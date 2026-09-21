#!/usr/bin/env python3
"""Offline integration tests with real Ninja, Clang PCH and ccache."""
import importlib.util
import os
from pathlib import Path
import shutil
import subprocess
import tempfile
import unittest
from unittest.mock import patch

spec = importlib.util.spec_from_file_location('build_cache', Path(__file__).parents[1] / 'build-cache.py')
helper = importlib.util.module_from_spec(spec)
spec.loader.exec_module(helper)


class BuildCacheTests(unittest.TestCase):
    def setUp(self):
        self.temporary = tempfile.TemporaryDirectory(prefix='ac-build-cache-test-')
        self.addCleanup(self.temporary.cleanup)
        self.root = Path(self.temporary.name)
        self.source = self.root / 'input'
        self.cache = self.root / 'cache'
        self.install = self.root / 'install'
        for name in ('conf', 'deps', 'modules', 'src/override', 'src/fallback'):
            (self.source / name).mkdir(parents=True)
        (self.source / 'CMakeLists.txt').write_text('''cmake_minimum_required(VERSION 3.16)
project(CacheFixture LANGUAGES CXX)
option(EXTRA "Test option default" OFF)
add_executable(probe src/main.cpp)
target_include_directories(probe PRIVATE src/override src/fallback)
target_compile_definitions(probe PRIVATE INCREMENT=$<BOOL:${EXTRA}>)
target_precompile_headers(probe PRIVATE src/pch.h)
install(TARGETS probe RUNTIME DESTINATION bin)
''')
        (self.source / 'src/main.cpp').write_text(
            '#include "value.h"\nint main() { std::cout << ANSWER + INCREMENT + 0; }\n')
        (self.source / 'src/pch.h').write_text('#include <iostream>\n')
        (self.source / 'src/fallback/value.h').write_text('#define ANSWER 1\n')
        self.options = ['-G', 'Ninja', '-DCMAKE_CXX_COMPILER=clang++',
                        '-DCMAKE_CXX_COMPILER_LAUNCHER=ccache',
                        '-DCMAKE_CXX_FLAGS=-Xclang -fno-pch-timestamp']
        self.environment = patch.dict(os.environ, {
            'CCACHE_CONFIGPATH': '/dev/null', 'CCACHE_DIR': str(self.root / 'ccache'),
            'CCACHE_SLOPPINESS': 'pch_defines,time_macros',
        })
        self.environment.start()
        self.addCleanup(self.environment.stop)

    def build(self):
        helper.build(self.source, self.cache, self.install, 2, self.options)
        return subprocess.check_output([self.install / 'bin/probe'], text=True)

    def marker(self):
        path = self.cache / 'binary/retained-marker'
        path.touch()
        return path

    def test_fresh_checkout_and_same_size_edit_with_old_mtime(self):
        self.assertEqual(self.build(), '1')
        obj = self.cache / 'binary/CMakeFiles/probe.dir/src/main.cpp.o'
        original_time = obj.stat().st_mtime_ns
        source = self.source / 'src/main.cpp'
        os.utime(source, (1, 1))
        self.assertEqual(self.build(), '1')
        self.assertEqual(obj.stat().st_mtime_ns, original_time)
        marker = self.marker()
        source.write_text(source.read_text().replace('+ 0', '+ 9'))
        os.utime(source, (1, 1))
        self.assertEqual(self.build(), '10')
        self.assertTrue(marker.exists())

    def test_added_and_removed_shadow_header(self):
        self.assertEqual(self.build(), '1')
        marker = self.marker()
        header = self.source / 'src/override/value.h'
        header.write_text('#define ANSWER 42\n')
        self.assertEqual(self.build(), '42')
        self.assertFalse(marker.exists())
        header.unlink()
        self.assertEqual(self.build(), '1')

    def test_option_and_default_changes(self):
        self.assertEqual(self.build(), '1')
        marker = self.marker()
        cmake = self.source / 'CMakeLists.txt'
        cmake.write_text(cmake.read_text().replace('default" OFF)', 'default" ON)'))
        self.assertEqual(self.build(), '2')
        self.assertFalse(marker.exists())
        self.options.append('-DEXTRA=OFF')
        self.assertEqual(self.build(), '1')

    def test_eviction_and_clean_install(self):
        self.assertEqual(self.build(), '1')
        obsolete = self.install / 'bin/obsolete'
        obsolete.touch()
        shutil.rmtree(self.cache / 'binary')
        self.assertEqual(self.build(), '1')
        self.assertFalse(obsolete.exists())
        shutil.rmtree(self.cache)
        self.assertEqual(self.build(), '1')

    def test_toolchain_change(self):
        self.assertEqual(self.build(), '1')
        marker = self.marker()
        with patch.object(helper, 'toolchain_identity', return_value={'changed': True}):
            self.assertEqual(self.build(), '1')
        self.assertFalse(marker.exists())

    def test_changed_pch_header(self):
        source = self.source / 'src/main.cpp'
        source.write_text(source.read_text().replace('+ 0', '+ BONUS'))
        header = self.source / 'src/pch.h'
        header.write_text('#include <iostream>\n#define BONUS 3\n')
        self.assertEqual(self.build(), '4')
        header.write_text('#include <iostream>\n#define BONUS 7\n')
        os.utime(header, (1, 1))
        self.assertEqual(self.build(), '8')

    def test_missing_signature(self):
        self.assertEqual(self.build(), '1')
        marker = self.marker()
        (self.cache / 'signature').unlink()
        self.assertEqual(self.build(), '1')
        self.assertFalse(marker.exists())

    def test_failed_build_recovery(self):
        self.assertEqual(self.build(), '1')
        source = self.source / 'src/main.cpp'
        valid = source.read_text()
        source.write_text('not valid C++\n')
        with self.assertRaises(subprocess.CalledProcessError):
            self.build()
        source.write_text(valid.replace('+ 0', '+ 9'))
        self.assertEqual(self.build(), '10')

    def test_symlink_target_change(self):
        (self.source / 'src/value1.h').write_text('#define ANSWER 11\n')
        (self.source / 'src/value2.h').write_text('#define ANSWER 22\n')
        link = self.source / 'src/override/value.h'
        link.symlink_to('../value1.h')
        self.assertEqual(self.build(), '11')
        marker = self.marker()
        link.unlink()
        link.symlink_to('../value2.h')
        self.assertEqual(self.build(), '22')
        self.assertFalse(marker.exists())


if __name__ == '__main__':
    unittest.main()

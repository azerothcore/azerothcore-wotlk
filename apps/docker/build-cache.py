#!/usr/bin/env python3
"""BuildKit-owned incremental workspace; installed artifacts stay outside the cache."""
import fcntl
import hashlib
import json
import os
from pathlib import Path
import shutil
import subprocess
import sys
import time


def digest(value):
    return hashlib.sha256(value).hexdigest()


def toolchain_identity():
    # Package versions include system headers/libraries, not just the compiler executable.
    return {
        'platform': os.uname().machine,
        'packages': digest(subprocess.check_output(['dpkg-query', '-W', '-f=${binary:Package}=${Version}\n'])),
        'versions': {name: subprocess.check_output([name, '--version'], text=True).splitlines()[0]
                     for name in ('clang', 'cmake', 'ninja', 'ccache')},
    }


def source_topology(source):
    entries = []
    for root, directories, files in os.walk(source):
        directories[:] = [name for name in directories if name != '.git']
        for name in directories + files:
            if name == '.git':
                continue
            path = Path(root) / name
            if path.is_symlink() or path.is_file():
                entries.append((str(path.relative_to(source)), str(path.readlink()) if path.is_symlink() else None))
    return sorted(entries)


def build(incoming, cache, install, jobs, options):
    cache.mkdir(parents=True, exist_ok=True)
    with (cache / 'lock').open('w') as lock:
        fcntl.flock(lock, fcntl.LOCK_EX)
        source, binary = cache / 'source', cache / 'binary'
        source.mkdir(exist_ok=True)
        # Deliberately omit -t: equal contents keep their mtime, changed contents get a new one.
        # Checksums handle fresh checkouts and equal-sized edits with preserved timestamps.
        subprocess.run(['rsync', '-rlpc', '--delete', '--exclude=.git',
                        *(str(incoming / name) for name in ('CMakeLists.txt', 'conf', 'deps', 'src', 'modules')),
                        str(source) + '/'], check=True)
        topology = source_topology(source)
        # CMake caches option defaults: reconfiguring alone does not pick up changed defaults.
        configuration = {name: digest((source / name).read_bytes()) for name, _ in topology
                         if Path(name).name == 'CMakeLists.txt' or name.endswith('.cmake')}
        identity = {'toolchain': toolchain_identity(), 'options': options, 'install': str(install),
                    'helper': digest(Path(__file__).read_bytes()), 'topology': topology,
                    'configuration': configuration}
        signature = digest(json.dumps(identity, sort_keys=True).encode())
        stamp = cache / 'signature'
        if not stamp.exists() or stamp.read_text() != signature:
            # In particular, adding a shadow header can invalidate Ninja's existing dependency graph.
            if binary.exists():
                shutil.rmtree(binary)
        # ccache direct-mode manifests also cannot detect a newly appearing shadow header.
        env = dict(os.environ, CCACHE_NAMESPACE=signature)
        timings = {}
        try:
            for phase, command in (
                ('configure', ['cmake', '-S', str(source), '-B', str(binary),
                               '-DCMAKE_INSTALL_PREFIX=' + str(install), *options]),
                ('build', ['cmake', '--build', str(binary), '--parallel', str(jobs)]),
                ('install', ['cmake', '--install', str(binary)]),
            ):
                if phase == 'install' and install.exists():
                    # Never ship an obsolete binary/library left by a removed target or module.
                    shutil.rmtree(install)
                start = time.monotonic()
                try:
                    subprocess.run(command, cwd=source, env=env, check=True)
                finally:
                    timings[phase + '_seconds'] = time.monotonic() - start
            stamp.write_text(signature)
        finally:
            print('BUILD_CACHE_TIMINGS ' + json.dumps(timings), flush=True)


if __name__ == '__main__':
    incoming, cache, install = (Path(value) for value in sys.argv[1:4])
    jobs = int(sys.argv[4]) if sys.argv[4] else len(os.sched_getaffinity(0)) + 1
    if jobs < 1:
        raise ValueError('BUILD_JOBS must be positive')
    build(incoming, cache, install, jobs, sys.argv[5:])

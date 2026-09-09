from conan import ConanFile
from conan.tools.cmake import CMakeToolchain

class StormLib(ConanFile):
    settings = "os", "compiler", "build_type", "arch"
    generators = "CMakeDeps"

    requires = (
        "zlib/1.3.1",
        "bzip2/1.0.8",
        "libtommath/1.3.0",
    )

    def generate(self):
        tc = CMakeToolchain(self)
        tc.user_presets_path = False
        tc.generate()
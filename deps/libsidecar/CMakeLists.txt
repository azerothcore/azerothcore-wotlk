#
# This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
#
# This file is free software; as a special exception the author gives
# unlimited permission to copy and/or distribute it, with or without
# modifications, as long as this notice is preserved.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY, to the extent permitted by law; without even the
# implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
#

# Use stub implementation only when the real libsidecar is disabled.
if (NOT USE_REAL_LIBSIDECAR)

    file(GLOB sources stub/*.c stub/*.h)

    add_library(libsidecar STATIC ${sources})

    set_target_properties(libsidecar
      PROPERTIES
        LINKER_LANGUAGE
          CXX
        INTERFACE_INCLUDE_DIRECTORIES
          ${CMAKE_CURRENT_SOURCE_DIR}/stub)

else()
    add_library(libsidecar SHARED IMPORTED GLOBAL)

    # Determine the correct library extension based on platform
    if(WIN32)
        set(LIBSIDECAR_EXTENSION "dll")
        set(LIBSIDECAR_IMPORT_LIB "libsidecar.lib")
    elseif(APPLE)
        set(LIBSIDECAR_EXTENSION "dylib")
    else()
        set(LIBSIDECAR_EXTENSION "so")
    endif()

    # Visible to worldserver CMake (rpath on UNIX; POST_BUILD copy on Windows).
    set(LIBSIDECAR_SHARED_FILE
        "${CMAKE_CURRENT_SOURCE_DIR}/libsidecar.${LIBSIDECAR_EXTENSION}"
        CACHE INTERNAL "Path to the real libsidecar shared library file")

    if (NOT EXISTS "${LIBSIDECAR_SHARED_FILE}")
        message(WARNING
            "USE_REAL_LIBSIDECAR is ON but ${LIBSIDECAR_SHARED_FILE} was not found. "
            "Place the matching shared library (and headers) from the same libsidecar "
            "build/release before linking or installing.")
    endif()

    if(WIN32)
        set_target_properties(libsidecar
          PROPERTIES
            IMPORTED_LOCATION
              ${LIBSIDECAR_SHARED_FILE}
            IMPORTED_IMPLIB
              ${CMAKE_CURRENT_SOURCE_DIR}/${LIBSIDECAR_IMPORT_LIB}
            INTERFACE_INCLUDE_DIRECTORIES
              ${CMAKE_CURRENT_SOURCE_DIR}/include)

        # worldserver installs to CMAKE_INSTALL_PREFIX root; DLL must sit next to it.
        # Build-tree runs: apps/CMakeLists.txt copies this DLL next to worldserver
        # (Windows has no rpath; the loader only searches the exe directory / PATH).
        install(FILES "${LIBSIDECAR_SHARED_FILE}"
            DESTINATION "${CMAKE_INSTALL_PREFIX}")
    else()
        set_target_properties(libsidecar
          PROPERTIES
            IMPORTED_LOCATION
              ${LIBSIDECAR_SHARED_FILE}
            INTERFACE_INCLUDE_DIRECTORIES
              ${CMAKE_CURRENT_SOURCE_DIR}/include
            IMPORTED_NO_SONAME
              true)

        # Source-tree dir for BUILD_RPATH only (dev runs from the build tree).
        # Do not put this path on INSTALL_RPATH — that would bake the build
        # machine's source tree into installed binaries.
        # Do not use INTERFACE_LINK_OPTIONS -rpath: game, scripts, and
        # worldserver all link libsidecar and would get duplicate -rpath warnings.
        set(LIBSIDECAR_RUNTIME_DIR "${CMAKE_CURRENT_SOURCE_DIR}" CACHE INTERNAL
            "Directory containing the real libsidecar shared library (build tree)")

        # Install next to the rest of the prefix libraries (worldserver → bin/,
        # so runtime rpath uses $ORIGIN/../lib and CMAKE_INSTALL_RPATH = prefix/lib).
        install(FILES "${LIBSIDECAR_SHARED_FILE}" DESTINATION lib)
    endif()

endif()

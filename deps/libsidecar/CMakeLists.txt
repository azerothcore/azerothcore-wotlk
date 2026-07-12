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

    if(WIN32)
        set_target_properties(libsidecar
          PROPERTIES
            IMPORTED_LOCATION
              ${CMAKE_CURRENT_SOURCE_DIR}/libsidecar.${LIBSIDECAR_EXTENSION}
            IMPORTED_IMPLIB
              ${CMAKE_CURRENT_SOURCE_DIR}/${LIBSIDECAR_IMPORT_LIB}
            INTERFACE_INCLUDE_DIRECTORIES
              ${CMAKE_CURRENT_SOURCE_DIR}/include)
    else()
        set_target_properties(libsidecar
          PROPERTIES
            IMPORTED_LOCATION
              ${CMAKE_CURRENT_SOURCE_DIR}/libsidecar.${LIBSIDECAR_EXTENSION}
            INTERFACE_INCLUDE_DIRECTORIES
              ${CMAKE_CURRENT_SOURCE_DIR}/include
            IMPORTED_NO_SONAME
              true)

        set_target_properties(libsidecar PROPERTIES
            IMPORTED_LOCATION_NOCONFIG
              "${CMAKE_INSTALL_RPATH}/libsidecar.${LIBSIDECAR_EXTENSION}"
            IMPORTED_SONAME_NOCONFIG
              "libsidecar.${LIBSIDECAR_EXTENSION}")
    endif()

endif()
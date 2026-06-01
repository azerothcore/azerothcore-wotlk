# /****************************************************************************
# **
# ** Copyright (C) 2015 Intel Corporation
# **
# ** Permission is hereby granted, free of charge, to any person obtaining a copy
# ** of this software and associated documentation files (the "Software"), to deal
# ** in the Software without restriction, including without limitation the rights
# ** to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# ** copies of the Software, and to permit persons to whom the Software is
# ** furnished to do so, subject to the following conditions:
# **
# ** The above copyright notice and this permission notice shall be included in
# ** all copies or substantial portions of the Software.
# **
# ** THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# ** IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# ** FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# ** AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# ** LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# ** OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# ** THE SOFTWARE.
# **
# ****************************************************************************/

cmake_minimum_required(VERSION 3.10)

project(tinycbor LANGUAGES C CXX VERSION 7.0)

# Set path to additional cmake scripts
set(CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR}/cmake ${CMAKE_MODULE_PATH})

set(TARGETS_EXPORT_NAME "TinyCBOR-targets")

option(WITH_FLOATING_POINT "Use floating point code in TinyCBOR" ON)
option(WITH_FREESTANDING "Compile TinyCBOR in C freestanding mode" OFF)
if(WITH_FLOATING_POINT AND NOT WITH_FREESTANDING)
  option(WITH_CBOR2JSON "Compile code to convert from CBOR to JSON" ON)
  option(BUILD_EXAMPLES "Compile the TinyCBOR examples" OFF)
  option(BUILD_TOOLS "Compile the TinyCBOR tools" ON)
endif()

# Include additional modules that are used unconditionally
include(GNUInstallDirs)
include(GenerateExportHeader)
include(CheckLinkerFlag)
include(CheckSymbolExists)

add_library(tinycbor
  src/cborencoder.c
  src/cborencoder_close_container_checked.c
  src/cborerrorstrings.c
  src/cborparser.c
  src/cborpretty.c
  src/cborvalidation.c
  src/cbor.h
)
if(WITH_FREESTANDING)
  target_compile_options(tinycbor PUBLIC
    $<$<NOT:$<CXX_COMPILER_ID:MSVC>>:-ffreestanding>
  )
else()
  target_sources(tinycbor PRIVATE
    src/cborparser_dup_string.c
    src/cborpretty_stdio.c
  )
  if(WITH_CBOR2JSON)
    target_sources(tinycbor PRIVATE
      src/cbortojson.c
    )
  endif()
endif()
if(WITH_FLOATING_POINT)
  target_sources(tinycbor PRIVATE
    src/cborencoder_float.c
    src/cborparser_float.c
  )
  if(NOT WIN32)
    target_link_libraries(tinycbor m)
  endif()
else()
  target_compile_definitions(tinycbor PUBLIC CBOR_NO_FLOATING_POINT)
endif()

set_target_properties(tinycbor PROPERTIES
  # Force this library to link as C and compile as C99, to ensure we
  # don't use something of a newer language level.
  LINKER_LANGUAGE C
  C_EXTENSIONS OFF
  C_STANDARD 99

  # Set version and output name
  VERSION "0.${PROJECT_VERSION}"
  SOVERSION "0"
)
if(BUILD_SHARED_LIBS)
  set_target_properties(tinycbor PROPERTIES C_VISIBILITY_PRESET hidden)

  # Check if the linker supports "-z defs" (a.k.a "--no-undefined")
  check_linker_flag(C "-Wl,-z,defs" HAVE_NO_UNDEFINED)
  if(HAVE_NO_UNDEFINED)
    target_link_options(tinycbor PRIVATE "-Wl,-z,defs")
  endif()
else()
  target_compile_definitions(tinycbor PUBLIC CBOR_STATIC_DEFINE)
endif()

# Enable warnings
target_compile_options(tinycbor PRIVATE
  $<$<CXX_COMPILER_ID:MSVC>:-W3>
  $<$<NOT:$<CXX_COMPILER_ID:MSVC>>:
    -Wall -Wextra
    -Werror=format-security
    -Werror=incompatible-pointer-types
    -Werror=implicit-function-declaration
    -Werror=int-conversion
  >
)

# Generate export macros
generate_export_header(tinycbor
  BASE_NAME "cbor"
  EXPORT_MACRO_NAME "CBOR_API"
  EXPORT_FILE_NAME "tinycbor-export.h"
)

# Generate version header
configure_file(src/tinycbor-version.h.in tinycbor-version.h)

# Generate pkgconfig file
configure_file(tinycbor.pc.in tinycbor.pc @ONLY)

# Check for open_memstream and store the result in HAVE_OPEN_MEMSTREAM
if(WITH_CBOR2JSON)
  check_symbol_exists(open_memstream stdio.h HAVE_OPEN_MEMSTREAM)
  check_symbol_exists(funopen stdio.h HAVE_OPEN_FUNOPEN)
  check_symbol_exists(fopencookie stdio.h HAVE_OPEN_FOPENCOOKIE)

  if(NOT HAVE_OPEN_MEMSTREAM)
    if (HAVE_OPEN_FUNOPEN)
      message(STATUS "implementing open_memstream using funopen()")
      target_compile_definitions(tinycbor PRIVATE HAVE_OPEN_FUNOPEN)
      target_sources(tinycbor PRIVATE src/open_memstream.c)
    elseif (HAVE_OPEN_FOPENCOOKIE)
      message(STATUS "implementing open_memstream using fopencookie()")
      target_compile_definitions(tinycbor PRIVATE HAVE_OPEN_FOPENCOOKIE)
      target_sources(tinycbor PRIVATE src/open_memstream.c)
    else()
      target_compile_definitions(tinycbor PRIVATE WITHOUT_OPEN_MEMSTREAM)
      message(WARNING "funopen and fopencookie unavailable, open_memstream can not be implemented and conversion to JSON will not work properly!")
    endif()
  endif()
endif()

target_include_directories(tinycbor
  PUBLIC "$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/src>"
  PUBLIC "$<BUILD_INTERFACE:${PROJECT_BINARY_DIR}>"
  PUBLIC "$<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>"
)

install(FILES
  ${PROJECT_SOURCE_DIR}/src/cbor.h
  ${PROJECT_BINARY_DIR}/tinycbor-version.h
  ${PROJECT_BINARY_DIR}/tinycbor-export.h
  DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/tinycbor
)
install(FILES
  ${CMAKE_BINARY_DIR}/tinycbor.pc
  DESTINATION ${CMAKE_INSTALL_LIBDIR}/pkgconfig
)
install(
  TARGETS tinycbor
  EXPORT "${TARGETS_EXPORT_NAME}"
  ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}   # import library
  LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}   # .so files are libraries
  RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}   # .dll files are binaries
  INCLUDES DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}  # this does not actually install anything (but used by downstream projects)
)

set(PROJECT_LIBRARIES TinyCBOR)
include(PackageConfig)

if(BUILD_EXAMPLES)
  add_subdirectory(examples)
endif()
if(BUILD_TESTING)
  enable_testing()
  add_subdirectory(tests)
endif()
if(BUILD_TOOLS)
  add_subdirectory(tools)
endif()

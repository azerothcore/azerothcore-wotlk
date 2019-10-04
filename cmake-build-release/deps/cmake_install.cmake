# Install script for directory: /home/cristian/Documents/AzerothCore/azerothcore/deps

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/usr/local")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "Release")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Install shared libraries without execute permission?
if(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)
  set(CMAKE_INSTALL_SO_NO_EXE "1")
endif()

# Is this installation the result of a crosscompile?
if(NOT DEFINED CMAKE_CROSSCOMPILING)
  set(CMAKE_CROSSCOMPILING "FALSE")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for each subdirectory.
  include("/home/cristian/Documents/AzerothCore/azerothcore/cmake-build-release/deps/threads/cmake_install.cmake")
  include("/home/cristian/Documents/AzerothCore/azerothcore/cmake-build-release/deps/acelite/cmake_install.cmake")
  include("/home/cristian/Documents/AzerothCore/azerothcore/cmake-build-release/deps/fmt/cmake_install.cmake")
  include("/home/cristian/Documents/AzerothCore/azerothcore/cmake-build-release/deps/zlib/cmake_install.cmake")
  include("/home/cristian/Documents/AzerothCore/azerothcore/cmake-build-release/deps/g3dlite/cmake_install.cmake")
  include("/home/cristian/Documents/AzerothCore/azerothcore/cmake-build-release/deps/recastnavigation/cmake_install.cmake")
  include("/home/cristian/Documents/AzerothCore/azerothcore/cmake-build-release/deps/SFMT/cmake_install.cmake")
  include("/home/cristian/Documents/AzerothCore/azerothcore/cmake-build-release/deps/utf8cpp/cmake_install.cmake")
  include("/home/cristian/Documents/AzerothCore/azerothcore/cmake-build-release/deps/openssl/cmake_install.cmake")
  include("/home/cristian/Documents/AzerothCore/azerothcore/cmake-build-release/deps/mysql/cmake_install.cmake")
  include("/home/cristian/Documents/AzerothCore/azerothcore/cmake-build-release/deps/readline/cmake_install.cmake")
  include("/home/cristian/Documents/AzerothCore/azerothcore/cmake-build-release/deps/jemalloc/cmake_install.cmake")
  include("/home/cristian/Documents/AzerothCore/azerothcore/cmake-build-release/deps/gsoap/cmake_install.cmake")

endif()


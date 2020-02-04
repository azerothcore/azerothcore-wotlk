# Minimum supported CMake version
cmake_minimum_required(VERSION 3.1 FATAL_ERROR)

# Project
project(asio_examples
  VERSION 1.11.0
  LANGUAGES CXX)

# Options
set(asio_BUILD_EXAMPLES_CPP11 ON CACHE BOOL "Build asio C++11 examples")
set(asio_BUILD_EXAMPLES_CPP14 ON CACHE BOOL "Build asio C++14 examples")

# Check asio targets
if(TARGET standalone)
  add_library(asio::standalone ALIAS standalone)
  set(asio_FOUND TRUE)
endif()

# Find asio package
if(NOT asio_FOUND)
  find_package(asio CONFIG REQUIRED)
endif()

# Installation configuration
include(GNUInstallDirs)

# C++11 examples
if(asio_BUILD_EXAMPLES_CPP11)
  add_subdirectory(cpp11)
endif()

# C++14 examples
if(asio_BUILD_EXAMPLES_CPP14)
  add_subdirectory(cpp14)
endif()
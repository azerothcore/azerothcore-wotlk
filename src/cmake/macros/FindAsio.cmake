# Copyright 2017 Bloomberg Finance L.P.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0

set(ASIO_FOUND FALSE)

if(TARGET ASIO::ASIO)
  set(ASIO_FOUND TRUE)
else()
  find_package(Threads QUIET)
  if(NOT Threads_FOUND)
    if(ASIO_FIND_REQUIRED)
      message(FATAL_ERROR "ASIO requires thread support, but it wasn't found.")
    else()
      if(ASIO_FIND_QUIETLY)
        message(STATUS "ASIO requires thread support, but it wasn't found.")
      endif()
    endif()
  else()
    find_path(ASIO_ROOT include/asio.hpp
      PATHS
        # Where asio lives relative to it's official repository
        ${CMAKE_CURRENT_LIST_DIR}/../../../asio/asio

        # Where asio should live
        ${CMAKE_CURRENT_LIST_DIR}/../../../asio
    )
    if(NOT ASIO_ROOT)
      if(ASIO_FIND_REQUIRED)
        message(FATAL_ERROR "ASIO headers could not be found.")
      else()
        if(ASIO_FIND_QUIETLY)
          message(STATUS "ASIO headers could not be found.")
        endif()
      endif()
    else()
      add_library(ASIO::ASIO INTERFACE IMPORTED GLOBAL)
      set_target_properties(ASIO::ASIO PROPERTIES
        INTERFACE_COMPILE_DEFINITIONS "ASIO_STANDALONE"
        INTERFACE_INCLUDE_DIRECTORIES "${ASIO_ROOT}/include"
      )
      target_link_libraries(ASIO::ASIO INTERFACE Threads::Threads)
      set(ASIO_FOUND TRUE)
    endif()
  endif()
endif()

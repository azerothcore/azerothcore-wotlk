# BSD-3-Clause
# Copyright (c) 2022, Rochet2 <rochet2@post.com>
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#
# * Redistributions of source code must retain the above copyright notice, this
#   list of conditions and the following disclaimer.
#
# * Redistributions in binary form must reproduce the above copyright notice,
#   this list of conditions and the following disclaimer in the documentation
#   and/or other materials provided with the distribution.
#
# * Neither the name of the copyright holder nor the names of its
#   contributors may be used to endorse or promote products derived from
#   this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
# FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
# DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
# SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
# CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
# OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
# OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

project ( lua C )

# Download source
include(FetchContent)
FetchContent_Declare(
  luajit21
  GIT_REPOSITORY https://github.com/LuaJIT/LuaJIT.git
  GIT_TAG        04dca7911ea255f37be799c18d74c305b921c1a6 # 2.1.0-beta3+ where mac builds without extra setup
)
FetchContent_MakeAvailable(luajit21)

set(LUA_SRC_FOLDER "${luajit21_SOURCE_DIR}")
set(LUA_BIN_FOLDER "${luajit21_BINARY_DIR}")
# note that the / at the end means that we copy folder contents, not the folder itself
file(COPY ${LUA_SRC_FOLDER}/ DESTINATION ${LUA_BIN_FOLDER})

if (WIN32)
  if (LUA_STATIC)
    # build luajit static
    add_custom_command(
      OUTPUT ${LUA_BIN_FOLDER}/src/lua51.lib ${LUA_BIN_FOLDER}/src/luajit.exe
      WORKING_DIRECTORY ${LUA_BIN_FOLDER}/src
      COMMAND call msvcbuild.bat static
    )

    # add it as a library target
    add_custom_target(luajit_target DEPENDS ${LUA_BIN_FOLDER}/src/lua51.lib)
    add_library(lualib STATIC IMPORTED GLOBAL)
    add_dependencies(lualib luajit_target)
    set_target_properties(lualib
    PROPERTIES
    IMPORTED_LOCATION ${LUA_BIN_FOLDER}/src/lua51.lib
    INTERFACE_INCLUDE_DIRECTORIES "${LUA_SRC_FOLDER}/src"
    )

    # install generated files
    install(FILES ${LUA_BIN_FOLDER}/src/lua51.lib ${LUA_BIN_FOLDER}/src/luajit.exe DESTINATION "${CMAKE_INSTALL_PREFIX}")
    install(DIRECTORY ${LUA_BIN_FOLDER}/src/jit DESTINATION "${CMAKE_INSTALL_PREFIX}/lua")
  else()
    # build luajit dll
    add_custom_command(
      OUTPUT ${LUA_BIN_FOLDER}/src/lua51.dll ${LUA_BIN_FOLDER}/src/lua51.lib ${LUA_BIN_FOLDER}/src/luajit.exe
      WORKING_DIRECTORY ${LUA_BIN_FOLDER}/src
      # COMMAND echo luajit built on platform $(Platform)
      # COMMAND cd $(VSInstallDir)/VC
      # COMMAND if \"$(Platform)\"==\"Win32\" echo \"luajit building $(Platform)\" & call $(VSInstallDir)/VC/vcvarsall.bat $(Platform) & call msvcbuild.bat
      # COMMAND if \"$(Platform)\"==\"Win32\" echo \"luajit building 64bit\" & call $(VSInstallDir)/VC/vcvarsall.bat x64
      # COMMAND if \"$(Platform)\"==\"Win64\" echo luajit building 64bit
      # COMMAND if \"$(Platform)\"==\"Win64\" call $(VSInstallDir)/VC/vcvarsall.bat x64
      # COMMAND cd ${LUA_BIN_FOLDER}/src
      COMMAND call msvcbuild.bat
      # COMMAND ${CMAKE_COMMAND} -E copy ${LUA_BIN_FOLDER}/src/lua51.dll ${CMAKE_BINARY_DIR}/$(ConfigurationName)/
      # COMMAND ${CMAKE_COMMAND} -E copy ${LUA_BIN_FOLDER}/src/lua51.lib ${CMAKE_BINARY_DIR}/$(ConfigurationName)/
      # COMMAND ${CMAKE_COMMAND} -E copy ${LUA_BIN_FOLDER}/src/luajit.exe ${CMAKE_BINARY_DIR}/$(ConfigurationName)/
    )

    # add it as a library target
    add_custom_target(luajit_target DEPENDS ${LUA_BIN_FOLDER}/src/lua51.lib)
    add_library(lualib SHARED IMPORTED GLOBAL)
    add_dependencies(lualib luajit_target)
    set_target_properties(lualib
    PROPERTIES
    IMPORTED_LOCATION ${LUA_BIN_FOLDER}/src/lua51.dll
    IMPORTED_IMPLIB ${LUA_BIN_FOLDER}/src/lua51.lib
    INTERFACE_INCLUDE_DIRECTORIES "${LUA_SRC_FOLDER}/src"
    )

    # install generated files
    install(FILES ${LUA_BIN_FOLDER}/src/lua51.dll ${LUA_BIN_FOLDER}/src/lua51.lib ${LUA_BIN_FOLDER}/src/luajit.exe DESTINATION "${CMAKE_INSTALL_PREFIX}")
    install(DIRECTORY ${LUA_BIN_FOLDER}/src/jit DESTINATION "${CMAKE_INSTALL_PREFIX}/lua")
  endif()
endif()

if (UNIX OR APPLE)
  #option(LUA_USR "Use /usr/local/ as lua library location" OFF)
  #if (LUA_USR)
  #  set(LUA_INSTALL_PATH "/usr/local")
  #else()
    set(LUA_INSTALL_PATH "${CMAKE_CURRENT_BINARY_DIR}/BIN")
  #endif()

  if (LUA_STATIC)
    set(LUAJIT_LIB_PATH "${LUA_INSTALL_PATH}/lib/libluajit-5.1.a")
  else()
    if (APPLE)
      set(LUAJIT_LIB_PATH "${LUA_INSTALL_PATH}/lib/libluajit-5.1.dylib")
    elseif(UNIX)
      set(LUAJIT_LIB_PATH "${LUA_INSTALL_PATH}/lib/libluajit-5.1.so")
    endif()
  endif()

  # build luajit
  # if (LUA_USR)
  #   add_custom_command(
  #     OUTPUT ${LUAJIT_LIB_PATH}
  #     COMMAND $(MAKE) -C ${LUA_BIN_FOLDER}
  #     COMMAND $(MAKE) -C ${LUA_BIN_FOLDER} install
  #   )
  # else ()
    add_custom_command(
      OUTPUT ${LUAJIT_LIB_PATH}
      # COMMAND $(MAKE) -C ${LUA_BIN_FOLDER} PREFIX=${LUA_INSTALL_PATH}
      COMMAND $(MAKE) -C ${LUA_BIN_FOLDER} install PREFIX=${LUA_INSTALL_PATH}
    )
  # endif()
  add_custom_target(luajit_target DEPENDS ${LUAJIT_LIB_PATH})

  # add it as a library target
  if (LUA_STATIC)
      add_library(lualib STATIC IMPORTED GLOBAL)
      # on static build the libraries are not a part of the luajit archive
      target_link_libraries(lualib INTERFACE ${CMAKE_DL_LIBS})
  else()
      add_library(lualib SHARED IMPORTED GLOBAL)
  endif()
  add_dependencies(lualib luajit_target)
  set_target_properties(lualib
  PROPERTIES
  # IMPORTED_LOCATION ${LUAJIT_LIB_PATH} # cmake bullshit. spent days figuring this and turns out set_target_properties does squat shit while set_property works fine.
  INTERFACE_INCLUDE_DIRECTORIES "${LUA_SRC_FOLDER}/src"
  )
  set_property(TARGET lualib PROPERTY IMPORTED_LOCATION ${LUAJIT_LIB_PATH})

  # install generated files
  install(DIRECTORY ${LUA_INSTALL_PATH}/ DESTINATION ${CMAKE_INSTALL_PREFIX})
endif()


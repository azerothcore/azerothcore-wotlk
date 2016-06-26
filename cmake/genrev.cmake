# Copyright (C) 
#
# This file is free software; as a special exception the author gives
# unlimited permission to copy and/or distribute it, with or without
# modifications, as long as this notice is preserved.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY, to the extent permitted by law; without even the
# implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

include(${CMAKE_SOURCE_DIR}/cmake/macros/EnsureVersion.cmake)

set(_REQUIRED_GIT_VERSION "1.7")

# Its not set during initial run
if(NOT BUILDDIR)
  set(BUILDDIR ${CMAKE_BINARY_DIR})
endif()

FIND_PROGRAM(SVN_EXECUTABLE svn DOC "subversion command line client")

# only do this if we have an svn client.
if (SVN_EXECUTABLE)
    MACRO(Subversion_GET_REVISION dir variable)
      EXECUTE_PROCESS(COMMAND ${SVN_EXECUTABLE} info ${dir}
        OUTPUT_VARIABLE ${variable}
        OUTPUT_STRIP_TRAILING_WHITESPACE)
      STRING(REGEX REPLACE "^(.*\n)?Revision: ([^\n]+).*"
        "\\2" ${variable} "${${variable}}")
    ENDMACRO(Subversion_GET_REVISION)

    Subversion_GET_REVISION(${CMAKE_SOURCE_DIR} REV2)
endif ()
  
  set(rev_hash_str ${REV2})
  set(rev_hash ${REV2})
  set(rev_id_str ${REV2})
  set(rev_id ${REV2})
  
  
  configure_file ( ${CMAKE_SOURCE_DIR}/revision.h.in.cmake ${BUILDDIR}/revision.h )

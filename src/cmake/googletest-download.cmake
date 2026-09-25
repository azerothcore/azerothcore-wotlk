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

# code copied from https://crascit.com/2015/07/25/cmake-gtest/
cmake_minimum_required(VERSION 3.5 FATAL_ERROR)

project(googletest-download NONE)

include(ExternalProject)

ExternalProject_Add(
        googletest
        SOURCE_DIR "@GOOGLETEST_DOWNLOAD_ROOT@/googletest-src"
        BINARY_DIR "@GOOGLETEST_DOWNLOAD_ROOT@/googletest-build"
        GIT_REPOSITORY
        https://github.com/google/googletest.git
        # Pinned to a main-branch commit rather than a tag: gtest-printers.h
        # converted char8_t/char16_t to char32_t implicitly, which clang-21
        # rejects under -Werror (-Wcharacter-conversion). Upstream fixed it in
        # fa8438ae, three weeks after v1.17.0 was cut, so no release carries it
        # yet. Move back to a tag once one ships that commit.
        GIT_TAG
        3940de91897160fea4815998e08d0fa3c2fb077e
        CONFIGURE_COMMAND ""
        BUILD_COMMAND ""
        INSTALL_COMMAND ""
        TEST_COMMAND ""
)

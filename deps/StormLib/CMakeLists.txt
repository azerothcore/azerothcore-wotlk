cmake_minimum_required(VERSION 3.25)
project(StormLib VERSION 9.30.0 LANGUAGES C CXX)

set(LIBRARY_NAME storm)
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

include(CMakeDependentOption)
include(GNUInstallDirs)

option(BUILD_SHARED_LIBS "Compile shared libraries" OFF)
option(STORM_SKIP_INSTALL "Skip installing files" OFF)
option(STORM_USE_BUNDLED_LIBRARIES
    "Force use of bundled dependencies instead of system libraries."
    OFF
)
cmake_dependent_option(WITH_BUNDLED_LIBTOMMATH
    "Bundle libtommath even when STORM_USE_BUNDLED_LIBRARIES is OFF."
    OFF "NOT STORM_USE_BUNDLED_LIBRARIES" ON
)
cmake_dependent_option(WITH_BUNDLED_LIBTOMCRYPT
    "Bundle libtomcrypt even when STORM_USE_BUNDLED_LIBRARIES is OFF."
    OFF "NOT STORM_USE_BUNDLED_LIBRARIES" ON
)
option(STORM_BUILD_TESTS
    "Compile StormLib test application" OFF
#   "BUILD_TESTING" OFF # Stay coherent with CTest variables
)

set(SRC_FILES
           src/adpcm/adpcm.cpp
           src/huffman/huff.cpp
           src/jenkins/lookup3.c
           src/lzma/C/LzFind.c
           src/lzma/C/LzmaDec.c
           src/lzma/C/LzmaEnc.c
           src/pklib/explode.c
           src/pklib/implode.c
           src/sparse/sparse.cpp
           src/FileStream.cpp
           src/SBaseCommon.cpp
           src/SBaseDumpData.cpp
           src/SBaseFileTable.cpp
           src/SBaseSubTypes.cpp
           src/SCompression.cpp
           src/SFileAddFile.cpp
           src/SFileAttributes.cpp
           src/SFileCompactArchive.cpp
           src/SFileCreateArchive.cpp
           src/SFileExtractFile.cpp
           src/SFileFindFile.cpp
           src/SFileGetFileInfo.cpp
           src/SFileListFile.cpp
           src/SFileOpenArchive.cpp
           src/SFileOpenFileEx.cpp
           src/SFilePatchArchives.cpp
           src/SFileReadFile.cpp
           src/SFileVerify.cpp
           src/SMemUtf8.cpp
           src/libtomcrypt/src/pk/rsa/rsa_verify_simple.c
           src/libtomcrypt/src/misc/crypt_libc.c
)

if(MSVC)
    # This file is used to create a DLL on windows
    # Use BUILD_SHARED_LIBS to create StormLib.dll
    set(STORM_DEF_FILES
           src/DllMain.def
    )
endif()

set(TOMCRYPT_FILES
           src/libtomcrypt/src/hashes/hash_memory.c
           src/libtomcrypt/src/hashes/md5.c
           src/libtomcrypt/src/hashes/sha1.c
           src/libtomcrypt/src/hashes/sha256.c
           src/libtomcrypt/src/math/ltm_desc.c
           src/libtomcrypt/src/math/multi.c
           src/libtomcrypt/src/math/rand_prime.c
           src/libtomcrypt/src/misc/base64_decode.c
           src/libtomcrypt/src/misc/crypt_argchk.c
           src/libtomcrypt/src/misc/crypt_find_hash.c
           src/libtomcrypt/src/misc/crypt_find_prng.c
           src/libtomcrypt/src/misc/crypt_hash_descriptor.c
           src/libtomcrypt/src/misc/crypt_hash_is_valid.c
           src/libtomcrypt/src/misc/crypt_ltc_mp_descriptor.c
           src/libtomcrypt/src/misc/crypt_prng_descriptor.c
           src/libtomcrypt/src/misc/crypt_prng_is_valid.c
           src/libtomcrypt/src/misc/crypt_register_hash.c
           src/libtomcrypt/src/misc/crypt_register_prng.c
           src/libtomcrypt/src/misc/zeromem.c
           src/libtomcrypt/src/pk/asn1/der_decode_bit_string.c
           src/libtomcrypt/src/pk/asn1/der_decode_boolean.c
           src/libtomcrypt/src/pk/asn1/der_decode_choice.c
           src/libtomcrypt/src/pk/asn1/der_decode_ia5_string.c
           src/libtomcrypt/src/pk/asn1/der_decode_integer.c
           src/libtomcrypt/src/pk/asn1/der_decode_object_identifier.c
           src/libtomcrypt/src/pk/asn1/der_decode_octet_string.c
           src/libtomcrypt/src/pk/asn1/der_decode_printable_string.c
           src/libtomcrypt/src/pk/asn1/der_decode_sequence_ex.c
           src/libtomcrypt/src/pk/asn1/der_decode_sequence_flexi.c
           src/libtomcrypt/src/pk/asn1/der_decode_sequence_multi.c
           src/libtomcrypt/src/pk/asn1/der_decode_short_integer.c
           src/libtomcrypt/src/pk/asn1/der_decode_utctime.c
           src/libtomcrypt/src/pk/asn1/der_decode_utf8_string.c
           src/libtomcrypt/src/pk/asn1/der_encode_bit_string.c
           src/libtomcrypt/src/pk/asn1/der_encode_boolean.c
           src/libtomcrypt/src/pk/asn1/der_encode_ia5_string.c
           src/libtomcrypt/src/pk/asn1/der_encode_integer.c
           src/libtomcrypt/src/pk/asn1/der_encode_object_identifier.c
           src/libtomcrypt/src/pk/asn1/der_encode_octet_string.c
           src/libtomcrypt/src/pk/asn1/der_encode_printable_string.c
           src/libtomcrypt/src/pk/asn1/der_encode_sequence_ex.c
           src/libtomcrypt/src/pk/asn1/der_encode_sequence_multi.c
           src/libtomcrypt/src/pk/asn1/der_encode_set.c
           src/libtomcrypt/src/pk/asn1/der_encode_setof.c
           src/libtomcrypt/src/pk/asn1/der_encode_short_integer.c
           src/libtomcrypt/src/pk/asn1/der_encode_utctime.c
           src/libtomcrypt/src/pk/asn1/der_encode_utf8_string.c
           src/libtomcrypt/src/pk/asn1/der_length_bit_string.c
           src/libtomcrypt/src/pk/asn1/der_length_boolean.c
           src/libtomcrypt/src/pk/asn1/der_length_ia5_string.c
           src/libtomcrypt/src/pk/asn1/der_length_integer.c
           src/libtomcrypt/src/pk/asn1/der_length_object_identifier.c
           src/libtomcrypt/src/pk/asn1/der_length_octet_string.c
           src/libtomcrypt/src/pk/asn1/der_length_printable_string.c
           src/libtomcrypt/src/pk/asn1/der_length_sequence.c
           src/libtomcrypt/src/pk/asn1/der_length_utctime.c
           src/libtomcrypt/src/pk/asn1/der_sequence_free.c
           src/libtomcrypt/src/pk/asn1/der_length_utf8_string.c
           src/libtomcrypt/src/pk/asn1/der_length_short_integer.c
           src/libtomcrypt/src/pk/ecc/ltc_ecc_map.c
           src/libtomcrypt/src/pk/ecc/ltc_ecc_mul2add.c
           src/libtomcrypt/src/pk/ecc/ltc_ecc_mulmod.c
           src/libtomcrypt/src/pk/ecc/ltc_ecc_points.c
           src/libtomcrypt/src/pk/ecc/ltc_ecc_projective_add_point.c
           src/libtomcrypt/src/pk/ecc/ltc_ecc_projective_dbl_point.c
           src/libtomcrypt/src/pk/pkcs1/pkcs_1_mgf1.c
           src/libtomcrypt/src/pk/pkcs1/pkcs_1_oaep_decode.c
           src/libtomcrypt/src/pk/pkcs1/pkcs_1_pss_decode.c
           src/libtomcrypt/src/pk/pkcs1/pkcs_1_pss_encode.c
           src/libtomcrypt/src/pk/pkcs1/pkcs_1_v1_5_decode.c
           src/libtomcrypt/src/pk/pkcs1/pkcs_1_v1_5_encode.c
           src/libtomcrypt/src/pk/rsa/rsa_exptmod.c
           src/libtomcrypt/src/pk/rsa/rsa_free.c
           src/libtomcrypt/src/pk/rsa/rsa_import.c
           src/libtomcrypt/src/pk/rsa/rsa_make_key.c
           src/libtomcrypt/src/pk/rsa/rsa_sign_hash.c
           src/libtomcrypt/src/pk/rsa/rsa_verify_hash.c
)

set(TOMMATH_FILES
           src/libtommath/bncore.c
           src/libtommath/bn_fast_mp_invmod.c
           src/libtommath/bn_fast_mp_montgomery_reduce.c
           src/libtommath/bn_fast_s_mp_mul_digs.c
           src/libtommath/bn_fast_s_mp_mul_high_digs.c
           src/libtommath/bn_fast_s_mp_sqr.c
           src/libtommath/bn_mp_2expt.c
           src/libtommath/bn_mp_abs.c
           src/libtommath/bn_mp_add.c
           src/libtommath/bn_mp_addmod.c
           src/libtommath/bn_mp_add_d.c
           src/libtommath/bn_mp_and.c
           src/libtommath/bn_mp_clamp.c
           src/libtommath/bn_mp_clear.c
           src/libtommath/bn_mp_clear_multi.c
           src/libtommath/bn_mp_cmp.c
           src/libtommath/bn_mp_cmp_d.c
           src/libtommath/bn_mp_cmp_mag.c
           src/libtommath/bn_mp_cnt_lsb.c
           src/libtommath/bn_mp_copy.c
           src/libtommath/bn_mp_count_bits.c
           src/libtommath/bn_mp_div.c
           src/libtommath/bn_mp_div_2.c
           src/libtommath/bn_mp_div_2d.c
           src/libtommath/bn_mp_div_3.c
           src/libtommath/bn_mp_div_d.c
           src/libtommath/bn_mp_dr_is_modulus.c
           src/libtommath/bn_mp_dr_reduce.c
           src/libtommath/bn_mp_dr_setup.c
           src/libtommath/bn_mp_exch.c
           src/libtommath/bn_mp_exptmod.c
           src/libtommath/bn_mp_exptmod_fast.c
           src/libtommath/bn_mp_expt_d.c
           src/libtommath/bn_mp_exteuclid.c
           src/libtommath/bn_mp_fread.c
           src/libtommath/bn_mp_fwrite.c
           src/libtommath/bn_mp_gcd.c
           src/libtommath/bn_mp_get_int.c
           src/libtommath/bn_mp_grow.c
           src/libtommath/bn_mp_init.c
           src/libtommath/bn_mp_init_copy.c
           src/libtommath/bn_mp_init_multi.c
           src/libtommath/bn_mp_init_set.c
           src/libtommath/bn_mp_init_set_int.c
           src/libtommath/bn_mp_init_size.c
           src/libtommath/bn_mp_invmod.c
           src/libtommath/bn_mp_invmod_slow.c
           src/libtommath/bn_mp_is_square.c
           src/libtommath/bn_mp_jacobi.c
           src/libtommath/bn_mp_karatsuba_mul.c
           src/libtommath/bn_mp_karatsuba_sqr.c
           src/libtommath/bn_mp_lcm.c
           src/libtommath/bn_mp_lshd.c
           src/libtommath/bn_mp_mod.c
           src/libtommath/bn_mp_mod_2d.c
           src/libtommath/bn_mp_mod_d.c
           src/libtommath/bn_mp_montgomery_calc_normalization.c
           src/libtommath/bn_mp_montgomery_reduce.c
           src/libtommath/bn_mp_montgomery_setup.c
           src/libtommath/bn_mp_mul.c
           src/libtommath/bn_mp_mulmod.c
           src/libtommath/bn_mp_mul_2.c
           src/libtommath/bn_mp_mul_2d.c
           src/libtommath/bn_mp_mul_d.c
           src/libtommath/bn_mp_neg.c
           src/libtommath/bn_mp_n_root.c
           src/libtommath/bn_mp_or.c
           src/libtommath/bn_mp_prime_fermat.c
           src/libtommath/bn_mp_prime_is_divisible.c
           src/libtommath/bn_mp_prime_is_prime.c
           src/libtommath/bn_mp_prime_miller_rabin.c
           src/libtommath/bn_mp_prime_next_prime.c
           src/libtommath/bn_mp_prime_rabin_miller_trials.c
           src/libtommath/bn_mp_prime_random_ex.c
           src/libtommath/bn_mp_radix_size.c
           src/libtommath/bn_mp_radix_smap.c
           src/libtommath/bn_mp_rand.c
           src/libtommath/bn_mp_read_radix.c
           src/libtommath/bn_mp_read_signed_bin.c
           src/libtommath/bn_mp_read_unsigned_bin.c
           src/libtommath/bn_mp_reduce.c
           src/libtommath/bn_mp_reduce_2k.c
           src/libtommath/bn_mp_reduce_2k_l.c
           src/libtommath/bn_mp_reduce_2k_setup.c
           src/libtommath/bn_mp_reduce_2k_setup_l.c
           src/libtommath/bn_mp_reduce_is_2k.c
           src/libtommath/bn_mp_reduce_is_2k_l.c
           src/libtommath/bn_mp_reduce_setup.c
           src/libtommath/bn_mp_rshd.c
           src/libtommath/bn_mp_set.c
           src/libtommath/bn_mp_set_int.c
           src/libtommath/bn_mp_shrink.c
           src/libtommath/bn_mp_signed_bin_size.c
           src/libtommath/bn_mp_sqr.c
           src/libtommath/bn_mp_sqrmod.c
           src/libtommath/bn_mp_sqrt.c
           src/libtommath/bn_mp_sub.c
           src/libtommath/bn_mp_submod.c
           src/libtommath/bn_mp_sub_d.c
           src/libtommath/bn_mp_toom_mul.c
           src/libtommath/bn_mp_toom_sqr.c
           src/libtommath/bn_mp_toradix.c
           src/libtommath/bn_mp_toradix_n.c
           src/libtommath/bn_mp_to_signed_bin.c
           src/libtommath/bn_mp_to_signed_bin_n.c
           src/libtommath/bn_mp_to_unsigned_bin.c
           src/libtommath/bn_mp_to_unsigned_bin_n.c
           src/libtommath/bn_mp_unsigned_bin_size.c
           src/libtommath/bn_mp_xor.c
           src/libtommath/bn_mp_zero.c
           src/libtommath/bn_prime_tab.c
           src/libtommath/bn_reverse.c
           src/libtommath/bn_s_mp_add.c
           src/libtommath/bn_s_mp_exptmod.c
           src/libtommath/bn_s_mp_mul_digs.c
           src/libtommath/bn_s_mp_mul_high_digs.c
           src/libtommath/bn_s_mp_sqr.c
           src/libtommath/bn_s_mp_sub.c
)

set(BZIP2_FILES
           src/bzip2/blocksort.c
           src/bzip2/bzlib.c
           src/bzip2/compress.c
           src/bzip2/crctable.c
           src/bzip2/decompress.c
           src/bzip2/huffman.c
           src/bzip2/randtable.c
)

set(ZLIB_FILES
           src/zlib/adler32.c
           src/zlib/compress.c
           src/zlib/crc32.c
           src/zlib/deflate.c
           src/zlib/inffast.c
           src/zlib/inflate.c
           src/zlib/inftrees.c
           src/zlib/trees.c
           src/zlib/zutil.c
)

add_library(${LIBRARY_NAME})

target_compile_definitions(${LIBRARY_NAME} PRIVATE _7ZIP_ST BZ_STRICT_ANSI)

if (NOT STORM_USE_BUNDLED_LIBRARIES)
    find_package(ZLIB REQUIRED)
    target_link_libraries(${LIBRARY_NAME} PRIVATE ZLIB::ZLIB)
    target_compile_definitions(${LIBRARY_NAME} PRIVATE __SYS_ZLIB)
else()
    set(SRC_FILES ${SRC_FILES} ${ZLIB_FILES})
endif()

if (NOT STORM_USE_BUNDLED_LIBRARIES)
    find_package(BZip2 REQUIRED)
    target_link_libraries(${LIBRARY_NAME} PRIVATE BZip2::BZip2)
    target_compile_definitions(${LIBRARY_NAME} PRIVATE __SYS_BZLIB)
else()
    set(SRC_FILES ${SRC_FILES} ${BZIP2_FILES})
endif()

if (NOT WITH_BUNDLED_LIBTOMMATH)
    find_package(libtommath QUIET)
    if (TARGET libtommath::libtommath)
        message(STATUS "Found libtommath: using target libtommath::libtommath")
        target_link_libraries(${LIBRARY_NAME} PRIVATE libtommath::libtommath)
    elseif (TARGET libtommath)
        message(STATUS "Found libtommath: using target libtommath")
        target_link_libraries(${LIBRARY_NAME} PRIVATE libtommath)
    else()
        find_package(PkgConfig REQUIRED)
        pkg_check_modules(libtommath REQUIRED IMPORTED_TARGET libtommath)
        message(STATUS "Found libtommath via pkg-config")
        target_link_libraries(${LIBRARY_NAME} PRIVATE PkgConfig::libtommath)
    endif()
else()
    message(STATUS "Using bundled libtommath sources")
    set(SRC_ADDITIONAL_FILES ${SRC_ADDITIONAL_FILES} ${TOMMATH_FILES})
endif()

if (NOT WITH_BUNDLED_LIBTOMCRYPT)
    find_package(libtomcrypt QUIET)
    if (TARGET libtomcrypt::libtomcrypt)
        message(STATUS "Found libtomcrypt: using target libtomcrypt::libtomcrypt")
        target_link_libraries(${LIBRARY_NAME} PRIVATE libtomcrypt::libtomcrypt)
    elseif (TARGET libtomcrypt)
        message(STATUS "Found libtomcrypt: using target libtomcrypt")
        target_link_libraries(${LIBRARY_NAME} PRIVATE libtomcrypt)
    else()
        find_package(PkgConfig REQUIRED)
        pkg_check_modules(libtomcrypt REQUIRED IMPORTED_TARGET libtomcrypt)
        message(STATUS "Found libtomcrypt via pkg-config")
        target_link_libraries(${LIBRARY_NAME} PRIVATE PkgConfig::libtomcrypt)
    endif()
    # Use the system's own tomcrypt.h instead of the bundled (vendored) copy,
    # since the two can disagree on struct layouts (e.g. ltc_math_descriptor)
    # across libtomcrypt versions, which is ABI-incompatible with the system .so.
    target_compile_definitions(${LIBRARY_NAME} PRIVATE __SYS_LIBTOMCRYPT)
else()
    message(STATUS "Using bundled libtomcrypt sources")
    set(SRC_ADDITIONAL_FILES ${SRC_ADDITIONAL_FILES} ${TOMCRYPT_FILES})
endif()

if(WIN32)
    target_link_libraries(${LIBRARY_NAME} PRIVATE wininet)
endif()

target_sources(${LIBRARY_NAME} PRIVATE ${SRC_FILES} ${SRC_ADDITIONAL_FILES} ${STORM_DEF_FILES})
if(WIN32)
    set_target_properties(${LIBRARY_NAME} PROPERTIES OUTPUT_NAME "StormLib")
endif()

option(STORM_UNICODE "Compile UNICODE version instead of ANSI one (Visual Studio only)" OFF)

if(WIN32)
    if(STORM_UNICODE)
        message(STATUS "Build UNICODE version")
        target_compile_definitions(${LIBRARY_NAME} PRIVATE UNICODE _UNICODE)
    else()
        message(STATUS "Build ANSI version")
    endif()
endif()

add_library(${PROJECT_NAME}::${LIBRARY_NAME} ALIAS ${LIBRARY_NAME}) # Allow users to link StormLib::storm when using add_subdirectory
target_compile_definitions(${LIBRARY_NAME} INTERFACE __STORMLIB_NO_STATIC_LINK__) #CMake will take care of the linking
target_include_directories(${LIBRARY_NAME} PUBLIC $<BUILD_INTERFACE:${CMAKE_CURRENT_LIST_DIR}/src>)
set_target_properties(${LIBRARY_NAME} PROPERTIES PUBLIC_HEADER "src/StormLib.h;src/StormPort.h")
if(BUILD_SHARED_LIBS)
    message(STATUS "Linking against dependent libraries dynamically")

    if(APPLE)
        set_target_properties(${LIBRARY_NAME} PROPERTIES FRAMEWORK TRUE)
        target_link_options(${LIBRARY_NAME} PRIVATE "-framework Carbon")
    endif()
    if(UNIX)
        set_target_properties(${LIBRARY_NAME} PROPERTIES
            VERSION "${PROJECT_VERSION}"
            SOVERSION "${PROJECT_VERSION_MAJOR}"
        )
    endif()
    if(WIN32)
        target_sources(${LIBRARY_NAME}
            PRIVATE
                src/DllMain.rc
        )
    endif()
else()
    message(STATUS "Linking against dependent libraries statically")
endif()

if (NOT STORM_SKIP_INSTALL)
    install(TARGETS ${LIBRARY_NAME}
        EXPORT ${PROJECT_NAME}Config
        RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
        LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
        ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
        FRAMEWORK DESTINATION /Library/Frameworks
        PUBLIC_HEADER DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
        INCLUDES DESTINATION ${CMAKE_INSTALL_INCLUDEDIR})

        install(EXPORT ${PROJECT_NAME}Config NAMESPACE ${PROJECT_NAME}:: DESTINATION ${CMAKE_INSTALL_DATAROOTDIR}/${PROJECT_NAME})

        #CPack configuration
        set(CPACK_GENERATOR "DEB" "RPM")
        set(CPACK_PACKAGE_NAME ${PROJECT_NAME})
        set(CPACK_PACKAGE_DESCRIPTION_SUMMARY "MPQ manipulation library")
        set(CPACK_PACKAGE_VENDOR "Ladislav Zezula")
        set(CPACK_PACKAGE_DESCRIPTION_FILE "${CMAKE_CURRENT_SOURCE_DIR}/README.md")
        set(CPACK_RESOURCE_FILE_LICENSE "${CMAKE_CURRENT_SOURCE_DIR}/LICENSE")
        set(CPACK_PACKAGE_VERSION_MAJOR "${PROJECT_VERSION_MAJOR}")
        set(CPACK_PACKAGE_VERSION_MINOR "${PROJECT_VERSION_MINOR}")
        set(CPACK_PACKAGE_VERSION "${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}")
        set(CPACK_PACKAGING_INSTALL_PREFIX "/usr/local")

        #DEB configuration
        set(CPACK_DEBIAN_PACKAGE_EPOCH 1)
        set(CPACK_DEBIAN_PACKAGE_SECTION "libs")
        set(CPACK_DEBIAN_PACKAGE_HOMEPAGE "http://www.zezula.net/en/mpq/stormlib.html")
        set(CPACK_DEBIAN_PACKAGE_MAINTAINER "imbacen@gmail.com")
        set(CPACK_DEBIAN_PACKAGE_DEPENDS "zlib1g,bzip2")

        #RPM configuration
        set(CPACK_RPM_PACKAGE_EPOCH 1)
        set(CPACK_RPM_PACKAGE_RELEASE 1)
        set(CPACK_RPM_PACKAGE_LICENSE "${CMAKE_CURRENT_SOURCE_DIR}/LICENSE")
        set(CPACK_RPM_PACKAGE_GROUP "${PROJECT_NAME}")
        set(CPACK_RPM_PACKAGE_URL "http://www.zezula.net/en/mpq/stormlib.html")
        set(CPACK_RPM_PACKAGE_REQUIRES "zlib,bzip2")

        include(CPack)
endif()

if(STORM_BUILD_TESTS)
    enable_testing()
    add_subdirectory(test)
endif()


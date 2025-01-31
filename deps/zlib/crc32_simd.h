//https://cs.chromium.org/chromium/src/third_party/zlib/crc32_simd.c
/* crc32_simd.h
 *
 * Copyright 2017 The Chromium Authors. All rights reserved.
 * Use of this source code is governed by a BSD-style license that can be
 * found in the Chromium source repository LICENSE file.
 */
#ifndef CRC32_SIMD_H 
#define  CRC32_SIMD_H


#include <stdint.h>

//#include "zconf.h"
//#include "zutil.h"
#include "deflate.h"

//#ifndef local
// #define local static
//#endif

//#ifndef z_crc_t
//	#ifdef Z_U4
//		typedef Z_U4 z_crc_t;
//	 #else
//		typedef unsigned long z_crc_t;
//	#endif
//#endif 
#ifdef HAS_PCLMUL
 #define CRC32_SIMD_SSE42_PCLMUL
#endif

#ifndef z_size_t
	#define z_size_t size_t
#endif
#ifndef zalign
	#ifdef _MSC_VER
	#define zalign(x) __declspec(align(x))
	#else
	#define zalign(x) __attribute__((aligned((x))))
	#endif
#endif



/*
 * crc32_sse42_simd_(): compute the crc32 of the buffer, where the buffer
 * length must be at least 64, and a multiple of 16.
 */
uint32_t ZLIB_INTERNAL crc32_sse42_simd_(
    const unsigned char *buf,
    z_size_t len,
    uint32_t crc);

/*
 * crc32_sse42_simd_ buffer size constraints: see the use in zlib/crc32.c
 * for computing the crc32 of an arbitrary length buffer.
 */
#define Z_CRC32_SSE42_MINIMUM_LENGTH 64
#define Z_CRC32_SSE42_CHUNKSIZE_MASK 15

/*
 * CRC32 checksums using ARMv8-a crypto instructions.
 */
uint32_t ZLIB_INTERNAL armv8_crc32_little(unsigned long crc,
                                          const unsigned char* buf,
                                          z_size_t len);

#endif /* CRC32_SIMD_H */
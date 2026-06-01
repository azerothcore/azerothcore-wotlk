/****************************************************************************
**
** Copyright (C) 2017 Intel Corporation
**
** Permission is hereby granted, free of charge, to any person obtaining a copy
** of this software and associated documentation files (the "Software"), to deal
** in the Software without restriction, including without limitation the rights
** to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
** copies of the Software, and to permit persons to whom the Software is
** furnished to do so, subject to the following conditions:
**
** The above copyright notice and this permission notice shall be included in
** all copies or substantial portions of the Software.
**
** THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
** IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
** FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
** AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
** LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
** OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
** THE SOFTWARE.
**
****************************************************************************/

#ifndef COMPILERSUPPORT_H
#define COMPILERSUPPORT_H

#include "cbor.h"

#ifndef _BSD_SOURCE
#  define _BSD_SOURCE
#endif
#ifndef _DEFAULT_SOURCE
#  define _DEFAULT_SOURCE
#endif
#ifndef assert
#  include <assert.h>
#endif
#include <stddef.h>
#include <stdint.h>
#include <string.h>

#ifndef __cplusplus
#  include <stdbool.h>
#endif

#if (defined(__STDC_VERSION__) && __STDC_VERSION__ >= 201112L) || (defined(__cplusplus) && __cplusplus >= 201103L) || (defined(__cpp_static_assert) && __cpp_static_assert >= 200410)
#  define cbor_static_assert(x)         static_assert(x, #x)
#elif !defined(__cplusplus) && defined(__GNUC__) && (__GNUC__ * 100 + __GNUC_MINOR__ >= 406) && (__STDC_VERSION__ > 199901L)
#  define cbor_static_assert(x)         _Static_assert(x, #x)
#else
#  define cbor_static_assert(x)         ((void)sizeof(char[2*!!(x) - 1]))
#endif

#if defined(__has_cpp_attribute)    // C23 and C++17
#  if __has_cpp_attribute(fallthrough)
#    define CBOR_FALLTHROUGH            [[fallthrough]]
#  endif
#endif
#ifndef CBOR_FALLTHROUGH
#  ifdef __GNUC__
#    define CBOR_FALLTHROUGH            __attribute__((fallthrough))
#  else
#    define CBOR_FALLTHROUGH            do { } while (0)
#  endif
#endif

#if (defined(__STDC_VERSION__) && __STDC_VERSION__ >= 199901L) || defined(__cplusplus)
/* inline is a keyword */
#else
/* use the definition from cbor.h */
#  define inline    CBOR_INLINE
#endif

#ifdef NDEBUG
#  define cbor_assert(cond)     do { if (!(cond)) unreachable(); } while (0)
#else
#  define cbor_assert(cond)     assert(cond)
#endif

#ifndef STRINGIFY
#define STRINGIFY(x)            STRINGIFY2(x)
#endif
#define STRINGIFY2(x)           #x

#if !defined(UINT32_MAX) || !defined(INT64_MAX)
/* C89? We can define UINT32_MAX portably, but not INT64_MAX */
#  error "Your system has stdint.h but that doesn't define UINT32_MAX or INT64_MAX"
#endif

#ifndef DBL_DECIMAL_DIG
/* DBL_DECIMAL_DIG is C11 */
#  define DBL_DECIMAL_DIG       17
#endif
#define DBL_DECIMAL_DIG_STR     STRINGIFY(DBL_DECIMAL_DIG)

#if defined(__GNUC__) && defined(__i386__) && !defined(__iamcu__)
#  define CBOR_INTERNAL_API_CC          __attribute__((regparm(3)))
#elif defined(_MSC_VER) && defined(_M_IX86)
#  define CBOR_INTERNAL_API_CC          __fastcall
#else
#  define CBOR_INTERNAL_API_CC
#endif

#ifndef __has_builtin
#  define __has_builtin(x)  0
#endif

#if (defined(__GNUC__) && (__GNUC__ * 100 + __GNUC_MINOR__ >= 403)) || \
    (__has_builtin(__builtin_bswap64) && __has_builtin(__builtin_bswap32))
#  if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
#    define cbor_ntohll     __builtin_bswap64
#    define cbor_htonll     __builtin_bswap64
#    define cbor_ntohl      __builtin_bswap32
#    define cbor_htonl      __builtin_bswap32
#    ifdef __INTEL_COMPILER
#      define cbor_ntohs    _bswap16
#      define cbor_htons    _bswap16
#    elif (__GNUC__ * 100 + __GNUC_MINOR__ >= 608) || __has_builtin(__builtin_bswap16)
#      define cbor_ntohs    __builtin_bswap16
#      define cbor_htons    __builtin_bswap16
#    else
#      define cbor_ntohs(x) (((uint16_t)(x) >> 8) | ((uint16_t)(x) << 8))
#      define cbor_htons    cbor_ntohs
#    endif
#  else
#    define cbor_ntohll
#    define cbor_htonll
#    define cbor_ntohl
#    define cbor_htonl
#    define cbor_ntohs
#    define cbor_htons
#  endif
#elif defined(__sun)
#  include <sys/byteorder.h>
#elif defined(_MSC_VER)
/* MSVC, which implies Windows, which implies little-endian and sizeof(long) == 4 */
#  include <stdlib.h>
#  define cbor_ntohll       _byteswap_uint64
#  define cbor_htonll       _byteswap_uint64
#  define cbor_ntohl        _byteswap_ulong
#  define cbor_htonl        _byteswap_ulong
#  define cbor_ntohs        _byteswap_ushort
#  define cbor_htons        _byteswap_ushort
#elif defined(__ICCARM__)
#  if __LITTLE_ENDIAN__ == 1
#    include <intrinsics.h>
#    define ntohll(x)       ((__REV((uint32_t)(x)) * UINT64_C(0x100000000)) + (__REV((x) >> 32)))
#    define htonll          ntohll
#    define cbor_ntohl     __REV
#    define cbor_htonl     __REV
#    define cbor_ntohs     __REVSH
#    define cbor_htons     __REVSH
#  else
#    define cbor_ntohll
#    define cbor_htonll
#    define cbor_ntohl
#    define cbor_htonl
#    define cbor_ntohs
#    define cbor_htons
#  endif
#endif
#ifndef cbor_ntohs
#  include <arpa/inet.h>
#  define cbor_ntohs        ntohs
#  define cbor_htons        htons
#endif
#ifndef cbor_ntohl
#  include <arpa/inet.h>
#  define cbor_ntohl        ntohl
#  define cbor_htonl        htonl
#endif
#ifndef cbor_ntohll
#  define cbor_ntohll       ntohll
#  define cbor_htonll       htonll
/* ntohll isn't usually defined */
#  ifndef ntohll
#    if (defined(__BYTE_ORDER__) && defined(__ORDER_BIG_ENDIAN__) && __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__) || \
    (defined(__BYTE_ORDER) && defined(__BIG_ENDIAN) && __BYTE_ORDER == __BIG_ENDIAN) || \
    (defined(BYTE_ORDER) && defined(BIG_ENDIAN) && BYTE_ORDER == BIG_ENDIAN) || \
    (defined(_BIG_ENDIAN) && !defined(_LITTLE_ENDIAN)) || (defined(__BIG_ENDIAN__) && !defined(__LITTLE_ENDIAN__)) || \
    defined(__ARMEB__) || defined(__MIPSEB__) || defined(__s390__) || defined(__sparc__)
#      define ntohll
#      define htonll
#    elif (defined(__BYTE_ORDER__) && defined(__ORDER_LITTLE_ENDIAN__) && __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__) || \
    (defined(__BYTE_ORDER) && defined(__LITTLE_ENDIAN) && __BYTE_ORDER == __LITTLE_ENDIAN) || \
    (defined(BYTE_ORDER) && defined(LITTLE_ENDIAN) && BYTE_ORDER == LITTLE_ENDIAN) || \
    defined(_LITTLE_ENDIAN) || defined(__LITTLE_ENDIAN__) || defined(__ARMEL__) || defined(__MIPSEL__) || \
    defined(__i386) || defined(__i386__) || defined(__x86_64) || defined(__x86_64__) || defined(__amd64)
#      define ntohll(x)       ((cbor_ntohl((uint32_t)(x)) * UINT64_C(0x100000000)) + (cbor_ntohl((x) >> 32)))
#      define htonll          ntohll
#    else
#      error "Unable to determine byte order!"
#    endif
#  endif
#endif


#ifdef __cplusplus
#  define CONST_CAST(t, v)  const_cast<t>(v)
#else
/* C-style const_cast without triggering a warning with -Wcast-qual */
#  define CONST_CAST(t, v)  (t)(uintptr_t)(v)
#endif

#if defined(__cplusplus) || __STDC_VERSION__ >= 202311
#  define CBOR_NULLPTR nullptr
#else
#  define CBOR_NULLPTR NULL
#endif

#ifdef likely
/* something has already defined likely(), accept it */
#elif defined(__GNUC__)
#  define likely(x)     __builtin_expect(!!(x), 1)
#  define unlikely(x)   __builtin_expect(!!(x), 0)
#else
#  define likely(x)     (x)
#  define unlikely(x)   (x)
#endif

#ifdef unreachable
/* C23 has unreachable() */
#elif defined(__GNUC__)
#  define unreachable() __builtin_unreachable()
#elif defined(_MSC_VER)
#  define unreachable() __assume(0)
#endif

static inline bool add_check_overflow(size_t v1, size_t v2, size_t *r)
{
#if ((defined(__GNUC__) && (__GNUC__ >= 5)) && !defined(__INTEL_COMPILER)) || __has_builtin(__builtin_add_overflow)
    return __builtin_add_overflow(v1, v2, r);
#else
    /* unsigned additions are well-defined */
    *r = v1 + v2;
    return v1 > v1 + v2;
#endif
}

static inline bool mul_check_overflow(size_t v1, size_t v2, size_t *r)
{
#if ((defined(__GNUC__) && (__GNUC__ >= 5)) && !defined(__INTEL_COMPILER)) || __has_builtin(__builtin_add_overflow)
    return __builtin_mul_overflow(v1, v2, r);
#else
    /* unsigned multiplications are well-defined */
    *r = v1 * v2;
    return *r > v1 && *r > v2;
#endif
}

#endif /* COMPILERSUPPORT_H */

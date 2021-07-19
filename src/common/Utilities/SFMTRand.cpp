/*
 * Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
 * Copyright (C) 2008-2021 TrinityCore <http://www.trinitycore.org/>
 */

#include "SFMTRand.h"
#include <algorithm>
#include <array>
#include <ctime>
#include <functional>
#include <random>

#if defined(__aarch64__)
#if defined(__clang__)
    #include <mm_malloc.h>
#elif defined(__GNUC__)
    static __inline__ void *__attribute__((__always_inline__, __nodebug__, __malloc__))
    _mm_malloc(size_t __size, size_t __align)
    {
        if (__align == 1)
        {
            return malloc(__size);
        }

        if (!(__align & (__align - 1)) && __align < sizeof(void *))
            __align = sizeof(void *);

        void *__mallocedMemory;

        if (posix_memalign(&__mallocedMemory, __align, __size))
            return NULL;

        return __mallocedMemory;
    }

    static __inline__ void __attribute__((__always_inline__, __nodebug__))
    _mm_free(void *__p)
    {
        free(__p);
    }
#else
    #error aarch64 only on clang and gcc
#endif
#else
#include <emmintrin.h>
#endif

SFMTRand::SFMTRand()
{
    std::random_device dev;

    if (dev.entropy() > 0)
    {
        std::array<uint32, SFMT_N32> seed;
        std::generate(seed.begin(), seed.end(), std::ref(dev));

        sfmt_init_by_array(&_state, seed.data(), seed.size());
    }
    else
    {
        sfmt_init_gen_rand(&_state, uint32(time(nullptr)));
    }
}

uint32 SFMTRand::RandomUInt32()                            // Output random bits
{
    return sfmt_genrand_uint32(&_state);
}

void* SFMTRand::operator new(size_t size, std::nothrow_t const&)
{
    return _mm_malloc(size, 16);
}

void SFMTRand::operator delete(void* ptr, std::nothrow_t const&)
{
    _mm_free(ptr);
}

void* SFMTRand::operator new(size_t size)
{
    return _mm_malloc(size, 16);
}

void SFMTRand::operator delete(void* ptr)
{
    _mm_free(ptr);
}

void* SFMTRand::operator new[](size_t size, std::nothrow_t const&)
{
    return _mm_malloc(size, 16);
}

void SFMTRand::operator delete[](void* ptr, std::nothrow_t const&)
{
    _mm_free(ptr);
}

void* SFMTRand::operator new[](size_t size)
{
    return _mm_malloc(size, 16);
}

void SFMTRand::operator delete[](void* ptr)
{
    _mm_free(ptr);
}

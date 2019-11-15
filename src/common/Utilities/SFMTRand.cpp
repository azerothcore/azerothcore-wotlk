/*
* Copyright (C) 2016+     AzerothCore <www.azerothcore.org>
* Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
* Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
*/

#include "SFMTRand.h"
#include <algorithm>
#include <array>
#include <functional>
#include <random>
#include <emmintrin.h>
#include <ctime>

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
        sfmt_init_gen_rand(&_state, uint32(time(nullptr)));
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

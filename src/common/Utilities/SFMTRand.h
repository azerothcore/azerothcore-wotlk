/*
 * Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
 * Copyright (C) 2008-2021 TrinityCore <http://www.trinitycore.org/>
 */

#ifndef SFMTRand_h__
#define SFMTRand_h__

#include "Define.h"
#include <SFMT.h>
#include <new>

/*
 * C++ Wrapper for SFMT
 */
class SFMTRand
{
public:
    SFMTRand();
    uint32 RandomUInt32(); // Output random bits
    void* operator new(size_t size, std::nothrow_t const&);
    void operator delete(void* ptr, std::nothrow_t const&);
    void* operator new(size_t size);
    void operator delete(void* ptr);
    void* operator new[](size_t size, std::nothrow_t const&);
    void operator delete[](void* ptr, std::nothrow_t const&);
    void* operator new[](size_t size);
    void operator delete[](void* ptr);
private:
    sfmt_t _state;
};

#endif // SFMTRand_h__

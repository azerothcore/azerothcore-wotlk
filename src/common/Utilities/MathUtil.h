/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef _MATH_UTIL_H
#define _MATH_UTIL_H

inline uint32 std_var(uint16 a[], uint16 n) {
    if (n == 0) return 0;
    uint64 sum = 0;
    uint64 sq_sum = 0;
    for (unsigned i = 0; i < n; ++i) {
        uint32 ai = a[i];
        sum += ai;
        sq_sum += ai * ai;
    }
    uint64 N = n;
    return (N * sq_sum - sum * sum) / (N * N);
}

inline 

#endif

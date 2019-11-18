/*
* Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU AGPL3 v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
* Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
* Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
*/

#include "Random.h"
#include "Common.h"
#include "Errors.h"
#include "SFMTRand.h"
#include <ace/TSS_T.h>

static acore::thread_specific_ptr<SFMTRand> sfmtRand;
static RandomEngine engine;

static SFMTRand* GetRng()
{
    SFMTRand* rand = sfmtRand.get();

    if (!rand)
    {
        rand = new SFMTRand();
        sfmtRand.reset(rand);
    }

    return rand;
}

int32 irand(int32 min, int32 max)
{
    ASSERT(max >= min);
    std::uniform_int_distribution<int32> uid(min, max);
    return uid(engine);
}

uint32 urand(uint32 min, uint32 max)
{
    ASSERT(max >= min);
    std::uniform_int_distribution<uint32> uid(min, max);
    return uid(engine);
}

uint32 urandms(uint32 min, uint32 max)
{
    ASSERT(std::numeric_limits<uint32>::max() / Milliseconds::period::den >= max);
    return urand(min * Milliseconds::period::den, max * Milliseconds::period::den);
}

float frand(float min, float max)
{
    ASSERT(max >= min);
    std::uniform_real_distribution<float> urd(min, max);
    return urd(engine);
}

Milliseconds randtime(Milliseconds min, Milliseconds max)
{
    long long diff = max.count() - min.count();
    ASSERT(diff >= 0);
    ASSERT(diff <= (uint32)-1);
    return min + Milliseconds(urand(0, diff));
}

uint32 rand32()
{
    return GetRng()->RandomUInt32();
}

double rand_norm()
{
    std::uniform_real_distribution<double> urd;
    return urd(engine);
}

double rand_chance()
{
    std::uniform_real_distribution<double> urd(0.0, 100.0);
    return urd(engine);
}

uint32 urandweighted(size_t count, double const* chances)
{
    std::discrete_distribution<uint32> dd(chances, chances + count);
    return dd(engine);
}

RandomEngine& RandomEngine::Instance()
{
    return engine;
}

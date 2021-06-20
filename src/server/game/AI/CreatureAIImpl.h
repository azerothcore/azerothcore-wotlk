/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */
#ifndef CREATUREAIIMPL_H
#define CREATUREAIIMPL_H

#include "Common.h"
#include "Define.h"
#include "TemporarySummon.h"
#include "CreatureAI.h"
#include "SpellMgr.h"

#include <functional>
#include <type_traits>

template<typename First, typename Second, typename... Rest>
static inline First const& RAND(First const& first, Second const& second, Rest const&... rest)
{
    std::reference_wrapper<typename std::add_const<First>::type> const pack[] = { first, second, rest... };
    return pack[urand(0, sizeof...(rest) + 1)].get();
}

enum AITarget
{
    AITARGET_SELF,
    AITARGET_VICTIM,
    AITARGET_ENEMY,
    AITARGET_ALLY,
    AITARGET_BUFF,
    AITARGET_DEBUFF,
};

enum AICondition
{
    AICOND_AGGRO,
    AICOND_COMBAT,
    AICOND_DIE,
};

#define AI_DEFAULT_COOLDOWN 5000

struct AISpellInfoType
{
    AISpellInfoType() : target(AITARGET_SELF), condition(AICOND_COMBAT)
        , cooldown(AI_DEFAULT_COOLDOWN), realCooldown(0), maxRange(0.0f){}
    AITarget target;
    AICondition condition;
    uint32 cooldown;
    uint32 realCooldown;
    float maxRange;
};

AISpellInfoType* GetAISpellInfo(uint32 i);

#endif


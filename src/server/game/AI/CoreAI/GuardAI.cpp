/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include "GuardAI.h"
#include "Errors.h"
#include "Player.h"
#include "ObjectAccessor.h"
#include "World.h"
#include "CreatureAIImpl.h"

int GuardAI::Permissible(Creature const* creature)
{
    if (creature->IsGuard())
        return PERMIT_BASE_SPECIAL;

    return PERMIT_BASE_NO;
}

GuardAI::GuardAI(Creature* creature) : ScriptedAI(creature)
{
}

void GuardAI::Reset()
{
    ScriptedAI::Reset();
    me->CastSpell(me, 18950 /*SPELL_INVISIBILITY_AND_STEALTH_DETECTION*/, true);
}

void GuardAI::EnterEvadeMode()
{
    if (!me->IsAlive())
    {
        me->GetMotionMaster()->MoveIdle();
        me->CombatStop(true);
        me->DeleteThreatList();
        return;
    }

#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outDebug(LOG_FILTER_UNITS, "Guard entry: %u enters evade mode.", me->GetEntry());
#endif

    me->RemoveAllAuras();
    me->DeleteThreatList();
    me->CombatStop(true);

    // Remove ChaseMovementGenerator from MotionMaster stack list, and add HomeMovementGenerator instead
    if (me->GetMotionMaster()->GetCurrentMovementGeneratorType() == CHASE_MOTION_TYPE)
        me->GetMotionMaster()->MoveTargetedHome();
}

void GuardAI::JustDied(Unit* killer)
{
    if (Player* player = killer->GetCharmerOrOwnerPlayerOrPlayerItself())
        me->SendZoneUnderAttackMessage(player);
}
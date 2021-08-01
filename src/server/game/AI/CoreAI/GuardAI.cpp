/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include "CreatureAIImpl.h"
#include "GuardAI.h"
#include "Player.h"

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

    LOG_DEBUG("entities.unit", "Guard entry: %u enters evade mode.", me->GetEntry());

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

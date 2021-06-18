/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include "HomeMovementGenerator.h"
#include "Creature.h"
#include "CreatureAI.h"
#include "DisableMgr.h"
#include "MoveSplineInit.h"
#include "WorldPacket.h"

void HomeMovementGenerator<Creature>::DoInitialize(Creature* owner)
{
    _setTargetLocation(owner);
}

void HomeMovementGenerator<Creature>::DoFinalize(Creature* owner)
{
    owner->ClearUnitState(UNIT_STATE_EVADE);
    if (arrived)
    {
        // Xinef: npc run by default
        //owner->SetWalk(true);
        owner->LoadCreaturesAddon(true);
        owner->AI()->JustReachedHome();
    }

    if (!owner->HasSwimmingFlagOutOfCombat())
        owner->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_SWIMMING);

    owner->UpdateEnvironmentIfNeeded(2);
}

void HomeMovementGenerator<Creature>::DoReset(Creature*)
{
}

void HomeMovementGenerator<Creature>::_setTargetLocation(Creature* owner)
{
    // Xinef: dont interrupt in any cast!
    //if (owner->HasUnitState(UNIT_STATE_ROOT | UNIT_STATE_STUNNED | UNIT_STATE_DISTRACTED))
    //    return;
    Movement::MoveSplineInit init(owner);
    float x, y, z, o;

    // Xinef: if there is motion generator on controlled slot, this one is not updated
    // Xinef: always get reset pos from idle slot
    MovementGenerator* gen = owner->GetMotionMaster()->GetMotionSlot(MOTION_SLOT_IDLE);
    if (owner->GetMotionMaster()->empty() || !gen || !gen->GetResetPosition(x, y, z))
    {
        owner->GetHomePosition(x, y, z, o);
        init.SetFacing(o);
    }

    owner->UpdateAllowedPositionZ(x, y, z);
    init.MoveTo(x, y, z, DisableMgr::IsPathfindingEnabled(owner->FindMap()), true);
    init.SetWalk(false);
    init.Launch();

    arrived = false;

    owner->ClearUnitState(uint32(UNIT_STATE_ALL_STATE & ~(UNIT_STATE_POSSESSED | UNIT_STATE_EVADE | UNIT_STATE_IGNORE_PATHFINDING | UNIT_STATE_NO_ENVIRONMENT_UPD)));
}

bool HomeMovementGenerator<Creature>::DoUpdate(Creature* owner, const uint32 /*time_diff*/)
{
    arrived = owner->movespline->Finalized();
    if (arrived)
        return false;

    if (i_recalculateTravel)
    {
        _setTargetLocation(owner);
        i_recalculateTravel = false;
    }

    return true;
}

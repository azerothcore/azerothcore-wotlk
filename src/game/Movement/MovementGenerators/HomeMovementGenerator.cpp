/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: http://github.com/azerothcore/azerothcore-wotlk/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include "HomeMovementGenerator.h"
#include "Creature.h"
#include "CreatureAI.h"
#include "WorldPacket.h"
#include "MoveSplineInit.h"
#include "MoveSpline.h"

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
    owner->m_targetsNotAcceptable.clear();
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

    init.MoveTo(x, y, z, MMAP::MMapFactory::IsPathfindingEnabled(owner->FindMap()), true);
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

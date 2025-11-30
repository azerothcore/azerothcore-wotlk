/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "HomeMovementGenerator.h"
#include "Creature.h"
#include "CreatureAI.h"
#include "DisableMgr.h"
#include "MoveSplineInit.h"

void HomeMovementGenerator<Creature>::DoInitialize(Creature* owner)
{
    _setTargetLocation(owner);
}

void HomeMovementGenerator<Creature>::DoFinalize(Creature* owner)
{
    owner->ClearUnitState(UNIT_STATE_EVADE);
    if (arrived)
    {
        owner->LoadCreaturesAddon(true);
        owner->AI()->JustReachedHome();
    }

    if (!owner->HasSwimmingFlagOutOfCombat())
        owner->RemoveUnitFlag(UNIT_FLAG_SWIMMING);
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
    init.MoveTo(x, y, z, sDisableMgr->IsPathfindingEnabled(owner->FindMap()), true);
    init.SetWalk(_walk);
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

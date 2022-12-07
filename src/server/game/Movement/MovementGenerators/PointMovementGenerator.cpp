/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU Affero General Public License as published by the
 * Free Software Foundation; either version 3 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "PointMovementGenerator.h"
#include "Creature.h"
#include "CreatureAI.h"
#include "Errors.h"
#include "MoveSpline.h"
#include "MoveSplineInit.h"
#include "ObjectAccessor.h"
#include "Player.h"
#include "World.h"

//----- Point Movement Generator
template<class T>
void PointMovementGenerator<T>::DoInitialize(T* unit)
{
    if (unit->HasUnitState(UNIT_STATE_NOT_MOVE) || unit->IsMovementPreventedByCasting())
    {
        // the next line is to ensure that a new spline is created in DoUpdate() once the unit is no longer rooted/stunned
        // todo: rename this flag to something more appropriate since it is set to true even without speed change now.
        _recalculateSpeed = true;
        return;
    }

    if (!unit->IsStopped())
        unit->StopMoving();

    unit->AddUnitState(UNIT_STATE_ROAMING | UNIT_STATE_ROAMING_MOVE);
    if (id == EVENT_CHARGE || id == EVENT_CHARGE_PREPATH)
    {
        unit->AddUnitState(UNIT_STATE_CHARGING);
    }

    _recalculateSpeed = false;
    Movement::MoveSplineInit init(unit);
    if (_precomputedPath.size() > 2) // pussywizard: for charge
        init.MovebyPath(_precomputedPath);
    else if (_generatePath)
    {
        PathGenerator path(unit);
        bool result = path.CalculatePath(_x, _y, _z, _forceDestination);
        if (result && !(path.GetPathType() & PATHFIND_NOPATH) && path.GetPath().size() > 2)
        {
            _precomputedPath = path.GetPath();
            init.MovebyPath(_precomputedPath);
        }
        else
        {
            // Xinef: fix strange client visual bug, moving on z coordinate only switches orientation by 180 degrees (visual only)
            if (G3D::fuzzyEq(unit->GetPositionX(), _x) && G3D::fuzzyEq(unit->GetPositionY(), _y))
            {
                _x += 0.2f * cos(unit->GetOrientation());
                _y += 0.2f * std::sin(unit->GetOrientation());
            }

            init.MoveTo(_x, _y, _z, true);
        }
    }
    else
    {
        // Xinef: fix strange client visual bug, moving on z coordinate only switches orientation by 180 degrees (visual only)
        if (G3D::fuzzyEq(unit->GetPositionX(), _x) && G3D::fuzzyEq(unit->GetPositionY(), _y))
        {
            _x += 0.2f * cos(unit->GetOrientation());
            _y += 0.2f * std::sin(unit->GetOrientation());
        }

        init.MoveTo(_x, _y, _z, true);
    }
    if (speed > 0.0f)
        init.SetVelocity(speed);

    if (_orientation > 0.0f)
    {
        init.SetFacing(_orientation);
    }

    init.Launch();
}

template<class T>
bool PointMovementGenerator<T>::DoUpdate(T* unit, uint32 /*diff*/)
{
    if (!unit)
        return false;

    if (unit->IsMovementPreventedByCasting())
    {
        unit->StopMoving();
        return true;
    }

    if (unit->HasUnitState(UNIT_STATE_NOT_MOVE))
    {
        if (!unit->HasUnitState(UNIT_STATE_CHARGING))
        {
            unit->StopMoving();
        }

        return true;
    }

    unit->AddUnitState(UNIT_STATE_ROAMING_MOVE);

    if (id != EVENT_CHARGE_PREPATH && _recalculateSpeed && !unit->movespline->Finalized())
    {
        _recalculateSpeed = false;
        Movement::MoveSplineInit init(unit);

        // xinef: speed changed during path execution, calculate remaining path and launch it once more
        if (_precomputedPath.size())
        {
            uint32 offset = std::min(uint32(unit->movespline->_currentSplineIdx()), uint32(_precomputedPath.size()));
            Movement::PointsArray::iterator offsetItr = _precomputedPath.begin();
            std::advance(offsetItr, offset);
            _precomputedPath.erase(_precomputedPath.begin(), offsetItr);

            // restore 0 element (current position)
            _precomputedPath.insert(_precomputedPath.begin(), G3D::Vector3(unit->GetPositionX(), unit->GetPositionY(), unit->GetPositionZ()));

            if (_precomputedPath.size() > 2)
                init.MovebyPath(_precomputedPath);
            else if (_precomputedPath.size() == 2)
                init.MoveTo(_precomputedPath[1].x, _precomputedPath[1].y, _precomputedPath[1].z, true);
        }
        else
            init.MoveTo(_x, _y, _z, true);
        if (speed > 0.0f) // Default value for point motion type is 0.0, if 0.0 spline will use GetSpeed on unit
            init.SetVelocity(speed);

        if (_orientation > 0.0f)
        {
            init.SetFacing(_orientation);
        }

        init.Launch();
    }

    return !unit->movespline->Finalized();
}

template<class T>
void PointMovementGenerator<T>::DoFinalize(T* unit)
{
    unit->ClearUnitState(UNIT_STATE_ROAMING | UNIT_STATE_ROAMING_MOVE);
    if (id == EVENT_CHARGE || id == EVENT_CHARGE_PREPATH)
    {
        unit->ClearUnitState(UNIT_STATE_CHARGING);

        if (_chargeTargetGUID && _chargeTargetGUID == unit->GetTarget())
        {
            if (Unit* target = ObjectAccessor::GetUnit(*unit, _chargeTargetGUID))
            {
                unit->Attack(target, true);
            }
        }
    }

    if (unit->movespline->Finalized())
        MovementInform(unit);
}

template<class T>
void PointMovementGenerator<T>::DoReset(T* unit)
{
    if (!unit->IsStopped())
        unit->StopMoving();

    unit->AddUnitState(UNIT_STATE_ROAMING | UNIT_STATE_ROAMING_MOVE);
    if (id == EVENT_CHARGE || id == EVENT_CHARGE_PREPATH)
    {
        unit->AddUnitState(UNIT_STATE_CHARGING);
    }
}

template<class T>
void PointMovementGenerator<T>::MovementInform(T* /*unit*/)
{
}

template <> void PointMovementGenerator<Creature>::MovementInform(Creature* unit)
{
    if (unit->AI())
        unit->AI()->MovementInform(POINT_MOTION_TYPE, id);

    if (Unit* summoner = unit->GetCharmerOrOwner())
    {
        if (UnitAI* AI = summoner->GetAI())
        {
            AI->SummonMovementInform(unit, POINT_MOTION_TYPE, id);
        }
    }
}

template void PointMovementGenerator<Player>::DoInitialize(Player*);
template void PointMovementGenerator<Creature>::DoInitialize(Creature*);
template void PointMovementGenerator<Player>::DoFinalize(Player*);
template void PointMovementGenerator<Creature>::DoFinalize(Creature*);
template void PointMovementGenerator<Player>::DoReset(Player*);
template void PointMovementGenerator<Creature>::DoReset(Creature*);
template bool PointMovementGenerator<Player>::DoUpdate(Player*, uint32);
template bool PointMovementGenerator<Creature>::DoUpdate(Creature*, uint32);

void AssistanceMovementGenerator::Finalize(Unit* unit)
{
    unit->ToCreature()->SetNoCallAssistance(false);
    unit->ToCreature()->CallAssistance();
    if (unit->IsAlive())
        unit->GetMotionMaster()->MoveSeekAssistanceDistract(sWorld->getIntConfig(CONFIG_CREATURE_FAMILY_ASSISTANCE_DELAY));
}

bool EffectMovementGenerator::Update(Unit* unit, uint32)
{
    return !unit->movespline->Finalized();
}

void EffectMovementGenerator::Finalize(Unit* unit)
{
    if (unit->GetTypeId() != TYPEID_UNIT)
        return;

    if (unit->GetTypeId() == TYPEID_UNIT && unit->HasUnitMovementFlag(MOVEMENTFLAG_FALLING) && unit->movespline->isFalling()) // pussywizard
        unit->RemoveUnitMovementFlag(MOVEMENTFLAG_FALLING);

    // Need restore previous movement since we have no proper states system
    //if (unit->IsAlive() && !unit->HasUnitState(UNIT_STATE_CONFUSED | UNIT_STATE_FLEEING))
    //{
    //    if (Unit* victim = unit->GetVictim())
    //        unit->GetMotionMaster()->MoveChase(victim);
    //    else
    //        unit->GetMotionMaster()->Initialize();
    //}

    if (unit->ToCreature()->AI())
        unit->ToCreature()->AI()->MovementInform(EFFECT_MOTION_TYPE, _Id);
}

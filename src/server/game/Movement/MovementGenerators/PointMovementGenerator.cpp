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
        /// @todo: rename this flag to something more appropriate since it is set to true even without speed change now.
        i_recalculateSpeed = true;
        return;
    }

    if (!unit->IsStopped())
        unit->StopMoving();

    unit->AddUnitState(UNIT_STATE_ROAMING | UNIT_STATE_ROAMING_MOVE);
    if (id == EVENT_CHARGE || id == EVENT_CHARGE_PREPATH)
    {
        unit->AddUnitState(UNIT_STATE_CHARGING);
    }

    i_recalculateSpeed = false;
    Movement::MoveSplineInit init(unit);
    if (m_precomputedPath.size() > 2) // pussywizard: for charge
        init.MovebyPath(m_precomputedPath);
    else if (_generatePath)
    {
        PathGenerator path(unit);
        bool result = path.CalculatePath(i_x, i_y, i_z, _forceDestination);
        if (result && !(path.GetPathType() & PATHFIND_NOPATH) && path.GetPath().size() > 2)
        {
            m_precomputedPath = path.GetPath();
            init.MovebyPath(m_precomputedPath);
        }
        else
        {
            // Xinef: fix strange client visual bug, moving on z coordinate only switches orientation by 180 degrees (visual only)
            if (G3D::fuzzyEq(unit->GetPositionX(), i_x) && G3D::fuzzyEq(unit->GetPositionY(), i_y))
            {
                i_x += 0.2f * cos(unit->GetOrientation());
                i_y += 0.2f * std::sin(unit->GetOrientation());
            }

            init.MoveTo(i_x, i_y, i_z, true);
        }
    }
    else
    {
        // Xinef: fix strange client visual bug, moving on z coordinate only switches orientation by 180 degrees (visual only)
        if (G3D::fuzzyEq(unit->GetPositionX(), i_x) && G3D::fuzzyEq(unit->GetPositionY(), i_y))
        {
            i_x += 0.2f * cos(unit->GetOrientation());
            i_y += 0.2f * std::sin(unit->GetOrientation());
        }

        init.MoveTo(i_x, i_y, i_z, true);
    }
    if (speed > 0.0f)
        init.SetVelocity(speed);

    if (i_orientation > 0.0f)
    {
        init.SetFacing(i_orientation);
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

    if (id != EVENT_CHARGE_PREPATH && i_recalculateSpeed && !unit->movespline->Finalized())
    {
        i_recalculateSpeed = false;
        Movement::MoveSplineInit init(unit);

        // xinef: speed changed during path execution, calculate remaining path and launch it once more
        if (m_precomputedPath.size())
        {
            uint32 offset = std::min(uint32(unit->movespline->_currentSplineIdx()), uint32(m_precomputedPath.size()));
            Movement::PointsArray::iterator offsetItr = m_precomputedPath.begin();
            std::advance(offsetItr, offset);
            m_precomputedPath.erase(m_precomputedPath.begin(), offsetItr);

            // restore 0 element (current position)
            m_precomputedPath.insert(m_precomputedPath.begin(), G3D::Vector3(unit->GetPositionX(), unit->GetPositionY(), unit->GetPositionZ()));

            if (m_precomputedPath.size() > 2)
                init.MovebyPath(m_precomputedPath);
            else if (m_precomputedPath.size() == 2)
                init.MoveTo(m_precomputedPath[1].x, m_precomputedPath[1].y, m_precomputedPath[1].z, true);
        }
        else
            init.MoveTo(i_x, i_y, i_z, true);
        if (speed > 0.0f) // Default value for point motion type is 0.0, if 0.0 spline will use GetSpeed on unit
            init.SetVelocity(speed);

        if (i_orientation > 0.0f)
        {
            init.SetFacing(i_orientation);
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
    if (!unit->IsCreature())
        return;

    if (unit->IsCreature() && unit->HasUnitMovementFlag(MOVEMENTFLAG_FALLING) && unit->movespline->isFalling()) // pussywizard
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
        unit->ToCreature()->AI()->MovementInform(EFFECT_MOTION_TYPE, m_Id);
}

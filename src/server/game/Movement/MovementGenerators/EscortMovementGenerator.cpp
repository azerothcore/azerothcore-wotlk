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

#include "EscortMovementGenerator.h"
#include "Creature.h"
#include "CreatureAI.h"
#include "MoveSplineInit.h"
#include "Player.h"

template<class T>
void EscortMovementGenerator<T>::DoInitialize(T* unit)
{
    if (!unit->IsStopped())
        unit->StopMoving();

    unit->AddUnitState(UNIT_STATE_ROAMING | UNIT_STATE_ROAMING_MOVE);
    i_recalculateSpeed = false;
    Movement::MoveSplineInit init(unit);

    if (m_precomputedPath.size() == 2) // xinef: simple case, just call move to
        init.MoveTo(m_precomputedPath[1].x, m_precomputedPath[1].y, m_precomputedPath[1].z, true);
    else if (m_precomputedPath.size())
        init.MovebyPath(m_precomputedPath);

    init.Launch();

    _splineId = unit->movespline->GetId();
}

template<class T>
bool EscortMovementGenerator<T>::DoUpdate(T* unit, uint32  /*diff*/)
{
    if (!unit)
        return false;

    if (unit->HasUnitState(UNIT_STATE_NOT_MOVE) || unit->IsMovementPreventedByCasting())
    {
        unit->ClearUnitState(UNIT_STATE_ROAMING_MOVE);
        return true;
    }

    unit->AddUnitState(UNIT_STATE_ROAMING_MOVE);

    bool arrived = unit->movespline->Finalized();

    if (i_recalculateSpeed && !arrived)
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

        init.Launch();
        // Xinef: Override spline Id on recalculate launch
        _splineId = unit->movespline->GetId();
    }

    return !arrived;
}

template<class T>
void EscortMovementGenerator<T>::DoFinalize(T* unit)
{
    unit->ClearUnitState(UNIT_STATE_ROAMING | UNIT_STATE_ROAMING_MOVE);
}

template<class T>
void EscortMovementGenerator<T>::DoReset(T* unit)
{
    if (!unit->IsStopped())
        unit->StopMoving();

    unit->AddUnitState(UNIT_STATE_ROAMING | UNIT_STATE_ROAMING_MOVE);
}

template void EscortMovementGenerator<Player>::DoInitialize(Player*);
template void EscortMovementGenerator<Creature>::DoInitialize(Creature*);
template void EscortMovementGenerator<Player>::DoFinalize(Player*);
template void EscortMovementGenerator<Creature>::DoFinalize(Creature*);
template void EscortMovementGenerator<Player>::DoReset(Player*);
template void EscortMovementGenerator<Creature>::DoReset(Creature*);
template bool EscortMovementGenerator<Player>::DoUpdate(Player* unit, uint32 diff);
template bool EscortMovementGenerator<Creature>::DoUpdate(Creature* unit, uint32 diff);

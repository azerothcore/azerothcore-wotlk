/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: http://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "Creature.h"
#include "MapManager.h"
#include "RandomMovementGenerator.h"
#include "ObjectAccessor.h"
#include "Map.h"
#include "Util.h"
#include "CreatureGroups.h"
#include "MoveSplineInit.h"
#include "MoveSpline.h"
#include "Spell.h"

template<>
void RandomMovementGenerator<Creature>::_setRandomLocation(Creature* creature)
{
    if (creature->_moveState != MAP_OBJECT_CELL_MOVE_NONE)
        return;

    if (_validPointsVector[_currentPoint].empty())
    {
        if (_currentPoint == RANDOM_POINTS_NUMBER) // cant go anywhere from initial position, lets stay
            return;
        // go back to initial position and will never return to this point
        _currentPoint = RANDOM_POINTS_NUMBER;
        _currDestPosition.Relocate(_initialPosition);
        creature->AddUnitState(UNIT_STATE_ROAMING_MOVE);
        Movement::MoveSplineInit init(creature);
        init.MoveTo(_currDestPosition.GetPositionX(), _currDestPosition.GetPositionY(), _currDestPosition.GetPositionZ());
        init.SetWalk(true);
        init.Launch();
        if (creature->GetFormation() && creature->GetFormation()->getLeader() == creature)
            creature->GetFormation()->LeaderMoveTo(_currDestPosition.GetPositionX(), _currDestPosition.GetPositionY(), _currDestPosition.GetPositionZ(), false);
        return;
    }

    uint8 random = urand(0, _validPointsVector[_currentPoint].size()-1);
    std::vector<uint8>::iterator randomIter = _validPointsVector[_currentPoint].begin() + random;
    uint8 newPoint = *randomIter;
    uint16 pathIdx = uint16(_currentPoint*RANDOM_POINTS_NUMBER + newPoint);

    // cant go anywhere from new point, so dont go there to not be stuck
    if (_validPointsVector[newPoint].empty())
    {
        _validPointsVector[_currentPoint].erase(randomIter);
        return;
    }

    Movement::PointsArray& finalPath = _preComputedPaths[pathIdx];
    if (finalPath.empty())
    {
        Map* map = creature->GetMap();
        float x = _destinationPoints[newPoint].x, y = _destinationPoints[newPoint].y, z = _destinationPoints[newPoint].z;
        // invalid coordinates
        if (!acore::IsValidMapCoord(x, y))
        {
            _validPointsVector[_currentPoint].erase(randomIter);
            _preComputedPaths.erase(pathIdx);
            return;
        }

        float ground = INVALID_HEIGHT;
        float levelZ = map->GetWaterOrGroundLevel(creature->GetPhaseMask(), x, y, z+4.0f, &ground);
        float newZ = INVALID_HEIGHT;

        // flying creature
        if (creature->CanFly())
            newZ = std::max<float>(levelZ, z + rand_norm()*_wanderDistance/2.0f);
        // point underwater
        else if (ground < levelZ)
        {
            if (!creature->CanSwim())
            {
                if (ground < levelZ - 1.5f)
                {
                    _validPointsVector[_currentPoint].erase(randomIter);
                    _preComputedPaths.erase(pathIdx);
                    return;
                }
                levelZ = ground;
            }
            else
            {
                if (levelZ > INVALID_HEIGHT)
                    newZ = std::min<float>(levelZ-2.0f, z + rand_norm()*_wanderDistance/2.0f);
                newZ = std::max<float>(ground, newZ);
            }
        }
        // point on ground
        else
        {
            if (levelZ <= INVALID_HEIGHT || !creature->CanWalk())
            {
                _validPointsVector[_currentPoint].erase(randomIter);
                _preComputedPaths.erase(pathIdx);
                return;
            }
        }

        if (newZ > INVALID_HEIGHT)
        {
            // flying / swiming creature - dest not in los
            if (!creature->IsWithinLOS(x, y, newZ))
            {
                _validPointsVector[_currentPoint].erase(randomIter);
                _preComputedPaths.erase(pathIdx);
                return;
            }

            finalPath.push_back(G3D::Vector3(creature->GetPositionX(), creature->GetPositionY(), creature->GetPositionZ()));
            finalPath.push_back(G3D::Vector3(x, y, newZ));
        }
        else // ground
        {
            bool result = _pathGenerator->CalculatePath(x, y, levelZ, false);
            if (result && !(_pathGenerator->GetPathType() & PATHFIND_NOPATH))
            {
                // generated path is too long
                float pathLen = _pathGenerator->getPathLength();
                if (pathLen*pathLen > creature->GetExactDistSq(x, y, levelZ) * MAX_PATH_LENGHT_FACTOR*MAX_PATH_LENGHT_FACTOR)
                {
                    _validPointsVector[_currentPoint].erase(randomIter);
                    _preComputedPaths.erase(pathIdx);
                    return;
                }

                finalPath = _pathGenerator->GetPath();
                Movement::PointsArray::iterator itr = finalPath.begin();
                Movement::PointsArray::iterator itrNext = finalPath.begin()+1;
                float zDiff, distDiff;

                for (; itrNext != finalPath.end(); ++itr, ++itrNext)
                {
                    distDiff = sqrt(((*itr).x-(*itrNext).x)*((*itr).x-(*itrNext).x) + ((*itr).y-(*itrNext).y)*((*itr).y-(*itrNext).y));
                    zDiff = fabs((*itr).z - (*itrNext).z);

                    // Xinef: tree climbing, cut as much as we can
                    if (zDiff > 2.0f ||
                        (G3D::fuzzyNe(zDiff, 0.0f) && distDiff / zDiff < 2.15f)) // ~25˚
                    {
                        _validPointsVector[_currentPoint].erase(randomIter);
                        _preComputedPaths.erase(pathIdx);
                        return;
                    }

                    if (!map->isInLineOfSight((*itr).x, (*itr).y, (*itr).z+2.f, (*itrNext).x, (*itrNext).y, (*itrNext).z+2.f, creature->GetPhaseMask(), LINEOFSIGHT_ALL_CHECKS))
                    {
                        _validPointsVector[_currentPoint].erase(randomIter);
                        _preComputedPaths.erase(pathIdx);
                        return;
                    }
                }

                // no valid path
                if (finalPath.size() < 2)
                {
                    _validPointsVector[_currentPoint].erase(randomIter);
                    _preComputedPaths.erase(pathIdx);
                    return;
                }
            }
            else
            {
                _validPointsVector[_currentPoint].erase(randomIter);
                _preComputedPaths.erase(pathIdx);
                return;
            }
        }
    }

    _currentPoint = newPoint;
    G3D::Vector3& finalPoint = finalPath[finalPath.size()-1];
    _currDestPosition.Relocate(finalPoint.x, finalPoint.y, finalPoint.z);

    creature->AddUnitState(UNIT_STATE_ROAMING_MOVE);
    ++_moveCount;
    if (roll_chance_i((int32)_moveCount * 25 + 10))
    {
        _moveCount = 0;
        _nextMoveTime.Reset(urand(4000, 8000));
    }

    Movement::MoveSplineInit init(creature);
    init.MovebyPath(finalPath);
    init.SetWalk(true);
    init.Launch();

    if (sWorld->getBoolConfig(CONFIG_DONT_CACHE_RANDOM_MOVEMENT_PATHS))
        _preComputedPaths.erase(pathIdx);

    //Call for creature group update
    if (creature->GetFormation() && creature->GetFormation()->getLeader() == creature)
        creature->GetFormation()->LeaderMoveTo(finalPoint.x, finalPoint.y, finalPoint.z, false);
}

template<>
void RandomMovementGenerator<Creature>::DoInitialize(Creature* creature)
{
    if (!creature->IsAlive())
        return;

    if (!_wanderDistance)
        _wanderDistance = creature->GetWanderDistance();

    _nextMoveTime.Reset(creature->GetDBTableGUIDLow() && creature->GetWanderDistance() == _wanderDistance ? urand(1, 5000) : 0);
    _wanderDistance = std::max((creature->GetWanderDistance() == _wanderDistance && creature->GetInstanceId() == 0) ? (creature->CanFly() ? MIN_WANDER_DISTANCE_AIR : MIN_WANDER_DISTANCE_GROUND) : 0.0f, _wanderDistance);

    if (G3D::fuzzyEq(_initialPosition.GetExactDist2d(0.0f, 0.0f), 0.0f))
    {
        _initialPosition.Relocate(creature);
        _destinationPoints.clear();
        for (uint8 i = 0; i < RANDOM_POINTS_NUMBER; ++i)
        {
            float angle = (M_PI*2.0f/(float)RANDOM_POINTS_NUMBER)*i;
            float factor = 0.5f + rand_norm()*0.5f;
            _destinationPoints.push_back(G3D::Vector3(_initialPosition.GetPositionX() + _wanderDistance*cos(angle)*factor, _initialPosition.GetPositionY() + _wanderDistance*sin(angle)*factor, _initialPosition.GetPositionZ()));
        }
    }

    if (!_pathGenerator)
        _pathGenerator = new PathGenerator(creature);
    creature->AddUnitState(UNIT_STATE_ROAMING | UNIT_STATE_ROAMING_MOVE);
}

template<>
void RandomMovementGenerator<Creature>::DoReset(Creature* creature)
{
    DoInitialize(creature);
}

template<>
void RandomMovementGenerator<Creature>::DoFinalize(Creature* creature)
{
    creature->ClearUnitState(UNIT_STATE_ROAMING|UNIT_STATE_ROAMING_MOVE);
    creature->SetWalk(false);
}

template<>
bool RandomMovementGenerator<Creature>::DoUpdate(Creature* creature, const uint32 diff)
{
    if (creature->HasUnitState(UNIT_STATE_ROOT | UNIT_STATE_STUNNED | UNIT_STATE_DISTRACTED))
    {
        _nextMoveTime.Reset(0);  // Expire the timer
        creature->ClearUnitState(UNIT_STATE_ROAMING_MOVE);
        return true;
    }

    // xinef: if we got disable move flag, do not remove default generator - just prevent movement
    if (creature->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_DISABLE_MOVE))
    {
        _nextMoveTime.Reset(0);  // Expire the timer
        creature->ClearUnitState(UNIT_STATE_ROAMING_MOVE);
        return true;
    }

    // prevent movement while casting spells with cast time or channel time
    if (creature->HasUnitState(UNIT_STATE_CASTING))
    {
        bool stop = true;
        if (Spell* spell = creature->GetCurrentSpell(CURRENT_CHANNELED_SPELL))
            if (!(spell->GetSpellInfo()->ChannelInterruptFlags & (AURA_INTERRUPT_FLAG_MOVE | AURA_INTERRUPT_FLAG_TURNING)) && !(spell->GetSpellInfo()->InterruptFlags & SPELL_INTERRUPT_FLAG_MOVEMENT))
                stop = false;

        if (stop)
        {
            if (!creature->IsStopped())
                creature->StopMoving();

            return true;
        }
    }

    if (creature->movespline->Finalized())
    {
        _nextMoveTime.Update(diff);
        if (_nextMoveTime.Passed())
            _setRandomLocation(creature);
    }
    return true;
}

template<>
bool RandomMovementGenerator<Creature>::GetResetPosition(float& x, float& y, float& z)
{
    if (_currentPoint < RANDOM_POINTS_NUMBER)
        _currDestPosition.GetPosition(x, y, z);
    else if (G3D::fuzzyNe(_initialPosition.GetExactDist2d(0.0f, 0.0f), 0.0f)) // if initial position is not 0.0f, 0.0f
        _initialPosition.GetPosition(x, y, z);
    else
        return false;
    return true;
}

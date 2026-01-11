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

#include "SmartAI.h"
#include "AreaTriggerScript.h"
#include "CellImpl.h"
#include "GridDefines.h"
#include "GridNotifiers.h"
#include "Group.h"
#include "ObjectDefines.h"
#include "ObjectMgr.h"
#include "ScriptedCreature.h"
#include "SpellMgr.h"
#include "Vehicle.h"

SmartAI::SmartAI(Creature* c) : CreatureAI(c)
{
    mIsCharmed = false;
    // copy script to local (protection for table reload)

    mWayPoints = nullptr;
    mEscortState = SMART_ESCORT_NONE;
    mCurrentWPID = 0;//first wp id is 1 !!
    mWPReached = false;
    mOOCReached = false;
    mWPPauseTimer = 0;
    mLastWP = nullptr;
    mEscortNPCFlags = 0;

    mCanRepeatPath = false;

    mEvadeDisabled = false;

    mCanAutoAttack = true;

    mForcedPaused = false;

    mForcedMovement = FORCED_MOVEMENT_NONE;

    mEscortQuestID = 0;

    mDespawnTime = 0;
    mDespawnState = 0;

    mEscortInvokerCheckTimer = 1000;
    mFollowDist = 0;
    mFollowAngle = 0;
    mFollowCredit = 0;
    mFollowArrivedEntry = 0;
    mFollowCreditType = 0;
    mFollowArrivedAlive = 0;
    mFollowArrivedTimer = 0;
    mInvincibilityHpLevel = 0;

    mJustReset = false;

    mcanSpawn = true;

    _chaseOnInterrupt = false;

    aiDataSet.clear();

    // Xinef: Vehicle conditions
    m_ConditionsTimer = 0;
    if (me->GetVehicleKit())
        conditions = sConditionMgr->GetConditionsForNotGroupedEntry(CONDITION_SOURCE_TYPE_CREATURE_TEMPLATE_VEHICLE, me->GetEntry());

    _currentRangeMode = false;
    _attackDistance = 0.f;
    _mainSpellId = 0;
}

bool SmartAI::IsAIControlled() const
{
    return !mIsCharmed;
}

void SmartAI::UpdateDespawn(const uint32 diff)
{
    if (mDespawnState <= 1 || mDespawnState > 3)
        return;

    if (mDespawnTime < diff)
    {
        if (mDespawnState == 2)
        {
            me->SetVisible(false);
            mDespawnTime = 5000;
            mDespawnState++;
        }
        else
            me->DespawnOrUnsummon();
    }
    else
        mDespawnTime -= diff;
}

WaypointData const* SmartAI::GetNextWayPoint()
{
    if (!mWayPoints || mWayPoints->empty())
        return nullptr;

    mCurrentWPID++;
    auto itr = mWayPoints->find(mCurrentWPID);
    if (itr != mWayPoints->end())
    {
        mLastWP = &(*itr).second;
        if (mLastWP->id != mCurrentWPID)
            LOG_ERROR("scripts.ai.sai", "SmartAI::GetNextWayPoint: Got not expected waypoint id {}, expected {}", mLastWP->id, mCurrentWPID);

        return &(*itr).second;
    }
    return nullptr;
}

void SmartAI::GenerateWayPointArray(Movement::PointsArray* points)
{
    if (!mWayPoints || mWayPoints->empty())
        return;

    // Flying unit, just fill array
    if (me->m_movementInfo.HasMovementFlag((MovementFlags)(MOVEMENTFLAG_CAN_FLY | MOVEMENTFLAG_DISABLE_GRAVITY)))
    {
        // xinef: first point in vector is unit real position
        points->clear();
        points->push_back(G3D::Vector3(me->GetPositionX(), me->GetPositionY(), me->GetPositionZ()));
        uint32 wpCounter = mCurrentWPID;
        auto itr = mWayPoints->find(wpCounter++);
        do
        {
            WaypointData const& wp = (*itr).second;
            points->push_back(G3D::Vector3(wp.x, wp.y, wp.z));

            itr = mWayPoints->find(wpCounter++);
        }
        while (itr != mWayPoints->end());
    }
    else
    {
        for (float size = 1.0f; size; size *= 0.5f)
        {
            std::vector<G3D::Vector3> pVector;
            // xinef: first point in vector is unit real position
            pVector.push_back(G3D::Vector3(me->GetPositionX(), me->GetPositionY(), me->GetPositionZ()));
            uint32 wpCounter = mCurrentWPID;

            uint32 length = (mWayPoints->size() - mCurrentWPID) * size;

            uint32 cnt = 0;
            for (auto itr = mWayPoints->find(wpCounter); itr != mWayPoints->end() && cnt++ <= length; ++itr)
            {
                WaypointData const& wp = (*itr).second;
                pVector.push_back(G3D::Vector3(wp.x, wp.y, wp.z));
            }

            if (pVector.size() > 2) // more than source + dest
            {
                G3D::Vector3 middle = (pVector[0] + pVector[pVector.size() - 1]) / 2.f;
                G3D::Vector3 offset;

                bool continueLoop = false;
                for (uint32 i = 1; i < pVector.size() - 1; ++i)
                {
                    offset = middle - pVector[i];
                    if (std::fabs(offset.x) >= 0xFF || std::fabs(offset.y) >= 0xFF || std::fabs(offset.z) >= 0x7F)
                    {
                        // offset is too big, split points
                        continueLoop = true;
                        break;
                    }
                }
                if (continueLoop)
                    continue;
            }
            // everything ok
            *points = pVector;
            break;
        }
    }
}

void SmartAI::StartPath(ForcedMovement forcedMovement, uint32 path, bool repeat, Unit* invoker, PathSource pathSource)
{
    if (HasEscortState(SMART_ESCORT_ESCORTING))
        StopPath();

    if (path)
    {
        if (!LoadPath(path, pathSource))
            return;
    }

    if (!mWayPoints || mWayPoints->empty())
        return;

    if (WaypointData const* wp = GetNextWayPoint())
    {
        AddEscortState(SMART_ESCORT_ESCORTING);
        mCanRepeatPath = repeat;
        mForcedMovement = forcedMovement;

        if (invoker && invoker->IsPlayer())
        {
            mEscortNPCFlags = me->GetNpcFlags();
            me->ReplaceAllNpcFlags(UNIT_NPC_FLAG_NONE);
        }

        Movement::PointsArray pathPoints;
        GenerateWayPointArray(&pathPoints);

        me->GetMotionMaster()->MoveSplinePath(&pathPoints, mForcedMovement);
        GetScript()->ProcessEventsFor(SMART_EVENT_ESCORT_START, nullptr, wp->id, GetScript()->GetPathId());
    }
}

bool SmartAI::LoadPath(uint32 entry, PathSource pathSource)
{
    if (HasEscortState(SMART_ESCORT_ESCORTING))
        return false;

    switch (pathSource)
    {
        case PathSource::SMART_WAYPOINT_MGR:
        {
            mWayPoints = sSmartWaypointMgr->GetPath(entry);
            if (!mWayPoints)
            {
                GetScript()->SetPathId(0);
                return false;
            }
            break;
        }
        case PathSource::WAYPOINT_MGR:
        {
            mWayPoints = sWaypointMgr->GetPath(entry);
            if (!mWayPoints)
            {
                GetScript()->SetPathId(0);
                return false;
            }
            break;
        }
    }

    GetScript()->SetPathId(entry);
    return true;
}

void SmartAI::PausePath(uint32 delay, bool forced)
{
    if (!HasEscortState(SMART_ESCORT_ESCORTING))
        return;

    if (HasEscortState(SMART_ESCORT_PAUSED))
    {
        LOG_ERROR("scripts.ai.sai", "SmartAI::StartPath: Creature entry {} wanted to pause waypoint movement while already paused, ignoring.", me->GetEntry());
        return;
    }

    AddEscortState(SMART_ESCORT_PAUSED);
    mWPPauseTimer = delay;
    if (forced && !mWPReached)
    {
        mForcedPaused = forced;
        if (me->GetMotionMaster()->GetMotionSlotType(MOTION_SLOT_ACTIVE) == ESCORT_MOTION_TYPE)
            me->GetMotionMaster()->MovementExpired();

        me->StopMoving();
        me->GetMotionMaster()->MoveIdle();//force stop

        auto waypoint = mWayPoints->find(mCurrentWPID);
        if (waypoint->second.orientation.has_value())
        {
            me->SetFacingTo(*waypoint->second.orientation);
        }
    }
    GetScript()->ProcessEventsFor(SMART_EVENT_ESCORT_PAUSED, nullptr, mCurrentWPID, GetScript()->GetPathId());
}

void SmartAI::StopPath(uint32 DespawnTime, uint32 quest, bool fail)
{
    if (!HasEscortState(SMART_ESCORT_ESCORTING))
        return;

    if (quest)
        mEscortQuestID = quest;

    SetDespawnTime(DespawnTime);

    if (me->GetMotionMaster()->GetMotionSlotType(MOTION_SLOT_ACTIVE) == ESCORT_MOTION_TYPE)
        me->GetMotionMaster()->MovementExpired();

    me->StopMoving();
    me->GetMotionMaster()->MoveIdle();
    GetScript()->ProcessEventsFor(SMART_EVENT_ESCORT_STOPPED, nullptr, mCurrentWPID, GetScript()->GetPathId());
    EndPath(fail);
}

void SmartAI::EndPath(bool fail)
{
    RemoveEscortState(SMART_ESCORT_ESCORTING | SMART_ESCORT_PAUSED | SMART_ESCORT_RETURNING);
    mWayPoints = nullptr;
    mLastWP = nullptr;
    mWPPauseTimer = 0;

    if (mEscortNPCFlags)
    {
        me->ReplaceAllNpcFlags(NPCFlags(mEscortNPCFlags));
        mEscortNPCFlags = 0;
    }

    ObjectVector const* targets = GetScript()->GetStoredTargetVector(SMART_ESCORT_TARGETS, *me);
    if (targets && mEscortQuestID)
    {
        if (targets->size() == 1 && GetScript()->IsPlayer((*targets->begin())))
        {
            Player* player = targets->front()->ToPlayer();
            if (Group* group = player->GetGroup())
            {
                for (GroupReference* groupRef = group->GetFirstMember(); groupRef != nullptr; groupRef = groupRef->next())
                {
                    Player* groupGuy = groupRef->GetSource();
                    if (!groupGuy || !player->IsInMap(groupGuy))
                        continue;

                    if (!fail && groupGuy->IsAtGroupRewardDistance(me) && !groupGuy->HasCorpse())
                        groupGuy->AreaExploredOrEventHappens(mEscortQuestID);
                    else if (fail && groupGuy->GetQuestStatus(mEscortQuestID) == QUEST_STATUS_INCOMPLETE)
                        groupGuy->FailQuest(mEscortQuestID);
                }
            }
            else
            {
                if (!fail && player->IsAtGroupRewardDistance(me) && !player->HasCorpse())
                    player->GroupEventHappens(mEscortQuestID, me);
                else if (fail && player->GetQuestStatus(mEscortQuestID) == QUEST_STATUS_INCOMPLETE)
                    player->FailQuest(mEscortQuestID);
            }
        }
        else
        {
            for (WorldObject* target : *targets)
            {
                if (GetScript()->IsPlayer(target))
                {
                    Player* player = target->ToPlayer();
                    if (!fail && player->IsAtGroupRewardDistance(me) && !player->HasCorpse())
                        player->AreaExploredOrEventHappens(mEscortQuestID);
                    else if (fail && player->GetQuestStatus(mEscortQuestID) == QUEST_STATUS_INCOMPLETE)
                        player->FailQuest(mEscortQuestID);
                }
            }
        }
    }

    // Xinef: if the escort failed - DO NOT PROCESS ANYTHING
    // Xinef: End Path events should be only processed if it was SUCCESSFUL stop or stop called by SMART_ACTION_WAYPOINT_STOP
    if (fail)
    {
        mCurrentWPID = 0;
        return;
    }

    GetScript()->ProcessEventsFor(SMART_EVENT_ESCORT_ENDED, nullptr, mCurrentWPID, GetScript()->GetPathId());
    mCurrentWPID = 0;

    if (mCanRepeatPath)
    {
        if (IsAIControlled())
            StartPath(mForcedMovement, GetScript()->GetPathId(), true);
    }
    else
        GetScript()->SetPathId(0);

    if (mDespawnState == 1)
        StartDespawn();
}

void SmartAI::ResumePath()
{
    if (mLastWP)
    {
        Movement::PointsArray pathPoints;
        GenerateWayPointArray(&pathPoints);

        me->GetMotionMaster()->MoveSplinePath(&pathPoints, mForcedMovement);
    }
}

void SmartAI::ReturnToLastOOCPos()
{
    if (!IsAIControlled())
        return;

    float x, y, z, o;
    me->GetHomePosition(x, y, z, o);
    me->GetMotionMaster()->MovePoint(SMART_ESCORT_LAST_OOC_POINT, x, y, z, FORCED_MOVEMENT_RUN);
}

void SmartAI::UpdatePath(const uint32 diff)
{
    if (!HasEscortState(SMART_ESCORT_ESCORTING))
        return;

    if (mEscortInvokerCheckTimer < diff)
    {
        // Xinef: Escort failed - no players in range
        // Xinef: Despawn immediately
        if (!IsEscortInvokerInRange())
        {
            StopPath(0, mEscortQuestID, true);

            // Xinef: allow to properly hook out of range despawn action, which in most cases should perform the same operation as dying
            GetScript()->ProcessEventsFor(SMART_EVENT_DEATH, me);
            me->DespawnOrUnsummon(1ms);
            return;
        }
        mEscortInvokerCheckTimer = 1000;
    }
    else
        mEscortInvokerCheckTimer -= diff;

    // handle pause
    if (HasEscortState(SMART_ESCORT_PAUSED))
    {
        if (mWPPauseTimer < diff)
        {
            if (!me->IsInCombat() && !HasEscortState(SMART_ESCORT_RETURNING) && (mWPReached || mForcedPaused))
            {
                GetScript()->ProcessEventsFor(SMART_EVENT_ESCORT_RESUMED, nullptr, mCurrentWPID, GetScript()->GetPathId());
                RemoveEscortState(SMART_ESCORT_PAUSED);
                if (mForcedPaused)// if paused between 2 wps resend movement
                {
                    mWPReached = false;
                    mForcedPaused = false;
                    ResumePath();
                }

                mWPPauseTimer = 0;
            }
        }
        else
            mWPPauseTimer -= diff;
    }

    if (HasEscortState(SMART_ESCORT_RETURNING))
    {
        if (mOOCReached)//reached OOC WP
        {
            mOOCReached = false;
            RemoveEscortState(SMART_ESCORT_RETURNING);
            if (!HasEscortState(SMART_ESCORT_PAUSED))
                ResumePath();
        }
    }

    if ((me->GetVictim() && me->IsInCombat()) || HasEscortState(SMART_ESCORT_PAUSED | SMART_ESCORT_RETURNING))
        return;

    // handle next wp
    if (!me->HasUnitState(UNIT_STATE_NOT_MOVE) && me->movespline->Finalized())//reached WP
    {
        if (!mWPReached)
        {
            ResumePath();
            return;
        }

        mWPReached = false;
        if (mCurrentWPID == GetWPCount())
            EndPath();
        else if (GetNextWayPoint())
        {
            // xinef: if we have reached waypoint, and there is no working spline movement it means our splitted array has ended, make new one
            if (me->movespline->Finalized())
                ResumePath();
        }
    }
}

void SmartAI::CheckConditions(const uint32 diff)
{
    Vehicle* vehicle = me->GetVehicleKit();
    if (!vehicle)
        return;

    if (m_ConditionsTimer < diff)
    {
        if (!conditions.empty())
        {
            for (SeatMap::iterator itr = vehicle->Seats.begin(); itr != vehicle->Seats.end(); ++itr)
                if (Unit* passenger = ObjectAccessor::GetUnit(*me, itr->second.Passenger.Guid))
                {
                    if (Player* player = passenger->ToPlayer())
                    {
                        if (!sConditionMgr->IsObjectMeetToConditions(player, me, conditions))
                        {
                            player->ExitVehicle();
                            return;//check other pessanger in next tick
                        }
                    }
                }
        }
        m_ConditionsTimer = 1000;
    }
    else
        m_ConditionsTimer -= diff;
}

void SmartAI::UpdateAI(uint32 diff)
{
    bool hasVictim = UpdateVictim();
    CheckConditions(diff);
    GetScript()->OnUpdate(diff);
    UpdatePath(diff);
    UpdateDespawn(diff);

    //TODO move to void
    if (mFollowGuid)
    {
        if (mFollowArrivedTimer < diff)
        {
            if (me->FindNearestCreature(mFollowArrivedEntry, INTERACTION_DISTANCE, mFollowArrivedAlive))
            {
                StopFollow(true);
                return;
            }

            mFollowArrivedTimer = 1000;
        }
        else
            mFollowArrivedTimer -= diff;
    }

    if (!IsAIControlled())
    {
        if (CharmInfo* charmInfo = me->GetCharmInfo())
        {
            if (charmInfo->IsCommandAttack() && mCanAutoAttack)
            {
                DoMeleeAttackIfReady();
            }
        }

        return;
    }

    if (!hasVictim)
        return;

    if (mCanAutoAttack)
        DoMeleeAttackIfReady();
}

bool SmartAI::IsEscortInvokerInRange()
{
    if (ObjectVector const* targets = GetScript()->GetStoredTargetVector(SMART_ESCORT_TARGETS, *me))
    {
        float checkDist = me->GetInstanceScript() ? SMART_ESCORT_MAX_PLAYER_DIST * 2 : SMART_ESCORT_MAX_PLAYER_DIST;
        if (targets->size() == 1 && GetScript()->IsPlayer((*targets->begin())))
        {
            Player* player = (*targets->begin())->ToPlayer();
            if (me->GetDistance(player) <= checkDist)
                return true;

            if (Group* group = player->GetGroup())
            {
                for (GroupReference* groupRef = group->GetFirstMember(); groupRef != nullptr; groupRef = groupRef->next())
                {
                    Player* groupGuy = groupRef->GetSource();

                    if (groupGuy && me->IsInMap(groupGuy) && me->GetDistance(groupGuy) <= checkDist)
                        return true;
                }
            }
        }
        else
        {
            for (WorldObject* target : *targets)
            {
                if (GetScript()->IsPlayer(target))
                {
                    if (me->GetDistance(target->ToPlayer()) <= checkDist)
                        return true;
                }
            }
        }

        // Xinef: no valid target found
        return false;
    }
    // Xinef: no player invoker was stored, just ignore range check
    return true;
}

void SmartAI::MovepointReached(uint32 id)
{
    // override the id, path can be resumed any time and counter will reset
    // mCurrentWPID holds proper id

    // xinef: both point movement and escort generator can enter this function
    if (id == SMART_ESCORT_LAST_OOC_POINT)
    {
        mOOCReached = true;
        return;
    }

    mWPReached = true;
    GetScript()->ProcessEventsFor(SMART_EVENT_ESCORT_REACHED, nullptr, mCurrentWPID);

    if (mLastWP)
    {
        me->SetPosition(mLastWP->x, mLastWP->y, mLastWP->z, me->GetOrientation());
        me->SetHomePosition(me->GetPosition());
    }

    if (HasEscortState(SMART_ESCORT_PAUSED))
    {
        if (me->GetMotionMaster()->GetMotionSlotType(MOTION_SLOT_ACTIVE) == ESCORT_MOTION_TYPE)
            me->GetMotionMaster()->MovementExpired();

        me->StopMovingOnCurrentPos();
        me->GetMotionMaster()->MoveIdle();
    }
    // Xinef: Can be unset in ProcessEvents
    else if (HasEscortState(SMART_ESCORT_ESCORTING) && me->GetMotionMaster()->GetCurrentMovementGeneratorType() == ESCORT_MOTION_TYPE)
    {
        mWPReached = false;
        if (mCurrentWPID == GetWPCount())
            EndPath();
        else if (GetNextWayPoint())
        {
            // xinef: if we have reached waypoint, and there is no working spline movement it means our splitted array has ended, make new one
            if (me->movespline->Finalized())
                ResumePath();
        }
    }
}

void SmartAI::MovementInform(uint32 MovementType, uint32 Data)
{
    if (MovementType == POINT_MOTION_TYPE && Data == SMART_ESCORT_LAST_OOC_POINT)
        me->ClearUnitState(UNIT_STATE_EVADE);

    if (MovementType == WAYPOINT_MOTION_TYPE)
        GetScript()->ProcessEventsFor(SMART_EVENT_WAYPOINT_REACHED, nullptr, Data); // data now corresponds to columns

    GetScript()->ProcessEventsFor(SMART_EVENT_MOVEMENTINFORM, nullptr, MovementType, Data);
    if (!HasEscortState(SMART_ESCORT_ESCORTING))
        return;

    if (MovementType == ESCORT_MOTION_TYPE || (MovementType == POINT_MOTION_TYPE && Data == SMART_ESCORT_LAST_OOC_POINT))
        MovepointReached(Data);
}

void SmartAI::EnterEvadeMode(EvadeReason /*why*/)
{
    if (mEvadeDisabled)
    {
        GetScript()->ProcessEventsFor(SMART_EVENT_EVADE);
        return;
    }

    if (me->GetCharmerGUID().IsPlayer() || me->HasUnitFlag(UNIT_FLAG_POSSESSED))
    {
        me->AttackStop();
        me->RemoveUnitFlag(UNIT_FLAG_IN_COMBAT);
        return;
    }

    if (!_EnterEvadeMode())
        return;

    me->AddUnitState(UNIT_STATE_EVADE);

    GetScript()->ProcessEventsFor(SMART_EVENT_EVADE); //must be after aura clear so we can cast spells from db

    if (HasEscortState(SMART_ESCORT_ESCORTING))
    {
        AddEscortState(SMART_ESCORT_RETURNING);
        ReturnToLastOOCPos();
    }
    else if (mFollowGuid)
    {
        if (Unit* target = ObjectAccessor::GetUnit(*me, mFollowGuid))
            me->GetMotionMaster()->MoveFollow(target, mFollowDist, mFollowAngle);
        me->ClearUnitState(UNIT_STATE_EVADE);

        // xinef: do not forget to reset scripts as we wont call reached home
        GetScript()->OnReset();
    }
    else
    {
        me->GetMotionMaster()->MoveTargetedHome();

        // xinef: do not forget to reset scripts as we wont call reached home
        if (!me->HasUnitState(UNIT_STATE_EVADE))
            GetScript()->OnReset();
    }
}

void SmartAI::MoveInLineOfSight(Unit* who)
{
    if (!who)
        return;

    GetScript()->OnMoveInLineOfSight(who);

    if (!IsAIControlled())
        return;

    if (me->GetVictim())
        return;

    if (me->HasReactState(REACT_PASSIVE) || AssistPlayerInCombatAgainst(who))
        return;

    if (me->HasReactState(REACT_AGGRESSIVE) && me->CanStartAttack(who))
    {
        if (me->HasUnitState(UNIT_STATE_DISTRACTED))
        {
            me->ClearUnitState(UNIT_STATE_DISTRACTED);
            me->GetMotionMaster()->Clear();
        }
        AttackStart(who);
    }
}

bool SmartAI::CanAIAttack(Unit const* /*who*/) const
{
    return !(me->GetReactState() == REACT_PASSIVE);
}

bool SmartAI::AssistPlayerInCombatAgainst(Unit* who)
{
    if (!IsAIControlled())
        return false;

    // Xinef: if unit has no victim, or victim is player controlled thing
    if (!who->GetVictim() || who->GetCharmerOrOwnerOrOwnGUID().IsPlayer())
        return false;

    //experimental (unknown) flag not present
    if (!(me->GetCreatureTemplate()->type_flags & CREATURE_TYPE_FLAG_CAN_ASSIST))
        return false;

    // Xinef: victim of unit has to be a player controlled unit
    if (!who->GetVictim()->GetCharmerOrOwnerOrOwnGUID().IsPlayer())
        return false;

    // Xinef: Check if victim can be assisted
    if (!me->IsValidAssistTarget(who->GetVictim()))
        return false;

    //too far away and no free sight?
    if (me->IsWithinDistInMap(who, SMART_MAX_AID_DIST) && me->IsWithinLOSInMap(who))
    {
        AttackStart(who);
        return true;
    }

    return false;
}

void SmartAI::JustRespawned()
{
    mDespawnTime = 0;
    mDespawnState = 0;
    mEscortState = SMART_ESCORT_NONE;
    me->SetVisible(true);
    if (me->GetFaction() != me->GetCreatureTemplate()->faction)
        me->RestoreFaction();
    mJustReset = true;
    JustReachedHome();
    GetScript()->ProcessEventsFor(SMART_EVENT_RESPAWN);
    mFollowGuid.Clear();//do not reset follower on Reset(), we need it after combat evade
    mFollowDist = 0;
    mFollowAngle = 0;
    mFollowCredit = 0;
    mFollowArrivedTimer = 1000;
    mFollowArrivedEntry = 0;
    mFollowCreditType = 0;
    mFollowArrivedAlive = true;
    aiDataSet.clear();
}

void SmartAI::JustReachedHome()
{
    GetScript()->OnReset();

    if (!mJustReset)
    {
        GetScript()->ProcessEventsFor(SMART_EVENT_REACHED_HOME);

        if (!UpdateVictim() && me->GetMotionMaster()->GetCurrentMovementGeneratorType() == IDLE_MOTION_TYPE && me->GetWaypointPath())
            me->GetMotionMaster()->MoveWaypoint(me->GetWaypointPath(), true);
    }

    mJustReset = false;
}

void SmartAI::JustEngagedWith(Unit* enemy)
{
    // Xinef: Interrupt channeled spells
    if (IsAIControlled())
        me->InterruptSpell(CURRENT_CHANNELED_SPELL, true, true);
    GetScript()->ProcessEventsFor(SMART_EVENT_AGGRO, enemy);
}

void SmartAI::JustDied(Unit* killer)
{
    GetScript()->ProcessEventsFor(SMART_EVENT_DEATH, killer);
    if (HasEscortState(SMART_ESCORT_ESCORTING))
        EndPath(true);
}

void SmartAI::KilledUnit(Unit* victim)
{
    GetScript()->ProcessEventsFor(SMART_EVENT_KILL, victim);
}

void SmartAI::JustSummoned(Creature* creature)
{
    GetScript()->ProcessEventsFor(SMART_EVENT_SUMMONED_UNIT, creature);
    GetScript()->AddCreatureSummon(creature->GetGUID());
}

void SmartAI::SummonedCreatureDies(Creature* summon, Unit* /*killer*/)
{
    GetScript()->ProcessEventsFor(SMART_EVENT_SUMMONED_UNIT_DIES, summon);
}

void SmartAI::SummonedCreatureEvade(Creature* summon)
{
    GetScript()->ProcessEventsFor(SMART_EVENT_SUMMONED_UNIT_EVADE, summon);
}

void SmartAI::AttackStart(Unit* who)
{
    // xinef: dont allow charmed npcs to act on their own
    if (me->HasUnitFlag(UNIT_FLAG_POSSESSED))
    {
        if (who)
            me->Attack(who, mCanAutoAttack);
        return;
    }

    if (who && me->Attack(who, me->IsWithinMeleeRange(who) || _currentRangeMode))
    {
        if (!me->HasUnitState(UNIT_STATE_NO_COMBAT_MOVEMENT))
        {
            MovementGeneratorType type = me->GetMotionMaster()->GetMotionSlotType(MOTION_SLOT_ACTIVE);
            if (type == ESCORT_MOTION_TYPE || type == POINT_MOTION_TYPE)
            {
                me->GetMotionMaster()->MovementExpired();
                me->StopMoving();
                me->GetMotionMaster()->Clear(false);
            }

            me->GetMotionMaster()->MoveChase(who, _attackDistance);
        }
    }
}

void SmartAI::SpellHit(Unit* unit, SpellInfo const* spellInfo)
{
    GetScript()->ProcessEventsFor(SMART_EVENT_SPELLHIT, unit, 0, 0, false, spellInfo);
}

void SmartAI::SpellHitTarget(Unit* target, SpellInfo const* spellInfo)
{
    GetScript()->ProcessEventsFor(SMART_EVENT_SPELLHIT_TARGET, target, 0, 0, false, spellInfo);
}

void SmartAI::DamageTaken(Unit* doneBy, uint32& damage, DamageEffectType damagetype, SpellSchoolMask /*damageSchoolMask*/)
{
    if (doneBy)
        GetScript()->ProcessEventsFor(SMART_EVENT_DAMAGED, doneBy, damage);

    if (!IsAIControlled()) // don't allow players to use unkillable units
        return;

    // Xinef: skip nodamage type (eg. instakill effect)
    if (damagetype != NODAMAGE && mInvincibilityHpLevel && (damage >= me->GetHealth() - mInvincibilityHpLevel))
        damage = me->GetHealth() - mInvincibilityHpLevel; // damage should not be nullified, because of player damage req.
}

void SmartAI::HealReceived(Unit* doneBy, uint32& addhealth)
{
    GetScript()->ProcessEventsFor(SMART_EVENT_RECEIVE_HEAL, doneBy, addhealth);
}

void SmartAI::ReceiveEmote(Player* player, uint32 textEmote)
{
    GetScript()->ProcessEventsFor(SMART_EVENT_RECEIVE_EMOTE, player, textEmote);
}

void SmartAI::IsSummonedBy(WorldObject* summoner)
{
    GetScript()->ProcessEventsFor(SMART_EVENT_JUST_SUMMONED, summoner->ToUnit(), 0, 0, false, nullptr, summoner->ToGameObject());
}

void SmartAI::DamageDealt(Unit* doneTo, uint32& damage, DamageEffectType /*damagetype*/, SpellSchoolMask /*damageSchoolMask*/)
{
    GetScript()->ProcessEventsFor(SMART_EVENT_DAMAGED_TARGET, doneTo, damage);
}

void SmartAI::SummonedCreatureDespawn(Creature* unit)
{
    GetScript()->ProcessEventsFor(SMART_EVENT_SUMMON_DESPAWNED, unit);
    GetScript()->RemoveCreatureSummon(unit->GetGUID());
}

void SmartAI::CorpseRemoved(uint32& respawnDelay)
{
    GetScript()->ProcessEventsFor(SMART_EVENT_CORPSE_REMOVED, nullptr, respawnDelay);

    // xinef: end escort upon corpse remove, safe check in case of immediate despawn
    if (IsEscorted())
        EndPath(true);
}

void SmartAI::PassengerBoarded(Unit* who, int8 seatId, bool apply)
{
    GetScript()->ProcessEventsFor(apply ? SMART_EVENT_PASSENGER_BOARDED : SMART_EVENT_PASSENGER_REMOVED, who, uint32(seatId), 0, apply);
}

void SmartAI::InitializeAI()
{
    GetScript()->OnInitialize(me);

    for (SmartScriptHolder const& event : GetScript()->GetEvents())
    {
        if (event.GetActionType() != SMART_ACTION_CAST)
            continue;

        if (!(event.action.cast.castFlags & SMARTCAST_MAIN_SPELL))
            continue;

        SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(event.action.cast.spell);
        if (spellInfo && spellInfo->IsPositive())
        {
            LOG_WARN("scripts.ai", "SmartAI: Creature {} has SMARTCAST_MAIN_SPELL on positive spell {} - positive spells should not be used as main spell",
                me->GetEntry(), event.action.cast.spell);
            continue;
        }

        SetMainSpell(event.action.cast.spell);
        break;
    }

    // Fallback: use first SMARTCAST_COMBAT_MOVE if no MAIN_SPELL found
    if (!_currentRangeMode)
    {
        for (SmartScriptHolder const& event : GetScript()->GetEvents())
        {
            if (event.GetActionType() != SMART_ACTION_CAST)
                continue;

            if (!(event.action.cast.castFlags & SMARTCAST_COMBAT_MOVE))
                continue;

            // Don't use positive (healing/buff) spells to determine attack distance
            SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(event.action.cast.spell);
            if (spellInfo && spellInfo->IsPositive())
                continue;

            SetMainSpell(event.action.cast.spell);
            break;
        }
    }

    if (!me->isDead())
    {
        mJustReset = true;
        JustReachedHome();
        GetScript()->ProcessEventsFor(SMART_EVENT_RESPAWN);
    }
}

void SmartAI::OnCharmed(bool /* apply */)
{
    bool const charmed = me->IsCharmed();
    if (charmed) // do this before we change charmed state, as charmed state might prevent these things from processing
    {
        if (HasEscortState(SMART_ESCORT_ESCORTING | SMART_ESCORT_PAUSED | SMART_ESCORT_RETURNING))
            EndPath(true);
    }

    mIsCharmed = charmed;

    if (!charmed && !me->IsInEvadeMode())
    {
        if (mCanRepeatPath)
            StartPath(mForcedMovement, GetScript()->GetPathId(), true);

        if (Unit* charmer = me->GetCharmer())
            AttackStart(charmer);
    }

    GetScript()->ProcessEventsFor(SMART_EVENT_CHARMED, nullptr, 0, 0, charmed);
}

void SmartAI::DoAction(int32 param)
{
    GetScript()->ProcessEventsFor(SMART_EVENT_ACTION_DONE, nullptr, param);
}

uint32 SmartAI::GetData(uint32 id) const
{
    auto const& itr = aiDataSet.find(id);
    if (itr != aiDataSet.end())
        return itr->second;

    return 0;
}

void SmartAI::SetData(uint32 id, uint32 value, WorldObject* invoker)
{
    Unit* unit = nullptr;
    GameObject* gob = nullptr;

    if (invoker)
    {
        unit = invoker->ToUnit();
        if (!unit)
            gob = invoker->ToGameObject();
    }

    aiDataSet[id] = value;
    GetScript()->ProcessEventsFor(SMART_EVENT_DATA_SET, unit, id, value, false, nullptr, gob);
}

void SmartAI::SetGUID(ObjectGuid const& /*guid*/, int32 /*id*/)
{
}

ObjectGuid SmartAI::GetGUID(int32 /*id*/) const
{
    return ObjectGuid::Empty;
}

void SmartAI::SetFly(bool fly)
{
    // xinef: set proper flag!
    //me->SetDisableGravity(fly);
    me->SetCanFly(fly);
}

void SmartAI::SetSwim(bool swim)
{
    me->SetSwim(swim);
}

void SmartAI::SetEvadeDisabled(bool disable)
{
    mEvadeDisabled = disable;
}

void SmartAI::sGossipHello(Player* player)
{
    GetScript()->ProcessEventsFor(SMART_EVENT_GOSSIP_HELLO, player);
}

void SmartAI::sGossipSelect(Player* player, uint32 sender, uint32 action)
{
    GetScript()->ProcessEventsFor(SMART_EVENT_GOSSIP_SELECT, player, sender, action);
}

void SmartAI::sGossipSelectCode(Player* /*player*/, uint32 /*sender*/, uint32 /*action*/, const char* /*code*/)
{
}

void SmartAI::sQuestAccept(Player* player, Quest const* quest)
{
    GetScript()->ProcessEventsFor(SMART_EVENT_ACCEPTED_QUEST, player, quest->GetQuestId());
}

void SmartAI::sQuestReward(Player* player, Quest const* quest, uint32 opt)
{
    GetScript()->ProcessEventsFor(SMART_EVENT_REWARD_QUEST, player, quest->GetQuestId(), opt);
}

void SmartAI::SetCombatMovement(bool on, bool stopOrStartMovement)
{
    if (on)
        me->ClearUnitState(UNIT_STATE_NO_COMBAT_MOVEMENT);
    else
        me->AddUnitState(UNIT_STATE_NO_COMBAT_MOVEMENT);

    if (!IsAIControlled() || HasEscortState(SMART_ESCORT_ESCORTING))
        return;

    if (stopOrStartMovement && me->GetVictim()) // Only change current movement while in combat
    {
        if (!me->IsCrowdControlled())
        {
            if (on)
                me->GetMotionMaster()->MoveChase(me->GetVictim());
            else if (me->GetMotionMaster()->GetCurrentMovementGeneratorType() == CHASE_MOTION_TYPE)
                me->StopMoving();
        }
    }
}

void SmartAI::SetCurrentRangeMode(bool on, float range)
{
    _currentRangeMode = on;
    _attackDistance = range;

    if (Unit* victim = me->GetVictim())
        me->GetMotionMaster()->MoveChase(victim, _attackDistance);
}

void SmartAI::SetMainSpell(uint32 spellId)
{
    SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(spellId);
    if (!spellInfo)
        return;

    float maxRange = spellInfo->GetMaxRange(false);
    if (maxRange <= NOMINAL_MELEE_RANGE)
        return;

    _mainSpellId = spellId;
    _attackDistance = std::max(maxRange - NOMINAL_MELEE_RANGE, 0.0f);
    _currentRangeMode = true;
}

void SmartAI::DistanceYourself(float range)
{
    Unit* victim = me->GetVictim();
    if (!victim || !victim->IsWithinMeleeRange(me))
        return;

    float combatReach = me->GetMeleeRange(victim);
    float distance = DISTANCING_CONSTANT + std::max(combatReach * 1.5f, combatReach + range);
    me->GetMotionMaster()->DistanceYourself(distance);
    _pendingDistancing = distance;
}

void SmartAI::SetFollow(Unit* target, float dist, float angle, uint32 credit, uint32 end, uint32 creditType, bool aliveState)
{
    if (!target)
    {
        StopFollow(false);
        return;
    }

    mFollowGuid = target->GetGUID();
    mFollowDist = dist;
    mFollowAngle = angle;
    mFollowArrivedTimer = 1000;
    mFollowCredit = credit;
    mFollowArrivedEntry = end;
    mFollowArrivedAlive = !aliveState; // negate - 0 is alive
    mFollowCreditType = creditType;
    me->GetMotionMaster()->MoveFollow(target, mFollowDist, mFollowAngle);
}

void SmartAI::StopFollow(bool complete)
{
    mFollowGuid.Clear();
    mFollowDist = 0;
    mFollowAngle = 0;
    mFollowCredit = 0;
    mFollowArrivedTimer = 1000;
    mFollowArrivedEntry = 0;
    mFollowCreditType = 0;

    me->GetMotionMaster()->Clear(false);
    me->StopMoving();
    me->GetMotionMaster()->MoveIdle();

    if (!complete)
        return;

    Player* player = ObjectAccessor::GetPlayer(*me, mFollowGuid);
    if (player)
    {
        if (!mFollowCreditType)
            player->RewardPlayerAndGroupAtEvent(mFollowCredit, me);
        else
            player->GroupEventHappens(mFollowCredit, me);
    }

    SetDespawnTime(5000);
    StartDespawn();

    GetScript()->ProcessEventsFor(SMART_EVENT_FOLLOW_COMPLETED, player);
}

void SmartAI::SetScript9(SmartScriptHolder& e, uint32 entry, WorldObject* invoker)
{
    if (invoker)
        GetScript()->mLastInvoker = invoker->GetGUID();
    GetScript()->SetScript9(e, entry);
}

void SmartAI::sOnGameEvent(bool start, uint16 eventId)
{
    GetScript()->ProcessEventsFor(start ? SMART_EVENT_GAME_EVENT_START : SMART_EVENT_GAME_EVENT_END, nullptr, eventId);
}

void SmartAI::OnSpellClick(Unit* clicker, bool&  /*result*/)
{
    // Xinef: i dont think this is necessery (can be made as event parameter)
    //if (!result)
    //    return;

    GetScript()->ProcessEventsFor(SMART_EVENT_ON_SPELLCLICK, clicker);
}

void SmartAI::PathEndReached(uint32 /*pathId*/)
{
    GetScript()->ProcessEventsFor(SMART_EVENT_WAYPOINT_ENDED, nullptr, 0, me->GetWaypointPath());
    me->LoadPath(0);
}

void SmartAI::DistancingEnded()
{
    SetCurrentRangeMode(true, _pendingDistancing);
    _pendingDistancing = 0.f;
}

bool SmartAI::IsMainSpellPrevented(SpellInfo const* spellInfo) const
{
    if (me->HasSpellCooldown(spellInfo->Id))
        return true;

    if (spellInfo->PreventionType == SPELL_PREVENTION_TYPE_SILENCE && me->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_SILENCED))
        return true;
    if (spellInfo->PreventionType == SPELL_PREVENTION_TYPE_PACIFY && me->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_PACIFIED))
        return true;

    return false;
}

void SmartAI::OnSpellCastFinished(SpellInfo const* spell, SpellFinishReason reason)
{
    CreatureAI::OnSpellCastFinished(spell, reason);
    if (reason == SPELL_FINISHED_CANCELED && _mainSpellId == spell->Id)
        if (_currentRangeMode && IsMainSpellPrevented(spell))
            SetCurrentRangeMode(false);
}

void SmartGameObjectAI::SummonedCreatureDies(Creature* summon, Unit* /*killer*/)
{
    GetScript()->ProcessEventsFor(SMART_EVENT_SUMMONED_UNIT_DIES, summon);
}

void SmartGameObjectAI::SummonedCreatureEvade(Creature* summon)
{
    GetScript()->ProcessEventsFor(SMART_EVENT_SUMMONED_UNIT_EVADE, summon);
}

void SmartGameObjectAI::UpdateAI(uint32 diff)
{
    GetScript()->OnUpdate(diff);
}

void SmartGameObjectAI::InitializeAI()
{
    GetScript()->OnInitialize(me);

    // Xinef: do not call respawn event if go is not spawned
    if (me->isSpawned())
        GetScript()->ProcessEventsFor(SMART_EVENT_RESPAWN);
    //Reset();
}

void SmartGameObjectAI::Reset()
{
    // Xinef: call respawn event on reset
    GetScript()->ProcessEventsFor(SMART_EVENT_RESPAWN);

    GetScript()->OnReset();
}

// Called when a player opens a gossip dialog with the gameobject.
bool SmartGameObjectAI::GossipHello(Player* player, bool reportUse)
{
    LOG_DEBUG("sql.sql", "SmartGameObjectAI::GossipHello");
    GetScript()->ProcessEventsFor(SMART_EVENT_GOSSIP_HELLO, player, (uint32)reportUse, 0, false, nullptr, me);
    return false;
}

// Called when a player selects a gossip item in the gameobject's gossip menu.
bool SmartGameObjectAI::GossipSelect(Player* player, uint32 sender, uint32 action)
{
    GetScript()->ProcessEventsFor(SMART_EVENT_GOSSIP_SELECT, player, sender, action, false, nullptr, me);
    return false;
}

// Called when a player selects a gossip with a code in the gameobject's gossip menu.
bool SmartGameObjectAI::GossipSelectCode(Player* /*player*/, uint32 /*sender*/, uint32 /*action*/, const char* /*code*/)
{
    return false;
}

// Called when a player accepts a quest from the gameobject.
bool SmartGameObjectAI::QuestAccept(Player* player, Quest const* quest)
{
    GetScript()->ProcessEventsFor(SMART_EVENT_ACCEPTED_QUEST, player, quest->GetQuestId(), 0, false, nullptr, me);
    return false;
}

// Called when a player selects a quest reward.
bool SmartGameObjectAI::QuestReward(Player* player, Quest const* quest, uint32 opt)
{
    GetScript()->ProcessEventsFor(SMART_EVENT_REWARD_QUEST, player, quest->GetQuestId(), opt, false, nullptr, me);
    return false;
}

// Called when the gameobject is destroyed (destructible buildings only).
void SmartGameObjectAI::Destroyed(Player* player, uint32 eventId)
{
    GetScript()->ProcessEventsFor(SMART_EVENT_DEATH, player, eventId, 0, false, nullptr, me);
}

void SmartGameObjectAI::SetData(uint32 id, uint32 value, WorldObject* invoker)
{
    Unit* unit = nullptr;
    GameObject* gob = nullptr;

    if (invoker)
    {
        unit = invoker->ToUnit();
        if (!unit)
            gob = invoker->ToGameObject();
    }

    GetScript()->ProcessEventsFor(SMART_EVENT_DATA_SET, unit, id, value, false, nullptr, gob);
}

void SmartGameObjectAI::SetScript9(SmartScriptHolder& e, uint32 entry, WorldObject* invoker)
{
    if (invoker)
        GetScript()->mLastInvoker = invoker->GetGUID();
    GetScript()->SetScript9(e, entry);
}

void SmartGameObjectAI::OnGameEvent(bool start, uint16 eventId)
{
    GetScript()->ProcessEventsFor(start ? SMART_EVENT_GAME_EVENT_START : SMART_EVENT_GAME_EVENT_END, nullptr, eventId);
}

void SmartGameObjectAI::OnStateChanged(uint32 state, Unit* unit)
{
    GetScript()->ProcessEventsFor(SMART_EVENT_GO_STATE_CHANGED, unit, state);
}

void SmartGameObjectAI::EventInform(uint32 eventId)
{
    GetScript()->ProcessEventsFor(SMART_EVENT_GO_EVENT_INFORM, nullptr, eventId);
}

void SmartGameObjectAI::SpellHit(Unit* unit, SpellInfo const* spellInfo)
{
    GetScript()->ProcessEventsFor(SMART_EVENT_SPELLHIT, unit, 0, 0, false, spellInfo);
}

void SmartGameObjectAI::JustSummoned(Creature* creature)
{
    GetScript()->ProcessEventsFor(SMART_EVENT_SUMMONED_UNIT, creature);
}

void SmartGameObjectAI::SummonedCreatureDespawn(Creature* unit)
{
    GetScript()->ProcessEventsFor(SMART_EVENT_SUMMON_DESPAWNED, unit, unit->GetEntry());
}

class SmartTrigger : public AreaTriggerScript
{
public:
    SmartTrigger() : AreaTriggerScript("SmartTrigger") {}

    bool OnTrigger(Player* player, AreaTrigger const* trigger) override
    {
        if (!player->IsAlive())
            return false;

        LOG_DEBUG("sql.sql", "AreaTrigger {} is using SmartTrigger script", trigger->entry);
        SmartScript script;
        script.OnInitialize(nullptr, trigger);
        script.ProcessEventsFor(SMART_EVENT_AREATRIGGER_ONTRIGGER, player, trigger->entry);
        return true;
    }
};

void AddSC_SmartScripts()
{
    new SmartTrigger();
}

/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include "DatabaseEnv.h"
#include "ObjectMgr.h"
#include "ObjectDefines.h"
#include "GridDefines.h"
#include "GridNotifiers.h"
#include "SpellMgr.h"
#include "GridNotifiersImpl.h"
#include "Cell.h"
#include "CellImpl.h"
#include "InstanceScript.h"
#include "ScriptedCreature.h"
#include "Group.h"
#include "SmartAI.h"
#include "ScriptMgr.h"
#include "Vehicle.h"

SmartAI::SmartAI(Creature* c) : CreatureAI(c)
{
    // copy script to local (protection for table reload)

    mWayPoints = NULL;
    mEscortState = SMART_ESCORT_NONE;
    mCurrentWPID = 0;//first wp id is 1 !!
    mWPReached = false;
    mOOCReached = false;
    mWPPauseTimer = 0;
    mLastWP = NULL;
    mEscortNPCFlags = 0;

    mCanRepeatPath = false;

    // spawn in run mode
    // Xinef: spawn in run mode and set mRun to run... this overrides SetWalk EVERYWHERE, RETARDS
    mRun = true;

    mCanAutoAttack = true;
    mCanCombatMove = true;

    mForcedPaused = false;

    mEscortQuestID = 0;

    mDespawnTime = 0;
    mDespawnState = 0;

    mEscortInvokerCheckTimer = 1000;
    mFollowGuid = 0;
    mFollowDist = 0;
    mFollowAngle = 0;
    mFollowCredit = 0;
    mFollowArrivedEntry = 0;
    mFollowCreditType = 0;
    mFollowArrivedAlive = 0;
    mFollowArrivedTimer = 0;
    mInvincibilityHpLevel = 0;

    mJustReset = false;

    // Xinef: Vehicle conditions
    m_ConditionsTimer = 0;
    if (me->GetVehicleKit())
        conditions = sConditionMgr->GetConditionsForNotGroupedEntry(CONDITION_SOURCE_TYPE_CREATURE_TEMPLATE_VEHICLE, me->GetEntry());
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

WayPoint* SmartAI::GetNextWayPoint()
{
    if (!mWayPoints || mWayPoints->empty())
        return NULL;

    mCurrentWPID++;
    WPPath::const_iterator itr = mWayPoints->find(mCurrentWPID);
    if (itr != mWayPoints->end())
    {
        mLastWP = (*itr).second;
        if (mLastWP->id != mCurrentWPID)
            sLog->outError("SmartAI::GetNextWayPoint: Got not expected waypoint id %u, expected %u", mLastWP->id, mCurrentWPID);

        return (*itr).second;
    }
    return NULL;
}

void SmartAI::GenerateWayPointArray(Movement::PointsArray* points)
{
    if (!mWayPoints || mWayPoints->empty())
        return;

    // Flying unit, just fill array
    if (me->m_movementInfo.HasMovementFlag((MovementFlags)(MOVEMENTFLAG_CAN_FLY|MOVEMENTFLAG_DISABLE_GRAVITY)))
    {
        // xinef: first point in vector is unit real position
        points->clear();
        points->push_back(G3D::Vector3(me->GetPositionX(), me->GetPositionY(), me->GetPositionZ()));
        uint32 wpCounter = mCurrentWPID;
        WPPath::const_iterator itr;
        while ((itr = mWayPoints->find(wpCounter++)) != mWayPoints->end())
        {
            WayPoint* wp = (*itr).second;
            points->push_back(G3D::Vector3(wp->x, wp->y, wp->z));
        }
    }
    else
    {
        for (float size = 1.0f; size; size *= 0.5f)
        {
            std::vector<G3D::Vector3> pVector;
            // xinef: first point in vector is unit real position
            pVector.push_back(G3D::Vector3(me->GetPositionX(), me->GetPositionY(), me->GetPositionZ()));
            uint32 length = (mWayPoints->size() - mCurrentWPID)*size;

            uint32 cnt = 0;
            uint32 wpCounter = mCurrentWPID;
            WPPath::const_iterator itr;
            while ((itr = mWayPoints->find(wpCounter++)) != mWayPoints->end() && cnt++ <= length)
            {
                WayPoint* wp = (*itr).second;
                pVector.push_back(G3D::Vector3(wp->x, wp->y, wp->z));
            }

            if (pVector.size() > 2) // more than source + dest
            {
                G3D::Vector3 middle = (pVector[0] + pVector[pVector.size()-1]) / 2.f;
                G3D::Vector3 offset;

                bool continueLoop = false;
                for (uint32 i = 1; i < pVector.size()-1; ++i)
                {
                    offset = middle - pVector[i];
                    if (fabs(offset.x) >= 0xFF || fabs(offset.y) >= 0xFF || fabs(offset.z) >= 0x7F)
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

void SmartAI::StartPath(bool run, uint32 path, bool repeat, Unit* invoker)
{
    if (me->IsInCombat())// no wp movement in combat
    {
        sLog->outError("SmartAI::StartPath: Creature entry %u wanted to start waypoint movement while in combat, ignoring.", me->GetEntry());
        return;
    }

    if (HasEscortState(SMART_ESCORT_ESCORTING))
        StopPath();

    if (path)
    {
        if (!LoadPath(path))
            return;
    }

    if (!mWayPoints || mWayPoints->empty())
        return;

    if (WayPoint* wp = GetNextWayPoint())
    {
        AddEscortState(SMART_ESCORT_ESCORTING);
        mCanRepeatPath = repeat;
        SetRun(run);

        if (invoker && invoker->GetTypeId() == TYPEID_PLAYER)
        {
            mEscortNPCFlags = me->GetUInt32Value(UNIT_NPC_FLAGS);
            me->SetUInt32Value(UNIT_NPC_FLAGS, 0);
        }

        Movement::PointsArray pathPoints;
        GenerateWayPointArray(&pathPoints);

        me->GetMotionMaster()->MoveSplinePath(&pathPoints);
        GetScript()->ProcessEventsFor(SMART_EVENT_WAYPOINT_START, NULL, wp->id, GetScript()->GetPathId());
    }
}

bool SmartAI::LoadPath(uint32 entry)
{
    if (HasEscortState(SMART_ESCORT_ESCORTING))
        return false;

    mWayPoints = sSmartWaypointMgr->GetPath(entry);
    if (!mWayPoints)
    {
        GetScript()->SetPathId(0);
        return false;
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
        sLog->outError("SmartAI::StartPath: Creature entry %u wanted to pause waypoint movement while already paused, ignoring.", me->GetEntry());
        return;
    }

    AddEscortState(SMART_ESCORT_PAUSED);
    mWPPauseTimer = delay;
    if (forced && !mWPReached)
    {
        mForcedPaused = forced;
        SetRun(mRun);
        if (me->GetMotionMaster()->GetMotionSlotType(MOTION_SLOT_ACTIVE) == ESCORT_MOTION_TYPE)
            me->GetMotionMaster()->MovementExpired();

        me->StopMoving();
        me->GetMotionMaster()->MoveIdle();//force stop
    }
    GetScript()->ProcessEventsFor(SMART_EVENT_WAYPOINT_PAUSED, NULL, mCurrentWPID, GetScript()->GetPathId());
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
    GetScript()->ProcessEventsFor(SMART_EVENT_WAYPOINT_STOPPED, NULL, mCurrentWPID, GetScript()->GetPathId());
    EndPath(fail);
}

void SmartAI::EndPath(bool fail)
{
    RemoveEscortState(SMART_ESCORT_ESCORTING | SMART_ESCORT_PAUSED | SMART_ESCORT_RETURNING);
    mWayPoints = NULL;
    mLastWP = NULL;
    mWPPauseTimer = 0;

    if (mEscortNPCFlags)
    {
        me->SetUInt32Value(UNIT_NPC_FLAGS, mEscortNPCFlags);
        mEscortNPCFlags = 0;
    }

    ObjectList* targets = GetScript()->GetTargetList(SMART_ESCORT_TARGETS);
    if (targets && mEscortQuestID)
    {
        if (targets->size() == 1 && GetScript()->IsPlayer((*targets->begin())))
        {
            Player* player = (*targets->begin())->ToPlayer();
            if (Group* group = player->GetGroup())
            {
                for (GroupReference* groupRef = group->GetFirstMember(); groupRef != NULL; groupRef = groupRef->next())
                {
                    Player* groupGuy = groupRef->GetSource();
                    if (!groupGuy || !player->IsInMap(groupGuy))
                        continue;

                    if (!fail && groupGuy->IsAtGroupRewardDistance(me) && !groupGuy->GetCorpse())
                        groupGuy->AreaExploredOrEventHappens(mEscortQuestID);
                    else if (fail && groupGuy->GetQuestStatus(mEscortQuestID) == QUEST_STATUS_INCOMPLETE)
                        groupGuy->FailQuest(mEscortQuestID);
                }
            }
            else
            {
                if (!fail && player->IsAtGroupRewardDistance(me) && !player->GetCorpse())
                    player->GroupEventHappens(mEscortQuestID, me);
                else if (fail && player->GetQuestStatus(mEscortQuestID) == QUEST_STATUS_INCOMPLETE)
                    player->FailQuest(mEscortQuestID);
            }
        }
        else
        {
            for (ObjectList::iterator iter = targets->begin(); iter != targets->end(); ++iter)
            {
                if (GetScript()->IsPlayer((*iter)))
                {
                    Player* player = (*iter)->ToPlayer();
                    if (!fail && player->IsAtGroupRewardDistance(me) && !player->GetCorpse())
                        player->AreaExploredOrEventHappens(mEscortQuestID);
                    else if (fail && player->GetQuestStatus(mEscortQuestID) == QUEST_STATUS_INCOMPLETE)
                        player->FailQuest(mEscortQuestID);
                }
            }
        }
    }

    // Xinef: if the escort failed - DO NOT PROCESS ANYTHING, ITS RETARDED
    // Xinef: End Path events should be only processed if it was SUCCESSFUL stop or stop called by SMART_ACTION_WAYPOINT_STOP
    if (fail)
    {
        mCurrentWPID = 0;
        return;
    }

    GetScript()->ProcessEventsFor(SMART_EVENT_WAYPOINT_ENDED, NULL, mCurrentWPID, GetScript()->GetPathId());
    mCurrentWPID = 0;

    if (mCanRepeatPath)
        StartPath(mRun, GetScript()->GetPathId(), mCanRepeatPath);
    else
        GetScript()->SetPathId(0);

    if (mDespawnState == 1)
        StartDespawn();
}

void SmartAI::ResumePath()
{
    SetRun(mRun);

    if (mLastWP)
    {
        Movement::PointsArray pathPoints;
        GenerateWayPointArray(&pathPoints);

        me->GetMotionMaster()->MoveSplinePath(&pathPoints);
    }
}

void SmartAI::ReturnToLastOOCPos()
{
    me->SetWalk(false);
    float x, y, z, o;
    me->GetHomePosition(x, y, z, o);
    me->GetMotionMaster()->MovePoint(SMART_ESCORT_LAST_OOC_POINT, x, y, z);
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
            me->DespawnOrUnsummon(1);
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
                GetScript()->ProcessEventsFor(SMART_EVENT_WAYPOINT_RESUMED, NULL, mCurrentWPID, GetScript()->GetPathId());
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
            SetRun(mRun);
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

    if (!UpdateVictim())
        return;

    if (mCanAutoAttack)
        DoMeleeAttackIfReady();
}

bool SmartAI::IsEscortInvokerInRange()
{
    ObjectList* targets = GetScript()->GetTargetList(SMART_ESCORT_TARGETS);
    if (targets)
    {
        float checkDist = me->GetInstanceScript() ? SMART_ESCORT_MAX_PLAYER_DIST*2 : SMART_ESCORT_MAX_PLAYER_DIST;
        if (targets->size() == 1 && GetScript()->IsPlayer((*targets->begin())))
        {
            Player* player = (*targets->begin())->ToPlayer();
            if (me->GetDistance(player) <= checkDist)
                return true;

            if (Group* group = player->GetGroup())
            {
                for (GroupReference* groupRef = group->GetFirstMember(); groupRef != NULL; groupRef = groupRef->next())
                {
                    Player* groupGuy = groupRef->GetSource();

                    if (groupGuy && me->IsInMap(groupGuy) && me->GetDistance(groupGuy) <= checkDist)
                        return true;
                }
            }
        }
        else
        {
            for (ObjectList::iterator iter = targets->begin(); iter != targets->end(); ++iter)
            {
                if (GetScript()->IsPlayer((*iter)))
                {
                    if (me->GetDistance((*iter)->ToPlayer()) <= checkDist)
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
    GetScript()->ProcessEventsFor(SMART_EVENT_WAYPOINT_REACHED, NULL, mCurrentWPID);

    if (mLastWP)
    {
        me->SetPosition(mLastWP->x, mLastWP->y, mLastWP->z, me->GetOrientation());
        me->SetHomePosition(me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), me->GetOrientation());
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
            SetRun(mRun);
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

    GetScript()->ProcessEventsFor(SMART_EVENT_MOVEMENTINFORM, NULL, MovementType, Data);
    if (!HasEscortState(SMART_ESCORT_ESCORTING))
        return;

    if (MovementType == ESCORT_MOTION_TYPE || (MovementType == POINT_MOTION_TYPE && Data == SMART_ESCORT_LAST_OOC_POINT))
        MovepointReached(Data);
}

void SmartAI::EnterEvadeMode()
{
    // xinef: fixes strange jumps when charming SmartAI npc
    if (!me->IsAlive() || me->IsInEvadeMode())
        return;
    
    if (IS_PLAYER_GUID(me->GetCharmerGUID()) || me->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_PLAYER_CONTROLLED))
    {
        me->AttackStop();
        return;
    }

    me->RemoveEvadeAuras();

    me->AddUnitState(UNIT_STATE_EVADE);
    me->DeleteThreatList();
    me->CombatStop(true);
    me->LoadCreaturesAddon(true);
    me->SetLootRecipient(NULL);
    me->ResetPlayerDamageReq();
    me->SetLastDamagedTime(0);

    GetScript()->ProcessEventsFor(SMART_EVENT_EVADE);//must be after aura clear so we can cast spells from db

    SetRun(mRun);
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

    if (me->GetVictim())
        return;

    if (me->HasReactState(REACT_PASSIVE) || AssistPlayerInCombat(who))
        return;

    if (me->CanStartAttack(who))
    {
        if (me->HasUnitState(UNIT_STATE_DISTRACTED))
        {
            me->ClearUnitState(UNIT_STATE_DISTRACTED);
            me->GetMotionMaster()->Clear();
        }
        AttackStart(who);
    }
}

bool SmartAI::CanAIAttack(const Unit* /*who*/) const
{
    if (me->GetReactState() == REACT_PASSIVE)
        return false;
    return true;
}

bool SmartAI::AssistPlayerInCombat(Unit* who)
{
    // Xinef: if unit has no victim, or victim is player controlled thing
    if (!who->GetVictim() || IS_PLAYER_GUID(who->GetCharmerOrOwnerOrOwnGUID()))
        return false;

    //experimental (unknown) flag not present
    if (!(me->GetCreatureTemplate()->type_flags & CREATURE_TYPEFLAGS_AID_PLAYERS))
        return false;

    // Xinef: victim of unit has to be a player controlled unit
    if (!IS_PLAYER_GUID(who->GetVictim()->GetCharmerOrOwnerOrOwnGUID()))
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
    if (me->getFaction() != me->GetCreatureTemplate()->faction)
        me->RestoreFaction();
    mJustReset = true;
    JustReachedHome();
    GetScript()->ProcessEventsFor(SMART_EVENT_RESPAWN);
    mFollowGuid = 0;//do not reset follower on Reset(), we need it after combat evade
    mFollowDist = 0;
    mFollowAngle = 0;
    mFollowCredit = 0;
    mFollowArrivedTimer = 1000;
    mFollowArrivedEntry = 0;
    mFollowCreditType = 0;
    mFollowArrivedAlive = true;
}

int SmartAI::Permissible(const Creature* creature)
{
    if (creature->GetAIName() == "SmartAI")
        return PERMIT_BASE_SPECIAL;
    return PERMIT_BASE_NO;
}

void SmartAI::JustReachedHome()
{
    GetScript()->OnReset();

    if (!mJustReset)
    {
        GetScript()->ProcessEventsFor(SMART_EVENT_REACHED_HOME);

        if (!UpdateVictim() && me->GetMotionMaster()->GetCurrentMovementGeneratorType() == IDLE_MOTION_TYPE && me->GetWaypointPath())
            me->GetMotionMaster()->MovePath(me->GetWaypointPath(), true);
    }

    mJustReset = false;
}

void SmartAI::EnterCombat(Unit* enemy)
{
    // Xinef: Interrupt channeled spells
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
}

void SmartAI::AttackStart(Unit* who)
{
    // xinef: dont allow charmed npcs to act on their own
    if (me->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_PLAYER_CONTROLLED))
    {
        if (who && mCanAutoAttack)
            me->Attack(who, true);
        return;
    }

    if (who && me->Attack(who, me->IsWithinMeleeRange(who)))
    {
        if (mCanCombatMove || GetScript()->GetMaxCombatDist())
        {
            SetRun(mRun);
            MovementGeneratorType type = me->GetMotionMaster()->GetMotionSlotType(MOTION_SLOT_ACTIVE);
            if (type == ESCORT_MOTION_TYPE || type == POINT_MOTION_TYPE)
            {
                me->GetMotionMaster()->MovementExpired();
                me->StopMoving();
            }
            me->GetMotionMaster()->MoveChase(who, GetScript()->GetCasterActualDist() ? GetScript()->GetCasterActualDist() : GetScript()->GetActualCombatDist());
        }
    }
}

void SmartAI::SpellHit(Unit* unit, const SpellInfo* spellInfo)
{
    GetScript()->ProcessEventsFor(SMART_EVENT_SPELLHIT, unit, 0, 0, false, spellInfo);
}

void SmartAI::SpellHitTarget(Unit* target, const SpellInfo* spellInfo)
{
    GetScript()->ProcessEventsFor(SMART_EVENT_SPELLHIT_TARGET, target, 0, 0, false, spellInfo);
}

void SmartAI::DamageTaken(Unit* doneBy, uint32& damage, DamageEffectType damagetype, SpellSchoolMask /*damageSchoolMask*/)
{
    if (doneBy)
        GetScript()->ProcessEventsFor(SMART_EVENT_DAMAGED, doneBy, damage);

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

void SmartAI::IsSummonedBy(Unit* summoner)
{
    GetScript()->ProcessEventsFor(SMART_EVENT_JUST_SUMMONED, summoner);
}

void SmartAI::DamageDealt(Unit* doneTo, uint32& damage, DamageEffectType /*damagetype*/)
{
    GetScript()->ProcessEventsFor(SMART_EVENT_DAMAGED_TARGET, doneTo, damage);
}

void SmartAI::SummonedCreatureDespawn(Creature* unit)
{
    GetScript()->ProcessEventsFor(SMART_EVENT_SUMMON_DESPAWNED, unit);
}

void SmartAI::UpdateAIWhileCharmed(const uint32 /*diff*/)
{
}

void SmartAI::CorpseRemoved(uint32& respawnDelay)
{
    GetScript()->ProcessEventsFor(SMART_EVENT_CORPSE_REMOVED, NULL, respawnDelay);

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
    if (!me->isDead())
    {
        mJustReset = true;
        JustReachedHome();
        GetScript()->ProcessEventsFor(SMART_EVENT_RESPAWN);
    }
}

void SmartAI::OnCharmed(bool apply)
{
    GetScript()->ProcessEventsFor(SMART_EVENT_CHARMED, NULL, 0, 0, apply);
}

void SmartAI::DoAction(int32 param)
{
    GetScript()->ProcessEventsFor(SMART_EVENT_ACTION_DONE, NULL, param);
}

uint32 SmartAI::GetData(uint32 /*id*/) const
{
    return 0;
}

void SmartAI::SetData(uint32 id, uint32 value)
{
    GetScript()->ProcessEventsFor(SMART_EVENT_DATA_SET, NULL, id, value);
}

void SmartAI::SetGUID(uint64 /*guid*/, int32 /*id*/)
{
}

uint64 SmartAI::GetGUID(int32 /*id*/) const
{
    return 0;
}

void SmartAI::SetRun(bool run)
{
    me->SetWalk(!run);
    mRun = run;
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

void SmartAI::SetForcedCombatMove(float dist)
{
    if (!me->GetVictim())
        return;

    SetRun(mRun);
    me->GetMotionMaster()->MoveChase(me->GetVictim(), dist);
}

void SmartAI::SetCombatMove(bool on)
{
    // Xinef: Fix Combat Movement
    if (GetScript()->GetMaxCombatDist()/* || GetScript()->GetCasterMaxDist()*/) // Xinef: we only need this hack for old caster movement system
        return;

    if (mCanCombatMove == on)
        return;

    mCanCombatMove = on;
    if (!HasEscortState(SMART_ESCORT_ESCORTING))
    {
        if (on && me->GetVictim())
        {
            if (me->GetMotionMaster()->GetCurrentMovementGeneratorType() == IDLE_MOTION_TYPE)
            {
                SetRun(mRun);
                me->GetMotionMaster()->MoveChase(me->GetVictim());
                me->CastStop();
            }
        }
        else
        {
            me->StopMoving();
            if (me->GetMotionMaster()->GetCurrentMovementGeneratorType() == CHASE_MOTION_TYPE)
                me->GetMotionMaster()->Clear(false);
            me->GetMotionMaster()->MoveIdle();
        }
    }
}

void SmartAI::SetFollow(Unit* target, float dist, float angle, uint32 credit, uint32 end, uint32 creditType, bool aliveState)
{
    if (!target)
    {
        StopFollow(false);
        return;
    }

    SetRun(mRun);
    mFollowGuid = target->GetGUID();
    mFollowDist = dist;
    mFollowAngle = angle;
    mFollowArrivedTimer = 1000;
    mFollowCredit = credit;
    mFollowArrivedEntry = end;
    mFollowArrivedAlive = !aliveState; // negate - 0 is alive

    me->GetMotionMaster()->MoveFollow(target, mFollowDist, mFollowAngle);
    mFollowCreditType = creditType;
}

void SmartAI::StopFollow(bool complete)
{
    mFollowGuid = 0;
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

    if (Player* player = ObjectAccessor::GetPlayer(*me, mFollowGuid))
    {
        if (!mFollowCreditType)
            player->RewardPlayerAndGroupAtEvent(mFollowCredit, me);
        else
            player->GroupEventHappens(mFollowCredit, me);
    }

    SetDespawnTime(5000);
    StartDespawn();

    GetScript()->ProcessEventsFor(SMART_EVENT_FOLLOW_COMPLETED);
}

void SmartAI::SetScript9(SmartScriptHolder& e, uint32 entry, Unit* invoker)
{
    if (invoker)
        GetScript()->mLastInvoker = invoker->GetGUID();
    GetScript()->SetScript9(e, entry);
}

void SmartAI::sOnGameEvent(bool start, uint16 eventId)
{
    GetScript()->ProcessEventsFor(start ? SMART_EVENT_GAME_EVENT_START : SMART_EVENT_GAME_EVENT_END, NULL, eventId);
}

void SmartAI::OnSpellClick(Unit* clicker, bool&  /*result*/)
{
    // Xinef: i dont think this is necessery (can be made as event parameter)
    //if (!result)
    //    return;

    GetScript()->ProcessEventsFor(SMART_EVENT_ON_SPELLCLICK, clicker);
}

int SmartGameObjectAI::Permissible(const GameObject* g)
{
    if (g->GetAIName() == "SmartGameObjectAI")
        return PERMIT_BASE_SPECIAL;
    return PERMIT_BASE_NO;
}

void SmartGameObjectAI::UpdateAI(uint32 diff)
{
    GetScript()->OnUpdate(diff);
}

void SmartGameObjectAI::InitializeAI()
{
    GetScript()->OnInitialize(go);

    // Xinef: do not call respawn event if go is not spawned
    if (go->isSpawned())
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
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outDebug(LOG_FILTER_DATABASE_AI, "SmartGameObjectAI::GossipHello");
#endif
    GetScript()->ProcessEventsFor(SMART_EVENT_GOSSIP_HELLO, player, (uint32)reportUse, 0, false, NULL, go);
    return false;
}

// Called when a player selects a gossip item in the gameobject's gossip menu.
bool SmartGameObjectAI::GossipSelect(Player* player, uint32 sender, uint32 action)
{
    GetScript()->ProcessEventsFor(SMART_EVENT_GOSSIP_SELECT, player, sender, action, false, NULL, go);
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
    GetScript()->ProcessEventsFor(SMART_EVENT_ACCEPTED_QUEST, player, quest->GetQuestId(), 0, false, NULL, go);
    return false;
}

// Called when a player selects a quest reward.
bool SmartGameObjectAI::QuestReward(Player* player, Quest const* quest, uint32 opt)
{
    GetScript()->ProcessEventsFor(SMART_EVENT_REWARD_QUEST, player, quest->GetQuestId(), opt, false, NULL, go);
    return false;
}

// Called when the gameobject is destroyed (destructible buildings only).
void SmartGameObjectAI::Destroyed(Player* player, uint32 eventId)
{
    GetScript()->ProcessEventsFor(SMART_EVENT_DEATH, player, eventId, 0, false, NULL, go);
}

void SmartGameObjectAI::SetData(uint32 id, uint32 value)
{
    GetScript()->ProcessEventsFor(SMART_EVENT_DATA_SET, NULL, id, value);
}

void SmartGameObjectAI::SetScript9(SmartScriptHolder& e, uint32 entry, Unit* invoker)
{
    if (invoker)
        GetScript()->mLastInvoker = invoker->GetGUID();
    GetScript()->SetScript9(e, entry);
}

void SmartGameObjectAI::OnGameEvent(bool start, uint16 eventId)
{
    GetScript()->ProcessEventsFor(start ? SMART_EVENT_GAME_EVENT_START : SMART_EVENT_GAME_EVENT_END, NULL, eventId);
}

void SmartGameObjectAI::OnStateChanged(uint32 state, Unit* unit)
{
    GetScript()->ProcessEventsFor(SMART_EVENT_GO_STATE_CHANGED, unit, state);
}

void SmartGameObjectAI::EventInform(uint32 eventId)
{
    GetScript()->ProcessEventsFor(SMART_EVENT_GO_EVENT_INFORM, NULL, eventId);
}

void SmartGameObjectAI::SpellHit(Unit* unit, const SpellInfo* spellInfo)
{
    GetScript()->ProcessEventsFor(SMART_EVENT_SPELLHIT, unit, 0, 0, false, spellInfo);
}

class SmartTrigger : public AreaTriggerScript
{
    public:

        SmartTrigger() : AreaTriggerScript("SmartTrigger") {}

        bool OnTrigger(Player* player, AreaTrigger const* trigger)
        {
            if (!player->IsAlive())
                return false;

#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
            sLog->outDebug(LOG_FILTER_DATABASE_AI, "AreaTrigger %u is using SmartTrigger script", trigger->entry);
#endif
            SmartScript script;
            script.OnInitialize(NULL, trigger);
            script.ProcessEventsFor(SMART_EVENT_AREATRIGGER_ONTRIGGER, player, trigger->entry);
            return true;
        }
};

void AddSC_SmartScripts()
{
    new SmartTrigger();
}

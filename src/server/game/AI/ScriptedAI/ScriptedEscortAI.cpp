/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2006-2009 ScriptDev2 <https://scriptdev2.svn.sourceforge.net/>
 */

/* ScriptData
SDName: Npc_EscortAI
SD%Complete: 100
SDComment:
SDCategory: Npc
EndScriptData */

#include "ScriptedCreature.h"
#include "ScriptedEscortAI.h"
#include "Group.h"
#include "Player.h"

enum ePoints
{
    POINT_LAST_POINT    = 0xFFFFFF,
    POINT_HOME          = 0xFFFFFE
};

npc_escortAI::npc_escortAI(Creature* creature) : ScriptedAI(creature),
    m_uiPlayerGUID(0),
    m_uiWPWaitTimer(1000),
    m_uiPlayerCheckTimer(0),
    m_uiEscortState(STATE_ESCORT_NONE),
    MaxPlayerDistance(DEFAULT_MAX_PLAYER_DISTANCE),
    m_pQuestForEscort(NULL),
    m_bIsActiveAttacker(true),
    m_bIsRunning(false),
    m_bCanInstantRespawn(false),
    m_bCanReturnToStart(false),
    DespawnAtEnd(true),
    DespawnAtFar(true),
    ScriptWP(false),
    HasImmuneToNPCFlags(false)
{}

void npc_escortAI::AttackStart(Unit* who)
{
    if (!who)
        return;

    if (me->Attack(who, true))
    {
        MovementGeneratorType type = me->GetMotionMaster()->GetMotionSlotType(MOTION_SLOT_ACTIVE);
        if (type == ESCORT_MOTION_TYPE || type == POINT_MOTION_TYPE)
        {
            me->GetMotionMaster()->MovementExpired();
            //me->DisableSpline();
            me->StopMoving();
        }

        if (IsCombatMovementAllowed())
            me->GetMotionMaster()->MoveChase(who);
    }
}

//see followerAI
bool npc_escortAI::AssistPlayerInCombat(Unit* who)
{
    if (!who || !who->GetVictim())
        return false;

    //experimental (unknown) flag not present
    if (!(me->GetCreatureTemplate()->type_flags & CREATURE_TYPEFLAGS_AID_PLAYERS))
        return false;

    //not a player
    if (!who->GetVictim()->GetCharmerOrOwnerPlayerOrPlayerItself())
        return false;

    //never attack friendly
    if (!me->IsValidAttackTarget(who))
        return false;

    //too far away and no free sight?
    if (me->IsWithinDistInMap(who, GetMaxPlayerDistance()) && me->IsWithinLOSInMap(who))
    {
        AttackStart(who);
        return true;
    }

    return false;
}

void npc_escortAI::MoveInLineOfSight(Unit* who)
{
    if (me->GetVictim())
        return;

    if (!me->HasUnitState(UNIT_STATE_STUNNED) && who->isTargetableForAttack(true, me) && who->isInAccessiblePlaceFor(me))
        if (HasEscortState(STATE_ESCORT_ESCORTING) && AssistPlayerInCombat(who))
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

void npc_escortAI::JustDied(Unit* /*killer*/)
{
    if (!HasEscortState(STATE_ESCORT_ESCORTING) || !m_uiPlayerGUID || !m_pQuestForEscort)
        return;

    if (Player* player = GetPlayerForEscort())
    {
        if (Group* group = player->GetGroup())
        {
            for (GroupReference* groupRef = group->GetFirstMember(); groupRef != NULL; groupRef = groupRef->next())
                if (Player* member = groupRef->GetSource())
                    if (member->IsInMap(player) && member->GetQuestStatus(m_pQuestForEscort->GetQuestId()) == QUEST_STATUS_INCOMPLETE)
                        member->FailQuest(m_pQuestForEscort->GetQuestId());
        }
        else
        {
            if (player->GetQuestStatus(m_pQuestForEscort->GetQuestId()) == QUEST_STATUS_INCOMPLETE)
                player->FailQuest(m_pQuestForEscort->GetQuestId());
        }
    }
}

void npc_escortAI::JustRespawned()
{
    RemoveEscortState(STATE_ESCORT_ESCORTING|STATE_ESCORT_RETURNING|STATE_ESCORT_PAUSED);

    if (!IsCombatMovementAllowed())
        SetCombatMovement(true);

    //add a small delay before going to first waypoint, normal in near all cases
    m_uiWPWaitTimer = 1000;

    if (me->getFaction() != me->GetCreatureTemplate()->faction)
        me->RestoreFaction();

    Reset();
}

void npc_escortAI::ReturnToLastPoint()
{
    float x, y, z, o;
    me->SetWalk(false);
    me->GetHomePosition(x, y, z, o);
    me->GetMotionMaster()->MovePoint(POINT_LAST_POINT, x, y, z);
}

void npc_escortAI::EnterEvadeMode()
{
    me->RemoveAllAuras();
    me->DeleteThreatList();
    me->CombatStop(true);
    me->SetLootRecipient(NULL);

    if (HasEscortState(STATE_ESCORT_ESCORTING))
    {
        AddEscortState(STATE_ESCORT_RETURNING);
        ReturnToLastPoint();
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
        sLog->outDebug(LOG_FILTER_TSCR, "TSCR: EscortAI has left combat and is now returning to last point");
#endif
    }
    else
    {
        me->GetMotionMaster()->MoveTargetedHome();
        if (HasImmuneToNPCFlags)
            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_NPC);
        Reset();
    }
}

bool npc_escortAI::IsPlayerOrGroupInRange()
{
    if (Player* player = GetPlayerForEscort())
    {
        if (Group* group = player->GetGroup())
        {
            for (GroupReference* groupRef = group->GetFirstMember(); groupRef != NULL; groupRef = groupRef->next())
                if (Player* member = groupRef->GetSource())
                    if (me->IsWithinDistInMap(member, GetMaxPlayerDistance()))
                        return true;
        }
        else if (me->IsWithinDistInMap(player, GetMaxPlayerDistance()))
            return true;
    }

    return false;
}

void npc_escortAI::UpdateAI(uint32 diff)
{
    if (HasEscortState(STATE_ESCORT_ESCORTING) && !me->GetVictim() && m_uiWPWaitTimer && !HasEscortState(STATE_ESCORT_RETURNING))
    {
        if (m_uiWPWaitTimer <= diff)
        {
            if (CurrentWP == WaypointList.end())
            {
                if (DespawnAtEnd)
                {
                    if (m_bCanReturnToStart)
                    {
                        float fRetX, fRetY, fRetZ;
                        me->GetRespawnPosition(fRetX, fRetY, fRetZ);
                        me->GetMotionMaster()->MovePoint(POINT_HOME, fRetX, fRetY, fRetZ);

                        m_uiWPWaitTimer = 0;
                        return;
                    }

                    if (m_bCanInstantRespawn)
                    {
                        me->setDeathState(JUST_DIED);
                        me->Respawn();
                    }
                    else
                        me->DespawnOrUnsummon();
                }

                // xinef: remove escort state, escort was finished (lack of this line resulted in skipping UpdateEscortAI calls after finished escort)
                RemoveEscortState(STATE_ESCORT_ESCORTING);
                return;
            }

            if (!HasEscortState(STATE_ESCORT_PAUSED))
            {
                // xinef, start escort if there is no spline active
                if (me->movespline->Finalized())
                {
                    Movement::PointsArray pathPoints;
                    GenerateWaypointArray(&pathPoints);
                    me->GetMotionMaster()->MoveSplinePath(&pathPoints);
                }

                WaypointStart(CurrentWP->id);
                m_uiWPWaitTimer = 0;
            }
        }
        else
            m_uiWPWaitTimer -= diff;
    }

    //Check if player or any member of his group is within range
    if (HasEscortState(STATE_ESCORT_ESCORTING) && m_uiPlayerGUID && !me->GetVictim() && !HasEscortState(STATE_ESCORT_RETURNING))
    {
        m_uiPlayerCheckTimer += diff;
        if (m_uiPlayerCheckTimer > 1000)
        {
            if (DespawnAtFar && !IsPlayerOrGroupInRange())
            {
                if (m_bCanInstantRespawn)
                {
                    me->setDeathState(JUST_DIED);
                    me->Respawn();
                }
                else
                    me->DespawnOrUnsummon();

                return;
            }

            m_uiPlayerCheckTimer = 0;
        }
    }

    UpdateEscortAI(diff);
}

void npc_escortAI::UpdateEscortAI(uint32 /*diff*/)
{
    if (!UpdateVictim())
        return;

    DoMeleeAttackIfReady();
}

void npc_escortAI::MovementInform(uint32 moveType, uint32 pointId)
{
    // xinef: no action allowed if there is no escort
    if (!HasEscortState(STATE_ESCORT_ESCORTING))
        return;

    if (moveType == POINT_MOTION_TYPE)
    {
        //Combat start position reached, continue waypoint movement
        if (pointId == POINT_LAST_POINT)
        {
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
            sLog->outDebug(LOG_FILTER_TSCR, "TSCR: EscortAI has returned to original position before combat");
#endif

            me->SetWalk(!m_bIsRunning);
            RemoveEscortState(STATE_ESCORT_RETURNING);

            if (!m_uiWPWaitTimer)
                m_uiWPWaitTimer = 1;
        }
        else if (pointId == POINT_HOME)
        {
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
            sLog->outDebug(LOG_FILTER_TSCR, "TSCR: EscortAI has returned to original home location and will continue from beginning of waypoint list.");
#endif

            CurrentWP = WaypointList.begin();
            m_uiWPWaitTimer = 1;
        }
    }
    else if (moveType == ESCORT_MOTION_TYPE)
    {
        if (m_uiWPWaitTimer <= 1 && !HasEscortState(STATE_ESCORT_PAUSED) && CurrentWP != WaypointList.end())
        {
            //Call WP function
            me->SetPosition(CurrentWP->x, CurrentWP->y, CurrentWP->z, me->GetOrientation());
            me->SetHomePosition(me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), me->GetOrientation());
            WaypointReached(CurrentWP->id);

            m_uiWPWaitTimer = CurrentWP->WaitTimeMs + 1;

            ++CurrentWP;

            if (m_uiWPWaitTimer > 1 || HasEscortState(STATE_ESCORT_PAUSED))
            {
                if (me->GetMotionMaster()->GetMotionSlotType(MOTION_SLOT_ACTIVE) == ESCORT_MOTION_TYPE)
                    me->GetMotionMaster()->MovementExpired();
                me->StopMovingOnCurrentPos();
                me->GetMotionMaster()->MoveIdle();
            }
        }
    }
}

/*
void npc_escortAI::OnPossess(bool apply)
{
    // We got possessed in the middle of being escorted, store the point
    // where we left off to come back to when possess is removed
    if (HasEscortState(STATE_ESCORT_ESCORTING))
    {
        if (apply)
            me->GetPosition(LastPos.x, LastPos.y, LastPos.z);
        else
        {
            Returning = true;
            me->GetMotionMaster()->MovementExpired();
            me->GetMotionMaster()->MovePoint(WP_LAST_POINT, LastPos.x, LastPos.y, LastPos.z);
        }
    }
}
*/

void npc_escortAI::AddWaypoint(uint32 id, float x, float y, float z, uint32 waitTime)
{
    Escort_Waypoint t(id, x, y, z, waitTime);

    WaypointList.push_back(t);

    // i think SD2 no longer uses this function
    ScriptWP = true;
    /*PointMovement wp;
    wp.m_uiCreatureEntry = me->GetEntry();
    wp.m_uiPointId = id;
    wp.m_fX = x;
    wp.m_fY = y;
    wp.m_fZ = z;
    wp.m_uiWaitTime = WaitTimeMs;
    PointMovementMap[wp.m_uiCreatureEntry].push_back(wp);*/
}

void npc_escortAI::FillPointMovementListForCreature()
{
    ScriptPointVector const& movePoints = sScriptSystemMgr->GetPointMoveList(me->GetEntry());
    if (movePoints.empty())
        return;

    ScriptPointVector::const_iterator itrEnd = movePoints.end();
    for (ScriptPointVector::const_iterator itr = movePoints.begin(); itr != itrEnd; ++itr)
    {
        Escort_Waypoint point(itr->uiPointId, itr->fX, itr->fY, itr->fZ, itr->uiWaitTime);
        WaypointList.push_back(point);
    }
}

void npc_escortAI::SetRun(bool on)
{
    if (on)
    {
        if (!m_bIsRunning)
            me->SetWalk(false);
        else
            sLog->outDebug(LOG_FILTER_TSCR, "TSCR: EscortAI attempt to set run mode, but is already running.");
    }
    else
    {
        if (m_bIsRunning)
            me->SetWalk(true);
        else
            sLog->outDebug(LOG_FILTER_TSCR, "TSCR: EscortAI attempt to set walk mode, but is already walking.");
    }

    m_bIsRunning = on;
}

//TODO: get rid of this many variables passed in function.
void npc_escortAI::Start(bool isActiveAttacker /* = true*/, bool run /* = false */, uint64 playerGUID /* = 0 */, Quest const* quest /* = NULL */, bool instantRespawn /* = false */, bool canLoopPath /* = false */, bool resetWaypoints /* = true */)
{
    if (me->GetVictim())
    {
        sLog->outError("TSCR ERROR: EscortAI (script: %s, creature entry: %u) attempts to Start while in combat", me->GetScriptName().c_str(), me->GetEntry());
        return;
    }

    if (HasEscortState(STATE_ESCORT_ESCORTING))
    {
        sLog->outError("TSCR: EscortAI (script: %s, creature entry: %u) attempts to Start while already escorting", me->GetScriptName().c_str(), me->GetEntry());
        return;
    }

    if (!ScriptWP && resetWaypoints) // sd2 never adds wp in script, but tc does
    {
        if (!WaypointList.empty())
            WaypointList.clear();
        FillPointMovementListForCreature();
    }

    if (WaypointList.empty())
    {
        sLog->outErrorDb("TSCR: EscortAI (script: %s, creature entry: %u) starts with 0 waypoints (possible missing entry in script_waypoint. Quest: %u).",
            me->GetScriptName().c_str(), me->GetEntry(), quest ? quest->GetQuestId() : 0);
        return;
    }

    //set variables
    m_bIsActiveAttacker = isActiveAttacker;
    m_bIsRunning = run;

    m_uiPlayerGUID = playerGUID;
    m_pQuestForEscort = quest;

    m_bCanInstantRespawn = instantRespawn;
    m_bCanReturnToStart = canLoopPath;

#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    if (m_bCanReturnToStart && m_bCanInstantRespawn)
        sLog->outDebug(LOG_FILTER_TSCR, "TSCR: EscortAI is set to return home after waypoint end and instant respawn at waypoint end. Creature will never despawn.");
#endif

    if (me->GetMotionMaster()->GetCurrentMovementGeneratorType() == WAYPOINT_MOTION_TYPE)
    {
        me->GetMotionMaster()->MovementExpired();
        me->GetMotionMaster()->MoveIdle();
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
        sLog->outDebug(LOG_FILTER_TSCR, "TSCR: EscortAI start with WAYPOINT_MOTION_TYPE, changed to MoveIdle.");
#endif
    }

    //disable npcflags
    me->SetUInt32Value(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_NONE);
    if (me->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_NPC))
    {
        HasImmuneToNPCFlags = true;
        me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_NPC);
    }

#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outDebug(LOG_FILTER_TSCR, "TSCR: EscortAI started with " UI64FMTD " waypoints. ActiveAttacker = %d, Run = %d, PlayerGUID = " UI64FMTD "", uint64(WaypointList.size()), m_bIsActiveAttacker, m_bIsRunning, m_uiPlayerGUID);
#endif

    CurrentWP = WaypointList.begin();

    //Set initial speed
    if (m_bIsRunning)
        me->SetWalk(false);
    else
        me->SetWalk(true);

    AddEscortState(STATE_ESCORT_ESCORTING);
    if (me->GetMotionMaster()->GetMotionSlotType(MOTION_SLOT_ACTIVE) == ESCORT_MOTION_TYPE)
        me->GetMotionMaster()->MovementExpired();
    me->DisableSpline();
    me->GetMotionMaster()->MoveIdle();
}

void npc_escortAI::SetEscortPaused(bool on)
{
    if (!HasEscortState(STATE_ESCORT_ESCORTING))
        return;

    if (on)
        AddEscortState(STATE_ESCORT_PAUSED);
    else
        RemoveEscortState(STATE_ESCORT_PAUSED);
}

bool npc_escortAI::SetNextWaypoint(uint32 pointId, float x, float y, float z, float orientation)
{
    me->UpdatePosition(x, y, z, orientation);
    return SetNextWaypoint(pointId, false);
}

bool npc_escortAI::SetNextWaypoint(uint32 pointId, bool setPosition)
{
    if (!WaypointList.empty())
        WaypointList.clear();

    FillPointMovementListForCreature();

    if (WaypointList.empty())
        return false;

    Escort_Waypoint waypoint(0, 0, 0, 0, 0);
    for (CurrentWP = WaypointList.begin(); CurrentWP != WaypointList.end(); ++CurrentWP)
    {
        if (CurrentWP->id == pointId)
        {
            if (setPosition)
                me->UpdatePosition(CurrentWP->x, CurrentWP->y, CurrentWP->z, me->GetOrientation());
            return true;
        }
    }

    return false;
}

bool npc_escortAI::GetWaypointPosition(uint32 pointId, float& x, float& y, float& z)
{
    ScriptPointVector const& waypoints = sScriptSystemMgr->GetPointMoveList(me->GetEntry());
    if (waypoints.empty())
        return false;

    for (ScriptPointVector::const_iterator itr = waypoints.begin(); itr != waypoints.end(); ++itr)
    {
        if (itr->uiPointId == pointId)
        {
            x = itr->fX;
            y = itr->fY;
            z = itr->fZ;
            return true;
        }
    }

    return false;
}

void npc_escortAI::GenerateWaypointArray(Movement::PointsArray* points)
{
    if (WaypointList.empty())
        return;

    uint32 startingWaypointId = CurrentWP->id;

    // Flying unit, just fill array
    if (me->m_movementInfo.HasMovementFlag((MovementFlags)(MOVEMENTFLAG_CAN_FLY|MOVEMENTFLAG_DISABLE_GRAVITY)))
    {
        // xinef: first point in vector is unit real position
        points->clear();
        points->push_back(G3D::Vector3(me->GetPositionX(), me->GetPositionY(), me->GetPositionZ()));
        for (std::list<Escort_Waypoint>::const_iterator itr = CurrentWP; itr != WaypointList.end(); ++itr)
            points->push_back(G3D::Vector3(itr->x, itr->y, itr->z));
    }
    else
    {
        for (float size = 1.0f; size; size *= 0.5f)
        {
            std::vector<G3D::Vector3> pVector;
            // xinef: first point in vector is unit real position
            pVector.push_back(G3D::Vector3(me->GetPositionX(), me->GetPositionY(), me->GetPositionZ()));
            uint32 length = (WaypointList.size() - startingWaypointId)*size;

            uint32 cnt = 0;
            for (std::list<Escort_Waypoint>::const_iterator itr = CurrentWP; itr != WaypointList.end() && cnt <= length; ++itr, ++cnt)
                pVector.push_back(G3D::Vector3(itr->x, itr->y, itr->z));

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

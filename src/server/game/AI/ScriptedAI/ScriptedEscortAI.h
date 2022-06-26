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

#ifndef SC_ESCORTAI_H
#define SC_ESCORTAI_H

#include "ScriptSystem.h"
#include "ScriptedCreature.h"

#define DEFAULT_MAX_PLAYER_DISTANCE 100

struct Escort_Waypoint
{
    Escort_Waypoint(uint32 _id, float _x, float _y, float _z, uint32 _w)
    {
        id = _id;
        x = _x;
        y = _y;
        z = _z;
        WaitTimeMs = _w;
    }

    uint32 id;
    float x;
    float y;
    float z;
    uint32 WaitTimeMs;
};

enum eEscortState
{
    STATE_ESCORT_NONE       = 0x000,                        //nothing in progress
    STATE_ESCORT_ESCORTING  = 0x001,                        //escort are in progress
    STATE_ESCORT_RETURNING  = 0x002,                        //escort is returning after being in combat
    STATE_ESCORT_PAUSED     = 0x004                         //will not proceed with waypoints before state is removed
};

struct npc_escortAI : public ScriptedAI
{
public:
    explicit npc_escortAI(Creature* creature);
    ~npc_escortAI() override {}

    // CreatureAI functions
    void AttackStart(Unit* who) override;

    void MoveInLineOfSight(Unit* who) override;

    void JustDied(Unit*) override;

    void JustRespawned() override;

    void ReturnToLastPoint();

    void EnterEvadeMode(EvadeReason /*why*/ = EVADE_REASON_OTHER) override;

    void UpdateAI(uint32 diff) override;                   //the "internal" update, calls UpdateEscortAI()
    virtual void UpdateEscortAI(uint32 diff);     //used when it's needed to add code in update (abilities, scripted events, etc)

    void MovementInform(uint32, uint32) override;

    // EscortAI functions
    void AddWaypoint(uint32 id, float x, float y, float z, uint32 waitTime = 0);    // waitTime is in ms

    //this will set the current position to x/y/z/o, and the current WP to pointId.
    bool SetNextWaypoint(uint32 pointId, float x, float y, float z, float orientation);

    //this will set the current position to WP start position (if setPosition == true),
    //and the current WP to pointId
    bool SetNextWaypoint(uint32 pointId, bool setPosition = true);

    bool GetWaypointPosition(uint32 pointId, float& x, float& y, float& z);

    void GenerateWaypointArray(Movement::PointsArray* points);

    virtual void WaypointReached(uint32 pointId) = 0;
    virtual void WaypointStart(uint32 /*pointId*/) {}

    void Start(bool isActiveAttacker = true, bool run = false, ObjectGuid playerGUID = ObjectGuid::Empty, Quest const* quest = nullptr, bool instantRespawn = false, bool canLoopPath = false, bool resetWaypoints = true);

    void SetRun(bool on = true);
    void SetEscortPaused(bool on);

    bool HasEscortState(uint32 escortState) { return (m_uiEscortState & escortState); }
    bool IsEscorted() override { return (m_uiEscortState & STATE_ESCORT_ESCORTING); }

    void SetMaxPlayerDistance(float newMax) { MaxPlayerDistance = newMax; }
    float GetMaxPlayerDistance() { return MaxPlayerDistance; }

    void SetDespawnAtEnd(bool despawn) { DespawnAtEnd = despawn; }
    void SetDespawnAtFar(bool despawn) { DespawnAtFar = despawn; }
    bool GetAttack() { return m_bIsActiveAttacker; }//used in EnterEvadeMode override
    void SetCanAttack(bool attack) { m_bIsActiveAttacker = attack; }
    ObjectGuid GetEventStarterGUID() { return m_uiPlayerGUID; }

    void AddEscortState(uint32 escortState) { m_uiEscortState |= escortState; }
    void RemoveEscortState(uint32 escortState) { m_uiEscortState &= ~escortState; }

protected:
    Player* GetPlayerForEscort() { return ObjectAccessor::GetPlayer(*me, m_uiPlayerGUID); }

private:
    bool AssistPlayerInCombatAgainst(Unit* who);
    bool IsPlayerOrGroupInRange();
    void FillPointMovementListForCreature();

    ObjectGuid m_uiPlayerGUID;
    uint32 m_uiWPWaitTimer;
    uint32 m_uiPlayerCheckTimer;
    uint32 m_uiEscortState;
    float MaxPlayerDistance;

    Quest const* m_pQuestForEscort;                     //generally passed in Start() when regular escort script.

    std::list<Escort_Waypoint> WaypointList;
    std::list<Escort_Waypoint>::iterator CurrentWP;

    bool m_bIsActiveAttacker;                           //obsolete, determined by faction.
    bool m_bIsRunning;                                  //all creatures are walking by default (has flag MOVEMENTFLAG_WALK)
    bool m_bCanInstantRespawn;                          //if creature should respawn instantly after escort over (if not, database respawntime are used)
    bool m_bCanReturnToStart;                           //if creature can walk same path (loop) without despawn. Not for regular escort quests.
    bool DespawnAtEnd;
    bool DespawnAtFar;
    bool ScriptWP;
    bool HasImmuneToNPCFlags;
};
#endif

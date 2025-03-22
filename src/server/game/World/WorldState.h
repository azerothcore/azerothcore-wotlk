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

#ifndef WORLD_STATE_H
#define WORLD_STATE_H

#include "Player.h"
#include <atomic>

// TODO: Move these to WorldStateDefines.h
enum WorldStateWorldStates
{
    // Sun's Reach Reclamation
    WORLD_STATE_QUEL_DANAS_MUSIC                    = 3426,
    WORLD_STATE_QUEL_DANAS_HARBOR                   = 3238,
    WORLD_STATE_QUEL_DANAS_ALCHEMY_LAB              = 3223,
    WORLD_STATE_QUEL_DANAS_ARMORY                   = 3233,
    WORLD_STATE_QUEL_DANAS_SANCTUM                  = 3244,
    WORLD_STATE_QUEL_DANAS_PORTAL                   = 3269,
    WORLD_STATE_QUEL_DANAS_ANVIL                    = 3228,
    WORLD_STATE_QUEL_DANAS_MONUMENT                 = 3275,
    // Sunwell Gate
    WORLD_STATE_AGAMATH_THE_FIRST_GATE_HEALTH       = 3253, // guessed, potentially wrong
    WORLD_STATE_ROHENDOR_THE_SECOND_GATE_HEALTH     = 3255,
    WORLD_STATE_ARCHONISUS_THE_FINAL_GATE_HEALTH    = 3257,
};

enum WorldStateCondition
{
    WORLD_STATE_CONDITION_TROLLBANES_COMMAND  = 39911,
    WORLD_STATE_CONDITION_NAZGRELS_FAVOR      = 39913,
    // Zeppelins
    WORLD_STATE_CONDITION_THE_THUNDERCALLER   = 164871,
    WORLD_STATE_CONDITION_THE_IRON_EAGLE      = 175080,
    WORLD_STATE_CONDITION_THE_PURPLE_PRINCESS = 176495,
};

enum WorldStateConditionState
{
    WORLD_STATE_CONDITION_STATE_NONE = 0,
};

enum WorldStateEvent
{
    WORLD_STATE_CUSTOM_EVENT_ON_ADALS_SONG_OF_BATTLE     = 39953,
    WORLD_STATE_CUSTOM_EVENT_ON_MAGTHERIDON_HEAD_SPAWN   = 184640,
    WORLD_STATE_CUSTOM_EVENT_ON_MAGTHERIDON_HEAD_DESPAWN = 184641,
};

enum WorldStateZoneId
{
    ZONEID_SHATTRATH    = 3703,
    ZONEID_BOTANICA     = 3847,
    ZONEID_ARCATRAZ     = 3848,
    ZONEID_MECHANAR     = 3849,

    ZONEID_HELLFIRE_PENINSULA   = 3483,
    ZONEID_HELLFIRE_RAMPARTS    = 3562,
    ZONEID_HELLFIRE_CITADEL     = 3563,
    ZONEID_BLOOD_FURNACE        = 3713,
    ZONEID_SHATTERED_HALLS      = 3714,
    ZONEID_MAGTHERIDON_LAIR     = 3836,

    ZONEID_ISLE_OF_QUEL_DANAS   = 4080,
    ZONEID_MAGISTERS_TERRACE    = 4131,
    ZONEID_SUNWELL_PLATEAU      = 4075,
};

enum WorldStateSpells
{
    SPELL_ADAL_SONG_OF_BATTLE   = 39953,

    SPELL_TROLLBANES_COMMAND    = 39911,
    SPELL_NAZGRELS_FAVOR        = 39913,

    SPELL_KIRU_SONG_OF_VICTORY  = 46302,
};

enum WorldStateSaveIds
{
    SAVE_ID_QUEL_DANAS = 20,
};

enum WorldStateGameEvents
{
   // Isle phases
    GAME_EVENT_QUEL_DANAS_PHASE_1               = 101,
    GAME_EVENT_QUEL_DANAS_PHASE_2_ONLY          = 102,
    GAME_EVENT_QUEL_DANAS_PHASE_2_PERMANENT     = 103,
    GAME_EVENT_QUEL_DANAS_PHASE_2_NO_PORTAL     = 104,
    GAME_EVENT_QUEL_DANAS_PHASE_2_PORTAL        = 105,
    GAME_EVENT_QUEL_DANAS_PHASE_3_ONLY          = 106,
    GAME_EVENT_QUEL_DANAS_PHASE_3_PERMANENT     = 107,
    GAME_EVENT_QUEL_DANAS_PHASE_3_NO_ANVIL      = 108,
    GAME_EVENT_QUEL_DANAS_PHASE_3_ANVIL         = 109,
    GAME_EVENT_QUEL_DANAS_PHASE_4               = 110,
    GAME_EVENT_QUEL_DANAS_PHASE_4_NO_MONUMENT   = 111,
    GAME_EVENT_QUEL_DANAS_PHASE_4_MONUMENT      = 112,
    GAME_EVENT_QUEL_DANAS_PHASE_4_NO_ALCHEMY_LAB= 113,
    GAME_EVENT_QUEL_DANAS_PHASE_4_ALCHEMY_LAB   = 114,
    GAME_EVENT_QUEL_DANAS_PHASE_4_KIRU          = 115,
    // SWP Phases
    GAME_EVENT_SWP_GATES_PHASE_0                = 116, // All Gates Closed
    GAME_EVENT_SWP_GATES_PHASE_1                = 117, // First Gate Open
    GAME_EVENT_SWP_GATES_PHASE_2                = 118, // Second Gate Open
    GAME_EVENT_SWP_GATES_PHASE_3                = 119, // All Gates Open
};

enum SunsReachPhases
{
    SUNS_REACH_PHASE_1_STAGING_AREA,
    SUNS_REACH_PHASE_2_SANCTUM,
    SUNS_REACH_PHASE_3_ARMORY,
    SUNS_REACH_PHASE_4_HARBOR,
};

enum SunsReachSubPhases
{
    SUBPHASE_PORTAL         = 0x01,
    SUBPHASE_ANVIL          = 0x02,
    SUBPHASE_ALCHEMY_LAB    = 0x04,
    SUBPHASE_MONUMENT       = 0x08,
    SUBPHASE_ALL = SUBPHASE_PORTAL | SUBPHASE_ANVIL | SUBPHASE_ALCHEMY_LAB | SUBPHASE_MONUMENT,
};

enum SunsReachCounters
{
    COUNTER_ERRATIC_BEHAVIOR,
    COUNTER_SANCTUM_WARDS,
    COUNTER_BATTLE_FOR_THE_SUNS_REACH_ARMORY,
    COUNTER_DISTRACTION_AT_THE_DEAD_SCAR,
    COUNTER_INTERCEPTING_THE_MANA_CELLS,
    COUNTER_INTERCEPT_THE_REINFORCEMENTS,
    COUNTER_TAKING_THE_HARBOR,
    COUNTER_MAKING_READY,
    COUNTER_DISCOVERING_YOUR_ROOTS,
    COUNTER_A_CHARITABLE_DONATION,
    COUNTERS_MAX,
};

enum SunwellGates
{
    SUNWELL_ALL_GATES_CLOSED,
    SUNWELL_AGAMATH_GATE1_OPEN,
    SUNWELL_ROHENDOR_GATE2_OPEN,
    SUNWELL_ARCHONISUS_GATE3_OPEN,
};
enum SunwellGateCounters
{
    COUNTER_AGAMATH_THE_FIRST_GATE,
    COUNTER_ROHENDOR_THE_SECOND_GATE,
    COUNTER_ARCHONISUS_THE_FINAL_GATE,
    COUNTERS_MAX_GATES,
};

struct SunsReachReclamationData
{
    uint32 m_phase;
    uint32 m_subphaseMask;
    uint32 m_sunsReachReclamationCounters[COUNTERS_MAX];
    GuidVector m_sunsReachReclamationPlayers;
    std::mutex m_sunsReachReclamationMutex;
    uint32 m_gate;
    uint32 m_gateCounters[COUNTERS_MAX_GATES];
    SunsReachReclamationData() : m_phase(SUNS_REACH_PHASE_1_STAGING_AREA), m_subphaseMask(0), m_gate(SUNWELL_ALL_GATES_CLOSED)
    {
        memset(m_sunsReachReclamationCounters, 0, sizeof(m_sunsReachReclamationCounters));
        memset(m_gateCounters, 0, sizeof(m_gateCounters));
    }
    std::string GetData();
    uint32 GetPhasePercentage(uint32 phase);
    uint32 GetSubPhasePercentage(uint32 subPhase);
    uint32 GetSunwellGatePercentage(uint32 gate);
};

// Intended for implementing server wide scripts, note: all behaviour must be safeguarded towards multithreading
class WorldState
{
    public:
        WorldState();
        virtual ~WorldState();
        static WorldState* instance();
        void Load();
        void Save(WorldStateSaveIds saveId);
        void SaveHelper(std::string& stringToSave, WorldStateSaveIds saveId);
        void HandlePlayerEnterZone(Player* player, WorldStateZoneId zoneId);
        void HandlePlayerLeaveZone(Player* player, WorldStateZoneId zoneId);
        bool IsConditionFulfilled(WorldStateCondition conditionId, WorldStateConditionState state = WORLD_STATE_CONDITION_STATE_NONE) const;
        void HandleConditionStateChange(WorldStateCondition conditionId, WorldStateConditionState state);
        void HandleExternalEvent(WorldStateEvent eventId, uint32 param);
        void Update(uint32 diff);
        void AddSunwellGateProgress(uint32 questId);
        void AddSunsReachProgress(uint32 questId);
        std::string GetSunsReachPrintout();
        void FillInitialWorldStates(WorldPackets::WorldState::InitWorldStates& packet, uint32 zoneId, uint32 /*areaId*/);
        void HandleSunsReachPhaseTransition(uint32 newPhase);
        void HandleSunsReachSubPhaseTransition(int32 subPhaseMask, bool initial = false);
        void SetSunsReachCounter(SunsReachCounters index, uint32 value);
        void HandleSunwellGateTransition(uint32 newGate);
        void SetSunwellGateCounter(SunwellGateCounters index, uint32 value);
    private:
        void SendWorldstateUpdate(std::mutex& mutex, GuidVector const& guids, uint32 value, uint32 worldStateId);
        void StopSunsReachPhase(bool forward);
        void StartSunsReachPhase(bool initial = false);
        void StartSunwellGatePhase();
        void StopSunwellGatePhase();
        void BuffAdalsSongOfBattle();
        void DispelAdalsSongOfBattle();
        uint32 _adalSongOfBattleTimer;
        void BuffMagtheridonTeam(TeamId team);
        void DispelMagtheridonTeam(TeamId team);
        bool _isMagtheridonHeadSpawnedHorde;
        bool _isMagtheridonHeadSpawnedAlliance;
        SunsReachReclamationData m_sunsReachData;
        std::map<WorldStateCondition, std::atomic<WorldStateConditionState>> _transportStates; // atomic to avoid having to lock
        std::mutex _mutex; // all World State operations are threat unsafe
};

#define sWorldState WorldState::instance()
#endif

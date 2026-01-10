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

#ifndef WORLD_STATE_H
#define WORLD_STATE_H

#include "AreaDefines.h"
#include "Player.h"
#include "WorldStateDefines.h"
#include <atomic>

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

enum WorldStateSpells
{
    SPELL_ADAL_SONG_OF_BATTLE   = 39953,

    SPELL_TROLLBANES_COMMAND    = 39911,
    SPELL_NAZGRELS_FAVOR        = 39913,

    SPELL_KIRU_SONG_OF_VICTORY  = 46302,
};

enum WorldStateSaveIds
{
    SAVE_ID_SCOURGE_INVASION = 3,
    SAVE_ID_QUEL_DANAS = 20,
};

enum WorldStateGameEvents
{
    // Scourge Invasion
    GAME_EVENT_SCOURGE_INVASION                         = 17,
    GAME_EVENT_SCOURGE_INVASION_BOSSES                  = 120,
    GAME_EVENT_SCOURGE_INVASION_WINTERSPRING            = 121,
    GAME_EVENT_SCOURGE_INVASION_TANARIS                 = 122,
    GAME_EVENT_SCOURGE_INVASION_AZSHARA                 = 123,
    GAME_EVENT_SCOURGE_INVASION_BLASTED_LANDS           = 124,
    GAME_EVENT_SCOURGE_INVASION_EASTERN_PLAGUELANDS     = 125,
    GAME_EVENT_SCOURGE_INVASION_BURNING_STEPPES         = 126,
    GAME_EVENT_SCOURGE_INVASION_50_INVASIONS            = 127,
    GAME_EVENT_SCOURGE_INVASION_100_INVASIONS           = 128,
    GAME_EVENT_SCOURGE_INVASION_150_INVASIONS           = 129,
    GAME_EVENT_SCOURGE_INVASION_INVASIONS_DONE          = 130,

    // Zombie infestation
    GAME_EVENT_ZOMBIE_INFESTATION_PHASE_1               = 110,
    GAME_EVENT_ZOMBIE_INFESTATION_PHASE_2               = 111,
    GAME_EVENT_ZOMBIE_INFESTATION_PHASE_3               = 112,
    GAME_EVENT_ZOMBIE_INFESTATION_PHASE_4               = 113,
    GAME_EVENT_ZOMBIE_INFESTATION_PHASE_5               = 114,
    GAME_EVENT_ZOMBIE_INFESTATION_PHASE_6               = 115,

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

enum SIMisc
{
    EVENT_HERALD_OF_THE_LICH_KING_ZONE_START     = 7,
    EVENT_HERALD_OF_THE_LICH_KING_ZONE_STOP      = 8,
    NPC_PALLID_HORROR                            = 16394,
    NPC_PATCHWORK_TERROR                         = 16382,
    NPC_HERALD_OF_THE_LICH_KING                  = 16995,
    ITEM_A_LETTER_FROM_THE_KEEPER_OF_THE_ROLLS   = 22723,
    NPC_ARGENT_EMISSARY                          = 16285,
    MAIL_TEMPLATE_ARGENT_DAWN_NEEDS_YOUR_HELP    = 171,
};

enum SIState : uint32
{
    STATE_0_DISABLED,
    STATE_1_ENABLED,
    SI_STATE_MAX,
};

enum SIZoneIds
{
    SI_ZONE_AZSHARA,
    SI_ZONE_BLASTED_LANDS,
    SI_ZONE_BURNING_STEPPES,
    SI_ZONE_EASTERN_PLAGUELANDS,
    SI_ZONE_TANARIS,
    SI_ZONE_WINTERSPRING,
    SI_ZONE_STORMWIND,
    SI_ZONE_UNDERCITY
};

enum SITimers
{
    SI_TIMER_AZSHARA,
    SI_TIMER_BLASTED_LANDS,
    SI_TIMER_BURNING_STEPPES,
    SI_TIMER_EASTERN_PLAGUELANDS,
    SI_TIMER_TANARIS,
    SI_TIMER_WINTERSPRING,
    SI_TIMER_STORMWIND,
    SI_TIMER_UNDERCITY,
    SI_TIMER_MAX,
};

enum SIRemaining
{
    SI_REMAINING_AZSHARA,
    SI_REMAINING_BLASTED_LANDS,
    SI_REMAINING_BURNING_STEPPES,
    SI_REMAINING_EASTERN_PLAGUELANDS,
    SI_REMAINING_TANARIS,
    SI_REMAINING_WINTERSPRING,
    SI_REMAINING_MAX,
};

enum SICityTimers
{
    // These timers may fail if you set it under 1 minute.
    ZONE_ATTACK_TIMER_MIN                               = 60 * 45, // 45 min.
    ZONE_ATTACK_TIMER_MAX                               = 60 * 60, // 60 min.
    CITY_ATTACK_TIMER_MIN                               = 60 * 45, // 45 min.
    CITY_ATTACK_TIMER_MAX                               = 60 * 60, // 60 min.
};

struct ScourgeInvasionData
{
    struct InvasionZone
    {
        uint32 map;
        uint32 zoneId;
        uint32 necropolisCount;
        uint32 remainingNecropoli;
        std::vector<Position> mouth;
        ObjectGuid mouthGuid {};
    };

    struct CityAttack
    {
        uint32 map;
        uint32 zoneId;
        std::vector<Position> pallid;
        ObjectGuid pallidGuid {};
    };

    SIState m_state;

    TimePoint m_timers[SI_TIMER_MAX];
    uint32 m_battlesWon;
    uint32 m_lastAttackZone;
    uint32 m_remaining[SI_REMAINING_MAX];
    uint64 m_broadcastTimer;
    std::mutex m_siMutex;

    std::set<uint32> m_pendingInvasions;
    std::set<uint32> m_pendingPallids;
    std::map<uint32, InvasionZone> m_activeInvasions;
    std::map<uint32, CityAttack> m_cityAttacks;

    ScourgeInvasionData();

    void Reset();
    std::string GetData();
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
        void LoadWorldStates();
        void setWorldState(uint32 index, uint64 value);
        [[nodiscard]] uint64 getWorldState(uint32 index) const;
        void Save(WorldStateSaveIds saveId);
        void SaveHelper(std::string& stringToSave, WorldStateSaveIds saveId);
        void HandlePlayerEnterZone(Player* player, AreaTableIDs zoneId);
        void HandlePlayerLeaveZone(Player* player, AreaTableIDs zoneId);
        bool IsConditionFulfilled(uint32 conditionId, uint32 state = WORLD_STATE_CONDITION_STATE_NONE) const;
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
        typedef std::map<uint32, uint64> WorldStatesMap;
        WorldStatesMap _worldstates;
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
        std::map<uint32, std::atomic<WorldStateConditionState>> _transportStates; // atomic to avoid having to lock
        std::mutex _mutex; // all World State operations are threat unsafe

        // Scourge Invasion
    public:
        void SetScourgeInvasionState(SIState state);
        void StartScourgeInvasion(bool sendMail);
        void StopScourgeInvasion();
        [[nodiscard]] uint32 GetSIRemaining(SIRemaining remaining) const;
        [[nodiscard]] uint32 GetSIRemainingByZone(uint32 zoneId) const;
        void SetSIRemaining(SIRemaining remaining, uint32 value);
        TimePoint GetSITimer(SITimers timer);
        void SetSITimer(SITimers timer, TimePoint timePoint);
        uint32 GetBattlesWon();
        void AddBattlesWon(int32 count);
        uint32 GetLastAttackZone();
        void SetLastAttackZone(uint32 zoneId);
        void BroadcastSIWorldstates();
        void HandleDefendedZones();

        std::string GetScourgeInvasionPrintout();
        void StartZoneEvent(SIZoneIds eventId);
        void StartNewInvasionIfTime(uint32 attackTimeVar, uint32 zoneId);
        void StartNewCityAttackIfTime(uint32 attackTimeVar, uint32 zoneId);
        void StartNewInvasion(uint32 zoneId);
        void StartNewCityAttack(uint32 zoneId);
        bool ResumeInvasion(ScourgeInvasionData::InvasionZone& zone);
        bool SummonMouth(Map* map, ScourgeInvasionData::InvasionZone& zone, Position position, bool newInvasion);
        bool SummonPallid(Map* map, ScourgeInvasionData::CityAttack& zone, const Position& position, uint32 spawnLoc);
        void HandleActiveZone(uint32 attackTimeVar, uint32 zoneId, uint32 remainingVar, TimePoint now);

        Map* GetMap(uint32 mapId, Position const& invZone);
        bool IsActiveZone(uint32 zoneId);
        uint32 GetActiveZones();
        uint32 GetTimerIdForZone(uint32 zoneId);

        void SetPallidGuid(uint32 zoneId, ObjectGuid guid);
        void SetMouthGuid(uint32 zoneId, ObjectGuid guid);
        void AddPendingInvasion(uint32 zoneId);
        void RemovePendingInvasion(uint32 zoneId);
        void AddPendingPallid(uint32 zoneId);
        void RemovePendingPallid(uint32 zoneId);

        void OnEnable(ScourgeInvasionData::InvasionZone& zone);
        void OnDisable(ScourgeInvasionData::InvasionZone& zone);
        void OnDisable(ScourgeInvasionData::CityAttack& zone);
    private:
        void SendScourgeInvasionMail();
        ScourgeInvasionData m_siData;
};

#define sWorldState WorldState::instance()
#endif

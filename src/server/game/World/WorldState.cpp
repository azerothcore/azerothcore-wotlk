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

#include "AreaDefines.h"
#include "CreatureAIImpl.h"
#include "GameEventMgr.h"
#include "Log.h"
#include "MapMgr.h"
#include "Player.h"
#include "SharedDefines.h"
#include "UnitAI.h"
#include "Weather.h"
#include "WorldState.h"
#include "WorldConfig.h"
#include "WorldStateDefines.h"
#include <chrono>

WorldState* WorldState::instance()
{
    static WorldState instance;
    return &instance;
}

WorldState::WorldState() : _isMagtheridonHeadSpawnedHorde(false), _isMagtheridonHeadSpawnedAlliance(false)
{
    _transportStates[WORLD_STATE_CONDITION_THE_IRON_EAGLE]      = WORLD_STATE_CONDITION_STATE_NONE;
    _transportStates[WORLD_STATE_CONDITION_THE_PURPLE_PRINCESS] = WORLD_STATE_CONDITION_STATE_NONE;
    _transportStates[WORLD_STATE_CONDITION_THE_THUNDERCALLER]   = WORLD_STATE_CONDITION_STATE_NONE;
}

WorldState::~WorldState()
{
}

void WorldState::Load()
{
    CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_WORLD_STATE);
    PreparedQueryResult result = CharacterDatabase.Query(stmt);

    if (result)
    {
        do
        {
            Field* fields = result->Fetch();
            uint32 id = fields[0].Get<uint32>();
            std::string data = fields[1].Get<std::string>();
            std::istringstream loadStream(data);

            switch (id)
            {
                case SAVE_ID_QUEL_DANAS:
                {
                    if (data.size())
                    {
                        try
                        {
                            loadStream >> m_sunsReachData.m_phase >> m_sunsReachData.m_subphaseMask;
                            for (uint32 i = 0; i < COUNTERS_MAX; ++i)
                                loadStream >> m_sunsReachData.m_sunsReachReclamationCounters[i];
                            loadStream >> m_sunsReachData.m_gate;
                            for (uint32 i = 0; i < COUNTERS_MAX_GATES; ++i)
                                loadStream >> m_sunsReachData.m_gateCounters[i];
                        }
                        catch (std::exception& e)
                        {
                            LOG_ERROR("scripts", "WorldState::Load: Exception reading SunsReach data {}", e.what());
                            m_sunsReachData.m_phase = 0;
                            m_sunsReachData.m_subphaseMask = 0;
                            memset(m_sunsReachData.m_sunsReachReclamationCounters, 0, sizeof(m_sunsReachData.m_sunsReachReclamationCounters));
                            m_sunsReachData.m_gate = SUNWELL_ALL_GATES_CLOSED;
                            memset(m_sunsReachData.m_gateCounters, 0, sizeof(m_sunsReachData.m_gateCounters));
                        }
                    }
                    else
                    {
                        m_sunsReachData.m_phase = 0;
                        m_sunsReachData.m_subphaseMask = 0;
                        memset(m_sunsReachData.m_sunsReachReclamationCounters, 0, sizeof(m_sunsReachData.m_sunsReachReclamationCounters));
                        m_sunsReachData.m_gate = SUNWELL_ALL_GATES_CLOSED;
                        memset(m_sunsReachData.m_gateCounters, 0, sizeof(m_sunsReachData.m_gateCounters));
                    }
                    break;
                }
                case SAVE_ID_SCOURGE_INVASION:
                    if (data.size())
                    {
                        try
                        {
                            uint32 state;
                            loadStream >> state;
                            m_siData.m_state = SIState(state);
                            for (TimePoint& m_timer : m_siData.m_timers)
                            {
                                uint64 time;
                                loadStream >> time;
                                m_timer = TimePoint(std::chrono::milliseconds(time));
                            }
                            loadStream >> m_siData.m_battlesWon >> m_siData.m_lastAttackZone;
                            for (unsigned int& i : m_siData.m_remaining)
                                loadStream >> i;
                        }
                        catch (std::exception& e)
                        {
                            LOG_ERROR("scripts", "WorldState::Load: Exception reading ScourgeInvasion data {}", e.what());
                            m_siData.Reset();
                        }
                    }
                    break;
            }
        } while (result->NextRow());
    }
    StartSunsReachPhase(true);
    StartSunwellGatePhase();
    HandleSunsReachSubPhaseTransition(m_sunsReachData.m_subphaseMask, true);

    if (m_siData.m_state == STATE_1_ENABLED)
    {
        StartScourgeInvasion(false);
        HandleDefendedZones();
    }
}

void WorldState::LoadWorldStates()
{
    uint32 oldMSTime = getMSTime();

    QueryResult result = CharacterDatabase.Query("SELECT entry, value FROM worldstates");

    if (!result)
    {
        LOG_WARN("server.loading", ">> Loaded 0 world states. DB table `worldstates` is empty!");
        LOG_INFO("server.loading", " ");
        return;
    }

    do
    {
        Field* fields = result->Fetch();
        _worldstates[fields[0].Get<uint32>()] = fields[1].Get<uint32>();
    } while (result->NextRow());

    LOG_INFO("server.loading", ">> Loaded {} World States in {} ms", _worldstates.size(), GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
}

// Setting a worldstate will save it to DB
void WorldState::setWorldState(uint32 index, uint64 timeValue)
{
    auto const& it = _worldstates.find(index);
    if (it != _worldstates.end())
    {
        CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_WORLDSTATE);
        stmt->SetData(0, uint32(timeValue));
        stmt->SetData(1, index);
        CharacterDatabase.Execute(stmt);
    }
    else
    {
        CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_WORLDSTATE);
        stmt->SetData(0, index);
        stmt->SetData(1, uint32(timeValue));
        CharacterDatabase.Execute(stmt);
    }

    _worldstates[index] = timeValue;
}

uint64 WorldState::getWorldState(uint32 index) const
{
    auto const& itr = _worldstates.find(index);
    return itr != _worldstates.end() ? itr->second : 0;
}

void WorldState::Save(WorldStateSaveIds saveId)
{
    switch (saveId)
    {
        case SAVE_ID_QUEL_DANAS:
        {
            std::string expansionData = m_sunsReachData.GetData();
            SaveHelper(expansionData, SAVE_ID_QUEL_DANAS);
            break;
        }
        case SAVE_ID_SCOURGE_INVASION:
        {
            std::string siData = m_siData.GetData();
            SaveHelper(siData, SAVE_ID_SCOURGE_INVASION);
            break;
        }
        default:
            break;
    }
}

void WorldState::SaveHelper(std::string& stringToSave, WorldStateSaveIds saveId)
{
    CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_REP_WORLD_STATE);
    stmt->SetData(0, saveId);
    stmt->SetData(1, stringToSave);
    CharacterDatabase.Execute(stmt);
}

bool WorldState::IsConditionFulfilled(uint32 conditionId, uint32 state) const
{
    switch (conditionId)
    {
        case WORLD_STATE_CONDITION_TROLLBANES_COMMAND:
            return _isMagtheridonHeadSpawnedAlliance;
        case WORLD_STATE_CONDITION_NAZGRELS_FAVOR:
            return _isMagtheridonHeadSpawnedHorde;
        case WORLD_STATE_CONDITION_THE_IRON_EAGLE:
        case WORLD_STATE_CONDITION_THE_PURPLE_PRINCESS:
        case WORLD_STATE_CONDITION_THE_THUNDERCALLER:
            return _transportStates.at(conditionId) == state;
        case WORLD_STATE_SCOURGE_INVASION_WINTERSPRING:
            return GetSIRemaining(SI_REMAINING_WINTERSPRING) > 0;
        case WORLD_STATE_SCOURGE_INVASION_AZSHARA:
            return GetSIRemaining(SI_REMAINING_AZSHARA) > 0;
        case WORLD_STATE_SCOURGE_INVASION_BLASTED_LANDS:
            return GetSIRemaining(SI_REMAINING_BLASTED_LANDS) > 0;
        case WORLD_STATE_SCOURGE_INVASION_BURNING_STEPPES:
            return GetSIRemaining(SI_REMAINING_BURNING_STEPPES) > 0;
        case WORLD_STATE_SCOURGE_INVASION_TANARIS:
            return GetSIRemaining(SI_REMAINING_TANARIS) > 0;
        case WORLD_STATE_SCOURGE_INVASION_EASTERN_PLAGUELANDS:
            return GetSIRemaining(SI_REMAINING_EASTERN_PLAGUELANDS) > 0;
        default:
            LOG_ERROR("scripts", "WorldState::IsConditionFulfilled: Unhandled WorldStateCondition {}", conditionId);
            return false;
    }
}

void WorldState::HandleConditionStateChange(WorldStateCondition conditionId, WorldStateConditionState state)
{
    _transportStates[conditionId] = state;
}

Map* WorldState::GetMap(uint32 mapId, Position const& invZone)
{
    Map* map = sMapMgr->FindBaseMap(mapId);
    if (!map)
        LOG_ERROR("scripts",
            "ScourgeInvasionEvent::GetMap found no map with mapId {} , x: {}, y: {}.",
            mapId,
            invZone.GetPositionX(),
            invZone.GetPositionY());
    return map;
}

void WorldState::HandleExternalEvent(WorldStateEvent eventId, uint32 param)
{
    std::lock_guard<std::mutex> guard(_mutex);
    switch (eventId)
    {
        case WORLD_STATE_CUSTOM_EVENT_ON_ADALS_SONG_OF_BATTLE:
            if (!_adalSongOfBattleTimer)
            {
                _adalSongOfBattleTimer = 120 * MINUTE * IN_MILLISECONDS;
                BuffAdalsSongOfBattle();
            }
            break;
        case WORLD_STATE_CUSTOM_EVENT_ON_MAGTHERIDON_HEAD_SPAWN:
            if (param == TEAM_ALLIANCE)
            {
                _isMagtheridonHeadSpawnedAlliance = true;
                BuffMagtheridonTeam(TEAM_ALLIANCE);
            }
            else
            {
                _isMagtheridonHeadSpawnedHorde = true;
                BuffMagtheridonTeam(TEAM_HORDE);
            }
            break;
        case WORLD_STATE_CUSTOM_EVENT_ON_MAGTHERIDON_HEAD_DESPAWN:
            if (param == TEAM_ALLIANCE)
            {
                _isMagtheridonHeadSpawnedAlliance = false;
                DispelMagtheridonTeam(TEAM_ALLIANCE);
            }
            else
            {
                _isMagtheridonHeadSpawnedHorde = false;
                DispelMagtheridonTeam(TEAM_HORDE);
            }
            break;
        default:
            break;
    }
}

void WorldState::Update(uint32 diff)
{
    if (_adalSongOfBattleTimer)
    {
        if (_adalSongOfBattleTimer <= diff)
        {
            _adalSongOfBattleTimer = 0;
            DispelAdalsSongOfBattle();
        }
        else
        {
            _adalSongOfBattleTimer -= diff;
        }
    }

    if (m_siData.m_state != STATE_0_DISABLED)
    {
        if (m_siData.m_broadcastTimer <= diff)
        {
            m_siData.m_broadcastTimer = 10000;
            BroadcastSIWorldstates();

            if (m_siData.m_state == STATE_1_ENABLED)
            {
                for (auto& zone : m_siData.m_cityAttacks)
                {
                    if (zone.second.zoneId == AREA_UNDERCITY)
                        StartNewCityAttackIfTime(SI_TIMER_UNDERCITY, zone.second.zoneId);
                    else if (zone.second.zoneId == AREA_STORMWIND_CITY)
                        StartNewCityAttackIfTime(SI_TIMER_STORMWIND, zone.second.zoneId);
                }

                TimePoint now = std::chrono::steady_clock::now();
                for (auto& zone : m_siData.m_activeInvasions)
                    HandleActiveZone(GetTimerIdForZone(zone.second.zoneId), zone.second.zoneId, zone.second.remainingNecropoli, now);
            }
        }
        else
            m_siData.m_broadcastTimer -= diff;
    }
}

void WorldState::HandlePlayerEnterZone(Player* player, AreaTableIDs zoneId)
{
    std::lock_guard<std::mutex> guard(_mutex);
    switch (zoneId)
    {
        case AREA_SHATTRATH_CITY:
        case AREA_THE_BOTANICA:
        case AREA_THE_MECHANAR:
        case AREA_THE_ARCATRAZ:
            if (_adalSongOfBattleTimer)
                player->CastSpell(player, SPELL_ADAL_SONG_OF_BATTLE, true);
            break;
        case AREA_HELLFIRE_PENINSULA:
        case AREA_HELLFIRE_RAMPARTS:
        case AREA_HELLFIRE_CITADEL:
        case AREA_THE_BLOOD_FURNACE:
        case AREA_THE_SHATTERED_HALLS:
        case AREA_MAGTHERIDONS_LAIR:
            if (_isMagtheridonHeadSpawnedAlliance && player->GetTeamId() == TEAM_ALLIANCE)
                player->CastSpell(player, SPELL_TROLLBANES_COMMAND, true);
            else if (_isMagtheridonHeadSpawnedHorde && player->GetTeamId() == TEAM_HORDE)
                player->CastSpell(player, SPELL_NAZGRELS_FAVOR, true);
            break;
        case AREA_ISLE_OF_QUEL_DANAS:
        case AREA_MAGISTERS_TERRACE:
        case AREA_SUNWELL_PLATEAU:
        {
            std::lock_guard<std::mutex> guard(m_sunsReachData.m_sunsReachReclamationMutex);
            m_sunsReachData.m_sunsReachReclamationPlayers.push_back(player->GetGUID());
            if (m_sunsReachData.m_subphaseMask == SUBPHASE_ALL)
                player->CastSpell(player, SPELL_KIRU_SONG_OF_VICTORY, true);
            break;
        }
        default:
            break;
    }
};
void WorldState::HandlePlayerLeaveZone(Player* player, AreaTableIDs zoneId)
{
    std::lock_guard<std::mutex> guard(_mutex);
    switch (zoneId)
    {
        case AREA_SHATTRATH_CITY:
        case AREA_THE_BOTANICA:
        case AREA_THE_MECHANAR:
        case AREA_THE_ARCATRAZ:
            if (!_adalSongOfBattleTimer)
                player->RemoveAurasDueToSpell(SPELL_ADAL_SONG_OF_BATTLE);
            break;
        case AREA_HELLFIRE_PENINSULA:
        case AREA_HELLFIRE_RAMPARTS:
        case AREA_HELLFIRE_CITADEL:
        case AREA_THE_BLOOD_FURNACE:
        case AREA_THE_SHATTERED_HALLS:
        case AREA_MAGTHERIDONS_LAIR:
            if (player->GetTeamId() == TEAM_ALLIANCE)
                player->RemoveAurasDueToSpell(SPELL_TROLLBANES_COMMAND);
            else if (player->GetTeamId() == TEAM_HORDE)
                player->RemoveAurasDueToSpell(SPELL_NAZGRELS_FAVOR);
            break;
        case AREA_ISLE_OF_QUEL_DANAS:
        case AREA_MAGISTERS_TERRACE:
        case AREA_SUNWELL_PLATEAU:
        {
            std::lock_guard<std::mutex> guard(m_sunsReachData.m_sunsReachReclamationMutex);
            player->RemoveAurasDueToSpell(SPELL_KIRU_SONG_OF_VICTORY);
            auto position = std::find(m_sunsReachData.m_sunsReachReclamationPlayers.begin(), m_sunsReachData.m_sunsReachReclamationPlayers.end(), player->GetGUID());
            if (position != m_sunsReachData.m_sunsReachReclamationPlayers.end())
                m_sunsReachData.m_sunsReachReclamationPlayers.erase(position);
            break;
        }
        default:
            break;
    }
};

void WorldState::BuffMagtheridonTeam(TeamId team)
{
    sMapMgr->DoForAllMaps([&](Map* map) -> void
    {
        switch (map->GetId())
        {
            case MAP_OUTLAND:
                map->DoForAllPlayers([&](Player* player)
                {
                    if (player->GetZoneId() == AREA_HELLFIRE_PENINSULA && player->GetTeamId() == TEAM_ALLIANCE && team == TEAM_ALLIANCE)
                        player->CastSpell(player, SPELL_TROLLBANES_COMMAND, true);
                    else if (player->GetZoneId() == AREA_HELLFIRE_PENINSULA && player->GetTeamId() == TEAM_HORDE && team == TEAM_HORDE)
                        player->CastSpell(player, SPELL_NAZGRELS_FAVOR, true);
                });
                break;
            case MAP_HELLFIRE_CITADEL_THE_SHATTERED_HALLS:
            case MAP_HELLFIRE_CITADEL_THE_BLOOD_FURNACE:
            case MAP_HELLFIRE_CITADEL_RAMPARTS:
            case MAP_MAGTHERIDONS_LAIR:
                map->DoForAllPlayers([&](Player* player)
                {
                    if (player->GetTeamId() == TEAM_ALLIANCE && team == TEAM_ALLIANCE)
                        player->CastSpell(player, SPELL_TROLLBANES_COMMAND, true);
                    else if (player->GetTeamId() == TEAM_HORDE && team == TEAM_HORDE)
                        player->CastSpell(player, SPELL_NAZGRELS_FAVOR, true);
                });
                break;
            default:
                break;
        }
    });
}

void WorldState::DispelMagtheridonTeam(TeamId team)
{
    sMapMgr->DoForAllMaps([&](Map* map) -> void
    {
        switch (map->GetId())
        {
            case MAP_OUTLAND:
                map->DoForAllPlayers([&](Player* player)
                {
                    if (player->GetZoneId() == AREA_HELLFIRE_PENINSULA && player->GetTeamId() == TEAM_ALLIANCE && team == TEAM_ALLIANCE)
                        player->RemoveAurasDueToSpell(SPELL_TROLLBANES_COMMAND);
                    else if (player->GetZoneId() == AREA_HELLFIRE_PENINSULA && player->GetTeamId() == TEAM_HORDE && team == TEAM_HORDE)
                        player->RemoveAurasDueToSpell(SPELL_NAZGRELS_FAVOR);
                });
                break;
            case MAP_HELLFIRE_CITADEL_THE_SHATTERED_HALLS:
            case MAP_HELLFIRE_CITADEL_THE_BLOOD_FURNACE:
            case MAP_HELLFIRE_CITADEL_RAMPARTS:
            case MAP_MAGTHERIDONS_LAIR:
                map->DoForAllPlayers([&](Player* player)
                {
                    if (player->GetTeamId() == TEAM_ALLIANCE && team == TEAM_ALLIANCE)
                        player->RemoveAurasDueToSpell(SPELL_TROLLBANES_COMMAND);
                    else if (player->GetTeamId() == TEAM_HORDE && team == TEAM_HORDE)
                        player->RemoveAurasDueToSpell(SPELL_NAZGRELS_FAVOR);
                });
                break;
            default:
                break;
        }
    });
}

void WorldState::BuffAdalsSongOfBattle()
{
    sMapMgr->DoForAllMaps([&](Map* map) -> void
    {
        switch (map->GetId())
        {
            case MAP_OUTLAND:
                map->DoForAllPlayers([&](Player* player)
                {
                    if (player->GetZoneId() == AREA_SHATTRATH_CITY)
                        player->CastSpell(player, SPELL_ADAL_SONG_OF_BATTLE, true);
                });
                break;
            case MAP_TEMPEST_KEEP_THE_ARCATRAZ:
            case MAP_TEMPEST_KEEP_THE_BOTANICA:
            case MAP_TEMPEST_KEEP_THE_MECHANAR:
                map->DoForAllPlayers([&](Player* player)
                {
                    player->CastSpell(player, SPELL_ADAL_SONG_OF_BATTLE, true);
                });
                break;
            default:
                break;
        }
    });
}

void WorldState::DispelAdalsSongOfBattle()
{
    sMapMgr->DoForAllMaps([&](Map* map) -> void
    {
        switch (map->GetId())
        {
            case MAP_OUTLAND:
                map->DoForAllPlayers([&](Player* player)
                {
                    if (player->GetZoneId() == AREA_SHATTRATH_CITY)
                        player->RemoveAurasDueToSpell(SPELL_ADAL_SONG_OF_BATTLE);
                });
                break;
            case MAP_TEMPEST_KEEP_THE_ARCATRAZ:
            case MAP_TEMPEST_KEEP_THE_BOTANICA:
            case MAP_TEMPEST_KEEP_THE_MECHANAR:
                map->DoForAllPlayers([&](Player* player)
                {
                    player->RemoveAurasDueToSpell(SPELL_ADAL_SONG_OF_BATTLE);
                });
                break;
            default:
                break;
        }
    });
}

void WorldState::SendWorldstateUpdate(std::mutex& mutex, GuidVector const& guids, uint32 value, uint32 worldStateId)
{
    std::lock_guard<std::mutex> guard(mutex);
    for (ObjectGuid const& guid : guids)
        if (Player* player = ObjectAccessor::FindPlayer(guid))
            player->SendUpdateWorldState(worldStateId, value);
}

enum WorldStateSunsReachQuests
{
    QUEST_ERRATIC_BEHAVIOR                  = 11524,
    QUEST_SANCTUM_WARDS                     = 11496,
    QUEST_BATTLE_FOR_THE_SUNS_REACH_ARMORY  = 11538,
    QUEST_DISTRACTION_AT_THE_DEAD_SCAR      = 11532,
    QUEST_INTERCEPTING_THE_MANA_CELLS       = 11513,
    QUEST_INTERCEPT_THE_REINFORCEMENTS      = 11542,
    QUEST_TAKING_THE_HARBOR                 = 11539,
    QUEST_MAKING_READY                      = 11535,
    QUEST_DISCOVERING_YOUR_ROOTS            = 11520,
    QUEST_A_CHARITABLE_DONATION             = 11545,
    QUEST_A_MAGNANIMOUS_BENEFACTOR          = 11549,
    COUNTER_MAX_VAL_REQ                     = 10000,
};

void WorldState::AddSunsReachProgress(uint32 questId)
{
    uint32 counter = 0;
    int32 otherCounter = -1;
    int32 worldState = 0;
    uint32 subPhaseMask = 0;
    uint32 addedValue = 1;
    switch (questId)
    {
        case QUEST_ERRATIC_BEHAVIOR:
            counter = COUNTER_ERRATIC_BEHAVIOR;
            otherCounter = COUNTER_SANCTUM_WARDS;
            worldState = WORLD_STATE_QUEL_DANAS_SANCTUM;
            break;
        case QUEST_SANCTUM_WARDS:
            counter = COUNTER_SANCTUM_WARDS;
            otherCounter = COUNTER_ERRATIC_BEHAVIOR;
            worldState = WORLD_STATE_QUEL_DANAS_SANCTUM;
            break;
        case QUEST_BATTLE_FOR_THE_SUNS_REACH_ARMORY:
            counter = COUNTER_BATTLE_FOR_THE_SUNS_REACH_ARMORY;
            otherCounter = COUNTER_DISTRACTION_AT_THE_DEAD_SCAR;
            worldState = WORLD_STATE_QUEL_DANAS_ARMORY;
            break;
        case QUEST_DISTRACTION_AT_THE_DEAD_SCAR:
            counter = COUNTER_DISTRACTION_AT_THE_DEAD_SCAR;
            otherCounter = COUNTER_BATTLE_FOR_THE_SUNS_REACH_ARMORY;
            worldState = WORLD_STATE_QUEL_DANAS_ARMORY;
            break;
        case QUEST_INTERCEPTING_THE_MANA_CELLS:
            counter = COUNTER_INTERCEPTING_THE_MANA_CELLS;
            subPhaseMask = SUBPHASE_PORTAL;
            worldState = WORLD_STATE_QUEL_DANAS_PORTAL;
            break;
        case QUEST_INTERCEPT_THE_REINFORCEMENTS:
            counter = COUNTER_INTERCEPT_THE_REINFORCEMENTS;
            otherCounter = COUNTER_TAKING_THE_HARBOR;
            worldState = WORLD_STATE_QUEL_DANAS_HARBOR;
            break;
        case QUEST_TAKING_THE_HARBOR:
            counter = COUNTER_TAKING_THE_HARBOR;
            otherCounter = COUNTER_INTERCEPT_THE_REINFORCEMENTS;
            worldState = WORLD_STATE_QUEL_DANAS_HARBOR;
            break;
        case QUEST_MAKING_READY:
            counter = COUNTER_MAKING_READY;
            subPhaseMask = SUBPHASE_ANVIL;
            worldState = WORLD_STATE_QUEL_DANAS_ANVIL;
            break;
        case QUEST_DISCOVERING_YOUR_ROOTS:
            counter = COUNTER_DISCOVERING_YOUR_ROOTS;
            subPhaseMask = SUBPHASE_ALCHEMY_LAB;
            worldState = WORLD_STATE_QUEL_DANAS_ALCHEMY_LAB;
            break;
        case QUEST_A_CHARITABLE_DONATION:
            counter = COUNTER_A_CHARITABLE_DONATION;
            subPhaseMask = SUBPHASE_MONUMENT;
            worldState = WORLD_STATE_QUEL_DANAS_MONUMENT;
            break;
        case QUEST_A_MAGNANIMOUS_BENEFACTOR:
            counter = COUNTER_A_CHARITABLE_DONATION;
            subPhaseMask = SUBPHASE_MONUMENT;
            worldState = WORLD_STATE_QUEL_DANAS_MONUMENT;
            addedValue = 150;
            break;
        default:
            return;
    }

    uint32 previousValue = 0;
    uint32 newValue = 0;

    if (!subPhaseMask)
        previousValue = m_sunsReachData.GetPhasePercentage(m_sunsReachData.m_phase);
    else
        previousValue = m_sunsReachData.GetSubPhasePercentage(subPhaseMask);
    m_sunsReachData.m_sunsReachReclamationCounters[counter] += addedValue;
    if (!subPhaseMask)
        newValue = m_sunsReachData.GetPhasePercentage(m_sunsReachData.m_phase);
    else
        newValue = m_sunsReachData.GetSubPhasePercentage(subPhaseMask);
    if (previousValue != newValue)
        SendWorldstateUpdate(m_sunsReachData.m_sunsReachReclamationMutex, m_sunsReachData.m_sunsReachReclamationPlayers, newValue, worldState);

    bool save = true;
    uint32 counterValue = m_sunsReachData.m_sunsReachReclamationCounters[counter];
    uint32 modifier = 1;
    if (otherCounter != -1)
    {
        modifier = 2;
        counterValue += m_sunsReachData.m_sunsReachReclamationCounters[otherCounter];
    }
    if (counterValue >= sWorld->getIntConfig(CONFIG_SUNSREACH_COUNTER_MAX) * modifier)
    {
        save = false;
        switch (questId)
        {
            case QUEST_ERRATIC_BEHAVIOR:
            case QUEST_SANCTUM_WARDS:
            {
                if (m_sunsReachData.m_phase == SUNS_REACH_PHASE_1_STAGING_AREA)
                    HandleSunsReachPhaseTransition(SUNS_REACH_PHASE_2_SANCTUM);
                break;
            }
            case QUEST_BATTLE_FOR_THE_SUNS_REACH_ARMORY:
            case QUEST_DISTRACTION_AT_THE_DEAD_SCAR:
            {
                if (m_sunsReachData.m_phase == SUNS_REACH_PHASE_2_SANCTUM)
                    HandleSunsReachPhaseTransition(SUNS_REACH_PHASE_3_ARMORY);
                break;
            }
            case QUEST_INTERCEPTING_THE_MANA_CELLS:
            {
                if ((m_sunsReachData.m_subphaseMask & SUBPHASE_PORTAL) == 0)
                    HandleSunsReachSubPhaseTransition(SUBPHASE_PORTAL);
                break;
            }
            case QUEST_INTERCEPT_THE_REINFORCEMENTS:
            case QUEST_TAKING_THE_HARBOR:
            {
                if (m_sunsReachData.m_phase == SUNS_REACH_PHASE_3_ARMORY)
                    HandleSunsReachPhaseTransition(SUNS_REACH_PHASE_4_HARBOR);
                break;
            }
            case QUEST_MAKING_READY:
            {
                if ((m_sunsReachData.m_subphaseMask & SUBPHASE_ANVIL) == 0)
                    HandleSunsReachSubPhaseTransition(SUBPHASE_ANVIL);
                break;
            }
            case QUEST_DISCOVERING_YOUR_ROOTS:
            {
                if ((m_sunsReachData.m_subphaseMask & SUBPHASE_ALCHEMY_LAB) == 0)
                    HandleSunsReachSubPhaseTransition(SUBPHASE_ALCHEMY_LAB);
                break;
            }
            case QUEST_A_CHARITABLE_DONATION:
            case QUEST_A_MAGNANIMOUS_BENEFACTOR:
            {
                if ((m_sunsReachData.m_subphaseMask & SUBPHASE_MONUMENT) == 0)
                    HandleSunsReachSubPhaseTransition(SUBPHASE_MONUMENT);
                break;
            }
        }
    }
    if (save)
        Save(SAVE_ID_QUEL_DANAS);
}

void WorldState::HandleSunsReachPhaseTransition(uint32 newPhase)
{
    if (newPhase < m_sunsReachData.m_phase)
    {
        while (newPhase != m_sunsReachData.m_phase)
        {
            StopSunsReachPhase(newPhase > m_sunsReachData.m_phase);
            --m_sunsReachData.m_phase;
        }
        StartSunsReachPhase();
    }
    else
    {
        StopSunsReachPhase(newPhase > m_sunsReachData.m_phase);
        bool moreThanOne = newPhase > m_sunsReachData.m_phase + 1; // custom command case
        m_sunsReachData.m_phase = newPhase;
        StartSunsReachPhase(moreThanOne);
    }
    switch (m_sunsReachData.m_phase)
    {
        case SUNS_REACH_PHASE_2_SANCTUM: if ((m_sunsReachData.m_subphaseMask & SUBPHASE_PORTAL) == 0) sGameEventMgr->StartEvent(GAME_EVENT_QUEL_DANAS_PHASE_2_NO_PORTAL); break;
        case SUNS_REACH_PHASE_3_ARMORY: if ((m_sunsReachData.m_subphaseMask & SUBPHASE_ANVIL) == 0) sGameEventMgr->StartEvent(GAME_EVENT_QUEL_DANAS_PHASE_3_NO_ANVIL); break;
        case SUNS_REACH_PHASE_4_HARBOR:
            if ((m_sunsReachData.m_subphaseMask & SUBPHASE_ALCHEMY_LAB) == 0) sGameEventMgr->StartEvent(GAME_EVENT_QUEL_DANAS_PHASE_4_NO_MONUMENT);
            if ((m_sunsReachData.m_subphaseMask & SUBPHASE_MONUMENT) == 0) sGameEventMgr->StartEvent(GAME_EVENT_QUEL_DANAS_PHASE_4_NO_ALCHEMY_LAB);
            break;
        default: break;
    }
    SendWorldstateUpdate(m_sunsReachData.m_sunsReachReclamationMutex, m_sunsReachData.m_sunsReachReclamationPlayers, m_sunsReachData.m_phase, WORLD_STATE_QUEL_DANAS_MUSIC);
    Save(SAVE_ID_QUEL_DANAS);
}

void WorldState::HandleSunsReachSubPhaseTransition(int32 subPhaseMask, bool initial)
{
    bool start = true;
    if (subPhaseMask < 0)
    {
        start = false;
        subPhaseMask = -subPhaseMask;
    }
    bool all = false;
    if (start)
    {
        m_sunsReachData.m_subphaseMask |= subPhaseMask;
        if ((m_sunsReachData.m_subphaseMask & SUBPHASE_ALL) == SUBPHASE_ALL)
            all = true;
    }
    else
    {
        if ((m_sunsReachData.m_subphaseMask & SUBPHASE_ALL) == SUBPHASE_ALL)
            all = true;
        m_sunsReachData.m_subphaseMask &= ~subPhaseMask;
    }
    if (initial)
    {
        if (m_sunsReachData.m_phase >= SUNS_REACH_PHASE_2_SANCTUM)
            if ((subPhaseMask & SUBPHASE_PORTAL) == 0)
                sGameEventMgr->StartEvent(GAME_EVENT_QUEL_DANAS_PHASE_2_NO_PORTAL);
        if (m_sunsReachData.m_phase >= SUNS_REACH_PHASE_3_ARMORY)
            if ((subPhaseMask & SUBPHASE_ANVIL) == 0)
                sGameEventMgr->StartEvent(GAME_EVENT_QUEL_DANAS_PHASE_3_NO_ANVIL);
        if (m_sunsReachData.m_phase >= SUNS_REACH_PHASE_4_HARBOR)
        {
            if ((subPhaseMask & SUBPHASE_ALCHEMY_LAB) == 0)
                sGameEventMgr->StartEvent(GAME_EVENT_QUEL_DANAS_PHASE_4_NO_ALCHEMY_LAB);
            if ((subPhaseMask & SUBPHASE_MONUMENT) == 0)
                sGameEventMgr->StartEvent(GAME_EVENT_QUEL_DANAS_PHASE_4_NO_MONUMENT);
        }
    }
    if ((subPhaseMask & SUBPHASE_PORTAL))
    {
        uint32 first = GAME_EVENT_QUEL_DANAS_PHASE_2_NO_PORTAL;
        uint32 second = GAME_EVENT_QUEL_DANAS_PHASE_2_PORTAL;
        if (start)
        {
            sGameEventMgr->StopEvent(first);
            sGameEventMgr->StartEvent(second);
        }
        else
        {
            sGameEventMgr->StopEvent(second);
            sGameEventMgr->StartEvent(first);
        }
    }
    if ((subPhaseMask & SUBPHASE_ANVIL))
    {
        uint32 first = GAME_EVENT_QUEL_DANAS_PHASE_3_NO_ANVIL;
        uint32 second = GAME_EVENT_QUEL_DANAS_PHASE_3_ANVIL;
        if (start)
        {
            sGameEventMgr->StopEvent(first);
            sGameEventMgr->StartEvent(second);
        }
        else
        {
            sGameEventMgr->StopEvent(second);
            sGameEventMgr->StartEvent(first);
        }
    }
    if ((subPhaseMask & SUBPHASE_ALCHEMY_LAB))
    {
        uint32 first = GAME_EVENT_QUEL_DANAS_PHASE_4_NO_ALCHEMY_LAB;
        uint32 second = GAME_EVENT_QUEL_DANAS_PHASE_4_ALCHEMY_LAB;
        if (start)
        {
            sGameEventMgr->StopEvent(first);
            sGameEventMgr->StartEvent(second);
        }
        else
        {
            sGameEventMgr->StopEvent(second);
            sGameEventMgr->StartEvent(first);
        }
    }
    if ((subPhaseMask & SUBPHASE_MONUMENT))
    {
        uint32 first = GAME_EVENT_QUEL_DANAS_PHASE_4_NO_MONUMENT;
        uint32 second = GAME_EVENT_QUEL_DANAS_PHASE_4_MONUMENT;
        if (start)
        {
            sGameEventMgr->StopEvent(first);
            sGameEventMgr->StartEvent(second);
        }
        else
        {
            sGameEventMgr->StopEvent(second);
            sGameEventMgr->StartEvent(first);
        }
    }
    if (all)
    {
        if (start)
            sGameEventMgr->StartEvent(GAME_EVENT_QUEL_DANAS_PHASE_4_KIRU);
        else
            sGameEventMgr->StopEvent(GAME_EVENT_QUEL_DANAS_PHASE_4_KIRU);

        if (!initial)
        {
            std::lock_guard<std::mutex> guard(m_sunsReachData.m_sunsReachReclamationMutex);
            for (ObjectGuid const& guid : m_sunsReachData.m_sunsReachReclamationPlayers)
                if (Player* player = ObjectAccessor::FindPlayer(guid))
                {
                    if (start)
                        player->CastSpell(player, SPELL_KIRU_SONG_OF_VICTORY, true);
                    else
                        player->RemoveAurasDueToSpell(SPELL_KIRU_SONG_OF_VICTORY);
                }
        }
    }
    if (!initial)
        Save(SAVE_ID_QUEL_DANAS);
}

void WorldState::HandleSunwellGateTransition(uint32 newGate)
{
    if (newGate < m_sunsReachData.m_gate)
    {
        while (newGate != m_sunsReachData.m_gate)
        {
            StopSunwellGatePhase();
            --m_sunsReachData.m_gate;
        }
        StartSunwellGatePhase();
    }
    else
    {
        StopSunwellGatePhase();
        m_sunsReachData.m_gate = newGate;
        StartSunwellGatePhase();
    }
    int32 worldState = 0;
    switch (newGate)
    {
        case SUNWELL_AGAMATH_GATE1_OPEN: worldState = WORLD_STATE_AGAMATH_THE_FIRST_GATE_HEALTH; break;
        case SUNWELL_ROHENDOR_GATE2_OPEN: worldState = WORLD_STATE_ROHENDOR_THE_SECOND_GATE_HEALTH; break;
        case SUNWELL_ARCHONISUS_GATE3_OPEN: worldState = WORLD_STATE_ARCHONISUS_THE_FINAL_GATE_HEALTH; break;
    }
    if (worldState)
        SendWorldstateUpdate(m_sunsReachData.m_sunsReachReclamationMutex, m_sunsReachData.m_sunsReachReclamationPlayers, m_sunsReachData.m_gate, worldState);

    Save(SAVE_ID_QUEL_DANAS);
}

void WorldState::SetSunsReachCounter(SunsReachCounters index, uint32 value)
{
    m_sunsReachData.m_sunsReachReclamationCounters[index] = value;
}

void WorldState::StopSunsReachPhase(bool forward)
{
    switch (m_sunsReachData.m_phase)
    {
        case SUNS_REACH_PHASE_1_STAGING_AREA: sGameEventMgr->StopEvent(GAME_EVENT_QUEL_DANAS_PHASE_1); break;
        case SUNS_REACH_PHASE_2_SANCTUM: sGameEventMgr->StopEvent(GAME_EVENT_QUEL_DANAS_PHASE_2_ONLY); if (!forward) sGameEventMgr->StopEvent(GAME_EVENT_QUEL_DANAS_PHASE_2_PERMANENT); break;
        case SUNS_REACH_PHASE_3_ARMORY: sGameEventMgr->StopEvent(GAME_EVENT_QUEL_DANAS_PHASE_3_ONLY); if (!forward) sGameEventMgr->StopEvent(GAME_EVENT_QUEL_DANAS_PHASE_3_PERMANENT); break;
        case SUNS_REACH_PHASE_4_HARBOR: sGameEventMgr->StopEvent(GAME_EVENT_QUEL_DANAS_PHASE_4); break;
        default: break;
    }
}

void WorldState::StartSunsReachPhase(bool initial)
{
    switch (m_sunsReachData.m_phase)
    {
        case SUNS_REACH_PHASE_1_STAGING_AREA:
            sGameEventMgr->StartEvent(GAME_EVENT_QUEL_DANAS_PHASE_1);
            if (Map* map = sMapMgr->FindBaseNonInstanceMap(MAP_OUTLAND))
                map->SetZoneWeather(AREA_ISLE_OF_QUEL_DANAS, WEATHER_STATE_MEDIUM_RAIN, 0.75f);
            break;
        case SUNS_REACH_PHASE_2_SANCTUM:
            sGameEventMgr->StartEvent(GAME_EVENT_QUEL_DANAS_PHASE_2_ONLY);
            sGameEventMgr->StartEvent(GAME_EVENT_QUEL_DANAS_PHASE_2_PERMANENT);
            if (Map* map = sMapMgr->FindBaseNonInstanceMap(MAP_OUTLAND))
                map->SetZoneWeather(AREA_ISLE_OF_QUEL_DANAS, WEATHER_STATE_LIGHT_RAIN, 0.5f);
            break;
        case SUNS_REACH_PHASE_3_ARMORY:
            if (initial)
                sGameEventMgr->StartEvent(GAME_EVENT_QUEL_DANAS_PHASE_2_PERMANENT);
            sGameEventMgr->StartEvent(GAME_EVENT_QUEL_DANAS_PHASE_3_ONLY); sGameEventMgr->StartEvent(GAME_EVENT_QUEL_DANAS_PHASE_3_PERMANENT);
            // TODO: Should be id 2 0.25f?
            if (Map* map = sMapMgr->FindBaseNonInstanceMap(MAP_OUTLAND))
                map->SetZoneWeather(AREA_ISLE_OF_QUEL_DANAS, WEATHER_STATE_LIGHT_RAIN, 0.25f);
            break;
        case SUNS_REACH_PHASE_4_HARBOR:
            if (initial)
            {
                sGameEventMgr->StartEvent(GAME_EVENT_QUEL_DANAS_PHASE_2_PERMANENT);
                sGameEventMgr->StartEvent(GAME_EVENT_QUEL_DANAS_PHASE_3_PERMANENT);
            }
            sGameEventMgr->StartEvent(GAME_EVENT_QUEL_DANAS_PHASE_4);
            if (Map* map = sMapMgr->FindBaseNonInstanceMap(MAP_OUTLAND))
                map->SetZoneWeather(AREA_ISLE_OF_QUEL_DANAS, WEATHER_STATE_FINE, 0.0f);
            break;
        default: break;
    }
}

std::string WorldState::GetSunsReachPrintout()
{
    auto formatPhase = [this]() -> std::string {
        std::string name;
        switch (m_sunsReachData.m_phase)
        {
            case SUNS_REACH_PHASE_1_STAGING_AREA: name = "Phase 1: Staging Area"; break;
            case SUNS_REACH_PHASE_2_SANCTUM: name = "Phase 2: Sanctum"; break;
            case SUNS_REACH_PHASE_3_ARMORY: name = "Phase 3: Armory"; break;
            case SUNS_REACH_PHASE_4_HARBOR: name = "Phase 4: Harbor"; break;
            default: name = "Unknown"; break;
        }
        return "Phase: " + std::to_string(m_sunsReachData.m_phase) + " (" + name + ") " + std::to_string(m_sunsReachData.GetPhasePercentage(m_sunsReachData.m_phase)) + "%\n";
    };

    auto formatSubPhase = [this](uint32 subPhase) -> std::string {
        std::string name;
        switch (subPhase)
        {
            case SUBPHASE_PORTAL: name = "Portal"; break;
            case SUBPHASE_ANVIL: name = "Anvil"; break;
            case SUBPHASE_ALCHEMY_LAB: name = "Alchemy Lab"; break;
            case SUBPHASE_MONUMENT: name = "Monument"; break;
            default: name = "Unknown"; break;
        }
        return name + ": " + (m_sunsReachData.m_subphaseMask & subPhase ? "100%" : std::to_string(m_sunsReachData.GetSubPhasePercentage(subPhase)) + "%");
    };

    auto formatCounter = [](uint32 counter, uint32 value) -> std::string {
        switch (counter)
        {
            case COUNTER_ERRATIC_BEHAVIOR:
                return "Erratic Behavior: " + std::to_string(value) + " (counts towards Phase 2: Sanctum)";
            case COUNTER_SANCTUM_WARDS:
                return "Sanctum Wards: " + std::to_string(value) + " (counts towards Phase 2: Sanctum)";
            case COUNTER_BATTLE_FOR_THE_SUNS_REACH_ARMORY:
                return "Battle for the Sun's Reach Armory: " + std::to_string(value) + " (counts towards Phase 3: Armory)";
            case COUNTER_DISTRACTION_AT_THE_DEAD_SCAR:
                return "Distraction at the Dead Scar: " + std::to_string(value) + " (counts towards Phase 3: Armory)";
            case COUNTER_INTERCEPTING_THE_MANA_CELLS:
                return "Intercepting the Mana Cells: " + std::to_string(value) + " (counts towards Subphase: Portal)";
            case COUNTER_INTERCEPT_THE_REINFORCEMENTS:
                return "Intercept the Reinforcements: " + std::to_string(value) + " (counts towards Phase 4: Harbor)";
            case COUNTER_TAKING_THE_HARBOR:
                return "Taking the Harbor: " + std::to_string(value) + " (counts towards Phase 4: Harbor)";
            case COUNTER_MAKING_READY:
                return "Making Ready: " + std::to_string(value) + " (counts towards Subphase: Anvil)";
            case COUNTER_DISCOVERING_YOUR_ROOTS:
                return "Discovering Your Roots: " + std::to_string(value) + " (counts towards Subphase: Alchemy Lab)";
            case COUNTER_A_CHARITABLE_DONATION:
                return "A Charitable Donation: " + std::to_string(value) + " (counts towards Subphase: Monument)";
            default:
                return "Unknown: " + std::to_string(value) + " (Unknown goal)";
        }
    };

    std::string output = formatPhase();
    output += "Subphase mask: " + std::to_string(m_sunsReachData.m_subphaseMask) + "\n";
    for (uint32 i = 0; i < 4; ++i)
    {
        uint32 subPhaseMask = 1 << i;
        output += "  " + formatSubPhase(subPhaseMask) + "\n";
    }
    output += "Counters:\n";
    output += "  Sunsreach.CounterMax = " + std::to_string(sWorld->getIntConfig(CONFIG_SUNSREACH_COUNTER_MAX)) + "\n";
    for (uint32 i = 0; i < COUNTERS_MAX; ++i)
        output += "  " + std::to_string(i) + ". " + formatCounter(i, m_sunsReachData.m_sunsReachReclamationCounters[i]) + "\n";

    // Sunwell Gates
    auto formatGatePhase = [](uint32 gate) -> std::string {
        switch (gate)
        {
            case SUNWELL_ALL_GATES_CLOSED: return "All Gates Closed"; break;
            case SUNWELL_AGAMATH_GATE1_OPEN: return "Gate 1 Agamath Open"; break;
            case SUNWELL_ROHENDOR_GATE2_OPEN: return "Gate 2 Rohendar Open"; break;
            case SUNWELL_ARCHONISUS_GATE3_OPEN: return "Gate 3 Archonisus Open"; break;
            default: return "Unknown"; break;
        }
    };
    output += "Sunwell Plateau Gate Phase " + std::to_string(m_sunsReachData.m_gate) + " (" + formatGatePhase(m_sunsReachData.m_gate) + ")" + ":\n";
    output += "  0. Gate 1 (Agamath): " + std::string(m_sunsReachData.m_gate >= SUNWELL_AGAMATH_GATE1_OPEN ? "Open " : "Closed ") + std::to_string(m_sunsReachData.m_gateCounters[COUNTER_AGAMATH_THE_FIRST_GATE]) + " (" + std::to_string(m_sunsReachData.GetSunwellGatePercentage(SUNWELL_ALL_GATES_CLOSED)) + "%)\n";
    output += "  1. Gate 2 (Rohendor): " + std::string(m_sunsReachData.m_gate >= SUNWELL_ROHENDOR_GATE2_OPEN ? "Open " : "Closed ") + std::to_string(m_sunsReachData.m_gateCounters[COUNTER_ROHENDOR_THE_SECOND_GATE]) +  " (" + std::to_string(m_sunsReachData.GetSunwellGatePercentage(SUNWELL_AGAMATH_GATE1_OPEN)) + "%)\n";
    output += "  2. Gate 3 (Archonisus): " + std::string(m_sunsReachData.m_gate >= SUNWELL_ARCHONISUS_GATE3_OPEN ? "Open " : "Closed ") + std::to_string(m_sunsReachData.m_gateCounters[COUNTER_ARCHONISUS_THE_FINAL_GATE]) + " (" + std::to_string(m_sunsReachData.GetSunwellGatePercentage(SUNWELL_ROHENDOR_GATE2_OPEN)) + "%)\n";
    return output;
}

std::string WorldState::GetScourgeInvasionPrintout()
{
    std::lock_guard<std::mutex> guard(m_siData.m_siMutex);
    std::string output = "Scourge Invasion Status:\n";

    auto formatState = [this]() -> std::string
    {
        switch (m_siData.m_state)
        {
            case STATE_0_DISABLED:
                return "Disabled";
            case STATE_1_ENABLED:
                return "Enabled";
            default:
                return "Unknown";
        }
    };
    auto formatRemaining = [this](SIRemaining val, char const* name) { return "  " + std::string(name) + ": " + std::to_string(m_siData.m_remaining[val]) + "\n"; };

    output += "State: " + formatState() + " (" + std::to_string(static_cast<uint32>(m_siData.m_state)) + ")\n";
    output += "Battles Won: " + std::to_string(m_siData.m_battlesWon) + "\n";
    output += "Last Attack Zone ID: " + std::to_string(m_siData.m_lastAttackZone) + "\n";

    output += "Zone Necropolis Count Remaining:\n";
    output += formatRemaining(SI_REMAINING_WINTERSPRING, "Winterspring");
    output += formatRemaining(SI_REMAINING_AZSHARA, "Azshara");
    output += formatRemaining(SI_REMAINING_BLASTED_LANDS, "Blasted Lands");
    output += formatRemaining(SI_REMAINING_BURNING_STEPPES, "Burning Steppes");
    output += formatRemaining(SI_REMAINING_TANARIS, "Tanaris");
    output += formatRemaining(SI_REMAINING_EASTERN_PLAGUELANDS, "Eastern Plaguelands");

    output += "Zone Timers (time until next event):\n";
    TimePoint now = std::chrono::steady_clock::now();
    auto formatTimer = [this](SITimers timerId, char const* name, TimePoint now)
    {
        TimePoint tp = m_siData.m_timers[timerId];
        std::string timerStr;
        if (tp == TimePoint())
            timerStr = "Not set";
        else if (tp <= now)
            timerStr = "Elapsed";
        else
        {
            auto diff = std::chrono::duration_cast<std::chrono::seconds>(tp - now);
            timerStr = std::to_string(diff.count()) + "s remaining";
        }
        return "  " + std::string(name) + ": " + timerStr + "\n";
    };

    output += formatTimer(SI_TIMER_WINTERSPRING, "Winterspring Invasion", now);
    output += formatTimer(SI_TIMER_AZSHARA, "Azshara Invasion", now);
    output += formatTimer(SI_TIMER_BLASTED_LANDS, "Blasted Lands Invasion", now);
    output += formatTimer(SI_TIMER_BURNING_STEPPES, "Burning Steppes Invasion", now);
    output += formatTimer(SI_TIMER_TANARIS, "Tanaris Invasion", now);
    output += formatTimer(SI_TIMER_EASTERN_PLAGUELANDS, "Eastern Plaguelands Invasion", now);
    output += formatTimer(SI_TIMER_STORMWIND, "Stormwind City Attack", now);
    output += formatTimer(SI_TIMER_UNDERCITY, "Undercity Attack", now);

    return output;
}

std::string SunsReachReclamationData::GetData()
{
    std::string output = std::to_string(m_phase) + " " + std::to_string(m_subphaseMask);
    for (uint32 value : m_sunsReachReclamationCounters)
        output += " " + std::to_string(value);
    output += " " + std::to_string(m_gate);
    for (uint32 value : m_gateCounters)
        output += " " + std::to_string(value);
    return output;
}

uint32 SunsReachReclamationData::GetPhasePercentage(uint32 phase)
{
    switch (phase)
    {
        case SUNS_REACH_PHASE_1_STAGING_AREA: return uint32((m_sunsReachReclamationCounters[COUNTER_ERRATIC_BEHAVIOR] + m_sunsReachReclamationCounters[COUNTER_SANCTUM_WARDS]) * 100 / (2 * sWorld->getIntConfig(CONFIG_SUNSREACH_COUNTER_MAX)));
        case SUNS_REACH_PHASE_2_SANCTUM: return uint32((m_sunsReachReclamationCounters[COUNTER_BATTLE_FOR_THE_SUNS_REACH_ARMORY] + m_sunsReachReclamationCounters[COUNTER_DISTRACTION_AT_THE_DEAD_SCAR]) * 100 / (2 * sWorld->getIntConfig(CONFIG_SUNSREACH_COUNTER_MAX)));
        case SUNS_REACH_PHASE_3_ARMORY: return uint32((m_sunsReachReclamationCounters[COUNTER_INTERCEPT_THE_REINFORCEMENTS] + m_sunsReachReclamationCounters[COUNTER_TAKING_THE_HARBOR]) * 100 / (2 * sWorld->getIntConfig(CONFIG_SUNSREACH_COUNTER_MAX)));
        default: return 0;
    }
}

uint32 SunsReachReclamationData::GetSubPhasePercentage(uint32 subPhase)
{
    switch (subPhase)
    {
        case SUBPHASE_PORTAL: return uint32(m_sunsReachReclamationCounters[COUNTER_INTERCEPTING_THE_MANA_CELLS] * 100 / sWorld->getIntConfig(CONFIG_SUNSREACH_COUNTER_MAX));
        case SUBPHASE_ANVIL: return uint32(m_sunsReachReclamationCounters[COUNTER_MAKING_READY] * 100 / sWorld->getIntConfig(CONFIG_SUNSREACH_COUNTER_MAX));
        case SUBPHASE_ALCHEMY_LAB: return uint32(m_sunsReachReclamationCounters[COUNTER_DISCOVERING_YOUR_ROOTS] * 100 / sWorld->getIntConfig(CONFIG_SUNSREACH_COUNTER_MAX));
        case SUBPHASE_MONUMENT: return uint32(m_sunsReachReclamationCounters[COUNTER_A_CHARITABLE_DONATION] * 100 / sWorld->getIntConfig(CONFIG_SUNSREACH_COUNTER_MAX));
        default: return 0;
    }
}

enum WorldStateSunwellGateQuests
{
    // Sunwell Plateau PTR progressive release gates
    QUEST_AGAMATH_THE_FIRST_GATE            = 11551,
    QUEST_ROHENDOR_THE_SECOND_GATE          = 11552,
    QUEST_ARCHONISUS_THE_FINAL_GATE         = 11553,
    COUNTER_MAX_VAL_REQ_SWP_GATES           = 80,
};

void WorldState::AddSunwellGateProgress(uint32 questId)
{
    uint32 counter = 0;
    int32 worldState = 0;
    uint32 addedValue = 1;
    switch (questId)
    {
        case QUEST_AGAMATH_THE_FIRST_GATE:
        case QUEST_ROHENDOR_THE_SECOND_GATE:
        case QUEST_ARCHONISUS_THE_FINAL_GATE:
            break;
        default: return;
    }
    switch (m_sunsReachData.m_gate)
    {
        case SUNWELL_ALL_GATES_CLOSED: counter = COUNTER_AGAMATH_THE_FIRST_GATE; worldState = WORLD_STATE_AGAMATH_THE_FIRST_GATE_HEALTH; break;
        case SUNWELL_AGAMATH_GATE1_OPEN: counter = COUNTER_ROHENDOR_THE_SECOND_GATE; worldState = WORLD_STATE_ROHENDOR_THE_SECOND_GATE_HEALTH; break;
        case SUNWELL_ROHENDOR_GATE2_OPEN: counter = COUNTER_ARCHONISUS_THE_FINAL_GATE; worldState = WORLD_STATE_ARCHONISUS_THE_FINAL_GATE_HEALTH; break;
        default: return;
    }
    uint32 previousValue = m_sunsReachData.GetSunwellGatePercentage(m_sunsReachData.m_gate);
    uint32 newValue = 0;
    m_sunsReachData.m_gateCounters[counter] += addedValue;
    newValue = m_sunsReachData.GetSunwellGatePercentage(m_sunsReachData.m_gate);
    if (previousValue != newValue)
        SendWorldstateUpdate(m_sunsReachData.m_sunsReachReclamationMutex, m_sunsReachData.m_sunsReachReclamationPlayers, newValue, worldState);
    bool save = true;
    if (m_sunsReachData.m_gateCounters[counter] >= COUNTER_MAX_VAL_REQ_SWP_GATES)
    {
        save = false;
        switch (questId)
        {
            case QUEST_AGAMATH_THE_FIRST_GATE:
            {
                if (m_sunsReachData.m_gate == SUNWELL_ALL_GATES_CLOSED)
                    HandleSunwellGateTransition(SUNWELL_AGAMATH_GATE1_OPEN);
                break;
            }
            case QUEST_ROHENDOR_THE_SECOND_GATE:
            {
                if (m_sunsReachData.m_gate == SUNWELL_AGAMATH_GATE1_OPEN)
                    HandleSunwellGateTransition(SUNWELL_ROHENDOR_GATE2_OPEN);
                break;
            }
            case QUEST_ARCHONISUS_THE_FINAL_GATE:
            {
                if (m_sunsReachData.m_gate == SUNWELL_ROHENDOR_GATE2_OPEN)
                    HandleSunwellGateTransition(SUNWELL_ARCHONISUS_GATE3_OPEN);
                break;
            }
        }
    }
    if (save)
        Save(SAVE_ID_QUEL_DANAS);
}

void WorldState::SetSunwellGateCounter(SunwellGateCounters index, uint32 value)
{
    m_sunsReachData.m_gateCounters[index] = value;
}

void WorldState::StartSunwellGatePhase()
{
    switch (m_sunsReachData.m_gate)
    {
        case SUNWELL_ALL_GATES_CLOSED: sGameEventMgr->StartEvent(GAME_EVENT_SWP_GATES_PHASE_0); break;
        case SUNWELL_AGAMATH_GATE1_OPEN: sGameEventMgr->StartEvent(GAME_EVENT_SWP_GATES_PHASE_1); break;
        case SUNWELL_ROHENDOR_GATE2_OPEN: sGameEventMgr->StartEvent(GAME_EVENT_SWP_GATES_PHASE_2); break;
        case SUNWELL_ARCHONISUS_GATE3_OPEN: sGameEventMgr->StartEvent(GAME_EVENT_SWP_GATES_PHASE_3); break;
        default: break;
    }
}

void WorldState::StopSunwellGatePhase()
{
    switch (m_sunsReachData.m_gate)
    {
        case SUNWELL_ALL_GATES_CLOSED: sGameEventMgr->StopEvent(GAME_EVENT_SWP_GATES_PHASE_0); break;
        case SUNWELL_AGAMATH_GATE1_OPEN: sGameEventMgr->StopEvent(GAME_EVENT_SWP_GATES_PHASE_1); break;
        case SUNWELL_ROHENDOR_GATE2_OPEN: sGameEventMgr->StopEvent(GAME_EVENT_SWP_GATES_PHASE_2); break;
        case SUNWELL_ARCHONISUS_GATE3_OPEN: sGameEventMgr->StopEvent(GAME_EVENT_SWP_GATES_PHASE_3); break;
        default: break;
    }
}

uint32 SunsReachReclamationData::GetSunwellGatePercentage(uint32 gate)
{
    int32 percentage = 0;
    switch (gate)
    {
        case SUNWELL_ALL_GATES_CLOSED:
            percentage = 100 - int32(m_gateCounters[COUNTER_AGAMATH_THE_FIRST_GATE] * 100 / COUNTER_MAX_VAL_REQ_SWP_GATES);
            break;
        case SUNWELL_AGAMATH_GATE1_OPEN:
            percentage = 100 - int32(m_gateCounters[COUNTER_ROHENDOR_THE_SECOND_GATE] * 100 / COUNTER_MAX_VAL_REQ_SWP_GATES);
            break;
        case SUNWELL_ROHENDOR_GATE2_OPEN:
            percentage = 100 - int32(m_gateCounters[COUNTER_ARCHONISUS_THE_FINAL_GATE] * 100 / COUNTER_MAX_VAL_REQ_SWP_GATES);
            break;
        default:
            return 0;
    }
    return percentage < 0 ? 0 : uint32(percentage);
}

void WorldState::SetScourgeInvasionState(SIState state)
{
    SIState oldState = m_siData.m_state;
    if (oldState == state)
        return;

    m_siData.m_state = state;
    if (oldState == STATE_0_DISABLED)
        StartScourgeInvasion(true);
    else if (state == STATE_0_DISABLED)
        StopScourgeInvasion();
    Save(SAVE_ID_SCOURGE_INVASION);
}

void WorldState::SendScourgeInvasionMail()
{
    QueryResult result = CharacterDatabase.Query("SELECT guid FROM characters WHERE level >= 50");
    if (result)
    {
        CharacterDatabaseTransaction trans = CharacterDatabase.BeginTransaction();
        MailDraft draft(MAIL_TEMPLATE_ARGENT_DAWN_NEEDS_YOUR_HELP);
        uint32 count = 0;
        do
        {
            Field* fields = result->Fetch();
            ObjectGuid playerGUID = ObjectGuid::Create<HighGuid::Player>(fields[0].Get<uint32>());

            // Add item manually. SendMailTo does not add items for offline players
            if (Item* item = Item::CreateItem(ITEM_A_LETTER_FROM_THE_KEEPER_OF_THE_ROLLS, 1))
            {
                item->SaveToDB(trans);
                draft.AddItem(item);
            }

            draft.SendMailTo(trans, MailReceiver(playerGUID.GetCounter()), NPC_ARGENT_EMISSARY, MAIL_CHECK_MASK_HAS_BODY);
            ++count;
        } while (result->NextRow());
        CharacterDatabase.CommitTransaction(trans);
        LOG_INFO("WorldState", "SendScourgeInvasionMail sent to {} characters", count);
    }
}

void WorldState::StartScourgeInvasion(bool sendMail)
{
    sGameEventMgr->StartEvent(GAME_EVENT_SCOURGE_INVASION, false);

    if (sendMail)
        SendScourgeInvasionMail();

    BroadcastSIWorldstates();
    if (m_siData.m_state == STATE_1_ENABLED)
    {
        for (auto& zone : m_siData.m_cityAttacks)
        {
            if (zone.second.zoneId == AREA_UNDERCITY)
                StartNewCityAttackIfTime(SI_TIMER_UNDERCITY, zone.second.zoneId);
            else if (zone.second.zoneId == AREA_STORMWIND_CITY)
                StartNewCityAttackIfTime(SI_TIMER_STORMWIND, zone.second.zoneId);
        }

        // randomization of init so that not every invasion starts the same way
        std::vector<uint32> randomIds;
        randomIds.reserve(m_siData.m_activeInvasions.size());
        for (auto const& [zoneId, _] : m_siData.m_activeInvasions)
            randomIds.push_back(zoneId);
        Acore::Containers::RandomShuffle(randomIds);
        for (uint32 id : randomIds)
            OnEnable(m_siData.m_activeInvasions[id]);

        sGameEventMgr->StartEvent(GAME_EVENT_SCOURGE_INVASION_BOSSES);
    }
}

ScourgeInvasionData::ScourgeInvasionData()
    : m_state(STATE_0_DISABLED), m_battlesWon(0), m_lastAttackZone(0), m_remaining{}, m_broadcastTimer(10000)
{
    m_activeInvasions.emplace(
        AREA_WINTERSPRING,
        InvasionZone{
            .map = MAP_KALIMDOR,
            .zoneId = AREA_WINTERSPRING,
            .necropolisCount = 3,
            .remainingNecropoli = SI_REMAINING_WINTERSPRING,
            .mouth = { Position{7736.56f, -4033.75f, 696.327f, 5.51524f} }
        }
    );
    m_activeInvasions.emplace(
        AREA_TANARIS,
        InvasionZone{
            .map = MAP_KALIMDOR,
            .zoneId = AREA_TANARIS,
            .necropolisCount = 3,
            .remainingNecropoli = SI_REMAINING_TANARIS,
            .mouth = { Position{-8352.68f, -3972.68f, 10.0753f, 2.14675f} }
        }
    );
    m_activeInvasions.emplace(
        AREA_AZSHARA,
        InvasionZone{
            .map = MAP_KALIMDOR,
            .zoneId = AREA_AZSHARA,
            .necropolisCount = 2,
            .remainingNecropoli = SI_REMAINING_AZSHARA,
            .mouth = { Position{3273.75f, -4276.98f, 125.509f, 5.44543f} }
        }
    );
    m_activeInvasions.emplace(
        AREA_BLASTED_LANDS,
        InvasionZone{
            .map = MAP_EASTERN_KINGDOMS,
            .zoneId = AREA_BLASTED_LANDS,
            .necropolisCount = 2,
            .remainingNecropoli = SI_REMAINING_BLASTED_LANDS,
            .mouth = { Position{-11429.3f, -3327.82f, 7.73628f, 1.0821f} }
        }
    );
    m_activeInvasions.emplace(
        AREA_EASTERN_PLAGUELANDS,
        InvasionZone{
            .map = MAP_EASTERN_KINGDOMS,
            .zoneId = AREA_EASTERN_PLAGUELANDS,
            .necropolisCount = 2,
            .remainingNecropoli = SI_REMAINING_EASTERN_PLAGUELANDS,
            .mouth = { Position{2014.55f, -4934.52f, 73.9846f, 0.0698132f} }
        }
    );
    m_activeInvasions.emplace(
        AREA_BURNING_STEPPES,
        InvasionZone{
            .map = MAP_EASTERN_KINGDOMS,
            .zoneId = AREA_BURNING_STEPPES,
            .necropolisCount = 2,
            .remainingNecropoli = SI_REMAINING_BURNING_STEPPES,
            .mouth = { Position{-8229.53f, -1118.11f, 144.012f, 6.17846f} }
        }
    );

    m_cityAttacks.emplace(
        AREA_UNDERCITY,
        CityAttack{
            .map = MAP_EASTERN_KINGDOMS,
            .zoneId = AREA_UNDERCITY,
            .pallid = {
                Position{1595.87f, 440.539f, -46.3349f, 2.28207f}, // Royal Quarter
                Position{1659.2f, 265.988f, -62.1788f, 3.64283f}   // Trade Quarter
            }
        }
    );
    m_cityAttacks.emplace(
        AREA_STORMWIND_CITY,
        CityAttack{
            .map = MAP_EASTERN_KINGDOMS,
            .zoneId = AREA_STORMWIND_CITY,
            .pallid = {
                Position{-8578.15f, 886.382f, 87.3148f, 0.586275f}, // Stormwind Keep
                Position{-8578.15f, 886.382f, 87.3148f, 0.586275f}  // Trade District
            }
        }
    );
}

void ScourgeInvasionData::Reset()
{
    std::lock_guard<std::mutex> guard(m_siMutex);
    for (auto& timepoint : m_timers)
        timepoint = TimePoint();

    m_battlesWon = 0;
    m_lastAttackZone = 0;
    m_broadcastTimer = 10000;
    memset(m_remaining, 0, sizeof(m_remaining));
}

std::string ScourgeInvasionData::GetData()
{
    std::string output = std::to_string(m_state) + " ";
    for (TimePoint& timer : m_timers)
    {
        if (timer == TimePoint())
            output += "0 ";
        else
            output += std::to_string(std::chrono::duration_cast<std::chrono::milliseconds>(timer.time_since_epoch()).count()) + " ";
    }
    output += std::to_string(m_battlesWon) + " " + std::to_string(m_lastAttackZone) + " ";
    for (uint32& remaining : m_remaining)
        output += std::to_string(remaining) + " ";
    return output;
}

void WorldState::StopScourgeInvasion()
{
    sGameEventMgr->StopEvent(GAME_EVENT_SCOURGE_INVASION);
    sGameEventMgr->StopEvent(GAME_EVENT_SCOURGE_INVASION_WINTERSPRING);
    sGameEventMgr->StopEvent(GAME_EVENT_SCOURGE_INVASION_TANARIS);
    sGameEventMgr->StopEvent(GAME_EVENT_SCOURGE_INVASION_AZSHARA);
    sGameEventMgr->StopEvent(GAME_EVENT_SCOURGE_INVASION_BLASTED_LANDS);
    sGameEventMgr->StopEvent(GAME_EVENT_SCOURGE_INVASION_EASTERN_PLAGUELANDS);
    sGameEventMgr->StopEvent(GAME_EVENT_SCOURGE_INVASION_BURNING_STEPPES);
    sGameEventMgr->StopEvent(GAME_EVENT_SCOURGE_INVASION_INVASIONS_DONE);
    sGameEventMgr->StopEvent(GAME_EVENT_SCOURGE_INVASION_BOSSES);
    BroadcastSIWorldstates();
    m_siData.Reset();

    for (auto& [_, cityData] : m_siData.m_cityAttacks)
        OnDisable(cityData);

    for (auto& [_, zoneData] : m_siData.m_activeInvasions)
        OnDisable(zoneData);
}

uint32 WorldState::GetSIRemaining(SIRemaining remaining) const
{
    return m_siData.m_remaining[remaining];
}

uint32 WorldState::GetSIRemainingByZone(uint32 zoneId) const
{
    SIRemaining remainingId;
    switch (zoneId)
    {
        case AREA_WINTERSPRING: remainingId = SI_REMAINING_WINTERSPRING; break;
        case AREA_AZSHARA: remainingId = SI_REMAINING_AZSHARA; break;
        case AREA_EASTERN_PLAGUELANDS: remainingId = SI_REMAINING_EASTERN_PLAGUELANDS; break;
        case AREA_BLASTED_LANDS: remainingId = SI_REMAINING_BLASTED_LANDS; break;
        case AREA_BURNING_STEPPES: remainingId = SI_REMAINING_BURNING_STEPPES; break;
        case AREA_TANARIS: remainingId = SI_REMAINING_TANARIS; break;
        default:
            LOG_ERROR("WorldState", "GetSIRemainingByZone called with invalid zone ID: {}", zoneId);
            return 0;
    }
    return GetSIRemaining(remainingId);
}

void WorldState::SetSIRemaining(SIRemaining remaining, uint32 value)
{
    std::lock_guard<std::mutex> guard(m_siData.m_siMutex);
    m_siData.m_remaining[remaining] = value;
    Save(SAVE_ID_SCOURGE_INVASION);
}

TimePoint WorldState::GetSITimer(SITimers timer)
{
    return m_siData.m_timers[timer];
}

void WorldState::SetSITimer(SITimers timer, TimePoint timePoint)
{
    m_siData.m_timers[timer] = timePoint;
}

uint32 WorldState::GetBattlesWon()
{
    std::lock_guard<std::mutex> guard(m_siData.m_siMutex);
    return m_siData.m_battlesWon;
}

void WorldState::AddBattlesWon(int32 count)
{
    std::lock_guard<std::mutex> guard(m_siData.m_siMutex);
    m_siData.m_battlesWon += count;
    HandleDefendedZones();
    Save(SAVE_ID_SCOURGE_INVASION);
}

uint32 WorldState::GetLastAttackZone()
{
    std::lock_guard<std::mutex> guard(m_siData.m_siMutex);
    return m_siData.m_lastAttackZone;
}

void WorldState::SetLastAttackZone(uint32 zoneId)
{
    std::lock_guard<std::mutex> guard(m_siData.m_siMutex);
    m_siData.m_lastAttackZone = zoneId;
}

void WorldState::BroadcastSIWorldstates()
{
    uint32 victories = GetBattlesWon();

    uint32 remainingAzshara = GetSIRemaining(SI_REMAINING_AZSHARA);
    uint32 remainingBlastedLands = GetSIRemaining(SI_REMAINING_BLASTED_LANDS);
    uint32 remainingBurningSteppes = GetSIRemaining(SI_REMAINING_BURNING_STEPPES);
    uint32 remainingEasternPlaguelands = GetSIRemaining(SI_REMAINING_EASTERN_PLAGUELANDS);
    uint32 remainingTanaris = GetSIRemaining(SI_REMAINING_TANARIS);
    uint32 remainingWinterspring = GetSIRemaining(SI_REMAINING_WINTERSPRING);

    sMapMgr->DoForAllMaps([&](Map* map) -> void
    {
        switch (map->GetId())
        {
            case MAP_EASTERN_KINGDOMS:
            case MAP_KALIMDOR:
                map->DoForAllPlayers([&](Player* pl)
                {
                    // do not process players which are not in world
                    if (!pl->IsInWorld())
                        return;

                    pl->SendUpdateWorldState(WORLD_STATE_SCOURGE_INVASION_AZSHARA, remainingAzshara > 0 ? 1 : 0);
                    pl->SendUpdateWorldState(WORLD_STATE_SCOURGE_INVASION_BLASTED_LANDS, remainingBlastedLands > 0 ? 1 : 0);
                    pl->SendUpdateWorldState(WORLD_STATE_SCOURGE_INVASION_BURNING_STEPPES, remainingBurningSteppes > 0 ? 1 : 0);
                    pl->SendUpdateWorldState(WORLD_STATE_SCOURGE_INVASION_EASTERN_PLAGUELANDS, remainingEasternPlaguelands > 0 ? 1 : 0);
                    pl->SendUpdateWorldState(WORLD_STATE_SCOURGE_INVASION_TANARIS, remainingTanaris > 0 ? 1 : 0);
                    pl->SendUpdateWorldState(WORLD_STATE_SCOURGE_INVASION_WINTERSPRING, remainingWinterspring > 0 ? 1 : 0);

                    pl->SendUpdateWorldState(WORLD_STATE_SCOURGE_INVASION_VICTORIES, victories);
                    pl->SendUpdateWorldState(WORLD_STATE_SCOURGE_INVASION_NECROPOLIS_AZSHARA, remainingAzshara);
                    pl->SendUpdateWorldState(WORLD_STATE_SCOURGE_INVASION_NECROPOLIS_BLASTED_LANDS, remainingBlastedLands);
                    pl->SendUpdateWorldState(WORLD_STATE_SCOURGE_INVASION_NECROPOLIS_BURNING_STEPPES, remainingBurningSteppes);
                    pl->SendUpdateWorldState(WORLD_STATE_SCOURGE_INVASION_NECROPOLIS_EASTERN_PLAGUELANDS, remainingEasternPlaguelands);
                    pl->SendUpdateWorldState(WORLD_STATE_SCOURGE_INVASION_NECROPOLIS_TANARIS, remainingTanaris);
                    pl->SendUpdateWorldState(WORLD_STATE_SCOURGE_INVASION_NECROPOLIS_WINTERSPRING, remainingWinterspring);
                });
            default:
                break;
        }
    });
}

void WorldState::HandleDefendedZones()
{
    if (m_siData.m_battlesWon < sWorld->getIntConfig(CONFIG_SCOURGEINVASION_COUNTER_FIRST))
    {
        sGameEventMgr->StopEvent(GAME_EVENT_SCOURGE_INVASION_50_INVASIONS);
        sGameEventMgr->StopEvent(GAME_EVENT_SCOURGE_INVASION_100_INVASIONS);
        sGameEventMgr->StopEvent(GAME_EVENT_SCOURGE_INVASION_150_INVASIONS);
    }
    else if (m_siData.m_battlesWon >= sWorld->getIntConfig(CONFIG_SCOURGEINVASION_COUNTER_FIRST) &&
             m_siData.m_battlesWon < sWorld->getIntConfig(CONFIG_SCOURGEINVASION_COUNTER_SECOND))
        sGameEventMgr->StartEvent(GAME_EVENT_SCOURGE_INVASION_50_INVASIONS);
    else if (m_siData.m_battlesWon >= sWorld->getIntConfig(CONFIG_SCOURGEINVASION_COUNTER_SECOND) &&
             m_siData.m_battlesWon < sWorld->getIntConfig(CONFIG_SCOURGEINVASION_COUNTER_THIRD))
    {
        sGameEventMgr->StopEvent(GAME_EVENT_SCOURGE_INVASION_50_INVASIONS);
        sGameEventMgr->StartEvent(GAME_EVENT_SCOURGE_INVASION_100_INVASIONS);
    }
    else if (m_siData.m_battlesWon >= sWorld->getIntConfig(CONFIG_SCOURGEINVASION_COUNTER_THIRD))
    {
        // The event is enabled via command, so we expect it to be disabled via command as well.
        // sGameEventMgr->StopEvent(GAME_EVENT_SCOURGE_INVASION);
        sGameEventMgr->StopEvent(GAME_EVENT_SCOURGE_INVASION_50_INVASIONS);
        sGameEventMgr->StopEvent(GAME_EVENT_SCOURGE_INVASION_100_INVASIONS);
        sGameEventMgr->StartEvent(GAME_EVENT_SCOURGE_INVASION_INVASIONS_DONE);
        sGameEventMgr->StartEvent(GAME_EVENT_SCOURGE_INVASION_150_INVASIONS);
    }
}

void WorldState::StartZoneEvent(SIZoneIds eventId)
{
    switch (eventId)
    {
        case SI_ZONE_AZSHARA: StartNewInvasion(AREA_AZSHARA); break;
        case SI_ZONE_BLASTED_LANDS: StartNewInvasion(AREA_BLASTED_LANDS); break;
        case SI_ZONE_BURNING_STEPPES: StartNewInvasion(AREA_BURNING_STEPPES); break;
        case SI_ZONE_EASTERN_PLAGUELANDS: StartNewInvasion(AREA_EASTERN_PLAGUELANDS); break;
        case SI_ZONE_TANARIS: StartNewInvasion(AREA_TANARIS); break;
        case SI_ZONE_WINTERSPRING: StartNewInvasion(AREA_WINTERSPRING); break;
        case SI_ZONE_STORMWIND: StartNewCityAttack(AREA_STORMWIND_CITY); break;
        case SI_ZONE_UNDERCITY: StartNewCityAttack(AREA_UNDERCITY); break;
        default:
            break;
    }
}

void WorldState::StartNewInvasionIfTime(uint32 attackTimeVar, uint32 zoneId)
{
    TimePoint now = std::chrono::steady_clock::now();

    // Not yet time
    if (now < sWorldState->GetSITimer(SITimers(attackTimeVar)))
        return;

    StartNewInvasion(zoneId);
}

void WorldState::StartNewCityAttackIfTime(uint32 attackTimeVar, uint32 zoneId)
{
    TimePoint now = std::chrono::steady_clock::now();

    // Not yet time
    if (now < sWorldState->GetSITimer(SITimers(attackTimeVar)))
        return;

    StartNewCityAttack(zoneId);
    uint32 cityAttackTimer = urand(CITY_ATTACK_TIMER_MIN, CITY_ATTACK_TIMER_MAX);
    TimePoint next_attack = now + std::chrono::seconds(cityAttackTimer);
    sWorldState->SetSITimer(SITimers(attackTimeVar), next_attack);
}

void WorldState::StartNewInvasion(uint32 zoneId)
{
    if (IsActiveZone(zoneId))
        return;

    // Don't attack same zone as before.
    if (zoneId == sWorldState->GetLastAttackZone())
        return;

    // If we have at least one victory and more than 1 active zones stop here.
    if (GetActiveZones() > 1 && sWorldState->GetBattlesWon() > 0)
        return;

    LOG_DEBUG("gameevent", "Scourge Invasion Event: Starting new invasion in {}.", zoneId);

    ScourgeInvasionData::InvasionZone& zone = m_siData.m_activeInvasions[zoneId];

    Map* map = GetMap(zone.map, zone.mouth[0]);

    if (!map)
    {
        LOG_ERROR("gameevent", "ScourgeInvasionEvent::StartNewInvasion unable to access required map ({}). Retrying next update.", zone.map);
        return;
    }

    switch (zoneId)
    {
        case AREA_AZSHARA: sGameEventMgr->StartEvent(GAME_EVENT_SCOURGE_INVASION_AZSHARA); break;
        case AREA_BLASTED_LANDS: sGameEventMgr->StartEvent(GAME_EVENT_SCOURGE_INVASION_BLASTED_LANDS); break;
        case AREA_BURNING_STEPPES: sGameEventMgr->StartEvent(GAME_EVENT_SCOURGE_INVASION_BURNING_STEPPES); break;
        case AREA_EASTERN_PLAGUELANDS: sGameEventMgr->StartEvent(GAME_EVENT_SCOURGE_INVASION_EASTERN_PLAGUELANDS); break;
        case AREA_TANARIS: sGameEventMgr->StartEvent(GAME_EVENT_SCOURGE_INVASION_TANARIS); break;
        case AREA_WINTERSPRING: sGameEventMgr->StartEvent(GAME_EVENT_SCOURGE_INVASION_WINTERSPRING); break;
        default:
            LOG_ERROR("gameevent", "ScourgeInvasionEvent::StartNewInvasion unknown zoneId {}.", zoneId);
            return;
    }

    if (map)
        SummonMouth(map, zone, zone.mouth[0], true);
}

void WorldState::StartNewCityAttack(uint32 zoneId)
{
    LOG_DEBUG("gameevent", "Scourge Invasion Event: Starting new City attack in zone {}.", zoneId);

    ScourgeInvasionData::CityAttack& zone = m_siData.m_cityAttacks[zoneId];

    uint32 SpawnLocationID = urand(0, static_cast<uint32>(zone.pallid.size() - 1));

    Map* map = GetMap(zone.map, zone.pallid[SpawnLocationID]);

    // If any of the required maps are not available we return. Will cause the invasion to be started
    // on next update instead
    if (!map)
    {
        LOG_ERROR("gameevent", "ScourgeInvasionEvent::StartNewCityAttackIfTime unable to access required map (%{}). Retrying next update.", zone.map);
        return;
    }

    if (m_siData.m_pendingPallids.find(zoneId) != m_siData.m_pendingPallids.end())
        return;

    if (map && SummonPallid(map, zone, zone.pallid[SpawnLocationID], SpawnLocationID))
        LOG_DEBUG("gameevent", "ScourgeInvasionEvent::StartNewCityAttackIfTime pallid spawned in {}.", zone.map);
    else
        LOG_DEBUG("gameevent", "ScourgeInvasionEvent::StartNewCityAttackIfTime unable to spawn pallid in {}.", zone.map);
}

bool WorldState::ResumeInvasion(ScourgeInvasionData::InvasionZone& zone)
{
    // Dont have a save variable to know which necropolises had already been destroyed, so we
    // just summon the same amount, but not necessarily the same necropolises
    LOG_DEBUG("gameevent", "Scourge Invasion Event: Resuming Scourge invasion in zone {}", zone.zoneId);

    uint32 num_necropolises_remaining = sWorldState->GetSIRemaining(SIRemaining(zone.remainingNecropoli));

    // Just making sure we can access all maps before starting the invasion
    for (uint32 i = 0; i < num_necropolises_remaining; i++)
    {
        if (!GetMap(zone.map, zone.mouth[0]))
        {
            LOG_ERROR("gameevent", "ScourgeInvasionEvent::ResumeInvasion map {} not accessible. Retry next update.", zone.map);
            return false;
        }
    }

    Map* mapPtr = GetMap(zone.map, zone.mouth[0]);
    if (!mapPtr)
    {
        LOG_ERROR("gameevent", "ScourgeInvasionEvent::ResumeInvasion failed getting map, even after making sure they were loaded....");
        return false;
    }

    SummonMouth(mapPtr, zone, zone.mouth[0], false);

    return true;
}

bool WorldState::SummonMouth(Map* map, ScourgeInvasionData::InvasionZone& zone, Position position, bool newInvasion)
{
    AddPendingInvasion(zone.zoneId);
    // Remove old mouth if required.
   if (Creature* existingMouth = map->GetCreature(zone.mouthGuid))
        existingMouth->AddObjectToRemoveList();

    if (Creature* mouth = map->SummonCreature(NPC_HERALD_OF_THE_LICH_KING, position))
    {
        mouth->GetAI()->DoAction(EVENT_HERALD_OF_THE_LICH_KING_ZONE_START);
        sWorldState->SetMouthGuid(zone.zoneId, mouth->GetGUID());
        if (newInvasion)
            sWorldState->SetSIRemaining(SIRemaining(zone.remainingNecropoli), zone.necropolisCount);
    }
    sWorldState->RemovePendingInvasion(zone.zoneId);

    return true;
}

enum PallidHorrorPaths
{
    PATH_STORMWIND_KEEP           = 163941,
    PATH_STORMWIND_TRADE_DISTRICT = 163942,
    PATH_UNDERCITY_TRADE_QUARTER  = 163943,
    PATH_UNDERCITY_ROYAL_QUARTER  = 163944,
};

bool WorldState::SummonPallid(Map* map, ScourgeInvasionData::CityAttack& zone, const Position& position, uint32 spawnLoc)
{
    AddPendingPallid(zone.zoneId);
    // Remove old pallid if required.
    uint32 pathID = 0;
    if (Creature* existingPallid = map->GetCreature(zone.pallidGuid))
        existingPallid->AddObjectToRemoveList();

    // if (Creature* pallid = map->SummonCreature(RAND(NPC_PALLID_HORROR, NPC_PATCHWORK_TERROR), position))
    if (Creature* pallid = map->SummonCreature(NPC_PALLID_HORROR, position))
    {
        pallid->GetMotionMaster()->Clear(false);
        if (pallid->GetZoneId() == AREA_UNDERCITY)
            pathID = spawnLoc == 0 ? PATH_UNDERCITY_ROYAL_QUARTER : PATH_UNDERCITY_TRADE_QUARTER;
        else
            pathID = spawnLoc == 0 ? PATH_STORMWIND_KEEP : PATH_STORMWIND_TRADE_DISTRICT;

        pallid->GetMotionMaster()->MoveWaypoint(pathID, false);

        sWorldState->SetPallidGuid(zone.zoneId, pallid->GetGUID());
    }
    sWorldState->RemovePendingPallid(zone.zoneId);

    return true;
}

void WorldState::HandleActiveZone(uint32 attackTimeVar, uint32 zoneId, uint32 remainingVar, TimePoint now)
{
    TimePoint timePoint = sWorldState->GetSITimer(SITimers(attackTimeVar));

    ScourgeInvasionData::InvasionZone& zone = m_siData.m_activeInvasions[zoneId];

    Map* map = sMapMgr->FindMap(zone.map, 0);

    if (zone.zoneId != zoneId)
        return;

    uint32 remaining = GetSIRemaining(SIRemaining(remainingVar));

    // Calculate the next possible attack between ZONE_ATTACK_TIMER_MIN and ZONE_ATTACK_TIMER_MAX.
    uint32 zoneAttackTimer = urand(ZONE_ATTACK_TIMER_MIN, ZONE_ATTACK_TIMER_MAX);
    TimePoint next_attack = now + std::chrono::seconds(zoneAttackTimer);
    uint64 timeToNextAttack = std::chrono::duration_cast<std::chrono::minutes>(next_attack-now).count();

    if (zone.mouthGuid)
    {
        // Handles the inactive zone, without a Mouth of Kel'Thuzad summoned (which spawns the whole zone event).
        Creature* mouth = map->GetCreature(zone.mouthGuid);
        if (!mouth)
            sWorldState->SetMouthGuid(zone.zoneId, ObjectGuid()); // delays spawning until next tick
        // Handles the active zone that has no necropolis left.
        else if (timePoint < now && remaining == 0)
        {
                sWorldState->SetSITimer(SITimers(attackTimeVar), next_attack);
                sWorldState->AddBattlesWon(1);
                sWorldState->SetLastAttackZone(zoneId);

                LOG_INFO("gameevent", "[Scourge Invasion Event] The Scourge has been defeated in {}, next attack starting in {} minutes.", zoneId, timeToNextAttack);
                LOG_DEBUG("gameevent", "[Scourge Invasion Event] {} victories", sWorldState->GetBattlesWon());

                if (mouth)
                    mouth->GetAI()->DoAction(EVENT_HERALD_OF_THE_LICH_KING_ZONE_STOP);
                else
                    LOG_ERROR("gameevent", "ScourgeInvasionEvent::HandleActiveZone ObjectGuid {} not found.", zone.mouthGuid.ToString());
        }
    }
    else
    {
        // If more than one zones are alreay being attacked, set the timer again to ZONE_ATTACK_TIMER.
        if (GetActiveZones() > 1)
            sWorldState->SetSITimer(SITimers(attackTimeVar), next_attack);

        // Try to start the zone if attackTimeVar is 0.
        StartNewInvasionIfTime(attackTimeVar, zoneId);
    }
}

void WorldState::SetPallidGuid(uint32 zoneId, ObjectGuid guid)
{
    m_siData.m_cityAttacks[zoneId].pallidGuid = guid;
}

void WorldState::SetMouthGuid(uint32 zoneId, ObjectGuid guid)
{
    m_siData.m_activeInvasions[zoneId].mouthGuid = guid;
}

void WorldState::AddPendingInvasion(uint32 zoneId)
{
    std::lock_guard<std::mutex> guard(m_siData.m_siMutex);
    m_siData.m_pendingInvasions.insert(zoneId);
}

void WorldState::RemovePendingInvasion(uint32 zoneId)
{
    std::lock_guard<std::mutex> guard(m_siData.m_siMutex);
    m_siData.m_pendingInvasions.erase(zoneId);
}

void WorldState::AddPendingPallid(uint32 zoneId)
{
    std::lock_guard<std::mutex> guard(m_siData.m_siMutex);
    m_siData.m_pendingPallids.insert(zoneId);
}

void WorldState::RemovePendingPallid(uint32 zoneId)
{
    std::lock_guard<std::mutex> guard(m_siData.m_siMutex);
    m_siData.m_pendingPallids.erase(zoneId);
}

void WorldState::OnEnable(ScourgeInvasionData::InvasionZone& zone)
{
    // If there were remaining necropolises in the old zone before shutdown, we
    // restore that zone
    if (sWorldState->GetSIRemaining(SIRemaining(zone.remainingNecropoli)) > 0)
        ResumeInvasion(zone);
    // Otherwise we start a new Invasion
    else
        StartNewInvasionIfTime(GetTimerIdForZone(zone.zoneId), zone.zoneId);
}

void WorldState::OnDisable(ScourgeInvasionData::InvasionZone& zone)
{
    if (!zone.mouthGuid)
        return;

    Map* map = GetMap(zone.map, zone.mouth[0]);

   if (Creature* mouth = map->GetCreature(zone.mouthGuid))
       mouth->DespawnOrUnsummon();
}

void WorldState::OnDisable(ScourgeInvasionData::CityAttack& zone)
{
    if (!zone.pallidGuid)
        return;

    Map* map = GetMap(zone.map, zone.pallid[0]);

        if (Creature* pallid = map->GetCreature(zone.pallidGuid))
            pallid->DespawnOrUnsummon();
}

bool WorldState::IsActiveZone(uint32 /*zoneId*/)
{
    return false;
}

// returns the amount of pending zones and active zones with a mouth creature on the map
uint32 WorldState::GetActiveZones()
{
    size_t i = m_siData.m_pendingInvasions.size();
    for (auto const& [zoneId, invasionData] : m_siData.m_activeInvasions)
    {
        Map* map = GetMap(invasionData.map, invasionData.mouth[0]);
        if (!map)
        {
            LOG_ERROR("gameevent", "ScourgeInvasionEvent::GetActiveZones no map for zone {}.", invasionData.map);
            continue;
        }

        Creature* mouth = map->GetCreature(invasionData.mouthGuid);
        if (mouth)
            i++;
    }
    return i;
}

uint32 WorldState::GetTimerIdForZone(uint32 zoneId)
{
    uint32 attackTime = 0;
    switch (zoneId)
    {
        case AREA_TANARIS: attackTime = SI_TIMER_TANARIS; break;
        case AREA_BLASTED_LANDS: attackTime = SI_TIMER_BLASTED_LANDS; break;
        case AREA_EASTERN_PLAGUELANDS: attackTime = SI_TIMER_EASTERN_PLAGUELANDS; break;
        case AREA_BURNING_STEPPES: attackTime = SI_TIMER_BURNING_STEPPES; break;
        case AREA_WINTERSPRING: attackTime = SI_TIMER_WINTERSPRING; break;
        case AREA_AZSHARA: attackTime = SI_TIMER_AZSHARA; break;
        default:
            LOG_ERROR("gameevent", "ScourgeInvasionEvent::GetTimerIdForZone unknown zoneId {}.", zoneId);
            return 0;
    }
    return attackTime;
}

void WorldState::FillInitialWorldStates(WorldPackets::WorldState::InitWorldStates& packet, uint32 zoneId, uint32 /*areaId*/)
{
    if (m_siData.m_state != STATE_0_DISABLED) // scourge invasion active - need to send all worldstates
    {
        uint32 victories = GetBattlesWon();

        uint32 remainingAzshara = GetSIRemaining(SI_REMAINING_AZSHARA);
        uint32 remainingBlastedLands = GetSIRemaining(SI_REMAINING_BLASTED_LANDS);
        uint32 remainingBurningSteppes = GetSIRemaining(SI_REMAINING_BURNING_STEPPES);
        uint32 remainingEasternPlaguelands = GetSIRemaining(SI_REMAINING_EASTERN_PLAGUELANDS);
        uint32 remainingTanaris = GetSIRemaining(SI_REMAINING_TANARIS);
        uint32 remainingWinterspring = GetSIRemaining(SI_REMAINING_WINTERSPRING);

        packet.Worldstates.reserve(13);
        packet.Worldstates.emplace_back(WORLD_STATE_SCOURGE_INVASION_AZSHARA, remainingAzshara > 0 ? 1 : 0);
        packet.Worldstates.emplace_back(WORLD_STATE_SCOURGE_INVASION_BLASTED_LANDS, remainingBlastedLands > 0 ? 1 : 0);
        packet.Worldstates.emplace_back(WORLD_STATE_SCOURGE_INVASION_BURNING_STEPPES, remainingBurningSteppes > 0 ? 1 : 0);
        packet.Worldstates.emplace_back(WORLD_STATE_SCOURGE_INVASION_EASTERN_PLAGUELANDS, remainingEasternPlaguelands > 0 ? 1 : 0);
        packet.Worldstates.emplace_back(WORLD_STATE_SCOURGE_INVASION_TANARIS, remainingTanaris > 0 ? 1 : 0);
        packet.Worldstates.emplace_back(WORLD_STATE_SCOURGE_INVASION_WINTERSPRING, remainingWinterspring > 0 ? 1 : 0);
        packet.Worldstates.emplace_back(WORLD_STATE_SCOURGE_INVASION_VICTORIES, victories);
        packet.Worldstates.emplace_back(WORLD_STATE_SCOURGE_INVASION_NECROPOLIS_AZSHARA, remainingAzshara);
        packet.Worldstates.emplace_back(WORLD_STATE_SCOURGE_INVASION_NECROPOLIS_BLASTED_LANDS, remainingBlastedLands);
        packet.Worldstates.emplace_back(WORLD_STATE_SCOURGE_INVASION_NECROPOLIS_BURNING_STEPPES, remainingBurningSteppes);
        packet.Worldstates.emplace_back(WORLD_STATE_SCOURGE_INVASION_NECROPOLIS_EASTERN_PLAGUELANDS, remainingEasternPlaguelands);
        packet.Worldstates.emplace_back(WORLD_STATE_SCOURGE_INVASION_NECROPOLIS_TANARIS, remainingTanaris);
        packet.Worldstates.emplace_back(WORLD_STATE_SCOURGE_INVASION_NECROPOLIS_WINTERSPRING, remainingWinterspring);
    }

    switch (zoneId)
    {
        case AREA_ISLE_OF_QUEL_DANAS:
        case AREA_MAGISTERS_TERRACE:
        case AREA_SUNWELL_PLATEAU:
        case AREA_SHATTRATH_CITY:
        {
            // Sunwell Reclamation
            switch (m_sunsReachData.m_phase)
            {
                case SUNS_REACH_PHASE_1_STAGING_AREA:
                    packet.Worldstates.emplace_back(WORLD_STATE_QUEL_DANAS_SANCTUM, m_sunsReachData.GetPhasePercentage(m_sunsReachData.m_phase));
                    break;
                case SUNS_REACH_PHASE_2_SANCTUM:
                    packet.Worldstates.emplace_back(WORLD_STATE_QUEL_DANAS_ARMORY, m_sunsReachData.GetPhasePercentage(m_sunsReachData.m_phase));
                    break;
                case SUNS_REACH_PHASE_3_ARMORY:
                    packet.Worldstates.emplace_back(WORLD_STATE_QUEL_DANAS_HARBOR, m_sunsReachData.GetPhasePercentage(m_sunsReachData.m_phase));
                    break;
                case SUNS_REACH_PHASE_4_HARBOR:
                    if ((m_sunsReachData.m_subphaseMask & SUBPHASE_ALCHEMY_LAB) == 0)
                        packet.Worldstates.emplace_back(WORLD_STATE_QUEL_DANAS_ALCHEMY_LAB, m_sunsReachData.GetSubPhasePercentage(SUBPHASE_ALCHEMY_LAB));
                    if ((m_sunsReachData.m_subphaseMask & SUBPHASE_MONUMENT) == 0)
                        packet.Worldstates.emplace_back(WORLD_STATE_QUEL_DANAS_MONUMENT, m_sunsReachData.GetSubPhasePercentage(SUBPHASE_MONUMENT));
                    break;
            }
            if (m_sunsReachData.m_phase >= SUNS_REACH_PHASE_2_SANCTUM && (m_sunsReachData.m_subphaseMask & SUBPHASE_PORTAL) == 0)
                packet.Worldstates.emplace_back(WORLD_STATE_QUEL_DANAS_PORTAL, m_sunsReachData.GetSubPhasePercentage(SUBPHASE_PORTAL));
            if (m_sunsReachData.m_phase >= SUNS_REACH_PHASE_3_ARMORY && (m_sunsReachData.m_subphaseMask & SUBPHASE_ANVIL) == 0)
                packet.Worldstates.emplace_back(WORLD_STATE_QUEL_DANAS_ANVIL, m_sunsReachData.GetSubPhasePercentage(SUBPHASE_ANVIL));
            packet.Worldstates.emplace_back(WORLD_STATE_QUEL_DANAS_MUSIC, m_sunsReachData.m_phase);

            // Sunwell Gates
            switch (m_sunsReachData.m_gate)
            {
                case SUNWELL_ALL_GATES_CLOSED:
                    packet.Worldstates.emplace_back(WORLD_STATE_AGAMATH_THE_FIRST_GATE_HEALTH, m_sunsReachData.GetSunwellGatePercentage(m_sunsReachData.m_gate));
                    break;
                case SUNWELL_AGAMATH_GATE1_OPEN:
                    packet.Worldstates.emplace_back(WORLD_STATE_ROHENDOR_THE_SECOND_GATE_HEALTH, m_sunsReachData.GetSunwellGatePercentage(m_sunsReachData.m_gate));
                    break;
                case SUNWELL_ROHENDOR_GATE2_OPEN:
                    packet.Worldstates.emplace_back(WORLD_STATE_ARCHONISUS_THE_FINAL_GATE_HEALTH, m_sunsReachData.GetSunwellGatePercentage(m_sunsReachData.m_gate));
                    break;
            }
            break;
        }
        default:
            break;
    }
}

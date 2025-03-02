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

#include "GameEventMgr.h"
#include "MapMgr.h"
#include "Player.h"
#include "SharedDefines.h"
#include "Weather.h"
#include "WorldState.h"

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
    QueryResult result = CharacterDatabase.Query("SELECT Id, Data FROM world_state");
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
            }
        } while (result->NextRow());
    }
    StartSunsReachPhase(true);
    StartSunwellGatePhase();
    HandleSunsReachSubPhaseTransition(m_sunsReachData.m_subphaseMask, true);
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
        default:
            break;
    }
}

void WorldState::SaveHelper(std::string& stringToSave, WorldStateSaveIds saveId)
{
    CharacterDatabase.Execute("DELETE FROM world_state WHERE Id='{}'", saveId);
    CharacterDatabase.Execute("INSERT INTO world_state(Id,Data) VALUES('{}','{}')", saveId, stringToSave.data());
}

bool WorldState::IsConditionFulfilled(WorldStateCondition conditionId, WorldStateConditionState state) const
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
        default:
            LOG_ERROR("scripts", "WorldState::IsConditionFulfilled: Unhandled WorldStateCondition {}", conditionId);
            return false;
    }
}

void WorldState::HandleConditionStateChange(WorldStateCondition conditionId, WorldStateConditionState state)
{
    _transportStates[conditionId] = state;
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
}

void WorldState::HandlePlayerEnterZone(Player* player, WorldStateZoneId zoneId)
{
    std::lock_guard<std::mutex> guard(_mutex);
    switch (zoneId)
    {
        case ZONEID_SHATTRATH:
        case ZONEID_BOTANICA:
        case ZONEID_MECHANAR:
        case ZONEID_ARCATRAZ:
            if (_adalSongOfBattleTimer)
                player->CastSpell(player, SPELL_ADAL_SONG_OF_BATTLE, true);
            break;
        case ZONEID_HELLFIRE_PENINSULA:
        case ZONEID_HELLFIRE_RAMPARTS:
        case ZONEID_HELLFIRE_CITADEL:
        case ZONEID_BLOOD_FURNACE:
        case ZONEID_SHATTERED_HALLS:
        case ZONEID_MAGTHERIDON_LAIR:
            if (_isMagtheridonHeadSpawnedAlliance && player->GetTeamId() == TEAM_ALLIANCE)
                player->CastSpell(player, SPELL_TROLLBANES_COMMAND, true);
            else if (_isMagtheridonHeadSpawnedHorde && player->GetTeamId() == TEAM_HORDE)
                player->CastSpell(player, SPELL_NAZGRELS_FAVOR, true);
            break;
        case ZONEID_ISLE_OF_QUEL_DANAS:
        case ZONEID_MAGISTERS_TERRACE:
        case ZONEID_SUNWELL_PLATEAU:
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
void WorldState::HandlePlayerLeaveZone(Player* player, WorldStateZoneId zoneId)
{
    std::lock_guard<std::mutex> guard(_mutex);
    switch (zoneId)
    {
        case ZONEID_SHATTRATH:
        case ZONEID_BOTANICA:
        case ZONEID_MECHANAR:
        case ZONEID_ARCATRAZ:
            if (!_adalSongOfBattleTimer)
                player->RemoveAurasDueToSpell(SPELL_ADAL_SONG_OF_BATTLE);
            break;
        case ZONEID_HELLFIRE_PENINSULA:
        case ZONEID_HELLFIRE_RAMPARTS:
        case ZONEID_HELLFIRE_CITADEL:
        case ZONEID_BLOOD_FURNACE:
        case ZONEID_SHATTERED_HALLS:
        case ZONEID_MAGTHERIDON_LAIR:
            if (player->GetTeamId() == TEAM_ALLIANCE)
                player->RemoveAurasDueToSpell(SPELL_TROLLBANES_COMMAND);
            else if (player->GetTeamId() == TEAM_HORDE)
                player->RemoveAurasDueToSpell(SPELL_NAZGRELS_FAVOR);
            break;
        case ZONEID_ISLE_OF_QUEL_DANAS:
        case ZONEID_MAGISTERS_TERRACE:
        case ZONEID_SUNWELL_PLATEAU:
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
            case 530: // Outland
                map->DoForAllPlayers([&](Player* player)
                {
                    if (player->GetZoneId() == ZONEID_HELLFIRE_PENINSULA && player->GetTeamId() == TEAM_ALLIANCE && team == TEAM_ALLIANCE)
                        player->CastSpell(player, SPELL_TROLLBANES_COMMAND, true);
                    else if (player->GetZoneId() == ZONEID_HELLFIRE_PENINSULA && player->GetTeamId() == TEAM_HORDE && team == TEAM_HORDE)
                        player->CastSpell(player, SPELL_NAZGRELS_FAVOR, true);
                });
                break;
            case 540: // The Shattered Halls
            case 542: // The Blood Furnace
            case 543: // Ramparts
            case 544: // Magtheridon's Lair
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
            case 530: // Outland
                map->DoForAllPlayers([&](Player* player)
                {
                    if (player->GetZoneId() == ZONEID_HELLFIRE_PENINSULA && player->GetTeamId() == TEAM_ALLIANCE && team == TEAM_ALLIANCE)
                        player->RemoveAurasDueToSpell(SPELL_TROLLBANES_COMMAND);
                    else if (player->GetZoneId() == ZONEID_HELLFIRE_PENINSULA && player->GetTeamId() == TEAM_HORDE && team == TEAM_HORDE)
                        player->RemoveAurasDueToSpell(SPELL_NAZGRELS_FAVOR);
                });
                break;
            case 540: // The Shattered Halls
            case 542: // The Blood Furnace
            case 543: // Ramparts
            case 544: // Magtheridon's Lair
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
            case 530: // Outland
                map->DoForAllPlayers([&](Player* player)
                {
                    if (player->GetZoneId() == ZONEID_SHATTRATH)
                        player->CastSpell(player, SPELL_ADAL_SONG_OF_BATTLE, true);
                });
                break;
            case 552: // Arcatraz
            case 553: // Botanica
            case 554: // Mechanar
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
            case 530: // Outland
                map->DoForAllPlayers([&](Player* player)
                {
                    if (player->GetZoneId() == ZONEID_SHATTRATH)
                        player->RemoveAurasDueToSpell(SPELL_ADAL_SONG_OF_BATTLE);
                });
                break;
            case 552: // Arcatraz
            case 553: // Botanica
            case 554: // Mechanar
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
            for (ObjectGuid& guid : m_sunsReachData.m_sunsReachReclamationPlayers)
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
            if (Map* map = sMapMgr->FindBaseNonInstanceMap(530))
                map->SetZoneWeather(ZONEID_ISLE_OF_QUEL_DANAS, WEATHER_STATE_MEDIUM_RAIN, 0.75f);
            break;
        case SUNS_REACH_PHASE_2_SANCTUM:
            sGameEventMgr->StartEvent(GAME_EVENT_QUEL_DANAS_PHASE_2_ONLY);
            sGameEventMgr->StartEvent(GAME_EVENT_QUEL_DANAS_PHASE_2_PERMANENT);
            if (Map* map = sMapMgr->FindBaseNonInstanceMap(530))
                map->SetZoneWeather(ZONEID_ISLE_OF_QUEL_DANAS, WEATHER_STATE_LIGHT_RAIN, 0.5f);
            break;
        case SUNS_REACH_PHASE_3_ARMORY:
            if (initial)
                sGameEventMgr->StartEvent(GAME_EVENT_QUEL_DANAS_PHASE_2_PERMANENT);
            sGameEventMgr->StartEvent(GAME_EVENT_QUEL_DANAS_PHASE_3_ONLY); sGameEventMgr->StartEvent(GAME_EVENT_QUEL_DANAS_PHASE_3_PERMANENT);
            // TODO: Should be id 2 0.25f?
            if (Map* map = sMapMgr->FindBaseNonInstanceMap(530))
                map->SetZoneWeather(ZONEID_ISLE_OF_QUEL_DANAS, WEATHER_STATE_LIGHT_RAIN, 0.25f);
            break;
        case SUNS_REACH_PHASE_4_HARBOR:
            if (initial)
            {
                sGameEventMgr->StartEvent(GAME_EVENT_QUEL_DANAS_PHASE_2_PERMANENT);
                sGameEventMgr->StartEvent(GAME_EVENT_QUEL_DANAS_PHASE_3_PERMANENT);
            }
            sGameEventMgr->StartEvent(GAME_EVENT_QUEL_DANAS_PHASE_4);
            if (Map* map = sMapMgr->FindBaseNonInstanceMap(530))
                map->SetZoneWeather(ZONEID_ISLE_OF_QUEL_DANAS, WEATHER_STATE_FINE, 0.0f);
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

void WorldState::FillInitialWorldStates(WorldPackets::WorldState::InitWorldStates& packet, uint32 zoneId, uint32 /*areaId*/)
{
    switch (zoneId)
    {
        case ZONEID_ISLE_OF_QUEL_DANAS:
        case ZONEID_MAGISTERS_TERRACE:
        case ZONEID_SUNWELL_PLATEAU:
        case ZONEID_SHATTRATH:
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
    }
}

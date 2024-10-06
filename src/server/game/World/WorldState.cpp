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

#include "Player.h"
#include "SharedDefines.h"
#include "WorldState.h"

WorldState* WorldState::instance()
{
    static WorldState instance;
    return &instance;
}

WorldState::WorldState() : _isMagtheridonHeadSpawnedHorde(false), _isMagtheridonHeadSpawnedAlliance(false)
{
    _transportStates[CONDITION_THE_PURPLE_PRINCESS] = ZEPPELIN_STATE_UNKOWN;
    _transportStates[CONDITION_THE_IRON_EAGLE]      = ZEPPELIN_STATE_UNKOWN;
    _transportStates[CONDITION_THE_THUNDERCALLER]   = ZEPPELIN_STATE_UNKOWN;
}

WorldState::~WorldState()
{
}

bool WorldState::IsConditionFulfilled(uint32 conditionId, uint32 state) const
{
    switch (conditionId)
    {
        case CONDITION_TROLLBANES_COMMAND:
            return _isMagtheridonHeadSpawnedAlliance;
        case CONDITION_NAZGRELS_FAVOR:
            return _isMagtheridonHeadSpawnedHorde;
        default:
            return _transportStates.at(conditionId) == state;
    }
}

void WorldState::HandleConditionStateChange(uint32 conditionId, uint32 state)
{
    _transportStates[conditionId] = state;
}

void WorldState::HandleExternalEvent(uint32 eventId, uint32 param)
{
    std::lock_guard<std::mutex> guard(_mutex);
    switch (eventId)
    {
        case CUSTOM_EVENT_ADALS_SONG_OF_BATTLE:
            if (!_adalSongOfBattleTimer)
            {
                _adalSongOfBattleTimer = 120 * MINUTE * IN_MILLISECONDS;
                BuffAdalsSongOfBattle();
            }
            break;
        case CUSTOM_EVENT_MAGTHERIDON_HEAD_SPAWN:
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
        case CUSTOM_EVENT_MAGTHERIDON_HEAD_DESPAWN:
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
    std::lock_guard<std::mutex> guard(_mutex);
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

void WorldState::HandlePlayerEnterZone(Player* player, uint32 zoneId)
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
        default:
            break;
    }
};
void WorldState::HandlePlayerLeaveZone(Player* player, uint32 zoneId)
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

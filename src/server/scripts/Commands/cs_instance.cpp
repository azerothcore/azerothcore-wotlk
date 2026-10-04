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

#include "Chat.h"
#include "CommandScript.h"
#include "DBCStores.h"
#include "DatabaseEnv.h"
#include "GameTime.h"
#include "InstanceSaveMgr.h"
#include "InstanceScript.h"
#include "Language.h"
#include "MapMgr.h"
#include "ObjectMgr.h"
#include "Player.h"
#include "RBAC.h"

using namespace Acore::ChatCommands;

class instance_commandscript : public CommandScript
{
public:
    instance_commandscript() : CommandScript("instance_commandscript") { }

    ChatCommandTable GetCommands() const override
    {
        static ChatCommandTable instanceCommandTable =
        {
            { "listbinds",    HandleInstanceListBindsCommand,    rbac::RBAC_PERM_COMMAND_INSTANCE_LISTBINDS,     Console::No },
            { "unbind",       HandleInstanceUnbindCommand,       rbac::RBAC_PERM_COMMAND_INSTANCE_UNBIND,        Console::Yes },
            { "stats",        HandleInstanceStatsCommand,        rbac::RBAC_PERM_COMMAND_INSTANCE_STATS,         Console::Yes },
            { "savedata",     HandleInstanceSaveDataCommand,     rbac::RBAC_PERM_COMMAND_INSTANCE_SAVEDATA,      Console::No },
            { "setbossstate", HandleInstanceSetBossStateCommand, rbac::RBAC_PERM_COMMAND_INSTANCE_SET_BOSS_STATE, Console::Yes },
            { "getbossstate", HandleInstanceGetBossStateCommand, rbac::RBAC_PERM_COMMAND_INSTANCE_GET_BOSS_STATE, Console::Yes },
        };

        static ChatCommandTable commandTable =
        {
            { "instance", instanceCommandTable },
        };

        return commandTable;
    }

    static bool HandleInstanceListBindsCommand(ChatHandler* handler)
    {
        Player* player = handler->getSelectedPlayer();
        if (!player)
            player = handler->GetSession()->GetPlayer();

        uint32 counter = 0;

        for (uint8 i = 0; i < MAX_DIFFICULTY; ++i)
        {
            for (auto const& [mapId, bind] : sInstanceSaveMgr->PlayerGetBoundInstances(player->GetGUID(), Difficulty(i)))
            {
                InstanceSave const* save = bind.save;
                uint32 resetTime = bind.extended ? save->GetExtendedResetTime() : save->GetResetTime();
                uint32 ttr = (resetTime >= GameTime::GetGameTime().count() ? resetTime - GameTime::GetGameTime().count() : 0);
                std::string timeleft = secsToTimeString(ttr);
                handler->PSendSysMessage("map: {}, inst: {}, perm: {}, diff: {}, canReset: {}, TTR: {}{}",
                    mapId, save->GetInstanceId(), bind.perm ? "yes" : "no", save->GetDifficulty(), save->CanReset() ? "yes" : "no", timeleft, (bind.extended ? " (extended)" : ""));
                counter++;
            }
        }

        handler->PSendSysMessage("player binds: {}", counter);

        return true;
    }

    // Player last, difficulty uint32: a number meant as map or difficulty is never read as a character guid
    static bool HandleInstanceUnbindCommand(ChatHandler* handler, Variant<uint16, EXACT_SEQUENCE("all")> mapArg,
        Optional<uint32> difficultyArg, Optional<PlayerIdentifier> target)
    {
        if (!target)
            target = PlayerIdentifier::FromTargetOrSelf(handler);

        if (!target)
        {
            handler->SendErrorMessage(LANG_PLAYER_NOT_FOUND);
            return false;
        }

        Player* player = target->GetConnectedPlayer();
        ObjectGuid const guid = target->GetGUID();

        // Keep the bind of the map the character is on, or logged out on
        uint32 currentMapId = 0;
        if (player)
            currentMapId = player->GetMapId();
        else
        {
            CharacterDatabasePreparedStatement* stmt =
                CharacterDatabase.GetPreparedStatement(CHAR_SEL_CHAR_POSITION_XYZ);
            stmt->SetData(0, guid.GetCounter());
            if (PreparedQueryResult result = CharacterDatabase.Query(stmt))
                currentMapId = (*result)[0].Get<uint16>();
        }

        uint16 counter = 0;
        uint16 mapId = 0;

        if (mapArg.holds_alternative<uint16>())
        {
            mapId = mapArg.get<uint16>();
            if (!mapId)
                return false;
        }

        for (uint8 i = 0; i < MAX_DIFFICULTY; ++i)
        {
            BoundInstancesMap const& m_boundInstances = sInstanceSaveMgr->PlayerGetBoundInstances(guid, Difficulty(i));
            for (BoundInstancesMap::const_iterator itr = m_boundInstances.begin(); itr != m_boundInstances.end();)
            {
                InstanceSave const* save = itr->second.save;
                if (itr->first != currentMapId && (!mapId || mapId == itr->first) && (!difficultyArg || *difficultyArg == uint32(save->GetDifficulty())))
                {
                    uint32 resetTime = itr->second.extended ? save->GetExtendedResetTime() : save->GetResetTime();
                    uint32 ttr = (resetTime >= GameTime::GetGameTime().count() ? resetTime - GameTime::GetGameTime().count() : 0);
                    std::string timeleft = secsToTimeString(ttr);
                    handler->PSendSysMessage("unbinding map: {}, inst: {}, perm: {}, diff: {}, canReset: {}, TTR: {}{}", itr->first, save->GetInstanceId(), itr->second.perm ? "yes" : "no", save->GetDifficulty(), save->CanReset() ? "yes" : "no", timeleft, (itr->second.extended ? " (extended)" : ""));
                    sInstanceSaveMgr->PlayerUnbindInstance(guid, itr->first, Difficulty(i), true, player);
                    itr = m_boundInstances.begin();
                    counter++;
                }
                else
                    ++itr;
            }
        }

        handler->PSendSysMessage("instances unbound: {}", counter);

        return true;
    }

    static bool HandleInstanceStatsCommand(ChatHandler* handler)
    {
        uint32 dungeon = 0, battleground = 0, arena = 0, spectators = 0;
        sMapMgr->GetNumInstances(dungeon, battleground, arena);
        handler->PSendSysMessage("instances loaded: dungeons ({}), battlegrounds ({}), arenas ({})", dungeon, battleground, arena);
        dungeon = 0;
        battleground = 0;
        arena = 0;
        spectators = 0;
        sMapMgr->GetNumPlayersInInstances(dungeon, battleground, arena, spectators);
        handler->SendErrorMessage("players in instances: dungeons ({}), battlegrounds ({}), arenas ({} + {} spect)", dungeon, battleground, arena, spectators);
        return false;
    }

    static bool HandleInstanceSaveDataCommand(ChatHandler* handler)
    {
        Player* player = handler->GetSession()->GetPlayer();
        Map* map = player->GetMap();
        if (!map->IsDungeon())
        {
            handler->SendErrorMessage("Map is not a dungeon.");
            return false;
        }

        if (!map->ToInstanceMap()->GetInstanceScript())
        {
            handler->SendErrorMessage("Map has no instance data.");
            return false;
        }

        map->ToInstanceMap()->GetInstanceScript()->SaveToDB();

        return true;
    }

    static bool HandleInstanceSetBossStateCommand(ChatHandler* handler, uint32 encounterId, uint32 state, Optional<PlayerIdentifier> player)
    {
        // Character name must be provided when using this from console.
        if (!player && !handler->GetSession())
        {
            handler->SendErrorMessage(LANG_CMD_SYNTAX);
            return false;
        }

        if (!player)
            player = PlayerIdentifier::FromSelf(handler);

        if (!player->IsConnected())
        {
            handler->SendErrorMessage(LANG_PLAYER_NOT_FOUND);
            return false;
        }

        InstanceMap* map = player->GetConnectedPlayer()->GetMap()->ToInstanceMap();
        if (!map)
        {
            handler->SendErrorMessage(LANG_NOT_DUNGEON);
            return false;
        }

        if (!map->GetInstanceScript())
        {
            handler->SendErrorMessage(LANG_NO_INSTANCE_DATA);
            return false;
        }

        // Reject improper values.
        if (encounterId > map->GetInstanceScript()->GetEncounterCount())
        {
            handler->SendErrorMessage(LANG_BAD_VALUE);
            return false;
        }

        map->GetInstanceScript()->SetBossState(encounterId, EncounterState(state));
        std::string stateName = InstanceScript::GetBossStateName(state);
        std::string bossName = GetBossName(GetEncounterNames(map), encounterId);
        handler->PSendSysMessage(LANG_COMMAND_INST_SET_BOSS_STATE, encounterId, bossName, state, stateName);
        return true;
    }

    static bool HandleInstanceGetBossStateCommand(ChatHandler* handler, Optional<PlayerIdentifier> player)
    {
        // Character name must be provided when using this from console.
        if (!player && !handler->GetSession())
        {
            handler->SendErrorMessage(LANG_CMD_SYNTAX);
            return false;
        }

        if (!player)
            player = PlayerIdentifier::FromSelf(handler);

        if (!player->IsConnected())
        {
            handler->SendErrorMessage(LANG_PLAYER_NOT_FOUND);
            return false;
        }

        InstanceMap* map = player->GetConnectedPlayer()->GetMap()->ToInstanceMap();
        if (!map)
        {
            handler->SendErrorMessage(LANG_NOT_DUNGEON);
            return false;
        }

        if (!map->GetInstanceScript())
        {
            handler->SendErrorMessage(LANG_NO_INSTANCE_DATA);
            return false;
        }

        std::unordered_map<uint32, char const*> encounterNames = GetEncounterNames(map);

        for (uint8 i = 0; i < map->GetInstanceScript()->GetEncounterCount(); ++i)
        {
            uint32 state = map->GetInstanceScript()->GetBossState(i);
            std::string stateName = InstanceScript::GetBossStateName(state);
            std::string bossName = GetBossName(encounterNames, i);

            handler->PSendSysMessage(
                LANG_COMMAND_INST_GET_BOSS_STATE,
                i, bossName, state, stateName);
        }

        return true;
    }

private:
    // Maps encounterIndex -> encounterName from DBC data
    static std::unordered_map<uint32, char const*> GetEncounterNames(InstanceMap const* map)
    {
        std::unordered_map<uint32, char const*> encounterNames;
        Difficulty difficulty = map->GetDifficulty();

        // For heroic ICC/Ruby Sanctum, encounters are only defined
        // for normal difficulty in the DBC, use the same fallback
        // pattern as Map::UpdateEncounterState
        DungeonEncounterList const* encounters = nullptr;
        if ((map->GetId() == 631 || map->GetId() == 724)
            && map->IsHeroic())
        {
            encounters = sObjectMgr->GetDungeonEncounterList(
                map->GetId(),
                !map->Is25ManRaid()
                    ? RAID_DIFFICULTY_10MAN_NORMAL
                    : RAID_DIFFICULTY_25MAN_NORMAL);
        }
        else
        {
            Difficulty diffFixed = IsSharedDifficultyMap(map->GetId())
                ? Difficulty(difficulty % 2)
                : difficulty;
            encounters = sObjectMgr->GetDungeonEncounterList(
                map->GetId(), diffFixed);
        }

        if (encounters)
        {
            for (auto const* encounter : *encounters)
                encounterNames[encounter->dbcEntry->encounterIndex]
                    = encounter->dbcEntry->encounterName[0];
        }

        return encounterNames;
    }

    static std::string GetBossName(std::unordered_map<uint32, char const*> const& encounterNames, uint32 encounterId)
    {
        auto it = encounterNames.find(encounterId);
        return (it != encounterNames.end() && it->second) ? it->second : "Unknown";
    }
};

void AddSC_instance_commandscript()
{
    new instance_commandscript();
}

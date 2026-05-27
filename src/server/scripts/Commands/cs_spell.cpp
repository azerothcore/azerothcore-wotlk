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
#include "DatabaseEnv.h"
#include "Language.h"
#include "RBAC.h"
#include "SpellInfo.h"
#include "SpellMgr.h"
#include <algorithm>

using namespace Acore::ChatCommands;

class spell_commandscript : public CommandScript
{
public:
    spell_commandscript() : CommandScript("spell_commandscript") { }

    ChatCommandTable GetCommands() const override
    {
        static ChatCommandTable spellGobjectFactionCommandTable =
        {
            { "add",    HandleSpellGobjectFactionAddCommand,    rbac::RBAC_PERM_COMMAND_SPELL_GOBJECT_FACTION_ADD,    Console::Yes },
            { "remove", HandleSpellGobjectFactionRemoveCommand, rbac::RBAC_PERM_COMMAND_SPELL_GOBJECT_FACTION_REMOVE, Console::Yes },
            { "list",   HandleSpellGobjectFactionListCommand,   rbac::RBAC_PERM_COMMAND_SPELL_GOBJECT_FACTION_LIST,   Console::Yes },
            { "update", HandleSpellGobjectFactionUpdateCommand, rbac::RBAC_PERM_COMMAND_SPELL_GOBJECT_FACTION_UPDATE, Console::Yes },
        };

        static ChatCommandTable spellGobjectCommandTable =
        {
            { "faction", spellGobjectFactionCommandTable },
        };

        static ChatCommandTable spellCommandTable =
        {
            { "gobject", spellGobjectCommandTable },
        };

        static ChatCommandTable commandTable =
        {
            { "spell", spellCommandTable },
        };

        return commandTable;
    }

    // .spell gobject faction add <spell_id|spelllink> <team_id> [comment]
    // team_id: 0 = Alliance, 1 = Horde
    static bool HandleSpellGobjectFactionAddCommand(ChatHandler* handler, SpellInfo const* spellInfo, uint8 teamId, Optional<Tail> comment)
    {
        if (teamId >= TEAM_NEUTRAL)
        {
            handler->PSendSysMessage(LANG_SPELL_GO_FACTION_INVALID_TEAM, teamId);
            handler->SetSentErrorMessage(true);
            return false;
        }

        uint32 spellId = spellInfo->Id;

        if (sSpellMgr->GetSpellGameObjectFaction(spellId))
        {
            handler->PSendSysMessage(LANG_SPELL_GO_FACTION_ADD_ALREADY_EXISTS, spellId, spellInfo->SpellName[0]);
            handler->SetSentErrorMessage(true);
            return false;
        }

        char const* teamName = (teamId == TEAM_ALLIANCE) ? "Alliance" : "Horde";
        std::string commentStr = comment ? std::string(*comment) : "";

        WorldDatabasePreparedStatement* stmt = WorldDatabase.GetPreparedStatement(WORLD_INS_SPELL_GO_FACTION);
        stmt->SetData(0, spellId);
        stmt->SetData(1, teamId);
        stmt->SetData(2, commentStr);
        WorldDatabase.DirectExecute(stmt);

        sSpellMgr->LoadSpellGameObjectFactions();

        handler->PSendSysMessage(LANG_SPELL_GO_FACTION_ADDED, spellId, spellInfo->SpellName[0], teamName);
        return true;
    }

    // .spell gobject faction remove <spell_id|spelllink>
    static bool HandleSpellGobjectFactionRemoveCommand(ChatHandler* handler, SpellInfo const* spellInfo)
    {
        uint32 spellId = spellInfo->Id;
        TeamId const* existingTeam = sSpellMgr->GetSpellGameObjectFaction(spellId);
        if (!existingTeam)
        {
            handler->PSendSysMessage(LANG_SPELL_GO_FACTION_NO_RESTRICTION, spellId, spellInfo->SpellName[0]);
            handler->SetSentErrorMessage(true);
            return false;
        }

        char const* teamName = (*existingTeam == TEAM_ALLIANCE) ? "Alliance" : "Horde";

        WorldDatabasePreparedStatement* stmt = WorldDatabase.GetPreparedStatement(WORLD_DEL_SPELL_GO_FACTION);
        stmt->SetData(0, spellId);
        WorldDatabase.DirectExecute(stmt);

        sSpellMgr->LoadSpellGameObjectFactions();

        handler->PSendSysMessage(LANG_SPELL_GO_FACTION_REMOVED, spellId, spellInfo->SpellName[0], teamName);
        return true;
    }

    // .spell gobject faction update <spell_id|spelllink> <team_id> [comment]
    // team_id: 0 = Alliance, 1 = Horde
    static bool HandleSpellGobjectFactionUpdateCommand(ChatHandler* handler, SpellInfo const* spellInfo, uint8 teamId, Optional<Tail> comment)
    {
        uint32 spellId = spellInfo->Id;

        TeamId const* existingTeam = sSpellMgr->GetSpellGameObjectFaction(spellId);
        if (!existingTeam)
        {
            handler->PSendSysMessage(LANG_SPELL_GO_FACTION_NOT_IN_TABLE, spellId, spellInfo->SpellName[0]);
            handler->SetSentErrorMessage(true);
            return false;
        }

        if (teamId >= TEAM_NEUTRAL)
        {
            handler->PSendSysMessage(LANG_SPELL_GO_FACTION_INVALID_TEAM, teamId);
            handler->SetSentErrorMessage(true);
            return false;
        }

        char const* teamName = (teamId == TEAM_ALLIANCE) ? "Alliance" : "Horde";

        if (*existingTeam == static_cast<TeamId>(teamId))
        {
            handler->PSendSysMessage(LANG_SPELL_GO_FACTION_ALREADY_SET, spellId, spellInfo->SpellName[0], teamName);
            handler->SetSentErrorMessage(true);
            return false;
        }

        std::string commentStr = comment ? std::string(*comment) : "";

        WorldDatabasePreparedStatement* stmt = WorldDatabase.GetPreparedStatement(WORLD_UPD_SPELL_GO_FACTION);
        stmt->SetData(0, teamId);
        stmt->SetData(1, commentStr);
        stmt->SetData(2, spellId);
        WorldDatabase.DirectExecute(stmt);

        sSpellMgr->LoadSpellGameObjectFactions();

        handler->PSendSysMessage(LANG_SPELL_GO_FACTION_UPDATED, spellId, spellInfo->SpellName[0], teamName);
        return true;
    }

    // .spell gobject faction list [nameFilter]
    static bool HandleSpellGobjectFactionListCommand(ChatHandler* handler, Optional<Tail> nameFilter)
    {
        WorldDatabasePreparedStatement* stmt = WorldDatabase.GetPreparedStatement(WORLD_SEL_SPELL_GO_FACTION_ALL);
        PreparedQueryResult result = WorldDatabase.Query(stmt);

        if (!result)
        {
            handler->SendSysMessage(LANG_SPELL_GO_FACTION_NO_ENTRIES);
            return true;
        }

        std::string filter;
        if (nameFilter)
        {
            filter = std::string(*nameFilter);
            std::transform(filter.begin(), filter.end(), filter.begin(), ::tolower);
        }

        handler->SendSysMessage("================================");

        uint32 count = 0;
        do
        {
            Field* fields = result->Fetch();
            uint32 spellId = fields[0].Get<uint32>();
            uint8 teamId   = fields[1].Get<uint8>();

            SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(spellId);
            char const* spellName = spellInfo ? spellInfo->SpellName[0] : "Unknown";

            if (!filter.empty())
            {
                std::string nameLower(spellName);
                std::transform(nameLower.begin(), nameLower.end(), nameLower.begin(), ::tolower);
                if (nameLower.find(filter) == std::string::npos)
                    continue;
            }

            char const* teamName = (teamId == TEAM_ALLIANCE) ? "Alliance" : "Horde";
            handler->PSendSysMessage("{} ({}) - {}", spellId, spellName, teamName);
            ++count;
        } while (result->NextRow());

        handler->SendSysMessage("================================");
        handler->PSendSysMessage(LANG_SPELL_GO_FACTION_COUNT, count);
        return true;
    }
};

void AddSC_spell_commandscript()
{
    new spell_commandscript();
}

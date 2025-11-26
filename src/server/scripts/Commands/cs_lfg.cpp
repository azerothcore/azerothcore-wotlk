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
#include "Group.h"
#include "LFGMgr.h"
#include "Language.h"
#include "Player.h"

void GetPlayerInfo(ChatHandler*  handler, Player* player)
{
    if (!player)
        return;

    ObjectGuid guid = player->GetGUID();
    lfg::LfgDungeonSet dungeons = sLFGMgr->GetSelectedDungeons(guid);

    std::string const& state = lfg::GetStateString(sLFGMgr->GetState(guid));
    handler->PSendSysMessage(LANG_LFG_PLAYER_INFO, player->GetName(),
                             state, uint8(dungeons.size()), lfg::ConcatenateDungeons(dungeons),
                             lfg::GetRolesString(sLFGMgr->GetRoles(guid)), sLFGMgr->GetComment(guid));
}

using namespace Acore::ChatCommands;

class lfg_commandscript : public CommandScript
{
public:
    lfg_commandscript() : CommandScript("lfg_commandscript") { }

    ChatCommandTable GetCommands() const override
    {
        static ChatCommandTable lfgCommandTable =
        {
            { "player",  HandleLfgPlayerInfoCommand, SEC_MODERATOR,     Console::No },
            { "group",   HandleLfgGroupInfoCommand,  SEC_MODERATOR,     Console::No },
            { "queue",   HandleLfgQueueInfoCommand,  SEC_MODERATOR,     Console::Yes },
            { "clean",   HandleLfgCleanCommand,      SEC_ADMINISTRATOR, Console::Yes },
            { "options", HandleLfgOptionsCommand,    SEC_GAMEMASTER,    Console::Yes },
        };

        static ChatCommandTable commandTable =
        {
            { "lfg", lfgCommandTable },
        };
        return commandTable;
    }

    static bool HandleLfgPlayerInfoCommand(ChatHandler* handler, Optional<PlayerIdentifier> player)
    {
        if (!player)
            player = PlayerIdentifier::FromTargetOrSelf(handler);
        if (!player)
            return false;

        if (Player* target = player->GetConnectedPlayer())
        {
            GetPlayerInfo(handler, target);
            return true;
        }

        return false;
    }

    static bool HandleLfgGroupInfoCommand(ChatHandler* handler, Optional<PlayerIdentifier> player)
    {
        if (!player)
            player = PlayerIdentifier::FromTargetOrSelf(handler);
        if (!player)
            return false;

        Group* groupTarget = nullptr;
        if (Player* target = player->GetConnectedPlayer())
            groupTarget = target->GetGroup();
        if (!groupTarget)
        {
            handler->PSendSysMessage(LANG_LFG_NOT_IN_GROUP, player->GetName());
            return true;
        }

        ObjectGuid guid = groupTarget->GetGUID();
        std::string const& state = lfg::GetStateString(sLFGMgr->GetState(guid));
        handler->PSendSysMessage(LANG_LFG_GROUP_INFO, groupTarget->isLFGGroup(),
                                 state, sLFGMgr->GetDungeon(guid));

        for (GroupReference* itr = groupTarget->GetFirstMember(); itr != nullptr; itr = itr->next())
            GetPlayerInfo(handler, itr->GetSource());

        return true;
    }

    static bool HandleLfgOptionsCommand(ChatHandler* handler, Optional<uint32> optionsArg)
    {
        if (optionsArg)
        {
            sLFGMgr->SetOptions(*optionsArg);
            handler->PSendSysMessage(LANG_LFG_OPTIONS_CHANGED);
        }
        handler->PSendSysMessage(LANG_LFG_OPTIONS, sLFGMgr->GetOptions());
        return true;
    }

    static bool HandleLfgQueueInfoCommand(ChatHandler* /*handler*/)
    {
        return true;
    }

    static bool HandleLfgCleanCommand(ChatHandler* handler)
    {
        handler->PSendSysMessage(LANG_LFG_CLEAN);
        sLFGMgr->Clean();
        return true;
    }
};

void AddSC_lfg_commandscript()
{
    new lfg_commandscript();
}

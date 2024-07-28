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

/* ScriptData
Name: guild_commandscript
%Complete: 100
Comment: All guild related commands
Category: commandscripts
EndScriptData */

#include "Chat.h"
#include "CommandScript.h"
#include "Guild.h"
#include "GuildMgr.h"

using namespace Acore::ChatCommands;

class guild_commandscript : public CommandScript
{
public:
    guild_commandscript() : CommandScript("guild_commandscript") { }

    ChatCommandTable GetCommands() const override
    {
        static ChatCommandTable guildCommandTable =
        {
            { "create",     HandleGuildCreateCommand,   SEC_GAMEMASTER, Console::Yes },
            { "delete",     HandleGuildDeleteCommand,   SEC_GAMEMASTER, Console::Yes },
            { "invite",     HandleGuildInviteCommand,   SEC_GAMEMASTER, Console::Yes },
            { "uninvite",   HandleGuildUninviteCommand, SEC_GAMEMASTER, Console::Yes },
            { "rank",       HandleGuildRankCommand,     SEC_GAMEMASTER, Console::Yes },
            { "rename",     HandleGuildRenameCommand,   SEC_GAMEMASTER, Console::Yes },
            { "info",       HandleGuildInfoCommand,     SEC_GAMEMASTER, Console::Yes }
        };
        static ChatCommandTable commandTable =
        {
            { "guild", guildCommandTable }
        };
        return commandTable;
    }

    static bool HandleGuildCreateCommand(ChatHandler* handler, Optional<PlayerIdentifier> target, QuotedString guildName)
    {
        if (!target)
        {
            target = PlayerIdentifier::FromTargetOrSelf(handler);
        }

        if (!target || !target->IsConnected())
        {
            handler->SendErrorMessage(LANG_PLAYER_NOT_FOUND);
            return false;
        }

        if (guildName.empty())
        {
            return false;
        }

        Player* playerTarget = target->GetConnectedPlayer();

        if (playerTarget->GetGuildId())
        {
            handler->SendErrorMessage(LANG_PLAYER_IN_GUILD);
            return false;
        }

        if (sGuildMgr->GetGuildByName(guildName))
        {
            handler->SendErrorMessage(LANG_GUILD_RENAME_ALREADY_EXISTS);
            return false;
        }

        if (!sObjectMgr->IsValidCharterName(guildName))
        {
            handler->SendErrorMessage(LANG_BAD_VALUE);
            return false;
        }

        Guild* guild = new Guild;
        if (!guild->Create(playerTarget, guildName))
        {
            delete guild;
            handler->SendErrorMessage(LANG_GUILD_NOT_CREATED);
            return false;
        }

        sGuildMgr->AddGuild(guild);

        return true;
    }

    static bool HandleGuildDeleteCommand(ChatHandler*, QuotedString guildName)
    {
        if (guildName.empty())
        {
            return false;
        }

        Guild* targetGuild = sGuildMgr->GetGuildByName(guildName);
        if (!targetGuild)
            return false;

        targetGuild->Disband();
        delete targetGuild;

        return true;
    }

    static bool HandleGuildInviteCommand(ChatHandler* handler, Optional<PlayerIdentifier> target, QuotedString guildName)
    {
        if (!target)
        {
            target = PlayerIdentifier::FromTargetOrSelf(handler);
        }

        if (!target)
        {
            return false;
        }

        if (guildName.empty())
        {
            return false;
        }

        Guild* targetGuild = sGuildMgr->GetGuildByName(guildName);
        if (!targetGuild)
            return false;

        // player's guild membership checked in AddMember before add
        return targetGuild->AddMember(target->GetGUID());
    }

    static bool HandleGuildUninviteCommand(ChatHandler* handler, Optional<PlayerIdentifier> target)
    {
        if (!target)
        {
            target = PlayerIdentifier::FromTargetOrSelf(handler);
        }

        if (!target)
        {
            return false;
        }

        Player* playerTarget = target->GetConnectedPlayer();

        uint32 guildId = playerTarget ? playerTarget->GetGuildId() : sCharacterCache->GetCharacterGuildIdByGuid(target->GetGUID());
        if (!guildId)
            return false;

        Guild* targetGuild = sGuildMgr->GetGuildById(guildId);
        if (!targetGuild)
            return false;

        targetGuild->DeleteMember(target->GetGUID(), false, true, true);
        return true;
    }

    static bool HandleGuildRankCommand(ChatHandler* handler, Optional<PlayerIdentifier> player, uint8 rank)
    {
        if (!player)
            player = PlayerIdentifier::FromTargetOrSelf(handler);

        if (!player)
            return false;

        uint32 guildId = player->IsConnected() ? player->GetConnectedPlayer()->GetGuildId() : sCharacterCache->GetCharacterGuildIdByGuid(player->GetGUID());
        if (!guildId)
            return false;

        Guild* targetGuild = sGuildMgr->GetGuildById(guildId);
        if (!targetGuild)
            return false;

        return targetGuild->ChangeMemberRank(player->GetGUID(), rank);
    }

    static bool HandleGuildRenameCommand(ChatHandler* handler, QuotedString oldGuildStr, QuotedString newGuildStr)
    {
        if (oldGuildStr.empty() || newGuildStr.empty())
        {
            return false;
        }

        Guild* guild = sGuildMgr->GetGuildByName(oldGuildStr);
        if (!guild)
        {
            handler->SendErrorMessage(LANG_COMMAND_COULDNOTFIND, oldGuildStr);
            return false;
        }

        if (sGuildMgr->GetGuildByName(newGuildStr))
        {
            handler->SendErrorMessage(LANG_GUILD_RENAME_ALREADY_EXISTS, newGuildStr);
            return false;
        }

        if (!guild->SetName(newGuildStr))
        {
            handler->SendErrorMessage(LANG_BAD_VALUE);
            return false;
        }

        handler->PSendSysMessage(LANG_GUILD_RENAME_DONE, oldGuildStr, newGuildStr);
        return true;
    }

    static bool HandleGuildInfoCommand(ChatHandler* handler, Optional<Variant<ObjectGuid::LowType, QuotedString>> const& guildIdentifier)
    {
        Guild* guild = nullptr;

        if (guildIdentifier)
        {
            if (ObjectGuid::LowType const* guid = std::get_if<ObjectGuid::LowType>(&*guildIdentifier))
                guild = sGuildMgr->GetGuildById(*guid);
            else
                guild = sGuildMgr->GetGuildByName(guildIdentifier->get<QuotedString>());
        }
        else if (Optional<PlayerIdentifier> target = PlayerIdentifier::FromTargetOrSelf(handler); target && target->IsConnected())
            guild = target->GetConnectedPlayer()->GetGuild();

        if (!guild)
            return false;

        // Display Guild Information
        handler->PSendSysMessage(LANG_GUILD_INFO_NAME, guild->GetName(), guild->GetId()); // Guild Id + Name

        std::string guildMasterName;
        if (sCharacterCache->GetCharacterNameByGuid(guild->GetLeaderGUID(), guildMasterName))
            handler->PSendSysMessage(LANG_GUILD_INFO_GUILD_MASTER, guildMasterName, guild->GetLeaderGUID().ToString()); // Guild Master

        // Format creation date
        char createdDateStr[20];
        time_t createdDate = guild->GetCreatedDate();
        tm localTm;
        strftime(createdDateStr, 20, "%Y-%m-%d %H:%M:%S", localtime_r(&createdDate, &localTm));

        handler->PSendSysMessage(LANG_GUILD_INFO_CREATION_DATE, createdDateStr); // Creation Date
        handler->PSendSysMessage(LANG_GUILD_INFO_MEMBER_COUNT, guild->GetMemberCount()); // Number of Members
        handler->PSendSysMessage(LANG_GUILD_INFO_BANK_GOLD, guild->GetTotalBankMoney() / 100 / 100); // Bank Gold (in gold coins)
        handler->PSendSysMessage(LANG_GUILD_INFO_MOTD, guild->GetMOTD()); // Message of the Day
        handler->PSendSysMessage(LANG_GUILD_INFO_EXTRA_INFO, guild->GetInfo()); // Extra Information
        return true;
    }
};

void AddSC_guild_commandscript()
{
    new guild_commandscript();
}

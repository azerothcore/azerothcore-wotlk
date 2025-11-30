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

#include "ArenaTeamMgr.h"
#include "ArenaSeasonMgr.h"
#include "ArenaTeamFilter.h"
#include "Chat.h"
#include "CommandScript.h"
#include "Player.h"

using namespace Acore::ChatCommands;

class arena_commandscript : public CommandScript
{
public:
    arena_commandscript() : CommandScript("arena_commandscript") { }

    ChatCommandTable GetCommands() const override
    {
        static ChatCommandTable arenaSeasonSetCommandTable =
        {
            { "state",          HandleArenaSeasonSetStateCommand, SEC_ADMINISTRATOR, Console::Yes }
        };

        static ChatCommandTable arenaSeasonCommandTable =
        {
            { "reward",         HandleArenaSeasonRewardCommand,      SEC_ADMINISTRATOR, Console::Yes },
            { "deleteteams",    HandleArenaSeasonDeleteTeamsCommand, SEC_ADMINISTRATOR, Console::Yes },
            { "start",          HandleArenaSeasonStartCommand,       SEC_ADMINISTRATOR, Console::Yes },
            { "set",            arenaSeasonSetCommandTable }
        };

        static ChatCommandTable arenaCommandTable =
        {
            { "create",         HandleArenaCreateCommand,   SEC_ADMINISTRATOR, Console::Yes },
            { "disband",        HandleArenaDisbandCommand,  SEC_ADMINISTRATOR, Console::Yes },
            { "rename",         HandleArenaRenameCommand,   SEC_ADMINISTRATOR, Console::Yes },
            { "captain",        HandleArenaCaptainCommand,  SEC_ADMINISTRATOR, Console::No  },
            { "info",           HandleArenaInfoCommand,     SEC_GAMEMASTER,    Console::Yes },
            { "lookup",         HandleArenaLookupCommand,   SEC_GAMEMASTER,    Console::Yes },
            { "season",         arenaSeasonCommandTable  }
        };

        static ChatCommandTable commandTable =
        {
            { "arena", arenaCommandTable }
        };

        return commandTable;
    }

    static bool HandleArenaCreateCommand(ChatHandler* handler, Optional<PlayerIdentifier> captain, QuotedString name, ArenaTeamTypes type)
    {
        if (sArenaTeamMgr->GetArenaTeamByName(name))
        {
            handler->SendErrorMessage(LANG_ARENA_ERROR_NAME_EXISTS, name);
            return false;
        }

        if (!captain)
            captain = PlayerIdentifier::FromTargetOrSelf(handler);

        if (!captain)
            return false;

        if (Player::GetArenaTeamIdFromDB(captain->GetGUID(), type) != 0)
        {
            handler->SendErrorMessage(LANG_ARENA_ERROR_SIZE, captain->GetName());
            return false;
        }

        ArenaTeam* arena = new ArenaTeam();

        if (!arena->Create(captain->GetGUID(), type, name, 4293102085, 101, 4293253939, 4, 4284049911))
        {
            delete arena;
            handler->SendErrorMessage(LANG_BAD_VALUE);
            return false;
        }

        sArenaTeamMgr->AddArenaTeam(arena);
        handler->PSendSysMessage(LANG_ARENA_CREATE, arena->GetName(), arena->GetId(), arena->GetType(), arena->GetCaptain().ToString());

        return true;
    }

    static bool HandleArenaDisbandCommand(ChatHandler* handler, uint32 teamId)
    {
        ArenaTeam* arena = sArenaTeamMgr->GetArenaTeamById(teamId);

        if (!arena)
        {
            handler->SendErrorMessage(LANG_ARENA_ERROR_NOT_FOUND, teamId);
            return false;
        }

        if (arena->IsFighting())
        {
            handler->SendErrorMessage(LANG_ARENA_ERROR_COMBAT);
            return false;
        }

        std::string name = arena->GetName();
        arena->Disband();

        delete(arena);

        handler->PSendSysMessage(LANG_ARENA_DISBAND, name, teamId);
        return true;
    }

    static bool HandleArenaRenameCommand(ChatHandler* handler, QuotedString oldName, QuotedString newName)
    {
        ArenaTeam* arena = sArenaTeamMgr->GetArenaTeamByName(oldName);
        if (!arena)
        {
            handler->SendErrorMessage(LANG_ARENA_ERROR_NAME_NOT_FOUND, oldName);
            return false;
        }

        if (sArenaTeamMgr->GetArenaTeamByName(newName))
        {
            handler->SendErrorMessage(LANG_ARENA_ERROR_NAME_EXISTS, oldName);
            return false;
        }

        if (arena->IsFighting())
        {
            handler->SendErrorMessage(LANG_ARENA_ERROR_COMBAT);
            return false;
        }

        if (!arena->SetName(newName))
        {
            handler->SendErrorMessage(LANG_BAD_VALUE);
            return false;
        }

        handler->PSendSysMessage(LANG_ARENA_RENAME, arena->GetId(), oldName, newName);

        return true;
    }

    static bool HandleArenaCaptainCommand(ChatHandler* handler, uint32 teamId, Optional<PlayerIdentifier> target)
    {
        ArenaTeam* arena = sArenaTeamMgr->GetArenaTeamById(teamId);
        if (!arena)
        {
            handler->SendErrorMessage(LANG_ARENA_ERROR_NOT_FOUND, teamId);
            return false;
        }

        if (arena->IsFighting())
        {
            handler->SendErrorMessage(LANG_ARENA_ERROR_COMBAT);
            return false;
        }

        if (!target)
            target = PlayerIdentifier::FromTargetOrSelf(handler);

        if (!target)
            return false;

        if (!arena->IsMember(target->GetGUID()))
        {
            handler->SendErrorMessage(LANG_ARENA_ERROR_NOT_MEMBER, target->GetName(), arena->GetName());
            return false;
        }

        if (arena->GetCaptain() == target->GetGUID())
        {
            handler->SendErrorMessage(LANG_ARENA_ERROR_CAPTAIN, target->GetName(), arena->GetName());
            return false;
        }

        std::string oldCaptainName;
        sCharacterCache->GetCharacterNameByGuid(arena->GetCaptain(), oldCaptainName);
        arena->SetCaptain(target->GetGUID());

        handler->PSendSysMessage(LANG_ARENA_CAPTAIN, arena->GetName(), arena->GetId(), oldCaptainName, target->GetName());

        return true;
    }

    static bool HandleArenaInfoCommand(ChatHandler* handler, uint32 teamId)
    {
        ArenaTeam* arena = sArenaTeamMgr->GetArenaTeamById(teamId);
        if (!arena)
        {
            handler->SendErrorMessage(LANG_ARENA_ERROR_NOT_FOUND, teamId);
            return false;
        }

        handler->PSendSysMessage(LANG_ARENA_INFO_HEADER, arena->GetName(), arena->GetId(), arena->GetRating(), arena->GetType(), arena->GetType());

        for (auto const& itr : arena->GetMembers())
            handler->PSendSysMessage(LANG_ARENA_INFO_MEMBERS, itr.Name, itr.Guid.GetCounter(), itr.PersonalRating, (arena->GetCaptain() == itr.Guid ? "Captain" : ""));

        return true;
    }

    static bool HandleArenaLookupCommand(ChatHandler* handler, Tail needle)
    {
        if (needle.empty())
            return false;

        bool found = false;
        for (auto [teamId, team] : sArenaTeamMgr->GetArenaTeams())
        {
            if (StringContainsStringI(team->GetName(), needle))
            {
                handler->PSendSysMessage(LANG_ARENA_LOOKUP, team->GetName(), team->GetId(), team->GetType(), team->GetType());
                found = true;
                continue;
            }
        }

        if (!found)
        {
            handler->SendErrorMessage(LANG_ARENA_ERROR_NAME_NOT_FOUND, std::string(needle));
            return false;
        }

        return true;
    }

    static bool HandleArenaSeasonRewardCommand(ChatHandler* handler, std::string teamsFilterStr)
    {
        std::unique_ptr<ArenaTeamFilter> uniqueFilter = ArenaTeamFilterFactoryByUserInput().CreateFilterByUserInput(teamsFilterStr);
        if (!uniqueFilter)
        {
            handler->PSendSysMessage("Invalid filter. Please check your input.");
            return false;
        }

        std::shared_ptr<ArenaTeamFilter> sharedFilter = std::move(uniqueFilter);

        if (!sArenaSeasonMgr->CanDeleteArenaTeams())
        {
            handler->PSendSysMessage("Cannot proceed. Make sure there are no active arenas and that rewards exist for the current season.");
            handler->PSendSysMessage("Hint: You can disable the arena queue using the following command: .arena season set state 0");
            return false;
        }

        handler->PSendSysMessage("Distributing rewards for arena teams (types: "+teamsFilterStr+")...");
        sArenaSeasonMgr->RewardTeamsForTheSeason(sharedFilter);
        handler->PSendSysMessage("Rewards distributed.");
        return true;
    }

    static bool HandleArenaSeasonDeleteTeamsCommand(ChatHandler* handler)
    {
        handler->PSendSysMessage("Deleting arena teams...");
        sArenaSeasonMgr->DeleteArenaTeams();
        handler->PSendSysMessage("Arena teams deleted.");
        return true;
    }

    static bool HandleArenaSeasonStartCommand(ChatHandler* handler, uint8 seasonId)
    {
        if (seasonId == sArenaSeasonMgr->GetCurrentSeason())
        {
            sArenaSeasonMgr->SetSeasonState(ARENA_SEASON_STATE_IN_PROGRESS);
            handler->PSendSysMessage("Arena season updated.");
            return true;
        }

        const uint8 maxSeasonId = 8;
        if (seasonId > maxSeasonId)
        {
            handler->PSendSysMessage("Invalid season id.");
            return false;
        }

        sArenaSeasonMgr->ChangeCurrentSeason(seasonId);
        handler->PSendSysMessage("Arena season changed to season {}.", seasonId);
        return true;
    }

    static bool HandleArenaSeasonSetStateCommand(ChatHandler* handler, uint8 state)
    {
        ArenaSeasonState seasonState;
        switch (state) {
            case ARENA_SEASON_STATE_DISABLED:
                seasonState = ARENA_SEASON_STATE_DISABLED;
                break;
            case ARENA_SEASON_STATE_IN_PROGRESS:
                seasonState = ARENA_SEASON_STATE_IN_PROGRESS;
                break;
            default:
                handler->PSendSysMessage("Invalid state.");
                return false;
        }

        sArenaSeasonMgr->SetSeasonState(seasonState);
        handler->PSendSysMessage("Arena season updated.");
        return true;
    }

};

void AddSC_arena_commandscript()
{
    new arena_commandscript();
}

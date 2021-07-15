/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

/* ScriptData
Name: arena_commandscript
%Complete: 100
Comment: All arena team related commands
Category: commandscripts
EndScriptData */

#include "ArenaTeamMgr.h"
#include "Chat.h"
#include "Language.h"
#include "ObjectMgr.h"
#include "Player.h"
#include "ScriptMgr.h"

using namespace Acore::ChatCommands;

class arena_commandscript : public CommandScript
{
public:
    arena_commandscript() : CommandScript("arena_commandscript") { }

    ChatCommandTable GetCommands() const override
    {
        static ChatCommandTable arenaCommandTable =
        {
            { "create",         HandleArenaCreateCommand,   SEC_ADMINISTRATOR, Console::Yes },
            { "disband",        HandleArenaDisbandCommand,  SEC_ADMINISTRATOR, Console::Yes },
            { "rename",         HandleArenaRenameCommand,   SEC_ADMINISTRATOR, Console::Yes },
            { "captain",        HandleArenaCaptainCommand,  SEC_ADMINISTRATOR, Console::No  },
            { "info",           HandleArenaInfoCommand,     SEC_GAMEMASTER,    Console::Yes },
            { "lookup",         HandleArenaLookupCommand,   SEC_GAMEMASTER,    Console::No  },
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
            handler->PSendSysMessage(LANG_ARENA_ERROR_NAME_EXISTS, name.c_str());
            handler->SetSentErrorMessage(true);
            return false;
        }

        if (!captain)
            captain = PlayerIdentifier::FromTargetOrSelf(handler);

        if (!captain)
            return false;

        if (Player::GetArenaTeamIdFromDB(captain->GetGUID(), type) != 0)
        {
            handler->PSendSysMessage(LANG_ARENA_ERROR_SIZE, captain->GetName().c_str());
            handler->SetSentErrorMessage(true);
            return false;
        }

        ArenaTeam* arena = new ArenaTeam();

        if (!arena->Create(captain->GetGUID(), type, name, 4293102085, 101, 4293253939, 4, 4284049911))
        {
            delete arena;
            handler->SendSysMessage(LANG_BAD_VALUE);
            handler->SetSentErrorMessage(true);
            return false;
        }

        sArenaTeamMgr->AddArenaTeam(arena);
        handler->PSendSysMessage(LANG_ARENA_CREATE, arena->GetName().c_str(), arena->GetId(), arena->GetType(), arena->GetCaptain().GetCounter());

        return true;
    }

    static bool HandleArenaDisbandCommand(ChatHandler* handler, uint32 teamId)
    {
        ArenaTeam* arena = sArenaTeamMgr->GetArenaTeamById(teamId);

        if (!arena)
        {
            handler->PSendSysMessage(LANG_ARENA_ERROR_NOT_FOUND, teamId);
            handler->SetSentErrorMessage(true);
            return false;
        }

        if (arena->IsFighting())
        {
            handler->SendSysMessage(LANG_ARENA_ERROR_COMBAT);
            handler->SetSentErrorMessage(true);
            return false;
        }

        std::string name = arena->GetName();
        arena->Disband();

        delete(arena);

        handler->PSendSysMessage(LANG_ARENA_DISBAND, name.c_str(), teamId);
        return true;
    }

    static bool HandleArenaRenameCommand(ChatHandler* handler, QuotedString oldName, QuotedString newName)
    {
        ArenaTeam* arena = sArenaTeamMgr->GetArenaTeamByName(oldName);
        if (!arena)
        {
            handler->PSendSysMessage(LANG_AREAN_ERROR_NAME_NOT_FOUND, oldName.c_str());
            handler->SetSentErrorMessage(true);
            return false;
        }

        if (sArenaTeamMgr->GetArenaTeamByName(newName))
        {
            handler->PSendSysMessage(LANG_ARENA_ERROR_NAME_EXISTS, oldName.c_str());
            handler->SetSentErrorMessage(true);
            return false;
        }

        if (arena->IsFighting())
        {
            handler->SendSysMessage(LANG_ARENA_ERROR_COMBAT);
            handler->SetSentErrorMessage(true);
            return false;
        }

        if (!arena->SetName(newName))
        {
            handler->SendSysMessage(LANG_BAD_VALUE);
            handler->SetSentErrorMessage(true);
            return false;
        }

        handler->PSendSysMessage(LANG_ARENA_RENAME, arena->GetId(), oldName.c_str(), newName.c_str());

        return true;
    }

    static bool HandleArenaCaptainCommand(ChatHandler* handler, uint32 teamId, Optional<PlayerIdentifier> target)
    {
        ArenaTeam* arena = sArenaTeamMgr->GetArenaTeamById(teamId);
        if (!arena)
        {
            handler->PSendSysMessage(LANG_ARENA_ERROR_NOT_FOUND, teamId);
            handler->SetSentErrorMessage(true);
            return false;
        }

        if (arena->IsFighting())
        {
            handler->SendSysMessage(LANG_ARENA_ERROR_COMBAT);
            handler->SetSentErrorMessage(true);
            return false;
        }

        if (!target)
            target = PlayerIdentifier::FromTargetOrSelf(handler);

        if (!target)
            return false;

        if (!arena->IsMember(target->GetGUID()))
        {
            handler->PSendSysMessage(LANG_ARENA_ERROR_NOT_MEMBER, target->GetName().c_str(), arena->GetName().c_str());
            handler->SetSentErrorMessage(true);
            return false;
        }

        if (arena->GetCaptain() == target->GetGUID())
        {
            handler->PSendSysMessage(LANG_ARENA_ERROR_CAPTAIN, target->GetName().c_str(), arena->GetName().c_str());
            handler->SetSentErrorMessage(true);
            return false;
        }

        std::string oldCaptainName;
        sObjectMgr->GetPlayerNameByGUID(arena->GetCaptain().GetCounter(), oldCaptainName);
        arena->SetCaptain(target->GetGUID());

        handler->PSendSysMessage(LANG_ARENA_CAPTAIN, arena->GetName().c_str(), arena->GetId(), oldCaptainName.c_str(), target->GetName().c_str());

        return true;
    }

    static bool HandleArenaInfoCommand(ChatHandler* handler, uint32 teamId)
    {
        ArenaTeam* arena = sArenaTeamMgr->GetArenaTeamById(teamId);
        if (!arena)
        {
            handler->PSendSysMessage(LANG_ARENA_ERROR_NOT_FOUND, teamId);
            handler->SetSentErrorMessage(true);
            return false;
        }

        handler->PSendSysMessage(LANG_ARENA_INFO_HEADER, arena->GetName().c_str(), arena->GetId(), arena->GetRating(), arena->GetType(), arena->GetType());

        for (auto const& itr : arena->GetMembers())
            handler->PSendSysMessage(LANG_ARENA_INFO_MEMBERS, itr.Name.c_str(), itr.Guid.GetCounter(), itr.PersonalRating, (arena->GetCaptain() == itr.Guid ? "- Captain" : ""));

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
                if (handler->GetSession())
                {
                    handler->PSendSysMessage(LANG_ARENA_LOOKUP, team->GetName().c_str(), team->GetId(), team->GetType(), team->GetType());
                    found = true;
                    continue;
                }
            }
        }

        if (!found)
            handler->PSendSysMessage(LANG_AREAN_ERROR_NAME_NOT_FOUND, std::string(needle).c_str());

        return true;
    }
};

void AddSC_arena_commandscript()
{
    new arena_commandscript();
}

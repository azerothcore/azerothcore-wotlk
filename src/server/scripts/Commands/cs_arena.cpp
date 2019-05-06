/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

/* ScriptData
Name: arena_commandscript
%Complete: 100
Comment: All arena team related commands
Category: commandscripts
EndScriptData */

#include "ScriptMgr.h"
#include "ArenaTeamMgr.h"
#include "Chat.h"
#include "Language.h"
#include "ObjectMgr.h"
#include "Player.h"

class arena_commandscript : public CommandScript
{
public:
    arena_commandscript() : CommandScript("arena_commandscript") { }

    std::vector<ChatCommand> GetCommands() const override
    {
        static std::vector<ChatCommand> arenaCommandTable =
        {
            { "create",         SEC_ADMINISTRATOR,  true,   &HandleArenaCreateCommand,   "" },
            { "disband",        SEC_ADMINISTRATOR,  true,   &HandleArenaDisbandCommand,  "" },
            { "rename",         SEC_ADMINISTRATOR,  true,   &HandleArenaRenameCommand,   "" },
            { "captain",        SEC_ADMINISTRATOR,  false,  &HandleArenaCaptainCommand,  "" },
            { "info",           SEC_GAMEMASTER,     true,   &HandleArenaInfoCommand,     "" },
            { "lookup",         SEC_GAMEMASTER,     false,  &HandleArenaLookupCommand,   "" },
        };
        static std::vector<ChatCommand> commandTable =
        {
            { "arena",          SEC_GAMEMASTER,     false, nullptr,                       "", arenaCommandTable },
        };
        return commandTable;
    }

    static bool HandleArenaCreateCommand(ChatHandler* handler, char const* args)
    {
        if (!*args)
            return false;

        Player* target;
        if (!handler->extractPlayerTarget(*args != '"' ? (char*)args : nullptr, &target))
            return false;

        char* tailStr = *args != '"' ? strtok(nullptr, "") : (char*)args;
        if (!tailStr)
            return false;

        char* name = handler->extractQuotedArg(tailStr);
        if (!name)
            return false;

        char* typeStr = strtok(nullptr, "");
        if (!typeStr)
            return false;

        int8 type = atoi(typeStr);
        if (sArenaTeamMgr->GetArenaTeamByName(name))
        {
            handler->PSendSysMessage(LANG_ARENA_ERROR_NAME_EXISTS, name);
            handler->SetSentErrorMessage(true);
            return false;
        }

        if (type == 2 || type == 3 || type == 5 )
        {
            if (Player::GetArenaTeamIdFromDB(target->GetGUID(), type) != 0)
            {
                handler->PSendSysMessage(LANG_ARENA_ERROR_SIZE, target->GetName().c_str());
                handler->SetSentErrorMessage(true);
                return false;
            }

            ArenaTeam* arena = new ArenaTeam();

            if (!arena->Create(target->GetGUID(), type, name, 4293102085, 101, 4293253939, 4, 4284049911))
            {
                delete arena;
                handler->SendSysMessage(LANG_BAD_VALUE);
                handler->SetSentErrorMessage(true);
                return false;
            }

            sArenaTeamMgr->AddArenaTeam(arena);
            handler->PSendSysMessage(LANG_ARENA_CREATE, arena->GetName().c_str(), arena->GetId(), arena->GetType(), arena->GetCaptain());
        }
        else
        {
            handler->SendSysMessage(LANG_BAD_VALUE);
            handler->SetSentErrorMessage(true);
            return false;
        }

        return true;
    }

    static bool HandleArenaDisbandCommand(ChatHandler* handler, char const* args)
    {
        if (!*args)
            return false;

        uint32 teamId = atoi((char*)args);
        if (!teamId)
            return false;

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

    static bool HandleArenaRenameCommand(ChatHandler* handler, char const* _args)
    {
        if (!*_args)
            return false;

        char* args = (char *)_args;

        char const* oldArenaStr = handler->extractQuotedArg(args);
        if (!oldArenaStr)
        {
            handler->SendSysMessage(LANG_BAD_VALUE);
            handler->SetSentErrorMessage(true);
            return false;
        }

        char const* newArenaStr = handler->extractQuotedArg(strtok(nullptr, ""));
        if (!newArenaStr)
        {
            handler->SendSysMessage(LANG_BAD_VALUE);
            handler->SetSentErrorMessage(true);
            return false;
        }

        ArenaTeam* arena = sArenaTeamMgr->GetArenaTeamByName(oldArenaStr);
        if (!arena)
        {
            handler->PSendSysMessage(LANG_AREAN_ERROR_NAME_NOT_FOUND, oldArenaStr);
            handler->SetSentErrorMessage(true);
            return false;
        }

        if (sArenaTeamMgr->GetArenaTeamByName(newArenaStr))
        {
            handler->PSendSysMessage(LANG_ARENA_ERROR_NAME_EXISTS, oldArenaStr);
            handler->SetSentErrorMessage(true);
            return false;
        }

        if (arena->IsFighting())
        {
            handler->SendSysMessage(LANG_ARENA_ERROR_COMBAT);
            handler->SetSentErrorMessage(true);
            return false;
        }

        if (!arena->SetName(newArenaStr))
        {
            handler->SendSysMessage(LANG_BAD_VALUE);
            handler->SetSentErrorMessage(true);
            return false;
        }

        handler->PSendSysMessage(LANG_ARENA_RENAME, arena->GetId(), oldArenaStr, newArenaStr);

        return true;
    }

    static bool HandleArenaCaptainCommand(ChatHandler* handler, char const* args)
    {
        if (!*args)
            return false;

        char* idStr;
        char* nameStr;
        handler->extractOptFirstArg((char*)args, &idStr, &nameStr);
        if (!idStr)
            return false;

        uint32 teamId = atoi(idStr);
        if (!teamId)
            return false;

        Player* target;
        uint64 targetGuid;
        if (!handler->extractPlayerTarget(nameStr, &target, &targetGuid))
            return false;

        ArenaTeam* arena = sArenaTeamMgr->GetArenaTeamById(teamId);

        if (!arena)
        {
            handler->PSendSysMessage(LANG_ARENA_ERROR_NOT_FOUND, teamId);
            handler->SetSentErrorMessage(true);
            return false;
        }

        if (!target)
        {
            handler->PSendSysMessage(LANG_PLAYER_NOT_EXIST_OR_OFFLINE, nameStr);
            handler->SetSentErrorMessage(true);
            return false;
        }

        if (arena->IsFighting())
        {
            handler->SendSysMessage(LANG_ARENA_ERROR_COMBAT);
            handler->SetSentErrorMessage(true);
            return false;
        }

        if (!arena->IsMember(targetGuid))
        {
            handler->PSendSysMessage(LANG_ARENA_ERROR_NOT_MEMBER, nameStr, arena->GetName().c_str());
            handler->SetSentErrorMessage(true);
            return false;
        }

        if (arena->GetCaptain() == targetGuid)
        {
            handler->PSendSysMessage(LANG_ARENA_ERROR_CAPTAIN, nameStr, arena->GetName().c_str());
            handler->SetSentErrorMessage(true);
            return false;
        }

        std::string oldCaptainName;
        sObjectMgr->GetPlayerNameByGUID(arena->GetCaptain(), oldCaptainName);
        arena->SetCaptain(targetGuid);

        handler->PSendSysMessage(LANG_ARENA_CAPTAIN, arena->GetName().c_str(), arena->GetId(), oldCaptainName.c_str(), target->GetName().c_str());

        return true;
    }

    static bool HandleArenaInfoCommand(ChatHandler* handler, char const* args)
    {
        if (!*args)
            return false;

        uint32 teamId = atoi((char*)args);
        if (!teamId)
            return false;

        ArenaTeam* arena = sArenaTeamMgr->GetArenaTeamById(teamId);

        if (!arena)
        {
            handler->PSendSysMessage(LANG_ARENA_ERROR_NOT_FOUND, teamId);
            handler->SetSentErrorMessage(true);
            return false;
        }

        handler->PSendSysMessage(LANG_ARENA_INFO_HEADER, arena->GetName().c_str(), arena->GetId(), arena->GetRating(), arena->GetType(), arena->GetType());
        for (ArenaTeam::MemberList::iterator itr = arena->m_membersBegin(); itr != arena->m_membersEnd(); ++itr)
            handler->PSendSysMessage(LANG_ARENA_INFO_MEMBERS, itr->Name.c_str(), GUID_LOPART(itr->Guid), itr->PersonalRating, (arena->GetCaptain() == itr->Guid ? "- Captain" : ""));

        return true;
    }

    static bool HandleArenaLookupCommand(ChatHandler* handler, char const* args)
    {
        if (!*args)
            return false;

        std::string namepart = args;
        std::wstring wnamepart;

        if (!Utf8toWStr(namepart, wnamepart))
            return false;

        wstrToLower(wnamepart);

        bool found = false;
        ArenaTeamMgr::ArenaTeamContainer::const_iterator i = sArenaTeamMgr->GetArenaTeamMapBegin();
        for (; i != sArenaTeamMgr->GetArenaTeamMapEnd(); ++i)
        {
            ArenaTeam* arena = i->second;

            if (Utf8FitTo(arena->GetName(), wnamepart))
            {
                if (handler->GetSession())
                {
                    handler->PSendSysMessage(LANG_ARENA_LOOKUP, arena->GetName().c_str(), arena->GetId(), arena->GetType(), arena->GetType());
                    found = true;
                    continue;
                }
             }
        }

        if (!found)
            handler->PSendSysMessage(LANG_AREAN_ERROR_NAME_NOT_FOUND, namepart.c_str());

        return true;
    }
};

void AddSC_arena_commandscript()
{
    new arena_commandscript();
}

/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

/* ScriptData
Name: honor_commandscript
%Complete: 100
Comment: All honor related commands
Category: commandscripts
EndScriptData */

#include "Chat.h"
#include "Language.h"
#include "ObjectMgr.h"
#include "Player.h"
#include "ScriptMgr.h"

class honor_commandscript : public CommandScript
{
public:
    honor_commandscript() : CommandScript("honor_commandscript") { }

    std::vector<ChatCommand> GetCommands() const override
    {
        static std::vector<ChatCommand> honorAddCommandTable =
        {
            { "kill",           SEC_GAMEMASTER,     false, &HandleHonorAddKillCommand,         "" },
            { "",               SEC_GAMEMASTER,     false, &HandleHonorAddCommand,             "" }
        };

        static std::vector<ChatCommand> honorCommandTable =
        {
            { "add",            SEC_GAMEMASTER,     false, nullptr,                            "", honorAddCommandTable },
            { "update",         SEC_GAMEMASTER,     false, &HandleHonorUpdateCommand,          "" }
        };

        static std::vector<ChatCommand> commandTable =
        {
            { "honor",          SEC_GAMEMASTER,     false, nullptr,                            "", honorCommandTable }
        };
        return commandTable;
    }

    static bool HandleHonorAddCommand(ChatHandler* handler, char const* args)
    {
        if (!*args)
            return false;

        Player* target = handler->getSelectedPlayer();
        if (!target)
        {
            handler->SendSysMessage(LANG_PLAYER_NOT_FOUND);
            handler->SetSentErrorMessage(true);
            return false;
        }

        // check online security
        if (handler->HasLowerSecurity(target, 0))
            return false;

        uint32 amount = (uint32)atoi(args);
        target->RewardHonor(nullptr, 1, amount);
        return true;
    }

    static bool HandleHonorAddKillCommand(ChatHandler* handler, char const* /*args*/)
    {
        Unit* target = handler->getSelectedUnit();
        if (!target)
        {
            handler->SendSysMessage(LANG_PLAYER_NOT_FOUND);
            handler->SetSentErrorMessage(true);
            return false;
        }

        // check online security
        if (target->GetTypeId() == TYPEID_PLAYER && handler->HasLowerSecurity(target->ToPlayer(), 0))
            return false;

        handler->GetSession()->GetPlayer()->RewardHonor(target, 1);
        return true;
    }

    static bool HandleHonorUpdateCommand(ChatHandler* handler, char const* /*args*/)
    {
        Player* target = handler->getSelectedPlayer();
        if (!target)
        {
            handler->SendSysMessage(LANG_PLAYER_NOT_FOUND);
            handler->SetSentErrorMessage(true);
            return false;
        }

        // check online security
        if (handler->HasLowerSecurity(target, 0))
            return false;

        target->UpdateHonorFields();
        return true;
    }
};

void AddSC_honor_commandscript()
{
    new honor_commandscript();
}

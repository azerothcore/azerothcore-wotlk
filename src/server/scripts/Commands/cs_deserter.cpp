/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include "Chat.h"
#include "Player.h"
#include "Language.h"
#include "ScriptMgr.h"
#include "SpellAuras.h"
#include "SpellAuraEffects.h"

 enum Spells
{
    LFG_SPELL_DUNGEON_DESERTER = 71041,
    BG_SPELL_DESERTER = 26013
};

class deserter_commandscript : public CommandScript
{
public:
    deserter_commandscript() : CommandScript("deserter_commandscript") { }

    std::vector<ChatCommand> GetCommands() const override
    {
        static std::vector<ChatCommand> deserterinstanceCommandTable =
        {
            { "add",            SEC_ADMINISTRATOR, false, &HandleDeserterInstanceAdd,          "" },
            { "remove",         SEC_ADMINISTRATOR, false, &HandleDeserterInstanceRemove,       "" }
        };

        static std::vector<ChatCommand> deserterBGCommandTable =
        {
            { "add",            SEC_ADMINISTRATOR, false, &HandleDeserterBGAdd,                "" },
            { "remove",         SEC_ADMINISTRATOR, false, &HandleDeserterBGRemove,             "" }
        };

        static std::vector<ChatCommand> deserterCommandTable =
        {
            { "instance",       SEC_ADMINISTRATOR,  false, nullptr,  "", deserterinstanceCommandTable },
            { "bg",             SEC_ADMINISTRATOR,  false, nullptr,  "", deserterBGCommandTable }
        };

        static std::vector<ChatCommand> commandTable =
        {
            { "deserter",       SEC_ADMINISTRATOR,  false, nullptr,               "", deserterCommandTable }
        };

        return commandTable;
    }

    static bool HandleDeserterAdd(ChatHandler* handler, char const* args, bool isInstance)
    {
        if (!*args)
            return false;

         Player* targetPlayer = handler->getSelectedPlayer();
        if (!targetPlayer)
        {
            handler->SendSysMessage(LANG_NO_CHAR_SELECTED);
            handler->SetSentErrorMessage(true);
            return false;
        }
        char* timeStr = strtok((char*)args, " ");
        if (!timeStr)
        {
            handler->SendSysMessage(LANG_BAD_VALUE);
            handler->SetSentErrorMessage(true);
            return false;
        }
        uint32 time = atoi(timeStr);

         if (!time)
         {
            handler->SendSysMessage(LANG_BAD_VALUE);
            handler->SetSentErrorMessage(true);
            return false;
         }

         Aura* aura = targetPlayer->AddAura(isInstance ? LFG_SPELL_DUNGEON_DESERTER : BG_SPELL_DESERTER, targetPlayer);

         if (!aura)
         {
            handler->SendSysMessage(LANG_BAD_VALUE);
            handler->SetSentErrorMessage(true);
            return false;
         }
        aura->SetDuration(time * IN_MILLISECONDS);

         return true;
    }

    static bool HandleDeserterRemove(ChatHandler* handler, char const* /*args*/, bool isInstance)
    {
        Player* targetPlayer = handler->getSelectedPlayer();
        if (!targetPlayer)
        {
            handler->SendSysMessage(LANG_NO_CHAR_SELECTED);
            handler->SetSentErrorMessage(true);
            return false;
        }

         targetPlayer->RemoveAura(isInstance ? LFG_SPELL_DUNGEON_DESERTER : BG_SPELL_DESERTER);

         return true;
    }

    static bool HandleDeserterInstanceAdd(ChatHandler* handler, char const* args)
    {
        return HandleDeserterAdd(handler, args, true);
    }

    static bool HandleDeserterBGAdd(ChatHandler* handler, char const* args)
    {
        return HandleDeserterAdd(handler, args, false);
    }

    static bool HandleDeserterInstanceRemove(ChatHandler* handler, char const* args)
    {
        return HandleDeserterRemove(handler, args, true);
    }

    static bool HandleDeserterBGRemove(ChatHandler* handler, char const* args)
    {
        return HandleDeserterRemove(handler, args, false);
    }
};

 void AddSC_deserter_commandscript()
{
    new deserter_commandscript();
}

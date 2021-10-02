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

#include "Chat.h"
#include "Language.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "SpellAuraEffects.h"
#include "SpellAuras.h"

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

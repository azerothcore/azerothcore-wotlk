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

#include "BattlefieldMgr.h"
#include "Chat.h"
#include "CommandScript.h"
#include "Language.h"

using namespace Acore::ChatCommands;

class bf_commandscript : public CommandScript
{
public:
    bf_commandscript() : CommandScript("bf_commandscript") { }

    ChatCommandTable GetCommands() const override
    {
        static ChatCommandTable battlefieldcommandTable =
        {
            { "start",  HandleBattlefieldStart,  SEC_ADMINISTRATOR, Console::Yes },
            { "stop",   HandleBattlefieldEnd,    SEC_ADMINISTRATOR, Console::Yes },
            { "switch", HandleBattlefieldSwitch, SEC_ADMINISTRATOR, Console::Yes },
            { "timer",  HandleBattlefieldTimer,  SEC_ADMINISTRATOR, Console::Yes },
            { "enable", HandleBattlefieldEnable, SEC_ADMINISTRATOR, Console::Yes }
        };
        static ChatCommandTable commandTable =
        {
            { "bf", battlefieldcommandTable }
        };
        return commandTable;
    }

    static bool HandleBattlefieldStart(ChatHandler* handler, uint32 battleId)
    {
        Battlefield* bf = sBattlefieldMgr->GetBattlefieldByBattleId(battleId);

        if (!bf)
        {
            handler->SendErrorMessage(LANG_BF_NOT_FOUND, battleId);
            return false;
        }

        bf->StartBattle();
        handler->SendWorldText(LANG_BF_STARTED, battleId);
        if (handler->IsConsole())
            handler->PSendSysMessage(LANG_BF_STARTED, battleId);

        return true;
    }

    static bool HandleBattlefieldEnd(ChatHandler* handler, uint32 battleId)
    {
        Battlefield* bf = sBattlefieldMgr->GetBattlefieldByBattleId(battleId);

        if (!bf)
        {
            handler->SendErrorMessage(LANG_BF_NOT_FOUND, battleId);
            return false;
        }

        bf->EndBattle(true);
        handler->SendWorldText(LANG_BF_STOPPED, battleId);
        if (handler->IsConsole())
            handler->PSendSysMessage(LANG_BF_STOPPED, battleId);

        return true;
    }

    static bool HandleBattlefieldEnable(ChatHandler* handler, uint32 battleId)
    {
        Battlefield* bf = sBattlefieldMgr->GetBattlefieldByBattleId(battleId);

        if (!bf)
        {
            handler->SendErrorMessage(LANG_BF_NOT_FOUND, battleId);
            return false;
        }

        if (bf->IsEnabled())
        {
            bf->ToggleBattlefield(false);
            handler->SendWorldText(LANG_BF_DISABLED, battleId);
            if (handler->IsConsole())
                handler->PSendSysMessage(LANG_BF_DISABLED, battleId);
        }
        else
        {
            bf->ToggleBattlefield(true);
            handler->SendWorldText(LANG_BF_ENABLED, battleId);
            if (handler->IsConsole())
                handler->PSendSysMessage(LANG_BF_ENABLED, battleId);
        }

        return true;
    }

    static bool HandleBattlefieldSwitch(ChatHandler* handler, uint32 battleId)
    {
        Battlefield* bf = sBattlefieldMgr->GetBattlefieldByBattleId(battleId);

        if (!bf)
        {
            handler->SendErrorMessage(LANG_BF_NOT_FOUND, battleId);
            return false;
        }

        bf->EndBattle(false);
        handler->SendWorldText(LANG_BF_SWITCHED, battleId);
        if (handler->IsConsole())
            handler->PSendSysMessage(LANG_BF_SWITCHED, battleId);

        return true;
    }

    static bool HandleBattlefieldTimer(ChatHandler* handler, uint32 battleId, std::string timeStr)
    {
        if (timeStr.empty())
        {
            return false;
        }

        if (Acore::StringTo<int32>(timeStr).value_or(0) < 0)
        {
            handler->SendErrorMessage(LANG_BAD_VALUE);
            return false;
        }

        int32 time = TimeStringToSecs(timeStr);
        if (time <= 0)
        {
            time = Acore::StringTo<int32>(timeStr).value_or(0);
        }

        if (time <= 0)
        {
            handler->SendErrorMessage(LANG_BAD_VALUE);
            return false;
        }

        Battlefield* bf = sBattlefieldMgr->GetBattlefieldByBattleId(battleId);

        if (!bf)
        {
            handler->SendErrorMessage(LANG_BF_NOT_FOUND, battleId);
            return false;
        }

        bf->SetTimer(time * IN_MILLISECONDS);
        bf->SendInitWorldStatesToAll();
        handler->SendWorldText(LANG_BF_TIMER_SET, battleId, time);
        if (handler->IsConsole())
            handler->PSendSysMessage(LANG_BF_TIMER_SET, battleId, time);

        return true;
    }
};

void AddSC_bf_commandscript()
{
    new bf_commandscript();
}

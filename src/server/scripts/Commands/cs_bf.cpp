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
#include "GameTime.h"
#include "Language.h"
#include "ObjectAccessor.h"
#include "Player.h"
#include "RBAC.h"

using namespace Acore::ChatCommands;

class bf_commandscript : public CommandScript
{
public:
    bf_commandscript() : CommandScript("bf_commandscript") { }

    ChatCommandTable GetCommands() const override
    {
        static ChatCommandTable battlefieldcommandTable =
        {
            { "start",  HandleBattlefieldStart,  rbac::RBAC_PERM_COMMAND_BF_START,  Console::Yes },
            { "stop",   HandleBattlefieldEnd,    rbac::RBAC_PERM_COMMAND_BF_STOP,   Console::Yes },
            { "switch", HandleBattlefieldSwitch, rbac::RBAC_PERM_COMMAND_BF_SWITCH, Console::Yes },
            { "timer",  HandleBattlefieldTimer,  rbac::RBAC_PERM_COMMAND_BF_TIMER,  Console::Yes },
            { "enable", HandleBattlefieldEnable, rbac::RBAC_PERM_COMMAND_BF_ENABLE, Console::Yes },
            { "queue",  HandleBattlefieldQueue,  rbac::RBAC_PERM_COMMAND_BF_QUEUE,  Console::Yes }
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

    static bool HandleBattlefieldQueue(ChatHandler* handler, uint32 battleId)
    {
        Battlefield* bf = sBattlefieldMgr->GetBattlefieldByBattleId(battleId);

        if (!bf)
        {
            handler->SendErrorMessage(LANG_BF_NOT_FOUND, battleId);
            return false;
        }

        handler->PSendSysMessage(bf->IsWarTime() ? LANG_BF_QUEUE_HDR_WAR : LANG_BF_QUEUE_HDR_WAIT,
            battleId, bf->GetTimer() / IN_MILLISECONDS);

        static char const* teamNames[PVP_TEAMS_COUNT] = { "Alliance", "Horde" };

        std::string offlineSuffix = handler->GetAcoreString(LANG_OFFLINE);

        auto nameOf = [offlineSuffix](ObjectGuid guid) -> std::string
        {
            if (Player* p = ObjectAccessor::FindPlayer(guid))
                return p->GetName();
            return std::to_string(guid.GetCounter()) + offlineSuffix;
        };

        for (uint8 i = 0; i < PVP_TEAMS_COUNT; ++i)
        {
            TeamId team = TeamId(i);

            GuidUnorderedSet const& inQueue = bf->GetPlayersQueueSet(team);
            PlayerTimerMap   const& invited = bf->GetInvitedPlayersMap(team);
            GuidUnorderedSet const& inWar   = bf->GetPlayersInWarSet(team);

            handler->PSendSysMessage(LANG_BF_QUEUE_TEAM_HDR,
                teamNames[i],
                static_cast<uint32>(inQueue.size()),
                static_cast<uint32>(invited.size()),
                static_cast<uint32>(inWar.size()));

            for (ObjectGuid const& guid : inQueue)
                handler->PSendSysMessage(LANG_BF_QUEUE_PLAYER_QUEUE, nameOf(guid));

            SystemTimePoint now = GameTime::GetSystemTime();
            for (auto const& [guid, expiry] : invited)
            {
                SystemTimePoint expiryPoint = std::chrono::system_clock::from_time_t(expiry);
                int32 secsLeft = std::max(int32(0), static_cast<int32>(
                    std::chrono::duration_cast<Seconds>(expiryPoint - now).count()));
                handler->PSendSysMessage(LANG_BF_QUEUE_PLAYER_INVITED, nameOf(guid), secsLeft);
            }

            for (ObjectGuid const& guid : inWar)
                handler->PSendSysMessage(LANG_BF_QUEUE_PLAYER_WAR, nameOf(guid));
        }

        return true;
    }
};

void AddSC_bf_commandscript()
{
    new bf_commandscript();
}

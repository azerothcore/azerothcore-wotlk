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

#include "ScriptMgr.h"
#include "ScriptMgrMacros.h"

bool ScriptMgr::OnPlayerbotCheckLFGQueue(lfg::Lfg5Guids const& guidsList)
{
    auto ret = IsValidBoolScript<PlayerbotScript>([&](PlayerbotScript* script)
    {
        return !script->OnPlayerbotCheckLFGQueue(guidsList);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

void ScriptMgr::OnPlayerbotCheckKillTask(Player* player, Unit* victim)
{
    ExecuteScript<PlayerbotScript>([&](PlayerbotScript* script)
    {
        script->OnPlayerbotCheckKillTask(player, victim);
    });
}

void ScriptMgr::OnPlayerbotCheckPetitionAccount(Player* player, bool& found)
{
    ExecuteScript<PlayerbotScript>([&](PlayerbotScript* script)
    {
        script->OnPlayerbotCheckPetitionAccount(player, found);
    });
}

bool ScriptMgr::OnPlayerbotCheckUpdatesToSend(Player* player)
{
    auto ret = IsValidBoolScript<PlayerbotScript>([&](PlayerbotScript* script)
    {
        return !script->OnPlayerbotCheckUpdatesToSend(player);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

void ScriptMgr::OnPlayerbotPacketSent(Player* player, WorldPacket const* packet)
{
    ExecuteScript<PlayerbotScript>([&](PlayerbotScript* script)
    {
        script->OnPlayerbotPacketSent(player, packet);
    });
}

void ScriptMgr::OnPlayerbotUpdate(uint32 diff)
{
    ExecuteScript<PlayerbotScript>([&](PlayerbotScript* script)
    {
        script->OnPlayerbotUpdate(diff);
    });
}

void ScriptMgr::OnPlayerbotUpdateSessions(Player* player)
{
    ExecuteScript<PlayerbotScript>([&](PlayerbotScript* script)
    {
        script->OnPlayerbotUpdateSessions(player);
    });
}

void ScriptMgr::OnPlayerbotLogout(Player* player)
{
    ExecuteScript<PlayerbotScript>([&](PlayerbotScript* script)
    {
        script->OnPlayerbotLogout(player);
    });
}

void ScriptMgr::OnPlayerbotLogoutBots()
{
    ExecuteScript<PlayerbotScript>([&](PlayerbotScript* script)
    {
        script->OnPlayerbotLogoutBots();
    });
}

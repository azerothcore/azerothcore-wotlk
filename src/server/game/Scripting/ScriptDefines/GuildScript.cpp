/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the
 * Free Software Foundation; either version 2 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "ScriptMgr.h"
#include "ScriptMgrMacros.h"

void ScriptMgr::OnGuildAddMember(Guild* guild, Player* player, uint8& plRank)
{
    ExecuteScript<GuildScript>([&](GuildScript* script)
    {
        script->OnAddMember(guild, player, plRank);
    });
}

void ScriptMgr::OnGuildRemoveMember(Guild* guild, Player* player, bool isDisbanding, bool isKicked)
{
    ExecuteScript<GuildScript>([&](GuildScript* script)
    {
        script->OnRemoveMember(guild, player, isDisbanding, isKicked);
    });
}

void ScriptMgr::OnGuildMOTDChanged(Guild* guild, const std::string& newMotd)
{
    ExecuteScript<GuildScript>([&](GuildScript* script)
    {
        script->OnMOTDChanged(guild, newMotd);
    });
}

void ScriptMgr::OnGuildInfoChanged(Guild* guild, const std::string& newInfo)
{
    ExecuteScript<GuildScript>([&](GuildScript* script)
    {
        script->OnInfoChanged(guild, newInfo);
    });
}

void ScriptMgr::OnGuildCreate(Guild* guild, Player* leader, const std::string& name)
{
    ExecuteScript<GuildScript>([&](GuildScript* script)
    {
        script->OnCreate(guild, leader, name);
    });
}

void ScriptMgr::OnGuildDisband(Guild* guild)
{
    ExecuteScript<GuildScript>([&](GuildScript* script)
    {
        script->OnDisband(guild);
    });
}

void ScriptMgr::OnGuildMemberWitdrawMoney(Guild* guild, Player* player, uint32& amount, bool isRepair)
{
    ExecuteScript<GuildScript>([&](GuildScript* script)
    {
        script->OnMemberWitdrawMoney(guild, player, amount, isRepair);
    });
}

void ScriptMgr::OnGuildMemberDepositMoney(Guild* guild, Player* player, uint32& amount)
{
    ExecuteScript<GuildScript>([&](GuildScript* script)
    {
        script->OnMemberDepositMoney(guild, player, amount);
    });
}

void ScriptMgr::OnGuildItemMove(Guild* guild, Player* player, Item* pItem, bool isSrcBank, uint8 srcContainer, uint8 srcSlotId,
                                bool isDestBank, uint8 destContainer, uint8 destSlotId)
{
    ExecuteScript<GuildScript>([&](GuildScript* script)
    {
        script->OnItemMove(guild, player, pItem, isSrcBank, srcContainer, srcSlotId, isDestBank, destContainer, destSlotId);
    });
}

void ScriptMgr::OnGuildEvent(Guild* guild, uint8 eventType, ObjectGuid::LowType playerGuid1, ObjectGuid::LowType playerGuid2, uint8 newRank)
{
    ExecuteScript<GuildScript>([&](GuildScript* script)
    {
        script->OnEvent(guild, eventType, playerGuid1, playerGuid2, newRank);
    });
}

void ScriptMgr::OnGuildBankEvent(Guild* guild, uint8 eventType, uint8 tabId, ObjectGuid::LowType playerGuid, uint32 itemOrMoney, uint16 itemStackCount, uint8 destTabId)
{
    ExecuteScript<GuildScript>([&](GuildScript* script)
    {
        script->OnBankEvent(guild, eventType, tabId, playerGuid, itemOrMoney, itemStackCount, destTabId);
    });
}

bool ScriptMgr::CanGuildSendBankList(Guild const* guild, WorldSession* session, uint8 tabId, bool sendAllSlots)
{
    auto ret = IsValidBoolScript<GuildScript>([&](GuildScript* script)
    {
        return !script->CanGuildSendBankList(guild, session, tabId, sendAllSlots);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

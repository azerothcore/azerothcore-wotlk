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

#include "GuildScript.h"
#include "ScriptMgr.h"
#include "ScriptMgrMacros.h"

void ScriptMgr::OnGuildAddMember(Guild* guild, Player* player, uint8& plRank)
{
    CALL_ENABLED_HOOKS(GuildScript, GUILDHOOK_ON_ADD_MEMBER, script->OnAddMember(guild, player, plRank));
}

void ScriptMgr::OnGuildRemoveMember(Guild* guild, Player* player, bool isDisbanding, bool isKicked)
{
    CALL_ENABLED_HOOKS(GuildScript, GUILDHOOK_ON_REMOVE_MEMBER, script->OnRemoveMember(guild, player, isDisbanding, isKicked));
}

void ScriptMgr::OnGuildMOTDChanged(Guild* guild, const std::string& newMotd)
{
    CALL_ENABLED_HOOKS(GuildScript, GUILDHOOK_ON_MOTD_CHANGED, script->OnMOTDChanged(guild, newMotd));
}

void ScriptMgr::OnGuildInfoChanged(Guild* guild, const std::string& newInfo)
{
    CALL_ENABLED_HOOKS(GuildScript, GUILDHOOK_ON_INFO_CHANGED, script->OnInfoChanged(guild, newInfo));
}

void ScriptMgr::OnGuildCreate(Guild* guild, Player* leader, const std::string& name)
{
    CALL_ENABLED_HOOKS(GuildScript, GUILDHOOK_ON_CREATE, script->OnCreate(guild, leader, name));
}

void ScriptMgr::OnGuildDisband(Guild* guild)
{
    CALL_ENABLED_HOOKS(GuildScript, GUILDHOOK_ON_DISBAND, script->OnDisband(guild));
}

void ScriptMgr::OnGuildMemberWitdrawMoney(Guild* guild, Player* player, uint32& amount, bool isRepair)
{
    CALL_ENABLED_HOOKS(GuildScript, GUILDHOOK_ON_MEMBER_WITDRAW_MONEY, script->OnMemberWitdrawMoney(guild, player, amount, isRepair));
}

void ScriptMgr::OnGuildMemberDepositMoney(Guild* guild, Player* player, uint32& amount)
{
    CALL_ENABLED_HOOKS(GuildScript, GUILDHOOK_ON_MEMBER_DEPOSIT_MONEY, script->OnMemberDepositMoney(guild, player, amount));
}

void ScriptMgr::OnGuildItemMove(Guild* guild, Player* player, Item* pItem, bool isSrcBank, uint8 srcContainer, uint8 srcSlotId, bool isDestBank, uint8 destContainer, uint8 destSlotId)
{
    CALL_ENABLED_HOOKS(GuildScript, GUILDHOOK_ON_ITEM_MOVE, script->OnItemMove(guild, player, pItem, isSrcBank, srcContainer, srcSlotId, isDestBank, destContainer, destSlotId));
}

void ScriptMgr::OnGuildEvent(Guild* guild, uint8 eventType, ObjectGuid::LowType playerGuid1, ObjectGuid::LowType playerGuid2, uint8 newRank)
{
    CALL_ENABLED_HOOKS(GuildScript, GUILDHOOK_ON_EVENT, script->OnEvent(guild, eventType, playerGuid1, playerGuid2, newRank));
}

void ScriptMgr::OnGuildBankEvent(Guild* guild, uint8 eventType, uint8 tabId, ObjectGuid::LowType playerGuid, uint32 itemOrMoney, uint16 itemStackCount, uint8 destTabId)
{
    CALL_ENABLED_HOOKS(GuildScript, GUILDHOOK_ON_BANK_EVENT, script->OnBankEvent(guild, eventType, tabId, playerGuid, itemOrMoney, itemStackCount, destTabId));
}

bool ScriptMgr::CanGuildSendBankList(Guild const* guild, WorldSession* session, uint8 tabId, bool sendAllSlots)
{
    CALL_ENABLED_BOOLEAN_HOOKS(GuildScript, GUILDHOOK_CAN_GUILD_SEND_BANK_LIST, !script->CanGuildSendBankList(guild, session, tabId, sendAllSlots));
}

GuildScript::GuildScript(const char* name, std::vector<uint16> enabledHooks)
    : ScriptObject(name, GUILDHOOK_END)
{
    // If empty - enable all available hooks.
    if (enabledHooks.empty())
        for (uint16 i = 0; i < GUILDHOOK_END; ++i)
            enabledHooks.emplace_back(i);

    ScriptRegistry<GuildScript>::AddScript(this, std::move(enabledHooks));
}

template class AC_GAME_API ScriptRegistry<GuildScript>;

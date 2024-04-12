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

#ifndef SCRIPT_OBJECT_GUILD_SCRIPT_H_
#define SCRIPT_OBJECT_GUILD_SCRIPT_H_

#include "ObjectGuid.h"
#include "ScriptObject.h"
#include <vector>

enum GuildHook
{
    GUILDHOOK_ON_ADD_MEMBER,
    GUILDHOOK_ON_REMOVE_MEMBER,
    GUILDHOOK_ON_MOTD_CHANGED,
    GUILDHOOK_ON_INFO_CHANGED,
    GUILDHOOK_ON_CREATE,
    GUILDHOOK_ON_DISBAND,
    GUILDHOOK_ON_MEMBER_WITDRAW_MONEY,
    GUILDHOOK_ON_MEMBER_DEPOSIT_MONEY,
    GUILDHOOK_ON_ITEM_MOVE,
    GUILDHOOK_ON_EVENT,
    GUILDHOOK_ON_BANK_EVENT,
    GUILDHOOK_CAN_GUILD_SEND_BANK_LIST,
    GUILDHOOK_END
};

class GuildScript : public ScriptObject
{
protected:
    GuildScript(const char* name, std::vector<uint16> enabledHooks = std::vector<uint16>());

public:
    [[nodiscard]] bool IsDatabaseBound() const override { return false; }

    // Called when a member is added to the guild.
    virtual void OnAddMember(Guild* /*guild*/, Player* /*player*/, uint8& /*plRank*/) { }

    // Called when a member is removed from the guild.
    virtual void OnRemoveMember(Guild* /*guild*/, Player* /*player*/, bool /*isDisbanding*/, bool /*isKicked*/) { }

    // Called when the guild MOTD (message of the day) changes.
    virtual void OnMOTDChanged(Guild* /*guild*/, const std::string& /*newMotd*/) { }

    // Called when the guild info is altered.
    virtual void OnInfoChanged(Guild* /*guild*/, const std::string& /*newInfo*/) { }

    // Called when a guild is created.
    virtual void OnCreate(Guild* /*guild*/, Player* /*leader*/, const std::string& /*name*/) { }

    // Called when a guild is disbanded.
    virtual void OnDisband(Guild* /*guild*/) { }

    // Called when a guild member withdraws money from a guild bank.
    virtual void OnMemberWitdrawMoney(Guild* /*guild*/, Player* /*player*/, uint32& /*amount*/, bool /*isRepair*/) { }

    // Called when a guild member deposits money in a guild bank.
    virtual void OnMemberDepositMoney(Guild* /*guild*/, Player* /*player*/, uint32& /*amount*/) { }

    // Called when a guild member moves an item in a guild bank.
    virtual void OnItemMove(Guild* /*guild*/, Player* /*player*/, Item* /*pItem*/, bool /*isSrcBank*/, uint8 /*srcContainer*/, uint8 /*srcSlotId*/, bool /*isDestBank*/, uint8 /*destContainer*/, uint8 /*destSlotId*/) { }

    virtual void OnEvent(Guild* /*guild*/, uint8 /*eventType*/, ObjectGuid::LowType /*playerGuid1*/, ObjectGuid::LowType /*playerGuid2*/, uint8 /*newRank*/) { }

    virtual void OnBankEvent(Guild* /*guild*/, uint8 /*eventType*/, uint8 /*tabId*/, ObjectGuid::LowType /*playerGuid*/, uint32 /*itemOrMoney*/, uint16 /*itemStackCount*/, uint8 /*destTabId*/) { }

    [[nodiscard]] virtual bool CanGuildSendBankList(Guild const* /*guild*/, WorldSession* /*session*/, uint8 /*tabId*/, bool /*sendAllSlots*/) { return true; }
};

#endif

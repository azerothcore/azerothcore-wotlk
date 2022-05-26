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

void ScriptMgr::OnItemCreate(Item* item, ItemTemplate const* itemProto, Player const* owner)
{
    ExecuteScript<MiscScript>([&](MiscScript* script)
    {
        script->OnItemCreate(item, itemProto, owner);
    });
}

bool ScriptMgr::CanApplySoulboundFlag(Item* item, ItemTemplate const* proto)
{
    auto ret = IsValidBoolScript<MiscScript>([&](MiscScript* script)
    {
        return !script->CanApplySoulboundFlag(item, proto);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

void ScriptMgr::OnConstructObject(Object* origin)
{
    ExecuteScript<MiscScript>([&](MiscScript* script)
    {
        script->OnConstructObject(origin);
    });
}

void ScriptMgr::OnDestructObject(Object* origin)
{
    ExecuteScript<MiscScript>([&](MiscScript* script)
    {
        script->OnDestructObject(origin);
    });
}

void ScriptMgr::OnConstructPlayer(Player* origin)
{
    ExecuteScript<MiscScript>([&](MiscScript* script)
    {
        script->OnConstructPlayer(origin);
    });
}

void ScriptMgr::OnDestructPlayer(Player* origin)
{
    ExecuteScript<MiscScript>([&](MiscScript* script)
    {
        script->OnDestructPlayer(origin);
    });
}

void ScriptMgr::OnConstructGroup(Group* origin)
{
    ExecuteScript<MiscScript>([&](MiscScript* script)
    {
        script->OnConstructGroup(origin);
    });
}

void ScriptMgr::OnDestructGroup(Group* origin)
{
    ExecuteScript<MiscScript>([&](MiscScript* script)
    {
        script->OnDestructGroup(origin);
    });
}

void ScriptMgr::OnConstructInstanceSave(InstanceSave* origin)
{
    ExecuteScript<MiscScript>([&](MiscScript* script)
    {
        script->OnConstructInstanceSave(origin);
    });
}

void ScriptMgr::OnDestructInstanceSave(InstanceSave* origin)
{
    ExecuteScript<MiscScript>([&](MiscScript* script)
    {
        script->OnDestructInstanceSave(origin);
    });
}

bool ScriptMgr::CanItemApplyEquipSpell(Player* player, Item* item)
{
    auto ret = IsValidBoolScript<MiscScript>([&](MiscScript* script)
    {
        return !script->CanItemApplyEquipSpell(player, item);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

bool ScriptMgr::CanSendAuctionHello(WorldSession const* session, ObjectGuid guid, Creature* creature)
{
    auto ret = IsValidBoolScript<MiscScript>([&](MiscScript* script)
    {
        return !script->CanSendAuctionHello(session, guid, creature);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

void ScriptMgr::ValidateSpellAtCastSpell(Player* player, uint32& oldSpellId, uint32& spellId, uint8& castCount, uint8& castFlags)
{
    ExecuteScript<MiscScript>([&](MiscScript* script)
    {
        script->ValidateSpellAtCastSpell(player, oldSpellId, spellId, castCount, castFlags);
    });
}

void ScriptMgr::ValidateSpellAtCastSpellResult(Player* player, Unit* mover, Spell* spell, uint32 oldSpellId, uint32 spellId)
{
    ExecuteScript<MiscScript>([&](MiscScript* script)
    {
        script->ValidateSpellAtCastSpellResult(player, mover, spell, oldSpellId, spellId);
    });
}

void ScriptMgr::OnAfterLootTemplateProcess(Loot* loot, LootTemplate const* tab, LootStore const& store, Player* lootOwner, bool personal, bool noEmptyError, uint16 lootMode)
{
    ExecuteScript<MiscScript>([&](MiscScript* script)
    {
        script->OnAfterLootTemplateProcess(loot, tab, store, lootOwner, personal, noEmptyError, lootMode);
    });
}

void ScriptMgr::OnInstanceSave(InstanceSave* instanceSave)
{
    ExecuteScript<MiscScript>([&](MiscScript* script)
    {
        script->OnInstanceSave(instanceSave);
    });
}

void ScriptMgr::OnPlayerSetPhase(const AuraEffect* auraEff, AuraApplication const* aurApp, uint8 mode, bool apply, uint32& newPhase)
{
    ExecuteScript<MiscScript>([&](MiscScript* script)
    {
        script->OnPlayerSetPhase(auraEff, aurApp, mode, apply, newPhase);
    });
}

void ScriptMgr::GetDialogStatus(Player* player, Object* questgiver)
{
    ExecuteScript<MiscScript>([&](MiscScript* script)
    {
        script->GetDialogStatus(player, questgiver);
    });
}

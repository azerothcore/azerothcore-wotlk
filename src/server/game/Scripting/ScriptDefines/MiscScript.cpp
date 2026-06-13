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

#include "MiscScript.h"
#include "ScriptMgr.h"
#include "ScriptMgrMacros.h"

void ScriptMgr::OnConstructObject(Object* origin)
{
    CALL_ENABLED_HOOKS(MiscScript, MISCHOOK_ON_CONSTRUCT_OBJECT, script->OnConstructObject(origin));
}

void ScriptMgr::OnDestructObject(Object* origin)
{
    CALL_ENABLED_HOOKS(MiscScript, MISCHOOK_ON_DESTRUCT_OBJECT, script->OnDestructObject(origin));
}

void ScriptMgr::OnConstructPlayer(Player* origin)
{
    CALL_ENABLED_HOOKS(MiscScript, MISCHOOK_ON_CONSTRUCT_PLAYER, script->OnConstructPlayer(origin));
}

void ScriptMgr::OnDestructPlayer(Player* origin)
{
    CALL_ENABLED_HOOKS(MiscScript, MISCHOOK_ON_DESTRUCT_PLAYER, script->OnDestructPlayer(origin));
}

void ScriptMgr::OnConstructGroup(Group* origin)
{
    CALL_ENABLED_HOOKS(MiscScript, MISCHOOK_ON_CONSTRUCT_GROUP, script->OnConstructGroup(origin));
}

void ScriptMgr::OnDestructGroup(Group* origin)
{
    CALL_ENABLED_HOOKS(MiscScript, MISCHOOK_ON_DESTRUCT_GROUP, script->OnDestructGroup(origin));
}

void ScriptMgr::OnConstructInstanceSave(InstanceSave* origin)
{
    CALL_ENABLED_HOOKS(MiscScript, MISCHOOK_ON_CONSTRUCT_INSTANCE_SAVE, script->OnConstructInstanceSave(origin));
}

void ScriptMgr::OnDestructInstanceSave(InstanceSave* origin)
{
    CALL_ENABLED_HOOKS(MiscScript, MISCHOOK_ON_DESTRUCT_INSTANCE_SAVE, script->OnDestructInstanceSave(origin));
}

void ScriptMgr::OnItemCreate(Item* item, ItemTemplate const* itemProto, Player const* owner)
{
    CALL_ENABLED_HOOKS(MiscScript, MISCHOOK_ON_ITEM_CREATE, script->OnItemCreate(item, itemProto, owner));
}

bool ScriptMgr::CanApplySoulboundFlag(Item* item, ItemTemplate const* proto)
{
    CALL_ENABLED_BOOLEAN_HOOKS(MiscScript, MISCHOOK_CAN_APPLY_SOULBOUND_FLAG, !script->CanApplySoulboundFlag(item, proto));
}

bool ScriptMgr::CanItemApplyEquipSpell(Player* player, Item* item)
{
    CALL_ENABLED_BOOLEAN_HOOKS(MiscScript, MISCHOOK_CAN_ITEM_APPLY_EQUIP_SPELL, !script->CanItemApplyEquipSpell(player, item));
}

bool ScriptMgr::CanSendAuctionHello(WorldSession const* session, ObjectGuid guid, Creature* creature)
{
    CALL_ENABLED_BOOLEAN_HOOKS(MiscScript, MISCHOOK_CAN_SEND_AUCTIONHELLO, !script->CanSendAuctionHello(session, guid, creature));
}

void ScriptMgr::ValidateSpellAtCastSpell(Player* player, uint32& oldSpellId, uint32& spellId, uint8& castCount, uint8& castFlags)
{
    CALL_ENABLED_HOOKS(MiscScript, MISCHOOK_VALIDATE_SPELL_AT_CAST_SPELL, script->ValidateSpellAtCastSpell(player, oldSpellId, spellId, castCount, castFlags));
}

void ScriptMgr::ValidateSpellAtCastSpellResult(Player* player, Unit* mover, Spell* spell, uint32 oldSpellId, uint32 spellId)
{
    CALL_ENABLED_HOOKS(MiscScript, MISCHOOK_VALIDATE_SPELL_AT_CAST_SPELL_RESULT, script->ValidateSpellAtCastSpellResult(player, mover, spell, oldSpellId, spellId));
}

void ScriptMgr::OnAfterLootTemplateProcess(Loot* loot, LootTemplate const* tab, LootStore const& store, Player* lootOwner, bool personal, bool noEmptyError, uint16 lootMode)
{
    CALL_ENABLED_HOOKS(MiscScript, MISCHOOK_ON_AFTER_LOOT_TEMPLATE_PROCESS, script->OnAfterLootTemplateProcess(loot, tab, store, lootOwner, personal, noEmptyError, lootMode));
}

void ScriptMgr::OnPlayerSetPhase(const AuraEffect* auraEff, AuraApplication const* aurApp, uint8 mode, bool apply, uint32& newPhase)
{
    CALL_ENABLED_HOOKS(MiscScript, MISCHOOK_ON_PLAYER_SET_PHASE, script->OnPlayerSetPhase(auraEff, aurApp, mode, apply, newPhase));
}

void ScriptMgr::OnInstanceSave(InstanceSave* instanceSave)
{
    CALL_ENABLED_HOOKS(MiscScript, MISCHOOK_ON_INSTANCE_SAVE, script->OnInstanceSave(instanceSave));
}

void ScriptMgr::GetDialogStatus(Player* player, Object* questgiver)
{
    CALL_ENABLED_HOOKS(MiscScript, MISCHOOK_GET_DIALOG_STATUS, script->GetDialogStatus(player, questgiver));
}

MiscScript::MiscScript(const char* name, std::vector<uint16> enabledHooks)
    : ScriptObject(name, MISCHOOK_END)
{
    // If empty - enable all available hooks.
    if (enabledHooks.empty())
        for (uint16 i = 0; i < MISCHOOK_END; ++i)
            enabledHooks.emplace_back(i);

    ScriptRegistry<MiscScript>::AddScript(this, std::move(enabledHooks));
}

template class AC_GAME_API ScriptRegistry<MiscScript>;

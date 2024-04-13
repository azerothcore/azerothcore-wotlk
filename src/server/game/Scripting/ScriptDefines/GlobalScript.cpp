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

#include "GlobalScript.h"
#include "InstanceScript.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "ScriptMgrMacros.h"

void ScriptMgr::OnGlobalItemDelFromDB(CharacterDatabaseTransaction trans, ObjectGuid::LowType itemGuid)
{
    ASSERT(trans);
    ASSERT(itemGuid);

    CALL_ENABLED_HOOKS(GlobalScript, GLOBALHOOK_ON_ITEM_DEL_FROM_DB, script->OnItemDelFromDB(trans, itemGuid));
}

void ScriptMgr::OnGlobalMirrorImageDisplayItem(Item const* item, uint32& display)
{
    CALL_ENABLED_HOOKS(GlobalScript, GLOBALHOOK_ON_MIRRORIMAGE_DISPLAY_ITEM, script->OnMirrorImageDisplayItem(item, display));
}

void ScriptMgr::OnAfterRefCount(Player const* player, Loot& loot, bool canRate, uint16 lootMode, LootStoreItem* LootStoreItem, uint32& maxcount, LootStore const& store)
{
    CALL_ENABLED_HOOKS(GlobalScript, GLOBALHOOK_ON_AFTER_REF_COUNT, script->OnAfterRefCount(player, LootStoreItem, loot, canRate, lootMode, maxcount, store));
}

void ScriptMgr::OnAfterCalculateLootGroupAmount(Player const* player, Loot& loot, uint16 lootMode, uint32& groupAmount, LootStore const& store)
{
    CALL_ENABLED_HOOKS(GlobalScript, GLOBALHOOK_ON_AFTER_CALCULATE_LOOT_GROUP_AMOUNT, script->OnAfterCalculateLootGroupAmount(player, loot, lootMode, groupAmount, store));
}

void ScriptMgr::OnBeforeDropAddItem(Player const* player, Loot& loot, bool canRate, uint16 lootMode, LootStoreItem* LootStoreItem, LootStore const& store)
{
    CALL_ENABLED_HOOKS(GlobalScript, GLOBALHOOK_ON_BEFORE_DROP_ADD_ITEM, script->OnBeforeDropAddItem(player, loot, canRate, lootMode, LootStoreItem, store));
}

bool ScriptMgr::OnItemRoll(Player const* player, LootStoreItem const* lootStoreItem, float& chance, Loot& loot, LootStore const& store)
{
    CALL_ENABLED_BOOLEAN_HOOKS(GlobalScript, GLOBALHOOK_ON_ITEM_ROLL, !script->OnItemRoll(player, lootStoreItem, chance, loot, store));
}

bool ScriptMgr::OnBeforeLootEqualChanced(Player const* player, LootStoreItemList equalChanced, Loot& loot, LootStore const& store)
{
    CALL_ENABLED_BOOLEAN_HOOKS(GlobalScript, GLOBALHOOK_ON_BEFORE_LOOT_EQUAL_CHANCED, !script->OnBeforeLootEqualChanced(player, equalChanced, loot, store));
}

void ScriptMgr::OnInitializeLockedDungeons(Player* player, uint8& level, uint32& lockData, lfg::LFGDungeonData const* dungeon)
{
    CALL_ENABLED_HOOKS(GlobalScript, GLOBALHOOK_ON_INITIALIZE_LOCKED_DUNGEONS, script->OnInitializeLockedDungeons(player, level, lockData, dungeon));
}

void ScriptMgr::OnAfterInitializeLockedDungeons(Player* player)
{
    CALL_ENABLED_HOOKS(GlobalScript, GLOBALHOOK_ON_AFTER_INITIALIZE_LOCKED_DUNGEONS, script->OnAfterInitializeLockedDungeons(player));
}

void ScriptMgr::OnBeforeUpdateArenaPoints(ArenaTeam* at, std::map<ObjectGuid, uint32>& ap)
{
    CALL_ENABLED_HOOKS(GlobalScript, GLOBALHOOK_ON_BEFORE_UPDATE_ARENA_POINTS, script->OnBeforeUpdateArenaPoints(at, ap));
}

void ScriptMgr::OnAfterUpdateEncounterState(Map* map, EncounterCreditType type, uint32 creditEntry, Unit* source, Difficulty difficulty_fixed, DungeonEncounterList const* encounters, uint32 dungeonCompleted, bool updated)
{
    CALL_ENABLED_HOOKS(GlobalScript, GLOBALHOOK_ON_AFTER_UPDATE_ENCOUNTER_STATE, script->OnAfterUpdateEncounterState(map, type, creditEntry, source, difficulty_fixed, encounters, dungeonCompleted, updated));
}

void ScriptMgr::OnBeforeWorldObjectSetPhaseMask(WorldObject const* worldObject, uint32& oldPhaseMask, uint32& newPhaseMask, bool& useCombinedPhases, bool& update)
{
    CALL_ENABLED_HOOKS(GlobalScript, GLOBALHOOK_ON_BEFORE_WORLDOBJECT_SET_PHASEMASK, script->OnBeforeWorldObjectSetPhaseMask(worldObject, oldPhaseMask, newPhaseMask, useCombinedPhases, update));
}

bool ScriptMgr::OnIsAffectedBySpellModCheck(SpellInfo const* affectSpell, SpellInfo const* checkSpell, SpellModifier const* mod)
{
    CALL_ENABLED_BOOLEAN_HOOKS(GlobalScript, GLOBALHOOK_ON_IS_AFFECTED_BY_SPELL_MOD_CHECK, !script->OnIsAffectedBySpellModCheck(affectSpell, checkSpell, mod));
}

bool ScriptMgr::OnSpellHealingBonusTakenNegativeModifiers(Unit const* target, Unit const* caster, SpellInfo const* spellInfo, float& val)
{
    CALL_ENABLED_BOOLEAN_HOOKS_WITH_DEFAULT_FALSE(GlobalScript, GLOBALHOOK_ON_SPELL_HEALING_BONUS_TAKEN_NEGATIVE_MODIFIERS, script->OnSpellHealingBonusTakenNegativeModifiers(target, caster, spellInfo, val));
}

void ScriptMgr::OnLoadSpellCustomAttr(SpellInfo* spell)
{
    CALL_ENABLED_HOOKS(GlobalScript, GLOBALHOOK_ON_LOAD_SPELL_CUSTOM_ATTR, script->OnLoadSpellCustomAttr(spell));
}

bool ScriptMgr::OnAllowedForPlayerLootCheck(Player const* player, ObjectGuid source)
{
    CALL_ENABLED_BOOLEAN_HOOKS(GlobalScript, GLOBALHOOK_ON_ALLOWED_FOR_PLAYER_LOOT_CHECK, script->OnAllowedForPlayerLootCheck(player, source));
}

bool ScriptMgr::OnAllowedToLootContainerCheck(Player const* player, ObjectGuid source)
{
    CALL_ENABLED_BOOLEAN_HOOKS(GlobalScript, GLOBALHOOK_ON_ALLOWED_TO_LOOT_CONTAINER_CHECK, script->OnAllowedToLootContainerCheck(player, source));
}

/**
 * @brief Called when an instance Id is deleted, usually because it expired or no players are bound to it anymore.
 *
 * @param instanceId The unique id of the instance
 */
void ScriptMgr::OnInstanceIdRemoved(uint32 instanceId)
{
    CALL_ENABLED_HOOKS(GlobalScript, GLOBALHOOK_ON_INSTANCEID_REMOVED, script->OnInstanceIdRemoved(instanceId));
}

/**
 * @brief Called when any raid boss has their state updated (e.g. pull, reset, kill).
 * @details Careful checks for old- and newState are required, since it can fire multiple times and not only when combat starts/ends.
 *
 * @param id The id of the boss in the [instance]
 * @param newState The new boss state to be applied to this boss
 * @param oldState The previously assigned state of this boss
 * @param instance A pointer to the [map] object of the instance
 */
void ScriptMgr::OnBeforeSetBossState(uint32 id, EncounterState newState, EncounterState oldState, Map* instance)
{
    CALL_ENABLED_HOOKS(GlobalScript, GLOBALHOOK_ON_BEFORE_SET_BOSS_STATE, script->OnBeforeSetBossState(id, newState, oldState, instance));
}

/**
 * @brief Called when a game object is created inside an instance
 *
 * @param instance A pointer to the [map] object of the instance
 * @param go The object being added
 */
void ScriptMgr::AfterInstanceGameObjectCreate(Map* instance, GameObject* go)
{
    CALL_ENABLED_HOOKS(GlobalScript, GLOBALHOOK_AFTER_INSTANCE_GAME_OBJECT_CREATE, script->AfterInstanceGameObjectCreate(instance, go));
}

GlobalScript::GlobalScript(const char* name, std::vector<uint16> enabledHooks)
    : ScriptObject(name, GLOBALHOOK_END)
{
    // If empty - enable all available hooks.
    if (enabledHooks.empty())
        for (uint16 i = 0; i < GLOBALHOOK_END; ++i)
            enabledHooks.emplace_back(i);

    ScriptRegistry<GlobalScript>::AddScript(this, std::move(enabledHooks));
}

template class AC_GAME_API ScriptRegistry<GlobalScript>;

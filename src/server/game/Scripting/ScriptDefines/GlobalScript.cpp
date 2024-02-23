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

    ExecuteScript<GlobalScript>([&](GlobalScript* script)
    {
        script->OnItemDelFromDB(trans, itemGuid);
    });
}

void ScriptMgr::OnGlobalMirrorImageDisplayItem(Item const* item, uint32& display)
{
    ExecuteScript<GlobalScript>([&](GlobalScript* script)
    {
        script->OnMirrorImageDisplayItem(item, display);
    });
}

void ScriptMgr::OnBeforeUpdateArenaPoints(ArenaTeam* at, std::map<ObjectGuid, uint32>& ap)
{
    ExecuteScript<GlobalScript>([&](GlobalScript* script)
    {
        script->OnBeforeUpdateArenaPoints(at, ap);
    });
}

void ScriptMgr::OnAfterRefCount(Player const* player, Loot& loot, bool canRate, uint16 lootMode, LootStoreItem* LootStoreItem, uint32& maxcount, LootStore const& store)
{
    ExecuteScript<GlobalScript>([&](GlobalScript* script)
    {
        script->OnAfterRefCount(player, LootStoreItem, loot, canRate, lootMode, maxcount, store);
    });
}

void ScriptMgr::OnAfterCalculateLootGroupAmount(Player const* player, Loot& loot, uint16 lootMode, uint32& groupAmount, LootStore const& store)
{
    ExecuteScript<GlobalScript>([&](GlobalScript* script)
    {
        script->OnAfterCalculateLootGroupAmount(player, loot, lootMode, groupAmount, store);
    });
}

void ScriptMgr::OnBeforeDropAddItem(Player const* player, Loot& loot, bool canRate, uint16 lootMode, LootStoreItem* LootStoreItem, LootStore const& store)
{
    ExecuteScript<GlobalScript>([&](GlobalScript* script)
    {
        script->OnBeforeDropAddItem(player, loot, canRate, lootMode, LootStoreItem, store);
    });
}

bool ScriptMgr::OnItemRoll(Player const* player, LootStoreItem const* lootStoreItem, float& chance, Loot& loot, LootStore const& store)
{
    auto ret = IsValidBoolScript<GlobalScript>([&](GlobalScript* script)
    {
        return !script->OnItemRoll(player, lootStoreItem, chance, loot, store);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

bool ScriptMgr::OnBeforeLootEqualChanced(Player const* player, LootStoreItemList equalChanced, Loot& loot, LootStore const& store)
{
    auto ret = IsValidBoolScript<GlobalScript>([&](GlobalScript* script)
    {
        return !script->OnBeforeLootEqualChanced(player, equalChanced, loot, store);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

void ScriptMgr::OnInitializeLockedDungeons(Player* player, uint8& level, uint32& lockData, lfg::LFGDungeonData const* dungeon)
{
    ExecuteScript<GlobalScript>([&](GlobalScript* script)
    {
        script->OnInitializeLockedDungeons(player, level, lockData, dungeon);
    });
}

void ScriptMgr::OnAfterInitializeLockedDungeons(Player* player)
{
    ExecuteScript<GlobalScript>([&](GlobalScript* script)
    {
        script->OnAfterInitializeLockedDungeons(player);
    });
}

void ScriptMgr::OnAfterUpdateEncounterState(Map* map, EncounterCreditType type, uint32 creditEntry, Unit* source, Difficulty difficulty_fixed, DungeonEncounterList const* encounters, uint32 dungeonCompleted, bool updated)
{
    ExecuteScript<GlobalScript>([&](GlobalScript* script)
    {
        script->OnAfterUpdateEncounterState(map, type, creditEntry, source, difficulty_fixed, encounters, dungeonCompleted, updated);
    });
}

void ScriptMgr::OnBeforeWorldObjectSetPhaseMask(WorldObject const* worldObject, uint32& oldPhaseMask, uint32& newPhaseMask, bool& useCombinedPhases, bool& update)
{
    ExecuteScript<GlobalScript>([&](GlobalScript* script)
    {
        script->OnBeforeWorldObjectSetPhaseMask(worldObject, oldPhaseMask, newPhaseMask, useCombinedPhases, update);
    });
}

bool ScriptMgr::OnIsAffectedBySpellModCheck(SpellInfo const* affectSpell, SpellInfo const* checkSpell, SpellModifier const* mod)
{
    auto ret = IsValidBoolScript<GlobalScript>([&](GlobalScript* script)
    {
        return !script->OnIsAffectedBySpellModCheck(affectSpell, checkSpell, mod);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

bool ScriptMgr::OnSpellHealingBonusTakenNegativeModifiers(Unit const* target, Unit const* caster, SpellInfo const* spellInfo, float& val)
{
    auto ret = IsValidBoolScript<GlobalScript>([&](GlobalScript* script)
    {
        return script->OnSpellHealingBonusTakenNegativeModifiers(target, caster, spellInfo, val);
    });

    if (ret && *ret)
    {
        return true;
    }

    return false;
}

void ScriptMgr::OnLoadSpellCustomAttr(SpellInfo* spell)
{
    ExecuteScript<GlobalScript>([&](GlobalScript* script)
    {
        script->OnLoadSpellCustomAttr(spell);
    });
}

bool ScriptMgr::OnAllowedForPlayerLootCheck(Player const* player, ObjectGuid source)
{
    auto ret = IsValidBoolScript<GlobalScript>([&](GlobalScript* script)
    {
        return script->OnAllowedForPlayerLootCheck(player, source);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

bool ScriptMgr::OnAllowedToLootContainerCheck(Player const* player, ObjectGuid source)
{
    auto ret = IsValidBoolScript<GlobalScript>([&](GlobalScript* script)
    {
        return script->OnAllowedToLootContainerCheck(player, source);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

/**
 * @brief Called when an instance Id is deleted, usually because it expired or no players are bound to it anymore.
 *
 * @param instanceId The unique id of the instance
 */
void ScriptMgr::OnInstanceIdRemoved(uint32 instanceId)
{
    ExecuteScript<GlobalScript>([&](GlobalScript* script)
    {
        script->OnInstanceIdRemoved(instanceId);
    });
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
    ExecuteScript<GlobalScript>([&](GlobalScript* script)
    {
        script->OnBeforeSetBossState(id, newState, oldState, instance);
    });
}

/**
 * @brief Called when a game object is created inside an instance
 *
 * @param instance A pointer to the [map] object of the instance
 * @param go The object being added
 */
void ScriptMgr::AfterInstanceGameObjectCreate(Map* instance, GameObject* go)
{
    ExecuteScript<GlobalScript>([&](GlobalScript* script)
    {
        script->AfterInstanceGameObjectCreate(instance, go);
    });
}

GlobalScript::GlobalScript(const char* name)
    : ScriptObject(name)
{
    ScriptRegistry<GlobalScript>::AddScript(this);
}

template class AC_GAME_API ScriptRegistry<GlobalScript>;

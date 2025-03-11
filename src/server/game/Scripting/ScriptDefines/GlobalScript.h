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

#ifndef SCRIPT_OBJECT_GLOBAL_SCRIPT_H_
#define SCRIPT_OBJECT_GLOBAL_SCRIPT_H_

#include "DatabaseEnvFwd.h"
#include "DBCEnums.h"
#include "ObjectGuid.h"
#include "ScriptObject.h"
#include <map>
#include <vector>

enum GlobalHook
{
    GLOBALHOOK_ON_ITEM_DEL_FROM_DB,
    GLOBALHOOK_ON_MIRRORIMAGE_DISPLAY_ITEM,
    GLOBALHOOK_ON_AFTER_REF_COUNT,
    GLOBALHOOK_ON_AFTER_CALCULATE_LOOT_GROUP_AMOUNT,
    GLOBALHOOK_ON_BEFORE_DROP_ADD_ITEM,
    GLOBALHOOK_ON_ITEM_ROLL,
    GLOBALHOOK_ON_BEFORE_LOOT_EQUAL_CHANCED,
    GLOBALHOOK_ON_INITIALIZE_LOCKED_DUNGEONS,
    GLOBALHOOK_ON_AFTER_INITIALIZE_LOCKED_DUNGEONS,
    GLOBALHOOK_ON_BEFORE_UPDATE_ARENA_POINTS,
    GLOBALHOOK_ON_AFTER_UPDATE_ENCOUNTER_STATE,
    GLOBALHOOK_ON_BEFORE_WORLDOBJECT_SET_PHASEMASK,
    GLOBALHOOK_ON_IS_AFFECTED_BY_SPELL_MOD_CHECK,
    GLOBALHOOK_ON_SPELL_HEALING_BONUS_TAKEN_NEGATIVE_MODIFIERS,
    GLOBALHOOK_ON_LOAD_SPELL_CUSTOM_ATTR,
    GLOBALHOOK_ON_ALLOWED_FOR_PLAYER_LOOT_CHECK,
    GLOBALHOOK_ON_ALLOWED_TO_LOOT_CONTAINER_CHECK,
    GLOBALHOOK_ON_INSTANCEID_REMOVED,
    GLOBALHOOK_ON_BEFORE_SET_BOSS_STATE,
    GLOBALHOOK_AFTER_INSTANCE_GAME_OBJECT_CREATE,
    GLOBALHOOK_END
};

// following hooks can be used anywhere and are not db bounded
class GlobalScript : public ScriptObject
{
protected:
    GlobalScript(const char* name, std::vector<uint16> enabledHooks = std::vector<uint16>());

public:
    // items
    virtual void OnItemDelFromDB(CharacterDatabaseTransaction /*trans*/, ObjectGuid::LowType /*itemGuid*/) { }
    virtual void OnMirrorImageDisplayItem(Item const* /*item*/, uint32& /*display*/) { }

    // loot
    virtual void OnAfterRefCount(Player const* /*player*/, LootStoreItem* /*LootStoreItem*/, Loot& /*loot*/, bool /*canRate*/, uint16 /*lootMode*/, uint32& /*maxcount*/, LootStore const& /*store*/) { }
    virtual void OnAfterCalculateLootGroupAmount(Player const* /*player*/, Loot& /*loot*/, uint16 /*lootMode*/, uint32& /*groupAmount*/, LootStore const& /*store*/) { }
    virtual void OnBeforeDropAddItem(Player const* /*player*/, Loot& /*loot*/, bool /*canRate*/, uint16 /*lootMode*/, LootStoreItem* /*LootStoreItem*/, LootStore const& /*store*/) { }
    virtual bool OnItemRoll(Player const* /*player*/, LootStoreItem const* /*LootStoreItem*/, float& /*chance*/, Loot& /*loot*/, LootStore const& /*store*/) { return true; };
    virtual bool OnBeforeLootEqualChanced(Player const* /*player*/, std::list<LootStoreItem*> /*EqualChanced*/, Loot& /*loot*/, LootStore const& /*store*/) { return true; }
    virtual void OnInitializeLockedDungeons(Player* /*player*/, uint8& /*level*/, uint32& /*lockData*/, lfg::LFGDungeonData const* /*dungeon*/) { }
    virtual void OnAfterInitializeLockedDungeons(Player* /*player*/) { }

    // On Before arena points distribution
    virtual void OnBeforeUpdateArenaPoints(ArenaTeam* /*at*/, std::map<ObjectGuid, uint32>& /*ap*/) { }

    // Called when a dungeon encounter is updated.
    virtual void OnAfterUpdateEncounterState(Map* /*map*/, EncounterCreditType /*type*/,  uint32 /*creditEntry*/, Unit* /*source*/, Difficulty /*difficulty_fixed*/, std::list<DungeonEncounter const*> const* /*encounters*/, uint32 /*dungeonCompleted*/, bool /*updated*/) { }

    // Called before the phase for a WorldObject is set
    virtual void OnBeforeWorldObjectSetPhaseMask(WorldObject const* /*worldObject*/, uint32& /*oldPhaseMask*/, uint32& /*newPhaseMask*/, bool& /*useCombinedPhases*/, bool& /*update*/) { }

    // Called when checking if an aura spell is affected by a mod
    virtual bool OnIsAffectedBySpellModCheck(SpellInfo const* /*affectSpell*/, SpellInfo const* /*checkSpell*/, SpellModifier const* /*mod*/) { return true; };

    // Called when checking for spell negative healing modifiers
    virtual bool OnSpellHealingBonusTakenNegativeModifiers(Unit const* /*target*/, Unit const* /*caster*/, SpellInfo const* /*spellInfo*/, float& /*val*/) { return false; };

    // Called after loading spell dbc corrections
    virtual void OnLoadSpellCustomAttr(SpellInfo* /*spell*/) { }

    // Called when checking if a player can see the creature loot item
    virtual bool OnAllowedForPlayerLootCheck(Player const* /*player*/, ObjectGuid /*source*/) { return false; };

    // Called when checking if a player can see the creature loot (if it can click the corpse f.e)
    virtual bool OnAllowedToLootContainerCheck(Player const* /*player*/, ObjectGuid /*source*/) { return false; };

    // Called when instance id is removed from database (e.g. instance reset)
    virtual void OnInstanceIdRemoved(uint32 /*instanceId*/) { }

    // Called when any raid boss has their state updated (e.g. pull, reset, kill)
    virtual void OnBeforeSetBossState(uint32 /*id*/, EncounterState /*newState*/, EncounterState /*oldState*/, Map* /*instance*/) { }

    // Called when a gameobject is created by an instance
    virtual void AfterInstanceGameObjectCreate(Map* /*instance*/, GameObject* /*go*/) { }
};

#endif

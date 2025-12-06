/*
* Copyright (C) 2010 - 2016 Eluna Lua Engine <http://emudevs.com/>
* This program is free software licensed under GPL version 3
* Please see the included DOCS/LICENSE.md for more information
*/

#ifndef SPELLENTRYMETHODS_H
#define SPELLENTRYMETHODS_H

namespace LuaSpellEntry
{
    /**
     * Returns the ID of the [SpellEntry].
     *
     * @return uint32 id
     */
    int GetId(lua_State* L, SpellEntry* entry)
    {
        Eluna::Push(L, entry->Id);
        return 1;
    }

    /**
     * Returns the category ID for the [SpellEntry].
     *
     * @return uint32 categoryId
     */
    int GetCategory(lua_State* L, SpellEntry* entry)
    {
        Eluna::Push(L, entry->Category);
        return 1;
    }

    /**
     * Returns the dispel ID for the [SpellEntry].
     *
     * @return uint32 dispelId
     */
    int GetDispel(lua_State* L, SpellEntry* entry)
    {
        Eluna::Push(L, entry->Dispel);
        return 1;
    }

    /**
     * Returns the mechanic ID for the [SpellEntry].
     *
     * @return uint32 mechanicId
     */
    int GetMechanic(lua_State* L, SpellEntry* entry)
    {
        Eluna::Push(L, entry->Mechanic);
        return 1;
    }

    /**
     * Returns the attribute bitflags for the [SpellEntry].
     *
     * @return uint32 attribute : bitmask, but returned as uint32
     */
    int GetAttributes(lua_State* L, SpellEntry* entry)
    {
        Eluna::Push(L, entry->Attributes);
        return 1;
    }

    /**
     * Returns the attributeEx bitflags for the [SpellEntry].
     *
     * @return uint32 attributeEx : bitmask, but returned as uint32
     */
    int GetAttributesEx(lua_State* L, SpellEntry* entry)
    {
        Eluna::Push(L, entry->AttributesEx);
        return 1;
    }

    /**
     * Returns the attributeEx2 bitflags for the [SpellEntry].
     *
     * @return uint32 attributeEx2 : bitmask, but returned as uint32
     */
    int GetAttributesEx2(lua_State* L, SpellEntry* entry)
    {
        Eluna::Push(L, entry->AttributesEx2);
        return 1;
    }

    /**
     * Returns the attributeEx3 bitflags for the [SpellEntry].
     *
     * @return uint32 attributeEx3 : bitmask, but returned as uint32
     */
    int GetAttributesEx3(lua_State* L, SpellEntry* entry)
    {
        Eluna::Push(L, entry->AttributesEx3);
        return 1;
    }

    /**
     * Returns the attributeEx4 bitflags for the [SpellEntry].
     *
     * @return uint32 attributeEx4 : bitmask, but returned as uint32
     */
    int GetAttributesEx4(lua_State* L, SpellEntry* entry)
    {
        Eluna::Push(L, entry->AttributesEx4);
        return 1;
    }

    /**
     * Returns the attributeEx5 bitflags for the [SpellEntry].
     *
     * @return uint32 attributeEx5 : bitmask, but returned as uint32
     */
    int GetAttributesEx5(lua_State* L, SpellEntry* entry)
    {
        Eluna::Push(L, entry->AttributesEx5);
        return 1;
    }

    /**
     * Returns the attributeEx6 bitflags for the [SpellEntry].
     *
     * @return uint32 attributeEx6 : bitmask, but returned as uint32
     */
    int GetAttributesEx6(lua_State* L, SpellEntry* entry)
    {
        Eluna::Push(L, entry->AttributesEx6);
        return 1;
    }

    /**
     * Returns the attributeEx7 bitflags for the [SpellEntry].
     *
     * @return uint32 attributeEx7 : bitmask, but returned as uint32
     */
    int GetAttributesEx7(lua_State* L, SpellEntry* entry)
    {
        Eluna::Push(L, entry->AttributesEx7);
        return 1;
    }

    /**
     * Returns the stance bitflags for the [SpellEntry].
     *
     * @return uint32 stance : bitmask, but returned as uint32
     */
    int GetStances(lua_State* L, SpellEntry* entry)
    {
        Eluna::Push(L, entry->Stances);
        return 1;
    }

    int GetStancesNot(lua_State* L, SpellEntry* entry)
    {
        Eluna::Push(L, entry->StancesNot);
        return 1;
    }

    /**
     * Returns the target bitmasks for the [SpellEntry].
     *
     * @return uint32 target : bitmasks, but returned as uint32.
     */
    int GetTargets(lua_State* L, SpellEntry* entry)
    {
        Eluna::Push(L, entry->Targets);
        return 1;
    }

    /**
     * Returns the target creature type bitmasks for the [SpellEntry].
     *
     * @return uint32 targetCreatureType : bitmasks, but returned as uint32.
     */
    int GetTargetCreatureType(lua_State* L, SpellEntry* entry)
    {
        Eluna::Push(L, entry->TargetCreatureType);
        return 1;
    }

    int GetRequiresSpellFocus(lua_State* L, SpellEntry* entry)
    {
        Eluna::Push(L, entry->RequiresSpellFocus);
        return 1;
    }

    int GetFacingCasterFlags(lua_State* L, SpellEntry* entry)
    {
        Eluna::Push(L, entry->FacingCasterFlags);
        return 1;
    }

    int GetCasterAuraState(lua_State* L, SpellEntry* entry)
    {
        Eluna::Push(L, entry->CasterAuraState);
        return 1;
    }

    int GetTargetAuraState(lua_State* L, SpellEntry* entry)
    {
        Eluna::Push(L, entry->TargetAuraState);
        return 1;
    }

    int GetCasterAuraStateNot(lua_State* L, SpellEntry* entry)
    {
        Eluna::Push(L, entry->CasterAuraStateNot);
        return 1;
    }

    int GetTargetAuraStateNot(lua_State* L, SpellEntry* entry)
    {
        Eluna::Push(L, entry->TargetAuraStateNot);
        return 1;
    }

    int GetCasterAuraSpell(lua_State* L, SpellEntry* entry)
    {
        Eluna::Push(L, entry->CasterAuraSpell);
        return 1;
    }

    int GetTargetAuraSpell(lua_State* L, SpellEntry* entry)
    {
        Eluna::Push(L, entry->TargetAuraSpell);
        return 1;
    }

    int GetExcludeCasterAuraSpell(lua_State* L, SpellEntry* entry)
    {
        Eluna::Push(L, entry->ExcludeCasterAuraSpell);
        return 1;
    }

    int GetExcludeTargetAuraSpell(lua_State* L, SpellEntry* entry)
    {
        Eluna::Push(L, entry->ExcludeTargetAuraSpell);
        return 1;
    }

    int GetCastingTimeIndex(lua_State* L, SpellEntry* entry)
    {
        Eluna::Push(L, entry->CastingTimeIndex);
        return 1;
    }

    /**
     * Returns the recovery time for the [SpellEntry].
     *
     * @return uint32 recoveryTime
     */
    int GetRecoveryTime(lua_State* L, SpellEntry* entry)
    {
        Eluna::Push(L, entry->RecoveryTime);
        return 1;
    }

    /**
     * Returns the category recovery time for the [SpellEntry].
     *
     * @return uint32 categoryRecoveryTime : in milliseconds, returned as uint32
     */
    int GetCategoryRecoveryTime(lua_State* L, SpellEntry* entry)
    {
        Eluna::Push(L, entry->CategoryRecoveryTime);
        return 1;
    }

    int GetInterruptFlags(lua_State* L, SpellEntry* entry)
    {
        Eluna::Push(L, entry->InterruptFlags);
        return 1;
    }

    int GetAuraInterruptFlags(lua_State* L, SpellEntry* entry)
    {
        Eluna::Push(L, entry->AuraInterruptFlags);
        return 1;
    }

    int GetChannelInterruptFlags(lua_State* L, SpellEntry* entry)
    {
        Eluna::Push(L, entry->ChannelInterruptFlags);
        return 1;
    }

    int GetProcFlags(lua_State* L, SpellEntry* entry)
    {
        Eluna::Push(L, entry->ProcFlags);
        return 1;
    }

    /**
     * Returns the proc chance of [SpellEntry].
     *
     * @return uint32 procChance
     */
    int GetProcChance(lua_State* L, SpellEntry* entry)
    {
        Eluna::Push(L, entry->ProcChance);
        return 1;
    }

    /**
     * Returns the proc charges of [SpellEntry].
     *
     * @return uint32 procCharges
     */
    int GetProcCharges(lua_State* L, SpellEntry* entry)
    {
        Eluna::Push(L, entry->ProcCharges);
        return 1;
    }

    /**
     * Returns the max level for the [SpellEntry].
     *
     * @return uint32 maxLevel : the [SpellEntry] max level.
     */
    int GetMaxLevel(lua_State* L, SpellEntry* entry)
    {
        Eluna::Push(L, entry->MaxLevel);
        return 1;
    }

    /**
     * Returns the base level required for the [SpellEntry].
     *
     * @return uint32 baseLevel
     */
    int GetBaseLevel(lua_State* L, SpellEntry* entry)
    {
        Eluna::Push(L, entry->BaseLevel);
        return 1;
    }

    /**
     * Returns the spell level for the [SpellEntry].
     *
     * @return uint32 spellLevel
     */
    int GetSpellLevel(lua_State* L, SpellEntry* entry)
    {
        Eluna::Push(L, entry->SpellLevel);
        return 1;
    }

    /**
     * Returns the duration index for the [SpellEntry].
     *
     * @return uint32 durationIndex
     */
    int GetDurationIndex(lua_State* L, SpellEntry* entry)
    {
        Eluna::Push(L, entry->DurationIndex);
        return 1;
    }

    /**
     * Returns the power type ID for the [SpellEntry].
     *
     * @return uint32 powerTypeId
     */
    int GetPowerType(lua_State* L, SpellEntry* entry)
    {
        Eluna::Push(L, entry->PowerType);
        return 1;
    }

    /**
     * Returns the mana cost for the [SpellEntry].
     *
     * @return uint32 manaCost
     */
    int GetManaCost(lua_State* L, SpellEntry* entry)
    {
        Eluna::Push(L, entry->ManaCost);
        return 1;
    }

    /**
     * Returns the mana cost per level for [SpellEntry].
     *
     * @return uint32 manaCostPerLevel
     */
    int GetManaCostPerlevel(lua_State* L, SpellEntry* entry)
    {
        Eluna::Push(L, entry->ManaCostPerlevel);
        return 1;
    }

    /**
     * Returns the mana per second for [SpellEntry].
     *
     * @return uint32 manaPerSecond
     */
    int GetManaPerSecond(lua_State* L, SpellEntry* entry)
    {
        Eluna::Push(L, entry->ManaPerSecond);
        return 1;
    }

    /**
     * Returns the mana per second per level for [SpellEntry].
     *
     * @return uint32 manaPerSecondPerLevel
     */
    int GetManaPerSecondPerLevel(lua_State* L, SpellEntry* entry)
    {
        Eluna::Push(L, entry->ManaPerSecondPerLevel);
        return 1;
    }

    /**
     * Returns the range index for [SpellEntry].
     *
     * @return uint32 rangeIndex
     */
    int GetRangeIndex(lua_State* L, SpellEntry* entry)
    {
        Eluna::Push(L, entry->RangeIndex);
        return 1;
    }

    /**
     * Returns speed for [SpellEntry].
     *
     * @return uint32 speed
     */
    int GetSpeed(lua_State* L, SpellEntry* entry)
    {
        Eluna::Push(L, entry->Speed);
        return 1;
    }

    /**
     * Returns the stack amount for [SpellEntry].
     *
     * @return uint32 stackAmount
     */
    int GetStackAmount(lua_State* L, SpellEntry* entry)
    {
        Eluna::Push(L, entry->StackAmount);
        return 1;
    }

    /**
     * Returns a table with all totem values for [SpellEntry].
     *
     * @return table totem
     */
    int GetTotem(lua_State* L, SpellEntry* entry)
    {
        lua_newtable(L);
        int tbl = lua_gettop(L);
        uint32 i = 0;

        for (size_t index = 0; index < entry->Totem.size(); ++index)
        {
            Eluna::Push(L, entry->Totem[index]);
            lua_rawseti(L, tbl, ++i);
        }
        
        lua_settop(L, tbl); // push table to top of stack
        return 1;
    }

    /**
     * Returns a table with all reagent values for [SpellEntry].
     *
     * @return table reagent
     */
    int GetReagent(lua_State* L, SpellEntry* entry)
    {
        lua_newtable(L);
        int tbl = lua_gettop(L);
        uint32 i = 0;

        for (size_t index = 0; index < entry->Reagent.size(); ++index)
        {
            Eluna::Push(L, entry->Reagent[index]);
            lua_rawseti(L, tbl, ++i);
        }
        
        lua_settop(L, tbl); // push table to top of stack
        return 1;
    }

    /**
     * Returns a table with all reagent count values for [SpellEntry].
     *
     * @return table reagentCount
     */
    int GetReagentCount(lua_State* L, SpellEntry* entry)
    {
        lua_newtable(L);
        int tbl = lua_gettop(L);
        uint32 i = 0;

        for (size_t index = 0; index < entry->ReagentCount.size(); ++index)
        {
            Eluna::Push(L, entry->ReagentCount[index]);
            lua_rawseti(L, tbl, ++i);
        }
        
        lua_settop(L, tbl); // push table to top of stack
        return 1;
    }

    /**
     * Returns the equipped item class ID for [SpellEntry].
     *
     * @return uint32 equippedItemClassId
     */
    int GetEquippedItemClass(lua_State* L, SpellEntry* entry)
    {
        Eluna::Push(L, entry->EquippedItemClass);
        return 1;
    }

    /**
     * Returns the equipped item sub class masks for [SpellEntry].
     *
     * @return uint32 equippedItemSubClassMasks : bitmasks, returned as uint32.
     */
    int GetEquippedItemSubClassMask(lua_State* L, SpellEntry* entry)
    {
        Eluna::Push(L, entry->EquippedItemSubClassMask);
        return 1;
    }

    /**
     * Returns the equipped item inventory type masks for [SpellEntry].
     *
     * @return uint32 equippedItemInventoryTypeMasks : bitmasks, returned as uint32.
     */
    int GetEquippedItemInventoryTypeMask(lua_State* L, SpellEntry* entry)
    {
        Eluna::Push(L, entry->EquippedItemInventoryTypeMask);
        return 1;
    }

    /**
     * Returns a table with all spell effect IDs for [SpellEntry].
     *
     * @return table effect
     */
    int GetEffect(lua_State* L, SpellEntry* entry)
    {
        lua_newtable(L);
        int tbl = lua_gettop(L);
        uint32 i = 0;

        for (size_t index = 0; index < entry->Effect.size(); ++index)
        {
            Eluna::Push(L, entry->Effect[index]);
            lua_rawseti(L, tbl, ++i);
        }
        
        lua_settop(L, tbl); // push table to top of stack
        return 1;
    }

    /**
     * Returns a table with all effect die sides values for [SpellEntry].
     *
     * @return table effectDieSides
     */
    int GetEffectDieSides(lua_State* L, SpellEntry* entry)
    {
        lua_newtable(L);
        int tbl = lua_gettop(L);
        uint32 i = 0;

        for (size_t index = 0; index < entry->EffectDieSides.size(); ++index)
        {
            Eluna::Push(L, entry->EffectDieSides[index]);
            lua_rawseti(L, tbl, ++i);
        }
        
        lua_settop(L, tbl); // push table to top of stack
        return 1;
    }

    /**
     * Returns a table with all effect real points per level values for [SpellEntry].
     *
     * @return table effectRealPointsPerLevel
     */
    int GetEffectRealPointsPerLevel(lua_State* L, SpellEntry* entry)
    {
        lua_newtable(L);
        int tbl = lua_gettop(L);
        uint32 i = 0;

        for (size_t index = 0; index < entry->EffectRealPointsPerLevel.size(); ++index)
        {
            Eluna::Push(L, entry->EffectRealPointsPerLevel[index]);
            lua_rawseti(L, tbl, ++i);
        }
        
        lua_settop(L, tbl); // push table to top of stack
        return 1;
    }

    /**
     * Returns a table with all effect base points values for [SpellEntry].
     *
     * @return table effectBasePoints
     */
    int GetEffectBasePoints(lua_State* L, SpellEntry* entry)
    {
        lua_newtable(L);
        int tbl = lua_gettop(L);
        uint32 i = 0;

        for (size_t index = 0; index < entry->EffectBasePoints.size(); ++index)
        {
            Eluna::Push(L, entry->EffectBasePoints[index]);
            lua_rawseti(L, tbl, ++i);
        }
        
        lua_settop(L, tbl); // push table to top of stack
        return 1;
    }

    /**
     * Returns a table with all effect mechanic IDs for [SpellEntry].
     *
     * @return table effectMechanic
     */
    int GetEffectMechanic(lua_State* L, SpellEntry* entry)
    {
        lua_newtable(L);
        int tbl = lua_gettop(L);
        uint32 i = 0;

        for (size_t index = 0; index < entry->EffectMechanic.size(); ++index)
        {
            Eluna::Push(L, entry->EffectMechanic[index]);
            lua_rawseti(L, tbl, ++i);
        }
        
        lua_settop(L, tbl); // push table to top of stack
        return 1;
    }

    /**
     * Returns a table with all effect implicit target a IDs for [SpellEntry].
     *
     * @return table effectImplicitTargetA
     */
    int GetEffectImplicitTargetA(lua_State* L, SpellEntry* entry)
    {
        lua_newtable(L);
        int tbl = lua_gettop(L);
        uint32 i = 0;

        for (size_t index = 0; index < entry->EffectImplicitTargetA.size(); ++index)
        {
            Eluna::Push(L, entry->EffectImplicitTargetA[index]);
            lua_rawseti(L, tbl, ++i);
        }
        
        lua_settop(L, tbl); // push table to top of stack
        return 1;
    }

    /**
     * Returns a table with all effect implicit target b IDs for [SpellEntry].
     *
     * @return table effectImplicitTargetB
     */
    int GetEffectImplicitTargetB(lua_State* L, SpellEntry* entry)
    {
        lua_newtable(L);
        int tbl = lua_gettop(L);
        uint32 i = 0;

        for (size_t index = 0; index < entry->EffectImplicitTargetB.size(); ++index)
        {
            Eluna::Push(L, entry->EffectImplicitTargetB[index]);
            lua_rawseti(L, tbl, ++i);
        }
        
        lua_settop(L, tbl); // push table to top of stack
        return 1;
    }

    /**
     * Returns a table with all effect radius index for [SpellEntry].
     *
     * @return table effectRadiusIndex
     */
    int GetEffectRadiusIndex(lua_State* L, SpellEntry* entry)
    {
        lua_newtable(L);
        int tbl = lua_gettop(L);
        uint32 i = 0;

        for (size_t index = 0; index < entry->EffectRadiusIndex.size(); ++index)
        {
            Eluna::Push(L, entry->EffectRadiusIndex[index]);
            lua_rawseti(L, tbl, ++i);
        }
        
        lua_settop(L, tbl); // push table to top of stack
        return 1;
    }

    /**
     * Returns a table with all effect apply aura IDs for [SpellEntry].
     *
     * @return table effectApplyAura
     */
    int GetEffectApplyAuraName(lua_State* L, SpellEntry* entry)
    {
        lua_newtable(L);
        int tbl = lua_gettop(L);
        uint32 i = 0;

        for (size_t index = 0; index < entry->EffectApplyAuraName.size(); ++index)
        {
            Eluna::Push(L, entry->EffectApplyAuraName[index]);
            lua_rawseti(L, tbl, ++i);
        }
        
        lua_settop(L, tbl); // push table to top of stack
        return 1;
    }

    /**
     * Returns a table with all effect amplitude values for [SpellEntry].
     *
     * @return table effectAmplitude
     */
    int GetEffectAmplitude(lua_State* L, SpellEntry* entry)
    {
        lua_newtable(L);
        int tbl = lua_gettop(L);
        uint32 i = 0;

        for (size_t index = 0; index < entry->EffectAmplitude.size(); ++index)
        {
            Eluna::Push(L, entry->EffectAmplitude[index]);
            lua_rawseti(L, tbl, ++i);
        }
        
        lua_settop(L, tbl); // push table to top of stack
        return 1;
    }

    /**
     * Returns a table with all effect value multiplier for [SpellEntry].
     *
     * @return table effectValueMultiplier
     */
    int GetEffectValueMultiplier(lua_State* L, SpellEntry* entry)
    {
        lua_newtable(L);
        int tbl = lua_gettop(L);
        uint32 i = 0;

        for (size_t index = 0; index < entry->EffectValueMultiplier.size(); ++index)
        {
            Eluna::Push(L, entry->EffectValueMultiplier[index]);
            lua_rawseti(L, tbl, ++i);
        }
        
        lua_settop(L, tbl); // push table to top of stack
        return 1;
    }

    /**
     * Returns a table with all effect chain target values for [SpellEntry].
     *
     * @return table effectChainTarget
     */
    int GetEffectChainTarget(lua_State* L, SpellEntry* entry)
    {
        lua_newtable(L);
        int tbl = lua_gettop(L);
        uint32 i = 0;

        for (size_t index = 0; index < entry->EffectChainTarget.size(); ++index)
        {
            Eluna::Push(L, entry->EffectChainTarget[index]);
            lua_rawseti(L, tbl, ++i);
        }
        
        lua_settop(L, tbl); // push table to top of stack
        return 1;
    }

    /**
     * Returns a table with all effect item type values for [SpellEntry].
     *
     * @return table effectItemType
     */
    int GetEffectItemType(lua_State* L, SpellEntry* entry)
    {
        lua_newtable(L);
        int tbl = lua_gettop(L);
        uint32 i = 0;

        for (size_t index = 0; index < entry->EffectItemType.size(); ++index)
        {
            Eluna::Push(L, entry->EffectItemType[index]);
            lua_rawseti(L, tbl, ++i);
        }
        
        lua_settop(L, tbl); // push table to top of stack
        return 1;
    }

    /**
     * Returns a table with all effect misc value A for [SpellEntry].
     *
     * @return table effectMiscValueA
     */
    int GetEffectMiscValue(lua_State* L, SpellEntry* entry)
    {
        lua_newtable(L);
        int tbl = lua_gettop(L);
        uint32 i = 0;

        for (size_t index = 0; index < entry->EffectMiscValue.size(); ++index)
        {
            Eluna::Push(L, entry->EffectMiscValue[index]);
            lua_rawseti(L, tbl, ++i);
        }
        
        lua_settop(L, tbl); // push table to top of stack
        return 1;
    }

    /**
     * Returns a table with all effect misc value B for [SpellEntry].
     *
     * @return table effectMiscValueB
     */
    int GetEffectMiscValueB(lua_State* L, SpellEntry* entry)
    {
        lua_newtable(L);
        int tbl = lua_gettop(L);
        uint32 i = 0;

        for (size_t index = 0; index < entry->EffectMiscValueB.size(); ++index)
        {
            Eluna::Push(L, entry->EffectMiscValueB[index]);
            lua_rawseti(L, tbl, ++i);
        }
        
        lua_settop(L, tbl); // push table to top of stack
        return 1;
    }

    /**
     * Returns a table with all effect trigger spell for [SpellEntry].
     *
     * @return table effectTriggerSpell
     */
    int GetEffectTriggerSpell(lua_State* L, SpellEntry* entry)
    {
        lua_newtable(L);
        int tbl = lua_gettop(L);
        uint32 i = 0;

        for (size_t index = 0; index < entry->EffectTriggerSpell.size(); ++index)
        {
            Eluna::Push(L, entry->EffectTriggerSpell[index]);
            lua_rawseti(L, tbl, ++i);
        }
        
        lua_settop(L, tbl); // push table to top of stack
        return 1;
    }

    /**
     * Returns a table with all effect points per combo point of [SpellEntry]
     *
     * @return table effectPointsPerComboPoint : returns a table containing all the effect points per combo point values of [SpellEntry]
     */
    int GetEffectPointsPerComboPoint(lua_State* L, SpellEntry* entry)
    {
        lua_newtable(L);
        int tbl = lua_gettop(L);
        uint32 i = 0;

        for (size_t index = 0; index < entry->EffectPointsPerComboPoint.size(); ++index)
        {
            Eluna::Push(L, entry->EffectPointsPerComboPoint[index]);
            lua_rawseti(L, tbl, ++i);
        }
        
        lua_settop(L, tbl); // push table to top of stack
        return 1;
    }

    int GetEffectSpellClassMask(lua_State* L, SpellEntry* entry)
    {
        lua_newtable(L);
        int tbl = lua_gettop(L);
        uint32 i = 0;

        for (size_t index = 0; index < entry->EffectSpellClassMask.size(); ++index)
        {
            Eluna::Push(L, entry->EffectSpellClassMask[index]);
            lua_rawseti(L, tbl, ++i);
        }
        
        lua_settop(L, tbl); // push table to top of stack
        return 1;
    }

    /**
     * Returns a table with both spell visuals of [SpellEntry]
     *
     * @return table spellVisuals : returns a table containing both spellVisuals for [SpellEntry].
     */
    int GetSpellVisual(lua_State* L, SpellEntry* entry)
    {
        lua_newtable(L);
        int tbl = lua_gettop(L);
        uint32 i = 0;

        for (size_t index = 0; index < entry->SpellVisual.size(); ++index)
        {
            Eluna::Push(L, entry->SpellVisual[index]);
            lua_rawseti(L, tbl, ++i);
        }
        
        lua_settop(L, tbl); // push table to top of stack
        return 1;
    }

    /**
     * Returns the spell icon ID for the [SpellEntry].
     *
     * @return uint32 spellIconId
     */
    int GetSpellIconID(lua_State* L, SpellEntry* entry)
    {
        Eluna::Push(L, entry->SpellIconID);
        return 1;
    }

    /**
     * Returns the active icon ID for the [SpellEntry].
     *
     * @return uint32 activeIconId
     */
    int GetActiveIconID(lua_State* L, SpellEntry* entry)
    {
        Eluna::Push(L, entry->ActiveIconID);
        return 1;
    }

    /**
     * Returns the spell Priority for the [SpellEntry].
     *
     * @return uint32 spellPriority
     */
    int GetSpellPriority(lua_State* L, SpellEntry* entry)
    {
        Eluna::Push(L, entry->SpellPriority);
        return 1;
    }

    /**
     * Returns a table of the [SpellEntry] names of all locals.
     *
     * @return table spellNames
     */
    int GetSpellName(lua_State* L, SpellEntry* entry)
    {
        lua_newtable(L);
        int tbl = lua_gettop(L);
        uint32 i = 0;

        for (size_t index = 0; index < entry->SpellName.size(); ++index)
        {
            Eluna::Push(L, entry->SpellName[index]);
            lua_rawseti(L, tbl, ++i);
        }
        
        lua_settop(L, tbl); // push table to top of stack
        return 1;
    }

    /**
     * Returns a table of the [SpellEntry] ranks.
     *
     * @return table spellRanks
     */
    int GetRank(lua_State* L, SpellEntry* entry)
    {
        lua_newtable(L);
        int tbl = lua_gettop(L);
        uint32 i = 0;

        for (size_t index = 0; index < entry->Rank.size(); ++index)
        {
            Eluna::Push(L, entry->Rank[index]);
            lua_rawseti(L, tbl, ++i);
        }
        
        lua_settop(L, tbl); // push table to top of stack
        return 1;
    }

    /**
     * Returns the mana cost percentage of [SpellEntry].
     *
     * @return uint32 manaCostPercentage : the mana cost in percentage, returned as uint32.
     */
    int GetManaCostPercentage(lua_State* L, SpellEntry* entry)
    {
        Eluna::Push(L, entry->ManaCostPercentage);
        return 1;
    }

    /**
     * Returns the global cooldown time value for [SpellEntry].
     *
     * @return uint32 globalCooldownTime
     */
    int GetStartRecoveryCategory(lua_State* L, SpellEntry* entry)
    {
        Eluna::Push(L, entry->StartRecoveryCategory);
        return 1;
    }

    /**
     * Returns the global cooldown category value for [SpellEntry].
     *
     * @return uint32 globalCooldownCategory
     */
    int GetStartRecoveryTime(lua_State* L, SpellEntry* entry)
    {
        Eluna::Push(L, entry->StartRecoveryTime);
        return 1;
    }

    /**
     * Returns the max target level value for [SpellEntry].
     *
     * @return uint32 maxTargetLevel
     */
    int GetMaxTargetLevel(lua_State* L, SpellEntry* entry)
    {
        Eluna::Push(L, entry->MaxTargetLevel);
        return 1;
    }


    int GetSpellFamilyName(lua_State* L, SpellEntry* entry)
    {
        Eluna::Push(L, entry->SpellFamilyName);
        return 1;
    }

    int GetSpellFamilyFlags(lua_State* L, SpellEntry* entry)
    {
        Eluna::Push(L, entry->SpellFamilyFlags);
        return 1;
    }

    /**
     * Returns the max affected targets value [SpellEntry].
     *
     * @return uint32 maxAffectedTargets
     */
    int GetMaxAffectedTargets(lua_State* L, SpellEntry* entry)
    {
        Eluna::Push(L, entry->MaxAffectedTargets);
        return 1;
    }

    /**
     * Returns the spell damage type ID [SpellEntry].
     *
     * @return uint32 spellDamageTypeId
     */
    int GetDmgClass(lua_State* L, SpellEntry* entry)
    {
        Eluna::Push(L, entry->DmgClass);
        return 1;
    }

    /**
     * Returns the prevention type ID [SpellEntry].
     *
     * @return uint32 preventionTypeId
     */
    int GetPreventionType(lua_State* L, SpellEntry* entry)
    {
        Eluna::Push(L, entry->PreventionType);
        return 1;
    }

    /**
     * Returns a table with all effect damage multiplier values [SpellEntry].
     *
     * @return table effectDamageMultipliers
     */
    int GetEffectDamageMultiplier(lua_State* L, SpellEntry* entry)
    {
        lua_newtable(L);
        int tbl = lua_gettop(L);
        uint32 i = 0;

        for (size_t index = 0; index < entry->EffectDamageMultiplier.size(); ++index)
        {
            Eluna::Push(L, entry->EffectDamageMultiplier[index]);
            lua_rawseti(L, tbl, ++i);
        }
        
        lua_settop(L, tbl); // push table to top of stack
        return 1;
    }

    /**
     * Returns a table with totem categories IDs [SpellEntry].
     *
     * @return table totemCategory
     */
    int GetTotemCategory(lua_State* L, SpellEntry* entry)
    {
        lua_newtable(L);
        int tbl = lua_gettop(L);
        uint32 i = 0;

        for (size_t index = 0; index < entry->TotemCategory.size(); ++index)
        {
            Eluna::Push(L, entry->TotemCategory[index]);
            lua_rawseti(L, tbl, ++i);
        }
        
        lua_settop(L, tbl); // push table to top of stack
        return 1;
    }

    int GetAreaGroupId(lua_State* L, SpellEntry* entry)
    {
        Eluna::Push(L, entry->AreaGroupId);
        return 1;
    }

    /**
     * Returns the school mask of [SpellEntry].
     *
     * @return uint32 schoolMask : bitmask, returned as uint32.
     */
    int GetSchoolMask(lua_State* L, SpellEntry* entry)
    {
        Eluna::Push(L, entry->SchoolMask);
        return 1;
    }

    /**
     * Returns the rune cost id for the [SpellEntry].
     *
     * @return uint32 runeCostId
     */
    int GetRuneCostID(lua_State* L, SpellEntry* entry)
    {
        Eluna::Push(L, entry->RuneCostID);
        return 1;
    }

    /**
     * Returns a table with all effect bonus multiplier values [SpellEntry].
     *
     * @return table effectBonusMultipliers
     */
    int GetEffectBonusMultiplier(lua_State* L, SpellEntry* entry)
    {
        lua_newtable(L);
        int tbl = lua_gettop(L);
        uint32 i = 0;

        for (size_t index = 0; index < entry->EffectBonusMultiplier.size(); ++index)
        {
            Eluna::Push(L, entry->EffectBonusMultiplier[index]);
            lua_rawseti(L, tbl, ++i);
        }
        
        lua_settop(L, tbl); // push table to top of stack
        return 1;
    }
}

#endif


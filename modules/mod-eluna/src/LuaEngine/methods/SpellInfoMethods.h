/*
* Copyright (C) 2010 - 2024 Eluna Lua Engine <https://forgeluaengine.github.io/>
* This program is free software licensed under GPL version 3
* Please see the included DOCS/LICENSE.md for more information
*/

#ifndef SPELLINFOMETHODS_H
#define SPELLINFOMETHODS_H

namespace LuaSpellInfo
{

    /**
     * Returns the name of the [SpellInfo]
     *
     * <pre>
     * enum LocaleConstant
     * {
     *     LOCALE_enUS = 0,
     *     LOCALE_koKR = 1,
     *     LOCALE_frFR = 2,
     *     LOCALE_deDE = 3,
     *     LOCALE_zhCN = 4,
     *     LOCALE_zhTW = 5,
     *     LOCALE_esES = 6,
     *     LOCALE_esMX = 7,
     *     LOCALE_ruRU = 8
     * };
     * </pre>
     *
     * @param [LocaleConstant] locale = DEFAULT_LOCALE : locale to return the [SpellInfo]'s name
     * @return [string] name
     */
    int GetName(lua_State* L, SpellInfo* spell_info)
    {
        uint8 locale = Eluna::CHECKVAL<uint8>(L, 2, DEFAULT_LOCALE);
        Eluna::Push(L, spell_info->SpellName[static_cast<LocaleConstant>(locale)]);
        return 1;
    }
    
    /**
     * Checks if the [SpellInfo] has a specific attribute.
     *
     * Attributes are characteristics or properties that spells can possess.
     * Attributes are divided into different categories (from 0 to 8 in this context).
     *
     * Here is how each attribute is inspected:
     * 
     * <pre>
     * 0 : SpellAttr0
     * 1 : SpellAttr1
     * 2 : SpellAttr2
     * 3 : SpellAttr3
     * 4 : SpellAttr4
     * 5 : SpellAttr5
     * 6 : SpellAttr6
     * 7 : SpellAttr7
     * -1 : SpellCustomAttributes
     * </pre>
     *
     * @param [int8] attributeType : the type of the attribute.
     * @param [uint32] attribute : the specific attribute to check.
     * @return [bool] has_attribute
     */
    int HasAttribute(lua_State* L, SpellInfo* spell_info)
    {
        int8 attributeType = Eluna::CHECKVAL<int8>(L, 2);
        uint32 attribute    = Eluna::CHECKVAL<uint32>(L, 3);

        bool hasAttribute = false;
        if ( attributeType == -1 ) {
            hasAttribute = spell_info->HasAttribute(static_cast<SpellCustomAttributes>(attribute));           ;
        }else{
            switch(attributeType)
            {
                case 0:
                    hasAttribute = spell_info->HasAttribute(static_cast<SpellAttr0>(attribute));
                    break;
                case 1:
                    hasAttribute = spell_info->HasAttribute(static_cast<SpellAttr1>(attribute));
                    break;
                case 2:
                    hasAttribute = spell_info->HasAttribute(static_cast<SpellAttr2>(attribute));
                    break;
                case 3:
                    hasAttribute = spell_info->HasAttribute(static_cast<SpellAttr3>(attribute));
                    break;
                case 4:
                    hasAttribute = spell_info->HasAttribute(static_cast<SpellAttr4>(attribute));
                    break;
                case 5:
                    hasAttribute = spell_info->HasAttribute(static_cast<SpellAttr5>(attribute));
                    break;
                case 6:
                    hasAttribute = spell_info->HasAttribute(static_cast<SpellAttr6>(attribute));
                    break;
                case 7:
                    hasAttribute = spell_info->HasAttribute(static_cast<SpellAttr7>(attribute));
                    break;
                case -1:
                    break;
            }
        }

        Eluna::Push(L, hasAttribute);
        return 1;
    }
    
    /**
     * Retrieves the attributes of the [SpellInfo] based on the attribute type.
     *
     * Attributes are properties or traits of a spell. There are different categories (0 to 8 in this case) of attributes.
     *
     * How each type of attribute is extracted:
     *
     * <pre>
     * 0 : Attributes
     * 1 : AttributesEx
     * 2 : AttributesEx2
     * 3 : AttributesEx3
     * 4 : AttributesEx4
     * 5 : AttributesEx5
     * 6 : AttributesEx6
     * 7 : AttributesEx7
     * -1 : AttributesCu
     * </pre>
     *
     * @param [int8] attributeType : The type of the attribute.
     * @return [uint32] attributes
     */
    int GetAttributes(lua_State* L, SpellInfo* spell_info)
    {
        int8 attributeType = Eluna::CHECKVAL<int8>(L, 2);
        uint32 attributes;

        if ( attributeType == -1 ) {
            attributes = spell_info->AttributesCu;
        }
        else {
            switch(attributeType)
            {
                case 0:
                    attributes = spell_info->Attributes;
                    break;
                case 1:
                    attributes = spell_info->AttributesEx;
                    break;
                case 2:
                    attributes = spell_info->AttributesEx2;
                    break;
                case 3:
                    attributes = spell_info->AttributesEx3;
                    break;
                case 4:
                    attributes = spell_info->AttributesEx4;
                    break;
                case 5:
                    attributes = spell_info->AttributesEx5;
                    break;
                case 6:
                    attributes = spell_info->AttributesEx6;
                    break;
                case 7:
                    attributes = spell_info->AttributesEx7;
                    break;
            }
        }

        Eluna::Push(L, attributes);
        return 1;
    }
    
    /**
     * Determines whether the [SpellInfo] affects an area (AOE - Area of Effect)
     *
     * The affected area will depend upon the specifics of the spell.
     * A target can be an individual unit, player, or an area, and the spellInfo stores these details.
     * 
     * The function checks the spell's attributes to determine if the spell is designed to affect an area or not.
     * The outcome relies on spell's attributes field.
     * 
     * @return [bool] is_affecting_area
     */
    int IsAffectingArea(lua_State* L, SpellInfo* spell_info)
    {
        Eluna::Push(L, spell_info->IsAffectingArea());
        return 1;
    }
    
    /**
     * Retrieves the category of the [SpellInfo].
     *
     * A spell's category is a way of grouping similar spells together.
     * It might define the spell's nature or its effect. 
     * For instance, damage spells, heal spells, and crowd-control spells might each have a different category.
     *
     * @return [uint32] category
     */
    int GetCategory(lua_State* L, SpellInfo* spell_info)
    {
        Eluna::Push(L, spell_info->GetCategory());
        return 1;
    }
    
    /**
     * Checks if the [SpellInfo] has a specific effect.
     *
     * A spell can have various effects such as damage, healing, or status changes.
     * These effects are identified by a predefined set of constants represented by the 'SpellEffects' enumeration.
     *
     * @param [uint8] effect : The specific effect to check.
     * @return [bool] has_effect 
     */
    int HasEffect(lua_State* L, SpellInfo* spell_info)
    {
        uint8 effect = Eluna::CHECKVAL<uint8>(L, 2);
        Eluna::Push(L, spell_info->HasEffect(static_cast<SpellEffects>(effect)));
        return 1;
    }
    
    /**
     * Checks if the [SpellInfo] has a specific aura.
     *
     * An aura represents a status change or modification due to a spell or ability. 
     * These auras are identified by a predefined set of constants represented by the 'AuraType' enumeration.
     *
     * @param [uint32] aura : The specific aura to check.
     * @return [bool] has_aura
     */
    int HasAura(lua_State* L, SpellInfo* spell_info)
    {
        uint32 aura = Eluna::CHECKVAL<uint32>(L, 2);
        Eluna::Push(L, spell_info->HasAura(static_cast<AuraType>(aura)));
        return 1;
    }
    
    /**
     * Checks if the [SpellInfo] has an area aura effect.
     *
     * Area aura is a type of spell effect that affects multiple targets within a certain area.
     * 
     * @return [bool] has_area_aura_effect
     */
    int HasAreaAuraEffect(lua_State* L, SpellInfo* spell_info)
    {
        Eluna::Push(L, spell_info->HasAreaAuraEffect());
        return 1;
    }
    
   
    /**
     * Checks if the [SpellInfo] is an explicit discovery.
     *
     * An "explicit discovery" may refer to a spell that is not intuitive or is hidden and must be specifically 
     * discovered by the player through some sort of action or event.
     *
     * @return [bool] is_explicit_discovery
     */
    int IsExplicitDiscovery(lua_State* L, SpellInfo* spell_info)
    {
        Eluna::Push(L, spell_info->IsExplicitDiscovery());
        return 1;
    }

    /**
     * Checks if the [SpellInfo] is related to loot crafting.
     *
     * Loot crafting can refer to the process wherein a player uses collected in-game items (loot)
     * to craft or create new items, abilities, or spells.
     *
     * @return [bool] is_loot_crafting
     */
    int IsLootCrafting(lua_State* L, SpellInfo* spell_info)
    {
        Eluna::Push(L, spell_info->IsLootCrafting());
        return 1;
    }

    /**
     * Checks if the [SpellInfo] is related to a Profession skill or Riding skill.
     *
     * Profession skills may refer to a set of abilities related to a particular trade or activity, such as blacksmithing or alchemy.
     * Riding skills are those related to the ability to ride mounts.
     *
     * @return [bool] is_profression_or_riding
     */
    int IsProfessionOrRiding(lua_State* L, SpellInfo* spell_info)
    {
        Eluna::Push(L, spell_info->IsProfessionOrRiding());
        return 1;
    }

    /**
     * Checks if the [SpellInfo] is related to a profession skill.
     *
     * Profession skills may refer to abilities related to a specific occupation or trade, 
     * such as blacksmithing, alchemy, fishing, etc.
     *
     * @return [bool] is_profession
     */
    int IsProfession(lua_State* L, SpellInfo* spell_info)
    {
        Eluna::Push(L, spell_info->IsProfession());
        return 1;
    }

    /**
     * Checks if the [SpellInfo] is related to a primary profession skill.
     *
     * Primary profession skills usually refer to main occupations or trades of the player character, 
     * such as blacksmithing, alchemy, mining, etc.
     *
     * @return [bool] is_primary_profession
     */
    int IsPrimaryProfession(lua_State* L, SpellInfo* spell_info)
    {
        Eluna::Push(L, spell_info->IsPrimaryProfession());
        return 1;
    }

    /**
     * Checks if the [SpellInfo] represents the first rank of a primary profession skill.
     * 
     * Primary profession skills usually refer to main occupations or trades of the player character. 
     * The first rank typically indicates the introductory level of the profession.
     *
     * @return [bool] is_primary_profession_first_rank
     */
    int IsPrimaryProfessionFirstRank(lua_State* L, SpellInfo* spell_info)
    {
        Eluna::Push(L, spell_info->IsPrimaryProfessionFirstRank());
        return 1;
    }

    /**
     * Checks if the [SpellInfo] represents an ability learned with a profession skill.
     *
     * Certain abilities or skills (like crafting item or gathering materials) 
     * can be learned as part of a profession.
     *
     * @return [bool] is_ability_learned_with_profession
     */
    int IsAbilityLearnedWithProfession(lua_State* L, SpellInfo* spell_info)
    {
        Eluna::Push(L, spell_info->IsAbilityLearnedWithProfession());
        return 1;
    }

    /**
     * Checks if the [SpellInfo] represents an ability of a specific skill type.
     *
     * This function allows checking if a spell or ability belongs to a specific skill type. 
     * The skill type is often represented as an integral value (in this case, uint32), 
     * where each value may correspond to a different skill category such as crafting, combat, magic, etc.
     *
     * @param [uint32] skillType: The skill type to check against. Should be an integral value representing the skill type.
     * @return [bool] is_ability_of_skill_type
     */
    int IsAbilityOfSkillType(lua_State* L, SpellInfo* spell_info)
    {
        uint32 skillType = Eluna::CHECKVAL<uint32>(L, 2);
        Eluna::Push(L, spell_info->IsAbilityOfSkillType(skillType));
        return 1;
    }

    /**
     * Determines if the [SpellInfo] represents a spell or ability that targets an area.
     *
     * Spells or abilities that target an area are typically designed to affect multiple targets within a specified range.
     *
     * @return [bool] is_targeting_area
     */
    int IsTargetingArea(lua_State* L, SpellInfo* spell_info)
    {
        Eluna::Push(L, spell_info->IsTargetingArea());
        return 1;
    }

    /**
     * Checks if the [SpellInfo] requires an explicit unit target.
     *
     * Certain spells or abilities can only be cast or used when a specific unit (like a player character, NPC, or enemy) is targeted. 
     * This function checks if the spell or ability represented by [SpellInfo] has this requirement.
     *
     * @return [bool] needs_explicit_unit_target
     */
    int NeedsExplicitUnitTarget(lua_State* L, SpellInfo* spell_info)
    {
        Eluna::Push(L, spell_info->NeedsExplicitUnitTarget());
        return 1;
    }

    /**
     * Checks if the [SpellInfo] requires to be triggered by the caster of another specified spell.
     *
     * Certain spells or abilities can only be activated or become effective when they are triggered by the caster 
     * of another specific spell (the triggeringSpell). This function examines if the spell or ability represented 
     * by [SpellInfo] has such requirement.
     *
     * @param triggeringSpell The spell by the casting of which the ability or spell represented by [SpellInfo] is triggered.
     * @return [bool] needs_to_be_triggered_by_caster
     */
    int NeedsToBeTriggeredByCaster(lua_State* L, SpellInfo* spell_info)
    {
        const SpellInfo* triggeringSpell = Eluna::CHECKOBJ<SpellInfo>(L, 2);
        Eluna::Push(L, spell_info->NeedsToBeTriggeredByCaster(triggeringSpell));
        return 1;
    }

    /**
     * Checks if the [SpellInfo] represents a self-casting spell or ability.
     *
     * Self-casting spells or abilities are those that the casters use on themselves. This can include 
     * defensive spells, healing spells, buffs, or any other type of effect that a player character or 
     * NPC applies on themselves.
     *
     * @return [bool] is_self_cast
     */
    int IsSelfCast(lua_State* L, SpellInfo* spell_info)
    {
        Eluna::Push(L, spell_info->IsSelfCast());
        return 1;
    }

    /**
     * Checks if the [SpellInfo] represents a passive spell or ability.
     *
     * Passive spells or abilities are those that are always in effect, without the need for the player or 
     * NPC to manually activate them. They usually provide their bonus or effect as long as certain conditions are met.
     *
     * @return [bool] is_passive
     */
    int IsPassive(lua_State* L, SpellInfo* spell_info)
    {
        Eluna::Push(L, spell_info->IsPassive());
        return 1;
    }

    /**
     * Checks if the [SpellInfo] represents a spell or ability that can be set to autocast.
     *
     * Autocasting is a feature that allows certain abilities or spells to be cast automatically by the game's 
     * AI when certain conditions are met. This function checks if the spell or ability represented by [SpellInfo] 
     * can be set to autocast.
     *
     * @return [bool] is_autocastable
     */
    int IsAutocastable(lua_State* L, SpellInfo* spell_info)
    {
        Eluna::Push(L, spell_info->IsAutocastable());
        return 1;
    }

    /**
     * Determines if the [SpellInfo] represents a spell or ability that stack with different ranks.
     *
     * Some spells or abilities can accumulate or "stack" their effects with multiple activations 
     * and these effects can sometimes vary based on the rank or level of the spell. This function checks 
     * if the spell represented by [SpellInfo] has this capacity.
     *
     * @return [bool] is_stackable_with_ranks
     */
    int IsStackableWithRanks(lua_State* L, SpellInfo* spell_info)
    {
        Eluna::Push(L, spell_info->IsStackableWithRanks());
        return 1;
    }

    /**
     * Checks if the [SpellInfo] represents a passive spell or ability that is stackable with different ranks.
     *
     * Some passive spells or abilities are designed to stack their effects with multiple activations, and these effects 
     * can also vary depending on the rank of the spell. This function assesses whether the spell or ability represented 
     * by [SpellInfo] has this property.
     *
     * @return [bool] is_passive_stackable_with_ranks
     */
    int IsPassiveStackableWithRanks(lua_State* L, SpellInfo* spell_info)
    {
        Eluna::Push(L, spell_info->IsPassiveStackableWithRanks());
        return 1;
    }

    /**
     * Checks if the [SpellInfo] represents a multi-slot aura spell or effect.
     *
     * A multi-slot aura is one that takes up more than one slot or position in the game's effect array or system. 
     * This function checks if the spell or ability represented by [SpellInfo] has this property.
     *
     * @return [bool] is_multi_slot_aura
     */
    int IsMultiSlotAura(lua_State* L, SpellInfo* spell_info)
    {
        Eluna::Push(L, spell_info->IsMultiSlotAura());
        return 1;
    }

    /**
     * Returns a boolean indicating whether the cooldown has started on the event associated with the [SpellInfo]
     *
     * @return [bool] is_cooldown_started_on_event
     */
    int IsCooldownStartedOnEvent(lua_State* L, SpellInfo* spell_info)
    {
        Eluna::Push(L, spell_info->IsCooldownStartedOnEvent());
        return 1;
    }

    /**
     * Returns a boolean indicating whether the death is persistent for the given [SpellInfo]
     *
     * @return [bool] is_death_persistant
     */
    int IsDeathPersistent(lua_State* L, SpellInfo* spell_info)
    {
        Eluna::Push(L, spell_info->IsDeathPersistent());
        return 1;
    }

    /**
     * Returns a boolean indicating whether the [SpellInfo] requires a dead target
     *
     * @return [bool] : true if the [SpellInfo] requires a dead target; false otherwise
     */
    int IsRequiringDeadTarget(lua_State* L, SpellInfo* spell_info)
    {
        Eluna::Push(L, spell_info->IsRequiringDeadTarget());
        return 1;
    }

    int IsAllowingDeadTarget(lua_State* L, SpellInfo* spell_info)
    {
        Eluna::Push(L, spell_info->IsAllowingDeadTarget());
        return 1;
    }

    int CanBeUsedInCombat(lua_State* L, SpellInfo* spell_info)
    {
        Eluna::Push(L, spell_info->CanBeUsedInCombat());
        return 1;
    }

    int IsPositive(lua_State* L, SpellInfo* spell_info)
    {
        Eluna::Push(L, spell_info->IsPositive());
        return 1;
    }

    int IsPositiveEffect(lua_State* L, SpellInfo* spell_info)
    {
        uint8 effIndex = Eluna::CHECKVAL<uint32>(L, 2);
        Eluna::Push(L, spell_info->IsPositiveEffect(effIndex));
        return 1;
    }

    int IsChanneled(lua_State* L, SpellInfo* spell_info)
    {
        Eluna::Push(L, spell_info->IsChanneled());
        return 1;
    }

    int NeedsComboPoints(lua_State* L, SpellInfo* spell_info)
    {
        Eluna::Push(L, spell_info->NeedsComboPoints());
        return 1;
    }

    int IsBreakingStealth(lua_State* L, SpellInfo* spell_info)
    {
        Eluna::Push(L, spell_info->IsBreakingStealth());
        return 1;
    }

    int IsRangedWeaponSpell(lua_State* L, SpellInfo* spell_info)
    {
        Eluna::Push(L, spell_info->IsRangedWeaponSpell());
        return 1;
    }

    int IsAutoRepeatRangedSpell(lua_State* L, SpellInfo* spell_info)
    {
        Eluna::Push(L, spell_info->IsAutoRepeatRangedSpell());
        return 1;
    }  

    
    int IsAffectedBySpellMods(lua_State* L, SpellInfo* spell_info)
    {
        Eluna::Push(L, spell_info->IsAffectedBySpellMods());
        return 1;
    }
    
    /*  int IsAffectedBySpellMod(lua_State* L, SpellInfo* spell_info)
        {
            const SpellInfo* auraSpellInfo = Eluna::CHECKOBJ<SpellInfo>(L, 2);
            Eluna::Push(L, spell_info->IsAffectedBySpellMod(auraSpellInfo));
            return 1;
        }
    */
    
    int CanPierceImmuneAura(lua_State* L, SpellInfo* spell_info)
    {
        const SpellInfo* auraSpellInfo = Eluna::CHECKOBJ<SpellInfo>(L, 2);
        Eluna::Push(L, spell_info->CanPierceImmuneAura(auraSpellInfo));
        return 1;
    }
    
    int CanDispelAura(lua_State* L, SpellInfo* spell_info)
    {
        const SpellInfo* auraSpellInfo = Eluna::CHECKOBJ<SpellInfo>(L, 2);
        Eluna::Push(L, spell_info->CanDispelAura(auraSpellInfo));
        return 1;
    }
    
    int IsSingleTarget(lua_State* L, SpellInfo* spell_info)
    {
        Eluna::Push(L, spell_info->IsSingleTarget());
        return 1;
    }
    
    int IsAuraExclusiveBySpecificWith(lua_State* L, SpellInfo* spell_info)
    {
        const SpellInfo* spellInfo = Eluna::CHECKOBJ<SpellInfo>(L, 2);
        Eluna::Push(L, spell_info->IsAuraExclusiveBySpecificWith(spellInfo));
        return 1;
    }
    
    int IsAuraExclusiveBySpecificPerCasterWith(lua_State* L, SpellInfo* spell_info)
    {
        const SpellInfo* spellInfo = Eluna::CHECKOBJ<SpellInfo>(L, 2);
        Eluna::Push(L, spell_info->IsAuraExclusiveBySpecificPerCasterWith(spellInfo));
        return 1;
    }
    
    int CheckShapeshift(lua_State* L, SpellInfo* spell_info)
    {
        uint32 form = Eluna::CHECKVAL<uint32>(L, 2);
        Eluna::Push(L, spell_info->CheckShapeshift(form));
        return 1;
    }
    
    int CheckLocation(lua_State* L, SpellInfo* spell_info)
    {
        uint32 map_id = Eluna::CHECKVAL<uint32>(L, 2);
        uint32 zone_id = Eluna::CHECKVAL<uint32>(L, 3);
        uint32 area_id = Eluna::CHECKVAL<uint32>(L, 4);
        Player* player = Eluna::CHECKOBJ<Player>(L, 5);
        bool strict = Eluna::CHECKVAL<bool>(L, 6, false);

        Eluna::Push(L, spell_info->CheckLocation(map_id, zone_id, area_id, player, strict));
        return 1;
    }
    
    int CheckTarget(lua_State* L, SpellInfo* spell_info)
    {
        const Unit* caster = Eluna::CHECKOBJ<Unit>(L, 2);
        const WorldObject* target = Eluna::CHECKOBJ<WorldObject>(L, 3);
        bool implicit = Eluna::CHECKVAL<bool>(L, 4, true);

        Eluna::Push(L, spell_info->CheckTarget(caster, target, implicit));
        return 1;
    }
    
    int CheckExplicitTarget(lua_State* L, SpellInfo* spell_info)
    {
        const Unit* caster = Eluna::CHECKOBJ<Unit>(L, 2);
        const WorldObject* target = Eluna::CHECKOBJ<WorldObject>(L, 3);
        const Item* item = Eluna::CHECKOBJ<Item>(L, 4, true);

        Eluna::Push(L, spell_info->CheckExplicitTarget(caster, target, item));
        return 1;
    }
    
    int CheckTargetCreatureType(lua_State* L, SpellInfo* spell_info)
    {
        const Unit* target = Eluna::CHECKOBJ<Unit>(L, 2);

        Eluna::Push(L, spell_info->CheckTargetCreatureType(target));
        return 1;
    }
    
    int GetSchoolMask(lua_State* L, SpellInfo* spell_info)
    {
        Eluna::Push(L, spell_info->GetSchoolMask());
        return 1;
    }
    
    int GetAllEffectsMechanicMask(lua_State* L, SpellInfo* spell_info)
    {
        Eluna::Push(L, spell_info->GetAllEffectsMechanicMask());
        return 1;
    }
    
    int GetEffectMechanicMask(lua_State* L, SpellInfo* spell_info)
    {
        uint32 effIndex = Eluna::CHECKVAL<uint32>(L, 2);
        
        Eluna::Push(L, spell_info->GetEffectMechanicMask(static_cast<SpellEffIndex>(effIndex)));
        return 1;
    }
    
    int GetSpellMechanicMaskByEffectMask(lua_State* L, SpellInfo* spell_info)
    {
        uint32 effectmask = Eluna::CHECKVAL<uint32>(L, 2);

        Eluna::Push(L, spell_info->GetSpellMechanicMaskByEffectMask(effectmask));
        return 1;
    }
    
    int GetEffectMechanic(lua_State* L, SpellInfo* spell_info)
    {
        uint32 effIndex = Eluna::CHECKVAL<uint32>(L, 2);

        Eluna::Push(L, spell_info->GetEffectMechanic(static_cast<SpellEffIndex>(effIndex)));
        return 1;
    }
    
    int GetDispelMask(lua_State* L, SpellInfo* spell_info)
    {
        uint32 type = Eluna::CHECKVAL<uint32>(L, 2, false);

        Eluna::Push(L, type != 0 ? spell_info->GetDispelMask(static_cast<DispelType>(type)) : spell_info->GetDispelMask());
        return 1;
    }
    
    int GetExplicitTargetMask(lua_State* L, SpellInfo* spell_info)
    {
        Eluna::Push(L, spell_info->GetExplicitTargetMask());
        return 1;
    }
    
    int GetAuraState(lua_State* L, SpellInfo* spell_info)
    {
        Eluna::Push(L, spell_info->GetAuraState());
        return 1;
    }
    
    int GetSpellSpecific(lua_State* L, SpellInfo* spell_info)
    {
        Eluna::Push(L, spell_info->GetSpellSpecific());
        return 1;
    }
}
#endif


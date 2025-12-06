#include "ABUnitScript.h"

#include "ABConfig.h"
#include "ABCreatureInfo.h"
#include "ABMapInfo.h"
#include "ABUtils.h"

void AutoBalance_UnitScript::ModifyPeriodicDamageAurasTick(Unit* target, Unit* source, uint32& amount, SpellInfo const* spellInfo)
{
    // if the spell is negative (damage), we need to flip the sign
    // if the spell is positive (healing or other) we keep it the same
    int32 adjustedAmount = !spellInfo->IsPositive() ? amount * -1 : amount;

    // only debug if the source or target is a player
    bool _debug_damage_and_healing = ((source && (source->GetTypeId() == TYPEID_PLAYER || source->IsControlledByPlayer())) || (target && target->GetTypeId() == TYPEID_PLAYER));
    _debug_damage_and_healing = (source && source->GetMap()->GetInstanceId());

    if (_debug_damage_and_healing)
        _Debug_Output("ModifyPeriodicDamageAurasTick", target, source, adjustedAmount, AUTOBALANCE_DAMAGE_HEALING_DEBUG_PHASE_BEFORE, spellInfo->SpellName[0], spellInfo->Id);

    // set amount to the absolute value of the function call
    // the provided amount doesn't indicate whether it's a positive or negative value
    adjustedAmount = _Modify_Damage_Healing(target, source, adjustedAmount, spellInfo);
    amount = abs(adjustedAmount);

    if (_debug_damage_and_healing)
        _Debug_Output("ModifyPeriodicDamageAurasTick", target, source, adjustedAmount, AUTOBALANCE_DAMAGE_HEALING_DEBUG_PHASE_AFTER, spellInfo->SpellName[0], spellInfo->Id);
}

void AutoBalance_UnitScript::ModifySpellDamageTaken(Unit* target, Unit* source, int32& amount, SpellInfo const* spellInfo)
{
    // if the spell is negative (damage), we need to flip the sign to negative
    // if the spell is positive (healing or other) we keep it the same (positive)
    int32 adjustedAmount = !spellInfo->IsPositive() ? amount * -1 : amount;

    // only debug if the source or target is a player
    bool _debug_damage_and_healing = ((source && (source->GetTypeId() == TYPEID_PLAYER || source->IsControlledByPlayer())) || (target && target->GetTypeId() == TYPEID_PLAYER));
    _debug_damage_and_healing = (source && source->GetMap()->GetInstanceId());

    if (_debug_damage_and_healing)
        _Debug_Output("ModifySpellDamageTaken", target, source, adjustedAmount, AUTOBALANCE_DAMAGE_HEALING_DEBUG_PHASE_BEFORE, spellInfo->SpellName[0], spellInfo->Id);

    // set amount to the absolute value of the function call
    // the provided amount doesn't indicate whether it's a positive or negative value
    adjustedAmount = _Modify_Damage_Healing(target, source, adjustedAmount, spellInfo);
    amount = abs(adjustedAmount);

    if (_debug_damage_and_healing)
        _Debug_Output("ModifySpellDamageTaken", target, source, adjustedAmount, AUTOBALANCE_DAMAGE_HEALING_DEBUG_PHASE_AFTER, spellInfo->SpellName[0], spellInfo->Id);
}

void AutoBalance_UnitScript::ModifyMeleeDamage(Unit* target, Unit* source, uint32& amount)
{
    // melee damage is always negative, so we need to flip the sign to negative
    int32 adjustedAmount = amount * -1;

    // only debug if the source or target is a player
    bool _debug_damage_and_healing = ((source && (source->GetTypeId() == TYPEID_PLAYER || source->IsControlledByPlayer())) || (target && target->GetTypeId() == TYPEID_PLAYER));
    _debug_damage_and_healing = (source && source->GetMap()->GetInstanceId());

    if (_debug_damage_and_healing)
        _Debug_Output("ModifyMeleeDamage", target, source, adjustedAmount, AUTOBALANCE_DAMAGE_HEALING_DEBUG_PHASE_BEFORE, "Melee");

    // set amount to the absolute value of the function call
    adjustedAmount = _Modify_Damage_Healing(target, source, adjustedAmount);
    amount = abs(adjustedAmount);

    if (_debug_damage_and_healing)
        _Debug_Output("ModifyMeleeDamage", target, source, adjustedAmount, AUTOBALANCE_DAMAGE_HEALING_DEBUG_PHASE_AFTER, "Melee");
}

void AutoBalance_UnitScript::ModifyHealReceived(Unit* target, Unit* source, uint32& amount, SpellInfo const* spellInfo)
{
    // healing is always positive, no need for any sign flip

    // only debug if the source or target is a player
    bool _debug_damage_and_healing = ((source && (source->GetTypeId() == TYPEID_PLAYER || source->IsControlledByPlayer())) || (target && target->GetTypeId() == TYPEID_PLAYER));
    _debug_damage_and_healing = (source && source->GetMap()->GetInstanceId());

    if (_debug_damage_and_healing)
        _Debug_Output("ModifyHealReceived", target, source, amount, AUTOBALANCE_DAMAGE_HEALING_DEBUG_PHASE_BEFORE, spellInfo->SpellName[0], spellInfo->Id);

    amount = _Modify_Damage_Healing(target, source, amount, spellInfo);

    if (_debug_damage_and_healing)
        _Debug_Output("ModifyHealReceived", target, source, amount, AUTOBALANCE_DAMAGE_HEALING_DEBUG_PHASE_AFTER, spellInfo->SpellName[0], spellInfo->Id);
}

void AutoBalance_UnitScript::OnAuraApply(Unit* unit, Aura* aura)
{
    // only debug if the source or target is a player
    bool _debug_damage_and_healing = (unit && unit->GetTypeId() == TYPEID_PLAYER);
    _debug_damage_and_healing = (unit && unit->GetMap()->GetInstanceId());

    // Only if this aura has a duration
    if (aura && (aura->GetDuration() > 0 || aura->GetMaxDuration() > 0))
    {
        uint32 auraDuration = _Modifier_CCDuration(unit, aura->GetCaster(), aura);

        // only update if we decided to change it
        if (auraDuration != (float)aura->GetDuration())
        {
            if (_debug_damage_and_healing)
                LOG_DEBUG("module.AutoBalance_DamageHealingCC", "AutoBalance_UnitScript::OnAuraApply(): Spell '{}' had it's duration adjusted ({}->{}).",
                aura->GetSpellInfo()->SpellName[0],
                aura->GetMaxDuration() / 1000,
                auraDuration / 1000
            );

            aura->SetMaxDuration(auraDuration);
            aura->SetDuration(auraDuration);
        }
    }
}

void AutoBalance_UnitScript::_Debug_Output(std::string function_name, Unit* target, Unit* source, int32 amount, Damage_Healing_Debug_Phase phase, std::string spell_name, uint32 spell_id)
{
    if (phase == AUTOBALANCE_DAMAGE_HEALING_DEBUG_PHASE_BEFORE)
    {
        LOG_DEBUG("module.AutoBalance_DamageHealingCC", "AutoBalance:: ------------------------------------------------");
    }

    if (target && source && amount)
    {
        LOG_DEBUG("module.AutoBalance_DamageHealingCC", "AutoBalance_UnitScript::{}: {}: {}{} {} {}{} with {}{} for ({})",
            function_name,
            phase ? "AFTER" : "BEFORE",
            source->GetName(),
            source->GetEntry() ? " (" + std::to_string(source->GetEntry()) + ")" : "",
            amount > 0 ? "heals" : "damages",
            target->GetName(),
            target->GetEntry() ? " (" + std::to_string(target->GetEntry()) + ")" : "",
            spell_name,
            spell_id ? " (" + std::to_string(spell_id) + ")" : "",
            amount
        );
    }
    else if (target && source)
    {
        LOG_DEBUG("module.AutoBalance_DamageHealingCC", "AutoBalance_UnitScript::{}: {}: {}{} damages {}{} with {}{} for (0)",
            function_name,
            phase ? "AFTER" : "BEFORE",
            source->GetName(),
            source->GetEntry() ? " (" + std::to_string(source->GetEntry()) + ")" : "",
            target->GetName(),
            target->GetEntry() ? " (" + std::to_string(target->GetEntry()) + ")" : "",
            spell_name,
            spell_id ? " (" + std::to_string(spell_id) + ")" : ""
        );
    }
    else if (target && amount)
    {
        LOG_DEBUG("module.AutoBalance_DamageHealingCC", "AutoBalance_UnitScript::{}: {}: ?? {} {}{} with {}{} for ({})",
            function_name,
            phase ? "AFTER" : "BEFORE",
            amount > 0 ? "heals" : "damages",
            target->GetName(),
            target->GetEntry() ? " (" + std::to_string(target->GetEntry()) + ")" : "",
            spell_name,
            spell_id ? " (" + std::to_string(spell_id) + ")" : "",
            amount
        );
    }
    else if (target)
    {
        LOG_DEBUG("module.AutoBalance_DamageHealingCC", "AutoBalance_UnitScript::{}: {}: ?? affects {}{} with {}{}",
            function_name,
            phase ? "AFTER" : "BEFORE",
            target->GetName(),
            target->GetEntry() ? " (" + std::to_string(target->GetEntry()) + ")" : "",
            spell_name,
            spell_id ? " (" + std::to_string(spell_id) + ")" : ""
        );
    }
    else
    {
        LOG_DEBUG("module.AutoBalance_DamageHealingCC", "AutoBalance_UnitScript::{}: {}: W? T? F? with {}{}",
            function_name,
            phase ? "AFTER" : "BEFORE",
            spell_name,
            spell_id ? " (" + std::to_string(spell_id) + ")" : ""
        );
    }
}

int32 AutoBalance_UnitScript::_Modify_Damage_Healing(Unit* target, Unit* source, int32 amount, SpellInfo const* spellInfo)
{
    //
    // Pre-flight Checks
    //

    // only debug if the source or target is a player
    bool _debug_damage_and_healing = ((source && (source->GetTypeId() == TYPEID_PLAYER || source->IsControlledByPlayer())) || (target && target->GetTypeId() == TYPEID_PLAYER));
    _debug_damage_and_healing = (source && source->GetMap()->GetInstanceId());

    // check that we're enabled globally, else return the original value
    if (!EnableGlobal)
    {
        if (_debug_damage_and_healing)
            LOG_DEBUG("module.AutoBalance_DamageHealingCC", "AutoBalance_UnitScript::_Modify_Damage_Healing: EnableGlobal is false, returning original value of ({}).", amount);

        return amount;
    }

    // if the source is gone (logged off? despawned?), use the same target and source.
    // hacky, but better than crashing or having the damage go to 1.0x
    if (!source)
    {
        if (_debug_damage_and_healing)
            LOG_DEBUG("module.AutoBalance_DamageHealingCC", "AutoBalance_UnitScript::_Modify_Damage_Healing: Source is null, using target as source.");

        source = target;
    }

    // make sure the source and target are in an instance, else return the original damage
    if (!(source->GetMap()->IsDungeon() && target->GetMap()->IsDungeon()))
    {
        //if (_debug_damage_and_healing)
        //    LOG_DEBUG("module.AutoBalance_DamageHealingCC", "AutoBalance_UnitScript::_Modify_Damage_Healing: Not in an instance, returning original value of ({}).", amount);

        return amount;
    }

    // make sure that the source is in the world, else return the original value
    if (!source->IsInWorld())
    {
        if (_debug_damage_and_healing)
            LOG_DEBUG("module.AutoBalance_DamageHealingCC", "AutoBalance_UnitScript::_Modify_Damage_Healing: Source does not exist in the world, returning original value of ({}).", amount);

        return amount;
    }

    // if the spell ID is in our "never modify" list, return the original value
    if
        (
            spellInfo &&
            spellInfo->Id &&
            std::find
            (
                spellIdsToNeverModify.begin(),
                spellIdsToNeverModify.end(),
                spellInfo->Id
            ) != spellIdsToNeverModify.end()
            )
    {
        if (_debug_damage_and_healing)
            LOG_DEBUG("module.AutoBalance_DamageHealingCC", "AutoBalance_UnitScript::_Modify_Damage_Healing: Spell {}({}) is in the never modify list, returning original value of ({}).",
                spellInfo->SpellName[0],
                spellInfo->Id,
                amount
            );

        return amount;
    }

    // get the maps' info
    AutoBalanceMapInfo* sourceMapABInfo = GetMapInfo(source->GetMap());
    AutoBalanceMapInfo* targetMapABInfo = GetMapInfo(target->GetMap());

    // if either the target or the source's maps are not enabled, return the original damage
    if (!sourceMapABInfo->enabled || !targetMapABInfo->enabled)
    {
        if (_debug_damage_and_healing)
            LOG_DEBUG("module.AutoBalance_DamageHealingCC", "AutoBalance_UnitScript::_Modify_Damage_Healing: Source or Target's map is not enabled, returning original value of ({}).", amount);

        return amount;
    }

    //
    // Source and Target Checking
    //

    // if the source is a player and they are healing themselves, return the original value
    if (source->GetTypeId() == TYPEID_PLAYER && source->GetGUID() == target->GetGUID() && amount >= 0)
    {
        if (_debug_damage_and_healing)
            LOG_DEBUG("module.AutoBalance_DamageHealingCC", "AutoBalance_UnitScript::_Modify_Damage_Healing: Source is a player that is self-healing, returning original value of ({}).", amount);

        return amount;
    }
    // if the source is a player and they are damaging themselves, log to debug but continue
    else if (source->GetTypeId() == TYPEID_PLAYER && source->GetGUID() == target->GetGUID() && amount < 0)
    {
        // if the spell used is in our list of spells to ignore, return the original value
        if
            (
                spellInfo &&
                spellInfo->Id &&
                std::find
                (
                    spellIdsThatSpendPlayerHealth.begin(),
                    spellIdsThatSpendPlayerHealth.end(),
                    spellInfo->Id
                ) != spellIdsThatSpendPlayerHealth.end()
                )
        {
            if (_debug_damage_and_healing)
                LOG_DEBUG("module.AutoBalance_DamageHealingCC", "AutoBalance_UnitScript::_Modify_Damage_Healing: Source is a player that is self-damaging with a spell that is ignored, returning original value of ({}).", amount);

            return amount;
        }

        if (_debug_damage_and_healing)
            LOG_DEBUG("module.AutoBalance_DamageHealingCC", "AutoBalance_UnitScript::_Modify_Damage_Healing: Source is a player that is self-damaging, continuing.");
    }
    // if the source is a player and they are damaging unit that is friendly, log to debug but continue
    else if (source->GetTypeId() == TYPEID_PLAYER && target->IsFriendlyTo(source) && amount < 0)
    {
        if (_debug_damage_and_healing)
            LOG_DEBUG("module.AutoBalance_DamageHealingCC", "AutoBalance_UnitScript::_Modify_Damage_Healing: Source is a player that is damaging a friendly unit, continuing.");
    }
    // if the source is a player under any other condition, return the original value
    else if (source->GetTypeId() == TYPEID_PLAYER)
    {
        if (_debug_damage_and_healing)
            LOG_DEBUG("module.AutoBalance_DamageHealingCC", "AutoBalance_UnitScript::_Modify_Damage_Healing: Source is an enemy player, returning original value of ({}).", amount);

        return amount;
    }
    // if the creature is attacking itself with an aura with effect type SPELL_AURA_SHARE_DAMAGE_PCT, return the orginal damage
    else if
        (
            source->GetTypeId() == TYPEID_UNIT &&
            source->GetTypeId() != TYPEID_PLAYER &&
            source->GetGUID() == target->GetGUID() &&
            _isAuraWithEffectType(spellInfo, SPELL_AURA_SHARE_DAMAGE_PCT)
            )
    {
        if (_debug_damage_and_healing)
            LOG_DEBUG("module.AutoBalance_DamageHealingCC", "AutoBalance_UnitScript::_Modify_Damage_Healing: Source is a creature that is self-damaging with an aura that shares damage, returning original value of ({}).", amount);

        return amount;
    }

    // if the source is under the control of the player, return the original damage
    // noteably, this should NOT include mind control targets
    if ((source->IsHunterPet() || source->IsPet() || source->IsSummon()) && source->IsControlledByPlayer())
    {
        if (_debug_damage_and_healing)
            LOG_DEBUG("module.AutoBalance_DamageHealingCC", "AutoBalance_UnitScript::_Modify_Damage_Healing: Source is a player-controlled pet or summon, returning original value of ({}).", amount);

        return amount;
    }

    //
    // Multiplier calculation
    //
    float damageMultiplier = 1.0f;

    // if the source is a player AND the target is that same player AND the value is damage (negative), use the map's multiplier
    if (source->GetTypeId() == TYPEID_PLAYER && source->GetGUID() == target->GetGUID() && amount < 0)
    {
        // if this aura damages based on a percent of the player's max health, use the un-level-scaled multiplier
        if (_isAuraWithEffectType(spellInfo, SPELL_AURA_PERIODIC_DAMAGE_PERCENT))
        {
            damageMultiplier = sourceMapABInfo->worldDamageHealingMultiplier;
            if (_debug_damage_and_healing)
            {
                LOG_DEBUG("module.AutoBalance_DamageHealingCC", "AutoBalance_UnitScript::_Modify_Damage_Healing: Spell damage based on percent of max health. Ignore level scaling.");
                LOG_DEBUG("module.AutoBalance_DamageHealingCC",
                    "AutoBalance_UnitScript::_Modify_Damage_Healing: Source is a player and the target is that same player, using the map's (level-scaling ignored) multiplier: ({})",
                    damageMultiplier
                );
            }
        }
        else
        {
            damageMultiplier = sourceMapABInfo->scaledWorldDamageHealingMultiplier;
            if (_debug_damage_and_healing)
            {
                LOG_DEBUG("module.AutoBalance_DamageHealingCC",
                    "AutoBalance_UnitScript::_Modify_Damage_Healing: Source is a player and the target is that same player, using the map's multiplier: ({})",
                    damageMultiplier
                );
            }
        }
    }
    // if the target is a player AND the value is healing (positive), use the map's damage multiplier
    // (player to player healing was already eliminated in the Source and Target Checking section)
    else if (target->GetTypeId() == TYPEID_PLAYER && amount >= 0)
    {
        damageMultiplier = targetMapABInfo->scaledWorldDamageHealingMultiplier;
        if (_debug_damage_and_healing)
        {
            LOG_DEBUG("module.AutoBalance_DamageHealingCC",
                "AutoBalance_UnitScript::_Modify_Damage_Healing: A non-player is healing a player, using the map's multiplier: ({})",
                damageMultiplier
            );
        }
    }
    // if the target is a player AND the source is not a creature, use the map's multiplier
    else if (target->GetTypeId() == TYPEID_PLAYER && source->GetTypeId() != TYPEID_UNIT && amount < 0)
    {
        // if this aura damages based on a percent of the player's max health, use the un-level-scaled multiplier
        if (_isAuraWithEffectType(spellInfo, SPELL_AURA_PERIODIC_DAMAGE_PERCENT))
        {
            damageMultiplier = targetMapABInfo->worldDamageHealingMultiplier;
            if (_debug_damage_and_healing)
            {
                LOG_DEBUG("module.AutoBalance_DamageHealingCC", "AutoBalance_UnitScript::_Modify_Damage_Healing: Spell damage based on percent of max health. Ignore level scaling.");
                LOG_DEBUG("module.AutoBalance_DamageHealingCC",
                    "AutoBalance_UnitScript::_Modify_Damage_Healing: Target is a player and the source is not a creature, using the map's (level-scaling-ignored) multiplier: ({})",
                    damageMultiplier
                );
            }
        }
        else
        {
            damageMultiplier = targetMapABInfo->scaledWorldDamageHealingMultiplier;
            if (_debug_damage_and_healing)
            {
                LOG_DEBUG("module.AutoBalance_DamageHealingCC",
                    "AutoBalance_UnitScript::_Modify_Damage_Healing: Target is a player and the source is not a creature, using the map's multiplier: ({})",
                    damageMultiplier
                );
            }
        }
    }
    // otherwise, use the source creature's damage multiplier
    else
    {
        // if this aura damages based on a percent of the player's max health, use the un-level-scaled multiplier
        if (_isAuraWithEffectType(spellInfo, SPELL_AURA_PERIODIC_DAMAGE_PERCENT))
        {
            damageMultiplier = source->CustomData.GetDefault<AutoBalanceCreatureInfo>("AutoBalanceCreatureInfo")->DamageMultiplier;
            if (_debug_damage_and_healing)
            {
                LOG_DEBUG("module.AutoBalance_DamageHealingCC", "AutoBalance_UnitScript::_Modify_Damage_Healing: Spell damage based on percent of max health. Ignore level scaling.");
                LOG_DEBUG("module.AutoBalance_DamageHealingCC",
                    "AutoBalance_UnitScript::_Modify_Damage_Healing: Using the source creature's (level-scaling ignored) damage multiplier: ({})",
                    damageMultiplier
                );
            }
        }
        // non percent-based, used the normal multiplier
        else
        {
            damageMultiplier = source->CustomData.GetDefault<AutoBalanceCreatureInfo>("AutoBalanceCreatureInfo")->ScaledDamageMultiplier;
            if (_debug_damage_and_healing)
            {
                LOG_DEBUG("module.AutoBalance_DamageHealingCC",
                    "AutoBalance_UnitScript::_Modify_Damage_Healing: Using the source creature's damage multiplier: ({})",
                    damageMultiplier
                );
            }
        }
    }

    // we are good to go, return the original damage times the multiplier
    if (_debug_damage_and_healing)
        LOG_DEBUG("module.AutoBalance_DamageHealingCC", "AutoBalance_UnitScript::_Modify_Damage_Healing: Returning modified {}: ({}) * ({}) = ({})",
            amount <= 0 ? "damage" : "healing",
            amount,
            damageMultiplier,
            amount * damageMultiplier
        );

    return amount * damageMultiplier;
}

uint32 AutoBalance_UnitScript::_Modifier_CCDuration(Unit* target, Unit* caster, Aura* aura)
{
    // store the original duration of the aura
    float originalDuration = (float)aura->GetDuration();

    // check that we're enabled globally, else return the original duration
    if (!EnableGlobal)
        return originalDuration;

    // ensure that both the target and the caster are defined
    if (!target || !caster)
        return originalDuration;

    // if the aura wasn't cast just now, don't change it
    if (aura->GetDuration() != aura->GetMaxDuration())
        return originalDuration;

    // if the target isn't a player or the caster is a player, return the original duration
    if (!target->IsPlayer() || caster->IsPlayer())
        return originalDuration;

    // make sure we're in an instance, else return the original duration
    if (!(target->GetMap()->IsDungeon() && caster->GetMap()->IsDungeon()))
        return originalDuration;

    // get the current creature's CC duration multiplier
    float ccDurationMultiplier = caster->CustomData.GetDefault<AutoBalanceCreatureInfo>("AutoBalanceCreatureInfo")->CCDurationMultiplier;

    // if it's the default of 1.0, return the original damage
    if (ccDurationMultiplier == 1)
        return originalDuration;

    // if the aura was cast by a pet or summon, return the original duration
    if ((caster->IsHunterPet() || caster->IsPet() || caster->IsSummon()) && caster->IsControlledByPlayer())
        return originalDuration;

    // only if this aura is a CC
    if (
        aura->HasEffectType(SPELL_AURA_MOD_CHARM) ||
        aura->HasEffectType(SPELL_AURA_MOD_CONFUSE) ||
        aura->HasEffectType(SPELL_AURA_MOD_DISARM) ||
        aura->HasEffectType(SPELL_AURA_MOD_FEAR) ||
        aura->HasEffectType(SPELL_AURA_MOD_PACIFY) ||
        aura->HasEffectType(SPELL_AURA_MOD_POSSESS) ||
        aura->HasEffectType(SPELL_AURA_MOD_SILENCE) ||
        aura->HasEffectType(SPELL_AURA_MOD_STUN) ||
        aura->HasEffectType(SPELL_AURA_MOD_SPEED_SLOW_ALL)
        )
    {
        return originalDuration * ccDurationMultiplier;
    }
    else
        return originalDuration;
}

bool AutoBalance_UnitScript::_isAuraWithEffectType(SpellInfo const* spellInfo, AuraType auraType, bool log)
{
    // if the spell is not defined, return false
    if (!spellInfo)
    {
        if (log)
            LOG_DEBUG("module.AutoBalance_DamageHealingCC", "AutoBalance_UnitScript::_isAuraWithEffectType: SpellInfo is null, returning false.");
        return false;
    }

    // if the spell doesn't have any effects, return false
    if (!spellInfo->GetEffects().size())
    {
        if (log)
            LOG_DEBUG("module.AutoBalance_DamageHealingCC", "AutoBalance_UnitScript::_isAuraWithEffectType: SpellInfo has no effects, returning false.");
        return false;
    }

    // iterate through the spell effects
    for (SpellEffectInfo effect : spellInfo->GetEffects())
    {
        // if the effect is not an aura, continue to next effect
        if (!effect.IsAura())
        {
            if (log)
                LOG_DEBUG("module.AutoBalance_DamageHealingCC", "AutoBalance_UnitScript::_isAuraWithEffectType: SpellInfo has an effect that is not an aura, continuing to next effect.");
            continue;
        }

        if (effect.ApplyAuraName == auraType)
        {
            // if the effect is an aura of the target type, return true
            LOG_DEBUG("module.AutoBalance_DamageHealingCC", "AutoBalance_UnitScript::_isAuraWithEffectType: SpellInfo has an aura of the target type, returning true.");
            return true;
        }
    }

    // if no aura effect of type auraType was found, return false
    if (log)
        LOG_DEBUG("module.AutoBalance_DamageHealingCC", "AutoBalance_UnitScript::_isAuraWithEffectType: SpellInfo has no aura of the target type, returning false.");
    return false;
}

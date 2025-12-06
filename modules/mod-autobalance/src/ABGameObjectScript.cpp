#include "ABGameObjectScript.h"

#include "ABConfig.h"
#include "ABMapInfo.h"
#include "ABUtils.h"

void AutoBalance_GameObjectScript::OnGameObjectModifyHealth(GameObject* target, Unit* source, int32& amount, SpellInfo const* spellInfo)
{
    // uncomment to debug this hook
    bool _debug_damage_and_healing = (source && target && (source->GetTypeId() == TYPEID_PLAYER || source->IsControlledByPlayer()));

    if (_debug_damage_and_healing)
        _Debug_Output("OnGameObjectModifyHealth", target, source, amount, "BEFORE:", spellInfo->SpellName[0], spellInfo->Id);

    // modify the amount
    amount = _Modify_GameObject_Damage_Healing(target, source, amount, spellInfo);

    if (_debug_damage_and_healing)
        _Debug_Output("OnGameObjectModifyHealth", target, source, amount, "AFTER:", spellInfo->SpellName[0], spellInfo->Id);
}

void AutoBalance_GameObjectScript::_Debug_Output(std::string function_name, GameObject* target, Unit* source, int32 amount, std::string prefix, std::string spell_name, uint32 spell_id)
{
    if (target && source && amount)
    {
        LOG_DEBUG("module.AutoBalance_DamageHealingCC", "AutoBalance_GameObjectScript::{}: {} {} {} {} ({} - {})",
            function_name,
            prefix,
            source->GetName(),
            amount,
            target->GetName(),
            spell_name,
            spell_id
        );
    }
    else if (target && source)
    {
        LOG_DEBUG("module.AutoBalance_DamageHealingCC", "AutoBalance_GameObjectScript::{}: {} {} 0 {} ({} - {})",
            function_name,
            prefix,
            source->GetName(),
            target->GetName(),
            spell_name,
            spell_id
        );
    }
    else if (target && amount)
    {
        LOG_DEBUG("module.AutoBalance_DamageHealingCC", "AutoBalance_GameObjectScript::{}: {} ?? {} {} ({} - {})",
            function_name,
            prefix,
            amount,
            target->GetName(),
            spell_name,
            spell_id
        );
    }
    else if (target)
    {
        LOG_DEBUG("module.AutoBalance_DamageHealingCC", "AutoBalance_GameObjectScript::{}: {} ?? ?? {} ({} - {})",
            function_name,
            prefix,
            target->GetName(),
            spell_name,
            spell_id
        );
    }
    else
    {
        LOG_DEBUG("module.AutoBalance_DamageHealingCC", "AutoBalance_GameObjectScript::{}: {} W? T? F? ({} - {})",
            function_name,
            prefix,
            spell_name,
            spell_id
        );
    }
}

int32 AutoBalance_GameObjectScript::_Modify_GameObject_Damage_Healing(GameObject* target, Unit* source, int32 amount, SpellInfo const* spellInfo)
{
    //
    // Pre-flight Checks
    //

    // uncomment to debug this function
    bool _debug_damage_and_healing = (source && target && (source->GetTypeId() == TYPEID_PLAYER || source->IsControlledByPlayer()));

    // check that we're enabled globally, else return the original value
    if (!EnableGlobal)
    {
        if (_debug_damage_and_healing)
            LOG_DEBUG("module.AutoBalance_DamageHealingCC", "AutoBalance_GameObjectScript::_Modify_GameObject_Damage_Healing: EnableGlobal is false, returning original value of ({}).", amount);

        return amount;
    }

    // make sure the target is in an instance, else return the original damage
    if (!(target->GetMap()->IsDungeon()))
    {
        if (_debug_damage_and_healing)
            LOG_DEBUG("module.AutoBalance_DamageHealingCC", "AutoBalance_GameObjectScript::_Modify_GameObject_Damage_Healing: Target is not in an instance, returning original value of ({}).", amount);

        return amount;
    }

    // make sure the target is in the world, else return the original value
    if (!target->IsInWorld())
    {
        if (_debug_damage_and_healing)
            LOG_DEBUG("module.AutoBalance_DamageHealingCC", "AutoBalance_GameObjectScript::_Modify_GameObject_Damage_Healing: Target does not exist in the world, returning original value of ({}).", amount);

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

    // get the map's info
    AutoBalanceMapInfo* targetMapABInfo = GetMapInfo(target->GetMap());

    // if the target's map is not enabled, return the original damage
    if (!targetMapABInfo->enabled)
    {
        if (_debug_damage_and_healing)
            LOG_DEBUG("module.AutoBalance_DamageHealingCC", "AutoBalance_GameObjectScript::_Modify_GameObject_Damage_Healing: Target's map is not enabled, returning original value of ({}).", amount);

        return amount;
    }

    //
    // Multiplier calculation
    //

    // calculate the new damage amount using the map's World Health Multiplier
    int32 newAmount = _Calculate_Amount_For_GameObject(target, amount, targetMapABInfo->worldHealthMultiplier);

    if (_debug_damage_and_healing)
        LOG_DEBUG("module.AutoBalance_DamageHealingCC", "AutoBalance_GameObjectScript::_Modify_GameObject_Damage_Healing: Returning modified damage: ({}) -> ({})", amount, newAmount);

    return newAmount;
}

int32 AutoBalance_GameObjectScript::_Calculate_Amount_For_GameObject(GameObject* target, int32 amount, float multiplier)
{
    // since it would be very complicated to reduce the real health of destructible game objects, instead we will
    // adjust the damage to them as though their health were scaled. Damage will usually be dealt by vehicles and
    // other non-player sources, so this effect shouldn't be as noticable as if we applied it to the player.
    uint32 realMaxHealth = target->GetGOValue()->Building.MaxHealth;

    uint32 scaledMaxHealth = realMaxHealth * multiplier;
    float percentDamageOfScaledMaxHealth = (float)amount / (float)scaledMaxHealth;

    uint32 scaledAmount = realMaxHealth * percentDamageOfScaledMaxHealth;

    return scaledAmount;
}

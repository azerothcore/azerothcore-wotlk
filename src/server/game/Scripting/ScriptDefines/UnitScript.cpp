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

#include "UnitScript.h"
#include "ScriptMgr.h"
#include "ScriptMgrMacros.h"

void ScriptMgr::OnHeal(Unit* healer, Unit* reciever, uint32& gain)
{
    CALL_ENABLED_HOOKS(UnitScript, UNITHOOK_ON_HEAL, script->OnHeal(healer, reciever, gain));
}

void ScriptMgr::OnDamage(Unit* attacker, Unit* victim, uint32& damage)
{
    CALL_ENABLED_HOOKS(UnitScript, UNITHOOK_ON_DAMAGE, script->OnDamage(attacker, victim, damage));
}

void ScriptMgr::ModifyPeriodicDamageAurasTick(Unit* target, Unit* attacker, uint32& damage, SpellInfo const* spellInfo)
{
    CALL_ENABLED_HOOKS(UnitScript, UNITHOOK_MODIFY_PERIODIC_DAMAGE_AURAS_TICK, script->ModifyPeriodicDamageAurasTick(target, attacker, damage, spellInfo));
}

void ScriptMgr::ModifyMeleeDamage(Unit* target, Unit* attacker, uint32& damage)
{
    CALL_ENABLED_HOOKS(UnitScript, UNITHOOK_MODIFY_MELEE_DAMAGE, script->ModifyMeleeDamage(target, attacker, damage));
}

void ScriptMgr::ModifySpellDamageTaken(Unit* target, Unit* attacker, int32& damage, SpellInfo const* spellInfo)
{
    CALL_ENABLED_HOOKS(UnitScript, UNITHOOK_MODIFY_SPELL_DAMAGE_TAKEN, script->ModifySpellDamageTaken(target, attacker, damage, spellInfo));
}

void ScriptMgr::ModifyHealReceived(Unit* target, Unit* healer, uint32& heal, SpellInfo const* spellInfo)
{
    CALL_ENABLED_HOOKS(UnitScript, UNITHOOK_MODIFY_HEAL_RECEIVED, script->ModifyHealReceived(target, healer, heal, spellInfo));
}

uint32 ScriptMgr::DealDamage(Unit* AttackerUnit, Unit* pVictim, uint32 damage, DamageEffectType damagetype)
{
    if (ScriptRegistry<UnitScript>::ScriptPointerList.empty())
    {
        return damage;
    }

    for (auto const& [scriptID, script] : ScriptRegistry<UnitScript>::ScriptPointerList)
    {
        auto const& dmg = script->DealDamage(AttackerUnit, pVictim, damage, damagetype);
        if (dmg != damage)
        {
            return damage;
        }
    }

    return damage;
}

void ScriptMgr::OnBeforeRollMeleeOutcomeAgainst(Unit const* attacker, Unit const* victim, WeaponAttackType attType, int32& attackerMaxSkillValueForLevel, int32& victimMaxSkillValueForLevel, int32& attackerWeaponSkill, int32& victimDefenseSkill, int32& crit_chance, int32& miss_chance, int32& dodge_chance, int32& parry_chance, int32& block_chance)
{
    CALL_ENABLED_HOOKS(UnitScript, UNITHOOK_ON_BEFORE_ROLL_MELEE_OUTCOME_AGAINST, script->OnBeforeRollMeleeOutcomeAgainst(attacker, victim, attType, attackerMaxSkillValueForLevel, victimMaxSkillValueForLevel, attackerWeaponSkill, victimDefenseSkill, crit_chance, miss_chance, dodge_chance, parry_chance, block_chance));
}

void ScriptMgr::OnAuraApply(Unit* unit, Aura* aura)
{
    CALL_ENABLED_HOOKS(UnitScript, UNITHOOK_ON_AURA_APPLY, script->OnAuraApply(unit, aura));
}

void ScriptMgr::OnAuraRemove(Unit* unit, AuraApplication* aurApp, AuraRemoveMode mode)
{
    CALL_ENABLED_HOOKS(UnitScript, UNITHOOK_ON_AURA_REMOVE, script->OnAuraRemove(unit, aurApp, mode));
}

bool ScriptMgr::IfNormalReaction(Unit const* unit, Unit const* target, ReputationRank& repRank)
{
    CALL_ENABLED_BOOLEAN_HOOKS(UnitScript, UNITHOOK_IF_NORMAL_REACTION, !script->IfNormalReaction(unit, target, repRank));
}

bool ScriptMgr::IsNeedModSpellDamagePercent(Unit const* unit, AuraEffect* auraEff, float& doneTotalMod, SpellInfo const* spellProto)
{
    CALL_ENABLED_BOOLEAN_HOOKS(UnitScript, UNITHOOK_IS_NEEDMOD_SPELL_DAMAGE_PERCENT, !script->IsNeedModSpellDamagePercent(unit, auraEff, doneTotalMod, spellProto));
}

bool ScriptMgr::IsNeedModMeleeDamagePercent(Unit const* unit, AuraEffect* auraEff, float& doneTotalMod, SpellInfo const* spellProto)
{
    CALL_ENABLED_BOOLEAN_HOOKS(UnitScript, UNITHOOK_IS_NEEDMOD_MELEE_DAMAGE_PERCENT, !script->IsNeedModMeleeDamagePercent(unit, auraEff, doneTotalMod, spellProto));
}

bool ScriptMgr::IsNeedModHealPercent(Unit const* unit, AuraEffect* auraEff, float& doneTotalMod, SpellInfo const* spellProto)
{
    CALL_ENABLED_BOOLEAN_HOOKS(UnitScript, UNITHOOK_IS_NEEDMOD_HEAL_PERCENT, !script->IsNeedModHealPercent(unit, auraEff, doneTotalMod, spellProto));
}

bool ScriptMgr::CanSetPhaseMask(Unit const* unit, uint32 newPhaseMask, bool update)
{
    CALL_ENABLED_BOOLEAN_HOOKS(UnitScript, UNITHOOK_CAN_SET_PHASE_MASK, !script->CanSetPhaseMask(unit, newPhaseMask, update));
}

bool ScriptMgr::IsCustomBuildValuesUpdate(Unit const* unit, uint8 updateType, ByteBuffer& fieldBuffer, Player const* target, uint16 index)
{
    CALL_ENABLED_BOOLEAN_HOOKS_WITH_DEFAULT_FALSE(UnitScript, UNITHOOK_IS_CUSTOM_BUILD_VALUES_UPDATE, script->IsCustomBuildValuesUpdate(unit, updateType, fieldBuffer, target, index));
}

bool ScriptMgr::ShouldTrackValuesUpdatePosByIndex(Unit const* unit, uint8 updateType, uint16 index)
{
    CALL_ENABLED_BOOLEAN_HOOKS_WITH_DEFAULT_FALSE(UnitScript, UNITHOOK_SHOULD_TRACK_VALUES_UPDATE_POS_BY_INDEX, script->ShouldTrackValuesUpdatePosByIndex(unit, updateType, index));
}

void ScriptMgr::OnPatchValuesUpdate(Unit const* unit, ByteBuffer& valuesUpdateBuf, BuildValuesCachePosPointers& posPointers, Player* target)
{
    CALL_ENABLED_HOOKS(UnitScript, UNITHOOK_ON_PATCH_VALUES_UPDATE, script->OnPatchValuesUpdate(unit, valuesUpdateBuf, posPointers, target));
}

void ScriptMgr::OnUnitUpdate(Unit* unit, uint32 diff)
{
    CALL_ENABLED_HOOKS(UnitScript, UNITHOOK_ON_UNIT_UPDATE, script->OnUnitUpdate(unit, diff));
}

void ScriptMgr::OnDisplayIdChange(Unit* unit, uint32 displayId)
{
    CALL_ENABLED_HOOKS(UnitScript, UNITHOOK_ON_DISPLAYID_CHANGE, script->OnDisplayIdChange(unit, displayId));
}

void ScriptMgr::OnUnitEnterEvadeMode(Unit* unit, uint8 evadeReason)
{
    CALL_ENABLED_HOOKS(UnitScript, UNITHOOK_ON_UNIT_ENTER_EVADE_MODE, script->OnUnitEnterEvadeMode(unit, evadeReason));
}

void ScriptMgr::OnUnitEnterCombat(Unit* unit, Unit* victim)
{
    CALL_ENABLED_HOOKS(UnitScript, UNITHOOK_ON_UNIT_ENTER_COMBAT, script->OnUnitEnterCombat(unit, victim));
}

void ScriptMgr::OnUnitDeath(Unit* unit, Unit* killer)
{
    CALL_ENABLED_HOOKS(UnitScript, UNITHOOK_ON_UNIT_DEATH, script->OnUnitDeath(unit, killer));
}

void ScriptMgr::OnUnitSetShapeshiftForm(Unit* unit, uint8 form)
{
    CALL_ENABLED_HOOKS(UnitScript, UNITHOOK_ON_UNIT_SET_SHAPESHIFT_FORM, script->OnUnitSetShapeshiftForm(unit, form));
}

UnitScript::UnitScript(const char* name, bool addToScripts, std::vector<uint16> enabledHooks)
    : ScriptObject(name, UNITHOOK_END)
{
    if (addToScripts)
    {
        // If empty - enable all available hooks.
        if (enabledHooks.empty())
            for (uint16 i = 0; i < UNITHOOK_END; ++i)
                enabledHooks.emplace_back(i);

        ScriptRegistry<UnitScript>::AddScript(this, std::move(enabledHooks));
    }
}

template class AC_GAME_API ScriptRegistry<UnitScript>;

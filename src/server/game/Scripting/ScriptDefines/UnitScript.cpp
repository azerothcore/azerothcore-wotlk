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

void ScriptMgr::OnHeal(Unit* healer, Unit* reciever, uint32& gain)
{
    ExecuteScript<UnitScript>([&](UnitScript* script)
    {
        script->OnHeal(healer, reciever, gain);
    });
}

void ScriptMgr::OnDamage(Unit* attacker, Unit* victim, uint32& damage)
{
    ExecuteScript<UnitScript>([&](UnitScript* script)
    {
        script->OnDamage(attacker, victim, damage);
    });
}

void ScriptMgr::ModifyPeriodicDamageAurasTick(Unit* target, Unit* attacker, uint32& damage, SpellInfo const* spellInfo)
{
    ExecuteScript<UnitScript>([&](UnitScript* script)
    {
        script->ModifyPeriodicDamageAurasTick(target, attacker, damage, spellInfo);
    });
}

void ScriptMgr::ModifyMeleeDamage(Unit* target, Unit* attacker, uint32& damage)
{
    ExecuteScript<UnitScript>([&](UnitScript* script)
    {
        script->ModifyMeleeDamage(target, attacker, damage);
    });
}

void ScriptMgr::ModifySpellDamageTaken(Unit* target, Unit* attacker, int32& damage, SpellInfo const* spellInfo)
{
    ExecuteScript<UnitScript>([&](UnitScript* script)
    {
        script->ModifySpellDamageTaken(target, attacker, damage, spellInfo);
    });
}

void ScriptMgr::ModifyHealReceived(Unit* target, Unit* healer, uint32& heal, SpellInfo const* spellInfo)
{
    ExecuteScript<UnitScript>([&](UnitScript* script)
    {
        script->ModifyHealReceived(target, healer, heal, spellInfo);
    });
}

void ScriptMgr::OnBeforeRollMeleeOutcomeAgainst(Unit const* attacker, Unit const* victim, WeaponAttackType attType, int32& attackerMaxSkillValueForLevel, int32& victimMaxSkillValueForLevel, int32& attackerWeaponSkill, int32& victimDefenseSkill, int32& crit_chance, int32& miss_chance, int32& dodge_chance, int32& parry_chance, int32& block_chance)
{
    ExecuteScript<UnitScript>([&](UnitScript* script)
    {
        script->OnBeforeRollMeleeOutcomeAgainst(attacker, victim, attType, attackerMaxSkillValueForLevel, victimMaxSkillValueForLevel, attackerWeaponSkill, victimDefenseSkill, crit_chance, miss_chance, dodge_chance, parry_chance, block_chance);
    });
}

void ScriptMgr::OnAuraRemove(Unit* unit, AuraApplication* aurApp, AuraRemoveMode mode)
{
    ExecuteScript<UnitScript>([&](UnitScript* script)
    {
        script->OnAuraRemove(unit, aurApp, mode);
    });
}

bool ScriptMgr::IfNormalReaction(Unit const* unit, Unit const* target, ReputationRank& repRank)
{
    auto ret = IsValidBoolScript<UnitScript>([&](UnitScript* script)
    {
        return !script->IfNormalReaction(unit, target, repRank);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

bool ScriptMgr::IsNeedModSpellDamagePercent(Unit const* unit, AuraEffect* auraEff, float& doneTotalMod, SpellInfo const* spellProto)
{
    auto ret = IsValidBoolScript<UnitScript>([&](UnitScript* script)
    {
        return !script->IsNeedModSpellDamagePercent(unit, auraEff, doneTotalMod, spellProto);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

bool ScriptMgr::IsNeedModMeleeDamagePercent(Unit const* unit, AuraEffect* auraEff, float& doneTotalMod, SpellInfo const* spellProto)
{
    auto ret = IsValidBoolScript<UnitScript>([&](UnitScript* script)
    {
        return !script->IsNeedModMeleeDamagePercent(unit, auraEff, doneTotalMod, spellProto);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

bool ScriptMgr::IsNeedModHealPercent(Unit const* unit, AuraEffect* auraEff, float& doneTotalMod, SpellInfo const* spellProto)
{
    auto ret = IsValidBoolScript<UnitScript>([&](UnitScript* script)
    {
        return !script->IsNeedModHealPercent(unit, auraEff, doneTotalMod, spellProto);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

bool ScriptMgr::CanSetPhaseMask(Unit const* unit, uint32 newPhaseMask, bool update)
{
    auto ret = IsValidBoolScript<UnitScript>([&](UnitScript* script)
    {
        return !script->CanSetPhaseMask(unit, newPhaseMask, update);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

bool ScriptMgr::IsCustomBuildValuesUpdate(Unit const* unit, uint8 updateType, ByteBuffer& fieldBuffer, Player const* target, uint16 index)
{
    auto ret = IsValidBoolScript<UnitScript>([&](UnitScript* script)
    {
        return script->IsCustomBuildValuesUpdate(unit, updateType, fieldBuffer, target, index);
    });

    if (ret && *ret)
    {
        return true;
    }

    return false;
}

bool ScriptMgr::ShouldTrackValuesUpdatePosByIndex(Unit const* unit, uint8 updateType, uint16 index)
{
    auto ret = IsValidBoolScript<UnitScript>([&](UnitScript* script) { return script->ShouldTrackValuesUpdatePosByIndex(unit, updateType, index); });

    if (ret && *ret)
        return true;

    return false;
}

void ScriptMgr::OnPatchValuesUpdate(Unit const* unit, ByteBuffer& valuesUpdateBuf, BuildValuesCachePosPointers& posPointers, Player* target)
{
    ExecuteScript<UnitScript>([&](UnitScript* script)
    {
        script->OnPatchValuesUpdate(unit, valuesUpdateBuf, posPointers, target);
    });
}

void ScriptMgr::OnUnitUpdate(Unit* unit, uint32 diff)
{
    ExecuteScript<UnitScript>([&](UnitScript* script)
    {
        script->OnUnitUpdate(unit, diff);
    });
}

void ScriptMgr::OnDisplayIdChange(Unit* unit, uint32 displayId)
{
    ExecuteScript<UnitScript>([&](UnitScript* script)
    {
        script->OnDisplayIdChange(unit, displayId);
    });
}

void ScriptMgr::OnUnitEnterEvadeMode(Unit* unit, uint8 evadeReason)
{
    ExecuteScript<UnitScript>([&](UnitScript* script)
    {
        script->OnUnitEnterEvadeMode(unit, evadeReason);
    });
}

void ScriptMgr::OnUnitEnterCombat(Unit* unit, Unit* victim)
{
    ExecuteScript<UnitScript>([&](UnitScript* script)
    {
        script->OnUnitEnterCombat(unit, victim);
    });
}

void ScriptMgr::OnUnitDeath(Unit* unit, Unit* killer)
{
    ExecuteScript<UnitScript>([&](UnitScript* script)
    {
        script->OnUnitDeath(unit, killer);
    });
}

void ScriptMgr::OnAuraApply(Unit* unit, Aura* aura)
{
    ExecuteScript<UnitScript>([&](UnitScript* script)
    {
        script->OnAuraApply(unit, aura);
    });
}

UnitScript::UnitScript(const char* name, bool addToScripts) :
    ScriptObject(name)
{
    if (addToScripts)
        ScriptRegistry<UnitScript>::AddScript(this);
}

template class AC_GAME_API ScriptRegistry<UnitScript>;

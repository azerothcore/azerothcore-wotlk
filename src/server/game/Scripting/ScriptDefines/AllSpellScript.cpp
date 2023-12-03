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

#include "AllSpellScript.h"
#include "ScriptMgr.h"
#include "ScriptMgrMacros.h"

void ScriptMgr::OnCalcMaxDuration(Aura const* aura, int32& maxDuration)
{
    ExecuteScript<AllSpellScript>([&](AllSpellScript* script)
    {
        script->OnCalcMaxDuration(aura, maxDuration);
    });
}

bool ScriptMgr::CanModAuraEffectDamageDone(AuraEffect const* auraEff, Unit* target, AuraApplication const* aurApp, uint8 mode, bool apply)
{
    auto ret = IsValidBoolScript<AllSpellScript>([&](AllSpellScript* script)
    {
        return !script->CanModAuraEffectDamageDone(auraEff, target, aurApp, mode, apply);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

bool ScriptMgr::CanModAuraEffectModDamagePercentDone(AuraEffect const* auraEff, Unit* target, AuraApplication const* aurApp, uint8 mode, bool apply)
{
    auto ret = IsValidBoolScript<AllSpellScript>([&](AllSpellScript* script)
    {
        return !script->CanModAuraEffectModDamagePercentDone(auraEff, target, aurApp, mode, apply);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

void ScriptMgr::OnSpellCheckCast(Spell* spell, bool strict, SpellCastResult& res)
{
    ExecuteScript<AllSpellScript>([&](AllSpellScript* script)
    {
        script->OnSpellCheckCast(spell, strict, res);
    });
}

bool ScriptMgr::CanPrepare(Spell* spell, SpellCastTargets const* targets, AuraEffect const* triggeredByAura)
{
    auto ret = IsValidBoolScript<AllSpellScript>([&](AllSpellScript* script)
    {
        return !script->CanPrepare(spell, targets, triggeredByAura);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

bool ScriptMgr::CanScalingEverything(Spell* spell)
{
    auto ret = IsValidBoolScript<AllSpellScript>([&](AllSpellScript* script)
    {
        return script->CanScalingEverything(spell);
    });

    if (ret && *ret)
    {
        return true;
    }

    return false;
}

bool ScriptMgr::CanSelectSpecTalent(Spell* spell)
{
    auto ret = IsValidBoolScript<AllSpellScript>([&](AllSpellScript* script)
    {
        return !script->CanSelectSpecTalent(spell);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

void ScriptMgr::OnScaleAuraUnitAdd(Spell* spell, Unit* target, uint32 effectMask, bool checkIfValid, bool implicit, uint8 auraScaleMask, TargetInfo& targetInfo)
{
    ExecuteScript<AllSpellScript>([&](AllSpellScript* script)
    {
        script->OnScaleAuraUnitAdd(spell, target, effectMask, checkIfValid, implicit, auraScaleMask, targetInfo);
    });
}

void ScriptMgr::OnRemoveAuraScaleTargets(Spell* spell, TargetInfo& targetInfo, uint8 auraScaleMask, bool& needErase)
{
    ExecuteScript<AllSpellScript>([&](AllSpellScript* script)
    {
        script->OnRemoveAuraScaleTargets(spell, targetInfo, auraScaleMask, needErase);
    });
}

void ScriptMgr::OnBeforeAuraRankForLevel(SpellInfo const* spellInfo, SpellInfo const* latestSpellInfo, uint8 level)
{
    ExecuteScript<AllSpellScript>([&](AllSpellScript* script)
    {
        script->OnBeforeAuraRankForLevel(spellInfo, latestSpellInfo, level);
    });
}

void ScriptMgr::OnDummyEffect(WorldObject* caster, uint32 spellID, SpellEffIndex effIndex, GameObject* gameObjTarget)
{
    ExecuteScript<AllSpellScript>([&](AllSpellScript* script)
    {
        script->OnDummyEffect(caster, spellID, effIndex, gameObjTarget);
    });
}

void ScriptMgr::OnDummyEffect(WorldObject* caster, uint32 spellID, SpellEffIndex effIndex, Creature* creatureTarget)
{
    ExecuteScript<AllSpellScript>([&](AllSpellScript* script)
    {
        script->OnDummyEffect(caster, spellID, effIndex, creatureTarget);
    });
}

void ScriptMgr::OnDummyEffect(WorldObject* caster, uint32 spellID, SpellEffIndex effIndex, Item* itemTarget)
{
    ExecuteScript<AllSpellScript>([&](AllSpellScript* script)
    {
        script->OnDummyEffect(caster, spellID, effIndex, itemTarget);
    });
}

AllSpellScript::AllSpellScript(char const* name)
    : ScriptObject(name)
{
    ScriptRegistry<AllSpellScript>::AddScript(this);
}

template class AC_GAME_API ScriptRegistry<AllSpellScript>;

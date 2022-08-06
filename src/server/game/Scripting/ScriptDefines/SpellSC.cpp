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

// This is an open source non-commercial project. Dear PVS-Studio, please check it.
// PVS-Studio Static Code Analyzer for C, C++ and C#: http://www.viva64.com

#include "ScriptMgr.h"
#include "ScriptMgrMacros.h"
#include "ScriptObject.h"

void ScriptMgr::OnCalcMaxDuration(Aura const* aura, int32& maxDuration)
{
    ExecuteScript<SpellSC>([&](SpellSC* script)
    {
        script->OnCalcMaxDuration(aura, maxDuration);
    });
}

bool ScriptMgr::CanModAuraEffectDamageDone(AuraEffect const* auraEff, Unit* target, AuraApplication const* aurApp, uint8 mode, bool apply)
{
    auto ret = IsValidBoolScript<SpellSC>([&](SpellSC* script)
    {
        return !script->CanModAuraEffectDamageDone(auraEff, target, aurApp, mode, apply);
    });

    return ReturnValidBool(ret);
}

bool ScriptMgr::CanModAuraEffectModDamagePercentDone(AuraEffect const* auraEff, Unit* target, AuraApplication const* aurApp, uint8 mode, bool apply)
{
    auto ret = IsValidBoolScript<SpellSC>([&](SpellSC* script)
    {
        return !script->CanModAuraEffectModDamagePercentDone(auraEff, target, aurApp, mode, apply);
    });

    return ReturnValidBool(ret);
}

void ScriptMgr::OnSpellCheckCast(Spell* spell, bool strict, SpellCastResult& res)
{
    ExecuteScript<SpellSC>([&](SpellSC* script)
    {
        script->OnSpellCheckCast(spell, strict, res);
    });
}

bool ScriptMgr::CanPrepare(Spell* spell, SpellCastTargets const* targets, AuraEffect const* triggeredByAura)
{
    auto ret = IsValidBoolScript<SpellSC>([&](SpellSC* script)
    {
        return !script->CanPrepare(spell, targets, triggeredByAura);
    });

    return ReturnValidBool(ret);
}

bool ScriptMgr::CanScalingEverything(Spell* spell)
{
    auto ret = IsValidBoolScript<SpellSC>([&](SpellSC* script)
    {
        return script->CanScalingEverything(spell);
    });

    return ReturnValidBool(ret, true);
}

bool ScriptMgr::CanSelectSpecTalent(Spell* spell)
{
    auto ret = IsValidBoolScript<SpellSC>([&](SpellSC* script)
    {
        return !script->CanSelectSpecTalent(spell);
    });

    return ReturnValidBool(ret);
}

void ScriptMgr::OnScaleAuraUnitAdd(Spell* spell, Unit* target, uint32 effectMask, bool checkIfValid, bool implicit, uint8 auraScaleMask, TargetInfo& targetInfo)
{
    ExecuteScript<SpellSC>([&](SpellSC* script)
    {
        script->OnScaleAuraUnitAdd(spell, target, effectMask, checkIfValid, implicit, auraScaleMask, targetInfo);
    });
}

void ScriptMgr::OnRemoveAuraScaleTargets(Spell* spell, TargetInfo& targetInfo, uint8 auraScaleMask, bool& needErase)
{
    ExecuteScript<SpellSC>([&](SpellSC* script)
    {
        script->OnRemoveAuraScaleTargets(spell, targetInfo, auraScaleMask, needErase);
    });
}

void ScriptMgr::OnBeforeAuraRankForLevel(SpellInfo const* spellInfo, SpellInfo const* latestSpellInfo, uint8 level)
{
    ExecuteScript<SpellSC>([&](SpellSC* script)
    {
        script->OnBeforeAuraRankForLevel(spellInfo, latestSpellInfo, level);
    });
}

void ScriptMgr::OnDummyEffect(WorldObject* caster, uint32 spellID, SpellEffIndex effIndex, GameObject* gameObjTarget)
{
    ExecuteScript<SpellSC>([&](SpellSC* script)
    {
        script->OnDummyEffect(caster, spellID, effIndex, gameObjTarget);
    });
}

void ScriptMgr::OnDummyEffect(WorldObject* caster, uint32 spellID, SpellEffIndex effIndex, Creature* creatureTarget)
{
    ExecuteScript<SpellSC>([&](SpellSC* script)
    {
        script->OnDummyEffect(caster, spellID, effIndex, creatureTarget);
    });
}

void ScriptMgr::OnDummyEffect(WorldObject* caster, uint32 spellID, SpellEffIndex effIndex, Item* itemTarget)
{
    ExecuteScript<SpellSC>([&](SpellSC* script)
    {
        script->OnDummyEffect(caster, spellID, effIndex, itemTarget);
    });
}

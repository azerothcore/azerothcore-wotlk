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
    CALL_ENABLED_HOOKS(AllSpellScript, ALLSPELLHOOK_ON_CALC_MAX_DURATION, script->OnCalcMaxDuration(aura, maxDuration));
}

bool ScriptMgr::CanModAuraEffectDamageDone(AuraEffect const* auraEff, Unit* target, AuraApplication const* aurApp, uint8 mode, bool apply)
{
    CALL_ENABLED_BOOLEAN_HOOKS(AllSpellScript, ALLSPELLHOOK_CAN_MOD_AURA_EFFECT_DAMAGE_DONE, !script->CanModAuraEffectDamageDone(auraEff, target, aurApp, mode, apply));
}

bool ScriptMgr::CanModAuraEffectModDamagePercentDone(AuraEffect const* auraEff, Unit* target, AuraApplication const* aurApp, uint8 mode, bool apply)
{
    CALL_ENABLED_BOOLEAN_HOOKS(AllSpellScript, ALLSPELLHOOK_CAN_MOD_AURA_EFFECT_MOD_DAMAGE_PERCENT_DONE, !script->CanModAuraEffectModDamagePercentDone(auraEff, target, aurApp, mode, apply));
}

void ScriptMgr::OnSpellCheckCast(Spell* spell, bool strict, SpellCastResult& res)
{
    CALL_ENABLED_HOOKS(AllSpellScript, ALLSPELLHOOK_ON_SPELL_CHECK_CAST, script->OnSpellCheckCast(spell, strict, res));
}

bool ScriptMgr::CanPrepare(Spell* spell, SpellCastTargets const* targets, AuraEffect const* triggeredByAura)
{
    CALL_ENABLED_BOOLEAN_HOOKS(AllSpellScript, ALLSPELLHOOK_CAN_PREPARE, !script->CanPrepare(spell, targets, triggeredByAura));
}

bool ScriptMgr::CanScalingEverything(Spell* spell)
{
    CALL_ENABLED_BOOLEAN_HOOKS_WITH_DEFAULT_FALSE(AllSpellScript, ALLSPELLHOOK_CAN_SCALING_EVERYTHING, script->CanScalingEverything(spell));
}

bool ScriptMgr::CanSelectSpecTalent(Spell* spell)
{
    CALL_ENABLED_BOOLEAN_HOOKS(AllSpellScript, ALLSPELLHOOK_CAN_SELECT_SPEC_TALENT, !script->CanSelectSpecTalent(spell));
}

void ScriptMgr::OnScaleAuraUnitAdd(Spell* spell, Unit* target, uint32 effectMask, bool checkIfValid, bool implicit, uint8 auraScaleMask, TargetInfo& targetInfo)
{
    CALL_ENABLED_HOOKS(AllSpellScript, ALLSPELLHOOK_ON_SCALE_AURA_UNIT_ADD, script->OnScaleAuraUnitAdd(spell, target, effectMask, checkIfValid, implicit, auraScaleMask, targetInfo));
}

void ScriptMgr::OnRemoveAuraScaleTargets(Spell* spell, TargetInfo& targetInfo, uint8 auraScaleMask, bool& needErase)
{
    CALL_ENABLED_HOOKS(AllSpellScript, ALLSPELLHOOK_ON_REMOVE_AURA_SCALE_TARGETS, script->OnRemoveAuraScaleTargets(spell, targetInfo, auraScaleMask, needErase));
}

void ScriptMgr::OnBeforeAuraRankForLevel(SpellInfo const* spellInfo, SpellInfo const* latestSpellInfo, uint8 level)
{
    CALL_ENABLED_HOOKS(AllSpellScript, ALLSPELLHOOK_ON_BEFORE_AURA_RANK_FOR_LEVEL, script->OnBeforeAuraRankForLevel(spellInfo, latestSpellInfo, level));
}

void ScriptMgr::OnDummyEffect(WorldObject* caster, uint32 spellID, SpellEffIndex effIndex, GameObject* gameObjTarget)
{
    CALL_ENABLED_HOOKS(AllSpellScript, ALLSPELLHOOK_ON_DUMMY_EFFECT_GAMEOBJECT, script->OnDummyEffect(caster, spellID, effIndex, gameObjTarget));
}

void ScriptMgr::OnDummyEffect(WorldObject* caster, uint32 spellID, SpellEffIndex effIndex, Creature* creatureTarget)
{
    CALL_ENABLED_HOOKS(AllSpellScript, ALLSPELLHOOK_ON_DUMMY_EFFECT_CREATURE, script->OnDummyEffect(caster, spellID, effIndex, creatureTarget));
}

void ScriptMgr::OnDummyEffect(WorldObject* caster, uint32 spellID, SpellEffIndex effIndex, Item* itemTarget)
{
    CALL_ENABLED_HOOKS(AllSpellScript, ALLSPELLHOOK_ON_DUMMY_EFFECT_ITEM, script->OnDummyEffect(caster, spellID, effIndex, itemTarget));
}

void ScriptMgr::OnSpellCastCancel(Spell* spell, Unit* caster, SpellInfo const* spellInfo, bool bySelf)
{
    CALL_ENABLED_HOOKS(AllSpellScript, ALLSPELLHOOK_ON_CAST_CANCEL, script->OnSpellCastCancel(spell, caster, spellInfo, bySelf));
}

void ScriptMgr::OnSpellCast(Spell* spell, Unit* caster, SpellInfo const* spellInfo, bool skipCheck)
{
    CALL_ENABLED_HOOKS(AllSpellScript, ALLSPELLHOOK_ON_CAST, script->OnSpellCast(spell, caster, spellInfo, skipCheck));
}

void ScriptMgr::OnSpellPrepare(Spell* spell, Unit* caster, SpellInfo const* spellInfo)
{
    CALL_ENABLED_HOOKS(AllSpellScript, ALLSPELLHOOK_ON_PREPARE, script->OnSpellPrepare(spell, caster, spellInfo));
}

AllSpellScript::AllSpellScript(char const* name, std::vector<uint16> enabledHooks)
    : ScriptObject(name, ALLSPELLHOOK_END)
{
    // If empty - enable all available hooks.
    if (enabledHooks.empty())
        for (uint16 i = 0; i < ALLSPELLHOOK_END; ++i)
            enabledHooks.emplace_back(i);

    ScriptRegistry<AllSpellScript>::AddScript(this, std::move(enabledHooks));
}

template class AC_GAME_API ScriptRegistry<AllSpellScript>;

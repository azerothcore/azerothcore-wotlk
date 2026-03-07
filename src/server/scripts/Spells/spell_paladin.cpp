/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "GameTime.h"
#include "Group.h"
#include "Player.h"
#include "SpellAuraEffects.h"
#include "SpellMgr.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "UnitAI.h"
/*
 * Scripts for spells with SPELLFAMILY_PALADIN and SPELLFAMILY_GENERIC spells used by paladin players.
 * Ordered alphabetically using scriptname.
 * Scriptnames of files in this file should be prefixed with "spell_pal_".
 */

enum PaladinSpells
{
    SPELL_PALADIN_DIVINE_PLEA                    = 54428,
    SPELL_PALADIN_BLESSING_OF_SANCTUARY_BUFF     = 67480,
    SPELL_PALADIN_BLESSING_OF_SANCTUARY_ENERGIZE = 57319,

    SPELL_PALADIN_HOLY_SHOCK_R1                  = 20473,
    SPELL_PALADIN_HOLY_SHOCK_R1_DAMAGE           = 25912,
    SPELL_PALADIN_HOLY_SHOCK_R1_HEALING          = 25914,

    SPELL_PALADIN_BLESSING_OF_LOWER_CITY_DRUID   = 37878,
    SPELL_PALADIN_BLESSING_OF_LOWER_CITY_PALADIN = 37879,
    SPELL_PALADIN_BLESSING_OF_LOWER_CITY_PRIEST  = 37880,
    SPELL_PALADIN_BLESSING_OF_LOWER_CITY_SHAMAN  = 37881,

    SPELL_PALADIN_DIVINE_STORM                   = 53385,
    SPELL_PALADIN_DIVINE_STORM_DUMMY             = 54171,
    SPELL_PALADIN_DIVINE_STORM_HEAL              = 54172,

    SPELL_PALADIN_EYE_FOR_AN_EYE_DAMAGE          = 25997,

    SPELL_PALADIN_FORBEARANCE                    = 25771,
    SPELL_PALADIN_AVENGING_WRATH_MARKER          = 61987,
    SPELL_PALADIN_IMMUNE_SHIELD_MARKER           = 61988,

    SPELL_PALADIN_HAND_OF_SACRIFICE              = 6940,
    SPELL_PALADIN_DIVINE_SACRIFICE               = 64205,

    SPELL_PALADIN_JUDGEMENT_DAMAGE               = 54158,
    SPELL_PALADIN_JUDGEMENT_OF_JUSTICE           = 20184,
    SPELL_PALADIN_JUDGEMENT_OF_LIGHT             = 20185,
    SPELL_PALADIN_JUDGEMENT_OF_WISDOM            = 20186,

    SPELL_PALADIN_GLYPH_OF_SALVATION             = 63225,

    SPELL_PALADIN_RIGHTEOUS_DEFENSE_TAUNT        = 31790,

    SPELL_PALADIN_SANCTIFIED_WRATH               = 57318,
    SPELL_PALADIN_SANCTIFIED_WRATH_TALENT_R1     = 53375,

    SPELL_PALADIN_SEAL_OF_RIGHTEOUSNESS          = 25742,

    SPELL_PALADIN_CONCENTRACTION_AURA            = 19746,
    SPELL_PALADIN_SANCTIFIED_RETRIBUTION_R1      = 31869,
    SPELL_PALADIN_SWIFT_RETRIBUTION_R1           = 53379,

    SPELL_PALADIN_IMPROVED_CONCENTRACTION_AURA   = 63510,
    SPELL_PALADIN_IMPROVED_DEVOTION_AURA         = 63514,
    SPELL_PALADIN_SANCTIFIED_RETRIBUTION_AURA    = 63531,
    SPELL_PALADIN_AURA_MASTERY_IMMUNE            = 64364,

    SPELL_JUDGEMENTS_OF_THE_JUST                 = 68055,
    SPELL_JUDGEMENT_OF_VENGEANCE_EFFECT          = 31804,
    SPELL_HOLY_VENGEANCE                         = 31803,
    SPELL_JUDGEMENT_OF_CORRUPTION_EFFECT         = 53733,
    SPELL_BLOOD_CORRUPTION                       = 53742,

    SPELL_GENERIC_ARENA_DAMPENING                = 74410,
    SPELL_GENERIC_BATTLEGROUND_DAMPENING         = 74411,

    // Crystalforge Raiment - Tier 5 Holy 2 Set
    SPELL_IMPROVED_JUDGEMENT                     = 37188,
    SPELL_IMPROVED_JUDGEMENT_ENERGIZE            = 43838,

    SPELL_PALADIN_HOLY_VENGEANCE                 = 31803,
    SPELL_PALADIN_BLOOD_CORRUPTION               = 53742,
    SPELL_PALADIN_SEAL_OF_VENGEANCE_EFFECT       = 42463,
    SPELL_PALADIN_SEAL_OF_CORRUPTION_EFFECT      = 53739
};

enum PaladinSpellIcons
{
    PALADIN_ICON_ID_RETRIBUTION_AURA             = 555,
    PALADIN_ICON_JUDGEMENTS_OF_THE_WISE          = 3017,
    PALADIN_ICON_HAMMER_OF_THE_RIGHTEOUS         = 3023,
    PALADIN_ICON_RIGHTEOUS_VENGEANCE             = 3025,
    PALADIN_ICON_SHEATH_OF_LIGHT                 = 3030
};

enum MiscSpellIcons
{
    SPELL_ICON_ID_STRENGTH_OF_WRYNN              = 1704,
    SPELL_ICON_ID_HELLSCREAM_WARSONG             = 937
};

// Proc system triggered spell IDs
enum PaladinProcSpells
{
    SPELL_PALADIN_ILLUMINATION_ENERGIZE          = 20272,
    SPELL_PALADIN_JUDGEMENTS_OF_THE_WISE_MANA    = 31930,
    SPELL_PALADIN_REPLENISHMENT                  = 57669,
    SPELL_PALADIN_RIGHTEOUS_VENGEANCE_DOT        = 61840,
    SPELL_PALADIN_SHEATH_OF_LIGHT_HOT            = 54203,
    SPELL_PALADIN_JUDGEMENT_OF_LIGHT_HEAL        = 20267,
    SPELL_PALADIN_JUDGEMENT_OF_WISDOM_MANA       = 20268,
    SPELL_PALADIN_SPIRITUAL_ATTUNEMENT_MANA      = 31786,
    SPELL_PALADIN_BEACON_OF_LIGHT_AURA           = 53563,
    SPELL_PALADIN_LIGHTS_BEACON                  = 53651,
    SPELL_PALADIN_BEACON_OF_LIGHT_FLASH          = 53652,
    SPELL_PALADIN_BEACON_OF_LIGHT_HOLY           = 53654,
    SPELL_PALADIN_HOLY_LIGHT_R1                  = 635,
    SPELL_PALADIN_GLYPH_OF_HOLY_LIGHT_HEAL       = 54968,
    SPELL_PALADIN_SACRED_SHIELD                  = 53601,
    SPELL_PALADIN_T9_HOLY_4P_BONUS               = 67191,
    SPELL_PALADIN_FLASH_OF_LIGHT_PROC            = 66922,
    SPELL_PALADIN_ENDURING_LIGHT                 = 40471,
    SPELL_PALADIN_ENDURING_JUDGEMENT             = 40472,
    SPELL_PALADIN_HOLY_POWER_ARMOR               = 28790,
    SPELL_PALADIN_HOLY_POWER_ATTACK_POWER        = 28791,
    SPELL_PALADIN_HOLY_POWER_SPELL_POWER         = 28793,
    SPELL_PALADIN_HOLY_POWER_MP5                 = 28795,
    SPELL_PALADIN_HOLY_MENDING                   = 64891,
    SPELL_PALADIN_GLYPH_OF_DIVINITY_PROC         = 54986,
    SPELL_PALADIN_HEART_OF_THE_CRUSADER_EFF_R1   = 21183,
    SPELL_PALADIN_JUDGEMENTS_OF_THE_JUST_PROC    = 68055,
    SPELL_PALADIN_SACRED_SHIELD_TRIGGER          = 58597,
    SPELL_PALADIN_T8_HOLY_4P_BONUS               = 64895
};

class spell_pal_seal_of_command_aura : public AuraScript
{
    PrepareAuraScript(spell_pal_seal_of_command_aura);

    bool CheckProc(ProcEventInfo& eventInfo)
    {
        if (!eventInfo.GetActor() || !eventInfo.GetActionTarget())
        {
            return false;
        }

        if (SpellInfo const* procSpell = eventInfo.GetSpellInfo())
        {
            if (procSpell->SpellIconID == 3025) // Righteous Vengeance, should not proc SoC
            {
                return false;
            }
        }

        return true;
    }

    void HandleProc(AuraEffect const* aurEff, ProcEventInfo& eventInfo)
    {
        PreventDefaultAction();
        int32 targets = 3;
        if (SpellInfo const* procSpell = eventInfo.GetSpellInfo())
        {
            if (procSpell->IsAffectingArea())
            {
                targets = 1;
            }
        }

        Unit* target = eventInfo.GetActionTarget();
        if (target->IsAlive())
        {
            eventInfo.GetActor()->CastCustomSpell(aurEff->GetSpellInfo()->Effects[EFFECT_0].TriggerSpell, SPELLVALUE_MAX_TARGETS, targets, target, false, nullptr, aurEff);
        }
    }

    void Register() override
    {
        if (m_scriptSpellId == 20375)
        {
            DoCheckProc += AuraCheckProcFn(spell_pal_seal_of_command_aura::CheckProc);
            OnEffectProc += AuraEffectProcFn(spell_pal_seal_of_command_aura::HandleProc, EFFECT_0, SPELL_AURA_PROC_TRIGGER_SPELL);
        }
    }
};

class spell_pal_seal_of_command : public SpellScript
{
    PrepareSpellScript(spell_pal_seal_of_command);

    void FilterTargets(std::list<WorldObject*>& targets)
    {
        if (SpellValue const* spellValue = GetSpellValue())
            if (spellValue->MaxAffectedTargets == 1)
                targets.clear();
    }

    void Register() override
    {
        if (m_scriptSpellId == 20424)
            OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_pal_seal_of_command::FilterTargets, EFFECT_0, TARGET_UNIT_TARGET_ENEMY);
    }
};

class spell_pal_divine_intervention : public AuraScript
{
    PrepareAuraScript(spell_pal_divine_intervention);

    void HandleRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        if (!GetTarget()->IsInCombat() && GetTarget()->IsPlayer())
            GetTarget()->RemoveAurasDueToSpell(GetTarget()->ToPlayer()->GetTeamId() == TEAM_ALLIANCE ? 57723 : 57724);
    }

    void Register() override
    {
        OnEffectRemove += AuraEffectRemoveFn(spell_pal_divine_intervention::HandleRemove, EFFECT_0, SPELL_AURA_SCHOOL_IMMUNITY, AURA_EFFECT_HANDLE_REAL);
    }
};

class spell_pal_seal_of_light : public AuraScript
{
    PrepareAuraScript(spell_pal_seal_of_light);

    bool CheckProc(ProcEventInfo& eventInfo)
    {
        // xinef: skip divine storm self hit (dummy) and righteous vengeance (0x20000000=
        return eventInfo.GetActor() != eventInfo.GetProcTarget() && (!eventInfo.GetSpellInfo() || !eventInfo.GetSpellInfo()->SpellFamilyFlags.HasFlag(0x20000000));
    }

    void Register() override
    {
        DoCheckProc += AuraCheckProcFn(spell_pal_seal_of_light::CheckProc);
    }
};

// 58597 - Sacred Shield (absorb)
class spell_pal_sacred_shield : public AuraScript
{
    PrepareAuraScript(spell_pal_sacred_shield);

    void CalculateAmount(AuraEffect const* aurEff, int32& amount, bool& /*canBeRecalculated*/)
    {
        if (Unit* caster = GetCaster())
        {
            // +75.00% from sp bonus
            float bonus = CalculatePct(caster->SpellBaseHealingBonusDone(GetSpellInfo()->GetSchoolMask()), 75.0f);

            // Divine Guardian is only applied at the spell healing bonus because it was already applied to the base value in CalculateSpellDamage
            bonus = caster->ApplyEffectModifiers(GetSpellInfo(), aurEff->GetEffIndex(), bonus);
            bonus *= caster->CalculateLevelPenalty(GetSpellInfo());

            amount += int32(bonus);

            // Arena - Dampening
            if (AuraEffect const* auraEffArenaDampening = caster->GetAuraEffect(SPELL_GENERIC_ARENA_DAMPENING, EFFECT_0))
                AddPct(amount, auraEffArenaDampening->GetAmount());
            // Battleground - Dampening
            else if (AuraEffect const* auraEffBattlegroundDampening = caster->GetAuraEffect(SPELL_GENERIC_BATTLEGROUND_DAMPENING, EFFECT_0))
                AddPct(amount, auraEffBattlegroundDampening->GetAmount());

            // ICC buff
            if (AuraEffect const* auraStrengthOfWrynn = caster->GetAuraEffect(SPELL_AURA_MOD_HEALING_DONE_PERCENT, SPELLFAMILY_GENERIC, SPELL_ICON_ID_STRENGTH_OF_WRYNN, EFFECT_2))
                AddPct(amount, auraStrengthOfWrynn->GetAmount());
            else if (AuraEffect const* auraHellscreamsWarsong = caster->GetAuraEffect(SPELL_AURA_MOD_HEALING_DONE_PERCENT, SPELLFAMILY_GENERIC, SPELL_ICON_ID_HELLSCREAM_WARSONG, EFFECT_2))
                AddPct(amount, auraHellscreamsWarsong->GetAmount());
        }
    }

    void Register() override
    {
        DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_pal_sacred_shield::CalculateAmount, EFFECT_0, SPELL_AURA_SCHOOL_ABSORB);
    }
};

// 31850 - Ardent Defender
class spell_pal_ardent_defender : public AuraScript
{
    PrepareAuraScript(spell_pal_ardent_defender);

public:
    spell_pal_ardent_defender()
    {
        absorbPct = 0;
        healPct = 0;
    }

private:
    uint32 absorbPct, healPct;

    enum Spell
    {
        PAL_SPELL_ARDENT_DEFENDER_DEBUFF = 66233,
        PAL_SPELL_ARDENT_DEFENDER_HEAL   = 66235
    };

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ PAL_SPELL_ARDENT_DEFENDER_HEAL });
    }

    bool Load() override
    {
        healPct = GetSpellInfo()->Effects[EFFECT_1].CalcValue();
        absorbPct = GetSpellInfo()->Effects[EFFECT_0].CalcValue();
        return GetUnitOwner()->IsPlayer();
    }

    void CalculateAmount(AuraEffect const* /*aurEff*/, int32& amount, bool& /*canBeRecalculated*/)
    {
        // Set absorbtion amount to unlimited
        amount = -1;
    }

    void Absorb(AuraEffect* aurEff, DamageInfo& dmgInfo, uint32& absorbAmount)
    {
        Unit* victim = GetTarget();
        int32 remainingHealth = victim->GetHealth() - dmgInfo.GetDamage();
        uint32 allowedHealth = victim->CountPctFromMaxHealth(35);
        // If damage kills us
        if (remainingHealth <= 0 && !victim->ToPlayer()->HasAura(PAL_SPELL_ARDENT_DEFENDER_DEBUFF))
        {
            // Cast healing spell, completely avoid damage
            absorbAmount = dmgInfo.GetDamage();

            uint32 defenseSkillValue = victim->GetDefenseSkillValue();
            // Max heal when defense skill denies critical hits from raid bosses
            // Formula: max defense at level + 140 (raiting from gear)
            uint32 reqDefForMaxHeal = victim->GetLevel() * 5 + 140;
            float pctFromDefense = (defenseSkillValue >= reqDefForMaxHeal)
                                    ? 1.0f
                                    : float(defenseSkillValue) / float(reqDefForMaxHeal);

            int32 healAmount = int32(victim->CountPctFromMaxHealth(uint32(healPct * pctFromDefense)));
            victim->CastCustomSpell(PAL_SPELL_ARDENT_DEFENDER_HEAL, SPELLVALUE_BASE_POINT0, healAmount, victim, true, nullptr, aurEff);
        }
        else if (remainingHealth < int32(allowedHealth))
        {
            // Reduce damage that brings us under 35% (or full damage if we are already under 35%) by x%
            uint32 damageToReduce = (victim->GetHealth() < allowedHealth)
                                    ? dmgInfo.GetDamage()
                                    : allowedHealth - remainingHealth;
            absorbAmount = CalculatePct(damageToReduce, absorbPct);
        }
    }

    void Register() override
    {
        DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_pal_ardent_defender::CalculateAmount, EFFECT_0, SPELL_AURA_SCHOOL_ABSORB);
        OnEffectAbsorb += AuraEffectAbsorbFn(spell_pal_ardent_defender::Absorb, EFFECT_0);
    }
};

// 31821 - Aura Mastery
class spell_pal_aura_mastery : public AuraScript
{
    PrepareAuraScript(spell_pal_aura_mastery);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_PALADIN_AURA_MASTERY_IMMUNE });
    }

    void HandleEffectApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        GetTarget()->CastSpell(GetTarget(), SPELL_PALADIN_AURA_MASTERY_IMMUNE, true);
    }

    void HandleEffectRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        GetTarget()->RemoveOwnedAura(SPELL_PALADIN_AURA_MASTERY_IMMUNE, GetCasterGUID());
    }

    void Register() override
    {
        AfterEffectApply += AuraEffectApplyFn(spell_pal_aura_mastery::HandleEffectApply, EFFECT_0, SPELL_AURA_ADD_PCT_MODIFIER, AURA_EFFECT_HANDLE_REAL);
        AfterEffectRemove += AuraEffectRemoveFn(spell_pal_aura_mastery::HandleEffectRemove, EFFECT_0, SPELL_AURA_ADD_PCT_MODIFIER, AURA_EFFECT_HANDLE_REAL);
    }
};

// 64364 - Aura Mastery Immune
class spell_pal_aura_mastery_immune : public AuraScript
{
    PrepareAuraScript(spell_pal_aura_mastery_immune);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_PALADIN_CONCENTRACTION_AURA });
    }

    bool CheckAreaTarget(Unit* target)
    {
        return target->HasAura(SPELL_PALADIN_CONCENTRACTION_AURA, GetCasterGUID());
    }

    void Register() override
    {
        DoCheckAreaTarget += AuraCheckAreaTargetFn(spell_pal_aura_mastery_immune::CheckAreaTarget);
    }
};

// 53563 - Beacon of Light
class spell_pal_beacon_of_light : public AuraScript
{
    PrepareAuraScript(spell_pal_beacon_of_light);

    bool Validate(SpellInfo const* spellInfo) override
    {
        return ValidateSpellInfo({ spellInfo->Effects[EFFECT_0].TriggerSpell });
    }

    void PeriodicTick(AuraEffect const* aurEff)
    {
        PreventDefaultAction();

        // area aura owner casts the spell
        Unit* owner = GetAura()->GetUnitOwner();
        uint32 triggerSpell = GetSpellInfo()->Effects[aurEff->GetEffIndex()].TriggerSpell;
        owner->CastSpell(GetTarget(), triggerSpell, true, nullptr, aurEff, owner->GetGUID());
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_pal_beacon_of_light::PeriodicTick, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
    }
};

// 31884 - Avenging Wrath
class spell_pal_avenging_wrath : public AuraScript
{
    PrepareAuraScript(spell_pal_avenging_wrath);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo(
        {
            SPELL_PALADIN_SANCTIFIED_WRATH,
            SPELL_PALADIN_SANCTIFIED_WRATH_TALENT_R1,
            SPELL_PALADIN_AVENGING_WRATH_MARKER,
            SPELL_PALADIN_IMMUNE_SHIELD_MARKER
        });
    }

    void HandleApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        Unit* target = GetTarget();

        if (AuraEffect const* sanctifiedWrathAurEff = target->GetAuraEffectOfRankedSpell(SPELL_PALADIN_SANCTIFIED_WRATH_TALENT_R1, EFFECT_2))
        {
            int32 basepoints = sanctifiedWrathAurEff->GetAmount();
            target->CastCustomSpell(target, SPELL_PALADIN_SANCTIFIED_WRATH, &basepoints, &basepoints, nullptr, true, nullptr, sanctifiedWrathAurEff);
        }
    }

    void HandleRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        GetTarget()->RemoveAurasDueToSpell(SPELL_PALADIN_SANCTIFIED_WRATH);
    }

    void Register() override
    {
        AfterEffectApply += AuraEffectApplyFn(spell_pal_avenging_wrath::HandleApply, EFFECT_0, SPELL_AURA_MOD_DAMAGE_PERCENT_DONE, AURA_EFFECT_HANDLE_REAL);
        AfterEffectRemove += AuraEffectRemoveFn(spell_pal_avenging_wrath::HandleRemove, EFFECT_0, SPELL_AURA_MOD_DAMAGE_PERCENT_DONE, AURA_EFFECT_HANDLE_REAL);
    }
};

// 37877 - Blessing of Faith
class spell_pal_blessing_of_faith : public SpellScript
{
    PrepareSpellScript(spell_pal_blessing_of_faith);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo(
            {
                SPELL_PALADIN_BLESSING_OF_LOWER_CITY_DRUID,
                SPELL_PALADIN_BLESSING_OF_LOWER_CITY_PALADIN,
                SPELL_PALADIN_BLESSING_OF_LOWER_CITY_PRIEST,
                SPELL_PALADIN_BLESSING_OF_LOWER_CITY_SHAMAN
            });
    }

    void HandleDummy(SpellEffIndex /*effIndex*/)
    {
        if (Unit* unitTarget = GetHitUnit())
        {
            uint32 spell_id = 0;
            switch (unitTarget->getClass())
            {
                case CLASS_DRUID:
                    spell_id = SPELL_PALADIN_BLESSING_OF_LOWER_CITY_DRUID;
                    break;
                case CLASS_PALADIN:
                    spell_id = SPELL_PALADIN_BLESSING_OF_LOWER_CITY_PALADIN;
                    break;
                case CLASS_PRIEST:
                    spell_id = SPELL_PALADIN_BLESSING_OF_LOWER_CITY_PRIEST;
                    break;
                case CLASS_SHAMAN:
                    spell_id = SPELL_PALADIN_BLESSING_OF_LOWER_CITY_SHAMAN;
                    break;
                default:
                    return; // ignore for non-healing classes
            }
            Unit* caster = GetCaster();
            caster->CastSpell(caster, spell_id, true);
        }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_pal_blessing_of_faith::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

// 20911 - Blessing of Sanctuary
// 25899 - Greater Blessing of Sanctuary
class spell_pal_blessing_of_sanctuary : public AuraScript
{
    PrepareAuraScript(spell_pal_blessing_of_sanctuary);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_PALADIN_BLESSING_OF_SANCTUARY_BUFF, SPELL_PALADIN_BLESSING_OF_SANCTUARY_ENERGIZE });
    }

    void HandleEffectApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        Unit* target = GetTarget();
        if (Unit* caster = GetCaster())
            caster->CastSpell(target, SPELL_PALADIN_BLESSING_OF_SANCTUARY_BUFF, true);
    }

    void HandleEffectRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        Unit* target = GetTarget();
        target->RemoveAura(SPELL_PALADIN_BLESSING_OF_SANCTUARY_BUFF, GetCasterGUID());
    }

    bool CheckProc(ProcEventInfo& /*eventInfo*/)
    {
        return GetTarget()->HasActivePowerType(POWER_MANA);
    }

    void HandleProc(AuraEffect const* aurEff, ProcEventInfo& /*eventInfo*/)
    {
        PreventDefaultAction();
        GetTarget()->CastSpell(GetTarget(), SPELL_PALADIN_BLESSING_OF_SANCTUARY_ENERGIZE, true, nullptr, aurEff);
    }

    void Register() override
    {
        AfterEffectApply += AuraEffectApplyFn(spell_pal_blessing_of_sanctuary::HandleEffectApply, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL_OR_REAPPLY_MASK);
        AfterEffectRemove += AuraEffectRemoveFn(spell_pal_blessing_of_sanctuary::HandleEffectRemove, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL_OR_REAPPLY_MASK);
        DoCheckProc += AuraCheckProcFn(spell_pal_blessing_of_sanctuary::CheckProc);
        OnEffectProc += AuraEffectProcFn(spell_pal_blessing_of_sanctuary::HandleProc, EFFECT_0, SPELL_AURA_DUMMY);
    }
};

// 64205 - Divine Sacrifice
class spell_pal_divine_sacrifice : public AuraScript
{
    PrepareAuraScript(spell_pal_divine_sacrifice);

    uint32 groupSize, minHpPct;
    int32 remainingAmount;

    bool Load() override
    {
        if (Unit* caster = GetCaster())
        {
            if (caster->IsPlayer())
            {
                if (caster->ToPlayer()->GetGroup())
                    groupSize = caster->ToPlayer()->GetGroup()->GetMembersCount();
                else
                    groupSize = 1;
            }
            else
                return false;

            remainingAmount = (caster->CountPctFromMaxHealth(GetSpellInfo()->Effects[EFFECT_2].CalcValue(caster)) * groupSize);
            minHpPct = GetSpellInfo()->Effects[EFFECT_1].CalcValue(caster);
            return true;
        }
        return false;
    }

    void Split(AuraEffect* /*aurEff*/, DamageInfo& /*dmgInfo*/, uint32& splitAmount)
    {
        remainingAmount -= splitAmount;
        // break when absorbed everything it could, or if the casters hp drops below 20%
        if (Unit* caster = GetCaster())
            if (remainingAmount <= 0 || (caster->GetHealthPct() < minHpPct))
                caster->RemoveAura(SPELL_PALADIN_DIVINE_SACRIFICE);
    }

    void Register() override
    {
        OnEffectSplit += AuraEffectSplitFn(spell_pal_divine_sacrifice::Split, EFFECT_0);
    }
};

// 53385 - Divine Storm
class spell_pal_divine_storm : public SpellScript
{
    PrepareSpellScript(spell_pal_divine_storm);

    uint32 healPct;

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_PALADIN_DIVINE_STORM_DUMMY });
    }

    bool Load() override
    {
        healPct = GetSpellInfo()->Effects[EFFECT_1].CalcValue(GetCaster());
        return true;
    }

    void TriggerHeal()
    {
        Unit* caster = GetCaster();
        if (GetHitUnit() != caster)
            caster->CastCustomSpell(SPELL_PALADIN_DIVINE_STORM_DUMMY, SPELLVALUE_BASE_POINT0, (GetHitDamage() * healPct) / 100, caster, true);
    }

    void Register() override
    {
        AfterHit += SpellHitFn(spell_pal_divine_storm::TriggerHeal);
    }
};

// 54171 - Divine Storm (Dummy)
class spell_pal_divine_storm_dummy : public SpellScript
{
    PrepareSpellScript(spell_pal_divine_storm_dummy);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_PALADIN_DIVINE_STORM_HEAL });
    }

    void CountTargets(std::list<WorldObject*>& targetList)
    {
        Acore::Containers::RandomResize(targetList, GetSpellValue()->MaxAffectedTargets);
        _targetCount = targetList.size();
    }

    void HandleDummy(SpellEffIndex /*effIndex*/)
    {
        if (!_targetCount || ! GetHitUnit())
            return;

        int32 heal = GetEffectValue() / _targetCount;
        GetCaster()->CastCustomSpell(GetHitUnit(), SPELL_PALADIN_DIVINE_STORM_HEAL, &heal, nullptr, nullptr, true);
    }
private:
    uint32 _targetCount;

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_pal_divine_storm_dummy::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_pal_divine_storm_dummy::CountTargets, EFFECT_0, TARGET_UNIT_CASTER_AREA_RAID);
    }
};

// 33695 - Exorcism and Holy Wrath Damage
class spell_pal_exorcism_and_holy_wrath_damage : public AuraScript
{
    PrepareAuraScript(spell_pal_exorcism_and_holy_wrath_damage);

    void HandleEffectCalcSpellMod(AuraEffect const* aurEff, SpellModifier*& spellMod)
    {
        if (!spellMod)
        {
            spellMod = new SpellModifier(aurEff->GetBase());
            spellMod->op = SPELLMOD_DAMAGE;
            spellMod->type = SPELLMOD_FLAT;
            spellMod->spellId = GetId();
            spellMod->mask[1] = 0x200002;
        }

        spellMod->value = aurEff->GetAmount();
    }

    void Register() override
    {
        DoEffectCalcSpellMod += AuraEffectCalcSpellModFn(spell_pal_exorcism_and_holy_wrath_damage::HandleEffectCalcSpellMod, EFFECT_0, SPELL_AURA_DUMMY);
    }
};

// -9799 - Eye for an Eye
class spell_pal_eye_for_an_eye : public AuraScript
{
    PrepareAuraScript(spell_pal_eye_for_an_eye);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_PALADIN_EYE_FOR_AN_EYE_DAMAGE });
    }

    void OnProc(AuraEffect const* aurEff, ProcEventInfo& eventInfo)
    {
        PreventDefaultAction();

        DamageInfo* damageInfo = eventInfo.GetDamageInfo();

        if (!damageInfo || !damageInfo->GetDamage())
        {
            return;
        }

        // return damage % to attacker but < 50% own total health
        int32 damage = std::min(CalculatePct(static_cast<int32>(damageInfo->GetDamage()), aurEff->GetAmount()), static_cast<int32>(GetTarget()->GetMaxHealth()) / 2);
        GetTarget()->CastCustomSpell(SPELL_PALADIN_EYE_FOR_AN_EYE_DAMAGE, SPELLVALUE_BASE_POINT0, damage, eventInfo.GetProcTarget(), true, nullptr, aurEff);
    }

    void Register() override
    {
        OnEffectProc += AuraEffectProcFn(spell_pal_eye_for_an_eye::OnProc, EFFECT_0, SPELL_AURA_DUMMY);
    }
};

// 54968 - Glyph of Holy Light
class spell_pal_glyph_of_holy_light : public SpellScript
{
    PrepareSpellScript(spell_pal_glyph_of_holy_light);

    void FilterTargets(std::list<WorldObject*>& targets)
    {
        targets.remove(GetExplTargetUnit());

        uint32 const maxTargets = GetSpellInfo()->MaxAffectedTargets;
        if (targets.size() > maxTargets)
        {
            targets.sort(Acore::HealthPctOrderPred());
            targets.resize(maxTargets);
        }
    }

    void Register() override
    {
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_pal_glyph_of_holy_light::FilterTargets, EFFECT_0, TARGET_UNIT_DEST_AREA_ALLY);
    }
};

// 63521 - Guarded by The Light
class spell_pal_guarded_by_the_light : public SpellScript
{
    PrepareSpellScript(spell_pal_guarded_by_the_light);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_PALADIN_DIVINE_PLEA });
    }

    void HandleScriptEffect(SpellEffIndex /*effIndex*/)
    {
        // Divine Plea
        if (Aura* aura = GetCaster()->GetAura(SPELL_PALADIN_DIVINE_PLEA))
            aura->RefreshDuration();
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_pal_guarded_by_the_light::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

// 6940 - Hand of Sacrifice
class spell_pal_hand_of_sacrifice_aura : public AuraScript
{
    PrepareAuraScript(spell_pal_hand_of_sacrifice_aura);

    int32 remainingAmount;

    bool Load() override
    {
        if (Unit* caster = GetCaster())
        {
            remainingAmount = caster->GetMaxHealth();
            return true;
        }
        return false;
    }

    void Split(AuraEffect* /*aurEff*/, DamageInfo& /*dmgInfo*/, uint32& splitAmount)
    {
        remainingAmount -= splitAmount;

        if (remainingAmount <= 0)
        {
            GetTarget()->RemoveAura(SPELL_PALADIN_HAND_OF_SACRIFICE);
        }
    }

    void Register() override
    {
        OnEffectSplit += AuraEffectSplitFn(spell_pal_hand_of_sacrifice_aura::Split, EFFECT_0);
    }
};

class spell_pal_hand_of_sacrifice : public SpellScript
{
    PrepareSpellScript(spell_pal_hand_of_sacrifice);

    SpellCastResult CheckTarget()
    {
        Unit* target = GetExplTargetUnit();
        if (!target || target->HasAura(SPELL_PALADIN_DIVINE_SACRIFICE))
            return SPELL_FAILED_TARGET_AURASTATE;

        return SPELL_CAST_OK;
    }

    void Register() override
    {
        OnCheckCast += SpellCheckCastFn(spell_pal_hand_of_sacrifice::CheckTarget);
    }
};

// 1038 - Hand of Salvation
class spell_pal_hand_of_salvation : public AuraScript
{
    PrepareAuraScript(spell_pal_hand_of_salvation);

    void CalculateAmount(AuraEffect const* /*aurEff*/, int32& amount, bool& /*canBeRecalculated*/)
    {
        if (Unit* caster = GetCaster())
        {
            // Glyph of Salvation
            if (caster->GetGUID() == GetUnitOwner()->GetGUID())
                if (AuraEffect const* aurEff = caster->GetAuraEffect(SPELL_PALADIN_GLYPH_OF_SALVATION, EFFECT_0))
                    amount -= aurEff->GetAmount();
        }
    }

    void Register() override
    {
        DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_pal_hand_of_salvation::CalculateAmount, EFFECT_1, SPELL_AURA_MOD_DAMAGE_PERCENT_TAKEN);
    }
};

// -20473 - Holy Shock
class spell_pal_holy_shock : public SpellScript
{
    PrepareSpellScript(spell_pal_holy_shock);

    bool Validate(SpellInfo const* spellInfo) override
    {
        SpellInfo const* firstRankSpellInfo = sSpellMgr->GetSpellInfo(SPELL_PALADIN_HOLY_SHOCK_R1);
        if (!firstRankSpellInfo)
            return false;

        // can't use other spell than holy shock due to spell_ranks dependency
        if (!spellInfo->IsRankOf(firstRankSpellInfo))
            return false;

        uint8 rank = spellInfo->GetRank();
        if (!sSpellMgr->GetSpellWithRank(SPELL_PALADIN_HOLY_SHOCK_R1_DAMAGE, rank, true) || !sSpellMgr->GetSpellWithRank(SPELL_PALADIN_HOLY_SHOCK_R1_HEALING, rank, true))
            return false;

        return true;
    }

    void HandleDummy(SpellEffIndex /*effIndex*/)
    {
        Unit* caster = GetCaster();
        if (Unit* unitTarget = GetHitUnit())
        {
            uint8 rank = GetSpellInfo()->GetRank();
            if (caster->IsFriendlyTo(unitTarget))
                caster->CastSpell(unitTarget, sSpellMgr->GetSpellWithRank(SPELL_PALADIN_HOLY_SHOCK_R1_HEALING, rank), true);
            else
                caster->CastSpell(unitTarget, sSpellMgr->GetSpellWithRank(SPELL_PALADIN_HOLY_SHOCK_R1_DAMAGE, rank), true);
        }
    }

    SpellCastResult CheckCast()
    {
        Unit* caster = GetCaster();
        if (Unit* target = GetExplTargetUnit())
        {
            if (!caster->IsFriendlyTo(target))
            {
                if (!caster->IsValidAttackTarget(target))
                    return SPELL_FAILED_BAD_TARGETS;

                if (!caster->isInFront(target))
                    return SPELL_FAILED_UNIT_NOT_INFRONT;
            }
        }
        else
            return SPELL_FAILED_BAD_TARGETS;
        return SPELL_CAST_OK;
    }

    void Register() override
    {
        OnCheckCast += SpellCheckCastFn(spell_pal_holy_shock::CheckCast);
        OnEffectHitTarget += SpellEffectFn(spell_pal_holy_shock::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

// 53407 - Judgement of Justice
// 20271 - Judgement of Light
// 53408 - Judgement of Wisdom
class spell_pal_judgement : public SpellScript
{
    PrepareSpellScript(spell_pal_judgement);

public:
    spell_pal_judgement(uint32 spellId) : SpellScript(), _spellId(spellId) { }

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_PALADIN_JUDGEMENT_DAMAGE, _spellId });
    }

    void HandleScriptEffect(SpellEffIndex /*effIndex*/)
    {
        uint32 spellId2 = SPELL_PALADIN_JUDGEMENT_DAMAGE;

        // some seals have SPELL_AURA_DUMMY in EFFECT_2
        Unit::AuraEffectList const& auras = GetCaster()->GetAuraEffectsByType(SPELL_AURA_DUMMY);
        for (Unit::AuraEffectList::const_iterator i = auras.begin(); i != auras.end(); ++i)
        {
            if ((*i)->GetSpellInfo()->GetSpellSpecific() == SPELL_SPECIFIC_SEAL && (*i)->GetEffIndex() == EFFECT_2)
                if (sSpellMgr->GetSpellInfo((*i)->GetAmount()))
                {
                    spellId2 = (*i)->GetAmount();
                    break;
                }
        }

        GetCaster()->CastSpell(GetHitUnit(), _spellId, true);
        GetCaster()->CastSpell(GetHitUnit(), spellId2, true);

        // Tier 5 Holy - 2 Set
        if (GetCaster()->HasAura(SPELL_IMPROVED_JUDGEMENT))
        {
            GetCaster()->CastSpell(GetCaster(), SPELL_IMPROVED_JUDGEMENT_ENERGIZE, true);
        }

        // Judgement of the Just
        if (GetCaster()->GetAuraEffect(SPELL_AURA_ADD_FLAT_MODIFIER, SPELLFAMILY_PALADIN, 3015, 0))
        {
            if (GetCaster()->CastSpell(GetHitUnit(), SPELL_JUDGEMENTS_OF_THE_JUST, true) && (spellId2 == SPELL_JUDGEMENT_OF_VENGEANCE_EFFECT || spellId2 == SPELL_JUDGEMENT_OF_CORRUPTION_EFFECT))
            {
                //hidden effect only cast when spellcast of judgements of the just is succesful
                GetCaster()->CastSpell(GetHitUnit(), SealApplication(spellId2), true); //add hidden seal apply effect for vengeance and corruption
            }
        }
    }

    uint32 SealApplication(uint32 correspondingSpellId)
    {
        switch (correspondingSpellId)
        {
            case SPELL_JUDGEMENT_OF_VENGEANCE_EFFECT:
                return SPELL_HOLY_VENGEANCE;
            case SPELL_JUDGEMENT_OF_CORRUPTION_EFFECT:
                return SPELL_BLOOD_CORRUPTION;
            default:
                return 0;
        }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_pal_judgement::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }

private:
    uint32 const _spellId;
};

// 20425 - Judgement of Command
class spell_pal_judgement_of_command : public SpellScript
{
    PrepareSpellScript(spell_pal_judgement_of_command);

    void HandleDummy(SpellEffIndex /*effIndex*/)
    {
        if (Unit* unitTarget = GetHitUnit())
            if (SpellInfo const* spell_proto = sSpellMgr->GetSpellInfo(GetEffectValue()))
                GetCaster()->CastSpell(unitTarget, spell_proto, true, nullptr);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_pal_judgement_of_command::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

// -633 - Lay on Hands
class spell_pal_lay_on_hands : public SpellScript
{
    PrepareSpellScript(spell_pal_lay_on_hands);

    bool Validate(SpellInfo const* /*spell*/) override
    {
        return ValidateSpellInfo(
            {
                SPELL_PALADIN_FORBEARANCE,
                SPELL_PALADIN_AVENGING_WRATH_MARKER,
                SPELL_PALADIN_IMMUNE_SHIELD_MARKER
            });
    }

    bool Load() override
    {
        _manaAmount = 0;
        return true;
    }

    void HandleMaxHealthHeal(SpellEffIndex /*effIndex*/)
    {
        Unit* caster = GetCaster();
        Unit* target = GetExplTargetUnit();

        if (!target || !caster)
            return;

        uint32 baseHeal = caster->GetMaxHealth();
        uint32 modifiedHeal = target->SpellHealingBonusTaken(caster, GetSpellInfo(), baseHeal, HEAL);

        // EffectHealMaxHealth() ignores healing modifiers, so we pre-apply the
        // difference here; this delta will be added on top of the raw heal.
        int64 healAdjustment = int64(modifiedHeal) - int64(baseHeal);

        SetHitHeal(healAdjustment);
    }

    SpellCastResult CheckCast()
    {
        Unit* caster = GetCaster();
        if (Unit* target = GetExplTargetUnit())
            if (caster == target)
                if (target->HasAnyAuras(SPELL_PALADIN_FORBEARANCE, SPELL_PALADIN_AVENGING_WRATH_MARKER, SPELL_PALADIN_IMMUNE_SHIELD_MARKER))
                    return SPELL_FAILED_TARGET_AURASTATE;

        // Xinef: Glyph of Divinity
        if (Unit* target = GetExplTargetUnit())
            if (target->HasActivePowerType(POWER_MANA))
                _manaAmount = target->GetPower(POWER_MANA);

        return SPELL_CAST_OK;
    }

    void HandleScript()
    {
        Unit* caster = GetCaster();
        Unit* target = GetHitUnit();
        if (caster == target)
        {
            caster->CastSpell(caster, SPELL_PALADIN_FORBEARANCE, true);
            caster->CastSpell(caster, SPELL_PALADIN_AVENGING_WRATH_MARKER, true);
            caster->CastSpell(caster, SPELL_PALADIN_IMMUNE_SHIELD_MARKER, true);
        }
        // Xinef: Glyph of Divinity
        else if (target && caster->HasAura(54939) && GetSpellInfo()->Id != 633 && _manaAmount > 0) // excluding first rank
        {
            _manaAmount = target->GetPower(POWER_MANA) - _manaAmount;
            if (_manaAmount > 0)
                caster->CastCustomSpell(54986 /*Energize*/, SPELLVALUE_BASE_POINT1, _manaAmount, caster, true);
        }
    }

    void Register() override
    {
        OnCheckCast += SpellCheckCastFn(spell_pal_lay_on_hands::CheckCast);
        AfterHit += SpellHitFn(spell_pal_lay_on_hands::HandleScript);
        OnEffectHitTarget += SpellEffectFn(spell_pal_lay_on_hands::HandleMaxHealthHeal, EFFECT_0, SPELL_EFFECT_HEAL_MAX_HEALTH);
    }

    int32 _manaAmount;
};

// 31789 - Righteous Defense
class spell_pal_righteous_defense : public SpellScript
{
    PrepareSpellScript(spell_pal_righteous_defense);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_PALADIN_RIGHTEOUS_DEFENSE_TAUNT });
    }

    SpellCastResult CheckCast()
    {
        Unit* caster = GetCaster();
        if (!caster->IsPlayer())
            return SPELL_FAILED_DONT_REPORT;

        if (Unit* target = GetExplTargetUnit())
        {
            if (!target->IsFriendlyTo(caster) || target->getAttackers().empty())
                return SPELL_FAILED_BAD_TARGETS;
        }
        else
            return SPELL_FAILED_BAD_TARGETS;

        return SPELL_CAST_OK;
    }

    void HandleTriggerSpellLaunch(SpellEffIndex effIndex)
    {
        PreventHitDefaultEffect(effIndex);
    }

    void HandleTriggerSpellHit(SpellEffIndex effIndex)
    {
        PreventHitDefaultEffect(effIndex);
        if (Unit* target = GetHitUnit())
            GetCaster()->CastSpell(target, SPELL_PALADIN_RIGHTEOUS_DEFENSE_TAUNT, true);
    }

    void Register() override
    {
        OnCheckCast += SpellCheckCastFn(spell_pal_righteous_defense::CheckCast);
        //! WORKAROUND
        //! target select will be executed in hitphase of effect 0
        //! so we must handle trigger spell also in hit phase (default execution in launch phase)
        //! see issue #3718
        OnEffectLaunchTarget += SpellEffectFn(spell_pal_righteous_defense::HandleTriggerSpellLaunch, EFFECT_1, SPELL_EFFECT_TRIGGER_SPELL);
        OnEffectHitTarget += SpellEffectFn(spell_pal_righteous_defense::HandleTriggerSpellHit, EFFECT_1, SPELL_EFFECT_TRIGGER_SPELL);
    }
};

// 20154, 21084 - Seal of Righteousness - melee proc dummy (addition ${$MWS*(0.022*$AP+0.044*$SPH)} damage)
class spell_pal_seal_of_righteousness : public AuraScript
{
    PrepareAuraScript(spell_pal_seal_of_righteousness);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_PALADIN_SEAL_OF_RIGHTEOUSNESS });
    }

    bool CheckProc(ProcEventInfo& eventInfo)
    {
        Unit* target = eventInfo.GetProcTarget();
        if (!target)
            return false;

        DamageInfo* damageInfo = eventInfo.GetDamageInfo();

        if (!damageInfo || !damageInfo->GetDamage())
        {
            return false;
        }

        return target->IsAlive() && !eventInfo.GetTriggerAuraSpell() && (damageInfo->GetDamage() || (eventInfo.GetHitMask() & PROC_EX_ABSORB));
    }

    void HandleProc(AuraEffect const* aurEff, ProcEventInfo& eventInfo)
    {
        PreventDefaultAction();

        float ap = GetTarget()->GetTotalAttackPowerValue(BASE_ATTACK);
        int32 holy = GetTarget()->SpellBaseDamageBonusDone(SPELL_SCHOOL_MASK_HOLY);
        holy += eventInfo.GetProcTarget()->SpellBaseDamageBonusTaken(SPELL_SCHOOL_MASK_HOLY);

        // Xinef: Libram of Divine Purpose
        if (AuraEffect* aurEffPaladin = GetTarget()->GetDummyAuraEffect(SPELLFAMILY_PALADIN, 2025, EFFECT_0))
        {
            holy += aurEffPaladin->GetAmount();
        }

        int32 bp = std::max<int32>(0, int32((ap * 0.022f + 0.044f * holy) * GetTarget()->GetAttackTime(BASE_ATTACK) / 1000));
        GetTarget()->CastCustomSpell(SPELL_PALADIN_SEAL_OF_RIGHTEOUSNESS, SPELLVALUE_BASE_POINT0, bp, eventInfo.GetProcTarget(), true, nullptr, aurEff);
    }

    void Register() override
    {
        DoCheckProc += AuraCheckProcFn(spell_pal_seal_of_righteousness::CheckProc);
        OnEffectProc += AuraEffectProcFn(spell_pal_seal_of_righteousness::HandleProc, EFFECT_0, SPELL_AURA_DUMMY);
    }
};

// -31876 - Judgements of the Wise
class spell_pal_judgements_of_the_wise : public AuraScript
{
    PrepareAuraScript(spell_pal_judgements_of_the_wise);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_PALADIN_JUDGEMENTS_OF_THE_WISE_MANA, SPELL_PALADIN_REPLENISHMENT });
    }

    void HandleProc(AuraEffect const* aurEff, ProcEventInfo& /*eventInfo*/)
    {
        PreventDefaultAction();
        Unit* caster = GetTarget();
        caster->CastSpell(caster, SPELL_PALADIN_JUDGEMENTS_OF_THE_WISE_MANA, true, nullptr, aurEff);
        caster->CastSpell(caster, SPELL_PALADIN_REPLENISHMENT, true, nullptr, aurEff);
    }

    void Register() override
    {
        OnEffectProc += AuraEffectProcFn(spell_pal_judgements_of_the_wise::HandleProc, EFFECT_0, SPELL_AURA_DUMMY);
    }
};

// -53380 - Righteous Vengeance
class spell_pal_righteous_vengeance : public AuraScript
{
    PrepareAuraScript(spell_pal_righteous_vengeance);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_PALADIN_RIGHTEOUS_VENGEANCE_DOT });
    }

    void HandleProc(AuraEffect const* aurEff, ProcEventInfo& eventInfo)
    {
        PreventDefaultAction();
        Unit* target = eventInfo.GetActionTarget();
        if (!target)
            return;

        DamageInfo* damageInfo = eventInfo.GetDamageInfo();
        if (!damageInfo || !damageInfo->GetDamage())
            return;

        // Calculate total DoT damage (percentage of crit damage), divided by 4 ticks
        int32 amount = CalculatePct(static_cast<int32>(damageInfo->GetDamage()), aurEff->GetAmount()) / 4;
        target->CastDelayedSpellWithPeriodicAmount(GetTarget(), SPELL_PALADIN_RIGHTEOUS_VENGEANCE_DOT, SPELL_AURA_PERIODIC_DAMAGE, amount);
    }

    void Register() override
    {
        OnEffectProc += AuraEffectProcFn(spell_pal_righteous_vengeance::HandleProc, EFFECT_0, SPELL_AURA_DUMMY);
    }
};

// -53501 - Sheath of Light
class spell_pal_sheath_of_light : public AuraScript
{
    PrepareAuraScript(spell_pal_sheath_of_light);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_PALADIN_SHEATH_OF_LIGHT_HOT });
    }

    bool CheckProc(ProcEventInfo& eventInfo)
    {
        HealInfo* healInfo = eventInfo.GetHealInfo();
        return healInfo && healInfo->GetHeal();
    }

    void HandleProc(AuraEffect const* aurEff, ProcEventInfo& eventInfo)
    {
        PreventDefaultAction();

        Unit* caster = eventInfo.GetActor();
        Unit* target = eventInfo.GetActionTarget();

        SpellInfo const* spellInfo = sSpellMgr->AssertSpellInfo(SPELL_PALADIN_SHEATH_OF_LIGHT_HOT);
        int32 amount = CalculatePct(static_cast<int32>(eventInfo.GetHealInfo()->GetHeal()), aurEff->GetAmount());

        ASSERT(spellInfo->GetMaxTicks() > 0);
        amount /= spellInfo->GetMaxTicks();

        caster->CastCustomSpell(SPELL_PALADIN_SHEATH_OF_LIGHT_HOT, SPELLVALUE_BASE_POINT0, amount, target, true, nullptr, aurEff);
    }

    void Register() override
    {
        DoCheckProc += AuraCheckProcFn(spell_pal_sheath_of_light::CheckProc);
        OnEffectProc += AuraEffectProcFn(spell_pal_sheath_of_light::HandleProc, EFFECT_1, SPELL_AURA_DUMMY);
    }
};

// 20185 - Judgement of Light (debuff on target)
class spell_pal_judgement_of_light_heal : public AuraScript
{
    PrepareAuraScript(spell_pal_judgement_of_light_heal);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_PALADIN_JUDGEMENT_OF_LIGHT_HEAL });
    }

    void HandleProc(AuraEffect const* aurEff, ProcEventInfo& eventInfo)
    {
        PreventDefaultAction();

        Unit* attacker = eventInfo.GetActor();
        if (!attacker)
            return;

        int32 bp = int32(attacker->CountPctFromMaxHealth(aurEff->GetAmount()));
        attacker->CastCustomSpell(attacker, SPELL_PALADIN_JUDGEMENT_OF_LIGHT_HEAL, &bp, nullptr, nullptr, true, nullptr, aurEff, GetCasterGUID());
    }

    void Register() override
    {
        OnEffectProc += AuraEffectProcFn(spell_pal_judgement_of_light_heal::HandleProc, EFFECT_0, SPELL_AURA_DUMMY);
    }
};

// 20186 - Judgement of Wisdom (debuff on target)
class spell_pal_judgement_of_wisdom_mana : public AuraScript
{
    PrepareAuraScript(spell_pal_judgement_of_wisdom_mana);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_PALADIN_JUDGEMENT_OF_WISDOM_MANA });
    }

    bool CheckProc(ProcEventInfo& eventInfo)
    {
        return eventInfo.GetActor()->getPowerType() == POWER_MANA;
    }

    void HandleProc(AuraEffect const* aurEff, ProcEventInfo& eventInfo)
    {
        PreventDefaultAction();

        Unit* attacker = eventInfo.GetActor();
        if (!attacker)
            return;

        int32 bp = int32(CalculatePct(attacker->GetCreateMana(), aurEff->GetAmount()));
        attacker->CastCustomSpell(attacker, SPELL_PALADIN_JUDGEMENT_OF_WISDOM_MANA, &bp, nullptr, nullptr, true, nullptr, aurEff, GetCasterGUID());
    }

    void Register() override
    {
        DoCheckProc += AuraCheckProcFn(spell_pal_judgement_of_wisdom_mana::CheckProc);
        OnEffectProc += AuraEffectProcFn(spell_pal_judgement_of_wisdom_mana::HandleProc, EFFECT_0, SPELL_AURA_DUMMY);
    }
};

// 31785, 33776 - Spiritual Attunement
class spell_pal_spiritual_attunement : public AuraScript
{
    PrepareAuraScript(spell_pal_spiritual_attunement);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_PALADIN_SPIRITUAL_ATTUNEMENT_MANA });
    }

    bool CheckProc(ProcEventInfo& eventInfo)
    {
        // If healed by another unit (not self)
        if (GetTarget() == eventInfo.GetActor())
            return false;

        // Don't allow non-positive spells to proc
        SpellInfo const* procSpell = eventInfo.GetSpellInfo();
        if (!procSpell || !procSpell->IsPositive())
            return false;

        HealInfo const* healInfo = eventInfo.GetHealInfo();
        if (!healInfo || !healInfo->GetEffectiveHeal())
            return false;

        return true;
    }

    void HandleProc(AuraEffect const* aurEff, ProcEventInfo& eventInfo)
    {
        PreventDefaultAction();
        HealInfo const* healInfo = eventInfo.GetHealInfo();
        if (!healInfo)
            return;

        uint32 effectiveHeal = healInfo->GetEffectiveHeal();
        if (!effectiveHeal)
            return;

        int32 bp = int32(CalculatePct(effectiveHeal, aurEff->GetAmount()));
        if (bp)
            GetTarget()->CastCustomSpell(SPELL_PALADIN_SPIRITUAL_ATTUNEMENT_MANA, SPELLVALUE_BASE_POINT0, bp, GetTarget(), true, nullptr, aurEff);
    }

    void Register() override
    {
        DoCheckProc += AuraCheckProcFn(spell_pal_spiritual_attunement::CheckProc);
        OnEffectProc += AuraEffectProcFn(spell_pal_spiritual_attunement::HandleProc, EFFECT_0, SPELL_AURA_DUMMY);
    }
};

// 1022 - Hand of Protection
class spell_pal_hand_of_protection : public SpellScript
{
    PrepareSpellScript(spell_pal_hand_of_protection);

    SpellCastResult CheckCast()
    {
        Unit* caster = GetCaster();

        if (!caster->GetTarget() || caster->GetTarget() == caster->GetGUID())
            return SPELL_CAST_OK;

        if (caster->HasStunAura())
            return SPELL_FAILED_STUNNED;

        if (caster->HasConfuseAura())
            return SPELL_FAILED_CONFUSED;

        if (caster->GetUnitFlags() & UNIT_FLAG_FLEEING)
            return SPELL_FAILED_FLEEING;

        return SPELL_CAST_OK;
    }

    void Register() override
    {
        OnCheckCast += SpellCheckCastFn(spell_pal_hand_of_protection::CheckCast);
    }
};

// -31871 - Divine Purpose
class spell_pal_divine_purpose : public AuraScript
{
    PrepareAuraScript(spell_pal_divine_purpose);

    bool CheckProc(ProcEventInfo& /*eventInfo*/)
    {
        // Get the EFFECT_2 aura effect for the proc chance
        if (AuraEffect const* aurEff = GetEffect(EFFECT_2))
            return roll_chance_i(aurEff->GetAmount());
        return false;
    }

    void HandleProc(AuraEffect const* /*aurEff*/, ProcEventInfo& eventInfo)
    {
        PreventDefaultAction();
        if (Unit* target = eventInfo.GetActionTarget())
            target->RemoveAurasWithMechanic(1 << MECHANIC_STUN, AURA_REMOVE_BY_ENEMY_SPELL);
    }

    void Register() override
    {
        DoCheckProc += AuraCheckProcFn(spell_pal_divine_purpose::CheckProc);
        OnEffectProc += AuraEffectProcFn(spell_pal_divine_purpose::HandleProc, EFFECT_2, SPELL_AURA_DUMMY);
    }
};

// -53569 - Infusion of Light
class spell_pal_infusion_of_light : public AuraScript
{
    PrepareAuraScript(spell_pal_infusion_of_light);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo(
            {
                SPELL_PALADIN_SACRED_SHIELD,
                SPELL_PALADIN_T9_HOLY_4P_BONUS,
                SPELL_PALADIN_FLASH_OF_LIGHT_PROC
            });
    }

    void HandleProc(AuraEffect const* aurEff, ProcEventInfo& eventInfo)
    {
        SpellInfo const* spellInfo = eventInfo.GetSpellInfo();
        if (!spellInfo)
            return;

        // Flash of Light HoT on Flash of Light when Sacred Shield active
        if (spellInfo->SpellFamilyFlags[0] & 0x40000000 && spellInfo->SpellIconID == 242)
        {
            PreventDefaultAction();

            HealInfo* healInfo = eventInfo.GetHealInfo();
            if (!healInfo || !healInfo->GetHeal())
                return;

            Unit* procTarget = eventInfo.GetActionTarget();
            if (procTarget && procTarget->HasAura(SPELL_PALADIN_SACRED_SHIELD))
            {
                Unit* target = GetTarget();
                SpellInfo const* flashProcInfo = sSpellMgr->AssertSpellInfo(SPELL_PALADIN_FLASH_OF_LIGHT_PROC);
                int32 duration = flashProcInfo->GetMaxDuration() / 1000;
                int32 pct = GetSpellInfo()->Effects[EFFECT_2].CalcValue();
                if (duration <= 0)
                    return;

                int32 bp0 = CalculatePct(healInfo->GetHeal() / duration, pct);

                // Item - Paladin T9 Holy 4P Bonus
                if (AuraEffect const* bonus = target->GetAuraEffect(SPELL_PALADIN_T9_HOLY_4P_BONUS, EFFECT_0))
                    AddPct(bp0, bonus->GetAmount());

                target->CastCustomSpell(SPELL_PALADIN_FLASH_OF_LIGHT_PROC, SPELLVALUE_BASE_POINT0, bp0, procTarget, true, nullptr, aurEff);
            }
        }
        // but should not proc on non-critical Holy Shocks
        else if ((spellInfo->SpellFamilyFlags[0] & 0x200000 || spellInfo->SpellFamilyFlags[1] & 0x10000) && !(eventInfo.GetHitMask() & PROC_EX_CRITICAL_HIT))
            PreventDefaultAction();
    }

    void Register() override
    {
        OnEffectProc += AuraEffectProcFn(spell_pal_infusion_of_light::HandleProc, EFFECT_0, SPELL_AURA_PROC_TRIGGER_SPELL);
    }
};

// 40470 - Paladin Tier 6 Trinket
class spell_pal_item_t6_trinket : public AuraScript
{
    PrepareAuraScript(spell_pal_item_t6_trinket);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo(
            {
                SPELL_PALADIN_ENDURING_LIGHT,
                SPELL_PALADIN_ENDURING_JUDGEMENT
            });
    }

    bool CheckProc(ProcEventInfo& eventInfo)
    {
        SpellInfo const* spellInfo = eventInfo.GetSpellInfo();
        if (!spellInfo)
            return false;

        // Holy Light & Flash of Light
        if (spellInfo->SpellFamilyFlags[0] & 0xC0000000)
        {
            if (!roll_chance_i(15))
                return false;

            _triggeredSpellId = SPELL_PALADIN_ENDURING_LIGHT;
            return true;
        }
        // Judgements
        else if (spellInfo->SpellFamilyFlags[0] & 0x00800000)
        {
            if (!roll_chance_i(50))
                return false;

            _triggeredSpellId = SPELL_PALADIN_ENDURING_JUDGEMENT;
            return true;
        }

        return false;
    }

    void HandleProc(AuraEffect const* aurEff, ProcEventInfo& eventInfo)
    {
        PreventDefaultAction();
        eventInfo.GetActor()->CastSpell(eventInfo.GetActionTarget(), _triggeredSpellId, true, nullptr, aurEff);
    }

    void Register() override
    {
        DoCheckProc += AuraCheckProcFn(spell_pal_item_t6_trinket::CheckProc);
        OnEffectProc += AuraEffectProcFn(spell_pal_item_t6_trinket::HandleProc, EFFECT_0, SPELL_AURA_DUMMY);
    }

private:
    uint32 _triggeredSpellId = 0;
};

// 28789 - Holy Power (T3 6P Bonus)
class spell_pal_t3_6p_bonus : public AuraScript
{
    PrepareAuraScript(spell_pal_t3_6p_bonus);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo(
            {
                SPELL_PALADIN_HOLY_POWER_ARMOR,
                SPELL_PALADIN_HOLY_POWER_ATTACK_POWER,
                SPELL_PALADIN_HOLY_POWER_SPELL_POWER,
                SPELL_PALADIN_HOLY_POWER_MP5
            });
    }

    void HandleProc(AuraEffect const* aurEff, ProcEventInfo& eventInfo)
    {
        PreventDefaultAction();

        uint32 spellId;
        Unit* caster = eventInfo.GetActor();
        Unit* target = eventInfo.GetActionTarget();
        if (!target)
            return;

        switch (target->getClass())
        {
            case CLASS_PALADIN:
            case CLASS_PRIEST:
            case CLASS_SHAMAN:
            case CLASS_DRUID:
                spellId = SPELL_PALADIN_HOLY_POWER_MP5;
                break;
            case CLASS_MAGE:
            case CLASS_WARLOCK:
                spellId = SPELL_PALADIN_HOLY_POWER_SPELL_POWER;
                break;
            case CLASS_HUNTER:
            case CLASS_ROGUE:
                spellId = SPELL_PALADIN_HOLY_POWER_ATTACK_POWER;
                break;
            case CLASS_WARRIOR:
                spellId = SPELL_PALADIN_HOLY_POWER_ARMOR;
                break;
            default:
                return;
        }

        caster->CastSpell(target, spellId, true, nullptr, aurEff);
    }

    void Register() override
    {
        OnEffectProc += AuraEffectProcFn(spell_pal_t3_6p_bonus::HandleProc, EFFECT_0, SPELL_AURA_DUMMY);
    }
};

// 64890 - Item - Paladin T8 Holy 2P Bonus
class spell_pal_t8_2p_bonus : public AuraScript
{
    PrepareAuraScript(spell_pal_t8_2p_bonus);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_PALADIN_HOLY_MENDING });
    }

    bool CheckProc(ProcEventInfo& eventInfo)
    {
        HealInfo* healInfo = eventInfo.GetHealInfo();
        return healInfo && healInfo->GetHeal();
    }

    void HandleProc(AuraEffect const* aurEff, ProcEventInfo& eventInfo)
    {
        PreventDefaultAction();

        Unit* caster = eventInfo.GetActor();
        Unit* target = eventInfo.GetActionTarget();
        if (!target)
            return;

        SpellInfo const* spellInfo = sSpellMgr->AssertSpellInfo(SPELL_PALADIN_HOLY_MENDING);
        int32 amount = CalculatePct(static_cast<int32>(eventInfo.GetHealInfo()->GetHeal()), aurEff->GetAmount());

        int32 maxTicks = spellInfo->GetMaxTicks();
        if (maxTicks <= 0)
            return;

        amount /= maxTicks;
        caster->CastCustomSpell(SPELL_PALADIN_HOLY_MENDING, SPELLVALUE_BASE_POINT0, amount, target, true, nullptr, aurEff);
    }

    void Register() override
    {
        DoCheckProc += AuraCheckProcFn(spell_pal_t8_2p_bonus::CheckProc);
        OnEffectProc += AuraEffectProcFn(spell_pal_t8_2p_bonus::HandleProc, EFFECT_0, SPELL_AURA_DUMMY);
    }
};

// -54939 - Glyph of Divinity
class spell_pal_glyph_of_divinity : public AuraScript
{
    PrepareAuraScript(spell_pal_glyph_of_divinity);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_PALADIN_GLYPH_OF_DIVINITY_PROC });
    }

    void OnProc(AuraEffect const* aurEff, ProcEventInfo& eventInfo)
    {
        SpellInfo const* spellInfo = eventInfo.GetSpellInfo();
        if (!spellInfo || !spellInfo->HasEffect(SPELL_EFFECT_ENERGIZE))
            return;

        Unit* caster = eventInfo.GetActor();
        if (caster == eventInfo.GetActionTarget())
            return;

        int32 amount = GetSpellInfo()->Effects[EFFECT_1].CalcValue() * 2;
        caster->CastCustomSpell(SPELL_PALADIN_GLYPH_OF_DIVINITY_PROC, SPELLVALUE_BASE_POINT1, amount, nullptr, true, nullptr, aurEff);
    }

    void Register() override
    {
        OnEffectProc += AuraEffectProcFn(spell_pal_glyph_of_divinity::OnProc, EFFECT_0, SPELL_AURA_ADD_PCT_MODIFIER);
    }
};

// -54936 - Glyph of Holy Light (dummy aura)
class spell_pal_glyph_of_holy_light_dummy : public AuraScript
{
    PrepareAuraScript(spell_pal_glyph_of_holy_light_dummy);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_PALADIN_GLYPH_OF_HOLY_LIGHT_HEAL });
    }

    bool CheckProc(ProcEventInfo& eventInfo)
    {
        HealInfo* healInfo = eventInfo.GetHealInfo();
        return healInfo && healInfo->GetHeal();
    }

    void HandleProc(AuraEffect const* aurEff, ProcEventInfo& eventInfo)
    {
        PreventDefaultAction();

        HealInfo* healInfo = eventInfo.GetHealInfo();

        uint32 basePoints = healInfo->GetSpellInfo()->Effects[EFFECT_0].BasePoints + healInfo->GetSpellInfo()->Effects[EFFECT_0].DieSides;
        uint32 healAmount;
        if (healInfo->GetEffectiveHeal() >= basePoints)
            healAmount = healInfo->GetEffectiveHeal();
        else
            healAmount = healInfo->GetHeal();

        int32 bp0 = CalculatePct(static_cast<int32>(healAmount), aurEff->GetAmount());
        eventInfo.GetActor()->CastCustomSpell(SPELL_PALADIN_GLYPH_OF_HOLY_LIGHT_HEAL, SPELLVALUE_BASE_POINT0, bp0, eventInfo.GetActionTarget(), true, nullptr, aurEff);
    }

    void Register() override
    {
        DoCheckProc += AuraCheckProcFn(spell_pal_glyph_of_holy_light_dummy::CheckProc);
        OnEffectProc += AuraEffectProcFn(spell_pal_glyph_of_holy_light_dummy::HandleProc, EFFECT_0, SPELL_AURA_DUMMY);
    }
};

// -20335 - Heart of the Crusader
class spell_pal_heart_of_the_crusader : public AuraScript
{
    PrepareAuraScript(spell_pal_heart_of_the_crusader);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_PALADIN_HEART_OF_THE_CRUSADER_EFF_R1 });
    }

    void HandleProc(AuraEffect const* aurEff, ProcEventInfo& eventInfo)
    {
        PreventDefaultAction();

        uint32 spellId = sSpellMgr->GetSpellWithRank(SPELL_PALADIN_HEART_OF_THE_CRUSADER_EFF_R1, GetSpellInfo()->GetRank());
        eventInfo.GetActor()->CastSpell(eventInfo.GetActionTarget(), spellId, true, nullptr, aurEff);
    }

    void Register() override
    {
        OnEffectProc += AuraEffectProcFn(spell_pal_heart_of_the_crusader::HandleProc, EFFECT_0, SPELL_AURA_DUMMY);
    }
};

// -20234 - Improved Lay on Hands
class spell_pal_improved_lay_of_hands : public AuraScript
{
    PrepareAuraScript(spell_pal_improved_lay_of_hands);

    bool Validate(SpellInfo const* spellInfo) override
    {
        return ValidateSpellInfo({ spellInfo->Effects[EFFECT_0].TriggerSpell });
    }

    void HandleProc(AuraEffect const* aurEff, ProcEventInfo& eventInfo)
    {
        PreventDefaultAction();
        uint32 triggeredSpell = GetSpellInfo()->Effects[EFFECT_0].TriggerSpell;
        eventInfo.GetActionTarget()->CastSpell(eventInfo.GetActionTarget(), triggeredSpell, true, nullptr, aurEff, GetTarget()->GetGUID());
    }

    void Register() override
    {
        OnEffectProc += AuraEffectProcFn(spell_pal_improved_lay_of_hands::HandleProc, EFFECT_0, SPELL_AURA_PROC_TRIGGER_SPELL);
    }
};

// -53695 - Judgements of the Just
class spell_pal_judgements_of_the_just : public AuraScript
{
    PrepareAuraScript(spell_pal_judgements_of_the_just);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_PALADIN_JUDGEMENTS_OF_THE_JUST_PROC });
    }

    void OnProc(AuraEffect const* aurEff, ProcEventInfo& eventInfo)
    {
        PreventDefaultAction();
        GetTarget()->CastSpell(eventInfo.GetActionTarget(), SPELL_PALADIN_JUDGEMENTS_OF_THE_JUST_PROC, true, nullptr, aurEff);
    }

    void Register() override
    {
        OnEffectProc += AuraEffectProcFn(spell_pal_judgements_of_the_just::OnProc, EFFECT_0, SPELL_AURA_ADD_FLAT_MODIFIER);
    }
};

// 58597 - Sacred Shield (dummy on target)
class spell_pal_sacred_shield_dummy : public AuraScript
{
    PrepareAuraScript(spell_pal_sacred_shield_dummy);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo(
        {
            SPELL_PALADIN_SACRED_SHIELD_TRIGGER,
            SPELL_PALADIN_T8_HOLY_4P_BONUS
        });
    }

    void HandleProc(AuraEffect const* aurEff, ProcEventInfo& /*eventInfo*/)
    {
        PreventDefaultAction();

        Unit* caster = GetCaster();
        if (!caster)
            return;

        std::chrono::steady_clock::time_point now = std::chrono::steady_clock::now();
        if (_cooldownEnd > now)
            return;

        std::chrono::seconds cooldown(aurEff->GetAmount());
        if (AuraEffect const* bonus = caster->GetAuraEffect(SPELL_PALADIN_T8_HOLY_4P_BONUS, EFFECT_0, caster->GetGUID()))
            cooldown = std::chrono::seconds(bonus->GetAmount());

        _cooldownEnd = now + cooldown;
        caster->CastSpell(GetTarget(), SPELL_PALADIN_SACRED_SHIELD_TRIGGER, true, nullptr, aurEff);
    }

    void Register() override
    {
        OnEffectProc += AuraEffectProcFn(spell_pal_sacred_shield_dummy::HandleProc, EFFECT_0, SPELL_AURA_DUMMY);
    }

    std::chrono::steady_clock::time_point _cooldownEnd = std::chrono::steady_clock::time_point::min();
};

// 31801, 53736 - Seal of Vengeance/Corruption (aura proc handler)
class spell_pal_seal_of_vengeance_aura : public AuraScript
{
    PrepareAuraScript(spell_pal_seal_of_vengeance_aura);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo(
        {
            SPELL_PALADIN_HOLY_VENGEANCE,
            SPELL_PALADIN_BLOOD_CORRUPTION,
            SPELL_PALADIN_SEAL_OF_VENGEANCE_EFFECT,
            SPELL_PALADIN_SEAL_OF_CORRUPTION_EFFECT
        });
    }

    bool Load() override
    {
        // Seal of Vengeance = 31801, Seal of Corruption = 53736
        _isVengeance = GetSpellInfo()->Id == 31801;
        return true;
    }

    void HandleApplyDoT(AuraEffect const* aurEff, ProcEventInfo& eventInfo)
    {
        PreventDefaultAction();

        if (!(eventInfo.GetTypeMask() & PROC_FLAG_DONE_MELEE_AUTO_ATTACK))
        {
            SpellInfo const* spellInfo = eventInfo.GetSpellInfo();
            if (!spellInfo || spellInfo->SpellIconID != PALADIN_ICON_HAMMER_OF_THE_RIGHTEOUS)
                return;
        }

        uint32 dotSpell = _isVengeance ? SPELL_PALADIN_HOLY_VENGEANCE : SPELL_PALADIN_BLOOD_CORRUPTION;
        eventInfo.GetActor()->CastSpell(eventInfo.GetActionTarget(), dotSpell, true, nullptr, aurEff);
    }

    void HandleSeal(AuraEffect const* aurEff, ProcEventInfo& eventInfo)
    {
        PreventDefaultAction();

        Unit* caster = eventInfo.GetActor();
        Unit* target = eventInfo.GetActionTarget();

        AuraEffect const* sealDot = target->GetAuraEffect(SPELL_AURA_PERIODIC_DAMAGE, SPELLFAMILY_PALADIN, 0x00000000, 0x00000800, 0x00000000, caster->GetGUID());
        if (!sealDot)
            return;

        uint8 stacks = sealDot->GetBase()->GetStackAmount();
        uint8 maxStacks = sealDot->GetSpellInfo()->StackAmount;

        uint32 damageSpell = _isVengeance ? SPELL_PALADIN_SEAL_OF_VENGEANCE_EFFECT : SPELL_PALADIN_SEAL_OF_CORRUPTION_EFFECT;

        // Scale weapon damage % by stacks (6.6% per stack, up to 33% at 5 stacks)
        SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(damageSpell);
        int32 amount = spellInfo->Effects[EFFECT_0].CalcValue();
        amount = (amount * stacks) / maxStacks;

        caster->CastCustomSpell(damageSpell, SPELLVALUE_BASE_POINT0, amount, target, true, nullptr, aurEff);
    }

    void Register() override
    {
        OnEffectProc += AuraEffectProcFn(spell_pal_seal_of_vengeance_aura::HandleApplyDoT, EFFECT_0, SPELL_AURA_DUMMY);
        OnEffectProc += AuraEffectProcFn(spell_pal_seal_of_vengeance_aura::HandleSeal, EFFECT_0, SPELL_AURA_DUMMY);
    }

private:
    bool _isVengeance = true;
};

// -20210 - Illumination
class spell_pal_illumination : public AuraScript
{
    PrepareAuraScript(spell_pal_illumination);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({
            SPELL_PALADIN_HOLY_SHOCK_R1_HEALING,
            SPELL_PALADIN_ILLUMINATION_ENERGIZE,
            SPELL_PALADIN_HOLY_SHOCK_R1
        });
    }

    void HandleProc(AuraEffect const* aurEff, ProcEventInfo& eventInfo)
    {
        PreventDefaultAction();

        // this script is valid only for the Holy Shock procs of illumination
        if (eventInfo.GetHealInfo() && eventInfo.GetHealInfo()->GetSpellInfo())
        {
            SpellInfo const* originalSpell = nullptr;

            // if proc comes from the Holy Shock heal, need to get mana cost of original spell - else it's the original heal itself
            if (eventInfo.GetHealInfo()->GetSpellInfo()->SpellFamilyFlags[1] & 0x00010000)
                originalSpell = sSpellMgr->GetSpellInfo(sSpellMgr->GetSpellWithRank(SPELL_PALADIN_HOLY_SHOCK_R1, eventInfo.GetHealInfo()->GetSpellInfo()->GetRank()));
            else
                originalSpell = eventInfo.GetHealInfo()->GetSpellInfo();

            if (originalSpell && aurEff->GetSpellInfo())
            {
                Unit* target = eventInfo.GetActor(); // Paladin is the target of the energize
                int32 baseCost = originalSpell->ManaCost + int32(CalculatePct(target->GetCreateMana(), originalSpell->ManaCostPercentage));
                int32 bp = CalculatePct(baseCost, aurEff->GetSpellInfo()->Effects[EFFECT_1].CalcValue());
                target->CastCustomSpell(target, SPELL_PALADIN_ILLUMINATION_ENERGIZE, &bp, nullptr, nullptr, true, nullptr, aurEff);
            }
        }
    }

    void Register() override
    {
        OnEffectProc += AuraEffectProcFn(spell_pal_illumination::HandleProc, EFFECT_0, SPELL_AURA_PROC_TRIGGER_SPELL);
    }
};

// 498, 642, 1022 - Divine Protection, Divine Shield, Hand of Protection
class spell_pal_immunities : public SpellScript
{
    PrepareSpellScript(spell_pal_immunities);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo(
        {
            SPELL_PALADIN_FORBEARANCE,
            SPELL_PALADIN_AVENGING_WRATH_MARKER,
            SPELL_PALADIN_IMMUNE_SHIELD_MARKER
        });
    }

    SpellCastResult CheckCast()
    {
        Unit* caster = GetCaster();

        // for HoP
        Unit* target = GetExplTargetUnit();
        if (!target)
            target = caster;

        // "Cannot be used within $61987d. of using Avenging Wrath."
        if (target->HasAura(SPELL_PALADIN_FORBEARANCE) || target->HasAura(SPELL_PALADIN_AVENGING_WRATH_MARKER))
            return SPELL_FAILED_TARGET_AURASTATE;

        return SPELL_CAST_OK;
    }

    void TriggerDebuffs()
    {
        if (Unit* target = GetHitUnit())
        {
            // Blizz seems to just apply aura without bothering to cast
            GetCaster()->AddAura(SPELL_PALADIN_FORBEARANCE, target);
            GetCaster()->AddAura(SPELL_PALADIN_AVENGING_WRATH_MARKER, target);
            GetCaster()->AddAura(SPELL_PALADIN_IMMUNE_SHIELD_MARKER, target);
        }
    }

    void Register() override
    {
        OnCheckCast += SpellCheckCastFn(spell_pal_immunities::CheckCast);
        AfterHit += SpellHitFn(spell_pal_immunities::TriggerDebuffs);
    }
};

// -20254 - Improved Concentration Aura
// -20138 - Improved Devotion Aura
//  31869 - Sanctified Retribution
// -53379 - Swift Retribution
class spell_pal_improved_aura : public AuraScript
{
    PrepareAuraScript(spell_pal_improved_aura);

public:
    spell_pal_improved_aura(uint32 spellId) : AuraScript(), _spellId(spellId) { }

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo(
        {
            _spellId,
            SPELL_PALADIN_SANCTIFIED_RETRIBUTION_R1,
            SPELL_PALADIN_SWIFT_RETRIBUTION_R1
        });
    }

    void HandleEffectApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        Unit* target = GetTarget();
        target->RemoveOwnedAura(_spellId, GetCasterGUID()); // need to remove to reapply spellmods
        target->CastSpell(target, _spellId, true);
    }

    void HandleEffectRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        uint32 spellId = GetSpellInfo()->GetFirstRankSpell()->Id;

        if ((spellId == SPELL_PALADIN_SANCTIFIED_RETRIBUTION_R1 && GetTarget()->GetAuraOfRankedSpell(SPELL_PALADIN_SWIFT_RETRIBUTION_R1))
            || (spellId == SPELL_PALADIN_SWIFT_RETRIBUTION_R1 && GetTarget()->GetAuraOfRankedSpell(SPELL_PALADIN_SANCTIFIED_RETRIBUTION_R1)))
            return;

        GetTarget()->RemoveOwnedAura(_spellId, GetCasterGUID());
    }

    void Register() override
    {
        AfterEffectApply += AuraEffectApplyFn(spell_pal_improved_aura::HandleEffectApply, EFFECT_FIRST_FOUND, SPELL_AURA_ADD_FLAT_MODIFIER, AURA_EFFECT_HANDLE_REAL);
        AfterEffectRemove += AuraEffectRemoveFn(spell_pal_improved_aura::HandleEffectRemove, EFFECT_FIRST_FOUND, SPELL_AURA_ADD_FLAT_MODIFIER, AURA_EFFECT_HANDLE_REAL);
    }

private:
    uint32 _spellId;
};

// 53651 - Light's Beacon - Beacon of Light
class spell_pal_light_s_beacon : public AuraScript
{
    PrepareAuraScript(spell_pal_light_s_beacon);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo(
        {
            SPELL_PALADIN_BEACON_OF_LIGHT_AURA,
            SPELL_PALADIN_BEACON_OF_LIGHT_FLASH,
            SPELL_PALADIN_BEACON_OF_LIGHT_HOLY,
            SPELL_PALADIN_HOLY_LIGHT_R1
        });
    }

    bool CheckProc(ProcEventInfo& eventInfo)
    {
        // Don't proc if the heal target is the beacon target (no double heal)
        if (GetTarget()->HasAura(SPELL_PALADIN_BEACON_OF_LIGHT_AURA, eventInfo.GetActor()->GetGUID()))
            return false;
        return true;
    }

    void HandleProc(AuraEffect const* aurEff, ProcEventInfo& eventInfo)
    {
        PreventDefaultAction();

        SpellInfo const* procSpell = eventInfo.GetSpellInfo();
        if (!procSpell)
            return;

        HealInfo* healInfo = eventInfo.GetHealInfo();
        if (!healInfo || !healInfo->GetHeal())
            return;

        // Holy Light heals for 100%, Flash of Light heals for 50%
        uint32 healSpellId = procSpell->IsRankOf(sSpellMgr->AssertSpellInfo(SPELL_PALADIN_HOLY_LIGHT_R1)) ?
            SPELL_PALADIN_BEACON_OF_LIGHT_FLASH : SPELL_PALADIN_BEACON_OF_LIGHT_HOLY;

        // Use heal amount before target-specific modifiers to avoid copying them
        uint32 healAmount = healInfo->GetHealBeforeTakenMods();
        int32 heal = CalculatePct(healAmount, aurEff->GetAmount());

        Unit* beaconTarget = GetCaster();
        if (!beaconTarget || !beaconTarget->HasAura(SPELL_PALADIN_BEACON_OF_LIGHT_AURA, eventInfo.GetActor()->GetGUID()))
            return;

        eventInfo.GetActor()->CastCustomSpell(healSpellId, SPELLVALUE_BASE_POINT0, heal, beaconTarget, true, nullptr, aurEff, eventInfo.GetActor()->GetGUID());
    }

    void Register() override
    {
        DoCheckProc += AuraCheckProcFn(spell_pal_light_s_beacon::CheckProc);
        OnEffectProc += AuraEffectProcFn(spell_pal_light_s_beacon::HandleProc, EFFECT_0, SPELL_AURA_DUMMY);
    }
};

void AddSC_paladin_spell_scripts()
{
    RegisterSpellAndAuraScriptPair(spell_pal_seal_of_command, spell_pal_seal_of_command_aura);
    RegisterSpellScript(spell_pal_divine_intervention);
    RegisterSpellScript(spell_pal_divine_purpose);
    RegisterSpellScript(spell_pal_seal_of_light);
    RegisterSpellScript(spell_pal_sacred_shield);
    RegisterSpellScript(spell_pal_ardent_defender);
    RegisterSpellScript(spell_pal_aura_mastery);
    RegisterSpellScript(spell_pal_aura_mastery_immune);
    RegisterSpellScript(spell_pal_beacon_of_light);
    RegisterSpellScript(spell_pal_avenging_wrath);
    RegisterSpellScript(spell_pal_blessing_of_faith);
    RegisterSpellScript(spell_pal_blessing_of_sanctuary);
    RegisterSpellScript(spell_pal_divine_sacrifice);
    RegisterSpellScript(spell_pal_divine_storm);
    RegisterSpellScript(spell_pal_divine_storm_dummy);
    RegisterSpellScript(spell_pal_exorcism_and_holy_wrath_damage);
    RegisterSpellScript(spell_pal_eye_for_an_eye);
    RegisterSpellScript(spell_pal_glyph_of_holy_light);
    RegisterSpellScript(spell_pal_guarded_by_the_light);
    RegisterSpellAndAuraScriptPair(spell_pal_hand_of_sacrifice, spell_pal_hand_of_sacrifice_aura);
    RegisterSpellScript(spell_pal_hand_of_salvation);
    RegisterSpellScript(spell_pal_holy_shock);
    RegisterSpellScript(spell_pal_infusion_of_light);
    RegisterSpellScript(spell_pal_item_t6_trinket);
    RegisterSpellScriptWithArgs(spell_pal_judgement, "spell_pal_judgement_of_justice", SPELL_PALADIN_JUDGEMENT_OF_JUSTICE);
    RegisterSpellScriptWithArgs(spell_pal_judgement, "spell_pal_judgement_of_light", SPELL_PALADIN_JUDGEMENT_OF_LIGHT);
    RegisterSpellScriptWithArgs(spell_pal_judgement, "spell_pal_judgement_of_wisdom", SPELL_PALADIN_JUDGEMENT_OF_WISDOM);
    RegisterSpellScript(spell_pal_judgement_of_command);
    RegisterSpellScript(spell_pal_lay_on_hands);
    RegisterSpellScript(spell_pal_righteous_defense);
    RegisterSpellScript(spell_pal_seal_of_righteousness);
    RegisterSpellScriptWithArgs(spell_pal_seal_of_vengeance_aura, "spell_pal_seal_of_vengeance");
    RegisterSpellScriptWithArgs(spell_pal_seal_of_vengeance_aura, "spell_pal_seal_of_corruption");
    RegisterSpellScript(spell_pal_hand_of_protection);
    RegisterSpellScript(spell_pal_judgements_of_the_wise);
    RegisterSpellScript(spell_pal_righteous_vengeance);
    RegisterSpellScript(spell_pal_sheath_of_light);
    RegisterSpellScript(spell_pal_judgement_of_light_heal);
    RegisterSpellScript(spell_pal_judgement_of_wisdom_mana);
    RegisterSpellScript(spell_pal_spiritual_attunement);
    RegisterSpellScript(spell_pal_t3_6p_bonus);
    RegisterSpellScript(spell_pal_t8_2p_bonus);
    RegisterSpellScript(spell_pal_glyph_of_divinity);
    RegisterSpellScript(spell_pal_glyph_of_holy_light_dummy);
    RegisterSpellScript(spell_pal_heart_of_the_crusader);
    RegisterSpellScript(spell_pal_improved_lay_of_hands);
    RegisterSpellScript(spell_pal_judgements_of_the_just);
    RegisterSpellScript(spell_pal_sacred_shield_dummy);
    RegisterSpellScript(spell_pal_illumination);
    RegisterSpellScript(spell_pal_immunities);
    RegisterSpellScriptWithArgs(spell_pal_improved_aura, "spell_pal_improved_concentraction_aura", SPELL_PALADIN_IMPROVED_CONCENTRACTION_AURA);
    RegisterSpellScriptWithArgs(spell_pal_improved_aura, "spell_pal_improved_devotion_aura", SPELL_PALADIN_IMPROVED_DEVOTION_AURA);
    RegisterSpellScriptWithArgs(spell_pal_improved_aura, "spell_pal_sanctified_retribution", SPELL_PALADIN_SANCTIFIED_RETRIBUTION_AURA);
    RegisterSpellScriptWithArgs(spell_pal_improved_aura, "spell_pal_swift_retribution", SPELL_PALADIN_SANCTIFIED_RETRIBUTION_AURA);
    RegisterSpellScript(spell_pal_light_s_beacon);
}

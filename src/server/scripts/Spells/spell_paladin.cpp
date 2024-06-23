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

//npcbot
#include "Creature.h"
//end npcbot

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
    PALADIN_ICON_ID_RETRIBUTION_AURA             = 555
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
        if (!GetTarget()->IsInCombat() && GetTarget()->GetTypeId() == TYPEID_PLAYER)
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

class spell_pal_sacred_shield_base : public AuraScript
{
    PrepareAuraScript(spell_pal_sacred_shield_base);

    void CalculateAmount(AuraEffect const* aurEff, int32& amount, bool& /*canBeRecalculated*/)
    {
        if (Unit* caster = GetCaster())
        {
            SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(GetSpellInfo()->Effects[aurEff->GetEffIndex()].TriggerSpell);
            amount = spellInfo->Effects[EFFECT_0].CalcValue();

            // +75.00% from sp bonus
            amount += CalculatePct(caster->SpellBaseDamageBonusDone(spellInfo->GetSchoolMask()), 75.0f);

            // Xinef: removed divine guardian because it will affect triggered spell with increased amount
            // Arena - Dampening
            if (AuraEffect const* dampening = caster->GetAuraEffect(SPELL_GENERIC_ARENA_DAMPENING, EFFECT_0))
            {
                AddPct(amount, dampening->GetAmount());
            }
            // Battleground - Dampening
            else if (AuraEffect const* dampening2 = caster->GetAuraEffect(SPELL_GENERIC_BATTLEGROUND_DAMPENING, EFFECT_0))
            {
                AddPct(amount, dampening2->GetAmount());
            }
        }
    }

    bool CheckProc(ProcEventInfo& eventInfo)
    {
        HealInfo* healinfo = eventInfo.GetHealInfo();
        DamageInfo* damageinfo = eventInfo.GetDamageInfo();
        return !(eventInfo.GetHitMask() & PROC_EX_INTERNAL_HOT) && ((healinfo && healinfo->GetHeal() > 0) || (damageinfo && damageinfo->GetDamage() > 0));
    }

    void HandleProc(AuraEffect const* aurEff, ProcEventInfo& eventInfo)
    {
        PreventDefaultAction();

        if (eventInfo.GetTypeMask() & PROC_FLAG_TAKEN_SPELL_MAGIC_DMG_CLASS_POS)
        {
            Unit* caster = eventInfo.GetActor();

            HealInfo* healinfo = eventInfo.GetHealInfo();

            if (!healinfo || !healinfo->GetHeal())
            {
                return;
            }

            SpellInfo const* procSpell = healinfo->GetSpellInfo();
            if (!procSpell)
            {
                return;
            }

            if (caster && procSpell->SpellFamilyName == SPELLFAMILY_PALADIN &&
                    procSpell->SpellFamilyFlags.HasFlag(0x40000000) && caster->GetAuraEffect(SPELL_AURA_PROC_TRIGGER_SPELL, SPELLFAMILY_PALADIN, 3021, 0)) // need infusion of light
            {
                int32 basepoints = int32(float(healinfo->GetHeal()) / 12.0f);
                // Item - Paladin T9 Holy 4P Bonus (Flash of Light)
                if (AuraEffect const* aurEffect = caster->GetAuraEffect(67191, EFFECT_0))
                    AddPct(basepoints, aurEffect->GetAmount());

                caster->CastCustomSpell(eventInfo.GetActionTarget(), 66922, &basepoints, nullptr, nullptr, true, nullptr, aurEff, caster->GetGUID());
                return;
            }

            return;
        }

        uint32 triggered_spell_id = GetSpellInfo()->Effects[aurEff->GetEffIndex()].TriggerSpell;
        if (eventInfo.GetActionTarget()->HasSpellCooldown(triggered_spell_id))
            return;

        uint32 cooldown = eventInfo.GetProcCooldown();
        int32 basepoints = aurEff->GetAmount();

        // Item - Paladin T8 Holy 4P Bonus
        if (Unit* caster = aurEff->GetCaster())
            if (AuraEffect const* aurEffect = caster->GetAuraEffect(64895, 0))
                cooldown = aurEffect->GetAmount() * IN_MILLISECONDS;

        eventInfo.GetActionTarget()->AddSpellCooldown(triggered_spell_id, 0, cooldown);
        eventInfo.GetActionTarget()->CastCustomSpell(eventInfo.GetActionTarget(), triggered_spell_id, &basepoints, nullptr, nullptr, true, nullptr, aurEff, eventInfo.GetActionTarget()->GetGUID());
    }

    void Register() override
    {
        DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_pal_sacred_shield_base::CalculateAmount, EFFECT_0, SPELL_AURA_DUMMY);
        DoCheckProc += AuraCheckProcFn(spell_pal_sacred_shield_base::CheckProc);
        OnEffectProc += AuraEffectProcFn(spell_pal_sacred_shield_base::HandleProc, EFFECT_0, SPELL_AURA_DUMMY);
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

        //npcbot - allow for npcbots
        if (GetUnitOwner()->IsNPCBot())
            return true;
        //end npcbot

        return GetUnitOwner()->GetTypeId() == TYPEID_PLAYER;
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

        //npcbot - calc for bots
        if (victim->GetTypeId() == TYPEID_UNIT/* && victim->ToCreature()->IsNPCBot()*/)
        {
            if (remainingHealth <= 0 && !victim->HasSpellCooldown(PAL_SPELL_ARDENT_DEFENDER_HEAL) &&
                !victim->ToCreature()->HasSpellCooldown(PAL_SPELL_ARDENT_DEFENDER_HEAL))
            {
                // Cast healing spell, completely avoid damage
                absorbAmount = dmgInfo.GetDamage();

                float defenseSkillValue = victim->GetDefenseSkillValue();
                // Max heal when defense skill denies critical hits from raid bosses
                // Formula: max defense at level + 140 (rating from gear)
                float reqDefForMaxHeal = victim->GetMaxSkillValueForLevel() + 140.0f;
                float defenseFactor = std::min(1.0f, defenseSkillValue / reqDefForMaxHeal);

                int32 healAmount = int32(victim->CountPctFromMaxHealth(uint32(healPct * defenseFactor)));
                victim->CastCustomSpell(PAL_SPELL_ARDENT_DEFENDER_HEAL, SPELLVALUE_BASE_POINT0, healAmount, victim, true, nullptr, aurEff);
                victim->ToCreature()->AddBotSpellCooldown(PAL_SPELL_ARDENT_DEFENDER_HEAL, 120000);
            }
            else if (remainingHealth < int32(allowedHealth))
            {
                // Reduce damage that brings us under 35% (or full damage if we are already under 35%) by x%
                uint32 damageToReduce = (victim->GetHealth() < allowedHealth)
                    ? dmgInfo.GetDamage()
                    : allowedHealth - remainingHealth;
                absorbAmount = CalculatePct(damageToReduce, absorbPct);
            }

            return;
        }
        //end npcbot

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

// 31884 - Avenging Wrath
class spell_pal_avenging_wrath : public AuraScript
{
    PrepareAuraScript(spell_pal_avenging_wrath);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_PALADIN_SANCTIFIED_WRATH, SPELL_PALADIN_SANCTIFIED_WRATH_TALENT_R1 });
    }

    void HandleApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        Unit* target = GetTarget();
        if (AuraEffect const* aurEff = target->GetAuraEffectOfRankedSpell(SPELL_PALADIN_SANCTIFIED_WRATH_TALENT_R1, EFFECT_2))
        {
            int32 basepoints = aurEff->GetAmount();
            target->CastCustomSpell(target, SPELL_PALADIN_SANCTIFIED_WRATH, &basepoints, &basepoints, nullptr, true, nullptr, aurEff);
        }
    }

    void HandleRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        GetTarget()->RemoveAurasDueToSpell(SPELL_PALADIN_SANCTIFIED_WRATH);
    }

    void Register() override
    {
        OnEffectApply += AuraEffectApplyFn(spell_pal_avenging_wrath::HandleApply, EFFECT_0, SPELL_AURA_MOD_DAMAGE_PERCENT_DONE, AURA_EFFECT_HANDLE_REAL);
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
        {
            // xinef: hack
            int32 value = 9;
            caster->CastCustomSpell(target, SPELL_PALADIN_BLESSING_OF_SANCTUARY_BUFF, &value, &value, 0, true);
        }
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
            //npcbot: handle for bots
            if (caster->IsNPCBot())
            {
                Player const* owner = caster->ToCreature()->GetBotOwner();
                if (!owner || owner->GetTypeId() != TYPEID_PLAYER)
                    return false;

                if (owner->GetGroup())
                    groupSize = owner->GetGroup()->GetMembersCount();
                else
                    groupSize = 1 + owner->GetNpcBotsCount();

                remainingAmount = (caster->CountPctFromMaxHealth(GetSpellInfo()->Effects[EFFECT_2].CalcValue(caster)) * groupSize);
                minHpPct = GetSpellInfo()->Effects[EFFECT_1].CalcValue(caster);
                return true;
            }
            //end npcbot
            if (caster->GetTypeId() == TYPEID_PLAYER)
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

    SpellCastResult CheckCast()
    {
        Unit* caster = GetCaster();
        if (Unit* target = GetExplTargetUnit())
            if (caster == target)
                if (target->HasAura(SPELL_PALADIN_FORBEARANCE) || target->HasAura(SPELL_PALADIN_AVENGING_WRATH_MARKER) || target->HasAura(SPELL_PALADIN_IMMUNE_SHIELD_MARKER))
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
        if (caster->GetTypeId() != TYPEID_PLAYER)
            //npcbot: this player check makes no sense
            if (!caster->IsNPCBot())
            //end npcbot
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

// 42463 - Seal of Vengeance
// 53739 - Seal of Corruption
class spell_pal_seal_of_vengeance : public SpellScript
{
    PrepareSpellScript(spell_pal_seal_of_vengeance);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_PALADIN_SEAL_OF_VENGEANCE_EFFECT, SPELL_PALADIN_SEAL_OF_CORRUPTION_EFFECT });
    }

    void HandleScriptEffect(SpellEffIndex /*effIndex*/)
    {
        Unit* target = GetExplTargetUnit();
        uint32 spellId = GetSpell()->GetSpellInfo()->Id;
        uint32 auraId = (spellId == SPELL_PALADIN_SEAL_OF_VENGEANCE_EFFECT)
            ? SPELL_PALADIN_HOLY_VENGEANCE
            : SPELL_PALADIN_BLOOD_CORRUPTION;
        int32 damage = GetHitDamage();
        uint8 stacks = 0;

        if (target)
        {
            Aura* aura = target->GetAura(auraId, GetCaster()->GetGUID());
            if (aura)
                stacks = aura->GetStackAmount();

            damage = ((damage * stacks) / 5);

            SetHitDamage(damage);
        }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_pal_seal_of_vengeance::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_WEAPON_PERCENT_DAMAGE);
    }
};

void AddSC_paladin_spell_scripts()
{
    RegisterSpellAndAuraScriptPair(spell_pal_seal_of_command, spell_pal_seal_of_command_aura);
    RegisterSpellScript(spell_pal_divine_intervention);
    RegisterSpellScript(spell_pal_seal_of_light);
    RegisterSpellScript(spell_pal_sacred_shield_base);
    RegisterSpellScript(spell_pal_ardent_defender);
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
    RegisterSpellScriptWithArgs(spell_pal_judgement, "spell_pal_judgement_of_justice", SPELL_PALADIN_JUDGEMENT_OF_JUSTICE);
    RegisterSpellScriptWithArgs(spell_pal_judgement, "spell_pal_judgement_of_light", SPELL_PALADIN_JUDGEMENT_OF_LIGHT);
    RegisterSpellScriptWithArgs(spell_pal_judgement, "spell_pal_judgement_of_wisdom", SPELL_PALADIN_JUDGEMENT_OF_WISDOM);
    RegisterSpellScript(spell_pal_judgement_of_command);
    RegisterSpellScript(spell_pal_lay_on_hands);
    RegisterSpellScript(spell_pal_righteous_defense);
    RegisterSpellScript(spell_pal_seal_of_righteousness);
    RegisterSpellScript(spell_pal_seal_of_vengeance);
}


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

/*
 * Scripts for spells with SPELLFAMILY_WARRIOR and SPELLFAMILY_GENERIC spells used by warrior players.
 * Ordered alphabetically using scriptname.
 * Scriptnames of files in this file should be prefixed with "spell_warr_".
 */

#include "Player.h"
#include "ScriptMgr.h"
#include "SpellAuraEffects.h"
#include "SpellInfo.h"
#include "SpellMgr.h"
#include "SpellScript.h"

enum WarriorSpells
{
    SPELL_WARRIOR_INTERVENE_TRIGGER                 = 59667,
    SPELL_WARRIOR_SPELL_REFLECTION                  = 23920,
    SPELL_WARRIOR_IMPROVED_SPELL_REFLECTION_TRIGGER = 59725,
    SPELL_WARRIOR_BLOODTHIRST                       = 23885,
    SPELL_WARRIOR_BLOODTHIRST_DAMAGE                = 23881,
    SPELL_WARRIOR_BLOODSURGE_R1                     = 29723,
    SPELL_WARRIOR_CHARGE                            = 34846,
    SPELL_WARRIOR_DAMAGE_SHIELD_DAMAGE              = 59653,
    SPELL_WARRIOR_DEEP_WOUNDS_RANK_1                = 12162,
    SPELL_WARRIOR_DEEP_WOUNDS_RANK_2                = 12850,
    SPELL_WARRIOR_DEEP_WOUNDS_RANK_3                = 12868,
    SPELL_WARRIOR_DEEP_WOUNDS_RANK_PERIODIC         = 12721,
    SPELL_WARRIOR_EXECUTE                           = 20647,
    SPELL_WARRIOR_EXECUTE_GCD_REDUCED               = 71069,
    SPELL_WARRIOR_EXTRA_CHARGE                      = 70849,
    SPELL_WARRIOR_GLYPH_OF_EXECUTION                = 58367,
    SPELL_WARRIOR_GLYPH_OF_VIGILANCE                = 63326,
    SPELL_WARRIOR_JUGGERNAUT_CRIT_BONUS_BUFF        = 65156,
    SPELL_WARRIOR_JUGGERNAUT_CRIT_BONUS_TALENT      = 64976,
    SPELL_WARRIOR_LAST_STAND_TRIGGERED              = 12976,
    SPELL_WARRIOR_RETALIATION_DAMAGE                = 22858,
    SPELL_WARRIOR_SLAM                              = 50783,
    SPELL_WARRIOR_SLAM_GCD_REDUCED                  = 71072,
    SPELL_WARRIOR_SUDDEN_DEATH_R1                   = 46913,
    SPELL_WARRIOR_SUNDER_ARMOR                      = 58567,
    SPELL_WARRIOR_SWEEPING_STRIKES_EXTRA_ATTACK_1   = 12723,
    SPELL_WARRIOR_SWEEPING_STRIKES_EXTRA_ATTACK_2   = 26654,
    SPELL_WARRIOR_TAUNT                             = 355,
    SPELL_WARRIOR_UNRELENTING_ASSAULT_RANK_1        = 46859,
    SPELL_WARRIOR_UNRELENTING_ASSAULT_RANK_2        = 46860,
    SPELL_WARRIOR_UNRELENTING_ASSAULT_TRIGGER_1     = 64849,
    SPELL_WARRIOR_UNRELENTING_ASSAULT_TRIGGER_2     = 64850,
    SPELL_WARRIOR_VIGILANCE_PROC                    = 50725,
    SPELL_WARRIOR_VIGILANCE_REDIRECT_THREAT         = 59665,
    SPELL_WARRIOR_SECOND_WIND_TRIGGER_1             = 29841,
    SPELL_WARRIOR_SECOND_WIND_TRIGGER_2             = 29842,
    SPELL_WARRIOR_GLYPH_OF_BLOCKING                 = 58374,
    SPELL_WARRIOR_STOICISM                          = 70845,
    SPELL_WARRIOR_T10_MELEE_4P_BONUS                = 70847
    SPELL_WARRIOR_WHIRLWIND_OFF                     = 44949
};

enum WarriorSpellIcons
{
    WARRIOR_ICON_ID_SUDDEN_DEATH                    = 1989
};

enum MiscSpells
{
    SPELL_PALADIN_BLESSING_OF_SANCTUARY             = 20911,
    SPELL_PALADIN_GREATER_BLESSING_OF_SANCTUARY     = 25899,
    SPELL_PRIEST_RENEWED_HOPE                       = 63944,
    SPELL_GEN_DAMAGE_REDUCTION_AURA                 = 68066,
    SPELL_CATEGORY_SHIELD_SLAM                      = 1209
};

class spell_warr_mocking_blow : public SpellScript
{
    PrepareSpellScript(spell_warr_mocking_blow);

    void HandleOnHit()
    {
        if (Unit* target = GetHitUnit())
            if (target->IsImmunedToSpellEffect(GetSpellInfo(), EFFECT_1))
                SetHitDamage(0);
    }

    void Register() override
    {
        OnHit += SpellHitFn(spell_warr_mocking_blow::HandleOnHit);
    }
};

enum VictoryRushEnum
{
    SPELL_VICTORIOUS    = 32216
};

class spell_warr_victory_rush : public SpellScript
{
    PrepareSpellScript(spell_warr_victory_rush);

    void VictoryRushHit()
    {
        if (Unit* player = GetCaster())
        {
            if (Unit* victim = GetHitUnit())
            {
                if (victim->isDead())
                {
                    player->CastSpell(player, SPELL_VICTORIOUS, true);
                }
            }
        }
    }

    void Register() override
    {
        AfterHit += SpellHitFn(spell_warr_victory_rush::VictoryRushHit);
    }
};

class spell_warr_intervene : public SpellScript
{
    PrepareSpellScript(spell_warr_intervene);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_WARRIOR_INTERVENE_TRIGGER });
    }

    void HandleApplyAura(SpellEffIndex /*effIndex*/)
    {
        if (Unit* target = GetHitUnit())
            target->CastSpell((Unit*)nullptr, SPELL_WARRIOR_INTERVENE_TRIGGER, true);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_warr_intervene::HandleApplyAura, EFFECT_1, SPELL_EFFECT_APPLY_AURA);
    }
};

class spell_warr_improved_spell_reflection : public AuraScript
{
    PrepareAuraScript(spell_warr_improved_spell_reflection);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_WARRIOR_SPELL_REFLECTION, SPELL_WARRIOR_IMPROVED_SPELL_REFLECTION_TRIGGER });
    }

    bool CheckProc(ProcEventInfo& eventInfo)
    {
        return eventInfo.GetSpellInfo() && eventInfo.GetActor() && eventInfo.GetSpellInfo()->Id == SPELL_WARRIOR_SPELL_REFLECTION;
    }

    void OnProc(AuraEffect const* aurEff, ProcEventInfo& eventInfo)
    {
        PreventDefaultAction();
        CustomSpellValues values;
        values.AddSpellMod(SPELLVALUE_MAX_TARGETS, aurEff->GetAmount());
        values.AddSpellMod(SPELLVALUE_RADIUS_MOD, 2000); // Base range = 100, final range = 20 value / 10000.0f = 0.2f
        eventInfo.GetActor()->CastCustomSpell(SPELL_WARRIOR_IMPROVED_SPELL_REFLECTION_TRIGGER, values, eventInfo.GetActor(), TRIGGERED_FULL_MASK, nullptr);
    }

    void Register() override
    {
        DoCheckProc += AuraCheckProcFn(spell_warr_improved_spell_reflection::CheckProc);
        OnEffectProc += AuraEffectProcFn(spell_warr_improved_spell_reflection::OnProc, EFFECT_1, SPELL_AURA_DUMMY);
    }
};

class spell_warr_improved_spell_reflection_trigger : public SpellScript
{
    PrepareSpellScript(spell_warr_improved_spell_reflection_trigger);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_WARRIOR_SPELL_REFLECTION });
    }

    void FilterTargets(std::list<WorldObject*>& unitList)
    {
        GetCaster()->RemoveAurasDueToSpell(SPELL_WARRIOR_SPELL_REFLECTION);
        unitList.sort(Acore::ObjectDistanceOrderPred(GetCaster()));
        while (unitList.size() > GetSpellValue()->MaxAffectedTargets)
            unitList.pop_back();
    }

    void Register() override
    {
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_warr_improved_spell_reflection_trigger::FilterTargets, EFFECT_0, TARGET_UNIT_CASTER_AREA_PARTY);
    }
};

class spell_warr_improved_spell_reflection_trigger_aura : public AuraScript
{
    PrepareAuraScript(spell_warr_improved_spell_reflection_trigger_aura);

    void HandleRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes  /*mode*/)
    {
        if (!IsExpired())
        {
            // aura remove - remove auras from all party members
            std::list<Unit*> PartyMembers;
            GetUnitOwner()->GetPartyMembers(PartyMembers);
            for (std::list<Unit*>::iterator itr = PartyMembers.begin(); itr != PartyMembers.end(); ++itr)
            {
                if ((*itr)->GetGUID() != GetOwner()->GetGUID())
                    if (Aura* aur = (*itr)->GetAura(59725, GetCasterGUID()))
                    {
                        aur->SetDuration(0);
                        aur->Remove();
                    }
            }
        }
    }

    void Register() override
    {
        AfterEffectRemove += AuraEffectRemoveFn(spell_warr_improved_spell_reflection_trigger_aura::HandleRemove, EFFECT_0, SPELL_AURA_REFLECT_SPELLS, AURA_EFFECT_HANDLE_REAL);
    }
};

// 70844 - Item - Warrior T10 Protection 4P Bonus
class spell_warr_item_t10_prot_4p_bonus : public AuraScript
{
    PrepareAuraScript(spell_warr_item_t10_prot_4p_bonus);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_WARRIOR_STOICISM });
    }

    void HandleProc(ProcEventInfo& eventInfo)
    {
        PreventDefaultAction();

        Unit* target = eventInfo.GetActionTarget();
        int32 bp0 = CalculatePct(target->GetMaxHealth(), GetSpellInfo()->Effects[EFFECT_1].CalcValue());
        target->CastCustomSpell(SPELL_WARRIOR_STOICISM, SPELLVALUE_BASE_POINT0, bp0, (Unit*)nullptr, true);
    }

    void Register() override
    {
        OnProc += AuraProcFn(spell_warr_item_t10_prot_4p_bonus::HandleProc);
    }
};

// 12975 - Last Stand
class spell_warr_last_stand : public SpellScript
{
    PrepareSpellScript(spell_warr_last_stand);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_WARRIOR_LAST_STAND_TRIGGERED });
    }

    void HandleDummy(SpellEffIndex /*effIndex*/)
    {
        Unit* caster = GetCaster();
        int32 healthModSpellBasePoints0 = int32(caster->CountPctFromMaxHealth(GetEffectValue()));
        caster->CastCustomSpell(caster, SPELL_WARRIOR_LAST_STAND_TRIGGERED, &healthModSpellBasePoints0, nullptr, nullptr, true, nullptr);
    }

    void Register() override
    {
        OnEffectHit += SpellEffectFn(spell_warr_last_stand::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

// -12162 - Deep Wounds
class spell_warr_deep_wounds : public SpellScript
{
    PrepareSpellScript(spell_warr_deep_wounds);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo(
        {
            SPELL_WARRIOR_DEEP_WOUNDS_RANK_1,
            SPELL_WARRIOR_DEEP_WOUNDS_RANK_2,
            SPELL_WARRIOR_DEEP_WOUNDS_RANK_3,
            SPELL_WARRIOR_DEEP_WOUNDS_RANK_PERIODIC
        });
    }

    void HandleDummy(SpellEffIndex /*effIndex*/)
    {
        int32 damage = std::max(GetEffectValue(), 0);
        Unit* caster = GetCaster();
        if (Unit* target = GetHitUnit())
        {
            // include target dependant auras
            damage = target->MeleeDamageBonusTaken(caster, damage, BASE_ATTACK, GetSpellInfo());
            // apply percent damage mods
            ApplyPct(damage, 16.0f * GetSpellInfo()->GetRank() / 6.0f);
            target->CastDelayedSpellWithPeriodicAmount(caster, SPELL_WARRIOR_DEEP_WOUNDS_RANK_PERIODIC, SPELL_AURA_PERIODIC_DAMAGE, damage, EFFECT_0);

            caster->CastCustomSpell(target, SPELL_WARRIOR_DEEP_WOUNDS_RANK_PERIODIC, &damage, nullptr, nullptr, true);
        }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_warr_deep_wounds::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

// -100 - Charge
class spell_warr_charge : public SpellScript
{
    PrepareSpellScript(spell_warr_charge);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo(
            {
                SPELL_WARRIOR_JUGGERNAUT_CRIT_BONUS_TALENT,
                SPELL_WARRIOR_JUGGERNAUT_CRIT_BONUS_BUFF,
                SPELL_WARRIOR_CHARGE
            });
    }

    void HandleDummy(SpellEffIndex /*effIndex*/)
    {
        int32 chargeBasePoints0 = GetEffectValue();
        Unit* caster = GetCaster();
        caster->CastCustomSpell(caster, SPELL_WARRIOR_CHARGE, &chargeBasePoints0, nullptr, nullptr, true);

        // Juggernaut crit bonus
        if (caster->HasAura(SPELL_WARRIOR_JUGGERNAUT_CRIT_BONUS_TALENT))
            caster->CastSpell(caster, SPELL_WARRIOR_JUGGERNAUT_CRIT_BONUS_BUFF, true);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_warr_charge::HandleDummy, EFFECT_1, SPELL_EFFECT_DUMMY);
    }
};

// -1464 - Slam
class spell_warr_slam : public SpellScript
{
    PrepareSpellScript(spell_warr_slam);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_WARRIOR_SLAM });
    }

    void SendMiss(SpellMissInfo missInfo)
    {
        if (missInfo != SPELL_MISS_NONE)
        {
            if (Unit* caster = GetCaster())
            {
                if (Unit* target = GetHitUnit())
                {
                    caster->SendSpellMiss(target, SPELL_WARRIOR_SLAM, missInfo);
                }
            }
        }
    }

    void HandleDummy(SpellEffIndex /*effIndex*/)
    {
        if (GetHitUnit())
            GetCaster()->CastCustomSpell(SPELL_WARRIOR_SLAM, SPELLVALUE_BASE_POINT0, GetEffectValue(), GetHitUnit(), TRIGGERED_FULL_MASK);
    }

    void Register() override
    {
        BeforeHit += BeforeSpellHitFn(spell_warr_slam::SendMiss);
        OnEffectHitTarget += SpellEffectFn(spell_warr_slam::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

// -58872 - Damage Shield
class spell_warr_damage_shield : public AuraScript
{
    PrepareAuraScript(spell_warr_damage_shield);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_WARRIOR_DAMAGE_SHIELD_DAMAGE });
    }

    void OnProc(AuraEffect const* aurEff, ProcEventInfo& eventInfo)
    {
        PreventDefaultAction();

        // % of amount blocked
        int32 damage = CalculatePct(int32(GetTarget()->GetShieldBlockValue()), aurEff->GetAmount());
        GetTarget()->CastCustomSpell(SPELL_WARRIOR_DAMAGE_SHIELD_DAMAGE, SPELLVALUE_BASE_POINT0, damage, eventInfo.GetProcTarget(), true, nullptr, aurEff);
    }

    void Register() override
    {
        OnEffectProc += AuraEffectProcFn(spell_warr_damage_shield::OnProc, EFFECT_0, SPELL_AURA_DUMMY);
    }
};

// -12834 - Deep Wounds Aura
class spell_warr_deep_wounds_aura : public AuraScript
{
    PrepareAuraScript(spell_warr_deep_wounds_aura);

    bool Validate(SpellInfo const* spellInfo) override
    {
        return ValidateSpellInfo({ spellInfo->GetEffect(EFFECT_0).TriggerSpell });
    }

    bool CheckProc(ProcEventInfo& eventInfo)
    {
        DamageInfo* damageInfo = eventInfo.GetDamageInfo();
        if (!damageInfo)
            return false;

        return eventInfo.GetActor()->GetTypeId() == TYPEID_PLAYER;
    }

    void OnProc(AuraEffect const* aurEff, ProcEventInfo& eventInfo)
    {
        PreventDefaultAction();

        Unit* actor = eventInfo.GetActor();
        float damage = 0.f;

        if (eventInfo.GetDamageInfo()->GetAttackType() == OFF_ATTACK)
            damage = (actor->GetFloatValue(UNIT_FIELD_MINOFFHANDDAMAGE) + actor->GetFloatValue(UNIT_FIELD_MAXOFFHANDDAMAGE)) / 2.f;
        else
            damage = (actor->GetFloatValue(UNIT_FIELD_MINDAMAGE) + actor->GetFloatValue(UNIT_FIELD_MAXDAMAGE)) / 2.f;

        actor->CastCustomSpell(GetSpellInfo()->Effects[EFFECT_0].TriggerSpell, SPELLVALUE_BASE_POINT0, int32(damage), eventInfo.GetProcTarget(), true, nullptr, aurEff);
    }

    void Register() override
    {
        DoCheckProc += AuraCheckProcFn(spell_warr_deep_wounds_aura::CheckProc);
        OnEffectProc += AuraEffectProcFn(spell_warr_deep_wounds_aura::OnProc, EFFECT_0, SPELL_AURA_PROC_TRIGGER_SPELL);
    }
};

// -5308 - Execute
class spell_warr_execute : public SpellScript
{
    PrepareSpellScript(spell_warr_execute);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_WARRIOR_EXECUTE, SPELL_WARRIOR_GLYPH_OF_EXECUTION });
    }

    void SendMiss(SpellMissInfo missInfo)
    {
        if (missInfo != SPELL_MISS_NONE)
        {
            if (Unit* caster = GetCaster())
            {
                if (Unit* target = GetHitUnit())
                {
                    caster->SendSpellMiss(target, SPELL_WARRIOR_EXECUTE, missInfo);
                }
            }
        }
    }

    void HandleEffect(SpellEffIndex effIndex)
    {
        Unit* caster = GetCaster();
        if (Unit* target = GetHitUnit())
        {
            SpellInfo const* spellInfo = GetSpellInfo();
            int32 rageUsed = std::min<int32>(300 - spellInfo->CalcPowerCost(caster, SpellSchoolMask(spellInfo->SchoolMask)), caster->GetPower(POWER_RAGE));
            int32 newRage = std::max<int32>(0, caster->GetPower(POWER_RAGE) - rageUsed);

            // Sudden Death rage save
            if (AuraEffect* aurEff = caster->GetAuraEffect(SPELL_AURA_PROC_TRIGGER_SPELL, SPELLFAMILY_GENERIC, WARRIOR_ICON_ID_SUDDEN_DEATH, EFFECT_0))
            {
                int32 ragesave = aurEff->GetSpellInfo()->Effects[EFFECT_1].CalcValue() * 10;
                newRage = std::max(newRage, ragesave);
            }

            caster->SetPower(POWER_RAGE, uint32(newRage));
            // Glyph of Execution bonus
            if (AuraEffect* aurEff = caster->GetAuraEffect(SPELL_WARRIOR_GLYPH_OF_EXECUTION, EFFECT_0))
                rageUsed += aurEff->GetAmount() * 10;

            int32 bp = GetEffectValue() + int32(rageUsed * spellInfo->Effects[effIndex].DamageMultiplier + caster->GetTotalAttackPowerValue(BASE_ATTACK) * 0.2f);
            caster->CastCustomSpell(target, SPELL_WARRIOR_EXECUTE, &bp, nullptr, nullptr, true, nullptr, nullptr, GetOriginalCaster()->GetGUID());
        }
    }

    void Register() override
    {
        BeforeHit += BeforeSpellHitFn(spell_warr_execute::SendMiss);
        OnEffectHitTarget += SpellEffectFn(spell_warr_execute::HandleEffect, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

// -29723 - Sudden Death
// -46913 - Bloodsurge
class spell_warr_extra_proc : public AuraScript
{
    PrepareAuraScript(spell_warr_extra_proc);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo(
        {
            SPELL_WARRIOR_T10_MELEE_4P_BONUS,
            SPELL_WARRIOR_EXTRA_CHARGE,
            SPELL_WARRIOR_SLAM_GCD_REDUCED,
            SPELL_WARRIOR_EXECUTE_GCD_REDUCED
        });
    }

    void HandleProc(AuraEffect const* aurEff, ProcEventInfo& /*eventInfo*/)
    {
        Unit* target = GetTarget();
        AuraEffect const* bonusAurEff = target->GetAuraEffect(SPELL_WARRIOR_T10_MELEE_4P_BONUS, EFFECT_0);
        if (!bonusAurEff)
            return;

        if (!roll_chance_i(bonusAurEff->GetAmount()))
            return;

        target->CastSpell((Unit*)nullptr, SPELL_WARRIOR_EXTRA_CHARGE, true, nullptr, aurEff);

        SpellInfo const* auraInfo = aurEff->GetSpellInfo();
        if (auraInfo->IsRankOf(sSpellMgr->AssertSpellInfo(SPELL_WARRIOR_BLOODSURGE_R1)))
            target->CastSpell((Unit*)nullptr, SPELL_WARRIOR_SLAM_GCD_REDUCED, true, nullptr, aurEff);
        else if (auraInfo->IsRankOf(sSpellMgr->AssertSpellInfo(SPELL_WARRIOR_SUDDEN_DEATH_R1)))
            target->CastSpell((Unit*)nullptr, SPELL_WARRIOR_EXECUTE_GCD_REDUCED, true, nullptr, aurEff);
    }

    void Register() override
    {
        OnEffectProc += AuraEffectProcFn(spell_warr_extra_proc::HandleProc, EFFECT_0, SPELL_AURA_PROC_TRIGGER_SPELL);
    }
};

// 58375 - Glyph of Blocking
class spell_warr_glyph_of_blocking : public AuraScript
{
    PrepareAuraScript(spell_warr_glyph_of_blocking);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_WARRIOR_GLYPH_OF_BLOCKING });
    }

    void HandleProc(AuraEffect const* aurEff, ProcEventInfo& eventInfo)
    {
        PreventDefaultAction();
        Unit* caster = eventInfo.GetActor();
        caster->CastSpell(caster, SPELL_WARRIOR_GLYPH_OF_BLOCKING, aurEff);
    }

    void Register() override
    {
        OnEffectProc += AuraEffectProcFn(spell_warr_glyph_of_blocking::HandleProc, EFFECT_0, SPELL_AURA_DUMMY);
    }
};

// 12809 - Concussion Blow
class spell_warr_concussion_blow : public SpellScript
{
    PrepareSpellScript(spell_warr_concussion_blow);

    void HandleDummy(SpellEffIndex /*effIndex*/)
    {
        SetHitDamage(CalculatePct(GetCaster()->GetTotalAttackPowerValue(BASE_ATTACK), GetEffectValue()));
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_warr_concussion_blow::HandleDummy, EFFECT_2, SPELL_EFFECT_DUMMY);
    }
};

// 23881 - Bloodthirst
class spell_warr_bloodthirst : public SpellScript
{
    PrepareSpellScript(spell_warr_bloodthirst);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_WARRIOR_BLOODTHIRST });
    }

    void HandleDamage(SpellEffIndex /*effIndex*/)
    {
        int32 damage = GetEffectValue();
        ApplyPct(damage, GetCaster()->GetTotalAttackPowerValue(BASE_ATTACK));

        if (Unit* target = GetHitUnit())
        {
            damage = GetCaster()->SpellDamageBonusDone(target, GetSpellInfo(), uint32(damage), SPELL_DIRECT_DAMAGE);
            damage = target->SpellDamageBonusTaken(GetCaster(), GetSpellInfo(), uint32(damage), SPELL_DIRECT_DAMAGE);
        }
        SetHitDamage(damage);
    }

    void HandleDummy(SpellEffIndex /*effIndex*/)
    {
        int32 damage = GetEffectValue();
        GetCaster()->CastCustomSpell(GetCaster(), SPELL_WARRIOR_BLOODTHIRST, &damage, nullptr, nullptr, true, nullptr);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_warr_bloodthirst::HandleDamage, EFFECT_0, SPELL_EFFECT_SCHOOL_DAMAGE);
        OnEffectHit += SpellEffectFn(spell_warr_bloodthirst::HandleDummy, EFFECT_1, SPELL_EFFECT_DUMMY);
    }
};

// 23880 - Bloodthirst (Heal)
class spell_warr_bloodthirst_heal : public SpellScript
{
    PrepareSpellScript(spell_warr_bloodthirst_heal);

    void HandleHeal(SpellEffIndex /*effIndex*/)
    {
        if (SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(SPELL_WARRIOR_BLOODTHIRST_DAMAGE))
            SetEffectValue(GetCaster()->CountPctFromMaxHealth(spellInfo->Effects[EFFECT_1].CalcValue(GetCaster())));
    }

    void Register() override
    {
        OnEffectLaunchTarget += SpellEffectFn(spell_warr_bloodthirst_heal::HandleHeal, EFFECT_0, SPELL_EFFECT_HEAL);
    }
};

// 7384, 7887, 11584, 11585 - Overpower
class spell_warr_overpower : public SpellScript
{
    PrepareSpellScript(spell_warr_overpower);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({
            SPELL_WARRIOR_UNRELENTING_ASSAULT_RANK_1,
            SPELL_WARRIOR_UNRELENTING_ASSAULT_TRIGGER_1,
            SPELL_WARRIOR_UNRELENTING_ASSAULT_RANK_2,
            SPELL_WARRIOR_UNRELENTING_ASSAULT_TRIGGER_2
            });
    }

    void HandleEffect(SpellEffIndex /*effIndex*/)
    {
        uint32 spellId = 0;
        if (GetCaster()->HasAura(SPELL_WARRIOR_UNRELENTING_ASSAULT_RANK_1))
            spellId = SPELL_WARRIOR_UNRELENTING_ASSAULT_TRIGGER_1;
        else if (GetCaster()->HasAura(SPELL_WARRIOR_UNRELENTING_ASSAULT_RANK_2))
            spellId = SPELL_WARRIOR_UNRELENTING_ASSAULT_TRIGGER_2;

        if (!spellId)
            return;

        if (Player* target = GetHitPlayer())
            if (target->HasUnitState(UNIT_STATE_CASTING))
                target->CastSpell(target, spellId, true, 0, 0, GetCaster()->GetGUID());
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_warr_overpower::HandleEffect, EFFECT_0, SPELL_EFFECT_ANY);
    }
};

// 5246 - Intimidating Shout
class spell_warr_intimidating_shout : public SpellScript
{
    PrepareSpellScript(spell_warr_intimidating_shout);

    void FilterTargets(std::list<WorldObject*>& unitList)
    {
        unitList.remove(GetExplTargetWorldObject());
    }

    void Register() override
    {
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_warr_intimidating_shout::FilterTargets, EFFECT_1, TARGET_UNIT_SRC_AREA_ENEMY);
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_warr_intimidating_shout::FilterTargets, EFFECT_2, TARGET_UNIT_SRC_AREA_ENEMY);
    }
};

// -772 - Rend
class spell_warr_rend : public AuraScript
{
    PrepareAuraScript(spell_warr_rend);

    void CalculateAmount(AuraEffect const* aurEff, int32& amount, bool& canBeRecalculated)
    {
        if (Unit* caster = GetCaster())
        {
            canBeRecalculated = false;

            // $0.2 * (($MWB + $mwb) / 2 + $AP / 14 * $MWS) bonus per tick
            float ap = caster->GetTotalAttackPowerValue(BASE_ATTACK);
            int32 mws = caster->GetAttackTime(BASE_ATTACK);
            float mwbMin = caster->GetWeaponDamageRange(BASE_ATTACK, MINDAMAGE);
            float mwbMax = caster->GetWeaponDamageRange(BASE_ATTACK, MAXDAMAGE);
            float mwb = ((mwbMin + mwbMax) / 2 + ap * mws / 14000) * 0.2f;
            amount += int32(caster->ApplyEffectModifiers(GetSpellInfo(), aurEff->GetEffIndex(), mwb));

            // "If used while your target is above 75% health, Rend does 35% more damage."
            // as for 3.1.3 only ranks above 9 (wrong tooltip?)
            if (GetSpellInfo()->GetRank() >= 9)
            {
                if (GetUnitOwner()->HasAuraState(AURA_STATE_HEALTH_ABOVE_75_PERCENT, GetSpellInfo(), caster))
                    AddPct(amount, GetSpellInfo()->Effects[EFFECT_2].CalcValue(caster));
            }
        }
    }

    void Register() override
    {
        DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_warr_rend::CalculateAmount, EFFECT_0, SPELL_AURA_PERIODIC_DAMAGE);
    }
};

// -29834 - Second Wind
class spell_warr_second_wind : public AuraScript
{
    PrepareAuraScript(spell_warr_second_wind);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo(
        {
            SPELL_WARRIOR_SECOND_WIND_TRIGGER_1,
            SPELL_WARRIOR_SECOND_WIND_TRIGGER_2
        });
    }

    bool CheckProc(ProcEventInfo& eventInfo)
    {
        SpellInfo const* spellInfo = eventInfo.GetSpellInfo();
        if (!spellInfo)
            return false;

        return (spellInfo->GetAllEffectsMechanicMask() & ((1 << MECHANIC_ROOT) | (1 << MECHANIC_STUN))) != 0;
    }

    void HandleProc(AuraEffect const* aurEff, ProcEventInfo& eventInfo)
    {
        static uint32 const triggeredSpells[2] = { SPELL_WARRIOR_SECOND_WIND_TRIGGER_1, SPELL_WARRIOR_SECOND_WIND_TRIGGER_2 };

        PreventDefaultAction();
        Unit* caster = eventInfo.GetActionTarget();
        uint32 spellId = triggeredSpells[GetSpellInfo()->GetRank() - 1];
        caster->CastSpell(caster, spellId, aurEff);
    }

    void Register() override
    {
        DoCheckProc += AuraCheckProcFn(spell_warr_second_wind::CheckProc);
        OnEffectProc += AuraEffectProcFn(spell_warr_second_wind::HandleProc, EFFECT_0, SPELL_AURA_DUMMY);
    }
};

// 64380, 65941 - Shattering Throw
class spell_warr_shattering_throw : public SpellScript
{
    PrepareSpellScript(spell_warr_shattering_throw);

    void HandleScript(SpellEffIndex effIndex)
    {
        PreventHitDefaultEffect(effIndex);

        // remove shields, will still display immune to damage part
        if (Unit* target = GetHitUnit())
            target->RemoveAurasWithMechanic(1 << MECHANIC_IMMUNE_SHIELD, AURA_REMOVE_BY_ENEMY_SPELL);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_warr_shattering_throw::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

// 12328, 18765, 35429 - Sweeping Strikes
class spell_warr_sweeping_strikes : public AuraScript
{
    PrepareAuraScript(spell_warr_sweeping_strikes);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_WARRIOR_SWEEPING_STRIKES_EXTRA_ATTACK_1, SPELL_WARRIOR_SWEEPING_STRIKES_EXTRA_ATTACK_2 });
    }

    bool Load() override
    {
        _procTarget = nullptr;
        return true;
    }

    bool CheckProc(ProcEventInfo& eventInfo)
    {
        Unit* actor = eventInfo.GetActor();
        if (!actor)
        {
            return false;
        }

        if (SpellInfo const* spellInfo = eventInfo.GetSpellInfo())
        {
            switch (spellInfo->Id)
            {
                case SPELL_WARRIOR_SWEEPING_STRIKES_EXTRA_ATTACK_1:
                case SPELL_WARRIOR_SWEEPING_STRIKES_EXTRA_ATTACK_2:
                case SPELL_WARRIOR_WHIRLWIND_OFF:
                    return false;
                default:
                    break;
            }
        }

        _procTarget = eventInfo.GetActor()->SelectNearbyNoTotemTarget(eventInfo.GetProcTarget());
        return _procTarget != nullptr;
    }

    void HandleProc(AuraEffect const* aurEff, ProcEventInfo& eventInfo)
    {
        PreventDefaultAction();
        if (DamageInfo* damageInfo = eventInfo.GetDamageInfo())
        {
            SpellInfo const* spellInfo = damageInfo->GetSpellInfo();
            if (spellInfo && spellInfo->Id == SPELL_WARRIOR_EXECUTE && !_procTarget->HasAuraState(AURA_STATE_HEALTHLESS_20_PERCENT))
            {
                // If triggered by Execute (while target is not under 20% hp) deals normalized weapon damage
                GetTarget()->CastSpell(_procTarget, SPELL_WARRIOR_SWEEPING_STRIKES_EXTRA_ATTACK_2, aurEff);
            }
            else
            {
                int32 damage = damageInfo->GetUnmitigatedDamage();
                GetTarget()->CastCustomSpell(_procTarget, SPELL_WARRIOR_SWEEPING_STRIKES_EXTRA_ATTACK_1, &damage, 0, 0, true, nullptr, aurEff);
            }
        }
    }

    void Register() override
    {
        DoCheckProc += AuraCheckProcFn(spell_warr_sweeping_strikes::CheckProc);
        OnEffectProc += AuraEffectProcFn(spell_warr_sweeping_strikes::HandleProc, EFFECT_0, SPELL_AURA_DUMMY);
    }

private:
    Unit* _procTarget = nullptr;
};

// 28845 - Cheat Death
class spell_warr_t3_prot_8p_bonus : public AuraScript
{
    PrepareAuraScript(spell_warr_t3_prot_8p_bonus);

    bool CheckProc(ProcEventInfo& eventInfo)
    {
        if (eventInfo.GetActionTarget()->HealthBelowPct(20))
            return true;

        DamageInfo* damageInfo = eventInfo.GetDamageInfo();
        if (damageInfo && damageInfo->GetDamage())
            if (GetTarget()->HealthBelowPctDamaged(20, damageInfo->GetDamage()))
                return true;

        return false;
    }

    void Register() override
    {
        DoCheckProc += AuraCheckProcFn(spell_warr_t3_prot_8p_bonus::CheckProc);
    }
};

// 50720 - Vigilance
class spell_warr_vigilance : public AuraScript
{
    PrepareAuraScript(spell_warr_vigilance);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo(
            {
                SPELL_WARRIOR_GLYPH_OF_VIGILANCE,
                SPELL_WARRIOR_VIGILANCE_PROC,
                SPELL_WARRIOR_VIGILANCE_REDIRECT_THREAT,
                SPELL_GEN_DAMAGE_REDUCTION_AURA,
                SPELL_PALADIN_BLESSING_OF_SANCTUARY,
                SPELL_PALADIN_GREATER_BLESSING_OF_SANCTUARY,
                SPELL_PRIEST_RENEWED_HOPE
            });
    }

    bool Load() override
    {
        _procTarget = nullptr;
        return true;
    }

    void HandleApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        Unit* target = GetTarget();
        target->CastSpell(target, SPELL_GEN_DAMAGE_REDUCTION_AURA, true);

        if (Unit* caster = GetCaster())
            target->CastSpell(caster, SPELL_WARRIOR_VIGILANCE_REDIRECT_THREAT, true);
    }

    void HandleAfterApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        //! WORKAROUND
        //! this glyph is a proc
        if (Unit* caster = GetCaster())
        {
            if (AuraEffect const* glyph = caster->GetAuraEffect(SPELL_WARRIOR_GLYPH_OF_VIGILANCE, EFFECT_0))
                GetTarget()->ModifyRedirectThreat(glyph->GetAmount());
        }
    }

    void HandleRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        Unit* target = GetTarget();
        if (target->HasAura(SPELL_GEN_DAMAGE_REDUCTION_AURA) &&
                !(target->HasAura(SPELL_PALADIN_BLESSING_OF_SANCTUARY) ||
                    target->HasAura(SPELL_PALADIN_GREATER_BLESSING_OF_SANCTUARY) ||
                    target->HasAura(SPELL_PRIEST_RENEWED_HOPE)))
        {
            target->RemoveAurasDueToSpell(SPELL_GEN_DAMAGE_REDUCTION_AURA);
        }

        target->ResetRedirectThreat();
    }

    bool CheckProc(ProcEventInfo& /*eventInfo*/)
    {
        _procTarget = GetCaster();
        return _procTarget;
    }

    void HandleProc(AuraEffect const* aurEff, ProcEventInfo& /*eventInfo*/)
    {
        PreventDefaultAction();
        GetTarget()->CastSpell(_procTarget, SPELL_WARRIOR_VIGILANCE_PROC, true, nullptr, aurEff);
    }

    void Register() override
    {
        OnEffectApply += AuraEffectApplyFn(spell_warr_vigilance::HandleApply, EFFECT_0, SPELL_AURA_PROC_TRIGGER_SPELL, AURA_EFFECT_HANDLE_REAL_OR_REAPPLY_MASK);
        AfterEffectApply += AuraEffectApplyFn(spell_warr_vigilance::HandleAfterApply, EFFECT_0, SPELL_AURA_PROC_TRIGGER_SPELL, AURA_EFFECT_HANDLE_REAL_OR_REAPPLY_MASK);
        OnEffectRemove += AuraEffectRemoveFn(spell_warr_vigilance::HandleRemove, EFFECT_0, SPELL_AURA_PROC_TRIGGER_SPELL, AURA_EFFECT_HANDLE_REAL_OR_REAPPLY_MASK);
        DoCheckProc += AuraCheckProcFn(spell_warr_vigilance::CheckProc);
        OnEffectProc += AuraEffectProcFn(spell_warr_vigilance::HandleProc, EFFECT_0, SPELL_AURA_PROC_TRIGGER_SPELL);
    }

private:
    Unit* _procTarget;
};

// 50725 - Vigilance
class spell_warr_vigilance_trigger : public SpellScript
{
    PrepareSpellScript(spell_warr_vigilance_trigger);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_WARRIOR_TAUNT });
    }

    void HandleScript(SpellEffIndex effIndex)
    {
        PreventHitDefaultEffect(effIndex);

        // Remove Taunt cooldown
        if (Player* target = GetHitPlayer())
            target->RemoveSpellCooldown(SPELL_WARRIOR_TAUNT, true);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_warr_vigilance_trigger::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

// 58387 - Glyph of Sunder Armor
class spell_warr_glyph_of_sunder_armor : public AuraScript
{
    PrepareAuraScript(spell_warr_glyph_of_sunder_armor);

    void HandleEffectCalcSpellMod(AuraEffect const* aurEff, SpellModifier*& spellMod)
    {
        if (!spellMod)
        {
            spellMod = new SpellModifier(aurEff->GetBase());
            spellMod->op = SpellModOp(aurEff->GetMiscValue());
            spellMod->type = SPELLMOD_FLAT;
            spellMod->spellId = GetId();
            spellMod->mask = GetSpellInfo()->Effects[aurEff->GetEffIndex()].SpellClassMask;
        }

        spellMod->value = aurEff->GetAmount();
    }

    void Register() override
    {
        DoEffectCalcSpellMod += AuraEffectCalcSpellModFn(spell_warr_glyph_of_sunder_armor::HandleEffectCalcSpellMod, EFFECT_0, SPELL_AURA_DUMMY);
    }
};

// 20230 - Retaliation
class spell_warr_retaliation : public AuraScript
{
    PrepareAuraScript(spell_warr_retaliation);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_WARRIOR_RETALIATION_DAMAGE });
    }

    bool CheckProc(ProcEventInfo& eventInfo)
    {
        if (!eventInfo.GetActor() || !eventInfo.GetProcTarget())
        {
            return false;
        }

        // check attack comes not from behind and warrior is not stunned
        return GetTarget()->isInFront(eventInfo.GetActor(), M_PI) && !GetTarget()->HasUnitState(UNIT_STATE_STUNNED);
    }

    void HandleEffectProc(AuraEffect const* aurEff, ProcEventInfo& eventInfo)
    {
        PreventDefaultAction();
        GetTarget()->CastSpell(eventInfo.GetProcTarget(), SPELL_WARRIOR_RETALIATION_DAMAGE, true, nullptr, aurEff);
    }

    void Register() override
    {
        DoCheckProc += AuraCheckProcFn(spell_warr_retaliation::CheckProc);
        OnEffectProc += AuraEffectProcFn(spell_warr_retaliation::HandleEffectProc, EFFECT_0, SPELL_AURA_DUMMY);
    }
};

void AddSC_warrior_spell_scripts()
{
    RegisterSpellScript(spell_warr_mocking_blow);
    RegisterSpellScript(spell_warr_intervene);
    RegisterSpellScript(spell_warr_improved_spell_reflection);
    RegisterSpellAndAuraScriptPair(spell_warr_improved_spell_reflection_trigger, spell_warr_improved_spell_reflection_trigger_aura);
    RegisterSpellScript(spell_warr_victory_rush);
    RegisterSpellScript(spell_warr_bloodthirst);
    RegisterSpellScript(spell_warr_bloodthirst_heal);
    RegisterSpellScript(spell_warr_charge);
    RegisterSpellScript(spell_warr_concussion_blow);
    RegisterSpellScript(spell_warr_damage_shield);
    RegisterSpellScript(spell_warr_deep_wounds);
    RegisterSpellScript(spell_warr_execute);
    RegisterSpellScript(spell_warr_glyph_of_sunder_armor);
    RegisterSpellScript(spell_warr_intimidating_shout);
    RegisterSpellScript(spell_warr_last_stand);
    RegisterSpellScript(spell_warr_overpower);
    RegisterSpellScript(spell_warr_rend);
    RegisterSpellScript(spell_warr_retaliation);
    RegisterSpellScript(spell_warr_shattering_throw);
    RegisterSpellScript(spell_warr_slam);
    RegisterSpellScript(spell_warr_sweeping_strikes);
    RegisterSpellScript(spell_warr_vigilance);
    RegisterSpellScript(spell_warr_vigilance_trigger);
    RegisterSpellScript(spell_warr_t3_prot_8p_bonus);
    RegisterSpellScript(spell_warr_item_t10_prot_4p_bonus);
    RegisterSpellScript(spell_warr_deep_wounds_aura);
    RegisterSpellScript(spell_warr_extra_proc);
    RegisterSpellScript(spell_warr_glyph_of_blocking);
    RegisterSpellScript(spell_warr_second_wind);
    RegisterSpellScript(spell_warr_t3_prot_8p_bonus);
}

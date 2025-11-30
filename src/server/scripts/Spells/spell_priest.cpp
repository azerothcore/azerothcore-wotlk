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

#include "CreatureScript.h"
#include "GridNotifiers.h"
#include "Player.h"
#include "SpellAuraEffects.h"
#include "SpellMgr.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "TemporarySummon.h"
/*
 * Scripts for spells with SPELLFAMILY_PRIEST and SPELLFAMILY_GENERIC spells used by priest players.
 * Ordered alphabetically using scriptname.
 * Scriptnames of files in this file should be prefixed with "spell_pri_".
 */

enum PriestSpells
{
    SPELL_PRIEST_DIVINE_AEGIS                       = 47753,
    SPELL_PRIEST_EMPOWERED_RENEW                    = 63544,
    SPELL_PRIEST_GLYPH_OF_CIRCLE_OF_HEALING         = 55675,
    SPELL_PRIEST_GLYPH_OF_LIGHTWELL                 = 55673,
    SPELL_PRIEST_GLYPH_OF_PRAYER_OF_HEALING_HEAL    = 56161,
    SPELL_PRIEST_GUARDIAN_SPIRIT_HEAL               = 48153,
    SPELL_PRIEST_ITEM_EFFICIENCY                    = 37595,
    SPELL_PRIEST_LIGHTWELL_CHARGES                  = 59907,
    SPELL_PRIEST_MANA_LEECH_PROC                    = 34650,
    SPELL_PRIEST_PENANCE_R1                         = 47540,
    SPELL_PRIEST_PENANCE_R1_DAMAGE                  = 47758,
    SPELL_PRIEST_PENANCE_R1_HEAL                    = 47757,
    SPELL_PRIEST_REFLECTIVE_SHIELD_TRIGGERED        = 33619,
    SPELL_PRIEST_REFLECTIVE_SHIELD_R1               = 33201,
    SPELL_PRIEST_SHADOW_WORD_DEATH                  = 32409,
    SPELL_PRIEST_T9_HEALING_2P                      = 67201,
    SPELL_PRIEST_VAMPIRIC_TOUCH_DISPEL              = 64085,
    SPELL_PRIEST_T4_4P_FLEXIBILITY                  = 37565,
    SPELL_PRIEST_GLYPH_OF_SHADOWFIEND               = 58228,
    SPELL_PRIEST_GLYPH_OF_SHADOWFIEND_MANA          = 58227,

    SPELL_GENERIC_ARENA_DAMPENING                   = 74410,
    SPELL_GENERIC_BATTLEGROUND_DAMPENING            = 74411,
    SPELL_PRIEST_TWIN_DISCIPLINE_R1                 = 47586,
    SPELL_PRIEST_SPIRITUAL_HEALING_R1               = 14898,
    SPELL_PRIEST_DIVINE_PROVIDENCE_R1               = 47562
};

enum PriestSpellIcons
{
    PRIEST_ICON_ID_BORROWED_TIME                    = 2899,
    PRIEST_ICON_ID_EMPOWERED_RENEW_TALENT           = 3021,
    PRIEST_ICON_ID_PAIN_AND_SUFFERING               = 2874,
};

enum Mics
{
    PRIEST_LIGHTWELL_NPC_1                          = 31897,
    PRIEST_LIGHTWELL_NPC_2                          = 31896,
    PRIEST_LIGHTWELL_NPC_3                          = 31895,
    PRIEST_LIGHTWELL_NPC_4                          = 31894,
    PRIEST_LIGHTWELL_NPC_5                          = 31893,
    PRIEST_LIGHTWELL_NPC_6                          = 31883
};

class spell_pri_shadowfiend_scaling : public AuraScript
{
    PrepareAuraScript(spell_pri_shadowfiend_scaling);

    void CalculateResistanceAmount(AuraEffect const* aurEff, int32& amount, bool& /*canBeRecalculated*/)
    {
        // xinef: shadowfiend inherits 40% of resistance from owner and 35% of armor (guessed)
        if (Unit* owner = GetUnitOwner()->GetOwner())
        {
            SpellSchoolMask schoolMask = SpellSchoolMask(aurEff->GetSpellInfo()->Effects[aurEff->GetEffIndex()].MiscValue);
            int32 modifier = schoolMask == SPELL_SCHOOL_MASK_NORMAL ? 35 : 40;
            amount = CalculatePct(std::max<int32>(0, owner->GetResistance(schoolMask)), modifier);
        }
    }

    void CalculateStatAmount(AuraEffect const* aurEff, int32& amount, bool& /*canBeRecalculated*/)
    {
        // xinef: shadowfiend inherits 30% of intellect and 65% of stamina (guessed)
        if (Unit* owner = GetUnitOwner()->GetOwner())
        {
            Stats stat = Stats(aurEff->GetSpellInfo()->Effects[aurEff->GetEffIndex()].MiscValue);
            amount = CalculatePct(std::max<int32>(0, owner->GetStat(stat)), stat == STAT_STAMINA ? 65 : 30);
        }
    }

    void CalculateAPAmount(AuraEffect const*  /*aurEff*/, int32& amount, bool& /*canBeRecalculated*/)
    {
        // xinef: shadowfiend inherits 333% of SP as AP - 35.7% of damage increase per hit
        if (Unit* owner = GetUnitOwner()->GetOwner())
        {
            int32 shadow = owner->SpellBaseDamageBonusDone(SPELL_SCHOOL_MASK_SHADOW);
            amount = CalculatePct(std::max<int32>(0, shadow), 300); // xinef: deacrased to 300, including 15% from self buff
        }
    }

    void CalculateSPAmount(AuraEffect const*  /*aurEff*/, int32& amount, bool& /*canBeRecalculated*/)
    {
        // xinef: shadowfiend inherits 30% of SP
        if (Unit* owner = GetUnitOwner()->GetOwner())
        {
            int32 shadow = owner->SpellBaseDamageBonusDone(SPELL_SCHOOL_MASK_SHADOW);
            amount = CalculatePct(std::max<int32>(0, shadow), 30);

            // xinef: Update appropriate player field
            if (owner->IsPlayer())
                owner->SetUInt32Value(PLAYER_PET_SPELL_POWER, (uint32)amount);
        }
    }

    void HandleEffectApply(AuraEffect const* aurEff, AuraEffectHandleModes /*mode*/)
    {
        GetUnitOwner()->ApplySpellImmune(0, IMMUNITY_STATE, aurEff->GetAuraType(), true, SPELL_BLOCK_TYPE_POSITIVE);
        if (aurEff->GetAuraType() == SPELL_AURA_MOD_ATTACK_POWER)
            GetUnitOwner()->ApplySpellImmune(0, IMMUNITY_STATE, SPELL_AURA_MOD_ATTACK_POWER_PCT, true, SPELL_BLOCK_TYPE_POSITIVE);
        else if (aurEff->GetAuraType() == SPELL_AURA_MOD_STAT)
            GetUnitOwner()->ApplySpellImmune(0, IMMUNITY_STATE, SPELL_AURA_MOD_TOTAL_STAT_PERCENTAGE, true, SPELL_BLOCK_TYPE_POSITIVE);
    }

    void Register() override
    {
        if (m_scriptSpellId != 35661)
            DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_pri_shadowfiend_scaling::CalculateResistanceAmount, EFFECT_ALL, SPELL_AURA_MOD_RESISTANCE);

        if (m_scriptSpellId == 35661 || m_scriptSpellId == 35662)
            DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_pri_shadowfiend_scaling::CalculateStatAmount, EFFECT_ALL, SPELL_AURA_MOD_STAT);

        if (m_scriptSpellId == 35661)
        {
            DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_pri_shadowfiend_scaling::CalculateAPAmount, EFFECT_ALL, SPELL_AURA_MOD_ATTACK_POWER);
            DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_pri_shadowfiend_scaling::CalculateSPAmount, EFFECT_ALL, SPELL_AURA_MOD_DAMAGE_DONE);
        }

        OnEffectApply += AuraEffectApplyFn(spell_pri_shadowfiend_scaling::HandleEffectApply, EFFECT_ALL, SPELL_AURA_ANY, AURA_EFFECT_HANDLE_REAL);
    }
};

// -34861 - Circle of Healing
class spell_pri_circle_of_healing : public SpellScript
{
    PrepareSpellScript(spell_pri_circle_of_healing);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_PRIEST_GLYPH_OF_CIRCLE_OF_HEALING });
    }

    void FilterTargets(std::list<WorldObject*>& targets)
    {
        targets.remove_if(Acore::RaidCheck(GetCaster(), false));

        uint32 const maxTargets = GetCaster()->HasAura(SPELL_PRIEST_GLYPH_OF_CIRCLE_OF_HEALING) ? 6 : 5; // Glyph of Circle of Healing

        if (targets.size() > maxTargets)
        {
            targets.sort(Acore::HealthPctOrderPred());
            targets.resize(maxTargets);
        }
    }

    void Register() override
    {
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_pri_circle_of_healing::FilterTargets, EFFECT_0, TARGET_UNIT_DEST_AREA_ALLY);
    }
};

// -47509 - Divine Aegis
class spell_pri_divine_aegis : public AuraScript
{
    PrepareAuraScript(spell_pri_divine_aegis);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_PRIEST_DIVINE_AEGIS });
    }

    bool CheckProc(ProcEventInfo& eventInfo)
    {
        return eventInfo.GetProcTarget();
    }

    void HandleProc(AuraEffect const* aurEff, ProcEventInfo& eventInfo)
    {
        PreventDefaultAction();

        int32 absorb = CalculatePct(int32(eventInfo.GetHealInfo()->GetHeal()), aurEff->GetAmount());

        // Multiple effects stack, so let's try to find this aura.
        if (AuraEffect const* aegis = eventInfo.GetProcTarget()->GetAuraEffect(SPELL_PRIEST_DIVINE_AEGIS, EFFECT_0))
            absorb += aegis->GetAmount();

        absorb = std::min(absorb, eventInfo.GetProcTarget()->GetLevel() * 125);

        GetTarget()->CastCustomSpell(SPELL_PRIEST_DIVINE_AEGIS, SPELLVALUE_BASE_POINT0, absorb, eventInfo.GetProcTarget(), true, nullptr, aurEff);
    }

    void Register() override
    {
        DoCheckProc += AuraCheckProcFn(spell_pri_divine_aegis::CheckProc);
        OnEffectProc += AuraEffectProcFn(spell_pri_divine_aegis::HandleProc, EFFECT_0, SPELL_AURA_DUMMY);
    }
};

// 64844 - Divine Hymn
class spell_pri_divine_hymn : public SpellScript
{
    PrepareSpellScript(spell_pri_divine_hymn);

    void FilterTargets(std::list<WorldObject*>& targets)
    {
        targets.remove_if(Acore::RaidCheck(GetCaster(), false));

        uint32 const maxTargets = 3;

        if (targets.size() > maxTargets)
        {
            targets.sort(Acore::HealthPctOrderPred());
            targets.resize(maxTargets);
        }
    }

    void Register() override
    {
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_pri_divine_hymn::FilterTargets, EFFECT_ALL, TARGET_UNIT_SRC_AREA_ALLY);
    }
};

// 55680 - Glyph of Prayer of Healing
class spell_pri_glyph_of_prayer_of_healing : public AuraScript
{
    PrepareAuraScript(spell_pri_glyph_of_prayer_of_healing);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_PRIEST_GLYPH_OF_PRAYER_OF_HEALING_HEAL });
    }

    void HandleProc(AuraEffect const* aurEff, ProcEventInfo& eventInfo)
    {
        PreventDefaultAction();

        HealInfo* healInfo = eventInfo.GetHealInfo();
        if (!healInfo || !healInfo->GetHeal())
        {
            return;
        }

        SpellInfo const* triggeredSpellInfo = sSpellMgr->AssertSpellInfo(SPELL_PRIEST_GLYPH_OF_PRAYER_OF_HEALING_HEAL);
        int32 heal = int32(CalculatePct(int32(healInfo->GetHeal()), aurEff->GetAmount()) / triggeredSpellInfo->GetMaxTicks());
        GetTarget()->CastCustomSpell(SPELL_PRIEST_GLYPH_OF_PRAYER_OF_HEALING_HEAL, SPELLVALUE_BASE_POINT0, heal, eventInfo.GetProcTarget(), true, nullptr, aurEff);
    }

    void Register() override
    {
        OnEffectProc += AuraEffectProcFn(spell_pri_glyph_of_prayer_of_healing::HandleProc, EFFECT_0, SPELL_AURA_DUMMY);
    }
};

// 47788 - Guardian Spirit
class spell_pri_guardian_spirit : public AuraScript
{
    PrepareAuraScript(spell_pri_guardian_spirit);

    uint32 healPct;

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_PRIEST_GUARDIAN_SPIRIT_HEAL });
    }

    bool Load() override
    {
        healPct = GetSpellInfo()->Effects[EFFECT_1].CalcValue();
        return true;
    }

    void CalculateAmount(AuraEffect const* /*aurEff*/, int32& amount, bool& /*canBeRecalculated*/)
    {
        // Set absorbtion amount to unlimited
        amount = -1;
    }

    void Absorb(AuraEffect* /*aurEff*/, DamageInfo& dmgInfo, uint32& absorbAmount)
    {
        Unit* target = GetTarget();
        if (dmgInfo.GetDamage() < target->GetHealth())
            return;

        int32 healAmount = int32(target->CountPctFromMaxHealth(healPct));
        // remove the aura now, we don't want 40% healing bonus
        Remove(AURA_REMOVE_BY_ENEMY_SPELL);
        target->CastCustomSpell(target, SPELL_PRIEST_GUARDIAN_SPIRIT_HEAL, &healAmount, nullptr, nullptr, true);
        absorbAmount = dmgInfo.GetDamage();
    }

    void Register() override
    {
        DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_pri_guardian_spirit::CalculateAmount, EFFECT_1, SPELL_AURA_SCHOOL_ABSORB);
        OnEffectAbsorb += AuraEffectAbsorbFn(spell_pri_guardian_spirit::Absorb, EFFECT_1);
    }
};

// 64904 - Hymn of Hope
class spell_pri_hymn_of_hope : public SpellScript
{
    PrepareSpellScript(spell_pri_hymn_of_hope);

    void FilterTargets(std::list<WorldObject*>& targets)
    {
        targets.remove_if(Acore::PowerCheck(POWER_MANA, false));
        targets.remove_if(Acore::RaidCheck(GetCaster(), false));

        uint32 const maxTargets = 3;

        if (targets.size() > maxTargets)
        {
            targets.sort(Acore::PowerPctOrderPred(POWER_MANA));
            targets.resize(maxTargets);
        }
    }

    void Register() override
    {
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_pri_hymn_of_hope::FilterTargets, EFFECT_ALL, TARGET_UNIT_SRC_AREA_ALLY);
    }
};

// 37594 - Greater Heal Refund
class spell_pri_item_greater_heal_refund : public AuraScript
{
    PrepareAuraScript(spell_pri_item_greater_heal_refund);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_PRIEST_ITEM_EFFICIENCY });
    }

    bool CheckProc(ProcEventInfo& eventInfo)
    {
        if (HealInfo* healInfo = eventInfo.GetHealInfo())
            if (Unit* healTarget = healInfo->GetTarget())
                if (eventInfo.GetHitMask() & PROC_EX_NO_OVERHEAL && healTarget->IsFullHealth())
                    return true;
        return false;
    }

    void HandleProc(AuraEffect const* aurEff, ProcEventInfo& /*eventInfo*/)
    {
        PreventDefaultAction();
        GetTarget()->CastSpell(GetTarget(), SPELL_PRIEST_ITEM_EFFICIENCY, true, nullptr, aurEff);
    }

    void Register() override
    {
        DoCheckProc += AuraCheckProcFn(spell_pri_item_greater_heal_refund::CheckProc);
        OnEffectProc += AuraEffectProcFn(spell_pri_item_greater_heal_refund::HandleProc, EFFECT_0, SPELL_AURA_PROC_TRIGGER_SPELL);
    }
};

// 60123 - Lightwell
class spell_pri_lightwell : public SpellScript
{
    PrepareSpellScript(spell_pri_lightwell);

    bool Load() override
    {
        return GetCaster()->IsCreature();
    }

    void HandleScriptEffect(SpellEffIndex /* effIndex */)
    {
        Creature* caster = GetCaster()->ToCreature();
        if (!caster || !caster->IsSummon())
            return;

        uint32 lightwellRenew = 0;
        switch (caster->GetEntry())
        {
            case PRIEST_LIGHTWELL_NPC_1: lightwellRenew = 7001; break;
            case PRIEST_LIGHTWELL_NPC_2: lightwellRenew = 27873; break;
            case PRIEST_LIGHTWELL_NPC_3: lightwellRenew = 27874; break;
            case PRIEST_LIGHTWELL_NPC_4: lightwellRenew = 28276; break;
            case PRIEST_LIGHTWELL_NPC_5: lightwellRenew = 48084; break;
            case PRIEST_LIGHTWELL_NPC_6: lightwellRenew = 48085; break;
        }

        // proc a spellcast
        if (Aura* chargesAura = caster->GetAura(SPELL_PRIEST_LIGHTWELL_CHARGES))
        {
            caster->CastSpell(GetHitUnit(), lightwellRenew, caster->ToTempSummon()->GetSummonerGUID());
            if (chargesAura->ModCharges(-1))
                caster->ToTempSummon()->UnSummon();
        }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_pri_lightwell::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

// -7001 - Lightwell Renew
class spell_pri_lightwell_renew : public AuraScript
{
    PrepareAuraScript(spell_pri_lightwell_renew);

    void CalculateAmount(AuraEffect const* /*aurEff*/, int32& amount, bool& /*canBeRecalculated*/)
    {
        if (Unit* caster = GetCaster())
        {
            // Bonus from Glyph of Lightwell
            if (AuraEffect* modHealing = caster->GetAuraEffect(SPELL_PRIEST_GLYPH_OF_LIGHTWELL, EFFECT_0))
                AddPct(amount, modHealing->GetAmount());
        }
    }

    void HandleUpdateSpellclick(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        if (Unit* caster = GetCaster())
        {
            if (Player* player = GetTarget()->ToPlayer())
            {
                UpdateData data;
                WorldPacket packet;
                caster->BuildValuesUpdateBlockForPlayer(&data, player);
                data.BuildPacket(packet);
                player->SendDirectMessage(&packet);
            }
        }
    }

    void Register() override
    {
        DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_pri_lightwell_renew::CalculateAmount, EFFECT_0, SPELL_AURA_PERIODIC_HEAL);
        AfterEffectApply += AuraEffectApplyFn(spell_pri_lightwell_renew::HandleUpdateSpellclick, EFFECT_0, SPELL_AURA_PERIODIC_HEAL, AURA_EFFECT_HANDLE_REAL);
        AfterEffectRemove += AuraEffectRemoveFn(spell_pri_lightwell_renew::HandleUpdateSpellclick, EFFECT_0, SPELL_AURA_PERIODIC_HEAL, AURA_EFFECT_HANDLE_REAL);
    }
};

// 8129 - Mana Burn
class spell_pri_mana_burn : public SpellScript
{
    PrepareSpellScript(spell_pri_mana_burn);

    void HandleAfterHit()
    {
        if (Unit* unitTarget = GetHitUnit())
            unitTarget->RemoveAurasWithMechanic((1 << MECHANIC_FEAR) | (1 << MECHANIC_POLYMORPH));
    }

    void Register() override
    {
        AfterHit += SpellHitFn(spell_pri_mana_burn::HandleAfterHit);
    }
};

// 28305 - Mana Leech (Passive) (Priest Pet Aura)
class spell_pri_mana_leech : public AuraScript
{
    PrepareAuraScript(spell_pri_mana_leech);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_PRIEST_MANA_LEECH_PROC });
    }

    bool Load() override
    {
        _procTarget = nullptr;
        return true;
    }

    bool CheckProc(ProcEventInfo& /*eventInfo*/)
    {
        _procTarget = GetTarget()->GetOwner();
        return _procTarget;
    }

    void HandleProc(AuraEffect const* aurEff, ProcEventInfo& /*eventInfo*/)
    {
        PreventDefaultAction();
        GetTarget()->CastSpell(_procTarget, SPELL_PRIEST_MANA_LEECH_PROC, true, nullptr, aurEff);
    }

    void Register() override
    {
        DoCheckProc += AuraCheckProcFn(spell_pri_mana_leech::CheckProc);
        OnEffectProc += AuraEffectProcFn(spell_pri_mana_leech::HandleProc, EFFECT_0, SPELL_AURA_DUMMY);
    }

private:
    Unit* _procTarget;
};

// -49821 - Mind Sear
class spell_pri_mind_sear : public SpellScript
{
    PrepareSpellScript(spell_pri_mind_sear);

    void FilterTargets(std::list<WorldObject*>& unitList)
    {
        unitList.remove_if(Acore::ObjectGUIDCheck(GetCaster()->GetGuidValue(UNIT_FIELD_CHANNEL_OBJECT), true));
    }

    void Register() override
    {
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_pri_mind_sear::FilterTargets, EFFECT_0, TARGET_UNIT_DEST_AREA_ENEMY);
    }
};

// 47948 - Pain and Suffering (Proc)
class spell_pri_pain_and_suffering_proc : public SpellScript
{
    PrepareSpellScript(spell_pri_pain_and_suffering_proc);

    void HandleEffectScriptEffect(SpellEffIndex /*effIndex*/)
    {
        // Refresh Shadow Word: Pain on target
        if (Unit* unitTarget = GetHitUnit())
            if (AuraEffect* aur = unitTarget->GetAuraEffect(SPELL_AURA_PERIODIC_DAMAGE, SPELLFAMILY_PRIEST, 0x8000, 0, 0, GetCaster()->GetGUID()))
            {
                aur->GetBase()->RefreshTimersWithMods();
                aur->ChangeAmount(aur->CalculateAmount(aur->GetCaster()), false);
            }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_pri_pain_and_suffering_proc::HandleEffectScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

// -47540 - Penance
class spell_pri_penance : public SpellScript
{
    PrepareSpellScript(spell_pri_penance);

    bool Load() override
    {
        return GetCaster()->IsPlayer();
    }

    bool Validate(SpellInfo const* spellInfo) override
    {
        SpellInfo const* firstRankSpellInfo = sSpellMgr->GetSpellInfo(SPELL_PRIEST_PENANCE_R1);
        if (!firstRankSpellInfo)
            return false;

        // can't use other spell than this penance due to spell_ranks dependency
        if (!spellInfo->IsRankOf(firstRankSpellInfo))
            return false;

        uint8 rank = spellInfo->GetRank();
        if (!sSpellMgr->GetSpellWithRank(SPELL_PRIEST_PENANCE_R1_DAMAGE, rank, true))
            return false;
        if (!sSpellMgr->GetSpellWithRank(SPELL_PRIEST_PENANCE_R1_HEAL, rank, true))
            return false;

        return true;
    }

    void HandleDummy(SpellEffIndex /*effIndex*/)
    {
        Unit* caster = GetCaster();
        if (Unit* unitTarget = GetHitUnit())
        {
            if (!unitTarget->IsAlive())
                return;

            uint8 rank = GetSpellInfo()->GetRank();

            if (caster->IsFriendlyTo(unitTarget))
                caster->CastSpell(unitTarget, sSpellMgr->GetSpellWithRank(SPELL_PRIEST_PENANCE_R1_HEAL, rank), false);
            else
                caster->CastSpell(unitTarget, sSpellMgr->GetSpellWithRank(SPELL_PRIEST_PENANCE_R1_DAMAGE, rank), false);
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
        OnEffectHitTarget += SpellEffectFn(spell_pri_penance::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
        OnCheckCast += SpellCheckCastFn(spell_pri_penance::CheckCast);
    }
};

// -17 - Power Word: Shield
static int32 CalculateSpellAmount(Unit* caster, int32 amount, SpellInfo const* spellInfo, const AuraEffect* aurEff)
{
    // +80.68% from sp bonus
    float bonus = 0.8068f;

    // Borrowed Time
    if (AuraEffect const* borrowedTime = caster->GetDummyAuraEffect(SPELLFAMILY_PRIEST, PRIEST_ICON_ID_BORROWED_TIME, EFFECT_1))
        bonus += CalculatePct(1.0f, borrowedTime->GetAmount());

    bonus *= caster->SpellBaseHealingBonusDone(spellInfo->GetSchoolMask());

    // Improved PW: Shield: its weird having a SPELLMOD_ALL_EFFECTS here but its blizzards doing :)
    // Improved PW: Shield is only applied at the spell healing bonus because it was already applied to the base value in CalculateSpellDamage
    bonus = caster->ApplyEffectModifiers(spellInfo, aurEff->GetEffIndex(), bonus);
    bonus *= caster->CalculateLevelPenalty(spellInfo);

    amount += int32(bonus);

    // Twin Disciplines
    if (AuraEffect const* twinDisciplines = caster->GetAuraEffect(SPELL_AURA_ADD_PCT_MODIFIER, SPELLFAMILY_PRIEST, 0x400000, 0, 0, caster->GetGUID()))
        AddPct(amount, twinDisciplines->GetAmount());

    // Focused Power, xinef: apply positive modifier only
    if (int32 healModifier = caster->GetMaxPositiveAuraModifier(SPELL_AURA_MOD_HEALING_DONE_PERCENT))
        AddPct(amount, healModifier);

    // Arena - Dampening
    if (AuraEffect const* arenaDampening = caster->GetAuraEffect(SPELL_GENERIC_ARENA_DAMPENING, EFFECT_0))
    {
        AddPct(amount, arenaDampening->GetAmount());
    }
    // Battleground - Dampening
    else if (AuraEffect const* bgDampening = caster->GetAuraEffect(SPELL_GENERIC_BATTLEGROUND_DAMPENING, EFFECT_0))
    {
        AddPct(amount, bgDampening->GetAmount());
    }

    return amount;
};

class spell_pri_power_word_shield_aura : public AuraScript
{
    PrepareAuraScript(spell_pri_power_word_shield_aura);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_PRIEST_REFLECTIVE_SHIELD_TRIGGERED, SPELL_PRIEST_REFLECTIVE_SHIELD_R1 });
    }

    void CalculateAmount(AuraEffect const* aurEff, int32& amount, bool& canBeRecalculated)
    {
        canBeRecalculated = false;
        if (Unit* caster = GetCaster())
            amount = CalculateSpellAmount(caster, amount, GetSpellInfo(), aurEff);
    }

    void ReflectDamage(AuraEffect* aurEff, DamageInfo& dmgInfo, uint32& absorbAmount)
    {
        Unit* target = GetTarget();
        if (dmgInfo.GetAttacker() == target)
            return;

        if (Unit* owner = GetUnitOwner())
            if (AuraEffect* talentAurEff = owner->GetAuraEffectOfRankedSpell(SPELL_PRIEST_REFLECTIVE_SHIELD_R1, EFFECT_0))
            {
                int32 bp = CalculatePct(absorbAmount, talentAurEff->GetAmount());
                // xinef: prevents infinite loop!
                if (!dmgInfo.GetSpellInfo() || dmgInfo.GetSpellInfo()->Id != SPELL_PRIEST_REFLECTIVE_SHIELD_TRIGGERED)
                    target->CastCustomSpell(dmgInfo.GetAttacker(), SPELL_PRIEST_REFLECTIVE_SHIELD_TRIGGERED, &bp, nullptr, nullptr, true, nullptr, aurEff);
            }
    }

    void Register() override
    {
        DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_pri_power_word_shield_aura::CalculateAmount, EFFECT_0, SPELL_AURA_SCHOOL_ABSORB);
        AfterEffectAbsorb += AuraEffectAbsorbFn(spell_pri_power_word_shield_aura::ReflectDamage, EFFECT_0);
    }
};

class spell_pri_power_word_shield : public SpellScript
{
    PrepareSpellScript(spell_pri_power_word_shield);

    SpellCastResult CheckCast()
    {
        Unit* caster = GetCaster();
        Unit* target = GetExplTargetUnit();
        if (!target)
            return SPELL_FAILED_BAD_TARGETS;

        if (AuraEffect* aurEff = target->GetAuraEffect(SPELL_AURA_SCHOOL_ABSORB, (SpellFamilyNames)GetSpellInfo()->SpellFamilyName, GetSpellInfo()->SpellIconID, EFFECT_0))
        {
            int32 newAmount = GetSpellInfo()->Effects[EFFECT_0].CalcValue(caster, nullptr, nullptr);
            newAmount = CalculateSpellAmount(caster, newAmount, GetSpellInfo(), aurEff);

            if (aurEff->GetAmount() > newAmount)
                return SPELL_FAILED_AURA_BOUNCED;
        }

        return SPELL_CAST_OK;
    }

    void Register() override
    {
        OnCheckCast += SpellCheckCastFn(spell_pri_power_word_shield::CheckCast);
    }
};

// 33110 - Prayer of Mending Heal
class spell_pri_prayer_of_mending_heal : public SpellScript
{
    PrepareSpellScript(spell_pri_prayer_of_mending_heal);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo(
            {
                SPELL_PRIEST_T9_HEALING_2P,
                SPELL_PRIEST_TWIN_DISCIPLINE_R1,
                SPELL_PRIEST_SPIRITUAL_HEALING_R1,
                SPELL_PRIEST_DIVINE_PROVIDENCE_R1
            });
    }

    void HandleHeal(SpellEffIndex /*effIndex*/)
    {
        if (Unit* caster = GetOriginalCaster())
        {
            int32 heal = GetEffectValue();
            if (AuraEffect* aurEff = caster->GetAuraEffect(SPELL_PRIEST_T9_HEALING_2P, EFFECT_0))
            {
                AddPct(heal, aurEff->GetAmount());
            }

            if (AuraEffect* aurEff = caster->GetAuraEffectOfRankedSpell(SPELL_PRIEST_TWIN_DISCIPLINE_R1, EFFECT_0))
            {
                AddPct(heal, aurEff->GetAmount());
            }
            if (AuraEffect* aurEff = caster->GetAuraEffectOfRankedSpell(SPELL_PRIEST_SPIRITUAL_HEALING_R1, EFFECT_0))
            {
                AddPct(heal, aurEff->GetAmount());
            }
            if (AuraEffect* aurEff = caster->GetAuraEffectOfRankedSpell(SPELL_PRIEST_DIVINE_PROVIDENCE_R1, EFFECT_0))
            {
                AddPct(heal, aurEff->GetAmount());
            }

            SetEffectValue(heal);
        }
    }

    void Register() override
    {
        OnEffectLaunchTarget += SpellEffectFn(spell_pri_prayer_of_mending_heal::HandleHeal, EFFECT_0, SPELL_EFFECT_HEAL);
    }
};

// -139 - Renew
class spell_pri_renew : public AuraScript
{
    PrepareAuraScript(spell_pri_renew);

    bool Load() override
    {
        return GetCaster() && GetCaster()->IsPlayer();
    }

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({SPELL_PRIEST_EMPOWERED_RENEW});
    }

    void HandleApplyEffect(AuraEffect const* aurEff, AuraEffectHandleModes /*mode*/)
    {
        if (Unit* caster = GetCaster())
        {
            // Empowered Renew
            if (AuraEffect const* empoweredRenewAurEff = caster->GetDummyAuraEffect(SPELLFAMILY_PRIEST, PRIEST_ICON_ID_EMPOWERED_RENEW_TALENT, EFFECT_1))
            {
                uint32 heal = GetEffect(EFFECT_0)->GetAmount();
                heal = GetTarget()->SpellHealingBonusTaken(caster, GetSpellInfo(), heal, DOT);

                int32 basepoints0 = empoweredRenewAurEff->GetAmount() * GetEffect(EFFECT_0)->GetTotalTicks() * int32(heal) / 100;
                caster->CastCustomSpell(GetTarget(), SPELL_PRIEST_EMPOWERED_RENEW, &basepoints0, nullptr, nullptr, true, nullptr, aurEff);
            }
        }
    }

    void Register() override
    {
        OnEffectApply += AuraEffectApplyFn(spell_pri_renew::HandleApplyEffect, EFFECT_0, SPELL_AURA_PERIODIC_HEAL, AURA_EFFECT_HANDLE_REAL_OR_REAPPLY_MASK);
    }
};

// -32379 - Shadow Word Death
class spell_pri_shadow_word_death : public SpellScript
{
    PrepareSpellScript(spell_pri_shadow_word_death);

    void HandleDamage()
    {
        int32 damage = GetHitDamage();

        // Pain and Suffering reduces damage
        if (AuraEffect* aurEff = GetCaster()->GetDummyAuraEffect(SPELLFAMILY_PRIEST, PRIEST_ICON_ID_PAIN_AND_SUFFERING, EFFECT_1))
            AddPct(damage, aurEff->GetAmount());

        GetCaster()->CastCustomSpell(GetCaster(), SPELL_PRIEST_SHADOW_WORD_DEATH, &damage, 0, 0, true);
    }

    void Register() override
    {
        OnHit += SpellHitFn(spell_pri_shadow_word_death::HandleDamage);
    }
};

// -34914 - Vampiric Touch
class spell_pri_vampiric_touch : public AuraScript
{
    PrepareAuraScript(spell_pri_vampiric_touch);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_PRIEST_VAMPIRIC_TOUCH_DISPEL });
    }

    void HandleDispel(DispelInfo* /*dispelInfo*/)
    {
        if (Unit* caster = GetCaster())
            if (Unit* target = GetUnitOwner())
                if (AuraEffect const* aurEff = GetEffect(EFFECT_1))
                {
                    int32 damage = aurEff->GetBaseAmount();
                    damage = aurEff->GetSpellInfo()->Effects[EFFECT_1].CalcValue(caster, &damage, nullptr) * 8;
                    // backfire damage
                    caster->CastCustomSpell(target, SPELL_PRIEST_VAMPIRIC_TOUCH_DISPEL, &damage, nullptr, nullptr, true, nullptr, aurEff);
                }
    }

    bool CheckProc(ProcEventInfo& eventInfo)
    {
        if (!eventInfo.GetActionTarget() || GetOwner()->GetGUID() != eventInfo.GetActionTarget()->GetGUID())
        {
            return false;
        }

        SpellInfo const* spellInfo = eventInfo.GetSpellInfo();
        if (!spellInfo || spellInfo->SpellFamilyName != SPELLFAMILY_PRIEST || !(spellInfo->SpellFamilyFlags[0] & 0x00002000))
        {
            return false;
        }

        return true;
    }

    void HandleProc(AuraEffect const* aurEff, ProcEventInfo& eventInfo)
    {
        PreventDefaultAction();
        if (Unit* actor = eventInfo.GetActor())
        {
            actor->CastSpell(actor, 57669, true, nullptr, aurEff);
        }
    }

    void Register() override
    {
        AfterDispel += AuraDispelFn(spell_pri_vampiric_touch::HandleDispel);
        DoCheckProc += AuraCheckProcFn(spell_pri_vampiric_touch::CheckProc);
        OnEffectProc += AuraEffectProcFn(spell_pri_vampiric_touch::HandleProc, EFFECT_0, SPELL_AURA_DUMMY);
    }
};

// 605 - Mind Control
class spell_pri_mind_control : public AuraScript
{
    PrepareAuraScript(spell_pri_mind_control);

    void HandleApplyEffect(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        if (Unit* caster = GetCaster())
        {
            if (Unit* target = GetTarget())
            {
                uint32 duration = static_cast<uint32>(GetDuration());
                caster->SetInCombatWith(target, duration);
                target->SetInCombatWith(caster, duration);
            }
        }
    }

    void HandleRemoveEffect(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        if (Unit* caster = GetCaster())
        {
            if (Unit* target = GetTarget())
            {
                caster->SetCombatTimer(0);
                target->SetCombatTimer(0);
            }
        }
    }

    void Register() override
    {
        AfterEffectApply += AuraEffectApplyFn(spell_pri_mind_control::HandleApplyEffect, EFFECT_0, SPELL_AURA_MOD_POSSESS, AURA_EFFECT_HANDLE_REAL);
        AfterEffectRemove += AuraEffectRemoveFn(spell_pri_mind_control::HandleRemoveEffect, EFFECT_0, SPELL_AURA_MOD_POSSESS, AURA_EFFECT_HANDLE_REAL);
    }
};

// 37565 - Flexibility | Item - Priest T4 Holy/Discipline 4P Bonus
class spell_pri_t4_4p_bonus : public AuraScript
{
    PrepareAuraScript(spell_pri_t4_4p_bonus);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_PRIEST_T4_4P_FLEXIBILITY });
    }

    void HandleProc(AuraEffect const* /*aurEff*/, ProcEventInfo& /*eventInfo*/)
    {
        PreventDefaultAction();
        GetTarget()->RemoveAurasDueToSpell(SPELL_PRIEST_T4_4P_FLEXIBILITY);
    }

    void Register() override
    {
        OnEffectProc += AuraEffectProcFn(spell_pri_t4_4p_bonus::HandleProc, EFFECT_ALL, SPELL_AURA_OVERRIDE_CLASS_SCRIPTS);
    }
};

// 57989 - Shadowfiend Death
class spell_pri_shadowfiend_death : public AuraScript
{
    PrepareAuraScript(spell_pri_shadowfiend_death);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_PRIEST_GLYPH_OF_SHADOWFIEND_MANA });
    }

    bool AfterCheckProc(ProcEventInfo& eventInfo, bool isTriggeredAtSpellProcEvent)
    {
        if (!isTriggeredAtSpellProcEvent)
            return false;
        return eventInfo.GetTypeMask() & PROC_FLAG_KILLED;
    }

    void HandleProc(AuraEffect const* /*aurEff*/, ProcEventInfo& /*eventInfo*/)
    {
        PreventDefaultAction();
        if (Unit* owner = GetTarget()->GetOwner())
            if (owner->HasAura(SPELL_PRIEST_GLYPH_OF_SHADOWFIEND))
                owner->CastSpell(owner, SPELL_PRIEST_GLYPH_OF_SHADOWFIEND_MANA, true);
    }

    void Register() override
    {
        DoAfterCheckProc += AuraAfterCheckProcFn(spell_pri_shadowfiend_death::AfterCheckProc);
        OnEffectProc += AuraEffectProcFn(spell_pri_shadowfiend_death::HandleProc, EFFECT_0, SPELL_AURA_DUMMY);
    }
};

void AddSC_priest_spell_scripts()
{
    RegisterSpellScript(spell_pri_shadowfiend_scaling);
    RegisterSpellScript(spell_pri_circle_of_healing);
    RegisterSpellScript(spell_pri_divine_aegis);
    RegisterSpellScript(spell_pri_divine_hymn);
    RegisterSpellScript(spell_pri_glyph_of_prayer_of_healing);
    RegisterSpellScript(spell_pri_guardian_spirit);
    RegisterSpellScript(spell_pri_hymn_of_hope);
    RegisterSpellScript(spell_pri_item_greater_heal_refund);
    RegisterSpellScript(spell_pri_lightwell);
    RegisterSpellScript(spell_pri_lightwell_renew);
    RegisterSpellScript(spell_pri_mana_burn);
    RegisterSpellScript(spell_pri_mana_leech);
    RegisterSpellScript(spell_pri_mind_sear);
    RegisterSpellScript(spell_pri_pain_and_suffering_proc);
    RegisterSpellScript(spell_pri_penance);
    RegisterSpellAndAuraScriptPair(spell_pri_power_word_shield, spell_pri_power_word_shield_aura);
    RegisterSpellScript(spell_pri_prayer_of_mending_heal);
    RegisterSpellScript(spell_pri_renew);
    RegisterSpellScript(spell_pri_shadow_word_death);
    RegisterSpellScript(spell_pri_vampiric_touch);
    RegisterSpellScript(spell_pri_mind_control);
    RegisterSpellScript(spell_pri_t4_4p_bonus);
    RegisterSpellScript(spell_pri_shadowfiend_death);
}

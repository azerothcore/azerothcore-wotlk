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

#include "Cell.h"
#include "CellImpl.h"
#include "CreatureScript.h"
#include "GridNotifiers.h"
#include "Pet.h"
#include "SpellAuraEffects.h"
#include "SpellAuras.h"
#include "SpellMgr.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
/*
 * Scripts for spells with SPELLFAMILY_HUNTER, SPELLFAMILY_PET and SPELLFAMILY_GENERIC spells used by hunter players.
 * Ordered alphabetically using scriptname.
 * Scriptnames of files in this file should be prefixed with "spell_hun_".
 */

/// @todo: this import is not necessary for compilation and marked as unused by the IDE
//  however, for some reasons removing it would cause a damn linking issue
//  there is probably some underlying problem with imports which should properly addressed
//  see: https://github.com/azerothcore/azerothcore-wotlk/issues/9766
#include "GridNotifiersImpl.h"

enum HunterSpells
{
    // Ours
    SPELL_HUNTER_WYVERN_STING_DOT                   = 24131,

    // Theirs
    SPELL_HUNTER_ASPECT_OF_THE_BEAST                = 13161,
    SPELL_HUNTER_ASPECT_OF_THE_BEAST_PET            = 61669,
    SPELL_HUNTER_ASPECT_OF_THE_VIPER                = 34074,
    SPELL_HUNTER_ASPECT_OF_THE_VIPER_ENERGIZE       = 34075,
    SPELL_HUNTER_BESTIAL_WRATH                      = 19574,
    SPELL_HUNTER_CHIMERA_SHOT_SERPENT               = 53353,
    SPELL_HUNTER_CHIMERA_SHOT_VIPER                 = 53358,
    SPELL_HUNTER_CHIMERA_SHOT_SCORPID               = 53359,
    SPELL_HUNTER_GLYPH_OF_ASPECT_OF_THE_VIPER       = 56851,
    SPELL_HUNTER_IMPROVED_MEND_PET                  = 24406,
    SPELL_HUNTER_INVIGORATION_TRIGGERED             = 53398,
    SPELL_HUNTER_MASTERS_CALL_TRIGGERED             = 62305,
    SPELL_HUNTER_MISDIRECTION_PROC                  = 35079,
    SPELL_HUNTER_PET_LAST_STAND_TRIGGERED           = 53479,
    SPELL_HUNTER_PET_HEART_OF_THE_PHOENIX           = 55709,
    SPELL_HUNTER_PET_HEART_OF_THE_PHOENIX_TRIGGERED = 54114,
    SPELL_HUNTER_PET_HEART_OF_THE_PHOENIX_DEBUFF    = 55711,
    SPELL_HUNTER_PET_CARRION_FEEDER_TRIGGERED       = 54045,
    SPELL_HUNTER_READINESS                          = 23989,
    SPELL_HUNTER_SNIPER_TRAINING_R1                 = 53302,
    SPELL_HUNTER_SNIPER_TRAINING_BUFF_R1            = 64418,
    SPELL_HUNTER_VICIOUS_VIPER                      = 61609,
    SPELL_HUNTER_VIPER_ATTACK_SPEED                 = 60144,
    SPELL_DRAENEI_GIFT_OF_THE_NAARU                 = 59543,
    SPELL_HUNTER_GLYPH_OF_ARCANE_SHOT               = 61389,
    SPELL_LOCK_AND_LOAD_TRIGGER                     = 56453,
    SPELL_LOCK_AND_LOAD_MARKER                      = 67544,
    SPELL_HUNTER_PET_LEGGINGS_OF_BEAST_MASTERY      = 38297, // Leggings of Beast Mastery
};

class spell_hun_check_pet_los : public SpellScript
{
    PrepareSpellScript(spell_hun_check_pet_los);

    SpellCastResult CheckCast()
    {
        Unit* pet = GetCaster()->GetGuardianPet();
        if (!pet)
            pet = GetCaster()->GetCharm();

        if (!pet)
            return SPELL_FAILED_NO_PET;

        if (!pet->IsAlive())
        {
            SetCustomCastResultMessage(SPELL_CUSTOM_ERROR_PET_IS_DEAD);
            return SPELL_FAILED_CUSTOM_ERROR;
        }

        if (!GetCaster()->IsWithinLOSInMap(pet))
            return SPELL_FAILED_LINE_OF_SIGHT;

        return SPELL_CAST_OK;
    }

    void Register() override
    {
        OnCheckCast += SpellCheckCastFn(spell_hun_check_pet_los::CheckCast);
    }
};

class spell_hun_cower : public AuraScript
{
    PrepareAuraScript(spell_hun_cower);

    void CalculateAmount(AuraEffect const* /*aurEff*/, int32& amount, bool& /*canBeRecalculated*/)
    {
        if (AuraEffect* aurEff = GetUnitOwner()->GetAuraEffect(SPELL_AURA_DUMMY, SPELLFAMILY_PET, GetSpellInfo()->SpellIconID, EFFECT_0))
            AddPct(amount, aurEff->GetAmount());
    }

    void Register() override
    {
        DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_hun_cower::CalculateAmount, EFFECT_1, SPELL_AURA_MOD_DECREASE_SPEED);
    }
};

class spell_hun_wyvern_sting : public AuraScript
{
    PrepareAuraScript(spell_hun_wyvern_sting)

    void HandleEffectRemove(AuraEffect const*  /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        if (Unit* caster = GetCaster())
            caster->CastSpell(GetTarget(), sSpellMgr->GetSpellWithRank(SPELL_HUNTER_WYVERN_STING_DOT, GetSpellInfo()->GetRank()), true);
    }

    void Register() override
    {
        AfterEffectRemove += AuraEffectRemoveFn(spell_hun_wyvern_sting::HandleEffectRemove, EFFECT_0, SPELL_AURA_MOD_STUN, AURA_EFFECT_HANDLE_REAL);
    }
};

class spell_hun_animal_handler : public AuraScript
{
    PrepareAuraScript(spell_hun_animal_handler);

    void CalculateAmount(AuraEffect const*  /*aurEff*/, int32& amount, bool& /*canBeRecalculated*/)
    {
        amount = 0;
        if (Unit* owner = GetUnitOwner()->GetOwner())
            if (AuraEffect const* animalHandlerEff = owner->GetDummyAuraEffect(SPELLFAMILY_HUNTER, 2234, EFFECT_1))
                amount = animalHandlerEff->GetAmount();
    }

    void Register() override
    {
        DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_hun_animal_handler::CalculateAmount, EFFECT_0, SPELL_AURA_MOD_ATTACK_POWER_PCT);
    }
};

class spell_hun_generic_scaling : public AuraScript
{
    PrepareAuraScript(spell_hun_generic_scaling);

    void CalculateResistanceAmount(AuraEffect const* aurEff, int32& amount, bool& /*canBeRecalculated*/)
    {
        // xinef: pet inherits 40% of resistance from owner and 35% of armor
        if (Unit* owner = GetUnitOwner()->GetOwner())
        {
            SpellSchoolMask schoolMask = SpellSchoolMask(aurEff->GetSpellInfo()->Effects[aurEff->GetEffIndex()].MiscValue);
            int32 modifier = schoolMask == SPELL_SCHOOL_MASK_NORMAL ? 35 : 40;
            amount = CalculatePct(std::max<int32>(0, owner->GetResistance(schoolMask)), modifier);
            if (owner->HasAura(SPELL_HUNTER_PET_LEGGINGS_OF_BEAST_MASTERY) && schoolMask == SPELL_SCHOOL_MASK_NORMAL)
            {
                amount += 490;
            }
        }
    }

    void CalculateStatAmount(AuraEffect const* aurEff, int32& amount, bool& /*canBeRecalculated*/)
    {
        if (Unit* owner = GetUnitOwner()->GetOwner())
        {
            // xinef: by default pet inherits 45% of stamina
            int32 modifier = 45;

            // xinef: Wild Hunt bonus for stamina
            if  (AuraEffect* wildHuntEff = GetUnitOwner()->GetDummyAuraEffect(SPELLFAMILY_PET, 3748, EFFECT_0))
                AddPct(modifier, wildHuntEff->GetAmount());

            amount = CalculatePct(std::max<int32>(0, owner->GetStat(Stats(aurEff->GetSpellInfo()->Effects[aurEff->GetEffIndex()].MiscValue))), modifier);
            if (owner->HasAura(SPELL_HUNTER_PET_LEGGINGS_OF_BEAST_MASTERY))
            {
                amount += 52;
            }
        }
    }

    void CalculateAPAmount(AuraEffect const*  /*aurEff*/, int32& amount, bool& /*canBeRecalculated*/)
    {
        if (Unit* owner = GetUnitOwner()->GetOwner())
        {
            // xinef: by default 22% of RAP
            int32 modifier = 22;

            // xinef: Wild Hunt bonus for AP
            if (AuraEffect* wildHuntEff = GetUnitOwner()->GetDummyAuraEffect(SPELLFAMILY_PET, 3748, EFFECT_1))
                AddPct(modifier, wildHuntEff->GetAmount());

            float ownerAP = owner->GetTotalAttackPowerValue(RANGED_ATTACK);

            // Xinef: Hunter vs. Wild
            if (AuraEffect* HvWEff = owner->GetAuraEffect(SPELL_AURA_MOD_ATTACK_POWER_OF_STAT_PERCENT, SPELLFAMILY_HUNTER, 3647, EFFECT_0))
                ownerAP += CalculatePct(owner->GetStat(STAT_STAMINA), HvWEff->GetAmount());

            amount = CalculatePct(std::max<int32>(0, ownerAP), modifier);
            if (owner->HasAura(SPELL_HUNTER_PET_LEGGINGS_OF_BEAST_MASTERY))
            {
                amount += 70;
            }
        }
    }

    void CalculateSPAmount(AuraEffect const*  /*aurEff*/, int32& amount, bool& /*canBeRecalculated*/)
    {
        if (Unit* owner = GetUnitOwner()->GetOwner())
        {
            // xinef: by default 12.87% of RAP
            float modifier = 12.87f;

            // xinef: Wild Hunt bonus for AP
            if (AuraEffect* wildHuntEff = GetUnitOwner()->GetDummyAuraEffect(SPELLFAMILY_PET, 3748, EFFECT_1))
                AddPct(modifier, wildHuntEff->GetAmount());

            amount = CalculatePct(std::max<int32>(0, owner->GetTotalAttackPowerValue(RANGED_ATTACK)), modifier);

            // xinef: Update appropriate player field
            if (owner->IsPlayer())
                owner->SetUInt32Value(PLAYER_PET_SPELL_POWER, (uint32)amount);
        }
    }

    void CalcPeriodic(AuraEffect const* /*aurEff*/, bool& isPeriodic, int32& amplitude)
    {
        isPeriodic = true;
        amplitude = 2 * IN_MILLISECONDS;
    }

    void HandlePeriodic(AuraEffect const* aurEff)
    {
        PreventDefaultAction();
        if (aurEff->GetAuraType() == SPELL_AURA_MOD_STAT && (aurEff->GetMiscValue() == STAT_STAMINA || aurEff->GetMiscValue() == STAT_INTELLECT))
        {
            int32 currentAmount = aurEff->GetAmount();
            int32 newAmount = GetEffect(aurEff->GetEffIndex())->CalculateAmount(GetCaster());
            if (newAmount != currentAmount)
            {
                if (aurEff->GetMiscValue() == STAT_STAMINA)
                {
                    uint32 actStat = GetUnitOwner()->GetHealth();
                    GetEffect(aurEff->GetEffIndex())->ChangeAmount(newAmount, false);
                    GetUnitOwner()->SetHealth(std::min<uint32>(GetUnitOwner()->GetMaxHealth(), actStat));
                }
                else
                {
                    uint32 actStat = GetUnitOwner()->GetPower(POWER_MANA);
                    GetEffect(aurEff->GetEffIndex())->ChangeAmount(newAmount, false);
                    GetUnitOwner()->SetPower(POWER_MANA, std::min<uint32>(GetUnitOwner()->GetMaxPower(POWER_MANA), actStat));
                }
            }
        }
        else
            GetEffect(aurEff->GetEffIndex())->RecalculateAmount();
    }

    void Register() override
    {
        if (m_scriptSpellId != 34902)
            DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_hun_generic_scaling::CalculateResistanceAmount, EFFECT_ALL, SPELL_AURA_MOD_RESISTANCE);
        else
        {
            DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_hun_generic_scaling::CalculateStatAmount, EFFECT_ALL, SPELL_AURA_MOD_STAT);
            DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_hun_generic_scaling::CalculateAPAmount, EFFECT_ALL, SPELL_AURA_MOD_ATTACK_POWER);
            DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_hun_generic_scaling::CalculateSPAmount, EFFECT_ALL, SPELL_AURA_MOD_DAMAGE_DONE);
        }

        DoEffectCalcPeriodic += AuraEffectCalcPeriodicFn(spell_hun_generic_scaling::CalcPeriodic, EFFECT_ALL, SPELL_AURA_ANY);
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_hun_generic_scaling::HandlePeriodic, EFFECT_ALL, SPELL_AURA_ANY);
    }
};

// Taming the Beast quests (despawn creature after dismiss)
class spell_hun_taming_the_beast : public AuraScript
{
    PrepareAuraScript(spell_hun_taming_the_beast);

    void HandleOnEffectApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        if (Unit* target = GetTarget())
        {
            if (Creature* creature = target->ToCreature())
            {
                creature->GetThreatMgr().ClearAllThreat();
            }
        }
    }

    void HandleOnEffectRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        if (Unit* target = GetTarget())
            if (Creature* creature = target->ToCreature())
                creature->DespawnOrUnsummon(1);
    }

    void Register() override
    {
        OnEffectApply += AuraEffectApplyFn(spell_hun_taming_the_beast::HandleOnEffectApply, EFFECT_0, SPELL_AURA_MOD_CHARM, AURA_EFFECT_HANDLE_REAL);
        OnEffectRemove += AuraEffectRemoveFn(spell_hun_taming_the_beast::HandleOnEffectRemove, EFFECT_0, SPELL_AURA_MOD_CHARM, AURA_EFFECT_HANDLE_REAL);
    }
};

// 13161 Aspect of the Beast
class spell_hun_aspect_of_the_beast : public AuraScript
{
    PrepareAuraScript(spell_hun_aspect_of_the_beast);

    bool Load() override
    {
        return GetCaster() && GetCaster()->IsPlayer();
    }

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_HUNTER_ASPECT_OF_THE_BEAST_PET });
    }

    void OnRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        if (GetCaster())
            if (Player* caster = GetCaster()->ToPlayer())
                if (Pet* pet = caster->GetPet())
                    pet->RemoveAurasDueToSpell(SPELL_HUNTER_ASPECT_OF_THE_BEAST_PET);
    }

    void OnApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        if (GetCaster())
            if (Player* caster = GetCaster()->ToPlayer())
                if (caster->GetPet())
                    caster->CastSpell(caster, SPELL_HUNTER_ASPECT_OF_THE_BEAST_PET, true);
    }

    void OnPetApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        Unit* pet = GetUnitOwner();
        if (Unit* owner = pet->GetOwner())
            if (owner->HasAura(SPELL_HUNTER_ASPECT_OF_THE_BEAST))
                return;

        SetDuration(0);
    }

    void Register() override
    {
        if (m_scriptSpellId == 13161)
        {
            AfterEffectApply += AuraEffectApplyFn(spell_hun_aspect_of_the_beast::OnApply, EFFECT_0, SPELL_AURA_UNTRACKABLE, AURA_EFFECT_HANDLE_REAL);
            AfterEffectRemove += AuraEffectRemoveFn(spell_hun_aspect_of_the_beast::OnRemove, EFFECT_0, SPELL_AURA_UNTRACKABLE, AURA_EFFECT_HANDLE_REAL);
        }
        else
            AfterEffectApply += AuraEffectApplyFn(spell_hun_aspect_of_the_beast::OnPetApply, EFFECT_0, SPELL_AURA_UNTRACKABLE, AURA_EFFECT_HANDLE_REAL);
    }
};

// 34074 - Aspect of the Viper
class spell_hun_ascpect_of_the_viper : public AuraScript
{
    PrepareAuraScript(spell_hun_ascpect_of_the_viper);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo(
            {
                SPELL_HUNTER_ASPECT_OF_THE_VIPER_ENERGIZE,
                SPELL_HUNTER_GLYPH_OF_ASPECT_OF_THE_VIPER,
                SPELL_HUNTER_VIPER_ATTACK_SPEED,
                SPELL_HUNTER_VICIOUS_VIPER
            });
    }

    bool CheckProc(ProcEventInfo& procInfo)
    {
        SpellInfo const* spellInfo = procInfo.GetSpellInfo();
        // Xinef: cannot proc from volley damage
        if (spellInfo && (spellInfo->SpellFamilyFlags[0] & 0x2000) && spellInfo->Effects[EFFECT_0].Effect == SPELL_EFFECT_SCHOOL_DAMAGE)
            return false;
        return true;
    }

    void HandleProc(AuraEffect const* aurEff, ProcEventInfo&  /*eventInfo*/)
    {
        PreventDefaultAction();

        uint32 maxMana = GetTarget()->GetMaxPower(POWER_MANA);
        int32 mana = CalculatePct(maxMana, GetTarget()->GetAttackTime(RANGED_ATTACK) / 1000.0f);

        if (AuraEffect const* glyph = GetTarget()->GetAuraEffect(SPELL_HUNTER_GLYPH_OF_ASPECT_OF_THE_VIPER, EFFECT_0))
            AddPct(mana, glyph->GetAmount());

        GetTarget()->CastCustomSpell(SPELL_HUNTER_ASPECT_OF_THE_VIPER_ENERGIZE, SPELLVALUE_BASE_POINT0, mana, GetTarget(), true, nullptr, aurEff);
    }

    void OnApply(AuraEffect const* aurEff, AuraEffectHandleModes /*mode*/)
    {
        // Hunter T7 4P Bonus
        if (GetTarget()->HasAura(SPELL_HUNTER_VIPER_ATTACK_SPEED))
            GetTarget()->CastSpell(GetTarget(), SPELL_HUNTER_VICIOUS_VIPER, true, nullptr, aurEff);
    }

    void OnRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        // Hunter T7 4P Bonus
        if (GetTarget()->HasAura(SPELL_HUNTER_VIPER_ATTACK_SPEED))
            GetTarget()->RemoveAurasDueToSpell(SPELL_HUNTER_VICIOUS_VIPER);
    }

    void Register() override
    {
        DoCheckProc += AuraCheckProcFn(spell_hun_ascpect_of_the_viper::CheckProc);
        OnEffectProc += AuraEffectProcFn(spell_hun_ascpect_of_the_viper::HandleProc, EFFECT_2, SPELL_AURA_DUMMY);
        AfterEffectApply += AuraEffectApplyFn(spell_hun_ascpect_of_the_viper::OnApply, EFFECT_0, SPELL_AURA_OBS_MOD_POWER, AURA_EFFECT_HANDLE_REAL);
        AfterEffectRemove += AuraEffectRemoveFn(spell_hun_ascpect_of_the_viper::OnRemove, EFFECT_0, SPELL_AURA_OBS_MOD_POWER, AURA_EFFECT_HANDLE_REAL);
    }
};

// 53209 Chimera Shot
class spell_hun_chimera_shot : public SpellScript
{
    PrepareSpellScript(spell_hun_chimera_shot);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_HUNTER_CHIMERA_SHOT_SERPENT, SPELL_HUNTER_CHIMERA_SHOT_VIPER, SPELL_HUNTER_CHIMERA_SHOT_SCORPID });
    }

    void HandleScriptEffect(SpellEffIndex /*effIndex*/)
    {
        Unit* caster = GetCaster();
        if (Unit* unitTarget = GetHitUnit())
        {
            uint32 spellId = 0;
            int32 basePoint = 0;
            Unit::AuraApplicationMap& Auras = unitTarget->GetAppliedAuras();
            for (Unit::AuraApplicationMap::iterator i = Auras.begin(); i != Auras.end(); ++i)
            {
                Aura* aura = i->second->GetBase();
                if (aura->GetCasterGUID() != caster->GetGUID())
                    continue;

                // Search only Serpent Sting, Viper Sting, Scorpid Sting auras
                flag96 familyFlag = aura->GetSpellInfo()->SpellFamilyFlags;
                if (!(familyFlag[1] & 0x00000080 || familyFlag[0] & 0x0000C000))
                    continue;
                if (AuraEffect* aurEff = aura->GetEffect(0))
                {
                    // Serpent Sting - Instantly deals 40% of the damage done by your Serpent Sting.
                    if (familyFlag[0] & 0x4000)
                    {
                        int32 TickCount = aurEff->GetTotalTicks();
                        spellId = SPELL_HUNTER_CHIMERA_SHOT_SERPENT;
                        basePoint = aurEff->GetAmount();
                        ApplyPct(basePoint, TickCount * 40);
                        basePoint = unitTarget->SpellDamageBonusTaken(caster, aura->GetSpellInfo(), basePoint, DOT, aura->GetStackAmount());
                    }
                    // Viper Sting - Instantly restores mana to you equal to 60% of the total amount drained by your Viper Sting.
                    else if (familyFlag[1] & 0x00000080)
                    {
                        int32 TickCount = aura->GetEffect(0)->GetTotalTicks();
                        spellId = SPELL_HUNTER_CHIMERA_SHOT_VIPER;

                        // Amount of one aura tick
                        basePoint = int32(CalculatePct(unitTarget->GetMaxPower(POWER_MANA), aurEff->GetAmount()));
                        int32 casterBasePoint = aurEff->GetAmount() * unitTarget->GetMaxPower(POWER_MANA) / 50; /// @todo: Caster uses unitTarget?
                        if (basePoint > casterBasePoint)
                            basePoint = casterBasePoint;
                        ApplyPct(basePoint, TickCount * 60);
                    }
                    // Scorpid Sting - Attempts to Disarm the target for 10 sec. This effect cannot occur more than once per 1 minute.
                    else if (familyFlag[0] & 0x00008000)
                    {
                        if (caster->ToPlayer()) // Scorpid Sting - Add 1 minute cooldown
                        {
                            if (caster->ToPlayer()->HasSpellCooldown(SPELL_HUNTER_CHIMERA_SHOT_SCORPID))
                                break;

                            caster->ToPlayer()->AddSpellCooldown(SPELL_HUNTER_CHIMERA_SHOT_SCORPID, 0, 60000);
                        }

                        spellId = SPELL_HUNTER_CHIMERA_SHOT_SCORPID;
                    }

                    // Refresh aura duration
                    aura->RefreshDuration();
                    aurEff->ChangeAmount(aurEff->CalculateAmount(caster), false);
                }
                break;
            }

            if (spellId)
                caster->CastCustomSpell(unitTarget, spellId, &basePoint, 0, 0, true);
        }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_hun_chimera_shot::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

// -19572 - Improved Mend Pet
class spell_hun_improved_mend_pet : public AuraScript
{
    PrepareAuraScript(spell_hun_improved_mend_pet);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_HUNTER_IMPROVED_MEND_PET });
    }

    bool CheckProc(ProcEventInfo& /*eventInfo*/)
    {
        return roll_chance_i(GetEffect(EFFECT_0)->GetAmount());
    }

    void HandleProc(AuraEffect const* aurEff, ProcEventInfo& /*eventInfo*/)
    {
        PreventDefaultAction();
        GetTarget()->CastSpell(GetTarget(), SPELL_HUNTER_IMPROVED_MEND_PET, true, nullptr, aurEff);
    }

    void Register() override
    {
        DoCheckProc += AuraCheckProcFn(spell_hun_improved_mend_pet::CheckProc);
        OnEffectProc += AuraEffectProcFn(spell_hun_improved_mend_pet::HandleProc, EFFECT_0, SPELL_AURA_DUMMY);
    }
};

// 53412 - Invigoration
class spell_hun_invigoration : public SpellScript
{
    PrepareSpellScript(spell_hun_invigoration);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_HUNTER_INVIGORATION_TRIGGERED });
    }

    void HandleScriptEffect(SpellEffIndex /*effIndex*/)
    {
        if (Unit* unitTarget = GetHitUnit())
            if (AuraEffect* aurEff = unitTarget->GetDummyAuraEffect(SPELLFAMILY_HUNTER, 3487, 0))
                if (roll_chance_i(aurEff->GetAmount()))
                    unitTarget->CastSpell(unitTarget, SPELL_HUNTER_INVIGORATION_TRIGGERED, true);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_hun_invigoration::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

// 53478 - Last Stand Pet
class spell_hun_last_stand_pet : public SpellScript
{
    PrepareSpellScript(spell_hun_last_stand_pet);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_HUNTER_PET_LAST_STAND_TRIGGERED });
    }

    void HandleDummy(SpellEffIndex /*effIndex*/)
    {
        Unit* caster = GetCaster();
        int32 healthModSpellBasePoints0 = int32(caster->CountPctFromMaxHealth(30));
        caster->CastCustomSpell(caster, SPELL_HUNTER_PET_LAST_STAND_TRIGGERED, &healthModSpellBasePoints0, nullptr, nullptr, true, nullptr);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_hun_last_stand_pet::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

// 53271 - Masters Call
class spell_hun_masters_call : public SpellScript
{
    PrepareSpellScript(spell_hun_masters_call);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_HUNTER_MASTERS_CALL_TRIGGERED });
    }

    SpellCastResult DoCheckCast()
    {
        Pet* pet = GetCaster()->ToPlayer()->GetPet();
        if (!pet || !pet->IsAlive())
            return SPELL_FAILED_NO_PET;

        // Do a mini Spell::CheckCasterAuras on the pet, no other way of doing this
        SpellCastResult result = SPELL_CAST_OK;
        uint32 const unitflag = pet->GetUnitFlags();
        if (pet->GetCharmerGUID())
            result = SPELL_FAILED_CHARMED;
        else if (unitflag & UNIT_FLAG_STUNNED)
            result = SPELL_FAILED_STUNNED;
        else if (unitflag & UNIT_FLAG_FLEEING)
            result = SPELL_FAILED_FLEEING;
        else if (unitflag & UNIT_FLAG_CONFUSED)
            result = SPELL_FAILED_CONFUSED;

        if (result != SPELL_CAST_OK)
            return result;

        Unit* target = GetExplTargetUnit();
        if (!target)
            return SPELL_FAILED_BAD_TARGETS;

        if (!pet->IsWithinLOSInMap(target))
            return SPELL_FAILED_LINE_OF_SIGHT;

        return SPELL_CAST_OK;
    }

    void HandleDummy(SpellEffIndex /*effIndex*/)
    {
        GetCaster()->ToPlayer()->GetPet()->CastSpell(GetHitUnit(), GetEffectValue(), true);
    }

    void HandleScriptEffect(SpellEffIndex /*effIndex*/)
    {
        GetHitUnit()->CastSpell((Unit*)nullptr, SPELL_HUNTER_MASTERS_CALL_TRIGGERED, true);
    }

    void Register() override
    {
        OnCheckCast += SpellCheckCastFn(spell_hun_masters_call::DoCheckCast);

        OnEffectHitTarget += SpellEffectFn(spell_hun_masters_call::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
        OnEffectHitTarget += SpellEffectFn(spell_hun_masters_call::HandleScriptEffect, EFFECT_1, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

// 23989 - Readiness
class spell_hun_readiness : public SpellScript
{
    PrepareSpellScript(spell_hun_readiness);

    bool Load() override
    {
        return GetCaster()->IsPlayer();
    }

    void HandleDummy(SpellEffIndex /*effIndex*/)
    {
        Player* caster = GetCaster()->ToPlayer();
        // immediately finishes the cooldown on your other Hunter abilities except Bestial Wrath

        // force removal of the disarm cooldown
        caster->RemoveSpellCooldown(SPELL_HUNTER_CHIMERA_SHOT_SCORPID);

        SpellCooldowns& cooldowns = caster->GetSpellCooldownMap();

        std::set<std::pair<uint32, bool>> spellsToRemove;
        std::set<uint32> categoriesToRemove;

        for (const auto& [spellId, cooldown] : cooldowns)
        {
            SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(spellId);
            if (spellInfo
            && spellInfo->SpellFamilyName == SPELLFAMILY_HUNTER
            && spellInfo->Id != SPELL_HUNTER_READINESS
            && spellInfo->Id != SPELL_HUNTER_BESTIAL_WRATH
            && spellInfo->Id != SPELL_DRAENEI_GIFT_OF_THE_NAARU)
            {
                if (spellInfo->RecoveryTime > 0)
                    spellsToRemove.insert(std::make_pair(spellInfo->Id, cooldown.needSendToClient));

                if (spellInfo->CategoryRecoveryTime > 0)
                    categoriesToRemove.insert(spellInfo->GetCategory());
            }
        }

        // we can't remove spell cooldowns while iterating.
        for (const auto& [spellId, sendToClient] : spellsToRemove)
            caster->RemoveSpellCooldown(spellId, sendToClient);
        for (const auto& category : categoriesToRemove)
            caster->RemoveCategoryCooldown(category);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_hun_readiness::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

// 37506 - Scatter Shot
class spell_hun_scatter_shot : public SpellScript
{
    PrepareSpellScript(spell_hun_scatter_shot);

    bool Load() override
    {
        return GetCaster()->IsPlayer();
    }

    void HandleDummy(SpellEffIndex /*effIndex*/)
    {
        Player* caster = GetCaster()->ToPlayer();
        // break Auto Shot and autohit
        caster->InterruptSpell(CURRENT_AUTOREPEAT_SPELL);
        caster->AttackStop();
        caster->SendAttackSwingCancelAttack();
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_hun_scatter_shot::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

// -53302 - Sniper Training
class spell_hun_sniper_training : public AuraScript
{
    PrepareAuraScript(spell_hun_sniper_training);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_HUNTER_SNIPER_TRAINING_R1, SPELL_HUNTER_SNIPER_TRAINING_BUFF_R1 });
    }

    void HandlePeriodic(AuraEffect const* aurEff)
    {
        PreventDefaultAction();
        if (aurEff->GetAmount() <= 0)
        {
            if (!GetCaster() || !GetTarget())
            {
                return;
            }

            Unit* target = GetTarget();

            uint32 spellId = SPELL_HUNTER_SNIPER_TRAINING_BUFF_R1 + GetId() - SPELL_HUNTER_SNIPER_TRAINING_R1;
            if (SpellInfo const* triggeredSpellInfo = sSpellMgr->GetSpellInfo(spellId))
            {
                Unit* triggerCaster = triggeredSpellInfo->NeedsToBeTriggeredByCaster(GetSpellInfo()) ? GetCaster() : target;
                triggerCaster->CastSpell(target, triggeredSpellInfo, true, 0, aurEff);
            }
        }
    }

    void HandleUpdatePeriodic(AuraEffect* aurEff)
    {
        //npcbot: handle creatures, remove dead trigger
        if (!GetUnitOwner()->IsAlive())
            return;
        if (Creature const* bot = GetUnitOwner()->ToCreature())
        {
            if (!bot->IsNPCBot())
                return;

            int32 baseAmount = aurEff->GetBaseAmount();
            int32 amount = bot->isMoving() || aurEff->GetAmount() <= 0 ?
                bot->CalculateSpellDamage(bot, GetSpellInfo(), aurEff->GetEffIndex(), &baseAmount) :
                aurEff->GetAmount() - 1;
            aurEff->SetAmount(amount);
            return;
        }
        //end npcbot
        if (Player* playerTarget = GetUnitOwner()->ToPlayer())
        {
            int32 baseAmount = aurEff->GetBaseAmount();
            int32 amount = playerTarget->isMoving() || aurEff->GetAmount() <= 0 ?
                            playerTarget->CalculateSpellDamage(playerTarget, GetSpellInfo(), aurEff->GetEffIndex(), &baseAmount) :
                            aurEff->GetAmount() - 1;
            aurEff->SetAmount(amount);
        }
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_hun_sniper_training::HandlePeriodic, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
        OnEffectUpdatePeriodic += AuraEffectUpdatePeriodicFn(spell_hun_sniper_training::HandleUpdatePeriodic, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
    }
};

// 55709 - Pet Heart of the Phoenix
class spell_hun_pet_heart_of_the_phoenix : public SpellScript
{
    PrepareSpellScript(spell_hun_pet_heart_of_the_phoenix);

    bool Load() override
    {
        if (!GetCaster()->IsPet())
            return false;
        return true;
    }

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_HUNTER_PET_HEART_OF_THE_PHOENIX_TRIGGERED, SPELL_HUNTER_PET_HEART_OF_THE_PHOENIX_DEBUFF });
    }

    SpellCastResult CheckCast()
    {
        Unit* caster = GetCaster();
        if (caster->IsAlive())
            return SPELL_FAILED_TARGET_NOT_DEAD;
        if (caster->HasAura(SPELL_HUNTER_PET_HEART_OF_THE_PHOENIX_DEBUFF))
            return SPELL_FAILED_CASTER_AURASTATE;
        return SPELL_CAST_OK;
    }

    void HandleScript(SpellEffIndex /*effIndex*/)
    {
        Unit* caster = GetCaster();
        if (Unit* owner = caster->GetOwner())
            if (!caster->HasAura(SPELL_HUNTER_PET_HEART_OF_THE_PHOENIX_DEBUFF))
            {
                owner->CastCustomSpell(SPELL_HUNTER_PET_HEART_OF_THE_PHOENIX_TRIGGERED, SPELLVALUE_BASE_POINT0, 100, caster, true);
                caster->CastSpell(caster, SPELL_HUNTER_PET_HEART_OF_THE_PHOENIX_DEBUFF, true);
            }
    }

    void Register() override
    {
        OnCheckCast += SpellCheckCastFn(spell_hun_pet_heart_of_the_phoenix::CheckCast);
        OnEffectHitTarget += SpellEffectFn(spell_hun_pet_heart_of_the_phoenix::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

// 54044 - Pet Carrion Feeder
class spell_hun_pet_carrion_feeder : public SpellScript
{
    PrepareSpellScript(spell_hun_pet_carrion_feeder);

    bool Load() override
    {
        if (!GetCaster()->IsPet())
            return false;
        return true;
    }

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_HUNTER_PET_CARRION_FEEDER_TRIGGERED });
    }

    SpellCastResult CheckIfCorpseNear()
    {
        Unit* caster = GetCaster();
        float max_range = GetSpellInfo()->GetMaxRange(false);
        WorldObject* result = nullptr;
        // search for nearby enemy corpse in range
        Acore::AnyDeadUnitSpellTargetInRangeCheck check(caster, max_range, GetSpellInfo(), TARGET_CHECK_ENEMY);
        Acore::WorldObjectSearcher<Acore::AnyDeadUnitSpellTargetInRangeCheck> searcher(caster, result, check);
        Cell::VisitWorldObjects(caster, searcher, max_range);
        if (!result)
        {
            Cell::VisitGridObjects(caster, searcher, max_range);
        }
        if (!result)
        {
            return SPELL_FAILED_NO_EDIBLE_CORPSES;
        }
        return SPELL_CAST_OK;
    }

    void HandleDummy(SpellEffIndex /*effIndex*/)
    {
        Unit* caster = GetCaster();
        caster->CastSpell(caster, SPELL_HUNTER_PET_CARRION_FEEDER_TRIGGERED, false);
    }

    void Register() override
    {
        OnEffectHit += SpellEffectFn(spell_hun_pet_carrion_feeder::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
        OnCheckCast += SpellCheckCastFn(spell_hun_pet_carrion_feeder::CheckIfCorpseNear);
    }
};

// 34477 - Misdirection
class spell_hun_misdirection : public AuraScript
{
    PrepareAuraScript(spell_hun_misdirection);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_HUNTER_MISDIRECTION_PROC });
    }

    void OnRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        if (GetTargetApplication()->GetRemoveMode() != AURA_REMOVE_BY_DEFAULT || !GetTarget()->HasAura(SPELL_HUNTER_MISDIRECTION_PROC))
            GetTarget()->ResetRedirectThreat();
    }

    bool CheckProc(ProcEventInfo& /*eventInfo*/)
    {
        return GetTarget()->GetRedirectThreatTarget();
    }

    void HandleProc(AuraEffect const* aurEff, ProcEventInfo& /*eventInfo*/)
    {
        PreventDefaultAction();
        GetTarget()->CastSpell(GetTarget(), SPELL_HUNTER_MISDIRECTION_PROC, true, nullptr, aurEff);
    }

    void Register() override
    {
        AfterEffectRemove += AuraEffectRemoveFn(spell_hun_misdirection::OnRemove, EFFECT_1, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
        DoCheckProc += AuraCheckProcFn(spell_hun_misdirection::CheckProc);
        OnEffectProc += AuraEffectProcFn(spell_hun_misdirection::HandleProc, EFFECT_1, SPELL_AURA_DUMMY);
    }
};

// 35079 - Misdirection (Proc)
class spell_hun_misdirection_proc : public AuraScript
{
    PrepareAuraScript(spell_hun_misdirection_proc);

    void OnRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        GetTarget()->ResetRedirectThreat();
    }

    void Register() override
    {
        AfterEffectRemove += AuraEffectRemoveFn(spell_hun_misdirection_proc::OnRemove, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
    }
};

// 781 - Disengage
class spell_hun_disengage : public SpellScript
{
    PrepareSpellScript(spell_hun_disengage);

    SpellCastResult CheckCast()
    {
        Unit* caster = GetCaster();
        if (caster->IsPlayer() && !caster->IsInCombat())
            return SPELL_FAILED_CANT_DO_THAT_RIGHT_NOW;

        return SPELL_CAST_OK;
    }

    void Register() override
    {
        OnCheckCast += SpellCheckCastFn(spell_hun_disengage::CheckCast);
    }
};

// 1515 - Tame Beast
class spell_hun_tame_beast : public SpellScript
{
    PrepareSpellScript(spell_hun_tame_beast);

    SpellCastResult CheckCast()
    {
        Unit* caster = GetCaster();
        if (caster->GetTypeId() != TYPEID_PLAYER)
            return SPELL_FAILED_DONT_REPORT;

        Player* player = GetCaster()->ToPlayer();

        if (!GetExplTargetUnit())
        {
            player->SendTameFailure(PET_TAME_INVALID_CREATURE);
            return SPELL_FAILED_DONT_REPORT;
        }

        if (Creature* target = GetExplTargetUnit()->ToCreature())
        {
            if (target->GetLevel() > player->GetLevel())
            {
                player->SendTameFailure(PET_TAME_TOO_HIGHLEVEL);
                return SPELL_FAILED_DONT_REPORT;
            }

            if (target->GetCreatureTemplate()->IsExotic() && !player->CanTameExoticPets())
            {
                player->SendTameFailure(PET_TAME_CANT_CONTROL_EXOTIC);
                return SPELL_FAILED_DONT_REPORT;
            }

            if (!target->GetCreatureTemplate()->IsTameable(player->CanTameExoticPets()))
            {
                player->SendTameFailure(PET_TAME_NOT_TAMEABLE);
                return SPELL_FAILED_DONT_REPORT;
            }

            PetStable const* petStable = player->GetPetStable();
            if (petStable)
            {
                if (petStable->CurrentPet)
                    return SPELL_FAILED_ALREADY_HAVE_SUMMON;

                if (petStable->GetUnslottedHunterPet())
                {
                    caster->SendTameFailure(PET_TAME_TOO_MANY);
                    return SPELL_FAILED_DONT_REPORT;
                }
            }

            if (player->GetCharmGUID())
            {
                player->SendTameFailure(PET_TAME_ANOTHER_SUMMON_ACTIVE);
                return SPELL_FAILED_DONT_REPORT;
            }

            if (target->GetOwnerGUID())
            {
                player->SendTameFailure(PET_TAME_CREATURE_ALREADY_OWNED);
                return SPELL_FAILED_DONT_REPORT;
            }
        }
        else
        {
            player->SendTameFailure(PET_TAME_INVALID_CREATURE);
            return SPELL_FAILED_DONT_REPORT;
        }

        return SPELL_CAST_OK;
    }

    void Register() override
    {
        OnCheckCast += SpellCheckCastFn(spell_hun_tame_beast::CheckCast);
    }
};

// 60144 - Viper Attack Speed
class spell_hun_viper_attack_speed : public AuraScript
{
    PrepareAuraScript(spell_hun_viper_attack_speed);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_HUNTER_ASPECT_OF_THE_VIPER, SPELL_HUNTER_VICIOUS_VIPER });
    }

    void OnApply(AuraEffect const* aurEff, AuraEffectHandleModes /*mode*/)
    {
        if (GetTarget()->HasAura(SPELL_HUNTER_ASPECT_OF_THE_VIPER))
            GetTarget()->CastSpell(GetTarget(), SPELL_HUNTER_VICIOUS_VIPER, true, nullptr, aurEff);
    }

    void OnRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        // possible exploit
        GetTarget()->RemoveAurasDueToSpell(SPELL_HUNTER_VICIOUS_VIPER);
    }

    void Register() override
    {
        AfterEffectApply += AuraEffectApplyFn(spell_hun_viper_attack_speed::OnApply, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
        AfterEffectRemove += AuraEffectRemoveFn(spell_hun_viper_attack_speed::OnRemove, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
    }
};

// 56841 - Glyph of Arcane Shot
class spell_hun_glyph_of_arcane_shot : public AuraScript
{
    PrepareAuraScript(spell_hun_glyph_of_arcane_shot);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_HUNTER_GLYPH_OF_ARCANE_SHOT });
    }

    bool CheckProc(ProcEventInfo& eventInfo)
    {
        if (Unit* procTarget = eventInfo.GetProcTarget())
        {
            // Find Serpent Sting, Viper Sting, Scorpid Sting, Wyvern Sting
            const auto found = std::find_if(std::begin(procTarget->GetAppliedAuras()), std::end(procTarget->GetAppliedAuras()),
                [&](std::pair<uint32, AuraApplication*> pair)
                {
                    Aura const* aura = pair.second->GetBase();
                    return ((aura->GetCasterGUID() == GetTarget()->GetGUID())
                        && aura->GetSpellInfo()->SpellFamilyName == SPELLFAMILY_HUNTER
                        && aura->GetSpellInfo()->SpellFamilyFlags.HasFlag(0xC000, 0x1080));
                });

            if (found != std::end(procTarget->GetAppliedAuras()))
            {
                return true;
            }
        }
        return false;
    }

    void HandleProc(AuraEffect const* aurEff, ProcEventInfo& eventInfo)
    {
        PreventDefaultAction();
        SpellInfo const* procSpell = eventInfo.GetSpellInfo();
        if (!procSpell)
        {
            return;
        }

        int32 mana = procSpell->CalcPowerCost(GetTarget(), procSpell->GetSchoolMask());
        ApplyPct(mana, aurEff->GetAmount());

        GetTarget()->CastCustomSpell(SPELL_HUNTER_GLYPH_OF_ARCANE_SHOT, SPELLVALUE_BASE_POINT0, mana, GetTarget());
    }

    void Register() override
    {
        DoCheckProc += AuraCheckProcFn(spell_hun_glyph_of_arcane_shot::CheckProc);
        OnEffectProc += AuraEffectProcFn(spell_hun_glyph_of_arcane_shot::HandleProc, EFFECT_0, SPELL_AURA_DUMMY);
    }
};

// -42243 - Volley (Trigger one)
class spell_hun_volley_trigger : public SpellScript
{
    PrepareSpellScript(spell_hun_volley_trigger);

    void SelectTarget(std::list<WorldObject*>& targets)
    {
        // It's here because Volley is an AOE spell so there is no specific target to be attacked
        // Let's select one of our targets
        if (!targets.empty())
        {
            _target = *(targets.begin());
        }
    }

    void HandleFinish()
    {
        if (!_target)
        {
            return;
        }

        Unit* caster = GetCaster();
        if (!caster || !caster->IsPlayer())
        {
            return;
        }

        for (Unit::ControlSet::iterator itr = caster->m_Controlled.begin(); itr != caster->m_Controlled.end(); ++itr)
        {
            if (Unit* pet = *itr)
            {
                if (pet->IsAlive() && pet->GetTypeId() == TYPEID_UNIT)
                {
                    pet->ToCreature()->AI()->OwnerAttacked(_target->ToUnit());
                }
            }
        }
    }

    void Register() override
    {
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_hun_volley_trigger::SelectTarget, EFFECT_0, TARGET_UNIT_DEST_AREA_ENEMY);
        AfterCast += SpellCastFn(spell_hun_volley_trigger::HandleFinish);
    }

private:
    WorldObject* _target = nullptr;
};

enum LocknLoadSpells
{
    SPELL_FROST_TRAP_SLOW = 67035
};

// -56342 - Lock and Load
class spell_hun_lock_and_load : public AuraScript
{
    PrepareAuraScript(spell_hun_lock_and_load);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_LOCK_AND_LOAD_TRIGGER, SPELL_LOCK_AND_LOAD_MARKER, SPELL_FROST_TRAP_SLOW });
    }

    bool CheckTrapProc(ProcEventInfo& eventInfo)
    {
        SpellInfo const* spellInfo = eventInfo.GetSpellInfo();
        if (!spellInfo || !eventInfo.GetActor())
        {
            return false;
        }

        // Black Arrow and Fire traps may trigger on periodic tick only.
        if (((spellInfo->GetSchoolMask() & SPELL_SCHOOL_MASK_FIRE) || (spellInfo->GetSchoolMask() & SPELL_SCHOOL_MASK_SHADOW))
            && (spellInfo->Effects[0].ApplyAuraName == SPELL_AURA_PERIODIC_DAMAGE || spellInfo->Effects[1].ApplyAuraName == SPELL_AURA_PERIODIC_DAMAGE))
        {
            return true;
        }

        return IsTargetValid(spellInfo, eventInfo.GetProcTarget()) && !eventInfo.GetActor()->HasAura(SPELL_LOCK_AND_LOAD_MARKER);
    }

    bool IsTargetValid(SpellInfo const* spellInfo, Unit* target)
    {
        if (!spellInfo || !target)
        {
            return false;
        }

        // Don't check it for fire traps and black arrow, they proc on periodic only and not spell hit.
        // So it's wrong to check for immunity, it was already checked when the spell was applied.
        if ((spellInfo->GetSchoolMask() & SPELL_SCHOOL_MASK_FIRE) || (spellInfo->GetSchoolMask() & SPELL_SCHOOL_MASK_SHADOW))
        {
            return false;
        }

        // HitMask for Frost Trap can't be checked correctly as it is.
        // That's because the talent is triggered by the spell that fires the trap (63487)...
        // ...and not the actual spell that applies the slow effect (67035).
        // So the IMMUNE result is never sent by the spell that triggers this.
        if (spellInfo->GetSchoolMask() & SPELL_SCHOOL_MASK_NATURE)
        {
            if (SpellInfo const* triggerSpell = sSpellMgr->GetSpellInfo(SPELL_FROST_TRAP_SLOW))
            {
                return !target->IsImmunedToSpell(triggerSpell);
            }
        }

        return true;
    }

    template <uint32 mask>
    void HandleProcs(AuraEffect const* aurEff, ProcEventInfo& eventInfo)
    {
        PreventDefaultAction();

        SpellInfo const* spellInfo = eventInfo.GetSpellInfo();

        if (!(eventInfo.GetTypeMask() & mask) || !spellInfo)
        {
            return;
        }

        // Also check if the proc from the fire traps and black arrow actually comes from the periodic ticks here.
        // Normally this wouldn't be required, but we are circumventing the current proc system limitations.
        if (((spellInfo->GetSchoolMask() & SPELL_SCHOOL_MASK_FIRE) || (spellInfo->GetSchoolMask() & SPELL_SCHOOL_MASK_SHADOW))
            && (spellInfo->Effects[0].ApplyAuraName == SPELL_AURA_PERIODIC_DAMAGE || spellInfo->Effects[1].ApplyAuraName == SPELL_AURA_PERIODIC_DAMAGE)
            && !(mask & PROC_FLAG_DONE_PERIODIC))
        {
            return;
        }

        if (!roll_chance_i(aurEff->GetAmount()))
        {
            return;
        }

        Unit* caster = eventInfo.GetActor();
        caster->CastSpell(caster, SPELL_LOCK_AND_LOAD_TRIGGER, true);
    }

    void ApplyMarker(ProcEventInfo& eventInfo)
    {
        if (IsTargetValid(eventInfo.GetSpellInfo(), eventInfo.GetProcTarget()))
        {
            Unit* caster = eventInfo.GetActor();
            caster->CastSpell(caster, SPELL_LOCK_AND_LOAD_MARKER, true);
        }
    }

    void Register() override
    {
        DoCheckProc += AuraCheckProcFn(spell_hun_lock_and_load::CheckTrapProc);

        OnEffectProc += AuraEffectProcFn(spell_hun_lock_and_load::HandleProcs<PROC_FLAG_DONE_TRAP_ACTIVATION>, EFFECT_0, SPELL_AURA_PROC_TRIGGER_SPELL);
        OnEffectProc += AuraEffectProcFn(spell_hun_lock_and_load::HandleProcs<PROC_FLAG_DONE_PERIODIC>, EFFECT_1, SPELL_AURA_DUMMY);

        AfterProc += AuraProcFn(spell_hun_lock_and_load::ApplyMarker);
    }
};

// 19577 - Intimidation
class spell_hun_intimidation : public AuraScript
{
    PrepareAuraScript(spell_hun_intimidation);

    bool CheckProc(ProcEventInfo& eventInfo)
    {
        if (SpellInfo const* spellInfo = eventInfo.GetSpellInfo())
        {
            return !spellInfo->IsPositive();
        }

        return true;
    }

    void Register() override
    {
        DoCheckProc += AuraCheckProcFn(spell_hun_intimidation::CheckProc);
    }
};

// 19574 - Bestial Wrath
class spell_hun_bestial_wrath : public SpellScript
{
    PrepareSpellScript(spell_hun_bestial_wrath);

    SpellCastResult CheckCast()
    {
        Unit* caster = GetCaster();
        if (!caster || caster->GetTypeId() != TYPEID_PLAYER)
        {
            return SPELL_FAILED_NO_VALID_TARGETS;
        }

        Pet* pet = caster->ToPlayer()->GetPet();
        if (!pet)
        {
            return SPELL_FAILED_NO_PET;
        }

        if (!pet->IsAlive())
        {
            SetCustomCastResultMessage(SPELL_CUSTOM_ERROR_PET_IS_DEAD);
            return SPELL_FAILED_CUSTOM_ERROR;
        }

        return SPELL_CAST_OK;
    }

    void Register() override
    {
        OnCheckCast += SpellCheckCastFn(spell_hun_bestial_wrath::CheckCast);
    }
};

// -24604 - Furious Howl
// 53434 - Call of the Wild
class spell_hun_target_self_and_pet : public SpellScript
{
    PrepareSpellScript(spell_hun_target_self_and_pet);

    bool Load() override
    {
        return GetCaster()->IsPet();
    }

    void FilterTargets(std::list<WorldObject*>& targets)
    {
        targets.remove_if([&](WorldObject const* target) -> bool
        {
            return target != GetCaster() && target != GetCaster()->ToPet()->GetOwner();
        });
    }

    void Register() override
    {
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_hun_target_self_and_pet::FilterTargets, EFFECT_ALL, TARGET_UNIT_CASTER_AREA_PARTY);
    }
};

void AddSC_hunter_spell_scripts()
{
    RegisterSpellScript(spell_hun_check_pet_los);
    RegisterSpellScript(spell_hun_cower);
    RegisterSpellScript(spell_hun_wyvern_sting);
    RegisterSpellScript(spell_hun_animal_handler);
    RegisterSpellScript(spell_hun_generic_scaling);
    RegisterSpellScript(spell_hun_taming_the_beast);
    RegisterSpellScript(spell_hun_glyph_of_arcane_shot);
    RegisterSpellScript(spell_hun_aspect_of_the_beast);
    RegisterSpellScript(spell_hun_ascpect_of_the_viper);
    RegisterSpellScript(spell_hun_chimera_shot);
    RegisterSpellScript(spell_hun_disengage);
    RegisterSpellScript(spell_hun_improved_mend_pet);
    RegisterSpellScript(spell_hun_invigoration);
    RegisterSpellScript(spell_hun_last_stand_pet);
    RegisterSpellScript(spell_hun_masters_call);
    RegisterSpellScript(spell_hun_misdirection);
    RegisterSpellScript(spell_hun_misdirection_proc);
    RegisterSpellScript(spell_hun_pet_carrion_feeder);
    RegisterSpellScript(spell_hun_pet_heart_of_the_phoenix);
    RegisterSpellScript(spell_hun_readiness);
    RegisterSpellScript(spell_hun_scatter_shot);
    RegisterSpellScript(spell_hun_sniper_training);
    RegisterSpellScript(spell_hun_tame_beast);
    RegisterSpellScript(spell_hun_viper_attack_speed);
    RegisterSpellScript(spell_hun_volley_trigger);
    RegisterSpellScript(spell_hun_lock_and_load);
    RegisterSpellScript(spell_hun_intimidation);
    RegisterSpellScript(spell_hun_bestial_wrath);
    RegisterSpellScript(spell_hun_target_self_and_pet);
}

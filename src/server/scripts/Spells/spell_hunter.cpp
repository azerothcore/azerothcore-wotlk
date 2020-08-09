/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

/*
 * Scripts for spells with SPELLFAMILY_HUNTER, SPELLFAMILY_PET and SPELLFAMILY_GENERIC spells used by hunter players.
 * Ordered alphabetically using scriptname.
 * Scriptnames of files in this file should be prefixed with "spell_hun_".
 */

#include "Pet.h"
#include "ScriptMgr.h"
#include "Cell.h"
#include "CellImpl.h"
#include "GridNotifiers.h"
#include "GridNotifiersImpl.h"
#include "SpellScript.h"
#include "SpellAuraEffects.h"

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
    SPELL_DRAENEI_GIFT_OF_THE_NAARU                 = 59543
};

// Ours
class spell_hun_check_pet_los : public SpellScriptLoader
{
    public:
        spell_hun_check_pet_los() : SpellScriptLoader("spell_hun_check_pet_los") {}

        class spell_hun_check_pet_los_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_hun_check_pet_los_SpellScript);

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

            void Register()
            {
                OnCheckCast += SpellCheckCastFn(spell_hun_check_pet_los_SpellScript::CheckCast);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_hun_check_pet_los_SpellScript();
        }
};

class spell_hun_cower : public SpellScriptLoader
{
    public:
        spell_hun_cower() : SpellScriptLoader("spell_hun_cower") { }

        class spell_hun_cower_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_hun_cower_AuraScript);

            void CalculateAmount(AuraEffect const* /*aurEff*/, int32 & amount, bool & /*canBeRecalculated*/)
            {
                if (AuraEffect* aurEff = GetUnitOwner()->GetAuraEffect(SPELL_AURA_DUMMY, SPELLFAMILY_PET, GetSpellInfo()->SpellIconID, EFFECT_0))
                    AddPct(amount, aurEff->GetAmount());
            }

            void Register()
            {
                 DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_hun_cower_AuraScript::CalculateAmount, EFFECT_1, SPELL_AURA_MOD_DECREASE_SPEED);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_hun_cower_AuraScript();
        }
};

class spell_hun_wyvern_sting : public SpellScriptLoader
{
    public:
        spell_hun_wyvern_sting() : SpellScriptLoader("spell_hun_wyvern_sting") { }

        class spell_hun_wyvern_sting_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_hun_wyvern_sting_AuraScript)

            void HandleEffectRemove(AuraEffect const*  /*aurEff*/, AuraEffectHandleModes /*mode*/)
            {
                if (Unit* caster = GetCaster())
                    caster->CastSpell(GetTarget(), sSpellMgr->GetSpellWithRank(SPELL_HUNTER_WYVERN_STING_DOT, GetSpellInfo()->GetRank()), true);
            }

            void Register()
            {
                AfterEffectRemove += AuraEffectRemoveFn(spell_hun_wyvern_sting_AuraScript::HandleEffectRemove, EFFECT_0, SPELL_AURA_MOD_STUN, AURA_EFFECT_HANDLE_REAL);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_hun_wyvern_sting_AuraScript();
        }
};

class spell_hun_animal_handler : public SpellScriptLoader
{
    public:
        spell_hun_animal_handler() : SpellScriptLoader("spell_hun_animal_handler") { }

        class spell_hun_animal_handler_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_hun_animal_handler_AuraScript);

            void CalculateAmount(AuraEffect const*  /*aurEff*/, int32 & amount, bool & /*canBeRecalculated*/)
            {
                amount = 0;
                if (Unit* owner = GetUnitOwner()->GetOwner())
                    if (AuraEffect const* animalHandlerEff = owner->GetDummyAuraEffect(SPELLFAMILY_HUNTER, 2234, EFFECT_1))
                        amount = animalHandlerEff->GetAmount();
            }

            void Register()
            {
                DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_hun_animal_handler_AuraScript::CalculateAmount, EFFECT_0, SPELL_AURA_MOD_ATTACK_POWER_PCT);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_hun_animal_handler_AuraScript();
        }
};

class spell_hun_generic_scaling : public SpellScriptLoader
{
    public:
        spell_hun_generic_scaling() : SpellScriptLoader("spell_hun_generic_scaling") { }

        class spell_hun_generic_scaling_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_hun_generic_scaling_AuraScript);

            void CalculateResistanceAmount(AuraEffect const* aurEff, int32 & amount, bool & /*canBeRecalculated*/)
            {
                // xinef: pet inherits 40% of resistance from owner and 35% of armor
                if (Unit* owner = GetUnitOwner()->GetOwner())
                {
                    SpellSchoolMask schoolMask = SpellSchoolMask(aurEff->GetSpellInfo()->Effects[aurEff->GetEffIndex()].MiscValue);
                    int32 modifier = schoolMask == SPELL_SCHOOL_MASK_NORMAL ? 35 : 40;
                    amount = CalculatePct(std::max<int32>(0, owner->GetResistance(schoolMask)), modifier);
                }
            }

            void CalculateStatAmount(AuraEffect const* aurEff, int32 & amount, bool & /*canBeRecalculated*/)
            {
                if (Unit* owner = GetUnitOwner()->GetOwner())
                {
                    // xinef: by default pet inherits 45% of stamina
                    int32 modifier = 45;

                    // xinef: Wild Hunt bonus for stamina
                    if  (AuraEffect* wildHuntEff = GetUnitOwner()->GetDummyAuraEffect(SPELLFAMILY_PET, 3748, EFFECT_0))
                        AddPct(modifier, wildHuntEff->GetAmount());

                    amount = CalculatePct(std::max<int32>(0, owner->GetStat(Stats(aurEff->GetSpellInfo()->Effects[aurEff->GetEffIndex()].MiscValue))), modifier);
                }
            }

            void CalculateAPAmount(AuraEffect const*  /*aurEff*/, int32 & amount, bool & /*canBeRecalculated*/)
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
                }
            }

            void CalculateSPAmount(AuraEffect const*  /*aurEff*/, int32 & amount, bool & /*canBeRecalculated*/)
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
                    if (owner->GetTypeId() == TYPEID_PLAYER)
                        owner->SetUInt32Value(PLAYER_PET_SPELL_POWER, (uint32)amount);
                }
            }

            void CalcPeriodic(AuraEffect const* /*aurEff*/, bool& isPeriodic, int32& amplitude)
            {
                isPeriodic = true;
                amplitude = 2*IN_MILLISECONDS;
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

            void Register()
            {
                if (m_scriptSpellId != 34902)
                    DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_hun_generic_scaling_AuraScript::CalculateResistanceAmount, EFFECT_ALL, SPELL_AURA_MOD_RESISTANCE);
                else
                {
                    DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_hun_generic_scaling_AuraScript::CalculateStatAmount, EFFECT_ALL, SPELL_AURA_MOD_STAT);
                    DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_hun_generic_scaling_AuraScript::CalculateAPAmount, EFFECT_ALL, SPELL_AURA_MOD_ATTACK_POWER);
                    DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_hun_generic_scaling_AuraScript::CalculateSPAmount, EFFECT_ALL, SPELL_AURA_MOD_DAMAGE_DONE);
                }

                DoEffectCalcPeriodic += AuraEffectCalcPeriodicFn(spell_hun_generic_scaling_AuraScript::CalcPeriodic, EFFECT_ALL, SPELL_AURA_ANY);
                OnEffectPeriodic += AuraEffectPeriodicFn(spell_hun_generic_scaling_AuraScript::HandlePeriodic, EFFECT_ALL, SPELL_AURA_ANY);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_hun_generic_scaling_AuraScript();
        }
};

// Taming the Beast quests (despawn creature after dismiss)
class spell_hun_taming_the_beast : public SpellScriptLoader
{
    public:
        spell_hun_taming_the_beast() : SpellScriptLoader("spell_hun_taming_the_beast") { }

        class spell_hun_taming_the_beast_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_hun_taming_the_beast_AuraScript);

            void HandleOnEffectRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
            {
                if (Unit* target = GetTarget())
                    if (Creature* creature = target->ToCreature())
                        creature->DespawnOrUnsummon(1);
            }

            void Register()
            {
                OnEffectRemove += AuraEffectRemoveFn(spell_hun_taming_the_beast_AuraScript::HandleOnEffectRemove, EFFECT_0, SPELL_AURA_MOD_CHARM, AURA_EFFECT_HANDLE_REAL);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_hun_taming_the_beast_AuraScript();
        }
};



// Theirs
// 13161 Aspect of the Beast
class spell_hun_aspect_of_the_beast : public SpellScriptLoader
{
    public:
        spell_hun_aspect_of_the_beast() : SpellScriptLoader("spell_hun_aspect_of_the_beast") { }

        class spell_hun_aspect_of_the_beast_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_hun_aspect_of_the_beast_AuraScript);

            bool Load()
            {
                return GetCaster() && GetCaster()->GetTypeId() == TYPEID_PLAYER;
            }

            bool Validate(SpellInfo const* /*spellInfo*/)
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_HUNTER_ASPECT_OF_THE_BEAST_PET))
                    return false;
                return true;
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

            void Register()
            {
                if (m_scriptSpellId == 13161)
                {
                    AfterEffectApply += AuraEffectApplyFn(spell_hun_aspect_of_the_beast_AuraScript::OnApply, EFFECT_0, SPELL_AURA_UNTRACKABLE, AURA_EFFECT_HANDLE_REAL);
                    AfterEffectRemove += AuraEffectRemoveFn(spell_hun_aspect_of_the_beast_AuraScript::OnRemove, EFFECT_0, SPELL_AURA_UNTRACKABLE, AURA_EFFECT_HANDLE_REAL);
                }
                else
                    AfterEffectApply += AuraEffectApplyFn(spell_hun_aspect_of_the_beast_AuraScript::OnPetApply, EFFECT_0, SPELL_AURA_UNTRACKABLE, AURA_EFFECT_HANDLE_REAL);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_hun_aspect_of_the_beast_AuraScript();
        }
};


// Theirs
// 34074 - Aspect of the Viper
class spell_hun_ascpect_of_the_viper : public SpellScriptLoader
{
    public:
        spell_hun_ascpect_of_the_viper() : SpellScriptLoader("spell_hun_ascpect_of_the_viper") { }

        class spell_hun_ascpect_of_the_viper_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_hun_ascpect_of_the_viper_AuraScript);

            bool Validate(SpellInfo const* /*spellInfo*/)
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_HUNTER_ASPECT_OF_THE_VIPER_ENERGIZE) ||
                    !sSpellMgr->GetSpellInfo(SPELL_HUNTER_GLYPH_OF_ASPECT_OF_THE_VIPER) ||
                    !sSpellMgr->GetSpellInfo(SPELL_HUNTER_VIPER_ATTACK_SPEED) ||
                    !sSpellMgr->GetSpellInfo(SPELL_HUNTER_VICIOUS_VIPER))
                    return false;
                return true;
            }

            bool CheckProc(ProcEventInfo& procInfo)
            {
                SpellInfo const* spellInfo = procInfo.GetDamageInfo()->GetSpellInfo();
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

                GetTarget()->CastCustomSpell(SPELL_HUNTER_ASPECT_OF_THE_VIPER_ENERGIZE, SPELLVALUE_BASE_POINT0, mana, GetTarget(), true, NULL, aurEff);
            }

            void OnApply(AuraEffect const* aurEff, AuraEffectHandleModes /*mode*/)
            {
                // Hunter T7 4P Bonus
                if (GetTarget()->HasAura(SPELL_HUNTER_VIPER_ATTACK_SPEED))
                    GetTarget()->CastSpell(GetTarget(), SPELL_HUNTER_VICIOUS_VIPER, true, NULL, aurEff);
            }

            void OnRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
            {
                // Hunter T7 4P Bonus
                if (GetTarget()->HasAura(SPELL_HUNTER_VIPER_ATTACK_SPEED))
                    GetTarget()->RemoveAurasDueToSpell(SPELL_HUNTER_VICIOUS_VIPER);
            }

            void Register()
            {
                DoCheckProc += AuraCheckProcFn(spell_hun_ascpect_of_the_viper_AuraScript::CheckProc);
                OnEffectProc += AuraEffectProcFn(spell_hun_ascpect_of_the_viper_AuraScript::HandleProc, EFFECT_0, SPELL_AURA_OBS_MOD_POWER);
                AfterEffectApply += AuraEffectApplyFn(spell_hun_ascpect_of_the_viper_AuraScript::OnApply, EFFECT_0, SPELL_AURA_OBS_MOD_POWER, AURA_EFFECT_HANDLE_REAL);
                AfterEffectRemove += AuraEffectRemoveFn(spell_hun_ascpect_of_the_viper_AuraScript::OnRemove, EFFECT_0, SPELL_AURA_OBS_MOD_POWER, AURA_EFFECT_HANDLE_REAL);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_hun_ascpect_of_the_viper_AuraScript();
        }
};

// 53209 Chimera Shot
class spell_hun_chimera_shot : public SpellScriptLoader
{
    public:
        spell_hun_chimera_shot() : SpellScriptLoader("spell_hun_chimera_shot") { }

        class spell_hun_chimera_shot_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_hun_chimera_shot_SpellScript);

            bool Validate(SpellInfo const* /*spellInfo*/)
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_HUNTER_CHIMERA_SHOT_SERPENT) || !sSpellMgr->GetSpellInfo(SPELL_HUNTER_CHIMERA_SHOT_VIPER) || !sSpellMgr->GetSpellInfo(SPELL_HUNTER_CHIMERA_SHOT_SCORPID))
                    return false;
                return true;
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
                                int32 casterBasePoint = aurEff->GetAmount() * unitTarget->GetMaxPower(POWER_MANA) / 50; // TODO: WTF? caster uses unitTarget?
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

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_hun_chimera_shot_SpellScript::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_hun_chimera_shot_SpellScript();
        }
};


// -19572 - Improved Mend Pet
class spell_hun_improved_mend_pet : public SpellScriptLoader
{
    public:
        spell_hun_improved_mend_pet() : SpellScriptLoader("spell_hun_improved_mend_pet") { }

        class spell_hun_improved_mend_pet_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_hun_improved_mend_pet_AuraScript);

            bool Validate(SpellInfo const* /*spellInfo*/)
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_HUNTER_IMPROVED_MEND_PET))
                    return false;
                return true;
            }

            bool CheckProc(ProcEventInfo& /*eventInfo*/)
            {
                return roll_chance_i(GetEffect(EFFECT_0)->GetAmount());
            }

            void HandleProc(AuraEffect const* aurEff, ProcEventInfo& /*eventInfo*/)
            {
                PreventDefaultAction();
                GetTarget()->CastSpell(GetTarget(), SPELL_HUNTER_IMPROVED_MEND_PET, true, NULL, aurEff);
            }

            void Register()
            {
                DoCheckProc += AuraCheckProcFn(spell_hun_improved_mend_pet_AuraScript::CheckProc);
                OnEffectProc += AuraEffectProcFn(spell_hun_improved_mend_pet_AuraScript::HandleProc, EFFECT_0, SPELL_AURA_DUMMY);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_hun_improved_mend_pet_AuraScript();
        }
};
// 53412 - Invigoration
class spell_hun_invigoration : public SpellScriptLoader
{
    public:
        spell_hun_invigoration() : SpellScriptLoader("spell_hun_invigoration") { }

        class spell_hun_invigoration_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_hun_invigoration_SpellScript);

            bool Validate(SpellInfo const* /*spellInfo*/)
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_HUNTER_INVIGORATION_TRIGGERED))
                    return false;
                return true;
            }

            void HandleScriptEffect(SpellEffIndex /*effIndex*/)
            {
                if (Unit* unitTarget = GetHitUnit())
                    if (AuraEffect* aurEff = unitTarget->GetDummyAuraEffect(SPELLFAMILY_HUNTER, 3487, 0))
                        if (roll_chance_i(aurEff->GetAmount()))
                            unitTarget->CastSpell(unitTarget, SPELL_HUNTER_INVIGORATION_TRIGGERED, true);
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_hun_invigoration_SpellScript::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_hun_invigoration_SpellScript();
        }
};

// 53478 - Last Stand Pet
class spell_hun_last_stand_pet : public SpellScriptLoader
{
    public:
        spell_hun_last_stand_pet() : SpellScriptLoader("spell_hun_last_stand_pet") { }

        class spell_hun_last_stand_pet_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_hun_last_stand_pet_SpellScript);

            bool Validate(SpellInfo const* /*spellInfo*/)
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_HUNTER_PET_LAST_STAND_TRIGGERED))
                    return false;
                return true;
            }

            void HandleDummy(SpellEffIndex /*effIndex*/)
            {
                Unit* caster = GetCaster();
                int32 healthModSpellBasePoints0 = int32(caster->CountPctFromMaxHealth(30));
                caster->CastCustomSpell(caster, SPELL_HUNTER_PET_LAST_STAND_TRIGGERED, &healthModSpellBasePoints0, nullptr, nullptr, true, nullptr);
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_hun_last_stand_pet_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_hun_last_stand_pet_SpellScript();
        }
};

// 53271 - Masters Call
class spell_hun_masters_call : public SpellScriptLoader
{
    public:
        spell_hun_masters_call() : SpellScriptLoader("spell_hun_masters_call") { }

        class spell_hun_masters_call_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_hun_masters_call_SpellScript);

            bool Validate(SpellInfo const* spellInfo)
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_HUNTER_MASTERS_CALL_TRIGGERED) || !sSpellMgr->GetSpellInfo(spellInfo->Effects[EFFECT_0].CalcValue()) || !sSpellMgr->GetSpellInfo(spellInfo->Effects[EFFECT_1].CalcValue()))
                    return false;
                return true;
            }

            void HandleScriptEffect(SpellEffIndex /*effIndex*/)
            {
                if (Unit* target = GetHitUnit())
                {
                    // Cannot be processed while pet is dead
                    TriggerCastFlags castMask = TriggerCastFlags(TRIGGERED_FULL_MASK & ~TRIGGERED_IGNORE_CASTER_AURASTATE);
                    //target->CastSpell(target, GetEffectValue(), castMask);
                    target->CastSpell(target, SPELL_HUNTER_MASTERS_CALL_TRIGGERED, castMask);
                    // there is a possibility that this effect should access effect 0 (dummy) target, but i dubt that
                    // it's more likely that on on retail it's possible to call target selector based on dbc values
                    // anyways, we're using GetExplTargetUnit() here and it's ok
                    if (Unit* ally = GetExplTargetUnit())
                    {
                        //target->CastSpell(ally, GetEffectValue(), castMask);
                        target->CastSpell(ally, GetSpellInfo()->Effects[EFFECT_0].CalcValue(), castMask);
                    }
                }
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_hun_masters_call_SpellScript::HandleScriptEffect, EFFECT_1, SPELL_EFFECT_SCRIPT_EFFECT);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_hun_masters_call_SpellScript();
        }
};

// 23989 - Readiness
class spell_hun_readiness : public SpellScriptLoader
{
    public:
        spell_hun_readiness() : SpellScriptLoader("spell_hun_readiness") { }

        class spell_hun_readiness_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_hun_readiness_SpellScript);

            bool Load()
            {
                return GetCaster()->GetTypeId() == TYPEID_PLAYER;
            }

            void HandleDummy(SpellEffIndex /*effIndex*/)
            {
                Player* caster = GetCaster()->ToPlayer();
                // immediately finishes the cooldown on your other Hunter abilities except Bestial Wrath

                PlayerSpellMap const& spellMap = caster->GetSpellMap();
                for (PlayerSpellMap::const_iterator itr = spellMap.begin(); itr != spellMap.end(); ++itr)
                {
                    SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(itr->first);
                    if (spellInfo->SpellFamilyName == SPELLFAMILY_HUNTER &&
                        spellInfo->Id != SPELL_HUNTER_READINESS &&
                        spellInfo->Id != SPELL_HUNTER_BESTIAL_WRATH &&
                        spellInfo->Id != SPELL_DRAENEI_GIFT_OF_THE_NAARU &&
                        spellInfo->GetRecoveryTime() > 0)
                    {
                        SpellCooldowns::iterator citr = caster->GetSpellCooldownMap().find(spellInfo->Id);
                        if (citr != caster->GetSpellCooldownMap().end() && citr->second.needSendToClient)
                            caster->RemoveSpellCooldown(spellInfo->Id, true);
                        else
                            caster->RemoveSpellCooldown(spellInfo->Id, false);
                    }

                    // force removal of the disarm cooldown
                    caster->RemoveSpellCooldown(SPELL_HUNTER_CHIMERA_SHOT_SCORPID, false);
                }
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_hun_readiness_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_hun_readiness_SpellScript();
        }
};

// 37506 - Scatter Shot
class spell_hun_scatter_shot : public SpellScriptLoader
{
    public:
        spell_hun_scatter_shot() : SpellScriptLoader("spell_hun_scatter_shot") { }

        class spell_hun_scatter_shot_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_hun_scatter_shot_SpellScript);

            bool Load()
            {
                return GetCaster()->GetTypeId() == TYPEID_PLAYER;
            }

            void HandleDummy(SpellEffIndex /*effIndex*/)
            {
                Player* caster = GetCaster()->ToPlayer();
                // break Auto Shot and autohit
                caster->InterruptSpell(CURRENT_AUTOREPEAT_SPELL);
                caster->AttackStop();
                caster->SendAttackSwingCancelAttack();
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_hun_scatter_shot_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_hun_scatter_shot_SpellScript();
        }
};

// -53302 - Sniper Training
class spell_hun_sniper_training : public SpellScriptLoader
{
    public:
        spell_hun_sniper_training() : SpellScriptLoader("spell_hun_sniper_training") { }

        class spell_hun_sniper_training_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_hun_sniper_training_AuraScript);

            bool Validate(SpellInfo const* /*spellInfo*/)
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_HUNTER_SNIPER_TRAINING_R1) || !sSpellMgr->GetSpellInfo(SPELL_HUNTER_SNIPER_TRAINING_BUFF_R1))
                    return false;
                return true;
            }

            void HandlePeriodic(AuraEffect const* aurEff)
            {
                PreventDefaultAction();
                if (aurEff->GetAmount() <= 0)
                {
                    Unit* caster = GetCaster();
                    uint32 spellId = SPELL_HUNTER_SNIPER_TRAINING_BUFF_R1 + GetId() - SPELL_HUNTER_SNIPER_TRAINING_R1;
                    if (Unit* target = GetTarget())
                    {
                        SpellInfo const* triggeredSpellInfo = sSpellMgr->GetSpellInfo(spellId);
                        Unit* triggerCaster = triggeredSpellInfo->NeedsToBeTriggeredByCaster(GetSpellInfo()) ? caster : target;
                        triggerCaster->CastSpell(target, triggeredSpellInfo, true, 0, aurEff);
                    }
                }
            }

            void HandleUpdatePeriodic(AuraEffect* aurEff)
            {
                if (Player* playerTarget = GetUnitOwner()->ToPlayer())
                {
                    int32 baseAmount = aurEff->GetBaseAmount();
                    int32 amount = playerTarget->isMoving() || aurEff->GetAmount() <= 0 ?
                    playerTarget->CalculateSpellDamage(playerTarget, GetSpellInfo(), aurEff->GetEffIndex(), &baseAmount) :
                    aurEff->GetAmount() - 1;
                    aurEff->SetAmount(amount);
                }
            }

            void Register()
            {
                OnEffectPeriodic += AuraEffectPeriodicFn(spell_hun_sniper_training_AuraScript::HandlePeriodic, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
                OnEffectUpdatePeriodic += AuraEffectUpdatePeriodicFn(spell_hun_sniper_training_AuraScript::HandleUpdatePeriodic, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_hun_sniper_training_AuraScript();
        }
};

// 55709 - Pet Heart of the Phoenix
class spell_hun_pet_heart_of_the_phoenix : public SpellScriptLoader
{
    public:
        spell_hun_pet_heart_of_the_phoenix() : SpellScriptLoader("spell_hun_pet_heart_of_the_phoenix") { }

        class spell_hun_pet_heart_of_the_phoenix_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_hun_pet_heart_of_the_phoenix_SpellScript);

            bool Load()
            {
                if (!GetCaster()->IsPet())
                    return false;
                return true;
            }

            bool Validate(SpellInfo const* /*spellInfo*/)
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_HUNTER_PET_HEART_OF_THE_PHOENIX_TRIGGERED) || !sSpellMgr->GetSpellInfo(SPELL_HUNTER_PET_HEART_OF_THE_PHOENIX_DEBUFF))
                    return false;
                return true;
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

            void Register()
            {
                OnCheckCast += SpellCheckCastFn(spell_hun_pet_heart_of_the_phoenix_SpellScript::CheckCast);
                OnEffectHitTarget += SpellEffectFn(spell_hun_pet_heart_of_the_phoenix_SpellScript::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_hun_pet_heart_of_the_phoenix_SpellScript();
        }
};

// 54044 - Pet Carrion Feeder
class spell_hun_pet_carrion_feeder : public SpellScriptLoader
{
    public:
        spell_hun_pet_carrion_feeder() : SpellScriptLoader("spell_hun_pet_carrion_feeder") { }

        class spell_hun_pet_carrion_feeder_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_hun_pet_carrion_feeder_SpellScript);

            bool Load()
            {
                if (!GetCaster()->IsPet())
                    return false;
                return true;
            }

            bool Validate(SpellInfo const* /*spellInfo*/)
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_HUNTER_PET_CARRION_FEEDER_TRIGGERED))
                    return false;
                return true;
            }

            SpellCastResult CheckIfCorpseNear()
            {
                Unit* caster = GetCaster();
                float max_range = GetSpellInfo()->GetMaxRange(false);
                WorldObject* result = nullptr;
                // search for nearby enemy corpse in range
                acore::AnyDeadUnitSpellTargetInRangeCheck check(caster, max_range, GetSpellInfo(), TARGET_CHECK_ENEMY);
                acore::WorldObjectSearcher<acore::AnyDeadUnitSpellTargetInRangeCheck> searcher(caster, result, check);
                caster->GetMap()->VisitFirstFound(caster->m_positionX, caster->m_positionY, max_range, searcher);
                if (!result)
                    return SPELL_FAILED_NO_EDIBLE_CORPSES;
                return SPELL_CAST_OK;
            }

            void HandleDummy(SpellEffIndex /*effIndex*/)
            {
                Unit* caster = GetCaster();
                caster->CastSpell(caster, SPELL_HUNTER_PET_CARRION_FEEDER_TRIGGERED, false);
            }

            void Register()
            {
                OnEffectHit += SpellEffectFn(spell_hun_pet_carrion_feeder_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
                OnCheckCast += SpellCheckCastFn(spell_hun_pet_carrion_feeder_SpellScript::CheckIfCorpseNear);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_hun_pet_carrion_feeder_SpellScript();
        }
};

// 34477 - Misdirection
class spell_hun_misdirection : public SpellScriptLoader
{
    public:
        spell_hun_misdirection() : SpellScriptLoader("spell_hun_misdirection") { }

        class spell_hun_misdirection_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_hun_misdirection_AuraScript);

            bool Validate(SpellInfo const* /*spellInfo*/)
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_HUNTER_MISDIRECTION_PROC))
                    return false;
                return true;
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
                GetTarget()->CastSpell(GetTarget(), SPELL_HUNTER_MISDIRECTION_PROC, true, NULL, aurEff);
            }

            void Register()
            {
                AfterEffectRemove += AuraEffectRemoveFn(spell_hun_misdirection_AuraScript::OnRemove, EFFECT_1, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
                DoCheckProc += AuraCheckProcFn(spell_hun_misdirection_AuraScript::CheckProc);
                OnEffectProc += AuraEffectProcFn(spell_hun_misdirection_AuraScript::HandleProc, EFFECT_1, SPELL_AURA_DUMMY);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_hun_misdirection_AuraScript();
        }
};

// 35079 - Misdirection (Proc)
class spell_hun_misdirection_proc : public SpellScriptLoader
{
    public:
        spell_hun_misdirection_proc() : SpellScriptLoader("spell_hun_misdirection_proc") { }

        class spell_hun_misdirection_proc_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_hun_misdirection_proc_AuraScript);

            void OnRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
            {
                GetTarget()->ResetRedirectThreat();
            }

            void Register()
            {
                AfterEffectRemove += AuraEffectRemoveFn(spell_hun_misdirection_proc_AuraScript::OnRemove, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_hun_misdirection_proc_AuraScript();
        }
};

// 781 - Disengage
class spell_hun_disengage : public SpellScriptLoader
{
    public:
        spell_hun_disengage() : SpellScriptLoader("spell_hun_disengage") { }

        class spell_hun_disengage_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_hun_disengage_SpellScript);

            SpellCastResult CheckCast()
            {
                Unit* caster = GetCaster();
                if (caster->GetTypeId() == TYPEID_PLAYER && !caster->IsInCombat())
                    return SPELL_FAILED_CANT_DO_THAT_RIGHT_NOW;

                return SPELL_CAST_OK;
            }

            void Register()
            {
                OnCheckCast += SpellCheckCastFn(spell_hun_disengage_SpellScript::CheckCast);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_hun_disengage_SpellScript();
        }
};

// 1515 - Tame Beast
class spell_hun_tame_beast : public SpellScriptLoader
{
    public:
        spell_hun_tame_beast() : SpellScriptLoader("spell_hun_tame_beast") { }

        class spell_hun_tame_beast_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_hun_tame_beast_SpellScript);

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
                    if (target->getLevel() > player->getLevel())
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
                    
                    if (caster->GetPetGUID() || player->GetTemporaryUnsummonedPetNumber() || player->IsPetDismissed() || player->GetCharmGUID())
                    {
                        player->SendTameFailure(PET_TAME_ANOTHER_SUMMON_ACTIVE);
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

            void Register()
            {
                OnCheckCast += SpellCheckCastFn(spell_hun_tame_beast_SpellScript::CheckCast);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_hun_tame_beast_SpellScript();
        }
};

// 60144 - Viper Attack Speed
class spell_hun_viper_attack_speed : public SpellScriptLoader
{
    public:
        spell_hun_viper_attack_speed() : SpellScriptLoader("spell_hun_viper_attack_speed") { }

        class spell_hun_viper_attack_speed_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_hun_viper_attack_speed_AuraScript);

            bool Validate(SpellInfo const* /*spellInfo*/)
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_HUNTER_ASPECT_OF_THE_VIPER) ||
                    !sSpellMgr->GetSpellInfo(SPELL_HUNTER_VICIOUS_VIPER))
                    return false;
                return true;
            }

            void OnApply(AuraEffect const* aurEff, AuraEffectHandleModes /*mode*/)
            {
                if (GetTarget()->HasAura(SPELL_HUNTER_ASPECT_OF_THE_VIPER))
                    GetTarget()->CastSpell(GetTarget(), SPELL_HUNTER_VICIOUS_VIPER, true, NULL, aurEff);
            }

            void OnRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
            {
                // possible exploit
                GetTarget()->RemoveAurasDueToSpell(SPELL_HUNTER_VICIOUS_VIPER);
            }

            void Register()
            {
                AfterEffectApply += AuraEffectApplyFn(spell_hun_viper_attack_speed_AuraScript::OnApply, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
                AfterEffectRemove += AuraEffectRemoveFn(spell_hun_viper_attack_speed_AuraScript::OnRemove, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_hun_viper_attack_speed_AuraScript();
        }
};

void AddSC_hunter_spell_scripts()
{
    // Ours
    new spell_hun_check_pet_los();
    new spell_hun_cower();
    new spell_hun_wyvern_sting();
    new spell_hun_animal_handler();
    new spell_hun_generic_scaling();
    new spell_hun_taming_the_beast();

    // Theirs
    new spell_hun_aspect_of_the_beast();
    new spell_hun_ascpect_of_the_viper();
    new spell_hun_chimera_shot();
    new spell_hun_disengage();
    new spell_hun_improved_mend_pet();
    new spell_hun_invigoration();
    new spell_hun_last_stand_pet();
    new spell_hun_masters_call();
    new spell_hun_misdirection();
    new spell_hun_misdirection_proc();
    new spell_hun_pet_carrion_feeder();
    new spell_hun_pet_heart_of_the_phoenix();
    new spell_hun_readiness();
    new spell_hun_scatter_shot();
    new spell_hun_sniper_training();
    new spell_hun_tame_beast();
    new spell_hun_viper_attack_speed();
}

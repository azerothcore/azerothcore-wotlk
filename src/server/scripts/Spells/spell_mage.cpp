/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

/*
 * Scripts for spells with SPELLFAMILY_MAGE and SPELLFAMILY_GENERIC spells used by mage players.
 * Ordered alphabetically using scriptname.
 * Scriptnames of files in this file should be prefixed with "spell_mage_".
 */

#include "ScriptMgr.h"
#include "SpellScript.h"
#include "SpellAuraEffects.h"
#include "Player.h"
#include "SpellMgr.h"
#include "TemporarySummon.h"
#include "Pet.h"

enum MageSpells
{
    // Ours
    SPELL_MAGE_BURNOUT_TRIGGER                   = 44450,
    SPELL_MAGE_IMPROVED_BLIZZARD_CHILLED         = 12486,

    // Theirs
    SPELL_MAGE_COLD_SNAP                         = 11958,
    SPELL_MAGE_FOCUS_MAGIC_PROC                  = 54648,
    SPELL_MAGE_FROST_WARDING_R1                  = 11189,
    SPELL_MAGE_FROST_WARDING_TRIGGERED           = 57776,
    SPELL_MAGE_INCANTERS_ABSORBTION_R1           = 44394,
    SPELL_MAGE_INCANTERS_ABSORBTION_TRIGGERED    = 44413,
    SPELL_MAGE_IGNITE                            = 12654,
    SPELL_MAGE_MASTER_OF_ELEMENTS_ENERGIZE       = 29077,
    SPELL_MAGE_SQUIRREL_FORM                     = 32813,
    SPELL_MAGE_GIRAFFE_FORM                      = 32816,
    SPELL_MAGE_SERPENT_FORM                      = 32817,
    SPELL_MAGE_DRAGONHAWK_FORM                   = 32818,
    SPELL_MAGE_WORGEN_FORM                       = 32819,
    SPELL_MAGE_SHEEP_FORM                        = 32820,
    SPELL_MAGE_GLYPH_OF_ETERNAL_WATER            = 70937,
    SPELL_MAGE_SUMMON_WATER_ELEMENTAL_PERMANENT  = 70908,
    SPELL_MAGE_SUMMON_WATER_ELEMENTAL_TEMPORARY  = 70907,
    SPELL_MAGE_GLYPH_OF_BLAST_WAVE               = 62126,
};

// Ours
class spell_mage_arcane_blast : public SpellScriptLoader
{
    public:
        spell_mage_arcane_blast() : SpellScriptLoader("spell_mage_arcane_blast") { }

        class spell_mage_arcane_blast_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_mage_arcane_blast_SpellScript);

            bool Load() { _triggerSpellId = 0; return true; }

            void HandleTriggerSpell(SpellEffIndex effIndex)
            {
                _triggerSpellId = GetSpellInfo()->Effects[effIndex].TriggerSpell;
                PreventHitDefaultEffect(effIndex);
            }

            void HandleAfterCast()
            {
                GetCaster()->CastSpell(GetCaster(), _triggerSpellId, TRIGGERED_FULL_MASK);
            }

            void Register()
            {
                OnEffectLaunch += SpellEffectFn(spell_mage_arcane_blast_SpellScript::HandleTriggerSpell, EFFECT_1, SPELL_EFFECT_TRIGGER_SPELL);
                OnEffectLaunchTarget += SpellEffectFn(spell_mage_arcane_blast_SpellScript::HandleTriggerSpell, EFFECT_1, SPELL_EFFECT_TRIGGER_SPELL);
                AfterCast += SpellCastFn(spell_mage_arcane_blast_SpellScript::HandleAfterCast);
            }

            private:
                uint32 _triggerSpellId;
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_mage_arcane_blast_SpellScript();
        }
};

class spell_mage_deep_freeze : public SpellScriptLoader
{
    public:
        spell_mage_deep_freeze() : SpellScriptLoader("spell_mage_deep_freeze") { }

        class spell_mage_deep_freeze_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_mage_deep_freeze_SpellScript)

            void HandleOnHit()
            {
                if (Unit* caster = GetCaster())
                    if (Unit* target = (caster->ToPlayer() ? caster->ToPlayer()->GetSelectedUnit() : nullptr))
                        if (Creature* cTarget = target->ToCreature())
                            if (cTarget->HasMechanicTemplateImmunity(1 << (MECHANIC_STUN - 1)))
                                caster->CastSpell(cTarget, 71757, true);
            }

            void Register()
            {
                OnHit += SpellHitFn(spell_mage_deep_freeze_SpellScript::HandleOnHit);
            }
        };

        SpellScript * GetSpellScript() const
        {
            return new spell_mage_deep_freeze_SpellScript();
        }
};

class spell_mage_burning_determination : public SpellScriptLoader
{
    public:
        spell_mage_burning_determination() : SpellScriptLoader("spell_mage_burning_determination") { }

        class spell_mage_burning_determination_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_mage_burning_determination_AuraScript);

            bool CheckProc(ProcEventInfo& eventInfo)
            {
                if (!eventInfo.GetDamageInfo()->GetSpellInfo() || !eventInfo.GetActionTarget())
                    return false;

                // Need Interrupt or Silenced mechanic
                if (!(eventInfo.GetDamageInfo()->GetSpellInfo()->GetAllEffectsMechanicMask() & ((1<<MECHANIC_INTERRUPT)|(1<<MECHANIC_SILENCE))))
                    return false;

                // Xinef: immuned effect should just eat charge
                if (eventInfo.GetHitMask() & PROC_EX_IMMUNE)
                {
                    eventInfo.GetActionTarget()->RemoveAurasDueToSpell(54748);
                    return false;
                }
                if (Aura* aura = eventInfo.GetActionTarget()->GetAura(54748))
                {
                    if (aura->GetDuration() < aura->GetMaxDuration())
                        eventInfo.GetActionTarget()->RemoveAurasDueToSpell(54748);
                    return false;
                }

                return true;
            }

            void HandleProc(AuraEffect const*  /*aurEff*/, ProcEventInfo&  /*eventInfo*/)
            {
                PreventDefaultAction();
                GetUnitOwner()->CastSpell(GetUnitOwner(), 54748, true);
            }

            void Register()
            {
                DoCheckProc += AuraCheckProcFn(spell_mage_burning_determination_AuraScript::CheckProc);
                OnEffectProc += AuraEffectProcFn(spell_mage_burning_determination_AuraScript::HandleProc, EFFECT_0, SPELL_AURA_PROC_TRIGGER_SPELL);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_mage_burning_determination_AuraScript();
        }
};

class spell_mage_molten_armor : public SpellScriptLoader
{
    public:
        spell_mage_molten_armor() : SpellScriptLoader("spell_mage_molten_armor") { }

        class spell_mage_molten_armor_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_mage_molten_armor_AuraScript);

            bool CheckProc(ProcEventInfo& eventInfo)
            {
                const SpellInfo* spellInfo = eventInfo.GetDamageInfo()->GetSpellInfo();
                if (!spellInfo || (eventInfo.GetTypeMask() & PROC_FLAG_TAKEN_MELEE_AUTO_ATTACK))
                    return true;

                // Xinef: Molten Shields talent
                if (AuraEffect* aurEff = eventInfo.GetActionTarget()->GetAuraEffect(SPELL_AURA_ADD_FLAT_MODIFIER, SPELLFAMILY_MAGE, 16, EFFECT_0))
                    return roll_chance_i(aurEff->GetSpellInfo()->GetRank()*50);

                return false;
            }

            void Register()
            {
                DoCheckProc += AuraCheckProcFn(spell_mage_molten_armor_AuraScript::CheckProc);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_mage_molten_armor_AuraScript();
        }
};

class spell_mage_mirror_image : public SpellScriptLoader
{
public:
    spell_mage_mirror_image() : SpellScriptLoader("spell_mage_mirror_image") { }

    class spell_mage_mirror_image_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_mage_mirror_image_AuraScript)
        
        void HandleEffectApply(AuraEffect const* aurEff, AuraEffectHandleModes /*mode*/)
        {
            GetTarget()->CastSpell((Unit*)NULL, GetSpellInfo()->Effects[aurEff->GetEffIndex()].TriggerSpell, true);
        }

        void CalcPeriodic(AuraEffect const* /*effect*/, bool& isPeriodic, int32&  /*amplitude*/)
        {
            isPeriodic = false;
        }

        void Register()
        {
            OnEffectApply += AuraEffectApplyFn(spell_mage_mirror_image_AuraScript::HandleEffectApply, EFFECT_2, SPELL_AURA_PERIODIC_DUMMY, AURA_EFFECT_HANDLE_REAL);
            DoEffectCalcPeriodic += AuraEffectCalcPeriodicFn(spell_mage_mirror_image_AuraScript::CalcPeriodic, EFFECT_2, SPELL_AURA_PERIODIC_DUMMY);
        }
    };

    AuraScript* GetAuraScript() const
    {
        return new spell_mage_mirror_image_AuraScript();
    }
};

class spell_mage_burnout : public SpellScriptLoader
{
    public:
        spell_mage_burnout() : SpellScriptLoader("spell_mage_burnout") { }

        class spell_mage_burnout_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_mage_burnout_AuraScript);

            bool Validate(SpellInfo const* /*spellInfo*/)
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_MAGE_BURNOUT_TRIGGER))
                    return false;
                return true;
            }

            bool CheckProc(ProcEventInfo& eventInfo)
            {
                return eventInfo.GetDamageInfo()->GetSpellInfo(); // eventInfo.GetSpellInfo()
            }

            void HandleProc(AuraEffect const* aurEff, ProcEventInfo& eventInfo)
            {
                PreventDefaultAction();

                int32 mana = int32(eventInfo.GetDamageInfo()->GetSpellInfo()->CalcPowerCost(GetTarget(), eventInfo.GetDamageInfo()->GetSchoolMask()));
                mana = CalculatePct(mana, aurEff->GetAmount());

                GetTarget()->CastCustomSpell(SPELL_MAGE_BURNOUT_TRIGGER, SPELLVALUE_BASE_POINT0, mana, GetTarget(), true, NULL, aurEff);
            }

            void Register()
            {
                DoCheckProc += AuraCheckProcFn(spell_mage_burnout_AuraScript::CheckProc);
                OnEffectProc += AuraEffectProcFn(spell_mage_burnout_AuraScript::HandleProc, EFFECT_1, SPELL_AURA_DUMMY);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_mage_burnout_AuraScript();
        }
};

class spell_mage_burnout_trigger : public SpellScriptLoader
{
    public:
        spell_mage_burnout_trigger() : SpellScriptLoader("spell_mage_burnout_trigger") { }

        class spell_mage_burnout_trigger_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_mage_burnout_trigger_SpellScript);

            void HandleDummy(SpellEffIndex effIndex)
            {
                PreventHitDefaultEffect(effIndex);
                if (Unit* target = GetHitUnit())
                {
                    int32 newDamage = -(target->ModifyPower(POWER_MANA, -GetEffectValue()));
                    GetSpell()->ExecuteLogEffectTakeTargetPower(effIndex, target, POWER_MANA, newDamage, 0.0f);
                }
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_mage_burnout_trigger_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_POWER_BURN);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_mage_burnout_trigger_SpellScript();
        }
};

class spell_mage_pet_scaling : public SpellScriptLoader
{
    public:
        spell_mage_pet_scaling() : SpellScriptLoader("spell_mage_pet_scaling") { }

        class spell_mage_pet_scaling_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_mage_pet_scaling_AuraScript);

            void CalculateResistanceAmount(AuraEffect const* aurEff, int32 & amount, bool & /*canBeRecalculated*/)
            {
                // xinef: mage pet inherits 40% of resistance from owner and 35% of armor (guessed)
                if (Unit* owner = GetUnitOwner()->GetOwner())
                {
                    SpellSchoolMask schoolMask = SpellSchoolMask(aurEff->GetSpellInfo()->Effects[aurEff->GetEffIndex()].MiscValue);
                    int32 modifier = schoolMask == SPELL_SCHOOL_MASK_NORMAL ? 35 : 40;
                    amount = CalculatePct(std::max<int32>(0, owner->GetResistance(schoolMask)), modifier);
                }
            }

            void CalculateStatAmount(AuraEffect const* aurEff, int32 & amount, bool & /*canBeRecalculated*/)
            {
                // xinef: mage pet inherits 30% of intellect / stamina
                if (Unit* owner = GetUnitOwner()->GetOwner())
                {
                    Stats stat = Stats(aurEff->GetSpellInfo()->Effects[aurEff->GetEffIndex()].MiscValue);
                    amount = CalculatePct(std::max<int32>(0, owner->GetStat(stat)), 30);
                }
            }

            void CalculateAPAmount(AuraEffect const*  /*aurEff*/, int32 &  /*amount*/, bool & /*canBeRecalculated*/)
            {
                // xinef: mage pet inherits 0% AP
            }

            void CalculateSPAmount(AuraEffect const*  /*aurEff*/, int32 & amount, bool & /*canBeRecalculated*/)
            {
                // xinef: mage pet inherits 33% of SP
                if (Unit* owner = GetUnitOwner()->GetOwner())
                {
                    int32 frost = owner->SpellBaseDamageBonusDone(SPELL_SCHOOL_MASK_FROST);
                    amount = CalculatePct(std::max<int32>(0, frost), 33);

                    // xinef: Update appropriate player field
                    if (owner->GetTypeId() == TYPEID_PLAYER)
                        owner->SetUInt32Value(PLAYER_PET_SPELL_POWER, (uint32)amount);
                }
            }

            void HandleEffectApply(AuraEffect const* aurEff, AuraEffectHandleModes /*mode*/)
            {
                if (GetUnitOwner()->IsPet())
                    return;

                GetUnitOwner()->ApplySpellImmune(0, IMMUNITY_STATE, aurEff->GetAuraType(), true, SPELL_BLOCK_TYPE_POSITIVE);
                if (aurEff->GetAuraType() == SPELL_AURA_MOD_ATTACK_POWER)
                    GetUnitOwner()->ApplySpellImmune(0, IMMUNITY_STATE, SPELL_AURA_MOD_ATTACK_POWER_PCT, true, SPELL_BLOCK_TYPE_POSITIVE);
                else if (aurEff->GetAuraType() == SPELL_AURA_MOD_STAT)
                    GetUnitOwner()->ApplySpellImmune(0, IMMUNITY_STATE, SPELL_AURA_MOD_TOTAL_STAT_PERCENTAGE, true, SPELL_BLOCK_TYPE_POSITIVE);
            }

            void CalcPeriodic(AuraEffect const* /*aurEff*/, bool& isPeriodic, int32& amplitude)
            {
                if (!GetUnitOwner()->IsPet())
                    return;

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
                if (m_scriptSpellId != 35657)
                    DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_mage_pet_scaling_AuraScript::CalculateResistanceAmount, EFFECT_ALL, SPELL_AURA_MOD_RESISTANCE);

                if (m_scriptSpellId == 35657 || m_scriptSpellId == 35658)
                    DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_mage_pet_scaling_AuraScript::CalculateStatAmount, EFFECT_ALL, SPELL_AURA_MOD_STAT);

                if (m_scriptSpellId == 35657)
                {
                    DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_mage_pet_scaling_AuraScript::CalculateAPAmount, EFFECT_ALL, SPELL_AURA_MOD_ATTACK_POWER);
                    DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_mage_pet_scaling_AuraScript::CalculateSPAmount, EFFECT_ALL, SPELL_AURA_MOD_DAMAGE_DONE);
                }

                OnEffectApply += AuraEffectApplyFn(spell_mage_pet_scaling_AuraScript::HandleEffectApply, EFFECT_ALL, SPELL_AURA_ANY, AURA_EFFECT_HANDLE_REAL);
                DoEffectCalcPeriodic += AuraEffectCalcPeriodicFn(spell_mage_pet_scaling_AuraScript::CalcPeriodic, EFFECT_ALL, SPELL_AURA_ANY);
                OnEffectPeriodic += AuraEffectPeriodicFn(spell_mage_pet_scaling_AuraScript::HandlePeriodic, EFFECT_ALL, SPELL_AURA_ANY);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_mage_pet_scaling_AuraScript();
        }
};

class spell_mage_brain_freeze : public SpellScriptLoader
{
    public:
        spell_mage_brain_freeze() : SpellScriptLoader("spell_mage_brain_freeze") { }

        class spell_mage_brain_freeze_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_mage_brain_freeze_AuraScript);

            bool CheckProc(ProcEventInfo& eventInfo)
            {
                const SpellInfo* spellInfo = eventInfo.GetDamageInfo()->GetSpellInfo();
                if (!spellInfo)
                    return false;

                // xinef: Improved Blizzard, generic chilled check
                if (spellInfo->SpellFamilyFlags[0] & 0x100000)
                    return spellInfo->Id == SPELL_MAGE_IMPROVED_BLIZZARD_CHILLED;

                return true;
            }

            void Register()
            {
                DoCheckProc += AuraCheckProcFn(spell_mage_brain_freeze_AuraScript::CheckProc);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_mage_brain_freeze_AuraScript();
        }
};

class spell_mage_glyph_of_eternal_water : public SpellScriptLoader
{
    public:
        spell_mage_glyph_of_eternal_water() : SpellScriptLoader("spell_mage_glyph_of_eternal_water") { }

        class spell_mage_glyph_of_eternal_water_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_mage_glyph_of_eternal_water_AuraScript);

            void OnRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
            {
                if (Unit* target = GetTarget())
                    if (Player* player = target->ToPlayer())
                        if (Pet* pet = player->GetPet())
                            if (pet->GetEntry() == NPC_WATER_ELEMENTAL_PERM)
                                pet->Remove(PET_SAVE_NOT_IN_SLOT);
            }

            void Register()
            {
                OnEffectRemove += AuraEffectRemoveFn(spell_mage_glyph_of_eternal_water_AuraScript::OnRemove, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_mage_glyph_of_eternal_water_AuraScript();
        }
};


// Theirs
// Incanter's Absorbtion
class spell_mage_incanters_absorbtion_base_AuraScript : public AuraScript
{
    public:
        bool Validate(SpellInfo const* /*spellInfo*/)
        {
            if (!sSpellMgr->GetSpellInfo(SPELL_MAGE_INCANTERS_ABSORBTION_TRIGGERED))
                return false;
            if (!sSpellMgr->GetSpellInfo(SPELL_MAGE_INCANTERS_ABSORBTION_R1))
                return false;
            return true;
        }

        void Trigger(AuraEffect* aurEff, DamageInfo& /*dmgInfo*/, uint32& absorbAmount)
        {
            Unit* target = GetTarget();

            if (AuraEffect* talentAurEff = target->GetAuraEffectOfRankedSpell(SPELL_MAGE_INCANTERS_ABSORBTION_R1, EFFECT_0))
            {
                int32 bp = CalculatePct(absorbAmount, talentAurEff->GetAmount());
                if (AuraEffect* currentAura = target->GetAuraEffect(SPELL_AURA_MOD_DAMAGE_DONE, SPELLFAMILY_MAGE, 2941, EFFECT_0))
                {
                    bp += int32(currentAura->GetAmount() * (currentAura->GetBase()->GetDuration() / (float)currentAura->GetBase()->GetMaxDuration()));
                    currentAura->ChangeAmount(bp);
                    currentAura->GetBase()->RefreshDuration();
                }
                else
                    target->CastCustomSpell(target, SPELL_MAGE_INCANTERS_ABSORBTION_TRIGGERED, &bp, nullptr, nullptr, true, NULL, aurEff);
            }
        }
};

// -11113 - Blast Wave
class spell_mage_blast_wave : public SpellScriptLoader
{
    public:
        spell_mage_blast_wave() : SpellScriptLoader("spell_mage_blast_wave") { }

        class spell_mage_blast_wave_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_mage_blast_wave_SpellScript);

            bool Validate(SpellInfo const* /*spellInfo*/)
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_MAGE_GLYPH_OF_BLAST_WAVE))
                    return false;
                return true;
            }

            void HandleKnockBack(SpellEffIndex effIndex)
            {
                if (GetCaster()->HasAura(SPELL_MAGE_GLYPH_OF_BLAST_WAVE))
                    PreventHitDefaultEffect(effIndex);
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_mage_blast_wave_SpellScript::HandleKnockBack, EFFECT_2, SPELL_EFFECT_KNOCK_BACK);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_mage_blast_wave_SpellScript();
        }
};

// 11958 - Cold Snap
class spell_mage_cold_snap : public SpellScriptLoader
{
    public:
        spell_mage_cold_snap() : SpellScriptLoader("spell_mage_cold_snap") { }

        class spell_mage_cold_snap_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_mage_cold_snap_SpellScript);

            bool Load()
            {
                return GetCaster()->GetTypeId() == TYPEID_PLAYER;
            }

            void HandleDummy(SpellEffIndex /*effIndex*/)
            {
                Player* caster = GetCaster()->ToPlayer();
                // immediately finishes the cooldown on Frost spells

                PlayerSpellMap const& spellMap = caster->GetSpellMap();
                for (PlayerSpellMap::const_iterator itr = spellMap.begin(); itr != spellMap.end(); ++itr)
                {
                    SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(itr->first);
                    if (spellInfo->SpellFamilyName == SPELLFAMILY_MAGE && (spellInfo->GetSchoolMask() & SPELL_SCHOOL_MASK_FROST) && spellInfo->Id != SPELL_MAGE_COLD_SNAP && spellInfo->GetRecoveryTime() > 0)
                    {
                        SpellCooldowns::iterator citr = caster->GetSpellCooldownMap().find(spellInfo->Id);
                        if (citr != caster->GetSpellCooldownMap().end() && citr->second.needSendToClient)
                            caster->RemoveSpellCooldown(spellInfo->Id, true);
                        else
                            caster->RemoveSpellCooldown(spellInfo->Id, false);
                    }
                }
            }

            void Register()
            {
                OnEffectHit += SpellEffectFn(spell_mage_cold_snap_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_mage_cold_snap_SpellScript();
        }
};

// -543  - Fire Ward
// -6143 - Frost Ward
class spell_mage_fire_frost_ward : public SpellScriptLoader
{
    public:
        spell_mage_fire_frost_ward() : SpellScriptLoader("spell_mage_fire_frost_ward") { }

        class spell_mage_fire_frost_ward_AuraScript : public spell_mage_incanters_absorbtion_base_AuraScript
        {
            PrepareAuraScript(spell_mage_fire_frost_ward_AuraScript);

            bool Validate(SpellInfo const* /*spellInfo*/)
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_MAGE_FROST_WARDING_TRIGGERED))
                    return false;
                if (!sSpellMgr->GetSpellInfo(SPELL_MAGE_FROST_WARDING_R1))
                    return false;
                return true;
            }

            void CalculateAmount(AuraEffect const* /*aurEff*/, int32& amount, bool& canBeRecalculated)
            {
                canBeRecalculated = false;
                if (Unit* caster = GetCaster())
                {
                    // +80.68% from sp bonus
                    float bonus = 0.8068f;

                    bonus *= caster->SpellBaseDamageBonusDone(GetSpellInfo()->GetSchoolMask());
                    bonus *= caster->CalculateLevelPenalty(GetSpellInfo());

                    amount += int32(bonus);
                }
            }

            void Absorb(AuraEffect* aurEff, DamageInfo& dmgInfo, uint32& absorbAmount)
            {
                Unit* target = GetTarget();
                if (AuraEffect* talentAurEff = target->GetAuraEffectOfRankedSpell(SPELL_MAGE_FROST_WARDING_R1, EFFECT_0))
                {
                    int32 chance = talentAurEff->GetSpellInfo()->Effects[EFFECT_1].CalcValue(); // SPELL_EFFECT_DUMMY with NO_TARGET

                    if (roll_chance_i(chance))
                    {
                        int32 bp = dmgInfo.GetDamage();
                        target->CastCustomSpell(target, SPELL_MAGE_FROST_WARDING_TRIGGERED, &bp, nullptr, nullptr, true, NULL, aurEff);
                        absorbAmount = 0;

                        // Xinef: trigger Incanters Absorbtion
                        uint32 damage = dmgInfo.GetDamage();
                        Trigger(aurEff, dmgInfo, damage);

                        // Xinef: hack for chaos bolt
                        if (!dmgInfo.GetSpellInfo() || dmgInfo.GetSpellInfo()->SpellIconID != 3178)
                            dmgInfo.AbsorbDamage(bp);

                        PreventDefaultAction();
                    }
                }
            }

            void Register()
            {
                DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_mage_fire_frost_ward_AuraScript::CalculateAmount, EFFECT_0, SPELL_AURA_SCHOOL_ABSORB);
                OnEffectAbsorb += AuraEffectAbsorbFn(spell_mage_fire_frost_ward_AuraScript::Absorb, EFFECT_0);
                AfterEffectAbsorb += AuraEffectAbsorbFn(spell_mage_fire_frost_ward_AuraScript::Trigger, EFFECT_0);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_mage_fire_frost_ward_AuraScript();
        }
};

// 54646 - Focus Magic
class spell_mage_focus_magic : public SpellScriptLoader
{
    public:
        spell_mage_focus_magic() : SpellScriptLoader("spell_mage_focus_magic") { }

        class spell_mage_focus_magic_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_mage_focus_magic_AuraScript);

            bool Validate(SpellInfo const* /*spellInfo*/)
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_MAGE_FOCUS_MAGIC_PROC))
                    return false;
                return true;
            }

            bool Load()
            {
                _procTarget = nullptr;
                return true;
            }

            bool CheckProc(ProcEventInfo& /*eventInfo*/)
            {
                _procTarget = GetCaster();
                return _procTarget && _procTarget->IsAlive();
            }

            void HandleProc(AuraEffect const* aurEff, ProcEventInfo& /*eventInfo*/)
            {
                PreventDefaultAction();
                GetTarget()->CastSpell(_procTarget, SPELL_MAGE_FOCUS_MAGIC_PROC, true, NULL, aurEff);
            }

            void Register()
            {
                DoCheckProc += AuraCheckProcFn(spell_mage_focus_magic_AuraScript::CheckProc);
                OnEffectProc += AuraEffectProcFn(spell_mage_focus_magic_AuraScript::HandleProc, EFFECT_0, SPELL_AURA_MOD_SPELL_CRIT_CHANCE);
            }

        private:
            Unit* _procTarget;
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_mage_focus_magic_AuraScript();
        }
};

// -11426 - Ice Barrier
class spell_mage_ice_barrier : public SpellScriptLoader
{
    public:
        spell_mage_ice_barrier() : SpellScriptLoader("spell_mage_ice_barrier") { }

        static int32 CalculateSpellAmount(Unit* caster, int32 amount, const SpellInfo* spellInfo, const AuraEffect* aurEff)
        {
            // +80.68% from sp bonus
            float bonus = 0.8068f;

            bonus *= caster->SpellBaseDamageBonusDone(spellInfo->GetSchoolMask());

            // Glyph of Ice Barrier: its weird having a SPELLMOD_ALL_EFFECTS here but its blizzards doing :)
            // Glyph of Ice Barrier is only applied at the spell damage bonus because it was already applied to the base value in CalculateSpellDamage
            bonus = caster->ApplyEffectModifiers(spellInfo, aurEff->GetEffIndex(), bonus);

            bonus *= caster->CalculateLevelPenalty(spellInfo);

            amount += int32(bonus);
            return amount;
        }

        class spell_mage_ice_barrier_AuraScript : public spell_mage_incanters_absorbtion_base_AuraScript
        {
            PrepareAuraScript(spell_mage_ice_barrier_AuraScript);

            void CalculateAmount(AuraEffect const* aurEff, int32& amount, bool& canBeRecalculated)
            {
                canBeRecalculated = false;
                if (Unit* caster = GetCaster())
                    amount = CalculateSpellAmount(caster, amount, GetSpellInfo(), aurEff);
            }

            void Register()
            {
                DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_mage_ice_barrier_AuraScript::CalculateAmount, EFFECT_0, SPELL_AURA_SCHOOL_ABSORB);
                AfterEffectAbsorb += AuraEffectAbsorbFn(spell_mage_ice_barrier_AuraScript::Trigger, EFFECT_0);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_mage_ice_barrier_AuraScript();
        }

        class spell_mage_ice_barrier_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_mage_ice_barrier_SpellScript);

            SpellCastResult CheckCast()
            {
                Unit* caster = GetCaster();

                if (AuraEffect* aurEff = caster->GetAuraEffect(SPELL_AURA_SCHOOL_ABSORB, (SpellFamilyNames)GetSpellInfo()->SpellFamilyName, GetSpellInfo()->SpellIconID, EFFECT_0))
                {
                    int32 newAmount = GetSpellInfo()->Effects[EFFECT_0].CalcValue(caster, NULL, nullptr);
                    newAmount = CalculateSpellAmount(caster, newAmount, GetSpellInfo(), aurEff);

                    if (aurEff->GetAmount() > newAmount)
                        return SPELL_FAILED_AURA_BOUNCED;
                }

                return SPELL_CAST_OK;
            }

            void Register()
            {
                OnCheckCast += SpellCheckCastFn(spell_mage_ice_barrier_SpellScript::CheckCast);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_mage_ice_barrier_SpellScript;
        }
};

// -11119 - Ignite
class spell_mage_ignite : public SpellScriptLoader
{
    public:
        spell_mage_ignite() : SpellScriptLoader("spell_mage_ignite") { }

        class spell_mage_ignite_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_mage_ignite_AuraScript);

            bool Validate(SpellInfo const* /*spellInfo*/)
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_MAGE_IGNITE))
                    return false;
                return true;
            }

            bool CheckProc(ProcEventInfo& eventInfo)
            {
                if (!eventInfo.GetActor() || !eventInfo.GetProcTarget())
                    return false;

                // Molten Armor
                if (SpellInfo const* spellInfo = eventInfo.GetDamageInfo()->GetSpellInfo())
                    if (spellInfo->SpellFamilyFlags[1] & 0x8)
                        return false;

                return true;
            }

            void HandleProc(AuraEffect const*  /*aurEff*/, ProcEventInfo& eventInfo)
            {
                PreventDefaultAction();

                SpellInfo const* igniteDot = sSpellMgr->GetSpellInfo(SPELL_MAGE_IGNITE);
                int32 pct = 8 * GetSpellInfo()->GetRank();

                int32 amount = int32(CalculatePct(eventInfo.GetDamageInfo()->GetDamage(), pct) / igniteDot->GetMaxTicks());

                // Xinef: implement ignite bug
                eventInfo.GetProcTarget()->CastDelayedSpellWithPeriodicAmount(eventInfo.GetActor(), SPELL_MAGE_IGNITE, SPELL_AURA_PERIODIC_DAMAGE, amount);
                //GetTarget()->CastCustomSpell(SPELL_MAGE_IGNITE, SPELLVALUE_BASE_POINT0, amount, eventInfo.GetProcTarget(), true, NULL, aurEff);
            }

            void Register()
            {
                DoCheckProc += AuraCheckProcFn(spell_mage_ignite_AuraScript::CheckProc);
                OnEffectProc += AuraEffectProcFn(spell_mage_ignite_AuraScript::HandleProc, EFFECT_0, SPELL_AURA_DUMMY);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_mage_ignite_AuraScript();
        }
};

// -44457 - Living Bomb
class spell_mage_living_bomb : public SpellScriptLoader
{
    public:
        spell_mage_living_bomb() : SpellScriptLoader("spell_mage_living_bomb") { }

        class spell_mage_living_bomb_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_mage_living_bomb_AuraScript);

            bool Validate(SpellInfo const* spell)
            {
                if (!sSpellMgr->GetSpellInfo(uint32(spell->Effects[EFFECT_1].CalcValue())))
                    return false;
                return true;
            }

            void AfterRemove(AuraEffect const* aurEff, AuraEffectHandleModes /*mode*/)
            {
                AuraRemoveMode removeMode = GetTargetApplication()->GetRemoveMode();
                if (removeMode != AURA_REMOVE_BY_ENEMY_SPELL && removeMode != AURA_REMOVE_BY_EXPIRE)
                    return;

                if (Unit* caster = GetCaster())
                    caster->CastSpell(GetTarget(), uint32(aurEff->GetAmount()), true, NULL, aurEff);
            }

            void Register()
            {
                AfterEffectRemove += AuraEffectRemoveFn(spell_mage_living_bomb_AuraScript::AfterRemove, EFFECT_1, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_mage_living_bomb_AuraScript();
        }
};

// -1463 - Mana Shield
class spell_mage_mana_shield : public SpellScriptLoader
{
    public:
        spell_mage_mana_shield() : SpellScriptLoader("spell_mage_mana_shield") { }

        class spell_mage_mana_shield_AuraScript : public spell_mage_incanters_absorbtion_base_AuraScript
        {
            PrepareAuraScript(spell_mage_mana_shield_AuraScript);

            void CalculateAmount(AuraEffect const* /*aurEff*/, int32& amount, bool& canBeRecalculated)
            {
                canBeRecalculated = false;
                if (Unit* caster = GetCaster())
                {
                    // +80.53% from sp bonus
                    float bonus = 0.8053f;

                    bonus *= caster->SpellBaseDamageBonusDone(GetSpellInfo()->GetSchoolMask());
                    bonus *= caster->CalculateLevelPenalty(GetSpellInfo());

                    amount += int32(bonus);
                }
            }

            void Register()
            {
                DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_mage_mana_shield_AuraScript::CalculateAmount, EFFECT_0, SPELL_AURA_MANA_SHIELD);
                AfterEffectManaShield += AuraEffectManaShieldFn(spell_mage_mana_shield_AuraScript::Trigger, EFFECT_0);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_mage_mana_shield_AuraScript();
        }
};

// -29074 - Master of Elements
class spell_mage_master_of_elements : public SpellScriptLoader
{
    public:
        spell_mage_master_of_elements() : SpellScriptLoader("spell_mage_master_of_elements") { }

        class spell_mage_master_of_elements_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_mage_master_of_elements_AuraScript);

            bool Validate(SpellInfo const* /*spellInfo*/)
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_MAGE_MASTER_OF_ELEMENTS_ENERGIZE))
                    return false;
                return true;
            }

            bool CheckProc(ProcEventInfo& eventInfo)
            {
                return eventInfo.GetDamageInfo()->GetSpellInfo(); // eventInfo.GetSpellInfo()
            }

            void HandleProc(AuraEffect const* aurEff, ProcEventInfo& eventInfo)
            {
                PreventDefaultAction();

                int32 mana = int32(eventInfo.GetDamageInfo()->GetSpellInfo()->CalcPowerCost(GetTarget(), eventInfo.GetDamageInfo()->GetSchoolMask()));
                mana = CalculatePct(mana, aurEff->GetAmount());

                if (mana > 0)
                    GetTarget()->CastCustomSpell(SPELL_MAGE_MASTER_OF_ELEMENTS_ENERGIZE, SPELLVALUE_BASE_POINT0, mana, GetTarget(), true, NULL, aurEff);
            }

            void Register()
            {
                DoCheckProc += AuraCheckProcFn(spell_mage_master_of_elements_AuraScript::CheckProc);
                OnEffectProc += AuraEffectProcFn(spell_mage_master_of_elements_AuraScript::HandleProc, EFFECT_0, SPELL_AURA_DUMMY);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_mage_master_of_elements_AuraScript();
        }
};

enum SilvermoonPolymorph
{
    NPC_AUROSALIA   = 18744,
};

/// @todo move out of here and rename - not a mage spell
// 32826 - Polymorph (Visual)
class spell_mage_polymorph_cast_visual : public SpellScriptLoader
{
    public:
        spell_mage_polymorph_cast_visual() : SpellScriptLoader("spell_mage_polymorph_visual") { }

        class spell_mage_polymorph_cast_visual_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_mage_polymorph_cast_visual_SpellScript);

            static const uint32 PolymorhForms[6];

            bool Validate(SpellInfo const* /*spellInfo*/)
            {
                // check if spell ids exist in dbc
                for (uint32 i = 0; i < 6; ++i)
                    if (!sSpellMgr->GetSpellInfo(PolymorhForms[i]))
                        return false;
                return true;
            }

            void HandleDummy(SpellEffIndex /*effIndex*/)
            {
                if (Unit* target = GetCaster()->FindNearestCreature(NPC_AUROSALIA, 30.0f))
                    if (target->GetTypeId() == TYPEID_UNIT)
                        target->CastSpell(target, PolymorhForms[urand(0, 5)], true);
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_mage_polymorph_cast_visual_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_mage_polymorph_cast_visual_SpellScript();
        }
};

const uint32 spell_mage_polymorph_cast_visual::spell_mage_polymorph_cast_visual_SpellScript::PolymorhForms[6] =
{
    SPELL_MAGE_SQUIRREL_FORM,
    SPELL_MAGE_GIRAFFE_FORM,
    SPELL_MAGE_SERPENT_FORM,
    SPELL_MAGE_DRAGONHAWK_FORM,
    SPELL_MAGE_WORGEN_FORM,
    SPELL_MAGE_SHEEP_FORM
};

// 31687 - Summon Water Elemental
class spell_mage_summon_water_elemental : public SpellScriptLoader
{
    public:
        spell_mage_summon_water_elemental() : SpellScriptLoader("spell_mage_summon_water_elemental") { }

        class spell_mage_summon_water_elemental_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_mage_summon_water_elemental_SpellScript)
            bool Validate(SpellInfo const* /*spellEntry*/)
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_MAGE_GLYPH_OF_ETERNAL_WATER))
                    return false;
                if (!sSpellMgr->GetSpellInfo(SPELL_MAGE_SUMMON_WATER_ELEMENTAL_TEMPORARY))
                    return false;
                if (!sSpellMgr->GetSpellInfo(SPELL_MAGE_SUMMON_WATER_ELEMENTAL_PERMANENT))
                    return false;
                return true;
            }

            void HandleDummy(SpellEffIndex /*effIndex*/)
            {
                Unit* caster = GetCaster();

                if (Creature *pet = ObjectAccessor::GetCreature(*caster, caster->GetPetGUID()))
                    if (!pet->IsAlive())
                        pet->ToTempSummon()->UnSummon();

                // Glyph of Eternal Water
                if (caster->HasAura(SPELL_MAGE_GLYPH_OF_ETERNAL_WATER))
                    caster->CastSpell(caster, SPELL_MAGE_SUMMON_WATER_ELEMENTAL_PERMANENT, true);
                else
                    caster->CastSpell(caster, SPELL_MAGE_SUMMON_WATER_ELEMENTAL_TEMPORARY, true);


                if (Creature *pet = ObjectAccessor::GetCreature(*caster, caster->GetPetGUID()))
                    if (pet->GetCharmInfo() && caster->ToPlayer())
                    {
                        pet->m_CreatureSpellCooldowns.clear();
                        const SpellInfo* spellEntry = sSpellMgr->GetSpellInfo(31707);
                        pet->GetCharmInfo()->ToggleCreatureAutocast(spellEntry, true);
                        pet->GetCharmInfo()->SetSpellAutocast(spellEntry, true);
                        caster->ToPlayer()->CharmSpellInitialize();
                    }
            }

            void Register()
            {
                OnEffectHit += SpellEffectFn(spell_mage_summon_water_elemental_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_mage_summon_water_elemental_SpellScript();
        }
};

void AddSC_mage_spell_scripts()
{
    // Ours
    new spell_mage_arcane_blast();
    new spell_mage_deep_freeze();
    new spell_mage_burning_determination();
    new spell_mage_molten_armor();
    new spell_mage_mirror_image();
    new spell_mage_burnout();
    new spell_mage_burnout_trigger();
    new spell_mage_pet_scaling();
    new spell_mage_brain_freeze();
    new spell_mage_glyph_of_eternal_water();

    // Theirs
    new spell_mage_blast_wave();
    new spell_mage_cold_snap();
    new spell_mage_fire_frost_ward();
    new spell_mage_focus_magic();
    new spell_mage_ice_barrier();
    new spell_mage_ignite();
    new spell_mage_living_bomb();
    new spell_mage_mana_shield();
    new spell_mage_master_of_elements();
    new spell_mage_polymorph_cast_visual();
    new spell_mage_summon_water_elemental();
}

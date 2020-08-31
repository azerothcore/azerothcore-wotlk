/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

/*
 * Scripts for spells with SPELLFAMILY_SHAMAN and SPELLFAMILY_GENERIC spells used by shaman players.
 * Ordered alphabetically using scriptname.
 * Scriptnames of files in this file should be prefixed with "spell_sha_".
 */

#include "ScriptMgr.h"
#include "GridNotifiers.h"
#include "Unit.h"
#include "SpellScript.h"
#include "SpellAuraEffects.h"
#include "TemporarySummon.h"

enum ShamanSpells
{
    // Ours
    SPELL_SHAMAN_GLYPH_OF_FERAL_SPIRIT          = 63271,

    // Theirs
    SPELL_SHAMAN_ANCESTRAL_AWAKENING_PROC       = 52752,
    SPELL_SHAMAN_BIND_SIGHT                     = 6277,
    SPELL_SHAMAN_CLEANSING_TOTEM_EFFECT         = 52025,
    SPELL_SHAMAN_EARTH_SHIELD_HEAL              = 379,
    SPELL_SHAMAN_ELEMENTAL_MASTERY              = 16166,
    SPELL_SHAMAN_EXHAUSTION                     = 57723,
    SPELL_SHAMAN_FIRE_NOVA_R1                   = 1535,
    SPELL_SHAMAN_FIRE_NOVA_TRIGGERED_R1         = 8349,
    SPELL_SHAMAN_GLYPH_OF_EARTH_SHIELD          = 63279,
    SPELL_SHAMAN_GLYPH_OF_HEALING_STREAM_TOTEM  = 55456,
    SPELL_SHAMAN_GLYPH_OF_MANA_TIDE             = 55441,
    SPELL_SHAMAN_GLYPH_OF_THUNDERSTORM          = 62132,
    SPELL_SHAMAN_ITEM_LIGHTNING_SHIELD          = 23552,
    SPELL_SHAMAN_ITEM_LIGHTNING_SHIELD_DAMAGE   = 27635,
    SPELL_SHAMAN_ITEM_MANA_SURGE                = 23571,
    SPELL_SHAMAN_LAVA_FLOWS_R1                  = 51480,
    SPELL_SHAMAN_LAVA_FLOWS_TRIGGERED_R1        = 64694,
    SPELL_SHAMAN_MANA_SPRING_TOTEM_ENERGIZE     = 52032,
    SPELL_SHAMAN_MANA_TIDE_TOTEM                = 39609,
    SPELL_SHAMAN_SATED                          = 57724,
    SPELL_SHAMAN_STORM_EARTH_AND_FIRE           = 51483,
    SPELL_SHAMAN_TOTEM_EARTHBIND_EARTHGRAB      = 64695,
    SPELL_SHAMAN_TOTEM_EARTHBIND_TOTEM          = 6474,
    SPELL_SHAMAN_TOTEM_EARTHEN_POWER            = 59566,
    SPELL_SHAMAN_TOTEM_HEALING_STREAM_HEAL      = 52042
};

enum ShamanSpellIcons
{
    SHAMAN_ICON_ID_RESTORATIVE_TOTEMS           = 338,
    SHAMAN_ICON_ID_SHAMAN_LAVA_FLOW             = 3087
};

// Ours
class spell_sha_totem_of_wrath : public SpellScriptLoader
{
    public:
        spell_sha_totem_of_wrath() : SpellScriptLoader("spell_sha_totem_of_wrath") { }

        class spell_sha_totem_of_wrath_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_sha_totem_of_wrath_SpellScript);

            void HandleAfterCast()
            {
                if (AuraEffect* aurEff = GetCaster()->GetAuraEffect(63280, EFFECT_0))
                    if (Creature* totem = GetCaster()->GetMap()->GetCreature(GetCaster()->m_SummonSlot[1]))   // Fire totem summon slot
                        if (SpellInfo const* totemSpell = sSpellMgr->GetSpellInfo(totem->m_spells[0]))
                        {
                            int32 bp0 = CalculatePct(totemSpell->Effects[EFFECT_0].CalcValue(), aurEff->GetAmount());
                            int32 bp1 = CalculatePct(totemSpell->Effects[EFFECT_1].CalcValue(), aurEff->GetAmount());
                            GetCaster()->CastCustomSpell(GetCaster(), 63283, &bp0, &bp1, NULL, true);
                        }
            }

            void Register()
            {
                AfterCast += SpellCastFn(spell_sha_totem_of_wrath_SpellScript::HandleAfterCast);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_sha_totem_of_wrath_SpellScript();
        }
};

class spell_sha_spirit_walk : public SpellScriptLoader
{
    public:
        spell_sha_spirit_walk() : SpellScriptLoader("spell_sha_spirit_walk") { }

        class spell_sha_spirit_walk_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_sha_spirit_walk_SpellScript);

            SpellCastResult CheckCast()
            {
               if (Unit* owner = GetCaster()->GetOwner())
                   if (GetCaster()->IsWithinDist(owner, GetSpellInfo()->GetMaxRange(GetSpellInfo()->IsPositive())))
                       return SPELL_CAST_OK;

                return SPELL_FAILED_OUT_OF_RANGE;
            }

            void Register()
            {
                OnCheckCast += SpellCheckCastFn(spell_sha_spirit_walk_SpellScript::CheckCast);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_sha_spirit_walk_SpellScript();
        }
};

class spell_sha_t10_restoration_4p_bonus : public SpellScriptLoader
{
    public:
        spell_sha_t10_restoration_4p_bonus() : SpellScriptLoader("spell_sha_t10_restoration_4p_bonus") { }

        class spell_sha_t10_restoration_4p_bonus_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_sha_t10_restoration_4p_bonus_AuraScript);

            bool CheckProc(ProcEventInfo& eventInfo)
            {
                return eventInfo.GetActor() && eventInfo.GetProcTarget();
            }

            void HandleProc(AuraEffect const* aurEff, ProcEventInfo& eventInfo)
            {
                PreventDefaultAction();

                uint32 triggered_spell_id = 70809;
                SpellInfo const* triggeredSpell = sSpellMgr->GetSpellInfo(triggered_spell_id);
                int32 amount = CalculatePct(eventInfo.GetDamageInfo()->GetDamage(), aurEff->GetAmount()) / triggeredSpell->GetMaxTicks();
                eventInfo.GetProcTarget()->CastDelayedSpellWithPeriodicAmount(GetTarget(), triggered_spell_id, SPELL_AURA_PERIODIC_HEAL, amount, EFFECT_0);
            }

            void Register()
            {
                DoCheckProc += AuraCheckProcFn(spell_sha_t10_restoration_4p_bonus_AuraScript::CheckProc);
                OnEffectProc += AuraEffectProcFn(spell_sha_t10_restoration_4p_bonus_AuraScript::HandleProc, EFFECT_0, SPELL_AURA_DUMMY);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_sha_t10_restoration_4p_bonus_AuraScript();
        }
};

class spell_sha_totemic_mastery : public SpellScriptLoader
{
    public:
        spell_sha_totemic_mastery() : SpellScriptLoader("spell_sha_totemic_mastery") { }

        class spell_sha_totemic_mastery_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_sha_totemic_mastery_AuraScript);

            void HandlePeriodic(AuraEffect const*  /*aurEff*/)
            {
                PreventDefaultAction();

                for (uint8 i = SUMMON_SLOT_TOTEM; i < MAX_TOTEM_SLOT; ++i)
                    if (!GetTarget()->m_SummonSlot[i])
                        return;

                GetTarget()->CastSpell(GetTarget(), 38437, true);
            }

            void Register()
            {
                OnEffectPeriodic += AuraEffectPeriodicFn(spell_sha_totemic_mastery_AuraScript::HandlePeriodic, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_sha_totemic_mastery_AuraScript();
        }
};

class spell_sha_feral_spirit_scaling : public SpellScriptLoader
{
    public:
        spell_sha_feral_spirit_scaling() : SpellScriptLoader("spell_sha_feral_spirit_scaling") { }

        class spell_sha_feral_spirit_scaling_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_sha_feral_spirit_scaling_AuraScript);

            void CalculateResistanceAmount(AuraEffect const* aurEff, int32 & amount, bool & /*canBeRecalculated*/)
            {
                // xinef: feral spirit inherits 40% of resistance from owner and 35% of armor
                if (Unit* owner = GetUnitOwner()->GetOwner())
                {
                    SpellSchoolMask schoolMask = SpellSchoolMask(aurEff->GetSpellInfo()->Effects[aurEff->GetEffIndex()].MiscValue);
                    int32 modifier = schoolMask == SPELL_SCHOOL_MASK_NORMAL ? 35 : 40;
                    amount = CalculatePct(std::max<int32>(0, owner->GetResistance(schoolMask)), modifier);
                }
            }

            void CalculateStatAmount(AuraEffect const* aurEff, int32 & amount, bool & /*canBeRecalculated*/)
            {
                // xinef: by default feral spirit inherits 30% of stamina
                if (Unit* owner = GetUnitOwner()->GetOwner())
                {
                    Stats stat = Stats(aurEff->GetSpellInfo()->Effects[aurEff->GetEffIndex()].MiscValue);
                    amount = CalculatePct(std::max<int32>(0, owner->GetStat(stat)), 30);
                }
            }

            void CalculateAPAmount(AuraEffect const*  /*aurEff*/, int32 & amount, bool & /*canBeRecalculated*/)
            {
                // xinef: by default feral spirit inherits 30% of AP
                if (Unit* owner = GetUnitOwner()->GetOwner())
                {
                    int32 modifier = 30;
                    if (AuraEffect const* gofsEff = owner->GetAuraEffect(SPELL_SHAMAN_GLYPH_OF_FERAL_SPIRIT, EFFECT_0))
                        modifier += gofsEff->GetAmount();

                    amount = CalculatePct(std::max<int32>(0, owner->GetTotalAttackPowerValue(BASE_ATTACK)), modifier);
                }
            }

            void CalculateSPAmount(AuraEffect const*  /*aurEff*/, int32 & amount, bool & /*canBeRecalculated*/)
            {
                // xinef: by default feral spirit inherits 30% of AP as SP
                if (Unit* owner = GetUnitOwner()->GetOwner())
                {
                    int32 modifier = 30;
                    if (AuraEffect const* gofsEff = owner->GetAuraEffect(SPELL_SHAMAN_GLYPH_OF_FERAL_SPIRIT, EFFECT_0))
                        modifier += gofsEff->GetAmount();

                    amount = CalculatePct(std::max<int32>(0, owner->GetTotalAttackPowerValue(BASE_ATTACK)), modifier);

                    // xinef: Update appropriate player field
                    if (owner->GetTypeId() == TYPEID_PLAYER)
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

            void CalcPeriodic(AuraEffect const* /*aurEff*/, bool& isPeriodic, int32& amplitude)
            {
                isPeriodic = true;
                amplitude = 1*IN_MILLISECONDS;
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
                if (m_scriptSpellId == 35675)
                    DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_sha_feral_spirit_scaling_AuraScript::CalculateResistanceAmount, EFFECT_ALL, SPELL_AURA_MOD_RESISTANCE);

                if (m_scriptSpellId == 35674)
                {
                    DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_sha_feral_spirit_scaling_AuraScript::CalculateStatAmount, EFFECT_ALL, SPELL_AURA_MOD_STAT);
                    DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_sha_feral_spirit_scaling_AuraScript::CalculateAPAmount, EFFECT_ALL, SPELL_AURA_MOD_ATTACK_POWER);
                    DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_sha_feral_spirit_scaling_AuraScript::CalculateSPAmount, EFFECT_ALL, SPELL_AURA_MOD_DAMAGE_DONE);
                }

                OnEffectApply += AuraEffectApplyFn(spell_sha_feral_spirit_scaling_AuraScript::HandleEffectApply, EFFECT_ALL, SPELL_AURA_ANY, AURA_EFFECT_HANDLE_REAL);
                DoEffectCalcPeriodic += AuraEffectCalcPeriodicFn(spell_sha_feral_spirit_scaling_AuraScript::CalcPeriodic, EFFECT_ALL, SPELL_AURA_ANY);
                OnEffectPeriodic += AuraEffectPeriodicFn(spell_sha_feral_spirit_scaling_AuraScript::HandlePeriodic, EFFECT_ALL, SPELL_AURA_ANY);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_sha_feral_spirit_scaling_AuraScript();
        }
};

class spell_sha_fire_elemental_scaling : public SpellScriptLoader
{
    public:
        spell_sha_fire_elemental_scaling() : SpellScriptLoader("spell_sha_fire_elemental_scaling") { }

        class spell_sha_fire_elemental_scaling_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_sha_fire_elemental_scaling_AuraScript);

            void CalculateResistanceAmount(AuraEffect const* aurEff, int32 & amount, bool & /*canBeRecalculated*/)
            {
                // xinef: fire elemental inherits 40% of resistance from owner and 35% of armor
                if (Unit* owner = GetUnitOwner()->GetOwner())
                {
                    SpellSchoolMask schoolMask = SpellSchoolMask(aurEff->GetSpellInfo()->Effects[aurEff->GetEffIndex()].MiscValue);
                    int32 modifier = schoolMask == SPELL_SCHOOL_MASK_NORMAL ? 35 : 40;
                    amount = CalculatePct(std::max<int32>(0, owner->GetResistance(schoolMask)), modifier);
                }
            }

            void CalculateStatAmount(AuraEffect const* aurEff, int32 & amount, bool & /*canBeRecalculated*/)
            {
                // xinef: fire elemental inherits 30% of intellect / stamina
                if (Unit* owner = GetUnitOwner()->GetOwner())
                {
                    Stats stat = Stats(aurEff->GetSpellInfo()->Effects[aurEff->GetEffIndex()].MiscValue);
                    amount = CalculatePct(std::max<int32>(0, owner->GetStat(stat)), 30);
                }
            }

            void CalculateAPAmount(AuraEffect const*  /*aurEff*/, int32 & amount, bool & /*canBeRecalculated*/)
            {
                // xinef: fire elemental inherits 300% / 150% of SP as AP
                if (Unit* owner = GetUnitOwner()->GetOwner())
                {
                    int32 fire = owner->SpellBaseDamageBonusDone(SPELL_SCHOOL_MASK_FIRE);
                    amount = CalculatePct(std::max<int32>(0, fire), (GetUnitOwner()->GetEntry() == NPC_FIRE_ELEMENTAL ? 300 : 150));
                }
            }

            void CalculateSPAmount(AuraEffect const*  /*aurEff*/, int32 & amount, bool & /*canBeRecalculated*/)
            {
                // xinef: fire elemental inherits 100% of SP
                if (Unit* owner = GetUnitOwner()->GetOwner())
                {
                    int32 fire = owner->SpellBaseDamageBonusDone(SPELL_SCHOOL_MASK_FIRE);
                    amount = CalculatePct(std::max<int32>(0, fire), 100);

                    // xinef: Update appropriate player field
                    if (owner->GetTypeId() == TYPEID_PLAYER)
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

            void Register()
            {
                if (m_scriptSpellId != 35665 && m_scriptSpellId != 65225)
                    DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_sha_fire_elemental_scaling_AuraScript::CalculateResistanceAmount, EFFECT_ALL, SPELL_AURA_MOD_RESISTANCE);

                if (m_scriptSpellId == 35666 || m_scriptSpellId == 65226)
                    DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_sha_fire_elemental_scaling_AuraScript::CalculateStatAmount, EFFECT_ALL, SPELL_AURA_MOD_STAT);

                if (m_scriptSpellId == 35665 || m_scriptSpellId == 65225)
                {
                    DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_sha_fire_elemental_scaling_AuraScript::CalculateAPAmount, EFFECT_ALL, SPELL_AURA_MOD_ATTACK_POWER);
                    DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_sha_fire_elemental_scaling_AuraScript::CalculateSPAmount, EFFECT_ALL, SPELL_AURA_MOD_DAMAGE_DONE);
                }

                OnEffectApply += AuraEffectApplyFn(spell_sha_fire_elemental_scaling_AuraScript::HandleEffectApply, EFFECT_ALL, SPELL_AURA_ANY, AURA_EFFECT_HANDLE_REAL);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_sha_fire_elemental_scaling_AuraScript();
        }
};


// Theirs
// 52759 - Ancestral Awakening (Proc)
class spell_sha_ancestral_awakening_proc : public SpellScriptLoader
{
    public:
        spell_sha_ancestral_awakening_proc() : SpellScriptLoader("spell_sha_ancestral_awakening_proc") { }

        class spell_sha_ancestral_awakening_proc_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_sha_ancestral_awakening_proc_SpellScript);

            bool Validate(SpellInfo const* /*spellInfo*/)
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_SHAMAN_ANCESTRAL_AWAKENING_PROC))
                    return false;
                return true;
            }

            void FilterTargets(std::list<WorldObject*>& targets)
            {
                if (targets.size() < 2)
                    return;

                targets.sort(acore::HealthPctOrderPred());

                WorldObject* target = targets.front();
                targets.clear();
                targets.push_back(target);
            }

            void HandleDummy(SpellEffIndex /*effIndex*/)
            {
                int32 damage = GetEffectValue();
                if (GetHitUnit())
                    GetCaster()->CastCustomSpell(GetHitUnit(), SPELL_SHAMAN_ANCESTRAL_AWAKENING_PROC, &damage, nullptr, nullptr, true);
            }

            void Register()
            {
                OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_sha_ancestral_awakening_proc_SpellScript::FilterTargets, EFFECT_0, TARGET_UNIT_CASTER_AREA_RAID);
                OnEffectHitTarget += SpellEffectFn(spell_sha_ancestral_awakening_proc_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_sha_ancestral_awakening_proc_SpellScript();
        }
};

// 51474 - Astral Shift
class spell_sha_astral_shift : public SpellScriptLoader
{
    public:
        spell_sha_astral_shift() : SpellScriptLoader("spell_sha_astral_shift") { }

        class spell_sha_astral_shift_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_sha_astral_shift_AuraScript);

            uint32 absorbPct;

            bool Load()
            {
                absorbPct = GetSpellInfo()->Effects[EFFECT_0].CalcValue(GetCaster());
                return true;
            }

            void CalculateAmount(AuraEffect const* /*aurEff*/, int32 & amount, bool & /*canBeRecalculated*/)
            {
                // Set absorbtion amount to unlimited
                amount = -1;
            }

            void Absorb(AuraEffect* /*aurEff*/, DamageInfo & dmgInfo, uint32 & absorbAmount)
            {
                // reduces all damage taken while stun, fear or silence
                if (GetTarget()->GetUInt32Value(UNIT_FIELD_FLAGS) & (UNIT_FLAG_FLEEING | UNIT_FLAG_SILENCED) || (GetTarget()->GetUInt32Value(UNIT_FIELD_FLAGS) & (UNIT_FLAG_STUNNED) && GetTarget()->HasAuraWithMechanic(1<<MECHANIC_STUN)))
                    absorbAmount = CalculatePct(dmgInfo.GetDamage(), absorbPct);
            }

            void Register()
            {
                 DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_sha_astral_shift_AuraScript::CalculateAmount, EFFECT_0, SPELL_AURA_SCHOOL_ABSORB);
                 OnEffectAbsorb += AuraEffectAbsorbFn(spell_sha_astral_shift_AuraScript::Absorb, EFFECT_0);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_sha_astral_shift_AuraScript();
        }
};

// 2825 - Bloodlust
class spell_sha_bloodlust : public SpellScriptLoader
{
    public:
        spell_sha_bloodlust() : SpellScriptLoader("spell_sha_bloodlust") { }

        class spell_sha_bloodlust_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_sha_bloodlust_SpellScript);

            bool Validate(SpellInfo const* /*spellInfo*/)
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_SHAMAN_SATED))
                    return false;
                if (!sSpellMgr->GetSpellInfo(SPELL_SHAMAN_EXHAUSTION))
                    return false;
                return true;
            }

            void RemoveInvalidTargets(std::list<WorldObject*>& targets)
            {
                targets.remove_if(acore::UnitAuraCheck(true, SPELL_SHAMAN_SATED));
                targets.remove_if(acore::UnitAuraCheck(true, SPELL_SHAMAN_EXHAUSTION));
            }

            void ApplyDebuff()
            {
                if (Unit* target = GetHitUnit())
                    target->CastSpell(target, SPELL_SHAMAN_SATED, true);
            }

            void Register()
            {
                OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_sha_bloodlust_SpellScript::RemoveInvalidTargets, EFFECT_ALL, TARGET_UNIT_CASTER_AREA_RAID);
                AfterHit += SpellHitFn(spell_sha_bloodlust_SpellScript::ApplyDebuff);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_sha_bloodlust_SpellScript();
        }
};

// -1064 - Chain Heal
class spell_sha_chain_heal : public SpellScriptLoader
{
    public:
        spell_sha_chain_heal() : SpellScriptLoader("spell_sha_chain_heal") { }

        class spell_sha_chain_heal_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_sha_chain_heal_SpellScript);

            bool Load()
            {
                firstHeal = true;
                riptide = false;
                return true;
            }

            void HandleHeal(SpellEffIndex /*effIndex*/)
            {
                if (firstHeal)
                {
                    // Check if the target has Riptide
                    if (AuraEffect* aurEff = GetHitUnit()->GetAuraEffect(SPELL_AURA_PERIODIC_HEAL, SPELLFAMILY_SHAMAN, 0, 0, 0x10, GetCaster()->GetGUID()))
                    {
                        riptide = true;
                        // Consume it
                        GetHitUnit()->RemoveAura(aurEff->GetBase());
                    }
                    firstHeal = false;
                }
                // Riptide increases the Chain Heal effect by 25%
                if (riptide)
                    SetHitHeal(GetHitHeal() * 1.25f);
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_sha_chain_heal_SpellScript::HandleHeal, EFFECT_0, SPELL_EFFECT_HEAL);
            }

            bool firstHeal;
            bool riptide;
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_sha_chain_heal_SpellScript();
        }
};

// 8171 - Cleansing Totem (Pulse)
class spell_sha_cleansing_totem_pulse : public SpellScriptLoader
{
    public:
        spell_sha_cleansing_totem_pulse() : SpellScriptLoader("spell_sha_cleansing_totem_pulse") { }

        class spell_sha_cleansing_totem_pulse_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_sha_cleansing_totem_pulse_SpellScript);

            bool Validate(SpellInfo const* /*spellInfo*/)
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_SHAMAN_CLEANSING_TOTEM_EFFECT))
                    return false;
                return true;
            }

            void HandleDummy(SpellEffIndex /*effIndex*/)
            {
                int32 bp = 1;
                if (GetCaster() && GetHitUnit() && GetOriginalCaster())
                    GetCaster()->CastCustomSpell(GetHitUnit(), SPELL_SHAMAN_CLEANSING_TOTEM_EFFECT, NULL, &bp, NULL, true, nullptr, nullptr, GetOriginalCaster()->GetGUID());
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_sha_cleansing_totem_pulse_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_sha_cleansing_totem_pulse_SpellScript();
        }
};

// -974 - Earth Shield
class spell_sha_earth_shield : public SpellScriptLoader
{
    public:
        spell_sha_earth_shield() : SpellScriptLoader("spell_sha_earth_shield") { }

        class spell_sha_earth_shield_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_sha_earth_shield_AuraScript);

            bool Validate(SpellInfo const* /*spellInfo*/)
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_SHAMAN_EARTH_SHIELD_HEAL))
                    return false;
                if (!sSpellMgr->GetSpellInfo(SPELL_SHAMAN_GLYPH_OF_EARTH_SHIELD))
                    return false;
                return true;
            }

            void CalculateAmount(AuraEffect const* /*aurEff*/, int32& amount, bool & /*canBeRecalculated*/)
            {
                if (Unit* caster = GetCaster())
                {
                    int32 baseAmount = amount;
                    amount = caster->SpellHealingBonusDone(GetUnitOwner(), GetSpellInfo(), amount, HEAL);
                    // xinef: taken should be calculated at every heal
                    //amount = GetUnitOwner()->SpellHealingBonusTaken(caster, GetSpellInfo(), amount, HEAL);

                    // Glyph of Earth Shield
                    //! WORKAROUND
                    //! this glyphe is a proc
                    if (AuraEffect* glyphe = caster->GetAuraEffect(SPELL_SHAMAN_GLYPH_OF_EARTH_SHIELD, EFFECT_0))
                        AddPct(amount, glyphe->GetAmount());

                    // xinef: Improved Shields
                    if ((baseAmount = amount - baseAmount))
                        if (AuraEffect* aurEff = caster->GetAuraEffect(SPELL_AURA_ADD_PCT_MODIFIER, SPELLFAMILY_SHAMAN, 19, EFFECT_1))
                        {
                            ApplyPct(baseAmount, aurEff->GetAmount());
                            amount += baseAmount;
                        }
                }
            }

            bool CheckProc(ProcEventInfo&  /*eventInfo*/)
            {
                return !GetTarget()->HasSpellCooldown(SPELL_SHAMAN_EARTH_SHIELD_HEAL);
            }

            void HandleProc(AuraEffect const* aurEff, ProcEventInfo&  /*eventInfo*/)
            {
                PreventDefaultAction();
                GetTarget()->CastCustomSpell(SPELL_SHAMAN_EARTH_SHIELD_HEAL, SPELLVALUE_BASE_POINT0, aurEff->GetAmount(), GetTarget(), true, NULL, aurEff, GetCasterGUID());
                GetTarget()->AddSpellCooldown(SPELL_SHAMAN_EARTH_SHIELD_HEAL, 0, 3500);
            }

            void Register()
            {
                DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_sha_earth_shield_AuraScript::CalculateAmount, EFFECT_0, SPELL_AURA_DUMMY);
                DoCheckProc += AuraCheckProcFn(spell_sha_earth_shield_AuraScript::CheckProc);
                OnEffectProc += AuraEffectProcFn(spell_sha_earth_shield_AuraScript::HandleProc, EFFECT_0, SPELL_AURA_DUMMY);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_sha_earth_shield_AuraScript();
        }
};

// 6474 - Earthbind Totem - Fix Talent: Earthen Power
class spell_sha_earthbind_totem : public SpellScriptLoader
{
    public:
        spell_sha_earthbind_totem() : SpellScriptLoader("spell_sha_earthbind_totem") { }

        class spell_sha_earthbind_totem_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_sha_earthbind_totem_AuraScript);

            bool Validate(SpellInfo const* /*spellInfo*/)
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_SHAMAN_TOTEM_EARTHBIND_TOTEM) || !sSpellMgr->GetSpellInfo(SPELL_SHAMAN_TOTEM_EARTHEN_POWER))
                    return false;
                return true;
            }

            void HandleEffectPeriodic(AuraEffect const* /*aurEff*/)
            {
                if (!GetCaster())
                    return;
                if (Player* owner = GetCaster()->GetCharmerOrOwnerPlayerOrPlayerItself())
                    if (AuraEffect* aur = owner->GetDummyAuraEffect(SPELLFAMILY_SHAMAN, 2289, 0))
                        if (roll_chance_i(aur->GetBaseAmount()))
                            GetTarget()->CastSpell((Unit*)NULL, SPELL_SHAMAN_TOTEM_EARTHEN_POWER, true);
            }

            void Apply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
            {
                if (!GetCaster())
                    return;
                Player* owner = GetCaster()->GetCharmerOrOwnerPlayerOrPlayerItself();
                if (!owner)
                    return;
                // Storm, Earth and Fire
                if (AuraEffect* aurEff = owner->GetAuraEffectOfRankedSpell(SPELL_SHAMAN_STORM_EARTH_AND_FIRE, EFFECT_1))
                {
                    if (roll_chance_i(aurEff->GetAmount()))
                        GetCaster()->CastSpell(GetCaster(), SPELL_SHAMAN_TOTEM_EARTHBIND_EARTHGRAB, false);
                }
            }

            void Register()
            {
                 OnEffectPeriodic += AuraEffectPeriodicFn(spell_sha_earthbind_totem_AuraScript::HandleEffectPeriodic, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
                 OnEffectApply += AuraEffectApplyFn(spell_sha_earthbind_totem_AuraScript::Apply, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL, AURA_EFFECT_HANDLE_REAL);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_sha_earthbind_totem_AuraScript();
        }
};

class EarthenPowerTargetSelector
{
    public:
        EarthenPowerTargetSelector() { }

        bool operator() (WorldObject* target)
        {
            if (!target->ToUnit())
                return true;

            if (!target->ToUnit()->HasAuraWithMechanic(1 << MECHANIC_SNARE))
                return true;

            return false;
        }
};

// 59566 - Earthen Power
class spell_sha_earthen_power : public SpellScriptLoader
{
    public:
        spell_sha_earthen_power() : SpellScriptLoader("spell_sha_earthen_power") { }

        class spell_sha_earthen_power_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_sha_earthen_power_SpellScript);

            void FilterTargets(std::list<WorldObject*>& unitList)
            {
                unitList.remove_if(EarthenPowerTargetSelector());
            }

            void Register()
            {
                OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_sha_earthen_power_SpellScript::FilterTargets, EFFECT_0, TARGET_UNIT_SRC_AREA_ALLY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_sha_earthen_power_SpellScript();
        }
};

// -1535 - Fire Nova
class spell_sha_fire_nova : public SpellScriptLoader
{
    public:
        spell_sha_fire_nova() : SpellScriptLoader("spell_sha_fire_nova") { }

        class spell_sha_fire_nova_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_sha_fire_nova_SpellScript);

            bool Validate(SpellInfo const* spellInfo)
            {
                SpellInfo const* firstRankSpellInfo = sSpellMgr->GetSpellInfo(SPELL_SHAMAN_FIRE_NOVA_R1);
                if (!firstRankSpellInfo || !spellInfo->IsRankOf(firstRankSpellInfo))
                    return false;

                uint8 rank = spellInfo->GetRank();
                if (!sSpellMgr->GetSpellWithRank(SPELL_SHAMAN_FIRE_NOVA_TRIGGERED_R1, rank, true))
                    return false;
                return true;
            }

            SpellCastResult CheckFireTotem()
            {
                // fire totem
                Unit* caster = GetCaster();
                if (Creature* totem = caster->GetMap()->GetCreature(caster->m_SummonSlot[1]))
                {
                    if (!caster->IsWithinDistInMap(totem, caster->GetSpellMaxRangeForTarget(totem, GetSpellInfo())))
                        return SPELL_FAILED_OUT_OF_RANGE;
                    return SPELL_CAST_OK;
                }
                else
                {
                    SetCustomCastResultMessage(SPELL_CUSTOM_ERROR_MUST_HAVE_FIRE_TOTEM);
                    return SPELL_FAILED_CUSTOM_ERROR;
                }
            }

            void HandleDummy(SpellEffIndex /*effIndex*/)
            {
                Unit* caster = GetCaster();
                if (Creature* totem = caster->GetMap()->GetCreature(caster->m_SummonSlot[1]))
                {
                    uint8 rank = GetSpellInfo()->GetRank();
                    if (totem->IsTotem())
                        caster->CastSpell(totem, sSpellMgr->GetSpellWithRank(SPELL_SHAMAN_FIRE_NOVA_TRIGGERED_R1, rank), true);
                }
            }

            void Register()
            {
                OnCheckCast += SpellCheckCastFn(spell_sha_fire_nova_SpellScript::CheckFireTotem);
                OnEffectHitTarget += SpellEffectFn(spell_sha_fire_nova_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_sha_fire_nova_SpellScript();
        }
};

// -8050 - Flame Shock
class spell_sha_flame_shock : public SpellScriptLoader
{
    public:
        spell_sha_flame_shock() : SpellScriptLoader("spell_sha_flame_shock") { }

        class spell_sha_flame_shock_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_sha_flame_shock_AuraScript);

            bool Validate(SpellInfo const* /*spell*/)
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_SHAMAN_LAVA_FLOWS_R1))
                    return false;
                if (!sSpellMgr->GetSpellInfo(SPELL_SHAMAN_LAVA_FLOWS_TRIGGERED_R1))
                    return false;
                return true;
            }

            void HandleDispel(DispelInfo* /*dispelInfo*/)
            {
                if (Unit* caster = GetCaster())
                    // Lava Flows
                    if (AuraEffect const* aurEff = caster->GetDummyAuraEffect(SPELLFAMILY_SHAMAN, SHAMAN_ICON_ID_SHAMAN_LAVA_FLOW, EFFECT_0))
                    {
                        if (SpellInfo const* firstRankSpellInfo = sSpellMgr->GetSpellInfo(SPELL_SHAMAN_LAVA_FLOWS_R1))
                            if (!aurEff->GetSpellInfo()->IsRankOf(firstRankSpellInfo))
                                return;

                        uint8 rank = aurEff->GetSpellInfo()->GetRank();
                        caster->CastSpell(caster, sSpellMgr->GetSpellWithRank(SPELL_SHAMAN_LAVA_FLOWS_TRIGGERED_R1, rank), true);
                    }
            }

            void Register()
            {
                AfterDispel += AuraDispelFn(spell_sha_flame_shock_AuraScript::HandleDispel);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_sha_flame_shock_AuraScript();
        }
};

// 52041, 52046, 52047, 52048, 52049, 52050, 58759, 58760, 58761 - Healing Stream Totem
class spell_sha_healing_stream_totem : public SpellScriptLoader
{
    public:
        spell_sha_healing_stream_totem() : SpellScriptLoader("spell_sha_healing_stream_totem") { }

        class spell_sha_healing_stream_totem_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_sha_healing_stream_totem_SpellScript);

            bool Validate(SpellInfo const* /*spellInfo*/)
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_SHAMAN_GLYPH_OF_HEALING_STREAM_TOTEM) || !sSpellMgr->GetSpellInfo(SPELL_SHAMAN_TOTEM_HEALING_STREAM_HEAL))
                    return false;
                return true;
            }

            void HandleDummy(SpellEffIndex /*effIndex*/)
            {
                int32 damage = GetEffectValue();
                SpellInfo const* triggeringSpell = GetTriggeringSpell();
                if (Unit* target = GetHitUnit())
                    if (Unit* caster = GetCaster())
                    {
                        if (Unit* owner = caster->GetOwner())
                        {
                            if (triggeringSpell)
                                damage = int32(owner->SpellHealingBonusDone(target, triggeringSpell, damage, HEAL));

                            // Restorative Totems
                            if (AuraEffect* dummy = owner->GetAuraEffect(SPELL_AURA_DUMMY, SPELLFAMILY_SHAMAN, SHAMAN_ICON_ID_RESTORATIVE_TOTEMS, 1))
                                AddPct(damage, dummy->GetAmount());

                            // Glyph of Healing Stream Totem
                            if (AuraEffect const* aurEff = owner->GetAuraEffect(SPELL_SHAMAN_GLYPH_OF_HEALING_STREAM_TOTEM, EFFECT_0))
                                AddPct(damage, aurEff->GetAmount());

                            damage = int32(target->SpellHealingBonusTaken(owner, triggeringSpell, damage, HEAL));
                        }
                        caster->CastCustomSpell(target, SPELL_SHAMAN_TOTEM_HEALING_STREAM_HEAL, &damage, 0, 0, true, 0, 0, GetOriginalCaster()->GetGUID());
                    }
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_sha_healing_stream_totem_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_sha_healing_stream_totem_SpellScript();
        }
};

// 32182 - Heroism
class spell_sha_heroism : public SpellScriptLoader
{
    public:
        spell_sha_heroism() : SpellScriptLoader("spell_sha_heroism") { }

        class spell_sha_heroism_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_sha_heroism_SpellScript);

            bool Validate(SpellInfo const* /*spellInfo*/)
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_SHAMAN_EXHAUSTION))
                    return false;
                if (!sSpellMgr->GetSpellInfo(SPELL_SHAMAN_SATED))
                    return false;
                return true;
            }

            void RemoveInvalidTargets(std::list<WorldObject*>& targets)
            {
                targets.remove_if(acore::UnitAuraCheck(true, SPELL_SHAMAN_EXHAUSTION));
                targets.remove_if(acore::UnitAuraCheck(true, SPELL_SHAMAN_SATED));
            }

            void ApplyDebuff()
            {
                if (Unit* target = GetHitUnit())
                    target->CastSpell(target, SPELL_SHAMAN_EXHAUSTION, true);
            }

            void Register()
            {
                OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_sha_heroism_SpellScript::RemoveInvalidTargets, EFFECT_0, TARGET_UNIT_CASTER_AREA_RAID);
                OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_sha_heroism_SpellScript::RemoveInvalidTargets, EFFECT_1, TARGET_UNIT_CASTER_AREA_RAID);
                OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_sha_heroism_SpellScript::RemoveInvalidTargets, EFFECT_2, TARGET_UNIT_CASTER_AREA_RAID);
                AfterHit += SpellHitFn(spell_sha_heroism_SpellScript::ApplyDebuff);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_sha_heroism_SpellScript();
        }
};

// 23551 - Lightning Shield
class spell_sha_item_lightning_shield : public SpellScriptLoader
{
    public:
        spell_sha_item_lightning_shield() : SpellScriptLoader("spell_sha_item_lightning_shield") { }

        class spell_sha_item_lightning_shield_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_sha_item_lightning_shield_AuraScript);

            bool Validate(SpellInfo const* /*spellInfo*/)
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_SHAMAN_ITEM_LIGHTNING_SHIELD))
                    return false;
                return true;
            }

            void HandleProc(AuraEffect const* aurEff, ProcEventInfo& eventInfo)
            {
                PreventDefaultAction();
                GetTarget()->CastSpell(eventInfo.GetProcTarget(), SPELL_SHAMAN_ITEM_LIGHTNING_SHIELD, true, NULL, aurEff);
            }

            void Register()
            {
                OnEffectProc += AuraEffectProcFn(spell_sha_item_lightning_shield_AuraScript::HandleProc, EFFECT_0, SPELL_AURA_PROC_TRIGGER_SPELL);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_sha_item_lightning_shield_AuraScript();
        }
};

// 23552 - Lightning Shield
class spell_sha_item_lightning_shield_trigger : public SpellScriptLoader
{
    public:
        spell_sha_item_lightning_shield_trigger() : SpellScriptLoader("spell_sha_item_lightning_shield_trigger") { }

        class spell_sha_item_lightning_shield_trigger_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_sha_item_lightning_shield_trigger_AuraScript);

            bool Validate(SpellInfo const* /*spellInfo*/)
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_SHAMAN_ITEM_MANA_SURGE))
                    return false;
                return true;
            }

            void HandleProc(AuraEffect const* aurEff, ProcEventInfo& /*eventInfo*/)
            {
                PreventDefaultAction();
                GetTarget()->CastSpell(GetTarget(), SPELL_SHAMAN_ITEM_LIGHTNING_SHIELD_DAMAGE, true, NULL, aurEff);
            }

            void Register()
            {
                OnEffectProc += AuraEffectProcFn(spell_sha_item_lightning_shield_trigger_AuraScript::HandleProc, EFFECT_0, SPELL_AURA_PROC_TRIGGER_SPELL);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_sha_item_lightning_shield_trigger_AuraScript();
        }
};

// 23572 - Mana Surge
class spell_sha_item_mana_surge : public SpellScriptLoader
{
    public:
        spell_sha_item_mana_surge() : SpellScriptLoader("spell_sha_item_mana_surge") { }

        class spell_sha_item_mana_surge_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_sha_item_mana_surge_AuraScript);

            bool Validate(SpellInfo const* /*spellInfo*/)
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_SHAMAN_ITEM_LIGHTNING_SHIELD_DAMAGE))
                    return false;
                return true;
            }

            bool CheckProc(ProcEventInfo& eventInfo)
            {
                return eventInfo.GetDamageInfo()->GetSpellInfo();
            }

            void HandleProc(AuraEffect const* aurEff, ProcEventInfo& eventInfo)
            {
                PreventDefaultAction();
                int32 mana = eventInfo.GetDamageInfo()->GetSpellInfo()->CalcPowerCost(GetTarget(), eventInfo.GetSchoolMask());
                int32 damage = CalculatePct(mana, 35);

                GetTarget()->CastCustomSpell(SPELL_SHAMAN_ITEM_MANA_SURGE, SPELLVALUE_BASE_POINT0, damage, GetTarget(), true, NULL, aurEff);
            }

            void Register()
            {
                DoCheckProc += AuraCheckProcFn(spell_sha_item_mana_surge_AuraScript::CheckProc);
                OnEffectProc += AuraEffectProcFn(spell_sha_item_mana_surge_AuraScript::HandleProc, EFFECT_0, SPELL_AURA_PROC_TRIGGER_SPELL);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_sha_item_mana_surge_AuraScript();
        }
};

// 70811 - Item - Shaman T10 Elemental 2P Bonus
class spell_sha_item_t10_elemental_2p_bonus : public SpellScriptLoader
{
    public:
        spell_sha_item_t10_elemental_2p_bonus() : SpellScriptLoader("spell_sha_item_t10_elemental_2p_bonus") { }

        class spell_sha_item_t10_elemental_2p_bonus_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_sha_item_t10_elemental_2p_bonus_AuraScript);

            bool Validate(SpellInfo const* /*spellInfo*/)
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_SHAMAN_ELEMENTAL_MASTERY))
                    return false;
                return true;
            }

            void HandleEffectProc(AuraEffect const* aurEff, ProcEventInfo& /*eventInfo*/)
            {
                PreventDefaultAction();
                if (Player* target = GetTarget()->ToPlayer())
                    target->ModifySpellCooldown(SPELL_SHAMAN_ELEMENTAL_MASTERY, -aurEff->GetAmount());
            }

            void Register()
            {
                OnEffectProc += AuraEffectProcFn(spell_sha_item_t10_elemental_2p_bonus_AuraScript::HandleEffectProc, EFFECT_0, SPELL_AURA_DUMMY);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_sha_item_t10_elemental_2p_bonus_AuraScript();
        }
};

// 60103 - Lava Lash
class spell_sha_lava_lash : public SpellScriptLoader
{
    public:
        spell_sha_lava_lash() : SpellScriptLoader("spell_sha_lava_lash") { }

        class spell_sha_lava_lash_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_sha_lava_lash_SpellScript)

            bool Load()
            {
                return GetCaster()->GetTypeId() == TYPEID_PLAYER;
            }

            void HandleDummy(SpellEffIndex /*effIndex*/)
            {
                if (Player* caster = GetCaster()->ToPlayer())
                {
                    int32 damage = GetEffectValue();
                    int32 hitDamage = GetHitDamage();
                    if (caster->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_OFFHAND))
                    {
                        // Damage is increased by 25% if your off-hand weapon is enchanted with Flametongue.
                        if (caster->GetAuraEffect(SPELL_AURA_DUMMY, SPELLFAMILY_SHAMAN, 0x200000, 0, 0))
                            AddPct(hitDamage, damage);
                        SetHitDamage(hitDamage);
                    }
                }
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_sha_lava_lash_SpellScript::HandleDummy, EFFECT_1, SPELL_EFFECT_DUMMY);
            }

        };

        SpellScript* GetSpellScript() const
        {
            return new spell_sha_lava_lash_SpellScript();
        }
};

// 52031, 52033, 52034, 52035, 52036, 58778, 58779, 58780 - Mana Spring Totem
class spell_sha_mana_spring_totem : public SpellScriptLoader
{
    public:
        spell_sha_mana_spring_totem() : SpellScriptLoader("spell_sha_mana_spring_totem") { }

        class spell_sha_mana_spring_totem_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_sha_mana_spring_totem_SpellScript);

            bool Validate(SpellInfo const* /*spellInfo*/)
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_SHAMAN_MANA_SPRING_TOTEM_ENERGIZE))
                    return false;
                return true;
            }

            void HandleDummy(SpellEffIndex /*effIndex*/)
            {
                int32 damage = GetEffectValue();
                if (Unit* target = GetHitUnit())
                    if (Unit* caster = GetCaster())
                        if (target->getPowerType() == POWER_MANA)
                            caster->CastCustomSpell(target, SPELL_SHAMAN_MANA_SPRING_TOTEM_ENERGIZE, &damage, 0, 0, true, 0, 0, GetOriginalCaster()->GetGUID());
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_sha_mana_spring_totem_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
            }

        };

        SpellScript* GetSpellScript() const
        {
            return new spell_sha_mana_spring_totem_SpellScript();
        }
};

// 39610 - Mana Tide Totem
class spell_sha_mana_tide_totem : public SpellScriptLoader
{
    public:
        spell_sha_mana_tide_totem() : SpellScriptLoader("spell_sha_mana_tide_totem") { }

        class spell_sha_mana_tide_totem_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_sha_mana_tide_totem_SpellScript);

            bool Validate(SpellInfo const* /*spellInfo*/)
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_SHAMAN_GLYPH_OF_MANA_TIDE) || !sSpellMgr->GetSpellInfo(SPELL_SHAMAN_MANA_TIDE_TOTEM))
                    return false;
                return true;
            }

            void HandleDummy(SpellEffIndex /*effIndex*/)
            {
                if (Unit* caster = GetCaster())
                    if (Unit* unitTarget = GetHitUnit())
                    {
                        if (unitTarget->getPowerType() == POWER_MANA)
                        {
                            int32 effValue = GetEffectValue();
                            // Glyph of Mana Tide
                            if (Unit* owner = caster->GetOwner())
                                if (AuraEffect* dummy = owner->GetAuraEffect(SPELL_SHAMAN_GLYPH_OF_MANA_TIDE, 0))
                                    effValue += dummy->GetAmount();
                            // Regenerate 6% of Total Mana Every 3 secs
                            int32 effBasePoints0 = int32(CalculatePct(unitTarget->GetMaxPower(POWER_MANA), effValue));
                            caster->CastCustomSpell(unitTarget, SPELL_SHAMAN_MANA_TIDE_TOTEM, &effBasePoints0, nullptr, nullptr, true, nullptr, nullptr, GetOriginalCaster()->GetGUID());
                        }
                    }
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_sha_mana_tide_totem_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_sha_mana_tide_totem_SpellScript();
        }
};

// 6495 - Sentry Totem
class spell_sha_sentry_totem : public SpellScriptLoader
{
    public:
        spell_sha_sentry_totem() : SpellScriptLoader("spell_sha_sentry_totem") { }

        class spell_sha_sentry_totem_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_sha_sentry_totem_AuraScript);

            bool Validate(SpellInfo const* /*spell*/)
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_SHAMAN_BIND_SIGHT))
                    return false;
                return true;
            }

            void AfterRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
            {
                if (Unit* caster = GetCaster())
                    if (caster->GetTypeId() == TYPEID_PLAYER)
                        caster->ToPlayer()->StopCastingBindSight();
            }

            void Register()
            {
                 AfterEffectRemove += AuraEffectRemoveFn(spell_sha_sentry_totem_AuraScript::AfterRemove, EFFECT_1, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_sha_sentry_totem_AuraScript();
        }
};

// -51490 - Thunderstorm
class spell_sha_thunderstorm : public SpellScriptLoader
{
    public:
        spell_sha_thunderstorm() : SpellScriptLoader("spell_sha_thunderstorm") { }

        class spell_sha_thunderstorm_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_sha_thunderstorm_SpellScript);

            void HandleKnockBack(SpellEffIndex effIndex)
            {
                // Glyph of Thunderstorm
                if (GetCaster()->HasAura(SPELL_SHAMAN_GLYPH_OF_THUNDERSTORM))
                    PreventHitDefaultEffect(effIndex);
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_sha_thunderstorm_SpellScript::HandleKnockBack, EFFECT_2, SPELL_EFFECT_KNOCK_BACK);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_sha_thunderstorm_SpellScript();
        }
};

void AddSC_shaman_spell_scripts()
{
    // ours
    new spell_sha_totem_of_wrath();
    new spell_sha_spirit_walk();
    new spell_sha_t10_restoration_4p_bonus();
    new spell_sha_totemic_mastery();
    new spell_sha_feral_spirit_scaling();
    new spell_sha_fire_elemental_scaling();

    // theirs
    new spell_sha_ancestral_awakening_proc();
    new spell_sha_astral_shift();
    new spell_sha_bloodlust();
    new spell_sha_chain_heal();
    new spell_sha_cleansing_totem_pulse();
    new spell_sha_earth_shield();
    new spell_sha_earthbind_totem();
    new spell_sha_earthen_power();
    new spell_sha_fire_nova();
    new spell_sha_flame_shock();
    new spell_sha_healing_stream_totem();
    new spell_sha_heroism();
    new spell_sha_item_lightning_shield();
    new spell_sha_item_lightning_shield_trigger();
    new spell_sha_item_mana_surge();
    new spell_sha_item_t10_elemental_2p_bonus();
    new spell_sha_lava_lash();
    new spell_sha_mana_spring_totem();
    new spell_sha_mana_tide_totem();
    new spell_sha_sentry_totem();
    new spell_sha_thunderstorm();
}

/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

/*
 * Scripts for spells with SPELLFAMILY_WARLOCK and SPELLFAMILY_GENERIC spells used by warlock players.
 * Ordered alphabetically using scriptname.
 * Scriptnames of files in this file should be prefixed with "spell_warl_".
 */

#include "ScriptMgr.h"
#include "SpellScript.h"
#include "SpellAuraEffects.h"
#include "Player.h"
#include "SpellInfo.h"
#include "TemporarySummon.h"

enum WarlockSpells
{
    SPELL_WARLOCK_CURSE_OF_DOOM_EFFECT              = 18662,
    SPELL_WARLOCK_DEMONIC_CIRCLE_SUMMON             = 48018,
    SPELL_WARLOCK_DEMONIC_CIRCLE_TELEPORT           = 48020,
    SPELL_WARLOCK_DEMONIC_CIRCLE_ALLOW_CAST         = 62388,
    SPELL_WARLOCK_DEMONIC_EMPOWERMENT_SUCCUBUS      = 54435,
    SPELL_WARLOCK_DEMONIC_EMPOWERMENT_VOIDWALKER    = 54443,
    SPELL_WARLOCK_DEMONIC_EMPOWERMENT_FELGUARD      = 54508,
    SPELL_WARLOCK_DEMONIC_EMPOWERMENT_FELHUNTER     = 54509,
    SPELL_WARLOCK_DEMONIC_EMPOWERMENT_IMP           = 54444,
    SPELL_WARLOCK_FEL_SYNERGY_HEAL                  = 54181,
    SPELL_WARLOCK_GLYPH_OF_SHADOWFLAME              = 63311,
    SPELL_WARLOCK_GLYPH_OF_SIPHON_LIFE              = 56216,
    SPELL_WARLOCK_HAUNT                             = 48181,
    SPELL_WARLOCK_HAUNT_HEAL                        = 48210,
    SPELL_WARLOCK_IMPROVED_HEALTHSTONE_R1           = 18692,
    SPELL_WARLOCK_IMPROVED_HEALTHSTONE_R2           = 18693,
    SPELL_WARLOCK_IMPROVED_HEALTH_FUNNEL_R1         = 18703,
    SPELL_WARLOCK_IMPROVED_HEALTH_FUNNEL_R2         = 18704,
    SPELL_WARLOCK_IMPROVED_HEALTH_FUNNEL_BUFF_R1    = 60955,
    SPELL_WARLOCK_IMPROVED_HEALTH_FUNNEL_BUFF_R2    = 60956,
    SPELL_WARLOCK_LIFE_TAP_ENERGIZE                 = 31818,
    SPELL_WARLOCK_LIFE_TAP_ENERGIZE_2               = 32553,
    SPELL_WARLOCK_SOULSHATTER                       = 32835,
    SPELL_WARLOCK_SIPHON_LIFE_HEAL                  = 63106,
    SPELL_WARLOCK_UNSTABLE_AFFLICTION_DISPEL        = 31117
};

enum WarlockSpellIcons
{
    WARLOCK_ICON_ID_IMPROVED_LIFE_TAP               = 208,
    WARLOCK_ICON_ID_MANA_FEED                       = 1982
};

// Ours
class spell_warl_eye_of_kilrogg : public SpellScriptLoader
{
    public:
        spell_warl_eye_of_kilrogg() : SpellScriptLoader("spell_warl_eye_of_kilrogg") { }

        class spell_warl_eye_of_kilrogg_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_warl_eye_of_kilrogg_AuraScript);

            void HandleAuraApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
            {
                PreventDefaultAction();
                if (Player* player = GetTarget()->ToPlayer())
                {
                    player->UnsummonPetTemporaryIfAny();

                    // Glyph of Kilrogg
                    if (player->HasAura(58081))
                        if (Unit* charm = player->GetCharm())
                        {
                            charm->SetSpeed(MOVE_RUN, 2.14f, true);
                            if (charm->GetMapId() == 530 || charm->GetMapId() == 571)
                            {
                                charm->SetCanFly(true);
                                charm->SetSpeed(MOVE_FLIGHT, 2.14f, true);
                                charm->SendMovementFlagUpdate();
                            }
                        }
                }
            }

            void HandleAuraRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
            {
                if (Player* player = GetTarget()->ToPlayer())
                {
                    if (Unit* charm = player->GetCharm())
                        charm->ToTempSummon()->UnSummon();

                    player->ResummonPetTemporaryUnSummonedIfAny();
                }
            }

            void Register()
            {
                OnEffectApply += AuraEffectApplyFn(spell_warl_eye_of_kilrogg_AuraScript::HandleAuraApply, EFFECT_1, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
                AfterEffectRemove += AuraEffectRemoveFn(spell_warl_eye_of_kilrogg_AuraScript::HandleAuraRemove, EFFECT_1, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_warl_eye_of_kilrogg_AuraScript();
        }
};

class spell_warl_shadowflame : public SpellScriptLoader
{
    public:
        spell_warl_shadowflame() : SpellScriptLoader("spell_warl_shadowflame") { }

        class spell_warl_shadowflame_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_warl_shadowflame_SpellScript);

            void HandleSchoolDMG(SpellEffIndex /*effIndex*/)
            {
                if (Unit* target = GetHitUnit())
                    GetCaster()->CastSpell(target, (GetSpellInfo()->Id == 47897 ? 47960 : 61291), true);
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_warl_shadowflame_SpellScript::HandleSchoolDMG, EFFECT_0, SPELL_EFFECT_SCHOOL_DAMAGE);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_warl_shadowflame_SpellScript();
        }
};

class spell_warl_seduction : public SpellScriptLoader
{
    public:
        spell_warl_seduction() : SpellScriptLoader("spell_warl_seduction") { }

        class spell_warl_seduction_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_warl_seduction_AuraScript);

            void HandleAuraApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
            {
                if (Unit* caster = GetCaster())
                {
                    if (Unit* owner = caster->GetOwner())
                        if (owner->GetAuraEffectDummy(56250))
                        {
                            Unit* target = GetTarget();
                            target->RemoveAurasByType(SPELL_AURA_PERIODIC_DAMAGE, 0, target->GetAura(32409)); // SW:D shall not be removed.
                            target->RemoveAurasByType(SPELL_AURA_PERIODIC_DAMAGE_PERCENT);
                            target->RemoveAurasByType(SPELL_AURA_PERIODIC_LEECH);
                        }
                }
            }

            void Register()
            {
                OnEffectApply += AuraEffectApplyFn(spell_warl_seduction_AuraScript::HandleAuraApply, EFFECT_0, SPELL_AURA_MOD_STUN, AURA_EFFECT_HANDLE_REAL);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_warl_seduction_AuraScript();
        }
};

class spell_warl_improved_demonic_tactics : public SpellScriptLoader
{
    public:
        spell_warl_improved_demonic_tactics() : SpellScriptLoader("spell_warl_improved_demonic_tactics") { }

        class spell_warl_improved_demonic_tactics_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_warl_improved_demonic_tactics_AuraScript);

            bool Load()
            {
                return GetUnitOwner()->GetTypeId() == TYPEID_PLAYER;
            }

            void CalcPeriodic(AuraEffect const* /*aurEff*/, bool& isPeriodic, int32& amplitude)
            {
                isPeriodic = true;
                amplitude = 10*IN_MILLISECONDS;
            }

            void CalculateAmount(AuraEffect const* aurEff, int32& amount, bool&  /*canBeRecalculated*/)
            {
                if (aurEff->GetEffIndex() == EFFECT_0)
                    amount = CalculatePct<int32, float>(GetUnitOwner()->ToPlayer()->GetFloatValue(PLAYER_SPELL_CRIT_PERCENTAGE1 + SPELL_SCHOOL_FROST), GetSpellInfo()->Effects[EFFECT_0].CalcValue());
                else
                    amount = CalculatePct<int32, float>(GetUnitOwner()->ToPlayer()->GetFloatValue(PLAYER_CRIT_PERCENTAGE), GetSpellInfo()->Effects[EFFECT_0].CalcValue());
            }

            void HandleEffectCalcSpellMod(AuraEffect const* aurEff, SpellModifier*& spellMod)
            {
                if (!spellMod)
                {
                    spellMod = new SpellModifier(aurEff->GetBase());
                    spellMod->op = SpellModOp(aurEff->GetMiscValue());
                    spellMod->type = SPELLMOD_FLAT;
                    spellMod->spellId = GetId();
                    spellMod->mask = flag96(0x0, 0x2000, 0x0); // Pet Passive
                }

                spellMod->value = aurEff->GetAmount();
            }

            void HandlePeriodic(AuraEffect const* aurEff)
            {
                PreventDefaultAction();
                GetAura()->GetEffect(aurEff->GetEffIndex())->RecalculateAmount();
            }

            void Register()
            {
                DoEffectCalcPeriodic += AuraEffectCalcPeriodicFn(spell_warl_improved_demonic_tactics_AuraScript::CalcPeriodic, EFFECT_ALL, SPELL_AURA_DUMMY);
                DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_warl_improved_demonic_tactics_AuraScript::CalculateAmount, EFFECT_ALL, SPELL_AURA_DUMMY);
                DoEffectCalcSpellMod += AuraEffectCalcSpellModFn(spell_warl_improved_demonic_tactics_AuraScript::HandleEffectCalcSpellMod, EFFECT_ALL, SPELL_AURA_DUMMY);
                OnEffectPeriodic += AuraEffectPeriodicFn(spell_warl_improved_demonic_tactics_AuraScript::HandlePeriodic, EFFECT_ALL, SPELL_AURA_DUMMY);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_warl_improved_demonic_tactics_AuraScript();
        }
};

class spell_warl_ritual_of_summoning : public SpellScriptLoader
{
    public:
        spell_warl_ritual_of_summoning() : SpellScriptLoader("spell_warl_ritual_of_summoning") { }

        class spell_warl_ritual_of_summoning_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_warl_ritual_of_summoning_SpellScript);

            SpellCastResult CheckCast()
            {
                if (GetCaster()->GetTypeId() == TYPEID_PLAYER)
                    if (GetCaster()->ToPlayer()->InBattleground())
                        return SPELL_FAILED_NOT_IN_BATTLEGROUND;
                return SPELL_CAST_OK;
            }

            void Register()
            {
                OnCheckCast += SpellCheckCastFn(spell_warl_ritual_of_summoning_SpellScript::CheckCast);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_warl_ritual_of_summoning_SpellScript();
        }
};

class spell_warl_demonic_aegis : public SpellScriptLoader
{
    public:
        spell_warl_demonic_aegis() : SpellScriptLoader("spell_warl_demonic_aegis") { }

        class spell_warl_demonic_aegis_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_warl_demonic_aegis_AuraScript);

            void HandleAuraApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
            {
                // Remove Fel Armor and Demon Armor
                GetTarget()->RemoveAurasWithFamily(SPELLFAMILY_WARLOCK, 0, 0x20000020, 0, 0);
            }

            void Register()
            {
                OnEffectRemove += AuraEffectRemoveFn(spell_warl_demonic_aegis_AuraScript::HandleAuraApply, EFFECT_0, SPELL_AURA_ADD_PCT_MODIFIER, AURA_EFFECT_HANDLE_REAL);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_warl_demonic_aegis_AuraScript();
        }
};

class spell_warl_demonic_knowledge : public SpellScriptLoader
{
    public:
        spell_warl_demonic_knowledge() : SpellScriptLoader("spell_warl_demonic_knowledge") { }

        class spell_warl_demonic_knowledge_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_warl_demonic_knowledge_AuraScript);

            void CalculateAmount(AuraEffect const* aurEff, int32 & amount, bool & /*canBeRecalculated*/)
            {
                if (Unit* caster = GetCaster())
                    amount = CalculatePct(caster->GetStat(STAT_STAMINA)+caster->GetStat(STAT_INTELLECT), aurEff->GetBaseAmount());
            }

            void CalcPeriodic(AuraEffect const* /*aurEff*/, bool& isPeriodic, int32& amplitude)
            {
                isPeriodic = true;
                amplitude = 5*IN_MILLISECONDS;
            }
            
            void HandlePeriodic(AuraEffect const* aurEff)
            {
                PreventDefaultAction();
                GetEffect(aurEff->GetEffIndex())->RecalculateAmount();
            }

            void Register()
            {
                DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_warl_demonic_knowledge_AuraScript::CalculateAmount, EFFECT_0, SPELL_AURA_MOD_DAMAGE_DONE);
                DoEffectCalcPeriodic += AuraEffectCalcPeriodicFn(spell_warl_demonic_knowledge_AuraScript::CalcPeriodic, EFFECT_0, SPELL_AURA_MOD_DAMAGE_DONE);
                OnEffectPeriodic += AuraEffectPeriodicFn(spell_warl_demonic_knowledge_AuraScript::HandlePeriodic, EFFECT_0, SPELL_AURA_MOD_DAMAGE_DONE);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_warl_demonic_knowledge_AuraScript();
        }
};

class spell_warl_generic_scaling : public SpellScriptLoader
{
    public:
        spell_warl_generic_scaling() : SpellScriptLoader("spell_warl_generic_scaling") { }

        class spell_warl_generic_scaling_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_warl_generic_scaling_AuraScript);

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
                // xinef: by default warlock pet inherits 75% of stamina and 30% of intellect
                if (Unit* owner = GetUnitOwner()->GetOwner())
                {
                    Stats stat = Stats(aurEff->GetSpellInfo()->Effects[aurEff->GetEffIndex()].MiscValue);
                    int32 modifier = stat == STAT_STAMINA ? 75 : 30;
                    amount = CalculatePct(std::max<int32>(0, owner->GetStat(stat)), modifier);
                }
            }

            void CalculateAPAmount(AuraEffect const*  /*aurEff*/, int32 & amount, bool & /*canBeRecalculated*/)
            {
                // xinef: by default warlock pet inherits 57% of max(SP FIRE, SP SHADOW) as AP
                if (Unit* owner = GetUnitOwner()->GetOwner())
                {
                    int32 fire  = owner->SpellBaseDamageBonusDone(SPELL_SCHOOL_MASK_FIRE);
                    int32 shadow = owner->SpellBaseDamageBonusDone(SPELL_SCHOOL_MASK_SHADOW);
                    int32 maximum  = (fire > shadow) ? fire : shadow;
                    amount = CalculatePct(std::max<int32>(0, maximum), 57);
                }
            }

            void CalculateSPAmount(AuraEffect const*  /*aurEff*/, int32 & amount, bool & /*canBeRecalculated*/)
            {
                // xinef: by default warlock pet inherits 15% of max(SP FIRE, SP SHADOW) as SP
                if (Unit* owner = GetUnitOwner()->GetOwner())
                {
                    int32 fire  = owner->SpellBaseDamageBonusDone(SPELL_SCHOOL_MASK_FIRE);
                    int32 shadow = owner->SpellBaseDamageBonusDone(SPELL_SCHOOL_MASK_SHADOW);
                    int32 maximum  = (fire > shadow) ? fire : shadow;
                    amount = CalculatePct(std::max<int32>(0, maximum), 15);

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
                if (m_scriptSpellId != 34947)
                    DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_warl_generic_scaling_AuraScript::CalculateResistanceAmount, EFFECT_ALL, SPELL_AURA_MOD_RESISTANCE);

                if (m_scriptSpellId == 34947 || m_scriptSpellId == 34956)
                    DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_warl_generic_scaling_AuraScript::CalculateStatAmount, EFFECT_ALL, SPELL_AURA_MOD_STAT);

                if (m_scriptSpellId == 34947)
                {
                    DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_warl_generic_scaling_AuraScript::CalculateAPAmount, EFFECT_ALL, SPELL_AURA_MOD_ATTACK_POWER);
                    DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_warl_generic_scaling_AuraScript::CalculateSPAmount, EFFECT_ALL, SPELL_AURA_MOD_DAMAGE_DONE);
                }

                DoEffectCalcPeriodic += AuraEffectCalcPeriodicFn(spell_warl_generic_scaling_AuraScript::CalcPeriodic, EFFECT_ALL, SPELL_AURA_ANY);
                OnEffectPeriodic += AuraEffectPeriodicFn(spell_warl_generic_scaling_AuraScript::HandlePeriodic, EFFECT_ALL, SPELL_AURA_ANY);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_warl_generic_scaling_AuraScript();
        }
};

class spell_warl_infernal_scaling : public SpellScriptLoader
{
    public:
        spell_warl_infernal_scaling() : SpellScriptLoader("spell_warl_infernal_scaling") { }

        class spell_warl_infernal_scaling_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_warl_infernal_scaling_AuraScript);

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
                // xinef: by default warlock pet inherits 75% of stamina and 30% of intellect
                if (Unit* owner = GetUnitOwner()->GetOwner())
                {
                    Stats stat = Stats(aurEff->GetSpellInfo()->Effects[aurEff->GetEffIndex()].MiscValue);
                    int32 modifier = stat == STAT_STAMINA ? 75 : 30;
                    amount = CalculatePct(std::max<int32>(0, owner->GetStat(stat)), modifier);
                }
            }

            void CalculateAPAmount(AuraEffect const*  /*aurEff*/, int32 & amount, bool & /*canBeRecalculated*/)
            {
                // xinef: by default warlock pet inherits 57% of max(SP FIRE, SP SHADOW) as AP
                if (Unit* owner = GetUnitOwner()->GetOwner())
                {
                    int32 fire  = owner->SpellBaseDamageBonusDone(SPELL_SCHOOL_MASK_FIRE);
                    int32 shadow = owner->SpellBaseDamageBonusDone(SPELL_SCHOOL_MASK_SHADOW);
                    int32 maximum  = (fire > shadow) ? fire : shadow;
                    amount = CalculatePct(std::max<int32>(0, maximum), 57);
                }
            }

            void CalculateSPAmount(AuraEffect const*  /*aurEff*/, int32 & amount, bool & /*canBeRecalculated*/)
            {
                // xinef: by default warlock pet inherits 15% of max(SP FIRE, SP SHADOW) as SP
                if (Unit* owner = GetUnitOwner()->GetOwner())
                {
                    int32 fire  = owner->SpellBaseDamageBonusDone(SPELL_SCHOOL_MASK_FIRE);
                    int32 shadow = owner->SpellBaseDamageBonusDone(SPELL_SCHOOL_MASK_SHADOW);
                    int32 maximum  = (fire > shadow) ? fire : shadow;
                    amount = CalculatePct(std::max<int32>(0, maximum), 15);

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
                if (m_scriptSpellId != 36186)
                    DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_warl_infernal_scaling_AuraScript::CalculateResistanceAmount, EFFECT_ALL, SPELL_AURA_MOD_RESISTANCE);

                if (m_scriptSpellId == 36186 || m_scriptSpellId == 36188)
                    DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_warl_infernal_scaling_AuraScript::CalculateStatAmount, EFFECT_ALL, SPELL_AURA_MOD_STAT);

                if (m_scriptSpellId == 36186)
                {
                    DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_warl_infernal_scaling_AuraScript::CalculateAPAmount, EFFECT_ALL, SPELL_AURA_MOD_ATTACK_POWER);
                    DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_warl_infernal_scaling_AuraScript::CalculateSPAmount, EFFECT_ALL, SPELL_AURA_MOD_DAMAGE_DONE);
                }

                OnEffectApply += AuraEffectApplyFn(spell_warl_infernal_scaling_AuraScript::HandleEffectApply, EFFECT_ALL, SPELL_AURA_ANY, AURA_EFFECT_HANDLE_REAL);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_warl_infernal_scaling_AuraScript();
        }
};

//Theirs
// -710 - Banish
class spell_warl_banish : public SpellScriptLoader
{
    public:
        spell_warl_banish() : SpellScriptLoader("spell_warl_banish") { }

        class spell_warl_banish_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_warl_banish_SpellScript);

            bool Load()
            {
                _removed = false;
                return true;
            }

            void HandleBanish()
            {
                if (Unit* target = GetHitUnit())
                {
                    if (target->GetAuraEffect(SPELL_AURA_SCHOOL_IMMUNITY, SPELLFAMILY_WARLOCK, 0, 0x08000000, 0))
                    {
                        // No need to remove old aura since its removed due to not stack by current Banish aura
                        PreventHitDefaultEffect(EFFECT_0);
                        PreventHitDefaultEffect(EFFECT_1);
                        PreventHitDefaultEffect(EFFECT_2);
                        _removed = true;
                    }
                }
            }

            void RemoveAura()
            {
                if (_removed)
                    PreventHitAura();
            }

            void Register()
            {
                BeforeHit += SpellHitFn(spell_warl_banish_SpellScript::HandleBanish);
                AfterHit += SpellHitFn(spell_warl_banish_SpellScript::RemoveAura);
            }

            bool _removed;
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_warl_banish_SpellScript();
        }
};

// 47193 - Demonic Empowerment
class spell_warl_demonic_empowerment : public SpellScriptLoader
{
    public:
        spell_warl_demonic_empowerment() : SpellScriptLoader("spell_warl_demonic_empowerment") { }

        class spell_warl_demonic_empowerment_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_warl_demonic_empowerment_SpellScript);

            bool Validate(SpellInfo const* /*spellInfo*/)
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_WARLOCK_DEMONIC_EMPOWERMENT_SUCCUBUS) || !sSpellMgr->GetSpellInfo(SPELL_WARLOCK_DEMONIC_EMPOWERMENT_VOIDWALKER) || !sSpellMgr->GetSpellInfo(SPELL_WARLOCK_DEMONIC_EMPOWERMENT_FELGUARD) || !sSpellMgr->GetSpellInfo(SPELL_WARLOCK_DEMONIC_EMPOWERMENT_FELHUNTER) || !sSpellMgr->GetSpellInfo(SPELL_WARLOCK_DEMONIC_EMPOWERMENT_IMP))
                    return false;
                return true;
            }

            void HandleScriptEffect(SpellEffIndex /*effIndex*/)
            {
                if (Creature* targetCreature = GetHitCreature())
                {
                    if (targetCreature->IsPet())
                    {
                        CreatureTemplate const* ci = sObjectMgr->GetCreatureTemplate(targetCreature->GetEntry());
                        switch (ci->family)
                        {
                            case CREATURE_FAMILY_SUCCUBUS:
                                targetCreature->CastSpell(targetCreature, SPELL_WARLOCK_DEMONIC_EMPOWERMENT_SUCCUBUS, true);
                                break;
                            case CREATURE_FAMILY_VOIDWALKER:
                            {
                                SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(SPELL_WARLOCK_DEMONIC_EMPOWERMENT_VOIDWALKER);
                                int32 hp = int32(targetCreature->CountPctFromMaxHealth(GetCaster()->CalculateSpellDamage(targetCreature, spellInfo, 0)));
                                targetCreature->CastCustomSpell(targetCreature, SPELL_WARLOCK_DEMONIC_EMPOWERMENT_VOIDWALKER, &hp, nullptr, nullptr, true);
                                //unitTarget->CastSpell(unitTarget, 54441, true);
                                break;
                            }
                            case CREATURE_FAMILY_FELGUARD:
                                targetCreature->CastSpell(targetCreature, SPELL_WARLOCK_DEMONIC_EMPOWERMENT_FELGUARD, true);
                                break;
                            case CREATURE_FAMILY_FELHUNTER:
                                targetCreature->CastSpell(targetCreature, SPELL_WARLOCK_DEMONIC_EMPOWERMENT_FELHUNTER, true);
                                break;
                            case CREATURE_FAMILY_IMP:
                                targetCreature->CastSpell(targetCreature, SPELL_WARLOCK_DEMONIC_EMPOWERMENT_IMP, true);
                                break;
                        }
                    }
                }
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_warl_demonic_empowerment_SpellScript::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_warl_demonic_empowerment_SpellScript();
        }
};

// 6201 - Create Healthstone (and ranks)
class spell_warl_create_healthstone : public SpellScriptLoader
{
    public:
        spell_warl_create_healthstone() : SpellScriptLoader("spell_warl_create_healthstone") { }

        class spell_warl_create_healthstone_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_warl_create_healthstone_SpellScript);

            static uint32 const iTypes[8][3];

            bool Validate(SpellInfo const* /*spellInfo*/)
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_WARLOCK_IMPROVED_HEALTHSTONE_R1) || !sSpellMgr->GetSpellInfo(SPELL_WARLOCK_IMPROVED_HEALTHSTONE_R2))
                    return false;
                return true;
            }

            SpellCastResult CheckCast()
            {
                if (Player* caster = GetCaster()->ToPlayer())
                {
                    uint8 spellRank = GetSpellInfo()->GetRank();
                    ItemPosCountVec dest;
                    InventoryResult msg = caster->CanStoreNewItem(NULL_BAG, NULL_SLOT, dest, iTypes[spellRank - 1][0], 1, nullptr);
                    if (msg != EQUIP_ERR_OK)
                        return SPELL_FAILED_TOO_MANY_OF_ITEM;
                }
                return SPELL_CAST_OK;
            }

            void HandleScriptEffect(SpellEffIndex effIndex)
            {
                if (Unit* unitTarget = GetHitUnit())
                {
                    uint32 rank = 0;
                    // Improved Healthstone
                    if (AuraEffect const* aurEff = unitTarget->GetDummyAuraEffect(SPELLFAMILY_WARLOCK, 284, 0))
                    {
                        switch (aurEff->GetId())
                        {
                            case SPELL_WARLOCK_IMPROVED_HEALTHSTONE_R1:
                                rank = 1;
                                break;
                            case SPELL_WARLOCK_IMPROVED_HEALTHSTONE_R2:
                                rank = 2;
                                break;
                            default:
                                sLog->outError("Unknown rank of Improved Healthstone id: %d", aurEff->GetId());
                                break;
                        }
                    }
                    uint8 spellRank = GetSpellInfo()->GetRank();
                    if (spellRank > 0 && spellRank <= 8)
                        CreateItem(effIndex, iTypes[spellRank - 1][rank]);
                }
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_warl_create_healthstone_SpellScript::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
                OnCheckCast += SpellCheckCastFn(spell_warl_create_healthstone_SpellScript::CheckCast);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_warl_create_healthstone_SpellScript();
        }
};

uint32 const spell_warl_create_healthstone::spell_warl_create_healthstone_SpellScript::iTypes[8][3] = {
    { 5512, 19004, 19005},              // Minor Healthstone
    { 5511, 19006, 19007},              // Lesser Healthstone
    { 5509, 19008, 19009},              // Healthstone
    { 5510, 19010, 19011},              // Greater Healthstone
    { 9421, 19012, 19013},              // Major Healthstone
    {22103, 22104, 22105},              // Master Healthstone
    {36889, 36890, 36891},              // Demonic Healthstone
    {36892, 36893, 36894}               // Fel Healthstone
};

// 47422 - Everlasting Affliction
class spell_warl_everlasting_affliction : public SpellScriptLoader
{
    public:
        spell_warl_everlasting_affliction() : SpellScriptLoader("spell_warl_everlasting_affliction") { }

        class spell_warl_everlasting_affliction_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_warl_everlasting_affliction_SpellScript);

            void HandleScriptEffect(SpellEffIndex /*effIndex*/)
            {
                if (Unit* unitTarget = GetHitUnit())
                    // Refresh corruption on target
                    if (AuraEffect* aur = unitTarget->GetAuraEffect(SPELL_AURA_PERIODIC_DAMAGE, SPELLFAMILY_WARLOCK, 0x2, 0, 0, GetCaster()->GetGUID()))
                    {
                        aur->GetBase()->RefreshTimersWithMods();
                        aur->ChangeAmount(aur->CalculateAmount(aur->GetCaster()), false);
                    }
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_warl_everlasting_affliction_SpellScript::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_warl_everlasting_affliction_SpellScript();
        }
};

// 18541 - Ritual of Doom Effect
class spell_warl_ritual_of_doom_effect : public SpellScriptLoader
{
    public:
        spell_warl_ritual_of_doom_effect() : SpellScriptLoader("spell_warl_ritual_of_doom_effect") { }

        class spell_warl_ritual_of_doom_effect_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_warl_ritual_of_doom_effect_SpellScript);

            void HandleDummy(SpellEffIndex /*effIndex*/)
            {
                Unit* caster = GetCaster();
                caster->CastSpell(caster, GetEffectValue(), true);
            }

            void Register()
            {
                OnEffectHit += SpellEffectFn(spell_warl_ritual_of_doom_effect_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_warl_ritual_of_doom_effect_SpellScript();
        }
};

// -27285 - Seed of Corruption
class spell_warl_seed_of_corruption : public SpellScriptLoader
{
    public:
        spell_warl_seed_of_corruption() : SpellScriptLoader("spell_warl_seed_of_corruption") { }

        class spell_warl_seed_of_corruption_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_warl_seed_of_corruption_SpellScript);

            void FilterTargets(std::list<WorldObject*>& targets)
            {
                if (GetExplTargetUnit())
                    targets.remove(GetExplTargetUnit());
            }

            void Register()
            {
                OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_warl_seed_of_corruption_SpellScript::FilterTargets, EFFECT_0, TARGET_UNIT_DEST_AREA_ENEMY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_warl_seed_of_corruption_SpellScript();
        }
};

// 29858 - Soulshatter
class spell_warl_soulshatter : public SpellScriptLoader
{
    public:
        spell_warl_soulshatter() : SpellScriptLoader("spell_warl_soulshatter") { }

        class spell_warl_soulshatter_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_warl_soulshatter_SpellScript);

            bool Validate(SpellInfo const* /*spellInfo*/)
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_WARLOCK_SOULSHATTER))
                    return false;
                return true;
            }

            void HandleDummy(SpellEffIndex /*effIndex*/)
            {
                Unit* caster = GetCaster();
                if (Unit* target = GetHitUnit())
                {
                    if (target->CanHaveThreatList() && target->getThreatManager().getThreat(caster) > 0.0f)
                        caster->CastSpell(target, SPELL_WARLOCK_SOULSHATTER, true);
                }
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_warl_soulshatter_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_warl_soulshatter_SpellScript();
        }
};

// 63108 - Siphon Life
class spell_warl_siphon_life : public SpellScriptLoader
{
    public:
        spell_warl_siphon_life() : SpellScriptLoader("spell_warl_siphon_life") { }

        class spell_warl_siphon_life_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_warl_siphon_life_AuraScript);

            bool Validate(SpellInfo const* /*spellInfo*/)
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_WARLOCK_SIPHON_LIFE_HEAL))
                    return false;
                if (!sSpellMgr->GetSpellInfo(SPELL_WARLOCK_GLYPH_OF_SIPHON_LIFE))
                    return false;
                return true;
            }

            bool CheckProc(ProcEventInfo& eventInfo)
            {
                return eventInfo.GetDamageInfo()->GetDamage() && GetTarget()->IsAlive();
            }

            void OnProc(AuraEffect const* aurEff, ProcEventInfo& eventInfo)
            {
                PreventDefaultAction();

                int32 amount = int32(CalculatePct(eventInfo.GetDamageInfo()->GetDamage(), aurEff->GetAmount()));
                // Glyph of Siphon Life
                if (AuraEffect const* glyph = GetTarget()->GetAuraEffect(SPELL_WARLOCK_GLYPH_OF_SIPHON_LIFE, EFFECT_0))
                    AddPct(amount, glyph->GetAmount());

                GetTarget()->CastCustomSpell(SPELL_WARLOCK_SIPHON_LIFE_HEAL, SPELLVALUE_BASE_POINT0, amount, GetTarget(), true, NULL, aurEff);
            }

            void Register()
            {
                DoCheckProc += AuraCheckProcFn(spell_warl_siphon_life_AuraScript::CheckProc);
                OnEffectProc += AuraEffectProcFn(spell_warl_siphon_life_AuraScript::OnProc, EFFECT_0, SPELL_AURA_DUMMY);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_warl_siphon_life_AuraScript();
        }
};

// -1454 - Life Tap
class spell_warl_life_tap : public SpellScriptLoader
{
    public:
        spell_warl_life_tap() : SpellScriptLoader("spell_warl_life_tap") { }

        class spell_warl_life_tap_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_warl_life_tap_SpellScript);

            bool Load()
            {
                return GetCaster()->GetTypeId() == TYPEID_PLAYER;
            }

            bool Validate(SpellInfo const* /*spell*/)
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_WARLOCK_LIFE_TAP_ENERGIZE) || !sSpellMgr->GetSpellInfo(SPELL_WARLOCK_LIFE_TAP_ENERGIZE_2))
                    return false;
                return true;
            }

            void HandleDummy(SpellEffIndex /*effIndex*/)
            {
                Player* caster = GetCaster()->ToPlayer();
                if (Unit* target = GetHitUnit())
                {
                    int32 damage = GetEffectValue() + 1.0f + (caster->GetStat(STAT_SPIRIT) * 1.5f);
                    int32 damage2Mana = GetEffectValue();
                    int32 mana = int32(damage2Mana + (caster->GetInt32Value(PLAYER_FIELD_MOD_DAMAGE_DONE_POS+SPELL_SCHOOL_SHADOW) * 0.5f));

                    // Shouldn't Appear in Combat Log
                    target->ModifyHealth(-damage);

                    // Improved Life Tap mod
                    if (AuraEffect const* aurEff = caster->GetDummyAuraEffect(SPELLFAMILY_WARLOCK, WARLOCK_ICON_ID_IMPROVED_LIFE_TAP, 0))
                        AddPct(mana, aurEff->GetAmount());

                    caster->CastCustomSpell(target, SPELL_WARLOCK_LIFE_TAP_ENERGIZE, &mana, nullptr, nullptr, false);

                    // Mana Feed
                    int32 manaFeedVal = 0;
                    if (AuraEffect const* aurEff = caster->GetAuraEffect(SPELL_AURA_ADD_FLAT_MODIFIER, SPELLFAMILY_WARLOCK, WARLOCK_ICON_ID_MANA_FEED, 0))
                        manaFeedVal = aurEff->GetAmount();

                    if (manaFeedVal > 0)
                    {
                        ApplyPct(manaFeedVal, mana);
                        caster->CastCustomSpell(caster, SPELL_WARLOCK_LIFE_TAP_ENERGIZE_2, &manaFeedVal, nullptr, nullptr, true, nullptr);
                    }
                }
            }

            SpellCastResult CheckCast()
            {
                if ((int32(GetCaster()->GetHealth()) > int32(GetSpellInfo()->Effects[EFFECT_0].CalcValue() + (6.3875 * GetSpellInfo()->BaseLevel) + (GetCaster()->GetStat(STAT_SPIRIT) * 1.5f) + 1.0f )))
                    return SPELL_CAST_OK;
                return SPELL_FAILED_FIZZLE;
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_warl_life_tap_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
                OnCheckCast += SpellCheckCastFn(spell_warl_life_tap_SpellScript::CheckCast);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_warl_life_tap_SpellScript();
        }
};

// 48018 - Demonic Circle: Summon
class spell_warl_demonic_circle_summon : public SpellScriptLoader
{
    public:
        spell_warl_demonic_circle_summon() : SpellScriptLoader("spell_warl_demonic_circle_summon") { }

        class spell_warl_demonic_circle_summon_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_warl_demonic_circle_summon_AuraScript);

            void HandleRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes mode)
            {
                // If effect is removed by expire remove the summoned demonic circle too.
                if (!(mode & AURA_EFFECT_HANDLE_REAPPLY))
                    GetTarget()->RemoveGameObject(GetId(), true);

                GetTarget()->RemoveAura(SPELL_WARLOCK_DEMONIC_CIRCLE_ALLOW_CAST);
            }

            void HandleDummyTick(AuraEffect const* /*aurEff*/)
            {
                if (GameObject* circle = GetTarget()->GetGameObject(GetId()))
                {
                    // Here we check if player is in demonic circle teleport range, if so add
                    // WARLOCK_DEMONIC_CIRCLE_ALLOW_CAST; allowing him to cast the WARLOCK_DEMONIC_CIRCLE_TELEPORT.
                    // If not in range remove the WARLOCK_DEMONIC_CIRCLE_ALLOW_CAST.

                    SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(SPELL_WARLOCK_DEMONIC_CIRCLE_TELEPORT);

                    if (GetTarget()->IsWithinDist(circle, spellInfo->GetMaxRange(true)))
                    {
                        if (!GetTarget()->HasAura(SPELL_WARLOCK_DEMONIC_CIRCLE_ALLOW_CAST))
                            GetTarget()->CastSpell(GetTarget(), SPELL_WARLOCK_DEMONIC_CIRCLE_ALLOW_CAST, true);
                    }
                    else
                        GetTarget()->RemoveAura(SPELL_WARLOCK_DEMONIC_CIRCLE_ALLOW_CAST);
                }
            }

            void Register()
            {
                OnEffectRemove += AuraEffectRemoveFn(spell_warl_demonic_circle_summon_AuraScript::HandleRemove, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY, AURA_EFFECT_HANDLE_REAL_OR_REAPPLY_MASK);
                OnEffectPeriodic += AuraEffectPeriodicFn(spell_warl_demonic_circle_summon_AuraScript::HandleDummyTick, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_warl_demonic_circle_summon_AuraScript();
        }
};

// 48020 - Demonic Circle: Teleport
class spell_warl_demonic_circle_teleport : public SpellScriptLoader
{
    public:
        spell_warl_demonic_circle_teleport() : SpellScriptLoader("spell_warl_demonic_circle_teleport") { }

        class spell_warl_demonic_circle_teleport_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_warl_demonic_circle_teleport_AuraScript);

            void HandleTeleport(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
            {
                if (Player* player = GetTarget()->ToPlayer())
                {
                    if (GameObject* circle = player->GetGameObject(SPELL_WARLOCK_DEMONIC_CIRCLE_SUMMON))
                    {
                        player->NearTeleportTo(circle->GetPositionX(), circle->GetPositionY(), circle->GetPositionZ(), circle->GetOrientation(), false, false, false, true);
                        player->RemoveAurasWithMechanic(1<<MECHANIC_SNARE);
                    }
                }
            }

            void Register()
            {
                OnEffectApply += AuraEffectApplyFn(spell_warl_demonic_circle_teleport_AuraScript::HandleTeleport, EFFECT_0, SPELL_AURA_MECHANIC_IMMUNITY, AURA_EFFECT_HANDLE_REAL);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_warl_demonic_circle_teleport_AuraScript();
        }
};

// -47230 - Fel Synergy
class spell_warl_fel_synergy : public SpellScriptLoader
{
    public:
        spell_warl_fel_synergy() : SpellScriptLoader("spell_warl_fel_synergy") { }

        class spell_warl_fel_synergy_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_warl_fel_synergy_AuraScript);

            bool Validate(SpellInfo const* /*spellInfo*/)
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_WARLOCK_FEL_SYNERGY_HEAL))
                    return false;
                return true;
            }

            bool CheckProc(ProcEventInfo& eventInfo)
            {
                // Xinef: Added charm check
                return (GetTarget()->GetGuardianPet() || GetTarget()->GetCharm()) && eventInfo.GetDamageInfo()->GetDamage();
            }

            void OnProc(AuraEffect const* aurEff, ProcEventInfo& eventInfo)
            {
                PreventDefaultAction();

                int32 heal = CalculatePct(int32(eventInfo.GetDamageInfo()->GetDamage()), aurEff->GetAmount());
                GetTarget()->CastCustomSpell(SPELL_WARLOCK_FEL_SYNERGY_HEAL, SPELLVALUE_BASE_POINT0, heal, (Unit*)NULL, true, NULL, aurEff); // TARGET_UNIT_PET
            }

            void Register()
            {
                DoCheckProc += AuraCheckProcFn(spell_warl_fel_synergy_AuraScript::CheckProc);
                OnEffectProc += AuraEffectProcFn(spell_warl_fel_synergy_AuraScript::OnProc, EFFECT_0, SPELL_AURA_DUMMY);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_warl_fel_synergy_AuraScript();
        }
};

// -48181 - Haunt
class spell_warl_haunt : public SpellScriptLoader
{
    public:
        spell_warl_haunt() : SpellScriptLoader("spell_warl_haunt") { }

        class spell_warl_haunt_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_warl_haunt_SpellScript);

            void HandleAfterHit()
            {
                if (Aura* aura = GetHitAura())
                    if (AuraEffect* aurEff = aura->GetEffect(EFFECT_1))
                        aurEff->SetAmount(CalculatePct(aurEff->GetAmount(), GetHitDamage()));
            }

            void Register()
            {
                AfterHit += SpellHitFn(spell_warl_haunt_SpellScript::HandleAfterHit);
            }
        };

        class spell_warl_haunt_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_warl_haunt_AuraScript);

            bool Validate(SpellInfo const* /*spellInfo*/)
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_WARLOCK_HAUNT_HEAL))
                    return false;
                return true;
            }

            void HandleRemove(AuraEffect const* aurEff, AuraEffectHandleModes /*mode*/)
            {
                if (Unit* caster = GetCaster())
                {
                    int32 amount = aurEff->GetAmount();
                    GetTarget()->CastCustomSpell(caster, SPELL_WARLOCK_HAUNT_HEAL, &amount, nullptr, nullptr, true, NULL, aurEff, GetCasterGUID());
                }
            }

            void Register()
            {
                OnEffectRemove += AuraEffectRemoveFn(spell_warl_haunt_AuraScript::HandleRemove, EFFECT_1, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL_OR_REAPPLY_MASK);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_warl_haunt_SpellScript();
        }

        AuraScript* GetAuraScript() const
        {
            return new spell_warl_haunt_AuraScript();
        }
};

// -30108 - Unstable Affliction
class spell_warl_unstable_affliction : public SpellScriptLoader
{
    public:
        spell_warl_unstable_affliction() : SpellScriptLoader("spell_warl_unstable_affliction") { }

        class spell_warl_unstable_affliction_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_warl_unstable_affliction_AuraScript);

            bool Validate(SpellInfo const* /*spellInfo*/)
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_WARLOCK_UNSTABLE_AFFLICTION_DISPEL))
                    return false;
                return true;
            }

            void HandleDispel(DispelInfo* dispelInfo)
            {
                if (Unit* caster = GetCaster())
                    if (AuraEffect const* aurEff = GetEffect(EFFECT_0))
                    {
                        int32 damage = aurEff->GetBaseAmount();
                        damage = aurEff->GetSpellInfo()->Effects[EFFECT_0].CalcValue(caster, &damage, nullptr) * 9;
                        // backfire damage and silence
                        caster->CastCustomSpell(dispelInfo->GetDispeller(), SPELL_WARLOCK_UNSTABLE_AFFLICTION_DISPEL, &damage, nullptr, nullptr, true, NULL, aurEff);
                    }
            }

            void Register()
            {
                AfterDispel += AuraDispelFn(spell_warl_unstable_affliction_AuraScript::HandleDispel);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_warl_unstable_affliction_AuraScript();
        }
};

// -603 - Curse of Doom
class spell_warl_curse_of_doom : public SpellScriptLoader
{
    public:
        spell_warl_curse_of_doom() : SpellScriptLoader("spell_warl_curse_of_doom") { }

        class spell_warl_curse_of_doom_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_warl_curse_of_doom_AuraScript);

            bool Validate(SpellInfo const* /*spellInfo*/)
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_WARLOCK_CURSE_OF_DOOM_EFFECT))
                    return false;
                return true;
            }

            bool Load()
            {
                return GetCaster() && GetCaster()->GetTypeId() == TYPEID_PLAYER;
            }

            void OnRemove(AuraEffect const* aurEff, AuraEffectHandleModes /*mode*/)
            {
                if (!GetCaster())
                    return;

                AuraRemoveMode removeMode = GetTargetApplication()->GetRemoveMode();
                if (removeMode != AURA_REMOVE_BY_DEATH || !IsExpired())
                    return;

                if (GetCaster()->ToPlayer()->isHonorOrXPTarget(GetTarget()))
                    GetCaster()->CastSpell(GetTarget(), SPELL_WARLOCK_CURSE_OF_DOOM_EFFECT, true, NULL, aurEff);
            }

            void Register()
            {
                 AfterEffectRemove += AuraEffectRemoveFn(spell_warl_curse_of_doom_AuraScript::OnRemove, EFFECT_0, SPELL_AURA_PERIODIC_DAMAGE, AURA_EFFECT_HANDLE_REAL);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_warl_curse_of_doom_AuraScript();
        }
};

// -755 - Health Funnel
class spell_warl_health_funnel : public SpellScriptLoader
{
    public:
        spell_warl_health_funnel() : SpellScriptLoader("spell_warl_health_funnel") { }

        class spell_warl_health_funnel_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_warl_health_funnel_AuraScript);

            void ApplyEffect(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
            {
                Unit* caster = GetCaster();
                if (!caster)
                    return;

                Unit* target = GetTarget();
                if (caster->HasAura(SPELL_WARLOCK_IMPROVED_HEALTH_FUNNEL_R2))
                    target->CastSpell(target, SPELL_WARLOCK_IMPROVED_HEALTH_FUNNEL_BUFF_R2, true);
                else if (caster->HasAura(SPELL_WARLOCK_IMPROVED_HEALTH_FUNNEL_R1))
                    target->CastSpell(target, SPELL_WARLOCK_IMPROVED_HEALTH_FUNNEL_BUFF_R1, true);
            }

            void RemoveEffect(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
            {
                Unit* target = GetTarget();
                target->RemoveAurasDueToSpell(SPELL_WARLOCK_IMPROVED_HEALTH_FUNNEL_BUFF_R1);
                target->RemoveAurasDueToSpell(SPELL_WARLOCK_IMPROVED_HEALTH_FUNNEL_BUFF_R2);
            }

            void Register()
            {
                OnEffectRemove += AuraEffectRemoveFn(spell_warl_health_funnel_AuraScript::RemoveEffect, EFFECT_0, SPELL_AURA_PERIODIC_HEAL, AURA_EFFECT_HANDLE_REAL);
                OnEffectApply += AuraEffectApplyFn(spell_warl_health_funnel_AuraScript::ApplyEffect, EFFECT_0, SPELL_AURA_PERIODIC_HEAL, AURA_EFFECT_HANDLE_REAL);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_warl_health_funnel_AuraScript();
        }
};

// -6229 - Shadow Ward
class spell_warl_shadow_ward : public SpellScriptLoader
{
    public:
        spell_warl_shadow_ward() : SpellScriptLoader("spell_warl_shadow_ward") { }

        class spell_warl_shadow_ward_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_warl_shadow_ward_AuraScript);

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

            void Register()
            {
                DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_warl_shadow_ward_AuraScript::CalculateAmount, EFFECT_0, SPELL_AURA_SCHOOL_ABSORB);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_warl_shadow_ward_AuraScript();
        }
};

// 63310 - Glyph of Shadowflame
class spell_warl_glyph_of_shadowflame : public SpellScriptLoader
{
    public:
        spell_warl_glyph_of_shadowflame() : SpellScriptLoader("spell_warl_glyph_of_shadowflame") { }

        class spell_warl_glyph_of_shadowflame_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_warl_glyph_of_shadowflame_AuraScript);

            bool Validate(SpellInfo const* /*spellInfo*/)
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_WARLOCK_GLYPH_OF_SHADOWFLAME))
                    return false;
                return true;
            }

            void HandleProc(AuraEffect const* aurEff, ProcEventInfo& eventInfo)
            {
                PreventDefaultAction();
                GetTarget()->CastSpell(eventInfo.GetProcTarget(), SPELL_WARLOCK_GLYPH_OF_SHADOWFLAME, true, NULL, aurEff);
            }

            void Register()
            {
                OnEffectProc += AuraEffectProcFn(spell_warl_glyph_of_shadowflame_AuraScript::HandleProc, EFFECT_0, SPELL_AURA_DUMMY);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_warl_glyph_of_shadowflame_AuraScript();
        }
};

void AddSC_warlock_spell_scripts()
{
    // Ours
    new spell_warl_eye_of_kilrogg();
    new spell_warl_shadowflame();
    new spell_warl_seduction();
    new spell_warl_improved_demonic_tactics();
    new spell_warl_ritual_of_summoning();
    new spell_warl_demonic_aegis();
    new spell_warl_demonic_knowledge();
    new spell_warl_generic_scaling();
    new spell_warl_infernal_scaling();

    // Theirs
    new spell_warl_banish();
    new spell_warl_create_healthstone();
    new spell_warl_curse_of_doom();
    new spell_warl_demonic_circle_summon();
    new spell_warl_demonic_circle_teleport();
    new spell_warl_demonic_empowerment();
    new spell_warl_everlasting_affliction();
    new spell_warl_fel_synergy();
    new spell_warl_glyph_of_shadowflame();
    new spell_warl_haunt();
    new spell_warl_health_funnel();
    new spell_warl_life_tap();
    new spell_warl_ritual_of_doom_effect();
    new spell_warl_seed_of_corruption();
    new spell_warl_shadow_ward();
    new spell_warl_siphon_life();
    new spell_warl_soulshatter();
    new spell_warl_unstable_affliction();
}

/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

/*
 * Scripts for spells with SPELLFAMILY_DEATHKNIGHT and SPELLFAMILY_GENERIC spells used by deathknight players.
 * Ordered alphabetically using scriptname.
 * Scriptnames of files in this file should be prefixed with "spell_dk_".
 */

#include "ScriptMgr.h"
#include "SpellScript.h"
#include "SpellAuraEffects.h"
#include "Player.h"
#include "SpellInfo.h"
#include "Totem.h"
#include "PetDefines.h"
#include "UnitAI.h"

enum DeathKnightSpells
{
    // Ours
    SPELL_DK_DEATH_AND_DECAY_TRIGGER            = 52212,
    SPELL_DK_GLYPH_OF_SCOURGE_STRIKE            = 58642,
    SPELL_DK_WANDERING_PLAGUE_TRIGGER           = 50526,
    SPELL_DK_GLYPH_OF_THE_GHOUL                 = 58686,
    SPELL_SHADOWMOURNE_CHAOS_BANE_DAMAGE        = 71904,
    SPELL_SHADOWMOURNE_SOUL_FRAGMENT            = 71905,
    SPELL_SHADOWMOURNE_CHAOS_BANE_BUFF          = 73422,

    // Theirs
    SPELL_DK_ANTI_MAGIC_SHELL_TALENT            = 51052,
    SPELL_DK_BLACK_ICE_R1                       = 49140,
    SPELL_DK_BLOOD_BOIL_TRIGGERED               = 65658,
    SPELL_DK_BLOOD_GORGED_HEAL                  = 50454,
    SPELL_DK_BLOOD_PRESENCE                     = 48266,
    SPELL_DK_CORPSE_EXPLOSION_TRIGGERED         = 43999,
    SPELL_DK_CORPSE_EXPLOSION_VISUAL            = 51270,
    SPELL_DK_DEATH_COIL_DAMAGE                  = 47632,
    SPELL_DK_DEATH_COIL_HEAL                    = 47633,
    SPELL_DK_DEATH_STRIKE_HEAL                  = 45470,
    SPELL_DK_FROST_FEVER                        = 55095,
    SPELL_DK_FROST_PRESENCE                     = 48263,
    SPELL_DK_FROST_PRESENCE_TRIGGERED           = 61261,
    SPELL_DK_GHOUL_EXPLODE                      = 47496,
    SPELL_DK_GLYPH_OF_DISEASE                   = 63334,
    SPELL_DK_GLYPH_OF_ICEBOUND_FORTITUDE        = 58625,
    SPELL_DK_IMPROVED_BLOOD_PRESENCE_R1         = 50365,
    SPELL_DK_IMPROVED_FROST_PRESENCE_R1         = 50384,
    SPELL_DK_IMPROVED_UNHOLY_PRESENCE_R1        = 50391,
    SPELL_DK_IMPROVED_BLOOD_PRESENCE_TRIGGERED  = 63611,
    SPELL_DK_IMPROVED_UNHOLY_PRESENCE_TRIGGERED = 63622,
    SPELL_DK_ITEM_SIGIL_VENGEFUL_HEART          = 64962,
    SPELL_DK_ITEM_T8_MELEE_4P_BONUS             = 64736,
    SPELL_DK_MASTER_OF_GHOULS                   = 52143,
    SPELL_DK_BLOOD_PLAGUE                       = 55078,
    SPELL_DK_RAISE_DEAD_USE_REAGENT             = 48289,
    SPELL_DK_RUNIC_POWER_ENERGIZE               = 49088,
    SPELL_DK_SCENT_OF_BLOOD                     = 50422,
    SPELL_DK_SCOURGE_STRIKE_TRIGGERED           = 70890,
    SPELL_DK_UNHOLY_PRESENCE                    = 48265,
    SPELL_DK_UNHOLY_PRESENCE_TRIGGERED          = 49772,
    SPELL_DK_WILL_OF_THE_NECROPOLIS_TALENT_R1   = 49189,
    SPELL_DK_WILL_OF_THE_NECROPOLIS_AURA_R1     = 52284
};

enum DeathKnightSpellIcons
{
    DK_ICON_ID_IMPROVED_DEATH_STRIKE            = 2751
};

enum Misc
{
    NPC_DK_GHOUL                                = 26125
};

// Ours
class spell_dk_wandering_plague : public SpellScriptLoader
{
    public:
        spell_dk_wandering_plague() : SpellScriptLoader("spell_dk_wandering_plague") { }

        class spell_dk_wandering_plague_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_dk_wandering_plague_SpellScript);

            void FilterTargets(std::list<WorldObject*>& targets)
            {
                static const AuraType ccAuras[] =
                {
                    SPELL_AURA_MOD_CONFUSE,
                    SPELL_AURA_MOD_FEAR,
                    SPELL_AURA_MOD_STUN,
                    SPELL_AURA_MOD_ROOT,
                    SPELL_AURA_TRANSFORM,
                    SPELL_AURA_NONE
                };

                for (std::list<WorldObject*>::iterator itr = targets.begin(); itr != targets.end();)
                {
                    Unit* target = (*itr)->ToUnit();
                    if (!target)
                    {
                        targets.erase(itr++);
                        continue;
                    }

                    bool skip = false;
                    for (uint8 index = 0; !skip && ccAuras[index] != SPELL_AURA_NONE; ++index)
                    {
                        Unit::AuraEffectList const& auras = target->GetAuraEffectsByType(ccAuras[index]);
                        for (Unit::AuraEffectList::const_iterator i = auras.begin(); i != auras.end(); ++i)
                            if ((*i)->GetAmount())
                            {
                                skip = true;
                                break;
                            }
                    }

                    if (skip)
                        targets.erase(itr++);
                    else
                        ++itr;
                }
            }

            void Register()
            {
                OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_dk_wandering_plague_SpellScript::FilterTargets, EFFECT_0, TARGET_UNIT_DEST_AREA_ENEMY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_dk_wandering_plague_SpellScript();
        }
};

class spell_dk_raise_ally : public SpellScriptLoader
{
    public:
        spell_dk_raise_ally() : SpellScriptLoader("spell_dk_raise_ally") { }

        class spell_dk_raise_ally_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_dk_raise_ally_SpellScript);

            void HandleDummy(SpellEffIndex /*effIndex*/)
            {
                if (Player* unitTarget = GetHitPlayer())
                {
                    unitTarget->CastSpell(unitTarget, GetEffectValue(), true);
                    if (Unit* ghoul = unitTarget->GetCharm())
                    {
                        //health, mana, armor and resistance
                        PetLevelInfo const* pInfo = sObjectMgr->GetPetLevelInfo(ghoul->GetEntry(), ghoul->getLevel());
                        if (pInfo)                                      // exist in DB
                        {
                            ghoul->SetCreateHealth(pInfo->health);
                            ghoul->SetModifierValue(UNIT_MOD_HEALTH, BASE_VALUE, pInfo->health);
                            ghoul->SetModifierValue(UNIT_MOD_ARMOR, BASE_VALUE, float(pInfo->armor));
                            for (uint8 stat = 0; stat < MAX_STATS; ++stat)
                                ghoul->SetCreateStat(Stats(stat), float(pInfo->stats[stat]));
                        }

                        ghoul->SetBaseWeaponDamage(BASE_ATTACK, MINDAMAGE, float(ghoul->getLevel() - (ghoul->getLevel() / 4)));
                        ghoul->SetBaseWeaponDamage(BASE_ATTACK, MAXDAMAGE, float(ghoul->getLevel() + (ghoul->getLevel() / 4)));

                        // Avoidance, Night of the Dead
                        if (Aura *aur = ghoul->AddAura(62137, ghoul))
                            if (AuraEffect *aurEff = GetCaster()->GetAuraEffect(SPELL_AURA_ADD_FLAT_MODIFIER, SPELLFAMILY_DEATHKNIGHT, 2718, 0))
                                if (aur->GetEffect(0))
                                    aur->GetEffect(0)->SetAmount(-aurEff->GetSpellInfo()->Effects[EFFECT_2].CalcValue());

                        // Hit / Expertise scalling, warlock / hunter pets have this by default
                        ghoul->AddAura(SPELL_HUNTER_PET_SCALING_04, ghoul);

                        // DK Ghoul haste refresh
                        float val = (GetCaster()->m_modAttackSpeedPct[BASE_ATTACK] - 1.0f) * 100.0f;
                        ghoul->m_modAttackSpeedPct[BASE_ATTACK] = GetCaster()->m_modAttackSpeedPct[BASE_ATTACK];
                        ghoul->SetFloatValue(UNIT_FIELD_BASEATTACKTIME, 2000.0f);
                        ghoul->ApplyPercentModFloatValue(UNIT_FIELD_BASEATTACKTIME, val, true); // we want to reduce attack time

                        // Strength + Stamina
                        for (uint8 i = STAT_STRENGTH; i <= STAT_STAMINA; ++i)
                        {
                            Stats stat = Stats(i);
                            if (stat != STAT_STRENGTH && stat != STAT_STAMINA)
                                continue;

                            float value = 0.0f;
                            float mod = (stat == STAT_STAMINA ? 0.3f : 0.7f);

                            // Check just if owner has Ravenous Dead since it's effect is not an aura
                            AuraEffect const* aurEff = GetCaster()->GetAuraEffect(SPELL_AURA_MOD_TOTAL_STAT_PERCENTAGE, SPELLFAMILY_DEATHKNIGHT, 3010, 0);
                            if (aurEff)
                            {
                                SpellInfo const* spellInfo = aurEff->GetSpellInfo();                                                 // Then get the SpellProto and add the dummy effect value
                                AddPct(mod, spellInfo->Effects[EFFECT_1].CalcValue());                                              // Ravenous Dead edits the original scale
                            }
                            // Glyph of the Ghoul
                            aurEff = GetCaster()->GetAuraEffect(SPELL_DK_GLYPH_OF_THE_GHOUL, EFFECT_0);
                            if (aurEff)
                                mod += CalculatePct(1.0f, aurEff->GetAmount());                                                    // Glyph of the Ghoul adds a flat value to the scale mod

                            value = float(GetCaster()->GetStat(stat)) * mod;
                            value = ghoul->GetTotalStatValue(stat, value);
                            ghoul->SetStat(stat, int32(value));
                            ghoul->ApplyStatBuffMod(stat, value, true);
                        }

                        // Attack Power
                        ghoul->SetModifierValue(UNIT_MOD_ATTACK_POWER, BASE_VALUE, 589 + ghoul->GetStat(STAT_STRENGTH) + ghoul->GetStat(STAT_AGILITY));
                        ghoul->SetInt32Value(UNIT_FIELD_ATTACK_POWER, (int32)ghoul->GetModifierValue(UNIT_MOD_ATTACK_POWER, BASE_VALUE) * ghoul->GetModifierValue(UNIT_MOD_ATTACK_POWER, BASE_PCT));
                        ghoul->SetInt32Value(UNIT_FIELD_ATTACK_POWER_MODS, (int32)ghoul->GetModifierValue(UNIT_MOD_ATTACK_POWER, TOTAL_VALUE));
                        ghoul->SetFloatValue(UNIT_FIELD_ATTACK_POWER_MULTIPLIER, ghoul->GetModifierValue(UNIT_MOD_ATTACK_POWER, TOTAL_PCT) - 1.0f);

                        // Health
                        ghoul->SetModifierValue(UNIT_MOD_HEALTH, TOTAL_VALUE, (ghoul->GetStat(STAT_STAMINA) - ghoul->GetCreateStat(STAT_STAMINA))*10.0f);

                        // Power Energy
                        ghoul->SetModifierValue(UnitMods(UNIT_MOD_POWER_START+POWER_ENERGY), BASE_VALUE, ghoul->GetCreatePowers(POWER_ENERGY));
                        ghoul->UpdateAllStats();
                        ghoul->SetFullHealth();

                        // Aura Immunities
                        ghoul->ApplySpellImmune(0, IMMUNITY_STATE, SPELL_AURA_MOD_MELEE_RANGED_HASTE, true, SPELL_BLOCK_TYPE_POSITIVE);
                        ghoul->ApplySpellImmune(0, IMMUNITY_STATE, SPELL_AURA_MELEE_SLOW, true, SPELL_BLOCK_TYPE_POSITIVE);
                        ghoul->ApplySpellImmune(0, IMMUNITY_STATE, SPELL_AURA_MOD_STAT, true, SPELL_BLOCK_TYPE_POSITIVE);
                        ghoul->ApplySpellImmune(0, IMMUNITY_STATE, SPELL_AURA_MOD_TOTAL_STAT_PERCENTAGE, true, SPELL_BLOCK_TYPE_POSITIVE);
                        ghoul->ApplySpellImmune(0, IMMUNITY_STATE, SPELL_AURA_MOD_ATTACK_POWER, true, SPELL_BLOCK_TYPE_POSITIVE);
                        ghoul->ApplySpellImmune(0, IMMUNITY_STATE, SPELL_AURA_MOD_ATTACK_POWER_PCT, true, SPELL_BLOCK_TYPE_POSITIVE);
                    }
                }
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_dk_raise_ally_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_dk_raise_ally_SpellScript();
        }
};

class spell_dk_raise_ally_trigger : public SpellScriptLoader
{
    public:
        spell_dk_raise_ally_trigger() : SpellScriptLoader("spell_dk_raise_ally_trigger") { }

        class spell_dk_raise_ally_trigger_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_dk_raise_ally_trigger_AuraScript);

            void HandleEffectRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
            {
                if (Unit* charm = GetUnitOwner()->GetCharm())
                    if (GetSpellInfo()->Effects[EFFECT_0].MiscValue >= 0 && charm->GetEntry() == uint32(GetSpellInfo()->Effects[EFFECT_0].MiscValue))
                        charm->ToCreature()->DespawnOrUnsummon();
            }

            void Register()
            {
                 OnEffectRemove += AuraEffectRemoveFn(spell_dk_raise_ally_trigger_AuraScript::HandleEffectRemove, EFFECT_1, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_dk_raise_ally_trigger_AuraScript();
        }
};

class spell_dk_aotd_taunt : public SpellScriptLoader
{
    public:
        spell_dk_aotd_taunt() : SpellScriptLoader("spell_dk_aotd_taunt") { }

        class spell_dk_aotd_taunt_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_dk_aotd_taunt_SpellScript);

            void FilterTargets(std::list<WorldObject*>& targets)
            {
                for (std::list<WorldObject*>::iterator itr = targets.begin(); itr != targets.end();)
                {
                    // ignore bosses
                    if (Creature* cr = (*itr)->ToCreature())
                        if (cr->isWorldBoss())
                        {
                            targets.erase(itr++);
                            continue;
                        }

                    ++itr;
                }
            }

            void Register()
            {
                OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_dk_aotd_taunt_SpellScript::FilterTargets, EFFECT_ALL, TARGET_UNIT_SRC_AREA_ENEMY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_dk_aotd_taunt_SpellScript();
        }
};

class spell_dk_death_and_decay : public SpellScriptLoader
{
    public:
        spell_dk_death_and_decay() : SpellScriptLoader("spell_dk_death_and_decay") { }

        class spell_dk_death_and_decay_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_dk_death_and_decay_SpellScript);

            void RecalculateDamage()
            {
                Unit* caster = GetCaster();
                Unit* target = GetHitUnit();
                int32 damage = GetHitDamage();

                // T10P2 bonus
                if (AuraEffect* aurEff = caster->GetAuraEffectDummy(70650))
                    AddPct(damage, aurEff->GetAmount());
                // Glyph of Death and Decay
                if (AuraEffect* aurEff = caster->GetAuraEffect(58629, EFFECT_0))
                    AddPct(damage, aurEff->GetAmount());

                // Xinef: include AOE damage reducing auras
                if (target)
                    damage = target->CalculateAOEDamageReduction(damage, GetSpellInfo()->SchoolMask, caster);

                SetHitDamage(damage);
            }

            void Register()
            {
                if (m_scriptSpellId == SPELL_DK_DEATH_AND_DECAY_TRIGGER)
                    OnHit += SpellHitFn(spell_dk_death_and_decay_SpellScript::RecalculateDamage);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_dk_death_and_decay_SpellScript();
        }

        class spell_dk_death_and_decay_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_dk_death_and_decay_AuraScript);

            void HandlePeriodic(AuraEffect const* aurEff)
            {
                PreventDefaultAction();
                if (GetCaster() && GetTarget())
                {
                    int32 basePoints0 = aurEff->GetAmount();
                    GetCaster()->CastCustomSpell(GetTarget(), SPELL_DK_DEATH_AND_DECAY_TRIGGER, &basePoints0, NULL, NULL, true, 0, aurEff);
                }
            }

            void Register()
            {
                if (m_scriptSpellId != SPELL_DK_DEATH_AND_DECAY_TRIGGER)
                    OnEffectPeriodic += AuraEffectPeriodicFn(spell_dk_death_and_decay_AuraScript::HandlePeriodic, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_dk_death_and_decay_AuraScript();
        }
};

class spell_dk_master_of_ghouls : public SpellScriptLoader
{
    public:
        spell_dk_master_of_ghouls() : SpellScriptLoader("spell_dk_master_of_ghouls") { }

        class spell_dk_master_of_ghouls_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_dk_master_of_ghouls_AuraScript);

            void HandleEffectApply(AuraEffect const*  /*aurEff*/, AuraEffectHandleModes /*mode*/)
            {
                Unit* target = GetTarget();
                if (target->GetTypeId() == TYPEID_PLAYER)
                    target->ToPlayer()->SetShowDKPet(true);
            }

            void HandleEffectRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
            {
                Unit* target = GetTarget();
                if (target->GetTypeId() == TYPEID_PLAYER)
                    target->ToPlayer()->SetShowDKPet(false);
            }

            void Register()
            {
                 OnEffectApply += AuraEffectApplyFn(spell_dk_master_of_ghouls_AuraScript::HandleEffectApply, EFFECT_0, SPELL_AURA_ADD_FLAT_MODIFIER, AURA_EFFECT_HANDLE_REAL);
                 OnEffectRemove += AuraEffectRemoveFn(spell_dk_master_of_ghouls_AuraScript::HandleEffectRemove, EFFECT_0, SPELL_AURA_ADD_FLAT_MODIFIER, AURA_EFFECT_HANDLE_REAL);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_dk_master_of_ghouls_AuraScript();
        }
};

class spell_dk_chains_of_ice : public SpellScriptLoader
{
    public:
        spell_dk_chains_of_ice() : SpellScriptLoader("spell_dk_chains_of_ice") { }

        class spell_dk_chains_of_ice_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_dk_chains_of_ice_SpellScript);

            void HandleAfterCast()
            {
                if (Unit* target = GetExplTargetUnit())
                {
                    std::list<Spell::TargetInfo> const* targetsInfo = GetSpell()->GetUniqueTargetInfo();
                    for (std::list<Spell::TargetInfo>::const_iterator ihit = targetsInfo->begin(); ihit != targetsInfo->end(); ++ihit)
                        if (ihit->missCondition == SPELL_MISS_NONE && ihit->targetGUID == target->GetGUID())
                            GetCaster()->CastSpell(target, 55095 /*SPELL_FROST_FEVER*/, true);
                }
            }

            void Register()
            {
                AfterCast += SpellCastFn(spell_dk_chains_of_ice_SpellScript::HandleAfterCast);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_dk_chains_of_ice_SpellScript();
        }

        class spell_dk_chains_of_ice_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_dk_chains_of_ice_AuraScript);

            void HandlePeriodic(AuraEffect* aurEff)
            {
                // Get 0 effect aura
                if (AuraEffect* slow = GetAura()->GetEffect(0))
                {
                    int32 newAmount = slow->GetAmount() + aurEff->GetAmount();
                    if (newAmount > 0)
                        newAmount = 0;
                    slow->ChangeAmount(newAmount);
                }
            }

            void Register()
            {
                OnEffectUpdatePeriodic += AuraEffectUpdatePeriodicFn(spell_dk_chains_of_ice_AuraScript::HandlePeriodic, EFFECT_1, SPELL_AURA_PERIODIC_DUMMY);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_dk_chains_of_ice_AuraScript();
        }
};

class spell_dk_bloodworms : public SpellScriptLoader
{
    public:
        spell_dk_bloodworms() : SpellScriptLoader("spell_dk_bloodworms") { }

        class spell_dk_bloodworms_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_dk_bloodworms_SpellScript);

            void HandleSummon(SpellEffIndex /*effIndex*/)
            {
                SetEffectValue(irand(2, 4));
            }

            void Register()
            {
                OnEffectHit += SpellEffectFn(spell_dk_bloodworms_SpellScript::HandleSummon, EFFECT_0, SPELL_EFFECT_SUMMON);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_dk_bloodworms_SpellScript();
        }
};

class spell_dk_summon_gargoyle : public SpellScriptLoader
{
    public:
        spell_dk_summon_gargoyle() : SpellScriptLoader("spell_dk_summon_gargoyle") { }

        class spell_dk_summon_gargoyle_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_dk_summon_gargoyle_SpellScript);

            void SetDest(SpellDestination& dest)
            {
                // Adjust effect summon position
                if (GetCaster()->IsWithinLOS(dest._position.GetPositionX(), dest._position.GetPositionY(), dest._position.GetPositionZ()+15.0f))
                    dest._position.m_positionZ += 15.0f;
            }

            void Register()
            {
                OnDestinationTargetSelect += SpellDestinationTargetSelectFn(spell_dk_summon_gargoyle_SpellScript::SetDest, EFFECT_0, TARGET_DEST_CASTER_FRONT_LEFT);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_dk_summon_gargoyle_SpellScript();
        }
};

class spell_dk_improved_blood_presence_proc : public SpellScriptLoader
{
    public:
        spell_dk_improved_blood_presence_proc() : SpellScriptLoader("spell_dk_improved_blood_presence_proc") { }

        class spell_dk_improved_blood_presence_proc_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_dk_improved_blood_presence_proc_AuraScript);

            bool CheckProc(ProcEventInfo& eventInfo)
            {
                return eventInfo.GetDamageInfo()->GetDamage();
            }

            void Register()
            {
                DoCheckProc += AuraCheckProcFn(spell_dk_improved_blood_presence_proc_AuraScript::CheckProc);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_dk_improved_blood_presence_proc_AuraScript();
        }
};

class spell_dk_wandering_plague_aura : public SpellScriptLoader
{
    public:
        spell_dk_wandering_plague_aura() : SpellScriptLoader("spell_dk_wandering_plague_aura") { }

        class spell_dk_wandering_plague_aura_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_dk_wandering_plague_aura_AuraScript);

            bool CheckProc(ProcEventInfo& eventInfo)
            {
                const SpellInfo* spellInfo = eventInfo.GetDamageInfo()->GetSpellInfo();
                if (!spellInfo || !eventInfo.GetActionTarget())
                    return false;

                if (!roll_chance_f(eventInfo.GetActor()->GetUnitCriticalChance(BASE_ATTACK, eventInfo.GetActionTarget())))
                    return false;

                return !eventInfo.GetActor()->HasSpellCooldown(SPELL_DK_WANDERING_PLAGUE_TRIGGER);
            }

            // xinef: prevent default proc with castItem passed, which applies 30 sec cooldown to procing of the aura
            void HandleProc(AuraEffect const* aurEff, ProcEventInfo& eventInfo)
            {
                PreventDefaultAction();
                
                eventInfo.GetActor()->AddSpellCooldown(SPELL_DK_WANDERING_PLAGUE_TRIGGER, 0, 1000);
                eventInfo.GetActor()->CastCustomSpell(SPELL_DK_WANDERING_PLAGUE_TRIGGER, SPELLVALUE_BASE_POINT0, CalculatePct<int32, int32>(eventInfo.GetDamageInfo()->GetDamage(), aurEff->GetAmount()), eventInfo.GetActionTarget(), TRIGGERED_FULL_MASK);
            }

            void Register()
            {
                DoCheckProc += AuraCheckProcFn(spell_dk_wandering_plague_aura_AuraScript::CheckProc);
                OnEffectProc += AuraEffectProcFn(spell_dk_wandering_plague_aura_AuraScript::HandleProc, EFFECT_0, SPELL_AURA_DUMMY);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_dk_wandering_plague_aura_AuraScript();
        }
};

class spell_dk_rune_of_the_fallen_crusader : public SpellScriptLoader
{
    public:
        spell_dk_rune_of_the_fallen_crusader() : SpellScriptLoader("spell_dk_rune_of_the_fallen_crusader") { }

        class spell_dk_rune_of_the_fallen_crusader_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_dk_rune_of_the_fallen_crusader_SpellScript);

            void RecalculateDamage()
            {
                std::list<Spell::TargetInfo>* targetsInfo = GetSpell()->GetUniqueTargetInfo();
                for (std::list<Spell::TargetInfo>::iterator ihit = targetsInfo->begin(); ihit != targetsInfo->end(); ++ihit)
                    if (ihit->targetGUID == GetCaster()->GetGUID())
                        ihit->crit = roll_chance_f(GetCaster()->GetFloatValue(PLAYER_CRIT_PERCENTAGE));
            }

            void Register()
            {
                OnHit += SpellHitFn(spell_dk_rune_of_the_fallen_crusader_SpellScript::RecalculateDamage);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_dk_rune_of_the_fallen_crusader_SpellScript();
        }
};

class spell_dk_bone_shield : public SpellScriptLoader
{
    public:
        spell_dk_bone_shield() : SpellScriptLoader("spell_dk_bone_shield") { }

        class spell_dk_bone_shield_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_dk_bone_shield_AuraScript);

            void HandleProc(ProcEventInfo& eventInfo)
            {
                PreventDefaultAction();
                if (!eventInfo.GetDamageInfo()->GetSpellInfo() || !eventInfo.GetDamageInfo()->GetSpellInfo()->IsTargetingArea())
                    DropCharge();
            }

            void Register()
            {
                OnProc += AuraProcFn(spell_dk_bone_shield_AuraScript::HandleProc);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_dk_bone_shield_AuraScript();
        }
};

class spell_dk_hungering_cold : public SpellScriptLoader
{
    public:
        spell_dk_hungering_cold() : SpellScriptLoader("spell_dk_hungering_cold") { }

        class spell_dk_hungering_cold_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_dk_hungering_cold_AuraScript);

            void HandleProc(ProcEventInfo& eventInfo)
            {
                PreventDefaultAction();
                if (eventInfo.GetDamageInfo()->GetDamage() > 0 && (!eventInfo.GetDamageInfo()->GetSpellInfo() || eventInfo.GetDamageInfo()->GetSpellInfo()->Dispel != DISPEL_DISEASE))
                    SetDuration(0);
            }

            void Register()
            {
                OnProc += AuraProcFn(spell_dk_hungering_cold_AuraScript::HandleProc);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_dk_hungering_cold_AuraScript();
        }
};

class spell_dk_blood_caked_blade : public SpellScriptLoader
{
    public:
        spell_dk_blood_caked_blade() : SpellScriptLoader("spell_dk_blood_caked_blade") { }

        class spell_dk_blood_caked_blade_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_dk_blood_caked_blade_AuraScript);

            bool CheckProc(ProcEventInfo& eventInfo)
            {
                return eventInfo.GetActionTarget() && eventInfo.GetActionTarget()->IsAlive();
            }

            void HandleProc(AuraEffect const* aurEff, ProcEventInfo& eventInfo)
            {
                PreventDefaultAction();
                eventInfo.GetActor()->CastSpell(eventInfo.GetActionTarget(), aurEff->GetSpellInfo()->Effects[EFFECT_0].TriggerSpell, true, NULL, aurEff);

                // Xinef: Shadowmourne hack (blood-caked blade trigger proc disabled...)
                if (roll_chance_i(75) && eventInfo.GetActor()->FindMap() && !eventInfo.GetActor()->FindMap()->IsBattlegroundOrArena() && eventInfo.GetActor()->HasAura(71903) && !eventInfo.GetActor()->HasAura(SPELL_SHADOWMOURNE_CHAOS_BANE_BUFF))
                {
                    eventInfo.GetActor()->CastSpell(eventInfo.GetActor(), SPELL_SHADOWMOURNE_SOUL_FRAGMENT, true);

                    // this can't be handled in AuraScript of SoulFragments because we need to know victim
                    if (Aura* soulFragments = eventInfo.GetActor()->GetAura(SPELL_SHADOWMOURNE_SOUL_FRAGMENT))
                    {
                        if (soulFragments->GetStackAmount() >= 10)
                        {
                            eventInfo.GetActor()->CastSpell(eventInfo.GetActor(), SPELL_SHADOWMOURNE_CHAOS_BANE_DAMAGE, true, NULL);
                            soulFragments->Remove();
                        }
                    }
                }
            }

            void Register()
            {
                DoCheckProc += AuraCheckProcFn(spell_dk_blood_caked_blade_AuraScript::CheckProc);
                OnEffectProc += AuraEffectProcFn(spell_dk_blood_caked_blade_AuraScript::HandleProc, EFFECT_0, SPELL_AURA_DUMMY);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_dk_blood_caked_blade_AuraScript();
        }
};

class spell_dk_dancing_rune_weapon : public SpellScriptLoader
{
    public:
        spell_dk_dancing_rune_weapon() : SpellScriptLoader("spell_dk_dancing_rune_weapon") { }

        class spell_dk_dancing_rune_weapon_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_dk_dancing_rune_weapon_AuraScript);

            bool CheckProc(ProcEventInfo& eventInfo)
            {
                if (!eventInfo.GetActor() || !eventInfo.GetActionTarget() || !eventInfo.GetActionTarget()->IsAlive() || eventInfo.GetActor()->GetTypeId() != TYPEID_PLAYER)
                    return false;

                const SpellInfo* spellInfo = eventInfo.GetDamageInfo()->GetSpellInfo();
                if (!spellInfo)
                    return true;

                // Death Coil exception, Check if spell is from spellbook
                if (spellInfo->Id != SPELL_DK_DEATH_COIL_DAMAGE && !eventInfo.GetActor()->ToPlayer()->HasActiveSpell(spellInfo->Id))
                    return false;
                
                // Can't cast raise dead/ally, death grip, dark command, death pact, death and decay, anti-magic shell
                if (spellInfo->SpellFamilyFlags.HasFlag(0x20A1220, 0x10000000, 0x0))
                    return false;

                // AoE can be cast only once
                if (spellInfo->IsTargetingArea() && eventInfo.GetActor() != eventInfo.GetActionTarget())
                    return false;

                // No spells with summoning
                if (spellInfo->HasEffect(SPELL_EFFECT_SUMMON))
                    return false;

                // No Positive Spells
                if (spellInfo->IsPositive())
                    return false;

                return true;
            }

            void HandleProc(AuraEffect const* aurEff, ProcEventInfo& eventInfo)
            {
                PreventDefaultAction();

                Unit* player = eventInfo.GetActor();
                Unit* target = eventInfo.GetActionTarget();
                Unit* dancingRuneWeapon = NULL;
                for (Unit::ControlSet::const_iterator itr = player->m_Controlled.begin(); itr != player->m_Controlled.end(); ++itr)
                    if (int32((*itr)->GetEntry()) == GetSpellInfo()->Effects[EFFECT_0].MiscValue)
                    {
                        dancingRuneWeapon = *itr;
                        break;
                    }
                
                if (!dancingRuneWeapon)
                    return;

                dancingRuneWeapon->SetOrientation(dancingRuneWeapon->GetAngle(target));
                if (const SpellInfo* procSpell = eventInfo.GetDamageInfo()->GetSpellInfo())
                {
                    // xinef: ugly hack
                    if (!procSpell->IsAffectingArea())
                        GetUnitOwner()->SetFloatValue(UNIT_FIELD_COMBATREACH, 10.0f);
                    dancingRuneWeapon->CastSpell(target, procSpell->Id, true, NULL, aurEff, dancingRuneWeapon->GetGUID());
                    GetUnitOwner()->SetFloatValue(UNIT_FIELD_COMBATREACH, 0.01f);
                }
                else
                {
                    target = player->GetMeleeHitRedirectTarget(target);
                    CalcDamageInfo damageInfo;
                    player->CalculateMeleeDamage(target, 0, &damageInfo, eventInfo.GetDamageInfo()->GetAttackType());
                    Unit::DealDamageMods(target, damageInfo.damage, &damageInfo.absorb);
                    damageInfo.attacker = dancingRuneWeapon;
                    damageInfo.damage /= 2.0f;
                    dancingRuneWeapon->SendAttackStateUpdate(&damageInfo);
                    dancingRuneWeapon->DealMeleeDamage(&damageInfo, true);
                }
            }

            void Register()
            {
                DoCheckProc += AuraCheckProcFn(spell_dk_dancing_rune_weapon_AuraScript::CheckProc);
                OnEffectProc += AuraEffectProcFn(spell_dk_dancing_rune_weapon_AuraScript::HandleProc, EFFECT_1, SPELL_AURA_DUMMY);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_dk_dancing_rune_weapon_AuraScript();
        }
};

class spell_dk_dancing_rune_weapon_visual : public SpellScriptLoader
{
    public:
        spell_dk_dancing_rune_weapon_visual() : SpellScriptLoader("spell_dk_dancing_rune_weapon_visual") { }

        class spell_dk_dancing_rune_weapon_visual_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_dk_dancing_rune_weapon_visual_AuraScript);

            void HandleEffectApply(AuraEffect const*  /*aurEff*/, AuraEffectHandleModes /*mode*/)
            {
                PreventDefaultAction();
                if (Unit* owner = GetUnitOwner()->ToTempSummon()->GetSummoner())
                {
                    GetUnitOwner()->SetUInt32Value(UNIT_VIRTUAL_ITEM_SLOT_ID, owner->GetUInt32Value(PLAYER_VISIBLE_ITEM_16_ENTRYID));
                    GetUnitOwner()->SetUInt32Value(UNIT_VIRTUAL_ITEM_SLOT_ID+1, owner->GetUInt32Value(PLAYER_VISIBLE_ITEM_17_ENTRYID));
                    GetUnitOwner()->SetFloatValue(UNIT_FIELD_COMBATREACH, 0.01f);
                }
            }

            void Register()
            {
                OnEffectApply += AuraEffectApplyFn(spell_dk_dancing_rune_weapon_visual_AuraScript::HandleEffectApply, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_dk_dancing_rune_weapon_visual_AuraScript();
        }
};

class spell_dk_scent_of_blood_trigger : public SpellScriptLoader
{
    public:
        spell_dk_scent_of_blood_trigger() : SpellScriptLoader("spell_dk_scent_of_blood_trigger") { }

        class spell_dk_scent_of_blood_trigger_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_dk_scent_of_blood_trigger_AuraScript);

            bool CheckProc(ProcEventInfo& eventInfo)
            {
                return (eventInfo.GetHitMask() & (PROC_EX_DODGE|PROC_EX_PARRY)) || eventInfo.GetDamageInfo()->GetDamage();
            }

            void Register()
            {
                DoCheckProc += AuraCheckProcFn(spell_dk_scent_of_blood_trigger_AuraScript::CheckProc);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_dk_scent_of_blood_trigger_AuraScript();
        }
};

class spell_dk_pet_scaling : public SpellScriptLoader
{
    public:
        spell_dk_pet_scaling() : SpellScriptLoader("spell_dk_pet_scaling") { }

        class spell_dk_pet_scaling_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_dk_pet_scaling_AuraScript);

            void CalculateStatAmount(AuraEffect const* aurEff, int32 & amount, bool & /*canBeRecalculated*/)
            {
                Stats stat = Stats(aurEff->GetSpellInfo()->Effects[aurEff->GetEffIndex()].MiscValue);

                // xinef: dk ghoul inherits 70% of strength and 30% of stamina
                if (GetUnitOwner()->GetEntry() != NPC_RISEN_GHOUL)
                {
                    // xinef: ebon garogyle - inherit 30% of stamina
                    if (GetUnitOwner()->GetEntry() == NPC_EBON_GARGOYLE && stat == STAT_STAMINA)
                        if (Unit* owner = GetUnitOwner()->GetOwner())
                            amount = CalculatePct(std::max<int32>(0, owner->GetStat(stat)), 30);
                    return;
                }

                if (Unit* owner = GetUnitOwner()->GetOwner())
                {
                    int32 modifier = stat == STAT_STRENGTH ? 70 : 30;

                    // Check just if owner has Ravenous Dead since it's effect is not an aura
                    if (AuraEffect const* rdEff = owner->GetAuraEffect(SPELL_AURA_MOD_TOTAL_STAT_PERCENTAGE, SPELLFAMILY_DEATHKNIGHT, 3010, 0))
                    {
                        SpellInfo const* spellInfo = rdEff->GetSpellInfo();                                                 // Then get the SpellProto and add the dummy effect value
                        AddPct(modifier, spellInfo->Effects[EFFECT_1].CalcValue());                                          // Ravenous Dead edits the original scale
                    }

                    // xinef: Glyph of the Ghoul
                    if (AuraEffect const* glyphEff = owner->GetAuraEffect(SPELL_DK_GLYPH_OF_THE_GHOUL, EFFECT_0))
                        modifier += glyphEff->GetAmount();

                    amount = CalculatePct(std::max<int32>(0, owner->GetStat(stat)), modifier);
                }
            }

            void CalculateSPAmount(AuraEffect const*  /*aurEff*/, int32 & amount, bool & /*canBeRecalculated*/)
            {
                // xinef: dk gargoyle inherits 33% of SP
                if (GetUnitOwner()->GetEntry() != NPC_EBON_GARGOYLE)
                    return;

                if (Unit* owner = GetUnitOwner()->GetOwner())
                {
                    int32 modifier = 33;

                    // xinef: impurity
                    if (owner->GetDummyAuraEffect(SPELLFAMILY_DEATHKNIGHT, 1986, 0))
                        modifier = 40;

                    amount = CalculatePct(std::max<int32>(0, owner->GetTotalAttackPowerValue(BASE_ATTACK)), modifier);

                    // xinef: Update appropriate player field
                    if (owner->GetTypeId() == TYPEID_PLAYER)
                        owner->SetUInt32Value(PLAYER_PET_SPELL_POWER, (uint32)amount);
                }
            }

            void CalculateHasteAmount(AuraEffect const*  /*aurEff*/, int32 & amount, bool & /*canBeRecalculated*/)
            {
                // xinef: scale haste with owners melee haste
                if (Unit* owner = GetUnitOwner()->GetOwner())
                    if (owner->m_modAttackSpeedPct[BASE_ATTACK] < 1.0f) // inherit haste only
                        amount = std::min<int32>(100, int32(((1.0f / owner->m_modAttackSpeedPct[BASE_ATTACK]) - 1.0f) * 100.0f));
            }

            void HandleEffectApply(AuraEffect const* aurEff, AuraEffectHandleModes /*mode*/)
            {
                if (aurEff->GetAuraType() != SPELL_AURA_MELEE_SLOW)
                    return;

                GetUnitOwner()->ApplySpellImmune(0, IMMUNITY_STATE, SPELL_AURA_MOD_CASTING_SPEED_NOT_STACK, true, SPELL_BLOCK_TYPE_POSITIVE);
                GetUnitOwner()->ApplySpellImmune(0, IMMUNITY_STATE, SPELL_AURA_MOD_MELEE_RANGED_HASTE, true, SPELL_BLOCK_TYPE_POSITIVE);
                GetUnitOwner()->ApplySpellImmune(0, IMMUNITY_STATE, SPELL_AURA_MELEE_SLOW, true, SPELL_BLOCK_TYPE_POSITIVE);

                if (GetUnitOwner()->IsPet())
                    return;

                GetUnitOwner()->ApplySpellImmune(0, IMMUNITY_STATE, SPELL_AURA_MOD_STAT, true, SPELL_BLOCK_TYPE_POSITIVE);
                GetUnitOwner()->ApplySpellImmune(0, IMMUNITY_STATE, SPELL_AURA_MOD_TOTAL_STAT_PERCENTAGE, true, SPELL_BLOCK_TYPE_POSITIVE);
                GetUnitOwner()->ApplySpellImmune(0, IMMUNITY_STATE, SPELL_AURA_MOD_ATTACK_POWER, true, SPELL_BLOCK_TYPE_POSITIVE);
                GetUnitOwner()->ApplySpellImmune(0, IMMUNITY_STATE, SPELL_AURA_MOD_ATTACK_POWER_PCT, true, SPELL_BLOCK_TYPE_POSITIVE);
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
                if (m_scriptSpellId == 54566)
                {
                    DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_dk_pet_scaling_AuraScript::CalculateStatAmount, EFFECT_ALL, SPELL_AURA_MOD_STAT);
                    DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_dk_pet_scaling_AuraScript::CalculateSPAmount, EFFECT_ALL, SPELL_AURA_MOD_DAMAGE_DONE);
                }

                if (m_scriptSpellId == 51996)
                    DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_dk_pet_scaling_AuraScript::CalculateHasteAmount, EFFECT_ALL, SPELL_AURA_MELEE_SLOW);

                OnEffectApply += AuraEffectApplyFn(spell_dk_pet_scaling_AuraScript::HandleEffectApply, EFFECT_ALL, SPELL_AURA_ANY, AURA_EFFECT_HANDLE_REAL);
                DoEffectCalcPeriodic += AuraEffectCalcPeriodicFn(spell_dk_pet_scaling_AuraScript::CalcPeriodic, EFFECT_ALL, SPELL_AURA_ANY);
                OnEffectPeriodic += AuraEffectPeriodicFn(spell_dk_pet_scaling_AuraScript::HandlePeriodic, EFFECT_ALL, SPELL_AURA_ANY);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_dk_pet_scaling_AuraScript();
        }
};


// Theirs
// 50462 - Anti-Magic Shell (on raid member)
class spell_dk_anti_magic_shell_raid : public SpellScriptLoader
{
    public:
        spell_dk_anti_magic_shell_raid() : SpellScriptLoader("spell_dk_anti_magic_shell_raid") { }

        class spell_dk_anti_magic_shell_raid_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_dk_anti_magic_shell_raid_AuraScript);

            uint32 absorbPct;

            bool Load()
            {
                absorbPct = GetSpellInfo()->Effects[EFFECT_0].CalcValue(GetCaster());
                return true;
            }

            void CalculateAmount(AuraEffect const* /*aurEff*/, int32 & amount, bool & /*canBeRecalculated*/)
            {
                // TODO: this should absorb limited amount of damage, but no info on calculation formula
                amount = -1;
            }

            void Absorb(AuraEffect* /*aurEff*/, DamageInfo & dmgInfo, uint32 & absorbAmount)
            {
                 absorbAmount = CalculatePct(dmgInfo.GetDamage(), absorbPct);
            }

            void Register()
            {
                 DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_dk_anti_magic_shell_raid_AuraScript::CalculateAmount, EFFECT_0, SPELL_AURA_SCHOOL_ABSORB);
                 OnEffectAbsorb += AuraEffectAbsorbFn(spell_dk_anti_magic_shell_raid_AuraScript::Absorb, EFFECT_0);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_dk_anti_magic_shell_raid_AuraScript();
        }
};

// 48707 - Anti-Magic Shell (on self)
class spell_dk_anti_magic_shell_self : public SpellScriptLoader
{
    public:
        spell_dk_anti_magic_shell_self() : SpellScriptLoader("spell_dk_anti_magic_shell_self") { }

        class spell_dk_anti_magic_shell_self_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_dk_anti_magic_shell_self_AuraScript);

            uint32 absorbPct, hpPct;
            bool Load()
            {
                absorbPct = GetSpellInfo()->Effects[EFFECT_0].CalcValue(GetCaster());
                hpPct = GetSpellInfo()->Effects[EFFECT_1].CalcValue(GetCaster());
                return true;
            }

            bool Validate(SpellInfo const* /*spellInfo*/)
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_DK_RUNIC_POWER_ENERGIZE))
                    return false;
                return true;
            }

            void CalculateAmount(AuraEffect const* /*aurEff*/, int32 & amount, bool & /*canBeRecalculated*/)
            {
                amount = GetCaster()->CountPctFromMaxHealth(hpPct);
            }

            void Absorb(AuraEffect* /*aurEff*/, DamageInfo & dmgInfo, uint32 & absorbAmount)
            {
                absorbAmount = std::min(CalculatePct(dmgInfo.GetDamage(), absorbPct), GetTarget()->CountPctFromMaxHealth(hpPct));
            }

            void Trigger(AuraEffect* aurEff, DamageInfo& /*dmgInfo*/, uint32& absorbAmount)
            {
                // damage absorbed by Anti-Magic Shell energizes the DK with additional runic power.
                // This, if I'm not mistaken, shows that we get back ~20% of the absorbed damage as runic power.
                int32 bp = CalculatePct(absorbAmount, 20);
                GetTarget()->CastCustomSpell(SPELL_DK_RUNIC_POWER_ENERGIZE, SPELLVALUE_BASE_POINT0, bp, GetTarget(), true, NULL, aurEff);
            }

            void HandleEffectApply(AuraEffect const*  /*aurEff*/, AuraEffectHandleModes /*mode*/)
            {
                Unit* target = GetTarget();
                target->ApplySpellImmune(GetId(), IMMUNITY_ID, 33786, true); // cyclone
            }

            void HandleEffectRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
            {
                Unit* target = GetTarget();
                target->ApplySpellImmune(GetId(), IMMUNITY_ID, 33786, false); // cyclone
            }

            void Register()
            {
                 DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_dk_anti_magic_shell_self_AuraScript::CalculateAmount, EFFECT_0, SPELL_AURA_SCHOOL_ABSORB);
                 OnEffectAbsorb += AuraEffectAbsorbFn(spell_dk_anti_magic_shell_self_AuraScript::Absorb, EFFECT_0);
                 AfterEffectAbsorb += AuraEffectAbsorbFn(spell_dk_anti_magic_shell_self_AuraScript::Trigger, EFFECT_0);

                 OnEffectApply += AuraEffectApplyFn(spell_dk_anti_magic_shell_self_AuraScript::HandleEffectApply, EFFECT_1, SPELL_AURA_MOD_IMMUNE_AURA_APPLY_SCHOOL, AURA_EFFECT_HANDLE_REAL);
                 OnEffectRemove += AuraEffectRemoveFn(spell_dk_anti_magic_shell_self_AuraScript::HandleEffectRemove, EFFECT_1, SPELL_AURA_MOD_IMMUNE_AURA_APPLY_SCHOOL, AURA_EFFECT_HANDLE_REAL);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_dk_anti_magic_shell_self_AuraScript();
        }
};

// 50461 - Anti-Magic Zone
class spell_dk_anti_magic_zone : public SpellScriptLoader
{
    public:
        spell_dk_anti_magic_zone() : SpellScriptLoader("spell_dk_anti_magic_zone") { }

        class spell_dk_anti_magic_zone_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_dk_anti_magic_zone_AuraScript);

            uint32 absorbPct;

            bool Load()
            {
                absorbPct = GetSpellInfo()->Effects[EFFECT_0].CalcValue(GetCaster());
                return true;
            }

            bool Validate(SpellInfo const* /*spellInfo*/)
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_DK_ANTI_MAGIC_SHELL_TALENT))
                    return false;
                return true;
            }

            void CalculateAmount(AuraEffect const* /*aurEff*/, int32 & amount, bool & canBeRecalculated)
            {
                SpellInfo const* talentSpell = sSpellMgr->GetSpellInfo(SPELL_DK_ANTI_MAGIC_SHELL_TALENT);
                amount = talentSpell->Effects[EFFECT_0].CalcValue(GetCaster());
                if (Unit* totem = GetCaster())
                    if (Unit* owner = totem->ToTotem()->GetSummoner())
                        amount += int32(2 * owner->GetTotalAttackPowerValue(BASE_ATTACK));
                canBeRecalculated = false;
            }

            void Absorb(AuraEffect* /*aurEff*/, DamageInfo & dmgInfo, uint32 & absorbAmount)
            {
                 absorbAmount = CalculatePct(dmgInfo.GetDamage(), absorbPct);
            }

            void Register()
            {
                 DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_dk_anti_magic_zone_AuraScript::CalculateAmount, EFFECT_0, SPELL_AURA_SCHOOL_ABSORB);
                 OnEffectAbsorb += AuraEffectAbsorbFn(spell_dk_anti_magic_zone_AuraScript::Absorb, EFFECT_0);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_dk_anti_magic_zone_AuraScript();
        }
};

// 48721 - Blood Boil
class spell_dk_blood_boil : public SpellScriptLoader
{
    public:
        spell_dk_blood_boil() : SpellScriptLoader("spell_dk_blood_boil") { }

        class spell_dk_blood_boil_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_dk_blood_boil_SpellScript);

            bool Validate(SpellInfo const* /*spellInfo*/)
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_DK_BLOOD_BOIL_TRIGGERED))
                    return false;
                return true;
            }

            bool Load()
            {
                _executed = false;
                return GetCaster()->GetTypeId() == TYPEID_PLAYER && GetCaster()->getClass() == CLASS_DEATH_KNIGHT;
            }

            void HandleAfterHit()
            {
                if (_executed || !GetHitUnit())
                    return;

                _executed = true;
                GetCaster()->CastSpell(GetCaster(), SPELL_DK_BLOOD_BOIL_TRIGGERED, true);
            }

            void Register()
            {
                AfterHit += SpellHitFn(spell_dk_blood_boil_SpellScript::HandleAfterHit);
            }

            bool _executed;
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_dk_blood_boil_SpellScript();
        }
};

// 50453 - Bloodworms Health Leech
class spell_dk_blood_gorged : public SpellScriptLoader
{
    public:
        spell_dk_blood_gorged() : SpellScriptLoader("spell_dk_blood_gorged") { }

        class spell_dk_blood_gorged_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_dk_blood_gorged_AuraScript);

            bool Validate(SpellInfo const* /*spellInfo*/)
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_DK_BLOOD_GORGED_HEAL))
                    return false;
                return true;
            }

            bool Load()
            {
                _procTarget = NULL;
                return true;
            }

            bool CheckProc(ProcEventInfo& /*eventInfo*/)
            {
                _procTarget = GetTarget()->GetOwner();
                return _procTarget;
            }

            void HandleProc(AuraEffect const* aurEff, ProcEventInfo& eventInfo)
            {
                PreventDefaultAction();
                int32 bp = int32(eventInfo.GetDamageInfo()->GetDamage() * 1.5f);
                GetTarget()->CastCustomSpell(SPELL_DK_BLOOD_GORGED_HEAL, SPELLVALUE_BASE_POINT0, bp, _procTarget, true, NULL, aurEff);
            }

            void Register()
            {
                DoCheckProc += AuraCheckProcFn(spell_dk_blood_gorged_AuraScript::CheckProc);
                OnEffectProc += AuraEffectProcFn(spell_dk_blood_gorged_AuraScript::HandleProc, EFFECT_0, SPELL_AURA_DUMMY);
            }

        private:
            Unit* _procTarget;
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_dk_blood_gorged_AuraScript();
        }
};

class CorpseExplosionCheck
{
public:
    explicit CorpseExplosionCheck(uint64 casterGUID, bool allowGhoul) : _casterGUID(casterGUID), _allowGhoul(allowGhoul) { }

    bool operator()(WorldObject* obj) const
    {
        if (Unit* target = obj->ToUnit())
        {
            if ((target->isDead() || (_allowGhoul && target->GetEntry() == NPC_DK_GHOUL && target->GetOwnerGUID() == _casterGUID))
                && !(target->GetCreatureTypeMask() & CREATURE_TYPEMASK_MECHANICAL_OR_ELEMENTAL)
                && target->GetDisplayId() == target->GetNativeDisplayId())
                return false;
        }

        return true;
    }

private:
    uint64 _casterGUID;
    bool _allowGhoul;
};

// 49158 - Corpse Explosion (51325, 51326, 51327, 51328)
class spell_dk_corpse_explosion : public SpellScriptLoader
{
    public:
        spell_dk_corpse_explosion() : SpellScriptLoader("spell_dk_corpse_explosion") { }

        class spell_dk_corpse_explosion_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_dk_corpse_explosion_SpellScript);

            bool Validate(SpellInfo const* spellInfo)
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_DK_CORPSE_EXPLOSION_TRIGGERED)
                    || !sSpellMgr->GetSpellInfo(SPELL_DK_GHOUL_EXPLODE)
                    || !sSpellMgr->GetSpellInfo(SPELL_DK_CORPSE_EXPLOSION_VISUAL)
                    || !sSpellMgr->GetSpellInfo(spellInfo->Effects[EFFECT_1].CalcValue()))
                    return false;
                return true;
            }

            bool Load()
            {
                _target = NULL;
                return true;
            }

            void CheckTarget(WorldObject*& target)
            {
                if (CorpseExplosionCheck(GetCaster()->GetGUID(), true)(target))
                    target = NULL;

                _target = target;
            }

            void CheckTargets(std::list<WorldObject*>& targets)
            {
                WorldObject* target = _target;
                if (!target)
                {
                    targets.remove_if(CorpseExplosionCheck(GetCaster()->GetGUID(), false));
                    if (targets.empty())
                    {
                        FinishCast(SPELL_FAILED_CANT_DO_THAT_RIGHT_NOW);
                        return;
                    }
                    target = Trinity::Containers::SelectRandomContainerElement(targets);
                    targets.clear();
                    targets.push_back(target);
                }
                else
                    targets.clear();
            }

            void HandleDamage(SpellEffIndex effIndex, Unit* target)
            {
                if (effIndex == EFFECT_0)
                    GetCaster()->CastCustomSpell(GetSpellInfo()->Effects[EFFECT_1].CalcValue(), SPELLVALUE_BASE_POINT0, GetEffectValue(), target, true);
                else if (effIndex == EFFECT_1)
                    GetCaster()->CastCustomSpell(GetEffectValue(), SPELLVALUE_BASE_POINT0, GetSpell()->CalculateSpellDamage(EFFECT_0, NULL), target, true);
            }

            void HandleCorpseExplosion(SpellEffIndex effIndex)
            {
                if (Unit* unitTarget = GetHitUnit())
                {
                    if (unitTarget->IsAlive())  // Living ghoul as a target
                    {
                        unitTarget->ToCreature()->m_CreatureSpellCooldowns.clear();
                        if (CharmInfo* charmInfo = unitTarget->GetCharmInfo())
                            charmInfo->GetGlobalCooldownMgr().CancelGlobalCooldown(sSpellMgr->GetSpellInfo(SPELL_DK_GHOUL_EXPLODE));

                        unitTarget->StopMoving();
                        unitTarget->CastSpell(unitTarget, SPELL_DK_GHOUL_EXPLODE, false);
                        // Corpse Explosion (Suicide) and Set corpse look handled in SpellScript of SPELL_DK_GHOUL_EXPLODE
                    }
                    else                        // Some corpse
                    {
                        HandleDamage(effIndex, unitTarget);
                        // Corpse Explosion (Suicide)
                        unitTarget->CastSpell(unitTarget, SPELL_DK_CORPSE_EXPLOSION_TRIGGERED, true);
                        // Set corpse look
                        GetCaster()->CastSpell(unitTarget, SPELL_DK_CORPSE_EXPLOSION_VISUAL, true);
                    }
                }
            }

            void Register()
            {
                OnObjectTargetSelect += SpellObjectTargetSelectFn(spell_dk_corpse_explosion_SpellScript::CheckTarget, EFFECT_0, TARGET_UNIT_TARGET_ANY);
                OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_dk_corpse_explosion_SpellScript::CheckTargets, EFFECT_1, TARGET_UNIT_DEST_AREA_ENTRY);
                OnEffectHitTarget += SpellEffectFn(spell_dk_corpse_explosion_SpellScript::HandleCorpseExplosion, EFFECT_0, SPELL_EFFECT_DUMMY);
                OnEffectHitTarget += SpellEffectFn(spell_dk_corpse_explosion_SpellScript::HandleCorpseExplosion, EFFECT_1, SPELL_EFFECT_DUMMY);
            }

        private:
            WorldObject* _target;
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_dk_corpse_explosion_SpellScript();
        }
};

// -47541, 52375, 59134, -62900 - Death Coil
class spell_dk_death_coil : public SpellScriptLoader
{
    public:
        spell_dk_death_coil() : SpellScriptLoader("spell_dk_death_coil") { }

        class spell_dk_death_coil_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_dk_death_coil_SpellScript);

            bool Validate(SpellInfo const* /*spell*/)
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_DK_DEATH_COIL_DAMAGE) || !sSpellMgr->GetSpellInfo(SPELL_DK_DEATH_COIL_HEAL))
                    return false;
                return true;
            }

            void HandleDummy(SpellEffIndex /*effIndex*/)
            {
                int32 damage = GetEffectValue();
                Unit* caster = GetCaster();
                if (Unit* target = GetHitUnit())
                {
                    if (caster->IsFriendlyTo(target))
                    {
                        int32 bp = int32(damage * 1.5f);
                        caster->CastCustomSpell(target, SPELL_DK_DEATH_COIL_HEAL, &bp, NULL, NULL, true);
                    }
                    else
                    {
                        if (AuraEffect const* auraEffect = caster->GetAuraEffect(SPELL_DK_ITEM_SIGIL_VENGEFUL_HEART, EFFECT_1))
                            damage += auraEffect->GetBaseAmount();
                        caster->CastCustomSpell(target, SPELL_DK_DEATH_COIL_DAMAGE, &damage, NULL, NULL, true);
                    }
                }
            }

            SpellCastResult CheckCast()
            {
                Unit* caster = GetCaster();
                if (Unit* target = GetExplTargetUnit())
                {
                    if (!caster->IsFriendlyTo(target) && !caster->isInFront(target))
                        return SPELL_FAILED_UNIT_NOT_INFRONT;

                    if (target->IsFriendlyTo(caster) && target->GetCreatureType() != CREATURE_TYPE_UNDEAD)
                        return SPELL_FAILED_BAD_TARGETS;
                }
                else
                    return SPELL_FAILED_BAD_TARGETS;

                return SPELL_CAST_OK;
            }

            void Register()
            {
                OnCheckCast += SpellCheckCastFn(spell_dk_death_coil_SpellScript::CheckCast);
                OnEffectHitTarget += SpellEffectFn(spell_dk_death_coil_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_dk_death_coil_SpellScript();
        }
};

// 52751 - Death Gate
class spell_dk_death_gate : public SpellScriptLoader
{
    public:
        spell_dk_death_gate() : SpellScriptLoader("spell_dk_death_gate") { }

        class spell_dk_death_gate_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_dk_death_gate_SpellScript);

            SpellCastResult CheckClass()
            {
                if (GetCaster()->getClass() != CLASS_DEATH_KNIGHT)
                {
                    SetCustomCastResultMessage(SPELL_CUSTOM_ERROR_MUST_BE_DEATH_KNIGHT);
                    return SPELL_FAILED_CUSTOM_ERROR;
                }

                return SPELL_CAST_OK;
            }

            void HandleScript(SpellEffIndex effIndex)
            {
                PreventHitDefaultEffect(effIndex);
                if (Unit* target = GetHitUnit())
                    target->CastSpell(target, GetEffectValue(), false);
            }

            void Register()
            {
                OnCheckCast += SpellCheckCastFn(spell_dk_death_gate_SpellScript::CheckClass);
                OnEffectHitTarget += SpellEffectFn(spell_dk_death_gate_SpellScript::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_dk_death_gate_SpellScript();
        }
};

// 49560 - Death Grip
class spell_dk_death_grip : public SpellScriptLoader
{
    public:
        spell_dk_death_grip() : SpellScriptLoader("spell_dk_death_grip") { }

        class spell_dk_death_grip_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_dk_death_grip_SpellScript);

            SpellCastResult CheckCast()
            {
                Unit* caster = GetCaster();
                Unit* target = GetExplTargetUnit();

                if (target->GetTypeId() == TYPEID_PLAYER && caster->GetExactDist(target) < 8.0f) // xinef: should be 8.0f, but we have to add target size (1.5f)
                    return SPELL_FAILED_TOO_CLOSE;

                if (caster->HasUnitState(UNIT_STATE_JUMPING) || caster->HasUnitMovementFlag(MOVEMENTFLAG_FALLING))
                    return SPELL_FAILED_MOVING;

                return SPELL_CAST_OK;
            }

            uint32 EntryCheck(uint32 entry)
            {
                Creature* targetCreature = GetHitCreature();

                switch (targetCreature->GetEntry())
                {
                    //Alliance Faction Champions
                case 34461:
                case 34460:
                case 34469:
                case 34467:
                case 34468:
                case 34465:
                case 34471:
                case 34466:
                case 34473:
                case 34472:
                case 34470:
                case 34463:
                case 34474:
                case 34475:

                    //Horde Faction Champions
                case 34458:
                case 34451:
                case 34459:
                case 34448:
                case 34449:
                case 34445:
                case 34456:
                case 34447:
                case 34441:
                case 34454:
                case 34444:
                case 34455:
                case 34450:
                case 34453:
                    return entry;
                    break;
                }
                return 0;
            }

            void HandleBaseDummy(SpellEffIndex /*effIndex*/)
            {
                Unit* caster = GetCaster();
                Unit* target = GetHitUnit();
                Unit* baseTarget = GetExplTargetUnit();
                Creature* targetCreature = GetHitCreature();

                if (caster != target)
                {                    
                    if (targetCreature && (targetCreature->isWorldBoss() || targetCreature->IsDungeonBoss()) && targetCreature->GetEntry() != EntryCheck(targetCreature->GetEntry()))
                    {
                        return;
                    }
                    else
                    {
                        caster->CastSpell(target, 49560, true);
                        const SpellInfo* spellInfo = sSpellMgr->GetSpellInfo(1766); // Rogue kick
                        if (!target->IsImmunedToSpellEffect(spellInfo, EFFECT_0))
                            target->InterruptNonMeleeSpells(true);
                    }
                }
                else
                    baseTarget->CastSpell(caster, 49560, true);
            }

            void HandleDummy(SpellEffIndex /*effIndex*/)
            {
                float casterZ = GetCaster()->GetPositionZ(); // for Ring of Valor
                WorldLocation gripPos = *GetExplTargetDest();
                if (Unit* target = GetHitUnit())
                    if (!target->HasAuraType(SPELL_AURA_DEFLECT_SPELLS) || target->HasUnitState(UNIT_STATE_STUNNED)) // Deterrence
                    {
                        if (target != GetCaster())
                        {
                            const SpellInfo* spellInfo = sSpellMgr->GetSpellInfo(1766); // Rogue kick
                            if (!target->IsImmunedToSpellEffect(spellInfo, EFFECT_0))
                                target->InterruptNonMeleeSpells(false, 0, false);
                        }

                        if (target->GetMapId() == 618) // for Ring of Valor
                            gripPos.m_positionZ = std::max(casterZ+0.2f, 28.5f);

                        target->CastSpell(gripPos.GetPositionX(), gripPos.GetPositionY(), gripPos.GetPositionZ(), 57604, true);
                    }
            }

            void Register()
            {
                if (m_scriptSpellId == 49576) // xinef: base death grip, add pvp range restriction
                {
                    OnCheckCast += SpellCheckCastFn(spell_dk_death_grip_SpellScript::CheckCast);
                    OnEffectHitTarget += SpellEffectFn(spell_dk_death_grip_SpellScript::HandleBaseDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
                }
                else
                    OnEffectHitTarget += SpellEffectFn(spell_dk_death_grip_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_dk_death_grip_SpellScript();
        }
};

// 48743 - Death Pact
class spell_dk_death_pact : public SpellScriptLoader
{
    public:
        spell_dk_death_pact() : SpellScriptLoader("spell_dk_death_pact") { }

        class spell_dk_death_pact_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_dk_death_pact_SpellScript);

            SpellCastResult CheckCast()
            {
                // Check if we have valid targets, otherwise skip spell casting here
                if (Player* player = GetCaster()->ToPlayer())
                    for (Unit::ControlSet::const_iterator itr = player->m_Controlled.begin(); itr != player->m_Controlled.end(); ++itr)
                        if (Creature* undeadPet = (*itr)->ToCreature())
                            if (undeadPet->IsAlive() &&
                                undeadPet->GetOwnerGUID() == player->GetGUID() &&
                                undeadPet->GetCreatureType() == CREATURE_TYPE_UNDEAD &&
                                undeadPet->IsWithinDist(player, 100.0f, false))
                                return SPELL_CAST_OK;

                return SPELL_FAILED_NO_PET;
            }

            void FilterTargets(std::list<WorldObject*>& targetList)
            {
                Unit* target = NULL;
                for (std::list<WorldObject*>::iterator itr = targetList.begin(); itr != targetList.end(); ++itr)
                {
                    if (Unit* unit = (*itr)->ToUnit())
                        if (unit->GetOwnerGUID() == GetCaster()->GetGUID() && unit->GetCreatureType() == CREATURE_TYPE_UNDEAD)
                        {
                            target = unit;
                            break;
                        }
                }

                targetList.clear();
                if (target)
                {
                    // xinef: remove all auras preventing effect execution
                    target->RemoveAllAurasOnDeath();
                    targetList.push_back(target);
                }
            }

            void Register()
            {
                OnCheckCast += SpellCheckCastFn(spell_dk_death_pact_SpellScript::CheckCast);
                OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_dk_death_pact_SpellScript::FilterTargets, EFFECT_1, TARGET_UNIT_DEST_AREA_ALLY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_dk_death_pact_SpellScript();
        }
};

// -49998 - Death Strike
class spell_dk_death_strike : public SpellScriptLoader
{
    public:
        spell_dk_death_strike() : SpellScriptLoader("spell_dk_death_strike") { }

        class spell_dk_death_strike_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_dk_death_strike_SpellScript);

            bool Validate(SpellInfo const* /*spellInfo*/)
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_DK_DEATH_STRIKE_HEAL))
                    return false;
                return true;
            }

            void HandleDummy(SpellEffIndex /*effIndex*/)
            {
                Unit* caster = GetCaster();
                if (Unit* target = GetHitUnit())
                {
                    uint32 count = target->GetDiseasesByCaster(caster->GetGUID());
                    int32 bp = int32(count * caster->CountPctFromMaxHealth(int32(GetSpellInfo()->Effects[EFFECT_0].DamageMultiplier)));
                    // Improved Death Strike
                    if (AuraEffect const* aurEff = caster->GetAuraEffect(SPELL_AURA_ADD_PCT_MODIFIER, SPELLFAMILY_DEATHKNIGHT, DK_ICON_ID_IMPROVED_DEATH_STRIKE, 0))
                        AddPct(bp, caster->CalculateSpellDamage(caster, aurEff->GetSpellInfo(), 2));
                    caster->CastCustomSpell(caster, SPELL_DK_DEATH_STRIKE_HEAL, &bp, NULL, NULL, false);
                }
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_dk_death_strike_SpellScript::HandleDummy, EFFECT_2, SPELL_EFFECT_DUMMY);
            }

        };

        SpellScript* GetSpellScript() const
        {
            return new spell_dk_death_strike_SpellScript();
        }
};

// 47496 - Explode, Ghoul spell for Corpse Explosion
class spell_dk_ghoul_explode : public SpellScriptLoader
{
    public:
        spell_dk_ghoul_explode() : SpellScriptLoader("spell_dk_ghoul_explode") { }

        class spell_dk_ghoul_explode_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_dk_ghoul_explode_SpellScript);

            bool Validate(SpellInfo const* spellInfo)
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_DK_CORPSE_EXPLOSION_TRIGGERED)
                    || spellInfo->Effects[EFFECT_2].CalcValue() <= 0)
                    return false;
                return true;
            }

            void HandleDamage(SpellEffIndex /*effIndex*/)
            {
                int32 value = int32(GetCaster()->CountPctFromMaxHealth(GetSpellInfo()->Effects[EFFECT_2].CalcValue(GetCaster())));
                SetEffectValue(value);
            }

            void Suicide(SpellEffIndex /*effIndex*/)
            {
                if (Unit* unitTarget = GetHitUnit())
                {
                    // Corpse Explosion (Suicide)
                    unitTarget->CastSpell(unitTarget, SPELL_DK_CORPSE_EXPLOSION_TRIGGERED, true);
                    // Set corpse look
                    GetCaster()->CastSpell(unitTarget, SPELL_DK_CORPSE_EXPLOSION_VISUAL, true);
                }
            }

            void Register()
            {
                OnEffectLaunchTarget += SpellEffectFn(spell_dk_ghoul_explode_SpellScript::HandleDamage, EFFECT_0, SPELL_EFFECT_SCHOOL_DAMAGE);
                OnEffectHitTarget += SpellEffectFn(spell_dk_ghoul_explode_SpellScript::Suicide, EFFECT_1, SPELL_EFFECT_SCHOOL_DAMAGE);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_dk_ghoul_explode_SpellScript();
        }
};

// 48792 - Icebound Fortitude
class spell_dk_icebound_fortitude : public SpellScriptLoader
{
    public:
        spell_dk_icebound_fortitude() : SpellScriptLoader("spell_dk_icebound_fortitude") { }

        class spell_dk_icebound_fortitude_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_dk_icebound_fortitude_AuraScript);

            bool Load()
            {
                Unit* caster = GetCaster();
                return caster && caster->GetTypeId() == TYPEID_PLAYER;
            }

            void CalculateAmount(AuraEffect const* /*aurEff*/, int32& amount, bool& /*canBeRecalculated*/)
            {
                if (Unit* caster = GetCaster())
                {
                    int32 value = amount;
                    uint32 defValue = uint32(caster->ToPlayer()->GetSkillValue(SKILL_DEFENSE) + caster->ToPlayer()->GetRatingBonusValue(CR_DEFENSE_SKILL));

                    if (defValue > 400)
                        value -= int32((defValue - 400) * 0.15);

                    // Glyph of Icebound Fortitude
                    if (AuraEffect const* aurEff = caster->GetAuraEffect(SPELL_DK_GLYPH_OF_ICEBOUND_FORTITUDE, EFFECT_0))
                    {
                        int32 valMax = -aurEff->GetAmount();
                        if (value > valMax)
                            value = valMax;
                    }
                    amount = value;
                }
            }

            void Register()
            {
                DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_dk_icebound_fortitude_AuraScript::CalculateAmount, EFFECT_2, SPELL_AURA_MOD_DAMAGE_PERCENT_TAKEN);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_dk_icebound_fortitude_AuraScript();
        }
};

// -50365 - Improved Blood Presence
class spell_dk_improved_blood_presence : public SpellScriptLoader
{
    public:
        spell_dk_improved_blood_presence() : SpellScriptLoader("spell_dk_improved_blood_presence") { }

        class spell_dk_improved_blood_presence_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_dk_improved_blood_presence_AuraScript);

            bool Validate(SpellInfo const* /*spellInfo*/)
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_DK_BLOOD_PRESENCE)
                    || !sSpellMgr->GetSpellInfo(SPELL_DK_FROST_PRESENCE)
                    || !sSpellMgr->GetSpellInfo(SPELL_DK_UNHOLY_PRESENCE)
                    || !sSpellMgr->GetSpellInfo(SPELL_DK_IMPROVED_BLOOD_PRESENCE_TRIGGERED))
                    return false;
                return true;
            }

            void HandleEffectApply(AuraEffect const* aurEff, AuraEffectHandleModes /*mode*/)
            {
                Unit* target = GetTarget();
                if ((target->HasAura(SPELL_DK_FROST_PRESENCE) || target->HasAura(SPELL_DK_UNHOLY_PRESENCE)) && !target->HasAura(SPELL_DK_IMPROVED_BLOOD_PRESENCE_TRIGGERED))
                    target->CastCustomSpell(SPELL_DK_IMPROVED_BLOOD_PRESENCE_TRIGGERED, SPELLVALUE_BASE_POINT1, aurEff->GetAmount(), target, true, NULL, aurEff);
            }

            void HandleEffectRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
            {
                Unit* target = GetTarget();
                if (!target->HasAura(SPELL_DK_BLOOD_PRESENCE))
                    target->RemoveAura(SPELL_DK_IMPROVED_BLOOD_PRESENCE_TRIGGERED);
            }

            void Register()
            {
                AfterEffectApply += AuraEffectApplyFn(spell_dk_improved_blood_presence_AuraScript::HandleEffectApply, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
                AfterEffectRemove += AuraEffectRemoveFn(spell_dk_improved_blood_presence_AuraScript::HandleEffectRemove, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_dk_improved_blood_presence_AuraScript();
        }
};

// -50384 - Improved Frost Presence
class spell_dk_improved_frost_presence : public SpellScriptLoader
{
    public:
        spell_dk_improved_frost_presence() : SpellScriptLoader("spell_dk_improved_frost_presence") { }

        class spell_dk_improved_frost_presence_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_dk_improved_frost_presence_AuraScript);

            bool Validate(SpellInfo const* /*spellInfo*/)
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_DK_BLOOD_PRESENCE)
                    || !sSpellMgr->GetSpellInfo(SPELL_DK_FROST_PRESENCE)
                    || !sSpellMgr->GetSpellInfo(SPELL_DK_UNHOLY_PRESENCE)
                    || !sSpellMgr->GetSpellInfo(SPELL_DK_FROST_PRESENCE_TRIGGERED))
                    return false;
                return true;
            }

            void HandleEffectApply(AuraEffect const* aurEff, AuraEffectHandleModes /*mode*/)
            {
                Unit* target = GetTarget();
                if ((target->HasAura(SPELL_DK_BLOOD_PRESENCE) || target->HasAura(SPELL_DK_UNHOLY_PRESENCE)) && !target->HasAura(SPELL_DK_FROST_PRESENCE_TRIGGERED))
                    target->CastCustomSpell(SPELL_DK_FROST_PRESENCE_TRIGGERED, SPELLVALUE_BASE_POINT0, aurEff->GetAmount(), target, true, NULL, aurEff);
            }

            void HandleEffectRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
            {
                Unit* target = GetTarget();
                if (!target->HasAura(SPELL_DK_FROST_PRESENCE))
                    target->RemoveAura(SPELL_DK_FROST_PRESENCE_TRIGGERED);
            }

            void Register()
            {
                AfterEffectApply += AuraEffectApplyFn(spell_dk_improved_frost_presence_AuraScript::HandleEffectApply, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
                AfterEffectRemove += AuraEffectRemoveFn(spell_dk_improved_frost_presence_AuraScript::HandleEffectRemove, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_dk_improved_frost_presence_AuraScript();
        }
};

// -50391 - Improved Unholy Presence
class spell_dk_improved_unholy_presence : public SpellScriptLoader
{
    public:
        spell_dk_improved_unholy_presence() : SpellScriptLoader("spell_dk_improved_unholy_presence") { }

        class spell_dk_improved_unholy_presence_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_dk_improved_unholy_presence_AuraScript);

            bool Validate(SpellInfo const* /*spellInfo*/)
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_DK_BLOOD_PRESENCE)
                    || !sSpellMgr->GetSpellInfo(SPELL_DK_FROST_PRESENCE)
                    || !sSpellMgr->GetSpellInfo(SPELL_DK_UNHOLY_PRESENCE)
                    || !sSpellMgr->GetSpellInfo(SPELL_DK_IMPROVED_UNHOLY_PRESENCE_TRIGGERED)
                    || !sSpellMgr->GetSpellInfo(SPELL_DK_UNHOLY_PRESENCE_TRIGGERED))
                    return false;
                return true;
            }

            void HandleEffectApply(AuraEffect const* aurEff, AuraEffectHandleModes /*mode*/)
            {
                Unit* target = GetTarget();
                if (target->HasAura(SPELL_DK_UNHOLY_PRESENCE) && !target->HasAura(SPELL_DK_IMPROVED_UNHOLY_PRESENCE_TRIGGERED))
                {
                    // Not listed as any effect, only base points set in dbc
                    int32 basePoints = GetSpellInfo()->Effects[EFFECT_1].CalcValue();
                    target->CastCustomSpell(target, SPELL_DK_IMPROVED_UNHOLY_PRESENCE_TRIGGERED, &basePoints, &basePoints, &basePoints, true, NULL, aurEff);
                }

                if ((target->HasAura(SPELL_DK_BLOOD_PRESENCE) || target->HasAura(SPELL_DK_FROST_PRESENCE)) && !target->HasAura(SPELL_DK_UNHOLY_PRESENCE_TRIGGERED))
                    target->CastCustomSpell(SPELL_DK_UNHOLY_PRESENCE_TRIGGERED, SPELLVALUE_BASE_POINT0, aurEff->GetAmount(), target, true, NULL, aurEff);
            }

            void HandleEffectRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
            {
                Unit* target = GetTarget();

                target->RemoveAura(SPELL_DK_IMPROVED_UNHOLY_PRESENCE_TRIGGERED);

                if (!target->HasAura(SPELL_DK_UNHOLY_PRESENCE))
                    target->RemoveAura(SPELL_DK_UNHOLY_PRESENCE_TRIGGERED);
            }

            void Register()
            {
                AfterEffectApply += AuraEffectApplyFn(spell_dk_improved_unholy_presence_AuraScript::HandleEffectApply, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
                AfterEffectRemove += AuraEffectRemoveFn(spell_dk_improved_unholy_presence_AuraScript::HandleEffectRemove, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_dk_improved_unholy_presence_AuraScript();
        }
};

// ID - 50842 Pestilence
class spell_dk_pestilence : public SpellScriptLoader
{
    public:
        spell_dk_pestilence() : SpellScriptLoader("spell_dk_pestilence") { }

        class spell_dk_pestilence_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_dk_pestilence_SpellScript);

            void HandleScriptEffect(SpellEffIndex /*effIndex*/)
            {
                Unit* caster = GetCaster();
                Unit* hitUnit = GetHitUnit();
                Unit* target = GetExplTargetUnit();
                if (!target)
                    return;

                if (target != hitUnit || caster->GetAura(SPELL_DK_GLYPH_OF_DISEASE))
                {
                    // xinef: checked in target selection
                    //if (!m_targets.GetUnitTarget()->IsWithinLOSInMap(unitTarget))
                    //  return;

                    // And spread them on target
                    // Blood Plague
                    if (target->GetAura(SPELL_DK_BLOOD_PLAGUE, caster->GetGUID()))
                        caster->CastSpell(hitUnit, SPELL_DK_BLOOD_PLAGUE, true);
                    // Frost Fever
                    if (target->GetAura(SPELL_DK_FROST_FEVER, caster->GetGUID()))
                        caster->CastSpell(hitUnit, SPELL_DK_FROST_FEVER, true);
                }
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_dk_pestilence_SpellScript::HandleScriptEffect, EFFECT_2, SPELL_EFFECT_SCRIPT_EFFECT);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_dk_pestilence_SpellScript();
        }
};

// 48266 - Blood Presence
// 48263 - Frost Presence
// 48265 - Unholy Presence
class spell_dk_presence : public SpellScriptLoader
{
    public:
        spell_dk_presence() : SpellScriptLoader("spell_dk_presence") { }

        class spell_dk_presence_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_dk_presence_AuraScript);

            bool Validate(SpellInfo const* /*spellInfo*/)
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_DK_BLOOD_PRESENCE)
                    || !sSpellMgr->GetSpellInfo(SPELL_DK_FROST_PRESENCE)
                    || !sSpellMgr->GetSpellInfo(SPELL_DK_UNHOLY_PRESENCE)
                    || !sSpellMgr->GetSpellInfo(SPELL_DK_IMPROVED_BLOOD_PRESENCE_R1)
                    || !sSpellMgr->GetSpellInfo(SPELL_DK_IMPROVED_FROST_PRESENCE_R1)
                    || !sSpellMgr->GetSpellInfo(SPELL_DK_IMPROVED_UNHOLY_PRESENCE_R1)
                    || !sSpellMgr->GetSpellInfo(SPELL_DK_IMPROVED_BLOOD_PRESENCE_TRIGGERED)
                    || !sSpellMgr->GetSpellInfo(SPELL_DK_IMPROVED_UNHOLY_PRESENCE_TRIGGERED)
                    || !sSpellMgr->GetSpellInfo(SPELL_DK_FROST_PRESENCE_TRIGGERED)
                    || !sSpellMgr->GetSpellInfo(SPELL_DK_UNHOLY_PRESENCE_TRIGGERED))
                    return false;

                return true;
            }

            void HandleImprovedBloodPresence(AuraEffect const* aurEff, AuraEffectHandleModes /*mode*/)
            {
                Unit* target = GetTarget();

                if (GetId() == SPELL_DK_BLOOD_PRESENCE)
                    target->CastSpell(target, SPELL_DK_IMPROVED_BLOOD_PRESENCE_TRIGGERED, true);
                else if (AuraEffect const* impAurEff = target->GetAuraEffectOfRankedSpell(SPELL_DK_IMPROVED_BLOOD_PRESENCE_R1, EFFECT_0))
                    if (!target->HasAura(SPELL_DK_IMPROVED_BLOOD_PRESENCE_TRIGGERED))
                        target->CastCustomSpell(SPELL_DK_IMPROVED_BLOOD_PRESENCE_TRIGGERED, SPELLVALUE_BASE_POINT1, impAurEff->GetAmount(), target, true, NULL, aurEff);
            }

            void HandleImprovedFrostPresence(AuraEffect const* aurEff, AuraEffectHandleModes /*mode*/)
            {
                Unit* target = GetTarget();

                if (GetId() == SPELL_DK_FROST_PRESENCE)
                    target->CastSpell(target, SPELL_DK_FROST_PRESENCE_TRIGGERED, true);
                else if (AuraEffect const* impAurEff = target->GetAuraEffectOfRankedSpell(SPELL_DK_IMPROVED_FROST_PRESENCE_R1, EFFECT_0))
                    if (!target->HasAura(SPELL_DK_FROST_PRESENCE_TRIGGERED))
                        target->CastCustomSpell(SPELL_DK_FROST_PRESENCE_TRIGGERED, SPELLVALUE_BASE_POINT0, impAurEff->GetAmount(), target, true, NULL, aurEff);
            }

            void HandleImprovedUnholyPresence(AuraEffect const* aurEff, AuraEffectHandleModes /*mode*/)
            {
                Unit* target = GetTarget();

                if (GetId() == SPELL_DK_UNHOLY_PRESENCE)
                    target->CastSpell(target, SPELL_DK_UNHOLY_PRESENCE_TRIGGERED, true);

                if (AuraEffect const* impAurEff = target->GetAuraEffectOfRankedSpell(SPELL_DK_IMPROVED_UNHOLY_PRESENCE_R1, EFFECT_0))
                {
                    if (GetId() == SPELL_DK_UNHOLY_PRESENCE)
                    {
                        // Not listed as any effect, only base points set
                        int32 bp = impAurEff->GetSpellInfo()->Effects[EFFECT_1].CalcValue();
                        target->CastCustomSpell(target, SPELL_DK_IMPROVED_UNHOLY_PRESENCE_TRIGGERED, &bp, &bp, &bp, true, NULL, aurEff);
                    }
                    else if (!target->HasAura(SPELL_DK_UNHOLY_PRESENCE_TRIGGERED))
                        target->CastCustomSpell(SPELL_DK_UNHOLY_PRESENCE_TRIGGERED, SPELLVALUE_BASE_POINT0, impAurEff->GetAmount(), target, true, NULL, aurEff);
                }
            }

            void HandleEffectRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
            {
                Unit* target = GetTarget();
                target->RemoveAura(SPELL_DK_IMPROVED_BLOOD_PRESENCE_TRIGGERED);
                target->RemoveAura(SPELL_DK_IMPROVED_UNHOLY_PRESENCE_TRIGGERED);
                target->RemoveAura(SPELL_DK_FROST_PRESENCE_TRIGGERED);
                target->RemoveAura(SPELL_DK_UNHOLY_PRESENCE_TRIGGERED);
            }

            void Register()
            {
                AfterEffectApply += AuraEffectApplyFn(spell_dk_presence_AuraScript::HandleImprovedBloodPresence, EFFECT_0, SPELL_AURA_ANY, AURA_EFFECT_HANDLE_REAL);
                AfterEffectApply += AuraEffectApplyFn(spell_dk_presence_AuraScript::HandleImprovedFrostPresence, EFFECT_0, SPELL_AURA_ANY, AURA_EFFECT_HANDLE_REAL);
                AfterEffectApply += AuraEffectApplyFn(spell_dk_presence_AuraScript::HandleImprovedUnholyPresence, EFFECT_0, SPELL_AURA_ANY, AURA_EFFECT_HANDLE_REAL);
                AfterEffectRemove += AuraEffectRemoveFn(spell_dk_presence_AuraScript::HandleEffectRemove, EFFECT_0, SPELL_AURA_ANY, AURA_EFFECT_HANDLE_REAL);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_dk_presence_AuraScript();
        }
};

class RaiseDeadCheck
{
    public:
        explicit RaiseDeadCheck(Player const* caster) : _caster(caster) { }

        bool operator()(WorldObject* obj) const
        {
            if (Unit* target = obj->ToUnit())
            {
                if (!target->IsAlive()
                    && _caster->isHonorOrXPTarget(target)
                    && target->GetCreatureType() == CREATURE_TYPE_HUMANOID
                    && target->GetDisplayId() == target->GetNativeDisplayId())
                    return false;
            }

            return true;
        }

    private:
        Player const* _caster;
};

// 46584 - Raise Dead
class spell_dk_raise_dead : public SpellScriptLoader
{
    public:
        spell_dk_raise_dead() : SpellScriptLoader("spell_dk_raise_dead") { }

        class spell_dk_raise_dead_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_dk_raise_dead_SpellScript);

            bool Validate(SpellInfo const* spellInfo)
            {
                if (!sSpellMgr->GetSpellInfo(spellInfo->Effects[EFFECT_1].CalcValue())
                    || !sSpellMgr->GetSpellInfo(spellInfo->Effects[EFFECT_2].CalcValue())
                    || !sSpellMgr->GetSpellInfo(SPELL_DK_RAISE_DEAD_USE_REAGENT)
                    || !sSpellMgr->GetSpellInfo(SPELL_DK_MASTER_OF_GHOULS))
                    return false;
                return true;
            }

            bool Load()
            {
                _result = SPELL_CAST_OK;
                _corpse = false;
                return GetCaster()->GetTypeId() == TYPEID_PLAYER;
            }

            SpellCastResult CheckCast()
            {
                /// process spell target selection before cast starts
                /// targets of effect_1 are used to check cast
                GetSpell()->SelectSpellTargets();
                /// cleanup spell target map, and fill it again on normal way
                GetSpell()->CleanupTargetList();
                /// _result is set in spell target selection
                return _result;
            }

            SpellCastResult CheckReagents()
            {
                /// @workaround: there is no access to castresult of other spells, check it manually
                SpellInfo const* reagentSpell = sSpellMgr->GetSpellInfo(SPELL_DK_RAISE_DEAD_USE_REAGENT);
                Player* player = GetCaster()->ToPlayer();
                if (!player->CanNoReagentCast(reagentSpell))
                {
                    for (uint32 i = 0; i < MAX_SPELL_REAGENTS; i++)
                    {
                        if (reagentSpell->Reagent[i] <= 0)
                            continue;

                        if (!player->HasItemCount(reagentSpell->Reagent[i], reagentSpell->ReagentCount[i]))
                        {
                            Spell::SendCastResult(player, reagentSpell, 0, SPELL_FAILED_REAGENTS);
                            return SPELL_FAILED_DONT_REPORT;
                        }
                    }
                }
                return SPELL_CAST_OK;
            }

            void CheckTargets(std::list<WorldObject*>& targets)
            {
                targets.remove_if(RaiseDeadCheck(GetCaster()->ToPlayer()));

                if (targets.empty())
                {
                    if (GetSpell()->getState() == SPELL_STATE_PREPARING)
                        _result = CheckReagents();

                    return;
                }

                WorldObject* target = Trinity::Containers::SelectRandomContainerElement(targets);
                targets.clear();
                targets.push_back(target);
                _corpse = true;
            }

            void CheckTarget(WorldObject*& target)
            {
                // Don't add caster to target map, if we found a corpse to raise dead
                if (_corpse)
                    target = NULL;
            }

            void ConsumeReagents()
            {
                // No corpse found, take reagents
                if (!_corpse)
                    GetCaster()->CastSpell(GetCaster(), SPELL_DK_RAISE_DEAD_USE_REAGENT, TriggerCastFlags(TRIGGERED_FULL_MASK & ~TRIGGERED_IGNORE_POWER_AND_REAGENT_COST));
            }

            uint32 GetGhoulSpellId()
            {
                // Do we have talent Master of Ghouls?
                if (GetCaster()->HasAura(SPELL_DK_MASTER_OF_GHOULS))
                    // summon as pet
                    return GetSpellInfo()->Effects[EFFECT_2].CalcValue();

                // or guardian
                return GetSpellInfo()->Effects[EFFECT_1].CalcValue();
            }

            void HandleRaiseDead(SpellEffIndex /*effIndex*/)
            {
                SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(GetGhoulSpellId());
                SpellCastTargets targets;
                targets.SetDst(*GetHitUnit());

                GetCaster()->CastSpell(targets, spellInfo, NULL, TRIGGERED_FULL_MASK, NULL, NULL, GetCaster()->GetGUID());
                GetCaster()->ToPlayer()->RemoveSpellCooldown(GetSpellInfo()->Id, true);
            }

            void Register()
            {
                OnCheckCast += SpellCheckCastFn(spell_dk_raise_dead_SpellScript::CheckCast);
                OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_dk_raise_dead_SpellScript::CheckTargets, EFFECT_1, TARGET_UNIT_DEST_AREA_ENTRY);
                OnObjectTargetSelect += SpellObjectTargetSelectFn(spell_dk_raise_dead_SpellScript::CheckTarget, EFFECT_2, TARGET_UNIT_CASTER);
                OnCast += SpellCastFn(spell_dk_raise_dead_SpellScript::ConsumeReagents);
                OnEffectHitTarget += SpellEffectFn(spell_dk_raise_dead_SpellScript::HandleRaiseDead, EFFECT_1, SPELL_EFFECT_SCRIPT_EFFECT);
                OnEffectHitTarget += SpellEffectFn(spell_dk_raise_dead_SpellScript::HandleRaiseDead, EFFECT_2, SPELL_EFFECT_DUMMY);
            }

        private:
            SpellCastResult _result;
            bool _corpse;
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_dk_raise_dead_SpellScript();
        }
};

// 59754 Rune Tap - Party
class spell_dk_rune_tap_party : public SpellScriptLoader
{
    public:
        spell_dk_rune_tap_party() : SpellScriptLoader("spell_dk_rune_tap_party") { }

        class spell_dk_rune_tap_party_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_dk_rune_tap_party_SpellScript);

            void CheckTargets(std::list<WorldObject*>& targets)
            {
                targets.remove(GetCaster());
            }

            void Register()
            {
                OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_dk_rune_tap_party_SpellScript::CheckTargets, EFFECT_0, TARGET_UNIT_CASTER_AREA_PARTY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_dk_rune_tap_party_SpellScript();
        }
};

// 50421 - Scent of Blood
class spell_dk_scent_of_blood : public SpellScriptLoader
{
    public:
        spell_dk_scent_of_blood() : SpellScriptLoader("spell_dk_scent_of_blood") { }

        class spell_dk_scent_of_blood_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_dk_scent_of_blood_AuraScript);

            bool Validate(SpellInfo const* /*spellInfo*/)
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_DK_SCENT_OF_BLOOD))
                    return false;
                return true;
            }

            void HandleProc(AuraEffect const* aurEff, ProcEventInfo& /*eventInfo*/)
            {
                PreventDefaultAction();
                GetTarget()->CastSpell(GetTarget(), SPELL_DK_SCENT_OF_BLOOD, true, NULL, aurEff);
                GetTarget()->RemoveAuraFromStack(GetSpellInfo()->Id);
            }

            void Register()
            {
                OnEffectProc += AuraEffectProcFn(spell_dk_scent_of_blood_AuraScript::HandleProc, EFFECT_0, SPELL_AURA_PROC_TRIGGER_SPELL);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_dk_scent_of_blood_AuraScript();
        }
};

// 55090 - Scourge Strike (55265, 55270, 55271)
class spell_dk_scourge_strike : public SpellScriptLoader
{
    public:
        spell_dk_scourge_strike() : SpellScriptLoader("spell_dk_scourge_strike") { }

        class spell_dk_scourge_strike_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_dk_scourge_strike_SpellScript);
            float multiplier;
            uint64 guid;

            bool Load()
            {
                multiplier = 1.0f;
                guid = 0;
                return true;
            }

            bool Validate(SpellInfo const* /*spellInfo*/)
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_DK_SCOURGE_STRIKE_TRIGGERED))
                    return false;
                return true;
            }

            void HandleDummy(SpellEffIndex /*effIndex*/)
            {
                Unit* caster = GetCaster();
                if (Unit* unitTarget = GetHitUnit())
                {
                    uint8 mode = caster->GetAuraEffectDummy(SPELL_DK_GLYPH_OF_SCOURGE_STRIKE) ? 2 : 0;
                    float disease_amt = GetEffectValue();

                    // Death Knight T8 Melee 4P Bonus
                    if (AuraEffect const* aurEff = caster->GetAuraEffect(SPELL_DK_ITEM_T8_MELEE_4P_BONUS, EFFECT_0))
                        AddPct(disease_amt, aurEff->GetAmount());

                    multiplier = disease_amt * unitTarget->GetDiseasesByCaster(caster->GetGUID(), mode) / 100.0f;
                    guid = unitTarget->GetGUID();
                }
            }

            void HandleAfterHit()
            {
                Unit* caster = GetCaster();
                if (Unit *unitTarget = ObjectAccessor::GetUnit(*caster, guid))
                {
                    int32 bp = GetHitDamage() * multiplier;
                    caster->CastCustomSpell(unitTarget, SPELL_DK_SCOURGE_STRIKE_TRIGGERED, &bp, NULL, NULL, true);

                    // Xinef: Shadowmourne hack (scourge strike trigger proc disabled...)
                    if (roll_chance_i(75) && caster->FindMap() && !caster->FindMap()->IsBattlegroundOrArena() && caster->HasAura(71903) && !caster->HasAura(SPELL_SHADOWMOURNE_CHAOS_BANE_BUFF))
                    {
                        caster->CastSpell(caster, SPELL_SHADOWMOURNE_SOUL_FRAGMENT, true);

                        // this can't be handled in AuraScript of SoulFragments because we need to know victim
                        if (Aura* soulFragments = caster->GetAura(SPELL_SHADOWMOURNE_SOUL_FRAGMENT))
                        {
                            if (soulFragments->GetStackAmount() >= 10)
                            {
                                caster->CastSpell(caster, SPELL_SHADOWMOURNE_CHAOS_BANE_DAMAGE, true, NULL);
                                soulFragments->Remove();
                            }
                        }
                    }
                }
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_dk_scourge_strike_SpellScript::HandleDummy, EFFECT_2, SPELL_EFFECT_DUMMY);
                AfterHit += SpellHitFn(spell_dk_scourge_strike_SpellScript::HandleAfterHit);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_dk_scourge_strike_SpellScript();
        }
};

// 49145 - Spell Deflection
class spell_dk_spell_deflection : public SpellScriptLoader
{
    public:
        spell_dk_spell_deflection() : SpellScriptLoader("spell_dk_spell_deflection") { }

        class spell_dk_spell_deflection_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_dk_spell_deflection_AuraScript);

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
                // You have a chance equal to your Parry chance
                float chance = GetTarget()->GetUnitParryChance();
                if (GetTarget()->IsNonMeleeSpellCast(false, false, true) || GetTarget()->HasUnitState(UNIT_STATE_CONTROLLED))
                    chance = 0.0f;

                if ((dmgInfo.GetDamageType() == SPELL_DIRECT_DAMAGE) && roll_chance_f(chance))
                    absorbAmount = CalculatePct(dmgInfo.GetDamage(), absorbPct);
            }

            void Register()
            {
                 DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_dk_spell_deflection_AuraScript::CalculateAmount, EFFECT_0, SPELL_AURA_SCHOOL_ABSORB);
                 OnEffectAbsorb += AuraEffectAbsorbFn(spell_dk_spell_deflection_AuraScript::Absorb, EFFECT_0);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_dk_spell_deflection_AuraScript();
        }
};

// 55233 - Vampiric Blood
class spell_dk_vampiric_blood : public SpellScriptLoader
{
    public:
        spell_dk_vampiric_blood() : SpellScriptLoader("spell_dk_vampiric_blood") { }

        class spell_dk_vampiric_blood_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_dk_vampiric_blood_AuraScript);

            void CalculateAmount(AuraEffect const* /*aurEff*/, int32& amount, bool& /*canBeRecalculated*/)
            {
                amount = GetUnitOwner()->CountPctFromMaxHealth(amount);
            }

            void Register()
            {
                DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_dk_vampiric_blood_AuraScript::CalculateAmount, EFFECT_1, SPELL_AURA_MOD_INCREASE_HEALTH);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_dk_vampiric_blood_AuraScript();
        }
};

// 52284 - Will of the Necropolis
class spell_dk_will_of_the_necropolis : public SpellScriptLoader
{
    public:
        spell_dk_will_of_the_necropolis() : SpellScriptLoader("spell_dk_will_of_the_necropolis") { }

        class spell_dk_will_of_the_necropolis_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_dk_will_of_the_necropolis_AuraScript);

            bool Validate(SpellInfo const* spellInfo)
            {
                SpellInfo const* firstRankSpellInfo = sSpellMgr->GetSpellInfo(SPELL_DK_WILL_OF_THE_NECROPOLIS_AURA_R1);
                if (!firstRankSpellInfo)
                    return false;

                // can't use other spell than will of the necropolis due to spell_ranks dependency
                if (!spellInfo->IsRankOf(firstRankSpellInfo))
                    return false;

                uint8 rank = spellInfo->GetRank();
                if (!sSpellMgr->GetSpellWithRank(SPELL_DK_WILL_OF_THE_NECROPOLIS_TALENT_R1, rank, true))
                    return false;

                return true;
            }

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
                // min pct of hp is stored in effect 0 of talent spell
                uint8 rank = GetSpellInfo()->GetRank();
                SpellInfo const* talentProto = sSpellMgr->GetSpellInfo(sSpellMgr->GetSpellWithRank(SPELL_DK_WILL_OF_THE_NECROPOLIS_TALENT_R1, rank));

                int32 remainingHp = int32(GetTarget()->GetHealth() - dmgInfo.GetDamage());
                int32 minHp = int32(GetTarget()->CountPctFromMaxHealth(talentProto->Effects[EFFECT_0].CalcValue(GetCaster())));

                // Damage that would take you below [effect0] health or taken while you are at [effect0]
                if (remainingHp < minHp)
                    absorbAmount = CalculatePct(dmgInfo.GetDamage(), absorbPct);
            }

            void Register()
            {
                 DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_dk_will_of_the_necropolis_AuraScript::CalculateAmount, EFFECT_0, SPELL_AURA_SCHOOL_ABSORB);
                 OnEffectAbsorb += AuraEffectAbsorbFn(spell_dk_will_of_the_necropolis_AuraScript::Absorb, EFFECT_0);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_dk_will_of_the_necropolis_AuraScript();
        }
};

void AddSC_deathknight_spell_scripts()
{
    // Ours
    new spell_dk_wandering_plague();
    new spell_dk_raise_ally();
    new spell_dk_raise_ally_trigger();
    new spell_dk_aotd_taunt();
    new spell_dk_death_and_decay();
    new spell_dk_master_of_ghouls();
    new spell_dk_chains_of_ice();
    new spell_dk_bloodworms();
    new spell_dk_summon_gargoyle();
    new spell_dk_improved_blood_presence_proc();
    new spell_dk_wandering_plague_aura();
    new spell_dk_rune_of_the_fallen_crusader();
    new spell_dk_bone_shield();
    new spell_dk_hungering_cold();
    new spell_dk_blood_caked_blade();
    new spell_dk_dancing_rune_weapon();
    new spell_dk_dancing_rune_weapon_visual();
    new spell_dk_scent_of_blood_trigger();
    new spell_dk_pet_scaling();

    // Theirs
    new spell_dk_anti_magic_shell_raid();
    new spell_dk_anti_magic_shell_self();
    new spell_dk_anti_magic_zone();
    new spell_dk_blood_boil();
    new spell_dk_blood_gorged();
    new spell_dk_corpse_explosion();
    new spell_dk_death_coil();
    new spell_dk_death_gate();
    new spell_dk_death_grip();
    new spell_dk_death_pact();
    new spell_dk_death_strike();
    new spell_dk_ghoul_explode();
    new spell_dk_icebound_fortitude();
    new spell_dk_improved_blood_presence();
    new spell_dk_improved_frost_presence();
    new spell_dk_improved_unholy_presence();
    new spell_dk_pestilence();
    new spell_dk_presence();
    new spell_dk_raise_dead();
    new spell_dk_rune_tap_party();
    new spell_dk_scent_of_blood();
    new spell_dk_scourge_strike();
    new spell_dk_spell_deflection();
    new spell_dk_vampiric_blood();
    new spell_dk_will_of_the_necropolis();
}

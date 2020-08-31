/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

/*
 * Scripts for spells with SPELLFAMILY_GENERIC spells used by items.
 * Ordered alphabetically using scriptname.
 * Scriptnames of files in this file should be prefixed with "spell_item_".
 */

#include "Player.h"
#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "SpellScript.h"
#include "SpellAuraEffects.h"
#include "SkillDiscovery.h"
#include "Battleground.h"

class spell_item_massive_seaforium_charge : public SpellScriptLoader
{
    public:
        spell_item_massive_seaforium_charge() : SpellScriptLoader("spell_item_massive_seaforium_charge") { }

        class spell_item_massive_seaforium_charge_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_item_massive_seaforium_charge_SpellScript);

            void HandleItemRemove(SpellEffIndex  /*effIndex*/)
            {
                if (!GetHitUnit() || !GetHitUnit()->ToPlayer())
                    return;

                Player* target = GetHitUnit()->ToPlayer();
                target->DestroyItemCount(39213, 1, true);
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_item_massive_seaforium_charge_SpellScript::HandleItemRemove, EFFECT_0, SPELL_EFFECT_SUMMON_OBJECT_WILD);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_item_massive_seaforium_charge_SpellScript();
        }
};

enum TitaniumSealOfDalaran
{
    TITANIUM_SEAL_OF_DALARAN_BROADCAST_TEXT_ID_FLIP      = 32638,
    TITANIUM_SEAL_OF_DALARAN_BROADCAST_TEXT_ID_HEADS_UP  = 32663,
    TITANIUM_SEAL_OF_DALARAN_BROADCAST_TEXT_ID_FACE_DOWN = 32664
};

class spell_item_titanium_seal_of_dalaran : public SpellScriptLoader
{
    public:
        spell_item_titanium_seal_of_dalaran() : SpellScriptLoader("spell_item_titanium_seal_of_dalaran") {}

        class spell_item_titanium_seal_of_dalaran_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_item_titanium_seal_of_dalaran_SpellScript)

            void OnScriptEffect(SpellEffIndex effIndex)
            {
                PreventHitDefaultEffect(effIndex);

                Unit* caster = GetCaster();
                if (Player* player = caster->ToPlayer())
                {
                    LocaleConstant loc_idx = player->GetSession()->GetSessionDbLocaleIndex();
                    if (BroadcastText const* bct = sObjectMgr->GetBroadcastText(TITANIUM_SEAL_OF_DALARAN_BROADCAST_TEXT_ID_FLIP))
                        player->TextEmote(bct->GetText(loc_idx, player->getGender()));
                    if (urand(0,1))
                    {
                        if (BroadcastText const* bct = sObjectMgr->GetBroadcastText(TITANIUM_SEAL_OF_DALARAN_BROADCAST_TEXT_ID_FACE_DOWN))
                            player->TextEmote(bct->GetText(loc_idx, player->getGender()));
                    }
                    else
                    {
                        if (BroadcastText const* bct = sObjectMgr->GetBroadcastText(TITANIUM_SEAL_OF_DALARAN_BROADCAST_TEXT_ID_HEADS_UP))
                            player->TextEmote(bct->GetText(loc_idx, player->getGender()));
                    }
                }
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_item_titanium_seal_of_dalaran_SpellScript::OnScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_item_titanium_seal_of_dalaran_SpellScript();
        }
};

enum AmplifyDish
{
    SPELL_AMPLIFY_30S               = 13180,
    SPELL_AMPLIFY_10S               = 67799,
    SPELL_MENTAL_BATTLE             = 67810,
    SPELL_AMPLIFY_CHARM_30S         = 13181,
    SPELL_AMPLIFY_CHARM_10S         = 26740,
};

class spell_item_mind_amplify_dish : public SpellScriptLoader
{
    public:
        spell_item_mind_amplify_dish() : SpellScriptLoader("spell_item_mind_amplify_dish") {}

        class spell_item_mind_amplify_dish_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_item_mind_amplify_dish_SpellScript)

            void OnDummyEffect(SpellEffIndex effIndex)
            {
                PreventHitDefaultEffect(effIndex);

                Unit* caster = GetCaster();
                if (Player* player = caster->ToPlayer())
                {
                    if (Unit *target = GetHitUnit())
                    {
                        // little protection
                        if (target->ToCreature())
                            if (target->ToCreature()->GetCreatureTemplate()->rank > CREATURE_ELITE_NORMAL)
                                return;

                        if (GetSpellInfo()->Id != SPELL_AMPLIFY_10S)
                            if (target->getLevel() > 60)
                                return;

                        uint8 pct = std::max(0, 20+player->getLevel()-target->getLevel());
                        if (roll_chance_i(pct))
                            player->CastSpell(target, SPELL_MENTAL_BATTLE, true);
                        else if (roll_chance_i(pct))
                            player->CastSpell(target, GetSpellInfo()->Id == SPELL_AMPLIFY_10S ? SPELL_AMPLIFY_CHARM_10S : SPELL_AMPLIFY_CHARM_30S, true);
                    }
                }
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_item_mind_amplify_dish_SpellScript::OnDummyEffect, EFFECT_0, SPELL_EFFECT_DUMMY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_item_mind_amplify_dish_SpellScript();
        }
};

class spell_item_runescroll_of_fortitude : public SpellScriptLoader
{
    public:
        spell_item_runescroll_of_fortitude() : SpellScriptLoader("spell_item_runescroll_of_fortitude") {}

        class spell_item_runescroll_of_fortitude_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_item_runescroll_of_fortitude_SpellScript)

            void OnScriptEffect(SpellEffIndex effIndex)
            {
                PreventHitDefaultEffect(effIndex);

                if (Unit* target = GetHitUnit())
                {
                    if (target->getLevel() < 70)
                        return;

                    target->CastSpell(target, 72590, true); // Stamina spell (Fortitude)
                }
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_item_runescroll_of_fortitude_SpellScript::OnScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_item_runescroll_of_fortitude_SpellScript();
        }
};

class spell_item_branns_communicator : public SpellScriptLoader
{
    public:
        spell_item_branns_communicator() : SpellScriptLoader("spell_item_branns_communicator") {}

        class spell_item_branns_communicator_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_item_branns_communicator_SpellScript)

            void OnScriptEffect(SpellEffIndex effIndex)
            {
                PreventHitDefaultEffect(effIndex);

                if (Player* target = GetHitPlayer())
                {
                    target->KilledMonsterCredit(29579, 0); // Brann's entry
                    target->CastSpell(target, 55038, true); // Brann summoning spell
                }
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_item_branns_communicator_SpellScript::OnScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_item_branns_communicator_SpellScript();
        }
};

class spell_item_goblin_gumbo_kettle : public SpellScriptLoader
{
public:
    spell_item_goblin_gumbo_kettle() : SpellScriptLoader("spell_item_goblin_gumbo_kettle") { }

    class spell_item_goblin_gumbo_kettle_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_item_goblin_gumbo_kettle_AuraScript);

        void CalcPeriodic(AuraEffect const* /*effect*/, bool& isPeriodic, int32& amplitude)
        {
            isPeriodic = true;
            amplitude = urand(10*IN_MILLISECONDS, 40*IN_MILLISECONDS);
        }

        void Update(AuraEffect* effect)
        {
            PreventDefaultAction();
            effect->SetPeriodicTimer(urand(10*IN_MILLISECONDS, 40*IN_MILLISECONDS));
            if (Unit* owner = GetUnitOwner())
                owner->CastSpell(owner, 42755 /*Goblin Gumbo Trigger*/, true);
        }

        void Register()
        {
            DoEffectCalcPeriodic += AuraEffectCalcPeriodicFn(spell_item_goblin_gumbo_kettle_AuraScript::CalcPeriodic, EFFECT_0, SPELL_AURA_PROC_TRIGGER_SPELL);
            OnEffectUpdatePeriodic += AuraEffectUpdatePeriodicFn(spell_item_goblin_gumbo_kettle_AuraScript::Update, EFFECT_0, SPELL_AURA_PROC_TRIGGER_SPELL);
        }
    };

    AuraScript* GetAuraScript() const
    {
        return new spell_item_goblin_gumbo_kettle_AuraScript();
    }
};

enum mithrilSpurs
{
    SPELL_MITHRIL_SPEED         = 59916,
};

class spell_item_mithril_spurs : public SpellScriptLoader
{
public:
    spell_item_mithril_spurs() : SpellScriptLoader("spell_item_mithril_spurs") { }

    class spell_item_mithril_spurs_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_item_mithril_spurs_AuraScript);

        void OnApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
        {
            Unit* target = GetTarget();
            if (target->getLevel() <= 70)
                target->AddAura(SPELL_MITHRIL_SPEED, target);
        }

        void OnRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
        {
            Unit* target = GetTarget();
            target->RemoveAurasDueToSpell(SPELL_MITHRIL_SPEED);
        }

        void Register()
        {
            OnEffectApply += AuraEffectApplyFn(spell_item_mithril_spurs_AuraScript::OnApply, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
            OnEffectRemove += AuraEffectRemoveFn(spell_item_mithril_spurs_AuraScript::OnRemove, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
        }
    };

    AuraScript* GetAuraScript() const
    {
        return new spell_item_mithril_spurs_AuraScript();
    }
};

class spell_item_magic_dust : public SpellScriptLoader
{
public:
    spell_item_magic_dust() : SpellScriptLoader("spell_item_magic_dust") { }

    class spell_item_magic_dust_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_item_magic_dust_AuraScript);

        void OnApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
        {
            Unit* target = GetTarget();
            if (target->getLevel() >= 30)
            {
                uint8 chance = 100 - std::min<uint8>(100, target->getLevel() - 30 * urand(3, 10));
                if (!roll_chance_i(chance))
                    PreventDefaultAction();
            }
        }

        void Register()
        {
            OnEffectApply += AuraEffectApplyFn(spell_item_magic_dust_AuraScript::OnApply, EFFECT_0, SPELL_AURA_MOD_STUN, AURA_EFFECT_HANDLE_REAL);
        }
    };

    AuraScript* GetAuraScript() const
    {
        return new spell_item_magic_dust_AuraScript();
    }
};

class spell_item_toy_train_set : public SpellScriptLoader
{
    public:
        spell_item_toy_train_set() : SpellScriptLoader("spell_item_toy_train_set") {}

        class spell_item_toy_train_set_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_item_toy_train_set_SpellScript)

            void HandleScriptEffect(SpellEffIndex effIndex)
            {
                PreventHitDefaultEffect(effIndex);
                if (Unit* target = GetHitUnit())
                    target->HandleEmoteCommand(EMOTE_ONESHOT_TRAIN);
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_item_toy_train_set_SpellScript::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_item_toy_train_set_SpellScript();
        }
};

enum eChicken
{
    SPELL_ROCKET_CHICKEN_EMOTE          = 45255,
};

class spell_item_rocket_chicken : public SpellScriptLoader
{
public:
    spell_item_rocket_chicken() : SpellScriptLoader("spell_item_rocket_chicken") { }

    class spell_item_rocket_chicken_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_item_rocket_chicken_AuraScript);

        void HandleDummyTick(AuraEffect const* /*aurEff*/)
        {
            if (roll_chance_i(5))
            {
                GetTarget()->ToCreature()->DespawnOrUnsummon(8000);
                GetTarget()->Kill(GetTarget(), GetTarget());
            }
            else if (roll_chance_i(50))
                GetTarget()->CastSpell(GetTarget(), SPELL_ROCKET_CHICKEN_EMOTE, false);
        }

        void Register()
        {
            OnEffectPeriodic += AuraEffectPeriodicFn(spell_item_rocket_chicken_AuraScript::HandleDummyTick, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY);
        }
    };

    AuraScript* GetAuraScript() const
    {
        return new spell_item_rocket_chicken_AuraScript();
    }
};

class spell_item_sleepy_willy : public SpellScriptLoader
{
    public:
        spell_item_sleepy_willy() : SpellScriptLoader("spell_item_sleepy_willy") {}

        class spell_item_sleepy_willy_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_item_sleepy_willy_SpellScript);

            void SelectTarget(std::list<WorldObject*>& targets)
            {
                Creature* target = nullptr;
                for (std::list<WorldObject*>::const_iterator itr = targets.begin(); itr != targets.end(); ++itr)
                    if (Creature* creature = (*itr)->ToCreature())
                        if (creature->IsCritter())
                        {
                            target = creature;
                            break;
                        }

                targets.clear();
                if (target)
                    targets.push_back(target);
            }

            void HandleScriptEffect(SpellEffIndex effIndex)
            {
                PreventHitDefaultEffect(effIndex);
                Creature* target = GetHitCreature();
                if (!target)
                    return;

                GetCaster()->CastSpell(target, GetEffectValue(), false);
            }

            void Register()
            {
                OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_item_sleepy_willy_SpellScript::SelectTarget, EFFECT_0, TARGET_UNIT_SRC_AREA_ENTRY);
                OnEffectHitTarget += SpellEffectFn(spell_item_sleepy_willy_SpellScript::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_item_sleepy_willy_SpellScript();
        }
};

class spell_item_lil_phylactery : public SpellScriptLoader
{
    public:
        spell_item_lil_phylactery() : SpellScriptLoader("spell_item_lil_phylactery") { }

        class spell_item_lil_phylactery_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_item_lil_phylactery_AuraScript);

            bool CheckProc(ProcEventInfo& eventInfo)
            {
                return eventInfo.GetActionTarget() && (eventInfo.GetActionTarget()->GetTypeId() != TYPEID_UNIT || eventInfo.GetActionTarget()->ToCreature()->isWorldBoss());
            }

            void HandleProc(AuraEffect const*  /*aurEff*/, ProcEventInfo&  /*eventInfo*/)
            {
                PreventDefaultAction();

                if (Unit* critter = ObjectAccessor::GetUnit(*GetUnitOwner(), GetUnitOwner()->GetCritterGUID()))
                    GetUnitOwner()->CastSpell(critter, 69731 /*SPELL_LICH_PET_AURA_ON_KILL*/, true);
            }

            void Register()
            {
                DoCheckProc += AuraCheckProcFn(spell_item_lil_phylactery_AuraScript::CheckProc);
                OnEffectProc += AuraEffectProcFn(spell_item_lil_phylactery_AuraScript::HandleProc, EFFECT_0, SPELL_AURA_PROC_TRIGGER_SPELL);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_item_lil_phylactery_AuraScript();
        }
};

class spell_item_shifting_naaru_silver : public SpellScriptLoader
{
public:
    spell_item_shifting_naaru_silver() : SpellScriptLoader("spell_item_shifting_naaru_silver") { }

    class spell_item_shifting_naaru_silver_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_item_shifting_naaru_silver_AuraScript);

        void OnApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
        {
            if (GetTarget() == GetCaster())
                if (Aura* aur = GetTarget()->AddAura(45044 /*Limitless Power*/, GetTarget()))
                    aur->SetDuration(GetDuration());
        }

        void OnRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
        {
            if (Aura* aur = GetTarget()->GetAura(45044 /*Limitless Power*/, GetTarget()->GetGUID()))
                aur->SetDuration(0);
        }

        void OnBaseRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
        {
            GetUnitOwner()->RemoveDynObject(45043);
        }

        void Register()
        {
            if (m_scriptSpellId == 45043)
            {
                OnEffectApply += AuraEffectApplyFn(spell_item_shifting_naaru_silver_AuraScript::OnApply, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
                AfterEffectRemove += AuraEffectRemoveFn(spell_item_shifting_naaru_silver_AuraScript::OnRemove, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
            }
            else
                AfterEffectRemove += AuraEffectRemoveFn(spell_item_shifting_naaru_silver_AuraScript::OnBaseRemove, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
        }
    };

    AuraScript* GetAuraScript() const
    {
        return new spell_item_shifting_naaru_silver_AuraScript();
    }
};

class spell_item_toxic_wasteling : public SpellScriptLoader
{
    public:
        spell_item_toxic_wasteling() : SpellScriptLoader("spell_item_toxic_wasteling") {}

        class spell_item_toxic_wasteling_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_item_toxic_wasteling_SpellScript);

            void HandleJump(SpellEffIndex effIndex)
            {
                PreventHitDefaultEffect(effIndex);
                if (Creature* target = GetHitCreature())
                {
                    GetCaster()->GetMotionMaster()->Clear(false);
                    GetCaster()->GetMotionMaster()->MoveIdle();
                    GetCaster()->ToCreature()->SetHomePosition(target->GetPositionX(), target->GetPositionY(), target->GetPositionZ(), 0.0f);
                    GetCaster()->GetMotionMaster()->MoveJump(target->GetPositionX(), target->GetPositionY(), target->GetPositionZ(), 12.0f, 3.0f, 1);
                    target->DespawnOrUnsummon(1500);
                }
            }

            void HandleScriptEffect(SpellEffIndex effIndex)
            {
                PreventHitDefaultEffect(effIndex);
            }

            void Register()
            {
                OnEffectLaunchTarget += SpellEffectFn(spell_item_toxic_wasteling_SpellScript::HandleJump, EFFECT_0, SPELL_EFFECT_JUMP);
                OnEffectHitTarget += SpellEffectFn(spell_item_toxic_wasteling_SpellScript::HandleScriptEffect, EFFECT_1, SPELL_EFFECT_SCRIPT_EFFECT);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_item_toxic_wasteling_SpellScript();
        }
};

class spell_item_lil_xt : public SpellScriptLoader
{
    public:
        spell_item_lil_xt() : SpellScriptLoader("spell_item_lil_xt") {}

        class spell_item_lil_xt_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_item_lil_xt_SpellScript);

            void HandleScriptEffect(SpellEffIndex effIndex)
            {
                PreventHitDefaultEffect(effIndex);
                Creature* target = GetHitCreature();
                if (!target)
                    return;
                GetCaster()->CastSpell(target, GetEffectValue(), false);
            }

            void HandleDummy(SpellEffIndex effIndex)
            {
                PreventHitDefaultEffect(effIndex);
                Creature* target = GetHitCreature();
                if (!target)
                    return;
                if (GetCaster()->GetTypeId() == TYPEID_UNIT && GetCaster()->ToCreature()->AI())
                    GetCaster()->ToCreature()->AI()->Talk(2);
                target->DespawnOrUnsummon(500);
            }

            void Register()
            {
                if (m_scriptSpellId == 76098)
                    OnEffectHitTarget += SpellEffectFn(spell_item_lil_xt_SpellScript::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
                else
                    OnEffectHitTarget += SpellEffectFn(spell_item_lil_xt_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_item_lil_xt_SpellScript();
        }
};

class spell_item_essence_of_life : public SpellScriptLoader
{
    public:
        spell_item_essence_of_life() : SpellScriptLoader("spell_item_essence_of_life") { }

        class spell_item_essence_of_life_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_item_essence_of_life_AuraScript);

            bool CheckProc(ProcEventInfo& eventInfo)
            {
                SpellInfo const* spellInfo = eventInfo.GetDamageInfo()->GetSpellInfo();
                if (!spellInfo || !spellInfo->HasEffect(SPELL_EFFECT_HEAL))
                    return false;

                return spellInfo->ManaCost > 0 || spellInfo->ManaCostPercentage > 0 || (spellInfo->SpellFamilyName == SPELLFAMILY_PALADIN && spellInfo->SpellIconID == 156);
            }

            void Register()
            {
                DoCheckProc += AuraCheckProcFn(spell_item_essence_of_life_AuraScript::CheckProc);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_item_essence_of_life_AuraScript();
        }
};

const uint32 crazyAlchemistTable[5] =
{
    53909, // Wild Magic
    53908, // Potion of Speed
    53762, // Indestructible Potion
    43185, // Runic Healing Potion
    43186  // Runic Mana Potion
};

class spell_item_crazy_alchemists_potion : public SpellScriptLoader
{
    public:
        spell_item_crazy_alchemists_potion() : SpellScriptLoader("spell_item_crazy_alchemists_potion") {}

        class spell_item_crazy_alchemists_potion_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_item_crazy_alchemists_potion_SpellScript);

            void HandleHeal(SpellEffIndex /*effIndex*/)
            {
                // Xinef: 20% to get additional effect, guessed
                if (roll_chance_i(20))
                    GetCaster()->CastSpell(GetCaster(), crazyAlchemistTable[urand(0, (GetCaster()->getPowerType() == POWER_MANA ? 4 : 3))], true);
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_item_crazy_alchemists_potion_SpellScript::HandleHeal, EFFECT_0, SPELL_EFFECT_HEAL);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_item_crazy_alchemists_potion_SpellScript();
        }
};

class spell_item_skull_of_impeding_doom : public SpellScriptLoader
{
    public:
        spell_item_skull_of_impeding_doom() : SpellScriptLoader("spell_item_skull_of_impeding_doom") { }

        class spell_item_skull_of_impeding_doom_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_item_skull_of_impeding_doom_AuraScript);

            void CalculateDamageAmount(AuraEffect const* /*aurEff*/, int32& amount, bool& /*canBeRecalculated*/)
            {
                if (!GetCaster())
                    return;

                amount = GetCaster()->GetMaxHealth()*0.12f; // 5 ticks which reduce health by 60%
            }

            void CalculateManaLeechAmount(AuraEffect const* /*aurEff*/, int32& amount, bool& /*canBeRecalculated*/)
            {
                if (!GetCaster() || GetCaster()->getPowerType() != POWER_MANA)
                    return;

                amount = GetCaster()->GetMaxPower(POWER_MANA)*0.12f; // 5 ticks which reduce health by 60%
            }

            void Register()
            {
                DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_item_skull_of_impeding_doom_AuraScript::CalculateDamageAmount, EFFECT_1, SPELL_AURA_PERIODIC_DAMAGE);
                DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_item_skull_of_impeding_doom_AuraScript::CalculateManaLeechAmount, EFFECT_2, SPELL_AURA_PERIODIC_MANA_LEECH);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_item_skull_of_impeding_doom_AuraScript();
        }
};

class spell_item_carrot_on_a_stick : public SpellScriptLoader
{
public:
    spell_item_carrot_on_a_stick() : SpellScriptLoader("spell_item_carrot_on_a_stick") { }

    class spell_item_carrot_on_a_stick_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_item_carrot_on_a_stick_AuraScript);

        void OnApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
        {
            PreventDefaultAction();
            if (GetTarget()->getLevel() > 70)
                return;
            GetTarget()->CastSpell(GetTarget(), 48402, true);
        }

        void OnRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
        {
            PreventDefaultAction();
            GetTarget()->RemoveAurasDueToSpell(48402);
        }

        void Register()
        {
            OnEffectApply += AuraEffectApplyFn(spell_item_carrot_on_a_stick_AuraScript::OnApply, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
            OnEffectRemove += AuraEffectRemoveFn(spell_item_carrot_on_a_stick_AuraScript::OnRemove, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
        }
    };

    AuraScript* GetAuraScript() const
    {
        return new spell_item_carrot_on_a_stick_AuraScript();
    }
};

enum Feast
{
    SPELL_GREAT_FEAST                        = 57301,
    SPELL_FISH_FEAST                         = 57426,
    SPELL_SMALL_FEAST                        = 58474,
    SPELL_GIGANTIC_FEAST                     = 58465,

    GREAT_FEAST_BROADCAST_TEXT_ID_PREPARE    = 31843,
    FISH_FEAST_BROADCAST_TEXT_ID_PREPARE     = 31844,
    SMALL_FEAST_BROADCAST_TEXT_ID_PREPARE    = 31845,
    GIGANTIC_FEAST_BROADCAST_TEXT_ID_PREPARE = 31846
};

class spell_item_feast : public SpellScriptLoader
{
    public:
        spell_item_feast() : SpellScriptLoader("spell_item_feast") {}

        class spell_item_feast_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_item_feast_SpellScript);

            bool Load()
            {
                return GetCaster()->GetTypeId() == TYPEID_PLAYER;
            }

            void HandleScriptEffect(SpellEffIndex effIndex)
            {
                PreventHitDefaultEffect(effIndex);

                Unit* caster = GetCaster();
                if (Player* player = caster->ToPlayer())
                {
                    LocaleConstant loc_idx = player->GetSession()->GetSessionDbLocaleIndex();

                    switch(GetSpellInfo()->Id)
                    {
                        case SPELL_GREAT_FEAST:
                            if (BroadcastText const* bct = sObjectMgr->GetBroadcastText(GREAT_FEAST_BROADCAST_TEXT_ID_PREPARE))
                                player->MonsterTextEmote(bct->GetText(loc_idx, player->getGender()).c_str(), player, false);
                            break;
                        case SPELL_FISH_FEAST:
                            if (BroadcastText const* bct = sObjectMgr->GetBroadcastText(FISH_FEAST_BROADCAST_TEXT_ID_PREPARE))
                                player->MonsterTextEmote(bct->GetText(loc_idx, player->getGender()).c_str(), player, false);
                            break;
                        case SPELL_SMALL_FEAST:
                            if (BroadcastText const* bct = sObjectMgr->GetBroadcastText(SMALL_FEAST_BROADCAST_TEXT_ID_PREPARE))
                                player->MonsterTextEmote(bct->GetText(loc_idx, player->getGender()).c_str(), player, false);
                            break;
                        case SPELL_GIGANTIC_FEAST:
                            if (BroadcastText const* bct = sObjectMgr->GetBroadcastText(GIGANTIC_FEAST_BROADCAST_TEXT_ID_PREPARE))
                                player->MonsterTextEmote(bct->GetText(loc_idx, player->getGender()).c_str(), player, false);
                            break;
                    }
                }
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_item_feast_SpellScript::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_item_feast_SpellScript();
        }
};

class spell_item_gnomish_universal_remote : public SpellScriptLoader
{
    public:
        spell_item_gnomish_universal_remote() : SpellScriptLoader("spell_item_gnomish_universal_remote") {}

        class spell_item_gnomish_universal_remote_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_item_gnomish_universal_remote_SpellScript);

            void HandleDummy(SpellEffIndex /*effIndex*/)
            {
                Unit* target = GetHitUnit();
                if (!target)
                    return;

                uint32 spellId = 0;
                switch (urand(0,2))
                {
                    case 0: spellId = 8345; break; // charm
                    case 1: spellId = 8346; break; // root
                    case 2: spellId = 8347; break; // threat
                }
                if (spellId)
                    GetCaster()->CastSpell(target, spellId, true);
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_item_gnomish_universal_remote_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_item_gnomish_universal_remote_SpellScript();
        }
};

class spell_item_strong_anti_venom : public SpellScriptLoader
{
    public:
        spell_item_strong_anti_venom() : SpellScriptLoader("spell_item_strong_anti_venom") {}

        class spell_item_strong_anti_venom_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_item_strong_anti_venom_SpellScript);

            void HandleDummy(SpellEffIndex effIndex)
            {
                PreventHitDefaultEffect(effIndex);
                if (Unit* target = GetHitUnit())
                {
                    std::list<uint32> removeList;
                    Unit::AuraMap const& auras = target->GetOwnedAuras();
                    for (Unit::AuraMap::const_iterator itr = auras.begin(); itr != auras.end(); ++itr)
                    {
                        Aura* aura = itr->second;
                        if (aura->GetSpellInfo()->SpellLevel > 35 || aura->GetSpellInfo()->Dispel != DISPEL_POISON)
                            continue;

                        removeList.push_back(aura->GetId());
                    }

                    for (std::list<uint32>::const_iterator itr = removeList.begin(); itr != removeList.end(); ++itr)
                        target->RemoveAurasDueToSpell(*itr);
                }
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_item_strong_anti_venom_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_item_strong_anti_venom_SpellScript();
        }
};

enum GnomishShrinkRay
{
    SPELL_GNOMISH_SHRINK_RAY_SELF = 13004,
    SPELL_GNOMISH_SHRINK_RAY_TARGET = 13003,
};

class spell_item_gnomish_shrink_ray : public SpellScriptLoader
{
    public:
        spell_item_gnomish_shrink_ray() : SpellScriptLoader("spell_item_gnomish_shrink_ray") { }

        class spell_item_gnomish_shrink_ray_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_item_gnomish_shrink_ray_SpellScript);

            void HandleDummy(SpellEffIndex /*effIndex*/)
            {
                Unit* caster = GetCaster();
                if (Unit* target = GetHitUnit())
                {
                    if (urand(0, 99) < 15)
                        caster->CastSpell(caster, SPELL_GNOMISH_SHRINK_RAY_SELF, true, nullptr);
                    else
                        caster->CastSpell(target, SPELL_GNOMISH_SHRINK_RAY_TARGET, true, nullptr);
                }
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_item_gnomish_shrink_ray_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_item_gnomish_shrink_ray_SpellScript();
        }
};

class spell_item_goblin_weather_machine : public SpellScriptLoader
{
    public:
        spell_item_goblin_weather_machine() : SpellScriptLoader("spell_item_goblin_weather_machine") { }

        class spell_item_goblin_weather_machine_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_item_goblin_weather_machine_SpellScript);

            void HandleScriptEffect(SpellEffIndex /*effIndex*/)
            {
                if (Unit* target = GetHitUnit())
                {
                    uint32 spellId = 46736;
                    if (uint8 add = urand(0, 3))
                        spellId += add+1;

                    target->CastSpell(target, spellId, true);
                }
            }

            void Register()
            {
                if (m_scriptSpellId == 46203)
                    OnEffectHitTarget += SpellEffectFn(spell_item_goblin_weather_machine_SpellScript::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_item_goblin_weather_machine_SpellScript();
        }

        class spell_item_goblin_weather_machine_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_item_goblin_weather_machine_AuraScript);

            void OnRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
            {
                if (roll_chance_i(50))
                    return;

                uint32 spellId = 46736;
                if (uint8 add = urand(0, 3))
                    spellId += add+1;

                GetUnitOwner()->CastSpell(GetUnitOwner(), spellId, true);
            }

            void Register()
            {
                if (m_scriptSpellId != 46203)
                    AfterEffectRemove += AuraEffectRemoveFn(spell_item_goblin_weather_machine_AuraScript::OnRemove, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_item_goblin_weather_machine_AuraScript();
        }
};

class spell_item_light_lamp : public SpellScriptLoader
{
    public:
        spell_item_light_lamp() : SpellScriptLoader("spell_item_light_lamp") { }

        class spell_item_light_lamp_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_item_light_lamp_SpellScript);

            void HandleActivateObject(SpellEffIndex effIndex)
            {
                PreventHitDefaultEffect(effIndex);
                if (GameObject* go = GetHitGObj())
                    go->UseDoorOrButton();
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_item_light_lamp_SpellScript::HandleActivateObject, EFFECT_0, SPELL_EFFECT_ACTIVATE_OBJECT);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_item_light_lamp_SpellScript();
        }
};

class spell_item_fetch_ball : public SpellScriptLoader
{
    public:
        spell_item_fetch_ball() : SpellScriptLoader("spell_item_fetch_ball") {}

        class spell_item_fetch_ball_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_item_fetch_ball_SpellScript);

            void SelectTarget(std::list<WorldObject*>& targets)
            {
                Creature* target = nullptr;
                for (std::list<WorldObject*>::const_iterator itr = targets.begin(); itr != targets.end(); ++itr)
                    if (Creature* creature = (*itr)->ToCreature())
                    {
                        if (creature->GetOwnerGUID() == GetCaster()->GetOwnerGUID() && !creature->IsNonMeleeSpellCast(false) && 
                            creature->GetMotionMaster()->GetCurrentMovementGeneratorType() != POINT_MOTION_TYPE)
                        {
                            target = creature;
                            break;
                        }
                    }

                targets.clear();
                if (target)
                    targets.push_back(target);
            }

            void Register()
            {
                OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_item_fetch_ball_SpellScript::SelectTarget, EFFECT_0, TARGET_UNIT_SRC_AREA_ENTRY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_item_fetch_ball_SpellScript();
        }
};

enum oracleAblutions
{
    SPELL_ABLUTION_RUNIC            = 59812,
    SPELL_ABLUTION_MANA             = 59813,
    SPELL_ABLUTION_RAGE             = 59814,
    SPELL_ABLUTION_ENERGY           = 59815,
};

class spell_item_oracle_ablutions : public SpellScriptLoader
{
    public:
        spell_item_oracle_ablutions() : SpellScriptLoader("spell_item_oracle_ablutions") {}

        class spell_item_oracle_ablutions_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_item_oracle_ablutions_SpellScript)

            void HandleScriptEffect(SpellEffIndex effIndex)
            {
                PreventHitDefaultEffect(effIndex);
                Unit* caster = GetCaster();
                switch (caster->getPowerType())
                {
                    case POWER_RUNIC_POWER:
                        caster->CastSpell(caster, SPELL_ABLUTION_RUNIC, true);
                        break;
                    case POWER_MANA:
                    {
                        int32 mana = CalculatePct(caster->GetMaxPower(POWER_MANA), 5.0f);
                        caster->CastCustomSpell(SPELL_ABLUTION_MANA, SPELLVALUE_BASE_POINT0, mana, caster, true);
                        break;
                    }
                    case POWER_RAGE:
                        caster->CastSpell(caster, SPELL_ABLUTION_RAGE, true);
                        break;
                    case POWER_ENERGY:
                        caster->CastSpell(caster, SPELL_ABLUTION_ENERGY, true);
                        break;
                    default:
                        break;
                }
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_item_oracle_ablutions_SpellScript::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_item_oracle_ablutions_SpellScript();
        }
};

class spell_item_trauma : public SpellScriptLoader
{
    public:
        spell_item_trauma() : SpellScriptLoader("spell_item_trauma") { }

        class spell_item_trauma_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_item_trauma_AuraScript);

            bool CheckProc(ProcEventInfo& eventInfo)
            {
                return eventInfo.GetActionTarget();
            }

            void HandleProc(AuraEffect const* /*aurEff*/, ProcEventInfo& eventInfo)
            {
                PreventDefaultAction();
                GetUnitOwner()->CastSpell(eventInfo.GetActionTarget(), GetSpellInfo()->Effects[EFFECT_0].TriggerSpell, true);
            }

            void Register()
            {
                DoCheckProc += AuraCheckProcFn(spell_item_trauma_AuraScript::CheckProc);
                OnEffectProc += AuraEffectProcFn(spell_item_trauma_AuraScript::HandleProc, EFFECT_0, SPELL_AURA_PROC_TRIGGER_SPELL);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_item_trauma_AuraScript();
        }
};

class spell_item_blade_ward_enchant : public SpellScriptLoader
{
    public:
        spell_item_blade_ward_enchant() : SpellScriptLoader("spell_item_blade_ward_enchant") { }

        class spell_item_blade_ward_enchant_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_item_blade_ward_enchant_AuraScript);

            void HandleProc(AuraEffect const* /*aurEff*/, ProcEventInfo& eventInfo)
            {
                PreventDefaultAction();
                const SpellInfo* spellInfo = sSpellMgr->GetSpellInfo(64442 /*SPELL_BLADE_WARDING*/);
                int32 basepoints = spellInfo->Effects[EFFECT_0].CalcValue() * this->GetStackAmount();
                eventInfo.GetActionTarget()->CastCustomSpell(spellInfo->Id, SPELLVALUE_BASE_POINT0, basepoints, eventInfo.GetActor(), true);
            }

            void Register()
            {
                OnEffectProc += AuraEffectProcFn(spell_item_blade_ward_enchant_AuraScript::HandleProc, EFFECT_1, SPELL_AURA_PROC_TRIGGER_SPELL);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_item_blade_ward_enchant_AuraScript();
        }
};

class spell_item_blood_draining_enchant : public SpellScriptLoader
{
    public:
        spell_item_blood_draining_enchant() : SpellScriptLoader("spell_item_blood_draining_enchant") { }

        class spell_item_blood_draining_enchant_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_item_blood_draining_enchant_AuraScript);

            void HandleProc(AuraEffect const* /*aurEff*/, ProcEventInfo& eventInfo)
            {
                PreventDefaultAction();
                if ((eventInfo.GetActionTarget()->GetHealth() - eventInfo.GetDamageInfo()->GetDamage()) >= eventInfo.GetActionTarget()->CountPctFromMaxHealth(35))
                    return;

                const SpellInfo* spellInfo = sSpellMgr->GetSpellInfo(64569 /*SPELL_BLOOD_RESERVE*/);
                int32 basepoints = spellInfo->Effects[EFFECT_0].CalcValue() * this->GetStackAmount();
                eventInfo.GetActionTarget()->CastCustomSpell(spellInfo->Id, SPELLVALUE_BASE_POINT0, basepoints, eventInfo.GetActionTarget(), true);
                eventInfo.GetActionTarget()->RemoveAurasDueToSpell(GetSpellInfo()->Id); // Remove rest auras
            }

            void Register()
            {
                OnEffectProc += AuraEffectProcFn(spell_item_blood_draining_enchant_AuraScript::HandleProc, EFFECT_0, SPELL_AURA_PROC_TRIGGER_SPELL);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_item_blood_draining_enchant_AuraScript();
        }
};

class spell_item_dragon_kite_summon_lightning_bunny : public SpellScriptLoader
{
    public:
        spell_item_dragon_kite_summon_lightning_bunny() : SpellScriptLoader("spell_item_dragon_kite_summon_lightning_bunny") { }

        class spell_item_dragon_kite_summon_lightning_bunny_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_item_dragon_kite_summon_lightning_bunny_SpellScript);

            void SetDest(SpellDestination& dest)
            {
                // Adjust effect summon position
                Position const offset = { 3.0f, 3.0f, 20.0f, 0.0f };
                dest.Relocate(*GetCaster());
                dest.RelocateOffset(offset);
            }

            void Register()
            {
                OnDestinationTargetSelect += SpellDestinationTargetSelectFn(spell_item_dragon_kite_summon_lightning_bunny_SpellScript::SetDest, EFFECT_0, TARGET_DEST_CASTER_RANDOM);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_item_dragon_kite_summon_lightning_bunny_SpellScript();
        }
};

class spell_item_enchanted_broom_periodic : public SpellScriptLoader
{
public:
    spell_item_enchanted_broom_periodic() : SpellScriptLoader("spell_item_enchanted_broom_periodic") { }

    class spell_item_enchanted_broom_periodic_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_item_enchanted_broom_periodic_AuraScript);

        void HandlePeriodicTick(AuraEffect const* /*aurEff*/)
        {
            PreventDefaultAction();
            if (Unit* owner = GetTarget()->GetOwner())
            {
                if (owner->isMoving())
                {
                    GetTarget()->GetMotionMaster()->MoveFollow(owner, PET_FOLLOW_DIST, GetTarget()->GetFollowAngle(), MOTION_SLOT_ACTIVE);
                }
                else
                {
                    GetTarget()->CastSpell(GetTarget(), GetId()-1, true);
                    GetTarget()->GetMotionMaster()->Clear(false);
                    GetTarget()->GetMotionMaster()->MoveRandom(5.0f);
                }
            }
        }

        void Register()
        {
            OnEffectPeriodic += AuraEffectPeriodicFn(spell_item_enchanted_broom_periodic_AuraScript::HandlePeriodicTick, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
        }
    };

    AuraScript* GetAuraScript() const
    {
        return new spell_item_enchanted_broom_periodic_AuraScript();
    }
};

class spell_item_summon_or_dismiss : public SpellScriptLoader
{
    public:
        spell_item_summon_or_dismiss() : SpellScriptLoader("spell_item_summon_or_dismiss") { }

        class spell_item_summon_or_dismiss_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_item_summon_or_dismiss_SpellScript);

            void HandleSummon(SpellEffIndex effIndex)
            {
                for (Unit::ControlSet::iterator itr = GetCaster()->m_Controlled.begin(); itr != GetCaster()->m_Controlled.end(); ++itr)
                {
                    if (GetSpellInfo()->Effects[effIndex].MiscValue >= 0 && (*itr)->GetEntry() == uint32(GetSpellInfo()->Effects[effIndex].MiscValue))
                    {
                        (*itr)->ToTempSummon()->UnSummon();
                        PreventHitDefaultEffect(effIndex);
                        return;
                    }
                }
            }

            void Register()
            {
                OnEffectHit += SpellEffectFn(spell_item_summon_or_dismiss_SpellScript::HandleSummon, EFFECT_ALL, SPELL_EFFECT_SUMMON);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_item_summon_or_dismiss_SpellScript;
        }
};

enum eDreanicPaleAle
{
    SPELL_PINK_ELEKK            = 49908
};

class spell_item_draenic_pale_ale : public SpellScriptLoader
{
    public:
        spell_item_draenic_pale_ale() : SpellScriptLoader("spell_item_draenic_pale_ale") { }

        class spell_item_draenic_pale_ale_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_item_draenic_pale_ale_SpellScript);

            void HandleSummon(SpellEffIndex effIndex)
            {
                PreventHitDefaultEffect(effIndex);
                if (roll_chance_i(70))
                    return;

                GetCaster()->CastSpell(GetCaster(), SPELL_PINK_ELEKK, true);

                float radius = GetSpellInfo()->Effects[effIndex].CalcRadius();
                for (uint8 count = 0; count < GetEffectValue(); ++count)
                {
                    Position pos = *GetCaster();
                    GetCaster()->GetClosePoint(pos.m_positionX, pos.m_positionY, pos.m_positionZ, pos.m_orientation, radius, M_PI - 1.2f + 0.3f * urand(0, 8));
                    Creature* summon = GetCaster()->SummonCreature(GetSpellInfo()->Effects[effIndex].MiscValue, pos, TEMPSUMMON_TIMED_DESPAWN, GetSpellInfo()->GetDuration());
                    if (!summon)
                        continue;

                    summon->SetOwnerGUID(GetCaster()->GetGUID());
                    summon->setFaction(GetCaster()->getFaction());
                    summon->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_PC|UNIT_FLAG_IMMUNE_TO_NPC);
                    summon->SetReactState(REACT_PASSIVE);
                    summon->GetMotionMaster()->MoveFollow(GetCaster(), PET_FOLLOW_DIST, GetCaster()->GetAngle(summon), MOTION_SLOT_CONTROLLED);
                    GetSpell()->ExecuteLogEffectSummonObject(effIndex, summon);
                }
            }

            void Register()
            {
                OnEffectHit += SpellEffectFn(spell_item_draenic_pale_ale_SpellScript::HandleSummon, EFFECT_0, SPELL_EFFECT_SUMMON);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_item_draenic_pale_ale_SpellScript;
        }
};

enum eMoleMachine
{
    SPELL_MOLE_MACHINE_PORT_TO_GRIM_GUZZLER     = 47523,
};

class spell_item_direbrew_remote : public SpellScriptLoader
{
    public:
        spell_item_direbrew_remote() : SpellScriptLoader("spell_item_direbrew_remote") { }

        class spell_item_direbrew_remote_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_item_direbrew_remote_AuraScript);

            void HandlePeriodicTick(AuraEffect const* aurEff)
            {
                PreventDefaultAction();
                if (aurEff->GetTickNumber() >= 2)
                {
                    SetDuration(0);
                    GetTarget()->CastSpell(GetTarget(), SPELL_MOLE_MACHINE_PORT_TO_GRIM_GUZZLER, true);
                }
            }

            void Register()
            {
                OnEffectPeriodic += AuraEffectPeriodicFn(spell_item_direbrew_remote_AuraScript::HandlePeriodicTick, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_item_direbrew_remote_AuraScript();
        }

        class spell_item_direbrew_remote_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_item_direbrew_remote_SpellScript)

            void HandleScriptEffect(SpellEffIndex effIndex)
            {
                PreventHitDefaultEffect(effIndex);
                if (Unit* target = GetHitUnit())
                    target->HandleEmoteCommand(EMOTE_ONESHOT_WAVE);
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_item_direbrew_remote_SpellScript::HandleScriptEffect, EFFECT_1, SPELL_EFFECT_SCRIPT_EFFECT);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_item_direbrew_remote_SpellScript();
        }
};

enum EyeOfGruul
{
    SPELL_DRUID_ITEM_HEALING_TRANCE   = 37721,
    SPELL_PALADIN_ITEM_HEALING_TRANCE = 37723,
    SPELL_PRIEST_ITEM_HEALING_TRANCE  = 37706,
    SPELL_SHAMAN_ITEM_HEALING_TRANCE  = 37722
};

// 37705 - Healing Discount
class spell_item_eye_of_gruul_healing_discount : public SpellScriptLoader
{
    public:
        spell_item_eye_of_gruul_healing_discount() : SpellScriptLoader("spell_item_eye_of_gruul_healing_discount") { }

        class spell_item_eye_of_gruul_healing_discount_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_item_eye_of_gruul_healing_discount_AuraScript);

            bool Validate(SpellInfo const* /*spellInfo*/)
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_DRUID_ITEM_HEALING_TRANCE)
                    || !sSpellMgr->GetSpellInfo(SPELL_PALADIN_ITEM_HEALING_TRANCE)
                    || !sSpellMgr->GetSpellInfo(SPELL_PRIEST_ITEM_HEALING_TRANCE)
                    || !sSpellMgr->GetSpellInfo(SPELL_SHAMAN_ITEM_HEALING_TRANCE))
                    return false;
                return true;
            }

            void HandleProc(AuraEffect const* aurEff, ProcEventInfo& /*eventInfo*/)
            {
                PreventDefaultAction();
                if (Unit* unitTarget = GetTarget())
                {
                    uint32 spell_id = 0;
                    switch (unitTarget->getClass())
                    {
                        case CLASS_DRUID:
                            spell_id = SPELL_DRUID_ITEM_HEALING_TRANCE;
                            break;
                        case CLASS_PALADIN:
                            spell_id = SPELL_PALADIN_ITEM_HEALING_TRANCE;
                            break;
                        case CLASS_PRIEST:
                            spell_id = SPELL_PRIEST_ITEM_HEALING_TRANCE;
                            break;
                        case CLASS_SHAMAN:
                            spell_id = SPELL_SHAMAN_ITEM_HEALING_TRANCE;
                            break;
                        default:
                            return; // ignore for non-healing classes
                    }

                    unitTarget->CastSpell(unitTarget, spell_id, true, NULL, aurEff);
                }
            }

            void Register()
            {
                OnEffectProc += AuraEffectProcFn(spell_item_eye_of_gruul_healing_discount_AuraScript::HandleProc, EFFECT_0, SPELL_AURA_PROC_TRIGGER_SPELL);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_item_eye_of_gruul_healing_discount_AuraScript();
        }
};

enum eArgentKnight
{
    SPELL_SUMMON_ARGENT_KNIGHT_ALLIANCE = 54296
};

class spell_item_summon_argent_knight :  public SpellScriptLoader
{
    public:
        spell_item_summon_argent_knight() : SpellScriptLoader("spell_item_summon_argent_knight") { }

        class spell_item_summon_argent_knight_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_item_summon_argent_knight_SpellScript);

            void HandleOnEffectHit(SpellEffIndex effIndex)
            {
                if (Unit* caster = GetCaster())
                {
                    if (caster->GetTypeId() == TYPEID_PLAYER)
                    {
                        // summoning the "Argent Knight (Horde)" is default for spell 54307;
                        if (caster->ToPlayer()->GetTeamId() == TEAM_ALLIANCE)
                        {
                            // prevent default summoning and summon "Argent Knight (Alliance)" instead
                            PreventHitDefaultEffect(effIndex);
                            caster->CastSpell(caster, SPELL_SUMMON_ARGENT_KNIGHT_ALLIANCE, true);
                        }
                    }
                }
            }

            void Register()
            {
                OnEffectHit += SpellEffectFn(spell_item_summon_argent_knight_SpellScript::HandleOnEffectHit, EFFECT_0, SPELL_EFFECT_SUMMON);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_item_summon_argent_knight_SpellScript();
        }
};

// Theirs
// Generic script for handling item dummy effects which trigger another spell.
class spell_item_trigger_spell : public SpellScriptLoader
{
    private:
        uint32 _triggeredSpellId;

    public:
        spell_item_trigger_spell(const char* name, uint32 triggeredSpellId) : SpellScriptLoader(name), _triggeredSpellId(triggeredSpellId) { }

        class spell_item_trigger_spell_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_item_trigger_spell_SpellScript);
        private:
            uint32 _triggeredSpellId;

        public:
            spell_item_trigger_spell_SpellScript(uint32 triggeredSpellId) : SpellScript(), _triggeredSpellId(triggeredSpellId) { }

            bool Validate(SpellInfo const* /*spellInfo*/)
            {
                if (!sSpellMgr->GetSpellInfo(_triggeredSpellId))
                    return false;
                return true;
            }

            void HandleDummy(SpellEffIndex /*effIndex*/)
            {
                Unit* caster = GetCaster();
                if (Item* item = GetCastItem())
                    caster->CastSpell(caster, _triggeredSpellId, true, item);
            }

            void Register()
            {
                OnEffectHit += SpellEffectFn(spell_item_trigger_spell_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_item_trigger_spell_SpellScript(_triggeredSpellId);
        }
};

enum AegisOfPreservation
{
    SPELL_AEGIS_HEAL   = 23781
};

// 23780 - Aegis of Preservation
class spell_item_aegis_of_preservation : public SpellScriptLoader
{
    public:
        spell_item_aegis_of_preservation() : SpellScriptLoader("spell_item_aegis_of_preservation") { }

        class spell_item_aegis_of_preservation_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_item_aegis_of_preservation_AuraScript);

            bool Validate(SpellInfo const* /*spellInfo*/)
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_AEGIS_HEAL))
                    return false;
                return true;
            }

            void HandleProc(AuraEffect const* aurEff, ProcEventInfo& /*eventInfo*/)
            {
                PreventDefaultAction();
                GetTarget()->CastSpell(GetTarget(), SPELL_AEGIS_HEAL, true, NULL, aurEff);
            }

            void Register()
            {
                OnEffectProc += AuraEffectProcFn(spell_item_aegis_of_preservation_AuraScript::HandleProc, EFFECT_1, SPELL_AURA_PROC_TRIGGER_SPELL);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_item_aegis_of_preservation_AuraScript();
        }
};

// 26400 - Arcane Shroud
class spell_item_arcane_shroud : public SpellScriptLoader
{
    public:
        spell_item_arcane_shroud() : SpellScriptLoader("spell_item_arcane_shroud") { }

        class spell_item_arcane_shroud_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_item_arcane_shroud_AuraScript);

            void CalculateAmount(AuraEffect const* /*aurEff*/, int32& amount, bool& /*canBeRecalculated*/)
            {
                int32 diff = GetUnitOwner()->getLevel() - 60;
                if (diff > 0)
                    amount += 2 * diff;
            }

            void Register()
            {
                DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_item_arcane_shroud_AuraScript::CalculateAmount, EFFECT_0, SPELL_AURA_MOD_THREAT);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_item_arcane_shroud_AuraScript();
        }
};

// 64415 - Val'anyr Hammer of Ancient Kings - Equip Effect
class spell_item_valanyr_hammer_of_ancient_kings : public SpellScriptLoader
{
public:
    spell_item_valanyr_hammer_of_ancient_kings() : SpellScriptLoader("spell_item_valanyr_hammer_of_ancient_kings") { }

    class spell_item_valanyr_hammer_of_ancient_kingsAuraScript : public AuraScript
    {
        PrepareAuraScript(spell_item_valanyr_hammer_of_ancient_kingsAuraScript);

        bool CheckProc(ProcEventInfo& eventInfo)
        {

            SpellInfo const* spellInfo = eventInfo.GetHealInfo()->GetSpellInfo();
            if (!spellInfo || !spellInfo->HasEffect(SPELL_EFFECT_HEAL))
                return false;

            return eventInfo.GetHealInfo() && eventInfo.GetHealInfo()->GetHeal() > 0;

        }

        void Register()
        {
            DoCheckProc += AuraCheckProcFn(spell_item_valanyr_hammer_of_ancient_kingsAuraScript::CheckProc);
        }
    };

    AuraScript* GetAuraScript() const
    {
        return new spell_item_valanyr_hammer_of_ancient_kingsAuraScript();
    }
};

// 64411 - Blessing of Ancient Kings (Val'anyr, Hammer of Ancient Kings)
enum BlessingOfAncientKings
{
    SPELL_PROTECTION_OF_ANCIENT_KINGS   = 64413
};

class spell_item_blessing_of_ancient_kings : public SpellScriptLoader
{
    public:
        spell_item_blessing_of_ancient_kings() : SpellScriptLoader("spell_item_blessing_of_ancient_kings") { }

        class spell_item_blessing_of_ancient_kings_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_item_blessing_of_ancient_kings_AuraScript);

            bool Validate(SpellInfo const* /*spellInfo*/)
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_PROTECTION_OF_ANCIENT_KINGS))
                    return false;
                return true;
            }

            bool CheckProc(ProcEventInfo& eventInfo)
            {
                return eventInfo.GetProcTarget();
            }

            void HandleProc(AuraEffect const* aurEff, ProcEventInfo& eventInfo)
            {
                PreventDefaultAction();

                int32 absorb = int32(CalculatePct(eventInfo.GetHealInfo()->GetHeal(), 15.0f));
                // xinef: all heals contribute to one bubble
                if (AuraEffect* protEff = eventInfo.GetProcTarget()->GetAuraEffect(SPELL_PROTECTION_OF_ANCIENT_KINGS, 0/*, eventInfo.GetActor()->GetGUID()*/))
                {
                    // The shield can grow to a maximum size of 20,000 damage absorbtion
                    protEff->SetAmount(std::min<int32>(protEff->GetAmount() + absorb, 20000));

                    // Refresh and return to prevent replacing the aura
                    protEff->GetBase()->RefreshDuration();
                }
                else
                    GetTarget()->CastCustomSpell(SPELL_PROTECTION_OF_ANCIENT_KINGS, SPELLVALUE_BASE_POINT0, absorb, eventInfo.GetProcTarget(), true, NULL, aurEff);
            }

            void Register()
            {
                DoCheckProc += AuraCheckProcFn(spell_item_blessing_of_ancient_kings_AuraScript::CheckProc);
                OnEffectProc += AuraEffectProcFn(spell_item_blessing_of_ancient_kings_AuraScript::HandleProc, EFFECT_0, SPELL_AURA_DUMMY);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_item_blessing_of_ancient_kings_AuraScript();
        }
};

// 8342  - Defibrillate (Goblin Jumper Cables) have 33% chance on success
// 22999 - Defibrillate (Goblin Jumper Cables XL) have 50% chance on success
// 54732 - Defibrillate (Gnomish Army Knife) have 67% chance on success
enum Defibrillate
{
    SPELL_GOBLIN_JUMPER_CABLES_FAIL     = 8338,
    SPELL_GOBLIN_JUMPER_CABLES_XL_FAIL  = 23055
};

class spell_item_defibrillate : public SpellScriptLoader
{
    public:
        spell_item_defibrillate(char const* name, uint8 chance, uint32 failSpell = 0) : SpellScriptLoader(name), _chance(chance), _failSpell(failSpell) { }

        class spell_item_defibrillate_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_item_defibrillate_SpellScript);

        public:
            spell_item_defibrillate_SpellScript(uint8 chance, uint32 failSpell) : SpellScript(), _chance(chance), _failSpell(failSpell) { }

            bool Validate(SpellInfo const* /*spellInfo*/)
            {
                if (_failSpell && !sSpellMgr->GetSpellInfo(_failSpell))
                    return false;
                return true;
            }

            void HandleScript(SpellEffIndex effIndex)
            {
                if (roll_chance_i(_chance))
                {
                    PreventHitDefaultEffect(effIndex);
                    if (_failSpell)
                        GetCaster()->CastSpell(GetCaster(), _failSpell, true, GetCastItem());
                }
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_item_defibrillate_SpellScript::HandleScript, EFFECT_0, SPELL_EFFECT_RESURRECT);
            }

        private:
            uint8 _chance;
            uint32 _failSpell;
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_item_defibrillate_SpellScript(_chance, _failSpell);
        }

    private:
        uint8 _chance;
        uint32 _failSpell;
};

enum DesperateDefense
{
    SPELL_DESPERATE_RAGE    = 33898
};

// 33896 - Desperate Defense
class spell_item_desperate_defense : public SpellScriptLoader
{
    public:
        spell_item_desperate_defense() : SpellScriptLoader("spell_item_desperate_defense") { }

        class spell_item_desperate_defense_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_item_desperate_defense_AuraScript);

            bool Validate(SpellInfo const* /*spellInfo*/)
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_DESPERATE_RAGE))
                    return false;
                return true;
            }

            void HandleProc(AuraEffect const* aurEff, ProcEventInfo& /*eventInfo*/)
            {
                PreventDefaultAction();
                GetTarget()->CastSpell(GetTarget(), SPELL_DESPERATE_RAGE, true, NULL, aurEff);
            }

            void Register()
            {
                OnEffectProc += AuraEffectProcFn(spell_item_desperate_defense_AuraScript::HandleProc, EFFECT_2, SPELL_AURA_PROC_TRIGGER_SPELL);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_item_desperate_defense_AuraScript();
        }
};

// http://www.wowhead.com/item=6522 Deviate Fish
// 8063 Deviate Fish
enum DeviateFishSpells
{
    SPELL_SLEEPY            = 8064,
    SPELL_INVIGORATE        = 8065,
    SPELL_SHRINK            = 8066,
    SPELL_PARTY_TIME        = 8067,
    SPELL_HEALTHY_SPIRIT    = 8068,
};

class spell_item_deviate_fish : public SpellScriptLoader
{
    public:
        spell_item_deviate_fish() : SpellScriptLoader("spell_item_deviate_fish") { }

        class spell_item_deviate_fish_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_item_deviate_fish_SpellScript);

            bool Load()
            {
                return GetCaster()->GetTypeId() == TYPEID_PLAYER;
            }

            bool Validate(SpellInfo const* /*spellInfo*/)
            {
                for (uint32 spellId = SPELL_SLEEPY; spellId <= SPELL_HEALTHY_SPIRIT; ++spellId)
                    if (!sSpellMgr->GetSpellInfo(spellId))
                        return false;
                return true;
            }

            void HandleDummy(SpellEffIndex /*effIndex*/)
            {
                Unit* caster = GetCaster();
                uint32 spellId = urand(SPELL_SLEEPY, SPELL_HEALTHY_SPIRIT);
                caster->CastSpell(caster, spellId, true, nullptr);
            }

            void Register()
            {
                OnEffectHit += SpellEffectFn(spell_item_deviate_fish_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_item_deviate_fish_SpellScript();
        }
};

// 71610, 71641 - Echoes of Light (Althor's Abacus)
class spell_item_echoes_of_light : public SpellScriptLoader
{
    public:
        spell_item_echoes_of_light() : SpellScriptLoader("spell_item_echoes_of_light") { }

        class spell_item_echoes_of_light_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_item_echoes_of_light_SpellScript);

            void FilterTargets(std::list<WorldObject*>& targets)
            {
                if (targets.size() < 2)
                    return;

                targets.sort(acore::HealthPctOrderPred());

                WorldObject* target = targets.front();
                targets.clear();
                targets.push_back(target);
            }

            void Register()
            {
                OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_item_echoes_of_light_SpellScript::FilterTargets, EFFECT_0, TARGET_UNIT_DEST_AREA_ALLY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_item_echoes_of_light_SpellScript();
        }
};

// 7434 - Fate Rune of Unsurpassed Vigor
enum FateRuneOfUnsurpassedVigor
{
    SPELL_UNSURPASSED_VIGOR = 25733
};

class spell_item_fate_rune_of_unsurpassed_vigor : public SpellScriptLoader
{
    public:
        spell_item_fate_rune_of_unsurpassed_vigor() : SpellScriptLoader("spell_item_fate_rune_of_unsurpassed_vigor") { }

        class spell_item_fate_rune_of_unsurpassed_vigor_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_item_fate_rune_of_unsurpassed_vigor_AuraScript);

            bool Validate(SpellInfo const* /*spellInfo*/)
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_UNSURPASSED_VIGOR))
                    return false;
                return true;
            }

            void HandleProc(AuraEffect const* /*aurEff*/, ProcEventInfo& /*eventInfo*/)
            {
                GetTarget()->CastSpell(GetTarget(), SPELL_UNSURPASSED_VIGOR, true);
            }

            void Register()
            {
                OnEffectProc += AuraEffectProcFn(spell_item_fate_rune_of_unsurpassed_vigor_AuraScript::HandleProc, EFFECT_0, SPELL_AURA_DUMMY);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_item_fate_rune_of_unsurpassed_vigor_AuraScript();
        }
};

// http://www.wowhead.com/item=47499 Flask of the North
// 67019 Flask of the North
enum FlaskOfTheNorthSpells
{
    SPELL_FLASK_OF_THE_NORTH_SP = 67016,
    SPELL_FLASK_OF_THE_NORTH_AP = 67017,
    SPELL_FLASK_OF_THE_NORTH_STR = 67018,
};

class spell_item_flask_of_the_north : public SpellScriptLoader
{
    public:
        spell_item_flask_of_the_north() : SpellScriptLoader("spell_item_flask_of_the_north") { }

        class spell_item_flask_of_the_north_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_item_flask_of_the_north_SpellScript);

            bool Validate(SpellInfo const* /*spellInfo*/)
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_FLASK_OF_THE_NORTH_SP) || !sSpellMgr->GetSpellInfo(SPELL_FLASK_OF_THE_NORTH_AP) || !sSpellMgr->GetSpellInfo(SPELL_FLASK_OF_THE_NORTH_STR))
                    return false;
                return true;
            }

            void HandleDummy(SpellEffIndex /*effIndex*/)
            {
                Unit* caster = GetCaster();
                std::vector<uint32> possibleSpells;
                switch (caster->getClass())
                {
                    case CLASS_WARLOCK:
                    case CLASS_MAGE:
                    case CLASS_PRIEST:
                        possibleSpells.push_back(SPELL_FLASK_OF_THE_NORTH_SP);
                        break;
                    case CLASS_DEATH_KNIGHT:
                    case CLASS_WARRIOR:
                        possibleSpells.push_back(SPELL_FLASK_OF_THE_NORTH_STR);
                        break;
                    case CLASS_ROGUE:
                    case CLASS_HUNTER:
                        possibleSpells.push_back(SPELL_FLASK_OF_THE_NORTH_AP);
                        break;
                    case CLASS_DRUID:
                    case CLASS_PALADIN:
                        possibleSpells.push_back(SPELL_FLASK_OF_THE_NORTH_SP);
                        possibleSpells.push_back(SPELL_FLASK_OF_THE_NORTH_STR);
                        break;
                    case CLASS_SHAMAN:
                        possibleSpells.push_back(SPELL_FLASK_OF_THE_NORTH_SP);
                        possibleSpells.push_back(SPELL_FLASK_OF_THE_NORTH_AP);
                        break;
                }

                caster->CastSpell(caster, possibleSpells[irand(0, (possibleSpells.size() - 1))], true, nullptr);
            }

            void Register()
            {
                OnEffectHit += SpellEffectFn(spell_item_flask_of_the_north_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_item_flask_of_the_north_SpellScript();
        }
};

// http://www.wowhead.com/item=10645 Gnomish Death Ray
// 13280 Gnomish Death Ray
enum GnomishDeathRay
{
    SPELL_GNOMISH_DEATH_RAY_SELF = 13493,
    SPELL_GNOMISH_DEATH_RAY_TARGET = 13279,
};

class spell_item_gnomish_death_ray : public SpellScriptLoader
{
    public:
        spell_item_gnomish_death_ray() : SpellScriptLoader("spell_item_gnomish_death_ray") { }

        class spell_item_gnomish_death_ray_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_item_gnomish_death_ray_SpellScript);

            bool Validate(SpellInfo const* /*spellInfo*/)
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_GNOMISH_DEATH_RAY_SELF) || !sSpellMgr->GetSpellInfo(SPELL_GNOMISH_DEATH_RAY_TARGET))
                    return false;
                return true;
            }

            void HandleDummy(SpellEffIndex /*effIndex*/)
            {
                Unit* caster = GetCaster();
                if (Unit* target = GetHitUnit())
                {
                    if (urand(0, 99) < 15)
                        caster->CastSpell(caster, SPELL_GNOMISH_DEATH_RAY_SELF, true, nullptr);    // failure
                    else
                        caster->CastSpell(target, SPELL_GNOMISH_DEATH_RAY_TARGET, true, nullptr);
                }
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_item_gnomish_death_ray_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_item_gnomish_death_ray_SpellScript();
        }
};

// http://www.wowhead.com/item=27388 Mr. Pinchy
// 33060 Make a Wish
enum MakeAWish
{
    SPELL_MR_PINCHYS_BLESSING       = 33053,
    SPELL_SUMMON_MIGHTY_MR_PINCHY   = 33057,
    SPELL_SUMMON_FURIOUS_MR_PINCHY  = 33059,
    SPELL_TINY_MAGICAL_CRAWDAD      = 33062,
    SPELL_MR_PINCHYS_GIFT           = 33064,
};

class spell_item_make_a_wish : public SpellScriptLoader
{
    public:
        spell_item_make_a_wish() : SpellScriptLoader("spell_item_make_a_wish") { }

        class spell_item_make_a_wish_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_item_make_a_wish_SpellScript);

            bool Load()
            {
                return GetCaster()->GetTypeId() == TYPEID_PLAYER;
            }

            bool Validate(SpellInfo const* /*spellInfo*/)
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_MR_PINCHYS_BLESSING) || !sSpellMgr->GetSpellInfo(SPELL_SUMMON_MIGHTY_MR_PINCHY) || !sSpellMgr->GetSpellInfo(SPELL_SUMMON_FURIOUS_MR_PINCHY) || !sSpellMgr->GetSpellInfo(SPELL_TINY_MAGICAL_CRAWDAD) || !sSpellMgr->GetSpellInfo(SPELL_MR_PINCHYS_GIFT))
                    return false;
                return true;
            }

            void HandleDummy(SpellEffIndex /*effIndex*/)
            {
                Unit* caster = GetCaster();
                uint32 spellId = SPELL_MR_PINCHYS_GIFT;
                switch (urand(1, 5))
                {
                    case 1: spellId = SPELL_MR_PINCHYS_BLESSING; break;
                    case 2: spellId = SPELL_SUMMON_MIGHTY_MR_PINCHY; break;
                    case 3: spellId = SPELL_SUMMON_FURIOUS_MR_PINCHY; break;
                    case 4: spellId = SPELL_TINY_MAGICAL_CRAWDAD; break;
                }
                caster->CastSpell(caster, spellId, true, nullptr);
            }

            void Register()
            {
                OnEffectHit += SpellEffectFn(spell_item_make_a_wish_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_item_make_a_wish_SpellScript();
        }
};

// http://www.wowhead.com/item=32686 Mingo's Fortune Giblets
// 40802 Mingo's Fortune Generator
class spell_item_mingos_fortune_generator : public SpellScriptLoader
{
    public:
        spell_item_mingos_fortune_generator() : SpellScriptLoader("spell_item_mingos_fortune_generator") { }

        class spell_item_mingos_fortune_generator_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_item_mingos_fortune_generator_SpellScript);

            void HandleDummy(SpellEffIndex effIndex)
            {
                // Selecting one from Bloodstained Fortune item
                uint32 newitemid;
                switch (urand(1, 20))
                {
                    case 1:  newitemid = 32688; break;
                    case 2:  newitemid = 32689; break;
                    case 3:  newitemid = 32690; break;
                    case 4:  newitemid = 32691; break;
                    case 5:  newitemid = 32692; break;
                    case 6:  newitemid = 32693; break;
                    case 7:  newitemid = 32700; break;
                    case 8:  newitemid = 32701; break;
                    case 9:  newitemid = 32702; break;
                    case 10: newitemid = 32703; break;
                    case 11: newitemid = 32704; break;
                    case 12: newitemid = 32705; break;
                    case 13: newitemid = 32706; break;
                    case 14: newitemid = 32707; break;
                    case 15: newitemid = 32708; break;
                    case 16: newitemid = 32709; break;
                    case 17: newitemid = 32710; break;
                    case 18: newitemid = 32711; break;
                    case 19: newitemid = 32712; break;
                    case 20: newitemid = 32713; break;
                    default:
                        return;
                }

                CreateItem(effIndex, newitemid);
            }

            void Register()
            {
                OnEffectHit += SpellEffectFn(spell_item_mingos_fortune_generator_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_item_mingos_fortune_generator_SpellScript();
        }
};

// 71875, 71877 - Item - Black Bruise: Necrotic Touch Proc
enum NecroticTouch
{
    SPELL_ITEM_NECROTIC_TOUCH_PROC  = 71879
};

class spell_item_necrotic_touch : public SpellScriptLoader
{
    public:
        spell_item_necrotic_touch() : SpellScriptLoader("spell_item_necrotic_touch") { }

        class spell_item_necrotic_touch_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_item_necrotic_touch_AuraScript);

            bool Validate(SpellInfo const* /*spellInfo*/)
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_ITEM_NECROTIC_TOUCH_PROC))
                    return false;
                return true;
            }

            bool CheckProc(ProcEventInfo& eventInfo)
            {
                return eventInfo.GetProcTarget() && eventInfo.GetProcTarget()->IsAlive();
            }

            void HandleProc(AuraEffect const* aurEff, ProcEventInfo& eventInfo)
            {
                PreventDefaultAction();
                int32 bp = CalculatePct(int32(eventInfo.GetDamageInfo()->GetDamage()), aurEff->GetAmount());
                GetTarget()->CastCustomSpell(SPELL_ITEM_NECROTIC_TOUCH_PROC, SPELLVALUE_BASE_POINT0, bp, eventInfo.GetProcTarget(), true, NULL, aurEff);
            }

            void Register()
            {
                DoCheckProc += AuraCheckProcFn(spell_item_necrotic_touch_AuraScript::CheckProc);
                OnEffectProc += AuraEffectProcFn(spell_item_necrotic_touch_AuraScript::HandleProc, EFFECT_0, SPELL_AURA_DUMMY);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_item_necrotic_touch_AuraScript();
        }
};

// http://www.wowhead.com/item=10720 Gnomish Net-o-Matic Projector
// 13120 Net-o-Matic
enum NetOMaticSpells
{
    SPELL_NET_O_MATIC_TRIGGERED1 = 16566,
    SPELL_NET_O_MATIC_TRIGGERED2 = 13119,
    SPELL_NET_O_MATIC_TRIGGERED3 = 13099,
};

class spell_item_net_o_matic : public SpellScriptLoader
{
    public:
        spell_item_net_o_matic() : SpellScriptLoader("spell_item_net_o_matic") { }

        class spell_item_net_o_matic_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_item_net_o_matic_SpellScript);

            bool Validate(SpellInfo const* /*spellInfo*/)
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_NET_O_MATIC_TRIGGERED1) || !sSpellMgr->GetSpellInfo(SPELL_NET_O_MATIC_TRIGGERED2) || !sSpellMgr->GetSpellInfo(SPELL_NET_O_MATIC_TRIGGERED3))
                    return false;
                return true;
            }

            void HandleDummy(SpellEffIndex /*effIndex*/)
            {
                if (Unit* target = GetHitUnit())
                {
                    uint32 spellId = SPELL_NET_O_MATIC_TRIGGERED3;
                    uint32 roll = urand(0, 99);
                    if (roll < 2)                            // 2% for 30 sec self root (off-like chance unknown)
                        spellId = SPELL_NET_O_MATIC_TRIGGERED1;
                    else if (roll < 4)                       // 2% for 20 sec root, charge to target (off-like chance unknown)
                        spellId = SPELL_NET_O_MATIC_TRIGGERED2;

                    GetCaster()->CastSpell(target, spellId, true, nullptr);
                }
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_item_net_o_matic_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_item_net_o_matic_SpellScript();
        }
};

// http://www.wowhead.com/item=8529 Noggenfogger Elixir
// 16589 Noggenfogger Elixir
enum NoggenfoggerElixirSpells
{
    SPELL_NOGGENFOGGER_ELIXIR_TRIGGERED1 = 16595,
    SPELL_NOGGENFOGGER_ELIXIR_TRIGGERED2 = 16593,
    SPELL_NOGGENFOGGER_ELIXIR_TRIGGERED3 = 16591,
};

class spell_item_noggenfogger_elixir : public SpellScriptLoader
{
    public:
        spell_item_noggenfogger_elixir() : SpellScriptLoader("spell_item_noggenfogger_elixir") { }

        class spell_item_noggenfogger_elixir_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_item_noggenfogger_elixir_SpellScript);

            bool Load()
            {
                return GetCaster()->GetTypeId() == TYPEID_PLAYER;
            }

            bool Validate(SpellInfo const* /*spellInfo*/)
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_NOGGENFOGGER_ELIXIR_TRIGGERED1) || !sSpellMgr->GetSpellInfo(SPELL_NOGGENFOGGER_ELIXIR_TRIGGERED2) || !sSpellMgr->GetSpellInfo(SPELL_NOGGENFOGGER_ELIXIR_TRIGGERED3))
                    return false;
                return true;
            }

            void HandleDummy(SpellEffIndex /*effIndex*/)
            {
                Unit* caster = GetCaster();
                uint32 spellId = SPELL_NOGGENFOGGER_ELIXIR_TRIGGERED3;
                switch (urand(1, 3))
                {
                    case 1: spellId = SPELL_NOGGENFOGGER_ELIXIR_TRIGGERED1; break;
                    case 2: spellId = SPELL_NOGGENFOGGER_ELIXIR_TRIGGERED2; break;
                }

                caster->CastSpell(caster, spellId, true, nullptr);
            }

            void Register()
            {
                OnEffectHit += SpellEffectFn(spell_item_noggenfogger_elixir_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_item_noggenfogger_elixir_SpellScript();
        }
};

// 17512 - Piccolo of the Flaming Fire
class spell_item_piccolo_of_the_flaming_fire : public SpellScriptLoader
{
    public:
        spell_item_piccolo_of_the_flaming_fire() : SpellScriptLoader("spell_item_piccolo_of_the_flaming_fire") { }

        class spell_item_piccolo_of_the_flaming_fire_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_item_piccolo_of_the_flaming_fire_SpellScript);

            void HandleScript(SpellEffIndex effIndex)
            {
                PreventHitDefaultEffect(effIndex);
                if (Player* target = GetHitPlayer())
                    target->HandleEmoteCommand(EMOTE_STATE_DANCE);
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_item_piccolo_of_the_flaming_fire_SpellScript::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_item_piccolo_of_the_flaming_fire_SpellScript();
        }
};

// http://www.wowhead.com/item=6657 Savory Deviate Delight
// 8213 Savory Deviate Delight
enum SavoryDeviateDelight
{
    SPELL_FLIP_OUT_MALE     = 8219,
    SPELL_FLIP_OUT_FEMALE   = 8220,
    SPELL_YAAARRRR_MALE     = 8221,
    SPELL_YAAARRRR_FEMALE   = 8222,
};

class spell_item_savory_deviate_delight : public SpellScriptLoader
{
    public:
        spell_item_savory_deviate_delight() : SpellScriptLoader("spell_item_savory_deviate_delight") { }

        class spell_item_savory_deviate_delight_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_item_savory_deviate_delight_SpellScript);

            bool Load()
            {
                return GetCaster()->GetTypeId() == TYPEID_PLAYER;
            }

            bool Validate(SpellInfo const* /*spellInfo*/)
            {
                for (uint32 spellId = SPELL_FLIP_OUT_MALE; spellId <= SPELL_YAAARRRR_FEMALE; ++spellId)
                    if (!sSpellMgr->GetSpellInfo(spellId))
                        return false;
                return true;
            }

            void HandleDummy(SpellEffIndex /*effIndex*/)
            {
                Unit* caster = GetCaster();
                uint32 spellId = 0;
                switch (urand(1, 2))
                {
                    // Flip Out - ninja
                    case 1: spellId = (caster->getGender() == GENDER_MALE ? SPELL_FLIP_OUT_MALE : SPELL_FLIP_OUT_FEMALE); break;
                    // Yaaarrrr - pirate
                    case 2: spellId = (caster->getGender() == GENDER_MALE ? SPELL_YAAARRRR_MALE : SPELL_YAAARRRR_FEMALE); break;
                }
                caster->CastSpell(caster, spellId, true, nullptr);
            }

            void Register()
            {
                OnEffectHit += SpellEffectFn(spell_item_savory_deviate_delight_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_item_savory_deviate_delight_SpellScript();
        }
};

// 48129 - Scroll of Recall
// 60320 - Scroll of Recall II
// 60321 - Scroll of Recall III
enum ScrollOfRecall
{
    SPELL_SCROLL_OF_RECALL_I                = 48129,
    SPELL_SCROLL_OF_RECALL_II               = 60320,
    SPELL_SCROLL_OF_RECALL_III              = 60321,
    SPELL_LOST                              = 60444,
    SPELL_SCROLL_OF_RECALL_FAIL_ALLIANCE_1  = 60323,
    SPELL_SCROLL_OF_RECALL_FAIL_HORDE_1     = 60328,
};

class spell_item_scroll_of_recall : public SpellScriptLoader
{
    public:
        spell_item_scroll_of_recall() : SpellScriptLoader("spell_item_scroll_of_recall") { }

        class spell_item_scroll_of_recall_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_item_scroll_of_recall_SpellScript);

            bool Load()
            {
                return GetCaster()->GetTypeId() == TYPEID_PLAYER;
            }

            void HandleScript(SpellEffIndex effIndex)
            {
                Unit* caster = GetCaster();
                uint8 maxSafeLevel = 0;
                switch (GetSpellInfo()->Id)
                {
                    case SPELL_SCROLL_OF_RECALL_I:  // Scroll of Recall
                        maxSafeLevel = 40;
                        break;
                    case SPELL_SCROLL_OF_RECALL_II:  // Scroll of Recall II
                        maxSafeLevel = 70;
                        break;
                    case SPELL_SCROLL_OF_RECALL_III:  // Scroll of Recal III
                        maxSafeLevel = 80;
                        break;
                    default:
                        break;
                }

                if (caster->getLevel() > maxSafeLevel)
                {
                    caster->CastSpell(caster, SPELL_LOST, true);

                    // ALLIANCE from 60323 to 60330 - HORDE from 60328 to 60335
                    uint32 spellId = SPELL_SCROLL_OF_RECALL_FAIL_ALLIANCE_1;
                    if (GetCaster()->ToPlayer()->GetTeamId() == TEAM_HORDE)
                        spellId = SPELL_SCROLL_OF_RECALL_FAIL_HORDE_1;

                    GetCaster()->CastSpell(GetCaster(), spellId + urand(0, 7), true);

                    PreventHitDefaultEffect(effIndex);
                }
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_item_scroll_of_recall_SpellScript::HandleScript, EFFECT_0, SPELL_EFFECT_TELEPORT_UNITS);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_item_scroll_of_recall_SpellScript();
        }
};

// 71169 - Shadow's Fate (Shadowmourne questline)
enum ShadowsFate
{
    SPELL_SOUL_FEAST        = 71203,
    NPC_SINDRAGOSA          = 36853
};

class spell_item_unsated_craving : public SpellScriptLoader
{
    public:
        spell_item_unsated_craving() : SpellScriptLoader("spell_item_unsated_craving") { }

        class spell_item_unsated_craving_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_item_unsated_craving_AuraScript);

            bool CheckProc(ProcEventInfo& procInfo)
            {
                Unit* caster = procInfo.GetActor();
                if (!caster || caster->GetTypeId() != TYPEID_PLAYER)
                    return false;

                Unit* target = procInfo.GetActionTarget();
                if (!target || target->GetTypeId() != TYPEID_UNIT || target->IsCritter() || (target->GetEntry() != NPC_SINDRAGOSA && target->IsSummon()))
                    return false;

                return true;
            }

            // xinef: prevent default proc with castItem passed, which applies 30 sec cooldown to procing of the aura
            void HandleProc(AuraEffect const* aurEff, ProcEventInfo& eventInfo)
            {
                PreventDefaultAction();
                eventInfo.GetActor()->CastSpell(eventInfo.GetActionTarget(), GetSpellInfo()->Effects[aurEff->GetEffIndex()].TriggerSpell, TRIGGERED_FULL_MASK);
            }

            void Register()
            {
                DoCheckProc += AuraCheckProcFn(spell_item_unsated_craving_AuraScript::CheckProc);
                OnEffectProc += AuraEffectProcFn(spell_item_unsated_craving_AuraScript::HandleProc, EFFECT_0, SPELL_AURA_PROC_TRIGGER_SPELL);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_item_unsated_craving_AuraScript();
        }
};

class spell_item_shadows_fate : public SpellScriptLoader
{
    public:
        spell_item_shadows_fate() : SpellScriptLoader("spell_item_shadows_fate") { }

        class spell_item_shadows_fate_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_item_shadows_fate_AuraScript);

            void HandleProc(AuraEffect const*  /*aurEff*/, ProcEventInfo& eventInfo)
            {
                PreventDefaultAction();

                Unit* caster = eventInfo.GetActor();
                Unit* target = GetCaster();
                if (!caster || !target)
                    return;

                caster->CastSpell(target, SPELL_SOUL_FEAST, TRIGGERED_FULL_MASK);
            }

            void Register()
            {
                OnEffectProc += AuraEffectProcFn(spell_item_shadows_fate_AuraScript::HandleProc, EFFECT_0, SPELL_AURA_DUMMY);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_item_shadows_fate_AuraScript();
        }
};

enum Shadowmourne
{
    SPELL_SHADOWMOURNE_CHAOS_BANE_DAMAGE    = 71904,
    SPELL_SHADOWMOURNE_SOUL_FRAGMENT        = 71905,
    SPELL_SHADOWMOURNE_VISUAL_LOW           = 72521,
    SPELL_SHADOWMOURNE_VISUAL_HIGH          = 72523,
    SPELL_SHADOWMOURNE_CHAOS_BANE_BUFF      = 73422,
};

// 71903 - Item - Shadowmourne Legendary
class spell_item_shadowmourne : public SpellScriptLoader
{
    public:
        spell_item_shadowmourne() : SpellScriptLoader("spell_item_shadowmourne") { }

        class spell_item_shadowmourne_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_item_shadowmourne_AuraScript);

            bool Validate(SpellInfo const* /*spellInfo*/)
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_SHADOWMOURNE_CHAOS_BANE_DAMAGE))
                    return false;
                if (!sSpellMgr->GetSpellInfo(SPELL_SHADOWMOURNE_SOUL_FRAGMENT))
                    return false;
                if (!sSpellMgr->GetSpellInfo(SPELL_SHADOWMOURNE_CHAOS_BANE_BUFF))
                    return false;
                return true;
            }

            bool CheckProc(ProcEventInfo& eventInfo)
            {
                if (GetTarget()->HasAura(SPELL_SHADOWMOURNE_CHAOS_BANE_BUFF)) // cant collect shards while under effect of Chaos Bane buff
                    return false;

                // Xinef: Not on BG / Arena
                /*if (!GetTarget()->FindMap() || GetTarget()->FindMap()->IsBattlegroundOrArena())
                    return false;*/

                if (const SpellInfo* procSpell = eventInfo.GetDamageInfo()->GetSpellInfo())
                    if (!eventInfo.GetDamageInfo()->GetDamage())
                    {
                        if (procSpell->SpellFamilyName == SPELLFAMILY_WARRIOR)
                        {
                            if (!procSpell->SpellFamilyFlags.HasFlag(0x2|0x20|0x4000, 0x0, 0x0))
                                return false;
                        }
                        else if (procSpell->SpellFamilyName == SPELLFAMILY_DEATHKNIGHT)
                        {
                            if (procSpell->Id != 55078 /*Blood Plague*/)
                                return false;
                        }
                        else
                            return false;
                    }

                return eventInfo.GetProcTarget() && eventInfo.GetActor() != eventInfo.GetProcTarget() && eventInfo.GetProcTarget()->IsAlive();
            }

            void HandleProc(AuraEffect const* aurEff, ProcEventInfo& eventInfo)
            {
                PreventDefaultAction();
                GetTarget()->CastSpell(GetTarget(), SPELL_SHADOWMOURNE_SOUL_FRAGMENT, true, NULL, aurEff);

                // this can't be handled in AuraScript of SoulFragments because we need to know victim
                if (Aura* soulFragments = GetTarget()->GetAura(SPELL_SHADOWMOURNE_SOUL_FRAGMENT))
                {
                    if (soulFragments->GetStackAmount() >= 10)
                    {
                        GetTarget()->CastSpell(eventInfo.GetProcTarget(), SPELL_SHADOWMOURNE_CHAOS_BANE_DAMAGE, true, NULL, aurEff);
                        soulFragments->Remove();
                    }
                }
            }
			
			void OnRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
			{
				GetTarget()->RemoveAurasDueToSpell(SPELL_SHADOWMOURNE_SOUL_FRAGMENT);
			}

            void Register()
            {
                DoCheckProc += AuraCheckProcFn(spell_item_shadowmourne_AuraScript::CheckProc);
                OnEffectProc += AuraEffectProcFn(spell_item_shadowmourne_AuraScript::HandleProc, EFFECT_0, SPELL_AURA_DUMMY);
				AfterEffectRemove += AuraEffectRemoveFn(spell_item_shadowmourne_AuraScript::OnRemove, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_item_shadowmourne_AuraScript();
        }
};

// 71905 - Soul Fragment
class spell_item_shadowmourne_soul_fragment : public SpellScriptLoader
{
    public:
        spell_item_shadowmourne_soul_fragment() : SpellScriptLoader("spell_item_shadowmourne_soul_fragment") { }

        class spell_item_shadowmourne_soul_fragment_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_item_shadowmourne_soul_fragment_AuraScript);

            bool Validate(SpellInfo const* /*spellInfo*/)
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_SHADOWMOURNE_VISUAL_LOW) || !sSpellMgr->GetSpellInfo(SPELL_SHADOWMOURNE_VISUAL_HIGH) || !sSpellMgr->GetSpellInfo(SPELL_SHADOWMOURNE_CHAOS_BANE_BUFF))
                    return false;
                return true;
            }

            void OnStackChange(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
            {
                Unit* target = GetTarget();
                switch (GetStackAmount())
                {
                    case 1:
                        target->CastSpell(target, SPELL_SHADOWMOURNE_VISUAL_LOW, true);
                        break;
                    case 6:
                        target->RemoveAurasDueToSpell(SPELL_SHADOWMOURNE_VISUAL_LOW);
                        target->CastSpell(target, SPELL_SHADOWMOURNE_VISUAL_HIGH, true);
                        break;
                    case 10:
                        target->RemoveAurasDueToSpell(SPELL_SHADOWMOURNE_VISUAL_HIGH);
                        target->CastSpell(target, SPELL_SHADOWMOURNE_CHAOS_BANE_BUFF, true);
                        break;
                    default:
                        break;
                }
            }

            void OnRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
            {
                Unit* target = GetTarget();
                target->RemoveAurasDueToSpell(SPELL_SHADOWMOURNE_VISUAL_LOW);
                target->RemoveAurasDueToSpell(SPELL_SHADOWMOURNE_VISUAL_HIGH);
            }

            void Register()
            {
                AfterEffectApply += AuraEffectApplyFn(spell_item_shadowmourne_soul_fragment_AuraScript::OnStackChange, EFFECT_0, SPELL_AURA_MOD_STAT, AuraEffectHandleModes(AURA_EFFECT_HANDLE_REAL | AURA_EFFECT_HANDLE_REAPPLY));
                AfterEffectRemove += AuraEffectRemoveFn(spell_item_shadowmourne_soul_fragment_AuraScript::OnRemove, EFFECT_0, SPELL_AURA_MOD_STAT, AURA_EFFECT_HANDLE_REAL);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_item_shadowmourne_soul_fragment_AuraScript();
        }
};

// http://www.wowhead.com/item=7734 Six Demon Bag
// 14537 Six Demon Bag
enum SixDemonBagSpells
{
    SPELL_FROSTBOLT                 = 11538,
    SPELL_POLYMORPH                 = 14621,
    SPELL_SUMMON_FELHOUND_MINION    = 14642,
    SPELL_FIREBALL                  = 15662,
    SPELL_CHAIN_LIGHTNING           = 21179,
    SPELL_ENVELOPING_WINDS          = 25189,
};

class spell_item_six_demon_bag : public SpellScriptLoader
{
    public:
        spell_item_six_demon_bag() : SpellScriptLoader("spell_item_six_demon_bag") { }

        class spell_item_six_demon_bag_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_item_six_demon_bag_SpellScript);

            bool Validate(SpellInfo const* /*spellInfo*/)
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_FROSTBOLT) || !sSpellMgr->GetSpellInfo(SPELL_POLYMORPH) || !sSpellMgr->GetSpellInfo(SPELL_SUMMON_FELHOUND_MINION) || !sSpellMgr->GetSpellInfo(SPELL_FIREBALL) || !sSpellMgr->GetSpellInfo(SPELL_CHAIN_LIGHTNING) || !sSpellMgr->GetSpellInfo(SPELL_ENVELOPING_WINDS))
                    return false;
                return true;
            }

            void HandleDummy(SpellEffIndex /*effIndex*/)
            {
                Unit* caster = GetCaster();
                if (Unit* target = GetHitUnit())
                {
                    uint32 spellId = 0;
                    uint32 rand = urand(0, 99);
                    if (rand < 25)                      // Fireball (25% chance)
                        spellId = SPELL_FIREBALL;
                    else if (rand < 50)                 // Frostball (25% chance)
                        spellId = SPELL_FROSTBOLT;
                    else if (rand < 70)                 // Chain Lighting (20% chance)
                        spellId = SPELL_CHAIN_LIGHTNING;
                    else if (rand < 80)                 // Polymorph (10% chance)
                    {
                        spellId = SPELL_POLYMORPH;
                        if (urand(0, 100) <= 30)        // 30% chance to self-cast
                            target = caster;
                    }
                    else if (rand < 95)                 // Enveloping Winds (15% chance)
                        spellId = SPELL_ENVELOPING_WINDS;
                    else                                // Summon Felhund minion (5% chance)
                    {
                        spellId = SPELL_SUMMON_FELHOUND_MINION;
                        target = caster;
                    }

                    caster->CastSpell(target, spellId, true, GetCastItem());
                }
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_item_six_demon_bag_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_item_six_demon_bag_SpellScript();
        }
};

// 28862 - The Eye of Diminution
class spell_item_the_eye_of_diminution : public SpellScriptLoader
{
    public:
        spell_item_the_eye_of_diminution() : SpellScriptLoader("spell_item_the_eye_of_diminution") { }

        class spell_item_the_eye_of_diminution_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_item_the_eye_of_diminution_AuraScript);

            void CalculateAmount(AuraEffect const* /*aurEff*/, int32& amount, bool& /*canBeRecalculated*/)
            {
                int32 diff = GetUnitOwner()->getLevel() - 60;
                if (diff > 0)
                    amount += diff;
            }

            void Register()
            {
                DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_item_the_eye_of_diminution_AuraScript::CalculateAmount, EFFECT_0, SPELL_AURA_MOD_THREAT);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_item_the_eye_of_diminution_AuraScript();
        }
};

// http://www.wowhead.com/item=44012 Underbelly Elixir
// 59640 Underbelly Elixir
enum UnderbellyElixirSpells
{
    SPELL_UNDERBELLY_ELIXIR_TRIGGERED1  = 59645,
    SPELL_UNDERBELLY_ELIXIR_TRIGGERED2  = 59831,
    SPELL_UNDERBELLY_ELIXIR_TRIGGERED3  = 59843,
    AREA_UNDERBELLY                     = 4560,
};

class spell_item_underbelly_elixir : public SpellScriptLoader
{
    public:
        spell_item_underbelly_elixir() : SpellScriptLoader("spell_item_underbelly_elixir") { }

        class spell_item_underbelly_elixir_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_item_underbelly_elixir_SpellScript);

            bool Load()
            {
                return GetCaster()->GetTypeId() == TYPEID_PLAYER;
            }
            bool Validate(SpellInfo const* /*spellInfo*/)
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_UNDERBELLY_ELIXIR_TRIGGERED1) || !sSpellMgr->GetSpellInfo(SPELL_UNDERBELLY_ELIXIR_TRIGGERED2) || !sSpellMgr->GetSpellInfo(SPELL_UNDERBELLY_ELIXIR_TRIGGERED3))
                    return false;
                return true;
            }

            void HandleDummy(SpellEffIndex /*effIndex*/)
            {
                Unit* caster = GetCaster();
                uint32 spellId = SPELL_UNDERBELLY_ELIXIR_TRIGGERED2;
                switch (urand(1, (caster->GetPositionZ() < 637 ? 3 : 2)))
                {
                    case 1: spellId = SPELL_UNDERBELLY_ELIXIR_TRIGGERED1; break;
                    case 2: spellId = SPELL_UNDERBELLY_ELIXIR_TRIGGERED3; break;
                }
                caster->CastSpell(caster, spellId, true, GetCastItem(), NULL, caster->GetGUID());
            }

            void Register()
            {
                OnEffectHit += SpellEffectFn(spell_item_underbelly_elixir_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_item_underbelly_elixir_SpellScript();
        }
};

enum GenericData
{
    SPELL_ARCANITE_DRAGONLING           = 19804,
    SPELL_BATTLE_CHICKEN                = 13166,
    SPELL_MECHANICAL_DRAGONLING         = 4073,
    SPELL_MITHRIL_MECHANICAL_DRAGONLING = 12749,
};

class spell_item_book_of_glyph_mastery : public SpellScriptLoader
{
    public:
        spell_item_book_of_glyph_mastery() : SpellScriptLoader("spell_item_book_of_glyph_mastery") { }

        class spell_item_book_of_glyph_mastery_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_item_book_of_glyph_mastery_SpellScript);

            bool Load()
            {
                return GetCaster()->GetTypeId() == TYPEID_PLAYER;
            }

            SpellCastResult CheckRequirement()
            {
                if (HasDiscoveredAllSpells(GetSpellInfo()->Id, GetCaster()->ToPlayer()))
                {
                    SetCustomCastResultMessage(SPELL_CUSTOM_ERROR_LEARNED_EVERYTHING);
                    return SPELL_FAILED_CUSTOM_ERROR;
                }

                return SPELL_CAST_OK;
            }

            void HandleScript(SpellEffIndex /*effIndex*/)
            {
                Player* caster = GetCaster()->ToPlayer();
                uint32 spellId = GetSpellInfo()->Id;

                // learn random explicit discovery recipe (if any)
                if (uint32 discoveredSpellId = GetExplicitDiscoverySpell(spellId, caster))
                    caster->learnSpell(discoveredSpellId);
            }

            void Register()
            {
                OnCheckCast += SpellCheckCastFn(spell_item_book_of_glyph_mastery_SpellScript::CheckRequirement);
                OnEffectHitTarget += SpellEffectFn(spell_item_book_of_glyph_mastery_SpellScript::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_item_book_of_glyph_mastery_SpellScript();
        }
};

enum Sinkholes
{
    NPC_SOUTH_SINKHOLE      = 25664,
    NPC_NORTHEAST_SINKHOLE  = 25665,
    NPC_NORTHWEST_SINKHOLE  = 25666,
};

class spell_item_map_of_the_geyser_fields : public SpellScriptLoader
{
    public:
        spell_item_map_of_the_geyser_fields() : SpellScriptLoader("spell_item_map_of_the_geyser_fields") { }

        class spell_item_map_of_the_geyser_fields_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_item_map_of_the_geyser_fields_SpellScript);

            SpellCastResult CheckSinkholes()
            {
                Unit* caster = GetCaster();
                if (caster->FindNearestCreature(NPC_SOUTH_SINKHOLE, 30.0f, true) ||
                    caster->FindNearestCreature(NPC_NORTHEAST_SINKHOLE, 30.0f, true) ||
                    caster->FindNearestCreature(NPC_NORTHWEST_SINKHOLE, 30.0f, true))
                    return SPELL_CAST_OK;

                SetCustomCastResultMessage(SPELL_CUSTOM_ERROR_MUST_BE_CLOSE_TO_SINKHOLE);
                return SPELL_FAILED_CUSTOM_ERROR;
            }

            void Register()
            {
                OnCheckCast += SpellCheckCastFn(spell_item_map_of_the_geyser_fields_SpellScript::CheckSinkholes);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_item_map_of_the_geyser_fields_SpellScript();
        }
};

enum VanquishedClutchesSpells
{
    SPELL_CRUSHER       = 64982,
    SPELL_CONSTRICTOR   = 64983,
    SPELL_CORRUPTOR     = 64984,
};

class spell_item_vanquished_clutches : public SpellScriptLoader
{
    public:
        spell_item_vanquished_clutches() : SpellScriptLoader("spell_item_vanquished_clutches") { }

        class spell_item_vanquished_clutches_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_item_vanquished_clutches_SpellScript);

            bool Validate(SpellInfo const* /*spellInfo*/)
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_CRUSHER) || !sSpellMgr->GetSpellInfo(SPELL_CONSTRICTOR) || !sSpellMgr->GetSpellInfo(SPELL_CORRUPTOR))
                    return false;
                return true;
            }

            void HandleDummy(SpellEffIndex /*effIndex*/)
            {
                uint32 spellId = RAND(SPELL_CRUSHER, SPELL_CONSTRICTOR, SPELL_CORRUPTOR);
                Unit* caster = GetCaster();
                caster->CastSpell(caster, spellId, true);
            }

            void Register()
            {
                OnEffectHit += SpellEffectFn(spell_item_vanquished_clutches_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_item_vanquished_clutches_SpellScript();
        }
};

enum AshbringerSounds
{
    SOUND_ASHBRINGER_1  = 8906,                             // "I was pure once"
    SOUND_ASHBRINGER_2  = 8907,                             // "Fought for righteousness"
    SOUND_ASHBRINGER_3  = 8908,                             // "I was once called Ashbringer"
    SOUND_ASHBRINGER_4  = 8920,                             // "Betrayed by my order"
    SOUND_ASHBRINGER_5  = 8921,                             // "Destroyed by Kel'Thuzad"
    SOUND_ASHBRINGER_6  = 8922,                             // "Made to serve"
    SOUND_ASHBRINGER_7  = 8923,                             // "My son watched me die"
    SOUND_ASHBRINGER_8  = 8924,                             // "Crusades fed his rage"
    SOUND_ASHBRINGER_9  = 8925,                             // "Truth is unknown to him"
    SOUND_ASHBRINGER_10 = 8926,                             // "Scarlet Crusade  is pure no longer"
    SOUND_ASHBRINGER_11 = 8927,                             // "Balnazzar's crusade corrupted my son"
    SOUND_ASHBRINGER_12 = 8928,                             // "Kill them all!"
};

class spell_item_ashbringer : public SpellScriptLoader
{
    public:
        spell_item_ashbringer() : SpellScriptLoader("spell_item_ashbringer") { }

        class spell_item_ashbringer_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_item_ashbringer_SpellScript);

            bool Load()
            {
                return GetCaster()->GetTypeId() == TYPEID_PLAYER;
            }

            void OnDummyEffect(SpellEffIndex effIndex)
            {
                PreventHitDefaultEffect(effIndex);

                Player* player = GetCaster()->ToPlayer();
                uint32 sound_id = RAND( SOUND_ASHBRINGER_1, SOUND_ASHBRINGER_2, SOUND_ASHBRINGER_3, SOUND_ASHBRINGER_4, SOUND_ASHBRINGER_5, SOUND_ASHBRINGER_6,
                                SOUND_ASHBRINGER_7, SOUND_ASHBRINGER_8, SOUND_ASHBRINGER_9, SOUND_ASHBRINGER_10, SOUND_ASHBRINGER_11, SOUND_ASHBRINGER_12 );

                // Ashbringers effect (spellID 28441) retriggers every 5 seconds, with a chance of making it say one of the above 12 sounds
                if (urand(0, 60) < 1)
                    player->PlayDirectSound(sound_id, player);
            }

            void Register()
            {
                OnEffectHit += SpellEffectFn(spell_item_ashbringer_SpellScript::OnDummyEffect, EFFECT_0, SPELL_EFFECT_DUMMY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_item_ashbringer_SpellScript();
        }
};

enum MagicEater
{
    SPELL_WILD_MAGIC                             = 58891,
    SPELL_WELL_FED_1                             = 57288,
    SPELL_WELL_FED_2                             = 57139,
    SPELL_WELL_FED_3                             = 57111,
    SPELL_WELL_FED_4                             = 57286,
    SPELL_WELL_FED_5                             = 57291,
};

class spell_magic_eater_food : public SpellScriptLoader
{
    public:
        spell_magic_eater_food() : SpellScriptLoader("spell_magic_eater_food") { }

        class spell_magic_eater_food_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_magic_eater_food_AuraScript);

            void HandleTriggerSpell(AuraEffect const* /*aurEff*/)
            {
                PreventDefaultAction();
                Unit* target = GetTarget();
                switch (urand(0, 5))
                {
                    case 0:
                        target->CastSpell(target, SPELL_WILD_MAGIC, true);
                        break;
                    case 1:
                        target->CastSpell(target, SPELL_WELL_FED_1, true);
                        break;
                    case 2:
                        target->CastSpell(target, SPELL_WELL_FED_2, true);
                        break;
                    case 3:
                        target->CastSpell(target, SPELL_WELL_FED_3, true);
                        break;
                    case 4:
                        target->CastSpell(target, SPELL_WELL_FED_4, true);
                        break;
                    case 5:
                        target->CastSpell(target, SPELL_WELL_FED_5, true);
                        break;
                }
            }

            void Register()
            {
                OnEffectPeriodic += AuraEffectPeriodicFn(spell_magic_eater_food_AuraScript::HandleTriggerSpell, EFFECT_1, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_magic_eater_food_AuraScript();
        }
};

class spell_item_shimmering_vessel : public SpellScriptLoader
{
    public:
        spell_item_shimmering_vessel() : SpellScriptLoader("spell_item_shimmering_vessel") { }

        class spell_item_shimmering_vessel_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_item_shimmering_vessel_SpellScript);

            void HandleDummy(SpellEffIndex /* effIndex */)
            {
                if (Creature* target = GetHitCreature())
                    target->setDeathState(JUST_RESPAWNED);
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_item_shimmering_vessel_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_item_shimmering_vessel_SpellScript();
        }
};

enum PurifyHelboarMeat
{
    SPELL_SUMMON_PURIFIED_HELBOAR_MEAT      = 29277,
    SPELL_SUMMON_TOXIC_HELBOAR_MEAT         = 29278,
};

class spell_item_purify_helboar_meat : public SpellScriptLoader
{
    public:
        spell_item_purify_helboar_meat() : SpellScriptLoader("spell_item_purify_helboar_meat") { }

        class spell_item_purify_helboar_meat_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_item_purify_helboar_meat_SpellScript);

            bool Load()
            {
                return GetCaster()->GetTypeId() == TYPEID_PLAYER;
            }

            bool Validate(SpellInfo const* /*spell*/)
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_SUMMON_PURIFIED_HELBOAR_MEAT) ||  !sSpellMgr->GetSpellInfo(SPELL_SUMMON_TOXIC_HELBOAR_MEAT))
                    return false;
                return true;
            }

            void HandleDummy(SpellEffIndex /* effIndex */)
            {
                Unit* caster = GetCaster();
                caster->CastSpell(caster, roll_chance_i(50) ? SPELL_SUMMON_PURIFIED_HELBOAR_MEAT : SPELL_SUMMON_TOXIC_HELBOAR_MEAT, true, nullptr);
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_item_purify_helboar_meat_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_item_purify_helboar_meat_SpellScript();
        }
};

enum CrystalPrison
{
    OBJECT_IMPRISONED_DOOMGUARD     = 179644,
};

class spell_item_crystal_prison_dummy_dnd : public SpellScriptLoader
{
    public:
        spell_item_crystal_prison_dummy_dnd() : SpellScriptLoader("spell_item_crystal_prison_dummy_dnd") { }

        class spell_item_crystal_prison_dummy_dnd_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_item_crystal_prison_dummy_dnd_SpellScript);

            bool Validate(SpellInfo const* /*spell*/)
            {
                if (!sObjectMgr->GetGameObjectTemplate(OBJECT_IMPRISONED_DOOMGUARD))
                    return false;
                return true;
            }

            void HandleDummy(SpellEffIndex /* effIndex */)
            {
                if (Creature* target = GetHitCreature())
                    if (target->isDead() && !target->IsPet())
                    {
                        GetCaster()->SummonGameObject(OBJECT_IMPRISONED_DOOMGUARD, target->GetPositionX(), target->GetPositionY(), target->GetPositionZ(), target->GetOrientation(), 0, 0, 0, 0, uint32(target->GetRespawnTime()-time(nullptr)));
                        target->DespawnOrUnsummon();
                    }
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_item_crystal_prison_dummy_dnd_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_item_crystal_prison_dummy_dnd_SpellScript();
        }
};

enum ReindeerTransformation
{
    SPELL_FLYING_REINDEER_310                   = 44827,
    SPELL_FLYING_REINDEER_280                   = 44825,
    SPELL_FLYING_REINDEER_60                    = 44824,
    SPELL_REINDEER_100                          = 25859,
    SPELL_REINDEER_60                           = 25858,
};

class spell_item_reindeer_transformation : public SpellScriptLoader
{
    public:
        spell_item_reindeer_transformation() : SpellScriptLoader("spell_item_reindeer_transformation") { }

        class spell_item_reindeer_transformation_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_item_reindeer_transformation_SpellScript);

            bool Validate(SpellInfo const* /*spell*/)
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_FLYING_REINDEER_310) || !sSpellMgr->GetSpellInfo(SPELL_FLYING_REINDEER_280)
                    || !sSpellMgr->GetSpellInfo(SPELL_FLYING_REINDEER_60) || !sSpellMgr->GetSpellInfo(SPELL_REINDEER_100)
                    || !sSpellMgr->GetSpellInfo(SPELL_REINDEER_60))
                    return false;
                return true;
            }

            void HandleDummy(SpellEffIndex /* effIndex */)
            {
                Unit* caster = GetCaster();
                if (caster->HasAuraType(SPELL_AURA_MOUNTED))
                {
                    float flyspeed = caster->GetSpeedRate(MOVE_FLIGHT);
                    float speed = caster->GetSpeedRate(MOVE_RUN);

                    caster->RemoveAurasByType(SPELL_AURA_MOUNTED);
                    //5 different spells used depending on mounted speed and if mount can fly or not

                    if (flyspeed >= 4.1f)
                        // Flying Reindeer
                        caster->CastSpell(caster, SPELL_FLYING_REINDEER_310, true); //310% flying Reindeer
                    else if (flyspeed >= 3.8f)
                        // Flying Reindeer
                        caster->CastSpell(caster, SPELL_FLYING_REINDEER_280, true); //280% flying Reindeer
                    else if (flyspeed >= 1.6f)
                        // Flying Reindeer
                        caster->CastSpell(caster, SPELL_FLYING_REINDEER_60, true); //60% flying Reindeer
                    else if (speed >= 2.0f)
                        // Reindeer
                        caster->CastSpell(caster, SPELL_REINDEER_100, true); //100% ground Reindeer
                    else
                        // Reindeer
                        caster->CastSpell(caster, SPELL_REINDEER_60, true); //60% ground Reindeer
                }
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_item_reindeer_transformation_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
            }
    };

    SpellScript* GetSpellScript() const
    {
        return new spell_item_reindeer_transformation_SpellScript();
    }
};

enum NighInvulnerability
{
    SPELL_NIGH_INVULNERABILITY                  = 30456,
    SPELL_COMPLETE_VULNERABILITY                = 30457,
};

class spell_item_nigh_invulnerability : public SpellScriptLoader
{
    public:
        spell_item_nigh_invulnerability() : SpellScriptLoader("spell_item_nigh_invulnerability") { }

        class spell_item_nigh_invulnerability_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_item_nigh_invulnerability_SpellScript);

            bool Validate(SpellInfo const* /*spell*/)
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_NIGH_INVULNERABILITY) || !sSpellMgr->GetSpellInfo(SPELL_COMPLETE_VULNERABILITY))
                    return false;
                return true;
            }

            void HandleDummy(SpellEffIndex /* effIndex */)
            {
                Unit* caster = GetCaster();
                if (Item* castItem = GetCastItem())
                {
                    if (roll_chance_i(86))                  // Nigh-Invulnerability   - success
                        caster->CastSpell(caster, SPELL_NIGH_INVULNERABILITY, true, castItem);
                    else                                    // Complete Vulnerability - backfire in 14% casts
                        caster->CastSpell(caster, SPELL_COMPLETE_VULNERABILITY, true, castItem);
                }
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_item_nigh_invulnerability_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_item_nigh_invulnerability_SpellScript();
        }
};

enum Poultryzer
{
    SPELL_POULTRYIZER_SUCCESS    = 30501,
    SPELL_POULTRYIZER_BACKFIRE   = 30504,
};

class spell_item_poultryizer : public SpellScriptLoader
{
    public:
        spell_item_poultryizer() : SpellScriptLoader("spell_item_poultryizer") { }

        class spell_item_poultryizer_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_item_poultryizer_SpellScript);

            bool Validate(SpellInfo const* /*spell*/)
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_POULTRYIZER_SUCCESS) || !sSpellMgr->GetSpellInfo(SPELL_POULTRYIZER_BACKFIRE))
                    return false;
                return true;
            }

            void HandleDummy(SpellEffIndex /* effIndex */)
            {
                if (GetCastItem() && GetHitUnit())
                    GetCaster()->CastSpell(GetHitUnit(), roll_chance_i(80) ? SPELL_POULTRYIZER_SUCCESS : SPELL_POULTRYIZER_BACKFIRE, true, GetCastItem());
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_item_poultryizer_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_item_poultryizer_SpellScript();
        }
};

enum SocretharsStone
{
    SPELL_SOCRETHAR_TO_SEAT     = 35743,
    SPELL_SOCRETHAR_FROM_SEAT   = 35744,
};

class spell_item_socrethars_stone : public SpellScriptLoader
{
    public:
        spell_item_socrethars_stone() : SpellScriptLoader("spell_item_socrethars_stone") { }

        class spell_item_socrethars_stone_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_item_socrethars_stone_SpellScript);

            bool Load()
            {
                return (GetCaster()->GetAreaId() == 3900 || GetCaster()->GetAreaId() == 3742);
            }
            bool Validate(SpellInfo const* /*spell*/)
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_SOCRETHAR_TO_SEAT) || !sSpellMgr->GetSpellInfo(SPELL_SOCRETHAR_FROM_SEAT))
                    return false;
                return true;
            }

            void HandleDummy(SpellEffIndex /* effIndex */)
            {
                Unit* caster = GetCaster();
                switch (caster->GetAreaId())
                {
                    case 3900:
                        caster->CastSpell(caster, SPELL_SOCRETHAR_TO_SEAT, true);
                        break;
                    case 3742:
                        caster->CastSpell(caster, SPELL_SOCRETHAR_FROM_SEAT, true);
                        break;
                    default:
                        return;
                }
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_item_socrethars_stone_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_item_socrethars_stone_SpellScript();
        }
};

enum DemonBroiledSurprise
{
    QUEST_SUPER_HOT_STEW                    = 11379,
    SPELL_CREATE_DEMON_BROILED_SURPRISE     = 43753,
    NPC_ABYSSAL_FLAMEBRINGER                = 19973,
};

class spell_item_demon_broiled_surprise : public SpellScriptLoader
{
    public:
        spell_item_demon_broiled_surprise() : SpellScriptLoader("spell_item_demon_broiled_surprise") { }

        class spell_item_demon_broiled_surprise_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_item_demon_broiled_surprise_SpellScript);

            bool Validate(SpellInfo const* /*spell*/)
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_CREATE_DEMON_BROILED_SURPRISE) || !sObjectMgr->GetCreatureTemplate(NPC_ABYSSAL_FLAMEBRINGER) || !sObjectMgr->GetQuestTemplate(QUEST_SUPER_HOT_STEW))
                    return false;
                return true;
            }

            bool Load()
            {
               return GetCaster()->GetTypeId() == TYPEID_PLAYER;
            }

            void HandleDummy(SpellEffIndex /* effIndex */)
            {
                Unit* player = GetCaster();
                player->CastSpell(player, SPELL_CREATE_DEMON_BROILED_SURPRISE, false);
            }

            SpellCastResult CheckRequirement()
            {
                Player* player = GetCaster()->ToPlayer();
                if (player->GetQuestStatus(QUEST_SUPER_HOT_STEW) != QUEST_STATUS_INCOMPLETE)
                    return SPELL_FAILED_CANT_DO_THAT_RIGHT_NOW;

                if (Creature* creature = player->FindNearestCreature(NPC_ABYSSAL_FLAMEBRINGER, 10, false))
                    if (creature->isDead())
                        return SPELL_CAST_OK;
                return SPELL_FAILED_NOT_HERE;
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_item_demon_broiled_surprise_SpellScript::HandleDummy, EFFECT_1, SPELL_EFFECT_DUMMY);
                OnCheckCast += SpellCheckCastFn(spell_item_demon_broiled_surprise_SpellScript::CheckRequirement);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_item_demon_broiled_surprise_SpellScript();
        }
};

enum CompleteRaptorCapture
{
    SPELL_RAPTOR_CAPTURE_CREDIT     = 42337,
};

class spell_item_complete_raptor_capture : public SpellScriptLoader
{
    public:
        spell_item_complete_raptor_capture() : SpellScriptLoader("spell_item_complete_raptor_capture") { }

        class spell_item_complete_raptor_capture_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_item_complete_raptor_capture_SpellScript);

            bool Validate(SpellInfo const* /*spell*/)
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_RAPTOR_CAPTURE_CREDIT))
                    return false;
                return true;
            }

            void HandleDummy(SpellEffIndex /* effIndex */)
            {
                Unit* caster = GetCaster();
                if (GetHitCreature())
                {
                    GetHitCreature()->DespawnOrUnsummon();

                    //cast spell Raptor Capture Credit
                    caster->CastSpell(caster, SPELL_RAPTOR_CAPTURE_CREDIT, true, nullptr);
                }
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_item_complete_raptor_capture_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_item_complete_raptor_capture_SpellScript();
        }
};

enum ImpaleLeviroth
{
    NPC_LEVIROTH                = 26452,
    SPELL_LEVIROTH_SELF_IMPALE  = 49882,
};

class spell_item_impale_leviroth : public SpellScriptLoader
{
    public:
        spell_item_impale_leviroth() : SpellScriptLoader("spell_item_impale_leviroth") { }

        class spell_item_impale_leviroth_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_item_impale_leviroth_SpellScript);

            bool Validate(SpellInfo const* /*spell*/)
            {
                if (!sObjectMgr->GetCreatureTemplate(NPC_LEVIROTH))
                    return false;
                return true;
            }

            void HandleDummy(SpellEffIndex /* effIndex */)
            {
                if (Creature* target = GetHitCreature())
                    if (target->GetEntry() == NPC_LEVIROTH && target->HealthAbovePct(94))
                    {
                        target->CastSpell(target, SPELL_LEVIROTH_SELF_IMPALE, true);
                        target->SetBaseWeaponDamage(BASE_ATTACK, MINDAMAGE, 150);
                        target->SetBaseWeaponDamage(BASE_ATTACK, MAXDAMAGE, 200);
                        target->LowerPlayerDamageReq(target->GetMaxHealth());
                    }
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_item_impale_leviroth_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_item_impale_leviroth_SpellScript();
        }
};

enum BrewfestMountTransformation
{
    SPELL_MOUNT_RAM_100                         = 43900,
    SPELL_MOUNT_RAM_60                          = 43899,
    SPELL_MOUNT_KODO_100                        = 49379,
    SPELL_MOUNT_KODO_60                         = 49378,
    SPELL_BREWFEST_MOUNT_TRANSFORM              = 49357,
    SPELL_BREWFEST_MOUNT_TRANSFORM_REVERSE      = 52845,
};

class spell_item_brewfest_mount_transformation : public SpellScriptLoader
{
    public:
        spell_item_brewfest_mount_transformation() : SpellScriptLoader("spell_item_brewfest_mount_transformation") { }

        class spell_item_brewfest_mount_transformation_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_item_brewfest_mount_transformation_SpellScript);

            bool Validate(SpellInfo const* /*spell*/)
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_MOUNT_RAM_100) || !sSpellMgr->GetSpellInfo(SPELL_MOUNT_RAM_60) || !sSpellMgr->GetSpellInfo(SPELL_MOUNT_KODO_100) || !sSpellMgr->GetSpellInfo(SPELL_MOUNT_KODO_60))
                    return false;
                return true;
            }

            void HandleDummy(SpellEffIndex /* effIndex */)
            {
                Player* caster = GetCaster()->ToPlayer();
                if (caster->HasAuraType(SPELL_AURA_MOUNTED))
                {
                    caster->RemoveAurasByType(SPELL_AURA_MOUNTED);
                    uint32 spell_id;

                    switch (GetSpellInfo()->Id)
                    {
                        case SPELL_BREWFEST_MOUNT_TRANSFORM:
                            if (caster->GetSpeedRate(MOVE_RUN) >= 2.0f)
                                spell_id = caster->GetTeamId() == TEAM_ALLIANCE ? SPELL_MOUNT_RAM_100 : SPELL_MOUNT_KODO_100;
                            else
                                spell_id = caster->GetTeamId() == TEAM_ALLIANCE ? SPELL_MOUNT_RAM_60 : SPELL_MOUNT_KODO_60;
                            break;
                        case SPELL_BREWFEST_MOUNT_TRANSFORM_REVERSE:
                            if (caster->GetSpeedRate(MOVE_RUN) >= 2.0f)
                                spell_id = caster->GetTeamId() == TEAM_HORDE ? SPELL_MOUNT_RAM_100 : SPELL_MOUNT_KODO_100;
                            else
                                spell_id = caster->GetTeamId() == TEAM_HORDE ? SPELL_MOUNT_RAM_60 : SPELL_MOUNT_KODO_60;
                            break;
                        default:
                            return;
                    }
                    caster->CastSpell(caster, spell_id, true);
                }
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_item_brewfest_mount_transformation_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_item_brewfest_mount_transformation_SpellScript();
        }
};

enum NitroBoots
{
    SPELL_NITRO_BOOTS_SUCCESS       = 54861,
    SPELL_NITRO_BOOTS_BACKFIRE      = 46014,
};

class spell_item_nitro_boots : public SpellScriptLoader
{
    public:
        spell_item_nitro_boots() : SpellScriptLoader("spell_item_nitro_boots") { }

        class spell_item_nitro_boots_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_item_nitro_boots_SpellScript);

            bool Load()
            {
                if (!GetCastItem())
                    return false;
                return true;
            }

            bool Validate(SpellInfo const* /*spell*/)
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_NITRO_BOOTS_SUCCESS) || !sSpellMgr->GetSpellInfo(SPELL_NITRO_BOOTS_BACKFIRE))
                    return false;
                return true;
            }

            void HandleDummy(SpellEffIndex /* effIndex */)
            {
                Unit* caster = GetCaster();
                caster->CastSpell(caster, caster->GetMap()->IsDungeon() || roll_chance_i(95) ? SPELL_NITRO_BOOTS_SUCCESS : SPELL_NITRO_BOOTS_BACKFIRE, true, GetCastItem());
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_item_nitro_boots_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_item_nitro_boots_SpellScript();
        }
};

enum TeachLanguage
{
    SPELL_LEARN_GNOMISH_BINARY      = 50242,
    SPELL_LEARN_GOBLIN_BINARY       = 50246,
};

class spell_item_teach_language : public SpellScriptLoader
{
    public:
        spell_item_teach_language() : SpellScriptLoader("spell_item_teach_language") { }

        class spell_item_teach_language_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_item_teach_language_SpellScript);

            bool Load()
            {
                return GetCaster()->GetTypeId() == TYPEID_PLAYER;
            }

            bool Validate(SpellInfo const* /*spell*/)
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_LEARN_GNOMISH_BINARY) || !sSpellMgr->GetSpellInfo(SPELL_LEARN_GOBLIN_BINARY))
                    return false;
                return true;
            }

            void HandleDummy(SpellEffIndex /* effIndex */)
            {
                Player* caster = GetCaster()->ToPlayer();

                if (roll_chance_i(34))
                    caster->CastSpell(caster, caster->GetTeamId() == TEAM_ALLIANCE ? SPELL_LEARN_GNOMISH_BINARY : SPELL_LEARN_GOBLIN_BINARY, true);
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_item_teach_language_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_item_teach_language_SpellScript();
        }
};

enum RocketBoots
{
    SPELL_ROCKET_BOOTS_PROC      = 30452,
};

class spell_item_rocket_boots : public SpellScriptLoader
{
    public:
        spell_item_rocket_boots() : SpellScriptLoader("spell_item_rocket_boots") { }

        class spell_item_rocket_boots_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_item_rocket_boots_SpellScript);

            bool Load()
            {
                return GetCaster()->GetTypeId() == TYPEID_PLAYER;
            }

            bool Validate(SpellInfo const* /*spell*/)
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_ROCKET_BOOTS_PROC))
                    return false;
                return true;
            }

            void HandleDummy(SpellEffIndex /* effIndex */)
            {
                Player* caster = GetCaster()->ToPlayer();
                if (Battleground* bg = caster->GetBattleground())
                    bg->EventPlayerDroppedFlag(caster);

                caster->RemoveSpellCooldown(SPELL_ROCKET_BOOTS_PROC);
                caster->CastSpell(caster, SPELL_ROCKET_BOOTS_PROC, true, nullptr);
            }

            SpellCastResult CheckCast()
            {
                if (GetCaster()->IsInWater())
                    return SPELL_FAILED_ONLY_ABOVEWATER;
                return SPELL_CAST_OK;
            }

            void Register()
            {
                OnCheckCast += SpellCheckCastFn(spell_item_rocket_boots_SpellScript::CheckCast);
                OnEffectHitTarget += SpellEffectFn(spell_item_rocket_boots_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_item_rocket_boots_SpellScript();
        }
};

enum PygmyOil
{
    SPELL_PYGMY_OIL_PYGMY_AURA      = 53806,
    SPELL_PYGMY_OIL_SMALLER_AURA    = 53805,
};

class spell_item_pygmy_oil : public SpellScriptLoader
{
    public:
        spell_item_pygmy_oil() : SpellScriptLoader("spell_item_pygmy_oil") { }

        class spell_item_pygmy_oil_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_item_pygmy_oil_SpellScript);

            bool Validate(SpellInfo const* /*spell*/)
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_PYGMY_OIL_PYGMY_AURA) || !sSpellMgr->GetSpellInfo(SPELL_PYGMY_OIL_SMALLER_AURA))
                    return false;
                return true;
            }

            void HandleDummy(SpellEffIndex /* effIndex */)
            {
                Unit* caster = GetCaster();
                if (Aura* aura = caster->GetAura(SPELL_PYGMY_OIL_PYGMY_AURA))
                    aura->RefreshDuration();
                else
                {
                    aura = caster->GetAura(SPELL_PYGMY_OIL_SMALLER_AURA);
                    if (!aura || aura->GetStackAmount() < 5 || !roll_chance_i(50))
                         caster->CastSpell(caster, SPELL_PYGMY_OIL_SMALLER_AURA, true);
                    else
                    {
                        aura->Remove();
                        caster->CastSpell(caster, SPELL_PYGMY_OIL_PYGMY_AURA, true);
                    }
                }
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_item_pygmy_oil_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_item_pygmy_oil_SpellScript();
        }
};

class spell_item_unusual_compass : public SpellScriptLoader
{
    public:
        spell_item_unusual_compass() : SpellScriptLoader("spell_item_unusual_compass") { }

        class spell_item_unusual_compass_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_item_unusual_compass_SpellScript);

            void HandleDummy(SpellEffIndex /* effIndex */)
            {
                Unit* caster = GetCaster();
                caster->SetFacingTo(frand(0.0f, 2.0f * M_PI));
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_item_unusual_compass_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_item_unusual_compass_SpellScript();
        }
};

enum ChickenCover
{
    SPELL_CHICKEN_NET               = 51959,
    SPELL_CAPTURE_CHICKEN_ESCAPE    = 51037,
    QUEST_CHICKEN_PARTY             = 12702,
    QUEST_FLOWN_THE_COOP            = 12532,
};

class spell_item_chicken_cover : public SpellScriptLoader
{
    public:
        spell_item_chicken_cover() : SpellScriptLoader("spell_item_chicken_cover") { }

        class spell_item_chicken_cover_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_item_chicken_cover_SpellScript);

            bool Load()
            {
                return GetCaster()->GetTypeId() == TYPEID_PLAYER;
            }

            bool Validate(SpellInfo const* /*spell*/)
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_CHICKEN_NET) || !sSpellMgr->GetSpellInfo(SPELL_CAPTURE_CHICKEN_ESCAPE) || !sObjectMgr->GetQuestTemplate(QUEST_CHICKEN_PARTY) || !sObjectMgr->GetQuestTemplate(QUEST_FLOWN_THE_COOP))
                    return false;
                return true;
            }

            void HandleDummy(SpellEffIndex /* effIndex */)
            {
                Player* caster = GetCaster()->ToPlayer();
                if (Unit* target = GetHitUnit())
                {
                    if (!target->HasAura(SPELL_CHICKEN_NET) && (caster->GetQuestStatus(QUEST_CHICKEN_PARTY) == QUEST_STATUS_INCOMPLETE || caster->GetQuestStatus(QUEST_FLOWN_THE_COOP) == QUEST_STATUS_INCOMPLETE))
                    {
                        caster->CastSpell(caster, SPELL_CAPTURE_CHICKEN_ESCAPE, true);
                        Unit::Kill(target, target);
                    }
                }
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_item_chicken_cover_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_item_chicken_cover_SpellScript();
        }
};

enum Refocus
{
    SPELL_AIMED_SHOT    = 19434,
    SPELL_MULTISHOT     = 2643,
    SPELL_VOLLEY        = 42243,
};

class spell_item_refocus : public SpellScriptLoader
{
    public:
        spell_item_refocus() : SpellScriptLoader("spell_item_refocus") { }

        class spell_item_refocus_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_item_refocus_SpellScript);

            void HandleDummy(SpellEffIndex /*effIndex*/)
            {
                Player* caster = GetCaster()->ToPlayer();

                if (!caster || caster->getClass() != CLASS_HUNTER)
                    return;

                caster->RemoveSpellCooldown(SPELL_AIMED_SHOT, true);
                caster->RemoveSpellCooldown(SPELL_MULTISHOT, true);
                caster->RemoveSpellCooldown(SPELL_VOLLEY, true);
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_item_refocus_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_item_refocus_SpellScript();
        }
};

class spell_item_muisek_vessel : public SpellScriptLoader
{
    public:
        spell_item_muisek_vessel() : SpellScriptLoader("spell_item_muisek_vessel") { }

        class spell_item_muisek_vessel_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_item_muisek_vessel_SpellScript);

            void HandleDummy(SpellEffIndex /*effIndex*/)
            {
                if (Creature* target = GetHitCreature())
                    if (target->isDead())
                        target->DespawnOrUnsummon();
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_item_muisek_vessel_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_item_muisek_vessel_SpellScript();
        }
};

enum GreatmothersSoulcather
{
    SPELL_FORCE_CAST_SUMMON_GNOME_SOUL = 46486,
};
class spell_item_greatmothers_soulcatcher : public SpellScriptLoader
{
public:
    spell_item_greatmothers_soulcatcher() : SpellScriptLoader("spell_item_greatmothers_soulcatcher") { }

    class spell_item_greatmothers_soulcatcher_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_item_greatmothers_soulcatcher_SpellScript);

        void HandleDummy(SpellEffIndex /*effIndex*/)
        {
            if (GetHitUnit())
                GetCaster()->CastSpell(GetCaster(), SPELL_FORCE_CAST_SUMMON_GNOME_SOUL);
        }

        void Register()
        {
            OnEffectHitTarget += SpellEffectFn(spell_item_greatmothers_soulcatcher_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
        }
    };

    SpellScript* GetSpellScript() const
    {
        return new spell_item_greatmothers_soulcatcher_SpellScript();
    }
};

enum Eggnog
{
    SPELL_EGG_NOG_REINDEER = 21936,
    SPELL_EGG_NOG_SNOWMAN  = 21980,
};
class spell_item_eggnog : public SpellScriptLoader
{
public:
    spell_item_eggnog() : SpellScriptLoader("spell_item_eggnog") { }

    class spell_item_eggnog_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_item_eggnog_SpellScript);

        bool Validate(SpellInfo const* /*spellInfo*/) override
        {
            if (!sSpellMgr->GetSpellInfo(SPELL_EGG_NOG_REINDEER) || !sSpellMgr->GetSpellInfo(SPELL_EGG_NOG_SNOWMAN))
                return false;
            return true;
        }

        void HandleScript(SpellEffIndex /* effIndex */)
        {
            if (roll_chance_i(40))
                GetCaster()->CastSpell(GetHitUnit(), roll_chance_i(50) ? SPELL_EGG_NOG_REINDEER : SPELL_EGG_NOG_SNOWMAN, GetCastItem());
        }

        void Register() override
        {
            OnEffectHitTarget += SpellEffectFn(spell_item_eggnog_SpellScript::HandleScript, EFFECT_2, SPELL_EFFECT_INEBRIATE);
        }
    };

    SpellScript* GetSpellScript() const
    {
        return new spell_item_eggnog_SpellScript();
    }
};

void AddSC_item_spell_scripts()
{
    // Ours
    new spell_item_massive_seaforium_charge();
    new spell_item_titanium_seal_of_dalaran();
    new spell_item_mind_amplify_dish();
    new spell_item_runescroll_of_fortitude();
    new spell_item_branns_communicator();
    new spell_item_goblin_gumbo_kettle();
    new spell_item_mithril_spurs();
    new spell_item_magic_dust();
    new spell_item_toy_train_set();
    new spell_item_rocket_chicken();
    new spell_item_sleepy_willy();
    new spell_item_lil_phylactery();
    new spell_item_shifting_naaru_silver();
    new spell_item_toxic_wasteling();
    new spell_item_lil_xt();
    new spell_item_essence_of_life();
    new spell_item_crazy_alchemists_potion();
    new spell_item_skull_of_impeding_doom();
    new spell_item_carrot_on_a_stick();
    new spell_item_feast();
    new spell_item_gnomish_universal_remote();
    new spell_item_strong_anti_venom();
    new spell_item_gnomish_shrink_ray();
    new spell_item_goblin_weather_machine();
    new spell_item_light_lamp();
    new spell_item_fetch_ball();
    new spell_item_oracle_ablutions();
    new spell_item_trauma();
    new spell_item_blade_ward_enchant();
    new spell_item_blood_draining_enchant();
    new spell_item_dragon_kite_summon_lightning_bunny();
    new spell_item_enchanted_broom_periodic();
    new spell_item_summon_or_dismiss();
    new spell_item_draenic_pale_ale();
    new spell_item_direbrew_remote();
    new spell_item_eye_of_gruul_healing_discount();
    new spell_item_summon_argent_knight();

    // Theirs
    // 23074 Arcanite Dragonling
    new spell_item_trigger_spell("spell_item_arcanite_dragonling", SPELL_ARCANITE_DRAGONLING);
    // 23133 Gnomish Battle Chicken
    new spell_item_trigger_spell("spell_item_gnomish_battle_chicken", SPELL_BATTLE_CHICKEN);
    // 23076 Mechanical Dragonling
    new spell_item_trigger_spell("spell_item_mechanical_dragonling", SPELL_MECHANICAL_DRAGONLING);
    // 23075 Mithril Mechanical Dragonling
    new spell_item_trigger_spell("spell_item_mithril_mechanical_dragonling", SPELL_MITHRIL_MECHANICAL_DRAGONLING);

    new spell_item_aegis_of_preservation();
    new spell_item_arcane_shroud();
    new spell_item_blessing_of_ancient_kings();
    new spell_item_valanyr_hammer_of_ancient_kings();
    new spell_item_defibrillate("spell_item_goblin_jumper_cables", 67, SPELL_GOBLIN_JUMPER_CABLES_FAIL);
    new spell_item_defibrillate("spell_item_goblin_jumper_cables_xl", 50, SPELL_GOBLIN_JUMPER_CABLES_XL_FAIL);
    new spell_item_defibrillate("spell_item_gnomish_army_knife", 33);
    new spell_item_desperate_defense();
    new spell_item_deviate_fish();
    new spell_item_echoes_of_light();
    new spell_item_fate_rune_of_unsurpassed_vigor();
    new spell_item_flask_of_the_north();
    new spell_item_gnomish_death_ray();
    new spell_item_make_a_wish();
    new spell_item_mingos_fortune_generator();
    new spell_item_necrotic_touch();
    new spell_item_net_o_matic();
    new spell_item_noggenfogger_elixir();
    new spell_item_piccolo_of_the_flaming_fire();
    new spell_item_savory_deviate_delight();
    new spell_item_scroll_of_recall();
    new spell_item_unsated_craving();
    new spell_item_shadows_fate();
    new spell_item_shadowmourne();
    new spell_item_shadowmourne_soul_fragment();
    new spell_item_six_demon_bag();
    new spell_item_the_eye_of_diminution();
    new spell_item_underbelly_elixir();
    new spell_item_book_of_glyph_mastery();
    new spell_item_map_of_the_geyser_fields();
    new spell_item_vanquished_clutches();

    new spell_item_ashbringer();
    new spell_magic_eater_food();
    new spell_item_refocus();
    new spell_item_shimmering_vessel();
    new spell_item_purify_helboar_meat();
    new spell_item_crystal_prison_dummy_dnd();
    new spell_item_reindeer_transformation();
    new spell_item_nigh_invulnerability();
    new spell_item_poultryizer();
    new spell_item_socrethars_stone();
    new spell_item_demon_broiled_surprise();
    new spell_item_complete_raptor_capture();
    new spell_item_impale_leviroth();
    new spell_item_brewfest_mount_transformation();
    new spell_item_nitro_boots();
    new spell_item_teach_language();
    new spell_item_rocket_boots();
    new spell_item_pygmy_oil();
    new spell_item_unusual_compass();
    new spell_item_chicken_cover();
    new spell_item_muisek_vessel();
    new spell_item_greatmothers_soulcatcher();
    new spell_item_eggnog();
}

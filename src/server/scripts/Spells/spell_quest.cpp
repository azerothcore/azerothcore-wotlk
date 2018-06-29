/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

/*
 * Scripts for spells with SPELLFAMILY_GENERIC spells used for quests.
 * Ordered alphabetically using questId and scriptname.
 * Scriptnames of files in this file should be prefixed with "spell_q#questID_".
 */

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "SpellScript.h"
#include "Vehicle.h"
#include "SpellAuras.h"
#include "GridNotifiers.h"
#include "MapManager.h"
#include "CreatureTextMgr.h"
#include "SpellAuraEffects.h"
#include "CellImpl.h"

// Ours
class spell_q11065_wrangle_some_aether_rays : public SpellScriptLoader
{
    public:
        spell_q11065_wrangle_some_aether_rays() : SpellScriptLoader("spell_q11065_wrangle_some_aether_rays") { }

        class spell_q11065_wrangle_some_aether_rays_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_q11065_wrangle_some_aether_rays_SpellScript);

            SpellCastResult CheckCast()
            {
                // if thane is present and not in combat - allow cast
                if (Unit* target = GetExplTargetUnit())
                    if (target->GetHealthPct() < 40.0f)
                        return SPELL_CAST_OK;

                return SPELL_FAILED_CASTER_AURASTATE;
            }

            void Register()
            {
                OnCheckCast += SpellCheckCastFn(spell_q11065_wrangle_some_aether_rays_SpellScript::CheckCast);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_q11065_wrangle_some_aether_rays_SpellScript();
        }

        class spell_q11065_wrangle_some_aether_rays_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_q11065_wrangle_some_aether_rays_AuraScript)
            void HandleEffectRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
            {
                Unit* ar = GetTarget();
                if (ar && ar->ToCreature())
                {
                    if (GetCaster() && GetCaster()->ToPlayer())
                    {
                        Player* player = GetCaster()->ToPlayer();

                        player->KilledMonsterCredit(23343, 0);
                        if (Creature *cr = GetCaster()->SummonCreature(23343, ar->GetPositionX(), ar->GetPositionY(), ar->GetPositionZ(), ar->GetOrientation(), TEMPSUMMON_TIMED_DESPAWN, 180000))
                        {
                            cr->CastSpell(player, 40926, true);
                            cr->GetMotionMaster()->MoveFollow(player, 5.0f, 2*M_PI*rand_norm());
                            ar->ToCreature()->DespawnOrUnsummon(500);
                        }
                    }
                }
            }

            void HandleEffectApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
            {
                SetDuration(5000);
            }

            void Register()
            {
                OnEffectApply += AuraEffectApplyFn(spell_q11065_wrangle_some_aether_rays_AuraScript::HandleEffectApply, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
                OnEffectRemove += AuraEffectRemoveFn(spell_q11065_wrangle_some_aether_rays_AuraScript::HandleEffectRemove, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
            }

        };

        AuraScript* GetAuraScript() const
        {
            return new spell_q11065_wrangle_some_aether_rays_AuraScript();
        }
};

enum eDrakuru
{
    QUEST_SUBJECT_TO_INTERPRETATION         = 11991,
    QUEST_MY_HEART_IS_IN_YOUR_HANDS         = 12802,

    NPC_DRAKURU                             = 28016,
};

class spell_image_of_drakuru_reagent_check : public SpellScriptLoader
{
    public:
        spell_image_of_drakuru_reagent_check() : SpellScriptLoader("spell_image_of_drakuru_reagent_check") { }

        class spell_image_of_drakuru_reagent_check_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_image_of_drakuru_reagent_check_SpellScript);

            void HandleDummyEffect(SpellEffIndex /*effIndex*/)
            {
                Unit* caster = GetCaster();
                if (!caster || !caster->ToPlayer())
                    return;
                Player* player = caster->ToPlayer();

                float dist = player->GetDistance(3385, -1807, 114);
                if (dist < 40.0f)
                {
                    caster->ToPlayer()->GroupEventHappens(QUEST_SUBJECT_TO_INTERPRETATION, caster);
                    caster->CastSpell(caster, 47118, false);
                    return;
                }

                dist = player->GetDistance(4244, -2025, 238);
                if (dist < 40.0f)
                {
                    caster->CastSpell(caster, 47150, false);
                    return;
                }

                dist = player->GetDistance(4524, -3472, 228);
                if (dist < 40.0f)
                {
                    caster->ToPlayer()->GroupEventHappens(QUEST_MY_HEART_IS_IN_YOUR_HANDS, caster);
                    caster->CastSpell(caster, 47317, false);
                    return;
                }

                dist = player->GetDistance(4599, -4877, 48);
                if (dist < 40.0f)
                {
                    caster->CastSpell(caster, 47406, false);
                    return;
                }

                dist = player->GetDistance(-236, -614, 116);
                if (dist < 40.0f)
                {
                    caster->CastSpell(caster, 50440, false);
                    return;
                }
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_image_of_drakuru_reagent_check_SpellScript::HandleDummyEffect, EFFECT_0, SPELL_EFFECT_DUMMY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_image_of_drakuru_reagent_check_SpellScript();
        };
};

class spell_q12014_steady_as_a_rock : public SpellScriptLoader
{
    public:
        spell_q12014_steady_as_a_rock() : SpellScriptLoader("spell_q12014_steady_as_a_rock") { }

        class spell_q12014_steady_as_a_rock_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_q12014_steady_as_a_rock_SpellScript);

            void HandleFinish()
            {
                Unit* caster = GetCaster();
                if (!caster || !caster->ToPlayer()) // caster cant be null, but meh :p
                    return;

                if (caster->ToPlayer()->GetQuestStatus(12014 /*QUEST_STEADY_AS_A_ROCK*/) == QUEST_STATUS_INCOMPLETE)
                {
                    float x = caster->GetPositionX() + 3.0f*cos(caster->GetOrientation());
                    float y = caster->GetPositionY() + 3.0f*sin(caster->GetOrientation());
                    float o = caster->GetOrientation() < M_PI ? caster->GetOrientation()+M_PI : caster->GetOrientation()-M_PI;
                    caster->SummonGameObject(188367, x, y, caster->GetPositionZ(), o, 0.0f, 0.0f, 0.0f, 0.0f, 60000);
                }
            }

            void Register()
            {
                AfterCast += SpellCastFn(spell_q12014_steady_as_a_rock_SpellScript::HandleFinish);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_q12014_steady_as_a_rock_SpellScript();
        };
};

class spell_q11026_a11051_banish_the_demons : public SpellScriptLoader
{
    public:
        spell_q11026_a11051_banish_the_demons() : SpellScriptLoader("spell_q11026_a11051_banish_the_demons") { }

        class spell_q11026_a11051_banish_the_demons_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_q11026_a11051_banish_the_demons_AuraScript)

            void HandleEffectRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
            {
                Unit* ar = GetTarget();
                if (ar && !ar->IsAlive())
                    ar->CastSpell(ar, 40828, true); // Banish kill credit
            }

            void Register()
            {
                // aura spell only
                if (m_scriptSpellId == 40825)
                    OnEffectRemove += AuraEffectRemoveFn(spell_q11026_a11051_banish_the_demons_AuraScript::HandleEffectRemove, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
            }

        };

        AuraScript* GetAuraScript() const
        {
            return new spell_q11026_a11051_banish_the_demons_AuraScript();
        }

        class spell_q11026_a11051_banish_the_demons_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_q11026_a11051_banish_the_demons_SpellScript);

            void HandleScriptEffect(SpellEffIndex /*effIndex*/)
            {
                if (Unit* target = GetHitUnit())
                    if (Unit* owner = target->ToTempSummon()->GetSummoner())
                        if (owner->GetTypeId() == TYPEID_PLAYER)
                            owner->ToPlayer()->KilledMonsterCredit(23327, 0); // Some trigger, just count
            }

            void Register()
            {
                // script effect only
                if (m_scriptSpellId == 40828)
                    OnEffectHitTarget += SpellEffectFn(spell_q11026_a11051_banish_the_demons_SpellScript::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_q11026_a11051_banish_the_demons_SpellScript();
        };
};

class spell_q10525_vision_guide : public SpellScriptLoader
{
public:
    spell_q10525_vision_guide() : SpellScriptLoader("spell_q10525_vision_guide") { }

    class spell_q10525_vision_guide_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_q10525_vision_guide_AuraScript)

        void HandleEffectApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
        {
            SetDuration(75*IN_MILLISECONDS);
        }

        void HandleEffectRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
        {
            if (Player* target = GetTarget()->ToPlayer())
            {
                target->AreaExploredOrEventHappens(10525); // Vision Guide quest
                target->GetMotionMaster()->MovementExpired();
                target->CleanupAfterTaxiFlight();
                target->NearTeleportTo(2283.267f, 5987.395f, 142.4f, 3.80f);
            }
        }

        void Register()
        {
            OnEffectApply += AuraEffectApplyFn(spell_q10525_vision_guide_AuraScript::HandleEffectApply, EFFECT_0, SPELL_AURA_TRANSFORM, AURA_EFFECT_HANDLE_REAL);
            AfterEffectRemove += AuraEffectRemoveFn(spell_q10525_vision_guide_AuraScript::HandleEffectRemove, EFFECT_0, SPELL_AURA_TRANSFORM, AURA_EFFECT_HANDLE_REAL);
        }

    };

    AuraScript* GetAuraScript() const
    {
        return new spell_q10525_vision_guide_AuraScript();
    }
};

class spell_q11322_q11317_the_cleansing : public SpellScriptLoader
{
public:
    spell_q11322_q11317_the_cleansing() : SpellScriptLoader("spell_q11322_q11317_the_cleansing") { }

    class spell_q11322_q11317_the_cleansing_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_q11322_q11317_the_cleansing_AuraScript)
        
        void HandleEffectApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
        {
            Unit* ar = GetCaster();
            if (ar && ar->ToPlayer())
            {
                if (ar->ToPlayer()->GetQuestStatus(11317) == QUEST_STATUS_INCOMPLETE || ar->ToPlayer()->GetQuestStatus(11322) == QUEST_STATUS_INCOMPLETE)
                    ar->SummonCreature(27959, 3032.0f, -5095.0f, 723.0f, 0.0f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 60000);
                
                ar->SetStandState(UNIT_STAND_STATE_SIT);
            }
        }

        void Register()
        {
            OnEffectApply += AuraEffectApplyFn(spell_q11322_q11317_the_cleansing_AuraScript::HandleEffectApply, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
        }
    };

    AuraScript* GetAuraScript() const
    {
        return new spell_q11322_q11317_the_cleansing_AuraScript();
    }
};

class spell_q10714_on_spirits_wings : public SpellScriptLoader
{
public:
    spell_q10714_on_spirits_wings() : SpellScriptLoader("spell_q10714_on_spirits_wings") { }

    class spell_q10714_on_spirits_wings_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_q10714_on_spirits_wings_SpellScript);

        uint8 count;
        bool Load()
        {
            count = 0;
            return true;
        }

        void HandleDummy(SpellEffIndex /*effIndex*/)
        {
            if (Creature* target = GetHitCreature())
                if (target->GetDBTableGUIDLow() == 77757 || target->GetDBTableGUIDLow() == 78693)
                {
                    count++;
                    if (count == 2)
                        if (GetCaster() && GetCaster()->ToPlayer())
                            GetCaster()->ToPlayer()->KilledMonsterCredit(22383, 0);
                }
        }

        void Register()
        {
            OnEffectHitTarget += SpellEffectFn(spell_q10714_on_spirits_wings_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
        }
    };

    SpellScript* GetSpellScript() const
    {
        return new spell_q10714_on_spirits_wings_SpellScript();
    };
};

class spell_q10720_the_smallest_creature : public SpellScriptLoader
{
public:
    spell_q10720_the_smallest_creature() : SpellScriptLoader("spell_q10720_the_smallest_creature") { }

    class spell_q10720_the_smallest_creature_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_q10720_the_smallest_creature_SpellScript);

        void HandleScriptEffect(SpellEffIndex /*effIndex*/)
        {
            if (GetCaster() && GetHitUnit())
                if (Player* player = GetCaster()->GetCharmerOrOwnerPlayerOrPlayerItself())
                    player->KilledMonsterCredit(GetHitUnit()->GetEntry(), 0);
        }

        void Register()
        {
            OnEffectHitTarget += SpellEffectFn(spell_q10720_the_smallest_creature_SpellScript::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
        }
    };

    SpellScript* GetSpellScript() const
    {
        return new spell_q10720_the_smallest_creature_SpellScript();
    };
};

class spell_q13086_last_line_of_defence : public SpellScriptLoader
{
    public:
        spell_q13086_last_line_of_defence() : SpellScriptLoader("spell_q13086_last_line_of_defence") { }

        class spell_q13086_last_line_of_defence_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_q13086_last_line_of_defence_SpellScript);

            bool Load() { _triggerSpellId = 0; return true; }

            void HandleDummy(SpellEffIndex effIndex)
            {
                if (effIndex == EFFECT_0)
                    _triggerSpellId = GetSpellInfo()->Effects[effIndex].CalcValue();

                PreventHitEffect(effIndex);
            }

            void HandleAfterCast()
            {
                if (WorldLocation const* loc = GetExplTargetDest())
                    GetCaster()->CastSpell(loc->GetPositionX(), loc->GetPositionY(), loc->GetPositionZ(), _triggerSpellId, true);
            }

            void Register()
            {
                OnEffectLaunch += SpellEffectFn(spell_q13086_last_line_of_defence_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
                OnEffectLaunch += SpellEffectFn(spell_q13086_last_line_of_defence_SpellScript::HandleDummy, EFFECT_1, SPELL_EFFECT_DUMMY);
                AfterCast += SpellCastFn(spell_q13086_last_line_of_defence_SpellScript::HandleAfterCast);
            }

            private:
                uint32 _triggerSpellId;
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_q13086_last_line_of_defence_SpellScript();
        }
};

enum eShadowVaultDecree
{
    NPC_THANE_UFRANG                = 29919,
};

class spell_q12943_shadow_vault_decree : public SpellScriptLoader
{
    public:
        spell_q12943_shadow_vault_decree() : SpellScriptLoader("spell_q12943_shadow_vault_decree") { }

        class spell_q12943_shadow_vault_decree_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_q12943_shadow_vault_decree_SpellScript);

            SpellCastResult CheckRequirement()
            {
                // if thane is present and not in combat - allow cast
                Unit* caster = GetCaster();
                if (Creature* thane = caster->FindNearestCreature(NPC_THANE_UFRANG, 30.0f))
                    if (!thane->IsInCombat())
                        return SPELL_CAST_OK;

                return SPELL_FAILED_CASTER_AURASTATE;
            }

            void HandleScriptEffect(SpellEffIndex /*effIndex*/)
            {
                Unit* caster = GetCaster();
                if (Creature* thane = caster->FindNearestCreature(NPC_THANE_UFRANG, 30.0f))
                    thane->AI()->AttackStart(caster);
            }

            void Register()
            {
                OnCheckCast += SpellCheckCastFn(spell_q12943_shadow_vault_decree_SpellScript::CheckRequirement);
                OnEffectHitTarget += SpellEffectFn(spell_q12943_shadow_vault_decree_SpellScript::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_q12943_shadow_vault_decree_SpellScript();
        }
};

class spell_q10769_dissension_amongst_the_ranks : public SpellScriptLoader
{
public:
    spell_q10769_dissension_amongst_the_ranks() : SpellScriptLoader("spell_q10769_dissension_amongst_the_ranks") { }

    class spell_q10769_dissension_amongst_the_ranks_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_q10769_dissension_amongst_the_ranks_AuraScript)
        
        void HandleEffectApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
        {
            Unit* ar = GetTarget();
            if (ar)
            {
                if (ar->getGender() == GENDER_MALE)
                    ar->CastSpell(ar, 38225, true);
                else
                    ar->CastSpell(ar, 38227, true);
            }
        }

        void HandleEffectRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
        {
            Unit* ar = GetTarget();
            if (ar)
            {
                if (ar->getGender() == GENDER_MALE)
                    ar->RemoveAurasDueToSpell(38225);
                else
                    ar->RemoveAurasDueToSpell(38227);
            }
        }

        void Register()
        {
            if (m_scriptSpellId == 38224)
            {
                OnEffectApply += AuraEffectApplyFn(spell_q10769_dissension_amongst_the_ranks_AuraScript::HandleEffectApply, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
                OnEffectRemove += AuraEffectRemoveFn(spell_q10769_dissension_amongst_the_ranks_AuraScript::HandleEffectRemove, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
            }
        }

    };

    class spell_q10769_dissension_amongst_the_ranks_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_q10769_dissension_amongst_the_ranks_SpellScript);

        void HandleScriptEffect(SpellEffIndex /*effIndex*/)
        {
            if (Unit* target = GetHitUnit())
                if (Player* player = target->GetCharmerOrOwnerPlayerOrPlayerItself())
                    if (player->HasAura(38224))
                        player->KilledMonsterCredit(22051, 0);
        }

        void Register()
        {
            if (m_scriptSpellId == 38223)
                OnEffectHitTarget += SpellEffectFn(spell_q10769_dissension_amongst_the_ranks_SpellScript::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
        }
    };

    AuraScript* GetAuraScript() const
    {
        return new spell_q10769_dissension_amongst_the_ranks_AuraScript();
    }

    SpellScript* GetSpellScript() const
    {
        return new spell_q10769_dissension_amongst_the_ranks_SpellScript();
    };
};

enum q11520Roots
{
    GO_RAZORTHORN_DIRT_MOUNT            = 187073,
    SPELL_SUMMON_RAZORTHORN_ROOT        = 44941,
};

class spell_q11520_discovering_your_roots : public SpellScriptLoader
{
public:
    spell_q11520_discovering_your_roots() : SpellScriptLoader("spell_q11520_discovering_your_roots") { }

    class spell_q11520_discovering_your_roots_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_q11520_discovering_your_roots_SpellScript);

        void HandleDummy(SpellEffIndex /*effIndex*/)
        {
            if (GameObject* go = GetCaster()->FindNearestGameObject(GO_RAZORTHORN_DIRT_MOUNT, 20.0f))
            {
                GetCaster()->GetMotionMaster()->MovePoint(0, *go);
                go->SetLootState(GO_JUST_DEACTIVATED);
                GetCaster()->CastSpell(GetCaster(), SPELL_SUMMON_RAZORTHORN_ROOT, true);
            }
        }

        void Register()
        {
            OnEffectHitTarget += SpellEffectFn(spell_q11520_discovering_your_roots_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
        }
    };

    SpellScript* GetSpellScript() const
    {
        return new spell_q11520_discovering_your_roots_SpellScript();
    };
};

class spell_quest_dragonmaw_race_generic : public SpellScriptLoader
{
    public:
        spell_quest_dragonmaw_race_generic() : SpellScriptLoader("spell_quest_dragonmaw_race_generic") { }

        class spell_quest_dragonmaw_race_generic_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_quest_dragonmaw_race_generic_SpellScript);
            
            bool Load()
            {
                _x = _y = _z = 0.0f;
                return true;
            }

            SpellCastResult RelocateDest()
            {
                Unit* caster = GetCaster();
                float o = Position::NormalizeOrientation(caster->GetOrientation()+frand(0.0f, 2*M_PI));
                float dist = frand(5.0f, 30.0f);
                _x = caster->GetPositionX()+dist*cos(o);
                _y = caster->GetPositionY()+dist*sin(o);
                _z = caster->GetPositionZ()+frand(-10.0f, 15.0f);
                GetSpell()->m_targets.SetDst(_x, _y, _z, 0.0f, caster->GetMapId());
                return SPELL_CAST_OK;
            }

            void ChangeDest(SpellEffIndex effIndex)
            {
                PreventHitDefaultEffect(effIndex);
                Unit* caster = GetCaster();
                if (Creature* trigger = caster->SummonCreature(23356, _x, _y, _z, 0.0f, TEMPSUMMON_TIMED_DESPAWN, 1500))
                {
                    trigger->CastSpell(trigger, GetSpellInfo()->Effects[effIndex].TriggerSpell, true);
                    if (GetSpellInfo()->Effects[effIndex].TriggerSpell == 41064)
                        trigger->CastSpell(trigger, 41284, true);
                }

            }

            void Register()
            {
                OnCheckCast += SpellCheckCastFn(spell_quest_dragonmaw_race_generic_SpellScript::RelocateDest);
                OnEffectHit += SpellEffectFn(spell_quest_dragonmaw_race_generic_SpellScript::ChangeDest, EFFECT_0, SPELL_EFFECT_TRIGGER_MISSILE);
            }

        private:
            float _x, _y, _z;
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_quest_dragonmaw_race_generic_SpellScript();
        }
};

class spell_q11670_it_was_the_orcs_honest : public SpellScriptLoader
{
public:
    spell_q11670_it_was_the_orcs_honest() : SpellScriptLoader("spell_q11670_it_was_the_orcs_honest") { }

    class spell_q11670_it_was_the_orcs_honest_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_q11670_it_was_the_orcs_honest_SpellScript);

        void HandleScriptEffect()
        {
            if (GetSpellInfo()->Id != 45759)
                return;

            if (Unit* caster = GetCaster())
                caster->CastSpell(caster, caster->getGender() == GENDER_MALE ? 45760 : 45762, true);
        }

        SpellCastResult CheckTarget()
        {
            if (GetSpellInfo()->Id != 45742)
                return SPELL_CAST_OK;

            if (!GetCaster() || !GetCaster()->HasAura((GetCaster()->getGender() == GENDER_MALE ? 45760 : 45762)))
            {
                SetCustomCastResultMessage(SPELL_CUSTOM_ERROR_NEED_WARSONG_DISGUISE);
                return SPELL_FAILED_CUSTOM_ERROR;
            }

            return SPELL_CAST_OK;
        }

        void Register()
        {
            OnCheckCast += SpellCheckCastFn(spell_q11670_it_was_the_orcs_honest_SpellScript::CheckTarget);
            AfterHit += SpellHitFn(spell_q11670_it_was_the_orcs_honest_SpellScript::HandleScriptEffect);
        }
    };

    SpellScript* GetSpellScript() const
    {
        return new spell_q11670_it_was_the_orcs_honest_SpellScript();
    };
};

enum eTestFlight
{
    SPELL_CANNON_CHARGING_SELF      = 36860,
    SPELL_TELEPORT_VISUAL           = 35517,
    SPELL_CANNON_CHARGING_PORT      = 36801,
    SPELL_CANNON_CHARGING_STATE2    = 36790,
    SPELL_CANNON_CHARGING_STATE3    = 36792,
    SPELL_CANNON_CHARGING_STATE4    = 36800,
    SPELL_CANNON_CHANNEL            = 36795,
    SPELL_ZEPHYRIUM_CHARGED         = 37108,

    SPELL_SOARING_10557             = 37910,
    SPELL_SOARING_10710             = 37962,
    SPELL_SOARING_10711             = 36812,
    SPELL_SOARING_10712             = 37968,
    SPELL_SOARING_10716             = 37940,

    NPC_CANNON                      = 21393,
    NPC_CANNON_TARGET               = 21394,
    NPC_GNOME_SHOOTER               = 21413,

    QUEST_TF_ZEPHYRIUM_CAPACITORIUM = 10557,
    QUEST_TF_SINGING_RIDGE          = 10710,
    QUEST_TF_RAZAANS_LANDING        = 10711,
    QUEST_TF_RUUAN_WEALD            = 10712,
};

static Position ShooterPos[] =
{
    {1920.91f, 5579.68f, 269.23f, 1.93f},
    {1921.01f, 5585.01f, 269.23f, 4.42f},
    {1917.48f, 5583.55f, 269.23f, 5.71f},
    {1917.16f, 5581.52f, 269.23f, 0.11f},
};

class spell_quest_test_flight_charging : public SpellScriptLoader
{
public:
    spell_quest_test_flight_charging() : SpellScriptLoader("spell_quest_test_flight_charging") { }

    class spell_quest_test_flight_charging_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_quest_test_flight_charging_AuraScript)

        void OnApplySelf(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
        {
            GetTarget()->CastSpell(GetTarget(), SPELL_TELEPORT_VISUAL, true);
            GetTarget()->CastSpell(GetTarget(), SPELL_CANNON_CHARGING_PORT, true);
        }

        void PerformKick()
        {
            if (Player* player = GetTarget()->ToPlayer())
            {
                Creature* shooter = player->FindNearestCreature(NPC_GNOME_SHOOTER, 20.0f);
                if (!shooter)
                    return;

                uint8 task = 0;
                uint32 spellId = 0;
                for (; task < 4; ++task)
                    if (shooter->GetDistance(ShooterPos[task]) < 1.0f)
                        break;

                switch (task)
                {
                    case 0: spellId = SPELL_SOARING_10557; break;
                    case 1: spellId = SPELL_SOARING_10710; break;
                    case 2: spellId = SPELL_SOARING_10711; break;
                    case 3: spellId = SPELL_SOARING_10712; break;
                }

                player->RemoveAurasDueToSpell(SPELL_CANNON_CHARGING_PORT);
                shooter->CastSpell(player, spellId, true);
            }
        }

        void HandleEffectPeriodicSelf(AuraEffect const * aurEff)
        {
            if (aurEff->GetTickNumber() == 1)
            {
                GetTarget()->SummonCreature(NPC_CANNON_TARGET, 1919.99f, 5581.97f, 272.30f, 5.27f, TEMPSUMMON_TIMED_DESPAWN, 12000);
                if (Creature* cannon = GetTarget()->FindNearestCreature(NPC_CANNON, 40.0f))
                    cannon->CastSpell(cannon, SPELL_CANNON_CHANNEL, false);
            }
            if (aurEff->GetTickNumber() == 6)
                PerformKick();
        }

        void HandleEffectPeriodicPlatform(AuraEffect const * aurEff)
        {
            if (aurEff->GetTickNumber() == 1)
                GetTarget()->CastSpell(GetTarget(), SPELL_CANNON_CHARGING_STATE2, true);
            else if (aurEff->GetTickNumber() == 2)
                GetTarget()->CastSpell(GetTarget(), SPELL_CANNON_CHARGING_STATE3, true);
            else if (aurEff->GetTickNumber() == 3)
                GetTarget()->CastSpell(GetTarget(), SPELL_CANNON_CHARGING_STATE4, true);
            else if (aurEff->GetTickNumber() == 5)
                GetTarget()->CastSpell(GetTarget(), SPELL_TELEPORT_VISUAL, true);
        }

        void Register()
        {
            if (m_scriptSpellId == SPELL_CANNON_CHARGING_SELF)
            {
                OnEffectApply += AuraEffectApplyFn(spell_quest_test_flight_charging_AuraScript::OnApplySelf, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL, AURA_EFFECT_HANDLE_REAL);
                OnEffectPeriodic += AuraEffectPeriodicFn(spell_quest_test_flight_charging_AuraScript::HandleEffectPeriodicSelf, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
            }
            else
                OnEffectPeriodic += AuraEffectPeriodicFn(spell_quest_test_flight_charging_AuraScript::HandleEffectPeriodicPlatform, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
        }
    };

    AuraScript* GetAuraScript() const
    {
        return new spell_quest_test_flight_charging_AuraScript();
    }
};

enum qFallFromGrace
{
    SPELL_SCARLET_RAVEN_PRIEST_IMAGE_MALE   = 48763,
    SPELL_SCARLET_RAVEN_PRIEST_IMAGE_FEMALE = 48761
};

class spell_q12274_a_fall_from_grace_costume : public SpellScriptLoader
{
public:
    spell_q12274_a_fall_from_grace_costume() : SpellScriptLoader("spell_q12274_a_fall_from_grace_costume") {}

    class spell_q12274_a_fall_from_grace_costume_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_q12274_a_fall_from_grace_costume_SpellScript)

        bool Validate(SpellInfo const* /*SpellEntry*/)
        {
            if (!sSpellMgr->GetSpellInfo(SPELL_SCARLET_RAVEN_PRIEST_IMAGE_MALE) || !sSpellMgr->GetSpellInfo(SPELL_SCARLET_RAVEN_PRIEST_IMAGE_FEMALE))
                return false;
            return true;
        }

        void HandleScript(SpellEffIndex  /*effIndex*/)
        {            
            if(Unit* target = GetHitUnit())
            {
                if(Player* p = target->ToPlayer())
                {
                    p->CastSpell(p, p->getGender() == GENDER_FEMALE ? SPELL_SCARLET_RAVEN_PRIEST_IMAGE_FEMALE : SPELL_SCARLET_RAVEN_PRIEST_IMAGE_MALE, false);
                }
            }     
        }

        void Register()
        {
            OnEffectHitTarget += SpellEffectFn(spell_q12274_a_fall_from_grace_costume_SpellScript::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
        }
    };

    SpellScript* GetSpellScript() const
    {
        return new spell_q12274_a_fall_from_grace_costume_SpellScript();
    }
};

class spell_q13369_fate_up_against_your_will : public SpellScriptLoader
{
public:
    spell_q13369_fate_up_against_your_will() : SpellScriptLoader("spell_q13369_fate_up_against_your_will") {}

    class spell_q13369_fate_up_against_your_will_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_q13369_fate_up_against_your_will_SpellScript)

        void HandleScript(SpellEffIndex effIndex)
        {
            PreventHitDefaultEffect(effIndex);
            GetCaster()->CastSpell(GetCaster(), GetEffectValue(), true);   
        }

        SpellCastResult CheckRequirement()
        {
            // Fate, Up Against Your Will (13369)
            if (Unit* caster = GetCaster())
                if (caster->GetTypeId() == TYPEID_PLAYER && caster->ToPlayer()->GetQuestStatus(13369) >= QUEST_STATUS_COMPLETE)
                    return SPELL_CAST_OK;
            return SPELL_FAILED_DONT_REPORT;
        }

        void Register()
        {
            OnCheckCast += SpellCheckCastFn(spell_q13369_fate_up_against_your_will_SpellScript::CheckRequirement);
            OnEffectHitTarget += SpellEffectFn(spell_q13369_fate_up_against_your_will_SpellScript::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
        }
    };

    SpellScript* GetSpellScript() const
    {
        return new spell_q13369_fate_up_against_your_will_SpellScript();
    }
};

class spell_q11198_take_down_tethyr : public SpellScriptLoader
{
public:
    spell_q11198_take_down_tethyr() : SpellScriptLoader("spell_q11198_take_down_tethyr") {}

    class spell_q11198_take_down_tethyr_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_q11198_take_down_tethyr_SpellScript)

        void HandleScript(SpellEffIndex effIndex)
        {
            PreventHitDefaultEffect(effIndex);
            if (Unit* unit = GetHitUnit())
                if (unit->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_PC))
                    return;
            GetCaster()->CastCustomSpell(42576 /*SPELL_CANNON_BLAST*/, SPELLVALUE_BASE_POINT0, GetEffectValue(), GetCaster(), true);   
        }

        void Register()
        {
            OnEffectHitTarget += SpellEffectFn(spell_q11198_take_down_tethyr_SpellScript::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
        }
    };

    SpellScript* GetSpellScript() const
    {
        return new spell_q11198_take_down_tethyr_SpellScript();
    }
};

class spell_q11653_youre_not_so_big_now : public SpellScriptLoader
{
public:
    spell_q11653_youre_not_so_big_now() : SpellScriptLoader("spell_q11653_youre_not_so_big_now") {}

    class spell_q11653_youre_not_so_big_now_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_q11653_youre_not_so_big_now_SpellScript)

        void HandleScript(SpellEffIndex effIndex)
        {
            PreventHitDefaultEffect(effIndex);
            Unit* target = GetHitUnit();
            if (!target || target->GetTypeId() != TYPEID_UNIT)
                return;

            static uint32 const spellPlayer[5] =
            {
                45674,                            // Bigger!
                45675,                            // Shrunk
                45678,                            // Yellow
                45682,                            // Ghost
                45684                             // Polymorph
            };

            static uint32 const spellTarget[5] =
            {
                45673,                            // Bigger!
                45672,                            // Shrunk
                45677,                            // Yellow
                45681,                            // Ghost
                45673                             // Polymorph
            };

            if (roll_chance_i(30))
                GetCaster()->CastSpell(GetCaster(), spellPlayer[urand(0, 4)], true);
            else
                target->CastSpell(target, spellTarget[urand(0, 4)], true);
        }

        void Register()
        {
            OnEffectHitTarget += SpellEffectFn(spell_q11653_youre_not_so_big_now_SpellScript::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
        }
    };

    SpellScript* GetSpellScript() const
    {
        return new spell_q11653_youre_not_so_big_now_SpellScript();
    }
};

class spell_q10985_light_of_the_naaru : public SpellScriptLoader
{
    public:
        spell_q10985_light_of_the_naaru() : SpellScriptLoader("spell_q10985_light_of_the_naaru") { }

        class spell_q10985_light_of_the_naaru_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_q10985_light_of_the_naaru_AuraScript);

            bool CheckProc(ProcEventInfo& eventInfo)
            {
                Unit* target = eventInfo.GetActionTarget();
                return target && target->getFaction() == 1843; // Xinef: Illidari demons faction
            }

            void Register()
            {
                DoCheckProc += AuraCheckProcFn(spell_q10985_light_of_the_naaru_AuraScript::CheckProc);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_q10985_light_of_the_naaru_AuraScript();
        }
};


// Theirs
class spell_generic_quest_update_entry_SpellScript : public SpellScript
{
    PrepareSpellScript(spell_generic_quest_update_entry_SpellScript);
    private:
        uint16 _spellEffect;
        uint8 _effIndex;
        uint32 _originalEntry;
        uint32 _newEntry;
        bool _shouldAttack;
        uint32 _despawnTime;

    public:
        spell_generic_quest_update_entry_SpellScript(uint16 spellEffect, uint8 effIndex, uint32 originalEntry, uint32 newEntry, bool shouldAttack, uint32 despawnTime = 0) :
            SpellScript(), _spellEffect(spellEffect), _effIndex(effIndex), _originalEntry(originalEntry),
            _newEntry(newEntry), _shouldAttack(shouldAttack), _despawnTime(despawnTime) { }

        void HandleDummy(SpellEffIndex /*effIndex*/)
        {
            if (Creature* creatureTarget = GetHitCreature())
                if (!creatureTarget->IsPet() && creatureTarget->GetEntry() == _originalEntry)
                {
                    creatureTarget->UpdateEntry(_newEntry);
                    if (_shouldAttack && creatureTarget->IsAIEnabled)
                        creatureTarget->AI()->AttackStart(GetCaster());

                    if (_despawnTime)
                        creatureTarget->DespawnOrUnsummon(_despawnTime);
                }
        }

        void Register()
        {
            OnEffectHitTarget += SpellEffectFn(spell_generic_quest_update_entry_SpellScript::HandleDummy, _effIndex, _spellEffect);
        }
};

// http://www.wowhead.com/quest=55 Morbent Fel
// 8913 Sacred Cleansing
enum Quest55Data
{
    NPC_MORBENT             = 1200,
    NPC_WEAKENED_MORBENT    = 24782,
};

class spell_q55_sacred_cleansing : public SpellScriptLoader
{
    public:
        spell_q55_sacred_cleansing() : SpellScriptLoader("spell_q55_sacred_cleansing") { }

        SpellScript* GetSpellScript() const
        {
            return new spell_generic_quest_update_entry_SpellScript(SPELL_EFFECT_DUMMY, EFFECT_1, NPC_MORBENT, NPC_WEAKENED_MORBENT, true);
        }
};

// 9712 - Thaumaturgy Channel
enum ThaumaturgyChannel
{
    SPELL_THAUMATURGY_CHANNEL = 21029
};

class spell_q2203_thaumaturgy_channel : public SpellScriptLoader
{
    public:
        spell_q2203_thaumaturgy_channel() : SpellScriptLoader("spell_q2203_thaumaturgy_channel") { }

        class spell_q2203_thaumaturgy_channel_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_q2203_thaumaturgy_channel_AuraScript);

            bool Validate(SpellInfo const* /*spellInfo*/)
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_THAUMATURGY_CHANNEL))
                    return false;
                return true;
            }

            void HandleEffectPeriodic(AuraEffect const* /*aurEff*/)
            {
                PreventDefaultAction();
                if (Unit* caster = GetCaster())
                    caster->CastSpell(caster, SPELL_THAUMATURGY_CHANNEL, false);
            }

            void Register()
            {
                OnEffectPeriodic += AuraEffectPeriodicFn(spell_q2203_thaumaturgy_channel_AuraScript::HandleEffectPeriodic, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_q2203_thaumaturgy_channel_AuraScript();
        }
};

// http://www.wowhead.com/quest=5206 Marauders of Darrowshire
// 17271 Test Fetid Skull
enum Quest5206Data
{
    SPELL_CREATE_RESONATING_SKULL = 17269,
    SPELL_CREATE_BONE_DUST = 17270
};

class spell_q5206_test_fetid_skull : public SpellScriptLoader
{
    public:
        spell_q5206_test_fetid_skull() : SpellScriptLoader("spell_q5206_test_fetid_skull") { }

        class spell_q5206_test_fetid_skull_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_q5206_test_fetid_skull_SpellScript);

            bool Load()
            {
                return GetCaster()->GetTypeId() == TYPEID_PLAYER;
            }

            bool Validate(SpellInfo const* /*spellEntry*/)
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_CREATE_RESONATING_SKULL) || !sSpellMgr->GetSpellInfo(SPELL_CREATE_BONE_DUST))
                    return false;
                return true;
            }

            void HandleDummy(SpellEffIndex /*effIndex*/)
            {
                Unit* caster = GetCaster();
                uint32 spellId = roll_chance_i(50) ? SPELL_CREATE_RESONATING_SKULL : SPELL_CREATE_BONE_DUST;
                caster->CastSpell(caster, spellId, true, NULL);
            }

            void Register()
            {
                OnEffectHit += SpellEffectFn(spell_q5206_test_fetid_skull_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_q5206_test_fetid_skull_SpellScript();
        }
};

// http://www.wowhead.com/quest=6124 Curing the Sick (A)
// http://www.wowhead.com/quest=6129 Curing the Sick (H)
// 19512 Apply Salve
enum Quests6124_6129Data
{
    NPC_SICKLY_GAZELLE  = 12296,
    NPC_CURED_GAZELLE   = 12297,
    NPC_SICKLY_DEER     = 12298,
    NPC_CURED_DEER      = 12299,
    DESPAWN_TIME        = 30000
};

class spell_q6124_6129_apply_salve : public SpellScriptLoader
{
    public:
        spell_q6124_6129_apply_salve() : SpellScriptLoader("spell_q6124_6129_apply_salve") { }

        class spell_q6124_6129_apply_salve_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_q6124_6129_apply_salve_SpellScript);

            bool Load()
            {
                return GetCaster()->GetTypeId() == TYPEID_PLAYER;
            }

            void HandleDummy(SpellEffIndex /*effIndex*/)
            {
                Player* caster = GetCaster()->ToPlayer();
                if (GetCastItem())
                    if (Creature* creatureTarget = GetHitCreature())
                    {
                        uint32 newEntry = 0;
                        switch (caster->GetTeamId())
                        {
                            case TEAM_HORDE:
                                if (creatureTarget->GetEntry() == NPC_SICKLY_GAZELLE)
                                    newEntry = NPC_CURED_GAZELLE;
                                break;
                            case TEAM_ALLIANCE:
                                if (creatureTarget->GetEntry() == NPC_SICKLY_DEER)
                                    newEntry = NPC_CURED_DEER;
                                break;
                            default:
                                break;
                        }
                        if (newEntry)
                        {
                            creatureTarget->UpdateEntry(newEntry);
                            creatureTarget->DespawnOrUnsummon(DESPAWN_TIME);
                            caster->KilledMonsterCredit(newEntry, 0);
                        }
                    }
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_q6124_6129_apply_salve_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_q6124_6129_apply_salve_SpellScript();
        }
};

// http://www.wowhead.com/quest=11396 Bring Down Those Shields (A)
// http://www.wowhead.com/quest=11399 Bring Down Those Shields (H)
enum Quest11396_11399Data
{
    SPELL_FORCE_SHIELD_ARCANE_PURPLE_X3 = 43874,
    SPELL_SCOURGING_CRYSTAL_CONTROLLER = 43878
};

// 43874 Scourge Mur'gul Camp: Force Shield Arcane Purple x3
class spell_q11396_11399_force_shield_arcane_purple_x3 : public SpellScriptLoader
{
    public:
        spell_q11396_11399_force_shield_arcane_purple_x3() : SpellScriptLoader("spell_q11396_11399_force_shield_arcane_purple_x3") { }

        class spell_q11396_11399_force_shield_arcane_purple_x3_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_q11396_11399_force_shield_arcane_purple_x3_AuraScript);

            void HandleEffectApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
            {
                Unit* target = GetTarget();
            target->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_PC);
            target->SetControlled(true, UNIT_STATE_STUNNED);
            }

            void HandleEffectRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
            {
            GetTarget()->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_PC);
            }

            void Register()
            {
                OnEffectApply += AuraEffectApplyFn(spell_q11396_11399_force_shield_arcane_purple_x3_AuraScript::HandleEffectApply, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
                OnEffectRemove += AuraEffectRemoveFn(spell_q11396_11399_force_shield_arcane_purple_x3_AuraScript::HandleEffectRemove, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
            }

        };

        AuraScript* GetAuraScript() const
        {
            return new spell_q11396_11399_force_shield_arcane_purple_x3_AuraScript();
        }
};

// 50133 Scourging Crystal Controller
class spell_q11396_11399_scourging_crystal_controller : public SpellScriptLoader
{
    public:
        spell_q11396_11399_scourging_crystal_controller() : SpellScriptLoader("spell_q11396_11399_scourging_crystal_controller") { }

        class spell_q11396_11399_scourging_crystal_controller_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_q11396_11399_scourging_crystal_controller_SpellScript);

            bool Validate(SpellInfo const* /*spellEntry*/)
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_FORCE_SHIELD_ARCANE_PURPLE_X3) || !sSpellMgr->GetSpellInfo(SPELL_SCOURGING_CRYSTAL_CONTROLLER))
                    return false;
                return true;
            }

            void HandleDummy(SpellEffIndex /*effIndex*/)
            {
                if (Creature* target = GetHitCreature())
                    if (target->HasAura(SPELL_FORCE_SHIELD_ARCANE_PURPLE_X3))
                        // Make sure nobody else is channeling the same target
                        if (!target->HasAura(SPELL_SCOURGING_CRYSTAL_CONTROLLER))
                            GetCaster()->CastSpell(target, SPELL_SCOURGING_CRYSTAL_CONTROLLER, true, GetCastItem());
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_q11396_11399_scourging_crystal_controller_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_q11396_11399_scourging_crystal_controller_SpellScript();
        };
};

// 43882 Scourging Crystal Controller Dummy
class spell_q11396_11399_scourging_crystal_controller_dummy : public SpellScriptLoader
{
    public:
        spell_q11396_11399_scourging_crystal_controller_dummy() : SpellScriptLoader("spell_q11396_11399_scourging_crystal_controller_dummy") { }

        class spell_q11396_11399_scourging_crystal_controller_dummy_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_q11396_11399_scourging_crystal_controller_dummy_SpellScript);

            bool Validate(SpellInfo const* /*spellEntry*/)
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_FORCE_SHIELD_ARCANE_PURPLE_X3))
                    return false;
                return true;
            }

            void HandleDummy(SpellEffIndex /*effIndex*/)
            {
                if (Unit* target = GetHitUnit())
                    if (target->GetTypeId() == TYPEID_UNIT)
                        target->RemoveAurasDueToSpell(SPELL_FORCE_SHIELD_ARCANE_PURPLE_X3);
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_q11396_11399_scourging_crystal_controller_dummy_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_q11396_11399_scourging_crystal_controller_dummy_SpellScript();
        };
};

// http://www.wowhead.com/quest=11515 Blood for Blood
// 44936 Quest - Fel Siphon Dummy
enum Quest11515Data
{
    NPC_FELBLOOD_INITIATE   = 24918,
    NPC_EMACIATED_FELBLOOD  = 24955
};

class spell_q11515_fel_siphon_dummy : public SpellScriptLoader
{
    public:
        spell_q11515_fel_siphon_dummy() : SpellScriptLoader("spell_q11515_fel_siphon_dummy") { }

        SpellScript* GetSpellScript() const
        {
            return new spell_generic_quest_update_entry_SpellScript(SPELL_EFFECT_DUMMY, EFFECT_0, NPC_FELBLOOD_INITIATE, NPC_EMACIATED_FELBLOOD, true);
        }
};

// http://www.wowhead.com/quest=11587 Prison Break
// 45449 Arcane Prisoner Rescue
enum Quest11587Data
{
    SPELL_SUMMON_ARCANE_PRISONER_MALE    = 45446,    // Summon Arcane Prisoner - Male
    SPELL_SUMMON_ARCANE_PRISONER_FEMALE  = 45448,    // Summon Arcane Prisoner - Female
    SPELL_ARCANE_PRISONER_KILL_CREDIT    = 45456     // Arcane Prisoner Kill Credit
};

class spell_q11587_arcane_prisoner_rescue : public SpellScriptLoader
{
    public:
        spell_q11587_arcane_prisoner_rescue() : SpellScriptLoader("spell_q11587_arcane_prisoner_rescue") { }

        class spell_q11587_arcane_prisoner_rescue_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_q11587_arcane_prisoner_rescue_SpellScript);

            bool Validate(SpellInfo const* /*spellEntry*/)
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_SUMMON_ARCANE_PRISONER_MALE) || !sSpellMgr->GetSpellInfo(SPELL_SUMMON_ARCANE_PRISONER_FEMALE) || !sSpellMgr->GetSpellInfo(SPELL_ARCANE_PRISONER_KILL_CREDIT))
                    return false;
                return true;
            }

            void HandleDummy(SpellEffIndex /*effIndex*/)
            {
                Unit* caster = GetCaster();
                if (Unit* unitTarget = GetHitUnit())
                {
                    uint32 spellId = SPELL_SUMMON_ARCANE_PRISONER_MALE;
                    if (rand() % 2)
                        spellId = SPELL_SUMMON_ARCANE_PRISONER_FEMALE;
                    caster->CastSpell(caster, spellId, true);
                    unitTarget->CastSpell(caster, SPELL_ARCANE_PRISONER_KILL_CREDIT, true);
                }
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_q11587_arcane_prisoner_rescue_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_q11587_arcane_prisoner_rescue_SpellScript();
        }
};

// http://www.wowhead.com/quest=11730 Master and Servant
// 46023 The Ultrasonic Screwdriver
enum Quest11730Data
{
    SPELL_SUMMON_SCAVENGEBOT_004A8  = 46063,
    SPELL_SUMMON_SENTRYBOT_57K      = 46068,
    SPELL_SUMMON_DEFENDOTANK_66D    = 46058,
    SPELL_SUMMON_SCAVENGEBOT_005B6  = 46066,
    SPELL_SUMMON_55D_COLLECTATRON   = 46034,
    SPELL_ROBOT_KILL_CREDIT         = 46027,
    NPC_SCAVENGEBOT_004A8           = 25752,
    NPC_SENTRYBOT_57K               = 25753,
    NPC_DEFENDOTANK_66D             = 25758,
    NPC_SCAVENGEBOT_005B6           = 25792,
    NPC_55D_COLLECTATRON            = 25793
};

class spell_q11730_ultrasonic_screwdriver : public SpellScriptLoader
{
    public:
        spell_q11730_ultrasonic_screwdriver() : SpellScriptLoader("spell_q11730_ultrasonic_screwdriver") { }

        class spell_q11730_ultrasonic_screwdriver_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_q11730_ultrasonic_screwdriver_SpellScript);

            bool Load()
            {
                return GetCaster()->GetTypeId() == TYPEID_PLAYER && GetCastItem();
            }

            bool Validate(SpellInfo const* /*spellEntry*/)
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_SUMMON_SCAVENGEBOT_004A8) || !sSpellMgr->GetSpellInfo(SPELL_SUMMON_SENTRYBOT_57K) || !sSpellMgr->GetSpellInfo(SPELL_SUMMON_DEFENDOTANK_66D) || !sSpellMgr->GetSpellInfo(SPELL_SUMMON_SCAVENGEBOT_005B6) || !sSpellMgr->GetSpellInfo(SPELL_SUMMON_55D_COLLECTATRON) || !sSpellMgr->GetSpellInfo(SPELL_ROBOT_KILL_CREDIT))
                    return false;
                return true;
            }

            void HandleDummy(SpellEffIndex /*effIndex*/)
            {
                Item* castItem = GetCastItem();
                Unit* caster = GetCaster();
                if (Creature* target = GetHitCreature())
                {
                    uint32 spellId = 0;
                    switch (target->GetEntry())
                    {
                        case NPC_SCAVENGEBOT_004A8: spellId = SPELL_SUMMON_SCAVENGEBOT_004A8;    break;
                        case NPC_SENTRYBOT_57K:     spellId = SPELL_SUMMON_SENTRYBOT_57K;        break;
                        case NPC_DEFENDOTANK_66D:   spellId = SPELL_SUMMON_DEFENDOTANK_66D;      break;
                        case NPC_SCAVENGEBOT_005B6: spellId = SPELL_SUMMON_SCAVENGEBOT_005B6;    break;
                        case NPC_55D_COLLECTATRON:  spellId = SPELL_SUMMON_55D_COLLECTATRON;     break;
                        default:
                            return;
                    }
                    caster->CastSpell(caster, spellId, true, castItem);
                    caster->CastSpell(caster, SPELL_ROBOT_KILL_CREDIT, true);
                    target->DespawnOrUnsummon();
                }
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_q11730_ultrasonic_screwdriver_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_q11730_ultrasonic_screwdriver_SpellScript();
        }
};

// http://www.wowhead.com/quest=12459 That Which Creates Can Also Destroy
// 49587 Seeds of Nature's Wrath
enum Quest12459Data
{
    NPC_REANIMATED_FROSTWYRM        = 26841,
    NPC_WEAK_REANIMATED_FROSTWYRM   = 27821,

    NPC_TURGID                      = 27808,
    NPC_WEAK_TURGID                 = 27809,

    NPC_DEATHGAZE                   = 27122,
    NPC_WEAK_DEATHGAZE              = 27807,
};

class spell_q12459_seeds_of_natures_wrath : public SpellScriptLoader
{
    public:
        spell_q12459_seeds_of_natures_wrath() : SpellScriptLoader("spell_q12459_seeds_of_natures_wrath") { }

        class spell_q12459_seeds_of_natures_wrath_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_q12459_seeds_of_natures_wrath_SpellScript);

            void HandleDummy(SpellEffIndex /*effIndex*/)
            {
                if (Creature* creatureTarget = GetHitCreature())
                {
                    uint32 uiNewEntry = 0;
                    switch (creatureTarget->GetEntry())
                    {
                        case NPC_REANIMATED_FROSTWYRM:  uiNewEntry = NPC_WEAK_REANIMATED_FROSTWYRM; break;
                        case NPC_TURGID:                uiNewEntry = NPC_WEAK_TURGID;               break;
                        case NPC_DEATHGAZE:             uiNewEntry = NPC_WEAK_DEATHGAZE;            break;
                    }
                    if (uiNewEntry)
                        creatureTarget->UpdateEntry(uiNewEntry);
                }
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_q12459_seeds_of_natures_wrath_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_q12459_seeds_of_natures_wrath_SpellScript();
        }
};

// http://www.wowhead.com/quest=12634 Some Make Lemonade, Some Make Liquor
// 51840 Despawn Fruit Tosser
enum Quest12634Data
{
    SPELL_BANANAS_FALL_TO_GROUND    = 51836,
    SPELL_ORANGE_FALLS_TO_GROUND    = 51837,
    SPELL_PAPAYA_FALLS_TO_GROUND    = 51839,
    SPELL_SUMMON_ADVENTUROUS_DWARF  = 52070
};

class spell_q12634_despawn_fruit_tosser : public SpellScriptLoader
{
    public:
        spell_q12634_despawn_fruit_tosser() : SpellScriptLoader("spell_q12634_despawn_fruit_tosser") { }

        class spell_q12634_despawn_fruit_tosser_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_q12634_despawn_fruit_tosser_SpellScript);

            bool Validate(SpellInfo const* /*spellEntry*/)
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_BANANAS_FALL_TO_GROUND) || !sSpellMgr->GetSpellInfo(SPELL_ORANGE_FALLS_TO_GROUND) || !sSpellMgr->GetSpellInfo(SPELL_PAPAYA_FALLS_TO_GROUND) || !sSpellMgr->GetSpellInfo(SPELL_SUMMON_ADVENTUROUS_DWARF))
                    return false;
                return true;
            }

            void HandleDummy(SpellEffIndex /*effIndex*/)
            {
                uint32 spellId = SPELL_BANANAS_FALL_TO_GROUND;
                switch (urand(0, 3))
                {
                    case 1: spellId = SPELL_ORANGE_FALLS_TO_GROUND; break;
                    case 2: spellId = SPELL_PAPAYA_FALLS_TO_GROUND; break;
                }
                // sometimes, if you're lucky, you get a dwarf
                if (roll_chance_i(5))
                    spellId = SPELL_SUMMON_ADVENTUROUS_DWARF;
                GetCaster()->CastSpell(GetCaster(), spellId, true, NULL);
            }

            void Register()
            {
                OnEffectHit += SpellEffectFn(spell_q12634_despawn_fruit_tosser_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_q12634_despawn_fruit_tosser_SpellScript();
        }
};

// http://www.wowhead.com/quest=12683 Burning to Help
// 52308 Take Sputum Sample
class spell_q12683_take_sputum_sample : public SpellScriptLoader
{
    public:
        spell_q12683_take_sputum_sample() : SpellScriptLoader("spell_q12683_take_sputum_sample") { }

        class spell_q12683_take_sputum_sample_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_q12683_take_sputum_sample_SpellScript);

            void HandleDummy(SpellEffIndex /*effIndex*/)
            {
                uint32 reqAuraId = GetSpellInfo()->Effects[EFFECT_1].CalcValue();

                Unit* caster = GetCaster();
                if (caster->HasAuraEffect(reqAuraId, 0))
                {
                    uint32 spellId = GetSpellInfo()->Effects[EFFECT_0].CalcValue();
                    caster->CastSpell(caster, spellId, true, NULL);
                }
            }

            void Register()
            {
                OnEffectHit += SpellEffectFn(spell_q12683_take_sputum_sample_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_q12683_take_sputum_sample_SpellScript();
        }
};

// http://www.wowhead.com/quest=12851 Going Bearback
// 54798 FLAMING Arrow Triggered Effect
enum Quest12851Data
{
    NPC_FROSTGIANT = 29351,
    NPC_FROSTWORG  = 29358,
    SPELL_FROSTGIANT_CREDIT = 58184,
    SPELL_FROSTWORG_CREDIT  = 58183,
    SPELL_IMMOLATION        = 54690,
    SPELL_ABLAZE            = 54683,
};

class spell_q12851_going_bearback : public SpellScriptLoader
{
    public:
        spell_q12851_going_bearback() : SpellScriptLoader("spell_q12851_going_bearback") { }

        class spell_q12851_going_bearback_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_q12851_going_bearback_AuraScript);

            void HandleEffectApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
            {
                if (Unit* caster = GetCaster())
                {
                    Unit* target = GetTarget();
                    // Already in fire
                    if (target->HasAura(SPELL_ABLAZE))
                        return;

                    if (Player* player = caster->GetCharmerOrOwnerPlayerOrPlayerItself())
                    {
                        switch (target->GetEntry())
                        {
                            case NPC_FROSTWORG:
                                target->CastSpell(player, SPELL_FROSTWORG_CREDIT, true);
                                target->CastSpell(target, SPELL_IMMOLATION, true);
                                target->CastSpell(target, SPELL_ABLAZE, true);
                                break;
                            case NPC_FROSTGIANT:
                                target->CastSpell(player, SPELL_FROSTGIANT_CREDIT, true);
                                target->CastSpell(target, SPELL_IMMOLATION, true);
                                target->CastSpell(target, SPELL_ABLAZE, true);
                                break;
                        }
                    }
                }
            }

            void Register()
            {
                AfterEffectApply += AuraEffectApplyFn(spell_q12851_going_bearback_AuraScript::HandleEffectApply, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY, AURA_EFFECT_HANDLE_REAL_OR_REAPPLY_MASK);
            }

        };

        AuraScript* GetAuraScript() const
        {
            return new spell_q12851_going_bearback_AuraScript();
        }
};

// http://www.wowhead.com/quest=12937 Relief for the Fallen
// 55804 Healing Finished
enum Quest12937Data
{
    SPELL_TRIGGER_AID_OF_THE_EARTHEN    = 55809,
    NPC_FALLEN_EARTHEN_DEFENDER         = 30035,
};

class spell_q12937_relief_for_the_fallen : public SpellScriptLoader
{
    public:
        spell_q12937_relief_for_the_fallen() : SpellScriptLoader("spell_q12937_relief_for_the_fallen") { }

        class spell_q12937_relief_for_the_fallen_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_q12937_relief_for_the_fallen_SpellScript);

            bool Load()
            {
                return GetCaster()->GetTypeId() == TYPEID_PLAYER;
            }

            bool Validate(SpellInfo const* /*spellEntry*/)
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_TRIGGER_AID_OF_THE_EARTHEN))
                    return false;
                return true;
            }

            void HandleDummy(SpellEffIndex /*effIndex*/)
            {
                Player* caster = GetCaster()->ToPlayer();
                if (Creature* target = GetHitCreature())
                {
                    caster->CastSpell(caster, SPELL_TRIGGER_AID_OF_THE_EARTHEN, true, NULL);
                    caster->KilledMonsterCredit(NPC_FALLEN_EARTHEN_DEFENDER, 0);
                    target->DespawnOrUnsummon();
                }
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_q12937_relief_for_the_fallen_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_q12937_relief_for_the_fallen_SpellScript();
        }
};

enum Whoarethey
{
    SPELL_MALE_DISGUISE = 38080,
    SPELL_FEMALE_DISGUISE = 38081,
    SPELL_GENERIC_DISGUISE = 32756
};

class spell_q10041_q10040_who_are_they : public SpellScriptLoader
{
    public:
        spell_q10041_q10040_who_are_they() : SpellScriptLoader("spell_q10041_q10040_who_are_they") { }

        class spell_q10041_q10040_who_are_they_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_q10041_q10040_who_are_they_SpellScript);

            bool Validate(SpellInfo const* /*spellEntry*/)
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_MALE_DISGUISE) || !sSpellMgr->GetSpellInfo(SPELL_FEMALE_DISGUISE) || !sSpellMgr->GetSpellInfo(SPELL_GENERIC_DISGUISE))
                    return false;
                return true;
            }

            void HandleScript(SpellEffIndex effIndex)
            {
                PreventHitDefaultEffect(effIndex);
                if (Player* target = GetHitPlayer())
                {
                    target->CastSpell(target, target->getGender() == GENDER_MALE ? SPELL_MALE_DISGUISE : SPELL_FEMALE_DISGUISE, true);
                    target->CastSpell(target, SPELL_GENERIC_DISGUISE, true);
                }
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_q10041_q10040_who_are_they_SpellScript::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_q10041_q10040_who_are_they_SpellScript();
        }
};

enum symboloflife
{
    SPELL_PERMANENT_FEIGN_DEATH = 29266,
};

// 8593 Symbol of life dummy
class spell_symbol_of_life_dummy : public SpellScriptLoader
{
    public:
        spell_symbol_of_life_dummy() : SpellScriptLoader("spell_symbol_of_life_dummy") { }

        class spell_symbol_of_life_dummy_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_symbol_of_life_dummy_SpellScript);

            void HandleDummy(SpellEffIndex /*effIndex*/)
            {
                if (Creature* target = GetHitCreature())
                {
                    if (target->HasAura(SPELL_PERMANENT_FEIGN_DEATH))
                    {
                        target->RemoveAurasDueToSpell(SPELL_PERMANENT_FEIGN_DEATH);
                        target->SetUInt32Value(UNIT_DYNAMIC_FLAGS, 0);
                        target->SetUInt32Value(UNIT_FIELD_FLAGS_2, 0);
                        target->SetHealth(target->GetMaxHealth() / 2);
                        target->SetPower(POWER_MANA, uint32(target->GetMaxPower(POWER_MANA) * 0.75f));
                    }
                }
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_symbol_of_life_dummy_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_symbol_of_life_dummy_SpellScript();
        };
};

// http://www.wowhead.com/quest=12659 Scalps!
// 52090 Ahunae's Knife
enum Quest12659Data
{
    NPC_SCALPS_KC_BUNNY = 28622,
};

class spell_q12659_ahunaes_knife : public SpellScriptLoader
{
    public:
        spell_q12659_ahunaes_knife() : SpellScriptLoader("spell_q12659_ahunaes_knife") { }

        class spell_q12659_ahunaes_knife_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_q12659_ahunaes_knife_SpellScript);

            bool Load()
            {
                return GetCaster()->GetTypeId() == TYPEID_PLAYER;
            }

            void HandleDummy(SpellEffIndex /*effIndex*/)
            {
                Player* caster = GetCaster()->ToPlayer();
                if (Creature* target = GetHitCreature())
                {
                    target->DespawnOrUnsummon();
                    caster->KilledMonsterCredit(NPC_SCALPS_KC_BUNNY, 0);
                }
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_q12659_ahunaes_knife_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_q12659_ahunaes_knife_SpellScript();
        };
};

enum StoppingTheSpread
{
    NPC_VILLAGER_KILL_CREDIT                     = 18240,
    SPELL_FLAMES                                 = 39199,
};

class spell_q9874_liquid_fire : public SpellScriptLoader
{
    public:
        spell_q9874_liquid_fire() : SpellScriptLoader("spell_q9874_liquid_fire")
        {
        }

        class spell_q9874_liquid_fire_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_q9874_liquid_fire_SpellScript);

            bool Load()
            {
                return GetCaster()->GetTypeId() == TYPEID_PLAYER;
            }

            void HandleDummy(SpellEffIndex /*effIndex*/)
            {
                Player* caster = GetCaster()->ToPlayer();
                if (Creature* target = GetHitCreature())
                    if (target && !target->HasAura(SPELL_FLAMES))
                    {
                        caster->KilledMonsterCredit(NPC_VILLAGER_KILL_CREDIT, 0);
                        target->CastSpell(target, SPELL_FLAMES, true);
                        target->DespawnOrUnsummon(20000);
                    }
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_q9874_liquid_fire_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_q9874_liquid_fire_SpellScript();
        };
};

enum SalvagingLifesStength
{
    NPC_SHARD_KILL_CREDIT                        = 29303,
};

class spell_q12805_lifeblood_dummy : public SpellScriptLoader
{
    public:
        spell_q12805_lifeblood_dummy() : SpellScriptLoader("spell_q12805_lifeblood_dummy")
        {
        }

        class spell_q12805_lifeblood_dummy_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_q12805_lifeblood_dummy_SpellScript);

            bool Load()
            {
                return GetCaster()->GetTypeId() == TYPEID_PLAYER;
            }

            void HandleScript(SpellEffIndex /*effIndex*/)
            {
                Player* caster = GetCaster()->ToPlayer();
                if (Creature* target = GetHitCreature())
                {
                    caster->KilledMonsterCredit(NPC_SHARD_KILL_CREDIT, 0);
                    target->CastSpell(target, uint32(GetEffectValue()), true);
                    target->DespawnOrUnsummon(2000);
                }
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_q12805_lifeblood_dummy_SpellScript::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_q12805_lifeblood_dummy_SpellScript();
        };
};

/*
 http://www.wowhead.com/quest=13283 King of the Mountain
 http://www.wowhead.com/quest=13280 King of the Mountain
 59643 Plant Horde Battle Standard
 4338 Plant Alliance Battle Standard
 */
enum BattleStandard
{
    NPC_KING_OF_THE_MOUNTAINT_KC                    = 31766,
};

class spell_q13280_13283_plant_battle_standard: public SpellScriptLoader
{
    public:
        spell_q13280_13283_plant_battle_standard() : SpellScriptLoader("spell_q13280_13283_plant_battle_standard") { }

        class spell_q13280_13283_plant_battle_standard_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_q13280_13283_plant_battle_standard_SpellScript);

            void HandleDummy(SpellEffIndex /*effIndex*/)
            {
                Unit* caster = GetCaster();
                if (caster->IsVehicle())
                    if (Unit* player = caster->GetVehicleKit()->GetPassenger(0))
                         player->ToPlayer()->KilledMonsterCredit(NPC_KING_OF_THE_MOUNTAINT_KC, 0);
            }

            void Register()
            {
                OnEffectHit += SpellEffectFn(spell_q13280_13283_plant_battle_standard_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_q13280_13283_plant_battle_standard_SpellScript();
        }
};

enum ChumTheWaterSummons
{
    SUMMON_ANGRY_KVALDIR = 66737,
    SUMMON_NORTH_SEA_MAKO = 66738,
    SUMMON_NORTH_SEA_THRESHER = 66739,
    SUMMON_NORTH_SEA_BLUE_SHARK = 66740
};

class spell_q14112_14145_chum_the_water: public SpellScriptLoader
{
    public:
        spell_q14112_14145_chum_the_water() : SpellScriptLoader("spell_q14112_14145_chum_the_water") { }

        class spell_q14112_14145_chum_the_water_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_q14112_14145_chum_the_water_SpellScript);

            bool Validate(SpellInfo const* /*spellEntry*/)
            {
                if (!sSpellMgr->GetSpellInfo(SUMMON_ANGRY_KVALDIR) || !sSpellMgr->GetSpellInfo(SUMMON_NORTH_SEA_MAKO) || !sSpellMgr->GetSpellInfo(SUMMON_NORTH_SEA_THRESHER) || !sSpellMgr->GetSpellInfo(SUMMON_NORTH_SEA_BLUE_SHARK))
                    return false;
                return true;
            }

            void HandleScriptEffect(SpellEffIndex /*effIndex*/)
            {
                Unit* caster = GetCaster();
                caster->CastSpell(caster, RAND(SUMMON_ANGRY_KVALDIR, SUMMON_NORTH_SEA_MAKO, SUMMON_NORTH_SEA_THRESHER, SUMMON_NORTH_SEA_BLUE_SHARK));
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_q14112_14145_chum_the_water_SpellScript::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_q14112_14145_chum_the_water_SpellScript();
        }
};

// http://old01.wowhead.com/quest=9452 - Red Snapper - Very Tasty!
enum RedSnapperVeryTasty
{
    ITEM_RED_SNAPPER             = 23614,

    SPELL_CAST_NET               = 29866,
    SPELL_NEW_SUMMON_TEST        = 49214,

    GO_SCHOOL_OF_RED_SNAPPER     = 181616
};

class spell_q9452_cast_net: public SpellScriptLoader
{
    public:
        spell_q9452_cast_net() : SpellScriptLoader("spell_q9452_cast_net") { }

        class spell_q9452_cast_net_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_q9452_cast_net_SpellScript);

            bool Load()
            {
                return GetCaster()->GetTypeId() == TYPEID_PLAYER;
            }

            SpellCastResult CheckCast()
            {
                GameObject* go = GetCaster()->FindNearestGameObject(GO_SCHOOL_OF_RED_SNAPPER, 3.0f);
                if (!go || go->GetRespawnTime())
                    return SPELL_FAILED_REQUIRES_SPELL_FOCUS;

                return SPELL_CAST_OK;
            }

            void HandleDummy(SpellEffIndex /*effIndex*/)
            {
                Player* caster = GetCaster()->ToPlayer();
                if (roll_chance_i(66))
                    caster->AddItem(ITEM_RED_SNAPPER, 1);
                else
                    caster->CastSpell(caster, SPELL_NEW_SUMMON_TEST, true);
            }

            void HandleActiveObject(SpellEffIndex effIndex)
            {
                PreventHitDefaultEffect(effIndex);
                GetHitGObj()->SetRespawnTime(roll_chance_i(50) ? 2 * MINUTE : 3 * MINUTE);
                GetHitGObj()->Use(GetCaster());
                GetHitGObj()->SetLootState(GO_JUST_DEACTIVATED);
            }

            void Register()
            {
                OnCheckCast += SpellCheckCastFn(spell_q9452_cast_net_SpellScript::CheckCast);
                OnEffectHit += SpellEffectFn(spell_q9452_cast_net_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
                OnEffectHitTarget += SpellEffectFn(spell_q9452_cast_net_SpellScript::HandleActiveObject, EFFECT_1, SPELL_EFFECT_ACTIVATE_OBJECT);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_q9452_cast_net_SpellScript();
        }
};

enum HodirsHelm
{
    SAY_1               = 1,
    SAY_2               = 2,
    NPC_KILLCREDIT      = 30210, // Hodir's Helm KC Bunny
    NPC_ICE_SPIKE_BUNNY = 30215
};

class spell_q12987_read_pronouncement : public SpellScriptLoader
{
public:
    spell_q12987_read_pronouncement() : SpellScriptLoader("spell_q12987_read_pronouncement") { }

    class spell_q12987_read_pronouncement_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_q12987_read_pronouncement_AuraScript);

        void OnApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
        {
            // player must cast kill credit and do emote text, according to sniff
            if (Player* target = GetTarget()->ToPlayer())
            {
                if (Creature* trigger = target->FindNearestCreature(NPC_ICE_SPIKE_BUNNY, 25.0f))
                {
                    sCreatureTextMgr->SendChat(trigger, SAY_1, target, CHAT_MSG_ADDON, LANG_ADDON, TEXT_RANGE_NORMAL, 0, TEAM_NEUTRAL, false, target);
                    target->KilledMonsterCredit(NPC_KILLCREDIT, 0);
                    sCreatureTextMgr->SendChat(trigger, SAY_2, target, CHAT_MSG_ADDON, LANG_ADDON, TEXT_RANGE_NORMAL, 0, TEAM_NEUTRAL, false, target);
                }
            }
        }

        void Register()
        {
            AfterEffectApply += AuraEffectApplyFn(spell_q12987_read_pronouncement_AuraScript::OnApply, EFFECT_0, SPELL_AURA_NONE, AURA_EFFECT_HANDLE_REAL);
        }
    };

    AuraScript* GetAuraScript() const
    {
        return new spell_q12987_read_pronouncement_AuraScript();
    }
};

enum LeaveNothingToChance
{
    NPC_UPPER_MINE_SHAFT            = 27436,
    NPC_LOWER_MINE_SHAFT            = 27437,

    SPELL_UPPER_MINE_SHAFT_CREDIT   = 48744,
    SPELL_LOWER_MINE_SHAFT_CREDIT   = 48745,
};

class spell_q12277_wintergarde_mine_explosion : public SpellScriptLoader
{
    public:
        spell_q12277_wintergarde_mine_explosion() : SpellScriptLoader("spell_q12277_wintergarde_mine_explosion") { }

        class spell_q12277_wintergarde_mine_explosion_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_q12277_wintergarde_mine_explosion_SpellScript);

            void HandleDummy(SpellEffIndex /*effIndex*/)
            {
                if (Creature* unitTarget = GetHitCreature())
                {
                    if (Unit* caster = GetCaster())
                    {
                        if (caster->GetTypeId() == TYPEID_UNIT)
                        {
                            if (Unit* owner = caster->GetOwner())
                            {
                                switch (unitTarget->GetEntry())
                                {
                                    case NPC_UPPER_MINE_SHAFT:
                                        caster->CastSpell(owner, SPELL_UPPER_MINE_SHAFT_CREDIT, true);
                                        break;
                                    case NPC_LOWER_MINE_SHAFT:
                                        caster->CastSpell(owner, SPELL_LOWER_MINE_SHAFT_CREDIT, true);
                                        break;
                                    default:
                                        break;
                                }
                            }
                        }
                    }
                }
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_q12277_wintergarde_mine_explosion_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_q12277_wintergarde_mine_explosion_SpellScript();
        }
};

enum FocusOnTheBeach
{
    SPELL_BUNNY_CREDIT_BEAM = 47390,
};

class spell_q12066_bunny_kill_credit : public SpellScriptLoader
{
public:
    spell_q12066_bunny_kill_credit() : SpellScriptLoader("spell_q12066_bunny_kill_credit") { }

    class spell_q12066_bunny_kill_credit_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_q12066_bunny_kill_credit_SpellScript);

        void HandleDummy(SpellEffIndex /*effIndex*/)
        {
            if (Creature* target = GetHitCreature())
                target->CastSpell(GetCaster(), SPELL_BUNNY_CREDIT_BEAM, false);
        }

        void Register()
        {
            OnEffectHitTarget += SpellEffectFn(spell_q12066_bunny_kill_credit_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
        }
    };

    SpellScript* GetSpellScript() const
    {
        return new spell_q12066_bunny_kill_credit_SpellScript();
    }
};

enum ACleansingSong
{
    SPELL_SUMMON_SPIRIT_ATAH        = 52954,
    SPELL_SUMMON_SPIRIT_HAKHALAN    = 52958,
    SPELL_SUMMON_SPIRIT_KOOSU       = 52959,

    AREA_BITTERTIDELAKE             = 4385,
    AREA_RIVERSHEART                = 4290,
    AREA_WINTERGRASPRIVER           = 4388,
};

class spell_q12735_song_of_cleansing : public SpellScriptLoader
{
    public:
        spell_q12735_song_of_cleansing() : SpellScriptLoader("spell_q12735_song_of_cleansing") { }

        class spell_q12735_song_of_cleansing_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_q12735_song_of_cleansing_SpellScript);

            void HandleScript(SpellEffIndex /*effIndex*/)
            {
                Unit* caster = GetCaster();
                switch (caster->GetAreaId())
                {
                    case AREA_BITTERTIDELAKE:
                        caster->CastSpell(caster, SPELL_SUMMON_SPIRIT_ATAH);
                        break;
                    case AREA_RIVERSHEART:
                        caster->CastSpell(caster, SPELL_SUMMON_SPIRIT_HAKHALAN);
                        break;
                    case AREA_WINTERGRASPRIVER:
                        caster->CastSpell(caster, SPELL_SUMMON_SPIRIT_KOOSU);
                        break;
                    default:
                        break;
                }
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_q12735_song_of_cleansing_SpellScript::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_q12735_song_of_cleansing_SpellScript();
        }
};

// "Bombing Run" and "Bomb Them Again!"
enum Quest11010_11102_11023Data
{
    // Spell
    SPELL_FLAK_CANNON_TRIGGER = 40110,
    SPELL_CHOOSE_LOC          = 40056,
    SPELL_AGGRO_CHECK         = 40112,
    // NPCs
    NPC_FEL_CANNON2           = 23082
};

// 40113 Knockdown Fel Cannon: The Aggro Check Aura
class spell_q11010_q11102_q11023_aggro_check_aura : public SpellScriptLoader
{
    public:
        spell_q11010_q11102_q11023_aggro_check_aura() : SpellScriptLoader("spell_q11010_q11102_q11023_aggro_check_aura") { }

        class spell_q11010_q11102_q11023_aggro_check_aura_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_q11010_q11102_q11023_aggro_check_aura_AuraScript);

            void HandleTriggerSpell(AuraEffect const* /*aurEff*/)
            {
                if (Unit* target = GetTarget())
                    // On trigger proccing
                    target->CastSpell(target, SPELL_AGGRO_CHECK);
            }

            void Register()
            {
               OnEffectPeriodic += AuraEffectPeriodicFn(spell_q11010_q11102_q11023_aggro_check_aura_AuraScript::HandleTriggerSpell, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_q11010_q11102_q11023_aggro_check_aura_AuraScript();
        }
};

// 40112 Knockdown Fel Cannon: The Aggro Check
class spell_q11010_q11102_q11023_aggro_check : public SpellScriptLoader
{
    public:
        spell_q11010_q11102_q11023_aggro_check() : SpellScriptLoader("spell_q11010_q11102_q11023_aggro_check") { }

        class spell_q11010_q11102_q11023_aggro_check_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_q11010_q11102_q11023_aggro_check_SpellScript);

            void HandleDummy(SpellEffIndex /*effIndex*/)
            {
                if (Player* playerTarget = GetHitPlayer())
                    // Check if found player target is on fly mount or using flying form
                    if (playerTarget->HasAuraType(SPELL_AURA_FLY) || playerTarget->HasAuraType(SPELL_AURA_MOD_INCREASE_MOUNTED_FLIGHT_SPEED))
                        playerTarget->CastSpell(playerTarget, SPELL_FLAK_CANNON_TRIGGER, TRIGGERED_FULL_MASK);
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_q11010_q11102_q11023_aggro_check_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_q11010_q11102_q11023_aggro_check_SpellScript();
        }
};

// 40119 Knockdown Fel Cannon: The Aggro Burst
class spell_q11010_q11102_q11023_aggro_burst : public SpellScriptLoader
{
    public:
        spell_q11010_q11102_q11023_aggro_burst() : SpellScriptLoader("spell_q11010_q11102_q11023_aggro_burst") { }

        class spell_q11010_q11102_q11023_aggro_burst_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_q11010_q11102_q11023_aggro_burst_AuraScript);

            void HandleEffectPeriodic(AuraEffect const* /*aurEff*/)
            {
                if (Unit* target = GetTarget())
                    // On each tick cast Choose Loc to trigger summon
                    target->CastSpell(target, SPELL_CHOOSE_LOC);
            }

            void Register()
            {
                OnEffectPeriodic += AuraEffectPeriodicFn(spell_q11010_q11102_q11023_aggro_burst_AuraScript::HandleEffectPeriodic, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_q11010_q11102_q11023_aggro_burst_AuraScript();
        }
};

// 40056 Knockdown Fel Cannon: Choose Loc
class spell_q11010_q11102_q11023_choose_loc : public SpellScriptLoader
{
    public:
        spell_q11010_q11102_q11023_choose_loc() : SpellScriptLoader("spell_q11010_q11102_q11023_choose_loc") { }

        class spell_q11010_q11102_q11023_choose_loc_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_q11010_q11102_q11023_choose_loc_SpellScript);

            void HandleDummy(SpellEffIndex /*effIndex*/)
            {
                Unit* caster = GetCaster();
                // Check for player that is in 65 y range
                std::list<Player*> playerList;
                Trinity::AnyPlayerInObjectRangeCheck checker(caster, 65.0f);
                Trinity::PlayerListSearcher<Trinity::AnyPlayerInObjectRangeCheck> searcher(caster, playerList, checker);
                caster->VisitNearbyWorldObject(65.0f, searcher);
                    for (std::list<Player*>::const_iterator itr = playerList.begin(); itr != playerList.end(); ++itr)
                    // Check if found player target is on fly mount or using flying form
                        if ((*itr)->HasAuraType(SPELL_AURA_FLY) || (*itr)->HasAuraType(SPELL_AURA_MOD_INCREASE_MOUNTED_FLIGHT_SPEED))
                            // Summom Fel Cannon (bunny version) at found player
                            caster->SummonCreature(NPC_FEL_CANNON2, (*itr)->GetPositionX(), (*itr)->GetPositionY(), (*itr)->GetPositionZ());
            }

            void Register()
            {
                OnEffectHit += SpellEffectFn(spell_q11010_q11102_q11023_choose_loc_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_q11010_q11102_q11023_choose_loc_SpellScript();
        }
};

// 39844 - Skyguard Blasting Charge
// 40160 - Throw Bomb
class spell_q11010_q11102_q11023_q11008_check_fly_mount : public SpellScriptLoader
{
    public:
        spell_q11010_q11102_q11023_q11008_check_fly_mount() : SpellScriptLoader("spell_q11010_q11102_q11023_q11008_check_fly_mount") { }

        class spell_q11010_q11102_q11023_q11008_check_fly_mount_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_q11010_q11102_q11023_q11008_check_fly_mount_SpellScript);

            SpellCastResult CheckRequirement()
            {
                Unit* caster = GetCaster();
                // This spell will be cast only if caster has one of these auras
                if (!(caster->HasAuraType(SPELL_AURA_FLY) || caster->HasAuraType(SPELL_AURA_MOD_INCREASE_MOUNTED_FLIGHT_SPEED)))
                    return SPELL_FAILED_CANT_DO_THAT_RIGHT_NOW;
                return SPELL_CAST_OK;
            }

            void Register()
            {
                OnCheckCast += SpellCheckCastFn(spell_q11010_q11102_q11023_q11008_check_fly_mount_SpellScript::CheckRequirement);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_q11010_q11102_q11023_q11008_check_fly_mount_SpellScript();
        }
};

// 55368 - Summon Stefan
class spell_q12661_q12669_q12676_q12677_q12713_summon_stefan : public SpellScriptLoader
{
    public:
        spell_q12661_q12669_q12676_q12677_q12713_summon_stefan() : SpellScriptLoader("spell_q12661_q12669_q12676_q12677_q12713_summon_stefan") { }

        class spell_q12661_q12669_q12676_q12677_q12713_summon_stefan_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_q12661_q12669_q12676_q12677_q12713_summon_stefan_SpellScript);

            void SetDest(SpellDestination& dest)
            {
                // Adjust effect summon position
                Position const offset = { 0.0f, 0.0f, 20.0f, 0.0f };
                dest.RelocateOffset(offset);
            }

            void Register()
            {
                OnDestinationTargetSelect += SpellDestinationTargetSelectFn(spell_q12661_q12669_q12676_q12677_q12713_summon_stefan_SpellScript::SetDest, EFFECT_0, TARGET_DEST_CASTER_BACK);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_q12661_q12669_q12676_q12677_q12713_summon_stefan_SpellScript();
        }
};

enum QuenchingMist
{
    SPELL_FLICKERING_FLAMES = 53504
};

class spell_q12730_quenching_mist : public SpellScriptLoader
{
    public:
        spell_q12730_quenching_mist() : SpellScriptLoader("spell_q12730_quenching_mist") { }

        class spell_q12730_quenching_mist_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_q12730_quenching_mist_AuraScript);

            bool Validate(SpellInfo const* /*spellInfo*/)
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_FLICKERING_FLAMES))
                    return false;
                return true;
            }

            void HandleEffectPeriodic(AuraEffect const* /*aurEff*/)
            {
                GetTarget()->RemoveAurasDueToSpell(SPELL_FLICKERING_FLAMES);
            }

            void Register()
            {
                OnEffectPeriodic += AuraEffectPeriodicFn(spell_q12730_quenching_mist_AuraScript::HandleEffectPeriodic, EFFECT_0, SPELL_AURA_PERIODIC_HEAL);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_q12730_quenching_mist_AuraScript();
        }
};

// 13291 - Borrowed Technology/13292 - The Solution Solution /Daily//13239 - Volatility/13261 - Volatiliy /Daily//
enum Quest13291_13292_13239_13261Data
{
    // NPCs
    NPC_SKYTALON       = 31583,
    NPC_DECOY          = 31578,
    // Spells
    SPELL_RIDE         = 56687
};

class spell_q13291_q13292_q13239_q13261_frostbrood_skytalon_grab_decoy : public SpellScriptLoader
{
    public:
        spell_q13291_q13292_q13239_q13261_frostbrood_skytalon_grab_decoy() : SpellScriptLoader("spell_q13291_q13292_q13239_q13261_frostbrood_skytalon_grab_decoy") { }

        class spell_q13291_q13292_q13239_q13261_frostbrood_skytalon_grab_decoy_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_q13291_q13292_q13239_q13261_frostbrood_skytalon_grab_decoy_SpellScript);

            bool Validate(SpellInfo const* /*spell*/)
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_RIDE))
                    return false;

                return true;
            }

            void HandleDummy(SpellEffIndex /*effIndex*/)
            {
                if (!GetHitCreature())
                    return;
                // TO DO: Being triggered is hack, but in checkcast it doesn't pass aurastate requirements.
                // Beside that the decoy won't keep it's freeze animation state when enter.
                GetHitCreature()->CastSpell(GetCaster(), SPELL_RIDE, true);
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_q13291_q13292_q13239_q13261_frostbrood_skytalon_grab_decoy_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_q13291_q13292_q13239_q13261_frostbrood_skytalon_grab_decoy_SpellScript();
        }
};

// 59303 - Summon Frost Wyrm
class spell_q13291_q13292_q13239_q13261_armored_decoy_summon_skytalon : public SpellScriptLoader
{
    public:
        spell_q13291_q13292_q13239_q13261_armored_decoy_summon_skytalon() : SpellScriptLoader("spell_q13291_q13292_q13239_q13261_armored_decoy_summon_skytalon") { }

        class spell_q13291_q13292_q13239_q13261_armored_decoy_summon_skytalon_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_q13291_q13292_q13239_q13261_armored_decoy_summon_skytalon_SpellScript);

            void SetDest(SpellDestination& dest)
            {
                // Adjust effect summon position
                Position const offset = { 0.0f, 0.0f, 20.0f, 0.0f };
                dest.RelocateOffset(offset);
            }

            void Register()
            {
                OnDestinationTargetSelect += SpellDestinationTargetSelectFn(spell_q13291_q13292_q13239_q13261_armored_decoy_summon_skytalon_SpellScript::SetDest, EFFECT_0, TARGET_DEST_CASTER_BACK);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_q13291_q13292_q13239_q13261_armored_decoy_summon_skytalon_SpellScript();
        }
};

enum BearFlankMaster
{
    SPELL_BEAR_FLANK_MASTER = 56565,
    SPELL_CREATE_BEAR_FLANK = 56566,
    SPELL_BEAR_FLANK_FAIL = 56569
};

class spell_q13011_bear_flank_master : public SpellScriptLoader
{
    public:
        spell_q13011_bear_flank_master() : SpellScriptLoader("spell_q13011_bear_flank_master") { }

        class spell_q13011_bear_flank_master_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_q13011_bear_flank_master_SpellScript);

            bool Validate(SpellInfo const* /*spellInfo*/)
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_BEAR_FLANK_MASTER) ||
                    !sSpellMgr->GetSpellInfo(SPELL_CREATE_BEAR_FLANK))
                    return false;
                return true;
            }

            bool Load()
            {
                return GetCaster()->GetTypeId() == TYPEID_UNIT;
            }

            void HandleScript(SpellEffIndex /*effIndex*/)
            {
                bool failed = RAND(0, 1); // 50% chance
                Creature* creature = GetCaster()->ToCreature();
                if (Player* player = GetHitPlayer())
                {
                    if (failed)
                    {
                        player->CastSpell(creature, SPELL_BEAR_FLANK_FAIL);
                        creature->AI()->Talk(0, player);
                    }
                    else
                        player->CastSpell(player, SPELL_CREATE_BEAR_FLANK);
                }
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_q13011_bear_flank_master_SpellScript::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_q13011_bear_flank_master_SpellScript();
        }
};

enum BurstAtTheSeams
{
    NPC_DRAKKARI_CHIEFTAINK                 = 29099,

    QUEST_BURST_AT_THE_SEAMS                = 12690,

    SPELL_BURST_AT_THE_SEAMS                = 52510, // Burst at the Seams
    SPELL_BURST_AT_THE_SEAMS_DMG            = 52508, // Damage spell
    SPELL_BURST_AT_THE_SEAMS_DMG_2          = 59580, // Abomination self damage spell
    SPELL_BURST_AT_THE_SEAMS_BONE           = 52516, // Burst at the Seams:Bone
    SPELL_BURST_AT_THE_SEAMS_MEAT           = 52520, // Explode Abomination:Meat
    SPELL_BURST_AT_THE_SEAMS_BMEAT          = 52523, // Explode Abomination:Bloody Meat
    SPELL_DRAKKARI_SKULLCRUSHER_CREDIT      = 52590, // Credit for Drakkari Skullcrusher
    SPELL_SUMMON_DRAKKARI_CHIEFTAIN         = 52616, // Summon Drakkari Chieftain
    SPELL_DRAKKARI_CHIEFTAINK_KILL_CREDIT   = 52620  // Drakkari Chieftain Kill Credit
};

class spell_q12690_burst_at_the_seams : public SpellScriptLoader
{
    public:
        spell_q12690_burst_at_the_seams() : SpellScriptLoader("spell_q12690_burst_at_the_seams") { }

        class spell_q12690_burst_at_the_seams_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_q12690_burst_at_the_seams_SpellScript);

            bool Validate(SpellInfo const* /*spellInfo*/)
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_BURST_AT_THE_SEAMS)
                    || !sSpellMgr->GetSpellInfo(SPELL_BURST_AT_THE_SEAMS_DMG)
                    || !sSpellMgr->GetSpellInfo(SPELL_BURST_AT_THE_SEAMS_DMG_2)
                    || !sSpellMgr->GetSpellInfo(SPELL_BURST_AT_THE_SEAMS_BONE)
                    || !sSpellMgr->GetSpellInfo(SPELL_BURST_AT_THE_SEAMS_MEAT)
                    || !sSpellMgr->GetSpellInfo(SPELL_BURST_AT_THE_SEAMS_BMEAT))
                    return false;
                return true;
            }

            bool Load()
            {
                return GetCaster()->GetTypeId() == TYPEID_UNIT;
            }

            void HandleKnockBack(SpellEffIndex /*effIndex*/)
            {
                if (Unit* creature = GetHitCreature())
                {
                    if (Unit* charmer = GetCaster()->GetCharmerOrOwner())
                    {
                        if (Player* player = charmer->ToPlayer())
                        {
                            if (player->GetQuestStatus(QUEST_BURST_AT_THE_SEAMS) == QUEST_STATUS_INCOMPLETE)
                            {
                                creature->CastSpell(creature, SPELL_BURST_AT_THE_SEAMS_BONE, true);
                                creature->CastSpell(creature, SPELL_BURST_AT_THE_SEAMS_MEAT, true);
                                creature->CastSpell(creature, SPELL_BURST_AT_THE_SEAMS_BMEAT, true);
                                creature->CastSpell(creature, SPELL_BURST_AT_THE_SEAMS_DMG, true);
                                creature->CastSpell(creature, SPELL_BURST_AT_THE_SEAMS_DMG_2, true);

                                player->CastSpell(player, SPELL_DRAKKARI_SKULLCRUSHER_CREDIT, true);
                                uint16 count = player->GetReqKillOrCastCurrentCount(QUEST_BURST_AT_THE_SEAMS, NPC_DRAKKARI_CHIEFTAINK);
                                if ((count % 20) == 0)
                                    player->CastSpell(player, SPELL_SUMMON_DRAKKARI_CHIEFTAIN, true);
                            }
                        }
                    }
                }
            }

            void HandleScript(SpellEffIndex /*effIndex*/)
            {
                GetCaster()->ToCreature()->DespawnOrUnsummon(2 * IN_MILLISECONDS);
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_q12690_burst_at_the_seams_SpellScript::HandleKnockBack, EFFECT_1, SPELL_EFFECT_KNOCK_BACK);
                OnEffectHitTarget += SpellEffectFn(spell_q12690_burst_at_the_seams_SpellScript::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_q12690_burst_at_the_seams_SpellScript();
        }
};

enum EscapeFromSilverbrook
{
    SPELL_SUMMON_WORGEN = 48681
};

// 48682 - Escape from Silverbrook - Periodic Dummy
class spell_q12308_escape_from_silverbrook : public SpellScriptLoader
{
    public:
        spell_q12308_escape_from_silverbrook() : SpellScriptLoader("spell_q12308_escape_from_silverbrook") { }

        class spell_q12308_escape_from_silverbrook_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_q12308_escape_from_silverbrook_SpellScript);

            bool Validate(SpellInfo const* /*spellInfo*/)
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_SUMMON_WORGEN))
                    return false;
                return true;
            }

            void HandleDummy(SpellEffIndex /*effIndex*/)
            {
                GetCaster()->CastSpell(GetCaster(), SPELL_SUMMON_WORGEN, true);
            }

            void Register()
            {
                OnEffectHit += SpellEffectFn(spell_q12308_escape_from_silverbrook_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_q12308_escape_from_silverbrook_SpellScript();
        }
};

// 48681 - Summon Silverbrook Worgen
class spell_q12308_escape_from_silverbrook_summon_worgen : public SpellScriptLoader
{
    public:
        spell_q12308_escape_from_silverbrook_summon_worgen() : SpellScriptLoader("spell_q12308_escape_from_silverbrook_summon_worgen") { }

        class spell_q12308_escape_from_silverbrook_summon_worgen_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_q12308_escape_from_silverbrook_summon_worgen_SpellScript);

            void ModDest(SpellDestination& dest)
            {
                float dist = GetSpellInfo()->Effects[EFFECT_0].CalcRadius(GetCaster());
                float angle = frand(0.75f, 1.25f) * M_PI;

                Position pos;
                GetCaster()->GetNearPosition(pos, dist, angle);
                dest.Relocate(pos);
            }

            void Register()
            {
                OnDestinationTargetSelect += SpellDestinationTargetSelectFn(spell_q12308_escape_from_silverbrook_summon_worgen_SpellScript::ModDest, EFFECT_0, TARGET_DEST_CASTER_SUMMON);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_q12308_escape_from_silverbrook_summon_worgen_SpellScript();
        }
};


enum DeathComesFromOnHigh
{
    SPELL_FORGE_CREDIT                  = 51974,
    SPELL_TOWN_HALL_CREDIT              = 51977,
    SPELL_SCARLET_HOLD_CREDIT           = 51980,
    SPELL_CHAPEL_CREDIT                 = 51982,

    NPC_NEW_AVALON_FORGE                = 28525,
    NPC_NEW_AVALON_TOWN_HALL            = 28543,
    NPC_SCARLET_HOLD                    = 28542,
    NPC_CHAPEL_OF_THE_CRIMSON_FLAME     = 28544
};

// 51858 - Siphon of Acherus
class spell_q12641_death_comes_from_on_high : public SpellScriptLoader
{
    public:
        spell_q12641_death_comes_from_on_high() : SpellScriptLoader("spell_q12641_death_comes_from_on_high") { }

        class spell_q12641_death_comes_from_on_high_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_q12641_death_comes_from_on_high_SpellScript);

            bool Validate(SpellInfo const* /*spellInfo*/)
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_FORGE_CREDIT) ||
                    !sSpellMgr->GetSpellInfo(SPELL_TOWN_HALL_CREDIT) ||
                    !sSpellMgr->GetSpellInfo(SPELL_SCARLET_HOLD_CREDIT) ||
                    !sSpellMgr->GetSpellInfo(SPELL_CHAPEL_CREDIT))
                    return false;
                return true;
            }

            void HandleDummy(SpellEffIndex /*effIndex*/)
            {
                uint32 spellId = 0;

                switch (GetHitCreature()->GetEntry())
                {
                    case NPC_NEW_AVALON_FORGE:
                        spellId = SPELL_FORGE_CREDIT;
                        break;
                    case NPC_NEW_AVALON_TOWN_HALL:
                        spellId = SPELL_TOWN_HALL_CREDIT;
                        break;
                    case NPC_SCARLET_HOLD:
                        spellId = SPELL_SCARLET_HOLD_CREDIT;
                        break;
                    case NPC_CHAPEL_OF_THE_CRIMSON_FLAME:
                        spellId = SPELL_CHAPEL_CREDIT;
                        break;
                    default:
                        return;
                }

                GetCaster()->CastSpell((Unit*)NULL, spellId, true);
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_q12641_death_comes_from_on_high_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_q12641_death_comes_from_on_high_SpellScript();
        }
};

// 51769 - Emblazon Runeblade
class spell_q12619_emblazon_runeblade : public SpellScriptLoader
{
    public:
        spell_q12619_emblazon_runeblade() : SpellScriptLoader("spell_q12619_emblazon_runeblade") { }

        class spell_q12619_emblazon_runeblade_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_q12619_emblazon_runeblade_AuraScript);

            void HandleEffectPeriodic(AuraEffect const* aurEff)
            {
                PreventDefaultAction();
                if (Unit* caster = GetCaster())
                    caster->CastSpell(caster, GetSpellInfo()->Effects[aurEff->GetEffIndex()].TriggerSpell, true, NULL, aurEff);
            }

            void Register()
            {
                OnEffectPeriodic += AuraEffectPeriodicFn(spell_q12619_emblazon_runeblade_AuraScript::HandleEffectPeriodic, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_q12619_emblazon_runeblade_AuraScript();
        }
};

// 51770 - Emblazon Runeblade
class spell_q12619_emblazon_runeblade_effect : public SpellScriptLoader
{
    public:
        spell_q12619_emblazon_runeblade_effect() : SpellScriptLoader("spell_q12619_emblazon_runeblade_effect") { }

        class spell_q12619_emblazon_runeblade_effect_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_q12619_emblazon_runeblade_effect_SpellScript);

            void HandleScript(SpellEffIndex /*effIndex*/)
            {
                GetCaster()->CastSpell(GetCaster(), uint32(GetEffectValue()), false);
            }

            void Register()
            {
                OnEffectHit += SpellEffectFn(spell_q12619_emblazon_runeblade_effect_SpellScript::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_q12619_emblazon_runeblade_effect_SpellScript();
        }
};

enum Quest_The_Storm_King
{
    SPELL_RIDE_GYMER            = 43671,
    SPELL_GRABBED               = 55424
};

class spell_q12919_gymers_grab : public SpellScriptLoader
{
    public:
        spell_q12919_gymers_grab() : SpellScriptLoader("spell_q12919_gymers_grab") { }

        class spell_q12919_gymers_grab_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_q12919_gymers_grab_SpellScript);

            bool Validate(SpellInfo const* /*spell*/)
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_RIDE_GYMER))
                    return false;
                return true;
            }

            void HandleScript(SpellEffIndex /*effIndex*/)
            {
                int8 seatId = 2;
                if (!GetHitCreature())
                    return;
                GetHitCreature()->CastCustomSpell(SPELL_RIDE_GYMER, SPELLVALUE_BASE_POINT0, seatId, GetCaster(), true);
                GetHitCreature()->CastSpell(GetHitCreature(), SPELL_GRABBED, true);
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_q12919_gymers_grab_SpellScript::HandleScript, EFFECT_0,  SPELL_EFFECT_SCRIPT_EFFECT);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_q12919_gymers_grab_SpellScript();
        }
};

enum Quest_The_Storm_King_Throw
{
    SPELL_VARGUL_EXPLOSION      = 55569
};

class spell_q12919_gymers_throw : public SpellScriptLoader
{
    public:
        spell_q12919_gymers_throw() : SpellScriptLoader("spell_q12919_gymers_throw") { }

        class spell_q12919_gymers_throw_SpellScript : public SpellScript
        {
           PrepareSpellScript(spell_q12919_gymers_throw_SpellScript);

            void HandleScript(SpellEffIndex /*effIndex*/)
            {
                Unit* caster = GetCaster();
                if (caster->IsVehicle())
                    if (Unit* passenger = caster->GetVehicleKit()->GetPassenger(1))
                    {
                         passenger->ExitVehicle();
                         caster->CastSpell(passenger, SPELL_VARGUL_EXPLOSION, true);
                    }
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_q12919_gymers_throw_SpellScript::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_q12919_gymers_throw_SpellScript();
        }
};

#define QUEST_CROW_TRANSFORM 9718

// spell 38776 
class spell_q9718_crow_transform : public SpellScriptLoader
{
public:
    spell_q9718_crow_transform() : SpellScriptLoader("spell_q9718_crow_transform") { }

    class spell_q9718_crow_transform_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_q9718_crow_transform_AuraScript)

        void HandleEffectRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
        {
            if(GetOwner())
                if(Player* player = GetOwner()->ToPlayer())
                    player->CompleteQuest(QUEST_CROW_TRANSFORM);
        }

        void Register()
        {
            OnEffectRemove += AuraEffectRemoveFn(spell_q9718_crow_transform_AuraScript::HandleEffectRemove, EFFECT_0, SPELL_AURA_TRANSFORM, AURA_EFFECT_HANDLE_REAL_OR_REAPPLY_MASK);
        }
    };

    AuraScript* GetAuraScript() const
    {
        return new spell_q9718_crow_transform_AuraScript();
    }
};


void AddSC_quest_spell_scripts()
{
    // Ours
    new spell_q11065_wrangle_some_aether_rays();
    new spell_image_of_drakuru_reagent_check();
    new spell_q12014_steady_as_a_rock();
    new spell_q11026_a11051_banish_the_demons();
    new spell_q10525_vision_guide();
    new spell_q11322_q11317_the_cleansing();
    new spell_q10714_on_spirits_wings();
    new spell_q10720_the_smallest_creature();
    new spell_q13086_last_line_of_defence();
    new spell_q12943_shadow_vault_decree();
    new spell_q10769_dissension_amongst_the_ranks();
    new spell_q11520_discovering_your_roots();
    new spell_quest_dragonmaw_race_generic();
    new spell_q11670_it_was_the_orcs_honest();
    new spell_quest_test_flight_charging();
    new spell_q12274_a_fall_from_grace_costume();
    new spell_q13369_fate_up_against_your_will();
    new spell_q11198_take_down_tethyr();
    new spell_q11653_youre_not_so_big_now();
    new spell_q10985_light_of_the_naaru();
    new spell_q9718_crow_transform();

    // Theirs
    new spell_q55_sacred_cleansing();
    new spell_q2203_thaumaturgy_channel();
    new spell_q5206_test_fetid_skull();
    new spell_q6124_6129_apply_salve();
    new spell_q11396_11399_force_shield_arcane_purple_x3();
    new spell_q11396_11399_scourging_crystal_controller();
    new spell_q11396_11399_scourging_crystal_controller_dummy();
    new spell_q11515_fel_siphon_dummy();
    new spell_q11587_arcane_prisoner_rescue();
    new spell_q11730_ultrasonic_screwdriver();
    new spell_q12459_seeds_of_natures_wrath();
    new spell_q12634_despawn_fruit_tosser();
    new spell_q12683_take_sputum_sample();
    new spell_q12851_going_bearback();
    new spell_q12937_relief_for_the_fallen();
    new spell_q10041_q10040_who_are_they();
    new spell_symbol_of_life_dummy();
    new spell_q12659_ahunaes_knife();
    new spell_q9874_liquid_fire();
    new spell_q12805_lifeblood_dummy();
    new spell_q13280_13283_plant_battle_standard();
    new spell_q14112_14145_chum_the_water();
    new spell_q9452_cast_net();
    new spell_q12987_read_pronouncement();
    new spell_q12277_wintergarde_mine_explosion();
    new spell_q12066_bunny_kill_credit();
    new spell_q12735_song_of_cleansing();
    new spell_q11010_q11102_q11023_aggro_check_aura();
    new spell_q11010_q11102_q11023_aggro_check();
    new spell_q11010_q11102_q11023_aggro_burst();
    new spell_q11010_q11102_q11023_choose_loc();
    new spell_q11010_q11102_q11023_q11008_check_fly_mount();
    new spell_q12661_q12669_q12676_q12677_q12713_summon_stefan();
    new spell_q12730_quenching_mist();
    new spell_q13291_q13292_q13239_q13261_frostbrood_skytalon_grab_decoy();
    new spell_q13291_q13292_q13239_q13261_armored_decoy_summon_skytalon();
    new spell_q13011_bear_flank_master();
    new spell_q12690_burst_at_the_seams();
    new spell_q12308_escape_from_silverbrook_summon_worgen();
    new spell_q12308_escape_from_silverbrook();
    new spell_q12641_death_comes_from_on_high();
    new spell_q12619_emblazon_runeblade();
    new spell_q12619_emblazon_runeblade_effect();
    new spell_q12919_gymers_grab();
    new spell_q12919_gymers_throw();
}

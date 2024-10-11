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

#include "CellImpl.h"
#include "CreatureScript.h"
#include "CreatureTextMgr.h"
#include "GridNotifiers.h"
#include "MapMgr.h"
#include "ScriptedCreature.h"
#include "SpellAuraEffects.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "Vehicle.h"
/*
 * Scripts for spells with SPELLFAMILY_GENERIC spells used for quests.
 * Ordered alphabetically using questId and scriptname.
 * Scriptnames of files in this file should be prefixed with "spell_q#questID_".
 */

class spell_q11065_wrangle_some_aether_rays : public SpellScript
{
    PrepareSpellScript(spell_q11065_wrangle_some_aether_rays);

    SpellCastResult CheckCast()
    {
        // if thane is present and not in combat - allow cast
        if (Unit* target = GetExplTargetUnit())
            if (target->GetHealthPct() < 40.0f)
                return SPELL_CAST_OK;

        return SPELL_FAILED_CASTER_AURASTATE;
    }

    void Register() override
    {
        OnCheckCast += SpellCheckCastFn(spell_q11065_wrangle_some_aether_rays::CheckCast);
    }
};

class spell_q11065_wrangle_some_aether_rays_aura : public AuraScript
{
    PrepareAuraScript(spell_q11065_wrangle_some_aether_rays_aura)
    void HandleEffectRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        Unit* ar = GetTarget();
        if (ar && ar->ToCreature())
        {
            if (GetCaster() && GetCaster()->ToPlayer())
            {
                Player* player = GetCaster()->ToPlayer();

                player->KilledMonsterCredit(23343);
                if (Creature* cr = GetCaster()->SummonCreature(23343, ar->GetPositionX(), ar->GetPositionY(), ar->GetPositionZ(), ar->GetOrientation(), TEMPSUMMON_TIMED_DESPAWN, 180000))
                {
                    cr->CastSpell(player, 40926, true);
                    cr->GetMotionMaster()->MoveFollow(player, 5.0f, 2 * M_PI * rand_norm());
                    ar->ToCreature()->DespawnOrUnsummon(500);
                }
            }
        }
    }

    void HandleEffectApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        SetDuration(5000);
    }

    void Register() override
    {
        OnEffectApply += AuraEffectApplyFn(spell_q11065_wrangle_some_aether_rays_aura::HandleEffectApply, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
        OnEffectRemove += AuraEffectRemoveFn(spell_q11065_wrangle_some_aether_rays_aura::HandleEffectRemove, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
    }
};

enum eDrakuru
{
    QUEST_SUBJECT_TO_INTERPRETATION         = 11991,
    QUEST_MY_HEART_IS_IN_YOUR_HANDS         = 12802,

    NPC_DRAKURU                             = 28016,
};

class spell_image_of_drakuru_reagent_check : public SpellScript
{
    PrepareSpellScript(spell_image_of_drakuru_reagent_check);

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

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_image_of_drakuru_reagent_check::HandleDummyEffect, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

class spell_q12014_steady_as_a_rock : public SpellScript
{
    PrepareSpellScript(spell_q12014_steady_as_a_rock);

    void HandleFinish()
    {
        Unit* caster = GetCaster();
        if (!caster || !caster->ToPlayer()) // caster cant be null, but meh :p
            return;

        if (caster->ToPlayer()->GetQuestStatus(12014 /*QUEST_STEADY_AS_A_ROCK*/) == QUEST_STATUS_INCOMPLETE)
        {
            float x = caster->GetPositionX() + 3.0f * cos(caster->GetOrientation());
            float y = caster->GetPositionY() + 3.0f * std::sin(caster->GetOrientation());
            float o = caster->GetOrientation() < M_PI ? caster->GetOrientation() + M_PI : caster->GetOrientation() - M_PI;
            caster->SummonGameObject(188367, x, y, caster->GetPositionZ(), o, 0.0f, 0.0f, 0.0f, 0.0f, 60000);
        }
    }

    void Register() override
    {
        AfterCast += SpellCastFn(spell_q12014_steady_as_a_rock::HandleFinish);
    }
};

class spell_q11026_a11051_banish_the_demons_aura : public AuraScript
{
    PrepareAuraScript(spell_q11026_a11051_banish_the_demons_aura)

    void HandleEffectRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        Unit* ar = GetTarget();
        if (ar && !ar->IsAlive())
            ar->CastSpell(ar, 40828, true); // Banish kill credit
    }

    void Register() override
    {
        // aura spell only
        if (m_scriptSpellId == 40825)
            OnEffectRemove += AuraEffectRemoveFn(spell_q11026_a11051_banish_the_demons_aura::HandleEffectRemove, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
    }
};

class spell_q11026_a11051_banish_the_demons : public SpellScript
{
    PrepareSpellScript(spell_q11026_a11051_banish_the_demons);

    void HandleScriptEffect(SpellEffIndex /*effIndex*/)
    {
        if (Unit* target = GetHitUnit())
            if (Unit* owner = target->ToTempSummon()->GetSummonerUnit())
                if (owner->IsPlayer())
                    owner->ToPlayer()->KilledMonsterCredit(23327); // Some trigger, just count
    }

    void Register() override
    {
        // script effect only
        if (m_scriptSpellId == 40828)
            OnEffectHitTarget += SpellEffectFn(spell_q11026_a11051_banish_the_demons::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

class spell_q10525_vision_guide : public AuraScript
{
    PrepareAuraScript(spell_q10525_vision_guide)

    void HandleEffectApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        SetDuration(75 * IN_MILLISECONDS);
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

    void Register() override
    {
        OnEffectApply += AuraEffectApplyFn(spell_q10525_vision_guide::HandleEffectApply, EFFECT_0, SPELL_AURA_TRANSFORM, AURA_EFFECT_HANDLE_REAL);
        AfterEffectRemove += AuraEffectRemoveFn(spell_q10525_vision_guide::HandleEffectRemove, EFFECT_0, SPELL_AURA_TRANSFORM, AURA_EFFECT_HANDLE_REAL);
    }
};

class spell_q11322_q11317_the_cleansing : public AuraScript
{
    PrepareAuraScript(spell_q11322_q11317_the_cleansing)

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

    void Register() override
    {
        OnEffectApply += AuraEffectApplyFn(spell_q11322_q11317_the_cleansing::HandleEffectApply, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
    }
};

class spell_q10714_on_spirits_wings : public SpellScript
{
    PrepareSpellScript(spell_q10714_on_spirits_wings);

    uint8 count;
    bool Load() override
    {
        count = 0;
        return true;
    }

    void HandleDummy(SpellEffIndex /*effIndex*/)
    {
        if (Creature* target = GetHitCreature())
            if (target->GetSpawnId() == 77757 || target->GetSpawnId() == 78693)
            {
                count++;
                if (count == 2)
                    if (GetCaster() && GetCaster()->ToPlayer())
                        GetCaster()->ToPlayer()->KilledMonsterCredit(22383);
            }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_q10714_on_spirits_wings::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

class spell_q10720_the_smallest_creature : public SpellScript
{
    PrepareSpellScript(spell_q10720_the_smallest_creature);

    void HandleScriptEffect(SpellEffIndex /*effIndex*/)
    {
        if (GetCaster() && GetHitUnit())
            if (Player* player = GetCaster()->GetCharmerOrOwnerPlayerOrPlayerItself())
                player->KilledMonsterCredit(GetHitUnit()->GetEntry());
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_q10720_the_smallest_creature::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

class spell_q13086_last_line_of_defence : public SpellScript
{
    PrepareSpellScript(spell_q13086_last_line_of_defence);

    bool Load() override { _triggerSpellId = 0; return true; }

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

    void Register() override
    {
        OnEffectLaunch += SpellEffectFn(spell_q13086_last_line_of_defence::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
        OnEffectLaunch += SpellEffectFn(spell_q13086_last_line_of_defence::HandleDummy, EFFECT_1, SPELL_EFFECT_DUMMY);
        AfterCast += SpellCastFn(spell_q13086_last_line_of_defence::HandleAfterCast);
    }

private:
    uint32 _triggerSpellId;
};

enum eShadowVaultDecree
{
    NPC_THANE_UFRANG                = 29919,
};

class spell_q12943_shadow_vault_decree : public SpellScript
{
    PrepareSpellScript(spell_q12943_shadow_vault_decree);

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

    void Register() override
    {
        OnCheckCast += SpellCheckCastFn(spell_q12943_shadow_vault_decree::CheckRequirement);
        OnEffectHitTarget += SpellEffectFn(spell_q12943_shadow_vault_decree::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

class spell_q10769_dissension_amongst_the_ranks_aura : public AuraScript
{
    PrepareAuraScript(spell_q10769_dissension_amongst_the_ranks_aura)

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

    void Register() override
    {
        if (m_scriptSpellId == 38224)
        {
            OnEffectApply += AuraEffectApplyFn(spell_q10769_dissension_amongst_the_ranks_aura::HandleEffectApply, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
            OnEffectRemove += AuraEffectRemoveFn(spell_q10769_dissension_amongst_the_ranks_aura::HandleEffectRemove, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
        }
    }
};

class spell_q10769_dissension_amongst_the_ranks : public SpellScript
{
    PrepareSpellScript(spell_q10769_dissension_amongst_the_ranks);

    void HandleScriptEffect(SpellEffIndex /*effIndex*/)
    {
        if (Unit* target = GetHitUnit())
            if (Player* player = target->GetCharmerOrOwnerPlayerOrPlayerItself())
                if (player->HasAura(38224))
                    player->KilledMonsterCredit(22051);
    }

    void Register() override
    {
        if (m_scriptSpellId == 38223)
            OnEffectHitTarget += SpellEffectFn(spell_q10769_dissension_amongst_the_ranks::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

enum q11520Roots
{
    GO_RAZORTHORN_DIRT_MOUNT            = 187073,
    SPELL_SUMMON_RAZORTHORN_ROOT        = 44941,
};

class spell_q11520_discovering_your_roots : public SpellScript
{
    PrepareSpellScript(spell_q11520_discovering_your_roots);

    void HandleDummy(SpellEffIndex /*effIndex*/)
    {
        if (GameObject* go = GetCaster()->FindNearestGameObject(GO_RAZORTHORN_DIRT_MOUNT, 20.0f))
        {
            GetCaster()->GetMotionMaster()->MovePoint(0, *go);
            go->SetLootState(GO_JUST_DEACTIVATED);
            GetCaster()->CastSpell(GetCaster(), SPELL_SUMMON_RAZORTHORN_ROOT, true);
        }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_q11520_discovering_your_roots::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

class spell_q11670_it_was_the_orcs_honest : public SpellScript
{
    PrepareSpellScript(spell_q11670_it_was_the_orcs_honest);

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

    void Register() override
    {
        OnCheckCast += SpellCheckCastFn(spell_q11670_it_was_the_orcs_honest::CheckTarget);
        AfterHit += SpellHitFn(spell_q11670_it_was_the_orcs_honest::HandleScriptEffect);
    }
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

class spell_quest_test_flight_charging : public AuraScript
{
    PrepareAuraScript(spell_quest_test_flight_charging)

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
                case 0:
                    spellId = SPELL_SOARING_10557;
                    break;
                case 1:
                    spellId = SPELL_SOARING_10710;
                    break;
                case 2:
                    spellId = SPELL_SOARING_10711;
                    break;
                case 3:
                    spellId = SPELL_SOARING_10712;
                    break;
            }

            player->RemoveAurasDueToSpell(SPELL_CANNON_CHARGING_PORT);
            shooter->CastSpell(player, spellId, true);
        }
    }

    void HandleEffectPeriodicSelf(AuraEffect const* aurEff)
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

    void HandleEffectPeriodicPlatform(AuraEffect const* aurEff)
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

    void Register() override
    {
        if (m_scriptSpellId == SPELL_CANNON_CHARGING_SELF)
        {
            OnEffectApply += AuraEffectApplyFn(spell_quest_test_flight_charging::OnApplySelf, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL, AURA_EFFECT_HANDLE_REAL);
            OnEffectPeriodic += AuraEffectPeriodicFn(spell_quest_test_flight_charging::HandleEffectPeriodicSelf, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
        }
        else
            OnEffectPeriodic += AuraEffectPeriodicFn(spell_quest_test_flight_charging::HandleEffectPeriodicPlatform, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
    }
};

enum qFallFromGrace
{
    SPELL_SCARLET_RAVEN_PRIEST_IMAGE_MALE   = 48763,
    SPELL_SCARLET_RAVEN_PRIEST_IMAGE_FEMALE = 48761
};

class spell_q12274_a_fall_from_grace_costume : public SpellScript
{
    PrepareSpellScript(spell_q12274_a_fall_from_grace_costume)

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_SCARLET_RAVEN_PRIEST_IMAGE_MALE, SPELL_SCARLET_RAVEN_PRIEST_IMAGE_FEMALE });
    }

    void HandleScript(SpellEffIndex  /*effIndex*/)
    {
        if (Unit* target = GetHitUnit())
        {
            if (Player* p = target->ToPlayer())
            {
                p->CastSpell(p, p->getGender() == GENDER_FEMALE ? SPELL_SCARLET_RAVEN_PRIEST_IMAGE_FEMALE : SPELL_SCARLET_RAVEN_PRIEST_IMAGE_MALE, false);
            }
        }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_q12274_a_fall_from_grace_costume::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

class spell_q13369_fate_up_against_your_will : public SpellScript
{
    PrepareSpellScript(spell_q13369_fate_up_against_your_will)

    void HandleScript(SpellEffIndex effIndex)
    {
        PreventHitDefaultEffect(effIndex);
        GetCaster()->CastSpell(GetCaster(), GetEffectValue(), true);
    }

    SpellCastResult CheckRequirement()
    {
        // Fate, Up Against Your Will (13369)
        if (Unit* caster = GetCaster())
            if (caster->IsPlayer() && caster->ToPlayer()->GetQuestStatus(13369) >= QUEST_STATUS_COMPLETE)
                return SPELL_CAST_OK;
        return SPELL_FAILED_DONT_REPORT;
    }

    void Register() override
    {
        OnCheckCast += SpellCheckCastFn(spell_q13369_fate_up_against_your_will::CheckRequirement);
        OnEffectHitTarget += SpellEffectFn(spell_q13369_fate_up_against_your_will::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

class spell_q11198_take_down_tethyr : public SpellScript
{
    PrepareSpellScript(spell_q11198_take_down_tethyr)

    void HandleScript(SpellEffIndex effIndex)
    {
        PreventHitDefaultEffect(effIndex);
        if (Unit* unit = GetHitUnit())
            if (unit->IsImmuneToPC())
                return;
        GetCaster()->CastCustomSpell(42576 /*SPELL_CANNON_BLAST*/, SPELLVALUE_BASE_POINT0, GetEffectValue(), GetCaster(), true);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_q11198_take_down_tethyr::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

class spell_q11653_youre_not_so_big_now : public SpellScript
{
    PrepareSpellScript(spell_q11653_youre_not_so_big_now)

    void HandleScript(SpellEffIndex effIndex)
    {
        PreventHitDefaultEffect(effIndex);
        Unit* target = GetHitUnit();
        if (!target || !target->IsCreature())
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

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_q11653_youre_not_so_big_now::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

class spell_q10985_light_of_the_naaru : public AuraScript
{
    PrepareAuraScript(spell_q10985_light_of_the_naaru);

    bool CheckProc(ProcEventInfo& eventInfo)
    {
        Unit* target = eventInfo.GetActionTarget();
        return target && target->GetFaction() == 1843; // Xinef: Illidari demons faction
    }

    void Register() override
    {
        DoCheckProc += AuraCheckProcFn(spell_q10985_light_of_the_naaru::CheckProc);
    }
};

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

    void Register() override
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

    SpellScript* GetSpellScript() const override
    {
        return new spell_generic_quest_update_entry_SpellScript(SPELL_EFFECT_DUMMY, EFFECT_1, NPC_MORBENT, NPC_WEAKENED_MORBENT, true);
    }
};

enum BendingShinbone
{
    SPELL_BENDING_SHINBONE1 = 8854,
    SPELL_BENDING_SHINBONE2 = 8855
};

class spell_q1846_bending_shinbone : public SpellScript
{
    PrepareSpellScript(spell_q1846_bending_shinbone);

    void HandleScriptEffect(SpellEffIndex /* effIndex */)
    {
        Item* target = GetHitItem();
        Unit* caster = GetCaster();
        if (!target && !caster->IsPlayer())
            return;

        uint32 const spellId = roll_chance_i(20) ? SPELL_BENDING_SHINBONE1 : SPELL_BENDING_SHINBONE2;
        caster->CastSpell(caster, spellId, true);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_q1846_bending_shinbone::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

// 9712 - Thaumaturgy Channel
enum ThaumaturgyChannel
{
    SPELL_THAUMATURGY_CHANNEL = 21029
};

class spell_q2203_thaumaturgy_channel : public AuraScript
{
    PrepareAuraScript(spell_q2203_thaumaturgy_channel);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_THAUMATURGY_CHANNEL });
    }

    void HandleEffectPeriodic(AuraEffect const* /*aurEff*/)
    {
        PreventDefaultAction();
        if (Unit* caster = GetCaster())
            caster->CastSpell(caster, SPELL_THAUMATURGY_CHANNEL, false);
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_q2203_thaumaturgy_channel::HandleEffectPeriodic, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
    }
};

// http://www.wowhead.com/quest=5206 Marauders of Darrowshire
// 17271 Test Fetid Skull
enum Quest5206Data
{
    SPELL_CREATE_RESONATING_SKULL = 17269,
    SPELL_CREATE_BONE_DUST = 17270
};

class spell_q5206_test_fetid_skull : public SpellScript
{
    PrepareSpellScript(spell_q5206_test_fetid_skull);

    bool Load() override
    {
        return GetCaster()->IsPlayer();
    }

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_CREATE_RESONATING_SKULL, SPELL_CREATE_BONE_DUST });
    }

    void HandleDummy(SpellEffIndex /*effIndex*/)
    {
        Unit* caster = GetCaster();
        uint32 spellId = roll_chance_i(50) ? SPELL_CREATE_RESONATING_SKULL : SPELL_CREATE_BONE_DUST;
        caster->CastSpell(caster, spellId, true, nullptr);
    }

    void Register() override
    {
        OnEffectHit += SpellEffectFn(spell_q5206_test_fetid_skull::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
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

class spell_q6124_6129_apply_salve : public SpellScript
{
    PrepareSpellScript(spell_q6124_6129_apply_salve);

    bool Load() override
    {
        return GetCaster()->IsPlayer();
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
                    creatureTarget->GetMotionMaster()->Clear();
                    creatureTarget->GetMotionMaster()->MoveFleeing(caster);
                    creatureTarget->SetUnitFlag(UNIT_FLAG_NOT_ATTACKABLE_1);
                    creatureTarget->DespawnOrUnsummon(DESPAWN_TIME);
                    caster->KilledMonsterCredit(newEntry);
                }
            }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_q6124_6129_apply_salve::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
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
class spell_q11396_11399_force_shield_arcane_purple_x3 : public AuraScript
{
    PrepareAuraScript(spell_q11396_11399_force_shield_arcane_purple_x3);

    void HandleEffectApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        Unit* target = GetTarget();
        target->SetImmuneToPC(true);
        target->SetControlled(true, UNIT_STATE_STUNNED);
    }

    void HandleEffectRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        GetTarget()->SetImmuneToPC(false);
    }

    void Register() override
    {
        OnEffectApply += AuraEffectApplyFn(spell_q11396_11399_force_shield_arcane_purple_x3::HandleEffectApply, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
        OnEffectRemove += AuraEffectRemoveFn(spell_q11396_11399_force_shield_arcane_purple_x3::HandleEffectRemove, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
    }
};

// 50133 Scourging Crystal Controller
class spell_q11396_11399_scourging_crystal_controller : public SpellScript
{
    PrepareSpellScript(spell_q11396_11399_scourging_crystal_controller);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_FORCE_SHIELD_ARCANE_PURPLE_X3, SPELL_SCOURGING_CRYSTAL_CONTROLLER });
    }

    void HandleDummy(SpellEffIndex /*effIndex*/)
    {
        if (Creature* target = GetHitCreature())
            if (target->HasAura(SPELL_FORCE_SHIELD_ARCANE_PURPLE_X3))
                // Make sure nobody else is channeling the same target
                if (!target->HasAura(SPELL_SCOURGING_CRYSTAL_CONTROLLER))
                    GetCaster()->CastSpell(target, SPELL_SCOURGING_CRYSTAL_CONTROLLER, true, GetCastItem());
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_q11396_11399_scourging_crystal_controller::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

// 43882 Scourging Crystal Controller Dummy
class spell_q11396_11399_scourging_crystal_controller_dummy : public SpellScript
{
    PrepareSpellScript(spell_q11396_11399_scourging_crystal_controller_dummy);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_FORCE_SHIELD_ARCANE_PURPLE_X3 });
    }

    void HandleDummy(SpellEffIndex /*effIndex*/)
    {
        if (Unit* target = GetHitUnit())
            if (target->IsCreature())
                target->RemoveAurasDueToSpell(SPELL_FORCE_SHIELD_ARCANE_PURPLE_X3);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_q11396_11399_scourging_crystal_controller_dummy::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
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

    SpellScript* GetSpellScript() const override
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

class spell_q11587_arcane_prisoner_rescue : public SpellScript
{
    PrepareSpellScript(spell_q11587_arcane_prisoner_rescue);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo(
            {
                SPELL_SUMMON_ARCANE_PRISONER_MALE,
                SPELL_SUMMON_ARCANE_PRISONER_FEMALE,
                SPELL_ARCANE_PRISONER_KILL_CREDIT
            });
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

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_q11587_arcane_prisoner_rescue::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
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

class spell_q11730_ultrasonic_screwdriver : public SpellScript
{
    PrepareSpellScript(spell_q11730_ultrasonic_screwdriver);

    bool Load() override
    {
        return GetCaster()->IsPlayer() && GetCastItem();
    }

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo(
            {
                SPELL_SUMMON_SCAVENGEBOT_004A8,
                SPELL_SUMMON_SENTRYBOT_57K,
                SPELL_SUMMON_DEFENDOTANK_66D,
                SPELL_SUMMON_SCAVENGEBOT_005B6,
                SPELL_SUMMON_55D_COLLECTATRON,
                SPELL_ROBOT_KILL_CREDIT
            });
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
                case NPC_SCAVENGEBOT_004A8:
                    spellId = SPELL_SUMMON_SCAVENGEBOT_004A8;
                    break;
                case NPC_SENTRYBOT_57K:
                    spellId = SPELL_SUMMON_SENTRYBOT_57K;
                    break;
                case NPC_DEFENDOTANK_66D:
                    spellId = SPELL_SUMMON_DEFENDOTANK_66D;
                    break;
                case NPC_SCAVENGEBOT_005B6:
                    spellId = SPELL_SUMMON_SCAVENGEBOT_005B6;
                    break;
                case NPC_55D_COLLECTATRON:
                    spellId = SPELL_SUMMON_55D_COLLECTATRON;
                    break;
                default:
                    return;
            }
            caster->CastSpell(caster, spellId, true, castItem);
            caster->CastSpell(caster, SPELL_ROBOT_KILL_CREDIT, true);
            target->DespawnOrUnsummon();
        }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_q11730_ultrasonic_screwdriver::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
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

class spell_q12459_seeds_of_natures_wrath : public SpellScript
{
    PrepareSpellScript(spell_q12459_seeds_of_natures_wrath);

    void HandleDummy(SpellEffIndex /*effIndex*/)
    {
        if (Creature* creatureTarget = GetHitCreature())
        {
            uint32 uiNewEntry = 0;
            switch (creatureTarget->GetEntry())
            {
                case NPC_REANIMATED_FROSTWYRM:
                    uiNewEntry = NPC_WEAK_REANIMATED_FROSTWYRM;
                    break;
                case NPC_TURGID:
                    uiNewEntry = NPC_WEAK_TURGID;
                    break;
                case NPC_DEATHGAZE:
                    uiNewEntry = NPC_WEAK_DEATHGAZE;
                    break;
            }
            if (uiNewEntry)
                creatureTarget->UpdateEntry(uiNewEntry);
        }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_q12459_seeds_of_natures_wrath::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
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

class spell_q12634_despawn_fruit_tosser : public SpellScript
{
    PrepareSpellScript(spell_q12634_despawn_fruit_tosser);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo(
            {
                SPELL_BANANAS_FALL_TO_GROUND,
                SPELL_ORANGE_FALLS_TO_GROUND,
                SPELL_PAPAYA_FALLS_TO_GROUND,
                SPELL_SUMMON_ADVENTUROUS_DWARF
            });
    }

    void HandleDummy(SpellEffIndex /*effIndex*/)
    {
        uint32 spellId = SPELL_BANANAS_FALL_TO_GROUND;
        switch (urand(0, 3))
        {
            case 1:
                spellId = SPELL_ORANGE_FALLS_TO_GROUND;
                break;
            case 2:
                spellId = SPELL_PAPAYA_FALLS_TO_GROUND;
                break;
        }
        // sometimes, if you're lucky, you get a dwarf
        if (roll_chance_i(5))
            spellId = SPELL_SUMMON_ADVENTUROUS_DWARF;
        GetCaster()->CastSpell(GetCaster(), spellId, true, nullptr);
    }

    void Register() override
    {
        OnEffectHit += SpellEffectFn(spell_q12634_despawn_fruit_tosser::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

// http://www.wowhead.com/quest=12683 Burning to Help
// 52308 Take Sputum Sample
class spell_q12683_take_sputum_sample : public SpellScript
{
    PrepareSpellScript(spell_q12683_take_sputum_sample);

    void HandleDummy(SpellEffIndex /*effIndex*/)
    {
        uint32 reqAuraId = GetSpellInfo()->Effects[EFFECT_1].CalcValue();

        Unit* caster = GetCaster();
        if (caster->HasAuraEffect(reqAuraId, 0))
        {
            uint32 spellId = GetSpellInfo()->Effects[EFFECT_0].CalcValue();
            caster->CastSpell(caster, spellId, true, nullptr);
        }
    }

    void Register() override
    {
        OnEffectHit += SpellEffectFn(spell_q12683_take_sputum_sample::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
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

class spell_q12851_going_bearback : public AuraScript
{
    PrepareAuraScript(spell_q12851_going_bearback);

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

    void Register() override
    {
        AfterEffectApply += AuraEffectApplyFn(spell_q12851_going_bearback::HandleEffectApply, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY, AURA_EFFECT_HANDLE_REAL_OR_REAPPLY_MASK);
    }
};

// http://www.wowhead.com/quest=12937 Relief for the Fallen
// 55804 Healing Finished
enum Quest12937Data
{
    SPELL_TRIGGER_AID_OF_THE_EARTHEN    = 55809,
    NPC_FALLEN_EARTHEN_DEFENDER         = 30035,
};

class spell_q12937_relief_for_the_fallen : public SpellScript
{
    PrepareSpellScript(spell_q12937_relief_for_the_fallen);

    bool Load() override
    {
        return GetCaster()->IsPlayer();
    }

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_TRIGGER_AID_OF_THE_EARTHEN });
    }

    void HandleDummy(SpellEffIndex /*effIndex*/)
    {
        Player* caster = GetCaster()->ToPlayer();
        if (Creature* target = GetHitCreature())
        {
            caster->CastSpell(caster, SPELL_TRIGGER_AID_OF_THE_EARTHEN, true, nullptr);
            caster->KilledMonsterCredit(NPC_FALLEN_EARTHEN_DEFENDER);
            target->DespawnOrUnsummon();
        }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_q12937_relief_for_the_fallen::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

enum Whoarethey
{
    SPELL_MALE_DISGUISE = 38080,
    SPELL_FEMALE_DISGUISE = 38081,
    SPELL_GENERIC_DISGUISE = 32756
};

class spell_q10041_q10040_who_are_they : public SpellScript
{
    PrepareSpellScript(spell_q10041_q10040_who_are_they);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo(
            {
                SPELL_MALE_DISGUISE,
                SPELL_FEMALE_DISGUISE,
                SPELL_GENERIC_DISGUISE
            });
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

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_q10041_q10040_who_are_they::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

enum symboloflife
{
    SPELL_PERMANENT_FEIGN_DEATH = 29266,
};

// 8593 Symbol of life dummy
class spell_symbol_of_life_dummy : public SpellScript
{
    PrepareSpellScript(spell_symbol_of_life_dummy);

    void HandleDummy(SpellEffIndex /*effIndex*/)
    {
        if (Creature* target = GetHitCreature())
        {
            if (target->HasAura(SPELL_PERMANENT_FEIGN_DEATH))
            {
                target->RemoveAurasDueToSpell(SPELL_PERMANENT_FEIGN_DEATH);
                target->ReplaceAllDynamicFlags(0);
                target->ReplaceAllUnitFlags2(UNIT_FLAG2_NONE);
                target->SetHealth(target->GetMaxHealth() / 2);
                target->SetPower(POWER_MANA, uint32(target->GetMaxPower(POWER_MANA) * 0.75f));
            }
        }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_symbol_of_life_dummy::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

// http://www.wowhead.com/quest=12659 Scalps!
// 52090 Ahunae's Knife
enum Quest12659Data
{
    NPC_SCALPS_KC_BUNNY = 28622,
};

class spell_q12659_ahunaes_knife : public SpellScript
{
    PrepareSpellScript(spell_q12659_ahunaes_knife);

    bool Load() override
    {
        return GetCaster()->IsPlayer();
    }

    void HandleDummy(SpellEffIndex /*effIndex*/)
    {
        Player* caster = GetCaster()->ToPlayer();
        if (Creature* target = GetHitCreature())
        {
            target->DespawnOrUnsummon();
            caster->KilledMonsterCredit(NPC_SCALPS_KC_BUNNY);
        }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_q12659_ahunaes_knife::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

enum StoppingTheSpread
{
    NPC_VILLAGER_KILL_CREDIT                     = 18240,
    SPELL_FLAMES                                 = 39199,
};

class spell_q9874_liquid_fire : public SpellScript
{
    PrepareSpellScript(spell_q9874_liquid_fire);

    bool Load() override
    {
        return GetCaster()->IsPlayer();
    }

    void HandleDummy(SpellEffIndex /*effIndex*/)
    {
        Player* caster = GetCaster()->ToPlayer();
        if (Creature* target = GetHitCreature())
            if (target && !target->HasAura(SPELL_FLAMES))
            {
                caster->KilledMonsterCredit(NPC_VILLAGER_KILL_CREDIT);
                target->CastSpell(target, SPELL_FLAMES, true);
                target->DespawnOrUnsummon(20000);
            }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_q9874_liquid_fire::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

enum SalvagingLifesStength
{
    NPC_SHARD_KILL_CREDIT                        = 29303,
};

class spell_q12805_lifeblood_dummy : public SpellScript
{
    PrepareSpellScript(spell_q12805_lifeblood_dummy);

    bool Load() override
    {
        return GetCaster()->IsPlayer();
    }

    void HandleScript(SpellEffIndex /*effIndex*/)
    {
        Player* caster = GetCaster()->ToPlayer();
        if (Creature* target = GetHitCreature())
        {
            caster->KilledMonsterCredit(NPC_SHARD_KILL_CREDIT);
            target->CastSpell(target, uint32(GetEffectValue()), true);
            target->DespawnOrUnsummon(2000);
        }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_q12805_lifeblood_dummy::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
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

class spell_q13280_13283_plant_battle_standard : public SpellScript
{
    PrepareSpellScript(spell_q13280_13283_plant_battle_standard);

    void HandleDummy(SpellEffIndex /*effIndex*/)
    {
        Unit* caster = GetCaster();
        if (caster->IsVehicle())
            if (Unit* player = caster->GetVehicleKit()->GetPassenger(0))
                player->ToPlayer()->KilledMonsterCredit(NPC_KING_OF_THE_MOUNTAINT_KC);
    }

    void Register() override
    {
        OnEffectHit += SpellEffectFn(spell_q13280_13283_plant_battle_standard::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

enum ChumTheWaterSummons
{
    SUMMON_ANGRY_KVALDIR = 66737,
    SUMMON_NORTH_SEA_MAKO = 66738,
    SUMMON_NORTH_SEA_THRESHER = 66739,
    SUMMON_NORTH_SEA_BLUE_SHARK = 66740
};

class spell_q14112_14145_chum_the_water : public SpellScript
{
    PrepareSpellScript(spell_q14112_14145_chum_the_water);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo(
            {
                SUMMON_ANGRY_KVALDIR,
                SUMMON_NORTH_SEA_MAKO,
                SUMMON_NORTH_SEA_THRESHER,
                SUMMON_NORTH_SEA_BLUE_SHARK
            });
    }

    void HandleScriptEffect(SpellEffIndex /*effIndex*/)
    {
        Unit* caster = GetCaster();
        caster->CastSpell(caster, RAND(SUMMON_ANGRY_KVALDIR, SUMMON_NORTH_SEA_MAKO, SUMMON_NORTH_SEA_THRESHER, SUMMON_NORTH_SEA_BLUE_SHARK));
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_q14112_14145_chum_the_water::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
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

class spell_q9452_cast_net : public SpellScript
{
    PrepareSpellScript(spell_q9452_cast_net);

    bool Load() override
    {
        return GetCaster()->IsPlayer();
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

    void Register() override
    {
        OnCheckCast += SpellCheckCastFn(spell_q9452_cast_net::CheckCast);
        OnEffectHit += SpellEffectFn(spell_q9452_cast_net::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
        OnEffectHitTarget += SpellEffectFn(spell_q9452_cast_net::HandleActiveObject, EFFECT_1, SPELL_EFFECT_ACTIVATE_OBJECT);
    }
};

enum HodirsHelm
{
    SAY_1               = 1,
    SAY_2               = 2,
    NPC_KILLCREDIT      = 30210, // Hodir's Helm KC Bunny
    NPC_ICE_SPIKE_BUNNY = 30215
};

class spell_q12987_read_pronouncement : public AuraScript
{
    PrepareAuraScript(spell_q12987_read_pronouncement);

    void OnApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        // player must cast kill credit and do emote text, according to sniff
        if (Player* target = GetTarget()->ToPlayer())
        {
            if (Creature* trigger = target->FindNearestCreature(NPC_ICE_SPIKE_BUNNY, 25.0f))
            {
                sCreatureTextMgr->SendChat(trigger, SAY_1, target, CHAT_MSG_ADDON, LANG_ADDON, TEXT_RANGE_NORMAL, 0, TEAM_NEUTRAL, false, target);
                target->KilledMonsterCredit(NPC_KILLCREDIT);
                sCreatureTextMgr->SendChat(trigger, SAY_2, target, CHAT_MSG_ADDON, LANG_ADDON, TEXT_RANGE_NORMAL, 0, TEAM_NEUTRAL, false, target);
            }
        }
    }

    void Register() override
    {
        AfterEffectApply += AuraEffectApplyFn(spell_q12987_read_pronouncement::OnApply, EFFECT_0, SPELL_AURA_NONE, AURA_EFFECT_HANDLE_REAL);
    }
};

enum LeaveNothingToChance
{
    NPC_UPPER_MINE_SHAFT            = 27436,
    NPC_LOWER_MINE_SHAFT            = 27437,

    SPELL_UPPER_MINE_SHAFT_CREDIT   = 48744,
    SPELL_LOWER_MINE_SHAFT_CREDIT   = 48745,
};

class spell_q12277_wintergarde_mine_explosion : public SpellScript
{
    PrepareSpellScript(spell_q12277_wintergarde_mine_explosion);

    void HandleDummy(SpellEffIndex /*effIndex*/)
    {
        if (Creature* unitTarget = GetHitCreature())
        {
            if (Unit* caster = GetCaster())
            {
                if (caster->IsCreature())
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

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_q12277_wintergarde_mine_explosion::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

enum FocusOnTheBeach
{
    SPELL_BUNNY_CREDIT_BEAM = 47390,
};

class spell_q12066_bunny_kill_credit : public SpellScript
{
    PrepareSpellScript(spell_q12066_bunny_kill_credit);

    void HandleDummy(SpellEffIndex /*effIndex*/)
    {
        if (Creature* target = GetHitCreature())
            target->CastSpell(GetCaster(), SPELL_BUNNY_CREDIT_BEAM, false);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_q12066_bunny_kill_credit::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
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

class spell_q12735_song_of_cleansing : public SpellScript
{
    PrepareSpellScript(spell_q12735_song_of_cleansing);

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

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_q12735_song_of_cleansing::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
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
class spell_q11010_q11102_q11023_aggro_check_aura : public AuraScript
{
    PrepareAuraScript(spell_q11010_q11102_q11023_aggro_check_aura);

    void HandleTriggerSpell(AuraEffect const* /*aurEff*/)
    {
        if (Unit* target = GetTarget())
            // On trigger proccing
            target->CastSpell(target, SPELL_AGGRO_CHECK);
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_q11010_q11102_q11023_aggro_check_aura::HandleTriggerSpell, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
    }
};

// 40112 Knockdown Fel Cannon: The Aggro Check
class spell_q11010_q11102_q11023_aggro_check : public SpellScript
{
    PrepareSpellScript(spell_q11010_q11102_q11023_aggro_check);

    void HandleDummy(SpellEffIndex /*effIndex*/)
    {
        if (Player* playerTarget = GetHitPlayer())
            // Check if found player target is on fly mount or using flying form
            if (playerTarget->HasAuraType(SPELL_AURA_FLY) || playerTarget->HasAuraType(SPELL_AURA_MOD_INCREASE_MOUNTED_FLIGHT_SPEED))
                playerTarget->CastSpell(playerTarget, SPELL_FLAK_CANNON_TRIGGER, TRIGGERED_FULL_MASK);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_q11010_q11102_q11023_aggro_check::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

// 40119 Knockdown Fel Cannon: The Aggro Burst
class spell_q11010_q11102_q11023_aggro_burst : public AuraScript
{
    PrepareAuraScript(spell_q11010_q11102_q11023_aggro_burst);

    void HandleEffectPeriodic(AuraEffect const* /*aurEff*/)
    {
        if (Unit* target = GetTarget())
            // On each tick cast Choose Loc to trigger summon
            target->CastSpell(target, SPELL_CHOOSE_LOC);
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_q11010_q11102_q11023_aggro_burst::HandleEffectPeriodic, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY);
    }
};

// 40056 Knockdown Fel Cannon: Choose Loc
class spell_q11010_q11102_q11023_choose_loc : public SpellScript
{
    PrepareSpellScript(spell_q11010_q11102_q11023_choose_loc);

    void HandleDummy(SpellEffIndex /*effIndex*/)
    {
        Unit* caster = GetCaster();
        // Check for player that is in 65 y range
        std::list<Player*> playerList;
        Acore::AnyPlayerInObjectRangeCheck checker(caster, 65.0f);
        Acore::PlayerListSearcher<Acore::AnyPlayerInObjectRangeCheck> searcher(caster, playerList, checker);
        Cell::VisitWorldObjects(caster, searcher, 65.0f);
        for (std::list<Player*>::const_iterator itr = playerList.begin(); itr != playerList.end(); ++itr)
            // Check if found player target is on fly mount or using flying form
            if ((*itr)->HasAuraType(SPELL_AURA_FLY) || (*itr)->HasAuraType(SPELL_AURA_MOD_INCREASE_MOUNTED_FLIGHT_SPEED))
                // Summom Fel Cannon (bunny version) at found player
                caster->SummonCreature(NPC_FEL_CANNON2, (*itr)->GetPositionX(), (*itr)->GetPositionY(), (*itr)->GetPositionZ());
    }

    void Register() override
    {
        OnEffectHit += SpellEffectFn(spell_q11010_q11102_q11023_choose_loc::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

// 39844 - Skyguard Blasting Charge
// 40160 - Throw Bomb
class spell_q11010_q11102_q11023_q11008_check_fly_mount : public SpellScript
{
    PrepareSpellScript(spell_q11010_q11102_q11023_q11008_check_fly_mount);

    SpellCastResult CheckRequirement()
    {
        Unit* caster = GetCaster();
        // This spell will be cast only if caster has one of these auras
        if (!(caster->HasAuraType(SPELL_AURA_FLY) || caster->HasAuraType(SPELL_AURA_MOD_INCREASE_MOUNTED_FLIGHT_SPEED)))
            return SPELL_FAILED_CANT_DO_THAT_RIGHT_NOW;
        return SPELL_CAST_OK;
    }

    void Register() override
    {
        OnCheckCast += SpellCheckCastFn(spell_q11010_q11102_q11023_q11008_check_fly_mount::CheckRequirement);
    }
};

// 55368 - Summon Stefan
    class spell_q12661_q12669_q12676_q12677_q12713_summon_stefan : public SpellScript
    {
        PrepareSpellScript(spell_q12661_q12669_q12676_q12677_q12713_summon_stefan);

        void SetDest(SpellDestination& dest)
        {
            // Adjust effect summon position
            Position const offset = { 0.0f, 0.0f, 20.0f, 0.0f };
            dest.RelocateOffset(offset);
        }

        void Register() override
        {
            OnDestinationTargetSelect += SpellDestinationTargetSelectFn(spell_q12661_q12669_q12676_q12677_q12713_summon_stefan::SetDest, EFFECT_0, TARGET_DEST_CASTER_BACK);
        }
    };

enum QuenchingMist
{
    SPELL_FLICKERING_FLAMES = 53504
};

    class spell_q12730_quenching_mist : public AuraScript
    {
        PrepareAuraScript(spell_q12730_quenching_mist);

        bool Validate(SpellInfo const* /*spellInfo*/) override
        {
            return ValidateSpellInfo({ SPELL_FLICKERING_FLAMES });
        }

        void HandleEffectPeriodic(AuraEffect const* /*aurEff*/)
        {
            GetTarget()->RemoveAurasDueToSpell(SPELL_FLICKERING_FLAMES);
        }

        void Register() override
        {
            OnEffectPeriodic += AuraEffectPeriodicFn(spell_q12730_quenching_mist::HandleEffectPeriodic, EFFECT_0, SPELL_AURA_PERIODIC_HEAL);
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

    class spell_q13291_q13292_q13239_q13261_frostbrood_skytalon_grab_decoy : public SpellScript
    {
        PrepareSpellScript(spell_q13291_q13292_q13239_q13261_frostbrood_skytalon_grab_decoy);

        bool Validate(SpellInfo const* /*spell*/) override
        {
            return ValidateSpellInfo({ SPELL_RIDE });
        }

        void HandleDummy(SpellEffIndex /*effIndex*/)
        {
            if (!GetHitCreature())
                return;
            // TO DO: Being triggered is hack, but in checkcast it doesn't pass aurastate requirements.
            // Beside that the decoy won't keep it's freeze animation state when enter.
            GetHitCreature()->CastSpell(GetCaster(), SPELL_RIDE, true);
        }

        void Register() override
        {
            OnEffectHitTarget += SpellEffectFn(spell_q13291_q13292_q13239_q13261_frostbrood_skytalon_grab_decoy::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
        }
    };

// 59303 - Summon Frost Wyrm
    class spell_q13291_q13292_q13239_q13261_armored_decoy_summon_skytalon : public SpellScript
    {
        PrepareSpellScript(spell_q13291_q13292_q13239_q13261_armored_decoy_summon_skytalon);

        void SetDest(SpellDestination& dest)
        {
            // Adjust effect summon position
            Position const offset = { 0.0f, 0.0f, 20.0f, 0.0f };
            dest.RelocateOffset(offset);
        }

        void Register() override
        {
            OnDestinationTargetSelect += SpellDestinationTargetSelectFn(spell_q13291_q13292_q13239_q13261_armored_decoy_summon_skytalon::SetDest, EFFECT_0, TARGET_DEST_CASTER_BACK);
        }
    };

enum BearFlankMaster
{
    SPELL_BEAR_FLANK_MASTER = 56565,
    SPELL_CREATE_BEAR_FLANK = 56566,
    SPELL_BEAR_FLANK_FAIL = 56569
};

    class spell_q13011_bear_flank_master : public SpellScript
    {
        PrepareSpellScript(spell_q13011_bear_flank_master);

        bool Validate(SpellInfo const* /*spellInfo*/) override
        {
            return ValidateSpellInfo({ SPELL_BEAR_FLANK_MASTER, SPELL_CREATE_BEAR_FLANK });
        }

        bool Load() override
        {
            return GetCaster()->IsCreature();
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

        void Register() override
        {
            OnEffectHitTarget += SpellEffectFn(spell_q13011_bear_flank_master::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
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

class spell_q12690_burst_at_the_seams : public SpellScript
{
    PrepareSpellScript(spell_q12690_burst_at_the_seams);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo(
            {
                SPELL_BURST_AT_THE_SEAMS,
                SPELL_BURST_AT_THE_SEAMS_DMG,
                SPELL_BURST_AT_THE_SEAMS_DMG_2,
                SPELL_BURST_AT_THE_SEAMS_BONE,
                SPELL_BURST_AT_THE_SEAMS_MEAT,
                SPELL_BURST_AT_THE_SEAMS_BMEAT
            });
    }

    bool Load() override
    {
        return GetCaster()->IsCreature();
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

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_q12690_burst_at_the_seams::HandleKnockBack, EFFECT_1, SPELL_EFFECT_KNOCK_BACK);
        OnEffectHitTarget += SpellEffectFn(spell_q12690_burst_at_the_seams::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

enum EscapeFromSilverbrook
{
    SPELL_SUMMON_WORGEN = 48681
};

// 48682 - Escape from Silverbrook - Periodic Dummy
class spell_q12308_escape_from_silverbrook : public SpellScript
{
    PrepareSpellScript(spell_q12308_escape_from_silverbrook);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_SUMMON_WORGEN });
    }

    void HandleDummy(SpellEffIndex /*effIndex*/)
    {
        GetCaster()->CastSpell(GetCaster(), SPELL_SUMMON_WORGEN, true);
    }

    void Register() override
    {
        OnEffectHit += SpellEffectFn(spell_q12308_escape_from_silverbrook::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

// 48681 - Summon Silverbrook Worgen
class spell_q12308_escape_from_silverbrook_summon_worgen : public SpellScript
{
    PrepareSpellScript(spell_q12308_escape_from_silverbrook_summon_worgen);

    void ModDest(SpellDestination& dest)
    {
        float dist = GetSpellInfo()->Effects[EFFECT_0].CalcRadius(GetCaster());
        float angle = frand(0.75f, 1.25f) * M_PI;

        Position pos = GetCaster()->GetNearPosition(dist, angle);
        dest.Relocate(pos);
    }

    void Register() override
    {
        OnDestinationTargetSelect += SpellDestinationTargetSelectFn(spell_q12308_escape_from_silverbrook_summon_worgen::ModDest, EFFECT_0, TARGET_DEST_CASTER_SUMMON);
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
class spell_q12641_death_comes_from_on_high : public SpellScript
{
    PrepareSpellScript(spell_q12641_death_comes_from_on_high);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo(
            {
                SPELL_FORGE_CREDIT,
                SPELL_TOWN_HALL_CREDIT,
                SPELL_SCARLET_HOLD_CREDIT,
                SPELL_CHAPEL_CREDIT
            });
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

        GetCaster()->CastSpell((Unit*)nullptr, spellId, true);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_q12641_death_comes_from_on_high::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

// 51769 - Emblazon Runeblade
class spell_q12619_emblazon_runeblade : public AuraScript
{
    PrepareAuraScript(spell_q12619_emblazon_runeblade);

    void HandleEffectPeriodic(AuraEffect const* aurEff)
    {
        PreventDefaultAction();
        if (Unit* caster = GetCaster())
            caster->CastSpell(caster, GetSpellInfo()->Effects[aurEff->GetEffIndex()].TriggerSpell, true, nullptr, aurEff);
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_q12619_emblazon_runeblade::HandleEffectPeriodic, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
    }
};

// 51770 - Emblazon Runeblade
class spell_q12619_emblazon_runeblade_effect : public SpellScript
{
    PrepareSpellScript(spell_q12619_emblazon_runeblade_effect);

    void HandleScript(SpellEffIndex /*effIndex*/)
    {
        GetCaster()->CastSpell(GetCaster(), uint32(GetEffectValue()), false);
    }

    void Register() override
    {
        OnEffectHit += SpellEffectFn(spell_q12619_emblazon_runeblade_effect::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

enum Quest_The_Storm_King
{
    SPELL_RIDE_GYMER            = 43671,
    SPELL_GRABBED               = 55424
};

class spell_q12919_gymers_grab : public SpellScript
{
    PrepareSpellScript(spell_q12919_gymers_grab);

    bool Validate(SpellInfo const* /*spell*/) override
    {
        return ValidateSpellInfo({ SPELL_RIDE_GYMER });
    }

    void HandleScript(SpellEffIndex /*effIndex*/)
    {
        int8 seatId = 2;
        if (!GetHitCreature())
            return;
        GetHitCreature()->CastCustomSpell(SPELL_RIDE_GYMER, SPELLVALUE_BASE_POINT0, seatId, GetCaster(), true);
        GetHitCreature()->CastSpell(GetHitCreature(), SPELL_GRABBED, true);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_q12919_gymers_grab::HandleScript, EFFECT_0,  SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

enum Quest_The_Storm_King_Throw
{
    SPELL_VARGUL_EXPLOSION      = 55569
};

class spell_q12919_gymers_throw : public SpellScript
{
    PrepareSpellScript(spell_q12919_gymers_throw);

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

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_q12919_gymers_throw::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

#define QUEST_CROW_TRANSFORM 9718

// spell 38776
    class spell_q9718_crow_transform : public AuraScript
    {
        PrepareAuraScript(spell_q9718_crow_transform)

        void HandleEffectRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
        {
            if (GetOwner())
                if (Player* player = GetOwner()->ToPlayer())
                    player->CompleteQuest(QUEST_CROW_TRANSFORM);
        }

        void Register() override
        {
            OnEffectRemove += AuraEffectRemoveFn(spell_q9718_crow_transform::HandleEffectRemove, EFFECT_0, SPELL_AURA_TRANSFORM, AURA_EFFECT_HANDLE_REAL_OR_REAPPLY_MASK);
        }
    };

enum QuestShyRotam
{
    NPC_SHY_ROTAM = 10737,
};

// 16796 - Summon Shy-Rotam
class spell_q5056_summon_shy_rotam : public SpellScript
{
    PrepareSpellScript(spell_q5056_summon_shy_rotam);

    void HandleFinish()
    {
        Position shyRotamSpawnPosition = Position(8072.38f, -3833.81f, 690.03f, 4.56f);
        if (Creature* summon = GetCaster()->SummonCreature(NPC_SHY_ROTAM, shyRotamSpawnPosition, TEMPSUMMON_TIMED_DESPAWN, 15 * MINUTE * IN_MILLISECONDS))
        {
            summon->AI()->AttackStart(GetCaster());
        }
    }

    void Register() override
    {
        AfterCast += SpellCastFn(spell_q5056_summon_shy_rotam::HandleFinish);
    }
};

enum RookeryEgg
{
    ITEM_COLLECTED_DRAGON_EGG   = 12241,
    QUEST_EGG_COLLECTION        = 4735,
    GO_ROOKERY_EGG              = 175124
};

class spell_q4735_collect_rookery_egg : public SpellScript
{
    PrepareSpellScript(spell_q4735_collect_rookery_egg);

    SpellCastResult CheckCast()
    {
        if (GameObject* rookery = GetCaster()->FindNearestGameObject(GO_ROOKERY_EGG, 5.0f, true))
        {
            if (rookery->GetGoState() != GO_STATE_ACTIVE_ALTERNATIVE)
                return SPELL_FAILED_BAD_TARGETS;
        }
        return SPELL_CAST_OK;
    }

    SpellCastResult CheckQuest()
    {
        if (Player* playerCaster = GetCaster()->ToPlayer())
        {
            if (playerCaster->GetQuestStatus(QUEST_EGG_COLLECTION) == QUEST_STATUS_INCOMPLETE)
                return SPELL_CAST_OK;
        }
        return SPELL_FAILED_DONT_REPORT;
    }

    void HandleActiveObject(SpellEffIndex /*effIndex*/)
    {
        if (Player* playerCaster = GetCaster()->ToPlayer())
            playerCaster->AddItem(ITEM_COLLECTED_DRAGON_EGG, 1);
    }

    void Register() override
    {
        OnCheckCast += SpellCheckCastFn(spell_q4735_collect_rookery_egg::CheckQuest);
        OnCheckCast += SpellCheckCastFn(spell_q4735_collect_rookery_egg::CheckCast);
        OnEffectHit += SpellEffectFn(spell_q4735_collect_rookery_egg::HandleActiveObject, EFFECT_0, SPELL_EFFECT_ACTIVATE_OBJECT);
    }
};

enum BookOfFelNames
{
    SPELL_METAMORPHOSIS   = 36298
};

class spell_q10651_q10692_book_of_fel_names : public SpellScript
{
    PrepareSpellScript(spell_q10651_q10692_book_of_fel_names);

    void HandleScript(SpellEffIndex /*effIndex*/)
    {
        if (GetHitUnit()->HasAura(SPELL_METAMORPHOSIS))
            GetHitUnit()->RemoveAurasDueToSpell(SPELL_METAMORPHOSIS);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_q10651_q10692_book_of_fel_names::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

enum Feralfen
{
    NPC_FERALFEN_TOTEM    = 18186
};

class spell_q9847_a_spirit_ally : public SpellScript
{
    PrepareSpellScript(spell_q9847_a_spirit_ally);

    void HandleSendEvent(SpellEffIndex /*effIndex*/)
    {
        float dist = 5.0f;
        float angle = GetCaster()->GetOrientation() - 1.25f;
        Position pos = GetCaster()->GetNearPosition(dist, angle);
        GetCaster()->SummonCreature(NPC_FERALFEN_TOTEM, pos, TEMPSUMMON_TIMED_DESPAWN, 1 * MINUTE * IN_MILLISECONDS);
    }

    void Register() override
    {
        OnEffectHit += SpellEffectFn(spell_q9847_a_spirit_ally::HandleSendEvent, EFFECT_0, SPELL_EFFECT_SEND_EVENT);
    }
};

void AddSC_quest_spell_scripts()
{
    RegisterSpellAndAuraScriptPair(spell_q11065_wrangle_some_aether_rays, spell_q11065_wrangle_some_aether_rays_aura);
    RegisterSpellScript(spell_image_of_drakuru_reagent_check);
    RegisterSpellScript(spell_q12014_steady_as_a_rock);
    RegisterSpellAndAuraScriptPair(spell_q11026_a11051_banish_the_demons, spell_q11026_a11051_banish_the_demons_aura);
    RegisterSpellScript(spell_q10525_vision_guide);
    RegisterSpellScript(spell_q11322_q11317_the_cleansing);
    RegisterSpellScript(spell_q10714_on_spirits_wings);
    RegisterSpellScript(spell_q10720_the_smallest_creature);
    RegisterSpellScript(spell_q13086_last_line_of_defence);
    RegisterSpellScript(spell_q12943_shadow_vault_decree);
    RegisterSpellAndAuraScriptPair(spell_q10769_dissension_amongst_the_ranks, spell_q10769_dissension_amongst_the_ranks_aura);
    RegisterSpellScript(spell_q11520_discovering_your_roots);
    RegisterSpellScript(spell_q11670_it_was_the_orcs_honest);
    RegisterSpellScript(spell_quest_test_flight_charging);
    RegisterSpellScript(spell_q12274_a_fall_from_grace_costume);
    RegisterSpellScript(spell_q13369_fate_up_against_your_will);
    RegisterSpellScript(spell_q11198_take_down_tethyr);
    RegisterSpellScript(spell_q11653_youre_not_so_big_now);
    RegisterSpellScript(spell_q10985_light_of_the_naaru);
    RegisterSpellScript(spell_q9718_crow_transform);
    new spell_q55_sacred_cleansing();
    RegisterSpellScript(spell_q1846_bending_shinbone);
    RegisterSpellScript(spell_q2203_thaumaturgy_channel);
    RegisterSpellScript(spell_q5206_test_fetid_skull);
    RegisterSpellScript(spell_q6124_6129_apply_salve);
    RegisterSpellScript(spell_q11396_11399_force_shield_arcane_purple_x3);
    RegisterSpellScript(spell_q11396_11399_scourging_crystal_controller);
    RegisterSpellScript(spell_q11396_11399_scourging_crystal_controller_dummy);
    new spell_q11515_fel_siphon_dummy();
    RegisterSpellScript(spell_q11587_arcane_prisoner_rescue);
    RegisterSpellScript(spell_q11730_ultrasonic_screwdriver);
    RegisterSpellScript(spell_q12459_seeds_of_natures_wrath);
    RegisterSpellScript(spell_q12634_despawn_fruit_tosser);
    RegisterSpellScript(spell_q12683_take_sputum_sample);
    RegisterSpellScript(spell_q12851_going_bearback);
    RegisterSpellScript(spell_q12937_relief_for_the_fallen);
    RegisterSpellScript(spell_q10041_q10040_who_are_they);
    RegisterSpellScript(spell_symbol_of_life_dummy);
    RegisterSpellScript(spell_q12659_ahunaes_knife);
    RegisterSpellScript(spell_q9874_liquid_fire);
    RegisterSpellScript(spell_q12805_lifeblood_dummy);
    RegisterSpellScript(spell_q13280_13283_plant_battle_standard);
    RegisterSpellScript(spell_q14112_14145_chum_the_water);
    RegisterSpellScript(spell_q9452_cast_net);
    RegisterSpellScript(spell_q12987_read_pronouncement);
    RegisterSpellScript(spell_q12277_wintergarde_mine_explosion);
    RegisterSpellScript(spell_q12066_bunny_kill_credit);
    RegisterSpellScript(spell_q12735_song_of_cleansing);
    RegisterSpellScript(spell_q11010_q11102_q11023_aggro_check_aura);
    RegisterSpellScript(spell_q11010_q11102_q11023_aggro_check);
    RegisterSpellScript(spell_q11010_q11102_q11023_aggro_burst);
    RegisterSpellScript(spell_q11010_q11102_q11023_choose_loc);
    RegisterSpellScript(spell_q11010_q11102_q11023_q11008_check_fly_mount);
    RegisterSpellScript(spell_q12661_q12669_q12676_q12677_q12713_summon_stefan);
    RegisterSpellScript(spell_q12730_quenching_mist);
    RegisterSpellScript(spell_q13291_q13292_q13239_q13261_frostbrood_skytalon_grab_decoy);
    RegisterSpellScript(spell_q13291_q13292_q13239_q13261_armored_decoy_summon_skytalon);
    RegisterSpellScript(spell_q13011_bear_flank_master);
    RegisterSpellScript(spell_q12690_burst_at_the_seams);
    RegisterSpellScript(spell_q12308_escape_from_silverbrook_summon_worgen);
    RegisterSpellScript(spell_q12308_escape_from_silverbrook);
    RegisterSpellScript(spell_q12641_death_comes_from_on_high);
    RegisterSpellScript(spell_q12619_emblazon_runeblade);
    RegisterSpellScript(spell_q12619_emblazon_runeblade_effect);
    RegisterSpellScript(spell_q12919_gymers_grab);
    RegisterSpellScript(spell_q12919_gymers_throw);
    RegisterSpellScript(spell_q5056_summon_shy_rotam);
    RegisterSpellScript(spell_q4735_collect_rookery_egg);
    RegisterSpellScript(spell_q10651_q10692_book_of_fel_names);
    RegisterSpellScript(spell_q9847_a_spirit_ally);
}

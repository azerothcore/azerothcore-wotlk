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

#include "CreatureScript.h"
#include "PassiveAI.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "SpellAuraEffects.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "sunwell_plateau.h"

enum Spells
{
    SPELL_ENRAGE                        = 26662,
    SPELL_NEGATIVE_ENERGY               = 46009,
    SPELL_SUMMON_BLOOD_ELVES_PERIODIC   = 46041,
    SPELL_OPEN_PORTAL_PERIODIC          = 45994,
    SPELL_DARKNESS_PERIODIC             = 45998,
    SPELL_SUMMON_BERSERKER1             = 46037,
    SPELL_SUMMON_FURY_MAGE1             = 46038,
    SPELL_SUMMON_FURY_MAGE2             = 46039,
    SPELL_SUMMON_BERSERKER2             = 46040,
    SPELL_SUMMON_DARK_FIEND             = 46000, // till 46007
    SPELL_OPEN_ALL_PORTALS              = 46177,
    SPELL_SUMMON_ENTROPIUS              = 46217,

    // Entropius's spells
    SPELL_ENTROPIUS_COSMETIC_SPAWN      = 46223,
    SPELL_NEGATIVE_ENERGY_PERIODIC      = 46284,
    SPELL_BLACK_HOLE                    = 46282,
    SPELL_DARKNESS                      = 46268,
    SPELL_SUMMON_DARK_FIEND_ENTROPIUS   = 46263,

    //Black Hole Spells
    SPELL_BLACK_HOLE_SUMMON_VISUAL      = 46242,
    SPELL_BLACK_HOLE_SUMMON_VISUAL2     = 46248,
    SPELL_BLACK_HOLE_VISUAL2            = 46235,
    SPELL_BLACK_HOLE_PASSIVE            = 46228,
    SPELL_BLACK_HOLE_EFFECT             = 46230
};

struct boss_muru : public BossAI
{
    boss_muru(Creature* creature) : BossAI(creature, DATA_MURU) { }

    void Reset() override
    {
        BossAI::Reset();
        me->SetReactState(REACT_AGGRESSIVE);
        me->RemoveUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
        me->SetVisible(true);
        me->m_Events.KillAllEvents(false);
    }

    void JustEngagedWith(Unit* who) override
    {
        BossAI::JustEngagedWith(who);
        DoCastSelf(SPELL_NEGATIVE_ENERGY, true);
        DoCastSelf(SPELL_SUMMON_BLOOD_ELVES_PERIODIC, true);
        DoCastSelf(SPELL_OPEN_PORTAL_PERIODIC, true);
        DoCastSelf(SPELL_DARKNESS_PERIODIC, true);

        me->m_Events.AddEventAtOffset([&] {
            DoCastSelf(SPELL_ENRAGE, true);

            if (Creature* entropius = summons.GetCreatureWithEntry(NPC_ENTROPIUS))
                entropius->CastSpell(entropius, SPELL_ENRAGE, true);
        }, 10min);
    }

    void JustSummoned(Creature* creature) override
    {
        if (creature->GetEntry() == NPC_ENTROPIUS)
            creature->SetInCombatWithZone();
        else
            BossAI::JustSummoned(creature);
    }

    void DamageTaken(Unit*, uint32& damage, DamageEffectType, SpellSchoolMask) override
    {
        if (damage >= me->GetHealth())
        {
            damage = me->GetHealth() - 1;
            if (!me->HasUnitFlag(UNIT_FLAG_NOT_SELECTABLE))
            {
                me->SetUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
                me->RemoveAllAuras();
                DoCastSelf(SPELL_OPEN_ALL_PORTALS, true);

                me->m_Events.AddEventAtOffset([&]
                {
                    DoCastAOE(SPELL_SUMMON_ENTROPIUS);
                }, 7s);

                me->m_Events.AddEventAtOffset([&]
                {
                    me->SetVisible(false);
                }, 8s);
            }
        }
    }
};

struct boss_entropius : public ScriptedAI
{
    boss_entropius(Creature* creature) : ScriptedAI(creature) { }

    void Reset() override
    {
        scheduler.CancelAll();

        DoCastSelf(SPELL_ENTROPIUS_COSMETIC_SPAWN);
        DoCastSelf(SPELL_NEGATIVE_ENERGY_PERIODIC, true);

        me->SetReactState(REACT_PASSIVE);

        me->m_Events.AddEventAtOffset([&] {
            me->SetReactState(REACT_AGGRESSIVE);
            me->SetInCombatWithZone();
            AttackStart(SelectTargetFromPlayerList(50.0f));
        }, 3s);
    }

    void EnterEvadeMode(EvadeReason why) override
    {
        if (InstanceScript* instance = me->GetInstanceScript())
            if (Creature* muru = instance->GetCreature(DATA_MURU))
                if (!muru->IsInEvadeMode())
                    muru->AI()->EnterEvadeMode(why);

        me->DespawnOrUnsummon();
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        ScheduleTimedEvent(10s, [&] {
            DoCastRandomTarget(SPELL_DARKNESS, 0, 50.0f, true, true);
        }, 15s);

        ScheduleTimedEvent(15s, [&] {
            DoCastRandomTarget(SPELL_BLACK_HOLE, 0, 50.0f, true, true);
        }, 15s);
    }

    void JustDied(Unit* /*killer*/) override
    {
        if (InstanceScript* instance = me->GetInstanceScript())
            if (Creature* muru = instance->GetCreature(DATA_MURU))
                muru->KillSelf();
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;

        scheduler.Update(diff);
    }
};

struct npc_singularity : public NullCreatureAI
{
    npc_singularity(Creature* creature) : NullCreatureAI(creature) { }

    void Reset() override
    {
        me->DespawnOrUnsummon(18000);
        DoCastSelf(SPELL_BLACK_HOLE_SUMMON_VISUAL, true);
        DoCastSelf(SPELL_BLACK_HOLE_SUMMON_VISUAL2, true);

        me->m_Events.AddEventAtOffset([&] {
            me->KillSelf();
        }, 17s);

        me->m_Events.AddEventAtOffset([&] {
            me->RemoveAurasDueToSpell(SPELL_BLACK_HOLE_SUMMON_VISUAL2);
            DoCastSelf(SPELL_BLACK_HOLE_VISUAL2, true);
            DoCastSelf(SPELL_BLACK_HOLE_PASSIVE, true);
        }, 3500ms);

        scheduler.Schedule(5s, [this](TaskContext context)
        {
            auto const& playerList = me->GetMap()->GetPlayers();
            for (auto const& playerRef : playerList)
            {
                if (Player* player = playerRef.GetSource())
                    if (me->GetDistance2d(player) < 15.0f && player->GetPositionZ() < 72.0f && player->IsAlive() && !player->HasAura(SPELL_BLACK_HOLE_EFFECT))
                    {
                        me->GetMotionMaster()->MovePoint(0, player->GetPositionX(), player->GetPositionY(), player->GetPositionZ(), false, true);
                        context.Repeat();
                        return;
                    }
            }

            context.Repeat(1s);
        });
    }

    void UpdateAI(uint32 diff) override
    {
        scheduler.Update(diff);
    }
};

class spell_muru_summon_blood_elves_periodic_aura : public AuraScript
{
    PrepareAuraScript(spell_muru_summon_blood_elves_periodic_aura);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_SUMMON_FURY_MAGE1, SPELL_SUMMON_FURY_MAGE2, SPELL_SUMMON_BERSERKER1, SPELL_SUMMON_BERSERKER2 });
    }

    void HandleApply(AuraEffect const* aurEff, AuraEffectHandleModes /*mode*/)
    {
        // first tick after 10 seconds
        GetAura()->GetEffect(aurEff->GetEffIndex())->SetPeriodicTimer(10000);
    }

    void OnPeriodic(AuraEffect const*  /*aurEff*/)
    {
        GetUnitOwner()->CastSpell(GetUnitOwner(), SPELL_SUMMON_FURY_MAGE1, true);
        GetUnitOwner()->CastSpell(GetUnitOwner(), SPELL_SUMMON_FURY_MAGE2, true);
        GetUnitOwner()->CastSpell(GetUnitOwner(), SPELL_SUMMON_BERSERKER1, true);
        GetUnitOwner()->CastSpell(GetUnitOwner(), SPELL_SUMMON_BERSERKER2, true);
        GetUnitOwner()->CastSpell(GetUnitOwner(), SPELL_SUMMON_BERSERKER1, true);
        GetUnitOwner()->CastSpell(GetUnitOwner(), SPELL_SUMMON_BERSERKER2, true);
    }

    void Register() override
    {
        OnEffectApply += AuraEffectApplyFn(spell_muru_summon_blood_elves_periodic_aura::HandleApply, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY, AURA_EFFECT_HANDLE_REAL);
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_muru_summon_blood_elves_periodic_aura::OnPeriodic, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY);
    }
};

class spell_muru_darkness_aura : public AuraScript
{
    PrepareAuraScript(spell_muru_darkness_aura);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_SUMMON_DARK_FIEND });
    }

    void OnPeriodic(AuraEffect const* aurEff)
    {
        if (aurEff->GetTickNumber() == 3)
            for (uint8 i = 0; i < 8; ++i)
                GetUnitOwner()->CastSpell(GetUnitOwner(), SPELL_SUMMON_DARK_FIEND + i, true);
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_muru_darkness_aura::OnPeriodic, EFFECT_2, SPELL_AURA_PERIODIC_DUMMY);
    }
};

class spell_entropius_void_zone_visual_aura : public AuraScript
{
    PrepareAuraScript(spell_entropius_void_zone_visual_aura);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_SUMMON_DARK_FIEND_ENTROPIUS });
    }

    void HandleApply(AuraEffect const*  /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        SetDuration(3000);
    }

    void HandleRemove(AuraEffect const*  /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        GetUnitOwner()->CastSpell(GetUnitOwner(), SPELL_SUMMON_DARK_FIEND_ENTROPIUS, true);
    }

    void Register() override
    {
        OnEffectApply += AuraEffectApplyFn(spell_entropius_void_zone_visual_aura::HandleApply, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
        OnEffectRemove += AuraEffectRemoveFn(spell_entropius_void_zone_visual_aura::HandleApply, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
    }
};

class spell_entropius_black_hole_effect : public SpellScript
{
    PrepareSpellScript(spell_entropius_black_hole_effect);

    void HandlePull(SpellEffIndex effIndex)
    {
        PreventHitDefaultEffect(effIndex);
        Unit* target = GetHitUnit();
        if (!target)
            return;

        Position pos;
        if (target->GetDistance(GetCaster()) < 5.0f)
        {
            float o = frand(0, 2 * M_PI);
            pos.Relocate(GetCaster()->GetPositionX() + 4.0f * cos(o), GetCaster()->GetPositionY() + 4.0f * std::sin(o), GetCaster()->GetPositionZ() + frand(10.0f, 15.0f));
        }
        else
            pos.Relocate(GetCaster()->GetPositionX(), GetCaster()->GetPositionY(), GetCaster()->GetPositionZ() + 1.0f);

        float speedXY = float(GetSpellInfo()->Effects[effIndex].MiscValue) * 0.1f;
        float speedZ = target->GetDistance(pos) / speedXY * 0.5f * Movement::gravity;

        target->GetMotionMaster()->MoveJump(pos.GetPositionX(), pos.GetPositionY(), pos.GetPositionZ(), speedXY, speedZ);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_entropius_black_hole_effect::HandlePull, EFFECT_0, SPELL_EFFECT_PULL_TOWARDS_DEST);
    }
};

// 46284 - Negative Energy Periodic
class spell_entropius_negative_energy_periodic : public AuraScript
{
    PrepareAuraScript(spell_entropius_negative_energy_periodic);

    bool Validate(SpellInfo const* spellInfo) override
    {
        return ValidateSpellInfo({ spellInfo->Effects[EFFECT_0].TriggerSpell });
    }

    void PeriodicTick(AuraEffect const* aurEff)
    {
        PreventDefaultAction();
        uint32 targetCount = (aurEff->GetTickNumber() + 11) / 12;
        GetTarget()->CastCustomSpell(aurEff->GetSpellInfo()->Effects[EFFECT_0].TriggerSpell, SPELLVALUE_MAX_TARGETS, targetCount);
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_entropius_negative_energy_periodic::PeriodicTick, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
    }
};

void AddSC_boss_muru()
{
    RegisterSunwellPlateauCreatureAI(boss_muru);
    RegisterSunwellPlateauCreatureAI(boss_entropius);
    RegisterSunwellPlateauCreatureAI(npc_singularity);

    RegisterSpellScript(spell_muru_summon_blood_elves_periodic_aura);
    RegisterSpellScript(spell_muru_darkness_aura);
    RegisterSpellScript(spell_entropius_void_zone_visual_aura);
    RegisterSpellScript(spell_entropius_black_hole_effect);
    RegisterSpellScript(spell_entropius_negative_energy_periodic);
}

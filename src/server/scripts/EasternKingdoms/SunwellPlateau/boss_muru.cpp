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
    SPELL_NEGATIVE_ENERGY_CHAIN         = 46285,
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

enum Misc
{
    EVENT_SPELL_ENRAGE              = 1,
    EVENT_SUMMON_ENTROPIUS          = 2,
    EVENT_SET_INVISIBLE             = 3,
    EVENT_SPAWN_BLACK_HOLE          = 4,
    EVENT_SPAWN_DARKNESS            = 5,
    EVENT_START_BLACK_HOLE          = 6,
    EVENT_SWITCH_BLACK_HOLE_TARGET  = 7,
    EVENT_ENTROPIUS_AURAS           = 8,
    EVENT_ENTROPIUS_COMBAT          = 9,
    EVENT_SINGULARITY_DEATH         = 10,

    DATA_ENRAGE_TIMER               = 1,
    DATA_NEGATIVE_ENERGY_TARGETS    = 2
};

class boss_muru : public CreatureScript
{
public:
    boss_muru() : CreatureScript("boss_muru") { }

    struct boss_muruAI : public BossAI
    {
        boss_muruAI(Creature* creature) : BossAI(creature, DATA_MURU) { }

        void Reset() override
        {
            BossAI::Reset();
            me->SetReactState(REACT_AGGRESSIVE);
            me->RemoveUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
            me->SetVisible(true);
        }

        void JustEngagedWith(Unit* who) override
        {
            BossAI::JustEngagedWith(who);
            me->CastSpell(me, SPELL_NEGATIVE_ENERGY, true);
            me->CastSpell(me, SPELL_SUMMON_BLOOD_ELVES_PERIODIC, true);
            me->CastSpell(me, SPELL_OPEN_PORTAL_PERIODIC, true);
            me->CastSpell(me, SPELL_DARKNESS_PERIODIC, true);

            events.ScheduleEvent(EVENT_SPELL_ENRAGE, 600000);
        }

        void DamageTaken(Unit*, uint32& damage, DamageEffectType, SpellSchoolMask) override
        {
            if (damage >= me->GetHealth())
            {
                damage = 0;
                if (!me->HasUnitFlag(UNIT_FLAG_NOT_SELECTABLE))
                {
                    me->SetUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
                    me->RemoveAllAuras();
                    me->CastSpell(me, SPELL_OPEN_ALL_PORTALS, true);
                    events.ScheduleEvent(EVENT_SUMMON_ENTROPIUS, 7000);
                }
            }
        }

        void JustSummoned(Creature* summon) override
        {
            if (summon->GetEntry() == NPC_ENTROPIUS)
                summon->AI()->SetData(DATA_ENRAGE_TIMER, events.GetNextEventTime(EVENT_SPELL_ENRAGE));
            else
            {
                if (!summon->IsTrigger())
                    summon->SetInCombatWithZone();
                summons.Summon(summon);
            }
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);
            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (events.ExecuteEvent())
            {
                case EVENT_SPELL_ENRAGE:
                    me->CastSpell(me, SPELL_ENRAGE, true);
                    break;
                case EVENT_SUMMON_ENTROPIUS:
                    me->CastSpell(me, SPELL_SUMMON_ENTROPIUS, false);
                    events.ScheduleEvent(EVENT_SET_INVISIBLE, 1000);
                    break;
                case EVENT_SET_INVISIBLE:
                    me->SetVisible(false);
                    break;
            }
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetSunwellPlateauAI<boss_muruAI>(creature);
    }
};

class boss_entropius : public CreatureScript
{
public:
    boss_entropius() : CreatureScript("boss_entropius") { }

    struct boss_entropiusAI : public ScriptedAI
    {
        boss_entropiusAI(Creature* creature) : ScriptedAI(creature) { }

        EventMap events;
        EventMap events2;

        void Reset() override
        {
            events.Reset();
            events2.Reset();
            events2.ScheduleEvent(EVENT_ENTROPIUS_AURAS, 0);
            events2.ScheduleEvent(EVENT_ENTROPIUS_COMBAT, 3000);
            me->SetReactState(REACT_PASSIVE);
        }

        void EnterEvadeMode(EvadeReason why) override
        {
            if (InstanceScript* instance = me->GetInstanceScript())
                if (Creature* muru = ObjectAccessor::GetCreature(*me, instance->GetGuidData(NPC_MURU)))
                    if (!muru->IsInEvadeMode())
                        muru->AI()->EnterEvadeMode(why);

            me->DespawnOrUnsummon();
        }

        void JustEngagedWith(Unit* /*who*/) override
        {
            events.ScheduleEvent(EVENT_SPAWN_BLACK_HOLE, 15000);
            events.ScheduleEvent(EVENT_SPAWN_DARKNESS, 10000);
        }

        void SetData(uint32 type, uint32 data) override
        {
            if (type == DATA_ENRAGE_TIMER)
                events.ScheduleEvent(EVENT_SPELL_ENRAGE, data);
        }

        uint32 GetData(uint32 type) const override
        {
            if (type == DATA_NEGATIVE_ENERGY_TARGETS)
                return 1 + uint32(events.GetTimer() / 12000);
            return 0;
        }

        void JustDied(Unit* /*killer*/) override
        {
            if (InstanceScript* instance = me->GetInstanceScript())
                if (Creature* muru = ObjectAccessor::GetCreature(*me, instance->GetGuidData(NPC_MURU)))
                    Unit::Kill(muru, muru);
        }

        void UpdateAI(uint32 diff) override
        {
            events2.Update(diff);
            switch (events2.ExecuteEvent())
            {
                case EVENT_ENTROPIUS_AURAS:
                    me->CastSpell(me, SPELL_ENTROPIUS_COSMETIC_SPAWN, false);
                    me->CastSpell(me, SPELL_NEGATIVE_ENERGY_PERIODIC, true);
                    break;
                case EVENT_ENTROPIUS_COMBAT:
                    me->SetReactState(REACT_AGGRESSIVE);
                    me->SetInCombatWithZone();
                    AttackStart(SelectTargetFromPlayerList(50.0f));
                    break;
            }

            if (!events2.Empty())
                return;

            if (!UpdateVictim())
                return;

            events.Update(diff);
            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (events.ExecuteEvent())
            {
                case EVENT_SPELL_ENRAGE:
                    me->CastSpell(me, SPELL_ENRAGE, true);
                    break;
                case EVENT_SPAWN_DARKNESS:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 50.0f, true))
                        me->CastSpell(target, SPELL_DARKNESS, true);
                    events.ScheduleEvent(EVENT_SPAWN_DARKNESS, 15000);
                    break;
                case EVENT_SPAWN_BLACK_HOLE:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 50.0f, true))
                        me->CastSpell(target, SPELL_BLACK_HOLE, true);
                    events.ScheduleEvent(EVENT_SPAWN_BLACK_HOLE, 15000);
                    break;
            }

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetSunwellPlateauAI<boss_entropiusAI>(creature);
    }
};

class npc_singularity : public CreatureScript
{
public:
    npc_singularity() : CreatureScript("npc_singularity") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetSunwellPlateauAI<npc_singularityAI>(creature);
    }

    struct npc_singularityAI : public NullCreatureAI
    {
        npc_singularityAI(Creature* creature) : NullCreatureAI(creature)
        {
        }

        EventMap events;

        void Reset() override
        {
            me->DespawnOrUnsummon(18000);
            me->CastSpell(me, SPELL_BLACK_HOLE_SUMMON_VISUAL, true);
            me->CastSpell(me, SPELL_BLACK_HOLE_SUMMON_VISUAL2, true);
            events.ScheduleEvent(EVENT_START_BLACK_HOLE, 3500);
            events.ScheduleEvent(EVENT_SWITCH_BLACK_HOLE_TARGET, 5000);
            events.ScheduleEvent(EVENT_SINGULARITY_DEATH, 17000);
        }

        void UpdateAI(uint32 diff) override
        {
            events.Update(diff);
            switch (events.ExecuteEvent())
            {
                case EVENT_SINGULARITY_DEATH:
                    me->KillSelf();
                    break;
                case EVENT_START_BLACK_HOLE:
                    me->RemoveAurasDueToSpell(SPELL_BLACK_HOLE_SUMMON_VISUAL2);
                    me->CastSpell(me, SPELL_BLACK_HOLE_VISUAL2, true);
                    me->CastSpell(me, SPELL_BLACK_HOLE_PASSIVE, true);
                    break;
                case EVENT_SWITCH_BLACK_HOLE_TARGET:
                    {
                        Map::PlayerList const& players = me->GetMap()->GetPlayers();
                        for (Map::PlayerList::const_iterator itr = players.begin(); itr != players.end(); ++itr)
                            if (Player* player = itr->GetSource())
                                if (me->GetDistance2d(player) < 15.0f && player->GetPositionZ() < 72.0f && player->IsAlive() && !player->HasAura(SPELL_BLACK_HOLE_EFFECT))
                                {
                                    me->GetMotionMaster()->MovePoint(0, player->GetPositionX(), player->GetPositionY(), player->GetPositionZ(), false, true);
                                    events.ScheduleEvent(EVENT_SWITCH_BLACK_HOLE_TARGET, 5000);
                                    return;
                                }
                        events.ScheduleEvent(EVENT_SWITCH_BLACK_HOLE_TARGET, 500);
                        break;
                    }
            }
        }
    };
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

class spell_entropius_negative_energy : public SpellScript
{
    PrepareSpellScript(spell_entropius_negative_energy);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_NEGATIVE_ENERGY_CHAIN });
    }

    bool Load() override
    {
        return GetCaster()->GetTypeId() == TYPEID_UNIT;
    }

    void FilterTargets(std::list<WorldObject*>& targets)
    {
        Acore::Containers::RandomResize(targets, GetCaster()->GetAI()->GetData(DATA_NEGATIVE_ENERGY_TARGETS));
    }

    void HandleScriptEffect(SpellEffIndex effIndex)
    {
        PreventHitDefaultEffect(effIndex);
        if (Unit* target = GetHitUnit())
            GetCaster()->CastSpell(target, SPELL_NEGATIVE_ENERGY_CHAIN, true);
    }

    void Register() override
    {
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_entropius_negative_energy::FilterTargets, EFFECT_0, TARGET_UNIT_SRC_AREA_ENEMY);
        OnEffectHitTarget += SpellEffectFn(spell_entropius_negative_energy::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
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

void AddSC_boss_muru()
{
    new boss_muru();
    new boss_entropius();
    new npc_singularity();

    RegisterSpellScript(spell_muru_summon_blood_elves_periodic_aura);
    RegisterSpellScript(spell_muru_darkness_aura);
    RegisterSpellScript(spell_entropius_negative_energy);
    RegisterSpellScript(spell_entropius_void_zone_visual_aura);
    RegisterSpellScript(spell_entropius_black_hole_effect);
}

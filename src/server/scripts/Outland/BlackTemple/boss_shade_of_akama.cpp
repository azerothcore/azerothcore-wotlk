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
#include "ScriptedCreature.h"
#include "SpellScriptLoader.h"
#include "black_temple.h"

enum Says
{
    SAY_BROKEN_FREE_0               = 0,
    SAY_BROKEN_FREE_1               = 1,
    SAY_BROKEN_FREE_2               = 2,
    SAY_LOW_HEALTH                  = 3,
    SAY_DEATH                       = 4,

    SAY_BROKEN_S1                   = 0,
    SAY_BROKEN_S2                   = 1
};

enum Spells
{
    // Akama
    SPELL_STEALTH                   = 34189,
    SPELL_DESTRUCTIVE_POISON        = 40874,
    SPELL_CHAIN_LIGHTNING           = 39945,
    SPELL_AKAMA_SOUL_CHANNEL        = 40447,
    SPELL_FIXATE                    = 40607,
    SPELL_AKAMA_SOUL_RETRIEVE       = 40902,    // epilogue
    SPELL_AKAMA_SOUL_EXPEL_CHANNEL  = 40927,    // epilogue

    // Shade & Channelers
    SPELL_SHADE_SOUL_CHANNEL        = 40401,
    SPELL_THREAT                    = 41602,
    SPELL_SHADE_OF_AKAMA_TRIGGER    = 40955,

    // Summons
    SPELL_ASHTONGUE_WAVE_A          = 42073,   // unused
    SPELL_ASHTONGUE_WAVE_B          = 42035,
    SPELL_SUMMON_ASHTONGUE_SORCERER = 40476,
    SPELL_SUMMON_ASHTONGUE_DEFENDER = 40474
};

enum Creatures
{
    NPC_ASHTONGUE_SORCERER          = 23215,
    NPC_ASHTONGUE_DEFENDER          = 23216,
    NPC_ASHTONGUE_ELEMENTAL         = 23523,
    NPC_ASHTONGUE_ROGUE             = 23318,
    NPC_ASHTONGUE_SPIRITBIND        = 23524,
    NPC_ASHTONGUE_BROKEN            = 23319
};

enum Misc
{
    SUMMON_GROUP_BROKENS            = 1,

    POINT_ENGAGE                    = 0,
    POINT_OUTRO                     = 1,

    ACTION_GENERATOR_START          = 1,
    ACTION_GENERATOR_STOP           = 2,
    ACTION_GENERATOR_DESPAWN_ALL    = 3,

    COUNTER_SPAWNS_MAX              = 20,   // Max number of spawns for each generator, number chosen at random

    ACTION_AKAMA_START_OUTRO        = 1,

    FACTION_DEFAULT                 = 1820,
    FACTION_ENGAGE                  = 1868,
    FACTION_DEFENDER                = 1847
};

Position AkamaEngage = { 517.4877f, 400.79926f, 112.77704f };
Position AkamaOutro = { 469.0867f,  401.0793f,  118.52704f, 0.087266460061073303f };
Position ShadeEngage = { 512.48773f, 400.8283f, 112.77704f };

struct boss_shade_of_akama : public BossAI
{
    boss_shade_of_akama(Creature* creature) : BossAI(creature, DATA_SHADE_OF_AKAMA) { }

    std::list<Creature*> channelers;
    std::list<Creature*> generators;

    void Reset() override
    {
        channelers.clear();
        generators.clear();

        me->SetUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
        me->SetWalk(true);
        me->SetReactState(REACT_DEFENSIVE);
        BossAI::Reset();
    }

    void EnterEvadeMode(EvadeReason why) override
    {
        for (Creature* generator : generators)
            generator->AI()->DoAction(ACTION_GENERATOR_DESPAWN_ALL);

        for (Creature* channeler : channelers)
            channeler->SetUnitFlag(UNIT_FLAG_NOT_SELECTABLE);

        BossAI::EnterEvadeMode(why);
    }

    void JustDied(Unit* killer) override
    {
        BossAI::JustDied(killer);
        me->CastSpell(me, SPELL_SHADE_OF_AKAMA_TRIGGER, true);

        for (Creature* generator : generators)
            generator->AI()->DoAction(ACTION_GENERATOR_DESPAWN_ALL);

        if (Creature* akama = instance->GetCreature(DATA_AKAMA_SHADE))
            akama->AI()->DoAction(ACTION_AKAMA_START_OUTRO);
    }

    void SpellHit(Unit* /*caster*/, SpellInfo const* spell) override
    {
        if (spell->Id == SPELL_AKAMA_SOUL_CHANNEL)
        {
            instance->SetBossState(DATA_SHADE_OF_AKAMA, IN_PROGRESS);

            me->GetCreatureListWithEntryInGrid(channelers, NPC_ASHTONGUE_CHANNELER, 40.0f);
            me->GetCreatureListWithEntryInGrid(generators, NPC_CREATURE_GENERATOR_AKAMA, 100.0f);

            for (Creature* channeler : channelers)
                channeler->RemoveUnitFlag(UNIT_FLAG_NOT_SELECTABLE);

            for (Creature* generator : generators)
                generator->AI()->DoAction(ACTION_GENERATOR_START);

            ScheduleTimedEvent(1200ms, [&]
            {
                if (me->GetSpeed(MOVE_WALK) > 0.01f)
                {
                    me->GetMotionMaster()->Clear();
                    me->GetMotionMaster()->MovePoint(POINT_ENGAGE, ShadeEngage);
                }
            }, 1200ms);
        }
    }

    void MovementInform(uint32 type, uint32 point) override
    {
        if (type == POINT_MOTION_TYPE && point == POINT_ENGAGE)
        {
            me->RemoveUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
            me->RemoveAurasDueToSpell(SPELL_AKAMA_SOUL_CHANNEL);
            scheduler.CancelAll();

            for (Creature* generator : generators)
                generator->AI()->DoAction(ACTION_GENERATOR_STOP);

            if (Creature* akama = instance->GetCreature(DATA_AKAMA_SHADE))
            {
                akama->SetReactState(REACT_AGGRESSIVE);
                akama->InterruptSpell(CURRENT_CHANNELED_SPELL);
                DoCast(akama, SPELL_THREAT, true);
                me->AddThreat(akama, 900000.0f);
                akama->AI()->DoCast(me, SPELL_FIXATE, true);
                AttackStart(akama);
            }

            ScheduleTimedEvent(3500ms, [&]
            {
                if (Creature* akama = instance->GetCreature(DATA_AKAMA_SHADE))
                    me->AddThreat(akama, 900000.0f);
            }, 3500ms);
        }
    }

    void UpdateAI(uint32 diff) override
    {
        scheduler.Update(diff);

        DoMeleeAttackIfReady();
    }
};

struct npc_akama_shade : public ScriptedAI
{
    npc_akama_shade(Creature* creature) : ScriptedAI(creature)
    {
        instance = creature->GetInstanceScript();
    }

    InstanceScript* instance;

    void Reset() override
    {
        if (instance->GetBossState(DATA_SHADE_OF_AKAMA) == DONE)
        {
            me->RemoveNpcFlag(UNIT_NPC_FLAG_GOSSIP);
            return;
        }

        me->SetFaction(FACTION_DEFAULT);
        me->SetNpcFlag(UNIT_NPC_FLAG_GOSSIP);
        DoCastSelf(SPELL_STEALTH, true);
        me->SetWalk(true);
        _sayLowHealth = false;
        scheduler.CancelAll();
    }

    void MovementInform(uint32 type, uint32 point) override
    {
        if (type == POINT_MOTION_TYPE)
        {
            switch (point)
            {
            case POINT_ENGAGE:
                me->SetHomePosition(me->GetPosition());
                me->SetFaction(FACTION_ENGAGE);
                DoCast(me, SPELL_AKAMA_SOUL_CHANNEL, true);
                break;
            case POINT_OUTRO:
                DoCastSelf(SPELL_AKAMA_SOUL_RETRIEVE, true);
                ScheduleUniqueTimedEvent(15600ms, [&]
                {
                        Talk(SAY_BROKEN_FREE_0);
                        me->SummonCreatureGroup(SUMMON_GROUP_BROKENS);
                }, 1);
                ScheduleUniqueTimedEvent(26550ms, [&]
                {
                    Talk(SAY_BROKEN_FREE_1);
                }, 2);
                ScheduleUniqueTimedEvent(37500ms, [&]
                {
                    Talk(SAY_BROKEN_FREE_2);
                }, 3);
                ScheduleUniqueTimedEvent(52000ms, [&]
                {
                    std::list<Creature*> brokens;
                    me->GetCreatureListWithEntryInGrid(brokens, NPC_ASHTONGUE_BROKEN, 40.0f);
                    if (Creature* broken = GetClosestCreatureWithEntry(me, NPC_ASHTONGUE_BROKEN, 40.0f))
                        broken->AI()->Talk(SAY_BROKEN_S1);

                    for (Creature* broken : brokens)
                    {
                        broken->SetStandState(UNIT_STAND_STATE_KNEEL);
                        broken->SetFaction(FACTION_DEFAULT);
                        broken->AI()->Talk(SAY_BROKEN_S2, 4800ms);
                    }
                }, 4);
                break;
            }
        }
    }

    void DamageTaken(Unit* /*unit*/, uint32& damage, DamageEffectType, SpellSchoolMask) override
    {
        if (me->HealthBelowPctDamaged(20, damage) && !_sayLowHealth)
        {
            _sayLowHealth = true;
            Talk(SAY_LOW_HEALTH);
        }
    }

    void DoAction(int32 param) override
    {
        if (param == ACTION_AKAMA_START_OUTRO)
        {
            me->SetWalk(false);
            me->GetMotionMaster()->MovePoint(POINT_OUTRO, AkamaOutro);
        }
    }

    void JustSummoned(Creature* summon) override
    {
        // In Retail they seem to me like they should move in formations of 3 to set points, this is simpler for now
        ScriptedAI::JustSummoned(summon);
        float x, y, z;
        me->GetNearPoint(summon, x, y, z, 25.f, 0, me->GetAngle(summon));
        summon->SetWalk(true);
        summon->GetMotionMaster()->MovePoint(POINT_OUTRO, x, y, z);
    }

    void EnterEvadeMode(EvadeReason /*why*/) override { }

    void JustDied(Unit* /*killer*/) override
    {
        Talk(SAY_DEATH);
        if (Creature* shade = instance->GetCreature(DATA_SHADE_OF_AKAMA))
        {
            shade->SetHomePosition(shade->GetHomePosition());
            shade->AI()->EnterEvadeMode();
        }

        me->DespawnOrUnsummon();
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        ScheduleTimedEvent(2s, [&]
            {
                DoCastVictim(SPELL_CHAIN_LIGHTNING);
            }, 10s, 15s);
        ScheduleTimedEvent(5s, [&]
            {
                DoCastVictim(SPELL_DESTRUCTIVE_POISON);
            }, 4s, 15s);
    }

    void sGossipSelect(Player* player, uint32 /*sender*/, uint32 /*action*/) override
    {
        CloseGossipMenuFor(player);
        me->RemoveNpcFlag(UNIT_NPC_FLAG_GOSSIP);
        me->RemoveAurasDueToSpell(SPELL_STEALTH);
        me->GetMotionMaster()->MovePoint(POINT_ENGAGE, AkamaEngage);
    }

    void UpdateAI(uint32 diff) override
    {
        scheduler.Update(diff);
        DoMeleeAttackIfReady();
    }

    private:
        bool _sayLowHealth;
};

struct npc_creature_generator_akama : public ScriptedAI
{
    npc_creature_generator_akama(Creature* creature) : ScriptedAI(creature), summons(me)
    {
        instance = creature->GetInstanceScript();
    }

    uint8 spawnCounter = 0;

    void Reset() override
    {
        summons.DespawnAll();
        scheduler.CancelAll();
    }

    void JustSummoned(Creature* summon) override
    {
        spawnCounter++;
        ScriptedAI::JustSummoned(summon);

        switch (summon->GetEntry())
        {
        case NPC_ASHTONGUE_SORCERER:
            if (Creature* shade = instance->GetCreature(DATA_SHADE_OF_AKAMA))
            {
                float x, y, z;
                shade->GetNearPoint(shade, x, y, z, 20.f, 0, shade->GetAngle(summon));
                summon->GetMotionMaster()->MovePoint(POINT_ENGAGE, x, y, z);
            }
            break;
        case NPC_ASHTONGUE_DEFENDER:
            summon->SetFaction(FACTION_DEFENDER);
            if (Creature* akama = instance->GetCreature(DATA_AKAMA_SHADE))
                summon->AI()->AttackStart(akama);
            break;
        default:
            summon->SetInCombatWithZone();
            break;
        }
    }

    void SummonedCreatureDies(Creature* summon, Unit*) override
    {
        spawnCounter--;
        summon->DespawnOrUnsummon(10000);
        summons.Despawn(summon);
    }

    void DoAction(int32 param) override
    {
        switch (param)
        {
        case ACTION_GENERATOR_STOP:
            scheduler.CancelAll();
            break;
        case ACTION_GENERATOR_START:
            if (me->GetPositionY() > 400.0f)    // Right Side
            {
                ScheduleTimedEvent(10s, [&]
                {
                    if (spawnCounter <= COUNTER_SPAWNS_MAX)
                        DoCastSelf(SPELL_ASHTONGUE_WAVE_B);
                }, 50s, 60s);

                ScheduleTimedEvent(2s, 5s, [&]
                {
                    if (spawnCounter <= COUNTER_SPAWNS_MAX)
                        DoCastSelf(SPELL_SUMMON_ASHTONGUE_DEFENDER);
                }, 30s, 40s);
            }

            if (me->GetPositionY() < 400.0f)    // Left Side
            {
                ScheduleTimedEvent(3s, [&]
                {
                    if (spawnCounter <= COUNTER_SPAWNS_MAX)
                        DoCastSelf(SPELL_ASHTONGUE_WAVE_B);
                }, 50s, 60s);

                ScheduleTimedEvent(2s, 5s, [&]
                {
                    if (spawnCounter <= COUNTER_SPAWNS_MAX)
                        DoCastSelf(SPELL_SUMMON_ASHTONGUE_SORCERER);
                }, 30s, 35s);
            }
            break;
        case ACTION_GENERATOR_DESPAWN_ALL:
            summons.DespawnAll();
            scheduler.CancelAll();
            break;
        }
    }

    void UpdateAI(uint32 diff) override
    {
        scheduler.Update(diff);
    }

private:
    SummonList summons;
    InstanceScript* instance;
};

struct npc_ashtongue_sorcerer : public NullCreatureAI
{
    npc_ashtongue_sorcerer(Creature* creature) : NullCreatureAI(creature)
    {
        instance = creature->GetInstanceScript();
    }

    void MovementInform(uint32 type, uint32 point) override
    {
        if (type == POINT_MOTION_TYPE && point == POINT_ENGAGE)
            me->CastSpell(me, SPELL_SHADE_SOUL_CHANNEL, true);
    }

private:
    InstanceScript* instance;
};

struct npc_ashtongue_channeler : public NullCreatureAI
{
    npc_ashtongue_channeler(Creature* creature) : NullCreatureAI(creature)
    {
        instance = creature->GetInstanceScript();
    }

    void Reset() override
    {
        scheduler.Schedule(3600ms, [this](TaskContext context)
        {
            if (!me->HasUnitState(UNIT_STATE_CASTING))
                me->CastSpell(me, SPELL_SHADE_SOUL_CHANNEL, true);

            context.Repeat();
        });
    }

    void UpdateAI(uint32 diff) override
    {
        scheduler.Update(diff);
    }

private:
    InstanceScript* instance;
    TaskScheduler scheduler;
};

class spell_shade_of_akama_shade_soul_channel : public AuraScript
{
    PrepareAuraScript(spell_shade_of_akama_shade_soul_channel);

    void HandleEffectApply(AuraEffect const*  /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        if (Unit* caster = GetCaster())
            caster->SetFacingToObject(GetTarget());
    }

    void HandleEffectRemove(AuraEffect const*  /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        if (Aura* aura = GetTarget()->GetAura(GetSpellInfo()->Effects[EFFECT_1].TriggerSpell))
            aura->ModStackAmount(-1);
    }

    void Register() override
    {
        AfterEffectApply += AuraEffectApplyFn(spell_shade_of_akama_shade_soul_channel::HandleEffectApply, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
        AfterEffectRemove += AuraEffectRemoveFn(spell_shade_of_akama_shade_soul_channel::HandleEffectRemove, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
    }
};

class spell_shade_of_akama_akama_soul_expel : public SpellScript
{
    PrepareSpellScript(spell_shade_of_akama_akama_soul_expel);

    void SetDest(SpellDestination& dest)
    {
        // Adjust effect summon position
        Position const offset = { 0.0f, 0.0f, 25.0f, 0.0f };
        dest.RelocateOffset(offset);
    }

    void Register() override
    {
        OnDestinationTargetSelect += SpellDestinationTargetSelectFn(spell_shade_of_akama_akama_soul_expel::SetDest, EFFECT_0, TARGET_DEST_CASTER_RADIUS);
    }
};

void AddSC_boss_shade_of_akama()
{
    RegisterBlackTempleCreatureAI(boss_shade_of_akama);
    RegisterBlackTempleCreatureAI(npc_akama_shade);
    RegisterBlackTempleCreatureAI(npc_creature_generator_akama);
    RegisterBlackTempleCreatureAI(npc_ashtongue_channeler);
    RegisterBlackTempleCreatureAI(npc_ashtongue_sorcerer);
    RegisterSpellScript(spell_shade_of_akama_shade_soul_channel);
    RegisterSpellScript(spell_shade_of_akama_akama_soul_expel);
}


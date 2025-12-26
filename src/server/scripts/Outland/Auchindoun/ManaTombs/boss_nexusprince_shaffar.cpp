/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "CreatureScript.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "mana_tombs.h"

enum Text
{
    SAY_INTRO                       = 0,
    SAY_AGGRO                       = 1,
    SAY_SLAY                        = 2,
    SAY_SUMMON                      = 3,
    SAY_DEAD                        = 4
};

enum Spells
{
    // Shaffar
    SPELL_BLINK                     = 34605,
    SPELL_FROSTBOLT                 = 32364,
    SPELL_FIREBALL                  = 32363,
    SPELL_FROSTNOVA                 = 32365,
    SPELL_ETHEREAL_BEACON           = 32371, // Summons NPC_BEACON
    SPELL_ETHEREAL_BEACON_VISUAL    = 32368,

    // Yor
    SPELL_DOUBLE_BREATH             = 38361,
    SPELL_STOMP                     = 36405
};

enum Npc
{
    NPC_BEACON                      = 18431
};

struct boss_nexusprince_shaffar : public BossAI
{
    boss_nexusprince_shaffar(Creature* creature) : BossAI(creature, DATA_NEXUSPRINCE_SHAFFAR), summons(me)
    {
        HasTaunted = false;
        scheduler.SetValidator([this]
        {
            return !me->HasUnitState(UNIT_STATE_CASTING);
        });
    }

    SummonList summons;
    bool HasTaunted;

    void Reset() override
    {
        _Reset();
        summons.DespawnAll();
    }

    void MoveInLineOfSight(Unit* who) override
    {
        if (!HasTaunted && who->IsPlayer() && me->IsWithinDistInMap(who, 100.0f))
        {
            HasTaunted = true;
            Talk(SAY_INTRO);
        }
    }

    void JustEngagedWith(Unit*) override
    {
        _JustEngagedWith();
        Talk(SAY_AGGRO);
        summons.DoZoneInCombat();
        scheduler.Schedule(10s, [this](TaskContext context)
        {
            if (!urand(0, 3))
            {
                Talk(SAY_SUMMON);
            }
            DoCastSelf(SPELL_ETHEREAL_BEACON, true);
            context.Repeat(10s);
        }).Schedule(4s, [this](TaskContext context)
        {
            DoCastVictim(RAND(SPELL_FROSTBOLT, SPELL_FIREBALL));
            context.Repeat(3s, 4s);
        }).Schedule(15s, [this](TaskContext context)
        {
            DoCastSelf(SPELL_FROSTNOVA);
            context.Repeat(16s, 23s);
            scheduler.DelayAll(1500ms);
            scheduler.Schedule(1500ms, [this](TaskContext /*context*/)
            {
                DoCastSelf(SPELL_BLINK);
            });
        });
    }

    void JustSummoned(Creature* summon) override
    {
        if (me->IsInCombat() && summon->GetEntry() == NPC_BEACON)
        {
            summon->CastSpell(summon, SPELL_ETHEREAL_BEACON_VISUAL, false);
            if (Unit* target = SelectTargetFromPlayerList(50.0f))
            {
                summon->AI()->AttackStart(target);
            }
        }
        summons.Summon(summon);
    }

    void SummonedCreatureDespawn(Creature* summon) override
    {
        summons.Despawn(summon);
    }

    void KilledUnit(Unit* victim) override
    {
        if (victim->IsPlayer())
        {
            Talk(SAY_SLAY);
        }
    }

    void JustDied(Unit* /*killer*/) override
    {
        _JustDied();
        Talk(SAY_DEAD);
        summons.DespawnAll();
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;

        scheduler.Update(diff);
        if (me->HasUnitState(UNIT_STATE_CASTING))
            return;

        DoMeleeAttackIfReady();
    }
};

struct npc_yor : public ScriptedAI
{
    npc_yor(Creature* creature) : ScriptedAI(creature) { }

    void Reset() override { }

    void JustEngagedWith(Unit* /*who*/) override
    {
        _scheduler.Schedule(25500ms, 30500ms, [this](TaskContext context)
        {
            if (me->IsWithinDist(me->GetVictim(), ATTACK_DISTANCE))
            {
                DoCastVictim(SPELL_DOUBLE_BREATH);
            }
            context.Repeat(10s, 20s);
        }).Schedule(12s, 18s, [this](TaskContext context)
        {
            DoCastAOE(SPELL_STOMP);
            context.Repeat(14s, 24s);
        });
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;

        _scheduler.Update(diff);
        if (me->HasUnitState(UNIT_STATE_CASTING))
            return;

        DoMeleeAttackIfReady();
    }

private:
    TaskScheduler _scheduler;
};

void AddSC_boss_nexusprince_shaffar()
{
    RegisterManaTombsCreatureAI(boss_nexusprince_shaffar);
    RegisterManaTombsCreatureAI(npc_yor);
}

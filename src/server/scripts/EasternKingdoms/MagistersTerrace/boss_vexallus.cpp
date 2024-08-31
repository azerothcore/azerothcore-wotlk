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
#include "magisters_terrace.h"

enum Yells
{
    SAY_AGGRO                       = 0,
    SAY_ENERGY                      = 1,
    SAY_OVERLOAD                    = 2,
    SAY_KILL                        = 3,
    EMOTE_DISCHARGE_ENERGY          = 4
};

enum Spells
{
    // Pure energy spell info
    SPELL_ENERGY_FEEDBACK_CHANNEL   = 44328,
    SPELL_ENERGY_FEEDBACK           = 44335,

    // Vexallus spell info
    SPELL_CHAIN_LIGHTNING_N         = 44318,
    SPELL_CHAIN_LIGHTNING_H         = 46380,
    SPELL_OVERLOAD                  = 44352,
    SPELL_ARCANE_SHOCK_N            = 44319,
    SPELL_ARCANE_SHOCK_H            = 46381,

    SPELL_SUMMON_PURE_ENERGY_N      = 44322,
    SPELL_SUMMON_PURE_ENERGY_H1     = 46154,
    SPELL_SUMMON_PURE_ENERGY_H2     = 46159
};

enum Misc
{
    NPC_PURE_ENERGY                 = 24745
};

struct boss_vexallus : public BossAI
{
    boss_vexallus(Creature* creature) : BossAI(creature, DATA_VEXALLUS) { }

    void Reset() override
    {
        _Reset();

        ScheduleHealthCheckEvent({ 85, 70, 55, 40 }, [&]
        {
            Talk(SAY_ENERGY);
            Talk(EMOTE_DISCHARGE_ENERGY);

            if (IsHeroic())
            {
                DoCastSelf(SPELL_SUMMON_PURE_ENERGY_H1);
                DoCastSelf(SPELL_SUMMON_PURE_ENERGY_H2);
            }
            else
                DoCastSelf(SPELL_SUMMON_PURE_ENERGY_N);
        });

        ScheduleHealthCheckEvent(20, [&]
        {
            scheduler.CancelAll();
            DoCastSelf(SPELL_OVERLOAD, true);
        });
    }

    void KilledUnit(Unit* victim) override
    {
        if (victim->IsPlayer())
            Talk(SAY_KILL);
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        _JustEngagedWith();
        Talk(SAY_AGGRO);

        ScheduleTimedEvent(8s, [&]
        {
            DoCastRandomTarget(DUNGEON_MODE(SPELL_CHAIN_LIGHTNING_N, SPELL_CHAIN_LIGHTNING_H));
        }, 8s, 8s);

        ScheduleTimedEvent(5s, [&]
        {
            DoCastRandomTarget(DUNGEON_MODE(SPELL_ARCANE_SHOCK_N, SPELL_ARCANE_SHOCK_H));
        }, 8s, 8s);
    }

    void JustSummoned(Creature* summon) override
    {
        if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0))
        {
            summon->GetMotionMaster()->MoveFollow(target, 0.0f, 0.0f);
            summon->CastSpell(target, SPELL_ENERGY_FEEDBACK_CHANNEL, false);
        }
        summons.Summon(summon);
    }

    void SummonedCreatureDies(Creature* summon, Unit* killer) override
    {
        summons.Despawn(summon);
        summon->DespawnOrUnsummon(1);
        if (killer)
            killer->CastSpell(killer, SPELL_ENERGY_FEEDBACK, true, 0, 0, summon->GetGUID());
    }
};

void AddSC_boss_vexallus()
{
    RegisterMagistersTerraceCreatureAI(boss_vexallus);
}

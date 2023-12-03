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
#include "arcatraz.h"

enum Says
{
    SAY_INTRO                   = 0,
    SAY_AGGRO                   = 1,
    SAY_KILL                    = 2,
    SAY_MIND                    = 3,
    SAY_FEAR                    = 4,
    SAY_IMAGE                   = 5,
    SAY_DEATH                   = 6
};

enum Spells
{
    SPELL_FEAR                  = 39415,
    SPELL_MIND_REND             = 36924,
    SPELL_DOMINATION            = 37162,
    SPELL_MANA_BURN             = 39020,
    SPELL_66_ILLUSION           = 36931,
    SPELL_33_ILLUSION           = 36932,

    SPELL_MIND_REND_IMAGE   = 36929,
    H_SPELL_MIND_REND_IMAGE = 39021
};

enum Misc
{
    NPC_HARBINGER_SKYRISS_66    = 21466
};

struct boss_harbinger_skyriss : public BossAI
{
    boss_harbinger_skyriss(Creature* creature) : BossAI(creature, DATA_WARDEN_MELLICHAR) { }

    void Reset() override
    {
        _Reset();

        ScheduleHealthCheckEvent(66, [&] {
            Talk(SAY_IMAGE);
            DoCastSelf(SPELL_66_ILLUSION, true);
        });

        ScheduleHealthCheckEvent(33, [&] {
            Talk(SAY_IMAGE);
            DoCastSelf(SPELL_33_ILLUSION, true);
        });
    }

    void EnterEvadeMode(EvadeReason why) override
    {
        BossAI::EnterEvadeMode(why);
        instance->DoRespawnCreature(DATA_WARDEN_MELLICHAR, true);
        me->DespawnOrUnsummon();
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        Talk(SAY_AGGRO);
        me->SetInCombatWithZone();

        scheduler.Schedule(10s, [this](TaskContext context)
        {
            DoCastRandomTarget(SPELL_MIND_REND, 0, 50.0f);
            context.Repeat(10s);
        }).Schedule(15s, [this](TaskContext context)
        {
            if (DoCastRandomTarget(SPELL_FEAR, 1, 20.0f) == SPELL_CAST_OK)
            {
                Talk(SAY_FEAR);
            }
            context.Repeat(25s);
        }).Schedule(30s, [this](TaskContext context)
        {
            if (DoCastRandomTarget(SPELL_DOMINATION, 1, 30.0f) == SPELL_CAST_OK)
            {
                Talk(SAY_MIND);
            }
            context.Repeat();
        });

        if (IsHeroic())
        {
            scheduler.Schedule(25s, [this](TaskContext context)
            {
                if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, PowerUsersSelector(me, POWER_MANA, 40.0f, false)))
                {
                    DoCast(target, SPELL_MANA_BURN);
                }

                context.Repeat(30s);
            });
        }
    }

    void JustDied(Unit* /*killer*/) override
    {
        _JustDied();
        Talk(SAY_DEATH);
    }

    void JustSummoned(Creature* summon) override
    {
        summon->SetHealth(summon->CountPctFromMaxHealth(summon->GetEntry() == NPC_HARBINGER_SKYRISS_66 ? 66 : 33));
        me->UpdatePosition(*summon, true);
        me->SendMovementFlagUpdate();
        BossAI::JustSummoned(summon);
    }

    void KilledUnit(Unit* victim) override
    {
        if (victim->IsPlayer())
        {
            Talk(SAY_KILL);
        }
    }
};

void AddSC_boss_harbinger_skyriss()
{
    RegisterArcatrazCreatureAI(boss_harbinger_skyriss);
}

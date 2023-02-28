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

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "the_black_morass.h"

enum Enums
{
    SAY_ENTER                   = 0,
    SAY_AGGRO                   = 1,
    SAY_BANISH                  = 2,
    SAY_SLAY                    = 3,
    SAY_DEATH                   = 4,

    SPELL_HASTEN                = 31458,
    SPELL_MORTAL_WOUND          = 31464,
    SPELL_WING_BUFFET           = 31475,
    SPELL_REFLECT               = 38592,
    SPELL_BANISH_DRAGON_HELPER  = 31550
};

class boss_temporus : public CreatureScript
{
public:
    boss_temporus() : CreatureScript("boss_temporus") { }

    struct boss_temporusAI : public ScriptedAI
    {
        boss_temporusAI(Creature* creature) : ScriptedAI(creature)
        {
            instance = creature->GetInstanceScript();
            _scheduler.SetValidator([this]
            {
                return !me->HasUnitState(UNIT_STATE_CASTING);
            });
        }

        InstanceScript* instance;

        void Reset() override
        {
            _scheduler.CancelAll();
        }

        void InitializeAI() override
        {
            Talk(SAY_ENTER);
            ScriptedAI::InitializeAI();
        }

        void JustEngagedWith(Unit* /*who*/) override
        {
            if (IsHeroic())
            {
                _scheduler.Schedule(30s, [this](TaskContext context)
                {
                    DoCast(SPELL_REFLECT);
                    context.Repeat(30s);
                });
            }

            /* Timers need to be clarified with Gultask */
            _scheduler
                .Schedule(10s, [this](TaskContext context)
            {
                DoCast(SPELL_HASTEN);
                context.Repeat(20s);
            })
                .Schedule(7s, 10s, [this](TaskContext context)
            {
                DoCast(SPELL_WING_BUFFET);
                context.Repeat(20s, 26s);
            })
                .Schedule(4s, 10s, [this](TaskContext context)
            {
                DoCastVictim(SPELL_MORTAL_WOUND);
                context.Repeat(4s, 10s);
            });

            Talk(SAY_AGGRO);
        }

        void KilledUnit(Unit* victim) override
        {
            if (victim->GetTypeId() == TYPEID_PLAYER)
                Talk(SAY_SLAY);
        }

        void JustDied(Unit* /*killer*/) override
        {
            Talk(SAY_DEATH);
            instance->SetData(TYPE_TEMPORUS, DONE);
        }

        void MoveInLineOfSight(Unit* who) override
        {
            if (who->GetTypeId() == TYPEID_UNIT && who->GetEntry() == NPC_TIME_KEEPER)
            {
                if (me->IsWithinDistInMap(who, 20.0f))
                {
                    Talk(SAY_BANISH);
                    me->CastSpell(me, SPELL_BANISH_DRAGON_HELPER, true);
                    return;
                }
            }

            ScriptedAI::MoveInLineOfSight(who);
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
                return;

            _scheduler.Update(diff, [this]
            {
                DoMeleeAttackIfReady();
            });
        }

    protected:
        TaskScheduler _scheduler;
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetTheBlackMorassAI<boss_temporusAI>(creature);
    }
};

void AddSC_boss_temporus()
{
    new boss_temporus();
}

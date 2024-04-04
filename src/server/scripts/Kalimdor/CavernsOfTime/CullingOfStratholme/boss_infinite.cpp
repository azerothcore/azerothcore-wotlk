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
#include "culling_of_stratholme.h"

enum Spells
{
    SPELL_CORRUPTING_BLIGHT                     = 60588,
    SPELL_VOID_STRIKE                           = 60590,
    SPELL_CORRUPTION_OF_TIME_AURA               = 60451,
    SPELL_CORRUPTION_OF_TIME_CHANNEL            = 60422,
};

enum Events
{
    EVENT_SPELL_CORRUPTING_BLIGHT               = 1,
    EVENT_SPELL_VOID_STRIKE                     = 2,
};

enum Yells
{
    SAY_AGGRO                                   = 0,
    SAY_DEATH                                   = 1,
    SAY_FAIL                                    = 2,
    SAY_THANKS                                  = 0
};

class boss_infinite_corruptor : public CreatureScript
{
public:
    boss_infinite_corruptor() : CreatureScript("boss_infinite_corruptor") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetCullingOfStratholmeAI<boss_infinite_corruptorAI>(creature);
    }

    struct boss_infinite_corruptorAI : public ScriptedAI
    {
        boss_infinite_corruptorAI(Creature* c) : ScriptedAI(c), summons(me)
        {
        }

        EventMap events;
        SummonList summons;
        uint32 beamTimer;

        void Reset() override
        {
            events.Reset();
            summons.DespawnAll();
            if (InstanceScript* pInstance = me->GetInstanceScript())
                if (pInstance->GetData(DATA_GUARDIANTIME_EVENT) == 0)
                    me->DespawnOrUnsummon(500);

            me->SummonCreature(NPC_TIME_RIFT, 2337.6f, 1270.0f, 132.95f, 2.79f);
            me->SummonCreature(NPC_GUARDIAN_OF_TIME, 2319.3f, 1267.7f, 132.8f, 1.0f);
            beamTimer = 1;
        }

        void JustSummoned(Creature* cr) override { summons.Summon(cr); }

        void JustEngagedWith(Unit* /*who*/) override
        {
            me->InterruptNonMeleeSpells(false);
            events.ScheduleEvent(EVENT_SPELL_VOID_STRIKE, 8000);
            events.ScheduleEvent(EVENT_SPELL_CORRUPTING_BLIGHT, 12000);
            Talk(SAY_AGGRO);
        }

        void JustDied(Unit* /*killer*/) override
        {
            Talk(SAY_DEATH);
            for (SummonList::const_iterator itr = summons.begin(); itr != summons.end(); ++itr)
            {
                if (Creature* cr = ObjectAccessor::GetCreature(*me, (*itr)))
                {
                    if (cr->GetEntry() == NPC_TIME_RIFT)
                    {
                        cr->DespawnOrUnsummon(1000);
                    }
                    else
                    {
                        cr->DespawnOrUnsummon(5000);
                        cr->RemoveAllAuras();
                        cr->AI()->Talk(SAY_THANKS);
                    }
                }
            }

            if (InstanceScript* pInstance = me->GetInstanceScript())
            {
                pInstance->SetData(DATA_SHOW_INFINITE_TIMER, 0);
                pInstance->DoRemoveAurasDueToSpellOnPlayers(SPELL_CORRUPTING_BLIGHT);
            }
        }

        void DoAction(int32 param) override
        {
            if (!me->IsAlive())
                return;

            if (param == ACTION_RUN_OUT_OF_TIME)
            {
                Talk(SAY_FAIL);
                summons.DespawnAll();
                me->DespawnOrUnsummon(500);
            }
        }

        void UpdateAI(uint32 diff) override
        {
            if (beamTimer)
            {
                beamTimer += diff;
                if (beamTimer >= 2000)
                {
                    me->CastSpell(me, SPELL_CORRUPTION_OF_TIME_CHANNEL, true);
                    beamTimer = 0;
                }
            }

            if (!UpdateVictim())
                return;

            events.Update(diff);
            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (events.ExecuteEvent())
            {
                case EVENT_SPELL_VOID_STRIKE:
                    me->CastSpell(me->GetVictim(), SPELL_VOID_STRIKE, false);
                    events.RepeatEvent(8000);
                    break;
                case EVENT_SPELL_CORRUPTING_BLIGHT:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 50.0f, true))
                        me->CastSpell(target, SPELL_CORRUPTING_BLIGHT, false);
                    events.RepeatEvent(12000);
                    break;
            }

            DoMeleeAttackIfReady();
        }
    };
};

void AddSC_boss_infinite_corruptor()
{
    new boss_infinite_corruptor();
}

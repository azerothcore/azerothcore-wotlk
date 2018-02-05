/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "the_botanica.h"

enum Says
{
    SAY_AGGRO               = 0,
    SAY_SLAY                = 1,
    SAY_SUMMON              = 2,
    SAY_DEATH               = 3
};

enum Spells
{
    SPELL_WAR_STOMP                 = 34716,
    SPELL_SUMMON_TREANTS            = 34730, // 34727, 34730 - 34737, 34739
    SPELL_ARCANE_VOLLEY             = 36705,

    SPELL_SUMMON_SAPLINGS_SUMMON    = 34730,
    SPELL_SUMMON_SAPLINGS_PERIODIC  = 34741
};

enum Misc
{
    EVENT_ARCANE_VOLLEY     = 1,
    EVENT_WAR_STOMP         = 2,
    EVENT_SUMMON_TREANT     = 3
};

class boss_warp_splinter : public CreatureScript
{
    public:

        boss_warp_splinter() : CreatureScript("boss_warp_splinter") { }
        struct boss_warp_splinterAI : public BossAI
        {
            boss_warp_splinterAI(Creature* creature) : BossAI(creature, DATA_WARP_SPLINTER) { }

            void Reset()
            {
                _Reset();
            }

            void EnterCombat(Unit* /*who*/)
            {
                _EnterCombat();
                Talk(SAY_AGGRO);

                events.ScheduleEvent(EVENT_ARCANE_VOLLEY, 8000);
                events.ScheduleEvent(EVENT_WAR_STOMP, 15000);
                events.ScheduleEvent(EVENT_SUMMON_TREANT, 20000);
            }

            void KilledUnit(Unit* victim)
            {
                if (victim->GetTypeId() == TYPEID_PLAYER)
                    Talk(SAY_SLAY);
            }

            void JustDied(Unit* /*killer*/)
            {
                _JustDied();
                Talk(SAY_DEATH);
            }

            void UpdateAI(uint32 diff)
            {
                if (!UpdateVictim())
                    return;

                events.Update(diff);
                if (me->HasUnitState(UNIT_STATE_CASTING))
                    return;

                switch (events.ExecuteEvent())
                {
                    case EVENT_ARCANE_VOLLEY:
                        me->CastSpell(me, SPELL_ARCANE_VOLLEY, false);
                        events.ScheduleEvent(EVENT_ARCANE_VOLLEY, 20000);
                        break;
                    case EVENT_WAR_STOMP:
                        me->CastSpell(me, SPELL_WAR_STOMP, false);
                        events.ScheduleEvent(EVENT_WAR_STOMP, 30000);
                        break;
                    case EVENT_SUMMON_TREANT:
                        Talk(SAY_SUMMON);
                        me->CastSpell(me, SPELL_SUMMON_SAPLINGS_PERIODIC, true);
                        for (uint8 i = 0; i < 6; ++i)
                            me->CastSpell(me, SPELL_SUMMON_SAPLINGS_SUMMON+i, true);
                        events.ScheduleEvent(EVENT_SUMMON_TREANT, 40000);
                        break;
                }

                DoMeleeAttackIfReady();
            }
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return new boss_warp_splinterAI(creature);
        }
};

void AddSC_boss_warp_splinter()
{
    new boss_warp_splinter();
}


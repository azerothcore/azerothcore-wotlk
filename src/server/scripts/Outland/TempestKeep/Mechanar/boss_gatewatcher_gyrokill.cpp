/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "mechanar.h"

enum Say
{
    SAY_AGGRO                       = 0,
    SAY_SLAY                        = 1,
    SAY_SAW_BLADE                   = 2,
    SAY_DEATH                       = 3
};

enum Spells
{
    SPELL_STREAM_OF_MACHINE_FLUID   = 35311,
    SPELL_SAW_BLADE                 = 35318,
    SPELL_SHADOW_POWER              = 35322
};

enum Events
{
    EVENT_STREAM_OF_MACHINE_FLUID   = 1,
    EVENT_SAW_BLADE                 = 2,
    EVENT_SHADOW_POWER              = 3
};

class boss_gatewatcher_gyrokill : public CreatureScript
{
    public:
        boss_gatewatcher_gyrokill() : CreatureScript("boss_gatewatcher_gyrokill") { }

        struct boss_gatewatcher_gyrokillAI : public BossAI
        {
            boss_gatewatcher_gyrokillAI(Creature* creature) : BossAI(creature, DATA_GATEWATCHER_GYROKILL) { }

            void JustDied(Unit* /*killer*/)
            {
                _JustDied();
                Talk(SAY_DEATH);
            }

            void EnterCombat(Unit* /*who*/)
            {
                _EnterCombat();
                events.ScheduleEvent(EVENT_STREAM_OF_MACHINE_FLUID, 10000);
                events.ScheduleEvent(EVENT_SAW_BLADE, 20000);
                events.ScheduleEvent(EVENT_SHADOW_POWER, 30000);
                Talk(SAY_AGGRO);
            }

            void KilledUnit(Unit* victim)
            {
                if (victim->GetTypeId() == TYPEID_PLAYER)
                    Talk(SAY_SLAY);
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
                    case EVENT_STREAM_OF_MACHINE_FLUID:
                        me->CastSpell(me->GetVictim(), SPELL_STREAM_OF_MACHINE_FLUID, false);
                        events.ScheduleEvent(EVENT_STREAM_OF_MACHINE_FLUID, urand(12000, 14000));
                        break;
                    case EVENT_SAW_BLADE:
                        if (Unit* target= SelectTarget(SELECT_TARGET_RANDOM, 0, 50.0f))
                            me->CastSpell(target, SPELL_SAW_BLADE, false);
                        Talk(SAY_SAW_BLADE);
                        events.ScheduleEvent(EVENT_SAW_BLADE, 25000);
                        break;
                    case EVENT_SHADOW_POWER:
                        me->CastSpell(me, SPELL_SHADOW_POWER, false);
                        events.ScheduleEvent(EVENT_SAW_BLADE, 25000);
                        break;
                }

                DoMeleeAttackIfReady();
            }
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return new boss_gatewatcher_gyrokillAI(creature);
        }
};

void AddSC_boss_gatewatcher_gyrokill()
{
    new boss_gatewatcher_gyrokill();
}

/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "karazhan.h"

enum Spells 
{
    SPELL_REPENTANCE    = 29511,
    SPELL_HOLYFIRE      = 29522,
    SPELL_HOLYWRATH     = 32445,
    SPELL_HOLYGROUND    = 29523,
    SPELL_BERSERK       = 26662
};

enum Yells
{
    SAY_AGGRO           = 0,
    SAY_SLAY            = 1,
    SAY_REPENTANCE      = 2,
    SAY_DEATH           = 3
};

enum Events
{
    EVENT_REPENTANCE    = 1,
    EVENT_HOLYFIRE      = 2,
    EVENT_HOLYWRATH     = 3,
    EVENT_ENRAGE        = 4
};

class boss_maiden_of_virtue : public CreatureScript
{
    public:
        boss_maiden_of_virtue() : CreatureScript("boss_maiden_of_virtue") { }

        struct boss_maiden_of_virtueAI : public BossAI
        {
            boss_maiden_of_virtueAI(Creature* creature) : BossAI(creature, DATA_MAIDEN) { }

            void Reset()
            {
                BossAI::Reset();
            }

            void KilledUnit(Unit* /*victim*/)
            {
                if (urand(0, 1) == 0)
                    Talk(SAY_SLAY);
            }

            void JustDied(Unit* killer)
            {
                BossAI::JustDied(killer);
                Talk(SAY_DEATH);
            }

            void EnterCombat(Unit* who)
            {
                BossAI::EnterCombat(who);
                Talk(SAY_AGGRO);

                DoCastSelf(SPELL_HOLYGROUND, true);
                events.ScheduleEvent(EVENT_REPENTANCE, urand(33000, 45000));
                events.ScheduleEvent(EVENT_HOLYFIRE, 8000);
                events.ScheduleEvent(EVENT_HOLYWRATH, urand(15000, 25000));
                events.ScheduleEvent(EVENT_ENRAGE, 600000);
                DoZoneInCombat();
            }

            void UpdateAI(uint32 diff)
            {
                if (!UpdateVictim())
                    return;

                events.Update(diff);
                if (me->HasUnitState(UNIT_STATE_CASTING))
                    return;

                while (uint32 eventId = events.ExecuteEvent())
                {

                    switch (eventId)
                    {
                        case EVENT_REPENTANCE:
                            DoCastVictim(SPELL_REPENTANCE);
                            Talk(SAY_REPENTANCE);
                            events.ScheduleEvent(EVENT_REPENTANCE, 35000);
                            break;
                        case EVENT_HOLYFIRE:
                            if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 50.0f, true))
                                DoCast(target, SPELL_HOLYFIRE);
                            events.ScheduleEvent(EVENT_HOLYFIRE, urand(8000, 19000));
                            break;
                        case EVENT_HOLYWRATH:
                            if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 40.0f, true))
                                DoCast(target, SPELL_HOLYWRATH);
                            events.ScheduleEvent(EVENT_HOLYWRATH, urand(15000, 25000));
                            break;
                        case EVENT_ENRAGE:
                            DoCastSelf(SPELL_BERSERK, true);
                            break;
                    }

                    if (me->HasUnitState(UNIT_STATE_CASTING))
                    return;
                }

                DoMeleeAttackIfReady();
            }
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return GetInstanceAI<boss_maiden_of_virtueAI>(creature);
        }
};

void AddSC_boss_maiden_of_virtue()
{
    new boss_maiden_of_virtue();
}

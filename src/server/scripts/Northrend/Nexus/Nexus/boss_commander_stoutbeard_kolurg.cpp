/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "nexus.h"

enum Spells
{
    SPELL_BATTLE_SHOUT              = 31403,
    SPELL_CHARGE                    = 60067,
    SPELL_FRIGHTENING_SHOUT         = 19134,
    SPELL_WHIRLWIND                 = 38618
};

enum Events
{
    EVENT_BATTLE_SHOUT              = 1,
    EVENT_FRIGHTENING_SHOUT         = 2,
    EVENT_WHIRLWIND                 = 3,
    EVENT_COMMANDER_CHARGE          = 4,
    EVENT_KILL_TALK                 = 5
};

enum Says
{
    SAY_AGGRO                       = 0,
    SAY_DEATH                       = 1,
    SAY_KILL                        = 2
};

class boss_commander_stoutbeard : public CreatureScript
{
    public:
        boss_commander_stoutbeard() : CreatureScript("boss_commander_stoutbeard") { }

        CreatureAI* GetAI(Creature* creature) const
        {
            return GetInstanceAI<boss_commander_stoutbeardAI>(creature);
        }

        struct boss_commander_stoutbeardAI : public BossAI
        {
            boss_commander_stoutbeardAI(Creature* creature) : BossAI(creature, DATA_COMMANDER_EVENT) 
            {
            }

            void Reset() 
            {
                BossAI::Reset();
            }

            void EnterCombat(Unit* who)
            {
                BossAI::EnterCombat(who);
                Talk(SAY_AGGRO);
                
                events.ScheduleEvent(EVENT_BATTLE_SHOUT, 0);
                events.ScheduleEvent(EVENT_FRIGHTENING_SHOUT, 10000);
                events.ScheduleEvent(EVENT_WHIRLWIND, 15000);
                events.ScheduleEvent(EVENT_COMMANDER_CHARGE, 1000);
                me->RemoveAllAuras();
            }

            void KilledUnit(Unit*)
            {
                if (events.GetNextEventTime(EVENT_KILL_TALK) == 0)
                {
                    Talk(SAY_KILL);
                    events.ScheduleEvent(EVENT_KILL_TALK, 6000);
                }
            }

            void JustDied(Unit* killer)
            {
                BossAI::JustDied(killer);
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
                    case EVENT_BATTLE_SHOUT:
                        me->CastSpell(me, SPELL_BATTLE_SHOUT, true);
                        events.ScheduleEvent(EVENT_BATTLE_SHOUT, 120000);
                        break;
                    case EVENT_FRIGHTENING_SHOUT:
                        me->CastSpell(me->GetVictim(), SPELL_FRIGHTENING_SHOUT, false);
                        events.ScheduleEvent(EVENT_FRIGHTENING_SHOUT, urand(15000, 20000));
                        break;
                    case EVENT_WHIRLWIND:
                        me->CastSpell(me, SPELL_WHIRLWIND, false);
                        events.ScheduleEvent(EVENT_WHIRLWIND, 16000);
                        break;
                    case EVENT_COMMANDER_CHARGE:
                        if (Unit* target = SelectTarget(SELECT_TARGET_FARTHEST, 0, 25.0f))
                            me->CastSpell(target, SPELL_CHARGE, false);
                        events.ScheduleEvent(EVENT_COMMANDER_CHARGE, 20000);
                        break;
                }

                DoMeleeAttackIfReady();
            }
        };
};

void AddSC_boss_commander_stoutbeard()
{
    new boss_commander_stoutbeard();
}

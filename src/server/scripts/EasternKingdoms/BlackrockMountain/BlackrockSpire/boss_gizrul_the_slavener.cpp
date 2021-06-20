/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "blackrock_spire.h"
#include "TemporarySummon.h"

enum Spells
{
    SPELL_FATAL_BITE                = 16495,
    SPELL_INFECTED_BITE             = 16128,
    SPELL_FRENZY                    = 8269
};

enum Paths
{
    GIZRUL_PATH                     = 402450
};

enum Events
{
    EVENT_FATAL_BITE                = 1,
    EVENT_INFECTED_BITE             = 2,
    EVENT_FRENZY                    = 3
};

class boss_gizrul_the_slavener : public CreatureScript
{
public:
    boss_gizrul_the_slavener() : CreatureScript("boss_gizrul_the_slavener") { }

    struct boss_gizrul_the_slavenerAI : public BossAI
    {
       boss_gizrul_the_slavenerAI(Creature* creature) : BossAI(creature, DATA_GIZRUL_THE_SLAVENER) { }

        void Reset()
        {
            _Reset();
        }

        void IsSummonedBy(Unit* /*summoner*/)
        {
            me->GetMotionMaster()->MovePath(GIZRUL_PATH, false);
        }

        void EnterCombat(Unit* /*who*/)
        {
            _EnterCombat();
            events.ScheduleEvent(EVENT_FATAL_BITE, urand(17000,20000));
            events.ScheduleEvent(EVENT_INFECTED_BITE, urand(10000,12000));
        }

        void JustDied(Unit* /*killer*/)
        {
            _JustDied();
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
                    case EVENT_FATAL_BITE:
                        DoCastVictim(SPELL_FATAL_BITE);
                        events.ScheduleEvent(EVENT_FATAL_BITE, urand(8000,10000));
                        break;
                    case EVENT_INFECTED_BITE:
                        DoCast(me, SPELL_INFECTED_BITE);
                        events.ScheduleEvent(EVENT_FATAL_BITE, urand(8000,10000));
                        break;
                    default:
                        break;
                }
            }
            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return new boss_gizrul_the_slavenerAI(creature);
    }
};

void AddSC_boss_gizrul_the_slavener()
{
    new boss_gizrul_the_slavener();
}

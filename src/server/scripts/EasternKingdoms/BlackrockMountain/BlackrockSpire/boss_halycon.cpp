/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "blackrock_spire.h"

enum Spells
{
    SPELL_REND                      = 13738,
    SPELL_THRASH                    = 3391,
};

enum Says
{
    EMOTE_DEATH                     = 0
};

enum Events
{
    EVENT_REND                      = 1,
    EVENT_THRASH                    = 2,
};

const Position SummonLocation = { -167.9561f, -411.7844f, 76.23057f, 1.53589f };

class boss_halycon : public CreatureScript
{
public:
    boss_halycon() : CreatureScript("boss_halycon") { }

    struct boss_halyconAI : public BossAI
    {
        boss_halyconAI(Creature* creature) : BossAI(creature, DATA_HALYCON) { }

        void Reset()
        {
            _Reset();
            Summoned = false;
        }

        void EnterCombat(Unit* /*who*/)
        {
            _EnterCombat();
            events.ScheduleEvent(EVENT_REND, urand(17000,20000));
            events.ScheduleEvent(EVENT_THRASH, urand(10000,12000));
        }

        void JustDied(Unit* /*killer*/)
        {
            me->SummonCreature(NPC_GIZRUL_THE_SLAVENER, SummonLocation, TEMPSUMMON_TIMED_DESPAWN, 300000);
            Talk(EMOTE_DEATH);

            Summoned = true;
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
                    case EVENT_REND:
                        DoCastVictim(SPELL_REND);
                        events.ScheduleEvent(EVENT_REND, urand(8000,10000));
                        break;
                    case EVENT_THRASH:
                        DoCast(me, SPELL_THRASH);
                        break;
                    default:
                        break;
                }
            }
            DoMeleeAttackIfReady();
        }
        private:
            bool Summoned;
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return new boss_halyconAI(creature);
    }
};

void AddSC_boss_halycon()
{
    new boss_halycon();
}

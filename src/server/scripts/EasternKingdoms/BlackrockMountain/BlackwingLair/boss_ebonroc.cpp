/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "blackwing_lair.h"

enum Spells
{
    SPELL_SHADOWFLAME           = 22539,
    SPELL_WINGBUFFET            = 23339,
    SPELL_SHADOWOFEBONROC       = 23340
};

enum Events
{
    EVENT_SHADOWFLAME           = 1,
    EVENT_WINGBUFFET            = 2,
    EVENT_SHADOWOFEBONROC       = 3
};

class boss_ebonroc : public CreatureScript
{
public:
    boss_ebonroc() : CreatureScript("boss_ebonroc") { }

    struct boss_ebonrocAI : public BossAI
    {
        boss_ebonrocAI(Creature* creature) : BossAI(creature, BOSS_EBONROC) { }

        void EnterCombat(Unit* /*who*/)
        {
            if (instance->GetBossState(BOSS_BROODLORD) != DONE)
            {
                EnterEvadeMode();
                return;
            }
            _EnterCombat();

            events.ScheduleEvent(EVENT_SHADOWFLAME, urand(10000, 20000));
            events.ScheduleEvent(EVENT_WINGBUFFET, 30000);
            events.ScheduleEvent(EVENT_SHADOWOFEBONROC, urand(8000, 10000));
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
                    case EVENT_SHADOWFLAME:
                        DoCastVictim(SPELL_SHADOWFLAME);
                        events.ScheduleEvent(EVENT_SHADOWFLAME, urand(10000, 20000));
                        break;
                    case EVENT_WINGBUFFET:
                        DoCastVictim(SPELL_WINGBUFFET);
                        events.ScheduleEvent(EVENT_WINGBUFFET, 30000);
                        break;
                    case EVENT_SHADOWOFEBONROC:
                        DoCastVictim(SPELL_SHADOWOFEBONROC);
                        events.ScheduleEvent(EVENT_SHADOWOFEBONROC, urand(8000, 10000));
                        break;
                }
            }

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return GetInstanceAI<boss_ebonrocAI>(creature);
    }
};

void AddSC_boss_ebonroc()
{
    new boss_ebonroc();
}

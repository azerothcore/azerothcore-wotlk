/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include "blackwing_lair.h"
#include "ScriptedCreature.h"
#include "ScriptMgr.h"

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
        boss_ebonrocAI(Creature* creature) : BossAI(creature, DATA_EBONROC) { }

        void EnterCombat(Unit* who) override
        {
            BossAI::EnterCombat(who);

            events.ScheduleEvent(EVENT_SHADOWFLAME, 10000, 20000);
            events.ScheduleEvent(EVENT_WINGBUFFET, 30000);
            events.ScheduleEvent(EVENT_SHADOWOFEBONROC, 8000, 10000);
        }

        void UpdateAI(uint32 diff) override
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
                        events.ScheduleEvent(EVENT_SHADOWFLAME, 10000, 20000);
                        break;
                    case EVENT_WINGBUFFET:
                        DoCastVictim(SPELL_WINGBUFFET);
                        events.ScheduleEvent(EVENT_WINGBUFFET, 30000);
                        break;
                    case EVENT_SHADOWOFEBONROC:
                        DoCastVictim(SPELL_SHADOWOFEBONROC);
                        events.ScheduleEvent(EVENT_SHADOWOFEBONROC, 8000, 10000);
                        break;
                }

                if (me->HasUnitState(UNIT_STATE_CASTING))
                    return;
            }

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetInstanceAI<boss_ebonrocAI>(creature);
    }
};

void AddSC_boss_ebonroc()
{
    new boss_ebonroc();
}

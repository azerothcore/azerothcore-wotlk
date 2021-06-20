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
    SPELL_SHADOWFLAME       = 22539,
    SPELL_WINGBUFFET        = 23339,
    SPELL_FLAMEBUFFET       = 23341
};

enum Events
{
    EVENT_SHADOWFLAME       = 1,
    EVENT_WINGBUFFET        = 2,
    EVENT_FLAMEBUFFET       = 3
};

class boss_firemaw : public CreatureScript
{
public:
    boss_firemaw() : CreatureScript("boss_firemaw") { }

    struct boss_firemawAI : public BossAI
    {
        boss_firemawAI(Creature* creature) : BossAI(creature, BOSS_FIREMAW) { }

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
            events.ScheduleEvent(EVENT_FLAMEBUFFET, 5000);
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
                        if (DoGetThreat(me->GetVictim()))
                            DoModifyThreatPercent(me->GetVictim(), -75);
                        events.ScheduleEvent(EVENT_WINGBUFFET, 30000);
                        break;
                    case EVENT_FLAMEBUFFET:
                        DoCastVictim(SPELL_FLAMEBUFFET);
                        events.ScheduleEvent(EVENT_FLAMEBUFFET, 5000);
                        break;
                }
            }

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return GetInstanceAI<boss_firemawAI>(creature);
    }
};

void AddSC_boss_firemaw()
{
    new boss_firemaw();
}

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
    SPELL_SHOOT                     = 16496,
    SPELL_STUNBOMB                  = 16497,
    SPELL_HEALING_POTION            = 15504,
    SPELL_HOOKEDNET                 = 15609
};

enum Events
{
    EVENT_SHOOT                     = 1,
    EVENT_STUN_BOMB                 = 2
};

class quartermaster_zigris : public CreatureScript
{
public:
    quartermaster_zigris() : CreatureScript("quartermaster_zigris") { }

    struct boss_quatermasterzigrisAI : public BossAI
    {
        boss_quatermasterzigrisAI(Creature* creature) : BossAI(creature, DATA_QUARTERMASTER_ZIGRIS) { }

        void Reset()
        {
            _Reset();
        }

        void EnterCombat(Unit* /*who*/)
        {
            _EnterCombat();
            events.ScheduleEvent(EVENT_SHOOT,      1000);
            events.ScheduleEvent(EVENT_STUN_BOMB, 16000);
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
                    case EVENT_SHOOT:
                        DoCastVictim(SPELL_SHOOT);
                        events.ScheduleEvent(EVENT_SHOOT, 500);
                        break;
                    case EVENT_STUN_BOMB:
                        DoCastVictim(SPELL_STUNBOMB);
                        events.ScheduleEvent(EVENT_STUN_BOMB, 14000);
                        break;
                }
            }
            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return new boss_quatermasterzigrisAI(creature);
    }
};

void AddSC_boss_quatermasterzigris()
{
    new quartermaster_zigris();
}

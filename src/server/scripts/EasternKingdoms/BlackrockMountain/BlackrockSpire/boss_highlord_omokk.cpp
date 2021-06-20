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
    SPELL_FRENZY                    = 8269,
    SPELL_KNOCK_AWAY                = 10101
};

enum Events
{
    EVENT_FRENZY                    = 1,
    EVENT_KNOCK_AWAY                = 2
};

class boss_highlord_omokk : public CreatureScript
{
public:
    boss_highlord_omokk() : CreatureScript("boss_highlord_omokk") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new boss_highlordomokkAI(creature);
    }

    struct boss_highlordomokkAI : public BossAI
    {
        boss_highlordomokkAI(Creature* creature) : BossAI(creature, DATA_HIGHLORD_OMOKK) { }

        void Reset()
        {
            _Reset();
        }

        void EnterCombat(Unit* /*who*/)
        {
            _EnterCombat();
            events.ScheduleEvent(EVENT_FRENZY,      20000);
            events.ScheduleEvent(EVENT_KNOCK_AWAY,  18000);
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
                    case EVENT_FRENZY:
                        DoCastVictim(SPELL_FRENZY);
                        events.ScheduleEvent(EVENT_FRENZY, 60000);
                        break;
                    case EVENT_KNOCK_AWAY:
                        DoCastVictim(SPELL_KNOCK_AWAY);
                        events.ScheduleEvent(EVENT_KNOCK_AWAY, 12000);
                        break;
                    default:
                        break;
                }
            }
            DoMeleeAttackIfReady();
        }
    };

};

void AddSC_boss_highlordomokk()
{
    new boss_highlord_omokk();
}

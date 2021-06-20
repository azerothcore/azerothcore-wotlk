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
    SPELL_FLAMEBREAK                = 16785,
    SPELL_IMMOLATE                  = 20294,
    SPELL_TERRIFYINGROAR            = 14100,
};

enum Events
{
    EVENT_FLAME_BREAK              = 1,
    EVENT_IMMOLATE                 = 2,
    EVENT_TERRIFYING_ROAR          = 3,
};

class boss_the_beast : public CreatureScript
{
public:
    boss_the_beast() : CreatureScript("boss_the_beast") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new boss_thebeastAI(creature);
    }

    struct boss_thebeastAI : public BossAI
    {
        boss_thebeastAI(Creature* creature) : BossAI(creature, DATA_THE_BEAST) { }

        void Reset()
        {
            _Reset();
        }

        void EnterCombat(Unit* /*who*/)
        {
            _EnterCombat();
            events.ScheduleEvent(EVENT_FLAME_BREAK,     12 * IN_MILLISECONDS);
            events.ScheduleEvent(EVENT_IMMOLATE,         3 * IN_MILLISECONDS);
            events.ScheduleEvent(EVENT_TERRIFYING_ROAR, 23 * IN_MILLISECONDS);
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
                    case EVENT_FLAME_BREAK:
                        DoCastVictim(SPELL_FLAMEBREAK);
                        events.ScheduleEvent(EVENT_FLAME_BREAK, 10 * IN_MILLISECONDS);
                        break;
                    case EVENT_IMMOLATE:
                        if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 100, true))
                            DoCast(target, SPELL_IMMOLATE);
                        events.ScheduleEvent(EVENT_IMMOLATE, 8 * IN_MILLISECONDS);
                        break;
                    case EVENT_TERRIFYING_ROAR:
                        DoCastVictim(SPELL_TERRIFYINGROAR);
                        events.ScheduleEvent(EVENT_TERRIFYING_ROAR, 20 * IN_MILLISECONDS);
                        break;
                }
            }
            DoMeleeAttackIfReady();
        }
    };
};

void AddSC_boss_thebeast()
{
    new boss_the_beast();
}

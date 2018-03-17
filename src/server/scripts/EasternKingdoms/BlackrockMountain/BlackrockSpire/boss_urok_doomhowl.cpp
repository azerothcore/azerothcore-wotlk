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
    SPELL_REND                      = 16509,
    SPELL_STRIKE                    = 15580,
    SPELL_INTIMIDATING_ROAR         = 16508,
    SPELL_UROK_SPAWN                = 16473,
};

enum Says
{
    SAY_SUMMON                      = 0,
    SAY_AGGRO                       = 1,
};

enum Events
{
    EVENT_REND                      = 1,
    EVENT_STRIKE                    = 2,
    EVENT_INTIMIDATING_ROAR         = 3
};

class boss_urok_doomhowl : public CreatureScript
{
public:
    boss_urok_doomhowl() : CreatureScript("boss_urok_doomhowl") { }

    struct boss_urok_doomhowlAI : public BossAI
    {
        boss_urok_doomhowlAI(Creature* creature) : BossAI(creature, DATA_UROK_DOOMHOWL) {}

        void Reset()
        {
            _Reset();
        }

        void InitializeAI()
        {
            me->CastSpell(me, SPELL_UROK_SPAWN, true);
            BossAI::InitializeAI();
        }

        void EnterCombat(Unit* /*who*/)
        {
            _EnterCombat();
            events.ScheduleEvent(SPELL_REND, urand(17000,20000));
            events.ScheduleEvent(SPELL_STRIKE, urand(10000,12000));
            Talk(SAY_AGGRO);
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
                    case SPELL_REND:
                        DoCastVictim(SPELL_REND);
                        events.ScheduleEvent(SPELL_REND, urand(8000,10000));
                        break;
                    case SPELL_STRIKE:
                        DoCastVictim(SPELL_STRIKE);
                        events.ScheduleEvent(SPELL_STRIKE, urand(8000,10000));
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
        return new boss_urok_doomhowlAI(creature);
    }
};

void AddSC_boss_urok_doomhowl()
{
    new boss_urok_doomhowl();
}

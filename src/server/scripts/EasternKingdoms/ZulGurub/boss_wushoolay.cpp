/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

/* ScriptData
SDName: Boss_Wushoolay
SD%Complete: 100
SDComment:
SDCategory: Zul'Gurub
EndScriptData */

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "zulgurub.h"

enum Spells
{
    SPELL_LIGHTNINGCLOUD        = 25033,
    SPELL_LIGHTNINGWAVE         = 24819
};

enum Events
{
    EVENT_LIGHTNINGCLOUD        = 1,
    EVENT_LIGHTNINGWAVE         = 2
};

class boss_wushoolay : public CreatureScript
{
    public: boss_wushoolay() : CreatureScript("boss_wushoolay") { }

        struct boss_wushoolayAI : public BossAI
        {
            boss_wushoolayAI(Creature* creature) : BossAI(creature, DATA_EDGE_OF_MADNESS) { }

            void Reset()
            {
                _Reset();
            }

            void JustDied(Unit* /*killer*/)
            {
                _JustDied();
            }

            void EnterCombat(Unit* /*who*/)
            {
                _EnterCombat();
                events.ScheduleEvent(EVENT_LIGHTNINGCLOUD, urand(5000, 10000));
                events.ScheduleEvent(EVENT_LIGHTNINGWAVE, urand(8000, 16000));
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
                        case EVENT_LIGHTNINGCLOUD:
                            DoCastVictim(SPELL_LIGHTNINGCLOUD, true);
                            events.ScheduleEvent(EVENT_LIGHTNINGCLOUD, urand(15000, 20000));
                            break;
                        case EVENT_LIGHTNINGWAVE:
                            DoCast(SelectTarget(SELECT_TARGET_RANDOM, 0, 100, true), SPELL_LIGHTNINGWAVE);
                            events.ScheduleEvent(EVENT_LIGHTNINGWAVE, urand(12000, 16000));
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
            return new boss_wushoolayAI(creature);
        }
};

void AddSC_boss_wushoolay()
{
    new boss_wushoolay();
}


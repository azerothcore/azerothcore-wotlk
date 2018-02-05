/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

/* ScriptData
SDName: Boss_Hazzarah
SD%Complete: 100
SDComment:
SDCategory: Zul'Gurub
EndScriptData */

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "zulgurub.h"

enum Spells
{
    SPELL_MANABURN              = 26046,
    SPELL_SLEEP                 = 24664
};

enum Events
{
    EVENT_MANABURN              = 1,
    EVENT_SLEEP                 = 2,
    EVENT_ILLUSIONS             = 3
};

class boss_hazzarah : public CreatureScript
{
    public: boss_hazzarah() : CreatureScript("boss_hazzarah") { }

        struct boss_hazzarahAI : public BossAI
        {
            boss_hazzarahAI(Creature* creature) : BossAI(creature, DATA_EDGE_OF_MADNESS) { }

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
                events.ScheduleEvent(EVENT_MANABURN, urand(4000, 10000));
                events.ScheduleEvent(EVENT_SLEEP, urand(10000, 18000));
                events.ScheduleEvent(EVENT_ILLUSIONS, urand(10000, 18000));
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
                        case EVENT_MANABURN:
                            DoCastVictim(SPELL_MANABURN, true);
                            events.ScheduleEvent(EVENT_MANABURN, urand(8000, 16000));
                            break;
                        case EVENT_SLEEP:
                            DoCastVictim(SPELL_SLEEP, true);
                            events.ScheduleEvent(EVENT_SLEEP, urand(12000, 20000));
                            break;
                        case EVENT_ILLUSIONS:
                            // We will summon 3 illusions that will spawn on a random gamer and attack this gamer
                            // We will just use one model for the beginning
                            for (uint8 i = 0; i < 3; ++i)
                            {
                                if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0))
                                {
                                    Creature* Illusion = me->SummonCreature(NPC_NIGHTMARE_ILLUSION, target->GetPositionX(), target->GetPositionY(), target->GetPositionZ(), 0, TEMPSUMMON_TIMED_OR_CORPSE_DESPAWN, 30000);
                                    if (Illusion)
                                        Illusion->AI()->AttackStart(target);
                                }
                            }
                            events.ScheduleEvent(EVENT_ILLUSIONS, urand(15000, 25000));
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
            return new boss_hazzarahAI(creature);
        }
};

void AddSC_boss_hazzarah()
{
    new boss_hazzarah();
}

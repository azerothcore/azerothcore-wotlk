/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

/* ScriptData
SDName: Boss_Grilek
SD%Complete: 100
SDComment:
SDCategory: Zul'Gurub
EndScriptData */

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "zulgurub.h"

enum Spells
{
    SPELL_AVATAR                    = 24646, // Enrage Spell
    SPELL_GROUND_TREMOR             = 6524
};

enum Events
{
    EVENT_AVATAR                    = 1,
    EVENT_GROUND_TREMOR             = 2
};

class boss_grilek : public CreatureScript // grilek
{
    public: boss_grilek() : CreatureScript("boss_grilek") { }

        struct boss_grilekAI : public BossAI
        {
            boss_grilekAI(Creature* creature) : BossAI(creature, DATA_EDGE_OF_MADNESS) { }

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
                events.ScheduleEvent(EVENT_AVATAR, urand(15000, 25000));
                events.ScheduleEvent(EVENT_GROUND_TREMOR, urand(15000, 25000));
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
                        case EVENT_AVATAR:
                            DoCast(me, SPELL_AVATAR);
                            if (Unit* victim = me->GetVictim())
                            {
                                if (DoGetThreat(victim))
                                    DoModifyThreatPercent(victim, -50);
                            }

                            if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 1))
                                AttackStart(target);
                            events.ScheduleEvent(EVENT_AVATAR, urand(25000, 35000));
                            break;
                        case EVENT_GROUND_TREMOR:
                            DoCastVictim(SPELL_GROUND_TREMOR, true);
                            events.ScheduleEvent(EVENT_GROUND_TREMOR, urand(12000, 16000));
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
            return new boss_grilekAI(creature);
        }
};

void AddSC_boss_grilek()
{
    new boss_grilek();
}


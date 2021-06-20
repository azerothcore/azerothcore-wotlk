/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

/* ScriptData
SDName: Boss_Gahz'ranka
SD%Complete: 85
SDComment: Massive Geyser with knockback not working. Spell buggy.
SDCategory: Zul'Gurub
EndScriptData */

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "zulgurub.h"

enum Spells
{
    SPELL_FROSTBREATH               = 16099,
    SPELL_MASSIVEGEYSER             = 22421, // Not working. (summon)
    SPELL_SLAM                      = 24326
};

enum Events
{
    EVENT_FROSTBREATH               = 1,
    EVENT_MASSIVEGEYSER             = 2,
    EVENT_SLAM                      = 3
};

class boss_gahzranka : public CreatureScript // gahzranka
{
    public: boss_gahzranka() : CreatureScript("boss_gahzranka") { }

        struct boss_gahzrankaAI : public BossAI
        {
            boss_gahzrankaAI(Creature* creature) : BossAI(creature, DATA_GAHZRANKA) { }

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
                events.ScheduleEvent(EVENT_FROSTBREATH, 8000);
                events.ScheduleEvent(EVENT_MASSIVEGEYSER, 25000);
                events.ScheduleEvent(EVENT_SLAM, 17000);
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
                        case EVENT_FROSTBREATH:
                            DoCastVictim(SPELL_FROSTBREATH, true);
                            events.ScheduleEvent(EVENT_FROSTBREATH, urand(7000, 11000));
                            break;
                        case EVENT_MASSIVEGEYSER:
                            DoCastVictim(SPELL_MASSIVEGEYSER, true);
                            events.ScheduleEvent(EVENT_MASSIVEGEYSER, urand(22000, 32000));
                            break;
                        case EVENT_SLAM:
                            DoCastVictim(SPELL_SLAM, true);
                            events.ScheduleEvent(EVENT_SLAM, urand(12000, 20000));
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
            return new boss_gahzrankaAI(creature);
        }
};

void AddSC_boss_gahzranka()
{
    new boss_gahzranka();
}

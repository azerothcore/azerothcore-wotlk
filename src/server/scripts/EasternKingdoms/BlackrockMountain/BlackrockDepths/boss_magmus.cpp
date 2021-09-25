/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include "blackrock_depths.h"
#include "ScriptedCreature.h"
#include "ScriptMgr.h"

enum Spells
{
    SPELL_FIERYBURST                                       = 13900,
    SPELL_WARSTOMP                                         = 24375
};

enum SpellTimers
{
    SPELL_FIERYBURST_MIN = 4000,
    SPELL_FIERYBURST_MAX = 8000,
    SPELL_WARSTOMP_MIN   = 8000,
    SPELL_WARSTOMP_MAX   = 12000
};

class boss_magmus : public CreatureScript
{
public:
    boss_magmus() : CreatureScript("boss_magmus") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetBlackrockDepthsAI<boss_magmusAI>(creature);
    }

    struct boss_magmusAI : public BossAI
    {
        boss_magmusAI(Creature* creature) : BossAI(creature, TYPE_IRON_HALL) {}

        void Reset() override
        {
            _Reset();
            instance->SetData(TYPE_IRON_HALL, NOT_STARTED);
        }

        void EnterCombat(Unit* /*who*/) override
        {
            instance->SetData(TYPE_IRON_HALL, IN_PROGRESS);
            _EnterCombat();
            events.ScheduleEvent(SPELL_FIERYBURST, urand(SPELL_FIERYBURST_MIN, SPELL_FIERYBURST_MAX));
            events.ScheduleEvent(SPELL_WARSTOMP, urand(SPELL_WARSTOMP_MIN, SPELL_WARSTOMP_MAX));

        }

        void UpdateAI(uint32 diff) override
        {
            //Return since we have no target
            if (!UpdateVictim())
                return;

            events.Update(diff);

            while (uint32 eventId = events.ExecuteEvent())
            {
                switch (eventId)
                {
                case SPELL_WARSTOMP:
                    DoCastVictim(SPELL_WARSTOMP);
                    events.ScheduleEvent(SPELL_WARSTOMP, urand(SPELL_WARSTOMP_MIN, SPELL_WARSTOMP_MAX));
                    break;
                case SPELL_FIERYBURST:
                    DoCastVictim(SPELL_FIERYBURST);
                    events.ScheduleEvent(SPELL_FIERYBURST, urand(SPELL_FIERYBURST_MIN, SPELL_FIERYBURST_MAX));
                    break;
                default:
                    break;
                }
            }

            DoMeleeAttackIfReady();
        }
    };
};

void AddSC_boss_magmus()
{
    new boss_magmus();
}

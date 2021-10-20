/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

/* ScriptData
SDName: Boss_Lucifron
SD%Complete: 100
SDComment:
SDCategory: Molten Core
EndScriptData */

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "molten_core.h"

enum Spells
{
    SPELL_IMPENDING_DOOM    = 19702,
    SPELL_LUCIFRON_CURSE    = 19703,
    SPELL_SHADOW_SHOCK      = 20603,
};

enum Events
{
    EVENT_IMPENDING_DOOM    = 1,
    EVENT_LUCIFRON_CURSE    = 2,
    EVENT_SHADOW_SHOCK      = 3,
};

class boss_lucifron : public CreatureScript
{
public:
    boss_lucifron() : CreatureScript("boss_lucifron") { }

    struct boss_lucifronAI : public BossAI
    {
        boss_lucifronAI(Creature* creature) : BossAI(creature, DATA_LUCIFRON) {}

        void EnterCombat(Unit* /*victim*/) override
        {
            _EnterCombat();
            events.ScheduleEvent(EVENT_IMPENDING_DOOM, urand(6000, 11000));
            events.ScheduleEvent(EVENT_LUCIFRON_CURSE, urand(11000, 14000));
            events.ScheduleEvent(EVENT_SHADOW_SHOCK, 5000);
        }

        void ExecuteEvent(uint32 eventId) override
        {
            switch (eventId)
            {
                case EVENT_IMPENDING_DOOM:
                {
                    DoCastVictim(SPELL_IMPENDING_DOOM);
                    events.RepeatEvent(20000);
                    break;
                }
                case EVENT_LUCIFRON_CURSE:
                {
                    DoCastVictim(SPELL_LUCIFRON_CURSE);
                    events.RepeatEvent(20000);
                    break;
                }
                case EVENT_SHADOW_SHOCK:
                {
                    DoCastVictim(SPELL_SHADOW_SHOCK);
                    events.RepeatEvent(5000);
                    break;
                }
            }
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetMoltenCoreAI<boss_lucifronAI>(creature);
    }
};

void AddSC_boss_lucifron()
{
    new boss_lucifron();
}

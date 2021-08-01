/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include "blackrock_spire.h"
#include "ScriptedCreature.h"
#include "ScriptMgr.h"

enum Spells
{
    SPELL_CURSEOFBLOOD              = 24673,
    SPELL_HEX                       = 16708,
    SPELL_CLEAVE                    = 20691,
};

enum Events
{
    EVENT_CURSE_OF_BLOOD            = 1,
    EVENT_HEX                       = 2,
    EVENT_CLEAVE                    = 3,
};

class boss_shadow_hunter_voshgajin : public CreatureScript
{
public:
    boss_shadow_hunter_voshgajin() : CreatureScript("boss_shadow_hunter_voshgajin") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetBlackrockSpireAI<boss_shadowvoshAI>(creature);
    }

    struct boss_shadowvoshAI : public BossAI
    {
        boss_shadowvoshAI(Creature* creature) : BossAI(creature, DATA_SHADOW_HUNTER_VOSHGAJIN) { }

        void Reset() override
        {
            _Reset();
            //DoCast(me, SPELL_ICEARMOR, true);
        }

        void EnterCombat(Unit* /*who*/) override
        {
            _EnterCombat();
            events.ScheduleEvent(EVENT_CURSE_OF_BLOOD, 2 * IN_MILLISECONDS);
            events.ScheduleEvent(EVENT_HEX,     8 * IN_MILLISECONDS);
            events.ScheduleEvent(EVENT_CLEAVE, 14 * IN_MILLISECONDS);
        }

        void JustDied(Unit* /*killer*/) override
        {
            _JustDied();
        }

        void UpdateAI(uint32 diff) override
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
                    case EVENT_CURSE_OF_BLOOD:
                        DoCastVictim(SPELL_CURSEOFBLOOD);
                        events.ScheduleEvent(EVENT_CURSE_OF_BLOOD, 45 * IN_MILLISECONDS);
                        break;
                    case EVENT_HEX:
                        if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 100, true))
                            DoCast(target, SPELL_HEX);
                        events.ScheduleEvent(EVENT_HEX, 15 * IN_MILLISECONDS);
                        break;
                    case EVENT_CLEAVE:
                        DoCastVictim(SPELL_CLEAVE);
                        events.ScheduleEvent(EVENT_CLEAVE, 7 * IN_MILLISECONDS);
                        break;
                }
            }
            DoMeleeAttackIfReady();
        }
    };
};

void AddSC_boss_shadowvosh()
{
    new boss_shadow_hunter_voshgajin();
}

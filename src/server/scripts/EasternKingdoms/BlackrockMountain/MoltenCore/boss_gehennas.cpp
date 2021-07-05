/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

/* ScriptData
SDName: Boss_Gehennas
SD%Complete: 90
SDComment: Adds MC NYI
SDCategory: Molten Core
EndScriptData */

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "molten_core.h"

enum Spells
{
    SPELL_GEHENNAS_CURSE        = 19716,
    SPELL_RAIN_OF_FIRE          = 19717,
    SPELL_SHADOW_BOLT_RANDOM    = 19728,
    SPELL_SHADOW_BOLT_VICTIM    = 19729,
};

enum Events
{
    EVENT_GEHENNAS_CURSE    = 1,
    EVENT_RAIN_OF_FIRE,
    EVENT_SHADOW_BOLT,
};

class boss_gehennas : public CreatureScript
{
public:
    boss_gehennas() : CreatureScript("boss_gehennas") { }

    struct boss_gehennasAI : public BossAI
    {
        boss_gehennasAI(Creature* creature) : BossAI(creature, BOSS_GEHENNAS)
        {
        }

        void EnterCombat(Unit* /*attacker*/) override
        {
            _EnterCombat();
            events.ScheduleEvent(EVENT_GEHENNAS_CURSE, urand(6000, 9000));
            events.ScheduleEvent(EVENT_RAIN_OF_FIRE, 10000);
            events.ScheduleEvent(EVENT_SHADOW_BOLT, urand(3000, 5000));
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
            {
                return;
            }

            events.Update(diff);

            if (me->HasUnitState(UNIT_STATE_CASTING))
            {
                return;
            }

            while (uint32 const eventId = events.ExecuteEvent())
            {
                switch (eventId)
                {
                    case EVENT_GEHENNAS_CURSE:
                    {
                        DoCastVictim(SPELL_GEHENNAS_CURSE);
                        events.RepeatEvent(urand(25000, 30000));
                        break;
                    }
                    case EVENT_RAIN_OF_FIRE:
                    {
                        if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 0.0f, true))
                        {
                            DoCast(target, SPELL_RAIN_OF_FIRE);
                        }
                        events.RepeatEvent(6000);
                        break;
                    }
                    case EVENT_SHADOW_BOLT:
                    {
                        if (urand(0, 1))
                        {
                            if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 1, 0.0f, true))
                            {
                                DoCast(target, SPELL_SHADOW_BOLT_RANDOM);
                            }
                            else
                            {
                                DoCastVictim(SPELL_SHADOW_BOLT_VICTIM);
                            }
                        }
                        else
                        {
                            DoCastVictim(SPELL_SHADOW_BOLT_VICTIM);
                        }

                        events.RepeatEvent(5000);
                        break;
                    }
                }

                if (me->HasUnitState(UNIT_STATE_CASTING))
                {
                    return;
                }
            }

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetMoltenCoreAI<boss_gehennasAI>(creature);
    }
};

void AddSC_boss_gehennas()
{
    new boss_gehennas();
}

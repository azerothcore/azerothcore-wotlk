/*
 * Originally written by Pussywizard - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "violet_hold.h"

enum eSpells
{
  SPELL_CAUTERIZING_FLAMES                  = 59466,
  SPELL_FIREBOLT_N                          = 54235,
  SPELL_FIREBOLT_H                          = 59468,
  SPELL_FLAME_BREATH_N                      = 54282,
  SPELL_FLAME_BREATH_H                      = 59469,
  SPELL_LAVA_BURN_N                         = 54249,
  SPELL_LAVA_BURN_H                         = 59594,
};

#define SPELL_FIREBOLT                      DUNGEON_MODE(SPELL_FIREBOLT_N, SPELL_FIREBOLT_H)
#define SPELL_FLAME_BREATH                  DUNGEON_MODE(SPELL_FLAME_BREATH_N, SPELL_FLAME_BREATH_H)
#define SPELL_LAVA_BURN                     DUNGEON_MODE(SPELL_LAVA_BURN_N, SPELL_LAVA_BURN_H)

enum eEvents
{
    EVENT_SPELL_FIREBOLT = 1,
    EVENT_SPELL_FLAME_BREATH,
    EVENT_SPELL_LAVA_BURN,
    EVENT_SPELL_CAUTERIZING_FLAMES,
};

class boss_lavanthor : public CreatureScript
{
public:
    boss_lavanthor() : CreatureScript("boss_lavanthor") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new boss_lavanthorAI (pCreature);
    }

    struct boss_lavanthorAI : public ScriptedAI
    {
        boss_lavanthorAI(Creature *c) : ScriptedAI(c)
        {
            pInstance = c->GetInstanceScript();
        }

        InstanceScript* pInstance;
        EventMap events;

        void Reset()
        {
            events.Reset();
        }

        void EnterCombat(Unit* /*who*/)
        {
            DoZoneInCombat();
            events.Reset();
            events.RescheduleEvent(EVENT_SPELL_FIREBOLT, 1000);
            events.RescheduleEvent(EVENT_SPELL_FLAME_BREATH, 5000);
            events.RescheduleEvent(EVENT_SPELL_LAVA_BURN, 10000);
            if (IsHeroic())
                events.RescheduleEvent(EVENT_SPELL_CAUTERIZING_FLAMES, 3000);
        }

        void UpdateAI(uint32 diff)
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch(events.GetEvent())
            {
                case 0:
                    break;
                case EVENT_SPELL_FIREBOLT:
                    me->CastSpell(me->GetVictim(), SPELL_FIREBOLT, false);
                    events.RepeatEvent(urand(5000,13000));
                    break;
                case EVENT_SPELL_FLAME_BREATH:
                    me->CastSpell(me->GetVictim(), SPELL_FLAME_BREATH, false);
                    events.RepeatEvent(urand(10000,15000));
                    break;
                case EVENT_SPELL_LAVA_BURN:
                    me->CastSpell(me->GetVictim(), SPELL_LAVA_BURN, false);
                    events.RepeatEvent(urand(14000,20000));
                    break;
                case EVENT_SPELL_CAUTERIZING_FLAMES:
                    me->CastSpell((Unit*)NULL, SPELL_FLAME_BREATH, false);
                    events.RepeatEvent(urand(10000,16000));
                    break;
            }

            DoMeleeAttackIfReady();
        }

        void JustDied(Unit* /*killer*/)
        {
            if (pInstance)
                pInstance->SetData(DATA_BOSS_DIED, 0);
        }

        void MoveInLineOfSight(Unit* /*who*/) {}

        void EnterEvadeMode()
        {
            ScriptedAI::EnterEvadeMode();
            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
            if (pInstance)
                pInstance->SetData(DATA_FAILED, 1);
        }
    };
};

void AddSC_boss_lavanthor()
{
    new boss_lavanthor();
}

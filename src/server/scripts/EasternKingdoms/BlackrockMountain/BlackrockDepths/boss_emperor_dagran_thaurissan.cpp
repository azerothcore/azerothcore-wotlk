/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include "blackrock_depths.h"
#include "ScriptedCreature.h"
#include "ScriptMgr.h"

enum Yells
{
    YELL_SENATORS_ALIVE = 0,
    YELL_SENATORS_DEAD  = 1,
    SAY_SLAY            = 2
};

enum Spells
{
    SPELL_HANDOFTHAURISSAN                                 = 17492,
    SPELL_AVATAROFFLAME                                    = 15636
};

#define PERCENT_DEAD_SENATORS 0

class boss_emperor_dagran_thaurissan : public CreatureScript
{
public:
    boss_emperor_dagran_thaurissan() : CreatureScript("boss_emperor_dagran_thaurissan") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetBlackrockDepthsAI<boss_draganthaurissanAI>(creature);
    }

    struct boss_draganthaurissanAI : public BossAI
    {
        uint32 hasYelled       = 0;
        uint32 SenatorYells[5] = {3, 4, 5, 6, 7}; // IDs in creature_text database

        boss_draganthaurissanAI(Creature* creature) : BossAI(creature, DATA_EMPEROR){}

        void EnterCombat(Unit* /*who*/) override
        {
            if (hasYelled != 5)
            {
                Talk(YELL_SENATORS_ALIVE);
            }
            else
            {
                Talk(YELL_SENATORS_DEAD);
            }

            me->CallForHelp(VISIBLE_RANGE);
            events.ScheduleEvent(SPELL_HANDOFTHAURISSAN, urand(4000, 7000));
            events.ScheduleEvent(SPELL_AVATAROFFLAME, urand(10000, 12000));
        }

        void KilledUnit(Unit* /*victim*/) override
        {
            Talk(SAY_SLAY);
        }

        void SetData(uint32 type, uint32 data) override
        {
            if (type == PERCENT_DEAD_SENATORS)
            {
                if (data >= 20 * (hasYelled + 1)) // map the 5 yells to %. Yell after 20,40,60,80,100%
                {
                    if (hasYelled < 5)
                    {
                        Talk(SenatorYells[hasYelled]);
                    }
                    hasYelled++;
                }
            }
        }

        void JustDied(Unit* /*killer*/) override
        {
            if (Creature* Moira = ObjectAccessor::GetCreature(*me, instance->GetGuidData(DATA_MOIRA)))
            {
                Moira->AI()->EnterEvadeMode();
                Moira->AI()->Talk(0);
                Moira->setFaction(35);
            }
        }

        void UpdateAI(uint32 diff) override
        {
            //Return since we have no target
            if (!UpdateVictim())
                return;

            events.Update(diff);

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            while (uint32 eventId = events.ExecuteEvent())
            {
                switch (eventId)
                {
                case SPELL_HANDOFTHAURISSAN:
                    DoCast(SelectTarget(SELECT_TARGET_RANDOM), SPELL_HANDOFTHAURISSAN);
                    //DoCastVictim(SPELL_HANDOFTHAURISSAN);
                    events.ScheduleEvent(SPELL_HANDOFTHAURISSAN, urand(4000, 7000));
                    break;
                case SPELL_AVATAROFFLAME:
                    DoCastSelf(SPELL_AVATAROFFLAME);
                    events.ScheduleEvent(SPELL_AVATAROFFLAME, urand(23000, 27000));
                    break;
                default:
                    break;
                }
            }
            DoMeleeAttackIfReady();
        }
    };
};

void AddSC_boss_draganthaurissan()
{
    new boss_emperor_dagran_thaurissan();
}

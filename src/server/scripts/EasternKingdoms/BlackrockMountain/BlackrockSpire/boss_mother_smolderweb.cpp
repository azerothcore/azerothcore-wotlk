/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "blackrock_spire.h"

enum Spells
{
    SPELL_CRYSTALIZE                = 16104,
    SPELL_MOTHERSMILK               = 16468,
    SPELL_SUMMON_SPIRE_SPIDERLING   = 16103,
};

enum Events
{
    EVENT_CRYSTALIZE                = 1,
    EVENT_MOTHERS_MILK              = 2,
};

class boss_mother_smolderweb : public CreatureScript
{
public:
    boss_mother_smolderweb() : CreatureScript("boss_mother_smolderweb") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new boss_mothersmolderwebAI(creature);
    }

    struct boss_mothersmolderwebAI : public BossAI
    {
        boss_mothersmolderwebAI(Creature* creature) : BossAI(creature, DATA_MOTHER_SMOLDERWEB) {}

        void Reset()
        {
            _Reset();
        }

        void EnterCombat(Unit* /*who*/)
        {
            _EnterCombat();
            events.ScheduleEvent(EVENT_CRYSTALIZE,   20 * IN_MILLISECONDS);
            events.ScheduleEvent(EVENT_MOTHERS_MILK, 10 * IN_MILLISECONDS);
        }

        void JustDied(Unit* /*killer*/)
        {
            _JustDied();
        }

        void DamageTaken(Unit*, uint32 &damage, DamageEffectType, SpellSchoolMask)
        {
            if (me->GetHealth() <= damage)
                DoCast(me, SPELL_SUMMON_SPIRE_SPIDERLING, true);
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
                    case EVENT_CRYSTALIZE:
                        DoCast(me, SPELL_CRYSTALIZE);
                        events.ScheduleEvent(EVENT_CRYSTALIZE, 15 * IN_MILLISECONDS);
                        break;
                    case EVENT_MOTHERS_MILK:
                        DoCast(me, SPELL_MOTHERSMILK);
                        events.ScheduleEvent(EVENT_MOTHERS_MILK, urand(5 * IN_MILLISECONDS, 12500));
                        break;
                }
            }
            DoMeleeAttackIfReady();
        }
    };

};

void AddSC_boss_mothersmolderweb()
{
    new boss_mother_smolderweb();
}

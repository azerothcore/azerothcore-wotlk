/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "steam_vault.h"

enum HydromancerThespia
{
    SAY_SUMMON                  = 0,
    SAY_AGGRO                   = 1,
    SAY_SLAY                    = 2,
    SAY_DEAD                    = 3,

    SPELL_LIGHTNING_CLOUD       = 25033,
    SPELL_LUNG_BURST            = 31481,
    SPELL_ENVELOPING_WINDS      = 31718,

    EVENT_SPELL_LIGHTNING       = 1,
    EVENT_SPELL_LUNG            = 2,
    EVENT_SPELL_ENVELOPING      = 3
};

class boss_hydromancer_thespia : public CreatureScript
{
public:
    boss_hydromancer_thespia() : CreatureScript("boss_hydromancer_thespia") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new boss_thespiaAI (creature);
    }

    struct boss_thespiaAI : public ScriptedAI
    {
        boss_thespiaAI(Creature* creature) : ScriptedAI(creature)
        {
            instance = creature->GetInstanceScript();
        }

        InstanceScript* instance;
        EventMap events;

        void Reset()
        {
            events.Reset();
            if (instance)
                instance->SetData(TYPE_HYDROMANCER_THESPIA, NOT_STARTED);
        }

        void JustDied(Unit* /*killer*/)
        {
            Talk(SAY_DEAD);
            if (instance)
                instance->SetData(TYPE_HYDROMANCER_THESPIA, DONE);
        }

        void KilledUnit(Unit* victim)
        {
            if (victim->GetTypeId() == TYPEID_PLAYER)
                Talk(SAY_SLAY);
        }

        void EnterCombat(Unit* /*who*/)
        {
            Talk(SAY_AGGRO);
            events.ScheduleEvent(EVENT_SPELL_LIGHTNING, 15000);
            events.ScheduleEvent(EVENT_SPELL_LUNG, 7000);
            events.ScheduleEvent(EVENT_SPELL_ENVELOPING, 9000);

            if (instance)
                instance->SetData(TYPE_HYDROMANCER_THESPIA, IN_PROGRESS);
        }

        void UpdateAI(uint32 diff)
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);
            switch (events.GetEvent())
            {
                case EVENT_SPELL_LIGHTNING:
                    for (uint8 i = 0; i < DUNGEON_MODE(1, 2); ++i)
                        if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0))
                            me->CastSpell(target, SPELL_LIGHTNING_CLOUD, false);
                    events.RepeatEvent(urand(15000, 25000));
                    break;
                case EVENT_SPELL_LUNG:
                    if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0))
                    DoCast(target, SPELL_LUNG_BURST);
                    events.RepeatEvent(urand(7000, 12000));
                    break;
                case EVENT_SPELL_ENVELOPING:
                    for (uint8 i = 0; i < DUNGEON_MODE(1, 2); ++i)
                        if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0))
                            me->CastSpell(target, SPELL_ENVELOPING_WINDS, false);
                    events.RepeatEvent(urand(10000, 15000));
                    break;
            }

            DoMeleeAttackIfReady();
        }
    };

};

void AddSC_boss_hydromancer_thespia()
{
    new boss_hydromancer_thespia();
}

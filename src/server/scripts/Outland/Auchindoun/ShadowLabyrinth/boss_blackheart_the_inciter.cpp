/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "shadow_labyrinth.h"

enum BlackheartTheInciter
{
    SPELL_INCITE_CHAOS      = 33676,
    SPELL_INCITE_CHAOS_B    = 33684,                         //debuff applied to each member of party
    SPELL_CHARGE            = 33709,
    SPELL_WAR_STOMP         = 33707,

    SAY_INTRO               = 0,
    SAY_AGGRO               = 1,
    SAY_SLAY                = 2,
    SAY_HELP                = 3,
    SAY_DEATH               = 4,

    EVENT_SPELL_INCITE      = 1,
    EVENT_INCITE_WAIT       = 2,
    EVENT_SPELL_CHARGE      = 3,
    EVENT_SPELL_KNOCKBACK   = 4
};

class boss_blackheart_the_inciter : public CreatureScript
{
public:
    boss_blackheart_the_inciter() : CreatureScript("boss_blackheart_the_inciter") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new boss_blackheart_the_inciterAI (creature);
    }

    struct boss_blackheart_the_inciterAI : public ScriptedAI
    {
        boss_blackheart_the_inciterAI(Creature* creature) : ScriptedAI(creature)
        {
            instance = creature->GetInstanceScript();
        }

        InstanceScript* instance;
        EventMap events;

        bool InciteChaos;

        void Reset()
        {
            InciteChaos = false;
            events.Reset();

            if (instance)
                instance->SetData(DATA_BLACKHEARTTHEINCITEREVENT, NOT_STARTED);
        }

        void KilledUnit(Unit* victim)
        {
            if (victim->GetTypeId() == TYPEID_PLAYER && urand(0,1))
                Talk(SAY_SLAY);
        }

        void JustDied(Unit* /*killer*/)
        {
            Talk(SAY_DEATH);
            if (instance)
                instance->SetData(DATA_BLACKHEARTTHEINCITEREVENT, DONE);
        }

        void EnterCombat(Unit* /*who*/)
        {
            Talk(SAY_AGGRO);
            events.ScheduleEvent(EVENT_SPELL_INCITE, 20000);
            events.ScheduleEvent(EVENT_INCITE_WAIT, 15000);
            events.ScheduleEvent(EVENT_SPELL_CHARGE, 0);
            events.ScheduleEvent(EVENT_SPELL_KNOCKBACK, 15000);

            if (instance)
                instance->SetData(DATA_BLACKHEARTTHEINCITEREVENT, IN_PROGRESS);
        }

        void EnterEvadeMode()
        {
            if (InciteChaos && SelectTargetFromPlayerList(100.0f))
                return;
            CreatureAI::EnterEvadeMode();
        }

        void UpdateAI(uint32 diff)
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);
            switch (events.GetEvent())
            {
                case EVENT_INCITE_WAIT:
                    InciteChaos = false;
                    events.PopEvent();
                    break;
                case EVENT_SPELL_INCITE:
                {
                    me->CastSpell(me, SPELL_INCITE_CHAOS, false);

                    std::list<HostileReference*> t_list = me->getThreatManager().getThreatList();
                    for (std::list<HostileReference*>::const_iterator itr = t_list.begin(); itr!= t_list.end(); ++itr)
                    {
                        Unit* target = ObjectAccessor::GetUnit(*me, (*itr)->getUnitGuid());
                        if (target && target->GetTypeId() == TYPEID_PLAYER)
                            me->CastSpell(target, SPELL_INCITE_CHAOS_B, true);
                    }

                    DoResetThreat();
                    InciteChaos = true;
                    events.DelayEvents(15000);
                    events.RepeatEvent(40000);
                    events.ScheduleEvent(EVENT_INCITE_WAIT, 15000);
                    break;
                }
                case EVENT_SPELL_CHARGE:
                    if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0))
                        me->CastSpell(target, SPELL_CHARGE, false);
                    events.RepeatEvent(urand(15000, 25000));
                    break;
                case EVENT_SPELL_KNOCKBACK:
                    me->CastSpell(me, SPELL_WAR_STOMP, false);
                    events.RepeatEvent(urand(18000, 24000));
                    break;
            }

            if (InciteChaos)
                return;

            DoMeleeAttackIfReady();
        }
    };

};

void AddSC_boss_blackheart_the_inciter()
{
    new boss_blackheart_the_inciter();
}

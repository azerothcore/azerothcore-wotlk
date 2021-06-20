/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "the_black_morass.h"

enum Enums
{
    SAY_ENTER                   = 0,
    SAY_AGGRO                   = 1,
    SAY_BANISH                  = 2,
    SAY_SLAY                    = 3,
    SAY_DEATH                   = 4,

    SPELL_HASTEN                = 31458,
    SPELL_MORTAL_WOUND          = 31464,
    SPELL_WING_BUFFET           = 31475,
    SPELL_REFLECT               = 38592,
    SPELL_BANISH_DRAGON_HELPER  = 31550
};

enum Events
{
    EVENT_HASTEN                = 1,
    EVENT_MORTAL_WOUND          = 2,
    EVENT_WING_BUFFET           = 3,
    EVENT_SPELL_REFLECTION      = 4
};

class boss_temporus : public CreatureScript
{
public:
    boss_temporus() : CreatureScript("boss_temporus") { }

    struct boss_temporusAI : public ScriptedAI
    {
        boss_temporusAI(Creature* creature) : ScriptedAI(creature) { }

        EventMap events;

        void OwnTalk(uint32 id)
        {
            if (me->GetEntry() == NPC_TEMPORUS)
                Talk(id);
        }

        void Reset()
        {
            events.Reset();
        }

        void InitializeAI()
        {
            OwnTalk(SAY_ENTER);
            ScriptedAI::InitializeAI();
        }

        void EnterCombat(Unit* /*who*/)
        {
            events.ScheduleEvent(EVENT_HASTEN, 12000);
            events.ScheduleEvent(EVENT_MORTAL_WOUND, 5000);
            events.ScheduleEvent(EVENT_WING_BUFFET, 20000);
            if (IsHeroic())
                events.ScheduleEvent(EVENT_SPELL_REFLECTION, 28000);

            OwnTalk(SAY_AGGRO);
        }

        void KilledUnit(Unit* victim)
        {
            if (victim->GetTypeId() == TYPEID_PLAYER)
                OwnTalk(SAY_SLAY);
        }

        void JustDied(Unit* /*killer*/)
        {
            OwnTalk(SAY_DEATH);
            if (InstanceScript* instance = me->GetInstanceScript())
                instance->SetData(TYPE_TEMPORUS, DONE);
        }

        void MoveInLineOfSight(Unit* who)
        {
            if (who->GetTypeId() == TYPEID_UNIT && who->GetEntry() == NPC_TIME_KEEPER)
            {
                if (me->IsWithinDistInMap(who, 20.0f))
                {
                    OwnTalk(SAY_BANISH);
                    me->CastSpell(me, SPELL_BANISH_DRAGON_HELPER, true);
                    return;
                }
            }

            ScriptedAI::MoveInLineOfSight(who);
        }

        void UpdateAI(uint32 diff)
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);
            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (events.ExecuteEvent())
            {
                case EVENT_HASTEN:
                    me->CastSpell(me, SPELL_HASTEN, false);
                    events.ScheduleEvent(EVENT_HASTEN, 20000);
                    break;
                case EVENT_MORTAL_WOUND:
                    me->CastSpell(me->GetVictim(), SPELL_MORTAL_WOUND, false);
                    events.ScheduleEvent(EVENT_MORTAL_WOUND, 10000);
                    break;
                case EVENT_WING_BUFFET:
                    me->CastSpell(me, SPELL_WING_BUFFET, false);
                    events.ScheduleEvent(EVENT_WING_BUFFET, 20000);
                    break;
                case EVENT_SPELL_REFLECTION:
                    me->CastSpell(me, SPELL_REFLECT, false);
                    events.ScheduleEvent(EVENT_SPELL_REFLECTION, 30000);
                    break;
            }

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return new boss_temporusAI(creature);
    }
};

void AddSC_boss_temporus()
{
    new boss_temporus();
}

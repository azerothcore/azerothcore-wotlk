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
    EMOTE_FRENZY                = 5,

    SPELL_CLEAVE                = 40504,
    SPELL_TIME_STOP             = 31422,
    SPELL_ENRAGE                = 37605,
    SPELL_SAND_BREATH           = 31473,
    SPELL_CORRUPT_MEDIVH        = 37853,
    SPELL_BANISH_DRAGON_HELPER  = 31550
};

enum Events
{
    EVENT_SANDBREATH            = 1,
    EVENT_TIMESTOP              = 2,
    EVENT_FRENZY                = 3,
    EVENT_CLEAVE                = 4
};

class boss_aeonus : public CreatureScript
{
public:
    boss_aeonus() : CreatureScript("boss_aeonus") { }

    struct boss_aeonusAI : public ScriptedAI
    {
        boss_aeonusAI(Creature* creature) : ScriptedAI(creature)
        {
            instance = creature->GetInstanceScript();
        }

        EventMap events;
        InstanceScript* instance;

        void Reset()
        {
            events.Reset();
        }

        void JustReachedHome()
        {
            if (Unit* medivh = ObjectAccessor::GetUnit(*me, instance->GetData64(DATA_MEDIVH)))
                if (me->GetDistance2d(medivh) < 20.0f)
                    me->CastSpell(me, SPELL_CORRUPT_MEDIVH, false);
        }

        void InitializeAI()
        {
            Talk(SAY_ENTER);
            ScriptedAI::InitializeAI();

            if (Unit* medivh = ObjectAccessor::GetUnit(*me, instance->GetData64(DATA_MEDIVH)))
            {
                me->SetHomePosition(medivh->GetPositionX() + 14.0f*cos(medivh->GetAngle(me)), medivh->GetPositionY() + 14.0f*sin(medivh->GetAngle(me)), medivh->GetPositionZ(), me->GetAngle(medivh));
                me->GetMotionMaster()->MoveTargetedHome();
            }
        }

        void EnterCombat(Unit* /*who*/)
        {
            events.ScheduleEvent(EVENT_CLEAVE, 5000);
            events.ScheduleEvent(EVENT_SANDBREATH, 20000);
            events.ScheduleEvent(EVENT_TIMESTOP, 15000);
            events.ScheduleEvent(EVENT_FRENZY, 30000);

            Talk(SAY_AGGRO);
        }

        void MoveInLineOfSight(Unit* who)
        {
            if (who->GetTypeId() == TYPEID_UNIT && who->GetEntry() == NPC_TIME_KEEPER)
            {
                if (me->IsWithinDistInMap(who, 20.0f))
                {
                    Talk(SAY_BANISH);
                    me->CastSpell(me, SPELL_BANISH_DRAGON_HELPER, true);
                    return;
                }
            }

            ScriptedAI::MoveInLineOfSight(who);
        }

        void JustDied(Unit* /*killer*/)
        {
            Talk(SAY_DEATH);
            instance->SetData(TYPE_AEONUS, DONE);
        }

        void KilledUnit(Unit* victim)
        {
            if (victim->GetTypeId() == TYPEID_PLAYER)
                Talk(SAY_SLAY);
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
                case EVENT_CLEAVE:
                    me->CastSpell(me->GetVictim(), SPELL_CLEAVE, false);
                    events.ScheduleEvent(EVENT_CLEAVE, 10000);
                    break;
                case EVENT_SANDBREATH:
                    me->CastSpell(me->GetVictim(), SPELL_SAND_BREATH, false);
                    events.ScheduleEvent(EVENT_SANDBREATH, 20000);
                    break;
                case EVENT_TIMESTOP:
                    me->CastSpell(me, SPELL_TIME_STOP, false);
                    events.ScheduleEvent(EVENT_TIMESTOP, 25000);
                    break;
                case EVENT_FRENZY:
                    Talk(EMOTE_FRENZY);
                    me->CastSpell(me, SPELL_ENRAGE, false);
                    events.ScheduleEvent(EVENT_FRENZY, 30000);
                    break;
            }

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return new boss_aeonusAI(creature);
    }
};

void AddSC_boss_aeonus()
{
    new boss_aeonus();
}

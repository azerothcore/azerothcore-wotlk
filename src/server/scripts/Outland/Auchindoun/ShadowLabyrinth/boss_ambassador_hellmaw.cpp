/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "ScriptedEscortAI.h"
#include "shadow_labyrinth.h"

enum eEnums
{
    SAY_INTRO               = 0,
    SAY_AGGRO               = 1,
    SAY_HELP                = 2,
    SAY_SLAY                = 3,
    SAY_DEATH               = 4,

    SPELL_BANISH            = 30231,
    SPELL_CORROSIVE_ACID    = 33551,
    SPELL_FEAR              = 33547,
    SPELL_ENRAGE            = 34970,

    EVENT_SPELL_CORROSIVE   = 1,
    EVENT_SPELL_FEAR        = 2,
    EVENT_SPELL_ENRAGE      = 3
};

class boss_ambassador_hellmaw : public CreatureScript
{
public:
    boss_ambassador_hellmaw() : CreatureScript("boss_ambassador_hellmaw") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new boss_ambassador_hellmawAI(creature);
    }

    struct boss_ambassador_hellmawAI : public npc_escortAI
    {
        boss_ambassador_hellmawAI(Creature* creature) : npc_escortAI(creature)
        {
            instance = creature->GetInstanceScript();
        }

        InstanceScript* instance;
        EventMap events;
        bool isBanished;

        void DoAction(int32 param)
        {
            if (param != 1)
                return;

            me->RemoveAurasDueToSpell(SPELL_BANISH);
            Talk(SAY_INTRO);
            Start(true, false, 0, NULL, false, true);
            isBanished = false;
        }

        void Reset()
        {
            events.Reset();
            isBanished = false;
            if (instance)
            {
                instance->SetData(TYPE_HELLMAW, NOT_STARTED);
                if (instance->GetData(TYPE_OVERSEER) != DONE)
                {
                    isBanished = true;
                    me->CastSpell(me, SPELL_BANISH, true);
                }
                else
                    Start(true, false, 0, NULL, false, true);
            }
        }

        void EnterCombat(Unit*)
        {
            if (isBanished)
                return;
            Talk(SAY_AGGRO);
            events.ScheduleEvent(EVENT_SPELL_CORROSIVE, urand(5000, 10000));
            events.ScheduleEvent(EVENT_SPELL_FEAR, urand(15000, 20000));
            if (IsHeroic())
                events.ScheduleEvent(EVENT_SPELL_ENRAGE, 180000);

            if (instance)
                instance->SetData(TYPE_HELLMAW, IN_PROGRESS);
        }

        void MoveInLineOfSight(Unit* who)
        {
            if (isBanished)
                return;
            npc_escortAI::MoveInLineOfSight(who);
        }

        void AttackStart(Unit* who)
        {
            if (isBanished)
                return;
            npc_escortAI::AttackStart(who);
        }

        void WaypointReached(uint32 /*waypointId*/)
        {
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
                instance->SetData(TYPE_HELLMAW, DONE);
        }

        void UpdateAI(uint32 diff)
        {
            npc_escortAI::UpdateAI(diff);

            if (!UpdateVictim())
                return;

            if (isBanished)
            {
                EnterEvadeMode();
                return;
            }

            events.Update(diff);
            switch (events.GetEvent())
            {
                case EVENT_SPELL_CORROSIVE:
                    me->CastSpell(me->GetVictim(), SPELL_CORROSIVE_ACID, false);
                    events.RepeatEvent(urand(15000, 25000));
                    break;
                case EVENT_SPELL_FEAR:
                    me->CastSpell(me, SPELL_FEAR, false);
                    events.RepeatEvent(urand(20000, 35000));
                    break;
                case EVENT_SPELL_ENRAGE:
                    me->CastSpell(me->GetVictim(), SPELL_ENRAGE, false);
                    events.PopEvent();
                    break;
            }
            
            DoMeleeAttackIfReady();
        }
    };

};

void AddSC_boss_ambassador_hellmaw()
{
    new boss_ambassador_hellmaw();
}

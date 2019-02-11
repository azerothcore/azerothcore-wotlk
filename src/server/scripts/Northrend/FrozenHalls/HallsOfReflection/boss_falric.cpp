/*
 * Originally written by Pussywizard - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "halls_of_reflection.h"

enum Yells
{
    SAY_AGGRO                                     = 50,
    SAY_SLAY_1                                    = 51,
    SAY_SLAY_2                                    = 52,
    SAY_DEATH                                     = 53,
    SAY_IMPENDING_DESPAIR                         = 54,
    SAY_DEFILING_HORROR                           = 55,
};

enum Spells
{
    SPELL_QUIVERING_STRIKE                        = 72422,
    SPELL_IMPENDING_DESPAIR                       = 72426,
    SPELL_DEFILING_HORROR                         = 72435,
};

enum Events
{
    EVENT_NONE,
    EVENT_QUIVERING_STRIKE,
    EVENT_IMPENDING_DESPAIR,
    EVENT_DEFILING_HORROR,
    EVENT_UNROOT,
};

const uint32 hopelessnessId[3][2] = { {72395, 72390}, {72396, 72391}, {72397, 72393} };

class boss_falric : public CreatureScript
{
public:
    boss_falric() : CreatureScript("boss_falric") { }

    struct boss_falricAI : public ScriptedAI
    {
        boss_falricAI(Creature* creature) : ScriptedAI(creature)
        {
            pInstance = creature->GetInstanceScript();
        }

        InstanceScript* pInstance;
        EventMap events;
        uint8 uiHopelessnessCount;
        uint16 startFightTimer;

        void Reset()
        {
            startFightTimer = 0;
            uiHopelessnessCount = 0;
            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_PC | UNIT_FLAG_IMMUNE_TO_NPC);
            me->SetControlled(false, UNIT_STATE_ROOT);
            events.Reset();
            if (pInstance)
                pInstance->SetData(DATA_FALRIC, NOT_STARTED);
        }

        void EnterCombat(Unit* /*who*/)
        {
            me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_PC | UNIT_FLAG_IMMUNE_TO_NPC);

            events.ScheduleEvent(EVENT_QUIVERING_STRIKE, 5000);
            events.ScheduleEvent(EVENT_IMPENDING_DESPAIR, 11000);
            events.ScheduleEvent(EVENT_DEFILING_HORROR, 20000);
        }

        void DoAction(int32 a)
        {
            if (a == 1)
            {
                Talk(SAY_AGGRO);
                startFightTimer = 8000;
            }
        }

        void UpdateAI(uint32 diff)
        {
            if (startFightTimer)
            {
                if (startFightTimer <= diff)
                {
                    startFightTimer = 0;
                    me->SetInCombatWithZone();
                }
                else
                    startFightTimer -= diff;
            }

            if (!UpdateVictim())
                return;

            events.Update(diff);

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (events.ExecuteEvent())
            {
                case EVENT_QUIVERING_STRIKE:
                    me->CastSpell(me->GetVictim(), SPELL_QUIVERING_STRIKE, false);
                    events.ScheduleEvent(EVENT_QUIVERING_STRIKE, 5000);
                    break;
                case EVENT_IMPENDING_DESPAIR:
                    if (Unit* target = SelectTargetFromPlayerList(45.0f, 0, true))
                    {
                        Talk(SAY_IMPENDING_DESPAIR);
                        me->CastSpell(target, SPELL_IMPENDING_DESPAIR, false);
                    }
                    events.ScheduleEvent(EVENT_IMPENDING_DESPAIR, 12000);
                    break;
                case EVENT_DEFILING_HORROR:
                    Talk(SAY_DEFILING_HORROR);
                    me->CastSpell((Unit*)NULL, SPELL_DEFILING_HORROR, false);
                    me->SetControlled(true, UNIT_STATE_ROOT);
                    events.DelayEventsToMax(5000, 0);
                    events.ScheduleEvent(EVENT_UNROOT, 4000);
                    events.ScheduleEvent(EVENT_DEFILING_HORROR, 20000);
                    break;
                case EVENT_UNROOT:
                    me->SetControlled(false, UNIT_STATE_ROOT);
                    break;
            }

            if ((uiHopelessnessCount == 0 && HealthBelowPct(67)) || (uiHopelessnessCount == 1 && HealthBelowPct(34)) || (uiHopelessnessCount == 2 && HealthBelowPct(11)))
            {
                if (uiHopelessnessCount)
                    me->RemoveOwnedAura(hopelessnessId[uiHopelessnessCount-1][DUNGEON_MODE(0, 1)]);
                me->CastSpell((Unit*)NULL, hopelessnessId[uiHopelessnessCount][DUNGEON_MODE(0, 1)], true);
                ++uiHopelessnessCount;
            }

            if (!me->HasUnitState(UNIT_STATE_ROOT))
                DoMeleeAttackIfReady();
        }

        void JustDied(Unit* /*killer*/)
        {
            Talk(SAY_DEATH);
            if (pInstance)
                pInstance->SetData(DATA_FALRIC, DONE);
        }

        void KilledUnit(Unit* who)
        {
            if (who->GetTypeId() == TYPEID_PLAYER)
                Talk(RAND(SAY_SLAY_1, SAY_SLAY_2));
        }

        void EnterEvadeMode()
        {
            me->SetControlled(false, UNIT_STATE_ROOT);
            ScriptedAI::EnterEvadeMode();
            if (startFightTimer)
                Reset();
        }
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return new boss_falricAI(creature);
    }
};

void AddSC_boss_falric()
{
    new boss_falric();
}

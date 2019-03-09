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
    SPELL_REND_MOUNTS               = 16167, // Change model
    SPELL_CORROSIVE_ACID            = 16359, // Combat (self cast)
    SPELL_FLAMEBREATH               = 16390, // Combat (Self cast)
    SPELL_FREEZE                    = 16350, // Combat (Self cast)
    SPELL_KNOCK_AWAY                = 10101, // Combat
    SPELL_SUMMON_REND               = 16328  // Summons Rend near death
};

enum Misc
{
    NEFARIUS_PATH_2                 = 1379671,
    NEFARIUS_PATH_3                 = 1379672,
    GYTH_PATH_1                     = 1379681,
};

enum Events
{
    EVENT_CORROSIVE_ACID            = 1,
    EVENT_FREEZE                    = 2,
    EVENT_FLAME_BREATH              = 3,
    EVENT_KNOCK_AWAY                = 4,
    EVENT_SUMMONED_1                = 5,
    EVENT_SUMMONED_2                = 6
};

class boss_gyth : public CreatureScript
{
public:
    boss_gyth() : CreatureScript("boss_gyth") { }

    struct boss_gythAI : public BossAI
    {
        boss_gythAI(Creature* creature) : BossAI(creature, DATA_GYTH) { }

        bool SummonedRend;

        void Reset()
        {
            SummonedRend = false;
            if (instance->GetBossState(DATA_GYTH) == IN_PROGRESS)
            {
                instance->SetBossState(DATA_GYTH, NOT_STARTED);
                summons.DespawnAll();
                me->DespawnOrUnsummon();
            }
        }

        void EnterCombat(Unit* /*who*/)
        {
            _EnterCombat();

            events.ScheduleEvent(EVENT_CORROSIVE_ACID, urand(8000, 16000));
            events.ScheduleEvent(EVENT_FREEZE, urand(8000, 16000));
            events.ScheduleEvent(EVENT_FLAME_BREATH, urand(8000, 16000));
            events.ScheduleEvent(EVENT_KNOCK_AWAY, urand(12000, 18000));
        }

        void JustDied(Unit* /*killer*/)
        {
            instance->SetBossState(DATA_GYTH, DONE);
        }

        void SetData(uint32 /*type*/, uint32 data)
        {
            switch (data)
            {
                case 1:
                    events.ScheduleEvent(EVENT_SUMMONED_1, 1000);
                    break;
                default:
                    break;
            }
        }

        void JustSummoned(Creature* summon)
        {
            summons.Summon(summon);
            summon->AI()->AttackStart(me->SelectVictim());
        }

        void UpdateAI(uint32 diff)
        {

            if (!SummonedRend && HealthBelowPct(25))
            {
                DoCast(me, SPELL_SUMMON_REND);
                me->RemoveAura(SPELL_REND_MOUNTS);
                SummonedRend = true;
            }

            if (!UpdateVictim())
            {
                events.Update(diff);

                while (uint32 eventId = events.ExecuteEvent())
                {
                    switch (eventId)
                    {
                        case EVENT_SUMMONED_1:
                            me->AddAura(SPELL_REND_MOUNTS, me);
                            if (GameObject* portcullis = me->FindNearestGameObject(GO_DR_PORTCULLIS, 40.0f))
                                portcullis->UseDoorOrButton();
                            if (Creature* victor = me->FindNearestCreature(NPC_LORD_VICTOR_NEFARIUS, 75.0f, true))
                                victor->AI()->SetData(1, 1);
                            events.ScheduleEvent(EVENT_SUMMONED_2, 2000);
                            break;
                        case EVENT_SUMMONED_2:
                            me->GetMotionMaster()->MovePath(GYTH_PATH_1, false);
                            break;
                        default:
                            break;
                    }
                }
                return;
            }

            events.Update(diff);

            while (uint32 eventId = events.ExecuteEvent())
            {
                switch (eventId)
                {
                    case EVENT_CORROSIVE_ACID:
                        DoCast(me, SPELL_CORROSIVE_ACID);
                        events.ScheduleEvent(EVENT_CORROSIVE_ACID, urand(10000, 16000));
                        break;
                    case EVENT_FREEZE:
                        DoCast(me, SPELL_FREEZE);
                        events.ScheduleEvent(EVENT_FREEZE, urand(10000, 16000));
                        break;
                    case EVENT_FLAME_BREATH:
                        DoCast(me, SPELL_FLAMEBREATH);
                        events.ScheduleEvent(EVENT_FLAME_BREATH, urand(10000, 16000));
                        break;
                    case EVENT_KNOCK_AWAY:
                        DoCastVictim(SPELL_KNOCK_AWAY);
                        events.ScheduleEvent(EVENT_KNOCK_AWAY, urand(14000, 20000));
                        break;
                    default:
                        break;
                }
            }
            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return GetInstanceAI<boss_gythAI>(creature);
    }
};

void AddSC_boss_gyth()
{
    new boss_gyth();
}

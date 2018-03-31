/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "shattered_halls.h"

enum Says
{
    SAY_AGGRO                      = 0,
    SAY_SLAY                       = 1,
    SAY_DEATH                      = 2
};

enum Spells
{
     SPELL_BLADE_DANCE              = 30739,
     SPELL_CHARGE                   = 25821,
     SPELL_SPRINT                   = 32720,
};

enum Creatures
{
    NPC_SHATTERED_ASSASSIN         = 17695,
    NPC_HEARTHEN_GUARD             = 17621,
    NPC_SHARPSHOOTER_GUARD         = 17622,
    NPC_REAVER_GUARD               = 17623
};

float AssassEntrance[3] = { 275.136f, -84.29f, 2.3f  }; // y -8
float AssassExit[3]     = { 184.233f, -84.29f, 2.3f  }; // y -8
float AddsEntrance[3]   = { 306.036f, -84.29f, 1.93f };

enum Misc
{
    EVENT_CHECK_ROOM                = 1,
    EVENT_SUMMON_ADDS               = 2,
    EVENT_SUMMON_ASSASSINS          = 3,
    EVENT_SPELL_CHARGE              = 4,
    EVENT_MOVE_TO_NEXT_POINT        = 5,
    EVENT_BLADE_DANCE               = 6,
    EVENT_FINISH_BLADE_DANCE        = 7
};

class boss_warchief_kargath_bladefist : public CreatureScript
{
    public:
        boss_warchief_kargath_bladefist() : CreatureScript("boss_warchief_kargath_bladefist") { }

        struct boss_warchief_kargath_bladefistAI : public BossAI
        {
            boss_warchief_kargath_bladefistAI(Creature* creature) : BossAI(creature, DATA_KARGATH) { }

            void InitializeAI()
            {
                BossAI::InitializeAI();
                if (instance)
                    if (Creature* executioner = ObjectAccessor::GetCreature(*me, instance->GetData64(DATA_EXECUTIONER)))
                        executioner->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
            }

            void JustDied(Unit* /*killer*/)
            {
                Talk(SAY_DEATH);
                _JustDied();

                if (instance)
                    if (Creature* executioner = ObjectAccessor::GetCreature(*me, instance->GetData64(DATA_EXECUTIONER)))
                        executioner->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
            }

            void EnterCombat(Unit*  /*who*/)
            {
                Talk(SAY_AGGRO);
                _EnterCombat();

                events.ScheduleEvent(EVENT_CHECK_ROOM, 5000);
                events.ScheduleEvent(EVENT_SUMMON_ADDS, 30000);
                events.ScheduleEvent(EVENT_SUMMON_ASSASSINS, 5000);
                events.ScheduleEvent(EVENT_BLADE_DANCE, 30000);
                events.ScheduleEvent(EVENT_SPELL_CHARGE, 0);
            }

            void JustSummoned(Creature* summon)
            {
                if (summon->GetEntry() != NPC_SHATTERED_ASSASSIN)
                    summon->AI()->AttackStart(SelectTarget(SELECT_TARGET_RANDOM, 0));

                summons.Summon(summon);
            }

            void KilledUnit(Unit* victim)
            {
                if (victim->GetTypeId() == TYPEID_PLAYER)
                    Talk(SAY_SLAY);
            }

            void MovementInform(uint32 type, uint32 id)
            {
                if (type != POINT_MOTION_TYPE || id != 1)
                    return;

                me->CastSpell(me, SPELL_BLADE_DANCE, true);
                events.ScheduleEvent(EVENT_MOVE_TO_NEXT_POINT, 0);
            }

            void UpdateAI(uint32 diff)
            {
                if (!UpdateVictim())
                    return;

                events.Update(diff);
                switch (events.ExecuteEvent())
                {
                    case EVENT_CHECK_ROOM:
                        if (me->GetPositionX() > 255 || me->GetPositionX() < 205)
                        {
                            EnterEvadeMode();
                            return;
                        }
                        events.ScheduleEvent(EVENT_CHECK_ROOM, 5000);
                        break;
                    case EVENT_SUMMON_ASSASSINS:
                        me->SummonCreature(NPC_SHATTERED_ASSASSIN, AssassEntrance[0], AssassEntrance[1]+8, AssassEntrance[2], 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 30000);
                        me->SummonCreature(NPC_SHATTERED_ASSASSIN, AssassEntrance[0], AssassEntrance[1]-8, AssassEntrance[2], 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 30000);
                        me->SummonCreature(NPC_SHATTERED_ASSASSIN, AssassExit[0], AssassExit[1]+8, AssassExit[2], 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 30000);
                        me->SummonCreature(NPC_SHATTERED_ASSASSIN, AssassExit[0], AssassExit[1]-8, AssassExit[2], 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 30000);
                        break;
                    case EVENT_SUMMON_ADDS:
                        for (uint8 i = 0; i < 2; ++i)
                            me->SummonCreature(NPC_HEARTHEN_GUARD+urand(0,2), AddsEntrance[0], AddsEntrance[1], AddsEntrance[2], 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 30000);
      
                        events.ScheduleEvent(EVENT_SUMMON_ADDS, 30000);
                        break;
                    case EVENT_BLADE_DANCE:
                        events.DelayEvents(10001);
                        events.ScheduleEvent(EVENT_BLADE_DANCE, 40000);
                        events.ScheduleEvent(EVENT_MOVE_TO_NEXT_POINT, 0);
                        events.ScheduleEvent(EVENT_FINISH_BLADE_DANCE, 10000);
                        events.SetPhase(1);
                        me->CastSpell(me, SPELL_SPRINT, true);
                        break;
                    case EVENT_MOVE_TO_NEXT_POINT:
                    {
                        float x = 210 + frand(0.0f, 35.0f);
                        float y = -65.0f - frand(0.0f, 35.0f);
                        me->GetMotionMaster()->MovePoint(1, x, y, me->GetPositionZ());
                        break;
                    }
                    case EVENT_FINISH_BLADE_DANCE:
                        events.SetPhase(0);
                        me->GetMotionMaster()->Clear();
                        me->GetMotionMaster()->MoveChase(me->GetVictim());
                        if (IsHeroic())
                            events.ScheduleEvent(EVENT_SPELL_CHARGE, 3000);
                        break;
                    case EVENT_SPELL_CHARGE:
                        me->CastSpell(me->GetVictim(), SPELL_CHARGE, false);
                        break;
                }

                if (!events.IsInPhase(1))
                    DoMeleeAttackIfReady();
            }
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return GetInstanceAI<boss_warchief_kargath_bladefistAI>(creature);
        }
};

void AddSC_boss_warchief_kargath_bladefist()
{
    new boss_warchief_kargath_bladefist();
}

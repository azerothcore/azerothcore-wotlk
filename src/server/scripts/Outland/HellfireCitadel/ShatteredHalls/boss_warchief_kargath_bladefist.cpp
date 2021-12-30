/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU Affero General Public License as published by the
 * Free Software Foundation; either version 3 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
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

        void InitializeAI() override
        {
            BossAI::InitializeAI();
            if (instance)
                if (Creature* executioner = ObjectAccessor::GetCreature(*me, instance->GetGuidData(DATA_EXECUTIONER)))
                    executioner->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
        }

        void JustDied(Unit* /*killer*/) override
        {
            Talk(SAY_DEATH);
            _JustDied();

            if (instance)
                if (Creature* executioner = ObjectAccessor::GetCreature(*me, instance->GetGuidData(DATA_EXECUTIONER)))
                    executioner->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
        }

        void EnterCombat(Unit*  /*who*/) override
        {
            Talk(SAY_AGGRO);
            _EnterCombat();

            events.ScheduleEvent(EVENT_CHECK_ROOM, 5000);
            events.ScheduleEvent(EVENT_SUMMON_ADDS, 30000);
            events.ScheduleEvent(EVENT_SUMMON_ASSASSINS, 5000);
            events.ScheduleEvent(EVENT_BLADE_DANCE, 30000);
            events.ScheduleEvent(EVENT_SPELL_CHARGE, 0);
        }

        void JustSummoned(Creature* summon) override
        {
            if (summon->GetEntry() != NPC_SHATTERED_ASSASSIN)
                summon->AI()->AttackStart(SelectTarget(SelectTargetMethod::Random, 0));

            summons.Summon(summon);
        }

        void KilledUnit(Unit* victim) override
        {
            if (victim->GetTypeId() == TYPEID_PLAYER)
                Talk(SAY_SLAY);
        }

        void MovementInform(uint32 type, uint32 id) override
        {
            if (type != POINT_MOTION_TYPE || id != 1)
                return;

            me->CastSpell(me, SPELL_BLADE_DANCE, true);
            events.ScheduleEvent(EVENT_MOVE_TO_NEXT_POINT, 0);
        }

        void UpdateAI(uint32 diff) override
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
                    me->SummonCreature(NPC_SHATTERED_ASSASSIN, AssassEntrance[0], AssassEntrance[1] + 8, AssassEntrance[2], 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 30000);
                    me->SummonCreature(NPC_SHATTERED_ASSASSIN, AssassEntrance[0], AssassEntrance[1] - 8, AssassEntrance[2], 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 30000);
                    me->SummonCreature(NPC_SHATTERED_ASSASSIN, AssassExit[0], AssassExit[1] + 8, AssassExit[2], 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 30000);
                    me->SummonCreature(NPC_SHATTERED_ASSASSIN, AssassExit[0], AssassExit[1] - 8, AssassExit[2], 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 30000);
                    break;
                case EVENT_SUMMON_ADDS:
                    for (uint8 i = 0; i < 2; ++i)
                        me->SummonCreature(NPC_HEARTHEN_GUARD + urand(0, 2), AddsEntrance[0], AddsEntrance[1], AddsEntrance[2], 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 30000);

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

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetShatteredHallsAI<boss_warchief_kargath_bladefistAI>(creature);
    }
};

void AddSC_boss_warchief_kargath_bladefist()
{
    new boss_warchief_kargath_bladefist();
}

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
    EVENT_SPELL_ENRAGE      = 3,

    PATH_ID_START           = 1873100,
    PATH_ID_PATHING         = 1873101,

    SOUND_INTRO             = 9349
};

class boss_ambassador_hellmaw : public CreatureScript
{
public:
    boss_ambassador_hellmaw() : CreatureScript("boss_ambassador_hellmaw") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetShadowLabyrinthAI<boss_ambassador_hellmawAI>(creature);
    }

    struct boss_ambassador_hellmawAI : public ScriptedAI
    {
        boss_ambassador_hellmawAI(Creature* creature) : ScriptedAI(creature)
        {
            instance = creature->GetInstanceScript();
        }

        InstanceScript* instance;
        EventMap events;
        bool isBanished;

        void InitializeAI() override
        {
            Reset();

            if (instance && instance->GetData(TYPE_RITUALISTS) != DONE)
            {
                isBanished = true;
                me->SetImmuneToAll(true);

                me->m_Events.AddEventAtOffset([this]()
                {
                    DoCastSelf(SPELL_BANISH, true);
                }, 500ms);
            }
            else
            {
                me->GetMotionMaster()->MovePath(PATH_ID_START, false);
            }
        }

        void Reset() override
        {
            events.Reset();
            isBanished = false;
            me->SetImmuneToAll(false);
            if (instance)
            {
                instance->SetData(TYPE_HELLMAW, NOT_STARTED);
            }
        }

        void DoAction(int32 param) override
        {
            if (param != 1)
            {
                return;
            }

            me->RemoveAurasDueToSpell(SPELL_BANISH);
            Talk(SAY_INTRO);
            DoPlaySoundToSet(me, SOUND_INTRO);
            isBanished = false;
            me->SetImmuneToAll(false);
            me->GetMotionMaster()->MovePath(PATH_ID_START, false);
        }

        void JustEngagedWith(Unit*) override
        {
            if (isBanished)
            {
                return;
            }

            Talk(SAY_AGGRO);
            events.ScheduleEvent(EVENT_SPELL_CORROSIVE, urand(5000, 10000));
            events.ScheduleEvent(EVENT_SPELL_FEAR, urand(15000, 20000));
            if (IsHeroic())
            {
                events.ScheduleEvent(EVENT_SPELL_ENRAGE, 180000);
            }

            if (instance)
            {
                instance->SetData(TYPE_HELLMAW, IN_PROGRESS);
            }
        }

        void MoveInLineOfSight(Unit* who) override
        {
            if (isBanished)
            {
                return;
            }

            ScriptedAI::MoveInLineOfSight(who);
        }

        void AttackStart(Unit* who) override
        {
            if (isBanished)
            {
                return;
            }

            ScriptedAI::AttackStart(who);
        }

        void PathEndReached(uint32 pathId) override
        {
            if (pathId == PATH_ID_START)
            {
                me->m_Events.AddEventAtOffset([this]()
                {
                    me->GetMotionMaster()->MovePath(PATH_ID_PATHING, true);
                }, 20s);
            }
        }

        void KilledUnit(Unit* victim) override
        {
            if (victim->GetTypeId() == TYPEID_PLAYER && urand(0, 1))
                Talk(SAY_SLAY);
        }

        void JustDied(Unit* /*killer*/) override
        {
            Talk(SAY_DEATH);
            if (instance)
                instance->SetData(TYPE_HELLMAW, DONE);
        }

        bool CanAIAttack(Unit const* /*unit*/) const override
        {
            return !isBanished;
        }

        void DoMeleeAttackIfReady(bool ignoreCasting)
        {
            if (!ignoreCasting && me->HasUnitState(UNIT_STATE_CASTING))
            {
                return;
            }

            Unit* victim = me->GetVictim();
            if (!victim || !victim->IsInWorld())
            {
                return;
            }

            if (!me->IsWithinMeleeRange(victim))
            {
                return;
            }

            //Make sure our attack is ready and we aren't currently casting before checking distance
            if (me->isAttackReady())
            {
                // xinef: prevent base and off attack in same time, delay attack at 0.2 sec
                if (me->haveOffhandWeapon())
                {
                    if (me->getAttackTimer(OFF_ATTACK) < ATTACK_DISPLAY_DELAY)
                    {
                        me->setAttackTimer(OFF_ATTACK, ATTACK_DISPLAY_DELAY);
                    }
                }

                me->AttackerStateUpdate(victim, BASE_ATTACK, false, ignoreCasting);
                me->resetAttackTimer();
            }

            if (me->haveOffhandWeapon() && me->isAttackReady(OFF_ATTACK))
            {
                // xinef: delay main hand attack if both will hit at the same time (players code)
                if (me->getAttackTimer(BASE_ATTACK) < ATTACK_DISPLAY_DELAY)
                {
                    me->setAttackTimer(BASE_ATTACK, ATTACK_DISPLAY_DELAY);
                }

                me->AttackerStateUpdate(victim, OFF_ATTACK, false, ignoreCasting);
                me->resetAttackTimer(OFF_ATTACK);
            }
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);
            switch (events.ExecuteEvent())
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
                    break;
            }

            DoMeleeAttackIfReady(me->FindCurrentSpellBySpellId(SPELL_CORROSIVE_ACID) != nullptr);
        }
    };
};

void AddSC_boss_ambassador_hellmaw()
{
    new boss_ambassador_hellmaw();
}

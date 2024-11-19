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

#include "CreatureScript.h"
#include "ScriptedCreature.h"
#include "shadow_labyrinth.h"

enum Text
{
    SAY_INTRO               = 0,
    SAY_AGGRO               = 1,
    SAY_HELP                = 2,
    SAY_SLAY                = 3,
    SAY_DEATH               = 4
};

enum Spells
{
    SPELL_BANISH            = 30231,
    SPELL_CORROSIVE_ACID    = 33551,
    SPELL_FEAR              = 33547,
    SPELL_ENRAGE            = 34970
};

enum Misc
{
    PATH_ID_START           = 1873100,
    PATH_ID_PATHING         = 1873101,

    SOUND_INTRO             = 9349
};

struct boss_ambassador_hellmaw : public BossAI
{
    boss_ambassador_hellmaw(Creature* creature) : BossAI(creature, TYPE_HELLMAW) { }

    bool isBanished;

    void InitializeAI() override
    {
        Reset();

        if (instance->GetPersistentData(TYPE_RITUALISTS) != DONE)
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
        _Reset();
        isBanished = false;
        me->SetImmuneToAll(false);
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
        scheduler.Schedule(23050ms, 30350ms, [this](TaskContext context)
        {
            DoCastVictim(SPELL_CORROSIVE_ACID);
            context.Repeat(23050ms, 30350ms);
        }).Schedule(23s, 33s, [this](TaskContext context)
        {
            DoCastAOE(SPELL_FEAR);
            context.Repeat(23s, 33s);
        });

        if (IsHeroic())
        {
            scheduler.Schedule(3min, [this](TaskContext /*context*/)
            {
                DoCastSelf(SPELL_ENRAGE, true);
            });
        }
        _JustEngagedWith();
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
        if (victim->IsPlayer() && urand(0, 1))
        {
            Talk(SAY_SLAY);
        }
    }

    void JustDied(Unit* /*killer*/) override
    {
        Talk(SAY_DEATH);
        _JustDied();
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

        // Make sure our attack is ready and we aren't currently casting before checking distance
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

        scheduler.Update(diff);

        DoMeleeAttackIfReady(me->FindCurrentSpellBySpellId(SPELL_CORROSIVE_ACID) != nullptr);
    }
};

void AddSC_boss_ambassador_hellmaw()
{
    RegisterShadowLabyrinthCreatureAI(boss_ambassador_hellmaw);
}

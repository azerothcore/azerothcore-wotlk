/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "CreatureScript.h"
#include "ScriptedCreature.h"
#include "SpellMgr.h"
#include "halls_of_reflection.h"

enum Yells
{
    SAY_AGGRO             = 0,
    SAY_SLAY              = 1,
    SAY_DEATH             = 2,
    SAY_IMPENDING_DESPAIR = 3,
    SAY_DEFILING_HORROR   = 4,
};

enum Spells
{
    SPELL_QUIVERING_STRIKE  = 72422,
    SPELL_IMPENDING_DESPAIR = 72426,
    SPELL_DEFILING_HORROR   = 72435,
};

enum Events
{
    EVENT_QUIVERING_STRIKE = 1,
    EVENT_IMPENDING_DESPAIR,
    EVENT_DEFILING_HORROR,
    EVENT_UNROOT,
};

constexpr uint32 hopelessnessId[3] = { 72395, 72396, 72397 };

struct boss_falric : public BossAI
{
    boss_falric(Creature* creature) : BossAI(creature, DATA_FALRIC) { }

    void Reset() override
    {
        BossAI::Reset();
        _hopelessnessCount = 0;
        _startingFight = false;
        me->SetImmuneToAll(true);
        me->SetControlled(false, UNIT_STATE_ROOT);
    }

    void JustEngagedWith(Unit* who) override
    {
        BossAI::JustEngagedWith(who);
        me->SetImmuneToAll(false);

        events.ScheduleEvent(EVENT_QUIVERING_STRIKE, 5s);
        events.ScheduleEvent(EVENT_IMPENDING_DESPAIR, 11s);
        events.ScheduleEvent(EVENT_DEFILING_HORROR, 20s);
    }

    void DoAction(int32 action) override
    {
        if (action == 1)
        {
            Talk(SAY_AGGRO);
            _startingFight = true;
            me->m_Events.AddEventAtOffset([this]()
            {
                _startingFight = false;
                me->SetInCombatWithZone();
            }, 8s);
        }
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;

        events.Update(diff);

        if (me->HasUnitState(UNIT_STATE_CASTING))
            return;

        switch (events.ExecuteEvent())
        {
            case EVENT_QUIVERING_STRIKE:
                DoCastVictim(SPELL_QUIVERING_STRIKE);
                events.Repeat(5s);
                break;
            case EVENT_IMPENDING_DESPAIR:
                if (Unit* target = SelectTargetFromPlayerList(45.0f, 0, true))
                {
                    Talk(SAY_IMPENDING_DESPAIR);
                    DoCast(target, SPELL_IMPENDING_DESPAIR);
                }
                events.Repeat(12s);
                break;
            case EVENT_DEFILING_HORROR:
                Talk(SAY_DEFILING_HORROR);
                DoCastAOE(SPELL_DEFILING_HORROR);
                me->SetControlled(true, UNIT_STATE_ROOT);
                events.DelayEventsToMax(5s, 0);
                events.ScheduleEvent(EVENT_UNROOT, 4s);
                events.Repeat(20s);
                break;
            case EVENT_UNROOT:
                me->SetControlled(false, UNIT_STATE_ROOT);
                break;
        }

        if ((_hopelessnessCount == 0 && HealthBelowPct(67))
            || (_hopelessnessCount == 1 && HealthBelowPct(34))
            || (_hopelessnessCount == 2 && HealthBelowPct(11)))
        {
            if (_hopelessnessCount)
                me->RemoveOwnedAura(sSpellMgr->GetSpellIdForDifficulty(hopelessnessId[_hopelessnessCount - 1], me));

            DoCastAOE(hopelessnessId[_hopelessnessCount], true);
            ++_hopelessnessCount;
        }

        if (!me->HasUnitState(UNIT_STATE_ROOT))
            DoMeleeAttackIfReady();
    }

    void JustDied(Unit* killer) override
    {
        BossAI::JustDied(killer);
        Talk(SAY_DEATH);
    }

    void KilledUnit(Unit* who) override
    {
        if (who->IsPlayer())
            Talk(SAY_SLAY);
    }

    void EnterEvadeMode(EvadeReason why) override
    {
        me->SetControlled(false, UNIT_STATE_ROOT);
        BossAI::EnterEvadeMode(why);
        if (_startingFight)
            Reset();
    }

private:
    uint8 _hopelessnessCount{};
    bool _startingFight{};
};

void AddSC_boss_falric()
{
    RegisterHallsOfReflectionCreatureAI(boss_falric);
}

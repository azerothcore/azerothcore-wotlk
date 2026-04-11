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
#include "violet_hold.h"

enum eSpells
{
    SPELL_BLOODLUST                             = 54516,
    SPELL_BREAK_BONDS                           = 59463,
    SPELL_CHAIN_HEAL                            = 54481,
    SPELL_EARTH_SHIELD                          = 54479,
    SPELL_EARTH_SHOCK                           = 54511,
    SPELL_LIGHTNING_BOLT                        = 53044,
    SPELL_STORMSTRIKE                           = 51876,
};

enum Yells
{
    SAY_AGGRO                                   = 0,
    SAY_SLAY                                    = 1,
    SAY_DEATH                                   = 2,
    SAY_SPAWN                                   = 3,
    SAY_ADD_KILLED                              = 4,
    SAY_BOTH_ADDS_KILLED                        = 5
};

enum eEvents
{
    EVENT_SPELL_BLOODLUST = 1,
    EVENT_SPELL_BREAK_BONDS,
    EVENT_SPELL_CHAIN_HEAL,
    EVENT_SPELL_EARTH_SHIELD,
    EVENT_SPELL_EARTH_SHOCK,
    EVENT_SPELL_LIGHTNING_BOLT,
    EVENT_SPELL_STORMSTRIKE,
};

struct boss_erekem : public BossAI
{
    boss_erekem(Creature* c) : BossAI(c, BOSS_EREKEM) { }

    void JustEngagedWith(Unit* who) override
    {
        BossAI::JustEngagedWith(who);
        Talk(SAY_AGGRO);
        DoCastSelf(SPELL_EARTH_SHIELD);
        events.RescheduleEvent(EVENT_SPELL_BLOODLUST, 15s);
        events.RescheduleEvent(EVENT_SPELL_BREAK_BONDS, 9s, 14s);
        events.RescheduleEvent(EVENT_SPELL_CHAIN_HEAL, 0ms);
        events.RescheduleEvent(EVENT_SPELL_EARTH_SHIELD, 20s);
        events.RescheduleEvent(EVENT_SPELL_EARTH_SHOCK, 2s, 8s);
        events.RescheduleEvent(EVENT_SPELL_LIGHTNING_BOLT, 5s, 10s);
        if (IsHeroic())
            events.RescheduleEvent(EVENT_SPELL_STORMSTRIKE, 3s);

        if (Creature* c = instance->instance->GetCreature(instance->GetGuidData(DATA_EREKEM_GUARD_1_GUID)))
            if (!c->IsInCombat())
                c->AI()->AttackStart(who);
        if (Creature* c = instance->instance->GetCreature(instance->GetGuidData(DATA_EREKEM_GUARD_2_GUID)))
            if (!c->IsInCombat())
                c->AI()->AttackStart(who);
    }

    void ExecuteEvent(uint32 eventId) override
    {
        switch (eventId)
        {
            case EVENT_SPELL_BLOODLUST:
                DoCastAOE(SPELL_BLOODLUST);
                events.Repeat(35s, 45s);
                break;
            case EVENT_SPELL_BREAK_BONDS:
                DoCastAOE(SPELL_BREAK_BONDS);
                events.Repeat(16s, 22s);
                break;
            case EVENT_SPELL_CHAIN_HEAL:
                if (ObjectGuid targetGuid = GetChainHealTargetGuid())
                {
                    if (Creature* target = instance->instance->GetCreature(targetGuid))
                        DoCast(target, SPELL_CHAIN_HEAL);

                    Creature* guard1 = instance->instance->GetCreature(instance->GetGuidData(DATA_EREKEM_GUARD_1_GUID));
                    Creature* guard2 = instance->instance->GetCreature(instance->GetGuidData(DATA_EREKEM_GUARD_2_GUID));
                    if ((guard1 && !guard1->IsAlive()) || (guard2 && !guard2->IsAlive()))
                    {
                        events.Repeat(3s, 6s);
                        break;
                    }
                }
                events.Repeat(8s, 11s);
                break;
            case EVENT_SPELL_EARTH_SHIELD:
                DoCastSelf(SPELL_EARTH_SHIELD);
                events.Repeat(20s);
                break;
            case EVENT_SPELL_EARTH_SHOCK:
                DoCastVictim(SPELL_EARTH_SHOCK);
                events.Repeat(8s, 13s);
                break;
            case EVENT_SPELL_LIGHTNING_BOLT:
                DoCastRandomTarget(SPELL_LIGHTNING_BOLT, 0, 35.0f);
                events.Repeat(15s, 25s);
                break;
            case EVENT_SPELL_STORMSTRIKE:
                {
                    Creature* guard1 = instance->instance->GetCreature(instance->GetGuidData(DATA_EREKEM_GUARD_1_GUID));
                    Creature* guard2 = instance->instance->GetCreature(instance->GetGuidData(DATA_EREKEM_GUARD_2_GUID));
                    if (guard1 && !guard1->IsAlive() && guard2 && !guard2->IsAlive())
                        DoCastVictim(SPELL_STORMSTRIKE);
                    events.Repeat(3s);
                }
                break;
        }
    }

    void JustDied(Unit* killer) override
    {
        Talk(SAY_DEATH);
        BossAI::JustDied(killer);
    }

    void KilledUnit(Unit* victim) override
    {
        if (victim && victim->GetGUID() == me->GetGUID())
            return;
        Talk(SAY_SLAY);
    }

    void MoveInLineOfSight(Unit* /*who*/) override {}

    void EnterEvadeMode(EvadeReason why) override
    {
        me->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
        _EnterEvadeMode(why);
    }

    ObjectGuid GetChainHealTargetGuid()
    {
        if (HealthBelowPct(85))
            return me->GetGUID();

        if (Creature* c = instance->instance->GetCreature(instance->GetGuidData(DATA_EREKEM_GUARD_1_GUID)))
            if (c->IsAlive() && !c->HealthAbovePct(75))
                return c->GetGUID();

        if (Creature* c = instance->instance->GetCreature(instance->GetGuidData(DATA_EREKEM_GUARD_2_GUID)))
            if (c->IsAlive() && !c->HealthAbovePct(75))
                return c->GetGUID();

        return me->GetGUID();
    }
};

enum GuardSpells
{
    SPELL_GUSHING_WOUND                         = 39215,
    SPELL_HOWLING_SCREECH                       = 54462,
    SPELL_STRIKE                                = 14516
};

enum eGuardEvents
{
    EVENT_SPELL_GUSHING_WOUND = 1,
    EVENT_SPELL_HOWLING_SCREECH,
    EVENT_SPELL_STRIKE
};

struct npc_erekem_guard : public ScriptedAI
{
    npc_erekem_guard(Creature* c) : ScriptedAI(c)
    {
        _instance = c->GetInstanceScript();
    }

    void Reset() override
    {
        _events.Reset();
    }

    void JustEngagedWith(Unit* who) override
    {
        DoZoneInCombat();
        _events.Reset();
        _events.RescheduleEvent(EVENT_SPELL_GUSHING_WOUND, 1s, 3s);
        _events.RescheduleEvent(EVENT_SPELL_HOWLING_SCREECH, 8s, 13s);
        _events.RescheduleEvent(EVENT_SPELL_STRIKE, 4s, 8s);

        if (Creature* c = _instance->GetCreature(BOSS_EREKEM))
            if (!c->IsInCombat())
                c->AI()->AttackStart(who);
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;

        _events.Update(diff);

        if (me->HasUnitState(UNIT_STATE_CASTING))
            return;

        switch (_events.ExecuteEvent())
        {
            case EVENT_SPELL_GUSHING_WOUND:
                DoCastVictim(SPELL_GUSHING_WOUND);
                _events.Repeat(7s, 12s);
                break;
            case EVENT_SPELL_HOWLING_SCREECH:
                DoCastVictim(SPELL_HOWLING_SCREECH);
                _events.Repeat(8s, 13s);
                break;
            case EVENT_SPELL_STRIKE:
                DoCastVictim(SPELL_STRIKE);
                _events.Repeat(4s, 8s);
                break;
        }

        DoMeleeAttackIfReady();
    }

    void MoveInLineOfSight(Unit* /*who*/) override {}

private:
    InstanceScript* _instance;
    EventMap _events;
};

void AddSC_boss_erekem()
{
    RegisterVioletHoldCreatureAI(boss_erekem);
    RegisterVioletHoldCreatureAI(npc_erekem_guard);
}

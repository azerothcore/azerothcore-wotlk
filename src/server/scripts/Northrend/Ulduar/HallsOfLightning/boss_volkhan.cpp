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
#include "SpellInfo.h"
#include "halls_of_lightning.h"

enum VolkahnSpells
{
    // Volkhan
    SPELL_HEAT_N                        = 52387,
    SPELL_HEAT_H                        = 59528,
    SPELL_SHATTERING_STOMP_N            = 52237,
    SPELL_SHATTERING_STOMP_H            = 59529,
    SPELL_TEMPER                        = 52238,
    SPELL_SUMMON_MOLTEN_GOLEM           = 52405,

    //Molten Golem
    SPELL_BLAST_WAVE                    = 23113,
    SPELL_IMMOLATION_STRIKE_N           = 52433,
    SPELL_IMMOLATION_STRIKE_H           = 59530,
    SPELL_SHATTER_N                     = 52429,
    SPELL_SHATTER_H                     = 59527,
};

enum VolkhanOther
{
    // NPCs
    NPC_VOLKHAN_ANVIL                   = 28823,
    NPC_MOLTEN_GOLEM                    = 28695,
    NPC_BRITTLE_GOLEM                   = 28681,

    // Misc
    ACTION_SHATTER                      = 1,
    ACTION_DESTROYED                    = 2,

    // Point
    POINT_ANVIL                         = 1,
};

enum VolkhanEvents
{
    // Volkhan
    EVENT_HEAT                          = 1,
    EVENT_CHECK_HEALTH                  = 2,
    EVENT_SHATTER                       = 3,
    EVENT_POSITION                      = 4,
    EVENT_MOVE_TO_ANVIL                 = 5,

    // Molten Golem
    EVENT_BLAST                         = 11,
    EVENT_IMMOLATION                    = 12,
};

enum Yells
{
    SAY_AGGRO                               = 0,
    SAY_FORGE                               = 1,
    SAY_STOMP                               = 2,
    SAY_SLAY                                = 3,
    SAY_DEATH                               = 4,
    EMOTE_TO_ANVIL                          = 5,
    EMOTE_SHATTER                           = 6,
};

struct boss_volkhan : public BossAI
{
    boss_volkhan(Creature* creature) : BossAI(creature, DATA_VOLKHAN), summons(creature) { }

    void Reset() override
    {
        _Reset();
        x = y = z = PointID = ShatteredCount = 0;
        HealthCheck = 100;
        me->SetSpeed(MOVE_RUN, 1.2f, true);
        me->SetReactState(REACT_AGGRESSIVE);
        instance->SetData(DATA_VOLKHAN_ACHIEVEMENT, true);
    }

    void JustEngagedWith(Unit*) override
    {
        _JustEngagedWith();
        me->SetInCombatWithZone();
        Talk(SAY_AGGRO);
        ScheduleEvents(false);
    }

    void JustDied(Unit*) override
    {
        _JustDied();
        Talk(SAY_DEATH);
    }

    void GetNextPos()
    {
        if (me->GetPositionY() < -180)
        {
            if (me->GetPositionX() > 1330)
                x = 1355;
            else
                x = 1308;

            y = -178;
            z = 52.5f;
        }
        else if (me->GetPositionY() < -145)
        {
            if (me->GetPositionX() > 1330)
                x = 1355;
            else
                x = 1308;

            y = -137;
            z = 52.5f;
        }
        else if (me->GetPositionY() < -130)
        {
            if (me->GetPositionX() > 1330)
                x = 1343;
            else
                x = 1320;

            y = -123;
            z = 56.7f;
        }
        else
        {
            PointID = POINT_ANVIL;
            x = 1327;
            y = -96;
            z = 56.7f;
        }
    }

    void KilledUnit(Unit* victim) override
    {
        if (!victim->IsPlayer())
            return;

        Talk(SAY_SLAY);
    }

    void ScheduleEvents(bool anvil)
    {
        events.SetPhase(1);
        events.RescheduleEvent(EVENT_HEAT, 8s, 0, 1);
        events.RescheduleEvent(EVENT_SHATTER, 10s, 0, 1);
        events.RescheduleEvent(EVENT_CHECK_HEALTH, anvil ? 1s : 6s, 0, 1);
        events.RescheduleEvent(EVENT_POSITION, 4s, 0, 1);
    }

    void JustSummoned(Creature* summon) override
    {
        summons.Summon(summon);
        if (summon->GetEntry() == NPC_MOLTEN_GOLEM)
        {
            summon->SetFaction(me->GetFaction());

            if (Unit* target = SelectTarget(SelectTargetMethod::Random))
                summon->AI()->AttackStart(target);
        }
    }

    void DoAction(int32 param) override
    {
        if (param == ACTION_DESTROYED)
        {
            ShatteredCount++;
            if (ShatteredCount > 4)
                instance->SetData(DATA_VOLKHAN_ACHIEVEMENT, false);
        }
    }

    void MovementInform(uint32 type, uint32 id) override
    {
        if (type != POINT_MOTION_TYPE)
            return;

        if (id == POINT_ANVIL)
        {
            me->SetSpeed(MOVE_RUN, 1.2f, true);
            me->SetReactState(REACT_AGGRESSIVE);
            me->CastSpell(me, SPELL_TEMPER, false);
            PointID = 0;
            ScheduleEvents(true);

            // update orientation at server
            me->SetOrientation(2.19f);

            // and client
            WorldPacket data;
            me->BuildHeartBeatMsg(&data);
            me->SendMessageToSet(&data, false);
            me->SetControlled(true, UNIT_STATE_ROOT);
        }
        else
            events.ScheduleEvent(EVENT_MOVE_TO_ANVIL, 0ms, 0, 2);
    }

    void SpellHitTarget(Unit* /*who*/, SpellInfo const* spellInfo) override
    {
        if (spellInfo->Id == SPELL_TEMPER)
        {
            me->CastSpell(me, SPELL_SUMMON_MOLTEN_GOLEM, true);
            me->CastSpell(me, SPELL_SUMMON_MOLTEN_GOLEM, true);
            me->GetMotionMaster()->MoveChase(me->GetVictim());
            me->SetControlled(false, UNIT_STATE_ROOT);
        }
    }

    void GoToAnvil()
    {
        events.SetPhase(2);
        HealthCheck -= 20;
        me->SetSpeed(MOVE_RUN, 4.0f, true);
        me->SetReactState(REACT_PASSIVE);

        Talk(SAY_FORGE);

        if (me->GetMotionMaster()->GetCurrentMovementGeneratorType() == CHASE_MOTION_TYPE)
            me->GetMotionMaster()->MovementExpired();

        events.ScheduleEvent(EVENT_MOVE_TO_ANVIL, 0ms, 0, 2);
    }

    void UpdateAI(uint32 diff) override
    {
        //Return since we have no target
        if (!UpdateVictim())
            return;

        events.Update(diff);

        if (me->HasUnitState(UNIT_STATE_CASTING))
            return;

        switch (events.ExecuteEvent())
        {
            case EVENT_HEAT:
                me->CastSpell(me, me->GetMap()->IsHeroic() ? SPELL_HEAT_H : SPELL_HEAT_N, true);
                events.Repeat(8s);
                break;
            case EVENT_CHECK_HEALTH:
                if (HealthBelowPct(HealthCheck))
                    GoToAnvil();

                events.Repeat(1s);
                return;
            case EVENT_SHATTER:
                {
                    events.Repeat(10s);
                    summons.DoAction(ACTION_SHATTER);
                    break;
                }
            case EVENT_MOVE_TO_ANVIL:
                GetNextPos();
                me->GetMotionMaster()->MovePoint(PointID, x, y, z);
                return;
            case EVENT_POSITION:
                if (me->GetDistance(1331.9f, -106, 56) > 95)
                    EnterEvadeMode();
                else
                    events.Repeat(4s);

                return;
        }

        DoMeleeAttackIfReady();
    }

    private:
        EventMap events;
        SummonList summons;
        uint8 HealthCheck;
        float x, y, z;
        uint8 PointID;
        uint8 ShatteredCount;
};

struct npc_molten_golem : public ScriptedAI
{
    npc_molten_golem(Creature* creature) : ScriptedAI(creature)
    {
        m_pInstance = creature->GetInstanceScript();
    }

    void Reset() override
    {
        events.Reset();
        events.ScheduleEvent(EVENT_BLAST, 7s);
        events.ScheduleEvent(EVENT_IMMOLATION, 3s);
    }

    void DamageTaken(Unit*, uint32& uiDamage, DamageEffectType, SpellSchoolMask) override
    {
        if (me->GetEntry() == NPC_BRITTLE_GOLEM)
        {
            uiDamage = 0;
            return;
        }

        if (uiDamage >= me->GetHealth())
        {
            me->UpdateEntry(NPC_BRITTLE_GOLEM, 0, false);
            me->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE | UNIT_FLAG_DISABLE_MOVE);
            me->SetHealth(me->GetMaxHealth());
            me->RemoveAllAuras();
            me->AttackStop();
            uiDamage = 0;

            if (me->IsNonMeleeSpellCast(false))
                me->InterruptNonMeleeSpells(false);

            me->SetControlled(true, UNIT_STATE_STUNNED);
        }
    }

    void DoAction(int32 param) override
    {
        if (me->GetEntry() == NPC_BRITTLE_GOLEM && param == ACTION_SHATTER)
        {
            if (Creature* volkhan = m_pInstance->GetCreature(DATA_VOLKHAN))
                volkhan->AI()->DoAction(ACTION_DESTROYED);

            me->CastSpell(me, me->GetMap()->IsHeroic() ? SPELL_SHATTER_H : SPELL_SHATTER_N, true);
            me->DespawnOrUnsummon(500ms);
        }
    }

    void UpdateAI(uint32 diff) override
    {
        //Return since we have no target or if we are frozen
        if (!UpdateVictim() || me->GetEntry() == NPC_BRITTLE_GOLEM)
            return;

        events.Update(diff);

        if (me->HasUnitState(UNIT_STATE_CASTING))
            return;

        switch (events.ExecuteEvent())
        {
            case EVENT_BLAST:
                me->CastSpell(me, SPELL_BLAST_WAVE, false);
                events.Repeat(14s);
                break;
            case EVENT_IMMOLATION:
                me->CastSpell(me->GetVictim(), me->GetMap()->IsHeroic() ? SPELL_IMMOLATION_STRIKE_H : SPELL_IMMOLATION_STRIKE_N, false);
                events.Repeat(5s);
                break;
        }

        DoMeleeAttackIfReady();
    }
private:
    EventMap events;
    InstanceScript* m_pInstance;
};

void AddSC_boss_volkhan()
{
    RegisterHallOfLightningCreatureAI(boss_volkhan);
    RegisterHallOfLightningCreatureAI(npc_molten_golem);
}

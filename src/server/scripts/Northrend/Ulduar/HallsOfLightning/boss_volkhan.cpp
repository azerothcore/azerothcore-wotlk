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
#include "SpellInfo.h"
#include "halls_of_lightning.h"

enum VolkahnSpells
{
    // Volkhan
    SPELL_HEAT                          = 52387,
    SPELL_SHATTERING_STOMP              = 52237,
    SPELL_TEMPER                        = 52238,
    SPELL_SUMMON_MOLTEN_GOLEM           = 52405,

    //Molten Golem
    SPELL_BLAST_WAVE                    = 23113,
    SPELL_COOL_DOWN                     = 52443,
    SPELL_IMMOLATION_STRIKE             = 52433,
    SPELL_SHATTER                       = 52429,
};

enum VolkhanOther
{
    // NPCs
    NPC_VOLKHAN_ANVIL                   = 28823,
    NPC_MOLTEN_GOLEM                    = 28695,
    NPC_BRITTLE_GOLEM                   = 28681,
    NPC_SLAG                            = 28585,

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
    EVENT_IMMOLATION_STRIKE             = 12,
    EVENT_CHANGE_TARGET                 = 13,
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
    boss_volkhan(Creature* creature) : BossAI(creature, DATA_VOLKHAN) { }

    void Reset() override
    {
        _Reset();
        x = y = z = PointID = ShatteredCount = 0;
        shatteredStompCast = false;
        me->SetSpeed(MOVE_RUN, 1.2f, true);
        me->SetReactState(REACT_AGGRESSIVE);
        instance->SetData(DATA_VOLKHAN_ACHIEVEMENT, true);
    }

    void JustEngagedWith(Unit*) override
    {
        _JustEngagedWith();
        me->SetInCombatWithZone();
        Talk(SAY_AGGRO);
        events.ScheduleEvent(EVENT_MOVE_TO_ANVIL, randtime(9s, 14s));
        events.ScheduleEvent(EVENT_HEAT, randtime(18s, 38s));
        events.ScheduleEvent(EVENT_CHECK_HEALTH, 1s);
        events.ScheduleEvent(EVENT_POSITION, 4s);
    }

    void JustDied(Unit*) override
    {
        _JustDied();
        Talk(SAY_DEATH);

        std::list<Creature*> slags;
        GetCreatureListWithEntryInGrid(slags, me, NPC_SLAG, 100.0f);

        if (!slags.empty())
        {
            for (Creature* slag : slags)
            {
                if (slag)
                    slag->DespawnOrUnsummon();
            }
        }
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

    bool HasActiveGolem()
    {
        for (ObjectGuid const& guid : summons)
        {
            if (Creature* golem = ObjectAccessor::GetCreature(*me, guid))
            {
                if (golem->GetEntry() == NPC_MOLTEN_GOLEM && golem->IsAlive())
                    return true;
            }
        }
        return false;
    }

    void MovementInform(uint32 type, uint32 id) override
    {
        if (type != POINT_MOTION_TYPE)
            return;

        if (id == POINT_ANVIL)
        {
            me->SetSpeed(MOVE_RUN, 1.2f, true);
            DoCastSelf(SPELL_TEMPER);
            PointID = 0;

            // update orientation at server
            me->SetOrientation(2.19f);

            // and client
            me->SendMovementFlagUpdate(false);
            me->SetControlled(true, UNIT_STATE_ROOT);
        }
        else
            me->GetMotionMaster()->MovePoint(PointID, x, y, z);
    }

    void SpellHitTarget(Unit* /*who*/, SpellInfo const* spellInfo) override
    {
        if (spellInfo->Id == SPELL_TEMPER)
        {
            DoCastSelf(SPELL_SUMMON_MOLTEN_GOLEM, true);
            DoCastSelf(SPELL_SUMMON_MOLTEN_GOLEM, true);
            me->SetControlled(false, UNIT_STATE_ROOT);
            me->SetReactState(REACT_AGGRESSIVE);
            if (me->GetVictim())
                me->GetMotionMaster()->MoveChase(me->GetVictim());

            events.RescheduleEvent(EVENT_HEAT, randtime(9s, 24s));
        }
    }

    void GoToAnvil()
    {
        me->SetSpeed(MOVE_RUN, 4.0f, true);
        me->SetReactState(REACT_PASSIVE);

        Talk(SAY_FORGE);

        if (me->GetMotionMaster()->GetCurrentMovementGeneratorType() == CHASE_MOTION_TYPE)
            me->GetMotionMaster()->MovementExpired();

        GetNextPos();
        me->GetMotionMaster()->MovePoint(PointID, x, y, z);
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
            case EVENT_HEAT:
                if (HasActiveGolem())
                {
                    DoCastSelf(SPELL_HEAT);
                    events.Repeat(randtime(9s, 24s));
                }
                break;
            case EVENT_CHECK_HEALTH:
                if (!shatteredStompCast && HealthBelowPct(25))
                {
                    shatteredStompCast = true;
                    DoCastAOE(SPELL_SHATTERING_STOMP);
                    Talk(SAY_STOMP);
                    summons.DoAction(ACTION_SHATTER);
                }
                events.Repeat(1s);
                return;
            case EVENT_MOVE_TO_ANVIL:
                GoToAnvil();
                events.Repeat(randtime(30s, 36s));
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
        float x, y, z;
        uint8 PointID;
        uint8 ShatteredCount;
        bool shatteredStompCast;
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
        events.ScheduleEvent(EVENT_IMMOLATION_STRIKE, 3s);
        events.ScheduleEvent(EVENT_CHANGE_TARGET, 5s);
        DoCastSelf(SPELL_COOL_DOWN, true);
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
            if (me->GetMap()->IsHeroic())
                DoCastSelf(SPELL_BLAST_WAVE, true);

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

            me->CastSpell(me, SPELL_SHATTER, true);
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
            case EVENT_IMMOLATION_STRIKE:
                if (SelectTarget(SelectTargetMethod::MaxThreat, 0, 0.0f, true, true, -SPELL_IMMOLATION_STRIKE))
                    DoCastVictim(SPELL_IMMOLATION_STRIKE);
                events.Repeat(5s);
                break;
            case EVENT_CHANGE_TARGET:
                if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 0.0f, true))
                {
                    me->GetThreatMgr().ResetAllThreat();
                    me->AddThreat(target, 30000.0f);
                    AttackStart(target);
                }
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

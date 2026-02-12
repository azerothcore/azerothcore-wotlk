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
#include "ScriptedEscortAI.h"
#include "halls_of_lightning.h"

enum BjarngrimSpells
{
    // DEFENSIVE STANCE
    SPELL_DEFENSIVE_STANCE              = 53790,
    SPELL_DEFENSIVE_AURA                = 41105,
    SPELL_BJARNGRIM_REFLETION           = 36096,
    SPELL_PUMMEL                        = 12555,
    SPELL_KNOCK_AWAY                    = 52029,
    SPELL_IRONFORM                      = 52022,

    // BERSERKER STANCE
    SPELL_BERSERKER_STANCE              = 53791,
    SPELL_BERSERKER_AURA                = 41107,
    SPELL_MORTAL_STRIKE                 = 16856,
    SPELL_WHIRLWIND                     = 52027,

    // BATTLE STANCE
    SPELL_BATTLE_STANCE                 = 53792,
    SPELL_BATTLE_AURA                   = 41106,
    SPELL_INTERCEPT                     = 58769,
    SPELL_CLEAVE                        = 15284,
    SPELL_SLAM                          = 52026,

    //OTHER SPELLS
    SPELL_CHARGE_UP                     = 52098,      // only used when starting walk from one platform to the other
    SPELL_TEMPORARY_ELECTRICAL_CHARGE   = 52092,      // triggered part of above

    // STORMFORGED LIEUTENANT
    SPELL_ARC_WELD                      = 59085,
    SPELL_RENEW_STEEL                   = 52774,
};

enum BjarngrimOther
{
    // Stances
    STANCE_DEFENSIVE                    = 1,
    STANCE_BERSERKER                    = 2,
    STANCE_BATTLE                       = 3,

    // NPCs
    NPC_STORMFORGED_LIEUTENANT          = 29240,

    // Models
    EQUIP_SWORD                         = 37871,
    EQUIP_SHIELD                        = 35642,
    EQUIP_MACE                          = 43623,
};

enum BjarngrimEvents
{
    EVENT_BJARNGRIM_CHANGE_STANCE       = 1,

    // DEFENSIVE STANCE
    EVENT_BJARNGRIM_REFLECTION          = 11,
    EVENT_BJARNGRIM_PUMMEL              = 12,
    EVENT_BJARNGRIM_KNOCK               = 13,
    EVENT_BJARNGRIM_IRONFORM            = 14,

    // BERSERKER STANCE
    EVENT_BJARNGRIM_MORTAL_STRIKE       = 21,
    EVENT_BJARNGRIM_WHIRLWIND           = 22,

    // BATTLE STANCE
    EVENT_BJARNGRIM_INTERCEPT           = 31,
    EVENT_BJARNGRIM_CLEAVE              = 32,
    EVENT_BJARNGRIM_SLAM                = 33,

    // STORMFORGED LIEUTENANT
    EVENT_ARC_WELD                      = 41,
    EVENT_RENEW_STEEL                   = 42,

    // CHARGE UP
    EVENT_CHARGE_UP                     = 51,
};

enum Yells
{
    SAY_AGGRO                               = 0,
    SAY_DEFENSIVE_STANCE                    = 1,
    SAY_BATTLE_STANCE                       = 2,
    SAY_BERSERKER_STANCE                    = 3,
    SAY_SLAY                                = 4,
    SAY_DEATH                               = 5,
    EMOTE_DEFENSIVE_STANCE                  = 6,
    EMOTE_BATTLE_STANCE                     = 7,
    EMOTE_BERSEKER_STANCE                   = 8,
};

struct boss_bjarngrim : public npc_escortAI
{
    boss_bjarngrim(Creature* creature) : npc_escortAI(creature), summons(creature), m_uiStance(STANCE_BATTLE)
    {
        m_pInstance = creature->GetInstanceScript();
        InitializeWaypoints();
        me->SetWalk(true);
        Start(true, ObjectGuid::Empty, nullptr, false, true);
    }

    void InitializeWaypoints()
    {
        AddWaypoint(1, 1262.0f, -26.9f, 33.5f, 10000);
        AddWaypoint(2, 1262.18f, 99.3f, 33.5f, 10000);
        AddWaypoint(3, 1262.0f, -26.9f, 33.5f, 0);
        AddWaypoint(4, 1332.0f, -26.6f, 40.18f, 10000);
        AddWaypoint(5, 1395.092f, 36.6425f, 50.038f, 10000);
        AddWaypoint(6, 1332.0f, -26.6f, 40.18f, 0);
        AddWaypoint(7, 1262.0f, -26.9f, 33.5f, 0);
    }

    void Reset() override
    {
        events.Reset();
        summons.DespawnAll();

        for (uint8 i = 0; i < 2; ++i)
            if (Creature* dwarf = me->SummonCreature(NPC_STORMFORGED_LIEUTENANT, me->GetPositionX() + urand(4, 12), me->GetPositionY() + urand(4, 12), me->GetPositionZ()))
            {
                float angle = i == 0 ? 2.5f : 3.78f;
                dwarf->GetMotionMaster()->MoveFollow(me, 3, angle);
                summons.Summon(dwarf);
            }

        me->RemoveAllAuras();

        if (m_pInstance)
            m_pInstance->SetBossState(DATA_BJARNGRIM, NOT_STARTED);

        DoCastSelf(SPELL_BATTLE_STANCE, true);
        SetEquipmentSlots(false, EQUIP_SWORD, EQUIP_SHIELD, EQUIP_NO_CHANGE);
    }

    void JustEngagedWith(Unit*) override
    {
        me->SetInCombatWithZone();
        Talk(SAY_AGGRO);

        RollStance(STANCE_BATTLE);

        events.ScheduleEvent(EVENT_BJARNGRIM_CHANGE_STANCE, 20s, 0);

        // DEFENSIVE STANCE
        events.ScheduleEvent(EVENT_BJARNGRIM_REFLECTION, 8s, STANCE_DEFENSIVE);
        events.ScheduleEvent(EVENT_BJARNGRIM_KNOCK, 16s, STANCE_DEFENSIVE);
        events.ScheduleEvent(EVENT_BJARNGRIM_IRONFORM, 12s, STANCE_DEFENSIVE);

        // BERSERKER STANCE
        events.ScheduleEvent(EVENT_BJARNGRIM_INTERCEPT, 23s, STANCE_BERSERKER);
        events.ScheduleEvent(EVENT_BJARNGRIM_CLEAVE, 25s, STANCE_BERSERKER);
        events.ScheduleEvent(EVENT_BJARNGRIM_WHIRLWIND, 26s, STANCE_BERSERKER);

        // BATTLE STANCE
        events.ScheduleEvent(EVENT_BJARNGRIM_PUMMEL, 5s, STANCE_BATTLE);
        events.ScheduleEvent(EVENT_BJARNGRIM_MORTAL_STRIKE, 24s, STANCE_BATTLE);
        events.ScheduleEvent(EVENT_BJARNGRIM_SLAM, 30s, STANCE_BATTLE);

        if (m_pInstance)
        {
            m_pInstance->SetBossState(DATA_BJARNGRIM, IN_PROGRESS);
            m_pInstance->SetData(DATA_BJARNGRIM_ACHIEVEMENT, me->HasAura(SPELL_TEMPORARY_ELECTRICAL_CHARGE));
        }
    }

    void KilledUnit(Unit* victim) override
    {
        if (!victim->IsPlayer())
            return;

        Talk(SAY_SLAY);
    }

    void JustDied(Unit*) override
    {
        Talk(SAY_DEATH);

        if (m_pInstance)
            m_pInstance->SetBossState(DATA_BJARNGRIM, DONE);
    }

    void RemoveStanceAura(uint8 stance)
    {
        switch (stance)
        {
            case STANCE_DEFENSIVE:
                me->RemoveAura(SPELL_DEFENSIVE_STANCE);
                me->RemoveAura(SPELL_DEFENSIVE_AURA);
                break;
            case STANCE_BERSERKER:
                me->RemoveAura(SPELL_BERSERKER_STANCE);
                me->RemoveAura(SPELL_BERSERKER_AURA);
                break;
            case STANCE_BATTLE:
                me->RemoveAura(SPELL_BATTLE_STANCE);
                me->RemoveAura(SPELL_BATTLE_AURA);
                break;
        }
    }

    void RollStance(uint8 stance, uint8 force = 0)
    {
        if (urand(0, 1))
            stance = (++stance == 4 ? 1 : stance);
        else
            stance = (--stance == 0 ? 3 : stance);

        if (force)
            stance = force;

        switch (stance)
        {
            case STANCE_DEFENSIVE:
                Talk(SAY_DEFENSIVE_STANCE);

                DoCastSelf(SPELL_DEFENSIVE_STANCE, true);
                DoCastSelf(SPELL_DEFENSIVE_AURA, true);

                events.DelayEvents(20s, STANCE_BERSERKER);
                events.DelayEvents(20s, STANCE_BATTLE);

                SetEquipmentSlots(false, EQUIP_SWORD, EQUIP_SHIELD, EQUIP_NO_CHANGE);
                break;
            case STANCE_BERSERKER:
                Talk(SAY_BERSERKER_STANCE);

                DoCastSelf(SPELL_BERSERKER_STANCE, true);
                DoCastSelf(SPELL_BERSERKER_AURA, true);

                events.DelayEvents(20s, STANCE_DEFENSIVE);
                events.DelayEvents(20s, STANCE_BATTLE);

                SetEquipmentSlots(false, EQUIP_SWORD, EQUIP_SWORD, EQUIP_NO_CHANGE);
                break;
            case STANCE_BATTLE:
                Talk(SAY_BATTLE_STANCE);

                DoCastSelf(SPELL_BATTLE_STANCE, true);
                DoCastSelf(SPELL_BATTLE_AURA, true);

                events.DelayEvents(20s, STANCE_BERSERKER);
                events.DelayEvents(20s, STANCE_DEFENSIVE);

                SetEquipmentSlots(false, EQUIP_MACE, EQUIP_UNEQUIP, EQUIP_NO_CHANGE);
                break;
        }

        m_uiStance = stance;
    }

    void WaypointReached(uint32 Point) override
    {
        if (Point == 1)
        {
            events.CancelEvent(EVENT_CHARGE_UP);
            events.ScheduleEvent(EVENT_CHARGE_UP, 2500ms, 0);
        }
        else if (Point == 2)
        {
            events.CancelEvent(EVENT_CHARGE_UP);
        }
        else if (Point == 3)
        {
            me->RemoveAura(SPELL_TEMPORARY_ELECTRICAL_CHARGE);
        }
        else if (Point == 4)
        {
            events.CancelEvent(EVENT_CHARGE_UP);
            events.ScheduleEvent(EVENT_CHARGE_UP, 2500ms, 0);
        }
        else if (Point == 5)
        {
            events.CancelEvent(EVENT_CHARGE_UP);
        }
        else if (Point == 6)
        {
            me->RemoveAura(SPELL_TEMPORARY_ELECTRICAL_CHARGE);
        }
    }

    void UpdateEscortAI(uint32 diff) override
    {
        events.Update(diff);

        if (!me->IsInCombat())
        {
            // Handle charge-up only when out of combat
            if (uint32 eventId = events.ExecuteEvent())
            {
                if (eventId == EVENT_CHARGE_UP)
                {
                    DoCastSelf(SPELL_CHARGE_UP, true);
                    DoCastSelf(SPELL_TEMPORARY_ELECTRICAL_CHARGE, true);
                }
            }
            return;
        }

        // Return since we have no target
        if (!UpdateVictim())
        {
            Reset();
            return;
        }

        if (me->HasUnitState(UNIT_STATE_CASTING))
            return;

        switch (events.ExecuteEvent())
        {
            case EVENT_BJARNGRIM_CHANGE_STANCE:
                // roll new stance
                RemoveStanceAura(m_uiStance);
                RollStance(m_uiStance);
                events.Repeat(20s);
                break;

            case EVENT_CHARGE_UP:
                DoCastSelf(SPELL_CHARGE_UP, true);
                DoCastSelf(SPELL_TEMPORARY_ELECTRICAL_CHARGE, true);
                break;

            // DEFENSIVE STANCE
            case EVENT_BJARNGRIM_REFLECTION:
                DoCastSelf(SPELL_BJARNGRIM_REFLETION, true);
                events.Repeat(8s, 9s);
                break;
            case EVENT_BJARNGRIM_PUMMEL:
                DoCastVictim(SPELL_PUMMEL);
                events.Repeat(10s, 11s);
                break;
            case EVENT_BJARNGRIM_KNOCK:
                DoCastAOE(SPELL_KNOCK_AWAY);
                events.Repeat(20s, 21s);
                break;
            case EVENT_BJARNGRIM_IRONFORM:
                DoCastSelf(SPELL_IRONFORM, true);
                events.Repeat(18s, 23s);
                break;

            // BERSERKER STANCE
            case EVENT_BJARNGRIM_MORTAL_STRIKE:
                DoCastVictim(SPELL_MORTAL_STRIKE);
                events.Repeat(10s);
                break;
            case EVENT_BJARNGRIM_WHIRLWIND:
                DoCastSelf(SPELL_WHIRLWIND, true);
                events.Repeat(25s);
                break;

            // BATTLE STANCE
            case EVENT_BJARNGRIM_INTERCEPT:
                DoCastRandomTarget(SPELL_INTERCEPT, 0, 40.0f, false, true);
                events.Repeat(30s);
                break;
            case EVENT_BJARNGRIM_CLEAVE:
                DoCastVictim(SPELL_CLEAVE);
                events.Repeat(25s);
                break;
            case EVENT_BJARNGRIM_SLAM:
                DoCastVictim(SPELL_SLAM);
                events.Repeat(10s, 12s);
                break;
        }

        DoMeleeAttackIfReady();
    }

    private:
        InstanceScript* m_pInstance;
        EventMap events;
        SummonList summons;
        uint8 m_uiStance;
};

struct npc_stormforged_lieutenant : public ScriptedAI
{
    npc_stormforged_lieutenant(Creature* creature) : ScriptedAI(creature) { }

    void Reset() override
    {
        if (me->IsSummon())
            BjarngrimGUID = me->ToTempSummon()->GetSummonerGUID();
        else
            BjarngrimGUID.Clear();
    }

    void JustEngagedWith(Unit*) override
    {
        events.ScheduleEvent(EVENT_ARC_WELD, 2s);
        events.ScheduleEvent(EVENT_RENEW_STEEL, 10s, 11s);
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
            case EVENT_ARC_WELD:
                me->CastSpell(me->GetVictim(), SPELL_ARC_WELD, true);
                events.Repeat(20s);
                break;
            case EVENT_RENEW_STEEL:
                if (Creature* bjarngrim = ObjectAccessor::GetCreature(*me, BjarngrimGUID))
                    if (bjarngrim->IsAlive())
                        me->CastSpell(bjarngrim, SPELL_RENEW_STEEL, true);

                events.Repeat(10s, 14s);
                break;
        }

        DoMeleeAttackIfReady();
    }

    private:
        EventMap events;
        ObjectGuid BjarngrimGUID;
};

void AddSC_boss_bjarngrim()
{
    RegisterHallOfLightningCreatureAI(boss_bjarngrim);
    RegisterHallOfLightningCreatureAI(npc_stormforged_lieutenant);
}

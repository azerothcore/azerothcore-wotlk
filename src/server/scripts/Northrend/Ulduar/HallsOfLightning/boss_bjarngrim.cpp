/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "halls_of_lightning.h"
#include "ScriptedEscortAI.h"

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
    SPELL_RENEW_STEEL_N                 = 52774,
    SPELL_RENEW_STEEL_H                 = 59160,
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

class boss_bjarngrim : public CreatureScript
{
public:
    boss_bjarngrim() : CreatureScript("boss_bjarngrim") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new boss_bjarngrimAI (creature);
    }

    struct boss_bjarngrimAI : public npc_escortAI
    {
        boss_bjarngrimAI(Creature* creature) : npc_escortAI(creature), summons(creature)
        {
            m_pInstance = creature->GetInstanceScript();

            // Init waypoints
            AddWaypoint(1, 1262.18f, 99.3f, 33.5f, 0);
            AddWaypoint(2, 1281.6f, 99.5f, 33.5f, 0);
            AddWaypoint(3, 1311.7f, 99.4f, 40.1f, 0);
            AddWaypoint(4, 1332.5f, 99.7f, 40.18f, 0);
            AddWaypoint(5, 1311.7f, 99.4f, 40.1f, 0);
            AddWaypoint(6, 1281.6f, 99.5f, 33.5f, 0);
            AddWaypoint(7, 1262.18f, 99.3f, 33.5f, 0);
            AddWaypoint(8, 1262, -26.9f, 33.5f, 0);
            AddWaypoint(9, 1281.2f, -26.8f, 33.5f, 0);
            AddWaypoint(10, 1311.3f, -26.9f, 40.03f, 0);
            AddWaypoint(11, 1332, -26.6f, 40.18f, 0);
            AddWaypoint(12, 1311.3f, -26.9f, 40.03f, 0);
            AddWaypoint(13, 1281.2f, -26.8f, 33.5f, 0);
            AddWaypoint(14, 1262, -26.9f, 33.5f, 0);
            
            Start(true, false, 0, NULL, false, true);
        }

        InstanceScript* m_pInstance;
        EventMap events;
        SummonList summons;
        uint8 m_uiStance;

        void Reset()
        {
            events.Reset();
            summons.DespawnAll();

            for (uint8 i = 0; i < 2; ++i)
                if (Creature* dwarf = me->SummonCreature(NPC_STORMFORGED_LIEUTENANT, me->GetPositionX()+urand(4,12), me->GetPositionY()+urand(4,12), me->GetPositionZ()))
                {
                    dwarf->GetMotionMaster()->MoveFollow(me, 3, rand_norm()*2*3.14f);
                    summons.Summon(dwarf);
                }

            me->RemoveAllAuras();
            me->CastSpell(me, SPELL_TEMPORARY_ELECTRICAL_CHARGE, true);
            RollStance(0, STANCE_DEFENSIVE);

            if (m_pInstance)
                m_pInstance->SetData(TYPE_BJARNGRIM, NOT_STARTED);
        }

        void EnterCombat(Unit*)
        {
            me->SetInCombatWithZone();
            Talk(SAY_AGGRO);

            events.ScheduleEvent(EVENT_BJARNGRIM_CHANGE_STANCE, 20000, 0);

            // DEFENSIVE STANCE
            events.ScheduleEvent(EVENT_BJARNGRIM_REFLECTION, 8000, STANCE_DEFENSIVE);
            events.ScheduleEvent(EVENT_BJARNGRIM_PUMMEL, 5000, STANCE_DEFENSIVE);
            events.ScheduleEvent(EVENT_BJARNGRIM_KNOCK, 16000, STANCE_DEFENSIVE);
            events.ScheduleEvent(EVENT_BJARNGRIM_IRONFORM, 12000, STANCE_DEFENSIVE);

            // BERSERKER STANCE
            events.ScheduleEvent(EVENT_BJARNGRIM_MORTAL_STRIKE, 20000+4000, STANCE_BERSERKER);
            events.ScheduleEvent(EVENT_BJARNGRIM_WHIRLWIND, 20000+6000, STANCE_BERSERKER);

            // BATTLE STANCE
            events.ScheduleEvent(EVENT_BJARNGRIM_INTERCEPT, 20000+3000, STANCE_BATTLE);
            events.ScheduleEvent(EVENT_BJARNGRIM_CLEAVE, 20000+5000, STANCE_BATTLE);
            events.ScheduleEvent(EVENT_BJARNGRIM_SLAM, 20000+10000, STANCE_BATTLE);

            if (m_pInstance)
            {
                m_pInstance->SetData(TYPE_BJARNGRIM, IN_PROGRESS);
                m_pInstance->SetData(DATA_BJARNGRIM_ACHIEVEMENT, me->HasAura(SPELL_TEMPORARY_ELECTRICAL_CHARGE));
            }
        }

        void KilledUnit(Unit* victim)
        {
            if (victim->GetTypeId() != TYPEID_PLAYER)
                return;

            Talk(SAY_SLAY);
        }

        void JustDied(Unit*)
        {
            Talk(SAY_DEATH);

            if (m_pInstance)
                m_pInstance->SetData(TYPE_BJARNGRIM, DONE);
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
            if (urand(0,1))
                stance = (++stance == 4 ? 1 : stance);
            else
                stance = (--stance == 0 ? 3 : stance);

            if (force)
                stance = force;
            
            switch (stance)
            {
                case STANCE_DEFENSIVE:
                    Talk(SAY_DEFENSIVE_STANCE);

                    me->CastSpell(me, SPELL_DEFENSIVE_STANCE, true);
                    me->CastSpell(me, SPELL_DEFENSIVE_AURA, true);

                    events.DelayEvents(20000, STANCE_BERSERKER);
                    events.DelayEvents(20000, STANCE_BATTLE);

                    SetEquipmentSlots(false, EQUIP_SWORD, EQUIP_SHIELD, EQUIP_NO_CHANGE);
                    break;
                case STANCE_BERSERKER:
                    Talk(SAY_BERSERKER_STANCE);

                    me->CastSpell(me, SPELL_BERSERKER_STANCE, true);
                    me->CastSpell(me, SPELL_BERSERKER_AURA, true);

                    events.DelayEvents(20000, STANCE_DEFENSIVE);
                    events.DelayEvents(20000, STANCE_BATTLE);

                    SetEquipmentSlots(false, EQUIP_SWORD, EQUIP_SWORD, EQUIP_NO_CHANGE);
                    break;
                case STANCE_BATTLE:
                    Talk(SAY_BATTLE_STANCE);

                    me->CastSpell(me, SPELL_BATTLE_STANCE, true);
                    me->CastSpell(me, SPELL_BATTLE_AURA, true);

                    events.DelayEvents(20000, STANCE_BERSERKER);
                    events.DelayEvents(20000, STANCE_DEFENSIVE);

                    SetEquipmentSlots(false, EQUIP_MACE, EQUIP_UNEQUIP, EQUIP_NO_CHANGE);
                    break;
            }

            m_uiStance = stance;
        }

        void WaypointReached(uint32 Point)
        {
            if (Point == 1 || Point == 8)
                me->CastSpell(me, SPELL_TEMPORARY_ELECTRICAL_CHARGE, true);
            else if (Point == 7 || Point == 14)
                me->RemoveAura(SPELL_TEMPORARY_ELECTRICAL_CHARGE);
        }

        void UpdateEscortAI(uint32 diff)
        {
            if (!me->IsInCombat())
                return;

            // Return since we have no target
            if (!UpdateVictim())
            {
                Reset();
                return;
            }

            events.Update(diff);

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (events.GetEvent())
            {
                case EVENT_BJARNGRIM_CHANGE_STANCE:
                    // roll new stance
                    RemoveStanceAura(m_uiStance);
                    RollStance(m_uiStance);
                    events.RepeatEvent(20000);
                    break;

                ///////////////////////////////////////////////////////
                ///// DEFENSIVE STANCE
                ///////////////////////////////////////////////////////
                case EVENT_BJARNGRIM_REFLECTION:
                    me->CastSpell(me, SPELL_BJARNGRIM_REFLETION, true);
                    events.RepeatEvent(8000 + rand()%1000);
                    break;
                case EVENT_BJARNGRIM_PUMMEL:
                    me->CastSpell(me->GetVictim(), SPELL_PUMMEL, false);
                    events.RepeatEvent(10000 + rand()%1000);
                    break;
                case EVENT_BJARNGRIM_KNOCK:
                    me->CastSpell(me, SPELL_KNOCK_AWAY, false);
                    events.RepeatEvent(20000 + rand()%1000);
                    break;
                case EVENT_BJARNGRIM_IRONFORM:
                    me->CastSpell(me, SPELL_IRONFORM, true);
                    events.RepeatEvent(18000 + rand()%5000);
                    break;

                ///////////////////////////////////////////////////////
                ///// BERSERKER STANCE
                ///////////////////////////////////////////////////////
                case EVENT_BJARNGRIM_MORTAL_STRIKE:
                    me->CastSpell(me->GetVictim(), SPELL_MORTAL_STRIKE, false);
                    events.RepeatEvent(10000);
                    break;
                case EVENT_BJARNGRIM_WHIRLWIND:
                    me->CastSpell(me, SPELL_WHIRLWIND, true);
                    events.RepeatEvent(25000);
                    break;
                    
                ///////////////////////////////////////////////////////
                ///// BATTLE STANCE
                ///////////////////////////////////////////////////////
                case EVENT_BJARNGRIM_INTERCEPT:
                    if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM))
                        me->CastSpell(target, SPELL_INTERCEPT, true);

                    events.RepeatEvent(30000);
                    break;
                case EVENT_BJARNGRIM_CLEAVE:
                    me->CastSpell(me->GetVictim(), SPELL_CLEAVE, false);
                    events.RepeatEvent(25000);
                    break;
                case EVENT_BJARNGRIM_SLAM:
                    me->CastSpell(me->GetVictim(), SPELL_SLAM, false);
                    events.RepeatEvent(10000 + rand()%2000);
                    break;
            }

            DoMeleeAttackIfReady();
        }
    };
};

class npc_stormforged_lieutenant : public CreatureScript
{
public:
    npc_stormforged_lieutenant() : CreatureScript("npc_stormforged_lieutenant") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_stormforged_lieutenantAI (creature);
    }

    struct npc_stormforged_lieutenantAI : public ScriptedAI
    {
        npc_stormforged_lieutenantAI(Creature* creature) : ScriptedAI(creature) { }

        EventMap events;
        uint64 BjarngrimGUID;

        void Reset()
        {
            if (me->IsSummon())
                BjarngrimGUID = me->ToTempSummon()->GetSummonerGUID();
            else
                BjarngrimGUID = 0;
        }

        void EnterCombat(Unit*)
        {
            events.ScheduleEvent(EVENT_ARC_WELD, 2000);
            events.ScheduleEvent(EVENT_RENEW_STEEL, 10000 + rand()%1000);
        }

        void UpdateAI(uint32 diff)
        {
            //Return since we have no target
            if (!UpdateVictim())
                return;

            events.Update(diff);

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (events.GetEvent())
            {
                case EVENT_ARC_WELD:
                    me->CastSpell(me->GetVictim(), SPELL_ARC_WELD, true);
                    events.RepeatEvent(20000);
                    break;
                case EVENT_RENEW_STEEL:
                    if (Creature* bjarngrim = ObjectAccessor::GetCreature(*me, BjarngrimGUID))
                        if (bjarngrim->IsAlive())
                            me->CastSpell(bjarngrim, me->GetMap()->IsHeroic() ? SPELL_RENEW_STEEL_H : SPELL_RENEW_STEEL_N, true);

                    events.RepeatEvent(10000 + rand()%4000);
                    break;
            }

            DoMeleeAttackIfReady();
        }
    };
};


void AddSC_boss_bjarngrim()
{
    new boss_bjarngrim();
    new npc_stormforged_lieutenant();
}

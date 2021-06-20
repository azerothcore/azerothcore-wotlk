/*
 * Originally written by Pussywizard - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "violet_hold.h"

enum eSpells
{
    SPELL_BLOODLUST                             = 54516,
    SPELL_BREAK_BONDS                           = 59463,
    SPELL_CHAIN_HEAL_N                          = 54481,
    SPELL_CHAIN_HEAL_H                          = 59473,
    SPELL_EARTH_SHIELD_N                        = 54479,
    SPELL_EARTH_SHIELD_H                        = 59471,
    //SPELL_EARTH_SHIELD_TRIGGERED_N            = 54480,
    //SPELL_EARTH_SHIELD_TRIGGERED_H            = 59472,
    SPELL_EARTH_SHOCK                           = 54511,
    SPELL_LIGHTNING_BOLT                        = 53044,
    SPELL_STORMSTRIKE                           = 51876,
};

#define SPELL_CHAIN_HEAL                        DUNGEON_MODE(SPELL_CHAIN_HEAL_N, SPELL_CHAIN_HEAL_H)
#define SPELL_EARTH_SHIELD                      DUNGEON_MODE(SPELL_EARTH_SHIELD_N, SPELL_EARTH_SHIELD_H)

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

class boss_erekem : public CreatureScript
{
public:
    boss_erekem() : CreatureScript("boss_erekem") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new boss_erekemAI (pCreature);
    }

    struct boss_erekemAI : public ScriptedAI
    {
        boss_erekemAI(Creature *c) : ScriptedAI(c)
        {
            pInstance = c->GetInstanceScript();
        }

        InstanceScript* pInstance;
        EventMap events;

        void Reset()
        {
            events.Reset();
        }

        void EnterCombat(Unit* who)
        {
            DoZoneInCombat();
            Talk(SAY_AGGRO);
            DoCast(me, SPELL_EARTH_SHIELD);
            events.Reset();
            events.RescheduleEvent(EVENT_SPELL_BLOODLUST, 15000);
            events.RescheduleEvent(EVENT_SPELL_BREAK_BONDS, urand(9000,14000));
            events.RescheduleEvent(EVENT_SPELL_CHAIN_HEAL, 0);
            events.RescheduleEvent(EVENT_SPELL_EARTH_SHIELD, 20000);
            events.RescheduleEvent(EVENT_SPELL_EARTH_SHOCK, urand(2000,8000));
            events.RescheduleEvent(EVENT_SPELL_LIGHTNING_BOLT, urand(5000,10000));
            if (IsHeroic())
                events.RescheduleEvent(EVENT_SPELL_STORMSTRIKE, 3000);

            if (Creature* c = pInstance->instance->GetCreature(pInstance->GetData64(DATA_EREKEM_GUARD_1_GUID)))
                if (!c->IsInCombat())
                    c->AI()->AttackStart(who);
            if (Creature* c = pInstance->instance->GetCreature(pInstance->GetData64(DATA_EREKEM_GUARD_2_GUID)))
                if (!c->IsInCombat())
                    c->AI()->AttackStart(who);
        }

        void UpdateAI(uint32 diff)
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch(events.GetEvent())
            {
                case 0:
                    break;
                case EVENT_SPELL_BLOODLUST:
                    me->CastSpell((Unit*)NULL, SPELL_BLOODLUST, false);
                    events.RepeatEvent(urand(35000,45000));
                    break;
                case EVENT_SPELL_BREAK_BONDS:
                    me->CastSpell((Unit*)NULL, SPELL_BREAK_BONDS, false);
                    events.RepeatEvent(urand(16000,22000));
                    break;
                case EVENT_SPELL_CHAIN_HEAL:
                    if (uint64 TargetGUID = GetChainHealTargetGUID())
                        if (pInstance)
                        {
                            if (Creature* target = pInstance->instance->GetCreature(TargetGUID))
                                me->CastSpell(target, SPELL_CHAIN_HEAL, false);

                            Creature *pGuard1 = pInstance->instance->GetCreature(pInstance->GetData64(DATA_EREKEM_GUARD_1_GUID));
                            Creature *pGuard2 = pInstance->instance->GetCreature(pInstance->GetData64(DATA_EREKEM_GUARD_2_GUID));
                            if ((pGuard1 && !pGuard1->IsAlive()) || (pGuard2 && !pGuard2->IsAlive()))
                            {
                                events.RepeatEvent(urand(3000,6000));
                                break;
                            }
                        }
                    events.RepeatEvent(urand(8000,11000));
                    break;
                case EVENT_SPELL_EARTH_SHIELD:
                    me->CastSpell(me, SPELL_EARTH_SHIELD, false);
                    events.RepeatEvent(20000);
                    break;
                case EVENT_SPELL_EARTH_SHOCK:
                    me->CastSpell(me->GetVictim(), SPELL_EARTH_SHOCK, false);
                    events.RepeatEvent(urand(8000,13000));
                    break;
                case EVENT_SPELL_LIGHTNING_BOLT:
                    if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 35.0f, true))
                        me->CastSpell(target, SPELL_LIGHTNING_BOLT, false);
                    events.RepeatEvent(urand(15000,25000));
                    break;
                case EVENT_SPELL_STORMSTRIKE:
                    {
                        Creature *pGuard1 = pInstance->instance->GetCreature(pInstance->GetData64(DATA_EREKEM_GUARD_1_GUID));
                        Creature *pGuard2 = pInstance->instance->GetCreature(pInstance->GetData64(DATA_EREKEM_GUARD_2_GUID));
                        if (pGuard1 && !pGuard1->IsAlive() && pGuard2 && !pGuard2->IsAlive()) // both dead
                            me->CastSpell(me->GetVictim(), SPELL_STORMSTRIKE, false);
                        events.RepeatEvent(3000);
                    }
                    break;
            }

            DoMeleeAttackIfReady();
        }

        void JustDied(Unit* /*killer*/)
        {
            Talk(SAY_DEATH);
            if (pInstance)
                pInstance->SetData(DATA_BOSS_DIED, 0);
        }

        void KilledUnit(Unit* victim)
        {
            if (victim && victim->GetGUID() == me->GetGUID())
                return;
            Talk(SAY_SLAY);
        }

        void MoveInLineOfSight(Unit* /*who*/) {}

        void EnterEvadeMode()
        {
            ScriptedAI::EnterEvadeMode();
            events.Reset();
            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
            if (pInstance)
                pInstance->SetData(DATA_FAILED, 1);
        }

        uint64 GetChainHealTargetGUID()
        {
            if (HealthBelowPct(85))
                return me->GetGUID();

            if (pInstance)
            {
                if (Creature* c = pInstance->instance->GetCreature(pInstance->GetData64(DATA_EREKEM_GUARD_1_GUID)))
                    if (c->IsAlive() && !c->HealthAbovePct(75))
                        return c->GetGUID();

                if (Creature* c = pInstance->instance->GetCreature(pInstance->GetData64(DATA_EREKEM_GUARD_2_GUID)))
                    if (c->IsAlive() && !c->HealthAbovePct(75))
                        return c->GetGUID();
            }

            return me->GetGUID();
        }
    };
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


class npc_erekem_guard : public CreatureScript
{
public:
    npc_erekem_guard() : CreatureScript("npc_erekem_guard") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new npc_erekem_guardAI (pCreature);
    }

    struct npc_erekem_guardAI : public ScriptedAI
    {
        npc_erekem_guardAI(Creature *c) : ScriptedAI(c)
        {
            pInstance = c->GetInstanceScript();
        }

        InstanceScript* pInstance;
        EventMap events;

        void Reset()
        {
            events.Reset();
        }

        void EnterCombat(Unit* who)
        {
            DoZoneInCombat();
            events.Reset();
            events.RescheduleEvent(EVENT_SPELL_GUSHING_WOUND, urand(1000,3000));
            events.RescheduleEvent(EVENT_SPELL_HOWLING_SCREECH, urand(8000, 13000));
            events.RescheduleEvent(EVENT_SPELL_STRIKE, urand(4000, 8000));

            if (Creature* c = pInstance->instance->GetCreature(pInstance->GetData64(DATA_EREKEM_GUID)))
                if (!c->IsInCombat())
                    c->AI()->AttackStart(who);
        }

        void UpdateAI(uint32 diff)
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch(events.GetEvent())
            {
                case 0:
                    break;
                case EVENT_SPELL_GUSHING_WOUND:
                    me->CastSpell(me->GetVictim(), SPELL_GUSHING_WOUND, false);
                    events.RepeatEvent(urand(7000,12000));
                    break;
                case EVENT_SPELL_HOWLING_SCREECH:
                    me->CastSpell(me->GetVictim(), SPELL_HOWLING_SCREECH, false);
                    events.RepeatEvent(urand(8000,13000));
                    break;
                case EVENT_SPELL_STRIKE:
                    me->CastSpell(me->GetVictim(), SPELL_STRIKE, false);
                    events.RepeatEvent(urand(4000,8000));
                    break;
            }

            DoMeleeAttackIfReady();
        }

        void MoveInLineOfSight(Unit* /*who*/) {}
    };
};

void AddSC_boss_erekem()
{
    new boss_erekem();
    new npc_erekem_guard();
}

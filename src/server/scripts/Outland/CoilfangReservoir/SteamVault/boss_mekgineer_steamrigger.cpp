/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "steam_vault.h"

enum MekgineerSteamrigger
{
    SAY_MECHANICS               = 0,
    SAY_AGGRO                   = 1,
    SAY_SLAY                    = 2,
    SAY_DEATH                   = 3,

    SPELL_SUPER_SHRINK_RAY      = 31485,
    SPELL_SAW_BLADE             = 31486,
    SPELL_ELECTRIFIED_NET       = 35107,
    SPELL_REPAIR_N              = 31532,
    SPELL_REPAIR_H              = 37936,

    NPC_STREAMRIGGER_MECHANIC   = 17951,

    EVENT_CHECK_HP25            = 1,
    EVENT_CHECK_HP50            = 2,
    EVENT_CHECK_HP75            = 3,
    EVENT_SPELL_SHRINK          = 4,
    EVENT_SPELL_SAW             = 5,
    EVENT_SPELL_NET             = 6
    
};

class boss_mekgineer_steamrigger : public CreatureScript
{
public:
    boss_mekgineer_steamrigger() : CreatureScript("boss_mekgineer_steamrigger") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new boss_mekgineer_steamriggerAI (creature);
    }

    struct boss_mekgineer_steamriggerAI : public ScriptedAI
    {
        boss_mekgineer_steamriggerAI(Creature* creature) : ScriptedAI(creature)
        {
            instance = creature->GetInstanceScript();
        }

        InstanceScript* instance;
        EventMap events;

        void Reset()
        {
            events.Reset();
            if (instance)
                instance->SetData(TYPE_MEKGINEER_STEAMRIGGER, NOT_STARTED);
        }

        void JustDied(Unit* /*killer*/)
        {
            Talk(SAY_DEATH);
            if (instance)
                instance->SetData(TYPE_MEKGINEER_STEAMRIGGER, DONE);
        }

        void KilledUnit(Unit* victim)
        {
            if (victim->GetTypeId() == TYPEID_PLAYER)
                Talk(SAY_SLAY);
        }

        void EnterCombat(Unit* /*who*/)
        {
            Talk(SAY_AGGRO);
            events.ScheduleEvent(EVENT_SPELL_SHRINK, 20000);
            events.ScheduleEvent(EVENT_SPELL_SAW, 15000);
            events.ScheduleEvent(EVENT_SPELL_NET, 10000);
            events.ScheduleEvent(EVENT_CHECK_HP75, 5000);
            events.ScheduleEvent(EVENT_CHECK_HP50, 5000);
            events.ScheduleEvent(EVENT_CHECK_HP25, 5000);

            if (instance)
                instance->SetData(TYPE_MEKGINEER_STEAMRIGGER, IN_PROGRESS);
        }

        void SummonMechanics()
        {
            Talk(SAY_MECHANICS);

            me->SummonCreature(NPC_STREAMRIGGER_MECHANIC, me->GetPositionX()+15.0f, me->GetPositionY()+15.0f, me->GetPositionZ(), 0.0f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 30000);
            me->SummonCreature(NPC_STREAMRIGGER_MECHANIC, me->GetPositionX()-15.0f, me->GetPositionY()+15.0f, me->GetPositionZ(), 0.0f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 30000);
            me->SummonCreature(NPC_STREAMRIGGER_MECHANIC, me->GetPositionX()-15.0f, me->GetPositionY()-15.0f, me->GetPositionZ(), 0.0f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 30000);
            if (urand(0,1))
                me->SummonCreature(NPC_STREAMRIGGER_MECHANIC, me->GetPositionX()+15.0f, me->GetPositionY()-15.0f, me->GetPositionZ(), 0.0f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 30000);
        }

        void JustSummoned(Creature* cr)
        {
            cr->GetMotionMaster()->MoveFollow(me, 0.0f, 0.0f);
        }

        void UpdateAI(uint32 diff)
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);
            switch (uint32 eventId = events.GetEvent())
            {
                case EVENT_SPELL_SHRINK:
                    me->CastSpell(me->GetVictim(), SPELL_SUPER_SHRINK_RAY, false);
                    events.RepeatEvent(20000);
                    break;
                case EVENT_SPELL_SAW:
                    if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 1))
                        me->CastSpell(target, SPELL_SAW_BLADE, false);
                    else
                        me->CastSpell(me->GetVictim(), SPELL_SAW_BLADE, false);
                    events.RepeatEvent(15000);
                    break;
                case EVENT_SPELL_NET:
                    if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0))
                        me->CastSpell(target, SPELL_ELECTRIFIED_NET, false);
                    events.RepeatEvent(10000);
                    break;
                case EVENT_CHECK_HP25:
                case EVENT_CHECK_HP50:
                case EVENT_CHECK_HP75:
                    if (me->HealthBelowPct(eventId*25))
                    {
                        SummonMechanics();
                        events.PopEvent();
                        return;
                    }
                    events.RepeatEvent(2000);
                    break;
            }

            DoMeleeAttackIfReady();
        }
    };
};

class npc_steamrigger_mechanic : public CreatureScript
{
public:
    npc_steamrigger_mechanic() : CreatureScript("npc_steamrigger_mechanic") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_steamrigger_mechanicAI (creature);
    }

    struct npc_steamrigger_mechanicAI : public ScriptedAI
    {
        npc_steamrigger_mechanicAI(Creature* creature) : ScriptedAI(creature)
        {
        }

        uint32 repairTimer;
        uint64 bossGUID;

        void Reset()
        {
            repairTimer = 0;
            bossGUID = 0;
            if (InstanceScript* instance = me->GetInstanceScript())
                bossGUID = instance->GetData64(TYPE_MEKGINEER_STEAMRIGGER);
        }

        void MoveInLineOfSight(Unit* /*who*/) {}

        void UpdateAI(uint32 diff)
        {
            repairTimer += diff;
            if (repairTimer >= 2000)
            {
                repairTimer = 0;
                if (Unit* boss = ObjectAccessor::GetUnit(*me, bossGUID))
                {
                    if (me->IsWithinDistInMap(boss, 13.0f))
                        if (!me->HasUnitState(UNIT_STATE_CASTING))
                            me->CastSpell(me, DUNGEON_MODE(SPELL_REPAIR_N, SPELL_REPAIR_H), false);
                }
                return;
            }

            if (!UpdateVictim())
                return;

            DoMeleeAttackIfReady();
        }
    };
};

void AddSC_boss_mekgineer_steamrigger()
{
    new boss_mekgineer_steamrigger();
    new npc_steamrigger_mechanic();
}

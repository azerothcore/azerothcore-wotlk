/*
 * Originally written by Pussywizard - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "PassiveAI.h"
#include "ScriptedCreature.h"
#include "ScriptMgr.h"
#include "violet_hold.h"

enum Yells
{
    SAY_AGGRO                                   = 0,
    SAY_SLAY                                    = 1,
    SAY_DEATH                                   = 2,
    SAY_SPAWN                                   = 3,
    SAY_SHIELD                                  = 4,
    SAY_WHISPER                                 = 5
};

enum eSpells
{
    SPELL_SHROUD_OF_DARKNESS_N                      = 54524,
    SPELL_SHROUD_OF_DARKNESS_H                      = 59745,
    SPELL_VOID_SHIFT_N                              = 54361,
    SPELL_VOID_SHIFT_H                              = 59743,
    SPELL_SUMMON_VOID_SENTRY                        = 54369,
    SPELL_SUMMON_VOID_SENTRY_BALL                   = 58650,

    //SPELL_ZURAMAT_ADD_2_N                         = 54342,
    //SPELL_ZURAMAT_ADD_2_H                         = 59747,
};

#define NPC_VOID_SENTRY_BALL                        29365
#define SPELL_SHROUD_OF_DARKNESS                    DUNGEON_MODE(SPELL_SHROUD_OF_DARKNESS_N, SPELL_SHROUD_OF_DARKNESS_H)
#define SPELL_VOID_SHIFT                            DUNGEON_MODE(SPELL_VOID_SHIFT_N, SPELL_VOID_SHIFT_H)

enum eEvents
{
    EVENT_SPELL_SHROUD_OF_DARKNESS = 1,
    EVENT_SPELL_VOID_SHIFT,
    EVENT_SPELL_SUMMON_VOID_SENTRY,
};

class boss_zuramat : public CreatureScript
{
public:
    boss_zuramat() : CreatureScript("boss_zuramat") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetVioletHoldAI<boss_zuramatAI>(pCreature);
    }

    struct boss_zuramatAI : public ScriptedAI
    {
        boss_zuramatAI(Creature* c) : ScriptedAI(c), summons(me)
        {
            pInstance = c->GetInstanceScript();
        }

        InstanceScript* pInstance;
        EventMap events;
        SummonList summons;

        void Reset() override
        {
            events.Reset();
            summons.DespawnAll();
        }

        void EnterCombat(Unit* /*who*/) override
        {
            Talk(SAY_AGGRO);
            DoZoneInCombat();
            events.Reset();
            events.RescheduleEvent(EVENT_SPELL_SHROUD_OF_DARKNESS, urand(5000, 7000));
            events.RescheduleEvent(EVENT_SPELL_VOID_SHIFT, urand(23000, 25000));
            events.RescheduleEvent(EVENT_SPELL_SUMMON_VOID_SENTRY, 10000);
            if (pInstance)
                pInstance->SetData(DATA_ACHIEV, 1);
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch(events.ExecuteEvent())
            {
                case 0:
                    break;
                case EVENT_SPELL_SHROUD_OF_DARKNESS:
                    me->CastSpell(me, SPELL_SHROUD_OF_DARKNESS, false);
                    Talk(SAY_SHIELD);
                    events.RepeatEvent(20000);
                    break;
                case EVENT_SPELL_VOID_SHIFT:
                    if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 60.0f, true))
                    {
                        me->CastSpell(target, SPELL_VOID_SHIFT, false);
                        me->MonsterWhisper("Gaze... into the void.", target->ToPlayer(), false);
                    }
                    events.RepeatEvent(urand(18000, 22000));
                    break;
                case EVENT_SPELL_SUMMON_VOID_SENTRY:
                    me->CastSpell((Unit*)nullptr, SPELL_SUMMON_VOID_SENTRY, false);
                    events.RepeatEvent(12000);
                    break;
            }

            DoMeleeAttackIfReady();
        }

        void JustDied(Unit* /*killer*/) override
        {
            summons.DespawnAll();
            Talk(SAY_DEATH);
            if (pInstance)
                pInstance->SetData(DATA_BOSS_DIED, 0);
        }

        void KilledUnit(Unit* victim) override
        {
            if (victim && victim->GetGUID() == me->GetGUID())
                return;

            Talk(SAY_SLAY);
        }

        void JustSummoned(Creature* pSummoned) override
        {
            if (pSummoned)
            {
                summons.Summon(pSummoned);
                pSummoned->SetPhaseMask(16, true);
                if (pInstance)
                    pInstance->SetGuidData(DATA_ADD_TRASH_MOB, pSummoned->GetGUID());
            }
        }

        void SummonedCreatureDespawn(Creature* pSummoned) override
        {
            if (pSummoned)
            {
                summons.Despawn(pSummoned);
                if (pSummoned->IsAIEnabled)
                    pSummoned->AI()->DoAction(-1337);
                if (pInstance)
                    pInstance->SetGuidData(DATA_DELETE_TRASH_MOB, pSummoned->GetGUID());
            }
        }

        void MoveInLineOfSight(Unit* /*who*/) override {}

        void EnterEvadeMode() override
        {
            ScriptedAI::EnterEvadeMode();
            events.Reset();
            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
            if (pInstance)
                pInstance->SetData(DATA_FAILED, 1);
        }
    };
};

class npc_vh_void_sentry : public CreatureScript
{
public:
    npc_vh_void_sentry() : CreatureScript("npc_vh_void_sentry") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetVioletHoldAI<npc_vh_void_sentryAI>(pCreature);
    }

    struct npc_vh_void_sentryAI : public NullCreatureAI
    {
        npc_vh_void_sentryAI(Creature* c) : NullCreatureAI(c)
        {
            pInstance = c->GetInstanceScript();
            SummonedGUID.Clear();
            checkTimer = 5000;
            //me->CastSpell(me, SPELL_SUMMON_VOID_SENTRY_BALL, true);
            if (Creature* pSummoned = me->SummonCreature(NPC_VOID_SENTRY_BALL, *me, TEMPSUMMON_TIMED_DESPAWN, 300000))
            {
                pSummoned->SetPhaseMask(1, true);
                SummonedGUID = pSummoned->GetGUID();
                pInstance->SetGuidData(DATA_ADD_TRASH_MOB, pSummoned->GetGUID());
            }
        }

        InstanceScript* pInstance;
        ObjectGuid SummonedGUID;
        uint16 checkTimer;

        void DoAction(int32 a) override
        {
            if (a == -1337)
                if (Creature* c = pInstance->instance->GetCreature(SummonedGUID))
                    c->DespawnOrUnsummon();
        }

        void JustDied(Unit* /*killer*/) override
        {
            if (pInstance)
            {
                pInstance->SetData(DATA_ACHIEV, 0);
                if (Creature* c = pInstance->instance->GetCreature(SummonedGUID))
                    c->DespawnOrUnsummon();
            }
            me->DespawnOrUnsummon(5000);
        }

        void SummonedCreatureDespawn(Creature* pSummoned) override
        {
            if (pSummoned)
                pInstance->SetGuidData(DATA_DELETE_TRASH_MOB, pSummoned->GetGUID());
        }

        void UpdateAI(uint32 diff) override
        {
            if (checkTimer <= diff)
            {
                checkTimer = 5000;
                bool good = false;
                if (me->IsSummon())
                    if (Unit* s = me->ToTempSummon()->GetSummoner())
                        if (s->IsAlive())
                            good = true;
                if (!good)
                    Unit::Kill(me, me);
            }
            else
                checkTimer -= diff;
        }
    };
};

void AddSC_boss_zuramat()
{
    new boss_zuramat();
    new npc_vh_void_sentry();
}

/*
 * Originally written by Pussywizard - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptedCreature.h"
#include "ScriptMgr.h"
#include "utgarde_keep.h"

enum eTexts
{
    // Skarvald
    YELL_SKARVALD_AGGRO                         = 0,
    YELL_SKARVALD_DAL_DIED                      = 1,
    YELL_SKARVALD_SKA_DIEDFIRST                 = 2,
    YELL_SKARVALD_KILL                          = 3,
    YELL_SKARVALD_DAL_DIEDFIRST                 = 4,

    // Dalronn
    YELL_DALRONN_AGGRO                          = 0,
    YELL_DALRONN_SKA_DIED                       = 1,
    YELL_DALRONN_DAL_DIEDFIRST                  = 2,
    YELL_DALRONN_KILL                           = 3,
    YELL_DALRONN_SKA_DIEDFIRST                  = 4
};

enum eSpells
{
    // Skarvald
    SPELL_CHARGE                                = 43651,
    SPELL_STONE_STRIKE                          = 48583,
    SPELL_ENRAGE                                = 48193,
    SPELL_SUMMON_SKARVALD_GHOST                 = 48613,
    // Dalronn
    SPELL_SHADOW_BOLT_N                         = 43649,
    SPELL_SHADOW_BOLT_H                         = 59575,
    SPELL_DEBILITATE                            = 43650,
    SPELL_SUMMON_SKELETONS                      = 52611,
    SPELL_SUMMON_DALRONN_GHOST                  = 48612
};

enum eEvents
{
    // Skarvald
    EVENT_SHARVALD_CHARGE                       = 1,
    EVENT_STONE_STRIKE,
    EVENT_ENRAGE,
    // Dalronn
    EVENT_SHADOW_BOLT,
    EVENT_DEBILITATE,
    EVENT_SUMMON_SKELETONS,

    EVENT_YELL_DALRONN_AGGRO,
    EVENT_MATE_DIED
};

class boss_skarvald_the_constructor : public CreatureScript
{
public:
    boss_skarvald_the_constructor() : CreatureScript("boss_skarvald_the_constructor") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetUtgardeKeepAI<boss_skarvald_the_constructorAI>(pCreature);
    }

    struct boss_skarvald_the_constructorAI : public ScriptedAI
    {
        boss_skarvald_the_constructorAI(Creature* c) : ScriptedAI(c)
        {
            pInstance = c->GetInstanceScript();
        }

        InstanceScript* pInstance;
        EventMap events;

        void Reset() override
        {
            me->SetLootMode(0);
            events.Reset();
            if (me->GetEntry() == NPC_SKARVALD)
            {
                if (pInstance)
                {
                    pInstance->SetData(DATA_DALRONN_AND_SKARVALD, NOT_STARTED);
                }
            }
            else // NPC_SKARVALD_GHOST
            {
                if (Unit* target = me->SelectNearestTarget(50.0f))
                {
                    me->AddThreat(target, 0.0f);
                    AttackStart(target);
                }
            }
        }

        void DoAction(int32 param) override
        {
            switch (param)
            {
                case 1:
                    events.RescheduleEvent(EVENT_MATE_DIED, 3500);
                    break;
            }
        }

        void EnterCombat(Unit* who) override
        {
            events.Reset();
            events.RescheduleEvent(EVENT_SHARVALD_CHARGE, 5000);
            events.RescheduleEvent(EVENT_STONE_STRIKE, 10000);
            if (me->GetEntry() == NPC_SKARVALD)
            {
                Talk(YELL_SKARVALD_AGGRO);
                if (IsHeroic())
                {
                    events.ScheduleEvent(EVENT_ENRAGE, 1000);
                }
            }
            if (pInstance)
            {
                pInstance->SetData(DATA_DALRONN_AND_SKARVALD, IN_PROGRESS);
                if (Creature* dalronn = pInstance->instance->GetCreature(pInstance->GetGuidData(DATA_DALRONN)))
                {
                    if (!dalronn->IsInCombat() && who)
                    {
                        dalronn->AddThreat(who, 0.0f);
                        dalronn->AI()->AttackStart(who);
                    }
                }
            }
        }

        void KilledUnit(Unit* /*victim*/) override
        {
            if (me->GetEntry() == NPC_SKARVALD)
            {
                Talk(YELL_SKARVALD_KILL);
            }
        }

        void JustDied(Unit*  /*Killer*/) override
        {
            if (me->GetEntry() != NPC_SKARVALD)
                return;

            if (pInstance)
            {
                if (Creature* dalronn = pInstance->instance->GetCreature(pInstance->GetGuidData(DATA_DALRONN)))
                {
                    if (dalronn->isDead())
                    {
                        Talk(YELL_SKARVALD_SKA_DIEDFIRST);
                        pInstance->SetData(DATA_DALRONN_AND_SKARVALD, DONE);
                        pInstance->SetData(DATA_UNLOCK_SKARVALD_LOOT, 0);
                        return;
                    }
                    else
                    {
                        Talk(YELL_SKARVALD_DAL_DIED);
                        dalronn->AI()->DoAction(1);
                    }
                }
            }
            me->CastSpell((Unit*)nullptr, SPELL_SUMMON_SKARVALD_GHOST, true);
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
                case 0:
                    break;
                case EVENT_MATE_DIED:
                    Talk(YELL_SKARVALD_DAL_DIEDFIRST);
                    break;
                case EVENT_SHARVALD_CHARGE:
                    if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, (IsHeroic() ? 100.0f : 30.0f), true))
                    {
                        ScriptedAI::DoResetThreat();
                        me->AddThreat(target, 10000.0f);
                        me->CastSpell(target, SPELL_CHARGE, false);
                    }
                    events.RepeatEvent(urand(5000, 10000));
                    break;
                case EVENT_STONE_STRIKE:
                    if (me->GetVictim() && me->IsWithinMeleeRange(me->GetVictim()))
                    {
                        me->CastSpell(me->GetVictim(), SPELL_STONE_STRIKE, false);
                        events.RepeatEvent(urand(5000, 10000));
                    }
                    else
                    {
                        events.RepeatEvent(3000);
                    }
                    break;
                case EVENT_ENRAGE:
                    if (me->GetHealthPct() <= 60)
                    {
                        me->CastSpell(me, SPELL_ENRAGE, true);
                        break;
                    }
                    events.RepeatEvent(1000);
                    break;
            }
            DoMeleeAttackIfReady();
        }
    };
};

class boss_dalronn_the_controller : public CreatureScript
{
public:
    boss_dalronn_the_controller() : CreatureScript("boss_dalronn_the_controller") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetUtgardeKeepAI<boss_dalronn_the_controllerAI>(pCreature);
    }

    struct boss_dalronn_the_controllerAI : public ScriptedAI
    {
        boss_dalronn_the_controllerAI(Creature* c) : ScriptedAI(c), summons(me)
        {
            pInstance = c->GetInstanceScript();
        }

        InstanceScript* pInstance;
        EventMap events;
        SummonList summons;

        void Reset() override
        {
            me->SetLootMode(0);
            events.Reset();
            summons.DespawnAll();
            if (me->GetEntry() == NPC_DALRONN)
            {
                if (pInstance)
                {
                    pInstance->SetData(DATA_DALRONN_AND_SKARVALD, NOT_STARTED);
                }
            }
            else // NPC_DALRONN_GHOST
            {
                if (Unit* target = me->SelectNearestTarget(50.0f))
                {
                    me->AddThreat(target, 0.0f);
                    AttackStart(target);
                }
            }
        }

        void DoAction(int32 param) override
        {
            switch (param)
            {
                case -1:
                    summons.DespawnAll();
                    break;
                case 1:
                    events.RescheduleEvent(EVENT_MATE_DIED, 3500);
                    break;
            }
        }

        void EnterCombat(Unit* who) override
        {
            events.Reset();
            events.RescheduleEvent(EVENT_SHADOW_BOLT, 1000);
            events.RescheduleEvent(EVENT_DEBILITATE, 5000);
            if (IsHeroic())
            {
                events.RescheduleEvent(EVENT_SUMMON_SKELETONS, 10000);
            }
            if (me->GetEntry() == NPC_DALRONN)
            {
                events.RescheduleEvent(EVENT_YELL_DALRONN_AGGRO, 4999);
            }
            if (pInstance)
            {
                pInstance->SetData(DATA_DALRONN_AND_SKARVALD, IN_PROGRESS);
                if (Creature* skarvald = pInstance->instance->GetCreature(pInstance->GetGuidData(DATA_SKARVALD)))
                {
                    if (!skarvald->IsInCombat() && who)
                    {
                        skarvald->AddThreat(who, 0.0f);
                        skarvald->AI()->AttackStart(who);
                    }
                }
            }
        }

        void KilledUnit(Unit* /*victim*/) override
        {
            if (me->GetEntry() == NPC_DALRONN)
            {
                Talk(YELL_DALRONN_KILL);
            }
        }

        void JustSummoned(Creature* minions) override
        {
            summons.Summon(minions);
            minions->SetInCombatWithZone();
        }

        void JustDied(Unit*  /*Killer*/) override
        {
            if (me->GetEntry() != NPC_DALRONN)
                return;

            if (pInstance)
            {
                if (Creature* skarvald = pInstance->instance->GetCreature(pInstance->GetGuidData(DATA_SKARVALD)))
                {
                    if (skarvald->isDead())
                    {
                        Talk(YELL_DALRONN_DAL_DIEDFIRST);
                        pInstance->SetData(DATA_DALRONN_AND_SKARVALD, DONE);
                        pInstance->SetData(DATA_UNLOCK_DALRONN_LOOT, 0);
                        return;
                    }
                    else
                    {
                        Talk(YELL_DALRONN_SKA_DIED);
                        skarvald->AI()->DoAction(1);
                    }
                }
            }
            me->CastSpell((Unit*)nullptr, SPELL_SUMMON_DALRONN_GHOST, true);
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
                case 0:
                    break;
                case EVENT_YELL_DALRONN_AGGRO:
                    Talk(YELL_DALRONN_AGGRO);
                    break;
                case EVENT_MATE_DIED:
                    Talk(YELL_DALRONN_SKA_DIEDFIRST);
                    break;
                case EVENT_SHADOW_BOLT:
                    if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 40.0f, true))
                    {
                        me->CastSpell(target, DUNGEON_MODE(SPELL_SHADOW_BOLT_N, SPELL_SHADOW_BOLT_H), false);
                    }
                    events.RepeatEvent(2050);
                    break;
                case EVENT_DEBILITATE:
                    if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 45.0f, true))
                    {
                        me->CastSpell(target, SPELL_DEBILITATE, false);
                        events.RepeatEvent(urand(5000, 10000));
                    }
                    else
                    {
                        events.RepeatEvent(3000);
                    }
                    break;
                case EVENT_SUMMON_SKELETONS:
                    me->CastSpell((Unit*)nullptr, SPELL_SUMMON_SKELETONS, false);
                    events.RepeatEvent(urand(20000, 30000));
                    break;
            }
            DoMeleeAttackIfReady();
        }
    };
};

void AddSC_boss_skarvald_dalronn()
{
    new boss_skarvald_the_constructor();
    new boss_dalronn_the_controller();
}

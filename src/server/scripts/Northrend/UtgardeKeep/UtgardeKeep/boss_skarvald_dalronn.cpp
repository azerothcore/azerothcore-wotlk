/*
 * Originally written by Pussywizard - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "utgarde_keep.h"

enum eTexts
{
    //signed for 24200, but used by 24200, 27390
    YELL_SKARVALD_AGGRO                         = 0,
    YELL_SKARVALD_DAL_DIED                      = 1,
    YELL_SKARVALD_SKA_DIEDFIRST                 = 2,
    YELL_SKARVALD_KILL                          = 3,
    YELL_SKARVALD_DAL_DIEDFIRST                 = 4,

    //signed for 24201, but used by 24201, 27389
    YELL_DALRONN_AGGRO                          = 0,
    YELL_DALRONN_SKA_DIED                       = 1,
    YELL_DALRONN_DAL_DIEDFIRST                  = 2,
    YELL_DALRONN_KILL                           = 3,
    YELL_DALRONN_SKA_DIEDFIRST                  = 4,
};

enum eSpells
{
    // Skarvald:
    SPELL_CHARGE                                = 43651,
    SPELL_STONE_STRIKE                          = 48583,
    SPELL_SUMMON_SKARVALD_GHOST                 = 48613,

    // Dalronn:
    SPELL_SHADOW_BOLT_N                         = 43649,
    SPELL_SHADOW_BOLT_H                         = 59575,
    SPELL_DEBILITATE                            = 43650,
    SPELL_SUMMON_SKELETONS                      = 52611,
    SPELL_SUMMON_DALRONN_GHOST                  = 48612,
};

#define SPELL_SHADOW_BOLT               DUNGEON_MODE(SPELL_SHADOW_BOLT_N, SPELL_SHADOW_BOLT_H)

enum eEvents
{
    EVENT_SPELL_CHARGE = 1,
    EVENT_SPELL_STONE_STRIKE,

    EVENT_SPELL_SHADOW_BOLT,
    EVENT_SPELL_DEBILITATE,
    EVENT_SPELL_SUMMON_SKELETONS,

    EVENT_YELL_DALRONN_AGGRO,
    EVENT_MATE_DIED,
};

class boss_skarvald_the_constructor : public CreatureScript
{
public:
    boss_skarvald_the_constructor() : CreatureScript("boss_skarvald_the_constructor") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new boss_skarvald_the_constructorAI (pCreature);
    }

    struct boss_skarvald_the_constructorAI : public ScriptedAI
    {
        boss_skarvald_the_constructorAI(Creature *c) : ScriptedAI(c)
        {
            pInstance = c->GetInstanceScript();
        }

        InstanceScript* pInstance;
        EventMap events;

        void Reset()
        {
            me->SetLootMode(0);
            events.Reset();
            if( me->GetEntry() == NPC_SKARVALD )
            {
                if (pInstance)
                    pInstance->SetData(DATA_DALRONN_AND_SKARVALD, NOT_STARTED);
            }
            else // NPC_SKARVALD_GHOST
                if( Unit* target = me->SelectNearestTarget(50.0f) )
                {
                    me->AddThreat(target, 0.0f);
                    AttackStart(target);
                }
        }

        void DoAction(int32 param)
        {
            switch(param)
            {
                case 1:
                    events.RescheduleEvent(EVENT_MATE_DIED, 3500);
                    break;
            }
        }

        void EnterCombat(Unit * who)
        {
            events.Reset();
            events.RescheduleEvent(EVENT_SPELL_CHARGE, 5000);
            events.RescheduleEvent(EVENT_SPELL_STONE_STRIKE, 10000);

            if (me->GetEntry() == NPC_SKARVALD)
                Talk(YELL_SKARVALD_AGGRO);

            if (pInstance)
            {
                pInstance->SetData(DATA_DALRONN_AND_SKARVALD, IN_PROGRESS);
                if( Creature* c = pInstance->instance->GetCreature(pInstance->GetData64(DATA_DALRONN)) )
                    if( !c->IsInCombat() && who )
                    {
                        c->AddThreat(who, 0.0f);
                        c->AI()->AttackStart(who);
                    }
            }
        }

        void KilledUnit(Unit * /*victim*/)
        {
            if (me->GetEntry() == NPC_SKARVALD)
                Talk(YELL_SKARVALD_KILL);
        }

        void JustDied(Unit*  /*Killer*/)
        {
            if( me->GetEntry() != NPC_SKARVALD )
                return;
            if( pInstance ) {
                if( Creature* dalronn = pInstance->instance->GetCreature(pInstance->GetData64(DATA_DALRONN)) ) {
                    if( dalronn->isDead() )
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

            me->CastSpell((Unit*)NULL, SPELL_SUMMON_SKARVALD_GHOST, true);
        }

        void UpdateAI(uint32 diff)
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);
            
            if( me->HasUnitState(UNIT_STATE_CASTING) )
                return;

            switch( events.GetEvent() )
            {
                case 0:
                    break;
                case EVENT_MATE_DIED:
                    Talk(YELL_SKARVALD_DAL_DIEDFIRST);
                    events.PopEvent();
                    break;
                case EVENT_SPELL_CHARGE:
                    if( Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, (IsHeroic() ? 100.0f : 30.0f), true) )
                    {
                        ScriptedAI::DoResetThreat();
                        me->AddThreat(target, 10000.0f);
                        me->CastSpell(target, SPELL_CHARGE, false);
                    }
                    events.RepeatEvent(urand(5000,10000));
                    break;
                case EVENT_SPELL_STONE_STRIKE:
                    if( me->GetVictim() && me->IsWithinMeleeRange(me->GetVictim()) )
                    {
                        me->CastSpell(me->GetVictim(), SPELL_STONE_STRIKE, false);
                        events.RepeatEvent(urand(5000,10000));
                    }
                    else
                        events.RepeatEvent(3000);
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

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new boss_dalronn_the_controllerAI (pCreature);
    }

    struct boss_dalronn_the_controllerAI : public ScriptedAI
    {
        boss_dalronn_the_controllerAI(Creature *c) : ScriptedAI(c), summons(me)
        {
            pInstance = c->GetInstanceScript();
        }

        InstanceScript* pInstance;
        EventMap events;
        SummonList summons;

        void Reset()
        {
            me->SetLootMode(0);
            events.Reset();
            summons.DespawnAll();
            if( me->GetEntry() == NPC_DALRONN )
            {
                if (pInstance)
                    pInstance->SetData(DATA_DALRONN_AND_SKARVALD, NOT_STARTED);
            }
            else // NPC_DALRONN_GHOST
                if( Unit* target = me->SelectNearestTarget(50.0f) )
                {
                    me->AddThreat(target, 0.0f);
                    AttackStart(target);
                }
        }

        void DoAction(int32 param)
        {
            switch(param)
            {
                case -1:
                    summons.DespawnAll();
                    break;
                case 1:
                    events.RescheduleEvent(EVENT_MATE_DIED, 3500);
                    break;
            }
        }

        void EnterCombat(Unit * who)
        {
            events.Reset();
            events.RescheduleEvent(EVENT_SPELL_SHADOW_BOLT, 1000);
            events.RescheduleEvent(EVENT_SPELL_DEBILITATE, 5000);
            if( IsHeroic() )
                events.RescheduleEvent(EVENT_SPELL_SUMMON_SKELETONS, 10000);

            if (me->GetEntry() == NPC_DALRONN)
                events.RescheduleEvent(EVENT_YELL_DALRONN_AGGRO, 4999);

            if (pInstance)
            {
                pInstance->SetData(DATA_DALRONN_AND_SKARVALD, IN_PROGRESS);
                if( Creature* c = pInstance->instance->GetCreature(pInstance->GetData64(DATA_SKARVALD)) )
                    if( !c->IsInCombat() && who )
                    {
                        c->AddThreat(who, 0.0f);
                        c->AI()->AttackStart(who);
                    }
            }
        }

        void KilledUnit(Unit * /*victim*/)
        {
            if (me->GetEntry() == NPC_DALRONN)
                Talk(YELL_DALRONN_KILL);
        }

        void JustSummoned(Creature* s)
        {
            summons.Summon(s);
        }

        void JustDied(Unit*  /*Killer*/)
        {
            if( me->GetEntry() != NPC_DALRONN )
                return;
            if( pInstance ) {
                if( Creature* skarvald = pInstance->instance->GetCreature(pInstance->GetData64(DATA_SKARVALD)) ) {
                    if( skarvald->isDead() )
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
            me->CastSpell((Unit*)NULL, SPELL_SUMMON_DALRONN_GHOST, true);
        }

        void UpdateAI(uint32 diff)
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);
            
            if( me->HasUnitState(UNIT_STATE_CASTING) )
                return;

            switch( events.GetEvent() )
            {
                case 0:
                    break;
                case EVENT_YELL_DALRONN_AGGRO:
                    Talk(YELL_DALRONN_AGGRO);
                    events.PopEvent();
                    break;
                case EVENT_MATE_DIED:
                    Talk(YELL_DALRONN_SKA_DIEDFIRST);
                    events.PopEvent();
                    break;
                case EVENT_SPELL_SHADOW_BOLT:
                    if( Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 42.0f, true) )
                        me->CastSpell(target, SPELL_SHADOW_BOLT, false);
                    events.RepeatEvent(2500);                   
                    break;
                case EVENT_SPELL_DEBILITATE:
                    if( Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 45.0f, true) )
                    {
                        me->CastSpell(target, SPELL_DEBILITATE, false);
                        events.RepeatEvent(urand(5000,10000));
                    }
                    else
                        events.RepeatEvent(3000);
                    break;
                case EVENT_SPELL_SUMMON_SKELETONS:
                    me->CastSpell((Unit*)NULL, SPELL_SUMMON_SKELETONS, false);
                    events.RepeatEvent(urand(20000,30000));
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

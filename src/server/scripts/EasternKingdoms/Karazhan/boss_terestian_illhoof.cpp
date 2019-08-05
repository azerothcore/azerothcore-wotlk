/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "karazhan.h"
#include "PassiveAI.h"
#include "SpellInfo.h"

enum TerestianSays
{
    SAY_SLAY                  = 0,
    SAY_DEATH                 = 1,
    SAY_AGGRO                 = 2,
    SAY_SACRIFICE             = 3,
    SAY_SUMMON_PORTAL         = 4
};

enum TerestianSpells
{
    SPELL_SHADOW_BOLT         = 30055,
    SPELL_SUMMON_IMP          = 30066,
    SPELL_FIENDISH_PORTAL_1   = 30171,
    SPELL_FIENDISH_PORTAL_2   = 30179,
    SPELL_BERSERK             = 32965,
    SPELL_SUMMON_FIENDISH_IMP = 30184,
    SPELL_BROKEN_PACT         = 30065,
    SPELL_AMPLIFY_FLAMES      = 30053,
    SPELL_FIREBOLT            = 30050,
    SPELL_SUMMON_DEMONCHAINS  = 30120,
    SPELL_DEMON_CHAINS        = 30206,
    SPELL_SACRIFICE           = 30115
};

enum TerestianMisc
{
    NPC_FIENDISH_PORTAL       = 17265,
    ACTION_DESPAWN_IMPS       = 1
};

enum TerestianEvents
{
    EVENT_SACRIFICE = 1,
    EVENT_SHADOWBOLT,
    EVENT_SUMMON_PORTAL_1,
    EVENT_SUMMON_PORTAL_2,
    EVENT_SUMMON_KILREK,
    EVENT_ENRAGE
};

class boss_terestian_illhoof : public CreatureScript
{
public:
    boss_terestian_illhoof() : CreatureScript("boss_terestian_illhoof") { }

    struct boss_terestianAI : public BossAI
    {
        boss_terestianAI(Creature* creature) : BossAI(creature, DATA_TERESTIAN) { }

        void Reset()
        {
            EntryCheckPredicate pred(NPC_FIENDISH_PORTAL);
            summons.DoAction(ACTION_DESPAWN_IMPS, pred);
            _Reset();

            events.ScheduleEvent(EVENT_SHADOWBOLT, 1000);
            events.ScheduleEvent(EVENT_SUMMON_KILREK, 3000);
            events.ScheduleEvent(EVENT_SACRIFICE, 30000);
            events.ScheduleEvent(EVENT_SUMMON_PORTAL_1, 10000);
            events.ScheduleEvent(EVENT_SUMMON_PORTAL_2, 11000);
            events.ScheduleEvent(EVENT_ENRAGE, 600000);
        }

        void EnterCombat(Unit* /*who*/)
        {
            Talk(SAY_AGGRO);
        }

        void SpellHit(Unit* /*caster*/, SpellInfo const* spell)
        {
            if (spell->Id == SPELL_BROKEN_PACT)
                events.ScheduleEvent(EVENT_SUMMON_KILREK, 32000);
        }

        void KilledUnit(Unit* victim) 
        {
            if (victim->GetTypeId() == TYPEID_PLAYER)
                Talk(SAY_SLAY);
        }

        void JustDied(Unit* /*killer*/)
        {
            Talk(SAY_DEATH);
            EntryCheckPredicate pred(NPC_FIENDISH_PORTAL);
            summons.DoAction(ACTION_DESPAWN_IMPS, pred);
        }

        void ExecuteEvent(uint32 eventId)
        {
            switch (eventId)
            {
                case EVENT_SACRIFICE:
                    if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 100.0f, true))
                    {
                        DoCast(target, SPELL_SACRIFICE, true);
                        target->CastSpell(target, SPELL_SUMMON_DEMONCHAINS, true);
                        Talk(SAY_SACRIFICE);
                    }
                    events.ScheduleEvent(EVENT_SACRIFICE, 42000);
                    break;
                case EVENT_SHADOWBOLT:
                    if (Unit* target = SelectTarget(SELECT_TARGET_TOPAGGRO, 0))
                        DoCast(target, SPELL_SHADOW_BOLT);
                    events.ScheduleEvent(EVENT_SHADOWBOLT, urand(4000, 10000));
                    break;
                case EVENT_SUMMON_KILREK:
                    me->RemoveAurasDueToSpell(SPELL_BROKEN_PACT);
                    DoCastAOE(SPELL_SUMMON_IMP, true);
                    break;
                case EVENT_SUMMON_PORTAL_1:
                    Talk(SAY_SUMMON_PORTAL);
                    DoCastAOE(SPELL_FIENDISH_PORTAL_1);
                    break;
                case EVENT_SUMMON_PORTAL_2:
                    DoCastAOE(SPELL_FIENDISH_PORTAL_2, true);
                    break;
                case EVENT_ENRAGE:
                    DoCastSelf(SPELL_BERSERK, true);
                    break;
                default:
                    break;
            }
        }
    };

    CreatureAI* GetAI(Creature* creature) const 
    {
        return GetInstanceAI<boss_terestianAI>(creature);
    }
};

class npc_kilrek : public CreatureScript
{
public:
    npc_kilrek() : CreatureScript("npc_kilrek") { }

    struct npc_kilrekAI : public ScriptedAI
    {
        npc_kilrekAI(Creature* creature) : ScriptedAI(creature) { }

        void Reset() 
        {
            /* scheduler.Schedule(Seconds(8), [this](TaskContext amplify)
            {
                DoCastVictim(SPELL_AMPLIFY_FLAMES);
                amplify.Repeat(Seconds(9));
            });*/
        }

        void JustDied(Unit* /*killer*/) 
        {
            DoCastAOE(SPELL_BROKEN_PACT, true);
            me->DespawnOrUnsummon(Seconds(15));
        }

        void UpdateAI(uint32 diff) 
        {
            if (!UpdateVictim())
                return;

            /*scheduler.Update(diff, [this]
            {
                DoMeleeAttackIfReady();
            }); */
        }

    /*private:
        TaskScheduler scheduler; */
    };

    CreatureAI* GetAI(Creature* creature) const 
    {
        return GetInstanceAI<npc_kilrekAI>(creature);
    }
};

class npc_demon_chain : public CreatureScript
{
public:
    npc_demon_chain() : CreatureScript("npc_demon_chain") { }

    struct npc_demon_chainAI : public PassiveAI
    {
        npc_demon_chainAI(Creature* creature) : PassiveAI(creature) { }

        void IsSummonedBy(Unit* summoner) 
        {
            sacrificeGUID = summoner->GetGUID();
            DoCastSelf(SPELL_DEMON_CHAINS, true);
        }

        void JustDied(Unit* /*killer*/) 
        {
            if (Unit* sacrifice = ObjectAccessor::GetUnit(*me, sacrificeGUID))
                sacrifice->RemoveAurasDueToSpell(SPELL_SACRIFICE);
        }

    private:
        uint64 sacrificeGUID;
    };

    CreatureAI* GetAI(Creature* creature) const 
    {
        return GetInstanceAI<npc_demon_chainAI>(creature);
    }
};

class npc_fiendish_portal : public CreatureScript
{
public:
    npc_fiendish_portal() : CreatureScript("npc_fiendish_portal") { }

    struct npc_fiendish_portalAI : public PassiveAI
    {
        npc_fiendish_portalAI(Creature* creature) : PassiveAI(creature), _summons(me) { }

        void Reset() 
        {
            /* scheduler.Schedule(Milliseconds(2400), 8000, [this](TaskContext summonImp)
            {
                DoCastAOE(SPELL_SUMMON_FIENDISH_IMP, true);
                summonImp.Repeat();
            });*/
        }

        void DoAction(int32 action) 
        {
            if (action == ACTION_DESPAWN_IMPS)
                summons.DespawnAll();
        }

        void JustSummoned(Creature* summon) 
        {
            summons.Summon(summon);
            DoZoneInCombat(summon);
        }

        void UpdateAI(uint32 diff) 
        {
            /*scheduler.Update(diff);*/
        }

    /* private:
        SummonList _summons;
        TaskScheduler scheduler;*/
    };

    CreatureAI* GetAI(Creature* creature) const 
    {
        return GetInstanceAI<npc_fiendish_portalAI>(creature);
    }
};

class npc_fiendish_imp : public CreatureScript
{
public:
    npc_fiendish_imp() : CreatureScript("npc_fiendish_imp") { }

    struct npc_fiendish_impAI : public ScriptedAI
    {
        npc_fiendish_impAI(Creature* creature) : ScriptedAI(creature) { }

        void Reset() 
        {
            /*scheduler.Schedule(Seconds(2), [this](TaskContext firebolt)
            {
                DoCastVictim(SPELL_FIREBOLT);
                firebolt.Repeat(Milliseconds(2400));
            });*/

            me->ApplySpellImmune(0, IMMUNITY_SCHOOL, SPELL_SCHOOL_MASK_FIRE, true);
        }

        void UpdateAI(uint32 diff) 
        {
            if (!UpdateVictim())
                return;

            /* scheduler.Update(diff, [this]
            {
                DoMeleeAttackIfReady();
            });*/
        }

    /* private:
        TaskScheduler scheduler;*/
    };

    CreatureAI* GetAI(Creature* creature) const 
    {
        return GetInstanceAI<npc_fiendish_impAI>(creature);
    }
};

void AddSC_boss_terestian_illhoof()
{
    new boss_terestian_illhoof();
    new npc_kilrek();
    new npc_demon_chain();
    new npc_fiendish_portal();
    new npc_fiendish_imp();
}

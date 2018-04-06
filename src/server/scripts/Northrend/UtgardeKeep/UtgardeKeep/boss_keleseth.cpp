/*
 * Originally written by Pussywizard - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "utgarde_keep.h"
#include "SpellAuraEffects.h"
#include "SpellScript.h"
#include "PassiveAI.h"

enum eTexts
{
    SAY_START_COMBAT                    = 1,
    SAY_FROST_TOMB                      = 3,
    SAY_SUMMON_SKELETONS                = 2,
    SAY_FROST_TOMB_EMOTE                = 4,
    SAY_DEATH                           = 5,
};

enum eNPCs
{
    NPC_FROST_TOMB                      = 23965,
    NPC_SKELETON                        = 23970,
};

enum eSpells
{
    SPELL_FROST_TOMB                    = 42672,
    SPELL_FROST_TOMB_SUMMON             = 42714,
    SPELL_FROST_TOMB_AURA               = 48400,

    SPELL_SHADOWBOLT_N                  = 43667,
    SPELL_SHADOWBOLT_H                  = 59389,
};

#define SPELL_SHADOWBOLT                DUNGEON_MODE(SPELL_SHADOWBOLT_N, SPELL_SHADOWBOLT_H)

enum eEvents
{
    EVENT_SPELL_SHADOWBOLT = 1,
    EVENT_FROST_TOMB,
    EVENT_SUMMON_SKELETONS,
};

class npc_frost_tomb : public CreatureScript
{
public:
    npc_frost_tomb() : CreatureScript("npc_frost_tomb") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new npc_frost_tombAI(pCreature);
    }

    struct npc_frost_tombAI : public NullCreatureAI
    {
        npc_frost_tombAI(Creature *c) : NullCreatureAI(c), PrisonerGUID(0)
        {
            if (TempSummon* t = c->ToTempSummon())
                if (Unit* s = t->GetSummoner())
                {
                    PrisonerGUID = s->GetGUID();
                    if( me->GetInstanceScript() && me->GetInstanceScript()->instance->IsHeroic() )
                    {
                        const int32 dmg = 2000;
                        c->CastCustomSpell(s, SPELL_FROST_TOMB_AURA, NULL, &dmg, NULL, true);
                    }
                    else
                        c->CastSpell(s, SPELL_FROST_TOMB_AURA, true);
                }
        }
        uint64 PrisonerGUID;

        void JustDied(Unit* killer)
        {
            if (killer->GetGUID() != me->GetGUID())
                if (InstanceScript* pInstance = me->GetInstanceScript())
                    pInstance->SetData(DATA_ON_THE_ROCKS_ACHIEV, 0);

            if (PrisonerGUID)
                if (Unit* p = ObjectAccessor::GetUnit(*me, PrisonerGUID))
                    p->RemoveAurasDueToSpell(SPELL_FROST_TOMB_AURA);
            me->DespawnOrUnsummon(5000);
        }

        void UpdateAI(uint32  /*diff*/)
        {
            if (PrisonerGUID)
            {
                if (Unit* p = ObjectAccessor::GetUnit(*me, PrisonerGUID))
                {
                    if( !p->HasAura(SPELL_FROST_TOMB_AURA) )
                        Unit::Kill(me, me);
                }
                else
                    Unit::Kill(me, me);
            }
        }
    };

};

class boss_keleseth : public CreatureScript
{
public:
    boss_keleseth() : CreatureScript("boss_keleseth") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new boss_kelesethAI (pCreature);
    }

    struct boss_kelesethAI : public ScriptedAI
    {
        boss_kelesethAI(Creature *c) : ScriptedAI(c)
        {
            pInstance = c->GetInstanceScript();
        }

        InstanceScript* pInstance;
        EventMap events;

        void Reset()
        {
            events.Reset();
            if (pInstance)
                pInstance->SetData(DATA_KELESETH, NOT_STARTED);
        }

        void MoveInLineOfSight(Unit* /*who*/) {}

        /*void KilledUnit(Unit * victim)
        {
            if (victim == me)
                return;
            DoScriptText(SAY_KILL, me);
        }*/

        void JustDied(Unit* /*killer*/)
        {
            Talk(SAY_DEATH);
            if (pInstance)
                pInstance->SetData(DATA_KELESETH, DONE);
        }

        void EnterCombat(Unit* /*who*/)
        {
            events.Reset();
            events.RescheduleEvent(EVENT_SPELL_SHADOWBOLT, 0);
            events.RescheduleEvent(EVENT_FROST_TOMB, 28000);
            events.RescheduleEvent(EVENT_SUMMON_SKELETONS, 4000);

            Talk(SAY_START_COMBAT);
            DoZoneInCombat();

            if (pInstance)
                pInstance->SetData(DATA_KELESETH, IN_PROGRESS);
        }

        void AttackStart(Unit* who)
        {
            if( !who )
                return;

            UnitAI::AttackStartCaster(who, 12.0f);
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
                case EVENT_SPELL_SHADOWBOLT:
                    me->CastSpell(me->GetVictim(), SPELL_SHADOWBOLT, false);
                    events.RepeatEvent(urand(4000,5000));
                    break;
                case EVENT_FROST_TOMB:
                    if( Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 0.0f, true) )
                        if( !target->HasAura(SPELL_FROST_TOMB_AURA) )
                        {
                            Talk(SAY_FROST_TOMB_EMOTE, target);
                            Talk(SAY_FROST_TOMB);
                            me->CastSpell(target, SPELL_FROST_TOMB, false);
                            events.RepeatEvent(15000);
                            break;
                        }
                    events.RepeatEvent(1000);
                    break;
                case EVENT_SUMMON_SKELETONS:
                    Talk(SAY_SUMMON_SKELETONS);
                    for (uint8 i = 0; i < 5; ++i)
                    {
                        float dist = rand_norm()*4+3.0f;
                        float angle = rand_norm()*2*M_PI;
                        if( Creature* c = me->SummonCreature(NPC_SKELETON, 156.2f+cos(angle)*dist, 259.1f+sin(angle)*dist, 42.9f, 0, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 20000) )
                            if( Unit* target = c->SelectNearestTarget(250.0f) )
                            {
                                c->AddThreat(target, 5.0f);
                                DoZoneInCombat(c);
                            }
                    }
                    events.PopEvent();
                    break;
            }

            DoMeleeAttackIfReady();
        }
    };

};

enum eSkeletonEnum
{
    SPELL_DECREPIFY                     = 42702,
    SPELL_BONE_ARMOR                    = 59386,
    SPELL_SCOURGE_RESURRECTION          = 42704,

    EVENT_SPELL_DECREPIFY = 1,
    EVENT_SPELL_BONE_ARMOR,
    EVENT_RESURRECT,
    EVENT_RESURRECT_2,
};

class npc_vrykul_skeleton : public CreatureScript
{
public:
    npc_vrykul_skeleton() : CreatureScript("npc_vrykul_skeleton") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new npc_vrykul_skeletonAI (pCreature);
    }

    struct npc_vrykul_skeletonAI : public ScriptedAI
    {
        npc_vrykul_skeletonAI(Creature *c) : ScriptedAI(c)
        {
            pInstance = c->GetInstanceScript();
        }

        InstanceScript *pInstance;
        EventMap events;

        void Reset()
        {
            events.Reset();
            events.RescheduleEvent(EVENT_SPELL_DECREPIFY, urand(10000,20000));
            if( IsHeroic() )
                events.RescheduleEvent(EVENT_SPELL_BONE_ARMOR, urand(25000,120000));
        }

        void DamageTaken(Unit*, uint32 &damage, DamageEffectType, SpellSchoolMask)
        {
            if (damage >= me->GetHealth())
            {
                damage = 0;
                me->InterruptNonMeleeSpells(true);
                me->RemoveAllAuras();
                me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                me->SetControlled(true, UNIT_STATE_ROOT);
                me->GetMotionMaster()->MovementExpired();
                me->GetMotionMaster()->MoveIdle();
                me->StopMoving();
                me->SetStandState(UNIT_STAND_STATE_DEAD);
                me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_UNK_29);
                me->SetFlag(UNIT_FIELD_FLAGS_2, UNIT_FLAG2_FEIGN_DEATH);
                me->SetFlag(UNIT_DYNAMIC_FLAGS, UNIT_DYNFLAG_DEAD);
                events.RescheduleEvent(EVENT_RESURRECT, 12000);
            }
        }

        void UpdateAI(uint32 diff)
        {
            if( pInstance && pInstance->GetData(DATA_KELESETH) != IN_PROGRESS )
            {
                if( me->IsAlive() )
                    Unit::Kill(me, me);
                return;
            }

            if (!UpdateVictim())
                return;

            events.Update(diff);

            if( me->HasUnitState(UNIT_STATE_CASTING) )
                return;

            switch( events.GetEvent() )
            {
                case 0:
                    break;
                case EVENT_SPELL_DECREPIFY:
                    if( !me->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE) )
                        me->CastSpell(me->GetVictim(), SPELL_DECREPIFY, false);
                    events.RepeatEvent(urand(15000,25000));
                    break;
                case EVENT_SPELL_BONE_ARMOR:
                    if( !me->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE) )
                        me->CastSpell((Unit*)NULL, SPELL_BONE_ARMOR, false);
                    events.RepeatEvent(urand(40000,120000));
                    break;
                case EVENT_RESURRECT:
                    events.PopEvent();
                    events.DelayEvents(3500);
                    DoCast(me, SPELL_SCOURGE_RESURRECTION, true);
                    me->SetStandState(UNIT_STAND_STATE_STAND);
                    me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_UNK_29);
                    me->RemoveFlag(UNIT_FIELD_FLAGS_2, UNIT_FLAG2_FEIGN_DEATH);
                    me->RemoveFlag(UNIT_DYNAMIC_FLAGS, UNIT_DYNFLAG_DEAD);
                    events.RescheduleEvent(EVENT_RESURRECT_2, 3000);
                    break;
                case EVENT_RESURRECT_2:
                    me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                    me->SetControlled(false, UNIT_STATE_ROOT);
                    me->GetMotionMaster()->MoveChase(me->GetVictim());
                    events.PopEvent();
                    break;
            }

            if( !me->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE) )
                DoMeleeAttackIfReady();
        }
    };

};

class spell_frost_tomb : public SpellScriptLoader
{
    public:
        spell_frost_tomb() : SpellScriptLoader("spell_frost_tomb") { }

        class spell_frost_tombAuraScript : public AuraScript
        {
            PrepareAuraScript(spell_frost_tombAuraScript);

            void HandleEffectPeriodic(AuraEffect const* aurEff)
            {
                PreventDefaultAction();
                if (aurEff->GetTickNumber()==1)
                    if( Unit* target = GetTarget() )
                        target->CastSpell((Unit*)NULL, SPELL_FROST_TOMB_SUMMON, true);
            }

            void Register()
            {
                OnEffectPeriodic += AuraEffectPeriodicFn(spell_frost_tombAuraScript::HandleEffectPeriodic, EFFECT_1, SPELL_AURA_PERIODIC_DUMMY);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_frost_tombAuraScript();
        }
};

void AddSC_boss_keleseth()
{
    new boss_keleseth();
    new npc_frost_tomb();
    new npc_vrykul_skeleton();
    new spell_frost_tomb();
}

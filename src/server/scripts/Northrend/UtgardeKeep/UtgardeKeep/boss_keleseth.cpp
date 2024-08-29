/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU Affero General Public License as published by the
 * Free Software Foundation; either version 3 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "CreatureScript.h"
#include "PassiveAI.h"
#include "ScriptedCreature.h"
#include "SpellAuraEffects.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "utgarde_keep.h"

enum eTexts
{
    SAY_START_COMBAT                    = 1,
    SAY_FROST_TOMB                      = 3,
    SAY_SUMMON_SKELETONS                = 2,
    SAY_FROST_TOMB_EMOTE                = 4,
    SAY_DEATH                           = 5,
    SAY_KILL                            = 6,
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

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetUtgardeKeepAI<npc_frost_tombAI>(pCreature);
    }

    struct npc_frost_tombAI : public NullCreatureAI
    {
        npc_frost_tombAI(Creature* c) : NullCreatureAI(c)
        {
            if (TempSummon* t = c->ToTempSummon())
                if (Unit* s = t->GetSummonerUnit())
                {
                    PrisonerGUID = s->GetGUID();
                    if( me->GetInstanceScript() && me->GetInstanceScript()->instance->IsHeroic() )
                    {
                        const int32 dmg = 2000;
                        c->CastCustomSpell(s, SPELL_FROST_TOMB_AURA, nullptr, &dmg, nullptr, true);
                    }
                    else
                        c->CastSpell(s, SPELL_FROST_TOMB_AURA, true);
                }
        }
        ObjectGuid PrisonerGUID;

        void JustDied(Unit* killer) override
        {
            if (killer && killer->GetGUID() != me->GetGUID())
                if (InstanceScript* pInstance = me->GetInstanceScript())
                    pInstance->SetData(DATA_ON_THE_ROCKS_ACHIEV, 0);

            if (PrisonerGUID)
                if (Unit* p = ObjectAccessor::GetUnit(*me, PrisonerGUID))
                    p->RemoveAurasDueToSpell(SPELL_FROST_TOMB_AURA);
            me->DespawnOrUnsummon(5000);
        }

        void UpdateAI(uint32  /*diff*/) override
        {
            if (PrisonerGUID)
            {
                if (Unit* p = ObjectAccessor::GetUnit(*me, PrisonerGUID))
                {
                    if( !p->HasAura(SPELL_FROST_TOMB_AURA) )
                        me->KillSelf();
                }
                else
                    me->KillSelf();
            }
        }
    };
};

class boss_keleseth : public CreatureScript
{
public:
    boss_keleseth() : CreatureScript("boss_keleseth") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetUtgardeKeepAI<boss_kelesethAI>(pCreature);
    }

    struct boss_kelesethAI : public ScriptedAI
    {
        boss_kelesethAI(Creature* c) : ScriptedAI(c)
        {
            pInstance = c->GetInstanceScript();
        }

        InstanceScript* pInstance;
        EventMap events;

        void Reset() override
        {
            events.Reset();
            if (pInstance)
                pInstance->SetData(DATA_KELESETH, NOT_STARTED);
        }

        void KilledUnit(Unit* victim) override
        {
            if (victim->IsPlayer())
            {
                Talk(SAY_KILL);
            }
        }

        void JustDied(Unit* /*killer*/) override
        {
            Talk(SAY_DEATH);
            if (pInstance)
                pInstance->SetData(DATA_KELESETH, DONE);
        }

        void JustEngagedWith(Unit* /*who*/) override
        {
            events.Reset();
            events.RescheduleEvent(EVENT_SPELL_SHADOWBOLT, 0ms);
            events.RescheduleEvent(EVENT_FROST_TOMB, 28s);
            events.RescheduleEvent(EVENT_SUMMON_SKELETONS, 4s);

            Talk(SAY_START_COMBAT);
            DoZoneInCombat();

            if (pInstance)
                pInstance->SetData(DATA_KELESETH, IN_PROGRESS);
        }

        void AttackStart(Unit* who) override
        {
            if( !who )
                return;

            UnitAI::AttackStartCaster(who, 12.0f);
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);

            if( me->HasUnitState(UNIT_STATE_CASTING) )
                return;

            switch( events.ExecuteEvent() )
            {
                case 0:
                    break;
                case EVENT_SPELL_SHADOWBOLT:
                    me->CastSpell(me->GetVictim(), SPELL_SHADOWBOLT, false);
                    events.Repeat(4s, 5s);
                    break;
                case EVENT_FROST_TOMB:
                    if( Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 0.0f, true, true) )
                        if( !target->HasAura(SPELL_FROST_TOMB_AURA) )
                        {
                            Talk(SAY_FROST_TOMB_EMOTE, target);
                            Talk(SAY_FROST_TOMB);
                            me->CastSpell(target, SPELL_FROST_TOMB, false);
                            events.Repeat(15s);
                            break;
                        }
                    events.Repeat(1s);
                    break;
                case EVENT_SUMMON_SKELETONS:
                    Talk(SAY_SUMMON_SKELETONS);
                    for (uint8 i = 0; i < 5; ++i)
                    {
                        float dist = rand_norm() * 4 + 3.0f;
                        float angle = rand_norm() * 2 * M_PI;
                        if( Creature* c = me->SummonCreature(NPC_SKELETON, 156.2f + cos(angle) * dist, 259.1f + std::sin(angle) * dist, 42.9f, 0, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 20000) )
                            if( Unit* target = c->SelectNearestTarget(250.0f) )
                            {
                                c->AddThreat(target, 5.0f);
                                DoZoneInCombat(c);
                            }
                    }
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

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetUtgardeKeepAI<npc_vrykul_skeletonAI>(pCreature);
    }

    struct npc_vrykul_skeletonAI : public ScriptedAI
    {
        npc_vrykul_skeletonAI(Creature* c) : ScriptedAI(c)
        {
            pInstance = c->GetInstanceScript();
        }

        InstanceScript* pInstance;
        EventMap events;

        void Reset() override
        {
            events.Reset();
            events.RescheduleEvent(EVENT_SPELL_DECREPIFY, 10s, 20s);
            if( IsHeroic() )
                events.RescheduleEvent(EVENT_SPELL_BONE_ARMOR, 25s, 120s);
        }

        void DamageTaken(Unit*, uint32& damage, DamageEffectType, SpellSchoolMask) override
        {
            if (damage >= me->GetHealth())
            {
                damage = 0;
                me->InterruptNonMeleeSpells(true);
                me->RemoveAllAuras();
                me->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                me->SetControlled(true, UNIT_STATE_ROOT);
                me->GetMotionMaster()->MovementExpired();
                me->GetMotionMaster()->MoveIdle();
                me->StopMoving();
                me->SetStandState(UNIT_STAND_STATE_DEAD);
                me->SetUnitFlag(UNIT_FLAG_PREVENT_EMOTES_FROM_CHAT_TEXT);
                me->SetUnitFlag2(UNIT_FLAG2_FEIGN_DEATH);
                me->SetDynamicFlag(UNIT_DYNFLAG_DEAD);
                events.RescheduleEvent(EVENT_RESURRECT, 12s);
            }
        }

        void UpdateAI(uint32 diff) override
        {
            if( pInstance && pInstance->GetData(DATA_KELESETH) != IN_PROGRESS )
            {
                if( me->IsAlive() )
                    me->KillSelf();
                return;
            }

            if (!UpdateVictim())
                return;

            events.Update(diff);

            if( me->HasUnitState(UNIT_STATE_CASTING) )
                return;

            switch( events.ExecuteEvent() )
            {
                case 0:
                    break;
                case EVENT_SPELL_DECREPIFY:
                    if( !me->HasUnitFlag(UNIT_FLAG_NON_ATTACKABLE) )
                        me->CastSpell(me->GetVictim(), SPELL_DECREPIFY, false);
                    events.Repeat(15s, 25s);
                    break;
                case EVENT_SPELL_BONE_ARMOR:
                    if( !me->HasUnitFlag(UNIT_FLAG_NON_ATTACKABLE) )
                        me->CastSpell((Unit*)nullptr, SPELL_BONE_ARMOR, false);
                    events.Repeat(40s, 120s);
                    break;
                case EVENT_RESURRECT:
                    events.DelayEvents(3500ms);
                    DoCast(me, SPELL_SCOURGE_RESURRECTION, true);
                    me->SetStandState(UNIT_STAND_STATE_STAND);
                    me->RemoveUnitFlag(UNIT_FLAG_PREVENT_EMOTES_FROM_CHAT_TEXT);
                    me->RemoveUnitFlag2(UNIT_FLAG2_FEIGN_DEATH);
                    me->RemoveDynamicFlag(UNIT_DYNFLAG_DEAD);
                    events.RescheduleEvent(EVENT_RESURRECT_2, 3s);
                    break;
                case EVENT_RESURRECT_2:
                    me->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                    me->SetControlled(false, UNIT_STATE_ROOT);
                    me->GetMotionMaster()->MoveChase(me->GetVictim());
                    break;
            }

            if( !me->HasUnitFlag(UNIT_FLAG_NON_ATTACKABLE) )
                DoMeleeAttackIfReady();
        }
    };
};

class spell_frost_tomb_aura : public AuraScript
{
    PrepareAuraScript(spell_frost_tomb_aura);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_FROST_TOMB_SUMMON });
    }

    void HandleEffectPeriodic(AuraEffect const* aurEff)
    {
        PreventDefaultAction();
        if (aurEff->GetTickNumber() == 1)
            if( Unit* target = GetTarget() )
                target->CastSpell((Unit*)nullptr, SPELL_FROST_TOMB_SUMMON, true);
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_frost_tomb_aura::HandleEffectPeriodic, EFFECT_1, SPELL_AURA_PERIODIC_DUMMY);
    }
};

void AddSC_boss_keleseth()
{
    new boss_keleseth();
    new npc_frost_tomb();
    new npc_vrykul_skeleton();
    RegisterSpellScript(spell_frost_tomb_aura);
}

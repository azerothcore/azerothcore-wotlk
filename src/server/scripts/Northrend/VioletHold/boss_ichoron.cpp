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
#include "Player.h"
#include "ScriptedCreature.h"
#include "SpellInfo.h"
#include "violet_hold.h"

#define ACTION_WATER_ELEMENT_HIT            1
#define ACTION_WATER_ELEMENT_KILLED         2

#define MAX_SPAWN_LOC 5
static Position SpawnLoc[MAX_SPAWN_LOC] =
{
    {1840.64f, 795.407f, 44.079f, 1.676f},
    {1886.24f, 757.733f, 47.750f, 5.201f},
    {1877.91f, 845.915f, 43.417f, 3.560f},
    {1918.97f, 850.645f, 47.225f, 4.136f},
    {1935.50f, 796.224f, 52.492f, 4.224f},
};

enum Yells
{
    SAY_AGGRO                                   = 0,
    SAY_SLAY                                    = 1,
    SAY_DEATH                                   = 2,
    SAY_SPAWN                                   = 3,
    SAY_ENRAGE                                  = 4,
    SAY_SHATTER                                 = 5,
    SAY_BUBBLE                                  = 6
};

enum eCreatures
{
    NPC_ICHOR_GLOBULE                       = 29321,
};

enum eSpells
{
    SPELL_DRAINED                           = 59820,
    SPELL_FRENZY                            = 54312,
    SPELL_PROTECTIVE_BUBBLE                 = 54306,
    SPELL_WATER_BLAST                       = 54237,
    SPELL_WATER_BOLT_VOLLEY                 = 54241,

    SPELL_SPLASH                            = 59516, // casted by globule upon death
    SPELL_WATER_GLOBULE                     = 54268, // casted when hit by visual
    SPELL_CREATE_GLOBULE_VISUAL             = 54260, // tar 25
};

class boss_ichoron : public CreatureScript
{
public:
    boss_ichoron() : CreatureScript("boss_ichoron") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetVioletHoldAI<boss_ichoronAI>(pCreature);
    }

    struct boss_ichoronAI : public ScriptedAI
    {
        boss_ichoronAI(Creature* c) : ScriptedAI(c), globules(me)
        {
            pInstance = c->GetInstanceScript();
        }

        InstanceScript* pInstance;
        SummonList globules;
        bool bIsExploded;
        bool bIsFrenzy;
        uint32 uiWaterBoltVolleyTimer;
        uint32 uiDrainedTimer;

        void Reset() override
        {
            globules.DespawnAll();
            bIsExploded = false;
            bIsFrenzy = false;
            uiDrainedTimer = 15000;
            uiWaterBoltVolleyTimer = urand(7000, 12000);
            me->RemoveUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
            me->SetDisplayId(me->GetNativeDisplayId());
        }

        void DoAction(int32 param) override
        {
            if (!me->IsAlive())
                return;

            switch (param)
            {
                case ACTION_WATER_ELEMENT_HIT:
                    if (pInstance)
                        pInstance->SetData(DATA_ACHIEV, 0);
                    me->ModifyHealth(int32(me->CountPctFromMaxHealth(1)));
                    if (bIsExploded)
                        DoExplodeCompleted();
                    break;
                case ACTION_WATER_ELEMENT_KILLED:
                    uint32 damage = me->CountPctFromMaxHealth(3);
                    damage = std::min(damage, me->GetHealth() - 1);
                    me->ModifyHealth(-int32(damage));
                    me->LowerPlayerDamageReq(damage);
                    break;
            }
        }

        void DoExplodeCompleted()
        {
            bIsExploded = false;
            me->RemoveAura(SPELL_DRAINED);
            if (!HealthBelowPct(25))
            {
                Talk(SAY_BUBBLE);
                me->CastSpell(me, SPELL_PROTECTIVE_BUBBLE, true);
            }

            me->RemoveUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
            me->SetDisplayId(me->GetNativeDisplayId());
        }

        void IchoronDoCastToAllHostilePlayers(uint32 spellId, bool triggered)
        {
            Map::PlayerList const& PlayerList = me->GetMap()->GetPlayers();
            if (PlayerList.IsEmpty())
                return;

            for (Map::PlayerList::const_iterator i = PlayerList.begin(); i != PlayerList.end(); ++i)
                if (Player* plr = i->GetSource())
                    me->CastSpell(plr, spellId, triggered);
        }

        void JustEngagedWith(Unit* /*who*/) override
        {
            bIsExploded = false;
            bIsFrenzy = false;
            uiDrainedTimer = 15000;
            uiWaterBoltVolleyTimer = urand(7000, 12000);
            DoZoneInCombat();
            Talk(SAY_AGGRO);
            me->CastSpell(me, SPELL_PROTECTIVE_BUBBLE, true);
            if (pInstance)
                pInstance->SetData(DATA_ACHIEV, 1);
        }

        void UpdateAI(uint32 uiDiff) override
        {
            if (!UpdateVictim())
                return;

            if (!bIsFrenzy && !bIsExploded && HealthBelowPct(25))
            {
                Talk(SAY_ENRAGE);
                me->CastSpell(me, SPELL_FRENZY, true);
                bIsFrenzy = true;
            }

            if (!bIsFrenzy)
            {
                if (!bIsExploded)
                {
                    if (!me->HasAura(SPELL_PROTECTIVE_BUBBLE))
                    {
                        me->InterruptNonMeleeSpells(false);
                        Talk(SAY_SHATTER);
                        DoZoneInCombat();
                        IchoronDoCastToAllHostilePlayers(SPELL_WATER_BLAST, true);
                        me->CastSpell(me, SPELL_DRAINED, true);
                        bIsExploded = true;
                        uiDrainedTimer = 15000;
                        me->SetUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
                        me->SetDisplayId(11686);
                        for (uint8 i = 0; i < MAX_SPAWN_LOC; ++i)
                        {
                            float angle = rand_norm() * 2 * M_PI;
                            Position p1(SpawnLoc[i]), p2(SpawnLoc[i]);
                            p1.m_positionX += 2.5f * cos(angle);
                            p1.m_positionY += 2.5f * std::sin(angle);
                            p2.m_positionX -= 2.5f * cos(angle);
                            p2.m_positionY -= 2.5f * std::sin(angle);
                            DoSummon(NPC_ICHOR_GLOBULE, p1, 60000, TEMPSUMMON_TIMED_OR_DEAD_DESPAWN);
                            DoSummon(NPC_ICHOR_GLOBULE, p2, 60000, TEMPSUMMON_TIMED_OR_DEAD_DESPAWN);
                        }
                    }
                }
                else
                {
                    if (uiDrainedTimer <= uiDiff)
                        DoExplodeCompleted();
                    else
                    {
                        uiDrainedTimer -= uiDiff;

                        bool bIsWaterElementsAlive = false;
                        if (!globules.empty())
                        {
                            for (ObjectGuid const& guid : globules)
                                if (Creature* pTemp = ObjectAccessor::GetCreature(*me, guid))
                                    if (pTemp->IsAlive())
                                    {
                                        bIsWaterElementsAlive = true;
                                        break;
                                    }
                        }

                        if (!bIsWaterElementsAlive)
                            DoExplodeCompleted();
                    }
                }
            }

            if (!bIsExploded)
            {
                if (uiWaterBoltVolleyTimer <= uiDiff)
                {
                    me->CastSpell((Unit*)nullptr, SPELL_WATER_BOLT_VOLLEY, false);
                    uiWaterBoltVolleyTimer = urand(10000, 15000);
                }
                else uiWaterBoltVolleyTimer -= uiDiff;
            }

            DoMeleeAttackIfReady();
        }

        void JustSummoned(Creature* pSummoned) override
        {
            if (pSummoned)
            {
                pSummoned->SetSpeed(MOVE_RUN, 0.3f);
                pSummoned->RemoveUnitMovementFlag(MOVEMENTFLAG_WALKING);
                pSummoned->GetMotionMaster()->MoveFollow(me, 0, 0);
                me->CastSpell(pSummoned, SPELL_CREATE_GLOBULE_VISUAL, true); // triggered should ignore los
                globules.Summon(pSummoned);
                if (pInstance)
                    pInstance->SetGuidData(DATA_ADD_TRASH_MOB, pSummoned->GetGUID());
            }
        }

        void SummonedCreatureDespawn(Creature* pSummoned) override
        {
            if (pSummoned)
            {
                globules.Despawn(pSummoned);
                if (pInstance)
                    pInstance->SetGuidData(DATA_DELETE_TRASH_MOB, pSummoned->GetGUID());
            }
        }

        void JustDied(Unit* /*killer*/) override
        {
            Talk(SAY_DEATH);
            bIsExploded = false;
            me->RemoveUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
            me->SetDisplayId(me->GetNativeDisplayId());
            globules.DespawnAll();
            if (pInstance)
                pInstance->SetData(DATA_BOSS_DIED, 0);
        }

        void KilledUnit(Unit* victim) override
        {
            if (victim && victim->GetGUID() == me->GetGUID())
                return;
            Talk(SAY_SLAY);
        }

        void MoveInLineOfSight(Unit* /*who*/) override {}

        void EnterEvadeMode(EvadeReason why) override
        {
            ScriptedAI::EnterEvadeMode(why);
            me->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE);

            if (pInstance)
                pInstance->SetData(DATA_FAILED, 1);
        }
    };
};

class npc_ichor_globule : public CreatureScript
{
public:
    npc_ichor_globule() : CreatureScript("npc_ichor_globule") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetVioletHoldAI<npc_ichor_globuleAI>(pCreature);
    }

    struct npc_ichor_globuleAI : public ScriptedAI
    {
        npc_ichor_globuleAI(Creature* c) : ScriptedAI(c)
        {
            pInstance = c->GetInstanceScript();
            uiRangeCheck_Timer = 1000;
        }

        InstanceScript* pInstance;
        uint32 uiRangeCheck_Timer;

        void SpellHit(Unit*  /*caster*/, SpellInfo const* spell) override
        {
            if (spell->Id == SPELL_CREATE_GLOBULE_VISUAL)
                me->CastSpell(me, SPELL_WATER_GLOBULE, true);
        }

        void UpdateAI(uint32 uiDiff) override
        {
            if (uiRangeCheck_Timer < uiDiff)
            {
                if (pInstance)
                    if (Creature* pIchoron = pInstance->instance->GetCreature(pInstance->GetGuidData(DATA_ICHORON_GUID)))
                        if (me->IsWithinDist(pIchoron, 2.0f, false))
                        {
                            if (pIchoron->AI())
                                pIchoron->AI()->DoAction(ACTION_WATER_ELEMENT_HIT);
                            me->DespawnOrUnsummon();
                        }
                uiRangeCheck_Timer = 1000;
            }
            else uiRangeCheck_Timer -= uiDiff;
        }

        void JustDied(Unit* /*killer*/) override
        {
            me->CastSpell(me, SPELL_SPLASH, true);
            if (pInstance)
                if (Creature* pIchoron = pInstance->instance->GetCreature(pInstance->GetGuidData(DATA_ICHORON_GUID)))
                    if (pIchoron->AI())
                        pIchoron->AI()->DoAction(ACTION_WATER_ELEMENT_KILLED);
            me->DespawnOrUnsummon(2500ms);
        }

        void AttackStart(Unit* /*who*/) override {}
        void MoveInLineOfSight(Unit* /*who*/) override {}
    };
};

void AddSC_boss_ichoron()
{
    new boss_ichoron();
    new npc_ichor_globule();
}

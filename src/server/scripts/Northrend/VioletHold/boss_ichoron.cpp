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

    SPELL_SPLASH                            = 59516,
    SPELL_WATER_GLOBULE                     = 54268,
    SPELL_CREATE_GLOBULE_VISUAL             = 54260,
};

enum eEvents
{
    EVENT_WATER_BOLT_VOLLEY = 1,
    EVENT_DRAINED_CHECK,
};

struct boss_ichoron : public BossAI
{
    boss_ichoron(Creature* c) : BossAI(c, BOSS_ICHORON) { }

    void Reset() override
    {
        BossAI::Reset();
        _isExploded = false;
        _isFrenzy = false;
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
                instance->SetData(DATA_ACHIEV, 0);
                me->ModifyHealth(int32(me->CountPctFromMaxHealth(1)));
                if (_isExploded)
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
        _isExploded = false;
        me->RemoveAura(SPELL_DRAINED);
        if (!HealthBelowPct(25))
        {
            Talk(SAY_BUBBLE);
            DoCastSelf(SPELL_PROTECTIVE_BUBBLE, true);
        }

        me->RemoveUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
        me->SetDisplayId(me->GetNativeDisplayId());
    }

    void IchoronDoCastToAllHostilePlayers(uint32 spellId, bool triggered)
    {
        Map::PlayerList const& playerList = me->GetMap()->GetPlayers();
        if (playerList.IsEmpty())
            return;

        for (Map::PlayerList::const_iterator i = playerList.begin(); i != playerList.end(); ++i)
            if (Player* plr = i->GetSource())
                DoCast(plr, spellId, triggered);
    }

    void JustEngagedWith(Unit* who) override
    {
        _isExploded = false;
        _isFrenzy = false;
        BossAI::JustEngagedWith(who);
        Talk(SAY_AGGRO);
        DoCastSelf(SPELL_PROTECTIVE_BUBBLE, true);
        events.RescheduleEvent(EVENT_WATER_BOLT_VOLLEY, 7s, 12s);
        instance->SetData(DATA_ACHIEV, 1);
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;

        events.Update(diff);

        if (!_isFrenzy && !_isExploded && HealthBelowPct(25))
        {
            Talk(SAY_ENRAGE);
            DoCastSelf(SPELL_FRENZY, true);
            _isFrenzy = true;
        }

        if (!_isFrenzy)
        {
            if (!_isExploded)
            {
                if (!me->HasAura(SPELL_PROTECTIVE_BUBBLE))
                {
                    me->InterruptNonMeleeSpells(false);
                    Talk(SAY_SHATTER);
                    DoZoneInCombat();
                    IchoronDoCastToAllHostilePlayers(SPELL_WATER_BLAST, true);
                    DoCastSelf(SPELL_DRAINED, true);
                    _isExploded = true;
                    events.CancelEvent(EVENT_WATER_BOLT_VOLLEY);
                    events.RescheduleEvent(EVENT_DRAINED_CHECK, 15s);
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
                if (events.ExecuteEvent() == EVENT_DRAINED_CHECK)
                    DoExplodeCompleted();
                else
                {
                    bool isWaterElementsAlive = false;
                    if (!summons.empty())
                    {
                        for (ObjectGuid const& guid : summons)
                            if (Creature* temp = ObjectAccessor::GetCreature(*me, guid))
                                if (temp->IsAlive())
                                {
                                    isWaterElementsAlive = true;
                                    break;
                                }
                    }

                    if (!isWaterElementsAlive)
                        DoExplodeCompleted();
                }
            }
        }

        if (!_isExploded)
        {
            if (events.ExecuteEvent() == EVENT_WATER_BOLT_VOLLEY)
            {
                DoCastAOE(SPELL_WATER_BOLT_VOLLEY);
                events.Repeat(10s, 15s);
            }
        }

        DoMeleeAttackIfReady();
    }

    void JustSummoned(Creature* summoned) override
    {
        if (summoned)
        {
            summoned->SetSpeed(MOVE_RUN, 0.3f);
            summoned->RemoveUnitMovementFlag(MOVEMENTFLAG_WALKING);
            summoned->GetMotionMaster()->MoveFollow(me, 0, 0, MOTION_SLOT_ACTIVE, false, false);
            DoCast(summoned, SPELL_CREATE_GLOBULE_VISUAL, true);
            BossAI::JustSummoned(summoned);
            instance->SetGuidData(DATA_ADD_TRASH_MOB, summoned->GetGUID());
        }
    }

    void SummonedCreatureDespawn(Creature* summoned) override
    {
        if (summoned)
        {
            BossAI::SummonedCreatureDespawn(summoned);
            instance->SetGuidData(DATA_DELETE_TRASH_MOB, summoned->GetGUID());
        }
    }

    void JustDied(Unit* killer) override
    {
        Talk(SAY_DEATH);
        _isExploded = false;
        me->RemoveUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
        me->SetDisplayId(me->GetNativeDisplayId());
        BossAI::JustDied(killer);
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
        me->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
        _EnterEvadeMode(why);
    }

private:
    bool _isExploded;
    bool _isFrenzy;
};

enum eGlobuleEvents
{
    EVENT_RANGE_CHECK = 1,
};

struct npc_ichor_globule : public ScriptedAI
{
    npc_ichor_globule(Creature* c) : ScriptedAI(c)
    {
        _instance = c->GetInstanceScript();
    }

    void Reset() override
    {
        _events.RescheduleEvent(EVENT_RANGE_CHECK, 1s);
    }

    void SpellHit(Unit*  /*caster*/, SpellInfo const* spell) override
    {
        if (spell->Id == SPELL_CREATE_GLOBULE_VISUAL)
            DoCastSelf(SPELL_WATER_GLOBULE, true);
    }

    void UpdateAI(uint32 diff) override
    {
        _events.Update(diff);

        if (_events.ExecuteEvent() == EVENT_RANGE_CHECK)
        {
            if (Creature* ichoron = _instance->GetCreature(BOSS_ICHORON))
                if (me->IsWithinDist(ichoron, 2.0f, false))
                {
                    if (ichoron->AI())
                        ichoron->AI()->DoAction(ACTION_WATER_ELEMENT_HIT);
                    me->DespawnOrUnsummon();
                    return;
                }
            _events.Repeat(1s);
        }
    }

    void JustDied(Unit* /*killer*/) override
    {
        DoCastSelf(SPELL_SPLASH, true);
        if (Creature* ichoron = _instance->GetCreature(BOSS_ICHORON))
            if (ichoron->AI())
                ichoron->AI()->DoAction(ACTION_WATER_ELEMENT_KILLED);
        me->DespawnOrUnsummon(2500ms);
    }

    void AttackStart(Unit* /*who*/) override {}
    void MoveInLineOfSight(Unit* /*who*/) override {}

private:
    InstanceScript* _instance;
    EventMap _events;
};

void AddSC_boss_ichoron()
{
    RegisterVioletHoldCreatureAI(boss_ichoron);
    RegisterVioletHoldCreatureAI(npc_ichor_globule);
}

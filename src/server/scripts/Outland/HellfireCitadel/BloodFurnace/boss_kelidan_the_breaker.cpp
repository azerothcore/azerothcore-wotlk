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

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "SpellAuras.h"
#include "blood_furnace.h"

enum Says
{
    SAY_WAKE                    = 0,
    SAY_ADD_AGGRO               = 1,
    SAY_KILL                    = 2,
    SAY_NOVA                    = 3,
    SAY_DIE                     = 4
};

enum Spells
{
    // Keldian
    SPELL_CORRUPTION            = 30938,
    SPELL_EVOCATION             = 30935,
    SPELL_FIRE_NOVA             = 33132,
    SPELL_SHADOW_BOLT_VOLLEY    = 28599,
    SPELL_BURNING_NOVA          = 30940,
    SPELL_VORTEX                = 37370,

    // Channelers
    SPELL_SHADOW_BOLT           = 12739,
    SPELL_MARK_OF_SHADOW        = 30937,
    SPELL_CHANNELING            = 39123
};

enum Actions
{
    ACTION_CHANNELER_ENGAGED    = 1,
    ACTION_CHANNELER_DIED       = 2
};

const float ShadowmoonChannelers[5][4] =
{
    {302.0f, -87.0f, -24.4f, 0.157f},
    {321.0f, -63.5f, -24.6f, 4.887f},
    {346.0f, -74.5f, -24.6f, 3.595f},
    {344.0f, -103.5f, -24.5f, 2.356f},
    {316.0f, -109.0f, -24.6f, 1.257f}
};

struct boss_kelidan_the_breaker : public BossAI
{
    boss_kelidan_the_breaker(Creature* creature) : BossAI(creature, DATA_KELIDAN)
    {
        scheduler.SetValidator([this]
        {
            return !me->HasUnitState(UNIT_STATE_CASTING);
        });
    }

    ObjectGuid channelers[5];
    uint32 checkTimer;
    bool addYell;

    void Reset() override
    {
        addYell = false;
        checkTimer = 5000;
        _Reset();
        ApplyImmunities(true);
        SummonChannelers();
        me->SetReactState(REACT_PASSIVE);
        me->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
        me->SetImmuneToAll(true);
        if (instance)
        {
            instance->SetData(DATA_KELIDAN, NOT_STARTED);
        }
    }

    void JustEngagedWith(Unit*  /*who*/) override
    {
        Talk(SAY_WAKE);
        _JustEngagedWith();
        me->InterruptNonMeleeSpells(false);
        if (instance)
        {
            instance->SetData(DATA_KELIDAN, IN_PROGRESS);
        }
        scheduler.Schedule(1s, [this](TaskContext context)
        {
            DoCastAOE(SPELL_SHADOW_BOLT_VOLLEY);
            context.Repeat(8s, 13s);
        }).Schedule(5s, [this](TaskContext context)
        {
            DoCastAOE(SPELL_CORRUPTION);
            context.Repeat(30s, 50s);
        }).Schedule(15s, [this](TaskContext context)
        {
            Talk(SAY_NOVA);
            ApplyImmunities(false);
            me->AddAura(SPELL_BURNING_NOVA, me);
            ApplyImmunities(true);
            if (IsHeroic())
            {
                DoCastAOE(SPELL_VORTEX);
            }
            scheduler.DelayGroup(0, 6s);
            scheduler.Schedule(5s, [this](TaskContext /*context*/)
            {
                DoCastSelf(SPELL_FIRE_NOVA, true);
            });
            context.Repeat(25s, 32s);
        });
    }

    void KilledUnit(Unit* /*victim*/) override
    {
        if (urand(0, 1))
        {
            Talk(SAY_KILL);
        }
    }

    void DoAction(int32 param) override
    {
        if (param == ACTION_CHANNELER_ENGAGED)
        {
            if (!addYell)
            {
                addYell = true;
                Talk(SAY_ADD_AGGRO);
                for (uint8 i = 0; i < 5; ++i)
                {
                    Creature* channeler = ObjectAccessor::GetCreature(*me, channelers[i]);
                    if (channeler && !channeler->IsInCombat())
                    {
                        channeler->SetInCombatWithZone();
                    }
                }
            }
        }
        else if (param == ACTION_CHANNELER_DIED)
        {
            for (uint8 i = 0; i < 5; ++i)
            {
                Creature* channeler = ObjectAccessor::GetCreature(*me, channelers[i]);
                if (channeler && channeler->IsAlive())
                    return;
            }
            me->SetReactState(REACT_AGGRESSIVE);
            me->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
            me->SetImmuneToAll(false);
            if (Unit* target = me->SelectNearestPlayer(100.0f))
            {
                AttackStart(target);
            }
        }
    }

    void CheckChannelers()
    {
        if (addYell)
        {
            if (!SelectTargetFromPlayerList(100.0f))
            {
                EnterEvadeMode();
            }
            return;
        }
        SummonChannelers();
        for (uint8 i = 0; i < 5; ++i)
        {
            Creature* channeler = ObjectAccessor::GetCreature(*me, channelers[i]);
            if (channeler && !channeler->HasUnitState(UNIT_STATE_CASTING) && !channeler->IsInCombat())
            {
                Creature* target = ObjectAccessor::GetCreature(*me, channelers[(i + 2) % 5]);
                if (target)
                {
                    channeler->CastSpell(target, SPELL_CHANNELING, false);
                }
            }
        }
    }

    void SummonChannelers()
    {
        for (uint8 i = 0; i < 5; ++i)
        {
            Creature* channeler = ObjectAccessor::GetCreature(*me, channelers[i]);
            if (channeler && channeler->isDead())
            {
                channeler->DespawnOrUnsummon(1);
                channeler = nullptr;
            }
            if (!channeler)
            {
                channeler = me->SummonCreature(NPC_CHANNELER, ShadowmoonChannelers[i][0], ShadowmoonChannelers[i][1], ShadowmoonChannelers[i][2], ShadowmoonChannelers[i][3], TEMPSUMMON_CORPSE_TIMED_DESPAWN, 300000);
            }
            channelers[i] = channeler ? channeler->GetGUID() : ObjectGuid::Empty;
        }
    }

    void JustDied(Unit* /*killer*/) override
    {
        Talk(SAY_DIE);
        _JustDied();
        if (instance)
        {
            me->GetMap()->LoadGrid(0, -111.0f);
            instance->SetData(DATA_KELIDAN, DONE);
            instance->HandleGameObject(instance->GetGuidData(DATA_DOOR1), true);
            instance->HandleGameObject(instance->GetGuidData(DATA_DOOR6), true);
        }
    }

    void ApplyImmunities(bool apply)
    {
        me->ApplySpellImmune(0, IMMUNITY_MECHANIC, MECHANIC_CHARM, apply);
        me->ApplySpellImmune(0, IMMUNITY_MECHANIC, MECHANIC_DISORIENTED, apply);
        me->ApplySpellImmune(0, IMMUNITY_MECHANIC, MECHANIC_DISTRACT, apply);
        me->ApplySpellImmune(0, IMMUNITY_MECHANIC, MECHANIC_FEAR, apply);
        me->ApplySpellImmune(0, IMMUNITY_MECHANIC, MECHANIC_ROOT, apply);
        me->ApplySpellImmune(0, IMMUNITY_MECHANIC, MECHANIC_SILENCE, apply);
        me->ApplySpellImmune(0, IMMUNITY_MECHANIC, MECHANIC_SLEEP, apply);
        me->ApplySpellImmune(0, IMMUNITY_MECHANIC, MECHANIC_SNARE, apply);
        me->ApplySpellImmune(0, IMMUNITY_MECHANIC, MECHANIC_STUN, apply);
        me->ApplySpellImmune(0, IMMUNITY_MECHANIC, MECHANIC_FREEZE, apply);
        me->ApplySpellImmune(0, IMMUNITY_MECHANIC, MECHANIC_KNOCKOUT, apply);
        me->ApplySpellImmune(0, IMMUNITY_MECHANIC, MECHANIC_POLYMORPH, apply);
        me->ApplySpellImmune(0, IMMUNITY_MECHANIC, MECHANIC_BANISH, apply);
        me->ApplySpellImmune(0, IMMUNITY_MECHANIC, MECHANIC_SHACKLE, apply);
        me->ApplySpellImmune(0, IMMUNITY_MECHANIC, MECHANIC_TURN, apply);
        me->ApplySpellImmune(0, IMMUNITY_MECHANIC, MECHANIC_HORROR, apply);
        me->ApplySpellImmune(0, IMMUNITY_MECHANIC, MECHANIC_DAZE, apply);
        me->ApplySpellImmune(0, IMMUNITY_MECHANIC, MECHANIC_SAPPED, apply);
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
        {
            checkTimer += diff;
            if (checkTimer >= 5000)
            {
                checkTimer = 0;
                CheckChannelers();
                if (!me->HasUnitState(UNIT_STATE_CASTING))
                {
                    me->CastSpell(me, SPELL_EVOCATION, false);
                }
            }
            return;
        }

        scheduler.Update(diff);
        if (me->HasUnitState(UNIT_STATE_CASTING))
            return;

        DoMeleeAttackIfReady();
    }
};

struct npc_shadowmoon_channeler : public ScriptedAI
{
    npc_shadowmoon_channeler(Creature* creature) : ScriptedAI(creature) {}

    Creature* GetKelidan()
    {
        if (InstanceScript* instance = me->GetInstanceScript())
        {
            return instance->GetCreature(DATA_KELIDAN);
        }
        return nullptr;
    }

    void JustEngagedWith(Unit*  /*who*/) override
    {
        if (Creature* kelidan = GetKelidan())
        {
            kelidan->AI()->DoAction(ACTION_CHANNELER_ENGAGED);
        }
        me->InterruptNonMeleeSpells(false);
        _scheduler.Schedule(1200ms, 2400ms, [this](TaskContext context)
        {
            DoCastVictim(SPELL_SHADOW_BOLT);
            context.Repeat(6s, 7200ms);
        }).Schedule(5s, 6500ms, [this](TaskContext context)
        {
            DoCastRandomTarget(SPELL_MARK_OF_SHADOW);
            context.Repeat(16s, 17500ms);
        });
    }

    void JustDied(Unit*  /*killer*/) override
    {
        if (Creature* kelidan = GetKelidan())
        {
            kelidan->AI()->DoAction(ACTION_CHANNELER_DIED);
        }
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;

        _scheduler.Update(diff);
        if (me->HasUnitState(UNIT_STATE_CASTING))
            return;

        DoMeleeAttackIfReady();
    }

private:
    TaskScheduler _scheduler;
};

void AddSC_boss_kelidan_the_breaker()
{
    RegisterBloodFurnaceCreatureAI(boss_kelidan_the_breaker);
    RegisterBloodFurnaceCreatureAI(npc_shadowmoon_channeler);
}

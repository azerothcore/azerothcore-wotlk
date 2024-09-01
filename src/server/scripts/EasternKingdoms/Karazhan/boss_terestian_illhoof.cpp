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
#include "ScriptedCreature.h"
#include "SpellInfo.h"
#include "karazhan.h"

enum Text
{
    SAY_SLAY                    = 0,
    SAY_DEATH                   = 1,
    SAY_AGGRO                   = 2,
    SAY_SACRIFICE               = 3,
    SAY_SUMMON                  = 4
};

enum Spells
{
    SPELL_SUMMON_DEMONCHAINS    = 30120,
    SPELL_DEMON_CHAINS          = 30206,
    SPELL_ENRAGE                = 23537,
    SPELL_SHADOW_BOLT           = 30055,
    SPELL_SACRIFICE             = 30115,
    SPELL_BERSERK               = 32965,
    SPELL_SUMMON_FIENDISIMP     = 30184,
    SPELL_SUMMON_IMP            = 30066,

    SPELL_FIENDISH_PORTAL       = 30171,
    SPELL_FIENDISH_PORTAL_1     = 30179,

    SPELL_FIREBOLT              = 30050,
    SPELL_BROKEN_PACT           = 30065,
    SPELL_AMPLIFY_FLAMES        = 30053
};

enum Creatures
{
    NPC_DEMONCHAINS             = 17248,
    NPC_PORTAL                  = 17265
};

struct npc_kilrek : public ScriptedAI
{
    npc_kilrek(Creature* creature) : ScriptedAI(creature)
    {
        instance = creature->GetInstanceScript();
    }

    void Reset() override
    {
        _scheduler.CancelAll();
        TerestianGUID.Clear();
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        _scheduler.Schedule(2s, [this](TaskContext context)
        {
            me->InterruptNonMeleeSpells(false);
            DoCastVictim(SPELL_AMPLIFY_FLAMES);
            context.Repeat(10s, 20s);
        });
    }

    void JustDied(Unit* /*killer*/) override
    {
        ObjectGuid TerestianGuid = instance->GetGuidData(DATA_TERESTIAN);
        if (TerestianGuid)
        {
            Unit* Terestian = ObjectAccessor::GetUnit(*me, TerestianGuid);
            if (Terestian && Terestian->IsAlive())
            {
                DoCast(Terestian, SPELL_BROKEN_PACT, true);
            }
        }
        me->DespawnOrUnsummon(15000);
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
    InstanceScript* instance;
    ObjectGuid TerestianGUID;
};

struct npc_demon_chain : public ScriptedAI
{
    npc_demon_chain(Creature* creature) : ScriptedAI(creature) { }

    void Reset() override
    {
        sacrificeGUID.Clear();
    }

    void IsSummonedBy(WorldObject* summoner) override
    {
        sacrificeGUID = summoner->GetGUID();
        DoCastSelf(SPELL_DEMON_CHAINS, true);
    }

    void JustEngagedWith(Unit* /*who*/) override { }
    void AttackStart(Unit* /*who*/) override { }
    void MoveInLineOfSight(Unit* /*who*/) override { }

    void JustDied(Unit* /*killer*/) override
    {
        if (sacrificeGUID)
        {
            Unit* Sacrifice = ObjectAccessor::GetUnit(*me, sacrificeGUID);
            if (Sacrifice)
            {
                Sacrifice->RemoveAurasDueToSpell(SPELL_SACRIFICE);
            }
        }
    }

private:
    ObjectGuid sacrificeGUID;
};

struct boss_terestian_illhoof : public BossAI
{
    boss_terestian_illhoof(Creature* creature) : BossAI(creature, DATA_TERESTIAN)
    {
        scheduler.SetValidator([this]
        {
            return !me->HasUnitState(UNIT_STATE_CASTING);
        });
    }

    void Reset() override
    {
        _Reset();
        SummonKilrek();
    }

    void SummonKilrek()
    {
        me->RemoveAurasDueToSpell(SPELL_BROKEN_PACT);
        DoCastSelf(SPELL_SUMMON_IMP);
    }

    void SpellHit(Unit* /*caster*/, SpellInfo const* spell) override
    {
        if (spell->Id == SPELL_BROKEN_PACT)
        {
            scheduler.Schedule(45s, [this](TaskContext /*context*/) {
                SummonKilrek();
                });
        }
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        Talk(SAY_AGGRO);
        DoZoneInCombat();
        scheduler.Schedule(30s, [this](TaskContext context)
        {
            if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 100.0f, true, false))
            {
                DoCast(target, SPELL_SACRIFICE, true);
                target->m_Events.AddEventAtOffset([target] {
                    target->CastSpell(target, SPELL_SUMMON_DEMONCHAINS, true);
                }, 1s);

                Talk(SAY_SACRIFICE);
                context.Repeat(30s);
            }
        }).Schedule(5s, [this](TaskContext context)
        {
            DoCastVictim(SPELL_SHADOW_BOLT);
            context.Repeat(10s);
        }).Schedule(10s, [this](TaskContext)
        {
            DoCastAOE(SPELL_FIENDISH_PORTAL);
        }).Schedule(11s, [this](TaskContext)
        {
            DoCastAOE(SPELL_FIENDISH_PORTAL_1);
        }).Schedule(10min, [this](TaskContext /*context*/)
        {
            DoCastSelf(SPELL_BERSERK);
        });
    }

    void JustSummoned(Creature* summoned) override
    {
        if (summoned->GetEntry() == NPC_PORTAL)
        {
            summoned->SetReactState(REACT_PASSIVE);
            if (summoned->GetUInt32Value(UNIT_CREATED_BY_SPELL) == SPELL_FIENDISH_PORTAL_1)
            {
                Talk(SAY_SUMMON);
            }
        }

        summons.Summon(summoned);
    }

    void KilledUnit(Unit* victim) override
    {
        if (victim->IsPlayer())
        {
            Talk(SAY_SLAY);
        }
    }

    void JustDied(Unit* /*killer*/) override
    {
        _JustDied();
        Talk(SAY_DEATH);
    }
};

void AddSC_boss_terestian_illhoof()
{
    RegisterKarazhanCreatureAI(boss_terestian_illhoof);
    RegisterKarazhanCreatureAI(npc_kilrek);
    RegisterKarazhanCreatureAI(npc_demon_chain);
}

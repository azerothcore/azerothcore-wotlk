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
#include "ScriptedCreature.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "ruins_of_ahnqiraj.h"

enum Emotes
{
    EMOTE_TARGET                = 0
};

enum Spells
{
    SPELL_CREEPING_PLAGUE       = 20512,
    SPELL_DISMEMBER             = 96,
    SPELL_GATHERING_SPEED       = 1834,
    SPELL_FULL_SPEED            = 1557,
    SPELL_THORNS                = 25640,
    SPELL_BURU_TRANSFORM        = 24721,
    SPELL_SUMMON_HATCHLING      = 1881,
    SPELL_EXPLODE               = 19593,
    SPELL_EXPLODE_2             = 5255,
    SPELL_BURU_EGG_TRIGGER      = 26646,
    SPELL_CREATURE_SPECIAL      = 7155, // from sniffs
};

enum Events
{
    EVENT_DISMEMBER             = 1,
    EVENT_GATHERING_SPEED       = 2,
    EVENT_CREEPING_PLAGUE       = 3
};

enum Phases
{
    PHASE_EGG                   = 1,
    PHASE_TRANSFORM             = 2
};

struct boss_buru : public BossAI
{
    boss_buru(Creature* creature) : BossAI(creature, DATA_BURU) {}

    void EnterEvadeMode(EvadeReason why) override
    {
        BossAI::EnterEvadeMode(why);

        DoCastSelf(SPELL_FULL_SPEED, true);

        _phase = PHASE_EGG;
        instance->SetData(DATA_BURU_PHASE, _phase);

        ManipulateEggs(true);
    }

    void ManipulateEggs(bool respawn)
    {
        std::list<Creature*> eggs;
        me->GetCreaturesWithEntryInRange(eggs, 150.0f, NPC_BURU_EGG);
        for (Creature* egg : eggs)
            respawn ? egg->Respawn() : Unit::Kill(me, egg);
    }

    void JustEngagedWith(Unit* who) override
    {
        BossAI::JustEngagedWith(who);
        me->AddThreat(who, 1000000.f);
        Talk(EMOTE_TARGET, who);
        DoCastSelf(SPELL_THORNS);
        _phase = PHASE_EGG;
        instance->SetData(DATA_BURU_PHASE, _phase);
        ManipulateEggs(true);
        me->RemoveAurasDueToSpell(SPELL_FULL_SPEED);
        events.ScheduleEvent(EVENT_DISMEMBER, 5s);
        events.ScheduleEvent(EVENT_GATHERING_SPEED, 2s);
    }

    void SpellHit(Unit* /*caster*/, SpellInfo const* spell) override
    {
        if (spell->Id == SPELL_CREATURE_SPECIAL)
            ChaseNewVictim();
    }

    void JustDied(Unit* killer) override
    {
        instance->DoRemoveAurasDueToSpellOnPlayers(SPELL_CREEPING_PLAGUE);
        BossAI::JustDied(killer);
    }

    void KilledUnit(Unit* victim) override
    {
        if (victim->IsPlayer())
            ChaseNewVictim();
    }

    void ChaseNewVictim()
    {
        if (_phase != PHASE_EGG)
            return;

        me->RemoveAurasDueToSpell(SPELL_GATHERING_SPEED);
        events.CancelEvent(EVENT_GATHERING_SPEED);
        events.ScheduleEvent(EVENT_GATHERING_SPEED, 2s);
        if (Unit* victim = SelectTarget(SelectTargetMethod::Random, 0, 0.f, true))
        {
            DoResetThreatList();
            AttackStart(victim);
            me->AddThreat(victim, 1000000.f);
            Talk(EMOTE_TARGET, victim);
        }
    }

    void DamageTaken(Unit* attacker, uint32& damage, DamageEffectType, SpellSchoolMask) override
    {
        if (attacker && attacker->GetEntry() == NPC_BURU_EGG)
        {
            me->LowerPlayerDamageReq(damage);
        }

        if (me->HealthBelowPctDamaged(20, damage) && _phase == PHASE_EGG)
        {
            DoCastSelf(SPELL_FULL_SPEED, true);
            ManipulateEggs(false);
            me->RemoveAurasDueToSpell(SPELL_THORNS);
            me->RemoveAurasDueToSpell(SPELL_GATHERING_SPEED);
            events.Reset();
            _phase = PHASE_TRANSFORM;
            instance->SetData(DATA_BURU_PHASE, _phase);
            DoResetThreatList();
            events.ScheduleEvent(EVENT_CREEPING_PLAGUE, 2s);
            DoCastSelf(SPELL_BURU_TRANSFORM);
        }
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;

        events.Update(diff);

        while (uint32 eventId = events.ExecuteEvent())
        {
            switch (eventId)
            {
                case EVENT_DISMEMBER:
                    DoCastVictim(SPELL_DISMEMBER);
                    events.ScheduleEvent(EVENT_DISMEMBER, 5s);
                    break;
                case EVENT_GATHERING_SPEED:
                    DoCastSelf(SPELL_GATHERING_SPEED);
                    events.ScheduleEvent(EVENT_GATHERING_SPEED, 9s);
                    break;
                case EVENT_CREEPING_PLAGUE:
                    DoCastAOE(SPELL_CREEPING_PLAGUE);
                    events.ScheduleEvent(EVENT_CREEPING_PLAGUE, 6s);
                    break;
                default:
                    break;
            }
        }

        DoMeleeAttackIfReady();
    }
private:
    uint8 _phase;
};

struct npc_buru_egg : public ScriptedAI
{
    npc_buru_egg(Creature* creature) : ScriptedAI(creature)
    {
        _instance = me->GetInstanceScript();
        me->SetCombatMovement(false);
        me->SetReactState(REACT_PASSIVE);
        me->SetControlled(true, UNIT_STATE_STUNNED);
    }

    void JustEngagedWith(Unit* attacker) override
    {
        if (Creature* buru = _instance->GetCreature(DATA_BURU))
        {
            if (!buru->IsInCombat())
            {
                buru->AI()->AttackStart(attacker);
            }
        }
    }

    void JustSummoned(Creature* who) override
    {
        if (who->GetEntry() == NPC_HATCHLING)
        {
            if (Creature* buru = _instance->GetCreature(DATA_BURU))
            {
                if (Unit* target = buru->AI()->SelectTarget(SelectTargetMethod::Random))
                {
                    who->AI()->AttackStart(target);
                }
            }
        }
    }

    void JustDied(Unit* killer) override
    {
        DoCastSelf(SPELL_SUMMON_HATCHLING, true);
        if (killer->GetEntry() != NPC_BURU)
        {
            if (Creature* buru = _instance->GetCreature(DATA_BURU))
            {
                DoCastSelf(SPELL_EXPLODE, true);
                DoCastSelf(SPELL_BURU_EGG_TRIGGER, true);
                buru->CastSpell(buru, SPELL_CREATURE_SPECIAL, true);
            }
        }

        me->DespawnOrUnsummon(5s);
    }

    void UpdateAI(uint32 /*diff*/) override { }

private:
    InstanceScript* _instance;
};

class spell_egg_explosion : public SpellScript
{
    PrepareSpellScript(spell_egg_explosion);

    void HandleDummyHitTarget(SpellEffIndex /*effIndex*/)
    {
        if (Unit* target = GetHitUnit())
        {
            int32 damage = 0;
            if (target->IsPlayer())
                damage = -16 * GetCaster()->GetDistance(target) + 500;
            else if (target->GetEntry() == NPC_BURU && target->HasAura(SPELL_THORNS))
                damage = target->GetMaxHealth() * 7.f / 100;

            GetCaster()->CastCustomSpell(target, SPELL_EXPLODE_2, &damage, nullptr, nullptr, true);
        }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_egg_explosion::HandleDummyHitTarget, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

void AddSC_boss_buru()
{
    RegisterRuinsOfAhnQirajCreatureAI(boss_buru);
    RegisterRuinsOfAhnQirajCreatureAI(npc_buru_egg);
    RegisterSpellScript(spell_egg_explosion);
}

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
#include "SpellScript.h"
#include "TaskScheduler.h"
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
    EVENT_FULL_SPEED            = 3,
    EVENT_CREEPING_PLAGUE       = 4,
    EVENT_RESPAWN_EGG           = 5,
};

enum Phases
{
    PHASE_EGG                   = 0,
    PHASE_TRANSFORM             = 1
};

struct boss_buru : public BossAI
{
    boss_buru(Creature* creature) : BossAI(creature, DATA_BURU), _transforming(false) {}

    void EnterEvadeMode(EvadeReason why) override
    {
        BossAI::EnterEvadeMode(why);

        DoCastSelf(SPELL_FULL_SPEED, true);

        ManipulateEggs(true);
        _eggs.clear();
        _transforming = false;
        _scheduler.CancelAll();
    }

    void ManipulateEggs(bool respawn)
    {
        std::list<Creature*> eggs;
        me->GetCreaturesWithEntryInRange(eggs, 150.0f, NPC_BURU_EGG);
        for (Creature* egg : eggs)
            respawn ? egg->Respawn() : Unit::Kill(me, egg);
    }

    void EnterCombat(Unit* who) override
    {
        _EnterCombat();
        Talk(EMOTE_TARGET, who);
        DoCastSelf(SPELL_THORNS);
        ManipulateEggs(true);
        me->RemoveAurasDueToSpell(SPELL_FULL_SPEED);
        events.ScheduleEvent(EVENT_DISMEMBER, 5s);
        events.ScheduleEvent(EVENT_GATHERING_SPEED, 9s);
        events.ScheduleEvent(EVENT_FULL_SPEED, 60s);
        _phase = PHASE_EGG;
        _scheduler.CancelAll();
    }

    void SpellHit(Unit* /*caster*/, SpellInfo const* spell) override
    {
        if (spell->Id == SPELL_CREATURE_SPECIAL)
            ChaseNewVictim();
    }

    void JustDied(Unit* /*killer*/) override
    {
        if (InstanceScript* pInstance = me->GetInstanceScript())
        {
            pInstance->DoRemoveAurasDueToSpellOnPlayers(SPELL_CREEPING_PLAGUE);
        }
    }

    void KilledUnit(Unit* victim) override
    {
        if (victim->GetTypeId() == TYPEID_PLAYER)
            ChaseNewVictim();
    }

    void ChaseNewVictim()
    {
        if (_phase != PHASE_EGG)
            return;

        me->RemoveAurasDueToSpell(SPELL_FULL_SPEED);
        me->RemoveAurasDueToSpell(SPELL_GATHERING_SPEED);
        events.ScheduleEvent(EVENT_GATHERING_SPEED, 9s);
        events.ScheduleEvent(EVENT_FULL_SPEED, 60s);
        if (Unit* victim = SelectTarget(SelectTargetMethod::Random, 0, 0.f, true))
        {
            DoResetThreat();
            AttackStart(victim);
            me->AddThreat(victim, 1000000.f);
            Talk(EMOTE_TARGET, victim);
        }
    }

    void SetGUID(ObjectGuid const guid, int32 /*type*/) override
    {
        _eggs.push_back(guid);
        events.ScheduleEvent(EVENT_RESPAWN_EGG, 120s);
    }

    void DamageTaken(Unit* attacker, uint32& damage, DamageEffectType, SpellSchoolMask) override
    {
        if (attacker->GetEntry() != NPC_BURU_EGG && _phase == PHASE_EGG)
        {
            damage = damage * 0.01f; // 99% dmg resist
        }

        if (me->HealthBelowPctDamaged(20.f, damage) && _phase == PHASE_EGG)
        {
            _transforming = true;
            DoCastSelf(SPELL_FULL_SPEED, true);
            ManipulateEggs(false);
            SetCombatMovement(false);
            me->StopMoving();
            me->SetReactState(REACT_PASSIVE);
            me->RemoveAurasDueToSpell(SPELL_THORNS);
            events.Reset();
            _phase = PHASE_TRANSFORM;
            DoResetThreat();
            DoCastSelf(SPELL_BURU_TRANSFORM);

            _scheduler.Schedule(6s, [this](TaskContext /*context*/)
                {
                    SetCombatMovement(true);
                    me->SetReactState(REACT_AGGRESSIVE);
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 100.f, true))
                        AttackStart(target);
                    _transforming = false;
                    events.ScheduleEvent(EVENT_CREEPING_PLAGUE, 2s);
                });
        }
    }

    void UpdateAI(uint32 diff) override
    {
        _scheduler.Update(diff);

        if (!UpdateVictim() || _transforming)
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
                case EVENT_FULL_SPEED:
                    DoCastSelf(SPELL_FULL_SPEED);
                    break;
                case EVENT_CREEPING_PLAGUE:
                    DoCastAOE(SPELL_CREEPING_PLAGUE);
                    events.ScheduleEvent(EVENT_CREEPING_PLAGUE, 6s);
                    break;
                case EVENT_RESPAWN_EGG:
                    if (Creature* egg = me->GetMap()->GetCreature(*_eggs.begin()))
                        egg->Respawn();

                    _eggs.pop_front();
                    break;
                default:
                    break;
            }
        }

        DoMeleeAttackIfReady();
    }
private:
    uint8 _phase;
    GuidList _eggs;
    TaskScheduler _scheduler;
    bool _transforming;
};

struct npc_buru_egg : public ScriptedAI
{
    npc_buru_egg(Creature* creature) : ScriptedAI(creature)
    {
        _instance = me->GetInstanceScript();
        SetCombatMovement(false);
        me->SetReactState(REACT_PASSIVE);
    }

    void EnterCombat(Unit* attacker) override
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
                if (!buru->HasAura(SPELL_BURU_TRANSFORM))
                {
                    DoCastSelf(SPELL_EXPLODE);
                    DoCastSelf(SPELL_BURU_EGG_TRIGGER, true);
                    buru->CastSpell(buru, SPELL_CREATURE_SPECIAL, true);
                    if (buru->GetAI())
                        buru->AI()->SetGUID(me->GetGUID());
                }
            }
        }
    }
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

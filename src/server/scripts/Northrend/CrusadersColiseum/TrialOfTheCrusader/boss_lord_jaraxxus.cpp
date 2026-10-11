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
#include "SpellAuras.h"
#include "SpellMgr.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "trial_of_the_crusader.h"

enum JaraxxusTexts
{
    SAY_AGGRO                           = 1,
    EMOTE_LEGION_FLAME                  = 2,
    EMOTE_NETHER_PORTAL                 = 3,
    SAY_MISTRESS_OF_PAIN                = 4,
    EMOTE_INCINERATE                    = 5,
    SAY_INCINERATE                      = 6,
    EMOTE_INFERNAL_ERUPTION             = 7,
    SAY_INFERNAL_ERUPTION               = 8,
    SAY_DEATH                           = 10,
};

enum JaraxxusNPCs
{
    NPC_INFERNAL_VOLCANO                = 34813,
    NPC_NETHER_PORTAL                   = 34825,
};

enum JaraxxusSpells
{
    SPELL_NETHER_POWER                  = 66228,
    SPELL_INCINERATE_FLESH              = 66237,
    SPELL_FEL_FIREBALL                  = 66532,
    SPELL_FEL_LIGHTNING                 = 66528,
    SPELL_LEGION_FLAME                  = 66197,
    SPELL_SUMMON_VOLCANO                = 66258,
    SPELL_SUMMON_NETHER_PORTAL          = 66269,
    SPELL_SPELLSTEAL                    = 30449,

    SPELL_FEL_STREAK                    = 66494,
    SPELL_FEL_STREAK_MORPH              = 66493,

    SPELL_SHIVAN_SLASH                  = 66378,
    SPELL_SPINNING_PAIN_SPIKE           = 66283,
    SPELL_MISTRESS_KISS                 = 66336,
    SPELL_MISTRESS_KISS_INTERRUPT       = 66359,
};

enum JaraxxusEvents
{
    EVENT_SPELL_FEL_FIREBALL = 1,
    EVENT_SPELL_FEL_LIGHTNING,
    EVENT_SPELL_INCINERATE_FLESH,
    EVENT_SPELL_NETHER_POWER,
    EVENT_SPELL_LEGION_FLAME,
    EVENT_SUMMON_VOLCANO,
    EVENT_SUMMON_NETHER_PORTAL,

    EVENT_SPELL_FEL_STREAK,

    EVENT_SPELL_SHIVAN_SLASH,
    EVENT_SPELL_SPINNING_PAIN_SPIKE,
    EVENT_SPELL_MISTRESS_KISS,
};

struct boss_jaraxxus : public ScriptedAI
{
    boss_jaraxxus(Creature* creature) : ScriptedAI(creature), instance(creature->GetInstanceScript()), summons(creature)
    {
        me->AddUnitMovementFlag(MOVEMENTFLAG_WALKING);
        me->SetReactState(REACT_PASSIVE);
    }

    void Reset() override
    {
        events.Reset();
        instance->SetData(TYPE_JARAXXUS, NOT_STARTED);

        std::list<Creature*> creatures;
        me->GetCreatureListWithEntryInGrid(creatures, NPC_INFERNAL_VOLCANO, 500.0f);
        me->GetCreatureListWithEntryInGrid(creatures, NPC_NETHER_PORTAL, 500.0f);
        for (Creature* creature : creatures)
            creature->DespawnOrUnsummon();
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        me->setActive(true);
        events.Reset();
        events.RescheduleEvent(EVENT_SPELL_FEL_FIREBALL, 5s);
        events.RescheduleEvent(EVENT_SPELL_FEL_LIGHTNING, 10s, 15s);
        events.RescheduleEvent(EVENT_SPELL_INCINERATE_FLESH, 24s, 26s);
        events.RescheduleEvent(EVENT_SPELL_NETHER_POWER, 25s, 45s);
        events.RescheduleEvent(EVENT_SPELL_LEGION_FLAME, 30s);
        // Portal and volcano alternate, each scheduling the other
        events.RescheduleEvent(EVENT_SUMMON_NETHER_PORTAL, 20s);

        me->RemoveAura(SPELL_JARAXXUS_CHAINS);
        Talk(SAY_AGGRO);
        DoZoneInCombat();
        instance->SetData(TYPE_JARAXXUS, IN_PROGRESS);
    }

    void SpellHit(Unit* caster, SpellInfo const* spellInfo) override
    {
        uint32 const netherPowerId = sSpellMgr->GetSpellIdForDifficulty(SPELL_NETHER_POWER, me);

        if (spellInfo->Id == netherPowerId)
        {
            if (Aura* aura = me->GetAura(netherPowerId))
                aura->SetStackAmount(spellInfo->StackAmount);
        }
        else if (spellInfo->Id == SPELL_SPELLSTEAL && caster)
        {
            if (Aura* aura = me->GetAura(netherPowerId))
            {
                if (aura->GetStackAmount() > 1)
                    aura->ModStackAmount(-1);
                else
                    aura->Remove();

                caster->CastSpell(caster, SPELL_NETHER_POWER, true);
            }
        }
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;

        events.Update(diff);

        if (me->HasUnitState(UNIT_STATE_CASTING))
            return;

        switch (events.ExecuteEvent())
        {
            case EVENT_SPELL_FEL_FIREBALL:
                DoCastVictim(SPELL_FEL_FIREBALL);
                events.Repeat(10s, 15s);
                break;
            case EVENT_SPELL_FEL_LIGHTNING:
                if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 0.0f, true, true))
                    DoCast(target, SPELL_FEL_LIGHTNING);
                events.Repeat(10s, 15s);
                break;
            case EVENT_SPELL_INCINERATE_FLESH:
                if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 0.0f, true, true))
                {
                    Talk(EMOTE_INCINERATE, target);
                    Talk(SAY_INCINERATE);
                    DoCast(target, SPELL_INCINERATE_FLESH);
                }
                events.Repeat(20s, 25s);
                break;
            case EVENT_SPELL_NETHER_POWER:
                DoCastSelf(SPELL_NETHER_POWER);
                events.DelayEvents(5s);
                events.Repeat(25s, 45s);
                break;
            case EVENT_SPELL_LEGION_FLAME:
                if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 0.0f, true, true))
                {
                    Talk(EMOTE_LEGION_FLAME, target);
                    DoCast(target, SPELL_LEGION_FLAME);
                }
                events.Repeat(30s);
                break;
            case EVENT_SUMMON_NETHER_PORTAL:
                Talk(EMOTE_NETHER_PORTAL);
                Talk(SAY_MISTRESS_OF_PAIN);
                DoCastAOE(SPELL_SUMMON_NETHER_PORTAL);
                events.RescheduleEvent(EVENT_SUMMON_VOLCANO, 1min);
                break;
            case EVENT_SUMMON_VOLCANO:
                Talk(EMOTE_INFERNAL_ERUPTION);
                Talk(SAY_INFERNAL_ERUPTION);
                DoCastAOE(SPELL_SUMMON_VOLCANO);
                events.RescheduleEvent(EVENT_SUMMON_NETHER_PORTAL, 1min);
                break;
            default:
                break;
        }

        DoMeleeAttackIfReady();
    }

    void JustDied(Unit* /*killer*/) override
    {
        summons.DespawnAll();
        Talk(SAY_DEATH);
        instance->SetData(TYPE_JARAXXUS, DONE);
    }

    void JustReachedHome() override
    {
        me->setActive(false);
    }

    void JustSummoned(Creature* summon) override
    {
        summons.Summon(summon);
    }

    void EnterEvadeMode(EvadeReason /*why*/) override
    {
        events.Reset();
        summons.DespawnAll();
        me->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
        instance->SetData(TYPE_FAILED, 1);
    }

    void MoveInLineOfSight(Unit* /*who*/) override { }

private:
    InstanceScript* const instance;
    SummonList summons;
};

struct npc_fel_infernal : public ScriptedAI
{
    npc_fel_infernal(Creature* creature) : ScriptedAI(creature) { }

    void Reset() override
    {
        if (Unit* target = me->SelectNearestTarget(200.0f))
        {
            AttackStart(target);
            DoZoneInCombat();
        }
        events.Reset();
        events.RescheduleEvent(EVENT_SPELL_FEL_STREAK, 7s, 20s);
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;

        events.Update(diff);

        if (me->HasUnitState(UNIT_STATE_CASTING))
            return;

        switch (events.ExecuteEvent())
        {
            case EVENT_SPELL_FEL_STREAK:
                if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 44.0f, true))
                {
                    DoResetThreatList();
                    me->AddThreat(target, 50000.0f);
                    DoCast(target, SPELL_FEL_STREAK_MORPH, true);
                    DoCast(target, SPELL_FEL_STREAK, true);
                    events.Repeat(30s);
                }
                else
                    events.Repeat(5s);
                break;
            default:
                break;
        }

        DoMeleeAttackIfReady();
    }

    void JustDied(Unit* /*killer*/) override
    {
        me->DespawnOrUnsummon(10s);
    }

    void EnterEvadeMode(EvadeReason /*why*/) override
    {
        me->DespawnOrUnsummon();
    }
};

struct npc_mistress_of_pain : public ScriptedAI
{
    npc_mistress_of_pain(Creature* creature) : ScriptedAI(creature) { }

    void Reset() override
    {
        if (Unit* target = me->SelectNearestTarget(200.0f))
        {
            AttackStart(target);
            DoZoneInCombat();
        }
        events.Reset();
        events.RescheduleEvent(EVENT_SPELL_SHIVAN_SLASH, 10s, 20s);
        events.RescheduleEvent(EVENT_SPELL_SPINNING_PAIN_SPIKE, 22s, 30s);
        if (IsHeroic())
            events.RescheduleEvent(EVENT_SPELL_MISTRESS_KISS, 10s, 15s);
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;

        events.Update(diff);

        if (me->HasUnitState(UNIT_STATE_CASTING))
            return;

        switch (events.ExecuteEvent())
        {
            case EVENT_SPELL_SHIVAN_SLASH:
                DoCastVictim(SPELL_SHIVAN_SLASH);
                events.Repeat(15s, 25s);
                break;
            case EVENT_SPELL_SPINNING_PAIN_SPIKE:
                if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 140.0f, true))
                    DoCast(target, SPELL_SPINNING_PAIN_SPIKE);
                events.Repeat(25s, 30s);
                break;
            case EVENT_SPELL_MISTRESS_KISS:
                DoCastAOE(SPELL_MISTRESS_KISS);
                events.Repeat(25s, 35s);
                break;
            default:
                break;
        }

        DoMeleeAttackIfReady();
    }

    void JustDied(Unit* /*killer*/) override
    {
        me->DespawnOrUnsummon(10s);
    }

    void EnterEvadeMode(EvadeReason /*why*/) override
    {
        me->DespawnOrUnsummon();
    }
};

class spell_mistress_kiss_aura : public AuraScript
{
    PrepareAuraScript(spell_mistress_kiss_aura);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_MISTRESS_KISS_INTERRUPT });
    }

    void HandleEffectPeriodic(AuraEffect const* /*aurEff*/)
    {
        Unit* target = GetTarget();
        if (!target->HasUnitState(UNIT_STATE_CASTING))
            return;

        if (Unit* caster = GetCaster())
        {
            caster->CastSpell(target, SPELL_MISTRESS_KISS_INTERRUPT, true);
            SetDuration(0);
        }
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_mistress_kiss_aura::HandleEffectPeriodic, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY);
    }
};

class spell_mistress_kiss_area : public SpellScript
{
    PrepareSpellScript(spell_mistress_kiss_area);

    void FilterTargets(std::list<WorldObject*>& targets)
    {
        targets.remove_if(Acore::ObjectTypeIdCheck(TYPEID_PLAYER, false));
        targets.remove_if(Acore::PowerCheck(POWER_MANA, false));
        if (targets.empty())
            return;

        WorldObject* target = Acore::Containers::SelectRandomContainerElement(targets);
        targets.clear();
        targets.push_back(target);
    }

    void HandleScript(SpellEffIndex /*effIndex*/)
    {
        GetCaster()->CastSpell(GetHitUnit(), uint32(GetEffectValue()), true);
    }

    void Register() override
    {
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_mistress_kiss_area::FilterTargets, EFFECT_0, TARGET_UNIT_SRC_AREA_ENEMY);
        OnEffectHitTarget += SpellEffectFn(spell_mistress_kiss_area::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

void AddSC_boss_jaraxxus()
{
    RegisterTrialOfTheCrusaderCreatureAI(boss_jaraxxus);
    RegisterTrialOfTheCrusaderCreatureAI(npc_fel_infernal);
    RegisterTrialOfTheCrusaderCreatureAI(npc_mistress_of_pain);
    RegisterSpellScript(spell_mistress_kiss_aura);
    RegisterSpellScript(spell_mistress_kiss_area);
}

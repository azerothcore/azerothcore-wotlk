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

#include "AreaTriggerScript.h"
#include "CreatureScript.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "zulgurub.h"
/*
Name: Boss_Hakkar
%Complete: 95
Comment: Blood siphon spell buggy cause of Core Issue.
Category: Zul'Gurub
*/

enum Says
{
    SAY_AGGRO                       = 0,
    SAY_FLEEING                     = 1,
    SAY_MINION_DESTROY              = 2,
    SAY_PROTECT_ALTAR               = 3,
    SAY_PROTECT_GURUBASHI_EMPIRE    = 4,
    SAY_PLEDGE_ALLEGIANCE           = 5,
    SAY_WORLD_WILL_SUFFER           = 6,
    SAY_EVADE                       = 7
};

enum Spells
{
    SPELL_BLOOD_SIPHON          = 24324,
    SPELL_BLOOD_SIPHON_HEAL     = 24322,
    SPELL_BLOOD_SIPHON_DAMAGE   = 24323,
    SPELL_CORRUPTED_BLOOD       = 24328,
    SPELL_CAUSE_INSANITY        = 24327,
    SPELL_ENRAGE                = 24318,
    // The Aspects of all High Priests spells
    SPELL_ASPECT_OF_JEKLIK      = 24687,
    SPELL_ASPECT_OF_VENOXIS     = 24688,
    SPELL_ASPECT_OF_MARLI       = 24686,
    SPELL_ASPECT_OF_THEKAL      = 24689,
    SPELL_ASPECT_OF_ARLOKK      = 24690,
    SPELL_POISONOUS_BLOOD       = 24321
};

enum Events
{
    EVENT_BLOOD_SIPHON          = 1,
    EVENT_CORRUPTED_BLOOD       = 2,
    EVENT_CAUSE_INSANITY        = 3,
    EVENT_ENRAGE                = 4,
    // The Aspects of all High Priests events
    EVENT_ASPECT_OF_JEKLIK      = 5,
    EVENT_ASPECT_OF_VENOXIS     = 6,
    EVENT_ASPECT_OF_MARLI       = 7,
    EVENT_ASPECT_OF_THEKAL      = 8,
    EVENT_ASPECT_OF_ARLOKK      = 9
};

class boss_hakkar : public CreatureScript
{
public:
    boss_hakkar() : CreatureScript("boss_hakkar") { }

    struct boss_hakkarAI : public BossAI
    {
        boss_hakkarAI(Creature* creature) : BossAI(creature, DATA_HAKKAR) { }

        bool CheckInRoom() override
        {
            if (me->GetPositionZ() < 52.f || me->GetPositionZ() > 57.28f)
            {
                BossAI::EnterEvadeMode(EVADE_REASON_BOUNDARY);
                return false;
            }
            return true;
        }

        void ApplyHakkarPowerStacks()
        {
            me->RemoveAurasDueToSpell(SPELL_HAKKAR_POWER);
            for (int i = DATA_JEKLIK; i < DATA_HAKKAR; i++)
                if (instance->GetBossState(i) != DONE)
                    DoCastSelf(SPELL_HAKKAR_POWER, true);
        }

        void Reset() override
        {
            _Reset();

            ApplyHakkarPowerStacks();
        }

        void JustDied(Unit* /*killer*/) override
        {
            _JustDied();
        }

        void JustEngagedWith(Unit* /*who*/) override
        {
            _JustEngagedWith();
            events.ScheduleEvent(EVENT_BLOOD_SIPHON, 90s);
            events.ScheduleEvent(EVENT_CORRUPTED_BLOOD, 25s);
            events.ScheduleEvent(EVENT_CAUSE_INSANITY, 17s);
            events.ScheduleEvent(EVENT_ENRAGE, 1min);
            if (instance->GetBossState(DATA_JEKLIK) != DONE)
                events.ScheduleEvent(EVENT_ASPECT_OF_JEKLIK, 21s);
            if (instance->GetBossState(DATA_VENOXIS) != DONE)
                events.ScheduleEvent(EVENT_ASPECT_OF_VENOXIS, 14s);
            if (instance->GetBossState(DATA_MARLI) != DONE)
                events.ScheduleEvent(EVENT_ASPECT_OF_MARLI, 15s);
            if (instance->GetBossState(DATA_THEKAL) != DONE)
                events.ScheduleEvent(EVENT_ASPECT_OF_THEKAL, 10s);
            if (instance->GetBossState(DATA_ARLOKK) != DONE)
                events.ScheduleEvent(EVENT_ASPECT_OF_ARLOKK, 18s);
            Talk(SAY_AGGRO);
        }

        void EnterEvadeMode(EvadeReason evadeReason) override
        {
            BossAI::EnterEvadeMode(evadeReason);

            Talk(SAY_EVADE);
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim() || !CheckInRoom())
                return;

            events.Update(diff);

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            while (uint32 eventId = events.ExecuteEvent())
            {
                switch (eventId)
                {
                    case EVENT_BLOOD_SIPHON:
                        DoCastAOE(SPELL_BLOOD_SIPHON, true);
                        events.ScheduleEvent(EVENT_BLOOD_SIPHON, 90s);
                        break;
                    case EVENT_CORRUPTED_BLOOD:
                        DoCastVictim(SPELL_CORRUPTED_BLOOD, true);
                        events.ScheduleEvent(EVENT_CORRUPTED_BLOOD, 30s, 40s);
                        break;
                    case EVENT_CAUSE_INSANITY:
                        if (me->GetThreatMgr().GetThreatListSize() > 1)
                        {
                            if (Unit* victim = SelectTarget(SelectTargetMethod::MaxThreat, 0, 30.f, true))
                            {
                                DoCast(victim, SPELL_CAUSE_INSANITY);
                            }
                        }
                        events.ScheduleEvent(EVENT_CAUSE_INSANITY, 35s, 40s);
                        break;
                    case EVENT_ENRAGE:
                        if (!me->HasAura(SPELL_ENRAGE))
                            DoCastSelf(SPELL_ENRAGE);
                        events.ScheduleEvent(EVENT_ENRAGE, 90s);
                        break;
                    case EVENT_ASPECT_OF_JEKLIK:
                        DoCastVictim(SPELL_ASPECT_OF_JEKLIK, true);
                        events.ScheduleEvent(EVENT_ASPECT_OF_JEKLIK, 24s);
                        break;
                    case EVENT_ASPECT_OF_VENOXIS:
                        DoCastVictim(SPELL_ASPECT_OF_VENOXIS, true);
                        events.ScheduleEvent(EVENT_ASPECT_OF_VENOXIS, 16s, 18s);
                        break;
                    case EVENT_ASPECT_OF_MARLI:
                        if (Unit* victim = SelectTarget(SelectTargetMethod::MaxThreat, 0, 5.f, true))
                        {
                            DoCast(victim, SPELL_ASPECT_OF_MARLI, true);
                            me->GetThreatMgr().ModifyThreatByPercent(victim, -100.f);
                        }
                        events.ScheduleEvent(EVENT_ASPECT_OF_MARLI, 45s);
                        break;
                    case EVENT_ASPECT_OF_THEKAL:
                        DoCastVictim(SPELL_ASPECT_OF_THEKAL, true);
                        events.ScheduleEvent(EVENT_ASPECT_OF_THEKAL, 15s);
                        break;
                    case EVENT_ASPECT_OF_ARLOKK:
                        if (Unit* victim = SelectTarget(SelectTargetMethod::MaxThreat, 0, 5.f, true))
                        {
                            DoCast(victim, SPELL_ASPECT_OF_ARLOKK, true);
                            me->GetThreatMgr().ModifyThreatByPercent(victim, -100.f);
                        }
                        events.ScheduleEvent(EVENT_ASPECT_OF_ARLOKK, 10s, 15s);
                        break;
                    default:
                        break;
                }
            }

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetZulGurubAI<boss_hakkarAI>(creature);
    }
};

class at_zulgurub_entrance_speech : public OnlyOnceAreaTriggerScript
{
public:
    at_zulgurub_entrance_speech() : OnlyOnceAreaTriggerScript("at_zulgurub_entrance_speech") {}

    bool _OnTrigger(Player* player, const AreaTrigger* /*at*/) override
    {
        if (InstanceScript* instance = player->GetInstanceScript())
        {
            // Instance map's enormous, Hakkar's GRID is not loaded by the time players enter.
            // Without this, the creature never says anything, because it doesn't load in time.
            player->GetMap()->LoadGrid(-11783.99f, -1655.27f);

            if (Creature* hakkar = ObjectAccessor::GetCreature(*player, instance->GetGuidData(DATA_HAKKAR)))
            {
                hakkar->setActive(true);
                if (hakkar->GetAI())
                {
                    hakkar->AI()->Talk(SAY_PROTECT_GURUBASHI_EMPIRE);
                }
            }
        }

        return false;
    }
};

class at_zulgurub_bridge_speech : public OnlyOnceAreaTriggerScript
{
public:
    at_zulgurub_bridge_speech() : OnlyOnceAreaTriggerScript("at_zulgurub_bridge_speech") {}

    bool _OnTrigger(Player* player, const AreaTrigger* /*at*/) override
    {
        if (InstanceScript* instance = player->GetInstanceScript())
        {
            // Instance map's enormous, Hakkar's GRID is not loaded by the time players enter.
           // Without this, the creature never says anything, because it doesn't load in time.
            player->GetMap()->LoadGrid(-11783.99f, -1655.27f);

            if (Creature* hakkar = ObjectAccessor::GetCreature(*player, instance->GetGuidData(DATA_HAKKAR)))
            {
                if (hakkar->GetAI())
                {
                    hakkar->AI()->Talk(SAY_PROTECT_ALTAR);
                }
            }
        }

        return false;
    }
};

class at_zulgurub_temple_speech : public OnlyOnceAreaTriggerScript
{
public:
    at_zulgurub_temple_speech() : OnlyOnceAreaTriggerScript("at_zulgurub_temple_speech") {}

    bool _OnTrigger(Player* player, const AreaTrigger* /*at*/) override
    {
        if (InstanceScript* instance = player->GetInstanceScript())
        {
            // Instance map's enormous, Hakkar's GRID is not loaded by the time players enter.
           // Without this, the creature never says anything, because it doesn't load in time.
            player->GetMap()->LoadGrid(-11783.99f, -1655.27f);

            if (Creature* hakkar = ObjectAccessor::GetCreature(*player, instance->GetGuidData(DATA_HAKKAR)))
            {
                if (hakkar->GetAI())
                {
                    hakkar->AI()->Talk(SAY_MINION_DESTROY);
                }
            }
        }

        return false;
    }
};

class at_zulgurub_bloodfire_pit_speech : public OnlyOnceAreaTriggerScript
{
public:
    at_zulgurub_bloodfire_pit_speech() : OnlyOnceAreaTriggerScript("at_zulgurub_bloodfire_pit_speech") {}

    bool _OnTrigger(Player* player, const AreaTrigger* /*at*/) override
    {
        if (InstanceScript* instance = player->GetInstanceScript())
        {
            // Instance map's enormous, Hakkar's GRID is not loaded by the time players enter.
           // Without this, the creature never says anything, because it doesn't load in time.
            player->GetMap()->LoadGrid(-11783.99f, -1655.27f);

            if (Creature* hakkar = ObjectAccessor::GetCreature(*player, instance->GetGuidData(DATA_HAKKAR)))
            {
                if (hakkar->GetAI())
                {
                    hakkar->AI()->Talk(SAY_PLEDGE_ALLEGIANCE, player);
                }
            }
        }

        return false;
    }
};

class at_zulgurub_edge_of_madness_speech : public OnlyOnceAreaTriggerScript
{
public:
    at_zulgurub_edge_of_madness_speech() : OnlyOnceAreaTriggerScript("at_zulgurub_edge_of_madness_speech") {}

    bool _OnTrigger(Player* player, const AreaTrigger* /*at*/) override
    {
        if (InstanceScript* instance = player->GetInstanceScript())
        {
            // Instance map's enormous, Hakkar's GRID is not loaded by the time players enter.
           // Without this, the creature never says anything, because it doesn't load in time.
            player->GetMap()->LoadGrid(-11783.99f, -1655.27f);

            if (Creature* hakkar = ObjectAccessor::GetCreature(*player, instance->GetGuidData(DATA_HAKKAR)))
            {
                if (hakkar->GetAI())
                {
                    hakkar->AI()->Talk(SAY_WORLD_WILL_SUFFER, player);
                }
            }
        }

        return false;
    }
};

class spell_blood_siphon : public SpellScript
{
    PrepareSpellScript(spell_blood_siphon);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_BLOOD_SIPHON_DAMAGE, SPELL_BLOOD_SIPHON_HEAL });
    }

    void FilterTargets(std::list<WorldObject*>& targets)
    {
        // Max. 20 targets
        if (!targets.empty())
        {
            Acore::Containers::RandomResize(targets, 20);
        }
    }

    void HandleScriptEffect(SpellEffIndex /*effIndex*/)
    {
        if (Unit* caster = GetCaster())
        {
            if (Player* player = GetHitPlayer())
            {
                player->CastSpell(caster, player->HasAura(SPELL_POISONOUS_BLOOD) ? SPELL_BLOOD_SIPHON_DAMAGE : SPELL_BLOOD_SIPHON_HEAL, true);
            }
        }
    }

    void Register() override
    {
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_blood_siphon::FilterTargets, EFFECT_0, TARGET_UNIT_SRC_AREA_ENEMY);
        OnEffectHitTarget += SpellEffectFn(spell_blood_siphon::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

class spell_hakkar_power_down : public SpellScript
{
    PrepareSpellScript(spell_hakkar_power_down);

    void HandleOnHit()
    {
        if (Unit* caster = GetCaster())
            if (caster->HasAura(SPELL_HAKKAR_POWER))
                caster->RemoveAuraFromStack(SPELL_HAKKAR_POWER);
    }

    void Register() override
    {
        OnHit += SpellHitFn(spell_hakkar_power_down::HandleOnHit);
    }
};

void AddSC_boss_hakkar()
{
    new boss_hakkar();
    new at_zulgurub_entrance_speech();
    new at_zulgurub_bridge_speech();
    new at_zulgurub_temple_speech();
    new at_zulgurub_bloodfire_pit_speech();
    new at_zulgurub_edge_of_madness_speech();
    RegisterSpellScript(spell_blood_siphon);
    RegisterSpellScript(spell_hakkar_power_down);
}

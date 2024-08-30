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
#include "Player.h"
#include "ScriptedCreature.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "ruins_of_ahnqiraj.h"

enum Texts
{
    EMOTE_AGGRO                 = 0,
    EMOTE_MANA_FULL             = 1,
    EMOTE_STONE_PHASE           = 2
};

enum Spells
{
    SPELL_TRAMPLE               = 15550,
    SPELL_DRAIN_MANA_SERVERSIDE = 25676,
    SPELL_DRAIN_MANA            = 25671,
    SPELL_ARCANE_ERUPTION       = 25672,
    SPELL_SUMMON_MANA_FIENDS    = 25684,
    SPELL_SUMMON_MANA_FIEND_1   = 25681, // TARGET_DEST_CASTER_FRONT
    SPELL_SUMMON_MANA_FIEND_2   = 25682, // TARGET_DEST_CASTER_LEFT
    SPELL_SUMMON_MANA_FIEND_3   = 25683, // TARGET_DEST_CASTER_RIGHT
    SPELL_ENERGIZE              = 25685,

    SPELL_LARGE_OBSIDIAN_CHUNK  = 27630 //  Server-side
};

enum Events
{
    EVENT_SPELL_TRAMPLE         = 1,
    EVENT_SPELL_DRAIN_MANA      = 2,
    EVENT_STONE_PHASE           = 3,
    EVENT_STONE_PHASE_END       = 4
};

struct boss_moam : public BossAI
{
    boss_moam(Creature* creature) : BossAI(creature, DATA_MOAM) {}

    void InitializeAI() override
    {
        me->m_CombatDistance = 50.0f;
        Reset();
    }

    void Reset() override
    {
        _Reset();
        me->SetPower(POWER_MANA, 0);
        me->SetRegeneratingPower(false);
    }

    void JustEngagedWith(Unit* who) override
    {
        BossAI::JustEngagedWith(who);
        Talk(EMOTE_AGGRO);
        events.ScheduleEvent(EVENT_STONE_PHASE, 90s);
        events.ScheduleEvent(EVENT_SPELL_TRAMPLE, 9s);
        events.ScheduleEvent(EVENT_SPELL_DRAIN_MANA, 3s);
    }

    void JustDied(Unit* /*killer*/) override
    {
        _JustDied();
        DoCastAOE(SPELL_LARGE_OBSIDIAN_CHUNK, true);
    }

    void SummonedCreatureDies(Creature* /*creature*/, Unit* /*killer*/) override
    {
        if (!summons.IsAnyCreatureAlive() && me->HasAura(SPELL_ENERGIZE))
        {
            events.RescheduleEvent(EVENT_STONE_PHASE_END, 1s);
        }
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;

        events.Update(diff);

        if (me->GetPower(POWER_MANA) == me->GetMaxPower(POWER_MANA))
        {
            if (me->HasAura(SPELL_ENERGIZE))
            {
                me->RemoveAurasDueToSpell(SPELL_ENERGIZE);
                events.RescheduleEvent(EVENT_STONE_PHASE_END, 1s);
            }

            Talk(EMOTE_MANA_FULL);
            DoCastAOE(SPELL_ARCANE_ERUPTION);
        }

        while (uint32 eventId = events.ExecuteEvent())
        {
            switch (eventId)
            {
                case EVENT_STONE_PHASE:
                    Talk(EMOTE_STONE_PHASE);
                    DoCastAOE(SPELL_SUMMON_MANA_FIENDS);
                    DoCastSelf(SPELL_ENERGIZE);
                    events.CancelEvent(EVENT_SPELL_DRAIN_MANA);
                    events.ScheduleEvent(EVENT_STONE_PHASE_END, 90s);
                    break;
                case EVENT_STONE_PHASE_END:
                    me->RemoveAurasDueToSpell(SPELL_ENERGIZE);
                    events.ScheduleEvent(EVENT_SPELL_DRAIN_MANA, 2s, 6s);
                    events.ScheduleEvent(EVENT_STONE_PHASE, 90s);
                    break;
                case EVENT_SPELL_DRAIN_MANA:
                    DoCastAOE(SPELL_DRAIN_MANA_SERVERSIDE);
                    events.ScheduleEvent(EVENT_SPELL_DRAIN_MANA, 2s, 6s);
                    break;
                case EVENT_SPELL_TRAMPLE:
                    DoCastAOE(SPELL_TRAMPLE);
                    events.ScheduleEvent(EVENT_SPELL_TRAMPLE, 15s);
                    break;
                default:
                    break;
            }
        }

        DoMeleeAttackIfReady();
    }
};

// 25676 - Drain Mana (server-side)
class spell_moam_mana_drain_filter : public SpellScript
{
    PrepareSpellScript(spell_moam_mana_drain_filter);

    void FilterTargets(std::list<WorldObject*>& targets)
    {
        targets.remove_if([&](WorldObject* target) -> bool
        {
            return !target->IsPlayer() || target->ToPlayer()->getPowerType() != POWER_MANA;
        });

        if (!targets.empty())
        {
            Acore::Containers::RandomResize(targets, 6);
        }
    }

    void HandleScript(SpellEffIndex /*effIndex*/)
    {
        if (Unit* caster = GetCaster())
        {
            caster->CastSpell(GetHitUnit(), SPELL_DRAIN_MANA, true);
        }
    }

    void Register() override
    {
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_moam_mana_drain_filter::FilterTargets, EFFECT_ALL, TARGET_UNIT_SRC_AREA_ENEMY);
        OnEffectHitTarget += SpellEffectFn(spell_moam_mana_drain_filter::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

// 25684 - Summon Mana Fiends (server-side)
class spell_moam_summon_mana_fiends : public SpellScript
{
    PrepareSpellScript(spell_moam_summon_mana_fiends);

    void HandleScript(SpellEffIndex /*effIndex*/)
    {
        const uint32 spellIds[3] = { SPELL_SUMMON_MANA_FIEND_1, SPELL_SUMMON_MANA_FIEND_2, SPELL_SUMMON_MANA_FIEND_3 };

        for (uint32 spellId : spellIds)
        {
            GetCaster()->CastSpell((Unit*)nullptr, spellId, true);
        }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_moam_summon_mana_fiends::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

void AddSC_boss_moam()
{
    RegisterRuinsOfAhnQirajCreatureAI(boss_moam);
    RegisterSpellScript(spell_moam_mana_drain_filter);
    RegisterSpellScript(spell_moam_summon_mana_fiends);
}

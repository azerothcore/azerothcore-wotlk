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
#include "ruins_of_ahnqiraj.h"

enum Texts
{
    EMOTE_AGGRO                 = 0,
    EMOTE_MANA_FULL             = 1
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

enum Actions
{
    ACTION_STONE_PHASE_START    = 1,
    ACTION_STONE_PHASE_END      = 2
};

class boss_moam : public CreatureScript
{
public:
    boss_moam() : CreatureScript("boss_moam") { }

    struct boss_moamAI : public BossAI
    {
        boss_moamAI(Creature* creature) : BossAI(creature, DATA_MOAM) {}

        void Reset() override
        {
            _Reset();
            me->SetPower(POWER_MANA, 0);
            me->SetRegeneratingPower(false);
            _isStonePhase = false;
        }

        void DoAction(int32 action) override
        {
            switch (action)
            {
                case ACTION_STONE_PHASE_END:
                    {
                        me->RemoveAurasDueToSpell(SPELL_ENERGIZE);
                        events.ScheduleEvent(EVENT_STONE_PHASE, 90000);
                        _isStonePhase = false;
                        break;
                    }
                case ACTION_STONE_PHASE_START:
                    {
                        DoCastAOE(SPELL_SUMMON_MANA_FIENDS);
                        DoCastSelf(SPELL_ENERGIZE);
                        events.ScheduleEvent(EVENT_STONE_PHASE_END, 90000);
                        break;
                    }
                default:
                    break;
            }
        }

        void EnterCombat(Unit* who) override
        {
            BossAI::EnterCombat(who);
            Talk(EMOTE_AGGRO);
            events.ScheduleEvent(EVENT_STONE_PHASE, 90000);
            events.ScheduleEvent(EVENT_SPELL_TRAMPLE, 9000);
            events.ScheduleEvent(EVENT_SPELL_DRAIN_MANA, 3000);
        }

        void JustDied(Unit* /*killer*/) override
        {
            _JustDied();
            DoCastAOE(SPELL_LARGE_OBSIDIAN_CHUNK, true);
        }

        void SummonedCreatureDies(Creature* /*creature*/, Unit* /*killer*/) override
        {
            if (!summons.IsAnyCreatureAlive())
            {
                DoAction(ACTION_STONE_PHASE_END);
            }
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);

            if (me->GetPower(POWER_MANA) == me->GetMaxPower(POWER_MANA))
            {
                Talk(EMOTE_MANA_FULL);
                DoCastAOE(SPELL_ARCANE_ERUPTION);
                DoAction(ACTION_STONE_PHASE_END);
            }

            while (uint32 eventId = events.ExecuteEvent())
            {
                switch (eventId)
                {
                    case EVENT_STONE_PHASE:
                        DoAction(ACTION_STONE_PHASE_START);
                        break;
                    case EVENT_STONE_PHASE_END:
                        DoAction(ACTION_STONE_PHASE_END);
                        break;
                    case EVENT_SPELL_DRAIN_MANA:
                        DoCastAOE(SPELL_DRAIN_MANA_SERVERSIDE);
                        events.ScheduleEvent(EVENT_SPELL_DRAIN_MANA, urand(2000, 6000));
                        break;
                    case EVENT_SPELL_TRAMPLE:
                        DoCastVictim(SPELL_TRAMPLE);
                        events.ScheduleEvent(EVENT_SPELL_TRAMPLE, 15000);
                        break;
                    default:
                        break;
                }
            }
            DoMeleeAttackIfReady();
        }
    private:
        bool _isStonePhase;
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetRuinsOfAhnQirajAI<boss_moamAI>(creature);
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
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_moam_mana_drain_filter::FilterTargets, EFFECT_ALL, TARGET_UNIT_DEST_AREA_ENEMY);
        OnEffectHitTarget += SpellEffectFn(spell_moam_mana_drain_filter::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

// 25684 - Summon Mana Fiends (Server-side)
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
    new boss_moam();
    RegisterSpellScript(spell_moam_mana_drain_filter);
    RegisterSpellScript(spell_moam_summon_mana_fiends);
}

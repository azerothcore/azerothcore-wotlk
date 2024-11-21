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
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "zulgurub.h"

enum Spells
{
    SPELL_SLEEP                             = 24664,
    SPELL_EARTH_SHOCK                       = 24685,
    SPELL_CHAIN_BURN                        = 24684,
    SPELL_SUMMON_NIGHTMARE_ILLUSION_LEFT    = 24681,
    SPELL_SUMMON_NIGHTMARE_ILLUSION_BACK    = 24728,
    SPELL_SUMMON_NIGHTMARE_ILLUSION_RIGHT   = 24729
};

enum Events
{
    EVENT_SLEEP                             = 1,
    EVENT_EARTH_SHOCK                       = 2,
    EVENT_CHAIN_BURN                        = 3,
    EVENT_ILLUSIONS                         = 4
};

struct boss_hazzarah : public BossAI
{
    boss_hazzarah(Creature* creature) : BossAI(creature, DATA_EDGE_OF_MADNESS) { }

    void JustSummoned(Creature* summon) override
    {
        summons.Summon(summon);

        summon->SetCorpseDelay(10);
        summon->SetReactState(REACT_PASSIVE);
        summon->SetUnitFlag(UNIT_FLAG_DISABLE_MOVE);
        summon->SetVisible(false);
        summon->m_Events.AddEventAtOffset([summon]()
            {
                summon->SetVisible(true);
            }, 2s);

        summon->m_Events.AddEventAtOffset([summon]()
            {
                summon->RemoveUnitFlag(UNIT_FLAG_DISABLE_MOVE);
                summon->SetReactState(REACT_AGGRESSIVE);
                summon->SetInCombatWithZone();
            }, 5s);
    }

    void SummonedCreatureDies(Creature* summon, Unit* /*killer*/) override
    {
        summons.Despawn(summon);
        summon->DespawnOrUnsummon();
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        _JustEngagedWith();
        events.ScheduleEvent(EVENT_SLEEP, 12s, 15s);
        events.ScheduleEvent(EVENT_EARTH_SHOCK, 8s, 18s);
        events.ScheduleEvent(EVENT_CHAIN_BURN, 12s, 28s);
        events.ScheduleEvent(EVENT_ILLUSIONS, 16s, 24s);
    }

    bool CanAIAttack(Unit const* target) const override
    {
        if (me->GetThreatMgr().GetThreatListSize() > 1)
        {
            ThreatContainer::StorageType::const_iterator lastRef = me->GetThreatMgr().GetOnlineContainer().GetThreatList().end();
            --lastRef;
            if (Unit* lastTarget = (*lastRef)->getTarget())
            {
                if (lastTarget != target)
                {
                    return !target->HasAura(SPELL_SLEEP);
                }
            }
        }

        return true;
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;

        events.Update(diff);

        if (me->HasUnitState(UNIT_STATE_CASTING))
            return;

        while (uint32 eventId = events.ExecuteEvent())
        {
            switch (eventId)
            {
                case EVENT_SLEEP:
                    DoCastVictim(SPELL_SLEEP, true);
                    events.ScheduleEvent(EVENT_SLEEP, 24s, 32s);
                    return;
                case EVENT_EARTH_SHOCK:
                    DoCastVictim(SPELL_EARTH_SHOCK);
                    events.ScheduleEvent(EVENT_EARTH_SHOCK, 8s, 18s);
                    break;
                case EVENT_CHAIN_BURN:
                    if (me->GetPowerPct(POWER_MANA) > 5.f) // totally guessed
                    {
                        if (Unit* target = SelectTarget(SelectTargetMethod::Random, 1, [&](Unit* u) { return u && !u->IsPet() && u->getPowerType() == POWER_MANA; }))
                        {
                            DoCast(target, SPELL_CHAIN_BURN);
                        }
                    }
                    events.ScheduleEvent(EVENT_CHAIN_BURN, 12s, 28s);
                    break;
                case EVENT_ILLUSIONS:
                    DoCastSelf(SPELL_SUMMON_NIGHTMARE_ILLUSION_LEFT, true);
                    DoCastSelf(SPELL_SUMMON_NIGHTMARE_ILLUSION_BACK, true);
                    DoCastSelf(SPELL_SUMMON_NIGHTMARE_ILLUSION_RIGHT, true);
                    events.ScheduleEvent(EVENT_ILLUSIONS, 15s, 25s);
                    break;
                default:
                    break;
            }
        }

        DoMeleeAttackIfReady();
    }
};

class spell_chain_burn : public SpellScript
{
    PrepareSpellScript(spell_chain_burn);

    void FilterTargets(std::list<WorldObject*>& targets)
    {
        Unit* caster = GetCaster();
        targets.remove_if([caster](WorldObject* target) -> bool
        {
            Unit* unit = target->ToUnit();
            return !unit || unit->getPowerType() != POWER_MANA || caster->GetVictim() == unit;
        });
    }

    void Register() override
    {
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_chain_burn::FilterTargets, EFFECT_0, TARGET_UNIT_TARGET_ENEMY);
    }
};

void AddSC_boss_hazzarah()
{
    RegisterZulGurubCreatureAI(boss_hazzarah);
    RegisterSpellScript(spell_chain_burn);
}

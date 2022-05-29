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

/* ScriptData
SDName: Boss_Gahz'ranka
SD%Complete: 85
SDComment: Massive Geyser with knockback not working. Spell buggy.
SDCategory: Zul'Gurub
EndScriptData */

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "zulgurub.h"

enum Spells
{
    SPELL_FROSTBREATH               = 16099,
    SPELL_MASSIVEGEYSER             = 22421, // Not working. (summon)
    SPELL_SLAM                      = 24326
};

enum Events
{
    EVENT_FROSTBREATH               = 1,
    EVENT_MASSIVEGEYSER             = 2,
    EVENT_SLAM                      = 3
};

class boss_gahzranka : public CreatureScript // gahzranka
{
public:
    boss_gahzranka() : CreatureScript("boss_gahzranka") { }

    struct boss_gahzrankaAI : public BossAI
    {
        boss_gahzrankaAI(Creature* creature) : BossAI(creature, DATA_GAHZRANKA) { }

        void Reset() override
        {
            _Reset();
        }

        void JustDied(Unit* /*killer*/) override
        {
            _JustDied();
        }

        void EnterCombat(Unit* /*who*/) override
        {
            _EnterCombat();
            events.ScheduleEvent(EVENT_FROSTBREATH, 8000);
            events.ScheduleEvent(EVENT_MASSIVEGEYSER, 25000);
            events.ScheduleEvent(EVENT_SLAM, 17000);
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
                    case EVENT_FROSTBREATH:
                        DoCastVictim(SPELL_FROSTBREATH, true);
                        events.ScheduleEvent(EVENT_FROSTBREATH, urand(7000, 11000));
                        break;
                    case EVENT_MASSIVEGEYSER:
                        DoCastVictim(SPELL_MASSIVEGEYSER, true);
                        events.ScheduleEvent(EVENT_MASSIVEGEYSER, urand(22000, 32000));
                        break;
                    case EVENT_SLAM:
                        DoCastVictim(SPELL_SLAM, true);
                        events.ScheduleEvent(EVENT_SLAM, urand(12000, 20000));
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
        return GetZulGurubAI<boss_gahzrankaAI>(creature);
    }
};

class spell_gahzranka_slam : public SpellScript
{
    PrepareSpellScript(spell_gahzranka_slam);

    void FilterTargets(std::list<WorldObject*>& targets)
    {
        if (Unit* caster = GetCaster())
        {
            _wipeThreat = targets.size() < caster->GetThreatMgr().getThreatList().size();
        }
    }

    void HandleWipeThreat(SpellEffIndex effIndex)
    {
        if (_wipeThreat)
        {
            if (Unit* caster = GetCaster())
            {
                if (Unit* target = GetHitUnit())
                {
                    caster->GetThreatMgr().modifyThreatPercent(target, -100);
                }
            }
        }
    }

    void Register() override
    {
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_gahzranka_slam::FilterTargets, EFFECT_1, TARGET_UNIT_SRC_AREA_ENEMY);
        OnEffectHitTarget += SpellEffectFn(spell_gahzranka_slam::HandleWipeThreat, EFFECT_1, SPELL_EFFECT_KNOCK_BACK);
    }

private:
    bool _wipeThreat = false;
};

void AddSC_boss_gahzranka()
{
    new boss_gahzranka();
    RegisterSpellScript(spell_gahzranka_slam);
}

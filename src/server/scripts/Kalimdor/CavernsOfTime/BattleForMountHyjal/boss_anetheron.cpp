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
#include "hyjal.h"

enum Spells
{
    SPELL_CARRION_SWARM       = 31306,
    SPELL_SLEEP               = 31298,
    SPELL_INFERNO             = 31299,
    SPELL_VAMPIRIC_AURA       = 31317,
    SPELL_ENRAGE              = 26662,
    SPELL_INFERNAL_STUN       = 31302,
    SPELL_INFERNAL_IMMOLATION = 31304
};

enum Texts
{
    SAY_ONDEATH         = 0,
    SAY_ONSLAY          = 1,
    SAY_SWARM           = 2,
    SAY_SLEEP           = 3,
    SAY_INFERNO         = 4,
    SAY_ONSPAWN         = 5,
};

struct boss_anetheron : public BossAI
{
public:
    boss_anetheron(Creature* creature) : BossAI(creature, DATA_ANETHERON)
    {
        _recentlySpoken = false;
        scheduler.SetValidator([this]
            {
                return !me->HasUnitState(UNIT_STATE_CASTING);
            });
    }

    void JustEngagedWith(Unit * who) override
    {
        BossAI::JustEngagedWith(who);

        scheduler.Schedule(20s, 28s, [this](TaskContext context)
        {
            if (DoCastRandomTarget(SPELL_CARRION_SWARM, 0, 60.f, false) == SPELL_CAST_OK)
                Talk(SAY_SWARM);
            context.Repeat(10s, 15s);
        }).Schedule(25s, 32s, [this](TaskContext context)
        {
            Talk(SAY_SLEEP);
            DoCastRandomTarget(SPELL_SLEEP, 1, 0.0f, true, false, false);
            context.Repeat(35s, 48s);
        }).Schedule(30s, 48s, [this](TaskContext context)
        {
            if (DoCastRandomTarget(SPELL_INFERNO) == SPELL_CAST_OK)
                Talk(SAY_INFERNO);

            context.Repeat(50s, 55s);
        }).Schedule(10min, [this](TaskContext context)
            {
                DoCastSelf(SPELL_ENRAGE);
                context.Repeat(5min);
            });
    }

    void JustSummoned(Creature* summon) override
    {
        if (summon)
        {
            summon->AI()->DoCast(SPELL_INFERNAL_STUN);
            summon->SetInCombatWithZone();
        }
        BossAI::JustSummoned(summon);
    }

    void DoAction(int32 action) override
    {
        Talk(SAY_ONSPAWN, 1200ms);

        if (action == DATA_ANETHERON)
            me->GetMotionMaster()->MovePath(urand(ALLIANCE_BASE_CHARGE_1, ALLIANCE_BASE_CHARGE_3), false);
    }

    void PathEndReached(uint32 pathId) override
    {
        switch (pathId)
        {
        case ALLIANCE_BASE_CHARGE_1:
        case ALLIANCE_BASE_CHARGE_2:
        case ALLIANCE_BASE_CHARGE_3:
            me->m_Events.AddEventAtOffset([this]()
                {
                    me->GetMotionMaster()->MovePath(urand(ALLIANCE_BASE_PATROL_1, ALLIANCE_BASE_PATROL_3), true);
                }, 1s);
            break;
        }
    }

    void KilledUnit(Unit* victim) override
    {
        if (!_recentlySpoken && victim->IsPlayer())
        {
            Talk(SAY_ONSLAY);
            _recentlySpoken = true;

            scheduler.Schedule(6s, [this](TaskContext)
                {
                    _recentlySpoken = false;
                });
        }
    }

    void JustDied(Unit * killer) override
    {
        Talk(SAY_ONDEATH);
        BossAI::JustDied(killer);
    }

private:
    bool _recentlySpoken;
};

class spell_anetheron_sleep : public SpellScript
{
    PrepareSpellScript(spell_anetheron_sleep);

    void FilterTargets(std::list<WorldObject*>& targets)
    {
        if (!targets.empty())
            Acore::Containers::RandomResize(targets, 3);
    }

    void Register() override
    {
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_anetheron_sleep::FilterTargets, EFFECT_0, TARGET_UNIT_SRC_AREA_ENEMY);
    }
};

void AddSC_boss_anetheron()
{
    RegisterHyjalAI(boss_anetheron);
    RegisterSpellScript(spell_anetheron_sleep);
}

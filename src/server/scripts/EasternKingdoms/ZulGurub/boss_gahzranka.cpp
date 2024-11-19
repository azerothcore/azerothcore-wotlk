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
    SPELL_FROSTBREATH               = 16099,
    SPELL_MASSIVEGEYSER             = 22421,
    SPELL_SLAM                      = 24326,
    SPELL_THRASH                    = 3417, // Triggers 3391
    SPELL_SPLASH                    = 24593
};

enum Misc
{
    GAMEOBJECT_MUDSKUNK_LURE        = 180346
};

struct boss_gahzranka : public BossAI
{
    boss_gahzranka(Creature* creature) : BossAI(creature, DATA_GAHZRANKA) {}

    void IsSummonedBy(WorldObject* /*summoner*/) override
    {
        me->GetMotionMaster()->MovePath(me->GetEntry() * 10, false);
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        _JustEngagedWith();
        me->AddAura(SPELL_THRASH, me);

        ScheduleTimedEvent(8s, [&]
        {
            DoCastVictim(SPELL_FROSTBREATH);
        }, 8s, 20s);

        ScheduleTimedEvent(25s, [&]
        {
            DoCastVictim(SPELL_MASSIVEGEYSER);
        }, 22s, 32s);

        ScheduleTimedEvent(15s, [&]
        {
            DoCastVictim(SPELL_SLAM, true);
        }, 12s, 20s);
    }
};

class spell_gahzranka_slam : public SpellScript
{
    PrepareSpellScript(spell_gahzranka_slam);

    void FilterTargets(std::list<WorldObject*>& targets)
    {
        if (Unit* caster = GetCaster())
            _wipeThreat = targets.size() < caster->GetThreatMgr().GetThreatListSize();
    }

    void HandleWipeThreat(SpellEffIndex /*effIndex*/)
    {
        if (_wipeThreat)
            if (Unit* caster = GetCaster())
                if (Unit* target = GetHitUnit())
                    caster->GetThreatMgr().ModifyThreatByPercent(target, -100);
    }

    void Register() override
    {
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_gahzranka_slam::FilterTargets, EFFECT_1, TARGET_UNIT_SRC_AREA_ENEMY);
        OnEffectHitTarget += SpellEffectFn(spell_gahzranka_slam::HandleWipeThreat, EFFECT_1, SPELL_EFFECT_KNOCK_BACK);
    }

private:
    bool _wipeThreat = false;
};

class spell_pagles_point_cast : public SpellScript
{
    PrepareSpellScript(spell_pagles_point_cast);

    void OnEffect(SpellEffIndex /*effIndex*/)
    {
        if (Unit* caster = GetCaster())
        {
            if (InstanceScript* instanceScript = caster->GetInstanceScript())
            {
                if (!instanceScript->GetData(DATA_GAHZRANKA) && !caster->FindNearestCreature(NPC_GAHZRANKA, 50.0f))
                {
                    caster->m_Events.AddEventAtOffset([caster]()
                    {
                        if (GameObject* lure = caster->SummonGameObject(GAMEOBJECT_MUDSKUNK_LURE, -11688.5f, -1737.74f, 10.409842f, 1.f, 0.f, 0.f, 0.f, 0.f, 30 * IN_MILLISECONDS))
                        {
                            lure->DespawnOrUnsummon(5s);
                            caster->m_Events.AddEventAtOffset([caster]()
                            {
                                if (!caster->FindNearestCreature(NPC_GAHZRANKA, 50.0f))
                                {
                                    caster->CastSpell(caster, SPELL_SPLASH, true);
                                    caster->SummonCreature(NPC_GAHZRANKA, -11688.5f, -1723.74f, -5.78f, 0.f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 5 * DAY * IN_MILLISECONDS);
                                }
                            }, 5s);
                        }
                    }, 2s);
                }
            }
        }
    }

    void Register() override
    {
        OnEffectLaunch += SpellEffectFn(spell_pagles_point_cast::OnEffect, EFFECT_1, SPELL_EFFECT_SEND_EVENT);
    }
};

void AddSC_boss_gahzranka()
{
    RegisterZulGurubCreatureAI(boss_gahzranka);
    RegisterSpellScript(spell_gahzranka_slam);
    RegisterSpellScript(spell_pagles_point_cast);
}

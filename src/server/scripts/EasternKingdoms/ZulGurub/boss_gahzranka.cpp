/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the
 * Free Software Foundation; either version 2 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
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
#include "SpellScript.h"
#include "zulgurub.h"

enum Spells
{
    SPELL_FROSTBREATH               = 16099,
    SPELL_MASSIVEGEYSER             = 22421,
    SPELL_SLAM                      = 24326,
    SPELL_THRASH                    = 3417, // Triggers 3391
    SPELL_SPLASH                    = 24593
};

enum Events
{
    EVENT_FROSTBREATH               = 1,
    EVENT_MASSIVEGEYSER             = 2,
    EVENT_SLAM                      = 3
};

enum Misc
{
    GAMEOBJECT_MUDSKUNK_LURE        = 180346
};

class boss_gahzranka : public CreatureScript
{
public:
    boss_gahzranka() : CreatureScript("boss_gahzranka") { }

    struct boss_gahzrankaAI : public BossAI
    {
        boss_gahzrankaAI(Creature* creature) : BossAI(creature, DATA_GAHZRANKA) { }

        void IsSummonedBy(Unit* /*summoner*/) override
        {
            me->GetMotionMaster()->MovePath(me->GetEntry() * 10, false);
        }

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
            me->AddAura(SPELL_THRASH, me);
            events.ScheduleEvent(EVENT_FROSTBREATH, 8000);
            events.ScheduleEvent(EVENT_MASSIVEGEYSER, 25000);
            events.ScheduleEvent(EVENT_SLAM, 15000);
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
                        DoCastVictim(SPELL_FROSTBREATH);
                        events.ScheduleEvent(EVENT_FROSTBREATH, urand(8000, 20000));
                        break;
                    case EVENT_MASSIVEGEYSER:
                        DoCastVictim(SPELL_MASSIVEGEYSER);
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

    void HandleWipeThreat(SpellEffIndex /*effIndex*/)
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

class spell_pagles_point_cast : public SpellScript
{
    PrepareSpellScript(spell_pagles_point_cast);

    void OnEffect(SpellEffIndex /*effIndex*/)
    {
        if (Unit* caster = GetCaster())
        {
            if (InstanceScript* instanceScript = caster->GetInstanceScript())
            {
                if (!instanceScript->GetData(DATA_GAHZRANKA))
                {
                    caster->m_Events.AddEventAtOffset([caster]()
                    {
                        if (GameObject* lure = caster->SummonGameObject(GAMEOBJECT_MUDSKUNK_LURE, -11688.5f, -1737.74f, 10.409842f, 1.f, 0.f, 0.f, 0.f, 0.f, 30 * IN_MILLISECONDS))
                        {
                            caster->m_Events.AddEventAtOffset([caster, lure]()
                            {
                                if (lure)
                                    lure->DespawnOrUnsummon();
                                caster->CastSpell(caster, SPELL_SPLASH, true);
                                caster->SummonCreature(NPC_GAHZRANKA, -11688.5f, -1723.74f, -5.78f, 0.f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 5 * DAY * IN_MILLISECONDS);
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
    new boss_gahzranka();
    RegisterSpellScript(spell_gahzranka_slam);
    RegisterSpellScript(spell_pagles_point_cast);
}

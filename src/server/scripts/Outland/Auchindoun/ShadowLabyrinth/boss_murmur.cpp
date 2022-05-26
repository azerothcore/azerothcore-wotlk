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

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "SpellInfo.h"
#include "shadow_labyrinth.h"

enum Murmur
{
    EMOTE_SONIC_BOOM            = 0,

    SPELL_RESONANCE                 = 33657,
    SPELL_MAGNETIC_PULL             = 33689,
    SPELL_SONIC_SHOCK               = 38797,
    SPELL_THUNDERING_STORM          = 39365,

    SPELL_SONIC_BOOM_CAST_N         = 33923,
    SPELL_SONIC_BOOM_CAST_H         = 38796,
    SPELL_SONIC_BOOM_EFFECT_N       = 38795,
    SPELL_SONIC_BOOM_EFFECT_H       = 33666,
    SPELL_MURMURS_TOUCH_N           = 33711,
    SPELL_MURMURS_TOUCH_H           = 38794,

    EVENT_SPELL_SONIC_BOOM          = 1,
    EVENT_SPELL_SONIC_BOOM_EFFECT   = 2,
    EVENT_SPELL_MURMURS_TOUCH       = 3,
    EVENT_SPELL_RESONANCE           = 4,
    EVENT_SPELL_MAGNETIC            = 5,
    EVENT_SPELL_THUNDERING          = 6,
    EVENT_SPELL_SONIC_SHOCK         = 7
};

class boss_murmur : public CreatureScript
{
public:
    boss_murmur() : CreatureScript("boss_murmur") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetShadowLabyrinthAI<boss_murmurAI>(creature);
    }

    struct boss_murmurAI : public ScriptedAI
    {
        boss_murmurAI(Creature* creature) : ScriptedAI(creature)
        {
            SetCombatMovement(false);
            instance = creature->GetInstanceScript();
        }

        InstanceScript* instance;
        EventMap events;

        void Reset() override
        {
            events.Reset();
            me->SetHealth(me->CountPctFromMaxHealth(40));
            me->ResetPlayerDamageReq();

            if (instance)
                instance->SetData(DATA_MURMUREVENT, NOT_STARTED);
        }

        void EnterCombat(Unit* /*who*/) override
        {
            events.ScheduleEvent(EVENT_SPELL_SONIC_BOOM, 30000);
            events.ScheduleEvent(EVENT_SPELL_MURMURS_TOUCH, urand(8000, 20000));
            events.ScheduleEvent(EVENT_SPELL_RESONANCE, 5000);
            events.ScheduleEvent(EVENT_SPELL_MAGNETIC, urand(15000, 30000));
            if (IsHeroic())
            {
                events.ScheduleEvent(EVENT_SPELL_THUNDERING, 15000);
                events.ScheduleEvent(EVENT_SPELL_SONIC_SHOCK, 10000);
            }

            if (instance)
                instance->SetData(DATA_MURMUREVENT, IN_PROGRESS);
        }

        void JustDied(Unit*) override
        {
            if (instance)
                instance->SetData(DATA_MURMUREVENT, DONE);
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim() || me->HasUnitState(UNIT_STATE_CASTING))
                return;

            events.Update(diff);
            switch (events.ExecuteEvent())
            {
                case EVENT_SPELL_SONIC_BOOM:
                    Talk(EMOTE_SONIC_BOOM);
                    me->CastSpell(me, DUNGEON_MODE(SPELL_SONIC_BOOM_CAST_N, SPELL_SONIC_BOOM_CAST_H), false);
                    events.RepeatEvent(28500);
                    events.DelayEvents(1500);
                    events.ScheduleEvent(EVENT_SPELL_SONIC_BOOM_EFFECT, 0);
                    return;
                case EVENT_SPELL_SONIC_BOOM_EFFECT:
                    me->CastSpell(me, DUNGEON_MODE(SPELL_SONIC_BOOM_EFFECT_N, SPELL_SONIC_BOOM_EFFECT_H), true);
                    break;
                case EVENT_SPELL_MURMURS_TOUCH:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 80.0f, true))
                        me->CastSpell(target, DUNGEON_MODE(SPELL_MURMURS_TOUCH_N, SPELL_MURMURS_TOUCH_H), false);
                    events.RepeatEvent(urand(25000, 35000));
                    break;
                case EVENT_SPELL_RESONANCE:
                    if (!me->IsWithinMeleeRange(me->GetVictim()))
                        me->CastSpell(me, SPELL_RESONANCE, false);
                    events.RepeatEvent(5000);
                    break;
                case EVENT_SPELL_MAGNETIC:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 80.0f, true))
                    {
                        me->CastSpell(target, SPELL_MAGNETIC_PULL, false);
                        events.RepeatEvent(urand(15000, 30000));
                        return;
                    }
                    events.RepeatEvent(500);
                    break;
                case EVENT_SPELL_THUNDERING:
                    me->CastSpell(me, SPELL_THUNDERING_STORM, true);
                    events.RepeatEvent(15000);
                    break;
                case EVENT_SPELL_SONIC_SHOCK:
                    me->CastSpell(me->GetVictim(), SPELL_SONIC_SHOCK, false);
                    events.RepeatEvent(urand(10000, 20000));
                    break;
            }

            if (!me->isAttackReady())
                return;

            if (!me->IsWithinMeleeRange(me->GetVictim()))
            {
                ThreatContainer::StorageType threatlist = me->GetThreatMgr().getThreatList();
                for (ThreatContainer::StorageType::const_iterator i = threatlist.begin(); i != threatlist.end(); ++i)
                    if (Unit* target = ObjectAccessor::GetUnit(*me, (*i)->getUnitGuid()))
                        if (target->IsAlive() && me->IsWithinMeleeRange(target))
                        {
                            me->TauntApply(target);
                            break;
                        }
            }

            DoMeleeAttackIfReady();
        }
    };
};

class spell_murmur_sonic_boom_effect : public SpellScriptLoader
{
public:
    spell_murmur_sonic_boom_effect() : SpellScriptLoader("spell_murmur_sonic_boom_effect") { }

    class spell_murmur_sonic_boom_effect_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_murmur_sonic_boom_effect_SpellScript)

    public:
        spell_murmur_sonic_boom_effect_SpellScript() : SpellScript() { }

        void RecalculateDamage()
        {
            SetHitDamage(GetHitUnit()->CountPctFromMaxHealth(90));
        }

        void Register() override
        {
            OnHit += SpellHitFn(spell_murmur_sonic_boom_effect_SpellScript::RecalculateDamage);
        }
    };

    SpellScript* GetSpellScript() const override
    {
        return new spell_murmur_sonic_boom_effect_SpellScript();
    }
};

class spell_murmur_thundering_storm : public SpellScriptLoader
{
public:
    spell_murmur_thundering_storm() : SpellScriptLoader("spell_murmur_thundering_storm") { }

    class spell_murmur_thundering_storm_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_murmur_thundering_storm_SpellScript);

        void SelectTarget(std::list<WorldObject*>& targets)
        {
            targets.remove_if(Acore::AllWorldObjectsInExactRange(GetCaster(), 100.0f, true));
            targets.remove_if(Acore::AllWorldObjectsInExactRange(GetCaster(), 25.0f, false));
        }

        void Register() override
        {
            OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_murmur_thundering_storm_SpellScript::SelectTarget, EFFECT_0, TARGET_UNIT_SRC_AREA_ENEMY);
        }
    };

    SpellScript* GetSpellScript() const override
    {
        return new spell_murmur_thundering_storm_SpellScript();
    }
};

void AddSC_boss_murmur()
{
    new boss_murmur();
    new spell_murmur_sonic_boom_effect();
    new spell_murmur_thundering_storm();
}

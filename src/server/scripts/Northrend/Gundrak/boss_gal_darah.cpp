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

#include "AchievementCriteriaScript.h"
#include "CreatureScript.h"
#include "ScriptedCreature.h"
#include "SpellScriptLoader.h"
#include "gundrak.h"
#include "SpellScript.h"

enum Spells
{
    SPELL_START_VISUAL                  = 54988,
    SPELL_ENRAGE                        = 55285,
    SPELL_IMPALING_CHARGE               = 54956,
    SPELL_IMPALING_CHARGE_VEHICLE       = 54958,
    SPELL_STOMP                         = 55292,
    SPELL_PUNCTURE                      = 55276,
    SPELL_STAMPEDE                      = 55218,
    SPELL_STAMPEDE_DMG                  = 55220,
    SPELL_WHIRLING_SLASH                = 55250,
    SPELL_TRANSFORM_TO_RHINO            = 55297,
    SPELL_TRANSFORM_TO_TROLL            = 55299
};

enum Yells
{
    SAY_AGGRO                           = 0,
    SAY_SLAY                            = 1,
    SAY_DEATH                           = 2,
    SAY_SUMMON_RHINO                    = 3,
    SAY_TRANSFORM                       = 4,
    SAY_IMPALE                          = 5
};

enum Events
{
    EVENT_KILL_TALK                     = 1
};

struct boss_gal_darah : public BossAI
{
    boss_gal_darah(Creature* creature) : BossAI(creature, DATA_GAL_DARAH) { }

    void Reset() override
    {
        BossAI::Reset();
        DoCastSelf(SPELL_START_VISUAL);
        impaledList.clear();
        _stampedeVictim.Clear();
    }

    void JustReachedHome() override
    {
        BossAI::JustReachedHome();
        DoCastSelf(SPELL_START_VISUAL);
    }

    void SpellHit(Unit* /*caster*/, SpellInfo const* spellInfo) override
    {
        if (spellInfo->Id == SPELL_TRANSFORM_TO_RHINO)
        {
            ScheduleTimedEvent(8s, 11s, [&] {
                if (Unit* target = SelectTarget(SelectTargetMethod::Random, 1, 100.0f, true))
                {
                    DoCast(target, SPELL_IMPALING_CHARGE);
                    Talk(SAY_IMPALE, target);
                    impaledList.insert(target->GetGUID());
                }
            }, 16s, 17s);

            ScheduleTimedEvent(6s, 8s, [&] {
                DoCastSelf(SPELL_ENRAGE);
            }, 16s, 17s);

            ScheduleTimedEvent(7s, 10s, [&] {
                DoCastAOE(SPELL_STOMP);
            }, 10s, 12s);

            me->m_Events.AddEventAtOffset([&] {
                scheduler.CancelAll();
                DoCastSelf(SPELL_TRANSFORM_TO_TROLL);
            }, 32s);
        }
        else if (spellInfo->Id == SPELL_TRANSFORM_TO_TROLL)
        {
            ScheduleEvents();
        }
    }

    void ScheduleEvents()
    {
        ScheduleTimedEvent(10s, [&] {
            Talk(SAY_SUMMON_RHINO);
            if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 100.0f))
            {
                _stampedeVictim = target->GetGUID();
                DoCast(target, SPELL_STAMPEDE);
            }
        }, 15s);

        ScheduleTimedEvent(10s, 16s, [&] {
            DoCastVictim(SPELL_PUNCTURE);
        }, 15s, 18s);

        ScheduleTimedEvent(11s, 19s, [&] {
            DoCastAOE(SPELL_WHIRLING_SLASH);
        }, 17s, 19s);

        me->m_Events.AddEventAtOffset([&] {
            scheduler.CancelAll();
            DoCastSelf(SPELL_TRANSFORM_TO_RHINO);
            Talk(SAY_TRANSFORM);
        }, 32s);
    }

    void JustEngagedWith(Unit* who) override
    {
        Talk(SAY_AGGRO);
        BossAI::JustEngagedWith(who);

        ScheduleEvents();
        me->RemoveAurasDueToSpell(SPELL_START_VISUAL);
        me->InterruptNonMeleeSpells(true);
    }

    void JustSummoned(Creature* summon) override
    {
        if (Unit* target = ObjectAccessor::GetUnit(*me, _stampedeVictim))
            summon->CastSpell(target, SPELL_STAMPEDE_DMG, true);

        summons.Summon(summon);
    }

    uint32 GetData(uint32  /*type*/) const override
    {
        return impaledList.size();
    }

    void JustDied(Unit* killer) override
    {
        Talk(SAY_DEATH);
        BossAI::JustDied(killer);
    }

    void KilledUnit(Unit*) override
    {
        if (!events.HasTimeUntilEvent(EVENT_KILL_TALK))
        {
            Talk(SAY_SLAY);
            events.ScheduleEvent(EVENT_KILL_TALK, 6s);
        }
    }

private:
    GuidSet impaledList;
    ObjectGuid _stampedeVictim;
};

class spell_galdarah_impaling_charge : public SpellScript
{
    PrepareSpellScript(spell_galdarah_impaling_charge);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_IMPALING_CHARGE_VEHICLE });
    }

    void HandleApplyAura(SpellEffIndex /*effIndex*/)
    {
        if (Unit* target = GetHitUnit())
            target->CastSpell(GetCaster(), SPELL_IMPALING_CHARGE_VEHICLE, true);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_galdarah_impaling_charge::HandleApplyAura, EFFECT_1, SPELL_EFFECT_APPLY_AURA);
    }
};

class spell_galdarah_transform : public SpellScript
{
    PrepareSpellScript(spell_galdarah_transform);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_TRANSFORM_TO_RHINO });
    }

    void HandleScriptEffect(SpellEffIndex /*effIndex*/)
    {
        if (Unit* target = GetHitUnit())
            target->RemoveAurasDueToSpell(SPELL_TRANSFORM_TO_RHINO);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_galdarah_transform::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

class achievement_share_the_love : public AchievementCriteriaScript
{
public:
    achievement_share_the_love() : AchievementCriteriaScript("achievement_share_the_love") { }

    bool OnCheck(Player* /*player*/, Unit* target, uint32 /*criteria_id*/) override
    {
        if (!target)
            return false;

        return target->GetAI()->GetData(target->GetEntry()) >= 5;
    }
};

void AddSC_boss_gal_darah()
{
    RegisterGundrakCreatureAI(boss_gal_darah);
    RegisterSpellScript(spell_galdarah_impaling_charge);
    RegisterSpellScript(spell_galdarah_transform);
    new achievement_share_the_love();
}

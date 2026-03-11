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

#include "CreatureScript.h"
#include "GridNotifiers.h"
#include "ScriptedCreature.h"
#include "SpellAuraEffects.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "hyjal.h"

enum Spells
{
    SPELL_MALEVOLENT_CLEAVE = 31436,
    SPELL_WAR_STOMP         = 31480,
    SPELL_CRIPPLE           = 31477,
    SPELL_MARK              = 31447,
    SPELL_MARK_DAMAGE       = 31463
};

enum Texts
{
    SAY_ONSLAY          = 0,
    SAY_MARK            = 1,
    SAY_ONSPAWN         = 2,
};

enum Sounds
{
    SOUND_ONDEATH       = 11018,
};

struct boss_kazrogal : public BossAI
{
public:
    boss_kazrogal(Creature* creature) : BossAI(creature, DATA_KAZROGAL)
    {
        scheduler.SetValidator([this]
            {
                return !me->HasUnitState(UNIT_STATE_CASTING);
            });
    }

    void Reset() override
    {
        _recentlySpoken = false;
        _markCounter = 0;
        BossAI::Reset();
    }

    void JustEngagedWith(Unit * who) override
    {
        BossAI::JustEngagedWith(who);

        scheduler.Schedule(6s, 21s, [this](TaskContext context)
        {
            DoCastVictim(SPELL_MALEVOLENT_CLEAVE);
            context.Repeat();
        }).Schedule(12s, 18s, [this](TaskContext context)
        {
            if (SelectTarget(SelectTargetMethod::Random, 0, 12.f))
            {
                DoCastAOE(SPELL_WAR_STOMP);
                context.Repeat(15s, 30s);
            }
            else
                context.Repeat(1200ms);
        }).Schedule(15s, [this](TaskContext context)
        {
            DoCastRandomTarget(SPELL_CRIPPLE, 0, 20.f);
            context.Repeat(12s, 20s);
        }).Schedule(45s, [this](TaskContext context)
        {
            DoCastSelf(SPELL_MARK);
            Talk(SAY_MARK);
            context.Repeat(GetMarkRepeatTimer());
        });
    }

    Milliseconds GetMarkRepeatTimer()
    {
        ++_markCounter;
        Milliseconds timer = 45s - (5s * _markCounter);
        if (timer <= 10s)
            return 10s;
        else
            return timer;
    }

    void DoAction(int32 action) override
    {
        Talk(SAY_ONSPAWN, 1200ms);

        if (action == DATA_KAZROGAL)
            me->GetMotionMaster()->MoveWaypoint(HORDE_BOSS_PATH, false);
    }

    void KilledUnit(Unit * victim) override
    {
        if (!_recentlySpoken && victim->IsPlayer() && me->IsAlive())
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
        me->PlayDirectSound(SOUND_ONDEATH);
        BossAI::JustDied(killer);
    }

private:
    bool _recentlySpoken;
    uint8 _markCounter;
};

class spell_mark_of_kazrogal : public SpellScript
{
    PrepareSpellScript(spell_mark_of_kazrogal);

    void FilterTargets(std::list<WorldObject*>& targets)
    {
        targets.remove_if(Acore::PowerCheck(POWER_MANA, false));
    }

    void Register() override
    {
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_mark_of_kazrogal::FilterTargets, EFFECT_0, TARGET_UNIT_SRC_AREA_ENEMY);
    }
};

class spell_mark_of_kazrogal_aura : public AuraScript
{
    PrepareAuraScript(spell_mark_of_kazrogal_aura);

    bool Validate(SpellInfo const* /*spell*/) override
    {
        return ValidateSpellInfo({ SPELL_MARK_DAMAGE });
    }

    void OnPeriodic(AuraEffect const* aurEff)
    {
        Unit* target = GetTarget();

        if ((int32)target->GetPower(POWER_MANA) < aurEff->GetBaseAmount())
        {
            target->CastSpell(target, SPELL_MARK_DAMAGE, true, nullptr, aurEff);
            // Remove aura
            SetDuration(0);
        }
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_mark_of_kazrogal_aura::OnPeriodic, EFFECT_0, SPELL_AURA_PERIODIC_MANA_LEECH);
    }
};

void AddSC_boss_kazrogal()
{
    RegisterHyjalAI(boss_kazrogal);
    RegisterSpellAndAuraScriptPair(spell_mark_of_kazrogal, spell_mark_of_kazrogal_aura);
}

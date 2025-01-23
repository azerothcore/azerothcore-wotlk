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
#include "SpellScriptLoader.h"
#include "black_temple.h"
#include "SpellScript.h"

enum Says
{
    SAY_AGGRO                       = 0,
    SAY_SLAY                        = 1,
    SAY_SPECIAL                     = 2,
    SAY_ENRAGE                      = 3,
    SAY_DEATH                       = 4
};

enum Spells
{
    SPELL_ACIDIC_WOUND              = 40484,
    SPELL_FEL_ACID_BREATH1          = 40508,
    SPELL_FEL_ACID_BREATH2          = 40595,
    SPELL_ARCING_SMASH1             = 40457,
    SPELL_ARCING_SMASH2             = 40599,
    SPELL_EJECT1                    = 40486,
    SPELL_EJECT2                    = 40597,
    SPELL_BEWILDERING_STRIKE        = 40491,
    SPELL_BLOODBOIL                 = 42005,
    SPELL_ACID_GEYSER               = 40630,
    SPELL_BERSERK                   = 45078,
    SPELL_CHARGE                    = 40602,

    SPELL_FEL_GEYSER_SUMMON         = 40569,
    SPELL_FEL_GEYSER_STUN           = 40591,
    SPELL_FEL_GEYSER_DAMAGE         = 40593,

    SPELL_FEL_RAGE_SELF             = 40594,
    SPELL_FEL_RAGE_TARGET           = 40604,
    SPELL_FEL_RAGE_2                = 40616,
    SPELL_FEL_RAGE_3                = 41625,
    SPELL_FEL_RAGE_SIZE             = 46787,
    SPELL_TAUNT_GURTOGG             = 40603,
    SPELL_INSIGNIFICANCE            = 40618
};

enum Misc
{
    EVENT_SPELL_BERSERK             = 1,
    GROUP_DELAY                     = 1
};

// Main boss class
struct boss_gurtogg_bloodboil : public BossAI
{
    boss_gurtogg_bloodboil(Creature* creature) : BossAI(creature, DATA_GURTOGG_BLOODBOIL), _recentlySpoken(false), _inFelRage(false) { }

    void Reset() override
    {
        BossAI::Reset();
        _recentlySpoken = false;
        _inFelRage = false;
    }

    void JustEngagedWith(Unit* who) override
    {
        BossAI::JustEngagedWith(who);
        Talk(SAY_AGGRO);

        // Apply Acidic Wound only outside Fel Rage
        if (!_inFelRage)
            DoCastSelf(SPELL_ACIDIC_WOUND, true);

        // Bloodboil timer - only outside Fel Rage
        ScheduleTimedEvent(10s, [&] {
            if (!_inFelRage) {
                me->CastCustomSpell(SPELL_BLOODBOIL, SPELLVALUE_MAX_TARGETS, 5, me, false);
                DoCastSelf(SPELL_ACIDIC_WOUND, true);
            }
        }, 10s);

        // Fel Acid Breath
        ScheduleTimedEvent(38s, [&] {
            DoCastVictim(me->HasAura(SPELL_FEL_RAGE_SELF) ? SPELL_FEL_ACID_BREATH2 : SPELL_FEL_ACID_BREATH1);
        }, 30s);

        // Eject
        ScheduleTimedEvent(14s, [&] {
            DoCastVictim(me->HasAura(SPELL_FEL_RAGE_SELF) ? SPELL_EJECT2 : SPELL_EJECT1);
        }, 20s);

        // Arcing Smash
        ScheduleTimedEvent(5s, [&] {
            DoCastVictim(me->HasAura(SPELL_FEL_RAGE_SELF) ? SPELL_ARCING_SMASH2 : SPELL_ARCING_SMASH1);
        }, 15s);

        // Fel Rage phase transition
        ScheduleTimedEvent(1min, [&] {
            if (Unit* target = SelectTarget(SelectTargetMethod::Random, 1, 40.0f, true))
            {
                _inFelRage = true;
                me->RemoveAurasByType(SPELL_AURA_MOD_TAUNT);
                
                // Apply Fel Rage effects
                DoCastSelf(SPELL_FEL_RAGE_SELF, true);
                DoCast(target, SPELL_FEL_RAGE_TARGET, true);
                DoCast(target, SPELL_FEL_RAGE_2, true);
                DoCast(target, SPELL_FEL_RAGE_3, true);
                DoCast(target, SPELL_FEL_RAGE_SIZE, true);
                target->CastSpell(me, SPELL_TAUNT_GURTOGG, true);

                // Additional effects
                DoCast(target, SPELL_FEL_GEYSER_SUMMON, true);
                DoCastSelf(SPELL_FEL_GEYSER_STUN, true);
                DoCastSelf(SPELL_INSIGNIFICANCE, true);

                // Delayed charge
                me->m_Events.AddEventAtOffset([&] {
                    DoCastVictim(SPELL_CHARGE);
                }, 2s);

                // End Fel Rage phase after 28 seconds based on fel rage duration
                me->m_Events.AddEventAtOffset([&] {
                    _inFelRage = false;
                }, 28s);

                scheduler.DelayGroup(GROUP_DELAY, 30s);
            }
        }, 90s);

        // Enrage timer
        ScheduleUniqueTimedEvent(10min, [&] {
            Talk(SAY_ENRAGE);
            DoCastSelf(SPELL_BERSERK, true);
        }, EVENT_SPELL_BERSERK);

        // Bewildering Strike
        scheduler.Schedule(28s, [this](TaskContext context) {
            context.SetGroup(GROUP_DELAY);
            DoCastVictim(SPELL_BEWILDERING_STRIKE);
            context.Repeat(30s);
        });
    }

    bool CanAIAttack(Unit const* who) const override
    {
        return !who->IsImmunedToDamage(SPELL_SCHOOL_MASK_ALL) && !who->HasUnitState(UNIT_STATE_CONFUSED);
    }

    void KilledUnit(Unit* /*victim*/) override
    {
        if (!_recentlySpoken)
        {
            Talk(SAY_SLAY);
            me->m_Events.AddEventAtOffset([&] {
                _recentlySpoken = false;
            }, 6s);
        }
    }

    void JustSummoned(Creature* summon) override
    {
        summons.Summon(summon);
        summon->CastSpell(summon, SPELL_FEL_GEYSER_DAMAGE, false);
    }

    void JustDied(Unit* killer) override
    {
        BossAI::JustDied(killer);
        Talk(SAY_DEATH);
    }

    bool CheckEvadeIfOutOfCombatArea() const override
    {
        return me->GetHomePosition().GetExactDist2d(me) > 105.0f;
    }

private:
    bool _recentlySpoken;
    bool _inFelRage;
};

// Bloodboil spell implementation
class spell_gurtogg_bloodboil : public SpellScript
{
    PrepareSpellScript(spell_gurtogg_bloodboil);

    void FilterTargets(std::list<WorldObject*>& targets)
    {
        if (targets.empty())
            return;

        targets.sort(Acore::ObjectDistanceOrderPred(GetCaster(), false));
        if (targets.size() > GetSpellValue()->MaxAffectedTargets)
        {
            std::list<WorldObject*>::iterator itr = targets.begin();
            std::advance(itr, GetSpellValue()->MaxAffectedTargets);
            targets.erase(itr, targets.end());
        }
    }

    void Register() override
    {
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_gurtogg_bloodboil::FilterTargets, EFFECT_ALL, TARGET_UNIT_SRC_AREA_ENEMY);
    }
};

// Eject spell implementation
class spell_gurtogg_eject : public SpellScript
{
    PrepareSpellScript(spell_gurtogg_eject);

    void HandleScriptEffect(SpellEffIndex effIndex)
    {
        PreventHitEffect(effIndex);
        if (Unit* target = GetHitUnit())
            GetCaster()->GetThreatMgr().ModifyThreatByPercent(target, -20);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_gurtogg_eject::HandleScriptEffect, EFFECT_2, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

void AddSC_boss_gurtogg_bloodboil()
{
    RegisterBlackTempleCreatureAI(boss_gurtogg_bloodboil);
    RegisterSpellScript(spell_gurtogg_bloodboil);
    RegisterSpellScript(spell_gurtogg_eject);
}

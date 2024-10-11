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
#include "sethekk_halls.h"

enum Text
{
    SAY_INTRO                   = 0,
    SAY_AGGRO                   = 1,
    SAY_SLAY                    = 2,
    SAY_DEATH                   = 3,
    EMOTE_ARCANE_EXP            = 4
};

enum Spells
{
    SPELL_BLINK                 = 38194,
    SPELL_BLINK_TELEPORT        = 38203,
    SPELL_MANA_SHIELD           = 38151,
    SPELL_ARCANE_BUBBLE         = 9438,
    SPELL_SLOW                  = 35032,
    SPELL_POLYMORPH             = 38245,
    SPELL_ARCANE_VOLLEY         = 35059,
    SPELL_ARCANE_EXPLOSION      = 38197
};

struct boss_talon_king_ikiss : public BossAI
{
    boss_talon_king_ikiss(Creature* creature) : BossAI(creature, DATA_IKISS), _spoken(false)
    {
        scheduler.SetValidator([this]
        {
            return !me->HasUnitState(UNIT_STATE_CASTING);
        });
    }

    void Reset() override
    {
        _Reset();
        _spoken = false;
        ScheduleHealthCheckEvent({ 80, 50, 25 }, [&] {
            me->InterruptNonMeleeSpells(false);
            DoCastAOE(SPELL_BLINK);
            DoCastSelf(SPELL_ARCANE_BUBBLE, true);
            Talk(EMOTE_ARCANE_EXP);
            scheduler.Schedule(1s, [this](TaskContext /*context*/)
            {
                DoCastAOE(SPELL_ARCANE_EXPLOSION);
            }).Schedule(6500ms, [this](TaskContext /*context*/)
            {
                me->GetThreatMgr().ResetAllThreat();
            });
        });

        ScheduleHealthCheckEvent(20, [&] {
            DoCastSelf(SPELL_MANA_SHIELD);
        });
    }

    /// @todo: remove this once pets stop going through doors.
    bool CanAIAttack(Unit const* /*victim*/) const override
    {
        return _spoken;
    }

    void MoveInLineOfSight(Unit* who) override
    {
        if (!_spoken && who->IsPlayer())
        {
            Talk(SAY_INTRO);
            _spoken = true;
        }
        ScriptedAI::MoveInLineOfSight(who);
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        _JustEngagedWith();
        Talk(SAY_AGGRO);
        scheduler.Schedule(5s, [this](TaskContext context)
        {
            DoCastAOE(SPELL_ARCANE_VOLLEY);
            context.Repeat(7s, 12s);
        }).Schedule(8s, [this](TaskContext context)
        {
            SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(SPELL_POLYMORPH);
            if (Unit* target = SelectTarget(SelectTargetMethod::Random, 1, [&](Unit* target) -> bool
                {
                    return target && !target->IsImmunedToSpell(spellInfo);
                }))
            {
                DoCast(target, SPELL_POLYMORPH);
            }
            context.Repeat(15s, 17500ms);
        });
        if (IsHeroic())
        {
            scheduler.Schedule(15s, 25s, [this](TaskContext context)
            {
                DoCastAOE(SPELL_SLOW);
                context.Repeat(15s, 30s);
            });
        }
    }

    void JustDied(Unit* /*killer*/) override
    {
        _JustDied();
        Talk(SAY_DEATH);
        if (GameObject* coffer = instance->GetGameObject(DATA_GO_TALON_KING_COFFER))
        {
            coffer->RemoveGameObjectFlag(GO_FLAG_NOT_SELECTABLE | GO_FLAG_INTERACT_COND);
        }
    }

    void KilledUnit(Unit* victim) override
    {
        if (victim->IsPlayer() && urand(0, 1))
        {
            Talk(SAY_SLAY);
        }
    }

private:
    bool _spoken;
};

// 38194 - Blink
class spell_talon_king_ikiss_blink : public SpellScript
{
    PrepareSpellScript(spell_talon_king_ikiss_blink);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return sSpellMgr->GetSpellInfo(SPELL_BLINK);
    }

    void FilterTargets(std::list<WorldObject*>& targets)
    {
        uint8 maxSize = 1;
        if (targets.size() > maxSize)
        {
            Acore::Containers::RandomResize(targets, maxSize);
        }
    }

    void HandleDummyHitTarget(SpellEffIndex effIndex)
    {
        PreventHitDefaultEffect(effIndex);
        GetHitUnit()->CastSpell(GetCaster(), SPELL_BLINK_TELEPORT, true);
    }

    void Register() override
    {
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_talon_king_ikiss_blink::FilterTargets, EFFECT_0, TARGET_UNIT_SRC_AREA_ENEMY);
        OnEffectHitTarget += SpellEffectFn(spell_talon_king_ikiss_blink::HandleDummyHitTarget, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

void AddSC_boss_talon_king_ikiss()
{
    RegisterSethekkHallsCreatureAI(boss_talon_king_ikiss);
    RegisterSpellScript(spell_talon_king_ikiss_blink);
}

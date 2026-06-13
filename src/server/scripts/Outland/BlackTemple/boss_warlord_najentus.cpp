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
#include "ScriptedCreature.h"
#include "SpellScriptLoader.h"
#include "black_temple.h"
#include "Player.h"
#include "SpellScript.h"

enum Yells
{
    SAY_AGGRO                       = 0,
    SAY_NEEDLE                      = 1,
    SAY_SLAY                        = 2,
    SAY_SPECIAL                     = 3,
    SAY_ENRAGE                      = 4,
    SAY_DEATH                       = 5
};

enum Spells
{
    SPELL_NEEDLE_SPINE              = 39992,
    SPELL_NEEDLE_SPINE_DAMAGE       = 39835,
    SPELL_TIDAL_BURST               = 39878,
    SPELL_TIDAL_SHIELD              = 39872,
    SPELL_IMPALING_SPINE            = 39837,
    SPELL_SUMMON_IMPALING_SPINE     = 39929,
    SPELL_BERSERK                   = 26662,
    SPELL_REMOVE_SPINES             = 40354
};

enum Events
{
    EVENT_TALK_CHECK                = 1,
    EVENT_ENRAGE                    = 2
};

enum Misc
{
    ITEM_NAJENTUS_SPINE             = 32408
};

struct boss_najentus : public BossAI
{
    boss_najentus(Creature* creature) : BossAI(creature, DATA_HIGH_WARLORD_NAJENTUS), _canTalk(true) { }

    void Reset() override
    {
        _Reset();
        me->m_Events.CancelEventGroup(EVENT_ENRAGE);
        DoCastSelf(SPELL_REMOVE_SPINES);
    }

    void JustEngagedWith(Unit* who) override
    {
        _canTalk = true;

        BossAI::JustEngagedWith(who);
        Talk(SAY_AGGRO);
        DoCastSelf(SPELL_REMOVE_SPINES);

        me->m_Events.AddEventAtOffset([this] {
            Talk(SAY_ENRAGE);
            DoCastSelf(SPELL_BERSERK, true);
        }, 8min, EVENT_ENRAGE);

        ScheduleTimedEvent(25s, 100s, [&]
        {
            Talk(SAY_SPECIAL);
        }, 25s, 100s);

        ScheduleTimedEvent(10s, [&]
        {
            me->CastCustomSpell(SPELL_NEEDLE_SPINE, SPELLVALUE_MAX_TARGETS, 3, me, false);
        }, 15s, 15s);

        ScheduleTimedEvent(21s, [&]
        {
            if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 0.0f, false, false))
            {
                DoCast(target, SPELL_IMPALING_SPINE);
                target->CastSpell(target, SPELL_SUMMON_IMPALING_SPINE, true);
                Talk(SAY_NEEDLE);
            }
        }, 20s, 20s);

        ScheduleTimedEvent(1min, [&]
        {
            DoCastSelf(SPELL_TIDAL_SHIELD);
            scheduler.DelayAll(10s);
        }, 1min, 1min);
    }

    void KilledUnit(Unit* victim) override
    {
        if (victim->IsPlayer() && _canTalk)
        {
            Talk(SAY_SLAY);
            _canTalk = false;
            ScheduleUniqueTimedEvent(5s, [&]
            {
                _canTalk = true;
            }, EVENT_TALK_CHECK);
        }
    }

    void JustDied(Unit* killer) override
    {
        BossAI::JustDied(killer);
        me->m_Events.CancelEventGroup(EVENT_ENRAGE);
        Talk(SAY_DEATH);
    }

private:
    bool _canTalk;
};

class spell_najentus_needle_spine : public SpellScript
{
    PrepareSpellScript(spell_najentus_needle_spine);

    void HandleDummy(SpellEffIndex  /*effIndex*/)
    {
        if (Unit* target = GetHitUnit())
            GetCaster()->CastSpell(target, SPELL_NEEDLE_SPINE_DAMAGE, true);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_najentus_needle_spine::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

class spell_najentus_hurl_spine : public SpellScript
{
    PrepareSpellScript(spell_najentus_hurl_spine);

    void HandleSchoolDamage(SpellEffIndex  /*effIndex*/)
    {
        Unit* target = GetHitUnit();
        if (target && target->HasAura(SPELL_TIDAL_SHIELD))
        {
            target->RemoveAurasDueToSpell(SPELL_TIDAL_SHIELD);
            target->CastSpell(target, SPELL_TIDAL_BURST, true);
        }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_najentus_hurl_spine::HandleSchoolDamage, EFFECT_0, SPELL_EFFECT_SCHOOL_DAMAGE);
    }
};

class spell_najentus_remove_spines : public SpellScript
{
    PrepareSpellScript(spell_najentus_remove_spines);

    void RemoveSpines()
    {
        if (Unit* caster = GetCaster())
        {
            caster->GetMap()->DoForAllPlayers([&](Player* player)
            {
                player->DestroyItemCount(ITEM_NAJENTUS_SPINE, 5, true);
            });
        }
    }

    void Register() override
    {
        OnCast += SpellCastFn(spell_najentus_remove_spines::RemoveSpines);
    }
};

void AddSC_boss_najentus()
{
    RegisterBlackTempleCreatureAI(boss_najentus);
    RegisterSpellScript(spell_najentus_needle_spine);
    RegisterSpellScript(spell_najentus_hurl_spine);
    RegisterSpellScript(spell_najentus_remove_spines);
}

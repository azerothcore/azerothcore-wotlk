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

#include "ScriptMgr.h"
#include "scholomance.h"
#include "ScriptedCreature.h"
#include "SpellScript.h"
#include "TaskScheduler.h"

enum Spells
{
    SPELL_SHADOWBOLT_VOLLEY             = 20741,
    SPELL_BONE_SHIELD                   = 27688,

    SPELL_SUMMON_BONE_MAGES             = 27695,

    SPELL_SUMMON_BONE_MAGE_FRONT_LEFT   = 27696,
    SPELL_SUMMON_BONE_MAGE_FRONT_RIGHT  = 27697,
    SPELL_SUMMON_BONE_MAGE_BACK_RIGHT   = 27698,
    SPELL_SUMMON_BONE_MAGE_BACK_LEFT    = 27699,

    SPELL_SUMMON_BONE_MINION1           = 27690,
    SPELL_SUMMON_BONE_MINION2           = 27691,
    SPELL_SUMMON_BONE_MINION3           = 27692,
    SPELL_SUMMON_BONE_MINION4           = 27693,

    SPELL_SUMMON_BONE_MINIONS           = 27687
};

enum Events
{
    EVENT_SHADOWBOLT_VOLLEY = 1,
    EVENT_SUMMON_MINIONS
};

enum Says
{
    TALK_SUMMON     = 0,
    TALK_AGGRO      = 1,
    TALK_ENRAGE     = 2,
    TALK_DEATH      = 3
};

struct boss_kormok : public ScriptedAI
{
    boss_kormok(Creature* creature) : ScriptedAI(creature), _summons(creature) {}

    void Reset() override
    {
        _mages = false;

        _scheduler.CancelAll();
        _scheduler.SetValidator([this]
        {
            return !me->HasUnitState(UNIT_STATE_CASTING);
        });

        _summons.DespawnAll();
    }

    void IsSummonedBy(Unit* /*summoner*/) override
    {
        Talk(TALK_SUMMON);

        _scheduler.Schedule(2s, [this](TaskContext context)
        {
            DoCastSelf(SPELL_BONE_SHIELD);
            context.Repeat(45s);
        });
    }

    void EnterCombat(Unit* /*who*/) override
    {
        Talk(TALK_AGGRO);

        _scheduler.Schedule(10s, [this](TaskContext context)
        {
            DoCastVictim(SPELL_SHADOWBOLT_VOLLEY);
            context.Repeat(15s);
        })
        .Schedule(15s, [this](TaskContext context)
        {
            DoCast(SPELL_SUMMON_BONE_MINIONS);
            context.Repeat(12s);
        });
    }

    void JustSummoned(Creature* summon) override
    {
        _summons.Summon(summon);
        DoZoneInCombat(summon);
    }

    void SummonedCreatureDespawn(Creature* summon) override
    {
        _summons.Despawn(summon);
    }

    void DamageTaken(Unit* /*attacker*/, uint32& damage, DamageEffectType /*damageType*/, SpellSchoolMask /*damageSchoolMask*/) override
    {
        if (!_mages && me->HealthBelowPctDamaged(25, damage))
        {
            _mages = true;

            Talk(TALK_ENRAGE);

            DoCast(SPELL_SUMMON_BONE_MAGES);
        }
    }

    void JustDied(Unit* /*killer*/) override
    {
        Talk(TALK_DEATH);
    }

    void UpdateAI(uint32 diff) override
    {
        _scheduler.Update(diff);

        if (!UpdateVictim())
        {
            return;
        }

        DoMeleeAttackIfReady();
    }

    private:
        TaskScheduler _scheduler;
        SummonList _summons;
        bool _mages;
};

uint32 const SummonMageSpells[4] =
{
    SPELL_SUMMON_BONE_MAGE_FRONT_LEFT,
    SPELL_SUMMON_BONE_MAGE_FRONT_RIGHT,
    SPELL_SUMMON_BONE_MAGE_BACK_RIGHT,
    SPELL_SUMMON_BONE_MAGE_BACK_LEFT,
};

// 27695 - Summon Bone Mages
class spell_kormok_summon_bone_mages : public SpellScript
{
    PrepareSpellScript(spell_kormok_summon_bone_mages);

    bool Validate(SpellInfo const* /*spell*/) override
    {
        return ValidateSpellInfo(SummonMageSpells);
    }

    void HandleScript(SpellEffIndex effIndex)
    {
        PreventHitDefaultEffect(effIndex);

        for (uint32 i = 0; i < 2; ++i)
        {
            GetCaster()->CastSpell(GetCaster(), SummonMageSpells[urand(0, 3)], true);
        }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_kormok_summon_bone_mages::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

// 27687 - Summon Bone Minions
class spell_kormok_summon_bone_minions : public SpellScript
{
    PrepareSpellScript(spell_kormok_summon_bone_minions);

    bool Validate(SpellInfo const* /*spell*/) override
    {
        return ValidateSpellInfo({ SPELL_SUMMON_BONE_MINIONS });
    }

    void HandleScript(SpellEffIndex effIndex)
    {
        PreventHitDefaultEffect(effIndex);

        // Possible spells to handle this not found.
        for (uint32 i = 0; i < 4; ++i)
        {
            GetCaster()->CastSpell(GetCaster(), SPELL_SUMMON_BONE_MINION1 + i, true);
        }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_kormok_summon_bone_minions::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

void AddSC_boss_kormok()
{
    RegisterScholomanceCreatureAI(boss_kormok);
    RegisterSpellScript(spell_kormok_summon_bone_mages);
    RegisterSpellScript(spell_kormok_summon_bone_minions);
}

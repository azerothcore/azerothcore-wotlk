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
#include "arcatraz.h"

enum Say
{
    SAY_AGGRO                       = 0,
    SAY_SLAY                        = 1,
    SAY_SHADOW_NOVA                 = 2,
    SAY_DEATH                       = 3
};

enum Spells
{
    SPELL_VOID_ZONE                 = 36119,
    SPELL_SHADOW_NOVA               = 36127,
    SPELL_SEED_OF_CORRUPTION        = 36123,
    SPELL_CORRUPTION_PROC           = 32865
};

struct boss_zereketh_the_unbound : public BossAI
{
    boss_zereketh_the_unbound(Creature* creature) : BossAI(creature, DATA_ZEREKETH) { }

    void JustDied(Unit* /*killer*/) override
    {
        _JustDied();
        Talk(SAY_DEATH);
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        _JustEngagedWith();
        Talk(SAY_AGGRO);

        scheduler.Schedule(11s, 29s, [this](TaskContext context)
        {
            DoCastRandomTarget(SPELL_VOID_ZONE, 0, 60.0f);
            context.Repeat();
        }).Schedule(12s, 22s, [this](TaskContext context)
        {
            DoCastAOE(SPELL_SHADOW_NOVA);
            if (roll_chance_i(50))
            {
                Talk(SAY_SHADOW_NOVA);
            }
            context.Repeat();
        }).Schedule(6s, 12s, [this](TaskContext context)
        {
            DoCastRandomTarget(SPELL_SEED_OF_CORRUPTION, 0, 30.0f);
            context.Repeat(13s, 27s);
        });
    }

    void KilledUnit(Unit* victim) override
    {
        if (victim->IsPlayer())
        {
            Talk(SAY_SLAY);
        }
    }
};

// 36123, 39367 -- Seed of Corruption
class spell_zereketh_seed_of_corruption: public AuraScript
{
    PrepareAuraScript(spell_zereketh_seed_of_corruption);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_CORRUPTION_PROC });
    }

    void HandleProc(AuraEffect const* /*aurEff*/, ProcEventInfo& /*eventInfo*/)
    {
        PreventDefaultAction();
        uint32 val = GetSpellInfo()->GetEffect(EFFECT_1).BasePoints;
        GetTarget()->RemoveAurasDueToSpell(GetSpellInfo()->Id);

        if (GetCaster())
        {
            GetCaster()->CastCustomSpell(SPELL_CORRUPTION_PROC, SPELLVALUE_BASE_POINT0, val, GetTarget(), true);
        }
    }

    void Register() override
    {
        OnEffectProc += AuraEffectProcFn(spell_zereketh_seed_of_corruption::HandleProc, EFFECT_1, SPELL_AURA_DUMMY);
    }
};

void AddSC_boss_zereketh_the_unbound()
{
    RegisterArcatrazCreatureAI(boss_zereketh_the_unbound);
    RegisterSpellScript(spell_zereketh_seed_of_corruption);
}


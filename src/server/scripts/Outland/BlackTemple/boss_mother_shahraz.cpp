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
#include "GridNotifiers.h"
#include "SpellAuraEffects.h"
#include "SpellScript.h"

enum Says
{
    SAY_TAUNT                       = 0,
    SAY_AGGRO                       = 1,
    SAY_SPELL                       = 2,
    SAY_SLAY                        = 3,
    SAY_ENRAGE                      = 4,
    SAY_DEATH                       = 5,
    SAY_EMOTE_FRENZY                = 6
};

enum Spells
{
    SPELL_PRISMATIC_AURA_SHADOW     = 40880,
    SPELL_PRISMATIC_AURA_FIRE       = 40882,
    SPELL_PRISMATIC_AURA_NATURE     = 40883,
    SPELL_PRISMATIC_AURA_ARCANE     = 40891,
    SPELL_PRISMATIC_AURA_FROST      = 40896,
    SPELL_PRISMATIC_AURA_HOLY       = 40897,
    SPELL_SABER_LASH_AURA           = 40816,
    SPELL_SABER_LASH                = 40810,
    SPELL_SILENCING_SHRIEK          = 40823,
    SPELL_RANDOM_PERIODIC           = 40867,
    SPELL_SINFUL_PERIODIC           = 40862,
    SPELL_SINISTER_PERIODIC         = 40863,
    SPELL_VILE_PERIODIC             = 40865,
    SPELL_WICKED_PERIODIC           = 40866,
    SPELL_FATAL_ATTRACTION          = 40869,
    SPELL_FATAL_ATTRACTION_AURA     = 41001,
    SPELL_FATAL_ATTRACTION_DAMAGE   = 40871,
    SPELL_ENRAGE                    = 45078,
    SPELL_SABER_LASH_IMMUNITY       = 43690
};

enum Misc
{
    GROUP_ENRAGE                    = 1
};

struct boss_mother_shahraz : public BossAI
{
    boss_mother_shahraz(Creature* creature) : BossAI(creature, DATA_MOTHER_SHAHRAZ), _canTalk(true) { }

    void Reset() override
    {
        _Reset();
        me->m_Events.CancelEventGroup(GROUP_ENRAGE);
        _canTalk = true;

        ScheduleHealthCheckEvent(10, [&] {
            Talk(SAY_EMOTE_FRENZY);
        });
    }

    void JustEngagedWith(Unit* who) override
    {
        BossAI::JustEngagedWith(who);
        Talk(SAY_AGGRO);
        DoCastSelf(SPELL_SABER_LASH_AURA, true);
        DoCastSelf(SPELL_RANDOM_PERIODIC, true);

        ScheduleTimedEvent(4s, [&] {
            DoCastVictim(SPELL_SABER_LASH);
        }, 30s);

        ScheduleTimedEvent(1min, [&] {
            Talk(SAY_TAUNT);
        }, 1min, 2min);

        ScheduleTimedEvent(0s, [&] {
            DoCastSelf(RAND(SPELL_PRISMATIC_AURA_SHADOW, SPELL_PRISMATIC_AURA_FIRE, SPELL_PRISMATIC_AURA_NATURE, SPELL_PRISMATIC_AURA_ARCANE, SPELL_PRISMATIC_AURA_FROST, SPELL_PRISMATIC_AURA_HOLY));
        }, 15s);

        ScheduleTimedEvent(30s, [&] {
            DoCastAOE(SPELL_SILENCING_SHRIEK);
        }, 30s);

        ScheduleTimedEvent(50s, [&] {
            Talk(SAY_SPELL);
            DoCast(SPELL_FATAL_ATTRACTION);
        }, 1min);

        me->m_Events.AddEventAtOffset([&] {
            DoCastSelf(SPELL_ENRAGE, true);
            Talk(SAY_ENRAGE);
        }, 10min, GROUP_ENRAGE);
    }

    void KilledUnit(Unit* /*victim*/) override
    {
        if (_canTalk)
        {
            Talk(SAY_SLAY);
            _canTalk = false;

            ScheduleUniqueTimedEvent(6s, [&] {
                _canTalk = true;
            }, 1);
        }
    }

    void JustDied(Unit* killer) override
    {
        BossAI::JustDied(killer);
        me->m_Events.CancelEventGroup(GROUP_ENRAGE);
        Talk(SAY_DEATH);
    }

    private:
        bool _canTalk;
};

class spell_mother_shahraz_random_periodic_aura : public AuraScript
{
    PrepareAuraScript(spell_mother_shahraz_random_periodic_aura);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_SINFUL_PERIODIC, SPELL_SINISTER_PERIODIC, SPELL_VILE_PERIODIC, SPELL_WICKED_PERIODIC });
    }

    void Update(AuraEffect const* effect)
    {
        PreventDefaultAction();
        if (GetUnitOwner() && (effect->GetTickNumber() % 6 == 1 || effect->GetTickNumber() == 1)) // Reapplies 12-18s after the third beam
            GetUnitOwner()->CastSpell(GetUnitOwner(), RAND(SPELL_SINFUL_PERIODIC, SPELL_SINISTER_PERIODIC, SPELL_VILE_PERIODIC, SPELL_WICKED_PERIODIC), true);
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_mother_shahraz_random_periodic_aura::Update, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
    }
};

class spell_mother_shahraz_beam_periodic_aura : public AuraScript
{
    PrepareAuraScript(spell_mother_shahraz_beam_periodic_aura);

    void Update(AuraEffect const* effect)
    {
        PreventDefaultAction();
        if (Unit* target = GetUnitOwner()->GetAI()->SelectTarget(SelectTargetMethod::Random, 0))
            GetUnitOwner()->CastSpell(target, GetSpellInfo()->Effects[effect->GetEffIndex()].TriggerSpell, true);
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_mother_shahraz_beam_periodic_aura::Update, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
    }
};

class spell_mother_shahraz_saber_lash_aura : public AuraScript
{
    PrepareAuraScript(spell_mother_shahraz_saber_lash_aura);

    bool CheckProc(ProcEventInfo&  /*eventInfo*/)
    {
        return false;
    }

    void Update(AuraEffect const* effect)
    {
        PreventDefaultAction();
        if (Unit* target = GetUnitOwner()->GetVictim())
            GetUnitOwner()->CastSpell(target, GetSpellInfo()->Effects[effect->GetEffIndex()].TriggerSpell, true);
    }

    void Register() override
    {
        DoCheckProc += AuraCheckProcFn(spell_mother_shahraz_saber_lash_aura::CheckProc);
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_mother_shahraz_saber_lash_aura::Update, EFFECT_1, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
    }
};

constexpr float minTeleportDistSq = 30.f * 30.f;
constexpr float maxTeleportDistSq = 50.f * 50.f;

const Position teleportPositions[79] =
{
    {918.581, 110.065, 192.849},
    {943.493, 108.279, 192.847},
    {964.335, 109.774, 192.836},
    {971.987, 148.678, 192.820},
    {956.107, 146.804, 197.075},
    {934.990, 144.492, 197.075},
    {916.477, 143.932, 192.829},
    {921.147, 167.942, 192.827},
    {925.678, 184.302, 192.838},
    {940.993, 181.637, 192.463},
    {948.525, 193.635, 191.906},
    {965.403, 179.717, 192.832},
    {966.440, 197.428, 192.840},
    {959.519, 218.769, 192.846},
    {943.849, 208.796, 191.209},
    {931.741, 199.204, 192.846},
    {931.808, 220.284, 192.845},
    {945.203, 232.269, 191.208},
    {966.960, 236.315, 192.842},
    {966.079, 258.634, 192.822},
    {945.193, 252.556, 191.208},
    {924.433, 235.585, 192.842},
    {919.422, 250.186, 192.820},
    {923.024, 271.408, 192.368},
    {928.982, 283.581, 192.368},
    {923.807, 302.435, 192.854},
    {925.547, 316.368, 192.830},
    {922.124, 330.724, 192.842},
    {926.061, 343.538, 192.848},
    {947.211, 351.582, 191.208},
    {965.287, 351.110, 192.850},
    {964.311, 340.715, 192.850},
    {971.435, 328.932, 192.850},
    {979.385, 318.413, 192.843},
    {962.361, 304.283, 192.839},
    {964.359, 287.723, 192.835},
    {961.600, 270.791, 192.829},
    {945.802, 267.542, 191.208},
    {948.130, 284.002, 191.208},
    {940.823, 299.090, 191.208},
    {949.039, 314.410, 191.208},
    {941.133, 334.733, 191.208},
    {956.045, 329.034, 192.834},
    {956.605, 247.336, 192.828},
    {931.937, 244.108, 192.819},
    {938.510, 158.778, 197.075},
    {928.364, 208.923, 192.847},
    {962.436, 205.330, 192.847},
    {955.670, 346.279, 192.849},
    {931.286, 324.910, 192.819},
    {962.375, 317.202, 192.838},
    {956.159, 292.589, 192.834},
    {934.550, 274.786, 192.368},
    {921.056, 287.731, 192.368},
    {956.248, 262.074, 192.829},
    {955.738, 231.656, 192.836},
    {934.566, 231.991, 192.838},
    {956.050, 198.811, 192.841},
    {939.707, 193.020, 191.923},
    {940.500, 259.348, 191.208},
    {948.237, 304.773, 191.208},
    {923.764, 176.246, 192.832},
    {960.474, 187.324, 192.833},
    {968.408, 168.684, 192.825},
    {967.788, 126.891, 192.822},
    {930.301, 118.605, 192.847},
    {952.902, 159.420, 197.075},
    {931.728, 291.711, 192.368},
    {950.031, 276.024, 191.208},
    {943.486, 243.084, 191.208},
    {950.499, 223.192, 191.208},
    {940.605, 218.999, 191.208},
    {949.264, 183.562, 192.380},
    {950.100, 207.404, 191.241},
    {969.982, 187.897, 192.837},
    {931.661, 185.178, 192.831},
    {924.498, 193.739, 192.847},
    {966.774, 226.680, 192.847},
    {953.118, 121.170, 192.822},
 };

class spell_mother_shahraz_fatal_attraction : public SpellScript
{
    PrepareSpellScript(spell_mother_shahraz_fatal_attraction);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_FATAL_ATTRACTION_AURA });
    }

    void FilterTargets(std::list<WorldObject*>& targets)
    {
        Acore::Containers::RandomResize(targets, 3);
        targets.remove_if(Acore::UnitAuraCheck(true, SPELL_SABER_LASH_IMMUNITY));
    }

    void SetDest(SpellDestination& dest)
    {
        Position casterPos = GetCaster()->GetPosition();
        std::vector<Position> validTeleportPositions;
        std::copy_if(std::begin(teleportPositions), std::end(teleportPositions), std::back_inserter(validTeleportPositions),
            [&](Position const& pos) {
            float distanceSq = pos.GetExactDist2dSq(casterPos);
            return minTeleportDistSq <= distanceSq  && distanceSq <= maxTeleportDistSq;
        });
        if (validTeleportPositions.empty())
        {
            LOG_ERROR("scripts", "spell_mother_shahraz_fatal_attraction: No valid teleport positions found (Map: {} X: {} Y: {} Z: {})",
                GetCaster()->GetMap()->GetId(), GetCaster()->GetPositionX(), GetCaster()->GetPositionY(), GetCaster()->GetPositionZ());
            return;
         }
        Position finalDest = validTeleportPositions[urand(0, validTeleportPositions.size() - 1)];
        dest.Relocate(finalDest);
    }

    void HandleTeleportUnits(SpellEffIndex  /*effIndex*/)
    {
        if (Unit* target = GetHitUnit())
            GetCaster()->CastSpell(target, SPELL_FATAL_ATTRACTION_AURA, true);
    }

    void Register() override
    {
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_mother_shahraz_fatal_attraction::FilterTargets, EFFECT_ALL, TARGET_UNIT_SRC_AREA_ENEMY);
        OnDestinationTargetSelect += SpellDestinationTargetSelectFn(spell_mother_shahraz_fatal_attraction::SetDest, EFFECT_1, TARGET_DEST_CASTER);
        OnEffectHitTarget += SpellEffectFn(spell_mother_shahraz_fatal_attraction::HandleTeleportUnits, EFFECT_1, SPELL_EFFECT_TELEPORT_UNITS);
    }
};

class spell_mother_shahraz_fatal_attraction_dummy : public SpellScript
{
    PrepareSpellScript(spell_mother_shahraz_fatal_attraction_dummy);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_FATAL_ATTRACTION_DAMAGE, SPELL_FATAL_ATTRACTION_AURA });
    }

    void FilterTargets(std::list<WorldObject*>& targets)
    {
        if (targets.empty())
            GetCaster()->RemoveAurasDueToSpell(SPELL_FATAL_ATTRACTION_AURA);
    }

    void HandleDummy(SpellEffIndex  /*effIndex*/)
    {
        if (Unit* caster = GetCaster())
            if (AuraEffect* aurEff = caster->GetAuraEffect(SPELL_FATAL_ATTRACTION_AURA, EFFECT_1))
            {
                if (aurEff->GetTickNumber() <= 2)
                {
                    int32 damage = 1000 * aurEff->GetTickNumber();
                    caster->CastCustomSpell(caster, SPELL_FATAL_ATTRACTION_DAMAGE, &damage, 0, 0, true);
                }
                else
                    caster->CastSpell(caster, SPELL_FATAL_ATTRACTION_DAMAGE, true);
            }
    }

    void Register() override
    {
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_mother_shahraz_fatal_attraction_dummy::FilterTargets, EFFECT_ALL, TARGET_UNIT_SRC_AREA_ALLY);
        OnEffectHitTarget += SpellEffectFn(spell_mother_shahraz_fatal_attraction_dummy::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

void AddSC_boss_mother_shahraz()
{
    RegisterBlackTempleCreatureAI(boss_mother_shahraz);
    RegisterSpellScript(spell_mother_shahraz_random_periodic_aura);
    RegisterSpellScript(spell_mother_shahraz_beam_periodic_aura);
    RegisterSpellScript(spell_mother_shahraz_saber_lash_aura);
    RegisterSpellScript(spell_mother_shahraz_fatal_attraction);
    RegisterSpellScript(spell_mother_shahraz_fatal_attraction_dummy);
}

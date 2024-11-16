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
            me->CastCustomSpell(SPELL_FATAL_ATTRACTION, SPELLVALUE_MAX_TARGETS, 3, me, false);
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

const Position validTeleportStairsPos[9] =
{
    //Platform teleports

    {945.00f, 149.17f, 197.07483},
    {956.92f, 153.20f, 197.07483},
    {933.69f, 154.15f, 197.07483},

    //Floor teleports

    {966.87f, 184.45f, 192.84f},
    {927.22f, 187.04f, 192.84f},
    {922.54f, 110.09f, 192.84f},
    {958.01f, 110.47f, 192.84f},
    {939.95f, 108.29f, 192.84f},
    {945.68f, 205.74f, 192.84f}
};

constexpr float minTeleportDist = 30.f;
constexpr float maxTeleportDist = 50.f;

class spell_mother_shahraz_fatal_attraction : public SpellScript
{
    PrepareSpellScript(spell_mother_shahraz_fatal_attraction);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_FATAL_ATTRACTION_AURA });
    }

    void FilterTargets(std::list<WorldObject*>& targets)
    {
        targets.remove_if(Acore::UnitAuraCheck(true, SPELL_SABER_LASH_IMMUNITY));
    }

    void SetDest(SpellDestination& dest)
    {
        Position finalDest;

        // Check if the boss is near stairs to avoid players falling through the platform with random teleports.
        if (GetCaster()->GetPositionY() < 194.f)
            finalDest = validTeleportStairsPos[urand(0, 8)];
        else
        {
            finalDest = GetCaster()->GetNearPosition(frand(minTeleportDist, maxTeleportDist), static_cast<float>(rand_norm()) * static_cast<float>(2 * M_PI), true);

            // Maybe not necessary but just in case to avoid LOS issues with an object
            if (!GetCaster()->IsWithinLOS(finalDest.GetPositionX(), finalDest.GetPositionY(), finalDest.GetPositionZ()))
                finalDest = GetCaster()->GetNearPosition(frand(minTeleportDist, maxTeleportDist), static_cast<float>(rand_norm()) * static_cast<float>(2 * M_PI), true);

            /* @note: To avoid teleporting players near a walls, we will define a safe area.
             * As the boss have an area boudary around y: 320.f. We will limit the safe area to this value, avoiding wird issues.
             * x limit: 932.f/960.f | y limit: 224.f/320.f
             */
            if (finalDest.m_positionX < 932.f)
                finalDest.m_positionX = 932.f;
            else if (finalDest.m_positionX > 960.f)
                finalDest.m_positionX = 960.f;

            if (finalDest.m_positionY < 224.f)
                finalDest.m_positionY = 224.f;
            else if (finalDest.m_positionY > 320.f)
                finalDest.m_positionY = 320.f;

            // After relocate a finalDest outside the safe area, we need to recheck the distance with the boss
            if (GetCaster()->GetExactDist2d(finalDest) < minTeleportDist)
            {
                if (finalDest.m_positionX == 932.f || finalDest.m_positionX == 960.f)
                    finalDest.m_positionY = finalDest.m_positionY + (minTeleportDist - GetCaster()->GetExactDist2d(finalDest));
                else if (finalDest.m_positionY == 224.f || finalDest.m_positionY == 320.f)
                    finalDest.m_positionX = finalDest.m_positionX + (minTeleportDist - GetCaster()->GetExactDist2d(finalDest));
            }
        }

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
        OnDestinationTargetSelect += SpellDestinationTargetSelectFn(spell_mother_shahraz_fatal_attraction::SetDest, EFFECT_1, TARGET_DEST_CASTER_RANDOM);
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

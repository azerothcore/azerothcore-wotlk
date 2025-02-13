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
#include "Player.h"
#include "ScriptedCreature.h"
#include "SpellAuraEffects.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "WorldSession.h"
#include "sunwell_plateau.h"

enum Yells
{
    SAY_SATH_AGGRO                              = 0,
    SAY_SATH_SLAY                               = 1,
    SAY_SATH_DEATH                              = 2,
    SAY_SATH_SPELL1                             = 3,
    SAY_SATH_SPELL2                             = 4,

    SAY_EVIL_AGGRO                              = 0,
    SAY_EVIL_SLAY                               = 1,
    SAY_GOOD_PLRWIN                             = 2,
    SAY_EVIL_ENRAGE                             = 3,
    SAY_SATH_ENRAGE_ME                          = 4,
    SAY_KALEC_ENRAGE_SATH                       = 5,

    SAY_GOOD_AGGRO                              = 0,
    SAY_GOOD_NEAR_DEATH                         = 1,
    SAY_GOOD_NEAR_DEATH2                        = 2,
    SAY_GOOD_MADRIGOSA                          = 3 // Madrigosa deserved a far better fate. You did what had to be done, but this battle is far from over!
};

enum Spells
{
    SPELL_SPECTRAL_EXHAUSTION           = 44867,
    SPELL_SPECTRAL_BLAST                = 44869,
    SPELL_SPECTRAL_BLAST_PORTAL         = 44866,
    SPELL_SPECTRAL_BLAST_AA             = 46648,
    SPELL_TELEPORT_SPECTRAL             = 46019,

    SPELL_TELEPORT_NORMAL_REALM         = 46020,
    SPELL_SPECTRAL_REALM                = 46021,
    SPELL_SPECTRAL_INVISIBILITY         = 44801,
    SPELL_DEMONIC_VISUAL                = 44800,

    SPELL_ARCANE_BUFFET                 = 45018,
    SPELL_FROST_BREATH                  = 44799,
    SPELL_TAIL_LASH                     = 45122,

    SPELL_BANISH                        = 44836,
    SPELL_TRANSFORM_KALEC               = 44670,
    SPELL_CRAZED_RAGE                   = 44807,

    SPELL_CORRUPTION_STRIKE             = 45029,
    SPELL_CURSE_OF_BOUNDLESS_AGONY      = 45032,
    SPELL_CURSE_OF_BOUNDLESS_AGONY_PLR  = 45034,
    SPELL_SHADOW_BOLT                   = 45031,

    SPELL_HEROIC_STRIKE                 = 45026,
    SPELL_REVITALIZE                    = 45027
};

enum SWPActions
{
    ACTION_ENRAGE                       = 1,
    ACTION_BANISH                       = 2,
    ACTION_SATH_BANISH                  = 3,
    ACTION_KALEC_DIED                   = 4,
    ACTION_ENRAGE_OTHER                 = 5,
};

#define DRAGON_REALM_Z  53.079f

struct boss_kalecgos : public BossAI
{
    boss_kalecgos(Creature* creature) : BossAI(creature, DATA_KALECGOS)
    {
        SetInvincibility(true);
    }

    bool CanAIAttack(Unit const* target) const override
    {
        return target->GetPositionZ() > 50.0f;
    }

    bool CheckInRoom() override
    {
        if (me->GetDistance(me->GetHomePosition()) > 50.0f)
            return false;

        return true;
    }

    void Reset() override
    {
        BossAI::Reset();
        me->SetFullHealth();
        me->SetStandState(UNIT_STAND_STATE_SLEEP);
        me->SetDisableGravity(false);
        me->SetReactState(REACT_AGGRESSIVE);
        me->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE);

        _sathBanished = false;
        ClearPlayerAuras();

        ScheduleHealthCheckEvent(10, [&] {
            if (Creature* Sath = instance->GetCreature(DATA_SATHROVARR))
                Sath->AI()->DoAction(ACTION_ENRAGE_OTHER);
            DoAction(ACTION_ENRAGE);
        });

        ScheduleHealthCheckEvent(1, [&] {
            DoAction(ACTION_BANISH);
        });
    }

    void ClearPlayerAuras() const
    {
        instance->DoRemoveAurasDueToSpellOnPlayers(SPELL_CURSE_OF_BOUNDLESS_AGONY);
        instance->DoRemoveAurasDueToSpellOnPlayers(SPELL_CURSE_OF_BOUNDLESS_AGONY_PLR);
        instance->DoRemoveAurasDueToSpellOnPlayers(SPELL_SPECTRAL_REALM);
    }

    void DoAction(int32 param) override
    {
        if (param == ACTION_ENRAGE || param == ACTION_ENRAGE_OTHER)
        {
            Talk(param == ACTION_ENRAGE ? SAY_KALEC_ENRAGE_SATH : SAY_SATH_ENRAGE_ME);
            DoCastSelf(SPELL_CRAZED_RAGE, true);
            return;
        }
        else if (param == ACTION_BANISH)
        {
            DoCastSelf(SPELL_BANISH, true);
            scheduler.CancelAll();
        }
        else if (param == ACTION_SATH_BANISH)
            _sathBanished = true;
        else if (param == ACTION_KALEC_DIED)
        {
            scheduler.CancelAll();

            me->m_Events.AddEventAtOffset([&] {
                me->SetReactState(REACT_PASSIVE);
                me->CombatStop();
                me->RemoveAllAuras();
                me->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                Talk(SAY_EVIL_ENRAGE);
            }, 1s);

            me->m_Events.AddEventAtOffset([&] {
                me->SetDisableGravity(true);
                me->HandleEmoteCommand(EMOTE_ONESHOT_LIFTOFF);
            }, 4s);

            me->m_Events.AddEventAtOffset([&] {
                EnterEvadeMode();
            }, 9s);

            ClearPlayerAuras();
            return;
        }

        if (me->HasAura(SPELL_BANISH) && _sathBanished)
        {
            scheduler.CancelAll();

            me->m_Events.AddEventAtOffset([&] {
                me->SetRegeneratingHealth(false);
                me->RemoveAllAuras();
                me->SetReactState(REACT_PASSIVE);
                me->CombatStop();
                me->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                me->SetFaction(FACTION_FRIENDLY);
            }, 1s);

            me->m_Events.AddEventAtOffset([&] {
                if (Creature* Sath = instance->GetCreature(DATA_SATHROVARR))
                {
                    summons.Despawn(Sath);
                    Unit::Kill(me, Sath);
                }
            }, 2s);

            Talk(SAY_GOOD_PLRWIN, 10s);

            me->m_Events.AddEventAtOffset([&] {
                me->SetDisableGravity(true);
                me->HandleEmoteCommand(EMOTE_ONESHOT_LIFTOFF);
            }, 15s);

            me->m_Events.AddEventAtOffset([&] {
                me->SetVisible(false);
                me->KillSelf();
            }, 20s);

            ClearPlayerAuras();
            if (Creature* Sath = instance->GetCreature(DATA_SATHROVARR))
            {
                Sath->RemoveAllAuras();
                Sath->GetMotionMaster()->MovementExpired();
                Sath->SetReactState(REACT_PASSIVE);
                Sath->NearTeleportTo(1696.20f, 915.0f, DRAGON_REALM_Z, Sath->GetOrientation());
            }
        }
    }

    void JustEngagedWith(Unit* who) override
    {
        BossAI::JustEngagedWith(who);

        ScheduleTimedEvent(6s, [&] {
            DoCastAOE(SPELL_ARCANE_BUFFET);
        }, 8s);

        ScheduleTimedEvent(15s, [&] {
            DoCastVictim(SPELL_FROST_BREATH);
        }, 15s);

        ScheduleTimedEvent(10s, [&] {
            me->CastCustomSpell(RAND(44978, 45001, 45002, 45004, 45006, 45010), SPELLVALUE_MAX_TARGETS, 1, me, false);
        }, 20s);

        ScheduleTimedEvent(25s, [&] {
            DoCastVictim(SPELL_TAIL_LASH);
        }, 15s);

        ScheduleTimedEvent(20s, [&] {
            DoCastAOE(SPELL_SPECTRAL_BLAST);
        }, 15s, 25s);

        scheduler.Schedule(16s, [this](TaskContext)
        {
            if (Creature* kalec = me->SummonCreature(NPC_KALEC, 1702.21f, 931.7f, -74.56f, 5.07f, TEMPSUMMON_MANUAL_DESPAWN))
                kalec->CastSpell(kalec, SPELL_SPECTRAL_INVISIBILITY, true);

            me->SummonCreature(NPC_SATHROVARR, 1704.62f, 927.78f, -73.9f, 2.0f, TEMPSUMMON_MANUAL_DESPAWN);
        });

        me->SetStandState(UNIT_STAND_STATE_STAND);
        Talk(SAY_EVIL_AGGRO);
    }

    void KilledUnit(Unit* victim) override
    {
        if (victim->IsPlayer() && roll_chance_i(50))
            Talk(SAY_EVIL_SLAY);
    }

    private:
        bool _sathBanished;
};

struct boss_kalec : public ScriptedAI
{
    boss_kalec(Creature* creature) : ScriptedAI(creature) { }

    void JustEngagedWith(Unit*) override
    {
        ScheduleTimedEvent(5s, [&] {
            DoCastSelf(SPELL_REVITALIZE);
        }, 10s);

        ScheduleTimedEvent(3s, [&] {
            DoCastVictim(SPELL_HEROIC_STRIKE);
        }, 5s);

        scheduler.Schedule(1s, [this](TaskContext context)
        {
            if (me->HealthBelowPct(50))
                Talk(SAY_GOOD_NEAR_DEATH);
            else
                context.Repeat();
        });

        scheduler.Schedule(1s, [this](TaskContext context)
        {
            if (me->HealthBelowPct(10))
                Talk(SAY_GOOD_NEAR_DEATH2);
            else
                context.Repeat();
        });

        Talk(SAY_GOOD_AGGRO);
    }

    void JustDied(Unit*) override
    {
        if (InstanceScript* instance = me->GetInstanceScript())
            if (Creature* kalecgos = instance->GetCreature(DATA_KALECGOS))
                kalecgos->AI()->DoAction(ACTION_KALEC_DIED);
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;

        scheduler.Update(diff,
            std::bind(&BossAI::DoMeleeAttackIfReady, this));
    }
};

struct boss_sathrovarr : public ScriptedAI
{
    boss_sathrovarr(Creature* creature) : ScriptedAI(creature)
    {
        _instance = creature->GetInstanceScript();
        SetInvincibility(true);
    }

    bool CanAIAttack(Unit const* target) const override
    {
        return target->GetPositionZ() < 50.0f;
    }

    void Reset() override
    {
        DoCastSelf(SPELL_DEMONIC_VISUAL, true);
        DoCastSelf(SPELL_SPECTRAL_INVISIBILITY, true);
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        Talk(SAY_SATH_AGGRO);

        ScheduleTimedEvent(7s, [&] {
            if (roll_chance_i(20))
                Talk(SAY_SATH_SPELL1);
            DoCastVictim(SPELL_SHADOW_BOLT);
        }, 9s);

        ScheduleTimedEvent(20s, [&] {
            me->CastCustomSpell(SPELL_CURSE_OF_BOUNDLESS_AGONY, SPELLVALUE_MAX_TARGETS, 1, me, false);
        }, 30s);

        ScheduleTimedEvent(20s, [&] {
            if (roll_chance_i(20))
                Talk(SAY_SATH_SPELL2);
            DoCastVictim(SPELL_CORRUPTION_STRIKE);
        }, 9s);

        scheduler.Schedule(1s, [this](TaskContext context)
        {
            if (me->HealthBelowPct(10))
            {
                if (Creature* kalecgos = _instance->GetCreature(DATA_KALECGOS))
                    kalecgos->AI()->DoAction(ACTION_ENRAGE_OTHER);
                DoAction(ACTION_ENRAGE);
            }
            else
                context.Repeat();
        });

        scheduler.Schedule(1s, [this](TaskContext context)
        {
            if (me->HealthBelowPct(1))
            {
                if (Creature* kalecgos = _instance->GetCreature(DATA_KALECGOS))
                    kalecgos->AI()->DoAction(ACTION_SATH_BANISH);
                DoAction(ACTION_BANISH);
            }
            else
                context.Repeat();
        });
    }

    void KilledUnit(Unit* target) override
    {
        if (target->IsPlayer())
            Talk(SAY_SATH_SLAY);
    }

    void JustDied(Unit* /*killer*/) override
    {
        Talk(SAY_SATH_DEATH);
    }

    void DoAction(int32 param) override
    {
        if (param == ACTION_ENRAGE || param == ACTION_ENRAGE_OTHER)
            DoCastSelf(SPELL_CRAZED_RAGE, true);
        else if (param == ACTION_BANISH)
            DoCastSelf(SPELL_BANISH, true);
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;

        scheduler.Update(diff,
            std::bind(&BossAI::DoMeleeAttackIfReady, this));
    }

private:
    InstanceScript* _instance;
};

class SpectralBlastCheck
{
public:
    SpectralBlastCheck(Unit* victim) : _victim(victim) { }

    bool operator()(WorldObject* unit)
    {
        return unit->GetPositionZ() < 50.0f || unit->ToUnit()->HasAura(SPELL_SPECTRAL_EXHAUSTION) || unit->GetGUID() == _victim->GetGUID();
    }
private:
    Unit* _victim;
};

class spell_kalecgos_spectral_blast_dummy : public SpellScript
{
    PrepareSpellScript(spell_kalecgos_spectral_blast_dummy);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_SPECTRAL_BLAST_PORTAL, SPELL_SPECTRAL_BLAST_AA, SPELL_TELEPORT_SPECTRAL });
    }

    void FilterTargets(std::list<WorldObject*>& targets)
    {
        targets.remove_if(SpectralBlastCheck(GetCaster()->GetVictim()));
        Acore::Containers::RandomResize(targets, 1);
    }

    void HandleDummy(SpellEffIndex effIndex)
    {
        PreventHitDefaultEffect(effIndex);
        if (Unit* target = GetHitUnit())
        {
            target->CastSpell(target, SPELL_SPECTRAL_BLAST_PORTAL, true);
            target->CastSpell(target, SPELL_SPECTRAL_BLAST_AA, true);
            target->CastSpell(target, SPELL_TELEPORT_SPECTRAL, true);
        }
    }

    void Register() override
    {
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_kalecgos_spectral_blast_dummy::FilterTargets, EFFECT_0, TARGET_UNIT_SRC_AREA_ENEMY);
        OnEffectHitTarget += SpellEffectFn(spell_kalecgos_spectral_blast_dummy::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

class spell_kalecgos_curse_of_boundless_agony_aura : public AuraScript
{
    PrepareAuraScript(spell_kalecgos_curse_of_boundless_agony_aura);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_CURSE_OF_BOUNDLESS_AGONY_PLR });
    }

    void OnRemove(AuraEffect const*  /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        if (InstanceScript* instance = GetUnitOwner()->GetInstanceScript())
            if (instance->IsEncounterInProgress())
                GetUnitOwner()->CastCustomSpell(SPELL_CURSE_OF_BOUNDLESS_AGONY_PLR, SPELLVALUE_MAX_TARGETS, 1, GetUnitOwner(), true);
    }

    void OnPeriodic(AuraEffect const* aurEff)
    {
        if (aurEff->GetTickNumber() > 1 && aurEff->GetTickNumber() % 5 == 1)
            GetAura()->GetEffect(aurEff->GetEffIndex())->SetAmount(aurEff->GetAmount() * 2);
    }

    void Register() override
    {
        AfterEffectRemove += AuraEffectRemoveFn(spell_kalecgos_curse_of_boundless_agony_aura::OnRemove, EFFECT_0, SPELL_AURA_PERIODIC_DAMAGE, AURA_EFFECT_HANDLE_REAL);
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_kalecgos_curse_of_boundless_agony_aura::OnPeriodic, EFFECT_0, SPELL_AURA_PERIODIC_DAMAGE);
    }
};

class spell_kalecgos_spectral_realm_dummy : public SpellScript
{
    PrepareSpellScript(spell_kalecgos_spectral_realm_dummy);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_SPECTRAL_EXHAUSTION, SPELL_TELEPORT_SPECTRAL });
    }

    SpellCastResult CheckCast()
    {
        if (GetCaster()->HasAura(SPELL_SPECTRAL_EXHAUSTION))
            return SPELL_FAILED_CASTER_AURASTATE;

        return SPELL_CAST_OK;
    }

    void HandleScriptEffect(SpellEffIndex effIndex)
    {
        PreventHitDefaultEffect(effIndex);
        GetCaster()->CastSpell(GetCaster(), SPELL_TELEPORT_SPECTRAL, true);
    }

    void Register() override
    {
        OnCheckCast += SpellCheckCastFn(spell_kalecgos_spectral_realm_dummy::CheckCast);
        OnEffectHitTarget += SpellEffectFn(spell_kalecgos_spectral_realm_dummy::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

class spell_kalecgos_spectral_realm_aura : public AuraScript
{
    PrepareAuraScript(spell_kalecgos_spectral_realm_aura);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_SPECTRAL_EXHAUSTION, SPELL_TELEPORT_NORMAL_REALM });
    }

    void OnRemove(AuraEffect const*  /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        GetUnitOwner()->CastSpell(GetUnitOwner(), SPELL_SPECTRAL_EXHAUSTION, true);
        GetUnitOwner()->CastSpell(GetUnitOwner(), SPELL_TELEPORT_NORMAL_REALM, true);
    }

    void Register() override
    {
        OnEffectRemove += AuraEffectRemoveFn(spell_kalecgos_spectral_realm_aura::OnRemove, EFFECT_1, SPELL_AURA_MOD_INVISIBILITY, AURA_EFFECT_HANDLE_REAL);
    }
};

void AddSC_boss_kalecgos()
{
    RegisterSunwellPlateauCreatureAI(boss_kalecgos);
    RegisterSunwellPlateauCreatureAI(boss_sathrovarr);
    RegisterSunwellPlateauCreatureAI(boss_kalec);
    RegisterSpellScript(spell_kalecgos_spectral_blast_dummy);
    RegisterSpellScript(spell_kalecgos_curse_of_boundless_agony_aura);
    RegisterSpellScript(spell_kalecgos_spectral_realm_dummy);
    RegisterSpellScript(spell_kalecgos_spectral_realm_aura);
}

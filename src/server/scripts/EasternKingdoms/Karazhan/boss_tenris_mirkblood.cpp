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

#include "karazhan.h"
#include "AreaTriggerScript.h"
#include "CreatureScript.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "SpellInfo.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "UnitAI.h"

enum Text
{
    SAY_APPROACH = 0,
    SAY_AGGRO    = 1,
    SAY_SUMMON   = 2
};

enum Spells
{
    SPELL_BLOOD_MIRROR0                  = 50844, // clone, proc 1206
    SPELL_BLOOD_MIRROR1                  = 50845, // script, dummy, dummy
    SPELL_BLOOD_MIRROR_TARGET_PICKER     = 50883, // script
    SPELL_BLOOD_MIRROR_TRANSITION_VISUAL = 50910, // dummy
    SPELL_BLOOD_MIRROR_DAMAGE            = 50846, // damage

    SPELL_BLOOD_TAP = 51135, // drain health

    SPELL_BLOOD_SWOOP                             = 50922, // charge, periodic damage, trigger 50925
    SPELL_DASH_GASH_PRE_SPELL                     = 50923, // script, trigger 50922
    SPELL_DASH_GASH_RETURN_TO_TANK                = 50924, // charge
    SPELL_DASH_GASH_RETURN_TO_TANK_PRE_SPELL      = 50925, // null
    SPELL_DASH_GASH_RETURN_TO_TANK_PRE_SPELL_ROOT = 50932, // null

    SPELL_DESPAWN_SANGUINE_SPIRIT_VISUAL             = 51214, // dummy
    SPELL_DESPAWN_SANGUINE_SPIRITS                   = 51212, // script, dummy
    SPELL_SANGUINE_SPIRIT_AURA                       = 50993, // dummy, periodic trigger 51013
    SPELL_SANGUINE_SPIRIT_PRE_AURA                   = 51282, // dummy
    SPELL_SANGUINE_SPIRIT_PRE_AURA2                  = 51283, // size mod
    SPELL_SUMMON_SANGUINE_SPIRIT0                    = 50996, // null
    SPELL_SUMMON_SANGUINE_SPIRIT1                    = 50998, // trigger missile 50996
    SPELL_SUMMON_SANGUINE_SPIRIT2                    = 51204, // trigger missile 50996
    SPELL_SUMMON_SANGUINE_SPIRIT_MISSILE_BURST       = 51208, // periodic trigger 50998
    SPELL_SUMMON_SANGUINE_SPIRIT_SHORT_MISSILE_BURST = 51280, // periodic trigger 50998
    SPELL_SUMMON_SANGUINE_SPIRIT_ON_KILL             = 51205, // dummy
    SPELL_EXSANGUINATE                               = 51013, // damage
};

struct boss_tenris_mirkblood : public BossAI
{
    boss_tenris_mirkblood(Creature* creature) : BossAI(creature, DATA_MIRKBLOOD)
    {
        scheduler.SetValidator([this]
            {
                return !me->HasUnitState(UNIT_STATE_CASTING);
            });
    }

    void Reset() override
    {
        _Reset();

        ScheduleHealthCheckEvent(50, [&] {
            Talk(SAY_SUMMON);
            DoCast(SPELL_SUMMON_SANGUINE_SPIRIT_MISSILE_BURST);
            });

        ScheduleHealthCheckEvent(45, [&] {
            scheduler.Schedule(10s, 15s, [this](TaskContext context)
                {
                    DoCast(SPELL_BLOOD_TAP);
                    context.Repeat(15s, 40s);
                });
            });

        scheduler.CancelAll();
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        Talk(SAY_AGGRO);
        DoZoneInCombat();

        ScheduleTimedEvent(1s, 5s, [&] {
            // Blood Mirror
            DoCast(SPELL_BLOOD_MIRROR_TARGET_PICKER);
            }, 20s, 50s);
        ScheduleTimedEvent(30s, [&] {
            // Blood Swoop
            DoCast(SPELL_DASH_GASH_PRE_SPELL);
            }, 15s, 40s);
        ScheduleTimedEvent(6s, 15s, [&] {
            // Sanguine Spirit
            DoCast(SPELL_SUMMON_SANGUINE_SPIRIT_SHORT_MISSILE_BURST);
            }, 6s, 15s);
    }

    /*
    void JustSummoned(Creature* summoned) override
    {
    }

    void KilledUnit(Unit* victim) override
    {
    }
    */

    void DamageTaken(Unit* attacker, uint32& damage, DamageEffectType damageType, SpellSchoolMask damageSchoolMask) override
    {
        BossAI::DamageTaken(attacker, damage, damageType, damageSchoolMask);

        if (!me->HasAura(SPELL_BLOOD_MIRROR0))
            return;

        if (!_mirrorTarget)
            return;

        int32 damageTaken = damage;

        me->CastCustomSpell(_mirrorTarget, SPELL_BLOOD_MIRROR_DAMAGE, &damageTaken, &damageTaken, &damageTaken, true, nullptr, nullptr, me->GetGUID());
    }

    void SpellHit(Unit* caster, SpellInfo const* spell) override
    {
        LOG_ERROR("sql.sql", "spell hit!");
        if (spell->Id == SPELL_BLOOD_MIRROR0 && caster != me)
            _mirrorTarget = caster;
    }

private:
    Unit* _mirrorTarget = nullptr;
};

class spell_mirkblood_blood_mirror : public SpellScript
{
    PrepareSpellScript(spell_mirkblood_blood_mirror)

    void HandleCast()
    {
        LOG_ERROR("sql.sql", "blood mirror hit");

        if (!GetCaster())
            return;
    }

    void Register() override
    {
        OnCast += SpellCastFn(spell_mirkblood_blood_mirror::HandleCast);
    }
};

class spell_mirkblood_blood_mirror_target_picker : public SpellScript
{
    PrepareSpellScript(spell_mirkblood_blood_mirror_target_picker)

    bool Validate(SpellInfo const* /*spell*/) override
    {
        return ValidateSpellInfo({ SPELL_BLOOD_MIRROR0, SPELL_BLOOD_MIRROR1, SPELL_BLOOD_MIRROR_TRANSITION_VISUAL });
    }

    void HandleHit()
    {
        LOG_ERROR("sql.sql", "target picker hit");

        Unit* caster = GetCaster();

        if (!caster->ToCreature())
            return;

        Unit* target = caster->GetAI()->SelectTarget(SelectTargetMethod::Random, 0, 0.0f, true, false);

        if (!target) // Only Blood Mirror the tank if they're the only one around
            target = caster->GetVictim();

        if (!target)
            return;

        caster->CastSpell(caster, SPELL_BLOOD_MIRROR_TRANSITION_VISUAL, TRIGGERED_FULL_MASK);
        caster->CastSpell(target, SPELL_BLOOD_MIRROR_TRANSITION_VISUAL, TRIGGERED_FULL_MASK);

        caster->AddAura(SPELL_BLOOD_MIRROR1, caster); // Should be a cast, but channeled spell results in either Mirkblood or player being unactionable
        caster->AddAura(SPELL_BLOOD_MIRROR1, target); // Adding aura manually causes visual to not appear properly, but better than breaking gameplay

        target->CastSpell(caster, SPELL_BLOOD_MIRROR0); // Clone player
    }

    void Register() override
    {
        OnCast += SpellCastFn(spell_mirkblood_blood_mirror_target_picker::HandleHit);
    }
};

class spell_mirkblood_dash_gash_return_to_tank_pre_spell : public SpellScript
{
    PrepareSpellScript(spell_mirkblood_dash_gash_return_to_tank_pre_spell)

    bool Validate(SpellInfo const* /*spell*/) override
    {
        return ValidateSpellInfo({ SPELL_DASH_GASH_RETURN_TO_TANK });
    }

    void HandleCast()
    {
        LOG_ERROR("sql.sql", "dash gash hit");
        if (!GetCaster() || !GetCaster()->GetThreatMgr().GetCurrentVictim())
            return;
        // Probably wrong, maybe don't charge if would charge the same target?
        if (GetCaster()->GetDistance2d(GetCaster()->GetThreatMgr().GetCurrentVictim()) < 5.0f)
            return;

        GetCaster()->CastSpell(GetCaster()->GetVictim(), SPELL_DASH_GASH_RETURN_TO_TANK);
    }

    void Register() override
    {
        OnCast += SpellCastFn(spell_mirkblood_dash_gash_return_to_tank_pre_spell::HandleCast);
    }
};

class spell_mirkblood_summon_sanguine_spirit : public SpellScript
{
    PrepareSpellScript(spell_mirkblood_summon_sanguine_spirit)

    void HandleSummon(SpellEffIndex /*effIndex*/)
    {
        LOG_ERROR("sql.sql", "sanguine spirit hit");
    }

    void Register() override
    {
        OnEffectHit += SpellEffectFn(spell_mirkblood_summon_sanguine_spirit::HandleSummon, EFFECT_ALL, SPELL_EFFECT_SUMMON);
    }
};

class at_karazhan_mirkblood_approach : public AreaTriggerScript
{
public:
    at_karazhan_mirkblood_approach() : AreaTriggerScript("at_karazhan_mirkblood_approach") {}

    bool OnTrigger(Player* player, AreaTrigger const* /*trigger*/) override
    {
        if (InstanceScript* instance = player->GetInstanceScript())
            if (instance->GetBossState(DATA_MIRKBLOOD) != DONE)
                if (Creature* mirkblood = instance->GetCreature(DATA_MIRKBLOOD))
                    mirkblood->AI()->Talk(SAY_APPROACH, player);

        return false;
    }
};

class at_karazhan_mirkblood_entrance : public OnlyOnceAreaTriggerScript
{
public:
    at_karazhan_mirkblood_entrance() : OnlyOnceAreaTriggerScript("at_karazhan_mirkblood_entrance") {}

    bool _OnTrigger(Player* player, AreaTrigger const* /*trigger*/) override
    {
        if (InstanceScript* instance = player->GetInstanceScript())
            if (instance->GetBossState(DATA_MIRKBLOOD) != DONE)
                if (Creature* mirkblood = instance->GetCreature(DATA_MIRKBLOOD))
                {
                    // AREA TRIGGER 5015 MAY ENGAGE OR JUST RELEASE NOT_SELECTABLE FLAG
                    mirkblood->Talk(std::string_view("gwuh"), CHAT_MSG_MONSTER_YELL, LANG_UNIVERSAL, 100.0f, mirkblood);
                }

        return false;
    }
};

void AddSC_boss_tenris_mirkblood()
{
    RegisterKarazhanCreatureAI(boss_tenris_mirkblood);
    RegisterSpellScript(spell_mirkblood_blood_mirror);
    RegisterSpellScript(spell_mirkblood_blood_mirror_target_picker);
    RegisterSpellScript(spell_mirkblood_dash_gash_return_to_tank_pre_spell);
    RegisterSpellScript(spell_mirkblood_summon_sanguine_spirit);
    new at_karazhan_mirkblood_approach();
    new at_karazhan_mirkblood_entrance();
}

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

#include "karazhan.h"
#include "AreaTriggerScript.h"
#include "CreatureScript.h"
#include "GameObjectAI.h"
#include "GameObjectScript.h"
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
    SPELL_BLOOD_MIRROR0                  = 50844,
    SPELL_BLOOD_MIRROR1                  = 50845,
    SPELL_BLOOD_MIRROR_TARGET_PICKER     = 50883,
    SPELL_BLOOD_MIRROR_TRANSITION_VISUAL = 50910,
    SPELL_BLOOD_MIRROR_DAMAGE            = 50846,

    SPELL_BLOOD_TAP = 51135,

    SPELL_BLOOD_SWOOP                             = 50922,
    SPELL_DASH_GASH_PRE_SPELL                     = 50923,
    SPELL_DASH_GASH_RETURN_TO_TANK                = 50924,
    // SPELL_DASH_GASH_RETURN_TO_TANK_PRE_SPELL      = 50925,
    // SPELL_DASH_GASH_RETURN_TO_TANK_PRE_SPELL_ROOT = 50932,

    SPELL_DESPAWN_SANGUINE_SPIRIT_VISUAL             = 51214,
    SPELL_DESPAWN_SANGUINE_SPIRITS                   = 51212,
    SPELL_SANGUINE_SPIRIT_AURA                       = 50993,
    SPELL_SANGUINE_SPIRIT_PRE_AURA                   = 51282,
    SPELL_SANGUINE_SPIRIT_PRE_AURA2                  = 51283,
    SPELL_SUMMON_SANGUINE_SPIRIT0                    = 50996,
    SPELL_SUMMON_SANGUINE_SPIRIT1                    = 50998,
    // SPELL_SUMMON_SANGUINE_SPIRIT2                 = 51204,
    SPELL_SUMMON_SANGUINE_SPIRIT_MISSILE_BURST       = 51208,
    SPELL_SUMMON_SANGUINE_SPIRIT_SHORT_MISSILE_BURST = 51280,
    SPELL_SUMMON_SANGUINE_SPIRIT_ON_KILL             = 51205,
    SPELL_EXSANGUINATE                               = 51013,
    SPELL_DUMMY_NUKE_RANGE_SELF                      = 51106,
};

enum Events
{
    EVENT_SAY  = 1,
    EVENT_FLAG = 2
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

        me->SetImmuneToPC(true);

        ScheduleHealthCheckEvent(50, [&] {
            Talk(SAY_SUMMON);
            DoCast(SPELL_SUMMON_SANGUINE_SPIRIT_MISSILE_BURST);
            });

        ScheduleHealthCheckEvent(45, [&] {
            ScheduleTimedEvent(10s, 15s, [&] {
                DoCast(SPELL_BLOOD_TAP);
                }, 15s, 40s);
            });
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
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

    void KilledUnit(Unit* victim) override
    {
        if (!victim)
            return;

        DoCast(victim, SPELL_SUMMON_SANGUINE_SPIRIT_ON_KILL);

        if (!_mirrorTarget)
            return;

        if (victim == _mirrorTarget)
        {
            me->RemoveAurasDueToSpell(SPELL_BLOOD_MIRROR0);
            me->RemoveAurasDueToSpell(SPELL_BLOOD_MIRROR1);
        }
    }

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
        if (spell->Id == SPELL_BLOOD_MIRROR0 && caster != me)
            _mirrorTarget = caster;
    }

    void EnterEvadeMode(EvadeReason why) override
    {
        _EnterEvadeMode(why);
        me->SetImmuneToPC(false);
    }

private:
    Unit* _mirrorTarget = nullptr;
};

struct npc_sanguine_spirit : public ScriptedAI
{
    npc_sanguine_spirit(Creature* creature) : ScriptedAI(creature) {}

    void Reset() override
    {
        scheduler.CancelAll();
        me->ApplySpellImmune(0, IMMUNITY_SCHOOL, SPELL_SCHOOL_MASK_ALL, true);

        me->SetReactState(REACT_PASSIVE);

        DoCastSelf(SPELL_SANGUINE_SPIRIT_PRE_AURA);

        scheduler.Schedule(5s, [this](TaskContext /*context*/)
        {
            DoCastSelf(SPELL_SANGUINE_SPIRIT_PRE_AURA2);
        }).Schedule(3s, [this](TaskContext /*context*/)
        {
            me->SetReactState(REACT_AGGRESSIVE);
            me->SetInCombatWithZone();
            DoCastSelf(SPELL_SANGUINE_SPIRIT_AURA);
        }).Schedule(30s, [this](TaskContext /*context*/)
        {
            me->DespawnOrUnsummon();
        });
    }

    void UpdateAI(uint32 diff) override
    {
        scheduler.Update(diff);
        UpdateVictim();
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

class spell_mirkblood_exsanguinate : public SpellScript
{
    PrepareSpellScript(spell_mirkblood_exsanguinate)

    void CalculateDamage()
    {
        if (!GetHitUnit())
            return;

        SetHitDamage(std::max((GetHitUnit()->GetHealth() * 0.66f), 2000.0f));
    }

    void Register() override
    {
        OnHit += SpellHitFn(spell_mirkblood_exsanguinate::CalculateDamage);
    }
};

class at_karazhan_mirkblood_approach : public AreaTriggerScript
{
public:
    at_karazhan_mirkblood_approach() : AreaTriggerScript("at_karazhan_mirkblood_approach") {}

    bool OnTrigger(Player* player, AreaTrigger const* /*trigger*/) override
    {
        if (InstanceScript* instance = player->GetInstanceScript())
            if (Creature* mirkblood = instance->GetCreature(DATA_MIRKBLOOD))
                if (mirkblood->IsAlive() && !mirkblood->IsInCombat())
                    mirkblood->AI()->Talk(SAY_APPROACH, player);

        return false;
    }
};

class at_karazhan_mirkblood_entrance : public AreaTriggerScript
{
public:
    at_karazhan_mirkblood_entrance() : AreaTriggerScript("at_karazhan_mirkblood_entrance") {}

    bool OnTrigger(Player* player, AreaTrigger const* /*trigger*/) override
    {
        if (InstanceScript* instance = player->GetInstanceScript())
            if (Creature* mirkblood = instance->GetCreature(DATA_MIRKBLOOD))
                if (mirkblood->IsAlive() && mirkblood->IsImmuneToPC())
                    mirkblood->SetImmuneToPC(false);

        return false;
    }
};

class go_blood_drenched_door : public GameObjectScript
{
public:
    go_blood_drenched_door() : GameObjectScript("go_blood_drenched_door") {}

    struct go_blood_drenched_doorAI : public GameObjectAI
    {
        go_blood_drenched_doorAI(GameObject* go) : GameObjectAI(go) {}

        EventMap events;
        Creature* mirkblood;
        Player* opener;

        bool GossipHello(Player* player, bool /*reportUse*/) override
        {
            events.Reset();

            if (InstanceScript* instance = player->GetInstanceScript())
            {
                if (instance->GetBossState(DATA_MIRKBLOOD) != DONE)
                {
                    opener = player;
                    mirkblood = instance->GetCreature(DATA_MIRKBLOOD);

                    events.ScheduleEvent(EVENT_SAY, 1s);
                    events.ScheduleEvent(EVENT_FLAG, 5s);
                }
            }

            me->SetGameObjectFlag(GO_FLAG_NOT_SELECTABLE);

            return true;
        }

        void UpdateAI(uint32 diff) override
        {
            if (events.Empty())
                return;

            events.Update(diff);
            switch (events.ExecuteEvent())
            {
            case EVENT_SAY:
                if (!mirkblood || !mirkblood->IsAlive())
                    return;
                mirkblood->AI()->Talk(SAY_AGGRO, opener);
                break;
            case EVENT_FLAG:
                if (mirkblood)
                    mirkblood->SetImmuneToPC(false);
                me->Delete();
                break;
            }
        }
    };

    GameObjectAI* GetAI(GameObject* go) const override
    {
        return new go_blood_drenched_doorAI(go);
    }
};

void AddSC_boss_tenris_mirkblood()
{
    RegisterKarazhanCreatureAI(boss_tenris_mirkblood);
    RegisterKarazhanCreatureAI(npc_sanguine_spirit);
    RegisterSpellScript(spell_mirkblood_blood_mirror_target_picker);
    RegisterSpellScript(spell_mirkblood_dash_gash_return_to_tank_pre_spell);
    RegisterSpellScript(spell_mirkblood_exsanguinate);
    new at_karazhan_mirkblood_approach();
    new at_karazhan_mirkblood_entrance();
    new go_blood_drenched_door();
}

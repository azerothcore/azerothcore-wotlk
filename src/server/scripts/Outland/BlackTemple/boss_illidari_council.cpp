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
#include "Player.h"
#include "SpellAuraEffects.h"
#include "SpellScript.h"

enum Says
{
    SAY_COUNCIL_AGGRO                   = 0,
    SAY_COUNCIL_ENRAGE                  = 1,
    SAY_COUNCIL_SPECIAL                 = 2,
    SAY_COUNCIL_SLAY                    = 3,
    SAY_COUNCIL_DEATH                   = 4
};

enum Spells
{
    SPELL_EMPYREAL_BALANCE              = 41499,
    SPELL_BERSERK                       = 41924,

    // Gathios the Shatterer
    SPELL_BLESSING_OF_PROTECTION        = 41450,
    SPELL_BLESSING_OF_SPELL_WARDING     = 41451,
    SPELL_CONSECRATION                  = 41541,
    SPELL_HAMMER_OF_JUSTICE             = 41468,
    SPELL_SEAL_OF_COMMAND               = 41469,
    SPELL_SEAL_OF_BLOOD                 = 41459,
    SPELL_CHROMATIC_RESISTANCE_AURA     = 41453,
    SPELL_DEVOTION_AURA                 = 41452,
    SPELL_JUDGEMENT                     = 41467,

    // High Nethermancer Zerevor
    SPELL_FLAMESTRIKE                   = 41481,
    SPELL_BLIZZARD                      = 41482,
    SPELL_ARCANE_BOLT                   = 41483,
    SPELL_ARCANE_EXPLOSION              = 41524,
    SPELL_DAMPEN_MAGIC                  = 41478,

    // Lady Malande
    SPELL_EMPOWERED_SMITE               = 41471,
    SPELL_CIRCLE_OF_HEALING             = 41455,
    SPELL_REFLECTIVE_SHIELD             = 41475,
    SPELL_REFLECTIVE_SHIELD_T           = 33619,
    SPELL_DIVINE_WRATH                  = 41472,
    SPELL_HEAL_VISUAL                   = 24171,

    // Veras Darkshadow
    SPELL_DEADLY_STRIKE                 = 41480,
    SPELL_DEADLY_POISON                 = 41485,
    SPELL_ENVENOM                       = 41487,
    SPELL_VANISH                        = 41476,
    SPELL_VANISH_OUT                    = 41479,
    SPELL_VANISH_VISUAL                 = 24222
};

enum Misc
{
    ACTION_START_ENCOUNTER              = 1,
    ACTION_END_ENCOUNTER                = 2,
    ACTION_ENRAGE                       = 3,

    EVENT_SPELL_BLESSING                = 1,
    EVENT_SPELL_AURA                    = 2,
    EVENT_SPELL_SEAL                    = 3,
    EVENT_SPELL_HAMMER_OF_JUSTICE       = 4,
    EVENT_SPELL_JUDGEMENT               = 5,
    EVENT_SPELL_CONSECRATION            = 6,

    EVENT_SPELL_FLAMESTRIKE             = 10,
    EVENT_SPELL_BLIZZARD                = 11,
    EVENT_SPELL_ARCANE_BOLT             = 12,
    EVENT_SPELL_DAMPEN_MAGIC            = 13,
    EVENT_SPELL_ARCANE_EXPLOSION        = 14,

    EVENT_SPELL_REFLECTIVE_SHIELD       = 20,
    EVENT_SPELL_CIRCLE_OF_HEALING       = 21,
    EVENT_SPELL_DIVINE_WRATH            = 22,
    EVENT_SPELL_EMPOWERED_SMITE         = 23,

    EVENT_SPELL_VANISH                  = 30,
    EVENT_SPELL_VANISH_OUT              = 31,
    EVENT_SPELL_ENRAGE                  = 32,

    EVENT_KILL_TALK                     = 100
};

class VerasEnvenom : public BasicEvent
{
public:
    VerasEnvenom(Unit& owner, ObjectGuid targetGUID) : _owner(owner), _targetGUID(targetGUID) { }

    bool Execute(uint64 /*eventTime*/, uint32 /*updateTime*/) override
    {
        if (Player* target = ObjectAccessor::GetPlayer(_owner, _targetGUID))
        {
            target->m_clientGUIDs.insert(_owner.GetGUID());
            _owner.CastSpell(target, SPELL_ENVENOM, true);
            target->RemoveAurasDueToSpell(SPELL_DEADLY_POISON);
            target->m_clientGUIDs.erase(_owner.GetGUID());
        }
        return true;
    }

private:
    Unit& _owner;
    ObjectGuid _targetGUID;
};

struct boss_illidari_council : public BossAI
{
    boss_illidari_council(Creature* creature) : BossAI(creature, DATA_ILLIDARI_COUNCIL) { }

    void EnterEvadeMode(EvadeReason why) override
    {
        for (uint8 i = DATA_GATHIOS_THE_SHATTERER; i <= DATA_VERAS_DARKSHADOW; ++i)
            if (Creature* member = instance->GetCreature(i))
                member->AI()->EnterEvadeMode();

        BossAI::EnterEvadeMode(why);
    }

    void AttackStart(Unit*) override { }
    void MoveInLineOfSight(Unit*) override { }

    void DoAction(int32 param) override
    {
        if (!me->isActiveObject() && param == ACTION_START_ENCOUNTER)
        {
            me->setActive(true);

            bool spoken = false;
            for (uint8 i = DATA_GATHIOS_THE_SHATTERER; i <= DATA_VERAS_DARKSHADOW; ++i)
            {
                if (Creature* member = instance->GetCreature(i))
                {
                    if (!spoken && (roll_chance_i(33) || i == 3))
                    {
                        spoken = true;
                        member->AI()->Talk(SAY_COUNCIL_AGGRO);
                    }
                    member->SetOwnerGUID(me->GetGUID());
                    member->SetInCombatWithZone();
                }
            }
        }
        else if (param == ACTION_ENRAGE)
        {
            for (uint8 i = DATA_GATHIOS_THE_SHATTERER; i <= DATA_VERAS_DARKSHADOW; ++i)
                if (Creature* member = instance->GetCreature(i))
                    member->AI()->DoAction(ACTION_ENRAGE);
        }
        else if (param == ACTION_END_ENCOUNTER)
        {
            me->setActive(false);
            for (uint8 i = DATA_GATHIOS_THE_SHATTERER; i <= DATA_VERAS_DARKSHADOW; ++i)
                if (Creature* member = instance->GetCreature(i))
                    if (member->IsAlive())
                        Unit::Kill(me, member);
            me->KillSelf();
        }
    }

    void UpdateAI(uint32  /*diff*/) override
    {
        if (!me->isActiveObject())
            return;

        if (!SelectTargetFromPlayerList(115.0f))
        {
            EnterEvadeMode(EVADE_REASON_NO_HOSTILES);
            return;
        }

        me->CastSpell(me, SPELL_EMPYREAL_BALANCE, true);
    }
};

struct boss_illidari_council_memberAI : public ScriptedAI
{
    boss_illidari_council_memberAI(Creature* creature) : ScriptedAI(creature)
    {
        instance = creature->GetInstanceScript();
        SetBoundary(instance->GetBossBoundary(DATA_ILLIDARI_COUNCIL));
    }

    InstanceScript* instance;
    EventMap events;

    void Reset() override
    {
        events.Reset();
    }

    void EnterEvadeMode(EvadeReason why) override
    {
        me->SetOwnerGUID(ObjectGuid::Empty);
        ScriptedAI::EnterEvadeMode(why);
    }

    void DoAction(int32 param) override
    {
        if (param == ACTION_ENRAGE)
        {
            me->CastSpell(me, SPELL_BERSERK, true);
            Talk(SAY_COUNCIL_ENRAGE);
        }
    }

    void KilledUnit(Unit*) override
    {
        if (events.GetNextEventTime(EVENT_KILL_TALK) == 0)
        {
            Talk(SAY_COUNCIL_SLAY);
            events.ScheduleEvent(EVENT_KILL_TALK, 6000);
        }
    }

    void JustDied(Unit*) override
    {
        Talk(SAY_COUNCIL_DEATH);
        if (Creature* council = instance->GetCreature(DATA_ILLIDARI_COUNCIL))
            council->GetAI()->DoAction(ACTION_END_ENCOUNTER);
    }

    void JustEngagedWith(Unit*  /*who*/) override
    {
        if (Creature* council = instance->GetCreature(DATA_ILLIDARI_COUNCIL))
            council->GetAI()->DoAction(ACTION_START_ENCOUNTER);
    }
};

struct boss_gathios_the_shatterer : public boss_illidari_council_memberAI
{
    boss_gathios_the_shatterer(Creature* creature) : boss_illidari_council_memberAI(creature)
    {
        _toggleBlessing = RAND(true, false);
        _toggleAura = RAND(true, false);
        _toggleSeal = RAND(true, false);
    }

    Creature* SelectCouncilMember()
    {
        if (roll_chance_i(50))
            return instance->GetCreature(DATA_LADY_MALANDE);

        if (roll_chance_i(20))
            if (Creature* veras = instance->GetCreature(DATA_VERAS_DARKSHADOW))
                if (!veras->HasAura(SPELL_VANISH))
                    return veras;

        return instance->GetCreature(RAND(DATA_GATHIOS_THE_SHATTERER, DATA_HIGH_NETHERMANCER_ZEREVOR));
    }

    void JustEngagedWith(Unit* who) override
    {
        boss_illidari_council_memberAI::JustEngagedWith(who);
        events.ScheduleEvent(EVENT_SPELL_BLESSING, 10000);
        events.ScheduleEvent(EVENT_SPELL_AURA, 0);
        events.ScheduleEvent(EVENT_SPELL_SEAL, 2000);
        events.ScheduleEvent(EVENT_SPELL_HAMMER_OF_JUSTICE, 6000);
        events.ScheduleEvent(EVENT_SPELL_JUDGEMENT, 8000);
        events.ScheduleEvent(EVENT_SPELL_CONSECRATION, 4000);
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;

        events.Update(diff);
        if (me->HasUnitState(UNIT_STATE_CASTING))
            return;

        switch (events.ExecuteEvent())
        {
        case EVENT_SPELL_BLESSING:
            if (Unit* member = SelectCouncilMember())
            {
                me->CastSpell(member, _toggleBlessing ? SPELL_BLESSING_OF_PROTECTION : SPELL_BLESSING_OF_SPELL_WARDING);
                _toggleBlessing = !_toggleBlessing;
            }
            events.ScheduleEvent(EVENT_SPELL_BLESSING, 15000);
            break;
        case EVENT_SPELL_AURA:
            me->CastSpell(me, _toggleAura ? SPELL_DEVOTION_AURA : SPELL_CHROMATIC_RESISTANCE_AURA);
            _toggleAura = !_toggleAura;
            events.ScheduleEvent(EVENT_SPELL_AURA, 60000);
            break;
        case EVENT_SPELL_CONSECRATION:
            if (roll_chance_i(50))
                Talk(SAY_COUNCIL_SPECIAL);
            me->CastSpell(me, SPELL_CONSECRATION, false);
            events.ScheduleEvent(EVENT_SPELL_AURA, 30000);
            break;
        case EVENT_SPELL_HAMMER_OF_JUSTICE:
            if (Unit* target = me->GetVictim())
                if (target->IsPlayer() && me->IsInRange(target, 10.0f, 40.0f, true))
                {
                    me->CastSpell(target, SPELL_HAMMER_OF_JUSTICE);
                    events.ScheduleEvent(EVENT_SPELL_HAMMER_OF_JUSTICE, 20s);
                    break;
                }
            events.ScheduleEvent(EVENT_SPELL_HAMMER_OF_JUSTICE, 0);
            break;
        case EVENT_SPELL_SEAL:
            me->CastSpell(me, _toggleSeal ? SPELL_SEAL_OF_COMMAND : SPELL_SEAL_OF_BLOOD);
            _toggleSeal = !_toggleSeal;
            events.ScheduleEvent(EVENT_SPELL_SEAL, 20000);
            break;
        case EVENT_SPELL_JUDGEMENT:
            me->CastSpell(me->GetVictim(), SPELL_JUDGEMENT, false);
            events.ScheduleEvent(EVENT_SPELL_JUDGEMENT, 20000);
            break;
        }

        DoMeleeAttackIfReady();
    }
private:
    bool _toggleBlessing;
    bool _toggleAura;
    bool _toggleSeal;
};

struct boss_high_nethermancer_zerevor : public boss_illidari_council_memberAI
{
    boss_high_nethermancer_zerevor(Creature* creature) : boss_illidari_council_memberAI(creature) { }

    void AttackStart(Unit* who) override
    {
        if (who && me->Attack(who, true))
            me->GetMotionMaster()->MoveChase(who, 20.0f);
    }

    void JustEngagedWith(Unit* who) override
    {
        boss_illidari_council_memberAI::JustEngagedWith(who);
        events.ScheduleEvent(EVENT_SPELL_FLAMESTRIKE, 25000);
        events.ScheduleEvent(EVENT_SPELL_BLIZZARD, 5000);
        events.ScheduleEvent(EVENT_SPELL_ARCANE_BOLT, 15000);
        events.ScheduleEvent(EVENT_SPELL_DAMPEN_MAGIC, 0);
        events.ScheduleEvent(EVENT_SPELL_ARCANE_EXPLOSION, 10000);
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;

        events.Update(diff);
        if (me->HasUnitState(UNIT_STATE_CASTING))
            return;

        switch (events.ExecuteEvent())
        {
        case EVENT_SPELL_DAMPEN_MAGIC:
            me->CastSpell(me, SPELL_DAMPEN_MAGIC, false);
            events.ScheduleEvent(EVENT_SPELL_DAMPEN_MAGIC, 120000);
            break;
        case EVENT_SPELL_ARCANE_BOLT:
            me->CastSpell(me->GetVictim(), SPELL_ARCANE_BOLT, false);
            events.ScheduleEvent(EVENT_SPELL_ARCANE_BOLT, 3000);
            break;
        case EVENT_SPELL_FLAMESTRIKE:
            if (roll_chance_i(50))
                Talk(SAY_COUNCIL_SPECIAL);
            if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 100.0f))
                me->CastSpell(target, SPELL_FLAMESTRIKE, false);
            events.ScheduleEvent(EVENT_SPELL_FLAMESTRIKE, 40000);
            break;
        case EVENT_SPELL_BLIZZARD:
            if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 100.0f))
                me->CastSpell(target, SPELL_BLIZZARD, false);
            events.ScheduleEvent(EVENT_SPELL_BLIZZARD, 40000);
            break;
        case EVENT_SPELL_ARCANE_EXPLOSION:
            if (SelectTarget(SelectTargetMethod::Random, 0, 10.0f))
                me->CastSpell(me, SPELL_ARCANE_EXPLOSION, false);
            events.ScheduleEvent(EVENT_SPELL_ARCANE_EXPLOSION, 10000);
            break;
        }

        DoMeleeAttackIfReady();
    }
};

struct boss_lady_malande : public boss_illidari_council_memberAI
{
    boss_lady_malande(Creature* creature) : boss_illidari_council_memberAI(creature) { }

    void AttackStart(Unit* who) override
    {
        if (who && me->Attack(who, true))
            me->GetMotionMaster()->MoveChase(who, 20.0f);
    }

    void JustEngagedWith(Unit* who) override
    {
        boss_illidari_council_memberAI::JustEngagedWith(who);
        events.ScheduleEvent(EVENT_SPELL_REFLECTIVE_SHIELD, 10000);
        events.ScheduleEvent(EVENT_SPELL_CIRCLE_OF_HEALING, 20000);
        events.ScheduleEvent(EVENT_SPELL_DIVINE_WRATH, 5000);
        events.ScheduleEvent(EVENT_SPELL_EMPOWERED_SMITE, 15000);
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;

        events.Update(diff);
        if (me->HasUnitState(UNIT_STATE_CASTING))
            return;

        switch (events.ExecuteEvent())
        {
        case EVENT_SPELL_CIRCLE_OF_HEALING:
            me->CastSpell(me, SPELL_CIRCLE_OF_HEALING, false);
            events.ScheduleEvent(EVENT_SPELL_CIRCLE_OF_HEALING, 20000);
            break;
        case EVENT_SPELL_REFLECTIVE_SHIELD:
            if (roll_chance_i(50))
                Talk(SAY_COUNCIL_SPECIAL);
            me->CastSpell(me, SPELL_REFLECTIVE_SHIELD, false);
            events.ScheduleEvent(EVENT_SPELL_REFLECTIVE_SHIELD, 40000);
            break;
        case EVENT_SPELL_DIVINE_WRATH:
            if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 100.0f))
                me->CastSpell(target, SPELL_DIVINE_WRATH, false);
            events.ScheduleEvent(EVENT_SPELL_DIVINE_WRATH, 20000);
            break;
        case EVENT_SPELL_EMPOWERED_SMITE:
            me->CastSpell(me->GetVictim(), SPELL_EMPOWERED_SMITE, false);
            events.ScheduleEvent(EVENT_SPELL_EMPOWERED_SMITE, 3000);
            break;
        }
    }
};

struct boss_veras_darkshadow : public boss_illidari_council_memberAI
{
    boss_veras_darkshadow(Creature* creature) : boss_illidari_council_memberAI(creature) { }

    void JustEngagedWith(Unit* who) override
    {
        me->SetCanDualWield(true);
        boss_illidari_council_memberAI::JustEngagedWith(who);
        events.ScheduleEvent(EVENT_SPELL_VANISH, 10000);
        events.ScheduleEvent(EVENT_SPELL_ENRAGE, 900000);
    }

    void JustSummoned(Creature* summon) override
    {
        summon->CastSpell(summon, SPELL_VANISH_VISUAL, true);
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;

        events.Update(diff);
        if (me->HasUnitState(UNIT_STATE_CASTING))
            return;

        switch (events.ExecuteEvent())
        {
        case EVENT_SPELL_VANISH:
            if (roll_chance_i(50))
                Talk(SAY_COUNCIL_SPECIAL);
            me->CastSpell(me, SPELL_DEADLY_STRIKE, false);
            me->CastSpell(me, SPELL_VANISH, false);
            events.ScheduleEvent(EVENT_SPELL_VANISH, 60000);
            events.ScheduleEvent(EVENT_SPELL_VANISH_OUT, 29000);
            break;
        case EVENT_SPELL_VANISH_OUT:
            me->CastSpell(me, SPELL_VANISH_OUT, false);
            break;
        case EVENT_SPELL_ENRAGE:
            DoResetThreatList();
            if (Creature* council = instance->GetCreature(DATA_ILLIDARI_COUNCIL))
                council->GetAI()->DoAction(ACTION_ENRAGE);
            break;
        }

        if (events.GetNextEventTime(EVENT_SPELL_VANISH_OUT) == 0)
            DoMeleeAttackIfReady();
    }
};

class spell_illidari_council_balance_of_power_aura : public AuraScript
{
    PrepareAuraScript(spell_illidari_council_balance_of_power_aura);

    void CalculateAmount(AuraEffect const* /*aurEff*/, int32& amount, bool& /*canBeRecalculated*/)
    {
        // Set absorbtion amount to unlimited (no absorb)
        amount = -1;
    }

    void Register() override
    {
        DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_illidari_council_balance_of_power_aura::CalculateAmount, EFFECT_0, SPELL_AURA_SCHOOL_ABSORB);
    }
};

class spell_illidari_council_empyreal_balance : public SpellScript
{
    PrepareSpellScript(spell_illidari_council_empyreal_balance);

    bool Load() override
    {
        _sharedHealth = 0;
        _sharedHealthMax = 0;
        _targetCount = 0;
        return GetCaster()->GetTypeId() == TYPEID_UNIT;
    }

    void HandleDummy(SpellEffIndex effIndex)
    {
        PreventHitDefaultEffect(effIndex);
        if (Unit* target = GetHitUnit())
        {
            _targetCount++;
            _sharedHealth += target->GetHealth();
            _sharedHealthMax += target->GetMaxHealth();
        }
    }

    void HandleAfterCast()
    {
        if (_targetCount != 4)
        {
            GetCaster()->ToCreature()->AI()->EnterEvadeMode();
            return;
        }

        float pct = (_sharedHealth / _sharedHealthMax) * 100.0f;
        std::list<TargetInfo> const* targetsInfo = GetSpell()->GetUniqueTargetInfo();
        for (std::list<TargetInfo>::const_iterator ihit = targetsInfo->begin(); ihit != targetsInfo->end(); ++ihit)
            if (Creature* target = ObjectAccessor::GetCreature(*GetCaster(), ihit->targetGUID))
            {
                target->LowerPlayerDamageReq(target->GetMaxHealth());
                target->SetHealth(CalculatePct(target->GetMaxHealth(), pct));
            }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_illidari_council_empyreal_balance::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
        AfterCast += SpellCastFn(spell_illidari_council_empyreal_balance::HandleAfterCast);
    }

private:
    float _sharedHealth;
    float _sharedHealthMax;
    uint8 _targetCount;
};

class spell_illidari_council_reflective_shield_aura : public AuraScript
{
    PrepareAuraScript(spell_illidari_council_reflective_shield_aura);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_REFLECTIVE_SHIELD_T });
    }

    void ReflectDamage(AuraEffect* aurEff, DamageInfo& dmgInfo, uint32& absorbAmount)
    {
        Unit* target = GetTarget();
        if (dmgInfo.GetAttacker() == target)
            return;

        int32 bp = absorbAmount / 2;
        target->CastCustomSpell(dmgInfo.GetAttacker(), SPELL_REFLECTIVE_SHIELD_T, &bp, nullptr, nullptr, true, nullptr, aurEff);
    }

    void Register() override
    {
        AfterEffectAbsorb += AuraEffectAbsorbFn(spell_illidari_council_reflective_shield_aura::ReflectDamage, EFFECT_0);
    }
};

class spell_illidari_council_judgement : public SpellScript
{
    PrepareSpellScript(spell_illidari_council_judgement);

    void HandleScriptEffect(SpellEffIndex /*effIndex*/)
    {
        auto const& auras = GetCaster()->GetAuraEffectsByType(SPELL_AURA_DUMMY);
        for (auto i = auras.begin(); i != auras.end(); ++i)
        {
            if ((*i)->GetSpellInfo()->GetSpellSpecific() == SPELL_SPECIFIC_SEAL && (*i)->GetEffIndex() == EFFECT_2)
                if (sSpellMgr->GetSpellInfo((*i)->GetAmount()))
                {
                    GetCaster()->CastSpell(GetHitUnit(), (*i)->GetAmount(), true);
                    GetCaster()->RemoveAurasDueToSpell((*i)->GetSpellInfo()->Id);
                    break;
                }
        }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_illidari_council_judgement::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

class spell_illidari_council_deadly_strike_aura : public AuraScript
{
    PrepareAuraScript(spell_illidari_council_deadly_strike_aura);

    void Update(AuraEffect const* effect)
    {
        PreventDefaultAction();
        if (Unit* target = GetUnitOwner()->GetAI()->SelectTarget(SelectTargetMethod::Random, 0, 100.0f, true))
        {
            GetUnitOwner()->CastSpell(target, GetSpellInfo()->Effects[effect->GetEffIndex()].TriggerSpell, true);
            GetUnitOwner()->m_Events.AddEvent(new VerasEnvenom(*GetUnitOwner(), target->GetGUID()), GetUnitOwner()->m_Events.CalculateTime(urand(1500, 3500)));
        }
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_illidari_council_deadly_strike_aura::Update, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
    }
};

void AddSC_boss_illidari_council()
{
    RegisterBlackTempleCreatureAI(boss_illidari_council);
    RegisterBlackTempleCreatureAI(boss_gathios_the_shatterer);
    RegisterBlackTempleCreatureAI(boss_lady_malande);
    RegisterBlackTempleCreatureAI(boss_veras_darkshadow);
    RegisterBlackTempleCreatureAI(boss_high_nethermancer_zerevor);
    RegisterSpellScript(spell_illidari_council_balance_of_power_aura);
    RegisterSpellScript(spell_illidari_council_empyreal_balance);
    RegisterSpellScript(spell_illidari_council_reflective_shield_aura);
    RegisterSpellScript(spell_illidari_council_judgement);
    RegisterSpellScript(spell_illidari_council_deadly_strike_aura);
}

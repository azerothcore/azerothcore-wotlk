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
#include "Spell.h"
#include "SpellScriptLoader.h"
#include "black_temple.h"
#include "Player.h"
#include "SpellAuraEffects.h"
#include "SpellScript.h"

enum Says
{
    //Suffering
    SUFF_SAY_FREED                      = 0,
    SUFF_SAY_AGGRO                      = 1,
    SUFF_SAY_SLAY                       = 2,
    SUFF_SAY_RECAP                      = 3,
    SUFF_SAY_AFTER                      = 4,
    SUFF_SAY_ENRAGE                     = 5,
    SUFF_EMOTE_ENRAGE                   = 6,

    //Desire
    DESI_SAY_FREED                      = 0,
    DESI_SAY_SLAY                       = 1,
    DESI_SAY_SPEC                       = 2,
    DESI_SAY_RECAP                      = 3,
    DESI_SAY_AFTER                      = 4,

    //Anger
    ANGER_SAY_FREED                     = 0,
    ANGER_SAY_SLAY                      = 1,
    ANGER_SAY_SPEC                      = 2,
    ANGER_SAY_RECAP                     = 3,
    ANGER_SAY_DEATH                     = 4
};

enum Spells
{
    SPELL_EMERGE_VISUAL                 = 50142,
    SPELL_SUMMON_ESSENCE_OF_SUFFERING   = 41488,
    SPELL_SUMMON_ESSENCE_OF_DESIRE      = 41493,
    SPELL_SUMMON_ESSENCE_OF_ANGER       = 41496,
    SPELL_SUMMON_ENSLAVED_SOUL          = 41537,

    // Suffering
    SPELL_AURA_OF_SUFFERING             = 41292,
    SPELL_AURA_OF_SUFFERING_TRIGGER     = 42017,
    SPELL_ESSENCE_OF_SUFFERING_PASSIVE  = 41296,
    SPELL_ESSENCE_OF_SUFFERING_PASSIVE2 = 41623,
    SPELL_FRENZY                        = 41305,
    SPELL_SOUL_DRAIN                    = 41303,

    // Desire
    SPELL_AURA_OF_DESIRE                = 41350,
    SPELL_AURA_OF_DESIRE_DAMAGE         = 41352,
    SPELL_RUNE_SHIELD                   = 41431,
    SPELL_DEADEN                        = 41410,
    SPELL_SPIRIT_SHOCK                  = 41426,

    // Anger
    SPELL_AURA_OF_ANGER                 = 41337,
    SPELL_SPITE                         = 41376,
    SPELL_SPITE_DAMAGE                  = 41377,
    SPELL_SOUL_SCREAM                   = 41545,
    SPELL_SEETHE                        = 41364
};

enum Misc
{
    ACTION_ESSENCE_OF_SUFFERING     = 1,
    ACTION_ESSENCE_OF_DESIRE        = 2,
    ACTION_ESSENCE_OF_ANGER         = 3,
    ACTION_ENGAGE_ESSENCE           = 4,

    EVENT_ESSENCE_OF_SUFFERING      = 1,
    EVENT_ESSENCE_OF_DESIRE         = 2,
    EVENT_ESSENCE_OF_ANGER          = 3,

    POINT_GO_BACK                   = 1
};

class SuckBackEvent : public BasicEvent
{
public:
    SuckBackEvent(Creature& owner, uint32 action) : BasicEvent(), _owner(owner), _action(action) { }

    bool Execute(uint64 /*eventTime*/, uint32 /*diff*/) override
    {
        if (_owner.IsSummon())
            if (Unit* summoner = _owner.ToTempSummon()->GetSummonerUnit())
            {
                summoner->GetAI()->DoAction(_action);
                _owner.SetStandState(UNIT_STAND_STATE_SUBMERGED);
                _owner.DespawnOrUnsummon(200ms);
            }
        return true;
    }

private:
    Creature& _owner;
    uint32 _action;
};

class boss_reliquary_of_souls : public CreatureScript
{
public:
    boss_reliquary_of_souls() : CreatureScript("boss_reliquary_of_souls") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetBlackTempleAI<boss_reliquary_of_soulsAI>(creature);
    }

    struct boss_reliquary_of_soulsAI : public BossAI
    {
        boss_reliquary_of_soulsAI(Creature* creature) : BossAI(creature, DATA_RELIQUARY_OF_SOULS)
        {
        }

        void Reset() override
        {
            BossAI::Reset();
            me->SetStandState(UNIT_STAND_STATE_SLEEP);
        }

        void MoveInLineOfSight(Unit* who) override
        {
            if (!who || me->getStandState() != UNIT_STAND_STATE_SLEEP || !who->IsPlayer() ||
                who->ToPlayer()->IsGameMaster() || me->GetDistance2d(who) > 90.0f ||
                !me->isInFront(who, M_PI / 4.0f) || !me->IsWithinLOSInMap(who))
                return;

            me->SetInCombatWithZone();
            me->SetStandState(UNIT_STAND_STATE_STAND);

            ScheduleUniqueTimedEvent(5s, [&] {
                me->SetStandState(UNIT_STAND_STATE_SUBMERGED);
                DoCastSelf(SPELL_SUMMON_ESSENCE_OF_SUFFERING);
            }, EVENT_ESSENCE_OF_SUFFERING);
        }

        void DoAction(int32 param) override
        {
            if (param == ACTION_ESSENCE_OF_SUFFERING)
            {
                PhaseTransitionSpawns();

                ScheduleUniqueTimedEvent(38s, [&] {
                    summons.DespawnAll();
                    me->SetStandState(UNIT_STAND_STATE_SUBMERGED);
                    DoCastSelf(SPELL_SUMMON_ESSENCE_OF_DESIRE);
                }, EVENT_ESSENCE_OF_DESIRE);
            }
            else if (param == ACTION_ESSENCE_OF_DESIRE)
            {
                PhaseTransitionSpawns();

                ScheduleUniqueTimedEvent(38s, [&] {
                    summons.DespawnAll();
                    me->SetStandState(UNIT_STAND_STATE_SUBMERGED);
                    DoCastSelf(SPELL_SUMMON_ESSENCE_OF_ANGER);
                }, EVENT_ESSENCE_OF_ANGER);
            }
            else if (param == ACTION_ESSENCE_OF_ANGER)
            {
            }
        }

        void PhaseTransitionSpawns()
        {
            me->SetStandState(UNIT_STAND_STATE_STAND);
            me->m_Events.AddEventAtOffset([&] {
                me->SetStandState(UNIT_STAND_STATE_STAND);
            }, 1s);

            me->m_Events.AddEventAtOffset([&] {
                me->CastCustomSpell(SPELL_SUMMON_ENSLAVED_SOUL, SPELLVALUE_MAX_TARGETS, 1, me, false);
                me->CastCustomSpell(SPELL_SUMMON_ENSLAVED_SOUL, SPELLVALUE_MAX_TARGETS, 1, me, false);

                for (uint8 i = 0; i < 16; ++i)
                {
                    me->m_Events.AddEventAtOffset([&] {
                        me->CastCustomSpell(SPELL_SUMMON_ENSLAVED_SOUL, SPELLVALUE_MAX_TARGETS, 1, me, false);
                        }, i * 1200ms);
                }
            }, 8s);
        }

        void JustEngagedWith(Unit* who) override
        {
            BossAI::JustEngagedWith(who);
        }

        void JustSummoned(Creature* summon) override
        {
            summons.Summon(summon);
            if (summon->GetEntry() == NPC_ENSLAVED_SOUL)
                return;

            summon->SetReactState(REACT_PASSIVE);
            summon->CastSpell(summon, SPELL_EMERGE_VISUAL, true);
            me->m_Events.AddEventAtOffset([&] {
                summons.DoAction(ACTION_ENGAGE_ESSENCE);
            }, 4s);
        }

        void SummonedCreatureDies(Creature* summon, Unit*) override
        {
            summons.Despawn(summon);
        }

        void AttackStart(Unit*) override { }

        void JustDied(Unit* killer) override
        {
            summons.clear();
            BossAI::JustDied(killer);
        }

        void UpdateAI(uint32 diff) override
        {
            if (me->getStandState() == UNIT_STAND_STATE_SLEEP)
                return;

            scheduler.Update(diff);

            if (!UpdateVictim())
                return;
        }

        bool CheckEvadeIfOutOfCombatArea() const override
        {
            return !SelectTargetFromPlayerList(80.0f);
        }
    };
};

class boss_essence_of_suffering : public CreatureScript
{
public:
    boss_essence_of_suffering() : CreatureScript("boss_essence_of_suffering") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetBlackTempleAI<boss_essence_of_sufferingAI>(creature);
    }

    struct boss_essence_of_sufferingAI : public ScriptedAI
    {
        boss_essence_of_sufferingAI(Creature* creature) : ScriptedAI(creature), _recentlySpoken(false) { }

        void Reset() override
        {
            _recentlySpoken = false;
            scheduler.CancelAll();
        }

        void DoAction(int32 param) override
        {
            if (param == ACTION_ENGAGE_ESSENCE)
            {
                me->RemoveUnitFlag(UNIT_FLAG_NOT_SELECTABLE | UNIT_FLAG_NON_ATTACKABLE);
                me->SetReactState(REACT_AGGRESSIVE);
                me->SetInCombatWithZone();
            }
        }

        void MovementInform(uint32 type, uint32 id) override
        {
            if (type != POINT_MOTION_TYPE || id != POINT_GO_BACK)
                return;

            me->m_Events.AddEventAtOffset(new SuckBackEvent(*me, ACTION_ESSENCE_OF_SUFFERING), 1500ms);
            me->SetTarget();
            me->SetFacingTo(M_PI / 2.0f);
        }

        void DamageTaken(Unit*, uint32& damage, DamageEffectType, SpellSchoolMask) override
        {
            if (damage >= me->GetHealth())
            {
                damage = me->GetHealth() - 1;
                if (!me->HasUnitFlag(UNIT_FLAG_NON_ATTACKABLE))
                {
                    me->RemoveAurasDueToSpell(SPELL_ESSENCE_OF_SUFFERING_PASSIVE); // prevent fixate from triggering
                    me->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                    Talk(SUFF_SAY_RECAP);
                    me->SetReactState(REACT_PASSIVE);
                    me->GetMotionMaster()->Clear();
                    me->GetMotionMaster()->MovePoint(POINT_GO_BACK, me->GetHomePosition(), FORCED_MOVEMENT_NONE, 0.f, false);
                    scheduler.CancelAll();
                }
            }
        }

        void KilledUnit(Unit* /*victim*/) override
        {
            if (!_recentlySpoken)
            {
                Talk(SUFF_SAY_SLAY);
                me->m_Events.AddEventAtOffset([&] {
                    _recentlySpoken = false;
                }, 6s);
            }
        }

        void JustEngagedWith(Unit* /*who*/) override
        {
            Talk(SUFF_SAY_FREED);
            DoCastSelf(SPELL_AURA_OF_SUFFERING, true);
            DoCastSelf(SPELL_ESSENCE_OF_SUFFERING_PASSIVE, true);
            DoCastSelf(SPELL_ESSENCE_OF_SUFFERING_PASSIVE2, true);

            ScheduleTimedEvent(45s, [&] {
                Talk(SUFF_SAY_ENRAGE);
                Talk(SUFF_EMOTE_ENRAGE);
                DoCastSelf(SPELL_FRENZY);

                me->m_Events.AddEventAtOffset([&] {
                    Talk(SUFF_EMOTE_ENRAGE);
                }, 3s);
            }, 45s);

            ScheduleTimedEvent(25s, [&] {
                me->CastCustomSpell(SPELL_SOUL_DRAIN, SPELLVALUE_MAX_TARGETS, 3, me, false);
             }, 30s);
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
                return;

            scheduler.Update(diff);
            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            DoMeleeAttackIfReady();
        }

    private:
        bool _recentlySpoken;
    };
};

class boss_essence_of_desire : public CreatureScript
{
public:
    boss_essence_of_desire() : CreatureScript("boss_essence_of_desire") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetBlackTempleAI<boss_essence_of_desireAI>(creature);
    }

    struct boss_essence_of_desireAI : public ScriptedAI
    {
        boss_essence_of_desireAI(Creature* creature) : ScriptedAI(creature), _recentlySpoken(false) { }

        void Reset() override
        {
            _recentlySpoken = false;
            scheduler.CancelAll();
        }

        void DoAction(int32 param) override
        {
            if (param == ACTION_ENGAGE_ESSENCE)
            {
                me->RemoveUnitFlag(UNIT_FLAG_NOT_SELECTABLE | UNIT_FLAG_NON_ATTACKABLE);
                me->SetReactState(REACT_AGGRESSIVE);
                me->SetInCombatWithZone();
            }
        }

        void MovementInform(uint32 type, uint32 id) override
        {
            if (type != POINT_MOTION_TYPE || id != POINT_GO_BACK)
                return;

            me->m_Events.AddEventAtOffset(new SuckBackEvent(*me, ACTION_ESSENCE_OF_DESIRE), 1500ms);
            me->SetTarget();
            me->SetFacingTo(M_PI / 2.0f);
        }

        void DamageTaken(Unit*, uint32& damage, DamageEffectType, SpellSchoolMask) override
        {
            if (damage >= me->GetHealth())
            {
                damage = me->GetHealth() - 1;
                if (!me->HasUnitFlag(UNIT_FLAG_NON_ATTACKABLE))
                {
                    me->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                    Talk(DESI_SAY_RECAP);
                    me->SetReactState(REACT_PASSIVE);
                    me->GetMotionMaster()->Clear();
                    me->GetMotionMaster()->MovePoint(POINT_GO_BACK, me->GetHomePosition(), FORCED_MOVEMENT_NONE, 0.f, false);
                    scheduler.CancelAll();
                }
            }
        }

        void KilledUnit(Unit* /*victim*/) override
        {
            if (!_recentlySpoken)
            {
                Talk(DESI_SAY_SLAY);
                me->m_Events.AddEventAtOffset([&] {
                    _recentlySpoken = false;
                }, 6s);
            }
        }

        void JustEngagedWith(Unit* /*who*/) override
        {
            Talk(DESI_SAY_FREED);
            DoCastSelf(SPELL_AURA_OF_DESIRE, true);

            ScheduleTimedEvent(28s, [&] {
                if (roll_chance_i(50))
                    Talk(DESI_SAY_SPEC);
                DoCastVictim(SPELL_DEADEN);
            }, 31s);

            scheduler.Schedule(8s, 12s, [this](TaskContext context) {
                if (!me->HasUnitState(UNIT_STATE_CASTING))
                {
                    if (DoCastVictim(SPELL_SPIRIT_SHOCK) == SPELL_CAST_OK)
                        context.Repeat(1200ms);
                    else
                        context.Repeat(3s, 8s);
                }
                else
                    context.Repeat(1200ms);
            });

            ScheduleTimedEvent(13s, [&] {
                DoCastSelf(SPELL_RUNE_SHIELD);
            }, 15s);
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
                return;

            scheduler.Update(diff);
            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            DoMeleeAttackIfReady();
        }

    private:
        bool _recentlySpoken;
    };
};

class boss_essence_of_anger : public CreatureScript
{
public:
    boss_essence_of_anger() : CreatureScript("boss_essence_of_anger") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetBlackTempleAI<boss_essence_of_angerAI>(creature);
    }

    struct boss_essence_of_angerAI : public ScriptedAI
    {
        boss_essence_of_angerAI(Creature* creature) : ScriptedAI(creature), _recentlySpoken(false) { }

        ObjectGuid targetGUID;

        void Reset() override
        {
            _recentlySpoken = false;
            targetGUID.Clear();
            scheduler.CancelAll();
        }

        void DoAction(int32 param) override
        {
            if (param == ACTION_ENGAGE_ESSENCE)
            {
                me->RemoveUnitFlag(UNIT_FLAG_NOT_SELECTABLE | UNIT_FLAG_NON_ATTACKABLE);
                me->SetReactState(REACT_AGGRESSIVE);
                me->SetInCombatWithZone();
            }
        }

        void KilledUnit(Unit* /*victim*/) override
        {
            if (!_recentlySpoken)
            {
                Talk(ANGER_SAY_SLAY);
                me->m_Events.AddEventAtOffset([&] {
                    _recentlySpoken = false;
                }, 6s);
            }
        }

        void JustDied(Unit* /*killer*/) override
        {
            Talk(ANGER_SAY_DEATH);
            if (me->IsSummon())
                if (Unit* summoner = me->ToTempSummon()->GetSummonerUnit())
                    Unit::Kill(summoner, summoner);
        }

        void JustEngagedWith(Unit* /*who*/) override
        {
            Talk(ANGER_SAY_FREED);
            DoCastSelf(SPELL_AURA_OF_ANGER, true);

            ScheduleTimedEvent(15s, [&] {
                if (roll_chance_i(30))
                    Talk(ANGER_SAY_SPEC);
                me->CastCustomSpell(SPELL_SPITE, SPELLVALUE_MAX_TARGETS, 3, me, false);
            }, 25s);

            ScheduleTimedEvent(10s, [&] {
                DoCastVictim(SPELL_SOUL_SCREAM);
            }, 10s);

            ScheduleTimedEvent(1s, [&] {
                if (Unit* victim = me->GetVictim())
                {
                    ObjectGuid victimGUID = victim->GetGUID();
                    if (targetGUID && targetGUID != victimGUID)
                        DoCastSelf(SPELL_SEETHE);
                    // victim can be lost
                    targetGUID = victimGUID;
                }
            }, 1s);
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
                return;

            scheduler.Update(diff);
            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            DoMeleeAttackIfReady();
        }

    private:
        bool _recentlySpoken;
    };
};

class spell_reliquary_of_souls_aura_of_suffering_aura : public AuraScript
{
    PrepareAuraScript(spell_reliquary_of_souls_aura_of_suffering_aura);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_AURA_OF_SUFFERING_TRIGGER });
    }

    void HandleEffectApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        GetTarget()->CastSpell(GetTarget(), SPELL_AURA_OF_SUFFERING_TRIGGER, true);
    }

    void HandleEffectRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        GetTarget()->RemoveAurasDueToSpell(SPELL_AURA_OF_SUFFERING_TRIGGER);
    }

    void Register() override
    {
        OnEffectApply += AuraEffectApplyFn(spell_reliquary_of_souls_aura_of_suffering_aura::HandleEffectApply, EFFECT_0, SPELL_AURA_MOD_HEALING_PCT, AURA_EFFECT_HANDLE_REAL);
        OnEffectRemove += AuraEffectRemoveFn(spell_reliquary_of_souls_aura_of_suffering_aura::HandleEffectRemove, EFFECT_0, SPELL_AURA_MOD_HEALING_PCT, AURA_EFFECT_HANDLE_REAL);
    }
};

class spell_reliquary_of_souls_fixate : public SpellScript
{
    PrepareSpellScript(spell_reliquary_of_souls_fixate);

    void FilterTargets(std::list<WorldObject*>& targets)
    {
        if (targets.empty())
            return;

        targets.sort(Acore::ObjectDistanceOrderPred(GetCaster()));
        WorldObject* target = targets.front();
        targets.clear();
        targets.push_back(target);
    }

    void Register() override
    {
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_reliquary_of_souls_fixate::FilterTargets, EFFECT_ALL, TARGET_UNIT_SRC_AREA_ENEMY);
    }
};

class spell_reliquary_of_souls_fixate_aura : public AuraScript
{
    PrepareAuraScript(spell_reliquary_of_souls_fixate_aura);

    void HandleEffectRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        if (Unit* caster = GetCaster())
            caster->RemoveAurasDueToSpell(GetSpellInfo()->Effects[EFFECT_1].TriggerSpell, GetTarget()->GetGUID());
    }

    void Register() override
    {
        OnEffectRemove += AuraEffectRemoveFn(spell_reliquary_of_souls_fixate_aura::HandleEffectRemove, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
    }
};

class spell_reliquary_of_souls_aura_of_desire_aura : public AuraScript
{
    PrepareAuraScript(spell_reliquary_of_souls_aura_of_desire_aura);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_AURA_OF_DESIRE_DAMAGE });
    }

    bool CheckProc(ProcEventInfo& eventInfo)
    {
        return eventInfo.GetActor() && eventInfo.GetActionTarget();
    }

    void HandleProc(AuraEffect const* /*aurEff*/, ProcEventInfo& eventInfo)
    {
        PreventDefaultAction();
        eventInfo.GetActionTarget()->CastCustomSpell(SPELL_AURA_OF_DESIRE_DAMAGE, SPELLVALUE_BASE_POINT0, eventInfo.GetDamageInfo()->GetDamage() / 2, eventInfo.GetActor(), true);
    }

    void CalculateAmount(AuraEffect const* /*aurEff*/, int32& amount, bool& /*canBeRecalculated*/)
    {
        if (AuraEffect* effect = GetAura()->GetEffect(EFFECT_2))
            amount = std::max<int32>(-100, -5 * int32(effect->GetTickNumber()));
    }

    void Update(AuraEffect const*  /*effect*/)
    {
        PreventDefaultAction();
        if (AuraEffect* effect = GetAura()->GetEffect(EFFECT_1))
            effect->RecalculateAmount();
    }

    void Register() override
    {
        DoCheckProc += AuraCheckProcFn(spell_reliquary_of_souls_aura_of_desire_aura::CheckProc);
        OnEffectProc += AuraEffectProcFn(spell_reliquary_of_souls_aura_of_desire_aura::HandleProc, EFFECT_0, SPELL_AURA_MOD_HEALING_PCT);
        DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_reliquary_of_souls_aura_of_desire_aura::CalculateAmount, EFFECT_1, SPELL_AURA_MOD_INCREASE_ENERGY_PERCENT);
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_reliquary_of_souls_aura_of_desire_aura::Update, EFFECT_2, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
    }
};

class spell_reliquary_of_souls_aura_of_anger_aura : public AuraScript
{
    PrepareAuraScript(spell_reliquary_of_souls_aura_of_anger_aura);

    void CalculateAmount(AuraEffect const*  /*aurEff*/, int32& amount, bool& /*canBeRecalculated*/)
    {
        if (AuraEffect* effect = GetAura()->GetEffect(EFFECT_0))
            amount = amount * effect->GetTickNumber();
    }

    void Update(AuraEffect const*  /*effect*/)
    {
        if (AuraEffect* effect = GetAura()->GetEffect(EFFECT_0))
            effect->RecalculateAmount();
        if (AuraEffect* effect = GetAura()->GetEffect(EFFECT_1))
            effect->RecalculateAmount();
    }

    void Register() override
    {
        DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_reliquary_of_souls_aura_of_anger_aura::CalculateAmount, EFFECT_0, SPELL_AURA_PERIODIC_DAMAGE);
        DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_reliquary_of_souls_aura_of_anger_aura::CalculateAmount, EFFECT_1, SPELL_AURA_MOD_DAMAGE_PERCENT_DONE);
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_reliquary_of_souls_aura_of_anger_aura::Update, EFFECT_0, SPELL_AURA_PERIODIC_DAMAGE);
    }
};

class spell_reliquary_of_souls_spite_aura : public AuraScript
{
    PrepareAuraScript(spell_reliquary_of_souls_spite_aura);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_SPITE_DAMAGE });
    }

    void HandleEffectRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        if (Unit* caster = GetCaster())
            caster->CastSpell(GetTarget(), SPELL_SPITE_DAMAGE, true);
    }

    void Register() override
    {
        AfterEffectRemove += AuraEffectRemoveFn(spell_reliquary_of_souls_spite_aura::HandleEffectRemove, EFFECT_0, SPELL_AURA_DAMAGE_IMMUNITY, AURA_EFFECT_HANDLE_REAL);
    }
};

void AddSC_boss_reliquary_of_souls()
{
    new boss_reliquary_of_souls();
    new boss_essence_of_suffering();
    new boss_essence_of_desire();
    new boss_essence_of_anger();
    RegisterSpellScript(spell_reliquary_of_souls_aura_of_suffering_aura);
    RegisterSpellAndAuraScriptPair(spell_reliquary_of_souls_fixate, spell_reliquary_of_souls_fixate_aura);
    RegisterSpellScript(spell_reliquary_of_souls_aura_of_desire_aura);
    RegisterSpellScript(spell_reliquary_of_souls_aura_of_anger_aura);
    RegisterSpellScript(spell_reliquary_of_souls_spite_aura);
}

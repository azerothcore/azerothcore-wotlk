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
#include "azjol_nerub.h"
#include "SpellInfo.h"
#include "SpellMgr.h"
#include "SpellScript.h"

enum Spells
{
    SPELL_CARRION_BEETLES               = 53520,
    SPELL_SUMMON_CARRION_BEETLES        = 53521,
    SPELL_LEECHING_SWARM                = 53467,
    SPELL_POUND                         = 53472,
    SPELL_POUND_DAMAGE                  = 53509,
    SPELL_IMPALE_PERIODIC               = 53456,
    SPELL_EMERGE                        = 53500,
    SPELL_SUBMERGE                      = 53421,
    SPELL_SELF_ROOT                     = 42716,
    SPELL_CLEAR_ALL_DEBUFFS             = 34098,

    SPELL_SUMMON_DARTER                 = 53599,
    SPELL_SUMMON_ASSASSIN               = 53610,
    SPELL_SUMMON_GUARDIAN               = 53614,
    SPELL_SUMMON_VENOMANCER             = 53615,
};

enum Yells
{
    SAY_AGGRO                           = 0,
    SAY_SLAY                            = 1,
    SAY_DEATH                           = 2,
    SAY_LOCUST                          = 3,
    SAY_SUBMERGE                        = 4,
    SAY_INTRO                           = 5
};

enum Misc
{
    ACHIEV_TIMED_START_EVENT            = 20381,
};

enum Events
{
    EVENT_CARRION_BEETLES               = 1,
    EVENT_LEECHING_SWARM                = 2,
    EVENT_IMPALE                        = 3,
    EVENT_POUND                         = 4,
    EVENT_ENABLE_ROTATE                 = 5,
    EVENT_CLOSE_DOORS                   = 6,
    EVENT_EMERGE                        = 7,
    EVENT_SUMMON_GUARDIAN               = 8,
    EVENT_SUMMON_VENOMANCER             = 9,
    EVENT_SUMMON_DARTER                 = 10,
    EVENT_SUMMON_ASSASSINS              = 11,
    EVENT_KILL_TALK                     = 12
};

enum CreatureIds
{
    NPC_ANUBAR_GUARDIAN                 = 29216,
    NPC_ANUBAR_VENOMANCER               = 29217,
};

enum Groups : uint8
{
    GROUP_EMERGED = 1,
    GROUP_SUBMERGED
};

enum SubPhase : uint8
{
    SUBMERGE_NONE = 0,
    SUBMERGE_75 = 1,
    SUBMERGE_50 = 2,
    SUBMERGE_25 = 3,
};

enum SummonGroups
{
    SUMMON_GROUP_WORLD_TRIGGER_GUARDIAN = 1,
    SUMMON_GROUP_WORLD_TRIGGER_BALCONY = 2
};

struct boss_anub_arak : public BossAI
{
    explicit boss_anub_arak(Creature* creature) : BossAI(creature, DATA_ANUBARAK), _intro(false),
    _submergePhase(SUBMERGE_NONE), _remainingLargeSummonsBeforeEmerge(0), _balconySummons(me)
    {
        me->m_SightDistance = 120.0f;
    }

    void Reset() override
    {
        BossAI::Reset();
        me->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE);
        instance->DoStopTimedAchievement(ACHIEVEMENT_TIMED_TYPE_EVENT, ACHIEV_TIMED_START_EVENT);
        _remainingLargeSummonsBeforeEmerge = 0;
        _submergePhase = SUBMERGE_NONE;

        ScheduleHealthCheckEvent({ 75, 50, 25 }, [&]{
            events.CancelEventGroup(GROUP_EMERGED);
            Talk(SAY_SUBMERGE);
            DoCastSelf(SPELL_CLEAR_ALL_DEBUFFS, true);
            DoCastSelf(SPELL_SUBMERGE, false);
        }, false);
    }

    void SpellHitTarget(Unit* /*caster*/, SpellInfo const* spellInfo) override
    {
        if (spellInfo->Id == SPELL_SUBMERGE)
        {
            me->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE);
            me->RemoveAurasDueToSpell(SPELL_LEECHING_SWARM);
            DoCastSelf(SPELL_IMPALE_PERIODIC, true);

            ++_submergePhase;
            ScheduleSubmerged();
        }
    }

    void ScheduleEmerged()
    {
        events.CancelEventGroup(GROUP_SUBMERGED);
        events.ScheduleEvent(EVENT_CARRION_BEETLES, 6500ms, GROUP_EMERGED);
        events.ScheduleEvent(EVENT_LEECHING_SWARM, 20s, GROUP_EMERGED);
        events.ScheduleEvent(EVENT_POUND, 15s, GROUP_EMERGED);
    };

    void ScheduleSubmerged()
    {
        events.CancelEventGroup(GROUP_EMERGED);
        events.ScheduleEvent(EVENT_EMERGE, 60s, GROUP_SUBMERGED);

        switch (_submergePhase)
        {
            case SUBMERGE_75:
                events.ScheduleEvent(EVENT_SUMMON_GUARDIAN, 4s, GROUP_SUBMERGED);
                if (IsHeroic())
                    events.ScheduleEvent(EVENT_SUMMON_GUARDIAN, 7s, GROUP_SUBMERGED);

                _remainingLargeSummonsBeforeEmerge = IsHeroic() ? 2 : 1;

                events.ScheduleEvent(EVENT_SUMMON_ASSASSINS, 4s, GROUP_SUBMERGED);
                events.ScheduleEvent(EVENT_SUMMON_ASSASSINS, 24s, GROUP_SUBMERGED);
                events.ScheduleEvent(EVENT_SUMMON_ASSASSINS, 44s, GROUP_SUBMERGED);
                break;
            case SUBMERGE_50:
                events.ScheduleEvent(EVENT_SUMMON_GUARDIAN, 4s, GROUP_SUBMERGED);
                if (IsHeroic())
                    events.ScheduleEvent(EVENT_SUMMON_GUARDIAN, 7s, GROUP_SUBMERGED);

                events.ScheduleEvent(EVENT_SUMMON_VENOMANCER, 24s, GROUP_SUBMERGED);
                if (IsHeroic())
                    events.ScheduleEvent(EVENT_SUMMON_VENOMANCER, 29s, GROUP_SUBMERGED);

                _remainingLargeSummonsBeforeEmerge = IsHeroic() ? 4 : 2;

                events.ScheduleEvent(EVENT_SUMMON_ASSASSINS, 4s, GROUP_SUBMERGED);
                events.ScheduleEvent(EVENT_SUMMON_ASSASSINS, 24s, GROUP_SUBMERGED);
                events.ScheduleEvent(EVENT_SUMMON_ASSASSINS, 44s, GROUP_SUBMERGED);
                break;
            case SUBMERGE_25:
                events.ScheduleEvent(EVENT_SUMMON_GUARDIAN, 4s, GROUP_SUBMERGED);
                if (IsHeroic())
                    events.ScheduleEvent(EVENT_SUMMON_GUARDIAN, 7s, GROUP_SUBMERGED);

                events.ScheduleEvent(EVENT_SUMMON_VENOMANCER, 24s, GROUP_SUBMERGED);
                if (IsHeroic())
                    events.ScheduleEvent(EVENT_SUMMON_VENOMANCER, 29s, GROUP_SUBMERGED);

                _remainingLargeSummonsBeforeEmerge = IsHeroic() ? 4 : 2;

                events.ScheduleEvent(EVENT_SUMMON_ASSASSINS, 4s, GROUP_SUBMERGED);
                events.ScheduleEvent(EVENT_SUMMON_DARTER, 4s, GROUP_SUBMERGED);

                events.ScheduleEvent(EVENT_SUMMON_DARTER, 12s, GROUP_SUBMERGED);

                events.ScheduleEvent(EVENT_SUMMON_ASSASSINS, 24s, GROUP_SUBMERGED);
                events.ScheduleEvent(EVENT_SUMMON_DARTER, 26s, GROUP_SUBMERGED);

                events.ScheduleEvent(EVENT_SUMMON_DARTER, 32s, GROUP_SUBMERGED);

                events.ScheduleEvent(EVENT_SUMMON_ASSASSINS, 44s, GROUP_SUBMERGED);
                events.ScheduleEvent(EVENT_SUMMON_DARTER, 45s, GROUP_SUBMERGED);
                break;
            default:
                break;
        }
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        Talk(SAY_AGGRO);
        instance->DoStartTimedAchievement(ACHIEVEMENT_TIMED_TYPE_EVENT, ACHIEV_TIMED_START_EVENT);

        ScheduleEmerged();
        events.ScheduleEvent(EVENT_CLOSE_DOORS, 5s);

        // set up world triggers
        std::list<TempSummon*> summoned;
        me->SummonCreatureGroup(SUMMON_GROUP_WORLD_TRIGGER_GUARDIAN, &summoned);
        if (summoned.empty())
        {
            EnterEvadeMode(EVADE_REASON_OTHER);
            return;
        }
        TempSummon* guardianTrigger = summoned.front();
        _guardianTriggerGUID = guardianTrigger->GetGUID();

        summoned.clear();
        _balconySummons.clear();
        me->SummonCreatureGroup(SUMMON_GROUP_WORLD_TRIGGER_BALCONY, &summoned);
        if (summoned.empty())
        {
            EnterEvadeMode(EVADE_REASON_OTHER);
            return;
        }
        for (auto const& summon : summoned)
            _balconySummons.Summon(summon);
    }

    void EnterEvadeMode(EvadeReason why) override
    {
        me->DisableRotate(false);
        BossAI::EnterEvadeMode(why);
        summons.DespawnAll();
    }

    void MoveInLineOfSight(Unit* who) override
    {
        if (!_intro && who->IsPlayer())
        {
            _intro = true;
            Talk(SAY_INTRO);
        }
        BossAI::MoveInLineOfSight(who);
    }

    void JustDied(Unit* killer) override
    {
        Talk(SAY_DEATH);
        BossAI::JustDied(killer);
    }

    void KilledUnit(Unit* /*victim*/) override
    {
        if (!events.HasTimeUntilEvent(EVENT_KILL_TALK))
        {
            Talk(SAY_SLAY);
            events.ScheduleEvent(EVENT_KILL_TALK, 6s);
        }
    }

    void SummonedCreatureDies(Creature* summon, Unit* /*killer*/) override
    {
        if (!me->HasUnitFlag(UNIT_FLAG_NOT_SELECTABLE))
            return;

        switch (summon->GetEntry())
        {
            case NPC_ANUBAR_GUARDIAN:
            case NPC_ANUBAR_VENOMANCER:
            {
                --_remainingLargeSummonsBeforeEmerge;
                if (_remainingLargeSummonsBeforeEmerge == 0)
                {
                    me->RemoveAurasDueToSpell(SPELL_IMPALE_PERIODIC);
                    events.RescheduleEvent(EVENT_EMERGE, 5s, GROUP_SUBMERGED);
                }
                break;
            }
            default:
                break;
        }
    }

    void SummonedCreatureEvade(Creature* /*summon*/) override
    {
        EnterEvadeMode(EVADE_REASON_OTHER);
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;

        events.Update(diff);
        scheduler.Update(diff);

        if (me->HasUnitState(UNIT_STATE_CASTING))
            return;

        switch (events.ExecuteEvent())
        {
            case EVENT_CLOSE_DOORS:
                BossAI::_JustEngagedWith();
                break;
            case EVENT_CARRION_BEETLES:
                DoCastSelf(SPELL_CARRION_BEETLES);
                events.ScheduleEvent(EVENT_CARRION_BEETLES, 25s, GROUP_EMERGED);
                break;
            case EVENT_LEECHING_SWARM:
                Talk(SAY_LOCUST);
                DoCastSelf(SPELL_LEECHING_SWARM);
                events.ScheduleEvent(EVENT_LEECHING_SWARM, 20s, GROUP_EMERGED);
                break;
            case EVENT_POUND:
                if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 10.0f))
                {
                    DoCastSelf(SPELL_SELF_ROOT, true);
                    me->DisableRotate(true);
                    me->SendMovementFlagUpdate();
                    events.ScheduleEvent(EVENT_ENABLE_ROTATE, 3300ms, GROUP_EMERGED);
                    DoCast(target, SPELL_POUND);
                }
                events.ScheduleEvent(EVENT_POUND, 18s, GROUP_EMERGED);
                break;
            case EVENT_ENABLE_ROTATE:
                me->RemoveAurasDueToSpell(SPELL_SELF_ROOT);
                me->DisableRotate(false);
                break;
            case EVENT_EMERGE:
                me->RemoveAurasDueToSpell(SPELL_SUBMERGE);
                me->RemoveAurasDueToSpell(SPELL_IMPALE_PERIODIC);
                me->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE);
                DoCastSelf(SPELL_EMERGE);
                ScheduleEmerged();
                break;
            case EVENT_SUMMON_GUARDIAN:
                if (Creature* trigger = ObjectAccessor::GetCreature(*me, _guardianTriggerGUID))
                    trigger->CastSpell(trigger, SPELL_SUMMON_GUARDIAN, true, nullptr, nullptr, me->GetGUID());
                break;
            case EVENT_SUMMON_VENOMANCER:
                if (Creature* trigger = ObjectAccessor::GetCreature(*me, _guardianTriggerGUID))
                    trigger->CastSpell(trigger, SPELL_SUMMON_VENOMANCER, true, nullptr, nullptr, me->GetGUID());
                break;
            case EVENT_SUMMON_DARTER:
                if (Creature* trigger = ObjectAccessor::GetCreature(*me, Acore::Containers::SelectRandomContainerElement(_balconySummons)))
                    trigger->CastSpell(trigger, SPELL_SUMMON_DARTER, true, nullptr, nullptr, me->GetGUID());
                break;
            case EVENT_SUMMON_ASSASSINS:
                if (Creature* trigger = ObjectAccessor::GetCreature(*me, Acore::Containers::SelectRandomContainerElement(_balconySummons)))
                    trigger->CastSpell(trigger, SPELL_SUMMON_ASSASSIN, true, nullptr, nullptr, me->GetGUID());
                if (Creature* trigger = ObjectAccessor::GetCreature(*me, Acore::Containers::SelectRandomContainerElement(_balconySummons)))
                    trigger->CastSpell(trigger, SPELL_SUMMON_ASSASSIN, true, nullptr, nullptr, me->GetGUID());
                break;
            default:
                break;
        }

        if (!me->HasUnitFlag(UNIT_FLAG_NOT_SELECTABLE))
            DoMeleeAttackIfReady();
    }

    void DamageTaken(Unit* attacker, uint32& damage, DamageEffectType damagetype, SpellSchoolMask damageSchoolMask) override
    {
        BossAI::DamageTaken(attacker, damage, damagetype, damageSchoolMask);

        if (me->HasAura(SPELL_SUBMERGE) && damage >= me->GetHealth())
            damage = me->GetHealth() - 1;
    }

    private:
        bool _intro;
        uint8 _submergePhase;
        uint8 _remainingLargeSummonsBeforeEmerge;
        ObjectGuid _guardianTriggerGUID;
        SummonList _balconySummons;
};

class spell_azjol_nerub_carrion_beetles : public AuraScript
{
    PrepareAuraScript(spell_azjol_nerub_carrion_beetles)

    void HandleEffectPeriodic(AuraEffect const* /*aurEff*/)
    {
        // Xinef: 2 each second
        GetUnitOwner()->CastSpell(GetUnitOwner(), SPELL_SUMMON_CARRION_BEETLES, true);
        GetUnitOwner()->CastSpell(GetUnitOwner(), SPELL_SUMMON_CARRION_BEETLES, true);
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_azjol_nerub_carrion_beetles::HandleEffectPeriodic, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY);
    }
};

class spell_azjol_nerub_pound : public SpellScript
{
    PrepareSpellScript(spell_azjol_nerub_pound);

    void HandleApplyAura(SpellEffIndex /*effIndex*/)
    {
        if (Unit* unitTarget = GetHitUnit())
            GetCaster()->CastSpell(unitTarget, SPELL_POUND_DAMAGE, true);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_azjol_nerub_pound::HandleApplyAura, EFFECT_0, SPELL_EFFECT_APPLY_AURA);
    }
};

class spell_azjol_nerub_impale_summon : public SpellScript
{
    PrepareSpellScript(spell_azjol_nerub_impale_summon);

    void SetDest(SpellDestination& dest)
    {
        // Adjust effect summon position
        float floorZ = GetCaster()->GetMapHeight(GetCaster()->GetPositionX(), GetCaster()->GetPositionY(), GetCaster()->GetPositionZ(), true);
        if (floorZ > INVALID_HEIGHT)
            dest._position.m_positionZ = floorZ;
    }

    void Register() override
    {
        OnDestinationTargetSelect += SpellDestinationTargetSelectFn(spell_azjol_nerub_impale_summon::SetDest, EFFECT_0, TARGET_DEST_CASTER);
    }
};

void AddSC_boss_anub_arak()
{
    RegisterAzjolNerubCreatureAI(boss_anub_arak);
    RegisterSpellScript(spell_azjol_nerub_carrion_beetles);
    RegisterSpellScript(spell_azjol_nerub_pound);
    RegisterSpellScript(spell_azjol_nerub_impale_summon);
}

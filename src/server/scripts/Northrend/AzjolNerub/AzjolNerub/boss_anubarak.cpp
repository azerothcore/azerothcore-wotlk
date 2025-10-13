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

    EVENT_CARRION_BEETELS               = 1,
    EVENT_LEECHING_SWARM                = 2,
    EVENT_IMPALE                        = 3,
    EVENT_POUND                         = 4,
    EVENT_CLOSE_DOORS                   = 5,
    EVENT_EMERGE                        = 6,
    EVENT_SUMMON_VENOMANCER             = 7,
    EVENT_SUMMON_DARTER                 = 8,
    EVENT_SUMMON_GUARDIAN               = 9,
    EVENT_SUMMON_ASSASSINS              = 10,
    EVENT_ENABLE_ROTATE                 = 11,
    EVENT_KILL_TALK                     = 12
};

enum ANAnubarakNpcs
{
    NPC_ANUBAR_GUARDIAN                 = 29216,
    NPC_ANUBAR_VENOMANCER               = 29217
};

class boss_anub_arak : public CreatureScript
{
    public:
        boss_anub_arak() : CreatureScript("boss_anub_arak") { }

        struct boss_anub_arakAI : public BossAI
        {
            boss_anub_arakAI(Creature* creature) : BossAI(creature, DATA_ANUBARAK_EVENT)
            {
                me->m_SightDistance = 120.0f;
                _intro = false;
                _summonedMinions = false;
            }

            void EnterEvadeMode(EvadeReason why) override
            {
                me->DisableRotate(false);
                BossAI::EnterEvadeMode(why);
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

            void KilledUnit(Unit*  /*victim*/) override
            {
                if (!events.HasTimeUntilEvent(EVENT_KILL_TALK))
                {
                    Talk(SAY_SLAY);
                    events.ScheduleEvent(EVENT_KILL_TALK, 6s);
                }
            }

            void JustSummoned(Creature* summon) override
            {
                summons.Summon(summon);
                if (!summon->IsTrigger())
                    summon->SetInCombatWithZone();
            }

            void Reset() override
            {
                BossAI::Reset();
                _summonedMinions = false;
                me->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE|UNIT_FLAG_NOT_SELECTABLE);
                instance->DoStopTimedAchievement(ACHIEVEMENT_TIMED_TYPE_EVENT, ACHIEV_TIMED_START_EVENT);

                ScheduleHealthCheckEvent({ 75, 50, 25 }, [&]{
                    Talk(SAY_SUBMERGE);
                    _summonedMinions = false;
                    DoCastSelf(SPELL_CLEAR_ALL_DEBUFFS, true);
                    DoCastSelf(SPELL_SUBMERGE, false);

                    me->m_Events.AddEventAtOffset([this] {
                        me->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE);
                        DoCastSelf(SPELL_IMPALE_PERIODIC, true);
                    }, 2s);

                    events.Reset();
                    events.ScheduleEvent(EVENT_EMERGE, 60s);
                    events.ScheduleEvent(EVENT_SUMMON_ASSASSINS, 2s);
                    events.ScheduleEvent(EVENT_SUMMON_GUARDIAN, 4s);
                    events.ScheduleEvent(EVENT_SUMMON_ASSASSINS, 15s);
                    events.ScheduleEvent(EVENT_SUMMON_VENOMANCER, 20s);
                    events.ScheduleEvent(EVENT_SUMMON_DARTER, 30s);
                    events.ScheduleEvent(EVENT_SUMMON_ASSASSINS, 35s);
                }, false);
            }

            void SummonedCreatureDies(Creature* /*summon*/, Unit* /*killer*/) override
            {
                if (!me->HasUnitFlag(UNIT_FLAG_NOT_SELECTABLE))
                    return;

                if (_summonedMinions && !summons.IsAnyCreatureWithEntryAlive(NPC_ANUBAR_GUARDIAN) && !summons.IsAnyCreatureWithEntryAlive(NPC_ANUBAR_VENOMANCER))
                {
                    events.Reset();
                    events.ScheduleEvent(EVENT_EMERGE, 5s);
                }
            }

            void JustEngagedWith(Unit* ) override
            {
                Talk(SAY_AGGRO);
                instance->DoStartTimedAchievement(ACHIEVEMENT_TIMED_TYPE_EVENT, ACHIEV_TIMED_START_EVENT);

                events.ScheduleEvent(EVENT_CARRION_BEETELS, 6500ms);
                events.ScheduleEvent(EVENT_LEECHING_SWARM, 20s);
                events.ScheduleEvent(EVENT_POUND, 15s);
                events.ScheduleEvent(EVENT_CLOSE_DOORS, 5s);
            }

            void SummonHelpers(float x, float y, float z, uint32 spellId)
            {
                SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(spellId);
                me->SummonCreature(spellInfo->Effects[EFFECT_0].MiscValue, x, y, z, 0.0f, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 5000);
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
                        _JustEngagedWith();
                        break;
                    case EVENT_CARRION_BEETELS:
                        me->CastSpell(me, SPELL_CARRION_BEETLES, false);
                        events.ScheduleEvent(EVENT_CARRION_BEETELS, 25s);
                        break;
                    case EVENT_LEECHING_SWARM:
                        Talk(SAY_LOCUST);
                        me->CastSpell(me, SPELL_LEECHING_SWARM, false);
                        events.ScheduleEvent(EVENT_LEECHING_SWARM, 20s);
                        break;
                    case EVENT_POUND:
                        if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 10.0f))
                        {
                            me->CastSpell(me, SPELL_SELF_ROOT, true);
                            me->DisableRotate(true);
                            me->SendMovementFlagUpdate();
                            events.ScheduleEvent(EVENT_ENABLE_ROTATE, 3300ms);
                            me->CastSpell(target, SPELL_POUND, false);
                        }
                        events.ScheduleEvent(EVENT_POUND, 18s);
                        break;
                    case EVENT_ENABLE_ROTATE:
                        me->RemoveAurasDueToSpell(SPELL_SELF_ROOT);
                        me->DisableRotate(false);
                        break;
                    case EVENT_EMERGE:
                        me->CastSpell(me, SPELL_EMERGE, true);
                        me->RemoveAura(SPELL_SUBMERGE);
                        me->RemoveAura(SPELL_IMPALE_PERIODIC);
                        me->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE|UNIT_FLAG_NOT_SELECTABLE);
                        events.ScheduleEvent(EVENT_CARRION_BEETELS, 6500ms);
                        events.ScheduleEvent(EVENT_LEECHING_SWARM, 20s);
                        events.ScheduleEvent(EVENT_POUND, 15s);
                        break;
                    case EVENT_SUMMON_ASSASSINS:
                        SummonHelpers(509.32f, 247.42f, 239.48f, SPELL_SUMMON_ASSASSIN);
                        SummonHelpers(589.51f, 240.19f, 236.0f, SPELL_SUMMON_ASSASSIN);
                        break;
                    case EVENT_SUMMON_DARTER:
                        SummonHelpers(509.32f, 247.42f, 239.48f, SPELL_SUMMON_DARTER);
                        SummonHelpers(589.51f, 240.19f, 236.0f, SPELL_SUMMON_DARTER);
                        break;
                    case EVENT_SUMMON_GUARDIAN:
                        SummonHelpers(550.34f, 316.00f, 234.30f, SPELL_SUMMON_GUARDIAN);
                        break;
                    case EVENT_SUMMON_VENOMANCER:
                        _summonedMinions = true;
                        SummonHelpers(550.34f, 316.00f, 234.30f, SPELL_SUMMON_VENOMANCER);
                        break;
                }

                if (!me->HasUnitFlag(UNIT_FLAG_NOT_SELECTABLE))
                    DoMeleeAttackIfReady();
            }

            private:
                bool _intro;
                bool _summonedMinions;
        };

        CreatureAI* GetAI(Creature* creature) const override
        {
            return GetAzjolNerubAI<boss_anub_arakAI>(creature);
        }
};

class spell_azjol_nerub_carrion_beetels : public AuraScript
{
    PrepareAuraScript(spell_azjol_nerub_carrion_beetels)

    void HandleEffectPeriodic(AuraEffect const*  /*aurEff*/)
    {
        // Xinef: 2 each second
        GetUnitOwner()->CastSpell(GetUnitOwner(), SPELL_SUMMON_CARRION_BEETLES, true);
        GetUnitOwner()->CastSpell(GetUnitOwner(), SPELL_SUMMON_CARRION_BEETLES, true);
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_azjol_nerub_carrion_beetels::HandleEffectPeriodic, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY);
    }
};

class spell_azjol_nerub_pound : public SpellScript
{
    PrepareSpellScript(spell_azjol_nerub_pound);

    void HandleApplyAura(SpellEffIndex  /*effIndex*/)
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
    new boss_anub_arak();
    RegisterSpellScript(spell_azjol_nerub_carrion_beetels);
    RegisterSpellScript(spell_azjol_nerub_pound);
    RegisterSpellScript(spell_azjol_nerub_impale_summon);
}

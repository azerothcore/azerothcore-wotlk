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

#include "AchievementCriteriaScript.h"
#include "CreatureScript.h"
#include "ScriptedCreature.h"
#include "SpellScriptLoader.h"
#include "gundrak.h"
#include "SpellScript.h"

enum Spells
{
    SPELL_POISON_NOVA                           = 55081,
    SPELL_POWERFULL_BITE                        = 48287,
    SPELL_VENOM_BOLT                            = 54970,

    SPELL_SNAKE_WRAP                            = 55126
};

enum Yells
{
    SAY_AGGRO                                   = 0,
    SAY_SLAY                                    = 1,
    SAY_DEATH                                   = 2,
    SAY_SUMMON_SNAKES                           = 3,
    SAY_SUMMON_CONSTRICTORS                     = 4,
    EMOTE_NOVA                                  = 5,
    EMOTE_ALTAR                                 = 6
};

enum Misc
{
    NPC_SLADRAN_VIPER                           = 29680,
    NPC_SLADRAN_CONSTRICTORS                    = 29713,

    MAX_VIPER                                   = 2,
    MAX_CONSTRICTOR                             = 3,
    MAX_SUMMONS                                 = 5,

    EVENT_POISON_NOVA                           = 1,
    EVENT_POWERFULL_BITE                        = 2,
    EVENT_VENOM_BOLT                            = 3,
    EVENT_CHECK_HEALTH1                         = 4,
    EVENT_CHECK_HEALTH2                         = 5,
    EVENT_SUMMON1                               = 6,
    EVENT_SUMMON2                               = 7,
    EVENT_KILL_TALK                             = 8
};

const Position SpawnLoc[] =
{
    {1783.81f, 646.637f, 133.948f, 3.71755f},
    {1775.03f, 606.586f, 134.165f, 1.43117f},
    {1765.66f, 646.542f, 134.02f,  5.11381f},
    {1717.39f, 630.041f, 129.282f, 5.96903f},
    {1716.76f, 635.159f, 129.282f, 0.191986f}
};

class boss_slad_ran : public CreatureScript
{
public:
    boss_slad_ran() : CreatureScript("boss_slad_ran") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetGundrakAI<boss_slad_ranAI>(creature);
    }

    struct boss_slad_ranAI : public BossAI
    {
        boss_slad_ranAI(Creature* creature) : BossAI(creature, DATA_SLAD_RAN)
        {
        }

        void Reset() override
        {
            BossAI::Reset();
            _achievement = true;
        }

        uint32 GetData(uint32 data) const override
        {
            if (data == me->GetEntry())
                return uint32(_achievement);
            return 0;
        }

        void SetData(uint32 data, uint32) override
        {
            if (data == me->GetEntry())
                _achievement = false;
        }

        void JustEngagedWith(Unit* who) override
        {
            Talk(SAY_AGGRO);
            BossAI::JustEngagedWith(who);

            events.ScheduleEvent(EVENT_POISON_NOVA, 10s);
            events.ScheduleEvent(EVENT_POWERFULL_BITE, 3s);
            events.ScheduleEvent(EVENT_VENOM_BOLT, 15s);
            events.ScheduleEvent(EVENT_CHECK_HEALTH1, 1s);
            events.ScheduleEvent(EVENT_CHECK_HEALTH2, 1s);
        }

        void JustDied(Unit* killer) override
        {
            Talk(SAY_DEATH);
            Talk(EMOTE_ALTAR);
            BossAI::JustDied(killer);
        }

        void KilledUnit(Unit*) override
        {
            if (events.GetNextEventTime(EVENT_KILL_TALK) == 0)
            {
                Talk(SAY_SLAY);
                events.ScheduleEvent(EVENT_KILL_TALK, 6s);
            }
        }

        void JustSummoned(Creature* summon) override
        {
            summon->SetInCombatWithZone();
            summons.Summon(summon);
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
                case EVENT_CHECK_HEALTH1:
                    if (me->HealthBelowPct(70))
                    {
                        Talk(SAY_SUMMON_SNAKES);
                        events.ScheduleEvent(EVENT_SUMMON1, 1s);
                        break;
                    }
                    events.ScheduleEvent(EVENT_CHECK_HEALTH1, 1s);
                    break;
                case EVENT_CHECK_HEALTH2:
                    if (me->HealthBelowPct(50))
                    {
                        Talk(SAY_SUMMON_CONSTRICTORS);
                        events.ScheduleEvent(EVENT_SUMMON2, 1s);
                        break;
                    }
                    events.ScheduleEvent(EVENT_CHECK_HEALTH2, 1s);
                    break;
                case EVENT_POISON_NOVA:
                    Talk(EMOTE_NOVA);
                    me->CastSpell(me, SPELL_POISON_NOVA, false);
                    events.ScheduleEvent(EVENT_POISON_NOVA, 15s);
                    break;
                case EVENT_POWERFULL_BITE:
                    me->CastSpell(me->GetVictim(), SPELL_POWERFULL_BITE, false);
                    events.ScheduleEvent(EVENT_POWERFULL_BITE, 10s);
                    break;
                case EVENT_VENOM_BOLT:
                    me->CastSpell(me->GetVictim(), SPELL_VENOM_BOLT, false);
                    events.ScheduleEvent(EVENT_VENOM_BOLT, 10s);
                    break;
                case EVENT_SUMMON1:
                    for (uint8 i = MAX_CONSTRICTOR; i < MAX_SUMMONS; ++i)
                        me->SummonCreature(NPC_SLADRAN_VIPER, SpawnLoc[i], TEMPSUMMON_CORPSE_TIMED_DESPAWN, 20 * IN_MILLISECONDS);
                    events.ScheduleEvent(EVENT_SUMMON1, 8s);
                    break;
                case EVENT_SUMMON2:
                    for (uint8 i = 0; i < MAX_CONSTRICTOR; ++i)
                        me->SummonCreature(NPC_SLADRAN_CONSTRICTORS, SpawnLoc[i], TEMPSUMMON_CORPSE_TIMED_DESPAWN, 20 * IN_MILLISECONDS);
                    events.ScheduleEvent(EVENT_SUMMON2, 3s, 5s);
                    break;
            }

            DoMeleeAttackIfReady();
        }

    private:
        bool _achievement;
    };
};

class spell_sladran_grip_of_sladran_aura : public AuraScript
{
    PrepareAuraScript(spell_sladran_grip_of_sladran_aura);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_SNAKE_WRAP });
    }

    void HandlePeriodic(AuraEffect const*  /*aurEff*/)
    {
        PreventDefaultAction();
        if (GetStackAmount() >= 5)
        {
            SetDuration(0);
            GetUnitOwner()->CastSpell(GetUnitOwner(), SPELL_SNAKE_WRAP, true);
        }
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_sladran_grip_of_sladran_aura::HandlePeriodic, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY);
    }
};

class achievement_snakes_whyd_it_have_to_be_snakes : public AchievementCriteriaScript
{
public:
    achievement_snakes_whyd_it_have_to_be_snakes() : AchievementCriteriaScript("achievement_snakes_whyd_it_have_to_be_snakes")
    {
    }

    bool OnCheck(Player* /*player*/, Unit* target, uint32 /*criteria_id*/) override
    {
        if (!target)
            return false;

        return target->GetAI()->GetData(target->GetEntry());
    }
};

void AddSC_boss_slad_ran()
{
    new boss_slad_ran();
    RegisterSpellScript(spell_sladran_grip_of_sladran_aura);
    new achievement_snakes_whyd_it_have_to_be_snakes();
}

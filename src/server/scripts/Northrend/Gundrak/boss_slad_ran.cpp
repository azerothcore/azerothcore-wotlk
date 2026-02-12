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

    EVENT_KILL_TALK                             = 1
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

    struct boss_slad_ranAI : public BossAI
    {
        boss_slad_ranAI(Creature* creature) : BossAI(creature, DATA_SLAD_RAN) { }

        void Reset() override
        {
            BossAI::Reset();
            _achievement = true;

            ScheduleHealthCheckEvent(90, [&] {
                Talk(SAY_SUMMON_SNAKES);

                ScheduleTimedEvent(1s, [&] {
                    for (uint8 i = MAX_CONSTRICTOR; i < MAX_SUMMONS; ++i)
                        me->SummonCreature(NPC_SLADRAN_VIPER, SpawnLoc[i], TEMPSUMMON_CORPSE_TIMED_DESPAWN, 20 * IN_MILLISECONDS);
                }, 8s);
            });

            ScheduleHealthCheckEvent(DUNGEON_MODE(50, 75), [&] {
                Talk(SAY_SUMMON_CONSTRICTORS);

                ScheduleTimedEvent(1s, [&] {
                    for (uint8 i = 0; i < MAX_CONSTRICTOR; ++i)
                        me->SummonCreature(NPC_SLADRAN_CONSTRICTORS, SpawnLoc[i], TEMPSUMMON_CORPSE_TIMED_DESPAWN, 20 * IN_MILLISECONDS);
                }, 3s, 5s);
            });
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

            ScheduleTimedEvent(16s, 53s, [&]{
                Talk(EMOTE_NOVA);
                DoCastAOE(SPELL_POISON_NOVA);
            }, 16s, 53s);

            ScheduleTimedEvent(3s, [&] {
                DoCastVictim(SPELL_POWERFULL_BITE);
            }, 10s);

            ScheduleTimedEvent(15s, [&] {
                DoCastRandomTarget(SPELL_VENOM_BOLT, 0, 45.0f, false);
            }, 10s);
        }

        void JustDied(Unit* killer) override
        {
            Talk(SAY_DEATH);
            Talk(EMOTE_ALTAR);
            BossAI::JustDied(killer);
        }

        void KilledUnit(Unit*) override
        {
            if (!events.HasTimeUntilEvent(EVENT_KILL_TALK))
            {
                Talk(SAY_SLAY);
                events.ScheduleEvent(EVENT_KILL_TALK, 6s);
            }
        }

    private:
        bool _achievement;
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetGundrakAI<boss_slad_ranAI>(creature);
    }
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

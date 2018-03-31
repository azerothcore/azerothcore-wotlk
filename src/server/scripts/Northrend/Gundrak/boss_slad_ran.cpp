/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "gundrak.h"

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

const Position SpawnLoc[]=
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

        CreatureAI* GetAI(Creature* creature) const
        {
            return new boss_slad_ranAI(creature);
        }

        struct boss_slad_ranAI : public BossAI
        {
            boss_slad_ranAI(Creature* creature) : BossAI(creature, DATA_SLAD_RAN)
            {
            }

            void Reset()
            {
                BossAI::Reset();
                _achievement = true;
            }

            uint32 GetData(uint32 data) const
            {
                if (data == me->GetEntry())
                    return uint32(_achievement);
                return 0;
            }

            void SetData(uint32 data, uint32)
            {
                if (data == me->GetEntry())
                    _achievement = false;
            }

            void EnterCombat(Unit* who)
            {
                Talk(SAY_AGGRO);
                BossAI::EnterCombat(who);

                events.ScheduleEvent(EVENT_POISON_NOVA, 10000);
                events.ScheduleEvent(EVENT_POWERFULL_BITE, 3000);
                events.ScheduleEvent(EVENT_VENOM_BOLT, 15000);
                events.ScheduleEvent(EVENT_CHECK_HEALTH1, 1000);
                events.ScheduleEvent(EVENT_CHECK_HEALTH2, 1000);
            }

            void JustDied(Unit* killer)
            {
                Talk(SAY_DEATH);
                Talk(EMOTE_ALTAR);
                BossAI::JustDied(killer);
            }

            void KilledUnit(Unit*)
            {
                if (events.GetNextEventTime(EVENT_KILL_TALK) == 0)
                {
                    Talk(SAY_SLAY);
                    events.ScheduleEvent(EVENT_KILL_TALK, 6000);
                }
            }

            void JustSummoned(Creature* summon)
            {
                summon->SetInCombatWithZone();
                summons.Summon(summon);
            }

            void UpdateAI(uint32 diff)
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
                            events.ScheduleEvent(EVENT_SUMMON1, 1000);
                            break;
                        }
                        events.ScheduleEvent(EVENT_CHECK_HEALTH1, 1000);
                        break;
                    case EVENT_CHECK_HEALTH2:
                        if (me->HealthBelowPct(50))
                        {
                            Talk(SAY_SUMMON_CONSTRICTORS);
                            events.ScheduleEvent(EVENT_SUMMON2, 1000);
                            break;
                        }
                        events.ScheduleEvent(EVENT_CHECK_HEALTH2, 1000);
                        break;
                    case EVENT_POISON_NOVA:
                        Talk(EMOTE_NOVA);
                        me->CastSpell(me, SPELL_POISON_NOVA, false);
                        events.ScheduleEvent(EVENT_POISON_NOVA, 15000);
                        break;
                    case EVENT_POWERFULL_BITE:
                        me->CastSpell(me->GetVictim(), SPELL_POWERFULL_BITE, false);
                        events.ScheduleEvent(EVENT_POWERFULL_BITE, 10000);
                        break;
                    case EVENT_VENOM_BOLT:
                        me->CastSpell(me->GetVictim(), SPELL_VENOM_BOLT, false);
                        events.ScheduleEvent(EVENT_VENOM_BOLT, 10000);
                        break;
                    case EVENT_SUMMON1:
                        for (uint8 i = MAX_CONSTRICTOR; i < MAX_SUMMONS; ++i)
                            me->SummonCreature(NPC_SLADRAN_VIPER, SpawnLoc[i], TEMPSUMMON_CORPSE_TIMED_DESPAWN, 20*IN_MILLISECONDS);
                        events.ScheduleEvent(EVENT_SUMMON1, 8000);
                        break;
                    case EVENT_SUMMON2:
                        for (uint8 i = 0; i < MAX_CONSTRICTOR; ++i)
                            me->SummonCreature(NPC_SLADRAN_CONSTRICTORS, SpawnLoc[i], TEMPSUMMON_CORPSE_TIMED_DESPAWN, 20*IN_MILLISECONDS);
                        events.ScheduleEvent(EVENT_SUMMON2, urand(3000, 5000));
                        break;
                }

                DoMeleeAttackIfReady();
            }

        private:
            bool _achievement;
        };
};

class spell_sladran_grip_of_sladran : public SpellScriptLoader
{
    public:
        spell_sladran_grip_of_sladran() : SpellScriptLoader("spell_sladran_grip_of_sladran") { }

        class spell_sladran_grip_of_sladran_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_sladran_grip_of_sladran_AuraScript);

            void HandlePeriodic(AuraEffect const*  /*aurEff*/)
            {
                PreventDefaultAction();
                if (GetStackAmount() >= 5)
                {
                    SetDuration(0);
                    GetUnitOwner()->CastSpell(GetUnitOwner(), SPELL_SNAKE_WRAP, true);
                }
            }

            void Register()
            {
                OnEffectPeriodic += AuraEffectPeriodicFn(spell_sladran_grip_of_sladran_AuraScript::HandlePeriodic, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_sladran_grip_of_sladran_AuraScript();
        }
};

class achievement_snakes_whyd_it_have_to_be_snakes : public AchievementCriteriaScript
{
    public:
        achievement_snakes_whyd_it_have_to_be_snakes() : AchievementCriteriaScript("achievement_snakes_whyd_it_have_to_be_snakes")
        {
        }

        bool OnCheck(Player* /*player*/, Unit* target)
        {
            if (!target)
                return false;

            return target->GetAI()->GetData(target->GetEntry());
        }
};

void AddSC_boss_slad_ran()
{
    new boss_slad_ran();
    new spell_sladran_grip_of_sladran();
    new achievement_snakes_whyd_it_have_to_be_snakes();
}

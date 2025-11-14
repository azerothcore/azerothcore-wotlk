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
#include "azjol_nerub.h"

enum Spells
{
    SPELL_SUBBOSS_AGGRO_TRIGGER         = 52343,
    SPELL_SWARM                         = 52440,
    SPELL_MIND_FLAY                     = 52586,
    SPELL_CURSE_OF_FATIGUE              = 52592,
    SPELL_FRENZY                        = 28747
};

enum Npcs
{
    NPC_WARRIOR                         = 28732,
    NPC_SKIRMISHER                      = 28734,
    NPC_SHADOWCASTER                    = 28733
};

enum Yells
{
    SAY_AGGRO                           = 0,
    SAY_SLAY                            = 1,
    SAY_DEATH                           = 2,
    SAY_SWARM                           = 3,
    SAY_PREFIGHT                        = 4,
    SAY_SEND_GROUP                      = 5
};

enum MiscActions
{
    ACTION_MINION_ENGAGED               = 1,
    GROUP_SWARM                         = 1
};

class boss_krik_thir : public CreatureScript
{
public:
    boss_krik_thir() : CreatureScript("boss_krik_thir") { }

    struct boss_krik_thirAI : public BossAI
    {
        boss_krik_thirAI(Creature* creature) : BossAI(creature, DATA_KRIKTHIR)
        {
            _initTalk = false;
            _canTalk = true;
            _minionInCombat = false;

            scheduler.SetValidator([this]
            {
                return !me->HasUnitState(UNIT_STATE_CASTING);
            });
        }

        void Reset() override
        {
            BossAI::Reset();

            me->SummonCreature(NPC_WATCHER_NARJIL, 511.8f, 666.493f, 776.278f, 0.977f, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 30000);
            me->SummonCreature(NPC_SHADOWCASTER, 511.63f, 672.44f, 775.71f, 0.90f, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 30000);
            me->SummonCreature(NPC_WARRIOR, 506.75f, 670.7f, 776.24f, 0.92f, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 30000);
            me->SummonCreature(NPC_WATCHER_GASHRA, 526.66f, 663.605f, 775.805f, 1.23f, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 30000);
            me->SummonCreature(NPC_SKIRMISHER, 522.91f, 660.18f, 776.19f, 1.28f, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 30000);
            me->SummonCreature(NPC_WARRIOR, 528.14f, 659.72f, 776.14f, 1.37f, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 30000);
            me->SummonCreature(NPC_WATCHER_SILTHIK, 543.826f, 665.123f, 776.245f, 1.55f, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 30000);
            me->SummonCreature(NPC_SKIRMISHER, 547.5f, 669.96f, 776.1f, 2.3f, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 30000);
            me->SummonCreature(NPC_SHADOWCASTER, 548.64f, 664.27f, 776.74f, 1.77f, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 30000);

            ScheduleHealthCheckEvent(25, [&] {
                DoCastSelf(SPELL_FRENZY, true);

                scheduler.CancelGroup(GROUP_SWARM);

                scheduler.Schedule(7s, 17s, GROUP_SWARM, [&](TaskContext context)
                {
                    Talk(SAY_SWARM);
                    DoCastAOE(SPELL_SWARM);
                    context.Repeat(20s);
                });
            });

            _canTalk = true;
            _minionInCombat = false;
        }

        void MoveInLineOfSight(Unit* who) override
        {
            if (!who->IsPlayer())
                return;

            if (!_initTalk)
            {
                _initTalk = true;
                Talk(SAY_PREFIGHT);
            }
        }

        void DoAction(int32 actionId) override
        {
            if (actionId == ACTION_MINION_ENGAGED && !_minionInCombat)
            {
                _minionInCombat = true;

                for (Seconds const& timer : { 10s, 40s, 70s })
                {
                    me->m_Events.AddEventAtOffset([this] {
                        me->CastCustomSpell(SPELL_SUBBOSS_AGGRO_TRIGGER, SPELLVALUE_MAX_TARGETS, 1, me, true);
                        Talk(SAY_SEND_GROUP);
                    }, timer);
                }

                me->m_Events.AddEventAtOffset([this] {
                    me->SetInCombatWithZone();
                }, 100s);
            }
        }

        uint32 GetData(uint32 data) const override
        {
            if (data == me->GetEntry())
                return summons.HasEntry(NPC_WATCHER_NARJIL) && summons.HasEntry(NPC_WATCHER_GASHRA) && summons.HasEntry(NPC_WATCHER_SILTHIK);
            return 0;
        }

        void JustEngagedWith(Unit* who) override
        {
            BossAI::JustEngagedWith(who);
            Talk(SAY_AGGRO);

            me->m_Events.KillAllEvents(false);

            scheduler.Schedule(8s, 14s, [&](TaskContext context)
            {
                DoCastVictim(SPELL_MIND_FLAY);
                if (!IsInFrenzy())
                    context.Repeat(8s, 14s);
                else
                    context.Repeat(5s, 9s);
            }).Schedule(10s, 13s, GROUP_SWARM, [&](TaskContext context)
            {
                Talk(SAY_SWARM);
                DoCastAOE(SPELL_SWARM);
                context.Repeat(26s, 30s);
            });

            ScheduleTimedEvent(27s, 35s, [&] {
                DoCastRandomTarget(SPELL_CURSE_OF_FATIGUE);
            }, 27s, 35s);

            summons.DoZoneInCombat();
        }

        void JustDied(Unit* killer) override
        {
            BossAI::JustDied(killer);
            Talk(SAY_DEATH);
        }

        void KilledUnit(Unit* /*victim*/) override
        {
            if (_canTalk)
            {
                _canTalk = false;
                Talk(SAY_SLAY);
                me->m_Events.AddEventAtOffset([&] {
                    _canTalk = true;
                }, 6s);
            }
        }

        void JustSummoned(Creature* summon) override
        {
            summon->SetNoCallAssistance(true);
            summons.Summon(summon);
        }

        void SummonedCreatureDies(Creature* summon, Unit*) override
        {
            summons.Despawn(summon);
        }

    private:
        bool _initTalk;
        bool _canTalk;
        bool _minionInCombat;

        [[nodiscard]] bool IsInFrenzy() const { return me->HasAura(SPELL_FRENZY); }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetAzjolNerubAI<boss_krik_thirAI>(creature);
    }
};

class achievement_watch_him_die : public AchievementCriteriaScript
{
public:
    achievement_watch_him_die() : AchievementCriteriaScript("achievement_watch_him_die")
    {
    }

    bool OnCheck(Player* /*player*/, Unit* target, uint32 /*criteria_id*/) override
    {
        if (!target)
            return false;

        return target->GetAI()->GetData(target->GetEntry());
    }
};

void AddSC_boss_krik_thir()
{
    new boss_krik_thir();
    new achievement_watch_him_die();
}

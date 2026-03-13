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
#include "CreatureGroups.h"
#include "CreatureScript.h"
#include "ScriptedCreature.h"
#include "SpellInfo.h"
#include "azjol_nerub.h"

enum Spells
{
    SPELL_SUBBOSS_AGGRO_TRIGGER         = 52343,
    SPELL_SWARM                         = 52440,
    SPELL_MIND_FLAY                     = 52586,
    SPELL_CURSE_OF_FATIGUE              = 52592,
    SPELL_FRENZY                        = 28747
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
    GROUP_SWARM                         = 1,
    GROUP_WATCHERS                      = 2
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
            _firstCall = true;
            _minionsEngaged = 0;

            if (me->IsInEvadeMode())
                return;

            Creature* narjil = instance->GetCreature(DATA_NARJIL);
            Creature* gashra = instance->GetCreature(DATA_GASHRA);
            Creature* silthik = instance->GetCreature(DATA_SILTHIK);

            for (Creature* watcher : { narjil, gashra, silthik })
            {
                if (watcher && watcher->GetFormation())
                    watcher->GetFormation()->RespawnFormation(true);
            }
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
            if (actionId == ACTION_MINION_ENGAGED)
                ++_minionsEngaged;

            if (actionId == ACTION_MINION_ENGAGED && !_minionInCombat)
            {
                _minionInCombat = true;

                Talk(SAY_SEND_GROUP, 10s);

                for (Seconds const& timer : { 60s, 120s })
                    CallWatcher(timer);

                me->m_Events.AddEventAtOffset([this] {
                    me->SetInCombatWithZone();
                }, IsHeroic() ? 200s : 180s);
            }
            else if (actionId == ACTION_MINION_DIED)
            {
                me->m_Events.CancelEventGroup(GROUP_WATCHERS);

                // Check if any of the watchers is alive
                if (!me->FindNearestCreature(NPC_WATCHER_SILTHIK, 100.0f) &&
                    !me->FindNearestCreature(NPC_WATCHER_NARJIL, 100.0f) &&
                    !me->FindNearestCreature(NPC_WATCHER_GASHRA, 100.0f))
                    return;

                me->m_Events.AddEventAtOffset([this] {
                    SummonWatcher();
                }, 5s, GROUP_WATCHERS);

                // Schedule the next (10s + 60s)
                CallWatcher(70s);
            }
        }

        void CallWatcher(Seconds timer)
        {
            me->m_Events.AddEventAtOffset([this] {
                _firstCall = false;
                Talk(SAY_SEND_GROUP);
                SummonWatcher();
            }, timer, GROUP_WATCHERS);
        }

        void SummonWatcher()
        {
            me->m_Events.AddEventAtOffset([this] {
                me->CastCustomSpell(SPELL_SUBBOSS_AGGRO_TRIGGER, SPELLVALUE_MAX_TARGETS, 1, me, true);
                _firstCall = false;
            }, 5s, GROUP_WATCHERS);
        }

        uint32 GetData(uint32 data) const override
        {
            if (data == me->GetEntry())
            {
                Creature* narjil = instance->GetCreature(DATA_NARJIL);
                Creature* gashra = instance->GetCreature(DATA_GASHRA);
                Creature* silthik = instance->GetCreature(DATA_SILTHIK);

                if (!narjil || !gashra || !silthik)
                    return false;

                return narjil->IsAlive() && gashra->IsAlive() && silthik->IsAlive();
            }

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

            if (Creature* narjil = instance->GetCreature(DATA_NARJIL))
                narjil->SetInCombatWithZone();

            if (Creature* gashra = instance->GetCreature(DATA_GASHRA))
                gashra->SetInCombatWithZone();

            if (Creature* silthik = instance->GetCreature(DATA_SILTHIK))
                silthik->SetInCombatWithZone();
        }

        void SpellHitTarget(Unit* target, SpellInfo const* spellInfo) override
        {
            if (spellInfo->Id == SPELL_SUBBOSS_AGGRO_TRIGGER)
            {
                if (_minionsEngaged == 2 && _firstCall)
                    return;

                if (Creature* creature = target->ToCreature())
                    creature->SetInCombatWithZone();
            }
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

        void SummonedCreatureDies(Creature* summon, Unit*) override
        {
            summons.Despawn(summon);
        }

    private:
        bool _initTalk;
        bool _canTalk;
        bool _minionInCombat;
        uint8 _minionsEngaged;
        bool _firstCall;

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

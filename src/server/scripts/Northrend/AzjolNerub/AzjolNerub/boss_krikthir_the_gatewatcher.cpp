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
#include "azjol_nerub.h"

enum Spells
{
    SPELL_SUBBOSS_AGGRO_TRIGGER         = 52343,
    SPELL_SWARM                         = 52440,
    SPELL_MIND_FLAY                     = 52586,
    SPELL_CURSE_OF_FATIGUE              = 52592,
    SPELL_FRENZY                        = 28747
};

enum Events
{
    EVENT_KRIK_START_WAVE               = 1,
    EVENT_KRIK_SUMMON                   = 2,
    EVENT_KRIK_MIND_FLAY                = 3,
    EVENT_KRIK_CURSE                    = 4,
    EVENT_KRIK_HEALTH_CHECK             = 5,
    EVENT_KRIK_ENTER_COMBAT             = 6,
    EVENT_KILL_TALK                     = 7,
    EVENT_CALL_ADDS                     = 8,
    EVENT_KRIK_CHECK_EVADE              = 9
};

enum Npcs
{
    NPC_WATCHER_NARJIL                  = 28729,
    NPC_WATCHER_GASHRA                  = 28730,
    NPC_WATCHER_SILTHIK                 = 28731,
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

class boss_krik_thir : public CreatureScript
{
public:
    boss_krik_thir() : CreatureScript("boss_krik_thir") { }

    struct boss_krik_thirAI : public BossAI
    {
        boss_krik_thirAI(Creature* creature) : BossAI(creature, DATA_KRIKTHIR_THE_GATEWATCHER_EVENT)
        {
            _initTalk = false;
        }

        EventMap events2;
        bool _initTalk;

        void Reset() override
        {
            BossAI::Reset();
            events2.Reset();

            me->SummonCreature(NPC_WATCHER_NARJIL, 511.8f, 666.493f, 776.278f, 0.977f, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 30000);
            me->SummonCreature(NPC_SHADOWCASTER, 511.63f, 672.44f, 775.71f, 0.90f, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 30000);
            me->SummonCreature(NPC_WARRIOR, 506.75f, 670.7f, 776.24f, 0.92f, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 30000);
            me->SummonCreature(NPC_WATCHER_GASHRA, 526.66f, 663.605f, 775.805f, 1.23f, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 30000);
            me->SummonCreature(NPC_SKIRMISHER, 522.91f, 660.18f, 776.19f, 1.28f, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 30000);
            me->SummonCreature(NPC_WARRIOR, 528.14f, 659.72f, 776.14f, 1.37f, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 30000);
            me->SummonCreature(NPC_WATCHER_SILTHIK, 543.826f, 665.123f, 776.245f, 1.55f, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 30000);
            me->SummonCreature(NPC_SKIRMISHER, 547.5f, 669.96f, 776.1f, 2.3f, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 30000);
            me->SummonCreature(NPC_SHADOWCASTER, 548.64f, 664.27f, 776.74f, 1.77f, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 30000);
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

            if (events.Empty() && who->GetPositionZ() < 785.0f)
            {
                events2.ScheduleEvent(EVENT_KRIK_START_WAVE, 10s);
                events2.ScheduleEvent(EVENT_KRIK_START_WAVE, 40s);
                events2.ScheduleEvent(EVENT_KRIK_START_WAVE, 70s);
                events2.ScheduleEvent(EVENT_KRIK_ENTER_COMBAT, 100s);
                events2.ScheduleEvent(EVENT_KRIK_CHECK_EVADE, 5s);

                events.ScheduleEvent(EVENT_KRIK_HEALTH_CHECK, 1s);
                events.ScheduleEvent(EVENT_KRIK_MIND_FLAY, 13s);
                events.ScheduleEvent(EVENT_KRIK_SUMMON, 17s);
                events.ScheduleEvent(EVENT_KRIK_CURSE, 8s);
                events.ScheduleEvent(EVENT_CALL_ADDS, 1s);
                me->setActive(true);
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
            events2.Reset();
        }

        void JustDied(Unit* killer) override
        {
            BossAI::JustDied(killer);
            Talk(SAY_DEATH);
        }

        void KilledUnit(Unit* ) override
        {
            if (events.GetNextEventTime(EVENT_KILL_TALK) == 0)
            {
                Talk(SAY_SLAY);
                events.ScheduleEvent(EVENT_KILL_TALK, 6s);
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

        void UpdateAI(uint32 diff) override
        {
            events2.Update(diff);
            switch (events2.ExecuteEvent())
            {
                case EVENT_KRIK_START_WAVE:
                    me->CastCustomSpell(SPELL_SUBBOSS_AGGRO_TRIGGER, SPELLVALUE_MAX_TARGETS, 1, me, true);
                    Talk(SAY_SEND_GROUP);
                    break;
                case EVENT_KRIK_ENTER_COMBAT:
                    me->SetInCombatWithZone();
                    break;
                case EVENT_KRIK_CHECK_EVADE:
                    if (!SelectTargetFromPlayerList(100.0f))
                    {
                        EnterEvadeMode();
                        return;
                    }
                    events2.ScheduleEvent(EVENT_KRIK_CHECK_EVADE, 5s);
                    break;
            }

            if (!UpdateVictim())
                return;

            events.Update(diff);
            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (events.ExecuteEvent())
            {
                case EVENT_KRIK_HEALTH_CHECK:
                    if (HealthBelowPct(10))
                    {
                        me->CastSpell(me, SPELL_FRENZY, true);
                        break;
                    }
                    events.ScheduleEvent(EVENT_KRIK_HEALTH_CHECK, 1s);
                    break;
                case EVENT_KRIK_SUMMON:
                    Talk(SAY_SWARM);
                    me->CastSpell(me, SPELL_SWARM, false);
                    events.ScheduleEvent(EVENT_KRIK_SUMMON, 20s);
                    break;
                case EVENT_KRIK_MIND_FLAY:
                    me->CastSpell(me->GetVictim(), SPELL_MIND_FLAY, false);
                    events.ScheduleEvent(EVENT_KRIK_MIND_FLAY, 15s);
                    break;
                case EVENT_KRIK_CURSE:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 100, true))
                        me->CastSpell(target, SPELL_CURSE_OF_FATIGUE, true);
                    events.ScheduleEvent(EVENT_KRIK_CURSE, 10s);
                    break;
                case EVENT_CALL_ADDS:
                    summons.DoZoneInCombat();
                    break;
            }

            DoMeleeAttackIfReady();
        }
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

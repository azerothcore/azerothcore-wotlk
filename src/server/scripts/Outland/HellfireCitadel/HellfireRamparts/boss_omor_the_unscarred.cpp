/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "hellfire_ramparts.h"

enum Says
{
    SAY_AGGRO                   = 0,
    SAY_SUMMON                  = 1,
    SAY_CURSE                   = 2,
    SAY_KILL                    = 3,
    SAY_DIE                     = 4,
    SAY_WIPE                    = 5
};

enum Spells
{
    SPELL_SHADOW_BOLT           = 30686,
    SPELL_SUMMON_FIENDISH_HOUND = 30707,
    SPELL_TREACHEROUS_AURA      = 30695,
    SPELL_DEMONIC_SHIELD        = 31901,
    SPELL_ORBITAL_STRIKE        = 30637,
    SPELL_SHADOW_WHIP           = 30638
};

enum Misc
{
    EVENT_SUMMON1               = 1,
    EVENT_SUMMON2               = 2,
    EVENT_TREACHEROUS_AURA      = 3,
    EVENT_DEMONIC_SHIELD        = 4,
    EVENT_KILL_TALK             = 5,
    EVENT_ORBITAL_STRIKE        = 6,
    EVENT_SHADOW_WHIP           = 7
};

class boss_omor_the_unscarred : public CreatureScript
{
    public:
        boss_omor_the_unscarred() : CreatureScript("boss_omor_the_unscarred") { }

        struct boss_omor_the_unscarredAI : public BossAI
        {
            boss_omor_the_unscarredAI(Creature* creature) : BossAI(creature, DATA_OMOR_THE_UNSCARRED)
            {
            }

            void Reset()
            {
                Talk(SAY_WIPE);
                BossAI::Reset();
                _targetGUID = 0;
            }

            void EnterCombat(Unit* who)
            {
                Talk(SAY_AGGRO);
                BossAI::EnterCombat(who);

                events.ScheduleEvent(EVENT_SUMMON1, 10000);
                events.ScheduleEvent(EVENT_SUMMON2, 25000);
                events.ScheduleEvent(EVENT_TREACHEROUS_AURA, 6000);
                events.ScheduleEvent(EVENT_DEMONIC_SHIELD, 1000);
                events.ScheduleEvent(EVENT_ORBITAL_STRIKE, 20000);
            }

            void KilledUnit(Unit*)
            {
                if (events.GetNextEventTime(EVENT_KILL_TALK) == 0)
                {
                    Talk(SAY_KILL);
                    events.ScheduleEvent(EVENT_KILL_TALK, 6000);
                }
            }

            void JustSummoned(Creature* summon)
            {
                Talk(SAY_SUMMON);
                summons.Summon(summon);
                summon->SetInCombatWithZone();
            }

            void JustDied(Unit* killer)
            {
                Talk(SAY_DIE);
                BossAI::JustDied(killer);
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
                    case EVENT_SUMMON1:
                        Talk(SAY_SUMMON);
                        me->CastSpell(me, SPELL_SUMMON_FIENDISH_HOUND, false);
                        break;
                    case EVENT_SUMMON2:
                        me->CastSpell(me, SPELL_SUMMON_FIENDISH_HOUND, false);
                        events.ScheduleEvent(EVENT_SUMMON2, 15000);
                        break;
                    case EVENT_TREACHEROUS_AURA:
                        if (roll_chance_i(33))
                            Talk(SAY_CURSE);
                        if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0))
                            me->CastSpell(target, SPELL_TREACHEROUS_AURA, false);
                        events.ScheduleEvent(EVENT_TREACHEROUS_AURA, urand(12000, 18000));
                        break;
                    case EVENT_DEMONIC_SHIELD:
                        if (me->HealthBelowPct(21))
                        {
                            me->CastSpell(me, SPELL_DEMONIC_SHIELD, false);
                            events.ScheduleEvent(EVENT_DEMONIC_SHIELD, 15000);
                        }
                        else
                            events.ScheduleEvent(EVENT_DEMONIC_SHIELD, 1000);
                        break;
                    case EVENT_ORBITAL_STRIKE:
                        if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 15.0f, true))
                        {
                            _targetGUID = target->GetGUID();
                            me->CastSpell(target, SPELL_ORBITAL_STRIKE, false);
                            events.DelayEvents(5000);
                            events.ScheduleEvent(EVENT_SHADOW_WHIP, 4000);
                            me->GetMotionMaster()->Clear();
                        }
                        events.ScheduleEvent(EVENT_ORBITAL_STRIKE, 20000);
                        break;
                    case EVENT_SHADOW_WHIP:
                        me->GetMotionMaster()->MoveChase(me->GetVictim());
                        if (Unit* target = ObjectAccessor::GetUnit(*me, _targetGUID))
                            me->CastSpell(target, SPELL_SHADOW_WHIP, false);
                        _targetGUID = 0;
                        break;
                }

                if (!me->GetVictim() || !me->isAttackReady())
                    return;

                if (me->IsWithinMeleeRange(me->GetVictim()))
                {
                    me->GetMotionMaster()->MoveChase(me->GetVictim());
                    DoMeleeAttackIfReady();
                }
                else
                {
                    me->GetMotionMaster()->Clear();
                    me->CastSpell(me->GetVictim(), SPELL_SHADOW_BOLT, false);
                    me->resetAttackTimer();
                }
            }

        private:
            uint64 _targetGUID;
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return GetInstanceAI<boss_omor_the_unscarredAI>(creature);
        }
};

void AddSC_boss_omor_the_unscarred()
{
    new boss_omor_the_unscarred();
}


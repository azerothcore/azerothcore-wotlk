/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "karazhan.h"

enum Curator
{
    SAY_AGGRO                       = 0,
    SAY_SUMMON                      = 1,
    SAY_EVOCATE                     = 2,
    SAY_ENRAGE                      = 3,
    SAY_KILL                        = 4,
    SAY_DEATH                       = 5,

    SPELL_HATEFUL_BOLT              = 30383,
    SPELL_EVOCATION                 = 30254,
    SPELL_ARCANE_INFUSION           = 30403,
    SPELL_ASTRAL_DECONSTRUCTION     = 30407,

    SPELL_SUMMON_ASTRAL_FLARE1      = 30236,
    SPELL_SUMMON_ASTRAL_FLARE2      = 30239,
    SPELL_SUMMON_ASTRAL_FLARE3      = 30240,
    SPELL_SUMMON_ASTRAL_FLARE4      = 30241,

    EVENT_KILL_TALK                 = 1,
    EVENT_SPELL_HATEFUL_BOLT        = 2,
    EVENT_SPELL_EVOCATION           = 3,
    EVENT_SPELL_ASTRAL_FLARE        = 4,
    EVENT_SPELL_BERSERK             = 5,
    EVENT_CHECK_HEALTH              = 6
};

class boss_curator : public CreatureScript
{
    public:
        boss_curator() : CreatureScript("boss_curator") { }

        struct boss_curatorAI : public BossAI
        {
            boss_curatorAI(Creature* creature) : BossAI(creature, DATA_CURATOR) { }

            void Reset()
            {
                BossAI::Reset();
                me->ApplySpellImmune(0, IMMUNITY_DAMAGE, SPELL_SCHOOL_MASK_ARCANE, true);
                me->ApplySpellImmune(0, IMMUNITY_STATE, SPELL_AURA_PERIODIC_MANA_LEECH, true);
                me->ApplySpellImmune(0, IMMUNITY_STATE, SPELL_AURA_POWER_BURN, true);
                me->ApplySpellImmune(0, IMMUNITY_EFFECT, SPELL_EFFECT_POWER_BURN, true);
            }

            void KilledUnit(Unit*  /*victim*/)
            {
                if (events.GetNextEventTime(EVENT_KILL_TALK) == 0)
                {
                    Talk(SAY_KILL);
                    events.ScheduleEvent(EVENT_KILL_TALK, 5000);
                }
            }

            void JustDied(Unit* killer)
            {
                BossAI::JustDied(killer);
                Talk(SAY_DEATH);
            }

            void EnterCombat(Unit* who)
            {
                BossAI::EnterCombat(who);
                Talk(SAY_AGGRO);

                events.ScheduleEvent(EVENT_SPELL_HATEFUL_BOLT, 10000);
                events.ScheduleEvent(EVENT_SPELL_ASTRAL_FLARE, 6000);
                events.ScheduleEvent(EVENT_SPELL_BERSERK, 600000);
                events.ScheduleEvent(EVENT_CHECK_HEALTH, 1000);
                DoZoneInCombat();
            }

            void JustSummoned(Creature* summon)
            {
                summons.Summon(summon);
                if (Unit* target = summon->SelectNearbyTarget(nullptr, 40.0f))
                {
                    summon->AI()->AttackStart(target);
                    summon->AddThreat(target, 1000.0f);
                }

                summon->SetInCombatWithZone();
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
                    case EVENT_CHECK_HEALTH:
                        if (me->HealthBelowPct(16))
                        {
                            events.CancelEvent(EVENT_SPELL_ASTRAL_FLARE);
                            me->CastSpell(me, SPELL_ARCANE_INFUSION, true);
                            Talk(SAY_ENRAGE);
                            break;
                        }
                        events.ScheduleEvent(EVENT_CHECK_HEALTH, 1000);
                        break;
                    case EVENT_SPELL_BERSERK:
                        Talk(SAY_ENRAGE);
                        me->InterruptNonMeleeSpells(true);
                        me->CastSpell(me, SPELL_ASTRAL_DECONSTRUCTION, true);
                        break;
                    case EVENT_SPELL_HATEFUL_BOLT:
                        if (Unit* target = SelectTarget(SELECT_TARGET_TOPAGGRO, urand(1, 2), 40.0f))
                            me->CastSpell(target, SPELL_HATEFUL_BOLT, false);
                        events.ScheduleEvent(EVENT_SPELL_HATEFUL_BOLT, urand(5000, 7500) * (events.GetNextEventTime(EVENT_SPELL_BERSERK) == 0 ? 1 : 2));
                        break;
                    case EVENT_SPELL_ASTRAL_FLARE:
                    {
                        me->CastSpell(me, RAND(SPELL_SUMMON_ASTRAL_FLARE1, SPELL_SUMMON_ASTRAL_FLARE2, SPELL_SUMMON_ASTRAL_FLARE3, SPELL_SUMMON_ASTRAL_FLARE4), false);
                        int32 mana = CalculatePct(me->GetMaxPower(POWER_MANA), 10);
                        me->ModifyPower(POWER_MANA, -mana);
                        if (me->GetPowerPct(POWER_MANA) < 10.0f)
                        {
                            Talk(SAY_EVOCATE);
                            me->CastSpell(me, SPELL_EVOCATION, false);

                            events.DelayEvents(20000);
                            events.ScheduleEvent(EVENT_SPELL_ASTRAL_FLARE, 20000);
                        }
                        else
                        {
                            if (roll_chance_i(50))
                                Talk(SAY_SUMMON);

                            events.ScheduleEvent(EVENT_SPELL_ASTRAL_FLARE, 10000);
                        }

                        break;
                    }
                }

                DoMeleeAttackIfReady();
            }
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return GetInstanceAI<boss_curatorAI>(creature);
        }
};

void AddSC_boss_curator()
{
    new boss_curator();
}

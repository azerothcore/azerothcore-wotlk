/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "magisters_terrace.h"

enum Yells
{
    SAY_AGGRO                       = 0,
    SAY_ENERGY                      = 1,
    SAY_OVERLOAD                    = 2,
    SAY_KILL                        = 3,
    EMOTE_DISCHARGE_ENERGY          = 4
};

enum Spells
{
    // Pure energy spell info
    SPELL_ENERGY_FEEDBACK_CHANNEL   = 44328,
    SPELL_ENERGY_FEEDBACK           = 44335,

    // Vexallus spell info
    SPELL_CHAIN_LIGHTNING_N         = 44318,
    SPELL_CHAIN_LIGHTNING_H         = 46380,
    SPELL_OVERLOAD                  = 44352,
    SPELL_ARCANE_SHOCK_N            = 44319,
    SPELL_ARCANE_SHOCK_H            = 46381,

    SPELL_SUMMON_PURE_ENERGY_N      = 44322,
    SPELL_SUMMON_PURE_ENERGY_H1     = 46154,
    SPELL_SUMMON_PURE_ENERGY_H2     = 46159
};

enum Misc
{
    NPC_PURE_ENERGY                 = 24745,

    INTERVAL_MODIFIER               = 15,
    INTERVAL_SWITCH                 = 6,

    EVENT_SPELL_CHAIN_LIGHTNING     = 1,
    EVENT_SPELL_ARCANE_SHOCK        = 2,
    EVENT_HEALTH_CHECK              = 3,
};

class boss_vexallus : public CreatureScript
{
public:
    boss_vexallus() : CreatureScript("boss_vexallus") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new boss_vexallusAI(creature);
    };

    struct boss_vexallusAI : public ScriptedAI
    {
        boss_vexallusAI(Creature* creature) : ScriptedAI(creature), summons(me)
        {
            instance = creature->GetInstanceScript();
        }

        InstanceScript* instance;
        EventMap events;
        SummonList summons;

        uint8 IntervalHealthAmount;
        bool Enraged;

        void Reset()
        {
            summons.DespawnAll();
            IntervalHealthAmount = 1;

            instance->SetData(DATA_VEXALLUS_EVENT, NOT_STARTED);
            instance->DoRemoveAurasDueToSpellOnPlayers(SPELL_ENERGY_FEEDBACK);
        }

        void KilledUnit(Unit* victim)
        {
            if (victim->GetTypeId() == TYPEID_PLAYER)
                Talk(SAY_KILL);
        }

        void JustDied(Unit* /*killer*/)
        {
            summons.DespawnAll();
            instance->SetData(DATA_VEXALLUS_EVENT, DONE);
            instance->DoRemoveAurasDueToSpellOnPlayers(SPELL_ENERGY_FEEDBACK);
        }

        void EnterCombat(Unit* /*who*/)
        {
            Talk(SAY_AGGRO);
            instance->SetData(DATA_VEXALLUS_EVENT, IN_PROGRESS);

            events.ScheduleEvent(EVENT_SPELL_CHAIN_LIGHTNING, 8000);
            events.ScheduleEvent(EVENT_SPELL_ARCANE_SHOCK, 5000);
            events.ScheduleEvent(EVENT_HEALTH_CHECK, 1000);
        }

        void JustSummoned(Creature* summon)
        {
            if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0))
            {
                summon->GetMotionMaster()->MoveFollow(target, 0.0f, 0.0f);
                summon->CastSpell(target, SPELL_ENERGY_FEEDBACK_CHANNEL, false);
            }
            summons.Summon(summon);
        }

        void SummonedCreatureDies(Creature* summon, Unit* killer)
        {
            summons.Despawn(summon);
            summon->DespawnOrUnsummon(1);
            if (killer)
                killer->CastSpell(killer, SPELL_ENERGY_FEEDBACK, true, 0, 0, summon->GetGUID());
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
                case EVENT_HEALTH_CHECK:
                    //used for check, when Vexallus cast adds 85%, 70%, 55%, 40%
                    if (!HealthAbovePct(100 - INTERVAL_MODIFIER * IntervalHealthAmount))
                    {
                        if (IntervalHealthAmount++ == INTERVAL_SWITCH)
                        {
                            events.Reset();
                            me->CastSpell(me, SPELL_OVERLOAD, true);
                            return;
                        }
                            
                        Talk(SAY_ENERGY);
                        Talk(EMOTE_DISCHARGE_ENERGY);

                        if (IsHeroic())
                        {
                            me->CastSpell(me, SPELL_SUMMON_PURE_ENERGY_H1, false);
                            me->CastSpell(me, SPELL_SUMMON_PURE_ENERGY_H2, false);
                        }
                        else
                            me->CastSpell(me, SPELL_SUMMON_PURE_ENERGY_N, false);
                    }
                    events.ScheduleEvent(EVENT_HEALTH_CHECK, 0);
                    break;
                case EVENT_SPELL_CHAIN_LIGHTNING:
                    if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0))
                        me->CastSpell(target, DUNGEON_MODE(SPELL_CHAIN_LIGHTNING_N, SPELL_CHAIN_LIGHTNING_H), false);
                    events.ScheduleEvent(EVENT_SPELL_CHAIN_LIGHTNING, 8000);
                    break;
                case EVENT_SPELL_ARCANE_SHOCK:
                    if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 20.0f))
                        me->CastSpell(target, DUNGEON_MODE(SPELL_ARCANE_SHOCK_N, SPELL_ARCANE_SHOCK_H), false);
                    events.ScheduleEvent(EVENT_SPELL_ARCANE_SHOCK, 8000);
                    break;
            }

            DoMeleeAttackIfReady();
        }
    };
};

void AddSC_boss_vexallus()
{
    new boss_vexallus();
}

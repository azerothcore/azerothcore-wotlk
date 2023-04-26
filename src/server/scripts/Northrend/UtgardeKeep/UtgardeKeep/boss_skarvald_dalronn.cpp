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

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "utgarde_keep.h"

enum eTexts
{
    // Skarvald
    YELL_SKARVALD_AGGRO                         = 0,
    YELL_SKARVALD_DAL_DIED                      = 1,
    YELL_SKARVALD_SKA_DIEDFIRST                 = 2,
    YELL_SKARVALD_KILL                          = 3,
    YELL_SKARVALD_DAL_DIEDFIRST                 = 4,

    // Dalronn
    YELL_DALRONN_AGGRO                          = 0,
    YELL_DALRONN_SKA_DIED                       = 1,
    YELL_DALRONN_DAL_DIEDFIRST                  = 2,
    YELL_DALRONN_KILL                           = 3,
    YELL_DALRONN_SKA_DIEDFIRST                  = 4
};

enum eSpells
{
    // Skarvald
    SPELL_CHARGE                                = 43651,
    SPELL_STONE_STRIKE                          = 48583,
    SPELL_ENRAGE                                = 48193,
    SPELL_SUMMON_SKARVALD_GHOST                 = 48613,
    // Dalronn
    SPELL_SHADOW_BOLT_N                         = 43649,
    SPELL_SHADOW_BOLT_H                         = 59575,
    SPELL_DEBILITATE                            = 43650,
    SPELL_SUMMON_SKELETONS                      = 52611,
    SPELL_SUMMON_DALRONN_GHOST                  = 48612
};

enum eEvents
{
    // Skarvald
    EVENT_SHARVALD_CHARGE                       = 1,
    EVENT_STONE_STRIKE,
    EVENT_ENRAGE,
    // Dalronn
    EVENT_SHADOW_BOLT,
    EVENT_DEBILITATE,
    EVENT_SUMMON_SKELETONS,

    EVENT_YELL_DALRONN_AGGRO,
    EVENT_MATE_DIED
};

class boss_skarvald_the_constructor : public CreatureScript
{
public:
    boss_skarvald_the_constructor() : CreatureScript("boss_skarvald_the_constructor") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetUtgardeKeepAI<boss_skarvald_the_constructorAI>(pCreature);
    }

    struct boss_skarvald_the_constructorAI : public ScriptedAI
    {
        boss_skarvald_the_constructorAI(Creature* c) : ScriptedAI(c)
        {
            pInstance = c->GetInstanceScript();
        }

        InstanceScript* pInstance;
        EventMap events;

        void Reset() override
        {
            me->SetLootMode(0);
            events.Reset();
            if (me->GetEntry() == NPC_SKARVALD)
            {
                if (pInstance)
                {
                    pInstance->SetData(DATA_DALRONN_AND_SKARVALD, NOT_STARTED);
                }
            }
            else // NPC_SKARVALD_GHOST
            {
                if (Unit* target = me->SelectNearestTarget(50.0f))
                {
                    me->AddThreat(target, 0.0f);
                    AttackStart(target);
                }
            }
        }

        void DoAction(int32 param) override
        {
            switch (param)
            {
                case 1:
                    events.RescheduleEvent(EVENT_MATE_DIED, 3500ms);
                    break;
            }
        }

        void JustEngagedWith(Unit* who) override
        {
            events.Reset();
            events.RescheduleEvent(EVENT_SHARVALD_CHARGE, 5s);
            events.RescheduleEvent(EVENT_STONE_STRIKE, 10s);
            if (me->GetEntry() == NPC_SKARVALD)
            {
                Talk(YELL_SKARVALD_AGGRO);
                if (IsHeroic())
                {
                    events.ScheduleEvent(EVENT_ENRAGE, 1s);
                }
            }
            if (pInstance)
            {
                pInstance->SetData(DATA_DALRONN_AND_SKARVALD, IN_PROGRESS);
                if (Creature* dalronn = pInstance->instance->GetCreature(pInstance->GetGuidData(DATA_DALRONN)))
                {
                    if (!dalronn->IsInCombat() && who)
                    {
                        dalronn->AddThreat(who, 0.0f);
                        dalronn->AI()->AttackStart(who);
                    }
                }
            }
        }

        void KilledUnit(Unit* /*victim*/) override
        {
            if (me->GetEntry() == NPC_SKARVALD)
            {
                Talk(YELL_SKARVALD_KILL);
            }
        }

        void JustDied(Unit*  /*Killer*/) override
        {
            if (me->GetEntry() != NPC_SKARVALD)
                return;

            if (pInstance)
            {
                if (Creature* dalronn = pInstance->instance->GetCreature(pInstance->GetGuidData(DATA_DALRONN)))
                {
                    if (dalronn->isDead())
                    {
                        Talk(YELL_SKARVALD_SKA_DIEDFIRST);
                        pInstance->SetData(DATA_DALRONN_AND_SKARVALD, DONE);
                        pInstance->SetData(DATA_UNLOCK_SKARVALD_LOOT, 0);
                        return;
                    }
                    else
                    {
                        Talk(YELL_SKARVALD_DAL_DIED);
                        dalronn->AI()->DoAction(1);
                    }
                }
            }
            me->CastSpell((Unit*)nullptr, SPELL_SUMMON_SKARVALD_GHOST, true);
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
                case 0:
                    break;
                case EVENT_MATE_DIED:
                    Talk(YELL_SKARVALD_DAL_DIEDFIRST);
                    break;
                case EVENT_SHARVALD_CHARGE:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, (IsHeroic() ? 100.0f : 30.0f), true))
                    {
                        DoResetThreatList();
                        me->AddThreat(target, 10000.0f);
                        me->CastSpell(target, SPELL_CHARGE, false);
                    }
                    events.Repeat(5s, 10s);
                    break;
                case EVENT_STONE_STRIKE:
                    if (me->GetVictim() && me->IsWithinMeleeRange(me->GetVictim()))
                    {
                        me->CastSpell(me->GetVictim(), SPELL_STONE_STRIKE, false);
                        events.Repeat(5s, 10s);
                    }
                    else
                    {
                        events.Repeat(3s);
                    }
                    break;
                case EVENT_ENRAGE:
                    if (me->GetHealthPct() <= 60)
                    {
                        me->CastSpell(me, SPELL_ENRAGE, true);
                        break;
                    }
                    events.Repeat(1s);
                    break;
            }
            DoMeleeAttackIfReady();
        }
    };
};

class boss_dalronn_the_controller : public CreatureScript
{
public:
    boss_dalronn_the_controller() : CreatureScript("boss_dalronn_the_controller") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetUtgardeKeepAI<boss_dalronn_the_controllerAI>(pCreature);
    }

    struct boss_dalronn_the_controllerAI : public ScriptedAI
    {
        boss_dalronn_the_controllerAI(Creature* c) : ScriptedAI(c), summons(me)
        {
            pInstance = c->GetInstanceScript();
        }

        InstanceScript* pInstance;
        EventMap events;
        SummonList summons;

        void Reset() override
        {
            me->SetLootMode(0);
            events.Reset();
            summons.DespawnAll();
            if (me->GetEntry() == NPC_DALRONN)
            {
                if (pInstance)
                {
                    pInstance->SetData(DATA_DALRONN_AND_SKARVALD, NOT_STARTED);
                }
            }
            else // NPC_DALRONN_GHOST
            {
                if (Unit* target = me->SelectNearestTarget(50.0f))
                {
                    me->AddThreat(target, 0.0f);
                    AttackStart(target);
                }
            }
        }

        void DoAction(int32 param) override
        {
            switch (param)
            {
                case -1:
                    summons.DespawnAll();
                    break;
                case 1:
                    events.RescheduleEvent(EVENT_MATE_DIED, 3500ms);
                    break;
            }
        }

        void JustEngagedWith(Unit* who) override
        {
            events.Reset();
            events.RescheduleEvent(EVENT_SHADOW_BOLT, 1s);
            events.RescheduleEvent(EVENT_DEBILITATE, 5s);
            if (IsHeroic())
            {
                events.RescheduleEvent(EVENT_SUMMON_SKELETONS, 10s);
            }
            if (me->GetEntry() == NPC_DALRONN)
            {
                events.RescheduleEvent(EVENT_YELL_DALRONN_AGGRO, 5s);
            }
            if (pInstance)
            {
                pInstance->SetData(DATA_DALRONN_AND_SKARVALD, IN_PROGRESS);
                if (Creature* skarvald = pInstance->instance->GetCreature(pInstance->GetGuidData(DATA_SKARVALD)))
                {
                    if (!skarvald->IsInCombat() && who)
                    {
                        skarvald->AddThreat(who, 0.0f);
                        skarvald->AI()->AttackStart(who);
                    }
                }
            }
        }

        void KilledUnit(Unit* /*victim*/) override
        {
            if (me->GetEntry() == NPC_DALRONN)
            {
                Talk(YELL_DALRONN_KILL);
            }
        }

        void JustSummoned(Creature* minions) override
        {
            summons.Summon(minions);
            minions->SetInCombatWithZone();
        }

        void JustDied(Unit*  /*Killer*/) override
        {
            if (me->GetEntry() != NPC_DALRONN)
                return;

            if (pInstance)
            {
                if (Creature* skarvald = pInstance->instance->GetCreature(pInstance->GetGuidData(DATA_SKARVALD)))
                {
                    if (skarvald->isDead())
                    {
                        Talk(YELL_DALRONN_DAL_DIEDFIRST);
                        pInstance->SetData(DATA_DALRONN_AND_SKARVALD, DONE);
                        pInstance->SetData(DATA_UNLOCK_DALRONN_LOOT, 0);
                        return;
                    }
                    else
                    {
                        Talk(YELL_DALRONN_SKA_DIED);
                        skarvald->AI()->DoAction(1);
                    }
                }
            }
            me->CastSpell((Unit*)nullptr, SPELL_SUMMON_DALRONN_GHOST, true);
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
                case 0:
                    break;
                case EVENT_YELL_DALRONN_AGGRO:
                    Talk(YELL_DALRONN_AGGRO);
                    break;
                case EVENT_MATE_DIED:
                    Talk(YELL_DALRONN_SKA_DIEDFIRST);
                    break;
                case EVENT_SHADOW_BOLT:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 40.0f, true))
                    {
                        me->CastSpell(target, DUNGEON_MODE(SPELL_SHADOW_BOLT_N, SPELL_SHADOW_BOLT_H), false);
                    }
                    events.Repeat(2s);
                    break;
                case EVENT_DEBILITATE:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 45.0f, true))
                    {
                        me->CastSpell(target, SPELL_DEBILITATE, false);
                        events.Repeat(5s, 10s);
                    }
                    else
                    {
                        events.Repeat(3s);
                    }
                    break;
                case EVENT_SUMMON_SKELETONS:
                    me->CastSpell((Unit*)nullptr, SPELL_SUMMON_SKELETONS, false);
                    events.Repeat(20s, 30s);
                    break;
            }
            DoMeleeAttackIfReady();
        }
    };
};

void AddSC_boss_skarvald_dalronn()
{
    new boss_skarvald_the_constructor();
    new boss_dalronn_the_controller();
}

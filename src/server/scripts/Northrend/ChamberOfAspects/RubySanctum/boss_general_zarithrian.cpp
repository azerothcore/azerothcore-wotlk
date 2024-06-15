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

#include "CreatureScript.h"
#include "ScriptedCreature.h"
#include "ScriptedEscortAI.h"
#include "ruby_sanctum.h"

enum Texts
{
    SAY_AGGRO                   = 0,
    SAY_KILL                    = 1,
    SAY_ADDS                    = 2,
    SAY_DEATH                   = 3
};

enum Spells
{
    // General Zarithrian
    SPELL_INTIMIDATING_ROAR     = 74384,
    SPELL_CLEAVE_ARMOR          = 74367,
    SPELL_SUMMON_FLAMECALLER    = 74398,

    // Onyx Flamecaller
    SPELL_BLAST_NOVA            = 74392,
    SPELL_LAVA_GOUT             = 74394
};

enum Misc
{
    // General Zarithrian
    EVENT_CLEAVE                    = 1,
    EVENT_INTIDMDATING_ROAR         = 2,
    EVENT_SUMMON_ADDS1              = 3,
    EVENT_SUMMON_ADDS2              = 4,
    EVENT_KILL_TALK                 = 5,

    // Onyx Flamecaller
    EVENT_BLAST_NOVA                = 6,
    EVENT_LAVA_GOUT                 = 7,

    MAX_PATH_FLAMECALLER_WAYPOINTS  = 12
};

// East
Position const FlamecallerWaypointsE[MAX_PATH_FLAMECALLER_WAYPOINTS] =
{
    {3042.971f, 419.8809f, 86.94320f, 0.0f},
    {3043.971f, 419.8809f, 86.94320f, 0.0f},
    {3044.885f, 428.8281f, 86.19320f, 0.0f},
    {3045.494f, 434.7930f, 85.56398f, 0.0f},
    {3045.900f, 438.7695f, 84.81398f, 0.0f},
    {3045.657f, 456.8290f, 85.95601f, 0.0f},
    {3043.657f, 459.0790f, 87.20601f, 0.0f},
    {3042.157f, 460.5790f, 87.70601f, 0.0f},
    {3040.907f, 462.0790f, 88.45601f, 0.0f},
    {3038.907f, 464.0790f, 89.20601f, 0.0f},
    {3025.907f, 478.0790f, 89.70601f, 0.0f},
    {3003.832f, 501.2510f, 89.47303f, 0.0f}
};

// West
Position const FlamecallerWaypointsW[MAX_PATH_FLAMECALLER_WAYPOINTS] =
{
    {3062.596f, 636.9980f, 82.50338f, 0.0f},
    {3062.514f, 624.9980f, 83.70634f, 0.0f},
    {3062.486f, 620.9980f, 84.33134f, 0.0f},
    {3062.445f, 613.9930f, 84.45634f, 0.0f},
    {3062.445f, 613.9930f, 84.45634f, 0.0f},
    {3059.208f, 610.6501f, 85.39581f, 0.0f},
    {3055.958f, 606.9001f, 86.14581f, 0.0f},
    {3046.458f, 596.4001f, 86.89581f, 0.0f},
    {3043.958f, 593.4001f, 87.64581f, 0.0f},
    {3040.458f, 589.9001f, 88.39581f, 0.0f},
    {3034.458f, 583.1501f, 88.89581f, 0.0f},
    {3014.970f, 561.8073f, 88.83527f, 0.0f},
};

class boss_general_zarithrian : public CreatureScript
{
public:
    boss_general_zarithrian() : CreatureScript("boss_general_zarithrian") { }

    struct boss_general_zarithrianAI : public BossAI
    {
        boss_general_zarithrianAI(Creature* creature) : BossAI(creature, DATA_GENERAL_ZARITHRIAN)
        {
        }

        void Reset() override
        {
            BossAI::Reset();
            if (instance->GetBossState(DATA_SAVIANA_RAGEFIRE) == DONE && instance->GetBossState(DATA_BALTHARUS_THE_WARBORN) == DONE)
            {
                me->RemoveUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
                me->SetImmuneToPC(false);
            }
        }

        void JustEngagedWith(Unit* who) override
        {
            BossAI::JustEngagedWith(who);
            Talk(SAY_AGGRO);

            events.ScheduleEvent(EVENT_CLEAVE, 9s);
            events.ScheduleEvent(EVENT_INTIDMDATING_ROAR, 14s);
            events.ScheduleEvent(EVENT_SUMMON_ADDS1, 18s);
            if (Is25ManRaid())
                events.ScheduleEvent(EVENT_SUMMON_ADDS2, 20s);
        }

        void JustSummoned(Creature* summon) override
        {
            summons.Summon(summon);
        }

        void JustDied(Unit* killer) override
        {
            BossAI::JustDied(killer);
            Talk(SAY_DEATH);
        }

        void KilledUnit(Unit*  /*victim*/) override
        {
            if (events.GetNextEventTime(EVENT_KILL_TALK) == 0)
            {
                Talk(SAY_KILL);
                events.ScheduleEvent(EVENT_KILL_TALK, 6s);
            }
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
                case EVENT_SUMMON_ADDS1:
                    Talk(SAY_ADDS);
                    if (Creature* stalker1 = ObjectAccessor::GetCreature(*me, instance->GetGuidData(DATA_ZARITHRIAN_SPAWN_STALKER_1)))
                        stalker1->CastSpell(stalker1, SPELL_SUMMON_FLAMECALLER, false);
                    if (Creature* stalker2 = ObjectAccessor::GetCreature(*me, instance->GetGuidData(DATA_ZARITHRIAN_SPAWN_STALKER_2)))
                        stalker2->CastSpell(stalker2, SPELL_SUMMON_FLAMECALLER, false);
                    events.ScheduleEvent(EVENT_SUMMON_ADDS1, 40s);
                    break;
                case EVENT_SUMMON_ADDS2:
                    if (Creature* stalker1 = ObjectAccessor::GetCreature(*me, instance->GetGuidData(DATA_ZARITHRIAN_SPAWN_STALKER_1)))
                        stalker1->CastSpell(stalker1, SPELL_SUMMON_FLAMECALLER, false);
                    if (Creature* stalker2 = ObjectAccessor::GetCreature(*me, instance->GetGuidData(DATA_ZARITHRIAN_SPAWN_STALKER_2)))
                        stalker2->CastSpell(stalker2, SPELL_SUMMON_FLAMECALLER, false);
                    events.ScheduleEvent(EVENT_SUMMON_ADDS2, 40s);
                    break;
                case EVENT_INTIDMDATING_ROAR:
                    me->CastSpell(me, SPELL_INTIMIDATING_ROAR, false);
                    events.ScheduleEvent(EVENT_INTIDMDATING_ROAR, 30s);
                    break;
                case EVENT_CLEAVE:
                    me->CastSpell(me->GetVictim(), SPELL_CLEAVE_ARMOR, false);
                    events.ScheduleEvent(EVENT_CLEAVE, 15s);
                    break;
            }

            DoMeleeAttackIfReady();
        }

        bool CheckEvadeIfOutOfCombatArea() const override
        {
            return me->GetPositionX() > 3060.0f;
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetRubySanctumAI<boss_general_zarithrianAI>(creature);
    }
};

class npc_onyx_flamecaller : public CreatureScript
{
public:
    npc_onyx_flamecaller() : CreatureScript("npc_onyx_flamecaller") { }

    struct npc_onyx_flamecallerAI : public npc_escortAI
    {
        npc_onyx_flamecallerAI(Creature* creature) : npc_escortAI(creature), _instance(creature->GetInstanceScript())
        {
            npc_escortAI::SetDespawnAtEnd(false);
        }

        void Reset() override
        {
            _lavaGoutCount = 0;
            AddWaypoints();
            Start(true, true);
        }

        void JustEngagedWith(Unit* /*who*/) override
        {
            _events.Reset();
            _events.ScheduleEvent(EVENT_BLAST_NOVA, 20s, 30s);
            _events.ScheduleEvent(EVENT_LAVA_GOUT, 5s);
        }

        void EnterEvadeMode(EvadeReason /*why*/) override
        {
            // Prevent EvadeMode
        }

        void IsSummonedBy(WorldObject* /*summoner*/) override
        {
            // Let Zarithrian count as summoner. _instance cant be null since we got GetRubySanctumAI
            if (Creature* zarithrian = ObjectAccessor::GetCreature(*me, _instance->GetGuidData(NPC_GENERAL_ZARITHRIAN)))
                zarithrian->AI()->JustSummoned(me);
        }

        void WaypointReached(uint32 waypointId) override
        {
            if (waypointId == MAX_PATH_FLAMECALLER_WAYPOINTS)
                me->SetInCombatWithZone();
        }

        void AddWaypoints()
        {
            if (me->GetPositionY() < 500.0f)
            {
                for (uint8 i = 0; i < MAX_PATH_FLAMECALLER_WAYPOINTS; i++)
                    AddWaypoint(i + 1, FlamecallerWaypointsE[i].GetPositionX(), FlamecallerWaypointsE[i].GetPositionY(), FlamecallerWaypointsE[i].GetPositionZ());
            }
            else
            {
                for (uint8 i = 0; i < MAX_PATH_FLAMECALLER_WAYPOINTS; i++)
                    AddWaypoint(i + 1, FlamecallerWaypointsW[i].GetPositionX(), FlamecallerWaypointsW[i].GetPositionY(), FlamecallerWaypointsW[i].GetPositionZ());
            }
        }

        void UpdateEscortAI(uint32 diff) override
        {
            if (!UpdateVictim())
                return;

            _events.Update(diff);
            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (_events.ExecuteEvent())
            {
                case EVENT_BLAST_NOVA:
                    DoCastAOE(SPELL_BLAST_NOVA);
                    _events.ScheduleEvent(EVENT_BLAST_NOVA, 20s, 30s);
                    break;
                case EVENT_LAVA_GOUT:
                    if (_lavaGoutCount >= 3)
                    {
                        _lavaGoutCount = 0;
                        _events.ScheduleEvent(EVENT_LAVA_GOUT, 8s);
                        break;
                    }
                    DoCastVictim(SPELL_LAVA_GOUT);
                    _lavaGoutCount++;
                    _events.ScheduleEvent(EVENT_LAVA_GOUT, 1500ms);
                    break;
            }

            DoMeleeAttackIfReady();
        }
    private:
        EventMap _events;
        InstanceScript* _instance;
        uint8 _lavaGoutCount;
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetRubySanctumAI<npc_onyx_flamecallerAI>(creature);
    }
};

void AddSC_boss_general_zarithrian()
{
    new boss_general_zarithrian();
    new npc_onyx_flamecaller();
}

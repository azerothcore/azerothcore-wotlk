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

#include "CreatureScript.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "halls_of_stone.h"

enum Spells
{
    // SJONNIR
    SPELL_FRENZY                            = 28747, //at 20% hp
    SPELL_CHAIN_LIGHTNING                   = 50830,
    SPELL_LIGHTNING_SHIELD                  = 50831,
    SPELL_STATIC_CHARGE                     = 50834,
    SPELL_LIGHTNING_RING                    = 50840,
    SPELL_LIGHTNING_RING_5S                 = 51849,

    // IRON SLUDGE
    SPELL_TOXIC_VOLLEY                      = 50838,

    // FORGED IRON DWARF
    SPELL_LIGHTNING_TETHER                  = 50895,

    // FORGED IRON TROGG
    SPELL_LIGHTNING_SHOCK                   = 50900,
};

enum Npc
{
    NPC_DWARFES_FRIENDLY                    = 27980, //after fix the machine by Brann
    NPC_OOZE                                = 27981, //spawn after killing dwarf
    NPC_FORGED_IRON_DWARF                   = 27982,
    NPC_FORGED_IRON_TROGG                   = 27979,
};

enum Yells
{
    SAY_AGGRO                                              = 0,
    SAY_SLAY                                               = 1,
    SAY_DEATH                                              = 2
};

enum Events
{
    // TRASH
    EVENT_MALFORMED_OOZE_CHECK              = 10,
    EVENT_TOXIC_VOLLEY                      = 11,
    EVENT_FORGED_LIGHTNING_SHOCK            = 12,
    EVENT_FORGED_LIGHTNING_TETHER           = 13,
};

enum SjonnirMisc
{
    GROUP_SUMMONS                           = 1,
    GROUP_LIGHTNING_RING                    = 2,

    POS_GEN_RIGHT                           = 0,
    POS_GEN_LEFT                            = 1,
    POS_ROOM_CENTER                         = 2,

    // ACTIONS
    ACTION_SLUG_KILLED                      = 1,
};

static Position RoomPosition[] =
{
    {1293.0f, 610.0f, 199.3f, 0.0f},
    {1294.2f, 724.3f, 199.3f, 0.0f},
    {1295.2f, 667.1f, 189.7f, 0.0f},
};

class boss_sjonnir : public CreatureScript
{
public:
    boss_sjonnir() : CreatureScript("boss_sjonnir") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetHallsOfStoneAI<boss_sjonnirAI>(pCreature);
    }

    struct boss_sjonnirAI : public BossAI
    {
        boss_sjonnirAI(Creature* c) : BossAI(c, BOSS_SJONNIR) { }

        uint8 SlugeCount;

        void Reset() override
        {
            _Reset();
            scheduler.ClearValidator();
            SlugeCount = 0;
            instance->SetData(DATA_SJONNIR_ACHIEVEMENT, false);

            if (instance->GetData(BOSS_TRIBUNAL_OF_AGES) == DONE)
            {
                if (GameObject* console = me->GetMap()->GetGameObject(instance->GetGuidData(GO_SJONNIR_CONSOLE)))
                    console->SetGoState(GO_STATE_READY);

                if (Creature* brann = ObjectAccessor::GetCreature(*me, instance->GetGuidData(NPC_BRANN)))
                {
                    brann->setDeathState(DeathState::JustDied);
                    brann->Respawn();
                    brann->AI()->DoAction(ACTION_SJONNIR_WIPE_START);
                }
            }

            ScheduleHealthCheckEvent(75, [&] {
                scheduler.CancelGroup(GROUP_SUMMONS);
                scheduler.Schedule(1s, GROUP_SUMMONS, [&](TaskContext context) {
                    uint8 Pos = urand(POS_GEN_RIGHT, POS_GEN_LEFT);
                    me->SummonCreature(NPC_FORGED_IRON_TROGG, RoomPosition[Pos].GetPositionX(), RoomPosition[Pos].GetPositionY(), RoomPosition[Pos].GetPositionZ(), 0, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 20000);
                    ActivatePipe(Pos);
                    context.Repeat(5s, 7s);
                });
            });

            ScheduleHealthCheckEvent(50, [&] {
                if (Creature* brann = ObjectAccessor::GetCreature(*me, instance->GetGuidData(NPC_BRANN)))
                    brann->AI()->Talk(SAY_BRANN_SPAWN_OOZE);

                scheduler.CancelGroup(GROUP_SUMMONS);
                scheduler.Schedule(3s, GROUP_SUMMONS, [&](TaskContext context) {
                    uint8 pos = urand(POS_GEN_RIGHT, POS_GEN_LEFT);
                    if (Creature* ooze = me->SummonCreature(NPC_OOZE, RoomPosition[pos], TEMPSUMMON_CORPSE_TIMED_DESPAWN, 20000))
                    {
                        ActivatePipe(pos);
                        ooze->GetMotionMaster()->MovePoint(0, RoomPosition[POS_ROOM_CENTER].GetPositionX(), RoomPosition[POS_ROOM_CENTER].GetPositionY(), RoomPosition[POS_ROOM_CENTER].GetPositionZ());
                        ooze->SetReactState(REACT_PASSIVE);
                        ooze->SetWalk(true);
                    }

                    context.Repeat();
                });
            });

            ScheduleHealthCheckEvent(25, [&] {
                if (Creature* brann = ObjectAccessor::GetCreature(*me, instance->GetGuidData(NPC_BRANN)))
                    brann->AI()->Talk(SAY_BRANN_SPAWN_EARTHEN);

                scheduler.CancelGroup(GROUP_SUMMONS);
                scheduler.Schedule(1s, GROUP_SUMMONS, [&](TaskContext context) {
                    for (int i = 0; i < 3; i++)
                    {
                        uint8 pos = urand(POS_GEN_RIGHT, POS_GEN_LEFT);
                        if (Creature* dwarf = me->SummonCreature(NPC_DWARFES_FRIENDLY, RoomPosition[pos], TEMPSUMMON_CORPSE_TIMED_DESPAWN, 20000))
                        {
                            if (Player* plr = SelectTargetFromPlayerList(100.0f))
                                dwarf->SetFaction(plr->GetFaction());

                            ActivatePipe(pos);
                            dwarf->AI()->AttackStart(me);
                        }
                    }

                    context.Repeat(10s, 20s);
                });
            });

            ScheduleHealthCheckEvent(20, [&] {
                scheduler.CancelGroup(GROUP_LIGHTNING_RING);
                DoCastSelf(SPELL_FRENZY, true);

                ScheduleTimedEvent(1s, [&] {
                    DoCastSelf(SPELL_LIGHTNING_RING_5S);
                }, 11s);
            });
        }

        void ScheduleTasks() override
        {
            ScheduleTimedEvent(14s, 19s, [&] {
                DoCastSelf(SPELL_LIGHTNING_SHIELD);
            }, 14s, 19s);

            ScheduleTimedEvent(6s, 12s, [&] {
                DoCastVictim(SPELL_CHAIN_LIGHTNING);
            }, 6s, 12s);

            ScheduleTimedEvent(24s, [&] {
                DoCastRandomTarget(SPELL_STATIC_CHARGE, 0, 50.0f);
            }, 20s);

            scheduler.Schedule(30s, GROUP_LIGHTNING_RING, [&](TaskContext context) {
                DoCastAOE(SPELL_LIGHTNING_RING);
                context.Repeat(40s);
            });

            if (Creature* brann = ObjectAccessor::GetCreature(*me, instance->GetGuidData(NPC_BRANN)))
                brann->AI()->Talk(SAY_BRANN_SPAWN_TROGG, 20s);

            scheduler.Schedule(5s, GROUP_SUMMONS, [&](TaskContext context) {
                uint8 pos = urand(POS_GEN_RIGHT, POS_GEN_LEFT);
                me->SummonCreature(NPC_FORGED_IRON_DWARF, RoomPosition[pos], TEMPSUMMON_CORPSE_TIMED_DESPAWN, 20000);
                ActivatePipe(pos);
                context.Repeat(30s);
            });
        }

        void JustEngagedWith(Unit*  /*who*/) override
        {
            _JustEngagedWith();
            Talk(SAY_AGGRO);

            if (GameObject* doors = me->GetMap()->GetGameObject(instance->GetGuidData(GO_SJONNIR_DOOR)))
                doors->SetGoState(GO_STATE_READY);

            if (instance->GetData(BOSS_TRIBUNAL_OF_AGES) == DONE)
                if (Creature* brann = ObjectAccessor::GetCreature(*me, instance->GetGuidData(NPC_BRANN)))
                    brann->AI()->DoAction(ACTION_START_SJONNIR_FIGHT);
        }

        void DoAction(int32 param) override
        {
            if (param == ACTION_SLUG_KILLED)
            {
                SlugeCount++;
                if (SlugeCount >= 5)
                    instance->SetData(DATA_SJONNIR_ACHIEVEMENT, true);
            }
        }

        void JustDied(Unit*  /*killer*/) override
        {
            Talk(SAY_DEATH);
            _JustDied();
            if (GameObject* sd = me->GetMap()->GetGameObject(instance->GetGuidData(GO_SJONNIR_DOOR)))
                sd->SetGoState(GO_STATE_ACTIVE);

            if (Creature* brann = ObjectAccessor::GetCreature(*me, instance->GetGuidData(NPC_BRANN)))
                brann->AI()->DoAction(ACTION_SJONNIR_DEAD);
        }

        void KilledUnit(Unit* /*victim*/) override
        {
            if (urand(0, 1))
                return;

            Talk(SAY_SLAY);
        }

        void ActivatePipe(uint8 side)
        {
            if (GameObject* pipe = me->GetMap()->GetGameObject(instance->GetGuidData(side == POS_GEN_RIGHT ? GO_RIGHT_PIPE : GO_LEFT_PIPE)))
                pipe->SendCustomAnim(0);
        }
    };
};

class boss_sjonnir_dwarf : public CreatureScript
{
public:
    boss_sjonnir_dwarf() : CreatureScript("boss_sjonnir_dwarf") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetHallsOfStoneAI<boss_sjonnir_dwarfAI>(pCreature);
    }

    struct boss_sjonnir_dwarfAI : public ScriptedAI
    {
        boss_sjonnir_dwarfAI(Creature* c) : ScriptedAI(c) { }

        void UpdateAI(uint32  /*diff*/) override
        {
            if (!UpdateVictim())
                return;

            DoSpellAttackIfReady((me->GetEntry() == NPC_FORGED_IRON_DWARF) ? SPELL_LIGHTNING_TETHER : SPELL_LIGHTNING_SHOCK);
        }
    };
};

class boss_sjonnir_iron_sludge : public CreatureScript
{
public:
    boss_sjonnir_iron_sludge() : CreatureScript("boss_sjonnir_iron_sludge") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetHallsOfStoneAI<boss_sjonnir_iron_sludgeAI>(pCreature);
    }

    struct boss_sjonnir_iron_sludgeAI : public ScriptedAI
    {
        boss_sjonnir_iron_sludgeAI(Creature* c) : ScriptedAI(c) { }

        EventMap events;
        void Reset() override
        {
            events.Reset();
        }

        void JustEngagedWith(Unit*) override
        {
            events.ScheduleEvent(EVENT_TOXIC_VOLLEY, 5s);
        }
        void JustDied(Unit*  /*killer*/) override
        {
            if (InstanceScript* instance = me->GetInstanceScript())
                if (Creature* sjonnir = instance->GetCreature(BOSS_SJONNIR))
                    sjonnir->AI()->DoAction(ACTION_SLUG_KILLED);
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
                // Every 5 seconds
                case EVENT_TOXIC_VOLLEY:
                    {
                        me->CastSpell(me, SPELL_TOXIC_VOLLEY, false);
                        events.Repeat(5s);
                        break;
                    }
            }

            DoMeleeAttackIfReady();
        }
    };
};

//OOZE
class boss_sjonnir_malformed_ooze : public CreatureScript
{
public:
    boss_sjonnir_malformed_ooze() : CreatureScript("boss_sjonnir_malformed_ooze") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetHallsOfStoneAI<boss_sjonnir_malformed_oozeAI>(pCreature);
    }

    struct boss_sjonnir_malformed_oozeAI : public ScriptedAI
    {
        boss_sjonnir_malformed_oozeAI(Creature* c) : ScriptedAI(c) {    }

        EventMap events;
        void MovementInform(uint32 type, uint32 point) override
        {
            if (type == POINT_MOTION_TYPE && point == 0)
                events.RescheduleEvent(EVENT_MALFORMED_OOZE_CHECK, 1s);
        }

        void JustEngagedWith(Unit*) override { }
        void MoveInLineOfSight(Unit*) override { }

        void UpdateAI(uint32 diff) override
        {
            events.Update(diff);
            switch (events.ExecuteEvent())
            {
                case EVENT_MALFORMED_OOZE_CHECK:
                    {
                        std::list<Creature*> oozeList;
                        me->GetCreaturesWithEntryInRange(oozeList, 5.0f, NPC_OOZE);
                        for (std::list<Creature*>::const_iterator itr = oozeList.begin(); itr != oozeList.end(); ++itr)
                            if ((*itr)->GetGUID() != me->GetGUID() && (*itr)->IsAlive() && me->IsAlive())
                                if (Creature* is = me->SummonCreature(NPC_IRON_SLUDGE, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 20000))
                                {
                                    me->KillSelf();
                                    Unit::Kill(*itr, *itr);
                                    is->SetInCombatWithZone();
                                    break;
                                }

                        events.Repeat(1s);
                        break;
                    }
            }
        }
    };
};

void AddSC_boss_sjonnir()
{
    new boss_sjonnir();
    new boss_sjonnir_dwarf();
    new boss_sjonnir_malformed_ooze();
    new boss_sjonnir_iron_sludge();
}

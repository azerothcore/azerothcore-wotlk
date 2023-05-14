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
#include "shattered_halls.h"

enum Spells
{
    SPELL_BLAST_WAVE            = 30600,
    SPELL_FEAR                  = 30584,
    SPELL_THUNDERCLAP           = 30633,
    SPELL_BEATDOWN              = 30618,
    SPELL_BURNING_MAUL          = 30598
};

enum Equip
{
    EQUIP_STANDARD              = 1,
    EQUIP_BURNING_MAUL          = 2
};

enum Creatures
{
    NPC_LEFT_HEAD               = 19523,
    NPC_RIGHT_HEAD              = 19524
};

enum Misc
{
    EMOTE_ENRAGE                = 0,

    SETDATA_DATA                = 1,
    SETDATA_YELL                = 1
};

enum Events
{
    EVENT_AGGRO_YELL_1          = 1,
    EVENT_AGGRO_YELL_2          = 2,
    EVENT_AGGRO_YELL_3          = 3,
    EVENT_THREAT_YELL_L_1       = 4,
    EVENT_THREAT_YELL_L_2       = 5,
    EVENT_THREAT_YELL_L_3       = 6,
    EVENT_THREAT_YELL_R_1       = 7,
    EVENT_KILL_YELL_LEFT        = 8,
    EVENT_KILL_YELL_RIGHT       = 9,
    EVENT_DEATH_YELL            = 10
};

enum Phase
{
    GROUP_NON_BURNING_PHASE     = 0,
    GROUP_BURNING_PHASE         = 1,
    GROUP_FULL_PHASE            = 2
};

struct boss_warbringer_omrogg : public BossAI
{
    boss_warbringer_omrogg(Creature* creature) : BossAI(creature, DATA_OMROGG)
    {
        scheduler.SetValidator([this]
        {
            return !me->HasUnitState(UNIT_STATE_CASTING);
        });
    }

    EventMap events2;

    Creature* GetLeftHead()
    {
        return summons.GetCreatureWithEntry(NPC_LEFT_HEAD);
    }

    Creature* GetRightHead()
    {
        return summons.GetCreatureWithEntry(NPC_RIGHT_HEAD);
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        me->SummonCreature(NPC_LEFT_HEAD, 0.0f, 0.0f, 0.0f, 0.0f, TEMPSUMMON_DEAD_DESPAWN, 0);
        me->SummonCreature(NPC_RIGHT_HEAD, 0.0f, 0.0f, 0.0f, 0.0f, TEMPSUMMON_DEAD_DESPAWN, 0);

        if (Creature* LeftHead = GetLeftHead())
        {
            uint8 aggroYell = urand(EVENT_AGGRO_YELL_1, EVENT_AGGRO_YELL_3);
            LeftHead->AI()->Talk(aggroYell - 1);
            events2.ScheduleEvent(aggroYell, 3000);
        }

        _JustEngagedWith();
        scheduler.Schedule(500ms, GROUP_FULL_PHASE, [this](TaskContext context)
        {
            scheduler.Schedule(12100ms, 17300ms, GROUP_NON_BURNING_PHASE, [this](TaskContext context)
            {
                DoCastAOE(SPELL_THUNDERCLAP);
                context.Repeat(17200ms, 24200ms);
            }).Schedule(20s, 30s, GROUP_NON_BURNING_PHASE, [this](TaskContext /*context*/)
            {
                DoCastSelf(SPELL_BEATDOWN);
                me->SetUnitFlag(UNIT_FLAG_PACIFIED);
                me->SetReactState(REACT_PASSIVE);
                scheduler.Schedule(200ms, GROUP_NON_BURNING_PHASE, [this](TaskContext /*context*/)
                {
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0))
                    {
                        uint8 threatYell = urand(EVENT_THREAT_YELL_L_1, EVENT_THREAT_YELL_R_1);
                        if (Creature* head = threatYell == EVENT_THREAT_YELL_R_1 ? GetRightHead() : GetLeftHead())
                        {
                            head->AI()->Talk(threatYell - 1);
                        }
                        events.ScheduleEvent(threatYell, 3000);
                        DoResetThreatList();
                        me->AddThreat(target, 2250.0f);
                        scheduler.Schedule(1200ms, GROUP_BURNING_PHASE, [this](TaskContext /*context*/)
                        {
                            me->SetReactState(REACT_AGGRESSIVE);
                            me->RemoveUnitFlag(UNIT_FLAG_PACIFIED);
                        });
                    }
                }).Schedule(40s, 60s, GROUP_NON_BURNING_PHASE, [this](TaskContext /*context*/)
                {
                    me->SetUnitFlag(UNIT_FLAG_PACIFIED);
                    me->SetReactState(REACT_PASSIVE);
                    scheduler.Schedule(1200ms, GROUP_NON_BURNING_PHASE, [this](TaskContext /*context*/)
                    {
                        DoCastSelf(SPELL_FEAR);
                        DoCastSelf(SPELL_BURNING_MAUL);
                        me->LoadEquipment(EQUIP_BURNING_MAUL);
                        scheduler.CancelGroup(GROUP_NON_BURNING_PHASE);
                        scheduler.Schedule(200ms, GROUP_BURNING_PHASE, [this](TaskContext /*context*/)
                        {
                            me->Yell("%s roars!", LANG_UNIVERSAL);
                            scheduler.Schedule(2200ms, GROUP_BURNING_PHASE, [this](TaskContext /*context*/)
                            {
                                if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0))
                                {
                                    uint8 threatYell = urand(EVENT_THREAT_YELL_L_1, EVENT_THREAT_YELL_R_1);
                                    if (Creature* head = threatYell == EVENT_THREAT_YELL_R_1 ? GetRightHead() : GetLeftHead())
                                    {
                                        head->AI()->Talk(threatYell - 1);
                                    }
                                    events.ScheduleEvent(threatYell, 3000);
                                    DoResetThreatList();
                                    me->AddThreat(target, 2250.0f);
                                    me->SetReactState(REACT_AGGRESSIVE);
                                    me->RemoveUnitFlag(UNIT_FLAG_PACIFIED);
                                }
                            });
                        });
                        scheduler.Schedule(4850ms, 8500ms, GROUP_BURNING_PHASE, [this](TaskContext context)
                        {
                            DoCastAOE(SPELL_BLAST_WAVE, false);
                            context.Repeat(4850ms, 8500ms);
                        }).Schedule(45s, 60s, GROUP_BURNING_PHASE, [this](TaskContext context)
                        {
                            me->LoadEquipment(EQUIP_STANDARD);
                            context.CancelGroup(GROUP_BURNING_PHASE);
                            scheduler.RescheduleGroup(GROUP_NON_BURNING_PHASE, 5ms);
                            context.RescheduleGroup(GROUP_NON_BURNING_PHASE, 5ms);
                            context.RescheduleGroup(GROUP_FULL_PHASE, 1050ms);
                        });
                    });
                });
            });
        context.Repeat(130s, 150s);
        });
    }

    void JustSummoned(Creature* summoned) override
    {
        summons.Summon(summoned);
    }

    void KilledUnit(Unit* /*victim*/) override
    {
        Creature* head = nullptr;
        uint32 eventId = EVENT_KILL_YELL_LEFT;
        if (urand(0, 1))
        {
            head = GetLeftHead();
            eventId = EVENT_KILL_YELL_LEFT;
        }
        else
        {
            head = GetRightHead();
            eventId = EVENT_KILL_YELL_RIGHT;
        }

        if (head)
        {
            head->AI()->Talk(eventId - 1);
        }
        events2.ScheduleEvent(eventId, 3000);
    }

    void JustDied(Unit* /*killer*/) override
    {
        Creature* LeftHead  = GetLeftHead();
        Creature* RightHead = GetRightHead();
        if (!LeftHead || !RightHead)
            return;

        LeftHead->DespawnOrUnsummon(5000);
        RightHead->DespawnOrUnsummon(5000);
        LeftHead->AI()->Talk(EVENT_DEATH_YELL - 1);
        RightHead->AI()->SetData(SETDATA_DATA, SETDATA_YELL);
        instance->SetBossState(DATA_OMROGG, DONE);
    }

    void UpdateAI(uint32 diff) override
    {
        events2.Update(diff);
        scheduler.Update(diff);
        switch (uint32 eventId = events2.ExecuteEvent())
        {
            case EVENT_AGGRO_YELL_1:
            case EVENT_AGGRO_YELL_2:
            case EVENT_AGGRO_YELL_3:
            case EVENT_KILL_YELL_LEFT:
            case EVENT_THREAT_YELL_L_1:
            case EVENT_THREAT_YELL_L_2:
            case EVENT_THREAT_YELL_L_3:
                if (Creature* RightHead = GetRightHead())
                {
                    RightHead->AI()->Talk(eventId - 1);
                }
                break;
            case EVENT_KILL_YELL_RIGHT:
            case EVENT_THREAT_YELL_R_1:
                if (Creature* LeftHead = GetLeftHead())
                {
                    LeftHead->AI()->Talk(eventId - 1);
                }
                break;
        }

        if (!UpdateVictim())
            return;

        if (me->HasUnitState(UNIT_STATE_CASTING))
            return;

        DoMeleeAttackIfReady();
    }
};

struct npc_omrogg_heads : public NullCreatureAI
{
        npc_omrogg_heads(Creature* creature) : NullCreatureAI(creature)
        {
            timer = 0;
        }

        void SetData(uint32 data, uint32 value) override
        {
            if (data == SETDATA_DATA && value == SETDATA_YELL)
                timer = 1;
        }

        void UpdateAI(uint32 diff) override
        {
            if (timer)
            {
                timer += diff;
                if (timer >= 3000)
                {
                    timer = 0;
                    Talk(EVENT_DEATH_YELL - 1);
                }
            }
        }
        uint32 timer;
};

void AddSC_boss_warbringer_omrogg()
{
    RegisterShatteredHallsCreatureAI(boss_warbringer_omrogg);
    RegisterShatteredHallsCreatureAI(npc_omrogg_heads);
}

/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "shattered_halls.h"

enum Spells
{
    SPELL_BLAST_WAVE            = 30600,
    SPELL_FEAR                  = 30584,
    SPELL_THUNDERCLAP           = 30633,
    SPELL_BURNING_MAUL_N        = 30598,
    SPELL_BURNING_MAUL_H        = 36056,
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
    EVENT_DEATH_YELL            = 10,

    EVENT_SPELL_FEAR            = 20,
    EVENT_SPELL_BURNING_MAUL    = 21,
    EVENT_SPELL_THUNDER_CLAP    = 22,
    EVENT_RESET_THREAT          = 23,
    EVENT_SPELL_BLAST_WAVE      = 24
};

// ########################################################
// Warbringer_Omrogg
// ########################################################

class boss_warbringer_omrogg : public CreatureScript
{
    public:
        boss_warbringer_omrogg() : CreatureScript("boss_warbringer_omrogg") { }

        struct boss_warbringer_omroggAI : public BossAI
        {
            boss_warbringer_omroggAI(Creature* creature) : BossAI(creature, DATA_OMROGG)
            {
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

            void EnterCombat(Unit* /*who*/)
            {
                me->SummonCreature(NPC_LEFT_HEAD, 0.0f, 0.0f, 0.0f, 0.0f, TEMPSUMMON_DEAD_DESPAWN, 0);
                me->SummonCreature(NPC_RIGHT_HEAD, 0.0f, 0.0f, 0.0f, 0.0f, TEMPSUMMON_DEAD_DESPAWN, 0);

                if (Creature* LeftHead = GetLeftHead())
                {
                    uint8 aggroYell = urand(EVENT_AGGRO_YELL_1, EVENT_AGGRO_YELL_3);
                    LeftHead->AI()->Talk(aggroYell-1);
                    events2.ScheduleEvent(aggroYell, 3000);
                }

                _EnterCombat();

                events.ScheduleEvent(EVENT_SPELL_FEAR, 8000);
                events.ScheduleEvent(EVENT_SPELL_BURNING_MAUL, 25000);
                events.ScheduleEvent(EVENT_SPELL_THUNDER_CLAP, 15000);
                events.ScheduleEvent(EVENT_RESET_THREAT, 30000);
            }

            void JustSummoned(Creature* summoned)
            {
                summons.Summon(summoned);
            }

            void KilledUnit(Unit* /*victim*/)
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
                    head->AI()->Talk(eventId-1);

                events2.ScheduleEvent(eventId, 3000);
            }

            void JustDied(Unit* /*killer*/)
            {
                Creature* LeftHead  = GetLeftHead();
                Creature* RightHead = GetRightHead();
                if (!LeftHead || !RightHead)
                    return;

                LeftHead->DespawnOrUnsummon(5000);
                RightHead->DespawnOrUnsummon(5000);

                LeftHead->AI()->Talk(EVENT_DEATH_YELL-1);
                RightHead->AI()->SetData(SETDATA_DATA, SETDATA_YELL);

                instance->SetBossState(DATA_OMROGG, DONE);
            }       

            void UpdateAI(uint32 diff)
            {
                events2.Update(diff);
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
                            RightHead->AI()->Talk(eventId-1);
                        break;
                    case EVENT_KILL_YELL_RIGHT:
                    case EVENT_THREAT_YELL_R_1:
                        if (Creature* LeftHead = GetLeftHead())
                            LeftHead->AI()->Talk(eventId-1);
                        break;
                }

                if (!UpdateVictim())
                    return;

                events.Update(diff);
                if (me->HasUnitState(UNIT_STATE_CASTING))
                    return;

                switch (events.ExecuteEvent())
                {
                    case EVENT_SPELL_FEAR:
                        me->CastSpell(me, SPELL_FEAR, false);
                        events.ScheduleEvent(EVENT_SPELL_FEAR, 22000);
                        break;
                    case EVENT_SPELL_THUNDER_CLAP:
                        me->CastSpell(me, SPELL_THUNDERCLAP, false);
                        events.ScheduleEvent(EVENT_SPELL_THUNDER_CLAP, 25000);
                        break;
                    case EVENT_RESET_THREAT:
                        if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0))
                        {
                            uint8 threatYell = urand(EVENT_THREAT_YELL_L_1, EVENT_THREAT_YELL_R_1);
                            if (Creature* head = threatYell == EVENT_THREAT_YELL_R_1 ? GetRightHead() : GetLeftHead())
                                head->AI()->Talk(threatYell-1);
                            events.ScheduleEvent(threatYell, 3000);

                            DoResetThreat();
                            me->AddThreat(target, 10.0f);
                        }
                        events.ScheduleEvent(EVENT_RESET_THREAT, 30000);
                        break;
                    case EVENT_SPELL_BURNING_MAUL:
                        Talk(EMOTE_ENRAGE);
                        me->CastSpell(me, DUNGEON_MODE(SPELL_BURNING_MAUL_N, SPELL_BURNING_MAUL_H), false);
                        events.ScheduleEvent(EVENT_SPELL_BURNING_MAUL, 40000);
                        events.ScheduleEvent(EVENT_SPELL_BLAST_WAVE, 15000);
                        events.ScheduleEvent(EVENT_SPELL_BLAST_WAVE, 20000);
                        break;
                    case EVENT_SPELL_BLAST_WAVE:
                        me->CastSpell(me, SPELL_BLAST_WAVE, false);
                        break;
                }

                DoMeleeAttackIfReady();
            }
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return GetInstanceAI<boss_warbringer_omroggAI>(creature);
        }
};

class npc_omrogg_heads : public CreatureScript
{
    public:
        npc_omrogg_heads() : CreatureScript("npc_omrogg_heads") { }

        struct npc_omrogg_headsAI : public NullCreatureAI
        {
            npc_omrogg_headsAI(Creature* creature) : NullCreatureAI(creature) { timer = 0; }

            void SetData(uint32 data, uint32 value)
            {
                if (data == SETDATA_DATA && value == SETDATA_YELL)
                    timer = 1;
            }

            void UpdateAI(uint32 diff)
            {
                if (timer)
                {
                    timer += diff;
                    if (timer >= 3000)
                    {
                        timer = 0;
                        Talk(EVENT_DEATH_YELL-1);
                    }
                }
            }

            uint32 timer;
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return GetInstanceAI<npc_omrogg_headsAI>(creature);
        }
};

void AddSC_boss_warbringer_omrogg()
{
    new boss_warbringer_omrogg();
    new npc_omrogg_heads();
}

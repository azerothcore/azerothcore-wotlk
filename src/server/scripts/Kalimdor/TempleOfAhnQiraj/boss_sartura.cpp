/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

/* ScriptData
SDName: Boss_Sartura
SD%Complete: 95
SDComment:
SDCategory: Temple of Ahn'Qiraj
EndScriptData */

#include "ScriptMgr.h"
#include "ScriptedCreature.h"

enum Says
{
    // Sartura
    SAY_AGGRO                     = 0,
    SAY_SLAY                      = 1,
    SAY_DEATH                     = 2,
};

enum Spells
{
    // Sartura
    SPELL_SARTURA_WHIRLWIND       = 26083,
    SPELL_SARTURA_ENRAGE          = 28747, //TODO: Check to make sure that this is the correct ID.
    SPELL_SARTURA_ENRAGEHARD      = 28798,

    // Guard
    SPELL_GUARD_WHIRLWIND         = 26038,
    SPELL_GUARD_KNOCKBACK         = 26027
};

enum Events
{
    // Sartura
    EVENT_SARTURA_WHIRLWIND        = 1,
    EVENT_SARTURA_WHIRLWIND_RANDOM = 2,
    EVENT_SARTURA_WHIRLWIND_END    = 3,
    EVENT_SARTURA_CHECK            = 4,
    EVENT_SARTURA_ENRAGEHARD       = 5,
    EVENT_SARTURA_AGGRO_RESET      = 6,
    EVENT_SARTURA_AGGRO_RESET_END  = 7,

    // Guard
    EVENT_GUARD_WHIRLWIND          = 1,
    EVENT_GUARD_WHIRLWIND_RANDOM   = 2,
    EVENT_GUARD_WHIRLWIND_END      = 3,
    EVENT_GUARD_KNOCKBACk          = 4,
    EVENT_GUARD_AGGRO_RESET        = 5,
    EVENT_GUARD_AGGRO_RESET_END    = 6
};

class boss_sartura : public CreatureScript
{
public:
    boss_sartura() : CreatureScript("boss_sartura") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new boss_sarturaAI(creature);
    }

    struct boss_sarturaAI : public ScriptedAI
    {
        boss_sarturaAI(Creature* creature) : ScriptedAI(creature)
        {
            Whirlwind = false;
            Enraged = false;
            AggroReset = false;
        }

        void Reset()
        {
            events.Reset();

            Whirlwind = false;
            Enraged = false;
            AggroReset = false;
        }

        void EnterCombat(Unit* /*who*/)
        {
            Talk(SAY_AGGRO);

            events.ScheduleEvent(EVENT_SARTURA_WHIRLWIND, 30000);
            events.ScheduleEvent(EVENT_SARTURA_WHIRLWIND_RANDOM, urand(3000, 7000));
            events.ScheduleEvent(EVENT_SARTURA_AGGRO_RESET, urand(45000, 55000));
            events.ScheduleEvent(EVENT_SARTURA_ENRAGEHARD, 10 * 60000);
            events.ScheduleEvent(EVENT_SARTURA_CHECK, 2000);
        }

         void JustDied(Unit* /*killer*/)
         {
             events.Reset();

             Talk(SAY_DEATH);
         }

         void KilledUnit(Unit* /*victim*/)
         {
             Talk(SAY_SLAY);
         }

        void UpdateAI(uint32 diff)
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);

            while (uint32 eventid = events.ExecuteEvent())
            {
                switch (eventid)
                {
                case EVENT_SARTURA_WHIRLWIND:
                    DoCast(me, SPELL_SARTURA_WHIRLWIND);
                    Whirlwind = true;
                    events.ScheduleEvent(EVENT_SARTURA_WHIRLWIND_RANDOM, urand(3000, 7000));
                    events.ScheduleEvent(EVENT_SARTURA_WHIRLWIND_END, 15000);
                    break;
                case EVENT_SARTURA_WHIRLWIND_RANDOM:
                    if (Whirlwind == true)
                    {
                        if (Unit* pUnit = SelectTarget(SELECT_TARGET_RANDOM, 1, 100.0f, true))
                        {
                            me->AddThreat(pUnit, 1.0f);
                            me->TauntApply(pUnit);
                            AttackStart(pUnit);
                        }
                        events.RepeatEvent(urand(3000, 7000));
                    }
                    break;
                case EVENT_SARTURA_WHIRLWIND_END:
                    events.CancelEvent(EVENT_SARTURA_WHIRLWIND_RANDOM);
                    Whirlwind = false;
                    events.ScheduleEvent(EVENT_SARTURA_WHIRLWIND, urand(25000, 40000));
                    break;
                case EVENT_SARTURA_AGGRO_RESET:
                    if (AggroReset != true)
                    {
                        AggroReset = true;
                        events.ScheduleEvent(EVENT_SARTURA_AGGRO_RESET_END, 15000);
                    }

                    if (Unit* pUnit = SelectTarget(SELECT_TARGET_RANDOM, 1, 100.0f, true))
                    {
                        me->AddThreat(pUnit, 1.0f);
                        me->TauntApply(pUnit);
                        AttackStart(pUnit);
                    }
                    events.RepeatEvent(urand(2000, 5000));
                    break;
                case EVENT_SARTURA_AGGRO_RESET_END:
                    AggroReset = false;
                    events.RescheduleEvent(EVENT_SARTURA_AGGRO_RESET, urand(30000, 40000));
                    break;
                case EVENT_SARTURA_CHECK:
                    if (Enraged == false)
                        if (HealthAbovePct(20) == false && me->IsNonMeleeSpellCast(false) == false)
                        {
                            DoCast(me, SPELL_SARTURA_ENRAGE);
                            Enraged = true;
                        }
                    events.RepeatEvent(2000);
                    break;
                case EVENT_SARTURA_ENRAGEHARD:
                    DoCast(me, SPELL_SARTURA_ENRAGEHARD);
                    break;
                }

            }

            DoMeleeAttackIfReady();
        }
        private:
            EventMap events;
            bool Enraged;
            bool AggroReset;
            bool Whirlwind;
    };

};

class npc_sartura_royal_guard : public CreatureScript
{
public:
    npc_sartura_royal_guard() : CreatureScript("npc_sartura_royal_guard") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_sartura_royal_guardAI(creature);
    }

    struct npc_sartura_royal_guardAI : public ScriptedAI
    {
        npc_sartura_royal_guardAI(Creature* creature) : ScriptedAI(creature)
        {
            Whirlwind = false;
            AggroReset = false;
        }

        void Reset()
        {
            events.Reset();

            Whirlwind = false;
            AggroReset = false;
        }

        void EnterCombat(Unit* /*who*/)
        {
            events.ScheduleEvent(EVENT_GUARD_WHIRLWIND, 30000);
            events.ScheduleEvent(EVENT_GUARD_AGGRO_RESET, urand(45000, 55000));
            events.ScheduleEvent(EVENT_GUARD_KNOCKBACk, 10000);
        }

        void UpdateAI(uint32 diff)
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);

            while (uint32 eventid = events.ExecuteEvent())
            {
                switch (eventid)
                {
                case EVENT_GUARD_WHIRLWIND:
                    DoCast(me, SPELL_GUARD_WHIRLWIND);
                    Whirlwind = true;
                    events.ScheduleEvent(EVENT_GUARD_WHIRLWIND_RANDOM, urand(3000, 7000));
                    events.ScheduleEvent(EVENT_GUARD_WHIRLWIND_END, 15000);
                    break;
                case EVENT_GUARD_WHIRLWIND_RANDOM:
                    if (Whirlwind == true)
                    {
                        if (Unit* pUnit = SelectTarget(SELECT_TARGET_RANDOM, 1, 100.0f, true))
                        {
                            me->AddThreat(pUnit, 1.0f);
                            me->TauntApply(pUnit);
                            AttackStart(pUnit);
                        }
                        events.RepeatEvent(urand(3000, 7000));
                    }
                    break;
                case EVENT_GUARD_WHIRLWIND_END:
                    events.CancelEvent(EVENT_SARTURA_WHIRLWIND_RANDOM);
                    Whirlwind = false;
                    events.ScheduleEvent(EVENT_SARTURA_WHIRLWIND, urand(25000, 40000));
                    break;
                case EVENT_GUARD_AGGRO_RESET:
                    if (AggroReset != true)
                    {
                        AggroReset = true;
                        events.ScheduleEvent(EVENT_GUARD_AGGRO_RESET_END, 15000);
                    }

                    if (Unit* pUnit = SelectTarget(SELECT_TARGET_RANDOM, 1, 100.0f, true))
                    {
                        me->AddThreat(pUnit, 1.0f);
                        me->TauntApply(pUnit);
                        AttackStart(pUnit);
                    }
                    events.RepeatEvent(urand(2000, 5000));
                    break;
                case EVENT_GUARD_AGGRO_RESET_END:
                    AggroReset = false;
                    events.RescheduleEvent(EVENT_SARTURA_AGGRO_RESET, urand(30000, 40000));
                    break;
                case EVENT_GUARD_KNOCKBACk:
                    DoCast(me, SPELL_GUARD_WHIRLWIND);
                    events.RepeatEvent(urand(10000, 20000));
                }

                DoMeleeAttackIfReady();
            }
        }
    private:
        EventMap events;
        bool Whirlwind;
        bool AggroReset;
    };

};

void AddSC_boss_sartura()
{
    new boss_sartura();
    new npc_sartura_royal_guard();
}

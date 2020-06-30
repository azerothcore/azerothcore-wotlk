/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "Player.h"

enum Texts
{
    SAY_AGGRO           = 0,
    SAY_KILL            = 1,
    SAY_DEATH           = 2,
    EMOTE_DARK_SHELL    = 3
};

enum Spells
{
    SPELL_VOID_BLAST = 32325,
    SPELL_DARK_SHELL = 32358
};

enum Events
{
    EVENT_VOID_BLAST = 1,
    EVENT_DARK_SHELL
};


class boss_pandemonius : public CreatureScript
{
public:
    boss_pandemonius() : CreatureScript("boss_pandemonius") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new boss_pandemoniusAI(creature);
    }

    struct boss_pandemoniusAI : public ScriptedAI
    {
        boss_pandemoniusAI(Creature* creature) : ScriptedAI(creature) { }
        
        EventMap events;

        void Reset()
        {
            events.Reset();
            VoidBlastCounter = 0;
        }

        void EnterCombat(Unit*)
        {
            me->SetInCombatWithZone();

            Talk(SAY_AGGRO);

            events.ScheduleEvent(EVENT_DARK_SHELL, 20000);
            events.ScheduleEvent(EVENT_VOID_BLAST, urand(8000, 23000));
        }

        void KilledUnit(Unit* victim)
        {
            if (victim->GetTypeId() == TYPEID_PLAYER)
                Talk(SAY_KILL);
        }

        void JustDied(Unit* /*killer*/)
        {
            Talk(SAY_DEATH);
        }

        void UpdateAI(uint32 diff)
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);
            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (events.GetEvent())
            {
            case EVENT_VOID_BLAST:
                if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 100.0f, true))
                {
                    DoCast(target, SPELL_VOID_BLAST);
                    ++VoidBlastCounter;
                }

                if (VoidBlastCounter == 5)
                {
                    VoidBlastCounter = 0;
                    events.RescheduleEvent(EVENT_VOID_BLAST, urand(15000, 25000));
                }
                else
                {
                    events.RescheduleEvent(EVENT_VOID_BLAST, 500);
                    events.DelayEvents(EVENT_DARK_SHELL, 500);
                }
                break;
            case EVENT_DARK_SHELL:
                if (me->IsNonMeleeSpellCast(false))
                {
                    me->InterruptNonMeleeSpells(true);
                }

                Talk(EMOTE_DARK_SHELL);
                DoCast(me, SPELL_DARK_SHELL);
                events.RescheduleEvent(EVENT_DARK_SHELL, 20000);
                break;
            default:
                break;
            }

            DoMeleeAttackIfReady();
        }

        private:
            uint32 VoidBlastCounter;
    };
};

void AddSC_boss_pandemonius()
{
    new boss_pandemonius();
}

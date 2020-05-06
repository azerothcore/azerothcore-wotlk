/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "blackrock_spire.h"

enum Spells
{
    SPELL_FIRENOVA                  = 23462,
    SPELL_CLEAVE                    = 20691,
    SPELL_CONFLIGURATION            = 16805,
    SPELL_THUNDERCLAP               = 15548, //Not sure if right ID. 23931 would be a harder possibility.
};

enum Events
{
    EVENT_FIRE_NOVA                = 1,
    EVENT_CLEAVE                   = 2,
    EVENT_CONFLIGURATION           = 3,
    EVENT_THUNDERCLAP              = 4,
};

enum ChromaticEliteGuardEvents
{
    EVENT_MORTAL_STRIKE = 1,
    EVENT_KNOCKDOWN     = 2,
    EVENT_STRIKE        = 3
};

enum ChromaticEliteGuardSpells
{
    SPELL_MORTAL_STRIKE = 15708,
    SPELL_KNOCKDOWN     = 16790,
    SPELL_STRIKE        = 15580
};

int const ChromaticEliteGuardEntry  = 10814;
int const GeneralDrakkisathEntry    = 10814;

class boss_drakkisath : public CreatureScript
{
public:
    boss_drakkisath() : CreatureScript("boss_drakkisath") { }

    struct boss_drakkisathAI : public BossAI
    {
        boss_drakkisathAI(Creature* creature) : BossAI(creature, DATA_GENERAL_DRAKKISATH) { }

        void Reset()
        {
            _Reset();
        }

        void EnterCombat(Unit* /*who*/)
        {
            _EnterCombat();
            CallForHelp();
            events.ScheduleEvent(EVENT_FIRE_NOVA, 6000);
            events.ScheduleEvent(EVENT_CLEAVE,    8000);
            events.ScheduleEvent(EVENT_CONFLIGURATION, 15000);
            events.ScheduleEvent(EVENT_THUNDERCLAP,    17000);
        }

        // Will make his two adds engage combat
        void CallForHelp()
        {
            std::list<Creature*> ChromaticEliteGuards;
            me->GetCreaturesWithEntryInRange(ChromaticEliteGuards, 15.0f, ChromaticEliteGuardEntry);
            for (std::list<Creature*>::const_iterator itr = ChromaticEliteGuards.begin(); itr != ChromaticEliteGuards.end(); ++itr)
            {
                if ((*itr)->GetGUID())
                    (*itr)->ToCreature()->AI()->AttackStart(me->GetVictim());
            }
        }

        void JustDied(Unit* /*killer*/)
        {
            _JustDied();
        }

        void UpdateAI(uint32 diff)
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            while (uint32 eventId = events.ExecuteEvent())
            {
                switch (eventId)
                {
                    case EVENT_FIRE_NOVA:
                        DoCastVictim(SPELL_FIRENOVA);
                        events.ScheduleEvent(EVENT_FIRE_NOVA, 10000);
                        break;
                    case EVENT_CLEAVE:
                        DoCastVictim(SPELL_CLEAVE);
                        events.ScheduleEvent(EVENT_CLEAVE, 8000);
                        break;
                    case EVENT_CONFLIGURATION:
                        DoCastVictim(SPELL_CONFLIGURATION);
                        events.ScheduleEvent(EVENT_CONFLIGURATION, 18000);
                        break;
                    case EVENT_THUNDERCLAP:
                        DoCastVictim(SPELL_THUNDERCLAP);
                        events.ScheduleEvent(EVENT_THUNDERCLAP, 20000);
                        break;
                }
            }
            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return new boss_drakkisathAI(creature);
    }
};

class chromatic_elite_guard : public CreatureScript
{
public:
    chromatic_elite_guard() : CreatureScript("chromatic_elite_guard") { }

    struct chromatic_elite_guardAI : public ScriptedAI
    {
        chromatic_elite_guardAI(Creature* creature) : ScriptedAI(creature) { }

        EventMap _events;

        void EnterCombat(Unit* who)
        {
            _events.ScheduleEvent(EVENT_MORTAL_STRIKE, urand(5000, 12800));
            _events.ScheduleEvent(EVENT_KNOCKDOWN, urand(5600, 15400));
            _events.ScheduleEvent(EVENT_STRIKE, urand(12000, 20800));

            std::list<Creature*> GeneralDrakkisath;
            me->GetCreaturesWithEntryInRange(GeneralDrakkisath, 15.0f, GeneralDrakkisathEntry);
            for (std::list<Creature*>::const_iterator itr = GeneralDrakkisath.begin(); itr != GeneralDrakkisath.end(); ++itr)
            {
                if ((*itr)->GetGUID())
                    (*itr)->ToCreature()->AI()->AttackStart(who);
            }

            std::list<Creature*> ChromaticEliteGuards;
            me->GetCreaturesWithEntryInRange(ChromaticEliteGuards, 15.0f, ChromaticEliteGuardEntry);
            for (std::list<Creature*>::const_iterator itr = ChromaticEliteGuards.begin(); itr != ChromaticEliteGuards.end(); ++itr)
            {
                if ((*itr)->GetGUID())
                    (*itr)->ToCreature()->AI()->AttackStart(who);
            }
        }

        void UpdateAI(uint32 diff)
        {
            if (!UpdateVictim())
                return;

            _events.Update(diff);

            switch (_events.ExecuteEvent())
            {
                case EVENT_MORTAL_STRIKE:
                    DoCastVictim(SPELL_MORTAL_STRIKE);
                    _events.ScheduleEvent(EVENT_MORTAL_STRIKE, 13000);
                    break;
                case EVENT_KNOCKDOWN:
                    DoCastVictim(SPELL_KNOCKDOWN);
                    _events.ScheduleEvent(EVENT_MORTAL_STRIKE, urand(11200, 25700));
                    break;
                case EVENT_STRIKE:
                    DoCastVictim(SPELL_STRIKE);
                    _events.ScheduleEvent(EVENT_MORTAL_STRIKE, 9000);
                    break;
            }

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return new chromatic_elite_guardAI(creature);
    }
};

void AddSC_boss_drakkisath()
{
    new boss_drakkisath();
    new chromatic_elite_guard();
}

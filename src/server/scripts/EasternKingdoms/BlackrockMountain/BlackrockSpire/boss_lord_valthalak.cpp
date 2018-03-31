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
    SPELL_FRENZY                    = 8269,
    SPELL_SUMMON_SPECTRAL_ASSASSIN  = 27249,
    SPELL_SHADOW_BOLT_VOLLEY        = 27382,
    SPELL_SHADOW_WRATH              = 27286
};

enum Says
{
    EMOTE_FRENZY                    = 0
};

enum Events
{
    EVENT_SUMMON_SPECTRAL_ASSASSIN  = 1,
    EVENT_SHADOW_BOLT_VOLLEY        = 2,
    EVENT_SHADOW_WRATH              = 3
};

class boss_lord_valthalak : public CreatureScript
{
public:
    boss_lord_valthalak() : CreatureScript("boss_lord_valthalak") { }

    struct boss_lord_valthalakAI : public BossAI
    {
        boss_lord_valthalakAI(Creature* creature) : BossAI(creature, DATA_LORD_VALTHALAK) { }

        void Reset()
        {
            _Reset();
            frenzy40 = false;
            frenzy15 = false;
        }

        void EnterCombat(Unit* /*who*/)
        {
            _EnterCombat();
            events.ScheduleEvent(EVENT_SUMMON_SPECTRAL_ASSASSIN, urand(6000,8000));
            events.ScheduleEvent(EVENT_SHADOW_WRATH, urand(9000,18000));
        }

        void JustDied(Unit* /*killer*/)
        {
            instance->SetData(DATA_LORD_VALTHALAK, DONE);
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
                    case EVENT_SUMMON_SPECTRAL_ASSASSIN:
                        DoCast(me, SPELL_SUMMON_SPECTRAL_ASSASSIN);
                        events.ScheduleEvent(EVENT_SUMMON_SPECTRAL_ASSASSIN, urand(30000,35000));
                        break;
                    case EVENT_SHADOW_BOLT_VOLLEY:
                        DoCastVictim(SPELL_SHADOW_BOLT_VOLLEY);
                        events.ScheduleEvent(EVENT_SHADOW_BOLT_VOLLEY, urand(4000,6000));
                        break;
                    case EVENT_SHADOW_WRATH:
                        DoCastVictim(SPELL_SHADOW_WRATH);
                        events.ScheduleEvent(EVENT_SHADOW_WRATH, urand(19000,24000));
                        break;
                    default:
                        break;
                }
            }

            if (!frenzy40)
            {
                if (HealthBelowPct(40))
                {
                    DoCast(me, SPELL_FRENZY);
                    events.CancelEvent(EVENT_SUMMON_SPECTRAL_ASSASSIN);
                    frenzy40 = true;
                }
            }

            if (!frenzy15)
            {
                if (HealthBelowPct(15))
                {
                    DoCast(me, SPELL_FRENZY);
                    events.ScheduleEvent(EVENT_SHADOW_BOLT_VOLLEY, urand(7000,14000));
                    frenzy15 = true;
                }
            }

            DoMeleeAttackIfReady();
        }
        private:
            bool frenzy40;
            bool frenzy15;
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return GetInstanceAI<boss_lord_valthalakAI>(creature);
    }
};

void AddSC_boss_lord_valthalak()
{
    new boss_lord_valthalak();
}

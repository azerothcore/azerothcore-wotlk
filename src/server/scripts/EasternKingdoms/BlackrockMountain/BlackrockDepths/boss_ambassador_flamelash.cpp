/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include "ScriptMgr.h"
#include "ScriptedCreature.h"

enum Spells
{
    SPELL_FIREBLAST                                        = 15573
};

enum AmbassadorEvents
{
    EVENT_SPELL_FIREBLAST   = 0,
    EVENT_SUMMON_SPIRITS    = 1,
};

const Position SummonPositions[7] =
{
    // TODO: Must look for the runes position
};

class boss_ambassador_flamelash : public CreatureScript
{
public:
    boss_ambassador_flamelash() : CreatureScript("boss_ambassador_flamelash") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new boss_ambassador_flamelashAI(creature);
    }

    struct boss_ambassador_flamelashAI : public ScriptedAI
    {
        boss_ambassador_flamelashAI(Creature* creature) : ScriptedAI(creature), summons(nullptr) { }

        EventMap _events;
        SummonList summons;
        
        void JustSummoned(Creature* cr) override { summons.Summon(cr); }

        void Reset() override
        {
            events.Reset();
            summons.DespawnAll();
        }

        void EnterCombat(Unit* /*who*/) override
        { 
            _events.ScheduleEvent(EVENT_SPELL_FIREBLAST, 2000);
            
            // Spawn 7 Embers initially, then 12s after they die
            for (int i = 0; i < 7; ++i)
                _events.ScheduleEvent(EVENT_SUMMON_SPIRITS, 4000);
        }

        void SummonSpirits(Unit* victim)
        {
            if (Creature* Spirit = DoSpawnCreature(9178, float(irand(-9, 9)), float(irand(-9, 9)), 0, 0, TEMPSUMMON_TIMED_OR_CORPSE_DESPAWN, 60000))
                Spirit->AI()->AttackStart(victim);
                // TODO: Remove attack victim and make it path to Ambassador
                // suiciding and giving him a buff that increase size and damage
        }

        void UpdateAI(uint32 diff) override
        {
            //Return since we have no target
            if (!UpdateVictim())
                return;
                
            _events.Update(diff);

            switch(_events.ExecuteEvent())
            {
                case EVENT_SPELL_FIREBLAST:
                    DoCastVictim(SPELL_FIREBLAST);
                    _events.ScheduleEvent(EVENT_SPELL_FIREBLAST, 7000);
                    break;
                case EVENT_SUMMON_SPIRITS:
                    SummonSpirits(me->GetVictim());
                    _events.ScheduleEvent(EVENT_SUMMON_SPIRITS, 12000);
                    break;
            }

            DoMeleeAttackIfReady();
        }
    };
};

void AddSC_boss_ambassador_flamelash()
{
    new boss_ambassador_flamelash();
}

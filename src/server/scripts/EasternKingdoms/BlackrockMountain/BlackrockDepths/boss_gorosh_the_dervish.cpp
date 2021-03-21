/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include "ScriptedCreature.h"
#include "ScriptMgr.h"

enum Spells
{
    SPELL_WHIRLWIND                                        = 15589,
    SPELL_MORTALSTRIKE                                     = 24573
};

class boss_gorosh_the_dervish : public CreatureScript
{
public:
    boss_gorosh_the_dervish() : CreatureScript("boss_gorosh_the_dervish") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new boss_gorosh_the_dervishAI(creature);
    }

    struct boss_gorosh_the_dervishAI : public ScriptedAI
    {
        boss_gorosh_the_dervishAI(Creature* creature) : ScriptedAI(creature) { }

        uint32 WhirlWind_Timer;
        uint32 MortalStrike_Timer;

        void Reset() override
        {
            WhirlWind_Timer = 12000;
            MortalStrike_Timer = 22000;
        }

        void EnterCombat(Unit* /*who*/) override
        {
        }

        void UpdateAI(uint32 diff) override
        {
            //Return since we have no target
            if (!UpdateVictim())
                return;

            //WhirlWind_Timer
            if (WhirlWind_Timer <= diff)
            {
                DoCast(me, SPELL_WHIRLWIND);
                WhirlWind_Timer = 15000;
            }
            else WhirlWind_Timer -= diff;

            //MortalStrike_Timer
            if (MortalStrike_Timer <= diff)
            {
                DoCastVictim(SPELL_MORTALSTRIKE);
                MortalStrike_Timer = 15000;
            }
            else MortalStrike_Timer -= diff;

            DoMeleeAttackIfReady();
        }
    };
};

void AddSC_boss_gorosh_the_dervish()
{
    new boss_gorosh_the_dervish();
}

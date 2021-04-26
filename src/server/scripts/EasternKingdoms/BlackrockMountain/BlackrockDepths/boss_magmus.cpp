/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include "blackrock_depths.h"
#include "ScriptedCreature.h"
#include "ScriptMgr.h"

enum Spells
{
    SPELL_FIERYBURST                                       = 13900,
    SPELL_WARSTOMP                                         = 24375
};

class boss_magmus : public CreatureScript
{
public:
    boss_magmus() : CreatureScript("boss_magmus") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetBlackrockDepthsAI<boss_magmusAI>(creature);
    }

    struct boss_magmusAI : public ScriptedAI
    {
        boss_magmusAI(Creature* creature) : ScriptedAI(creature) { }

        uint32 FieryBurst_Timer;
        uint32 WarStomp_Timer;

        void Reset() override
        {
            FieryBurst_Timer = 5000;
            WarStomp_Timer = 0;
        }

        void EnterCombat(Unit* /*who*/) override { }

        void UpdateAI(uint32 diff) override
        {
            //Return since we have no target
            if (!UpdateVictim())
                return;

            //FieryBurst_Timer
            if (FieryBurst_Timer <= diff)
            {
                DoCastVictim(SPELL_FIERYBURST);
                FieryBurst_Timer = 6000;
            }
            else FieryBurst_Timer -= diff;

            //WarStomp_Timer
            if (HealthBelowPct(51))
            {
                if (WarStomp_Timer <= diff)
                {
                    DoCastVictim(SPELL_WARSTOMP);
                    WarStomp_Timer = 8000;
                }
                else WarStomp_Timer -= diff;
            }

            DoMeleeAttackIfReady();
        }
        // When he die open door to last chamber
        void JustDied(Unit* killer) override
        {
            if (InstanceScript* instance = killer->GetInstanceScript())
                instance->HandleGameObject(instance->GetGuidData(DATA_THRONE_DOOR), true);
        }
    };
};

void AddSC_boss_magmus()
{
    new boss_magmus();
}

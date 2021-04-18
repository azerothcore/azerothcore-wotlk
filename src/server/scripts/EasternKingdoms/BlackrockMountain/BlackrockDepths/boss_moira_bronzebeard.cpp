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
    SPELL_HEAL                                             = 10917,
    SPELL_RENEW                                            = 10929,
    SPELL_SHIELD                                           = 10901,
    SPELL_MINDBLAST                                        = 10947,
    SPELL_SHADOWWORDPAIN                                   = 10894,
    SPELL_SMITE                                            = 10934
};

class boss_moira_bronzebeard : public CreatureScript
{
public:
    boss_moira_bronzebeard() : CreatureScript("boss_moira_bronzebeard") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetBlackrockDepthsAI<boss_moira_bronzebeardAI>(creature);
    }

    struct boss_moira_bronzebeardAI : public ScriptedAI
    {
        boss_moira_bronzebeardAI(Creature* creature) : ScriptedAI(creature) { }

        uint32 Heal_Timer;
        uint32 MindBlast_Timer;
        uint32 ShadowWordPain_Timer;
        uint32 Smite_Timer;

        void Reset() override
        {
            Heal_Timer = 12000;                                 //These times are probably wrong
            MindBlast_Timer = 16000;
            ShadowWordPain_Timer = 2000;
            Smite_Timer = 8000;
        }

        void EnterCombat(Unit* /*who*/) override { }

        void UpdateAI(uint32 diff) override
        {
            //Return since we have no target
            if (!UpdateVictim())
                return;

            //MindBlast_Timer
            if (MindBlast_Timer <= diff)
            {
                DoCastVictim(SPELL_MINDBLAST);
                MindBlast_Timer = 14000;
            }
            else MindBlast_Timer -= diff;

            //ShadowWordPain_Timer
            if (ShadowWordPain_Timer <= diff)
            {
                DoCastVictim(SPELL_SHADOWWORDPAIN);
                ShadowWordPain_Timer = 18000;
            }
            else ShadowWordPain_Timer -= diff;

            //Smite_Timer
            if (Smite_Timer <= diff)
            {
                DoCastVictim(SPELL_SMITE);
                Smite_Timer = 10000;
            }
            else Smite_Timer -= diff;
        }
    };
};

void AddSC_boss_moira_bronzebeard()
{
    new boss_moira_bronzebeard();
}

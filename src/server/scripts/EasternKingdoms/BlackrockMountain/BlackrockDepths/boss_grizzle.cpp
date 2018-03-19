/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include "ScriptMgr.h"
#include "ScriptedCreature.h"

enum Grizzle
{
    SPELL_GROUNDTREMOR      = 6524,
    SPELL_FRENZY            = 28371,
    EMOTE_FRENZY_KILL       = 0
};

class boss_grizzle : public CreatureScript
{
public:
    boss_grizzle() : CreatureScript("boss_grizzle") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new boss_grizzleAI(creature);
    }

    struct boss_grizzleAI : public ScriptedAI
    {
        boss_grizzleAI(Creature* creature) : ScriptedAI(creature) { }

        uint32 GroundTremor_Timer;
        uint32 Frenzy_Timer;

        void Reset()
        {
            GroundTremor_Timer = 12000;
            Frenzy_Timer =0;
        }

        void EnterCombat(Unit* /*who*/) { }

        void UpdateAI(uint32 diff)
        {
            //Return since we have no target
            if (!UpdateVictim())
                return;

            //GroundTremor_Timer
            if (GroundTremor_Timer <= diff)
            {
                DoCastVictim(SPELL_GROUNDTREMOR);
                GroundTremor_Timer = 8000;
            } else GroundTremor_Timer -= diff;

            //Frenzy_Timer
            if (HealthBelowPct(51))
            {
                if (Frenzy_Timer <= diff)
                {
                    DoCast(me, SPELL_FRENZY);
                    Talk(EMOTE_FRENZY_KILL);

                    Frenzy_Timer = 15000;
                } else Frenzy_Timer -= diff;
            }

            DoMeleeAttackIfReady();
        }
    };
};

void AddSC_boss_grizzle()
{
    new boss_grizzle();
}

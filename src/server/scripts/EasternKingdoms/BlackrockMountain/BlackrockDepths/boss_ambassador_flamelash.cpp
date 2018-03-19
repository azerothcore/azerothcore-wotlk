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
        boss_ambassador_flamelashAI(Creature* creature) : ScriptedAI(creature) { }

        uint32 FireBlast_Timer;
        uint32 Spirit_Timer;

        void Reset()
        {
            FireBlast_Timer = 2000;
            Spirit_Timer = 24000;
        }

        void EnterCombat(Unit* /*who*/) { }

        void SummonSpirits(Unit* victim)
        {
            if (Creature* Spirit = DoSpawnCreature(9178, float(irand(-9, 9)), float(irand(-9, 9)), 0, 0, TEMPSUMMON_TIMED_OR_CORPSE_DESPAWN, 60000))
                Spirit->AI()->AttackStart(victim);
        }

        void UpdateAI(uint32 diff)
        {
            //Return since we have no target
            if (!UpdateVictim())
                return;

            //FireBlast_Timer
            if (FireBlast_Timer <= diff)
            {
                DoCastVictim(SPELL_FIREBLAST);
                FireBlast_Timer = 7000;
            } else FireBlast_Timer -= diff;

            //Spirit_Timer
            if (Spirit_Timer <= diff)
            {
                SummonSpirits(me->GetVictim());
                SummonSpirits(me->GetVictim());
                SummonSpirits(me->GetVictim());
                SummonSpirits(me->GetVictim());

                Spirit_Timer = 30000;
            } else Spirit_Timer -= diff;

            DoMeleeAttackIfReady();
        }
    };
};

void AddSC_boss_ambassador_flamelash()
{
    new boss_ambassador_flamelash();
}

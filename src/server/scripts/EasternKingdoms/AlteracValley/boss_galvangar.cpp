/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include "ScriptMgr.h"
#include "ScriptedCreature.h"

enum Spells
{
    SPELL_CLEAVE                                  = 15284,
    SPELL_FRIGHTENING_SHOUT                       = 19134,
    SPELL_WHIRLWIND1                              = 15589,
    SPELL_WHIRLWIND2                              = 13736,
    SPELL_MORTAL_STRIKE                           = 16856
};

enum Yells
{
    YELL_AGGRO                                    = 0,
    YELL_EVADE                                    = 1
};

class boss_galvangar : public CreatureScript
{
public:
    boss_galvangar() : CreatureScript("boss_galvangar") { }

    struct boss_galvangarAI : public ScriptedAI
    {
        boss_galvangarAI(Creature* creature) : ScriptedAI(creature) { }

        uint32 CleaveTimer;
        uint32 FrighteningShoutTimer;
        uint32 Whirlwind1Timer;
        uint32 Whirlwind2Timer;
        uint32 MortalStrikeTimer;
        uint32 ResetTimer;

        void Reset()
        {
            CleaveTimer                     = urand(1 * IN_MILLISECONDS, 9 * IN_MILLISECONDS);
            FrighteningShoutTimer           = urand(2 * IN_MILLISECONDS, 19 * IN_MILLISECONDS);
            Whirlwind1Timer                 = urand(1 * IN_MILLISECONDS, 13 * IN_MILLISECONDS);
            Whirlwind2Timer                 = urand(5 * IN_MILLISECONDS, 20 * IN_MILLISECONDS);
            MortalStrikeTimer               = urand(5 * IN_MILLISECONDS, 20 * IN_MILLISECONDS);
            ResetTimer                      = 5 * IN_MILLISECONDS;
        }

        void EnterCombat(Unit* /*who*/)
        {
            Talk(YELL_AGGRO);
        }

        void JustRespawned()
        {
            Reset();
        }

        void UpdateAI(uint32 diff)
        {
            if (!UpdateVictim())
                return;

            if (CleaveTimer <= diff)
            {
                DoCastVictim(SPELL_CLEAVE);
                CleaveTimer =  urand(10 * IN_MILLISECONDS, 16 * IN_MILLISECONDS);
            } else CleaveTimer -= diff;

            if (FrighteningShoutTimer <= diff)
            {
                DoCastVictim(SPELL_FRIGHTENING_SHOUT);
                FrighteningShoutTimer = urand(10 * IN_MILLISECONDS, 15 * IN_MILLISECONDS);
            } else FrighteningShoutTimer -= diff;

            if (Whirlwind1Timer <= diff)
            {
                DoCastVictim(SPELL_WHIRLWIND1);
                Whirlwind1Timer = urand(6 * IN_MILLISECONDS, 10 * IN_MILLISECONDS);
            } else Whirlwind1Timer -= diff;

            if (Whirlwind2Timer <= diff)
            {
                DoCastVictim(SPELL_WHIRLWIND2);
                Whirlwind2Timer = urand(10 * IN_MILLISECONDS, 25 * IN_MILLISECONDS);
            } else Whirlwind2Timer -= diff;

            if (MortalStrikeTimer <= diff)
            {
                DoCastVictim(SPELL_MORTAL_STRIKE);
                MortalStrikeTimer = urand(10 * IN_MILLISECONDS, 30 * IN_MILLISECONDS);
            } else MortalStrikeTimer -= diff;

            // check if creature is not outside of building
            if (ResetTimer <= diff)
            {
                if (me->GetDistance2d(me->GetHomePosition().GetPositionX(), me->GetHomePosition().GetPositionY()) > 50)
                {
                    EnterEvadeMode();
                    Talk(YELL_EVADE);
                }
                ResetTimer = 5 * IN_MILLISECONDS;
            } else ResetTimer -= diff;

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return new boss_galvangarAI(creature);
    }
};

void AddSC_boss_galvangar()
{
    new boss_galvangar;
}

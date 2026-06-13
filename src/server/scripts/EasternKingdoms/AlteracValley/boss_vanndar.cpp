/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "BattlegroundAV.h"
#include "CreatureScript.h"
#include "ScriptedCreature.h"

enum Yells
{
    YELL_AGGRO                                    = 0,
    YELL_EVADE                                    = 1,
    //YELL_RESPAWN1                                 = -1810010, // Missing in database
    //YELL_RESPAWN2                                 = -1810011, // Missing in database
    YELL_RANDOM                                   = 2,
    YELL_SPELL                                    = 3,
};

enum Spells
{
    SPELL_AVATAR                                  = 19135,
    SPELL_THUNDERCLAP                             = 15588,
    SPELL_STORMBOLT                               = 20685 // not sure
};

class boss_vanndar : public CreatureScript
{
public:
    boss_vanndar() : CreatureScript("boss_vanndar") { }

    struct boss_vanndarAI : public ScriptedAI
    {
        boss_vanndarAI(Creature* creature) : ScriptedAI(creature) { }

        uint32 AvatarTimer;
        uint32 ThunderclapTimer;
        uint32 StormboltTimer;
        uint32 ResetTimer;
        uint32 YellTimer;
        bool Attacked;

        void Reset() override
        {
            AvatarTimer  = 3 * IN_MILLISECONDS;
            ThunderclapTimer = 4 * IN_MILLISECONDS;
            StormboltTimer = 6 * IN_MILLISECONDS;
            ResetTimer = 5 * IN_MILLISECONDS;
            YellTimer = urand(20 * IN_MILLISECONDS, 30 * IN_MILLISECONDS);
            Attacked = false;
        }

        void JustEngagedWith(Unit* /*who*/) override
        {
            Talk(YELL_AGGRO);
        }

        void AttackStart(Unit* victim) override
        {
            ScriptedAI::AttackStart(victim);

            if (!Attacked)
            {
                Attacked = true;

                // Mini bosses should attack as well
                if (BattlegroundMap* bgMap = me->GetMap()->ToBattlegroundMap())
                {
                    if (Battleground* bg = bgMap->GetBG())
                    {
                        for (uint8 i = AV_CPLACE_A_MARSHAL_SOUTH; i <= AV_CPLACE_A_MARSHAL_STONE; ++i)
                        {
                            if (Creature* marshall = bg->GetBGCreature(i))
                            {
                                if (marshall->IsAIEnabled && !marshall->GetVictim())
                                {
                                    marshall->AI()->AttackStart(victim);
                                }
                            }
                        }
                    }
                }
            }
        }

        void EnterEvadeMode(EvadeReason why) override
        {
            ScriptedAI::EnterEvadeMode(why);

            if (Attacked)
            {
                Attacked = false;

                // Evade mini bosses
                if (BattlegroundMap* bgMap = me->GetMap()->ToBattlegroundMap())
                {
                    if (Battleground* bg = bgMap->GetBG())
                    {
                        for (uint8 i = AV_CPLACE_A_MARSHAL_SOUTH; i <= AV_CPLACE_A_MARSHAL_STONE; ++i)
                        {
                            if (Creature* marshall = bg->GetBGCreature(i))
                            {
                                if (marshall->IsAIEnabled && !marshall->IsInEvadeMode())
                                {
                                    marshall->AI()->EnterEvadeMode();
                                }
                            }
                        }
                    }
                }
            }
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
                return;

            if (AvatarTimer <= diff)
            {
                DoCastVictim(SPELL_AVATAR);
                AvatarTimer =  urand(15 * IN_MILLISECONDS, 20 * IN_MILLISECONDS);
            }
            else AvatarTimer -= diff;

            if (ThunderclapTimer <= diff)
            {
                DoCastVictim(SPELL_THUNDERCLAP);
                ThunderclapTimer = urand(5 * IN_MILLISECONDS, 15 * IN_MILLISECONDS);
            }
            else ThunderclapTimer -= diff;

            if (StormboltTimer <= diff)
            {
                DoCastVictim(SPELL_STORMBOLT);
                StormboltTimer = urand(10 * IN_MILLISECONDS, 25 * IN_MILLISECONDS);
            }
            else StormboltTimer -= diff;

            if (YellTimer <= diff)
            {
                Talk(YELL_RANDOM);
                YellTimer = urand(20 * IN_MILLISECONDS, 30 * IN_MILLISECONDS); //20 to 30 seconds
            }
            else YellTimer -= diff;

            // check if creature is not outside of building
            if (ResetTimer <= diff)
            {
                if (me->GetDistance2d(me->GetHomePosition().GetPositionX(), me->GetHomePosition().GetPositionY()) > 50)
                {
                    ScriptedAI::EnterEvadeMode();
                    Talk(YELL_EVADE);
                }
                ResetTimer = 5 * IN_MILLISECONDS;
            }
            else ResetTimer -= diff;

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new boss_vanndarAI(creature);
    }
};

void AddSC_boss_vanndar()
{
    new boss_vanndar;
}

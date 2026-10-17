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

#include "CreatureScript.h"
#include "Player.h"
#include "ScriptedCreature.h"

/*######
## npc_webbed_creature
######*/

enum WebbedCreature
{
    SPELL_FREE_WEBBED_CREATURE_HOSTILE_START = 30954,
    SPELL_FREE_WEBBED_CREATURE_HOSTILE_END   = 30963,
    SPELL_FREE_WEBBED_CREATURE_RESEARCHER    = 31010,

    NPC_EXPEDITION_RESEARCHER                = 17681
};

class npc_webbed_creature : public CreatureScript
{
public:
    npc_webbed_creature() : CreatureScript("npc_webbed_creature") { }

    struct npc_webbed_creatureAI : public ScriptedAI
    {
        npc_webbed_creatureAI(Creature* creature) : ScriptedAI(creature) { }

        void Reset() override { }

        void JustEngagedWith(Unit* /*who*/) override { }

        void JustDied(Unit* /*killer*/) override
        {
            switch (urand(0, 2))
            {
                case 0:
                    me->CastSpell(me, SPELL_FREE_WEBBED_CREATURE_RESEARCHER, true);
                    if (Player* player = me->GetLootRecipient())
                        player->RewardPlayerAndGroupAtEvent(NPC_EXPEDITION_RESEARCHER, player);
                    break;
                case 1:
                case 2:
                    me->CastSpell(me, urand(SPELL_FREE_WEBBED_CREATURE_HOSTILE_START, SPELL_FREE_WEBBED_CREATURE_HOSTILE_END), true);
                    break;
            }
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_webbed_creatureAI(creature);
    }
};

void AddSC_bloodmyst_isle()
{
    new npc_webbed_creature();
}

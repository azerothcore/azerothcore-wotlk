/*
    MIT License

    Copyright (c) 2018 José González

    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"), to deal
    in the Software without restriction, including without limitation the rights
    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
    copies of the Software, and to permit persons to whom the Software is
    furnished to do so, subject to the following conditions:

    The above copyright notice and this permission notice shall be included in all
    copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
    SOFTWARE.
 */

#include "ScriptMgr.h"
#include "ScriptPCH.h"   

class npc_example : public CreatureScript
{
public:
    npc_example() : CreatureScript("npc_example") { }

    // Called when the player opens the gossip menu assigned to this creature
    bool OnGossipHello(Player* player, Creature* creature) override
    {
        return true;
    }

    // Called when the player selects an option from the gossip menu
    bool OnGossipSelect(Player* player, Creature* creature, uint32 sender, uint32 action) override
    {
        return true;
    }

    // Same as before, but this time the option has a code assigned
    bool OnGossipSelectCode(Player* player, Creature* creature, uint32 sender, uint32 action, const char* code) override
    {
        return true;
    }

    // Called when a player accepts a quest from the creature
    bool OnQuestAccept(Player* player, Creature* creature, Quest const* quest) override
    {
        return true;
    }

    // Called when a player selects a quest in the creature's quest menu
    bool OnQuestSelect(Player* player, Creature* creature, Quest const* quest) override
    {
        return true;
    }

    // Called when a player completes a quest with the creature
    bool OnQuestComplete(Player* player, Creature* creature, Quest const* quest) override
    {
        return true;
    }

    // Called when the player is rewarded for completing a quest
    bool OnQuestReward(Player* player, Creature* creature, Quest const* quest, uint32 opt) override
    {
        return true;
    }

    // Called when the dialog status between a player and the creature is requested
    uint32 GetDialogStatus(Player* player, Creature* creature) override
    {
        return true;
    }

    // Creature update, without ScriptedAI
    void OnCreatureUpdate(Creature* creature, uint32 diff)
    {
        return;
    }

    // AI is used mainly for combat purposes. Passed to the script through GetAI()
    struct npc_exampleAI : public ScriptedAI
    {
        npc_exampleAI(Creature* creature) : ScriptedAI(creature)
        {
            // Constructor, define variables here
        }

        // Called when the creature is spawned or when comes out of combat
        void Reset()
        {
            timeToShoot = 300;
            me->MonsterYell("Reset!", LANG_UNIVERSAL, 0);
            return;
        }

        void UpdateAI(uint32 diff)
        {
            if (diff > timeToShoot)
            {
                me->MonsterYell("Pew", LANG_UNIVERSAL, 0);
                timeToShoot = 300;
            }
            else
                timeToShoot -= diff;
        }

        // For more ScriptedAI methods, check: 
        // https://github.com/azerothcore/azerothcore-wotlk/blob/master/src/server/game/AI/ScriptedAI/ScriptedCreature.h

    private:
        // Declare variables here
        uint32 timeToShoot;
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_exampleAI(creature);
    }
};

void AddSC_npc_example()
{
    new npc_example();
}

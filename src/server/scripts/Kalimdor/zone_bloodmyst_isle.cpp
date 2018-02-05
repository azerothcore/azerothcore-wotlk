/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

/* ScriptData
SDName: Bloodmyst_Isle
SD%Complete: 80
SDComment: Quest support: 9670
SDCategory: Bloodmyst Isle
EndScriptData */

/* ContentData
npc_webbed_creature
EndContentData */

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "Player.h"

/*######
## npc_webbed_creature
######*/

//possible creatures to be spawned
uint32 const possibleSpawns[32] = {17322, 17661, 17496, 17522, 17340, 17352, 17333, 17524, 17654, 17348, 17339, 17345, 17359, 17353, 17336, 17550, 17330, 17701, 17321, 17680, 17325, 17320, 17683, 17342, 17715, 17334, 17341, 17338, 17337, 17346, 17344, 17327};

enum WebbedCreature
{
    NPC_EXPEDITION_RESEARCHER                     = 17681
};

class npc_webbed_creature : public CreatureScript
{
public:
    npc_webbed_creature() : CreatureScript("npc_webbed_creature") { }

    struct npc_webbed_creatureAI : public ScriptedAI
    {
        npc_webbed_creatureAI(Creature* creature) : ScriptedAI(creature) { }

        void Reset() { }

        void EnterCombat(Unit* /*who*/) { }

        void JustDied(Unit* killer)
        {
            uint32 spawnCreatureID = 0;

            switch (urand(0, 2))
            {
                case 0:
                    if (Player* player = killer->ToPlayer())
                        player->KilledMonsterCredit(NPC_EXPEDITION_RESEARCHER, 0);
                    break;
                case 1:
                case 2:
                    spawnCreatureID = possibleSpawns[urand(0, 30)];
                    break;
            }

            if (spawnCreatureID)
                me->SummonCreature(spawnCreatureID, 0.0f, 0.0f, 0.0f, me->GetOrientation(), TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 60000);
        }
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_webbed_creatureAI(creature);
    }
};

void AddSC_bloodmyst_isle()
{
    new npc_webbed_creature();
}

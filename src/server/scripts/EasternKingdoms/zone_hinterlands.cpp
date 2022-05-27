/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the
 * Free Software Foundation; either version 2 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

/* ScriptData
SDName: Hinterlands
SD%Complete: 100
SDComment: Quest support: 2742
SDCategory: The Hinterlands
EndScriptData */

/* ContentData
npc_rinji
EndContentData */

#include "Player.h"
#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "ScriptedEscortAI.h"

/*######
## npc_rinji
######*/

enum Rinji
{
    SAY_RIN_BY_OUTRUNNER    = 0,
    SAY_RIN_FREE            = 0, // from here
    SAY_RIN_HELP            = 1,
    SAY_RIN_COMPLETE        = 2,
    SAY_RIN_PROGRESS_1      = 3,
    SAY_RIN_PROGRESS_2      = 4,
    QUEST_RINJI_TRAPPED     = 2742,
    NPC_RANGER              = 2694,
    NPC_OUTRUNNER           = 2691,
    GO_RINJI_CAGE           = 142036
};

struct Location
{
    float posX, posY, posZ;
};

Location AmbushSpawn[] =
{
    { 191.296204f, -2839.329346f, 107.388f },
    { 70.972466f,  -2848.674805f, 109.459f }
};

Location AmbushMoveTo[] =
{
    { 166.630386f, -2824.780273f, 108.153f },
    { 70.886589f,  -2874.335449f, 116.675f }
};

class npc_rinji : public CreatureScript
{
public:
    npc_rinji() : CreatureScript("npc_rinji") { }

    struct npc_rinjiAI : public npc_escortAI
    {
        npc_rinjiAI(Creature* creature) : npc_escortAI(creature)
        {
            _IsByOutrunner = false;
            spawnId = 0;
            me->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_DISABLE_MOVE);
        }

        void Reset() override
        {
            postEventCount = 0;
            postEventTimer = 3000;
        }

        void JustRespawned() override
        {
            _IsByOutrunner = false;
            spawnId = 0;

            npc_escortAI::JustRespawned();
        }

        void EnterCombat(Unit* who) override
        {
            if (HasEscortState(STATE_ESCORT_ESCORTING))
            {
                if (who->GetEntry() == NPC_OUTRUNNER && !_IsByOutrunner)
                {
                    if (Creature* talker = who->ToCreature())
                        talker->AI()->Talk(SAY_RIN_BY_OUTRUNNER);
                    _IsByOutrunner = true;
                }

                if (rand() % 4)
                    return;

                //only if attacked and escorter is not in combat?
                Talk(SAY_RIN_HELP);
            }
        }

        void DoSpawnAmbush(bool _first)
        {
            if (!_first)
                spawnId = 1;

            me->SummonCreature(NPC_RANGER, AmbushSpawn[spawnId].posX, AmbushSpawn[spawnId].posY, AmbushSpawn[spawnId].posZ, 0.0f,
                               TEMPSUMMON_TIMED_OR_CORPSE_DESPAWN, 60000);

            for (int i = 0; i < 2; ++i)
            {
                me->SummonCreature(NPC_OUTRUNNER, AmbushSpawn[spawnId].posX, AmbushSpawn[spawnId].posY, AmbushSpawn[spawnId].posZ, 0.0f,
                                   TEMPSUMMON_TIMED_OR_CORPSE_DESPAWN, 60000);
            }
        }

        void JustSummoned(Creature* summoned) override
        {
            summoned->SetWalk(false);
            summoned->GetMotionMaster()->MovePoint(0, AmbushMoveTo[spawnId].posX, AmbushMoveTo[spawnId].posY, AmbushMoveTo[spawnId].posZ);
        }

        void sQuestAccept(Player* player, Quest const* quest) override
        {
            me->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_DISABLE_MOVE);
            if (quest->GetQuestId() == QUEST_RINJI_TRAPPED)
            {
                if (GameObject* go = me->FindNearestGameObject(GO_RINJI_CAGE, INTERACTION_DISTANCE))
                    go->UseDoorOrButton();

                npc_escortAI::Start(false, false, player->GetGUID(), quest);
            }
        }

        void WaypointReached(uint32 waypointId) override
        {
            Player* player = GetPlayerForEscort();
            if (!player)
                return;

            switch (waypointId)
            {
                case 1:
                    Talk(SAY_RIN_FREE, player);
                    break;
                case 7:
                    DoSpawnAmbush(true);
                    break;
                case 13:
                    DoSpawnAmbush(false);
                    break;
                case 17:
                    Talk(SAY_RIN_COMPLETE, player);
                    player->GroupEventHappens(QUEST_RINJI_TRAPPED, me);
                    SetRun();
                    postEventCount = 1;
                    break;
            }
        }

        void UpdateEscortAI(uint32 diff) override
        {
            //Check if we have a current target
            if (!UpdateVictim())
            {
                if (HasEscortState(STATE_ESCORT_ESCORTING) && postEventCount)
                {
                    if (postEventTimer <= diff)
                    {
                        postEventTimer = 3000;

                        if (Player* player = GetPlayerForEscort())
                        {
                            switch (postEventCount)
                            {
                                case 1:
                                    Talk(SAY_RIN_PROGRESS_1, player);
                                    ++postEventCount;
                                    break;
                                case 2:
                                    Talk(SAY_RIN_PROGRESS_2, player);
                                    postEventCount = 0;
                                    break;
                            }
                        }
                        else
                        {
                            me->DespawnOrUnsummon();
                            return;
                        }
                    }
                    else
                        postEventTimer -= diff;
                }
                return;
            }
            DoMeleeAttackIfReady();
        }

    private:
        uint32 postEventCount;
        uint32 postEventTimer;
        int    spawnId;
        bool   _IsByOutrunner;
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_rinjiAI(creature);
    }
};

void AddSC_hinterlands()
{
    new npc_rinji();
}

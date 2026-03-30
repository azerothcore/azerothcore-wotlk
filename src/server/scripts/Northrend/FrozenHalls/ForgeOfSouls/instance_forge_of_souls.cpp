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

#include "InstanceMapScript.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "forge_of_souls.h"
#include "Group.h"

enum Misc
{
    NPC_CORRUPTED_SOUL_FRAGMENT         = 36535,

    ACHIEV_CRITERIA_SOUL_POWER          = 12752,
    ACHIEV_CRITERIA_THREE_FACED         = 12976,

    SOUL_POWER_FRAGMENT_COUNT           = 4,
};

BossBoundaryData const boundaries =
{
    { DATA_BRONJAHM,    new CircleBoundary(Position(5297.3f, 2506.45f), 100.96)                                                                                   },
    { DATA_DEVOURER,    new ParallelogramBoundary(Position(5663.56f, 2570.53f), Position(5724.39f, 2520.45f), Position(5570.36f, 2461.42f)) }
};

static ObjectData const creatureData[] =
{
    { NPC_BRONJAHM, DATA_BRONJAHM },
    { NPC_DEVOURER, DATA_DEVOURER },
    { 0,            0             }
};

class instance_forge_of_souls : public InstanceMapScript
{
public:
    instance_forge_of_souls() : InstanceMapScript("instance_forge_of_souls", MAP_THE_FORGE_OF_SOULS) { }

    InstanceScript* GetInstanceScript(InstanceMap* map) const override
    {
        return new instance_forge_of_souls_InstanceScript(map);
    }

    struct instance_forge_of_souls_InstanceScript : public InstanceScript
    {
        instance_forge_of_souls_InstanceScript(Map* map) : InstanceScript(map)
        {
            SetHeaders(DataHeader);
            SetBossNumber(MAX_ENCOUNTER);
            LoadObjectData(creatureData, nullptr);
            LoadBossBoundaries(boundaries);
        }

        ObjectGuid LeaderFirstGUID;
        ObjectGuid LeaderSecondGUID;
        ObjectGuid GuardFirstGUID;
        ObjectGuid GuardSecondGUID;

        void OnPlayerEnter(Player* player) override
        {
            InstanceScript::OnPlayerEnter(player);

            // this will happen only after crash and loading the instance from db
            if (AllBossesDone() && (!LeaderSecondGUID || !instance->GetCreature(LeaderSecondGUID)))
            {
                Position pos = {5658.15f, 2502.564f, 708.83f, 0.885207f};
                instance->SummonCreature(NPC_SYLVANAS_PART2, pos);
            }
        }

        void OnCreatureCreate(Creature* creature) override
        {
            InstanceScript::OnCreatureCreate(creature);

            switch (creature->GetEntry())
            {
                case NPC_SYLVANAS_PART1:
                    if (GetTeamIdInInstance() == TEAM_ALLIANCE)
                        creature->UpdateEntry(NPC_JAINA_PART1);
                    LeaderFirstGUID = creature->GetGUID();

                    if (AllBossesDone())
                        creature->SetVisible(false);
                    break;
                case NPC_SYLVANAS_PART2:
                    if (GetTeamIdInInstance() == TEAM_ALLIANCE)
                        creature->UpdateEntry(NPC_JAINA_PART2);
                    LeaderSecondGUID = creature->GetGUID();
                    break;
                case NPC_LORALEN:
                    if (GetTeamIdInInstance() == TEAM_ALLIANCE)
                        creature->UpdateEntry(NPC_ELANDRA);
                    if (!GuardFirstGUID)
                    {
                        GuardFirstGUID = creature->GetGUID();
                        if (AllBossesDone())
                            creature->SetVisible(false);
                    }
                    break;
                case NPC_KALIRA:
                    if (GetTeamIdInInstance() == TEAM_ALLIANCE)
                        creature->UpdateEntry(NPC_KORELN);
                    if (!GuardSecondGUID)
                    {
                        GuardSecondGUID = creature->GetGUID();
                        if (AllBossesDone())
                            creature->SetVisible(false);
                    }
                    break;
            }
        }

        void HandleOutro()
        {
            if (!LeaderSecondGUID || !instance->GetCreature(LeaderSecondGUID))
                if (Creature* leader = instance->SummonCreature(NPC_SYLVANAS_PART2, outroSpawnPoint))
                    if (Creature* boss = GetCreature(DATA_DEVOURER))
                    {
                        float angle = boss->GetAngle(leader);
                        leader->GetMotionMaster()->MovePoint(1, boss->GetPositionX() + 10.0f * cos(angle), boss->GetPositionY() + 10.0f * std::sin(angle), boss->GetPositionZ());
                    }

            if (GetTeamIdInInstance() < TEAM_NEUTRAL) // Shouldn't happen, but just in case.
            {
                for (int8 i = 0; outroPositions[i].entry[GetTeamIdInInstance()] != 0; ++i)
                    if (Creature* summon = instance->SummonCreature(outroPositions[i].entry[GetTeamIdInInstance()], outroPositions[i].startPosition))
                        summon->GetMotionMaster()->MoveWaypoint(outroPositions[i].pathId, false);
            }
        }

        bool SetBossState(uint32 type, EncounterState state) override
        {
            if (!InstanceScript::SetBossState(type, state))
                return false;

            if (state == DONE && AllBossesDone())
                HandleOutro();

            return true;
        }

        bool CheckAchievementCriteriaMeet(uint32 criteria_id, Player const*  /*source*/, Unit const*  /*target*/, uint32  /*miscvalue1*/) override
        {
            switch (criteria_id)
            {
                case ACHIEV_CRITERIA_SOUL_POWER:
                    if (Creature* bronjahm = GetCreature(DATA_BRONJAHM))
                    {
                        std::list<Creature*> fragments;
                        bronjahm->GetCreaturesWithEntryInRange(fragments, 200.0f, NPC_CORRUPTED_SOUL_FRAGMENT);
                        return std::count_if(fragments.begin(), fragments.end(),
                            [](Creature const* fragment) { return fragment->IsAlive(); }) >= SOUL_POWER_FRAGMENT_COUNT;
                    }
                    break;
                case ACHIEV_CRITERIA_THREE_FACED:
                    if (Creature* devourer = GetCreature(DATA_DEVOURER))
                        return devourer->AI()->GetData(1) != 0;
                    break;
            }
            return false;
        }
    };
};

void AddSC_instance_forge_of_souls()
{
    new instance_forge_of_souls();
}

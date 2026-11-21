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

#include "AreaBoundary.h"
#include "InstanceMapScript.h"
#include "InstanceScript.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "forge_of_souls.h"
#include <algorithm>
#include <cmath>
#include <list>

enum AchievementCriteria
{
    CRITERIA_SOUL_POWER                 = 12752,
    CRITERIA_THREE_FACED                = 12976,
};

enum Misc
{
    SOUL_POWER_FRAGMENT_COUNT           = 4,
};

Position const LeaderSecondRespawnPosition = { 5658.15f, 2502.564f, 708.83f, 0.885207f };

BossBoundaryData const Boundaries =
{
    { DATA_BRONJAHM,    new CircleBoundary(Position(5297.3f, 2506.45f), 100.96f)                                                            },
    { DATA_DEVOURER,    new ParallelogramBoundary(Position(5663.56f, 2570.53f), Position(5724.39f, 2520.45f), Position(5570.36f, 2461.42f)) }
};

ObjectData const CreatureObjectData[] =
{
    { NPC_BRONJAHM, DATA_BRONJAHM },
    { NPC_DEVOURER, DATA_DEVOURER },
    { 0,            0             }
};

class instance_forge_of_souls : public InstanceMapScript
{
public:
    instance_forge_of_souls() : InstanceMapScript(ForgeOfSoulsScriptName, MAP_THE_FORGE_OF_SOULS) { }

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
            LoadObjectData(CreatureObjectData, nullptr);
            LoadBossBoundaries(Boundaries);
        }

        void OnPlayerEnter(Player* player) override
        {
            InstanceScript::OnPlayerEnter(player);

            // Only reached when the instance is loaded from the DB with all bosses already done
            if (AllBossesDone() && !instance->GetCreature(_leaderSecondGUID))
                instance->SummonCreature(NPC_SYLVANAS_PART2, LeaderSecondRespawnPosition);
        }

        void OnCreatureCreate(Creature* creature) override
        {
            InstanceScript::OnCreatureCreate(creature);

            switch (creature->GetEntry())
            {
                case NPC_SYLVANAS_PART1:
                    if (GetTeamIdInInstance() == TEAM_ALLIANCE)
                        creature->UpdateEntry(NPC_JAINA_PART1);

                    if (AllBossesDone())
                        creature->SetVisible(false);
                    break;
                case NPC_SYLVANAS_PART2:
                    if (GetTeamIdInInstance() == TEAM_ALLIANCE)
                        creature->UpdateEntry(NPC_JAINA_PART2);

                    _leaderSecondGUID = creature->GetGUID();
                    break;
                case NPC_LORALEN:
                    if (GetTeamIdInInstance() == TEAM_ALLIANCE)
                        creature->UpdateEntry(NPC_ELANDRA);

                    if (!_guardFirstGUID)
                    {
                        _guardFirstGUID = creature->GetGUID();
                        if (AllBossesDone())
                            creature->SetVisible(false);
                    }
                    break;
                case NPC_KALIRA:
                    if (GetTeamIdInInstance() == TEAM_ALLIANCE)
                        creature->UpdateEntry(NPC_KORELN);

                    if (!_guardSecondGUID)
                    {
                        _guardSecondGUID = creature->GetGUID();
                        if (AllBossesDone())
                            creature->SetVisible(false);
                    }
                    break;
                default:
                    break;
            }
        }

        void HandleOutro()
        {
            if (!instance->GetCreature(_leaderSecondGUID))
            {
                if (Creature* leader = instance->SummonCreature(NPC_SYLVANAS_PART2, OutroSpawnPoint))
                {
                    if (Creature* boss = GetCreature(DATA_DEVOURER))
                    {
                        float angle = boss->GetAngle(leader);
                        leader->GetMotionMaster()->MovePoint(POINT_OUTRO, boss->GetPositionX() + 10.0f * std::cos(angle), boss->GetPositionY() + 10.0f * std::sin(angle), boss->GetPositionZ());
                    }
                }
            }

            TeamId teamId = GetTeamIdInInstance();
            if (teamId == TEAM_NEUTRAL)
                return;

            for (OutroPosition const& outro : OutroPositions)
                if (Creature* summon = instance->SummonCreature(outro.Entry[teamId], outro.StartPosition))
                    summon->GetMotionMaster()->MoveWaypoint(outro.PathId, false);
        }

        bool SetBossState(uint32 type, EncounterState state) override
        {
            if (!InstanceScript::SetBossState(type, state))
                return false;

            if (state == DONE && AllBossesDone())
                HandleOutro();

            return true;
        }

        bool CheckAchievementCriteriaMeet(uint32 criteriaId, Player const* /*source*/, Unit const* /*target*/, uint32 /*miscvalue1*/) override
        {
            switch (criteriaId)
            {
                case CRITERIA_SOUL_POWER:
                    if (Creature* bronjahm = GetCreature(DATA_BRONJAHM))
                    {
                        std::list<Creature*> fragments;
                        bronjahm->GetCreaturesWithEntryInRange(fragments, 200.0f, NPC_CORRUPTED_SOUL_FRAGMENT);
                        return std::count_if(fragments.begin(), fragments.end(),
                            [](Creature const* fragment) { return fragment->IsAlive(); }) >= SOUL_POWER_FRAGMENT_COUNT;
                    }
                    break;
                case CRITERIA_THREE_FACED:
                    if (Creature* devourer = GetCreature(DATA_DEVOURER))
                        return devourer->AI()->GetData(DATA_THREE_FACED) != 0;

                    break;
                default:
                    break;
            }

            return false;
        }

    private:
        ObjectGuid _leaderSecondGUID;
        ObjectGuid _guardFirstGUID;
        ObjectGuid _guardSecondGUID;
    };
};

void AddSC_instance_forge_of_souls()
{
    new instance_forge_of_souls();
}

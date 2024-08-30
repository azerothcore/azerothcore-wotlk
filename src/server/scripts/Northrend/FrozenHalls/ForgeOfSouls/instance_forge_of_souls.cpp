/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU Affero General Public License as published by the
 * Free Software Foundation; either version 3 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "CreatureScript.h"
#include "InstanceMapScript.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "forge_of_souls.h"

BossBoundaryData const boundaries =
{
    { DATA_BRONJAHM,    new CircleBoundary(Position(5297.3f, 2506.45f), 100.96)                                                                                   },
    { DATA_DEVOURER,    new ParallelogramBoundary(Position(5663.56f, 2570.53f), Position(5724.39f, 2520.45f), Position(5570.36f, 2461.42f)) }
};

class instance_forge_of_souls : public InstanceMapScript
{
public:
    instance_forge_of_souls() : InstanceMapScript("instance_forge_of_souls", 632) { }

    InstanceScript* GetInstanceScript(InstanceMap* map) const override
    {
        return new instance_forge_of_souls_InstanceScript(map);
    }

    struct instance_forge_of_souls_InstanceScript : public InstanceScript
    {
        instance_forge_of_souls_InstanceScript(Map* map) : InstanceScript(map)
        {
            SetHeaders(DataHeader);
            LoadBossBoundaries(boundaries);
        }

        uint32 m_auiEncounter[MAX_ENCOUNTER];
        TeamId teamIdInInstance;
        std::string str_data;
        ObjectGuid NPC_BronjahmGUID;
        ObjectGuid NPC_DevourerGUID;

        ObjectGuid NPC_LeaderFirstGUID;
        ObjectGuid NPC_LeaderSecondGUID;
        ObjectGuid NPC_GuardFirstGUID;
        ObjectGuid NPC_GuardSecondGUID;

        void Initialize() override
        {
            memset(&m_auiEncounter, 0, sizeof(m_auiEncounter));
            teamIdInInstance = TEAM_NEUTRAL;
        }

        bool IsEncounterInProgress() const override
        {
            for (uint8 i = 0; i < MAX_ENCOUNTER; ++i)
                if (m_auiEncounter[i] == IN_PROGRESS) return true;

            return false;
        }

        void OnPlayerEnter(Player* /*plr*/) override
        {
            // this will happen only after crash and loading the instance from db
            if (m_auiEncounter[0] == DONE && m_auiEncounter[1] == DONE && (!NPC_LeaderSecondGUID || !instance->GetCreature(NPC_LeaderSecondGUID)))
            {
                Position pos = {5658.15f, 2502.564f, 708.83f, 0.885207f};
                instance->SummonCreature(NPC_SYLVANAS_PART2, pos);
            }
        }

        void OnCreatureCreate(Creature* creature) override
        {
            if (teamIdInInstance == TEAM_NEUTRAL)
            {
                Map::PlayerList const& players = instance->GetPlayers();
                if (!players.IsEmpty())
                    if (Player* player = players.begin()->GetSource())
                        teamIdInInstance = player->GetTeamId();
            }

            switch (creature->GetEntry())
            {
                case NPC_BRONJAHM:
                    NPC_BronjahmGUID = creature->GetGUID();
                    break;
                case NPC_DEVOURER:
                    NPC_DevourerGUID = creature->GetGUID();
                    break;
                case NPC_SYLVANAS_PART1:
                    if (teamIdInInstance == TEAM_ALLIANCE)
                        creature->UpdateEntry(NPC_JAINA_PART1);
                    NPC_LeaderFirstGUID = creature->GetGUID();

                    if (m_auiEncounter[0] == DONE && m_auiEncounter[1] == DONE)
                        creature->SetVisible(false);
                    break;
                case NPC_SYLVANAS_PART2:
                    if (teamIdInInstance == TEAM_ALLIANCE)
                        creature->UpdateEntry(NPC_JAINA_PART2);
                    NPC_LeaderSecondGUID = creature->GetGUID();
                    break;
                case NPC_LORALEN:
                    if (teamIdInInstance == TEAM_ALLIANCE)
                        creature->UpdateEntry(NPC_ELANDRA);
                    if (!NPC_GuardFirstGUID)
                    {
                        NPC_GuardFirstGUID = creature->GetGUID();
                        if (m_auiEncounter[0] == DONE && m_auiEncounter[1] == DONE)
                            creature->SetVisible(false);
                    }
                    break;
                case NPC_KALIRA:
                    if (teamIdInInstance == TEAM_ALLIANCE)
                        creature->UpdateEntry(NPC_KORELN);
                    if (!NPC_GuardSecondGUID)
                    {
                        NPC_GuardSecondGUID = creature->GetGUID();
                        if (m_auiEncounter[0] == DONE && m_auiEncounter[1] == DONE)
                            creature->SetVisible(false);
                    }
                    break;
            }
        }

        void HandleOutro()
        {
            if (!NPC_LeaderSecondGUID || !instance->GetCreature(NPC_LeaderSecondGUID))
                if (Creature* leader = instance->SummonCreature(NPC_SYLVANAS_PART2, outroSpawnPoint))
                    if (Creature* boss = instance->GetCreature(NPC_DevourerGUID))
                    {
                        float angle = boss->GetAngle(leader);
                        leader->GetMotionMaster()->MovePoint(1, boss->GetPositionX() + 10.0f * cos(angle), boss->GetPositionY() + 10.0f * std::sin(angle), boss->GetPositionZ());
                    }

            for (int8 i = 0; outroPositions[i].entry[teamIdInInstance] != 0; ++i)
                if (Creature* summon = instance->SummonCreature(outroPositions[i].entry[teamIdInInstance], outroPositions[i].startPosition))
                    summon->GetMotionMaster()->MovePath(outroPositions[i].pathId, false);
        }

        void SetData(uint32 type, uint32 data) override
        {
            switch(type)
            {
                case DATA_BRONJAHM:
                    m_auiEncounter[type] = data;
                    break;
                case DATA_DEVOURER:
                    m_auiEncounter[type] = data;
                    if (m_auiEncounter[0] == DONE && m_auiEncounter[1] == DONE)
                        HandleOutro();
                    break;
            }

            if (data == DONE)
                SaveToDB();
        }

        ObjectGuid GetGuidData(uint32 type) const override
        {
            switch (type)
            {
                case DATA_BRONJAHM:
                    return NPC_BronjahmGUID;
            }

            return ObjectGuid::Empty;
        }

        bool CheckAchievementCriteriaMeet(uint32 criteria_id, Player const*  /*source*/, Unit const*  /*target*/, uint32  /*miscvalue1*/) override
        {
            switch(criteria_id)
            {
                case 12752: // Soul Power
                    if( Creature* c = instance->GetCreature(NPC_BronjahmGUID) )
                    {
                        std::list<Creature*> L;
                        uint8 count = 0;
                        c->GetCreaturesWithEntryInRange(L, 200.0f, 36535); // find all Corrupted Soul Fragment (36535)
                        for( std::list<Creature*>::const_iterator itr = L.begin(); itr != L.end(); ++itr )
                            if( (*itr)->IsAlive() )
                                ++count;
                        return (count >= 4);
                    }
                    break;
                case 12976:
                    if( Creature* c = instance->GetCreature(NPC_DevourerGUID) )
                        return (bool)c->AI()->GetData(1);
                    break;
            }
            return false;
        }

        void ReadSaveDataMore(std::istringstream& data) override
        {
            data >> m_auiEncounter[0];
            data >> m_auiEncounter[1];
        }

        void WriteSaveDataMore(std::ostringstream& data) override
        {
            data << m_auiEncounter[0] << ' ' << m_auiEncounter[1];
        }
    };
};

void AddSC_instance_forge_of_souls()
{
    new instance_forge_of_souls();
}

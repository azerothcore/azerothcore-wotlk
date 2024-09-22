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
#include "pit_of_saron.h"

class instance_pit_of_saron : public InstanceMapScript
{
public:
    instance_pit_of_saron() : InstanceMapScript("instance_pit_of_saron", 658) { }

    struct instance_pit_of_saron_InstanceScript : public InstanceScript
    {
        instance_pit_of_saron_InstanceScript(Map* map) : InstanceScript(map)
        {
            SetHeaders(DataHeader);
        }

        uint32 m_auiEncounter[MAX_ENCOUNTER];
        TeamId teamIdInInstance;
        uint32 InstanceProgress;
        std::string str_data;

        ObjectGuid NPC_LeaderFirstGUID;
        ObjectGuid NPC_LeaderSecondGUID;
        ObjectGuid NPC_TyrannusEventGUID;
        ObjectGuid NPC_Necrolyte1GUID;
        ObjectGuid NPC_Necrolyte2GUID;
        ObjectGuid NPC_GuardFirstGUID;
        ObjectGuid NPC_GuardSecondGUID;
        ObjectGuid NPC_SindragosaGUID;

        ObjectGuid NPC_GarfrostGUID;
        ObjectGuid NPC_MartinOrGorkunGUID;
        ObjectGuid NPC_RimefangGUID;
        ObjectGuid NPC_TyrannusGUID;

        ObjectGuid GO_IceWallGUID;

        bool bAchievEleven;
        bool bAchievDontLookUp;

        void Initialize() override
        {
            memset(&m_auiEncounter, 0, sizeof(m_auiEncounter));
            teamIdInInstance = TEAM_NEUTRAL;
            InstanceProgress = INSTANCE_PROGRESS_NONE;

            bAchievEleven = true;
            bAchievDontLookUp = true;
        }

        bool IsEncounterInProgress() const override
        {
            for (uint8 i = 0; i < MAX_ENCOUNTER; ++i)
                if (m_auiEncounter[i] == IN_PROGRESS) return true;

            return false;
        }

        void OnPlayerEnter(Player*  /*plr*/) override
        {
            instance->LoadGrid(LeaderIntroPos.GetPositionX(), LeaderIntroPos.GetPositionY());
            if (Creature* c = instance->GetCreature(GetGuidData(DATA_LEADER_FIRST_GUID)))
                c->AI()->SetData(DATA_START_INTRO, 0);
        }

        uint32 GetCreatureEntry(ObjectGuid::LowType /*guidLow*/, CreatureData const* data) override
        {
            if (teamIdInInstance == TEAM_NEUTRAL)
            {
                Map::PlayerList const& players = instance->GetPlayers();
                if (!players.IsEmpty())
                    if (Player* player = players.begin()->GetSource())
                        teamIdInInstance = player->GetTeamId();
            }

            uint32 entry = data->id1;
            switch (entry)
            {
                case NPC_RESCUED_ALLIANCE_SLAVE:
                    if (teamIdInInstance == TEAM_HORDE)
                        return 0;
                    break;
                case NPC_RESCUED_HORDE_SLAVE:
                    if (teamIdInInstance == TEAM_ALLIANCE)
                        return 0;
                    break;
            }

            return entry;
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
                case NPC_SYLVANAS_PART1:
                    if (teamIdInInstance == TEAM_ALLIANCE)
                        creature->UpdateEntry(NPC_JAINA_PART1);
                    NPC_LeaderFirstGUID = creature->GetGUID();

                    switch (InstanceProgress)
                    {
                        case INSTANCE_PROGRESS_FINISHED_INTRO:
                            creature->SetPosition(LeaderIntroPos);
                            break;
                        case INSTANCE_PROGRESS_FINISHED_KRICK_SCENE:
                        case INSTANCE_PROGRESS_AFTER_WARN_1:
                        case INSTANCE_PROGRESS_AFTER_WARN_2:
                        case INSTANCE_PROGRESS_AFTER_TUNNEL_WARN:
                        case INSTANCE_PROGRESS_TYRANNUS_INTRO:
                            creature->SetPosition(SBSLeaderEndPos);
                            break;
                    }
                    break;
                case NPC_SYLVANAS_PART2:
                    if (teamIdInInstance == TEAM_ALLIANCE)
                        creature->UpdateEntry(NPC_JAINA_PART2);
                    NPC_LeaderSecondGUID = creature->GetGUID();
                    break;
                case NPC_TYRANNUS_EVENT:
                    if (!NPC_TyrannusEventGUID)
                    {
                        switch (InstanceProgress)
                        {
                            case INSTANCE_PROGRESS_FINISHED_INTRO:
                                creature->SetPosition(SBSTyrannusStartPos);
                                break;
                            case INSTANCE_PROGRESS_FINISHED_KRICK_SCENE:
                                creature->SetPosition(PTSTyrannusWaitPos1);
                                break;
                            case INSTANCE_PROGRESS_AFTER_WARN_1:
                                creature->SetPosition(PTSTyrannusWaitPos2);
                                break;
                            case INSTANCE_PROGRESS_AFTER_WARN_2:
                                creature->SetPosition(PTSTyrannusWaitPos3);
                                break;
                            case INSTANCE_PROGRESS_AFTER_TUNNEL_WARN:
                            case INSTANCE_PROGRESS_TYRANNUS_INTRO:
                                creature->SetPosition(SBSTyrannusStartPos);
                                break;
                        }
                        NPC_TyrannusEventGUID = creature->GetGUID();
                    }
                    break;
                case NPC_LORALEN:
                    if (teamIdInInstance == TEAM_ALLIANCE)
                        creature->UpdateEntry(NPC_ELANDRA);
                    if (!NPC_GuardFirstGUID)
                        NPC_GuardFirstGUID = creature->GetGUID();
                    break;
                case NPC_KALIRA:
                    if (teamIdInInstance == TEAM_ALLIANCE)
                        creature->UpdateEntry(NPC_KORELN);
                    if (!NPC_GuardSecondGUID)
                        NPC_GuardSecondGUID = creature->GetGUID();
                    break;
                case NPC_HORDE_SLAVE_1:
                    if (teamIdInInstance == TEAM_ALLIANCE)
                        creature->UpdateEntry(NPC_ALLIANCE_SLAVE_1);
                    break;
                case NPC_HORDE_SLAVE_2:
                    if (teamIdInInstance == TEAM_ALLIANCE)
                        creature->UpdateEntry(NPC_ALLIANCE_SLAVE_2);
                    break;
                case NPC_HORDE_SLAVE_3:
                    if (teamIdInInstance == TEAM_ALLIANCE)
                        creature->UpdateEntry(NPC_ALLIANCE_SLAVE_3);
                    break;
                case NPC_HORDE_SLAVE_4:
                    if (teamIdInInstance == TEAM_ALLIANCE)
                        creature->UpdateEntry(NPC_ALLIANCE_SLAVE_4);
                    break;
                case NPC_GORKUN_IRONSKULL_1:
                    if (teamIdInInstance == TEAM_ALLIANCE)
                        creature->UpdateEntry(NPC_MARTIN_VICTUS_1);
                    break;
                case NPC_GARFROST:
                    NPC_GarfrostGUID = creature->GetGUID();
                    break;
                case NPC_FREED_SLAVE_1_HORDE:
                    if (teamIdInInstance == TEAM_ALLIANCE)
                        creature->UpdateEntry(NPC_FREED_SLAVE_1_ALLIANCE);
                    break;
                case NPC_FREED_SLAVE_2_HORDE:
                    if (teamIdInInstance == TEAM_ALLIANCE)
                        creature->UpdateEntry(NPC_FREED_SLAVE_2_ALLIANCE);
                    break;
                case NPC_FREED_SLAVE_3_HORDE:
                    if (teamIdInInstance == TEAM_ALLIANCE)
                        creature->UpdateEntry(NPC_FREED_SLAVE_3_ALLIANCE);
                    break;
                case NPC_GORKUN_IRONSKULL_2:
                    if (NPC_MartinOrGorkunGUID)
                        if (Creature* c = instance->GetCreature(NPC_MartinOrGorkunGUID))
                        {
                            c->AI()->DoAction(1); // despawn summons
                            c->DespawnOrUnsummon();
                        }
                    if (teamIdInInstance == TEAM_ALLIANCE)
                        creature->UpdateEntry(NPC_MARTIN_VICTUS_2);
                    NPC_MartinOrGorkunGUID = creature->GetGUID();
                    break;
                case NPC_RIMEFANG:
                    NPC_RimefangGUID = creature->GetGUID();
                    if (m_auiEncounter[2] == DONE)
                        creature->SetVisible(false);
                    break;
                case NPC_TYRANNUS:
                    if (NPC_TyrannusGUID)
                        if (Creature* c = instance->GetCreature(NPC_TyrannusGUID))
                            c->DespawnOrUnsummon();
                    NPC_TyrannusGUID = creature->GetGUID();

                    if (m_auiEncounter[2] == DONE)
                        creature->SetVisible(false);
                    break;
                case NPC_SINDRAGOSA:
                    NPC_SindragosaGUID = creature->GetGUID();
                    break;
            }
        }

        void OnGameObjectCreate(GameObject* go) override
        {
            switch (go->GetEntry())
            {
                case GO_ICE_WALL:
                    GO_IceWallGUID = go->GetGUID();
                    if (GetData(DATA_GARFROST) == DONE && GetData(DATA_ICK) == DONE)
                        go->SetGoState(GO_STATE_ACTIVE);
                    break;
            }
        }

        void SetData(uint32 type, uint32 data) override
        {
            switch (type)
            {
                case DATA_INSTANCE_PROGRESS:
                    if (InstanceProgress < data)
                    {
                        InstanceProgress = data;
                        if (InstanceProgress == INSTANCE_PROGRESS_TYRANNUS_INTRO && instance->GetDifficulty() == DUNGEON_DIFFICULTY_HEROIC && bAchievDontLookUp) // achiev Don't Look Up (4525)
                            DoUpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_BE_SPELL_TARGET, 72845);
                    }
                    break;
                case DATA_GARFROST:
                    m_auiEncounter[0] = data;
                    if (data == DONE)
                        instance->SummonCreature(NPC_GORKUN_IRONSKULL_1, FBSSpawnPos);
                    else // NOT_STARTED, IN_PROGRESS
                        bAchievEleven = true;
                    if (data == DONE && GetData(DATA_ICK) == DONE)
                        if (GameObject* icewall = instance->GetGameObject(GO_IceWallGUID))
                            icewall->SetGoState(GO_STATE_ACTIVE);
                    break;
                case DATA_ICK:
                    m_auiEncounter[1] = data;
                    if (data == DONE && GetData(DATA_GARFROST) == DONE)
                        if (GameObject* icewall = instance->GetGameObject(GO_IceWallGUID))
                            icewall->SetGoState(GO_STATE_ACTIVE);
                    break;
                case DATA_TYRANNUS:
                    m_auiEncounter[2] = data;
                    if (data == DONE)
                        instance->SummonCreature(NPC_SYLVANAS_PART2, TSLeaderSpawnPos);
                    break;
                case DATA_ACHIEV_ELEVEN:
                    bAchievEleven = false;
                    break;
                case DATA_ACHIEV_DONT_LOOK_UP:
                    bAchievDontLookUp = false;
                    break;
            }

            if (data == DONE || type == DATA_INSTANCE_PROGRESS)
                SaveToDB();
        }

        void SetGuidData(uint32 type, ObjectGuid data) override
        {
            switch (type)
            {
                case DATA_NECROLYTE_1_GUID:
                    NPC_Necrolyte1GUID = data;
                    break;
                case DATA_NECROLYTE_2_GUID:
                    NPC_Necrolyte2GUID = data;
                    break;
                case DATA_MARTIN_OR_GORKUN_GUID:
                    NPC_MartinOrGorkunGUID = data;
                    break;
            }
        }

        uint32 GetData(uint32 type) const override
        {
            switch (type)
            {
                case DATA_INSTANCE_PROGRESS:
                    return InstanceProgress;
                case DATA_TEAMID_IN_INSTANCE:
                    return teamIdInInstance;
                case DATA_GARFROST:
                    return m_auiEncounter[0];
                case DATA_ICK:
                    return m_auiEncounter[1];
                case DATA_TYRANNUS:
                    return m_auiEncounter[2];
            }

            return 0;
        }

        ObjectGuid GetGuidData(uint32 type) const override
        {
            switch (type)
            {
                case DATA_TYRANNUS_EVENT_GUID:
                    return NPC_TyrannusEventGUID;
                case DATA_NECROLYTE_1_GUID:
                    return NPC_Necrolyte1GUID;
                case DATA_NECROLYTE_2_GUID:
                    return NPC_Necrolyte2GUID;
                case DATA_GUARD_1_GUID:
                    return NPC_GuardFirstGUID;
                case DATA_GUARD_2_GUID:
                    return NPC_GuardSecondGUID;
                case DATA_LEADER_FIRST_GUID:
                    return NPC_LeaderFirstGUID;
                case DATA_GARFROST_GUID:
                    return NPC_GarfrostGUID;
                case DATA_MARTIN_OR_GORKUN_GUID:
                    return NPC_MartinOrGorkunGUID;
                case DATA_RIMEFANG_GUID:
                    return NPC_RimefangGUID;
                case DATA_TYRANNUS_GUID:
                    return NPC_TyrannusGUID;
                case DATA_LEADER_SECOND_GUID:
                    return NPC_LeaderSecondGUID;
                case DATA_SINDRAGOSA_GUID:
                    return NPC_SindragosaGUID;
            }

            return ObjectGuid::Empty;
        }

        bool CheckAchievementCriteriaMeet(uint32 criteria_id, Player const*  /*source*/, Unit const*  /*target*/, uint32  /*miscvalue1*/) override
        {
            switch (criteria_id)
            {
                case 12993: // Doesn't Go to Eleven (4524)
                    return bAchievEleven;
            }
            return false;
        }

        void ReadSaveDataMore(std::istringstream& data) override
        {
            data >> m_auiEncounter[0];
            data >> m_auiEncounter[1];
            data >> m_auiEncounter[2];
            data >> InstanceProgress;
        }

        void WriteSaveDataMore(std::ostringstream& data) override
        {
            data << m_auiEncounter[0] << ' '
                << m_auiEncounter[1] << ' '
                << m_auiEncounter[2] << ' '
                << InstanceProgress;
        }
    };

    InstanceScript* GetInstanceScript(InstanceMap* map) const override
    {
        return new instance_pit_of_saron_InstanceScript(map);
    }
};

void AddSC_instance_pit_of_saron()
{
    new instance_pit_of_saron();
}

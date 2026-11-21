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

#include "Creature.h"
#include "CreatureData.h"
#include "GameObject.h"
#include "InstanceMapScript.h"
#include "InstanceScript.h"
#include "Map.h"
#include "pit_of_saron.h"
#include <algorithm>
#include <sstream>

class instance_pit_of_saron : public InstanceMapScript
{
public:
    instance_pit_of_saron() : InstanceMapScript(PitOfSaronScriptName, MAP_PIT_OF_SARON) { }

    struct instance_pit_of_saron_InstanceScript : public InstanceScript
    {
        instance_pit_of_saron_InstanceScript(Map* map) : InstanceScript(map)
        {
            SetHeaders(DataHeader);
        }

        void Initialize() override
        {
            std::fill_n(_encounters, MAX_ENCOUNTER, NOT_STARTED);
            _instanceProgress = INSTANCE_PROGRESS_NONE;

            _achievEleven = true;
            _achievDontLookUp = true;
        }

        bool IsEncounterInProgress() const override
        {
            for (uint8 i = 0; i < MAX_ENCOUNTER; ++i)
                if (_encounters[i] == IN_PROGRESS)
                    return true;

            return false;
        }

        void OnPlayerEnter(Player* player) override
        {
            InstanceScript::OnPlayerEnter(player);

            if (Creature* leader = instance->GetCreature(_leaderFirstGUID))
                leader->AI()->SetData(DATA_START_INTRO, 0);
        }

        uint32 GetCreatureEntry(ObjectGuid::LowType /*guidLow*/, CreatureData const* data) override
        {
            uint32 entry = data->id;
            switch (entry)
            {
                case NPC_RESCUED_ALLIANCE_SLAVE:
                    if (GetTeamIdInInstance() == TEAM_HORDE)
                        return 0;
                    break;
                case NPC_RESCUED_HORDE_SLAVE:
                    if (GetTeamIdInInstance() == TEAM_ALLIANCE)
                        return 0;
                    break;
                default:
                    break;
            }

            return entry;
        }

        void OnCreatureCreate(Creature* creature) override
        {
            switch (creature->GetEntry())
            {
                case NPC_SYLVANAS_PART1:
                    if (GetTeamIdInInstance() == TEAM_ALLIANCE)
                        creature->UpdateEntry(NPC_JAINA_PART1);
                    _leaderFirstGUID = creature->GetGUID();

                    switch (_instanceProgress)
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
                        default:
                            break;
                    }
                    break;
                case NPC_SYLVANAS_PART2:
                    if (GetTeamIdInInstance() == TEAM_ALLIANCE)
                        creature->UpdateEntry(NPC_JAINA_PART2);
                    _leaderSecondGUID = creature->GetGUID();
                    break;
                case NPC_TYRANNUS_EVENT:
                    if (!_tyrannusEventGUID)
                    {
                        switch (_instanceProgress)
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
                            default:
                                break;
                        }
                        _tyrannusEventGUID = creature->GetGUID();
                    }
                    break;
                case NPC_LORALEN:
                    if (GetTeamIdInInstance() == TEAM_ALLIANCE)
                        creature->UpdateEntry(NPC_ELANDRA);
                    if (!_guardFirstGUID)
                        _guardFirstGUID = creature->GetGUID();
                    break;
                case NPC_KALIRA:
                    if (GetTeamIdInInstance() == TEAM_ALLIANCE)
                        creature->UpdateEntry(NPC_KORELN);
                    if (!_guardSecondGUID)
                        _guardSecondGUID = creature->GetGUID();
                    break;
                case NPC_HORDE_SLAVE_1:
                    if (GetTeamIdInInstance() == TEAM_ALLIANCE)
                        creature->UpdateEntry(NPC_ALLIANCE_SLAVE_1);
                    break;
                case NPC_HORDE_SLAVE_2:
                    if (GetTeamIdInInstance() == TEAM_ALLIANCE)
                        creature->UpdateEntry(NPC_ALLIANCE_SLAVE_2);
                    break;
                case NPC_HORDE_SLAVE_3:
                    if (GetTeamIdInInstance() == TEAM_ALLIANCE)
                        creature->UpdateEntry(NPC_ALLIANCE_SLAVE_3);
                    break;
                case NPC_HORDE_SLAVE_4:
                    if (GetTeamIdInInstance() == TEAM_ALLIANCE)
                        creature->UpdateEntry(NPC_ALLIANCE_SLAVE_4);
                    break;
                case NPC_GORKUN_IRONSKULL_1:
                    if (GetTeamIdInInstance() == TEAM_ALLIANCE)
                        creature->UpdateEntry(NPC_MARTIN_VICTUS_1);
                    break;
                case NPC_GARFROST:
                    _garfrostGUID = creature->GetGUID();
                    break;
                case NPC_FREED_SLAVE_1_HORDE:
                    if (GetTeamIdInInstance() == TEAM_ALLIANCE)
                        creature->UpdateEntry(NPC_FREED_SLAVE_1_ALLIANCE);
                    break;
                case NPC_FREED_SLAVE_2_HORDE:
                    if (GetTeamIdInInstance() == TEAM_ALLIANCE)
                        creature->UpdateEntry(NPC_FREED_SLAVE_2_ALLIANCE);
                    break;
                case NPC_FREED_SLAVE_3_HORDE:
                    if (GetTeamIdInInstance() == TEAM_ALLIANCE)
                        creature->UpdateEntry(NPC_FREED_SLAVE_3_ALLIANCE);
                    break;
                case NPC_GORKUN_IRONSKULL_2:
                    if (Creature* general = instance->GetCreature(_martinOrGorkunGUID))
                    {
                        general->AI()->DoAction(ACTION_DESPAWN_SUMMONS);
                        general->DespawnOrUnsummon();
                    }
                    if (GetTeamIdInInstance() == TEAM_ALLIANCE)
                        creature->UpdateEntry(NPC_MARTIN_VICTUS_2);
                    _martinOrGorkunGUID = creature->GetGUID();
                    break;
                case NPC_RIMEFANG:
                    _rimefangGUID = creature->GetGUID();
                    if (_encounters[DATA_TYRANNUS] == DONE)
                        creature->SetVisible(false);
                    break;
                case NPC_TYRANNUS:
                    if (Creature* tyrannus = instance->GetCreature(_tyrannusGUID))
                        tyrannus->DespawnOrUnsummon();
                    _tyrannusGUID = creature->GetGUID();

                    if (_encounters[DATA_TYRANNUS] == DONE)
                        creature->SetVisible(false);
                    break;
                case NPC_SINDRAGOSA:
                    _sindragosaGUID = creature->GetGUID();
                    break;
                default:
                    break;
            }
        }

        void OnGameObjectCreate(GameObject* go) override
        {
            switch (go->GetEntry())
            {
                case GO_ICE_WALL:
                    _iceWallGUID = go->GetGUID();
                    if (GetData(DATA_GARFROST) == DONE && GetData(DATA_ICK) == DONE)
                        go->SetGoState(GO_STATE_ACTIVE);
                    break;
                default:
                    break;
            }
        }

        void SetData(uint32 type, uint32 data) override
        {
            switch (type)
            {
                case DATA_INSTANCE_PROGRESS:
                    if (_instanceProgress < data)
                    {
                        _instanceProgress = data;
                        if (_instanceProgress == INSTANCE_PROGRESS_TYRANNUS_INTRO && instance->GetDifficulty() == DUNGEON_DIFFICULTY_HEROIC && _achievDontLookUp)
                            DoUpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_BE_SPELL_TARGET, SPELL_ACHIEVEMENT_CHECK_DONT_LOOK_UP);
                    }
                    break;
                case DATA_GARFROST:
                    _encounters[DATA_GARFROST] = data;
                    if (data == DONE)
                        instance->SummonCreature(NPC_GORKUN_IRONSKULL_1, FBSSpawnPos);
                    else // NOT_STARTED, IN_PROGRESS
                        _achievEleven = true;
                    if (data == DONE && GetData(DATA_ICK) == DONE)
                        if (GameObject* iceWall = instance->GetGameObject(_iceWallGUID))
                            iceWall->SetGoState(GO_STATE_ACTIVE);
                    break;
                case DATA_ICK:
                    _encounters[DATA_ICK] = data;
                    if (data == DONE && GetData(DATA_GARFROST) == DONE)
                        if (GameObject* iceWall = instance->GetGameObject(_iceWallGUID))
                            iceWall->SetGoState(GO_STATE_ACTIVE);
                    break;
                case DATA_TYRANNUS:
                    _encounters[DATA_TYRANNUS] = data;
                    if (data == DONE)
                        instance->SummonCreature(NPC_SYLVANAS_PART2, TSLeaderSpawnPos);
                    break;
                case DATA_ACHIEV_ELEVEN:
                    _achievEleven = false;
                    break;
                case DATA_ACHIEV_DONT_LOOK_UP:
                    _achievDontLookUp = false;
                    break;
                default:
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
                    _necrolyte1GUID = data;
                    break;
                case DATA_NECROLYTE_2_GUID:
                    _necrolyte2GUID = data;
                    break;
                case DATA_MARTIN_OR_GORKUN_GUID:
                    _martinOrGorkunGUID = data;
                    break;
                default:
                    break;
            }
        }

        uint32 GetData(uint32 type) const override
        {
            switch (type)
            {
                case DATA_INSTANCE_PROGRESS:
                    return _instanceProgress;
                case DATA_TEAMID_IN_INSTANCE:
                    return GetTeamIdInInstance();
                case DATA_GARFROST:
                case DATA_ICK:
                case DATA_TYRANNUS:
                    return _encounters[type];
                default:
                    break;
            }

            return 0;
        }

        ObjectGuid GetGuidData(uint32 type) const override
        {
            switch (type)
            {
                case DATA_TYRANNUS_EVENT_GUID:
                    return _tyrannusEventGUID;
                case DATA_NECROLYTE_1_GUID:
                    return _necrolyte1GUID;
                case DATA_NECROLYTE_2_GUID:
                    return _necrolyte2GUID;
                case DATA_GUARD_1_GUID:
                    return _guardFirstGUID;
                case DATA_GUARD_2_GUID:
                    return _guardSecondGUID;
                case DATA_LEADER_FIRST_GUID:
                    return _leaderFirstGUID;
                case DATA_GARFROST_GUID:
                    return _garfrostGUID;
                case DATA_MARTIN_OR_GORKUN_GUID:
                    return _martinOrGorkunGUID;
                case DATA_RIMEFANG_GUID:
                    return _rimefangGUID;
                case DATA_TYRANNUS_GUID:
                    return _tyrannusGUID;
                case DATA_LEADER_SECOND_GUID:
                    return _leaderSecondGUID;
                case DATA_SINDRAGOSA_GUID:
                    return _sindragosaGUID;
                default:
                    break;
            }

            return ObjectGuid::Empty;
        }

        bool CheckAchievementCriteriaMeet(uint32 criteriaId, Player const* /*source*/, Unit const* /*target*/, uint32 /*miscvalue1*/) override
        {
            switch (criteriaId)
            {
                case CRITERIA_DOESNT_GO_TO_ELEVEN:
                    return _achievEleven;
                default:
                    break;
            }

            return false;
        }

        void ReadSaveDataMore(std::istringstream& data) override
        {
            data >> _encounters[DATA_GARFROST];
            data >> _encounters[DATA_ICK];
            data >> _encounters[DATA_TYRANNUS];
            data >> _instanceProgress;
        }

        void WriteSaveDataMore(std::ostringstream& data) override
        {
            data << _encounters[DATA_GARFROST] << ' '
                << _encounters[DATA_ICK] << ' '
                << _encounters[DATA_TYRANNUS] << ' '
                << _instanceProgress;
        }

    private:
        uint32 _encounters[MAX_ENCOUNTER];
        uint32 _instanceProgress;

        ObjectGuid _leaderFirstGUID;
        ObjectGuid _leaderSecondGUID;
        ObjectGuid _tyrannusEventGUID;
        ObjectGuid _necrolyte1GUID;
        ObjectGuid _necrolyte2GUID;
        ObjectGuid _guardFirstGUID;
        ObjectGuid _guardSecondGUID;
        ObjectGuid _sindragosaGUID;

        ObjectGuid _garfrostGUID;
        ObjectGuid _martinOrGorkunGUID;
        ObjectGuid _rimefangGUID;
        ObjectGuid _tyrannusGUID;

        ObjectGuid _iceWallGUID;

        bool _achievEleven;
        bool _achievDontLookUp;
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

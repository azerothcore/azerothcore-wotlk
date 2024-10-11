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

#include "EventMap.h"
#include "InstanceMapScript.h"
#include "InstanceScript.h"
#include "Player.h"
#include "old_hillsbrad.h"

static Position const instancePositions[INSTANCE_POSITIONS_COUNT] =
{
    { 2188.18f, 228.90f, 53.025f, 1.77f },    // Orcs Gather Point 1
    { 2103.23f, 93.550f, 53.096f, 3.78f },    // Orcs Gather Point 2
    { 2172.76f, 149.54f, 87.981f, 4.19f }     // Lieutenant Drake Summon Position
};

const Position thrallPositions[THRALL_POSITIONS_COUNT] =
{
    {2181.37f, 119.15f, 89.45f, 5.75f},     // After wearing armor
    {2096.09f, 195.91f, 65.22f, 2.45f},     // After Fourth Ambush
    {2062.9f, 229.93f, 64.454f, 2.45f},     // After Captain Skarloc death
    {2486.91f, 626.356f, 58.0761f, 0.0f},   // Arrived at Tarren Mill
    {2660.47f, 659.223f, 62.0f, 5.78f}      // Taretha Met
};

class instance_old_hillsbrad : public InstanceMapScript
{
public:
    instance_old_hillsbrad() : InstanceMapScript("instance_old_hillsbrad", 560) { }

    InstanceScript* GetInstanceScript(InstanceMap* map) const override
    {
        return new instance_old_hillsbrad_InstanceMapScript(map);
    }

    struct instance_old_hillsbrad_InstanceMapScript : public InstanceScript
    {
        instance_old_hillsbrad_InstanceMapScript(Map* map) : InstanceScript(map) { }

        void Initialize() override
        {
            SetHeaders(DataHeader);
            _encounterProgress = 0;
            _barrelCount = 0;
            _attemptsCount = 0;

            _initalFlamesSet.clear();
            _finalFlamesSet.clear();
            _prisonersSet.clear();
            _events.Reset();
        }

        void OnPlayerEnter(Player* player) override
        {
            if (instance->GetPlayersCountExceptGMs() <= 1)
                CleanupInstance();

            EnsureGridLoaded();

            if (_encounterProgress < ENCOUNTER_PROGRESS_BARRELS)
                player->SendUpdateWorldState(WORLD_STATE_BARRELS_PLANTED, _barrelCount);
        }

        void CleanupInstance()
        {
            if (_encounterProgress == ENCOUNTER_PROGRESS_NONE)
                return;

            _events.ScheduleEvent(EVENT_INITIAL_BARRELS_FLAME, 0);
            _events.ScheduleEvent(EVENT_FINAL_BARRELS_FLAME, 0);

            if (_encounterProgress == ENCOUNTER_PROGRESS_BARRELS)
                _events.ScheduleEvent(EVENT_SUMMON_LIEUTENANT, 0);
            else
                SetData(DATA_THRALL_REPOSITION, 2);
        }

        void OnCreatureCreate(Creature* creature) override
        {
            switch (creature->GetEntry())
            {
                case NPC_THRALL:
                    _thrallGUID = creature->GetGUID();
                    if (_encounterProgress == ENCOUNTER_PROGRESS_FINISHED)
                        creature->SetVisible(false);
                    else
                        Reposition(creature);
                    break;
                case NPC_ORC_PRISONER:
                    _prisonersSet.insert(creature->GetGUID());
                    break;
                case NPC_TARETHA:
                    if (_encounterProgress == ENCOUNTER_PROGRESS_FINISHED)
                        creature->SetVisible(false);
                    _tarethaGUID = creature->GetGUID();
                    break;
            }
        }

        void OnGameObjectCreate(GameObject* gameobject) override
        {
            switch (gameobject->GetEntry())
            {
                case GO_BARREL:
                    if (_encounterProgress >= ENCOUNTER_PROGRESS_BARRELS)
                        gameobject->SetGameObjectFlag(GO_FLAG_NOT_SELECTABLE);
                    break;
                case GO_PRISON_DOOR:
                    if (_encounterProgress >= ENCOUNTER_PROGRESS_THRALL_ARMORED)
                        gameobject->SetGoState(GO_STATE_ACTIVE);
                    break;
                case GO_ROARING_FLAME:
                    // Xinef: hack in DB to distinguish final / initial flames
                    if (gameobject->GetPhaseMask() & 0x2)
                        _finalFlamesSet.insert(gameobject->GetGUID());
                    else
                        _initalFlamesSet.insert(gameobject->GetGUID());
                    break;
            }
        }

        void SetData(uint32 type, uint32 data) override
        {
            switch (type)
            {
                case DATA_THRALL_REPOSITION:
                    if (data > 1)
                        _events.ScheduleEvent(EVENT_THRALL_REPOSITION, data == 2 ? 0 : 10000);
                    else if (Creature* thrall = instance->GetCreature(_thrallGUID))
                        Reposition(thrall);
                    return;
                case DATA_ESCORT_PROGRESS:
                    if (_encounterProgress < data)
                    {
                        _encounterProgress = data;
                        SaveToDB();
                    }
                    break;
                case DATA_BOMBS_PLACED:
                    {
                        if (_barrelCount >= 5 || _encounterProgress > ENCOUNTER_PROGRESS_NONE)
                            return;

                        DoUpdateWorldState(WORLD_STATE_BARRELS_PLANTED, ++_barrelCount);
                        if (_barrelCount == 5)
                        {
                            _events.ScheduleEvent(EVENT_INITIAL_BARRELS_FLAME, 4000);
                            _events.ScheduleEvent(EVENT_FINAL_BARRELS_FLAME, 12000);
                            _events.ScheduleEvent(EVENT_SUMMON_LIEUTENANT, 18000);
                        }
                        break;
                    }
                case DATA_THRALL_ADD_FLAG:
                    if (Creature* thrall = instance->GetCreature(_thrallGUID))
                        thrall->SetNpcFlag(UNIT_NPC_FLAG_GOSSIP);
                    break;
            }
        }

        uint32 GetData(uint32 data) const override
        {
            if (data == DATA_ESCORT_PROGRESS)
                return _encounterProgress;
            else if (data == DATA_ATTEMPTS_COUNT)
                return _attemptsCount;
            return 0;
        }

        ObjectGuid GetGuidData(uint32 data) const override
        {
            if (data == DATA_THRALL_GUID)
                return _thrallGUID;
            else if (data == DATA_TARETHA_GUID)
                return _tarethaGUID;

            return ObjectGuid::Empty;
        }

        void Update(uint32 diff) override
        {
            _events.Update(diff);
            switch (_events.ExecuteEvent())
            {
                case EVENT_INITIAL_BARRELS_FLAME:
                    {
                        instance->LoadGrid(instancePositions[0].GetPositionX(), instancePositions[0].GetPositionY());
                        instance->LoadGrid(instancePositions[1].GetPositionX(), instancePositions[1].GetPositionY());

                        for (ObjectGuid const& guid : _prisonersSet)
                            if (Creature* orc = instance->GetCreature(guid))
                            {
                                uint8 index = orc->GetDistance(instancePositions[0]) < 80.0f ? 0 : 1;
                                Position pos(instancePositions[index]);
                                orc->MovePosition(pos, frand(1.0f, 3.0f) + 15.0f * (float)rand_norm(), (float)rand_norm() * static_cast<float>(2 * M_PI));
                                orc->GetMotionMaster()->MovePoint(1, pos);
                                orc->SetStandState(UNIT_STAND_STATE_STAND);
                            }

                        for (ObjectGuid const& guid : _initalFlamesSet)
                            if (GameObject* gobject = instance->GetGameObject(guid))
                            {
                                gobject->SetRespawnTime(0);
                                gobject->UpdateObjectVisibility(true);
                            }
                        break;
                    }
                case EVENT_FINAL_BARRELS_FLAME:
                    {
                        instance->LoadGrid(instancePositions[0].GetPositionX(), instancePositions[0].GetPositionY());
                        instance->LoadGrid(instancePositions[1].GetPositionX(), instancePositions[1].GetPositionY());

                        if (_encounterProgress == ENCOUNTER_PROGRESS_NONE)
                        {
                            Map::PlayerList const& players = instance->GetPlayers();
                            if (!players.IsEmpty())
                                for (Map::PlayerList::const_iterator itr = players.begin(); itr != players.end(); ++itr)
                                    if (Player* player = itr->GetSource())
                                        player->KilledMonsterCredit(NPC_LODGE_QUEST_TRIGGER);
                        }

                        for (ObjectGuid const& guid : _finalFlamesSet)
                            if (GameObject* gobject = instance->GetGameObject(guid))
                            {
                                gobject->SetRespawnTime(0);
                                gobject->UpdateObjectVisibility(true);
                            }

                        for (ObjectGuid const& guid : _prisonersSet)
                            if (Creature* orc = instance->GetCreature(guid))
                                if (roll_chance_i(25))
                                    orc->HandleEmoteCommand(EMOTE_ONESHOT_CHEER);

                        SetData(DATA_ESCORT_PROGRESS, ENCOUNTER_PROGRESS_BARRELS);
                        DoUpdateWorldState(WORLD_STATE_BARRELS_PLANTED, 0);
                        break;
                    }
                case EVENT_SUMMON_LIEUTENANT:
                    {
                        instance->LoadGrid(instancePositions[2].GetPositionX(), instancePositions[2].GetPositionY());
                        instance->SummonCreature(NPC_LIEUTENANT_DRAKE, instancePositions[2]);
                        break;
                    }
                case EVENT_THRALL_REPOSITION:
                    {
                        if (Creature* thrall = instance->GetCreature(_thrallGUID))
                        {
                            if (!thrall->IsAlive())
                            {
                                ++_attemptsCount;
                                EnsureGridLoaded();
                                thrall->SetVisible(false);
                                Reposition(thrall);
                                thrall->setDeathState(DeathState::Dead);
                                thrall->Respawn();
                                thrall->SetVisible(true);
                                SaveToDB();
                            }
                            else
                                thrall->AI()->Reset();
                        }
                        break;
                    }
            }
        }

        void Reposition(Creature* thrall)
        {
            switch (uint32 data = GetData(DATA_ESCORT_PROGRESS))
            {
                case ENCOUNTER_PROGRESS_THRALL_ARMORED:
                case ENCOUNTER_PROGRESS_AMBUSHES_1:
                case ENCOUNTER_PROGRESS_SKARLOC_KILLED:
                case ENCOUNTER_PROGRESS_TARREN_MILL:
                case ENCOUNTER_PROGRESS_TARETHA_MEET:
                    thrall->UpdatePosition(thrallPositions[data - ENCOUNTER_PROGRESS_THRALL_ARMORED], true);
                    thrall->SetHomePosition(thrallPositions[data - ENCOUNTER_PROGRESS_THRALL_ARMORED]);
                    thrall->SetFacingTo(thrallPositions[data - ENCOUNTER_PROGRESS_THRALL_ARMORED].GetOrientation());
                    break;
            }
        }

        void EnsureGridLoaded()
        {
            for (uint8 i = 0; i < THRALL_POSITIONS_COUNT; ++i)
                instance->LoadGrid(thrallPositions[i].GetPositionX(), thrallPositions[i].GetPositionY());
        }

        void ReadSaveDataMore(std::istringstream& data) override
        {
            data >> _encounterProgress;
            data >> _attemptsCount;
        }

        void WriteSaveDataMore(std::ostringstream& data) override
        {
            data << _encounterProgress << ' ' << _attemptsCount;
        }

    private:
        uint32 _encounterProgress;
        uint32 _barrelCount;
        uint32 _attemptsCount;

        ObjectGuid _thrallGUID;
        ObjectGuid _tarethaGUID;
        GuidSet _initalFlamesSet;
        GuidSet _finalFlamesSet;
        GuidSet _prisonersSet;

        EventMap _events;
    };
};

void AddSC_instance_old_hillsbrad()
{
    new instance_old_hillsbrad();
}

/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "InstanceScript.h"
#include "old_hillsbrad.h"
#include "Player.h"

const Position instancePositions[INSTANCE_POSITIONS_COUNT] = 
{
    {2188.18f, 228.90f, 53.025f, 1.77f},    // Orcs Gather Point 1
    {2103.23f, 93.55f, 53.096f, 3.78f},     // Orcs Gather Point 2
    {2128.43f, 71.01f, 64.42f, 1.74f}       // Lieutenant Drake Summon Position
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

    InstanceScript* GetInstanceScript(InstanceMap* map) const
    {
        return new instance_old_hillsbrad_InstanceMapScript(map);
    }

    struct instance_old_hillsbrad_InstanceMapScript : public InstanceScript
    {
        instance_old_hillsbrad_InstanceMapScript(Map* map) : InstanceScript(map) { }

        void Initialize()
        {
            _encounterProgress = 0;
            _barrelCount = 0;
            _attemptsCount = 0;

            _thrallGUID = 0;
            _tarethaGUID = 0;

            _initalFlamesSet.clear();
            _finalFlamesSet.clear();
            _prisonersSet.clear();
            _events.Reset();
        }

        void OnPlayerEnter(Player* player)
        {
            if (instance->GetPlayersCountExceptGMs() == 1)
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

        void OnCreatureCreate(Creature* creature)
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

        void OnGameObjectCreate(GameObject* gameobject)
        {
            switch (gameobject->GetEntry())
            {
                case GO_BARREL:
                    if (_encounterProgress >= ENCOUNTER_PROGRESS_BARRELS)
                        gameobject->SetFlag(GAMEOBJECT_FLAGS, GO_FLAG_NOT_SELECTABLE);
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

        void SetData(uint32 type, uint32 data)
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
                    _encounterProgress = data;
                    SaveToDB();
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
                        thrall->SetFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);
                    break;
            }
        }

        uint32 GetData(uint32 data) const
        {
            if (data == DATA_ESCORT_PROGRESS)
                return _encounterProgress;
            else if (data == DATA_ATTEMPTS_COUNT)
                return _attemptsCount;
            return 0;
        }

        uint64 GetData64(uint32 data) const
        {
            if (data == DATA_THRALL_GUID)
                return _thrallGUID;
            else if (data == DATA_TARETHA_GUID)
                return _tarethaGUID;
            return 0;
        }

        void Update(uint32 diff)
        {
            _events.Update(diff);
            switch (_events.ExecuteEvent())
            {
                case EVENT_INITIAL_BARRELS_FLAME:
                {
                    instance->LoadGrid(instancePositions[0].GetPositionX(), instancePositions[0].GetPositionY());
                    instance->LoadGrid(instancePositions[1].GetPositionX(), instancePositions[1].GetPositionY());

                    for (std::set<uint64>::const_iterator itr = _prisonersSet.begin(); itr != _prisonersSet.end(); ++itr)
                        if (Creature* orc = instance->GetCreature(*itr))
                        {
                            uint8 index = orc->GetDistance(instancePositions[0]) < 80.0f ? 0 : 1;
                            Position pos(instancePositions[index]);
                            orc->MovePosition(pos, frand(1.0f, 3.0f) + 15.0f * (float)rand_norm(), (float)rand_norm() * static_cast<float>(2 * M_PI));
                            orc->GetMotionMaster()->MovePoint(1, pos);
                            orc->SetStandState(UNIT_STAND_STATE_STAND);
                        }

                    for (std::set<uint64>::const_iterator itr = _initalFlamesSet.begin(); itr != _initalFlamesSet.end(); ++itr)
                        if (GameObject* gobject = instance->GetGameObject(*itr))
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
                        if (!players.isEmpty())
                            for (Map::PlayerList::const_iterator itr = players.begin(); itr != players.end(); ++itr)
                                if (Player* player = itr->GetSource())
                                    player->KilledMonsterCredit(NPC_LODGE_QUEST_TRIGGER, 0);
                    }

                    for (std::set<uint64>::const_iterator itr = _finalFlamesSet.begin(); itr != _finalFlamesSet.end(); ++itr)
                        if (GameObject* gobject = instance->GetGameObject(*itr))
                        {
                            gobject->SetRespawnTime(0);
                            gobject->UpdateObjectVisibility(true);
                        }

                    for (std::set<uint64>::const_iterator itr = _prisonersSet.begin(); itr != _prisonersSet.end(); ++itr)
                        if (Creature* orc = instance->GetCreature(*itr))
                            if (roll_chance_i(25))
                                orc->HandleEmoteCommand(EMOTE_ONESHOT_CHEER);
                    
                    SetData(DATA_ESCORT_PROGRESS, ENCOUNTER_PROGRESS_BARRELS);
                    DoUpdateWorldState(WORLD_STATE_BARRELS_PLANTED, 0);
                    break;
                }
                case EVENT_SUMMON_LIEUTENANT:
                {
                    instance->LoadGrid(instancePositions[2].GetPositionX(), instancePositions[2].GetPositionY());
                    if (Creature* drake = instance->SummonCreature(NPC_LIEUTENANT_DRAKE, instancePositions[2]))
                        drake->AI()->Talk(0);
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
                            thrall->setDeathState(DEAD);
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

        std::string GetSaveData()
        {
            OUT_SAVE_INST_DATA;

            std::ostringstream saveStream;
                saveStream << "O H " << _encounterProgress << ' ' << _attemptsCount;

            OUT_SAVE_INST_DATA_COMPLETE;
            return saveStream.str();
        }

        void Load(const char* in)
        {
            if (!in)
            {
                OUT_LOAD_INST_DATA_FAIL;
                return;
            }

            OUT_LOAD_INST_DATA(in);

            char dataHead1, dataHead2;
            uint32 data0, data1;

            std::istringstream loadStream(in);
            loadStream >> dataHead1 >> dataHead2 >> data0 >> data1;

            if (dataHead1 == 'O' && dataHead2 == 'H')
            {
                _encounterProgress = data0;
                _attemptsCount = data1;
            }
            else
                OUT_LOAD_INST_DATA_FAIL;

            OUT_LOAD_INST_DATA_COMPLETE;
        }

        private:
            uint32 _encounterProgress;
            uint32 _barrelCount;
            uint32 _attemptsCount;

            uint64 _thrallGUID;
            uint64 _tarethaGUID;
            std::set<uint64> _initalFlamesSet;
            std::set<uint64> _finalFlamesSet;
            std::set<uint64> _prisonersSet;

            EventMap _events;
    };

};

void AddSC_instance_old_hillsbrad()
{
    new instance_old_hillsbrad();
}

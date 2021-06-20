/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "InstanceScript.h"
#include "blood_furnace.h"
#include "CreatureAI.h"

class instance_blood_furnace : public InstanceMapScript
{
    public:
        instance_blood_furnace() : InstanceMapScript("instance_blood_furnace", 542) {}

        struct instance_blood_furnace_InstanceMapScript : public InstanceScript
        {
            instance_blood_furnace_InstanceMapScript(Map* map) : InstanceScript(map) {}

            uint32 _auiEncounter[MAX_ENCOUNTER];
            uint64 _bossGUIDs[3];
            uint64 _doorGUIDs[6];
            uint64 _prisonGUIDs[4];

            std::set<uint64> _prisonersCell[4];

            uint8 _prisonerCounter[4];

            uint64 _broggokLeverGUID;

            void Initialize()
            {
                memset(&_auiEncounter, 0, sizeof(_auiEncounter));
                memset(&_bossGUIDs, 0, sizeof(_bossGUIDs));
                memset(&_doorGUIDs, 0, sizeof(_doorGUIDs));
                memset(&_prisonGUIDs, 0, sizeof(_prisonGUIDs));
                memset(&_prisonerCounter, 0, sizeof(_prisonerCounter));

                for (uint8 i = 0; i < 4; ++i)
                    _prisonersCell[i].clear();

                _broggokLeverGUID = 0;
            }

            void OnCreatureCreate(Creature* creature)
            {
                switch (creature->GetEntry())
                {
                    case NPC_THE_MAKER:
                        _bossGUIDs[DATA_THE_MAKER] = creature->GetGUID();
                        break;
                    case NPC_BROGGOK:
                        _bossGUIDs[DATA_BROGGOK] = creature->GetGUID();
                        break;
                    case NPC_KELIDAN:
                        _bossGUIDs[DATA_KELIDAN] = creature->GetGUID();
                        break;
                    case NPC_NASCENT_FEL_ORC:
                        StorePrisoner(creature);
                        break;
                }
            }

            void OnUnitDeath(Unit* unit)
            {
                if (unit && unit->GetTypeId() == TYPEID_UNIT && unit->GetEntry() == NPC_NASCENT_FEL_ORC)
                    PrisonerDied(unit->GetGUID());
            }

            void OnGameObjectCreate(GameObject* go)
            {
                 if (go->GetEntry() == 181766)                //Final exit door
                     _doorGUIDs[0] = go->GetGUID();
                 if (go->GetEntry() == 181811)               //The Maker Front door
                     _doorGUIDs[1] = go->GetGUID();
                 if (go->GetEntry() == 181812)                //The Maker Rear door
                 {
                     _doorGUIDs[2] = go->GetGUID();
                     if (GetData(DATA_THE_MAKER) == DONE)
                         HandleGameObject(go->GetGUID(), true);
                 }
                 if (go->GetEntry() == 181822)               //Broggok Front door
                     _doorGUIDs[3] = go->GetGUID();
                 if (go->GetEntry() == 181819)               //Broggok Rear door
                 {
                     _doorGUIDs[4] = go->GetGUID();
                     if (GetData(DATA_BROGGOK) == DONE)
                         HandleGameObject(go->GetGUID(), true);
                 }
                 if (go->GetEntry() == 181823)               //Kelidan exit door
                     _doorGUIDs[5] = go->GetGUID();

                 if (go->GetEntry() == 181821)               //Broggok prison cell front right
                     _prisonGUIDs[0] = go->GetGUID();
                 if (go->GetEntry() == 181818)               //Broggok prison cell back right
                     _prisonGUIDs[1] = go->GetGUID();
                 if (go->GetEntry() == 181820)               //Broggok prison cell front left
                     _prisonGUIDs[2] = go->GetGUID();
                 if (go->GetEntry() == 181817)               //Broggok prison cell back left
                     _prisonGUIDs[3] = go->GetGUID();

                 if (go->GetEntry() == 181982)
                     _broggokLeverGUID = go->GetGUID();       //Broggok lever
            }

            uint64 GetData64(uint32 data) const
            {
                switch (data)
                {
                     case DATA_THE_MAKER:
                     case DATA_BROGGOK:
                     case DATA_KELIDAN:
                         return _bossGUIDs[data];

                     case DATA_DOOR1:
                     case DATA_DOOR2:
                     case DATA_DOOR3:
                     case DATA_DOOR4:
                     case DATA_DOOR5:
                     case DATA_DOOR6:
                         return _doorGUIDs[data-DATA_DOOR1];

                     case DATA_PRISON_CELL1:
                     case DATA_PRISON_CELL2:
                     case DATA_PRISON_CELL3:
                     case DATA_PRISON_CELL4:
                         return _prisonGUIDs[data-DATA_PRISON_CELL1];
                }
                return 0;
            }

            void SetData(uint32 type, uint32 data)
            {
                 switch (type)
                 {
                     case DATA_THE_MAKER:
                     case DATA_BROGGOK:
                     case DATA_KELIDAN:
                         _auiEncounter[type] = data;
                         if (type == DATA_BROGGOK)
                             UpdateBroggokEvent(data);
                         break;
                 }

                if (data == DONE)
                    SaveToDB();
            }

            std::string GetSaveData()
            {
                OUT_SAVE_INST_DATA;

                std::ostringstream saveStream;
                saveStream << "B F " << _auiEncounter[0] << ' ' << _auiEncounter[1] << ' ' << _auiEncounter[2];

                OUT_SAVE_INST_DATA_COMPLETE;
                return saveStream.str();
            }

            uint32 GetData(uint32 type) const
            {
                switch (type)
                {
                    case DATA_THE_MAKER:
                    case DATA_BROGGOK:
                    case DATA_KELIDAN:
                        return _auiEncounter[type];
                }
                return 0;
            }

            void Load(const char* strIn)
            {
                if (!strIn)
                {
                    OUT_LOAD_INST_DATA_FAIL;
                    return;
                }

                OUT_LOAD_INST_DATA(strIn);

                char dataHead1, dataHead2;

                std::istringstream loadStream(strIn);
                loadStream >> dataHead1 >> dataHead2;

                if (dataHead1 == 'B' && dataHead2 == 'F')
                {
                    loadStream >> _auiEncounter[0] >> _auiEncounter[1] >> _auiEncounter[2];

                    for (uint8 i = 0; i < MAX_ENCOUNTER; ++i)
                        if (_auiEncounter[i] == IN_PROGRESS || _auiEncounter[i] == FAIL)
                            _auiEncounter[i] = NOT_STARTED;
                }

                OUT_LOAD_INST_DATA_COMPLETE;
            }

            void UpdateBroggokEvent(uint32 data)
            {
                switch (data)
                {
                    case IN_PROGRESS:
                        ActivateCell(DATA_PRISON_CELL1);
                        HandleGameObject(_doorGUIDs[3], false);
                        break;
                    case NOT_STARTED:
                        ResetPrisons();
                        HandleGameObject(_doorGUIDs[4], false);
                        HandleGameObject(_doorGUIDs[3], true);
                        if (GameObject* lever = instance->GetGameObject(_broggokLeverGUID))
                            lever->Respawn();
                        break;
                }
            }

            void ResetPrisons()
            {
                for (uint8 i = 0; i < 4; ++i)
                {
                    _prisonerCounter[i] = _prisonersCell[i].size();
                    ResetPrisoners(_prisonersCell[i]);
                    HandleGameObject(_prisonGUIDs[i], false);
                }
            }

            void ResetPrisoners(std::set<uint64> prisoners)
            {
                for (std::set<uint64>::iterator i = prisoners.begin(); i != prisoners.end(); ++i)
                    if (Creature* prisoner = instance->GetCreature(*i))
                        ResetPrisoner(prisoner);
            }

            void ResetPrisoner(Creature* prisoner)
            {
                if (!prisoner->IsAlive())
                    prisoner->Respawn(true);
                prisoner->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_PC | UNIT_FLAG_IMMUNE_TO_NPC | UNIT_FLAG_NON_ATTACKABLE);
            }

            void StorePrisoner(Creature* creature)
            {
                float posX = creature->GetPositionX();
                float posY = creature->GetPositionY();

                if (posX >= 405.0f && posX <= 423.0f)
                {
                    if (posY >= 106.0f && posY <= 123.0f)
                    {
                        _prisonersCell[0].insert(creature->GetGUID());
                        ++_prisonerCounter[0];
                        ResetPrisoner(creature);
                    }
                    else if (posY >= 76.0f && posY <= 91.0f)
                    {
                        _prisonersCell[1].insert(creature->GetGUID());
                        ++_prisonerCounter[1];
                        ResetPrisoner(creature);
                    }
                }
                else if (posX >= 490.0f && posX <= 506.0f)
                {
                    if (posY >= 106.0f && posY <= 123.0f)
                    {
                        _prisonersCell[2].insert(creature->GetGUID());
                        ++_prisonerCounter[2];
                        ResetPrisoner(creature);
                    }
                    else if (posY >= 76.0f && posY <= 91.0f)
                    {
                        _prisonersCell[3].insert(creature->GetGUID());
                        ++_prisonerCounter[3];
                        ResetPrisoner(creature);
                    }
                }
            }

            void PrisonerDied(uint64 guid)
            {
                if (_prisonersCell[0].find(guid) != _prisonersCell[0].end() && --_prisonerCounter[0] <= 0)
                    ActivateCell(DATA_PRISON_CELL2);
                else if (_prisonersCell[1].find(guid) != _prisonersCell[1].end() && --_prisonerCounter[1] <= 0)
                    ActivateCell(DATA_PRISON_CELL3);
                else if (_prisonersCell[2].find(guid) != _prisonersCell[2].end() && --_prisonerCounter[2] <= 0)
                    ActivateCell(DATA_PRISON_CELL4);
                else if (_prisonersCell[3].find(guid) != _prisonersCell[3].end() && --_prisonerCounter[3] <= 0)
                    ActivateCell(DATA_DOOR5);
            }

            void ActivateCell(uint8 id)
            {
                switch (id)
                {
                    case DATA_PRISON_CELL1:
                    case DATA_PRISON_CELL2:
                    case DATA_PRISON_CELL3:
                    case DATA_PRISON_CELL4:
                        HandleGameObject(_prisonGUIDs[id-DATA_PRISON_CELL1], true);
                        ActivatePrisoners(_prisonersCell[id-DATA_PRISON_CELL1]);
                        break;
                    case DATA_DOOR5:
                        HandleGameObject(_doorGUIDs[4], true);
                        if (Creature* broggok = instance->GetCreature(GetData64(DATA_BROGGOK)))
                            broggok->AI()->DoAction(ACTION_ACTIVATE_BROGGOK);
                        break;
                }
            }

            void ActivatePrisoners(std::set<uint64> prisoners)
            {
                for (std::set<uint64>::iterator i = prisoners.begin(); i != prisoners.end(); ++i)
                    if (Creature* prisoner = instance->GetCreature(*i))
                    {
                        prisoner->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_PC | UNIT_FLAG_IMMUNE_TO_NPC | UNIT_FLAG_NON_ATTACKABLE);
                        prisoner->SetInCombatWithZone();
                    }
            }
        };

        InstanceScript* GetInstanceScript(InstanceMap* map) const
        {
            return new instance_blood_furnace_InstanceMapScript(map);
        }
};

void AddSC_instance_blood_furnace()
{
    new instance_blood_furnace();
}


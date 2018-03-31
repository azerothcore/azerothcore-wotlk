/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

/* ScriptData
SDName: Instance_ZulGurub
SD%Complete: 80
SDComment: Missing reset function after killing a boss for Ohgan, Thekal.
SDCategory: Zul'Gurub
EndScriptData */

#include "ScriptMgr.h"
#include "InstanceScript.h"
#include "zulgurub.h"

DoorData const doorData[] =
{
    { GO_FORCEFIELD, DATA_ARLOKK, DOOR_TYPE_ROOM, BOUNDARY_NONE },
    { 0,             0,           DOOR_TYPE_ROOM, BOUNDARY_NONE } // END
};

class instance_zulgurub : public InstanceMapScript
{
    public: instance_zulgurub(): InstanceMapScript(ZGScriptName, 309) { }

        struct instance_zulgurub_InstanceMapScript : public InstanceScript
        {
            instance_zulgurub_InstanceMapScript(Map* map) : InstanceScript(map)
            {
                SetBossNumber(EncounterCount);
                LoadDoorData(doorData);
            }

            void Initialize()
            {
                _zealotLorkhanGUID = 0;
                _zealotZathGUID = 0;
                _highPriestTekalGUID = 0;
                _jindoTheHexxerGUID = 0;
                _vilebranchSpeakerGUID = 0;
                _arlokkGUID = 0;
                _goGongOfBethekkGUID = 0;
            }

            bool IsEncounterInProgress() const
            {
                // not active in Zul'Gurub
                return false;
            }

            void OnCreatureCreate(Creature* creature)
            {
                switch (creature->GetEntry())
                {
                    case NPC_ZEALOT_LORKHAN:
                        _zealotLorkhanGUID = creature->GetGUID();
                        break;
                    case NPC_ZEALOT_ZATH:
                        _zealotZathGUID = creature->GetGUID();
                        break;
                    case NPC_HIGH_PRIEST_THEKAL:
                        _highPriestTekalGUID = creature->GetGUID();
                        break;
                    case NPC_JINDO_THE_HEXXER:
                        _jindoTheHexxerGUID = creature->GetGUID();
                        break;
                    case NPC_VILEBRANCH_SPEAKER:
                        _vilebranchSpeakerGUID = creature->GetGUID();
                        break;
                    case NPC_ARLOKK:
                        _arlokkGUID = creature->GetGUID();
                        break;
                }
            }

            void OnGameObjectCreate(GameObject* go)
            {
                switch (go->GetEntry())
                {
                    case GO_FORCEFIELD:
                        AddDoor(go, true);
                        break;
                    case GO_GONG_OF_BETHEKK:
                        _goGongOfBethekkGUID = go->GetGUID();
                        if (GetBossState(DATA_ARLOKK) == DONE)
                            go->SetFlag(GAMEOBJECT_FLAGS, GO_FLAG_NOT_SELECTABLE);
                        else
                            go->RemoveFlag(GAMEOBJECT_FLAGS, GO_FLAG_NOT_SELECTABLE);
                        break;
                    default:
                        break;
                }
            }

            void OnGameObjectRemove(GameObject* go)
            {
                switch (go->GetEntry())
                {
                    case GO_FORCEFIELD:
                        AddDoor(go, false);
                        break;
                    default:
                        break;
                }
            }

            uint64 GetData64(uint32 uiData) const
            {
                switch (uiData)
                {
                    case DATA_LORKHAN:
                        return _zealotLorkhanGUID;
                        break;
                    case DATA_ZATH:
                        return _zealotZathGUID;
                        break;
                    case DATA_THEKAL:
                        return _highPriestTekalGUID;
                        break;
                    case DATA_JINDO:
                        return _jindoTheHexxerGUID;
                        break;
                    case NPC_ARLOKK:
                        return _arlokkGUID;
                        break;
                    case GO_GONG_OF_BETHEKK:
                        return _goGongOfBethekkGUID;
                        break;
                }
                return 0;
            }

            std::string GetSaveData()
            {
                OUT_SAVE_INST_DATA;

                std::ostringstream saveStream;
                saveStream << "Z G " << GetBossSaveData();

                OUT_SAVE_INST_DATA_COMPLETE;
                return saveStream.str();
            }

            void Load(const char* str)
            {
                if (!str)
                {
                    OUT_LOAD_INST_DATA_FAIL;
                    return;
                }

                OUT_LOAD_INST_DATA(str);

                char dataHead1, dataHead2;

                std::istringstream loadStream(str);
                loadStream >> dataHead1 >> dataHead2;

                if (dataHead1 == 'Z' && dataHead2 == 'G')
                {
                    for (uint32 i = 0; i < EncounterCount; ++i)
                    {
                        uint32 tmpState;
                        loadStream >> tmpState;
                        if (tmpState == IN_PROGRESS || tmpState > SPECIAL)
                            tmpState = NOT_STARTED;
                        SetBossState(i, EncounterState(tmpState));
                    }
                }
                else
                    OUT_LOAD_INST_DATA_FAIL;

                OUT_LOAD_INST_DATA_COMPLETE;
            }
        private:
            //If all High Priest bosses were killed. Lorkhan, Zath and Ohgan are added too.
            //Storing Lorkhan, Zath and Thekal because we need to cast on them later. Jindo is needed for healfunction too.

            uint64 _zealotLorkhanGUID;
            uint64 _zealotZathGUID;
            uint64 _highPriestTekalGUID;
            uint64 _jindoTheHexxerGUID;
            uint64 _vilebranchSpeakerGUID;
            uint64 _arlokkGUID;
            uint64 _goGongOfBethekkGUID;
        };

        InstanceScript* GetInstanceScript(InstanceMap* map) const
        {
            return new instance_zulgurub_InstanceMapScript(map);
        }
};

void AddSC_instance_zulgurub()
{
    new instance_zulgurub();
}

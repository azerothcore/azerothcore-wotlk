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

/* ScriptData
SDName: Instance_ZulGurub
SD%Complete: 80
SDComment: Missing reset function after killing a boss for Ohgan, Thekal.
SDCategory: Zul'Gurub
EndScriptData */

#include "InstanceScript.h"
#include "ScriptMgr.h"
#include "zulgurub.h"

DoorData const doorData[] =
{
    { GO_FORCEFIELD, DATA_ARLOKK, DOOR_TYPE_ROOM },
    { 0,             0,           DOOR_TYPE_ROOM }
};

MinionData const minionData[] =
{
    { NPC_ZEALOT_LORKHAN, DATA_THEKAL },
    { NPC_ZEALOT_ZATH,    DATA_THEKAL }
};

class instance_zulgurub : public InstanceMapScript
{
public:
    instance_zulgurub(): InstanceMapScript(ZGScriptName, 309) { }

    struct instance_zulgurub_InstanceMapScript : public InstanceScript
    {
        instance_zulgurub_InstanceMapScript(Map* map) : InstanceScript(map)
        {
            SetBossNumber(EncounterCount);
            LoadDoorData(doorData);
            LoadMinionData(minionData);
        }

        void OnCreatureCreate(Creature* creature) override
        {
            InstanceScript::OnCreatureCreate(creature);

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
                case NPC_HAKKAR:
                    _hakkarGUID = creature->GetGUID();
                    break;
            }
        }

        void OnGameObjectCreate(GameObject* go) override
        {
            InstanceScript::OnGameObjectCreate(go);

            switch (go->GetEntry())
            {
                case GO_GONG_OF_BETHEKK:
                    _goGongOfBethekkGUID = go->GetGUID();
                    if (GetBossState(DATA_ARLOKK) == DONE)
                        go->SetGameObjectFlag(GO_FLAG_NOT_SELECTABLE);
                    else
                        go->RemoveGameObjectFlag(GO_FLAG_NOT_SELECTABLE);
                    break;
                default:
                    break;
            }
        }

        ObjectGuid GetGuidData(uint32 uiData) const override
        {
            switch (uiData)
            {
                case DATA_LORKHAN:
                    return _zealotLorkhanGUID;
                case DATA_ZATH:
                    return _zealotZathGUID;
                case DATA_THEKAL:
                    return _highPriestTekalGUID;
                case DATA_JINDO:
                    return _jindoTheHexxerGUID;
                case NPC_ARLOKK:
                    return _arlokkGUID;
                case GO_GONG_OF_BETHEKK:
                    return _goGongOfBethekkGUID;
                case DATA_HAKKAR:
                    return _hakkarGUID;
            }

            return ObjectGuid::Empty;
        }

        std::string GetSaveData() override
        {
            OUT_SAVE_INST_DATA;

            std::ostringstream saveStream;
            saveStream << "Z G " << GetBossSaveData();

            OUT_SAVE_INST_DATA_COMPLETE;
            return saveStream.str();
        }

        void Load(const char* str) override
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

        ObjectGuid _zealotLorkhanGUID;
        ObjectGuid _zealotZathGUID;
        ObjectGuid _highPriestTekalGUID;
        ObjectGuid _jindoTheHexxerGUID;
        ObjectGuid _vilebranchSpeakerGUID;
        ObjectGuid _arlokkGUID;
        ObjectGuid _goGongOfBethekkGUID;
        ObjectGuid _hakkarGUID;
    };

    InstanceScript* GetInstanceScript(InstanceMap* map) const override
    {
        return new instance_zulgurub_InstanceMapScript(map);
    }
};

void AddSC_instance_zulgurub()
{
    new instance_zulgurub();
}

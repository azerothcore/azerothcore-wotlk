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
#include "ScriptedCreature.h"
#include "halls_of_lightning.h"

class instance_halls_of_lightning : public InstanceMapScript
{
public:
    instance_halls_of_lightning() : InstanceMapScript("instance_halls_of_lightning", 602) { }

    InstanceScript* GetInstanceScript(InstanceMap* pMap) const override
    {
        return new instance_halls_of_lightning_InstanceMapScript(pMap);
    }

    struct instance_halls_of_lightning_InstanceMapScript : public InstanceScript
    {
        instance_halls_of_lightning_InstanceMapScript(Map* pMap) : InstanceScript(pMap) { Initialize(); };

        uint32 m_auiEncounter[MAX_ENCOUNTER];

        ObjectGuid m_uiGeneralBjarngrimGUID;
        ObjectGuid m_uiIonarGUID;
        ObjectGuid m_uiLokenGUID;
        ObjectGuid m_uiVolkhanGUID;

        ObjectGuid m_uiBjarngrimDoorGUID;
        ObjectGuid m_uiVolkhanDoorGUID;
        ObjectGuid m_uiIonarDoorGUID;
        ObjectGuid m_uiLokenDoorGUID;
        ObjectGuid m_uiLokenGlobeGUID;

        bool volkhanAchievement;
        bool bjarngrimAchievement;

        void Initialize() override
        {
            SetHeaders(DataHeader);
            memset(&m_auiEncounter, 0, sizeof(m_auiEncounter));

            volkhanAchievement = false;
            bjarngrimAchievement = false;
        }

        bool IsEncounterInProgress() const override
        {
            for (uint8 i = 0; i < MAX_ENCOUNTER; ++i)
            {
                if (m_auiEncounter[i] == IN_PROGRESS && i != TYPE_LOKEN_INTRO)
                {
                    return true;
                }
            }
            return false;
        }

        void OnCreatureCreate(Creature* pCreature) override
        {
            switch (pCreature->GetEntry())
            {
                case NPC_BJARNGRIM:
                    m_uiGeneralBjarngrimGUID = pCreature->GetGUID();
                    break;
                case NPC_VOLKHAN:
                    m_uiVolkhanGUID = pCreature->GetGUID();
                    break;
                case NPC_IONAR:
                    m_uiIonarGUID = pCreature->GetGUID();
                    break;
                case NPC_LOKEN:
                    m_uiLokenGUID = pCreature->GetGUID();
                    break;
            }
        }

        void OnGameObjectCreate(GameObject* pGo) override
        {
            switch (pGo->GetEntry())
            {
                case GO_BJARNGRIM_DOOR:
                    m_uiBjarngrimDoorGUID = pGo->GetGUID();
                    if (m_auiEncounter[TYPE_BJARNGRIM] == DONE)
                        pGo->SetGoState(GO_STATE_ACTIVE);

                    break;
                case GO_VOLKHAN_DOOR:
                    m_uiVolkhanDoorGUID = pGo->GetGUID();
                    if (m_auiEncounter[TYPE_VOLKHAN] == DONE)
                        pGo->SetGoState(GO_STATE_ACTIVE);

                    break;
                case GO_IONAR_DOOR:
                    m_uiIonarDoorGUID = pGo->GetGUID();
                    if (m_auiEncounter[TYPE_IONAR] == DONE)
                        pGo->SetGoState(GO_STATE_ACTIVE);

                    break;
                case GO_LOKEN_DOOR:
                    m_uiLokenDoorGUID = pGo->GetGUID();
                    if (m_auiEncounter[TYPE_LOKEN] == DONE)
                        pGo->SetGoState(GO_STATE_ACTIVE);

                    break;
                case GO_LOKEN_THRONE:
                    m_uiLokenGlobeGUID = pGo->GetGUID();
                    break;
            }
        }

        bool CheckAchievementCriteriaMeet(uint32 criteria_id, Player const*  /*source*/, Unit const*  /*target*/, uint32  /*miscvalue1*/) override
        {
            switch (criteria_id)
            {
                case 7321: //Shatter Resistant (2042)
                    return volkhanAchievement;
                case 6835: // Lightning Struck (1834)
                    return bjarngrimAchievement;
            }
            return false;
        }

        void SetData(uint32 uiType, uint32 uiData) override
        {
            m_auiEncounter[uiType] = uiData;
            if (uiType == TYPE_LOKEN_INTRO)
                SaveToDB();

            // Achievements
            if (uiType == DATA_BJARNGRIM_ACHIEVEMENT)
                bjarngrimAchievement = (bool)uiData;
            else if (uiType == DATA_VOLKHAN_ACHIEVEMENT)
                volkhanAchievement = (bool)uiData;

            if (uiData != DONE)
                return;

            switch (uiType)
            {
                case TYPE_BJARNGRIM:
                    HandleGameObject(m_uiBjarngrimDoorGUID, true);
                    break;
                case TYPE_VOLKHAN:
                    HandleGameObject(m_uiVolkhanDoorGUID, true);
                    break;
                case TYPE_IONAR:
                    HandleGameObject(m_uiIonarDoorGUID, true);
                    break;
                case TYPE_LOKEN:
                    HandleGameObject(m_uiLokenDoorGUID, true);
                    //Appears to be type 5 GO with animation. Need to figure out how this work, code below only placeholder
                    if (GameObject* pGlobe = instance->GetGameObject(m_uiLokenGlobeGUID))
                        pGlobe->SetGoState(GO_STATE_ACTIVE);

                    break;
            }

            SaveToDB();
        }

        void ReadSaveDataMore(std::istringstream& data) override
        {
            data >> m_auiEncounter[0];
            data >> m_auiEncounter[1];
            data >> m_auiEncounter[2];
            data >> m_auiEncounter[3];
        }

        void WriteSaveDataMore(std::ostringstream& data) override
        {
            data << m_auiEncounter[0] << ' '
                << m_auiEncounter[1] << ' '
                << m_auiEncounter[2] << ' '
                << m_auiEncounter[3] << ' ';
        }

        uint32 GetData(uint32 uiType) const override
        {
            return m_auiEncounter[uiType];
        }

        ObjectGuid GetGuidData(uint32 uiData) const override
        {
            switch (uiData)
            {
                case TYPE_BJARNGRIM:
                    return m_uiGeneralBjarngrimGUID;
                case TYPE_VOLKHAN:
                    return m_uiVolkhanGUID;
                case TYPE_IONAR:
                    return m_uiIonarGUID;
                case TYPE_LOKEN:
                    return m_uiLokenGUID;
            }

            return ObjectGuid::Empty;
        }
    };
};

void AddSC_instance_halls_of_lightning()
{
    new instance_halls_of_lightning();
}

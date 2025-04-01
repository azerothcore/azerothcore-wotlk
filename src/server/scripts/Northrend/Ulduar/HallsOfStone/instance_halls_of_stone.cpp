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
#include "halls_of_stone.h"

class instance_halls_of_stone : public InstanceMapScript
{
public:
    instance_halls_of_stone() : InstanceMapScript("instance_halls_of_stone", 599) { }

    InstanceScript* GetInstanceScript(InstanceMap* pMap) const override
    {
        return new instance_halls_of_stone_InstanceMapScript(pMap);
    }

    struct instance_halls_of_stone_InstanceMapScript : public InstanceScript
    {
        instance_halls_of_stone_InstanceMapScript(Map* map) : InstanceScript(map) { Initialize(); }

        uint32 Encounter[MAX_ENCOUNTER];

        ObjectGuid goKaddrakGUID;
        ObjectGuid goMarnakGUID;
        ObjectGuid goAbedneumGUID;
        ObjectGuid goTribunalConsoleGUID;
        ObjectGuid goSkyRoomFloorGUID;
        ObjectGuid goSjonnirConsoleGUID;
        ObjectGuid goSjonnirDoorGUID;
        ObjectGuid goLeftPipeGUID;
        ObjectGuid goRightPipeGUID;
        ObjectGuid goTribunalDoorGUID;

        ObjectGuid SjonnirGUID;
        ObjectGuid BrannGUID;

        bool brannAchievement;
        bool sjonnirAchievement;
        bool isMaidenOfGriefDead;
        bool isKrystalusDead;

        void Initialize() override
        {
            SetHeaders(DataHeader);
            memset(&Encounter, 0, sizeof(Encounter));

            brannAchievement = false;
            sjonnirAchievement = false;
            isMaidenOfGriefDead = false;
            isKrystalusDead = false;
        }

        bool IsEncounterInProgress() const override
        {
            for (uint8 i = 0; i < MAX_ENCOUNTER; ++i)
            {
                if (Encounter[i] == IN_PROGRESS && i != BRANN_BRONZEBEARD)
                {
                    return true;
                }
            }
            return false;
        }

        void OnGameObjectCreate(GameObject* go) override
        {
            switch (go->GetEntry())
            {
                case GO_KADDRAK:
                    goKaddrakGUID = go->GetGUID();
                    break;
                case GO_ABEDNEUM:
                    goAbedneumGUID = go->GetGUID();
                    if (Encounter[BOSS_TRIBUNAL_OF_AGES] == DONE)
                        go->SetGoState(GO_STATE_ACTIVE);
                    break;
                case GO_MARNAK:
                    goMarnakGUID = go->GetGUID();
                    break;
                case GO_TRIBUNAL_CONSOLE:
                    goTribunalConsoleGUID = go->GetGUID();
                    break;
                case GO_TRIBUNAL_ACCESS_DOOR:
                    goTribunalDoorGUID = go->GetGUID();
                    go->SetGoState(GO_STATE_READY);
                    break;
                case GO_SKY_FLOOR:
                    goSkyRoomFloorGUID = go->GetGUID();
                    if (Encounter[BOSS_TRIBUNAL_OF_AGES] == DONE)
                        go->SetGoState(GO_STATE_ACTIVE);
                    break;
                case GO_SJONNIR_CONSOLE:
                    goSjonnirConsoleGUID = go->GetGUID();
                    break;
                case GO_SJONNIR_DOOR:
                    goSjonnirDoorGUID = go->GetGUID();
                    if (Encounter[BOSS_TRIBUNAL_OF_AGES] == DONE)
                        go->SetGoState(GO_STATE_ACTIVE);
                    break;
                case GO_LEFT_PIPE:
                    goLeftPipeGUID = go->GetGUID();
                    break;
                case GO_RIGHT_PIPE:
                    goRightPipeGUID = go->GetGUID();
                    break;
            }
        }

        void OnCreatureCreate(Creature* creature) override
        {
            switch (creature->GetEntry())
            {
                case NPC_SJONNIR:
                    SjonnirGUID = creature->GetGUID();
                    break;
                case NPC_BRANN:
                    BrannGUID = creature->GetGUID();
                    break;
            }
        }

        ObjectGuid GetGuidData(uint32 id) const override
        {
            switch (id)
            {
                case GO_TRIBUNAL_CONSOLE:
                    return goTribunalConsoleGUID;
                case GO_TRIBUNAL_ACCESS_DOOR:
                    return goTribunalDoorGUID;
                case GO_SJONNIR_CONSOLE:
                    return goSjonnirConsoleGUID;
                case GO_SJONNIR_DOOR:
                    return goSjonnirDoorGUID;
                case GO_LEFT_PIPE:
                    return goLeftPipeGUID;
                case GO_RIGHT_PIPE:
                    return goRightPipeGUID;
                case GO_KADDRAK:
                    return goKaddrakGUID;
                case GO_MARNAK:
                    return goMarnakGUID;
                case GO_ABEDNEUM:
                    return goAbedneumGUID;
                case GO_SKY_FLOOR:
                    return goSkyRoomFloorGUID;

                case NPC_SJONNIR:
                    return SjonnirGUID;
                case NPC_BRANN:
                    return BrannGUID;
            }

            return ObjectGuid::Empty;
        }

        uint32 GetData(uint32 id) const override
        {
            switch (id)
            {
                case BOSS_KRYSTALLUS:
                case BOSS_MAIDEN_OF_GRIEF:
                case BOSS_TRIBUNAL_OF_AGES:
                case BOSS_SJONNIR:
                case BRANN_BRONZEBEARD:
                    return Encounter[id];
            }

            return 0;
        }

        bool CheckAchievementCriteriaMeet(uint32 criteria_id, Player const*  /*source*/, Unit const*  /*target*/, uint32  /*miscvalue1*/) override
        {
            switch (criteria_id)
            {
                case 7590: // Brann Spankin' New (2154)
                    return brannAchievement;
                case 7593: // Abuse the Ooze (2155)
                    return sjonnirAchievement;
            }

            return false;
        }

        void SetData(uint32 type, uint32 data) override
        {
            if (type < MAX_ENCOUNTER)
                Encounter[type] = data;

            if (data == DONE)
            {
                isMaidenOfGriefDead = type == BOSS_MAIDEN_OF_GRIEF || isMaidenOfGriefDead;
                isKrystalusDead = type == BOSS_KRYSTALLUS || isKrystalusDead;
            }

            if (isMaidenOfGriefDead && isKrystalusDead)
                if (GameObject* tribunalDoor = instance->GetGameObject(goTribunalDoorGUID))
                    tribunalDoor->SetGoState(GO_STATE_ACTIVE);

            if (type == BOSS_TRIBUNAL_OF_AGES && data == SPECIAL)
            {
                if (GameObject* pSkyRoomFloor = instance->GetGameObject(goSkyRoomFloorGUID))
                    pSkyRoomFloor->SetGoState(GO_STATE_READY);
            }

            if (type == BOSS_TRIBUNAL_OF_AGES && data == DONE)
            {
                GameObject* pAbedneum = instance->GetGameObject(goAbedneumGUID);
                GameObject* pKaddrak = instance->GetGameObject(goKaddrakGUID);
                GameObject* pMarnak = instance->GetGameObject(goMarnakGUID);

                GameObject* pSkyRoomFloor = instance->GetGameObject(goSkyRoomFloorGUID);
                bool skyRoomDown = false;

                if (pAbedneum && pKaddrak && pMarnak && pSkyRoomFloor)
                {
                    if (pAbedneum->GetGoState() != GO_STATE_ACTIVE)
                    {
                        if (pKaddrak->GetGoState() != GO_STATE_ACTIVE && pMarnak->GetGoState() != GO_STATE_ACTIVE)
                        {
                            //Abedneum first talk
                            pAbedneum->SetGoState(GO_STATE_ACTIVE);
                        }
                        else if (pMarnak->GetGoState() == GO_STATE_ACTIVE)
                        {
                            //Abedneum second talk
                            pAbedneum->SetGoState(GO_STATE_ACTIVE);
                            pMarnak->SetGoState(GO_STATE_READY);
                            pSkyRoomFloor->SetGoState(GO_STATE_READY);
                            skyRoomDown = true;
                        }
                        else
                        {
                            //Marnak talk
                            if (pKaddrak->GetGoState() == GO_STATE_ACTIVE)
                            {
                                pMarnak->SetGoState(GO_STATE_ACTIVE);
                                pKaddrak->SetGoState(GO_STATE_READY);
                                pSkyRoomFloor->SetGoState(GO_STATE_READY);
                            }
                        }
                    }
                    else
                    {
                        //Kaddrak talk
                        if (pKaddrak->GetGoState() != GO_STATE_ACTIVE)
                        {
                            pAbedneum->SetGoState(GO_STATE_READY);
                            pKaddrak->SetGoState(GO_STATE_ACTIVE);
                            pSkyRoomFloor->SetGoState(GO_STATE_READY);
                        }
                    }

                    if (!skyRoomDown)
                        pSkyRoomFloor->SetGoState(GO_STATE_ACTIVE);
                }

                // Make sjonnir attackable
                if (Creature* cSjonnir = instance->GetCreature(SjonnirGUID))
                    cSjonnir->RemoveUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
            }

            if (type == BOSS_TRIBUNAL_OF_AGES && data == NOT_STARTED)
            {
                if (GameObject* pAbedneum = instance->GetGameObject(goAbedneumGUID))
                    pAbedneum->SetGoState(GO_STATE_READY);
                if (GameObject* pKaddrak = instance->GetGameObject(goKaddrakGUID))
                    pKaddrak->SetGoState(GO_STATE_READY);
                if (GameObject* pMarnak = instance->GetGameObject(goMarnakGUID))
                    pMarnak->SetGoState(GO_STATE_READY);
                if (GameObject* pSkyRoomFloor = instance->GetGameObject(goSkyRoomFloorGUID))
                    pSkyRoomFloor->SetGoState(GO_STATE_READY);
            }

            if (type == BOSS_TRIBUNAL_OF_AGES && data == FAIL)
            {
                if (GameObject* pAbedneum = instance->GetGameObject(goAbedneumGUID))
                    pAbedneum->SetGoState(GO_STATE_ACTIVE);
                if (GameObject* pKaddrak = instance->GetGameObject(goKaddrakGUID))
                    pKaddrak->SetGoState(GO_STATE_ACTIVE);
                if (GameObject* pMarnak = instance->GetGameObject(goMarnakGUID))
                    pMarnak->SetGoState(GO_STATE_ACTIVE);
                if (GameObject* pSkyRoomFloor = instance->GetGameObject(goSkyRoomFloorGUID))
                    pSkyRoomFloor->SetGoState(GO_STATE_READY);
            }

            if (type == DATA_BRANN_ACHIEVEMENT)
            {
                brannAchievement = (bool)data;
                return;
            }
            if (type == DATA_SJONNIR_ACHIEVEMENT)
            {
                sjonnirAchievement = (bool)data;
                return;
            }

            if (data == DONE)
                SaveToDB();
        }

        void ReadSaveDataMore(std::istringstream& data) override
        {
            data >> Encounter[0];
            data >> Encounter[1];
            data >> Encounter[2];
            data >> Encounter[3];
            data >> Encounter[4];
        }

        void WriteSaveDataMore(std::ostringstream& data) override
        {
            data << Encounter[0] << ' '
                << Encounter[1] << ' '
                << Encounter[2] << ' '
                << Encounter[3] << ' '
                << Encounter[4] << ' ';
        }
    };
};

void AddSC_instance_halls_of_stone()
{
    new instance_halls_of_stone();
}

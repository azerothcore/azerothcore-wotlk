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

#include "InstanceMapScript.h"
#include "ScriptedCreature.h"
#include "gundrak.h"

DoorData const doorData[] =
{
    { GO_ECK_DOORS,             DATA_MOORABI,           DOOR_TYPE_PASSAGE },
    { GO_ECK_UNDERWATER_GATE,   DATA_ECK_THE_FEROCIOUS, DOOR_TYPE_PASSAGE },
    { GO_GAL_DARAH_DOORS0,      DATA_GAL_DARAH,         DOOR_TYPE_ROOM    },
    { GO_GAL_DARAH_DOORS1,      DATA_GAL_DARAH,         DOOR_TYPE_PASSAGE },
    { GO_GAL_DARAH_DOORS2,      DATA_GAL_DARAH,         DOOR_TYPE_PASSAGE },
    { 0,                        0,                      DOOR_TYPE_ROOM    }
};

class instance_gundrak : public InstanceMapScript
{
public:
    instance_gundrak() : InstanceMapScript("instance_gundrak", 604) { }

    InstanceScript* GetInstanceScript(InstanceMap* pMap) const override
    {
        return new instance_gundrak_InstanceMapScript(pMap);
    }

    struct instance_gundrak_InstanceMapScript : public InstanceScript
    {
        instance_gundrak_InstanceMapScript(Map* map) : InstanceScript(map)
        {
            SetHeaders(DataHeader);
        }

        ObjectGuid _sladRanAltarGUID;
        ObjectGuid _moorabiAltarGUID;
        ObjectGuid _drakkariAltarGUID;
        ObjectGuid _bridgeGUIDs[6];
        uint32 _keysInCount;
        uint32 _activateTimer;

        void Initialize() override
        {
            SetBossNumber(MAX_ENCOUNTERS);
            LoadDoorData(doorData);

            _keysInCount = 0;
            _activateTimer = 0;
        }

        void OnGameObjectCreate(GameObject* gameobject) override
        {
            switch (gameobject->GetEntry())
            {
                case GO_ALTAR_OF_SLAD_RAN:
                    _sladRanAltarGUID = gameobject->GetGUID();
                    gameobject->SetGoState(GetBossState(DATA_SLAD_RAN) == DONE ? GO_STATE_ACTIVE : GO_STATE_READY);
                    break;
                case GO_ALTAR_OF_DRAKKARI:
                    _drakkariAltarGUID = gameobject->GetGUID();
                    gameobject->SetGoState(GetBossState(DATA_DRAKKARI_COLOSSUS) == DONE ? GO_STATE_ACTIVE : GO_STATE_READY);
                    break;
                case GO_ALTAR_OF_MOORABI:
                    _moorabiAltarGUID = gameobject->GetGUID();
                    gameobject->SetGoState(GetBossState(DATA_MOORABI) == DONE ? GO_STATE_ACTIVE : GO_STATE_READY);
                    break;
                case GO_STATUE_OF_SLAD_RAN:
                    _bridgeGUIDs[0] = gameobject->GetGUID();
                    gameobject->SetGoState(_keysInCount == 3 ? GO_STATE_ACTIVE_ALTERNATIVE : (GetBossState(DATA_SLAD_RAN) == DONE ? GO_STATE_READY : GO_STATE_ACTIVE));
                    break;
                case GO_STATUE_OF_DRAKKARI:
                    _bridgeGUIDs[1] = gameobject->GetGUID();
                    gameobject->SetGoState(_keysInCount == 3 ? GO_STATE_ACTIVE_ALTERNATIVE : (GetBossState(DATA_DRAKKARI_COLOSSUS) == DONE ? GO_STATE_READY : GO_STATE_ACTIVE));
                    break;
                case GO_STATUE_OF_MOORABI:
                    _bridgeGUIDs[2] = gameobject->GetGUID();
                    gameobject->SetGoState(_keysInCount == 3 ? GO_STATE_ACTIVE_ALTERNATIVE : (GetBossState(DATA_MOORABI) == DONE ? GO_STATE_READY : GO_STATE_ACTIVE));
                    break;
                case GO_STATUE_OF_GAL_DARAH:
                    _bridgeGUIDs[3] = gameobject->GetGUID();
                    gameobject->SetGoState(_keysInCount == 3 ? GO_STATE_ACTIVE_ALTERNATIVE : GO_STATE_READY);
                    break;
                case GO_GUNDRAK_COLLISION:
                    _bridgeGUIDs[4] = gameobject->GetGUID();
                    gameobject->SetGoState(_keysInCount == 3 ? GO_STATE_ACTIVE_ALTERNATIVE : GO_STATE_READY);
                    break;
                case GO_GUNDRAK_BRIDGE:
                    _bridgeGUIDs[5] = gameobject->GetGUID();
                    gameobject->SetGoState(GO_STATE_READY);
                    break;
                case GO_ECK_DOORS:
                case GO_ECK_UNDERWATER_GATE:
                case GO_GAL_DARAH_DOORS0:
                case GO_GAL_DARAH_DOORS1:
                case GO_GAL_DARAH_DOORS2:
                    AddDoor(gameobject);
                    break;
            }
        }

        void OnGameObjectRemove(GameObject* gameobject) override
        {
            switch (gameobject->GetEntry())
            {
                case GO_ECK_DOORS:
                case GO_ECK_UNDERWATER_GATE:
                case GO_GAL_DARAH_DOORS0:
                case GO_GAL_DARAH_DOORS1:
                case GO_GAL_DARAH_DOORS2:
                    RemoveDoor(gameobject);
                    break;
            }
        }

        void SetData(uint32 type, uint32) override
        {
            switch (type)
            {
                case NPC_ECK_THE_FEROCIOUS:
                    if (GetBossState(DATA_ECK_THE_FEROCIOUS_INIT) != DONE)
                    {
                        SetBossState(DATA_ECK_THE_FEROCIOUS_INIT, NOT_STARTED);
                        SetBossState(DATA_ECK_THE_FEROCIOUS_INIT, DONE);
                    }
                    break;
                case GO_ALTAR_OF_SLAD_RAN:
                    if (GameObject* statue = instance->GetGameObject(_bridgeGUIDs[0]))
                        statue->SetGoState(GO_STATE_READY);
                    break;
                case GO_ALTAR_OF_DRAKKARI:
                    if (GameObject* statue = instance->GetGameObject(_bridgeGUIDs[1]))
                        statue->SetGoState(GO_STATE_READY);
                    break;
                case GO_ALTAR_OF_MOORABI:
                    if (GameObject* statue = instance->GetGameObject(_bridgeGUIDs[2]))
                        statue->SetGoState(GO_STATE_READY);
                    break;
            }

            if (type >= GO_ALTAR_OF_SLAD_RAN)
            {
                for (uint8 i = 0; i < 3; ++i)
                    if (GameObject* statue = instance->GetGameObject(_bridgeGUIDs[i]))
                        if (statue->GetGoState() != GO_STATE_READY)
                            return;
                _activateTimer = 1;
            }
        }

        bool SetBossState(uint32 type, EncounterState state) override
        {
            if (!InstanceScript::SetBossState(type, state))
            {
                if (state == DONE && (type == DATA_SLAD_RAN || type == DATA_MOORABI || type == DATA_DRAKKARI_COLOSSUS))
                    ++_keysInCount;
                return false;
            }

            if (state != DONE)
                return true;

            switch (type)
            {
                case DATA_SLAD_RAN:
                    if (GameObject* altar = instance->GetGameObject(_sladRanAltarGUID))
                        altar->RemoveGameObjectFlag(GO_FLAG_NOT_SELECTABLE);
                    break;
                case DATA_MOORABI:
                    if (GameObject* altar = instance->GetGameObject(_moorabiAltarGUID))
                        altar->RemoveGameObjectFlag(GO_FLAG_NOT_SELECTABLE);
                    break;
                case DATA_DRAKKARI_COLOSSUS:
                    if (GameObject* altar = instance->GetGameObject(_drakkariAltarGUID))
                        altar->RemoveGameObjectFlag(GO_FLAG_NOT_SELECTABLE);
                    break;
                case DATA_ECK_THE_FEROCIOUS_INIT:
                    {
                        Position pos = {1624.70f, 891.43f, 95.08f, 1.2f};
                        if (instance->IsHeroic())
                            instance->SummonCreature(NPC_ECK_THE_FEROCIOUS, pos);
                        break;
                    }
            }
            return true;
        }

        void Update(uint32 diff) override
        {
            if (!_activateTimer)
                return;

            _activateTimer += diff;
            if (_activateTimer >= 5000)
            {
                _activateTimer = 0;
                for (uint8 i = 0; i < 5; ++i)
                    if (GameObject* go = instance->GetGameObject(_bridgeGUIDs[i]))
                        go->SetGoState(GO_STATE_ACTIVE_ALTERNATIVE);
            }
        }
    };
};

void AddSC_instance_gundrak()
{
    new instance_gundrak();
}


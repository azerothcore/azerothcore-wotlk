/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "gundrak.h"

DoorData const doorData[] =
{
    { GO_ECK_DOORS,             DATA_MOORABI,           DOOR_TYPE_PASSAGE,  BOUNDARY_NONE },
    { GO_ECK_UNDERWATER_GATE,   DATA_ECK_THE_FEROCIOUS, DOOR_TYPE_PASSAGE,  BOUNDARY_NONE },
    { GO_GAL_DARAH_DOORS0,      DATA_GAL_DARAH,         DOOR_TYPE_ROOM,     BOUNDARY_NONE },
    { GO_GAL_DARAH_DOORS1,      DATA_GAL_DARAH,         DOOR_TYPE_PASSAGE,  BOUNDARY_NONE },
    { GO_GAL_DARAH_DOORS2,      DATA_GAL_DARAH,         DOOR_TYPE_PASSAGE,  BOUNDARY_NONE },
    { 0,                        0,                      DOOR_TYPE_ROOM,     BOUNDARY_NONE }
};

class instance_gundrak : public InstanceMapScript
{
    public:
        instance_gundrak() : InstanceMapScript("instance_gundrak", 604) { }

        InstanceScript* GetInstanceScript(InstanceMap* pMap) const
        {
            return new instance_gundrak_InstanceMapScript(pMap);
        }

        struct instance_gundrak_InstanceMapScript : public InstanceScript
        {
            instance_gundrak_InstanceMapScript(Map* map) : InstanceScript(map)
            {
            }

            uint64 _sladRanAltarGUID;
            uint64 _moorabiAltarGUID;
            uint64 _drakkariAltarGUID;
            uint64 _bridgeGUIDs[6];
            uint32 _keysInCount;
            uint32 _activateTimer;

            void Initialize()
            {
                SetBossNumber(MAX_ENCOUNTERS);
                LoadDoorData(doorData);

                _sladRanAltarGUID = 0;
                _moorabiAltarGUID = 0;
                _drakkariAltarGUID = 0;
                _keysInCount = 0;
                _activateTimer = 0;
                memset(&_bridgeGUIDs, 0, sizeof(_bridgeGUIDs));
            }

            void OnGameObjectCreate(GameObject* gameobject)
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
                        AddDoor(gameobject, true);
                        break;
                }
            }

            void OnGameObjectRemove(GameObject* gameobject)
            {
                switch (gameobject->GetEntry())
                {
                    case GO_ECK_DOORS:
                    case GO_ECK_UNDERWATER_GATE:
                    case GO_GAL_DARAH_DOORS0:
                    case GO_GAL_DARAH_DOORS1:
                    case GO_GAL_DARAH_DOORS2:
                        AddDoor(gameobject, false);
                        break;
                }
            }

            void SetData(uint32 type, uint32)
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

            bool SetBossState(uint32 type, EncounterState state)
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
                            altar->RemoveFlag(GAMEOBJECT_FLAGS, GO_FLAG_NOT_SELECTABLE);
                        break;
                    case DATA_MOORABI:
                        if (GameObject* altar = instance->GetGameObject(_moorabiAltarGUID))
                            altar->RemoveFlag(GAMEOBJECT_FLAGS, GO_FLAG_NOT_SELECTABLE);
                        break;
                    case DATA_DRAKKARI_COLOSSUS:
                        if (GameObject* altar = instance->GetGameObject(_drakkariAltarGUID))
                            altar->RemoveFlag(GAMEOBJECT_FLAGS, GO_FLAG_NOT_SELECTABLE);
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

            std::string GetSaveData()
            {
                std::ostringstream saveStream;
                saveStream << "G D " << GetBossSaveData();
                return saveStream.str();
            }

            void Load(const char* in)
            {
                if (!in)
                    return;

                char dataHead1, dataHead2;
                std::istringstream loadStream(in);
                loadStream >> dataHead1 >> dataHead2;
                if (dataHead1 == 'G' && dataHead2 == 'D')
                {
                    for (uint8 i = 0; i < MAX_ENCOUNTERS; ++i)
                    {
                        uint32 tmpState;
                        loadStream >> tmpState;
                        if (tmpState == IN_PROGRESS || tmpState > SPECIAL)
                            tmpState = NOT_STARTED;
                        SetBossState(i, EncounterState(tmpState));
                    }
                }
            }

            void Update(uint32 diff)
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

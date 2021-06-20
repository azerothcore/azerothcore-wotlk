/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "InstanceScript.h"
#include "hellfire_ramparts.h"

class instance_ramparts : public InstanceMapScript
{
    public:
        instance_ramparts() : InstanceMapScript("instance_ramparts", 543) { }

        struct instance_ramparts_InstanceMapScript : public InstanceScript
        {
            instance_ramparts_InstanceMapScript(Map* map) : InstanceScript(map) { }

            void Initialize()
            {
                SetBossNumber(MAX_ENCOUNTERS);
                felIronChestGUID = 0;
            }

            void OnGameObjectCreate(GameObject* go)
            {
                switch (go->GetEntry())
                {
                    case GO_FEL_IRON_CHEST_NORMAL:
                    case GO_FEL_IRON_CHECT_HEROIC:
                        felIronChestGUID = go->GetGUID();
                        break;
                }
            }

            bool SetBossState(uint32 type, EncounterState state)
            {
                if (!InstanceScript::SetBossState(type, state))
                    return false;

                if (type == DATA_VAZRUDEN && state == DONE)
                    if (GameObject* chest = instance->GetGameObject(felIronChestGUID))
                        chest->RemoveFlag(GAMEOBJECT_FLAGS, GO_FLAG_NOT_SELECTABLE);
                return true;
            }

            std::string GetSaveData()
            {
                std::ostringstream saveStream;
                saveStream << "H R " << GetBossSaveData();
                return saveStream.str();
            }

            void Load(const char* strIn)
            {
                if (!strIn)
                    return;

                char dataHead1, dataHead2;
                std::istringstream loadStream(strIn);
                loadStream >> dataHead1 >> dataHead2;

                if (dataHead1 == 'H' && dataHead2 == 'R')
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

            protected:
                uint64 felIronChestGUID;
        };

        InstanceScript* GetInstanceScript(InstanceMap* map) const
        {
            return new instance_ramparts_InstanceMapScript(map);
        }
};

void AddSC_instance_ramparts()
{
    new instance_ramparts();
}

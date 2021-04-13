/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "hellfire_ramparts.h"
#include "InstanceScript.h"
#include "ScriptMgr.h"

class instance_hellfire_ramparts : public InstanceMapScript
{
public:
    instance_hellfire_ramparts() : InstanceMapScript("instance_hellfire_ramparts", 543) { }

    struct instance_hellfire_ramparts_InstanceMapScript : public InstanceScript
    {
        instance_hellfire_ramparts_InstanceMapScript(Map* map) : InstanceScript(map) { }

        void Initialize() override
        {
            SetBossNumber(MAX_ENCOUNTERS);
            felIronChestGUID = 0;
        }

        void OnGameObjectCreate(GameObject* go) override
        {
            switch (go->GetEntry())
            {
                case GO_FEL_IRON_CHEST_NORMAL:
                case GO_FEL_IRON_CHECT_HEROIC:
                    felIronChestGUID = go->GetGUID();
                    break;
            }
        }

        bool SetBossState(uint32 type, EncounterState state) override
        {
            if (!InstanceScript::SetBossState(type, state))
                return false;

            if (type == DATA_VAZRUDEN && state == DONE)
                if (GameObject* chest = instance->GetGameObject(felIronChestGUID))
                    chest->RemoveFlag(GAMEOBJECT_FLAGS, GO_FLAG_NOT_SELECTABLE);
            return true;
        }

        std::string GetSaveData() override
        {
            std::ostringstream saveStream;
            saveStream << "H R " << GetBossSaveData();
            return saveStream.str();
        }

        void Load(const char* strIn) override
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

    InstanceScript* GetInstanceScript(InstanceMap* map) const override
    {
        return new instance_hellfire_ramparts_InstanceMapScript(map);
    }
};

void AddSC_instance_hellfire_ramparts()
{
    new instance_hellfire_ramparts();
}

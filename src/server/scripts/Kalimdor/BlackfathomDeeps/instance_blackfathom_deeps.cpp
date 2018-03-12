/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "InstanceScript.h"
#include "blackfathom_deeps.h"

class instance_blackfathom_deeps : public InstanceMapScript
{
    public:
        instance_blackfathom_deeps() : InstanceMapScript("instance_blackfathom_deeps", 48) { }

        InstanceScript* GetInstanceScript(InstanceMap* map) const
        {
            return new instance_blackfathom_deeps_InstanceMapScript(map);
        }

        struct instance_blackfathom_deeps_InstanceMapScript : public InstanceScript
        {
            instance_blackfathom_deeps_InstanceMapScript(Map* map) : InstanceScript(map) { }

            void Initialize()
            {
                memset(&_encounters, 0, sizeof(_encounters));
                _akumaiPortalGUID = 0;
                _requiredDeaths = 0;
            }

            void OnCreatureCreate(Creature* creature)
            {
                if (creature->IsSummon() && (creature->GetEntry() == NPC_BARBED_CRUSTACEAN || creature->GetEntry() == NPC_AKU_MAI_SERVANT || 
                    creature->GetEntry() == NPC_MURKSHALLOW_SOFTSHELL || creature->GetEntry() == NPC_AKU_MAI_SNAPJAW))
                    ++_requiredDeaths;
            }

            void OnUnitDeath(Unit* unit)
            {
                if (unit->IsSummon() && (unit->GetEntry() == NPC_BARBED_CRUSTACEAN || unit->GetEntry() == NPC_AKU_MAI_SERVANT || 
                    unit->GetEntry() == NPC_MURKSHALLOW_SOFTSHELL || unit->GetEntry() == NPC_AKU_MAI_SNAPJAW))
                {
                    if (--_requiredDeaths == 0)
                        if (_encounters[TYPE_FIRE1] == DONE && _encounters[TYPE_FIRE2] == DONE && _encounters[TYPE_FIRE3] == DONE && _encounters[TYPE_FIRE4] == DONE)
                            HandleGameObject(_akumaiPortalGUID, true);
                }
            }

            void OnGameObjectCreate(GameObject* gameobject)
            {
                switch (gameobject->GetEntry())
                {
                    case GO_FIRE_OF_AKU_MAI_1:
                    case GO_FIRE_OF_AKU_MAI_2:
                    case GO_FIRE_OF_AKU_MAI_3:
                    case GO_FIRE_OF_AKU_MAI_4:
                        if (_encounters[gameobject->GetEntry() - GO_FIRE_OF_AKU_MAI_1 + 1] == DONE)
                        {
                            gameobject->SetFlag(GAMEOBJECT_FLAGS, GO_FLAG_IN_USE);
                            gameobject->SetGoState(GO_STATE_ACTIVE);
                        }
                        break;
                    case GO_SHRINE_OF_GELIHAST:
                        if (_encounters[TYPE_GELIHAST] == DONE)
                            gameobject->RemoveFlag(GAMEOBJECT_FLAGS, GO_FLAG_NOT_SELECTABLE);
                        break;
                    case GO_ALTAR_OF_THE_DEEPS:
                        if (_encounters[TYPE_AKU_MAI] == DONE)
                            gameobject->RemoveFlag(GAMEOBJECT_FLAGS, GO_FLAG_NOT_SELECTABLE);
                        break;
                    case GO_AKU_MAI_DOOR:
                        if (_encounters[TYPE_FIRE1] == DONE && _encounters[TYPE_FIRE2] == DONE && _encounters[TYPE_FIRE3] == DONE && _encounters[TYPE_FIRE4] == DONE)
                            HandleGameObject(0, true, gameobject);
                        _akumaiPortalGUID = gameobject->GetGUID();
                        break;
                }
            }

            void SetData(uint32 type, uint32 data)
            {
                switch (type)
                {
                    case TYPE_GELIHAST:
                    case TYPE_FIRE1:
                    case TYPE_FIRE2:
                    case TYPE_FIRE3:
                    case TYPE_FIRE4:
                    case TYPE_AKU_MAI:
                        _encounters[type] = data;
                        break;
                }

                if (data == DONE)
                    SaveToDB();
            }

            std::string GetSaveData()
            {
                std::ostringstream saveStream;
                saveStream << "B L " << _encounters[0] << ' ' << _encounters[1] << ' ' << _encounters[2] << ' ' << _encounters[3] << ' ' << _encounters[4] << ' ' << _encounters[5];
                return saveStream.str();
            }

            void Load(const char* in)
            {
                if (!in)
                    return;

                char dataHead1, dataHead2;
                std::istringstream loadStream(in);
                loadStream >> dataHead1 >> dataHead2;
                if (dataHead1 == 'B' && dataHead2 == 'L')
                {
                    for (uint8 i = 0; i < MAX_ENCOUNTERS; ++i)
                    {
                        loadStream >> _encounters[i];
                        if (_encounters[i] == IN_PROGRESS)
                            _encounters[i] = NOT_STARTED;
                    }
                }
            }

        private:
            uint32 _encounters[MAX_ENCOUNTERS];
            uint64 _akumaiPortalGUID;
            uint8 _requiredDeaths;
        };
};

void AddSC_instance_blackfathom_deeps()
{
    new instance_blackfathom_deeps();
}

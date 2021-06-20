/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "InstanceScript.h"
#include "dire_maul.h"

class instance_dire_maul : public InstanceMapScript
{
    public:
        instance_dire_maul() : InstanceMapScript("instance_dire_maul", 429) { }

        struct instance_dire_maul_InstanceMapScript : public InstanceScript
        {
            instance_dire_maul_InstanceMapScript(Map* map) : InstanceScript(map) { }

            void Initialize()
            {
                _eastWingProgress = 0;
                _westWingProgress = 0;
                _pylonsState = 0;
                _northWingProgress = 0;
                _northWingBosses = 0;
                _immoltharGUID = 0;
            }

            void OnCreatureCreate(Creature* creature)
            {
                switch (creature->GetEntry())
                {
                    case NPC_IMMOL_THAR:
                        _immoltharGUID = creature->GetGUID();
                        break;
                    case NPC_HIGHBORNE_SUMMONER:
                        if (_pylonsState == ALL_PYLONS_OFF)
                            creature->DespawnOrUnsummon(5000);
                        break;
                }
            }

            void OnGameObjectCreate(GameObject* gameobject)
            {
                switch (gameobject->GetEntry())
                {
                    case GO_DIRE_MAUL_FORCE_FIELD:
                        if (_pylonsState == ALL_PYLONS_OFF)
                            gameobject->SetGoState(GO_STATE_ACTIVE);
                        break;
                    case GO_GORDOK_TRIBUTE:
                    {
                        uint32 fullLootMode = 0x3F;
                        for (uint32 i = 0; i < _northWingBosses; ++i)
                            fullLootMode >>= 1;

                        gameobject->SetLootMode(fullLootMode);
                        break;
                    }
                }
            }

            void SetData(uint32 type, uint32 data)
            {
                switch (type)
                {
                    case TYPE_EAST_WING_PROGRESS:
                        _eastWingProgress = data;
                        instance->LoadGrid(-56.59f, -269.12f);
                        break;
                    case TYPE_WEST_WING_PROGRESS:
                        _westWingProgress = data;
                        instance->LoadGrid(132.626f, 625.913f);
                        break;
                    case TYPE_NORTH_WING_PROGRESS:
                        _northWingProgress = data;
                        break;
                    case TYPE_NORTH_WING_BOSSES:
                        _northWingBosses |= (1 << _northWingBosses);
                        break;
                    case TYPE_PYLONS_STATE:
                        if (_pylonsState & data)
                            return;
                        _pylonsState |= data;
                        if (_pylonsState == ALL_PYLONS_OFF) // all five active, 31
                        {
                            instance->LoadGrid(-38.08f, 812.44f);
                            if (Creature* immol = instance->GetCreature(_immoltharGUID))
                            {
                                immol->setActive(true);
                                immol->GetAI()->SetData(1, 1);
                            }
                        }
                        break;

                }

                SaveToDB();
            }

            uint32 GetData(uint32 type) const
            {
                if (type == TYPE_EAST_WING_PROGRESS)
                    return _eastWingProgress;
                else if (type == TYPE_WEST_WING_PROGRESS)
                    return _westWingProgress;
                else if (type == TYPE_NORTH_WING_PROGRESS)
                    return _northWingProgress;

                return 0;
            }

            std::string GetSaveData()
            {
                std::ostringstream saveStream;
                saveStream << "D M " << _eastWingProgress << ' ' << _westWingProgress << ' ' << _pylonsState << ' ' << _northWingProgress << ' ' << _northWingBosses;
                return saveStream.str();
            }

            void Load(const char* in)
            {
                if (!in)
                    return;

                char dataHead1, dataHead2;
                std::istringstream loadStream(in);
                loadStream >> dataHead1 >> dataHead2;
                if (dataHead1 == 'D' && dataHead2 == 'M')
                {
                    loadStream >> _eastWingProgress;
                    loadStream >> _westWingProgress;
                    loadStream >> _pylonsState;
                    loadStream >> _northWingProgress;
                    loadStream >> _northWingBosses;
                }
            }

        private:
            uint32 _eastWingProgress;
            uint32 _westWingProgress;
            uint32 _pylonsState;
            uint32 _northWingProgress;
            uint32 _northWingBosses;

            uint64 _immoltharGUID;
        };

        InstanceScript* GetInstanceScript(InstanceMap* map) const
        {
            return new instance_dire_maul_InstanceMapScript(map);
        }
};

void AddSC_instance_dire_maul()
{
    new instance_dire_maul();
}

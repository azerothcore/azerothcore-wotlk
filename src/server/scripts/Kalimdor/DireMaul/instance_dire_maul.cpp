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

#include "InstanceScript.h"
#include "ScriptObject.h"
#include "dire_maul.h"

class instance_dire_maul : public InstanceMapScript
{
public:
    instance_dire_maul() : InstanceMapScript(DMScriptName, 429) { }

    struct instance_dire_maul_InstanceMapScript : public InstanceScript
    {
        instance_dire_maul_InstanceMapScript(Map* map) : InstanceScript(map) { }

        void Initialize() override
        {
            _eastWingProgress = 0;
            _westWingProgress = 0;
            _pylonsState = 0;
            _northWingProgress = 0;
            _northWingBosses = 0;
            HighborneSummoners.clear();
        }

        void OnCreatureCreate(Creature* creature) override
        {
            switch (creature->GetEntry())
            {
                case NPC_IMMOL_THAR:
                    _immoltharGUID = creature->GetGUID();
                    if (_pylonsState == ALL_PYLONS_OFF)
                    {
                        creature->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                    }
                    else
                    {
                        creature->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                    }
                    break;
                case NPC_HIGHBORNE_SUMMONER:
                    if (_pylonsState == ALL_PYLONS_OFF)
                    {
                        creature->DespawnOrUnsummon(5000);
                    }
                    else
                    {
                        creature->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                    }
                    HighborneSummoners.push_back(creature->GetGUID());
                    break;
            }
        }

        void OnGameObjectCreate(GameObject* gameobject) override
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

        void SetData(uint32 type, uint32 data) override
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
                            immol->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                        }
                        for (const auto& guid : HighborneSummoners)
                        {
                            if (Creature* summoner = instance->GetCreature(guid))
                            {
                                summoner->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                            }
                        }
                    }
                    break;
            }

            SaveToDB();
        }

        uint32 GetData(uint32 type) const override
        {
            if (type == TYPE_EAST_WING_PROGRESS)
                return _eastWingProgress;
            else if (type == TYPE_WEST_WING_PROGRESS)
                return _westWingProgress;
            else if (type == TYPE_NORTH_WING_PROGRESS)
                return _northWingProgress;

            return 0;
        }

        std::string GetSaveData() override
        {
            std::ostringstream saveStream;
            saveStream << "D M " << _eastWingProgress << ' ' << _westWingProgress << ' ' << _pylonsState << ' ' << _northWingProgress << ' ' << _northWingBosses;
            return saveStream.str();
        }

        void Load(const char* in) override
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

        ObjectGuid _immoltharGUID;
        std::vector<ObjectGuid> HighborneSummoners;
    };

    InstanceScript* GetInstanceScript(InstanceMap* map) const override
    {
        return new instance_dire_maul_InstanceMapScript(map);
    }
};

void AddSC_instance_dire_maul()
{
    new instance_dire_maul();
}

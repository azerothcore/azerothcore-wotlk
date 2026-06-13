/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "InstanceMapScript.h"
#include "InstanceScript.h"
#include "blackfathom_deeps.h"

class instance_blackfathom_deeps : public InstanceMapScript
{
public:
    instance_blackfathom_deeps() : InstanceMapScript("instance_blackfathom_deeps", MAP_BLACKFATHOM_DEEPS) { }

    InstanceScript* GetInstanceScript(InstanceMap* map) const override
    {
        return new instance_blackfathom_deeps_InstanceMapScript(map);
    }

    struct instance_blackfathom_deeps_InstanceMapScript : public InstanceScript
    {
        instance_blackfathom_deeps_InstanceMapScript(Map* map) : InstanceScript(map) { }

        void Initialize() override
        {
            SetHeaders(DataHeader);
            memset(&_encounters, 0, sizeof(_encounters));
            _requiredDeaths = 0;
        }

        void OnCreatureCreate(Creature* creature) override
        {
            if (creature->IsSummon() && (creature->GetEntry() == NPC_BARBED_CRUSTACEAN || creature->GetEntry() == NPC_AKU_MAI_SERVANT ||
                                         creature->GetEntry() == NPC_MURKSHALLOW_SOFTSHELL || creature->GetEntry() == NPC_AKU_MAI_SNAPJAW))
                ++_requiredDeaths;
        }

        void OnUnitDeath(Unit* unit) override
        {
            if (unit->IsSummon() && (unit->GetEntry() == NPC_BARBED_CRUSTACEAN || unit->GetEntry() == NPC_AKU_MAI_SERVANT ||
                                     unit->GetEntry() == NPC_MURKSHALLOW_SOFTSHELL || unit->GetEntry() == NPC_AKU_MAI_SNAPJAW))
            {
                if (--_requiredDeaths == 0)
                {
                    if (IsFireEventDone())
                    {
                        HandleGameObject(_akumaiPortalGUID, true);
                        _encounters[TYPE_AKU_MAI_EVENT] = DONE;
                    }
                }
            }
        }

        void OnGameObjectCreate(GameObject* gameobject) override
        {
            switch (gameobject->GetEntry())
            {
                case GO_FIRE_OF_AKU_MAI_1:
                case GO_FIRE_OF_AKU_MAI_2:
                case GO_FIRE_OF_AKU_MAI_3:
                case GO_FIRE_OF_AKU_MAI_4:
                    if (_encounters[TYPE_AKU_MAI_EVENT] == DONE)
                    {
                        gameobject->SetGameObjectFlag(GO_FLAG_IN_USE);
                        gameobject->SetGoState(GO_STATE_ACTIVE);
                    }
                    break;
                case GO_SHRINE_OF_GELIHAST:
                    if (_encounters[TYPE_GELIHAST] == DONE)
                        gameobject->RemoveGameObjectFlag(GO_FLAG_NOT_SELECTABLE);
                    break;
                case GO_ALTAR_OF_THE_DEEPS:
                    if (_encounters[TYPE_AKU_MAI] == DONE)
                        gameobject->RemoveGameObjectFlag(GO_FLAG_NOT_SELECTABLE);
                    break;
                case GO_AKU_MAI_DOOR:
                    if (IsFireEventDone() && _encounters[TYPE_AKU_MAI_EVENT] == DONE)
                        HandleGameObject(ObjectGuid::Empty, true, gameobject);
                    _akumaiPortalGUID = gameobject->GetGUID();
                    break;
            }
        }

        void SetData(uint32 type, uint32 data) override
        {
            switch (type)
            {
                case TYPE_GELIHAST:
                case TYPE_FIRE1:
                case TYPE_FIRE2:
                case TYPE_FIRE3:
                case TYPE_FIRE4:
                case TYPE_AKU_MAI:
                case TYPE_AKU_MAI_EVENT:
                    _encounters[type] = data;
                    break;
            }

            if (data == DONE)
                SaveToDB();
        }

        void ReadSaveDataMore(std::istringstream& data) override
        {
            data >> _encounters[0];
            data >> _encounters[1];
            data >> _encounters[2];
            data >> _encounters[3];
            data >> _encounters[4];
            data >> _encounters[5];
        }

        void WriteSaveDataMore(std::ostringstream& data) override
        {
            data << _encounters[0] << ' '
                << _encounters[1] << ' '
                << _encounters[2] << ' '
                << _encounters[3] << ' '
                << _encounters[4] << ' '
                << _encounters[5];
        }

        bool IsFireEventDone()
        {
            return _encounters[TYPE_FIRE1] == DONE && _encounters[TYPE_FIRE2] == DONE && _encounters[TYPE_FIRE3] == DONE && _encounters[TYPE_FIRE4] == DONE;
        }

    private:
        uint32 _encounters[MAX_ENCOUNTERS];
        ObjectGuid _akumaiPortalGUID;
        uint8 _requiredDeaths;
    };
};

void AddSC_instance_blackfathom_deeps()
{
    new instance_blackfathom_deeps();
}

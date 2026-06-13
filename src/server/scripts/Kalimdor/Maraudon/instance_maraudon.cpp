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
#include "maraudon.h"

class instance_maraudon : public InstanceMapScript
{
public:
    instance_maraudon() : InstanceMapScript("instance_maraudon", MAP_MARAUDON) { }

    struct instance_maraudon_InstanceMapScript : public InstanceScript
    {
        instance_maraudon_InstanceMapScript(Map* map) : InstanceScript(map)
        {
        }

        void Initialize() override
        {
            SetHeaders(DataHeader);
            memset(&_encounters, 0, sizeof(_encounters));
        }

        void OnGameObjectCreate(GameObject* gameobject) override
        {
            switch (gameobject->GetEntry())
            {
                case GO_CORRUPTION_SPEWER:
                    if (_encounters[TYPE_NOXXION] == DONE)
                        HandleGameObject(ObjectGuid::Empty, true, gameobject);
                    break;
            }
        }

        void SetData(uint32 type, uint32 data) override
        {
            switch (type)
            {
                case TYPE_NOXXION:
                    _encounters[type] = data;
                    break;
            }

            if (data == DONE)
                SaveToDB();
        }

        void ReadSaveDataMore(std::istringstream& data) override
        {
            data >> _encounters[0];
        }

        void WriteSaveDataMore(std::ostringstream& data) override
        {
            data << _encounters[0];
        }

    private:
        uint32 _encounters[MAX_ENCOUNTERS];
    };

    InstanceScript* GetInstanceScript(InstanceMap* map) const override
    {
        return new instance_maraudon_InstanceMapScript(map);
    }
};

void AddSC_instance_maraudon()
{
    new instance_maraudon();
}

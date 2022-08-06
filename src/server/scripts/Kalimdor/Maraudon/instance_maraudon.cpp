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
#include "maraudon.h"

class instance_maraudon : public InstanceMapScript
{
public:
    instance_maraudon() : InstanceMapScript("instance_maraudon", 349) { }

    struct instance_maraudon_InstanceMapScript : public InstanceScript
    {
        instance_maraudon_InstanceMapScript(Map* map) : InstanceScript(map)
        {
        }

        void Initialize() override
        {
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

        std::string GetSaveData() override
        {
            std::ostringstream saveStream;
            saveStream << "M A " << _encounters[0];
            return saveStream.str();
        }

        void Load(const char* in) override
        {
            if (!in)
                return;

            char dataHead1, dataHead2;
            std::istringstream loadStream(in);
            loadStream >> dataHead1 >> dataHead2;
            if (dataHead1 == 'M' && dataHead2 == 'A')
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

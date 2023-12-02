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

#include "CreatureScript.h"
#include "InstanceMapScript.h"
#include "InstanceScript.h"
#include "ObjectMgr.h"
#include "razorfen_downs.h"

class instance_razorfen_downs : public InstanceMapScript
{
public:
    instance_razorfen_downs() : InstanceMapScript("instance_razorfen_downs", 129) { }

    struct instance_razorfen_downs_InstanceMapScript : public InstanceScript
    {
        instance_razorfen_downs_InstanceMapScript(Map* map) : InstanceScript(map)
        {
        }

        void Initialize() override
        {
            SetHeaders(DataHeader);
            _gongPhase = 0;
            _firesState = 0;
        }

        void OnGameObjectCreate(GameObject* gameobject) override
        {
            switch (gameobject->GetEntry())
            {
                case GO_IDOL_OVEN_FIRE:
                case GO_IDOL_CUP_FIRE:
                case GO_IDOL_MOUTH_FIRE:
                    if (_firesState == DONE)
                        gameobject->Delete();
                    break;
                case GO_GONG:
                    if (_gongPhase == DONE)
                        gameobject->SetGameObjectFlag(GO_FLAG_NOT_SELECTABLE);
                    break;
            }
        }

        uint32 GetData(uint32 type) const override
        {
            if (type == GO_GONG)
                return _gongPhase;
            return 0;
        }

        void SetData(uint32 type, uint32 data) override
        {
            if (type == GO_GONG)
                _gongPhase = data;
            else if (type == GO_BELNISTRASZS_BRAZIER)
                _firesState = DONE;
            SaveToDB();
        }

        void ReadSaveDataMore(std::istringstream& data) override
        {
            data >> _gongPhase;
            data >> _firesState;
        }

        void WriteSaveDataMore(std::ostringstream& data) override
        {
            data << _gongPhase << ' ' << _firesState;
        }

    private:
        uint32 _gongPhase;
        uint32 _firesState;
    };

    InstanceScript* GetInstanceScript(InstanceMap* map) const override
    {
        return new instance_razorfen_downs_InstanceMapScript(map);
    }
};

void AddSC_instance_razorfen_downs()
{
    new instance_razorfen_downs();
}

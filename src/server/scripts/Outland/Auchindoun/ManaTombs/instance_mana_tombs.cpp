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
#include "Map.h"
#include "ScriptMgr.h"
#include "mana_tombs.h"

class instance_mana_tombs : public InstanceMapScript
{
public:
    instance_mana_tombs() : InstanceMapScript(MTScriptName, 557) { }

    struct instance_mana_tombs_InstanceMapScript : public InstanceScript
    {
        instance_mana_tombs_InstanceMapScript(Map* map) : InstanceScript(map)
        {
            SetBossNumber(EncounterCount);
        }

        void Load(char const* data) override { LoadBossState(data); }

        std::string GetSaveData() override { return DataHeader + GetBossSaveData(); }
    };

    InstanceScript* GetInstanceScript(InstanceMap* map) const override
    {
        return new instance_mana_tombs_InstanceMapScript(map);
    }
};

void AddSC_instance_mana_tombs()
{
    new instance_mana_tombs();
}

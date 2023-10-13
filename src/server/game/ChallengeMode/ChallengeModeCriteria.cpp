/*
 * This file is part of the TrinityCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the
 * Free Software Foundation; either version 2 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "ChallengeModeCriteria.h"
#include "ChallengeModeMgr.h"
#include "DatabaseEnv.h"
#include "InstanceSaveMgr.h"
#include "InstanceScript.h"
#include "Log.h"
#include "Map.h"
#include "ObjectMgr.h"
#include "Player.h"

enum CriteriaType {
    BOSS = 0,
    MINIONS = 1,
    TIMER = 3
};

ChallengeModeCriteria::ChallengeModeCriteria(Map* map) : _map(map)
{
    ASSERT(_map);
    LoadInstanceData();
}

void ChallengeModeCriteria::LoadInstanceData()
{
    _criteria.clear();

    QueryResult result = WorldDatabase.Query("SELECT * FROM `forge_mythic_criteria` where `instance` = {}", _map->GetId());

    if (result)
    {
        do
        {
            Field* fields = result->Fetch();
            uint32 instance = fields[1].Get<uint32>();
            uint32 type = fields[2].Get<uint32>();
            uint32 value = fields[3].Get<uint32>();

            switch (type) {
            case BOSS:
                _criteria[value] = 0;
                continue;
            case MINIONS:
                _maxMinionCount = value;
                _criteria[0] = 0;
                continue;
            case TIMER:

                continue;
            default:
                continue;
            }
        }
        while (result->NextRow());
    }
}

void ChallengeModeCriteria::CompleteCriteria(Unit* victim)
{
    if (InstanceMap* iMap = const_cast<Map*>(_map)->ToInstanceMap())
    {
        if (InstanceScript* instance = iMap->GetInstanceScript())
        {
            if (instance->IsChallengeModeStarted())
            {
                instance->CompleteChallengeMode(victim->GetPosition());
            }
        }
    }
}

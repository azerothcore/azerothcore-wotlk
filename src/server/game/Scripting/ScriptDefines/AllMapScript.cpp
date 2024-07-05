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

#include "AllMapScript.h"
#include "BattlegroundMapScript.h"
#include "InstanceMapScript.h"
#include "PlayerScript.h"
#include "ScriptMgr.h"
#include "ScriptMgrMacros.h"
#include "WorldMapScript.h"

namespace
{
    template<class ScriptName>
    void ForeachMaps(Map* map, std::function<void(ScriptName*)> const& executeHook)
    {
        auto mapEntry = map->GetEntry();
        if (!mapEntry)
        {
            return;
        }

        if constexpr (std::is_same_v<ScriptName, WorldMapScript>)
        {
            if (!mapEntry->IsWorldMap())
            {
                return;
            }
        }
        else if constexpr (std::is_same_v<ScriptName, InstanceMapScript>)
        {
            if (!mapEntry->IsDungeon())
            {
                return;
            }
        }
        else if constexpr (std::is_same_v<ScriptName, BattlegroundMapScript>)
        {
            if (!mapEntry->IsBattleground())
            {
                return;
            }
        }
        else
        {
            static_assert(Acore::dependant_false_v<ScriptName>, "Unsupported type used for ForeachMaps");
        }

        if (ScriptRegistry<ScriptName>::ScriptPointerList.empty())
        {
            return;
        }

        for (auto const& [scriptID, script] : ScriptRegistry<ScriptName>::ScriptPointerList)
        {
            auto const scriptEntry = script->GetEntry();
            if (!scriptEntry)
            {
                continue;
            }

            if (scriptEntry->MapID != map->GetId())
            {
                continue;
            }

            executeHook(script);
            return;
        }
    }
}

void ScriptMgr::OnCreateMap(Map* map)
{
    ASSERT(map);

    ExecuteScript<AllMapScript>([&](AllMapScript* script)
    {
        script->OnCreateMap(map);
    });

    ForeachMaps<WorldMapScript>(map,
    [&](WorldMapScript* script)
    {
        script->OnCreate(map);
    });

    ForeachMaps<InstanceMapScript>(map,
    [&](InstanceMapScript* script)
    {
        script->OnCreate((InstanceMap*)map);
    });

    ForeachMaps<BattlegroundMapScript>(map,
    [&](BattlegroundMapScript* script)
    {
        script->OnCreate((BattlegroundMap*)map);
    });
}

void ScriptMgr::OnDestroyMap(Map* map)
{
    ASSERT(map);

    ExecuteScript<AllMapScript>([&](AllMapScript* script)
    {
        script->OnDestroyMap(map);
    });

    ForeachMaps<WorldMapScript>(map,
    [&](WorldMapScript* script)
    {
        script->OnDestroy(map);
    });

    ForeachMaps<InstanceMapScript>(map,
    [&](InstanceMapScript* script)
    {
        script->OnDestroy((InstanceMap*)map);
    });

    ForeachMaps<BattlegroundMapScript>(map,
    [&](BattlegroundMapScript* script)
    {
        script->OnDestroy((BattlegroundMap*)map);
    });
}

void ScriptMgr::OnLoadGridMap(Map* map, GridMap* gmap, uint32 gx, uint32 gy)
{
    ASSERT(map);
    ASSERT(gmap);

    ForeachMaps<WorldMapScript>(map,
    [&](WorldMapScript* script)
    {
        script->OnLoadGridMap(map, gmap, gx, gy);
    });

    ForeachMaps<InstanceMapScript>(map,
    [&](InstanceMapScript* script)
    {
        script->OnLoadGridMap((InstanceMap*)map, gmap, gx, gy);
    });

    ForeachMaps<BattlegroundMapScript>(map,
    [&](BattlegroundMapScript* script)
    {
        script->OnLoadGridMap((BattlegroundMap*)map, gmap, gx, gy);
    });
}

void ScriptMgr::OnUnloadGridMap(Map* map, GridMap* gmap, uint32 gx, uint32 gy)
{
    ASSERT(map);
    ASSERT(gmap);

    ForeachMaps<WorldMapScript>(map,
    [&](WorldMapScript* script)
    {
        script->OnUnloadGridMap(map, gmap, gx, gy);
    });

    ForeachMaps<InstanceMapScript>(map,
    [&](InstanceMapScript* script)
    {
        script->OnUnloadGridMap((InstanceMap*)map, gmap, gx, gy);
    });

    ForeachMaps<BattlegroundMapScript>(map,
    [&](BattlegroundMapScript* script)
    {
        script->OnUnloadGridMap((BattlegroundMap*)map, gmap, gx, gy);
    });
}

void ScriptMgr::OnPlayerEnterMap(Map* map, Player* player)
{
    ASSERT(map);
    ASSERT(player);

    ExecuteScript<AllMapScript>([&](AllMapScript* script)
    {
        script->OnPlayerEnterAll(map, player);
    });

    ExecuteScript<PlayerScript>([=](PlayerScript* script)
    {
        script->OnMapChanged(player);
    });

    ForeachMaps<WorldMapScript>(map,
    [&](WorldMapScript* script)
    {
        script->OnPlayerEnter(map, player);
    });

    ForeachMaps<InstanceMapScript>(map,
    [&](InstanceMapScript* script)
    {
        script->OnPlayerEnter((InstanceMap*)map, player);
    });

    ForeachMaps<BattlegroundMapScript>(map,
    [&](BattlegroundMapScript* script)
    {
        script->OnPlayerEnter((BattlegroundMap*)map, player);
    });
}

void ScriptMgr::OnPlayerLeaveMap(Map* map, Player* player)
{
    ASSERT(map);
    ASSERT(player);

    ExecuteScript<AllMapScript>([&](AllMapScript* script)
    {
        script->OnPlayerLeaveAll(map, player);
    });

    ForeachMaps<WorldMapScript>(map,
    [&](WorldMapScript* script)
    {
        script->OnPlayerLeave(map, player);
    });

    ForeachMaps<InstanceMapScript>(map,
    [&](InstanceMapScript* script)
    {
        script->OnPlayerLeave((InstanceMap*)map, player);
    });

    ForeachMaps<BattlegroundMapScript>(map,
    [&](BattlegroundMapScript* script)
    {
        script->OnPlayerLeave((BattlegroundMap*)map, player);
    });
}

void ScriptMgr::OnMapUpdate(Map* map, uint32 diff)
{
    ASSERT(map);

    ExecuteScript<AllMapScript>([&](AllMapScript* script)
    {
        script->OnMapUpdate(map, diff);
    });

    ForeachMaps<WorldMapScript>(map,
    [&](WorldMapScript* script)
    {
        script->OnUpdate(map, diff);
    });

    ForeachMaps<InstanceMapScript>(map,
    [&](InstanceMapScript* script)
    {
        script->OnUpdate((InstanceMap*)map, diff);
    });

    ForeachMaps<BattlegroundMapScript>(map,
    [&](BattlegroundMapScript* script)
    {
        script->OnUpdate((BattlegroundMap*)map, diff);
    });
}

void ScriptMgr::OnBeforeCreateInstanceScript(InstanceMap* instanceMap, InstanceScript** instanceData, bool load, std::string data, uint32 completedEncounterMask)
{
    ExecuteScript<AllMapScript>([&](AllMapScript* script)
    {
        script->OnBeforeCreateInstanceScript(instanceMap, instanceData, load, data, completedEncounterMask);
    });
}

void ScriptMgr::OnDestroyInstance(MapInstanced* mapInstanced, Map* map)
{
    ExecuteScript<AllMapScript>([&](AllMapScript* script)
    {
        script->OnDestroyInstance(mapInstanced, map);
    });
}

AllMapScript::AllMapScript(const char* name) :
    ScriptObject(name)
{
    ScriptRegistry<AllMapScript>::AddScript(this);
}

template class AC_GAME_API ScriptRegistry<AllMapScript>;

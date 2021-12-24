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

#include "ScriptMgr.h"
#include "ScriptMgrMacros.h"

namespace
{
    template<class ScriptName>
    inline void ForeachMaps([[maybe_unused]] Map* map, [[maybe_unused]] std::function<void(ScriptName*)> executeHook)
    {
        static_assert(Acore::dependant_false_v<ScriptName>, "Unsupported type used for ForeachMaps");
    }

    template<>
    inline void ForeachMaps(Map* map, std::function<void(WorldMapScript*)> executeHook)
    {
        auto mapEntry = map->GetEntry();

        if (!mapEntry)
        {
            return;
        }

        if (!mapEntry->IsWorldMap())
        {
            return;
        }

        if (ScriptRegistry<WorldMapScript>::ScriptPointerList.empty())
        {
            return;
        }

        for (auto const& [scriptID, script] : ScriptRegistry<WorldMapScript>::ScriptPointerList)
        {
            MapEntry const* mapEntry = script->GetEntry();
            if (!mapEntry)
            {
                continue;
            }

            if (mapEntry->MapID != map->GetId())
            {
                continue;
            }

            executeHook(script);
            return;
        }
    }

    template<>
    inline void ForeachMaps(Map* map, std::function<void(InstanceMapScript*)> executeHook)
    {
        auto mapEntry = map->GetEntry();

        if (!mapEntry)
        {
            return;
        }

        if (!mapEntry->IsDungeon())
        {
            return;
        }

        if (ScriptRegistry<InstanceMapScript>::ScriptPointerList.empty())
        {
            return;
        }

        for (auto const& [scriptID, script] : ScriptRegistry<InstanceMapScript>::ScriptPointerList)
        {
            MapEntry const* mapEntry = script->GetEntry();
            if (!mapEntry)
            {
                continue;
            }

            if (mapEntry->MapID != map->GetId())
            {
                continue;
            }

            executeHook(script);
            return;
        }
    }

    template<>
    inline void ForeachMaps(Map* map, std::function<void(BattlegroundMapScript*)> executeHook)
    {
        auto mapEntry = map->GetEntry();

        if (!mapEntry)
        {
            return;
        }

        if (!mapEntry->IsBattleground())
        {
            return;
        }

        if (ScriptRegistry<BattlegroundMapScript>::ScriptPointerList.empty())
        {
            return;
        }

        for (auto const& [scriptID, script] : ScriptRegistry<BattlegroundMapScript>::ScriptPointerList)
        {
            MapEntry const* mapEntry = script->GetEntry();
            if (!mapEntry)
            {
                continue;
            }

            if (mapEntry->MapID != map->GetId())
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

    ExecuteScript<PlayerScript>([&](PlayerScript* script)
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

void ScriptMgr::OnBeforeCreateInstanceScript(InstanceMap* instanceMap, InstanceScript* instanceData, bool load, std::string data, uint32 completedEncounterMask)
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

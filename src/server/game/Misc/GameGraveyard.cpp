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

#include "GameGraveyard.h"
#include "DBCStores.h"
#include "DatabaseEnv.h"
#include "Log.h"
#include "MapMgr.h"
#include "ScriptMgr.h"

Graveyard* Graveyard::instance()
{
    static Graveyard instance;
    return &instance;
}

void Graveyard::LoadGraveyardFromDB()
{
    uint32 oldMSTime = getMSTime();

    _graveyardStore.clear();

    QueryResult result = WorldDatabase.Query("SELECT ID, Map, x, y, z, Comment FROM game_graveyard");
    if (!result)
    {
        LOG_WARN("server.loading", ">> Loaded 0 graveyard. Table `game_graveyard` is empty!");
        LOG_INFO("server.loading", " ");
        return;
    }

    int32 Count = 0;

    do
    {
        Field* fields = result->Fetch();
        uint32 ID = fields[0].Get<uint32>();

        GraveyardStruct Graveyard;

        Graveyard.Map = fields[1].Get<uint32>();
        Graveyard.x = fields[2].Get<float>();
        Graveyard.y = fields[3].Get<float>();
        Graveyard.z = fields[4].Get<float>();
        Graveyard.name = fields[5].Get<std::string>();

        if (!Utf8toWStr(Graveyard.name, Graveyard.wnameLow))
        {
            LOG_ERROR("sql.sql", "Wrong UTF8 name for id {} in `game_graveyard` table, ignoring.", ID);
            continue;
        }

        wstrToLower(Graveyard.wnameLow);

        _graveyardStore[ID] = Graveyard;

        ++Count;
    } while (result->NextRow());

    LOG_INFO("server.loading", ">> Loaded {} Graveyard in {} ms", Count, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
}

GraveyardStruct const* Graveyard::GetGraveyard(uint32 ID) const
{
    GraveyardContainer::const_iterator itr = _graveyardStore.find(ID);
    if (itr != _graveyardStore.end())
        return &itr->second;

    return nullptr;
}

GraveyardStruct const* Graveyard::GetDefaultGraveyard(TeamId teamId)
{
    enum DefaultGraveyard
    {
        HORDE_GRAVEYARD = 10, // Crossroads
        ALLIANCE_GRAVEYARD = 4, // Westfall
    };

    return sGraveyard->GetGraveyard(teamId == TEAM_HORDE ? HORDE_GRAVEYARD : ALLIANCE_GRAVEYARD);
}

GraveyardStruct const* Graveyard::GetClosestGraveyard(Player* player, TeamId teamId, bool nearCorpse)
{
    uint32 graveyardOverride = 0;
    sScriptMgr->OnBeforeChooseGraveyard(player, teamId, nearCorpse, graveyardOverride);
    if (graveyardOverride)
    {
        return sGraveyard->GetGraveyard(graveyardOverride);
    }

    WorldLocation loc = player->GetWorldLocation();

    if (nearCorpse)
    {
        loc = player->GetCorpseLocation();
    }

    uint32 mapId = loc.GetMapId();
    float  x     = loc.GetPositionX();
    float  y     = loc.GetPositionY();
    float  z     = loc.GetPositionZ();

    uint32 zoneId = 0;
    uint32 areaId = 0;
    player->GetZoneAndAreaId(zoneId, areaId);

    return GetClosestGraveyard(mapId, x, y, z, teamId, areaId, zoneId, player->getClass() == CLASS_DEATH_KNIGHT);
}

GraveyardStruct const* Graveyard::GetClosestGraveyard(uint32 mapId, float x, float y, float z, TeamId teamId, uint32 areaId, uint32 zoneId, bool isDeathKnight)
{
    if (!zoneId && !areaId)
    {
        if (z > -500)
        {
            LOG_ERROR("sql.sql", "GetClosestGraveyard: unable to find zoneId and areaId for map {} coords ({}, {}, {})", mapId, x, y, z);
            return GetDefaultGraveyard(teamId);
        }
    }

    // Simulate std. algorithm:
    //   found some graveyard associated to (ghost_zone, ghost_map)
    //
    //   if mapId == graveyard.mapId (ghost in plain zone or city or battleground) and search graveyard at same map
    //     then check faction
    //   if mapId != graveyard.mapId (ghost in instance) and search any graveyard associated
    //     then check faction

    // Fetch the graveyards linked to the areaId first, presumably the closer ones.
    GraveyardMapBounds range = GraveyardStore.equal_range(areaId);

    // No graveyards linked to the area, search zone.
    if (range.first == range.second)
    {
        range = GraveyardStore.equal_range(zoneId);
    }
    else // Found a graveyard linked to the area, check if it's a valid one.
    {
        GraveyardData const& graveyardLink = range.first->second;

        if (!graveyardLink.IsNeutralOrFriendlyToTeam(teamId))
        {
            // Not a friendly or neutral graveyard, search zone.
            range = GraveyardStore.equal_range(zoneId);
        }
    }

    MapEntry const* map = sMapStore.LookupEntry(mapId);

    // not need to check validity of map object; MapId _MUST_ be valid here
    if (range.first == range.second && !map->IsBattlegroundOrArena())
    {
        LOG_ERROR("sql.sql", "Table `graveyard_zone` incomplete: Zone {} Team {} does not have a linked graveyard.", zoneId, teamId);
        return GetDefaultGraveyard(teamId);
    }

    // at corpse map
    bool foundNear = false;
    float distNear = 10000;
    GraveyardStruct const* entryNear = nullptr;

    // at entrance map for corpse map
    bool foundEntr = false;
    float distEntr = 10000;
    GraveyardStruct const* entryEntr = nullptr;

    // some where other
    GraveyardStruct const* entryFar = nullptr;

    MapEntry const* mapEntry = sMapStore.LookupEntry(mapId);

    for (; range.first != range.second; ++range.first)
    {
        GraveyardData const& graveyardLink = range.first->second;
        GraveyardStruct const* entry = sGraveyard->GetGraveyard(graveyardLink.safeLocId);
        if (!entry)
        {
            LOG_ERROR("sql.sql", "Table `graveyard_zone` has record for not existing `game_graveyard` table {}, skipped.", graveyardLink.safeLocId);
            continue;
        }

        // Skip enemy faction graveyard.
        if (!graveyardLink.IsNeutralOrFriendlyToTeam(teamId))
        {
            continue;
        }

        // Skip Archerus graveyards if the player isn't a Death Knight.
        enum DeathKnightGraveyards
        {
            GRAVEYARD_EBON_HOLD = 1369,
            GRAVEYARD_ARCHERUS  = 1405
        };

        if (!isDeathKnight && (graveyardLink.safeLocId == GRAVEYARD_EBON_HOLD || graveyardLink.safeLocId == GRAVEYARD_ARCHERUS))
        {
            continue;
        }

        // find now nearest graveyard at other map
        if (mapId != entry->Map)
        {
            // if find graveyard at different map from where entrance placed (or no entrance data), use any first
            if (!mapEntry
                    || mapEntry->entrance_map < 0
                    || uint32(mapEntry->entrance_map) != entry->Map
                    || (mapEntry->entrance_x == 0 && mapEntry->entrance_y == 0))
            {
                // not have any corrdinates for check distance anyway
                entryFar = entry;
                continue;
            }

            // at entrance map calculate distance (2D);
            float dist2 = (entry->x - mapEntry->entrance_x) * (entry->x - mapEntry->entrance_x)
                          + (entry->y - mapEntry->entrance_y) * (entry->y - mapEntry->entrance_y);
            if (foundEntr)
            {
                if (dist2 < distEntr)
                {
                    distEntr = dist2;
                    entryEntr = entry;
                }
            }
            else
            {
                foundEntr = true;
                distEntr = dist2;
                entryEntr = entry;
            }
        }
        // find now nearest graveyard at same map
        else
        {
            float dist2 = (entry->x - x) * (entry->x - x) + (entry->y - y) * (entry->y - y) + (entry->z - z) * (entry->z - z);
            if (foundNear)
            {
                if (dist2 < distNear)
                {
                    distNear = dist2;
                    entryNear = entry;
                }
            }
            else
            {
                foundNear = true;
                distNear = dist2;
                entryNear = entry;
            }
        }
    }

    if (entryNear)
        return entryNear;

    if (entryEntr)
        return entryEntr;

    return entryFar;
}

GraveyardData const* Graveyard::FindGraveyardData(uint32 id, uint32 zoneId)
{
    GraveyardMapBounds range = GraveyardStore.equal_range(zoneId);
    for (; range.first != range.second; ++range.first)
    {
        GraveyardData const& data = range.first->second;
        if (data.safeLocId == id)
            return &data;
    }

    return nullptr;
}

bool Graveyard::AddGraveyardLink(uint32 id, uint32 zoneId, TeamId teamId, bool persist /*= true*/)
{
    if (FindGraveyardData(id, zoneId))
        return false;

    // add link to loaded data
    GraveyardData data;
    data.safeLocId = id;
    data.teamId = teamId;

    GraveyardStore.insert(WGGraveyardContainer::value_type(zoneId, data));

    // add link to DB
    if (persist)
    {
        WorldDatabasePreparedStatement* stmt = WorldDatabase.GetPreparedStatement(WORLD_INS_GRAVEYARD_ZONE);

        stmt->SetData(0, id);
        stmt->SetData(1, zoneId);
        // Xinef: DB Data compatibility...
        stmt->SetData(2, uint16(teamId == TEAM_NEUTRAL ? 0 : (teamId == TEAM_ALLIANCE ? ALLIANCE : HORDE)));

        WorldDatabase.Execute(stmt);
    }

    return true;
}

void Graveyard::RemoveGraveyardLink(uint32 id, uint32 zoneId, TeamId teamId, bool persist /*= false*/)
{
    GraveyardMapBoundsNonConst range = GraveyardStore.equal_range(zoneId);
    if (range.first == range.second)
    {
        LOG_ERROR("sql.sql", "Table `graveyard_zone` incomplete: Zone {} Team {} does not have a linked graveyard.", zoneId, teamId);
        return;
    }

    bool found = false;

    for (; range.first != range.second; ++range.first)
    {
        GraveyardData& data = range.first->second;

        // skip not matching safezone id
        if (data.safeLocId != id)
            continue;

        // skip enemy faction graveyard at same map (normal area, city, or battleground)
        // team == 0 case can be at call from .neargrave
        if (data.teamId != TEAM_NEUTRAL && teamId != TEAM_NEUTRAL && data.teamId != teamId)
            continue;

        found = true;
        break;
    }

    // no match, return
    if (!found)
        return;

    // remove from links
    GraveyardStore.erase(range.first);

    // remove link from DB
    if (persist)
    {
        WorldDatabasePreparedStatement* stmt = WorldDatabase.GetPreparedStatement(WORLD_DEL_GRAVEYARD_ZONE);

        stmt->SetData(0, id);
        stmt->SetData(1, zoneId);
        // Xinef: DB Data compatibility...
        stmt->SetData(2, uint16(teamId == TEAM_NEUTRAL ? 0 : (teamId == TEAM_ALLIANCE ? ALLIANCE : HORDE)));

        WorldDatabase.Execute(stmt);
    }
}

void Graveyard::LoadGraveyardZones()
{
    uint32 oldMSTime = getMSTime();

    GraveyardStore.clear(); // need for reload case

    //                                                0       1         2
    QueryResult result = WorldDatabase.Query("SELECT ID, GhostZone, Faction FROM graveyard_zone");

    if (!result)
    {
        LOG_WARN("server.loading", ">> Loaded 0 Graveyard-Zone Links. DB Table `graveyard_zone` Is Empty.");
        LOG_INFO("server.loading", " ");
        return;
    }

    uint32 count = 0;

    do
    {
        ++count;

        Field* fields = result->Fetch();

        uint32 safeLocId = fields[0].Get<uint32>();
        uint32 zoneId = fields[1].Get<uint32>();
        uint32 team = fields[2].Get<uint16>();
        TeamId teamId = team == 0 ? TEAM_NEUTRAL : (team == ALLIANCE ? TEAM_ALLIANCE : TEAM_HORDE);

        GraveyardStruct const* entry = sGraveyard->GetGraveyard(safeLocId);
        if (!entry)
        {
            LOG_ERROR("sql.sql", "Table `graveyard_zone` has a record for not existing `game_graveyard` table {}, skipped.", safeLocId);
            continue;
        }

        AreaTableEntry const* areaEntry = sAreaTableStore.LookupEntry(zoneId);
        if (!areaEntry)
        {
            LOG_ERROR("sql.sql", "Table `graveyard_zone` has a record for not existing zone id ({}), skipped.", zoneId);
            continue;
        }

        if (team != 0 && team != HORDE && team != ALLIANCE)
        {
            LOG_ERROR("sql.sql", "Table `graveyard_zone` has a record for non player faction ({}), skipped.", team);
            continue;
        }

        if (!AddGraveyardLink(safeLocId, zoneId, teamId, false))
            LOG_ERROR("sql.sql", "Table `graveyard_zone` has a duplicate record for Graveyard (ID: {}) and Zone (ID: {}), skipped.", safeLocId, zoneId);
    } while (result->NextRow());

    LOG_INFO("server.loading", ">> Loaded {} Graveyard-Zone Links in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
}

GraveyardStruct const* Graveyard::GetGraveyard(const std::string& name) const
{
    // explicit name case
    std::wstring wname;
    if (!Utf8toWStr(name, wname))
        return nullptr;

    // converting string that we try to find to lower case
    wstrToLower(wname);

    // Alternative first GameTele what contains wnameLow as substring in case no GameTele location found
    const GraveyardStruct* alt = nullptr;
    for (GraveyardContainer::const_iterator itr = _graveyardStore.begin(); itr != _graveyardStore.end(); ++itr)
    {
        if (itr->second.wnameLow == wname)
            return &itr->second;
        else if (!alt && itr->second.wnameLow.find(wname) != std::wstring::npos)
            alt = &itr->second;
    }

    return alt;
}

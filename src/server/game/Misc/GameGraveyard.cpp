#include "GameGraveyard.h"
#include "MapManager.h"
#include "DBCStores.h"
#include "DatabaseEnv.h"
#include "Log.h"

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
        sLog->outString(">> Loaded 0 graveyard. Table `game_graveyard` is empty!");
        sLog->outString();
        return;
    }

    int32 Count = 0;

    do
    {
        Field* fields = result->Fetch();
        uint32 ID = fields[0].GetUInt32();

        GraveyardStruct Graveyard;

        Graveyard.Map = fields[1].GetUInt32();
        Graveyard.x = fields[2].GetFloat();
        Graveyard.y = fields[3].GetFloat();
        Graveyard.z = fields[4].GetFloat();
        Graveyard.name = fields[5].GetString();
        
        if (!Utf8toWStr(Graveyard.name, Graveyard.wnameLow))
        {
            sLog->outErrorDb("Wrong UTF8 name for id %u in `game_graveyard` table, ignoring.", ID);
            continue;
        }

        wstrToLower(Graveyard.wnameLow);

        _graveyardStore[ID] = Graveyard;

        ++Count;

    } while (result->NextRow());

    sLog->outString(">> Loaded %i graveyard in %u ms", Count, GetMSTimeDiffToNow(oldMSTime));
    sLog->outString();
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

GraveyardStruct const* Graveyard::GetClosestGraveyard(float x, float y, float z, uint32 MapId, TeamId teamId)
{
    // search for zone associated closest graveyard
    uint32 zoneId = sMapMgr->GetZoneId(MapId, x, y, z);

    if (!zoneId)
    {
        if (z > -500)
        {
            sLog->outError("ZoneId not found for map %u coords (%f, %f, %f)", MapId, x, y, z);
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
    GraveyardMapBounds range = GraveyardStore.equal_range(zoneId);
    MapEntry const* map = sMapStore.LookupEntry(MapId);

    // not need to check validity of map object; MapId _MUST_ be valid here
    if (range.first == range.second && !map->IsBattlegroundOrArena())
    {
        sLog->outErrorDb("Table `graveyard_zone` incomplete: Zone %u Team %u does not have a linked graveyard.", zoneId, teamId);
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

    MapEntry const* mapEntry = sMapStore.LookupEntry(MapId);

    for (; range.first != range.second; ++range.first)
    {
        GraveyardData const& data = range.first->second;
        GraveyardStruct const* entry = sGraveyard->GetGraveyard(data.safeLocId);
        if (!entry)
        {
            sLog->outErrorDb("Table `graveyard_zone` has record for not existing `game_graveyard` table %u, skipped.", data.safeLocId);
            continue;
        }

        // skip enemy faction graveyard
        // team == 0 case can be at call from .neargrave
        if (data.teamId != TEAM_NEUTRAL && teamId != TEAM_NEUTRAL && data.teamId != teamId)
            continue;

        // find now nearest graveyard at other map
        if (MapId != entry->Map)
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
            float dist2 = (entry->x - mapEntry->entrance_x)*(entry->x - mapEntry->entrance_x)
                + (entry->y - mapEntry->entrance_y)*(entry->y - mapEntry->entrance_y);
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
            float dist2 = (entry->x - x)*(entry->x - x) + (entry->y - y)*(entry->y - y) + (entry->z - z)*(entry->z - z);
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
        PreparedStatement* stmt = WorldDatabase.GetPreparedStatement(WORLD_INS_GRAVEYARD_ZONE);

        stmt->setUInt32(0, id);
        stmt->setUInt32(1, zoneId);
        // Xinef: DB Data compatibility...
        stmt->setUInt16(2, uint16(teamId == TEAM_NEUTRAL ? 0 : (teamId == TEAM_ALLIANCE ? ALLIANCE : HORDE)));

        WorldDatabase.Execute(stmt);
    }

    return true;
}

void Graveyard::RemoveGraveyardLink(uint32 id, uint32 zoneId, TeamId teamId, bool persist /*= false*/)
{
    GraveyardMapBoundsNonConst range = GraveyardStore.equal_range(zoneId);
    if (range.first == range.second)
    {
        sLog->outError("Table `graveyard_zone` incomplete: Zone %u Team %u does not have a linked graveyard.", zoneId, teamId);
        return;
    }

    bool found = false;

    for (; range.first != range.second; ++range.first)
    {
        GraveyardData & data = range.first->second;

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
        PreparedStatement* stmt = WorldDatabase.GetPreparedStatement(WORLD_DEL_GRAVEYARD_ZONE);

        stmt->setUInt32(0, id);
        stmt->setUInt32(1, zoneId);
        // Xinef: DB Data compatibility...
        stmt->setUInt16(2, uint16(teamId == TEAM_NEUTRAL ? 0 : (teamId == TEAM_ALLIANCE ? ALLIANCE : HORDE)));

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
        sLog->outString(">> Loaded 0 graveyard-zone links. DB table `graveyard_zone` is empty.");
        sLog->outString();
        return;
    }

    uint32 count = 0;

    do
    {
        ++count;

        Field* fields = result->Fetch();

        uint32 safeLocId = fields[0].GetUInt32();
        uint32 zoneId = fields[1].GetUInt32();
        uint32 team = fields[2].GetUInt16();
        TeamId teamId = team == 0 ? TEAM_NEUTRAL : (team == ALLIANCE ? TEAM_ALLIANCE : TEAM_HORDE);

        GraveyardStruct const* entry = sGraveyard->GetGraveyard(safeLocId);
        if (!entry)
        {
            sLog->outErrorDb("Table `graveyard_zone` has a record for not existing `game_graveyard` table %u, skipped.", safeLocId);
            continue;
        }

        AreaTableEntry const* areaEntry = sAreaTableStore.LookupEntry(zoneId);
        if (!areaEntry)
        {
            sLog->outErrorDb("Table `graveyard_zone` has a record for not existing zone id (%u), skipped.", zoneId);
            continue;
        }

        if (areaEntry->zone != 0)
        {
            sLog->outErrorDb("Table `graveyard_zone` has a record for subzone id (%u) instead of zone, skipped.", zoneId);
            continue;
        }

        if (team != 0 && team != HORDE && team != ALLIANCE)
        {
            sLog->outErrorDb("Table `graveyard_zone` has a record for non player faction (%u), skipped.", team);
            continue;
        }

        if (!AddGraveyardLink(safeLocId, zoneId, teamId, false))
            sLog->outErrorDb("Table `graveyard_zone` has a duplicate record for Graveyard (ID: %u) and Zone (ID: %u), skipped.", safeLocId, zoneId);

    } while (result->NextRow());

    sLog->outString(">> Loaded %u graveyard-zone links in %u ms", count, GetMSTimeDiffToNow(oldMSTime));
    sLog->outString();
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
        else if (alt == NULL && itr->second.wnameLow.find(wname) != std::wstring::npos)
            alt = &itr->second;
    }

    return alt;
}

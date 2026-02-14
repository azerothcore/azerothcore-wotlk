/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify it under
 * the terms of the GNU General Public License as published by the Free Software
 * Foundation; either version 2 of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License along with
 * this program. If not, see <http://www.gnu.org/licenses/>.
 */

#ifndef TEST_MAP_H
#define TEST_MAP_H

#include "Map.h"
#include "DBCStructure.h"

/**
 * TestMap - A minimal test harness for Map.
 *
 * Since Map has a complex constructor requiring MapEntry from DBC,
 * this creates a fake MapEntry to control IsRaid()/IsDungeon() behavior.
 *
 * Usage:
 *   TestMap* map = new TestMap();
 *   map->SetIsRaid(true);  // Make this a raid map
 */
class TestMap : public Map
{
public:
    TestMap();
    ~TestMap() override;

    // Must be called before constructing TestMap to insert fake DBC entry
    // and initialize script registries
    static void EnsureDBC();

    // Control map type for testing
    void SetMapType(uint32 type) { _fakeMapEntry.map_type = type; }
    void SetIsRaid(bool val) { _fakeMapEntry.map_type = val ? MAP_RAID : MAP_COMMON; }
    void SetIsDungeon(bool val) { _fakeMapEntry.map_type = val ? MAP_INSTANCE : MAP_COMMON; }

private:
    MapEntry _fakeMapEntry;
};

#endif // TEST_MAP_H

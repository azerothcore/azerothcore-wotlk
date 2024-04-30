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

#ifndef _SCRIPT_OBJECT_H_
#define _SCRIPT_OBJECT_H_

#include "DatabaseEnvFwd.h"
#include "ScriptObjectFwd.h"
#include <string_view>

//#include "Duration.h"
//#include "LFG.h"
//#include "ObjectGuid.h"
//#include "SharedDefines.h"
//#include "Tuples.h"
//#include "Types.h"

 // Check out our guide on how to create new hooks in our wiki! https://www.azerothcore.org/wiki/hooks-script
 /*
     TODO: Add more script type classes.

     SessionScript
     CollisionScript
     ArenaTeamScript
 */

constexpr auto VISIBLE_RANGE = 166.0f; //MAX visible range (size of grid)

class ScriptObject
{
    friend class ScriptMgr;

public:
    // Do not override this in scripts; it should be overridden by the various script type classes. It indicates
    // whether or not this script type must be assigned in the database.
    [[nodiscard]] virtual bool IsDatabaseBound() const { return false; }
    [[nodiscard]] virtual bool isAfterLoadScript() const { return IsDatabaseBound(); }
    virtual void checkValidity() { }

    [[nodiscard]] const std::string& GetName() const { return _name; }

    [[nodiscard]] uint16 GetTotalAvailableHooks() { return _totalAvailableHooks; }

protected:
    ScriptObject(const char* name, uint16 totalAvailableHooks = 0) : _name(std::string(name)), _totalAvailableHooks(totalAvailableHooks)
    {
    }

    virtual ~ScriptObject() = default;

private:
    const std::string _name;
    const uint16 _totalAvailableHooks;
};

template<class TObject>
class UpdatableScript
{
protected:
    UpdatableScript() = default;

public:
    virtual void OnUpdate(TObject* /*obj*/, uint32 /*diff*/) { }
};

template<class TMap>
class MapScript : public UpdatableScript<TMap>
{
    MapEntry const* _mapEntry;
    uint32 _mapId;

protected:
    explicit MapScript(uint32 mapId) : _mapId(mapId) { }

public:
    void checkMap();

    // Gets the MapEntry structure associated with this script. Can return nullptr.
    MapEntry const* GetEntry() { return _mapEntry; }

    // Called when the map is created.
    virtual void OnCreate(TMap* /*map*/) { }

    // Called just before the map is destroyed.
    virtual void OnDestroy(TMap* /*map*/) { }

    // Called when a grid map is loaded.
    virtual void OnLoadGridMap(TMap* /*map*/, GridMap* /*gmap*/, uint32 /*gx*/, uint32 /*gy*/) { }

    // Called when a grid map is unloaded.
    virtual void OnUnloadGridMap(TMap* /*map*/, GridMap* /*gmap*/, uint32 /*gx*/, uint32 /*gy*/)  { }

    // Called when a player enters the map.
    virtual void OnPlayerEnter(TMap* /*map*/, Player* /*player*/) { }

    // Called when a player leaves the map.
    virtual void OnPlayerLeave(TMap* /*map*/, Player* /*player*/) { }

    // Called on every map update tick.
    void OnUpdate(TMap* /*map*/, uint32 /*diff*/) override { }
};

#endif //_SCRIPT_OBJECT_H_

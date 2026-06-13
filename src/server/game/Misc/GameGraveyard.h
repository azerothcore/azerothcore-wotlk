/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#ifndef _GAMEGRAVEYARD_H_
#define _GAMEGRAVEYARD_H_

#include "Player.h"
#include "SharedDefines.h"
#include <map>
#include <unordered_map>

struct GraveyardStruct
{
    uint32 ID;
    uint32 Map;
    float x;
    float y;
    float z;
    std::string name;
    std::wstring wnameLow;
};

struct GraveyardData
{
    uint32 safeLocId;
    TeamId teamId;

    [[nodiscard]] bool IsNeutralOrFriendlyToTeam(TeamId playerTeamId) const { return teamId == TEAM_NEUTRAL || playerTeamId == TEAM_NEUTRAL || teamId == playerTeamId; }
};

typedef std::multimap<uint32, GraveyardData> WGGraveyardContainer;
typedef std::pair<WGGraveyardContainer::const_iterator, WGGraveyardContainer::const_iterator> GraveyardMapBounds;
typedef std::pair<WGGraveyardContainer::iterator, WGGraveyardContainer::iterator> GraveyardMapBoundsNonConst;

class Graveyard
{
public:
    static Graveyard* instance();

    typedef std::unordered_map<uint32, GraveyardStruct> GraveyardContainer;

    GraveyardStruct const* GetGraveyard(uint32 ID) const;
    GraveyardStruct const* GetGraveyard(const std::string& name) const;
    GraveyardStruct const* GetDefaultGraveyard(TeamId teamId);
    GraveyardStruct const* GetClosestGraveyard(Player* player, TeamId teamId, bool nearCorpse = false);
    GraveyardData const* FindGraveyardData(uint32 id, uint32 zone);
    GraveyardContainer const& GetGraveyardData() const { return _graveyardStore; }
    bool AddGraveyardLink(uint32 id, uint32 zoneId, TeamId teamId, bool persist = true);
    void RemoveGraveyardLink(uint32 id, uint32 zoneId, TeamId teamId, bool persist = false);
    void LoadGraveyardZones();
    void LoadGraveyardFromDB();

private:
    GraveyardContainer _graveyardStore;

    // for wintergrasp only
    WGGraveyardContainer GraveyardStore;
};

#define sGraveyard Graveyard::instance()

#endif // _GAMEGRAVEYARD_H_

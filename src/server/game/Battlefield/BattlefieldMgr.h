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

#ifndef BATTLEFIELD_MGR_H_
#define BATTLEFIELD_MGR_H_

#include "Battlefield.h"

class Player;
class GameObject;
class Creature;
class ZoneScript;
struct GossipMenuItems;

// class to handle player enter / leave / areatrigger / GO use events
class BattlefieldMgr
{
public:
    BattlefieldMgr();
    ~BattlefieldMgr();

    static BattlefieldMgr* instance();

    // create battlefield events
    void InitBattlefield();
    // called when a player enters a battlefield area
    void HandlePlayerEnterZone(Player* player, uint32 areaflag);
    // called when player leaves a battlefield area
    void HandlePlayerLeaveZone(Player* player, uint32 areaflag);
    // called when player resurrects
    void HandlePlayerResurrects(Player* player, uint32 areaflag);
    // return assigned battlefield
    Battlefield* GetBattlefieldToZoneId(uint32 zoneId);
    Battlefield* GetBattlefieldByBattleId(uint32 battleId);

    ZoneScript* GetZoneScript(uint32 zoneId);

    void AddZone(uint32 zoneId, Battlefield* handle);

    void Update(uint32 diff);

    void HandleGossipOption(Player* player, ObjectGuid guid, uint32 gossipId);

    bool CanTalkTo(Player* player, Creature* creature, GossipMenuItems gso);

    void HandleDropFlag(Player* player, uint32 spellId);

    using BattlefieldSet = std::vector<Battlefield*>;
    using BattlefieldMap = std::map<uint32 /* zoneid */, Battlefield*>;

private:
    // contains all initiated battlefield events
    // used when initing / cleaning up
    BattlefieldSet _battlefieldSet;
    // maps the zone ids to a battlefield event
    // used in player event handling
    BattlefieldMap _battlefieldMap;
    // update interval
    uint32 _updateTimer;
};

#define sBattlefieldMgr BattlefieldMgr::instance()

#endif

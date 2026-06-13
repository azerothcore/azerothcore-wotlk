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

#ifndef OUTDOOR_PVP_ZM_
#define OUTDOOR_PVP_ZM_

#include "Language.h"
#include "OutdoorPvP.h"

const uint8 OutdoorPvPZMBuffZonesNum = 5;

// the buff is cast in these zones
const uint32 OutdoorPvPZMBuffZones[OutdoorPvPZMBuffZonesNum] =
{
    AREA_ZANGARMARSH,
    AREA_SERPENTSHRINE_CAVERN,
    AREA_THE_SLAVE_PENS,
    AREA_THE_STEAMVAULT,
    AREA_THE_UNDERBOG
};

// linked when the central tower is controlled
const uint32 ZM_GRAVEYARD_ZONE = AREA_ZANGARMARSH;

// linked when the central tower is controlled
const uint32 ZM_GRAVEYARD_ID = 969;

enum OutdoorPvPZMSpells
{
    // cast on the players of the controlling faction
    ZM_CAPTURE_BUFF = 33779,  // twin spire blessing
    // spell that the field scout casts on the player to carry the flag
    ZM_BATTLE_STANDARD_A = 32430,
    // spell that the field scout casts on the player to carry the flag
    ZM_BATTLE_STANDARD_H = 32431,
    // token create spell
    ZM_AlliancePlayerKillReward = 32155,
    // token create spell
    ZM_HordePlayerKillReward = 32158
};

// banners 182527, 182528, 182529, gotta check them ingame
const go_type ZM_Banner_A = { 182527, MAP_OUTLAND, 253.54f, 7083.81f, 36.7728f, -0.017453f, 0.0f, 0.0f, 0.008727f, -0.999962f };
const go_type ZM_Banner_H = { 182528, MAP_OUTLAND, 253.54f, 7083.81f, 36.7728f, -0.017453f, 0.0f, 0.0f, 0.008727f, -0.999962f };
const go_type ZM_Banner_N = { 182529, MAP_OUTLAND, 253.54f, 7083.81f, 36.7728f, -0.017453f, 0.0f, 0.0f, 0.008727f, -0.999962f };

// horde field scout spawn data
const creature_type ZM_HordeFieldScout = {18564, MAP_OUTLAND, 296.625f, 7818.4f, 42.6294f, 5.18363f};

// alliance field scout spawn data
const creature_type ZM_AllianceFieldScout = {18581, MAP_OUTLAND, 374.395f, 6230.08f, 22.8351f, 0.593412f};

enum ZMCreatureTypes
{
    ZM_ALLIANCE_FIELD_SCOUT = 0,
    ZM_HORDE_FIELD_SCOUT,
    ZM_CREATURE_NUM
};

struct zm_beacon
{
    uint32 slider_disp;
    uint32 slider_n;
    uint32 slider_pos;
    uint32 ui_tower_n;
    uint32 ui_tower_h;
    uint32 ui_tower_a;
    uint32 map_tower_n;
    uint32 map_tower_h;
    uint32 map_tower_a;
    uint32 event_enter;
    uint32 event_leave;
};

enum ZM_BeaconType
{
    ZM_BEACON_EAST = 0,
    ZM_BEACON_WEST,
    ZM_NUM_BEACONS
};

const zm_beacon ZMBeaconInfo[ZM_NUM_BEACONS] =
{
    {2533, 2535, 2534, 2560, 2559, 2558, 2652, 2651, 2650, 11807, 11806},
    {2527, 2529, 2528, 2557, 2556, 2555, 2646, 2645, 2644, 11805, 11804}
};

const uint32 ZMBeaconCaptureA[ZM_NUM_BEACONS] =
{
    LANG_OPVP_ZM_CAPTURE_EAST_A,
    LANG_OPVP_ZM_CAPTURE_WEST_A
};

const uint32 ZMBeaconCaptureH[ZM_NUM_BEACONS] =
{
    LANG_OPVP_ZM_CAPTURE_EAST_H,
    LANG_OPVP_ZM_CAPTURE_WEST_H
};

const uint32 ZMBeaconLoseA[ZM_NUM_BEACONS] =
{
    LANG_OPVP_ZM_LOSE_EAST_A,
    LANG_OPVP_ZM_LOSE_WEST_A
};

const uint32 ZMBeaconLoseH[ZM_NUM_BEACONS] =
{
    LANG_OPVP_ZM_LOSE_EAST_H,
    LANG_OPVP_ZM_LOSE_WEST_H
};

const go_type ZMCapturePoints[ZM_NUM_BEACONS] =
{
    {182523, MAP_OUTLAND, 303.243f, 6841.36f, 40.1245f, -1.58825f, 0.0f, 0.0f, 0.71325f, -0.700909f},
    {182522, MAP_OUTLAND, 336.466f, 7340.26f, 41.4984f, -1.58825f, 0.0f, 0.0f, 0.71325f, -0.700909f}
};

enum ZM_TowerStateMask
{
    ZM_TOWERSTATE_N = 1,
    ZM_TOWERSTATE_A = 2,
    ZM_TOWERSTATE_H = 4
};

class OutdoorPvPZM;

class OPvPCapturePointZM_Beacon : public OPvPCapturePoint
{
public:
    OPvPCapturePointZM_Beacon(OutdoorPvP* pvp, ZM_BeaconType type);

    void ChangeState() override;

    void SendChangePhase() override;

    void FillInitialWorldStates(WorldPackets::WorldState::InitWorldStates& packet) override;

    // used when player is activated/inactivated in the area
    bool HandlePlayerEnter(Player* player) override;
    void HandlePlayerLeave(Player* player) override;

    void UpdateTowerState();

protected:
    ZM_BeaconType m_TowerType;
    uint32 m_TowerState;
};

enum Zm_GraveyardState
{
    ZM_GRAVEYARD_N = 1,
    ZM_GRAVEYARD_A = 2,
    ZM_GRAVEYARD_H = 4
};

class OPvPCapturePointZM_Graveyard : public OPvPCapturePoint
{
public:
    OPvPCapturePointZM_Graveyard(OutdoorPvP* pvp);

    bool Update(uint32 diff) override;

    void ChangeState() override {}

    void FillInitialWorldStates(WorldPackets::WorldState::InitWorldStates& packet) override;

    void UpdateTowerState();

    int32 HandleOpenGo(Player* player, GameObject* go) override;

    void SetBeaconState(TeamId controlling_teamId); // not good atm

    bool HandleGossipOption(Player* player, Creature* creature, uint32 gossipid) override;

    bool HandleDropFlag(Player* player, uint32 spellId) override;

    bool CanTalkTo(Player* player, Creature* creature, GossipMenuItems const& gso) override;

    uint32 GetGraveyardState() const;

private:
    uint32 m_GraveyardState;

protected:
    TeamId m_BothControllingFactionId;
    ObjectGuid m_FlagCarrierGUID;
};

class OutdoorPvPZM : public OutdoorPvP
{
public:
    OutdoorPvPZM();

    bool SetupOutdoorPvP() override;

    void HandlePlayerEnterZone(Player* player, uint32 zone) override;
    void HandlePlayerLeaveZone(Player* player, uint32 zone) override;

    bool Update(uint32 diff) override;

    void FillInitialWorldStates(WorldPackets::WorldState::InitWorldStates& packet) override;

    void SendRemoveWorldStates(Player* player) override;

    void HandleKillImpl(Player* player, Unit* killed) override;

    uint32 GetAllianceTowersControlled() const;
    void SetAllianceTowersControlled(uint32 count);

    uint32 GetHordeTowersControlled() const;
    void SetHordeTowersControlled(uint32 count);

private:
    OPvPCapturePointZM_Graveyard* m_Graveyard;

    uint32 m_AllianceTowersControlled;
    uint32 m_HordeTowersControlled;
};

/// @todo: flag carrier death/leave/mount/activitychange should give back the gossip options
#endif

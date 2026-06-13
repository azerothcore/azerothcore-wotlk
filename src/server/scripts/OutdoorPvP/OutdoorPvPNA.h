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

#ifndef OUTDOOR_PVP_NA_
#define OUTDOOR_PVP_NA_

#include "OutdoorPvP.h"

/// @todo: "sometimes" set to neutral

enum OutdoorPvPNASpells
{
    NA_KILL_TOKEN_ALLIANCE = 33005,
    NA_KILL_TOKEN_HORDE = 33004,
    NA_CAPTURE_BUFF = 33795  // strength of the halaani
};

// kill credit for pks
const uint32 NA_CREDIT_MARKER = 24867;

const uint32 NA_GUARDS_MAX = 15;

const uint32 NA_BUFF_ZONE = AREA_NAGRAND;

const uint32 NA_HALAA_GRAVEYARD = 993;

const uint32 NA_HALAA_GRAVEYARD_ZONE = AREA_NAGRAND; // need to add zone id, not area id

const uint32 NA_RESPAWN_TIME = 3600000; // one hour to capture after defeating all guards

const uint32 NA_GUARD_CHECK_TIME = 500; // every half second

const uint32 NA_HALAA_BOMB = 24538; // Item id Bomb throwed in Halaa

const uint32 FLIGHT_NODES_NUM = 4;

// used to access the elements of Horde/AllyControlGOs
enum ControlGOTypes
{
    NA_ROOST_S = 0,
    NA_ROOST_W = 1,
    NA_ROOST_N = 2,
    NA_ROOST_E = 3,

    NA_BOMB_WAGON_S = 4,
    NA_BOMB_WAGON_W = 5,
    NA_BOMB_WAGON_N = 6,
    NA_BOMB_WAGON_E = 7,

    NA_DESTROYED_ROOST_S = 8,
    NA_DESTROYED_ROOST_W = 9,
    NA_DESTROYED_ROOST_N = 10,
    NA_DESTROYED_ROOST_E = 11,

    NA_CONTROL_GO_NUM = 12
};

const uint32 FlightPathStartNodes[FLIGHT_NODES_NUM] = {103, 105, 107, 109};
const uint32 FlightPathEndNodes[FLIGHT_NODES_NUM] = {104, 106, 108, 110};

enum FlightSpellsNA
{
    NA_SPELL_FLY_SOUTH = 32059,
    NA_SPELL_FLY_WEST = 32068,
    NA_SPELL_FLY_NORTH = 32075,
    NA_SPELL_FLY_EAST = 32081
};

//Npc ids from Halaa guards, Ally and Horde
enum HalaaGuardsNA
{
    NA_HALAANI_GUARD_A = 18256,
    NA_HALAANI_GUARD_H = 18192
};

enum HalaaCreaturesSpawn
{
    NA_HALAA_CREATURES = 12, //Quantity of creatures_templates contains HALAA
    NA_HALAA_CREATURE_TEAM_SPAWN = 20, //Number of creatures by team
    NA_HALAA_MAX_CREATURE_SPAWN = 40 //Number of creatures by both teams
};

// spawned when the alliance is attacking, horde is in control
const go_type HordeControlGOs[NA_CONTROL_GO_NUM] =
{
    {182267, MAP_OUTLAND, -1815.8f, 8036.51f, -26.2354f, -2.89725f, 0.0f, 0.0f, 0.992546f, -0.121869f}, //ALLY_ROOST_SOUTH
    {182280, MAP_OUTLAND, -1507.95f, 8132.1f, -19.5585f, -1.3439f, 0.0f, 0.0f, 0.622515f, -0.782608f}, //ALLY_ROOST_WEST
    {182281, MAP_OUTLAND, -1384.52f, 7779.33f, -11.1663f, -0.575959f, 0.0f, 0.0f, 0.284015f, -0.95882f}, //ALLY_ROOST_NORTH
    {182282, MAP_OUTLAND, -1650.11f, 7732.56f, -15.4505f, -2.80998f, 0.0f, 0.0f, 0.986286f, -0.165048f}, //ALLY_ROOST_EAST

    {182222, MAP_OUTLAND, -1825.4022f, 8039.2602f, -26.08f, -2.89725f, 0.0f, 0.0f, 0.992546f, -0.121869f}, //HORDE_BOMB_WAGON_SOUTH
    {182272, MAP_OUTLAND, -1517.44f, 8140.24f, -20.17f, -2.8099f, 0.0f, 0.0f, 0.622515f, -0.782608f}, //HORDE_BOMB_WAGON_WEST
    {182273, MAP_OUTLAND, -1389.53f, 7782.50f, -11.62f, -1.5184f, 0.0f, 0.0f, 0.284015f, -0.95882f}, //HORDE_BOMB_WAGON_NORTH
    {182274, MAP_OUTLAND, -1662.28f, 7735.00f, -15.96f, 1.8845f, 0.0f, 0.0f, 0.986286f, -0.165048f}, //HORDE_BOMB_WAGON_EAST

    {182266, MAP_OUTLAND, -1815.8f, 8036.51f, -26.2354f, -2.89725f, 0.0f, 0.0f, 0.992546f, -0.121869f}, //DESTROYED_ALLY_ROOST_SOUTH
    {182275, MAP_OUTLAND, -1507.95f, 8132.1f, -19.5585f, -1.3439f, 0.0f, 0.0f, 0.622515f, -0.782608f}, //DESTROYED_ALLY_ROOST_WEST
    {182276, MAP_OUTLAND, -1384.52f, 7779.33f, -11.1663f, -0.575959f, 0.0f, 0.0f, 0.284015f, -0.95882f}, //DESTROYED_ALLY_ROOST_NORTH
    {182277, MAP_OUTLAND, -1650.11f, 7732.56f, -15.4505f, -2.80998f, 0.0f, 0.0f, 0.986286f, -0.165048f}  //DESTROYED_ALLY_ROOST_EAST
};

// spawned when the horde is attacking, alliance is in control
const go_type AllianceControlGOs[NA_CONTROL_GO_NUM] =
{
    {182301, MAP_OUTLAND, -1815.8f, 8036.51f, -26.2354f, -2.89725f, 0.0f, 0.0f, 0.992546f, -0.121869f}, //HORDE_ROOST_SOUTH
    {182302, MAP_OUTLAND, -1507.95f, 8132.1f, -19.5585f, -1.3439f, 0.0f, 0.0f, 0.622515f, -0.782608f}, //HORDE_ROOST_WEST
    {182303, MAP_OUTLAND, -1384.52f, 7779.33f, -11.1663f, -0.575959f, 0.0f, 0.0f, 0.284015f, -0.95882f}, //HORDE_ROOST_NORTH
    {182304, MAP_OUTLAND, -1650.11f, 7732.56f, -15.4505f, -2.80998f, 0.0f, 0.0f, 0.986286f, -0.165048f}, //HORDE_ROOST_EAST

    {182305, MAP_OUTLAND, -1825.4022f, 8039.2602f, -26.08f, -2.89725f, 0.0f, 0.0f, 0.992546f, -0.121869f}, //ALLY_BOMB_WAGON_SOUTH
    {182306, MAP_OUTLAND, -1517.44f, 8140.24f, -20.17f, -2.8099f, 0.0f, 0.0f, 0.622515f, -0.782608f}, //ALLY_BOMB_WAGON_WEST
    {182307, MAP_OUTLAND, -1389.53f, 7782.50f, -11.62f, -1.5184f, 0.0f, 0.0f, 0.284015f, -0.95882f}, //ALLY_BOMB_WAGON_NORTH
    {182308, MAP_OUTLAND, -1662.28f, 7735.00f, -15.96f, 1.8845f, 0.0f, 0.0f, 0.986286f, -0.165048f}, //ALLY_BOMB_WAGON_EAST

    {182297, MAP_OUTLAND, -1815.8f, 8036.51f, -26.2354f, -2.89725f, 0.0f, 0.0f, 0.992546f, -0.121869f}, //DESTROYED_HORDE_ROOST_SOUTH
    {182298, MAP_OUTLAND, -1507.95f, 8132.1f, -19.5585f, -1.3439f, 0.0f, 0.0f, 0.622515f, -0.782608f}, //DESTROYED_HORDE_ROOST_WEST
    {182299, MAP_OUTLAND, -1384.52f, 7779.33f, -11.1663f, -0.575959f, 0.0f, 0.0f, 0.284015f, -0.95882f}, //DESTROYED_HORDE_ROOST_NORTH
    {182300, MAP_OUTLAND, -1650.11f, 7732.56f, -15.4505f, -2.80998f, 0.0f, 0.0f, 0.986286f, -0.165048f}  //DESTROYED_HORDE_ROOST_EAST
};

struct HalaaIds
{
    uint32 idPatrol;
};

const HalaaIds PatrolCreatureEntry[NA_HALAA_CREATURES] =
{
    // Horde
    {18192},
    {18816},
    {18821},
    {21474},
    {21484},
    {21483},
    // Ally
    {18256},
    {18817},
    {18822},
    {21485},
    {21487},
    {21488}
};

enum WyvernStates
{
    WYVERN_NEU_HORDE = 1,
    WYVERN_NEU_ALLIANCE = 2,
    WYVERN_HORDE = 4,
    WYVERN_ALLIANCE = 8
};

enum HalaaStates
{
    HALAA_N = 1,
    HALAA_N_A = 2,
    HALAA_A = 4,
    HALAA_N_H = 8,
    HALAA_H = 16
};

typedef std::map<uint32, ObjectGuid::LowType> HalaaNPCS;

class Unit;
class Creature;
class OutdoorPvPNA;

class OPvPCapturePointNA : public OPvPCapturePoint
{
public:
    OPvPCapturePointNA(OutdoorPvP* pvp);

    bool Update(uint32 diff) override;

    void ChangeState() override;

    void SendChangePhase() override;

    void FillInitialWorldStates(WorldPackets::WorldState::InitWorldStates& packet) override;

    // used when player is activated/inactivated in the area
    bool HandlePlayerEnter(Player* player) override;
    void HandlePlayerLeave(Player* player) override;

    bool HandleCustomSpell(Player* player, uint32 spellId, GameObject* go) override;

    int32 HandleOpenGo(Player* player, GameObject* go) override;

    uint32 GetAliveGuardsCount();
    TeamId GetControllingFaction() const;

protected:
    // called when a faction takes control
    void FactionTakeOver(TeamId teamId);

    void DespawnGOs();
    void DespawnCreatures(HalaaNPCS teamNPC);

    void SpawnNPCsForTeam(HalaaNPCS teamNPC);
    void SpawnGOsForTeam(TeamId teamId);

    void UpdateWyvernRoostWorldState(uint32 roost);
    void UpdateHalaaWorldState();
private:
    bool m_capturable;

    uint32 m_GuardsAlive;

    TeamId m_ControllingFaction;

    uint32 m_WyvernStateNorth;
    uint32 m_WyvernStateSouth;
    uint32 m_WyvernStateEast;
    uint32 m_WyvernStateWest;

    uint32 m_HalaaState;

    uint32 m_RespawnTimer;

    uint32 m_GuardCheckTimer;

    bool m_canRecap;
};

class OutdoorPvPNA : public OutdoorPvP
{
public:
    OutdoorPvPNA();

    bool SetupOutdoorPvP() override;

    void HandlePlayerEnterZone(Player* player, uint32 zone) override;
    void HandlePlayerLeaveZone(Player* player, uint32 zone) override;

    bool Update(uint32 diff) override;

    void FillInitialWorldStates(WorldPackets::WorldState::InitWorldStates& packet) override;

    void SendRemoveWorldStates(Player* player) override;

    void HandleKill(Player* killer, Unit* killed) override;

    void HandleKillImpl(Player* player, Unit* killed) override;

    OPvPCapturePointNA* GetCapturePoint() { return m_obj; }

private:
    OPvPCapturePointNA* m_obj;
};

#endif

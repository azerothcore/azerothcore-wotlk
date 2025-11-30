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

#ifndef OUTDOOR_PVP_HP_
#define OUTDOOR_PVP_HP_

#include "OutdoorPvP.h"
#include "WorldStateDefines.h"

#define OutdoorPvPHPBuffZonesNum 6

const uint32 OutdoorPvPHPBuffZones[OutdoorPvPHPBuffZonesNum] =
{
    AREA_HELLFIRE_PENINSULA,
    AREA_HELLFIRE_CITADEL,
    AREA_HELLFIRE_RAMPARTS,
    AREA_THE_BLOOD_FURNACE,
    AREA_THE_SHATTERED_HALLS,
    AREA_MAGTHERIDONS_LAIR
};

enum OutdoorPvPHPSpells
{
    AlliancePlayerKillReward = 32155,
    HordePlayerKillReward = 32158,
    AllianceBuff = 32071,
    HordeBuff = 32049
};

enum OutdoorPvPHPTowerType
{
    HP_TOWER_BROKEN_HILL = 0,
    HP_TOWER_OVERLOOK = 1,
    HP_TOWER_STADIUM = 2,
    HP_TOWER_NUM = 3
};

const uint32 HP_CREDITMARKER[HP_TOWER_NUM] = {19032, 19028, 19029};

//const uint32 HP_CapturePointEvent_Enter[HP_TOWER_NUM] = {11404, 11396, 11388};

//const uint32 HP_CapturePointEvent_Leave[HP_TOWER_NUM] = {11403, 11395, 11387};

const uint32 HP_MAP_N[HP_TOWER_NUM] = {WORLD_STATE_OPVP_HP_BROKENHILL_N, WORLD_STATE_OPVP_HP_OVERLOOK_N, WORLD_STATE_OPVP_HP_STADIUM_N };

const uint32 HP_MAP_A[HP_TOWER_NUM] = {WORLD_STATE_OPVP_HP_BROKENHILL_A, WORLD_STATE_OPVP_HP_OVERLOOK_A, WORLD_STATE_OPVP_HP_STADIUM_A };

const uint32 HP_MAP_H[HP_TOWER_NUM] = {WORLD_STATE_OPVP_HP_BROKENHILL_H, WORLD_STATE_OPVP_HP_OVERLOOK_H, WORLD_STATE_OPVP_HP_STADIUM_H };

const uint32 HP_TowerArtKit_A[HP_TOWER_NUM] = {65, 62, 67};

const uint32 HP_TowerArtKit_H[HP_TOWER_NUM] = {64, 61, 68};

const uint32 HP_TowerArtKit_N[HP_TOWER_NUM] = {66, 63, 69};

const go_type HPCapturePoints[HP_TOWER_NUM] =
{
    {182175, MAP_OUTLAND, -471.462f, 3451.09f, 34.6432f, 0.174533f, 0.0f, 0.0f, 0.087156f, 0.996195f},      // 0 - Broken Hill
    {182174, MAP_OUTLAND, -184.889f, 3476.93f, 38.205f, -0.017453f, 0.0f, 0.0f, 0.008727f, -0.999962f},     // 1 - Overlook
    {182173, MAP_OUTLAND, -290.016f, 3702.42f, 56.6729f, 0.034907f, 0.0f, 0.0f, 0.017452f, 0.999848f}     // 2 - Stadium
};

const go_type HPTowerFlags[HP_TOWER_NUM] =
{
    {183514, MAP_OUTLAND, -467.078f, 3528.17f, 64.7121f, 3.14159f, 0.0f, 0.0f, 1.0f, 0.0f},  // 0 broken hill
    {182525, MAP_OUTLAND, -187.887f, 3459.38f, 60.0403f, -3.12414f, 0.0f, 0.0f, 0.999962f, -0.008727f}, // 1 overlook
    {183515, MAP_OUTLAND, -289.610f, 3696.83f, 75.9447f, 3.12414f, 0.0f, 0.0f, 0.999962f, 0.008727f} // 2 stadium
};

class OPvPCapturePointHP : public OPvPCapturePoint
{
public:
    OPvPCapturePointHP(OutdoorPvP* pvp, OutdoorPvPHPTowerType type);

    void ChangeState() override;

    void SendChangePhase() override;

    void FillInitialWorldStates(WorldPackets::WorldState::InitWorldStates& packet) override;

    // used when player is activated/inactivated in the area
    bool HandlePlayerEnter(Player* player) override;
    void HandlePlayerLeave(Player* player) override;

private:
    OutdoorPvPHPTowerType m_TowerType;
};

class OutdoorPvPHP : public OutdoorPvP
{
public:
    OutdoorPvPHP();

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
    // how many towers are controlled
    uint32 m_AllianceTowersControlled;
    uint32 m_HordeTowersControlled;
};

#endif

/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: http://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "BattlegroundEY.h"
#include "ObjectMgr.h"
#include "World.h"
#include "WorldPacket.h"
#include "BattlegroundMgr.h"
#include "Creature.h"
#include "Language.h"
#include "Object.h"
#include "Player.h"
#include "Util.h"
#include "WorldSession.h"
#include "GameGraveyard.h"

BattlegroundEY::BattlegroundEY()
{
    m_BuffChange = true;
    BgObjects.resize(BG_EY_OBJECT_MAX);
    BgCreatures.resize(BG_EY_CREATURES_MAX);

    _capturePointInfo[POINT_FEL_REAVER]._areaTrigger = AT_FEL_REAVER_BUFF;
    _capturePointInfo[POINT_BLOOD_ELF]._areaTrigger = AT_BLOOD_ELF_BUFF;
    _capturePointInfo[POINT_DRAENEI_RUINS]._areaTrigger = AT_DRAENEI_RUINS_BUFF;
    _capturePointInfo[POINT_MAGE_TOWER]._areaTrigger = AT_MAGE_TOWER_BUFF;
    _honorTics = 0;
    _ownedPointsCount[TEAM_ALLIANCE] = 0;
    _ownedPointsCount[TEAM_HORDE] = 0;
    _flagKeeperGUID = 0;
    _droppedFlagGUID = 0;
    _flagState = BG_EY_FLAG_STATE_ON_BASE;
    _flagCapturedObject = 0;

    StartMessageIds[BG_STARTING_EVENT_FIRST]  = LANG_BG_EY_START_TWO_MINUTES;
    StartMessageIds[BG_STARTING_EVENT_SECOND] = LANG_BG_EY_START_ONE_MINUTE;
    StartMessageIds[BG_STARTING_EVENT_THIRD]  = LANG_BG_EY_START_HALF_MINUTE;
    StartMessageIds[BG_STARTING_EVENT_FOURTH] = LANG_BG_EY_HAS_BEGUN;
}

BattlegroundEY::~BattlegroundEY()
{
}

void BattlegroundEY::PostUpdateImpl(uint32 diff)
{
    if (GetStatus() == STATUS_IN_PROGRESS)
    {
        _bgEvents.Update(diff);
        while (uint32 eventId = _bgEvents.ExecuteEvent())
            switch (eventId)
            {
                case BG_EY_EVENT_ADD_POINTS:
                    if (_ownedPointsCount[TEAM_ALLIANCE] > 0)
                        AddPoints(TEAM_ALLIANCE, BG_EY_TickPoints[_ownedPointsCount[TEAM_ALLIANCE] - 1]);
                    if (_ownedPointsCount[TEAM_HORDE] > 0)
                        AddPoints(TEAM_HORDE, BG_EY_TickPoints[_ownedPointsCount[TEAM_HORDE] - 1]);
                    _bgEvents.ScheduleEvent(BG_EY_EVENT_ADD_POINTS, BG_EY_FPOINTS_TICK_TIME - (World::GetGameTimeMS() % BG_EY_FPOINTS_TICK_TIME));
                    break;
                case BG_EY_EVENT_FLAG_ON_GROUND:
                    RespawnFlagAfterDrop();
                    break;
                case BG_EY_EVENT_RESPAWN_FLAG:
                    RespawnFlag();
                    break;
                case BG_EY_EVENT_CHECK_CPOINTS:
                    UpdatePointsState();
                    _bgEvents.ScheduleEvent(BG_EY_EVENT_CHECK_CPOINTS, BG_EY_FPOINTS_CHECK_TIME - (World::GetGameTimeMS() % BG_EY_FPOINTS_CHECK_TIME));
                    break;
            }
    }
}

void BattlegroundEY::StartingEventCloseDoors()
{
    SpawnBGObject(BG_EY_OBJECT_DOOR_A, RESPAWN_IMMEDIATELY);
    SpawnBGObject(BG_EY_OBJECT_DOOR_H, RESPAWN_IMMEDIATELY);

    for (uint32 i = BG_EY_OBJECT_A_BANNER_FEL_REAVER_CENTER; i < BG_EY_OBJECT_MAX; ++i)
        SpawnBGObject(i, RESPAWN_ONE_DAY);
}

void BattlegroundEY::StartingEventOpenDoors()
{
    SpawnBGObject(BG_EY_OBJECT_DOOR_A, RESPAWN_ONE_DAY);
    SpawnBGObject(BG_EY_OBJECT_DOOR_H, RESPAWN_ONE_DAY);

    for (uint32 i = BG_EY_OBJECT_N_BANNER_FEL_REAVER_CENTER; i <= BG_EY_OBJECT_FLAG_NETHERSTORM; ++i)
        SpawnBGObject(i, RESPAWN_IMMEDIATELY);

    for (uint32 i = 0; i < EY_POINTS_MAX; ++i)
        SpawnBGObject(BG_EY_OBJECT_SPEEDBUFF_FEL_REAVER + i*3 + urand(0, 2), RESPAWN_IMMEDIATELY);

    // Achievement: Flurry
    StartTimedAchievement(ACHIEVEMENT_TIMED_TYPE_EVENT, BG_EY_EVENT_START_BATTLE);
    _bgEvents.ScheduleEvent(BG_EY_EVENT_ADD_POINTS, 0);
    _bgEvents.ScheduleEvent(BG_EY_EVENT_CHECK_CPOINTS, 0);
}

void BattlegroundEY::AddPoints(TeamId teamId, uint32 points)
{
    uint8 honorRewards = uint8(m_TeamScores[teamId] / _honorTics);
    m_TeamScores[teamId] += points;

    for (; honorRewards < uint8(m_TeamScores[teamId] / _honorTics); ++honorRewards)
        RewardHonorToTeam(GetBonusHonorFromKill(1), teamId);

    UpdateWorldState(teamId == TEAM_ALLIANCE ? EY_ALLIANCE_RESOURCES : EY_HORDE_RESOURCES, std::min<uint32>(m_TeamScores[teamId], BG_EY_MAX_TEAM_SCORE));
    if (m_TeamScores[teamId] >= BG_EY_MAX_TEAM_SCORE)
        EndBattleground(teamId);
}

void BattlegroundEY::UpdatePointsState()
{
    std::vector<GameObject*> pointsVec;
    for (uint8 point = 0; point < EY_POINTS_MAX; ++point)
    {
        pointsVec.push_back(GetBGObject(BG_EY_OBJECT_TOWER_CAP_FEL_REAVER + point));
        _capturePointInfo[point]._playersCount[TEAM_ALLIANCE] = 0;
        _capturePointInfo[point]._playersCount[TEAM_HORDE] = 0;
    }

    const BattlegroundPlayerMap& bgPlayerMap = GetPlayers();
    for (BattlegroundPlayerMap::const_iterator itr = bgPlayerMap.begin(); itr != bgPlayerMap.end(); ++itr)
    {
        UpdateWorldStateForPlayer(PROGRESS_BAR_SHOW, BG_EY_PROGRESS_BAR_DONT_SHOW, itr->second);
        for (uint8 point = 0; point < EY_POINTS_MAX; ++point)
            if (GameObject* pointObject = pointsVec[point])
                if (itr->second->CanCaptureTowerPoint() && itr->second->IsWithinDistInMap(pointObject, BG_EY_POINT_RADIUS))
                {
                    UpdateWorldStateForPlayer(PROGRESS_BAR_SHOW, BG_EY_PROGRESS_BAR_SHOW, itr->second);
                    UpdateWorldStateForPlayer(PROGRESS_BAR_PERCENT_GREY, BG_EY_PROGRESS_BAR_PERCENT_GREY, itr->second);
                    UpdateWorldStateForPlayer(PROGRESS_BAR_STATUS, _capturePointInfo[point]._barStatus, itr->second);
                    ++_capturePointInfo[point]._playersCount[itr->second->GetTeamId()];

                    // Xinef: ugly hax... area trigger is no longer called by client...
                    if (pointObject->GetEntry() == BG_OBJECT_FR_TOWER_CAP_EY_ENTRY && itr->second->GetDistance2d(2043.96f, 1729.68f) < 3.0f)
                        HandleAreaTrigger(itr->second, AT_FEL_REAVER_POINT);
                }
    }

    for (uint8 point = 0; point < EY_POINTS_MAX; ++point)
    {
        _capturePointInfo[point]._barStatus += std::max<int8>(std::min<int8>(_capturePointInfo[point]._playersCount[TEAM_ALLIANCE] - _capturePointInfo[point]._playersCount[TEAM_HORDE], BG_EY_POINT_MAX_CAPTURERS_COUNT), -BG_EY_POINT_MAX_CAPTURERS_COUNT);
        _capturePointInfo[point]._barStatus = std::max<int8>(std::min<int8>(_capturePointInfo[point]._barStatus, BG_EY_PROGRESS_BAR_ALI_CONTROLLED), BG_EY_PROGRESS_BAR_HORDE_CONTROLLED);

        TeamId pointOwnerTeamId = TEAM_NEUTRAL;
        if (_capturePointInfo[point]._barStatus <= BG_EY_PROGRESS_BAR_NEUTRAL_LOW)
            pointOwnerTeamId = TEAM_HORDE;
        else if (_capturePointInfo[point]._barStatus >= BG_EY_PROGRESS_BAR_NEUTRAL_HIGH)
            pointOwnerTeamId = TEAM_ALLIANCE;
        
        if (pointOwnerTeamId != _capturePointInfo[point]._ownerTeamId)
        {
            if (_capturePointInfo[point].IsUncontrolled())
                EventTeamCapturedPoint(pointOwnerTeamId, point);

            if (pointOwnerTeamId == TEAM_NEUTRAL && _capturePointInfo[point].IsUnderControl())
                EventTeamLostPoint(pointOwnerTeamId, point);
        }
    }
}

void BattlegroundEY::EndBattleground(TeamId winnerTeamId)
{
    RewardHonorToTeam(GetBonusHonorFromKill(1), winnerTeamId);
    RewardHonorToTeam(GetBonusHonorFromKill(1), TEAM_ALLIANCE);
    RewardHonorToTeam(GetBonusHonorFromKill(1), TEAM_HORDE);
    Battleground::EndBattleground(winnerTeamId);
}

void BattlegroundEY::UpdatePointsCount()
{
    UpdateWorldState(EY_ALLIANCE_BASE, _ownedPointsCount[TEAM_ALLIANCE]);
    UpdateWorldState(EY_HORDE_BASE, _ownedPointsCount[TEAM_HORDE]);
}

void BattlegroundEY::UpdatePointsIcons(uint32 point)
{
    if (_capturePointInfo[point].IsUnderControl())
    {
        UpdateWorldState(m_PointsIconStruct[point].WorldStateControlIndex, 0);
        UpdateWorldState(m_PointsIconStruct[point].WorldStateAllianceControlledIndex, _capturePointInfo[point].IsUnderControl(TEAM_ALLIANCE));
        UpdateWorldState(m_PointsIconStruct[point].WorldStateHordeControlledIndex, _capturePointInfo[point].IsUnderControl(TEAM_HORDE));
    }
    else
    {
        UpdateWorldState(m_PointsIconStruct[point].WorldStateAllianceControlledIndex, 0);
        UpdateWorldState(m_PointsIconStruct[point].WorldStateHordeControlledIndex, 0);
        UpdateWorldState(m_PointsIconStruct[point].WorldStateControlIndex, 1);
    }
}

void BattlegroundEY::AddPlayer(Player* player)
{
    Battleground::AddPlayer(player);
    PlayerScores[player->GetGUID()] = new BattlegroundEYScore(player);
}

void BattlegroundEY::RemovePlayer(Player* player)
{
    if (GetFlagPickerGUID() == player->GetGUID())
        EventPlayerDroppedFlag(player);
}

void BattlegroundEY::HandleAreaTrigger(Player* player, uint32 trigger)
{
    if (GetStatus() != STATUS_IN_PROGRESS || !player->IsAlive())
        return;

    switch (trigger)
    {
        case AT_BLOOD_ELF_POINT:
            if (_capturePointInfo[POINT_BLOOD_ELF].IsUnderControl(player->GetTeamId()))
                if (_flagState == BG_EY_FLAG_STATE_ON_PLAYER && GetFlagPickerGUID() == player->GetGUID())
                    EventPlayerCapturedFlag(player, BG_EY_OBJECT_FLAG_BLOOD_ELF);
            break;
        case AT_FEL_REAVER_POINT:
            if (_capturePointInfo[POINT_FEL_REAVER].IsUnderControl(player->GetTeamId()))
                if (_flagState == BG_EY_FLAG_STATE_ON_PLAYER && GetFlagPickerGUID() == player->GetGUID())
                    EventPlayerCapturedFlag(player, BG_EY_OBJECT_FLAG_FEL_REAVER);
            break;
        case AT_MAGE_TOWER_POINT:
            if (_capturePointInfo[POINT_MAGE_TOWER].IsUnderControl(player->GetTeamId()))
                if (_flagState == BG_EY_FLAG_STATE_ON_PLAYER && GetFlagPickerGUID() == player->GetGUID())
                    EventPlayerCapturedFlag(player, BG_EY_OBJECT_FLAG_MAGE_TOWER);
            break;
        case AT_DRAENEI_RUINS_POINT:
            if (_capturePointInfo[POINT_DRAENEI_RUINS].IsUnderControl(player->GetTeamId()))
                if (_flagState == BG_EY_FLAG_STATE_ON_PLAYER && GetFlagPickerGUID() == player->GetGUID())
                    EventPlayerCapturedFlag(player, BG_EY_OBJECT_FLAG_DRAENEI_RUINS);
            break;
        case 4512:
        case 4515:
        case 4517:
        case 4519:
        case 4530:
        case 4531:
        case 5866:
        case AT_BLOOD_ELF_BUFF:
        case AT_FEL_REAVER_BUFF:
        case AT_MAGE_TOWER_BUFF:
        case AT_DRAENEI_RUINS_BUFF:
            break;
    }
}

bool BattlegroundEY::SetupBattleground()
{
        // doors
    AddObject(BG_EY_OBJECT_DOOR_A, BG_OBJECT_A_DOOR_EY_ENTRY, 2527.6f, 1596.91f, 1262.13f, -3.12414f, -0.173642f, -0.001515f, 0.98477f, -0.008594f, RESPAWN_IMMEDIATELY);
    AddObject(BG_EY_OBJECT_DOOR_H, BG_OBJECT_H_DOOR_EY_ENTRY, 1803.21f, 1539.49f, 1261.09f, 3.14159f, 0.173648f, 0, 0.984808f, 0, RESPAWN_IMMEDIATELY);
        // banners (alliance)
    AddObject(BG_EY_OBJECT_A_BANNER_FEL_REAVER_CENTER, BG_OBJECT_A_BANNER_EY_ENTRY, 2057.46f, 1735.07f, 1187.91f, -0.925024f, 0, 0, 0.446198f, -0.894934f, RESPAWN_ONE_DAY);
    AddObject(BG_EY_OBJECT_A_BANNER_FEL_REAVER_LEFT, BG_OBJECT_A_BANNER_EY_ENTRY, 2032.25f, 1729.53f, 1190.33f, 1.8675f, 0, 0, 0.803857f, 0.594823f, RESPAWN_ONE_DAY);
    AddObject(BG_EY_OBJECT_A_BANNER_FEL_REAVER_RIGHT, BG_OBJECT_A_BANNER_EY_ENTRY, 2092.35f, 1775.46f, 1187.08f, -0.401426f, 0, 0, 0.199368f, -0.979925f, RESPAWN_ONE_DAY);
    AddObject(BG_EY_OBJECT_A_BANNER_BLOOD_ELF_CENTER, BG_OBJECT_A_BANNER_EY_ENTRY, 2047.19f, 1349.19f, 1189.0f, -1.62316f, 0, 0, 0.725374f, -0.688354f, RESPAWN_ONE_DAY);
    AddObject(BG_EY_OBJECT_A_BANNER_BLOOD_ELF_LEFT, BG_OBJECT_A_BANNER_EY_ENTRY, 2074.32f, 1385.78f, 1194.72f, 0.488692f, 0, 0, 0.241922f, 0.970296f, RESPAWN_ONE_DAY);
    AddObject(BG_EY_OBJECT_A_BANNER_BLOOD_ELF_RIGHT, BG_OBJECT_A_BANNER_EY_ENTRY, 2025.13f, 1386.12f, 1192.74f, 2.3911f, 0, 0, 0.930418f, 0.366501f, RESPAWN_ONE_DAY);
    AddObject(BG_EY_OBJECT_A_BANNER_DRAENEI_RUINS_CENTER, BG_OBJECT_A_BANNER_EY_ENTRY, 2276.8f, 1400.41f, 1196.33f, 2.44346f, 0, 0, 0.939693f, 0.34202f, RESPAWN_ONE_DAY);
    AddObject(BG_EY_OBJECT_A_BANNER_DRAENEI_RUINS_LEFT, BG_OBJECT_A_BANNER_EY_ENTRY, 2305.78f, 1404.56f, 1199.38f, 1.74533f, 0, 0, 0.766044f, 0.642788f, RESPAWN_ONE_DAY);
    AddObject(BG_EY_OBJECT_A_BANNER_DRAENEI_RUINS_RIGHT, BG_OBJECT_A_BANNER_EY_ENTRY, 2245.4f, 1366.41f, 1195.28f, 2.21657f, 0, 0, 0.894934f, 0.446198f, RESPAWN_ONE_DAY);
    AddObject(BG_EY_OBJECT_A_BANNER_MAGE_TOWER_CENTER, BG_OBJECT_A_BANNER_EY_ENTRY, 2270.84f, 1784.08f, 1186.76f, 2.42601f, 0, 0, 0.936672f, 0.350207f, RESPAWN_ONE_DAY);
    AddObject(BG_EY_OBJECT_A_BANNER_MAGE_TOWER_LEFT, BG_OBJECT_A_BANNER_EY_ENTRY, 2269.13f, 1737.7f, 1186.66f, 0.994838f, 0, 0, 0.477159f, 0.878817f, RESPAWN_ONE_DAY);
    AddObject(BG_EY_OBJECT_A_BANNER_MAGE_TOWER_RIGHT, BG_OBJECT_A_BANNER_EY_ENTRY, 2300.86f, 1741.25f, 1187.7f, -0.785398f, 0, 0, 0.382683f, -0.92388f, RESPAWN_ONE_DAY);
        // banners (horde)
    AddObject(BG_EY_OBJECT_H_BANNER_FEL_REAVER_CENTER, BG_OBJECT_H_BANNER_EY_ENTRY, 2057.46f, 1735.07f, 1187.91f, -0.925024f, 0, 0, 0.446198f, -0.894934f, RESPAWN_ONE_DAY);
    AddObject(BG_EY_OBJECT_H_BANNER_FEL_REAVER_LEFT, BG_OBJECT_H_BANNER_EY_ENTRY, 2032.25f, 1729.53f, 1190.33f, 1.8675f, 0, 0, 0.803857f, 0.594823f, RESPAWN_ONE_DAY);
    AddObject(BG_EY_OBJECT_H_BANNER_FEL_REAVER_RIGHT, BG_OBJECT_H_BANNER_EY_ENTRY, 2092.35f, 1775.46f, 1187.08f, -0.401426f, 0, 0, 0.199368f, -0.979925f, RESPAWN_ONE_DAY);
    AddObject(BG_EY_OBJECT_H_BANNER_BLOOD_ELF_CENTER, BG_OBJECT_H_BANNER_EY_ENTRY, 2047.19f, 1349.19f, 1189.0f, -1.62316f, 0, 0, 0.725374f, -0.688354f, RESPAWN_ONE_DAY);
    AddObject(BG_EY_OBJECT_H_BANNER_BLOOD_ELF_LEFT, BG_OBJECT_H_BANNER_EY_ENTRY, 2074.32f, 1385.78f, 1194.72f, 0.488692f, 0, 0, 0.241922f, 0.970296f, RESPAWN_ONE_DAY);
    AddObject(BG_EY_OBJECT_H_BANNER_BLOOD_ELF_RIGHT, BG_OBJECT_H_BANNER_EY_ENTRY, 2025.13f, 1386.12f, 1192.74f, 2.3911f, 0, 0, 0.930418f, 0.366501f, RESPAWN_ONE_DAY);
    AddObject(BG_EY_OBJECT_H_BANNER_DRAENEI_RUINS_CENTER, BG_OBJECT_H_BANNER_EY_ENTRY, 2276.8f, 1400.41f, 1196.33f, 2.44346f, 0, 0, 0.939693f, 0.34202f, RESPAWN_ONE_DAY);
    AddObject(BG_EY_OBJECT_H_BANNER_DRAENEI_RUINS_LEFT, BG_OBJECT_H_BANNER_EY_ENTRY, 2305.78f, 1404.56f, 1199.38f, 1.74533f, 0, 0, 0.766044f, 0.642788f, RESPAWN_ONE_DAY);
    AddObject(BG_EY_OBJECT_H_BANNER_DRAENEI_RUINS_RIGHT, BG_OBJECT_H_BANNER_EY_ENTRY, 2245.4f, 1366.41f, 1195.28f, 2.21657f, 0, 0, 0.894934f, 0.446198f, RESPAWN_ONE_DAY);
    AddObject(BG_EY_OBJECT_H_BANNER_MAGE_TOWER_CENTER, BG_OBJECT_H_BANNER_EY_ENTRY, 2270.84f, 1784.08f, 1186.76f, 2.42601f, 0, 0, 0.936672f, 0.350207f, RESPAWN_ONE_DAY);
    AddObject(BG_EY_OBJECT_H_BANNER_MAGE_TOWER_LEFT, BG_OBJECT_H_BANNER_EY_ENTRY, 2269.13f, 1737.7f, 1186.66f, 0.994838f, 0, 0, 0.477159f, 0.878817f, RESPAWN_ONE_DAY);
    AddObject(BG_EY_OBJECT_H_BANNER_MAGE_TOWER_RIGHT, BG_OBJECT_H_BANNER_EY_ENTRY, 2300.86f, 1741.25f, 1187.7f, -0.785398f, 0, 0, 0.382683f, -0.92388f, RESPAWN_ONE_DAY);
        // banners (natural)
    AddObject(BG_EY_OBJECT_N_BANNER_FEL_REAVER_CENTER, BG_OBJECT_N_BANNER_EY_ENTRY, 2057.46f, 1735.07f, 1187.91f, -0.925024f, 0, 0, 0.446198f, -0.894934f, RESPAWN_ONE_DAY);
    AddObject(BG_EY_OBJECT_N_BANNER_FEL_REAVER_LEFT, BG_OBJECT_N_BANNER_EY_ENTRY, 2032.25f, 1729.53f, 1190.33f, 1.8675f, 0, 0, 0.803857f, 0.594823f, RESPAWN_ONE_DAY);
    AddObject(BG_EY_OBJECT_N_BANNER_FEL_REAVER_RIGHT, BG_OBJECT_N_BANNER_EY_ENTRY, 2092.35f, 1775.46f, 1187.08f, -0.401426f, 0, 0, 0.199368f, -0.979925f, RESPAWN_ONE_DAY);
    AddObject(BG_EY_OBJECT_N_BANNER_BLOOD_ELF_CENTER, BG_OBJECT_N_BANNER_EY_ENTRY, 2047.19f, 1349.19f, 1189.0f, -1.62316f, 0, 0, 0.725374f, -0.688354f, RESPAWN_ONE_DAY);
    AddObject(BG_EY_OBJECT_N_BANNER_BLOOD_ELF_LEFT, BG_OBJECT_N_BANNER_EY_ENTRY, 2074.32f, 1385.78f, 1194.72f, 0.488692f, 0, 0, 0.241922f, 0.970296f, RESPAWN_ONE_DAY);
    AddObject(BG_EY_OBJECT_N_BANNER_BLOOD_ELF_RIGHT, BG_OBJECT_N_BANNER_EY_ENTRY, 2025.13f, 1386.12f, 1192.74f, 2.3911f, 0, 0, 0.930418f, 0.366501f, RESPAWN_ONE_DAY);
    AddObject(BG_EY_OBJECT_N_BANNER_DRAENEI_RUINS_CENTER, BG_OBJECT_N_BANNER_EY_ENTRY, 2276.8f, 1400.41f, 1196.33f, 2.44346f, 0, 0, 0.939693f, 0.34202f, RESPAWN_ONE_DAY);
    AddObject(BG_EY_OBJECT_N_BANNER_DRAENEI_RUINS_LEFT, BG_OBJECT_N_BANNER_EY_ENTRY, 2305.78f, 1404.56f, 1199.38f, 1.74533f, 0, 0, 0.766044f, 0.642788f, RESPAWN_ONE_DAY);
    AddObject(BG_EY_OBJECT_N_BANNER_DRAENEI_RUINS_RIGHT, BG_OBJECT_N_BANNER_EY_ENTRY, 2245.4f, 1366.41f, 1195.28f, 2.21657f, 0, 0, 0.894934f, 0.446198f, RESPAWN_ONE_DAY);
    AddObject(BG_EY_OBJECT_N_BANNER_MAGE_TOWER_CENTER, BG_OBJECT_N_BANNER_EY_ENTRY, 2270.84f, 1784.08f, 1186.76f, 2.42601f, 0, 0, 0.936672f, 0.350207f, RESPAWN_ONE_DAY);
    AddObject(BG_EY_OBJECT_N_BANNER_MAGE_TOWER_LEFT, BG_OBJECT_N_BANNER_EY_ENTRY, 2269.13f, 1737.7f, 1186.66f, 0.994838f, 0, 0, 0.477159f, 0.878817f, RESPAWN_ONE_DAY);
    AddObject(BG_EY_OBJECT_N_BANNER_MAGE_TOWER_RIGHT, BG_OBJECT_N_BANNER_EY_ENTRY, 2300.86f, 1741.25f, 1187.7f, -0.785398f, 0, 0, 0.382683f, -0.92388f, RESPAWN_ONE_DAY);
        // flags
    AddObject(BG_EY_OBJECT_FLAG_NETHERSTORM, BG_OBJECT_FLAG2_EY_ENTRY, 2174.782227f, 1569.054688f, 1160.361938f, -1.448624f, 0, 0, 0.662620f, -0.748956f, RESPAWN_ONE_DAY);
    AddObject(BG_EY_OBJECT_FLAG_FEL_REAVER, BG_OBJECT_FLAG1_EY_ENTRY, 2044.28f, 1729.68f, 1189.96f, -0.017453f, 0, 0, 0.008727f, -0.999962f, RESPAWN_ONE_DAY);
    AddObject(BG_EY_OBJECT_FLAG_BLOOD_ELF, BG_OBJECT_FLAG1_EY_ENTRY, 2048.83f, 1393.65f, 1194.49f, 0.20944f, 0, 0, 0.104528f, 0.994522f, RESPAWN_ONE_DAY);
    AddObject(BG_EY_OBJECT_FLAG_DRAENEI_RUINS, BG_OBJECT_FLAG1_EY_ENTRY, 2286.56f, 1402.36f, 1197.11f, 3.72381f, 0, 0, 0.957926f, -0.287016f, RESPAWN_ONE_DAY);
    AddObject(BG_EY_OBJECT_FLAG_MAGE_TOWER, BG_OBJECT_FLAG1_EY_ENTRY, 2284.48f, 1731.23f, 1189.99f, 2.89725f, 0, 0, 0.992546f, 0.121869f, RESPAWN_ONE_DAY);
        // tower cap
    AddObject(BG_EY_OBJECT_TOWER_CAP_FEL_REAVER, BG_OBJECT_FR_TOWER_CAP_EY_ENTRY, 2024.600708f, 1742.819580f, 1195.157715f, 2.443461f, 0, 0, 0.939693f, 0.342020f, RESPAWN_ONE_DAY);
    AddObject(BG_EY_OBJECT_TOWER_CAP_BLOOD_ELF, BG_OBJECT_BE_TOWER_CAP_EY_ENTRY, 2050.493164f, 1372.235962f, 1194.563477f, 1.710423f, 0, 0, 0.754710f, 0.656059f, RESPAWN_ONE_DAY);
    AddObject(BG_EY_OBJECT_TOWER_CAP_DRAENEI_RUINS, BG_OBJECT_DR_TOWER_CAP_EY_ENTRY, 2301.010498f, 1386.931641f, 1197.183472f, 1.570796f, 0, 0, 0.707107f, 0.707107f, RESPAWN_ONE_DAY);
    AddObject(BG_EY_OBJECT_TOWER_CAP_MAGE_TOWER, BG_OBJECT_HU_TOWER_CAP_EY_ENTRY, 2282.121582f, 1760.006958f, 1189.707153f, 1.919862f, 0, 0, 0.819152f, 0.573576f, RESPAWN_ONE_DAY);

    for (uint8 i = 0; i < EY_POINTS_MAX; ++i)
    {
        AreaTrigger const* at = sObjectMgr->GetAreaTrigger(_capturePointInfo[i]._areaTrigger);
        AddObject(BG_EY_OBJECT_SPEEDBUFF_FEL_REAVER + i * 3 + 0, Buff_Entries[0], at->x, at->y, at->z, 0.907571f, 0, 0, 0.438371f, 0.898794f, RESPAWN_ONE_DAY);
        AddObject(BG_EY_OBJECT_SPEEDBUFF_FEL_REAVER + i * 3 + 1, Buff_Entries[1], at->x, at->y, at->z, 0.907571f, 0, 0, 0.438371f, 0.898794f, RESPAWN_ONE_DAY);
        AddObject(BG_EY_OBJECT_SPEEDBUFF_FEL_REAVER + i * 3 + 2, Buff_Entries[2], at->x, at->y, at->z, 0.907571f, 0, 0, 0.438371f, 0.898794f, RESPAWN_ONE_DAY);
    }

    GraveyardStruct const* sg = NULL;
    sg = sGraveyard->GetGraveyard(BG_EY_GRAVEYARD_MAIN_ALLIANCE);
    AddSpiritGuide(BG_EY_SPIRIT_MAIN_ALLIANCE, sg->x, sg->y, sg->z, 3.124139f, TEAM_ALLIANCE);

    sg = sGraveyard->GetGraveyard(BG_EY_GRAVEYARD_MAIN_HORDE);
    AddSpiritGuide(BG_EY_SPIRIT_MAIN_HORDE, sg->x, sg->y, sg->z, 3.193953f, TEAM_HORDE);

    for (uint32 i = BG_EY_OBJECT_DOOR_A; i < BG_EY_OBJECT_MAX; ++i)
        if (BgObjects[i] == 0)
        {
            sLog->outErrorDb("BatteGroundEY: Failed to spawn some object Battleground not created!");
            return false;
        }

    for (uint32 i = BG_EY_SPIRIT_MAIN_ALLIANCE; i <= BG_EY_SPIRIT_MAIN_HORDE; ++i)
        if (BgCreatures[i] == 0)
        {
            sLog->outErrorDb("BatteGroundEY: Failed to spawn spirit guides Battleground not created!");
            return false;
        }

    return true;
}

void BattlegroundEY::Init()
{
    //call parent's class reset
    Battleground::Init();

    _bgEvents.Reset();
    _honorTics = BattlegroundMgr::IsBGWeekend(GetBgTypeID(true)) ? BG_EY_HONOR_TICK_WEEKEND : BG_EY_HONOR_TICK_NORMAL;
    _ownedPointsCount[TEAM_ALLIANCE] = 0;
    _ownedPointsCount[TEAM_HORDE] = 0;
    _flagKeeperGUID = 0;
    _droppedFlagGUID = 0;
    _flagState = BG_EY_FLAG_STATE_ON_BASE;
    _flagCapturedObject = 0;
}

void BattlegroundEY::RespawnFlag()
{
    if (_flagState != BG_EY_FLAG_STATE_ON_BASE)
        return;

    if (_flagCapturedObject > 0)
        SpawnBGObject(_flagCapturedObject, RESPAWN_ONE_DAY);

    _flagCapturedObject = 0;
    SpawnBGObject(BG_EY_OBJECT_FLAG_NETHERSTORM, RESPAWN_IMMEDIATELY);

    SendMessageToAll(LANG_BG_EY_RESETED_FLAG, CHAT_MSG_BG_SYSTEM_NEUTRAL);
    PlaySoundToAll(BG_EY_SOUND_FLAG_RESET);
    UpdateWorldState(NETHERSTORM_FLAG, 1);
}

void BattlegroundEY::RespawnFlagAfterDrop()
{
    if (_flagState != BG_EY_FLAG_STATE_ON_GROUND)
        return;

    _flagState = BG_EY_FLAG_STATE_ON_BASE;
    RespawnFlag();
    if (GameObject* flag = ObjectAccessor::GetObjectInMap(GetDroppedFlagGUID(), FindBgMap(), (GameObject*)NULL))
        flag->Delete();
    SetDroppedFlagGUID(0);
}

void BattlegroundEY::HandleKillPlayer(Player* player, Player* killer)
{
    if (GetStatus() != STATUS_IN_PROGRESS)
        return;

    Battleground::HandleKillPlayer(player, killer);
    EventPlayerDroppedFlag(player);
}

void BattlegroundEY::EventPlayerDroppedFlag(Player* player)
{
    if (GetFlagPickerGUID() != player->GetGUID())
        return;

    SetFlagPicker(0);
    player->RemoveAurasDueToSpell(BG_EY_NETHERSTORM_FLAG_SPELL);
    if (GetStatus() != STATUS_IN_PROGRESS)
        return;

    _flagState = BG_EY_FLAG_STATE_ON_GROUND;
    _bgEvents.RescheduleEvent(BG_EY_EVENT_FLAG_ON_GROUND, BG_EY_FLAG_ON_GROUND_TIME);

    player->CastSpell(player, SPELL_RECENTLY_DROPPED_FLAG, true);
    player->CastSpell(player, BG_EY_PLAYER_DROPPED_FLAG_SPELL, true);

    SendMessageToAll(LANG_BG_EY_DROPPED_FLAG, player->GetTeamId() == TEAM_ALLIANCE ? CHAT_MSG_BG_SYSTEM_ALLIANCE : CHAT_MSG_BG_SYSTEM_HORDE);
}

void BattlegroundEY::EventPlayerClickedOnFlag(Player* player, GameObject* gameObject)
{
    if (GetStatus() != STATUS_IN_PROGRESS || GetFlagPickerGUID() || !player->IsWithinDistInMap(gameObject, 10.0f))
        return;

    _flagState = BG_EY_FLAG_STATE_ON_PLAYER;
    SpawnBGObject(BG_EY_OBJECT_FLAG_NETHERSTORM, RESPAWN_ONE_DAY);
    SetFlagPicker(player->GetGUID());
    SetDroppedFlagGUID(0);

    player->CastSpell(player, BG_EY_NETHERSTORM_FLAG_SPELL, true);
    player->RemoveAurasWithInterruptFlags(AURA_INTERRUPT_FLAG_ENTER_PVP_COMBAT);

    PSendMessageToAll(LANG_BG_EY_HAS_TAKEN_FLAG, player->GetTeamId() == TEAM_ALLIANCE ? CHAT_MSG_BG_SYSTEM_ALLIANCE : CHAT_MSG_BG_SYSTEM_HORDE, NULL, player->GetName().c_str());
    PlaySoundToAll(player->GetTeamId() == TEAM_ALLIANCE ? BG_EY_SOUND_FLAG_PICKED_UP_ALLIANCE : BG_EY_SOUND_FLAG_PICKED_UP_HORDE);
    UpdateWorldState(NETHERSTORM_FLAG, 0);
}

void BattlegroundEY::EventTeamLostPoint(TeamId  /*teamId*/, uint32 point)
{
    TeamId oldTeamId = _capturePointInfo[point]._ownerTeamId;
    if (oldTeamId == TEAM_ALLIANCE)
    {
        _ownedPointsCount[TEAM_ALLIANCE]--;
        SpawnBGObject(m_LosingPointTypes[point].DespawnObjectTypeAlliance, RESPAWN_ONE_DAY);
        SpawnBGObject(m_LosingPointTypes[point].DespawnObjectTypeAlliance + 1, RESPAWN_ONE_DAY);
        SpawnBGObject(m_LosingPointTypes[point].DespawnObjectTypeAlliance + 2, RESPAWN_ONE_DAY);
        SendMessageToAll(m_LosingPointTypes[point].MessageIdAlliance, CHAT_MSG_BG_SYSTEM_ALLIANCE);
    }
    else
    {
        _ownedPointsCount[TEAM_HORDE]--;
        SpawnBGObject(m_LosingPointTypes[point].DespawnObjectTypeHorde, RESPAWN_ONE_DAY);
        SpawnBGObject(m_LosingPointTypes[point].DespawnObjectTypeHorde + 1, RESPAWN_ONE_DAY);
        SpawnBGObject(m_LosingPointTypes[point].DespawnObjectTypeHorde + 2, RESPAWN_ONE_DAY);
        SendMessageToAll(m_LosingPointTypes[point].MessageIdHorde, CHAT_MSG_BG_SYSTEM_HORDE);
    }

    SpawnBGObject(m_LosingPointTypes[point].SpawnNeutralObjectType, RESPAWN_IMMEDIATELY);
    SpawnBGObject(m_LosingPointTypes[point].SpawnNeutralObjectType + 1, RESPAWN_IMMEDIATELY);
    SpawnBGObject(m_LosingPointTypes[point].SpawnNeutralObjectType + 2, RESPAWN_IMMEDIATELY);

    _capturePointInfo[point]._ownerTeamId = TEAM_NEUTRAL;

    UpdatePointsIcons(point);
    UpdatePointsCount();
    DelCreature(BG_EY_TRIGGER_FEL_REAVER + point);
}

void BattlegroundEY::EventTeamCapturedPoint(TeamId teamId, uint32 point)
{
    SpawnBGObject(m_CapturingPointTypes[point].DespawnNeutralObjectType, RESPAWN_ONE_DAY);
    SpawnBGObject(m_CapturingPointTypes[point].DespawnNeutralObjectType + 1, RESPAWN_ONE_DAY);
    SpawnBGObject(m_CapturingPointTypes[point].DespawnNeutralObjectType + 2, RESPAWN_ONE_DAY);

    if (teamId == TEAM_ALLIANCE)
    {
        _ownedPointsCount[TEAM_ALLIANCE]++;
        SpawnBGObject(m_CapturingPointTypes[point].SpawnObjectTypeAlliance, RESPAWN_IMMEDIATELY);
        SpawnBGObject(m_CapturingPointTypes[point].SpawnObjectTypeAlliance + 1, RESPAWN_IMMEDIATELY);
        SpawnBGObject(m_CapturingPointTypes[point].SpawnObjectTypeAlliance + 2, RESPAWN_IMMEDIATELY);
        SendMessageToAll(m_CapturingPointTypes[point].MessageIdAlliance, CHAT_MSG_BG_SYSTEM_ALLIANCE);
    }
    else
    {
        _ownedPointsCount[TEAM_HORDE]++;
        SpawnBGObject(m_CapturingPointTypes[point].SpawnObjectTypeHorde, RESPAWN_IMMEDIATELY);
        SpawnBGObject(m_CapturingPointTypes[point].SpawnObjectTypeHorde + 1, RESPAWN_IMMEDIATELY);
        SpawnBGObject(m_CapturingPointTypes[point].SpawnObjectTypeHorde + 2, RESPAWN_IMMEDIATELY);
        SendMessageToAll(m_CapturingPointTypes[point].MessageIdHorde, CHAT_MSG_BG_SYSTEM_HORDE);
    }

    _capturePointInfo[point]._ownerTeamId = teamId;
    if (BgCreatures[point])
        DelCreature(point);

    GraveyardStruct const* sg = sGraveyard->GetGraveyard(m_CapturingPointTypes[point].GraveYardId);
    AddSpiritGuide(point, sg->x, sg->y, sg->z, 3.124139f, teamId);

    UpdatePointsIcons(point);
    UpdatePointsCount();

    // Xinef: done this way to avoid errors in console
    Creature* trigger = GetBgMap()->GetCreature(BgCreatures[BG_EY_TRIGGER_FEL_REAVER + point]);
    if (!trigger)
       trigger = AddCreature(WORLD_TRIGGER, BG_EY_TRIGGER_FEL_REAVER + point, BG_EY_TriggerPositions[point][0], BG_EY_TriggerPositions[point][1], BG_EY_TriggerPositions[point][2], BG_EY_TriggerPositions[point][3]);

    if (trigger)
    {
        trigger->setFaction(teamId == TEAM_ALLIANCE ? 84 : 83);
        trigger->CastSpell(trigger, SPELL_HONORABLE_DEFENDER_25Y, true);
    }
}

void BattlegroundEY::EventPlayerCapturedFlag(Player* player, uint32 BgObjectType)
{
    SetFlagPicker(0);
    _flagState = BG_EY_FLAG_STATE_ON_BASE;
    player->RemoveAurasDueToSpell(BG_EY_NETHERSTORM_FLAG_SPELL);
    player->RemoveAurasWithInterruptFlags(AURA_INTERRUPT_FLAG_ENTER_PVP_COMBAT);

    SpawnBGObject(BgObjectType, RESPAWN_IMMEDIATELY);
    _bgEvents.RescheduleEvent(BG_EY_EVENT_RESPAWN_FLAG, BG_EY_FLAG_RESPAWN_TIME);
    _flagCapturedObject = BgObjectType;

    if (player->GetTeamId() == TEAM_ALLIANCE)
    {
        PlaySoundToAll(BG_EY_SOUND_FLAG_CAPTURED_ALLIANCE);
        SendMessageToAll(LANG_BG_EY_CAPTURED_FLAG_A, CHAT_MSG_BG_SYSTEM_ALLIANCE, player);
    }
    else
    {
        PlaySoundToAll(BG_EY_SOUND_FLAG_CAPTURED_HORDE);
        SendMessageToAll(LANG_BG_EY_CAPTURED_FLAG_H, CHAT_MSG_BG_SYSTEM_HORDE, player);
    }

    UpdatePlayerScore(player, SCORE_FLAG_CAPTURES, 1);
    if (_ownedPointsCount[player->GetTeamId()] > 0)
        AddPoints(player->GetTeamId(), BG_EY_FlagPoints[_ownedPointsCount[player->GetTeamId()] - 1]);
}

void BattlegroundEY::UpdatePlayerScore(Player* player, uint32 type, uint32 value, bool doAddHonor)
{
    if (type == SCORE_FLAG_CAPTURES)
    {
        BattlegroundScoreMap::iterator itr = PlayerScores.find(player->GetGUID());
        if (itr != PlayerScores.end())
            ((BattlegroundEYScore*)itr->second)->FlagCaptures += value;
        player->UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_BG_OBJECTIVE_CAPTURE, BG_EY_OBJECTIVE_CAPTURE_FLAG);
        return;
    }

    Battleground::UpdatePlayerScore(player, type, value, doAddHonor);
}

void BattlegroundEY::FillInitialWorldStates(WorldPacket& data)
{
    data << uint32(EY_HORDE_BASE)                   << uint32(_ownedPointsCount[TEAM_HORDE]);
    data << uint32(EY_ALLIANCE_BASE)                << uint32(_ownedPointsCount[TEAM_ALLIANCE]);
    data << uint32(DRAENEI_RUINS_HORDE_CONTROL)     << uint32(_capturePointInfo[POINT_DRAENEI_RUINS].IsUnderControl(TEAM_HORDE));
    data << uint32(DRAENEI_RUINS_ALLIANCE_CONTROL)  << uint32(_capturePointInfo[POINT_DRAENEI_RUINS].IsUnderControl(TEAM_ALLIANCE));
    data << uint32(DRAENEI_RUINS_UNCONTROL)         << uint32(_capturePointInfo[POINT_DRAENEI_RUINS].IsUncontrolled());
    data << uint32(MAGE_TOWER_ALLIANCE_CONTROL)     << uint32(_capturePointInfo[POINT_MAGE_TOWER].IsUnderControl(TEAM_HORDE));
    data << uint32(MAGE_TOWER_HORDE_CONTROL)        << uint32(_capturePointInfo[POINT_MAGE_TOWER].IsUnderControl(TEAM_ALLIANCE));
    data << uint32(MAGE_TOWER_UNCONTROL)            << uint32(_capturePointInfo[POINT_MAGE_TOWER].IsUncontrolled());
    data << uint32(FEL_REAVER_HORDE_CONTROL)        << uint32(_capturePointInfo[POINT_FEL_REAVER].IsUnderControl(TEAM_HORDE));
    data << uint32(FEL_REAVER_ALLIANCE_CONTROL)     << uint32(_capturePointInfo[POINT_FEL_REAVER].IsUnderControl(TEAM_ALLIANCE));
    data << uint32(FEL_REAVER_UNCONTROL)            << uint32(_capturePointInfo[POINT_FEL_REAVER].IsUncontrolled());
    data << uint32(BLOOD_ELF_HORDE_CONTROL)         << uint32(_capturePointInfo[POINT_BLOOD_ELF].IsUnderControl(TEAM_HORDE));
    data << uint32(BLOOD_ELF_ALLIANCE_CONTROL)      << uint32(_capturePointInfo[POINT_BLOOD_ELF].IsUnderControl(TEAM_ALLIANCE));
    data << uint32(BLOOD_ELF_UNCONTROL)             << uint32(_capturePointInfo[POINT_BLOOD_ELF].IsUncontrolled());
    data << uint32(NETHERSTORM_FLAG)                << uint32(_flagState == BG_EY_FLAG_STATE_ON_BASE);
    data << uint32(NETHERSTORM_FLAG_STATE_HORDE)    << uint32(1);
    data << uint32(NETHERSTORM_FLAG_STATE_ALLIANCE) << uint32(1);
    data << uint32(EY_HORDE_RESOURCES)              << uint32(GetTeamScore(TEAM_HORDE));
    data << uint32(EY_ALLIANCE_RESOURCES)           << uint32(GetTeamScore(TEAM_ALLIANCE));
    data << uint32(PROGRESS_BAR_SHOW)               << uint32(0);
    data << uint32(PROGRESS_BAR_PERCENT_GREY)       << uint32(0);
    data << uint32(PROGRESS_BAR_STATUS)             << uint32(0);
}

GraveyardStruct const* BattlegroundEY::GetClosestGraveyard(Player* player)
{
    GraveyardStruct const* entry = sGraveyard->GetGraveyard(BG_EY_GRAVEYARD_MAIN_ALLIANCE + player->GetTeamId());
    GraveyardStruct const* nearestEntry = entry;

    float pX = player->GetPositionX();
    float pY = player->GetPositionY();
    float pZ = player->GetPositionZ();
    float dist = (entry->x - pX)*(entry->x - pX) + (entry->y - pY)*(entry->y - pY) + (entry->z - pZ)*(entry->z - pZ);
    float minDist = dist;

    for (uint8 i = 0; i < EY_POINTS_MAX; ++i)
        if (_capturePointInfo[i].IsUnderControl(player->GetTeamId()))
        {
            entry = sGraveyard->GetGraveyard(m_CapturingPointTypes[i].GraveYardId);
            dist = (entry->x - pX)*(entry->x - pX) + (entry->y - pY)*(entry->y - pY) + (entry->z - pZ)*(entry->z - pZ);
            if (dist < minDist)
            {
                minDist = dist;
                nearestEntry = entry;
            }
        }

    return nearestEntry;
}

bool BattlegroundEY::AllNodesConrolledByTeam(TeamId teamId) const
{
    uint32 count = 0;
    for (uint8 i = 0; i < EY_POINTS_MAX; ++i)
        if (_capturePointInfo[i].IsUnderControl(teamId))
            ++count;

    return count == EY_POINTS_MAX;
}

TeamId BattlegroundEY::GetPrematureWinner()
{
    if (GetTeamScore(TEAM_ALLIANCE) > GetTeamScore(TEAM_HORDE))
        return TEAM_ALLIANCE;

    return GetTeamScore(TEAM_HORDE) > GetTeamScore(TEAM_ALLIANCE) ? TEAM_HORDE : Battleground::GetPrematureWinner();
}

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

#include "BattlegroundMgr.h"
#include "ArenaTeam.h"
#include "ArenaTeamMgr.h"
#include "BattlegroundAB.h"
#include "BattlegroundAV.h"
#include "BattlegroundBE.h"
#include "BattlegroundDS.h"
#include "BattlegroundEY.h"
#include "BattlegroundIC.h"
#include "BattlegroundNA.h"
#include "BattlegroundQueue.h"
#include "BattlegroundRL.h"
#include "BattlegroundRV.h"
#include "BattlegroundSA.h"
#include "BattlegroundWS.h"
#include "Chat.h"
#include "Common.h"
#include "DisableMgr.h"
#include "Formulas.h"
#include "GameEventMgr.h"
#include "GameGraveyard.h"
#include "GameTime.h"
#include "Map.h"
#include "MapMgr.h"
#include "ObjectMgr.h"
#include "Opcodes.h"
#include "Player.h"
#include "SharedDefines.h"
#include "World.h"
#include "WorldPacket.h"
#include <unordered_map>

/*********************************************************/
/***            BATTLEGROUND MANAGER                   ***/
/*********************************************************/

BattlegroundMgr::BattlegroundMgr() : m_ArenaTesting(false), m_Testing(false),
    m_lastClientVisibleInstanceId(0), m_NextAutoDistributionTime(0), m_AutoDistributionTimeChecker(0), m_NextPeriodicQueueUpdateTime(5 * IN_MILLISECONDS)
{
    for (uint32 qtype = BATTLEGROUND_QUEUE_NONE; qtype < MAX_BATTLEGROUND_QUEUE_TYPES; ++qtype)
        m_BattlegroundQueues[qtype].SetBgTypeIdAndArenaType(BGTemplateId(BattlegroundQueueTypeId(qtype)), BGArenaType(BattlegroundQueueTypeId(qtype)));
}

BattlegroundMgr::~BattlegroundMgr()
{
    DeleteAllBattlegrounds();
}

BattlegroundMgr* BattlegroundMgr::instance()
{
    static BattlegroundMgr instance;
    return &instance;
}

void BattlegroundMgr::DeleteAllBattlegrounds()
{
    while (!m_Battlegrounds.empty())
        delete m_Battlegrounds.begin()->second;
    m_Battlegrounds.clear();

    while (!m_BattlegroundTemplates.empty())
        delete m_BattlegroundTemplates.begin()->second;
    m_BattlegroundTemplates.clear();
}

// used to update running battlegrounds, and delete finished ones
void BattlegroundMgr::Update(uint32 diff)
{
    // update all battlegrounds and delete if needed
    for (BattlegroundContainer::iterator itr = m_Battlegrounds.begin(), itrDelete; itr != m_Battlegrounds.end(); )
    {
        itrDelete = itr++;
        Battleground* bg = itrDelete->second;
        bg->Update(diff);
        if (bg->ToBeDeleted())
        {
            itrDelete->second = nullptr;
            m_Battlegrounds.erase(itrDelete);
            delete bg;
        }
    }

    // update events
    for (int qtype = BATTLEGROUND_QUEUE_NONE; qtype < MAX_BATTLEGROUND_QUEUE_TYPES; ++qtype)
        m_BattlegroundQueues[qtype].UpdateEvents(diff);

    // update using scheduled tasks (used only for rated arenas, initial opponent search works differently than periodic queue update)
    if (!m_ArenaQueueUpdateScheduler.empty())
    {
        std::vector<uint64> scheduled;
        std::swap(scheduled, m_ArenaQueueUpdateScheduler);
        for (uint8 i = 0; i < scheduled.size(); i++)
        {
            uint32 arenaRatedTeamId = scheduled[i] >> 32;
            BattlegroundQueueTypeId bgQueueTypeId = BattlegroundQueueTypeId(scheduled[i] >> 16 & 255);
            BattlegroundBracketId bracket_id = BattlegroundBracketId(scheduled[i] & 255);
            m_BattlegroundQueues[bgQueueTypeId].BattlegroundQueueUpdate(diff, bracket_id, true, arenaRatedTeamId); // pussywizard: looking for opponents only for this team
        }
    }

    // periodic queue update
    if (m_NextPeriodicQueueUpdateTime < diff)
    {
        m_NextPeriodicQueueUpdateTime = 5 * IN_MILLISECONDS;

        // for rated arenas
        for (uint32 qtype = BATTLEGROUND_QUEUE_2v2; qtype < MAX_BATTLEGROUND_QUEUE_TYPES; ++qtype)
            for (uint32 bracket = BG_BRACKET_ID_FIRST; bracket < MAX_BATTLEGROUND_BRACKETS; ++bracket)
                m_BattlegroundQueues[qtype].BattlegroundQueueUpdate(m_NextPeriodicQueueUpdateTime, BattlegroundBracketId(bracket), true, 0); // pussywizard: 0 for rated means looking for opponents for every team

        // for battlegrounds and not rated arenas
        // in first loop try to fill already running battlegrounds, then in a second loop try to create new battlegrounds
        for (uint32 qtype = BATTLEGROUND_QUEUE_AV; qtype < MAX_BATTLEGROUND_QUEUE_TYPES; ++qtype)
            for (uint32 bracket = BG_BRACKET_ID_FIRST; bracket < MAX_BATTLEGROUND_BRACKETS; ++bracket)
                m_BattlegroundQueues[qtype].BattlegroundQueueUpdate(m_NextPeriodicQueueUpdateTime, BattlegroundBracketId(bracket), false, 0);
    }
    else
        m_NextPeriodicQueueUpdateTime -= diff;

    // arena points auto-distribution
    if (sWorld->getBoolConfig(CONFIG_ARENA_AUTO_DISTRIBUTE_POINTS))
    {
        if (m_AutoDistributionTimeChecker < diff)
        {
            if (GameTime::GetGameTime() > m_NextAutoDistributionTime)
            {
                sArenaTeamMgr->DistributeArenaPoints();
                m_NextAutoDistributionTime = m_NextAutoDistributionTime + 1_days * sWorld->getIntConfig(CONFIG_ARENA_AUTO_DISTRIBUTE_INTERVAL_DAYS);
                sWorld->setWorldState(WS_ARENA_DISTRIBUTION_TIME, m_NextAutoDistributionTime.count());
            }
            m_AutoDistributionTimeChecker = 600000; // 10 minutes check
        }
        else
            m_AutoDistributionTimeChecker -= diff;
    }
}

void BattlegroundMgr::BuildBattlegroundStatusPacket(WorldPacket* data, Battleground* bg, uint8 QueueSlot, uint8 StatusID, uint32 Time1, uint32 Time2, uint8 arenatype, TeamId teamId, bool isRated, BattlegroundTypeId forceBgTypeId)
{
    // pussywizard:
    //ASSERT(QueueSlot < PLAYER_MAX_BATTLEGROUND_QUEUES);

    if (StatusID == STATUS_NONE || !bg)
    {
        data->Initialize(SMSG_BATTLEFIELD_STATUS, 4 + 8);
        *data << uint32(QueueSlot);
        *data << uint64(0);
        return;
    }

    data->Initialize(SMSG_BATTLEFIELD_STATUS, (4 + 8 + 1 + 1 + 4 + 1 + 4 + 4 + 4));
    *data << uint32(QueueSlot);
    // The following segment is read as uint64 in client but can be appended as their original type.
    *data << uint8(arenatype);
    *data << uint8(bg->isArena() ? 0xE : 0x0);
    *data << uint32(forceBgTypeId != BATTLEGROUND_TYPE_NONE ? forceBgTypeId : bg->GetBgTypeID());
    *data << uint16(0x1F90);
    // End of uint64 segment, decomposed this way for simplicity
    *data << uint8(bg->GetMinLevel());
    *data << uint8(bg->GetMaxLevel());
    *data << uint32(bg->GetClientInstanceID());

    // following displays the minimap icon. 0 = faction icon, 1 = arenaicon
    *data << uint8(bg->isRated() || isRated); // 1 for rated match, 0 for bg or non rated match

    *data << uint32(StatusID);                                  // status
    switch (StatusID)
    {
        case STATUS_WAIT_QUEUE:                                 // status_in_queue
            *data << uint32(Time1);                             // average wait time, milliseconds
            *data << uint32(Time2);                             // time in queue, updated every minute!, milliseconds
            break;
        case STATUS_WAIT_JOIN:                                  // status_invite
            *data << uint32(bg->GetMapId());                    // map id
            *data << uint64(0);                                 // 3.3.5, unknown
            *data << uint32(Time1);                             // time to remove from queue, milliseconds
            break;
        case STATUS_IN_PROGRESS:                                // status_in_progress
            *data << uint32(bg->GetMapId());                    // map id
            *data << uint64(0);                                 // 3.3.5, unknown
            *data << uint32(Time1);                             // time to bg auto leave, 0 at bg start, 120000 after bg end, milliseconds
            *data << uint32(Time2);                             // time from bg start, milliseconds
            *data << uint8(teamId == TEAM_ALLIANCE ? 1 : 0);   // arenafaction (0 for horde, 1 for alliance)
            break;
        default:
            break;
    }
}

void BattlegroundMgr::BuildGroupJoinedBattlegroundPacket(WorldPacket* data, GroupJoinBattlegroundResult result)
{
    data->Initialize(SMSG_GROUP_JOINED_BATTLEGROUND, 4);
    *data << int32(result);
    if (result == ERR_BATTLEGROUND_JOIN_TIMED_OUT || result == ERR_BATTLEGROUND_JOIN_FAILED)
        *data << uint64(0);                                 // player guid
}

void BattlegroundMgr::BuildPlaySoundPacket(WorldPacket* data, uint32 soundid)
{
    data->Initialize(SMSG_PLAY_SOUND, 4);
    *data << uint32(soundid);
}

void BattlegroundMgr::BuildPlayerLeftBattlegroundPacket(WorldPacket* data, ObjectGuid guid)
{
    data->Initialize(SMSG_BATTLEGROUND_PLAYER_LEFT, 8);
    *data << guid;
}

void BattlegroundMgr::BuildPlayerJoinedBattlegroundPacket(WorldPacket* data, Player* player)
{
    data->Initialize(SMSG_BATTLEGROUND_PLAYER_JOINED, 8);
    *data << player->GetGUID();
}

Battleground* BattlegroundMgr::GetBattleground(uint32 instanceId)
{
    if (!instanceId)
        return nullptr;

    BattlegroundContainer::const_iterator itr = m_Battlegrounds.find(instanceId);
    if (itr != m_Battlegrounds.end())
        return itr->second;

    return nullptr;
}

Battleground* BattlegroundMgr::GetBattlegroundTemplate(BattlegroundTypeId bgTypeId)
{
    BattlegroundTemplateContainer::const_iterator itr = m_BattlegroundTemplates.find(bgTypeId);
    if (itr != m_BattlegroundTemplates.end())
        return itr->second;

    return nullptr;
}

uint32 BattlegroundMgr::GetNextClientVisibleInstanceId()
{
    return ++m_lastClientVisibleInstanceId;
}

// create a new battleground that will really be used to play
Battleground* BattlegroundMgr::CreateNewBattleground(BattlegroundTypeId originalBgTypeId, uint32 minLevel, uint32 maxLevel, uint8 arenaType, bool isRated)
{
    BattlegroundTypeId bgTypeId = GetRandomBG(originalBgTypeId);

    if (originalBgTypeId == BATTLEGROUND_AA)
        originalBgTypeId = bgTypeId;

    // get the template BG
    Battleground* bg_template = GetBattlegroundTemplate(bgTypeId);
    if (!bg_template)
        return nullptr;

    Battleground* bg = nullptr;
    // create a copy of the BG template
    if (BattlegroundMgr::bgTypeToTemplate.find(bgTypeId) == BattlegroundMgr::bgTypeToTemplate.end())
    {
        return nullptr;
    }

    bg = BattlegroundMgr::bgTypeToTemplate[bgTypeId](bg_template);

    bool isRandom = bgTypeId != originalBgTypeId && !bg->isArena();

    bg->SetLevelRange(minLevel, maxLevel);
    bg->SetInstanceID(sMapMgr->GenerateInstanceId());
    bg->SetClientInstanceID(IsArenaType(originalBgTypeId) ? 0 : GetNextClientVisibleInstanceId());
    bg->Init();
    bg->SetStatus(STATUS_WAIT_JOIN); // start the joining of the bg
    bg->SetArenaType(arenaType);
    bg->SetBgTypeID(originalBgTypeId);
    bg->SetRandomTypeID(bgTypeId);
    bg->SetRated(isRated);
    bg->SetRandom(isRandom);

    // Set up correct min/max player counts for scoreboards
    if (bg->isArena())
    {
        uint32 maxPlayersPerTeam = ArenaTeam::GetReqPlayersForType(arenaType) / 2;
        sScriptMgr->OnSetArenaMaxPlayersPerTeam(arenaType, maxPlayersPerTeam);
        bg->SetMaxPlayersPerTeam(maxPlayersPerTeam);
    }

    return bg;
}

// used to create the BG templates
bool BattlegroundMgr::CreateBattleground(CreateBattlegroundData& data)
{
    // Create the BG
    Battleground* bg = nullptr;
    bg = BattlegroundMgr::bgtypeToBattleground[data.bgTypeId];

    if (bg == nullptr)
        return false;

    if (data.bgTypeId == BATTLEGROUND_RB)
        bg->SetRandom(true);

    bg->SetMapId(data.MapID);
    bg->SetBgTypeID(data.bgTypeId);
    bg->SetInstanceID(0);
    bg->SetArenaorBGType(data.IsArena);
    bg->SetMinPlayersPerTeam(data.MinPlayersPerTeam);
    bg->SetMaxPlayersPerTeam(data.MaxPlayersPerTeam);
    bg->SetName(data.BattlegroundName);
    bg->SetTeamStartPosition(TEAM_ALLIANCE, data.StartLocation[TEAM_ALLIANCE]);
    bg->SetTeamStartPosition(TEAM_HORDE, data.StartLocation[TEAM_HORDE]);
    bg->SetStartMaxDist(data.StartMaxDist);
    bg->SetLevelRange(data.LevelMin, data.LevelMax);
    bg->SetScriptId(data.scriptId);

    AddBattleground(bg);

    return true;
}

void BattlegroundMgr::CreateInitialBattlegrounds()
{
    uint32 oldMSTime = getMSTime();

    _battlegroundMapTemplates.clear();
    _battlegroundTemplates.clear();

    //                                               0   1                  2                  3       4       5                 6               7              8            9             10      11
    QueryResult result = WorldDatabase.Query("SELECT ID, MinPlayersPerTeam, MaxPlayersPerTeam, MinLvl, MaxLvl, AllianceStartLoc, AllianceStartO, HordeStartLoc, HordeStartO, StartMaxDist, Weight, ScriptName FROM battleground_template");

    if (!result)
    {
        LOG_ERROR("bg.battleground", ">> Loaded 0 battlegrounds. DB table `battleground_template` is empty.");
        return;
    }

    uint32 count = 0;

    do
    {
        Field* fields = result->Fetch();

        uint32 bgTypeId = fields[0].Get<uint32>();

        if (DisableMgr::IsDisabledFor(DISABLE_TYPE_BATTLEGROUND, bgTypeId, nullptr))
            continue;

        // can be overwrite by values from DB
        BattlemasterListEntry const* bl = sBattlemasterListStore.LookupEntry(bgTypeId);
        if (!bl)
        {
            LOG_ERROR("bg.battleground", "Battleground ID {} not found in BattlemasterList.dbc. Battleground not created.", bgTypeId);
            continue;
        }

        CreateBattlegroundData data;
        data.bgTypeId = BattlegroundTypeId(bgTypeId);
        data.IsArena = (bl->type == TYPE_ARENA);
        data.MinPlayersPerTeam = fields[1].Get<uint16>();
        data.MaxPlayersPerTeam = fields[2].Get<uint16>();
        data.LevelMin = fields[3].Get<uint8>();
        data.LevelMax = fields[4].Get<uint8>();
        float dist = fields[9].Get<float>();
        data.StartMaxDist = dist * dist;
        data.Weight = fields[10].Get<uint8>();

        data.scriptId = sObjectMgr->GetScriptId(fields[11].Get<std::string>());
        data.BattlegroundName = bl->name[sWorld->GetDefaultDbcLocale()];
        data.MapID = bl->mapid[0];

        if (data.MaxPlayersPerTeam == 0 || data.MinPlayersPerTeam > data.MaxPlayersPerTeam)
        {
            LOG_ERROR("bg.battleground", "Table `battleground_template` for id {} has bad values for MinPlayersPerTeam ({}) and MaxPlayersPerTeam({})",
                data.bgTypeId, data.MinPlayersPerTeam, data.MaxPlayersPerTeam);
            continue;
        }

        if (data.LevelMin == 0 || data.LevelMax == 0 || data.LevelMin > data.LevelMax)
        {
            LOG_ERROR("bg.battleground", "Table `battleground_template` for id {} has bad values for LevelMin ({}) and LevelMax({})",
                data.bgTypeId, data.LevelMin, data.LevelMax);
            continue;
        }

        if (data.bgTypeId != BATTLEGROUND_AA && data.bgTypeId != BATTLEGROUND_RB)
        {
            uint32 startId = fields[5].Get<uint32>();
            if (GraveyardStruct const* start = sGraveyard->GetGraveyard(startId))
            {
                data.StartLocation[TEAM_ALLIANCE].Relocate(start->x, start->y, start->z, fields[6].Get<float>());
            }
            else
            {
                LOG_ERROR("sql.sql", "Table `battleground_template` for id %u contains a non-existing WorldSafeLocs.dbc id %u in field `AllianceStartLoc`. BG not created.", data.bgTypeId, startId);
                continue;
            }

            startId = fields[7].Get<uint32>();
            if (GraveyardStruct const* start = sGraveyard->GetGraveyard(startId))
            {
                data.StartLocation[TEAM_HORDE].Relocate(start->x, start->y, start->z, fields[8].Get<float>());
            }
            else
            {
                LOG_ERROR("sql.sql", "Table `battleground_template` for id %u contains a non-existing WorldSafeLocs.dbc id %u in field `HordeStartLoc`. BG not created.", data.bgTypeId, startId);
                continue;
            }
        }

        if (!CreateBattleground(data))
            continue;

        _battlegroundTemplates[BattlegroundTypeId(bgTypeId)] = data;

        if (bl->mapid[1] == -1) // in this case we have only one mapId
            _battlegroundMapTemplates[bl->mapid[0]] = &_battlegroundTemplates[BattlegroundTypeId(bgTypeId)];

        ++count;
    } while (result->NextRow());

    LOG_INFO("server.loading", ">> Loaded {} battlegrounds in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
}

void BattlegroundMgr::InitAutomaticArenaPointDistribution()
{
    if (!sWorld->getBoolConfig(CONFIG_ARENA_AUTO_DISTRIBUTE_POINTS))
        return;

    Seconds wstime = Seconds(sWorld->getWorldState(WS_ARENA_DISTRIBUTION_TIME));
    Seconds curtime = GameTime::GetGameTime();

    LOG_INFO("server.loading", "Initializing Automatic Arena Point Distribution");

    if (wstime < curtime)
    {
        m_NextAutoDistributionTime = curtime; // reset will be called in the next update
        LOG_INFO("server.loading", "Next arena point distribution time in the past, reseting it now.");
    }
    else
    {
        m_NextAutoDistributionTime = wstime;
    }

    LOG_INFO("server.loading", "Automatic Arena Point Distribution initialized.");
}

void BattlegroundMgr::BuildBattlegroundListPacket(WorldPacket* data, ObjectGuid guid, Player* player, BattlegroundTypeId bgTypeId, uint8 fromWhere)
{
    if (!player)
        return;

    uint32 winner_kills = player->GetRandomWinner() ? sWorld->getIntConfig(CONFIG_BG_REWARD_WINNER_HONOR_LAST) : sWorld->getIntConfig(CONFIG_BG_REWARD_WINNER_HONOR_FIRST);
    uint32 winner_arena = player->GetRandomWinner() ? sWorld->getIntConfig(CONFIG_BG_REWARD_WINNER_ARENA_LAST) : sWorld->getIntConfig(CONFIG_BG_REWARD_WINNER_ARENA_FIRST);
    uint32 loser_kills = player->GetRandomWinner() ? sWorld->getIntConfig(CONFIG_BG_REWARD_LOSER_HONOR_LAST) : sWorld->getIntConfig(CONFIG_BG_REWARD_LOSER_HONOR_FIRST);

    winner_kills = Acore::Honor::hk_honor_at_level(player->getLevel(), float(winner_kills));
    loser_kills = Acore::Honor::hk_honor_at_level(player->getLevel(), float(loser_kills));

    data->Initialize(SMSG_BATTLEFIELD_LIST);
    *data << guid;                                          // battlemaster guid
    *data << uint8(fromWhere);                              // from where you joined
    *data << uint32(bgTypeId);                              // battleground id
    *data << uint8(0);                                      // unk
    *data << uint8(0);                                      // unk

    // Rewards
    *data << uint8(player->GetRandomWinner());              // 3.3.3 hasWin
    *data << uint32(winner_kills);                          // 3.3.3 winHonor
    *data << uint32(winner_arena);                          // 3.3.3 winArena
    *data << uint32(loser_kills);                           // 3.3.3 lossHonor

    uint8 isQueueRandom = (bgTypeId == BATTLEGROUND_RB);

    *data << uint8(isQueueRandom);                          // 3.3.3 isRandom
    if (isQueueRandom)
    {
        // Rewards (random)
        *data << uint8(player->GetRandomWinner());          // 3.3.3 hasWin_Random
        *data << uint32(winner_kills);                      // 3.3.3 winHonor_Random
        *data << uint32(winner_arena);                      // 3.3.3 winArena_Random
        *data << uint32(loser_kills);                       // 3.3.3 lossHonor_Random
    }

    if (bgTypeId == BATTLEGROUND_AA)                        // arena
        *data << uint32(0);                                 // unk (count?)
    else                                                    // battleground
    {
        size_t count_pos = data->wpos();
        *data << uint32(0);                                 // number of bg instances

        if (Battleground* bgt = GetBattlegroundTemplate(bgTypeId))
            if (GetBattlegroundBracketByLevel(bgt->GetMapId(), player->getLevel()))
            {
                uint32 count = 0;
                /*for (BattlegroundClientIdsContainer::const_iterator itr = clientIds.begin(); itr != clientIds.end(); ++itr)
                {
                    *data << uint32(*itr);
                    ++count;
                }*/
                data->put<uint32>(count_pos, count);
            }
    }
}

void BattlegroundMgr::SendToBattleground(Player* player, uint32 instanceId, BattlegroundTypeId bgTypeId)
{
    if (Battleground* bg = GetBattleground(instanceId))
    {
        uint32 mapid = bg->GetMapId();
        Position const* pos = bg->GetTeamStartPosition(player->GetBgTeamId());

        LOG_DEBUG("bg.battleground", "BattlegroundMgr::SendToBattleground: Sending {} to map {}, {} (bgType {})", player->GetName(), mapid, pos->ToString(), bgTypeId);
        player->TeleportTo(mapid, pos->GetPositionX(), pos->GetPositionY(), pos->GetPositionZ(), pos->GetOrientation());
    }
    else
    {
        LOG_ERROR("bg.battleground", "BattlegroundMgr::SendToBattleground: Instance {} (bgType {}) not found while trying to teleport player {}", instanceId, bgTypeId, player->GetName());
    }
}

void BattlegroundMgr::SendAreaSpiritHealerQueryOpcode(Player* player, Battleground* bg, ObjectGuid guid)
{
    WorldPacket data(SMSG_AREA_SPIRIT_HEALER_TIME, 12);
    uint32 time_ = RESURRECTION_INTERVAL - bg->GetLastResurrectTime();      // resurrect every X seconds
    if (time_ == uint32(-1))
        time_ = 0;
    data << guid << time_;
    player->GetSession()->SendPacket(&data);
}

bool BattlegroundMgr::IsArenaType(BattlegroundTypeId bgTypeId)
{
    return bgTypeId == BATTLEGROUND_AA
           || bgTypeId == BATTLEGROUND_BE
           || bgTypeId == BATTLEGROUND_NA
           || bgTypeId == BATTLEGROUND_DS
           || bgTypeId == BATTLEGROUND_RV
           || bgTypeId == BATTLEGROUND_RL;
}

BattlegroundQueueTypeId BattlegroundMgr::BGQueueTypeId(BattlegroundTypeId bgTypeId, uint8 arenaType)
{
    uint32 queueTypeID = BATTLEGROUND_QUEUE_NONE;

    if (arenaType)
    {
        if (BattlegroundMgr::ArenaTypeToQueue.find(arenaType) != BattlegroundMgr::ArenaTypeToQueue.end())
        {
            queueTypeID = BattlegroundMgr::ArenaTypeToQueue.at(arenaType);
        }

        sScriptMgr->OnArenaTypeIDToQueueID(bgTypeId, arenaType, queueTypeID);

        return static_cast<BattlegroundQueueTypeId>(queueTypeID);
    }

    if (BattlegroundMgr::bgToQueue.find(bgTypeId) != BattlegroundMgr::bgToQueue.end())
    {
        queueTypeID = BattlegroundMgr::bgToQueue.at(bgTypeId);
    }

    return static_cast<BattlegroundQueueTypeId>(queueTypeID);
}

BattlegroundTypeId BattlegroundMgr::BGTemplateId(BattlegroundQueueTypeId bgQueueTypeId)
{
    if (BattlegroundMgr::queueToBg.find(bgQueueTypeId) == BattlegroundMgr::queueToBg.end())
    {
        return BattlegroundTypeId(0);
    }

    return BattlegroundMgr::queueToBg[bgQueueTypeId];
}

uint8 BattlegroundMgr::BGArenaType(BattlegroundQueueTypeId bgQueueTypeId)
{
    uint8 arenaType = 0;

    if (BattlegroundMgr::QueueToArenaType.find(bgQueueTypeId) != BattlegroundMgr::QueueToArenaType.end())
    {
        arenaType = BattlegroundMgr::QueueToArenaType.at(bgQueueTypeId);
    }

    sScriptMgr->OnArenaQueueIdToArenaType(bgQueueTypeId, arenaType);

    return arenaType;
}

void BattlegroundMgr::ToggleTesting()
{
    if (sWorld->getBoolConfig(CONFIG_DEBUG_BATTLEGROUND))
    {
        m_Testing = true;
        sWorld->SendWorldText(LANG_DEBUG_BG_CONF);
    }
    else
    {
        m_Testing = !m_Testing;
        sWorld->SendWorldText(m_Testing ? LANG_DEBUG_BG_ON : LANG_DEBUG_BG_OFF);
    }
}

void BattlegroundMgr::ToggleArenaTesting()
{
    if (sWorld->getBoolConfig(CONFIG_DEBUG_ARENA))
    {
        m_ArenaTesting = true;
        sWorld->SendWorldText(LANG_DEBUG_ARENA_CONF);
    }
    else
    {
        m_ArenaTesting = !m_ArenaTesting;
        sWorld->SendWorldText(m_ArenaTesting ? LANG_DEBUG_ARENA_ON : LANG_DEBUG_ARENA_OFF);
    }
}

void BattlegroundMgr::SetHolidayWeekends(uint32 mask)
{
    for (uint32 bgtype = 1; bgtype < MAX_BATTLEGROUND_TYPE_ID; ++bgtype)
    {
        if (bgtype == BATTLEGROUND_RB)
            continue;
        if (Battleground* bgt = GetBattlegroundTemplate(BattlegroundTypeId(bgtype)))
            bgt->SetHoliday(mask & (1 << bgtype));
    }
}

void BattlegroundMgr::ScheduleArenaQueueUpdate(uint32 arenaRatedTeamId, BattlegroundQueueTypeId bgQueueTypeId, BattlegroundBracketId bracket_id)
{
    uint64 const scheduleId = ((uint64)arenaRatedTeamId << 32) | (bgQueueTypeId << 16) | bracket_id;
    if (std::find(m_ArenaQueueUpdateScheduler.begin(), m_ArenaQueueUpdateScheduler.end(), scheduleId) == m_ArenaQueueUpdateScheduler.end())
        m_ArenaQueueUpdateScheduler.push_back(scheduleId);
}

uint32 BattlegroundMgr::GetRatingDiscardTimer() const
{
    return sWorld->getIntConfig(CONFIG_ARENA_RATING_DISCARD_TIMER);
}

uint32 BattlegroundMgr::GetPrematureFinishTime() const
{
    return sWorld->getIntConfig(CONFIG_BATTLEGROUND_PREMATURE_FINISH_TIMER);
}

void BattlegroundMgr::LoadBattleMastersEntry()
{
    uint32 oldMSTime = getMSTime();

    mBattleMastersMap.clear();                                  // need for reload case

    QueryResult result = WorldDatabase.Query("SELECT entry, bg_template FROM battlemaster_entry");

    if (!result)
    {
        LOG_INFO("server.loading", ">> Loaded 0 battlemaster entries. DB table `battlemaster_entry` is empty!");
        LOG_INFO("server.loading", " ");
        return;
    }

    uint32 count = 0;

    do
    {
        ++count;

        Field* fields = result->Fetch();

        uint32 entry = fields[0].Get<uint32>();
        if (CreatureTemplate const* cInfo = sObjectMgr->GetCreatureTemplate(entry))
        {
            if ((cInfo->npcflag & UNIT_NPC_FLAG_BATTLEMASTER) == 0)
                LOG_ERROR("sql.sql", "Creature (Entry: {}) listed in `battlemaster_entry` is not a battlemaster.", entry);
        }
        else
        {
            LOG_ERROR("sql.sql", "Creature (Entry: {}) listed in `battlemaster_entry` does not exist.", entry);
            continue;
        }

        uint32 bgTypeId  = fields[1].Get<uint32>();
        if (!sBattlemasterListStore.LookupEntry(bgTypeId))
        {
            LOG_ERROR("sql.sql", "Table `battlemaster_entry` contain entry {} for not existed battleground type {}, ignored.", entry, bgTypeId);
            continue;
        }

        mBattleMastersMap[entry] = BattlegroundTypeId(bgTypeId);
    } while (result->NextRow());

    CheckBattleMasters();

    LOG_INFO("server.loading", ">> Loaded {} battlemaster entries in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
}

void BattlegroundMgr::CheckBattleMasters()
{
    CreatureTemplateContainer const* ctc = sObjectMgr->GetCreatureTemplates();
    for (CreatureTemplateContainer::const_iterator itr = ctc->begin(); itr != ctc->end(); ++itr)
    {
        if ((itr->second.npcflag & UNIT_NPC_FLAG_BATTLEMASTER) && mBattleMastersMap.find(itr->second.Entry) == mBattleMastersMap.end())
        {
            LOG_ERROR("sql.sql", "CreatureTemplate (Entry: {}) has UNIT_NPC_FLAG_BATTLEMASTER but no data in `battlemaster_entry` table. Removing flag!", itr->second.Entry);
            const_cast<CreatureTemplate*>(&itr->second)->npcflag &= ~UNIT_NPC_FLAG_BATTLEMASTER;
        }
    }
}

HolidayIds BattlegroundMgr::BGTypeToWeekendHolidayId(BattlegroundTypeId bgTypeId)
{
    switch (bgTypeId)
    {
        case BATTLEGROUND_AV:
            return HOLIDAY_CALL_TO_ARMS_AV;
        case BATTLEGROUND_EY:
            return HOLIDAY_CALL_TO_ARMS_EY;
        case BATTLEGROUND_WS:
            return HOLIDAY_CALL_TO_ARMS_WS;
        case BATTLEGROUND_SA:
            return HOLIDAY_CALL_TO_ARMS_SA;
        case BATTLEGROUND_AB:
            return HOLIDAY_CALL_TO_ARMS_AB;
        case BATTLEGROUND_IC:
            return HOLIDAY_CALL_TO_ARMS_IC;
        default:
            return HOLIDAY_NONE;
    }
}

BattlegroundTypeId BattlegroundMgr::WeekendHolidayIdToBGType(HolidayIds holiday)
{
    switch (holiday)
    {
        case HOLIDAY_CALL_TO_ARMS_AV:
            return BATTLEGROUND_AV;
        case HOLIDAY_CALL_TO_ARMS_EY:
            return BATTLEGROUND_EY;
        case HOLIDAY_CALL_TO_ARMS_WS:
            return BATTLEGROUND_WS;
        case HOLIDAY_CALL_TO_ARMS_SA:
            return BATTLEGROUND_SA;
        case HOLIDAY_CALL_TO_ARMS_AB:
            return BATTLEGROUND_AB;
        case HOLIDAY_CALL_TO_ARMS_IC:
            return BATTLEGROUND_IC;
        default:
            return BATTLEGROUND_TYPE_NONE;
    }
}

bool BattlegroundMgr::IsBGWeekend(BattlegroundTypeId bgTypeId)
{
    return IsHolidayActive(BGTypeToWeekendHolidayId(bgTypeId));
}

BattlegroundTypeId BattlegroundMgr::GetRandomBG(BattlegroundTypeId bgTypeId)
{
    if (GetBattlegroundTemplateByTypeId(bgTypeId))
    {
        std::vector<BattlegroundTypeId> ids;
        ids.reserve(16);
        std::vector<double> weights;
        weights.reserve(16);
        BattlemasterListEntry const* bl = sBattlemasterListStore.LookupEntry(bgTypeId);

        for (int32 mapId : bl->mapid)
        {
            if (mapId == -1)
                break;

            if (CreateBattlegroundData const* bg = GetBattlegroundTemplateByMapId(mapId))
            {
                ids.push_back(bg->bgTypeId);
                weights.push_back(bg->Weight);
            }
        }

        return *Acore::Containers::SelectRandomWeightedContainerElement(ids, weights);
    }

    return BATTLEGROUND_TYPE_NONE;
}

void BattlegroundMgr::AddBattleground(Battleground* bg)
{
    if (bg->GetInstanceID() == 0)
        m_BattlegroundTemplates[bg->GetBgTypeID()] = bg;
    else
        m_Battlegrounds[bg->GetInstanceID()] = bg;

    sScriptMgr->OnBattlegroundCreate(bg);
}

void BattlegroundMgr::RemoveBattleground(BattlegroundTypeId bgTypeId, uint32 instanceId)
{
    if (instanceId == 0)
        m_BattlegroundTemplates.erase(bgTypeId);
    else
        m_Battlegrounds.erase(instanceId);
}

void BattlegroundMgr::DoForAllBattlegrounds(std::function<void(Battleground*)> const& worker)
{
    for (auto const& [_, bg] : m_Battlegrounds)
    {
        worker(bg);
    }
}

// init/update unordered_map
// Battlegrounds
std::unordered_map<int, BattlegroundQueueTypeId> BattlegroundMgr::bgToQueue =
{
    { BATTLEGROUND_AV, BATTLEGROUND_QUEUE_AV},
    { BATTLEGROUND_WS, BATTLEGROUND_QUEUE_WS},
    { BATTLEGROUND_AB, BATTLEGROUND_QUEUE_AB},
    { BATTLEGROUND_EY, BATTLEGROUND_QUEUE_EY},
    { BATTLEGROUND_SA, BATTLEGROUND_QUEUE_SA},
    { BATTLEGROUND_IC, BATTLEGROUND_QUEUE_IC},
    { BATTLEGROUND_RB, BATTLEGROUND_QUEUE_RB},
    // Arena Battlegrounds
    { BATTLEGROUND_NA, BattlegroundQueueTypeId(0)},        // Nagrand Arena
    { BATTLEGROUND_BE, BattlegroundQueueTypeId(0)},        // Blade's Edge Arena
    { BATTLEGROUND_AA, BattlegroundQueueTypeId(0)},        // All Arena
    { BATTLEGROUND_RL, BattlegroundQueueTypeId(0)},        // Ruins of Lordaernon
    { BATTLEGROUND_DS, BattlegroundQueueTypeId(0)},        // Dalaran Sewer
    { BATTLEGROUND_RV, BattlegroundQueueTypeId(0)},        // Ring of Valor
};

std::unordered_map<int, BattlegroundTypeId> BattlegroundMgr::queueToBg =
{
    { BATTLEGROUND_QUEUE_NONE,  BATTLEGROUND_TYPE_NONE },
    { BATTLEGROUND_QUEUE_AV,    BATTLEGROUND_AV },
    { BATTLEGROUND_QUEUE_WS,    BATTLEGROUND_WS },
    { BATTLEGROUND_QUEUE_AB,    BATTLEGROUND_AB },
    { BATTLEGROUND_QUEUE_EY,    BATTLEGROUND_EY },
    { BATTLEGROUND_QUEUE_SA,    BATTLEGROUND_SA },
    { BATTLEGROUND_QUEUE_IC,    BATTLEGROUND_IC },
    { BATTLEGROUND_QUEUE_RB,    BATTLEGROUND_RB },
    { BATTLEGROUND_QUEUE_2v2,   BATTLEGROUND_AA },
    { BATTLEGROUND_QUEUE_3v3,   BATTLEGROUND_AA },
    { BATTLEGROUND_QUEUE_5v5,   BATTLEGROUND_AA },
};

std::unordered_map<int, Battleground*> BattlegroundMgr::bgtypeToBattleground =
{
    { BATTLEGROUND_AV, new BattlegroundAV },
    { BATTLEGROUND_WS, new BattlegroundWS },
    { BATTLEGROUND_AB, new BattlegroundAB },
    { BATTLEGROUND_NA, new BattlegroundNA },
    { BATTLEGROUND_BE, new BattlegroundBE },
    { BATTLEGROUND_EY, new BattlegroundEY },
    { BATTLEGROUND_RL, new BattlegroundRL },
    { BATTLEGROUND_SA, new BattlegroundSA },
    { BATTLEGROUND_DS, new BattlegroundDS },
    { BATTLEGROUND_RV, new BattlegroundRV },
    { BATTLEGROUND_IC, new BattlegroundIC },
    { BATTLEGROUND_AA, new Battleground },
    { BATTLEGROUND_RB, new Battleground },
};

std::unordered_map<int, bgRef> BattlegroundMgr::bgTypeToTemplate =
{
    { BATTLEGROUND_AV, [](Battleground * bg_t) -> Battleground* { return new BattlegroundAV(*(BattlegroundAV*)bg_t); } },
    { BATTLEGROUND_WS, [](Battleground * bg_t) -> Battleground* { return new BattlegroundWS(*(BattlegroundWS*)bg_t); } },
    { BATTLEGROUND_AB, [](Battleground * bg_t) -> Battleground* { return new BattlegroundAB(*(BattlegroundAB*)bg_t); } },
    { BATTLEGROUND_NA, [](Battleground * bg_t) -> Battleground* { return new BattlegroundNA(*(BattlegroundNA*)bg_t); } },
    { BATTLEGROUND_BE, [](Battleground * bg_t) -> Battleground* { return new BattlegroundBE(*(BattlegroundBE*)bg_t); } },
    { BATTLEGROUND_EY, [](Battleground * bg_t) -> Battleground* { return new BattlegroundEY(*(BattlegroundEY*)bg_t); } },
    { BATTLEGROUND_RL, [](Battleground * bg_t) -> Battleground* { return new BattlegroundRL(*(BattlegroundRL*)bg_t); } },
    { BATTLEGROUND_SA, [](Battleground * bg_t) -> Battleground* { return new BattlegroundSA(*(BattlegroundSA*)bg_t); } },
    { BATTLEGROUND_DS, [](Battleground * bg_t) -> Battleground* { return new BattlegroundDS(*(BattlegroundDS*)bg_t); } },
    { BATTLEGROUND_RV, [](Battleground * bg_t) -> Battleground* { return new BattlegroundRV(*(BattlegroundRV*)bg_t); } },
    { BATTLEGROUND_IC, [](Battleground * bg_t) -> Battleground* { return new BattlegroundIC(*(BattlegroundIC*)bg_t); } },

    { BATTLEGROUND_RB, [](Battleground * bg_t) -> Battleground* { return new Battleground(*bg_t); }, },
    { BATTLEGROUND_AA, [](Battleground * bg_t) -> Battleground* { return new Battleground(*bg_t); }, },
};

std::unordered_map<int, bgMapRef> BattlegroundMgr::getBgFromMap = {};

std::unordered_map<int, bgTypeRef> BattlegroundMgr::getBgFromTypeID =
{
    {
        BATTLEGROUND_RB,
        [](WorldPacket * data, Battleground::BattlegroundScoreMap::const_iterator itr2, Battleground * bg)
        {
            if (BattlegroundMgr::getBgFromMap.find(bg->GetMapId()) == BattlegroundMgr::getBgFromMap.end()) // this should not happen
            {
                *data << uint32(0);
            }
            else
            {
                BattlegroundMgr::getBgFromMap[bg->GetMapId()](data, itr2);
            }
        }
    }
};

std::unordered_map<uint32, BattlegroundQueueTypeId> BattlegroundMgr::ArenaTypeToQueue =
{
    { ARENA_TYPE_2v2, BATTLEGROUND_QUEUE_2v2 },
    { ARENA_TYPE_3v3, BATTLEGROUND_QUEUE_3v3 },
    { ARENA_TYPE_5v5, BATTLEGROUND_QUEUE_5v5 }
};

std::unordered_map<uint32, ArenaType> BattlegroundMgr::QueueToArenaType =
{
    { BATTLEGROUND_QUEUE_2v2, ARENA_TYPE_2v2 },
    { BATTLEGROUND_QUEUE_3v3, ARENA_TYPE_3v3 },
    { BATTLEGROUND_QUEUE_5v5, ARENA_TYPE_5v5 }
};

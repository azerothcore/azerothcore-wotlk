/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include "Common.h"
#include "ObjectMgr.h"
#include "ArenaTeamMgr.h"
#include "World.h"
#include "WorldPacket.h"

#include "ArenaTeam.h"
#include "BattlegroundMgr.h"
#include "BattlegroundAV.h"
#include "BattlegroundAB.h"
#include "BattlegroundEY.h"
#include "BattlegroundWS.h"
#include "BattlegroundNA.h"
#include "BattlegroundBE.h"
#include "BattlegroundRL.h"
#include "BattlegroundSA.h"
#include "BattlegroundDS.h"
#include "BattlegroundRV.h"
#include "BattlegroundIC.h"
#include "Chat.h"
#include "Map.h"
#include "MapInstanced.h"
#include "MapManager.h"
#include "Player.h"
#include "GameEventMgr.h"
#include "SharedDefines.h"
#include "Formulas.h"
#include "DisableMgr.h"
#include "Opcodes.h"
#include "BattlegroundQueue.h"
#include "GameGraveyard.h"
#include <unordered_map>
#ifdef ELUNA
#include "LuaEngine.h"
#endif

/*********************************************************/
/***            BATTLEGROUND MANAGER                   ***/
/*********************************************************/

BattlegroundMgr::BattlegroundMgr() : randomBgDifficultyEntry(999, 0, 80, 80, 0), m_ArenaTesting(false), m_Testing(false), 
    m_lastClientVisibleInstanceId(0), m_NextAutoDistributionTime(0), m_AutoDistributionTimeChecker(0), m_NextPeriodicQueueUpdateTime(5*IN_MILLISECONDS)
{
    for (uint32 qtype = BATTLEGROUND_QUEUE_NONE; qtype < MAX_BATTLEGROUND_QUEUE_TYPES; ++qtype)
        m_BattlegroundQueues[qtype].SetBgTypeIdAndArenaType(BGTemplateId(BattlegroundQueueTypeId(qtype)), BGArenaType(BattlegroundQueueTypeId(qtype)));
}

BattlegroundMgr::~BattlegroundMgr()
{
    DeleteAllBattlegrounds();
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
            itrDelete->second = NULL;
            m_Battlegrounds.erase(itrDelete);
            delete bg;
        }
    }

    // update to change current bg type the random system is trying to create
    RandomSystem.Update(diff);

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
            m_BattlegroundQueues[bgQueueTypeId].BattlegroundQueueUpdate(bracket_id, 0x03, true, arenaRatedTeamId); // pussywizard: looking for opponents only for this team
        }
    }

    // periodic queue update
    if (m_NextPeriodicQueueUpdateTime < diff)
    {
        // for rated arenas
        for (uint32 qtype = BATTLEGROUND_QUEUE_2v2; qtype < MAX_BATTLEGROUND_QUEUE_TYPES; ++qtype)
            for (uint32 bracket = BG_BRACKET_ID_FIRST; bracket < MAX_BATTLEGROUND_BRACKETS; ++bracket)
                m_BattlegroundQueues[qtype].BattlegroundQueueUpdate(BattlegroundBracketId(bracket), 0x03, true, 0); // pussywizard: 0 for rated means looking for opponents for every team

        // for battlegrounds and not rated arenas
        // in first loop try to fill already running battlegrounds, then in a second loop try to create new battlegrounds
        for (uint8 action = 1; action <= 2; ++action)
            for (uint32 qtype = BATTLEGROUND_QUEUE_AV; qtype < MAX_BATTLEGROUND_QUEUE_TYPES; ++qtype)
                for (uint32 bracket = BG_BRACKET_ID_FIRST; bracket < MAX_BATTLEGROUND_BRACKETS; ++bracket)
                    m_BattlegroundQueues[qtype].BattlegroundQueueUpdate(BattlegroundBracketId(bracket), action, false, 0);

        m_NextPeriodicQueueUpdateTime = 5*IN_MILLISECONDS;
    }
    else
        m_NextPeriodicQueueUpdateTime -= diff;

    // arena points auto-distribution
    if (sWorld->getBoolConfig(CONFIG_ARENA_AUTO_DISTRIBUTE_POINTS))
    {
        if (m_AutoDistributionTimeChecker < diff)
        {
            if (time(NULL) > m_NextAutoDistributionTime)
            {
                sArenaTeamMgr->DistributeArenaPoints();
                m_NextAutoDistributionTime = m_NextAutoDistributionTime + BATTLEGROUND_ARENA_POINT_DISTRIBUTION_DAY * sWorld->getIntConfig(CONFIG_ARENA_AUTO_DISTRIBUTE_INTERVAL_DAYS);
                sWorld->setWorldState(WS_ARENA_DISTRIBUTION_TIME, uint64(m_NextAutoDistributionTime));
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
    ASSERT(QueueSlot < PLAYER_MAX_BATTLEGROUND_QUEUES);

    if (StatusID == STATUS_NONE || !bg)
    {
        data->Initialize(SMSG_BATTLEFIELD_STATUS, 4+8);
        *data << uint32(QueueSlot);
        *data << uint64(0);
        return;
    }

    data->Initialize(SMSG_BATTLEFIELD_STATUS, (4+8+1+1+4+1+4+4+4));
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

void BattlegroundMgr::BuildPvpLogDataPacket(WorldPacket* data, Battleground* bg)
{
    uint8 type = (bg->isArena() ? 1 : 0);

    data->Initialize(MSG_PVP_LOG_DATA, (1+1+4+40*bg->GetPlayerScoresSize()));
    *data << uint8(type);                                   // type (battleground=0/arena=1)

    if (type)                                               // arena
    {
        // it seems this must be according to BG_WINNER_A/H and _NOT_ TEAM_A/H
        for (TeamId iTeamId = TEAM_ALLIANCE; iTeamId <= TEAM_HORDE; iTeamId = TeamId(iTeamId+1))
        {
            // Xinef: oryginally this was looping in reverse order, loop order was changed so we have to change checked teamId
            int32 rating_change = bg->GetArenaTeamRatingChangeForTeam(Battleground::GetOtherTeamId(iTeamId));

            uint32 pointsLost = rating_change < 0 ? -rating_change : 0;
            uint32 pointsGained = rating_change > 0 ? rating_change : 0;
            uint32 MatchmakerRating = bg->GetArenaMatchmakerRating(Battleground::GetOtherTeamId(iTeamId));

            *data << uint32(pointsLost);                    // Rating Lost
            *data << uint32(pointsGained);                  // Rating gained
            *data << uint32(MatchmakerRating);              // Matchmaking Value
        }
        for (TeamId iTeamId = TEAM_ALLIANCE; iTeamId <= TEAM_HORDE; iTeamId = TeamId(iTeamId+1))
        {
            if (ArenaTeam* at = sArenaTeamMgr->GetArenaTeamById(bg->GetArenaTeamIdForTeam(Battleground::GetOtherTeamId(iTeamId))))
                *data << at->GetName();
            else
                *data << uint8(0);
        }
    }

    if (bg->GetStatus() != STATUS_WAIT_LEAVE)
        *data << uint8(0);                                     // bg not ended
    else
    {
        *data << uint8(1);                                     // bg ended
        *data << uint8(bg->GetWinner());                       // who win
    }

    size_t wpos = data->wpos();
    uint32 scoreCount = 0;
    *data << uint32(scoreCount);                            // placeholder

    Battleground::BattlegroundScoreMap::const_iterator itr2 = bg->GetPlayerScoresBegin();
    for (Battleground::BattlegroundScoreMap::const_iterator itr = itr2; itr != bg->GetPlayerScoresEnd();)
    {
        itr2 = itr++;
        if (!bg->IsPlayerInBattleground(itr2->first))
        {
            sLog->outError("Player " UI64FMTD " has scoreboard entry for battleground %u but is not in battleground!", itr->first, bg->GetBgTypeID());
            continue;
        }

        *data << uint64(itr2->first);
        *data << uint32(itr2->second->KillingBlows);
        if (type == 0)
        {
            *data << uint32(itr2->second->HonorableKills);
            *data << uint32(itr2->second->Deaths);
            *data << uint32(itr2->second->BonusHonor);
        }
        else
        {
            *data << uint8(itr2->second->player->GetBgTeamId() == TEAM_ALLIANCE ? 1 : 0); // green or yellow
        }
        *data << uint32(itr2->second->DamageDone);              // damage done
        *data << uint32(itr2->second->HealingDone);             // healing done
        switch (bg->GetBgTypeID())                              // battleground specific things
        {
            case BATTLEGROUND_RB:
                switch (bg->GetMapId())
                {
                    case 489:
                        *data << uint32(0x00000002);            // count of next fields
                        *data << uint32(((BattlegroundWGScore*)itr2->second)->FlagCaptures);        // flag captures
                        *data << uint32(((BattlegroundWGScore*)itr2->second)->FlagReturns);         // flag returns
                        break;
                    case 566:
                        *data << uint32(0x00000001);            // count of next fields
                        *data << uint32(((BattlegroundEYScore*)itr2->second)->FlagCaptures);        // flag captures
                        break;
                    case 529:
                        *data << uint32(0x00000002);            // count of next fields
                        *data << uint32(((BattlegroundABScore*)itr2->second)->BasesAssaulted);      // bases asssulted
                        *data << uint32(((BattlegroundABScore*)itr2->second)->BasesDefended);       // bases defended
                        break;
                    case 30:
                        *data << uint32(0x00000005);            // count of next fields
                        *data << uint32(((BattlegroundAVScore*)itr2->second)->GraveyardsAssaulted); // GraveyardsAssaulted
                        *data << uint32(((BattlegroundAVScore*)itr2->second)->GraveyardsDefended);  // GraveyardsDefended
                        *data << uint32(((BattlegroundAVScore*)itr2->second)->TowersAssaulted);     // TowersAssaulted
                        *data << uint32(((BattlegroundAVScore*)itr2->second)->TowersDefended);      // TowersDefended
                        *data << uint32(((BattlegroundAVScore*)itr2->second)->MinesCaptured);       // MinesCaptured
                        break;
                    case 607:
                        *data << uint32(0x00000002);            // count of next fields
                        *data << uint32(((BattlegroundSAScore*)itr2->second)->demolishers_destroyed);
                        *data << uint32(((BattlegroundSAScore*)itr2->second)->gates_destroyed);
                        break;
                    case 628:                                   // IC
                        *data << uint32(0x00000002);            // count of next fields
                        *data << uint32(((BattlegroundICScore*)itr2->second)->BasesAssaulted);       // bases asssulted
                        *data << uint32(((BattlegroundICScore*)itr2->second)->BasesDefended);        // bases defended
                    default:
                        *data << uint32(0);
                        break;
                }
                break;
            case BATTLEGROUND_AV:
                *data << uint32(0x00000005);                    // count of next fields
                *data << uint32(((BattlegroundAVScore*)itr2->second)->GraveyardsAssaulted); // GraveyardsAssaulted
                *data << uint32(((BattlegroundAVScore*)itr2->second)->GraveyardsDefended);  // GraveyardsDefended
                *data << uint32(((BattlegroundAVScore*)itr2->second)->TowersAssaulted);     // TowersAssaulted
                *data << uint32(((BattlegroundAVScore*)itr2->second)->TowersDefended);      // TowersDefended
                *data << uint32(((BattlegroundAVScore*)itr2->second)->MinesCaptured);       // MinesCaptured
                break;
            case BATTLEGROUND_WS:
                *data << uint32(0x00000002);                    // count of next fields
                *data << uint32(((BattlegroundWGScore*)itr2->second)->FlagCaptures);        // flag captures
                *data << uint32(((BattlegroundWGScore*)itr2->second)->FlagReturns);         // flag returns
                break;
            case BATTLEGROUND_AB:
                *data << uint32(0x00000002);                    // count of next fields
                *data << uint32(((BattlegroundABScore*)itr2->second)->BasesAssaulted);      // bases asssulted
                *data << uint32(((BattlegroundABScore*)itr2->second)->BasesDefended);       // bases defended
                break;
            case BATTLEGROUND_EY:
                *data << uint32(0x00000001);                    // count of next fields
                *data << uint32(((BattlegroundEYScore*)itr2->second)->FlagCaptures);        // flag captures
                break;
            case BATTLEGROUND_SA:
                *data << uint32(0x00000002);                    // count of next fields
                *data << uint32(((BattlegroundSAScore*)itr2->second)->demolishers_destroyed);
                *data << uint32(((BattlegroundSAScore*)itr2->second)->gates_destroyed);
                break;
            case BATTLEGROUND_IC:
                *data << uint32(0x00000002);                // count of next fields
                *data << uint32(((BattlegroundICScore*)itr2->second)->BasesAssaulted);       // bases assaulted
                *data << uint32(((BattlegroundICScore*)itr2->second)->BasesDefended);        // bases defended
                break;
            case BATTLEGROUND_NA:
            case BATTLEGROUND_BE:
            case BATTLEGROUND_AA:
            case BATTLEGROUND_RL:
            case BATTLEGROUND_DS:
            case BATTLEGROUND_RV:
                *data << uint32(0);
                break;
            default:
                *data << uint32(0);
                break;
        }
        // should never happen
        if (++scoreCount >= bg->GetMaxPlayersPerTeam()*2 && itr != bg->GetPlayerScoresEnd())
        {
            sLog->outMisc("Battleground %u scoreboard has more entries (%u) than allowed players in this bg (%u)", bg->GetBgTypeID(), bg->GetPlayerScoresSize(), bg->GetMaxPlayersPerTeam()*2);
            break;
        }
    }

    data->put(wpos, scoreCount);
}

void BattlegroundMgr::BuildGroupJoinedBattlegroundPacket(WorldPacket* data, GroupJoinBattlegroundResult result)
{
    data->Initialize(SMSG_GROUP_JOINED_BATTLEGROUND, 4);
    *data << int32(result);
    if (result == ERR_BATTLEGROUND_JOIN_TIMED_OUT || result == ERR_BATTLEGROUND_JOIN_FAILED)
        *data << uint64(0);                                 // player guid
}

void BattlegroundMgr::BuildUpdateWorldStatePacket(WorldPacket* data, uint32 field, uint32 value)
{
    data->Initialize(SMSG_UPDATE_WORLD_STATE, 4+4);
    *data << uint32(field);
    *data << uint32(value);
}

void BattlegroundMgr::BuildPlaySoundPacket(WorldPacket* data, uint32 soundid)
{
    data->Initialize(SMSG_PLAY_SOUND, 4);
    *data << uint32(soundid);
}

void BattlegroundMgr::BuildPlayerLeftBattlegroundPacket(WorldPacket* data, uint64 guid)
{
    data->Initialize(SMSG_BATTLEGROUND_PLAYER_LEFT, 8);
    *data << uint64(guid);
}

void BattlegroundMgr::BuildPlayerJoinedBattlegroundPacket(WorldPacket* data, Player* player)
{
    data->Initialize(SMSG_BATTLEGROUND_PLAYER_JOINED, 8);
    *data << uint64(player->GetGUID());
}

Battleground* BattlegroundMgr::GetBattleground(uint32 instanceId)
{
    if (!instanceId)
        return NULL;

    BattlegroundContainer::const_iterator itr = m_Battlegrounds.find(instanceId);
    if (itr != m_Battlegrounds.end())
       return itr->second;

    return NULL;
}

Battleground* BattlegroundMgr::GetBattlegroundTemplate(BattlegroundTypeId bgTypeId)
{
    BattlegroundTemplateContainer::const_iterator itr = m_BattlegroundTemplates.find(bgTypeId);
    if (itr != m_BattlegroundTemplates.end())
        return itr->second;

    return NULL;
}

uint32 BattlegroundMgr::GetNextClientVisibleInstanceId()
{
    return ++m_lastClientVisibleInstanceId;
}

// create a new battleground that will really be used to play
Battleground* BattlegroundMgr::CreateNewBattleground(BattlegroundTypeId bgTypeId, uint32 minLevel, uint32 maxLevel, uint8 arenaType, bool isRated)
{
    // pussywizard: random battleground is chosen before calling this function!
    ASSERT(bgTypeId != BATTLEGROUND_RB);

    // pussywizard: randomize for all arena
    if (bgTypeId == BATTLEGROUND_AA)
        bgTypeId = RAND<BattlegroundTypeId>(BATTLEGROUND_NA, BATTLEGROUND_BE, BATTLEGROUND_RL, BATTLEGROUND_DS, BATTLEGROUND_RV);

    // get the template BG
    Battleground* bg_template = GetBattlegroundTemplate(bgTypeId);
    if (!bg_template)
        return NULL;

    Battleground* bg = NULL;
    // create a copy of the BG template
    if (BattlegroundMgr::bgTypeToTemplate.find(bgTypeId) == BattlegroundMgr::bgTypeToTemplate.end()) {
        return NULL;
    }

    bg = BattlegroundMgr::bgTypeToTemplate[bgTypeId](bg_template);

    bg->SetLevelRange(minLevel, maxLevel);
    bg->SetInstanceID(sMapMgr->GenerateInstanceId());
    bg->SetClientInstanceID(IsArenaType(bgTypeId) ? 0 : GetNextClientVisibleInstanceId());
    bg->Init();
    bg->SetStatus(STATUS_WAIT_JOIN); // start the joining of the bg
    bg->SetArenaType(arenaType);
    bg->SetBgTypeID(bgTypeId);
    bg->SetRated(isRated);

    // Set up correct min/max player counts for scoreboards
    if (bg->isArena())
    {
        uint32 maxPlayersPerTeam = 0;
        switch (arenaType)
        {
            case ARENA_TYPE_2v2:
                maxPlayersPerTeam = 2;
                break;
            case ARENA_TYPE_3v3:
                maxPlayersPerTeam = 3;
                break;
            case ARENA_TYPE_5v5:
                maxPlayersPerTeam = 5;
                break;
        }

        bg->SetMaxPlayersPerTeam(maxPlayersPerTeam);
    }

    return bg;
}

// used to create the BG templates
bool BattlegroundMgr::CreateBattleground(CreateBattlegroundData& data)
{
    // Create the BG
    Battleground* bg = NULL;
    bg = BattlegroundMgr::bgtypeToBattleground[data.bgTypeId];

    if (bg == NULL)
        return false;

    bg->SetMapId(data.bgTypeId == BATTLEGROUND_RB ? randomBgDifficultyEntry.mapId : data.MapID);
    bg->SetBgTypeID(data.bgTypeId);
    bg->SetInstanceID(0);
    bg->SetArenaorBGType(data.IsArena);
    bg->SetMinPlayersPerTeam(data.MinPlayersPerTeam);
    bg->SetMaxPlayersPerTeam(data.MaxPlayersPerTeam);
    bg->SetName(data.BattlegroundName);
    bg->SetTeamStartLoc(TEAM_ALLIANCE, data.Team1StartLocX, data.Team1StartLocY, data.Team1StartLocZ, data.Team1StartLocO);
    bg->SetTeamStartLoc(TEAM_HORDE,    data.Team2StartLocX, data.Team2StartLocY, data.Team2StartLocZ, data.Team2StartLocO);
    bg->SetStartMaxDist(data.StartMaxDist);
    bg->SetLevelRange(data.LevelMin, data.LevelMax);
    bg->SetScriptId(data.scriptId);

    AddBattleground(bg);

    return true;
}

void BattlegroundMgr::CreateInitialBattlegrounds()
{
    uint32 oldMSTime = getMSTime();
    //                                               0   1                  2                  3       4       5                 6               7              8            9             10      11
    QueryResult result = WorldDatabase.Query("SELECT ID, MinPlayersPerTeam, MaxPlayersPerTeam, MinLvl, MaxLvl, AllianceStartLoc, AllianceStartO, HordeStartLoc, HordeStartO, StartMaxDist, Weight, ScriptName FROM battleground_template");

    if (!result)
    {
        sLog->outError(">> Loaded 0 battlegrounds. DB table `battleground_template` is empty.");
        return;
    }

    uint32 count = 0;

    do
    {
        Field* fields = result->Fetch();

        uint32 bgTypeId = fields[0].GetUInt32();

        if (DisableMgr::IsDisabledFor(DISABLE_TYPE_BATTLEGROUND, bgTypeId, NULL))
            continue;

        // can be overwrite by values from DB
        BattlemasterListEntry const* bl = sBattlemasterListStore.LookupEntry(bgTypeId);
        if (!bl)
        {
            sLog->outError("Battleground ID %u not found in BattlemasterList.dbc. Battleground not created.", bgTypeId);
            continue;
        }

        CreateBattlegroundData data;
        data.bgTypeId = BattlegroundTypeId(bgTypeId);
        data.IsArena = (bl->type == TYPE_ARENA);
        data.MinPlayersPerTeam = fields[1].GetUInt16();
        data.MaxPlayersPerTeam = fields[2].GetUInt16();
        data.LevelMin = fields[3].GetUInt8();
        data.LevelMax = fields[4].GetUInt8();
        float dist = fields[9].GetFloat();
        data.StartMaxDist = dist * dist;

        data.scriptId = sObjectMgr->GetScriptId(fields[11].GetCString());
        data.BattlegroundName = bl->name[sWorld->GetDefaultDbcLocale()];
        data.MapID = bl->mapid[0];

        if (data.MaxPlayersPerTeam == 0 || data.MinPlayersPerTeam > data.MaxPlayersPerTeam)
        {
            sLog->outError("Table `battleground_template` for id %u has bad values for MinPlayersPerTeam (%u) and MaxPlayersPerTeam(%u)",
                data.bgTypeId, data.MinPlayersPerTeam, data.MaxPlayersPerTeam);
            continue;
        }

        if (data.LevelMin == 0 || data.LevelMax == 0 || data.LevelMin > data.LevelMax)
        {
            sLog->outError("Table `battleground_template` for id %u has bad values for LevelMin (%u) and LevelMax(%u)",
                data.bgTypeId, data.LevelMin, data.LevelMax);
            continue;
        }

        if (data.bgTypeId == BATTLEGROUND_AA || data.bgTypeId == BATTLEGROUND_RB)
        {
            data.Team1StartLocX = 0;
            data.Team1StartLocY = 0;
            data.Team1StartLocZ = 0;
            data.Team1StartLocO = fields[6].GetFloat();
            data.Team2StartLocX = 0;
            data.Team2StartLocY = 0;
            data.Team2StartLocZ = 0;
            data.Team2StartLocO = fields[8].GetFloat();
        }
        else
        {
            uint32 startId = fields[5].GetUInt32();
            if (GraveyardStruct const* start = sGraveyard->GetGraveyard(startId))
            {
                data.Team1StartLocX = start->x;
                data.Team1StartLocY = start->y;
                data.Team1StartLocZ = start->z;
                data.Team1StartLocO = fields[6].GetFloat();
            }
            else
            {
                sLog->outError("Table `battleground_template` for id %u have non-existed `game_graveyard` table id %u in field `AllianceStartLoc`. BG not created.", data.bgTypeId, startId);
                continue;
            }

            startId = fields[7].GetUInt32();
            if (GraveyardStruct const* start = sGraveyard->GetGraveyard(startId))
            {
                data.Team2StartLocX = start->x;
                data.Team2StartLocY = start->y;
                data.Team2StartLocZ = start->z;
                data.Team2StartLocO = fields[8].GetFloat();
            }
            else
            {
                sLog->outError("Table `battleground_template` for id %u have non-existed `game_graveyard` table id %u in field `HordeStartLoc`. BG not created.", data.bgTypeId, startId);
                continue;
            }
        }

        if (!CreateBattleground(data))
            continue;

        ++count;
    }
    while (result->NextRow());

    sLog->outString(">> Loaded %u battlegrounds in %u ms", count, GetMSTimeDiffToNow(oldMSTime));
}

void BattlegroundMgr::InitAutomaticArenaPointDistribution()
{
    if (!sWorld->getBoolConfig(CONFIG_ARENA_AUTO_DISTRIBUTE_POINTS))
        return;

    time_t wstime = time_t(sWorld->getWorldState(WS_ARENA_DISTRIBUTION_TIME));
    time_t curtime = time(NULL);
    sLog->outString("AzerothCore Battleground: Initializing Automatic Arena Point Distribution");
    if (wstime < curtime)
    {
        m_NextAutoDistributionTime = curtime;           // reset will be called in the next update
        sLog->outString("AzerothCore Battleground: Next arena point distribution time in the past, reseting it now.");
    }
    else
        m_NextAutoDistributionTime = wstime;
 	sLog->outString("AzerothCore Battleground: Automatic Arena Point Distribution initialized.");
}

void BattlegroundMgr::BuildBattlegroundListPacket(WorldPacket* data, uint64 guid, Player* player, BattlegroundTypeId bgTypeId, uint8 fromWhere)
{
    if (!player)
        return;

    uint32 winner_kills = player->GetRandomWinner() ? BG_REWARD_WINNER_HONOR_LAST : BG_REWARD_WINNER_HONOR_FIRST;
    uint32 winner_arena = player->GetRandomWinner() ? BG_REWARD_WINNER_ARENA_LAST : BG_REWARD_WINNER_ARENA_FIRST;
    uint32 loser_kills = player->GetRandomWinner() ? BG_REWARD_LOSER_HONOR_LAST : BG_REWARD_LOSER_HONOR_FIRST;

    winner_kills = Trinity::Honor::hk_honor_at_level(player->getLevel(), float(winner_kills));
    loser_kills = Trinity::Honor::hk_honor_at_level(player->getLevel(), float(loser_kills));

    data->Initialize(SMSG_BATTLEFIELD_LIST);
    *data << uint64(guid);                                  // battlemaster guid
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

void BattlegroundMgr::SendToBattleground(Player* player, uint32 instanceId, BattlegroundTypeId  /*bgTypeId*/)
{
    if (Battleground* bg = GetBattleground(instanceId))
    {
        float x, y, z, o;
        bg->GetTeamStartLoc(player->GetBgTeamId(), x, y, z, o);
        player->TeleportTo(bg->GetMapId(), x, y, z, o);
    }
}

void BattlegroundMgr::SendAreaSpiritHealerQueryOpcode(Player* player, Battleground* bg, uint64 guid)
{
    WorldPacket data(SMSG_AREA_SPIRIT_HEALER_TIME, 12);
    uint32 time_ = 30000 - bg->GetLastResurrectTime();      // resurrect every 30 seconds
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
    if (arenaType) {
        switch (arenaType) {
            case ARENA_TYPE_2v2:
                return BATTLEGROUND_QUEUE_2v2;
            case ARENA_TYPE_3v3:
                return BATTLEGROUND_QUEUE_3v3;
            case ARENA_TYPE_5v5:
                return BATTLEGROUND_QUEUE_5v5;
            default:
                return BATTLEGROUND_QUEUE_NONE;
        }
    }

    if (BattlegroundMgr::bgToQueue.find(bgTypeId) == BattlegroundMgr::bgToQueue.end()) {
        return BATTLEGROUND_QUEUE_NONE;
    }

    return BattlegroundMgr::bgToQueue[bgTypeId];
}

BattlegroundTypeId BattlegroundMgr::BGTemplateId(BattlegroundQueueTypeId bgQueueTypeId)
{
    if (BattlegroundMgr::queueToBg.find(bgQueueTypeId) == BattlegroundMgr::queueToBg.end()) {
        return BattlegroundTypeId(0);
    }

    return BattlegroundMgr::queueToBg[bgQueueTypeId];
}

uint8 BattlegroundMgr::BGArenaType(BattlegroundQueueTypeId bgQueueTypeId)
{
    switch (bgQueueTypeId)
    {
        case BATTLEGROUND_QUEUE_2v2:
            return ARENA_TYPE_2v2;
        case BATTLEGROUND_QUEUE_3v3:
            return ARENA_TYPE_3v3;
        case BATTLEGROUND_QUEUE_5v5:
            return ARENA_TYPE_5v5;
        default:
            return 0;
    }
}

void BattlegroundMgr::ToggleTesting()
{
    m_Testing = !m_Testing;
    sWorld->SendWorldText(m_Testing ? LANG_DEBUG_BG_ON : LANG_DEBUG_BG_OFF);
}

void BattlegroundMgr::ToggleArenaTesting()
{
    m_ArenaTesting = !m_ArenaTesting;
    sWorld->SendWorldText(m_ArenaTesting ? LANG_DEBUG_ARENA_ON : LANG_DEBUG_ARENA_OFF);
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
        sLog->outString(">> Loaded 0 battlemaster entries. DB table `battlemaster_entry` is empty!");
        sLog->outString();
        return;
    }

    uint32 count = 0;

    do
    {
        ++count;

        Field* fields = result->Fetch();

        uint32 entry = fields[0].GetUInt32();
        if (CreatureTemplate const* cInfo = sObjectMgr->GetCreatureTemplate(entry))
        {
            if ((cInfo->npcflag & UNIT_NPC_FLAG_BATTLEMASTER) == 0)
                sLog->outErrorDb("Creature (Entry: %u) listed in `battlemaster_entry` is not a battlemaster.", entry);
        }
        else
        {
            sLog->outErrorDb("Creature (Entry: %u) listed in `battlemaster_entry` does not exist.", entry);
            continue;
        }

        uint32 bgTypeId  = fields[1].GetUInt32();
        if (!sBattlemasterListStore.LookupEntry(bgTypeId))
        {
            sLog->outErrorDb("Table `battlemaster_entry` contain entry %u for not existed battleground type %u, ignored.", entry, bgTypeId);
            continue;
        }

        mBattleMastersMap[entry] = BattlegroundTypeId(bgTypeId);
    }
    while (result->NextRow());

    CheckBattleMasters();

    sLog->outString(">> Loaded %u battlemaster entries in %u ms", count, GetMSTimeDiffToNow(oldMSTime));
    sLog->outString();
}

void BattlegroundMgr::CheckBattleMasters()
{
    CreatureTemplateContainer const* ctc = sObjectMgr->GetCreatureTemplates();
    for (CreatureTemplateContainer::const_iterator itr = ctc->begin(); itr != ctc->end(); ++itr)
    {
        if ((itr->second.npcflag & UNIT_NPC_FLAG_BATTLEMASTER) && mBattleMastersMap.find(itr->second.Entry) == mBattleMastersMap.end())
        {
            sLog->outErrorDb("CreatureTemplate (Entry: %u) has UNIT_NPC_FLAG_BATTLEMASTER but no data in `battlemaster_entry` table. Removing flag!", itr->second.Entry);
            const_cast<CreatureTemplate*>(&itr->second)->npcflag &= ~UNIT_NPC_FLAG_BATTLEMASTER;
        }
    }
}

HolidayIds BattlegroundMgr::BGTypeToWeekendHolidayId(BattlegroundTypeId bgTypeId)
{
    switch (bgTypeId)
    {
        case BATTLEGROUND_AV: return HOLIDAY_CALL_TO_ARMS_AV;
        case BATTLEGROUND_EY: return HOLIDAY_CALL_TO_ARMS_EY;
        case BATTLEGROUND_WS: return HOLIDAY_CALL_TO_ARMS_WS;
        case BATTLEGROUND_SA: return HOLIDAY_CALL_TO_ARMS_SA;
        case BATTLEGROUND_AB: return HOLIDAY_CALL_TO_ARMS_AB;
        case BATTLEGROUND_IC: return HOLIDAY_CALL_TO_ARMS_IC;
        default: return HOLIDAY_NONE;
    }
}

BattlegroundTypeId BattlegroundMgr::WeekendHolidayIdToBGType(HolidayIds holiday)
{
    switch (holiday)
    {
        case HOLIDAY_CALL_TO_ARMS_AV: return BATTLEGROUND_AV;
        case HOLIDAY_CALL_TO_ARMS_EY: return BATTLEGROUND_EY;
        case HOLIDAY_CALL_TO_ARMS_WS: return BATTLEGROUND_WS;
        case HOLIDAY_CALL_TO_ARMS_SA: return BATTLEGROUND_SA;
        case HOLIDAY_CALL_TO_ARMS_AB: return BATTLEGROUND_AB;
        case HOLIDAY_CALL_TO_ARMS_IC: return BATTLEGROUND_IC;
        default: return BATTLEGROUND_TYPE_NONE;
    }
}

bool BattlegroundMgr::IsBGWeekend(BattlegroundTypeId bgTypeId)
{
    return IsHolidayActive(BGTypeToWeekendHolidayId(bgTypeId));
}

void BattlegroundMgr::AddBattleground(Battleground* bg)
{
    if (bg->GetInstanceID() == 0)
        m_BattlegroundTemplates[bg->GetBgTypeID()] = bg;
    else
        m_Battlegrounds[bg->GetInstanceID()] = bg;
#ifdef ELUNA
    sEluna->OnBGCreate(bg, bg->GetBgTypeID(), bg->GetInstanceID());
#endif
}

void BattlegroundMgr::RemoveBattleground(BattlegroundTypeId bgTypeId, uint32 instanceId)
{
    if (instanceId == 0)
        m_BattlegroundTemplates.erase(bgTypeId);
    else
        m_Battlegrounds.erase(instanceId);
}

void BattlegroundMgr::InviteGroupToBG(GroupQueueInfo* ginfo, Battleground* bg, TeamId teamId)
{
    ASSERT(!ginfo->IsInvitedToBGInstanceGUID);

    // set side if needed
    if (teamId != TEAM_NEUTRAL)
        ginfo->teamId = teamId;

    // set invitation
    ginfo->IsInvitedToBGInstanceGUID = bg->GetInstanceID();

    BattlegroundQueueTypeId bgQueueTypeId = BattlegroundMgr::BGQueueTypeId(ginfo->BgTypeId, ginfo->ArenaType);
    BattlegroundQueue& bgQueue = sBattlegroundMgr->GetBattlegroundQueue(bgQueueTypeId);

    // set ArenaTeamId for rated matches
    if (bg->isArena() && bg->isRated())
        bg->SetArenaTeamIdForTeam(ginfo->teamId, ginfo->ArenaTeamId);

    ginfo->RemoveInviteTime = World::GetGameTimeMS() + INVITE_ACCEPT_WAIT_TIME;

    // loop through the players
    for (std::set<uint64>::iterator itr = ginfo->Players.begin(); itr != ginfo->Players.end(); ++itr)
    {
        // get the player
        Player* player = ObjectAccessor::FindPlayerInOrOutOfWorld(*itr);

        // player is removed from queue when logging out
        ASSERT(player);

        // update average wait time
        bgQueue.PlayerInvitedToBGUpdateAverageWaitTime(ginfo);

        // increase invited counter for each invited player
        bg->IncreaseInvitedCount(ginfo->teamId);

        // create remind invite events
        BGQueueInviteEvent* inviteEvent = new BGQueueInviteEvent(player->GetGUID(), ginfo->IsInvitedToBGInstanceGUID, ginfo->BgTypeId, ginfo->ArenaType, ginfo->RemoveInviteTime);
        bgQueue.AddEvent(inviteEvent, INVITATION_REMIND_TIME);
        // create automatic remove events
        BGQueueRemoveEvent* removeEvent = new BGQueueRemoveEvent(player->GetGUID(), ginfo->IsInvitedToBGInstanceGUID, bgQueueTypeId, ginfo->RemoveInviteTime);
        bgQueue.AddEvent(removeEvent, INVITE_ACCEPT_WAIT_TIME);

        WorldPacket data;

        uint32 queueSlot = player->GetBattlegroundQueueIndex(bgQueueTypeId);
        ASSERT(queueSlot < PLAYER_MAX_BATTLEGROUND_QUEUES);

        // send status packet
        sBattlegroundMgr->BuildBattlegroundStatusPacket(&data, bg, queueSlot, STATUS_WAIT_JOIN, INVITE_ACCEPT_WAIT_TIME, 0, ginfo->ArenaType, TEAM_NEUTRAL, bg->isRated(), ginfo->BgTypeId);
        player->GetSession()->SendPacket(&data);

        // pussywizard:
        if (bg->isArena() && bg->isRated())
            bg->ArenaLogEntries[player->GetGUID()].Fill(player->GetName().c_str(), player->GetGUIDLow(), player->GetSession()->GetAccountId(), ginfo->ArenaTeamId, player->GetSession()->GetRemoteAddress());
    }
}

RandomBattlegroundSystem::RandomBattlegroundSystem() : m_CurrentRandomBg(BATTLEGROUND_TYPE_NONE), m_SwitchTimer(0)
{
}

void RandomBattlegroundSystem::Update(uint32 diff)
{
    if (m_SwitchTimer <= diff)
    {
        if (m_BgOrder.empty())
        {
            // order it like: big, small, big, small, small, small (stored backwards, actually)

            std::vector<BattlegroundTypeId> big, small;
            big.push_back(BATTLEGROUND_AV);
            big.push_back(BATTLEGROUND_IC);
            small.push_back(BATTLEGROUND_WS);
            small.push_back(BATTLEGROUND_EY);
            small.push_back(BATTLEGROUND_AB);
            small.push_back(BATTLEGROUND_SA);

            std::random_shuffle(big.begin(), big.end());
            std::random_shuffle(small.begin(), small.end());

            m_BgOrder.push_back(small.back()); small.pop_back();
            m_BgOrder.push_back(small.back()); small.pop_back();
            m_BgOrder.push_back(small.back()); small.pop_back();
            m_BgOrder.push_back(big.back()); big.pop_back();
            m_BgOrder.push_back(small.back()); small.pop_back();
            m_BgOrder.push_back(big.back()); big.pop_back();
        }

        m_CurrentRandomBg = m_BgOrder.back();
        m_BgOrder.pop_back();

        switch (m_CurrentRandomBg)
        {
            case BATTLEGROUND_AV: m_SwitchTimer = 180*IN_MILLISECONDS; break; // max 40 per team
            case BATTLEGROUND_WS: m_SwitchTimer = 30*IN_MILLISECONDS; break; // max 10 per team
            case BATTLEGROUND_IC: m_SwitchTimer = 180*IN_MILLISECONDS; break; // max 40 per team
            case BATTLEGROUND_EY: m_SwitchTimer = 40*IN_MILLISECONDS; break; // max 15 per team
            case BATTLEGROUND_AB: m_SwitchTimer = 40*IN_MILLISECONDS; break; // max 15 per team
            case BATTLEGROUND_SA: m_SwitchTimer = 40*IN_MILLISECONDS; break; // max 15 per team
            default: ASSERT(false); break;
        }
    }
    else
        m_SwitchTimer -= diff;
}

void RandomBattlegroundSystem::BattlegroundCreated(BattlegroundTypeId bgTypeId)
{
    // if created current random bg, set current to another one
    if (bgTypeId == m_CurrentRandomBg)
        Update(0xffffffff);
}

// init/update unordered_map
// Battlegrounds
std::unordered_map<int, BattlegroundQueueTypeId> BattlegroundMgr::bgToQueue = {
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

std::unordered_map<int, BattlegroundTypeId> BattlegroundMgr::queueToBg = {
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

std::unordered_map<int, Battleground*> BattlegroundMgr::bgtypeToBattleground = {
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

std::unordered_map<int, bgRef> BattlegroundMgr::bgTypeToTemplate = {
    { BATTLEGROUND_AV, [](Battleground *bg_t) -> Battleground*{ return new BattlegroundAV(*(BattlegroundAV*)bg_t); } },
    { BATTLEGROUND_WS, [](Battleground *bg_t) -> Battleground*{ return new BattlegroundWS(*(BattlegroundWS*)bg_t); } },
    { BATTLEGROUND_AB, [](Battleground *bg_t) -> Battleground*{ return new BattlegroundAB(*(BattlegroundAB*)bg_t); } },
    { BATTLEGROUND_NA, [](Battleground *bg_t) -> Battleground*{ return new BattlegroundNA(*(BattlegroundNA*)bg_t); } },
    { BATTLEGROUND_BE, [](Battleground *bg_t) -> Battleground*{ return new BattlegroundBE(*(BattlegroundBE*)bg_t); } },
    { BATTLEGROUND_EY, [](Battleground *bg_t) -> Battleground*{ return new BattlegroundEY(*(BattlegroundEY*)bg_t); } },
    { BATTLEGROUND_RL, [](Battleground *bg_t) -> Battleground*{ return new BattlegroundRL(*(BattlegroundRL*)bg_t); } },
    { BATTLEGROUND_SA, [](Battleground *bg_t) -> Battleground*{ return new BattlegroundSA(*(BattlegroundSA*)bg_t); } },
    { BATTLEGROUND_DS, [](Battleground *bg_t) -> Battleground*{ return new BattlegroundDS(*(BattlegroundDS*)bg_t); } },
    { BATTLEGROUND_RV, [](Battleground *bg_t) -> Battleground*{ return new BattlegroundRV(*(BattlegroundRV*)bg_t); } },
    { BATTLEGROUND_IC, [](Battleground *bg_t) -> Battleground*{ return new BattlegroundIC(*(BattlegroundIC*)bg_t); } },

    { BATTLEGROUND_RB, [](Battleground *bg_t) -> Battleground*{ return new Battleground(*bg_t); }, },
    { BATTLEGROUND_AA, [](Battleground *bg_t) -> Battleground*{ return new Battleground(*bg_t); }, },
};

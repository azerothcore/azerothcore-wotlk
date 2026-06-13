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

#include "ArenaTeamMgr.h"
#include "Chat.h"
#include "DatabaseEnv.h"
#include "Define.h"
#include "Language.h"
#include "Log.h"
#include "ObjectAccessor.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "World.h"

ArenaTeamMgr::ArenaTeamMgr()
{
    NextArenaTeamId = 1;
    LastArenaLogId = 0;
    NextTempArenaTeamId = 0xFFF00000;
}

ArenaTeamMgr::~ArenaTeamMgr()
{
    for (ArenaTeamContainer::iterator itr = ArenaTeamStore.begin(); itr != ArenaTeamStore.end(); ++itr)
        delete itr->second;
}

ArenaTeamMgr* ArenaTeamMgr::instance()
{
    static ArenaTeamMgr instance;
    return &instance;
}

// Arena teams collection
ArenaTeam* ArenaTeamMgr::GetArenaTeamById(uint32 arenaTeamId) const
{
    ArenaTeamContainer::const_iterator itr = ArenaTeamStore.find(arenaTeamId);
    if (itr != ArenaTeamStore.end())
        return itr->second;

    return nullptr;
}

ArenaTeam* ArenaTeamMgr::GetArenaTeamByName(const std::string& arenaTeamName) const
{
    std::string search = arenaTeamName;
    std::transform(search.begin(), search.end(), search.begin(), ::toupper);
    for (ArenaTeamContainer::const_iterator itr = ArenaTeamStore.begin(); itr != ArenaTeamStore.end(); ++itr)
    {
        std::string teamName = itr->second->GetName();
        std::transform(teamName.begin(), teamName.end(), teamName.begin(), ::toupper);
        if (search == teamName)
        {
            return itr->second;
        }
    }
    return nullptr;
}

ArenaTeam* ArenaTeamMgr::GetArenaTeamByName(std::string const& arenaTeamName, const uint32 type) const
{
    std::string search = arenaTeamName;
    std::transform(search.begin(), search.end(), search.begin(), ::toupper);
    for (auto itr = ArenaTeamStore.begin(); itr != ArenaTeamStore.end(); ++itr)
    {
        if (itr->second->GetType() != type)
        {
            continue;
        }
        std::string teamName = itr->second->GetName();
        std::transform(teamName.begin(), teamName.end(), teamName.begin(), ::toupper);
        if (search == teamName)
        {
            return itr->second;
        }
    }
    return nullptr;
}

ArenaTeam* ArenaTeamMgr::GetArenaTeamByCaptain(ObjectGuid guid) const
{
    for (ArenaTeamContainer::const_iterator itr = ArenaTeamStore.begin(); itr != ArenaTeamStore.end(); ++itr)
    {
        if (itr->second->GetCaptain() == guid)
        {
            return itr->second;
        }
    }
    return nullptr;
}

ArenaTeam* ArenaTeamMgr::GetArenaTeamByCaptain(ObjectGuid guid, const uint32 type) const
{
    for (ArenaTeamContainer::const_iterator itr = ArenaTeamStore.begin(); itr != ArenaTeamStore.end(); ++itr)
    {
        if (itr->second->GetCaptain() == guid && itr->second->GetType() == type)
        {
            return itr->second;
        }
    }
    return nullptr;
}

void ArenaTeamMgr::AddArenaTeam(ArenaTeam* arenaTeam)
{
    ArenaTeamStore[arenaTeam->GetId()] = arenaTeam;
}

void ArenaTeamMgr::RemoveArenaTeam(uint32 arenaTeamId)
{
    ArenaTeamStore.erase(arenaTeamId);
}

void ArenaTeamMgr::DeleteAllArenaTeams()
{
    for (auto const& [id, team] : ArenaTeamStore)
    {
        while (team->GetMembersSize() > 0)
            team->DelMember(team->GetMembers().front().Guid, false);

        delete team;
    }

    ArenaTeamStore.clear();

    CharacterDatabaseTransaction trans = CharacterDatabase.BeginTransaction();
    trans->Append("DELETE FROM arena_team_member");
    trans->Append("DELETE FROM arena_team");
    trans->Append("DELETE FROM character_arena_stats");
    CharacterDatabase.CommitTransaction(trans);

    NextArenaTeamId = 1;
}

uint32 ArenaTeamMgr::GenerateArenaTeamId()
{
    if (NextArenaTeamId >= MAX_ARENA_TEAM_ID)
    {
        LOG_ERROR("bg.arena", "Arena team ids overflow!! Can't continue, shutting down server. ");
        World::StopNow(ERROR_EXIT_CODE);
    }

    return NextArenaTeamId++;
}

uint32 ArenaTeamMgr::GenerateTempArenaTeamId()
{
    if (NextTempArenaTeamId >= MAX_TEMP_ARENA_TEAM_ID)
        NextTempArenaTeamId = MAX_ARENA_TEAM_ID;

    return NextTempArenaTeamId++;
}

void ArenaTeamMgr::LoadArenaTeams()
{
    uint32 oldMSTime = getMSTime();

    // Clean out the trash before loading anything
    CharacterDatabase.Execute("DELETE FROM arena_team_member WHERE arenaTeamId NOT IN (SELECT arenaTeamId FROM arena_team)");       // One-time query

    //                                                        0        1         2         3          4              5            6            7           8
    QueryResult result = CharacterDatabase.Query("SELECT arenaTeamId, name, captainGuid, type, backgroundColor, emblemStyle, emblemColor, borderStyle, borderColor, "
                         //      9        10        11         12           13        14
                         "rating, weekGames, weekWins, seasonGames, seasonWins, `rank` FROM arena_team ORDER BY arenaTeamId ASC");

    if (!result)
    {
        LOG_WARN("server.loading", ">> Loaded 0 arena teams. DB table `arena_team` is empty!");
        LOG_INFO("server.loading", " ");
        return;
    }

    QueryResult result2 = CharacterDatabase.Query(
                              //              0              1           2             3              4                 5          6     7          8                  9      10
                              "SELECT arenaTeamId, atm.guid, atm.weekGames, atm.weekWins, atm.seasonGames, atm.seasonWins, c.name, class, personalRating, matchMakerRating, maxMMR FROM arena_team_member atm"
                              " INNER JOIN arena_team ate USING (arenaTeamId)"
                              " LEFT JOIN characters AS c ON atm.guid = c.guid"
                              " LEFT JOIN character_arena_stats AS cas ON c.guid = cas.guid AND (cas.slot = 0 AND ate.type = 2 OR cas.slot = 1 AND ate.type = 3 OR cas.slot = 2 AND ate.type = 5)"
                              " ORDER BY atm.arenateamid ASC");

    uint32 count = 0;
    do
    {
        ArenaTeam* newArenaTeam = new ArenaTeam;

        if (!newArenaTeam->LoadArenaTeamFromDB(result) || !newArenaTeam->LoadMembersFromDB(result2))
        {
            newArenaTeam->Disband(nullptr);
            delete newArenaTeam;
            continue;
        }

        AddArenaTeam(newArenaTeam);

        ++count;
    } while (result->NextRow());

    LOG_INFO("server.loading", ">> Loaded {} arena teams in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
}

void ArenaTeamMgr::DistributeArenaPoints()
{
    // Used to distribute arena points based on last week's stats
    ChatHandler(nullptr).SendWorldText(LANG_DIST_ARENA_POINTS_START);

    ChatHandler(nullptr).SendWorldText(LANG_DIST_ARENA_POINTS_ONLINE_START);

    // Temporary structure for storing maximum points to add values for all players
    std::map<ObjectGuid, uint32> PlayerPoints;

    // At first update all points for all team members
    for (ArenaTeamContainer::iterator teamItr = GetArenaTeamMapBegin(); teamItr != GetArenaTeamMapEnd(); ++teamItr)
        if (ArenaTeam* at = teamItr->second)
        {
            at->UpdateArenaPointsHelper(PlayerPoints);
            sScriptMgr->OnBeforeUpdateArenaPoints(at, PlayerPoints);
        }

    CharacterDatabaseTransaction trans = CharacterDatabase.BeginTransaction();

    CharacterDatabasePreparedStatement* stmt;

    // Cycle that gives points to all players
    for (std::map<ObjectGuid, uint32>::iterator playerItr = PlayerPoints.begin(); playerItr != PlayerPoints.end(); ++playerItr)
    {
        // Add points to player if online
        if (Player* player = ObjectAccessor::FindPlayer(playerItr->first))
            player->ModifyArenaPoints(playerItr->second, trans);
        else    // Update database
        {
            stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_CHAR_ARENA_POINTS);
            stmt->SetData(0, playerItr->second);
            stmt->SetData(1, playerItr->first.GetCounter());
            trans->Append(stmt);
        }
    }

    CharacterDatabase.CommitTransaction(trans);

    PlayerPoints.clear();

    ChatHandler(nullptr).SendWorldText(LANG_DIST_ARENA_POINTS_ONLINE_END);

    ChatHandler(nullptr).SendWorldText(LANG_DIST_ARENA_POINTS_TEAM_START);
    for (ArenaTeamContainer::iterator titr = GetArenaTeamMapBegin(); titr != GetArenaTeamMapEnd(); ++titr)
    {
        if (ArenaTeam* at = titr->second)
        {
            if (at->FinishWeek())
                at->SaveToDB(true);

            at->NotifyStatsChanged();
        }
    }

    ChatHandler(nullptr).SendWorldText(LANG_DIST_ARENA_POINTS_TEAM_END);

    ChatHandler(nullptr).SendWorldText(LANG_DIST_ARENA_POINTS_END);
}

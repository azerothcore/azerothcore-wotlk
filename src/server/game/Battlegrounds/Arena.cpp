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

#include "Arena.h"
#include "ArenaTeamMgr.h"
#include "GroupMgr.h"
#include "Log.h"
#include "ObjectAccessor.h"
#include "Pet.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "World.h"
#include "WorldSession.h"
#include "WorldSessionMgr.h"
#include "WorldStateDefines.h"
#include "WorldStatePackets.h"

void ArenaScore::AppendToPacket(WorldPacket& data)
{
    data << PlayerGuid;

    data << uint32(KillingBlows);
    data << uint8(PvPTeamId);
    data << uint32(DamageDone);
    data << uint32(HealingDone);

    BuildObjectivesBlock(data);
}

void ArenaScore::BuildObjectivesBlock(WorldPacket& data)
{
    data << uint32(0); // Objectives Count
}

void ArenaTeamScore::BuildRatingInfoBlock(WorldPacket& data)
{
    uint32 ratingLost = std::abs(std::min(RatingChange, 0));
    uint32 ratingWon = std::max(RatingChange, 0);

    // should be old rating, new rating, and client will calculate rating change itself
    data << uint32(ratingLost);
    data << uint32(ratingWon);
    data << uint32(MatchmakerRating);
}

void ArenaTeamScore::BuildTeamInfoBlock(WorldPacket& data)
{
    data << TeamName;
}

Arena::Arena()
{
    StartDelayTimes[BG_STARTING_EVENT_FIRST]  = BG_START_DELAY_1M;
    StartDelayTimes[BG_STARTING_EVENT_SECOND] = BG_START_DELAY_30S;
    StartDelayTimes[BG_STARTING_EVENT_THIRD]  = BG_START_DELAY_15S;
    StartDelayTimes[BG_STARTING_EVENT_FOURTH] = BG_START_DELAY_NONE;

    StartMessageIds[BG_STARTING_EVENT_FIRST]  = ARENA_TEXT_START_ONE_MINUTE;
    StartMessageIds[BG_STARTING_EVENT_SECOND] = ARENA_TEXT_START_THIRTY_SECONDS;
    StartMessageIds[BG_STARTING_EVENT_THIRD]  = ARENA_TEXT_START_FIFTEEN_SECONDS;
    StartMessageIds[BG_STARTING_EVENT_FOURTH] = ARENA_TEXT_START_BATTLE_HAS_BEGUN;
}

void Arena::AddPlayer(Player* player)
{
    Battleground::AddPlayer(player);
    PlayerScores.emplace(player->GetGUID().GetCounter(), new ArenaScore(player->GetGUID(), player->GetBgTeamId()));

    if (player->GetBgTeamId() == TEAM_ALLIANCE) // gold
    {
        if (player->GetTeamId() == TEAM_HORDE)
            player->CastSpell(player, SPELL_HORDE_GOLD_FLAG, true);
        else
            player->CastSpell(player, SPELL_ALLIANCE_GOLD_FLAG, true);
    }
    else // green
    {
        if (player->GetTeamId() == TEAM_HORDE)
            player->CastSpell(player, SPELL_HORDE_GREEN_FLAG, true);
        else
            player->CastSpell(player, SPELL_ALLIANCE_GREEN_FLAG, true);
    }

    UpdateArenaWorldState();

    Group* group = player->GetGroup();
    if (group)
    {
        // Hackfix for crossfaction arenas, recreate group when joining
        // Without this, players in a crossfaction arena group would not be able to cast beneficial spells on their teammates

        std::vector<Player*> members;
        bool isCrossfaction = false;
        for (Group::member_citerator mitr = group->GetMemberSlots().begin(); mitr != group->GetMemberSlots().end(); ++mitr)
        {
            Player* member = ObjectAccessor::FindPlayer(mitr->guid);
            if (!member || member->GetGUID() == player->GetGUID())
            {
                continue;
            }
            members.push_back(member);
            if (member->GetTeamId(true) != player->GetTeamId(true))
            {
                isCrossfaction = true;
            }
        }

        if (isCrossfaction)
        {
            for (Player* member : members)
            {
                member->RemoveFromGroup();
            }
            group->Disband();

            group = new Group();
            SetBgRaid(player->GetBgTeamId(), group);
            group->Create(player);
            sGroupMgr->AddGroup(group);
            for (Player* member : members)
            {
                group->AddMember(member);
            }
        }
    }
}

void Arena::RemovePlayer(Player* /*player*/)
{
    if (GetStatus() == STATUS_WAIT_LEAVE)
        return;

    UpdateArenaWorldState();
    CheckWinConditions();
}

void Arena::FillInitialWorldStates(WorldPackets::WorldState::InitWorldStates& packet)
{
    packet.Worldstates.reserve(2);
    packet.Worldstates.emplace_back(WORLD_STATE_ARENA_ALIVE_PLAYERS_GREEN, GetAlivePlayersCountByTeam(TEAM_HORDE));
    packet.Worldstates.emplace_back(WORLD_STATE_ARENA_ALIVE_PLAYERS_GOLD, GetAlivePlayersCountByTeam(TEAM_ALLIANCE));
}

void Arena::UpdateArenaWorldState()
{
    UpdateWorldState(WORLD_STATE_ARENA_ALIVE_PLAYERS_GREEN, GetAlivePlayersCountByTeam(TEAM_HORDE));
    UpdateWorldState(WORLD_STATE_ARENA_ALIVE_PLAYERS_GOLD, GetAlivePlayersCountByTeam(TEAM_ALLIANCE));
}

void Arena::HandleKillPlayer(Player* player, Player* killer)
{
    if (GetStatus() != STATUS_IN_PROGRESS)
        return;

    Battleground::HandleKillPlayer(player, killer);

    UpdateArenaWorldState();
    CheckWinConditions();
}

void Arena::RemovePlayerAtLeave(Player* player)
{
    if (isRated() && GetStatus() == STATUS_IN_PROGRESS)
    {
        if (auto const& member = Acore::Containers::MapGetValuePtr(m_Players, player->GetGUID()))
        {
            // if the player was a match participant, calculate rating
            auto teamId = member->GetBgTeamId();

            ArenaTeam* winnerArenaTeam = sArenaTeamMgr->GetArenaTeamById(GetArenaTeamIdForTeam(GetOtherTeamId(teamId)));
            ArenaTeam* loserArenaTeam = sArenaTeamMgr->GetArenaTeamById(GetArenaTeamIdForTeam(teamId));

            if (winnerArenaTeam && loserArenaTeam && winnerArenaTeam != loserArenaTeam)
                loserArenaTeam->MemberLost(player, GetArenaMatchmakerRating(GetOtherTeamId(teamId)));
        }
    }

    // remove player
    Battleground::RemovePlayerAtLeave(player);
}

void Arena::CheckWinConditions()
{
    if (!sScriptMgr->OnBeforeArenaCheckWinConditions(this))
        return;

    if (!GetAlivePlayersCountByTeam(TEAM_ALLIANCE) && GetPlayersCountByTeam(TEAM_HORDE))
        EndBattleground(TEAM_HORDE);
    else if (GetPlayersCountByTeam(TEAM_ALLIANCE) && !GetAlivePlayersCountByTeam(TEAM_HORDE))
        EndBattleground(TEAM_ALLIANCE);
}

void Arena::EndBattleground(TeamId winnerTeamId)
{
    if (isRated())
    {
        uint32 startDelay = GetStartDelayTime();
        bool bValidArena = GetStatus() == STATUS_IN_PROGRESS && GetStartTime() >= startDelay + 15000; // pussywizard: only if arena lasted at least 15 secs

        uint32 loserTeamRating = 0;
        uint32 loserMatchmakerRating = 0;
        int32  loserChange = 0;
        int32  loserMatchmakerChange = 0;
        uint32 winnerTeamRating = 0;
        uint32 winnerMatchmakerRating = 0;
        int32  winnerChange = 0;
        int32  winnerMatchmakerChange = 0;

        ArenaTeam* winnerArenaTeam = sArenaTeamMgr->GetArenaTeamById(GetArenaTeamIdForTeam(winnerTeamId == TEAM_NEUTRAL ? TEAM_HORDE : winnerTeamId));
        ArenaTeam* loserArenaTeam  = sArenaTeamMgr->GetArenaTeamById(GetArenaTeamIdForTeam(winnerTeamId == TEAM_NEUTRAL ? TEAM_ALLIANCE : GetOtherTeamId(winnerTeamId)));

        auto SaveArenaLogs = [&]()
        {
            // pussywizard: arena logs in database
            uint32 fightId = sArenaTeamMgr->GetNextArenaLogId();
            uint32 currOnline = sWorldSessionMgr->GetActiveSessionCount();

            CharacterDatabaseTransaction trans = CharacterDatabase.BeginTransaction();
            CharacterDatabasePreparedStatement* stmt2 = CharacterDatabase.GetPreparedStatement(CHAR_INS_ARENA_LOG_FIGHT);
            stmt2->SetData(0, fightId);
            stmt2->SetData(1, GetArenaType());
            stmt2->SetData(2, ((GetStartTime() <= startDelay ? 0 : GetStartTime() - startDelay) / 1000));
            stmt2->SetData(3, winnerArenaTeam->GetId());
            stmt2->SetData(4, loserArenaTeam->GetId());
            stmt2->SetData(5, (uint16)winnerTeamRating);
            stmt2->SetData(6, (uint16)winnerMatchmakerRating);
            stmt2->SetData(7, (int16)winnerChange);
            stmt2->SetData(8, (uint16)loserTeamRating);
            stmt2->SetData(9, (uint16)loserMatchmakerRating);
            stmt2->SetData(10, (int16)loserChange);
            stmt2->SetData(11, currOnline);
            trans->Append(stmt2);

            uint8 memberId = 0;
            for (auto const& [playerGuid, arenaLogEntryData] : ArenaLogEntries)
            {
                auto const& score = PlayerScores.find(playerGuid.GetCounter());
                stmt2 = CharacterDatabase.GetPreparedStatement(CHAR_INS_ARENA_LOG_MEMBERSTATS);
                stmt2->SetData(0, fightId);
                stmt2->SetData(1, ++memberId);
                stmt2->SetData(2, arenaLogEntryData.Name);
                stmt2->SetData(3, arenaLogEntryData.Guid);
                stmt2->SetData(4, arenaLogEntryData.ArenaTeamId);
                stmt2->SetData(5, arenaLogEntryData.Acc);
                stmt2->SetData(6, arenaLogEntryData.IP);
                if (score != PlayerScores.end())
                {
                    stmt2->SetData(7, score->second->GetDamageDone());
                    stmt2->SetData(8, score->second->GetHealingDone());
                    stmt2->SetData(9, score->second->GetKillingBlows());
                }
                else
                {
                    stmt2->SetData(7, 0);
                    stmt2->SetData(8, 0);
                    stmt2->SetData(9, 0);
                }
                trans->Append(stmt2);
            }

            CharacterDatabase.CommitTransaction(trans);
        };

        if (winnerArenaTeam && loserArenaTeam && winnerArenaTeam != loserArenaTeam)
        {
            loserTeamRating = loserArenaTeam->GetRating();
            loserMatchmakerRating = GetArenaMatchmakerRating(GetOtherTeamId(winnerTeamId));
            winnerTeamRating = winnerArenaTeam->GetRating();
            winnerMatchmakerRating = GetArenaMatchmakerRating(winnerTeamId);

            if (winnerTeamId != TEAM_NEUTRAL)
            {
                winnerMatchmakerChange = bValidArena ? winnerArenaTeam->WonAgainst(winnerMatchmakerRating, loserMatchmakerRating, winnerChange, GetBgMap()) : 0;
                loserMatchmakerChange = loserArenaTeam->LostAgainst(loserMatchmakerRating, winnerMatchmakerRating, loserChange, GetBgMap());

                sScriptMgr->OnAfterArenaRatingCalculation(this, winnerMatchmakerChange, loserMatchmakerChange, winnerChange, loserChange);

                LOG_DEBUG("bg.arena", "match Type: {} --- Winner: old rating: {}, rating gain: {}, old MMR: {}, MMR gain: {} --- Loser: old rating: {}, rating loss: {}, old MMR: {}, MMR loss: {} ---",
                    GetArenaType(), winnerTeamRating, winnerChange, winnerMatchmakerRating, winnerMatchmakerChange,
                    loserTeamRating, loserChange, loserMatchmakerRating, loserMatchmakerChange);

                SetArenaMatchmakerRating(winnerTeamId, winnerMatchmakerRating + winnerMatchmakerChange);
                SetArenaMatchmakerRating(GetOtherTeamId(winnerTeamId), loserMatchmakerRating + loserMatchmakerChange);

                // bg team that the client expects is different to TeamId
                // alliance 1, horde 0
                uint8 winnerTeam = winnerTeamId == TEAM_ALLIANCE ? PVP_TEAM_ALLIANCE : PVP_TEAM_HORDE;
                uint8 loserTeam = winnerTeamId == TEAM_ALLIANCE ? PVP_TEAM_HORDE : PVP_TEAM_ALLIANCE;

                _arenaTeamScores[winnerTeam].Assign(winnerChange, winnerMatchmakerRating, winnerArenaTeam->GetName());
                _arenaTeamScores[loserTeam].Assign(loserChange, loserMatchmakerRating, loserArenaTeam->GetName());

                LOG_DEBUG("bg.arena", "Arena match Type: {} for Team1Id: {} - Team2Id: {} ended. WinnerTeamId: {}. Winner rating: +{}, Loser rating: {}",
                    GetArenaType(), GetArenaTeamIdForTeam(TEAM_ALLIANCE), GetArenaTeamIdForTeam(TEAM_HORDE), winnerArenaTeam->GetId(), winnerChange, loserChange);
            }
            else // Deduct 16 points from each teams arena-rating if there are no winners after 45+2 minutes
            {
                // pussywizard: in case of a draw, the following is always true:
                // winnerArenaTeam => TEAM_HORDE, loserArenaTeam => TEAM_ALLIANCE

                winnerTeamRating = winnerArenaTeam->GetRating();
                winnerMatchmakerRating = GetArenaMatchmakerRating(TEAM_HORDE);
                loserTeamRating = loserArenaTeam->GetRating();
                loserMatchmakerRating = GetArenaMatchmakerRating(TEAM_ALLIANCE);
                winnerMatchmakerChange = 0;
                loserMatchmakerChange = 0;
                winnerChange = ARENA_TIMELIMIT_POINTS_LOSS;
                loserChange = ARENA_TIMELIMIT_POINTS_LOSS;

                _arenaTeamScores[PVP_TEAM_ALLIANCE].Assign(ARENA_TIMELIMIT_POINTS_LOSS, winnerMatchmakerRating, winnerArenaTeam->GetName());
                _arenaTeamScores[PVP_TEAM_HORDE].Assign(ARENA_TIMELIMIT_POINTS_LOSS, loserMatchmakerRating, loserArenaTeam->GetName());

                winnerArenaTeam->FinishGame(ARENA_TIMELIMIT_POINTS_LOSS, GetBgMap());
                loserArenaTeam->FinishGame(ARENA_TIMELIMIT_POINTS_LOSS, GetBgMap());
            }
        }

        SaveArenaLogs();

        uint8 aliveWinners = GetAlivePlayersCountByTeam(winnerTeamId);

        for (auto const& [playerGuid, player] : GetPlayers())
        {
            auto const& bgTeamId = player->GetBgTeamId();

            // per player calculation
            if (winnerArenaTeam && loserArenaTeam && winnerArenaTeam != loserArenaTeam)
            {
                if (bgTeamId == winnerTeamId)
                {
                    if (bValidArena)
                    {
                        // update achievement BEFORE personal rating update
                        uint32 rating = player->GetArenaPersonalRating(winnerArenaTeam->GetSlot());
                        player->UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_WIN_RATED_ARENA, rating ? rating : 1);
                        player->UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_WIN_ARENA, GetMapId());

                        // Last standing - Rated 5v5 arena & be solely alive player
                        if (GetArenaType() == ARENA_TYPE_5v5 && aliveWinners == 1 && player->IsAlive())
                        {
                            player->CastSpell(player, SPELL_LAST_MAN_STANDING, true);
                        }

                        winnerArenaTeam->MemberWon(player, loserMatchmakerRating, winnerMatchmakerChange);
                    }
                }
                else
                {
                    loserArenaTeam->MemberLost(player, winnerMatchmakerRating, loserMatchmakerChange);

                    // Arena lost => reset the win_rated_arena having the "no_lose" condition
                    player->ResetAchievementCriteria(ACHIEVEMENT_CRITERIA_CONDITION_NO_LOSE, 0);
                }

                player->UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_PLAY_ARENA, GetMapId());
            }
        }

        // update previous opponents for arena queue
        winnerArenaTeam->SetPreviousOpponents(loserArenaTeam->GetId());
        loserArenaTeam->SetPreviousOpponents(winnerArenaTeam->GetId());

        // save the stat changes
        if (bValidArena)
        {
            winnerArenaTeam->SaveToDB();
            winnerArenaTeam->NotifyStatsChanged();
        }

        loserArenaTeam->SaveToDB();
        loserArenaTeam->NotifyStatsChanged();
    }

    // end battleground
    Battleground::EndBattleground(winnerTeamId);
}

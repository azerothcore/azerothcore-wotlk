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

#ifndef AZEROTHCORE_ARENATEAM_H
#define AZEROTHCORE_ARENATEAM_H

#include "Map.h"
#include "QueryResult.h"
#include <list>
#include <map>

class WorldSession;
class WorldPacket;
class Player;
class Group;

enum ArenaTeamCommandTypes
{
    ERR_ARENA_TEAM_CREATE_S                 = 0x00,
    ERR_ARENA_TEAM_INVITE_SS                = 0x01,
    ERR_ARENA_TEAM_QUIT_S                   = 0x03,
    ERR_ARENA_TEAM_FOUNDER_S                = 0x0E
};

enum ArenaTeamCommandErrors
{
    ERR_ARENA_TEAM_INTERNAL                 = 0x01,
    ERR_ALREADY_IN_ARENA_TEAM               = 0x02,
    ERR_ALREADY_IN_ARENA_TEAM_S             = 0x03,
    ERR_INVITED_TO_ARENA_TEAM               = 0x04,
    ERR_ALREADY_INVITED_TO_ARENA_TEAM_S     = 0x05,
    ERR_ARENA_TEAM_NAME_INVALID             = 0x06,
    ERR_ARENA_TEAM_NAME_EXISTS_S            = 0x07,
    ERR_ARENA_TEAM_LEADER_LEAVE_S           = 0x08,
    ERR_ARENA_TEAM_PERMISSIONS              = 0x08,
    ERR_ARENA_TEAM_PLAYER_NOT_IN_TEAM       = 0x09,
    ERR_ARENA_TEAM_PLAYER_NOT_IN_TEAM_SS    = 0x0A,
    ERR_ARENA_TEAM_PLAYER_NOT_FOUND_S       = 0x0B,
    ERR_ARENA_TEAM_NOT_ALLIED               = 0x0C,
    ERR_ARENA_TEAM_IGNORING_YOU_S           = 0x13,
    ERR_ARENA_TEAM_TARGET_TOO_LOW_S         = 0x15,
    ERR_ARENA_TEAM_TARGET_TOO_HIGH_S        = 0x16,
    ERR_ARENA_TEAM_TOO_MANY_MEMBERS_S       = 0x17,
    ERR_ARENA_TEAM_NOT_FOUND                = 0x1B,
    ERR_ARENA_TEAMS_LOCKED                  = 0x1E
};

enum ArenaTeamEvents
{
    ERR_ARENA_TEAM_JOIN_SS                  = 3,            // player name + arena team name
    ERR_ARENA_TEAM_LEAVE_SS                 = 4,            // player name + arena team name
    ERR_ARENA_TEAM_REMOVE_SSS               = 5,            // player name + arena team name + captain name
    ERR_ARENA_TEAM_LEADER_IS_SS             = 6,            // player name + arena team name
    ERR_ARENA_TEAM_LEADER_CHANGED_SSS       = 7,            // old captain + new captain + arena team name
    ERR_ARENA_TEAM_DISBANDED_S              = 8             // captain name + arena team name
};

// PLAYER_FIELD_ARENA_TEAM_INFO_1_1 offsets
enum ArenaTeamInfoType : uint8
{
    ARENA_TEAM_ID                = 0,
    ARENA_TEAM_TYPE              = 1,                       // new in 3.2 - team type?
    ARENA_TEAM_MEMBER            = 2,                       // 0 - captain, 1 - member
    ARENA_TEAM_GAMES_WEEK        = 3,
    ARENA_TEAM_GAMES_SEASON      = 4,
    ARENA_TEAM_WINS_SEASON       = 5,
    ARENA_TEAM_PERSONAL_RATING   = 6,
    ARENA_TEAM_END               = 7
};

/*
need info how to send these ones:
ERR_ARENA_TEAM_YOU_JOIN_S - client show it automatically when accept invite
ERR_ARENA_TEAM_TARGET_TOO_LOW_S
ERR_ARENA_TEAM_TOO_MANY_MEMBERS_S
ERR_ARENA_TEAM_LEVEL_TOO_LOW_I
*/

// EnumUtils: DESCRIBE THIS
enum ArenaTeamTypes
{
    ARENA_TEAM_2v2      = 2,
    ARENA_TEAM_3v3      = 3,
    ARENA_TEAM_5v5      = 5
};

enum ArenaSlot
{
    ARENA_SLOT_2v2,
    ARENA_SLOT_3v3,
    ARENA_SLOT_5v5
};

struct ArenaTeamMember
{
    ObjectGuid Guid;
    std::string Name;
    uint8 Class;
    uint16 WeekGames;
    uint16 WeekWins;
    uint16 SeasonGames;
    uint16 SeasonWins;
    uint16 PersonalRating;
    uint16 MatchMakerRating;
    uint16 MaxMMR;

    void ModifyPersonalRating(Player* player, int32 mod, uint32 type);
    void ModifyMatchmakerRating(int32 mod, uint32 slot);
};

struct ArenaTeamStats
{
    uint16 Rating;
    uint16 WeekGames;
    uint16 WeekWins;
    uint16 SeasonGames;
    uint16 SeasonWins;
    uint32 Rank;
};

#define MAX_ARENA_SLOT 3                                    // 0..2 slots

class ArenaTeam
{
public:
    ArenaTeam();
    ~ArenaTeam();

    auto Create(ObjectGuid captainGuid, uint8 type, std::string const& teamName, uint32 backgroundColor, uint8 emblemStyle, uint32 emblemColor, uint8 borderStyle, uint32 borderColor) -> bool;
    void Disband(WorldSession* session);
    void Disband();

    typedef std::list<ArenaTeamMember> MemberList;

    [[nodiscard]] auto GetId() const -> uint32              { return TeamId; }
    [[nodiscard]] auto GetType() const -> uint32            { return Type; }
    [[nodiscard]] auto  GetSlot() const -> uint8            { return GetSlotByType(GetType()); }
    static auto GetSlotByType(uint32 type) -> uint8;
    static auto GetReqPlayersForType(uint32 type) -> uint8;
    [[nodiscard]] auto GetCaptain() const -> ObjectGuid { return CaptainGuid; }
    [[nodiscard]] auto GetName() const -> std::string const&       { return TeamName; }
    [[nodiscard]] auto GetStats() const -> const ArenaTeamStats& { return Stats; }
    void SetArenaTeamStats(ArenaTeamStats& stats) { Stats = stats; }

    [[nodiscard]] auto GetRating() const -> uint32          { return Stats.Rating; }
    auto GetAverageMMR(Group* group) const -> uint32;

    void SetCaptain(ObjectGuid guid);
    auto SetName(std::string const& name) -> bool;
    auto AddMember(ObjectGuid playerGuid) -> bool;

    // Shouldn't be ObjectGuid, because than can reference guid from members on Disband
    // and this method removes given record from list. So invalid reference can happen.
    void DelMember(ObjectGuid guid, bool cleanDb);

    [[nodiscard]] auto GetMembersSize() const -> size_t         { return Members.size(); }
    [[nodiscard]] auto   Empty() const -> bool                  { return Members.empty(); }
    auto m_membersBegin() -> MemberList::iterator { return Members.begin(); }
    auto m_membersEnd() -> MemberList::iterator   { return Members.end(); }
    auto GetMembers() -> MemberList& { return Members; }
    [[nodiscard]] auto IsMember(ObjectGuid guid) const -> bool;

    auto GetMember(ObjectGuid guid) -> ArenaTeamMember*;
    auto GetMember(std::string const& name) -> ArenaTeamMember*;

    [[nodiscard]] auto IsFighting() const -> bool;

    auto LoadArenaTeamFromDB(QueryResult arenaTeamDataResult) -> bool;
    auto LoadMembersFromDB(QueryResult arenaTeamMembersResult) -> bool;
    void LoadStatsFromDB(uint32 ArenaTeamId);
    void SaveToDB();

    void BroadcastPacket(WorldPacket* packet);
    void BroadcastEvent(ArenaTeamEvents event, ObjectGuid guid, uint8 strCount, std::string const& str1, std::string const& str2, std::string const& str3);
    void NotifyStatsChanged();

    void MassInviteToEvent(WorldSession* session);

    void Roster(WorldSession* session);
    void Query(WorldSession* session);
    void SendStats(WorldSession* session);
    void Inspect(WorldSession* session, ObjectGuid guid);

    auto GetPoints(uint32 MemberRating) -> uint32;
    auto  GetMatchmakerRatingMod(uint32 ownRating, uint32 opponentRating, bool won) -> int32;
    auto  GetRatingMod(uint32 ownRating, uint32 opponentRating, bool won) -> int32;
    auto  GetChanceAgainst(uint32 ownRating, uint32 opponentRating) -> float;
    auto  WonAgainst(uint32 Own_MMRating, uint32 Opponent_MMRating, int32& rating_change, const Map* bgMap) -> int32;
    void   MemberWon(Player* player, uint32 againstMatchmakerRating, int32 MatchmakerRatingChange);
    auto  LostAgainst(uint32 Own_MMRating, uint32 Opponent_MMRating, int32& rating_change, const Map* bgMap) -> int32;
    void   MemberLost(Player* player, uint32 againstMatchmakerRating, int32 MatchmakerRatingChange = -12);

    void UpdateArenaPointsHelper(std::map<ObjectGuid, uint32>& PlayerPoints);

    void FinishWeek();
    void FinishGame(int32 mod, const Map* bgMap);

    void CreateTempArenaTeam(std::vector<Player*> playerList, uint8 type, std::string const& teamName);

    // Containers
    static std::unordered_map<uint32, uint8> ArenaSlotByType; // Slot -> Type
    static std::unordered_map<uint8, uint8> ArenaReqPlayersForType; // Type -> Players count

protected:
    uint32      TeamId;
    uint8       Type;
    std::string TeamName;
    ObjectGuid  CaptainGuid;

    uint32 BackgroundColor; // ARGB format
    uint8  EmblemStyle;     // icon id
    uint32 EmblemColor;     // ARGB format
    uint8  BorderStyle;     // border image id
    uint32 BorderColor;     // ARGB format

    MemberList     Members;
    ArenaTeamStats Stats;
};
#endif

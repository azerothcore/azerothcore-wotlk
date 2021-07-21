/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef __BATTLEGROUNDQUEUE_H
#define __BATTLEGROUNDQUEUE_H

#include "Battleground.h"
#include "Common.h"
#include "DBCEnums.h"
#include "EventProcessor.h"
#include <deque>

#define COUNT_OF_PLAYERS_TO_AVERAGE_WAIT_TIME 10

struct GroupQueueInfo                                       // stores information about the group in queue (also used when joined as solo!)
{
    GuidSet Players;                                        // player guid set
    TeamId  teamId;                                         // Player team (TEAM_ALLIANCE/TEAM_HORDE)
    TeamId  RealTeamID;                                     // Realm player team (TEAM_ALLIANCE/TEAM_HORDE)
    BattlegroundTypeId BgTypeId;                            // battleground type id
    bool    IsRated;                                        // rated
    uint8   ArenaType;                                      // 2v2, 3v3, 5v5 or 0 when BG
    uint32  ArenaTeamId;                                    // team id if rated match
    uint32  JoinTime;                                       // time when group was added
    uint32  RemoveInviteTime;                               // time when we will remove invite for players in group
    uint32  IsInvitedToBGInstanceGUID;                      // was invited to certain BG
    uint32  ArenaTeamRating;                                // if rated match, inited to the rating of the team
    uint32  ArenaMatchmakerRating;                          // if rated match, inited to the rating of the team
    uint32  OpponentsTeamRating;                            // for rated arena matches
    uint32  OpponentsMatchmakerRating;                      // for rated arena matches

    // pussywizard: for internal use
    uint8 _bracketId;
    uint8 _groupType;
};

enum BattlegroundQueueGroupTypes
{
    BG_QUEUE_PREMADE_ALLIANCE,
    BG_QUEUE_PREMADE_HORDE,
    BG_QUEUE_NORMAL_ALLIANCE,
    BG_QUEUE_NORMAL_HORDE,

    BG_QUEUE_MAX = 10
};

class Battleground;
class BattlegroundQueue
{
public:
    BattlegroundQueue();
    ~BattlegroundQueue();

    void BattlegroundQueueUpdate(BattlegroundBracketId bracket_id, bool isRated, uint32 arenaRatedTeamId);
    void UpdateEvents(uint32 diff);

    void FillPlayersToBG(Battleground* bg, int32 aliFree, int32 hordeFree, BattlegroundBracketId bracket_id);
    void FillPlayersToBGWithSpecific(Battleground* bg, int32 aliFree, int32 hordeFree, BattlegroundBracketId thisBracketId, BattlegroundQueue* specificQueue, BattlegroundBracketId specificBracketId);
    bool CheckPremadeMatch(BattlegroundBracketId bracket_id, uint32 MinPlayersPerTeam, uint32 MaxPlayersPerTeam);
    bool CheckNormalMatch(Battleground* bgTemplate, BattlegroundBracketId bracket_id, uint32 minPlayers, uint32 maxPlayers);
    bool CheckSkirmishForSameFaction(BattlegroundBracketId bracket_id, uint32 minPlayersPerTeam);
    GroupQueueInfo* AddGroup(Player* leader, Group* group, PvPDifficultyEntry const* bracketEntry, bool isRated, bool isPremade, uint32 ArenaRating, uint32 MatchmakerRating, uint32 ArenaTeamId);
    void RemovePlayer(ObjectGuid guid, bool sentToBg, uint32 playerQueueSlot);
    bool IsPlayerInvitedToRatedArena(ObjectGuid pl_guid);
    bool IsPlayerInvited(ObjectGuid pl_guid, uint32 bgInstanceGuid, uint32 removeTime);
    bool GetPlayerGroupInfoData(ObjectGuid guid, GroupQueueInfo* ginfo);
    void PlayerInvitedToBGUpdateAverageWaitTime(GroupQueueInfo* ginfo);
    uint32 GetAverageQueueWaitTime(GroupQueueInfo* ginfo) const;
    [[nodiscard]] uint32 GetPlayersCountInGroupsQueue(BattlegroundBracketId bracketId, BattlegroundQueueGroupTypes bgqueue);
    [[nodiscard]] bool IsAllQueuesEmpty(BattlegroundBracketId bracket_id);
    void SendMessageBGQueue(Player* leader, Battleground* bg, PvPDifficultyEntry const* bracketEntry);
    void SendJoinMessageArenaQueue(Player* leader, GroupQueueInfo* ginfo, PvPDifficultyEntry const* bracketEntry, bool isRated);
    void SendExitMessageArenaQueue(GroupQueueInfo* ginfo);

    void SetBgTypeIdAndArenaType(BattlegroundTypeId b, uint8 a) { m_bgTypeId = b; m_arenaType = ArenaType(a); } // pussywizard
    void AddEvent(BasicEvent* Event, uint64 e_time);

    typedef std::map<ObjectGuid, GroupQueueInfo*> QueuedPlayersMap;
    QueuedPlayersMap m_QueuedPlayers;

    //do NOT use deque because deque.erase() invalidates ALL iterators
    typedef std::list<GroupQueueInfo*> GroupsQueueType;

    /*
    This two dimensional array is used to store All queued groups
    First dimension specifies the bgTypeId
    Second dimension specifies the player's group types -
         BG_QUEUE_PREMADE_ALLIANCE  is used for premade alliance groups and alliance rated arena teams
         BG_QUEUE_PREMADE_HORDE     is used for premade horde groups and horde rated arena teams
         BG_QUEUE_NORMAL_ALLIANCE   is used for normal (or small) alliance groups or non-rated arena matches
         BG_QUEUE_NORMAL_HORDE      is used for normal (or small) horde groups or non-rated arena matches
    */
    GroupsQueueType m_QueuedGroups[MAX_BATTLEGROUND_BRACKETS][BG_QUEUE_MAX];

    // class to select and invite groups to bg
    class SelectionPool
    {
    public:
        SelectionPool(): PlayerCount(0) {};
        void Init();
        bool AddGroup(GroupQueueInfo* ginfo, uint32 desiredCount);
        bool KickGroup(uint32 size);
        [[nodiscard]] uint32 GetPlayerCount() const { return PlayerCount; }
    public:
        GroupsQueueType SelectedGroups;
    private:
        uint32 PlayerCount;
    };

    //one selection pool for horde, other one for alliance
    SelectionPool m_SelectionPools[BG_TEAMS_COUNT];

    ArenaType GetArenaType() { return m_arenaType; }
    BattlegroundTypeId GetBGTypeID() { return m_bgTypeId; }
private:
    BattlegroundTypeId m_bgTypeId;
    ArenaType m_arenaType;
    uint32 m_WaitTimes[BG_TEAMS_COUNT][MAX_BATTLEGROUND_BRACKETS][COUNT_OF_PLAYERS_TO_AVERAGE_WAIT_TIME];
    uint32 m_WaitTimeLastIndex[BG_TEAMS_COUNT][MAX_BATTLEGROUND_BRACKETS];

    // Event handler
    EventProcessor m_events;
};

/*
    This class is used to invite player to BG again, when minute lasts from his first invitation
    it is capable to solve all possibilities
*/
class BGQueueInviteEvent : public BasicEvent
{
public:
    BGQueueInviteEvent(ObjectGuid pl_guid, uint32 BgInstanceGUID, BattlegroundTypeId BgTypeId, uint8 arenaType, uint32 removeTime) :
        m_PlayerGuid(pl_guid), m_BgInstanceGUID(BgInstanceGUID), m_BgTypeId(BgTypeId), m_ArenaType(arenaType), m_RemoveTime(removeTime)
    { }
    ~BGQueueInviteEvent() override = default;

    bool Execute(uint64 e_time, uint32 p_time) override;
    void Abort(uint64 e_time) override;
private:
    ObjectGuid m_PlayerGuid;
    uint32 m_BgInstanceGUID;
    BattlegroundTypeId m_BgTypeId;
    uint8  m_ArenaType;
    uint32 m_RemoveTime;
};

/*
    This class is used to remove player from BG queue after 1 minute 20 seconds from first invitation
    We must store removeInvite time in case player left queue and joined and is invited again
    We must store bgQueueTypeId, because battleground can be deleted already, when player entered it
*/
class BGQueueRemoveEvent : public BasicEvent
{
public:
    BGQueueRemoveEvent(ObjectGuid pl_guid, uint32 bgInstanceGUID, BattlegroundQueueTypeId bgQueueTypeId, uint32 removeTime)
        : m_PlayerGuid(pl_guid), m_BgInstanceGUID(bgInstanceGUID), m_RemoveTime(removeTime), m_BgQueueTypeId(bgQueueTypeId)
    {}

    ~BGQueueRemoveEvent() override = default;

    bool Execute(uint64 e_time, uint32 p_time) override;
    void Abort(uint64 e_time) override;
private:
    ObjectGuid m_PlayerGuid;
    uint32 m_BgInstanceGUID;
    uint32 m_RemoveTime;
    BattlegroundQueueTypeId m_BgQueueTypeId;
};

#endif

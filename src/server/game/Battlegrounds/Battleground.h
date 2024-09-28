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

#ifndef __BATTLEGROUND_H
#define __BATTLEGROUND_H

#include "ArenaScore.h"
#include "Common.h"
#include "DBCEnums.h"
#include "GameObject.h"
#include "SharedDefines.h"

class Creature;
class GameObject;
class Group;
class Player;
class WorldPacket;
class BattlegroundMap;
class BattlegroundAV;
class BattlegroundWS;
class BattlegroundAB;
class BattlegroundNA;
class BattlegroundBE;
class BattlegroundEY;
class BattlegroundRL;
class BattlegroundSA;
class BattlegroundDS;
class BattlegroundRV;
class BattlegroundIC;

struct PvPDifficultyEntry;
struct GraveyardStruct;

enum BattlegroundDesertionType : uint8
{
    BG_DESERTION_TYPE_LEAVE_BG           = 0, // player leaves the BG
    BG_DESERTION_TYPE_OFFLINE            = 1, // player is kicked from BG because offline
    BG_DESERTION_TYPE_LEAVE_QUEUE        = 2, // player is invited to join and refuses to do it
    BG_DESERTION_TYPE_NO_ENTER_BUTTON    = 3, // player is invited to join and do nothing (time expires)
    BG_DESERTION_TYPE_INVITE_LOGOUT      = 4, // player is invited to join and logs out
    ARENA_DESERTION_TYPE_LEAVE_BG        = 5, // player leaves the Arena
    ARENA_DESERTION_TYPE_LEAVE_QUEUE     = 6, // player is invited to join arena and refuses to do it
    ARENA_DESERTION_TYPE_NO_ENTER_BUTTON = 7, // player is invited to join arena and do nothing (time expires)
    ARENA_DESERTION_TYPE_INVITE_LOGOUT   = 8, // player is invited to join arena and logs out
};

enum BattlegroundMaps
{
    MAP_BG_ALTERAC_VALLEY           = 30,
    MAP_BG_WARSONG_GULCH            = 489,
    MAP_BG_ARATHI_BASIN             = 529,
    MAP_BG_EYE_OF_THE_STORM         = 566,
    MAP_BG_STRAND_OF_THE_ANCIENTS   = 607,
    MAP_BG_ISLE_OF_CONQUEST         = 628
};

enum BattlegroundBroadcastTexts
{
    BG_TEXT_ALLIANCE_WINS           = 10633,
    BG_TEXT_HORDE_WINS              = 10634,

    BG_TEXT_START_TWO_MINUTES       = 18193,
    BG_TEXT_START_ONE_MINUTE        = 18194,
    BG_TEXT_START_HALF_MINUTE       = 18195,
    BG_TEXT_BATTLE_HAS_BEGUN        = 18196,
};

enum BattlegroundSounds
{
    SOUND_HORDE_WINS                = 8454,
    SOUND_ALLIANCE_WINS             = 8455,
    SOUND_BG_START                  = 3439,
    SOUND_BG_START_L70ETC           = 11803,
};

enum BattlegroundQuests
{
    SPELL_WS_QUEST_REWARD           = 43483,
    SPELL_AB_QUEST_REWARD           = 43484,
    SPELL_AV_QUEST_REWARD           = 43475,
    SPELL_AV_QUEST_KILLED_BOSS      = 23658,
    SPELL_EY_QUEST_REWARD           = 43477,
    SPELL_SA_QUEST_REWARD           = 61213,
    SPELL_AB_QUEST_REWARD_4_BASES   = 24061,
    SPELL_AB_QUEST_REWARD_5_BASES   = 24064
};

enum BattlegroundMarks
{
    SPELL_WS_MARK_LOSER             = 24950,
    SPELL_WS_MARK_WINNER            = 24951,
    SPELL_WS_MARK_TIE               = 66126,
    SPELL_AB_MARK_LOSER             = 24952,
    SPELL_AB_MARK_WINNER            = 24953,
    SPELL_AV_MARK_LOSER             = 24954,
    SPELL_AV_MARK_WINNER            = 24955,
    SPELL_SA_MARK_WINNER            = 61160,
    SPELL_SA_MARK_LOSER             = 61159,
    SPELL_WG_MARK_WINNER            = 56902,
    ITEM_AV_MARK_OF_HONOR           = 20560,
    ITEM_WS_MARK_OF_HONOR           = 20558,
    ITEM_AB_MARK_OF_HONOR           = 20559,
    ITEM_EY_MARK_OF_HONOR           = 29024,
    ITEM_SA_MARK_OF_HONOR           = 42425,
    ITEM_IC_MARK_OF_HONOR           = 47395,
};

enum BattlegroundMarksCount
{
    ITEM_WINNER_COUNT               = 3,
    ITEM_LOSER_COUNT                = 1
};

enum BattlegroundCreatures
{
    BG_CREATURE_ENTRY_A_SPIRITGUIDE = 13116,                // alliance
    BG_CREATURE_ENTRY_H_SPIRITGUIDE = 13117,                // horde
};

enum BattlegroundSpells
{
    SPELL_WAITING_FOR_RESURRECT     = 2584,                 // Waiting to Resurrect
    SPELL_SPIRIT_HEAL_CHANNEL       = 22011,                // Spirit Heal Channel
    SPELL_SPIRIT_HEAL               = 22012,                // Spirit Heal
    SPELL_RESURRECTION_VISUAL       = 24171,                // Resurrection Impact Visual
    SPELL_ARENA_PREPARATION         = 32727,                // use this one, 32728 not correct
    SPELL_PREPARATION               = 44521,                // Preparation
    SPELL_SPIRIT_HEAL_MANA          = 44535,                // Spirit Heal
    SPELL_RECENTLY_DROPPED_FLAG     = 42792,                // Recently Dropped Flag
    SPELL_AURA_PLAYER_INACTIVE      = 43681,                // Inactive
    SPELL_HONORABLE_DEFENDER_25Y    = 68652,                // +50% honor when standing at a capture point that you control, 25yards radius (added in 3.2)
    SPELL_HONORABLE_DEFENDER_60Y    = 66157                 // +50% honor when standing at a capture point that you control, 60yards radius (added in 3.2), probably for 40+ player battlegrounds
};

enum BattlegroundReputations
{
    BG_REP_AV_HORDE                 = 729,
    BG_REP_AV_ALLIANCE              = 730,
    BG_REP_AB_HORDE                 = 510,
    BG_REP_AB_ALLIANCE              = 509,
    BG_REP_WS_HORDE                 = 889,
    BG_REP_WS_ALLIANCE              = 890,
};

enum BattlegroundTimeIntervals
{
    CHECK_PLAYER_POSITION_INVERVAL  = 9000,                 // ms
    //REMIND_INTERVAL               = 10000,                // ms
    INVITATION_REMIND_TIME          = 20000,                // ms
    INVITE_ACCEPT_WAIT_TIME         = 60000,                // ms
    TIME_TO_AUTOREMOVE              = 120000,               // ms
    MAX_OFFLINE_TIME                = 300,                  // secs
    RESPAWN_ONE_DAY                 = 86400,                // secs
    RESPAWN_IMMEDIATELY             = 0,                    // secs
};

#define RESURRECTION_INTERVAL (sWorld->getIntConfig(CONFIG_BATTLEGROUND_PLAYER_RESPAWN) * IN_MILLISECONDS)
#define RESTORATION_BUFF_RESPAWN_TIME (sWorld->getIntConfig(CONFIG_BATTLEGROUND_RESTORATION_BUFF_RESPAWN))
#define BERSERKING_BUFF_RESPAWN_TIME (sWorld->getIntConfig(CONFIG_BATTLEGROUND_BERSERKING_BUFF_RESPAWN))
#define SPEED_BUFF_RESPAWN_TIME (sWorld->getIntConfig(CONFIG_BATTLEGROUND_SPEED_BUFF_RESPAWN))

enum BattlegroundStartTimeIntervals
{
    BG_START_DELAY_2M               = 120000,               // ms (2 minutes)
    BG_START_DELAY_1M               = 60000,                // ms (1 minute)
    BG_START_DELAY_30S              = 30000,                // ms (30 seconds)
    BG_START_DELAY_15S              = 15000,                // ms (15 seconds) Used only in arena
    BG_START_DELAY_NONE             = 0,                    // ms
};

#define BATTLEGROUND_UPDATE_INTERVAL 1000

enum BattlegroundBuffObjects
{
    BG_OBJECTID_SPEEDBUFF_ENTRY     = 179871,
    BG_OBJECTID_REGENBUFF_ENTRY     = 179904,
    BG_OBJECTID_BERSERKERBUFF_ENTRY = 179905
};

const uint32 Buff_Entries[3] = { BG_OBJECTID_SPEEDBUFF_ENTRY, BG_OBJECTID_REGENBUFF_ENTRY, BG_OBJECTID_BERSERKERBUFF_ENTRY };

enum BattlegroundStatus
{
    STATUS_NONE                     = 0,                     // first status, should mean bg is not instance
    STATUS_WAIT_QUEUE               = 1,                     // means bg is empty and waiting for queue
    STATUS_WAIT_JOIN                = 2,                     // this means, that BG has already started and it is waiting for more players
    STATUS_IN_PROGRESS              = 3,                     // means bg is running
    STATUS_WAIT_LEAVE               = 4                      // means some faction has won BG and it is ending
};

//npcbot
struct BattlegroundBot
{
    TeamId Team;                                             // bot's team
};
//end npcbot

struct BattlegroundObjectInfo
{
    BattlegroundObjectInfo()  = default;

    GameObject*  object{nullptr};
    int32       timer{0};
    uint32      spellid{0};
};

enum ArenaType : uint8
{
    ARENA_TYPE_2v2                  = 2,
    ARENA_TYPE_3v3                  = 3,
    ARENA_TYPE_5v5                  = 5
};

enum BattlegroundType
{
    TYPE_BATTLEGROUND               = 3,
    TYPE_ARENA                      = 4
};

enum BattlegroundStartingEvents
{
    BG_STARTING_EVENT_NONE          = 0x00,
    BG_STARTING_EVENT_1             = 0x01,
    BG_STARTING_EVENT_2             = 0x02,
    BG_STARTING_EVENT_3             = 0x04,
    BG_STARTING_EVENT_4             = 0x08
};

enum BattlegroundStartingEventsIds
{
    BG_STARTING_EVENT_FIRST         = 0,
    BG_STARTING_EVENT_SECOND        = 1,
    BG_STARTING_EVENT_THIRD         = 2,
    BG_STARTING_EVENT_FOURTH        = 3
};

enum SpiritOfCompetitionEvent
{
    EVENT_SPIRIT_OF_COMPETITION             = 46,
    QUEST_FLAG_PARTICIPANT                  = 12187,
    QUEST_FLAG_WINNER                       = 12186,
    SPELL_SPIRIT_OF_COMPETITION_PARTICIPANT = 48163,
    SPELL_SPIRIT_OF_COMPETITION_WINNER      = 48164,
};

constexpr auto BG_STARTING_EVENT_COUNT = 4;

class ArenaLogEntryData
{
public:
    ArenaLogEntryData() = default;

    void Fill(std::string_view name, ObjectGuid::LowType guid, uint32 acc, uint32 arenaTeamId, std::string ip)
    {
        Name = std::string(name);
        Guid = guid;
        Acc = acc;
        ArenaTeamId = arenaTeamId;
        IP = ip;
    }

    std::string Name{};
    ObjectGuid::LowType Guid{0};
    uint32 Acc{0};
    uint32 ArenaTeamId{0};
    std::string IP{};
};

enum BGHonorMode
{
    BG_NORMAL = 0,
    BG_HOLIDAY,
    BG_HONOR_MODE_NUM
};

#define ARENA_TIMELIMIT_POINTS_LOSS    -16
#define ARENA_READY_MARKER_ENTRY 301337

/*
    This class is used to:
    1. Add player to battleground
    2. Remove player from battleground
    3. some certain cases, same for all battlegrounds
    4. It has properties same for all battlegrounds
*/

enum BattlegroundQueueInvitationType
{
    BG_QUEUE_INVITATION_TYPE_NO_BALANCE = 0, // no balance: N+M vs N players
    BG_QUEUE_INVITATION_TYPE_BALANCED   = 1, // teams balanced: N+1 vs N players
    BG_QUEUE_INVITATION_TYPE_EVEN       = 2  // teams even: N vs N players
};

class Battleground
{
public:
    Battleground();
    virtual ~Battleground();

    void Update(uint32 diff);

    virtual bool SetupBattleground()                    // must be implemented in BG subclass
    {
        return true;
    }

    virtual void Init();
    virtual void StartingEventCloseDoors() { }
    virtual void StartingEventOpenDoors() { }
    virtual void ResetBGSubclass() { }                  // must be implemented in BG subclass

    virtual void DestroyGate(Player* /*player*/, GameObject* /*go*/) {}

    /* achievement req. */
    [[nodiscard]] virtual bool AllNodesConrolledByTeam(TeamId /*teamId*/) const { return false; }
    void StartTimedAchievement(AchievementCriteriaTimedTypes type, uint32 entry);

    /* Battleground */
    // Get methods:
    [[nodiscard]] std::string GetName() const         { return m_Name; }
    [[nodiscard]] BattlegroundTypeId GetBgTypeID(bool GetRandom = false) const { return GetRandom ? m_RandomTypeID : m_RealTypeID; }
    [[nodiscard]] BattlegroundBracketId GetBracketId() const { return m_BracketId; }
    [[nodiscard]] uint32 GetInstanceID() const        { return m_InstanceID; }
    [[nodiscard]] BattlegroundStatus GetStatus() const { return m_Status; }
    [[nodiscard]] uint32 GetClientInstanceID() const  { return m_ClientInstanceID; }
    [[nodiscard]] uint32 GetStartTime() const         { return m_StartTime; }
    [[nodiscard]] uint32 GetEndTime() const           { return m_EndTime; }
    [[nodiscard]] uint32 GetLastResurrectTime() const { return m_LastResurrectTime; }

    [[nodiscard]] uint32 GetMinLevel() const          { return m_LevelMin; }
    [[nodiscard]] uint32 GetMaxLevel() const          { return m_LevelMax; }

    [[nodiscard]] uint32 GetMaxPlayersPerTeam() const { return m_MaxPlayersPerTeam; }
    [[nodiscard]] uint32 GetMinPlayersPerTeam() const { return m_MinPlayersPerTeam; }

    [[nodiscard]] int32 GetStartDelayTime() const     { return m_StartDelayTime; }
    [[nodiscard]] uint8 GetArenaType() const          { return m_ArenaType; }
    [[nodiscard]] PvPTeamId GetWinner() const         { return m_WinnerId; }
    [[nodiscard]] uint32 GetScriptId() const          { return ScriptId; }
    [[nodiscard]] uint32 GetBonusHonorFromKill(uint32 kills) const;

    // Spirit of Competition event
    void SpiritOfCompetitionEvent(PvPTeamId winnerTeamId) const;

    bool IsRandom() { return m_IsRandom; }

    // Set methods:
    void SetName(std::string_view name) { m_Name = std::string(name); }
    void SetBgTypeID(BattlegroundTypeId TypeID) { m_RealTypeID = TypeID; }
    void SetRandomTypeID(BattlegroundTypeId TypeID) { m_RandomTypeID = TypeID; }
    void SetBracket(PvPDifficultyEntry const* bracketEntry);
    void SetInstanceID(uint32 InstanceID) { m_InstanceID = InstanceID; }
    void SetStatus(BattlegroundStatus Status) { m_Status = Status; }
    void SetClientInstanceID(uint32 InstanceID) { m_ClientInstanceID = InstanceID; }
    void SetStartTime(uint32 Time) { m_StartTime = Time; }
    void SetEndTime(uint32 Time) { m_EndTime = Time; }
    void SetLastResurrectTime(uint32 Time) { m_LastResurrectTime = Time; }
    void SetLevelRange(uint32 min, uint32 max) { m_LevelMin = min; m_LevelMax = max; }
    void SetRated(bool state) { m_IsRated = state; }
    void SetArenaType(uint8 type) { m_ArenaType = type; }
    void SetArenaorBGType(bool _isArena) { m_IsArena = _isArena; }
    void SetWinner(PvPTeamId winner) { m_WinnerId = winner; }
    void SetScriptId(uint32 scriptId) { ScriptId = scriptId; }
    void SetRandom(bool isRandom) { m_IsRandom = isRandom; }

    void ModifyStartDelayTime(int32 diff) { m_StartDelayTime -= diff; }
    void SetStartDelayTime(int32 Time)    { m_StartDelayTime = Time; }

    void SetMaxPlayersPerTeam(uint32 MaxPlayers) { m_MaxPlayersPerTeam = MaxPlayers; }
    void SetMinPlayersPerTeam(uint32 MinPlayers) { m_MinPlayersPerTeam = MinPlayers; }

    void AddToBGFreeSlotQueue();        // this queue will be useful when more battlegrounds instances will be available
    void RemoveFromBGFreeSlotQueue();   // this method could delete whole BG instance, if another free is available

    void DecreaseInvitedCount(TeamId teamId)    { if (m_BgInvitedPlayers[teamId]) --m_BgInvitedPlayers[teamId]; }
    void IncreaseInvitedCount(TeamId teamId)    { ++m_BgInvitedPlayers[teamId]; }
    [[nodiscard]] uint32 GetInvitedCount(TeamId teamId) const { return m_BgInvitedPlayers[teamId]; }

    [[nodiscard]] bool HasFreeSlots() const;
    [[nodiscard]] uint32 GetFreeSlotsForTeam(TeamId teamId) const;
    [[nodiscard]] uint32 GetMaxFreeSlots() const;

    typedef std::set<Player*> SpectatorList;
    typedef std::map<ObjectGuid, ObjectGuid> ToBeTeleportedMap;
    void AddSpectator(Player* p) { m_Spectators.insert(p); }
    void RemoveSpectator(Player* p) { m_Spectators.erase(p); }
    bool HaveSpectators() { return !m_Spectators.empty(); }
    [[nodiscard]] const SpectatorList& GetSpectators() const { return m_Spectators; }
    void AddToBeTeleported(ObjectGuid spectator, ObjectGuid participant) { m_ToBeTeleported[spectator] = participant; }
    void RemoveToBeTeleported(ObjectGuid spectator) { ToBeTeleportedMap::iterator itr = m_ToBeTeleported.find(spectator); if (itr != m_ToBeTeleported.end()) m_ToBeTeleported.erase(itr); }
    void SpectatorsSendPacket(WorldPacket& data);

    [[nodiscard]] bool isArena() const        { return m_IsArena; }
    [[nodiscard]] bool isBattleground() const { return !m_IsArena; }
    [[nodiscard]] bool isRated() const        { return m_IsRated; }

    typedef std::map<ObjectGuid, Player*> BattlegroundPlayerMap;
    //npcbot
    typedef std::map<ObjectGuid, BattlegroundBot> BattlegroundBotMap;
    [[nodiscard]] BattlegroundBotMap const& GetBots() const { return m_Bots; }
    //end npcbot
    [[nodiscard]] BattlegroundPlayerMap const& GetPlayers() const { return m_Players; }
    [[nodiscard]] uint32 GetPlayersSize() const { return m_Players.size(); }

    void ReadyMarkerClicked(Player* p); // pussywizard
    GuidSet readyMarkerClickedSet; // pussywizard

    typedef std::unordered_map<ObjectGuid::LowType, BattlegroundScore*> BattlegroundScoreMap;
    typedef std::unordered_map<ObjectGuid, ArenaLogEntryData> ArenaLogEntryDataMap; // pussywizard
    ArenaLogEntryDataMap ArenaLogEntries; // pussywizard
    [[nodiscard]] BattlegroundScoreMap const* GetPlayerScores() const { return &PlayerScores; }
    [[nodiscard]] std::size_t GetPlayerScoresSize() const { return PlayerScores.size(); }

    [[nodiscard]] uint32 GetReviveQueueSize() const { return m_ReviveQueue.size(); }

    void AddPlayerToResurrectQueue(ObjectGuid npc_guid, ObjectGuid player_guid);
    void RemovePlayerFromResurrectQueue(Player* player);

    /// Relocate all players in ReviveQueue to the closest graveyard
    void RelocateDeadPlayers(ObjectGuid queueIndex);

    void StartBattleground();

    GameObject* GetBGObject(uint32 type);
    Creature* GetBGCreature(uint32 type);

    // Location
    void SetMapId(uint32 MapID) { m_MapId = MapID; }
    [[nodiscard]] uint32 GetMapId() const { return m_MapId; }

    // Map pointers
    void SetBgMap(BattlegroundMap* map) { m_Map = map; }
    [[nodiscard]] BattlegroundMap* GetBgMap() const { ASSERT(m_Map); return m_Map; }
    [[nodiscard]] BattlegroundMap* FindBgMap() const { return m_Map; }

    void SetTeamStartPosition(TeamId teamId, Position const& pos);
    Position const* GetTeamStartPosition(TeamId teamId) const;

    void SetStartMaxDist(float startMaxDist) { m_StartMaxDist = startMaxDist; }
    [[nodiscard]] float GetStartMaxDist() const { return m_StartMaxDist; }

    // Packet Transfer
    // method that should fill worldpacket with actual world states (not yet implemented for all battlegrounds!)
    virtual void FillInitialWorldStates(WorldPacket& /*data*/) { }
    void SendPacketToTeam(TeamId teamId, WorldPacket const* packet, Player* sender = nullptr, bool self = true);
    void SendPacketToAll(WorldPacket const* packet);
    void YellToAll(Creature* creature, const char* text, uint32 language);

    void SendChatMessage(Creature* source, uint8 textId, WorldObject* target = nullptr);
    void SendBroadcastText(uint32 id, ChatMsg msgType, WorldObject const* target = nullptr);

    template<class Do>
    void BroadcastWorker(Do& _do);

    void PlaySoundToAll(uint32 soundId);
    void CastSpellOnTeam(uint32 spellId, TeamId teamId);
    void RemoveAuraOnTeam(uint32 spellId, TeamId teamId);
    void RewardHonorToTeam(uint32 honor, TeamId teamId);
    void RewardReputationToTeam(uint32 factionId, uint32 reputation, TeamId teamId);
    uint32 GetRealRepFactionForPlayer(uint32 factionId, Player* player);

    void UpdateWorldState(uint32 variable, uint32 value);

    void EndBattleground(PvPTeamId winnerTeamId);

    /// @deprecated need delete
    virtual void EndBattleground(TeamId winnerTeamId)
    {
        EndBattleground(GetPvPTeamId(winnerTeamId));
    }

    void BlockMovement(Player* player);

    // Raid Group
    [[nodiscard]] Group* GetBgRaid(TeamId teamId) const { return m_BgRaids[teamId]; }
    void SetBgRaid(TeamId teamId, Group* bg_raid);

    void BuildPvPLogDataPacket(WorldPacket& data);
    virtual bool UpdatePlayerScore(Player* player, uint32 type, uint32 value, bool doAddHonor = true);

    [[nodiscard]] uint32 GetPlayersCountByTeam(TeamId teamId) const { return m_PlayersCount[teamId]; }
    [[nodiscard]] uint32 GetAlivePlayersCountByTeam(TeamId teamId) const;   // used in arenas to correctly handle death in spirit of redemption / last stand etc. (killer = killed) cases
    void UpdatePlayersCountByTeam(TeamId teamId, bool remove)
    {
        if (remove)
            --m_PlayersCount[teamId];
        else
            ++m_PlayersCount[teamId];
    }

    virtual void CheckWinConditions() { }

    // used for rated arena battles
    void SetArenaTeamIdForTeam(TeamId teamId, uint32 ArenaTeamId) { m_ArenaTeamIds[teamId] = ArenaTeamId; }
    [[nodiscard]] uint32 GetArenaTeamIdForTeam(TeamId teamId) const { return m_ArenaTeamIds[teamId]; }
    void SetArenaMatchmakerRating(TeamId teamId, uint32 MMR) { m_ArenaTeamMMR[teamId] = MMR; }
    [[nodiscard]] uint32 GetArenaMatchmakerRating(TeamId teamId) const { return m_ArenaTeamMMR[teamId]; }

    // Triggers handle
    // must be implemented in BG subclass
    virtual void HandleAreaTrigger(Player* /*player*/, uint32 /*trigger*/) {}
    // must be implemented in BG subclass if need AND call base class generic code
    virtual void HandleKillPlayer(Player* player, Player* killer);
    virtual void HandleKillUnit(Creature* /*unit*/, Player* /*killer*/) { }

    // Battleground events
    virtual void EventPlayerDroppedFlag(Player* /*player*/) {}
    virtual void EventPlayerClickedOnFlag(Player* /*player*/, GameObject* /*gameObject*/) {}
    virtual void EventPlayerDamagedGO(Player* /*player*/, GameObject* /*go*/, uint32 /*eventType*/) {}
    virtual void EventPlayerUsedGO(Player* /*player*/, GameObject* /*go*/) {}

    // this function can be used by spell to interact with the BG map
    virtual void DoAction(uint32 /*action*/, ObjectGuid /*var*/) {}

    virtual void HandlePlayerResurrect(Player* /*player*/) {}

    // Death related
    virtual GraveyardStruct const* GetClosestGraveyard(Player* player);

    virtual void AddPlayer(Player* player);                // must be implemented in BG subclass

    void AddOrSetPlayerToCorrectBgGroup(Player* player, TeamId teamId);

    //npcbot
    [[nodiscard]] std::size_t GetBotScoresSize() const { return BotScores.size(); }
    void RemoveBotFromResurrectQueue(ObjectGuid guid);
    virtual void AddBot(Creature* bot);
    virtual void RemoveBotAtLeave(ObjectGuid guid);
    virtual bool UpdateBotScore(Creature const* bot, uint32 type, uint32 value);
    void AddOrSetBotToCorrectBgGroup(Creature* bot, TeamId teamId);
    void RewardXPAtKill(Player* killer, Creature* victim);
    void RewardXPAtKill(Creature* killer, Player* victim);
    void RewardXPAtKill(Creature* killer, Creature* victim);
    virtual void HandleBotKillPlayer(Creature* killer, Player* victim);
    virtual void HandleBotKillBot(Creature* killer, Creature* victim);
    virtual void HandlePlayerKillBot(Creature* victim, Player* killer);
    virtual void HandleBotKillUnit(Creature* /*killer*/, Creature* /*victim*/) { }
    TeamId GetBotTeamId(ObjectGuid guid) const;
    virtual GraveyardStruct const* GetClosestGraveyardForBot(Creature* bot) const;
    virtual void RemoveBot(ObjectGuid /*guid*/) {}
    virtual void EventBotDroppedFlag(Creature* /*bot*/) { }
    virtual void EventBotClickedOnFlag(Creature* /*bot*/, GameObject* /*target_obj*/) { }
    virtual void HandleBotAreaTrigger(Creature* /*bot*/, uint32 /*trigger*/) { }
    //end npcbot

    virtual void RemovePlayerAtLeave(Player* player);
    // can be extended in in BG subclass

    void HandleTriggerBuff(GameObject* gameObject);
    void SetHoliday(bool is_holiday);

    /// @todo: make this protected:
    typedef GuidVector BGObjects;
    typedef GuidVector BGCreatures;
    BGObjects BgObjects;
    BGCreatures BgCreatures;
    void SpawnBGObject(uint32 type, uint32 respawntime, uint32 forceRespawnDelay = 0);
    bool AddObject(uint32 type, uint32 entry, float x, float y, float z, float o, float rotation0, float rotation1, float rotation2, float rotation3, uint32 respawnTime = 0, GOState goState = GO_STATE_READY);
    Creature* AddCreature(uint32 entry, uint32 type, float x, float y, float z, float o, uint32 respawntime = 0, MotionTransport* transport = nullptr);
    bool DelCreature(uint32 type);
    bool DelObject(uint32 type);
    bool AddSpiritGuide(uint32 type, float x, float y, float z, float o, TeamId teamId);
    int32 GetObjectType(ObjectGuid guid);

    void DoorOpen(uint32 type);
    void DoorClose(uint32 type);
    //to be removed
    const char* GetAcoreString(int32 entry);

    virtual bool HandlePlayerUnderMap(Player* /*player*/) { return false; }

    // since arenas can be AvA or Hvh, we have to get the "temporary" team of a player
    static TeamId GetOtherTeamId(TeamId teamId);
    [[nodiscard]] bool IsPlayerInBattleground(ObjectGuid guid) const;

    [[nodiscard]] bool ToBeDeleted() const { return m_SetDeleteThis; }
    //void SetDeleteThis() { m_SetDeleteThis = true; }

    void RewardXPAtKill(Player* killer, Player* victim);

    [[nodiscard]] virtual ObjectGuid GetFlagPickerGUID(TeamId /*teamId*/ = TEAM_NEUTRAL) const { return ObjectGuid::Empty; }
    virtual void SetDroppedFlagGUID(ObjectGuid /*guid*/, TeamId /*teamId*/ = TEAM_NEUTRAL) {}
    [[nodiscard]] uint32 GetTeamScore(TeamId teamId) const;

    virtual TeamId GetPrematureWinner();

    // because BattleGrounds with different types and same level range has different m_BracketId
    [[nodiscard]] uint8 GetUniqueBracketId() const;

    BattlegroundAV* ToBattlegroundAV() { if (GetBgTypeID(true) == BATTLEGROUND_AV) return reinterpret_cast<BattlegroundAV*>(this); else return nullptr; }
    [[nodiscard]] BattlegroundAV const* ToBattlegroundAV() const { if (GetBgTypeID(true) == BATTLEGROUND_AV) return reinterpret_cast<const BattlegroundAV*>(this); else return nullptr; }

    BattlegroundWS* ToBattlegroundWS() { if (GetBgTypeID(true) == BATTLEGROUND_WS) return reinterpret_cast<BattlegroundWS*>(this); else return nullptr; }
    [[nodiscard]] BattlegroundWS const* ToBattlegroundWS() const { if (GetBgTypeID(true) == BATTLEGROUND_WS) return reinterpret_cast<const BattlegroundWS*>(this); else return nullptr; }

    BattlegroundAB* ToBattlegroundAB() { if (GetBgTypeID(true) == BATTLEGROUND_AB) return reinterpret_cast<BattlegroundAB*>(this); else return nullptr; }
    [[nodiscard]] BattlegroundAB const* ToBattlegroundAB() const { if (GetBgTypeID(true) == BATTLEGROUND_AB) return reinterpret_cast<const BattlegroundAB*>(this); else return nullptr; }

    BattlegroundNA* ToBattlegroundNA() { if (GetBgTypeID(true) == BATTLEGROUND_NA) return reinterpret_cast<BattlegroundNA*>(this); else return nullptr; }
    [[nodiscard]] BattlegroundNA const* ToBattlegroundNA() const { if (GetBgTypeID(true) == BATTLEGROUND_NA) return reinterpret_cast<const BattlegroundNA*>(this); else return nullptr; }

    BattlegroundBE* ToBattlegroundBE() { if (GetBgTypeID(true) == BATTLEGROUND_BE) return reinterpret_cast<BattlegroundBE*>(this); else return nullptr; }
    [[nodiscard]] BattlegroundBE const* ToBattlegroundBE() const { if (GetBgTypeID(true) == BATTLEGROUND_BE) return reinterpret_cast<const BattlegroundBE*>(this); else return nullptr; }

    BattlegroundEY* ToBattlegroundEY() { if (GetBgTypeID(true) == BATTLEGROUND_EY) return reinterpret_cast<BattlegroundEY*>(this); else return nullptr; }
    [[nodiscard]] BattlegroundEY const* ToBattlegroundEY() const { if (GetBgTypeID(true) == BATTLEGROUND_EY) return reinterpret_cast<const BattlegroundEY*>(this); else return nullptr; }

    BattlegroundRL* ToBattlegroundRL() { if (GetBgTypeID(true) == BATTLEGROUND_RL) return reinterpret_cast<BattlegroundRL*>(this); else return nullptr; }
    [[nodiscard]] BattlegroundRL const* ToBattlegroundRL() const { if (GetBgTypeID(true) == BATTLEGROUND_RL) return reinterpret_cast<const BattlegroundRL*>(this); else return nullptr; }

    BattlegroundSA* ToBattlegroundSA() { if (GetBgTypeID(true) == BATTLEGROUND_SA) return reinterpret_cast<BattlegroundSA*>(this); else return nullptr; }
    [[nodiscard]] BattlegroundSA const* ToBattlegroundSA() const { if (GetBgTypeID(true) == BATTLEGROUND_SA) return reinterpret_cast<const BattlegroundSA*>(this); else return nullptr; }

    BattlegroundDS* ToBattlegroundDS() { if (GetBgTypeID(true) == BATTLEGROUND_DS) return reinterpret_cast<BattlegroundDS*>(this); else return nullptr; }
    [[nodiscard]] BattlegroundDS const* ToBattlegroundDS() const { if (GetBgTypeID(true) == BATTLEGROUND_DS) return reinterpret_cast<const BattlegroundDS*>(this); else return nullptr; }

    BattlegroundRV* ToBattlegroundRV() { if (GetBgTypeID(true) == BATTLEGROUND_RV) return reinterpret_cast<BattlegroundRV*>(this); else return nullptr; }
    [[nodiscard]] BattlegroundRV const* ToBattlegroundRV() const { if (GetBgTypeID(true) == BATTLEGROUND_RV) return reinterpret_cast<const BattlegroundRV*>(this); else return nullptr; }

    BattlegroundIC* ToBattlegroundIC() { if (GetBgTypeID(true) == BATTLEGROUND_IC) return reinterpret_cast<BattlegroundIC*>(this); else return nullptr; }
    [[nodiscard]] BattlegroundIC const* ToBattlegroundIC() const { if (GetBgTypeID(true) == BATTLEGROUND_IC) return reinterpret_cast<const BattlegroundIC*>(this); else return nullptr; }

protected:
    // this method is called, when BG cannot spawn its own spirit guide, or something is wrong, It correctly ends Battleground
    void EndNow();
    void PlayerAddedToBGCheckIfBGIsRunning(Player* player);

    void _ProcessResurrect(uint32 diff);
    void _ProcessProgress(uint32 diff);
    void _ProcessLeave(uint32 diff);
    void _ProcessJoin(uint32 diff);
    void _CheckSafePositions(uint32 diff);

    // Scorekeeping
    BattlegroundScoreMap PlayerScores;                // Player scores
    //npcbot
    BattlegroundScoreMap BotScores;
    BattlegroundBotMap m_Bots;
    //end npcbot
    // must be implemented in BG subclass
    virtual void RemovePlayer(Player* /*player*/) {}

    // Player lists, those need to be accessible by inherited classes
    BattlegroundPlayerMap m_Players;
    // Spirit Guide guid + Player list GUIDS
    std::map<ObjectGuid, GuidVector> m_ReviveQueue;

    // these are important variables used for starting messages
    uint8 m_Events;
    BattlegroundStartTimeIntervals  StartDelayTimes[BG_STARTING_EVENT_COUNT];
    // this must be filled in constructors!
    uint32 StartMessageIds[BG_STARTING_EVENT_COUNT];

    bool m_BuffChange;
    bool m_IsRandom;

    BGHonorMode m_HonorMode;
    int32 m_TeamScores[PVP_TEAMS_COUNT];

    ArenaTeamScore _arenaTeamScores[PVP_TEAMS_COUNT];

    // pussywizard:
    uint32 m_UpdateTimer;

    EventProcessor _reviveEvents;

private:
    // Battleground
    BattlegroundTypeId m_RealTypeID;
    BattlegroundTypeId m_RandomTypeID;                  // TypeID created from Random Battleground list
    uint32 m_InstanceID;                                // Battleground Instance's GUID!
    BattlegroundStatus m_Status;
    uint32 m_ClientInstanceID;                          // the instance-id which is sent to the client and without any other internal use
    uint32 m_StartTime;
    uint32 m_ResetStatTimer;
    uint32 m_ValidStartPositionTimer;
    int32 m_EndTime;                                    // it is set to 120000 when bg is ending and it decreases itself
    uint32 m_LastResurrectTime;
    BattlegroundBracketId m_BracketId{ BG_BRACKET_ID_FIRST };
    uint8  m_ArenaType;                                 // 2=2v2, 3=3v3, 5=5v5
    bool   _InBGFreeSlotQueue{ false };                // used to make sure that BG is only once inserted into the BattlegroundMgr.BGFreeSlotQueue[bgTypeId] deque
    bool   m_SetDeleteThis;                             // used for safe deletion of the bg after end / all players leave
    bool   m_IsArena;
    PvPTeamId m_WinnerId;
    int32  m_StartDelayTime;
    bool   m_IsRated;                                   // is this battle rated?
    bool   m_PrematureCountDown;
    uint32 m_PrematureCountDownTimer;
    std::string m_Name{};

    /* Pre- and post-update hooks */

    /**
     * @brief Pre-update hook.
     *
     * Will be called before battleground update is started. Depending on
     * the result of this call actual update body may be skipped.
     *
     * @param diff a time difference between two worldserver update loops in
     * milliseconds.
     *
     * @return @c true if update must be performed, @c false otherwise.
     *
     * @see Update(), PostUpdateImpl().
     */
    virtual bool PreUpdateImpl(uint32 /* diff */) { return true; }

    /**
     * @brief Post-update hook.
     *
     * Will be called after battleground update has passed. May be used to
     * implement custom update effects in subclasses.
     *
     * @param diff a time difference between two worldserver update loops in
     * milliseconds.
     *
     * @see Update(), PreUpdateImpl().
     */
    virtual void PostUpdateImpl(uint32 /* diff */) { }

    // Player lists
    GuidVector m_ResurrectQueue;                // Player GUID
    GuidDeque m_OfflineQueue;                   // Player GUID

    // Invited counters are useful for player invitation to BG - do not allow, if BG is started to one faction to have 2 more players than another faction
    // Invited counters will be changed only when removing already invited player from queue, removing player from battleground and inviting player to BG
    // Invited players counters
    uint32 m_BgInvitedPlayers[PVP_TEAMS_COUNT];

    // Raid Group
    Group* m_BgRaids[PVP_TEAMS_COUNT];                   // 0 - alliance, 1 - horde

    SpectatorList m_Spectators;
    ToBeTeleportedMap m_ToBeTeleported;

    // Players count by team
    uint32 m_PlayersCount[PVP_TEAMS_COUNT];

    // Arena team ids by team
    uint32 m_ArenaTeamIds[PVP_TEAMS_COUNT];
    uint32 m_ArenaTeamMMR[PVP_TEAMS_COUNT];

    // Limits
    uint32 m_LevelMin;
    uint32 m_LevelMax;
    uint32 m_MaxPlayersPerTeam;
    uint32 m_MinPlayersPerTeam;

    // Start location
    uint32 m_MapId;
    BattlegroundMap* m_Map;
    float m_StartMaxDist;
    std::array<Position, PVP_TEAMS_COUNT> _startPosition;
    uint32 ScriptId;
};
#endif

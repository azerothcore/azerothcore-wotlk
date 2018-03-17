/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef __BATTLEGROUND_H
#define __BATTLEGROUND_H

#include "Common.h"
#include "SharedDefines.h"
#include "DBCEnums.h"
#include "GameObject.h"

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
struct WorldSafeLocsEntry;

enum BattlegroundDesertionType
{
    BG_DESERTION_TYPE_LEAVE_BG          = 0, // player leaves the BG
    BG_DESERTION_TYPE_OFFLINE           = 1, // player is kicked from BG because offline
    BG_DESERTION_TYPE_LEAVE_QUEUE       = 2, // player is invited to join and refuses to do it
    BG_DESERTION_TYPE_NO_ENTER_BUTTON   = 3, // player is invited to join and do nothing (time expires)
    BG_DESERTION_TYPE_INVITE_LOGOUT     = 4, // player is invited to join and logs out
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
    BG_CREATURE_ENTRY_A_SPIRITGUIDE      = 13116,           // alliance
    BG_CREATURE_ENTRY_H_SPIRITGUIDE      = 13117,           // horde
};

enum BattlegroundSpells
{
    SPELL_WAITING_FOR_RESURRECT     = 2584,                 // Waiting to Resurrect
    SPELL_SPIRIT_HEAL_CHANNEL       = 22011,                // Spirit Heal Channel
    SPELL_SPIRIT_HEAL               = 22012,                // Spirit Heal
    SPELL_RESURRECTION_VISUAL       = 24171,                // Resurrection Impact Visual
    SPELL_ARENA_PREPARATION         = 32727,                // use this one, 32728 not correct
    SPELL_ALLIANCE_GOLD_FLAG        = 32724,
    SPELL_ALLIANCE_GREEN_FLAG       = 32725,
    SPELL_HORDE_GOLD_FLAG           = 35774,
    SPELL_HORDE_GREEN_FLAG          = 35775,
    SPELL_PREPARATION               = 44521,                // Preparation
    SPELL_SPIRIT_HEAL_MANA          = 44535,                // Spirit Heal
    SPELL_RECENTLY_DROPPED_FLAG     = 42792,                // Recently Dropped Flag
    SPELL_AURA_PLAYER_INACTIVE      = 43681,                // Inactive
    SPELL_HONORABLE_DEFENDER_25Y    = 68652,                // +50% honor when standing at a capture point that you control, 25yards radius (added in 3.2)
    SPELL_HONORABLE_DEFENDER_60Y    = 66157,                // +50% honor when standing at a capture point that you control, 60yards radius (added in 3.2), probably for 40+ player battlegrounds
    SPELL_THE_LAST_STANDING         = 26549,                // Arena achievement related
};

enum BattlegroundReputations
{
    BG_REP_AV_HORDE         = 729,
    BG_REP_AV_ALLIANCE      = 730,
    BG_REP_AB_HORDE         = 510,
    BG_REP_AB_ALLIANCE      = 509,
    BG_REP_WS_HORDE         = 889,
    BG_REP_WS_ALLIANCE      = 890,
};

enum BattlegroundTimeIntervals
{
    CHECK_PLAYER_POSITION_INVERVAL  = 9000,                 // ms
    RESURRECTION_INTERVAL           = 30000,                // ms
    //REMIND_INTERVAL                 = 10000,                // ms
    INVITATION_REMIND_TIME          = 20000,                // ms
    INVITE_ACCEPT_WAIT_TIME         = 60000,                // ms
    TIME_TO_AUTOREMOVE              = 120000,               // ms
    MAX_OFFLINE_TIME                = 300,                  // secs
    RESPAWN_ONE_DAY                 = 86400,                // secs
    RESPAWN_IMMEDIATELY             = 0,                    // secs
    BUFF_RESPAWN_TIME               = 180,                  // secs
};

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

enum BattlegroundRandomRewards
{
    BG_REWARD_WINNER_HONOR_FIRST    = 30,
    BG_REWARD_WINNER_ARENA_FIRST    = 25,
    BG_REWARD_WINNER_HONOR_LAST     = 15,
    BG_REWARD_WINNER_ARENA_LAST     = 0,
    BG_REWARD_LOSER_HONOR_FIRST    = 5,
    BG_REWARD_LOSER_HONOR_LAST     = 5
};

const uint32 Buff_Entries[3] = { BG_OBJECTID_SPEEDBUFF_ENTRY, BG_OBJECTID_REGENBUFF_ENTRY, BG_OBJECTID_BERSERKERBUFF_ENTRY };

enum BattlegroundStatus
{
    STATUS_NONE         = 0,                                // first status, should mean bg is not instance
    STATUS_WAIT_QUEUE   = 1,                                // means bg is empty and waiting for queue
    STATUS_WAIT_JOIN    = 2,                                // this means, that BG has already started and it is waiting for more players
    STATUS_IN_PROGRESS  = 3,                                // means bg is running
    STATUS_WAIT_LEAVE   = 4                                 // means some faction has won BG and it is ending
};

enum BattlegroundTeams
{
    BG_TEAMS_COUNT      = 2
};

struct BattlegroundObjectInfo
{
    BattlegroundObjectInfo() : object(NULL), timer(0), spellid(0) {}

    GameObject  *object;
    int32       timer;
    uint32      spellid;
};

enum ScoreType
{
    SCORE_KILLING_BLOWS         = 1,
    SCORE_DEATHS                = 2,
    SCORE_HONORABLE_KILLS       = 3,
    SCORE_BONUS_HONOR           = 4,
    //EY, but in MSG_PVP_LOG_DATA opcode!
    SCORE_DAMAGE_DONE           = 5,
    SCORE_HEALING_DONE          = 6,
    //WS
    SCORE_FLAG_CAPTURES         = 7,
    SCORE_FLAG_RETURNS          = 8,
    //AB and IC
    SCORE_BASES_ASSAULTED       = 9,
    SCORE_BASES_DEFENDED        = 10,
    //AV
    SCORE_GRAVEYARDS_ASSAULTED  = 11,
    SCORE_GRAVEYARDS_DEFENDED   = 12,
    SCORE_TOWERS_ASSAULTED      = 13,
    SCORE_TOWERS_DEFENDED       = 14,
    SCORE_MINES_CAPTURED        = 15,
    SCORE_LEADERS_KILLED        = 16,
    SCORE_SECONDARY_OBJECTIVES  = 17,
    //SOTA
    SCORE_DESTROYED_DEMOLISHER  = 18,
    SCORE_DESTROYED_WALL        = 19,
};

enum ArenaType
{
    ARENA_TYPE_2v2          = 2,
    ARENA_TYPE_3v3          = 3,
    ARENA_TYPE_5v5          = 5
};

enum BattlegroundType
{
    TYPE_BATTLEGROUND     = 3,
    TYPE_ARENA            = 4
};

enum BattlegroundStartingEvents
{
    BG_STARTING_EVENT_NONE  = 0x00,
    BG_STARTING_EVENT_1     = 0x01,
    BG_STARTING_EVENT_2     = 0x02,
    BG_STARTING_EVENT_3     = 0x04,
    BG_STARTING_EVENT_4     = 0x08
};

enum BattlegroundStartingEventsIds
{
    BG_STARTING_EVENT_FIRST     = 0,
    BG_STARTING_EVENT_SECOND    = 1,
    BG_STARTING_EVENT_THIRD     = 2,
    BG_STARTING_EVENT_FOURTH    = 3
};
#define BG_STARTING_EVENT_COUNT 4

struct BattlegroundScore
{
    BattlegroundScore(Player* player) : KillingBlows(0), Deaths(0), HonorableKills(0), BonusHonor(0),
        DamageDone(0), HealingDone(0), player(player)
    { }

    virtual ~BattlegroundScore() { }                        //virtual destructor is used when deleting score from scores map

    uint32 KillingBlows;
    uint32 Deaths;
    uint32 HonorableKills;
    uint32 BonusHonor;
    uint32 DamageDone;
    uint32 HealingDone;
    Player* player;

    uint32 GetKillingBlows() const { return KillingBlows; }
    uint32 GetDeaths() const { return Deaths; }
    uint32 GetHonorableKills() const { return HonorableKills; }
    uint32 GetBonusHonor() const { return BonusHonor; }
    uint32 GetDamageDone() const { return DamageDone; }
    uint32 GetHealingDone() const { return HealingDone; }

    virtual uint32 GetAttr1() const { return 0; }
    virtual uint32 GetAttr2() const { return 0; }
    virtual uint32 GetAttr3() const { return 0; }
    virtual uint32 GetAttr4() const { return 0; }
    virtual uint32 GetAttr5() const { return 0; }
};

class ArenaLogEntryData
{
    public:
        ArenaLogEntryData() : Guid(0), ArenaTeamId(0), DamageDone(0), HealingDone(0), KillingBlows(0) {}
        void Fill(const char* name, uint32 guid, uint32 acc, uint32 arenaTeamId, std::string ip)
        {
            Name = std::string(name);
            Guid = guid;
            Acc = acc;
            ArenaTeamId = arenaTeamId;
            IP = ip;
        }

        std::string Name;
        uint32 Guid;
        uint32 Acc;
        uint32 ArenaTeamId;
        std::string IP;
        uint32 DamageDone;
        uint32 HealingDone;
        uint32 KillingBlows;
};

enum BGHonorMode
{
    BG_NORMAL = 0,
    BG_HOLIDAY,
    BG_HONOR_MODE_NUM
};

#define BG_AWARD_ARENA_POINTS_MIN_LEVEL 71
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
        virtual bool AllNodesConrolledByTeam(TeamId /*teamId*/) const { return false; }
        void StartTimedAchievement(AchievementCriteriaTimedTypes type, uint32 entry);

        /* Battleground */
        // Get methods:
        char const* GetName() const         { return m_Name; }
        BattlegroundTypeId GetBgTypeID() const { return m_RealTypeID; }
        uint32 GetInstanceID() const        { return m_InstanceID; }
        BattlegroundStatus GetStatus() const { return m_Status; }
        uint32 GetClientInstanceID() const  { return m_ClientInstanceID; }
        uint32 GetStartTime() const         { return m_StartTime; }
        uint32 GetEndTime() const           { return m_EndTime; }
        uint32 GetLastResurrectTime() const { return m_LastResurrectTime; }

        uint32 GetMinLevel() const          { return m_LevelMin; }
        uint32 GetMaxLevel() const          { return m_LevelMax; }

        uint32 GetMaxPlayersPerTeam() const { return m_MaxPlayersPerTeam; }
        uint32 GetMinPlayersPerTeam() const { return m_MinPlayersPerTeam; }

        int32 GetStartDelayTime() const     { return m_StartDelayTime; }
        uint8 GetArenaType() const          { return m_ArenaType; }
        TeamId GetWinner() const             { return m_WinnerId; }
        uint32 GetScriptId() const          { return ScriptId; }
        uint32 GetBonusHonorFromKill(uint32 kills) const;

        // Set methods:
        void SetName(char const* Name)      { m_Name = Name; }
        void SetBgTypeID(BattlegroundTypeId TypeID) { m_RealTypeID = TypeID; }
        void SetInstanceID(uint32 InstanceID) { m_InstanceID = InstanceID; }
        void SetStatus(BattlegroundStatus Status) { m_Status = Status; }
        void SetClientInstanceID(uint32 InstanceID) { m_ClientInstanceID = InstanceID; }
        void SetStartTime(uint32 Time)      { m_StartTime = Time; }
        void SetEndTime(uint32 Time)        { m_EndTime = Time; }
        void SetLastResurrectTime(uint32 Time) { m_LastResurrectTime = Time; }
        void SetLevelRange(uint32 min, uint32 max) { m_LevelMin = min; m_LevelMax = max; }
        void SetRated(bool state)           { m_IsRated = state; }
        void SetArenaType(uint8 type)       { m_ArenaType = type; }
        void SetArenaorBGType(bool _isArena) { m_IsArena = _isArena; }
        void SetWinner(TeamId winner)        { m_WinnerId = winner; }
        void SetScriptId(uint32 scriptId)   { ScriptId = scriptId; }

        void ModifyStartDelayTime(int32 diff) { m_StartDelayTime -= diff; }
        void SetStartDelayTime(int32 Time)    { m_StartDelayTime = Time; }

        void SetMaxPlayersPerTeam(uint32 MaxPlayers) { m_MaxPlayersPerTeam = MaxPlayers; }
        void SetMinPlayersPerTeam(uint32 MinPlayers) { m_MinPlayersPerTeam = MinPlayers; }

        void DecreaseInvitedCount(TeamId teamId)    { ASSERT(m_BgInvitedPlayers[teamId] > 0); --m_BgInvitedPlayers[teamId]; }
        void IncreaseInvitedCount(TeamId teamId)    { ++m_BgInvitedPlayers[teamId]; }
        uint32 GetInvitedCount(TeamId teamId) const { return m_BgInvitedPlayers[teamId]; }

        bool HasFreeSlots() const;
        uint32 GetFreeSlotsForTeam(TeamId teamId) const;
        uint32 GetMaxFreeSlots() const;
 
        typedef std::set<Player*> SpectatorList;
        typedef std::map<uint64, uint64> ToBeTeleportedMap;
        void AddSpectator(Player* p) { m_Spectators.insert(p); }
        void RemoveSpectator(Player* p) { m_Spectators.erase(p); }
        bool HaveSpectators() { return !m_Spectators.empty(); }
        const SpectatorList& GetSpectators() const { return m_Spectators; }
        void AddToBeTeleported(uint64 spectator, uint64 participant) { m_ToBeTeleported[spectator] = participant; }
        void RemoveToBeTeleported(uint64 spectator) { ToBeTeleportedMap::iterator itr = m_ToBeTeleported.find(spectator); if (itr != m_ToBeTeleported.end()) m_ToBeTeleported.erase(itr); }
        void SpectatorsSendPacket(WorldPacket& data);

        bool isArena() const        { return m_IsArena; }
        bool isBattleground() const { return !m_IsArena; }
        bool isRated() const        { return m_IsRated; }

        typedef std::map<uint64, Player*> BattlegroundPlayerMap;
        BattlegroundPlayerMap const& GetPlayers() const { return m_Players; }
        uint32 GetPlayersSize() const { return m_Players.size(); }

        void ReadyMarkerClicked(Player* p); // pussywizard
        std::set<uint32> readyMarkerClickedSet; // pussywizard

        typedef std::map<uint64, BattlegroundScore*> BattlegroundScoreMap;
        typedef std::map<uint64, ArenaLogEntryData> ArenaLogEntryDataMap;// pussywizard
        ArenaLogEntryDataMap ArenaLogEntries; // pussywizard
        BattlegroundScoreMap::const_iterator GetPlayerScoresBegin() const { return PlayerScores.begin(); }
        BattlegroundScoreMap::const_iterator GetPlayerScoresEnd() const { return PlayerScores.end(); }
        uint32 GetPlayerScoresSize() const { return PlayerScores.size(); }

        uint32 GetReviveQueueSize() const { return m_ReviveQueue.size(); }

        void AddPlayerToResurrectQueue(uint64 npc_guid, uint64 player_guid);
        void RemovePlayerFromResurrectQueue(Player* player);

        /// Relocate all players in ReviveQueue to the closest graveyard
        void RelocateDeadPlayers(uint64 queueIndex);

        void StartBattleground();

        GameObject* GetBGObject(uint32 type);
        Creature* GetBGCreature(uint32 type);

        // Location
        void SetMapId(uint32 MapID) { m_MapId = MapID; }
        uint32 GetMapId() const { return m_MapId; }

        // Map pointers
        void SetBgMap(BattlegroundMap* map) { m_Map = map; }
        BattlegroundMap* GetBgMap() const { ASSERT(m_Map); return m_Map; }
        BattlegroundMap* FindBgMap() const { return m_Map; }

        void SetTeamStartLoc(TeamId teamId, float X, float Y, float Z, float O);
        void GetTeamStartLoc(TeamId teamId, float &X, float &Y, float &Z, float &O) const
        {
            X = m_TeamStartLocX[teamId];
            Y = m_TeamStartLocY[teamId];
            Z = m_TeamStartLocZ[teamId];
            O = m_TeamStartLocO[teamId];
        }

        void SetStartMaxDist(float startMaxDist) { m_StartMaxDist = startMaxDist; }
        float GetStartMaxDist() const { return m_StartMaxDist; }

        // Packet Transfer
        // method that should fill worldpacket with actual world states (not yet implemented for all battlegrounds!)
        virtual void FillInitialWorldStates(WorldPacket& /*data*/) {}
        void SendPacketToTeam(TeamId teamId, WorldPacket* packet, Player* sender = NULL, bool self = true);
        void SendPacketToAll(WorldPacket* packet);
        void YellToAll(Creature* creature, const char* text, uint32 language);

        template<class Do>
        void BroadcastWorker(Do& _do);

        void PlaySoundToAll(uint32 soundId);
        void CastSpellOnTeam(uint32 spellId, TeamId teamId);
        void RemoveAuraOnTeam(uint32 spellId, TeamId teamId);
        void RewardHonorToTeam(uint32 honor, TeamId teamId);
        void RewardReputationToTeam(uint32 factionId, uint32 reputation, TeamId teamId);
        uint32 GetRealRepFactionForPlayer(uint32 factionId, Player* player);

        void UpdateWorldState(uint32 Field, uint32 Value);
        void UpdateWorldStateForPlayer(uint32 Field, uint32 Value, Player* player);
        void EndBattleground(TeamId winnerTeamId);
        void BlockMovement(Player* player);

        void SendWarningToAll(int32 entry, ...);
        void SendMessageToAll(int32 entry, ChatMsg type, Player const* source = NULL);
        void PSendMessageToAll(int32 entry, ChatMsg type, Player const* source, ...);

        // specialized version with 2 string id args
        void SendMessage2ToAll(int32 entry, ChatMsg type, Player const* source, int32 strId1 = 0, int32 strId2 = 0);

        // Raid Group
        Group* GetBgRaid(TeamId teamId) const { return m_BgRaids[teamId]; }
        void SetBgRaid(TeamId teamId, Group* bg_raid);

        virtual void UpdatePlayerScore(Player* player, uint32 type, uint32 value, bool doAddHonor = true);

        uint32 GetPlayersCountByTeam(TeamId teamId) const { return m_PlayersCount[teamId]; }
        uint32 GetAlivePlayersCountByTeam(TeamId teamId) const;   // used in arenas to correctly handle death in spirit of redemption / last stand etc. (killer = killed) cases
        void UpdatePlayersCountByTeam(TeamId teamId, bool remove)
        {
            if (remove)
                --m_PlayersCount[teamId];
            else
                ++m_PlayersCount[teamId];
        }

        // used for rated arena battles
        void SetArenaTeamIdForTeam(TeamId teamId, uint32 ArenaTeamId) { m_ArenaTeamIds[teamId] = ArenaTeamId; }
        uint32 GetArenaTeamIdForTeam(TeamId teamId) const             { return m_ArenaTeamIds[teamId]; }
        void SetArenaTeamRatingChangeForTeam(TeamId teamId, int32 RatingChange) { m_ArenaTeamRatingChanges[teamId] = RatingChange; }
        int32 GetArenaTeamRatingChangeForTeam(TeamId teamId) const    { return m_ArenaTeamRatingChanges[teamId]; }
        void SetArenaMatchmakerRating(TeamId teamId, uint32 MMR)      { m_ArenaTeamMMR[teamId] = MMR; }
        uint32 GetArenaMatchmakerRating(TeamId teamId) const          { return m_ArenaTeamMMR[teamId]; }
        void CheckArenaAfterTimerConditions();
        void CheckArenaWinConditions();
        virtual void UpdateArenaWorldState();

        // Triggers handle
        // must be implemented in BG subclass
        virtual void HandleAreaTrigger(Player* /*player*/, uint32 /*trigger*/) {}
        // must be implemented in BG subclass if need AND call base class generic code
        virtual void HandleKillPlayer(Player* player, Player* killer);
        virtual void HandleKillUnit(Creature* /*unit*/, Player* /*killer*/);

        // Battleground events
        virtual void EventPlayerDroppedFlag(Player* /*player*/) {}
        virtual void EventPlayerClickedOnFlag(Player* /*player*/, GameObject* /*gameObject*/) {}
        virtual void EventPlayerDamagedGO(Player* /*player*/, GameObject* /*go*/, uint32 /*eventType*/) {}
        virtual void EventPlayerUsedGO(Player* /*player*/, GameObject* /*go*/){}

        // this function can be used by spell to interact with the BG map
        virtual void DoAction(uint32 /*action*/, uint64 /*var*/) {}

        virtual void HandlePlayerResurrect(Player* /*player*/) {}

        // Death related
        virtual WorldSafeLocsEntry const* GetClosestGraveyard(Player* player);

        virtual void AddPlayer(Player* player);                // must be implemented in BG subclass

        void AddOrSetPlayerToCorrectBgGroup(Player* player, TeamId teamId);

        void RemovePlayerAtLeave(Player* player);
                                                            // can be extended in in BG subclass

        void HandleTriggerBuff(GameObject* gameObject);
        void SetHoliday(bool is_holiday);

        // TODO: make this protected:
        typedef std::vector<uint64> BGObjects;
        typedef std::vector<uint64> BGCreatures;
        BGObjects BgObjects;
        BGCreatures BgCreatures;
        void SpawnBGObject(uint32 type, uint32 respawntime);
        bool AddObject(uint32 type, uint32 entry, float x, float y, float z, float o, float rotation0, float rotation1, float rotation2, float rotation3, uint32 respawnTime = 0, GOState goState = GO_STATE_READY);
        Creature* AddCreature(uint32 entry, uint32 type, float x, float y, float z, float o, uint32 respawntime = 0, MotionTransport* transport = NULL);
        bool DelCreature(uint32 type);
        bool DelObject(uint32 type);
        bool AddSpiritGuide(uint32 type, float x, float y, float z, float o, TeamId teamId);
        int32 GetObjectType(uint64 guid);

        void DoorOpen(uint32 type);
        void DoorClose(uint32 type);
        //to be removed
        const char* GetTrinityString(int32 entry);

        virtual bool HandlePlayerUnderMap(Player* /*player*/) { return false; }

        // since arenas can be AvA or Hvh, we have to get the "temporary" team of a player
        static TeamId GetOtherTeamId(TeamId teamId);
        bool IsPlayerInBattleground(uint64 guid) const;

        bool ToBeDeleted() const { return m_SetDeleteThis; }
        //void SetDeleteThis() { m_SetDeleteThis = true; }

        void RewardXPAtKill(Player* killer, Player* victim);

        virtual uint64 GetFlagPickerGUID(TeamId /*teamId*/ = TEAM_NEUTRAL) const { return 0; }
        virtual void SetDroppedFlagGUID(uint64 /*guid*/, TeamId /*teamId*/ = TEAM_NEUTRAL) {}
        uint32 GetTeamScore(TeamId teamId) const;
        
        virtual TeamId GetPrematureWinner();

        // because BattleGrounds with different types and same level range has different m_BracketId
        uint8 GetUniqueBracketId() const;

        BattlegroundAV* ToBattlegroundAV() { if (GetBgTypeID() == BATTLEGROUND_AV) return reinterpret_cast<BattlegroundAV*>(this); else return NULL; }
        BattlegroundAV const* ToBattlegroundAV() const { if (GetBgTypeID() == BATTLEGROUND_AV) return reinterpret_cast<const BattlegroundAV*>(this); else return NULL; }

        BattlegroundWS* ToBattlegroundWS() { if (GetBgTypeID() == BATTLEGROUND_WS) return reinterpret_cast<BattlegroundWS*>(this); else return NULL; }
        BattlegroundWS const* ToBattlegroundWS() const { if (GetBgTypeID() == BATTLEGROUND_WS) return reinterpret_cast<const BattlegroundWS*>(this); else return NULL; }

        BattlegroundAB* ToBattlegroundAB() { if (GetBgTypeID() == BATTLEGROUND_AB) return reinterpret_cast<BattlegroundAB*>(this); else return NULL; }
        BattlegroundAB const* ToBattlegroundAB() const { if (GetBgTypeID() == BATTLEGROUND_AB) return reinterpret_cast<const BattlegroundAB*>(this); else return NULL; }

        BattlegroundNA* ToBattlegroundNA() { if (GetBgTypeID() == BATTLEGROUND_NA) return reinterpret_cast<BattlegroundNA*>(this); else return NULL; }
        BattlegroundNA const* ToBattlegroundNA() const { if (GetBgTypeID() == BATTLEGROUND_NA) return reinterpret_cast<const BattlegroundNA*>(this); else return NULL; }

        BattlegroundBE* ToBattlegroundBE() { if (GetBgTypeID() == BATTLEGROUND_BE) return reinterpret_cast<BattlegroundBE*>(this); else return NULL; }
        BattlegroundBE const* ToBattlegroundBE() const { if (GetBgTypeID() == BATTLEGROUND_BE) return reinterpret_cast<const BattlegroundBE*>(this); else return NULL; }

        BattlegroundEY* ToBattlegroundEY() { if (GetBgTypeID() == BATTLEGROUND_EY) return reinterpret_cast<BattlegroundEY*>(this); else return NULL; }
        BattlegroundEY const* ToBattlegroundEY() const { if (GetBgTypeID() == BATTLEGROUND_EY) return reinterpret_cast<const BattlegroundEY*>(this); else return NULL; }

        BattlegroundRL* ToBattlegroundRL() { if (GetBgTypeID() == BATTLEGROUND_RL) return reinterpret_cast<BattlegroundRL*>(this); else return NULL; }
        BattlegroundRL const* ToBattlegroundRL() const { if (GetBgTypeID() == BATTLEGROUND_RL) return reinterpret_cast<const BattlegroundRL*>(this); else return NULL; }

        BattlegroundSA* ToBattlegroundSA() { if (GetBgTypeID() == BATTLEGROUND_SA) return reinterpret_cast<BattlegroundSA*>(this); else return NULL; }
        BattlegroundSA const* ToBattlegroundSA() const { if (GetBgTypeID() == BATTLEGROUND_SA) return reinterpret_cast<const BattlegroundSA*>(this); else return NULL; }

        BattlegroundDS* ToBattlegroundDS() { if (GetBgTypeID() == BATTLEGROUND_DS) return reinterpret_cast<BattlegroundDS*>(this); else return NULL; }
        BattlegroundDS const* ToBattlegroundDS() const { if (GetBgTypeID() == BATTLEGROUND_DS) return reinterpret_cast<const BattlegroundDS*>(this); else return NULL; }

        BattlegroundRV* ToBattlegroundRV() { if (GetBgTypeID() == BATTLEGROUND_RV) return reinterpret_cast<BattlegroundRV*>(this); else return NULL; }
        BattlegroundRV const* ToBattlegroundRV() const { if (GetBgTypeID() == BATTLEGROUND_RV) return reinterpret_cast<const BattlegroundRV*>(this); else return NULL; }

        BattlegroundIC* ToBattlegroundIC() { if (GetBgTypeID() == BATTLEGROUND_IC) return reinterpret_cast<BattlegroundIC*>(this); else return NULL; }
        BattlegroundIC const* ToBattlegroundIC() const { if (GetBgTypeID() == BATTLEGROUND_IC) return reinterpret_cast<const BattlegroundIC*>(this); else return NULL; }

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
        // must be implemented in BG subclass
        virtual void RemovePlayer(Player* /*player*/) {}

        // Player lists, those need to be accessible by inherited classes
        BattlegroundPlayerMap  m_Players;
        // Spirit Guide guid + Player list GUIDS
        std::map<uint64, std::vector<uint64> >  m_ReviveQueue;

        // these are important variables used for starting messages
        uint8 m_Events;
        BattlegroundStartTimeIntervals  StartDelayTimes[BG_STARTING_EVENT_COUNT];
        // this must be filled in constructors!
        uint32 StartMessageIds[BG_STARTING_EVENT_COUNT];

        bool   m_BuffChange;

        BGHonorMode m_HonorMode;
        int32 m_TeamScores[BG_TEAMS_COUNT];

        // pussywizard:
        uint32 m_UpdateTimer;
    private:
        // Battleground
        BattlegroundTypeId m_RealTypeID;
        uint32 m_InstanceID;                                // Battleground Instance's GUID!
        BattlegroundStatus m_Status;
        uint32 m_ClientInstanceID;                          // the instance-id which is sent to the client and without any other internal use
        uint32 m_StartTime;
        uint32 m_ResetStatTimer;
        uint32 m_ValidStartPositionTimer;
        int32 m_EndTime;                                    // it is set to 120000 when bg is ending and it decreases itself
        uint32 m_LastResurrectTime;
        uint8  m_ArenaType;                                 // 2=2v2, 3=3v3, 5=5v5
        bool   m_SetDeleteThis;                             // used for safe deletion of the bg after end / all players leave
        bool   m_IsArena;
        TeamId  m_WinnerId;
        int32  m_StartDelayTime;
        bool   m_IsRated;                                   // is this battle rated?
        bool   m_PrematureCountDown;
        uint32 m_PrematureCountDownTimer;
        char const* m_Name;

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
        std::vector<uint64> m_ResurrectQueue;               // Player GUID
        std::deque<uint64> m_OfflineQueue;                  // Player GUID

        // Invited counters are useful for player invitation to BG - do not allow, if BG is started to one faction to have 2 more players than another faction
        // Invited counters will be changed only when removing already invited player from queue, removing player from battleground and inviting player to BG
        // Invited players counters
        uint32 m_BgInvitedPlayers[BG_TEAMS_COUNT];

        // Raid Group
        Group* m_BgRaids[BG_TEAMS_COUNT];                   // 0 - alliance, 1 - horde

        SpectatorList m_Spectators;
        ToBeTeleportedMap m_ToBeTeleported;

        // Players count by team
        uint32 m_PlayersCount[BG_TEAMS_COUNT];

        // Arena team ids by team
        uint32 m_ArenaTeamIds[BG_TEAMS_COUNT];

        int32 m_ArenaTeamRatingChanges[BG_TEAMS_COUNT];
        uint32 m_ArenaTeamMMR[BG_TEAMS_COUNT];

        // Limits
        uint32 m_LevelMin;
        uint32 m_LevelMax;
        uint32 m_MaxPlayersPerTeam;
        uint32 m_MinPlayersPerTeam;

        // Start location
        uint32 m_MapId;
        BattlegroundMap* m_Map;
        float m_TeamStartLocX[BG_TEAMS_COUNT];
        float m_TeamStartLocY[BG_TEAMS_COUNT];
        float m_TeamStartLocZ[BG_TEAMS_COUNT];
        float m_TeamStartLocO[BG_TEAMS_COUNT];
        float m_StartMaxDist;
        uint32 ScriptId;
};
#endif

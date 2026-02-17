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

#ifndef _LFGMGR_H
#define _LFGMGR_H

#include <utility>

#include "DBCStructure.h"
#include "Field.h"
#include "LFG.h"
#include "LFGGroupData.h"
#include "LFGPlayerData.h"
#include "LFGQueue.h"
#include "Map.h"

class Group;
class Player;
class Quest;
class WorldLocation;

namespace lfg
{

    enum LfgOptions
    {
        LFG_OPTION_ENABLE_DUNGEON_FINDER             = 0x01,
        LFG_OPTION_ENABLE_RAID_BROWSER               = 0x02,
        LFG_OPTION_ENABLE_SEASONAL_BOSSES            = 0x04
    };

    enum LFGMgrEnum
    {
        LFG_TIME_ROLECHECK                           = 45 * IN_MILLISECONDS,
        LFG_TIME_BOOT                                = 120,
        LFG_TIME_PROPOSAL                            = 40,
        LFG_QUEUEUPDATE_INTERVAL                     = 8 * IN_MILLISECONDS,
        LFG_SPELL_DUNGEON_COOLDOWN                   = 71328,
        LFG_SPELL_DUNGEON_DESERTER                   = 71041,
        LFG_SPELL_LUCK_OF_THE_DRAW                   = 72221,
        LFG_GROUP_KICK_VOTES_NEEDED                  = 3
    };

    enum LfgFlags
    {
        LFG_FLAG_UNK1                                = 0x1,
        LFG_FLAG_UNK2                                = 0x2,
        LFG_FLAG_SEASONAL                            = 0x4,
        LFG_FLAG_UNK3                                = 0x8
    };

    /// Determines the type of instance
    enum LfgType
    {
        LFG_TYPE_NONE                                = 0,
        LFG_TYPE_DUNGEON                             = 1,
        LFG_TYPE_RAID                                = 2,
        LFG_TYPE_ZONE                                = 4,
        LFG_TYPE_HEROIC                              = 5,
        LFG_TYPE_RANDOM                              = 6
    };

    /// Proposal states
    enum LfgProposalState
    {
        LFG_PROPOSAL_INITIATING                      = 0,
        LFG_PROPOSAL_FAILED                          = 1,
        LFG_PROPOSAL_SUCCESS                         = 2
    };

    /// Teleport errors
    enum LfgTeleportError
    {
        // 7 = "You can't do that right now" | 5 = No client reaction
        LFG_TELEPORTERROR_OK                         = 0,      // Internal use
        LFG_TELEPORTERROR_PLAYER_DEAD                = 1,
        LFG_TELEPORTERROR_FALLING                    = 2,
        LFG_TELEPORTERROR_IN_VEHICLE                 = 3,
        LFG_TELEPORTERROR_FATIGUE                    = 4,
        LFG_TELEPORTERROR_INVALID_LOCATION           = 6,
        LFG_TELEPORTERROR_COMBAT                     = 8       // FIXME - It can be 7 or 8 (Need proper data)
    };

    /// Queue join results
    enum LfgJoinResult
    {
        // 3 = No client reaction | 18 = "Rolecheck failed"
        LFG_JOIN_OK                                  = 0,      // Joined (no client msg)
        LFG_JOIN_FAILED                              = 1,      // RoleCheck Failed
        LFG_JOIN_GROUPFULL                           = 2,      // Your group is full
        LFG_JOIN_INTERNAL_ERROR                      = 4,      // Internal LFG Error
        LFG_JOIN_NOT_MEET_REQS                       = 5,      // You do not meet the requirements for the chosen dungeons
        LFG_JOIN_PARTY_NOT_MEET_REQS                 = 6,      // One or more party members do not meet the requirements for the chosen dungeons
        LFG_JOIN_MIXED_RAID_DUNGEON                  = 7,      // You cannot mix dungeons, raids, and random when picking dungeons
        LFG_JOIN_MULTI_REALM                         = 8,      // The dungeon you chose does not support players from multiple realms
        LFG_JOIN_DISCONNECTED                        = 9,      // One or more party members are pending invites or disconnected
        LFG_JOIN_PARTY_INFO_FAILED                   = 10,     // Could not retrieve information about some party members
        LFG_JOIN_DUNGEON_INVALID                     = 11,     // One or more dungeons was not valid
        LFG_JOIN_DESERTER                            = 12,     // You can not queue for dungeons until your deserter debuff wears off
        LFG_JOIN_PARTY_DESERTER                      = 13,     // One or more party members has a deserter debuff
        LFG_JOIN_RANDOM_COOLDOWN                     = 14,     // You can not queue for random dungeons while on random dungeon cooldown
        LFG_JOIN_PARTY_RANDOM_COOLDOWN               = 15,     // One or more party members are on random dungeon cooldown
        LFG_JOIN_TOO_MUCH_MEMBERS                    = 16,     // You can not enter dungeons with more that 5 party members
        LFG_JOIN_USING_BG_SYSTEM                     = 17      // You can not use the dungeon system while in BG or arenas
    };

    /// Role check states
    enum LfgRoleCheckState
    {
        LFG_ROLECHECK_DEFAULT                        = 0,      // Internal use = Not initialized.
        LFG_ROLECHECK_FINISHED                       = 1,      // Role check finished
        LFG_ROLECHECK_INITIALITING                   = 2,      // Role check begins
        LFG_ROLECHECK_MISSING_ROLE                   = 3,      // Someone didn't selected a role after 2 mins
        LFG_ROLECHECK_WRONG_ROLES                    = 4,      // Can't form a group with that role selection
        LFG_ROLECHECK_ABORTED                        = 5,      // Someone leave the group
        LFG_ROLECHECK_NO_ROLE                        = 6       // Someone selected no role
    };

    enum LfgUpdateFlag // pussywizard: for raid browser
    {
        LFG_UPDATE_FLAG_NONE          = 0x00,
        LFG_UPDATE_FLAG_CHARACTERINFO = 0x01,
        LFG_UPDATE_FLAG_COMMENT       = 0x02,
        LFG_UPDATE_FLAG_GROUPLEADER   = 0x04,
        LFG_UPDATE_FLAG_GROUPGUID     = 0x08,
        LFG_UPDATE_FLAG_ROLES         = 0x10,
        LFG_UPDATE_FLAG_AREA          = 0x20,
        LFG_UPDATE_FLAG_STATUS        = 0x40,
        LFG_UPDATE_FLAG_BINDED        = 0x80
    };

    enum LfgSeasonalDungeons
    {
        LFG_DUNGEON_HEADLESS_HORSEMAN   = 285,
        LFG_DUNGEON_FROST_LORD_AHUNE    = 286,
        LFG_DUNGEON_COREN_DIREBREW      = 287,
        LFG_DUNGEON_CROWN_CHEMICAL_CO   = 288
    };

    struct RBEntryInfo
    {
        RBEntryInfo() = default;
        RBEntryInfo(uint8 _roles, std::string  _comment) : roles(_roles), comment(std::move(_comment)) {}
        uint8 roles;
        std::string comment;
    };

    struct RBInternalInfo
    {
        ObjectGuid guid;
        std::string comment;
        bool isGroupLeader;
        ObjectGuid groupGuid;
        uint8 roles;
        uint32 encounterMask;
        ObjectGuid instanceGuid;

        // additional character info parameters:
        uint8 _online;
        uint8 _level;
        uint8 _class;
        uint8 _race;
        float _avgItemLevel;
        // --
        uint8 _talents0;
        uint8 _talents1;
        uint8 _talents2;
        uint32 _area;
        uint32 _armor;
        uint32 _spellDamage;
        uint32 _spellHeal;
        // --
        uint32 _critRatingMelee;
        uint32 _critRatingRanged;
        uint32 _critRatingSpell;
        float _mp5;
        float _mp5combat;
        // --
        uint32 _attackPower;
        uint32 _agility;
        uint32 _health;
        uint32 _mana;
        uint32 _defenseSkill;
        // --
        uint32 _dodgeRating;
        uint32 _blockRating;
        uint32 _parryRating;
        uint32 _hasteRating;
        uint32 _expertiseRating;

        RBInternalInfo() = default;
        RBInternalInfo(ObjectGuid guid, std::string  comment, bool isGroupLeader, ObjectGuid groupGuid, uint8 roles, uint32 encounterMask, ObjectGuid instanceGuid,
                       uint8 _online, uint8 _level, uint8 _class, uint8 _race, float _avgItemLevel,
                       uint8 (&_talents)[3], uint32 _area, uint32 _armor, uint32 _spellDamage, uint32 _spellHeal,
                       uint32 _critRatingMelee, uint32 _critRatingRanged, uint32 _critRatingSpell, float _mp5, float _mp5combat,
                       uint32 _attackPower, uint32 _agility, uint32 _health, uint32 _mana, uint32 _defenseSkill,
                       uint32 _dodgeRating, uint32 _blockRating, uint32 _parryRating, uint32 _hasteRating, uint32 _expertiseRating)
            : guid(guid), comment(std::move(comment)), isGroupLeader(isGroupLeader), groupGuid(groupGuid), roles(roles), encounterMask(encounterMask), instanceGuid(instanceGuid),
              _online(_online), _level(_level), _class(_class), _race(_race), _avgItemLevel(_avgItemLevel),
              _talents0(_talents[0]), _talents1(_talents[1]), _talents2(_talents[2]), _area(_area), _armor(_armor), _spellDamage(_spellDamage), _spellHeal(_spellHeal),
              _critRatingMelee(_critRatingMelee), _critRatingRanged(_critRatingRanged), _critRatingSpell(_critRatingSpell), _mp5(_mp5), _mp5combat(_mp5combat),
              _attackPower(_attackPower), _agility(_agility), _health(_health), _mana(_mana), _defenseSkill(_defenseSkill),
              _dodgeRating(_dodgeRating), _blockRating(_blockRating), _parryRating(_parryRating), _hasteRating(_hasteRating), _expertiseRating(_expertiseRating)
        {}
        [[nodiscard]] bool PlayerSameAs(RBInternalInfo const& i) const
        {
            return isGroupLeader == i.isGroupLeader && groupGuid == i.groupGuid && roles == i.roles && (isGroupLeader || (comment == i.comment && encounterMask == i.encounterMask && instanceGuid == i.instanceGuid))
                   && _online == i._online && _level == i._level && _class == i._class && _race == i._race && std::fabs(_avgItemLevel - i._avgItemLevel) < 0.01f
                   && _talents0 == i._talents0 && _talents1 == i._talents1 && _talents2 == i._talents2 && _area == i._area && _armor == i._armor && _spellDamage == i._spellDamage && _spellHeal == i._spellHeal
                   && _critRatingMelee == i._critRatingMelee && _critRatingRanged == i._critRatingRanged && _critRatingSpell == i._critRatingSpell && std::fabs(_mp5 - i._mp5) < 0.01f && std::fabs(_mp5combat - i._mp5combat) < 0.01f
                   && _attackPower == i._attackPower && _agility == i._agility && _health == i._health && _mana == i._mana && _defenseSkill == i._defenseSkill
                   && _dodgeRating == i._dodgeRating && _blockRating == i._blockRating && _parryRating == i._parryRating && _hasteRating == i._hasteRating && _expertiseRating == i._expertiseRating;
        }
        void CopyStats(RBInternalInfo const& i)
        {
            _avgItemLevel = i._avgItemLevel;
            _talents0 = i._talents0;
            _talents1 = i._talents1;
            _talents2 = i._talents2;
            _area = i._area;
            _armor = i._armor;
            _spellDamage = i._spellDamage;
            _spellHeal = i._spellHeal;
            _critRatingMelee = i._critRatingMelee;
            _critRatingRanged = i._critRatingRanged;
            _critRatingSpell = i._critRatingSpell;
            _mp5 = i._mp5;
            _mp5combat = i._mp5combat;
            _attackPower = i._attackPower;
            _agility = i._agility;
            _health = i._health;
            _mana = i._mana;
            _defenseSkill = i._defenseSkill;
            _dodgeRating = i._dodgeRating;
            _blockRating = i._blockRating;
            _parryRating = i._parryRating;
            _hasteRating = i._hasteRating;
            _expertiseRating = i._expertiseRating;
        }
    };

    // Forward declaration (just to have all typedef together)
    struct LFGDungeonData;
    struct LfgReward;
    struct LfgQueueInfo;
    struct LfgRoleCheck;
    struct LfgProposal;
    struct LfgProposalPlayer;
    struct LfgPlayerBoot;

    typedef std::map<uint8, LFGQueue> LfgQueueContainer;
    typedef std::multimap<uint32, LfgReward const*> LfgRewardContainer;
    typedef std::pair<LfgRewardContainer::const_iterator, LfgRewardContainer::const_iterator> LfgRewardContainerBounds;
    typedef std::map<uint8, LfgDungeonSet> LfgCachedDungeonContainer;
    typedef std::map<ObjectGuid, LfgAnswer> LfgAnswerContainer;
    typedef std::map<ObjectGuid, LfgRoleCheck> LfgRoleCheckContainer;
    typedef std::map<uint32, LfgProposal> LfgProposalContainer;
    typedef std::map<ObjectGuid, LfgProposalPlayer> LfgProposalPlayerContainer;
    typedef std::map<ObjectGuid, LfgPlayerBoot> LfgPlayerBootContainer;
    typedef std::map<ObjectGuid, LfgGroupData> LfgGroupDataContainer;
    typedef std::map<ObjectGuid, LfgPlayerData> LfgPlayerDataContainer;
    typedef std::unordered_map<uint32, LFGDungeonData> LFGDungeonContainer;

    // Data needed by SMSG_LFG_JOIN_RESULT
    struct LfgJoinResultData
    {
        LfgJoinResultData(LfgJoinResult _result = LFG_JOIN_OK, LfgRoleCheckState _state = LFG_ROLECHECK_DEFAULT):
            result(_result), state(_state) {}
        LfgJoinResult result;
        LfgRoleCheckState state;
        LfgLockPartyMap lockmap;
    };

    // Data needed by SMSG_LFG_UPDATE_PARTY and SMSG_LFG_UPDATE_PLAYER
    struct LfgUpdateData
    {
        LfgUpdateData(LfgUpdateType _type = LFG_UPDATETYPE_DEFAULT): updateType(_type),  comment("") { }
        LfgUpdateData(LfgUpdateType _type, LfgDungeonSet  _dungeons, std::string  _comment):
            updateType(_type), state(LFG_STATE_NONE), dungeons(std::move(_dungeons)), comment(std::move(_comment)) { }
        LfgUpdateData(LfgUpdateType _type, LfgState _state, LfgDungeonSet  _dungeons, std::string  _comment = ""):
            updateType(_type), state(_state), dungeons(std::move(_dungeons)), comment(std::move(_comment)) { }

        LfgUpdateType updateType;
        LfgState state{LFG_STATE_NONE};
        LfgDungeonSet dungeons;
        std::string comment;
    };

    // Data needed by SMSG_LFG_QUEUE_STATUS
    struct LfgQueueStatusData
    {
        LfgQueueStatusData(uint32 _dungeonId = 0, int32 _waitTime = -1, int32 _waitTimeAvg = -1, int32 _waitTimeTank = -1, int32 _waitTimeHealer = -1,
                           int32 _waitTimeDps = -1, uint32 _queuedTime = 0, uint8 _tanks = 0, uint8 _healers = 0, uint8 _dps = 0) :
            dungeonId(_dungeonId), waitTime(_waitTime), waitTimeAvg(_waitTimeAvg), waitTimeTank(_waitTimeTank), waitTimeHealer(_waitTimeHealer),
            waitTimeDps(_waitTimeDps), queuedTime(_queuedTime), tanks(_tanks), healers(_healers), dps(_dps) {}

        uint32 dungeonId;
        int32 waitTime;
        int32 waitTimeAvg;
        int32 waitTimeTank;
        int32 waitTimeHealer;
        int32 waitTimeDps;
        uint32 queuedTime;
        uint8 tanks;
        uint8 healers;
        uint8 dps;
    };

    struct LfgPlayerRewardData
    {
        LfgPlayerRewardData(uint32 random, uint32 current, bool _done, Quest const* _quest):
            rdungeonEntry(random), sdungeonEntry(current), done(_done), quest(_quest) { }
        uint32 rdungeonEntry;
        uint32 sdungeonEntry;
        bool done;
        Quest const* quest;
    };

    // Reward info
    struct LfgReward
    {
        LfgReward(uint32 _maxLevel = 0, uint32 _firstQuest = 0, uint32 _otherQuest = 0):
            maxLevel(_maxLevel), firstQuest(_firstQuest), otherQuest(_otherQuest) { }

        uint32 maxLevel;
        uint32 firstQuest;
        uint32 otherQuest;
    };

    // Stores player data related to proposal to join
    struct LfgProposalPlayer
    {
        LfgProposalPlayer() = default;
        uint8 role{0};                                         ///< Proposed role
        LfgAnswer accept{LFG_ANSWER_PENDING};                  ///< Accept status (-1 not answer | 0 Not agree | 1 agree)
        ObjectGuid group;                                      ///< Original group guid. 0 if no original group
    };

    // Stores group data related to proposal to join
    struct LfgProposal
    {
        LfgProposal(uint32 dungeon = 0):  dungeonId(dungeon)
        { }

        uint32 id{0};                                          ///< Proposal Id
        uint32 dungeonId;                                      ///< Dungeon to join
        LfgProposalState state{LFG_PROPOSAL_INITIATING};       ///< State of the proposal
        ObjectGuid group;                                      ///< Proposal group (0 if new)
        ObjectGuid leader;                                     ///< Leader guid.
        time_t cancelTime{0};                                  ///< Time when we will cancel this proposal
        uint32 encounters{0};                                  ///< Dungeon Encounters
        bool isNew{true};                                      ///< Determines if it's new group or not
        Lfg5Guids queues;                                      ///< Queue Ids to remove/readd
        LfgGuidList showorder;                                 ///< Show order in update window
        LfgProposalPlayerContainer players;                    ///< Players data
    };

    // Stores all rolecheck info of a group that wants to join
    struct LfgRoleCheck
    {
        time_t cancelTime;                                     ///< Time when the rolecheck will fail
        LfgRolesMap roles;                                     ///< Player selected roles
        LfgRoleCheckState state;                               ///< State of the rolecheck
        LfgDungeonSet dungeons;                                ///< Dungeons group is applying for (expanded random dungeons)
        uint32 rDungeonId;                                     ///< Random Dungeon Id.
        ObjectGuid leader;                                     ///< Leader of the group
    };

    // Stores information of a current vote to kick someone from a group
    struct LfgPlayerBoot
    {
        time_t cancelTime;                                     ///< Time left to vote
        bool inProgress;                                       ///< Vote in progress
        LfgAnswerContainer votes;                              ///< Player votes (-1 not answer | 0 Not agree | 1 agree)
        ObjectGuid victim;                                     ///< Player guid to be kicked (can't vote)
        std::string reason;                                    ///< kick reason
    };

    struct LFGDungeonData
    {
        LFGDungeonData():  name("")
        { }
        LFGDungeonData(LFGDungeonEntry const* dbc) : id(dbc->ID), name(dbc->Name[0]), map(dbc->MapID),
            type(dbc->TypeID), expansion(uint8(dbc->ExpansionLevel)), group(uint8(dbc->GroupID)),
            minlevel(uint8(dbc->MinLevel)), maxlevel(uint8(dbc->MaxLevel)), difficulty(Difficulty(dbc->Difficulty)),
            seasonal((dbc->Flags & LFG_FLAG_SEASONAL) != 0), x(0.0f), y(0.0f), z(0.0f), o(0.0f)
        { }

        uint32 id{0};
        std::string name;
        uint16 map{0};
        uint8 type{0};
        uint8 expansion{0};
        uint8 group{0};
        uint8 minlevel{0};
        uint8 maxlevel{0};
        Difficulty difficulty{REGULAR_DIFFICULTY};
        bool seasonal{false};
        float x{0.0f}, y{0.0f}, z{0.0f}, o{0.0f};

        // Helpers
        [[nodiscard]] uint32 Entry() const { return id + (type << 24); }
    };

    class LFGMgr
    {
    private:
        LFGMgr();
        ~LFGMgr();

        // pussywizard: RAIDBROWSER
        typedef std::unordered_map<ObjectGuid /*playerGuid*/, RBEntryInfo> RBEntryInfoMap;
        typedef std::unordered_map<uint32 /*dungeonId*/, RBEntryInfoMap> RBStoreMap;
        RBStoreMap RaidBrowserStore[2]; // for 2 factions
        typedef std::unordered_map<ObjectGuid /*playerGuid*/, uint32 /*dungeonId*/> RBSearchersMap;
        RBSearchersMap RBSearchersStore[2]; // for 2 factions
        typedef std::unordered_map<uint32 /*dungeonId*/, WorldPacket> RBCacheMap;
        RBCacheMap RBCacheStore[2]; // for 2 factions
        typedef std::unordered_map<ObjectGuid /*guid*/, RBInternalInfo> RBInternalInfoMap;
        typedef std::unordered_map<uint32 /*dungeonId*/, RBInternalInfoMap> RBInternalInfoMapMap;
        RBInternalInfoMapMap RBInternalInfoStorePrev[2]; // for 2 factions
        RBInternalInfoMapMap RBInternalInfoStoreCurr[2]; // for 2 factions
        typedef std::set<uint32 /*dungeonId*/> RBUsedDungeonsSet; // needs to be ordered
        RBUsedDungeonsSet RBUsedDungeonsStore[2]; // for 2 factions

    public:
        static LFGMgr* instance();

        // Functions used outside lfg namespace
        void Update(uint32 diff, uint8 task);

        // World.cpp
        /// Finish the dungeon for the given group. All check are performed using internal lfg data
        void FinishDungeon(ObjectGuid gguid, uint32 dungeonId, const Map* currMap);
        /// Loads rewards for random dungeons
        void LoadRewards();
        /// Loads dungeons from dbc and adds teleport coords
        void LoadLFGDungeons(bool reload = false);

        // Multiple files
        /// Check if given guid applied for random dungeon
        bool selectedRandomLfgDungeon(ObjectGuid guid);
        /// Check if given guid applied for given map and difficulty. Used to know
        bool inLfgDungeonMap(ObjectGuid guid, uint32 map, Difficulty difficulty);
        /// Get selected dungeons
        LfgDungeonSet const& GetSelectedDungeons(ObjectGuid guid);
        /// Get current lfg state
        LfgState GetState(ObjectGuid guid);
        /// Get current dungeon
        uint32 GetDungeon(ObjectGuid guid, bool asId = true);
        /// Get the map id of the current dungeon
        uint32 GetDungeonMapId(ObjectGuid guid);
        /// Get kicks left in current group
        uint8 GetKicksLeft(ObjectGuid gguid);
        /// Load Lfg group info from DB
        void _LoadFromDB(Field* fields, ObjectGuid guid);
        /// Initializes player data after loading group data from DB
        void SetupGroupMember(ObjectGuid guid, ObjectGuid gguid);
        /// Return Lfg dungeon entry for given dungeon id
        uint32 GetLFGDungeonEntry(uint32 id);

        // cs_lfg
        /// Get current player roles
        uint8 GetRoles(ObjectGuid guid);
        /// Get current player comment (used for LFR)
        std::string const& GetComment(ObjectGuid gguid);
        /// Gets current lfg options
        uint32 GetOptions();
        /// Sets new lfg options
        void SetOptions(uint32 options);
        /// Checks if given lfg option is enabled
        bool isOptionEnabled(uint32 option);
        /// Clears queue - Only for internal testing
        void Clean();

        // LFGScripts
        /// Get leader of the group (using internal data)
        ObjectGuid GetLeader(ObjectGuid guid);
        /// Initializes locked dungeons for given player (called at login or level change)
        void InitializeLockedDungeons(Player* player, Group const* group = nullptr);
        /// Sets player team
        void SetTeam(ObjectGuid guid, TeamId teamId);
        /// Sets player group
        void SetGroup(ObjectGuid guid, ObjectGuid group);
        /// Gets player group
        ObjectGuid GetGroup(ObjectGuid guid);
        /// Sets the leader of the group
        void SetLeader(ObjectGuid gguid, ObjectGuid leader);
        /// Removes saved group data
        void RemoveGroupData(ObjectGuid guid);
        /// Removes a player from a group
        uint8 RemovePlayerFromGroup(ObjectGuid gguid, ObjectGuid guid);
        /// Adds player to group
        void AddPlayerToGroup(ObjectGuid gguid, ObjectGuid guid);
        /// Store player that selected random queue to group
        void AddPlayerQueuedForRandomDungeonToGroup(ObjectGuid gguid, ObjectGuid guid);
        bool IsPlayerQueuedForRandomDungeon(ObjectGuid guid);
        /// Xinef: Set Random Players Count
        void SetRandomPlayersCount(ObjectGuid guid, uint8 count);
        /// Xinef: Get Random Players Count
        uint8 GetRandomPlayersCount(ObjectGuid guid);

        // LFGHandler
        /// Get locked dungeons
        LfgLockMap const& GetLockedDungeons(ObjectGuid guid);
        /// Returns current lfg status
        LfgUpdateData GetLfgStatus(ObjectGuid guid);
        /// Checks if Seasonal dungeon is active
        bool IsSeasonActive(uint32 dungeonId);
        /// Checks if given dungeon map is disabled
        bool IsDungeonDisabled(uint32 mapId, Difficulty difficulty) const;
        /// Gets the random dungeon reward corresponding to given dungeon and player level
        LfgReward const* GetRandomDungeonReward(uint32 dungeon, uint8 level);
        /// Returns all random and seasonal dungeons for given level and expansion
        LfgDungeonSet GetRandomAndSeasonalDungeons(uint8 level, uint8 expansion);
        /// Teleport a player to/from selected dungeon
        void TeleportPlayer(Player* player, bool out, WorldLocation const* teleportLocation = nullptr);
        /// Inits new proposal to boot a player
        void InitBoot(ObjectGuid gguid, ObjectGuid kicker, ObjectGuid victim, std::string const& reason);
        /// Updates player boot proposal with new player answer
        void UpdateBoot(ObjectGuid guid, bool accept);
        /// Updates proposal to join dungeon with player answer
        void UpdateProposal(uint32 proposalId, ObjectGuid guid, bool accept);
        /// Updates the role check with player answer
        void UpdateRoleCheck(ObjectGuid gguid, ObjectGuid guid = ObjectGuid::Empty, uint8 roles = PLAYER_ROLE_NONE);
        /// Sets player lfg roles
        void SetRoles(ObjectGuid guid, uint8 roles);
        /// Sets player lfr comment
        void SetComment(ObjectGuid guid, std::string const& comment);
        /// Join Lfg with selected roles, dungeons and comment
        void JoinLfg(Player* player, uint8 roles, LfgDungeonSet& dungeons, std::string const& comment);
        /// Leaves lfg
        void LeaveLfg(ObjectGuid guid);
        /// pussywizard: cleans all queues' data
        void LeaveAllLfgQueues(ObjectGuid guid, bool allowgroup, ObjectGuid groupguid = ObjectGuid::Empty);
        /// pussywizard: Raid Browser
        void JoinRaidBrowser(Player* player, uint8 roles, LfgDungeonSet& dungeons, std::string comment);
        void LeaveRaidBrowser(ObjectGuid guid);
        void LfrSearchAdd(Player* p, uint32 dungeonId);
        void LfrSearchRemove(Player* p);
        void SendRaidBrowserCachedList(Player* player, uint32 dungeonId);
        void UpdateRaidBrowser(uint32 diff);
        void LfrSetComment(Player* p, std::string comment);
        void SendRaidBrowserJoinedPacket(Player* p, LfgDungeonSet& dungeons, std::string comment);
        void RBPacketAppendGroup(const RBInternalInfo& info, ByteBuffer& buffer);
        void RBPacketAppendPlayer(const RBInternalInfo& info, ByteBuffer& buffer);
        void RBPacketBuildDifference(WorldPacket& differencePacket, uint32 dungeonId, uint32 deletedCounter, ByteBuffer& buffer_deleted, uint32 groupCounter, ByteBuffer& buffer_groups, uint32 playerCounter, ByteBuffer& buffer_players);
        void RBPacketBuildFull(WorldPacket& fullPacket, uint32 dungeonId, RBInternalInfoMap& infoMap);

        // LfgQueue
        /// Get last lfg state (NONE, DUNGEON or FINISHED_DUNGEON)
        LfgState GetOldState(ObjectGuid guid);
        /// Check if given group guid is lfg
        bool IsLfgGroup(ObjectGuid guid);
        /// Gets the player count of given group
        uint8 GetPlayerCount(ObjectGuid guid);
        /// Add a new Proposal
        uint32 AddProposal(LfgProposal& proposal);
        /// Checks if all players are queued
        bool AllQueued(Lfg5Guids const& check);
        /// Checks if given roles match, modifies given roles map with new roles
        static uint8 CheckGroupRoles(LfgRolesMap& groles);
        /// Checks if given players are ignoring each other
        static bool HasIgnore(ObjectGuid guid1, ObjectGuid guid2);
        /// Sends queue status to player
        static void SendLfgQueueStatus(ObjectGuid guid, LfgQueueStatusData const& data);
        // debug lfg command
        void ToggleTesting();
        /// For 1 player queue testing
        [[nodiscard]] bool IsTesting() const { return m_Testing; }

        void SetDungeon(ObjectGuid guid, uint32 dungeon);

    private:
        TeamId GetTeam(ObjectGuid guid);
        void RestoreState(ObjectGuid guid, char const* debugMsg);
        void ClearState(ObjectGuid guid, char const* debugMsg);
        void SetSelectedDungeons(ObjectGuid guid, LfgDungeonSet const& dungeons);
        void SetLockedDungeons(ObjectGuid guid, LfgLockMap const& lock);
        void DecreaseKicksLeft(ObjectGuid guid);
        void SetState(ObjectGuid guid, LfgState state);
        void SetCanOverrideRBState(ObjectGuid guid, bool val);
        void GetCompatibleDungeons(LfgDungeonSet& dungeons, LfgGuidSet const& players, LfgLockPartyMap& lockMap, uint32 randomDungeonId = 0);
        void _SaveToDB(ObjectGuid guid);
        LFGDungeonData const* GetLFGDungeon(uint32 id);

        // Proposals
        void RemoveProposal(LfgProposalContainer::iterator itProposal, LfgUpdateType type);
        void MakeNewGroup(LfgProposal const& proposal);

        // Generic
        LFGQueue& GetQueue(ObjectGuid guid);
        LfgDungeonSet const& GetDungeonsByRandom(uint32 randomdungeon);
        LfgType GetDungeonType(uint32 dungeon);

        void SendLfgBootProposalUpdate(ObjectGuid guid, LfgPlayerBoot const& boot);
        void SendLfgJoinResult(ObjectGuid guid, LfgJoinResultData const& data);
        void SendLfgRoleChosen(ObjectGuid guid, ObjectGuid pguid, uint8 roles);
        void SendLfgRoleCheckUpdate(ObjectGuid guid, LfgRoleCheck const& roleCheck);
        void SendLfgUpdateParty(ObjectGuid guid, LfgUpdateData const& data);
        void SendLfgUpdatePlayer(ObjectGuid guid, LfgUpdateData const& data);
        void SendLfgUpdateProposal(ObjectGuid guid, LfgProposal const& proposal);

        LfgGuidSet const& GetPlayers(ObjectGuid guid);

        // General variables
        uint32 m_lfgProposalId;                            ///< used as internal counter for proposals
        uint32 m_options;                                  ///< Stores config options
        uint32 lastProposalId;                             ///< pussywizard, store it here because of splitting LFGMgr update into tasks
        uint32 m_raidBrowserUpdateTimer[2];                ///< pussywizard
        uint32 m_raidBrowserLastUpdatedDungeonId[2];       ///< pussywizard: for 2 factions

        LfgQueueContainer QueuesStore;                     ///< Queues
        LfgCachedDungeonContainer CachedDungeonMapStore;   ///< Stores all dungeons by groupType
        // Reward System
        LfgRewardContainer RewardMapStore;                 ///< Stores rewards for random dungeons
        LFGDungeonContainer  LfgDungeonStore;
        // Rolecheck - Proposal - Vote Kicks
        LfgRoleCheckContainer RoleChecksStore;             ///< Current Role checks
        LfgProposalContainer ProposalsStore;               ///< Current Proposals
        LfgPlayerBootContainer BootsStore;                 ///< Current player kicks
        LfgPlayerDataContainer PlayersStore;               ///< Player data
        LfgGroupDataContainer GroupsStore;                 ///< Group data
        bool m_Testing;
    };

    template <typename T, FMT_ENABLE_IF(std::is_enum_v<T>)>
    auto format_as(T f) { return fmt::underlying(f); }

} // namespace lfg

#define sLFGMgr lfg::LFGMgr::instance()

#endif

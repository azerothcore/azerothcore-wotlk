/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

/// \addtogroup world The World
/// @{
/// \file

#ifndef __WORLD_H
#define __WORLD_H

#include "Common.h"
#include "Timer.h"
#include "SharedDefines.h"
#include "QueryResult.h"
#include "Callback.h"

#include <map>
#include <set>
#include <list>
#include <atomic>

class Object;
class WorldPacket;
class WorldSession;
class Player;
class WorldSocket;
class SystemMgr;

extern uint32 realmID;

// ServerMessages.dbc
enum ServerMessageType
{
    SERVER_MSG_SHUTDOWN_TIME      = 1,
    SERVER_MSG_RESTART_TIME       = 2,
    SERVER_MSG_STRING             = 3,
    SERVER_MSG_SHUTDOWN_CANCELLED = 4,
    SERVER_MSG_RESTART_CANCELLED  = 5
};

enum ShutdownMask
{
    SHUTDOWN_MASK_RESTART = 1,
    SHUTDOWN_MASK_IDLE    = 2,
};

enum ShutdownExitCode
{
    SHUTDOWN_EXIT_CODE = 0,
    ERROR_EXIT_CODE    = 1,
    RESTART_EXIT_CODE  = 2,
};

/// Timers for different object refresh rates
enum WorldTimers
{
    WUPDATE_AUCTIONS,
    WUPDATE_WEATHERS,
    WUPDATE_UPTIME,
    WUPDATE_CORPSES,
    WUPDATE_EVENTS,
    WUPDATE_CLEANDB,
    WUPDATE_AUTOBROADCAST,
    WUPDATE_MAILBOXQUEUE,
    WUPDATE_PINGDB,
    WUPDATE_5_SECS,
    WUPDATE_COUNT
};

/// Configuration elements
enum WorldBoolConfigs
{
    CONFIG_DURABILITY_LOSS_IN_PVP = 0,
    CONFIG_ADDON_CHANNEL,
    CONFIG_ALLOW_PLAYER_COMMANDS,
    CONFIG_CLEAN_CHARACTER_DB,
    CONFIG_STATS_SAVE_ONLY_ON_LOGOUT,
    CONFIG_ALLOW_TWO_SIDE_ACCOUNTS,
    CONFIG_ALLOW_TWO_SIDE_INTERACTION_CALENDAR,
    CONFIG_ALLOW_TWO_SIDE_INTERACTION_CHAT,
    CONFIG_ALLOW_TWO_SIDE_INTERACTION_CHANNEL,
    CONFIG_ALLOW_TWO_SIDE_INTERACTION_GROUP,
    CONFIG_ALLOW_TWO_SIDE_INTERACTION_GUILD,
    CONFIG_ALLOW_TWO_SIDE_INTERACTION_AUCTION,
    CONFIG_ALLOW_TWO_SIDE_INTERACTION_MAIL,
    CONFIG_ALLOW_TWO_SIDE_WHO_LIST,
    CONFIG_ALLOW_TWO_SIDE_ADD_FRIEND,
    CONFIG_ALLOW_TWO_SIDE_TRADE,
    CONFIG_ALL_TAXI_PATHS,
    CONFIG_INSTANCE_IGNORE_LEVEL,
    CONFIG_INSTANCE_IGNORE_RAID,
    CONFIG_INSTANCE_GMSUMMON_PLAYER,
    CONFIG_INSTANCE_SHARED_ID,
    CONFIG_GM_LOG_TRADE,
    CONFIG_ALLOW_GM_GROUP,
    CONFIG_ALLOW_GM_FRIEND,
    CONFIG_GM_LOWER_SECURITY,
    CONFIG_SKILL_PROSPECTING,
    CONFIG_SKILL_MILLING,
    CONFIG_SAVE_RESPAWN_TIME_IMMEDIATELY,
    CONFIG_WEATHER,
    CONFIG_ALWAYS_MAX_SKILL_FOR_LEVEL,
    CONFIG_QUEST_IGNORE_RAID,
    CONFIG_DETECT_POS_COLLISION,
    CONFIG_RESTRICTED_LFG_CHANNEL,
    CONFIG_SILENTLY_GM_JOIN_TO_CHANNEL,
    CONFIG_TALENTS_INSPECTING,
    CONFIG_CHAT_FAKE_MESSAGE_PREVENTING,
    CONFIG_CHAT_MUTE_FIRST_LOGIN,
    CONFIG_DEATH_CORPSE_RECLAIM_DELAY_PVP,
    CONFIG_DEATH_CORPSE_RECLAIM_DELAY_PVE,
    CONFIG_DEATH_BONES_WORLD,
    CONFIG_DEATH_BONES_BG_OR_ARENA,
    CONFIG_DIE_COMMAND_MODE,
    CONFIG_DECLINED_NAMES_USED,
    CONFIG_BATTLEGROUND_DISABLE_QUEST_SHARE_IN_BG,
    CONFIG_BATTLEGROUND_DISABLE_READY_CHECK_IN_BG,
    CONFIG_BATTLEGROUND_CAST_DESERTER,
    CONFIG_BATTLEGROUND_QUEUE_ANNOUNCER_ENABLE,
    CONFIG_BATTLEGROUND_QUEUE_ANNOUNCER_PLAYERONLY,
    CONFIG_BATTLEGROUND_STORE_STATISTICS_ENABLE,
    CONFIG_BATTLEGROUND_TRACK_DESERTERS,
    CONFIG_BG_XP_FOR_KILL,
    CONFIG_ARENA_AUTO_DISTRIBUTE_POINTS,
    CONFIG_ARENA_SEASON_IN_PROGRESS,
    CONFIG_ARENA_QUEUE_ANNOUNCER_ENABLE,
    CONFIG_OFFHAND_CHECK_AT_SPELL_UNLEARN,
    CONFIG_VMAP_INDOOR_CHECK,
    CONFIG_PET_LOS,
    CONFIG_START_ALL_SPELLS,
    CONFIG_START_ALL_EXPLORED,
    CONFIG_START_ALL_REP,
    CONFIG_ALWAYS_MAXSKILL,
    CONFIG_PVP_TOKEN_ENABLE,
    CONFIG_NO_RESET_TALENT_COST,
    CONFIG_SHOW_KICK_IN_WORLD,
    CONFIG_SHOW_MUTE_IN_WORLD,
    CONFIG_SHOW_BAN_IN_WORLD,
    CONFIG_CHATLOG_CHANNEL,
    CONFIG_CHATLOG_WHISPER,
    CONFIG_CHATLOG_SYSCHAN,
    CONFIG_CHATLOG_PARTY,
    CONFIG_CHATLOG_RAID,
    CONFIG_CHATLOG_GUILD,
    CONFIG_CHATLOG_PUBLIC,
    CONFIG_CHATLOG_ADDON,
    CONFIG_CHATLOG_BGROUND,
    CONFIG_AUTOBROADCAST,
    CONFIG_ALLOW_TICKETS,
    CONFIG_DELETE_CHARACTER_TICKET_TRACE,
    CONFIG_PRESERVE_CUSTOM_CHANNELS,
    CONFIG_WINTERGRASP_ENABLE,
    CONFIG_PDUMP_NO_PATHS,
    CONFIG_PDUMP_NO_OVERWRITE,
    CONFIG_ENABLE_MMAPS, // pussywizard
    CONFIG_ENABLE_LOGIN_AFTER_DC, // pussywizard
    CONFIG_DONT_CACHE_RANDOM_MOVEMENT_PATHS, // pussywizard
    CONFIG_QUEST_IGNORE_AUTO_ACCEPT,
    CONFIG_QUEST_IGNORE_AUTO_COMPLETE,
    CONFIG_QUEST_ENABLE_QUEST_TRACKER,
    CONFIG_WARDEN_ENABLED,
    CONFIG_ENABLE_CONTINENT_TRANSPORT,
    CONFIG_ENABLE_CONTINENT_TRANSPORT_PRELOADING,
    CONFIG_MINIGOB_MANABONK,
    CONFIG_IP_BASED_ACTION_LOGGING,
    CONFIG_CALCULATE_CREATURE_ZONE_AREA_DATA,
    CONFIG_CALCULATE_GAMEOBJECT_ZONE_AREA_DATA,
    CONFIG_CHECK_GOBJECT_LOS,
    CONFIG_CLOSE_IDLE_CONNECTIONS,
    CONFIG_LFG_LOCATION_ALL, // Player can join LFG anywhere
    CONFIG_PRELOAD_ALL_NON_INSTANCED_MAP_GRIDS,
    CONFIG_ALLOW_TWO_SIDE_INTERACTION_EMOTE,
    CONFIG_ITEMDELETE_METHOD,
    CONFIG_ITEMDELETE_VENDOR,
    CONFIG_SET_ALL_CREATURES_WITH_WAYPOINT_MOVEMENT_ACTIVE,
    CONFIG_DEBUG_BATTLEGROUND,
    CONFIG_DEBUG_ARENA,
    BOOL_CONFIG_VALUE_COUNT
};

enum WorldFloatConfigs
{
    CONFIG_GROUP_XP_DISTANCE = 0,
    CONFIG_MAX_RECRUIT_A_FRIEND_DISTANCE,
    CONFIG_SIGHT_MONSTER,
    CONFIG_LISTEN_RANGE_SAY,
    CONFIG_LISTEN_RANGE_TEXTEMOTE,
    CONFIG_LISTEN_RANGE_YELL,
    CONFIG_CREATURE_FAMILY_FLEE_ASSISTANCE_RADIUS,
    CONFIG_CREATURE_FAMILY_ASSISTANCE_RADIUS,
    CONFIG_CHANCE_OF_GM_SURVEY,
    CONFIG_ARENA_WIN_RATING_MODIFIER_1,
    CONFIG_ARENA_WIN_RATING_MODIFIER_2,
    CONFIG_ARENA_LOSE_RATING_MODIFIER,
    CONFIG_ARENA_MATCHMAKER_RATING_MODIFIER,
    FLOAT_CONFIG_VALUE_COUNT
};

enum WorldIntConfigs
{
    CONFIG_COMPRESSION = 0,
    CONFIG_INTERVAL_MAPUPDATE,
    CONFIG_INTERVAL_CHANGEWEATHER,
    CONFIG_INTERVAL_DISCONNECT_TOLERANCE,
    CONFIG_INTERVAL_SAVE,
    CONFIG_PORT_WORLD,
    CONFIG_SOCKET_TIMEOUTTIME,
    CONFIG_SESSION_ADD_DELAY,
    CONFIG_GAME_TYPE,
    CONFIG_REALM_ZONE,
    CONFIG_STRICT_PLAYER_NAMES,
    CONFIG_STRICT_CHARTER_NAMES,
    CONFIG_STRICT_CHANNEL_NAMES,
    CONFIG_STRICT_PET_NAMES,
    CONFIG_MIN_PLAYER_NAME,
    CONFIG_MIN_CHARTER_NAME,
    CONFIG_MIN_PET_NAME,
    CONFIG_CHARACTER_CREATING_DISABLED,
    CONFIG_CHARACTER_CREATING_DISABLED_RACEMASK,
    CONFIG_CHARACTER_CREATING_DISABLED_CLASSMASK,
    CONFIG_CHARACTERS_PER_ACCOUNT,
    CONFIG_CHARACTERS_PER_REALM,
    CONFIG_HEROIC_CHARACTERS_PER_REALM,
    CONFIG_CHARACTER_CREATING_MIN_LEVEL_FOR_HEROIC_CHARACTER,
    CONFIG_SKIP_CINEMATICS,
    CONFIG_MAX_PLAYER_LEVEL,
    CONFIG_MIN_DUALSPEC_LEVEL,
    CONFIG_START_PLAYER_LEVEL,
    CONFIG_START_HEROIC_PLAYER_LEVEL,
    CONFIG_START_PLAYER_MONEY,
    CONFIG_MAX_HONOR_POINTS,
    CONFIG_START_HONOR_POINTS,
    CONFIG_MAX_ARENA_POINTS,
    CONFIG_START_ARENA_POINTS,
    CONFIG_MAX_RECRUIT_A_FRIEND_BONUS_PLAYER_LEVEL,
    CONFIG_MAX_RECRUIT_A_FRIEND_BONUS_PLAYER_LEVEL_DIFFERENCE,
    CONFIG_INSTANCE_RESET_TIME_HOUR,
    CONFIG_INSTANCE_RESET_TIME_RELATIVE_TIMESTAMP,
    CONFIG_INSTANCE_UNLOAD_DELAY,
    CONFIG_MAX_PRIMARY_TRADE_SKILL,
    CONFIG_MIN_PETITION_SIGNS,
    CONFIG_GM_LOGIN_STATE,
    CONFIG_GM_VISIBLE_STATE,
    CONFIG_GM_ACCEPT_TICKETS,
    CONFIG_GM_CHAT,
    CONFIG_GM_WHISPERING_TO,
    CONFIG_GM_LEVEL_IN_GM_LIST,
    CONFIG_GM_LEVEL_IN_WHO_LIST,
    CONFIG_START_GM_LEVEL,
    CONFIG_GROUP_VISIBILITY,
    CONFIG_MAIL_DELIVERY_DELAY,
    CONFIG_UPTIME_UPDATE,
    CONFIG_SKILL_CHANCE_ORANGE,
    CONFIG_SKILL_CHANCE_YELLOW,
    CONFIG_SKILL_CHANCE_GREEN,
    CONFIG_SKILL_CHANCE_GREY,
    CONFIG_SKILL_CHANCE_MINING_STEPS,
    CONFIG_SKILL_CHANCE_SKINNING_STEPS,
    CONFIG_SKILL_GAIN_CRAFTING,
    CONFIG_SKILL_GAIN_DEFENSE,
    CONFIG_SKILL_GAIN_GATHERING,
    CONFIG_SKILL_GAIN_WEAPON,
    CONFIG_MAX_OVERSPEED_PINGS,
    CONFIG_EXPANSION,
    CONFIG_CHATFLOOD_MESSAGE_COUNT,
    CONFIG_CHATFLOOD_MESSAGE_DELAY,
    CONFIG_CHATFLOOD_MUTE_TIME,
    CONFIG_EVENT_ANNOUNCE,
    CONFIG_CREATURE_FAMILY_ASSISTANCE_DELAY,
    CONFIG_CREATURE_FAMILY_FLEE_DELAY,
    CONFIG_WORLD_BOSS_LEVEL_DIFF,
    CONFIG_QUEST_LOW_LEVEL_HIDE_DIFF,
    CONFIG_QUEST_HIGH_LEVEL_HIDE_DIFF,
    CONFIG_CHAT_STRICT_LINK_CHECKING_SEVERITY,
    CONFIG_CHAT_STRICT_LINK_CHECKING_KICK,
    CONFIG_CHAT_CHANNEL_LEVEL_REQ,
    CONFIG_CHAT_WHISPER_LEVEL_REQ,
    CONFIG_CHAT_SAY_LEVEL_REQ,
    CONFIG_PARTY_LEVEL_REQ,
    CONFIG_CHAT_TIME_MUTE_FIRST_LOGIN,
    CONFIG_TRADE_LEVEL_REQ,
    CONFIG_TICKET_LEVEL_REQ,
    CONFIG_AUCTION_LEVEL_REQ,
    CONFIG_MAIL_LEVEL_REQ,
    CONFIG_CORPSE_DECAY_NORMAL,
    CONFIG_CORPSE_DECAY_RARE,
    CONFIG_CORPSE_DECAY_ELITE,
    CONFIG_CORPSE_DECAY_RAREELITE,
    CONFIG_CORPSE_DECAY_WORLDBOSS,
    CONFIG_DEATH_SICKNESS_LEVEL,
    CONFIG_INSTANT_LOGOUT,
    CONFIG_DISABLE_BREATHING,
    CONFIG_BATTLEGROUND_PREMATURE_FINISH_TIMER,
    CONFIG_BATTLEGROUND_PREMADE_GROUP_WAIT_FOR_MATCH,
    CONFIG_BATTLEGROUND_REPORT_AFK_TIMER,
    CONFIG_BATTLEGROUND_REPORT_AFK,
    CONFIG_BATTLEGROUND_INVITATION_TYPE,
    CONFIG_BATTLEGROUND_PLAYER_RESPAWN,
    CONFIG_BATTLEGROUND_BUFF_RESPAWN,
    CONFIG_ARENA_MAX_RATING_DIFFERENCE,
    CONFIG_ARENA_RATING_DISCARD_TIMER,
    CONFIG_ARENA_AUTO_DISTRIBUTE_INTERVAL_DAYS,
    CONFIG_ARENA_SEASON_ID,
    CONFIG_ARENA_START_RATING,
    CONFIG_ARENA_START_PERSONAL_RATING,
    CONFIG_ARENA_START_MATCHMAKER_RATING,
    CONFIG_HONOR_AFTER_DUEL,
    CONFIG_PVP_TOKEN_MAP_TYPE,
    CONFIG_PVP_TOKEN_ID,
    CONFIG_PVP_TOKEN_COUNT,
    CONFIG_INTERVAL_LOG_UPDATE,
    CONFIG_MIN_LOG_UPDATE,
    CONFIG_ENABLE_SINFO_LOGIN,
    CONFIG_PLAYER_ALLOW_COMMANDS,
    CONFIG_NUMTHREADS,
    CONFIG_LOGDB_CLEARINTERVAL,
    CONFIG_LOGDB_CLEARTIME,
    CONFIG_TELEPORT_TIMEOUT_NEAR, // pussywizard
    CONFIG_TELEPORT_TIMEOUT_FAR, // pussywizard
    CONFIG_MAX_ALLOWED_MMR_DROP, // pussywizard
    CONFIG_CLIENTCACHE_VERSION,
    CONFIG_GUILD_EVENT_LOG_COUNT,
    CONFIG_GUILD_BANK_EVENT_LOG_COUNT,
    CONFIG_MIN_LEVEL_STAT_SAVE,
    CONFIG_RANDOM_BG_RESET_HOUR,
    CONFIG_CALENDAR_DELETE_OLD_EVENTS_HOUR,
    CONFIG_GUILD_RESET_HOUR,
    CONFIG_CHARDELETE_KEEP_DAYS,
    CONFIG_CHARDELETE_METHOD,
    CONFIG_CHARDELETE_MIN_LEVEL,
    CONFIG_AUTOBROADCAST_CENTER,
    CONFIG_AUTOBROADCAST_INTERVAL,
    CONFIG_MAX_RESULTS_LOOKUP_COMMANDS,
    CONFIG_DB_PING_INTERVAL,
    CONFIG_PRESERVE_CUSTOM_CHANNEL_DURATION,
    CONFIG_PERSISTENT_CHARACTER_CLEAN_FLAGS,
    CONFIG_LFG_OPTIONSMASK,
    CONFIG_MAX_INSTANCES_PER_HOUR,
    CONFIG_WINTERGRASP_PLR_MAX,
    CONFIG_WINTERGRASP_PLR_MIN,
    CONFIG_WINTERGRASP_PLR_MIN_LVL,
    CONFIG_WINTERGRASP_BATTLETIME,
    CONFIG_WINTERGRASP_NOBATTLETIME,
    CONFIG_WINTERGRASP_RESTART_AFTER_CRASH,
    CONFIG_PACKET_SPOOF_POLICY,
    CONFIG_PACKET_SPOOF_BANMODE,
    CONFIG_PACKET_SPOOF_BANDURATION,
    CONFIG_WARDEN_CLIENT_RESPONSE_DELAY,
    CONFIG_WARDEN_CLIENT_CHECK_HOLDOFF,
    CONFIG_WARDEN_CLIENT_FAIL_ACTION,
    CONFIG_WARDEN_CLIENT_BAN_DURATION,
    CONFIG_WARDEN_NUM_MEM_CHECKS,
    CONFIG_WARDEN_NUM_OTHER_CHECKS,
    CONFIG_BIRTHDAY_TIME,
    CONFIG_SOCKET_TIMEOUTTIME_ACTIVE,
    CONFIG_INSTANT_TAXI,
    CONFIG_AFK_PREVENT_LOGOUT,
    CONFIG_ICC_BUFF_HORDE,
    CONFIG_ICC_BUFF_ALLIANCE,
    CONFIG_ITEMDELETE_QUALITY,
    CONFIG_ITEMDELETE_ITEM_LEVEL,
    CONFIG_BG_REWARD_WINNER_HONOR_FIRST,
    CONFIG_BG_REWARD_WINNER_ARENA_FIRST,
    CONFIG_BG_REWARD_WINNER_HONOR_LAST,
    CONFIG_BG_REWARD_WINNER_ARENA_LAST,
    CONFIG_BG_REWARD_LOSER_HONOR_FIRST,
    CONFIG_BG_REWARD_LOSER_HONOR_LAST,
    CONFIG_CHARTER_COST_GUILD,
    CONFIG_CHARTER_COST_ARENA_2v2,
    CONFIG_CHARTER_COST_ARENA_3v3,
    CONFIG_CHARTER_COST_ARENA_5v5,
    CONFIG_MAX_WHO_LIST_RETURN,
    CONFIG_WAYPOINT_MOVEMENT_STOP_TIME_FOR_PLAYER,
    INT_CONFIG_VALUE_COUNT
};

/// Server rates
enum Rates
{
    RATE_HEALTH = 0,
    RATE_POWER_MANA,
    RATE_POWER_RAGE_INCOME,
    RATE_POWER_RAGE_LOSS,
    RATE_POWER_RUNICPOWER_INCOME,
    RATE_POWER_RUNICPOWER_LOSS,
    RATE_POWER_FOCUS,
    RATE_POWER_ENERGY,
    RATE_SKILL_DISCOVERY,
    RATE_DROP_ITEM_POOR,
    RATE_DROP_ITEM_NORMAL,
    RATE_DROP_ITEM_UNCOMMON,
    RATE_DROP_ITEM_RARE,
    RATE_DROP_ITEM_EPIC,
    RATE_DROP_ITEM_LEGENDARY,
    RATE_DROP_ITEM_ARTIFACT,
    RATE_DROP_ITEM_REFERENCED,

    RATE_DROP_ITEM_REFERENCED_AMOUNT,
    RATE_SELLVALUE_ITEM_POOR,
    RATE_SELLVALUE_ITEM_NORMAL,
    RATE_SELLVALUE_ITEM_UNCOMMON,
    RATE_SELLVALUE_ITEM_RARE,
    RATE_SELLVALUE_ITEM_EPIC,
    RATE_SELLVALUE_ITEM_LEGENDARY,
    RATE_SELLVALUE_ITEM_ARTIFACT,
    RATE_SELLVALUE_ITEM_HEIRLOOM,
    RATE_BUYVALUE_ITEM_POOR,
    RATE_BUYVALUE_ITEM_NORMAL,
    RATE_BUYVALUE_ITEM_UNCOMMON,
    RATE_BUYVALUE_ITEM_RARE,
    RATE_BUYVALUE_ITEM_EPIC,
    RATE_BUYVALUE_ITEM_LEGENDARY,
    RATE_BUYVALUE_ITEM_ARTIFACT,
    RATE_BUYVALUE_ITEM_HEIRLOOM,
    RATE_DROP_MONEY,
    RATE_XP_KILL,
    RATE_XP_BG_KILL,
    RATE_XP_QUEST,
    RATE_XP_EXPLORE,
    RATE_REPAIRCOST,
    RATE_REPUTATION_GAIN,
    RATE_REPUTATION_LOWLEVEL_KILL,
    RATE_REPUTATION_LOWLEVEL_QUEST,
    RATE_REPUTATION_RECRUIT_A_FRIEND_BONUS,
    RATE_CREATURE_NORMAL_HP,
    RATE_CREATURE_ELITE_ELITE_HP,
    RATE_CREATURE_ELITE_RAREELITE_HP,
    RATE_CREATURE_ELITE_WORLDBOSS_HP,
    RATE_CREATURE_ELITE_RARE_HP,
    RATE_CREATURE_NORMAL_DAMAGE,
    RATE_CREATURE_ELITE_ELITE_DAMAGE,
    RATE_CREATURE_ELITE_RAREELITE_DAMAGE,
    RATE_CREATURE_ELITE_WORLDBOSS_DAMAGE,
    RATE_CREATURE_ELITE_RARE_DAMAGE,
    RATE_CREATURE_NORMAL_SPELLDAMAGE,
    RATE_CREATURE_ELITE_ELITE_SPELLDAMAGE,
    RATE_CREATURE_ELITE_RAREELITE_SPELLDAMAGE,
    RATE_CREATURE_ELITE_WORLDBOSS_SPELLDAMAGE,
    RATE_CREATURE_ELITE_RARE_SPELLDAMAGE,
    RATE_CREATURE_AGGRO,
    RATE_REST_INGAME,
    RATE_REST_OFFLINE_IN_TAVERN_OR_CITY,
    RATE_REST_OFFLINE_IN_WILDERNESS,
    RATE_DAMAGE_FALL,
    RATE_AUCTION_TIME,
    RATE_AUCTION_DEPOSIT,
    RATE_AUCTION_CUT,
    RATE_HONOR,
    RATE_ARENA_POINTS,
    RATE_TALENT,
    RATE_CORPSE_DECAY_LOOTED,
    RATE_INSTANCE_RESET_TIME,
    RATE_TARGET_POS_RECALCULATION_RANGE,
    RATE_DURABILITY_LOSS_ON_DEATH,
    RATE_DURABILITY_LOSS_DAMAGE,
    RATE_DURABILITY_LOSS_PARRY,
    RATE_DURABILITY_LOSS_ABSORB,
    RATE_DURABILITY_LOSS_BLOCK,
    RATE_MOVESPEED,
    MAX_RATES
};

/// Can be used in SMSG_AUTH_RESPONSE packet
enum BillingPlanFlags
{
    SESSION_NONE            = 0x00,
    SESSION_UNUSED          = 0x01,
    SESSION_RECURRING_BILL  = 0x02,
    SESSION_FREE_TRIAL      = 0x04,
    SESSION_IGR             = 0x08,
    SESSION_USAGE           = 0x10,
    SESSION_TIME_MIXTURE    = 0x20,
    SESSION_RESTRICTED      = 0x40,
    SESSION_ENABLE_CAIS     = 0x80,
};

/// Type of server, this is values from second column of Cfg_Configs.dbc
enum RealmType
{
    REALM_TYPE_NORMAL = 0,
    REALM_TYPE_PVP = 1,
    REALM_TYPE_NORMAL2 = 4,
    REALM_TYPE_RP = 6,
    REALM_TYPE_RPPVP = 8,
    REALM_TYPE_FFA_PVP = 16                                 // custom, free for all pvp mode like arena PvP in all zones except rest activated places and sanctuaries
                         // replaced by REALM_PVP in realm list
};

enum RealmZone
{
    REALM_ZONE_UNKNOWN       = 0,                           // any language
    REALM_ZONE_DEVELOPMENT   = 1,                           // any language
    REALM_ZONE_UNITED_STATES = 2,                           // extended-Latin
    REALM_ZONE_OCEANIC       = 3,                           // extended-Latin
    REALM_ZONE_LATIN_AMERICA = 4,                           // extended-Latin
    REALM_ZONE_TOURNAMENT_5  = 5,                           // basic-Latin at create, any at login
    REALM_ZONE_KOREA         = 6,                           // East-Asian
    REALM_ZONE_TOURNAMENT_7  = 7,                           // basic-Latin at create, any at login
    REALM_ZONE_ENGLISH       = 8,                           // extended-Latin
    REALM_ZONE_GERMAN        = 9,                           // extended-Latin
    REALM_ZONE_FRENCH        = 10,                          // extended-Latin
    REALM_ZONE_SPANISH       = 11,                          // extended-Latin
    REALM_ZONE_RUSSIAN       = 12,                          // Cyrillic
    REALM_ZONE_TOURNAMENT_13 = 13,                          // basic-Latin at create, any at login
    REALM_ZONE_TAIWAN        = 14,                          // East-Asian
    REALM_ZONE_TOURNAMENT_15 = 15,                          // basic-Latin at create, any at login
    REALM_ZONE_CHINA         = 16,                          // East-Asian
    REALM_ZONE_CN1           = 17,                          // basic-Latin at create, any at login
    REALM_ZONE_CN2           = 18,                          // basic-Latin at create, any at login
    REALM_ZONE_CN3           = 19,                          // basic-Latin at create, any at login
    REALM_ZONE_CN4           = 20,                          // basic-Latin at create, any at login
    REALM_ZONE_CN5           = 21,                          // basic-Latin at create, any at login
    REALM_ZONE_CN6           = 22,                          // basic-Latin at create, any at login
    REALM_ZONE_CN7           = 23,                          // basic-Latin at create, any at login
    REALM_ZONE_CN8           = 24,                          // basic-Latin at create, any at login
    REALM_ZONE_TOURNAMENT_25 = 25,                          // basic-Latin at create, any at login
    REALM_ZONE_TEST_SERVER   = 26,                          // any language
    REALM_ZONE_TOURNAMENT_27 = 27,                          // basic-Latin at create, any at login
    REALM_ZONE_QA_SERVER     = 28,                          // any language
    REALM_ZONE_CN9           = 29,                          // basic-Latin at create, any at login
    REALM_ZONE_TEST_SERVER_2 = 30,                          // any language
    REALM_ZONE_CN10          = 31,                          // basic-Latin at create, any at login
    REALM_ZONE_CTC           = 32,
    REALM_ZONE_CNC           = 33,
    REALM_ZONE_CN1_4         = 34,                          // basic-Latin at create, any at login
    REALM_ZONE_CN2_6_9       = 35,                          // basic-Latin at create, any at login
    REALM_ZONE_CN3_7         = 36,                          // basic-Latin at create, any at login
    REALM_ZONE_CN5_8         = 37                           // basic-Latin at create, any at login
};

enum WorldStates
{
    WS_ARENA_DISTRIBUTION_TIME                 = 20001,                     // Next arena distribution time
    WS_WEEKLY_QUEST_RESET_TIME                 = 20002,                     // Next weekly reset time
    WS_BG_DAILY_RESET_TIME                     = 20003,                     // Next daily BG reset time
    WS_CLEANING_FLAGS                          = 20004,                     // Cleaning Flags
    WS_DAILY_QUEST_RESET_TIME                  = 20005,                     // Next daily reset time
    WS_GUILD_DAILY_RESET_TIME                  = 20006,                     // Next guild cap reset time
    WS_MONTHLY_QUEST_RESET_TIME                = 20007,                     // Next monthly reset time
    WS_DAILY_CALENDAR_DELETION_OLD_EVENTS_TIME = 20008                      // Next daily calendar deletions of old events time
};

/// Storage class for commands issued for delayed execution
struct CliCommandHolder
{
    typedef void Print(void*, const char*);
    typedef void CommandFinished(void*, bool success);

    void* m_callbackArg;
    char* m_command;
    Print* m_print;

    CommandFinished* m_commandFinished;

    CliCommandHolder(void* callbackArg, const char* command, Print* zprint, CommandFinished* commandFinished)
        : m_callbackArg(callbackArg), m_print(zprint), m_commandFinished(commandFinished)
    {
        size_t len = strlen(command) + 1;
        m_command = new char[len];
        memcpy(m_command, command, len);
    }

    ~CliCommandHolder() { delete[] m_command; }
};

typedef std::unordered_map<uint32, WorldSession*> SessionMap;

#define WORLD_SLEEP_CONST 10

// xinef: global storage
struct GlobalPlayerData
{
    uint32 guidLow;
    uint32 accountId;
    std::string name;
    uint8 race;
    uint8 playerClass;
    uint8 gender;
    uint8 level;
    uint16 mailCount;
    uint32 guildId;
    uint32 groupId;
    uint32 arenaTeamId[3];
};

enum GlobalPlayerUpdateMask
{
    PLAYER_UPDATE_DATA_LEVEL            = 0x01,
    PLAYER_UPDATE_DATA_RACE             = 0x02,
    PLAYER_UPDATE_DATA_CLASS            = 0x04,
    PLAYER_UPDATE_DATA_GENDER           = 0x08,
    PLAYER_UPDATE_DATA_NAME             = 0x10,
};

typedef std::map<uint32, GlobalPlayerData> GlobalPlayerDataMap;
typedef std::map<std::string, uint32> GlobalPlayerNameMap;

// xinef: petitions storage
struct PetitionData
{
};

/// The World
class World
{
public:
    World();
    ~World();

    static World* instance();

    static uint32 m_worldLoopCounter;

    WorldSession* FindSession(uint32 id) const;
    WorldSession* FindOfflineSession(uint32 id) const;
    WorldSession* FindOfflineSessionForCharacterGUID(uint32 guidLow) const;
    void AddSession(WorldSession* s);
    void SendAutoBroadcast();
    bool KickSession(uint32 id);
    /// Get the number of current active sessions
    void UpdateMaxSessionCounters();
    const SessionMap& GetAllSessions() const { return m_sessions; }
    uint32 GetActiveAndQueuedSessionCount() const { return m_sessions.size(); }
    uint32 GetActiveSessionCount() const { return m_sessions.size() - m_QueuedPlayer.size(); }
    uint32 GetQueuedSessionCount() const { return m_QueuedPlayer.size(); }
    /// Get the maximum number of parallel sessions on the server since last reboot
    uint32 GetMaxQueuedSessionCount() const { return m_maxQueuedSessionCount; }
    uint32 GetMaxActiveSessionCount() const { return m_maxActiveSessionCount; }
    /// Get number of players
    inline uint32 GetPlayerCount() const { return m_PlayerCount; }
    inline uint32 GetMaxPlayerCount() const { return m_MaxPlayerCount; }

    /// Increase/Decrease number of players
    inline void IncreasePlayerCount()
    {
        m_PlayerCount++;
        m_MaxPlayerCount = std::max(m_MaxPlayerCount, m_PlayerCount);
    }
    inline void DecreasePlayerCount() { m_PlayerCount--; }

    Player* FindPlayerInZone(uint32 zone);

    /// Deny clients?
    bool IsClosed() const;

    /// Close world
    void SetClosed(bool val);

    /// Security level limitations
    AccountTypes GetPlayerSecurityLimit() const { return m_allowedSecurityLevel; }
    void SetPlayerSecurityLimit(AccountTypes sec);
    void LoadDBAllowedSecurityLevel();

    /// Active session server limit
    void SetPlayerAmountLimit(uint32 limit) { m_playerLimit = limit; }
    uint32 GetPlayerAmountLimit() const { return m_playerLimit; }

    //player Queue
    typedef std::list<WorldSession*> Queue;
    void AddQueuedPlayer(WorldSession*);
    bool RemoveQueuedPlayer(WorldSession* session);
    int32 GetQueuePos(WorldSession*);
    bool HasRecentlyDisconnected(WorldSession*);

    /// \todo Actions on m_allowMovement still to be implemented
    /// Is movement allowed?
    bool getAllowMovement() const { return m_allowMovement; }
    /// Allow/Disallow object movements
    void SetAllowMovement(bool allow) { m_allowMovement = allow; }

    /// Set the string for new characters (first login)
    void SetNewCharString(std::string const& str) { m_newCharString = str; }
    /// Get the string for new characters (first login)
    std::string const& GetNewCharString() const { return m_newCharString; }

    LocaleConstant GetDefaultDbcLocale() const { return m_defaultDbcLocale; }

    /// Get the path where data (dbc, maps) are stored on disk
    std::string const& GetDataPath() const { return m_dataPath; }

    /// When server started?
    time_t const& GetStartTime() const { return m_startTime; }
    /// What time is it?
    time_t const& GetGameTime() const { return m_gameTime; }
    /// What time is it? in ms
    static uint32 GetGameTimeMS() { return m_gameMSTime; }
    /// Uptime (in secs)
    uint32 GetUptime() const { return uint32(m_gameTime - m_startTime); }
    /// Update time
    uint32 GetUpdateTime() const { return m_updateTime; }
    void SetRecordDiffInterval(int32 t) { if (t >= 0) m_int_configs[CONFIG_INTERVAL_LOG_UPDATE] = (uint32)t; }

    /// Next daily quests and random bg reset time
    time_t GetNextDailyQuestsResetTime() const { return m_NextDailyQuestReset; }
    time_t GetNextWeeklyQuestsResetTime() const { return m_NextWeeklyQuestReset; }
    time_t GetNextRandomBGResetTime() const { return m_NextRandomBGReset; }

    /// Get the maximum skill level a player can reach
    uint16 GetConfigMaxSkillValue() const
    {
        uint16 lvl = uint16(getIntConfig(CONFIG_MAX_PLAYER_LEVEL));
        return lvl > 60 ? 300 + ((lvl - 60) * 75) / 10 : lvl * 5;
    }

    void SetInitialWorldSettings();
    void LoadConfigSettings(bool reload = false);

    void SendWorldText(uint32 string_id, ...);
    void SendGlobalText(const char* text, WorldSession* self);
    void SendGMText(uint32 string_id, ...);
    void SendGlobalMessage(WorldPacket* packet, WorldSession* self = 0, TeamId teamId = TEAM_NEUTRAL);
    void SendGlobalGMMessage(WorldPacket* packet, WorldSession* self = 0, TeamId teamId = TEAM_NEUTRAL);
    bool SendZoneMessage(uint32 zone, WorldPacket* packet, WorldSession* self = 0, TeamId teamId = TEAM_NEUTRAL);
    void SendZoneText(uint32 zone, const char* text, WorldSession* self = 0, TeamId teamId = TEAM_NEUTRAL);
    void SendServerMessage(ServerMessageType type, const char* text = "", Player* player = nullptr);

    /// Are we in the middle of a shutdown?
    bool IsShuttingDown() const { return m_ShutdownTimer > 0; }
    uint32 GetShutDownTimeLeft() const { return m_ShutdownTimer; }
    void ShutdownServ(uint32 time, uint32 options, uint8 exitcode);
    void ShutdownCancel();
    void ShutdownMsg(bool show = false, Player* player = nullptr);
    static uint8 GetExitCode() { return m_ExitCode; }
    static void StopNow(uint8 exitcode) { m_stopEvent = true; m_ExitCode = exitcode; }
    static bool IsStopped() { return m_stopEvent; }

    void Update(uint32 diff);

    void UpdateSessions(uint32 diff);
    /// Set a server rate (see #Rates)
    void setRate(Rates rate, float value) { rate_values[rate] = value; }
    /// Get a server rate (see #Rates)
    float getRate(Rates rate) const { return rate_values[rate]; }

    /// Set a server configuration element (see #WorldConfigs)
    void setBoolConfig(WorldBoolConfigs index, bool value)
    {
        if (index < BOOL_CONFIG_VALUE_COUNT)
            m_bool_configs[index] = value;
    }

    /// Get a server configuration element (see #WorldConfigs)
    bool getBoolConfig(WorldBoolConfigs index) const
    {
        return index < BOOL_CONFIG_VALUE_COUNT ? m_bool_configs[index] : 0;
    }

    /// Set a server configuration element (see #WorldConfigs)
    void setFloatConfig(WorldFloatConfigs index, float value)
    {
        if (index < FLOAT_CONFIG_VALUE_COUNT)
            m_float_configs[index] = value;
    }

    /// Get a server configuration element (see #WorldConfigs)
    float getFloatConfig(WorldFloatConfigs index) const
    {
        return index < FLOAT_CONFIG_VALUE_COUNT ? m_float_configs[index] : 0;
    }

    /// Set a server configuration element (see #WorldConfigs)
    void setIntConfig(WorldIntConfigs index, uint32 value)
    {
        if (index < INT_CONFIG_VALUE_COUNT)
            m_int_configs[index] = value;
    }

    /// Get a server configuration element (see #WorldConfigs)
    uint32 getIntConfig(WorldIntConfigs index) const
    {
        return index < INT_CONFIG_VALUE_COUNT ? m_int_configs[index] : 0;
    }

    void setWorldState(uint32 index, uint64 value);
    uint64 getWorldState(uint32 index) const;
    void LoadWorldStates();

    /// Are we on a "Player versus Player" server?
    bool IsPvPRealm() const { return (getIntConfig(CONFIG_GAME_TYPE) == REALM_TYPE_PVP || getIntConfig(CONFIG_GAME_TYPE) == REALM_TYPE_RPPVP || getIntConfig(CONFIG_GAME_TYPE) == REALM_TYPE_FFA_PVP); }
    bool IsFFAPvPRealm() const { return getIntConfig(CONFIG_GAME_TYPE) == REALM_TYPE_FFA_PVP; }

    void KickAll();
    void KickAllLess(AccountTypes sec);

    // for max speed access
    static float GetMaxVisibleDistanceOnContinents()    { return m_MaxVisibleDistanceOnContinents; }
    static float GetMaxVisibleDistanceInInstances()     { return m_MaxVisibleDistanceInInstances;  }
    static float GetMaxVisibleDistanceInBGArenas()      { return m_MaxVisibleDistanceInBGArenas;   }

    // our: needed for arena spectator subscriptions
    uint32 GetNextWhoListUpdateDelaySecs()
    {
        if (m_timers[WUPDATE_5_SECS].Passed())
            return 1;
        uint32 t = m_timers[WUPDATE_5_SECS].GetInterval() - m_timers[WUPDATE_5_SECS].GetCurrent();
        t = std::min(t, (uint32)m_timers[WUPDATE_5_SECS].GetInterval());
        return uint32(ceil(t / 1000.0f));
    }

    // xinef: Global Player Data Storage system
    void LoadGlobalPlayerDataStore();
    uint32 GetGlobalPlayerGUID(std::string const& name) const;
    GlobalPlayerData const* GetGlobalPlayerData(uint32 guid) const;
    void AddGlobalPlayerData(uint32 guid, uint32 accountId, std::string const& name, uint8 gender, uint8 race, uint8 playerClass, uint8 level, uint16 mailCount, uint32 guildId);
    void UpdateGlobalPlayerData(uint32 guid, uint8 mask, std::string const& name, uint8 level = 0, uint8 gender = 0, uint8 race = 0, uint8 playerClass = 0);
    void UpdateGlobalPlayerMails(uint32 guid, int16 count, bool add = true);
    void UpdateGlobalPlayerGuild(uint32 guid, uint32 guildId);
    void UpdateGlobalPlayerGroup(uint32 guid, uint32 groupId);
    void UpdateGlobalPlayerArenaTeam(uint32 guid, uint8 slot, uint32 arenaTeamId);
    void UpdateGlobalNameData(uint32 guidLow, std::string const& oldName, std::string const& newName);
    void DeleteGlobalPlayerData(uint32 guid, std::string const& name);

    void ProcessCliCommands();
    void QueueCliCommand(CliCommandHolder* commandHolder) { cliCmdQueue.add(commandHolder); }

    void ForceGameEventUpdate();

    void UpdateRealmCharCount(uint32 accid);

    LocaleConstant GetAvailableDbcLocale(LocaleConstant locale) const { if (m_availableDbcLocaleMask & (1 << locale)) return locale; else return m_defaultDbcLocale; }

    // used World DB version
    void LoadDBVersion();
    char const* GetDBVersion() const { return m_DBVersion.c_str(); }

    void LoadAutobroadcasts();

    void UpdateAreaDependentAuras();

    uint32 GetCleaningFlags() const { return m_CleaningFlags; }
    void   SetCleaningFlags(uint32 flags) { m_CleaningFlags = flags; }
    void   ResetEventSeasonalQuests(uint16 event_id);

    time_t GetNextTimeWithDayAndHour(int8 dayOfWeek, int8 hour); // pussywizard
    time_t GetNextTimeWithMonthAndHour(int8 month, int8 hour); // pussywizard

    std::string const& GetRealmName() const { return _realmName; } // pussywizard
    void SetRealmName(std::string name) { _realmName = name; } // pussywizard

protected:
    void _UpdateGameTime();
    // callback for UpdateRealmCharacters
    void _UpdateRealmCharCount(PreparedQueryResult resultCharCount);

    void InitDailyQuestResetTime();
    void InitWeeklyQuestResetTime();
    void InitMonthlyQuestResetTime();
    void InitRandomBGResetTime();
    void InitCalendarOldEventsDeletionTime();
    void InitGuildResetTime();
    void ResetDailyQuests();
    void ResetWeeklyQuests();
    void ResetMonthlyQuests();
    void ResetRandomBG();
    void CalendarDeleteOldEvents();
    void ResetGuildCap();
private:
    static std::atomic_long m_stopEvent;
    static uint8 m_ExitCode;
    uint32 m_ShutdownTimer;
    uint32 m_ShutdownMask;

    uint32 m_CleaningFlags;

    bool m_isClosed;

    time_t m_startTime;
    time_t m_gameTime;
    IntervalTimer m_timers[WUPDATE_COUNT];
    time_t mail_expire_check_timer;
    uint32 m_updateTime, m_updateTimeSum;
    static uint32 m_gameMSTime;

    SessionMap m_sessions;
    SessionMap m_offlineSessions;
    typedef std::unordered_map<uint32, time_t> DisconnectMap;
    DisconnectMap m_disconnects;
    uint32 m_maxActiveSessionCount;
    uint32 m_maxQueuedSessionCount;
    uint32 m_PlayerCount;
    uint32 m_MaxPlayerCount;

    std::string m_newCharString;

    float rate_values[MAX_RATES];
    uint32 m_int_configs[INT_CONFIG_VALUE_COUNT];
    bool m_bool_configs[BOOL_CONFIG_VALUE_COUNT];
    float m_float_configs[FLOAT_CONFIG_VALUE_COUNT];
    typedef std::map<uint32, uint64> WorldStatesMap;
    WorldStatesMap m_worldstates;
    uint32 m_playerLimit;
    AccountTypes m_allowedSecurityLevel;
    LocaleConstant m_defaultDbcLocale;                     // from config for one from loaded DBC locales
    uint32 m_availableDbcLocaleMask;                       // by loaded DBC
    void DetectDBCLang();
    bool m_allowMovement;
    std::string m_dataPath;

    // for max speed access
    static float m_MaxVisibleDistanceOnContinents;
    static float m_MaxVisibleDistanceInInstances;
    static float m_MaxVisibleDistanceInBGArenas;

    // our speed ups
    GlobalPlayerDataMap _globalPlayerDataStore; // xinef
    GlobalPlayerNameMap _globalPlayerNameStore; // xinef

    std::string _realmName;

    // CLI command holder to be thread safe
    ACE_Based::LockedQueue<CliCommandHolder*, ACE_Thread_Mutex> cliCmdQueue;

    // next daily quests and random bg reset time
    time_t m_NextDailyQuestReset;
    time_t m_NextWeeklyQuestReset;
    time_t m_NextMonthlyQuestReset;
    time_t m_NextRandomBGReset;
    time_t m_NextCalendarOldEventsDeletionTime;
    time_t m_NextGuildReset;

    //Player Queue
    Queue m_QueuedPlayer;

    // sessions that are added async
    void AddSession_(WorldSession* s);
    ACE_Based::LockedQueue<WorldSession*, ACE_Thread_Mutex> addSessQueue;

    // used versions
    std::string m_DBVersion;

    typedef std::map<uint8, std::string> AutobroadcastsMap;
    AutobroadcastsMap m_Autobroadcasts;

    typedef std::map<uint8, uint8> AutobroadcastsWeightMap;
    AutobroadcastsWeightMap m_AutobroadcastsWeights;

    void ProcessQueryCallbacks();
    ACE_Future_Set<PreparedQueryResult> m_realmCharCallbacks;
};

#define sWorld World::instance()
#endif
/// @}

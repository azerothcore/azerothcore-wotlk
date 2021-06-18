/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

/** \file
    \ingroup world
*/

#include "AccountMgr.h"
#include "AchievementMgr.h"
#include "AddonMgr.h"
#include "ArenaTeamMgr.h"
#include "AsyncAuctionListing.h"
#include "AuctionHouseMgr.h"
#include "AvgDiffTracker.h"
#include "BattlefieldMgr.h"
#include "BattlegroundMgr.h"
#include "CalendarMgr.h"
#include "Channel.h"
#include "ChannelMgr.h"
#include "CharacterDatabaseCleaner.h"
#include "Chat.h"
#include "Common.h"
#include "ConditionMgr.h"
#include "Config.h"
#include "CreatureAIRegistry.h"
#include "CreatureGroups.h"
#include "CreatureTextMgr.h"
#include "DatabaseEnv.h"
#include "DBCStores.h"
#include "DisableMgr.h"
#include "DynamicVisibility.h"
#include "GameEventMgr.h"
#include "GameGraveyard.h"
#include "GitRevision.h"
#include "GridNotifiersImpl.h"
#include "GroupMgr.h"
#include "GuildMgr.h"
#include "InstanceSaveMgr.h"
#include "ItemEnchantmentMgr.h"
#include "IPLocation.h"
#include "Language.h"
#include "LFGMgr.h"
#include "Log.h"
#include "LootItemStorage.h"
#include "LootMgr.h"
#include "MapManager.h"
#include "MMapFactory.h"
#include "ObjectMgr.h"
#include "Opcodes.h"
#include "OutdoorPvPMgr.h"
#include "PetitionMgr.h"
#include "Player.h"
#include "PoolMgr.h"
#include "Realm.h"
#include "SavingSystem.h"
#include "ScriptMgr.h"
#include "ServerMotd.h"
#include "SkillDiscovery.h"
#include "SkillExtraItems.h"
#include "SmartAI.h"
#include "SpellMgr.h"
#include "TicketMgr.h"
#include "Transport.h"
#include "TransportMgr.h"
#include "Util.h"
#include "Vehicle.h"
#include "VMapFactory.h"
#include "Warden.h"
#include "WardenCheckMgr.h"
#include "WaypointMovementGenerator.h"
#include "WeatherMgr.h"
#include "WhoListCache.h"
#include "World.h"
#include "WorldPacket.h"
#include "WorldSession.h"
#include <VMapManager2.h>

#ifdef ELUNA
#include "LuaEngine.h"
#endif

std::atomic_long World::m_stopEvent = false;
uint8 World::m_ExitCode = SHUTDOWN_EXIT_CODE;
uint32 World::m_worldLoopCounter = 0;
uint32 World::m_gameMSTime = 0;

float World::m_MaxVisibleDistanceOnContinents = DEFAULT_VISIBILITY_DISTANCE;
float World::m_MaxVisibleDistanceInInstances  = DEFAULT_VISIBILITY_INSTANCE;
float World::m_MaxVisibleDistanceInBGArenas   = DEFAULT_VISIBILITY_BGARENAS;

Realm realm;

/// World constructor
World::World()
{
    m_playerLimit = 0;
    m_allowedSecurityLevel = SEC_PLAYER;
    m_allowMovement = true;
    m_ShutdownMask = 0;
    m_ShutdownTimer = 0;
    m_gameTime = time(nullptr);
    m_gameMSTime = getMSTime();
    m_startTime = m_gameTime;
    m_maxActiveSessionCount = 0;
    m_maxQueuedSessionCount = 0;
    m_PlayerCount = 0;
    m_MaxPlayerCount = 0;
    m_NextDailyQuestReset = 0;
    m_NextWeeklyQuestReset = 0;
    m_NextMonthlyQuestReset = 0;
    m_NextRandomBGReset = 0;
    m_NextCalendarOldEventsDeletionTime = 0;
    m_NextGuildReset = 0;

    m_defaultDbcLocale = LOCALE_enUS;

    mail_expire_check_timer = 0;
    m_updateTime = 0;
    m_updateTimeSum = 0;

    m_isClosed = false;

    m_CleaningFlags = 0;

    memset(rate_values, 0, sizeof(rate_values));
    memset(m_int_configs, 0, sizeof(m_int_configs));
    memset(m_bool_configs, 0, sizeof(m_bool_configs));
    memset(m_float_configs, 0, sizeof(m_float_configs));
}

/// World destructor
World::~World()
{
    ///- Empty the kicked session set
    while (!m_sessions.empty())
    {
        // not remove from queue, prevent loading new sessions
        delete m_sessions.begin()->second;
        m_sessions.erase(m_sessions.begin());
    }

    while (!m_offlineSessions.empty())
    {
        delete m_offlineSessions.begin()->second;
        m_offlineSessions.erase(m_offlineSessions.begin());
    }

    CliCommandHolder* command = nullptr;
    while (cliCmdQueue.next(command))
        delete command;

    VMAP::VMapFactory::clear();
    MMAP::MMapFactory::clear();

    //TODO free addSessQueue
}

std::unique_ptr<IWorld>& getWorldInstance()
{
    static std::unique_ptr<IWorld> instance = std::make_unique<World>();
    return instance;
}

/// Find a player in a specified zone
Player* World::FindPlayerInZone(uint32 zone)
{
    ///- circle through active sessions and return the first player found in the zone
    SessionMap::const_iterator itr;
    for (itr = m_sessions.begin(); itr != m_sessions.end(); ++itr)
    {
        if (!itr->second)
            continue;

        Player* player = itr->second->GetPlayer();
        if (!player)
            continue;

        if (player->IsInWorld() && player->GetZoneId() == zone)
            return player;
    }
    return nullptr;
}

bool World::IsClosed() const
{
    return m_isClosed;
}

void World::SetClosed(bool val)
{
    m_isClosed = val;

    // Invert the value, for simplicity for scripters.
    sScriptMgr->OnOpenStateChange(!val);
}

/// Find a session by its id
WorldSession* World::FindSession(uint32 id) const
{
    SessionMap::const_iterator itr = m_sessions.find(id);

    if (itr != m_sessions.end())
        return itr->second;                                 // also can return nullptr for kicked session
    else
        return nullptr;
}

WorldSession* World::FindOfflineSession(uint32 id) const
{
    SessionMap::const_iterator itr = m_offlineSessions.find(id);
    if (itr != m_offlineSessions.end())
        return itr->second;
    else
        return nullptr;
}

WorldSession* World::FindOfflineSessionForCharacterGUID(ObjectGuid::LowType guidLow) const
{
    if (m_offlineSessions.empty())
        return nullptr;

    for (SessionMap::const_iterator itr = m_offlineSessions.begin(); itr != m_offlineSessions.end(); ++itr)
        if (itr->second->GetGuidLow() == guidLow)
            return itr->second;

    return nullptr;
}

/// Remove a given session
bool World::KickSession(uint32 id)
{
    ///- Find the session, kick the user, but we can't delete session at this moment to prevent iterator invalidation
    SessionMap::const_iterator itr = m_sessions.find(id);

    if (itr != m_sessions.end() && itr->second)
    {
        if (itr->second->PlayerLoading())
            return false;

        itr->second->KickPlayer("KickSession", false);
    }

    return true;
}

void World::AddSession(WorldSession* s)
{
    addSessQueue.add(s);
}

void World::AddSession_(WorldSession* s)
{
    ASSERT (s);

    // kick existing session with same account (if any)
    // if character on old session is being loaded, then return
    if (!KickSession(s->GetAccountId()))
    {
        s->KickPlayer("kick existing session with same account");
        delete s; // session not added yet in session list, so not listed in queue
        return;
    }

    SessionMap::const_iterator old = m_sessions.find(s->GetAccountId());
    if (old != m_sessions.end())
    {
        WorldSession* oldSession = old->second;

        if (!RemoveQueuedPlayer(oldSession) && getIntConfig(CONFIG_INTERVAL_DISCONNECT_TOLERANCE))
            m_disconnects[s->GetAccountId()] = time(nullptr);

        // pussywizard:
        if (oldSession->HandleSocketClosed())
        {
            // there should be no offline session if current one is logged onto a character
            SessionMap::iterator iter;
            if ((iter = m_offlineSessions.find(oldSession->GetAccountId())) != m_offlineSessions.end())
            {
                WorldSession* tmp = iter->second;
                m_offlineSessions.erase(iter);
                tmp->SetShouldSetOfflineInDB(false);
                delete tmp;
            }
            oldSession->SetOfflineTime(time(nullptr));
            m_offlineSessions[oldSession->GetAccountId()] = oldSession;
        }
        else
        {
            oldSession->SetShouldSetOfflineInDB(false); // pussywizard: don't set offline in db because new session for that acc is already created
            delete oldSession;
        }
    }

    m_sessions[s->GetAccountId()] = s;

    uint32 Sessions = GetActiveAndQueuedSessionCount();
    uint32 pLimit = GetPlayerAmountLimit();

    // don't count this session when checking player limit
    --Sessions;

    if (pLimit > 0 && Sessions >= pLimit && AccountMgr::IsPlayerAccount(s->GetSecurity()) && !s->CanSkipQueue() && !HasRecentlyDisconnected(s))
    {
        AddQueuedPlayer (s);
        UpdateMaxSessionCounters();
        return;
    }

    s->SendAuthResponse(AUTH_OK, true);
    s->SendAddonsInfo();
    s->SendClientCacheVersion(sWorld->getIntConfig(CONFIG_CLIENTCACHE_VERSION));
    s->SendTutorialsData();

    UpdateMaxSessionCounters();
}

bool World::HasRecentlyDisconnected(WorldSession* session)
{
    if (!session)
        return false;

    if (uint32 tolerance = getIntConfig(CONFIG_INTERVAL_DISCONNECT_TOLERANCE))
    {
        for (DisconnectMap::iterator i = m_disconnects.begin(); i != m_disconnects.end();)
        {
            if ((time(nullptr) - i->second) < tolerance)
            {
                if (i->first == session->GetAccountId())
                    return true;
                ++i;
            }
            else
                m_disconnects.erase(i++);
        }
    }
    return false;
}

int32 World::GetQueuePos(WorldSession* sess)
{
    uint32 position = 1;

    for (Queue::const_iterator iter = m_QueuedPlayer.begin(); iter != m_QueuedPlayer.end(); ++iter, ++position)
        if ((*iter) == sess)
            return position;

    return 0;
}

void World::AddQueuedPlayer(WorldSession* sess)
{
    sess->SetInQueue(true);
    m_QueuedPlayer.push_back(sess);

    // The 1st SMSG_AUTH_RESPONSE needs to contain other info too.
    sess->SendAuthResponse(AUTH_WAIT_QUEUE, false, GetQueuePos(sess));
}

bool World::RemoveQueuedPlayer(WorldSession* sess)
{
    uint32 sessions = GetActiveSessionCount();

    uint32 position = 1;
    Queue::iterator iter = m_QueuedPlayer.begin();

    // search to remove and count skipped positions
    bool found = false;

    for (; iter != m_QueuedPlayer.end(); ++iter, ++position)
    {
        if (*iter == sess)
        {
            sess->SetInQueue(false);
            sess->ResetTimeOutTime(false);
            iter = m_QueuedPlayer.erase(iter);
            found = true;
            break;
        }
    }

    // if session not queued then it was an active session
    if (!found)
    {
        ASSERT(sessions > 0);
        --sessions;
    }

    // accept first in queue
    if ((!GetPlayerAmountLimit() || sessions < GetPlayerAmountLimit()) && !m_QueuedPlayer.empty())
    {
        WorldSession* pop_sess = m_QueuedPlayer.front();
        pop_sess->SetInQueue(false);
        pop_sess->ResetTimeOutTime(false);
        pop_sess->SendAuthWaitQue(0);
        pop_sess->SendAddonsInfo();

        pop_sess->SendClientCacheVersion(sWorld->getIntConfig(CONFIG_CLIENTCACHE_VERSION));
        pop_sess->SendAccountDataTimes(GLOBAL_CACHE_MASK);
        pop_sess->SendTutorialsData();

        m_QueuedPlayer.pop_front();

        // update iter to point first queued socket or end() if queue is empty now
        iter = m_QueuedPlayer.begin();
        position = 1;
    }

    // update queue position from iter to end()
    for (; iter != m_QueuedPlayer.end(); ++iter, ++position)
        (*iter)->SendAuthWaitQue(position);

    return found;
}

/// Initialize config values
void World::LoadConfigSettings(bool reload)
{
    if (reload)
    {
        if (!sConfigMgr->Reload())
        {
            LOG_ERROR("server", "World settings reload fail: can't read settings.");
            return;
        }

        sLog->LoadFromConfig();
    }

    // Set realm id and enable db logging
    sLog->SetRealmId(realm.Id.Realm);

#ifdef ELUNA
    ///- Initialize Lua Engine
    if (!reload)
    {
        LOG_INFO("server", "Initialize Eluna Lua Engine...");
        Eluna::Initialize();
    }
#endif

    sScriptMgr->OnBeforeConfigLoad(reload);

    ///- Read the player limit and the Message of the day from the config file
    if (!reload)
    {
        SetPlayerAmountLimit(sConfigMgr->GetOption<int32>("PlayerLimit", 1000));
    }

    Motd::SetMotd(sConfigMgr->GetOption<std::string>("Motd", "Welcome to an AzerothCore server"));

    ///- Read ticket system setting from the config file
    m_bool_configs[CONFIG_ALLOW_TICKETS] = sConfigMgr->GetOption<bool>("AllowTickets", true);
    m_bool_configs[CONFIG_DELETE_CHARACTER_TICKET_TRACE] = sConfigMgr->GetOption<bool>("DeletedCharacterTicketTrace", false);

    ///- Get string for new logins (newly created characters)
    SetNewCharString(sConfigMgr->GetOption<std::string>("PlayerStart.String", ""));

    ///- Send server info on login?
    m_int_configs[CONFIG_ENABLE_SINFO_LOGIN] = sConfigMgr->GetOption<int32>("Server.LoginInfo", 0);

    ///- Read all rates from the config file
    rate_values[RATE_HEALTH]      = sConfigMgr->GetOption<float>("Rate.Health", 1);
    if (rate_values[RATE_HEALTH] < 0)
    {
        LOG_ERROR("server", "Rate.Health (%f) must be > 0. Using 1 instead.", rate_values[RATE_HEALTH]);
        rate_values[RATE_HEALTH] = 1;
    }
    rate_values[RATE_POWER_MANA]  = sConfigMgr->GetOption<float>("Rate.Mana", 1);
    if (rate_values[RATE_POWER_MANA] < 0)
    {
        LOG_ERROR("server", "Rate.Mana (%f) must be > 0. Using 1 instead.", rate_values[RATE_POWER_MANA]);
        rate_values[RATE_POWER_MANA] = 1;
    }
    rate_values[RATE_POWER_RAGE_INCOME] = sConfigMgr->GetOption<float>("Rate.Rage.Income", 1);
    rate_values[RATE_POWER_RAGE_LOSS]   = sConfigMgr->GetOption<float>("Rate.Rage.Loss", 1);
    if (rate_values[RATE_POWER_RAGE_LOSS] < 0)
    {
        LOG_ERROR("server", "Rate.Rage.Loss (%f) must be > 0. Using 1 instead.", rate_values[RATE_POWER_RAGE_LOSS]);
        rate_values[RATE_POWER_RAGE_LOSS] = 1;
    }
    rate_values[RATE_POWER_RUNICPOWER_INCOME] = sConfigMgr->GetOption<float>("Rate.RunicPower.Income", 1);
    rate_values[RATE_POWER_RUNICPOWER_LOSS]   = sConfigMgr->GetOption<float>("Rate.RunicPower.Loss", 1);
    if (rate_values[RATE_POWER_RUNICPOWER_LOSS] < 0)
    {
        LOG_ERROR("server", "Rate.RunicPower.Loss (%f) must be > 0. Using 1 instead.", rate_values[RATE_POWER_RUNICPOWER_LOSS]);
        rate_values[RATE_POWER_RUNICPOWER_LOSS] = 1;
    }
    rate_values[RATE_POWER_FOCUS]                 = sConfigMgr->GetOption<float>("Rate.Focus", 1.0f);
    rate_values[RATE_POWER_ENERGY]                = sConfigMgr->GetOption<float>("Rate.Energy", 1.0f);

    rate_values[RATE_SKILL_DISCOVERY]             = sConfigMgr->GetOption<float>("Rate.Skill.Discovery", 1.0f);

    rate_values[RATE_DROP_ITEM_POOR]              = sConfigMgr->GetOption<float>("Rate.Drop.Item.Poor", 1.0f);
    rate_values[RATE_DROP_ITEM_NORMAL]            = sConfigMgr->GetOption<float>("Rate.Drop.Item.Normal", 1.0f);
    rate_values[RATE_DROP_ITEM_UNCOMMON]          = sConfigMgr->GetOption<float>("Rate.Drop.Item.Uncommon", 1.0f);
    rate_values[RATE_DROP_ITEM_RARE]              = sConfigMgr->GetOption<float>("Rate.Drop.Item.Rare", 1.0f);
    rate_values[RATE_DROP_ITEM_EPIC]              = sConfigMgr->GetOption<float>("Rate.Drop.Item.Epic", 1.0f);
    rate_values[RATE_DROP_ITEM_LEGENDARY]         = sConfigMgr->GetOption<float>("Rate.Drop.Item.Legendary", 1.0f);
    rate_values[RATE_DROP_ITEM_ARTIFACT]          = sConfigMgr->GetOption<float>("Rate.Drop.Item.Artifact", 1.0f);
    rate_values[RATE_DROP_ITEM_REFERENCED]        = sConfigMgr->GetOption<float>("Rate.Drop.Item.Referenced", 1.0f);
    rate_values[RATE_DROP_ITEM_REFERENCED_AMOUNT] = sConfigMgr->GetOption<float>("Rate.Drop.Item.ReferencedAmount", 1.0f);
    rate_values[RATE_DROP_MONEY]                  = sConfigMgr->GetOption<float>("Rate.Drop.Money", 1.0f);
    rate_values[RATE_REWARD_BONUS_MONEY]          = sConfigMgr->GetOption<float>("Rate.RewardBonusMoney", 1.0f);
    rate_values[RATE_XP_KILL]                     = sConfigMgr->GetOption<float>("Rate.XP.Kill", 1.0f);
    rate_values[RATE_XP_BG_KILL]                  = sConfigMgr->GetOption<float>("Rate.XP.BattlegroundKill", 1.0f);
    rate_values[RATE_XP_QUEST]                    = sConfigMgr->GetOption<float>("Rate.XP.Quest", 1.0f);
    rate_values[RATE_XP_EXPLORE]                  = sConfigMgr->GetOption<float>("Rate.XP.Explore", 1.0f);
    rate_values[RATE_XP_PET]                      = sConfigMgr->GetOption<float>("Rate.XP.Pet", 1.0f);
    rate_values[RATE_XP_PET_NEXT_LEVEL]           = sConfigMgr->GetOption<float>("Rate.Pet.LevelXP", 0.05f);
    rate_values[RATE_REPAIRCOST]                  = sConfigMgr->GetOption<float>("Rate.RepairCost", 1.0f);

    rate_values[RATE_SELLVALUE_ITEM_POOR]         = sConfigMgr->GetOption<float>("Rate.SellValue.Item.Poor", 1.0f);
    rate_values[RATE_SELLVALUE_ITEM_NORMAL]       = sConfigMgr->GetOption<float>("Rate.SellValue.Item.Normal", 1.0f);
    rate_values[RATE_SELLVALUE_ITEM_UNCOMMON]     = sConfigMgr->GetOption<float>("Rate.SellValue.Item.Uncommon", 1.0f);
    rate_values[RATE_SELLVALUE_ITEM_RARE]         = sConfigMgr->GetOption<float>("Rate.SellValue.Item.Rare", 1.0f);
    rate_values[RATE_SELLVALUE_ITEM_EPIC]         = sConfigMgr->GetOption<float>("Rate.SellValue.Item.Epic", 1.0f);
    rate_values[RATE_SELLVALUE_ITEM_LEGENDARY]    = sConfigMgr->GetOption<float>("Rate.SellValue.Item.Legendary", 1.0f);
    rate_values[RATE_SELLVALUE_ITEM_ARTIFACT]     = sConfigMgr->GetOption<float>("Rate.SellValue.Item.Artifact", 1.0f);
    rate_values[RATE_SELLVALUE_ITEM_HEIRLOOM]     = sConfigMgr->GetOption<float>("Rate.SellValue.Item.Heirloom", 1.0f);

    rate_values[ RATE_BUYVALUE_ITEM_POOR]         = sConfigMgr->GetOption<float>("Rate.BuyValue.Item.Poor", 1.0f);
    rate_values[ RATE_BUYVALUE_ITEM_NORMAL]       = sConfigMgr->GetOption<float>("Rate.BuyValue.Item.Normal", 1.0f);
    rate_values[ RATE_BUYVALUE_ITEM_UNCOMMON]     = sConfigMgr->GetOption<float>("Rate.BuyValue.Item.Uncommon", 1.0f);
    rate_values[ RATE_BUYVALUE_ITEM_RARE]         = sConfigMgr->GetOption<float>("Rate.BuyValue.Item.Rare", 1.0f);
    rate_values[ RATE_BUYVALUE_ITEM_EPIC]         = sConfigMgr->GetOption<float>("Rate.BuyValue.Item.Epic", 1.0f);
    rate_values[ RATE_BUYVALUE_ITEM_LEGENDARY]    = sConfigMgr->GetOption<float>("Rate.BuyValue.Item.Legendary", 1.0f);
    rate_values[RATE_BUYVALUE_ITEM_ARTIFACT]      = sConfigMgr->GetOption<float>("Rate.BuyValue.Item.Artifact", 1.0f);
    rate_values[RATE_BUYVALUE_ITEM_HEIRLOOM]      = sConfigMgr->GetOption<float>("Rate.BuyValue.Item.Heirloom", 1.0f);

    if (rate_values[RATE_REPAIRCOST] < 0.0f)
    {
        LOG_ERROR("server", "Rate.RepairCost (%f) must be >=0. Using 0.0 instead.", rate_values[RATE_REPAIRCOST]);
        rate_values[RATE_REPAIRCOST] = 0.0f;
    }
    rate_values[RATE_REPUTATION_GAIN]                      = sConfigMgr->GetOption<float>("Rate.Reputation.Gain", 1.0f);
    rate_values[RATE_REPUTATION_LOWLEVEL_KILL]             = sConfigMgr->GetOption<float>("Rate.Reputation.LowLevel.Kill", 1.0f);
    rate_values[RATE_REPUTATION_LOWLEVEL_QUEST]            = sConfigMgr->GetOption<float>("Rate.Reputation.LowLevel.Quest", 1.0f);
    rate_values[RATE_REPUTATION_RECRUIT_A_FRIEND_BONUS]    = sConfigMgr->GetOption<float>("Rate.Reputation.RecruitAFriendBonus", 0.1f);
    rate_values[RATE_CREATURE_NORMAL_DAMAGE]               = sConfigMgr->GetOption<float>("Rate.Creature.Normal.Damage", 1.0f);
    rate_values[RATE_CREATURE_ELITE_ELITE_DAMAGE]          = sConfigMgr->GetOption<float>("Rate.Creature.Elite.Elite.Damage", 1.0f);
    rate_values[RATE_CREATURE_ELITE_RAREELITE_DAMAGE]      = sConfigMgr->GetOption<float>("Rate.Creature.Elite.RAREELITE.Damage", 1.0f);
    rate_values[RATE_CREATURE_ELITE_WORLDBOSS_DAMAGE]      = sConfigMgr->GetOption<float>("Rate.Creature.Elite.WORLDBOSS.Damage", 1.0f);
    rate_values[RATE_CREATURE_ELITE_RARE_DAMAGE]           = sConfigMgr->GetOption<float>("Rate.Creature.Elite.RARE.Damage", 1.0f);
    rate_values[RATE_CREATURE_NORMAL_HP]                   = sConfigMgr->GetOption<float>("Rate.Creature.Normal.HP", 1.0f);
    rate_values[RATE_CREATURE_ELITE_ELITE_HP]              = sConfigMgr->GetOption<float>("Rate.Creature.Elite.Elite.HP", 1.0f);
    rate_values[RATE_CREATURE_ELITE_RAREELITE_HP]          = sConfigMgr->GetOption<float>("Rate.Creature.Elite.RAREELITE.HP", 1.0f);
    rate_values[RATE_CREATURE_ELITE_WORLDBOSS_HP]          = sConfigMgr->GetOption<float>("Rate.Creature.Elite.WORLDBOSS.HP", 1.0f);
    rate_values[RATE_CREATURE_ELITE_RARE_HP]               = sConfigMgr->GetOption<float>("Rate.Creature.Elite.RARE.HP", 1.0f);
    rate_values[RATE_CREATURE_NORMAL_SPELLDAMAGE]          = sConfigMgr->GetOption<float>("Rate.Creature.Normal.SpellDamage", 1.0f);
    rate_values[RATE_CREATURE_ELITE_ELITE_SPELLDAMAGE]     = sConfigMgr->GetOption<float>("Rate.Creature.Elite.Elite.SpellDamage", 1.0f);
    rate_values[RATE_CREATURE_ELITE_RAREELITE_SPELLDAMAGE] = sConfigMgr->GetOption<float>("Rate.Creature.Elite.RAREELITE.SpellDamage", 1.0f);
    rate_values[RATE_CREATURE_ELITE_WORLDBOSS_SPELLDAMAGE] = sConfigMgr->GetOption<float>("Rate.Creature.Elite.WORLDBOSS.SpellDamage", 1.0f);
    rate_values[RATE_CREATURE_ELITE_RARE_SPELLDAMAGE]      = sConfigMgr->GetOption<float>("Rate.Creature.Elite.RARE.SpellDamage", 1.0f);
    rate_values[RATE_CREATURE_AGGRO]                       = sConfigMgr->GetOption<float>("Rate.Creature.Aggro", 1.0f);
    rate_values[RATE_REST_INGAME]                          = sConfigMgr->GetOption<float>("Rate.Rest.InGame", 1.0f);
    rate_values[RATE_REST_OFFLINE_IN_TAVERN_OR_CITY]       = sConfigMgr->GetOption<float>("Rate.Rest.Offline.InTavernOrCity", 1.0f);
    rate_values[RATE_REST_OFFLINE_IN_WILDERNESS]           = sConfigMgr->GetOption<float>("Rate.Rest.Offline.InWilderness", 1.0f);
    rate_values[RATE_DAMAGE_FALL]                          = sConfigMgr->GetOption<float>("Rate.Damage.Fall", 1.0f);
    rate_values[RATE_AUCTION_TIME]                         = sConfigMgr->GetOption<float>("Rate.Auction.Time", 1.0f);
    rate_values[RATE_AUCTION_DEPOSIT]                      = sConfigMgr->GetOption<float>("Rate.Auction.Deposit", 1.0f);
    rate_values[RATE_AUCTION_CUT]                          = sConfigMgr->GetOption<float>("Rate.Auction.Cut", 1.0f);
    rate_values[RATE_HONOR]                                = sConfigMgr->GetOption<float>("Rate.Honor", 1.0f);
    rate_values[RATE_ARENA_POINTS]                         = sConfigMgr->GetOption<float>("Rate.ArenaPoints", 1.0f);
    rate_values[RATE_INSTANCE_RESET_TIME]                  = sConfigMgr->GetOption<float>("Rate.InstanceResetTime", 1.0f);
    rate_values[RATE_TALENT]                               = sConfigMgr->GetOption<float>("Rate.Talent", 1.0f);
    if (rate_values[RATE_TALENT] < 0.0f)
    {
        LOG_ERROR("server", "Rate.Talent (%f) must be > 0. Using 1 instead.", rate_values[RATE_TALENT]);
        rate_values[RATE_TALENT] = 1.0f;
    }
    rate_values[RATE_MOVESPEED] = sConfigMgr->GetOption<float>("Rate.MoveSpeed", 1.0f);
    if (rate_values[RATE_MOVESPEED] < 0)
    {
        LOG_ERROR("server", "Rate.MoveSpeed (%f) must be > 0. Using 1 instead.", rate_values[RATE_MOVESPEED]);
        rate_values[RATE_MOVESPEED] = 1.0f;
    }
    for (uint8 i = 0; i < MAX_MOVE_TYPE; ++i) playerBaseMoveSpeed[i] = baseMoveSpeed[i] * rate_values[RATE_MOVESPEED];
    rate_values[RATE_CORPSE_DECAY_LOOTED] = sConfigMgr->GetOption<float>("Rate.Corpse.Decay.Looted", 0.5f);

    rate_values[RATE_TARGET_POS_RECALCULATION_RANGE] = sConfigMgr->GetOption<float>("TargetPosRecalculateRange", 1.5f);
    if (rate_values[RATE_TARGET_POS_RECALCULATION_RANGE] < CONTACT_DISTANCE)
    {
        LOG_ERROR("server", "TargetPosRecalculateRange (%f) must be >= %f. Using %f instead.", rate_values[RATE_TARGET_POS_RECALCULATION_RANGE], CONTACT_DISTANCE, CONTACT_DISTANCE);
        rate_values[RATE_TARGET_POS_RECALCULATION_RANGE] = CONTACT_DISTANCE;
    }
    else if (rate_values[RATE_TARGET_POS_RECALCULATION_RANGE] > NOMINAL_MELEE_RANGE)
    {
        LOG_ERROR("server", "TargetPosRecalculateRange (%f) must be <= %f. Using %f instead.",
                       rate_values[RATE_TARGET_POS_RECALCULATION_RANGE], NOMINAL_MELEE_RANGE, NOMINAL_MELEE_RANGE);
        rate_values[RATE_TARGET_POS_RECALCULATION_RANGE] = NOMINAL_MELEE_RANGE;
    }

    rate_values[RATE_DURABILITY_LOSS_ON_DEATH]  = sConfigMgr->GetOption<float>("DurabilityLoss.OnDeath", 10.0f);
    if (rate_values[RATE_DURABILITY_LOSS_ON_DEATH] < 0.0f)
    {
        LOG_ERROR("server", "DurabilityLoss.OnDeath (%f) must be >=0. Using 0.0 instead.", rate_values[RATE_DURABILITY_LOSS_ON_DEATH]);
        rate_values[RATE_DURABILITY_LOSS_ON_DEATH] = 0.0f;
    }
    if (rate_values[RATE_DURABILITY_LOSS_ON_DEATH] > 100.0f)
    {
        LOG_ERROR("server", "DurabilityLoss.OnDeath (%f) must be <= 100. Using 100.0 instead.", rate_values[RATE_DURABILITY_LOSS_ON_DEATH]);
        rate_values[RATE_DURABILITY_LOSS_ON_DEATH] = 0.0f;
    }
    rate_values[RATE_DURABILITY_LOSS_ON_DEATH] = rate_values[RATE_DURABILITY_LOSS_ON_DEATH] / 100.0f;

    rate_values[RATE_DURABILITY_LOSS_DAMAGE] = sConfigMgr->GetOption<float>("DurabilityLossChance.Damage", 0.5f);
    if (rate_values[RATE_DURABILITY_LOSS_DAMAGE] < 0.0f)
    {
        LOG_ERROR("server", "DurabilityLossChance.Damage (%f) must be >=0. Using 0.0 instead.", rate_values[RATE_DURABILITY_LOSS_DAMAGE]);
        rate_values[RATE_DURABILITY_LOSS_DAMAGE] = 0.0f;
    }
    rate_values[RATE_DURABILITY_LOSS_ABSORB] = sConfigMgr->GetOption<float>("DurabilityLossChance.Absorb", 0.5f);
    if (rate_values[RATE_DURABILITY_LOSS_ABSORB] < 0.0f)
    {
        LOG_ERROR("server", "DurabilityLossChance.Absorb (%f) must be >=0. Using 0.0 instead.", rate_values[RATE_DURABILITY_LOSS_ABSORB]);
        rate_values[RATE_DURABILITY_LOSS_ABSORB] = 0.0f;
    }
    rate_values[RATE_DURABILITY_LOSS_PARRY] = sConfigMgr->GetOption<float>("DurabilityLossChance.Parry", 0.05f);
    if (rate_values[RATE_DURABILITY_LOSS_PARRY] < 0.0f)
    {
        LOG_ERROR("server", "DurabilityLossChance.Parry (%f) must be >=0. Using 0.0 instead.", rate_values[RATE_DURABILITY_LOSS_PARRY]);
        rate_values[RATE_DURABILITY_LOSS_PARRY] = 0.0f;
    }
    rate_values[RATE_DURABILITY_LOSS_BLOCK] = sConfigMgr->GetOption<float>("DurabilityLossChance.Block", 0.05f);
    if (rate_values[RATE_DURABILITY_LOSS_BLOCK] < 0.0f)
    {
        LOG_ERROR("server", "DurabilityLossChance.Block (%f) must be >=0. Using 0.0 instead.", rate_values[RATE_DURABILITY_LOSS_BLOCK]);
        rate_values[RATE_DURABILITY_LOSS_BLOCK] = 0.0f;
    }

    ///- Read other configuration items from the config file

    m_bool_configs[CONFIG_DURABILITY_LOSS_IN_PVP] = sConfigMgr->GetOption<bool>("DurabilityLoss.InPvP", false);

    m_int_configs[CONFIG_COMPRESSION] = sConfigMgr->GetOption<int32>("Compression", 1);
    if (m_int_configs[CONFIG_COMPRESSION] < 1 || m_int_configs[CONFIG_COMPRESSION] > 9)
    {
        LOG_ERROR("server", "Compression level (%u) must be in range 1..9. Using default compression level (1).", m_int_configs[CONFIG_COMPRESSION]);
        m_int_configs[CONFIG_COMPRESSION] = 1;
    }
    m_bool_configs[CONFIG_ADDON_CHANNEL]                   = sConfigMgr->GetOption<bool>("AddonChannel", true);
    m_bool_configs[CONFIG_CLEAN_CHARACTER_DB]              = sConfigMgr->GetOption<bool>("CleanCharacterDB", false);
    m_int_configs[CONFIG_PERSISTENT_CHARACTER_CLEAN_FLAGS] = sConfigMgr->GetOption<int32>("PersistentCharacterCleanFlags", 0);
    m_int_configs[CONFIG_CHAT_CHANNEL_LEVEL_REQ]           = sConfigMgr->GetOption<int32>("ChatLevelReq.Channel", 1);
    m_int_configs[CONFIG_CHAT_WHISPER_LEVEL_REQ]           = sConfigMgr->GetOption<int32>("ChatLevelReq.Whisper", 1);
    m_int_configs[CONFIG_CHAT_SAY_LEVEL_REQ]               = sConfigMgr->GetOption<int32>("ChatLevelReq.Say", 1);
    m_int_configs[CONFIG_PARTY_LEVEL_REQ]                  = sConfigMgr->GetOption<int32>("PartyLevelReq", 1);
    m_int_configs[CONFIG_TRADE_LEVEL_REQ]                  = sConfigMgr->GetOption<int32>("LevelReq.Trade", 1);
    m_int_configs[CONFIG_TICKET_LEVEL_REQ]                 = sConfigMgr->GetOption<int32>("LevelReq.Ticket", 1);
    m_int_configs[CONFIG_AUCTION_LEVEL_REQ]                = sConfigMgr->GetOption<int32>("LevelReq.Auction", 1);
    m_int_configs[CONFIG_MAIL_LEVEL_REQ]                   = sConfigMgr->GetOption<int32>("LevelReq.Mail", 1);
    m_bool_configs[CONFIG_ALLOW_PLAYER_COMMANDS]           = sConfigMgr->GetOption<bool>("AllowPlayerCommands", 1);
    m_bool_configs[CONFIG_PRESERVE_CUSTOM_CHANNELS]        = sConfigMgr->GetOption<bool>("PreserveCustomChannels", false);
    m_int_configs[CONFIG_PRESERVE_CUSTOM_CHANNEL_DURATION] = sConfigMgr->GetOption<int32>("PreserveCustomChannelDuration", 14);
    m_int_configs[CONFIG_INTERVAL_SAVE]                    = sConfigMgr->GetOption<int32>("PlayerSaveInterval", 15 * MINUTE * IN_MILLISECONDS);
    m_int_configs[CONFIG_INTERVAL_DISCONNECT_TOLERANCE]    = sConfigMgr->GetOption<int32>("DisconnectToleranceInterval", 0);
    m_bool_configs[CONFIG_STATS_SAVE_ONLY_ON_LOGOUT]       = sConfigMgr->GetOption<bool>("PlayerSave.Stats.SaveOnlyOnLogout", true);

    m_int_configs[CONFIG_MIN_LEVEL_STAT_SAVE] = sConfigMgr->GetOption<int32>("PlayerSave.Stats.MinLevel", 0);
    if (m_int_configs[CONFIG_MIN_LEVEL_STAT_SAVE] > MAX_LEVEL)
    {
        LOG_ERROR("server", "PlayerSave.Stats.MinLevel (%i) must be in range 0..80. Using default, do not save character stats (0).", m_int_configs[CONFIG_MIN_LEVEL_STAT_SAVE]);
        m_int_configs[CONFIG_MIN_LEVEL_STAT_SAVE] = 0;
    }

    m_int_configs[CONFIG_INTERVAL_MAPUPDATE] = sConfigMgr->GetOption<int32>("MapUpdateInterval", 100);
    if (m_int_configs[CONFIG_INTERVAL_MAPUPDATE] < MIN_MAP_UPDATE_DELAY)
    {
        LOG_ERROR("server", "MapUpdateInterval (%i) must be greater %u. Use this minimal value.", m_int_configs[CONFIG_INTERVAL_MAPUPDATE], MIN_MAP_UPDATE_DELAY);
        m_int_configs[CONFIG_INTERVAL_MAPUPDATE] = MIN_MAP_UPDATE_DELAY;
    }
    if (reload)
        sMapMgr->SetMapUpdateInterval(m_int_configs[CONFIG_INTERVAL_MAPUPDATE]);

    m_int_configs[CONFIG_INTERVAL_CHANGEWEATHER] = sConfigMgr->GetOption<int32>("ChangeWeatherInterval", 10 * MINUTE * IN_MILLISECONDS);

    if (reload)
    {
        uint32 val = sConfigMgr->GetOption<int32>("WorldServerPort", 8085);
        if (val != m_int_configs[CONFIG_PORT_WORLD])
            LOG_ERROR("server", "WorldServerPort option can't be changed at worldserver.conf reload, using current value (%u).", m_int_configs[CONFIG_PORT_WORLD]);
    }
    else
        m_int_configs[CONFIG_PORT_WORLD] = sConfigMgr->GetOption<int32>("WorldServerPort", 8085);

    m_bool_configs[CONFIG_CLOSE_IDLE_CONNECTIONS]   = sConfigMgr->GetOption<bool>("CloseIdleConnections", true);
    m_int_configs[CONFIG_SOCKET_TIMEOUTTIME]        = sConfigMgr->GetOption<int32>("SocketTimeOutTime", 900000);
    m_int_configs[CONFIG_SOCKET_TIMEOUTTIME_ACTIVE] = sConfigMgr->GetOption<int32>("SocketTimeOutTimeActive", 60000);
    m_int_configs[CONFIG_SESSION_ADD_DELAY]         = sConfigMgr->GetOption<int32>("SessionAddDelay", 10000);

    m_float_configs[CONFIG_GROUP_XP_DISTANCE]             = sConfigMgr->GetOption<float>("MaxGroupXPDistance", 74.0f);
    m_float_configs[CONFIG_MAX_RECRUIT_A_FRIEND_DISTANCE] = sConfigMgr->GetOption<float>("MaxRecruitAFriendBonusDistance", 100.0f);

    /// \todo Add MonsterSight in worldserver.conf or put it as define
    m_float_configs[CONFIG_SIGHT_MONSTER] = sConfigMgr->GetOption<float>("MonsterSight", 50);

    if (reload)
    {
        uint32 val = sConfigMgr->GetOption<int32>("GameType", 0);
        if (val != m_int_configs[CONFIG_GAME_TYPE])
            LOG_ERROR("server", "GameType option can't be changed at worldserver.conf reload, using current value (%u).", m_int_configs[CONFIG_GAME_TYPE]);
    }
    else
        m_int_configs[CONFIG_GAME_TYPE] = sConfigMgr->GetOption<int32>("GameType", 0);

    if (reload)
    {
        uint32 val = sConfigMgr->GetOption<int32>("RealmZone", REALM_ZONE_DEVELOPMENT);
        if (val != m_int_configs[CONFIG_REALM_ZONE])
            LOG_ERROR("server", "RealmZone option can't be changed at worldserver.conf reload, using current value (%u).", m_int_configs[CONFIG_REALM_ZONE]);
    }
    else
        m_int_configs[CONFIG_REALM_ZONE] = sConfigMgr->GetOption<int32>("RealmZone", REALM_ZONE_DEVELOPMENT);

    m_int_configs[CONFIG_STRICT_PLAYER_NAMES]                  = sConfigMgr->GetOption<int32> ("StrictPlayerNames",  0);
    m_int_configs[CONFIG_STRICT_CHARTER_NAMES]                 = sConfigMgr->GetOption<int32> ("StrictCharterNames", 0);
    m_int_configs[CONFIG_STRICT_CHANNEL_NAMES]                 = sConfigMgr->GetOption<int32> ("StrictChannelNames", 0);
    m_int_configs[CONFIG_STRICT_PET_NAMES]                     = sConfigMgr->GetOption<int32> ("StrictPetNames",     0);

    m_bool_configs[CONFIG_ALLOW_TWO_SIDE_ACCOUNTS]             = sConfigMgr->GetOption<bool>("AllowTwoSide.Accounts", true);
    m_bool_configs[CONFIG_ALLOW_TWO_SIDE_INTERACTION_CALENDAR] = sConfigMgr->GetOption<bool>("AllowTwoSide.Interaction.Calendar", false);
    m_bool_configs[CONFIG_ALLOW_TWO_SIDE_INTERACTION_CHAT]     = sConfigMgr->GetOption<bool>("AllowTwoSide.Interaction.Chat", false);
    m_bool_configs[CONFIG_ALLOW_TWO_SIDE_INTERACTION_CHANNEL]  = sConfigMgr->GetOption<bool>("AllowTwoSide.Interaction.Channel", false);
    m_bool_configs[CONFIG_ALLOW_TWO_SIDE_INTERACTION_GROUP]    = sConfigMgr->GetOption<bool>("AllowTwoSide.Interaction.Group", false);
    m_bool_configs[CONFIG_ALLOW_TWO_SIDE_INTERACTION_GUILD]    = sConfigMgr->GetOption<bool>("AllowTwoSide.Interaction.Guild", false);
    m_bool_configs[CONFIG_ALLOW_TWO_SIDE_INTERACTION_AUCTION]  = sConfigMgr->GetOption<bool>("AllowTwoSide.Interaction.Auction", false);
    m_bool_configs[CONFIG_ALLOW_TWO_SIDE_INTERACTION_MAIL]     = sConfigMgr->GetOption<bool>("AllowTwoSide.Interaction.Mail", false);
    m_bool_configs[CONFIG_ALLOW_TWO_SIDE_WHO_LIST]             = sConfigMgr->GetOption<bool>("AllowTwoSide.WhoList", false);
    m_bool_configs[CONFIG_ALLOW_TWO_SIDE_ADD_FRIEND]           = sConfigMgr->GetOption<bool>("AllowTwoSide.AddFriend", false);
    m_bool_configs[CONFIG_ALLOW_TWO_SIDE_TRADE]                = sConfigMgr->GetOption<bool>("AllowTwoSide.Trade", false);
    m_bool_configs[CONFIG_ALLOW_TWO_SIDE_INTERACTION_EMOTE]    = sConfigMgr->GetOption<bool>("AllowTwoSide.Interaction.Emote", false);

    m_int_configs[CONFIG_MIN_PLAYER_NAME] = sConfigMgr->GetOption<int32> ("MinPlayerName",  2);
    if (m_int_configs[CONFIG_MIN_PLAYER_NAME] < 1 || m_int_configs[CONFIG_MIN_PLAYER_NAME] > MAX_PLAYER_NAME)
    {
        LOG_ERROR("server", "MinPlayerName (%i) must be in range 1..%u. Set to 2.", m_int_configs[CONFIG_MIN_PLAYER_NAME], MAX_PLAYER_NAME);
        m_int_configs[CONFIG_MIN_PLAYER_NAME] = 2;
    }

    m_int_configs[CONFIG_MIN_CHARTER_NAME] = sConfigMgr->GetOption<int32> ("MinCharterName", 2);
    if (m_int_configs[CONFIG_MIN_CHARTER_NAME] < 1 || m_int_configs[CONFIG_MIN_CHARTER_NAME] > MAX_CHARTER_NAME)
    {
        LOG_ERROR("server", "MinCharterName (%i) must be in range 1..%u. Set to 2.", m_int_configs[CONFIG_MIN_CHARTER_NAME], MAX_CHARTER_NAME);
        m_int_configs[CONFIG_MIN_CHARTER_NAME] = 2;
    }

    m_int_configs[CONFIG_MIN_PET_NAME] = sConfigMgr->GetOption<int32> ("MinPetName",     2);
    if (m_int_configs[CONFIG_MIN_PET_NAME] < 1 || m_int_configs[CONFIG_MIN_PET_NAME] > MAX_PET_NAME)
    {
        LOG_ERROR("server", "MinPetName (%i) must be in range 1..%u. Set to 2.", m_int_configs[CONFIG_MIN_PET_NAME], MAX_PET_NAME);
        m_int_configs[CONFIG_MIN_PET_NAME] = 2;
    }

    m_int_configs[CONFIG_CHARTER_COST_GUILD]     = sConfigMgr->GetOption<int32>("Guild.CharterCost", 1000);
    m_int_configs[CONFIG_CHARTER_COST_ARENA_2v2] = sConfigMgr->GetOption<int32>("ArenaTeam.CharterCost.2v2", 800000);
    m_int_configs[CONFIG_CHARTER_COST_ARENA_3v3] = sConfigMgr->GetOption<int32>("ArenaTeam.CharterCost.3v3", 1200000);
    m_int_configs[CONFIG_CHARTER_COST_ARENA_5v5] = sConfigMgr->GetOption<int32>("ArenaTeam.CharterCost.5v5", 2000000);

    m_int_configs[CONFIG_MAX_WHO_LIST_RETURN] = sConfigMgr->GetOption<int32>("MaxWhoListReturns", 49);

    m_int_configs[CONFIG_CHARACTER_CREATING_DISABLED]           = sConfigMgr->GetOption<int32>("CharacterCreating.Disabled", 0);
    m_int_configs[CONFIG_CHARACTER_CREATING_DISABLED_RACEMASK]  = sConfigMgr->GetOption<int32>("CharacterCreating.Disabled.RaceMask", 0);

    m_int_configs[CONFIG_CHARACTER_CREATING_DISABLED_CLASSMASK] = sConfigMgr->GetOption<int32>("CharacterCreating.Disabled.ClassMask", 0);

    m_int_configs[CONFIG_CHARACTERS_PER_REALM] = sConfigMgr->GetOption<int32>("CharactersPerRealm", 10);
    if (m_int_configs[CONFIG_CHARACTERS_PER_REALM] < 1 || m_int_configs[CONFIG_CHARACTERS_PER_REALM] > 10)
    {
        LOG_ERROR("server", "CharactersPerRealm (%i) must be in range 1..10. Set to 10.", m_int_configs[CONFIG_CHARACTERS_PER_REALM]);
        m_int_configs[CONFIG_CHARACTERS_PER_REALM] = 10;
    }

    // must be after CONFIG_CHARACTERS_PER_REALM
    m_int_configs[CONFIG_CHARACTERS_PER_ACCOUNT] = sConfigMgr->GetOption<int32>("CharactersPerAccount", 50);
    if (m_int_configs[CONFIG_CHARACTERS_PER_ACCOUNT] < m_int_configs[CONFIG_CHARACTERS_PER_REALM])
    {
        LOG_ERROR("server", "CharactersPerAccount (%i) can't be less than CharactersPerRealm (%i).", m_int_configs[CONFIG_CHARACTERS_PER_ACCOUNT], m_int_configs[CONFIG_CHARACTERS_PER_REALM]);
        m_int_configs[CONFIG_CHARACTERS_PER_ACCOUNT] = m_int_configs[CONFIG_CHARACTERS_PER_REALM];
    }

    m_int_configs[CONFIG_HEROIC_CHARACTERS_PER_REALM] = sConfigMgr->GetOption<int32>("HeroicCharactersPerRealm", 1);
    if (int32(m_int_configs[CONFIG_HEROIC_CHARACTERS_PER_REALM]) < 0 || m_int_configs[CONFIG_HEROIC_CHARACTERS_PER_REALM] > 10)
    {
        LOG_ERROR("server", "HeroicCharactersPerRealm (%i) must be in range 0..10. Set to 1.", m_int_configs[CONFIG_HEROIC_CHARACTERS_PER_REALM]);
        m_int_configs[CONFIG_HEROIC_CHARACTERS_PER_REALM] = 1;
    }

    m_int_configs[CONFIG_CHARACTER_CREATING_MIN_LEVEL_FOR_HEROIC_CHARACTER] = sConfigMgr->GetOption<int32>("CharacterCreating.MinLevelForHeroicCharacter", 55);

    m_int_configs[CONFIG_SKIP_CINEMATICS] = sConfigMgr->GetOption<int32>("SkipCinematics", 0);
    if (int32(m_int_configs[CONFIG_SKIP_CINEMATICS]) < 0 || m_int_configs[CONFIG_SKIP_CINEMATICS] > 2)
    {
        LOG_ERROR("server", "SkipCinematics (%i) must be in range 0..2. Set to 0.", m_int_configs[CONFIG_SKIP_CINEMATICS]);
        m_int_configs[CONFIG_SKIP_CINEMATICS] = 0;
    }

    if (reload)
    {
        uint32 val = sConfigMgr->GetOption<int32>("MaxPlayerLevel", DEFAULT_MAX_LEVEL);
        if (val != m_int_configs[CONFIG_MAX_PLAYER_LEVEL])
            LOG_ERROR("server", "MaxPlayerLevel option can't be changed at config reload, using current value (%u).", m_int_configs[CONFIG_MAX_PLAYER_LEVEL]);
    }
    else
        m_int_configs[CONFIG_MAX_PLAYER_LEVEL] = sConfigMgr->GetOption<int32>("MaxPlayerLevel", DEFAULT_MAX_LEVEL);

    if (m_int_configs[CONFIG_MAX_PLAYER_LEVEL] > MAX_LEVEL)
    {
        LOG_ERROR("server", "MaxPlayerLevel (%i) must be in range 1..%u. Set to %u.", m_int_configs[CONFIG_MAX_PLAYER_LEVEL], MAX_LEVEL, MAX_LEVEL);
        m_int_configs[CONFIG_MAX_PLAYER_LEVEL] = MAX_LEVEL;
    }

    m_int_configs[CONFIG_MIN_DUALSPEC_LEVEL] = sConfigMgr->GetOption<int32>("MinDualSpecLevel", 40);

    m_int_configs[CONFIG_START_PLAYER_LEVEL] = sConfigMgr->GetOption<int32>("StartPlayerLevel", 1);
    if (m_int_configs[CONFIG_START_PLAYER_LEVEL] < 1)
    {
        LOG_ERROR("server", "StartPlayerLevel (%i) must be in range 1..MaxPlayerLevel(%u). Set to 1.", m_int_configs[CONFIG_START_PLAYER_LEVEL], m_int_configs[CONFIG_MAX_PLAYER_LEVEL]);
        m_int_configs[CONFIG_START_PLAYER_LEVEL] = 1;
    }
    else if (m_int_configs[CONFIG_START_PLAYER_LEVEL] > m_int_configs[CONFIG_MAX_PLAYER_LEVEL])
    {
        LOG_ERROR("server", "StartPlayerLevel (%i) must be in range 1..MaxPlayerLevel(%u). Set to %u.", m_int_configs[CONFIG_START_PLAYER_LEVEL], m_int_configs[CONFIG_MAX_PLAYER_LEVEL], m_int_configs[CONFIG_MAX_PLAYER_LEVEL]);
        m_int_configs[CONFIG_START_PLAYER_LEVEL] = m_int_configs[CONFIG_MAX_PLAYER_LEVEL];
    }

    m_int_configs[CONFIG_START_HEROIC_PLAYER_LEVEL] = sConfigMgr->GetOption<int32>("StartHeroicPlayerLevel", 55);
    if (m_int_configs[CONFIG_START_HEROIC_PLAYER_LEVEL] < 1)
    {
        LOG_ERROR("server", "StartHeroicPlayerLevel (%i) must be in range 1..MaxPlayerLevel(%u). Set to 55.",
                       m_int_configs[CONFIG_START_HEROIC_PLAYER_LEVEL], m_int_configs[CONFIG_MAX_PLAYER_LEVEL]);
        m_int_configs[CONFIG_START_HEROIC_PLAYER_LEVEL] = 55;
    }
    else if (m_int_configs[CONFIG_START_HEROIC_PLAYER_LEVEL] > m_int_configs[CONFIG_MAX_PLAYER_LEVEL])
    {
        LOG_ERROR("server", "StartHeroicPlayerLevel (%i) must be in range 1..MaxPlayerLevel(%u). Set to %u.",
                       m_int_configs[CONFIG_START_HEROIC_PLAYER_LEVEL], m_int_configs[CONFIG_MAX_PLAYER_LEVEL], m_int_configs[CONFIG_MAX_PLAYER_LEVEL]);
        m_int_configs[CONFIG_START_HEROIC_PLAYER_LEVEL] = m_int_configs[CONFIG_MAX_PLAYER_LEVEL];
    }

    m_int_configs[CONFIG_START_PLAYER_MONEY] = sConfigMgr->GetOption<int32>("StartPlayerMoney", 0);
    if (int32(m_int_configs[CONFIG_START_PLAYER_MONEY]) < 0)
    {
        LOG_ERROR("server", "StartPlayerMoney (%i) must be in range 0..%u. Set to %u.", m_int_configs[CONFIG_START_PLAYER_MONEY], MAX_MONEY_AMOUNT, 0);
        m_int_configs[CONFIG_START_PLAYER_MONEY] = 0;
    }
    else if (m_int_configs[CONFIG_START_PLAYER_MONEY] > MAX_MONEY_AMOUNT)
    {
        LOG_ERROR("server", "StartPlayerMoney (%i) must be in range 0..%u. Set to %u.",
                       m_int_configs[CONFIG_START_PLAYER_MONEY], MAX_MONEY_AMOUNT, MAX_MONEY_AMOUNT);
        m_int_configs[CONFIG_START_PLAYER_MONEY] = MAX_MONEY_AMOUNT;
    }

    m_int_configs[CONFIG_MAX_HONOR_POINTS] = sConfigMgr->GetOption<int32>("MaxHonorPoints", 75000);
    if (int32(m_int_configs[CONFIG_MAX_HONOR_POINTS]) < 0)
    {
        LOG_ERROR("server", "MaxHonorPoints (%i) can't be negative. Set to 0.", m_int_configs[CONFIG_MAX_HONOR_POINTS]);
        m_int_configs[CONFIG_MAX_HONOR_POINTS] = 0;
    }

    m_int_configs[CONFIG_START_HONOR_POINTS] = sConfigMgr->GetOption<int32>("StartHonorPoints", 0);
    if (int32(m_int_configs[CONFIG_START_HONOR_POINTS]) < 0)
    {
        LOG_ERROR("server", "StartHonorPoints (%i) must be in range 0..MaxHonorPoints(%u). Set to %u.",
                       m_int_configs[CONFIG_START_HONOR_POINTS], m_int_configs[CONFIG_MAX_HONOR_POINTS], 0);
        m_int_configs[CONFIG_START_HONOR_POINTS] = 0;
    }
    else if (m_int_configs[CONFIG_START_HONOR_POINTS] > m_int_configs[CONFIG_MAX_HONOR_POINTS])
    {
        LOG_ERROR("server", "StartHonorPoints (%i) must be in range 0..MaxHonorPoints(%u). Set to %u.",
                       m_int_configs[CONFIG_START_HONOR_POINTS], m_int_configs[CONFIG_MAX_HONOR_POINTS], m_int_configs[CONFIG_MAX_HONOR_POINTS]);
        m_int_configs[CONFIG_START_HONOR_POINTS] = m_int_configs[CONFIG_MAX_HONOR_POINTS];
    }

    m_int_configs[CONFIG_MAX_ARENA_POINTS] = sConfigMgr->GetOption<int32>("MaxArenaPoints", 10000);
    if (int32(m_int_configs[CONFIG_MAX_ARENA_POINTS]) < 0)
    {
        LOG_ERROR("server", "MaxArenaPoints (%i) can't be negative. Set to 0.", m_int_configs[CONFIG_MAX_ARENA_POINTS]);
        m_int_configs[CONFIG_MAX_ARENA_POINTS] = 0;
    }

    m_int_configs[CONFIG_START_ARENA_POINTS] = sConfigMgr->GetOption<int32>("StartArenaPoints", 0);
    if (int32(m_int_configs[CONFIG_START_ARENA_POINTS]) < 0)
    {
        LOG_ERROR("server", "StartArenaPoints (%i) must be in range 0..MaxArenaPoints(%u). Set to %u.",
                       m_int_configs[CONFIG_START_ARENA_POINTS], m_int_configs[CONFIG_MAX_ARENA_POINTS], 0);
        m_int_configs[CONFIG_START_ARENA_POINTS] = 0;
    }
    else if (m_int_configs[CONFIG_START_ARENA_POINTS] > m_int_configs[CONFIG_MAX_ARENA_POINTS])
    {
        LOG_ERROR("server", "StartArenaPoints (%i) must be in range 0..MaxArenaPoints(%u). Set to %u.",
                       m_int_configs[CONFIG_START_ARENA_POINTS], m_int_configs[CONFIG_MAX_ARENA_POINTS], m_int_configs[CONFIG_MAX_ARENA_POINTS]);
        m_int_configs[CONFIG_START_ARENA_POINTS] = m_int_configs[CONFIG_MAX_ARENA_POINTS];
    }

    m_int_configs[CONFIG_MAX_RECRUIT_A_FRIEND_BONUS_PLAYER_LEVEL] = sConfigMgr->GetOption<int32>("RecruitAFriend.MaxLevel", 60);
    if (m_int_configs[CONFIG_MAX_RECRUIT_A_FRIEND_BONUS_PLAYER_LEVEL] > m_int_configs[CONFIG_MAX_PLAYER_LEVEL])
    {
        LOG_ERROR("server", "RecruitAFriend.MaxLevel (%i) must be in the range 0..MaxLevel(%u). Set to %u.",
                       m_int_configs[CONFIG_MAX_RECRUIT_A_FRIEND_BONUS_PLAYER_LEVEL], m_int_configs[CONFIG_MAX_PLAYER_LEVEL], 60);
        m_int_configs[CONFIG_MAX_RECRUIT_A_FRIEND_BONUS_PLAYER_LEVEL] = 60;
    }

    m_int_configs[CONFIG_MAX_RECRUIT_A_FRIEND_BONUS_PLAYER_LEVEL_DIFFERENCE] = sConfigMgr->GetOption<int32>("RecruitAFriend.MaxDifference", 4);
    m_bool_configs[CONFIG_ALL_TAXI_PATHS] = sConfigMgr->GetOption<bool>("AllFlightPaths", false);
    m_int_configs[CONFIG_INSTANT_TAXI]    = sConfigMgr->GetOption<int32>("InstantFlightPaths", 0);

    m_bool_configs[CONFIG_INSTANCE_IGNORE_LEVEL]    = sConfigMgr->GetOption<bool>("Instance.IgnoreLevel", false);
    m_bool_configs[CONFIG_INSTANCE_IGNORE_RAID]     = sConfigMgr->GetOption<bool>("Instance.IgnoreRaid", false);
    m_bool_configs[CONFIG_INSTANCE_GMSUMMON_PLAYER] = sConfigMgr->GetOption<bool>("Instance.GMSummonPlayer", false);
    m_bool_configs[CONFIG_INSTANCE_SHARED_ID]       = sConfigMgr->GetOption<bool>("Instance.SharedNormalHeroicId", false);

    m_int_configs[CONFIG_INSTANCE_RESET_TIME_HOUR]               = sConfigMgr->GetOption<int32>("Instance.ResetTimeHour", 4);
    m_int_configs[CONFIG_INSTANCE_RESET_TIME_RELATIVE_TIMESTAMP] = sConfigMgr->GetOption<int32>("Instance.ResetTimeRelativeTimestamp", 1135814400);
    m_int_configs[CONFIG_INSTANCE_UNLOAD_DELAY]                  = sConfigMgr->GetOption<int32>("Instance.UnloadDelay", 30 * MINUTE * IN_MILLISECONDS);

    m_int_configs[CONFIG_MAX_PRIMARY_TRADE_SKILL] = sConfigMgr->GetOption<int32>("MaxPrimaryTradeSkill", 2);
    m_int_configs[CONFIG_MIN_PETITION_SIGNS]      = sConfigMgr->GetOption<int32>("MinPetitionSigns", 9);
    if (m_int_configs[CONFIG_MIN_PETITION_SIGNS] > 9)
    {
        LOG_ERROR("server", "MinPetitionSigns (%i) must be in range 0..9. Set to 9.", m_int_configs[CONFIG_MIN_PETITION_SIGNS]);
        m_int_configs[CONFIG_MIN_PETITION_SIGNS] = 9;
    }

    m_int_configs[CONFIG_GM_LOGIN_STATE]        = sConfigMgr->GetOption<int32>("GM.LoginState", 2);
    m_int_configs[CONFIG_GM_VISIBLE_STATE]      = sConfigMgr->GetOption<int32>("GM.Visible", 2);
    m_int_configs[CONFIG_GM_CHAT]               = sConfigMgr->GetOption<int32>("GM.Chat", 2);
    m_int_configs[CONFIG_GM_WHISPERING_TO]      = sConfigMgr->GetOption<int32>("GM.WhisperingTo", 2);

    m_int_configs[CONFIG_GM_LEVEL_IN_GM_LIST]   = sConfigMgr->GetOption<int32>("GM.InGMList.Level", SEC_ADMINISTRATOR);
    m_int_configs[CONFIG_GM_LEVEL_IN_WHO_LIST]  = sConfigMgr->GetOption<int32>("GM.InWhoList.Level", SEC_ADMINISTRATOR);
    m_int_configs[CONFIG_START_GM_LEVEL]        = sConfigMgr->GetOption<int32>("GM.StartLevel", 1);
    if (m_int_configs[CONFIG_START_GM_LEVEL] < m_int_configs[CONFIG_START_PLAYER_LEVEL])
    {
        LOG_ERROR("server", "GM.StartLevel (%i) must be in range StartPlayerLevel(%u)..%u. Set to %u.",
                       m_int_configs[CONFIG_START_GM_LEVEL], m_int_configs[CONFIG_START_PLAYER_LEVEL], MAX_LEVEL, m_int_configs[CONFIG_START_PLAYER_LEVEL]);
        m_int_configs[CONFIG_START_GM_LEVEL] = m_int_configs[CONFIG_START_PLAYER_LEVEL];
    }
    else if (m_int_configs[CONFIG_START_GM_LEVEL] > MAX_LEVEL)
    {
        LOG_ERROR("server", "GM.StartLevel (%i) must be in range 1..%u. Set to %u.", m_int_configs[CONFIG_START_GM_LEVEL], MAX_LEVEL, MAX_LEVEL);
        m_int_configs[CONFIG_START_GM_LEVEL] = MAX_LEVEL;
    }
    m_bool_configs[CONFIG_ALLOW_GM_GROUP]       = sConfigMgr->GetOption<bool>("GM.AllowInvite", false);
    m_bool_configs[CONFIG_ALLOW_GM_FRIEND]      = sConfigMgr->GetOption<bool>("GM.AllowFriend", false);
    m_bool_configs[CONFIG_GM_LOWER_SECURITY]    = sConfigMgr->GetOption<bool>("GM.LowerSecurity", false);
    m_float_configs[CONFIG_CHANCE_OF_GM_SURVEY] = sConfigMgr->GetOption<float>("GM.TicketSystem.ChanceOfGMSurvey", 50.0f);

    m_int_configs[CONFIG_GROUP_VISIBILITY]      = sConfigMgr->GetOption<int32>("Visibility.GroupMode", 1);

    m_int_configs[CONFIG_MAIL_DELIVERY_DELAY]   = sConfigMgr->GetOption<int32>("MailDeliveryDelay", HOUR);

    m_int_configs[CONFIG_UPTIME_UPDATE]         = sConfigMgr->GetOption<int32>("UpdateUptimeInterval", 10);
    if (int32(m_int_configs[CONFIG_UPTIME_UPDATE]) <= 0)
    {
        LOG_ERROR("server", "UpdateUptimeInterval (%i) must be > 0, set to default 10.", m_int_configs[CONFIG_UPTIME_UPDATE]);
        m_int_configs[CONFIG_UPTIME_UPDATE] = 1;
    }

    if (reload)
    {
        m_timers[WUPDATE_UPTIME].SetInterval(m_int_configs[CONFIG_UPTIME_UPDATE]*MINUTE * IN_MILLISECONDS);
        m_timers[WUPDATE_UPTIME].Reset();
    }

    // log db cleanup interval
    m_int_configs[CONFIG_LOGDB_CLEARINTERVAL] = sConfigMgr->GetOption<int32>("LogDB.Opt.ClearInterval", 10);
    if (int32(m_int_configs[CONFIG_LOGDB_CLEARINTERVAL]) <= 0)
    {
        LOG_ERROR("server", "LogDB.Opt.ClearInterval (%i) must be > 0, set to default 10.", m_int_configs[CONFIG_LOGDB_CLEARINTERVAL]);
        m_int_configs[CONFIG_LOGDB_CLEARINTERVAL] = 10;
    }
    if (reload)
    {
        m_timers[WUPDATE_CLEANDB].SetInterval(m_int_configs[CONFIG_LOGDB_CLEARINTERVAL] * MINUTE * IN_MILLISECONDS);
        m_timers[WUPDATE_CLEANDB].Reset();
    }
    m_int_configs[CONFIG_LOGDB_CLEARTIME] = sConfigMgr->GetOption<int32>("LogDB.Opt.ClearTime", 1209600); // 14 days default
    LOG_INFO("server", "Will clear `logs` table of entries older than %i seconds every %u minutes.",
                    m_int_configs[CONFIG_LOGDB_CLEARTIME], m_int_configs[CONFIG_LOGDB_CLEARINTERVAL]);

    m_int_configs[CONFIG_TELEPORT_TIMEOUT_NEAR]             = sConfigMgr->GetOption<int32>("TeleportTimeoutNear", 25); // pussywizard
    m_int_configs[CONFIG_TELEPORT_TIMEOUT_FAR]              = sConfigMgr->GetOption<int32>("TeleportTimeoutFar", 45); // pussywizard
    m_int_configs[CONFIG_MAX_ALLOWED_MMR_DROP]              = sConfigMgr->GetOption<int32>("MaxAllowedMMRDrop", 500); // pussywizard
    m_bool_configs[CONFIG_ENABLE_LOGIN_AFTER_DC]            = sConfigMgr->GetOption<bool>("EnableLoginAfterDC", true); // pussywizard
    m_bool_configs[CONFIG_DONT_CACHE_RANDOM_MOVEMENT_PATHS] = sConfigMgr->GetOption<bool>("DontCacheRandomMovementPaths", true); // pussywizard

    m_int_configs[CONFIG_SKILL_CHANCE_ORANGE] = sConfigMgr->GetOption<int32>("SkillChance.Orange", 100);
    m_int_configs[CONFIG_SKILL_CHANCE_YELLOW] = sConfigMgr->GetOption<int32>("SkillChance.Yellow", 75);
    m_int_configs[CONFIG_SKILL_CHANCE_GREEN]  = sConfigMgr->GetOption<int32>("SkillChance.Green", 25);
    m_int_configs[CONFIG_SKILL_CHANCE_GREY]   = sConfigMgr->GetOption<int32>("SkillChance.Grey", 0);

    m_int_configs[CONFIG_SKILL_CHANCE_MINING_STEPS]     = sConfigMgr->GetOption<int32>("SkillChance.MiningSteps", 75);
    m_int_configs[CONFIG_SKILL_CHANCE_SKINNING_STEPS]   = sConfigMgr->GetOption<int32>("SkillChance.SkinningSteps", 75);

    m_bool_configs[CONFIG_SKILL_PROSPECTING] = sConfigMgr->GetOption<bool>("SkillChance.Prospecting", false);
    m_bool_configs[CONFIG_SKILL_MILLING]     = sConfigMgr->GetOption<bool>("SkillChance.Milling", false);

    m_int_configs[CONFIG_SKILL_GAIN_CRAFTING] = sConfigMgr->GetOption<int32>("SkillGain.Crafting", 1);

    m_int_configs[CONFIG_SKILL_GAIN_DEFENSE] = sConfigMgr->GetOption<int32>("SkillGain.Defense", 1);

    m_int_configs[CONFIG_SKILL_GAIN_GATHERING] = sConfigMgr->GetOption<int32>("SkillGain.Gathering", 1);

    m_int_configs[CONFIG_SKILL_GAIN_WEAPON] = sConfigMgr->GetOption<int32>("SkillGain.Weapon", 1);

    m_int_configs[CONFIG_MAX_OVERSPEED_PINGS] = sConfigMgr->GetOption<int32>("MaxOverspeedPings", 2);
    if (m_int_configs[CONFIG_MAX_OVERSPEED_PINGS] != 0 && m_int_configs[CONFIG_MAX_OVERSPEED_PINGS] < 2)
    {
        LOG_ERROR("server", "MaxOverspeedPings (%i) must be in range 2..infinity (or 0 to disable check). Set to 2.", m_int_configs[CONFIG_MAX_OVERSPEED_PINGS]);
        m_int_configs[CONFIG_MAX_OVERSPEED_PINGS] = 2;
    }

    m_bool_configs[CONFIG_SAVE_RESPAWN_TIME_IMMEDIATELY] = sConfigMgr->GetOption<bool>("SaveRespawnTimeImmediately", true);
    m_bool_configs[CONFIG_WEATHER]                       = sConfigMgr->GetOption<bool>("ActivateWeather", true);

    m_int_configs[CONFIG_DISABLE_BREATHING] = sConfigMgr->GetOption<int32>("DisableWaterBreath", SEC_CONSOLE);

    m_bool_configs[CONFIG_ALWAYS_MAX_SKILL_FOR_LEVEL] = sConfigMgr->GetOption<bool>("AlwaysMaxSkillForLevel", false);

    if (reload)
    {
        uint32 val = sConfigMgr->GetOption<int32>("Expansion", 2);
        if (val != m_int_configs[CONFIG_EXPANSION])
            LOG_ERROR("server", "Expansion option can't be changed at worldserver.conf reload, using current value (%u).", m_int_configs[CONFIG_EXPANSION]);
    }
    else
        m_int_configs[CONFIG_EXPANSION] = sConfigMgr->GetOption<int32>("Expansion", 2);

    m_int_configs[CONFIG_CHATFLOOD_MESSAGE_COUNT]    = sConfigMgr->GetOption<int32>("ChatFlood.MessageCount", 10);
    m_int_configs[CONFIG_CHATFLOOD_MESSAGE_DELAY]    = sConfigMgr->GetOption<int32>("ChatFlood.MessageDelay", 1);
    m_int_configs[CONFIG_CHATFLOOD_MUTE_TIME]        = sConfigMgr->GetOption<int32>("ChatFlood.MuteTime", 10);
    m_bool_configs[CONFIG_CHAT_MUTE_FIRST_LOGIN]     = sConfigMgr->GetOption<bool>("Chat.MuteFirstLogin", false);
    m_int_configs[CONFIG_CHAT_TIME_MUTE_FIRST_LOGIN] = sConfigMgr->GetOption<int32>("Chat.MuteTimeFirstLogin", 120);

    m_int_configs[CONFIG_EVENT_ANNOUNCE] = sConfigMgr->GetOption<int32>("Event.Announce", 0);

    m_float_configs[CONFIG_CREATURE_FAMILY_FLEE_ASSISTANCE_RADIUS] = sConfigMgr->GetOption<float>("CreatureFamilyFleeAssistanceRadius", 30.0f);
    m_float_configs[CONFIG_CREATURE_FAMILY_ASSISTANCE_RADIUS]      = sConfigMgr->GetOption<float>("CreatureFamilyAssistanceRadius", 10.0f);
    m_int_configs[CONFIG_CREATURE_FAMILY_ASSISTANCE_DELAY]         = sConfigMgr->GetOption<int32>("CreatureFamilyAssistanceDelay", 2000);
    m_int_configs[CONFIG_CREATURE_FAMILY_ASSISTANCE_PERIOD]        = sConfigMgr->GetOption<int32>("CreatureFamilyAssistancePeriod", 3000);
    m_int_configs[CONFIG_CREATURE_FAMILY_FLEE_DELAY]               = sConfigMgr->GetOption<int32>("CreatureFamilyFleeDelay", 7000);

    m_int_configs[CONFIG_WORLD_BOSS_LEVEL_DIFF] = sConfigMgr->GetOption<int32>("WorldBossLevelDiff", 3);

    m_bool_configs[CONFIG_QUEST_ENABLE_QUEST_TRACKER] = sConfigMgr->GetOption<bool>("Quests.EnableQuestTracker", false);

    // note: disable value (-1) will assigned as 0xFFFFFFF, to prevent overflow at calculations limit it to max possible player level MAX_LEVEL(100)
    m_int_configs[CONFIG_QUEST_LOW_LEVEL_HIDE_DIFF] = sConfigMgr->GetOption<int32>("Quests.LowLevelHideDiff", 4);
    if (m_int_configs[CONFIG_QUEST_LOW_LEVEL_HIDE_DIFF] > MAX_LEVEL)
        m_int_configs[CONFIG_QUEST_LOW_LEVEL_HIDE_DIFF] = MAX_LEVEL;
    m_int_configs[CONFIG_QUEST_HIGH_LEVEL_HIDE_DIFF] = sConfigMgr->GetOption<int32>("Quests.HighLevelHideDiff", 7);
    if (m_int_configs[CONFIG_QUEST_HIGH_LEVEL_HIDE_DIFF] > MAX_LEVEL)
        m_int_configs[CONFIG_QUEST_HIGH_LEVEL_HIDE_DIFF] = MAX_LEVEL;
    m_bool_configs[CONFIG_QUEST_IGNORE_RAID]          = sConfigMgr->GetOption<bool>("Quests.IgnoreRaid", false);
    m_bool_configs[CONFIG_QUEST_IGNORE_AUTO_ACCEPT]   = sConfigMgr->GetOption<bool>("Quests.IgnoreAutoAccept", false);
    m_bool_configs[CONFIG_QUEST_IGNORE_AUTO_COMPLETE] = sConfigMgr->GetOption<bool>("Quests.IgnoreAutoComplete", false);

    m_int_configs[CONFIG_RANDOM_BG_RESET_HOUR] = sConfigMgr->GetOption<int32>("Battleground.Random.ResetHour", 6);
    if (m_int_configs[CONFIG_RANDOM_BG_RESET_HOUR] > 23)
    {
        LOG_ERROR("server", "Battleground.Random.ResetHour (%i) can't be load. Set to 6.", m_int_configs[CONFIG_RANDOM_BG_RESET_HOUR]);
        m_int_configs[CONFIG_RANDOM_BG_RESET_HOUR] = 6;
    }

    m_int_configs[CONFIG_CALENDAR_DELETE_OLD_EVENTS_HOUR] = sConfigMgr->GetOption<int32>("Calendar.DeleteOldEventsHour", 6);
    if (m_int_configs[CONFIG_CALENDAR_DELETE_OLD_EVENTS_HOUR] > 23)
    {
        LOG_ERROR("server", "Calendar.DeleteOldEventsHour (%i) can't be load. Set to 6.", m_int_configs[CONFIG_CALENDAR_DELETE_OLD_EVENTS_HOUR]);
        m_int_configs[CONFIG_CALENDAR_DELETE_OLD_EVENTS_HOUR] = 6;
    }

    m_int_configs[CONFIG_GUILD_RESET_HOUR] = sConfigMgr->GetOption<int32>("Guild.ResetHour", 6);
    if (m_int_configs[CONFIG_GUILD_RESET_HOUR] > 23)
    {
        LOG_ERROR("server", "Guild.ResetHour (%i) can't be load. Set to 6.", m_int_configs[CONFIG_GUILD_RESET_HOUR]);
        m_int_configs[CONFIG_GUILD_RESET_HOUR] = 6;
    }

    m_int_configs[CONFIG_GUILD_BANK_INITIAL_TABS] = sConfigMgr->GetOption<int32>("Guild.BankInitialTabs", 0);
    m_int_configs[CONFIG_GUILD_BANK_TAB_COST_0] = sConfigMgr->GetOption<int32>("Guild.BankTabCost0", 1000000);
    m_int_configs[CONFIG_GUILD_BANK_TAB_COST_1] = sConfigMgr->GetOption<int32>("Guild.BankTabCost1", 2500000);
    m_int_configs[CONFIG_GUILD_BANK_TAB_COST_2] = sConfigMgr->GetOption<int32>("Guild.BankTabCost2", 5000000);
    m_int_configs[CONFIG_GUILD_BANK_TAB_COST_3] = sConfigMgr->GetOption<int32>("Guild.BankTabCost3", 10000000);
    m_int_configs[CONFIG_GUILD_BANK_TAB_COST_4] = sConfigMgr->GetOption<int32>("Guild.BankTabCost4", 25000000);
    m_int_configs[CONFIG_GUILD_BANK_TAB_COST_5] = sConfigMgr->GetOption<int32>("Guild.BankTabCost5", 50000000);

    m_bool_configs[CONFIG_DETECT_POS_COLLISION] = sConfigMgr->GetOption<bool>("DetectPosCollision", true);

    m_bool_configs[CONFIG_RESTRICTED_LFG_CHANNEL]      = sConfigMgr->GetOption<bool>("Channel.RestrictedLfg", true);
    m_bool_configs[CONFIG_SILENTLY_GM_JOIN_TO_CHANNEL] = sConfigMgr->GetOption<bool>("Channel.SilentlyGMJoin", false);

    m_bool_configs[CONFIG_TALENTS_INSPECTING]                = sConfigMgr->GetOption<bool>("TalentsInspecting", true);
    m_bool_configs[CONFIG_CHAT_FAKE_MESSAGE_PREVENTING]      = sConfigMgr->GetOption<bool>("ChatFakeMessagePreventing", false);
    m_int_configs[CONFIG_CHAT_STRICT_LINK_CHECKING_SEVERITY] = sConfigMgr->GetOption<int32>("ChatStrictLinkChecking.Severity", 0);
    m_int_configs[CONFIG_CHAT_STRICT_LINK_CHECKING_KICK]     = sConfigMgr->GetOption<int32>("ChatStrictLinkChecking.Kick", 0);

    m_int_configs[CONFIG_CORPSE_DECAY_NORMAL]    = sConfigMgr->GetOption<int32>("Corpse.Decay.NORMAL", 60);
    m_int_configs[CONFIG_CORPSE_DECAY_RARE]      = sConfigMgr->GetOption<int32>("Corpse.Decay.RARE", 300);
    m_int_configs[CONFIG_CORPSE_DECAY_ELITE]     = sConfigMgr->GetOption<int32>("Corpse.Decay.ELITE", 300);
    m_int_configs[CONFIG_CORPSE_DECAY_RAREELITE] = sConfigMgr->GetOption<int32>("Corpse.Decay.RAREELITE", 300);
    m_int_configs[CONFIG_CORPSE_DECAY_WORLDBOSS] = sConfigMgr->GetOption<int32>("Corpse.Decay.WORLDBOSS", 3600);

    m_int_configs[CONFIG_DEATH_SICKNESS_LEVEL]            = sConfigMgr->GetOption<int32> ("Death.SicknessLevel", 11);
    m_bool_configs[CONFIG_DEATH_CORPSE_RECLAIM_DELAY_PVP] = sConfigMgr->GetOption<bool>("Death.CorpseReclaimDelay.PvP", true);
    m_bool_configs[CONFIG_DEATH_CORPSE_RECLAIM_DELAY_PVE] = sConfigMgr->GetOption<bool>("Death.CorpseReclaimDelay.PvE", true);
    m_bool_configs[CONFIG_DEATH_BONES_WORLD]              = sConfigMgr->GetOption<bool>("Death.Bones.World", true);
    m_bool_configs[CONFIG_DEATH_BONES_BG_OR_ARENA]        = sConfigMgr->GetOption<bool>("Death.Bones.BattlegroundOrArena", true);

    m_bool_configs[CONFIG_DIE_COMMAND_MODE] = sConfigMgr->GetOption<bool>("Die.Command.Mode", true);

    // always use declined names in the russian client
    m_bool_configs[CONFIG_DECLINED_NAMES_USED] =
        (m_int_configs[CONFIG_REALM_ZONE] == REALM_ZONE_RUSSIAN) ? true : sConfigMgr->GetOption<bool>("DeclinedNames", false);

    m_float_configs[CONFIG_LISTEN_RANGE_SAY]       = sConfigMgr->GetOption<float>("ListenRange.Say", 25.0f);
    m_float_configs[CONFIG_LISTEN_RANGE_TEXTEMOTE] = sConfigMgr->GetOption<float>("ListenRange.TextEmote", 25.0f);
    m_float_configs[CONFIG_LISTEN_RANGE_YELL]      = sConfigMgr->GetOption<float>("ListenRange.Yell", 300.0f);

    m_bool_configs[CONFIG_BATTLEGROUND_DISABLE_QUEST_SHARE_IN_BG]           = sConfigMgr->GetOption<bool>("Battleground.DisableQuestShareInBG", false);
    m_bool_configs[CONFIG_BATTLEGROUND_DISABLE_READY_CHECK_IN_BG]           = sConfigMgr->GetOption<bool>("Battleground.DisableReadyCheckInBG", false);
    m_bool_configs[CONFIG_BATTLEGROUND_CAST_DESERTER]                       = sConfigMgr->GetOption<bool>("Battleground.CastDeserter", true);
    m_bool_configs[CONFIG_BATTLEGROUND_QUEUE_ANNOUNCER_ENABLE]              = sConfigMgr->GetOption<bool>("Battleground.QueueAnnouncer.Enable", false);
    m_int_configs[CONFIG_BATTLEGROUND_QUEUE_ANNOUNCER_LIMIT_MIN_LEVEL]      = sConfigMgr->GetOption<uint32>("Battleground.QueueAnnouncer.Limit.MinLevel", 0);
    m_int_configs[CONFIG_BATTLEGROUND_QUEUE_ANNOUNCER_LIMIT_MIN_PLAYERS]    = sConfigMgr->GetOption<uint32>("Battleground.QueueAnnouncer.Limit.MinPlayers", 3);
    m_int_configs[CONFIG_BATTLEGROUND_QUEUE_ANNOUNCER_SPAM_DELAY]           = sConfigMgr->GetOption<uint32>("Battleground.QueueAnnouncer.SpamProtection.Delay", 30);
    m_bool_configs[CONFIG_BATTLEGROUND_QUEUE_ANNOUNCER_PLAYERONLY]          = sConfigMgr->GetOption<bool>("Battleground.QueueAnnouncer.PlayerOnly", false);
    m_bool_configs[CONFIG_BATTLEGROUND_STORE_STATISTICS_ENABLE]             = sConfigMgr->GetOption<bool>("Battleground.StoreStatistics.Enable", false);
    m_bool_configs[CONFIG_BATTLEGROUND_TRACK_DESERTERS]                     = sConfigMgr->GetOption<bool>("Battleground.TrackDeserters.Enable", false);
    m_int_configs[CONFIG_BATTLEGROUND_PREMATURE_FINISH_TIMER]               = sConfigMgr->GetOption<int32> ("Battleground.PrematureFinishTimer", 5 * MINUTE * IN_MILLISECONDS);
    m_int_configs[CONFIG_BATTLEGROUND_INVITATION_TYPE]                      = sConfigMgr->GetOption<int32>("Battleground.InvitationType", 0);
    m_int_configs[CONFIG_BATTLEGROUND_PREMADE_GROUP_WAIT_FOR_MATCH]         = sConfigMgr->GetOption<int32> ("Battleground.PremadeGroupWaitForMatch", 30 * MINUTE * IN_MILLISECONDS);
    m_bool_configs[CONFIG_BG_XP_FOR_KILL]                                   = sConfigMgr->GetOption<bool>("Battleground.GiveXPForKills", false);
    m_int_configs[CONFIG_BATTLEGROUND_REPORT_AFK_TIMER]                     = sConfigMgr->GetOption<int32>("Battleground.ReportAFK.Timer", 4);
    m_int_configs[CONFIG_BATTLEGROUND_REPORT_AFK]                           = sConfigMgr->GetOption<int32>("Battleground.ReportAFK", 3);
    if (m_int_configs[CONFIG_BATTLEGROUND_REPORT_AFK] < 1)
    {
        LOG_ERROR("server", "Battleground.ReportAFK (%d) must be >0. Using 3 instead.", m_int_configs[CONFIG_BATTLEGROUND_REPORT_AFK]);
        m_int_configs[CONFIG_BATTLEGROUND_REPORT_AFK] = 3;
    }
    else if (m_int_configs[CONFIG_BATTLEGROUND_REPORT_AFK] > 9)
    {
        LOG_ERROR("server", "Battleground.ReportAFK (%d) must be <10. Using 3 instead.", m_int_configs[CONFIG_BATTLEGROUND_REPORT_AFK]);
        m_int_configs[CONFIG_BATTLEGROUND_REPORT_AFK] = 3;
    }
    m_int_configs[CONFIG_BATTLEGROUND_PLAYER_RESPAWN]        = sConfigMgr->GetOption<int32>("Battleground.PlayerRespawn", 30);
    if (m_int_configs[CONFIG_BATTLEGROUND_PLAYER_RESPAWN] < 3)
    {
        LOG_ERROR("server", "Battleground.PlayerRespawn (%i) must be >2. Using 30 instead.", m_int_configs[CONFIG_BATTLEGROUND_PLAYER_RESPAWN]);
        m_int_configs[CONFIG_BATTLEGROUND_PLAYER_RESPAWN] = 30;
    }
    m_int_configs[CONFIG_BATTLEGROUND_BUFF_RESPAWN]        = sConfigMgr->GetOption<int32>("Battleground.BuffRespawn", 180);
    if (m_int_configs[CONFIG_BATTLEGROUND_BUFF_RESPAWN] < 1)
    {
        LOG_ERROR("server", "Battleground.BuffRespawn (%i) must be >0. Using 180 instead.", m_int_configs[CONFIG_BATTLEGROUND_BUFF_RESPAWN]);
        m_int_configs[CONFIG_BATTLEGROUND_BUFF_RESPAWN] = 180;
    }

    m_int_configs[CONFIG_ARENA_MAX_RATING_DIFFERENCE]                = sConfigMgr->GetOption<int32> ("Arena.MaxRatingDifference", 150);
    m_int_configs[CONFIG_ARENA_RATING_DISCARD_TIMER]                 = sConfigMgr->GetOption<int32> ("Arena.RatingDiscardTimer", 10 * MINUTE * IN_MILLISECONDS);
    m_bool_configs[CONFIG_ARENA_AUTO_DISTRIBUTE_POINTS]              = sConfigMgr->GetOption<bool>("Arena.AutoDistributePoints", false);
    m_int_configs[CONFIG_ARENA_AUTO_DISTRIBUTE_INTERVAL_DAYS]        = sConfigMgr->GetOption<int32> ("Arena.AutoDistributeInterval", 7); // pussywizard: spoiled by implementing constant day and hour, always 7 now
    m_int_configs[CONFIG_ARENA_GAMES_REQUIRED]                       = sConfigMgr->GetOption<int32> ("Arena.GamesRequired", 10);
    m_int_configs[CONFIG_ARENA_SEASON_ID]                            = sConfigMgr->GetOption<int32> ("Arena.ArenaSeason.ID", 1);
    m_int_configs[CONFIG_ARENA_START_RATING]                         = sConfigMgr->GetOption<int32> ("Arena.ArenaStartRating", 0);
    m_int_configs[CONFIG_ARENA_START_PERSONAL_RATING]                = sConfigMgr->GetOption<int32> ("Arena.ArenaStartPersonalRating", 1000);
    m_int_configs[CONFIG_ARENA_START_MATCHMAKER_RATING]              = sConfigMgr->GetOption<int32> ("Arena.ArenaStartMatchmakerRating", 1500);
    m_bool_configs[CONFIG_ARENA_SEASON_IN_PROGRESS]                  = sConfigMgr->GetOption<bool>("Arena.ArenaSeason.InProgress", true);
    m_float_configs[CONFIG_ARENA_WIN_RATING_MODIFIER_1]              = sConfigMgr->GetOption<float>("Arena.ArenaWinRatingModifier1", 48.0f);
    m_float_configs[CONFIG_ARENA_WIN_RATING_MODIFIER_2]              = sConfigMgr->GetOption<float>("Arena.ArenaWinRatingModifier2", 24.0f);
    m_float_configs[CONFIG_ARENA_LOSE_RATING_MODIFIER]               = sConfigMgr->GetOption<float>("Arena.ArenaLoseRatingModifier", 24.0f);
    m_float_configs[CONFIG_ARENA_MATCHMAKER_RATING_MODIFIER]         = sConfigMgr->GetOption<float>("Arena.ArenaMatchmakerRatingModifier", 24.0f);
    m_bool_configs[CONFIG_ARENA_QUEUE_ANNOUNCER_ENABLE]              = sConfigMgr->GetOption<bool> ("Arena.QueueAnnouncer.Enable", false);
    m_bool_configs[CONFIG_ARENA_QUEUE_ANNOUNCER_PLAYERONLY]          = sConfigMgr->GetOption<bool> ("Arena.QueueAnnouncer.PlayerOnly", false);

    m_bool_configs[CONFIG_OFFHAND_CHECK_AT_SPELL_UNLEARN]            = sConfigMgr->GetOption<bool>("OffhandCheckAtSpellUnlearn", true);

    if (int32 clientCacheId = sConfigMgr->GetOption<int32>("ClientCacheVersion", 0))
    {
        // overwrite DB/old value
        if (clientCacheId > 0)
        {
            m_int_configs[CONFIG_CLIENTCACHE_VERSION] = clientCacheId;
            LOG_INFO("server", "Client cache version set to: %u", clientCacheId);
        }
        else
            LOG_ERROR("server", "ClientCacheVersion can't be negative %d, ignored.", clientCacheId);
    }

    m_int_configs[CONFIG_INSTANT_LOGOUT] = sConfigMgr->GetOption<int32>("InstantLogout", SEC_MODERATOR);

    m_int_configs[CONFIG_GUILD_EVENT_LOG_COUNT] = sConfigMgr->GetOption<int32>("Guild.EventLogRecordsCount", GUILD_EVENTLOG_MAX_RECORDS);
    if (m_int_configs[CONFIG_GUILD_EVENT_LOG_COUNT] > GUILD_EVENTLOG_MAX_RECORDS)
        m_int_configs[CONFIG_GUILD_EVENT_LOG_COUNT] = GUILD_EVENTLOG_MAX_RECORDS;
    m_int_configs[CONFIG_GUILD_BANK_EVENT_LOG_COUNT] = sConfigMgr->GetOption<int32>("Guild.BankEventLogRecordsCount", GUILD_BANKLOG_MAX_RECORDS);
    if (m_int_configs[CONFIG_GUILD_BANK_EVENT_LOG_COUNT] > GUILD_BANKLOG_MAX_RECORDS)
        m_int_configs[CONFIG_GUILD_BANK_EVENT_LOG_COUNT] = GUILD_BANKLOG_MAX_RECORDS;

    //visibility on continents
    m_MaxVisibleDistanceOnContinents = sConfigMgr->GetOption<float>("Visibility.Distance.Continents", DEFAULT_VISIBILITY_DISTANCE);
    if (m_MaxVisibleDistanceOnContinents < 45 * sWorld->getRate(RATE_CREATURE_AGGRO))
    {
        LOG_ERROR("server", "Visibility.Distance.Continents can't be less max aggro radius %f", 45 * sWorld->getRate(RATE_CREATURE_AGGRO));
        m_MaxVisibleDistanceOnContinents = 45 * sWorld->getRate(RATE_CREATURE_AGGRO);
    }
    else if (m_MaxVisibleDistanceOnContinents > MAX_VISIBILITY_DISTANCE)
    {
        LOG_ERROR("server", "Visibility.Distance.Continents can't be greater %f", MAX_VISIBILITY_DISTANCE);
        m_MaxVisibleDistanceOnContinents = MAX_VISIBILITY_DISTANCE;
    }

    //visibility in instances
    m_MaxVisibleDistanceInInstances = sConfigMgr->GetOption<float>("Visibility.Distance.Instances", DEFAULT_VISIBILITY_INSTANCE);
    if (m_MaxVisibleDistanceInInstances < 45 * sWorld->getRate(RATE_CREATURE_AGGRO))
    {
        LOG_ERROR("server", "Visibility.Distance.Instances can't be less max aggro radius %f", 45 * sWorld->getRate(RATE_CREATURE_AGGRO));
        m_MaxVisibleDistanceInInstances = 45 * sWorld->getRate(RATE_CREATURE_AGGRO);
    }
    else if (m_MaxVisibleDistanceInInstances > MAX_VISIBILITY_DISTANCE)
    {
        LOG_ERROR("server", "Visibility.Distance.Instances can't be greater %f", MAX_VISIBILITY_DISTANCE);
        m_MaxVisibleDistanceInInstances = MAX_VISIBILITY_DISTANCE;
    }

    //visibility in BG/Arenas
    m_MaxVisibleDistanceInBGArenas = sConfigMgr->GetOption<float>("Visibility.Distance.BGArenas", DEFAULT_VISIBILITY_BGARENAS);
    if (m_MaxVisibleDistanceInBGArenas < 45 * sWorld->getRate(RATE_CREATURE_AGGRO))
    {
        LOG_ERROR("server", "Visibility.Distance.BGArenas can't be less max aggro radius %f", 45 * sWorld->getRate(RATE_CREATURE_AGGRO));
        m_MaxVisibleDistanceInBGArenas = 45 * sWorld->getRate(RATE_CREATURE_AGGRO);
    }
    else if (m_MaxVisibleDistanceInBGArenas > MAX_VISIBILITY_DISTANCE)
    {
        LOG_ERROR("server", "Visibility.Distance.BGArenas can't be greater %f", MAX_VISIBILITY_DISTANCE);
        m_MaxVisibleDistanceInBGArenas = MAX_VISIBILITY_DISTANCE;
    }

    ///- Load the CharDelete related config options
    m_int_configs[CONFIG_CHARDELETE_METHOD]    = sConfigMgr->GetOption<int32>("CharDelete.Method", 0);
    m_int_configs[CONFIG_CHARDELETE_MIN_LEVEL] = sConfigMgr->GetOption<int32>("CharDelete.MinLevel", 0);
    m_int_configs[CONFIG_CHARDELETE_KEEP_DAYS] = sConfigMgr->GetOption<int32>("CharDelete.KeepDays", 30);

    ///- Load the ItemDelete related config options
    m_bool_configs[CONFIG_ITEMDELETE_METHOD]    = sConfigMgr->GetOption<bool>("ItemDelete.Method", 0);
    m_bool_configs[CONFIG_ITEMDELETE_VENDOR]    = sConfigMgr->GetOption<bool>("ItemDelete.Vendor", 0);
    m_int_configs[CONFIG_ITEMDELETE_QUALITY]    = sConfigMgr->GetOption<int32>("ItemDelete.Quality", 3);
    m_int_configs[CONFIG_ITEMDELETE_ITEM_LEVEL] = sConfigMgr->GetOption<int32>("ItemDelete.ItemLevel", 80);

    m_int_configs[CONFIG_FFA_PVP_TIMER] = sConfigMgr->GetOption<int32>("FFAPvPTimer", 30);

    ///- Read the "Data" directory from the config file
    std::string dataPath = sConfigMgr->GetOption<std::string>("DataDir", "./");
    if (dataPath.empty() || (dataPath.at(dataPath.length() - 1) != '/' && dataPath.at(dataPath.length() - 1) != '\\'))
        dataPath.push_back('/');

#if AC_PLATFORM == AC_PLATFORM_UNIX || AC_PLATFORM == AC_PLATFORM_APPLE
    if (dataPath[0] == '~')
    {
        const char* home = getenv("HOME");
        if (home)
            dataPath.replace(0, 1, home);
    }
#endif

    if (reload)
    {
        if (dataPath != m_dataPath)
            LOG_ERROR("server", "DataDir option can't be changed at worldserver.conf reload, using current value (%s).", m_dataPath.c_str());
    }
    else
    {
        m_dataPath = dataPath;
        LOG_INFO("server", "Using DataDir %s", m_dataPath.c_str());
    }

    m_bool_configs[CONFIG_VMAP_INDOOR_CHECK] = sConfigMgr->GetOption<bool>("vmap.enableIndoorCheck", 0);
    bool enableIndoor = sConfigMgr->GetOption<bool>("vmap.enableIndoorCheck", true);
    bool enableLOS = sConfigMgr->GetOption<bool>("vmap.enableLOS", true);
    bool enableHeight = sConfigMgr->GetOption<bool>("vmap.enableHeight", true);
    bool enablePetLOS = sConfigMgr->GetOption<bool>("vmap.petLOS", true);

    if (!enableHeight)
        LOG_ERROR("server", "VMap height checking disabled! Creatures movements and other various things WILL be broken! Expect no support.");

    VMAP::VMapFactory::createOrGetVMapManager()->setEnableLineOfSightCalc(enableLOS);
    VMAP::VMapFactory::createOrGetVMapManager()->setEnableHeightCalc(enableHeight);
    LOG_INFO("server", "WORLD: VMap support included. LineOfSight:%i, getHeight:%i, indoorCheck:%i PetLOS:%i", enableLOS, enableHeight, enableIndoor, enablePetLOS);

    m_bool_configs[CONFIG_PET_LOS]          = sConfigMgr->GetOption<bool>("vmap.petLOS", true);
    m_bool_configs[CONFIG_START_ALL_SPELLS]   = sConfigMgr->GetOption<bool>("PlayerStart.CustomSpells", false);
    m_int_configs[CONFIG_HONOR_AFTER_DUEL]    = sConfigMgr->GetOption<int32>("HonorPointsAfterDuel", 0);
    m_bool_configs[CONFIG_START_ALL_EXPLORED] = sConfigMgr->GetOption<bool>("PlayerStart.MapsExplored", false);
    m_bool_configs[CONFIG_START_ALL_REP]      = sConfigMgr->GetOption<bool>("PlayerStart.AllReputation", false);
    m_bool_configs[CONFIG_ALWAYS_MAXSKILL]    = sConfigMgr->GetOption<bool>("AlwaysMaxWeaponSkill", false);
    m_bool_configs[CONFIG_PVP_TOKEN_ENABLE]   = sConfigMgr->GetOption<bool>("PvPToken.Enable", false);
    m_int_configs[CONFIG_PVP_TOKEN_MAP_TYPE]  = sConfigMgr->GetOption<int32>("PvPToken.MapAllowType", 4);
    m_int_configs[CONFIG_PVP_TOKEN_ID]        = sConfigMgr->GetOption<int32>("PvPToken.ItemID", 29434);
    m_int_configs[CONFIG_PVP_TOKEN_COUNT]     = sConfigMgr->GetOption<int32>("PvPToken.ItemCount", 1);
    if (m_int_configs[CONFIG_PVP_TOKEN_COUNT] < 1)
        m_int_configs[CONFIG_PVP_TOKEN_COUNT] = 1;

    m_bool_configs[CONFIG_NO_RESET_TALENT_COST]       = sConfigMgr->GetOption<bool>("NoResetTalentsCost", false);
    m_int_configs[CONFIG_TOGGLE_XP_COST]              = sConfigMgr->GetOption<int32>("ToggleXP.Cost", 100000);
    m_bool_configs[CONFIG_SHOW_KICK_IN_WORLD]         = sConfigMgr->GetOption<bool>("ShowKickInWorld", false);
    m_bool_configs[CONFIG_SHOW_MUTE_IN_WORLD]         = sConfigMgr->GetOption<bool>("ShowMuteInWorld", false);
    m_bool_configs[CONFIG_SHOW_BAN_IN_WORLD]          = sConfigMgr->GetOption<bool>("ShowBanInWorld", false);
    m_int_configs[CONFIG_INTERVAL_LOG_UPDATE]         = sConfigMgr->GetOption<int32>("RecordUpdateTimeDiffInterval", 300000);
    m_int_configs[CONFIG_MIN_LOG_UPDATE]              = sConfigMgr->GetOption<int32>("MinRecordUpdateTimeDiff", 100);
    m_int_configs[CONFIG_NUMTHREADS]                  = sConfigMgr->GetOption<int32>("MapUpdate.Threads", 1);
    m_int_configs[CONFIG_MAX_RESULTS_LOOKUP_COMMANDS] = sConfigMgr->GetOption<int32>("Command.LookupMaxResults", 0);

    // Warden
    m_bool_configs[CONFIG_WARDEN_ENABLED]              = sConfigMgr->GetOption<bool>("Warden.Enabled", true);
    m_int_configs[CONFIG_WARDEN_NUM_MEM_CHECKS]        = sConfigMgr->GetOption<int32>("Warden.NumMemChecks", 3);
    m_int_configs[CONFIG_WARDEN_NUM_LUA_CHECKS]        = sConfigMgr->GetOption<int32>("Warden.NumLuaChecks", 1);
    m_int_configs[CONFIG_WARDEN_NUM_OTHER_CHECKS]      = sConfigMgr->GetOption<int32>("Warden.NumOtherChecks", 7);
    m_int_configs[CONFIG_WARDEN_CLIENT_BAN_DURATION]   = sConfigMgr->GetOption<int32>("Warden.BanDuration", 86400);
    m_int_configs[CONFIG_WARDEN_CLIENT_CHECK_HOLDOFF]  = sConfigMgr->GetOption<int32>("Warden.ClientCheckHoldOff", 30);
    m_int_configs[CONFIG_WARDEN_CLIENT_FAIL_ACTION]    = sConfigMgr->GetOption<int32>("Warden.ClientCheckFailAction", 0);
    m_int_configs[CONFIG_WARDEN_CLIENT_RESPONSE_DELAY] = sConfigMgr->GetOption<int32>("Warden.ClientResponseDelay", 600);

    // Dungeon finder
    m_int_configs[CONFIG_LFG_OPTIONSMASK] = sConfigMgr->GetOption<int32>("DungeonFinder.OptionsMask", 3);

    // Max instances per hour
    m_int_configs[CONFIG_MAX_INSTANCES_PER_HOUR] = sConfigMgr->GetOption<int32>("AccountInstancesPerHour", 5);

    // AutoBroadcast
    m_bool_configs[CONFIG_AUTOBROADCAST]         = sConfigMgr->GetOption<bool>("AutoBroadcast.On", false);
    m_int_configs[CONFIG_AUTOBROADCAST_CENTER]   = sConfigMgr->GetOption<int32>("AutoBroadcast.Center", 0);
    m_int_configs[CONFIG_AUTOBROADCAST_INTERVAL] = sConfigMgr->GetOption<int32>("AutoBroadcast.Timer", 60000);
    if (reload)
    {
        m_timers[WUPDATE_AUTOBROADCAST].SetInterval(m_int_configs[CONFIG_AUTOBROADCAST_INTERVAL]);
        m_timers[WUPDATE_AUTOBROADCAST].Reset();
    }

    // MySQL ping time interval
    m_int_configs[CONFIG_DB_PING_INTERVAL] = sConfigMgr->GetOption<int32>("MaxPingTime", 30);

    // misc
    m_bool_configs[CONFIG_PDUMP_NO_PATHS]     = sConfigMgr->GetOption<bool>("PlayerDump.DisallowPaths", true);
    m_bool_configs[CONFIG_PDUMP_NO_OVERWRITE] = sConfigMgr->GetOption<bool>("PlayerDump.DisallowOverwrite", true);
    m_bool_configs[CONFIG_ENABLE_MMAPS]       = sConfigMgr->GetOption<bool>("MoveMaps.Enable", true);
    MMAP::MMapFactory::InitializeDisabledMaps();

    // Wintergrasp
    m_bool_configs[CONFIG_WINTERGRASP_ENABLE]             = sConfigMgr->GetOption<bool>("Wintergrasp.Enable", false);
    m_int_configs[CONFIG_WINTERGRASP_PLR_MAX]             = sConfigMgr->GetOption<int32>("Wintergrasp.PlayerMax", 100);
    m_int_configs[CONFIG_WINTERGRASP_PLR_MIN]             = sConfigMgr->GetOption<int32>("Wintergrasp.PlayerMin", 0);
    m_int_configs[CONFIG_WINTERGRASP_PLR_MIN_LVL]         = sConfigMgr->GetOption<int32>("Wintergrasp.PlayerMinLvl", 77);
    m_int_configs[CONFIG_WINTERGRASP_BATTLETIME]          = sConfigMgr->GetOption<int32>("Wintergrasp.BattleTimer", 30);
    m_int_configs[CONFIG_WINTERGRASP_NOBATTLETIME]        = sConfigMgr->GetOption<int32>("Wintergrasp.NoBattleTimer", 150);
    m_int_configs[CONFIG_WINTERGRASP_RESTART_AFTER_CRASH] = sConfigMgr->GetOption<int32>("Wintergrasp.CrashRestartTimer", 10);

    m_int_configs[CONFIG_BIRTHDAY_TIME]     = sConfigMgr->GetOption<int32>("BirthdayTime", 1222964635);
    m_bool_configs[CONFIG_MINIGOB_MANABONK] = sConfigMgr->GetOption<bool>("Minigob.Manabonk.Enable", true);

    m_bool_configs[CONFIG_ENABLE_CONTINENT_TRANSPORT]            = sConfigMgr->GetOption<bool>("IsContinentTransport.Enabled", true);
    m_bool_configs[CONFIG_ENABLE_CONTINENT_TRANSPORT_PRELOADING] = sConfigMgr->GetOption<bool>("IsPreloadedContinentTransport.Enabled", false);

    m_bool_configs[CONFIG_IP_BASED_ACTION_LOGGING] = sConfigMgr->GetOption<bool>("Allow.IP.Based.Action.Logging", false);

    // Whether to use LoS from game objects
    m_bool_configs[CONFIG_CHECK_GOBJECT_LOS] = sConfigMgr->GetOption<bool>("CheckGameObjectLoS", true);

    m_bool_configs[CONFIG_CALCULATE_CREATURE_ZONE_AREA_DATA]   = sConfigMgr->GetOption<bool>("Calculate.Creature.Zone.Area.Data", false);
    m_bool_configs[CONFIG_CALCULATE_GAMEOBJECT_ZONE_AREA_DATA] = sConfigMgr->GetOption<bool>("Calculate.Gameoject.Zone.Area.Data", false);

    // Player can join LFG anywhere
    m_bool_configs[CONFIG_LFG_LOCATION_ALL] = sConfigMgr->GetOption<bool>("LFG.Location.All", false);

    // Prevent players AFK from being logged out
    m_int_configs[CONFIG_AFK_PREVENT_LOGOUT] = sConfigMgr->GetOption<int32>("PreventAFKLogout", 0);

    // Preload all grids of all non-instanced maps
    m_bool_configs[CONFIG_PRELOAD_ALL_NON_INSTANCED_MAP_GRIDS] = sConfigMgr->GetOption<bool>("PreloadAllNonInstancedMapGrids", false);

    // ICC buff override
    m_int_configs[CONFIG_ICC_BUFF_HORDE] = sConfigMgr->GetOption<int32>("ICC.Buff.Horde", 73822);
    m_int_configs[CONFIG_ICC_BUFF_ALLIANCE] = sConfigMgr->GetOption<int32>("ICC.Buff.Alliance", 73828);

    m_bool_configs[CONFIG_SET_ALL_CREATURES_WITH_WAYPOINT_MOVEMENT_ACTIVE] = sConfigMgr->GetOption<bool>("SetAllCreaturesWithWaypointMovementActive", false);

    // packet spoof punishment
    m_int_configs[CONFIG_PACKET_SPOOF_POLICY] = sConfigMgr->GetOption<int32>("PacketSpoof.Policy", (uint32)WorldSession::DosProtection::POLICY_KICK);
    m_int_configs[CONFIG_PACKET_SPOOF_BANMODE] = sConfigMgr->GetOption<int32>("PacketSpoof.BanMode", (uint32)0);
    if (m_int_configs[CONFIG_PACKET_SPOOF_BANMODE] > 1)
        m_int_configs[CONFIG_PACKET_SPOOF_BANMODE] = (uint32)0;

    m_int_configs[CONFIG_PACKET_SPOOF_BANDURATION] = sConfigMgr->GetOption<int32>("PacketSpoof.BanDuration", 86400);

    // Random Battleground Rewards
    m_int_configs[CONFIG_BG_REWARD_WINNER_HONOR_FIRST] = sConfigMgr->GetOption<int32>("Battleground.RewardWinnerHonorFirst", 30);
    m_int_configs[CONFIG_BG_REWARD_WINNER_ARENA_FIRST] = sConfigMgr->GetOption<int32>("Battleground.RewardWinnerArenaFirst", 25);
    m_int_configs[CONFIG_BG_REWARD_WINNER_HONOR_LAST]  = sConfigMgr->GetOption<int32>("Battleground.RewardWinnerHonorLast", 15);
    m_int_configs[CONFIG_BG_REWARD_WINNER_ARENA_LAST]  = sConfigMgr->GetOption<int32>("Battleground.RewardWinnerArenaLast", 0);
    m_int_configs[CONFIG_BG_REWARD_LOSER_HONOR_FIRST]  = sConfigMgr->GetOption<int32>("Battleground.RewardLoserHonorFirst", 5);
    m_int_configs[CONFIG_BG_REWARD_LOSER_HONOR_LAST]   = sConfigMgr->GetOption<int32>("Battleground.RewardLoserHonorLast", 5);

    m_int_configs[CONFIG_WAYPOINT_MOVEMENT_STOP_TIME_FOR_PLAYER] = sConfigMgr->GetOption<int32>("WaypointMovementStopTimeForPlayer", 120);

    m_int_configs[CONFIG_DUNGEON_ACCESS_REQUIREMENTS_PRINT_MODE]              = sConfigMgr->GetOption<int32>("DungeonAccessRequirements.PrintMode", 1);
    m_bool_configs[CONFIG_DUNGEON_ACCESS_REQUIREMENTS_PORTAL_CHECK_ILVL]      = sConfigMgr->GetOption<bool>("DungeonAccessRequirements.PortalAvgIlevelCheck", false);
    m_bool_configs[CONFIG_DUNGEON_ACCESS_REQUIREMENTS_LFG_DBC_LEVEL_OVERRIDE] = sConfigMgr->GetOption<bool>("DungeonAccessRequirements.LFGLevelDBCOverride", false);
    m_int_configs[CONFIG_DUNGEON_ACCESS_REQUIREMENTS_OPTIONAL_STRING_ID]      = sConfigMgr->GetOption<int32>("DungeonAccessRequirements.OptionalStringID", 0);
    m_int_configs[CONFIG_NPC_EVADE_IF_NOT_REACHABLE] = sConfigMgr->GetOption<int32>("NpcEvadeIfTargetIsUnreachable", 5);
    m_int_configs[CONFIG_NPC_REGEN_TIME_IF_NOT_REACHABLE_IN_RAID] = sConfigMgr->GetOption<int32>("NpcRegenHPTimeIfTargetIsUnreachable", 10);
    m_bool_configs[CONFIG_REGEN_HP_CANNOT_REACH_TARGET_IN_RAID] = sConfigMgr->GetOption<bool>("NpcRegenHPIfTargetIsUnreachable", true);

    //Debug
    m_bool_configs[CONFIG_DEBUG_BATTLEGROUND] = sConfigMgr->GetOption<bool>("Debug.Battleground", false);
    m_bool_configs[CONFIG_DEBUG_ARENA]        = sConfigMgr->GetOption<bool>("Debug.Arena",        false);

    m_int_configs[CONFIG_GM_LEVEL_CHANNEL_MODERATION] = sConfigMgr->GetOption<int32>("Channel.ModerationGMLevel", 1);

    m_bool_configs[CONFIG_SET_BOP_ITEM_TRADEABLE] = sConfigMgr->GetOption<bool>("Item.SetItemTradeable", true);

    // call ScriptMgr if we're reloading the configuration
    sScriptMgr->OnAfterConfigLoad(reload);
}

/// Initialize the World
void World::SetInitialWorldSettings()
{
    ///- Server startup begin
    uint32 startupBegin = getMSTime();

    ///- Initialize the random number generator
    srand((unsigned int)time(nullptr));

    ///- Initialize detour memory management
    dtAllocSetCustom(dtCustomAlloc, dtCustomFree);

    LOG_INFO("server", "Initializing Scripts...");
    sScriptMgr->Initialize();

    ///- Initialize VMapManager function pointers (to untangle game/collision circular deps)
    VMAP::VMapManager2* vmmgr2 = VMAP::VMapFactory::createOrGetVMapManager();
    vmmgr2->GetLiquidFlagsPtr = &GetLiquidFlags;
    vmmgr2->IsVMAPDisabledForPtr = &DisableMgr::IsVMAPDisabledFor;

    ///- Initialize config settings
    LoadConfigSettings();

    ///- Initialize Allowed Security Level
    LoadDBAllowedSecurityLevel();

    ///- Init highest guids before any table loading to prevent using not initialized guids in some code.
    sObjectMgr->SetHighestGuids();

    if (!sConfigMgr->isDryRun())
    {
        ///- Check the existence of the map files for all starting areas.
        if (!MapManager::ExistMapAndVMap(0, -6240.32f, 331.033f)
                || !MapManager::ExistMapAndVMap(0, -8949.95f, -132.493f)
                || !MapManager::ExistMapAndVMap(1, -618.518f, -4251.67f)
                || !MapManager::ExistMapAndVMap(0, 1676.35f, 1677.45f)
                || !MapManager::ExistMapAndVMap(1, 10311.3f, 832.463f)
                || !MapManager::ExistMapAndVMap(1, -2917.58f, -257.98f)
                || (m_int_configs[CONFIG_EXPANSION] && (
                        !MapManager::ExistMapAndVMap(530, 10349.6f, -6357.29f) ||
                        !MapManager::ExistMapAndVMap(530, -3961.64f, -13931.2f))))
        {
            exit(1);
        }
    }

    ///- Initialize pool manager
    sPoolMgr->Initialize();

    ///- Initialize game event manager
    sGameEventMgr->Initialize();

    ///- Loading strings. Getting no records means core load has to be canceled because no error message can be output.
    LOG_INFO("server", " ");
    LOG_INFO("server", "Loading acore strings...");
    if (!sObjectMgr->LoadAcoreStrings())
        exit(1);                                            // Error message displayed in function already

    ///- Update the realm entry in the database with the realm type from the config file
    //No SQL injection as values are treated as integers

    // not send custom type REALM_FFA_PVP to realm list
    uint32 server_type;
    if (IsFFAPvPRealm())
        server_type = REALM_TYPE_PVP;
    else
        server_type = getIntConfig(CONFIG_GAME_TYPE);

    uint32 realm_zone = getIntConfig(CONFIG_REALM_ZONE);

    LoginDatabase.PExecute("UPDATE realmlist SET icon = %u, timezone = %u WHERE id = '%d'", server_type, realm_zone, realm.Id.Realm);      // One-time query

    ///- Custom Hook for loading DB items
    sScriptMgr->OnLoadCustomDatabaseTable();

    ///- Load the DBC files
    LOG_INFO("server", "Initialize data stores...");
    LoadDBCStores(m_dataPath);
    DetectDBCLang();

    // Load IP Location Database
    sIPLocation->Load();

    std::vector<uint32> mapIds;
    for (auto const& map : sMapStore)
        mapIds.emplace_back(map->MapID);

    vmmgr2->InitializeThreadUnsafe(mapIds);

    MMAP::MMapManager* mmmgr = MMAP::MMapFactory::createOrGetMMapManager();
    mmmgr->InitializeThreadUnsafe(mapIds);

    LOG_INFO("server", "Loading Game Graveyard...");
    sGraveyard->LoadGraveyardFromDB();

    LOG_INFO("server", "Loading spell dbc data corrections...");
    sSpellMgr->LoadDbcDataCorrections();

    LOG_INFO("server", "Loading SpellInfo store...");
    sSpellMgr->LoadSpellInfoStore();

    LOG_INFO("server", "Loading Spell Rank Data...");
    sSpellMgr->LoadSpellRanks();

    LOG_INFO("server", "Loading Spell Specific And Aura State...");
    sSpellMgr->LoadSpellSpecificAndAuraState();

    LOG_INFO("server", "Loading SkillLineAbilityMultiMap Data...");
    sSpellMgr->LoadSkillLineAbilityMap();

    LOG_INFO("server", "Loading spell custom attributes...");
    sSpellMgr->LoadSpellCustomAttr();

    LOG_INFO("server", "Loading GameObject models...");
    LoadGameObjectModelList(m_dataPath);

    LOG_INFO("server", "Loading Script Names...");
    sObjectMgr->LoadScriptNames();

    LOG_INFO("server", "Loading Instance Template...");
    sObjectMgr->LoadInstanceTemplate();

    // xinef: Global Storage, should be loaded asap
    LOG_INFO("server", "Load Global Player Data...");
    sWorld->LoadGlobalPlayerDataStore();

    // Must be called before `creature_respawn`/`gameobject_respawn` tables
    LOG_INFO("server", "Loading instances...");
    sInstanceSaveMgr->LoadInstances();

    LOG_INFO("server", "Loading Broadcast texts...");
    sObjectMgr->LoadBroadcastTexts();
    sObjectMgr->LoadBroadcastTextLocales();

    LOG_INFO("server", "Loading Localization strings...");
    uint32 oldMSTime = getMSTime();
    sObjectMgr->LoadCreatureLocales();
    sObjectMgr->LoadGameObjectLocales();
    sObjectMgr->LoadItemLocales();
    sObjectMgr->LoadItemSetNameLocales();
    sObjectMgr->LoadQuestLocales();
    sObjectMgr->LoadQuestOfferRewardLocale();
    sObjectMgr->LoadQuestRequestItemsLocale();
    sObjectMgr->LoadNpcTextLocales();
    sObjectMgr->LoadPageTextLocales();
    sObjectMgr->LoadGossipMenuItemsLocales();
    sObjectMgr->LoadPointOfInterestLocales();

    sObjectMgr->SetDBCLocaleIndex(GetDefaultDbcLocale());        // Get once for all the locale index of DBC language (console/broadcasts)
    LOG_INFO("server", ">> Localization strings loaded in %u ms", GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server", " ");

    LOG_INFO("server", "Loading Page Texts...");
    sObjectMgr->LoadPageTexts();

    LOG_INFO("server", "Loading Game Object Templates...");         // must be after LoadPageTexts
    sObjectMgr->LoadGameObjectTemplate();

    LOG_INFO("server", "Loading Game Object template addons...");
    sObjectMgr->LoadGameObjectTemplateAddons();

    LOG_INFO("server", "Loading Transport templates...");
    sTransportMgr->LoadTransportTemplates();

    LOG_INFO("server", "Loading Spell Required Data...");
    sSpellMgr->LoadSpellRequired();

    LOG_INFO("server", "Loading Spell Group types...");
    sSpellMgr->LoadSpellGroups();

    LOG_INFO("server", "Loading Spell Learn Skills...");
    sSpellMgr->LoadSpellLearnSkills();                           // must be after LoadSpellRanks

    LOG_INFO("server", "Loading Spell Proc Event conditions...");
    sSpellMgr->LoadSpellProcEvents();

    LOG_INFO("server", "Loading Spell Proc conditions and data...");
    sSpellMgr->LoadSpellProcs();

    LOG_INFO("server", "Loading Spell Bonus Data...");
    sSpellMgr->LoadSpellBonusess();

    LOG_INFO("server", "Loading Aggro Spells Definitions...");
    sSpellMgr->LoadSpellThreats();

    LOG_INFO("server", "Loading Mixology bonuses...");
    sSpellMgr->LoadSpellMixology();

    LOG_INFO("server", "Loading Spell Group Stack Rules...");
    sSpellMgr->LoadSpellGroupStackRules();

    LOG_INFO("server", "Loading NPC Texts...");
    sObjectMgr->LoadGossipText();

    LOG_INFO("server", "Loading Enchant Spells Proc datas...");
    sSpellMgr->LoadSpellEnchantProcData();

    LOG_INFO("server", "Loading Item Random Enchantments Table...");
    LoadRandomEnchantmentsTable();

    LOG_INFO("server", "Loading Disables");
    DisableMgr::LoadDisables();                                  // must be before loading quests and items

    LOG_INFO("server", "Loading Items...");                         // must be after LoadRandomEnchantmentsTable and LoadPageTexts
    sObjectMgr->LoadItemTemplates();

    LOG_INFO("server", "Loading Item set names...");                // must be after LoadItemPrototypes
    sObjectMgr->LoadItemSetNames();

    LOG_INFO("server", "Loading Creature Model Based Info Data...");
    sObjectMgr->LoadCreatureModelInfo();

    LOG_INFO("server", "Loading Creature templates...");
    sObjectMgr->LoadCreatureTemplates();

    LOG_INFO("server", "Loading Equipment templates...");           // must be after LoadCreatureTemplates
    sObjectMgr->LoadEquipmentTemplates();

    LOG_INFO("server", "Loading Creature template addons...");
    sObjectMgr->LoadCreatureTemplateAddons();

    LOG_INFO("server", "Loading Reputation Reward Rates...");
    sObjectMgr->LoadReputationRewardRate();

    LOG_INFO("server", "Loading Creature Reputation OnKill Data...");
    sObjectMgr->LoadReputationOnKill();

    LOG_INFO("server", "Loading Reputation Spillover Data..." );
    sObjectMgr->LoadReputationSpilloverTemplate();

    LOG_INFO("server", "Loading Points Of Interest Data...");
    sObjectMgr->LoadPointsOfInterest();

    LOG_INFO("server", "Loading Creature Base Stats...");
    sObjectMgr->LoadCreatureClassLevelStats();

    LOG_INFO("server", "Loading Creature Data...");
    sObjectMgr->LoadCreatures();

    LOG_INFO("server", "Loading Temporary Summon Data...");
    sObjectMgr->LoadTempSummons();                               // must be after LoadCreatureTemplates() and LoadGameObjectTemplates()

    LOG_INFO("server", "Loading pet levelup spells...");
    sSpellMgr->LoadPetLevelupSpellMap();

    LOG_INFO("server", "Loading pet default spells additional to levelup spells...");
    sSpellMgr->LoadPetDefaultSpells();

    LOG_INFO("server", "Loading Creature Addon Data...");
    sObjectMgr->LoadCreatureAddons();                            // must be after LoadCreatureTemplates() and LoadCreatures()

    LOG_INFO("server", "Loading Gameobject Data...");
    sObjectMgr->LoadGameobjects();

    LOG_INFO("server", "Loading GameObject Addon Data...");
    sObjectMgr->LoadGameObjectAddons();                          // must be after LoadGameObjectTemplate() and LoadGameobjects()

    LOG_INFO("server", "Loading GameObject Quest Items...");
    sObjectMgr->LoadGameObjectQuestItems();

    LOG_INFO("server", "Loading Creature Quest Items...");
    sObjectMgr->LoadCreatureQuestItems();

    LOG_INFO("server", "Loading Creature Linked Respawn...");
    sObjectMgr->LoadLinkedRespawn();                             // must be after LoadCreatures(), LoadGameObjects()

    LOG_INFO("server", "Loading Weather Data...");
    WeatherMgr::LoadWeatherData();

    LOG_INFO("server", "Loading Quests...");
    sObjectMgr->LoadQuests();                                    // must be loaded after DBCs, creature_template, item_template, gameobject tables

    LOG_INFO("server", "Checking Quest Disables");
    DisableMgr::CheckQuestDisables();                           // must be after loading quests

    LOG_INFO("server", "Loading Quest POI");
    sObjectMgr->LoadQuestPOI();

    LOG_INFO("server", "Loading Quests Starters and Enders...");
    sObjectMgr->LoadQuestStartersAndEnders();                    // must be after quest load

    LOG_INFO("server", "Loading Objects Pooling Data...");
    sPoolMgr->LoadFromDB();

    LOG_INFO("server", "Loading Game Event Data...");               // must be after loading pools fully
    sGameEventMgr->LoadHolidayDates();                           // Must be after loading DBC
    sGameEventMgr->LoadFromDB();                                 // Must be after loading holiday dates

    LOG_INFO("server", "Loading UNIT_NPC_FLAG_SPELLCLICK Data..."); // must be after LoadQuests
    sObjectMgr->LoadNPCSpellClickSpells();

    LOG_INFO("server", "Loading Vehicle Template Accessories...");
    sObjectMgr->LoadVehicleTemplateAccessories();                // must be after LoadCreatureTemplates() and LoadNPCSpellClickSpells()

    LOG_INFO("server", "Loading Vehicle Accessories...");
    sObjectMgr->LoadVehicleAccessories();                       // must be after LoadCreatureTemplates() and LoadNPCSpellClickSpells()

    LOG_INFO("server", "Loading SpellArea Data...");                // must be after quest load
    sSpellMgr->LoadSpellAreas();

    LOG_INFO("server", "Loading Area Trigger definitions");
    sObjectMgr->LoadAreaTriggers();

    LOG_INFO("server", "Loading Area Trigger Teleport definitions...");
    sObjectMgr->LoadAreaTriggerTeleports();

    LOG_INFO("server", "Loading Access Requirements...");
    sObjectMgr->LoadAccessRequirements();                        // must be after item template load

    LOG_INFO("server", "Loading Quest Area Triggers...");
    sObjectMgr->LoadQuestAreaTriggers();                         // must be after LoadQuests

    LOG_INFO("server", "Loading Tavern Area Triggers...");
    sObjectMgr->LoadTavernAreaTriggers();

    LOG_INFO("server", "Loading AreaTrigger script names...");
    sObjectMgr->LoadAreaTriggerScripts();

    LOG_INFO("server", "Loading LFG entrance positions..."); // Must be after areatriggers
    sLFGMgr->LoadLFGDungeons();

    LOG_INFO("server", "Loading Dungeon boss data...");
    sObjectMgr->LoadInstanceEncounters();

    LOG_INFO("server", "Loading LFG rewards...");
    sLFGMgr->LoadRewards();

    LOG_INFO("server", "Loading Graveyard-zone links...");
    sGraveyard->LoadGraveyardZones();

    LOG_INFO("server", "Loading spell pet auras...");
    sSpellMgr->LoadSpellPetAuras();

    LOG_INFO("server", "Loading Spell target coordinates...");
    sSpellMgr->LoadSpellTargetPositions();

    LOG_INFO("server", "Loading enchant custom attributes...");
    sSpellMgr->LoadEnchantCustomAttr();

    LOG_INFO("server", "Loading linked spells...");
    sSpellMgr->LoadSpellLinked();

    LOG_INFO("server", "Loading Player Create Data...");
    sObjectMgr->LoadPlayerInfo();

    LOG_INFO("server", "Loading Exploration BaseXP Data...");
    sObjectMgr->LoadExplorationBaseXP();

    LOG_INFO("server", "Loading Pet Name Parts...");
    sObjectMgr->LoadPetNames();

    CharacterDatabaseCleaner::CleanDatabase();

    LOG_INFO("server", "Loading the max pet number...");
    sObjectMgr->LoadPetNumber();

    LOG_INFO("server", "Loading pet level stats...");
    sObjectMgr->LoadPetLevelInfo();

    LOG_INFO("server", "Loading Player level dependent mail rewards...");
    sObjectMgr->LoadMailLevelRewards();

    // Loot tables
    LoadLootTables();

    LOG_INFO("server", "Loading Skill Discovery Table...");
    LoadSkillDiscoveryTable();

    LOG_INFO("server", "Loading Skill Extra Item Table...");
    LoadSkillExtraItemTable();

    LOG_INFO("server", "Loading Skill Perfection Data Table...");
    LoadSkillPerfectItemTable();

    LOG_INFO("server", "Loading Skill Fishing base level requirements...");
    sObjectMgr->LoadFishingBaseSkillLevel();

    LOG_INFO("server", "Loading Achievements...");
    sAchievementMgr->LoadAchievementReferenceList();
    LOG_INFO("server", "Loading Achievement Criteria Lists...");
    sAchievementMgr->LoadAchievementCriteriaList();
    LOG_INFO("server", "Loading Achievement Criteria Data...");
    sAchievementMgr->LoadAchievementCriteriaData();
    LOG_INFO("server", "Loading Achievement Rewards...");
    sAchievementMgr->LoadRewards();
    LOG_INFO("server", "Loading Achievement Reward Locales...");
    sAchievementMgr->LoadRewardLocales();
    LOG_INFO("server", "Loading Completed Achievements...");
    sAchievementMgr->LoadCompletedAchievements();

    ///- Load dynamic data tables from the database
    LOG_INFO("server", "Loading Item Auctions...");
    sAuctionMgr->LoadAuctionItems();
    LOG_INFO("server", "Loading Auctions...");
    sAuctionMgr->LoadAuctions();

    sGuildMgr->LoadGuilds();

    LOG_INFO("server", "Loading ArenaTeams...");
    sArenaTeamMgr->LoadArenaTeams();

    LOG_INFO("server", "Loading Groups...");
    sGroupMgr->LoadGroups();

    LOG_INFO("server", "Loading ReservedNames...");
    sObjectMgr->LoadReservedPlayersNames();

    LOG_INFO("server", "Loading GameObjects for quests...");
    sObjectMgr->LoadGameObjectForQuests();

    LOG_INFO("server", "Loading BattleMasters...");
    sBattlegroundMgr->LoadBattleMastersEntry();

    LOG_INFO("server", "Loading GameTeleports...");
    sObjectMgr->LoadGameTele();

    LOG_INFO("server", "Loading Gossip menu...");
    sObjectMgr->LoadGossipMenu();

    LOG_INFO("server", "Loading Gossip menu options...");
    sObjectMgr->LoadGossipMenuItems();

    LOG_INFO("server", "Loading Vendors...");
    sObjectMgr->LoadVendors();                                   // must be after load CreatureTemplate and ItemTemplate

    LOG_INFO("server", "Loading Trainers...");
    sObjectMgr->LoadTrainerSpell();                              // must be after load CreatureTemplate

    LOG_INFO("server", "Loading Waypoints...");
    sWaypointMgr->Load();

    LOG_INFO("server", "Loading SmartAI Waypoints...");
    sSmartWaypointMgr->LoadFromDB();

    LOG_INFO("server", "Loading Creature Formations...");
    sFormationMgr->LoadCreatureFormations();

    LOG_INFO("server", "Loading World States...");              // must be loaded before battleground, outdoor PvP and conditions
    LoadWorldStates();

    LOG_INFO("server", "Loading Conditions...");
    sConditionMgr->LoadConditions();

    LOG_INFO("server", "Loading faction change achievement pairs...");
    sObjectMgr->LoadFactionChangeAchievements();

    LOG_INFO("server", "Loading faction change spell pairs...");
    sObjectMgr->LoadFactionChangeSpells();

    LOG_INFO("server", "Loading faction change item pairs...");
    sObjectMgr->LoadFactionChangeItems();

    LOG_INFO("server", "Loading faction change reputation pairs...");
    sObjectMgr->LoadFactionChangeReputations();

    LOG_INFO("server", "Loading faction change title pairs...");
    sObjectMgr->LoadFactionChangeTitles();

    LOG_INFO("server", "Loading faction change quest pairs...");
    sObjectMgr->LoadFactionChangeQuests();

    LOG_INFO("server", "Loading GM tickets...");
    sTicketMgr->LoadTickets();

    LOG_INFO("server", "Loading GM surveys...");
    sTicketMgr->LoadSurveys();

    LOG_INFO("server", "Loading client addons...");
    AddonMgr::LoadFromDB();

    // pussywizard:
    LOG_INFO("server", "Deleting invalid mail items...");
    LOG_INFO("server", " ");
    CharacterDatabase.Query("DELETE mi FROM mail_items mi LEFT JOIN item_instance ii ON mi.item_guid = ii.guid WHERE ii.guid IS NULL");
    CharacterDatabase.Query("DELETE mi FROM mail_items mi LEFT JOIN mail m ON mi.mail_id = m.id WHERE m.id IS NULL");
    CharacterDatabase.Query("UPDATE mail m LEFT JOIN mail_items mi ON m.id = mi.mail_id SET m.has_items=0 WHERE m.has_items<>0 AND mi.mail_id IS NULL");

    ///- Handle outdated emails (delete/return)
    LOG_INFO("server", "Returning old mails...");
    LOG_INFO("server", " ");
    sObjectMgr->ReturnOrDeleteOldMails(false);

    ///- Load AutoBroadCast
    LOG_INFO("server", "Loading Autobroadcasts...");
    LoadAutobroadcasts();

    ///- Load and initialize scripts
    sObjectMgr->LoadSpellScripts();                              // must be after load Creature/Gameobject(Template/Data)
    sObjectMgr->LoadEventScripts();                              // must be after load Creature/Gameobject(Template/Data)
    sObjectMgr->LoadWaypointScripts();

    LOG_INFO("server", "Loading spell script names...");
    sObjectMgr->LoadSpellScriptNames();

    LOG_INFO("server", "Loading Creature Texts...");
    sCreatureTextMgr->LoadCreatureTexts();

    LOG_INFO("server", "Loading Creature Text Locales...");
    sCreatureTextMgr->LoadCreatureTextLocales();

    LOG_INFO("server", "Loading Scripts...");
    sScriptMgr->LoadDatabase();

    LOG_INFO("server", "Validating spell scripts...");
    sObjectMgr->ValidateSpellScripts();

    LOG_INFO("server", "Loading SmartAI scripts...");
    sSmartScriptMgr->LoadSmartAIFromDB();

    LOG_INFO("server", "Loading Calendar data...");
    sCalendarMgr->LoadFromDB();

    LOG_INFO("server", "Initializing SpellInfo precomputed data..."); // must be called after loading items, professions, spells and pretty much anything
    LOG_INFO("server", " ");
    sObjectMgr->InitializeSpellInfoPrecomputedData();

    ///- Initialize game time and timers
    LOG_INFO("server", "Initialize game time and timers");
    LOG_INFO("server", " ");
    m_gameTime = time(nullptr);
    m_startTime = m_gameTime;

    LoginDatabase.PExecute("INSERT INTO uptime (realmid, starttime, uptime, revision) VALUES(%u, %u, 0, '%s')",
                           realm.Id.Realm, uint32(m_startTime), GitRevision::GetFullVersion());       // One-time query

    m_timers[WUPDATE_WEATHERS].SetInterval(1 * IN_MILLISECONDS);
    m_timers[WUPDATE_AUCTIONS].SetInterval(MINUTE * IN_MILLISECONDS);
    m_timers[WUPDATE_AUCTIONS].SetCurrent(MINUTE * IN_MILLISECONDS);
    m_timers[WUPDATE_UPTIME].SetInterval(m_int_configs[CONFIG_UPTIME_UPDATE]*MINUTE * IN_MILLISECONDS);
    //Update "uptime" table based on configuration entry in minutes.

    m_timers[WUPDATE_CORPSES].SetInterval(20 * MINUTE * IN_MILLISECONDS);
    //erase corpses every 20 minutes
    m_timers[WUPDATE_CLEANDB].SetInterval(m_int_configs[CONFIG_LOGDB_CLEARINTERVAL]*MINUTE * IN_MILLISECONDS);
    // clean logs table every 14 days by default
    m_timers[WUPDATE_AUTOBROADCAST].SetInterval(getIntConfig(CONFIG_AUTOBROADCAST_INTERVAL));

    m_timers[WUPDATE_PINGDB].SetInterval(getIntConfig(CONFIG_DB_PING_INTERVAL)*MINUTE * IN_MILLISECONDS);  // Mysql ping time in minutes

    // our speed up
    m_timers[WUPDATE_5_SECS].SetInterval(5 * IN_MILLISECONDS);

    mail_expire_check_timer = time(nullptr) + 6 * 3600;

    ///- Initilize static helper structures
    AIRegistry::Initialize();

    ///- Initialize MapManager
    LOG_INFO("server", "Starting Map System");
    LOG_INFO("server", " ");
    sMapMgr->Initialize();

    LOG_INFO("server", "Starting Game Event system...");
    LOG_INFO("server", " ");
    uint32 nextGameEvent = sGameEventMgr->StartSystem();
    m_timers[WUPDATE_EVENTS].SetInterval(nextGameEvent);    //depend on next event

    // Delete all characters which have been deleted X days before
    Player::DeleteOldCharacters();

    // Delete all custom channels which haven't been used for PreserveCustomChannelDuration days.
    Channel::CleanOldChannelsInDB();

    LOG_INFO("server.loading", "Initializing Opcodes...");
    opcodeTable.Initialize();

    LOG_INFO("server", "Starting Arena Season...");
    LOG_INFO("server", " ");
    sGameEventMgr->StartArenaSeason();

    sTicketMgr->Initialize();

    ///- Initialize Battlegrounds
    LOG_INFO("server", "Starting Battleground System");
    sBattlegroundMgr->CreateInitialBattlegrounds();
    sBattlegroundMgr->InitAutomaticArenaPointDistribution();

    ///- Initialize outdoor pvp
    LOG_INFO("server", "Starting Outdoor PvP System");
    sOutdoorPvPMgr->InitOutdoorPvP();

    ///- Initialize Battlefield
    LOG_INFO("server", "Starting Battlefield System");
    sBattlefieldMgr->InitBattlefield();

    LOG_INFO("server", "Loading Transports...");
    sTransportMgr->SpawnContinentTransports();

    ///- Initialize Warden
    LOG_INFO("server", "Loading Warden Checks..." );
    sWardenCheckMgr->LoadWardenChecks();

    LOG_INFO("server", "Loading Warden Action Overrides..." );
    sWardenCheckMgr->LoadWardenOverrides();

    LOG_INFO("server", "Deleting expired bans...");
    LoginDatabase.Execute("DELETE FROM ip_banned WHERE unbandate <= UNIX_TIMESTAMP() AND unbandate<>bandate");      // One-time query

    LOG_INFO("server", "Calculate next daily quest reset time...");
    InitDailyQuestResetTime();

    LOG_INFO("server", "Calculate next weekly quest reset time..." );
    InitWeeklyQuestResetTime();

    LOG_INFO("server", "Calculate next monthly quest reset time...");
    InitMonthlyQuestResetTime();

    LOG_INFO("server", "Calculate random battleground reset time..." );
    InitRandomBGResetTime();

    LOG_INFO("server", "Calculate deletion of old calendar events time...");
    InitCalendarOldEventsDeletionTime();

    LOG_INFO("server", "Calculate Guild cap reset time...");
    LOG_INFO("server", " ");
    InitGuildResetTime();

    LOG_INFO("server", "Load Petitions...");
    sPetitionMgr->LoadPetitions();

    LOG_INFO("server", "Load Petition Signs...");
    sPetitionMgr->LoadSignatures();

    LOG_INFO("server", "Load Stored Loot Items...");
    sLootItemStorage->LoadStorageFromDB();

    LOG_INFO("server", "Load Channel Rights...");
    ChannelMgr::LoadChannelRights();

    LOG_INFO("server", "Load Channels...");
    ChannelMgr::LoadChannels();

#ifdef ELUNA
    ///- Run eluna scripts.
    // in multithread foreach: run scripts
    sEluna->RunScripts();
    sEluna->OnConfigLoad(false, false); // Must be done after Eluna is initialized and scripts have run.
#endif

    if (sWorld->getBoolConfig(CONFIG_PRELOAD_ALL_NON_INSTANCED_MAP_GRIDS))
    {
        LOG_INFO("server", "Loading all grids for all non-instanced maps...");

        for (uint32 i = 0; i < sMapStore.GetNumRows(); ++i)
        {
            MapEntry const* mapEntry = sMapStore.LookupEntry(i);

            if (mapEntry && !mapEntry->Instanceable())
            {
                Map* map = sMapMgr->CreateBaseMap(mapEntry->MapID);

                if (map)
                {
                    LOG_INFO("server", ">> Loading all grids for map %u", map->GetId());
                    map->LoadAllCells();
                }
            }
        }
    }

    uint32 startupDuration = GetMSTimeDiffToNow(startupBegin);
    LOG_INFO("server", " ");
    LOG_INFO("server", "WORLD: World initialized in %u minutes %u seconds", (startupDuration / 60000), ((startupDuration % 60000) / 1000)); // outError for red color in console
    LOG_INFO("server", " ");

    if (sConfigMgr->isDryRun())
    {
        LOG_INFO("server", "AzerothCore dry run completed, terminating.");
        exit(0);
    }
}

void World::DetectDBCLang()
{
    uint8 m_lang_confid = sConfigMgr->GetOption<int32>("DBC.Locale", 255);

    if (m_lang_confid != 255 && m_lang_confid >= TOTAL_LOCALES)
    {
        LOG_ERROR("server", "Incorrect DBC.Locale! Must be >= 0 and < %d (set to 0)", TOTAL_LOCALES);
        m_lang_confid = LOCALE_enUS;
    }

    ChrRacesEntry const* race = sChrRacesStore.LookupEntry(1);
    std::string availableLocalsStr;

    uint8 default_locale = TOTAL_LOCALES;
    for (uint8 i = default_locale - 1; i < TOTAL_LOCALES; --i) // -1 will be 255 due to uint8
    {
        if (race->name[i][0] != '\0')                     // check by race names
        {
            default_locale = i;
            m_availableDbcLocaleMask |= (1 << i);
            availableLocalsStr += localeNames[i];
            availableLocalsStr += " ";
        }
    }

    if (default_locale != m_lang_confid && m_lang_confid < TOTAL_LOCALES &&
            (m_availableDbcLocaleMask & (1 << m_lang_confid)))
    {
        default_locale = m_lang_confid;
    }

    if (default_locale >= TOTAL_LOCALES)
    {
        LOG_ERROR("server", "Unable to determine your DBC Locale! (corrupt DBC?)");
        exit(1);
    }

    m_defaultDbcLocale = LocaleConstant(default_locale);

    LOG_INFO("server", "Using %s DBC Locale as default. All available DBC locales: %s", localeNames[GetDefaultDbcLocale()], availableLocalsStr.empty() ? "<none>" : availableLocalsStr.c_str());
    LOG_INFO("server", " ");
}

void World::LoadAutobroadcasts()
{
    uint32 oldMSTime = getMSTime();

    m_Autobroadcasts.clear();
    m_AutobroadcastsWeights.clear();

    uint32 realmId = sConfigMgr->GetOption<int32>("RealmID", 0);
    PreparedStatement* stmt = LoginDatabase.GetPreparedStatement(LOGIN_SEL_AUTOBROADCAST);
    stmt->setInt32(0, realmId);
    PreparedQueryResult result = LoginDatabase.Query(stmt);

    if (!result)
    {
        LOG_INFO("server", ">> Loaded 0 autobroadcasts definitions. DB table `autobroadcast` is empty for this realm!");
        return;
    }

    uint32 count = 0;

    do
    {
        Field* fields = result->Fetch();
        uint8 id = fields[0].GetUInt8();

        m_Autobroadcasts[id] = fields[2].GetString();
        m_AutobroadcastsWeights[id] = fields[1].GetUInt8();

        ++count;
    } while (result->NextRow());

    LOG_INFO("server", ">> Loaded %u autobroadcast definitions in %u ms", count, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server", " ");
}

/// Update the World !
void World::Update(uint32 diff)
{
    m_updateTime = diff;

    if (m_int_configs[CONFIG_INTERVAL_LOG_UPDATE])
    {
        m_updateTimeSum += diff;
        if (m_updateTimeSum > m_int_configs[CONFIG_INTERVAL_LOG_UPDATE])
        {
            LOG_INFO("server", "Average update time diff: %u. Players online: %u.", avgDiffTracker.getAverage(), (uint32)GetActiveSessionCount());
            m_updateTimeSum = 0;
        }
    }

    DynamicVisibilityMgr::Update(GetActiveSessionCount());

    ///- Update the different timers
    for (int i = 0; i < WUPDATE_COUNT; ++i)
    {
        if (m_timers[i].GetCurrent() >= 0)
            m_timers[i].Update(diff);
        else
            m_timers[i].SetCurrent(0);
    }

    // pussywizard: our speed up and functionality
    if (m_timers[WUPDATE_5_SECS].Passed())
    {
        m_timers[WUPDATE_5_SECS].Reset();

        // moved here from HandleCharEnumOpcode
        PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_EXPIRED_BANS);
        CharacterDatabase.Execute(stmt);

        // copy players hashmapholder to avoid mutex
        WhoListCacheMgr::Update();
    }

    ///- Update the game time and check for shutdown time
    _UpdateGameTime();

    /// Handle daily quests reset time
    if (m_gameTime > m_NextDailyQuestReset)
        ResetDailyQuests();

    /// Handle weekly quests reset time
    if (m_gameTime > m_NextWeeklyQuestReset)
        ResetWeeklyQuests();

    /// Handle monthly quests reset time
    if (m_gameTime > m_NextMonthlyQuestReset)
        ResetMonthlyQuests();

    if (m_gameTime > m_NextRandomBGReset)
        ResetRandomBG();

    if (m_gameTime > m_NextCalendarOldEventsDeletionTime)
        CalendarDeleteOldEvents();

    if (m_gameTime > m_NextGuildReset)
        ResetGuildCap();

    // pussywizard:
    // acquire mutex now, this is kind of waiting for listing thread to finish it's work (since it can't process next packet)
    // so we don't have to do it in every packet that modifies auctions
    AsyncAuctionListingMgr::SetAuctionListingAllowed(false);
    {
        std::lock_guard<std::mutex> guard(AsyncAuctionListingMgr::GetLock());

        // pussywizard: handle auctions when the timer has passed
        if (m_timers[WUPDATE_AUCTIONS].Passed())
        {
            m_timers[WUPDATE_AUCTIONS].Reset();

            // pussywizard: handle expired auctions, auctions expired when realm was offline are also handled here (not during loading when many required things aren't loaded yet)
            sAuctionMgr->Update();
        }

        AsyncAuctionListingMgr::Update(diff);

        if (m_gameTime > mail_expire_check_timer)
        {
            sObjectMgr->ReturnOrDeleteOldMails(true);
            mail_expire_check_timer = m_gameTime + 6 * 3600;
        }

        UpdateSessions(diff);
    }
    // end of section with mutex
    AsyncAuctionListingMgr::SetAuctionListingAllowed(true);

    /// <li> Handle weather updates when the timer has passed
    if (m_timers[WUPDATE_WEATHERS].Passed())
    {
        m_timers[WUPDATE_WEATHERS].Reset();
        WeatherMgr::Update(uint32(m_timers[WUPDATE_WEATHERS].GetInterval()));
    }

    /// <li> Clean logs table
    if (sWorld->getIntConfig(CONFIG_LOGDB_CLEARTIME) > 0) // if not enabled, ignore the timer
    {
        if (m_timers[WUPDATE_CLEANDB].Passed())
        {
            m_timers[WUPDATE_CLEANDB].Reset();

            PreparedStatement* stmt = LoginDatabase.GetPreparedStatement(LOGIN_DEL_OLD_LOGS);

            stmt->setUInt32(0, sWorld->getIntConfig(CONFIG_LOGDB_CLEARTIME));
            stmt->setUInt32(1, uint32(time(0)));

            LoginDatabase.Execute(stmt);
        }
    }

    sLFGMgr->Update(diff, 0); // pussywizard: remove obsolete stuff before finding compatibility during map update

    sMapMgr->Update(diff);

    if (sWorld->getBoolConfig(CONFIG_AUTOBROADCAST))
    {
        if (m_timers[WUPDATE_AUTOBROADCAST].Passed())
        {
            m_timers[WUPDATE_AUTOBROADCAST].Reset();
            SendAutoBroadcast();
        }
    }

    sBattlegroundMgr->Update(diff);

    sOutdoorPvPMgr->Update(diff);

    sBattlefieldMgr->Update(diff);

    sLFGMgr->Update(diff, 2); // pussywizard: handle created proposals

    // execute callbacks from sql queries that were queued recently
    ProcessQueryCallbacks();

    /// <li> Update uptime table
    if (m_timers[WUPDATE_UPTIME].Passed())
    {
        uint32 tmpDiff = uint32(m_gameTime - m_startTime);
        uint32 maxOnlinePlayers = GetMaxPlayerCount();

        m_timers[WUPDATE_UPTIME].Reset();

        PreparedStatement* stmt = LoginDatabase.GetPreparedStatement(LOGIN_UPD_UPTIME_PLAYERS);

        stmt->setUInt32(0, tmpDiff);
        stmt->setUInt16(1, uint16(maxOnlinePlayers));
        stmt->setUInt32(2, realm.Id.Realm);
        stmt->setUInt32(3, uint32(m_startTime));

        LoginDatabase.Execute(stmt);
    }

    ///- Erase corpses once every 20 minutes
    if (m_timers[WUPDATE_CORPSES].Passed())
    {
        m_timers[WUPDATE_CORPSES].Reset();
        sMapMgr->DoForAllMaps([](Map* map)
        {
            map->RemoveOldCorpses();
        });
    }

    ///- Process Game events when necessary
    if (m_timers[WUPDATE_EVENTS].Passed())
    {
        m_timers[WUPDATE_EVENTS].Reset();                   // to give time for Update() to be processed
        uint32 nextGameEvent = sGameEventMgr->Update();
        m_timers[WUPDATE_EVENTS].SetInterval(nextGameEvent);
        m_timers[WUPDATE_EVENTS].Reset();
    }

    ///- Ping to keep MySQL connections alive
    if (m_timers[WUPDATE_PINGDB].Passed())
    {
        m_timers[WUPDATE_PINGDB].Reset();
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
        LOG_DEBUG("server", "Ping MySQL to keep connection alive");
#endif
        CharacterDatabase.KeepAlive();
        LoginDatabase.KeepAlive();
        WorldDatabase.KeepAlive();
    }

    // update the instance reset times
    sInstanceSaveMgr->Update();

    // And last, but not least handle the issued cli commands
    ProcessCliCommands();

    sScriptMgr->OnWorldUpdate(diff);

    SavingSystemMgr::Update(diff);
}

void World::ForceGameEventUpdate()
{
    m_timers[WUPDATE_EVENTS].Reset();                   // to give time for Update() to be processed
    uint32 nextGameEvent = sGameEventMgr->Update();
    m_timers[WUPDATE_EVENTS].SetInterval(nextGameEvent);
    m_timers[WUPDATE_EVENTS].Reset();
}

/// Send a packet to all players (except self if mentioned)
void World::SendGlobalMessage(WorldPacket* packet, WorldSession* self, TeamId teamId)
{
    SessionMap::const_iterator itr;
    for (itr = m_sessions.begin(); itr != m_sessions.end(); ++itr)
    {
        if (itr->second &&
                itr->second->GetPlayer() &&
                itr->second->GetPlayer()->IsInWorld() &&
                itr->second != self &&
                (teamId == TEAM_NEUTRAL || itr->second->GetPlayer()->GetTeamId() == teamId))
        {
            itr->second->SendPacket(packet);
        }
    }
}

/// Send a packet to all GMs (except self if mentioned)
void World::SendGlobalGMMessage(WorldPacket* packet, WorldSession* self, TeamId teamId)
{
    SessionMap::iterator itr;
    for (itr = m_sessions.begin(); itr != m_sessions.end(); ++itr)
    {
        if (itr->second &&
                itr->second->GetPlayer() &&
                itr->second->GetPlayer()->IsInWorld() &&
                itr->second != self &&
                !AccountMgr::IsPlayerAccount(itr->second->GetSecurity()) &&
                (teamId == TEAM_NEUTRAL || itr->second->GetPlayer()->GetTeamId() == teamId))
        {
            itr->second->SendPacket(packet);
        }
    }
}

namespace Acore
{
    class WorldWorldTextBuilder
    {
    public:
        typedef std::vector<WorldPacket*> WorldPacketList;
        explicit WorldWorldTextBuilder(uint32 textId, va_list* args = nullptr) : i_textId(textId), i_args(args) {}
        void operator()(WorldPacketList& data_list, LocaleConstant loc_idx)
        {
            char const* text = sObjectMgr->GetAcoreString(i_textId, loc_idx);

            if (i_args)
            {
                // we need copy va_list before use or original va_list will corrupted
                va_list ap;
                va_copy(ap, *i_args);

                char str[2048];
                vsnprintf(str, 2048, text, ap);
                va_end(ap);

                do_helper(data_list, &str[0]);
            }
            else
                do_helper(data_list, (char*)text);
        }
    private:
        char* lineFromMessage(char*& pos) { char* start = strtok(pos, "\n"); pos = nullptr; return start; }
        void do_helper(WorldPacketList& data_list, char* text)
        {
            char* pos = text;
            while (char* line = lineFromMessage(pos))
            {
                WorldPacket* data = new WorldPacket();
                ChatHandler::BuildChatPacket(*data, CHAT_MSG_SYSTEM, LANG_UNIVERSAL, nullptr, nullptr, line);
                data_list.push_back(data);
            }
        }

        uint32 i_textId;
        va_list* i_args;
    };
}                                                           // namespace Acore

/// Send a System Message to all players (except self if mentioned)
void World::SendWorldText(uint32 string_id, ...)
{
    va_list ap;
    va_start(ap, string_id);

    Acore::WorldWorldTextBuilder wt_builder(string_id, &ap);
    Acore::LocalizedPacketListDo<Acore::WorldWorldTextBuilder> wt_do(wt_builder);
    for (SessionMap::const_iterator itr = m_sessions.begin(); itr != m_sessions.end(); ++itr)
    {
        if (!itr->second || !itr->second->GetPlayer() || !itr->second->GetPlayer()->IsInWorld())
            continue;

        wt_do(itr->second->GetPlayer());
    }

    va_end(ap);
}

/// Send a System Message to all GMs (except self if mentioned)
void World::SendGMText(uint32 string_id, ...)
{
    va_list ap;
    va_start(ap, string_id);

    Acore::WorldWorldTextBuilder wt_builder(string_id, &ap);
    Acore::LocalizedPacketListDo<Acore::WorldWorldTextBuilder> wt_do(wt_builder);
    for (SessionMap::iterator itr = m_sessions.begin(); itr != m_sessions.end(); ++itr)
    {
        if (!itr->second || !itr->second->GetPlayer() || !itr->second->GetPlayer()->IsInWorld())
            continue;

        if (AccountMgr::IsPlayerAccount(itr->second->GetSecurity()))
            continue;

        wt_do(itr->second->GetPlayer());
    }

    va_end(ap);
}

/// DEPRECATED, only for debug purpose. Send a System Message to all players (except self if mentioned)
void World::SendGlobalText(const char* text, WorldSession* self)
{
    WorldPacket data;

    // need copy to prevent corruption by strtok call in LineFromMessage original string
    char* buf = strdup(text);
    char* pos = buf;

    while (char* line = ChatHandler::LineFromMessage(pos))
    {
        ChatHandler::BuildChatPacket(data, CHAT_MSG_SYSTEM, LANG_UNIVERSAL, nullptr, nullptr, line);
        SendGlobalMessage(&data, self);
    }

    free(buf);
}

/// Send a packet to all players (or players selected team) in the zone (except self if mentioned)
bool World::SendZoneMessage(uint32 zone, WorldPacket* packet, WorldSession* self, TeamId teamId)
{
    bool foundPlayerToSend = false;
    SessionMap::const_iterator itr;

    for (itr = m_sessions.begin(); itr != m_sessions.end(); ++itr)
    {
        if (itr->second &&
                itr->second->GetPlayer() &&
                itr->second->GetPlayer()->IsInWorld() &&
                itr->second->GetPlayer()->GetZoneId() == zone &&
                itr->second != self &&
                (teamId == TEAM_NEUTRAL || itr->second->GetPlayer()->GetTeamId() == teamId))
        {
            itr->second->SendPacket(packet);
            foundPlayerToSend = true;
        }
    }

    return foundPlayerToSend;
}

/// Send a System Message to all players in the zone (except self if mentioned)
void World::SendZoneText(uint32 zone, const char* text, WorldSession* self, TeamId teamId)
{
    WorldPacket data;
    ChatHandler::BuildChatPacket(data, CHAT_MSG_SYSTEM, LANG_UNIVERSAL, nullptr, nullptr, text);
    SendZoneMessage(zone, &data, self, teamId);
}

/// Kick (and save) all players
void World::KickAll()
{
    m_QueuedPlayer.clear();                                 // prevent send queue update packet and login queued sessions

    // session not removed at kick and will removed in next update tick
    for (SessionMap::const_iterator itr = m_sessions.begin(); itr != m_sessions.end(); ++itr)
        itr->second->KickPlayer("KickAll sessions");

    // pussywizard: kick offline sessions
    for (SessionMap::const_iterator itr = m_offlineSessions.begin(); itr != m_offlineSessions.end(); ++itr)
        itr->second->KickPlayer("KickAll offline sessions");
}

/// Kick (and save) all players with security level less `sec`
void World::KickAllLess(AccountTypes sec)
{
    // session not removed at kick and will removed in next update tick
    for (SessionMap::const_iterator itr = m_sessions.begin(); itr != m_sessions.end(); ++itr)
        if (itr->second->GetSecurity() < sec)
            itr->second->KickPlayer("KickAllLess");
}

/// Update the game time
void World::_UpdateGameTime()
{
    ///- update the time
    time_t thisTime = time(nullptr);
    uint32 elapsed = uint32(thisTime - m_gameTime);
    m_gameTime = thisTime;
    m_gameMSTime = getMSTime();

    ///- if there is a shutdown timer
    if (!IsStopped() && m_ShutdownTimer > 0 && elapsed > 0)
    {
        ///- ... and it is overdue, stop the world (set m_stopEvent)
        if (m_ShutdownTimer <= elapsed)
        {
            if (!(m_ShutdownMask & SHUTDOWN_MASK_IDLE) || GetActiveAndQueuedSessionCount() == 0)
                m_stopEvent = true;                         // exist code already set
            else
                m_ShutdownTimer = 1;                        // minimum timer value to wait idle state
        }
        ///- ... else decrease it and if necessary display a shutdown countdown to the users
        else
        {
            m_ShutdownTimer -= elapsed;

            ShutdownMsg();
        }
    }
}

/// Shutdown the server
void World::ShutdownServ(uint32 time, uint32 options, uint8 exitcode)
{
    // ignore if server shutdown at next tick
    if (IsStopped())
        return;

    m_ShutdownMask = options;
    m_ExitCode = exitcode;

    ///- If the shutdown time is 0, set m_stopEvent (except if shutdown is 'idle' with remaining sessions)
    if (time == 0)
    {
        if (!(options & SHUTDOWN_MASK_IDLE) || GetActiveAndQueuedSessionCount() == 0)
            m_stopEvent = true;                             // exist code already set
        else
            m_ShutdownTimer = 1;                            //So that the session count is re-evaluated at next world tick
    }
    ///- Else set the shutdown timer and warn users
    else
    {
        m_ShutdownTimer = time;
        ShutdownMsg(true);
    }

    sScriptMgr->OnShutdownInitiate(ShutdownExitCode(exitcode), ShutdownMask(options));
}

/// Display a shutdown message to the user(s)
void World::ShutdownMsg(bool show, Player* player)
{
    // not show messages for idle shutdown mode
    if (m_ShutdownMask & SHUTDOWN_MASK_IDLE)
        return;

    ///- Display a message every 12 hours, hours, 5 minutes, minute, 5 seconds and finally seconds
    if (show ||
            (m_ShutdownTimer < 5 * MINUTE && (m_ShutdownTimer % 15) == 0) || // < 5 min; every 15 sec
            (m_ShutdownTimer < 15 * MINUTE && (m_ShutdownTimer % MINUTE) == 0) || // < 15 min ; every 1 min
            (m_ShutdownTimer < 30 * MINUTE && (m_ShutdownTimer % (5 * MINUTE)) == 0) || // < 30 min ; every 5 min
            (m_ShutdownTimer < 12 * HOUR && (m_ShutdownTimer % HOUR) == 0) || // < 12 h ; every 1 h
            (m_ShutdownTimer > 12 * HOUR && (m_ShutdownTimer % (12 * HOUR)) == 0)) // > 12 h ; every 12 h
    {
        std::string str = secsToTimeString(m_ShutdownTimer).append(".");

        ServerMessageType msgid = (m_ShutdownMask & SHUTDOWN_MASK_RESTART) ? SERVER_MSG_RESTART_TIME : SERVER_MSG_SHUTDOWN_TIME;

        SendServerMessage(msgid, str.c_str(), player);
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
        LOG_DEBUG("server", "Server is %s in %s", (m_ShutdownMask & SHUTDOWN_MASK_RESTART ? "restart" : "shuttingdown"), str.c_str());
#endif
    }
}

/// Cancel a planned server shutdown
void World::ShutdownCancel()
{
    // nothing cancel or too later
    if (!m_ShutdownTimer || m_stopEvent)
        return;

    ServerMessageType msgid = (m_ShutdownMask & SHUTDOWN_MASK_RESTART) ? SERVER_MSG_RESTART_CANCELLED : SERVER_MSG_SHUTDOWN_CANCELLED;

    m_ShutdownMask = 0;
    m_ShutdownTimer = 0;
    m_ExitCode = SHUTDOWN_EXIT_CODE;                       // to default value
    SendServerMessage(msgid);

#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    LOG_DEBUG("server", "Server %s cancelled.", (m_ShutdownMask & SHUTDOWN_MASK_RESTART ? "restart" : "shuttingdown"));
#endif

    sScriptMgr->OnShutdownCancel();
}

/// Send a server message to the user(s)
void World::SendServerMessage(ServerMessageType type, const char* text, Player* player)
{
    WorldPacket data(SMSG_SERVER_MESSAGE, 50);              // guess size
    data << uint32(type);
    if (type <= SERVER_MSG_STRING)
        data << text;

    if (player)
        player->GetSession()->SendPacket(&data);
    else
        SendGlobalMessage(&data);
}

void World::UpdateSessions(uint32 diff)
{
    ///- Add new sessions
    WorldSession* sess = nullptr;
    while (addSessQueue.next(sess))
        AddSession_ (sess);

    ///- Then send an update signal to remaining ones
    for (SessionMap::iterator itr = m_sessions.begin(), next; itr != m_sessions.end(); itr = next)
    {
        next = itr;
        ++next;

        ///- and remove not active sessions from the list
        WorldSession* pSession = itr->second;
        WorldSessionFilter updater(pSession);

        // pussywizard:
        if (pSession->HandleSocketClosed())
        {
            if (!RemoveQueuedPlayer(pSession) && getIntConfig(CONFIG_INTERVAL_DISCONNECT_TOLERANCE))
                m_disconnects[pSession->GetAccountId()] = time(nullptr);
            m_sessions.erase(itr);
            // there should be no offline session if current one is logged onto a character
            SessionMap::iterator iter;
            if ((iter = m_offlineSessions.find(pSession->GetAccountId())) != m_offlineSessions.end())
            {
                WorldSession* tmp = iter->second;
                m_offlineSessions.erase(iter);
                tmp->SetShouldSetOfflineInDB(false);
                delete tmp;
            }
            pSession->SetOfflineTime(time(nullptr));
            m_offlineSessions[pSession->GetAccountId()] = pSession;
            continue;
        }

        if (!pSession->Update(diff, updater))
        {
            if (!RemoveQueuedPlayer(pSession) && getIntConfig(CONFIG_INTERVAL_DISCONNECT_TOLERANCE))
                m_disconnects[pSession->GetAccountId()] = time(nullptr);
            m_sessions.erase(itr);
            if (m_offlineSessions.find(pSession->GetAccountId()) != m_offlineSessions.end()) // pussywizard: don't set offline in db because offline session for that acc is present (character is in world)
                pSession->SetShouldSetOfflineInDB(false);
            delete pSession;
        }
    }

    // pussywizard:
    if (m_offlineSessions.empty())
        return;
    uint32 currTime = time(nullptr);
    for (SessionMap::iterator itr = m_offlineSessions.begin(), next; itr != m_offlineSessions.end(); itr = next)
    {
        next = itr;
        ++next;
        WorldSession* pSession = itr->second;
        if (!pSession->GetPlayer() || pSession->GetOfflineTime() + 60 < currTime || pSession->IsKicked())
        {
            m_offlineSessions.erase(itr);
            if (m_sessions.find(pSession->GetAccountId()) != m_sessions.end())
                pSession->SetShouldSetOfflineInDB(false); // pussywizard: don't set offline in db because new session for that acc is already created
            delete pSession;
        }
    }
}

// This handles the issued and queued CLI commands
void World::ProcessCliCommands()
{
    CliCommandHolder::Print* zprint = nullptr;
    void* callbackArg = nullptr;
    CliCommandHolder* command = nullptr;
    while (cliCmdQueue.next(command))
    {
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
        LOG_DEBUG("server", "CLI command under processing...");
#endif
        zprint = command->m_print;
        callbackArg = command->m_callbackArg;
        CliHandler handler(callbackArg, zprint);
        handler.ParseCommands(command->m_command);
        if (command->m_commandFinished)
            command->m_commandFinished(callbackArg, !handler.HasSentErrorMessage());
        delete command;
    }
}

void World::SendAutoBroadcast()
{
    if (m_Autobroadcasts.empty())
        return;

    uint32 weight = 0;
    AutobroadcastsWeightMap selectionWeights;

    std::string msg;

    for (AutobroadcastsWeightMap::const_iterator it = m_AutobroadcastsWeights.begin(); it != m_AutobroadcastsWeights.end(); ++it)
    {
        if (it->second)
        {
            weight += it->second;
            selectionWeights[it->first] = it->second;
        }
    }

    if (weight)
    {
        uint32 selectedWeight = urand(0, weight - 1);
        weight = 0;
        for (AutobroadcastsWeightMap::const_iterator it = selectionWeights.begin(); it != selectionWeights.end(); ++it)
        {
            weight += it->second;
            if (selectedWeight < weight)
            {
                msg = m_Autobroadcasts[it->first];
                break;
            }
        }
    }
    else
        msg = m_Autobroadcasts[urand(0, m_Autobroadcasts.size())];

    uint32 abcenter = sWorld->getIntConfig(CONFIG_AUTOBROADCAST_CENTER);

    if (abcenter == 0)
        sWorld->SendWorldText(LANG_AUTO_BROADCAST, msg.c_str());

    else if (abcenter == 1)
    {
        WorldPacket data(SMSG_NOTIFICATION, (msg.size() + 1));
        data << msg;
        sWorld->SendGlobalMessage(&data);
    }

    else if (abcenter == 2)
    {
        sWorld->SendWorldText(LANG_AUTO_BROADCAST, msg.c_str());

        WorldPacket data(SMSG_NOTIFICATION, (msg.size() + 1));
        data << msg;
        sWorld->SendGlobalMessage(&data);
    }

#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    LOG_DEBUG("server", "AutoBroadcast: '%s'", msg.c_str());
#endif
}

void World::UpdateRealmCharCount(uint32 accountId)
{
    PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_CHARACTER_COUNT);
    stmt->setUInt32(0, accountId);
    stmt->setUInt32(1, accountId);
    PreparedQueryResultFuture result = CharacterDatabase.AsyncQuery(stmt);
    m_realmCharCallbacks.insert(result);
}

void World::_UpdateRealmCharCount(PreparedQueryResult resultCharCount)
{
    if (resultCharCount)
    {
        Field* fields = resultCharCount->Fetch();
        uint32 accountId = fields[0].GetUInt32();
        uint8 charCount = uint8(fields[1].GetUInt64());

        SQLTransaction trans = LoginDatabase.BeginTransaction();

        PreparedStatement* stmt = LoginDatabase.GetPreparedStatement(LOGIN_DEL_REALM_CHARACTERS_BY_REALM);
        stmt->setUInt32(0, accountId);
        stmt->setUInt32(1, realm.Id.Realm);
        trans->Append(stmt);

        stmt = LoginDatabase.GetPreparedStatement(LOGIN_INS_REALM_CHARACTERS);
        stmt->setUInt8(0, charCount);
        stmt->setUInt32(1, accountId);
        stmt->setUInt32(2, realm.Id.Realm);
        trans->Append(stmt);

        LoginDatabase.CommitTransaction(trans);
    }
}

// int8 dayOfWeek: 0 (sunday) to 6 (saturday)
time_t World::GetNextTimeWithDayAndHour(int8 dayOfWeek, int8 hour)
{
    if (hour < 0 || hour > 23)
        hour = 0;
    time_t curr = time(nullptr);
    tm localTm;
    localtime_r(&curr, &localTm);
    localTm.tm_hour = hour;
    localTm.tm_min  = 0;
    localTm.tm_sec  = 0;
    uint32 add;
    if (dayOfWeek < 0 || dayOfWeek > 6)
        dayOfWeek = (localTm.tm_wday + 1) % 7;
    if (localTm.tm_wday >= dayOfWeek)
        add = (7 - (localTm.tm_wday - dayOfWeek)) * DAY;
    else
        add = (dayOfWeek - localTm.tm_wday) * DAY;
    return mktime(&localTm) + add;
}

// int8 month: 0 (january) to 11 (december)
time_t World::GetNextTimeWithMonthAndHour(int8 month, int8 hour)
{
    if (hour < 0 || hour > 23)
        hour = 0;
    time_t curr = time(nullptr);
    tm localTm;
    localtime_r(&curr, &localTm);
    localTm.tm_mday = 1;
    localTm.tm_hour = hour;
    localTm.tm_min  = 0;
    localTm.tm_sec  = 0;
    if (month < 0 || month > 11)
    {
        month = (localTm.tm_mon + 1) % 12;
        if (month == 0)
            localTm.tm_year += 1;
    }
    else if (localTm.tm_mon >= month)
        localTm.tm_year += 1;
    localTm.tm_mon = month;
    return mktime(&localTm);
}

void World::InitWeeklyQuestResetTime()
{
    time_t wstime = time_t(sWorld->getWorldState(WS_WEEKLY_QUEST_RESET_TIME));
    m_NextWeeklyQuestReset = wstime ? wstime : GetNextTimeWithDayAndHour(4, 6);
    if (!wstime)
        sWorld->setWorldState(WS_WEEKLY_QUEST_RESET_TIME, uint64(m_NextWeeklyQuestReset));
}

void World::InitDailyQuestResetTime()
{
    time_t wstime = time_t(sWorld->getWorldState(WS_DAILY_QUEST_RESET_TIME));
    m_NextDailyQuestReset = wstime ? wstime : GetNextTimeWithDayAndHour(-1, 6);
    if (!wstime)
        sWorld->setWorldState(WS_DAILY_QUEST_RESET_TIME, uint64(m_NextDailyQuestReset));
}

void World::InitMonthlyQuestResetTime()
{
    time_t wstime = time_t(sWorld->getWorldState(WS_MONTHLY_QUEST_RESET_TIME));
    m_NextMonthlyQuestReset = wstime ? wstime : GetNextTimeWithMonthAndHour(-1, 6);
    if (!wstime)
        sWorld->setWorldState(WS_MONTHLY_QUEST_RESET_TIME, uint64(m_NextMonthlyQuestReset));
}

void World::InitRandomBGResetTime()
{
    time_t wstime = time_t(sWorld->getWorldState(WS_BG_DAILY_RESET_TIME));
    m_NextRandomBGReset = wstime ? wstime : GetNextTimeWithDayAndHour(-1, 6);
    if (!wstime)
        sWorld->setWorldState(WS_BG_DAILY_RESET_TIME, uint64(m_NextRandomBGReset));
}

void World::InitCalendarOldEventsDeletionTime()
{
    time_t now = time(nullptr);
    time_t currentDeletionTime = getWorldState(WS_DAILY_CALENDAR_DELETION_OLD_EVENTS_TIME);
    time_t nextDeletionTime = currentDeletionTime ? currentDeletionTime : GetNextTimeWithDayAndHour(-1, getIntConfig(CONFIG_CALENDAR_DELETE_OLD_EVENTS_HOUR));

    // If the reset time saved in the worldstate is before now it means the server was offline when the reset was supposed to occur.
    // In this case we set the reset time in the past and next world update will do the reset and schedule next one in the future.
    if (currentDeletionTime < now)
        m_NextCalendarOldEventsDeletionTime = nextDeletionTime - DAY;
    else
        m_NextCalendarOldEventsDeletionTime = nextDeletionTime;

    if (!currentDeletionTime)
        sWorld->setWorldState(WS_DAILY_CALENDAR_DELETION_OLD_EVENTS_TIME, uint64(m_NextCalendarOldEventsDeletionTime));
}

void World::InitGuildResetTime()
{
    time_t wstime = time_t(getWorldState(WS_GUILD_DAILY_RESET_TIME));
    m_NextGuildReset = wstime ? wstime : GetNextTimeWithDayAndHour(-1, 6);
    if (!wstime)
        sWorld->setWorldState(WS_GUILD_DAILY_RESET_TIME, uint64(m_NextGuildReset));
}

void World::ResetDailyQuests()
{
    PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_QUEST_STATUS_DAILY);
    CharacterDatabase.Execute(stmt);

    for (SessionMap::const_iterator itr = m_sessions.begin(); itr != m_sessions.end(); ++itr)
        if (itr->second->GetPlayer())
            itr->second->GetPlayer()->ResetDailyQuestStatus();

    m_NextDailyQuestReset = GetNextTimeWithDayAndHour(-1, 6);
    sWorld->setWorldState(WS_DAILY_QUEST_RESET_TIME, uint64(m_NextDailyQuestReset));

    // change available dailies
    sPoolMgr->ChangeDailyQuests();
}

void World::LoadDBAllowedSecurityLevel()
{
    PreparedStatement* stmt = LoginDatabase.GetPreparedStatement(LOGIN_SEL_REALMLIST_SECURITY_LEVEL);
    stmt->setInt32(0, int32(realm.Id.Realm));
    PreparedQueryResult result = LoginDatabase.Query(stmt);

    if (result)
        SetPlayerSecurityLimit(AccountTypes(result->Fetch()->GetUInt8()));
}

void World::SetPlayerSecurityLimit(AccountTypes _sec)
{
    AccountTypes sec = _sec < SEC_CONSOLE ? _sec : SEC_PLAYER;
    bool update = sec > m_allowedSecurityLevel;
    m_allowedSecurityLevel = sec;
    if (update)
        KickAllLess(m_allowedSecurityLevel);
}

void World::ResetWeeklyQuests()
{
    PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_QUEST_STATUS_WEEKLY);
    CharacterDatabase.Execute(stmt);

    for (SessionMap::const_iterator itr = m_sessions.begin(); itr != m_sessions.end(); ++itr)
        if (itr->second->GetPlayer())
            itr->second->GetPlayer()->ResetWeeklyQuestStatus();

    m_NextWeeklyQuestReset = GetNextTimeWithDayAndHour(4, 6);
    sWorld->setWorldState(WS_WEEKLY_QUEST_RESET_TIME, uint64(m_NextWeeklyQuestReset));

    // change available weeklies
    sPoolMgr->ChangeWeeklyQuests();
}

void World::ResetMonthlyQuests()
{
    LOG_INFO("server", "Monthly quests reset for all characters.");

    PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_QUEST_STATUS_MONTHLY);
    CharacterDatabase.Execute(stmt);

    for (SessionMap::const_iterator itr = m_sessions.begin(); itr != m_sessions.end(); ++itr)
        if (itr->second->GetPlayer())
            itr->second->GetPlayer()->ResetMonthlyQuestStatus();

    m_NextMonthlyQuestReset = GetNextTimeWithMonthAndHour(-1, 6);
    sWorld->setWorldState(WS_MONTHLY_QUEST_RESET_TIME, uint64(m_NextMonthlyQuestReset));
}

void World::ResetEventSeasonalQuests(uint16 event_id)
{
    PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_QUEST_STATUS_SEASONAL);
    stmt->setUInt16(0, event_id);
    CharacterDatabase.Execute(stmt);

    for (SessionMap::const_iterator itr = m_sessions.begin(); itr != m_sessions.end(); ++itr)
        if (itr->second->GetPlayer())
            itr->second->GetPlayer()->ResetSeasonalQuestStatus(event_id);
}

void World::ResetRandomBG()
{
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    LOG_DEBUG("server", "Random BG status reset for all characters.");
#endif

    PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_BATTLEGROUND_RANDOM);
    CharacterDatabase.Execute(stmt);

    for (SessionMap::const_iterator itr = m_sessions.begin(); itr != m_sessions.end(); ++itr)
        if (itr->second->GetPlayer())
            itr->second->GetPlayer()->SetRandomWinner(false);

    m_NextRandomBGReset = GetNextTimeWithDayAndHour(-1, 6);
    sWorld->setWorldState(WS_BG_DAILY_RESET_TIME, uint64(m_NextRandomBGReset));
}

void World::CalendarDeleteOldEvents()
{
    LOG_INFO("server", "Calendar deletion of old events.");

    m_NextCalendarOldEventsDeletionTime = time_t(m_NextCalendarOldEventsDeletionTime + DAY);
    sWorld->setWorldState(WS_DAILY_CALENDAR_DELETION_OLD_EVENTS_TIME, uint64(m_NextCalendarOldEventsDeletionTime));
    sCalendarMgr->DeleteOldEvents();
}

void World::ResetGuildCap()
{
    LOG_INFO("server", "Guild Daily Cap reset.");

    m_NextGuildReset = GetNextTimeWithDayAndHour(-1, 6);
    sWorld->setWorldState(WS_GUILD_DAILY_RESET_TIME, uint64(m_NextGuildReset));

    sGuildMgr->ResetTimes();
}

void World::UpdateMaxSessionCounters()
{
    m_maxActiveSessionCount = std::max(m_maxActiveSessionCount, uint32(m_sessions.size() - m_QueuedPlayer.size()));
    m_maxQueuedSessionCount = std::max(m_maxQueuedSessionCount, uint32(m_QueuedPlayer.size()));
}

void World::LoadDBVersion()
{
    QueryResult result = WorldDatabase.Query("SELECT db_version, cache_id FROM version LIMIT 1");
    if (result)
    {
        Field* fields = result->Fetch();

        m_DBVersion              = fields[0].GetString();

        // will be overwrite by config values if different and non-0
        m_int_configs[CONFIG_CLIENTCACHE_VERSION] = fields[1].GetUInt32();
    }

    if (m_DBVersion.empty())
        m_DBVersion = "Unknown world database.";
}

void World::LoadDBRevision()
{
    QueryResult resultWorld     = WorldDatabase.Query("SELECT date FROM version_db_world ORDER BY date DESC LIMIT 1");
    QueryResult resultCharacter = CharacterDatabase.Query("SELECT date FROM version_db_characters ORDER BY date DESC LIMIT 1");
    QueryResult resultAuth      = LoginDatabase.Query("SELECT date FROM version_db_auth ORDER BY date DESC LIMIT 1");

    if (resultWorld)
    {
        Field* fields = resultWorld->Fetch();

        m_WorldDBRevision = fields[0].GetString();
    }
    if (resultCharacter)
    {
        Field* fields = resultCharacter->Fetch();

        m_CharacterDBRevision = fields[0].GetString();
    }
    if (resultAuth)
    {
        Field* fields = resultAuth->Fetch();

        m_AuthDBRevision = fields[0].GetString();
    }

    if (m_WorldDBRevision.empty())
    {
        m_WorldDBRevision = "Unkown World Database Revision";
    }
    if (m_CharacterDBRevision.empty())
    {
        m_CharacterDBRevision = "Unkown Character Database Revision";
    }
    if (m_AuthDBRevision.empty())
    {
        m_AuthDBRevision = "Unkown Auth Database Revision";
    }
}

void World::UpdateAreaDependentAuras()
{
    SessionMap::const_iterator itr;
    for (itr = m_sessions.begin(); itr != m_sessions.end(); ++itr)
        if (itr->second && itr->second->GetPlayer() && itr->second->GetPlayer()->IsInWorld())
        {
            itr->second->GetPlayer()->UpdateAreaDependentAuras(itr->second->GetPlayer()->GetAreaId());
            itr->second->GetPlayer()->UpdateZoneDependentAuras(itr->second->GetPlayer()->GetZoneId());
        }
}

void World::LoadWorldStates()
{
    uint32 oldMSTime = getMSTime();

    QueryResult result = CharacterDatabase.Query("SELECT entry, value FROM worldstates");

    if (!result)
    {
        LOG_INFO("server", ">> Loaded 0 world states. DB table `worldstates` is empty!");
        LOG_INFO("server", " ");
        return;
    }

    uint32 count = 0;

    do
    {
        Field* fields = result->Fetch();
        m_worldstates[fields[0].GetUInt32()] = fields[1].GetUInt32();
        ++count;
    } while (result->NextRow());

    LOG_INFO("server", ">> Loaded %u world states in %u ms", count, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server", " ");
}

// Setting a worldstate will save it to DB
void World::setWorldState(uint32 index, uint64 value)
{
    WorldStatesMap::const_iterator it = m_worldstates.find(index);
    if (it != m_worldstates.end())
    {
        PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_WORLDSTATE);

        stmt->setUInt32(0, uint32(value));
        stmt->setUInt32(1, index);

        CharacterDatabase.Execute(stmt);
    }
    else
    {
        PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_WORLDSTATE);

        stmt->setUInt32(0, index);
        stmt->setUInt32(1, uint32(value));

        CharacterDatabase.Execute(stmt);
    }
    m_worldstates[index] = value;
}

uint64 World::getWorldState(uint32 index) const
{
    WorldStatesMap::const_iterator it = m_worldstates.find(index);
    return it != m_worldstates.end() ? it->second : 0;
}

void World::ProcessQueryCallbacks()
{
    PreparedQueryResult result;

    while (!m_realmCharCallbacks.is_empty())
    {
        ACE_Future<PreparedQueryResult> lResult;
        ACE_Time_Value timeout = ACE_Time_Value::zero;
        if (m_realmCharCallbacks.next_readable(lResult, &timeout) != 1)
            break;

        if (lResult.ready())
        {
            lResult.get(result);
            _UpdateRealmCharCount(result);
            lResult.cancel();
        }
    }
}

void World::LoadGlobalPlayerDataStore()
{
    uint32 oldMSTime = getMSTime();

    _globalPlayerDataStore.clear();
    QueryResult result = CharacterDatabase.Query("SELECT guid, account, name, gender, race, class, level FROM characters WHERE deleteDate IS NULL");
    if (!result)
    {
        LOG_INFO("server", ">> Loaded 0 Players data.");
        return;
    }

    uint32 count = 0;

    // query to load number of mails by receiver
    std::map<uint32, uint16> _mailCountMap;
    QueryResult mailCountResult = CharacterDatabase.Query("SELECT receiver, COUNT(receiver) FROM mail GROUP BY receiver");
    if (mailCountResult)
    {
        do
        {
            Field* fields = mailCountResult->Fetch();
            _mailCountMap[fields[0].GetUInt32()] = uint16(fields[1].GetUInt64());
        } while (mailCountResult->NextRow());
    }

    do
    {
        Field* fields = result->Fetch();
        ObjectGuid::LowType guidLow = fields[0].GetUInt32();

        // count mails
        uint16 mailCount = 0;
        std::map<uint32, uint16>::const_iterator itr = _mailCountMap.find(guidLow);
        if (itr != _mailCountMap.end())
            mailCount = itr->second;

        AddGlobalPlayerData(
            guidLow,               /*guid*/
            fields[1].GetUInt32(), /*accountId*/
            fields[2].GetString(), /*name*/
            fields[3].GetUInt8(),  /*gender*/
            fields[4].GetUInt8(),  /*race*/
            fields[5].GetUInt8(),  /*class*/
            fields[6].GetUInt8(),  /*level*/
            mailCount,             /*mail count*/
            0                      /*guild id*/);

        ++count;
    } while (result->NextRow());

    LOG_INFO("server", ">> Loaded %d Players data in %u ms", count, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server", " ");
}

void World::AddGlobalPlayerData(ObjectGuid::LowType guid, uint32 accountId, std::string const& name, uint8 gender, uint8 race, uint8 playerClass, uint8 level, uint16 mailCount, uint32 guildId)
{
    GlobalPlayerData data;

    data.guidLow = guid;
    data.accountId = accountId;
    data.name = name;
    data.level = level;
    data.race = race;
    data.playerClass = playerClass;
    data.gender = gender;
    data.mailCount = mailCount;
    data.guildId = guildId;
    data.groupId = 0;
    data.arenaTeamId[0] = 0;
    data.arenaTeamId[1] = 0;
    data.arenaTeamId[2] = 0;

    _globalPlayerDataStore[guid] = data;
    _globalPlayerNameStore[name] = guid;
}

void World::UpdateGlobalPlayerData(ObjectGuid::LowType guid, uint8 mask, std::string const& name, uint8 level, uint8 gender, uint8 race, uint8 playerClass)
{
    GlobalPlayerDataMap::iterator itr = _globalPlayerDataStore.find(guid);
    if (itr == _globalPlayerDataStore.end())
        return;

    if (mask & PLAYER_UPDATE_DATA_LEVEL)
        itr->second.level = level;
    if (mask & PLAYER_UPDATE_DATA_RACE)
        itr->second.race = race;
    if (mask & PLAYER_UPDATE_DATA_CLASS)
        itr->second.playerClass = playerClass;
    if (mask & PLAYER_UPDATE_DATA_GENDER)
        itr->second.gender = gender;
    if (mask & PLAYER_UPDATE_DATA_NAME)
        itr->second.name = name;

    WorldPacket data(SMSG_INVALIDATE_PLAYER, 8);
    data << guid;
    SendGlobalMessage(&data);
}

void World::UpdateGlobalPlayerMails(ObjectGuid::LowType guid, int16 count, bool add)
{
    GlobalPlayerDataMap::iterator itr = _globalPlayerDataStore.find(guid);
    if (itr == _globalPlayerDataStore.end())
        return;

    if (!add)
    {
        itr->second.mailCount = count;
        return;
    }

    int16 icount = (int16)itr->second.mailCount;
    if (count < 0 && abs(count) > icount)
        count = -icount;
    itr->second.mailCount = uint16(icount + count); // addition or subtraction
}

void World::UpdateGlobalPlayerGuild(ObjectGuid::LowType guid, uint32 guildId)
{
    GlobalPlayerDataMap::iterator itr = _globalPlayerDataStore.find(guid);
    if (itr == _globalPlayerDataStore.end())
        return;

    itr->second.guildId = guildId;
}
void World::UpdateGlobalPlayerGroup(ObjectGuid::LowType guid, uint32 groupId)
{
    GlobalPlayerDataMap::iterator itr = _globalPlayerDataStore.find(guid);
    if (itr == _globalPlayerDataStore.end())
        return;

    itr->second.groupId = groupId;
}

void World::UpdateGlobalPlayerArenaTeam(ObjectGuid::LowType guid, uint8 slot, uint32 arenaTeamId)
{
    GlobalPlayerDataMap::iterator itr = _globalPlayerDataStore.find(guid);
    if (itr == _globalPlayerDataStore.end())
        return;

    itr->second.arenaTeamId[slot] = arenaTeamId;
}

void World::UpdateGlobalNameData(ObjectGuid::LowType guidLow, std::string const& oldName, std::string const& newName)
{
    _globalPlayerNameStore.erase(oldName);
    _globalPlayerNameStore[newName] = guidLow;
}

void World::DeleteGlobalPlayerData(ObjectGuid::LowType guid, std::string const& name)
{
    if (guid)
        _globalPlayerDataStore.erase(guid);
    if (!name.empty())
        _globalPlayerNameStore.erase(name);
}

GlobalPlayerData const* World::GetGlobalPlayerData(ObjectGuid::LowType guid) const
{
    // Get data from global storage
    GlobalPlayerDataMap::const_iterator itr = _globalPlayerDataStore.find(guid);
    if (itr != _globalPlayerDataStore.end())
        return &itr->second;

    // Player is not in the global storage, try to get it from the Database
    PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_DATA_BY_GUID);

    stmt->setUInt32(0, guid);

    PreparedQueryResult result = CharacterDatabase.Query(stmt);

    if (result)
    {
        // Player was not in the global storage, but it was found in the database
        // Let's add it to the global storage
        Field* fields = result->Fetch();

        std::string name = fields[2].GetString();

        LOG_INFO("server", "Player %s [GUID: %u] was not found in the global storage, but it was found in the database.", name.c_str(), guid);

        sWorld->AddGlobalPlayerData(
            fields[0].GetUInt32(), /*guid*/
            fields[1].GetUInt32(), /*accountId*/
            fields[2].GetString(), /*name*/
            fields[3].GetUInt8(),  /*gender*/
            fields[4].GetUInt8(),  /*race*/
            fields[5].GetUInt8(),  /*class*/
            fields[6].GetUInt8(),  /*level*/
            0,                     /*mail count*/
            0                      /*guild id*/
        );

        itr = _globalPlayerDataStore.find(guid);
        if (itr != _globalPlayerDataStore.end())
        {
            LOG_INFO("server", "Player %s [GUID: %u] added to the global storage.", name.c_str(), guid);
            return &itr->second;
        }
    }

    // Player not found
    return nullptr;
}

ObjectGuid World::GetGlobalPlayerGUID(std::string const& name) const
{
    // Get data from global storage
    GlobalPlayerNameMap::const_iterator itr = _globalPlayerNameStore.find(name);
    if (itr != _globalPlayerNameStore.end())
        return ObjectGuid::Create<HighGuid::Player>(itr->second);

    // Player is not in the global storage, try to get it from the Database
    PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_DATA_BY_NAME);

    stmt->setString(0, name);

    PreparedQueryResult result = CharacterDatabase.Query(stmt);

    if (result)
    {
        // Player was not in the global storage, but it was found in the database
        // Let's add it to the global storage
        Field* fields = result->Fetch();

        ObjectGuid::LowType guidLow = fields[0].GetUInt32();

        LOG_INFO("server", "Player %s [GUID: %u] was not found in the global storage, but it was found in the database.", name.c_str(), guidLow);

        sWorld->AddGlobalPlayerData(
            guidLow,               /*guid*/
            fields[1].GetUInt32(), /*accountId*/
            fields[2].GetString(), /*name*/
            fields[3].GetUInt8(),  /*gender*/
            fields[4].GetUInt8(),  /*race*/
            fields[5].GetUInt8(),  /*class*/
            fields[6].GetUInt8(),  /*level*/
            0,                     /*mail count*/
            0                      /*guild id*/
        );

        itr = _globalPlayerNameStore.find(name);
        if (itr != _globalPlayerNameStore.end())
        {
            LOG_INFO("server", "Player %s [GUID: %u] added to the global storage.", name.c_str(), guidLow);

            return ObjectGuid::Create<HighGuid::Player>(guidLow);
        }
    }

    // Player not found
    return ObjectGuid::Empty;
}

void World::RemoveOldCorpses()
{
    m_timers[WUPDATE_CORPSES].SetCurrent(m_timers[WUPDATE_CORPSES].GetInterval());
}

bool World::IsPvPRealm() const
{
    return getIntConfig(CONFIG_GAME_TYPE) == REALM_TYPE_PVP || getIntConfig(CONFIG_GAME_TYPE) == REALM_TYPE_RPPVP || getIntConfig(CONFIG_GAME_TYPE) == REALM_TYPE_FFA_PVP;
}

bool World::IsFFAPvPRealm() const
{
    return getIntConfig(CONFIG_GAME_TYPE) == REALM_TYPE_FFA_PVP;
}

/*
 * mod-nostrum-hardcore — HardcoreManager implementation
 */

#include "HardcoreManager.h"
#include "Chat.h"
#include "CharacterCache.h"
#include "Config.h"
#include "Creature.h"
#include "DBCStores.h"
#include "DatabaseEnv.h"
#include "Guild.h"
#include "GuildMgr.h"
#include "Log.h"
#include "ObjectAccessor.h"
#include "Player.h"
#include "SharedDefines.h"
#include "SpellMgr.h"
#include "StringFormat.h"
#include "StringConvert.h"
#include "Tokenize.h"
#include "WorldSessionMgr.h"


// ---------------------------------------------------------------------------
// Singleton
// ---------------------------------------------------------------------------

HardcoreManager* HardcoreManager::Instance()
{
    static HardcoreManager instance;
    return &instance;
}

// ---------------------------------------------------------------------------
// Config loading
// ---------------------------------------------------------------------------

void HardcoreManager::LoadConfig()
{
    _config.enabled                    = sConfigMgr->GetOption<bool>  ("Hardcore.Enable",                    true);
    _config.debug                      = sConfigMgr->GetOption<bool>  ("Hardcore.Debug",                     false);

    _config.maxPlayedSecondsToEnable   = sConfigMgr->GetOption<uint32>("Hardcore.MaxPlayedSecondsToEnable",  600);
    _config.requireLevelOne            = sConfigMgr->GetOption<bool>  ("Hardcore.RequireLevelOne",            true);
    _config.requireZeroDeaths          = sConfigMgr->GetOption<bool>  ("Hardcore.RequireZeroDeaths",          true);

    _config.countPvEDeaths             = sConfigMgr->GetOption<bool>  ("Hardcore.CountPvEDeaths",             true);
    _config.countEnvironmentalDeaths   = sConfigMgr->GetOption<bool>  ("Hardcore.CountEnvironmentalDeaths",   true);
    _config.countDuelDeaths            = sConfigMgr->GetOption<bool>  ("Hardcore.CountDuelDeaths",            false);
    _config.countBattlegroundDeaths    = sConfigMgr->GetOption<bool>  ("Hardcore.CountBattlegroundDeaths",    true);
    _config.countArenaDeaths           = sConfigMgr->GetOption<bool>  ("Hardcore.CountArenaDeaths",           true);
    _config.countWorldPvPDeaths        = sConfigMgr->GetOption<bool>  ("Hardcore.CountWorldPvPDeaths",        true);

    _config.fallenStayGhost            = sConfigMgr->GetOption<bool>  ("Hardcore.FallenStayGhost",            true);
    _config.blockFallenResurrection    = sConfigMgr->GetOption<bool>  ("Hardcore.BlockFallenResurrection",    true);

    _config.soulOfIronSpellId          = sConfigMgr->GetOption<uint32>("Hardcore.SoulOfIronSpellId",          0);
    _config.selfFoundSoulOfIronSpellId = sConfigMgr->GetOption<uint32>("Hardcore.SelfFoundSoulOfIronSpellId", 0);

    _config.titleId                    = sConfigMgr->GetOption<uint32>("Hardcore.TitleId",                    0);
    _config.selfFoundTitleId           = sConfigMgr->GetOption<uint32>("Hardcore.SelfFoundTitleId",           0);

    _config.announceOptIn              = sConfigMgr->GetOption<bool>  ("Hardcore.AnnounceOptIn",              true);
    _config.announceDeaths             = sConfigMgr->GetOption<bool>  ("Hardcore.AnnounceDeaths",             true);
    _config.announceMilestones         = sConfigMgr->GetOption<bool>  ("Hardcore.AnnounceMilestones",         true);

    _config.leaderboardLimit           = sConfigMgr->GetOption<uint32>("Hardcore.LeaderboardLimit",           10);

    _config.selfFoundBlockTrade        = sConfigMgr->GetOption<bool>  ("Hardcore.SelfFound.BlockTrade",       true);
    _config.selfFoundBlockAuctionHouse = sConfigMgr->GetOption<bool>  ("Hardcore.SelfFound.BlockAuctionHouse",true);
    _config.selfFoundBlockPlayerMail   = sConfigMgr->GetOption<bool>  ("Hardcore.SelfFound.BlockPlayerMail",  true);

    _config.autoGuildEnable            = sConfigMgr->GetOption<bool>        ("Hardcore.AutoGuild.Enable", true);
    _config.autoGuildName              = sConfigMgr->GetOption<std::string> ("Hardcore.AutoGuild.Name",   "Deathwalkers");
    _config.autoGuildMotd              = sConfigMgr->GetOption<std::string> ("Hardcore.AutoGuild.MOTD",
        "Welcome to Deathwalkers. One life. No excuses. Help each other survive.");

    // Parse milestone levels from comma-separated string
    _config.milestoneLevels.clear();
    std::string milestonesStr = sConfigMgr->GetOption<std::string>("Hardcore.MilestoneLevels", "10,20,40,60,70,80");
    for (auto const& token : Acore::Tokenize(milestonesStr, ',', true))
    {
        if (auto parsed = Acore::StringTo<uint8>(token))
            _config.milestoneLevels.insert(*parsed);
    }

    if (_config.debug)
        LOG_INFO("module", "[Hardcore] Config loaded. Module {}.", _config.enabled ? "ENABLED" : "DISABLED");
}

// ---------------------------------------------------------------------------
// Player lifecycle
// ---------------------------------------------------------------------------

void HardcoreManager::OnPlayerLogin(Player* player)
{
    if (!_config.enabled)
        return;

    uint32 guid = player->GetGUID().GetCounter();

    LoadDataFromDB(guid);
    LoadFlagsFromDB(guid);

    if (IsFallen(guid))
    {
        ChatHandler(player->GetSession()).PSendSysMessage(
            "This Hardcore character has fallen. You may remain as a ghost, but resurrection is permanently disabled.");
        return;
    }

    if (IsActive(guid))
    {
        ApplyBuff(player);

        if (player->GetGuildId() == 0)
            EnsureAndJoinGuild(player);
    }
}

void HardcoreManager::OnPlayerLogout(Player* player)
{
    if (!_config.enabled)
        return;

    uint32 guid = player->GetGUID().GetCounter();

    // Update played_time in the HC record so leaderboard stays current
    auto it = _data.find(guid);
    if (it != _data.end() && it->second.status == HardcoreStatus::Active)
    {
        it->second.levelReached = player->GetLevel();
        it->second.playedTime   = player->GetTotalPlayedTime();
        SaveDataToDB(it->second);
    }

    // Clean up pending confirmation
    _pending.erase(guid);
    _handledDeaths.erase(guid);
    _duelExempts.erase(guid);

    // Unload from memory to avoid stale data
    _data.erase(guid);
    _flags.erase(guid);
}

// ---------------------------------------------------------------------------
// Data access
// ---------------------------------------------------------------------------

HardcoreData* HardcoreManager::GetData(uint32 guid)
{
    auto it = _data.find(guid);
    return it != _data.end() ? &it->second : nullptr;
}

HardcoreFlags* HardcoreManager::GetFlags(uint32 guid)
{
    auto it = _flags.find(guid);
    return it != _flags.end() ? &it->second : nullptr;
}

bool HardcoreManager::IsActive(uint32 guid)
{
    HardcoreData* d = GetData(guid);
    return d && d->status == HardcoreStatus::Active;
}

bool HardcoreManager::IsFallen(uint32 guid)
{
    HardcoreData* d = GetData(guid);
    return d && d->status == HardcoreStatus::Fallen;
}

bool HardcoreManager::IsHardcore(uint32 guid)
{
    HardcoreData* d = GetData(guid);
    return d && d->mode == HardcoreMode::Hardcore && d->status == HardcoreStatus::Active;
}

bool HardcoreManager::IsSelfFound(uint32 guid)
{
    HardcoreData* d = GetData(guid);
    return d && d->mode == HardcoreMode::SelfFound && d->status == HardcoreStatus::Active;
}

bool HardcoreManager::IsSelfFoundAny(uint32 guid)
{
    // Check in-memory first (online character)
    if (HardcoreData* d = GetData(guid))
        return d->mode == HardcoreMode::SelfFound && d->status == HardcoreStatus::Active;

    // Offline: query DB
    QueryResult result = CharacterDatabase.Query(
        "SELECT 1 FROM mod_nostrum_hardcore WHERE guid = {} AND mode = 2 AND status = 1",
        guid);
    return result != nullptr;
}

// ---------------------------------------------------------------------------
// Confirmation flow
// ---------------------------------------------------------------------------

void HardcoreManager::SetPendingMode(Player* player, HardcoreMode mode)
{
    uint32 guid = player->GetGUID().GetCounter();
    _pending[guid] = { mode, time(nullptr) };
}

bool HardcoreManager::HasValidPendingMode(Player* player)
{
    uint32 guid = player->GetGUID().GetCounter();
    auto it = _pending.find(guid);
    if (it == _pending.end())
        return false;
    return (time(nullptr) - it->second.timestamp) < CONFIRM_EXPIRE_SECONDS;
}

HardcoreMode HardcoreManager::GetPendingMode(Player* player)
{
    uint32 guid = player->GetGUID().GetCounter();
    auto it = _pending.find(guid);
    if (it == _pending.end())
        return HardcoreMode::None;
    if ((time(nullptr) - it->second.timestamp) >= CONFIRM_EXPIRE_SECONDS)
        return HardcoreMode::None;
    return it->second.mode;
}

void HardcoreManager::ClearPendingMode(Player* player)
{
    _pending.erase(player->GetGUID().GetCounter());
}

bool HardcoreManager::Confirm(Player* player, std::string& outError)
{
    uint32 guid = player->GetGUID().GetCounter();

    // Check confirmation still valid
    auto pendIt = _pending.find(guid);
    if (pendIt == _pending.end())
    {
        outError = "No Hardcore mode is pending confirmation.\nUse .hardcore enable or .hardcore selffound first.";
        return false;
    }
    if ((time(nullptr) - pendIt->second.timestamp) >= CONFIRM_EXPIRE_SECONDS)
    {
        _pending.erase(pendIt);
        outError = "Your Hardcore confirmation has expired.\nUse .hardcore enable or .hardcore selffound again.";
        return false;
    }

    HardcoreMode mode = pendIt->second.mode;
    _pending.erase(pendIt);

    // Re-check eligibility at confirm time
    std::string eligReason;
    if (!CheckEligibility(player, mode, eligReason))
    {
        outError = Acore::StringFormat("You are no longer eligible.\nReason: {}", eligReason);
        return false;
    }

    // Build and save HC record
    HardcoreData data;
    data.guid          = guid;
    data.accountId     = player->GetSession()->GetAccountId();
    data.characterName = player->GetName();
    data.race          = player->getRace();
    data.playerClass   = player->getClass();
    data.mode          = mode;
    data.status        = HardcoreStatus::Active;
    data.levelReached  = player->GetLevel();
    data.playedTime    = player->GetTotalPlayedTime();
    data.enabledAt     = time(nullptr);

    _data[guid] = data;
    SaveDataToDB(data);

    // Apply cosmetic buff and title
    ApplyBuff(player);

    // Auto-join Hardcore guild
    EnsureAndJoinGuild(player);

    // Announce globally
    if (_config.announceOptIn)
    {
        if (mode == HardcoreMode::SelfFound)
            Broadcast(Acore::StringFormat("[Hardcore] {} has begun a Self-Found Hardcore journey.", player->GetName()));
        else
            Broadcast(Acore::StringFormat("[Hardcore] {} has begun a Hardcore journey.", player->GetName()));
    }

    return true;
}

// ---------------------------------------------------------------------------
// Eligibility
// ---------------------------------------------------------------------------

bool HardcoreManager::CheckEligibility(Player* player, HardcoreMode mode, std::string& outReason)
{
    uint32 guid = player->GetGUID().GetCounter();

    // Already have a HC record?
    HardcoreData* existing = GetData(guid);
    if (existing && (existing->status == HardcoreStatus::Active || existing->status == HardcoreStatus::Fallen))
    {
        outReason = "This character is already Hardcore.";
        return false;
    }

    if (_config.requireLevelOne && (player->GetLevel() != 1 || player->GetUInt32Value(PLAYER_XP) != 0))
    {
        outReason = "You can only enable Hardcore on a fresh level 1 character with 0 XP.";
        return false;
    }

    HardcoreFlags* flags = GetFlags(guid);
    if (_config.requireZeroDeaths && flags && flags->deathCount > 0)
    {
        outReason = "This character has died before.";
        return false;
    }

    uint32 played = player->GetTotalPlayedTime();
    if (played > _config.maxPlayedSecondsToEnable)
    {
        uint32 minutes = _config.maxPlayedSecondsToEnable / 60;
        outReason = Acore::StringFormat("This character has more than {} minutes played.", minutes);
        return false;
    }

    if (mode == HardcoreMode::SelfFound && flags)
    {
        if (flags->hasTraded)
        {
            outReason = "This character has traded with another player.";
            return false;
        }
        if (flags->hasSentMail)
        {
            outReason = "This character has sent mail to another player.";
            return false;
        }
        if (flags->hasReceivedMail)
        {
            outReason = "This character has received player mail.";
            return false;
        }
        if (flags->hasUsedAuctionHouse)
        {
            outReason = "This character has used the Auction House.";
            return false;
        }
    }

    return true;
}

// ---------------------------------------------------------------------------
// Death handling
// ---------------------------------------------------------------------------

void HardcoreManager::NotifyCreatureDeath(Creature* killer, Player* killed)
{
    if (!_config.enabled || !_config.countPvEDeaths)
        return;

    uint32 guid = killed->GetGUID().GetCounter();
    std::string killerName = killer ? killer->GetName() : "a creature";

    // Always mark as handled so OnPlayerJustDied doesn't double-count
    _handledDeaths[guid] = killerName;

    // Track death for non-HC players too (eligibility)
    IncrementDeathCount(guid);

    if (!IsActive(guid))
        return;

    ProcessHCDeath(killed, killerName);
}

void HardcoreManager::NotifyPvPDeath(Player* killer, Player* killed)
{
    if (!_config.enabled)
        return;

    uint32 guid  = killed->GetGUID().GetCounter();
    std::string killerName = killer ? killer->GetName() : "another player";

    // Always mark as handled
    _handledDeaths[guid] = killerName;

    // Track death for eligibility
    IncrementDeathCount(guid);

    if (!IsActive(guid))
        return;

    bool inBG    = killed->InBattleground();
    bool inArena = killed->InArena();
    bool pvpFlag = killed->IsPvP();

    bool shouldCount = false;
    if (inBG    && _config.countBattlegroundDeaths)  shouldCount = true;
    if (inArena && _config.countArenaDeaths)          shouldCount = true;
    if (!inBG && !inArena && pvpFlag && _config.countWorldPvPDeaths) shouldCount = true;

    if (shouldCount)
        ProcessHCDeath(killed, killerName);
}

void HardcoreManager::NotifyGeneralDeath(Player* player)
{
    if (!_config.enabled)
        return;

    uint32 guid = player->GetGUID().GetCounter();

    // Was this already handled by a more specific hook?
    auto it = _handledDeaths.find(guid);
    if (it != _handledDeaths.end())
    {
        _handledDeaths.erase(it);
        return; // Already processed
    }

    // Duel exempt?
    if (_duelExempts.count(guid))
    {
        _duelExempts.erase(guid);
        return;
    }

    // Not handled by creature/pvp hooks — this is environmental or other
    IncrementDeathCount(guid);

    if (!IsActive(guid))
        return;

    if (_config.countEnvironmentalDeaths)
        ProcessHCDeath(player, "Environmental");
}

void HardcoreManager::NotifyDuelLoss(Player* loser)
{
    if (!_config.enabled || _config.countDuelDeaths)
        return; // If duel deaths count, don't exempt

    _duelExempts.insert(loser->GetGUID().GetCounter());
}

void HardcoreManager::ProcessHCDeath(Player* player, std::string const& killerName)
{
    uint32 guid = player->GetGUID().GetCounter();
    HardcoreData* data = GetData(guid);
    if (!data || data->status != HardcoreStatus::Active)
        return;

    data->status       = HardcoreStatus::Fallen;
    data->levelReached = player->GetLevel();
    data->playedTime   = player->GetTotalPlayedTime();
    data->deathAt      = time(nullptr);
    data->deathZone    = player->GetZoneId();
    data->deathMap     = player->GetMapId();
    data->deathKiller  = killerName;

    SaveDataToDB(*data);
    RemoveBuff(player);

    std::string zoneName = GetZoneName(data->deathZone);
    std::string timeStr  = FormatTime(data->playedTime);

    // Notify the player
    ChatHandler(player->GetSession()).PSendSysMessage(
        Acore::StringFormat(
            "Your Hardcore journey has ended.\n"
            "Level reached: {}\n"
            "Zone: {}\n"
            "Killed by: {}\n"
            "Time played: {}\n"
            "This character has fallen and cannot be revived. You may remain as a ghost.",
            data->levelReached, zoneName, killerName, timeStr).c_str());

    // Global announcement
    if (_config.announceDeaths)
    {
        if (killerName != "Environmental" && !killerName.empty())
        {
            Broadcast(Acore::StringFormat(
                "[Hardcore Death] {} has fallen at level {} in {}. Killed by: {}.",
                data->characterName, data->levelReached, zoneName, killerName));
        }
        else
        {
            Broadcast(Acore::StringFormat(
                "[Hardcore Death] {} has fallen at level {} in {}.",
                data->characterName, data->levelReached, zoneName));
        }
    }

    // Fallen characters stay connected as permanent ghosts — no kick.
}

// ---------------------------------------------------------------------------
// Self-found eligibility flags
// ---------------------------------------------------------------------------

void HardcoreManager::FlagTraded(uint32 guid)
{
    auto it = _flags.find(guid);
    if (it == _flags.end() || it->second.hasTraded)
        return;
    it->second.hasTraded = true;
    SaveFlagField(guid, "has_traded", 1);
}

void HardcoreManager::FlagSentMail(uint32 guid)
{
    auto it = _flags.find(guid);
    if (it == _flags.end() || it->second.hasSentMail)
        return;
    it->second.hasSentMail = true;
    SaveFlagField(guid, "has_sent_mail", 1);
}

void HardcoreManager::FlagReceivedMail(uint32 guid)
{
    auto it = _flags.find(guid);
    if (it == _flags.end() || it->second.hasReceivedMail)
        return;
    it->second.hasReceivedMail = true;
    SaveFlagField(guid, "has_received_mail", 1);
}

void HardcoreManager::FlagUsedAuctionHouse(uint32 guid)
{
    auto it = _flags.find(guid);
    if (it == _flags.end() || it->second.hasUsedAuctionHouse)
        return;
    it->second.hasUsedAuctionHouse = true;
    SaveFlagField(guid, "has_used_auction_house", 1);
}

// ---------------------------------------------------------------------------
// Level milestones
// ---------------------------------------------------------------------------

void HardcoreManager::OnLevelChanged(Player* player, uint8 /*oldLevel*/)
{
    if (!_config.enabled || !_config.announceMilestones)
        return;

    uint32 guid  = player->GetGUID().GetCounter();
    uint8  level = player->GetLevel();

    if (!IsActive(guid))
        return;

    if (_config.milestoneLevels.find(level) == _config.milestoneLevels.end())
        return;

    if (IsMilestoneAnnounced(guid, level))
        return;

    SaveMilestone(guid, level);

    HardcoreData* data = GetData(guid);
    bool selfFound = data && data->mode == HardcoreMode::SelfFound;

    if (level == 80)
    {
        Broadcast(Acore::StringFormat(
            "[Hardcore] {} has reached level 80 without dying. A true champion of Nostrum.",
            player->GetName()));
    }
    else if (selfFound)
    {
        Broadcast(Acore::StringFormat(
            "[Hardcore] {} reached level {} in Self-Found mode.", player->GetName(), level));
    }
    else
    {
        Broadcast(Acore::StringFormat(
            "[Hardcore] {} reached level {}.", player->GetName(), level));
    }
}

// ---------------------------------------------------------------------------
// Buff management
// ---------------------------------------------------------------------------

void HardcoreManager::ApplyBuff(Player* player)
{
    uint32 guid = player->GetGUID().GetCounter();
    HardcoreData* data = GetData(guid);
    if (!data)
        return;

    bool isSelfFound = (data->mode == HardcoreMode::SelfFound);
    uint32 spellId = isSelfFound
        ? _config.selfFoundSoulOfIronSpellId
        : _config.soulOfIronSpellId;

    if (_config.debug)
        LOG_INFO("module", "[Hardcore] ApplyBuff: player={} spellId={} isSelfFound={}",
            player->GetName(), spellId, isSelfFound);

    if (spellId != 0)
    {
        SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(spellId);
        if (!spellInfo)
        {
            LOG_WARN("module", "[Hardcore] Configured spell ID {} not found in SpellMgr — buff skipped for {}.",
                spellId, player->GetName());
        }
        else if (player->HasAura(spellId))
        {
            if (_config.debug)
                LOG_INFO("module", "[Hardcore] {} already has aura {} — skipping.", player->GetName(), spellId);
        }
        else
        {
            // AddAura applies the aura directly without going through the full cast system.
            // This is more reliable than CastSpell for cosmetic/passive persistent auras.
            Aura* aura = player->AddAura(spellId, player);
            if (_config.debug)
            {
                if (aura)
                    LOG_INFO("module", "[Hardcore] Applied aura {} to {}.", spellId, player->GetName());
                else
                    LOG_WARN("module", "[Hardcore] AddAura({}) returned null for {} — spell may lack SPELL_EFFECT_APPLY_AURA.",
                        spellId, player->GetName());
            }
        }
    }
    else if (_config.debug)
    {
        LOG_INFO("module", "[Hardcore] Buff disabled (spell ID = 0) for {}.", player->GetName());
    }

    ApplyTitle(player);
}

void HardcoreManager::RemoveBuff(Player* player)
{
    if (_config.soulOfIronSpellId != 0)
        player->RemoveAurasDueToSpell(_config.soulOfIronSpellId);
    if (_config.selfFoundSoulOfIronSpellId != 0)
        player->RemoveAurasDueToSpell(_config.selfFoundSoulOfIronSpellId);

    RemoveTitle(player);
}

void HardcoreManager::ApplyTitle(Player* player)
{
    uint32 guid = player->GetGUID().GetCounter();
    HardcoreData* data = GetData(guid);
    if (!data)
        return;

    bool isSelfFound = (data->mode == HardcoreMode::SelfFound);
    uint32 titleId = isSelfFound
        ? _config.selfFoundTitleId
        : _config.titleId;

    if (_config.debug)
        LOG_INFO("module", "[Hardcore] ApplyTitle: player={} configuredTitleId={} isSelfFound={}",
            player->GetName(), titleId, isSelfFound);

    if (titleId == 0)
    {
        if (_config.debug)
            LOG_INFO("module", "[Hardcore] Title disabled (configured ID = 0) for {}.", player->GetName());
        return;
    }

    // sCharTitlesStore.LookupEntry uses the DBC row ID (first column of CharTitles.dbc),
    // NOT the bit_index. Configure Hardcore.TitleId with the DBC row ID.
    CharTitlesEntry const* entry = sCharTitlesStore.LookupEntry(titleId);
    if (!entry)
    {
        LOG_WARN("module",
            "[Hardcore] Title DBC row ID {} not found in CharTitles.dbc — no title applied for {}. "
            "Check that Hardcore.TitleId is the DBC row ID (first column), not the bit_index.",
            titleId, player->GetName());
        return;
    }

    if (_config.debug)
        LOG_INFO("module",
            "[Hardcore] Resolved title: DBC ID={} bit_index={} name='{}' for {}.",
            entry->ID, entry->bit_index,
            entry->nameMale[0] ? entry->nameMale[0] : "<no name>",
            player->GetName());

    if (!player->HasTitle(entry))
    {
        player->SetTitle(entry);
        if (_config.debug)
            LOG_INFO("module", "[Hardcore] Added title bit_index={} to known titles for {}.",
                entry->bit_index, player->GetName());
    }

    player->SetCurrentTitle(entry);

    if (_config.debug)
        LOG_INFO("module", "[Hardcore] SetCurrentTitle bit_index={} applied to {}.",
            entry->bit_index, player->GetName());
}

void HardcoreManager::RemoveTitle(Player* player)
{
    auto removeOne = [&](uint32 titleId)
    {
        if (titleId == 0)
            return;
        CharTitlesEntry const* entry = sCharTitlesStore.LookupEntry(titleId);
        if (!entry)
            return;
        if (player->HasTitle(entry))
            player->SetTitle(entry, true);
        player->SetCurrentTitle(entry, true);
    };

    removeOne(_config.titleId);
    removeOne(_config.selfFoundTitleId);
}

// ---------------------------------------------------------------------------
// Auto-guild
// ---------------------------------------------------------------------------

void HardcoreManager::EnsureAndJoinGuild(Player* player)
{
    if (!_config.autoGuildEnable)
        return;

    if (player->GetGuildId() != 0)
    {
        if (_config.debug)
            LOG_INFO("module", "[Hardcore] {} is already in guild ID {} — skipping auto-add.",
                player->GetName(), player->GetGuildId());
        ChatHandler(player->GetSession()).PSendSysMessage(
            "You are already in a guild and could not be added to Deathwalkers automatically. "
            "Leave your current guild to join Deathwalkers.");
        return;
    }

    // Look for the Hardcore guild in the in-memory manager first.
    Guild* guild = sGuildMgr->GetGuildByName(_config.autoGuildName);

    if (_config.debug)
        LOG_INFO("module", "[Hardcore] EnsureAndJoinGuild: guild '{}' found in sGuildMgr = {}.",
            _config.autoGuildName, guild ? "YES" : "NO");

    if (!guild)
    {
        // Guard against orphaned guilds in DB left by previous runs where AddGuild was
        // never called (before this bug was fixed). Warn loudly if found.
        QueryResult dupResult = CharacterDatabase.Query(
            "SELECT guildid FROM guild WHERE name = '{}' ORDER BY guildid ASC",
            _config.autoGuildName);

        if (dupResult)
        {
            uint32 count = dupResult->GetRowCount();
            uint32 canonicalId = dupResult->Fetch()[0].Get<uint32>();

            if (count > 1)
            {
                LOG_ERROR("module",
                    "[Hardcore] Found {} guilds named '{}' in DB — duplicate guilds detected from a previous bug! "
                    "Using oldest guild (ID {}). Run the cleanup SQL in README to remove duplicates.",
                    count, _config.autoGuildName, canonicalId);
            }
            else
            {
                LOG_WARN("module",
                    "[Hardcore] Guild '{}' (ID {}) is in DB but not in sGuildMgr — orphaned from a previous run. "
                    "It will be picked up by LoadGuilds on the next restart. Creating a new one for this session.",
                    _config.autoGuildName, canonicalId);
            }
            // Fall through to create a new guild for THIS session. On the next restart,
            // LoadGuilds will load all DB guilds; the duplicate cleanup SQL should be run first.
        }

        // Create the Hardcore guild with this player as the founding leader.
        guild = new Guild();
        if (!guild->Create(player, _config.autoGuildName))
        {
            delete guild;
            LOG_ERROR("module", "[Hardcore] Failed to create guild '{}'.", _config.autoGuildName);
            ChatHandler(player->GetSession()).PSendSysMessage(
                "Could not create the Hardcore guild automatically. Please contact a GM.");
            return;
        }

        // CRITICAL: register in sGuildMgr so GetGuildByName finds it for all subsequent
        // Hardcore confirmations in this server session.
        sGuildMgr->AddGuild(guild);

        if (_config.debug)
            LOG_INFO("module", "[Hardcore] Created guild '{}' (ID {}) and registered in sGuildMgr.",
                _config.autoGuildName, guild->GetId());

        // Set the MOTD via the proper Guild API. The player is the guild leader and has
        // GR_RIGHT_SETMOTD. HandleSetMOTD updates both the in-memory object and the DB.
        guild->HandleSetMOTD(player->GetSession(), _config.autoGuildMotd);

        if (_config.debug)
            LOG_INFO("module", "[Hardcore] MOTD set for guild '{}' (ID {}).",
                _config.autoGuildName, guild->GetId());

        // By default AzerothCore gives Officer rank GR_RIGHT_ALL (which includes invite).
        // Strip the invite bit (0x10) from Officer so only the GuildMaster can invite.
        // GR_RIGHT_INVITE = GR_RIGHT_EMPTY(0x40) | 0x10 = 0x50.
        // The invite check is: (rights & GR_RIGHT_INVITE) != GR_RIGHT_EMPTY.
        // Removing 0x10 makes that false, blocking invites for the Officer rank.
        // Guild::GetRankInfo is private, so we update guild_rank directly. The in-memory
        // rank state for this session still has full rights, but no member will be at
        // Officer rank yet (all auto-added members use GR_MEMBER). Takes full effect after
        // the next server restart when LoadGuilds reads the corrected DB row.
        CharacterDatabase.Execute(
            "UPDATE guild_rank SET rights = rights & ~0x10 WHERE guildid = {} AND rid = {}",
            guild->GetId(), static_cast<uint8>(GR_OFFICER));

        if (_config.debug)
            LOG_INFO("module",
                "[Hardcore] Removed invite bit from Officer rank (DB) for guild '{}' (ID {}). "
                "Takes full in-memory effect on next restart.",
                _config.autoGuildName, guild->GetId());

        LOG_INFO("module", "[Hardcore] Guild '{}' (ID {}) created for Hardcore players.",
            _config.autoGuildName, guild->GetId());

        // The founding player is already the guild leader — no AddMember call needed.
        ChatHandler(player->GetSession()).PSendSysMessage(
            Acore::StringFormat(
                "You have founded {}. One life. No excuses.", _config.autoGuildName).c_str());

        if (_config.debug)
            LOG_INFO("module", "[Hardcore] {} is guild leader of '{}' (ID {}). GetGuildId={}.",
                player->GetName(), _config.autoGuildName, guild->GetId(), player->GetGuildId());
        return;
    }

    // Guild already exists — verify the MOTD matches config and correct it in DB if not.
    // The in-memory MOTD will only reflect the change after the next server restart
    // (when LoadGuilds re-reads the DB), which is acceptable for a cosmetic field.
    if (guild->GetMOTD() != _config.autoGuildMotd)
    {
        CharacterDatabase.Execute(
            "UPDATE guild SET motd = '{}' WHERE guildid = {}",
            _config.autoGuildMotd, guild->GetId());
        if (_config.debug)
            LOG_INFO("module",
                "[Hardcore] Corrected MOTD for guild '{}' (ID {}) in DB. Takes effect on next restart.",
                _config.autoGuildName, guild->GetId());
    }

    if (_config.debug)
        LOG_INFO("module", "[Hardcore] Adding {} to existing guild '{}' (ID {}). Player guildId before={}.",
            player->GetName(), _config.autoGuildName, guild->GetId(), player->GetGuildId());

    // Add the player as a regular Member rank so they have no invite rights by default.
    if (!guild->AddMember(player->GetGUID(), GR_MEMBER))
    {
        LOG_ERROR("module", "[Hardcore] Failed to add {} to guild '{}'.",
            player->GetName(), _config.autoGuildName);
        ChatHandler(player->GetSession()).PSendSysMessage(
            "Could not add you to the Hardcore guild. Please contact a GM.");
        return;
    }

    if (_config.debug)
        LOG_INFO("module", "[Hardcore] Added {} to '{}' (ID {}). Player guildId after={}.",
            player->GetName(), _config.autoGuildName, guild->GetId(), player->GetGuildId());

    ChatHandler(player->GetSession()).PSendSysMessage(
        Acore::StringFormat("You have joined {}. One life. No excuses.", _config.autoGuildName).c_str());
}

// ---------------------------------------------------------------------------
// Leaderboard
// ---------------------------------------------------------------------------

std::string HardcoreManager::BuildLeaderboard()
{
    uint32 limit = _config.leaderboardLimit > 0 ? _config.leaderboardLimit : 10;

    QueryResult result = CharacterDatabase.Query(
        "SELECT h.character_name, h.level_reached, h.mode, h.status, "
        "       c.class "
        "FROM mod_nostrum_hardcore h "
        "LEFT JOIN characters c ON c.guid = h.guid "
        "WHERE h.status IN (1, 2) "
        "ORDER BY h.level_reached DESC, h.status ASC, h.played_time ASC "
        "LIMIT {}",
        limit);

    if (!result)
        return "No Hardcore characters have been recorded yet.";

    std::string out = "Top Hardcore Survivors:\n\n";
    uint32 rank = 1;

    do
    {
        auto fields     = result->Fetch();
        std::string name     = fields[0].Get<std::string>();
        uint8 level          = fields[1].Get<uint8>();
        HardcoreMode mode    = static_cast<HardcoreMode>(fields[2].Get<uint8>());
        HardcoreStatus status= static_cast<HardcoreStatus>(fields[3].Get<uint8>());
        uint8 cls            = fields[4].Get<uint8>();

        std::string className;
        switch (cls)
        {
            case CLASS_WARRIOR:    className = "Warrior";     break;
            case CLASS_PALADIN:    className = "Paladin";     break;
            case CLASS_HUNTER:     className = "Hunter";      break;
            case CLASS_ROGUE:      className = "Rogue";       break;
            case CLASS_PRIEST:     className = "Priest";      break;
            case CLASS_DEATH_KNIGHT: className = "Death Knight"; break;
            case CLASS_SHAMAN:     className = "Shaman";      break;
            case CLASS_MAGE:       className = "Mage";        break;
            case CLASS_WARLOCK:    className = "Warlock";     break;
            case CLASS_DRUID:      className = "Druid";       break;
            default:               className = "Unknown";     break;
        }

        std::string statusStr = (status == HardcoreStatus::Active) ? "Alive" : "Fallen";
        std::string modeStr   = (mode == HardcoreMode::SelfFound)  ? "Self-Found" : "Hardcore";

        out += Acore::StringFormat("{}. {} - Level {} {} - {} - {}\n",
            rank, name, level, className, statusStr, modeStr);

        ++rank;
    } while (result->NextRow());

    return out;
}

// ---------------------------------------------------------------------------
// GM helpers
// ---------------------------------------------------------------------------

bool HardcoreManager::GMGetInfo(std::string const& playerName, std::string& outMsg)
{
    // Try online first
    ObjectGuid guid = sCharacterCache->GetCharacterGuidByName(playerName);
    if (!guid)
    {
        outMsg = "Character not found.";
        return false;
    }
    uint32 lowGuid = guid.GetCounter();

    QueryResult result = CharacterDatabase.Query(
        "SELECT h.character_name, h.mode, h.status, h.level_reached, h.played_time, "
        "       h.enabled_at, h.death_at, h.death_zone, h.death_killer "
        "FROM mod_nostrum_hardcore h "
        "WHERE h.guid = {}",
        lowGuid);

    if (!result)
    {
        outMsg = Acore::StringFormat("Player {} has no Hardcore record.", playerName);
        return true;
    }

    auto f = result->Fetch();
    std::string name      = f[0].Get<std::string>();
    uint8  mode           = f[1].Get<uint8>();
    uint8  status         = f[2].Get<uint8>();
    uint8  level          = f[3].Get<uint8>();
    uint32 playedTime     = f[4].Get<uint32>();
    uint32 enabledAt      = f[5].Get<uint32>();
    uint32 deathAt        = f[6].Get<uint32>();
    uint32 deathZone      = f[7].Get<uint32>();
    std::string killer    = f[8].Get<std::string>();

    std::string modeStr   = (mode == 2) ? "Self-Found" : "Hardcore";
    std::string statusStr;
    switch (static_cast<HardcoreStatus>(status))
    {
        case HardcoreStatus::Active:  statusStr = "Active";  break;
        case HardcoreStatus::Fallen:  statusStr = "Fallen";  break;
        case HardcoreStatus::Removed: statusStr = "Removed"; break;
        default:                      statusStr = "None";    break;
    }

    outMsg = Acore::StringFormat(
        "Player: {}\n"
        "Status: {}\n"
        "Mode: {}\n"
        "Level: {}\n"
        "Time Played: {}\n"
        "Enabled At: {}\n"
        "Death At: {}\n"
        "Death Zone: {}\n"
        "Killed By: {}",
        name, statusStr, modeStr, level,
        FormatTime(playedTime),
        enabledAt ? std::to_string(enabledAt) : "N/A",
        deathAt   ? std::to_string(deathAt)   : "N/A",
        deathZone ? GetZoneName(deathZone)     : "N/A",
        killer.empty() ? "N/A" : killer);

    return true;
}

bool HardcoreManager::GMRevive(std::string const& playerName, std::string& outMsg)
{
    ObjectGuid guid = sCharacterCache->GetCharacterGuidByName(playerName);
    if (!guid)
    {
        outMsg = "Character not found.";
        return false;
    }
    uint32 lowGuid = guid.GetCounter();

    CharacterDatabase.Execute(
        "UPDATE mod_nostrum_hardcore SET status = 1, death_at = NULL, death_zone = NULL, "
        "death_map = NULL, death_killer = NULL, revived_by_gm = 1 "
        "WHERE guid = {} AND status = 2",
        lowGuid);

    // Update memory if online
    auto it = _data.find(lowGuid);
    if (it != _data.end())
    {
        it->second.status     = HardcoreStatus::Active;
        it->second.deathAt    = 0;
        it->second.deathZone  = 0;
        it->second.deathMap   = 0;
        it->second.deathKiller.clear();
        it->second.revivedByGm = true;

        Player* player = ObjectAccessor::FindPlayer(guid);
        if (player)
            ApplyBuff(player);
    }

    outMsg = Acore::StringFormat("Hardcore status restored for {}.", playerName);
    return true;
}

bool HardcoreManager::GMRemove(std::string const& playerName, std::string& outMsg)
{
    ObjectGuid guid = sCharacterCache->GetCharacterGuidByName(playerName);
    if (!guid)
    {
        outMsg = "Character not found.";
        return false;
    }
    uint32 lowGuid = guid.GetCounter();

    CharacterDatabase.Execute(
        "UPDATE mod_nostrum_hardcore SET status = 3, removed_by_gm = 1 WHERE guid = {}",
        lowGuid);

    // Update memory if online
    auto it = _data.find(lowGuid);
    if (it != _data.end())
    {
        it->second.status     = HardcoreStatus::Removed;
        it->second.removedByGm = true;

        Player* player = ObjectAccessor::FindPlayer(guid);
        if (player)
            RemoveBuff(player);
    }

    outMsg = Acore::StringFormat("Hardcore status removed from {}.", playerName);
    return true;
}

// ---------------------------------------------------------------------------
// Static broadcast helper
// ---------------------------------------------------------------------------

void HardcoreManager::Broadcast(std::string const& msg)
{
    ChatHandler(nullptr).SendGlobalSysMessage(msg.c_str());
}

// ---------------------------------------------------------------------------
// Static time formatter
// ---------------------------------------------------------------------------

std::string HardcoreManager::FormatTime(uint32 seconds)
{
    uint32 days    = seconds / 86400;
    seconds       %= 86400;
    uint32 hours   = seconds / 3600;
    seconds       %= 3600;
    uint32 minutes = seconds / 60;

    if (days > 0)
        return Acore::StringFormat("{}d {}h {}m", days, hours, minutes);
    if (hours > 0)
        return Acore::StringFormat("{}h {}m", hours, minutes);
    return Acore::StringFormat("{}m", minutes);
}

// ---------------------------------------------------------------------------
// Private helpers
// ---------------------------------------------------------------------------

void HardcoreManager::LoadDataFromDB(uint32 guid)
{
    QueryResult result = CharacterDatabase.Query(
        "SELECT account_id, character_name, race, class, mode, status, "
        "       level_reached, played_time, UNIX_TIMESTAMP(enabled_at), "
        "       UNIX_TIMESTAMP(death_at), death_zone, death_map, death_killer, "
        "       revived_by_gm, removed_by_gm "
        "FROM mod_nostrum_hardcore WHERE guid = {}",
        guid);

    if (!result)
        return;

    auto f = result->Fetch();
    HardcoreData data;
    data.guid          = guid;
    data.accountId     = f[0].Get<uint32>();
    data.characterName = f[1].Get<std::string>();
    data.race          = f[2].Get<uint8>();
    data.playerClass   = f[3].Get<uint8>();
    data.mode          = static_cast<HardcoreMode>  (f[4].Get<uint8>());
    data.status        = static_cast<HardcoreStatus>(f[5].Get<uint8>());
    data.levelReached  = f[6].Get<uint8>();
    data.playedTime    = f[7].Get<uint32>();
    data.enabledAt     = static_cast<time_t>(f[8].Get<uint32>());
    data.deathAt       = static_cast<time_t>(f[9].Get<uint32>());
    data.deathZone     = f[10].Get<uint32>();
    data.deathMap      = f[11].Get<uint32>();
    data.deathKiller   = f[12].Get<std::string>();
    data.revivedByGm   = f[13].Get<bool>();
    data.removedByGm   = f[14].Get<bool>();

    _data[guid] = data;
}

void HardcoreManager::LoadFlagsFromDB(uint32 guid)
{
    QueryResult result = CharacterDatabase.Query(
        "SELECT death_count, has_traded, has_sent_mail, has_received_mail, has_used_auction_house "
        "FROM mod_nostrum_hardcore_flags WHERE guid = {}",
        guid);

    HardcoreFlags flags;
    flags.guid = guid;

    if (result)
    {
        auto f = result->Fetch();
        flags.deathCount          = f[0].Get<uint32>();
        flags.hasTraded           = f[1].Get<bool>();
        flags.hasSentMail         = f[2].Get<bool>();
        flags.hasReceivedMail     = f[3].Get<bool>();
        flags.hasUsedAuctionHouse = f[4].Get<bool>();
    }
    else
    {
        // First time this character logs in with the module — create the row
        CharacterDatabase.Execute(
            "INSERT IGNORE INTO mod_nostrum_hardcore_flags (guid) VALUES ({})", guid);
    }

    _flags[guid] = flags;
}

void HardcoreManager::SaveDataToDB(HardcoreData const& data)
{
    CharacterDatabase.Execute(
        "REPLACE INTO mod_nostrum_hardcore "
        "(guid, account_id, character_name, race, class, mode, status, "
        " level_reached, played_time, enabled_at, death_at, death_zone, death_map, "
        " death_killer, revived_by_gm, removed_by_gm) "
        "VALUES ({}, {}, '{}', {}, {}, {}, {}, {}, {}, "
        "FROM_UNIXTIME({}), {}, {}, {}, '{}', {}, {})",
        data.guid, data.accountId, data.characterName,
        data.race, data.playerClass,
        static_cast<uint8>(data.mode), static_cast<uint8>(data.status),
        data.levelReached, data.playedTime,
        static_cast<uint32>(data.enabledAt),
        data.deathAt  ? Acore::StringFormat("FROM_UNIXTIME({})", static_cast<uint32>(data.deathAt)) : "NULL",
        data.deathZone, data.deathMap,
        data.deathKiller,
        data.revivedByGm ? 1 : 0,
        data.removedByGm ? 1 : 0);
}

void HardcoreManager::SaveFlagField(uint32 guid, std::string const& field, uint32 value)
{
    CharacterDatabase.Execute(
        "UPDATE mod_nostrum_hardcore_flags SET {} = {} WHERE guid = {}",
        field, value, guid);
}

void HardcoreManager::IncrementDeathCount(uint32 guid)
{
    auto it = _flags.find(guid);
    if (it != _flags.end())
        ++(it->second.deathCount);

    CharacterDatabase.Execute(
        "UPDATE mod_nostrum_hardcore_flags SET death_count = death_count + 1 WHERE guid = {}",
        guid);
}

bool HardcoreManager::IsMilestoneAnnounced(uint32 guid, uint8 level)
{
    QueryResult result = CharacterDatabase.Query(
        "SELECT 1 FROM mod_nostrum_hardcore_milestones WHERE guid = {} AND milestone_level = {}",
        guid, level);
    return result != nullptr;
}

void HardcoreManager::SaveMilestone(uint32 guid, uint8 level)
{
    CharacterDatabase.Execute(
        "INSERT IGNORE INTO mod_nostrum_hardcore_milestones (guid, milestone_level) VALUES ({}, {})",
        guid, level);
}

std::string HardcoreManager::GetZoneName(uint32 zoneId)
{
    if (zoneId == 0)
        return "Unknown";

    AreaTableEntry const* area = sAreaTableStore.LookupEntry(zoneId);
    if (!area)
        return "Unknown";

    // Use locale index 0 (English / default)
    return area->area_name[0] ? area->area_name[0] : "Unknown";
}

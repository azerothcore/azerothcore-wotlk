/*
 * mod-nostrum-hardcore
 * Optional Hardcore and Self-Found Hardcore system for NostrumWoW.
 */

#ifndef HARDCORE_MANAGER_H
#define HARDCORE_MANAGER_H

#include "Define.h"
#include <ctime>
#include <set>
#include <string>
#include <unordered_map>
#include <unordered_set>

class Creature;
class Player;

enum class HardcoreMode : uint8
{
    None      = 0,
    Hardcore  = 1,
    SelfFound = 2,
};

enum class HardcoreStatus : uint8
{
    None    = 0,
    Active  = 1,
    Fallen  = 2,
    Removed = 3,
};

struct HardcoreData
{
    uint32        guid          = 0;
    uint32        accountId     = 0;
    std::string   characterName;
    uint8         race          = 0;
    uint8         playerClass   = 0;
    HardcoreMode  mode          = HardcoreMode::None;
    HardcoreStatus status       = HardcoreStatus::None;
    uint8         levelReached  = 1;
    uint32        playedTime    = 0;
    time_t        enabledAt     = 0;
    time_t        deathAt       = 0;
    uint32        deathZone     = 0;
    uint32        deathMap      = 0;
    std::string   deathKiller;
    bool          revivedByGm   = false;
    bool          removedByGm   = false;
};

struct HardcoreFlags
{
    uint32 guid                = 0;
    uint32 deathCount          = 0;
    bool   hasTraded           = false;
    bool   hasSentMail         = false;
    bool   hasReceivedMail     = false;
    bool   hasUsedAuctionHouse = false;
};

struct HardcoreConfig
{
    bool   enabled                   = true;
    bool   debug                     = false;

    // Eligibility
    uint32 maxPlayedSecondsToEnable  = 600;
    bool   requireLevelOne           = true;
    bool   requireZeroDeaths         = true;

    // Death rules
    bool   countPvEDeaths            = true;
    bool   countEnvironmentalDeaths  = true;
    bool   countDuelDeaths           = false;
    bool   countBattlegroundDeaths   = true;
    bool   countArenaDeaths          = true;
    bool   countWorldPvPDeaths       = true;

    // Fallen ghost behavior
    bool   fallenStayGhost           = true;
    bool   blockFallenResurrection   = true;

    // Cosmetic spell IDs (0 = disabled)
    uint32 soulOfIronSpellId         = 0;
    uint32 selfFoundSoulOfIronSpellId= 0;

    // Cosmetic title IDs (0 = disabled)
    uint32 titleId                   = 0;
    uint32 selfFoundTitleId          = 0;

    // Announcements
    bool          announceOptIn      = true;
    bool          announceDeaths     = true;
    bool          announceMilestones = true;
    std::set<uint8> milestoneLevels;

    // Leaderboard
    uint32 leaderboardLimit          = 10;

    // Self-Found restrictions
    bool   selfFoundBlockTrade       = true;
    bool   selfFoundBlockAuctionHouse= true;
    bool   selfFoundBlockPlayerMail  = true;

    // Hardcore restrictions
    bool   hardcoreBlockAuctionHouse = true;

    // Auto-guild
    bool        autoGuildEnable      = true;
    std::string autoGuildName        = "Deathwalkers";
    std::string autoGuildMotd        = "Welcome to Deathwalkers. One life. No excuses. Help each other survive.";
};

class HardcoreManager
{
public:
    static HardcoreManager* Instance();

    void LoadConfig();

    bool IsEnabled()             const { return _config.enabled; }
    HardcoreConfig const& Cfg()  const { return _config; }

    // --- Per-player state management ---
    void OnPlayerLogin(Player* player);
    void OnPlayerLogout(Player* player);

    // --- Data access ---
    HardcoreData*  GetData(uint32 guid);
    HardcoreFlags* GetFlags(uint32 guid);

    bool IsActive(uint32 guid);
    bool IsFallen(uint32 guid);
    bool IsHardcore(uint32 guid);         // mode == Hardcore (not SelfFound), online only
    bool IsSelfFound(uint32 guid);        // mode == SelfFound, online only
    bool IsSelfFoundAny(uint32 guid);     // mode == SelfFound, checks DB for offline characters

    // Returns active HC mode for guid; HardcoreMode::None if not enrolled or fallen.
    // Checks in-memory for online players and falls back to DB for offline.
    HardcoreMode GetActiveModeAny(uint32 guid);

    // True if guidA and guidB are allowed to trade/mail/group with each other.
    // Softcore<->Softcore and Hardcore<->Hardcore are allowed; all other pairings are not.
    // Self-Found is always isolated (blocked with everyone).
    bool CanInteract(uint32 guidA, uint32 guidB);

    // --- Confirmation flow ---
    void  SetPendingMode(Player* player, HardcoreMode mode);
    bool  HasValidPendingMode(Player* player);  // returns false if no pending or expired
    HardcoreMode GetPendingMode(Player* player);
    void  ClearPendingMode(Player* player);

    // Check eligibility and activate if valid
    bool  Confirm(Player* player, std::string& outError);

    // --- Eligibility ---
    bool  CheckEligibility(Player* player, HardcoreMode mode, std::string& outReason);

    // --- Resurrection safety net ---
    // Called from OnPlayerCanRepopAtGraveyard / OnPlayerCanResurrect.
    // If the player is active HC and dead but ProcessHCDeath was never called
    // (edge case: some environmental deaths slip past OnPlayerJustDied),
    // force-processes the death now so the fallen block fires correctly.
    void EnsureFallenIfDead(Player* player);

    // --- Death notification (called from script hooks) ---
    // Creature kill: mark death as handled, process if HC active
    void NotifyCreatureDeath(Creature* killer, Player* killed);
    // PvP kill: check PvP flag / BG / arena, mark as handled, process if needed
    void NotifyPvPDeath(Player* killer, Player* killed);
    // General death (OnPlayerJustDied): handles environmental deaths
    void NotifyGeneralDeath(Player* player);
    // Duel loss: exempt this player's next death from HC processing
    void NotifyDuelLoss(Player* loser);

    // --- Self-found eligibility flag setters ---
    void FlagTraded(uint32 guid);
    void FlagSentMail(uint32 guid);
    void FlagReceivedMail(uint32 guid);
    void FlagUsedAuctionHouse(uint32 guid);

    // --- Level milestone ---
    void OnLevelChanged(Player* player, uint8 oldLevel);

    // --- Buff management ---
    void ApplyBuff(Player* player);
    void RemoveBuff(Player* player);

    // --- Leaderboard ---
    std::string BuildLeaderboard();

    // --- Player self-service ---
    bool PlayerDisable(Player* player, std::string& outMsg);

    // --- GM helpers ---
    bool GMGetInfo(std::string const& playerName, std::string& outMsg);
    bool GMRevive(std::string const& playerName, std::string& outMsg);
    bool GMRemove(std::string const& playerName, std::string& outMsg);

    // Broadcast a yellow system chat message to all online players
    static void Broadcast(std::string const& msg);

    // Format played seconds -> "Xd Yh Zm" string
    static std::string FormatTime(uint32 seconds);

private:
    HardcoreManager() = default;

    void LoadDataFromDB(uint32 guid);
    void LoadFlagsFromDB(uint32 guid);
    void SaveDataToDB(HardcoreData const& data);
    void SaveFlagField(uint32 guid, std::string const& field, uint32 value);
    void IncrementDeathCount(uint32 guid);

    void ProcessHCDeath(Player* player, std::string const& killerName);
    void EnsureAndJoinGuild(Player* player);
    void ApplyTitle(Player* player);
    void RemoveTitle(Player* player);

    bool IsMilestoneAnnounced(uint32 guid, uint8 level);
    void SaveMilestone(uint32 guid, uint8 level);

    std::string GetZoneName(uint32 zoneId);

    HardcoreConfig _config;

    std::unordered_map<uint32, HardcoreData>  _data;    // guid -> HC record
    std::unordered_map<uint32, HardcoreFlags> _flags;   // guid -> eligibility flags

    struct PendingConf { HardcoreMode mode; time_t timestamp; };
    std::unordered_map<uint32, PendingConf>   _pending; // guid -> pending confirmation

    // Deaths already processed by creature/pvp hook; value = killer name
    std::unordered_map<uint32, std::string>   _handledDeaths;
    // Players who just lost a duel — exempt from next OnPlayerJustDied
    std::unordered_set<uint32>                _duelExempts;

    static constexpr uint32 CONFIRM_EXPIRE_SECONDS = 60;
};

#define sHardcoreMgr HardcoreManager::Instance()

#endif // HARDCORE_MANAGER_H

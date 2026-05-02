/*
 * mod-nostrum-hardcore
 *
 * Optional Hardcore and Self-Found Hardcore system for NostrumWoW.
 *
 * Players can opt into Hardcore on a fresh character using dot commands.
 * Death is permanent. Self-Found additionally disables trading, mail, and AH.
 *
 * Death detection strategy:
 *   - OnPlayerKilledByCreature / OnPlayerPVPKill fire BEFORE OnPlayerJustDied.
 *   - We mark creature/pvp deaths as "handled" and store the killer name.
 *   - OnPlayerJustDied then skips already-handled deaths; remaining are environmental.
 *   - OnPlayerDuelEnd exempts the loser from the next OnPlayerJustDied call.
 *
 * Mail blocking strategy:
 *   - Sending is blocked in OnPlayerCanSendMail (fires before MAIL_OK and before
 *     items leave inventory) for both Self-Found senders and Self-Found receivers.
 *   - OnBeforeMailDraftSendMailTo is used only for eligibility flagging.
 *     Setting sendMail=false there would silently destroy the sender's items
 *     because HandleSendMail already sent MAIL_OK and removed items by that point.
 */

#include "HardcoreManager.h"

#include "AuctionHouseScript.h"
#include "AuctionHouseMgr.h"
#include "Chat.h"
#include "ChatCommand.h"
#include "CommandScript.h"
#include "Creature.h"
#include "DatabaseEnv.h"
#include "Log.h"
#include "Mail.h"
#include "MailScript.h"
#include "MiscScript.h"
#include "ObjectGuid.h"
#include "Player.h"
#include "PlayerScript.h"
#include "SharedDefines.h"
#include "StringFormat.h"
#include "WorldScript.h"

// ---------------------------------------------------------------------------
// WorldScript — startup and config
// ---------------------------------------------------------------------------

class HardcoreWorldScript : public WorldScript
{
public:
    HardcoreWorldScript() : WorldScript("HardcoreWorldScript",
        { WORLDHOOK_ON_AFTER_CONFIG_LOAD, WORLDHOOK_ON_STARTUP })
    {
    }

    void OnAfterConfigLoad(bool reload) override
    {
        sHardcoreMgr->LoadConfig();
        if (reload)
            LOG_INFO("module", ">> Hardcore: config reloaded.");
    }

    void OnStartup() override
    {
        // Create tables at startup so the module is self-installing
        CharacterDatabase.Execute(
            "CREATE TABLE IF NOT EXISTS `mod_nostrum_hardcore` ("
            "  `guid`           INT UNSIGNED     NOT NULL,"
            "  `account_id`     INT UNSIGNED     NOT NULL,"
            "  `character_name` VARCHAR(12)      NOT NULL,"
            "  `race`           TINYINT UNSIGNED NOT NULL,"
            "  `class`          TINYINT UNSIGNED NOT NULL,"
            "  `mode`           TINYINT UNSIGNED NOT NULL COMMENT '1=Hardcore 2=SelfFound',"
            "  `status`         TINYINT UNSIGNED NOT NULL DEFAULT 1 COMMENT '1=Active 2=Fallen 3=Removed',"
            "  `level_reached`  TINYINT UNSIGNED NOT NULL DEFAULT 1,"
            "  `played_time`    INT UNSIGNED     NOT NULL DEFAULT 0,"
            "  `enabled_at`     TIMESTAMP        NOT NULL DEFAULT CURRENT_TIMESTAMP,"
            "  `death_at`       TIMESTAMP        NULL DEFAULT NULL,"
            "  `death_zone`     INT UNSIGNED     NULL DEFAULT NULL,"
            "  `death_map`      INT UNSIGNED     NULL DEFAULT NULL,"
            "  `death_killer`   VARCHAR(128)     NULL DEFAULT NULL,"
            "  `revived_by_gm`  TINYINT UNSIGNED NOT NULL DEFAULT 0,"
            "  `removed_by_gm`  TINYINT UNSIGNED NOT NULL DEFAULT 0,"
            "  PRIMARY KEY (`guid`),"
            "  INDEX `idx_hc_status_level` (`status`, `level_reached`),"
            "  INDEX `idx_hc_mode_status_level` (`mode`, `status`, `level_reached`)"
            ") ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci");

        CharacterDatabase.Execute(
            "CREATE TABLE IF NOT EXISTS `mod_nostrum_hardcore_flags` ("
            "  `guid`                   INT UNSIGNED     NOT NULL,"
            "  `death_count`            INT UNSIGNED     NOT NULL DEFAULT 0,"
            "  `has_traded`             TINYINT UNSIGNED NOT NULL DEFAULT 0,"
            "  `has_sent_mail`          TINYINT UNSIGNED NOT NULL DEFAULT 0,"
            "  `has_received_mail`      TINYINT UNSIGNED NOT NULL DEFAULT 0,"
            "  `has_used_auction_house` TINYINT UNSIGNED NOT NULL DEFAULT 0,"
            "  `updated_at`             TIMESTAMP        NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,"
            "  PRIMARY KEY (`guid`)"
            ") ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci");

        CharacterDatabase.Execute(
            "CREATE TABLE IF NOT EXISTS `mod_nostrum_hardcore_milestones` ("
            "  `guid`            INT UNSIGNED     NOT NULL,"
            "  `milestone_level` TINYINT UNSIGNED NOT NULL,"
            "  `announced_at`    TIMESTAMP        NOT NULL DEFAULT CURRENT_TIMESTAMP,"
            "  PRIMARY KEY (`guid`, `milestone_level`)"
            ") ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci");

        LOG_INFO("module", ">> Hardcore: tables ensured.");
    }
};

// ---------------------------------------------------------------------------
// PlayerScript — all player hooks
// ---------------------------------------------------------------------------

class HardcorePlayerScript : public PlayerScript
{
public:
    HardcorePlayerScript() : PlayerScript("HardcorePlayerScript",
        {
            PLAYERHOOK_ON_LOGIN,
            PLAYERHOOK_ON_LOGOUT,
            PLAYERHOOK_ON_PLAYER_JUST_DIED,
            PLAYERHOOK_ON_PVP_KILL,
            PLAYERHOOK_ON_PLAYER_KILLED_BY_CREATURE,
            PLAYERHOOK_ON_DUEL_END,
            PLAYERHOOK_ON_LEVEL_CHANGED,
            PLAYERHOOK_CAN_INIT_TRADE,
            PLAYERHOOK_CAN_SET_TRADE_ITEM,
            PLAYERHOOK_CAN_SEND_MAIL,
            PLAYERHOOK_CAN_PLACE_AUCTION_BID,
            PLAYERHOOK_CAN_RESURRECT,
            PLAYERHOOK_CAN_REPOP_AT_GRAVEYARD,
        })
    {
    }

    // ---- Lifecycle ----

    void OnPlayerLogin(Player* player) override
    {
        sHardcoreMgr->OnPlayerLogin(player);
    }

    void OnPlayerLogout(Player* player) override
    {
        sHardcoreMgr->OnPlayerLogout(player);
    }

    // ---- Death hooks ----
    // Note: OnPlayerKilledByCreature and OnPlayerPVPKill fire BEFORE OnPlayerJustDied.

    void OnPlayerKilledByCreature(Creature* killer, Player* killed) override
    {
        sHardcoreMgr->NotifyCreatureDeath(killer, killed);
    }

    void OnPlayerPVPKill(Player* killer, Player* killed) override
    {
        sHardcoreMgr->NotifyPvPDeath(killer, killed);
    }

    void OnPlayerJustDied(Player* player) override
    {
        // Handles environmental/fallthrough deaths not caught by the hooks above
        sHardcoreMgr->NotifyGeneralDeath(player);
    }

    // ---- Duel ----

    void OnPlayerDuelEnd(Player* /*winner*/, Player* loser, DuelCompleteType type) override
    {
        if (type == DUEL_WON)
            sHardcoreMgr->NotifyDuelLoss(loser);
    }

    // ---- Level milestones ----

    void OnPlayerLevelChanged(Player* player, uint8 oldLevel) override
    {
        sHardcoreMgr->OnLevelChanged(player, oldLevel);
    }

    // ---- Self-Found trade restrictions ----

    bool OnPlayerCanInitTrade(Player* player, Player* /*target*/) override
    {
        if (!sHardcoreMgr->IsEnabled())
            return true;

        uint32 guid = player->GetGUID().GetCounter();

        // Block if already Self-Found active
        if (sHardcoreMgr->IsSelfFound(guid) && sHardcoreMgr->Cfg().selfFoundBlockTrade)
        {
            ChatHandler(player->GetSession()).PSendSysMessage(
                "Self-Found Hardcore characters cannot trade.");
            return false;
        }

        // Flag for eligibility tracking (initiating a trade window flags the character)
        sHardcoreMgr->FlagTraded(guid);
        return true;
    }

    bool OnPlayerCanSetTradeItem(Player* player, Item* /*tradedItem*/, uint8 /*tradeSlot*/) override
    {
        if (!sHardcoreMgr->IsEnabled())
            return true;

        uint32 guid = player->GetGUID().GetCounter();

        if (sHardcoreMgr->IsSelfFound(guid) && sHardcoreMgr->Cfg().selfFoundBlockTrade)
        {
            ChatHandler(player->GetSession()).PSendSysMessage(
                "Self-Found Hardcore characters cannot trade.");
            return false;
        }

        return true;
    }

    // ---- Self-Found mail restrictions ----

    bool OnPlayerCanSendMail(Player* player, ObjectGuid receiverGuid, ObjectGuid /*mailbox*/,
        std::string& /*subject*/, std::string& /*body*/, uint32 /*money*/, uint32 /*COD*/, Item* /*item*/) override
    {
        if (!sHardcoreMgr->IsEnabled())
            return true;

        uint32 senderLow   = player->GetGUID().GetCounter();
        uint32 receiverLow = receiverGuid.GetCounter();

        // Block if sender is Self-Found — fires before MAIL_OK, safe to reject
        if (sHardcoreMgr->IsSelfFound(senderLow) && sHardcoreMgr->Cfg().selfFoundBlockPlayerMail)
        {
            ChatHandler(player->GetSession()).PSendSysMessage(
                "Self-Found Hardcore characters cannot use player mail.");
            return false;
        }

        // Block if receiver is Self-Found (online or offline) — also fires before MAIL_OK
        if (sHardcoreMgr->Cfg().selfFoundBlockPlayerMail &&
            senderLow != receiverLow &&
            sHardcoreMgr->IsSelfFoundAny(receiverLow))
        {
            ChatHandler(player->GetSession()).PSendSysMessage(
                "You cannot send mail to that player.");
            return false;
        }

        // Flag sender for Self-Found eligibility tracking
        sHardcoreMgr->FlagSentMail(senderLow);
        return true;
    }

    // ---- Self-Found Auction House restrictions (bidding/buying) ----

    bool OnPlayerCanPlaceAuctionBid(Player* player, AuctionEntry* /*auction*/) override
    {
        if (!sHardcoreMgr->IsEnabled())
            return true;

        uint32 guid = player->GetGUID().GetCounter();

        if (sHardcoreMgr->IsSelfFound(guid) && sHardcoreMgr->Cfg().selfFoundBlockAuctionHouse)
        {
            ChatHandler(player->GetSession()).PSendSysMessage(
                "Self-Found Hardcore characters cannot use the Auction House.");
            return false;
        }

        // Flag for eligibility tracking
        sHardcoreMgr->FlagUsedAuctionHouse(guid);
        return true;
    }

    // ---- Resurrection blocking for fallen characters ----

    bool OnPlayerCanRepopAtGraveyard(Player* player) override
    {
        if (!sHardcoreMgr->IsEnabled() || !sHardcoreMgr->Cfg().blockFallenResurrection)
            return true;

        uint32 guid = player->GetGUID().GetCounter();
        if (!sHardcoreMgr->IsFallen(guid))
            return true;

        ChatHandler(player->GetSession()).PSendSysMessage(
            "This Hardcore character has fallen. Resurrection is permanently disabled.");
        return false;
    }

    bool OnPlayerCanResurrect(Player* player) override
    {
        if (!sHardcoreMgr->IsEnabled() || !sHardcoreMgr->Cfg().blockFallenResurrection)
            return true;

        uint32 guid = player->GetGUID().GetCounter();
        if (!sHardcoreMgr->IsFallen(guid))
            return true;

        ChatHandler(player->GetSession()).PSendSysMessage(
            "This Hardcore character has fallen. Resurrection is permanently disabled.");
        return false;
    }
};

// ---------------------------------------------------------------------------
// AuctionHouseScript — track AH listing for Self-Found eligibility
// Note: OnAuctionAdd fires AFTER the auction is created; we can flag but not block.
// ---------------------------------------------------------------------------

class HardcoreAHScript : public AuctionHouseScript
{
public:
    HardcoreAHScript() : AuctionHouseScript("HardcoreAHScript",
        { AUCTIONHOUSEHOOK_ON_AUCTION_ADD })
    {
    }

    void OnAuctionAdd(AuctionHouseObject* /*ah*/, AuctionEntry* entry) override
    {
        if (!sHardcoreMgr->IsEnabled())
            return;

        // entry->owner is the character low GUID who listed the item
        uint32 ownerGuid = entry->owner.GetCounter();
        sHardcoreMgr->FlagUsedAuctionHouse(ownerGuid);

        // If the owner is Self-Found, we cannot undo the listing here.
        // TODO: AzerothCore module API has no pre-auction-create hook.
        // Document as known limitation. Eligibility flag prevents future Self-Found opt-in.
    }
};

// ---------------------------------------------------------------------------
// MailScript — block/track player-to-player mail for Self-Found
// ---------------------------------------------------------------------------

class HardcoreMailScript : public MailScript
{
public:
    HardcoreMailScript() : MailScript("HardcoreMailScript",
        { MAILHOOK_ON_BEFORE_MAIL_DRAFT_SEND_MAIL_TO })
    {
    }

    void OnBeforeMailDraftSendMailTo(MailDraft* /*mailDraft*/, MailReceiver const& receiver,
        MailSender const& sender, MailCheckMask& /*checked*/, uint32& /*deliver_delay*/,
        uint32& /*custom_expiration*/, bool& /*deleteMailItemsFromDB*/, bool& /*sendMail*/) override
    {
        if (!sHardcoreMgr->IsEnabled())
            return;

        // Only care about player-to-player mail (MAIL_NORMAL = 0)
        if (sender.GetMailMessageType() != MAIL_NORMAL)
            return;

        // Flag the receiver for Self-Found eligibility tracking only.
        // Do NOT set sendMail = false here: HandleSendMail already sent MAIL_OK to the
        // client and removed items from the sender's inventory before reaching this point.
        // Blocking here would silently destroy the sender's items. Blocking is done
        // earlier in OnPlayerCanSendMail, which fires before any of that happens.
        sHardcoreMgr->FlagReceivedMail(receiver.GetPlayerGUIDLow());
    }
};

// ---------------------------------------------------------------------------
// MiscScript — block AH NPC interaction for Self-Found characters
// CanSendAuctionHello fires before the AH window is sent to the client,
// so returning false prevents the player from seeing or using the AH at all.
// ---------------------------------------------------------------------------

class HardcoreMiscScript : public MiscScript
{
public:
    HardcoreMiscScript() : MiscScript("HardcoreMiscScript",
        { MISCHOOK_CAN_SEND_AUCTIONHELLO })
    {
    }

    bool CanSendAuctionHello(WorldSession const* session, ObjectGuid /*guid*/, Creature* /*creature*/) override
    {
        if (!sHardcoreMgr->IsEnabled())
            return true;

        Player* player = session->GetPlayer();
        if (!player)
            return true;

        uint32 guid = player->GetGUID().GetCounter();

        if (sHardcoreMgr->IsSelfFound(guid) && sHardcoreMgr->Cfg().selfFoundBlockAuctionHouse)
        {
            ChatHandler(player->GetSession()).PSendSysMessage(
                "Self-Found Hardcore characters cannot use the Auction House.");
            return false;
        }

        return true;
    }
};

// ---------------------------------------------------------------------------
// CommandScript — .hardcore commands
// ---------------------------------------------------------------------------

class HardcoreCommandScript : public CommandScript
{
public:
    HardcoreCommandScript() : CommandScript("HardcoreCommandScript") { }

    [[nodiscard]] std::vector<Acore::ChatCommands::ChatCommandBuilder> GetCommands() const override
    {
        using namespace Acore::ChatCommands;

        static std::vector<ChatCommandBuilder> hardcoreTable =
        {
            { "enable",      HandleHardcoreEnableCommand,     SEC_PLAYER,       Console::No },
            { "selffound",   HandleHardcoreSelfFoundCommand,  SEC_PLAYER,       Console::No },
            { "confirm",     HandleHardcoreConfirmCommand,    SEC_PLAYER,       Console::No },
            { "status",      HandleHardcoreStatusCommand,     SEC_PLAYER,       Console::No },
            { "rules",       HandleHardcoreRulesCommand,      SEC_PLAYER,       Console::No },
            { "leaderboard", HandleHardcoreLeaderboardCommand,SEC_PLAYER,       Console::No },
            { "info",        HandleHardcoreInfoGmCommand,     SEC_GAMEMASTER,   Console::No },
            { "revive",      HandleHardcoreReviveGmCommand,   SEC_GAMEMASTER,   Console::No },
            { "remove",      HandleHardcoreRemoveGmCommand,   SEC_ADMINISTRATOR,Console::No },
        };

        static std::vector<ChatCommandBuilder> commandTable =
        {
            { "hardcore", hardcoreTable },
        };

        return commandTable;
    }

    // ---- .hardcore enable ----

    static bool HandleHardcoreEnableCommand(ChatHandler* handler)
    {
        if (!sHardcoreMgr->IsEnabled())
        {
            handler->PSendSysMessage("The Hardcore system is currently disabled.");
            return true;
        }

        Player* player = handler->GetSession()->GetPlayer();
        std::string reason;
        if (!sHardcoreMgr->CheckEligibility(player, HardcoreMode::Hardcore, reason))
        {
            handler->PSendSysMessage("You are not eligible for Hardcore Mode.");
            handler->PSendSysMessage(Acore::StringFormat("Reason: {}", reason).c_str());
            return true;
        }

        sHardcoreMgr->SetPendingMode(player, HardcoreMode::Hardcore);

        handler->PSendSysMessage("You are about to begin Hardcore Mode.");
        handler->PSendSysMessage(" ");
        handler->PSendSysMessage("Rules:");
        handler->PSendSysMessage("- Death is permanent.");
        handler->PSendSysMessage("- PvE and environmental deaths count.");
        handler->PSendSysMessage("- Duel deaths do not count. Battleground, arena, and World PvP deaths count if the player is PvP-enabled/flagged or voluntarily joined the PvP activity.");
        handler->PSendSysMessage("- Trading, mail, and Auction House are allowed.");
        handler->PSendSysMessage("- PvP is optional.");
        handler->PSendSysMessage("- This cannot be undone.");
        handler->PSendSysMessage(" ");
        handler->PSendSysMessage("Type .hardcore confirm to begin.");
        return true;
    }

    // ---- .hardcore selffound ----

    static bool HandleHardcoreSelfFoundCommand(ChatHandler* handler)
    {
        if (!sHardcoreMgr->IsEnabled())
        {
            handler->PSendSysMessage("The Hardcore system is currently disabled.");
            return true;
        }

        Player* player = handler->GetSession()->GetPlayer();
        std::string reason;
        if (!sHardcoreMgr->CheckEligibility(player, HardcoreMode::SelfFound, reason))
        {
            handler->PSendSysMessage("You are not eligible for Self-Found Hardcore.");
            handler->PSendSysMessage(Acore::StringFormat("Reason: {}", reason).c_str());
            return true;
        }

        sHardcoreMgr->SetPendingMode(player, HardcoreMode::SelfFound);

        handler->PSendSysMessage("You are about to begin Hardcore Self-Found Mode.");
        handler->PSendSysMessage(" ");
        handler->PSendSysMessage("Rules:");
        handler->PSendSysMessage("- Death is permanent.");
        handler->PSendSysMessage("- Trading is disabled.");
        handler->PSendSysMessage("- Auction House is disabled.");
        handler->PSendSysMessage("- Player mail is disabled.");
        handler->PSendSysMessage("- PvP is optional.");
        handler->PSendSysMessage("- Duel deaths do not count. Battleground, arena, and World PvP deaths count if the player is PvP-enabled/flagged or voluntarily joined the PvP activity.");
        handler->PSendSysMessage("- This cannot be undone.");
        handler->PSendSysMessage(" ");
        handler->PSendSysMessage("Type .hardcore confirm to begin.");
        return true;
    }

    // ---- .hardcore confirm ----

    static bool HandleHardcoreConfirmCommand(ChatHandler* handler)
    {
        if (!sHardcoreMgr->IsEnabled())
        {
            handler->PSendSysMessage("The Hardcore system is currently disabled.");
            return true;
        }

        Player* player = handler->GetSession()->GetPlayer();
        std::string error;

        if (!sHardcoreMgr->HasValidPendingMode(player))
        {
            // Distinguish expired vs never set
            HardcoreMode pendingMode = sHardcoreMgr->GetPendingMode(player);
            if (pendingMode == HardcoreMode::None)
            {
                handler->PSendSysMessage("No Hardcore mode is pending confirmation.");
                handler->PSendSysMessage("Use .hardcore enable or .hardcore selffound first.");
            }
            else
            {
                handler->PSendSysMessage("Your Hardcore confirmation has expired.");
                handler->PSendSysMessage("Use .hardcore enable or .hardcore selffound again.");
                sHardcoreMgr->ClearPendingMode(player);
            }
            return true;
        }

        HardcoreMode pendingMode = sHardcoreMgr->GetPendingMode(player);

        if (!sHardcoreMgr->Confirm(player, error))
        {
            handler->PSendSysMessage(error.c_str());
            return true;
        }

        if (pendingMode == HardcoreMode::SelfFound)
        {
            handler->PSendSysMessage("Hardcore Self-Found enabled. Walk alone. Survive.");
        }
        else
        {
            handler->PSendSysMessage("Hardcore Mode enabled. Survive.");
        }

        return true;
    }

    // ---- .hardcore status ----

    static bool HandleHardcoreStatusCommand(ChatHandler* handler)
    {
        Player* player = handler->GetSession()->GetPlayer();
        uint32  guid   = player->GetGUID().GetCounter();

        if (!sHardcoreMgr->IsEnabled())
        {
            handler->PSendSysMessage("Hardcore Status: Not active (module disabled).");
            return true;
        }

        HardcoreData* data = sHardcoreMgr->GetData(guid);
        if (!data)
        {
            handler->PSendSysMessage("Hardcore Status: Not active");
            return true;
        }

        if (data->status == HardcoreStatus::Fallen)
        {
            handler->PSendSysMessage("Hardcore Status: Fallen — permanent ghost");
            handler->PSendSysMessage(Acore::StringFormat("Mode: {}",
                data->mode == HardcoreMode::SelfFound ? "Self-Found Hardcore" : "Hardcore").c_str());
            handler->PSendSysMessage(Acore::StringFormat("Level Reached: {}", data->levelReached).c_str());
            handler->PSendSysMessage(Acore::StringFormat("Time Played: {}", HardcoreManager::FormatTime(data->playedTime)).c_str());
            handler->PSendSysMessage(Acore::StringFormat("Killed by: {}", data->deathKiller.empty() ? "Unknown" : data->deathKiller).c_str());
            handler->PSendSysMessage("Resurrection is permanently disabled. Use .hardcore revive (GM only) to restore.");
            return true;
        }

        if (data->status == HardcoreStatus::Active)
        {
            bool selfFound = data->mode == HardcoreMode::SelfFound;

            handler->PSendSysMessage("Hardcore Status: Active");
            handler->PSendSysMessage(Acore::StringFormat("Mode: {}",
                selfFound ? "Self-Found Hardcore" : "Hardcore").c_str());
            handler->PSendSysMessage(Acore::StringFormat("Level: {}", player->GetLevel()).c_str());
            handler->PSendSysMessage(Acore::StringFormat("Time Played: {}",
                HardcoreManager::FormatTime(player->GetTotalPlayedTime())).c_str());
            handler->PSendSysMessage("PvP: Optional — use the in-game PvP toggle. Deaths while PvP-flagged count.");

            if (selfFound)
            {
                handler->PSendSysMessage("Trading: Disabled");
                handler->PSendSysMessage("Mail: Disabled");
                handler->PSendSysMessage("Auction House: Disabled");
            }
            return true;
        }

        handler->PSendSysMessage("Hardcore Status: Not active");
        return true;
    }

    // ---- .hardcore rules ----

    static bool HandleHardcoreRulesCommand(ChatHandler* handler)
    {
        handler->PSendSysMessage("Hardcore Rules:");
        handler->PSendSysMessage("- If you die, your character falls permanently.");
        handler->PSendSysMessage("- Fallen characters remain as permanent ghosts. Resurrection is disabled.");
        handler->PSendSysMessage("- Creature deaths count.");
        handler->PSendSysMessage("- Dungeon and raid deaths count.");
        handler->PSendSysMessage("- Falling, drowning, lava, fatigue, and other environmental deaths count.");
        handler->PSendSysMessage("- Duel deaths do not count.");
        handler->PSendSysMessage("- Battleground deaths count.");
        handler->PSendSysMessage("- Arena deaths count.");
        handler->PSendSysMessage("- PvP is optional. Use the normal in-game PvP toggle. If you die while PvP flagged, the death counts.");
        handler->PSendSysMessage("- World PvP deaths count if the character is PvP-flagged.");
        handler->PSendSysMessage(" ");
        handler->PSendSysMessage("Regular Hardcore:");
        handler->PSendSysMessage("- Trading is allowed.");
        handler->PSendSysMessage("- Mail is allowed.");
        handler->PSendSysMessage("- Auction House is allowed.");
        handler->PSendSysMessage(" ");
        handler->PSendSysMessage("Self-Found Hardcore:");
        handler->PSendSysMessage("- Trading is disabled.");
        handler->PSendSysMessage("- Auction House is disabled.");
        handler->PSendSysMessage("- Player mail is disabled.");
        return true;
    }

    // ---- .hardcore leaderboard ----

    static bool HandleHardcoreLeaderboardCommand(ChatHandler* handler)
    {
        if (!sHardcoreMgr->IsEnabled())
        {
            handler->PSendSysMessage("The Hardcore system is currently disabled.");
            return true;
        }

        std::string board = sHardcoreMgr->BuildLeaderboard();
        handler->PSendSysMessage(board.c_str());
        return true;
    }

    // ---- GM: .hardcore info <player> ----

    static bool HandleHardcoreInfoGmCommand(ChatHandler* handler, char const* args)
    {
        if (!args || !*args)
        {
            handler->PSendSysMessage("Usage: .hardcore info <player>");
            return false;
        }

        std::string playerName = args;
        std::string msg;
        if (!sHardcoreMgr->GMGetInfo(playerName, msg))
        {
            handler->PSendSysMessage(msg.c_str());
            return false;
        }

        handler->PSendSysMessage(msg.c_str());
        return true;
    }

    // ---- GM: .hardcore revive <player> ----

    static bool HandleHardcoreReviveGmCommand(ChatHandler* handler, char const* args)
    {
        if (!args || !*args)
        {
            handler->PSendSysMessage("Usage: .hardcore revive <player>");
            return false;
        }

        std::string playerName = args;
        std::string msg;
        bool ok = sHardcoreMgr->GMRevive(playerName, msg);
        handler->PSendSysMessage(msg.c_str());
        return ok;
    }

    // ---- Admin: .hardcore remove <player> ----

    static bool HandleHardcoreRemoveGmCommand(ChatHandler* handler, char const* args)
    {
        if (!args || !*args)
        {
            handler->PSendSysMessage("Usage: .hardcore remove <player>");
            return false;
        }

        std::string playerName = args;
        std::string msg;
        bool ok = sHardcoreMgr->GMRemove(playerName, msg);
        handler->PSendSysMessage(msg.c_str());
        return ok;
    }
};

// ---------------------------------------------------------------------------
// Module registration
// ---------------------------------------------------------------------------

void Addmod_nostrum_hardcoreScripts()
{
    new HardcoreWorldScript();
    new HardcorePlayerScript();
    new HardcoreAHScript();
    new HardcoreMailScript();
    new HardcoreMiscScript();
    new HardcoreCommandScript();
}

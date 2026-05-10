/*
 * mod-nostrum-starter
 *
 * Grants a one-time starter reward to fresh level-1 characters on first login.
 * Currently gives one Large Knapsack (12-slot bag).
 *
 * Designed to be extended later with additional new-character QoL features:
 * starter gold, learned spells, flight paths, welcome messages, etc.
 */

#include "Chat.h"
#include "Config.h"
#include "DatabaseEnv.h"
#include "Item.h"
#include "Log.h"
#include "Player.h"
#include "PlayerScript.h"
#include "WorldScript.h"

// ---------------------------------------------------------------------------
// Config
// ---------------------------------------------------------------------------

namespace
{

struct StarterConfig
{
    bool        enabled         = true;
    uint32      bagItemId       = 900100; // Nostrum Starter Bag
    uint32      bagCount        = 1;
    std::string welcomeMessage  = "Welcome to NostrumWoW! You have received a starter bag.";
};

StarterConfig gCfg;

void LoadConfig()
{
    gCfg.enabled        = sConfigMgr->GetOption<bool>       ("NostrumStarter.Enable",          true);
    gCfg.bagItemId      = sConfigMgr->GetOption<uint32>     ("NostrumStarter.Bag.ItemId",       1725);
    gCfg.bagCount       = sConfigMgr->GetOption<uint32>     ("NostrumStarter.Bag.Count",        1);
    gCfg.welcomeMessage = sConfigMgr->GetOption<std::string>("NostrumStarter.WelcomeMessage",
        "Welcome to NostrumWoW! You have received a starter bag.");

    LOG_INFO("module", ">> NostrumStarter: loaded. enabled={} bagItemId={} bagCount={}",
        gCfg.enabled, gCfg.bagItemId, gCfg.bagCount);
}

// ---------------------------------------------------------------------------
// Reward helpers
// ---------------------------------------------------------------------------

bool HasReceivedReward(uint32 guid)
{
    QueryResult result = CharacterDatabase.Query(
        "SELECT 1 FROM nostrum_starter_rewards WHERE guid = {}", guid);
    return result != nullptr;
}

void MarkRewarded(uint32 guid)
{
    CharacterDatabase.Execute(
        "INSERT IGNORE INTO nostrum_starter_rewards (guid, rewarded_at) VALUES ({}, UNIX_TIMESTAMP())",
        guid);
}

void TryGrantStarterBag(Player* player)
{
    uint32 guid = player->GetGUID().GetCounter();

    if (HasReceivedReward(guid))
    {
        LOG_DEBUG("module", "[NostrumStarter] {} (guid={}) already rewarded — skipping.",
            player->GetName(), guid);
        return;
    }

    if (player->GetLevel() != 1)
    {
        LOG_DEBUG("module", "[NostrumStarter] {} (guid={}) is level {} — skipping starter reward.",
            player->GetName(), guid, player->GetLevel());
        return;
    }

    // Attempt to store the bag in the main inventory.
    ItemPosCountVec dest;
    InventoryResult canStore = player->CanStoreNewItem(NULL_BAG, NULL_SLOT, dest, gCfg.bagItemId, gCfg.bagCount);
    if (canStore != EQUIP_ERR_OK)
    {
        LOG_WARN("module",
            "[NostrumStarter] Could not add starter bag (itemId={} count={}) to {}'s inventory — "
            "InventoryResult={}. Inventory may be full.",
            gCfg.bagItemId, gCfg.bagCount, player->GetName(), static_cast<uint32>(canStore));
        // Mark as rewarded anyway so we don't retry on every login.
        MarkRewarded(guid);
        return;
    }

    Item* item = player->StoreNewItem(dest, gCfg.bagItemId, true, 0);
    if (!item)
    {
        LOG_ERROR("module",
            "[NostrumStarter] StoreNewItem returned null for {} (guid={}). Reward not granted.",
            player->GetName(), guid);
        return;
    }

    // Notify the client so the item appears without a relog.
    player->SendNewItem(item, gCfg.bagCount, true, false);

    MarkRewarded(guid);

    if (!gCfg.welcomeMessage.empty())
        ChatHandler(player->GetSession()).PSendSysMessage(gCfg.welcomeMessage.c_str());

    LOG_INFO("module", "[NostrumStarter] Granted starter bag (itemId={}) to {} (guid={}).",
        gCfg.bagItemId, player->GetName(), guid);
}

} // anonymous namespace

// ---------------------------------------------------------------------------
// WorldScript — startup table creation + config loading
// ---------------------------------------------------------------------------

class NostrumStarterWorldScript : public WorldScript
{
public:
    NostrumStarterWorldScript() : WorldScript("NostrumStarterWorldScript",
        { WORLDHOOK_ON_AFTER_CONFIG_LOAD, WORLDHOOK_ON_STARTUP })
    {
    }

    void OnAfterConfigLoad(bool /*reload*/) override
    {
        LoadConfig();
    }

    void OnStartup() override
    {
        CharacterDatabase.Execute(
            "CREATE TABLE IF NOT EXISTS `nostrum_starter_rewards` ("
            "  `guid`        INT UNSIGNED NOT NULL,"
            "  `rewarded_at` INT UNSIGNED NOT NULL,"
            "  PRIMARY KEY (`guid`)"
            ") ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci");

        LOG_INFO("module", ">> NostrumStarter: table ensured.");
    }
};

// ---------------------------------------------------------------------------
// PlayerScript — first-login reward
// ---------------------------------------------------------------------------

class NostrumStarterPlayerScript : public PlayerScript
{
public:
    NostrumStarterPlayerScript() : PlayerScript("NostrumStarterPlayerScript",
        { PLAYERHOOK_ON_LOGIN, PLAYERHOOK_CAN_SELL_ITEM })
    {
    }

    void OnPlayerLogin(Player* player) override
    {
        if (!gCfg.enabled)
            return;

        TryGrantStarterBag(player);
    }

    bool OnPlayerCanSellItem(Player* player, Item* item, Creature* /*vendor*/) override
    {
        if (!gCfg.enabled)
            return true;

        if (item->GetEntry() == gCfg.bagItemId)
        {
            ChatHandler(player->GetSession()).PSendSysMessage("The starter bag cannot be sold.");
            return false;
        }

        return true;
    }
};

// ---------------------------------------------------------------------------
// Registration
// ---------------------------------------------------------------------------

void Addmod_nostrum_starterScripts()
{
    new NostrumStarterWorldScript();
    new NostrumStarterPlayerScript();
}

/*
 * mod-nostrum-peak
 *
 * Tracks the all-time peak concurrent online player count across restarts.
 * When a new record is set, a server-wide announcement is broadcast.
 *
 * Storage: single row in `mod_nostrum_peak_online` (acore_characters).
 * Count source: sWorldSessionMgr->GetPlayerCount() at login time.
 */

#include "DatabaseEnv.h"
#include "Player.h"
#include "PlayerScript.h"
#include "StringFormat.h"
#include "WorldScript.h"
#include "WorldSessionMgr.h"

#include <atomic>

static std::atomic<uint32> g_peakOnline{0};

// ---------------------------------------------------------------------------
// WorldScript — create table and load stored peak on startup
// ---------------------------------------------------------------------------

class PeakOnlineWorldScript : public WorldScript
{
public:
    PeakOnlineWorldScript() : WorldScript("PeakOnlineWorldScript",
        { WORLDHOOK_ON_STARTUP })
    {
    }

    void OnStartup() override
    {
        CharacterDatabase.Execute(
            "CREATE TABLE IF NOT EXISTS `mod_nostrum_peak_online` ("
            "  `id`          TINYINT UNSIGNED NOT NULL DEFAULT 1,"
            "  `peak_count`  INT UNSIGNED     NOT NULL DEFAULT 0,"
            "  `achieved_at` TIMESTAMP        NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,"
            "  PRIMARY KEY (`id`)"
            ") ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci");

        CharacterDatabase.Execute(
            "INSERT IGNORE INTO `mod_nostrum_peak_online` (`id`, `peak_count`) VALUES (1, 0)");

        QueryResult result = CharacterDatabase.Query(
            "SELECT `peak_count` FROM `mod_nostrum_peak_online` WHERE `id` = 1");

        if (result)
        {
            uint32 stored = result->Fetch()[0].Get<uint32>();
            g_peakOnline.store(stored);
            LOG_INFO("module", ">> Peak Online: loaded stored peak of {} players.", stored);
        }
    }
};

// ---------------------------------------------------------------------------
// PlayerScript — check and update peak on each login
// ---------------------------------------------------------------------------

class PeakOnlinePlayerScript : public PlayerScript
{
public:
    PeakOnlinePlayerScript() : PlayerScript("PeakOnlinePlayerScript",
        { PLAYERHOOK_ON_LOGIN })
    {
    }

    void OnPlayerLogin(Player* /*player*/) override
    {
        uint32 current = sWorldSessionMgr->GetPlayerCount();
        uint32 peak = g_peakOnline.load();

        if (current <= peak)
            return;

        // Update in-memory peak atomically (compare-exchange to avoid a race)
        if (!g_peakOnline.compare_exchange_strong(peak, current))
            return;

        CharacterDatabase.Execute(Acore::StringFormat(
            "UPDATE `mod_nostrum_peak_online` SET `peak_count` = {}, `achieved_at` = NOW() WHERE `id` = 1",
            current));

        std::string msg = Acore::StringFormat(
            "[NostrumWoW] New all-time peak: {} players online!", current);
        sWorldSessionMgr->SendServerMessage(SERVER_MSG_STRING, msg);

        LOG_INFO("module", ">> Peak Online: new record — {} players.", current);
    }
};

// ---------------------------------------------------------------------------

void Addmod_nostrum_peakScripts()
{
    new PeakOnlineWorldScript();
    new PeakOnlinePlayerScript();
}

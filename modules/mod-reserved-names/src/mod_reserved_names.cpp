/*
 * mod-reserved-names
 *
 * Blocks character creation when the requested name is reserved for a different
 * account in acore_auth.reserved_character_names.  The rightful account may
 * always claim their own reserved name.
 *
 * Hook strategy
 * -------------
 * CanPacketReceive (ServerScript):
 *   Fires before HandleCharCreateOpcode runs.  We copy the CMSG_CHAR_CREATE
 *   packet, read and normalise the name, and cache it per accountId so the
 *   AccountScript hook can retrieve it.
 *
 * CanAccountCreateCharacter (AccountScript):
 *   Fires inside the async callback chain that finalises character creation.
 *   We look up the cached name, query LoginDatabase synchronously, and reject
 *   (return false) if the name is reserved for a different account.
 *
 * Both hooks run on the world-update thread (PROCESS_THREADUNSAFE), so no
 * mutex is needed on the pending-name map.
 */

#include "AccountScript.h"
#include "Config.h"
#include "DatabaseEnv.h"
#include "Log.h"
#include "ObjectMgr.h"
#include "Opcodes.h"
#include "ServerScript.h"
#include "WorldPacket.h"
#include "WorldScript.h"
#include "WorldSession.h"

#include <unordered_map>
#include <string>

// ---------------------------------------------------------------------------
// Module state
// ---------------------------------------------------------------------------

namespace
{

struct ReservedNamesConfig
{
    bool enabled        = true;
    bool deleteOnClaim  = false;
};

ReservedNamesConfig gCfg;

// Keyed by accountId; holds the normalised character name from the most recent
// CMSG_CHAR_CREATE packet received for that session.
std::unordered_map<uint32, std::string> gPendingNames;

void LoadConfig()
{
    gCfg.enabled       = sConfigMgr->GetOption<bool>("ReservedNames.Enable",                          true);
    gCfg.deleteOnClaim = sConfigMgr->GetOption<bool>("ReservedNames.DeleteReservationOnSuccessfulClaim", false);

    LOG_INFO("module", ">> ReservedNames: loaded. enabled={} deleteOnClaim={}",
        gCfg.enabled, gCfg.deleteOnClaim);
}

} // anonymous namespace

// ---------------------------------------------------------------------------
// WorldScript — config + table bootstrap
// ---------------------------------------------------------------------------

class ReservedNamesWorldScript : public WorldScript
{
public:
    ReservedNamesWorldScript() : WorldScript("ReservedNamesWorldScript",
        { WORLDHOOK_ON_AFTER_CONFIG_LOAD, WORLDHOOK_ON_STARTUP })
    {
    }

    void OnAfterConfigLoad(bool /*reload*/) override
    {
        LoadConfig();
    }

    void OnStartup() override
    {
        LoginDatabase.Execute(
            "CREATE TABLE IF NOT EXISTS `reserved_character_names` ("
            "  `name`          VARCHAR(12)      NOT NULL,"
            "  `account_id`    INT UNSIGNED     NOT NULL,"
            "  `original_guid` INT UNSIGNED     NULL,"
            "  `race`          TINYINT UNSIGNED NULL,"
            "  `class`         TINYINT UNSIGNED NULL,"
            "  `gender`        TINYINT UNSIGNED NULL,"
            "  `reserved_at`   TIMESTAMP        DEFAULT CURRENT_TIMESTAMP,"
            "  PRIMARY KEY (`name`)"
            ") ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci");

        LOG_INFO("module", ">> ReservedNames: table ensured.");
    }
};

// ---------------------------------------------------------------------------
// ServerScript — capture character name from CMSG_CHAR_CREATE
// ---------------------------------------------------------------------------

class ReservedNamesServerScript : public ServerScript
{
public:
    ReservedNamesServerScript() : ServerScript("ReservedNamesServerScript",
        { SERVERHOOK_CAN_PACKET_RECEIVE })
    {
    }

    bool CanPacketReceive(WorldSession* session, WorldPacket const& packet) override
    {
        if (!gCfg.enabled)
            return true;

        if (packet.GetOpcode() != CMSG_CHAR_CREATE)
            return true;

        if (!session)
            return true;

        // Copy the packet so we can read from it without affecting the original.
        WorldPacket pkt(packet);

        std::string name;
        pkt >> name;

        if (!normalizePlayerName(name))
            return true; // empty / invalid; let the normal handler reject it

        gPendingNames[session->GetAccountId()] = name;
        return true;
    }
};

// ---------------------------------------------------------------------------
// AccountScript — enforce reservation
// ---------------------------------------------------------------------------

class ReservedNamesAccountScript : public AccountScript
{
public:
    ReservedNamesAccountScript() : AccountScript("ReservedNamesAccountScript",
        { ACCOUNTHOOK_CAN_ACCOUNT_CREATE_CHARACTER })
    {
    }

    bool CanAccountCreateCharacter(uint32 accountId, uint8 /*charRace*/, uint8 /*charClass*/) override
    {
        if (!gCfg.enabled)
            return true;

        auto it = gPendingNames.find(accountId);
        if (it == gPendingNames.end())
            return true; // no name captured (shouldn't happen in normal flow)

        std::string name = it->second;
        gPendingNames.erase(it);

        // Escape before embedding in a format query.
        std::string escapedName = name;
        LoginDatabase.EscapeString(escapedName);

        QueryResult result = LoginDatabase.Query(
            "SELECT account_id FROM reserved_character_names WHERE name = '{}'",
            escapedName);

        if (!result)
            return true; // name is not reserved — allow

        Field* fields = result->Fetch();
        uint32 reservedAccountId = fields[0].Get<uint32>();

        if (reservedAccountId == accountId)
        {
            LOG_INFO("module",
                "[ReservedNames] Account {} successfully claimed reserved name '{}'.",
                accountId, name);

            if (gCfg.deleteOnClaim)
            {
                LoginDatabase.Execute(
                    "DELETE FROM reserved_character_names WHERE name = '{}'",
                    escapedName);
            }

            return true; // rightful owner — allow
        }

        LOG_WARN("module",
            "[ReservedNames] Account {} attempted to create character with name '{}', "
            "which is reserved for account {}. Creation denied.",
            accountId, name, reservedAccountId);

        return false; // wrong account — deny; engine sends CHAR_CREATE_DISABLED
    }
};

// ---------------------------------------------------------------------------
// Registration
// ---------------------------------------------------------------------------

void Addmod_reserved_namesScripts()
{
    new ReservedNamesWorldScript();
    new ReservedNamesServerScript();
    new ReservedNamesAccountScript();
}

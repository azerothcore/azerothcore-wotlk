#include "VaultMgr.h"
#include "mod_branding_loader.h"
#include "Chat.h"
#include "CommandScript.h"
#include "Player.h"
#include "RBAC.h"
#include "ScriptMgr.h"

using namespace Acore::ChatCommands;
using namespace Branding;

namespace
{
    void ReportResult(ChatHandler* handler, VaultOpResult result, uint32 itemEntry, uint32 count)
    {
        switch (result)
        {
            case VaultOpResult::Ok:
                handler->PSendSysMessage("Vault: {} x item {} done.", count, itemEntry);
                break;
            case VaultOpResult::Mailed:
                handler->PSendSysMessage("Vault: {} x item {} withdrawn (bags full -> mailed).", count, itemEntry);
                break;
            case VaultOpResult::Disabled:
                handler->SendErrorMessage("The account vault is disabled on this realm.");
                break;
            case VaultOpResult::EmptyQuantity:
                handler->SendErrorMessage("Specify a valid item entry and a count above zero.");
                break;
            case VaultOpResult::CapacityExceeded:
                handler->SendErrorMessage("The account vault is full.");
                break;
            case VaultOpResult::InsufficientFunds:
                handler->SendErrorMessage("You cannot afford the deposit fee.");
                break;
            case VaultOpResult::NotEnoughItems:
                handler->SendErrorMessage("You do not have that many of item {} to deposit.", itemEntry);
                break;
            case VaultOpResult::NotStored:
                handler->SendErrorMessage("The vault does not hold that many of item {}.", itemEntry);
                break;
        }
    }
}

// Loads/refreshes vault config on startup and on `.reload config`.
class BrandingVaultWorldScript : public WorldScript
{
public:
    BrandingVaultWorldScript() : WorldScript("BrandingVaultWorldScript") { }

    void OnAfterConfigLoad(bool /*reload*/) override
    {
        sVaultMgr->LoadConfig();
    }
};

// Caches the account's vault on login and drops it on logout (account-scoped, no Player* retained).
class BrandingVaultPlayerScript : public PlayerScript
{
public:
    BrandingVaultPlayerScript() : PlayerScript("BrandingVaultPlayerScript") { }

    void OnPlayerLogin(Player* player) override
    {
        if (!player || !sVaultMgr->Enabled())
            return;

        sVaultMgr->LoadAccount(player->GetSession()->GetAccountId());
    }

    void OnPlayerLogout(Player* player) override
    {
        if (!player)
            return;

        // State is persisted on every op, so dropping the cache here is safe. (A multi-character
        // online account reloads cheaply on the next op via the login hook.)
        sVaultMgr->UnloadAccount(player->GetSession()->GetAccountId());
    }
};

// `.vault` -- account-shared stash: deposit (with friction), withdraw, list (§13). v1 command UI.
class branding_vault_commandscript : public CommandScript
{
public:
    branding_vault_commandscript() : CommandScript("branding_vault_commandscript") { }

    ChatCommandTable GetCommands() const override
    {
        static ChatCommandTable vaultCommandTable =
        {
            { "deposit",  HandleVaultDepositCommand,  rbac::RBAC_PERM_COMMAND_GM, Console::No },
            { "withdraw", HandleVaultWithdrawCommand, rbac::RBAC_PERM_COMMAND_GM, Console::No },
            { "list",     HandleVaultListCommand,     rbac::RBAC_PERM_COMMAND_GM, Console::No },
        };

        static ChatCommandTable commandTable =
        {
            { "vault", vaultCommandTable },
        };
        return commandTable;
    }

    static bool HandleVaultDepositCommand(ChatHandler* handler, uint32 itemEntry, uint32 count)
    {
        Player* player = handler->GetPlayer();
        if (!player)
        {
            handler->SendErrorMessage("This command must be used in-world.");
            return false;
        }

        if (count > 0 && itemEntry > 0)
            handler->PSendSysMessage("Deposit fee: {} copper.", sVaultMgr->DepositCost(count));

        ReportResult(handler, sVaultMgr->Deposit(player, itemEntry, count), itemEntry, count);
        return true;
    }

    static bool HandleVaultWithdrawCommand(ChatHandler* handler, uint32 itemEntry, uint32 count)
    {
        Player* player = handler->GetPlayer();
        if (!player)
        {
            handler->SendErrorMessage("This command must be used in-world.");
            return false;
        }

        ReportResult(handler, sVaultMgr->Withdraw(player, itemEntry, count), itemEntry, count);
        return true;
    }

    static bool HandleVaultListCommand(ChatHandler* handler)
    {
        Player* player = handler->GetPlayer();
        if (!player)
        {
            handler->SendErrorMessage("This command must be used in-world.");
            return false;
        }
        if (!sVaultMgr->Enabled())
        {
            handler->SendErrorMessage("The account vault is disabled on this realm.");
            return true;
        }

        uint32 const accountId = player->GetSession()->GetAccountId();
        auto const contents = sVaultMgr->Contents(accountId);

        handler->PSendSysMessage("Account vault: {} / {} units stored.",
            sVaultMgr->StoredTotal(accountId), sVaultMgr->Capacity());
        if (contents.empty())
            handler->PSendSysMessage("  (empty)");
        for (auto const& [entry, count] : contents)
            handler->PSendSysMessage("  item {}: {}", entry, count);

        return true;
    }
};

void AddBrandingVaultScripts()
{
    new BrandingVaultWorldScript();
    new BrandingVaultPlayerScript();
    new branding_vault_commandscript();
}

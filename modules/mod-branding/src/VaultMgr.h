#ifndef MOD_BRANDING_SRC_VAULTMGR_H
#define MOD_BRANDING_SRC_VAULTMGR_H

#include "VaultConfig.h"
#include "vault/Vault.h"
#include <cstdint>
#include <map>
#include <unordered_map>
#include <vector>

class Player;

namespace Branding
{
    // Outcome of a deposit/withdraw request -- the script layer turns this into a player message.
    enum class VaultOpResult : uint8_t
    {
        Disabled = 0,       // vault feature off
        Ok,                 // stored / delivered
        EmptyQuantity,      // requested 0
        CapacityExceeded,   // vault full
        InsufficientFunds,  // cannot pay the deposit friction
        NotEnoughItems,     // player lacks the items to deposit
        NotStored,          // tried to withdraw more than is banked
        Mailed              // withdraw succeeded but bags were full -> mailed
    };

    // Adapter manager for the account vault (§13). Owns a per-account cache of banked stacks keyed
    // by account id (account-scoped, never a raw Player*). Deposit charges VaultTransferCost friction
    // and enforces VaultCanStore capacity via the pure-core planners; withdraw hands items back
    // through RewardDelivery (inventory, mail fallback).
    class VaultMgr
    {
    public:
        static VaultMgr* instance();

        void LoadConfig();
        bool Enabled() const { return _config.Enabled(); }
        uint32_t Capacity() const { return _config.Capacity(); }

        // Lifecycle: load on first need / login, drop the cache when the last char logs out.
        void LoadAccount(uint32_t accountId);
        void UnloadAccount(uint32_t accountId);

        // Total units banked for the account (across all item entries) -- the capacity dimension.
        uint32_t StoredTotal(uint32_t accountId) const;
        // Banked count of a specific item entry.
        uint32_t StoredCount(uint32_t accountId, uint32_t itemEntry) const;
        // Snapshot of all banked stacks (entry -> count), for UI listing.
        std::vector<std::pair<uint32_t, uint32_t>> Contents(uint32_t accountId) const;

        // Friction cost the player would pay to deposit `count` units (for UI / confirmation).
        uint32_t DepositCost(uint32_t count) const;

        // Move `count` of `itemEntry` from the player's bags into the account vault, charging
        // friction. Persists immediately (account-shared state must survive any character logout).
        VaultOpResult Deposit(Player* player, uint32_t itemEntry, uint32_t count);

        // Move `count` of `itemEntry` from the vault back to the player (RewardDelivery). Free.
        VaultOpResult Withdraw(Player* player, uint32_t itemEntry, uint32_t count);

    private:
        VaultMgr() = default;

        using ItemMap = std::map<uint32_t, uint32_t>;  // item_entry -> count (ordered for stable UI)

        ItemMap& Cache(uint32_t accountId);
        void PersistStack(uint32_t accountId, uint32_t itemEntry, uint32_t newCount);

        VaultConfig _config;
        std::unordered_map<uint32_t, ItemMap> _accounts;
    };
}

#define sVaultMgr Branding::VaultMgr::instance()

#endif // MOD_BRANDING_SRC_VAULTMGR_H

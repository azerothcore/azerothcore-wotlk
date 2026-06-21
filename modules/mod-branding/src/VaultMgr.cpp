#include "VaultMgr.h"
#include "RewardDelivery.h"
#include "DatabaseEnv.h"
#include "Player.h"

namespace Branding
{
    VaultMgr* VaultMgr::instance()
    {
        static VaultMgr mgr;
        return &mgr;
    }

    void VaultMgr::LoadConfig()
    {
        _config.Load();
    }

    VaultMgr::ItemMap& VaultMgr::Cache(uint32_t accountId)
    {
        return _accounts[accountId];
    }

    void VaultMgr::LoadAccount(uint32_t accountId)
    {
        ItemMap& items = _accounts[accountId];
        items.clear();

        // NOTE: blocking read on the login path for simplicity (tiny, PK-indexed). TODO: move to the
        // async query path once running under a full build, per project DB convention.
        QueryResult result = LoginDatabase.Query(
            "SELECT `item_entry`, `count` FROM `account_vault` WHERE `account` = {}", accountId);
        if (!result)
            return;

        do
        {
            Field* fields = result->Fetch();
            uint32 const entry = fields[0].Get<uint32>();
            uint32 const count = fields[1].Get<uint32>();
            if (entry != 0 && count != 0)
                items[entry] = count;
        } while (result->NextRow());
    }

    void VaultMgr::UnloadAccount(uint32_t accountId)
    {
        _accounts.erase(accountId);
    }

    uint32_t VaultMgr::StoredTotal(uint32_t accountId) const
    {
        auto it = _accounts.find(accountId);
        if (it == _accounts.end())
            return 0;

        uint64_t total = 0;
        for (auto const& [entry, count] : it->second)
            total += count;

        return total > 0xFFFFFFFFu ? 0xFFFFFFFFu : static_cast<uint32_t>(total);
    }

    uint32_t VaultMgr::StoredCount(uint32_t accountId, uint32_t itemEntry) const
    {
        auto it = _accounts.find(accountId);
        if (it == _accounts.end())
            return 0;

        auto entryIt = it->second.find(itemEntry);
        return entryIt != it->second.end() ? entryIt->second : 0;
    }

    std::vector<std::pair<uint32_t, uint32_t>> VaultMgr::Contents(uint32_t accountId) const
    {
        std::vector<std::pair<uint32_t, uint32_t>> out;
        auto it = _accounts.find(accountId);
        if (it == _accounts.end())
            return out;

        out.reserve(it->second.size());
        for (auto const& [entry, count] : it->second)
            out.emplace_back(entry, count);

        return out;
    }

    uint32_t VaultMgr::DepositCost(uint32_t count) const
    {
        return VaultTransferCost(count, _config);
    }

    void VaultMgr::PersistStack(uint32_t accountId, uint32_t itemEntry, uint32_t newCount)
    {
        if (newCount == 0)
        {
            LoginDatabase.Execute(
                "DELETE FROM `account_vault` WHERE `account` = {} AND `item_entry` = {}",
                accountId, itemEntry);
            return;
        }

        LoginDatabase.Execute(
            "REPLACE INTO `account_vault` (`account`, `item_entry`, `count`) VALUES ({}, {}, {})",
            accountId, itemEntry, newCount);
    }

    VaultOpResult VaultMgr::Deposit(Player* player, uint32_t itemEntry, uint32_t count)
    {
        if (!_config.Enabled())
            return VaultOpResult::Disabled;
        if (!player || itemEntry == 0 || count == 0)
            return VaultOpResult::EmptyQuantity;

        uint32 const accountId = player->GetSession()->GetAccountId();
        ItemMap& items = Cache(accountId);

        VaultDepositPlan const plan = PlanDeposit(StoredTotal(accountId), count, player->GetMoney(), _config);
        if (!plan.allowed)
        {
            switch (plan.reason)
            {
                case VaultDepositReason::CapacityExceeded:  return VaultOpResult::CapacityExceeded;
                case VaultDepositReason::InsufficientFunds: return VaultOpResult::InsufficientFunds;
                default:                                    return VaultOpResult::EmptyQuantity;
            }
        }

        // The player must actually hold the items being deposited.
        if (player->GetItemCount(itemEntry, false) < count)
            return VaultOpResult::NotEnoughItems;

        // Charge friction and remove the items, then bank them.
        player->ModifyMoney(-static_cast<int32>(plan.cost));
        player->DestroyItemCount(itemEntry, count, true, false);

        uint32_t const newCount = items[itemEntry] + count;
        items[itemEntry] = newCount;
        PersistStack(accountId, itemEntry, newCount);
        return VaultOpResult::Ok;
    }

    VaultOpResult VaultMgr::Withdraw(Player* player, uint32_t itemEntry, uint32_t count)
    {
        if (!_config.Enabled())
            return VaultOpResult::Disabled;
        if (!player || itemEntry == 0 || count == 0)
            return VaultOpResult::EmptyQuantity;

        uint32 const accountId = player->GetSession()->GetAccountId();
        ItemMap& items = Cache(accountId);

        uint32_t const stored = StoredCount(accountId, itemEntry);
        VaultWithdrawPlan const plan = PlanWithdraw(stored, count);
        if (!plan.allowed)
            return VaultOpResult::NotStored;

        // Decrement the bank first; if delivery falls back to mail the items still leave the vault.
        uint32_t const newCount = stored - plan.amount;
        if (newCount == 0)
            items.erase(itemEntry);
        else
            items[itemEntry] = newCount;
        PersistStack(accountId, itemEntry, newCount);

        DeliveryResult const delivered = DeliverItem(player, itemEntry, plan.amount,
            "Account Vault Withdrawal", "Items withdrawn from your account vault.");
        return delivered == DeliveryResult::Mailed ? VaultOpResult::Mailed : VaultOpResult::Ok;
    }
}

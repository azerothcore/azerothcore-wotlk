#include "Vault.h"

namespace Branding
{
    uint32_t VaultTransferCost(uint32_t quantity, IVaultConfig const& cfg)
    {
        if (quantity == 0)
            return 0;

        return cfg.TransferBaseCost() + cfg.TransferCostPerUnit() * quantity;
    }

    bool VaultCanStore(uint32_t currentCount, uint32_t addCount, IVaultConfig const& cfg)
    {
        return static_cast<uint64_t>(currentCount) + addCount <= cfg.Capacity();
    }

    VaultDepositPlan PlanDeposit(uint32_t currentCount, uint32_t requested, uint64_t availableFunds,
        IVaultConfig const& cfg)
    {
        VaultDepositPlan plan;
        if (requested == 0)
        {
            plan.reason = VaultDepositReason::EmptyQuantity;
            return plan;
        }

        if (!VaultCanStore(currentCount, requested, cfg))
        {
            plan.reason = VaultDepositReason::CapacityExceeded;
            return plan;
        }

        plan.cost = VaultTransferCost(requested, cfg);
        if (plan.cost > availableFunds)
        {
            plan.reason = VaultDepositReason::InsufficientFunds;
            return plan;
        }

        plan.allowed = true;
        plan.reason = VaultDepositReason::Ok;
        return plan;
    }

    VaultWithdrawPlan PlanWithdraw(uint32_t storedCount, uint32_t requested)
    {
        VaultWithdrawPlan plan;
        if (requested == 0 || requested > storedCount)
            return plan;

        plan.allowed = true;
        plan.amount = requested;
        return plan;
    }
}

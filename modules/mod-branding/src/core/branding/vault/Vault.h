#ifndef MOD_BRANDING_CORE_VAULT_VAULT_H
#define MOD_BRANDING_CORE_VAULT_VAULT_H

#include <cstdint>

namespace Branding
{
    // Account vault tunables (§13). Transfer friction prevents instant infinite-storage abuse.
    class IVaultConfig
    {
    public:
        virtual ~IVaultConfig() = default;
        virtual uint32_t Capacity() const = 0;
        virtual uint32_t TransferBaseCost() const = 0;
        virtual uint32_t TransferCostPerUnit() const = 0;
    };

    // §13: friction cost to deposit `quantity` units. 0 for nothing; otherwise base + per-unit
    // (so even a single unit carries the base friction). Monotonic non-decreasing in quantity.
    uint32_t VaultTransferCost(uint32_t quantity, IVaultConfig const& cfg);

    // §13: can `addCount` more units fit given `currentCount` already stored?
    bool VaultCanStore(uint32_t currentCount, uint32_t addCount, IVaultConfig const& cfg);

    // Why a deposit was (dis)allowed -- lets the adapter surface a precise message without
    // re-deriving the decision.
    enum class VaultDepositReason : uint8_t
    {
        Ok = 0,
        EmptyQuantity,      // nothing requested
        CapacityExceeded,   // would overflow the account vault (VaultCanStore)
        InsufficientFunds   // friction cost (VaultTransferCost) exceeds available funds
    };

    struct VaultDepositPlan
    {
        bool allowed = false;
        uint32_t cost = 0;  // friction charged on success; also reported when rejected for funds/UI
        VaultDepositReason reason = VaultDepositReason::EmptyQuantity;
    };

    // §13: full deposit decision -- capacity + friction-cost + affordability in one place so the
    // adapter stays a thin executor. `availableFunds` is the resource the friction is paid from
    // (copper in the adapter). On Ok, `cost` must be deducted by the caller before storing.
    VaultDepositPlan PlanDeposit(uint32_t currentCount, uint32_t requested, uint64_t availableFunds,
        IVaultConfig const& cfg);

    struct VaultWithdrawPlan
    {
        bool allowed = false;
        uint32_t amount = 0;  // clamped to what is actually stored; withdrawal carries no friction
    };

    // §13: withdraw decision -- bounded by `storedCount`; no cost. Rejects 0 or over-withdraws.
    VaultWithdrawPlan PlanWithdraw(uint32_t storedCount, uint32_t requested);
}

#endif // MOD_BRANDING_CORE_VAULT_VAULT_H

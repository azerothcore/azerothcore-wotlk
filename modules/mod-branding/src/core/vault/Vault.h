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
}

#endif // MOD_BRANDING_CORE_VAULT_VAULT_H

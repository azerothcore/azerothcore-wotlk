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
}

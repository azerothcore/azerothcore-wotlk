#ifndef MOD_BRANDING_SRC_VAULTCONFIG_H
#define MOD_BRANDING_SRC_VAULTCONFIG_H

#include "vault/Vault.h"
#include <cstdint>

namespace Branding
{
    // Production IVaultConfig (§13): account-vault tunables snapshotted from sConfigMgr so the pure
    // core stays deterministic. Loaded at startup and on `.reload config`.
    class VaultConfig : public IVaultConfig
    {
    public:
        void Load();
        bool Enabled() const { return _enabled; }

        uint32_t Capacity() const override { return _capacity; }
        uint32_t TransferBaseCost() const override { return _transferBaseCost; }
        uint32_t TransferCostPerUnit() const override { return _transferCostPerUnit; }

    private:
        bool _enabled = false;
        uint32_t _capacity = 1000;
        uint32_t _transferBaseCost = 1000;        // copper
        uint32_t _transferCostPerUnit = 50;       // copper per unit
    };
}

#endif // MOD_BRANDING_SRC_VAULTCONFIG_H

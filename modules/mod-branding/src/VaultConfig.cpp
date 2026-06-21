#include "VaultConfig.h"
#include "Configuration/Config.h"

namespace Branding
{
    void VaultConfig::Load()
    {
        _enabled = sConfigMgr->GetOption<bool>("Branding.Vault.Enable", false);
        _capacity = sConfigMgr->GetOption<uint32_t>("Branding.Vault.Capacity", 1000);
        _transferBaseCost = sConfigMgr->GetOption<uint32_t>("Branding.Vault.TransferBaseCost", 1000);
        _transferCostPerUnit = sConfigMgr->GetOption<uint32_t>("Branding.Vault.TransferCostPerUnit", 50);
    }
}

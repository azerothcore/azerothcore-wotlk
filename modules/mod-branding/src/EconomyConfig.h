#ifndef MOD_BRANDING_SRC_ECONOMYCONFIG_H
#define MOD_BRANDING_SRC_ECONOMYCONFIG_H

#include <cstdint>

namespace Branding
{
    // Production config for the economy/crafting adapter (§8.6). The closed loop represents the two
    // economy resources -- materials and fragments -- as item entries (config-mapped), so faucets
    // (event rewards) and sinks (crafting) trade in the same items. MaterialItem mirrors
    // Branding.Event.RewardItemId so a craft consumes exactly what an event grants.
    class EconomyConfig
    {
    public:
        void Load();
        bool Enabled() const { return _enabled; }

        uint32_t MaterialItem() const { return _materialItem; }
        uint32_t FragmentItem() const { return _fragmentItem; }

    private:
        bool _enabled = false;
        uint32_t _materialItem = 190000;   // Branding Material (BoE; mirrors the event reward, §16.3/§16.4)
        uint32_t _fragmentItem = 190001;   // Branding Fragment (BoA; raid/invasion-sourced)
    };
}

#endif // MOD_BRANDING_SRC_ECONOMYCONFIG_H

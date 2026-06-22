#ifndef MOD_BRANDING_SRC_ECONOMYCONFIG_H
#define MOD_BRANDING_SRC_ECONOMYCONFIG_H

#include "branding/common/Brand.h"
#include <cstdint>

namespace Branding
{
    // Production config for the economy/crafting adapter (§8.6). The closed loop represents the
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

        // §16 per-school Fragments. When enabled, a schooled recipe consumes its school's Fragment
        // (SchoolFragmentBaseItemId + BrandId) instead of the generic FragmentItem -- the
        // "Fire-Branded Fragment" loop. The base MUST match the generator's SCHOOL_FRAGMENT_BASE.
        bool SchoolFragmentsEnabled() const { return _schoolFragments; }
        uint32_t SchoolFragmentItem(BrandId school) const
        {
            return _schoolFragmentBase + static_cast<uint32_t>(school);
        }

    private:
        bool _enabled = false;
        uint32_t _materialItem = 190000;   // Branding Material (BoE; mirrors the event reward, §16.3/§16.4)
        uint32_t _fragmentItem = 190001;   // generic Branding Fragment (BoA; raid/invasion-sourced)
        bool _schoolFragments = false;     // route schooled recipes to per-school Fragments (§16)
        uint32_t _schoolFragmentBase = 190100;  // <School>-Branded Fragment band base (190100 + BrandId)
    };
}

#endif // MOD_BRANDING_SRC_ECONOMYCONFIG_H

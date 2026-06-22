#ifndef MOD_BRANDING_CORE_ECONOMY_ECONOMY_H
#define MOD_BRANDING_CORE_ECONOMY_ECONOMY_H

#include "branding/common/Brand.h"
#include <cstdint>

namespace Branding
{
    // Resources held by a crafter (the closed economy loop, §8.1/§8.6).
    struct Resources
    {
        uint32_t materials = 0;
        uint32_t fragments = 0;
    };

    // A crafting recipe: inputs consumed -> an item + character XP produced.
    struct Recipe
    {
        uint32_t materials = 0;
        uint32_t fragments = 0;
        uint32_t outputItemId = 0;
        uint32_t charXp = 0;
        // BrandId of the Fragment this recipe consumes (the §16 per-school Fragment loop). The pure
        // ResolveCraft ignores it -- it routes only the *count* -- but the adapter reads it to pick
        // which Fragment item entry to consume. BrandId::COUNT means "no school" -> generic Fragment.
        BrandId school = BrandId::COUNT;
    };

    struct CraftResult
    {
        bool crafted = false;
        Resources consumed;     // exact inputs removed (0 if not crafted)
        uint32_t outputItemId = 0;
        uint32_t charXp = 0;
    };

    // §8.6: can the recipe be crafted from the available resources?
    bool CanCraft(Recipe const& recipe, Resources const& available);

    // §8.6: resolve a craft -- consumes exact inputs and yields the output, or rejects cleanly.
    CraftResult ResolveCraft(Recipe const& recipe, Resources const& available);
}

#endif // MOD_BRANDING_CORE_ECONOMY_ECONOMY_H

#ifndef MOD_BRANDING_CORE_ECONOMY_ECONOMY_H
#define MOD_BRANDING_CORE_ECONOMY_ECONOMY_H

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

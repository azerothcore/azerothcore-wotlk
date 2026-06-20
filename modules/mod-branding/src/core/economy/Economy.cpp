#include "Economy.h"

namespace Branding
{
    bool CanCraft(Recipe const& recipe, Resources const& available)
    {
        return available.materials >= recipe.materials && available.fragments >= recipe.fragments;
    }

    CraftResult ResolveCraft(Recipe const& recipe, Resources const& available)
    {
        CraftResult result;
        if (!CanCraft(recipe, available))
            return result;          // crafted = false, nothing consumed

        result.crafted = true;
        result.consumed.materials = recipe.materials;
        result.consumed.fragments = recipe.fragments;
        result.outputItemId = recipe.outputItemId;
        result.charXp = recipe.charXp;
        return result;
    }
}

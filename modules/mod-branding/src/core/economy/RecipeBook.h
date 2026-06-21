#ifndef MOD_BRANDING_CORE_ECONOMY_RECIPEBOOK_H
#define MOD_BRANDING_CORE_ECONOMY_RECIPEBOOK_H

#include "Economy.h"
#include <cstddef>
#include <cstdint>
#include <unordered_map>

namespace Branding
{
    // A pure registry of recipes keyed by recipe id (§8.6). The adapter loads rows from the
    // `branding_recipe` world table into this book; in-world crafting resolves a recipe by id then
    // hands it to ResolveCraft. Kept pure (no AzerothCore deps) so load/lookup logic is tested on
    // the standalone target.
    class RecipeBook
    {
    public:
        // Register/replace a recipe. A zero output item id is ignored (a recipe must produce
        // something), so malformed rows never enter the book. Returns true if stored.
        bool Add(uint32_t recipeId, Recipe const& recipe);

        // Look up a recipe by id. Returns nullptr when unknown.
        Recipe const* Find(uint32_t recipeId) const;

        bool Empty() const { return _recipes.empty(); }
        std::size_t Size() const { return _recipes.size(); }
        void Clear() { _recipes.clear(); }

    private:
        std::unordered_map<uint32_t, Recipe> _recipes;
    };
}

#endif // MOD_BRANDING_CORE_ECONOMY_RECIPEBOOK_H

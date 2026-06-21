#include "RecipeBook.h"

namespace Branding
{
    bool RecipeBook::Add(uint32_t recipeId, Recipe const& recipe)
    {
        if (recipe.outputItemId == 0)
            return false;          // a recipe must produce something

        _recipes[recipeId] = recipe;
        return true;
    }

    Recipe const* RecipeBook::Find(uint32_t recipeId) const
    {
        auto it = _recipes.find(recipeId);
        return it != _recipes.end() ? &it->second : nullptr;
    }
}

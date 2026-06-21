#ifndef MOD_BRANDING_SRC_ECONOMYMGR_H
#define MOD_BRANDING_SRC_ECONOMYMGR_H

#include "EconomyConfig.h"
#include "economy/RecipeBook.h"
#include <cstdint>

class Player;

namespace Branding
{
    // Outcome of a craft attempt, so the command/gossip surface can report cleanly.
    enum class CraftOutcome : uint8_t
    {
        Disabled = 0,       // economy adapter disabled
        UnknownRecipe,      // no recipe with that id loaded
        InsufficientResources,
        DeliveryFailed,     // ResolveCraft succeeded but output could not be delivered
        Crafted             // inputs consumed, output delivered
    };

    struct CraftReport
    {
        CraftOutcome outcome = CraftOutcome::Disabled;
        uint32_t materialsNeeded = 0;
        uint32_t fragmentsNeeded = 0;
        uint32_t materialsHave = 0;
        uint32_t fragmentsHave = 0;
        uint32_t outputItemId = 0;
        uint32_t charXp = 0;
    };

    // Adapter for the closed-loop economy (§8.1/§8.6). Loads recipes from the `branding_recipe` world
    // table into the pure RecipeBook; the craft entry point reads the player's resource items
    // (config-mapped materials/fragments), runs the pure ResolveCraft, removes the exact inputs, and
    // delivers the output via RewardDelivery. Insufficient resources are refused without consuming.
    class EconomyMgr
    {
    public:
        static EconomyMgr* instance();

        void LoadConfig();
        void LoadRecipes();
        bool Enabled() const { return _config.Enabled(); }
        std::size_t RecipeCount() const { return _recipes.Size(); }

        uint32_t MaterialItem() const { return _config.MaterialItem(); }
        uint32_t FragmentItem() const { return _config.FragmentItem(); }

        // Attempt to craft `recipeId` for `player`. No raw Player pointer is stored.
        CraftReport Craft(Player* player, uint32_t recipeId);

    private:
        EconomyMgr() = default;

        EconomyConfig _config;
        RecipeBook _recipes;
    };
}

#define sEconomyMgr Branding::EconomyMgr::instance()

#endif // MOD_BRANDING_SRC_ECONOMYMGR_H

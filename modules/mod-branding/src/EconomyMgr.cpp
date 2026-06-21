#include "EconomyMgr.h"
#include "RewardDelivery.h"
#include "branding/economy/Economy.h"
#include "DatabaseEnv.h"
#include "Log.h"
#include "Player.h"

namespace Branding
{
    EconomyMgr* EconomyMgr::instance()
    {
        static EconomyMgr mgr;
        return &mgr;
    }

    void EconomyMgr::LoadConfig()
    {
        _config.Load();
    }

    void EconomyMgr::LoadRecipes()
    {
        _recipes.Clear();
        if (!_config.Enabled())
            return;

        QueryResult result = WorldDatabase.Query(
            "SELECT `id`, `materials`, `fragments`, `output_item`, `char_xp` FROM `branding_recipe`");
        if (!result)
        {
            LOG_INFO("server.loading", ">> Loaded 0 branding recipes (table empty).");
            return;
        }

        uint32 count = 0;
        do
        {
            Field* fields = result->Fetch();
            uint32 const id = fields[0].Get<uint32>();
            Recipe recipe;
            recipe.materials = fields[1].Get<uint32>();
            recipe.fragments = fields[2].Get<uint32>();
            recipe.outputItemId = fields[3].Get<uint32>();
            recipe.charXp = fields[4].Get<uint32>();

            if (_recipes.Add(id, recipe))
                ++count;
            else
                LOG_WARN("server.loading", "branding_recipe id {} skipped: output_item is 0.", id);
        } while (result->NextRow());

        LOG_INFO("server.loading", ">> Loaded {} branding recipes.", count);
    }

    CraftReport EconomyMgr::Craft(Player* player, uint32_t recipeId)
    {
        CraftReport report;
        if (!_config.Enabled() || !player)
        {
            report.outcome = CraftOutcome::Disabled;
            return report;
        }

        Recipe const* recipe = _recipes.Find(recipeId);
        if (!recipe)
        {
            report.outcome = CraftOutcome::UnknownRecipe;
            return report;
        }

        report.materialsNeeded = recipe->materials;
        report.fragmentsNeeded = recipe->fragments;
        report.outputItemId = recipe->outputItemId;
        report.charXp = recipe->charXp;

        Resources available;
        available.materials = player->GetItemCount(_config.MaterialItem(), false);
        available.fragments = player->GetItemCount(_config.FragmentItem(), false);
        report.materialsHave = available.materials;
        report.fragmentsHave = available.fragments;

        CraftResult const craft = ResolveCraft(*recipe, available);
        if (!craft.crafted)
        {
            report.outcome = CraftOutcome::InsufficientResources;
            return report;   // nothing consumed
        }

        // Consume exact inputs first, then deliver the output. Removing before delivery keeps the
        // sink ahead of the faucet (no double-spend on a delivery edge case).
        if (craft.consumed.materials > 0)
            player->DestroyItemCount(_config.MaterialItem(), craft.consumed.materials, true);
        if (craft.consumed.fragments > 0)
            player->DestroyItemCount(_config.FragmentItem(), craft.consumed.fragments, true);

        DeliveryResult const delivered = DeliverItem(player, craft.outputItemId, 1,
            "Branding Crafting", "Your crafted item.");
        if (delivered == DeliveryResult::None)
        {
            report.outcome = CraftOutcome::DeliveryFailed;
            return report;
        }

        if (craft.charXp > 0)
            player->GiveXP(craft.charXp, nullptr);

        report.outcome = CraftOutcome::Crafted;
        return report;
    }
}

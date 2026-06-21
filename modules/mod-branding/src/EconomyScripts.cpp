#include "EconomyMgr.h"
#include "mod_branding_loader.h"
#include "Chat.h"
#include "CommandScript.h"
#include "Player.h"
#include "RBAC.h"
#include "ScriptMgr.h"

using namespace Acore::ChatCommands;
using namespace Branding;

// Loads/refreshes economy config on startup and on `.reload config`, and (re)loads the recipe table.
class BrandingEconomyWorldScript : public WorldScript
{
public:
    BrandingEconomyWorldScript() : WorldScript("BrandingEconomyWorldScript") { }

    void OnAfterConfigLoad(bool /*reload*/) override
    {
        sEconomyMgr->LoadConfig();
        sEconomyMgr->LoadRecipes();
    }
};

// `.branding craft <recipeId>` -- closed-loop crafting (§8.6). Reads the player's material/fragment
// items, resolves the recipe via the pure core, consumes exact inputs, and delivers the output.
// Insufficient resources are refused cleanly without consuming anything.
class branding_economy_commandscript : public CommandScript
{
public:
    branding_economy_commandscript() : CommandScript("branding_economy_commandscript") { }

    ChatCommandTable GetCommands() const override
    {
        static ChatCommandTable brandingCommandTable =
        {
            { "craft", HandleBrandingCraftCommand, rbac::RBAC_PERM_COMMAND_DEBUG, Console::No },
        };

        static ChatCommandTable commandTable =
        {
            { "branding", brandingCommandTable },
        };
        return commandTable;
    }

    static bool HandleBrandingCraftCommand(ChatHandler* handler, uint32 recipeId)
    {
        Player* player = handler->GetPlayer();
        if (!player)
        {
            handler->SendErrorMessage("This command must be used in-world.");
            return false;
        }

        CraftReport const report = sEconomyMgr->Craft(player, recipeId);
        switch (report.outcome)
        {
            case CraftOutcome::Disabled:
                handler->SendErrorMessage("Branding economy is disabled.");
                return false;
            case CraftOutcome::UnknownRecipe:
                handler->SendErrorMessage("No branding recipe with id {}.", recipeId);
                return false;
            case CraftOutcome::InsufficientResources:
                handler->PSendSysMessage("Cannot craft recipe {}: need {} materials (item {}) and {} fragments (item {}); you have {}/{}.",
                    recipeId, report.materialsNeeded, sEconomyMgr->MaterialItem(),
                    report.fragmentsNeeded, sEconomyMgr->FragmentItem(),
                    report.materialsHave, report.fragmentsHave);
                return true;
            case CraftOutcome::DeliveryFailed:
                handler->SendErrorMessage("Crafting failed: could not deliver item {}.", report.outputItemId);
                return false;
            case CraftOutcome::Crafted:
                handler->PSendSysMessage("Crafted item {} (consumed {} materials, {} fragments; +{} XP).",
                    report.outputItemId, report.materialsNeeded, report.fragmentsNeeded, report.charXp);
                return true;
            default:
                return false;
        }
    }
};

void AddBrandingEconomyScripts()
{
    new BrandingEconomyWorldScript();
    new branding_economy_commandscript();
}

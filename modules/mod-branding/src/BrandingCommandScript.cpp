#include "DiscoveryMgr.h"
#include "ProficiencyMgr.h"
#include "ScalingMgr.h"
#include "mod_branding_loader.h"
#include "Chat.h"
#include "CommandScript.h"
#include "Player.h"
#include "RBAC.h"

using namespace Acore::ChatCommands;
using namespace Branding;

// `.branding info` -- read-only inspection of the wired branding systems for the calling player.
class branding_commandscript : public CommandScript
{
public:
    branding_commandscript() : CommandScript("branding_commandscript") { }

    ChatCommandTable GetCommands() const override
    {
        static ChatCommandTable brandingCommandTable =
        {
            { "info", HandleBrandingInfoCommand, rbac::RBAC_PERM_COMMAND_DEBUG, Console::No },
        };

        static ChatCommandTable commandTable =
        {
            { "branding", brandingCommandTable },
        };
        return commandTable;
    }

    static bool HandleBrandingInfoCommand(ChatHandler* handler)
    {
        Player* player = handler->GetPlayer();
        if (!player)
        {
            handler->SendErrorMessage("This command must be used in-world.");
            return false;
        }

        ObjectGuid const guid = player->GetGUID();
        uint32 const account = player->GetSession()->GetAccountId();

        handler->PSendSysMessage("Branding info for {}:", player->GetName());

        bool anyBrand = false;
        for (uint8 b = 0; b < static_cast<uint8>(BrandId::COUNT); ++b)
        {
            BrandId const brand = static_cast<BrandId>(b);
            uint8 const level = sProficiencyMgr->BrandLevel(guid, brand);
            if (level == 0)
                continue;

            anyBrand = true;
            handler->PSendSysMessage("  brand {}: level {}, effect strength {:.2f}",
                uint32(b), uint32(level), sProficiencyMgr->EffectStrength(guid, account, brand));
        }
        if (!anyBrand)
            handler->PSendSysMessage("  (no brand proficiency earned yet)");

        handler->PSendSysMessage("Zone scaling: outgoing damage x{:.2f} (area {})",
            sScalingMgr->PlayerOutgoingFactor(player), player->GetAreaId());
        handler->PSendSysMessage("Discovery: tier {}, first-visit bonus {} xp",
            uint32(sDiscoveryMgr->AreaTier(player->GetAreaId())),
            sDiscoveryMgr->AreaDiscoveryBonus(player->GetLevel(), player->GetAreaId()));
        return true;
    }
};

void AddBrandingCommandScripts()
{
    new branding_commandscript();
}

#include "DiscoveryMgr.h"
#include "EventMgr.h"
#include "ProficiencyMgr.h"
#include "RewardDelivery.h"
#include "ScalingMgr.h"
#include "contribution/ContributionTypes.h"
#include "mod_branding_loader.h"
#include "Chat.h"
#include "CommandScript.h"
#include "Player.h"
#include "RBAC.h"

using namespace Acore::ChatCommands;
using namespace Branding;

namespace
{
    char const* TierName(RewardTier tier)
    {
        switch (tier)
        {
            case RewardTier::Bronze: return "Bronze";
            case RewardTier::Silver: return "Silver";
            case RewardTier::Gold:   return "Gold";
            default:                 return "None";
        }
    }
}

// `.branding info` -- read-only inspection of the wired branding systems for the calling player.
class branding_commandscript : public CommandScript
{
public:
    branding_commandscript() : CommandScript("branding_commandscript") { }

    ChatCommandTable GetCommands() const override
    {
        static ChatCommandTable eventCommandTable =
        {
            { "start",  HandleBrandingEventStartCommand,  rbac::RBAC_PERM_COMMAND_DEBUG, Console::No },
            { "stop",   HandleBrandingEventStopCommand,   rbac::RBAC_PERM_COMMAND_DEBUG, Console::No },
            { "status", HandleBrandingEventStatusCommand, rbac::RBAC_PERM_COMMAND_DEBUG, Console::No },
            { "claim",  HandleBrandingEventClaimCommand,  rbac::RBAC_PERM_COMMAND_DEBUG, Console::No },
        };

        static ChatCommandTable brandingCommandTable =
        {
            { "info",  HandleBrandingInfoCommand, rbac::RBAC_PERM_COMMAND_DEBUG, Console::No },
            { "event", eventCommandTable },
        };

        static ChatCommandTable commandTable =
        {
            { "branding", brandingCommandTable },
        };
        return commandTable;
    }

    static bool HandleBrandingEventStartCommand(ChatHandler* handler, uint32 type, uint32 goal)
    {
        Player* player = handler->GetPlayer();
        if (!player)
        {
            handler->SendErrorMessage("This command must be used in-world.");
            return false;
        }
        if (type >= static_cast<uint32>(EventType::COUNT))
        {
            handler->SendErrorMessage("Event type must be 0..{} (0=Invasion,1=ResourceSurge,2=EliteHunt,3=ProfessionAnomaly).",
                static_cast<uint32>(EventType::COUNT) - 1);
            return false;
        }

        uint32 const zone = player->GetZoneId();
        sEventMgr->StartEvent(zone, static_cast<EventType>(type), goal);
        handler->PSendSysMessage("Started branding event (type {}, goal {}) in zone {}.", type, goal, zone);
        return true;
    }

    static bool HandleBrandingEventStopCommand(ChatHandler* handler)
    {
        Player* player = handler->GetPlayer();
        if (!player)
        {
            handler->SendErrorMessage("This command must be used in-world.");
            return false;
        }

        uint32 const zone = player->GetZoneId();
        if (sEventMgr->StopEvent(zone))
            handler->PSendSysMessage("Stopped branding event in zone {}.", zone);
        else
            handler->PSendSysMessage("No active branding event in zone {}.", zone);
        return true;
    }

    static bool HandleBrandingEventStatusCommand(ChatHandler* handler)
    {
        Player* player = handler->GetPlayer();
        if (!player)
        {
            handler->SendErrorMessage("This command must be used in-world.");
            return false;
        }

        uint32 const zone = player->GetZoneId();
        ObjectGuid const guid = player->GetGUID();

        EventType type;
        if (sEventMgr->ActiveEventType(zone, type))
            handler->PSendSysMessage("Zone {} event: type {}, {:.0f}% contained.",
                zone, static_cast<uint32>(type), sEventMgr->Containment(zone) * 100.0);
        else
            handler->PSendSysMessage("Zone {}: no active event.", zone);

        handler->PSendSysMessage("Your contribution: {} points, tier {}.",
            sEventMgr->PlayerPoints(guid), TierName(sEventMgr->PlayerTier(guid)));
        return true;
    }

    static bool HandleBrandingEventClaimCommand(ChatHandler* handler)
    {
        Player* player = handler->GetPlayer();
        if (!player)
        {
            handler->SendErrorMessage("This command must be used in-world.");
            return false;
        }

        EventMgr::ResolvedReward const reward =
            sEventMgr->ResolveReward(player->GetGUID(), player->GetSession()->GetAccountId(), player->GetZoneId());

        if (reward.tier == RewardTier::None)
        {
            handler->PSendSysMessage("No contribution to claim yet.");
            return true;
        }

        switch (reward.category)
        {
            case RewardCategory::CraftingMats:
                if (reward.grant.materials == 0)
                {
                    handler->PSendSysMessage("Material reward is bounded by your account ceiling this period.");
                    break;
                }
                switch (DeliverItem(player, sEventMgr->RewardMaterialItem(), reward.grant.materials,
                    "Branding Event Reward", "Your event contribution has been rewarded."))
                {
                    case DeliveryResult::Inventory:
                        handler->PSendSysMessage("Reward: {} x item {} (added to bags).", reward.grant.materials, sEventMgr->RewardMaterialItem());
                        break;
                    case DeliveryResult::Mailed:
                        handler->PSendSysMessage("Reward: {} x item {} (bags full -> mailed).", reward.grant.materials, sEventMgr->RewardMaterialItem());
                        break;
                    default:
                        handler->PSendSysMessage("Reward could not be delivered.");
                        break;
                }
                break;
            case RewardCategory::Currency:
                if (reward.grant.currency == 0)
                    handler->PSendSysMessage("Currency reward is bounded by your account ceiling this period.");
                else
                {
                    player->ModifyMoney(static_cast<int32>(reward.grant.currency));
                    handler->PSendSysMessage("Reward: {} copper.", reward.grant.currency);
                }
                break;
            case RewardCategory::Xp:
                player->GiveXP(100 * static_cast<uint32>(reward.tier), nullptr);
                handler->PSendSysMessage("Reward: bonus XP.");
                break;
            default:
                handler->PSendSysMessage("Reward category {} (cosmetic/reputation grant TODO).", uint32(reward.category));
                break;
        }

        handler->PSendSysMessage("Claimed tier {}, category {}.", TierName(reward.tier), uint32(reward.category));
        return true;
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

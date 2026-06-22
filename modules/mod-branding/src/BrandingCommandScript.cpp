#include "AllegianceMgr.h"
#include "CatalystMgr.h"
#include "DiscoveryMgr.h"
#include "EventMgr.h"
#include "HeroicMgr.h"
#include "InsightMgr.h"
#include "ItemBrandingMgr.h"
#include "LoadoutMgr.h"
#include "MasteryCombatMgr.h"
#include "MasteryLoadoutMgr.h"
#include "MasteryMgr.h"
#include "ProficiencyMgr.h"
#include "RewardDelivery.h"
#include "ScalingMgr.h"
#include "SelectionMgr.h"
#include "branding/allegiance/Allegiance.h"
#include "branding/contribution/ContributionTypes.h"
#include "mod_branding_loader.h"
#include "Chat.h"
#include "CommandScript.h"
#include "Map.h"
#include "Player.h"
#include "RBAC.h"
#include <algorithm>
#include <cctype>
#include <cstdlib>
#include <string>
#include <string_view>

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

    char const* BrandName(BrandId brand)
    {
        switch (brand)
        {
            case BrandId::Fire:     return "Fire";
            case BrandId::Frost:    return "Frost";
            case BrandId::Nature:   return "Nature";
            case BrandId::Shadow:   return "Shadow";
            case BrandId::Arcane:   return "Arcane";
            case BrandId::Holy:     return "Holy";
            case BrandId::Physical: return "Physical";
            case BrandId::Wind:     return "Wind";
            case BrandId::Lightning: return "Lightning";
            case BrandId::Blood:    return "Blood";
            case BrandId::Void:     return "Void";
            case BrandId::Stone:    return "Stone";
            case BrandId::Venom:    return "Venom";
            case BrandId::Chrono:   return "Chrono";
            case BrandId::Spirit:   return "Spirit";
            default:                return "Unknown";
        }
    }

    char const* TreeName(MasteryTree tree)
    {
        switch (tree)
        {
            case MasteryTree::Defensive: return "Def";
            case MasteryTree::Offensive: return "Off";
            case MasteryTree::Support:   return "Support";
            default:                     return "?";
        }
    }

    char const* MasteryName(MasterySystem system)
    {
        switch (system)
        {
            case MasterySystem::Gathering: return "Gathering";
            case MasterySystem::Crafting:  return "Crafting";
            default:                       return "Unknown";
        }
    }

    char const* AllegianceName(Allegiance allegiance)
    {
        switch (allegiance)
        {
            case Allegiance::FireChaos:  return "Fire/Chaos";
            case Allegiance::NatureWild: return "Nature/Wild";
            case Allegiance::ShadowVoid: return "Shadow/Void";
            case Allegiance::TitanOrder: return "Titan/Order";
            default:                     return "None";
        }
    }
}

// `.branding ...` -- inspection + control surface for the wired branding systems.
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

        static ChatCommandTable knowledgeCommandTable =
        {
            { "grant", HandleBrandingKnowledgeGrantCommand, rbac::RBAC_PERM_COMMAND_DEBUG, Console::No },
            { "list",  HandleBrandingKnowledgeListCommand,  rbac::RBAC_PERM_COMMAND_DEBUG, Console::No },
        };

        static ChatCommandTable allegianceCommandTable =
        {
            { "set", HandleBrandingAllegianceSetCommand, rbac::RBAC_PERM_COMMAND_DEBUG, Console::No },
        };

        static ChatCommandTable insightCommandTable =
        {
            { "list",  HandleBrandingInsightListCommand,  rbac::RBAC_PERM_COMMAND_DEBUG, Console::No },
            { "grant", HandleBrandingInsightGrantCommand, rbac::RBAC_PERM_COMMAND_DEBUG, Console::No },
        };

        static ChatCommandTable schoolCommandTable =
        {
            { "select", HandleBrandingSchoolSelectCommand, rbac::RBAC_PERM_COMMAND_DEBUG, Console::No },
        };

        static ChatCommandTable brandingCommandTable =
        {
            { "info",        HandleBrandingInfoCommand,        rbac::RBAC_PERM_COMMAND_DEBUG, Console::No },
            { "heroic",      HandleBrandingHeroicCommand,      rbac::RBAC_PERM_COMMAND_DEBUG, Console::No },
            { "setbrand",    HandleBrandingSetBrandCommand,    rbac::RBAC_PERM_COMMAND_DEBUG, Console::No },
            { "setproc",     HandleBrandingSetProcCommand,     rbac::RBAC_PERM_COMMAND_DEBUG, Console::No },
            { "itembrand",   HandleBrandingItemBrandCommand,   rbac::RBAC_PERM_COMMAND_DEBUG, Console::No },
            { "upgradeitem", HandleBrandingUpgradeItemCommand, rbac::RBAC_PERM_COMMAND_DEBUG, Console::No },
            { "etch",        HandleBrandingEtchCommand,        rbac::RBAC_PERM_COMMAND_DEBUG, Console::No },
            { "knowledge",  knowledgeCommandTable },
            { "insight",    insightCommandTable },
            { "allegiance", allegianceCommandTable },
            { "school",     schoolCommandTable },
            { "event",      eventCommandTable },
        };

        static ChatCommandTable commandTable =
        {
            { "branding", brandingCommandTable },
        };
        return commandTable;
    }

    static bool HandleBrandingHeroicCommand(ChatHandler* handler)
    {
        Player* player = handler->GetPlayer();
        if (!player)
        {
            handler->SendErrorMessage("This command must be used in-world.");
            return false;
        }

        Map* map = player->GetMap();
        if (!map || !map->IsDungeon())
        {
            handler->PSendSysMessage("Heroic overlay: not in an instance.");
            return true;
        }

        HeroicContext const ctx = sHeroicMgr->ContextFor(map);
        uint8_t levelTarget = 0;
        sHeroicMgr->LevelTargetFor(map, levelTarget);
        handler->PSendSysMessage("Heroic overlay [{}]: selected={}, nativeHeroicMap={}, engages={}.",
            sHeroicMgr->Enabled() ? "enabled" : "disabled",
            ctx.selected == SelectedDifficulty::Heroic ? "Heroic" : "Normal",
            ctx.nativeHeroicMap, HeroicOverlayEngages(ctx));
        handler->PSendSysMessage("  levelTarget={}, healthMul={:.2f}, damageMul={:.2f}, tierBonus={}.",
            levelTarget, sHeroicMgr->HealthMulFor(map),
            sHeroicMgr->DamageMulFor(map), sHeroicMgr->TierBonusFor(map));

        HeroicMgr::RewardModifiers const mods = sHeroicMgr->RewardModifiersFor(map);
        handler->PSendSysMessage("  reward: currencyMul={:.2f}, tierBonus={} (instanced stream; not the event path).",
            mods.currencyMul, mods.tierBonus);

        if (uint8 const minBodies = sHeroicMgr->RecommendedMinBodies(map->GetId(), 0))
        {
            handler->PSendSysMessage("  advisory: recommended >= {} players. {}",
                minBodies, sHeroicMgr->ExceptionNote(map->GetId(), 0));
        }

        return true;
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
        {
            handler->PSendSysMessage("Zone {} event: type {}, {:.0f}% contained.",
                zone, static_cast<uint32>(type), sEventMgr->Containment(zone) * 100.0);
            // §2.5 crowd scaling: live enrolled count vs the decayed-peak headcount that drives it.
            handler->PSendSysMessage("Crowd: {} enrolled, effective headcount {}.",
                sEventMgr->ParticipantCount(zone), sEventMgr->EffectiveHeadcount(zone));
        }
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
            {
                // Allegiance application point (§12): scale the event XP reward by the player's
                // efficiency for the event's ideological alignment. A match boosts it; a mismatch,
                // no allegiance, or a disabled system stays exactly neutral -- never a penalty.
                uint32 const baseXp = 100 * static_cast<uint32>(reward.tier);
                EventType type;
                Allegiance const content =
                    sEventMgr->ActiveEventType(player->GetZoneId(), type) ? EventAlignment(type) : Allegiance::None;
                double const efficiency = sAllegianceMgr->Efficiency(player->GetGUID(), content);
                player->GiveXP(static_cast<uint32>(baseXp * efficiency), nullptr);
                handler->PSendSysMessage("Reward: bonus XP (allegiance x{:.2f}).", efficiency);
                break;
            }
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

        BrandLoadout const loadout = sLoadoutMgr->GetLoadout(guid);
        handler->PSendSysMessage("Active loadout: {} brand, proc archetype {}.",
            BrandName(loadout.activeBrand), uint32(loadout.selectedProcArchetype));

        ItemBrandState itemState;
        if (sItemBrandingMgr->EquippedState(player, itemState))
            handler->PSendSysMessage("Equipped item: {} brand, step {}, level {}, intensity x{:.2f}.",
                BrandName(itemState.brand), uint32(itemState.step), uint32(itemState.levelInStep),
                sItemBrandingMgr->EquippedIntensity(player));

        if (sItemBrandingMgr->EtchEnabled())
            handler->PSendSysMessage("Etched ({} brand): aggregate proc x{:.2f} (self-stack DR).",
                BrandName(loadout.activeBrand), sItemBrandingMgr->AggregateEtchedIntensity(player));

        handler->PSendSysMessage("Catalyst: same-role rank {}, raid multiplier x{:.2f}.",
            uint32(sCatalystMgr->SameRoleBrandedRank(player)), sCatalystMgr->RaidMultiplierFor(player));

        for (uint8 m = 0; m < static_cast<uint8>(MasterySystem::COUNT); ++m)
        {
            MasterySystem const system = static_cast<MasterySystem>(m);
            bool const unlocked = sMasteryMgr->AccountUnlocked(account, system);
            uint8 const level = sMasteryMgr->MasteryLevel(guid, system);
            handler->PSendSysMessage("Mastery {}: account {}, char level {}, efficiency bonus +{:.1f}%",
                MasteryName(system), unlocked ? "unlocked" : "locked", uint32(level),
                sMasteryMgr->Bonus(guid, account, system) * 100.0);
        }

        // §14.12 (issue #27): the COMBAT-mastery application plan -- the active (school, tree) cells
        // resolved to their bound magnitude (raid-wide via MaxRaidMul + catalyst DR, or personal via
        // MaxPersonalMul), plus the aggregate outgoing multiplier the UnitScript applies right now.
        MasteryPlan const plan = sMasteryCombatMgr->BuildPlan(player);
        if (plan.count == 0)
            handler->PSendSysMessage("Mastery combat: no active cell (or system disabled).");
        else
            handler->PSendSysMessage("Mastery combat: {} active cell(s), aggregate outgoing x{:.2f}.",
                uint32(plan.count), sMasteryCombatMgr->OutgoingMultiplierFor(player));
        for (uint8 i = 0; i < plan.count; ++i)
        {
            ResolvedMasteryEffect const& e = plan.effects[i];
            handler->PSendSysMessage(
                "  {} {} (arch {}): {}, x{:.2f}, rank {}, ppm {:.1f}, window {} ms, uptime {:.0f}%",
                BrandName(e.school), TreeName(e.tree), uint32(e.archetype),
                e.raidWide ? "raid" : "personal", e.magnitude, uint32(e.catalystRank),
                e.resolved.ppm, e.resolved.windowDurationMs, e.uptimeFraction * 100.0);
        }
        return true;
    }

    // Resolves a brand token (numeric id 0..COUNT-1, or a case-insensitive name) to a BrandId.
    static bool ParseBrand(std::string_view token, BrandId& out)
    {
        if (!token.empty() && std::all_of(token.begin(), token.end(), [](unsigned char c) { return std::isdigit(c); }))
        {
            uint32 const id = static_cast<uint32>(std::strtoul(std::string(token).c_str(), nullptr, 10));
            if (id >= static_cast<uint32>(BrandId::COUNT))
                return false;
            out = static_cast<BrandId>(id);
            return true;
        }

        for (uint8 b = 0; b < static_cast<uint8>(BrandId::COUNT); ++b)
        {
            BrandId const brand = static_cast<BrandId>(b);
            std::string const name = BrandName(brand);
            if (token.size() == name.size()
                && std::equal(token.begin(), token.end(), name.begin(),
                    [](unsigned char a, unsigned char c) { return std::tolower(a) == std::tolower(c); }))
            {
                out = brand;
                return true;
            }
        }
        return false;
    }

    // `.branding itembrand` -- brand the equipped main-hand weapon with the player's active brand.
    static bool HandleBrandingItemBrandCommand(ChatHandler* handler)
    {
        Player* player = handler->GetPlayer();
        if (!player)
        {
            handler->SendErrorMessage("This command must be used in-world.");
            return false;
        }
        if (!sItemBrandingMgr->Enabled())
        {
            handler->SendErrorMessage("Item branding is disabled (Branding.Item.Enable).");
            return false;
        }

        BrandId const brand = sLoadoutMgr->GetLoadout(player->GetGUID()).activeBrand;
        if (!sItemBrandingMgr->BrandEquipped(player, brand))
        {
            handler->SendErrorMessage("No equipped main-hand weapon to brand.");
            return false;
        }

        handler->PSendSysMessage("Equipped weapon branded {}.", BrandName(brand));
        return true;
    }

    // `.branding upgradeitem <levels>` -- spend resources to raise the equipped weapon's intensity.
    static bool HandleBrandingUpgradeItemCommand(ChatHandler* handler, uint32 levels)
    {
        Player* player = handler->GetPlayer();
        if (!player)
        {
            handler->SendErrorMessage("This command must be used in-world.");
            return false;
        }
        if (!sItemBrandingMgr->Enabled())
        {
            handler->SendErrorMessage("Item branding is disabled (Branding.Item.Enable).");
            return false;
        }

        if (levels == 0)
            levels = 1;

        uint32 const resources = levels * sItemBrandingMgr->Config().UpgradeCostPerLevel();
        uint8 const gained = sItemBrandingMgr->UpgradeEquipped(player, resources);
        if (gained == 0)
        {
            handler->SendErrorMessage("Nothing upgraded -- no branded weapon equipped, or already maxed.");
            return false;
        }

        handler->PSendSysMessage("Upgraded equipped weapon by {} level(s).", uint32(gained));
        return true;
    }

    // `.branding etch [slot]` -- one-shot Etch of an equipped item with the active school (#31):
    // rank-locked, soulbound, paid in Essence. `slot` is one of mainhand|offhand|ranged|trinket1|trinket2
    // (default mainhand). The low-friction, server-only on-ramp into the Branded system.
    static bool HandleBrandingEtchCommand(ChatHandler* handler, Optional<std::string_view> slotToken)
    {
        Player* player = handler->GetPlayer();
        if (!player)
        {
            handler->SendErrorMessage("This command must be used in-world.");
            return false;
        }

        uint8 equipSlot = EQUIPMENT_SLOT_MAINHAND;
        if (slotToken)
        {
            std::string token(*slotToken);
            std::transform(token.begin(), token.end(), token.begin(),
                [](unsigned char c) { return static_cast<char>(std::tolower(c)); });

            if (token == "mainhand" || token == "mh")
                equipSlot = EQUIPMENT_SLOT_MAINHAND;
            else if (token == "offhand" || token == "oh")
                equipSlot = EQUIPMENT_SLOT_OFFHAND;
            else if (token == "ranged" || token == "rg")
                equipSlot = EQUIPMENT_SLOT_RANGED;
            else if (token == "trinket1" || token == "t1")
                equipSlot = EQUIPMENT_SLOT_TRINKET1;
            else if (token == "trinket2" || token == "t2")
                equipSlot = EQUIPMENT_SLOT_TRINKET2;
            else
            {
                handler->SendErrorMessage("Unknown slot '{}'. Use: mainhand, offhand, ranged, trinket1, trinket2.", token);
                return false;
            }
        }

        BrandId const brand = sLoadoutMgr->GetLoadout(player->GetGUID()).activeBrand;
        switch (sItemBrandingMgr->EtchSlot(player, equipSlot))
        {
            case EtchResult::Success:
                handler->PSendSysMessage("Etched your equipped weapon with the {} brand -- it is now soulbound "
                    "and its proc expresses while {} is your active school.", BrandName(brand), BrandName(brand));
                return true;
            case EtchResult::Disabled:
                handler->SendErrorMessage("Etching is disabled (Branding.Item.Enable / Branding.Etch.Enable).");
                return false;
            case EtchResult::NoWeapon:
                handler->SendErrorMessage("No eligible item equipped in that slot to etch (weapons and trinkets only).");
                return false;
            case EtchResult::AlreadyBranded:
                handler->SendErrorMessage("That weapon already carries a Brand -- an Etch is permanent and one per item.");
                return false;
            case EtchResult::NotEnrolled:
                handler->SendErrorMessage("Your active school is not unlocked -- enroll (learn its Knowledge) before etching.");
                return false;
            case EtchResult::InsufficientEssence:
                handler->SendErrorMessage("Not enough Essence: need {}, have {}.",
                    sItemBrandingMgr->EssenceCost(),
                    player->GetItemCount(sItemBrandingMgr->EssenceItemId(), false));
                return false;
        }

        return false;
    }

    // `.branding knowledge grant <brand>` -- GM/debug unlock of an account-wide brand (design §6).
    static bool HandleBrandingKnowledgeGrantCommand(ChatHandler* handler, std::string_view brandToken)
    {
        Player* player = handler->GetPlayer();
        if (!player)
        {
            handler->SendErrorMessage("This command must be used in-world.");
            return false;
        }
        if (!sProficiencyMgr->Config().Enabled())
        {
            handler->SendErrorMessage("Branding module is disabled.");
            return false;
        }

        BrandId brand;
        if (!ParseBrand(brandToken, brand))
        {
            handler->SendErrorMessage("Unknown brand '{}'. Use a name (Fire, Frost, Nature, Shadow, Arcane, Holy, Physical) or id 0..{}.",
                brandToken, static_cast<uint32>(BrandId::COUNT) - 1);
            return false;
        }

        uint32 const account = player->GetSession()->GetAccountId();
        if (sProficiencyMgr->UnlockBrand(account, brand))
            handler->PSendSysMessage("Unlocked brand {} ({}) for account {}.",
                BrandName(brand), static_cast<uint32>(brand), account);
        else
            handler->PSendSysMessage("Brand {} is already unlocked for account {}.",
                BrandName(brand), account);
        return true;
    }

    // `.branding knowledge list` -- shows which brands the calling account has unlocked.
    static bool HandleBrandingKnowledgeListCommand(ChatHandler* handler)
    {
        Player* player = handler->GetPlayer();
        if (!player)
        {
            handler->SendErrorMessage("This command must be used in-world.");
            return false;
        }

        uint32 const account = player->GetSession()->GetAccountId();
        handler->PSendSysMessage("Brand knowledge for account {}:", account);

        bool any = false;
        for (uint8 b = 0; b < static_cast<uint8>(BrandId::COUNT); ++b)
        {
            BrandId const brand = static_cast<BrandId>(b);
            if (!sProficiencyMgr->IsBrandKnown(account, brand))
                continue;

            any = true;
            handler->PSendSysMessage("  {} ({}): unlocked", BrandName(brand), uint32(b));
        }
        if (!any)
            handler->PSendSysMessage("  (no brands unlocked -- use .branding knowledge grant <brand>)");
        return true;
    }

    // `.branding insight list` -- shows the calling account's fractional Insight per school (§14.13.1).
    static bool HandleBrandingInsightListCommand(ChatHandler* handler)
    {
        Player* player = handler->GetPlayer();
        if (!player)
        {
            handler->SendErrorMessage("This command must be used in-world.");
            return false;
        }
        if (!sInsightMgr->Enabled())
        {
            handler->SendErrorMessage("Insight is disabled (Branding.Insight.Enable).");
            return false;
        }

        uint32 const account = player->GetSession()->GetAccountId();
        double const threshold = sInsightMgr->Config().UnlockThreshold();
        handler->PSendSysMessage("Insight for account {} (unlock threshold {:.1f}):", account, threshold);

        bool any = false;
        for (uint8 b = 0; b < static_cast<uint8>(BrandId::COUNT); ++b)
        {
            BrandId const brand = static_cast<BrandId>(b);
            double const points = sInsightMgr->Points(account, brand);
            if (points <= 0.0)
                continue;

            any = true;
            handler->PSendSysMessage("  {} ({}): {:.4f} Insight{}", BrandName(brand), uint32(b), points,
                points >= threshold ? " (threshold reached)" : "");
        }
        if (!any)
            handler->PSendSysMessage("  (no Insight earned yet)");
        return true;
    }

    // `.branding insight grant <brand> [rank]` -- debug: award one kill's Insight (rank 0=RaidBoss,
    // 1=DungeonHeroic, 2=DungeonNormal, 3=TrashMote) to a school, applying the account-wide DR.
    static bool HandleBrandingInsightGrantCommand(ChatHandler* handler, std::string_view brandToken, Optional<uint32> rankArg)
    {
        Player* player = handler->GetPlayer();
        if (!player)
        {
            handler->SendErrorMessage("This command must be used in-world.");
            return false;
        }
        if (!sInsightMgr->Enabled())
        {
            handler->SendErrorMessage("Insight is disabled (Branding.Insight.Enable).");
            return false;
        }

        BrandId brand;
        if (!ParseBrand(brandToken, brand))
        {
            handler->SendErrorMessage("Unknown brand '{}'. Use a name or id 0..{}.",
                brandToken, static_cast<uint32>(BrandId::COUNT) - 1);
            return false;
        }

        uint32 const rankId = rankArg.value_or(0);
        if (rankId >= static_cast<uint32>(SourceRank::COUNT))
        {
            handler->SendErrorMessage("Rank must be 0..{} (0=RaidBoss,1=DungeonHeroic,2=DungeonNormal,3=TrashMote).",
                static_cast<uint32>(SourceRank::COUNT) - 1);
            return false;
        }

        uint32 const account = player->GetSession()->GetAccountId();
        bool unlocked = false;
        double const granted = sInsightMgr->Earn(account, brand, static_cast<SourceRank>(rankId), &unlocked);

        handler->PSendSysMessage("Granted {:.4f} Insight to {} (total {:.4f}).",
            granted, BrandName(brand), sInsightMgr->Points(account, brand));
        if (unlocked)
            handler->PSendSysMessage("Threshold reached -- Knowledge for {} unlocked for account {}.",
                BrandName(brand), account);
        return true;
    }

    // `.branding setbrand <brand>` -- select the active brand (rejected if the account lacks Knowledge).
    static bool HandleBrandingSetBrandCommand(ChatHandler* handler, uint32 brand)
    {
        Player* player = handler->GetPlayer();
        if (!player)
        {
            handler->SendErrorMessage("This command must be used in-world.");
            return false;
        }
        if (brand >= static_cast<uint32>(BrandId::COUNT))
        {
            handler->SendErrorMessage("Brand must be 0..{} (0=Fire,1=Frost,2=Nature,3=Shadow,4=Arcane,5=Holy,6=Physical).",
                static_cast<uint32>(BrandId::COUNT) - 1);
            return false;
        }

        BrandId const brandId = static_cast<BrandId>(brand);
        if (!sLoadoutMgr->SetActiveBrand(player, brandId))
        {
            handler->SendErrorMessage("Cannot select {}: your account has not unlocked its Brand Knowledge.",
                BrandName(brandId));
            return false;
        }

        handler->PSendSysMessage("Active brand set to {} (proc archetype reset to 0).", BrandName(brandId));
        return true;
    }

    // `.branding setproc <n>` -- select the proc archetype for the active brand (proficiency-gated).
    static bool HandleBrandingSetProcCommand(ChatHandler* handler, uint32 archetype)
    {
        Player* player = handler->GetPlayer();
        if (!player)
        {
            handler->SendErrorMessage("This command must be used in-world.");
            return false;
        }
        if (archetype > 0xFF)
        {
            handler->SendErrorMessage("Proc archetype index out of range.");
            return false;
        }

        if (!sLoadoutMgr->SetArchetype(player, static_cast<uint8>(archetype)))
        {
            BrandLoadout const current = sLoadoutMgr->GetLoadout(player->GetGUID());
            uint8 const unlocked = sLoadoutMgr->Config().ArchetypesAtLevel(
                sProficiencyMgr->BrandLevel(player->GetGUID(), current.activeBrand));
            handler->SendErrorMessage("Proc archetype {} is not available: {} unlocked at your {} proficiency.",
                archetype, unlocked, BrandName(current.activeBrand));
            return false;
        }

        handler->PSendSysMessage("Proc archetype set to {}.", archetype);
        return true;
    }

    // `.branding allegiance set <id>` -- commit to a soft allegiance (§12); validated by the core.
    static bool HandleBrandingAllegianceSetCommand(ChatHandler* handler, uint32 id)
    {
        Player* player = handler->GetPlayer();
        if (!player)
        {
            handler->SendErrorMessage("This command must be used in-world.");
            return false;
        }
        if (!sAllegianceMgr->Enabled())
        {
            handler->SendErrorMessage("Allegiance system is disabled (Branding.Allegiance.Enable).");
            return false;
        }

        Allegiance parsed = Allegiance::None;
        if (!ParseAllegiance(id, parsed))
        {
            handler->SendErrorMessage("Allegiance id must be 1..{} (1=Fire/Chaos, 2=Nature/Wild, 3=Shadow/Void, 4=Titan/Order).",
                static_cast<uint32>(Allegiance::COUNT) - 1);
            return false;
        }

        sAllegianceMgr->Select(player->GetGUID(), player->GetGUID().GetCounter(), id);
        handler->PSendSysMessage("Allegiance set to {} (mostly permanent).", AllegianceName(parsed));
        return true;
    }

    // `.branding school select <school>` -- switch the active school for an escalating gold tuition
    // (§14.13.2). Re-selecting a known school is gold-only and retains Proficiency; a never-known
    // school is rejected (no charge) until its Insight Knowledge is unlocked (#18).
    static bool HandleBrandingSchoolSelectCommand(ChatHandler* handler, std::string_view brandToken)
    {
        Player* player = handler->GetPlayer();
        if (!player)
        {
            handler->SendErrorMessage("This command must be used in-world.");
            return false;
        }
        if (!sSelectionMgr->Config().Enabled())
        {
            handler->SendErrorMessage("School selection is disabled (Branding.Selection.Enable).");
            return false;
        }

        BrandId brand;
        if (!ParseBrand(brandToken, brand))
        {
            handler->SendErrorMessage("Unknown school '{}'. Use a name (Fire, Frost, ...) or id 0..{}.",
                brandToken, static_cast<uint32>(BrandId::COUNT) - 1);
            return false;
        }

        SwitchResult const result = sSelectionMgr->SelectSchool(player, brand);
        switch (result.outcome)
        {
            case SwitchOutcome::Disabled:
                handler->SendErrorMessage("School selection is disabled (Branding.Selection.Enable).");
                return false;
            case SwitchOutcome::NotKnown:
                handler->SendErrorMessage("You have not unlocked the {} school. Earn its Insight Knowledge first (.branding knowledge).",
                    BrandName(brand));
                return false;
            case SwitchOutcome::InsufficientGold:
                handler->SendErrorMessage("Switching to {} costs {} copper tuition -- you cannot afford it.",
                    BrandName(brand), result.tuition);
                return false;
            case SwitchOutcome::Switched:
                handler->PSendSysMessage("Active school set to {} for {} copper. Proficiency retained.",
                    BrandName(brand), result.tuition);
                return true;
            default:
                return false;
        }
    }
};

void AddBrandingCommandScripts()
{
    new branding_commandscript();
}

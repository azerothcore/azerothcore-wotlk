#include "Discovery.h"

namespace Branding
{
    DiscoveryTier TierForZoneLevel(uint8_t zoneLevel, IDiscoveryConfig const& cfg)
    {
        if (zoneLevel <= cfg.CommonMaxLevel())
            return DiscoveryTier::Common;
        if (zoneLevel <= cfg.UncommonMaxLevel())
            return DiscoveryTier::Uncommon;
        if (zoneLevel <= cfg.RareMaxLevel())
            return DiscoveryTier::Rare;
        return DiscoveryTier::Epic;
    }

    uint32_t DiscoveryXp(uint8_t playerLevel, uint8_t zoneLevel, DiscoveryType type,
        bool firstDiscovery, IDiscoveryConfig const& cfg)
    {
        if (!firstDiscovery)
            return 0;

        double fraction = cfg.SubzonePct();
        if (type == DiscoveryType::Landmark)
            fraction = cfg.LandmarkPct();
        else if (type == DiscoveryType::Hidden)
            fraction = cfg.HiddenPct();

        // Dangerous: a zone well above the player pays more (pushes toward the 10-15% band).
        if (zoneLevel > static_cast<uint16_t>(playerLevel) + cfg.DangerThreshold())
            fraction *= cfg.DangerMultiplier();

        return static_cast<uint32_t>(fraction * static_cast<double>(cfg.XpToNextLevel(playerLevel)) + 0.5);
    }
}

#ifndef MOD_BRANDING_CORE_ECONOMY_DISCOVERY_H
#define MOD_BRANDING_CORE_ECONOMY_DISCOVERY_H

#include <cstdint>

namespace Branding
{
    // Kinds of world discovery (§8.2). Hidden > Landmark > Subzone in reward.
    enum class DiscoveryType : uint8_t
    {
        Subzone = 0,
        Landmark,
        Hidden
    };

    // Reward tiers driven by zone level (§8.3) -- the structured ruleset content is generated against.
    enum class DiscoveryTier : uint8_t
    {
        Common = 0,
        Uncommon,
        Rare,
        Epic
    };

    class IDiscoveryConfig
    {
    public:
        virtual ~IDiscoveryConfig() = default;

        // XP-to-next for a player level (the curve discovery XP is expressed as a % of, §8.2).
        virtual uint64_t XpToNextLevel(uint8_t playerLevel) const = 0;

        // Base award fractions by discovery type (level-appropriate band, e.g. 0.04..0.08).
        virtual double SubzonePct() const = 0;
        virtual double LandmarkPct() const = 0;
        virtual double HiddenPct() const = 0;

        // A zone more than this many levels above the player counts as "dangerous" (§8.2).
        virtual uint8_t DangerThreshold() const = 0;
        // Multiplier applied for a dangerous discovery (pushes 4-8% toward the 10-15% band).
        virtual double DangerMultiplier() const = 0;

        // Zone-level upper bounds for each discovery tier (§8.3).
        virtual uint8_t CommonMaxLevel() const = 0;
        virtual uint8_t UncommonMaxLevel() const = 0;
        virtual uint8_t RareMaxLevel() const = 0;
    };

    // §8.3: zone level -> discovery tier (monotonic non-decreasing in zone level).
    DiscoveryTier TierForZoneLevel(uint8_t zoneLevel, IDiscoveryConfig const& cfg);

    // §8.2: discovery XP as a fraction of the player's level-to-next. 0 if not the first discovery
    // (idempotent). Dangerous zones pay more; hidden > landmark > subzone; scales with player level.
    uint32_t DiscoveryXp(uint8_t playerLevel, uint8_t zoneLevel, DiscoveryType type,
        bool firstDiscovery, IDiscoveryConfig const& cfg);
}

#endif // MOD_BRANDING_CORE_ECONOMY_DISCOVERY_H

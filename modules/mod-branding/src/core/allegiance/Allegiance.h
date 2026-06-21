#ifndef MOD_BRANDING_CORE_ALLEGIANCE_ALLEGIANCE_H
#define MOD_BRANDING_CORE_ALLEGIANCE_ALLEGIANCE_H

#include "common/Brand.h"
#include "contribution/ContributionTypes.h"
#include <cstdint>

namespace Branding
{
    // Soft ideological allegiances replacing hard faction gating (§12). Influence rewards/efficiency,
    // NOT access.
    enum class Allegiance : uint8_t
    {
        None = 0,
        FireChaos,
        NatureWild,
        ShadowVoid,
        TitanOrder,
        COUNT
    };

    class IAllegianceConfig
    {
    public:
        virtual ~IAllegianceConfig() = default;
        // Efficiency multiplier when the player's allegiance matches the content's alignment.
        virtual double MatchEfficiency() const = 0;   // e.g. 1.15
    };

    // Reward/efficiency modifier (§12). Match -> bonus; mismatch/None -> 1.0 (never a penalty:
    // allegiance is soft, it does not restrict access). Always >= 1.0.
    double AllegianceEfficiency(Allegiance player, Allegiance contentAlignment, IAllegianceConfig const& cfg);

    // Maps a content brand to its ideological allegiance (§12). Brands with no inherent side
    // (e.g. Holy/Physical) map to None so they stay efficiency-neutral. This is the bridge the
    // application point uses to ask "does this content match the player's allegiance?".
    Allegiance BrandAlignment(BrandId brand);

    // Maps a public event type to the ideological allegiance its reward is aligned to (§9/§12).
    // Used by the reward application point so a player whose allegiance matches the event gets the
    // soft efficiency bonus.
    Allegiance EventAlignment(EventType type);

    // Validates a selection id from user input into a real allegiance. None (0) and out-of-range
    // values are rejected -- a player must commit to an actual side. On success writes `out` and
    // returns true; otherwise leaves `out` untouched and returns false.
    bool ParseAllegiance(uint32_t id, Allegiance& out);
}

#endif // MOD_BRANDING_CORE_ALLEGIANCE_ALLEGIANCE_H

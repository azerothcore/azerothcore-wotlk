#ifndef MOD_BRANDING_CORE_ALLEGIANCE_ALLEGIANCE_H
#define MOD_BRANDING_CORE_ALLEGIANCE_ALLEGIANCE_H

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
}

#endif // MOD_BRANDING_CORE_ALLEGIANCE_ALLEGIANCE_H

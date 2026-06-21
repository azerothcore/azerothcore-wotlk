#include "Allegiance.h"

namespace Branding
{
    double AllegianceEfficiency(Allegiance player, Allegiance contentAlignment, IAllegianceConfig const& cfg)
    {
        // Soft system: a match rewards, a mismatch or no allegiance is simply neutral (never a penalty).
        if (player == Allegiance::None || player != contentAlignment)
            return 1.0;

        return cfg.MatchEfficiency();
    }

    Allegiance BrandAlignment(BrandId brand)
    {
        switch (brand)
        {
            case BrandId::Fire:   return Allegiance::FireChaos;
            case BrandId::Nature: return Allegiance::NatureWild;
            case BrandId::Shadow: return Allegiance::ShadowVoid;
            case BrandId::Arcane: return Allegiance::TitanOrder;
            // Frost/Holy/Physical carry no ideological side -> neutral.
            default:              return Allegiance::None;
        }
    }

    Allegiance EventAlignment(EventType type)
    {
        switch (type)
        {
            case EventType::Invasion:          return Allegiance::FireChaos;
            case EventType::ResourceSurge:     return Allegiance::NatureWild;
            case EventType::EliteHunt:         return Allegiance::ShadowVoid;
            case EventType::ProfessionAnomaly: return Allegiance::TitanOrder;
            default:                           return Allegiance::None;
        }
    }

    bool ParseAllegiance(uint32_t id, Allegiance& out)
    {
        if (id == 0 || id >= static_cast<uint32_t>(Allegiance::COUNT))
            return false;

        out = static_cast<Allegiance>(id);
        return true;
    }
}

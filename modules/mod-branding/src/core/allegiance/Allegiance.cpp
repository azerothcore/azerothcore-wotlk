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
}

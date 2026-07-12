#include "KillSizing.h"
#include <algorithm>
#include <cmath>

namespace Branding
{
    double DifficultyMul(KillBand band, IBrandingConfig const& cfg)
    {
        double const floor = std::clamp(cfg.GreyFloor(), 0.0, 1.0);

        switch (band)
        {
        case KillBand::Full:
            return 1.0;
        case KillBand::Green:
            return (1.0 + floor) / 2.0;   // taper midpoint between full worth and the grey floor
        case KillBand::Grey:
        default:
            return floor;
        }
    }

    uint32_t KillBaseUnits(uint32_t atLevelGain, KillBand band, KillClassification classification,
        IBrandingConfig const& cfg)
    {
        double const value = static_cast<double>(atLevelGain) * DifficultyMul(band, cfg)
            * cfg.ClassWeight(classification);

        if (value <= 0.0)
            return 0;

        return static_cast<uint32_t>(std::llround(value));
    }
}

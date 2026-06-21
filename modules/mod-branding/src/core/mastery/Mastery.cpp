#include "Mastery.h"
#include <algorithm>

namespace Branding
{
    double MasteryEffectiveness(bool accountUnlocked, uint8_t characterLevel, IMasteryConfig const& cfg)
    {
        // Dual-key: the account must have unlocked the system before character skill counts (§14).
        if (!accountUnlocked || cfg.MaxMasteryLevel() == 0)
            return 0.0;

        double const effectiveness = static_cast<double>(characterLevel) / static_cast<double>(cfg.MaxMasteryLevel());
        return std::min(1.0, effectiveness);
    }

    double MasteryBonus(bool accountUnlocked, uint8_t characterLevel, IMasteryConfig const& cfg)
    {
        // Linear consumer mapping: the bounded MaxBonus weighted by the dual-key effectiveness, so
        // either key missing yields exactly 0 and full effectiveness yields exactly MaxBonus.
        return cfg.MaxBonus() * MasteryEffectiveness(accountUnlocked, characterLevel, cfg);
    }
}

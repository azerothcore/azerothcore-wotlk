#ifndef MOD_BRANDING_CORE_MASTERY_MASTERY_H
#define MOD_BRANDING_CORE_MASTERY_MASTERY_H

#include <cstdint>

namespace Branding
{
    class IMasteryConfig
    {
    public:
        virtual ~IMasteryConfig() = default;
        virtual uint8_t MaxMasteryLevel() const = 0;
    };

    // §14 dual-key (the same anti-P2W principle as §1/§7): a mastery is effective only when the
    // account has UNLOCKED it AND the character has EARNED the skill. Account unlock alone is inert
    // (returns 0), and character level alone (without the account unlock) is inert too. Returns a
    // normalized effectiveness in [0, 1].
    double MasteryEffectiveness(bool accountUnlocked, uint8_t characterLevel, IMasteryConfig const& cfg);
}

#endif // MOD_BRANDING_CORE_MASTERY_MASTERY_H

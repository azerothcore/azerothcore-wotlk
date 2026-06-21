#ifndef MOD_BRANDING_CORE_MASTERY_MASTERY_H
#define MOD_BRANDING_CORE_MASTERY_MASTERY_H

#include <cstdint>

namespace Branding
{
    // §14 concrete masteries an account can unlock. Each pairs an account-wide unlock with a
    // per-character earned skill level; the effect a mastery scales is named alongside it:
    //   Gathering -> bonus yield when harvesting (mining / herbalism / skinning).
    //   Crafting  -> bonus yield / reduced material waste when crafting.
    // Keep COUNT last; persisted by ordinal value, so only ever append.
    enum class MasterySystem : uint8_t
    {
        Gathering = 0,
        Crafting  = 1,
        COUNT
    };

    class IMasteryConfig
    {
    public:
        virtual ~IMasteryConfig() = default;
        virtual uint8_t MaxMasteryLevel() const = 0;
        // Largest fractional bonus a fully-effective mastery grants its consumer (e.g. 0.20 = +20%).
        virtual double MaxBonus() const = 0;
    };

    // §14 dual-key (the same anti-P2W principle as §1/§7): a mastery is effective only when the
    // account has UNLOCKED it AND the character has EARNED the skill. Account unlock alone is inert
    // (returns 0), and character level alone (without the account unlock) is inert too. Returns a
    // normalized effectiveness in [0, 1].
    double MasteryEffectiveness(bool accountUnlocked, uint8_t characterLevel, IMasteryConfig const& cfg);

    // The observable consumer value: a bounded fractional bonus (extra gathered/crafted units) that
    // scales linearly with effectiveness, from 0.0 (either key missing) up to cfg.MaxBonus(). Pure:
    // callers multiply a base quantity by (1 + this) to get the boosted amount.
    double MasteryBonus(bool accountUnlocked, uint8_t characterLevel, IMasteryConfig const& cfg);
}

#endif // MOD_BRANDING_CORE_MASTERY_MASTERY_H

#ifndef MOD_BRANDING_CORE_SCALING_SCALINGCONFIG_H
#define MOD_BRANDING_CORE_SCALING_SCALINGCONFIG_H

#include <cstdint>

namespace Branding
{
    // Injected tunables for the scaling systems (§2.1 player downscaling, §2.2 group scaling).
    // Pure core reads no globals; production wraps sConfigMgr, tests inject a pinned fake.
    class IScalingConfig
    {
    public:
        virtual ~IScalingConfig() = default;

        // --- Player stat scaling (§2.1) ---
        // Stat-growth exponent: factor = (target/player)^exp, clamped to <= 1.0 (downward only).
        virtual double StatScalingExponent() const = 0;

        // --- Group-size encounter scaling (§2.2) ---
        // Encounter multiplier at the smallest group (interpolates up to 1.0 at content size).
        virtual double GroupHealthFloor() const = 0;
        virtual double GroupDamageFloor() const = 0;

        // --- Group-size reward scaling (§2.2) ---
        virtual uint32_t MaxGroupMaterials() const = 0;   // material quantity at full group
        virtual uint8_t MaxRewardTier() const = 0;        // reward-tier cap at full group
        virtual double RareChanceMulMin() const = 0;      // rare/epic chance mult at smallest group
        virtual double RareChanceMulMax() const = 0;      // ...at full group

        // --- Branding-currency reduction (§2.4.3) ---
        // currencyMul = clamp(fraction^exp, floor, 1.0); exp >= 1 makes currency steeper than gear.
        virtual double CurrencyReductionExponent() const = 0;
        virtual double CurrencyMulFloor() const = 0;

        // --- Branding Boon: selectable raid-wide economy rate (§2.7, issues #81, #83) ---
        // Per-axis multiplier caps (the Drop cap is the migrated #81 +50%). Each axis is an
        // independent DR bucket, so a raid can light up all three at once without cross-axis
        // compounding. A lone maxed selector on an axis reaches exactly that axis's cap.
        virtual double BoonDropCap() const = 0;   // e.g. 1.5 = at most +50% instanced drop chance
        virtual double BoonXpCap() const = 0;     // e.g. 1.5 = at most +50% XP rate
        virtual double BoonGoldCap() const = 0;   // e.g. 1.5 = at most +50% gold rate
        // Geometric same-axis diminishing returns -- the SAME harsh curve as the §7.9 catalyst
        // (production reads the shared Branding.Catalyst.StackDecay): 1st selector full, each
        // subsequent one weighted decay^(i-1) (default 0.4 -> 1, 0.4, 0.16, ...).
        virtual double BoonStackDecay() const = 0;
        // Proficiency ceiling used to normalize a selector's rank into a [0,1] strength; equals the
        // §7 proficiency MaxLevel (Branding.Level.Max, default 50).
        virtual uint8_t BoonMaxRank() const = 0;
    };
}

#endif // MOD_BRANDING_CORE_SCALING_SCALINGCONFIG_H

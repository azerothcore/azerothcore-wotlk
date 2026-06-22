#ifndef MOD_BRANDING_CORE_CATALYST_CATALYSTSTACKING_H
#define MOD_BRANDING_CORE_CATALYST_CATALYSTSTACKING_H

#include "CatalystConfig.h"
#include "branding/common/Brand.h"
#include "branding/mastery/MasteryTrees.h"
#include <cstddef>
#include <cstdint>

namespace Branding
{
    // Effectiveness weight of the rank-th same-bucket branded specialist (1-indexed), in [0, 1].
    // rank 0 -> 0 (no specialist); rank 1 -> 1.0 (full); decays geometrically thereafter (§9 catalyst).
    double CatalystStackWeight(uint8_t rank, ICatalystConfig const& cfg);

    // The raid catalyst multiplier applied for the rank-th same-bucket branded specialist.
    // In [1.0, MaxRaidMul] for all inputs (a brand never hurts the raid), monotonically
    // NON-INCREASING in rank (1st full, 2nd reduced, 3rd+ heavily reduced; §7.9).
    double RaidCatalystMultiplier(uint8_t rank, ICatalystConfig const& cfg);

    // Aggregate multiplier from `count` same-bucket branded SOURCES stacked on ONE actor -- e.g. several
    // Etched items of the active school on a character (#31 decision 5). Each successive source is DR'd by
    // the same geometric stack weight as the raid curve, so the total SATURATES: the 1st source carries
    // most of the bonus and extra sources add ever less, capped at MaxRaidMul. Closed form (reusing
    // CatalystStackWeight): 1 + (MaxRaidMul - 1) * (1 - StackDecay) * sum_{r=1..count} StackWeight(r),
    // clamped to [1, MaxRaidMul]. count 0 -> 1.0. Monotonic non-decreasing in count. This is the
    // "wardrobe flexibility, not stacked power" guarantee: stacking Etched items never runs past the cap.
    double CatalystSelfStackMultiplier(uint8_t count, ICatalystConfig const& cfg);

    // §14.9: the catalyst DR bucket identity is (school, tree) -- NOT school alone and NOT role.
    // Two specialists share a DR bucket only when BOTH match, so Fire-Def / Fire-Off / Fire-Support
    // are three independent buckets (complementary, no DR); only a repeated cell stacks DR.
    struct CatalystKey
    {
        BrandId     school = BrandId::Fire;
        MasteryTree tree   = MasteryTree::Offensive;
    };

    bool SameCatalystBucket(CatalystKey const& a, CatalystKey const& b);

    // 1-based rank of roster[index] among the PRIOR entries sharing its (school, tree) bucket. The
    // adapter passes a deterministically ordered roster (e.g. GUID-sorted) so ranks are stable.
    // Returns 0 for a null roster or out-of-range index. Feeds CatalystStackWeight / RaidCatalystMultiplier.
    uint8_t CatalystRankInBucket(CatalystKey const* roster, std::size_t count, std::size_t index);
}

#endif // MOD_BRANDING_CORE_CATALYST_CATALYSTSTACKING_H

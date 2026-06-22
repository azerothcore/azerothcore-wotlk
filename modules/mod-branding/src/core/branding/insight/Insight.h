#ifndef MOD_BRANDING_CORE_INSIGHT_INSIGHT_H
#define MOD_BRANDING_CORE_INSIGHT_INSIGHT_H

#include "branding/common/Clock.h"
#include <cstdint>

// Pure core. No AzerothCore includes are permitted anywhere under core/ (only the standard library
// and own headers). Insight is the Knowledge-unlock currency (design §14.13.1, issue #18): a
// per-(account, school) NON-tradeable fractional DB point counter -- the deliberate exception to
// §16.3 (it is not an item). Earned from kills with ACCOUNT-WIDE diminishing returns; reaching the
// threshold unlocks the permanent Knowledge row once.
namespace Branding
{
    // Kill source ranks that yield Insight (design §14.13.1).
    //  - RaidBoss            : the backbone, ~1.0 Insight; weekly lockout is the throttle, no intra-week DR.
    //  - DungeonBossHeroic   : farmable, so DR is essential; heroic yields more than normal.
    //  - DungeonBossNormal   : farmable, DR'd, below heroic.
    //  - TrashMote           : generic world-mob "mote", VERY low rate, school-agnostic breadcrumb.
    enum class SourceRank : uint8_t
    {
        RaidBoss = 0,
        DungeonBossHeroic,
        DungeonBossNormal,
        TrashMote,
        COUNT
    };

    // Injected tunables for the Insight currency. Pure core reads no globals; production wraps
    // sConfigMgr (InsightConfig adapter), tests inject a FakeInsightConfig with pinned values.
    class IInsightConfig
    {
    public:
        virtual ~IInsightConfig() = default;

        // Base Insight per kill of this rank, BEFORE diminishing returns (raid boss ~1.0; dungeon
        // bosses < 1.0 with heroic > normal; trash mote tiny). Bounded >= 0.
        virtual double BaseInsight(SourceRank rank) const = 0;

        // Per-rank diminishing-returns geometric factor applied per prior kill of a DR'd rank within
        // the rolling window: yield = base * factor^prior. Raid bosses use factor 1.0 (no intra-week
        // DR; the lockout throttles). In [0, 1].
        virtual double DrFactor(SourceRank rank) const = 0;

        // After this many seconds the account-wide DR window decays back to empty (prior count resets).
        virtual uint64_t WindowSeconds() const = 0;

        // Points needed to unlock a school's Knowledge (design §14.13.1: ~30-40 after DR tuning).
        virtual double UnlockThreshold() const = 0;
    };

    // Account-wide, per-school Insight counter (design §14.13.1). `points` is the fractional running
    // total toward UnlockThreshold; the window fields throttle DR'd repeat farming ACCOUNT-WIDE
    // (mirrors the §7.4 BrandXp DR window via the injected clock). Loaded from DB, mutated by core,
    // saved by the adapter.
    struct InsightState
    {
        double points = 0.0;             // running total toward the unlock threshold
        uint32_t windowUnits = 0;        // DR'd kills counted in the current rolling window
        uint64_t windowStartUnix = 0;    // 0 = no active window
    };

    // Insight awarded for one kill given how many DR'd kills already landed in the current
    // account-wide window. NON-INCREASING in priorThisWindowAccountWide, bounded >= 0, fractional.
    // Pure and read-only. RaidBoss ignores prior (no intra-week DR); TrashMote is a flat tiny mote.
    double InsightForKill(SourceRank rank, uint32_t priorThisWindowAccountWide, IInsightConfig const& cfg);

    // Has this school's running total reached the unlock threshold? (design §14.13.1.)
    bool UnlockReached(double points, IInsightConfig const& cfg);

    // Whether this rank's repeat farming is throttled by the rolling window (DungeonBoss*/TrashMote).
    // RaidBoss is NOT windowed -- its weekly lockout is the throttle, so it never advances the window.
    bool RankIsWindowed(SourceRank rank);

    // Applies one kill: rolls the account-wide window forward if it has fully decayed, computes the
    // DR'd Insight against the current prior count, adds it to `state.points`, advances the window
    // for windowed ranks, and returns the Insight granted. Pure given the injected clock/config.
    double EarnInsight(InsightState& state, SourceRank rank, IInsightConfig const& cfg, IClock const& clock);
}

#endif // MOD_BRANDING_CORE_INSIGHT_INSIGHT_H

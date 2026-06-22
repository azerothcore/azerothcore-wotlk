#ifndef MOD_BRANDING_TESTS_FAKES_FAKEINSIGHTCONFIG_H
#define MOD_BRANDING_TESTS_FAKES_FAKEINSIGHTCONFIG_H

#include "branding/insight/Insight.h"
#include <array>
#include <cstddef>

namespace Branding::Test
{
    // Pinned config for deterministic Insight tests (design §14.13.1). Raid boss ~1.0 (no intra-week
    // DR), dungeon bosses DR'd with heroic > normal, trash mote tiny.
    class FakeInsightConfig : public IInsightConfig
    {
    public:
        // RaidBoss 1.0, DungeonBossHeroic 0.5, DungeonBossNormal 0.25, TrashMote 0.01.
        std::array<double, static_cast<size_t>(SourceRank::COUNT)> base{ { 1.0, 0.5, 0.25, 0.01 } };
        // RaidBoss 1.0 (windowed-off anyway), heroic/normal halve per prior kill, mote 0.5.
        std::array<double, static_cast<size_t>(SourceRank::COUNT)> drFactor{ { 1.0, 0.5, 0.5, 0.5 } };
        uint64_t windowSeconds = 3600;
        double unlockThreshold = 35.0;

        double BaseInsight(SourceRank rank) const override { return base[static_cast<size_t>(rank)]; }
        double DrFactor(SourceRank rank) const override { return drFactor[static_cast<size_t>(rank)]; }
        uint64_t WindowSeconds() const override { return windowSeconds; }
        double UnlockThreshold() const override { return unlockThreshold; }
    };
}

#endif // MOD_BRANDING_TESTS_FAKES_FAKEINSIGHTCONFIG_H

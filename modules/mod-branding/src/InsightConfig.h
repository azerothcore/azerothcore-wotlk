#ifndef MOD_BRANDING_SRC_INSIGHTCONFIG_H
#define MOD_BRANDING_SRC_INSIGHTCONFIG_H

#include "branding/insight/Insight.h"
#include <array>
#include <cstddef>

namespace Branding
{
    // Production IInsightConfig: snapshots the Insight tunables from sConfigMgr at load time. The
    // pure core reads no globals; this adapter is the only place sConfigMgr is touched for Insight
    // (design §14.13.1, issue #18). Mirrors BrandingConfig.
    class InsightConfig : public IInsightConfig
    {
    public:
        // (Re)reads all options from sConfigMgr. Call on startup and on `.reload config`.
        void Load();

        bool Enabled() const { return _enabled; }
        double MoteChance() const { return _moteChance; }

        double BaseInsight(SourceRank rank) const override { return _base[static_cast<size_t>(rank)]; }
        double DrFactor(SourceRank rank) const override { return _drFactor[static_cast<size_t>(rank)]; }
        uint64_t WindowSeconds() const override { return _windowSeconds; }
        double UnlockThreshold() const override { return _unlockThreshold; }

    private:
        bool _enabled = false;
        // RaidBoss 1.0, DungeonBossHeroic 0.5, DungeonBossNormal 0.25, TrashMote 0.01.
        std::array<double, static_cast<size_t>(SourceRank::COUNT)> _base{ { 1.0, 0.5, 0.25, 0.01 } };
        // RaidBoss 1.0 (not windowed), heroic/normal halve per prior kill, mote 0.5.
        std::array<double, static_cast<size_t>(SourceRank::COUNT)> _drFactor{ { 1.0, 0.5, 0.5, 0.5 } };
        uint64_t _windowSeconds = 3600;
        double _unlockThreshold = 35.0;
        // Per-trash-kill chance to award a mote (0..1); keeps the world-mob faucet VERY low rate.
        double _moteChance = 0.02;
    };
}

#endif // MOD_BRANDING_SRC_INSIGHTCONFIG_H

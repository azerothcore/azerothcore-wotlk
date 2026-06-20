#ifndef MOD_BRANDING_TESTS_FAKES_FAKEWORLDCONFIG_H
#define MOD_BRANDING_TESTS_FAKES_FAKEWORLDCONFIG_H

#include "allegiance/Allegiance.h"
#include "economy/Discovery.h"

namespace Branding::Test
{
    class FakeAllegianceConfig : public IAllegianceConfig
    {
    public:
        double matchEfficiency = 1.15;
        double MatchEfficiency() const override { return matchEfficiency; }
    };

    class FakeDiscoveryConfig : public IDiscoveryConfig
    {
    public:
        double subzonePct = 0.06;
        double landmarkPct = 0.08;
        double hiddenPct = 0.12;
        uint8_t dangerThreshold = 5;
        double dangerMultiplier = 2.0;
        uint8_t commonMaxLevel = 20;
        uint8_t uncommonMaxLevel = 40;
        uint8_t rareMaxLevel = 60;

        // Simple monotonic XP curve for deterministic tests.
        uint64_t XpToNextLevel(uint8_t playerLevel) const override { return static_cast<uint64_t>(playerLevel) * 1000ull; }
        double SubzonePct() const override { return subzonePct; }
        double LandmarkPct() const override { return landmarkPct; }
        double HiddenPct() const override { return hiddenPct; }
        uint8_t DangerThreshold() const override { return dangerThreshold; }
        double DangerMultiplier() const override { return dangerMultiplier; }
        uint8_t CommonMaxLevel() const override { return commonMaxLevel; }
        uint8_t UncommonMaxLevel() const override { return uncommonMaxLevel; }
        uint8_t RareMaxLevel() const override { return rareMaxLevel; }
    };
}

#endif // MOD_BRANDING_TESTS_FAKES_FAKEWORLDCONFIG_H

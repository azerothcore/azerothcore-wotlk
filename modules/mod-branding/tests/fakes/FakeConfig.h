#ifndef MOD_BRANDING_TESTS_FAKES_FAKECONFIG_H
#define MOD_BRANDING_TESTS_FAKES_FAKECONFIG_H

#include "common/Config.h"
#include <array>
#include <cstddef>

namespace Branding::Test
{
    // Pinned, tweakable config for deterministic tests. Defaults are neutral (weight/relevance 1.0,
    // no DR) so a test sets only the dials it cares about. Matches the §7.4 spec contract.
    class FakeConfig : public IBrandingConfig
    {
    public:
        // Per-source dials (indexed by ActivitySource). Default neutral.
        std::array<double, static_cast<size_t>(ActivitySource::COUNT)> sourceWeight{ { 1.0, 1.0, 1.0, 1.0, 1.0, 1.0 } };
        std::array<double, static_cast<size_t>(ActivitySource::COUNT)> relevance{ { 1.0, 1.0, 1.0, 1.0, 1.0, 1.0 } };
        std::array<double, static_cast<size_t>(RoleContribution::COUNT)> roleMul{ { 1.0, 1.0, 1.0, 1.0, 1.0, 1.0 } };

        double matchBonus = 1.25;

        // DR off by default (soft cap huge) so base tests are unaffected.
        uint32_t drSoftCap = 0xFFFFFFFFu;
        double drFloor = 0.1;
        double drSlope = 0.0;
        uint64_t drWindowSeconds = 3600;

        // Level curve: XpForLevel(n) = round(baseXp * n^exponent), capped at maxLevel.
        double baseXp = 100.0;
        double exponent = 2.0;
        uint8_t maxLevel = 50;

        double SourceWeight(ActivitySource source) const override { return sourceWeight[static_cast<size_t>(source)]; }
        double RelevanceMul(ActivitySource source) const override { return relevance[static_cast<size_t>(source)]; }
        double MatchBonus() const override { return matchBonus; }
        double RoleMul(RoleContribution role) const override { return roleMul[static_cast<size_t>(role)]; }

        uint32_t DrSoftCap() const override { return drSoftCap; }
        double DrFloor() const override { return drFloor; }
        double DrSlope() const override { return drSlope; }
        uint64_t DrWindowSeconds() const override { return drWindowSeconds; }

        double BaseXp() const override { return baseXp; }
        double Exponent() const override { return exponent; }
        uint8_t MaxLevel() const override { return maxLevel; }
    };
}

#endif // MOD_BRANDING_TESTS_FAKES_FAKECONFIG_H

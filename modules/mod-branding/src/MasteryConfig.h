#ifndef MOD_BRANDING_SRC_MASTERYCONFIG_H
#define MOD_BRANDING_SRC_MASTERYCONFIG_H

#include "branding/mastery/Mastery.h"
#include "branding/mastery/MasteryTrees.h"
#include <cstdint>

namespace Branding
{
    // Production config for §14 mastery: snapshots the tunables from sConfigMgr at load time. Backs
    // BOTH IMasteryConfig (the gathering/craft efficiency bonus) and IMasteryTreeConfig (the combat
    // trees: upkeep asymptote, enemy ceiling, and the §14.10 ppm/duration/magnitude tuning budget).
    // The pure core reads no globals; this adapter is the only place sConfigMgr is touched here.
    class MasteryConfig : public IMasteryConfig, public IMasteryTreeConfig
    {
    public:
        void Load();
        bool Enabled() const { return _enabled; }

        // IMasteryConfig + IMasteryTreeConfig share this method (one override satisfies both).
        uint8_t MaxMasteryLevel() const override { return _maxLevel; }
        double MaxBonus() const override { return _maxBonus; }

        // IMasteryTreeConfig (§14.2/§14.3/§14.8/§14.10).
        double   MaxUptime() const override { return _maxUptime; }
        double   UpkeepHalfLevel() const override { return _upkeepHalfLevel; }
        double   OffSchoolFactor() const override { return _offSchoolFactor; }
        double   MaxEnemyMul() const override { return _maxEnemyMul; }
        double   MinPpm() const override { return _minPpm; }
        double   MaxPpm() const override { return _maxPpm; }
        uint32_t MinWindowMs() const override { return _minWindowMs; }
        uint32_t MaxWindowMs() const override { return _maxWindowMs; }
        double   MaxProcMagnitude() const override { return _maxProcMagnitude; }
        double   MinReach() const override { return _minReach; }
        double   MaxReach() const override { return _maxReach; }
        // §14.4.1: 1 archetype at level 0, +1 every _archetypeUnlockStep levels (>= 1 step).
        uint8_t  MaxArchetypesAtLevel(uint8_t proficiencyLevel) const override
        {
            uint32_t const step = _archetypeUnlockStep > 0 ? _archetypeUnlockStep : 1;
            return static_cast<uint8_t>(1 + proficiencyLevel / step);
        }

    private:
        bool _enabled = false;
        uint8_t _maxLevel = 50;
        double _maxBonus = 0.20;

        // §14.10 combat-tree tunables (the player-tuning knob lives in module config).
        double _maxUptime = 0.60;
        double _upkeepHalfLevel = 25.0;
        double _offSchoolFactor = 0.25;
        double _maxEnemyMul = 1.5;
        double _minPpm = 1.0;
        double _maxPpm = 10.0;
        uint32_t _minWindowMs = 3000;
        uint32_t _maxWindowMs = 12000;
        double _maxProcMagnitude = 2.0;
        double _minReach = 0.0;
        double _maxReach = 40.0;
        uint32_t _archetypeUnlockStep = 20;  // §14.4.1: levels per additional unlocked proc archetype
    };
}

#endif // MOD_BRANDING_SRC_MASTERYCONFIG_H

#ifndef MOD_BRANDING_CORE_PROFICIENCY_KILLSIZING_H
#define MOD_BRANDING_CORE_PROFICIENCY_KILLSIZING_H

#include "branding/common/Brand.h"
#include "branding/common/Config.h"
#include <cstdint>

namespace Branding
{
    // Per-kill proficiency sizing (design §7.4 / issue #32). The adapter feeds two con-independent
    // inputs it reads off the game -- the "as if at-level" worth (Acore::XP::BaseGain(pl, pl, content),
    // which strips the level-diff penalty) and the kill's con-color band -- and gets back the
    // XpActivity::baseUnits that then runs through the existing source/match/DR pipeline.
    //
    // Pure and read-only: identical inputs -> identical result, so band boundaries are unit-testable
    // without any AzerothCore state.

    // Difficulty multiplier for a kill's con-color band: 1.0 for at/above-level (Full), tapering to
    // cfg.GreyFloor() at Grey. Green is the midpoint of the taper. Never returns 0 -- a grey/ambient
    // kill still pays the floor, so proficiency is earnable "anywhere" without the vanilla grey->0
    // cliff. Result is clamped to [GreyFloor, 1.0].
    double DifficultyMul(KillBand band, IBrandingConfig const& cfg);

    // The XpActivity::baseUnits magnitude for a single kill:
    //   round(atLevelGain * DifficultyMul(band) * cfg.ClassWeight(classification))
    // atLevelGain is the level-diff-stripped at-level worth supplied by the adapter.
    uint32_t KillBaseUnits(uint32_t atLevelGain, KillBand band, KillClassification classification,
        IBrandingConfig const& cfg);
}

#endif // MOD_BRANDING_CORE_PROFICIENCY_KILLSIZING_H

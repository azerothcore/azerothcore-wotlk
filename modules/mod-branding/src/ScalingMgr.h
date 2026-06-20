#ifndef MOD_BRANDING_SRC_SCALINGMGR_H
#define MOD_BRANDING_SRC_SCALINGMGR_H

#include "ScalingConfig.h"

class Player;

namespace Branding
{
    // Adapter for zone downscaling (§2.1). Resolves a player's current zone bracket and returns the
    // downward-only scaling factor from the pure core, applied to the player's outgoing damage.
    class ScalingMgr
    {
    public:
        static ScalingMgr* instance();

        void LoadConfig();
        bool Enabled() const { return _config.Enabled(); }

        // Outgoing-damage multiplier in (0, 1] for an over-leveled player; 1.0 when not over-leveled,
        // disabled, or the zone has no defined level.
        double PlayerOutgoingFactor(Player* attacker) const;

    private:
        ScalingMgr() = default;
        ScalingConfig _config;
    };
}

#define sScalingMgr Branding::ScalingMgr::instance()

#endif // MOD_BRANDING_SRC_SCALINGMGR_H

#ifndef MOD_BRANDING_SRC_SCALINGMGR_H
#define MOD_BRANDING_SRC_SCALINGMGR_H

#include "ScalingConfig.h"
#include "branding/scaling/GroupScaling.h"
#include "branding/scaling/ZoneBracket.h"

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

        // §2.7 Branding Boon (issues #81/#83): whether the selectable raid-wide boon is active.
        bool BoonEnabled() const { return _config.BoonEnabled(); }

        // Copper charged to change an already-chosen boon axis (0 = free / disabled charge, #83).
        uint32_t BoonReselectCost() const { return _config.BoonReselectCost(); }

        // §2.7: raid-wide multiplier for one boon axis, from the proficiency ranks of the group
        // members who SELECTED that axis (the actor alone when ungrouped). Reads proficiency +
        // selection from the ObjectGuid-keyed caches; no Player* is stored past the call. 1.0 when no
        // selecting member has any rank. Drives the Drop/Xp/Gold application hooks.
        double BoonMultiplier(Player const* actor, BoonAxis axis) const;

        // Load the admin-tunable per-zone bracket table (`branding_zone_bracket`) into the pure core.
        // Called on startup and `.reload config`; safe to call repeatedly (clears + repopulates).
        void LoadZoneBrackets();

        // Outgoing-damage multiplier in (0, 1] for an over-leveled player; 1.0 when not over-leveled,
        // disabled, or the zone has no defined level.
        double PlayerOutgoingFactor(Player* attacker) const;

        // §2.4.3 branding-currency multiplier for a group running content of a given intended size
        // (e.g. 5 in a 40-man). Independent of Branding.Scaling.Enable -- it uses only the currency
        // dials. 1.0 at full group; floored for a small group (steeper than gear).
        double CurrencyMulForGroup(uint8_t groupSize, uint8_t contentSize) const;

    private:
        ScalingMgr() = default;
        ScalingConfig _config;
        ZoneBracketTable _zoneBrackets;
    };
}

#define sScalingMgr Branding::ScalingMgr::instance()

#endif // MOD_BRANDING_SRC_SCALINGMGR_H

#ifndef MOD_BRANDING_SRC_CATALYSTMGR_H
#define MOD_BRANDING_SRC_CATALYSTMGR_H

#include "CatalystConfig.h"
#include "EffectConfig.h"

class Player;

namespace Branding
{
    // Adapter for catalyst stacking (§7.9 / §9 / Slice 4). Scans a player's group/raid for same-role
    // branded specialists, assigns a deterministic rank (by GUID), and feeds the catalyst stacking
    // weight into the raid multiplier (1st full, 2nd reduced, 3rd+ heavy). The same-role count is
    // sampled LIVE at query time (Risk #4 -- not snapshotted at pull), so stacking cannot be gamed.
    //
    // First cut computes + exposes the rank and raid multiplier (via `.branding info`); broadcasting
    // the raid buff to allies needs the aura layer and is a follow-up.
    class CatalystMgr
    {
    public:
        static CatalystMgr* instance();

        void LoadConfig();
        bool Enabled() const { return _catalyst.Enabled(); }

        // The catalyst DR config (StackDecay / MaxRaidMul), shared with other systems that reuse the
        // catalyst curve -- e.g. the #31 Etch self-stack aggregate (CatalystSelfStackMultiplier).
        ICatalystConfig const& Config() const { return _catalyst; }

        // 1-based rank of the player among same-role branded specialists in their group (1 = sole/
        // first specialist, full effect). 0 if the player isn't a branded, expressible specialist.
        uint8_t SameRoleBrandedRank(Player* player) const;

        // Catalyst-scaled raid multiplier for the player at their current rank: in [1.0, MaxRaidMul],
        // non-increasing as same-role specialists stack. 1.0 when disabled or rank 0.
        double RaidMultiplierFor(Player* player) const;

    private:
        CatalystMgr() = default;
        CatalystConfig _catalyst;
        EffectConfig _effect;   // for the raid multiplier caps / role scale (§7.9)
    };
}

#define sCatalystMgr Branding::CatalystMgr::instance()

#endif // MOD_BRANDING_SRC_CATALYSTMGR_H

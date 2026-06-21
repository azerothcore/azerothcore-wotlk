#ifndef MOD_BRANDING_SRC_EFFECTMGR_H
#define MOD_BRANDING_SRC_EFFECTMGR_H

#include "EffectConfig.h"

class Player;

namespace Branding
{
    // Adapter for the branding effect model (§7.9). Resolves a player's active brand (loadout) +
    // proficiency level + effect profile into the personal multiplier applied to their outgoing
    // damage during an active window. Anti-P2W gated: inert unless the account can express the brand.
    //
    // First cut: applies the PERSONAL multiplier (windowed) using the Damage/RaidWindow profile for
    // all branded players. Role-specific profiles (tank PersonalSpike, healer MechanicTransform) and
    // the raid multiplier (catalyst-scaled, issue #04) build on this.
    class EffectMgr
    {
    public:
        static EffectMgr* instance();

        void LoadConfig();
        bool Enabled() const { return _config.Enabled(); }

        // Outgoing-damage multiplier in [1.0, MaxPersonalMul] for the player right now; 1.0 when
        // disabled, the brand isn't account-expressible, or the effect window is not active.
        double PersonalMultiplierFor(Player* attacker) const;

    private:
        EffectMgr() = default;
        EffectConfig _config;
    };
}

#define sEffectMgr Branding::EffectMgr::instance()

#endif // MOD_BRANDING_SRC_EFFECTMGR_H

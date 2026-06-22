#ifndef MOD_BRANDING_SRC_EFFECTMGR_H
#define MOD_BRANDING_SRC_EFFECTMGR_H

#include "EffectConfig.h"
#include "branding/effects/EffectModel.h"
#include <cstdint>

class Player;
class Unit;

namespace Branding
{
    // Adapter for the §7.9 branding effect model. Resolves a player's active brand (loadout) +
    // proficiency level + role into the per-kind effect, then applies it during the active window:
    //   - RaidWindow (dps)      -> bounded outgoing-damage multiplier (catalyst-DR'd, issue #04 seam),
    //   - PersonalSpike (tank)  -> large outgoing multiplier AND inverse incoming-damage reduction,
    //   - MechanicTransform (healer) -> wasted overheal converted to an absorb shield.
    // Anti-P2W gated: every path is inert unless the CURRENT account can express the brand. The
    // §7.9 caps and the windowed "no passive uptime" rule live in the pure model; this is a thin applier.
    class EffectMgr
    {
    public:
        static EffectMgr* instance();

        void LoadConfig();
        bool Enabled() const { return _config.Enabled(); }

        // Outgoing-damage multiplier in [1.0, MaxPersonalMul] for the player right now; 1.0 when
        // disabled, the brand isn't account-expressible, or the effect window is not active.
        double OutgoingMultiplierFor(Player* attacker) const;

        // Incoming-damage multiplier in (0.0, 1.0] for a branded tank during its PersonalSpike window
        // (survivability spike); 1.0 otherwise. The caller multiplies it onto damage the player takes.
        double IncomingDamageMultiplierFor(Player* victim) const;

        // Healer MechanicTransform: shield amount to grant `target` from the overheal in a `heal` cast
        // by branded-healer `healer`; 0 when the healer isn't an expressible branded healer or there is
        // no overheal. The caller applies the absorb (see Branding.Effect.OverhealShieldSpell).
        uint32_t OverhealShieldFor(Player* healer, Unit* target, uint32_t heal) const;

        // Spell id used as the absorb-shield costume for the overheal transform (adapter-only config).
        uint32_t OverhealShieldSpell() const { return _overhealShieldSpell; }

        // Inspection (.branding info): fills the player's resolved profile + effect level, returns
        // false when disabled / no account-expressible brand. Does not gate on the window phase.
        bool ResolveActiveProfile(Player* player, EffectProfile& profile, uint8_t& level) const;

    private:
        EffectMgr() = default;

        // Shared gate: true + fills (profile, level) when `player` has an account-expressible active
        // brand and the system is enabled; false (leaving outputs untouched) otherwise.
        bool Resolve(Player* player, EffectProfile& profile, uint8_t& level) const;

        EffectConfig _config;
        uint32_t _overhealShieldSpell = 0;
    };
}

#define sEffectMgr Branding::EffectMgr::instance()

#endif // MOD_BRANDING_SRC_EFFECTMGR_H

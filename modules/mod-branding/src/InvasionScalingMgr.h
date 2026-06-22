#ifndef MOD_BRANDING_SRC_INVASIONSCALINGMGR_H
#define MOD_BRANDING_SRC_INVASIONSCALINGMGR_H

#include "InvasionScalingConfig.h"
#include "ScalingConfig.h"

class Creature;

namespace Branding
{
    // Adapter for §2.5 invasion creature difficulty (issue #26). The crowd-scaling twin of
    // MasteryEnemyMgr: an invasion creature's OUTGOING damage is multiplied by the crowd-keyed curve,
    // applied on the creature-attacker branch of a UnitScript (the §2.1 player downscale / §7.9 player
    // branding scripts only touch Player attackers, so this rides on top of the encounter baseline).
    //
    // Asymmetric levers (§2.5.1): a boss/mini-boss (worldboss/elite) uses the full §2.2
    // EncounterDamageMul (softer for a small crowd, authored difficulty at a full crowd); trash uses
    // the gentle InvasionTrashMul (baseline at a solo straggler, harder as the crowd grows). The
    // spawn-COUNT lever lives in EventScheduler; this manager only scales per-mob damage.
    //
    // No raw Creature*/Unit* is stored past a call -- rank, zone, headcount and the active-invasion
    // gate all resolve at call time. Health scaling is a documented follow-up (needs a creature-add
    // hook; §2.2 health is likewise not yet wired).
    class InvasionScalingMgr
    {
    public:
        static InvasionScalingMgr* instance();

        void LoadConfig();
        bool Enabled() const { return _invConfig.Enabled(); }

        // OUTGOING-damage multiplier for an invasion creature; 1.0 when disabled, not in an active
        // invasion, or (for trash at a solo crowd) simply the authored baseline.
        double OutgoingMultiplierFor(Creature* attacker) const;

    private:
        InvasionScalingMgr() = default;

        // §2.5.1 gate: an Invasion event is active in the creature's zone (mirrors MasteryEnemyMgr).
        static bool InActiveInvasion(Creature const* creature);

        ScalingConfig _scaling;            // §2.2 group dials, reused for the boss curve
        InvasionScalingConfig _invConfig;  // §2.5 gate + invasion dials (intended size, trash curve)
    };
}

#define sInvasionScalingMgr Branding::InvasionScalingMgr::instance()

#endif // MOD_BRANDING_SRC_INVASIONSCALINGMGR_H

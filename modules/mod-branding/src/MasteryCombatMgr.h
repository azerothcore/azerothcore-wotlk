#ifndef MOD_BRANDING_SRC_MASTERYCOMBATMGR_H
#define MOD_BRANDING_SRC_MASTERYCOMBATMGR_H

#include "CatalystConfig.h"
#include "EffectConfig.h"
#include "branding/catalyst/CatalystStacking.h"
#include "branding/common/Brand.h"
#include "branding/mastery/MasteryPlan.h"
#include "ObjectGuid.h"
#include <cstddef>
#include <cstdint>

class Player;

namespace Branding
{
    // Adapter for the §14.12 mastery COMBAT layer (issue #27). On combat/proc hooks it builds the pure
    // MasteryPlan from the live state it can read -- MasteryLoadoutMgr's active set + ProficiencyMgr's
    // per-school level/knowledge + MasteryConfig's three injected configs -- then applies each
    // ResolvedMasteryEffect in-world: windowed Off/Def cells as proc-cadence buff/debuff auras (PPM via
    // ExpectedProcs), sustained Support cells as maintained auras, personal-spike Def cells as tank
    // survivability auras. The §7.9 caps + catalyst DR are already baked into the plan, so the adapter
    // is a dumb applier. No raw Player*/Unit* is stored past a call -- everything resolves at call time
    // and timed cadence is keyed by ObjectGuid (project long-lived-reference rule).
    //
    // First cut (link-deferred per module practice): the plan build + the personal/raid magnitude
    // application points are wired; the EventMap/TaskScheduler proc-cadence loop and the live spell/aura
    // ids are the data-layer expansion. The pure plan is the testable heart and is fully covered.
    class MasteryCombatMgr
    {
    public:
        static MasteryCombatMgr* instance();

        void LoadConfig();
        bool Enabled() const;

        // Build the §14.12 application plan for a player from the live Mgrs. v1 passes the player's own
        // active cells as the catalyst roster (the documented raid-roster seam); a later task feeds the
        // surrounding raid roster here. Returns an empty plan when disabled / no valid active cell.
        MasteryPlan BuildPlan(Player* player) const;

        // Aggregate OUTGOING-damage multiplier from the player's currently-active raid-wide + personal
        // mastery cells, in [1.0, MaxPersonalMul]. 1.0 when disabled or no cell is active. This is the
        // application point the UnitScript multiplies onto outgoing damage (composes with §2.1 scaling).
        double OutgoingMultiplierFor(Player* player) const;

    private:
        MasteryCombatMgr() = default;

        // Fills the per-school dual-key/level state POD from ProficiencyMgr (anti-P2W: knowledge gates).
        MasterySchoolState SchoolStateFor(ObjectGuid guid, uint32_t accountId) const;

        // Builds the catalyst roster (v1: the player's own active cells) into `out`, returns the count.
        static std::size_t OwnRoster(ActiveMasterySet const& set, CatalystKey* out, std::size_t cap);

        // Whether a windowed effect is in its active phase at server time `nowMs` (sustained cells are
        // always on and handled by the caller). Reconstructs the cadence from the resolved params.
        static bool IsCellWindowActive(ResolvedMasteryEffect const& eff, uint64_t nowMs);

        // The §7.9 caps (IEffectConfig) and catalyst DR decay (ICatalystConfig) the plan binds with;
        // the tree envelope + loadout dials come from MasteryLoadoutMgr's shared MasteryConfig.
        EffectConfig _effectConfig;
        CatalystConfig _catalystConfig;
    };
}

#define sMasteryCombatMgr Branding::MasteryCombatMgr::instance()

#endif // MOD_BRANDING_SRC_MASTERYCOMBATMGR_H

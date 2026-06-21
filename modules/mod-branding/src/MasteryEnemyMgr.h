#ifndef MOD_BRANDING_SRC_MASTERYENEMYMGR_H
#define MOD_BRANDING_SRC_MASTERYENEMYMGR_H

#include "MasteryConfig.h"
#include "branding/mastery/EnemyMastery.h"

class Creature;

namespace Branding
{
    // Adapter for §14.8 ENEMY-side mastery (issue #31). The enemy twin of MasteryCombatMgr: an invasion
    // ELITE/BOSS creature's OUTGOING damage is multiplied by the pure EnemyMasteryMultiplierForRank,
    // mirroring the §7.9 EffectMgr / §2.1 ScalingMgr outgoing-damage UnitScript. The multiplier rides
    // ON TOP of the already §2.2-scaled encounter baseline (scaling-then-branding, §2.1) -- the player
    // downscale scripts touch only player attackers, so this creature-attacker branch never sees the
    // pre-scaled value. The multiplier is a function of creature RANK only (group-size invariant), so it
    // never reaches down and breaks small-group completability (§2.2 / Risk #4).
    //
    // No raw Creature*/Unit* is stored past a call -- the rank, zone, and active-invasion gate all
    // resolve at call time; the manager owns no per-creature state.
    class MasteryEnemyMgr
    {
    public:
        static MasteryEnemyMgr* instance();

        void LoadConfig();
        bool Enabled() const { return _config.Enabled() && _enemyEnabled; }

        // OUTGOING-damage multiplier in [1.0, MaxEnemyMul] for an invasion elite/boss creature. Returns
        // 1.0 when disabled, the creature is not an elite/boss, or it is not inside an active invasion.
        double OutgoingMultiplierFor(Creature* attacker) const;

    private:
        MasteryEnemyMgr() = default;

        // Maps a creature's rank (isWorldBoss / isElite) to the pure EnemyRank. Normal otherwise.
        static EnemyRank RankOf(Creature const* creature);

        // The §14.8.1 gate: is this creature part of an active INVASION? v1 reuses the event system's
        // per-zone active-event check (EventMgr::ActiveEventType == Invasion). Documented seam: a future
        // per-creature invasion-roster tag can replace this without touching the pure core.
        static bool InActiveInvasion(Creature const* creature);

        MasteryConfig _config;       // shares the §14 tree tunables (MaxEnemyMul, EnemyEliteLevelFraction)
        bool _enemyEnabled = false;  // Branding.Mastery.EnemyEnable
    };
}

#define sMasteryEnemyMgr Branding::MasteryEnemyMgr::instance()

#endif // MOD_BRANDING_SRC_MASTERYENEMYMGR_H

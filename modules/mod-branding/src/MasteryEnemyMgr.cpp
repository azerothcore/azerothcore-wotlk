#include "MasteryEnemyMgr.h"
#include "EventMgr.h"
#include "branding/contribution/ContributionTypes.h"
#include "Configuration/Config.h"
#include "Creature.h"
#include "Log.h"
#include "StringFormat.h"

namespace Branding
{
    MasteryEnemyMgr* MasteryEnemyMgr::instance()
    {
        static MasteryEnemyMgr mgr;
        return &mgr;
    }

    void MasteryEnemyMgr::LoadConfig()
    {
        _config.Load();
        _enemyEnabled = sConfigMgr->GetOption<bool>("Branding.Mastery.EnemyEnable", false);
    }

    EnemyRank MasteryEnemyMgr::RankOf(Creature const* creature)
    {
        if (creature->isWorldBoss())
            return EnemyRank::Boss;

        if (creature->isElite())
            return EnemyRank::Elite;

        return EnemyRank::Normal;
    }

    bool MasteryEnemyMgr::InActiveInvasion(Creature const* creature)
    {
        // v1 seam: a creature counts as "invasion" when an Invasion event is active in its zone. A
        // later per-creature invasion-roster tag would slot in here without a core change.
        EventType type = EventType::Invasion;
        if (!sEventMgr->ActiveEventType(creature->GetZoneId(), type))
            return false;

        return type == EventType::Invasion;
    }

    double MasteryEnemyMgr::OutgoingMultiplierFor(Creature* attacker) const
    {
        if (!Enabled() || !attacker)
            return 1.0;

        EnemyRank const rank = RankOf(attacker);
        if (rank == EnemyRank::Normal)
            return 1.0;

        if (!InActiveInvasion(attacker))
            return 1.0;

        // Pure decision: rank -> bounded multiplier (<= MaxEnemyMul, group-size invariant). The math
        // (the §14.8 curve) is reused, never reimplemented here.
        double const mul = EnemyMasteryMultiplierForRank(rank, _config);

        LOG_DEBUG("module.branding", "MasteryEnemyMgr: enemy mastery x{:.3f} on {} (rank {})",
            mul, attacker->GetGUID().ToString(),
            rank == EnemyRank::Boss ? "boss" : "elite");

        return mul;
    }
}

#include "ScalingMgr.h"
#include "scaling/Scaling.h"
#include "DBCStores.h"
#include "Player.h"

namespace Branding
{
    ScalingMgr* ScalingMgr::instance()
    {
        static ScalingMgr mgr;
        return &mgr;
    }

    void ScalingMgr::LoadConfig()
    {
        _config.Load();
    }

    double ScalingMgr::PlayerOutgoingFactor(Player* attacker) const
    {
        if (!_config.Enabled() || !attacker)
            return 1.0;

        // v1 bracket source: the game's built-in area_level (zero extra data). TODO: evolve to a
        // configurable per-zone bracket table (mod-zone-difficulty `zone_difficulty_info` shape) so
        // brackets are admin-tunable and event phases can override them (§2.1 event-overrides-zone).
        AreaTableEntry const* area = sAreaTableStore.LookupEntry(attacker->GetAreaId());
        if (!area || area->area_level <= 0)
            return 1.0;

        // Downward only: ScalingFactor returns 1.0 when the player is at or below the zone bracket.
        return ScalingFactor(attacker->GetLevel(), static_cast<uint8_t>(area->area_level), _config);
    }
}

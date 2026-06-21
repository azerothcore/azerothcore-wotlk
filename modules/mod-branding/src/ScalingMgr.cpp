#include "ScalingMgr.h"
#include "branding/scaling/Scaling.h"
#include "DatabaseEnv.h"
#include "DBCStores.h"
#include "Log.h"
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

    void ScalingMgr::LoadZoneBrackets()
    {
        // Admin-tunable per-zone bracket table (§2.1), studied after mod-zone-difficulty's
        // `zone_difficulty_info` shape (downward stat-scaling bracket, not a nerf/debuff table).
        // Repopulates from scratch so `.reload config` picks up edits without a restart.
        _zoneBrackets.Clear();

        QueryResult result = WorldDatabase.Query(
            "SELECT `zone_id`, `target_level` FROM `branding_zone_bracket`");
        if (!result)
        {
            LOG_INFO("module.branding", "Branding: no `branding_zone_bracket` rows; using area_level fallback.");
            return;
        }

        do
        {
            Field* fields = result->Fetch();
            uint32 const zoneId = fields[0].Get<uint32>();
            uint32 const targetLevel = fields[1].Get<uint8>();
            _zoneBrackets.Set(zoneId, static_cast<uint8_t>(targetLevel));
        } while (result->NextRow());

        LOG_INFO("module.branding", "Branding: loaded {} zone bracket override(s).", _zoneBrackets.Size());
    }

    double ScalingMgr::PlayerOutgoingFactor(Player* attacker) const
    {
        if (!_config.Enabled() || !attacker)
            return 1.0;

        // Fallback bracket = the game's built-in area_level (v1, zero data). An admin row in
        // `branding_zone_bracket` for the player's zone overrides it (§2.1); event-phase overrides
        // are a future extension layered on top of this resolution.
        AreaTableEntry const* area = sAreaTableStore.LookupEntry(attacker->GetAreaId());
        uint8_t const fallback = (area && area->area_level > 0) ? static_cast<uint8_t>(area->area_level) : 0;

        uint8_t const targetLevel = _zoneBrackets.ResolveTargetLevel(attacker->GetZoneId(), fallback);
        if (targetLevel == 0)
            return 1.0;

        // Downward only: ScalingFactor returns 1.0 when the player is at or below the zone bracket.
        return ScalingFactor(attacker->GetLevel(), targetLevel, _config);
    }
}

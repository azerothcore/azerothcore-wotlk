#ifndef MOD_BRANDING_CORE_SCALING_ZONEBRACKET_H
#define MOD_BRANDING_CORE_SCALING_ZONEBRACKET_H

#include <cstddef>
#include <cstdint>
#include <unordered_map>

namespace Branding
{
    // Admin-tunable per-zone downscaling brackets (§2.1). Pure value type, no AzerothCore deps.
    //
    // The adapter loads the `branding_zone_bracket` table (zone_id -> target_level) into this map
    // once at startup/reload, then per-attack asks ResolveTargetLevel() for the bracket. A configured
    // zone overrides the built-in `AreaTableEntry::area_level`; an unconfigured zone falls back to it,
    // preserving v1 behaviour. (Studied after mod-zone-difficulty's `zone_difficulty_info` shape;
    // reimplemented as a downward-only stat-scaling bracket, not a nerf/debuff table.)
    class ZoneBracketTable
    {
    public:
        // Insert or overwrite the configured target level for a zone (last write wins).
        void Set(uint32_t zoneId, uint8_t targetLevel) { _brackets[zoneId] = targetLevel; }

        // True when an admin row exists for this zone.
        bool Has(uint32_t zoneId) const { return _brackets.find(zoneId) != _brackets.end(); }

        // Configured target level for the zone if a row exists, else the supplied fallback
        // (the zone's `area_level`). The caller treats a 0 result as "no defined bracket".
        uint8_t ResolveTargetLevel(uint32_t zoneId, uint8_t fallbackAreaLevel) const
        {
            auto it = _brackets.find(zoneId);
            return it != _brackets.end() ? it->second : fallbackAreaLevel;
        }

        // Drop all rows (reload safety).
        void Clear() { _brackets.clear(); }

        // Number of distinct configured zones.
        std::size_t Size() const { return _brackets.size(); }

    private:
        std::unordered_map<uint32_t, uint8_t> _brackets;
    };
}

#endif // MOD_BRANDING_CORE_SCALING_ZONEBRACKET_H

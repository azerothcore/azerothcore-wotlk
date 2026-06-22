#ifndef MOD_BRANDING_SRC_PRESTIGEMGR_H
#define MOD_BRANDING_SRC_PRESTIGEMGR_H

#include "branding/common/Brand.h"
#include <array>
#include <cstddef>
#include <cstdint>

class Player;

namespace Branding
{
    // §14.13.4 Prestige config: snapshots the cosmetic-title tunables from sConfigMgr at load time.
    // Per-school title id is config-mapped so a later custom CharTitles.dbc patch can swap in literal
    // "the Fire-Branded" strings with no code change. v1 default repurposes spare/unused 3.3.5a
    // CharTitlesEntry ids (server-only, no client DBC patch). All ids are PLACEHOLDERS (see conf).
    class PrestigeConfig
    {
    public:
        // (Re)reads all options from sConfigMgr. Call on startup and on config reload.
        void Load();

        bool Enabled() const { return _enabled; }

        // Configured CharTitlesEntry id for a school's graduation title (0 = unmapped/disabled).
        uint32_t TitleId(BrandId brand) const { return _titleId[static_cast<size_t>(brand)]; }

        // Configured CharTitlesEntry id for the all-schools-maxed capstone (0 = disabled).
        uint32_t CapstoneTitleId() const { return _capstoneTitleId; }

    private:
        bool _enabled = false;
        std::array<uint32_t, static_cast<size_t>(BrandId::COUNT)> _titleId{};
        uint32_t _capstoneTitleId = 0;
    };

    // Adapter manager for §14.13.4 graduation titles. Cosmetic ONLY -- grants no stat/effect.
    // Stores no Player*/Creature* past a call (project long-lived-reference rule); all work is done
    // synchronously inside CheckAndGrant against the live Player passed by a script hook.
    class PrestigeMgr
    {
    public:
        static PrestigeMgr* instance();

        void LoadConfig();
        PrestigeConfig const& Config() const { return _config; }

        // For each maxed brand grants its (idempotent) title; if ALL brands are maxed grants the
        // capstone. Safe to call frequently (idempotent -> frequency affects only latency).
        void CheckAndGrant(Player* player);

    private:
        PrestigeMgr() = default;

        PrestigeConfig _config;
    };
}

#define sPrestigeMgr Branding::PrestigeMgr::instance()

#endif // MOD_BRANDING_SRC_PRESTIGEMGR_H

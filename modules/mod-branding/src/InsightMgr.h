#ifndef MOD_BRANDING_SRC_INSIGHTMGR_H
#define MOD_BRANDING_SRC_INSIGHTMGR_H

#include "InsightConfig.h"
#include "ServerClock.h"
#include "branding/common/Brand.h"
#include "branding/insight/Insight.h"
#include <array>
#include <cstddef>
#include <unordered_map>

class Player;

namespace Branding
{
    // Adapter manager for the Insight Knowledge-unlock currency (design §14.13.1, issue #18). Owns a
    // per-account cache of fractional per-school points plus a SINGLE ACCOUNT-WIDE diminishing-returns
    // window (so the counter can't be farmed across alts or across schools). Persists to the
    // `account_insight` auth table. On reaching the unlock threshold it routes through the existing
    // Knowledge-unlock path (ProficiencyMgr::UnlockBrand) -- writing the permanent
    // `account_brand_knowledge` row and refreshing the proficiency mask. Keyed by account id; no raw
    // Player* is retained (project long-lived-reference rule).
    class InsightMgr
    {
    public:
        static InsightMgr* instance();

        void LoadConfig();
        InsightConfig const& Config() const { return _config; }
        bool Enabled() const { return _config.Enabled(); }

        // Loads an account's per-school Insight into the cache (idempotent; safe to call on login).
        void LoadAccount(uint32_t accountId);
        void UnloadAccount(uint32_t accountId);

        // Earns Insight for a kill of `rank`, branded to `school`, applying the ACCOUNT-WIDE DR
        // window. Persists the mutated row(s). If the school's total reaches the unlock threshold,
        // unlocks the permanent Knowledge row once (idempotent) and returns true via `outUnlocked`.
        // Returns the fractional Insight granted (0 if disabled). Loads the account on demand.
        double Earn(uint32_t accountId, BrandId school, SourceRank rank, bool* outUnlocked = nullptr);

        // Current cached fractional Insight toward unlock for a school (loads on demand).
        double Points(uint32_t accountId, BrandId school);

    private:
        InsightMgr() = default;

        // Per-account state: fractional points per school + one account-wide DR window.
        struct AccountInsight
        {
            std::array<double, static_cast<size_t>(BrandId::COUNT)> points{};
            uint32_t windowUnits = 0;
            uint64_t windowStartUnix = 0;
        };

        AccountInsight& Ensure(uint32_t accountId);
        void PersistSchool(uint32_t accountId, BrandId school, AccountInsight const& acc) const;

        InsightConfig _config;
        ServerClock _clock;
        std::unordered_map<uint32_t, AccountInsight> _accounts;
    };
}

#define sInsightMgr Branding::InsightMgr::instance()

#endif // MOD_BRANDING_SRC_INSIGHTMGR_H

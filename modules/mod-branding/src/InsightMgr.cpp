#include "InsightMgr.h"
#include "ProficiencyMgr.h"
#include "DatabaseEnv.h"
#include "Log.h"

namespace Branding
{
    InsightMgr* InsightMgr::instance()
    {
        static InsightMgr mgr;
        return &mgr;
    }

    void InsightMgr::LoadConfig()
    {
        _config.Load();
    }

    void InsightMgr::LoadAccount(uint32_t accountId)
    {
        if (!_config.Enabled())
            return;

        AccountInsight& acc = _accounts[accountId];
        acc = AccountInsight{};

        // NOTE: blocking query on the login path for simplicity (tiny, indexed lookup). TODO: move to
        // the async path (AsyncQuery + WithCallback) once running under a full build, per §7.7.
        QueryResult result = LoginDatabase.Query(
            "SELECT `school`, `points`, `window_start`, `window_units` FROM `account_insight` WHERE `account` = {}",
            accountId);
        if (!result)
            return;

        // The DR window is account-wide: every row carries the same window snapshot, so the last row
        // read wins (they are written together). Points are per-school.
        do
        {
            Field* fields = result->Fetch();
            uint8 const school = fields[0].Get<uint8>();
            if (school >= static_cast<uint8>(BrandId::COUNT))
                continue;

            acc.points[school] = fields[1].Get<double>();
            acc.windowStartUnix = fields[2].Get<uint32>();
            acc.windowUnits = fields[3].Get<uint32>();
        } while (result->NextRow());
    }

    void InsightMgr::UnloadAccount(uint32_t accountId)
    {
        _accounts.erase(accountId);
    }

    InsightMgr::AccountInsight& InsightMgr::Ensure(uint32_t accountId)
    {
        auto it = _accounts.find(accountId);
        if (it != _accounts.end())
            return it->second;

        LoadAccount(accountId);
        return _accounts[accountId];
    }

    void InsightMgr::PersistSchool(uint32_t accountId, BrandId school, AccountInsight const& acc) const
    {
        LoginDatabase.Execute(
            "REPLACE INTO `account_insight` (`account`, `school`, `points`, `window_start`, `window_units`) "
            "VALUES ({}, {}, {}, {}, {})",
            accountId, static_cast<uint32>(school), acc.points[static_cast<size_t>(school)],
            static_cast<uint32>(acc.windowStartUnix), acc.windowUnits);
    }

    double InsightMgr::Earn(uint32_t accountId, BrandId school, SourceRank rank, bool* outUnlocked)
    {
        if (outUnlocked)
            *outUnlocked = false;
        if (!_config.Enabled() || school >= BrandId::COUNT)
            return 0.0;

        AccountInsight& acc = Ensure(accountId);

        // Bridge the account-wide window + this school's points into the pure-core InsightState, run
        // the deterministic DR core, then write the mutated fields back. The window is shared across
        // schools (account-wide), so an alt or a school-swap can't dodge diminishing returns.
        InsightState state;
        state.points = acc.points[static_cast<size_t>(school)];
        state.windowUnits = acc.windowUnits;
        state.windowStartUnix = acc.windowStartUnix;

        double const granted = EarnInsight(state, rank, _config, _clock);

        acc.points[static_cast<size_t>(school)] = state.points;
        acc.windowUnits = state.windowUnits;
        acc.windowStartUnix = state.windowStartUnix;

        PersistSchool(accountId, school, acc);

        LOG_DEBUG("module.branding", "Insight earned: account {} school {} rank {} +{:.4f} (total {:.4f}).",
            accountId, static_cast<uint32>(school), static_cast<uint32>(rank), granted,
            acc.points[static_cast<size_t>(school)]);

        // Reaching the threshold spends nothing extra -- it routes through the existing Knowledge
        // unlock path (writes `account_brand_knowledge` once + refreshes the proficiency mask).
        // UnlockBrand is idempotent: a second threshold-crossing returns false and changes nothing.
        if (UnlockReached(acc.points[static_cast<size_t>(school)], _config))
        {
            if (sProficiencyMgr->UnlockBrand(accountId, school))
            {
                LOG_INFO("module.branding", "Insight threshold reached: account {} unlocked Knowledge for school {}.",
                    accountId, static_cast<uint32>(school));
                if (outUnlocked)
                    *outUnlocked = true;
            }
        }

        return granted;
    }

    double InsightMgr::Points(uint32_t accountId, BrandId school)
    {
        if (school >= BrandId::COUNT)
            return 0.0;

        return Ensure(accountId).points[static_cast<size_t>(school)];
    }
}

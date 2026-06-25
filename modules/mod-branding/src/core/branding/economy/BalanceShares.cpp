#include "BalanceShares.h"

namespace Branding
{
    void SourceTotals::Add(XpSource source, uint64_t amount)
    {
        xp[static_cast<size_t>(source)] += amount;
    }

    uint64_t SourceTotals::Get(XpSource source) const
    {
        return xp[static_cast<size_t>(source)];
    }

    uint64_t SourceTotals::Total() const
    {
        uint64_t total = 0;
        for (uint64_t const v : xp)
            total += v;
        return total;
    }

    double BalanceShares::Share(XpSource source) const
    {
        return share[static_cast<size_t>(source)];
    }

    XpSource BalanceShares::Largest() const
    {
        size_t best = 0;
        for (size_t i = 1; i < share.size(); ++i)
        {
            if (share[i] > share[best])
                best = i;
        }
        return static_cast<XpSource>(best);
    }

    BalanceShares ComputeShares(SourceTotals const& totals)
    {
        BalanceShares result;

        uint64_t const total = totals.Total();
        if (total == 0)
            return result; // all-zero shares; no division by zero

        for (size_t i = 0; i < result.share.size(); ++i)
            result.share[i] = static_cast<double>(totals.xp[i]) / static_cast<double>(total);

        return result;
    }
}

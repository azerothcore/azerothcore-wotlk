/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#ifndef OBSERVABILITY_H__
#define OBSERVABILITY_H__

#include "MetricTypes.h"
#include <cstddef>
#include <source_location>
#include <string>

#if defined(WITHOUT_OBSERVABILITY)

namespace Acore::Observability
{
    inline bool IsEnabled() { return false; }

    class Counter
    {
    public:
        Counter(StaticStringLiteral, StaticStringLiteral, std::vector<Label> = {},
            std::source_location = std::source_location::current()) { }

        void Increment(uint64 = 1) const { }
    };

    class Gauge
    {
    public:
        Gauge(StaticStringLiteral, StaticStringLiteral, std::vector<Label> = {},
            std::source_location = std::source_location::current()) { }

        void Set(double) const { }
        void Increment(double = 1.0) const { }
        void Decrement(double = 1.0) const { }
    };

    class Info
    {
    public:
        Info(StaticStringLiteral, StaticStringLiteral, std::vector<Label> = {},
            std::source_location = std::source_location::current()) { }
    };

    class Histogram;

    class [[nodiscard]] ScopedHistogramTimer
    {
    public:
        ScopedHistogramTimer() { }
        explicit ScopedHistogramTimer(Histogram const&) { }
        ScopedHistogramTimer(ScopedHistogramTimer const&) = delete;
        ScopedHistogramTimer& operator=(ScopedHistogramTimer const&) = delete;
        ScopedHistogramTimer(ScopedHistogramTimer&&) noexcept = default;
        ScopedHistogramTimer& operator=(ScopedHistogramTimer&&) noexcept = default;
    };

    class Histogram
    {
    public:
        Histogram(StaticStringLiteral, StaticStringLiteral, Buckets, std::vector<Label> = {},
            std::source_location = std::source_location::current()) { }

        void Observe(double) const { }
        [[nodiscard]] ScopedHistogramTimer Measure() const { return ScopedHistogramTimer(*this); }
    };

    class HistogramFamily
    {
    public:
        HistogramFamily(StaticStringLiteral, StaticStringLiteral, Buckets, std::size_t = 0,
            std::source_location = std::source_location::current()) { }

        [[nodiscard]] ScopedHistogramTimer MeasureIndexed(std::size_t, StaticStringLiteral, uint32) const { return {}; }
        [[nodiscard]] ScopedHistogramTimer MeasureIndexed(std::size_t, StaticStringLiteral, StaticStringLiteral) const { return {}; }
    };

    class GaugeFamily
    {
    public:
        GaugeFamily(StaticStringLiteral, StaticStringLiteral, std::size_t = 0,
            std::source_location = std::source_location::current()) { }

        void SetIndexed(std::size_t, StaticStringLiteral, uint32, double) const { }
        void SetIndexed(std::size_t, StaticStringLiteral, StaticStringLiteral, double) const { }
    };

    class ObservabilityMgr
    {
    public:
        static ObservabilityMgr* instance()
        {
            static ObservabilityMgr instance;
            return &instance;
        }

        void Initialize(std::string const&) { }
        void LoadFromConfigs() { }
        void Unload() { }
        bool IsEnabled() const { return false; }
    };
}

#define sObservability Acore::Observability::ObservabilityMgr::instance()

#else

#include "MetricRegistry.h"
#include "ObservabilityMgr.h"

#endif

#endif // OBSERVABILITY_H__

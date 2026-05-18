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

#ifndef OBSERVABILITY_METRIC_REGISTRY_H__
#define OBSERVABILITY_METRIC_REGISTRY_H__

#include "Define.h"
#include "MetricTypes.h"
#include <chrono>
#include <cstddef>
#include <functional>
#include <map>
#include <memory>
#include <mutex>
#include <source_location>
#include <string>
#include <vector>

namespace Acore::Observability
{
    namespace Detail
    {
        struct CounterSeries;
        struct GaugeSeries;
        struct HistogramSeries;
    }

    struct BucketBoundary
    {
        double Value;
        std::string LeLabel;

        bool operator==(BucketBoundary const&) const = default;
    };

    class ScopedHistogramTimer;
    class HistogramFamily;

    class AC_COMMON_API Counter
    {
    public:
        Counter(StaticStringLiteral name, StaticStringLiteral help, std::vector<Label> labels = {},
            std::source_location owner = std::source_location::current());

        void Increment(uint64 amount = 1) const;

    private:
        Detail::CounterSeries* _series;
    };

    class AC_COMMON_API Gauge
    {
    public:
        Gauge(StaticStringLiteral name, StaticStringLiteral help, std::vector<Label> labels = {},
            std::source_location owner = std::source_location::current());

        void Set(double value) const;
        void Increment(double amount = 1.0) const;
        void Decrement(double amount = 1.0) const;

    private:
        Detail::GaugeSeries* _series;
    };

    class AC_COMMON_API Info
    {
    public:
        Info(StaticStringLiteral name, StaticStringLiteral help, std::vector<Label> labels = {},
            std::source_location owner = std::source_location::current());

    private:
        Detail::GaugeSeries* _series;
    };

    class AC_COMMON_API Histogram
    {
    public:
        Histogram(StaticStringLiteral name, StaticStringLiteral help, Buckets buckets, std::vector<Label> labels = {},
            std::source_location owner = std::source_location::current());

        void Observe(double value) const;
        [[nodiscard]] ScopedHistogramTimer Measure() const;

    private:
        friend class ScopedHistogramTimer;

        Detail::HistogramSeries* _series;
    };

    class AC_COMMON_API ScopedHistogramTimer
    {
    public:
        ScopedHistogramTimer();
        explicit ScopedHistogramTimer(Histogram const& histogram);
        ScopedHistogramTimer(ScopedHistogramTimer const&) = delete;
        ScopedHistogramTimer& operator=(ScopedHistogramTimer const&) = delete;
        ScopedHistogramTimer(ScopedHistogramTimer&& other) noexcept;
        ScopedHistogramTimer& operator=(ScopedHistogramTimer&& other) noexcept;
        ~ScopedHistogramTimer();

    private:
        explicit ScopedHistogramTimer(Detail::HistogramSeries& series);

        friend class Histogram;
        friend class HistogramFamily;

        Detail::HistogramSeries* _series;
        std::chrono::steady_clock::time_point _start;
    };

    class AC_COMMON_API MetricRegistry
    {
    public:
        struct Entry;

        MetricRegistry();
        ~MetricRegistry();

        Detail::CounterSeries& RegisterCounter(StaticStringLiteral name, StaticStringLiteral help, std::vector<Label> labels, std::source_location owner);
        Detail::GaugeSeries& RegisterGauge(StaticStringLiteral name, StaticStringLiteral help, std::vector<Label> labels, std::source_location owner);
        Detail::GaugeSeries& RegisterInfo(StaticStringLiteral name, StaticStringLiteral help, std::vector<Label> labels, std::source_location owner);
        Detail::HistogramSeries& RegisterHistogram(StaticStringLiteral name, StaticStringLiteral help, Buckets buckets, std::vector<Label> labels, std::source_location owner);

        void SetConstantLabel(StaticStringLiteral name, std::string_view value);
        void VisitMetrics(MetricVisitor& visitor) const;

    private:
        friend class HistogramFamily;

        enum class EntryKind
        {
            Counter,
            Gauge,
            Info,
            Histogram
        };

        Entry& CreateEntry(StaticStringLiteral name, StaticStringLiteral help, EntryKind kind, std::source_location owner, std::size_t indexedSeriesCount = 0);
        Entry* FindExisting(StaticStringLiteral name);
        bool IsCompatibleEntry(Entry const& entry, StaticStringLiteral name, StaticStringLiteral help, EntryKind kind, std::source_location owner) const;
        Entry* RegisterHistogramFamily(StaticStringLiteral name, StaticStringLiteral help, Buckets buckets, std::source_location owner, std::size_t indexedSeriesCount);
        Detail::HistogramSeries* FindIndexedHistogramSeries(Entry const& entry, std::size_t index) const;
        Detail::HistogramSeries& RegisterIndexedHistogramSeries(Entry& entry, std::size_t index, std::vector<Label> labels);
        Detail::HistogramSeries& RegisterHistogramSeriesLocked(Entry& entry, std::vector<Label> labels);
        void LogIncompatibleRegistration(StaticStringLiteral name, std::source_location existingOwner, std::source_location duplicateOwner, std::string_view reason) const;
        static Detail::CounterSeries& IgnoredCounter();
        static Detail::GaugeSeries& IgnoredGauge();
        static Detail::HistogramSeries& IgnoredHistogram();

        // Guards registry structure and series registration. Metric values are updated through their own atomics.
        mutable std::mutex _registryMutex;
        std::map<std::string, std::unique_ptr<Entry>, std::less<>> _entries;
        std::vector<Label> _constantLabels;
    };

    class AC_COMMON_API HistogramFamily
    {
    public:
        HistogramFamily(StaticStringLiteral name, StaticStringLiteral help, Buckets buckets,
            std::size_t indexedSeriesCount = 0,
            std::source_location owner = std::source_location::current());

        [[nodiscard]] ScopedHistogramTimer MeasureIndexed(std::size_t index, StaticStringLiteral labelName, uint32 labelValue) const;
        [[nodiscard]] ScopedHistogramTimer MeasureIndexed(std::size_t index, StaticStringLiteral labelName, StaticStringLiteral labelValue) const;

    private:
        MetricRegistry::Entry* _entry;
    };
}

#endif // OBSERVABILITY_METRIC_REGISTRY_H__

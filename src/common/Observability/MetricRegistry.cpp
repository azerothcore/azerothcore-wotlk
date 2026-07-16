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

#include "MetricRegistry.h"
#include "Errors.h"
#include "Log.h"
#include "ObservabilityMgr.h"
#include <algorithm>
#include <atomic>
#include <format>
#include <ranges>
#include <utility>
#include <variant>

namespace Acore::Observability
{
    namespace
    {
        template<class... Ts>
        struct overloaded : Ts...
        {
            using Ts::operator()...;
        };

        std::string LabelKey(std::vector<Label> const& labels)
        {
            std::string key;
            for (Label const& label : labels)
            {
                key.append(label.Name);
                key.push_back('\0');
                key.append(label.Value);
                key.push_back('\0');
            }
            return key;
        }

        std::vector<BucketBoundary> MakeBucketBoundaries(Buckets buckets)
        {
            std::ranges::sort(buckets);
            auto uniqueBuckets = std::ranges::unique(buckets);
            buckets.erase(uniqueBuckets.begin(), uniqueBuckets.end());

            std::vector<BucketBoundary> boundaries;
            boundaries.reserve(buckets.size());

            for (double bucket : buckets)
                boundaries.push_back({ bucket, std::format("{}", bucket) });

            return boundaries;
        }

    }

    namespace Detail
    {
        struct CounterSeries
        {
            explicit CounterSeries(std::vector<Label> labels) : Labels(std::move(labels)) { }

            void VisitSample(MetricFamilyView family, std::vector<Label> const& constantLabels, MetricVisitor& visitor) const
            {
                visitor.VisitSample(family, { "", { std::span{ constantLabels }, std::span{ Labels }, {} }, double(Value.load(std::memory_order_relaxed)) });
            }

            std::vector<Label> Labels;
            std::atomic<uint64> Value{ 0 };
        };

        struct GaugeSeries
        {
            explicit GaugeSeries(std::vector<Label> labels) : Labels(std::move(labels)) { }

            void VisitSample(MetricFamilyView family, std::vector<Label> const& constantLabels, MetricVisitor& visitor) const
            {
                visitor.VisitSample(family, { "", { std::span{ constantLabels }, std::span{ Labels }, {} }, Value.load(std::memory_order_relaxed) });
            }

            std::vector<Label> Labels;
            std::atomic<double> Value{ 0.0 };
        };

        struct HistogramSeries
        {
            HistogramSeries(std::vector<BucketBoundary> const& buckets, std::vector<Label> labels)
                : Buckets(buckets), Labels(std::move(labels)), BucketCounts(Buckets.size())
            {
            }

            void VisitSamples(MetricFamilyView family, std::vector<Label> const& constantLabels, MetricVisitor& visitor) const
            {
                uint64 cumulativeCount = 0;

                for (std::size_t i = 0; i < Buckets.size(); ++i)
                {
                    cumulativeCount += BucketCounts[i].load(std::memory_order_acquire);
                    LabelView extraLabels[] = { { "le", Buckets[i].LeLabel } };
                    visitor.VisitSample(family, { "_bucket", { std::span{ constantLabels }, std::span{ Labels }, extraLabels }, double(cumulativeCount) });
                }

                uint64 count = Count.load(std::memory_order_relaxed);
                LabelView infLabel[] = { { "le", "+Inf" } };
                visitor.VisitSample(family, { "_bucket", { std::span{ constantLabels }, std::span{ Labels }, infLabel }, double(count) });
                visitor.VisitSample(family, { "_sum", { std::span{ constantLabels }, std::span{ Labels }, {} }, Sum.load(std::memory_order_relaxed) });
                visitor.VisitSample(family, { "_count", { std::span{ constantLabels }, std::span{ Labels }, {} }, double(count) });
            }

            std::vector<BucketBoundary> const& Buckets;
            std::vector<Label> Labels;
            std::vector<std::atomic<uint64>> BucketCounts;
            std::atomic<uint64> Count{ 0 };
            std::atomic<double> Sum{ 0.0 };
        };

    }

    namespace
    {
        void ObserveHistogramSeries(Detail::HistogramSeries& series, double value)
        {
            auto bucket = std::ranges::lower_bound(series.Buckets, value, {}, &BucketBoundary::Value);

            // Count before BucketCounts: ensures a concurrent scrape never observes cumulative finite buckets > _count.
            series.Count.fetch_add(1, std::memory_order_relaxed);
            series.Sum.fetch_add(value, std::memory_order_relaxed);

            if (bucket != series.Buckets.end())
            {
                std::size_t index = static_cast<std::size_t>(bucket - series.Buckets.begin());
                series.BucketCounts[index].fetch_add(1, std::memory_order_release);
            }
        }
    }

    using CounterEntry = std::map<std::string, Detail::CounterSeries, std::less<>>;
    using GaugeSeriesMap = std::map<std::string, Detail::GaugeSeries, std::less<>>;

    struct GaugeEntry
    {
        explicit GaugeEntry(std::size_t indexedCount = 0) : IndexedSeries(indexedCount) { }

        ~GaugeEntry()
        {
            for (auto& slot : IndexedSeries)
                delete slot.load(std::memory_order_relaxed);
        }

        GaugeSeriesMap Series;
        std::vector<std::atomic<Detail::GaugeSeries*>> IndexedSeries; // Owned by GaugeEntry
    };

    struct HistogramEntry
    {
        HistogramEntry(std::vector<BucketBoundary> buckets, std::size_t indexedCount = 0)
            : Buckets(std::move(buckets)), IndexedSeries(indexedCount)
        {
            ASSERT(!Buckets.empty(), "Observability histogram entries must define at least one bucket");
        }

        ~HistogramEntry()
        {
            for (auto& slot : IndexedSeries)
                delete slot.load(std::memory_order_relaxed);
        }

        std::vector<BucketBoundary> Buckets;
        std::map<std::string, Detail::HistogramSeries, std::less<>> Series;
        std::vector<std::atomic<Detail::HistogramSeries*>> IndexedSeries; // Owned by HistogramEntry
    };

    struct InfoEntry
    {
        GaugeSeriesMap Series;
    };

    // Keep this order aligned with MetricKind.
    using EntryData = std::variant<CounterEntry, GaugeEntry, HistogramEntry, InfoEntry>;

    struct MetricRegistry::Entry
    {
        Entry(StaticStringLiteral name, StaticStringLiteral help, std::source_location owner, MetricKind kind, std::size_t indexedSeriesCount = 0)
            : Name(name), Help(help), Owner(owner)
        {
            switch (kind)
            {
                case MetricKind::Counter:
                    break;
                case MetricKind::Gauge:
                    Data.emplace<GaugeEntry>(indexedSeriesCount);
                    break;
                case MetricKind::Histogram:
                    ASSERT(false, "Histogram entries must be constructed with bucket boundaries");
                    break;
                case MetricKind::Info:
                    Data.emplace<InfoEntry>();
                    break;
            }
        }

        Entry(StaticStringLiteral name, StaticStringLiteral help, std::source_location owner, std::vector<BucketBoundary> buckets, std::size_t indexedSeriesCount)
            : Name(name), Help(help), Owner(owner), Data(std::in_place_type<HistogramEntry>, std::move(buckets), indexedSeriesCount)
        {
        }

        StaticStringLiteral Name;
        StaticStringLiteral Help;
        std::source_location Owner;
        EntryData Data;
    };

    Counter::Counter(StaticStringLiteral name, StaticStringLiteral help, std::vector<Label> labels, std::source_location owner)
        : _series(&sObservability->Registry().RegisterCounter(name, help, std::move(labels), owner))
    {
    }

    void Counter::Increment(uint64 amount) const
    {
        if (!IsEnabled())
            return;

        _series->Value.fetch_add(amount, std::memory_order_relaxed);
    }

    Gauge::Gauge(StaticStringLiteral name, StaticStringLiteral help, std::vector<Label> labels, std::source_location owner)
        : _series(&sObservability->Registry().RegisterGauge(name, help, std::move(labels), owner))
    {
    }

    void Gauge::Set(double value) const
    {
        if (!IsEnabled())
            return;

        _series->Value.store(value, std::memory_order_relaxed);
    }

    void Gauge::Increment(double amount) const
    {
        if (!IsEnabled())
            return;

        _series->Value.fetch_add(amount, std::memory_order_relaxed);
    }

    void Gauge::Decrement(double amount) const
    {
        Increment(-amount);
    }

    Info::Info(StaticStringLiteral name, StaticStringLiteral help, std::vector<Label> labels, std::source_location owner)
        : _series(&sObservability->Registry().RegisterInfo(name, help, std::move(labels), owner))
    {
        _series->Value.store(1.0, std::memory_order_relaxed);
    }

    Histogram::Histogram(StaticStringLiteral name, StaticStringLiteral help, Buckets buckets, std::vector<Label> labels, std::source_location owner)
        : _series(&sObservability->Registry().RegisterHistogram(name, help, std::move(buckets), std::move(labels), owner))
    {
    }

    void Histogram::Observe(double value) const
    {
        if (!IsEnabled())
            return;

        ObserveHistogramSeries(*_series, value);
    }

    ScopedHistogramTimer Histogram::Measure() const
    {
        return ScopedHistogramTimer(*this);
    }

    ScopedHistogramTimer::ScopedHistogramTimer()
        : _series(nullptr), _start()
    {
    }

    ScopedHistogramTimer::ScopedHistogramTimer(Histogram const& histogram)
        : ScopedHistogramTimer(*histogram._series)
    {
    }

    ScopedHistogramTimer::ScopedHistogramTimer(Detail::HistogramSeries& series)
        : _series(IsEnabled() ? &series : nullptr),
          _start(_series ? std::chrono::steady_clock::now() : std::chrono::steady_clock::time_point())
    {
    }

    ScopedHistogramTimer::ScopedHistogramTimer(ScopedHistogramTimer&& other) noexcept
        : _series(std::exchange(other._series, nullptr)), _start(other._start)
    {
    }

    ScopedHistogramTimer& ScopedHistogramTimer::operator=(ScopedHistogramTimer&& other) noexcept
    {
        if (this == &other)
            return *this;

        if (_series)
        {
            std::chrono::duration<double> elapsed = std::chrono::steady_clock::now() - _start;
            ObserveHistogramSeries(*_series, elapsed.count());
        }

        _series = std::exchange(other._series, nullptr);
        _start = other._start;
        return *this;
    }

    ScopedHistogramTimer::~ScopedHistogramTimer()
    {
        if (!_series)
            return;

        std::chrono::duration<double> elapsed = std::chrono::steady_clock::now() - _start;
        ObserveHistogramSeries(*_series, elapsed.count());
    }

    MetricRegistry::MetricRegistry() = default;

    MetricRegistry::~MetricRegistry() = default;

    Detail::CounterSeries& MetricRegistry::RegisterCounter(StaticStringLiteral name, StaticStringLiteral help, std::vector<Label> labels, std::source_location owner)
    {
        std::lock_guard<std::mutex> lock(_registryMutex);
        Entry* existing = FindExisting(name);
        Entry& entry = existing ? *existing : CreateEntry(name, help, MetricKind::Counter, owner);

        if (!IsCompatibleEntry(entry, name, help, MetricKind::Counter, owner))
            return IgnoredCounter();

        auto& counter = std::get<CounterEntry>(entry.Data);
        auto it = counter.try_emplace(LabelKey(labels), std::move(labels)).first;
        return it->second;
    }

    Detail::GaugeSeries& MetricRegistry::RegisterGauge(StaticStringLiteral name, StaticStringLiteral help, std::vector<Label> labels, std::source_location owner)
    {
        std::lock_guard<std::mutex> lock(_registryMutex);
        Entry* existing = FindExisting(name);
        Entry& entry = existing ? *existing : CreateEntry(name, help, MetricKind::Gauge, owner);

        if (!IsCompatibleEntry(entry, name, help, MetricKind::Gauge, owner))
            return IgnoredGauge();

        auto& gauge = std::get<GaugeEntry>(entry.Data);
        auto it = gauge.Series.try_emplace(LabelKey(labels), std::move(labels)).first;
        return it->second;
    }

    Detail::GaugeSeries& MetricRegistry::RegisterInfo(StaticStringLiteral name, StaticStringLiteral help, std::vector<Label> labels, std::source_location owner)
    {
        std::lock_guard<std::mutex> lock(_registryMutex);
        Entry* existing = FindExisting(name);
        Entry& entry = existing ? *existing : CreateEntry(name, help, MetricKind::Info, owner);

        if (!IsCompatibleEntry(entry, name, help, MetricKind::Info, owner))
            return IgnoredGauge();

        auto& info = std::get<InfoEntry>(entry.Data);
        auto it = info.Series.try_emplace(LabelKey(labels), std::move(labels)).first;
        return it->second;
    }

    Detail::HistogramSeries& MetricRegistry::RegisterHistogram(StaticStringLiteral name, StaticStringLiteral help, Buckets buckets, std::vector<Label> labels, std::source_location owner)
    {
        std::vector<BucketBoundary> boundaries = MakeBucketBoundaries(std::move(buckets));
        ASSERT(!boundaries.empty(), "Observability histogram '{}' must define at least one bucket", name);

        std::lock_guard<std::mutex> lock(_registryMutex);
        Entry* existing = FindExisting(name);
        Entry& entry = existing ? *existing : CreateHistogramEntry(name, help, std::move(boundaries), owner);

        if (!IsCompatibleEntry(entry, name, help, MetricKind::Histogram, owner))
            return IgnoredHistogram();

        auto& histogram = std::get<HistogramEntry>(entry.Data);
        if (existing && histogram.Buckets != boundaries)
        {
            LogIncompatibleRegistration(name, entry.Owner, owner, "histogram buckets differ");
            ASSERT(false, "Incompatible observability metric registration for '{}': histogram buckets differ", name);
            return IgnoredHistogram();
        }

        return EmplaceHistogramSeries(entry, std::move(labels));
    }

    MetricRegistry::Entry* MetricRegistry::RegisterHistogramFamily(StaticStringLiteral name, StaticStringLiteral help, Buckets buckets, std::source_location owner, std::size_t indexedSeriesCount)
    {
        std::vector<BucketBoundary> boundaries = MakeBucketBoundaries(std::move(buckets));
        ASSERT(!boundaries.empty(), "Observability histogram family '{}' must define at least one bucket", name);

        std::lock_guard<std::mutex> lock(_registryMutex);
        Entry* existing = FindExisting(name);
        Entry& entry = existing ? *existing : CreateHistogramEntry(name, help, std::move(boundaries), owner, indexedSeriesCount);

        if (!IsCompatibleEntry(entry, name, help, MetricKind::Histogram, owner))
            return nullptr;

        auto& histogram = std::get<HistogramEntry>(entry.Data);
        if (existing && histogram.Buckets != boundaries)
        {
            LogIncompatibleRegistration(name, entry.Owner, owner, "histogram buckets differ");
            ASSERT(false, "Incompatible observability metric registration for '{}': histogram buckets differ", name);
            return nullptr;
        }

        if (histogram.IndexedSeries.size() != indexedSeriesCount)
        {
            LogIncompatibleRegistration(name, entry.Owner, owner, "indexed series cache size differs");
            ASSERT(false, "Incompatible observability metric registration for '{}': indexed series cache size differs", name);
            return nullptr;
        }

        return &entry;
    }

    Detail::HistogramSeries* MetricRegistry::FindIndexedHistogramSeries(Entry const& entry, std::size_t index) const
    {
        return std::get<HistogramEntry>(entry.Data).IndexedSeries[index].load(std::memory_order_acquire);
    }

    Detail::HistogramSeries& MetricRegistry::RegisterIndexedHistogramSeries(Entry& entry, std::size_t index, std::vector<Label> labels)
    {
        auto& histogram = std::get<HistogramEntry>(entry.Data);
        auto& slot = histogram.IndexedSeries[index];
        auto fresh = std::make_unique<Detail::HistogramSeries>(histogram.Buckets, std::move(labels));

        Detail::HistogramSeries* expected = nullptr;
        if (slot.compare_exchange_strong(expected, fresh.get(),
                std::memory_order_release, std::memory_order_acquire))
            return *fresh.release();

        // Lost the race
        return *expected;
    }

    Detail::HistogramSeries& MetricRegistry::EmplaceHistogramSeries(Entry& entry, std::vector<Label> labels)
    {
        auto& histogram = std::get<HistogramEntry>(entry.Data);
        auto it = histogram.Series.try_emplace(LabelKey(labels), histogram.Buckets, std::move(labels)).first;
        return it->second;
    }

    MetricRegistry::Entry* MetricRegistry::RegisterGaugeFamily(StaticStringLiteral name, StaticStringLiteral help, std::source_location owner, std::size_t indexedSeriesCount)
    {
        std::lock_guard<std::mutex> lock(_registryMutex);
        Entry* existing = FindExisting(name);
        Entry& entry = existing ? *existing : CreateEntry(name, help, MetricKind::Gauge, owner, indexedSeriesCount);

        if (!IsCompatibleEntry(entry, name, help, MetricKind::Gauge, owner))
            return nullptr;

        auto& gauge = std::get<GaugeEntry>(entry.Data);
        if (gauge.IndexedSeries.size() != indexedSeriesCount)
        {
            LogIncompatibleRegistration(name, entry.Owner, owner, "indexed series cache size differs");
            ASSERT(false, "Incompatible observability metric registration for '{}': indexed series cache size differs", name);
            return nullptr;
        }

        return &entry;
    }

    Detail::GaugeSeries* MetricRegistry::FindIndexedGaugeSeries(Entry const& entry, std::size_t index) const
    {
        return std::get<GaugeEntry>(entry.Data).IndexedSeries[index].load(std::memory_order_acquire);
    }

    Detail::GaugeSeries& MetricRegistry::RegisterIndexedGaugeSeries(Entry& entry, std::size_t index, std::vector<Label> labels)
    {
        auto& gauge = std::get<GaugeEntry>(entry.Data);
        auto& slot = gauge.IndexedSeries[index];
        auto fresh = std::make_unique<Detail::GaugeSeries>(std::move(labels));

        Detail::GaugeSeries* expected = nullptr;
        if (slot.compare_exchange_strong(expected, fresh.get(),
                std::memory_order_release, std::memory_order_acquire))
            return *fresh.release();

        // Lost the race
        return *expected;
    }

    void MetricRegistry::SetConstantLabel(StaticStringLiteral name, std::string_view value)
    {
        std::lock_guard<std::mutex> lock(_registryMutex);

        auto it = std::ranges::find(_constantLabels, name, &Label::Name);
        if (it != _constantLabels.end())
            it->Value.assign(value);
        else
            _constantLabels.push_back({ name, std::string(value) });
    }

    void MetricRegistry::VisitMetrics(MetricVisitor& visitor) const
    {
        std::lock_guard<std::mutex> lock(_registryMutex);

        for (auto const& entryPtr : _entries | std::views::values)
        {
            Entry const& entry = *entryPtr;

            MetricFamilyView family{ entry.Name, entry.Help, static_cast<MetricKind>(entry.Data.index()) };
            visitor.VisitFamily(family);

            std::visit(overloaded{
                [&](CounterEntry const& counters)
                {
                    for (auto const& counter : counters | std::views::values)
                        counter.VisitSample(family, _constantLabels, visitor);
                },
                [&](GaugeEntry const& gauges)
                {
                    for (auto const& gauge : gauges.Series | std::views::values)
                        gauge.VisitSample(family, _constantLabels, visitor);

                    for (auto const& slot : gauges.IndexedSeries)
                        if (auto* series = slot.load(std::memory_order_acquire))
                            series->VisitSample(family, _constantLabels, visitor);
                },
                [&](HistogramEntry const& histograms)
                {
                    for (auto const& histogram : histograms.Series | std::views::values)
                        histogram.VisitSamples(family, _constantLabels, visitor);

                    for (auto const& slot : histograms.IndexedSeries)
                        if (auto* series = slot.load(std::memory_order_acquire))
                            series->VisitSamples(family, _constantLabels, visitor);
                },
                [&](InfoEntry const& info)
                {
                    for (auto const& gauge : info.Series | std::views::values)
                        gauge.VisitSample(family, _constantLabels, visitor);
                }
            }, entry.Data);
        }
    }

    MetricRegistry::Entry& MetricRegistry::CreateEntry(StaticStringLiteral name, StaticStringLiteral help, MetricKind kind, std::source_location owner, std::size_t indexedSeriesCount)
    {
        auto it = _entries.emplace(name, std::make_unique<Entry>(name, help, owner, kind, indexedSeriesCount)).first;
        return *it->second;
    }

    MetricRegistry::Entry& MetricRegistry::CreateHistogramEntry(StaticStringLiteral name, StaticStringLiteral help, std::vector<BucketBoundary> buckets, std::source_location owner, std::size_t indexedSeriesCount)
    {
        auto it = _entries.emplace(name, std::make_unique<Entry>(name, help, owner, std::move(buckets), indexedSeriesCount)).first;
        return *it->second;
    }

    MetricRegistry::Entry* MetricRegistry::FindExisting(StaticStringLiteral name)
    {
        if (auto it = _entries.find(name); it != _entries.end())
            return it->second.get();

        return nullptr;
    }

    bool MetricRegistry::IsCompatibleEntry(Entry const& entry, StaticStringLiteral name, StaticStringLiteral help, MetricKind kind, std::source_location owner) const
    {
        if (static_cast<MetricKind>(entry.Data.index()) != kind)
        {
            LogIncompatibleRegistration(name, entry.Owner, owner, "metric kind differs");
            ASSERT(false, "Incompatible observability metric registration for '{}': metric kind differs", name);
            return false;
        }

        if (entry.Help != help)
        {
            LogIncompatibleRegistration(name, entry.Owner, owner, "help text differs");
            ASSERT(false, "Incompatible observability metric registration for '{}': help text differs", name);
            return false;
        }

        return true;
    }

    void MetricRegistry::LogIncompatibleRegistration(StaticStringLiteral name, std::source_location existingOwner, std::source_location duplicateOwner, std::string_view reason) const
    {
        LOG_ERROR("observability", "Incompatible observability metric '{}' ignored: {}. Existing owner: {}:{} ({}). Duplicate owner: {}:{} ({}).",
            name, reason, existingOwner.file_name(), existingOwner.line(), existingOwner.function_name(), duplicateOwner.file_name(), duplicateOwner.line(), duplicateOwner.function_name());
    }

    HistogramFamily::HistogramFamily(StaticStringLiteral name, StaticStringLiteral help, Buckets buckets, std::size_t indexedSeriesCount, std::source_location owner)
        : _entry(sObservability->Registry().RegisterHistogramFamily(name, help, std::move(buckets), owner, indexedSeriesCount))
    {
    }

    ScopedHistogramTimer HistogramFamily::MeasureIndexed(std::size_t index, StaticStringLiteral labelName, uint32 labelValue) const
    {
        if (!_entry || !IsEnabled())
            return {};

        MetricRegistry& registry = sObservability->Registry();
        if (Detail::HistogramSeries* series = registry.FindIndexedHistogramSeries(*_entry, index)) [[likely]]
            return ScopedHistogramTimer(*series);

        Detail::HistogramSeries& series = registry.RegisterIndexedHistogramSeries(*_entry, index, { { labelName, std::format("{}", labelValue) } });
        return ScopedHistogramTimer(series);
    }

    ScopedHistogramTimer HistogramFamily::MeasureIndexed(std::size_t index, StaticStringLiteral labelName, StaticStringLiteral labelValue) const
    {
        if (!_entry || !IsEnabled())
            return {};

        MetricRegistry& registry = sObservability->Registry();
        if (Detail::HistogramSeries* series = registry.FindIndexedHistogramSeries(*_entry, index)) [[likely]]
            return ScopedHistogramTimer(*series);

        Detail::HistogramSeries& series = registry.RegisterIndexedHistogramSeries(*_entry, index, { { labelName, std::string(labelValue) } });
        return ScopedHistogramTimer(series);
    }

    GaugeFamily::GaugeFamily(StaticStringLiteral name, StaticStringLiteral help, std::size_t indexedSeriesCount, std::source_location owner)
        : _entry(sObservability->Registry().RegisterGaugeFamily(name, help, owner, indexedSeriesCount))
    {
    }

    void GaugeFamily::SetIndexed(std::size_t index, StaticStringLiteral labelName, uint32 labelValue, double value) const
    {
        if (!_entry || !IsEnabled())
            return;

        MetricRegistry& registry = sObservability->Registry();
        Detail::GaugeSeries* series = registry.FindIndexedGaugeSeries(*_entry, index);
        if (!series) [[unlikely]]
            series = &registry.RegisterIndexedGaugeSeries(*_entry, index, { { labelName, std::format("{}", labelValue) } });

        series->Value.store(value, std::memory_order_relaxed);
    }

    void GaugeFamily::SetIndexed(std::size_t index, StaticStringLiteral labelName, StaticStringLiteral labelValue, double value) const
    {
        if (!_entry || !IsEnabled())
            return;

        MetricRegistry& registry = sObservability->Registry();
        Detail::GaugeSeries* series = registry.FindIndexedGaugeSeries(*_entry, index);
        if (!series) [[unlikely]]
            series = &registry.RegisterIndexedGaugeSeries(*_entry, index, { { labelName, std::string(labelValue) } });

        series->Value.store(value, std::memory_order_relaxed);
    }

    Detail::CounterSeries& MetricRegistry::IgnoredCounter()
    {
        static Detail::CounterSeries counter({});
        return counter;
    }

    Detail::GaugeSeries& MetricRegistry::IgnoredGauge()
    {
        static Detail::GaugeSeries gauge({});
        return gauge;
    }

    Detail::HistogramSeries& MetricRegistry::IgnoredHistogram()
    {
        static std::vector<BucketBoundary> buckets;
        static Detail::HistogramSeries histogram(buckets, {});
        return histogram;
    }
}

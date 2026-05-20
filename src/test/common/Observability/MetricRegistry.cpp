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
#include "gmock/gmock.h"
#include "gtest/gtest.h"

#include <source_location>
#include <string>
#include <utility>
#include <vector>

using namespace Acore::Observability;

namespace
{
    using SampleLabels = std::vector<std::pair<std::string, std::string>>;

    struct RecordingVisitor : MetricVisitor
    {
        struct Family
        {
            std::string Name;
            std::string Help;
            MetricKind Kind;

            bool operator==(Family const&) const = default;
        };

        struct Sample
        {
            std::string Name;
            std::string Suffix;
            SampleLabels Labels;
            double Value;

            bool operator==(Sample const&) const = default;
        };

        std::vector<Family> Families;
        std::vector<Sample> Samples;

        void VisitFamily(MetricFamilyView family) override
        {
            Families.push_back({ std::string(family.Name), std::string(family.Help), family.Kind });
        }

        void VisitSample(MetricFamilyView family, MetricSampleView sample) override
        {
            Sample s{ std::string(family.Name), std::string(sample.Suffix), {}, sample.Value };
            sample.Labels.Visit([&](LabelView l)
            {
                s.Labels.emplace_back(std::string(l.Name), std::string(l.Value));
            });
            Samples.push_back(std::move(s));
        }
    };
}

TEST(MetricRegistryTest, SameNameAndLabelsCoalescesIntoSingleSeries)
{
    MetricRegistry registry;
    auto loc = std::source_location::current();

    registry.RegisterCounter("ac_world_packets_total", "Total world packets",
        { { "opcode", "CMSG_PING" } }, loc);
    registry.RegisterCounter("ac_world_packets_total", "Total world packets",
        { { "opcode", "CMSG_PING" } }, loc);

    RecordingVisitor visitor;
    registry.VisitMetrics(visitor);

    EXPECT_THAT(visitor.Families, testing::ElementsAre(
        RecordingVisitor::Family{ "ac_world_packets_total", "Total world packets", MetricKind::Counter }));
    EXPECT_THAT(visitor.Samples, testing::ElementsAre(
        RecordingVisitor::Sample{ "ac_world_packets_total", "", SampleLabels{ { "opcode", "CMSG_PING" } }, 0.0 }));
}

TEST(MetricRegistryTest, DistinctLabelsProduceDistinctSeries)
{
    MetricRegistry registry;
    auto loc = std::source_location::current();

    registry.RegisterCounter("ac_database_queue_size", "Current database async queue size",
        { { "database", "login" } }, loc);
    registry.RegisterCounter("ac_database_queue_size", "Current database async queue size",
        { { "database", "world" } }, loc);

    RecordingVisitor visitor;
    registry.VisitMetrics(visitor);

    EXPECT_THAT(visitor.Families, testing::ElementsAre(
        RecordingVisitor::Family{ "ac_database_queue_size", "Current database async queue size", MetricKind::Counter }));
    EXPECT_THAT(visitor.Samples, testing::ElementsAre(
        RecordingVisitor::Sample{ "ac_database_queue_size", "", SampleLabels{ { "database", "login" } }, 0.0 },
        RecordingVisitor::Sample{ "ac_database_queue_size", "", SampleLabels{ { "database", "world" } }, 0.0 }));
}

TEST(MetricRegistryTest, HistogramBucketsSortedAndDeduplicated)
{
    MetricRegistry registry;
    registry.RegisterHistogram("ac_world_update_duration_seconds", "Duration of one world update tick",
        { 1.0, 0.1, 1.0, 0.5 }, {},
        std::source_location::current());

    RecordingVisitor visitor;
    registry.VisitMetrics(visitor);

    EXPECT_THAT(visitor.Samples, testing::ElementsAre(
        RecordingVisitor::Sample{ "ac_world_update_duration_seconds", "_bucket", SampleLabels{ { "le", "0.1" } }, 0.0 },
        RecordingVisitor::Sample{ "ac_world_update_duration_seconds", "_bucket", SampleLabels{ { "le", "0.5" } }, 0.0 },
        RecordingVisitor::Sample{ "ac_world_update_duration_seconds", "_bucket", SampleLabels{ { "le", "1" } }, 0.0 },
        RecordingVisitor::Sample{ "ac_world_update_duration_seconds", "_bucket", SampleLabels{ { "le", "+Inf" } }, 0.0 },
        RecordingVisitor::Sample{ "ac_world_update_duration_seconds", "_sum", SampleLabels{}, 0.0 },
        RecordingVisitor::Sample{ "ac_world_update_duration_seconds", "_count", SampleLabels{}, 0.0 }));
}

TEST(MetricRegistryTest, ConstantLabelAppearsOnCounterGaugeAndHistogramSeries)
{
    MetricRegistry registry;
    auto loc = std::source_location::current();

    registry.SetConstantLabel("realm", "test");
    registry.RegisterCounter("ac_world_packets_total", "Total world packets", {}, loc);
    registry.RegisterGauge("ac_world_online_players", "Current online players", {}, loc);
    registry.RegisterHistogram("ac_world_update_duration_seconds", "Duration of one world update tick",
        { 0.1 }, {}, loc);

    RecordingVisitor visitor;
    registry.VisitMetrics(visitor);

    EXPECT_THAT(visitor.Samples, testing::ElementsAre(
        RecordingVisitor::Sample{ "ac_world_online_players", "", SampleLabels{ { "realm", "test" } }, 0.0 },
        RecordingVisitor::Sample{ "ac_world_packets_total", "", SampleLabels{ { "realm", "test" } }, 0.0 },
        RecordingVisitor::Sample{ "ac_world_update_duration_seconds", "_bucket", SampleLabels{ { "realm", "test" }, { "le", "0.1" } }, 0.0 },
        RecordingVisitor::Sample{ "ac_world_update_duration_seconds", "_bucket", SampleLabels{ { "realm", "test" }, { "le", "+Inf" } }, 0.0 },
        RecordingVisitor::Sample{ "ac_world_update_duration_seconds", "_sum", SampleLabels{ { "realm", "test" } }, 0.0 },
        RecordingVisitor::Sample{ "ac_world_update_duration_seconds", "_count", SampleLabels{ { "realm", "test" } }, 0.0 }));
}

TEST(MetricRegistryTest, SetConstantLabelOverwritesValue)
{
    MetricRegistry registry;

    registry.SetConstantLabel("realm", "old_realm");
    registry.SetConstantLabel("realm", "new_realm");
    registry.RegisterCounter("ac_world_packets_total", "Total world packets", {},
        std::source_location::current());

    RecordingVisitor visitor;
    registry.VisitMetrics(visitor);

    EXPECT_THAT(visitor.Samples, testing::ElementsAre(
        RecordingVisitor::Sample{ "ac_world_packets_total", "", SampleLabels{ { "realm", "new_realm" } }, 0.0 }));
}

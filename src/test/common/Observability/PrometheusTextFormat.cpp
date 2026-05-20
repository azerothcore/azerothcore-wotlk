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

#include "PrometheusTextFormat.h"
#include "MetricRegistry.h"
#include "gmock/gmock.h"
#include "gtest/gtest.h"

#include <source_location>

using namespace Acore::Observability;

TEST(PrometheusTextFormatTest, EmptyRegistryProducesEmptyOutput)
{
    MetricRegistry registry;
    EXPECT_THAT(PrometheusTextFormat::Serialize(registry), testing::IsEmpty());
}

TEST(PrometheusTextFormatTest, CounterNoLabels)
{
    MetricRegistry registry;
    registry.RegisterCounter("requests_total", "Total requests served", {},
        std::source_location::current());

    EXPECT_THAT(PrometheusTextFormat::Serialize(registry), testing::Eq(
        "# HELP requests_total Total requests served\n"
        "# TYPE requests_total counter\n"
        "requests_total 0\n"));
}

TEST(PrometheusTextFormatTest, GaugeWithSeriesLabel)
{
    MetricRegistry registry;
    registry.RegisterGauge("queue_depth", "Current queue depth",
        { { "queue", "ingest" } }, std::source_location::current());

    EXPECT_THAT(PrometheusTextFormat::Serialize(registry), testing::Eq(
        "# HELP queue_depth Current queue depth\n"
        "# TYPE queue_depth gauge\n"
        "queue_depth{queue=\"ingest\"} 0\n"));
}

TEST(PrometheusTextFormatTest, HistogramEmitsCumulativeBucketsAndSumCount)
{
    MetricRegistry registry;
    registry.RegisterHistogram("op_seconds", "Operation duration",
        { 0.1, 1.0 }, {}, std::source_location::current());

    EXPECT_THAT(PrometheusTextFormat::Serialize(registry), testing::Eq(
        "# HELP op_seconds Operation duration\n"
        "# TYPE op_seconds histogram\n"
        "op_seconds_bucket{le=\"0.1\"} 0\n"
        "op_seconds_bucket{le=\"1\"} 0\n"
        "op_seconds_bucket{le=\"+Inf\"} 0\n"
        "op_seconds_sum 0\n"
        "op_seconds_count 0\n"));
}

TEST(PrometheusTextFormatTest, HistogramEmitsSeriesLabelsOnBucketsSumAndCount)
{
    MetricRegistry registry;
    registry.RegisterHistogram("op_seconds", "Operation duration",
        { 0.1 }, { { "phase", "update_maps" } }, std::source_location::current());

    EXPECT_THAT(PrometheusTextFormat::Serialize(registry), testing::Eq(
        "# HELP op_seconds Operation duration\n"
        "# TYPE op_seconds histogram\n"
        "op_seconds_bucket{phase=\"update_maps\",le=\"0.1\"} 0\n"
        "op_seconds_bucket{phase=\"update_maps\",le=\"+Inf\"} 0\n"
        "op_seconds_sum{phase=\"update_maps\"} 0\n"
        "op_seconds_count{phase=\"update_maps\"} 0\n"));
}

TEST(PrometheusTextFormatTest, EscapesBackslashQuoteAndNewline)
{
    MetricRegistry registry;
    registry.RegisterGauge("g", "Quirky labels",
        { { "k", "a\\b\"c\nd" } }, std::source_location::current());

    EXPECT_THAT(PrometheusTextFormat::Serialize(registry), testing::Eq(
        "# HELP g Quirky labels\n"
        "# TYPE g gauge\n"
        "g{k=\"a\\\\b\\\"c\\nd\"} 0\n"));
}

TEST(PrometheusTextFormatTest, ConstantLabelsPrecedeSeriesLabels)
{
    MetricRegistry registry;
    registry.SetConstantLabel("realm", "test");
    registry.RegisterCounter("c", "Count", { { "kind", "x" } },
        std::source_location::current());

    EXPECT_THAT(PrometheusTextFormat::Serialize(registry), testing::Eq(
        "# HELP c Count\n"
        "# TYPE c counter\n"
        "c{realm=\"test\",kind=\"x\"} 0\n"));
}

TEST(PrometheusTextFormatTest, OmitsHelpLineWhenHelpEmpty)
{
    MetricRegistry registry;
    registry.RegisterCounter("c", "", {}, std::source_location::current());

    EXPECT_THAT(PrometheusTextFormat::Serialize(registry), testing::Eq(
        "# TYPE c counter\n"
        "c 0\n"));
}

TEST(PrometheusTextFormatTest, FamiliesEmittedInNameOrder)
{
    MetricRegistry registry;
    auto loc = std::source_location::current();
    registry.RegisterCounter("zeta", "Z", {}, loc);
    registry.RegisterCounter("alpha", "A", {}, loc);

    EXPECT_THAT(PrometheusTextFormat::Serialize(registry), testing::Eq(
        "# HELP alpha A\n"
        "# TYPE alpha counter\n"
        "alpha 0\n"
        "# HELP zeta Z\n"
        "# TYPE zeta counter\n"
        "zeta 0\n"));
}

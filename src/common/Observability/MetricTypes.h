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

#ifndef OBSERVABILITY_METRIC_TYPES_H__
#define OBSERVABILITY_METRIC_TYPES_H__

#include "Define.h"
#include <span>
#include <string>
#include <string_view>
#include <vector>

namespace Acore::Observability
{
    using StaticStringLiteral = char const*; // TODO: consteval enforce; TODO_CPP26: std::define_static_string

    enum class MetricKind
    {
        Counter,
        Gauge,
        Histogram,
        Info
    };

    struct Label
    {
        StaticStringLiteral Name;
        std::string Value;
    };

    using Buckets = std::vector<double>;

    inline Buckets DefaultDurationBuckets()
    {
        return { 0.0001, 0.00025, 0.0005, 0.001, 0.0025, 0.005, 0.01, 0.025, 0.05, 0.1, 0.25, 0.5, 1.0, 2.5 };
    }

    struct LabelView
    {
        std::string_view Name;
        std::string_view Value;
    };

    struct LabelSetView
    {
        std::span<Label const> ConstantLabels;
        std::span<Label const> SeriesLabels;
        std::span<LabelView const> ExtraLabels;

        template<typename Visitor>
        void Visit(Visitor&& visitor) const
        {
            for (Label const& label : ConstantLabels)
                visitor(LabelView{ label.Name, label.Value });

            for (Label const& label : SeriesLabels)
                visitor(LabelView{ label.Name, label.Value });

            for (LabelView label : ExtraLabels)
                visitor(label);
        }
    };

    struct MetricFamilyView
    {
        StaticStringLiteral Name;
        StaticStringLiteral Help;
        MetricKind Kind;
    };

    struct MetricSampleView
    {
        StaticStringLiteral Suffix;
        LabelSetView Labels;
        double Value;
    };

    class MetricVisitor
    {
    public:
        virtual ~MetricVisitor() = default;

        virtual void VisitFamily(MetricFamilyView family) = 0;
        virtual void VisitSample(MetricFamilyView family, MetricSampleView sample) = 0;
    };
}

#endif // OBSERVABILITY_METRIC_TYPES_H__

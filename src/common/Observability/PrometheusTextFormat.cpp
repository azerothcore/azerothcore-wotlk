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
#include <format>
#include <iterator>
#include <string>

namespace Acore::Observability
{
    namespace
    {
        std::string_view TypeName(MetricKind kind)
        {
            switch (kind)
            {
                case MetricKind::Counter:
                    return "counter";
                case MetricKind::Gauge:
                case MetricKind::Info:
                    return "gauge";
                case MetricKind::Histogram:
                    return "histogram";
            }

            return "untyped";
        }

        void WriteEscapedLabelValue(std::string& out, std::string_view value)
        {
            for (char c : value)
            {
                switch (c)
                {
                    case '\\':
                        out.append("\\\\");
                        break;
                    case '"':
                        out.append("\\\"");
                        break;
                    case '\n':
                        out.append("\\n");
                        break;
                    default:
                        out.push_back(c);
                        break;
                }
            }
        }

        void WriteLabels(std::string& out, LabelSetView labels)
        {
            bool first = true;

            labels.Visit([&](LabelView label)
            {
                out.push_back(first ? '{' : ',');
                first = false;
                std::format_to(std::back_inserter(out), "{}=\"", label.Name);
                WriteEscapedLabelValue(out, label.Value);
                out.push_back('"');
            });

            if (!first)
                out.push_back('}');
        }

        class PrometheusWriter : public MetricVisitor
        {
        public:
            explicit PrometheusWriter(std::string& out) : _out(out) { }

            void VisitFamily(MetricFamilyView family) override
            {
                if (!family.Help.empty())
                    std::format_to(std::back_inserter(_out), "# HELP {} {}\n", family.Name, family.Help);

                std::format_to(std::back_inserter(_out), "# TYPE {} {}\n", family.Name, TypeName(family.Kind));
            }

            void VisitSample(MetricFamilyView family, MetricSampleView sample) override
            {
                std::format_to(std::back_inserter(_out), "{}{}", family.Name, sample.Suffix);
                WriteLabels(_out, sample.Labels);
                std::format_to(std::back_inserter(_out), " {}\n", sample.Value);
            }

        private:
            std::string& _out;
        };
    }

    std::string PrometheusTextFormat::Serialize(MetricRegistry const& registry)
    {
        std::string out;
        PrometheusWriter writer(out);
        registry.VisitMetrics(writer);
        return out;
    }
}

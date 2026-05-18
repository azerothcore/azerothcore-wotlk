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
#include <sstream>

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

        void WriteEscapedLabelValue(std::ostringstream& out, std::string_view value)
        {
            for (char c : value)
            {
                switch (c)
                {
                    case '\\':
                        out << "\\\\";
                        break;
                    case '"':
                        out << "\\\"";
                        break;
                    case '\n':
                        out << "\\n";
                        break;
                    default:
                        out << c;
                        break;
                }
            }
        }

        void WriteLabels(std::ostringstream& out, LabelSetView labels)
        {
            bool first = true;

            labels.Visit([&](LabelView label)
            {
                if (first)
                    out << '{';
                else
                    out << ',';

                first = false;
                out << label.Name << "=\"";
                WriteEscapedLabelValue(out, label.Value);
                out << '"';
            });

            if (!first)
                out << '}';
        }

        class PrometheusWriter : public MetricVisitor
        {
        public:
            explicit PrometheusWriter(std::ostringstream& out) : _out(out) { }

            void VisitFamily(MetricFamilyView family) override
            {
                if (!family.Help.empty())
                    _out << "# HELP " << family.Name << ' ' << family.Help << '\n';

                _out << "# TYPE " << family.Name << ' ' << TypeName(family.Kind) << '\n';
            }

            void VisitSample(MetricFamilyView family, MetricSampleView sample) override
            {
                _out << family.Name << sample.Suffix;
                WriteLabels(_out, sample.Labels);
                _out << ' ' << sample.Value << '\n';
            }

        private:
            std::ostringstream& _out;
        };
    }

    std::string PrometheusTextFormat::Serialize(MetricRegistry const& registry)
    {
        std::ostringstream out;
        PrometheusWriter writer(out);
        registry.VisitMetrics(writer);
        return out.str();
    }
}

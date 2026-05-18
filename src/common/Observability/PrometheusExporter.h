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

#ifndef OBSERVABILITY_PROMETHEUS_EXPORTER_H__
#define OBSERVABILITY_PROMETHEUS_EXPORTER_H__

#include "Define.h"
#include <memory>
#include <string>

namespace Acore::Asio
{
    class IoContext;
}

namespace Acore::Observability
{
    class MetricRegistry;

    struct PrometheusEndpointConfig
    {
        bool Enabled = true;
        std::string BindAddress = "127.0.0.1";
        uint16 Port = 9200;

        bool operator==(PrometheusEndpointConfig const&) const = default;
    };

    class PrometheusExporter
    {
    public:
        PrometheusExporter(Acore::Asio::IoContext& ioContext, MetricRegistry& registry);
        ~PrometheusExporter();

        void ApplyConfig(PrometheusEndpointConfig config);
        void Stop();
        bool IsRunning() const;

        std::string RenderMetrics() const;

    private:
        class Impl;
        std::shared_ptr<Impl> _impl;
    };
}

#endif // OBSERVABILITY_PROMETHEUS_EXPORTER_H__

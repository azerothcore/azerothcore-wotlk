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

#include "ObservabilityMgr.h"
#include "Config.h"
#include "Log.h"
#include "PrometheusExporter.h"
#include <atomic>
#include <utility>

namespace Acore::Observability
{
    namespace
    {
        std::atomic<bool> RuntimeEnabled{ false };

        PrometheusEndpointConfig LoadPrometheusEndpointConfig(bool observabilityEnabled)
        {
            PrometheusEndpointConfig config;
            config.Enabled = observabilityEnabled && sConfigMgr->GetOption<bool>("Observability.Prometheus.Enable", true);
            config.BindAddress = sConfigMgr->GetOption<std::string>("Observability.Prometheus.IP", "127.0.0.1");

            if (config.BindAddress.empty())
            {
                LOG_ERROR("observability", "Observability.Prometheus.IP is empty, using 127.0.0.1.");
                config.BindAddress = "127.0.0.1";
            }

            int32 port = sConfigMgr->GetOption<int32>("Observability.Prometheus.Port", 9200);
            if (port < 1 || port > 65535)
            {
                LOG_ERROR("observability", "Observability.Prometheus.Port must be between 1 and 65535, using 9200.");
                port = 9200;
            }

            config.Port = uint16(port);
            return config;
        }
    }

    bool IsEnabled()
    {
        return RuntimeEnabled.load(std::memory_order_relaxed);
    }

    ObservabilityMgr::~ObservabilityMgr() = default;

    ObservabilityMgr* ObservabilityMgr::instance()
    {
        static ObservabilityMgr instance;
        return &instance;
    }

    void ObservabilityMgr::Initialize(std::string const& realmName)
    {
        _realmName = realmName;
        _registry.SetConstantLabel("realm", _realmName);
        _prometheusExporter = std::make_unique<PrometheusExporter>(_registry);
        LoadFromConfigs();
    }

    void ObservabilityMgr::LoadFromConfigs()
    {
        _enabled = sConfigMgr->GetOption<bool>("Observability.Enable", true);
        RuntimeEnabled.store(_enabled, std::memory_order_relaxed);

        if (!_enabled)
        {
            if (_prometheusExporter)
                _prometheusExporter->Stop();

            return;
        }

        if (!_prometheusExporter)
        {
            LOG_ERROR("observability", "Cannot apply observability config before observability is initialized.");
            return;
        }

        _prometheusExporter->ApplyConfig(LoadPrometheusEndpointConfig(_enabled));
    }

    void ObservabilityMgr::Unload()
    {
        if (_prometheusExporter)
            _prometheusExporter->Stop();

        _prometheusExporter.reset();
        _realmName.clear();
        _enabled = false;
        RuntimeEnabled.store(false, std::memory_order_relaxed);
    }
}

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

#ifndef OBSERVABILITY_MGR_H__
#define OBSERVABILITY_MGR_H__

#include "Define.h"
#include "MetricRegistry.h"
#include <memory>
#include <string>

namespace Acore::Observability
{
    class PrometheusExporter;

    AC_COMMON_API bool IsEnabled();

    class AC_COMMON_API ObservabilityMgr
    {
    public:
        ~ObservabilityMgr();

        static ObservabilityMgr* instance();

        void Initialize(std::string const& realmName);
        void LoadFromConfigs();
        void Unload();

        bool IsEnabled() const { return _enabled; }
        MetricRegistry& Registry() { return _registry; }
        MetricRegistry const& Registry() const { return _registry; }

    private:
        ObservabilityMgr() = default;

        MetricRegistry _registry;
        std::unique_ptr<PrometheusExporter> _prometheusExporter;
        std::string _realmName;
        bool _enabled = false;
    };
}

#define sObservability Acore::Observability::ObservabilityMgr::instance()

#endif // OBSERVABILITY_MGR_H__

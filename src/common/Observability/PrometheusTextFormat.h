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

#ifndef OBSERVABILITY_PROMETHEUS_TEXT_FORMAT_H__
#define OBSERVABILITY_PROMETHEUS_TEXT_FORMAT_H__

#include "Define.h"
#include <string>

namespace Acore::Observability
{
    class MetricRegistry;

    class PrometheusTextFormat
    {
    public:
        static std::string Serialize(MetricRegistry const& registry);
    };
}

#endif // OBSERVABILITY_PROMETHEUS_TEXT_FORMAT_H__

/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU Affero General Public License as published by the
 * Free Software Foundation; either version 3 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "CreatureAI.h"
#include "Define.h"
#include "SmartEnum.h"
#include <stdexcept>

namespace Acore::Impl::EnumUtilsImpl
{

/****************************************************************************\
|* data for enum 'CreatureAI::EvadeReason' in 'CreatureAI.h' auto-generated *|
\****************************************************************************/
template <>
AC_API_EXPORT EnumText EnumUtils<CreatureAI::EvadeReason>::ToString(CreatureAI::EvadeReason value)
{
    switch (value)
    {
        case CreatureAI::EVADE_REASON_NO_HOSTILES: return { "EVADE_REASON_NO_HOSTILES", "EVADE_REASON_NO_HOSTILES", "the creature's threat list is empty" };
        case CreatureAI::EVADE_REASON_BOUNDARY: return { "EVADE_REASON_BOUNDARY", "EVADE_REASON_BOUNDARY", "the creature has moved outside its evade boundary" };
        case CreatureAI::EVADE_REASON_SEQUENCE_BREAK: return { "EVADE_REASON_SEQUENCE_BREAK", "EVADE_REASON_SEQUENCE_BREAK", "this is a boss and the pre-requisite encounters for engaging it are not defeated yet" };
        case CreatureAI::EVADE_REASON_NO_PATH: return { "EVADE_REASON_NO_PATH", "EVADE_REASON_NO_PATH", "the creature was unable to reach its target for over 5 seconds" };
        default: throw std::out_of_range("value");
    }
}

template <>
AC_API_EXPORT size_t EnumUtils<CreatureAI::EvadeReason>::Count() { return 4; }

template <>
AC_API_EXPORT CreatureAI::EvadeReason EnumUtils<CreatureAI::EvadeReason>::FromIndex(size_t index)
{
    switch (index)
    {
        case 0: return CreatureAI::EVADE_REASON_NO_HOSTILES;
        case 1: return CreatureAI::EVADE_REASON_BOUNDARY;
        case 2: return CreatureAI::EVADE_REASON_SEQUENCE_BREAK;
        case 3: return CreatureAI::EVADE_REASON_NO_PATH;
        default: throw std::out_of_range("index");
    }
}

template <>
AC_API_EXPORT size_t EnumUtils<CreatureAI::EvadeReason>::ToIndex(CreatureAI::EvadeReason value)
{
    switch (value)
    {
        case CreatureAI::EVADE_REASON_NO_HOSTILES: return 0;
        case CreatureAI::EVADE_REASON_BOUNDARY: return 1;
        case CreatureAI::EVADE_REASON_SEQUENCE_BREAK: return 2;
        case CreatureAI::EVADE_REASON_NO_PATH: return 3;
        default: throw std::out_of_range("value");
    }
}
}

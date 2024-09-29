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

#include "WardenCheckMgr.h"
#include "Define.h"
#include "SmartEnum.h"
#include <stdexcept>

namespace Acore::Impl::EnumUtilsImpl
{

/**********************************************************************\
|* data for enum 'WardenActions' in 'WardenCheckMgr.h' auto-generated *|
\**********************************************************************/
template <>
AC_API_EXPORT EnumText EnumUtils<WardenActions>::ToString(WardenActions value)
{
    switch (value)
    {
        case WARDEN_ACTION_LOG: return { "WARDEN_ACTION_LOG", "Log", "" };
        case WARDEN_ACTION_KICK: return { "WARDEN_ACTION_KICK", "Kick", "" };
        case WARDEN_ACTION_BAN: return { "WARDEN_ACTION_BAN", "Ban", "" };
        default: throw std::out_of_range("value");
    }
}

template <>
AC_API_EXPORT std::size_t EnumUtils<WardenActions>::Count() { return 3; }

template <>
AC_API_EXPORT WardenActions EnumUtils<WardenActions>::FromIndex(std::size_t index)
{
    switch (index)
    {
        case 0: return WARDEN_ACTION_LOG;
        case 1: return WARDEN_ACTION_KICK;
        case 2: return WARDEN_ACTION_BAN;
        default: throw std::out_of_range("index");
    }
}

template <>
AC_API_EXPORT std::size_t EnumUtils<WardenActions>::ToIndex(WardenActions value)
{
    switch (value)
    {
        case WARDEN_ACTION_LOG: return 0;
        case WARDEN_ACTION_KICK: return 1;
        case WARDEN_ACTION_BAN: return 2;
        default: throw std::out_of_range("value");
    }
}
}

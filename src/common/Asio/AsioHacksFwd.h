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

#ifndef AsioHacksFwd_h__
#define AsioHacksFwd_h__

/**
  Collection of forward declarations to improve compile time
 */
namespace boost::posix_time
{
    class ptime;
}

namespace boost::asio
{
    template <typename Time>
    struct time_traits;
}

namespace boost::asio::ip
{
    class address;
    class tcp;

    template <typename InternetProtocol>
    class basic_endpoint;

    typedef basic_endpoint<tcp> tcp_endpoint;
}

namespace Acore::Asio
{
    class DeadlineTimer;
    class IoContext;
    class Resolver;
    class Strand;
}

#endif // AsioHacksFwd_h__

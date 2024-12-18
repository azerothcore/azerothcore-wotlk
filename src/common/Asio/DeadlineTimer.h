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

#ifndef DeadlineTimer_h__
#define DeadlineTimer_h__

#include <boost/asio/steady_timer.hpp>
#include <chrono>

using namespace std::chrono_literals;

#define DeadlineTimerBase boost::asio::basic_waitable_timer<std::chrono::steady_clock>

namespace Acore::Asio {
  class DeadlineTimer : public DeadlineTimerBase {

    public:

    using DeadlineTimerBase::basic_waitable_timer;

    DeadlineTimer(boost::asio::io_context& io)
        : DeadlineTimerBase(io) {}

  };
}

#endif // DeadlineTimer_h__

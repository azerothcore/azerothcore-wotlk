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

#ifndef Strand_h__
#define Strand_h__

#include "IoContext.h"
#include <boost/asio/strand.hpp>
#include <boost/asio/bind_executor.hpp>

namespace Acore::Asio
{
  /**
      Wrapper for boost::asio::strand to make it possible to forward declare it.
  */
  class Strand : public boost::asio::strand<boost::asio::io_context::executor_type>
  {
  public:
    Strand(IoContext& ioContext) : boost::asio::strand<boost::asio::io_context::executor_type>(ioContext.get_executor()) { }
  };

  // Using the actual boost::asio::bind_executor
  using boost::asio::bind_executor;
}

#endif // Strand_h__

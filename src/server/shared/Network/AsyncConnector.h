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

#ifndef __ASYNCCONNECT_H_
#define __ASYNCCONNECT_H_

#include <boost/asio.hpp>
#include <boost/system/error_code.hpp>
#include <memory>
#include <string>

#include "Asio/IoContext.h"
#include "Asio/IpAddress.h"
#include "Log.h"

using boost::asio::ip::tcp;

template <typename SocketType> class AsyncConnector {
public:
  /**
   * @brief Constructor for AsyncConnector
   *
   * @param ioContext   A reference to Acore::Asio::IoContext, similar
   *                    to how AsyncAcceptor uses it.
   * @param connectIp   IP address to connect to (string).
   * @param connectPort Port to connect on the remote host.
   * @param silent      If true, suppresses logging on error.
   */
    AsyncConnector(Acore::Asio::IoContext &ioContext, std::string const &connectIp, uint16 connectPort, bool silent = false) :
        _ioContext(ioContext), _endpoint(Acore::Net::make_address(connectIp),
        connectPort), _silent(silent)
    {
        Connect();
    }

public:
  /**
   * @brief Attempts to connect to the remote address asynchronously.
   */
  void Connect() {
    // below fails as we need access to raw socket later...
    // Create a shared pointer to your SocketType object (derived from
    // AsyncSocket).
    // auto connection = std::make_shared<SocketType>(_ioContext);

    // Create a shared pointer to a *plain* tcp::socket, not SocketType
    auto rawSocket = std::make_shared<tcp::socket>(_ioContext);

    try
    {
        rawSocket->async_connect(_endpoint, [this, rawSocket](boost::system::error_code const& ec)
        {
            HandleConnect(rawSocket, ec);
        });
    }
    catch (boost::system::system_error const& error)
    {
        if (!_silent)
        {
            LOG_ERROR("network", "AsyncConnector::Connect() - Exception in async_connect: {}", error.what());
        }
    }
  }

  /**
   * @brief The completion handler for the async_connect call.
   *
   * @param connection rawSocket
   * @param ec         The boost::system::error_code returned by async_connect.
   */
  void HandleConnect(std::shared_ptr<tcp::socket> rawSocket, const boost::system::error_code& ec)
  {
      if (!ec)
      {
          // If connection succeeded, create your SocketType with the connected socket
          auto connection = std::make_shared<SocketType>(std::move(*rawSocket));
          connection->Start();
      }
      else
      {
          if (!_silent)
          {
              LOG_ERROR("network", "AsyncConnector::HandleConnect - Failed to connect: {}", ec.message());
          }
      }
  }


private:
  // Use Acore::Asio::IoContext instead of a raw boost::asio::io_context
  // reference
  Acore::Asio::IoContext &_ioContext;

  // Endpoint will hold the IP address and port to connect to
  tcp::endpoint _endpoint;

  // If true, suppress error logging
  bool _silent;
};

#endif

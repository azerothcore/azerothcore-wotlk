/*
 * Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
 * Copyright (C) 2021+ WarheadCore <https://github.com/WarheadCore>
 */

#ifndef IpNetwork_h__
#define IpNetwork_h__

#include "Define.h"
#include "IpAddress.h"
#include <boost/version.hpp>

#if BOOST_VERSION >= 106600
#include <boost/asio/ip/network_v4.hpp>
#include <boost/asio/ip/network_v6.hpp>
#endif

namespace Acore::Net
{
    inline bool IsInNetwork(boost::asio::ip::address_v4 const& networkAddress, boost::asio::ip::address_v4 const& mask, boost::asio::ip::address_v4 const& clientAddress)
    {
#if BOOST_VERSION >= 106600
        boost::asio::ip::network_v4 network = boost::asio::ip::make_network_v4(networkAddress, mask);
        boost::asio::ip::address_v4_range hosts = network.hosts();
        return hosts.find(clientAddress) != hosts.end();
#else
        return (clientAddress.to_ulong() & mask.to_ulong()) == (networkAddress.to_ulong() & mask.to_ulong());
#endif
    }

    inline boost::asio::ip::address_v4 GetDefaultNetmaskV4(boost::asio::ip::address_v4 const& networkAddress)
    {
        if ((address_to_uint(networkAddress) & 0x80000000) == 0)
        {
            return boost::asio::ip::address_v4(0xFF000000);
        }
        if ((address_to_uint(networkAddress) & 0xC0000000) == 0x80000000)
        {
            return boost::asio::ip::address_v4(0xFFFF0000);
        }
        if ((address_to_uint(networkAddress) & 0xE0000000) == 0xC0000000)
        {
            return boost::asio::ip::address_v4(0xFFFFFF00);
        }
        return boost::asio::ip::address_v4(0xFFFFFFFF);
    }

    inline bool IsInNetwork(boost::asio::ip::address_v6 const& networkAddress, uint16 prefixLength, boost::asio::ip::address_v6 const& clientAddress)
    {
#if BOOST_VERSION >= 106600
        boost::asio::ip::network_v6 network = boost::asio::ip::make_network_v6(networkAddress, prefixLength);
        boost::asio::ip::address_v6_range hosts = network.hosts();
        return hosts.find(clientAddress) != hosts.end();
#else
        (void)networkAddress;
        (void)prefixLength;
        (void)clientAddress;
        return false;
#endif
    }
}

#endif // IpNetwork_h__

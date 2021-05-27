/*
 * Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
 * Copyright (C) 2021+ WarheadCore <https://github.com/WarheadCore>
 */

#ifndef AsioHacksFwd_h__
#define AsioHacksFwd_h__

#include <boost/version.hpp>

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

namespace acore::Asio
{
    class DeadlineTimer;
    class IoContext;
    class Resolver;
    class Strand;
}

#endif // AsioHacksFwd_h__

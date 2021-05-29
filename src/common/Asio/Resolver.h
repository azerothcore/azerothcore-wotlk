/*
 * Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
 * Copyright (C) 2021+ WarheadCore <https://github.com/WarheadCore>
 */

#ifndef Resolver_h__
#define Resolver_h__

#include "IoContext.h"
#include "Optional.h"
#include <boost/asio/ip/tcp.hpp>
#include <string>

namespace acore::Asio
{
    /**
     Hack to make it possible to forward declare resolver (one of its template arguments is a typedef to something super long and using nested classes)
    */
    class Resolver
    {
    public:
        explicit Resolver(IoContext& ioContext) : _impl(ioContext) { }

        Optional<boost::asio::ip::tcp::endpoint> Resolve(boost::asio::ip::tcp const& protocol, std::string const& host, std::string const& service)
        {
            boost::system::error_code ec;
#if BOOST_VERSION >= 106600
            boost::asio::ip::resolver_base::flags flagsResolver = boost::asio::ip::resolver_base::all_matching;
            boost::asio::ip::tcp::resolver::results_type results = _impl.resolve(protocol, host, service, flagsResolver, ec);
            if (results.begin() == results.end() || ec)
                return {};

            return results.begin()->endpoint();
#else
            boost::asio::ip::resolver_query_base::flags flagsQuery = boost::asio::ip::tcp::resolver::query::all_matching;
            boost::asio::ip::tcp::resolver::query query(std::move(protocol), std::move(host), std::move(service), flagsQuery);
            boost::asio::ip::tcp::resolver::iterator itr = _impl.resolve(query, ec);
            boost::asio::ip::tcp::resolver::iterator end;
            if (itr == end || ec)
                return {};

            return itr->endpoint();
#endif
        }

    private:
        boost::asio::ip::tcp::resolver _impl;
    };
}

#endif // Resolver_h__

/*
 * Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
 * Copyright (C) 2021+ WarheadCore <https://github.com/WarheadCore>
 */

#ifndef Strand_h__
#define Strand_h__

#include "IoContext.h"
#include <boost/asio/strand.hpp>

#if BOOST_VERSION >= 106600
#include <boost/asio/bind_executor.hpp>
#endif

namespace Acore::Asio
{
    /**
        Hack to make it possible to forward declare strand (which is a inner class)
    */
    class Strand : public IoContextBaseNamespace::IoContextBase::strand
    {
    public:
        Strand(IoContext& ioContext) : IoContextBaseNamespace::IoContextBase::strand(ioContext) { }
    };

#if BOOST_VERSION >= 106600
    using boost::asio::bind_executor;
#else
    template<typename T>
    inline decltype(auto) bind_executor(Strand& strand, T&& t)
    {
        return strand.wrap(std::forward<T>(t));
    }
#endif
}

#endif // Strand_h__

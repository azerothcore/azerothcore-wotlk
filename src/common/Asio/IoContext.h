/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license, you may redistribute it and/or modify it under version 3 of the License, or (at your option), any later version.
 * Copyright (C) 2008-2021 TrinityCore <http://www.trinitycore.org/>
 */

#ifndef IoContext_h__
#define IoContext_h__

#include <boost/version.hpp>

#if BOOST_VERSION >= 106600
#include <boost/asio/io_context.hpp>
#include <boost/asio/post.hpp>
#define IoContextBaseNamespace boost::asio
#define IoContextBase io_context
#else
#include <boost/asio/io_service.hpp>
#define IoContextBaseNamespace boost::asio
#define IoContextBase io_service
#endif

namespace acore
{
    namespace Asio
    {
        class IoContext
        {
        public:
            IoContext() : _impl() { }
            explicit IoContext(int concurrency_hint) : _impl(concurrency_hint) { }

            operator IoContextBaseNamespace::IoContextBase&() { return _impl; }
            operator IoContextBaseNamespace::IoContextBase const&() const { return _impl; }

            std::size_t run() { return _impl.run(); }
            void stop() { _impl.stop(); }

#if BOOST_VERSION >= 106600
            boost::asio::io_context::executor_type get_executor() noexcept { return _impl.get_executor(); }
#endif

        private:
            IoContextBaseNamespace::IoContextBase _impl;
        };

        template<typename T>
        inline decltype(auto) post(IoContextBaseNamespace::IoContextBase& ioContext, T&& t)
        {
#if BOOST_VERSION >= 106600
            return boost::asio::post(ioContext, std::forward<T>(t));
#else
            return ioContext.post(std::forward<T>(t));
#endif
        }

        template<typename T>
        inline decltype(auto) get_io_context(T&& ioObject)
        {
#if BOOST_VERSION >= 106600
            return ioObject.get_executor().context();
#else
            return ioObject.get_io_service();
#endif
        }
    }
}

#endif // IoContext_h__

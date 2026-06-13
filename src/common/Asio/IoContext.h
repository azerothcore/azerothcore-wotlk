/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#ifndef IoContext_h__
#define IoContext_h__

#include <boost/version.hpp>
#include <boost/asio/io_context.hpp>
#include <boost/asio/post.hpp>
#define IoContextBaseNamespace boost::asio
#define IoContextBase io_context

namespace Acore::Asio
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

        boost::asio::io_context::executor_type get_executor() noexcept { return _impl.get_executor(); }

    private:
        IoContextBaseNamespace::IoContextBase _impl;
    };

    template<typename T>
    inline decltype(auto) post(IoContextBaseNamespace::IoContextBase& ioContext, T&& t)
    {
        return boost::asio::post(ioContext, std::forward<T>(t));
    }

    template<typename T>
    inline boost::asio::io_context& get_io_context(T&& ioObject)
    {
        return static_cast<boost::asio::io_context&>(ioObject.get_executor().context());
    }
}

#endif // IoContext_h__

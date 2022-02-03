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

#ifndef ASYNC_CALLBACK_H_
#define ASYNC_CALLBACK_H_

#include "AsyncCallbackProcessor.h"
#include <functional>
#include <future>
#include <memory>

namespace Acore::Async
{
    using AsyncCallbackFuture = std::future<void>;

    class AC_COMMON_API AsyncCallback
    {
    public:
        AsyncCallback(AsyncCallbackFuture&& future) : _future(std::move(future)) { }
        AsyncCallback(AsyncCallback&&) = default;

        AsyncCallback& operator=(AsyncCallback&&) = default;

        bool InvokeIfReady();

    private:
        AsyncCallbackFuture _future;

        AsyncCallback(AsyncCallback const& right) = delete;
        AsyncCallback& operator=(AsyncCallback const& right) = delete;
    };

    class AsyncCallbackMgr
    {
    public:
        AsyncCallbackMgr() = default;
        ~AsyncCallbackMgr() = default;

        static AsyncCallbackMgr* instance();

        AsyncCallback& AddAsyncCallback(std::function<void()> execute);

        void ProcessReadyCallbacks();
        size_t GetSize() { return _asyncCallbacks.Size(); }

    private:
        AsyncCallbackProcessor<AsyncCallback> _asyncCallbacks;

        AsyncCallbackMgr(AsyncCallbackMgr const& right) = delete;
        AsyncCallbackMgr& operator=(AsyncCallbackMgr const& right) = delete;
    };
}

#define sAsyncCallbackMgr Acore::Async::AsyncCallbackMgr::instance()

#endif // ASYNC_CALLBACK_H_

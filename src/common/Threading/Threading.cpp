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

#include "Threading.h"
#include "Errors.h"

#include <chrono>
#include <system_error>

#ifdef WIN32
#include <windows.h>
#endif // WIN32
using namespace Acore;

Thread::Thread() : m_task(nullptr), m_iThreadId(), m_ThreadImp()
{
}

Thread::Thread(Runnable* instance) : m_task(instance), m_ThreadImp(&Thread::ThreadTask, (void*)m_task)
{
    m_iThreadId = m_ThreadImp.get_id();

    // register reference to m_task to prevent it deeltion until destructor
    if (m_task)
    {
        m_task->incReference();
    }
}

Thread::~Thread()
{
    // Wait();

    // deleted runnable object (if no other references)
    if (m_task)
    {
        m_task->decReference();
    }
}

bool Thread::wait()
{
    if (m_iThreadId == std::thread::id() || !m_task)
    {
        return false;
    }

    bool res = true;

    try
    {
        m_ThreadImp.join();
    }
    catch (std::system_error&)
    {
        res = false;
    }

    m_iThreadId = std::thread::id();

    return res;
}

void Thread::destroy()
{
    if (m_iThreadId == std::thread::id() || !m_task)
    {
        return;
    }

    // FIXME: We need to make sure that all threads can be trusted to
    // halt execution on their own as this is not an interrupt
    m_ThreadImp.join();
    m_iThreadId = std::thread::id();
}

void Thread::ThreadTask(void* param)
{
    Runnable* _task = (Runnable*)param;
    _task->run();
}

std::thread::id Thread::currentId()
{
    return std::this_thread::get_id();
}

void Thread::setPriority(Priority priority)
{
#ifdef WIN32
    std::thread::native_handle_type handle = m_ThreadImp.native_handle();
#endif

    bool _ok = true;

    switch (priority)
    {
#ifdef WIN32
        case Priority_Realtime:
            _ok = SetThreadPriority(handle, THREAD_PRIORITY_TIME_CRITICAL);
            break;
        case Priority_Highest:
            _ok = SetThreadPriority(handle, THREAD_PRIORITY_HIGHEST);
            break;
        case Priority_High:
            _ok = SetThreadPriority(handle, THREAD_PRIORITY_ABOVE_NORMAL);
            break;
        case Priority_Normal:
            _ok = SetThreadPriority(handle, THREAD_PRIORITY_NORMAL);
            break;
        case Priority_Low:
            _ok = SetThreadPriority(handle, THREAD_PRIORITY_BELOW_NORMAL);
            break;
        case Priority_Lowest:
            _ok = SetThreadPriority(handle, THREAD_PRIORITY_LOWEST);
            break;
        case Priority_Idle:
            _ok = SetThreadPriority(handle, THREAD_PRIORITY_IDLE);
            break;
#endif
        default:
            break;
    }

    // remove this ASSERT in case you don't want to know is thread priority change was successful or not
    ASSERT(_ok);
}

void Thread::Sleep(unsigned long msecs)
{
    std::this_thread::sleep_for(std::chrono::milliseconds(msecs));
}

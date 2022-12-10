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

#ifndef __PROCESS_H__
#define __PROCESS_H__

#include "Define.h"
#include <future>
#include <memory>
#include <string>
#include <vector>

namespace Acore
{

    /// Starts a process with the given arguments and parameters and will block
    /// until the process is finished.
    /// When an input path is given, the file will be routed to the processes stdin.
    /// When the process is marked as secure no arguments are leaked to logs.
    /// Note that most executables expect it's name as the first argument.
    AC_COMMON_API int StartProcess(std::string const& executable, std::vector<std::string> const& args,
                                   std::string const& logger, std::string input_file = "",
                                   bool secure = false);

    /// Platform and library independent representation
    /// of asynchronous process results
    class AsyncProcessResult
    {
    public:
        virtual ~AsyncProcessResult() { }

        /// Returns the future which contains the result of the process
        /// as soon it is finished.
        virtual std::future<int>& GetFutureResult() = 0;

        /// Tries to terminate the process
        virtual void Terminate() = 0;
    };

    /// Starts a process asynchronously with the given arguments and parameters and
    /// returns an AsyncProcessResult immediately which is set, when the process exits.
    /// When an input path is given, the file will be routed to the processes stdin.
    /// When the process is marked as secure no arguments are leaked to logs.
    /// Note that most executables expect it's name as the first argument.
    AC_COMMON_API std::shared_ptr<AsyncProcessResult> StartAsyncProcess(std::string executable, std::vector<std::string> args,
            std::string logger, std::string input_file = "",
            bool secure = false);

    /// Searches for the given executable in the PATH variable
    /// and returns a non-empty string when it was found.
    AC_COMMON_API std::string SearchExecutableInPath(std::string const& filename);

} // namespace Acore

#endif // __PROCESS_H__

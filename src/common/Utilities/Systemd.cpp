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

#if defined(__linux__)
#include <cstdlib>
#include <unistd.h>
#include <string>

int get_listen_fds()
{
    const char* listen_pid = std::getenv("LISTEN_PID");
    const char* listen_fds = std::getenv("LISTEN_FDS");
    if (!listen_pid || !listen_fds)
        return 0;

    pid_t pid = static_cast<pid_t>(std::stoi(listen_pid));
    if (pid != getpid())
        return 0;

    if (std::stoi(listen_fds) <= 0)
        return 0;

    return 3;
}
#else
// On non-Linux systems, just return 0 (no socket activation)
int get_listen_fds()
{
    return 0;
}
#endif

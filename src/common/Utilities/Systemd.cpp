/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information.
 *
 * Portions of this file are derived from systemd, licensed under:
 * - GPL-2.0-or-later (if the original systemd file was GPL-2.0+)
 *   OR
 * - LGPL-2.1-or-later, relicensed under GPL-2.0-or-later as permitted by LGPL-2.1+
 *
 * Original systemd copyright:
 *   Copyright (c) the systemd contributors.
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

#if defined(__linux__)
#include "Log.h"
#include "StringConvert.h"
#include <cstdlib>
#include <unistd.h>
#include <string>

int get_listen_fd()
{
    char* const listen_pid = std::getenv("LISTEN_PID");
    char* const listen_fds = std::getenv("LISTEN_FDS");
    if (!listen_pid || !listen_fds)
        return 0;

    pid_t pid = Acore::StringTo<int>(listen_pid).value_or(0);
    if (pid != getpid())
        return 0;

    int fds = Acore::StringTo<int>(listen_fds).value_or(0);
    if (fds <= 0)
        return 0;

    if (fds > 1)
        LOG_WARN("network", "Multiple file descriptors received from systemd socket activation, only the first will be used");

    return 3;
}
#else
// On non-Linux systems, just return 0 (no socket activation)
int get_listen_fd()
{
    return 0;
}
#endif

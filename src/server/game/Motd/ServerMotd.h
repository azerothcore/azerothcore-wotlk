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

#ifndef ServerMotd_h__
#define ServerMotd_h__

#include "Define.h"
#include <string>

class WorldPacket;

namespace Motd
{
    /// Set a new Message of the Day
    void SetMotd(std::string motd);

    /// Get the current Message of the Day
    char const* GetMotd();

    /// Get the motd packet to send at login
    WorldPacket const* GetMotdPacket();
}

#endif //ServerMotd_h_
// _

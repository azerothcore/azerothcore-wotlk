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

#ifndef _MOTDMGR_H_
#define _MOTDMGR_H_

#include "Define.h"
#include <string>
#include "Common.h"

class WorldPacket;

class AC_GAME_API MotdMgr
{
public:
    static MotdMgr* instance();

    /// Set a new Message of the Day
    void SetMotd(std::string motd, LocaleConstant locale);

    /// Load Message of the Day
    void LoadMotd();

    /// Get the current Message of the Day
    char const* GetMotd(LocaleConstant locale);

    /// Returns the current motd packet for the given locale
    WorldPacket const* GetMotdPacket(LocaleConstant locale);

private:
    // Loads all available localized motd for the realm
    void LoadMotdLocale();

    // Create a worldpacket for a given motd localization
    WorldPacket CreateWorldPacket(std::string motd);
};

#define sMotdMgr MotdMgr::instance()

#endif // _MOTDMGR_H_

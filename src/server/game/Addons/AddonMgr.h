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

#ifndef _ADDONMGR_H
#define _ADDONMGR_H

#include "Define.h"
#include <array>
#include <list>
#include <string>

struct AddonInfo
{
    AddonInfo(std::string  name, uint8 enabled, uint32 crc, uint8 state, bool crcOrPubKey)
        : Name(std::move(name)), Enabled(enabled), CRC(crc), State(state), UsePublicKeyOrCRC(crcOrPubKey) {}

    std::string Name;
    uint8 Enabled;
    uint32 CRC;
    uint8 State;
    bool UsePublicKeyOrCRC;
};

struct SavedAddon
{
    SavedAddon(std::string  name, uint32 crc) : Name(std::move(name)), CRC(crc) {}

    std::string Name;
    uint32 CRC;
};

struct BannedAddon
{
    BannedAddon(uint32 id, std::array<uint8, 16> const& nameMD5, std::array<uint8, 16> const& versionMD5, uint32 timestamp)
        : Id(id), NameMD5(nameMD5), VersionMD5(versionMD5), Timestamp(timestamp) {}

    uint32 Id;
    std::array<uint8, 16> NameMD5;
    std::array<uint8, 16> VersionMD5;
    uint32 Timestamp;
};

#define STANDARD_ADDON_CRC 0x4c1c776d

namespace AddonMgr
{
    void LoadFromDB();
    void SaveAddon(AddonInfo const& addon);
    SavedAddon const* GetAddonInfo(const std::string& name);

    typedef std::list<BannedAddon> BannedAddonList;
    BannedAddonList const* GetBannedAddons();
}

#endif

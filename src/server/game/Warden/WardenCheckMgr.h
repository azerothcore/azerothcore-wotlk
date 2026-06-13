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

#ifndef _WARDENCHECKMGR_H
#define _WARDENCHECKMGR_H

#include "Cryptography/BigNumber.h"
#include <map>

// EnumUtils: DESCRIBE THIS
enum WardenActions : uint8
{
    WARDEN_ACTION_LOG,  // TITLE Log
    WARDEN_ACTION_KICK, // TITLE Kick
    WARDEN_ACTION_BAN   // TITLE Ban
};

constexpr uint8 MAX_WARDEN_ACTION = 3;

enum WardenCheckTypes
{
    WARDEN_CHECK_MEM_TYPE   = 0,
    WARDEN_CHECK_LUA_TYPE   = 1,
    WARDEN_CHECK_OTHER_TYPE = 2,
};

constexpr uint8 MAX_WARDEN_CHECK_TYPES = 3;

struct WardenCheck
{
    uint8 Type;
    BigNumber Data;
    uint32 Address;                                         // PROC_CHECK, MEM_CHECK, PAGE_CHECK
    uint8 Length;                                           // PROC_CHECK, MEM_CHECK, PAGE_CHECK
    std::string Str;                                        // LUA, MPQ, DRIVER
    std::string Comment;
    uint16 CheckId;
    std::array<char, 4> IdStr = {};                         // LUA
    uint32 Action;
};

constexpr uint8 WARDEN_MAX_LUA_CHECK_LENGTH = 170;

struct WardenCheckResult
{
    BigNumber Result;                                       // MEM_CHECK
};

class WardenCheckMgr
{
    WardenCheckMgr();
    ~WardenCheckMgr();

public:
    static WardenCheckMgr* instance();

    // We have a linear key without any gaps, so we use vector for fast access
    typedef std::vector<WardenCheck> CheckContainer;
    typedef std::map<uint32, WardenCheckResult> CheckResultContainer;

    uint16 GetMaxValidCheckId() const { return static_cast<uint16>(CheckStore.size()); }
    WardenCheck const* GetWardenDataById(uint16 Id);
    WardenCheckResult const* GetWardenResultById(uint16 Id);

    std::vector<uint16> CheckIdPool[MAX_WARDEN_CHECK_TYPES];

    void LoadWardenChecks();
    void LoadWardenOverrides();

private:
    std::vector<WardenCheck> CheckStore;
    std::map<uint32, WardenCheckResult> CheckResultStore;
};

#define sWardenCheckMgr WardenCheckMgr::instance()

#endif

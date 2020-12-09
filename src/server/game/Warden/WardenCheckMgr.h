/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef _WARDENCHECKMGR_H
#define _WARDENCHECKMGR_H

#include <map>
#include "Cryptography/BigNumber.h"

enum WardenActions
{
    WARDEN_ACTION_LOG   = 0,
    WARDEN_ACTION_KICK  = 1,
    WARDEN_ACTION_BAN   = 2,
};

constexpr uint8 MAX_WARDEN_ACTION = 3;

static std::string GetWardenActionStr(uint32 action)
{
    switch (action)
    {
    case WARDEN_ACTION_LOG:
        return "WARDEN_ACTION_LOG";
    case WARDEN_ACTION_KICK:
        return "WARDEN_ACTION_KICK";
    case WARDEN_ACTION_BAN:
        return "WARDEN_ACTION_BAN";
    }

    return "UNHANDLED ACTION";
}

enum WardenCheckTypes
{
    WARDEN_CHECK_MEM_TYPE   = 0,
    WARDEN_CHECK_LUA_TYPE   = 1,
    WARDEN_CHECK_OTHER_TYPE = 2,
};

constexpr uint8 MAX_WARDEN_CHECK_TYPES = 3;

// Returns config id for specific type id
static WorldIntConfigs GetMaxWardenChecksForType(uint8 type)
{
    // Should never be higher type than defined
    ASSERT(type < MAX_WARDEN_CHECK_TYPES);

    switch (type)
    {
    case WARDEN_CHECK_MEM_TYPE:
        return CONFIG_WARDEN_NUM_MEM_CHECKS;
    case WARDEN_CHECK_LUA_TYPE:
        return CONFIG_WARDEN_NUM_LUA_CHECKS;
    default:
        break;
    }

    return CONFIG_WARDEN_NUM_OTHER_CHECKS;
}

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

    uint16 GetMaxValidCheckId() const { return static_cast<uint16>(_checks.size()); }
    WardenCheck const* GetWardenDataById(uint16 Id);
    WardenCheckResult const* GetWardenResultById(uint16 Id);

    std::vector<uint16> CheckIdPool[MAX_WARDEN_CHECK_TYPES];

    void LoadWardenChecks();
    void LoadWardenOverrides();

private:
    std::vector<WardenCheck> _checks;
    CheckContainer CheckStore;
    CheckResultContainer CheckResultStore;
};

#define sWardenCheckMgr WardenCheckMgr::instance()

#endif

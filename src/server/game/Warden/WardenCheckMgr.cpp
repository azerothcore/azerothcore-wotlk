/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include "Database/DatabaseEnv.h"
#include "Log.h"
#include "Util.h"
#include "Warden.h"
#include "WardenCheckMgr.h"
#include "WorldSession.h"

WardenCheckMgr::WardenCheckMgr()
{
}

WardenCheckMgr::~WardenCheckMgr()
{
}

WardenCheckMgr* WardenCheckMgr::instance()
{
    static WardenCheckMgr instance;
    return &instance;
}

void WardenCheckMgr::LoadWardenChecks()
{
    // Check if Warden is enabled by config before loading anything
    if (!sWorld->getBoolConfig(CONFIG_WARDEN_ENABLED))
    {
        LOG_INFO("server", ">> Warden disabled, loading checks skipped.");
        LOG_INFO("server", " ");
        return;
    }

    QueryResult result = WorldDatabase.Query("SELECT MAX(id) FROM warden_checks");

    if (!result)
    {
        LOG_INFO("server", ">> Loaded 0 Warden checks. DB table `warden_checks` is empty!");
        LOG_INFO("server", " ");
        return;
    }

    Field* fields = result->Fetch();

    uint16 maxCheckId = fields[0].GetUInt16();

    CheckStore.resize(maxCheckId + 1);

    //                                    0    1     2     3        4       5      6      7
    result = WorldDatabase.Query("SELECT id, type, data, result, address, length, str, comment FROM warden_checks ORDER BY id ASC");

    uint32 count = 0;
    do
    {
        fields = result->Fetch();

        uint16 id               = fields[0].GetUInt16();
        uint8 checkType         = fields[1].GetUInt8();

        if (checkType == LUA_EVAL_CHECK && id > 9999)
        {
            LOG_ERROR("server", "sql.sql: Warden Lua check with id %u found in `warden_checks`. Lua checks may have four-digit IDs at most. Skipped.", id);
            continue;
        }

        std::string data        = fields[2].GetString();
        std::string checkResult = fields[3].GetString();
        uint32 address          = fields[4].GetUInt32();
        uint8 length            = fields[5].GetUInt8();
        std::string str         = fields[6].GetString();
        std::string comment     = fields[7].GetString();

        WardenCheck &wardenCheck = CheckStore.at(id);
        wardenCheck.Type = checkType;
        wardenCheck.CheckId = id;

        // Initialize action with default action from config
        wardenCheck.Action = sWorld->getIntConfig(CONFIG_WARDEN_CLIENT_FAIL_ACTION);
        if (wardenCheck.Action > MAX_WARDEN_ACTION)
        {
            wardenCheck.Action = WARDEN_ACTION_BAN;
        }

        if (checkType == MEM_CHECK || checkType == PAGE_CHECK_A || checkType == PAGE_CHECK_B || checkType == PROC_CHECK)
        {
            wardenCheck.Address = address;
            wardenCheck.Length = length;
        }

        // PROC_CHECK support missing
        if (checkType == MEM_CHECK || checkType == MPQ_CHECK || checkType == LUA_EVAL_CHECK || checkType == DRIVER_CHECK || checkType == MODULE_CHECK)
        {
            wardenCheck.Str = str;
        }

        if (checkType == MPQ_CHECK || checkType == MEM_CHECK)
        {
            WardenCheckResult wr;
            wr.Result.SetHexStr(checkResult.c_str());
            CheckResultStore[id] = wr;
        }

        if (comment.empty())
            wardenCheck.Comment = "Undocumented Check";
        else
            wardenCheck.Comment = comment;

        // Prepare check pools
        switch (checkType)
        {
            case MEM_CHECK:
            case MODULE_CHECK:
            {
                CheckIdPool[WARDEN_CHECK_MEM_TYPE].push_back(id);
                break;
            }
            case LUA_EVAL_CHECK:
            {
                if (wardenCheck.Length > WARDEN_MAX_LUA_CHECK_LENGTH)
                {
                    LOG_ERROR("server", "sql.sql: Found over-long Lua check for Warden check with id %u in `warden_checks`. Max length is %u. Skipped.", id, WARDEN_MAX_LUA_CHECK_LENGTH);
                    continue;
                }

                std::string str2 = Acore::StringFormat("%04u", id);
                ASSERT(str2.size() == 4);
                std::copy(str2.begin(), str2.end(), wardenCheck.IdStr.begin());

                CheckIdPool[WARDEN_CHECK_LUA_TYPE].push_back(id);
                break;
            }
            default:
            {
                if (checkType == PAGE_CHECK_A || checkType == PAGE_CHECK_B || checkType == DRIVER_CHECK)
                    wardenCheck.Data.SetHexStr(data.c_str());

                CheckIdPool[WARDEN_CHECK_OTHER_TYPE].push_back(id);
                break;
            }
        }

        ++count;
    } while (result->NextRow());

    LOG_INFO("server", ">> Loaded %u warden checks.", count);
    LOG_INFO("server", " ");
}

void WardenCheckMgr::LoadWardenOverrides()
{
    // Check if Warden is enabled by config before loading anything
    if (!sWorld->getBoolConfig(CONFIG_WARDEN_ENABLED))
    {
        LOG_INFO("server", ">> Warden disabled, loading check overrides skipped.");
        LOG_INFO("server", " ");
        return;
    }

    //                                                      0        1
    QueryResult result = CharacterDatabase.Query("SELECT wardenId, action FROM warden_action");

    if (!result)
    {
        LOG_INFO("server", ">> Loaded 0 Warden action overrides. DB table `warden_action` is empty!");
        LOG_INFO("server", " ");
        return;
    }

    uint32 count = 0;

    do
    {
        Field* fields = result->Fetch();

        uint16 checkId = fields[0].GetUInt16();
        uint8  action  = fields[1].GetUInt8();

        // Check if action value is in range (0-2, see WardenActions enum)
        if (action > WARDEN_ACTION_BAN)
            LOG_ERROR("server", "Warden check override action out of range (ID: %u, action: %u)", checkId, action);
        // Check if check actually exists before accessing the CheckStore vector
        else if (checkId > CheckStore.size())
            LOG_ERROR("server", "Warden check action override for non-existing check (ID: %u, action: %u), skipped", checkId, action);
        else
        {
            CheckStore.at(checkId).Action = WardenActions(action);
            ++count;
        }
    } while (result->NextRow());

    LOG_INFO("server", ">> Loaded %u warden action overrides.", count);
    LOG_INFO("server", " ");
}

WardenCheck const* WardenCheckMgr::GetWardenDataById(uint16 Id)
{
    if (Id < CheckStore.size())
        return &CheckStore.at(Id);

    return nullptr;
}

WardenCheckResult const* WardenCheckMgr::GetWardenResultById(uint16 Id)
{
    CheckResultContainer::const_iterator itr = CheckResultStore.find(Id);
    if (itr != CheckResultStore.end())
    {
        return &itr->second;
    }

    return nullptr;
}

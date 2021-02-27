/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include "Common.h"
#include "Database/DatabaseEnv.h"
#include "Log.h"
#include "Util.h"
#include "Warden.h"
#include "WardenCheckMgr.h"
#include "WorldPacket.h"
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
        sLog->outString(">> Warden disabled, loading checks skipped.");
        sLog->outString();
        return;
    }

    QueryResult result = WorldDatabase.Query("SELECT MAX(id) FROM warden_checks");

    if (!result)
    {
        sLog->outString(">> Loaded 0 Warden checks. DB table `warden_checks` is empty!");
        sLog->outString();
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
            sLog->outError("sql.sql: Warden Lua check with id %u found in `warden_checks`. Lua checks may have four-digit IDs at most. Skipped.", id);
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
            int len = static_cast<int>(checkResult.size()) / 2;
            if (wr.Result.GetNumBytes() < len)
            {
                uint8* temp = new uint8[len];
                memset(temp, 0, len);
                memcpy(temp, wr.Result.AsByteArray().get(), wr.Result.GetNumBytes());
                std::reverse(temp, temp + len);
                wr.Result.SetBinary((uint8*)temp, len);
                delete [] temp;
            }
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
                    sLog->outError("sql.sql: Found over-long Lua check for Warden check with id %u in `warden_checks`. Max length is %u. Skipped.", id, WARDEN_MAX_LUA_CHECK_LENGTH);
                    continue;
                }

                std::string str = fmt::sprintf("%04u", id);
                ASSERT(str.size() == 4);
                std::copy(str.begin(), str.end(), wardenCheck.IdStr.begin());

                CheckIdPool[WARDEN_CHECK_LUA_TYPE].push_back(id);
                break;
            }
            default:
            {
                if (checkType == PAGE_CHECK_A || checkType == PAGE_CHECK_B || checkType == DRIVER_CHECK)
                {
                    wardenCheck.Data.SetHexStr(data.c_str());
                    int len = static_cast<int>(data.size()) / 2;

                    if (wardenCheck.Data.GetNumBytes() < len)
                    {
                        uint8 temp[24];
                        memset(temp, 0, len);
                        memcpy(temp, wardenCheck.Data.AsByteArray().get(), wardenCheck.Data.GetNumBytes());
                        std::reverse(temp, temp + len);
                        wardenCheck.Data.SetBinary((uint8*)temp, len);
                    }
                }

                CheckIdPool[WARDEN_CHECK_OTHER_TYPE].push_back(id);
                break;
            }
        }

        ++count;
    } while (result->NextRow());

    sLog->outString(">> Loaded %u warden checks.", count);
    sLog->outString();
}

void WardenCheckMgr::LoadWardenOverrides()
{
    // Check if Warden is enabled by config before loading anything
    if (!sWorld->getBoolConfig(CONFIG_WARDEN_ENABLED))
    {
        sLog->outString(">> Warden disabled, loading check overrides skipped.");
        sLog->outString();
        return;
    }

    //                                                      0        1
    QueryResult result = CharacterDatabase.Query("SELECT wardenId, action FROM warden_action");

    if (!result)
    {
        sLog->outString(">> Loaded 0 Warden action overrides. DB table `warden_action` is empty!");
        sLog->outString();
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
            sLog->outError("Warden check override action out of range (ID: %u, action: %u)", checkId, action);
        // Check if check actually exists before accessing the CheckStore vector
        else if (checkId > CheckStore.size())
            sLog->outError("Warden check action override for non-existing check (ID: %u, action: %u), skipped", checkId, action);
        else
        {
            CheckStore.at(checkId).Action = WardenActions(action);
            ++count;
        }
    } while (result->NextRow());

    sLog->outString(">> Loaded %u warden action overrides.", count);
    sLog->outString();
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


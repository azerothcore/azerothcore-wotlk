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

#include "WardenCheckMgr.h"
#include "Database/DatabaseEnv.h"
#include "Log.h"
#include "Util.h"
#include "Warden.h"
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
        LOG_INFO("server.loading", ">> Warden disabled, loading checks skipped.");
        LOG_INFO("server.loading", " ");
        return;
    }

    QueryResult result = WorldDatabase.Query("SELECT MAX(id) FROM warden_checks");

    if (!result)
    {
        LOG_WARN("server.loading", ">> Loaded 0 Warden checks. DB table `warden_checks` is empty!");
        LOG_INFO("server.loading", " ");
        return;
    }

    Field* fields = result->Fetch();

    uint16 maxCheckId = fields[0].Get<uint16>();

    CheckStore.resize(maxCheckId + 1);

    //                                    0    1     2     3        4       5      6      7
    result = WorldDatabase.Query("SELECT id, type, data, result, address, length, str, comment FROM warden_checks ORDER BY id ASC");

    uint32 count = 0;
    do
    {
        fields = result->Fetch();

        uint16 id               = fields[0].Get<uint16>();
        uint8 checkType         = fields[1].Get<uint8>();

        if (checkType == LUA_EVAL_CHECK && id > 9999)
        {
            LOG_ERROR("warden", "sql.sql: Warden Lua check with id {} found in `warden_checks`. Lua checks may have four-digit IDs at most. Skipped.", id);
            continue;
        }

        std::string data        = fields[2].Get<std::string>();
        std::string checkResult = fields[3].Get<std::string>();
        uint32 address          = fields[4].Get<uint32>();
        uint8 length            = fields[5].Get<uint8>();
        std::string str         = fields[6].Get<std::string>();
        std::string comment     = fields[7].Get<std::string>();

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
                    LOG_ERROR("warden", "sql.sql: Found over-long Lua check for Warden check with id {} in `warden_checks`. Max length is {}. Skipped.", id, WARDEN_MAX_LUA_CHECK_LENGTH);
                    continue;
                }

                std::string str2 = Acore::StringFormat("{:04}", id);
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

    LOG_INFO("server.loading", ">> Loaded {} warden checks.", count);
    LOG_INFO("server.loading", " ");
}

void WardenCheckMgr::LoadWardenOverrides()
{
    // Check if Warden is enabled by config before loading anything
    if (!sWorld->getBoolConfig(CONFIG_WARDEN_ENABLED))
    {
        LOG_INFO("server.loading", ">> Warden disabled, loading check overrides skipped.");
        LOG_INFO("server.loading", " ");
        return;
    }

    //                                                      0        1
    QueryResult result = CharacterDatabase.Query("SELECT wardenId, action FROM warden_action");

    if (!result)
    {
        LOG_WARN("server.loading", ">> Loaded 0 Warden action overrides. DB table `warden_action` is empty!");
        LOG_INFO("server.loading", " ");
        return;
    }

    uint32 count = 0;

    do
    {
        Field* fields = result->Fetch();

        uint16 checkId = fields[0].Get<uint16>();
        uint8  action  = fields[1].Get<uint8>();

        // Check if action value is in range (0-2, see WardenActions enum)
        if (action > WARDEN_ACTION_BAN)
            LOG_ERROR("warden", "Warden check override action out of range (ID: {}, action: {})", checkId, action);
        // Check if check actually exists before accessing the CheckStore vector
        else if (checkId > CheckStore.size())
            LOG_ERROR("warden", "Warden check action override for non-existing check (ID: {}, action: {}), skipped", checkId, action);
        else
        {
            CheckStore.at(checkId).Action = WardenActions(action);
            ++count;
        }
    } while (result->NextRow());

    LOG_INFO("server.loading", ">> Loaded {} warden action overrides.", count);
    LOG_INFO("server.loading", " ");
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

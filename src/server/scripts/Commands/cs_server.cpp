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

#include "Chat.h"
#include "CommandScript.h"
#include "Common.h"
#include "GameTime.h"
#include "GitRevision.h"
#include "Log.h"
#include "MapMgr.h"
#include "ModuleMgr.h"
#include "MotdMgr.h"
#include "MySQLThreading.h"
#include "Realm.h"
#include "StringConvert.h"
#include "UpdateTime.h"
#include "VMapFactory.h"
#include "VMapMgr2.h"
#include "WorldSessionMgr.h"
#include <boost/version.hpp>
#include <filesystem>
#include <numeric>
#include <openssl/crypto.h>
#include <openssl/opensslv.h>

using namespace Acore::ChatCommands;

class server_commandscript : public CommandScript
{
public:
    server_commandscript() : CommandScript("server_commandscript") { }

    ChatCommandTable GetCommands() const override
    {
        static ChatCommandTable serverIdleRestartCommandTable =
        {
            { "cancel",       HandleServerShutDownCancelCommand, SEC_ADMINISTRATOR, Console::Yes },
            { "",             HandleServerIdleRestartCommand,    SEC_CONSOLE,       Console::Yes }
        };

        static ChatCommandTable serverIdleShutdownCommandTable =
        {
            { "cancel",       HandleServerShutDownCancelCommand, SEC_ADMINISTRATOR, Console::Yes },
            { "",             HandleServerIdleShutDownCommand,   SEC_CONSOLE,       Console::Yes }
        };

        static ChatCommandTable serverRestartCommandTable =
        {
            { "cancel",       HandleServerShutDownCancelCommand, SEC_ADMINISTRATOR, Console::Yes },
            { "",             HandleServerRestartCommand,        SEC_ADMINISTRATOR, Console::Yes }
        };

        static ChatCommandTable serverShutdownCommandTable =
        {
            { "cancel",       HandleServerShutDownCancelCommand, SEC_ADMINISTRATOR, Console::Yes },
            { "",             HandleServerShutDownCommand,       SEC_ADMINISTRATOR, Console::Yes }
        };

        static ChatCommandTable serverSetCommandTable =
        {
            { "loglevel",     HandleServerSetLogLevelCommand,    SEC_CONSOLE,       Console::Yes },
            { "motd",         HandleServerSetMotdCommand,        SEC_ADMINISTRATOR, Console::Yes },
            { "closed",       HandleServerSetClosedCommand,      SEC_CONSOLE,       Console::Yes },
        };

        static ChatCommandTable serverCommandTable =
        {
            { "corpses",      HandleServerCorpsesCommand,        SEC_GAMEMASTER,    Console::Yes },
            { "debug",        HandleServerDebugCommand,          SEC_ADMINISTRATOR, Console::Yes },
            { "exit",         HandleServerExitCommand,           SEC_CONSOLE,       Console::Yes },
            { "idlerestart",  serverIdleRestartCommandTable },
            { "idleshutdown", serverIdleShutdownCommandTable },
            { "info",         HandleServerInfoCommand,           SEC_PLAYER,        Console::Yes },
            { "motd",         HandleServerMotdCommand,           SEC_PLAYER,        Console::Yes },
            { "restart",      serverRestartCommandTable },
            { "shutdown",     serverShutdownCommandTable },
            { "set",          serverSetCommandTable }
        };

        static ChatCommandTable commandTable =
        {
            { "server", serverCommandTable }
        };

        return commandTable;
    }

    // Triggering corpses expire check in world
    static bool HandleServerCorpsesCommand(ChatHandler* /*handler*/)
    {
        sMapMgr->DoForAllMaps([](Map* map)
        {
            map->RemoveOldCorpses();
        });
        return true;
    }

    static bool HandleServerDebugCommand(ChatHandler* handler)
    {
        uint16 worldPort = uint16(sWorld->getIntConfig(CONFIG_PORT_WORLD));
        std::string dbPortOutput;

        {
            uint16 dbPort = 0;
            if (QueryResult res = LoginDatabase.Query("SELECT port FROM realmlist WHERE id = {}", realm.Id.Realm))
                dbPort = (*res)[0].Get<uint16>();

            if (dbPort)
                dbPortOutput = Acore::StringFormat("Realmlist (Realm Id: {}) configured in port {}", realm.Id.Realm, dbPort);
            else
                dbPortOutput = Acore::StringFormat("Realm Id: {} not found in `realmlist` table. Please check your setup", realm.Id.Realm);
        }

        HandleServerInfoCommand(handler);

        handler->PSendSysMessage("Using SSL version: {} (library: {})", OPENSSL_VERSION_TEXT, OpenSSL_version(OPENSSL_VERSION));
        handler->PSendSysMessage("Using Boost version: {}.{}.{}", BOOST_VERSION / 100000, BOOST_VERSION / 100 % 1000, BOOST_VERSION % 100);
        handler->PSendSysMessage("Using CMake version: {}", GitRevision::GetCMakeVersion());

        handler->PSendSysMessage("Using MySQL version: {}", MySQL::GetLibraryVersion());
        handler->PSendSysMessage("Found MySQL Executable: {}", GitRevision::GetMySQLExecutable());

        handler->PSendSysMessage("Compiled on: {}", GitRevision::GetHostOSVersion());

        handler->PSendSysMessage("Worldserver listening connections on port {}", worldPort);
        handler->PSendSysMessage("{}", dbPortOutput);

        bool vmapIndoorCheck = sWorld->getBoolConfig(CONFIG_VMAP_INDOOR_CHECK);
        bool vmapLOSCheck = VMAP::VMapFactory::createOrGetVMapMgr()->isLineOfSightCalcEnabled();
        bool vmapHeightCheck = VMAP::VMapFactory::createOrGetVMapMgr()->isHeightCalcEnabled();

        bool mmapEnabled = sWorld->getBoolConfig(CONFIG_ENABLE_MMAPS);

        std::string dataDir = sWorld->GetDataPath();
        std::vector<std::string> subDirs;
        subDirs.emplace_back("maps");
        if (vmapIndoorCheck || vmapLOSCheck || vmapHeightCheck)
        {
            handler->PSendSysMessage("VMAPs status: Enabled. LineOfSight: {}, getHeight: {}, indoorCheck: {}", vmapLOSCheck, vmapHeightCheck, vmapIndoorCheck);
            subDirs.emplace_back("vmaps");
        }
        else
            handler->SendSysMessage("VMAPs status: Disabled");

        if (mmapEnabled)
        {
            handler->SendSysMessage("MMAPs status: Enabled");
            subDirs.emplace_back("mmaps");
        }
        else
            handler->SendSysMessage("MMAPs status: Disabled");

        for (std::string const& subDir : subDirs)
        {
            std::filesystem::path mapPath(dataDir);
            mapPath /= subDir;

            if (!std::filesystem::exists(mapPath))
            {
                handler->PSendSysMessage("{} directory doesn't exist!. Using path: {}", subDir, mapPath.generic_string());
                continue;
            }

            auto end = std::filesystem::directory_iterator();
            std::size_t folderSize = std::accumulate(std::filesystem::directory_iterator(mapPath), end, std::size_t(0), [](std::size_t val, std::filesystem::path const& mapFile)
            {
                if (std::filesystem::is_regular_file(mapFile))
                    val += std::filesystem::file_size(mapFile);
                return val;
            });

            handler->PSendSysMessage("{} directory located in {}. Total size: {} bytes", subDir, mapPath.generic_string(), folderSize);
        }

        LocaleConstant defaultLocale = sWorld->GetDefaultDbcLocale();
        uint32 availableLocalesMask = (1 << defaultLocale);

        for (uint8 i = 0; i < TOTAL_LOCALES; ++i)
        {
            LocaleConstant locale = static_cast<LocaleConstant>(i);
            if (locale == defaultLocale)
                continue;

            if (sWorld->GetAvailableDbcLocale(locale) != defaultLocale)
                availableLocalesMask |= (1 << locale);
        }

        std::string availableLocales;
        for (uint8 i = 0; i < TOTAL_LOCALES; ++i)
        {
            if (!(availableLocalesMask & (1 << i)))
                continue;

            availableLocales += localeNames[i];
            if (i != TOTAL_LOCALES - 1)
                availableLocales += " ";
        }

        handler->PSendSysMessage("Default DBC locale: {}.\nAll available DBC locales: {}", localeNames[defaultLocale], availableLocales);

        handler->PSendSysMessage("Using World DB: {}", sWorld->GetDBVersion());

        std::string lldb = "No updates found!";
        if (QueryResult resL = LoginDatabase.Query("SELECT name FROM updates ORDER BY name DESC LIMIT 1"))
        {
            Field* fields = resL->Fetch();
            lldb = fields[0].Get<std::string>();
        }
        std::string lcdb = "No updates found!";
        if (QueryResult resC = CharacterDatabase.Query("SELECT name FROM updates ORDER BY name DESC LIMIT 1"))
        {
            Field* fields = resC->Fetch();
            lcdb = fields[0].Get<std::string>();
        }
        std::string lwdb = "No updates found!";
        if (QueryResult resW = WorldDatabase.Query("SELECT name FROM updates ORDER BY name DESC LIMIT 1"))
        {
            Field* fields = resW->Fetch();
            lwdb = fields[0].Get<std::string>();
        }

        handler->PSendSysMessage("Latest LoginDatabase update: {}", lldb);
        handler->PSendSysMessage("Latest CharacterDatabase update: {}", lcdb);
        handler->PSendSysMessage("Latest WorldDatabase update: {}", lwdb);

        handler->PSendSysMessage("LoginDatabase queue size: {}", LoginDatabase.QueueSize());
        handler->PSendSysMessage("CharacterDatabase queue size: {}", CharacterDatabase.QueueSize());
        handler->PSendSysMessage("WorldDatabase queue size: {}", WorldDatabase.QueueSize());

        if (Acore::Module::GetEnableModulesList().empty())
            handler->PSendSysMessage("No modules are enabled");
        else
            handler->PSendSysMessage("List of enabled modules:");

        for (auto const& modName : Acore::Module::GetEnableModulesList())
        {
            handler->PSendSysMessage("|- {}", modName);
        }

        return true;
    }

    static bool HandleServerInfoCommand(ChatHandler* handler)
    {
        std::string realmName = sWorld->GetRealmName();
        uint32 playerCount = sWorldSessionMgr->GetPlayerCount();
        uint32 activeSessionCount = sWorldSessionMgr->GetActiveSessionCount();
        uint32 queuedSessionCount = sWorldSessionMgr->GetQueuedSessionCount();
        uint32 connPeak = sWorldSessionMgr->GetMaxActiveSessionCount();

        handler->PSendSysMessage("{}", GitRevision::GetFullVersion());
        if (!queuedSessionCount)
            handler->PSendSysMessage("Connected players: {}. Characters in world: {}.", activeSessionCount, playerCount);
        else
            handler->PSendSysMessage("Connected players: {}. Characters in world: {}. Queue: {}.", activeSessionCount, playerCount, queuedSessionCount);

        handler->PSendSysMessage("Connection peak: {}.", connPeak);
        handler->PSendSysMessage(LANG_UPTIME, secsToTimeString(GameTime::GetUptime().count()));
        handler->PSendSysMessage("Update time diff: {}ms. Last {} diffs summary:", sWorldUpdateTime.GetLastUpdateTime(), sWorldUpdateTime.GetDatasetSize());
        handler->PSendSysMessage("|- Mean: {}ms", sWorldUpdateTime.GetAverageUpdateTime());
        handler->PSendSysMessage("|- Median: {}ms", sWorldUpdateTime.GetPercentile(50));
        handler->PSendSysMessage("|- Percentiles (95, 99, max): {}ms, {}ms, {}ms",
                                 sWorldUpdateTime.GetPercentile(95),
                                 sWorldUpdateTime.GetPercentile(99),
                                 sWorldUpdateTime.GetPercentile(100));

        //! Can't use sWorld->ShutdownMsg here in case of console command
        if (sWorld->IsShuttingDown())
            handler->PSendSysMessage(LANG_SHUTDOWN_TIMELEFT, secsToTimeString(sWorld->GetShutDownTimeLeft()).append("."));

        return true;
    }
    // Display the 'Message of the day' for the realm
    static bool HandleServerMotdCommand(ChatHandler* handler)
    {
        handler->PSendSysMessage(LANG_MOTD_CURRENT);
        for (uint32 i = 0; i < TOTAL_LOCALES; ++i)
            handler->PSendSysMessage(LANG_GENERIC_TWO_CURLIES_WITH_COLON, GetNameByLocaleConstant(LocaleConstant(i)), sMotdMgr->GetMotd(LocaleConstant(i)));
        return true;
    }

    static bool HandleServerShutDownCancelCommand(ChatHandler* /*handler*/)
    {
        sWorld->ShutdownCancel();

        return true;
    }

    static bool HandleServerShutDownCommand(ChatHandler* handler, std::string time, Optional<int32> exitCode, Tail reason)
    {
        std::wstring wReason   = std::wstring();
        std::string  strReason = std::string();

        if (time.empty())
        {
            return false;
        }

        if (Acore::StringTo<int32>(time).value_or(0) < 0)
        {
            handler->SendErrorMessage(LANG_BAD_VALUE);
            return false;
        }

        if (!reason.empty())
        {
            if (!Utf8toWStr(reason, wReason))
            {
                return false;
            }

            if (!WStrToUtf8(wReason, strReason))
            {
                return false;
            }
        }

        int32 delay = TimeStringToSecs(time);
        if (delay <= 0)
        {
            delay = Acore::StringTo<int32>(time).value_or(0);
        }

        if (delay <= 0)
        {
            handler->SendErrorMessage(LANG_BAD_VALUE);
            return false;
        }

        if (exitCode && *exitCode >= 0 && *exitCode <= 125)
        {
            sWorld->ShutdownServ(delay, 0, *exitCode);
        }
        else
        {
            sWorld->ShutdownServ(delay, 0, SHUTDOWN_EXIT_CODE, strReason);
        }

        return true;
    }

    static bool HandleServerRestartCommand(ChatHandler* handler, std::string time, Optional<int32> exitCode, Tail reason)
    {
        std::wstring wReason = std::wstring();
        std::string strReason    = std::string();

        if (time.empty())
        {
            return false;
        }

        if (Acore::StringTo<int32>(time).value_or(0) < 0)
        {
            handler->SendErrorMessage(LANG_BAD_VALUE);
            return false;
        }

        if (!reason.empty())
        {
            if (!Utf8toWStr(reason, wReason))
            {
                return false;
            }

            if (!WStrToUtf8(wReason, strReason))
            {
                return false;
            }
        }

        int32 delay = TimeStringToSecs(time);
        if (delay <= 0)
        {
            delay = Acore::StringTo<int32>(time).value_or(0);
        }

        if (delay <= 0)
        {
            handler->SendErrorMessage(LANG_BAD_VALUE);
            return false;
        }

        if (exitCode && *exitCode >= 0 && *exitCode <= 125)
        {
            sWorld->ShutdownServ(delay, SHUTDOWN_MASK_RESTART, *exitCode);
        }
        else
        {
            sWorld->ShutdownServ(delay, SHUTDOWN_MASK_RESTART, RESTART_EXIT_CODE, strReason);
        }

        return true;
    }

    static bool HandleServerIdleRestartCommand(ChatHandler* handler, std::string time, Optional<int32> exitCode, Tail reason)
    {
        std::wstring wReason   = std::wstring();
        std::string  strReason = std::string();

        if (time.empty())
        {
            return false;
        }

        if (Acore::StringTo<int32>(time).value_or(0) < 0)
        {
            handler->SendErrorMessage(LANG_BAD_VALUE);
            return false;
        }

        if (!reason.empty())
        {
            if (!Utf8toWStr(reason, wReason))
            {
                return false;
            }

            if (!WStrToUtf8(wReason, strReason))
            {
                return false;
            }
        }

        int32 delay = TimeStringToSecs(time);
        if (delay <= 0)
        {
            delay = Acore::StringTo<int32>(time).value_or(0);
        }

        if (delay <= 0)
        {
            handler->SendErrorMessage(LANG_BAD_VALUE);
            return false;
        }

        if (exitCode && *exitCode >= 0 && *exitCode <= 125)
        {
            sWorld->ShutdownServ(delay, SHUTDOWN_MASK_RESTART | SHUTDOWN_MASK_IDLE, *exitCode);
        }
        else
        {
            sWorld->ShutdownServ(delay, SHUTDOWN_MASK_RESTART | SHUTDOWN_MASK_IDLE, RESTART_EXIT_CODE, strReason);
        }

        return true;
    }

    static bool HandleServerIdleShutDownCommand(ChatHandler* handler, std::string time, Optional<int32> exitCode, Tail reason)
    {
        std::wstring wReason   = std::wstring();
        std::string  strReason = std::string();

        if (time.empty())
        {
            return false;
        }

        if (Acore::StringTo<int32>(time).value_or(0) < 0)
        {
            handler->SendErrorMessage(LANG_BAD_VALUE);
            return false;
        }

        if (!reason.empty())
        {
            if (!Utf8toWStr(reason, wReason))
            {
                return false;
            }

            if (!WStrToUtf8(wReason, strReason))
            {
                return false;
            }
        }

        int32 delay = TimeStringToSecs(time);
        if (delay <= 0)
        {
            delay = Acore::StringTo<int32>(time).value_or(0);
        }

        if (delay <= 0)
        {
            handler->SendErrorMessage(LANG_BAD_VALUE);
            return false;
        }

        if (exitCode && *exitCode >= 0 && *exitCode <= 125)
        {
            sWorld->ShutdownServ(delay, SHUTDOWN_MASK_IDLE, *exitCode);
        }
        else
        {
            sWorld->ShutdownServ(delay, SHUTDOWN_MASK_IDLE, SHUTDOWN_EXIT_CODE, strReason);
        }

        return true;
    }

    // Exit the realm
    static bool HandleServerExitCommand(ChatHandler* handler)
    {
        handler->SendSysMessage(LANG_COMMAND_EXIT);
        World::StopNow(SHUTDOWN_EXIT_CODE);
        return true;
    }

    // Define the 'Message of the day' for the realm
    static bool HandleServerSetMotdCommand(ChatHandler* handler, Optional<int32> realmId, std::string locale, Tail motd)
    {
        std::wstring wMotd = std::wstring();
        std::string strMotd = std::string();

        // Default realmId to the current realm if not provided
        if (!realmId)
            realmId = static_cast<int32>(realm.Id.Realm);

        // Determine the locale; default to "enUS" if not provided
        LocaleConstant localeConstant;
        if (IsLocaleValid(locale))
            localeConstant = GetLocaleByName(locale);
        else
        {
            handler->SendErrorMessage("locale ({}) is not valid. Valid locales: enUS, koKR, frFR, deDE, zhCN, zhWE, esES, esMX, ruRU.", locale);
            return false;
        }

        if (motd.empty())
            return false;

        // Convert the concatenated motdString to UTF-8 and ensure encoding consistency
        if (!Utf8toWStr(motd, wMotd))
            return false;

        if (!WStrToUtf8(wMotd, strMotd))
            return false;

        // Start a transaction for the database operations
        LoginDatabaseTransaction trans = LoginDatabase.BeginTransaction();

        if (localeConstant == LOCALE_enUS)
        {
            // Insert or update in the main motd table for enUS
            LoginDatabasePreparedStatement* stmt = LoginDatabase.GetPreparedStatement(LOGIN_REP_MOTD);
            stmt->SetData(0, realmId.value());  // realmId for insertion
            stmt->SetData(1, strMotd);          // motd text for insertion
            trans->Append(stmt);
        }
        else
        {
            // Insert or update in the motd_localized table for other locales
            LoginDatabasePreparedStatement* stmt = LoginDatabase.GetPreparedStatement(LOGIN_REP_MOTD_LOCALE);
            stmt->SetData(0, realmId.value());  // realmId for insertion
            stmt->SetData(1, locale);           // locale for insertion
            stmt->SetData(2, strMotd);          // motd text for insertion
            trans->Append(stmt);
        }

        // Commit the transaction & update db
        LoginDatabase.CommitTransaction(trans);

        sMotdMgr->SetMotd(strMotd, localeConstant);
        handler->PSendSysMessage(LANG_MOTD_NEW, realmId.value(), locale, strMotd);
        return true;
    }

    // Set whether we accept new clients
    static bool HandleServerSetClosedCommand(ChatHandler* handler, Optional<std::string> args)
    {
        if (StringStartsWith("on", *args))
        {
            handler->SendSysMessage(LANG_WORLD_CLOSED);
            sWorld->SetClosed(true);
            return true;
        }
        else if (StringStartsWith("off", *args))
        {
            handler->SendSysMessage(LANG_WORLD_OPENED);
            sWorld->SetClosed(false);
            return true;
        }

        handler->SendErrorMessage(LANG_USE_BOL);
        return false;
    }

    // Set the level of logging
    static bool HandleServerSetLogLevelCommand(ChatHandler* /*handler*/, bool isLogger, std::string const& name, int32 level)
    {
        sLog->SetLogLevel(name, level, isLogger);
        return true;
    }
};

void AddSC_server_commandscript()
{
    new server_commandscript();
}

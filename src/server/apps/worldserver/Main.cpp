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

/// \addtogroup Acored Acore Daemon
/// @{
/// \file

#include "ACSoap.h"
#include "AppenderDB.h"
#include "AsyncAcceptor.h"
#include "AsyncAuctionListing.h"
#include "Banner.h"
#include "BattlegroundMgr.h"
#include "BigNumber.h"
#include "CliRunnable.h"
#include "Common.h"
#include "Config.h"
#include "DatabaseEnv.h"
#include "DatabaseLoader.h"
#include "DeadlineTimer.h"
#include "GitRevision.h"
#include "IoContext.h"
#include "MapMgr.h"
#include "Metric.h"
#include "ModuleMgr.h"
#include "ModulesScriptLoader.h"
#include "MySQLThreading.h"
#include "OpenSSLCrypto.h"
#include "OutdoorPvPMgr.h"
#include "ProcessPriority.h"
#include "RASession.h"
#include "RealmList.h"
#include "Resolver.h"
#include "ScriptLoader.h"
#include "ScriptMgr.h"
#include "SecretMgr.h"
#include "SharedDefines.h"
#include "World.h"
#include "WorldSocket.h"
#include "WorldSocketMgr.h"
#include <boost/asio/signal_set.hpp>
#include <boost/program_options.hpp>
#include <csignal>
#include <filesystem>
#include <iostream>
#include <openssl/crypto.h>
#include <openssl/opensslv.h>

#if AC_PLATFORM == AC_PLATFORM_WINDOWS
#include "ServiceWin32.h"
char serviceName[] = "worldserver";
char serviceLongName[] = "AzerothCore world service";
char serviceDescription[] = "AzerothCore World of Warcraft emulator world service";
/*
 * -1 - not in service mode
 *  0 - stopped
 *  1 - running
 *  2 - paused
 */
int m_ServiceStatus = -1;

#include <boost/dll/shared_library.hpp>
#include <timeapi.h>
#endif

#ifndef _ACORE_CORE_CONFIG
#define _ACORE_CORE_CONFIG "worldserver.conf"
#endif

using namespace boost::program_options;
namespace fs = std::filesystem;

class FreezeDetector
{
public:
    FreezeDetector(Acore::Asio::IoContext& ioContext, uint32 maxCoreStuckTime)
        : _timer(ioContext), _worldLoopCounter(0), _lastChangeMsTime(getMSTime()), _maxCoreStuckTimeInMs(maxCoreStuckTime) { }

    static void Start(std::shared_ptr<FreezeDetector> const& freezeDetector)
    {
        freezeDetector->_timer.expires_from_now(boost::posix_time::seconds(5));
        freezeDetector->_timer.async_wait(std::bind(&FreezeDetector::Handler, std::weak_ptr<FreezeDetector>(freezeDetector), std::placeholders::_1));
    }

    static void Handler(std::weak_ptr<FreezeDetector> freezeDetectorRef, boost::system::error_code const& error);

private:
    Acore::Asio::DeadlineTimer _timer;
    uint32 _worldLoopCounter;
    uint32 _lastChangeMsTime;
    uint32 _maxCoreStuckTimeInMs;
};

void SignalHandler(boost::system::error_code const& error, int signalNumber);
void ClearOnlineAccounts();
bool StartDB();
void StopDB();
bool LoadRealmInfo(Acore::Asio::IoContext& ioContext);
AsyncAcceptor* StartRaSocketAcceptor(Acore::Asio::IoContext& ioContext);
void ShutdownCLIThread(std::thread* cliThread);
void AuctionListingRunnable();
void WorldUpdateLoop();
variables_map GetConsoleArguments(int argc, char** argv, fs::path& configFile, [[maybe_unused]] std::string& cfg_service);

/// Launch the Azeroth server
int main(int argc, char** argv)
{
    Acore::Impl::CurrentServerProcessHolder::_type = SERVER_PROCESS_WORLDSERVER;
    signal(SIGABRT, &Acore::AbortHandler);

    // Command line parsing
    auto configFile = fs::path(sConfigMgr->GetConfigPath() + std::string(_ACORE_CORE_CONFIG));
    std::string configService;
    auto vm = GetConsoleArguments(argc, argv, configFile, configService);

    // exit if help or version is enabled
    if (vm.count("help"))
        return 0;

#if AC_PLATFORM == AC_PLATFORM_WINDOWS
    if (configService.compare("install") == 0)
        return WinServiceInstall() == true ? 0 : 1;
    else if (configService.compare("uninstall") == 0)
        return WinServiceUninstall() == true ? 0 : 1;
    else if (configService.compare("run") == 0)
        WinServiceRun();

    Optional<UINT> newTimerResolution;
    boost::system::error_code dllError;
    std::shared_ptr<boost::dll::shared_library> winmm(new boost::dll::shared_library("winmm.dll", dllError, boost::dll::load_mode::search_system_folders), [&](boost::dll::shared_library* lib)
    {
        try
        {
            if (newTimerResolution)
                lib->get<decltype(timeEndPeriod)>("timeEndPeriod")(*newTimerResolution);
        }
        catch (std::exception const&)
        {
            // ignore
        }

        delete lib;
    });

    if (winmm->is_loaded())
    {
        try
        {
            auto timeGetDevCapsPtr = winmm->get<decltype(timeGetDevCaps)>("timeGetDevCaps");
            // setup timer resolution
            TIMECAPS timeResolutionLimits;
            if (timeGetDevCapsPtr(&timeResolutionLimits, sizeof(TIMECAPS)) == TIMERR_NOERROR)
            {
                auto timeBeginPeriodPtr = winmm->get<decltype(timeBeginPeriod)>("timeBeginPeriod");
                newTimerResolution = std::min(std::max(timeResolutionLimits.wPeriodMin, 1u), timeResolutionLimits.wPeriodMax);
                timeBeginPeriodPtr(*newTimerResolution);
            }
        }
        catch (std::exception const& e)
        {
            printf("Failed to initialize timer resolution: %s\n", e.what());
        }
    }

#endif

    // Add file and args in config
    sConfigMgr->Configure(configFile.generic_string(), {argv, argv + argc}, CONFIG_FILE_LIST);

    if (!sConfigMgr->LoadAppConfigs())
        return 1;

    std::shared_ptr<Acore::Asio::IoContext> ioContext = std::make_shared<Acore::Asio::IoContext>();

    // Init all logs
    sLog->RegisterAppender<AppenderDB>();
    // If logs are supposed to be handled async then we need to pass the IoContext into the Log singleton
    sLog->Initialize(sConfigMgr->GetOption<bool>("Log.Async.Enable", false) ? ioContext.get() : nullptr);

    Acore::Banner::Show("worldserver-daemon",
        [](std::string_view text)
        {
            LOG_INFO("server.worldserver", text);
        },
        []()
        {
            LOG_INFO("server.worldserver", "> Using configuration file       {}", sConfigMgr->GetFilename());
            LOG_INFO("server.worldserver", "> Using SSL version:             {} (library: {})", OPENSSL_VERSION_TEXT, OpenSSL_version(OPENSSL_VERSION));
            LOG_INFO("server.worldserver", "> Using Boost version:           {}.{}.{}", BOOST_VERSION / 100000, BOOST_VERSION / 100 % 1000, BOOST_VERSION % 100);
        });

    OpenSSLCrypto::threadsSetup();

    std::shared_ptr<void> opensslHandle(nullptr, [](void*) { OpenSSLCrypto::threadsCleanup(); });

    // Seed the OpenSSL's PRNG here.
    // That way it won't auto-seed when calling BigNumber::SetRand and slow down the first world login
    BigNumber seed;
    seed.SetRand(16 * 8);

    /// worldserver PID file creation
    std::string pidFile = sConfigMgr->GetOption<std::string>("PidFile", "");
    if (!pidFile.empty())
    {
        if (uint32 pid = CreatePIDFile(pidFile))
            LOG_ERROR("server", "Daemon PID: {}\n", pid); // outError for red color in console
        else
        {
            LOG_ERROR("server", "Cannot create PID file {} (possible error: permission)\n", pidFile);
            return 1;
        }
    }

    // Set signal handlers (this must be done before starting IoContext threads, because otherwise they would unblock and exit)
    boost::asio::signal_set signals(*ioContext, SIGINT, SIGTERM);
#if AC_PLATFORM == AC_PLATFORM_WINDOWS
    signals.add(SIGBREAK);
#endif
    signals.async_wait(SignalHandler);

    // Start the Boost based thread pool
    int numThreads = sConfigMgr->GetOption<int32>("ThreadPool", 1);
    std::shared_ptr<std::vector<std::thread>> threadPool(new std::vector<std::thread>(), [ioContext](std::vector<std::thread>* del)
    {
        ioContext->stop();
        for (std::thread& thr : *del)
            thr.join();

        delete del;
    });

    if (numThreads < 1)
    {
        numThreads = 1;
    }

    for (int i = 0; i < numThreads; ++i)
    {
        threadPool->push_back(std::thread([ioContext]()
        {
            ioContext->run();
        }));
    }

    // Set process priority according to configuration settings
    SetProcessPriority("server.worldserver", sConfigMgr->GetOption<int32>(CONFIG_PROCESSOR_AFFINITY, 0), sConfigMgr->GetOption<bool>(CONFIG_HIGH_PRIORITY, false));

    // Loading modules configs before scripts
    sConfigMgr->LoadModulesConfigs();

    sScriptMgr->SetScriptLoader(AddScripts);
    sScriptMgr->SetModulesLoader(AddModulesScripts);

    std::shared_ptr<void> sScriptMgrHandle(nullptr, [](void*)
    {
        sScriptMgr->Unload();
        //sScriptReloadMgr->Unload();
    });

    LOG_INFO("server.loading", "Initializing Scripts...");
    sScriptMgr->Initialize();

    // Start the databases
    if (!StartDB())
        return 1;

    std::shared_ptr<void> dbHandle(nullptr, [](void*) { StopDB(); });

    // set server offline (not connectable)
    LoginDatabase.DirectExecute("UPDATE realmlist SET flag = (flag & ~{}) | {} WHERE id = '{}'", REALM_FLAG_OFFLINE, REALM_FLAG_VERSION_MISMATCH, realm.Id.Realm);

    LoadRealmInfo(*ioContext);

    sMetric->Initialize(realm.Name, *ioContext, []()
    {
        METRIC_VALUE("online_players", sWorld->GetPlayerCount());
        METRIC_VALUE("db_queue_login", uint64(LoginDatabase.QueueSize()));
        METRIC_VALUE("db_queue_character", uint64(CharacterDatabase.QueueSize()));
        METRIC_VALUE("db_queue_world", uint64(WorldDatabase.QueueSize()));
    });

    METRIC_EVENT("events", "Worldserver started", "");

    std::shared_ptr<void> sMetricHandle(nullptr, [](void*)
    {
        METRIC_EVENT("events", "Worldserver shutdown", "");
        sMetric->Unload();
    });

    Acore::Module::SetEnableModulesList(AC_MODULES_LIST);

    ///- Initialize the World
    sSecretMgr->Initialize();
    sWorld->SetInitialWorldSettings();

    std::shared_ptr<void> mapManagementHandle(nullptr, [](void*)
    {
        // unload battleground templates before different singletons destroyed
        sBattlegroundMgr->DeleteAllBattlegrounds();

        sOutdoorPvPMgr->Die();                     // unload it before MapMgr
        sMapMgr->UnloadAll();                      // unload all grids (including locked in memory)

        sScriptMgr->OnAfterUnloadAllMaps();
    });

    // Start the Remote Access port (acceptor) if enabled
    std::unique_ptr<AsyncAcceptor> raAcceptor;
    if (sConfigMgr->GetOption<bool>("Ra.Enable", false))
    {
        raAcceptor.reset(StartRaSocketAcceptor(*ioContext));
    }

    // Start soap serving thread if enabled
    std::shared_ptr<std::thread> soapThread;
    if (sConfigMgr->GetOption<bool>("SOAP.Enabled", false))
    {
        soapThread.reset(new std::thread(ACSoapThread, sConfigMgr->GetOption<std::string>("SOAP.IP", "127.0.0.1"), uint16(sConfigMgr->GetOption<int32>("SOAP.Port", 7878))),
            [](std::thread* thr)
        {
            thr->join();
            delete thr;
        });
    }

    // Launch the worldserver listener socket
    uint16 worldPort = uint16(sWorld->getIntConfig(CONFIG_PORT_WORLD));
    std::string worldListener = sConfigMgr->GetOption<std::string>("BindIP", "0.0.0.0");

    int networkThreads = sConfigMgr->GetOption<int32>("Network.Threads", 1);

    if (networkThreads <= 0)
    {
        LOG_ERROR("server.worldserver", "Network.Threads must be greater than 0");
        World::StopNow(ERROR_EXIT_CODE);
        return 1;
    }

    if (!sWorldSocketMgr.StartWorldNetwork(*ioContext, worldListener, worldPort, networkThreads))
    {
        LOG_ERROR("server.worldserver", "Failed to initialize network");
        World::StopNow(ERROR_EXIT_CODE);
        return 1;
    }

    std::shared_ptr<void> sWorldSocketMgrHandle(nullptr, [](void*)
    {
        sWorld->KickAll();              // save and kick all players
        sWorld->UpdateSessions(1);      // real players unload required UpdateSessions call

        sWorldSocketMgr.StopNetwork();

        ///- Clean database before leaving
        ClearOnlineAccounts();
    });

    // Set server online (allow connecting now)
    LoginDatabase.DirectExecute("UPDATE realmlist SET flag = flag & ~{}, population = 0 WHERE id = '{}'", REALM_FLAG_VERSION_MISMATCH, realm.Id.Realm);
    realm.PopulationLevel = 0.0f;
    realm.Flags = RealmFlags(realm.Flags & ~uint32(REALM_FLAG_VERSION_MISMATCH));

    // Start the freeze check callback cycle in 5 seconds (cycle itself is 1 sec)
    std::shared_ptr<FreezeDetector> freezeDetector;
    if (int32 coreStuckTime = sConfigMgr->GetOption<int32>("MaxCoreStuckTime", 60))
    {
        freezeDetector = std::make_shared<FreezeDetector>(*ioContext, coreStuckTime * 1000);
        FreezeDetector::Start(freezeDetector);
        LOG_INFO("server.worldserver", "Starting up anti-freeze thread ({} seconds max stuck time)...", coreStuckTime);
    }

    LOG_INFO("server.worldserver", "{} (worldserver-daemon) ready...", GitRevision::GetFullVersion());

    sScriptMgr->OnStartup();

// Be kind and warn people of EOL deprecation :)
#if !defined(MARIADB_VERSION_ID)
    if (MySQL::GetLibraryVersion() < 80000)
        LOG_WARN("server", "WARNING: You are using MySQL version 5.7 which is soon EOL!\nThis version will be deprecated. Consider upgrading to MySQL 8.0 or 8.1!");
#endif

    // Launch CliRunnable thread
    std::shared_ptr<std::thread> cliThread;
#if AC_PLATFORM == AC_PLATFORM_WINDOWS
    if (sConfigMgr->GetOption<bool>("Console.Enable", true) && (m_ServiceStatus == -1)/* need disable console in service mode*/)
#else
    if (sConfigMgr->GetOption<bool>("Console.Enable", true))
#endif
    {
        cliThread.reset(new std::thread(CliThread), &ShutdownCLIThread);
    }

    // Launch auction listing thread
    std::shared_ptr<std::thread> auctionListingThread;
    auctionListingThread.reset(new std::thread(AuctionListingRunnable),
        [](std::thread* thr)
    {
        thr->join();
        delete thr;
    });

    WorldUpdateLoop();

    // Shutdown starts here
    threadPool.reset();

    sLog->SetSynchronous();

    sScriptMgr->OnShutdown();

    // set server offline
    LoginDatabase.DirectExecute("UPDATE realmlist SET flag = flag | {} WHERE id = '{}'", REALM_FLAG_OFFLINE, realm.Id.Realm);

    LOG_INFO("server.worldserver", "Halting process...");

    // 0 - normal shutdown
    // 1 - shutdown at error
    // 2 - restart command used, this code can be used by restarter for restart AzerothCore

    return World::GetExitCode();
}

/// Initialize connection to the databases
bool StartDB()
{
    MySQL::Library_Init();

    // Load databases
    DatabaseLoader loader("server.worldserver", DatabaseLoader::DATABASE_NONE, AC_MODULES_LIST);
    loader
        .AddDatabase(LoginDatabase, "Login")
        .AddDatabase(CharacterDatabase, "Character")
        .AddDatabase(WorldDatabase, "World");

    if (!loader.Load())
        return false;

    ///- Get the realm Id from the configuration file
    realm.Id.Realm = sConfigMgr->GetOption<uint32>("RealmID", 0);
    if (!realm.Id.Realm)
    {
        LOG_ERROR("server.worldserver", "Realm ID not defined in configuration file");
        return false;
    }
    else if (realm.Id.Realm > 255)
    {
        /*
         * Due to the client only being able to read a realm.Id.Realm
         * with a size of uint8 we can "only" store up to 255 realms
         * anything further the client will behave anormaly
        */
        LOG_ERROR("server.worldserver", "Realm ID must range from 1 to 255");
        return false;
    }

    LOG_INFO("server.loading", "Loading World Information...");
    LOG_INFO("server.loading", "> RealmID:              {}", realm.Id.Realm);

    ///- Clean the database before starting
    ClearOnlineAccounts();

    ///- Insert version info into DB
    WorldDatabase.Execute("UPDATE version SET core_version = '{}', core_revision = '{}'", GitRevision::GetFullVersion(), GitRevision::GetHash());        // One-time query

    sWorld->LoadDBVersion();

    LOG_INFO("server.loading", "> Version DB world:     {}", sWorld->GetDBVersion());

    sScriptMgr->OnAfterDatabasesLoaded(loader.GetUpdateFlags());

    return true;
}

void StopDB()
{
    CharacterDatabase.Close();
    WorldDatabase.Close();
    LoginDatabase.Close();

    MySQL::Library_End();
}

/// Clear 'online' status for all accounts with characters in this realm
void ClearOnlineAccounts()
{
    // Reset online status for all accounts with characters on the current realm
    // pussywizard: tc query would set online=0 even if logged in on another realm >_>
    LoginDatabase.DirectExecute("UPDATE account SET online = 0 WHERE online = {}", realm.Id.Realm);

    // Reset online status for all characters
    CharacterDatabase.DirectExecute("UPDATE characters SET online = 0 WHERE online <> 0");
}

void ShutdownCLIThread(std::thread* cliThread)
{
    if (cliThread)
    {
#ifdef _WIN32
        // First try to cancel any I/O in the CLI thread
        if (!CancelSynchronousIo(cliThread->native_handle()))
        {
            // if CancelSynchronousIo() fails, print the error and try with old way
            DWORD errorCode = GetLastError();
            LPCSTR errorBuffer;

            DWORD formatReturnCode = FormatMessage(FORMAT_MESSAGE_FROM_SYSTEM | FORMAT_MESSAGE_ALLOCATE_BUFFER | FORMAT_MESSAGE_IGNORE_INSERTS,
                nullptr, errorCode, 0, (LPTSTR)&errorBuffer, 0, nullptr);
            if (!formatReturnCode)
                errorBuffer = "Unknown error";

            LOG_DEBUG("server.worldserver", "Error cancelling I/O of CliThread, error code {}, detail: {}", uint32(errorCode), errorBuffer);

            if (!formatReturnCode)
                LocalFree((LPSTR)errorBuffer);

            // send keyboard input to safely unblock the CLI thread
            INPUT_RECORD b[4];
            HANDLE hStdIn = GetStdHandle(STD_INPUT_HANDLE);
            b[0].EventType = KEY_EVENT;
            b[0].Event.KeyEvent.bKeyDown = TRUE;
            b[0].Event.KeyEvent.uChar.AsciiChar = 'X';
            b[0].Event.KeyEvent.wVirtualKeyCode = 'X';
            b[0].Event.KeyEvent.wRepeatCount = 1;

            b[1].EventType = KEY_EVENT;
            b[1].Event.KeyEvent.bKeyDown = FALSE;
            b[1].Event.KeyEvent.uChar.AsciiChar = 'X';
            b[1].Event.KeyEvent.wVirtualKeyCode = 'X';
            b[1].Event.KeyEvent.wRepeatCount = 1;

            b[2].EventType = KEY_EVENT;
            b[2].Event.KeyEvent.bKeyDown = TRUE;
            b[2].Event.KeyEvent.dwControlKeyState = 0;
            b[2].Event.KeyEvent.uChar.AsciiChar = '\r';
            b[2].Event.KeyEvent.wVirtualKeyCode = VK_RETURN;
            b[2].Event.KeyEvent.wRepeatCount = 1;
            b[2].Event.KeyEvent.wVirtualScanCode = 0x1c;

            b[3].EventType = KEY_EVENT;
            b[3].Event.KeyEvent.bKeyDown = FALSE;
            b[3].Event.KeyEvent.dwControlKeyState = 0;
            b[3].Event.KeyEvent.uChar.AsciiChar = '\r';
            b[3].Event.KeyEvent.wVirtualKeyCode = VK_RETURN;
            b[3].Event.KeyEvent.wVirtualScanCode = 0x1c;
            b[3].Event.KeyEvent.wRepeatCount = 1;
            DWORD numb;
            WriteConsoleInput(hStdIn, b, 4, &numb);
        }
#endif
        cliThread->join();
        delete cliThread;
    }
}

void WorldUpdateLoop()
{
    uint32 minUpdateDiff = uint32(sConfigMgr->GetOption<int32>("MinWorldUpdateTime", 1));
    uint32 realCurrTime = 0;
    uint32 realPrevTime = getMSTime();

    uint32 maxCoreStuckTime = uint32(sConfigMgr->GetOption<int32>("MaxCoreStuckTime", 60)) * 1000;
    uint32 halfMaxCoreStuckTime = maxCoreStuckTime / 2;
    if (!halfMaxCoreStuckTime)
        halfMaxCoreStuckTime = std::numeric_limits<uint32>::max();

    LoginDatabase.WarnAboutSyncQueries(true);
    CharacterDatabase.WarnAboutSyncQueries(true);
    WorldDatabase.WarnAboutSyncQueries(true);

    ///- While we have not World::m_stopEvent, update the world
    while (!World::IsStopped())
    {
        ++World::m_worldLoopCounter;
        realCurrTime = getMSTime();

        uint32 diff = getMSTimeDiff(realPrevTime, realCurrTime);
        if (diff < minUpdateDiff)
        {
            uint32 sleepTime = minUpdateDiff - diff;
            if (sleepTime >= halfMaxCoreStuckTime)
                LOG_ERROR("server.worldserver", "WorldUpdateLoop() waiting for {} ms with MaxCoreStuckTime set to {} ms", sleepTime, maxCoreStuckTime);
            // sleep until enough time passes that we can update all timers
            std::this_thread::sleep_for(Milliseconds(sleepTime));
            continue;
        }

        sWorld->Update(diff);
        realPrevTime = realCurrTime;

#ifdef _WIN32
        if (m_ServiceStatus == 0)
            World::StopNow(SHUTDOWN_EXIT_CODE);

        while (m_ServiceStatus == 2)
            Sleep(1000);
#endif
    }

    LoginDatabase.WarnAboutSyncQueries(false);
    CharacterDatabase.WarnAboutSyncQueries(false);
    WorldDatabase.WarnAboutSyncQueries(false);
}

void SignalHandler(boost::system::error_code const& error, int /*signalNumber*/)
{
    if (!error)
        World::StopNow(SHUTDOWN_EXIT_CODE);
}

void FreezeDetector::Handler(std::weak_ptr<FreezeDetector> freezeDetectorRef, boost::system::error_code const& error)
{
    if (!error)
    {
        if (std::shared_ptr<FreezeDetector> freezeDetector = freezeDetectorRef.lock())
        {
            uint32 curtime = getMSTime();

            uint32 worldLoopCounter = World::m_worldLoopCounter;
            if (freezeDetector->_worldLoopCounter != worldLoopCounter)
            {
                freezeDetector->_lastChangeMsTime = curtime;
                freezeDetector->_worldLoopCounter = worldLoopCounter;
            }
            // possible freeze
            else
            {
                uint32 msTimeDiff = getMSTimeDiff(freezeDetector->_lastChangeMsTime, curtime);
                if (msTimeDiff > freezeDetector->_maxCoreStuckTimeInMs)
                {
                    LOG_ERROR("server.worldserver", "World Thread hangs for {} ms, forcing a crash!", msTimeDiff);
                    ABORT("World Thread hangs for {} ms, forcing a crash!", msTimeDiff);
                }
            }

            freezeDetector->_timer.expires_from_now(boost::posix_time::seconds(1));
            freezeDetector->_timer.async_wait(std::bind(&FreezeDetector::Handler, freezeDetectorRef, std::placeholders::_1));
        }
    }
}

AsyncAcceptor* StartRaSocketAcceptor(Acore::Asio::IoContext& ioContext)
{
    uint16 raPort = uint16(sConfigMgr->GetOption<int32>("Ra.Port", 3443));
    std::string raListener = sConfigMgr->GetOption<std::string>("Ra.IP", "0.0.0.0");

    AsyncAcceptor* acceptor = new AsyncAcceptor(ioContext, raListener, raPort);
    if (!acceptor->Bind())
    {
        LOG_ERROR("server.worldserver", "Failed to bind RA socket acceptor");
        delete acceptor;
        return nullptr;
    }

    acceptor->AsyncAccept<RASession>();
    return acceptor;
}

bool LoadRealmInfo(Acore::Asio::IoContext& ioContext)
{
    QueryResult result = LoginDatabase.Query("SELECT id, name, address, localAddress, localSubnetMask, port, icon, flag, timezone, allowedSecurityLevel, population, gamebuild FROM realmlist WHERE id = {}", realm.Id.Realm);
    if (!result)
        return false;

    Acore::Asio::Resolver resolver(ioContext);

    Field* fields = result->Fetch();
    realm.Name = fields[1].Get<std::string>();

    Optional<boost::asio::ip::tcp::endpoint> externalAddress = resolver.Resolve(boost::asio::ip::tcp::v4(), fields[2].Get<std::string>(), "");
    if (!externalAddress)
    {
        LOG_ERROR("server.worldserver", "Could not resolve address {}", fields[2].Get<std::string>());
        return false;
    }

    realm.ExternalAddress = std::make_unique<boost::asio::ip::address>(externalAddress->address());

    Optional<boost::asio::ip::tcp::endpoint> localAddress = resolver.Resolve(boost::asio::ip::tcp::v4(), fields[3].Get<std::string>(), "");
    if (!localAddress)
    {
        LOG_ERROR("server.worldserver", "Could not resolve address {}", fields[3].Get<std::string>());
        return false;
    }

    realm.LocalAddress = std::make_unique<boost::asio::ip::address>(localAddress->address());

    Optional<boost::asio::ip::tcp::endpoint> localSubmask = resolver.Resolve(boost::asio::ip::tcp::v4(), fields[4].Get<std::string>(), "");
    if (!localSubmask)
    {
        LOG_ERROR("server.worldserver", "Could not resolve address {}", fields[4].Get<std::string>());
        return false;
    }

    realm.LocalSubnetMask = std::make_unique<boost::asio::ip::address>(localSubmask->address());

    realm.Port = fields[5].Get<uint16>();
    realm.Type = fields[6].Get<uint8>();
    realm.Flags = RealmFlags(fields[7].Get<uint8>());
    realm.Timezone = fields[8].Get<uint8>();
    realm.AllowedSecurityLevel = AccountTypes(fields[9].Get<uint8>());
    realm.PopulationLevel = fields[10].Get<float>();
    realm.Build = fields[11].Get<uint32>();
    return true;
}

void AuctionListingRunnable()
{
    LOG_INFO("server", "Starting up Auction House Listing thread...");

    while (!World::IsStopped())
    {
        Milliseconds diff = AsyncAuctionListingMgr::GetDiff();
        AsyncAuctionListingMgr::ResetDiff();

        if (!AsyncAuctionListingMgr::GetTempList().empty() || !AsyncAuctionListingMgr::GetList().empty())
        {
            {
                std::lock_guard<std::mutex> guard(AsyncAuctionListingMgr::GetTempLock());

                for (auto const& delayEvent: AsyncAuctionListingMgr::GetTempList())
                    AsyncAuctionListingMgr::GetList().emplace_back(delayEvent);

                AsyncAuctionListingMgr::GetTempList().clear();
            }

            for (auto& itr: AsyncAuctionListingMgr::GetList())
            {
                if (itr._pickupTimer <= diff)
                {
                    itr._pickupTimer = Milliseconds::zero();
                }
                else
                {
                    itr._pickupTimer -= diff;
                }
            }

            for (auto itr = AsyncAuctionListingMgr::GetList().begin(); itr != AsyncAuctionListingMgr::GetList().end(); ++itr)
            {
                if ((*itr)._pickupTimer != Milliseconds::zero())
                    continue;

                if ((*itr).Execute())
                    AsyncAuctionListingMgr::GetList().erase(itr);

                break;
            }
        }
        std::this_thread::sleep_for(1ms);
    }

    LOG_INFO("server", "Auction House Listing thread exiting without problems.");
}

variables_map GetConsoleArguments(int argc, char** argv, fs::path& configFile, [[maybe_unused]] std::string& configService)
{
    options_description all("Allowed options");
    all.add_options()
        ("help,h", "print usage message")
        ("version,v", "print version build info")
        ("dry-run,d", "Dry run")
        ("config,c", value<fs::path>(&configFile)->default_value(fs::path(sConfigMgr->GetConfigPath() + std::string(_ACORE_CORE_CONFIG))), "use <arg> as configuration file");

#if AC_PLATFORM == AC_PLATFORM_WINDOWS
    options_description win("Windows platform specific options");
    win.add_options()
        ("service,s", value<std::string>(&configService)->default_value(""), "Windows service options: [install | uninstall]");

    all.add(win);
#endif

    variables_map vm;

    try
    {
        store(command_line_parser(argc, argv).options(all).allow_unregistered().run(), vm);
        notify(vm);
    }
    catch (std::exception const& e)
    {
        std::cerr << e.what() << "\n";
    }

    if (vm.count("help"))
    {
        std::cout << all << "\n";
    }
    else if (vm.count("dry-run"))
    {
        sConfigMgr->setDryRun(true);
    }

    return vm;
}

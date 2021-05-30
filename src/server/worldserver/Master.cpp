/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

/** \file
    \ingroup Trinityd
*/

#include "ACSoap.h"
#include "BigNumber.h"
#include "CliRunnable.h"
#include "Common.h"
#include "Config.h"
#include "DatabaseEnv.h"
#include "DatabaseWorkerPool.h"
#include "GitRevision.h"
#include "Log.h"
#include "Master.h"
#include "OpenSSLCrypto.h"
#include "RARunnable.h"
#include "Realm.h"
#include "ScriptMgr.h"
#include "SignalHandler.h"
#include "Timer.h"
#include "Util.h"
#include "World.h"
#include "WorldRunnable.h"
#include "WorldSocket.h"
#include "WorldSocketMgr.h"
#include "DatabaseLoader.h"
#include "Optional.h"
#include "SecretMgr.h"
#include <ace/Sig_Handler.h>

#ifdef _WIN32
#include "ServiceWin32.h"
extern int m_ServiceStatus;
#endif

#ifdef __linux__
#include <sched.h>
#include <sys/resource.h>
#define PROCESS_HIGH_PRIORITY -15 // [-20, 19], default is 0
#endif

/// Handle worldservers's termination signals
void HandleSignal(int sigNum)
{
    switch (sigNum)
    {
    case SIGINT:
        World::StopNow(RESTART_EXIT_CODE);
        break;
    case SIGTERM:
#if AC_PLATFORM == AC_PLATFORM_WINDOWS
    case SIGBREAK:
        if (m_ServiceStatus != 1)
#endif
            World::StopNow(SHUTDOWN_EXIT_CODE);
        break;
    default:
        break;
    }
}

class FreezeDetectorRunnable : public acore::Runnable
{
private:
    uint32 _loops;
    uint32 _lastChange;
    uint32 _delayTime;

public:
    FreezeDetectorRunnable(uint32 freezeDelay) : _loops(0), _lastChange(0), _delayTime(freezeDelay) {}

    void run() override
    {
        if (!_delayTime)
            return;

        LOG_INFO("server", "Starting up anti-freeze thread (%u seconds max stuck time)...", _delayTime / 1000);
        while (!World::IsStopped())
        {
            uint32 curtime = getMSTime();
            if (_loops != World::m_worldLoopCounter)
            {
                _lastChange = curtime;
                _loops = World::m_worldLoopCounter;
            }
            else if (getMSTimeDiff(_lastChange, curtime) > _delayTime)
            {
                LOG_INFO("server", "World Thread hangs, kicking out server!");
                ABORT();
            }

            acore::Thread::Sleep(1000);
        }
        LOG_INFO("server", "Anti-freeze thread exiting without problems.");
    }
};

bool LoadRealmInfo();

Master* Master::instance()
{
    static Master instance;
    return &instance;
}

/// Main function
int Master::Run()
{
    OpenSSLCrypto::threadsSetup();
    BigNumber seed1;
    seed1.SetRand(16 * 8);

    /// worldserver PID file creation
    std::string pidFile = sConfigMgr->GetOption<std::string>("PidFile", "");
    if (!pidFile.empty())
    {
        if (uint32 pid = CreatePIDFile(pidFile))
            LOG_ERROR("server", "Daemon PID: %u\n", pid); // outError for red color in console
        else
        {
            LOG_ERROR("server", "Cannot create PID file %s (possible error: permission)\n", pidFile.c_str());
            return 1;
        }
    }

    ///- Start the databases
    if (!_StartDB())
        return 1;

    // set server offline (not connectable)
    LoginDatabase.DirectPExecute("UPDATE realmlist SET flag = (flag & ~%u) | %u WHERE id = '%d'", REALM_FLAG_OFFLINE, REALM_FLAG_VERSION_MISMATCH, realm.Id.Realm);

    LoadRealmInfo();

    // Loading modules configs
    sConfigMgr->LoadModulesConfigs();

    ///- Initialize the World
    sSecretMgr->Initialize();
    sWorld->SetInitialWorldSettings();

    sScriptMgr->OnStartup();

    ///- Initialize the signal handlers
    acore::SignalHandler signalHandler;

    signalHandler.handle_signal(SIGINT, &HandleSignal);
    signalHandler.handle_signal(SIGTERM, &HandleSignal);

#if AC_PLATFORM == AC_PLATFORM_WINDOWS
    signalHandler.handle_signal(SIGBREAK, &HandleSignal);
#endif

    ///- Launch WorldRunnable thread
    acore::Thread worldThread(new WorldRunnable);
    worldThread.setPriority(acore::Priority_Highest);

    acore::Thread* cliThread = nullptr;

#ifdef _WIN32
    if (sConfigMgr->GetOption<bool>("Console.Enable", true) && (m_ServiceStatus == -1)/* need disable console in service mode*/)
#else
    if (sConfigMgr->GetOption<bool>("Console.Enable", true))
#endif
    {
        ///- Launch CliRunnable thread
        cliThread = new acore::Thread(new CliRunnable);
    }

    acore::Thread rarThread(new RARunnable);

    // pussywizard:
    acore::Thread auctionLising_thread(new AuctionListingRunnable);
    auctionLising_thread.setPriority(acore::Priority_High);

#if defined(_WIN32) || defined(__linux__)

    ///- Handle affinity for multiple processors and process priority
    uint32 affinity = sConfigMgr->GetOption<int32>("UseProcessors", 0);
    bool highPriority = sConfigMgr->GetOption<bool>("ProcessPriority", false);

#ifdef _WIN32 // Windows

    HANDLE hProcess = GetCurrentProcess();

    if (affinity > 0)
    {
        ULONG_PTR appAff;
        ULONG_PTR sysAff;

        if (GetProcessAffinityMask(hProcess, &appAff, &sysAff))
        {
            ULONG_PTR currentAffinity = affinity & appAff;            // remove non accessible processors

            if (!currentAffinity)
                LOG_ERROR("server", "Processors marked in UseProcessors bitmask (hex) %x are not accessible for the worldserver. Accessible processors bitmask (hex): %x", affinity, appAff);
            else if (SetProcessAffinityMask(hProcess, currentAffinity))
                LOG_INFO("server", "Using processors (bitmask, hex): %x", currentAffinity);
            else
                LOG_ERROR("server", "Can't set used processors (hex): %x", currentAffinity);
        }
    }

    if (highPriority)
    {
        if (SetPriorityClass(hProcess, HIGH_PRIORITY_CLASS))
            LOG_INFO("server", "worldserver process priority class set to HIGH");
        else
            LOG_ERROR("server", "Can't set worldserver process priority class.");
    }

#else // Linux

    if (affinity > 0)
    {
        cpu_set_t mask;
        CPU_ZERO(&mask);

        for (unsigned int i = 0; i < sizeof(affinity) * 8; ++i)
            if (affinity & (1 << i))
                CPU_SET(i, &mask);

        if (sched_setaffinity(0, sizeof(mask), &mask))
            LOG_ERROR("server", "Can't set used processors (hex): %x, error: %s", affinity, strerror(errno));
        else
        {
            CPU_ZERO(&mask);
            sched_getaffinity(0, sizeof(mask), &mask);
            LOG_INFO("server", "Using processors (bitmask, hex): %lx", *(__cpu_mask*)(&mask));
        }
    }

    if (highPriority)
    {
        if (setpriority(PRIO_PROCESS, 0, PROCESS_HIGH_PRIORITY))
            LOG_ERROR("server", "Can't set worldserver process priority class, error: %s", strerror(errno));
        else
            LOG_INFO("server", "worldserver process priority class set to %i", getpriority(PRIO_PROCESS, 0));
    }

#endif
#endif

    // Start soap serving thread if enabled
    std::shared_ptr<std::thread> soapThread;
    if (sConfigMgr->GetOption<bool>("SOAP.Enabled", false))
    {
        soapThread.reset(new std::thread(ACSoapThread, sConfigMgr->GetOption<std::string>("SOAP.IP", "127.0.0.1"), sConfigMgr->GetOption<uint16>("SOAP.Port", 7878)),
            [](std::thread* thr)
        {
            thr->join();
            delete thr;
        });
    }

    // Start up freeze catcher thread
    acore::Thread* freezeThread = nullptr;
    if (uint32 freezeDelay = sConfigMgr->GetOption<int32>("MaxCoreStuckTime", 0))
    {
        FreezeDetectorRunnable* runnable = new FreezeDetectorRunnable(freezeDelay * 1000);
        freezeThread = new acore::Thread(runnable);
        freezeThread->setPriority(acore::Priority_Highest);
    }

    ///- Launch the world listener socket
    uint16 worldPort = uint16(sWorld->getIntConfig(CONFIG_PORT_WORLD));
    std::string bindIp = sConfigMgr->GetOption<std::string>("BindIP", "0.0.0.0");
    if (sWorldSocketMgr->StartNetwork(worldPort, bindIp.c_str()) == -1)
    {
        LOG_ERROR("server", "Failed to start network");
        World::StopNow(ERROR_EXIT_CODE);
        // go down and shutdown the server
    }

    // set server online (allow connecting now)
    LoginDatabase.DirectPExecute("UPDATE realmlist SET flag = flag & ~%u, population = 0 WHERE id = '%u'", REALM_FLAG_VERSION_MISMATCH, realm.Id.Realm);

    LOG_INFO("server", "%s (worldserver-daemon) ready...", GitRevision::GetFullVersion());

    // when the main thread closes the singletons get unloaded
    // since worldrunnable uses them, it will crash if unloaded after master
    worldThread.wait();
    rarThread.wait();
    auctionLising_thread.wait();

    if (freezeThread)
    {
        freezeThread->wait();
        delete freezeThread;
    }

    // set server offline
    LoginDatabase.DirectPExecute("UPDATE realmlist SET flag = flag | %u WHERE id = '%d'", REALM_FLAG_OFFLINE, realm.Id.Realm);

    ///- Clean database before leaving
    ClearOnlineAccounts();

    _StopDB();

    LOG_INFO("server", "Halting process...");

    if (cliThread)
    {
#ifdef _WIN32

        // this only way to terminate CLI thread exist at Win32 (alt. way exist only in Windows Vista API)
        //_exit(1);
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

        cliThread->wait();

#else

        cliThread->destroy();

#endif

        delete cliThread;
    }

    // for some unknown reason, unloading scripts here and not in worldrunnable
    // fixes a memory leak related to detaching threads from the module
    //UnloadScriptingModule();

    OpenSSLCrypto::threadsCleanup();
    // Exit the process with specified return value
    return World::GetExitCode();
}

/// Initialize connection to the databases
bool Master::_StartDB()
{
    MySQL::Library_Init();

    // Load databases
    DatabaseLoader loader;
    loader
        .AddDatabase(LoginDatabase, "Login")
        .AddDatabase(CharacterDatabase, "Character")
        .AddDatabase(WorldDatabase, "World");

    if (!loader.Load())
        return false;

    ///- Get the realm Id from the configuration file
    realm.Id.Realm = sConfigMgr->GetOption<int32>("RealmID", 0);
    if (!realm.Id.Realm)
    {
        LOG_ERROR("server", "Realm ID not defined in configuration file");
        return false;
    }
    else if (realm.Id.Realm > 255)
    {
        /*
         * Due to the client only being able to read a realm.Id.Realm
         * with a size of uint8 we can "only" store up to 255 realms
         * anything further the client will behave anormaly
        */
        LOG_ERROR("server", "Realm ID must range from 1 to 255");
        return false;
    }

    LOG_INFO("server", "Realm running as realm ID %d", realm.Id.Realm);

    ///- Clean the database before starting
    ClearOnlineAccounts();

    ///- Insert version info into DB
    WorldDatabase.PExecute("UPDATE version SET core_version = '%s', core_revision = '%s'", GitRevision::GetFullVersion(), GitRevision::GetHash());        // One-time query

    sWorld->LoadDBVersion();
    sWorld->LoadDBRevision();

    LOG_INFO("server", "Using World DB: %s", sWorld->GetDBVersion());
    return true;
}

void Master::_StopDB()
{
    CharacterDatabase.Close();
    WorldDatabase.Close();
    LoginDatabase.Close();

    MySQL::Library_End();
}

/// Clear 'online' status for all accounts with characters in this realm
void Master::ClearOnlineAccounts()
{
    // Reset online status for all accounts with characters on the current realm
    // pussywizard: tc query would set online=0 even if logged in on another realm >_>
    LoginDatabase.DirectPExecute("UPDATE account SET online = 0 WHERE online = %u", realm.Id.Realm);

    // Reset online status for all characters
    CharacterDatabase.DirectExecute("UPDATE characters SET online = 0 WHERE online <> 0");
}

bool LoadRealmInfo()
{
    QueryResult result = LoginDatabase.PQuery("SELECT id, name, address, localAddress, localSubnetMask, port, icon, flag, timezone, allowedSecurityLevel, population, gamebuild FROM realmlist WHERE id = %u", realm.Id.Realm);
    if (!result)
    {
        LOG_ERROR("server.worldserver", "> Not found realm with ID %u", realm.Id.Realm);
        return false;
    }

    Field* fields = result->Fetch();
    realm.Name = fields[1].GetString();
    realm.Port = fields[5].GetUInt16();

    Optional<ACE_INET_Addr> externalAddress = ACE_INET_Addr(realm.Port, fields[2].GetCString(), AF_INET);
    if (!externalAddress)
    {
        LOG_ERROR("server.worldserver", "Could not resolve address %s", fields[2].GetString().c_str());
        return false;
    }

    Optional<ACE_INET_Addr> localAddress = ACE_INET_Addr(realm.Port, fields[3].GetCString(), AF_INET);
    if (!localAddress)
    {
        LOG_ERROR("server.worldserver", "Could not resolve address %s", fields[3].GetString().c_str());
        return false;
    }

    Optional<ACE_INET_Addr> localSubmask = ACE_INET_Addr(0, fields[4].GetCString(), AF_INET);
    if (!localSubmask)
    {
        LOG_ERROR("server.worldserver", "Could not resolve address %s", fields[4].GetString().c_str());
        return false;
    }

    realm.ExternalAddress = std::make_unique<ACE_INET_Addr>(*externalAddress);
    realm.LocalAddress = std::make_unique<ACE_INET_Addr>(*localAddress);
    realm.LocalSubnetMask = std::make_unique<ACE_INET_Addr>(*localSubmask);

    realm.Type = fields[6].GetUInt8();
    realm.Flags = RealmFlags(fields[7].GetUInt8());
    realm.Timezone = fields[8].GetUInt8();
    realm.AllowedSecurityLevel = AccountTypes(fields[9].GetUInt8());
    realm.PopulationLevel = fields[10].GetFloat();
    realm.Build = fields[11].GetUInt32();
    return true;
}

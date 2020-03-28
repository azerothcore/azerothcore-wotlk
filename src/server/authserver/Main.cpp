/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

/**
* @file main.cpp
* @brief Authentication Server main program
*
* This file contains the main program for the
* authentication server
*/

#include <ace/Dev_Poll_Reactor.h>
#include <ace/TP_Reactor.h>
#include <ace/ACE.h>
#include <ace/Sig_Handler.h>
#include <openssl/opensslv.h>
#include <openssl/crypto.h>

#include "Common.h"
#include "Database/DatabaseEnv.h"
#include "Configuration/Config.h"
#include "Log.h"
#include "GitRevision.h"
#include "Util.h"
#include "SignalHandler.h"
#include "RealmList.h"
#include "RealmAcceptor.h"

#ifdef __linux__
#include <sched.h>
#include <sys/resource.h>
#define PROCESS_HIGH_PRIORITY -15 // [-20, 19], default is 0
#endif

#ifndef _ACORE_REALM_CONFIG
#define _ACORE_REALM_CONFIG "authserver.conf"
#endif

bool StartDB();
void StopDB();

bool stopEvent = false;                                     // Setting it to true stops the server

LoginDatabaseWorkerPool LoginDatabase;                      // Accessor to the authserver database

/// Handle authserver's termination signals
class AuthServerSignalHandler : public acore::SignalHandler
{
public:
    virtual void HandleSignal(int sigNum)
    {
        switch (sigNum)
        {
        case SIGINT:
        case SIGTERM:
            stopEvent = true;
            break;
        }
    }
};

/// Print out the usage string for this program on the console.
void usage(const char* prog)
{
    sLog->outString("Usage: \n %s [<options>]\n"
        "    -c config_file           use config_file as configuration file\n\r",
        prog);
}

/// Launch the auth server
extern int main(int argc, char** argv)
{
    // Command line parsing to get the configuration file name
    char const* configFile = _ACORE_REALM_CONFIG;
    int count = 1;
    while (count < argc)
    {
        if (strcmp(argv[count], "-c") == 0)
        {
            if (++count >= argc)
            {
                printf("Runtime-Error: -c option requires an input argument\n");
                usage(argv[0]);
                return 1;
            }
            else
                configFile = argv[count];
        }
        ++count;
    }

    sConfigMgr->SetConfigList(std::string(configFile));

    if (!sConfigMgr->LoadAppConfigs("authserver"))
        return 1;

    sLog->outString("%s (authserver)", GitRevision::GetFullVersion());
    sLog->outString("<Ctrl-C> to stop.\n");

    sLog->outString("   █████╗ ███████╗███████╗██████╗  ██████╗ ████████╗██╗  ██╗");           
    sLog->outString("  ██╔══██╗╚══███╔╝██╔════╝██╔══██╗██╔═══██╗╚══██╔══╝██║  ██║");           
    sLog->outString("  ███████║  ███╔╝ █████╗  ██████╔╝██║   ██║   ██║   ███████║");           
    sLog->outString("  ██╔══██║ ███╔╝  ██╔══╝  ██╔══██╗██║   ██║   ██║   ██╔══██║");           
    sLog->outString("  ██║  ██║███████╗███████╗██║  ██║╚██████╔╝   ██║   ██║  ██║");           
    sLog->outString("  ╚═╝  ╚═╝╚══════╝╚══════╝╚═╝  ╚═╝ ╚═════╝    ╚═╝   ╚═╝  ╚═╝");
    sLog->outString("                                ██████╗ ██████╗ ██████╗ ███████╗");
    sLog->outString("                                ██╔════╝██╔═══██╗██╔══██╗██╔═══╝");
    sLog->outString("                                ██║     ██║   ██║██████╔╝█████╗");  
    sLog->outString("                                ██║     ██║   ██║██╔══██╗██╔══╝");  
    sLog->outString("                                ╚██████╗╚██████╔╝██║  ██║███████╗");
    sLog->outString("                                 ╚═════╝ ╚═════╝ ╚═╝  ╚═╝╚══════╝\n");

    sLog->outString("  	  AzerothCore 3.3.5a  -  www.azerothcore.org\n");

    sLog->outString("Using configuration file %s.", configFile);

    sLog->outDetail("%s (Library: %s)", OPENSSL_VERSION_TEXT, SSLeay_version(SSLEAY_VERSION));

#if defined (ACE_HAS_EVENT_POLL) || defined (ACE_HAS_DEV_POLL)
    ACE_Reactor::instance(new ACE_Reactor(new ACE_Dev_Poll_Reactor(ACE::max_handles(), 1), 1), true);
#else
    ACE_Reactor::instance(new ACE_Reactor(new ACE_TP_Reactor(), true), true);
#endif

    sLog->outBasic("Max allowed open files is %d", ACE::max_handles());

    // authserver PID file creation
    std::string pidFile = sConfigMgr->GetStringDefault("PidFile", "");
    if (!pidFile.empty())
    {
        if (uint32 pid = CreatePIDFile(pidFile))
            sLog->outError("Daemon PID: %u\n", pid); // outError for red color in console
        else
        {
            sLog->outError("Cannot create PID file %s (possible error: permission)\n", pidFile.c_str());
            return 1;
        }
    }

    // Initialize the database connection
    if (!StartDB())
        return 1;

    // Initialize the log database
    sLog->SetLogDB(false);
    sLog->SetRealmID(0);                                               // ensure we've set realm to 0 (authserver realmid)

    // Get the list of realms for the server
    sRealmList->Initialize(sConfigMgr->GetIntDefault("RealmsStateUpdateDelay", 20));
    if (sRealmList->size() == 0)
    {
        sLog->outError("No valid realms specified.");
        return 1;
    }

    // Launch the listening network socket
    RealmAcceptor acceptor;

    int32 rmport = sConfigMgr->GetIntDefault("RealmServerPort", 3724);
    if (rmport < 0 || rmport > 0xFFFF)
    {
        sLog->outError("The specified RealmServerPort (%d) is out of the allowed range (1-65535)", rmport);
        return 1;
    }

    std::string bind_ip = sConfigMgr->GetStringDefault("BindIP", "0.0.0.0");

    ACE_INET_Addr bind_addr(uint16(rmport), bind_ip.c_str());

    if (acceptor.open(bind_addr, ACE_Reactor::instance(), ACE_NONBLOCK) == -1)
    {
        sLog->outError("Auth server can not bind to %s:%d (possible error: port already in use)", bind_ip.c_str(), rmport);
        return 1;
    }

    sLog->outString("Authserver listening to %s:%d", bind_ip.c_str(), rmport);

    // Initialize the signal handlers
    AuthServerSignalHandler SignalINT, SignalTERM;

    // Register authservers's signal handlers
    ACE_Sig_Handler Handler;
    Handler.register_handler(SIGINT, &SignalINT);
    Handler.register_handler(SIGTERM, &SignalTERM);

#if defined(_WIN32) || defined(__linux__)

    ///- Handle affinity for multiple processors and process priority
    uint32 affinity = sConfigMgr->GetIntDefault("UseProcessors", 0);
    bool highPriority = sConfigMgr->GetBoolDefault("ProcessPriority", false);

#ifdef _WIN32 // Windows

    HANDLE hProcess = GetCurrentProcess();
    if (affinity > 0)
    {
        ULONG_PTR appAff;
        ULONG_PTR sysAff;

        if (GetProcessAffinityMask(hProcess, &appAff, &sysAff))
        {
            // remove non accessible processors
            ULONG_PTR currentAffinity = affinity & appAff;

            if (!currentAffinity)
                sLog->outError("server.authserver", "Processors marked in UseProcessors bitmask (hex) %x are not accessible for the authserver. Accessible processors bitmask (hex): %x", affinity, appAff);
            else if (SetProcessAffinityMask(hProcess, currentAffinity))
                sLog->outString("server.authserver", "Using processors (bitmask, hex): %x", currentAffinity);
            else
                sLog->outError("server.authserver", "Can't set used processors (hex): %x", currentAffinity);
        }
    }

    if (highPriority)
    {
        if (SetPriorityClass(hProcess, HIGH_PRIORITY_CLASS))
            sLog->outString("server.authserver", "authserver process priority class set to HIGH");
        else
            sLog->outError("server.authserver", "Can't set authserver process priority class.");
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
            sLog->outError("Can't set used processors (hex): %x, error: %s", affinity, strerror(errno));
        else
        {
            CPU_ZERO(&mask);
            sched_getaffinity(0, sizeof(mask), &mask);
            sLog->outString("Using processors (bitmask, hex): %lx", *(__cpu_mask*)(&mask));
        }
    }

    if (highPriority)
    {
        if (setpriority(PRIO_PROCESS, 0, PROCESS_HIGH_PRIORITY))
            sLog->outError("Can't set authserver process priority class, error: %s", strerror(errno));
        else
            sLog->outString("authserver process priority class set to %i", getpriority(PRIO_PROCESS, 0));
    }

#endif
#endif

    // maximum counter for next ping
    uint32 numLoops = (sConfigMgr->GetIntDefault("MaxPingTime", 30) * (MINUTE * 1000000 / 100000));
    uint32 loopCounter = 0;

    // possibly enable db logging; avoid massive startup spam by doing it here.
    if (sConfigMgr->GetBoolDefault("EnableLogDB", false))
    {
        sLog->outString("Enabling database logging...");
        sLog->SetLogDB(true);
    }

    // Wait for termination signal
    while (!stopEvent)
    {
        // dont move this outside the loop, the reactor will modify it
        ACE_Time_Value interval(0, 100000);

        if (ACE_Reactor::instance()->run_reactor_event_loop(interval) == -1)
            break;

        if ((++loopCounter) == numLoops)
        {
            loopCounter = 0;
            sLog->outDetail("Ping MySQL to keep connection alive");
            LoginDatabase.KeepAlive();
        }
    }

    // Close the Database Pool and library
    StopDB();

    sLog->outString("Halting process...");
    return 0;
}

/// Initialize connection to the database
bool StartDB()
{
    MySQL::Library_Init();

    std::string dbstring = sConfigMgr->GetStringDefault("LoginDatabaseInfo", "");
    if (dbstring.empty())
    {
        sLog->outError("Database not specified");
        return false;
    }

    int32 worker_threads = sConfigMgr->GetIntDefault("LoginDatabase.WorkerThreads", 1);
    if (worker_threads < 1 || worker_threads > 32)
    {
        sLog->outError("Improper value specified for LoginDatabase.WorkerThreads, defaulting to 1.");
        worker_threads = 1;
    }

    int32 synch_threads = sConfigMgr->GetIntDefault("LoginDatabase.SynchThreads", 1);
    if (synch_threads < 1 || synch_threads > 32)
    {
        sLog->outError("Improper value specified for LoginDatabase.SynchThreads, defaulting to 1.");
        synch_threads = 1;
    }

    // NOTE: While authserver is singlethreaded you should keep synch_threads == 1. Increasing it is just silly since only 1 will be used ever.
    if (!LoginDatabase.Open(dbstring.c_str(), uint8(worker_threads), uint8(synch_threads)))
    {
        sLog->outError("Cannot connect to database");
        return false;
    }

    sLog->outString("Started auth database connection pool.");
    return true;
}

/// Close the connection to the database
void StopDB()
{
    LoginDatabase.Close();
    MySQL::Library_End();
}

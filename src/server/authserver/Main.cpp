/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
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

#include "AppenderDB.h"
#include "Banner.h"
#include "Common.h"
#include "Config.h"
#include "DatabaseEnv.h"
#include "DatabaseLoader.h"
#include "GitRevision.h"
#include "IPLocation.h"
#include "Log.h"
#include "RealmAcceptor.h"
#include "RealmList.h"
#include "SecretMgr.h"
#include "SharedDefines.h"
#include "SignalHandler.h"
#include "Util.h"
#include "ProcessPriority.h"
#include <ace/ACE.h>
#include <ace/Dev_Poll_Reactor.h>
#include <ace/Sig_Handler.h>
#include <ace/TP_Reactor.h>
#include <boost/version.hpp>
#include <openssl/crypto.h>
#include <openssl/opensslv.h>

#ifndef _ACORE_REALM_CONFIG
#define _ACORE_REALM_CONFIG "authserver.conf"
#endif

bool StartDB();
void StopDB();

bool stopEvent = false;                                     // Setting it to true stops the server

/// Print out the usage string for this program on the console.
void usage(const char* prog)
{
    LOG_INFO("server.authserver", "Usage: \n %s [<options>]\n"
                    "    -c config_file           use config_file as configuration file\n\r",
                    prog);
}

/// Launch the auth server
extern int main(int argc, char** argv)
{
    Acore::Impl::CurrentServerProcessHolder::_type = SERVER_PROCESS_AUTHSERVER;

    // Command line parsing to get the configuration file name
    std::string configFile = sConfigMgr->GetConfigPath() + std::string(_ACORE_REALM_CONFIG);
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

    // Add file and args in config
    sConfigMgr->Configure(configFile, std::vector<std::string>(argv, argv + argc));

    if (!sConfigMgr->LoadAppConfigs())
        return 1;

    // Init logging
    sLog->RegisterAppender<AppenderDB>();
    sLog->Initialize();

    Acore::Banner::Show("authserver",
        [](char const* text)
        {
            LOG_INFO("server.authserver", "%s", text);
        },
        []()
        {
            LOG_INFO("server.authserver", "> Using configuration file       %s.", sConfigMgr->GetFilename().c_str());
            LOG_INFO("server.authserver", "> Using SSL version:             %s (library: %s)", OPENSSL_VERSION_TEXT, SSLeay_version(SSLEAY_VERSION));
            LOG_INFO("server.authserver", "> Using Boost version:           %i.%i.%i", BOOST_VERSION / 100000, BOOST_VERSION / 100 % 1000, BOOST_VERSION % 100);
            LOG_INFO("server.authserver", "> Using ACE version:             %s\n", ACE_VERSION);
        }
    );

#if defined (ACE_HAS_EVENT_POLL) || defined (ACE_HAS_DEV_POLL)
    ACE_Reactor::instance(new ACE_Reactor(new ACE_Dev_Poll_Reactor(ACE::max_handles(), 1), 1), true);
#else
    ACE_Reactor::instance(new ACE_Reactor(new ACE_TP_Reactor(), true), true);
#endif

    LOG_INFO("server.authserver", "Max allowed open files is %d", ACE::max_handles());

    // authserver PID file creation
    std::string pidFile = sConfigMgr->GetOption<std::string>("PidFile", "");
    if (!pidFile.empty())
    {
        if (uint32 pid = CreatePIDFile(pidFile))
            LOG_INFO("server.authserver", "Daemon PID: %u\n", pid); // outError for red color in console
        else
        {
            LOG_ERROR("server.authserver", "Cannot create PID file %s (possible error: permission)\n", pidFile.c_str());
            return 1;
        }
    }

    // Initialize the database connection
    if (!StartDB())
        return 1;

    sSecretMgr->Initialize();

    // Load IP Location Database
    sIPLocation->Load();

    // Get the list of realms for the server
    sRealmList->Initialize(sConfigMgr->GetOption<int32>("RealmsStateUpdateDelay", 20));
    if (sRealmList->GetRealms().empty())
    {
        LOG_ERROR("server.authserver", "No valid realms specified.");
        return 1;
    }

    // Launch the listening network socket
    RealmAcceptor acceptor;

    int32 rmport = sConfigMgr->GetOption<int32>("RealmServerPort", 3724);
    if (rmport < 0 || rmport > 0xFFFF)
    {
        LOG_ERROR("server.authserver", "The specified RealmServerPort (%d) is out of the allowed range (1-65535)", rmport);
        return 1;
    }

    std::string bind_ip = sConfigMgr->GetOption<std::string>("BindIP", "0.0.0.0");

    ACE_INET_Addr bind_addr(uint16(rmport), bind_ip.c_str());

    if (acceptor.open(bind_addr, ACE_Reactor::instance(), ACE_NONBLOCK) == -1)
    {
        LOG_ERROR("server.authserver", "Auth server can not bind to %s:%d (possible error: port already in use)", bind_ip.c_str(), rmport);
        return 1;
    }

    LOG_INFO("server.authserver", "Authserver listening to %s:%d", bind_ip.c_str(), rmport);

    // Initialize the signal handlers
    Acore::SignalHandler signalHandler;
    auto const _handler = [](int) { stopEvent = true; };

    // Register authservers's signal handlers
    signalHandler.handle_signal(SIGINT, _handler);
    signalHandler.handle_signal(SIGTERM, _handler);
#if AC_PLATFORM == AC_PLATFORM_WINDOWS
    signalHandler.handle_signal(SIGBREAK, _handler);
#endif

    // Set process priority according to configuration settings
    SetProcessPriority("server.authserver", sConfigMgr->GetOption<int32>(CONFIG_PROCESSOR_AFFINITY, 0), sConfigMgr->GetOption<bool>(CONFIG_HIGH_PRIORITY, false));

    // maximum counter for next ping
    uint32 numLoops = (sConfigMgr->GetOption<int32>("MaxPingTime", 30) * (MINUTE * 1000000 / 100000));
    uint32 loopCounter = 0;

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
            LOG_INFO("server.authserver", "Ping MySQL to keep connection alive");
            LoginDatabase.KeepAlive();
        }
    }

    // Close the Database Pool and library
    StopDB();

    LOG_INFO("server.authserver", "Halting process...");
    return 0;
}

/// Initialize connection to the database
bool StartDB()
{
    MySQL::Library_Init();

    // Load databases
    // NOTE: While authserver is singlethreaded you should keep synch_threads == 1.
    // Increasing it is just silly since only 1 will be used ever.
    DatabaseLoader loader;
    loader
        .AddDatabase(LoginDatabase, "Login");

    if (!loader.Load())
        return false;

    LOG_INFO("server.authserver", "Started auth database connection pool.");
    sLog->SetRealmId(0); // Enables DB appenders when realm is set.
    return true;
}

/// Close the connection to the database
void StopDB()
{
    LoginDatabase.Close();
    MySQL::Library_End();
}

/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

/// \addtogroup Trinityd Trinity Daemon
/// @{
/// \file

#include <openssl/opensslv.h>
#include <openssl/crypto.h>
#include <ace/Version.h>
#include "Common.h"
#include "DatabaseEnv.h"
#include "Config.h"
#include "Log.h"
#include "Master.h"

#ifndef _TRINITY_CORE_CONFIG
# define _TRINITY_CORE_CONFIG  "worldserver.conf"
#endif

#ifdef _WIN32
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
#endif

WorldDatabaseWorkerPool WorldDatabase;                      ///< Accessor to the world database
CharacterDatabaseWorkerPool CharacterDatabase;              ///< Accessor to the character database
LoginDatabaseWorkerPool LoginDatabase;                      ///< Accessor to the realm/login database

uint32 realmID;                                             ///< Id of the realm

/// Print out the usage string for this program on the console.
void usage(const char* prog)
{
    SYS_LOG_INFO("Usage:\n");
    SYS_LOG_INFO(" %s [<options>]\n", prog);
    SYS_LOG_INFO("    -c config_file           use config_file as configuration file\n");
#ifdef _WIN32
    SYS_LOG_INFO("    Running as service functions:\n");
    SYS_LOG_INFO("    --service                run as service\n");
    SYS_LOG_INFO("    -s install               install service\n");
    SYS_LOG_INFO("    -s uninstall             uninstall service\n");
#endif
}

/// Launch the Trinity server
extern int main(int argc, char** argv)
{
    // Init system logging
    sLog->InitSystemLogger();

    ///- Command line parsing to get the configuration file name
    char const* cfg_file = _TRINITY_CORE_CONFIG;
    int c = 1;
    while (c < argc)
    {
        if (strcmp(argv[c], "--dry-run") == 0)
        {
            sConfigMgr->setDryRun(true);
        }

        if (!strcmp(argv[c], "-c"))
        {
            if (++c >= argc)
            {
                SYS_LOG_ERROR("Runtime-Error: -c option requires an input argument");
                usage(argv[0]);
                return 1;
            }
            else
                cfg_file = argv[c];
        }

        #ifdef _WIN32
        if (strcmp(argv[c], "-s") == 0) // Services
        {
            if (++c >= argc)
            {
                SYS_LOG_ERROR("Runtime-Error: -s option requires an input argument");
                usage(argv[0]);
                return 1;
            }

            if (strcmp(argv[c], "install") == 0)
            {
                if (WinServiceInstall())
                    SYS_LOG_INFO("Installing service\n");

                return 1;
            }
            else if (strcmp(argv[c], "uninstall") == 0)
            {
                if (WinServiceUninstall())
                    SYS_LOG_INFO("Uninstalling service\n");

                return 1;
            }
            else
            {
                SYS_LOG_ERROR("Runtime-Error: unsupported option %s", argv[c]);
                usage(argv[0]);
                return 1;
            }
        }

        if (strcmp(argv[c], "--service") == 0)
            WinServiceRun();
        #endif
        ++c;
    }

    std::string cfg_def_file=_TRINITY_CORE_CONFIG;
    cfg_def_file += ".dist";

    if (!sConfigMgr->LoadInitial(cfg_def_file.c_str())) 
    {
        SYS_LOG_ERROR("ERROR: Invalid or missing default configuration file : %s\n", cfg_def_file.c_str());
        return 1;
    }

    if (!sConfigMgr->LoadMore(cfg_file))
    {
        SYS_LOG_ERROR("WARNING: Invalid or missing configuration file : %s\n", cfg_file);
        SYS_LOG_ERROR("Verify that the file exists and has \'[worldserver]' written in the top of the file!\n");
    }

    sLog->Initialize();

    LOG_INFO("root", "Using configuration file %s.", cfg_file);
    LOG_INFO("root", "Using SSL version: %s (library: %s)", OPENSSL_VERSION_TEXT, SSLeay_version(SSLEAY_VERSION));
    LOG_INFO("root", "Using ACE version: %s", ACE_VERSION);

    ///- and run the 'Master'
    /// @todo Why do we need this 'Master'? Can't all of this be in the Main as for Realmd?
    int ret = sMaster->Run();

    // at sMaster return function exist with codes
    // 0 - normal shutdown
    // 1 - shutdown at error
    // 2 - restart command used, this code can be used by restarter for restart Trinityd

    return ret;
}

/// @}

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

#include "Banner.h"
#include "Config.h"
#include "DatabaseEnv.h"
#include "DatabaseLoader.h"
#include "IoContext.h"
#include "Log.h"
#include "MySQLThreading.h"
#include "OpenSSLCrypto.h"
#include "Util.h"
#include <boost/program_options.hpp>
#include <boost/version.hpp>
#include <csignal>
#include <filesystem>
#include <iostream>
#include <openssl/crypto.h>
#include <openssl/opensslv.h>

#ifndef _ACORE_DB_IMPORT_CONFIG
#define _ACORE_DB_IMPORT_CONFIG "dbimport.conf"
#endif

using namespace boost::program_options;
namespace fs = std::filesystem;

bool StartDB();
void StopDB();
variables_map GetConsoleArguments(int argc, char** argv, fs::path& configFile);

/// Launch the db import server
int main(int argc, char** argv)
{
    signal(SIGABRT, &Acore::AbortHandler);

    // Command line parsing
    auto configFile = fs::path(sConfigMgr->GetConfigPath() + std::string(_ACORE_DB_IMPORT_CONFIG));
    auto vm = GetConsoleArguments(argc, argv, configFile);

    // exit if help is enabled
    if (vm.count("help"))
        return 0;

    // Add file and args in config
    sConfigMgr->Configure(configFile.generic_string(), std::vector<std::string>(argv, argv + argc));

    if (!sConfigMgr->LoadAppConfigs())
        return 1;

    std::vector<std::string> overriddenKeys = sConfigMgr->OverrideWithEnvVariablesIfAny();

    // Init logging
    sLog->Initialize();

    Acore::Banner::Show("dbimport",
        [](std::string_view text)
        {
            LOG_INFO("dbimport", text);
        },
        []()
        {
            LOG_INFO("dbimport", "> Using configuration file:       {}", sConfigMgr->GetFilename());
            LOG_INFO("dbimport", "> Using SSL version:              {} (library: {})", OPENSSL_VERSION_TEXT, OpenSSL_version(OPENSSL_VERSION));
            LOG_INFO("dbimport", "> Using Boost version:            {}.{}.{}", BOOST_VERSION / 100000, BOOST_VERSION / 100 % 1000, BOOST_VERSION % 100);
        }
    );

    for (std::string const& key : overriddenKeys)
        LOG_INFO("dbimport", "Configuration field {} was overridden with environment variable.", key);

    OpenSSLCrypto::threadsSetup();

    std::shared_ptr<void> opensslHandle(nullptr, [](void*) { OpenSSLCrypto::threadsCleanup(); });

    // Initialize the database connection
    if (!StartDB())
        return 1;

    std::shared_ptr<void> dbHandle(nullptr, [](void*) { StopDB(); });

    LOG_INFO("dbimport", "Halting process...");

    return 0;
}

/// Initialize connection to the database
bool StartDB()
{
    MySQL::Library_Init();

    // Load modules conditionally based on what modules are allowed to auto-update or none
    std::string modules = sConfigMgr->GetOption<std::string>("Updates.AllowedModules", "all");
    LOG_INFO("dbimport", "Loading modules: {}", modules.empty() ? "none" : modules);

    DatabaseLoader loader =
        modules.empty() ? DatabaseLoader("dbimport") :
        (modules == "all") ? DatabaseLoader("dbimport", DatabaseLoader::DATABASE_MASK_ALL, AC_MODULES_LIST) :
        DatabaseLoader("dbimport", DatabaseLoader::DATABASE_MASK_ALL, modules);

    loader
        .AddDatabase(LoginDatabase, "Login")
        .AddDatabase(CharacterDatabase, "Character")
        .AddDatabase(WorldDatabase, "World");

    if (!loader.Load())
        return false;

    LOG_INFO("dbimport", "Started database connection pool.");
    return true;
}

/// Close the connection to the database
void StopDB()
{
    CharacterDatabase.Close();
    WorldDatabase.Close();
    LoginDatabase.Close();
    MySQL::Library_End();
}

variables_map GetConsoleArguments(int argc, char** argv, fs::path& configFile)
{
    options_description all("Allowed options");
    all.add_options()
        ("help,h", "print usage message")
        ("version,v", "print version build info")
        ("dry-run,d", "Dry run")
        ("config,c", value<fs::path>(&configFile)->default_value(fs::path(sConfigMgr->GetConfigPath() + std::string(_ACORE_DB_IMPORT_CONFIG))), "use <arg> as configuration file")
        ("config-policy", value<std::string>()->value_name("policy"), "override config severity policy (e.g. default=skip,critical_option=fatal)");

    variables_map variablesMap;

    try
    {
        store(command_line_parser(argc, argv).options(all).allow_unregistered().run(), variablesMap);
        notify(variablesMap);
    }
    catch (std::exception const& e)
    {
        std::cerr << e.what() << "\n";
    }

    if (variablesMap.count("help"))
    {
        std::cout << all << "\n";
    }
    else if (variablesMap.count("dry-run"))
    {
        sConfigMgr->setDryRun(true);
    }

    return variablesMap;
}

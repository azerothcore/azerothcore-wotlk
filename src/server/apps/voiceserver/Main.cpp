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

/**
* @file main.cpp
* @brief Voice Server main program
*
* This file contains the main program for the
* voice server
*/

#include "Banner.h"
#include "ChannelMgr.h"
#include "Config.h"
#include "GitRevision.h"
#include "InternalSocketMgr.h"
#include "IoContext.h"
#include "Log.h"
#include "ProcessPriority.h"
#include "SharedDefines.h"
#include "Util.h"
#include "VoiceModulesLoader.h"
#include "VoiceScriptMgr.h"
#include "VoiceServer.h"
#include <boost/asio/ip/tcp.hpp>
#include <boost/asio/signal_set.hpp>
#include <boost/program_options.hpp>
#include <boost/version.hpp>
#include <csignal>
#include <filesystem>
#include <iostream>
#include <openssl/crypto.h>
#include <openssl/opensslv.h>

#ifndef _ACORE_VOICE_CONFIG
#define _ACORE_VOICE_CONFIG "voiceserver.conf"
#endif

using boost::asio::ip::tcp;
using namespace boost::program_options;
namespace fs = std::filesystem;

void SignalHandler(std::weak_ptr<Acore::Asio::IoContext> ioContextRef, boost::system::error_code const& error,
    int signalNumber);
variables_map GetConsoleArguments(int argc, char** argv, fs::path& configFile);

/// Launch the voice server
int main(int argc, char** argv)
{
    Acore::Impl::CurrentServerProcessHolder::_type = SERVER_PROCESS_VOICESERVER;
    signal(SIGABRT, &Acore::AbortHandler);

    // Command line parsing
    auto configFile = fs::path(sConfigMgr->GetConfigPath() + std::string(_ACORE_VOICE_CONFIG));
    auto vm = GetConsoleArguments(argc, argv, configFile);

    // exit if help or version is enabled
    if (vm.count("help") || vm.count("version"))
        return 0;

    // Add file and args in config
    sConfigMgr->Configure(configFile.generic_string(), std::vector<std::string>(argv, argv + argc),
        VOICE_CONFIG_FILE_LIST);

    if (!sConfigMgr->LoadAppConfigs())
        return 1;

    // Init logging
    sLog->Initialize(nullptr);

    Acore::Banner::Show("voiceserver",
        [](std::string_view text)
        {
            LOG_INFO("server.voiceserver", text);
        },
        []()
        {
            LOG_INFO("server.voiceserver", "> Using configuration file       {}", sConfigMgr->GetFilename());
            LOG_INFO("server.voiceserver", "> Using SSL version:             {} (library: {})", OPENSSL_VERSION_TEXT,
                OpenSSL_version(OPENSSL_VERSION));
            LOG_INFO("server.voiceserver", "> Using Boost version:           {}.{}.{}", BOOST_VERSION / 100000,
                BOOST_VERSION / 100 % 1000, BOOST_VERSION % 100);
        });

    // configs of the voiceserver parts of the modules
    sConfigMgr->LoadModulesConfigs();

    // voiceserver PID file creation
    std::string pidFile = sConfigMgr->GetOption<std::string>("PidFile", "");
    if (!pidFile.empty())
    {
        if (uint32 pid = CreatePIDFile(pidFile))
            LOG_INFO("server.voiceserver", "Daemon PID: {}\n", pid);
        else
        {
            LOG_ERROR("server.voiceserver", "Cannot create PID file {} (possible error: permission)\n", pidFile);
            return 1;
        }
    }

    std::shared_ptr<Acore::Asio::IoContext> ioContext = std::make_shared<Acore::Asio::IoContext>();

    // Stop voice server if dry run
    if (sConfigMgr->isDryRun())
    {
        LOG_INFO("server.voiceserver", "Dry run completed, terminating.");
        return 0;
    }

    // create the voiceserver scripts of the modules
    sVoiceScriptMgr->SetModulesLoader(AddVoiceModulesScripts);
    sVoiceScriptMgr->Initialize();

    sVoiceScriptMgr->OnStartup(*ioContext);

    // released after the network handles below, so scripts shut down once all
    // connections are closed but before the io context their timers may use is gone
    std::shared_ptr<void> sScriptsHandle(nullptr, [](void*)
    {
        sVoiceScriptMgr->OnShutdown();
        sVoiceScriptMgr->Unload();
    });

    // Start the listening port (acceptor) for voiceserver connections
    uint32 const clientPort = sConfigMgr->GetOption<uint32>("ClientPort", 3724);
    uint32 const internalPort = sConfigMgr->GetOption<uint32>("InternalPort", 3725);
    if (clientPort > 0xFFFF || internalPort > 0xFFFF)
    {
        LOG_ERROR("server.voiceserver", "Specified port out of allowed range (1-65535)");
        return 1;
    }

    sVoiceChannelMgr.SetMaxPacketsPerSecond(sConfigMgr->GetOption<uint32>("ClientMaxPacketsPerSecond", 50));

    std::string const clientBindIp = sConfigMgr->GetOption<std::string>("ClientBindIP", "0.0.0.0");
    if (!sVoiceServer.Start(*ioContext, clientBindIp, clientPort))
    {
        LOG_ERROR("server.voiceserver", "Failed to initialize client network");
        return 1;
    }

    // registered right away so the UDP socket is also released when a later step fails
    std::shared_ptr<void> sVoiceServerHandle(nullptr, [](void*)
    {
        sVoiceServer.Stop();
    });

    // by default only accept internal (worldserver) connections from localhost
    std::string const internalBindIp = sConfigMgr->GetOption<std::string>("InternalBindIP", "127.0.0.1");
    if (!sInternalSocketMgr.StartNetwork(*ioContext, internalBindIp, internalPort))
    {
        LOG_ERROR("server.voiceserver", "Failed to initialize internal network");
        return 1;
    }

    std::shared_ptr<void> sSocketMgrHandle(nullptr, [](void*)
    {
        sInternalSocketMgr.StopNetwork();
    });

    // Set signal handlers
    boost::asio::signal_set signals(*ioContext, SIGINT, SIGTERM);
#if AC_PLATFORM == AC_PLATFORM_WINDOWS
    signals.add(SIGBREAK);
#endif
    signals.async_wait(std::bind(&SignalHandler, std::weak_ptr<Acore::Asio::IoContext>(ioContext),
        std::placeholders::_1, std::placeholders::_2));

    // Set process priority according to configuration settings
    SetProcessPriority("server.voiceserver", sConfigMgr->GetOption<int32>(CONFIG_PROCESSOR_AFFINITY, 0),
        sConfigMgr->GetOption<bool>(CONFIG_HIGH_PRIORITY, false));

    // Start the io service worker loop
    ioContext->run();

    LOG_INFO("server.voiceserver", "Halting process...");

    signals.cancel();

    return 0;
}

void SignalHandler(std::weak_ptr<Acore::Asio::IoContext> ioContextRef, boost::system::error_code const& error,
    int /*signalNumber*/)
{
    if (!error)
    {
        if (std::shared_ptr<Acore::Asio::IoContext> ioContext = ioContextRef.lock())
            ioContext->stop();
    }
}

variables_map GetConsoleArguments(int argc, char** argv, fs::path& configFile)
{
    options_description all("Allowed options");
    all.add_options()
        ("help,h", "print usage message")
        ("version,v", "print version build info")
        ("dry-run,d", "Dry run")
        ("config,c", value<fs::path>(&configFile)->default_value(fs::path(sConfigMgr->GetConfigPath() +
            std::string(_ACORE_VOICE_CONFIG))), "use <arg> as configuration file");

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
        std::cout << all << "\n";
    else if (variablesMap.count("version"))
        std::cout << GitRevision::GetFullVersion() << "\n";
    else if (variablesMap.count("dry-run"))
        sConfigMgr->setDryRun(true);

    return variablesMap;
}

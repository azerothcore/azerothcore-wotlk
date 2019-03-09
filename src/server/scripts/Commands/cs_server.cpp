/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

/* ScriptData
Name: server_commandscript
%Complete: 100
Comment: All server related commands
Category: commandscripts
EndScriptData */

#include "Chat.h"
#include "Config.h"
#include "Language.h"
#include "ObjectAccessor.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "GitRevision.h"
#include "AvgDiffTracker.h"
#include "ServerMotd.h"

class server_commandscript : public CommandScript
{
public:
    server_commandscript() : CommandScript("server_commandscript") { }

    std::vector<ChatCommand> GetCommands() const override
    {
        static std::vector<ChatCommand> serverIdleRestartCommandTable =
        {
            { "cancel",         SEC_ADMINISTRATOR,  true,  &HandleServerShutDownCancelCommand,      "" },
            { ""   ,            SEC_ADMINISTRATOR,  true,  &HandleServerIdleRestartCommand,         "" }
        };

        static std::vector<ChatCommand> serverIdleShutdownCommandTable =
        {
            { "cancel",         SEC_ADMINISTRATOR,  true,  &HandleServerShutDownCancelCommand,      "" },
            { ""   ,            SEC_ADMINISTRATOR,  true,  &HandleServerIdleShutDownCommand,        "" }
        };

        static std::vector<ChatCommand> serverRestartCommandTable =
        {
            { "cancel",         SEC_ADMINISTRATOR,  true,  &HandleServerShutDownCancelCommand,      "" },
            { ""   ,            SEC_ADMINISTRATOR,  true,  &HandleServerRestartCommand,             "" }
        };

        static std::vector<ChatCommand> serverShutdownCommandTable =
        {
            { "cancel",         SEC_ADMINISTRATOR,  true,  &HandleServerShutDownCancelCommand,      "" },
            { ""   ,            SEC_ADMINISTRATOR,  true,  &HandleServerShutDownCommand,            "" }
        };

        static std::vector<ChatCommand> serverSetCommandTable =
        {
            { "difftime",       SEC_CONSOLE,        true,  &HandleServerSetDiffTimeCommand,         "" },
            { "loglevel",       SEC_CONSOLE,        true,  &HandleServerSetLogLevelCommand,         "" },
            { "logfilelevel",   SEC_CONSOLE,        true,  &HandleServerSetLogFileLevelCommand,     "" },
            { "motd",           SEC_ADMINISTRATOR,  true,  &HandleServerSetMotdCommand,             "" },
            { "closed",         SEC_ADMINISTRATOR,  true,  &HandleServerSetClosedCommand,           "" }
        };

        static std::vector<ChatCommand> serverCommandTable =
        {
            { "corpses",        SEC_GAMEMASTER,     true,  &HandleServerCorpsesCommand,             "" },
            { "exit",           SEC_CONSOLE,        true,  &HandleServerExitCommand,                "" },
            { "idlerestart",    SEC_ADMINISTRATOR,  true,  nullptr,                                 "", serverIdleRestartCommandTable },
            { "idleshutdown",   SEC_ADMINISTRATOR,  true,  nullptr,                                 "", serverIdleShutdownCommandTable },
            { "info",           SEC_PLAYER,         true,  &HandleServerInfoCommand,                "" },
            { "motd",           SEC_PLAYER,         true,  &HandleServerMotdCommand,                "" },
            { "restart",        SEC_ADMINISTRATOR,  true,  nullptr,                                 "", serverRestartCommandTable },
            { "shutdown",       SEC_ADMINISTRATOR,  true,  nullptr,                                 "", serverShutdownCommandTable },
            { "set",            SEC_ADMINISTRATOR,  true,  nullptr,                                 "", serverSetCommandTable },
            { "togglequerylog", SEC_CONSOLE,        true,  &HandleServerToggleQueryLogging,         "" }
        };

         static std::vector<ChatCommand> commandTable =
        {
            { "server",         SEC_PLAYER,         true,  nullptr,                                 "", serverCommandTable }
        };
        return commandTable;
    }

    // Triggering corpses expire check in world
    static bool HandleServerCorpsesCommand(ChatHandler* /*handler*/, char const* /*args*/)
    {
        sObjectAccessor->RemoveOldCorpses();
        return true;
    }

    static bool HandleServerInfoCommand(ChatHandler* handler, char const* /*args*/)
    {
        std::string realmName = sWorld->GetRealmName();
        uint32 playerCount = sWorld->GetPlayerCount();
        uint32 activeSessionCount = sWorld->GetActiveSessionCount();
        uint32 queuedSessionCount = sWorld->GetQueuedSessionCount();
        uint32 connPeak = sWorld->GetMaxActiveSessionCount();
        std::string uptime = secsToTimeString(sWorld->GetUptime()).append(".");
        uint32 updateTime = sWorld->GetUpdateTime();
        uint32 avgUpdateTime = avgDiffTracker.getAverage();

        handler->PSendSysMessage("%s", GitRevision::GetFullVersion());
        if (!queuedSessionCount)
            handler->PSendSysMessage("Connected players: %u. Characters in world: %u.", activeSessionCount, playerCount);
        else
            handler->PSendSysMessage("Connected players: %u. Characters in world: %u. Queue: %u.", activeSessionCount, playerCount, queuedSessionCount);
        handler->PSendSysMessage("Connection peak: %u.", connPeak);
        handler->PSendSysMessage(LANG_UPTIME, uptime.c_str());
        handler->PSendSysMessage("Update time diff: %ums, average: %ums.", updateTime, avgUpdateTime);

        if (handler->GetSession())
            if (Player* p = handler->GetSession()->GetPlayer())
                if (p->HasFlag(PLAYER_FLAGS, PLAYER_FLAGS_DEVELOPER))
                    handler->PSendSysMessage("DEV wavg: %ums, nsmax: %ums, nsavg: %ums. LFG avg: %ums, max: %ums.", avgDiffTracker.getTimeWeightedAverage(), devDiffTracker.getMax(), devDiffTracker.getAverage(), lfgDiffTracker.getAverage(), lfgDiffTracker.getMax());

        //! Can't use sWorld->ShutdownMsg here in case of console command
        if (sWorld->IsShuttingDown())
            handler->PSendSysMessage(LANG_SHUTDOWN_TIMELEFT, secsToTimeString(sWorld->GetShutDownTimeLeft()).append(".").c_str());

        return true;
    }
    // Display the 'Message of the day' for the realm
    static bool HandleServerMotdCommand(ChatHandler* handler, char const* /*args*/)
    {
        handler->PSendSysMessage(LANG_MOTD_CURRENT, Motd::GetMotd());
        return true;
    }

    static bool HandleServerShutDownCancelCommand(ChatHandler* /*handler*/, char const* /*args*/)
    {
        sWorld->ShutdownCancel();

        return true;
    }

    static bool HandleServerShutDownCommand(ChatHandler* /*handler*/, char const* args)
    {
        if (!*args)
            return false;

        char* timeStr = strtok((char*) args, " ");
        char* exitCodeStr = strtok(nullptr, "");

        int32 time = atoi(timeStr);

        // Prevent interpret wrong arg value as 0 secs shutdown time
        if ((time == 0 && (timeStr[0] != '0' || timeStr[1] != '\0')) || time < 0)
            return false;

        if (exitCodeStr)
        {
            int32 exitCode = atoi(exitCodeStr);

            // Handle atoi() errors
            if (exitCode == 0 && (exitCodeStr[0] != '0' || exitCodeStr[1] != '\0'))
                return false;

            // Exit code should be in range of 0-125, 126-255 is used
            // in many shells for their own return codes and code > 255
            // is not supported in many others
            if (exitCode < 0 || exitCode > 125)
                return false;

            sWorld->ShutdownServ(time, 0, exitCode);
        }
        else
            sWorld->ShutdownServ(time, 0, SHUTDOWN_EXIT_CODE);

        return true;
    }

    static bool HandleServerRestartCommand(ChatHandler* /*handler*/, char const* args)
    {
        if (!*args)
            return false;

        char* timeStr = strtok((char*) args, " ");
        char* exitCodeStr = strtok(nullptr, "");

        int32 time = atoi(timeStr);

        //  Prevent interpret wrong arg value as 0 secs shutdown time
        if ((time == 0 && (timeStr[0] != '0' || timeStr[1] != '\0')) || time < 0)
            return false;

        if (exitCodeStr)
        {
            int32 exitCode = atoi(exitCodeStr);

            // Handle atoi() errors
            if (exitCode == 0 && (exitCodeStr[0] != '0' || exitCodeStr[1] != '\0'))
                return false;

            // Exit code should be in range of 0-125, 126-255 is used
            // in many shells for their own return codes and code > 255
            // is not supported in many others
            if (exitCode < 0 || exitCode > 125)
                return false;

            sWorld->ShutdownServ(time, SHUTDOWN_MASK_RESTART, exitCode);
        }
        else
            sWorld->ShutdownServ(time, SHUTDOWN_MASK_RESTART, RESTART_EXIT_CODE);

            return true;
    }

    static bool HandleServerIdleRestartCommand(ChatHandler* /*handler*/, char const* args)
    {
        if (!*args)
            return false;

        char* timeStr = strtok((char*) args, " ");
        char* exitCodeStr = strtok(nullptr, "");

        int32 time = atoi(timeStr);

        // Prevent interpret wrong arg value as 0 secs shutdown time
        if ((time == 0 && (timeStr[0] != '0' || timeStr[1] != '\0')) || time < 0)
            return false;

        if (exitCodeStr)
        {
            int32 exitCode = atoi(exitCodeStr);

            // Handle atoi() errors
            if (exitCode == 0 && (exitCodeStr[0] != '0' || exitCodeStr[1] != '\0'))
                return false;

            // Exit code should be in range of 0-125, 126-255 is used
            // in many shells for their own return codes and code > 255
            // is not supported in many others
            if (exitCode < 0 || exitCode > 125)
                return false;

            sWorld->ShutdownServ(time, SHUTDOWN_MASK_RESTART | SHUTDOWN_MASK_IDLE, exitCode);
        }
        else
            sWorld->ShutdownServ(time, SHUTDOWN_MASK_RESTART | SHUTDOWN_MASK_IDLE, RESTART_EXIT_CODE);
        return true;
    }

    static bool HandleServerIdleShutDownCommand(ChatHandler* /*handler*/, char const* args)
    {
        if (!*args)
            return false;

        char* timeStr = strtok((char*) args, " ");
        char* exitCodeStr = strtok(nullptr, "");

        int32 time = atoi(timeStr);

        // Prevent interpret wrong arg value as 0 secs shutdown time
        if ((time == 0 && (timeStr[0] != '0' || timeStr[1] != '\0')) || time < 0)
            return false;

        if (exitCodeStr)
        {
            int32 exitCode = atoi(exitCodeStr);

            // Handle atoi() errors
            if (exitCode == 0 && (exitCodeStr[0] != '0' || exitCodeStr[1] != '\0'))
                return false;

            // Exit code should be in range of 0-125, 126-255 is used
            // in many shells for their own return codes and code > 255
            // is not supported in many others
            if (exitCode < 0 || exitCode > 125)
                return false;

            sWorld->ShutdownServ(time, SHUTDOWN_MASK_IDLE, exitCode);
        }
        else
            sWorld->ShutdownServ(time, SHUTDOWN_MASK_IDLE, SHUTDOWN_EXIT_CODE);
            return true;
    }

    // Exit the realm
    static bool HandleServerExitCommand(ChatHandler* handler, char const* /*args*/)
    {
        handler->SendSysMessage(LANG_COMMAND_EXIT);
        World::StopNow(SHUTDOWN_EXIT_CODE);
        return true;
    }

    // Define the 'Message of the day' for the realm
    static bool HandleServerSetMotdCommand(ChatHandler* handler, char const* args)
    {
        Motd::SetMotd(args);
        handler->PSendSysMessage(LANG_MOTD_NEW, args);
        return true;
    }

    // Set whether we accept new clients
    static bool HandleServerSetClosedCommand(ChatHandler* handler, char const* args)
    {
        if (strncmp(args, "on", 3) == 0)
        {
            handler->SendSysMessage(LANG_WORLD_CLOSED);
            sWorld->SetClosed(true);
            return true;
        }
        else if (strncmp(args, "off", 4) == 0)
        {
            handler->SendSysMessage(LANG_WORLD_OPENED);
            sWorld->SetClosed(false);
            return true;
        }

        handler->SendSysMessage(LANG_USE_BOL);
        handler->SetSentErrorMessage(true);
        return false;
    }

    // Set the level of logging
    static bool HandleServerSetLogFileLevelCommand(ChatHandler* /*handler*/, char const* args)
    {
        if (!*args)
            return false;

        char* newLevel = strtok((char*)args, " ");
        if (!newLevel)
            return false;

        sLog->SetLogFileLevel(newLevel);
        return true;
    }

    // Set the level of logging
    static bool HandleServerSetLogLevelCommand(ChatHandler* /*handler*/, char const* args)
    {
        if (!*args)
            return false;

        char* newLevel = strtok((char*)args, " ");
        if (!newLevel)
            return false;

        sLog->SetLogLevel(newLevel);
        return true;
    }

    // set diff time record interval
    static bool HandleServerSetDiffTimeCommand(ChatHandler* /*handler*/, char const* args)
    {
        if (!*args)
            return false;

        char* newTimeStr = strtok((char*)args, " ");
        if (!newTimeStr)
            return false;

        int32 newTime = atoi(newTimeStr);
        if (newTime < 0)
            return false;

        sWorld->SetRecordDiffInterval(newTime);
        printf("Record diff every %u ms\n", newTime);

        return true;
    }

    // toggle sql driver query logging
    static bool HandleServerToggleQueryLogging(ChatHandler* handler, char const* /*args*/)
    {
        sLog->SetSQLDriverQueryLogging(!sLog->GetSQLDriverQueryLogging());

        if (sLog->GetSQLDriverQueryLogging())
            handler->PSendSysMessage(LANG_SQLDRIVER_QUERY_LOGGING_ENABLED);
        else
            handler->PSendSysMessage(LANG_SQLDRIVER_QUERY_LOGGING_DISABLED);
        return true;
    }
};

void AddSC_server_commandscript()
{
    new server_commandscript();
}

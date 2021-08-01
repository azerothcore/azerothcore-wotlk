/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

/// \addtogroup Acored
/// @{
/// \file

#include "AccountMgr.h"
#include "Chat.h"
#include "CliRunnable.h"
#include "Common.h"
#include "Config.h"
#include "Language.h"
#include "Log.h"
#include "MapManager.h"
#include "ObjectMgr.h"
#include "Player.h"
#include "Util.h"
#include "World.h"
#include "WorldSession.h"

static constexpr char CLI_PREFIX[] = "AC> ";

static inline void PrintCliPrefix()
{
    printf("%s", CLI_PREFIX);
}

#if AC_PLATFORM != AC_PLATFORM_WINDOWS
#include <readline/readline.h>
#include <readline/history.h>

char* command_finder(const char* text, int state)
{
    static size_t idx, len;
    const char* ret;
    std::vector<ChatCommand> const& cmd = ChatHandler::getCommandTable();

    if (!state)
    {
        idx = 0;
        len = strlen(text);
    }

    while (idx < cmd.size())
    {
        ret = cmd[idx].Name;
        if (!cmd[idx].AllowConsole)
        {
            ++idx;
            continue;
        }

        ++idx;
        //printf("Checking %s \n", cmd[idx].Name);
        if (strncmp(ret, text, len) == 0)
            return strdup(ret);
    }

    return ((char*)nullptr);
}

char** cli_completion(const char* text, int start, int /*end*/)
{
    char** matches = nullptr;

    if (start)
        rl_bind_key('\t', rl_abort);
    else
        matches = rl_completion_matches((char*)text, &command_finder);
    return matches;
}

int cli_hook_func()
{
    if (World::IsStopped())
        rl_done = 1;
    return 0;
}

#endif

void utf8print(void* /*arg*/, const char* str)
{
#if AC_PLATFORM == AC_PLATFORM_WINDOWS
    wchar_t wtemp_buf[6000];
    size_t wtemp_len = 6000 - 1;
    if (!Utf8toWStr(str, strlen(str), wtemp_buf, wtemp_len))
        return;

    char temp_buf[6000];
    CharToOemBuffW(&wtemp_buf[0], &temp_buf[0], wtemp_len + 1);
    printf(temp_buf);
#else
    {
        printf("%s", str);
        fflush(stdout);
    }
#endif
}

void commandFinished(void*, bool /*success*/)
{
    PrintCliPrefix();
    fflush(stdout);
}

#ifdef linux
// Non-blocking keypress detector, when return pressed, return 1, else always return 0
int kb_hit_return()
{
    struct timeval tv;
    fd_set fds;
    tv.tv_sec = 0;
    tv.tv_usec = 0;
    FD_ZERO(&fds);
    FD_SET(STDIN_FILENO, &fds);
    select(STDIN_FILENO + 1, &fds, nullptr, nullptr, &tv);
    return FD_ISSET(STDIN_FILENO, &fds);
}
#endif

/// %Thread start
void CliThread()
{
    ///- Display the list of available CLI functions then beep
    //TC_LOG_INFO("server.worldserver", "");
#if AC_PLATFORM != AC_PLATFORM_WINDOWS
    rl_attempted_completion_function = cli_completion;
    rl_event_hook = cli_hook_func;
#endif

    if (sConfigMgr->GetOption<bool>("BeepAtStart", true))
        printf("\a");                                       // \a = Alert

    // print this here the first time
    // later it will be printed after command queue updates
    PrintCliPrefix();

    ///- As long as the World is running (no World::m_stopEvent), get the command line and handle it
    while (!World::IsStopped())
    {
        fflush(stdout);

        char* command_str ;             // = fgets(commandbuf, sizeof(commandbuf), stdin);

#if AC_PLATFORM == AC_PLATFORM_WINDOWS
        char commandbuf[256];
        command_str = fgets(commandbuf, sizeof(commandbuf), stdin);
#else
        command_str = readline(CLI_PREFIX);
        rl_bind_key('\t', rl_complete);
#endif

        if (command_str != nullptr)
        {
            for (int x = 0; command_str[x]; ++x)
                if (command_str[x] == '\r' || command_str[x] == '\n')
                {
                    command_str[x] = 0;
                    break;
                }

            if (!*command_str)
            {
#if AC_PLATFORM == AC_PLATFORM_WINDOWS
                PrintCliPrefix();
#else
                free(command_str);
#endif
                continue;
            }

            std::string command;
            if (!consoleToUtf8(command_str, command))         // convert from console encoding to utf8
            {
#if AC_PLATFORM == AC_PLATFORM_WINDOWS
                PrintCliPrefix();
#else
                free(command_str);
#endif
                continue;
            }

            fflush(stdout);
            sWorld->QueueCliCommand(new CliCommandHolder(nullptr, command.c_str(), &utf8print, &commandFinished));
#if AC_PLATFORM != AC_PLATFORM_WINDOWS
            add_history(command.c_str());
            free(command_str);
#endif
        }
        else if (feof(stdin))
        {
            World::StopNow(SHUTDOWN_EXIT_CODE);
        }
    }
}

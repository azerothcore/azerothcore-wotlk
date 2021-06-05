/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include "Common.h"
#include "Errors.h"
#include "ObjectMgr.h"
#include "World.h"
#include "Config.h"
#include "CliRunnable.h"
#include "Log.h"
#include "Util.h"

#if ACORE_PLATFORM != ACORE_PLATFORM_WINDOWS
#include "Chat.h"
#include "ChatCommand.h"
#include <cstring>
#include <readline/readline.h>
#include <readline/history.h>
#endif

static constexpr char CLI_PREFIX[] = "AC> ";

static inline void PrintCliPrefix()
{
    printf("%s", CLI_PREFIX);
}

#if ACORE_PLATFORM != ACORE_PLATFORM_WINDOWS
namespace Acore::Impl::Readline
{
    static std::vector<std::string> vec;
    char* cli_unpack_vector(char const*, int state)
    {
        static size_t i=0;
        if (!state)
            i = 0;
        if (i < vec.size())
            return strdup(vec[i++].c_str());
        else
            return nullptr;
    }

    char** cli_completion(char const* text, int /*start*/, int /*end*/)
    {
        ::rl_attempted_completion_over = 1;
        vec = Acore::ChatCommands::GetAutoCompletionsFor(CliHandler(nullptr,nullptr), text);
        return ::rl_completion_matches(text, &cli_unpack_vector);
    }

    int cli_hook_func()
    {
           if (World::IsStopped())
               ::rl_done = 1;
           return 0;
    }
}
#endif

void utf8print(void* /*arg*/, std::string_view str)
{
#if ACORE_PLATFORM == ACORE_PLATFORM_WINDOWS
    std::wstring wbuf;
    if (!Utf8toWStr(str, wbuf))
        return;

    wprintf(L"%s", wbuf.c_str());
#else
{
    printf(STRING_VIEW_FMT, STRING_VIEW_FMT_ARG(str));
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
    select(STDIN_FILENO+1, &fds, nullptr, nullptr, &tv);
    return FD_ISSET(STDIN_FILENO, &fds);
}
#endif

/// %Thread start
void CliRunnable::run()
{
#if ACORE_PLATFORM == ACORE_PLATFORM_WINDOWS
    // print this here the first time
    // later it will be printed after command queue updates
    PrintCliPrefix();
#else
    ::rl_attempted_completion_function = &Acore::Impl::Readline::cli_completion;
    {
        static char BLANK = '\0';
        ::rl_completer_word_break_characters = &BLANK;
    }
    ::rl_event_hook = &Acore::Impl::Readline::cli_hook_func;
#endif

    if (sConfigMgr->GetBoolDefault("BeepAtStart", true))
        printf("\a"); // \a = Alert

    ///- As long as the World is running (no World::m_stopEvent), get the command line and handle it
    while (!World::IsStopped())
    {
        fflush(stdout);

        std::string command;

#if WARHEAD_PLATFORM == WARHEAD_PLATFORM_WINDOWS
        wchar_t commandbuf[256];
        if (fgetws(commandbuf, sizeof(commandbuf), stdin))
        {
            if (!WStrToUtf8(commandbuf, wcslen(commandbuf), command))
            {
                PrintCliPrefix();
                continue;
            }
        }
#else
        char* command_str = readline(CLI_PREFIX);
        ::rl_bind_key('\t', ::rl_complete);
        if (command_str != nullptr)
        {
            command = command_str;
            free(command_str);
        }
#endif

        if (!command.empty())
        {
            std::size_t nextLineIndex = command.find_first_of("\r\n");
            if (nextLineIndex != std::string::npos)
            {
                if (nextLineIndex == 0)
                {
#if ACORE_PLATFORM == ACORE_PLATFORM_WINDOWS
                    PrintCliPrefix();
#endif
                    continue;
                }

                command.erase(nextLineIndex);
            }

            fflush(stdout);
            sWorld->QueueCliCommand(new CliCommandHolder(nullptr, command.c_str(), &utf8print, &commandFinished));
#if ACORE_PLATFORM != ACORE_PLATFORM_WINDOWS
            add_history(command.c_str());
#endif
        }
        else if (feof(stdin))
        {
            World::StopNow(SHUTDOWN_EXIT_CODE);
        }
    }
}
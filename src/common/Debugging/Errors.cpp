/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include "Errors.h"

#include <ace/Stack_Trace.h>
#include <ace/OS_NS_unistd.h>
#include <cstdlib>

namespace Trinity {

void Assert(char const* file, int line, char const* function, char const* message)
{
    ACE_Stack_Trace st;
    fprintf(stderr, "\n%s:%i in %s ASSERTION FAILED:\n  %s\n%s\n",
            file, line, function, message, st.c_str());
    *((volatile int*)NULL) = 0;
    exit(1);
}

void Fatal(char const* file, int line, char const* function, char const* message)
{
    fprintf(stderr, "\n%s:%i in %s FATAL ERROR:\n  %s\n",
                   file, line, function, message);
    ACE_OS::sleep(10);
    *((volatile int*)NULL) = 0;
    exit(1);
}

void Error(char const* file, int line, char const* function, char const* message)
{
    fprintf(stderr, "\n%s:%i in %s ERROR:\n  %s\n",
                   file, line, function, message);
    *((volatile int*)NULL) = 0;
    exit(1);
}

void Warning(char const* file, int line, char const* function, char const* message)
{
    fprintf(stderr, "\n%s:%i in %s WARNING:\n  %s\n",
                   file, line, function, message);
}

} // namespace Trinity

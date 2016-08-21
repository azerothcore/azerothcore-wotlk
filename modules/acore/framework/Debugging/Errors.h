/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: http://github.com/azerothcore/azerothcore-wotlk/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef AZEROTHCORE_ERRORS_H
#define AZEROTHCORE_ERRORS_H

#include "Define.h"

namespace Trinity
{

    DECLSPEC_NORETURN void Assert(char const* file, int line, char const* function, char const* message) ATTR_NORETURN;

    DECLSPEC_NORETURN void Fatal(char const* file, int line, char const* function, char const* message) ATTR_NORETURN;

    DECLSPEC_NORETURN void Error(char const* file, int line, char const* function, char const* message) ATTR_NORETURN;

    void Warning(char const* file, int line, char const* function, char const* message);

} // namespace Trinity

#define WPAssert(cond) do { if (!(cond)) Trinity::Assert(__FILE__, __LINE__, __FUNCTION__, #cond); } while (0)
#define WPFatal(cond, msg) do { if (!(cond)) Trinity::Fatal(__FILE__, __LINE__, __FUNCTION__, (msg)); } while (0)
#define WPError(cond, msg) do { if (!(cond)) Trinity::Error(__FILE__, __LINE__, __FUNCTION__, (msg)); } while (0)
#define WPWarning(cond, msg) do { if (!(cond)) Trinity::Warning(__FILE__, __LINE__, __FUNCTION__, (msg)); } while (0)

#define ASSERT WPAssert

#endif

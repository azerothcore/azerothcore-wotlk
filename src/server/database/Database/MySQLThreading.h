/*
 * Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2021+ WarheadCore <https://github.com/WarheadCore>
 */

#ifndef _MYSQLTHREADING_H
#define _MYSQLTHREADING_H

#include "Define.h"

namespace MySQL
{
    AC_DATABASE_API void Library_Init();
    AC_DATABASE_API void Library_End();
    AC_DATABASE_API uint32 GetLibraryVersion();
}

#endif

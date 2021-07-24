/*
 * Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
 * Copyright (C) 2021+ WarheadCore <https://github.com/WarheadCore>
 */

#ifndef _PROCESSPRIO_H
#define _PROCESSPRIO_H

#include "Define.h"
#include <string>

#define CONFIG_PROCESSOR_AFFINITY "UseProcessors"
#define CONFIG_HIGH_PRIORITY "ProcessPriority"

void AC_COMMON_API SetProcessPriority(std::string const& logChannel, uint32 affinity, bool highPriority);

#endif

/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef DATABASEENV_H
#define DATABASEENV_H

#include "Common.h"
#include "Errors.h"
#include "Log.h"

#include "Field.h"
#include "QueryResult.h"

#include "MySQLThreading.h"
#include "Transaction.h"

#define _LIKE_           "LIKE"
#define _TABLE_SIM_      "`"
#define _CONCAT3_(A, B, C) "CONCAT( " A ", " B ", " C " )"
#define _OFFSET_         "LIMIT %d, 1"

#include "Implementation/LoginDatabase.h"
#include "Implementation/CharacterDatabase.h"
#include "Implementation/WorldDatabase.h"

extern WorldDatabaseWorkerPool WorldDatabase;
extern CharacterDatabaseWorkerPool CharacterDatabase;
extern LoginDatabaseWorkerPool LoginDatabase;

#endif

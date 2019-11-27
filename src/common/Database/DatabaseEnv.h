/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef _DATABASEENV_H_
#define _DATABASEENV_H_

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

#include "LoginDatabase.h"
#include "CharacterDatabase.h"
#include "WorldDatabase.h"

/// Accessor to the world database
extern WorldDatabaseWorkerPool WorldDatabase;

/// Accessor to the character database
extern CharacterDatabaseWorkerPool CharacterDatabase;

/// Accessor to the realm/login database
extern LoginDatabaseWorkerPool LoginDatabase;

#endif

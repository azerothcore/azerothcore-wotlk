/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef DATABASEENV_H
#define DATABASEENV_H

#include "Define.h"
#include "DatabaseWorkerPool.h"

#include "Implementation/LoginDatabase.h"
#include "Implementation/CharacterDatabase.h"
#include "Implementation/WorldDatabase.h"

#include "Field.h"
#include "PreparedStatement.h"
#include "QueryCallback.h"
#include "QueryResult.h"
#include "Transaction.h"

/// Accessor to the world database
extern DatabaseWorkerPool<WorldDatabaseConnection> WorldDatabase;
/// Accessor to the character database
extern DatabaseWorkerPool<CharacterDatabaseConnection> CharacterDatabase;
/// Accessor to the realm/login database
extern DatabaseWorkerPool<LoginDatabaseConnection> LoginDatabase;

#endif

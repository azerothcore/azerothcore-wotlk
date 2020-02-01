/*
* Copyright (C) 2016+     AzerothCore <www.azerothcore.org>
* Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
* Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
*/

#ifndef MySQLHacks_h__
#define MySQLHacks_h__

#include "MySQLWorkaround.h"
#include <type_traits>

struct MySQLHandle : MYSQL { };
struct MySQLResult : MYSQL_RES { };
struct MySQLField : MYSQL_FIELD { };
struct MySQLBind : MYSQL_BIND { };
struct MySQLStmt : MYSQL_STMT { };

// mysql 8 removed my_bool typedef (it was char) and started using bools directly
// to maintain compatibility we use this trick to retrieve which type is being used
using MySQLBool = std::remove_pointer_t<decltype(std::declval<MYSQL_BIND>().is_null)>;

#endif // MySQLHacks_h__
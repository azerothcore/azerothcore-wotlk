/*
 * Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
 * Copyright (C) 2021+ WarheadCore <https://github.com/WarheadCore>
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

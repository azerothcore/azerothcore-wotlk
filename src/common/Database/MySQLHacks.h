/*
 * Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
 */

#ifndef AZEROTHCORE_MYSQLHACKS_H
#define AZEROTHCORE_MYSQLHACKS_H

#endif //AZEROTHCORE_MYSQLHACKS_H

#if MYSQL_VERSION_ID >= 80001
typedef bool my_bool;
#endif

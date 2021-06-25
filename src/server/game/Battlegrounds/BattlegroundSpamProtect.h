/*
 * Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
 * Copyright (C) 2021+ WarheadCore <https://github.com/WarheadCore>
 */

#ifndef _BATTLEGROUND_SPAM_PROTECT_H_
#define _BATTLEGROUND_SPAM_PROTECT_H_

#include "Define.h"

class Player;
class Battleground;

class AC_GAME_API BGSpamProtect
{
public:
    static BGSpamProtect* instance();

    bool CanAnnounce(Player* player, Battleground* bg, uint32 minLevel, uint32 queueTotal);
};

#define sBGSpam BGSpamProtect::instance()

#endif

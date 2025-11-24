/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
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

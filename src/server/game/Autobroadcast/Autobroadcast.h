/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU Affero General Public License as published by the
 * Free Software Foundation; either version 3 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#ifndef _AUTO_BROAD_CAST_H_
#define _AUTO_BROAD_CAST_H_

#include "Common.h"
#include <unordered_map>

enum class AnnounceType : uint8
{
    WORLD = 0,
    NOTIFICATION,
    BOTH
};

class AC_GAME_API AutobroadcastMgr
{
public:
    static AutobroadcastMgr* instance();

    void Load();
    void Send();

private:
    using AutoBroadCastStore = std::unordered_map<uint8, std::string>;
    using AutoBroadCastWeightsStore = std::unordered_map<uint8, uint8>;

    AutoBroadCastStore _autobroadcasts;
    AutoBroadCastWeightsStore _autobroadcastsWeights;
};

#define sAutobroadcastMgr AutobroadcastMgr::instance()

#endif

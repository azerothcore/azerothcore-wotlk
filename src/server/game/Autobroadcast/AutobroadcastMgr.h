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

#ifndef _AUTOBROADCASTMGR_H_
#define _AUTOBROADCASTMGR_H_

#include "Common.h"
#include <map>

enum class AnnounceType : uint8
{
    World = 0,
    Notification = 1,
    Both = 2,
};

class AC_GAME_API AutobroadcastMgr
{
public:
    static AutobroadcastMgr* instance();

    void LoadAutobroadcasts();
    void SendAutobroadcasts();

private:
    void SendWorldAnnouncement(std::string msg);
    void SendNotificationAnnouncement(std::string msg);

    typedef std::map<uint8, std::string> AutobroadcastsMap;
    typedef std::map<uint8, uint8> AutobroadcastsWeightMap;

    AutobroadcastsMap _autobroadcasts;
    AutobroadcastsWeightMap _autobroadcastsWeights;

    AnnounceType _announceType;
};

#define sAutobroadcastMgr AutobroadcastMgr::instance()

#endif // _AUTOBROADCASTMGR_H_

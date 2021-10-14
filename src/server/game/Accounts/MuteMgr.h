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

#ifndef _MUTE_MANAGER_H_
#define _MUTE_MANAGER_H_

#include "Common.h"
#include "Duration.h"
#include "Optional.h"
#include <tuple>
#include <unordered_map>

using MuteInfo = std::tuple<uint64, Seconds, std::string, std::string>;

class AC_GAME_API MuteMgr
{
public:
    static MuteMgr* instance();

    void MutePlayer(std::string const& targetName, Seconds muteTime, std::string const& muteBy, std::string const& muteReason);
    void UnMutePlayer(std::string const& targetName);
    void UpdateMuteAccount(uint32 accountID, uint64 muteDate);
    void SetMuteTime(uint32 accountID, uint64 muteDate);
    void SetMuteTime(uint32 accountID, Seconds muteTime);
    uint64 GetMuteDate(uint32 accountID);
    std::string const GetMuteTimeString(uint32 accountID);
    void DeleteMuteTime(uint32 accountID, bool delFromDB = true);
    void CheckMuteExpired(uint32 accountID);
    bool CanSpeak(uint32 accountID);
    void CheckSpeakTime(uint32 accountID, time_t muteDate);
    void LoginAccount(uint32 accountID);
    Optional<std::tuple<uint64, Seconds, std::string, std::string>> GetMuteInfo(uint32 accountID);

private:
    std::unordered_map<uint32 /*acc id*/, uint64 /*unix time*/> _listSessions;
};

#define sMute MuteMgr::instance()

#endif // _MUTE_MANAGER_H_

/*
 * Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
 * Copyright (C) 2021+ WarheadCore <https://github.com/WarheadCore>
 */

#ifndef _MUTE_MANAGER_H_
#define _MUTE_MANAGER_H_

#include "Common.h"
#include "Duration.h"
#include "Optional.h"
#include <tuple>
#include <unordered_map>

class AC_GAME_API MuteMgr
{
public:
    static MuteMgr* instance();

    void MutePlayer(std::string const& targetName, Seconds notSpeakTime, std::string const& muteBy, std::string const& muteReason);
    void UnMutePlayer(std::string const& targetName);
    void UpdateMuteAccount(uint32 accountID, uint64 muteDate, Seconds muteTime);
    void SetMuteTime(uint32 accountID, uint64 muteDate);
    void AddMuteTime(uint32 accountID, Seconds muteTime);
    uint64 GetMuteDate(uint32 accountID);
    std::string const GetMuteTimeString(uint32 accountID);
    void DeleteMuteTime(uint32 accountID, bool delFromDB = true);
    void CheckMuteExpired(uint32 accountID);
    bool CanSpeak(uint32 accountID);
    void CheckSpeakTime(uint32 accountID, time_t muteDate);
    void LoginAccount(uint32 accountID);
    Optional<std::tuple<uint32, Seconds, std::string, std::string>> GetMuteInfo(uint32 accountID);

private:
    std::unordered_map<uint32 /*acc id*/, uint64 /*unix time*/> _listSessions;
};

#define sMute MuteMgr::instance()

#endif // _MUTE_MANAGER_H_

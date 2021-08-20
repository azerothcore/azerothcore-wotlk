/*
 * Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
 * Copyright (C) 2021+ WarheadCore <https://github.com/WarheadCore>
 */

#include "MuteMgr.h"
#include "Chat.h"
#include "DatabaseEnv.h"
#include "Language.h"
#include "ObjectMgr.h"
#include "Player.h"
#include "Timer.h"
#include "World.h"

MuteMgr* MuteMgr::instance()
{
    static MuteMgr instance;
    return &instance;
}

void MuteMgr::MutePlayer(std::string const& targetName, Seconds notSpeakTime, std::string const& muteBy, std::string const& muteReason)
{
    uint32 accountId = sObjectMgr->GetPlayerAccountIdByPlayerName(targetName);
    auto targetSession = sWorld->FindSession(accountId);

    // INSERT INTO `account_muted` (`accountid`, `mutedate`, `mutetime`, `mutedby`, `mutereason`, `active`) VALUES (?, ?, ?, ?, ?, 1)
    LoginDatabasePreparedStatement* stmt = LoginDatabase.GetPreparedStatement(LOGIN_INS_ACCOUNT_MUTE);
    stmt->setUInt32(0, accountId);

    /*
     * Mute will be in effect right away.
     * If Mute.AddAfterLogin.Enable mute will be in effect starting from the next login.
     */
    uint64 muteDate = sWorld->getBoolConfig(CONFIG_MUTE_ADD_AFTER_LOGIN) && !targetSession ? 0 : time(nullptr);

    if (targetSession)
    {
        AddMuteTime(accountId, notSpeakTime);
    }

    stmt->setUInt64(1, time(nullptr));
    stmt->setUInt32(2, notSpeakTime.count());
    stmt->setString(3, muteBy);
    stmt->setString(4, muteReason);
    LoginDatabase.Execute(stmt);

    auto GetPlayerLink = [&]()
    {
        return "|cffffffff|Hplayer:" + targetName + "|h[" + targetName + "]|h|r";
    };

    if (sWorld->getBoolConfig(CONFIG_SHOW_MUTE_IN_WORLD))
    {
        sWorld->SendWorldText(LANG_COMMAND_MUTEMESSAGE_WORLD, muteBy.c_str(), GetPlayerLink().c_str(), notSpeakTime.count(), muteReason.c_str());
    }

    if (targetSession)
    {
        ChatHandler(targetSession).PSendSysMessage(LANG_YOUR_CHAT_DISABLED, secsToTimeString(notSpeakTime.count()).c_str(), muteBy.c_str(), muteReason.c_str());
    }
}

void MuteMgr::UnMutePlayer(std::string const& targetName)
{
    uint32 accountId = sObjectMgr->GetPlayerAccountIdByPlayerName(targetName);

    DeleteMuteTime(accountId);

    if (auto targetSession = sWorld->FindSession(accountId))
    {
        ChatHandler(targetSession).SendSysMessage(LANG_YOUR_CHAT_ENABLED);
    }
}

void MuteMgr::AddMuteTime(uint32 accountID, Seconds muteTime)
{
    // Check exist
    auto itr = _listSessions.find(accountID);
    if (itr != _listSessions.end())
    {
        FMT_LOG_INFO("entities.player", "> MuteMgr::AddMuteTime: Account {} not found in mute manager!", accountID);
        return;
    }

    _listSessions.emplace(accountID, time(nullptr) + muteTime.count());
}

void MuteMgr::SetMuteTime(uint32 accountID, uint64 muteDate)
{
    if (!sWorld->FindSession(accountID))
    {
        // Skip if player offline
        return;
    }

    // Check empty
    auto itr = _listSessions.find(accountID);
    if (itr == _listSessions.end())
    {
        FMT_LOG_INFO("entities.player", "> MuteMgr::SetMuteTime: Account {} not found in mute manager!", accountID);
        return;
    }

    _listSessions.erase(accountID);
    _listSessions.emplace(accountID, muteDate);
}

uint64 MuteMgr::GetMuteDate(uint32 accountID)
{
    // Check exist
    auto itr = _listSessions.find(accountID);
    if (itr == _listSessions.end())
    {
        return 0;
    }

    return _listSessions.at(accountID);
}

void MuteMgr::DeleteMuteTime(uint32 accountID, bool delFromDB /*= true*/)
{
    if (delFromDB)
    {
        // UPDATE `account_muted` SET `active` = 0 WHERE `active` = 1 AND `accountid` = ?
        LoginDatabasePreparedStatement* stmt = LoginDatabase.GetPreparedStatement(LOGIN_DEL_ACCOUNT_MUTE);
        stmt->setUInt32(0, accountID);
        LoginDatabase.Execute(stmt);
    }

    // Check exist account muted
    auto itr = _listSessions.find(accountID);
    if (itr == _listSessions.end())
    {
        return;
    }

    _listSessions.erase(accountID);
}

void MuteMgr::CheckMuteExpired(uint32 accountID)
{
    auto _muteTime = GetMuteDate(accountID);
    auto timeNow = time(nullptr);

    if (!_muteTime || _muteTime > timeNow)
    {
        //
        return;
    }

    DeleteMuteTime(accountID);
}

std::string const MuteMgr::GetMuteTimeString(uint32 accountID)
{
    uint64 muteDate = GetMuteDate(accountID);

    if (!muteDate)
    {
        // Return empry string if no data
        return "";
    }

    return secsToTimeString(muteDate - time(nullptr), true);
}

bool MuteMgr::CanSpeak(uint32 accountID)
{
    return GetMuteDate(accountID) <= time(nullptr);
}

void MuteMgr::LoginAccount(uint32 accountID)
{
    // Set inactive if expired
    // UPDATE `account_muted` SET `active` = 0 WHERE `active` = 1 AND `mutetime` > 0 AND `accountid` = ? AND UNIX_TIMESTAMP() >= `mutedate` + `mutetime`
    LoginDatabasePreparedStatement* stmt = LoginDatabase.GetPreparedStatement(LOGIN_UPD_ACCOUNT_MUTE_EXPIRED);
    stmt->setUInt32(0, accountID);
    LoginDatabase.Execute(stmt);

    // Get info about mute time after update active
    // SELECT `mutedate`, `mutetime` FROM `account_muted` WHERE `accountid` = ? AND `active` = 1 AND UNIX_TIMESTAMP() <= `mutedate` + ABS(`mutetime`) ORDER BY `mutedate` + ABS(`mutetime`) DESC LIMIT 1
    stmt = LoginDatabase.GetPreparedStatement(LOGIN_SEL_ACCOUNT_MUTE);
    stmt->setUInt32(0, accountID);

    PreparedQueryResult result = LoginDatabase.Query(stmt);
    if (!result)
    {
        // If no info - no mute time :)
        return;
    }

    Field* fields = result->Fetch();
    uint32 mutedate = fields[0].GetUInt32();
    Seconds mutetime = Seconds(fields[1].GetInt32());

    if (!mutedate)
    {
        // Set now time (add mute after login)
        mutedate = time(nullptr);
    }

    UpdateMuteAccount(accountID, mutedate, mutetime);
}

void MuteMgr::UpdateMuteAccount(uint32 accountID, uint64 muteDate, Seconds muteTime)
{
    // UPDATE `account_muted` SET `mutedate` = ? WHERE `accountid` = ?
    LoginDatabasePreparedStatement* stmt = LoginDatabase.GetPreparedStatement(LOGIN_UPD_ACCOUNT_MUTE_DATE);
    stmt->setUInt32(0, muteDate);
    stmt->setUInt32(1, accountID);
    LoginDatabase.Execute(stmt);

    SetMuteTime(accountID, muteDate);
}

Optional<std::tuple<uint32, Seconds, std::string, std::string>> MuteMgr::GetMuteInfo(uint32 accountID)
{
    LoginDatabasePreparedStatement* stmt = LoginDatabase.GetPreparedStatement(LOGIN_SEL_ACCOUNT_MUTE);
    stmt->setUInt32(0, accountID);

    PreparedQueryResult result = LoginDatabase.Query(stmt);
    if (!result)
    {
        return std::nullopt;
    }

    Field* fields = result->Fetch();

    return std::make_tuple(fields[0].GetUInt32(), Seconds(fields[1].GetUInt32()), fields[2].GetString(), fields[3].GetString());
}

void MuteMgr::CheckSpeakTime(uint32 accountID, time_t muteDate)
{
    if (GetMuteDate(accountID) < muteDate)
    {
        SetMuteTime(accountID, muteDate);
    }
}

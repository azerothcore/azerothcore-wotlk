/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU AGPL3 v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
 */

#include "BanManager.h"
#include "AccountMgr.h"
#include "DatabaseEnv.h"
#include "ObjectAccessor.h"
#include "ObjectMgr.h"
#include "Player.h"
#include "Language.h"
#include "ScriptMgr.h"
#include "World.h"
#include "WorldSession.h"

BanManager* BanManager::instance()
{
    static BanManager instance;
    return &instance;
}

/// Ban an account, duration will be parsed using TimeStringToSecs if it is positive, otherwise permban
BanReturn BanManager::BanAccount(std::string const& AccountName, std::string const& Duration, std::string const& Reason, std::string const& Author)
{
    if (AccountName.empty() || Duration.empty())
        return BAN_SYNTAX_ERROR;

    uint32 DurationSecs = TimeStringToSecs(Duration);

    uint32 AccountID = AccountMgr::GetId(AccountName);
    if (!AccountID)
        return BAN_NOTFOUND;

    ///- Disconnect all affected players (for IP it can be several)
    SQLTransaction trans = LoginDatabase.BeginTransaction();
        
    // pussywizard: check existing ban to prevent overriding by a shorter one! >_>
    PreparedStatement* stmtAccountBanned = LoginDatabase.GetPreparedStatement(LOGIN_SEL_ACCOUNT_BANNED);
    stmtAccountBanned->setUInt32(0, AccountID);

    PreparedQueryResult banresult = LoginDatabase.Query(stmtAccountBanned);
    if (banresult && ((*banresult)[0].GetUInt32() == (*banresult)[1].GetUInt32() || ((*banresult)[1].GetUInt32() > time(nullptr) + DurationSecs && DurationSecs)))
        return BAN_LONGER_EXISTS;

    // make sure there is only one active ban
    PreparedStatement* stmt = LoginDatabase.GetPreparedStatement(LOGIN_UPD_ACCOUNT_NOT_BANNED);
    stmt->setUInt32(0, AccountID);
    trans->Append(stmt);

    // No SQL injection with prepared statements
    stmt = LoginDatabase.GetPreparedStatement(LOGIN_INS_ACCOUNT_BANNED);
    stmt->setUInt32(0, AccountID);
    stmt->setUInt32(1, DurationSecs);
    stmt->setString(2, Author);
    stmt->setString(3, Reason);
    trans->Append(stmt);

    if (WorldSession* session = sWorld->FindSession(AccountID))
        if (session->GetPlayerName() != Author)
            session->KickPlayer("Ban Account at condition 'FindSession(account)->GetPlayerName() != author'");

    if (WorldSession* session = sWorld->FindOfflineSession(AccountID))
        if (session->GetPlayerName() != Author)
            session->KickPlayer("Ban Account at condition 'FindOfflineSession(account)->GetPlayerName() != author'");

    LoginDatabase.CommitTransaction(trans);

    if (sWorld->getBoolConfig(CONFIG_SHOW_BAN_IN_WORLD))
    {
        bool IsPermanetly = true;

        if (TimeStringToSecs(Duration) > 0)
            IsPermanetly = false;

        if (!IsPermanetly)
            sWorld->SendWorldText(LANG_BAN_ACCOUNT_YOUBANNEDMESSAGE_WORLD, Author.c_str(), AccountName.c_str(), secsToTimeString(TimeStringToSecs(Duration), true).c_str(), Reason.c_str());
        else
            sWorld->SendWorldText(LANG_BAN_ACCOUNT_YOUPERMBANNEDMESSAGE_WORLD, Author.c_str(), AccountName.c_str(), Reason.c_str());
    }

    return BAN_SUCCESS;
}

/// Ban an account by player name, duration will be parsed using TimeStringToSecs if it is positive, otherwise permban
BanReturn BanManager::BanAccountByPlayerName(std::string const& CharacterName, std::string const& Duration, std::string const& Reason, std::string const& Author)
{
    if (CharacterName.empty() || Duration.empty())
        return BAN_SYNTAX_ERROR;

    uint32 DurationSecs = TimeStringToSecs(Duration);

    uint32 AccountID = sObjectMgr->GetPlayerAccountIdByPlayerName(CharacterName);
    if (!AccountID)
        return BAN_NOTFOUND;

    ///- Disconnect all affected players (for IP it can be several)
    SQLTransaction trans = LoginDatabase.BeginTransaction();

    // pussywizard: check existing ban to prevent overriding by a shorter one! >_>
    PreparedStatement* stmtAccountBanned = LoginDatabase.GetPreparedStatement(LOGIN_SEL_ACCOUNT_BANNED);
    stmtAccountBanned->setUInt32(0, AccountID);

    PreparedQueryResult banresult = LoginDatabase.Query(stmtAccountBanned);
    if (banresult && ((*banresult)[0].GetUInt32() == (*banresult)[1].GetUInt32() || ((*banresult)[1].GetUInt32() > time(nullptr) + DurationSecs && DurationSecs)))
        return BAN_LONGER_EXISTS;

    // make sure there is only one active ban
    PreparedStatement * stmt = LoginDatabase.GetPreparedStatement(LOGIN_UPD_ACCOUNT_NOT_BANNED);
    stmt->setUInt32(0, AccountID);
    trans->Append(stmt);

    // No SQL injection with prepared statements
    stmt = LoginDatabase.GetPreparedStatement(LOGIN_INS_ACCOUNT_BANNED);
    stmt->setUInt32(0, AccountID);
    stmt->setUInt32(1, DurationSecs);
    stmt->setString(2, Author);
    stmt->setString(3, Reason);
    trans->Append(stmt);

    if (WorldSession* session = sWorld->FindSession(AccountID))
        if (session->GetPlayerName() != Author)
            session->KickPlayer("Ban Account at condition 'FindSession(account)->GetPlayerName() != author'");

    if (WorldSession* session = sWorld->FindOfflineSession(AccountID))
        if (session->GetPlayerName() != Author)
            session->KickPlayer("Ban Account at condition 'FindOfflineSession(account)->GetPlayerName() != author'");

    LoginDatabase.CommitTransaction(trans);

    if (sWorld->getBoolConfig(CONFIG_SHOW_BAN_IN_WORLD))
    {
        bool IsPermanetly = true;

        if (TimeStringToSecs(Duration) > 0)
            IsPermanetly = false;

        std::string AccountName;

        AccountMgr::GetName(AccountID, AccountName);

        if (!IsPermanetly)
            sWorld->SendWorldText(LANG_BAN_ACCOUNT_YOUBANNEDMESSAGE_WORLD, Author.c_str(), AccountName.c_str(), secsToTimeString(TimeStringToSecs(Duration), true).c_str(), Reason.c_str());
        else
            sWorld->SendWorldText(LANG_BAN_ACCOUNT_YOUPERMBANNEDMESSAGE_WORLD, Author.c_str(), AccountName.c_str(), Reason.c_str());
    }

    return BAN_SUCCESS;
}

/// Ban an IP address, duration will be parsed using TimeStringToSecs if it is positive, otherwise permban
BanReturn BanManager::BanIP(std::string const& IP, std::string const& Duration, std::string const& Reason, std::string const& Author)
{
    if (IP.empty() || Duration.empty())
        return BAN_SYNTAX_ERROR;

    uint32 DurationSecs = TimeStringToSecs(Duration);

    // No SQL injection with prepared statements
    PreparedStatement* stmt = LoginDatabase.GetPreparedStatement(LOGIN_SEL_ACCOUNT_BY_IP);
    stmt->setString(0, IP);
    PreparedQueryResult resultAccounts = LoginDatabase.Query(stmt);

    stmt = LoginDatabase.GetPreparedStatement(LOGIN_INS_IP_BANNED);
    stmt->setString(0, IP);
    stmt->setUInt32(1, DurationSecs);
    stmt->setString(2, Author);
    stmt->setString(3, Reason);
    LoginDatabase.Execute(stmt);

    if (sWorld->getBoolConfig(CONFIG_SHOW_BAN_IN_WORLD))
    {
        bool IsPermanetly = true;

        if (TimeStringToSecs(Duration) > 0)
            IsPermanetly = false;

        if (IsPermanetly)
            sWorld->SendWorldText(LANG_BAN_IP_YOUPERMBANNEDMESSAGE_WORLD, Author.c_str(), IP.c_str(), Reason.c_str());
        else
            sWorld->SendWorldText(LANG_BAN_IP_YOUBANNEDMESSAGE_WORLD, Author.c_str(), IP.c_str(), secsToTimeString(TimeStringToSecs(Duration), true).c_str(), Reason.c_str());
    }

    if (!resultAccounts)
        return BAN_SUCCESS;

    ///- Disconnect all affected players (for IP it can be several)
    SQLTransaction trans = LoginDatabase.BeginTransaction();

    do
    {
        Field* fields = resultAccounts->Fetch();
        uint32 AccountID = fields[0].GetUInt32();

        if (WorldSession* session = sWorld->FindSession(AccountID))
            if (session->GetPlayerName() != Author)
                session->KickPlayer("Ban IP at condition 'FindSession(account)->GetPlayerName() != author'");

        if (WorldSession* session = sWorld->FindOfflineSession(AccountID))
            if (session->GetPlayerName() != Author)
                session->KickPlayer("Ban IP at condition 'FindOfflineSession(account)->GetPlayerName() != author'");

    } while (resultAccounts->NextRow());

    LoginDatabase.CommitTransaction(trans);

    return BAN_SUCCESS;
}

/// Ban an character, duration will be parsed using TimeStringToSecs if it is positive, otherwise permban
BanReturn BanManager::BanCharacter(std::string const& CharacterName, std::string const& Duration, std::string const& Reason, std::string const& Author)
{
    Player* target = ObjectAccessor::FindPlayerByName(CharacterName, false);    
    uint32 DurationSecs = TimeStringToSecs(Duration);
    uint32 TargetGUID = 0;

    /// Pick a player to ban if not online
    if (!target)
    {
        TargetGUID = sWorld->GetGlobalPlayerGUID(CharacterName);
        if (!TargetGUID)
            return BAN_NOTFOUND;
    }
    else
        TargetGUID = target->GetGUIDLow();

    // make sure there is only one active ban
    PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_CHARACTER_BAN);
    stmt->setUInt32(0, TargetGUID);
    CharacterDatabase.Execute(stmt);

    stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_CHARACTER_BAN);
    stmt->setUInt32(0, TargetGUID);
    stmt->setUInt32(1, DurationSecs);
    stmt->setString(2, Author);
    stmt->setString(3, Reason);
    CharacterDatabase.Execute(stmt);

    if (target)
        target->GetSession()->KickPlayer("Ban");

    if (sWorld->getBoolConfig(CONFIG_SHOW_BAN_IN_WORLD))
    {
        bool IsPermanetly = true;

        if (TimeStringToSecs(Duration) > 0)
            IsPermanetly = false;

        if (!IsPermanetly)
            sWorld->SendWorldText(LANG_BAN_CHARACTER_YOUBANNEDMESSAGE_WORLD, Author.c_str(), CharacterName.c_str(), secsToTimeString(TimeStringToSecs(Duration), true).c_str(), Reason.c_str());
        else
            sWorld->SendWorldText(LANG_BAN_CHARACTER_YOUPERMBANNEDMESSAGE_WORLD, Author.c_str(), CharacterName.c_str(), Reason.c_str());
    }

    return BAN_SUCCESS;
}

/// Remove a ban from an account
bool BanManager::RemoveBanAccount(std::string const& AccountName)
{
    uint32 AccountID = AccountMgr::GetId(AccountName);
    if (!AccountID)
        return false;

    // NO SQL injection as account is uint32
    PreparedStatement* stmt = LoginDatabase.GetPreparedStatement(LOGIN_UPD_ACCOUNT_NOT_BANNED);
    stmt->setUInt32(0, AccountID);
    LoginDatabase.Execute(stmt);

    return true;
}

/// Remove a ban from an player name
bool BanManager::RemoveBanAccountByPlayerName(std::string const& CharacterName)
{
    uint32 AccountID = sObjectMgr->GetPlayerAccountIdByPlayerName(CharacterName);
    if (!AccountID)
        return false;

    // NO SQL injection as account is uint32
    PreparedStatement* stmt = LoginDatabase.GetPreparedStatement(LOGIN_UPD_ACCOUNT_NOT_BANNED);
    stmt->setUInt32(0, AccountID);
    LoginDatabase.Execute(stmt);

    return true;
}

/// Remove a ban from an account
bool BanManager::RemoveBanIP(std::string const& IP)
{
    PreparedStatement* stmt = LoginDatabase.GetPreparedStatement(LOGIN_DEL_IP_NOT_BANNED);
    stmt->setString(0, IP);
    LoginDatabase.Execute(stmt);

    return true;
}

/// Remove a ban from a character
bool BanManager::RemoveBanCharacter(std::string const& CharacterName)
{
    Player* pBanned = ObjectAccessor::FindPlayerByName(CharacterName, false);
    uint32 guid = 0;

    /// Pick a player to ban if not online
    if (!pBanned)
        guid = sWorld->GetGlobalPlayerGUID(CharacterName);
    else
        guid = pBanned->GetGUIDLow();

    if (!guid)
        return false;

    PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_CHARACTER_BAN);
    stmt->setUInt32(0, guid);
    CharacterDatabase.Execute(stmt);
    return true;
}

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

#include "BanMgr.h"
#include "AccountMgr.h"
#include "DatabaseEnv.h"
#include "GameTime.h"
#include "Language.h"
#include "ObjectAccessor.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "World.h"
#include "WorldSession.h"

BanMgr* BanMgr::instance()
{
    static BanMgr instance;
    return &instance;
}

/// Ban an account, duration will be parsed using TimeStringToSecs if it is positive, otherwise permban
BanReturn BanMgr::BanAccount(std::string const& AccountName, std::string const& Duration, std::string const& Reason, std::string const& Author)
{
    if (AccountName.empty() || Duration.empty())
        return BAN_SYNTAX_ERROR;

    uint32 DurationSecs = TimeStringToSecs(Duration);

    uint32 AccountID = AccountMgr::GetId(AccountName);
    if (!AccountID)
        return BAN_NOTFOUND;

    ///- Disconnect all affected players (for IP it can be several)
    LoginDatabaseTransaction trans = LoginDatabase.BeginTransaction();

    // pussywizard: check existing ban to prevent overriding by a shorter one! >_>
    LoginDatabasePreparedStatement* stmtAccountBanned = LoginDatabase.GetPreparedStatement(LOGIN_SEL_ACCOUNT_BANNED);
    stmtAccountBanned->SetData(0, AccountID);

    PreparedQueryResult banresult = LoginDatabase.Query(stmtAccountBanned);
    if (banresult && ((*banresult)[0].Get<uint32>() == (*banresult)[1].Get<uint32>() || ((*banresult)[1].Get<uint32>() > GameTime::GetGameTime().count() + DurationSecs && DurationSecs)))
        return BAN_LONGER_EXISTS;

    // make sure there is only one active ban
    LoginDatabasePreparedStatement* stmt = LoginDatabase.GetPreparedStatement(LOGIN_UPD_ACCOUNT_NOT_BANNED);
    stmt->SetData(0, AccountID);
    trans->Append(stmt);

    // No SQL injection with prepared statements
    stmt = LoginDatabase.GetPreparedStatement(LOGIN_INS_ACCOUNT_BANNED);
    stmt->SetData(0, AccountID);
    stmt->SetData(1, DurationSecs);
    stmt->SetData(2, Author);
    stmt->SetData(3, Reason);
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
BanReturn BanMgr::BanAccountByPlayerName(std::string const& CharacterName, std::string const& Duration, std::string const& Reason, std::string const& Author)
{
    if (CharacterName.empty() || Duration.empty())
        return BAN_SYNTAX_ERROR;

    uint32 DurationSecs = TimeStringToSecs(Duration);

    uint32 AccountID = sCharacterCache->GetCharacterAccountIdByName(CharacterName);
    if (!AccountID)
        return BAN_NOTFOUND;

    ///- Disconnect all affected players (for IP it can be several)
    LoginDatabaseTransaction trans = LoginDatabase.BeginTransaction();

    // pussywizard: check existing ban to prevent overriding by a shorter one! >_>
    LoginDatabasePreparedStatement* stmtAccountBanned = LoginDatabase.GetPreparedStatement(LOGIN_SEL_ACCOUNT_BANNED);
    stmtAccountBanned->SetData(0, AccountID);

    PreparedQueryResult banresult = LoginDatabase.Query(stmtAccountBanned);
    if (banresult && ((*banresult)[0].Get<uint32>() == (*banresult)[1].Get<uint32>() || ((*banresult)[1].Get<uint32>() > GameTime::GetGameTime().count() + DurationSecs && DurationSecs)))
        return BAN_LONGER_EXISTS;

    // make sure there is only one active ban
    LoginDatabasePreparedStatement* stmt = LoginDatabase.GetPreparedStatement(LOGIN_UPD_ACCOUNT_NOT_BANNED);
    stmt->SetData(0, AccountID);
    trans->Append(stmt);

    // No SQL injection with prepared statements
    stmt = LoginDatabase.GetPreparedStatement(LOGIN_INS_ACCOUNT_BANNED);
    stmt->SetData(0, AccountID);
    stmt->SetData(1, DurationSecs);
    stmt->SetData(2, Author);
    stmt->SetData(3, Reason);
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
BanReturn BanMgr::BanIP(std::string const& IP, std::string const& Duration, std::string const& Reason, std::string const& Author)
{
    if (IP.empty() || Duration.empty())
        return BAN_SYNTAX_ERROR;

    uint32 DurationSecs = TimeStringToSecs(Duration);

    // No SQL injection with prepared statements
    LoginDatabasePreparedStatement* stmt = LoginDatabase.GetPreparedStatement(LOGIN_SEL_ACCOUNT_BY_IP);
    stmt->SetData(0, IP);
    PreparedQueryResult resultAccounts = LoginDatabase.Query(stmt);

    stmt = LoginDatabase.GetPreparedStatement(LOGIN_INS_IP_BANNED);
    stmt->SetData(0, IP);
    stmt->SetData(1, DurationSecs);
    stmt->SetData(2, Author);
    stmt->SetData(3, Reason);
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
    LoginDatabaseTransaction trans = LoginDatabase.BeginTransaction();

    do
    {
        Field* fields = resultAccounts->Fetch();
        uint32 AccountID = fields[0].Get<uint32>();

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
BanReturn BanMgr::BanCharacter(std::string const& CharacterName, std::string const& Duration, std::string const& Reason, std::string const& Author)
{
    Player* target = ObjectAccessor::FindPlayerByName(CharacterName, false);
    uint32 DurationSecs = TimeStringToSecs(Duration);
    ObjectGuid TargetGUID;

    /// Pick a player to ban if not online
    if (!target)
    {
        TargetGUID = sCharacterCache->GetCharacterGuidByName(CharacterName);
        if (!TargetGUID)
            return BAN_NOTFOUND;
    }
    else
        TargetGUID = target->GetGUID();

    // make sure there is only one active ban
    CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_CHARACTER_BAN);
    stmt->SetData(0, TargetGUID.GetCounter());
    CharacterDatabase.Execute(stmt);

    stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_CHARACTER_BAN);
    stmt->SetData(0, TargetGUID.GetCounter());
    stmt->SetData(1, DurationSecs);
    stmt->SetData(2, Author);
    stmt->SetData(3, Reason);
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
bool BanMgr::RemoveBanAccount(std::string const& AccountName)
{
    uint32 AccountID = AccountMgr::GetId(AccountName);
    if (!AccountID)
        return false;

    // NO SQL injection as account is uint32
    LoginDatabasePreparedStatement* stmt = LoginDatabase.GetPreparedStatement(LOGIN_UPD_ACCOUNT_NOT_BANNED);
    stmt->SetData(0, AccountID);
    LoginDatabase.Execute(stmt);

    return true;
}

/// Remove a ban from an player name
bool BanMgr::RemoveBanAccountByPlayerName(std::string const& CharacterName)
{
    uint32 AccountID = sCharacterCache->GetCharacterAccountIdByName(CharacterName);
    if (!AccountID)
        return false;

    // NO SQL injection as account is uint32
    LoginDatabasePreparedStatement* stmt = LoginDatabase.GetPreparedStatement(LOGIN_UPD_ACCOUNT_NOT_BANNED);
    stmt->SetData(0, AccountID);
    LoginDatabase.Execute(stmt);

    return true;
}

/// Remove a ban from an account
bool BanMgr::RemoveBanIP(std::string const& IP)
{
    LoginDatabasePreparedStatement* stmt = LoginDatabase.GetPreparedStatement(LOGIN_DEL_IP_NOT_BANNED);
    stmt->SetData(0, IP);
    LoginDatabase.Execute(stmt);

    return true;
}

/// Remove a ban from a character
bool BanMgr::RemoveBanCharacter(std::string const& CharacterName)
{
    Player* pBanned = ObjectAccessor::FindPlayerByName(CharacterName, false);
    ObjectGuid guid;

    /// Pick a player to ban if not online
    if (!pBanned)
        guid = sCharacterCache->GetCharacterGuidByName(CharacterName);
    else
        guid = pBanned->GetGUID();

    if (!guid)
        return false;

    CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_CHARACTER_BAN);
    stmt->SetData(0, guid.GetCounter());
    CharacterDatabase.Execute(stmt);
    return true;
}

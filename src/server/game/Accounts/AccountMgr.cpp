/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the
 * Free Software Foundation; either version 2 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "AccountMgr.h"
#include "Common.h"
#include "DatabaseEnv.h"
#include "Log.h"
#include "ObjectAccessor.h"
#include "Player.h"
#include "Realm.h"
#include "SRP6.h"
#include "ScriptMgr.h"
#include "Util.h"
#include "WorldSession.h"

AccountMgr::AccountMgr() { }

AccountMgr::~AccountMgr()
{
    ClearRBAC();
}

AccountMgr* AccountMgr::instance()
{
    static AccountMgr instance;
    return &instance;
}

AccountOpResult AccountMgr::CreateAccount(std::string username, std::string password, std::string email /*= ""*/)
{
    if (utf8length(username) > MAX_ACCOUNT_STR)
        return AOR_NAME_TOO_LONG;                           // username's too long

    if (utf8length(password) > MAX_PASS_STR)
        return AOR_PASS_TOO_LONG;                           // password's too long

    if (utf8length(email) > MAX_EMAIL_STR)
        return AOR_EMAIL_TOO_LONG;                          // email is too long

    Utf8ToUpperOnlyLatin(username);
    Utf8ToUpperOnlyLatin(password);
    Utf8ToUpperOnlyLatin(email);

    if (GetId(username))
        return AOR_NAME_ALREADY_EXIST;                      // username does already exist

    LoginDatabasePreparedStatement* stmt = LoginDatabase.GetPreparedStatement(LOGIN_INS_ACCOUNT);

    stmt->SetData(0, username);
    auto [salt, verifier] = Acore::Crypto::SRP6::MakeRegistrationData(username, password);
    stmt->SetData(1, salt);
    stmt->SetData(2, verifier);
    stmt->SetData(3, uint8(sWorld->getIntConfig(CONFIG_EXPANSION)));
    stmt->SetData(4, email);
    stmt->SetData(5, email);

    LoginDatabase.Execute(stmt);

    stmt = LoginDatabase.GetPreparedStatement(LOGIN_INS_REALM_CHARACTERS_INIT);

    LoginDatabase.Execute(stmt);

    return AOR_OK;                                          // everything's fine
}

AccountOpResult AccountMgr::ChangeEmail(uint32 accountId, std::string newEmail)
{
    std::string username;

    if (!GetName(accountId, username))
    {
        sScriptMgr->OnFailedEmailChange(accountId);
        return AOR_NAME_NOT_EXIST;                          // account doesn't exist
    }

    if (utf8length(newEmail) > MAX_EMAIL_STR)
    {
        sScriptMgr->OnFailedEmailChange(accountId);
        return AOR_EMAIL_TOO_LONG;                           // email's too long
    }

    Utf8ToUpperOnlyLatin(newEmail);

    LoginDatabasePreparedStatement* stmt = LoginDatabase.GetPreparedStatement(LOGIN_UPD_EMAIL);
    stmt->SetData(0, newEmail);
    stmt->SetData(1, accountId);
    LoginDatabase.Execute(stmt);

    sScriptMgr->OnEmailChange(accountId);
    return AOR_OK;
}

AccountOpResult AccountMgr::DeleteAccount(uint32 accountId)
{
    // Check if accounts exists
    LoginDatabasePreparedStatement* loginStmt = LoginDatabase.GetPreparedStatement(LOGIN_SEL_ACCOUNT_BY_ID);
    loginStmt->SetData(0, accountId);

    PreparedQueryResult result = LoginDatabase.Query(loginStmt);
    if (!result)
        return AOR_NAME_NOT_EXIST;

    sScriptMgr->OnBeforeAccountDelete(accountId);

    // Obtain accounts characters
    CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_CHARS_BY_ACCOUNT_ID);
    stmt->SetData(0, accountId);

    result = CharacterDatabase.Query(stmt);

    if (result)
    {
        do
        {
            ObjectGuid guid = ObjectGuid::Create<HighGuid::Player>((*result)[0].Get<uint32>());

            // Kick if player is online
            if (Player* p = ObjectAccessor::FindPlayer(guid))
            {
                WorldSession* s = p->GetSession();
                s->KickPlayer("Delete account");            // mark session to remove at next session list update
                s->LogoutPlayer(false);                     // logout player without waiting next session list update
            }

            Player::DeleteFromDB(guid.GetCounter(), accountId, false, true);       // no need to update realm characters
        } while (result->NextRow());
    }

    // table realm specific but common for all characters of account for realm
    stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_TUTORIALS);
    stmt->SetData(0, accountId);
    CharacterDatabase.Execute(stmt);

    stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_ACCOUNT_DATA);
    stmt->SetData(0, accountId);
    CharacterDatabase.Execute(stmt);

    stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_CHARACTER_BAN);
    stmt->SetData(0, accountId);
    CharacterDatabase.Execute(stmt);

    LoginDatabaseTransaction trans = LoginDatabase.BeginTransaction();

    loginStmt = LoginDatabase.GetPreparedStatement(LOGIN_DEL_ACCOUNT);
    loginStmt->SetData(0, accountId);
    trans->Append(loginStmt);

    loginStmt = LoginDatabase.GetPreparedStatement(LOGIN_DEL_ACCOUNT_ACCESS);
    loginStmt->SetData(0, accountId);
    trans->Append(loginStmt);

    loginStmt = LoginDatabase.GetPreparedStatement(LOGIN_DEL_REALM_CHARACTERS);
    loginStmt->SetData(0, accountId);
    trans->Append(loginStmt);

    loginStmt = LoginDatabase.GetPreparedStatement(LOGIN_DEL_ACCOUNT_BANNED);
    loginStmt->SetData(0, accountId);
    trans->Append(loginStmt);

    loginStmt = LoginDatabase.GetPreparedStatement(LOGIN_DEL_ACCOUNT_MUTED);
    loginStmt->SetData(0, accountId);
    trans->Append(loginStmt);

    LoginDatabase.CommitTransaction(trans);

    return AOR_OK;
}

AccountOpResult AccountMgr::ChangeUsername(uint32 accountId, std::string newUsername, std::string newPassword)
{
    // Check if accounts exists
    LoginDatabasePreparedStatement* stmt = LoginDatabase.GetPreparedStatement(LOGIN_SEL_ACCOUNT_BY_ID);
    stmt->SetData(0, accountId);
    PreparedQueryResult result = LoginDatabase.Query(stmt);

    if (!result)
        return AOR_NAME_NOT_EXIST;

    if (utf8length(newUsername) > MAX_ACCOUNT_STR)
        return AOR_NAME_TOO_LONG;

    if (utf8length(newPassword) > MAX_PASS_STR)
        return AOR_PASS_TOO_LONG;                           // password's too long

    Utf8ToUpperOnlyLatin(newUsername);
    Utf8ToUpperOnlyLatin(newPassword);

    stmt = LoginDatabase.GetPreparedStatement(LOGIN_UPD_USERNAME);
    stmt->SetData(0, newUsername);
    stmt->SetData(1, accountId);
    LoginDatabase.Execute(stmt);

    auto [salt, verifier] = Acore::Crypto::SRP6::MakeRegistrationData(newUsername, newPassword);
    stmt = LoginDatabase.GetPreparedStatement(LOGIN_UPD_LOGON);
    stmt->SetData(0, salt);
    stmt->SetData(1, verifier);
    stmt->SetData(2, accountId);
    LoginDatabase.Execute(stmt);

    return AOR_OK;
}

AccountOpResult AccountMgr::ChangePassword(uint32 accountId, std::string newPassword)
{
    std::string username;

    if (!GetName(accountId, username))
    {
        sScriptMgr->OnFailedPasswordChange(accountId);
        return AOR_NAME_NOT_EXIST;                          // account doesn't exist
    }

    if (utf8length(newPassword) > MAX_PASS_STR)
    {
        sScriptMgr->OnFailedEmailChange(accountId);
        return AOR_PASS_TOO_LONG;                           // password's too long
    }

    Utf8ToUpperOnlyLatin(username);
    Utf8ToUpperOnlyLatin(newPassword);

    auto [salt, verifier] = Acore::Crypto::SRP6::MakeRegistrationData(username, newPassword);

    LoginDatabasePreparedStatement* stmt = LoginDatabase.GetPreparedStatement(LOGIN_UPD_LOGON);
    stmt->SetData(0, salt);
    stmt->SetData(1, verifier);
    stmt->SetData(2, accountId);
    LoginDatabase.Execute(stmt);

    sScriptMgr->OnPasswordChange(accountId);
    return AOR_OK;
}

uint32 AccountMgr::GetId(std::string const& username)
{
    LoginDatabasePreparedStatement* stmt = LoginDatabase.GetPreparedStatement(LOGIN_GET_ACCOUNT_ID_BY_USERNAME);
    stmt->SetData(0, username);
    PreparedQueryResult result = LoginDatabase.Query(stmt);

    return (result) ? (*result)[0].Get<uint32>() : 0;
}

uint32 AccountMgr::GetSecurity(uint32 accountId)
{
    LoginDatabasePreparedStatement* stmt = LoginDatabase.GetPreparedStatement(LOGIN_GET_ACCOUNT_ACCESS_GMLEVEL);
    stmt->SetData(0, accountId);
    PreparedQueryResult result = LoginDatabase.Query(stmt);

    return (result) ? (*result)[0].Get<uint8>() : uint32(SEC_PLAYER);
}

uint32 AccountMgr::GetSecurity(uint32 accountId, int32 realmId)
{
    LoginDatabasePreparedStatement* stmt = LoginDatabase.GetPreparedStatement(LOGIN_GET_GMLEVEL_BY_REALMID);
    stmt->SetData(0, accountId);
    stmt->SetData(1, realmId);
    PreparedQueryResult result = LoginDatabase.Query(stmt);

    return (result) ? (*result)[0].Get<uint8>() : uint32(SEC_PLAYER);
}

bool AccountMgr::GetName(uint32 accountId, std::string& name)
{
    LoginDatabasePreparedStatement* stmt = LoginDatabase.GetPreparedStatement(LOGIN_GET_USERNAME_BY_ID);
    stmt->SetData(0, accountId);
    PreparedQueryResult result = LoginDatabase.Query(stmt);

    if (result)
    {
        name = (*result)[0].Get<std::string>();
        return true;
    }

    return false;
}

bool AccountMgr::CheckPassword(uint32 accountId, std::string password)
{
    std::string username;

    if (!GetName(accountId, username))
        return false;

    Utf8ToUpperOnlyLatin(username);
    Utf8ToUpperOnlyLatin(password);

    LoginDatabasePreparedStatement* stmt = LoginDatabase.GetPreparedStatement(LOGIN_SEL_CHECK_PASSWORD);
    stmt->SetData(0, accountId);
    if (PreparedQueryResult result = LoginDatabase.Query(stmt))
    {
        Acore::Crypto::SRP6::Salt salt = (*result)[0].Get<Binary, Acore::Crypto::SRP6::SALT_LENGTH>();
        Acore::Crypto::SRP6::Verifier verifier = (*result)[1].Get<Binary, Acore::Crypto::SRP6::VERIFIER_LENGTH>();
        if (Acore::Crypto::SRP6::CheckLogin(username, password, salt, verifier))
            return true;
    }

    return false;
}

uint32 AccountMgr::GetCharactersCount(uint32 accountId)
{
    // check character count
    CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_SUM_CHARS);
    stmt->SetData(0, accountId);
    PreparedQueryResult result = CharacterDatabase.Query(stmt);

    return (result) ? (*result)[0].Get<uint64>() : 0;
}

bool AccountMgr::IsPlayerAccount(uint32 gmlevel)
{
    return gmlevel == SEC_PLAYER;
}

bool AccountMgr::IsGMAccount(uint32 gmlevel)
{
    return gmlevel >= SEC_GAMEMASTER;
}

bool AccountMgr::IsAdminAccount(uint32 gmlevel)
{
    return gmlevel >= SEC_ADMINISTRATOR && gmlevel <= SEC_CONSOLE;
}

bool AccountMgr::IsConsoleAccount(uint32 gmlevel)
{
    return gmlevel == SEC_CONSOLE;
}

bool AccountMgr::HasPermission(uint32 accountId, uint32 permission, uint32 realmId)
{
    if (!accountId)
    {
        LOG_ERROR("rbac", "AccountMgr::HasPermission: Wrong accountId 0");
        return false;
    }

    rbac::RBACData rbac(accountId, "", realmId, GetSecurity(accountId, realmId));
    rbac.LoadFromDB();
    bool hasPermission = rbac.HasPermission(permission);

    LOG_DEBUG("rbac", "AccountMgr::HasPermission [AccountId: {}, PermissionId: {}, realmId: {}]: {}",
        accountId, permission, realmId, hasPermission);

    return hasPermission;
}

void AccountMgr::UpdateAccountAccess(rbac::RBACData* rbac, uint32 accountId, uint8 securityLevel, int32 realmId)
{
    if (rbac && securityLevel != rbac->GetSecurityLevel())
        rbac->SetSecurityLevel(securityLevel);

    LoginDatabaseTransaction trans = LoginDatabase.BeginTransaction();

    // Delete old security level from DB
    if (realmId == -1)
    {
        LoginDatabasePreparedStatement* stmt = LoginDatabase.GetPreparedStatement(LOGIN_DEL_ACCOUNT_ACCESS);
        stmt->SetData(0, accountId);
        trans->Append(stmt);
    }
    else
    {
        LoginDatabasePreparedStatement* stmt = LoginDatabase.GetPreparedStatement(LOGIN_DEL_ACCOUNT_ACCESS_BY_REALM);
        stmt->SetData(0, accountId);
        stmt->SetData(1, realmId);
        trans->Append(stmt);
    }

    // Add new security level
    if (securityLevel)
    {
        LoginDatabasePreparedStatement* stmt = LoginDatabase.GetPreparedStatement(LOGIN_INS_ACCOUNT_ACCESS);
        stmt->SetData(0, accountId);
        stmt->SetData(1, securityLevel);
        stmt->SetData(2, realmId);
        trans->Append(stmt);
    }

    LoginDatabase.CommitTransaction(trans);
}

void AccountMgr::LoadRBAC()
{
    ClearRBAC();

    LOG_DEBUG("rbac", "AccountMgr::LoadRBAC");
    uint32 oldMSTime = getMSTime();
    uint32 count1 = 0;
    uint32 count2 = 0;
    uint32 count3 = 0;

    LOG_DEBUG("rbac", "AccountMgr::LoadRBAC: Loading permissions");
    QueryResult result = LoginDatabase.Query("SELECT id, name FROM rbac_permissions");
    if (!result)
    {
        LOG_INFO("server.loading", ">> Loaded 0 RBAC permissions. DB table `rbac_permissions` is empty.");
        LOG_INFO("server.loading", " ");
        return;
    }

    do
    {
        Field* field = result->Fetch();
        uint32 id = field[0].Get<uint32>();
        _permissions[id] = new rbac::RBACPermission(id, field[1].Get<std::string>());
        ++count1;
    }
    while (result->NextRow());

    LOG_DEBUG("rbac", "AccountMgr::LoadRBAC: Loading linked permissions");
    result = LoginDatabase.Query("SELECT id, linkedId FROM rbac_linked_permissions ORDER BY id ASC");
    if (!result)
    {
        LOG_INFO("server.loading", ">> Loaded {} RBAC permissions", count1);
        LOG_INFO("server.loading", " ");
    }
    else
    {
        uint32 permissionId = 0;
        rbac::RBACPermission* permission = nullptr;

        do
        {
            Field* field = result->Fetch();
            uint32 newId = field[0].Get<uint32>();
            if (permissionId != newId)
            {
                permissionId = newId;
                permission = _permissions[newId];
            }

            uint32 linkedPermissionId = field[1].Get<uint32>();
            if (linkedPermissionId == permissionId)
            {
                LOG_ERROR("sql.sql", "RBAC Permission {} has itself as linked permission. Ignored", permissionId);
                continue;
            }
            permission->AddLinkedPermission(linkedPermissionId);
            ++count2;
        }
        while (result->NextRow());

        LOG_INFO("server.loading", ">> Loaded {} RBAC permissions and {} linked permissions in {} ms", count1, count2, GetMSTimeDiffToNow(oldMSTime));
        LOG_INFO("server.loading", " ");
    }

    LOG_DEBUG("rbac", "AccountMgr::LoadRBAC: Loading default permissions");
    LoginDatabasePreparedStatement* stmt = LoginDatabase.GetPreparedStatement(LOGIN_SEL_RBAC_DEFAULT_PERMISSIONS);
    stmt->SetData(0, int32(realm.Id.Realm));
    PreparedQueryResult defaultPermResult = LoginDatabase.Query(stmt);
    if (!defaultPermResult)
    {
        LOG_INFO("server.loading", ">> Loaded 0 RBAC default permissions. DB table `rbac_default_permissions` is empty.");
        LOG_INFO("server.loading", " ");
        return;
    }

    uint8 secId = 255;
    rbac::RBACPermissionContainer* permissions = nullptr;
    do
    {
        Field* field = defaultPermResult->Fetch();
        uint8 newId = field[0].Get<uint8>();
        if (secId != newId || permissions == nullptr)
        {
            secId = newId;
            permissions = &_defaultPermissions[secId];
        }

        permissions->insert(field[1].Get<uint32>());
        ++count3;
    }
    while (defaultPermResult->NextRow());

    LOG_INFO("server.loading", ">> Loaded {} RBAC default permissions in {} ms", count3, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
}

rbac::RBACPermission const* AccountMgr::GetRBACPermission(uint32 permissionId) const
{
    LOG_TRACE("rbac", "AccountMgr::GetRBACPermission: {}", permissionId);
    rbac::RBACPermissionsContainer::const_iterator it = _permissions.find(permissionId);
    if (it != _permissions.end())
        return it->second;

    return nullptr;
}

rbac::RBACPermissionContainer const& AccountMgr::GetRBACDefaultPermissions(uint8 secLevel)
{
    LOG_TRACE("rbac", "AccountMgr::GetRBACDefaultPermissions: secLevel {} - size: {}", secLevel, uint32(_defaultPermissions[secLevel].size()));
    return _defaultPermissions[secLevel];
}

void AccountMgr::ClearRBAC()
{
    for (std::pair<uint32 const, rbac::RBACPermission*>& permission : _permissions)
        delete permission.second;

    _permissions.clear();
    _defaultPermissions.clear();
}

void AccountMgr::AddPermissionForTest(uint32 permissionId, std::string const& name)
{
    if (_permissions.find(permissionId) != _permissions.end())
        return;

    _permissions[permissionId] = new rbac::RBACPermission(permissionId, name);
}

void AccountMgr::AddLinkedPermissionForTest(uint32 permissionId, uint32 linkedPermissionId)
{
    auto it = _permissions.find(permissionId);
    if (it != _permissions.end())
        it->second->AddLinkedPermission(linkedPermissionId);
}

void AccountMgr::AddDefaultPermissionForTest(uint8 secLevel, uint32 permissionId)
{
    _defaultPermissions[secLevel].insert(permissionId);
}

void AccountMgr::ClearPermissionsForTest()
{
    ClearRBAC();
}

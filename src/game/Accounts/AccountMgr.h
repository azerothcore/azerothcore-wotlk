/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: http://github.com/azerothcore/azerothcore-wotlk/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef _ACCMGR_H
#define _ACCMGR_H

#include <ace/Singleton.h>
#include "RBAC.h"

enum AccountOpResult
{
    AOR_OK,
    AOR_NAME_TOO_LONG,
    AOR_PASS_TOO_LONG,
    AOR_NAME_ALREDY_EXIST,
    AOR_NAME_NOT_EXIST,
    AOR_DB_INTERNAL_ERROR
};

#define MAX_ACCOUNT_STR 20

typedef std::map<uint32, RBACPermission*> RBACPermissionsContainer;
typedef std::map<uint32, RBACRole*> RBACRolesContainer;
typedef std::map<uint32, RBACGroup*> RBACGroupsContainer;
typedef std::map<uint32, RBACGroupContainer> RBACDefaultSecurityGroupContainer;

class AccountAccess
{
public:
    AccountAccess(uint32 accountId, uint8 gmlevel, uint8 realmId) : _accountId(accountId), _gmlevel(gmlevel), _realmId(realmId) {}

    uint32 _accountId;
    uint8 _gmlevel;
    uint8 _realmId;
};

typedef std::set<AccountAccess*> AccountAccessSet;

class AccountMgr
{
    friend class ACE_Singleton<AccountMgr, ACE_Null_Mutex>;

    private:
        AccountMgr();
        ~AccountMgr();

    public:
        AccountOpResult CreateAccount(std::string username, std::string password);
        static AccountOpResult DeleteAccount(uint32 accountId);
        static AccountOpResult ChangeUsername(uint32 accountId, std::string newUsername, std::string newPassword);
        static AccountOpResult ChangePassword(uint32 accountId, std::string newPassword);
        static bool CheckPassword(uint32 accountId, std::string password);

        static uint32 GetId(std::string const& username);
        uint32 GetSecurity(uint32 accountId);
        uint32 GetSecurity(uint32 accountId, int32 realmId);
        static bool GetName(uint32 accountId, std::string& name);
        static uint32 GetCharactersCount(uint32 accountId);
        static std::string CalculateShaPassHash(std::string const& name, std::string const& password);

        static bool normalizeString(std::string& utf8String);
        static bool IsPlayerAccount(uint32 gmlevel);
        static bool IsGMAccount(uint32 gmlevel);
        static bool IsAdminAccount(uint32 gmlevel);
        static bool IsConsoleAccount(uint32 gmlevel);
        static bool HasPermission(uint32 accountId, uint32 permission, uint32 realmId);

        void UpdateAccountAccess(RBACData* rbac, uint32 accountId, uint8 securityLevel, int32 realmId);

        void LoadRBAC();
        RBACGroup const* GetRBACGroup(uint32 group) const;
        RBACRole const* GetRBACRole(uint32 role) const;
        RBACPermission const* GetRBACPermission(uint32 permission) const;

        RBACGroupsContainer const& GetRBACGroupList() const { return _groups; }
        RBACRolesContainer const& GetRBACRoleList() const { return _roles; }
        RBACPermissionsContainer const& GetRBACPermissionList() const { return _permissions; }
        RBACGroupContainer const& GetRBACDefaultGroups() const { return _defaultGroups; }

        void LoadAccountAccess();

    private:
        void ClearRBAC();
        RBACPermissionsContainer _permissions;
        RBACRolesContainer _roles;
        RBACGroupsContainer _groups;
        RBACDefaultSecurityGroupContainer _defaultSecGroups;
        RBACGroupContainer _defaultGroups;

        AccountAccessSet _accountAccess;
};

#define sAccountMgr ACE_Singleton<AccountMgr, ACE_Null_Mutex>::instance()
#endif

/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2008-2021 TrinityCore <http://www.trinitycore.org/>
 */

/**
* @file RBAC.h
* @brief Role Based Access Control related classes definition
*
* This file contains all the classes and enums used to implement
* Role Based Access Control
*
* RBAC Rules:
* - Pemission: Defines an autorization to perform certain operation.
* - Role: Set of permissions.
* - Group: Set of roles.
* - An Account can have multiple groups, roles and permissions.
* - Account Groups can only be granted or revoked
* - Account Roles and Permissions can be granted, denied or revoked
* - Grant: Assignment of the object (role/permission) and allow it
* - Deny: Assignment of the object (role/permission) and deny it
* - Revoke: Removal of the object (role/permission) no matter if it was granted or denied
* - Global Permissions are computed as:
*       Group Grants + Role Grants + User Grans - Role Grants - User Grants
* - Groups, Roles and Permissions can be assigned by realm
*/

#ifndef _RBAC_H
#define _RBAC_H

#include "Define.h"
#include "DatabaseEnvFwd.h"
#include <string>
#include <set>
#include <map>

namespace rbac
{

enum RBACPermissions
{
    // Space for core permissions (1 - 149)
    // RBAC_PERM_INSTANT_LOGOUT                                 = 1,

    // Roles (Permissions with delegated permissions) use 150 - 199

    RBAC_ROLE_ADMINISTRATOR                                  = 196,
    RBAC_ROLE_GAMEMASTER                                     = 197,
    RBAC_ROLE_MODERATOR                                      = 198,
    RBAC_ROLE_PLAYER                                         = 199,

    // Command Permissions

    RBAC_PERM_COMMAND_RBAC                                   = 200,
    RBAC_PERM_COMMAND_RBAC_ACC                               = 201,
    RBAC_PERM_COMMAND_RBAC_ACC_PERM_LIST                     = 202,
    RBAC_PERM_COMMAND_RBAC_ACC_PERM_GRANT                    = 203,
    RBAC_PERM_COMMAND_RBAC_ACC_PERM_DENY                     = 204,
    RBAC_PERM_COMMAND_RBAC_ACC_PERM_REVOKE                   = 205,
    RBAC_PERM_COMMAND_RBAC_LIST                              = 206,

    RBAC_PERM_COMMAND_RELOAD_RBAC                            = 680,

    // custom permissions 1000+
    RBAC_PERM_MAX
};

enum RBACCommandResult
{
    RBAC_OK,
    RBAC_CANT_ADD_ALREADY_ADDED,
    RBAC_CANT_REVOKE_NOT_IN_LIST,
    RBAC_IN_GRANTED_LIST,
    RBAC_IN_DENIED_LIST,
    RBAC_ID_DOES_NOT_EXISTS
};

typedef std::set<uint32> RBACPermissionContainer;

class AC_GAME_API RBACPermission
{
    public:
        RBACPermission(uint32 id = 0, std::string const& name = ""):
            _id(id), _name(name), _perms() { }

        /// Gets the Name of the Object
        std::string const& GetName() const { return _name; }
        /// Gets the Id of the Object
        uint32 GetId() const { return _id; }

        /// Gets the Permissions linked to this permission
        RBACPermissionContainer const& GetLinkedPermissions() const { return _perms; }
        /// Adds a new linked Permission
        void AddLinkedPermission(uint32 id) { _perms.insert(id); }
        /// Removes a linked Permission
        void RemoveLinkedPermission(uint32 id) { _perms.erase(id); }

    private:
        uint32 _id;                                        ///> id of the object
        std::string _name;                                 ///> name of the object
        RBACPermissionContainer _perms;                    ///> Set of permissions
};

/**
 * @name RBACData
 * @brief Contains all needed information about the acccount
 *
 * This class contains all the data needed to calculate the account permissions.
 * RBACDAta is formed by granted and denied permissions and all the inherited permissions
 *
 * Calculation of current Permissions: Granted permissions - Denied permissions
 * - Granted permissions: through linked permissions and directly assigned
 * - Denied permissions: through linked permissions and directly assigned
 */
class AC_GAME_API RBACData
{
    public:
        RBACData(uint32 id, std::string const& name, int32 realmId, uint8 secLevel = 255):
            _id(id), _name(name), _realmId(realmId), _secLevel(secLevel),
            _grantedPerms(), _deniedPerms(), _globalPerms() { }

        /// Gets the Name of the Object
        std::string const& GetName() const { return _name; }
        /// Gets the Id of the Object
        uint32 GetId() const { return _id; }

        /**
         * @name HasPermission
         * @brief Checks if certain action is allowed
         *
         * Checks if certain action can be performed.
         *
         * @return grant or deny action
         *
         * Example Usage:
         * @code
         * bool Player::CanJoinArena(Battleground* bg)
         * {
         *     return bg->isArena() && HasPermission(RBAC_PERM_JOIN_ARENA);
         * }
         * @endcode
         */
        bool HasPermission(uint32 permission) const
        {
            return _globalPerms.find(permission) != _globalPerms.end();
        }

        // Functions enabled to be used by command system
        /// Returns all the granted permissions (after computation)
        RBACPermissionContainer const& GetPermissions() const { return _globalPerms; }
        /// Returns all the granted permissions
        RBACPermissionContainer const& GetGrantedPermissions() const { return _grantedPerms; }
        /// Returns all the denied permissions
        RBACPermissionContainer const& GetDeniedPermissions() const { return _deniedPerms; }

        /**
         * @name GrantRole
         * @brief Grants a permission
         *
         * Grants a permission to the account. If realm is 0 or the permission can not be added
         * No save to db action will be performed.
         *
         * Fails if permission Id does not exists or permission already granted or denied
         *
         * @param permissionId permission to be granted
         * @param realmId realm affected
         *
         * @return Success or failure (with reason) to grant the permission
         *
         * Example Usage:
         * @code
         * // previously defined "RBACData* rbac" with proper initialization
         * uint32 permissionId = 2;
         * if (rbac->GrantRole(permissionId) == RBAC_IN_DENIED_LIST)
         *     TC_LOG_DEBUG("entities.player", "Failed to grant permission %u, already denied", permissionId);
         * @endcode
         */
        RBACCommandResult GrantPermission(uint32 permissionId, int32 realmId = 0);

        /**
         * @name DenyPermission
         * @brief Denies a permission
         *
         * Denied a permission to the account. If realm is 0 or the permission can not be added
         * No save to db action will be performed.
         *
         * Fails if permission Id does not exists or permission already granted or denied
         *
         * @param permissionId permission to be denied
         * @param realmId realm affected
         *
         * @return Success or failure (with reason) to deny the permission
         *
         * Example Usage:
         * @code
         * // previously defined "RBACData* rbac" with proper initialization
         * uint32 permissionId = 2;
         * if (rbac->DenyRole(permissionId) == RBAC_ID_DOES_NOT_EXISTS)
         *     TC_LOG_DEBUG("entities.player", "Role Id %u does not exists", permissionId);
         * @endcode
         */
        RBACCommandResult DenyPermission(uint32 permissionId, int32 realmId = 0);

        /**
         * @name RevokePermission
         * @brief Removes a permission
         *
         * Removes a permission from the account. If realm is 0 or the permission can not be removed
         * No save to db action will be performed. Any delete operation will always affect
         * "all realms (-1)" in addition to the realm specified
         *
         * Fails if permission not present
         *
         * @param permissionId permission to be removed
         * @param realmId realm affected
         *
         * @return Success or failure (with reason) to remove the permission
         *
         * Example Usage:
         * @code
         * // previously defined "RBACData* rbac" with proper initialization
         * uint32 permissionId = 2;
         * if (rbac->RevokeRole(permissionId) == RBAC_OK)
         *     TC_LOG_DEBUG("entities.player", "Permission %u succesfully removed", permissionId);
         * @endcode
         */
        RBACCommandResult RevokePermission(uint32 permissionId, int32 realmId = 0);

        /// Loads all permissions assigned to current account
        void LoadFromDB();
        QueryCallback LoadFromDBAsync();
        void LoadFromDBCallback(PreparedQueryResult result);

        /// Sets security level
        void SetSecurityLevel(uint8 id)
        {
            _secLevel = id;
            LoadFromDB();
        }

        /// Returns the security level assigned
        uint8 GetSecurityLevel() const { return _secLevel; }
    private:
        /// Saves a permission to DB, Granted or Denied
        void SavePermission(uint32 role, bool granted, int32 realm);
        /// Clears roles, groups and permissions - Used for reload
        void ClearData();

        /**
         * @name CalculateNewPermissions
         * @brief Calculates new permissions
         *
         * Calculates new permissions after some change
         * The calculation is done Granted - Denied:
         * - Granted permissions: through linked permissions and directly assigned
         * - Denied permissions: through linked permissions and directly assigned
         */
        void CalculateNewPermissions();

        int32 GetRealmId() const { return _realmId; }

        // Auxiliar private functions - defined to allow to maintain same code even
        // if internal structure changes.

        /// Checks if a permission is granted
        bool HasGrantedPermission(uint32 permissionId) const
        {
            return _grantedPerms.find(permissionId) != _grantedPerms.end();
        }

        /// Checks if a permission is denied
        bool HasDeniedPermission(uint32 permissionId) const
        {
            return _deniedPerms.find(permissionId) != _deniedPerms.end();
        }

        /// Adds a new granted permission
        void AddGrantedPermission(uint32 permissionId)
        {
            _grantedPerms.insert(permissionId);
        }

        /// Removes a granted permission
        void RemoveGrantedPermission(uint32 permissionId)
        {
            _grantedPerms.erase(permissionId);
        }

        /// Adds a new denied permission
        void AddDeniedPermission(uint32 permissionId)
        {
            _deniedPerms.insert(permissionId);
        }

        /// Removes a denied permission
        void RemoveDeniedPermission(uint32 permissionId)
        {
            _deniedPerms.erase(permissionId);
        }

        /// Adds a list of permissions to another list
        void AddPermissions(RBACPermissionContainer const& permsFrom, RBACPermissionContainer& permsTo);

        /// Removes a list of permissions from another list
        void RemovePermissions(RBACPermissionContainer& permsFrom, RBACPermissionContainer const& permsToRemove);

        /**
         * @name ExpandPermissions
         * @brief Adds the list of linked permissions to the original list
         *
         * Given a list of permissions, gets all the inherited permissions
         * @param permissions The list of permissions to expand
         */
        void ExpandPermissions(RBACPermissionContainer& permissions);

        uint32 _id;                                        ///> Account id
        std::string _name;                                 ///> Account name
        int32 _realmId;                                    ///> RealmId Affected
        uint8 _secLevel;                                   ///> Account SecurityLevel
        RBACPermissionContainer _grantedPerms;             ///> Granted permissions
        RBACPermissionContainer _deniedPerms;              ///> Denied permissions
        RBACPermissionContainer _globalPerms;              ///> Calculated permissions
};

}

#endif

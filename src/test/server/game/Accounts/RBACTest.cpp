/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

/**
 * @file RBACTest.cpp
 * @brief Unit tests for the Role-Based Access Control (RBAC) system.
 *
 * Tests verify:
 * 1. RBACPermission class construction and accessors
 * 2. RBACData grant/deny/revoke operations
 * 3. Permission state transitions
 * 4. HasPermission checks with granted/denied lists
 */

#include "AccountMgr.h"
#include "RBAC.h"
#include "gtest/gtest.h"
#include <memory>

namespace
{

// Test permission IDs
constexpr uint32 TEST_PERM_1 = 1;
constexpr uint32 TEST_PERM_2 = 2;
constexpr uint32 TEST_PERM_3 = 3;
constexpr uint32 TEST_PERM_ROLE = 100;
constexpr uint32 TEST_PERM_INVALID = 99999;

// Test account/realm data
constexpr uint32 TEST_ACCOUNT_ID = 1;
constexpr uint32 TEST_REALM_ID = 1;
constexpr uint8 TEST_SEC_LEVEL = 3;
const std::string TEST_ACCOUNT_NAME = "TestAccount";

/**
 * @class RBACPermissionTest
 * @brief Tests for RBACPermission class functionality.
 */
class RBACPermissionTest : public ::testing::Test
{
protected:
    void SetUp() override
    {
        permission = std::make_unique<rbac::RBACPermission>(TEST_PERM_1, "Test Permission");
    }

    std::unique_ptr<rbac::RBACPermission> permission;
};

TEST_F(RBACPermissionTest, Constructor_SetsIdAndName)
{
    EXPECT_EQ(permission->GetId(), TEST_PERM_1);
    EXPECT_EQ(permission->GetName(), "Test Permission");
}

TEST_F(RBACPermissionTest, LinkedPermissions_InitiallyEmpty)
{
    EXPECT_TRUE(permission->GetLinkedPermissions().empty());
}

TEST_F(RBACPermissionTest, AddLinkedPermission_AddsToSet)
{
    permission->AddLinkedPermission(TEST_PERM_2);
    permission->AddLinkedPermission(TEST_PERM_3);

    const auto& linked = permission->GetLinkedPermissions();
    EXPECT_EQ(linked.size(), 2u);
    EXPECT_TRUE(linked.count(TEST_PERM_2) > 0);
    EXPECT_TRUE(linked.count(TEST_PERM_3) > 0);
}

TEST_F(RBACPermissionTest, AddLinkedPermission_NoDuplicates)
{
    permission->AddLinkedPermission(TEST_PERM_2);
    permission->AddLinkedPermission(TEST_PERM_2);
    permission->AddLinkedPermission(TEST_PERM_2);

    EXPECT_EQ(permission->GetLinkedPermissions().size(), 1u);
}

/**
 * @class RBACDataTest
 * @brief Tests for RBACData class functionality with full server setup.
 *
 * Uses AccountMgr's test permission registration to allow proper
 * GrantPermission/DenyPermission testing.
 */
class RBACDataTest : public ::testing::Test
{
protected:
    void SetUp() override
    {
        // Register test permissions with AccountMgr
        sAccountMgr->AddPermissionForTest(TEST_PERM_1, "Test Permission 1");
        sAccountMgr->AddPermissionForTest(TEST_PERM_2, "Test Permission 2");
        sAccountMgr->AddPermissionForTest(TEST_PERM_3, "Test Permission 3");
        sAccountMgr->AddPermissionForTest(TEST_PERM_ROLE, "Test Role Permission");

        rbacData = std::make_unique<rbac::RBACData>(TEST_ACCOUNT_ID, TEST_ACCOUNT_NAME, TEST_REALM_ID, TEST_SEC_LEVEL);
    }

    void TearDown() override
    {
        // Clean up test permissions
        sAccountMgr->ClearPermissionsForTest();
    }

    std::unique_ptr<rbac::RBACData> rbacData;
};

TEST_F(RBACDataTest, Constructor_SetsAccountData)
{
    EXPECT_EQ(rbacData->GetId(), TEST_ACCOUNT_ID);
    EXPECT_EQ(rbacData->GetName(), TEST_ACCOUNT_NAME);
    EXPECT_EQ(rbacData->GetSecurityLevel(), TEST_SEC_LEVEL);
}

TEST_F(RBACDataTest, InitialState_EmptyPermissions)
{
    EXPECT_TRUE(rbacData->GetGrantedPermissions().empty());
    EXPECT_TRUE(rbacData->GetDeniedPermissions().empty());
}

// Grant Permission Tests

TEST_F(RBACDataTest, GrantPermission_Success)
{
    rbac::RBACCommandResult result = rbacData->GrantPermission(TEST_PERM_1);
    EXPECT_EQ(result, rbac::RBAC_OK);
    EXPECT_TRUE(rbacData->GetGrantedPermissions().count(TEST_PERM_1) > 0);
}

TEST_F(RBACDataTest, GrantPermission_AlreadyGranted_ReturnsError)
{
    rbacData->GrantPermission(TEST_PERM_1);
    rbac::RBACCommandResult result = rbacData->GrantPermission(TEST_PERM_1);
    EXPECT_EQ(result, rbac::RBAC_CANT_ADD_ALREADY_ADDED);
}

TEST_F(RBACDataTest, GrantPermission_WhenDenied_ReturnsError)
{
    rbacData->DenyPermission(TEST_PERM_1);
    rbac::RBACCommandResult result = rbacData->GrantPermission(TEST_PERM_1);
    EXPECT_EQ(result, rbac::RBAC_IN_DENIED_LIST);
}

TEST_F(RBACDataTest, GrantPermission_InvalidId_ReturnsError)
{
    rbac::RBACCommandResult result = rbacData->GrantPermission(TEST_PERM_INVALID);
    EXPECT_EQ(result, rbac::RBAC_ID_DOES_NOT_EXISTS);
}

// Deny Permission Tests

TEST_F(RBACDataTest, DenyPermission_Success)
{
    rbac::RBACCommandResult result = rbacData->DenyPermission(TEST_PERM_1);
    EXPECT_EQ(result, rbac::RBAC_OK);
    EXPECT_TRUE(rbacData->GetDeniedPermissions().count(TEST_PERM_1) > 0);
}

TEST_F(RBACDataTest, DenyPermission_AlreadyDenied_ReturnsError)
{
    rbacData->DenyPermission(TEST_PERM_1);
    rbac::RBACCommandResult result = rbacData->DenyPermission(TEST_PERM_1);
    EXPECT_EQ(result, rbac::RBAC_CANT_ADD_ALREADY_ADDED);
}

TEST_F(RBACDataTest, DenyPermission_WhenGranted_ReturnsError)
{
    rbacData->GrantPermission(TEST_PERM_1);
    rbac::RBACCommandResult result = rbacData->DenyPermission(TEST_PERM_1);
    EXPECT_EQ(result, rbac::RBAC_IN_GRANTED_LIST);
}

TEST_F(RBACDataTest, DenyPermission_InvalidId_ReturnsError)
{
    rbac::RBACCommandResult result = rbacData->DenyPermission(TEST_PERM_INVALID);
    EXPECT_EQ(result, rbac::RBAC_ID_DOES_NOT_EXISTS);
}

// Revoke Permission Tests

TEST_F(RBACDataTest, RevokePermission_FromGranted_Success)
{
    rbacData->GrantPermission(TEST_PERM_1);
    rbac::RBACCommandResult result = rbacData->RevokePermission(TEST_PERM_1);
    EXPECT_EQ(result, rbac::RBAC_OK);
    EXPECT_TRUE(rbacData->GetGrantedPermissions().empty());
}

TEST_F(RBACDataTest, RevokePermission_FromDenied_Success)
{
    rbacData->DenyPermission(TEST_PERM_1);
    rbac::RBACCommandResult result = rbacData->RevokePermission(TEST_PERM_1);
    EXPECT_EQ(result, rbac::RBAC_OK);
    EXPECT_TRUE(rbacData->GetDeniedPermissions().empty());
}

TEST_F(RBACDataTest, RevokePermission_NotInList_ReturnsError)
{
    rbac::RBACCommandResult result = rbacData->RevokePermission(TEST_PERM_1);
    EXPECT_EQ(result, rbac::RBAC_CANT_REVOKE_NOT_IN_LIST);
}

// HasPermission Tests

TEST_F(RBACDataTest, HasPermission_WhenGranted_ReturnsTrue)
{
    rbacData->GrantPermission(TEST_PERM_1);
    rbacData->RecalculatePermissions();
    EXPECT_TRUE(rbacData->HasPermission(TEST_PERM_1));
}

TEST_F(RBACDataTest, HasPermission_WhenDenied_ReturnsFalse)
{
    rbacData->DenyPermission(TEST_PERM_1);
    rbacData->RecalculatePermissions();
    EXPECT_FALSE(rbacData->HasPermission(TEST_PERM_1));
}

TEST_F(RBACDataTest, HasPermission_WhenNotSet_ReturnsFalse)
{
    EXPECT_FALSE(rbacData->HasPermission(TEST_PERM_1));
}

// Multiple Permissions Tests

TEST_F(RBACDataTest, MultiplePermissions_IndependentTracking)
{
    rbacData->GrantPermission(TEST_PERM_1);
    rbacData->DenyPermission(TEST_PERM_2);
    rbacData->GrantPermission(TEST_PERM_3);
    rbacData->RecalculatePermissions();

    EXPECT_TRUE(rbacData->HasPermission(TEST_PERM_1));
    EXPECT_FALSE(rbacData->HasPermission(TEST_PERM_2));
    EXPECT_TRUE(rbacData->HasPermission(TEST_PERM_3));

    EXPECT_EQ(rbacData->GetGrantedPermissions().size(), 2u);
    EXPECT_EQ(rbacData->GetDeniedPermissions().size(), 1u);
}

TEST_F(RBACDataTest, RevokeAndRegrant_WorksCorrectly)
{
    rbacData->GrantPermission(TEST_PERM_1);
    rbacData->RecalculatePermissions();
    EXPECT_TRUE(rbacData->HasPermission(TEST_PERM_1));

    rbacData->RevokePermission(TEST_PERM_1);
    rbacData->RecalculatePermissions();
    EXPECT_FALSE(rbacData->HasPermission(TEST_PERM_1));

    // Now can grant again
    rbac::RBACCommandResult result = rbacData->GrantPermission(TEST_PERM_1);
    EXPECT_EQ(result, rbac::RBAC_OK);
    rbacData->RecalculatePermissions();
    EXPECT_TRUE(rbacData->HasPermission(TEST_PERM_1));
}

TEST_F(RBACDataTest, RevokeAndDeny_WorksCorrectly)
{
    rbacData->GrantPermission(TEST_PERM_1);
    rbacData->RecalculatePermissions();
    EXPECT_TRUE(rbacData->HasPermission(TEST_PERM_1));

    rbacData->RevokePermission(TEST_PERM_1);
    rbacData->RecalculatePermissions();
    EXPECT_FALSE(rbacData->HasPermission(TEST_PERM_1));

    // Now can deny
    rbac::RBACCommandResult result = rbacData->DenyPermission(TEST_PERM_1);
    EXPECT_EQ(result, rbac::RBAC_OK);
    rbacData->RecalculatePermissions();
    EXPECT_FALSE(rbacData->HasPermission(TEST_PERM_1));
    EXPECT_TRUE(rbacData->GetDeniedPermissions().count(TEST_PERM_1) > 0);
}

/**
 * @class RBACCommandResultTest
 * @brief Tests to verify all RBACCommandResult values are handled.
 */
class RBACCommandResultTest : public ::testing::Test
{
};

TEST_F(RBACCommandResultTest, AllResultValuesAreDefined)
{
    // Verify enum values exist and are distinct
    EXPECT_NE(rbac::RBAC_OK, rbac::RBAC_CANT_ADD_ALREADY_ADDED);
    EXPECT_NE(rbac::RBAC_OK, rbac::RBAC_CANT_REVOKE_NOT_IN_LIST);
    EXPECT_NE(rbac::RBAC_OK, rbac::RBAC_IN_GRANTED_LIST);
    EXPECT_NE(rbac::RBAC_OK, rbac::RBAC_IN_DENIED_LIST);
    EXPECT_NE(rbac::RBAC_OK, rbac::RBAC_ID_DOES_NOT_EXISTS);
}

/**
 * @class RBACLinkedPermissionsTest
 * @brief Tests for permission inheritance through linked permissions.
 */
class RBACLinkedPermissionsTest : public ::testing::Test
{
protected:
    void SetUp() override
    {
        // Register test permissions
        sAccountMgr->AddPermissionForTest(TEST_PERM_1, "Base Permission 1");
        sAccountMgr->AddPermissionForTest(TEST_PERM_2, "Base Permission 2");
        sAccountMgr->AddPermissionForTest(TEST_PERM_3, "Base Permission 3");
        sAccountMgr->AddPermissionForTest(TEST_PERM_ROLE, "Role Permission");

        rbacData = std::make_unique<rbac::RBACData>(TEST_ACCOUNT_ID, TEST_ACCOUNT_NAME, TEST_REALM_ID, TEST_SEC_LEVEL);
    }

    void TearDown() override
    {
        sAccountMgr->ClearPermissionsForTest();
    }

    std::unique_ptr<rbac::RBACData> rbacData;
};

TEST_F(RBACLinkedPermissionsTest, GrantedPermission_IsInGrantedList)
{
    rbacData->GrantPermission(TEST_PERM_1);

    const auto& granted = rbacData->GetGrantedPermissions();
    EXPECT_TRUE(granted.count(TEST_PERM_1) > 0);
}

TEST_F(RBACLinkedPermissionsTest, DeniedPermission_IsInDeniedList)
{
    rbacData->DenyPermission(TEST_PERM_1);

    const auto& denied = rbacData->GetDeniedPermissions();
    EXPECT_TRUE(denied.count(TEST_PERM_1) > 0);
}

TEST_F(RBACLinkedPermissionsTest, DeniedPermission_OverridesGranted)
{
    // Grant permission, then revoke and deny
    rbacData->GrantPermission(TEST_PERM_1);
    rbacData->RecalculatePermissions();
    EXPECT_TRUE(rbacData->HasPermission(TEST_PERM_1));

    rbacData->RevokePermission(TEST_PERM_1);
    rbacData->DenyPermission(TEST_PERM_1);
    rbacData->RecalculatePermissions();

    EXPECT_FALSE(rbacData->HasPermission(TEST_PERM_1));
}

/**
 * @class RBACSecurityLevelTest
 * @brief Tests for security level accessor.
 */
class RBACSecurityLevelTest : public ::testing::Test
{
protected:
    void SetUp() override
    {
        // Register a test permission for the test
        sAccountMgr->AddPermissionForTest(TEST_PERM_1, "Test Permission");
    }

    void TearDown() override
    {
        sAccountMgr->ClearPermissionsForTest();
    }
};

TEST_F(RBACSecurityLevelTest, Constructor_PreservesSecurityLevel)
{
    rbac::RBACData rbacLevel0(1, "Player", 1, 0);
    EXPECT_EQ(rbacLevel0.GetSecurityLevel(), 0);

    rbac::RBACData rbacLevel1(2, "Moderator", 1, 1);
    EXPECT_EQ(rbacLevel1.GetSecurityLevel(), 1);

    rbac::RBACData rbacLevel2(3, "GameMaster", 1, 2);
    EXPECT_EQ(rbacLevel2.GetSecurityLevel(), 2);

    rbac::RBACData rbacLevel3(4, "Administrator", 1, 3);
    EXPECT_EQ(rbacLevel3.GetSecurityLevel(), 3);
}

TEST_F(RBACSecurityLevelTest, SetSecurityLevelForTest_UpdatesLevel)
{
    rbac::RBACData rbac(1, "TestAccount", 1, 0);
    EXPECT_EQ(rbac.GetSecurityLevel(), 0);

    // Use test-friendly setter that doesn't call LoadFromDB
    rbac.SetSecurityLevelForTest(3);
    EXPECT_EQ(rbac.GetSecurityLevel(), 3);
}

/**
 * @class RBACPermissionExpansionTest
 * @brief Tests for permission expansion through linked permissions.
 *
 * Tests verify that when a role/permission with linked permissions is granted,
 * all linked permissions become effective via ExpandPermissions().
 */
class RBACPermissionExpansionTest : public ::testing::Test
{
protected:
    // Permission structure for testing:
    // ROLE_GM (100) -> links to PERM_KICK (10), PERM_BAN (11)
    // ROLE_ADMIN (101) -> links to ROLE_GM (100), PERM_SHUTDOWN (12)
    // This creates a hierarchy: ADMIN -> GM -> individual permissions

    static constexpr uint32 PERM_KICK = 10;
    static constexpr uint32 PERM_BAN = 11;
    static constexpr uint32 PERM_SHUTDOWN = 12;
    static constexpr uint32 PERM_TELEPORT = 13;
    static constexpr uint32 ROLE_GM = 100;
    static constexpr uint32 ROLE_ADMIN = 101;

    void SetUp() override
    {
        // Register individual permissions
        sAccountMgr->AddPermissionForTest(PERM_KICK, "Kick Permission");
        sAccountMgr->AddPermissionForTest(PERM_BAN, "Ban Permission");
        sAccountMgr->AddPermissionForTest(PERM_SHUTDOWN, "Shutdown Permission");
        sAccountMgr->AddPermissionForTest(PERM_TELEPORT, "Teleport Permission");

        // Register role permissions
        sAccountMgr->AddPermissionForTest(ROLE_GM, "GameMaster Role");
        sAccountMgr->AddPermissionForTest(ROLE_ADMIN, "Administrator Role");

        // Set up permission hierarchy:
        // GM role includes kick and ban
        sAccountMgr->AddLinkedPermissionForTest(ROLE_GM, PERM_KICK);
        sAccountMgr->AddLinkedPermissionForTest(ROLE_GM, PERM_BAN);

        // Admin role includes GM role and shutdown
        sAccountMgr->AddLinkedPermissionForTest(ROLE_ADMIN, ROLE_GM);
        sAccountMgr->AddLinkedPermissionForTest(ROLE_ADMIN, PERM_SHUTDOWN);

        rbacData = std::make_unique<rbac::RBACData>(TEST_ACCOUNT_ID, TEST_ACCOUNT_NAME, TEST_REALM_ID, TEST_SEC_LEVEL);
    }

    void TearDown() override
    {
        sAccountMgr->ClearPermissionsForTest();
    }

    std::unique_ptr<rbac::RBACData> rbacData;
};

TEST_F(RBACPermissionExpansionTest, GrantRole_ExpandsLinkedPermissions)
{
    // Grant GM role
    rbacData->GrantPermission(ROLE_GM);
    rbacData->RecalculatePermissions();

    // Should have access to GM role and linked permissions (kick, ban)
    EXPECT_TRUE(rbacData->HasPermission(ROLE_GM));
    EXPECT_TRUE(rbacData->HasPermission(PERM_KICK));
    EXPECT_TRUE(rbacData->HasPermission(PERM_BAN));

    // Should NOT have access to unlinked permissions
    EXPECT_FALSE(rbacData->HasPermission(PERM_SHUTDOWN));
    EXPECT_FALSE(rbacData->HasPermission(PERM_TELEPORT));
}

TEST_F(RBACPermissionExpansionTest, GrantRole_RecursiveExpansion)
{
    // Grant Admin role (which links to GM role, which links to kick/ban)
    rbacData->GrantPermission(ROLE_ADMIN);
    rbacData->RecalculatePermissions();

    // Should have access to Admin role
    EXPECT_TRUE(rbacData->HasPermission(ROLE_ADMIN));

    // Should have access to directly linked permissions (GM role, shutdown)
    EXPECT_TRUE(rbacData->HasPermission(ROLE_GM));
    EXPECT_TRUE(rbacData->HasPermission(PERM_SHUTDOWN));

    // Should have access to recursively linked permissions (from GM role)
    EXPECT_TRUE(rbacData->HasPermission(PERM_KICK));
    EXPECT_TRUE(rbacData->HasPermission(PERM_BAN));

    // Should NOT have access to unlinked permissions
    EXPECT_FALSE(rbacData->HasPermission(PERM_TELEPORT));
}

TEST_F(RBACPermissionExpansionTest, DenyRole_PreventsLinkedPermissions)
{
    // Grant teleport individually
    rbacData->GrantPermission(PERM_TELEPORT);

    // Grant admin role (gives kick, ban, shutdown via expansion)
    rbacData->GrantPermission(ROLE_ADMIN);
    rbacData->RecalculatePermissions();

    // Verify all permissions are granted
    EXPECT_TRUE(rbacData->HasPermission(ROLE_ADMIN));
    EXPECT_TRUE(rbacData->HasPermission(PERM_KICK));
    EXPECT_TRUE(rbacData->HasPermission(PERM_TELEPORT));

    // Now revoke admin and deny the GM role
    rbacData->RevokePermission(ROLE_ADMIN);
    rbacData->DenyPermission(ROLE_GM);
    rbacData->RecalculatePermissions();

    // GM role and its linked permissions should be denied
    EXPECT_FALSE(rbacData->HasPermission(ROLE_GM));
    EXPECT_FALSE(rbacData->HasPermission(PERM_KICK));
    EXPECT_FALSE(rbacData->HasPermission(PERM_BAN));

    // Teleport was granted directly, not through GM, so should still work
    EXPECT_TRUE(rbacData->HasPermission(PERM_TELEPORT));
}

TEST_F(RBACPermissionExpansionTest, DenyRole_OverridesIndividualGrant)
{
    // Grant kick permission individually
    rbacData->GrantPermission(PERM_KICK);
    rbacData->RecalculatePermissions();
    EXPECT_TRUE(rbacData->HasPermission(PERM_KICK));

    // Deny the GM role (which links to kick)
    rbacData->DenyPermission(ROLE_GM);
    rbacData->RecalculatePermissions();

    // Denying a role expands to deny all linked permissions
    // Even though kick was granted individually, denying GM role
    // expands to deny kick as well (RBAC deny expansion)
    EXPECT_FALSE(rbacData->HasPermission(PERM_KICK));
    EXPECT_FALSE(rbacData->HasPermission(ROLE_GM));
    EXPECT_FALSE(rbacData->HasPermission(PERM_BAN));
}

/**
 * @class RBACDefaultPermissionsTest
 * @brief Tests for default permissions based on security level.
 *
 * Tests verify that default permissions from rbac_default_permissions
 * are properly applied based on account security level.
 */
class RBACDefaultPermissionsTest : public ::testing::Test
{
protected:
    static constexpr uint32 PERM_PLAYER_1 = 20;
    static constexpr uint32 PERM_PLAYER_2 = 21;
    static constexpr uint32 PERM_MOD_1 = 30;
    static constexpr uint32 PERM_GM_1 = 40;
    static constexpr uint32 PERM_ADMIN_1 = 50;

    static constexpr uint8 SEC_PLAYER = 0;
    static constexpr uint8 SEC_MODERATOR = 1;
    static constexpr uint8 SEC_GAMEMASTER = 2;
    static constexpr uint8 SEC_ADMINISTRATOR = 3;

    void SetUp() override
    {
        // Register test permissions
        sAccountMgr->AddPermissionForTest(PERM_PLAYER_1, "Player Permission 1");
        sAccountMgr->AddPermissionForTest(PERM_PLAYER_2, "Player Permission 2");
        sAccountMgr->AddPermissionForTest(PERM_MOD_1, "Moderator Permission 1");
        sAccountMgr->AddPermissionForTest(PERM_GM_1, "GameMaster Permission 1");
        sAccountMgr->AddPermissionForTest(PERM_ADMIN_1, "Administrator Permission 1");

        // Set up default permissions for security levels
        sAccountMgr->AddDefaultPermissionForTest(SEC_PLAYER, PERM_PLAYER_1);
        sAccountMgr->AddDefaultPermissionForTest(SEC_PLAYER, PERM_PLAYER_2);

        sAccountMgr->AddDefaultPermissionForTest(SEC_MODERATOR, PERM_MOD_1);

        sAccountMgr->AddDefaultPermissionForTest(SEC_GAMEMASTER, PERM_GM_1);

        sAccountMgr->AddDefaultPermissionForTest(SEC_ADMINISTRATOR, PERM_ADMIN_1);
    }

    void TearDown() override
    {
        sAccountMgr->ClearPermissionsForTest();
    }
};

TEST_F(RBACDefaultPermissionsTest, GetDefaultPermissions_ReturnsCorrectSet)
{
    rbac::RBACPermissionContainer const& playerPerms = sAccountMgr->GetRBACDefaultPermissions(SEC_PLAYER);
    EXPECT_EQ(playerPerms.size(), 2u);
    EXPECT_TRUE(playerPerms.count(PERM_PLAYER_1) > 0);
    EXPECT_TRUE(playerPerms.count(PERM_PLAYER_2) > 0);

    rbac::RBACPermissionContainer const& modPerms = sAccountMgr->GetRBACDefaultPermissions(SEC_MODERATOR);
    EXPECT_EQ(modPerms.size(), 1u);
    EXPECT_TRUE(modPerms.count(PERM_MOD_1) > 0);

    rbac::RBACPermissionContainer const& gmPerms = sAccountMgr->GetRBACDefaultPermissions(SEC_GAMEMASTER);
    EXPECT_EQ(gmPerms.size(), 1u);
    EXPECT_TRUE(gmPerms.count(PERM_GM_1) > 0);

    rbac::RBACPermissionContainer const& adminPerms = sAccountMgr->GetRBACDefaultPermissions(SEC_ADMINISTRATOR);
    EXPECT_EQ(adminPerms.size(), 1u);
    EXPECT_TRUE(adminPerms.count(PERM_ADMIN_1) > 0);
}

TEST_F(RBACDefaultPermissionsTest, GetDefaultPermissions_EmptySecLevel_ReturnsEmpty)
{
    // Security level 255 has no default permissions set
    rbac::RBACPermissionContainer const& emptyPerms = sAccountMgr->GetRBACDefaultPermissions(255);
    EXPECT_TRUE(emptyPerms.empty());
}

TEST_F(RBACDefaultPermissionsTest, SecurityLevel_DeterminesDefaultPermissions)
{
    // Create RBACData for a player account (sec level 0)
    rbac::RBACData playerData(1, "PlayerAccount", TEST_REALM_ID, SEC_PLAYER);

    // Manually grant the default permissions (simulating LoadFromDBCallback)
    rbac::RBACPermissionContainer const& playerDefaults = sAccountMgr->GetRBACDefaultPermissions(SEC_PLAYER);
    for (uint32 perm : playerDefaults)
        playerData.GrantPermission(perm);

    playerData.RecalculatePermissions();

    // Player should have player permissions
    EXPECT_TRUE(playerData.HasPermission(PERM_PLAYER_1));
    EXPECT_TRUE(playerData.HasPermission(PERM_PLAYER_2));

    // Player should NOT have higher level permissions
    EXPECT_FALSE(playerData.HasPermission(PERM_MOD_1));
    EXPECT_FALSE(playerData.HasPermission(PERM_GM_1));
    EXPECT_FALSE(playerData.HasPermission(PERM_ADMIN_1));
}

TEST_F(RBACDefaultPermissionsTest, HigherSecLevel_GetsOnlyOwnDefaults)
{
    // Create RBACData for an admin account (sec level 3)
    rbac::RBACData adminData(4, "AdminAccount", TEST_REALM_ID, SEC_ADMINISTRATOR);

    // Manually grant the default permissions for admin level
    rbac::RBACPermissionContainer const& adminDefaults = sAccountMgr->GetRBACDefaultPermissions(SEC_ADMINISTRATOR);
    for (uint32 perm : adminDefaults)
        adminData.GrantPermission(perm);

    adminData.RecalculatePermissions();

    // Admin gets their own default permissions
    EXPECT_TRUE(adminData.HasPermission(PERM_ADMIN_1));

    // Note: In a real setup, admin would typically have a role that links to
    // lower permissions. Here we're just testing that default permissions
    // are applied per security level, not inherited.
    // Without explicit roles linking them, admin doesn't automatically get
    // player/mod/gm permissions.
    EXPECT_FALSE(adminData.HasPermission(PERM_PLAYER_1));
    EXPECT_FALSE(adminData.HasPermission(PERM_MOD_1));
    EXPECT_FALSE(adminData.HasPermission(PERM_GM_1));
}

/**
 * @class RBACDeniedExpansionTest
 * @brief Tests for denied permission expansion.
 *
 * Tests verify that denied permissions are properly expanded
 * and remove access to linked permissions.
 */
class RBACDeniedExpansionTest : public ::testing::Test
{
protected:
    static constexpr uint32 PERM_KICK = 10;
    static constexpr uint32 PERM_BAN = 11;
    static constexpr uint32 ROLE_GM = 100;

    void SetUp() override
    {
        sAccountMgr->AddPermissionForTest(PERM_KICK, "Kick Permission");
        sAccountMgr->AddPermissionForTest(PERM_BAN, "Ban Permission");
        sAccountMgr->AddPermissionForTest(ROLE_GM, "GameMaster Role");

        sAccountMgr->AddLinkedPermissionForTest(ROLE_GM, PERM_KICK);
        sAccountMgr->AddLinkedPermissionForTest(ROLE_GM, PERM_BAN);

        rbacData = std::make_unique<rbac::RBACData>(TEST_ACCOUNT_ID, TEST_ACCOUNT_NAME, TEST_REALM_ID, TEST_SEC_LEVEL);
    }

    void TearDown() override
    {
        sAccountMgr->ClearPermissionsForTest();
    }

    std::unique_ptr<rbac::RBACData> rbacData;
};

TEST_F(RBACDeniedExpansionTest, DenyRole_ExpandsDeniedLinkedPermissions)
{
    // First grant individual permissions that would be linked from GM
    rbacData->GrantPermission(PERM_KICK);
    rbacData->GrantPermission(PERM_BAN);
    rbacData->RecalculatePermissions();

    EXPECT_TRUE(rbacData->HasPermission(PERM_KICK));
    EXPECT_TRUE(rbacData->HasPermission(PERM_BAN));

    // Now deny the GM role
    rbacData->DenyPermission(ROLE_GM);
    rbacData->RecalculatePermissions();

    // The GM role and its linked permissions should be denied
    // Even though kick/ban were granted individually, denying the role
    // that links them should expand to deny those permissions
    EXPECT_FALSE(rbacData->HasPermission(ROLE_GM));
    EXPECT_FALSE(rbacData->HasPermission(PERM_KICK));
    EXPECT_FALSE(rbacData->HasPermission(PERM_BAN));
}

TEST_F(RBACDeniedExpansionTest, GrantAndDenySameRole_DenyWins)
{
    // Grant the GM role
    rbacData->GrantPermission(ROLE_GM);
    rbacData->RecalculatePermissions();
    EXPECT_TRUE(rbacData->HasPermission(ROLE_GM));
    EXPECT_TRUE(rbacData->HasPermission(PERM_KICK));

    // Revoke and then deny
    rbacData->RevokePermission(ROLE_GM);
    rbacData->DenyPermission(ROLE_GM);
    rbacData->RecalculatePermissions();

    // Deny should win - no access
    EXPECT_FALSE(rbacData->HasPermission(ROLE_GM));
    EXPECT_FALSE(rbacData->HasPermission(PERM_KICK));
    EXPECT_FALSE(rbacData->HasPermission(PERM_BAN));
}

}  // namespace

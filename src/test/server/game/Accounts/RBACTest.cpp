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

    auto const& linked = permission->GetLinkedPermissions();
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

    auto const& granted = rbacData->GetGrantedPermissions();
    EXPECT_TRUE(granted.count(TEST_PERM_1) > 0);
}

TEST_F(RBACLinkedPermissionsTest, DeniedPermission_IsInDeniedList)
{
    rbacData->DenyPermission(TEST_PERM_1);

    auto const& denied = rbacData->GetDeniedPermissions();
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

// ---------------------------------------------------------------------------
// Suite 1: RBACPermissionRemoveLinkedTest
// ---------------------------------------------------------------------------
class RBACPermissionRemoveLinkedTest : public ::testing::Test
{
protected:
    void SetUp() override
    {
        permission = std::make_unique<rbac::RBACPermission>(TEST_PERM_1, "Test Permission");
        permission->AddLinkedPermission(TEST_PERM_2);
        permission->AddLinkedPermission(TEST_PERM_3);
    }

    std::unique_ptr<rbac::RBACPermission> permission;
};

TEST_F(RBACPermissionRemoveLinkedTest, RemoveLinkedPermission_RemovesFromSet)
{
    EXPECT_EQ(permission->GetLinkedPermissions().size(), 2u);
    permission->RemoveLinkedPermission(TEST_PERM_2);
    EXPECT_EQ(permission->GetLinkedPermissions().size(), 1u);
    EXPECT_EQ(permission->GetLinkedPermissions().count(TEST_PERM_2), 0u);
    EXPECT_EQ(permission->GetLinkedPermissions().count(TEST_PERM_3), 1u);
}

TEST_F(RBACPermissionRemoveLinkedTest, RemoveNonExistent_IsNoOp)
{
    permission->RemoveLinkedPermission(TEST_PERM_INVALID);
    EXPECT_EQ(permission->GetLinkedPermissions().size(), 2u);
}

TEST_F(RBACPermissionRemoveLinkedTest, RemoveAll_LeavesEmpty)
{
    permission->RemoveLinkedPermission(TEST_PERM_2);
    permission->RemoveLinkedPermission(TEST_PERM_3);
    EXPECT_TRUE(permission->GetLinkedPermissions().empty());
}

// ---------------------------------------------------------------------------
// Suite 2: RBACGetPermissionsTest (computed global perms)
// ---------------------------------------------------------------------------
class RBACGetPermissionsTest : public ::testing::Test
{
protected:
    static constexpr uint32 PERM_A = 10;
    static constexpr uint32 PERM_B = 11;
    static constexpr uint32 PERM_C = 12;
    static constexpr uint32 ROLE_R = 100;

    void SetUp() override
    {
        sAccountMgr->AddPermissionForTest(PERM_A, "Permission A");
        sAccountMgr->AddPermissionForTest(PERM_B, "Permission B");
        sAccountMgr->AddPermissionForTest(PERM_C, "Permission C");
        sAccountMgr->AddPermissionForTest(ROLE_R, "Role R");

        sAccountMgr->AddLinkedPermissionForTest(ROLE_R, PERM_A);
        sAccountMgr->AddLinkedPermissionForTest(ROLE_R, PERM_B);

        rbacData = std::make_unique<rbac::RBACData>(TEST_ACCOUNT_ID, TEST_ACCOUNT_NAME, TEST_REALM_ID, TEST_SEC_LEVEL);
    }

    void TearDown() override
    {
        sAccountMgr->ClearPermissionsForTest();
    }

    std::unique_ptr<rbac::RBACData> rbacData;
};

TEST_F(RBACGetPermissionsTest, Empty_WhenNothingGranted)
{
    rbacData->RecalculatePermissions();
    EXPECT_TRUE(rbacData->GetPermissions().empty());
}

TEST_F(RBACGetPermissionsTest, MatchesHasPermission)
{
    rbacData->GrantPermission(PERM_A);
    rbacData->GrantPermission(PERM_C);
    rbacData->RecalculatePermissions();

    auto const& perms = rbacData->GetPermissions();
    for (uint32 p : perms)
        EXPECT_TRUE(rbacData->HasPermission(p));
    EXPECT_FALSE(rbacData->HasPermission(PERM_B));
}

TEST_F(RBACGetPermissionsTest, ExcludesDeniedPermissions)
{
    rbacData->GrantPermission(PERM_A);
    rbacData->GrantPermission(PERM_C);
    rbacData->DenyPermission(PERM_B);
    rbacData->RecalculatePermissions();

    auto const& perms = rbacData->GetPermissions();
    EXPECT_TRUE(perms.count(PERM_A) > 0);
    EXPECT_TRUE(perms.count(PERM_C) > 0);
    EXPECT_EQ(perms.count(PERM_B), 0u);
}

TEST_F(RBACGetPermissionsTest, IncludesExpandedLinkedPermissions)
{
    rbacData->GrantPermission(ROLE_R);
    rbacData->RecalculatePermissions();

    auto const& perms = rbacData->GetPermissions();
    EXPECT_TRUE(perms.count(ROLE_R) > 0);
    EXPECT_TRUE(perms.count(PERM_A) > 0);
    EXPECT_TRUE(perms.count(PERM_B) > 0);
    EXPECT_EQ(perms.count(PERM_C), 0u);
}

TEST_F(RBACGetPermissionsTest, ReflectsStateAfterRecalculate)
{
    rbacData->GrantPermission(PERM_A);
    rbacData->RecalculatePermissions();
    EXPECT_TRUE(rbacData->GetPermissions().count(PERM_A) > 0);

    rbacData->RevokePermission(PERM_A);
    rbacData->RecalculatePermissions();
    EXPECT_EQ(rbacData->GetPermissions().count(PERM_A), 0u);
}

// ---------------------------------------------------------------------------
// Suite 3: RBACRevokeEdgeCasesTest
// ---------------------------------------------------------------------------
class RBACRevokeEdgeCasesTest : public ::testing::Test
{
protected:
    void SetUp() override
    {
        sAccountMgr->AddPermissionForTest(TEST_PERM_1, "Permission 1");
        sAccountMgr->AddPermissionForTest(TEST_PERM_2, "Permission 2");
        sAccountMgr->AddPermissionForTest(TEST_PERM_3, "Permission 3");

        rbacData = std::make_unique<rbac::RBACData>(TEST_ACCOUNT_ID, TEST_ACCOUNT_NAME, TEST_REALM_ID, TEST_SEC_LEVEL);
    }

    void TearDown() override
    {
        sAccountMgr->ClearPermissionsForTest();
    }

    std::unique_ptr<rbac::RBACData> rbacData;
};

TEST_F(RBACRevokeEdgeCasesTest, RevokeUnregistered_ReturnsCantRevoke)
{
    rbac::RBACCommandResult result = rbacData->RevokePermission(TEST_PERM_INVALID);
    EXPECT_EQ(result, rbac::RBAC_CANT_REVOKE_NOT_IN_LIST);
}

TEST_F(RBACRevokeEdgeCasesTest, RevokeFromEmpty_ReturnsError)
{
    rbac::RBACCommandResult result = rbacData->RevokePermission(TEST_PERM_1);
    EXPECT_EQ(result, rbac::RBAC_CANT_REVOKE_NOT_IN_LIST);
}

TEST_F(RBACRevokeEdgeCasesTest, RevokeGranted_ThenDeny)
{
    rbacData->GrantPermission(TEST_PERM_1);
    rbacData->RecalculatePermissions();
    EXPECT_TRUE(rbacData->HasPermission(TEST_PERM_1));

    rbacData->RevokePermission(TEST_PERM_1);
    rbac::RBACCommandResult result = rbacData->DenyPermission(TEST_PERM_1);
    EXPECT_EQ(result, rbac::RBAC_OK);
    rbacData->RecalculatePermissions();
    EXPECT_FALSE(rbacData->HasPermission(TEST_PERM_1));
    EXPECT_TRUE(rbacData->GetDeniedPermissions().count(TEST_PERM_1) > 0);
}

TEST_F(RBACRevokeEdgeCasesTest, RevokeDenied_ThenGrant)
{
    rbacData->DenyPermission(TEST_PERM_1);
    rbacData->RecalculatePermissions();
    EXPECT_FALSE(rbacData->HasPermission(TEST_PERM_1));

    rbacData->RevokePermission(TEST_PERM_1);
    rbac::RBACCommandResult result = rbacData->GrantPermission(TEST_PERM_1);
    EXPECT_EQ(result, rbac::RBAC_OK);
    rbacData->RecalculatePermissions();
    EXPECT_TRUE(rbacData->HasPermission(TEST_PERM_1));
}

TEST_F(RBACRevokeEdgeCasesTest, RevokeDoesNotAffectOtherPermissions)
{
    rbacData->GrantPermission(TEST_PERM_1);
    rbacData->GrantPermission(TEST_PERM_2);
    rbacData->DenyPermission(TEST_PERM_3);

    rbacData->RevokePermission(TEST_PERM_1);

    EXPECT_TRUE(rbacData->GetGrantedPermissions().count(TEST_PERM_2) > 0);
    EXPECT_TRUE(rbacData->GetDeniedPermissions().count(TEST_PERM_3) > 0);
    EXPECT_EQ(rbacData->GetGrantedPermissions().count(TEST_PERM_1), 0u);
}

// ---------------------------------------------------------------------------
// Suite 4: RBACComplexHierarchyTest
// ---------------------------------------------------------------------------
class RBACComplexHierarchyTest : public ::testing::Test
{
protected:
    // 3-level: Admin(100)->GM(101)->Mod(102)->individual perms
    static constexpr uint32 PERM_A = 10;
    static constexpr uint32 PERM_B = 11;
    static constexpr uint32 PERM_C = 12;
    static constexpr uint32 PERM_D = 13;
    static constexpr uint32 PERM_E = 14;
    static constexpr uint32 PERM_F = 15;
    static constexpr uint32 PERM_G = 16;
    static constexpr uint32 PERM_H = 17;
    static constexpr uint32 PERM_I = 18;
    static constexpr uint32 PERM_J = 19;
    static constexpr uint32 PERM_K = 20;
    static constexpr uint32 PERM_L = 21;
    static constexpr uint32 ROLE_MOD = 102;
    static constexpr uint32 ROLE_GM = 101;
    static constexpr uint32 ROLE_ADMIN = 100;
    // Diamond: ROLE_X(103) and ROLE_Y(104) both link to PERM_SHARED(22)
    static constexpr uint32 PERM_SHARED = 22;
    static constexpr uint32 PERM_X_ONLY = 23;
    static constexpr uint32 PERM_Y_ONLY = 24;
    static constexpr uint32 ROLE_X = 103;
    static constexpr uint32 ROLE_Y = 104;
    // Wide role
    static constexpr uint32 ROLE_WIDE = 105;

    void SetUp() override
    {
        // Register individual perms
        sAccountMgr->AddPermissionForTest(PERM_A, "A");
        sAccountMgr->AddPermissionForTest(PERM_B, "B");
        sAccountMgr->AddPermissionForTest(PERM_C, "C");
        sAccountMgr->AddPermissionForTest(PERM_D, "D");
        sAccountMgr->AddPermissionForTest(PERM_E, "E");
        sAccountMgr->AddPermissionForTest(PERM_F, "F");
        sAccountMgr->AddPermissionForTest(PERM_G, "G");
        sAccountMgr->AddPermissionForTest(PERM_H, "H");
        sAccountMgr->AddPermissionForTest(PERM_I, "I");
        sAccountMgr->AddPermissionForTest(PERM_J, "J");
        sAccountMgr->AddPermissionForTest(PERM_K, "K");
        sAccountMgr->AddPermissionForTest(PERM_L, "L");
        sAccountMgr->AddPermissionForTest(PERM_SHARED, "Shared");
        sAccountMgr->AddPermissionForTest(PERM_X_ONLY, "X Only");
        sAccountMgr->AddPermissionForTest(PERM_Y_ONLY, "Y Only");

        // Register roles
        sAccountMgr->AddPermissionForTest(ROLE_MOD, "Mod");
        sAccountMgr->AddPermissionForTest(ROLE_GM, "GM");
        sAccountMgr->AddPermissionForTest(ROLE_ADMIN, "Admin");
        sAccountMgr->AddPermissionForTest(ROLE_X, "X");
        sAccountMgr->AddPermissionForTest(ROLE_Y, "Y");
        sAccountMgr->AddPermissionForTest(ROLE_WIDE, "Wide");

        // 3-level hierarchy
        sAccountMgr->AddLinkedPermissionForTest(ROLE_MOD, PERM_A);
        sAccountMgr->AddLinkedPermissionForTest(ROLE_MOD, PERM_B);
        sAccountMgr->AddLinkedPermissionForTest(ROLE_GM, ROLE_MOD);
        sAccountMgr->AddLinkedPermissionForTest(ROLE_GM, PERM_C);
        sAccountMgr->AddLinkedPermissionForTest(ROLE_ADMIN, ROLE_GM);
        sAccountMgr->AddLinkedPermissionForTest(ROLE_ADMIN, PERM_D);

        // Diamond inheritance
        sAccountMgr->AddLinkedPermissionForTest(ROLE_X, PERM_SHARED);
        sAccountMgr->AddLinkedPermissionForTest(ROLE_X, PERM_X_ONLY);
        sAccountMgr->AddLinkedPermissionForTest(ROLE_Y, PERM_SHARED);
        sAccountMgr->AddLinkedPermissionForTest(ROLE_Y, PERM_Y_ONLY);

        // Wide role (10+ linked perms)
        sAccountMgr->AddLinkedPermissionForTest(ROLE_WIDE, PERM_A);
        sAccountMgr->AddLinkedPermissionForTest(ROLE_WIDE, PERM_B);
        sAccountMgr->AddLinkedPermissionForTest(ROLE_WIDE, PERM_C);
        sAccountMgr->AddLinkedPermissionForTest(ROLE_WIDE, PERM_D);
        sAccountMgr->AddLinkedPermissionForTest(ROLE_WIDE, PERM_E);
        sAccountMgr->AddLinkedPermissionForTest(ROLE_WIDE, PERM_F);
        sAccountMgr->AddLinkedPermissionForTest(ROLE_WIDE, PERM_G);
        sAccountMgr->AddLinkedPermissionForTest(ROLE_WIDE, PERM_H);
        sAccountMgr->AddLinkedPermissionForTest(ROLE_WIDE, PERM_I);
        sAccountMgr->AddLinkedPermissionForTest(ROLE_WIDE, PERM_J);
        sAccountMgr->AddLinkedPermissionForTest(ROLE_WIDE, PERM_K);
        sAccountMgr->AddLinkedPermissionForTest(ROLE_WIDE, PERM_L);

        rbacData = std::make_unique<rbac::RBACData>(TEST_ACCOUNT_ID, TEST_ACCOUNT_NAME, TEST_REALM_ID, TEST_SEC_LEVEL);
    }

    void TearDown() override
    {
        sAccountMgr->ClearPermissionsForTest();
    }

    std::unique_ptr<rbac::RBACData> rbacData;
};

TEST_F(RBACComplexHierarchyTest, ThreeLevelDeep)
{
    rbacData->GrantPermission(ROLE_ADMIN);
    rbacData->RecalculatePermissions();

    EXPECT_TRUE(rbacData->HasPermission(ROLE_ADMIN));
    EXPECT_TRUE(rbacData->HasPermission(ROLE_GM));
    EXPECT_TRUE(rbacData->HasPermission(ROLE_MOD));
    EXPECT_TRUE(rbacData->HasPermission(PERM_A));
    EXPECT_TRUE(rbacData->HasPermission(PERM_B));
    EXPECT_TRUE(rbacData->HasPermission(PERM_C));
    EXPECT_TRUE(rbacData->HasPermission(PERM_D));
}

TEST_F(RBACComplexHierarchyTest, DiamondInheritance)
{
    rbacData->GrantPermission(ROLE_X);
    rbacData->GrantPermission(ROLE_Y);
    rbacData->RecalculatePermissions();

    EXPECT_TRUE(rbacData->HasPermission(PERM_SHARED));
    EXPECT_TRUE(rbacData->HasPermission(PERM_X_ONLY));
    EXPECT_TRUE(rbacData->HasPermission(PERM_Y_ONLY));
}

TEST_F(RBACComplexHierarchyTest, WideRole)
{
    rbacData->GrantPermission(ROLE_WIDE);
    rbacData->RecalculatePermissions();

    EXPECT_TRUE(rbacData->HasPermission(ROLE_WIDE));
    EXPECT_TRUE(rbacData->HasPermission(PERM_A));
    EXPECT_TRUE(rbacData->HasPermission(PERM_L));
    EXPECT_EQ(rbacData->GetPermissions().size(), 13u); // ROLE_WIDE + 12 perms
}

TEST_F(RBACComplexHierarchyTest, TwoOverlappingRoles_NoDuplicateInGetPermissions)
{
    // Both ROLE_X and ROLE_Y link to PERM_SHARED
    rbacData->GrantPermission(ROLE_X);
    rbacData->GrantPermission(ROLE_Y);
    rbacData->RecalculatePermissions();

    auto const& perms = rbacData->GetPermissions();
    // ROLE_X, ROLE_Y, PERM_SHARED, PERM_X_ONLY, PERM_Y_ONLY = 5
    EXPECT_EQ(perms.size(), 5u);
    EXPECT_EQ(perms.count(PERM_SHARED), 1u);
}

TEST_F(RBACComplexHierarchyTest, RevokeOneOverlappingRole_KeepsSharedFromOther)
{
    rbacData->GrantPermission(ROLE_X);
    rbacData->GrantPermission(ROLE_Y);
    rbacData->RecalculatePermissions();
    EXPECT_TRUE(rbacData->HasPermission(PERM_SHARED));

    rbacData->RevokePermission(ROLE_X);
    rbacData->RecalculatePermissions();

    // PERM_SHARED still accessible through ROLE_Y
    EXPECT_TRUE(rbacData->HasPermission(PERM_SHARED));
    EXPECT_TRUE(rbacData->HasPermission(PERM_Y_ONLY));
    EXPECT_FALSE(rbacData->HasPermission(PERM_X_ONLY));
}

// ---------------------------------------------------------------------------
// Suite 5: RBACDenySpecificFromRoleTest
// ---------------------------------------------------------------------------
class RBACDenySpecificFromRoleTest : public ::testing::Test
{
protected:
    static constexpr uint32 PERM_KICK = 10;
    static constexpr uint32 PERM_BAN = 11;
    static constexpr uint32 PERM_MUTE = 12;
    static constexpr uint32 PERM_SHUTDOWN = 13;
    static constexpr uint32 ROLE_MOD = 100;
    static constexpr uint32 ROLE_ADMIN = 101;

    void SetUp() override
    {
        sAccountMgr->AddPermissionForTest(PERM_KICK, "Kick");
        sAccountMgr->AddPermissionForTest(PERM_BAN, "Ban");
        sAccountMgr->AddPermissionForTest(PERM_MUTE, "Mute");
        sAccountMgr->AddPermissionForTest(PERM_SHUTDOWN, "Shutdown");
        sAccountMgr->AddPermissionForTest(ROLE_MOD, "Moderator");
        sAccountMgr->AddPermissionForTest(ROLE_ADMIN, "Admin");

        sAccountMgr->AddLinkedPermissionForTest(ROLE_MOD, PERM_KICK);
        sAccountMgr->AddLinkedPermissionForTest(ROLE_MOD, PERM_BAN);
        sAccountMgr->AddLinkedPermissionForTest(ROLE_MOD, PERM_MUTE);
        sAccountMgr->AddLinkedPermissionForTest(ROLE_ADMIN, PERM_SHUTDOWN);

        rbacData = std::make_unique<rbac::RBACData>(TEST_ACCOUNT_ID, TEST_ACCOUNT_NAME, TEST_REALM_ID, TEST_SEC_LEVEL);
    }

    void TearDown() override
    {
        sAccountMgr->ClearPermissionsForTest();
    }

    std::unique_ptr<rbac::RBACData> rbacData;
};

TEST_F(RBACDenySpecificFromRoleTest, DenyOneChild_SiblingsStillGranted)
{
    rbacData->GrantPermission(ROLE_MOD);
    rbacData->DenyPermission(PERM_BAN);
    rbacData->RecalculatePermissions();

    EXPECT_TRUE(rbacData->HasPermission(ROLE_MOD));
    EXPECT_TRUE(rbacData->HasPermission(PERM_KICK));
    EXPECT_TRUE(rbacData->HasPermission(PERM_MUTE));
    EXPECT_FALSE(rbacData->HasPermission(PERM_BAN));
}

TEST_F(RBACDenySpecificFromRoleTest, DenyPermNotInRole_RolePermsUnaffected)
{
    rbacData->GrantPermission(ROLE_MOD);
    rbacData->DenyPermission(PERM_SHUTDOWN);
    rbacData->RecalculatePermissions();

    EXPECT_TRUE(rbacData->HasPermission(ROLE_MOD));
    EXPECT_TRUE(rbacData->HasPermission(PERM_KICK));
    EXPECT_TRUE(rbacData->HasPermission(PERM_BAN));
    EXPECT_TRUE(rbacData->HasPermission(PERM_MUTE));
    EXPECT_FALSE(rbacData->HasPermission(PERM_SHUTDOWN));
}

TEST_F(RBACDenySpecificFromRoleTest, GrantTwoRoles_DenyOneRole)
{
    rbacData->GrantPermission(ROLE_MOD);
    rbacData->GrantPermission(ROLE_ADMIN);
    rbacData->RecalculatePermissions();
    EXPECT_TRUE(rbacData->HasPermission(PERM_SHUTDOWN));
    EXPECT_TRUE(rbacData->HasPermission(PERM_KICK));

    // Revoke and deny ROLE_ADMIN
    rbacData->RevokePermission(ROLE_ADMIN);
    rbacData->DenyPermission(ROLE_ADMIN);
    rbacData->RecalculatePermissions();

    // ROLE_ADMIN and its unique perm (SHUTDOWN) denied
    EXPECT_FALSE(rbacData->HasPermission(ROLE_ADMIN));
    EXPECT_FALSE(rbacData->HasPermission(PERM_SHUTDOWN));

    // ROLE_MOD perms remain
    EXPECT_TRUE(rbacData->HasPermission(ROLE_MOD));
    EXPECT_TRUE(rbacData->HasPermission(PERM_KICK));
    EXPECT_TRUE(rbacData->HasPermission(PERM_BAN));
    EXPECT_TRUE(rbacData->HasPermission(PERM_MUTE));
}

// ---------------------------------------------------------------------------
// Suite 6: RBACDefaultPermissionsWithRolesTest
// ---------------------------------------------------------------------------
class RBACDefaultPermissionsWithRolesTest : public ::testing::Test
{
protected:
    static constexpr uint32 PERM_A = 10;
    static constexpr uint32 PERM_B = 11;
    static constexpr uint32 PERM_C = 12;
    static constexpr uint32 PERM_MOD_1 = 13;
    static constexpr uint32 ROLE_PLAYER = 100;

    static constexpr uint8 SEC_PLAYER = 0;
    static constexpr uint8 SEC_MODERATOR = 1;

    void SetUp() override
    {
        sAccountMgr->AddPermissionForTest(PERM_A, "A");
        sAccountMgr->AddPermissionForTest(PERM_B, "B");
        sAccountMgr->AddPermissionForTest(PERM_C, "C");
        sAccountMgr->AddPermissionForTest(PERM_MOD_1, "Mod 1");
        sAccountMgr->AddPermissionForTest(ROLE_PLAYER, "Player Role");

        sAccountMgr->AddLinkedPermissionForTest(ROLE_PLAYER, PERM_A);
        sAccountMgr->AddLinkedPermissionForTest(ROLE_PLAYER, PERM_B);

        // Default: Player gets ROLE_PLAYER, Moderator gets PERM_MOD_1
        sAccountMgr->AddDefaultPermissionForTest(SEC_PLAYER, ROLE_PLAYER);
        sAccountMgr->AddDefaultPermissionForTest(SEC_MODERATOR, PERM_MOD_1);
    }

    void TearDown() override
    {
        sAccountMgr->ClearPermissionsForTest();
    }
};

TEST_F(RBACDefaultPermissionsWithRolesTest, DefaultRoleExpandsLinked)
{
    rbac::RBACData data(1, "Player", TEST_REALM_ID, SEC_PLAYER);

    // Simulate LoadFromDBCallback: grant defaults then recalculate
    rbac::RBACPermissionContainer const& defaults = sAccountMgr->GetRBACDefaultPermissions(SEC_PLAYER);
    for (uint32 perm : defaults)
        data.GrantPermission(perm);
    data.RecalculatePermissions();

    EXPECT_TRUE(data.HasPermission(ROLE_PLAYER));
    EXPECT_TRUE(data.HasPermission(PERM_A));
    EXPECT_TRUE(data.HasPermission(PERM_B));
}

TEST_F(RBACDefaultPermissionsWithRolesTest, DefaultRole_DenyLinkedChild)
{
    rbac::RBACData data(1, "Player", TEST_REALM_ID, SEC_PLAYER);

    rbac::RBACPermissionContainer const& defaults = sAccountMgr->GetRBACDefaultPermissions(SEC_PLAYER);
    for (uint32 perm : defaults)
        data.GrantPermission(perm);

    data.DenyPermission(PERM_B);
    data.RecalculatePermissions();

    EXPECT_TRUE(data.HasPermission(ROLE_PLAYER));
    EXPECT_TRUE(data.HasPermission(PERM_A));
    EXPECT_FALSE(data.HasPermission(PERM_B));
}

TEST_F(RBACDefaultPermissionsWithRolesTest, SecLevels_NoCrossContamination)
{
    rbac::RBACData playerData(1, "Player", TEST_REALM_ID, SEC_PLAYER);
    rbac::RBACData modData(2, "Mod", TEST_REALM_ID, SEC_MODERATOR);

    // Grant defaults for each
    for (uint32 p : sAccountMgr->GetRBACDefaultPermissions(SEC_PLAYER))
        playerData.GrantPermission(p);
    playerData.RecalculatePermissions();

    for (uint32 p : sAccountMgr->GetRBACDefaultPermissions(SEC_MODERATOR))
        modData.GrantPermission(p);
    modData.RecalculatePermissions();

    // Player has player perms, not mod perms
    EXPECT_TRUE(playerData.HasPermission(PERM_A));
    EXPECT_FALSE(playerData.HasPermission(PERM_MOD_1));

    // Mod has mod perms, not player perms (unless explicitly granted)
    EXPECT_TRUE(modData.HasPermission(PERM_MOD_1));
    EXPECT_FALSE(modData.HasPermission(PERM_A));
}

// ---------------------------------------------------------------------------
// Suite 7: RBACPermissionEnumConsistencyTest
// ---------------------------------------------------------------------------
class RBACPermissionEnumConsistencyTest : public ::testing::Test
{
protected:
    void SetUp() override
    {
        sAccountMgr->AddPermissionForTest(500, "Perm 500");
        sAccountMgr->AddPermissionForTest(700, "Perm 700");
        sAccountMgr->AddPermissionForTest(900, "Perm 900");
    }

    void TearDown() override
    {
        sAccountMgr->ClearPermissionsForTest();
    }
};

TEST_F(RBACPermissionEnumConsistencyTest, MaxGreaterThanHighestDefined)
{
    EXPECT_GT(static_cast<uint32>(rbac::RBAC_PERM_MAX), 911u);
}

TEST_F(RBACPermissionEnumConsistencyTest, RoleIdsWithinRange)
{
    EXPECT_LT(static_cast<uint32>(rbac::RBAC_ROLE_ADMINISTRATOR), static_cast<uint32>(rbac::RBAC_PERM_MAX));
    EXPECT_LT(static_cast<uint32>(rbac::RBAC_ROLE_GAMEMASTER), static_cast<uint32>(rbac::RBAC_PERM_MAX));
    EXPECT_LT(static_cast<uint32>(rbac::RBAC_ROLE_MODERATOR), static_cast<uint32>(rbac::RBAC_PERM_MAX));
    EXPECT_LT(static_cast<uint32>(rbac::RBAC_ROLE_PLAYER), static_cast<uint32>(rbac::RBAC_PERM_MAX));
}

TEST_F(RBACPermissionEnumConsistencyTest, NonContiguousIds_Work)
{
    rbac::RBACData data(1, "Test", TEST_REALM_ID, 0);

    data.GrantPermission(500);
    data.GrantPermission(900);
    data.DenyPermission(700);
    data.RecalculatePermissions();

    EXPECT_TRUE(data.HasPermission(500));
    EXPECT_TRUE(data.HasPermission(900));
    EXPECT_FALSE(data.HasPermission(700));
}

// ---------------------------------------------------------------------------
// Suite 8: RBACEmptyAndBoundaryTest
// ---------------------------------------------------------------------------
class RBACEmptyAndBoundaryTest : public ::testing::Test
{
protected:
    void SetUp() override
    {
        sAccountMgr->AddPermissionForTest(TEST_PERM_1, "Permission 1");
        rbacData = std::make_unique<rbac::RBACData>(TEST_ACCOUNT_ID, TEST_ACCOUNT_NAME, TEST_REALM_ID, TEST_SEC_LEVEL);
    }

    void TearDown() override
    {
        sAccountMgr->ClearPermissionsForTest();
    }

    std::unique_ptr<rbac::RBACData> rbacData;
};

TEST_F(RBACEmptyAndBoundaryTest, FreshData_AllEmpty)
{
    EXPECT_TRUE(rbacData->GetGrantedPermissions().empty());
    EXPECT_TRUE(rbacData->GetDeniedPermissions().empty());
    EXPECT_TRUE(rbacData->GetPermissions().empty());
}

TEST_F(RBACEmptyAndBoundaryTest, HasPermission_Zero_ReturnsFalse)
{
    EXPECT_FALSE(rbacData->HasPermission(0));
}

TEST_F(RBACEmptyAndBoundaryTest, HasPermission_Max_ReturnsFalse)
{
    EXPECT_FALSE(rbacData->HasPermission(rbac::RBAC_PERM_MAX));
}

TEST_F(RBACEmptyAndBoundaryTest, GrantDenyRevokeSequence)
{
    rbac::RBACCommandResult r1 = rbacData->GrantPermission(TEST_PERM_1);
    EXPECT_EQ(r1, rbac::RBAC_OK);
    rbacData->RecalculatePermissions();
    EXPECT_TRUE(rbacData->HasPermission(TEST_PERM_1));

    rbac::RBACCommandResult r2 = rbacData->RevokePermission(TEST_PERM_1);
    EXPECT_EQ(r2, rbac::RBAC_OK);

    rbac::RBACCommandResult r3 = rbacData->DenyPermission(TEST_PERM_1);
    EXPECT_EQ(r3, rbac::RBAC_OK);
    rbacData->RecalculatePermissions();
    EXPECT_FALSE(rbacData->HasPermission(TEST_PERM_1));

    rbac::RBACCommandResult r4 = rbacData->RevokePermission(TEST_PERM_1);
    EXPECT_EQ(r4, rbac::RBAC_OK);
    rbacData->RecalculatePermissions();
    EXPECT_FALSE(rbacData->HasPermission(TEST_PERM_1));
}

TEST_F(RBACEmptyAndBoundaryTest, MultipleRecalculates_Idempotent)
{
    rbacData->GrantPermission(TEST_PERM_1);
    rbacData->RecalculatePermissions();
    auto perms1 = rbacData->GetPermissions();

    rbacData->RecalculatePermissions();
    auto perms2 = rbacData->GetPermissions();

    rbacData->RecalculatePermissions();
    auto perms3 = rbacData->GetPermissions();

    EXPECT_EQ(perms1, perms2);
    EXPECT_EQ(perms2, perms3);
}

TEST_F(RBACEmptyAndBoundaryTest, RecalculateOnEmpty_Safe)
{
    rbacData->RecalculatePermissions();
    EXPECT_TRUE(rbacData->GetPermissions().empty());

    rbacData->RecalculatePermissions();
    EXPECT_TRUE(rbacData->GetPermissions().empty());
}

// ---------------------------------------------------------------------------
// Suite 9: RBACCircularLinkProtectionTest
// ---------------------------------------------------------------------------
class RBACCircularLinkProtectionTest : public ::testing::Test
{
protected:
    static constexpr uint32 PERM_A = 10;
    static constexpr uint32 PERM_B = 11;
    static constexpr uint32 PERM_C = 12;

    void SetUp() override
    {
        sAccountMgr->AddPermissionForTest(PERM_A, "A");
        sAccountMgr->AddPermissionForTest(PERM_B, "B");
        sAccountMgr->AddPermissionForTest(PERM_C, "C");
    }

    void TearDown() override
    {
        sAccountMgr->ClearPermissionsForTest();
    }
};

TEST_F(RBACCircularLinkProtectionTest, MutualLink_BothGranted)
{
    sAccountMgr->AddLinkedPermissionForTest(PERM_A, PERM_B);
    sAccountMgr->AddLinkedPermissionForTest(PERM_B, PERM_A);

    rbac::RBACData data(1, "Test", TEST_REALM_ID, 0);
    data.GrantPermission(PERM_A);
    data.RecalculatePermissions();

    EXPECT_TRUE(data.HasPermission(PERM_A));
    EXPECT_TRUE(data.HasPermission(PERM_B));
}

TEST_F(RBACCircularLinkProtectionTest, SelfReferencing_Terminates)
{
    sAccountMgr->AddLinkedPermissionForTest(PERM_A, PERM_A);

    rbac::RBACData data(1, "Test", TEST_REALM_ID, 0);
    data.GrantPermission(PERM_A);
    data.RecalculatePermissions();

    EXPECT_TRUE(data.HasPermission(PERM_A));
    EXPECT_EQ(data.GetPermissions().size(), 1u);
}

TEST_F(RBACCircularLinkProtectionTest, CircularChainOf3_AllGranted)
{
    sAccountMgr->AddLinkedPermissionForTest(PERM_A, PERM_B);
    sAccountMgr->AddLinkedPermissionForTest(PERM_B, PERM_C);
    sAccountMgr->AddLinkedPermissionForTest(PERM_C, PERM_A);

    rbac::RBACData data(1, "Test", TEST_REALM_ID, 0);
    data.GrantPermission(PERM_A);
    data.RecalculatePermissions();

    EXPECT_TRUE(data.HasPermission(PERM_A));
    EXPECT_TRUE(data.HasPermission(PERM_B));
    EXPECT_TRUE(data.HasPermission(PERM_C));
    EXPECT_EQ(data.GetPermissions().size(), 3u);
}

// ---------------------------------------------------------------------------
// Suite 10: RBACFullRoleHierarchyTest (mirrors actual 192-199 structure)
// ---------------------------------------------------------------------------
class RBACFullRoleHierarchyTest : public ::testing::Test
{
protected:
    // Roles
    static constexpr uint32 ROLE_PLAYER = 199;
    static constexpr uint32 ROLE_MOD = 198;
    static constexpr uint32 ROLE_GM = 197;
    static constexpr uint32 ROLE_ADMIN = 196;

    // Individual perms
    static constexpr uint32 PERM_PLAYER_1 = 10;
    static constexpr uint32 PERM_PLAYER_2 = 11;
    static constexpr uint32 PERM_MOD_1 = 20;
    static constexpr uint32 PERM_MOD_2 = 21;
    static constexpr uint32 PERM_GM_1 = 30;
    static constexpr uint32 PERM_GM_2 = 31;
    static constexpr uint32 PERM_ADMIN_1 = 40;
    static constexpr uint32 PERM_ADMIN_2 = 41;

    void SetUp() override
    {
        // Register individual perms
        sAccountMgr->AddPermissionForTest(PERM_PLAYER_1, "Player 1");
        sAccountMgr->AddPermissionForTest(PERM_PLAYER_2, "Player 2");
        sAccountMgr->AddPermissionForTest(PERM_MOD_1, "Mod 1");
        sAccountMgr->AddPermissionForTest(PERM_MOD_2, "Mod 2");
        sAccountMgr->AddPermissionForTest(PERM_GM_1, "GM 1");
        sAccountMgr->AddPermissionForTest(PERM_GM_2, "GM 2");
        sAccountMgr->AddPermissionForTest(PERM_ADMIN_1, "Admin 1");
        sAccountMgr->AddPermissionForTest(PERM_ADMIN_2, "Admin 2");

        // Register roles
        sAccountMgr->AddPermissionForTest(ROLE_PLAYER, "Player Role");
        sAccountMgr->AddPermissionForTest(ROLE_MOD, "Moderator Role");
        sAccountMgr->AddPermissionForTest(ROLE_GM, "GameMaster Role");
        sAccountMgr->AddPermissionForTest(ROLE_ADMIN, "Administrator Role");

        // Player(199) -> basic perms
        sAccountMgr->AddLinkedPermissionForTest(ROLE_PLAYER, PERM_PLAYER_1);
        sAccountMgr->AddLinkedPermissionForTest(ROLE_PLAYER, PERM_PLAYER_2);

        // Mod(198) -> Player + mod perms
        sAccountMgr->AddLinkedPermissionForTest(ROLE_MOD, ROLE_PLAYER);
        sAccountMgr->AddLinkedPermissionForTest(ROLE_MOD, PERM_MOD_1);
        sAccountMgr->AddLinkedPermissionForTest(ROLE_MOD, PERM_MOD_2);

        // GM(197) -> Mod + gm perms
        sAccountMgr->AddLinkedPermissionForTest(ROLE_GM, ROLE_MOD);
        sAccountMgr->AddLinkedPermissionForTest(ROLE_GM, PERM_GM_1);
        sAccountMgr->AddLinkedPermissionForTest(ROLE_GM, PERM_GM_2);

        // Admin(196) -> GM + admin perms
        sAccountMgr->AddLinkedPermissionForTest(ROLE_ADMIN, ROLE_GM);
        sAccountMgr->AddLinkedPermissionForTest(ROLE_ADMIN, PERM_ADMIN_1);
        sAccountMgr->AddLinkedPermissionForTest(ROLE_ADMIN, PERM_ADMIN_2);
    }

    void TearDown() override
    {
        sAccountMgr->ClearPermissionsForTest();
    }
};

TEST_F(RBACFullRoleHierarchyTest, GrantPlayerRole_OnlyPlayerPerms)
{
    rbac::RBACData data(1, "Player", TEST_REALM_ID, 0);
    data.GrantPermission(ROLE_PLAYER);
    data.RecalculatePermissions();

    EXPECT_TRUE(data.HasPermission(ROLE_PLAYER));
    EXPECT_TRUE(data.HasPermission(PERM_PLAYER_1));
    EXPECT_TRUE(data.HasPermission(PERM_PLAYER_2));

    EXPECT_FALSE(data.HasPermission(PERM_MOD_1));
    EXPECT_FALSE(data.HasPermission(PERM_GM_1));
    EXPECT_FALSE(data.HasPermission(PERM_ADMIN_1));
    // 3 total: ROLE_PLAYER + 2 player perms
    EXPECT_EQ(data.GetPermissions().size(), 3u);
}

TEST_F(RBACFullRoleHierarchyTest, GrantGMRole_FullChain)
{
    rbac::RBACData data(1, "GM", TEST_REALM_ID, 0);
    data.GrantPermission(ROLE_GM);
    data.RecalculatePermissions();

    // GM + Mod + Player perms
    EXPECT_TRUE(data.HasPermission(ROLE_GM));
    EXPECT_TRUE(data.HasPermission(ROLE_MOD));
    EXPECT_TRUE(data.HasPermission(ROLE_PLAYER));
    EXPECT_TRUE(data.HasPermission(PERM_PLAYER_1));
    EXPECT_TRUE(data.HasPermission(PERM_PLAYER_2));
    EXPECT_TRUE(data.HasPermission(PERM_MOD_1));
    EXPECT_TRUE(data.HasPermission(PERM_MOD_2));
    EXPECT_TRUE(data.HasPermission(PERM_GM_1));
    EXPECT_TRUE(data.HasPermission(PERM_GM_2));

    EXPECT_FALSE(data.HasPermission(PERM_ADMIN_1));
    EXPECT_FALSE(data.HasPermission(PERM_ADMIN_2));
    // 9 total: 3 roles + 6 perms
    EXPECT_EQ(data.GetPermissions().size(), 9u);
}

TEST_F(RBACFullRoleHierarchyTest, GrantAdminRole_AllPerms)
{
    rbac::RBACData data(1, "Admin", TEST_REALM_ID, 0);
    data.GrantPermission(ROLE_ADMIN);
    data.RecalculatePermissions();

    EXPECT_TRUE(data.HasPermission(ROLE_ADMIN));
    EXPECT_TRUE(data.HasPermission(ROLE_GM));
    EXPECT_TRUE(data.HasPermission(ROLE_MOD));
    EXPECT_TRUE(data.HasPermission(ROLE_PLAYER));
    EXPECT_TRUE(data.HasPermission(PERM_PLAYER_1));
    EXPECT_TRUE(data.HasPermission(PERM_PLAYER_2));
    EXPECT_TRUE(data.HasPermission(PERM_MOD_1));
    EXPECT_TRUE(data.HasPermission(PERM_MOD_2));
    EXPECT_TRUE(data.HasPermission(PERM_GM_1));
    EXPECT_TRUE(data.HasPermission(PERM_GM_2));
    EXPECT_TRUE(data.HasPermission(PERM_ADMIN_1));
    EXPECT_TRUE(data.HasPermission(PERM_ADMIN_2));
    // 12 total: 4 roles + 8 perms
    EXPECT_EQ(data.GetPermissions().size(), 12u);
}

TEST_F(RBACFullRoleHierarchyTest, GrantAdmin_DenyModRole_ModAndPlayerDenied)
{
    rbac::RBACData data(1, "Admin", TEST_REALM_ID, 0);
    data.GrantPermission(ROLE_ADMIN);
    data.DenyPermission(ROLE_MOD);
    data.RecalculatePermissions();

    // Admin + GM perms remain
    EXPECT_TRUE(data.HasPermission(ROLE_ADMIN));
    EXPECT_TRUE(data.HasPermission(ROLE_GM));
    EXPECT_TRUE(data.HasPermission(PERM_GM_1));
    EXPECT_TRUE(data.HasPermission(PERM_GM_2));
    EXPECT_TRUE(data.HasPermission(PERM_ADMIN_1));
    EXPECT_TRUE(data.HasPermission(PERM_ADMIN_2));

    // Mod role and its full chain denied (Mod + Player perms)
    EXPECT_FALSE(data.HasPermission(ROLE_MOD));
    EXPECT_FALSE(data.HasPermission(ROLE_PLAYER));
    EXPECT_FALSE(data.HasPermission(PERM_MOD_1));
    EXPECT_FALSE(data.HasPermission(PERM_MOD_2));
    EXPECT_FALSE(data.HasPermission(PERM_PLAYER_1));
    EXPECT_FALSE(data.HasPermission(PERM_PLAYER_2));
}

TEST_F(RBACFullRoleHierarchyTest, GrantAdmin_DenyOneCommandPerm)
{
    rbac::RBACData data(1, "Admin", TEST_REALM_ID, 0);
    data.GrantPermission(ROLE_ADMIN);
    data.DenyPermission(PERM_GM_1);
    data.RecalculatePermissions();

    // Only PERM_GM_1 is denied
    EXPECT_FALSE(data.HasPermission(PERM_GM_1));

    // Everything else still works
    EXPECT_TRUE(data.HasPermission(ROLE_ADMIN));
    EXPECT_TRUE(data.HasPermission(ROLE_GM));
    EXPECT_TRUE(data.HasPermission(ROLE_MOD));
    EXPECT_TRUE(data.HasPermission(ROLE_PLAYER));
    EXPECT_TRUE(data.HasPermission(PERM_GM_2));
    EXPECT_TRUE(data.HasPermission(PERM_ADMIN_1));
    EXPECT_TRUE(data.HasPermission(PERM_ADMIN_2));
    EXPECT_TRUE(data.HasPermission(PERM_MOD_1));
    EXPECT_TRUE(data.HasPermission(PERM_PLAYER_1));
    // 11 total: 12 - 1 denied
    EXPECT_EQ(data.GetPermissions().size(), 11u);
}

// ---------------------------------------------------------------------------
// Suite 11: RBACPermissionDefaultConstructorTest
// ---------------------------------------------------------------------------
class RBACPermissionDefaultConstructorTest : public ::testing::Test
{
};

TEST_F(RBACPermissionDefaultConstructorTest, DefaultConstructor_ZeroIdEmptyName)
{
    rbac::RBACPermission perm;
    EXPECT_EQ(perm.GetId(), 0u);
    EXPECT_EQ(perm.GetName(), "");
    EXPECT_TRUE(perm.GetLinkedPermissions().empty());
}

TEST_F(RBACPermissionDefaultConstructorTest, ConstructorWithIdOnly)
{
    rbac::RBACPermission perm(42);
    EXPECT_EQ(perm.GetId(), 42u);
    EXPECT_EQ(perm.GetName(), "");
    EXPECT_TRUE(perm.GetLinkedPermissions().empty());
}

// ---------------------------------------------------------------------------
// Suite 12: RBACAccountMgrPermissionLookupTest
// ---------------------------------------------------------------------------
class RBACAccountMgrPermissionLookupTest : public ::testing::Test
{
protected:
    void SetUp() override
    {
        sAccountMgr->AddPermissionForTest(TEST_PERM_1, "Permission One");
        sAccountMgr->AddPermissionForTest(TEST_PERM_2, "Permission Two");
    }

    void TearDown() override
    {
        sAccountMgr->ClearPermissionsForTest();
    }
};

TEST_F(RBACAccountMgrPermissionLookupTest, GetRBACPermission_ValidId_ReturnsPermission)
{
    rbac::RBACPermission const* perm = sAccountMgr->GetRBACPermission(TEST_PERM_1);
    ASSERT_NE(perm, nullptr);
    EXPECT_EQ(perm->GetId(), TEST_PERM_1);
    EXPECT_EQ(perm->GetName(), "Permission One");
}

TEST_F(RBACAccountMgrPermissionLookupTest, GetRBACPermission_InvalidId_ReturnsNull)
{
    rbac::RBACPermission const* perm = sAccountMgr->GetRBACPermission(TEST_PERM_INVALID);
    EXPECT_EQ(perm, nullptr);
}

TEST_F(RBACAccountMgrPermissionLookupTest, GetRBACPermissionList_ContainsRegistered)
{
    rbac::RBACPermissionsContainer const& list = sAccountMgr->GetRBACPermissionList();
    EXPECT_TRUE(list.find(TEST_PERM_1) != list.end());
    EXPECT_TRUE(list.find(TEST_PERM_2) != list.end());
    EXPECT_TRUE(list.find(TEST_PERM_INVALID) == list.end());
}

TEST_F(RBACAccountMgrPermissionLookupTest, GetRBACPermissionList_SizeMatchesRegistered)
{
    rbac::RBACPermissionsContainer const& list = sAccountMgr->GetRBACPermissionList();
    EXPECT_EQ(list.size(), 2u);
}

// ---------------------------------------------------------------------------
// Suite 13: RBACAccountMgrTestHelperEdgeCasesTest
// ---------------------------------------------------------------------------
class RBACAccountMgrTestHelperEdgeCasesTest : public ::testing::Test
{
protected:
    void TearDown() override
    {
        sAccountMgr->ClearPermissionsForTest();
    }
};

TEST_F(RBACAccountMgrTestHelperEdgeCasesTest, AddPermissionForTest_DuplicateIsNoOp)
{
    sAccountMgr->AddPermissionForTest(TEST_PERM_1, "Original Name");
    sAccountMgr->AddPermissionForTest(TEST_PERM_1, "Different Name");

    rbac::RBACPermission const* perm = sAccountMgr->GetRBACPermission(TEST_PERM_1);
    ASSERT_NE(perm, nullptr);
    EXPECT_EQ(perm->GetName(), "Original Name");
}

TEST_F(RBACAccountMgrTestHelperEdgeCasesTest, AddLinkedPermission_UnregisteredParent_NoOp)
{
    // Link to non-existent parent: should silently do nothing
    sAccountMgr->AddLinkedPermissionForTest(TEST_PERM_INVALID, TEST_PERM_1);
    EXPECT_EQ(sAccountMgr->GetRBACPermission(TEST_PERM_INVALID), nullptr);
}

TEST_F(RBACAccountMgrTestHelperEdgeCasesTest, ClearPermissions_RemovesEverything)
{
    sAccountMgr->AddPermissionForTest(TEST_PERM_1, "One");
    sAccountMgr->AddPermissionForTest(TEST_PERM_2, "Two");
    sAccountMgr->AddDefaultPermissionForTest(0, TEST_PERM_1);

    sAccountMgr->ClearPermissionsForTest();

    EXPECT_EQ(sAccountMgr->GetRBACPermission(TEST_PERM_1), nullptr);
    EXPECT_EQ(sAccountMgr->GetRBACPermission(TEST_PERM_2), nullptr);
    EXPECT_TRUE(sAccountMgr->GetRBACPermissionList().empty());
    EXPECT_TRUE(sAccountMgr->GetRBACDefaultPermissions(0).empty());
}

// ---------------------------------------------------------------------------
// Suite 14: RBACExpandPermissionsDanglingLinkTest
// ---------------------------------------------------------------------------
class RBACExpandPermissionsDanglingLinkTest : public ::testing::Test
{
protected:
    static constexpr uint32 PERM_VALID = 10;
    static constexpr uint32 PERM_DANGLING = 9999;
    static constexpr uint32 ROLE_WITH_DANGLING = 100;

    void SetUp() override
    {
        sAccountMgr->AddPermissionForTest(PERM_VALID, "Valid");
        sAccountMgr->AddPermissionForTest(ROLE_WITH_DANGLING, "Role With Dangling");

        // Role links to valid perm AND an unregistered perm ID
        sAccountMgr->AddLinkedPermissionForTest(ROLE_WITH_DANGLING, PERM_VALID);
        sAccountMgr->AddLinkedPermissionForTest(ROLE_WITH_DANGLING, PERM_DANGLING);

        rbacData = std::make_unique<rbac::RBACData>(TEST_ACCOUNT_ID, TEST_ACCOUNT_NAME, TEST_REALM_ID, TEST_SEC_LEVEL);
    }

    void TearDown() override
    {
        sAccountMgr->ClearPermissionsForTest();
    }

    std::unique_ptr<rbac::RBACData> rbacData;
};

TEST_F(RBACExpandPermissionsDanglingLinkTest, DanglingLink_SkippedGracefully)
{
    rbacData->GrantPermission(ROLE_WITH_DANGLING);
    rbacData->RecalculatePermissions();

    // Valid perm expanded, dangling silently skipped
    EXPECT_TRUE(rbacData->HasPermission(ROLE_WITH_DANGLING));
    EXPECT_TRUE(rbacData->HasPermission(PERM_VALID));
    EXPECT_FALSE(rbacData->HasPermission(PERM_DANGLING));
    // Only 2: the role + the valid perm (dangling not included)
    EXPECT_EQ(rbacData->GetPermissions().size(), 2u);
}

TEST_F(RBACExpandPermissionsDanglingLinkTest, DenyDanglingLink_SkippedGracefully)
{
    rbacData->GrantPermission(PERM_VALID);
    // PERM_DANGLING can't be denied since it's not registered
    rbac::RBACCommandResult result = rbacData->DenyPermission(PERM_DANGLING);
    EXPECT_EQ(result, rbac::RBAC_ID_DOES_NOT_EXISTS);

    rbacData->RecalculatePermissions();
    EXPECT_TRUE(rbacData->HasPermission(PERM_VALID));
}

// ---------------------------------------------------------------------------
// Suite 15: RBACLoadFromDBCallbackSimulationTest
// ---------------------------------------------------------------------------
class RBACLoadFromDBCallbackSimulationTest : public ::testing::Test
{
protected:
    static constexpr uint32 PERM_A = 10;
    static constexpr uint32 PERM_B = 11;
    static constexpr uint32 ROLE_PLAYER = 100;

    static constexpr uint8 SEC_PLAYER = 0;

    void SetUp() override
    {
        sAccountMgr->AddPermissionForTest(PERM_A, "A");
        sAccountMgr->AddPermissionForTest(PERM_B, "B");
        sAccountMgr->AddPermissionForTest(ROLE_PLAYER, "Player Role");

        sAccountMgr->AddLinkedPermissionForTest(ROLE_PLAYER, PERM_A);
        sAccountMgr->AddLinkedPermissionForTest(ROLE_PLAYER, PERM_B);

        sAccountMgr->AddDefaultPermissionForTest(SEC_PLAYER, ROLE_PLAYER);
    }

    void TearDown() override
    {
        sAccountMgr->ClearPermissionsForTest();
    }
};

TEST_F(RBACLoadFromDBCallbackSimulationTest, NullResult_AppliesDefaultsAndRecalculates)
{
    rbac::RBACData data(1, "Player", TEST_REALM_ID, SEC_PLAYER);

    // Simulate LoadFromDBCallback with no DB rows (nullptr result)
    data.LoadFromDBCallback(nullptr);

    // Default permission (ROLE_PLAYER) should be granted and expanded
    EXPECT_TRUE(data.HasPermission(ROLE_PLAYER));
    EXPECT_TRUE(data.HasPermission(PERM_A));
    EXPECT_TRUE(data.HasPermission(PERM_B));
    EXPECT_EQ(data.GetPermissions().size(), 3u);
}

TEST_F(RBACLoadFromDBCallbackSimulationTest, NullResult_NoDefaultsForHighSecLevel)
{
    // Sec level 3 has no defaults configured
    rbac::RBACData data(1, "Admin", TEST_REALM_ID, 3);
    data.LoadFromDBCallback(nullptr);

    EXPECT_TRUE(data.GetPermissions().empty());
}

// ---------------------------------------------------------------------------
// Suite 16: RBACDoubleRevokeTest
// ---------------------------------------------------------------------------
class RBACDoubleRevokeTest : public ::testing::Test
{
protected:
    void SetUp() override
    {
        sAccountMgr->AddPermissionForTest(TEST_PERM_1, "Permission 1");
        rbacData = std::make_unique<rbac::RBACData>(TEST_ACCOUNT_ID, TEST_ACCOUNT_NAME, TEST_REALM_ID, TEST_SEC_LEVEL);
    }

    void TearDown() override
    {
        sAccountMgr->ClearPermissionsForTest();
    }

    std::unique_ptr<rbac::RBACData> rbacData;
};

TEST_F(RBACDoubleRevokeTest, RevokeGrantedTwice_SecondFails)
{
    rbacData->GrantPermission(TEST_PERM_1);
    EXPECT_EQ(rbacData->RevokePermission(TEST_PERM_1), rbac::RBAC_OK);
    EXPECT_EQ(rbacData->RevokePermission(TEST_PERM_1), rbac::RBAC_CANT_REVOKE_NOT_IN_LIST);
}

TEST_F(RBACDoubleRevokeTest, RevokeDeniedTwice_SecondFails)
{
    rbacData->DenyPermission(TEST_PERM_1);
    EXPECT_EQ(rbacData->RevokePermission(TEST_PERM_1), rbac::RBAC_OK);
    EXPECT_EQ(rbacData->RevokePermission(TEST_PERM_1), rbac::RBAC_CANT_REVOKE_NOT_IN_LIST);
}

// ---------------------------------------------------------------------------
// Suite 17: RBACMultipleInstancesIndependenceTest
// ---------------------------------------------------------------------------
class RBACMultipleInstancesIndependenceTest : public ::testing::Test
{
protected:
    void SetUp() override
    {
        sAccountMgr->AddPermissionForTest(TEST_PERM_1, "Permission 1");
        sAccountMgr->AddPermissionForTest(TEST_PERM_2, "Permission 2");
        sAccountMgr->AddPermissionForTest(TEST_PERM_3, "Permission 3");
    }

    void TearDown() override
    {
        sAccountMgr->ClearPermissionsForTest();
    }
};

TEST_F(RBACMultipleInstancesIndependenceTest, TwoInstances_NoCrossContamination)
{
    rbac::RBACData data1(1, "Account1", TEST_REALM_ID, 0);
    rbac::RBACData data2(2, "Account2", TEST_REALM_ID, 0);

    data1.GrantPermission(TEST_PERM_1);
    data2.GrantPermission(TEST_PERM_2);

    data1.RecalculatePermissions();
    data2.RecalculatePermissions();

    EXPECT_TRUE(data1.HasPermission(TEST_PERM_1));
    EXPECT_FALSE(data1.HasPermission(TEST_PERM_2));

    EXPECT_FALSE(data2.HasPermission(TEST_PERM_1));
    EXPECT_TRUE(data2.HasPermission(TEST_PERM_2));
}

TEST_F(RBACMultipleInstancesIndependenceTest, ModifyingOne_DoesNotAffectOther)
{
    rbac::RBACData data1(1, "Account1", TEST_REALM_ID, 0);
    rbac::RBACData data2(2, "Account2", TEST_REALM_ID, 0);

    data1.GrantPermission(TEST_PERM_1);
    data1.GrantPermission(TEST_PERM_2);
    data2.GrantPermission(TEST_PERM_1);

    data1.RecalculatePermissions();
    data2.RecalculatePermissions();

    // Revoke from data1, data2 unaffected
    data1.RevokePermission(TEST_PERM_1);
    data1.RecalculatePermissions();

    EXPECT_FALSE(data1.HasPermission(TEST_PERM_1));
    EXPECT_TRUE(data2.HasPermission(TEST_PERM_1));
}

// ---------------------------------------------------------------------------
// Suite 18: RBACSetSecurityLevelForTestBehaviorTest
// ---------------------------------------------------------------------------
class RBACSetSecurityLevelForTestBehaviorTest : public ::testing::Test
{
protected:
    void SetUp() override
    {
        sAccountMgr->AddPermissionForTest(TEST_PERM_1, "Permission 1");
    }

    void TearDown() override
    {
        sAccountMgr->ClearPermissionsForTest();
    }
};

TEST_F(RBACSetSecurityLevelForTestBehaviorTest, DoesNotRecalculate)
{
    rbac::RBACData data(1, "Test", TEST_REALM_ID, 0);
    data.GrantPermission(TEST_PERM_1);
    data.RecalculatePermissions();
    EXPECT_TRUE(data.HasPermission(TEST_PERM_1));

    // Changing sec level via test helper should NOT clear/recalculate perms
    data.SetSecurityLevelForTest(3);
    EXPECT_EQ(data.GetSecurityLevel(), 3);
    EXPECT_TRUE(data.HasPermission(TEST_PERM_1));
}

TEST_F(RBACSetSecurityLevelForTestBehaviorTest, UpdatesLevelOnly)
{
    rbac::RBACData data(1, "Test", TEST_REALM_ID, 0);
    EXPECT_EQ(data.GetSecurityLevel(), 0);

    data.SetSecurityLevelForTest(1);
    EXPECT_EQ(data.GetSecurityLevel(), 1);

    data.SetSecurityLevelForTest(255);
    EXPECT_EQ(data.GetSecurityLevel(), 255);
}

// ---------------------------------------------------------------------------
// Suite 19: RBACDataAccessorsTest
// ---------------------------------------------------------------------------
class RBACDataAccessorsTest : public ::testing::Test
{
protected:
    void SetUp() override
    {
        sAccountMgr->AddPermissionForTest(TEST_PERM_1, "Permission 1");
    }

    void TearDown() override
    {
        sAccountMgr->ClearPermissionsForTest();
    }
};

TEST_F(RBACDataAccessorsTest, GetName_ReturnsAccountName)
{
    rbac::RBACData data(42, "MyAccount", TEST_REALM_ID, 0);
    EXPECT_EQ(data.GetName(), "MyAccount");
}

TEST_F(RBACDataAccessorsTest, GetName_EmptyString)
{
    rbac::RBACData data(1, "", TEST_REALM_ID, 0);
    EXPECT_EQ(data.GetName(), "");
}

TEST_F(RBACDataAccessorsTest, GetId_ReturnsAccountId)
{
    rbac::RBACData data(42, "Test", TEST_REALM_ID, 0);
    EXPECT_EQ(data.GetId(), 42u);
}

TEST_F(RBACDataAccessorsTest, GrantedDeniedGlobal_AllConsistent)
{
    rbac::RBACData data(1, "Test", TEST_REALM_ID, 0);

    data.GrantPermission(TEST_PERM_1);
    EXPECT_EQ(data.GetGrantedPermissions().size(), 1u);
    EXPECT_TRUE(data.GetDeniedPermissions().empty());

    // Before recalculate, global perms are still empty
    EXPECT_TRUE(data.GetPermissions().empty());

    data.RecalculatePermissions();
    // After recalculate, global perms reflect granted
    EXPECT_EQ(data.GetPermissions().size(), 1u);
    EXPECT_TRUE(data.HasPermission(TEST_PERM_1));
}

}  // namespace

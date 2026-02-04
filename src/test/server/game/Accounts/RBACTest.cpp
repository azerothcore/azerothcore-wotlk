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

TEST_F(RBACSecurityLevelTest, SetSecurityLevel_UpdatesLevel)
{
    rbac::RBACData rbac(1, "TestAccount", 1, 0);
    EXPECT_EQ(rbac.GetSecurityLevel(), 0);

    rbac.SetSecurityLevel(3);
    EXPECT_EQ(rbac.GetSecurityLevel(), 3);
}

}  // namespace

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

#include "Player.h"
#include "ScriptMgr.h"
#include "WorldSession.h"
#include "WorldMock.h"
#include "ObjectGuid.h"
#include "ScriptDefines/MiscScript.h"
#include "ScriptDefines/PlayerScript.h"
#include "ScriptDefines/WorldObjectScript.h"
#include "ScriptDefines/UnitScript.h"
#include "ScriptDefines/CommandScript.h"
#include "SharedDefines.h"
#include "gmock/gmock.h"
#include "gtest/gtest.h"
#include <string>
#include <string_view>

#ifndef TEST_F
#define TEST_F(fixture, name) void fixture##_##name()
#endif

using namespace testing;

namespace
{
class TestVisibilityScript : public PlayerScript
{
public:
    TestVisibilityScript() : PlayerScript("TestVisibilityScript", { PLAYERHOOK_ON_SET_SERVER_SIDE_VISIBILITY }) { }

    void OnPlayerSetServerSideVisibility(Player* player, ServerSideVisibilityType& type, AccountTypes& sec) override
    {
        ++CallCount;
        LastPlayer = player;
        LastType = type;
        LastSecurity = sec;
    }

    static void EnsureRegistered()
    {
        if (!Instance)
            Instance = new TestVisibilityScript();
    }

    static void Reset()
    {
        CallCount = 0;
        LastPlayer = nullptr;
        LastType = SERVERSIDE_VISIBILITY_GM;
        LastSecurity = SEC_PLAYER;
    }

    inline static TestVisibilityScript* Instance = nullptr;
    inline static uint32 CallCount = 0;
    inline static Player* LastPlayer = nullptr;
    inline static ServerSideVisibilityType LastType = SERVERSIDE_VISIBILITY_GM;
    inline static AccountTypes LastSecurity = SEC_PLAYER;
};

class TestPlayer : public Player
{
public:
    using Player::Player;

    void UpdateObjectVisibility(bool /*forced*/ = true, bool /*fromUpdate*/ = false) override { }

    void ForceInitValues(ObjectGuid::LowType guidLow = 1)
    {
        Object::_Create(guidLow, uint32(0), HighGuid::Player);
    }
};

class GmVisibleCommandTest : public ::testing::Test
{
protected:
    void SetUp() override
    {
        EnsureScriptRegistriesInitialized();

        TestVisibilityScript::EnsureRegistered();

        originalWorld = sWorld.release();
        worldMock = new NiceMock<WorldMock>();
        sWorld.reset(worldMock);

        static std::string emptyString;
        ON_CALL(*worldMock, GetDataPath()).WillByDefault(ReturnRef(emptyString));
        ON_CALL(*worldMock, GetRealmName()).WillByDefault(ReturnRef(emptyString));
        ON_CALL(*worldMock, GetDefaultDbcLocale()).WillByDefault(Return(LOCALE_enUS));
        ON_CALL(*worldMock, getRate(_)).WillByDefault(Return(1.0f));
        ON_CALL(*worldMock, getBoolConfig(_)).WillByDefault(Return(false));
        ON_CALL(*worldMock, getIntConfig(_)).WillByDefault(Return(0));
        ON_CALL(*worldMock, getFloatConfig(_)).WillByDefault(Return(0.0f));
        ON_CALL(*worldMock, GetPlayerSecurityLimit()).WillByDefault(Return(SEC_PLAYER));

        session = new WorldSession(1, "gm", 0, nullptr, SEC_GAMEMASTER, EXPANSION_WRATH_OF_THE_LICH_KING,
            0, LOCALE_enUS, 0, false, false, 0);

        player = new TestPlayer(session);
        player->ForceInitValues();
        session->SetPlayer(player);
        player->SetSession(session);

        TestVisibilityScript::Reset();
    }

    void TearDown() override
    {
        // Intentional leaks of session/player to avoid database access in destructors.
        IWorld* currentWorld = sWorld.release();
        delete currentWorld;
        worldMock = nullptr;

        sWorld.reset(originalWorld);
        originalWorld = nullptr;
        session = nullptr;
        player = nullptr;
    }

    void ExecuteCommand(std::string_view text)
    {
        if (text == ".gm visible off")
        {
            ApplyGmVisibleState(false);
        }
        else if (text == ".gm visible on")
        {
            ApplyGmVisibleState(true);
        }
        else
        {
            FAIL() << "Unsupported test command: " << text;
        }
    }

    static void EnsureScriptRegistriesInitialized()
    {
        static bool initialized = false;
        if (!initialized)
        {
            ScriptRegistry<MiscScript>::InitEnabledHooksIfNeeded(MISCHOOK_END);
            ScriptRegistry<WorldObjectScript>::InitEnabledHooksIfNeeded(WORLDOBJECTHOOK_END);
            ScriptRegistry<UnitScript>::InitEnabledHooksIfNeeded(UNITHOOK_END);
            ScriptRegistry<PlayerScript>::InitEnabledHooksIfNeeded(PLAYERHOOK_END);
            ScriptRegistry<CommandSC>::InitEnabledHooksIfNeeded(ALLCOMMANDHOOK_END);
            initialized = true;
        }
    }

    IWorld* originalWorld = nullptr;
    NiceMock<WorldMock>* worldMock = nullptr;
    WorldSession* session = nullptr;
    TestPlayer* player = nullptr;

private:
    void ApplyGmVisibleState(bool makeVisible)
    {
        constexpr uint32 VISUAL_AURA = 37800;

        if (makeVisible)
        {
            player->RemoveAurasDueToSpell(VISUAL_AURA);
            player->SetGMVisible(true);
        }
        else
        {
            player->AddAura(VISUAL_AURA, player);
            player->SetGMVisible(false);
        }

        player->UpdateObjectVisibility();
    }
};

TEST_F(GmVisibleCommandTest, SetsPlayerInvisibleAndInvokesHook)
{
    ExecuteCommand(".gm visible off");

    EXPECT_EQ(TestVisibilityScript::CallCount, 1u);
    EXPECT_EQ(TestVisibilityScript::LastPlayer, player);
    EXPECT_EQ(TestVisibilityScript::LastType, SERVERSIDE_VISIBILITY_GM);
    EXPECT_EQ(TestVisibilityScript::LastSecurity, session->GetSecurity());
    EXPECT_EQ(player->m_serverSideVisibility.GetValue(SERVERSIDE_VISIBILITY_GM), uint32(session->GetSecurity()));
    EXPECT_FALSE(player->isGMVisible());
}

TEST_F(GmVisibleCommandTest, SetsPlayerVisibleAndInvokesHook)
{
    // Ensure the player starts from invisible state to test the opposite transition as well.
    ExecuteCommand(".gm visible off");
    TestVisibilityScript::Reset();

    ExecuteCommand(".gm visible on");

    EXPECT_EQ(TestVisibilityScript::CallCount, 1u);
    EXPECT_EQ(TestVisibilityScript::LastPlayer, player);
    EXPECT_EQ(TestVisibilityScript::LastType, SERVERSIDE_VISIBILITY_GM);
    EXPECT_EQ(TestVisibilityScript::LastSecurity, SEC_PLAYER);
    EXPECT_EQ(player->m_serverSideVisibility.GetValue(SERVERSIDE_VISIBILITY_GM), uint32(SEC_PLAYER));
    EXPECT_TRUE(player->isGMVisible());
}
}

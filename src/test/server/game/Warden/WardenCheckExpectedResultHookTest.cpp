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

#include "ScriptDefines/SessionScript.h"
#include "ScriptMgr.h"
#include "SharedDefines.h"
#include "Warden.h"
#include "WardenCheckMgr.h"
#include "WorldMock.h"
#include "WorldSession.h"
#include "gmock/gmock.h"
#include "gtest/gtest.h"
#include <string>
#include <vector>

using namespace testing;

namespace
{
class TestWardenSessionScript : public SessionScript
{
public:
    TestWardenSessionScript()
        : SessionScript("TestWardenSessionScript", { SESSIONHOOK_ON_WARDEN_CHECK_EXPECTED_RESULT }) { }

    bool OnWardenCheckExpectedResult(WorldSession* session, WardenCheck const& check,
        std::vector<uint8>& expected) override
    {
        ++CallCount;

        if (session->GetSessionDbLocaleIndex() != AnswerLocale || check.CheckId != AnswerCheckId)
            return false;

        expected = Answer;
        return true;
    }

    static void EnsureRegistered()
    {
        if (!Instance)
            Instance = new TestWardenSessionScript();
    }

    static void Reset()
    {
        CallCount = 0;
        AnswerLocale = LOCALE_ruRU;
        AnswerCheckId = 47;
        Answer = { 0x00, 0x00, 0xFF, 0x24, 0x85 };
    }

    inline static TestWardenSessionScript* Instance = nullptr;
    inline static uint32 CallCount = 0;
    inline static LocaleConstant AnswerLocale = LOCALE_ruRU;
    inline static uint16 AnswerCheckId = 47;
    inline static std::vector<uint8> Answer;
};

class WardenCheckExpectedResultHookTest : public ::testing::Test
{
protected:
    void SetUp() override
    {
        TestWardenSessionScript::EnsureRegistered();

        originalWorld = sWorld.release();
        worldMock = new NiceMock<WorldMock>();
        sWorld.reset(worldMock);

        static std::string emptyString;
        ON_CALL(*worldMock, GetDataPath()).WillByDefault(ReturnRef(emptyString));
        ON_CALL(*worldMock, GetRealmName()).WillByDefault(ReturnRef(emptyString));
        ON_CALL(*worldMock, GetDefaultDbcLocale()).WillByDefault(Return(LOCALE_enUS));
        ON_CALL(*worldMock, GetAvailableDbcLocale(_)).WillByDefault(Return(LOCALE_enUS));
        ON_CALL(*worldMock, getRate(_)).WillByDefault(Return(1.0f));
        ON_CALL(*worldMock, getBoolConfig(_)).WillByDefault(Return(false));
        ON_CALL(*worldMock, getIntConfig(_)).WillByDefault(Return(0));
        ON_CALL(*worldMock, getFloatConfig(_)).WillByDefault(Return(0.0f));
        ON_CALL(*worldMock, GetPlayerSecurityLimit()).WillByDefault(Return(SEC_PLAYER));

        ruRuSession = new WorldSession(1, "ruRU", 0, nullptr, SEC_PLAYER, EXPANSION_WRATH_OF_THE_LICH_KING,
            0, LOCALE_ruRU, 0, false, false, 0);
        enUsSession = new WorldSession(2, "enUS", 0, nullptr, SEC_PLAYER, EXPANSION_WRATH_OF_THE_LICH_KING,
            0, LOCALE_enUS, 0, false, false, 0);

        TestWardenSessionScript::Reset();
    }

    void TearDown() override
    {
        // Intentional leaks of the sessions to avoid database access in destructors.
        IWorld* currentWorld = sWorld.release();
        delete currentWorld;
        worldMock = nullptr;

        sWorld.reset(originalWorld);
        originalWorld = nullptr;
        ruRuSession = nullptr;
        enUsSession = nullptr;
    }

    static WardenCheck MakeMemCheck(uint16 id)
    {
        WardenCheck check{};
        check.Type = MEM_CHECK;
        check.CheckId = id;
        check.Address = 0x52ABDC;
        check.Length = 5;
        return check;
    }

    IWorld* originalWorld = nullptr;
    NiceMock<WorldMock>* worldMock = nullptr;
    WorldSession* ruRuSession = nullptr;
    WorldSession* enUsSession = nullptr;
};

// cppcheck-suppress syntaxError
TEST_F(WardenCheckExpectedResultHookTest, ScriptAnswerFillsExpectedBytes)
{
    WardenCheck const check = MakeMemCheck(47);
    std::vector<uint8> expected;

    EXPECT_TRUE(sScriptMgr->OnWardenCheckExpectedResult(ruRuSession, check, expected));
    EXPECT_EQ(expected, TestWardenSessionScript::Answer);
    EXPECT_EQ(TestWardenSessionScript::CallCount, 1u);
}

TEST_F(WardenCheckExpectedResultHookTest, OtherLocaleFallsThrough)
{
    WardenCheck const check = MakeMemCheck(47);
    std::vector<uint8> expected;

    EXPECT_FALSE(sScriptMgr->OnWardenCheckExpectedResult(enUsSession, check, expected));
    EXPECT_TRUE(expected.empty());
    EXPECT_EQ(TestWardenSessionScript::CallCount, 1u);
}

TEST_F(WardenCheckExpectedResultHookTest, OtherCheckFallsThrough)
{
    WardenCheck const check = MakeMemCheck(48);
    std::vector<uint8> expected;

    EXPECT_FALSE(sScriptMgr->OnWardenCheckExpectedResult(ruRuSession, check, expected));
    EXPECT_TRUE(expected.empty());
    EXPECT_EQ(TestWardenSessionScript::CallCount, 1u);
}
}

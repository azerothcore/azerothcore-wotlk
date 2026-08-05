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

#include "Battleground.h"
#include "BattlegroundUtils.h"
#include "DBCStructure.h"
#include "ScriptMgr.h"
#include "ScriptDefines/AllBattlegroundScript.h"
#include "WorldMock.h"
#include "gtest/gtest.h"

/**
 * Tests the resolution order of the low-levels MinPlayersPerTeam override:
 * per-BG config key > global config key > battleground_template value,
 * and the guards that keep it away from arenas, templates (member function)
 * and max-level brackets.
 */
class LowLevelsMinPlayersOverrideTest : public ::testing::Test
{
protected:
    static constexpr uint32 TemplateMinPlayers = 5;

    void SetUp() override
    {
        // Battleground's destructor fires OnBattlegroundDestroy; the hook
        // registry must be sized before any hook is invoked.
        ScriptRegistry<BGScript>::InitEnabledHooksIfNeeded(ALLBATTLEGROUNDHOOK_END);

        previousWorld_ = std::move(sWorld);
        worldMock_ = new ::testing::NiceMock<WorldMock>();
        ON_CALL(*worldMock_, getIntConfig(::testing::_))
            .WillByDefault(::testing::Return(0));
        ON_CALL(*worldMock_, getIntConfig(CONFIG_MAX_PLAYER_LEVEL))
            .WillByDefault(::testing::Return(80));
        sWorld.reset(worldMock_);
    }

    void TearDown() override
    {
        sWorld = std::move(previousWorld_);
    }

    void SetIntConfig(ServerConfigs index, uint32 value)
    {
        ON_CALL(*worldMock_, getIntConfig(index))
            .WillByDefault(::testing::Return(value));
    }

    static PvPDifficultyEntry MakeBracket(uint32 minLevel, uint32 maxLevel)
    {
        return PvPDifficultyEntry(/*mapId*/ 0, /*bracketId*/ 0, minLevel, maxLevel, /*difficulty*/ 0);
    }

    // A template BG as loaded from battleground_template
    static void SetupTemplate(Battleground& bg, BattlegroundTypeId bgTypeId)
    {
        bg.SetBgTypeID(bgTypeId);
        bg.SetMinPlayersPerTeam(TemplateMinPlayers);
    }

    // A real BG instance bound to a level bracket
    static void SetupRealBg(Battleground& bg, BattlegroundTypeId bgTypeId, PvPDifficultyEntry const& bracket)
    {
        SetupTemplate(bg, bgTypeId);
        bg.SetBracket(&bracket);
    }

    ::testing::NiceMock<WorldMock>* worldMock_ = nullptr;
    std::unique_ptr<IWorld> previousWorld_;
};

TEST_F(LowLevelsMinPlayersOverrideTest, PerBgKeyWinsOverGlobalAndTemplate)
{
    SetIntConfig(CONFIG_BATTLEGROUND_OVERRIDE_LOWLEVELS_MINPLAYERS, 4);
    SetIntConfig(CONFIG_BATTLEGROUND_OVERRIDE_LOWLEVELS_MINPLAYERS_WS, 2);

    Battleground bg;
    PvPDifficultyEntry bracket = MakeBracket(10, 19);
    SetupRealBg(bg, BATTLEGROUND_WS, bracket);

    EXPECT_EQ(bg.GetMinPlayersPerTeam(), 2u);
    EXPECT_EQ(GetMinPlayersPerTeam(&bg, &bracket), 2u);
}

TEST_F(LowLevelsMinPlayersOverrideTest, GlobalKeyAppliesWhenPerBgUnset)
{
    SetIntConfig(CONFIG_BATTLEGROUND_OVERRIDE_LOWLEVELS_MINPLAYERS, 4);

    Battleground bg;
    PvPDifficultyEntry bracket = MakeBracket(10, 19);
    SetupRealBg(bg, BATTLEGROUND_WS, bracket);

    EXPECT_EQ(bg.GetMinPlayersPerTeam(), 4u);
    EXPECT_EQ(GetMinPlayersPerTeam(&bg, &bracket), 4u);
}

TEST_F(LowLevelsMinPlayersOverrideTest, TemplateValueAppliesWhenNoOverrideSet)
{
    Battleground bg;
    PvPDifficultyEntry bracket = MakeBracket(10, 19);
    SetupRealBg(bg, BATTLEGROUND_WS, bracket);

    EXPECT_EQ(bg.GetMinPlayersPerTeam(), TemplateMinPlayers);
    EXPECT_EQ(GetMinPlayersPerTeam(&bg, &bracket), TemplateMinPlayers);
}

TEST_F(LowLevelsMinPlayersOverrideTest, MaxLevelBracketIgnoresOverride)
{
    SetIntConfig(CONFIG_BATTLEGROUND_OVERRIDE_LOWLEVELS_MINPLAYERS, 4);
    SetIntConfig(CONFIG_BATTLEGROUND_OVERRIDE_LOWLEVELS_MINPLAYERS_WS, 2);

    Battleground bg;
    PvPDifficultyEntry bracket = MakeBracket(71, 80);
    SetupRealBg(bg, BATTLEGROUND_WS, bracket);

    EXPECT_EQ(bg.GetMinPlayersPerTeam(), TemplateMinPlayers);
    EXPECT_EQ(GetMinPlayersPerTeam(&bg, &bracket), TemplateMinPlayers);

    // same via the template path of the free helper
    Battleground templateBg;
    SetupTemplate(templateBg, BATTLEGROUND_WS);
    EXPECT_EQ(GetMinPlayersPerTeam(&templateBg, &bracket), TemplateMinPlayers);
}

TEST_F(LowLevelsMinPlayersOverrideTest, ArenaIgnoresOverride)
{
    SetIntConfig(CONFIG_BATTLEGROUND_OVERRIDE_LOWLEVELS_MINPLAYERS, 4);

    Battleground bg;
    PvPDifficultyEntry bracket = MakeBracket(10, 19);
    SetupRealBg(bg, BATTLEGROUND_NA, bracket);
    bg.SetArenaorBGType(true);

    EXPECT_EQ(bg.GetMinPlayersPerTeam(), TemplateMinPlayers);
    EXPECT_EQ(GetMinPlayersPerTeam(&bg, &bracket), TemplateMinPlayers);
}

TEST_F(LowLevelsMinPlayersOverrideTest, PerBgKeyDoesNotLeakToOtherBgs)
{
    SetIntConfig(CONFIG_BATTLEGROUND_OVERRIDE_LOWLEVELS_MINPLAYERS_WS, 2);

    EXPECT_EQ(GetLowLevelsMinPlayersOverride(BATTLEGROUND_WS), 2u);
    EXPECT_EQ(GetLowLevelsMinPlayersOverride(BATTLEGROUND_AB), 0u);

    Battleground bg;
    PvPDifficultyEntry bracket = MakeBracket(10, 19);
    SetupRealBg(bg, BATTLEGROUND_AB, bracket);

    EXPECT_EQ(bg.GetMinPlayersPerTeam(), TemplateMinPlayers);
}

TEST_F(LowLevelsMinPlayersOverrideTest, EachPerBgKeyResolvesIndependently)
{
    SetIntConfig(CONFIG_BATTLEGROUND_OVERRIDE_LOWLEVELS_MINPLAYERS_AV, 10);
    SetIntConfig(CONFIG_BATTLEGROUND_OVERRIDE_LOWLEVELS_MINPLAYERS_WS, 2);
    SetIntConfig(CONFIG_BATTLEGROUND_OVERRIDE_LOWLEVELS_MINPLAYERS_AB, 3);
    SetIntConfig(CONFIG_BATTLEGROUND_OVERRIDE_LOWLEVELS_MINPLAYERS_EY, 4);
    SetIntConfig(CONFIG_BATTLEGROUND_OVERRIDE_LOWLEVELS_MINPLAYERS_SA, 5);
    SetIntConfig(CONFIG_BATTLEGROUND_OVERRIDE_LOWLEVELS_MINPLAYERS_IC, 6);

    EXPECT_EQ(GetLowLevelsMinPlayersOverride(BATTLEGROUND_AV), 10u);
    EXPECT_EQ(GetLowLevelsMinPlayersOverride(BATTLEGROUND_WS), 2u);
    EXPECT_EQ(GetLowLevelsMinPlayersOverride(BATTLEGROUND_AB), 3u);
    EXPECT_EQ(GetLowLevelsMinPlayersOverride(BATTLEGROUND_EY), 4u);
    EXPECT_EQ(GetLowLevelsMinPlayersOverride(BATTLEGROUND_SA), 5u);
    EXPECT_EQ(GetLowLevelsMinPlayersOverride(BATTLEGROUND_IC), 6u);
}

TEST_F(LowLevelsMinPlayersOverrideTest, UnmappedBgTypeFallsBackToGlobal)
{
    SetIntConfig(CONFIG_BATTLEGROUND_OVERRIDE_LOWLEVELS_MINPLAYERS, 4);
    SetIntConfig(CONFIG_BATTLEGROUND_OVERRIDE_LOWLEVELS_MINPLAYERS_WS, 2);

    EXPECT_EQ(GetLowLevelsMinPlayersOverride(BATTLEGROUND_RB), 4u);
}

TEST_F(LowLevelsMinPlayersOverrideTest, FreeHelperOnTemplateUsesPerBgValue)
{
    SetIntConfig(CONFIG_BATTLEGROUND_OVERRIDE_LOWLEVELS_MINPLAYERS_WS, 2);

    Battleground templateBg;
    SetupTemplate(templateBg, BATTLEGROUND_WS);
    PvPDifficultyEntry bracket = MakeBracket(10, 19);

    // the free helper resolves via the bracket entry for templates
    EXPECT_EQ(GetMinPlayersPerTeam(&templateBg, &bracket), 2u);

    // the member function never applies overrides to templates
    EXPECT_EQ(templateBg.GetMinPlayersPerTeam(), TemplateMinPlayers);
}

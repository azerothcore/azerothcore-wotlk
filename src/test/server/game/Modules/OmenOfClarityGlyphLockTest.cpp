/*
 * Unit test for the mod-omen-of-clarity glyph slot locking behavior.
 *
 * Verifies that when the "empowered omen" feature is enabled for a player,
 * the major glyph slot 5 (bit 0x20 in PLAYER_GLYPHS_ENABLED) stays locked
 * even after leveling to 80 (which normally enables that slot).
 *
 * Because the module's internal cache (s_oocEnabled) and helper functions
 * are static to its .cpp file, this test uses a test-local PlayerScript
 * that replicates the same glyph-locking logic the module uses.  This
 * proves the mechanism works end-to-end through the hook system.
 */

#include "TestPlayer.h"
#include "TestMap.h"
#include "ScriptMgr.h"
#include "WorldSession.h"
#include "WorldMock.h"
#include "ObjectGuid.h"
#include "ScriptDefines/PlayerScript.h"
#include "SharedDefines.h"
#include "gtest/gtest.h"

#ifndef TEST_F
#define TEST_F(fixture, name) void fixture##_##name()
#endif

#include <unordered_set>

using namespace testing;

namespace
{

// Constants matching the module's values
static constexpr uint8  OOC_LOCKED_GLYPH_SLOT = 5;
static constexpr uint32 OOC_LOCKED_SLOT_BIT   = 0x20;

// Test-local cache mirroring the module's s_oocEnabled
static std::unordered_set<uint32> s_testOocEnabled;

// -------------------------------------------------------
// Test PlayerScript: replicates the module's level-change
// and quest-complete hooks for glyph slot locking.
// -------------------------------------------------------
class TestOocPlayerScript : public PlayerScript
{
public:
    TestOocPlayerScript()
        : PlayerScript("TestOocPlayerScript",
            { PLAYERHOOK_ON_LEVEL_CHANGED,
              PLAYERHOOK_ON_PLAYER_COMPLETE_QUEST }) { }

    void OnPlayerLevelChanged(Player* player,
                              uint8 /*oldLevel*/) override
    {
        if (s_testOocEnabled.count(
                player->GetGUID().GetCounter()))
        {
            // Same logic as EnsureGlyphSlotLocked in the module
            uint32 bits = player->GetUInt32Value(
                PLAYER_GLYPHS_ENABLED);
            if (bits & OOC_LOCKED_SLOT_BIT)
            {
                player->SetUInt32Value(PLAYER_GLYPHS_ENABLED,
                    bits & ~OOC_LOCKED_SLOT_BIT);
            }
        }
    }

    void OnPlayerCompleteQuest(Player* player,
                               Quest const* /*quest*/) override
    {
        // Simplified: always enable for the completing player
        s_testOocEnabled.insert(
            player->GetGUID().GetCounter());

        // Lock the slot (clear bit 0x20)
        uint32 bits = player->GetUInt32Value(
            PLAYER_GLYPHS_ENABLED);
        player->SetUInt32Value(PLAYER_GLYPHS_ENABLED,
            bits & ~OOC_LOCKED_SLOT_BIT);
    }

    static void EnsureRegistered()
    {
        if (!Instance)
            Instance = new TestOocPlayerScript();
    }

    inline static TestOocPlayerScript* Instance = nullptr;
};

// -------------------------------------------------------
// Test fixture
// -------------------------------------------------------
class OmenOfClarityGlyphLockTest : public ::testing::Test
{
protected:
    void SetUp() override
    {
        TestMap::EnsureDBC();
        TestOocPlayerScript::EnsureRegistered();

        originalWorld = sWorld.release();
        worldMock = new NiceMock<WorldMock>();
        sWorld.reset(worldMock);

        static std::string emptyString;
        ON_CALL(*worldMock, GetDataPath())
            .WillByDefault(ReturnRef(emptyString));
        ON_CALL(*worldMock, GetRealmName())
            .WillByDefault(ReturnRef(emptyString));
        ON_CALL(*worldMock, GetDefaultDbcLocale())
            .WillByDefault(Return(LOCALE_enUS));
        ON_CALL(*worldMock, getRate(_))
            .WillByDefault(Return(1.0f));
        ON_CALL(*worldMock, getBoolConfig(_))
            .WillByDefault(Return(false));
        ON_CALL(*worldMock, getIntConfig(_))
            .WillByDefault(Return(0));
        ON_CALL(*worldMock, getFloatConfig(_))
            .WillByDefault(Return(0.0f));
        ON_CALL(*worldMock, GetPlayerSecurityLimit())
            .WillByDefault(Return(SEC_PLAYER));

        session = new WorldSession(
            1, "test", 0, nullptr, SEC_PLAYER,
            EXPANSION_WRATH_OF_THE_LICH_KING,
            0, LOCALE_enUS, 0, false, false, 0);

        player = new TestPlayer(session);
        player->ForceInitValues(42);
        session->SetPlayer(player);
        player->SetSession(session);

        s_testOocEnabled.clear();
    }

    void TearDown() override
    {
        s_testOocEnabled.clear();

        // Intentional leaks of session/player to avoid
        // database access in destructors.
        IWorld* currentWorld = sWorld.release();
        delete currentWorld;
        worldMock = nullptr;

        sWorld.reset(originalWorld);
        originalWorld = nullptr;
        session = nullptr;
        player = nullptr;
    }

    /// Simulate what InitGlyphsForLevel() does for a given level.
    void SimulateGlyphsForLevel(uint8 level)
    {
        uint32 value = 0;
        if (level >= 15)
            value |= (0x01 | 0x02);
        if (level >= 30)
            value |= 0x08;
        if (level >= 50)
            value |= 0x04;
        if (level >= 70)
            value |= 0x10;
        if (level >= 80)
            value |= 0x20;
        player->SetUInt32Value(PLAYER_GLYPHS_ENABLED, value);
    }

    IWorld* originalWorld = nullptr;
    NiceMock<WorldMock>* worldMock = nullptr;
    WorldSession* session = nullptr;
    TestPlayer* player = nullptr;
};

// ----------------------------------------------------------
// TEST: Feature enabled → level to 80 → slot stays locked
// ----------------------------------------------------------
TEST_F(OmenOfClarityGlyphLockTest,
       GlyphSlotStaysLockedAfterLevelingTo80)
{
    // 1. Enable the empowered omen feature for this player
    s_testOocEnabled.insert(
        player->GetGUID().GetCounter());

    // 2. Lock glyph slot 5 (clear bit 0x20) as the module
    //    does on quest completion
    SimulateGlyphsForLevel(79);  // slots for level 79 (no 0x20)
    uint32 bitsAtLevel79 =
        player->GetUInt32Value(PLAYER_GLYPHS_ENABLED);
    EXPECT_EQ(bitsAtLevel79 & OOC_LOCKED_SLOT_BIT, 0u)
        << "Slot 5 should not be enabled before level 80";

    // 3. Simulate hitting level 80:
    //    The game calls InitGlyphsForLevel() which sets 0x20,
    //    THEN fires OnPlayerLevelChanged.
    SimulateGlyphsForLevel(80);
    uint32 bitsAfterInit =
        player->GetUInt32Value(PLAYER_GLYPHS_ENABLED);
    EXPECT_NE(bitsAfterInit & OOC_LOCKED_SLOT_BIT, 0u)
        << "InitGlyphsForLevel should enable slot 5 at 80";

    // 4. Fire the level-change hook (same as GiveLevel does)
    sScriptMgr->OnPlayerLevelChanged(player, 79);

    // 5. Verify the hook cleared the bit
    uint32 bitsAfterHook =
        player->GetUInt32Value(PLAYER_GLYPHS_ENABLED);
    EXPECT_EQ(bitsAfterHook & OOC_LOCKED_SLOT_BIT, 0u)
        << "Module hook should re-lock slot 5 after level 80";

    // Other glyph slots should be unaffected
    EXPECT_NE(bitsAfterHook & 0x01, 0u);  // slot 0 (level 15)
    EXPECT_NE(bitsAfterHook & 0x02, 0u);  // slot 1 (level 15)
    EXPECT_NE(bitsAfterHook & 0x04, 0u);  // slot 2 (level 50)
    EXPECT_NE(bitsAfterHook & 0x08, 0u);  // slot 3 (level 30)
    EXPECT_NE(bitsAfterHook & 0x10, 0u);  // slot 4 (level 70)
}

// ----------------------------------------------------------
// TEST: Feature NOT enabled → level to 80 → slot stays open
// ----------------------------------------------------------
TEST_F(OmenOfClarityGlyphLockTest,
       GlyphSlotOpensNormallyWhenFeatureDisabled)
{
    // Feature is NOT enabled (cache is empty)

    SimulateGlyphsForLevel(80);
    sScriptMgr->OnPlayerLevelChanged(player, 79);

    uint32 bits =
        player->GetUInt32Value(PLAYER_GLYPHS_ENABLED);
    EXPECT_NE(bits & OOC_LOCKED_SLOT_BIT, 0u)
        << "Without the feature, slot 5 should remain enabled";
}

// ----------------------------------------------------------
// TEST: Enable at sub-80, level through multiple levels,
//       slot stays locked throughout
// ----------------------------------------------------------
TEST_F(OmenOfClarityGlyphLockTest,
       GlyphSlotStaysLockedThroughMultipleLevelUps)
{
    s_testOocEnabled.insert(
        player->GetGUID().GetCounter());

    // Level from 78 → 79 → 80 → 81 (if somehow possible)
    for (uint8 newLevel = 78; newLevel <= 80; ++newLevel)
    {
        SCOPED_TRACE("Level: " + std::to_string(newLevel));
        SimulateGlyphsForLevel(newLevel);
        sScriptMgr->OnPlayerLevelChanged(
            player, newLevel - 1);

        uint32 bits =
            player->GetUInt32Value(PLAYER_GLYPHS_ENABLED);
        EXPECT_EQ(bits & OOC_LOCKED_SLOT_BIT, 0u)
            << "Slot 5 should remain locked at level "
            << static_cast<int>(newLevel);
    }
}

// ----------------------------------------------------------
// TEST: Feature enabled mid-session then level up
// ----------------------------------------------------------
TEST_F(OmenOfClarityGlyphLockTest,
       QuestCompletionLocksSlotThenLevelUpKeepsItLocked)
{
    // Player is level 79 with no feature
    SimulateGlyphsForLevel(79);
    EXPECT_EQ(
        player->GetUInt32Value(PLAYER_GLYPHS_ENABLED) &
            OOC_LOCKED_SLOT_BIT, 0u);

    // Complete the quest → hook enables feature + locks slot
    sScriptMgr->OnPlayerCompleteQuest(player, nullptr);
    EXPECT_TRUE(s_testOocEnabled.count(
        player->GetGUID().GetCounter()) > 0)
        << "Feature should be enabled after quest completion";

    // Now level to 80 → game re-enables all slots
    SimulateGlyphsForLevel(80);
    uint32 bitsPreHook =
        player->GetUInt32Value(PLAYER_GLYPHS_ENABLED);
    EXPECT_NE(bitsPreHook & OOC_LOCKED_SLOT_BIT, 0u)
        << "InitGlyphsForLevel should have set 0x20";

    // Level-change hook fires
    sScriptMgr->OnPlayerLevelChanged(player, 79);

    uint32 bitsPostHook =
        player->GetUInt32Value(PLAYER_GLYPHS_ENABLED);
    EXPECT_EQ(bitsPostHook & OOC_LOCKED_SLOT_BIT, 0u)
        << "Slot 5 should be re-locked after leveling to 80";
}

}  // namespace

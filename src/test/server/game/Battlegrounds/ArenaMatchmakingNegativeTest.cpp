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

#include "ArenaTeam.h"
#include "Battleground.h"
#include "BattlegroundMgr.h"
#include "BattlegroundQueue.h"
#include "DBCStore.h"
#include "DBCStructure.h"
#include "GameTime.h"
#include "MapMgr.h"
#include "ScriptMgr.h"
#include "ScriptDefines/AllBattlegroundScript.h"
#include "ScriptDefines/ArenaTeamScript.h"
#include "WorldMock.h"
#include "gtest/gtest.h"
#include <cstdlib>

// Defined in DBCStores.cpp with no header declaration.
extern DBCStorage<PvPDifficultyEntry> sPvPDifficultyStore;

// AQ-07's use after free is only diagnosable under AddressSanitizer. Anywhere
// else the read is silent undefined behaviour, which would make the test pass
// or crash at random rather than report anything.
#if defined(__SANITIZE_ADDRESS__)
#  define ARENA_NEGATIVE_ASAN 1
#elif defined(__has_feature)
#  if __has_feature(address_sanitizer)
#    define ARENA_NEGATIVE_ASAN 1
#  endif
#endif

/**
 * Negative tests for the Critical findings of docs/arena-matchmaking-audit.md.
 *
 * These are expected to FAIL. Each one asserts the behaviour the code is
 * supposed to have, against the code as it actually is, so a failure here is
 * the reproduction of a defect rather than a regression. Nothing in this file
 * is a guard, and no production code is modified to accommodate it.
 *
 * Covered: AM-01, AM-02 and AQ-07. The other twenty-one findings are out of
 * scope for this pass.
 *
 * The tests named Control_ must PASS. They establish that the fixture reaches
 * the code under test at all, which is what separates "the defect is real"
 * from "the harness never ran anything".
 */
namespace
{
    constexpr uint32 TestMapId = 559;                       // Nagrand Arena
    constexpr uint32 TestBracket = 0;
    constexpr uint32 BracketDbcRow = 1;
    constexpr uint32 InvitedInstanceId = 0xABCD;

    // The rated branch only reaches its pairing bookkeeping once
    // CreateNewBattleground returns non-null, so this stands in for the real
    // per-map factory and doubles as the "a pair was chosen" counter.
    int g_pairsCreated = 0;

    // Leaked on purpose: the arena is registered in bgDataStore by
    // StartBattleground, so freeing it here would leave a dangling entry.
    Battleground* CountingArenaFactory(Battleground* bgTemplate)
    {
        ++g_pairsCreated;
        return new Battleground(*bgTemplate);
    }
}

class ArenaMatchmakingNegativeTest : public ::testing::Test
{
protected:
    static constexpr uint32 MaxRatingDifference = 150;
    static constexpr uint32 RatingDiscardTimer = 600000;
    static constexpr uint32 PrevOpponentsDiscardTimer = 120000;

    void SetUp() override
    {
        ScriptRegistry<BGScript>::InitEnabledHooksIfNeeded(ALLBATTLEGROUNDHOOK_END);
        ScriptRegistry<ArenaTeamScript>::InitEnabledHooksIfNeeded(ARENATEAMHOOK_END);

        previousWorld_ = std::move(sWorld);
        worldMock_ = new ::testing::NiceMock<WorldMock>();
        ON_CALL(*worldMock_, getIntConfig(::testing::_)).WillByDefault(::testing::Return(0));
        ON_CALL(*worldMock_, getBoolConfig(::testing::_)).WillByDefault(::testing::Return(false));
        ON_CALL(*worldMock_, getFloatConfig(::testing::_)).WillByDefault(::testing::Return(0.0f));
        SetIntConfig(CONFIG_ARENA_MAX_RATING_DIFFERENCE, MaxRatingDifference);
        SetIntConfig(CONFIG_ARENA_RATING_DISCARD_TIMER, RatingDiscardTimer);
        SetIntConfig(CONFIG_ARENA_PREV_OPPONENTS_DISCARD_TIMER, PrevOpponentsDiscardTimer);
        sWorld.reset(worldMock_);

        // The store takes ownership and deletes the entry on the next SetEntry.
        sPvPDifficultyStore.SetEntry(BracketDbcRow,
            new PvPDifficultyEntry(TestMapId, TestBracket, /*minLevel*/ 80, /*maxLevel*/ 80, /*difficulty*/ 0));

        // Registered once at instance id 0, so GetBattlegroundTemplate keeps
        // returning it even after started arenas are added at higher ids.
        if (!arenaTemplate_)
        {
            arenaTemplate_ = new Battleground();
            arenaTemplate_->SetBgTypeID(BATTLEGROUND_TYPE_NONE);
            arenaTemplate_->SetInstanceID(0);
            arenaTemplate_->SetMapId(TestMapId);
            arenaTemplate_->SetArenaorBGType(true);
            arenaTemplate_->SetMinPlayersPerTeam(ARENA_TYPE_2v2);
            arenaTemplate_->SetMaxPlayersPerTeam(ARENA_TYPE_2v2);
            arenaTemplate_->SetLevelRange(80, 80);
        }

        sBattlegroundMgr->AddBattleground(arenaTemplate_);
        BattlegroundMgr::bgTypeToTemplate[BATTLEGROUND_TYPE_NONE] = &CountingArenaFactory;

        // Burn instance id 0 so an invited group's IsInvitedToBGInstanceGUID is
        // never confused with the zero that means "not invited".
        sMapMgr->GenerateInstanceId();

        g_pairsCreated = 0;

        // The same clock the rated branch reads, so "joined N ms ago" below
        // means exactly that.
        now_ = static_cast<uint32>(GameTime::GetGameTimeMS().count());
    }

    void TearDown() override
    {
        BattlegroundMgr::bgTypeToTemplate.erase(BATTLEGROUND_TYPE_NONE);
        sPvPDifficultyStore.SetEntry(BracketDbcRow, nullptr);
        sWorld = std::move(previousWorld_);
    }

    void SetIntConfig(ServerConfigs index, uint32 value)
    {
        ON_CALL(*worldMock_, getIntConfig(index)).WillByDefault(::testing::Return(value));
    }

    GroupQueueInfo* Enqueue(BattlegroundQueue& queue, BattlegroundQueueGroupTypes list, uint32 arenaTeamId,
        uint32 matchmakerRating, uint32 joinedMsAgo = 0, uint32 previousOpponentsTeamId = 0, bool invited = false)
    {
        auto* ginfo = new GroupQueueInfo();
        ginfo->teamId = (list == BG_QUEUE_PREMADE_HORDE) ? TEAM_HORDE : TEAM_ALLIANCE;
        ginfo->RealTeamID = ginfo->teamId;
        ginfo->BgTypeId = BATTLEGROUND_TYPE_NONE;
        ginfo->IsRated = true;
        ginfo->ArenaType = ARENA_TYPE_2v2;
        ginfo->ArenaTeamId = arenaTeamId;
        ginfo->JoinTime = now_ - joinedMsAgo;
        ginfo->RemoveInviteTime = 0;
        ginfo->IsInvitedToBGInstanceGUID = invited ? InvitedInstanceId : 0;
        ginfo->ArenaTeamRating = matchmakerRating;
        ginfo->ArenaMatchmakerRating = matchmakerRating;
        ginfo->OpponentsTeamRating = 0;
        ginfo->OpponentsMatchmakerRating = 0;
        ginfo->PreviousOpponentsTeamId = previousOpponentsTeamId;
        ginfo->BracketId = TestBracket;
        ginfo->GroupType = list;

        // The GUIDs resolve to no player, which keeps InviteGroupToBG's loop empty.
        for (uint32 i = 0; i < ARENA_TYPE_2v2; ++i)
            ginfo->Players.insert(ObjectGuid::Create<HighGuid::Player>(++nextPlayerGuid_));

        // The queue owns the allocation and frees it in its destructor.
        queue.m_QueuedGroups[TestBracket][list].push_back(ginfo);
        return ginfo;
    }

    // The last argument is the rating the caller believes is interesting.
    // Zero is what the periodic pass sends, which is what makes the queue
    // derive an anchor of its own.
    static void RunRatedUpdate(BattlegroundQueue& queue, uint32 callerRating)
    {
        queue.BattlegroundQueueUpdate(/*diff*/ 0, BATTLEGROUND_TYPE_NONE, BattlegroundBracketId(TestBracket),
            ARENA_TYPE_2v2, /*isRated*/ true, callerRating);
    }

    ::testing::NiceMock<WorldMock>* worldMock_ = nullptr;
    std::unique_ptr<IWorld> previousWorld_;
    uint32 now_ = 0;
    uint32 nextPlayerGuid_ = 0;

    static inline Battleground* arenaTemplate_ = nullptr;
};

/*********************************************************/
/***                     CONTROLS                      ***/
/*********************************************************/

// If this fails, every red result below is meaningless.
TEST_F(ArenaMatchmakingNegativeTest, Control_WellMatchedPairIsCreated)
{
    BattlegroundQueue queue;
    Enqueue(queue, BG_QUEUE_PREMADE_ALLIANCE, /*arenaTeamId*/ 2, /*mmr*/ 1600);
    Enqueue(queue, BG_QUEUE_PREMADE_HORDE, /*arenaTeamId*/ 3, /*mmr*/ 1620);

    RunRatedUpdate(queue, /*callerRating*/ 0);

    EXPECT_EQ(g_pairsCreated, 1) << "the fixture never reached the pairing code";
}

// The window is real for a single team, which is the premise AM-01 rests on:
// the filter works, it is just applied against the wrong reference.
TEST_F(ArenaMatchmakingNegativeTest, Control_TeamOutsideTheWindowIsNotPairedAlone)
{
    BattlegroundQueue queue;
    Enqueue(queue, BG_QUEUE_PREMADE_ALLIANCE, /*arenaTeamId*/ 2, /*mmr*/ 1000);
    Enqueue(queue, BG_QUEUE_PREMADE_HORDE, /*arenaTeamId*/ 3, /*mmr*/ 2900);

    RunRatedUpdate(queue, /*callerRating*/ 1000);

    EXPECT_EQ(g_pairsCreated, 0) << "a 1900 point gap was paired even against a single-sided window";
}

/*********************************************************/
/***  AM-01 - the two teams are never compared to each  ***/
/***  other, only to a third value                      ***/
/*********************************************************/

// Arena.MaxRatingDifference is documented as how far apart two teams may be.
// Two teams sitting on opposite edges of the window are 2x that far apart and
// are paired anyway.
//
// Audit: AM-01, BattlegroundQueue.cpp:940-991. Matrix row AM-01a.
TEST_F(ArenaMatchmakingNegativeTest, AM_01_TeamsFurtherApartThanMaxRatingDifferenceAreNotPaired)
{
    BattlegroundQueue queue;
    Enqueue(queue, BG_QUEUE_PREMADE_ALLIANCE, /*arenaTeamId*/ 2, /*mmr*/ 1850);
    Enqueue(queue, BG_QUEUE_PREMADE_HORDE, /*arenaTeamId*/ 3, /*mmr*/ 2150);

    // The window becomes [1850, 2150]. Both teams sit exactly on an edge.
    RunRatedUpdate(queue, /*callerRating*/ 2000);

    EXPECT_EQ(g_pairsCreated, 0)
        << "paired two teams 300 apart with Arena.MaxRatingDifference = " << MaxRatingDifference;
}

// Once Arena.RatingDiscardTimer has elapsed for one team its rating stops being
// checked at all, and nothing caps how far the other team may be.
//
// Audit: AM-01, BattlegroundQueue.cpp:967,984. Matrix row AM-01b.
TEST_F(ArenaMatchmakingNegativeTest, AM_01_DiscardedRatingDoesNotUncapTheOpposingTeam)
{
    BattlegroundQueue queue;
    Enqueue(queue, BG_QUEUE_PREMADE_ALLIANCE, /*arenaTeamId*/ 2, /*mmr*/ 1500,
        /*joinedMsAgo*/ RatingDiscardTimer + 60000);
    Enqueue(queue, BG_QUEUE_PREMADE_HORDE, /*arenaTeamId*/ 3, /*mmr*/ 2600);

    RunRatedUpdate(queue, /*callerRating*/ 2600);

    EXPECT_EQ(g_pairsCreated, 0)
        << "a team that waited out the discard timer was fed to an opponent 1100 rating above it";
}

/*********************************************************/
/***  AM-02 - the window is anchored on a team that     ***/
/***  need not be in the match                          ***/
/*********************************************************/

// A team already invited to another arena still sits at the head of its list,
// so the periodic pass anchors the window on a team that cannot play. Here it
// blocks a pair that is 20 rating apart.
//
// Audit: AM-02, BattlegroundQueue.cpp:913-941. Matrix row AM-02a.
TEST_F(ArenaMatchmakingNegativeTest, AM_02_InvitedFrontGroupDoesNotBlockAValidPair)
{
    BattlegroundQueue queue;
    // Longest waiting, already invited, and therefore the anchor.
    Enqueue(queue, BG_QUEUE_PREMADE_ALLIANCE, /*arenaTeamId*/ 1, /*mmr*/ 2400,
        /*joinedMsAgo*/ 30000, /*previousOpponentsTeamId*/ 0, /*invited*/ true);
    Enqueue(queue, BG_QUEUE_PREMADE_ALLIANCE, /*arenaTeamId*/ 2, /*mmr*/ 1600, /*joinedMsAgo*/ 20000);
    Enqueue(queue, BG_QUEUE_PREMADE_HORDE, /*arenaTeamId*/ 3, /*mmr*/ 1620, /*joinedMsAgo*/ 10000);

    // Anchor becomes 2400, window [2250, 2550], and both playable teams fall out of it.
    RunRatedUpdate(queue, /*callerRating*/ 0);

    EXPECT_EQ(g_pairsCreated, 1)
        << "a team invited to another arena set the rating window and starved a 20 point pair";
}

// The same defect in the other direction: a third team that is not in the match
// widens the window enough to admit a pair the rules should reject.
//
// Audit: AM-02, BattlegroundQueue.cpp:913-941. Matrix row AM-02b.
TEST_F(ArenaMatchmakingNegativeTest, AM_02_ThirdPartyRatingDoesNotAdmitAnIllegalPair)
{
    BattlegroundQueue queue;
    // Without this group the anchor would be 1900 and the pair would be rejected.
    Enqueue(queue, BG_QUEUE_PREMADE_ALLIANCE, /*arenaTeamId*/ 1, /*mmr*/ 2000,
        /*joinedMsAgo*/ 30000, /*previousOpponentsTeamId*/ 0, /*invited*/ true);
    Enqueue(queue, BG_QUEUE_PREMADE_ALLIANCE, /*arenaTeamId*/ 2, /*mmr*/ 1900, /*joinedMsAgo*/ 20000);
    Enqueue(queue, BG_QUEUE_PREMADE_HORDE, /*arenaTeamId*/ 3, /*mmr*/ 2100, /*joinedMsAgo*/ 10000);

    // Anchor becomes 2000, window [1850, 2150], and the 200 point gap slips through.
    RunRatedUpdate(queue, /*callerRating*/ 0);

    EXPECT_EQ(g_pairsCreated, 0)
        << "a team not in the match widened the window and admitted a 200 point gap";
}

/*********************************************************/
/***  AQ-07 - the season-end purge operates on a copy   ***/
/*********************************************************/

// ArenaSeasonMgr::DeleteArenaTeams binds the queue with `auto`, which drops the
// reference that GetBattlegroundQueue returns. Everything the purge does is
// done to a temporary.
//
// Audit: AQ-07, ArenaSeasonMgr.cpp:156.
TEST_F(ArenaMatchmakingNegativeTest, AQ_07_SeasonEndPurgeOperatesOnTheLiveQueue)
{
    constexpr BattlegroundQueueTypeId QueueType = BATTLEGROUND_QUEUE_2v2;

    // Verbatim from ArenaSeasonMgr.cpp:156.
    auto queue = sBattlegroundMgr->GetBattlegroundQueue(QueueType);

    EXPECT_EQ(&queue, &sBattlegroundMgr->GetBattlegroundQueue(QueueType))
        << "the season-end purge holds a copy, so nothing it does reaches the live queue";
}

// The observable consequence: a player removed by the purge is still queued.
//
// A single RemovePlayer rather than the real loop, because the real loop also
// erases from the map it is iterating. That iterator invalidation is the third
// defect of AQ-07 and is left to inspection, since reproducing it here would
// take the whole binary down rather than fail one test.
//
// Audit: AQ-07, ArenaSeasonMgr.cpp:156-159.
TEST_F(ArenaMatchmakingNegativeTest, AQ_07_PurgedPlayerLeavesTheLiveQueue)
{
    constexpr BattlegroundQueueTypeId QueueType = BATTLEGROUND_QUEUE_2v2;

    BattlegroundQueue& live = sBattlegroundMgr->GetBattlegroundQueue(QueueType);
    ASSERT_TRUE(live.m_QueuedPlayers.empty()) << "another test left this queue populated";

    GroupQueueInfo* ginfo = Enqueue(live, BG_QUEUE_PREMADE_ALLIANCE, /*arenaTeamId*/ 7, /*mmr*/ 1500);
    for (ObjectGuid const& guid : ginfo->Players)
        live.m_QueuedPlayers[guid] = ginfo;

    ObjectGuid const purged = *ginfo->Players.begin();

    {
        auto queue = sBattlegroundMgr->GetBattlegroundQueue(QueueType);
        queue.RemovePlayer(purged, true);
    }

    EXPECT_EQ(live.m_QueuedPlayers.count(purged), 0u)
        << "the purge removed the player from a temporary, the live queue still has them";

    // The temporary's destructor already freed everything `live` points at, so
    // drop the dangling pointers instead of letting the singleton keep them.
    // Nothing is leaked here, and nothing is freed twice.
    live.m_QueuedPlayers.clear();
    for (auto& list : live.m_QueuedGroups[TestBracket])
        list.clear();
}

#ifdef ARENA_NEGATIVE_ASAN
// The severity of AQ-07 rests on this and not on the failed purge: the copy's
// destructor frees every GroupQueueInfo the live queue still points at
// (BattlegroundQueue.cpp:56-70), so the next queue update walks freed memory.
//
// Run as a death test because the diagnostic aborts the process. The child is
// expected to exit cleanly, so ASan firing is a failure of this test rather
// than the end of the whole run.
//
// Audit: AQ-07, ArenaSeasonMgr.cpp:156.
TEST_F(ArenaMatchmakingNegativeTest, AQ_07_LiveQueueDoesNotPointAtFreedMemory)
{
    constexpr BattlegroundQueueTypeId QueueType = BATTLEGROUND_QUEUE_3v3;

    EXPECT_EXIT({
        BattlegroundQueue& live = sBattlegroundMgr->GetBattlegroundQueue(QueueType);
        GroupQueueInfo* ginfo = Enqueue(live, BG_QUEUE_PREMADE_ALLIANCE, /*arenaTeamId*/ 9, /*mmr*/ 1500);
        for (ObjectGuid const& guid : ginfo->Players)
            live.m_QueuedPlayers[guid] = ginfo;

        {
            // Verbatim from ArenaSeasonMgr.cpp:156.
            auto queue = sBattlegroundMgr->GetBattlegroundQueue(QueueType);
        }

        // What the very next BattlegroundQueueUpdate does: read the entries the
        // live queue still lists. volatile so the load cannot be optimised out.
        volatile bool sink = false;
        for (GroupQueueInfo const* queued : live.m_QueuedGroups[TestBracket][BG_QUEUE_PREMADE_ALLIANCE])
            sink = queued->IsRated;
        (void)sink;

        std::exit(0);
    }, ::testing::ExitedWithCode(0), "")
        << "the live queue was left pointing at memory the season-end purge already freed";
}
#endif

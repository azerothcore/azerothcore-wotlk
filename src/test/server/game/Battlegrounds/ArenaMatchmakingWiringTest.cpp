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
#include "DBCStores.h"
#include "GameTime.h"
#include "IntegrationTestFixture.h"
#include "MapMgr.h"
#include "ScriptMgr.h"
#include "ScriptDefines/AllBattlegroundScript.h"
#include "ScriptDefines/ArenaTeamScript.h"
#include "gmock/gmock.h"
#include "gtest/gtest.h"
#include <memory>
#include <string>
#include <vector>

using ::testing::Each;
using ::testing::ElementsAre;
using ::testing::IsEmpty;
using ::testing::SizeIs;
using ::testing::TestParamInfo;
using ::testing::Values;
using ::testing::WithParamInterface;

// A queue entry filed in the given list, which is where the update will look for it.
MATCHER_P(FiledIn, list, "")
{
    *result_listener << "team " << arg->ArenaTeamId << " is filed in list " << uint32(arg->GroupType);
    return arg->GroupType == list;
}

/**
 * BattlegroundQueue driven through its real entry points with no server behind it.
 *
 * The pairing rules are covered by ArenaMatchmakingTest without any of this scaffolding.
 * Two things are checked here. The wiring: AddGroup files rated teams into
 * BG_QUEUE_RATED_ARENA, the update projects that bucket, maps the configs onto Rules and
 * applies the invitations, and RemovePlayer drains it. And the defects behind issue 1, each
 * driven through the real update.
 */
namespace
{
    constexpr uint32 TestMapId = 559;                       // Nagrand Arena
    constexpr uint32 TestBracket = 0;
    constexpr uint32 BracketDbcRow = 1;
    constexpr uint32 InvitedInstanceId = 0xABCD;

    // Stands in for the per-map factory so CreateNewBattleground succeeds, and owns every
    // arena the update starts. ~Battleground takes the arena out of bgDataStore itself.
    std::vector<std::unique_ptr<Battleground>> g_createdArenas;

    Battleground* RecordingArenaFactory(Battleground* bgTemplate)
    {
        return g_createdArenas.emplace_back(std::make_unique<Battleground>(*bgTemplate)).get();
    }
}

class ArenaMatchmakingWiringTest : public IntegrationTestFixture
{
protected:
    static constexpr uint32 MaxRatingDifference = 150;
    static constexpr uint32 RatingDiscardTimer = 600000;
    static constexpr uint32 PrevOpponentsDiscardTimer = 120000;

    void SetUp() override
    {
        IntegrationTestFixture::SetUp();

        ScriptRegistry<BGScript>::InitEnabledHooksIfNeeded(ALLBATTLEGROUNDHOOK_END);
        ScriptRegistry<ArenaTeamScript>::InitEnabledHooksIfNeeded(ARENATEAMHOOK_END);

        SetIntConfig(CONFIG_ARENA_MAX_RATING_DIFFERENCE, MaxRatingDifference);
        SetIntConfig(CONFIG_ARENA_RATING_DISCARD_TIMER, RatingDiscardTimer);
        SetIntConfig(CONFIG_ARENA_PREV_OPPONENTS_DISCARD_TIMER, PrevOpponentsDiscardTimer);

        // The store takes ownership and deletes the entry on the next SetEntry.
        sPvPDifficultyStore.SetEntry(BracketDbcRow,
            new PvPDifficultyEntry(TestMapId, TestBracket, /*minLevel*/ 80, /*maxLevel*/ 80, /*difficulty*/ 0));

        // Instance id 0 is where GetBattlegroundTemplate looks. Started arenas get higher ids.
        _arenaTemplate = std::make_unique<Battleground>();
        _arenaTemplate->SetBgTypeID(BATTLEGROUND_TYPE_NONE);
        _arenaTemplate->SetInstanceID(0);
        _arenaTemplate->SetMapId(TestMapId);
        _arenaTemplate->SetArenaorBGType(true);
        _arenaTemplate->SetMinPlayersPerTeam(ARENA_TYPE_2v2);
        _arenaTemplate->SetMaxPlayersPerTeam(ARENA_TYPE_2v2);
        _arenaTemplate->SetLevelRange(80, 80);
        sBattlegroundMgr->AddBattleground(_arenaTemplate.get());
        BattlegroundMgr::bgTypeToTemplate[BATTLEGROUND_TYPE_NONE] = &RecordingArenaFactory;

        // Burn instance id 0 so an invited group's IsInvitedToBGInstanceGUID is never
        // confused with the zero that means "not invited".
        sMapMgr->GenerateInstanceId();

        // The same clock the rated branch reads, so "joined N ms ago" below means exactly
        // that. GameTime sits near zero in a unit test and the subtraction wraps, which is
        // harmless because wait times are computed in unsigned arithmetic.
        _now = static_cast<uint32>(GameTime::GetGameTimeMS().count());
    }

    void TearDown() override
    {
        g_createdArenas.clear();
        _arenaTemplate.reset();
        BattlegroundMgr::bgTypeToTemplate.erase(BATTLEGROUND_TYPE_NONE);
        sPvPDifficultyStore.SetEntry(BracketDbcRow, nullptr);

        IntegrationTestFixture::TearDown();
    }

    void SetIntConfig(ServerConfigs index, uint32 value)
    {
        ON_CALL(*GetWorldMock(), getIntConfig(index)).WillByDefault(::testing::Return(value));
    }

    static int PairsCreated() { return static_cast<int>(g_createdArenas.size()); }

    static PvPDifficultyEntry const* Bracket() { return sPvPDifficultyStore.LookupEntry(BracketDbcRow); }

    static BattlegroundQueue::GroupsQueueType const& List(BattlegroundQueue const& queue, BattlegroundQueueGroupTypes list)
    {
        return queue.m_QueuedGroups[TestBracket][list];
    }

    struct TeamSpec
    {
        uint32 arenaTeamId{};
        uint32 matchmakerRating{};
        uint32 joinedMsAgo{};
        uint32 previousOpponentsTeamId{};
        bool   invited{};
        TeamId teamId{ TEAM_ALLIANCE };
        BattlegroundQueueGroupTypes list{ BG_QUEUE_RATED_ARENA };
    };

    // Files an entry the way AddGroup would, without a player behind each GUID, which keeps
    // InviteGroupToBG's loop empty.
    GroupQueueInfo* Enqueue(BattlegroundQueue& queue, TeamSpec const& spec)
    {
        auto* ginfo = new GroupQueueInfo();
        ginfo->teamId = spec.teamId;
        ginfo->RealTeamID = spec.teamId;
        ginfo->BgTypeId = BATTLEGROUND_TYPE_NONE;
        ginfo->IsRated = true;
        ginfo->ArenaType = ARENA_TYPE_2v2;
        ginfo->ArenaTeamId = spec.arenaTeamId;
        ginfo->JoinTime = _now - spec.joinedMsAgo;
        ginfo->RemoveInviteTime = 0;
        ginfo->IsInvitedToBGInstanceGUID = spec.invited ? InvitedInstanceId : 0;
        ginfo->ArenaTeamRating = spec.matchmakerRating;
        ginfo->ArenaMatchmakerRating = spec.matchmakerRating;
        ginfo->OpponentsTeamRating = 0;
        ginfo->OpponentsMatchmakerRating = 0;
        ginfo->PreviousOpponentsTeamId = spec.previousOpponentsTeamId;
        ginfo->BracketId = TestBracket;
        ginfo->GroupType = spec.list;

        for (uint32 i = 0; i < ARENA_TYPE_2v2; ++i)
        {
            ObjectGuid const guid = ObjectGuid::Create<HighGuid::Player>(++_nextPlayerGuid);
            ginfo->Players.insert(guid);
            queue.m_QueuedPlayers[guid] = ginfo;
        }

        // The queue owns the allocation and frees it in its destructor.
        queue.m_QueuedGroups[TestBracket][spec.list].push_back(ginfo);
        return ginfo;
    }

    // The last argument is the rating the caller believes is interesting. It is still handed
    // to the script hooks, and must no longer affect selection.
    static void RunRatedUpdate(BattlegroundQueue& queue, uint32 callerRating)
    {
        queue.BattlegroundQueueUpdate(/*diff*/ 0, BATTLEGROUND_TYPE_NONE, BattlegroundBracketId(TestBracket),
            ARENA_TYPE_2v2, /*isRated*/ true, callerRating);
    }

    uint32 _now = 0;
    uint32 _nextPlayerGuid = 0;
    std::unique_ptr<Battleground> _arenaTemplate;
};

// The fixture must be able to reach the pairing code, otherwise nothing below means anything.
TEST_F(ArenaMatchmakingWiringTest, BaselineWellMatchedPairIsCreated)
{
    BattlegroundQueue queue;
    Enqueue(queue, { .arenaTeamId = 2, .matchmakerRating = 1600 });
    Enqueue(queue, { .arenaTeamId = 3, .matchmakerRating = 1620 });

    RunRatedUpdate(queue, /*callerRating*/ 0);

    EXPECT_EQ(PairsCreated(), 1);
}

namespace
{
    struct RoutingCase
    {
        char const* name;
        bool isRated;
        bool isPremade;
        TeamId team;
        uint32 arenaTeamId;
        BattlegroundQueueGroupTypes list;
    };

    void PrintTo(RoutingCase const& routing, std::ostream* os)
    {
        *os << routing.name;
    }
}

// AddGroup is where a group is filed, and the update only reads rated teams out of
// BG_QUEUE_RATED_ARENA. The faction split used to put horde teams in a different list.
class ArenaQueueRoutingTest : public ArenaMatchmakingWiringTest, public WithParamInterface<RoutingCase>
{
};

TEST_P(ArenaQueueRoutingTest, AddGroupFilesTheGroupWhereTheUpdateReadsIt)
{
    RoutingCase const& routing = GetParam();

    BattlegroundQueue queue;
    TestPlayer* leader = CreateTestPlayer();
    leader->SetTeamIdForTest(routing.team);

    GroupQueueInfo const* ginfo = queue.AddGroup(leader, nullptr, BATTLEGROUND_TYPE_NONE, Bracket(), ARENA_TYPE_2v2,
        routing.isRated, routing.isPremade, 1500, 1500, routing.arenaTeamId);

    EXPECT_THAT(ginfo, FiledIn(routing.list));
    EXPECT_THAT(List(queue, routing.list), ElementsAre(ginfo));
}

INSTANTIATE_TEST_SUITE_P(Buckets, ArenaQueueRoutingTest,
    Values(
        RoutingCase{ "RatedAlliance",   true,  false, TEAM_ALLIANCE, 7, BG_QUEUE_RATED_ARENA },
        RoutingCase{ "RatedHorde",      true,  false, TEAM_HORDE,    7, BG_QUEUE_RATED_ARENA },
        RoutingCase{ "UnratedAlliance", false, false, TEAM_ALLIANCE, 0, BG_QUEUE_NORMAL_ALLIANCE },
        RoutingCase{ "UnratedHorde",    false, false, TEAM_HORDE,    0, BG_QUEUE_NORMAL_HORDE },
        RoutingCase{ "PremadeAlliance", false, true,  TEAM_ALLIANCE, 0, BG_QUEUE_PREMADE_ALLIANCE },
        RoutingCase{ "PremadeHorde",    false, true,  TEAM_HORDE,    0, BG_QUEUE_PREMADE_HORDE }),
    [](TestParamInfo<RoutingCase> const& info) { return std::string(info.param.name); });

// Both sides learn the other's ratings and are invited to the same instance.
TEST_F(ArenaMatchmakingWiringTest, PairedGroupsAreInvitedAndCrossReferenced)
{
    BattlegroundQueue queue;
    GroupQueueInfo* first = Enqueue(queue, { .arenaTeamId = 2, .matchmakerRating = 1600 });
    GroupQueueInfo* second = Enqueue(queue, { .arenaTeamId = 3, .matchmakerRating = 1620 });

    RunRatedUpdate(queue, /*callerRating*/ 0);
    ASSERT_EQ(PairsCreated(), 1);

    EXPECT_EQ(first->OpponentsMatchmakerRating, second->ArenaMatchmakerRating);
    EXPECT_EQ(second->OpponentsMatchmakerRating, first->ArenaMatchmakerRating);
    EXPECT_EQ(first->OpponentsTeamRating, second->ArenaTeamRating);
    EXPECT_EQ(second->OpponentsTeamRating, first->ArenaTeamRating);

    EXPECT_NE(first->IsInvitedToBGInstanceGUID, 0u);
    EXPECT_EQ(first->IsInvitedToBGInstanceGUID, second->IsInvitedToBGInstanceGUID);
}

// The side a rated team plays is chosen at invite time, so both teams stay in the one bucket
// they queued into and no list move is needed to keep GroupType honest.
TEST_F(ArenaMatchmakingWiringTest, PairedGroupsStayInTheRatedQueue)
{
    BattlegroundQueue queue;
    Enqueue(queue, { .arenaTeamId = 11, .matchmakerRating = 2400, .teamId = TEAM_HORDE });
    Enqueue(queue, { .arenaTeamId = 22, .matchmakerRating = 2400, .teamId = TEAM_HORDE });

    RunRatedUpdate(queue, /*callerRating*/ 0);
    ASSERT_EQ(PairsCreated(), 1) << "the same-faction pair was not formed";

    EXPECT_THAT(List(queue, BG_QUEUE_RATED_ARENA), SizeIs(2));
    EXPECT_THAT(List(queue, BG_QUEUE_RATED_ARENA), Each(FiledIn(BG_QUEUE_RATED_ARENA)));

    for (BattlegroundQueueGroupTypes const list : { BG_QUEUE_PREMADE_ALLIANCE, BG_QUEUE_PREMADE_HORDE,
        BG_QUEUE_NORMAL_ALLIANCE, BG_QUEUE_NORMAL_HORDE })
    {
        SCOPED_TRACE("list " + std::to_string(list));
        EXPECT_THAT(List(queue, list), IsEmpty());
    }
}

// Entering the arena removes each member through RemovePlayer, which has to find the entry
// under the GroupType it was queued with. The last member out takes the entry with it.
TEST_F(ArenaMatchmakingWiringTest, EnteringTheArenaDrainsTheRatedQueue)
{
    BattlegroundQueue queue;
    Enqueue(queue, { .arenaTeamId = 2, .matchmakerRating = 1600 });
    Enqueue(queue, { .arenaTeamId = 3, .matchmakerRating = 1620 });

    RunRatedUpdate(queue, /*callerRating*/ 0);
    ASSERT_EQ(PairsCreated(), 1);

    // Copied first: RemovePlayer frees the entry along with its last member.
    std::vector<ObjectGuid> players;
    for (auto const& entry : queue.m_QueuedPlayers)
        players.push_back(entry.first);

    for (ObjectGuid const& guid : players)
        queue.RemovePlayer(guid, /*decreaseInvitedCount*/ false);

    EXPECT_THAT(List(queue, BG_QUEUE_RATED_ARENA), IsEmpty());
    EXPECT_THAT(queue.m_QueuedPlayers, IsEmpty());
}

// A group with no arena team resolves to a null ArenaTeam at match end.
TEST_F(ArenaMatchmakingWiringTest, GroupWithoutArenaTeamIsNotSelectedForRatedMatch)
{
    BattlegroundQueue queue;
    Enqueue(queue, { .arenaTeamId = 0, .matchmakerRating = 1500 });
    Enqueue(queue, { .arenaTeamId = 22, .matchmakerRating = 1500 });

    RunRatedUpdate(queue, /*callerRating*/ 1500);

    EXPECT_EQ(PairsCreated(), 0) << "a group with ArenaTeamId 0 was selected for a rated arena";
}

// Rated arena teams live in BG_QUEUE_RATED_ARENA and nowhere else. A module still writing
// them into the faction-split premade lists must not have them silently matched from there.
TEST_F(ArenaMatchmakingWiringTest, StaleGroupInAPremadeQueueIsNotSelected)
{
    BattlegroundQueue queue;
    Enqueue(queue, { .arenaTeamId = 1, .matchmakerRating = 1500, .list = BG_QUEUE_PREMADE_ALLIANCE });
    Enqueue(queue, { .arenaTeamId = 2, .matchmakerRating = 1500, .list = BG_QUEUE_PREMADE_HORDE });

    RunRatedUpdate(queue, /*callerRating*/ 0);

    EXPECT_EQ(PairsCreated(), 0) << "a rated team was matched out of a premade battleground queue";
}

// Arena.RatingDiscardTimer is documented "0 - (Disabled)". Disabled means the gap keeps
// applying however long a team waits, not that every team is instantly stale.
TEST_F(ArenaMatchmakingWiringTest, DisabledRatingDiscardTimerKeepsEnforcingTheGap)
{
    SetIntConfig(CONFIG_ARENA_RATING_DISCARD_TIMER, 0);

    BattlegroundQueue queue;
    Enqueue(queue, { .arenaTeamId = 1, .matchmakerRating = 1000, .joinedMsAgo = 3600000 });
    Enqueue(queue, { .arenaTeamId = 2, .matchmakerRating = 3000, .joinedMsAgo = 3600000 });

    RunRatedUpdate(queue, /*callerRating*/ 0);

    EXPECT_EQ(PairsCreated(), 0) << "a disabled discard timer waived the rating gap";
}

// Arena.MaxRatingDifference is documented the same way, and for the gap itself disabled does
// mean unconstrained.
TEST_F(ArenaMatchmakingWiringTest, DisabledMaxRatingDifferenceLeavesTheGapUnconstrained)
{
    SetIntConfig(CONFIG_ARENA_MAX_RATING_DIFFERENCE, 0);

    BattlegroundQueue queue;
    Enqueue(queue, { .arenaTeamId = 1, .matchmakerRating = 500 });
    Enqueue(queue, { .arenaTeamId = 2, .matchmakerRating = 3000 });

    RunRatedUpdate(queue, /*callerRating*/ 0);

    EXPECT_EQ(PairsCreated(), 1);
}

// JoinTime is the ms clock truncated to 32 bits and GameTime sits near zero here, so every
// JoinTime below predates the wrap. Measured any wider than 32 bits these teams look like
// 49 day waiters and the gap is waived. A guard, not a reproduction: the old code declines
// this pair too, for the unrelated reason that 3000 is outside the window anchored on 1000.
TEST_F(ArenaMatchmakingWiringTest, WaitIsMeasuredAcrossTheClockWrap)
{
    ASSERT_LT(_now, RatingDiscardTimer) << "fixture assumption: the clock has not yet passed the timer";

    BattlegroundQueue queue;
    Enqueue(queue, { .arenaTeamId = 1, .matchmakerRating = 1000, .joinedMsAgo = 30000 });
    Enqueue(queue, { .arenaTeamId = 2, .matchmakerRating = 3000, .joinedMsAgo = 20000 });

    RunRatedUpdate(queue, /*callerRating*/ 0);

    EXPECT_EQ(PairsCreated(), 0) << "two teams 2000 apart were treated as having waited out the discard timer";
}

/**
 * The defects behind issue 1, each driven through the real update.
 */

// Selection no longer takes a rating from the caller, so the same queue must produce the same
// match whatever the caller passes.
class ArenaCallerRatingTest : public ArenaMatchmakingWiringTest, public WithParamInterface<uint32>
{
};

TEST_P(ArenaCallerRatingTest, DoesNotSteerSelection)
{
    BattlegroundQueue queue;
    Enqueue(queue, { .arenaTeamId = 2, .matchmakerRating = 1600 });
    Enqueue(queue, { .arenaTeamId = 3, .matchmakerRating = 1620 });

    RunRatedUpdate(queue, GetParam());

    EXPECT_EQ(PairsCreated(), 1);
}

INSTANTIATE_TEST_SUITE_P(CallerRating, ArenaCallerRatingTest, Values(0u, 1500u, 2400u),
    [](TestParamInfo<uint32> const& info) { return "Rating" + std::to_string(info.param); });

// A group that is already in a match must not affect the outcome.
TEST_F(ArenaMatchmakingWiringTest, InvitedGroupDoesNotChangeTheOutcome)
{
    BattlegroundQueue queue;
    Enqueue(queue, { .arenaTeamId = 1, .matchmakerRating = 2400, .joinedMsAgo = 60000, .invited = true });
    Enqueue(queue, { .arenaTeamId = 2, .matchmakerRating = 1600 });
    Enqueue(queue, { .arenaTeamId = 3, .matchmakerRating = 1620 });

    RunRatedUpdate(queue, /*callerRating*/ 0);

    EXPECT_EQ(PairsCreated(), 1) << "a group already in a match suppressed an otherwise valid pairing";
}

// The rejection has to survive the trip through the wiring, not just the selector, so no
// arena is created.
TEST_F(ArenaMatchmakingWiringTest, PairBeyondMaxRatingDifferenceIsNotStarted)
{
    BattlegroundQueue queue;
    Enqueue(queue, { .arenaTeamId = 1, .matchmakerRating = 1850 });
    Enqueue(queue, { .arenaTeamId = 2, .matchmakerRating = 2150 });

    RunRatedUpdate(queue, /*callerRating*/ 2000);

    EXPECT_EQ(PairsCreated(), 0) << "paired two teams 300 apart at a 150 setting";
}

// The old selection centred a window on the rating it was handed and tested both candidates
// against that rather than against each other, so 1850 and 2150, both inside a window centred
// on 2000, were started against each other at twice the gap.
TEST_F(ArenaMatchmakingWiringTest, StartedPairIsNeverWiderThanMaxRatingDifference)
{
    BattlegroundQueue queue;
    GroupQueueInfo const* low = Enqueue(queue, { .arenaTeamId = 1, .matchmakerRating = 1850, .joinedMsAgo = 30000 });
    GroupQueueInfo const* high = Enqueue(queue, { .arenaTeamId = 2, .matchmakerRating = 2150, .joinedMsAgo = 20000 });
    GroupQueueInfo const* mid = Enqueue(queue, { .arenaTeamId = 3, .matchmakerRating = 2000, .joinedMsAgo = 10000 });

    // The scheduler hands in the joining team's rating, which is what the old code anchored on.
    RunRatedUpdate(queue, /*callerRating*/ 2000);

    EXPECT_EQ(PairsCreated(), 1);
    EXPECT_NE(low->IsInvitedToBGInstanceGUID, 0u) << "the longest waiter was not started";
    EXPECT_NE(mid->IsInvitedToBGInstanceGUID, 0u) << "1850 was not started against 2000, the only team it can face";
    EXPECT_EQ(high->IsInvitedToBGInstanceGUID, 0u) << "2150 was started against 1850, twice the gap";
}

// Faction is not a pairing criterion any more, so the rematch timer has to hold whichever
// sides the two teams last played on.
TEST_F(ArenaMatchmakingWiringTest, SameFactionPreviousOpponentsAreNotRematched)
{
    BattlegroundQueue queue;
    Enqueue(queue, { .arenaTeamId = 11, .matchmakerRating = 1800, .previousOpponentsTeamId = 22 });
    Enqueue(queue, { .arenaTeamId = 22, .matchmakerRating = 1800, .previousOpponentsTeamId = 11 });

    RunRatedUpdate(queue, /*callerRating*/ 1800);

    EXPECT_EQ(PairsCreated(), 0);
}

TEST_F(ArenaMatchmakingWiringTest, CrossFactionPreviousOpponentsAreNotRematched)
{
    BattlegroundQueue queue;
    Enqueue(queue, { .arenaTeamId = 11, .matchmakerRating = 1800, .previousOpponentsTeamId = 22,
        .teamId = TEAM_ALLIANCE });
    Enqueue(queue, { .arenaTeamId = 22, .matchmakerRating = 1800, .previousOpponentsTeamId = 11,
        .teamId = TEAM_HORDE });

    RunRatedUpdate(queue, /*callerRating*/ 1800);

    EXPECT_EQ(PairsCreated(), 0) << "rematched two teams inside PreviousOpponentsDiscardTimer";
}

// Queue position must not stop a valid pair from forming.
TEST_F(ArenaMatchmakingWiringTest, PartnerSearchConsidersEarlierGroups)
{
    BattlegroundQueue queue;
    Enqueue(queue, { .arenaTeamId = 1, .matchmakerRating = 1800 });
    Enqueue(queue, { .arenaTeamId = 2, .matchmakerRating = 1900 });

    RunRatedUpdate(queue, /*callerRating*/ 2000);

    EXPECT_EQ(PairsCreated(), 1) << "a pair 100 apart was skipped because one of them precedes the other";
}

// The comment on the branch has always promised "can create many in single queue update".
// Only one match was ever started, which is the stall behind issue 1.
TEST_F(ArenaMatchmakingWiringTest, EveryFormableMatchIsStartedInOneUpdate)
{
    BattlegroundQueue queue;
    Enqueue(queue, { .arenaTeamId = 1, .matchmakerRating = 1500, .joinedMsAgo = 40000 });
    Enqueue(queue, { .arenaTeamId = 2, .matchmakerRating = 1500, .joinedMsAgo = 30000 });
    Enqueue(queue, { .arenaTeamId = 3, .matchmakerRating = 1500, .joinedMsAgo = 20000 });
    Enqueue(queue, { .arenaTeamId = 4, .matchmakerRating = 1500, .joinedMsAgo = 10000 });

    RunRatedUpdate(queue, /*callerRating*/ 0);

    EXPECT_EQ(PairsCreated(), 2);
}

// A team nobody can play used to abort the whole bracket, so the teams behind it waited for
// the discard timer rather than for an opponent.
TEST_F(ArenaMatchmakingWiringTest, UnmatchableLongestWaiterDoesNotStallTheQueue)
{
    BattlegroundQueue queue;
    Enqueue(queue, { .arenaTeamId = 1, .matchmakerRating = 3000, .joinedMsAgo = 60000 });
    Enqueue(queue, { .arenaTeamId = 2, .matchmakerRating = 1500, .joinedMsAgo = 30000 });
    Enqueue(queue, { .arenaTeamId = 3, .matchmakerRating = 1550, .joinedMsAgo = 20000 });

    RunRatedUpdate(queue, /*callerRating*/ 0);

    EXPECT_EQ(PairsCreated(), 1) << "an unmatchable team blocked the teams behind it";
}

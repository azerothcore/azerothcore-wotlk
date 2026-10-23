/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "CreatureGroups.h"
#include "IntegrationTestFixture.h"
#include "MovementGenerator.h"
#include "MotionMaster.h"
#include "MoveSpline.h"
#include "TestCreature.h"
#include "WaypointMovementGenerator.h"
#include "WaypointMgr.h"
#include "gtest/gtest.h"
#include <memory>

class WaypointMgrTestAccessor
{
public:
    static void AddPath(WaypointPath path)
    {
        sWaypointMgr->_waypointStore.insert_or_assign(path.Id, std::move(path));
    }

    static void RemovePath(uint32 pathId)
    {
        sWaypointMgr->_waypointStore.erase(pathId);
    }
};

namespace
{

constexpr ObjectGuid::LowType LeaderSpawnId = 91001;
constexpr ObjectGuid::LowType FirstFollowerSpawnId = 91002;
constexpr ObjectGuid::LowType SecondFollowerSpawnId = 91003;
constexpr uint32 PatrolPathId = 99001;
constexpr uint32 LastReachedWaypointId = 4;

class PatrolLeaderPromotionTest : public IntegrationTestFixture
{
protected:
    void SetUp() override
    {
        IntegrationTestFixture::SetUp();

        if (!sMovementGeneratorRegistry->GetRegistryItem(IDLE_MOTION_TYPE))
            (new IdleMovementFactory())->RegisterSelf();

        if (!sMovementGeneratorRegistry->GetRegistryItem(WAYPOINT_MOTION_TYPE))
            (new MovementGeneratorFactory<WaypointMovementGenerator<Creature>>(
                WAYPOINT_MOTION_TYPE))->RegisterSelf();

        _leader = CreateFormationCreature(1, 10001, LeaderSpawnId);
        _firstFollower = CreateFormationCreature(2, 10002, FirstFollowerSpawnId);
        _secondFollower = CreateFormationCreature(3, 10003, SecondFollowerSpawnId);

        _leader->SetDefaultMovementType(WAYPOINT_MOTION_TYPE);
        _leader->LoadPath(PatrolPathId);
        _leader->UpdateWaypointID(LastReachedWaypointId);
        _leader->UpdateCurrentWaypointInfo(LastReachedWaypointId, PatrolPathId);

        std::vector<WaypointNode> nodes;
        nodes.emplace_back(1, 5.0f, 0.0f, 0.0f);
        nodes.emplace_back(LastReachedWaypointId, 10.0f, 0.0f, 0.0f);
        nodes.emplace_back(7, 15.0f, 0.0f, 0.0f);
        WaypointMgrTestAccessor::AddPath(WaypointPath(PatrolPathId, std::move(nodes)));
    }

    void TearDown() override
    {
        _leader->SetFormation(nullptr);
        _firstFollower->SetFormation(nullptr);
        _secondFollower->SetFormation(nullptr);
        _group.reset();

        sFormationMgr->CreatureGroupMap.erase(LeaderSpawnId);
        sFormationMgr->CreatureGroupMap.erase(FirstFollowerSpawnId);
        sFormationMgr->CreatureGroupMap.erase(SecondFollowerSpawnId);

        IntegrationTestFixture::TearDown();
        WaypointMgrTestAccessor::RemovePath(PatrolPathId);
    }

    void CreateFormation(bool enablePromotion)
    {
        FormationInfo leaderInfo;
        leaderInfo.leaderGUID = LeaderSpawnId;
        leaderInfo.groupAI =
            std::underlying_type_t<GroupAIFlags>(GroupAIFlags::GROUP_AI_FLAG_LEADER_ASSIST_MEMBER);
        if (enablePromotion)
            leaderInfo.groupAI |=
                std::underlying_type_t<GroupAIFlags>(GroupAIFlags::GROUP_AI_FLAG_PROMOTE_PATROL_LEADER);

        FormationInfo followerInfo;
        followerInfo.leaderGUID = LeaderSpawnId;
        followerInfo.follow_dist = 5.0f;
        followerInfo.groupAI = std::underlying_type_t<GroupAIFlags>(GroupAIFlags::GROUP_AI_FLAG_FOLLOW_LEADER);

        sFormationMgr->CreatureGroupMap[LeaderSpawnId] = leaderInfo;
        sFormationMgr->CreatureGroupMap[FirstFollowerSpawnId] = followerInfo;
        sFormationMgr->CreatureGroupMap[SecondFollowerSpawnId] = followerInfo;

        _group = std::make_unique<CreatureGroup>(LeaderSpawnId);
        _group->AddMember(_leader);
        _group->AddMember(_secondFollower);
        _group->AddMember(_firstFollower);
    }

    TestCreature* CreateFormationCreature(ObjectGuid::LowType guid, uint32 entry, ObjectGuid::LowType spawnId)
    {
        TestCreature* creature = CreateTestCreature(guid, entry, TEST_FACTION_HOSTILE_TO_ALL);
        creature->SetTestSpawnId(spawnId);
        return creature;
    }

    std::unique_ptr<CreatureGroup> _group;
    TestCreature* _leader = nullptr;
    TestCreature* _firstFollower = nullptr;
    TestCreature* _secondFollower = nullptr;
};

} // namespace

TEST_F(PatrolLeaderPromotionTest, OptInPromotionKeepsOriginalLeaderIdentity)
{
    CreateFormation(true);
    _leader->SetAlive(false);

    ASSERT_TRUE(_group->TryPromotePatrolLeader(_leader));
    EXPECT_EQ(_group->GetLeader(), _leader);
    EXPECT_EQ(_group->GetMovementLeader(), _firstFollower);
    EXPECT_TRUE(_group->IsFormed());
    EXPECT_EQ(_firstFollower->GetMotionMaster()->GetMotionSlotType(MOTION_SLOT_IDLE), WAYPOINT_MOTION_TYPE);
    EXPECT_EQ(_secondFollower->GetMotionMaster()->GetMotionSlotType(MOTION_SLOT_IDLE), FORMATION_MOTION_TYPE);
}

TEST_F(PatrolLeaderPromotionTest, UnflaggedFormationKeepsExistingBehavior)
{
    CreateFormation(false);
    _leader->SetAlive(false);

    EXPECT_FALSE(_group->TryPromotePatrolLeader(_leader));
    EXPECT_EQ(_group->GetMovementLeader(), _leader);
}

TEST_F(PatrolLeaderPromotionTest, PromotionPreservesActiveChaseMovement)
{
    CreateFormation(true);
    TestCreature* target = CreateTestCreature(4, 10004, TEST_FACTION_HOSTILE_TO_MONSTERS);
    _firstFollower->GetMotionMaster()->MoveChase(target);
    ASSERT_EQ(_firstFollower->GetMotionMaster()->GetCurrentMovementGeneratorType(), CHASE_MOTION_TYPE);
    _leader->SetAlive(false);

    ASSERT_TRUE(_group->TryPromotePatrolLeader(_leader));
    EXPECT_EQ(_firstFollower->GetMotionMaster()->GetCurrentMovementGeneratorType(), CHASE_MOTION_TYPE);
    EXPECT_EQ(_firstFollower->GetMotionMaster()->GetMotionSlotType(MOTION_SLOT_IDLE), WAYPOINT_MOTION_TYPE);
}

TEST_F(PatrolLeaderPromotionTest, SuccessiveLeaderDeathsPromoteRemainingFollower)
{
    CreateFormation(true);
    _leader->SetAlive(false);
    ASSERT_TRUE(_group->TryPromotePatrolLeader(_leader));
    _firstFollower->SetAlive(false);

    ASSERT_TRUE(_group->TryPromotePatrolLeader(_firstFollower));
    EXPECT_EQ(_group->GetMovementLeader(), _secondFollower);
    EXPECT_EQ(_secondFollower->GetMotionMaster()->GetMotionSlotType(MOTION_SLOT_IDLE), WAYPOINT_MOTION_TYPE);
}

TEST_F(PatrolLeaderPromotionTest, PromotionStopsWhenNoLivingFollowerRemains)
{
    CreateFormation(true);
    _leader->SetAlive(false);
    _firstFollower->SetAlive(false);
    _secondFollower->SetAlive(false);

    EXPECT_FALSE(_group->TryPromotePatrolLeader(_leader));
    EXPECT_EQ(_group->GetMovementLeader(), _leader);
}

TEST_F(PatrolLeaderPromotionTest, PromotionRequiresWaypointMovement)
{
    _leader->SetDefaultMovementType(IDLE_MOTION_TYPE);
    CreateFormation(true);
    _leader->SetAlive(false);

    EXPECT_FALSE(_group->TryPromotePatrolLeader(_leader));
    EXPECT_EQ(_group->GetMovementLeader(), _leader);
}

TEST_F(PatrolLeaderPromotionTest, PromotionCarriesTheLastReachedWaypoint)
{
    CreateFormation(true);
    _leader->SetAlive(false);

    ASSERT_TRUE(_group->TryPromotePatrolLeader(_leader));
    EXPECT_EQ(_firstFollower->GetCurrentWaypointInfo(), std::make_pair(LastReachedWaypointId, PatrolPathId));

    auto* movement = dynamic_cast<WaypointMovementGenerator<Creature>*>(
        _firstFollower->GetMotionMaster()->GetMotionSlot(MOTION_SLOT_IDLE));
    ASSERT_NE(movement, nullptr);
    EXPECT_EQ(movement->GetCurrentNode(), 2u);
}

TEST_F(PatrolLeaderPromotionTest, PromotionSurvivesOriginalLeaderUnload)
{
    CreateFormation(true);
    _leader->SetAlive(false);
    ASSERT_TRUE(_group->TryPromotePatrolLeader(_leader));

    _group->RemoveMember(_leader);
    EXPECT_EQ(_group->GetLeader(), nullptr);
    EXPECT_EQ(_group->GetMovementLeader(), _firstFollower);
    EXPECT_TRUE(_group->IsFormed());

    _firstFollower->SetAlive(false);
    ASSERT_TRUE(_group->TryPromotePatrolLeader(_firstFollower));
    EXPECT_EQ(_group->GetMovementLeader(), _secondFollower);

    _leader->SetAlive(true);
    _group->AddMember(_leader);
    EXPECT_EQ(_group->GetLeader(), _leader);
    EXPECT_EQ(_group->GetMovementLeader(), _leader);
}

TEST_F(PatrolLeaderPromotionTest, OriginalLeaderReclaimsMovementLeadershipOnRespawn)
{
    CreateFormation(true);
    _leader->SetAlive(false);
    ASSERT_TRUE(_group->TryPromotePatrolLeader(_leader));
    _leader->SetAlive(true);

    _group->MemberRespawned(_leader);
    EXPECT_EQ(_group->GetLeader(), _leader);
    EXPECT_EQ(_group->GetMovementLeader(), _leader);
}

TEST_F(PatrolLeaderPromotionTest, ReturningOriginalLeaderWaitsForCombatToEnd)
{
    CreateFormation(true);
    _leader->SetAlive(false);
    ASSERT_TRUE(_group->TryPromotePatrolLeader(_leader));

    TestCreature* target = CreateTestCreature(4, 10004, TEST_FACTION_HOSTILE_TO_MONSTERS);
    ASSERT_TRUE(_firstFollower->TestGetCombatMgr().SetInCombatWith(target));

    // Exercise the active-spline branch without requiring terrain or model DBC data.
    Movement::MoveSplineInitArgs splineArgs;
    splineArgs.path.emplace_back(0.0f, 0.0f, 0.0f);
    splineArgs.path.emplace_back(10.0f, 0.0f, 0.0f);
    splineArgs.velocity = 1.0f;
    splineArgs.facing.angle = 0.0f;
    splineArgs.walk = false;
    _firstFollower->movespline->Initialize(splineArgs);
    ASSERT_FALSE(_firstFollower->movespline->Finalized());

    _group->RemoveMember(_leader);
    _leader->SetAlive(true);
    _leader->GetMotionMaster()->Initialize();
    ASSERT_EQ(_leader->GetMotionMaster()->GetMotionSlotType(MOTION_SLOT_IDLE), WAYPOINT_MOTION_TYPE);

    _group->AddMember(_leader);
    ASSERT_EQ(_group->GetMovementLeader(), _firstFollower);
    _leader->Motion_Initialize();

    EXPECT_EQ(_leader->GetMotionMaster()->GetMotionSlotType(MOTION_SLOT_IDLE), IDLE_MOTION_TYPE);
    EXPECT_EQ(_group->GetMovementLeader(), _firstFollower);
}

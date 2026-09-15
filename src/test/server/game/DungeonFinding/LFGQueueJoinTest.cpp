/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
 * or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License
 * for more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "GameTime.h"
#include "Group.h"
#include "IntegrationTestFixture.h"
#include "LFGMgr.h"
#include "RBAC.h"
#include "SpellAuras.h"
#include "SpellInfoTestHelper.h"

#ifndef TEST_F
#define TEST_F(fixture, name) void fixture##_##name()
#endif

namespace lfg
{
namespace
{
constexpr uint32 SPECIFIC_DUNGEON = 900001;
constexpr uint32 RANDOM_DUNGEON = 900002;

class QueueTestGroup : public Group
{
public:
    QueueTestGroup(Player* leader, Player* member, bool continuing)
    {
        m_guid = ObjectGuid::Create<HighGuid::Group>(900001);
        m_leaderGuid = leader->GetGUID();
        m_groupType = continuing ? GROUPTYPE_LFG : GROUPTYPE_NORMAL;
        for (Player* player : { leader, member })
        {
            m_memberSlots.push_back({ player->GetGUID(), player->GetName(), 0, 0, 0 });
            player->SetGroup(this, 0);
        }
    }
};
}

// Exercise JoinLfg itself with private dungeon fixtures, without loading a world database.
class LFGQueueJoinTest : public IntegrationTestFixture
{
protected:
    void SetUp() override
    {
        IntegrationTestFixture::SetUp();
        _manager = new LFGMgr();
        LFGDungeonData dungeon;
        dungeon.id = SPECIFIC_DUNGEON;
        dungeon.type = LFG_TYPE_DUNGEON;
        _manager->LfgDungeonStore.emplace(dungeon.id, dungeon);
        dungeon.id = RANDOM_DUNGEON;
        dungeon.type = LFG_TYPE_RANDOM;
        _manager->LfgDungeonStore.emplace(dungeon.id, dungeon);
        _manager->CachedDungeonMapStore[0].insert(SPECIFIC_DUNGEON);
        _cooldownSpell = SpellInfoBuilder().WithId(LFG_SPELL_DUNGEON_COOLDOWN)
            .WithEffect(0, SPELL_EFFECT_APPLY_AURA, SPELL_AURA_DUMMY).BuildUnique();
    }

    void TearDown() override
    {
        for (Player* player : _players)
        {
            player->SetGroup(nullptr);
            player->RemoveAllAuras();
        }
        _group.reset();
        delete _manager;
        IntegrationTestFixture::TearDown();
    }

    TestPlayer* NewPlayer()
    {
        TestPlayer* player = CreateTestPlayer(900001 + _players.size());
        player->SetMaxHealth(100);
        player->SetHealth(100);
        // Seed this session only, without changing the global permission store or accessing the DB.
        auto& permissions = const_cast<rbac::RBACPermissionContainer&>(player->GetSession()->GetRBACData()->GetPermissions());
        permissions.insert(rbac::RBAC_PERM_JOIN_DUNGEON_FINDER);
        _players.push_back(player);
        return player;
    }

    void AddRunCooldown(Player* player)
    {
        Aura* aura = Aura::TryCreate(_cooldownSpell.get(), 1, player, player);
        ASSERT_NE(aura, nullptr);
        aura->SetMaxDuration(15 * MINUTE * IN_MILLISECONDS);
        aura->SetDuration(aura->GetMaxDuration());
        aura->ApplyForTargets();
        ASSERT_TRUE(player->HasAura(LFG_SPELL_DUNGEON_COOLDOWN));
    }

    void SetDeclineExpiry(Player* player, time_t expiresAt)
    {
        _manager->PlayersStore[player->GetGUID()].SetDeclineCooldown(expiresAt);
    }

    bool HasDeclineCooldown(Player* player, time_t now)
    {
        return _manager->PlayersStore[player->GetGUID()].HasDeclineCooldown(now);
    }

    void RemoveTestProposal(Player* player, LfgAnswer answer, LfgUpdateType reason)
    {
        LfgProposal proposal(SPECIFIC_DUNGEON);
        proposal.players[player->GetGUID()].accept = answer;
        auto [itr, inserted] = _manager->ProposalsStore.emplace(1, proposal);
        ASSERT_TRUE(inserted);
        _manager->RemoveProposal(itr, reason);
    }

    LfgState Join(Player* player, uint32 dungeon)
    {
        LfgDungeonSet dungeons{ dungeon };
        _manager->JoinLfg(player, PLAYER_ROLE_DAMAGE, dungeons, "");
        return _manager->GetState(player->GetGUID());
    }

    void MakeGroup(Player* leader, Player* member, bool continuing = false)
    {
        _group = std::make_unique<QueueTestGroup>(leader, member, continuing);
        if (continuing)
        {
            _manager->SetDungeon(_group->GetGUID(), SPECIFIC_DUNGEON);
            _manager->SetState(_group->GetGUID(), LFG_STATE_DUNGEON);
        }
    }

    LFGMgr* _manager = nullptr;
    std::vector<Player*> _players;
    std::unique_ptr<QueueTestGroup> _group;
    std::unique_ptr<SpellInfo> _cooldownSpell;
};

TEST_F(LFGQueueJoinTest, DeclineBlocksSpecificAndRandomQueuesWithoutAnAura)
{
    Player* player = NewPlayer();
    time_t const now = GameTime::GetGameTime().count();
    // Test players are not registered in ObjectAccessor, as with a disconnected proposal member.
    RemoveTestProposal(player, LFG_ANSWER_DENY, LFG_UPDATETYPE_PROPOSAL_DECLINED);
    EXPECT_TRUE(HasDeclineCooldown(player, now + LFG_TIME_DECLINE_COOLDOWN - 1));
    EXPECT_FALSE(HasDeclineCooldown(player, now + LFG_TIME_DECLINE_COOLDOWN));
    EXPECT_EQ(Join(player, SPECIFIC_DUNGEON), LFG_STATE_NONE);
    EXPECT_EQ(Join(player, RANDOM_DUNGEON), LFG_STATE_NONE);

    SetDeclineExpiry(player, now);
    EXPECT_EQ(Join(player, SPECIFIC_DUNGEON), LFG_STATE_QUEUED);
    _manager->LeaveLfg(player->GetGUID());
    EXPECT_EQ(Join(player, RANDOM_DUNGEON), LFG_STATE_QUEUED);
}

TEST_F(LFGQueueJoinTest, ProposalTimeoutAlsoBlocksSpecificQueues)
{
    Player* player = NewPlayer();
    RemoveTestProposal(player, LFG_ANSWER_PENDING, LFG_UPDATETYPE_PROPOSAL_FAILED);
    EXPECT_EQ(Join(player, SPECIFIC_DUNGEON), LFG_STATE_NONE);
    EXPECT_TRUE(HasDeclineCooldown(player, GameTime::GetGameTime().count()));
}

TEST_F(LFGQueueJoinTest, AcceptedProposalDoesNotApplyDeclinePenalty)
{
    Player* player = NewPlayer();
    RemoveTestProposal(player, LFG_ANSWER_AGREE, LFG_UPDATETYPE_PROPOSAL_DECLINED);
    EXPECT_FALSE(HasDeclineCooldown(player, GameTime::GetGameTime().count()));
    EXPECT_EQ(Join(player, SPECIFIC_DUNGEON), LFG_STATE_QUEUED);
}

TEST_F(LFGQueueJoinTest, RandomRunCooldownDoesNotBlockSpecificQueues)
{
    Player* player = NewPlayer();
    AddRunCooldown(player);
    // Same surviving aura after a vote kick, leaving a depleted group, or missing dungeon completion.
    EXPECT_EQ(Join(player, RANDOM_DUNGEON), LFG_STATE_NONE);
    EXPECT_EQ(Join(player, SPECIFIC_DUNGEON), LFG_STATE_QUEUED);
}

TEST_F(LFGQueueJoinTest, ExpiredDeclineDoesNotBypassRemainingRandomRunCooldown)
{
    Player* player = NewPlayer();
    AddRunCooldown(player);
    SetDeclineExpiry(player, GameTime::GetGameTime().count());
    EXPECT_EQ(Join(player, RANDOM_DUNGEON), LFG_STATE_NONE);
    EXPECT_EQ(Join(player, SPECIFIC_DUNGEON), LFG_STATE_QUEUED);
}

TEST_F(LFGQueueJoinTest, GroupMemberDeclineBlocksBothQueuesUntilExpiry)
{
    Player* leader = NewPlayer();
    Player* member = NewPlayer();
    MakeGroup(leader, member);
    time_t const now = GameTime::GetGameTime().count();
    SetDeclineExpiry(member, now + LFG_TIME_DECLINE_COOLDOWN);
    EXPECT_EQ(Join(leader, SPECIFIC_DUNGEON), LFG_STATE_NONE);
    EXPECT_EQ(Join(leader, RANDOM_DUNGEON), LFG_STATE_NONE);

    SetDeclineExpiry(member, now);
    EXPECT_EQ(Join(leader, SPECIFIC_DUNGEON), LFG_STATE_ROLECHECK);
}

TEST_F(LFGQueueJoinTest, GroupMemberRunCooldownOnlyBlocksRandomQueues)
{
    Player* leader = NewPlayer();
    Player* member = NewPlayer();
    MakeGroup(leader, member);
    AddRunCooldown(member);
    EXPECT_EQ(Join(leader, RANDOM_DUNGEON), LFG_STATE_NONE);
    EXPECT_EQ(Join(leader, SPECIFIC_DUNGEON), LFG_STATE_ROLECHECK);
}

TEST_F(LFGQueueJoinTest, ContinuingDungeonIgnoresLeaderAndMemberCooldowns)
{
    Player* leader = NewPlayer();
    Player* member = NewPlayer();
    MakeGroup(leader, member, true);
    for (Player* player : { leader, member })
    {
        AddRunCooldown(player);
        SetDeclineExpiry(player, GameTime::GetGameTime().count() + LFG_TIME_DECLINE_COOLDOWN);
    }
    EXPECT_EQ(Join(leader, SPECIFIC_DUNGEON), LFG_STATE_ROLECHECK);
}

TEST_F(LFGQueueJoinTest, QueueStateResetDoesNotClearDeclinePenalty)
{
    Player* player = NewPlayer();
    SetDeclineExpiry(player, GameTime::GetGameTime().count() + LFG_TIME_DECLINE_COOLDOWN);
    _manager->SetState(player->GetGUID(), LFG_STATE_NONE);
    _manager->LeaveLfg(player->GetGUID());
    EXPECT_EQ(Join(player, SPECIFIC_DUNGEON), LFG_STATE_NONE);
    EXPECT_TRUE(HasDeclineCooldown(player, GameTime::GetGameTime().count()));
}
}

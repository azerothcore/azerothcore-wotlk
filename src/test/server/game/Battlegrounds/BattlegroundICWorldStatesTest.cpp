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

#include "BattlegroundIC.h"
#include "ScriptMgr.h"
#include "ScriptDefines/AllBattlegroundScript.h"
#include "WorldMock.h"
#include "WorldStatePackets.h"
#include "gtest/gtest.h"
#include <array>
#include <map>

// Issue: https://github.com/azerothcore/azerothcore-wotlk/issues/24438
// Exercise the actual initial packet builder without requiring a live battleground.
class BattlegroundICWorldStatesTest : public ::testing::Test
{
protected:
    using NodeStates = std::array<ICNodeState, MAX_NODE_TYPES>;
    using GateStates = std::array<bool, MAX_FORTRESS_GATES_SPAWNS>;
    using WorldStates = std::map<int32, int32>;

    static constexpr NodeStates InitialNodes = { NODE_STATE_UNCONTROLLED, NODE_STATE_UNCONTROLLED,
        NODE_STATE_UNCONTROLLED, NODE_STATE_UNCONTROLLED, NODE_STATE_UNCONTROLLED,
        NODE_STATE_CONTROLLED_A, NODE_STATE_CONTROLLED_H };

    void SetUp() override
    {
        ScriptRegistry<BGScript>::InitEnabledHooksIfNeeded(ALLBATTLEGROUNDHOOK_END);
        _previousWorld = std::move(sWorld);
        sWorld = std::make_unique<::testing::NiceMock<WorldMock>>();
    }

    void TearDown() override
    {
        sWorld = std::move(_previousWorld);
    }

    static void SetMatchState(BattlegroundIC& bg, NodeStates const& nodes, GateStates const& gates)
    {
        for (uint8 i = 0; i < MAX_NODE_TYPES; ++i)
            bg.nodePoint[i].nodeState = nodes[i];

        for (uint8 i = 0; i < MAX_FORTRESS_GATES_SPAWNS; ++i)
            bg.GateStatus[bg.GetGateIDFromEntry(BG_IC_ObjSpawnlocs[i].entry)] =
                gates[i] ? BG_IC_GATE_DESTROYED : BG_IC_GATE_OK;
    }

    static WorldStates ReadSnapshot(BattlegroundIC& bg)
    {
        WorldPackets::WorldState::InitWorldStates packet;
        bg.FillInitialWorldStates(packet);

        WorldStates states;
        for (auto const& state : packet.Worldstates)
            EXPECT_TRUE(states.emplace(state.VariableID, state.Value).second)
                << "Duplicate world state " << state.VariableID;

        EXPECT_EQ(states.size(), 4u + MAX_FORTRESS_GATES_SPAWNS * 2u + MAX_NODE_TYPES * 5u);
        return states;
    }

    static void ExpectSnapshot(BattlegroundIC& bg, WorldStates const& states,
        NodeStates const& nodes, GateStates const& gates)
    {
        auto expectState = [&](uint32 id, int32 expected)
        {
            auto itr = states.find(id);
            ASSERT_NE(itr, states.end()) << "Missing world state " << id;
            EXPECT_EQ(itr->second, expected) << "World state " << id;
        };

        expectState(WORLD_STATE_BATTLEGROUND_IC_ALLIANCE_REINFORCEMENT_SET, 1);
        expectState(WORLD_STATE_BATTLEGROUND_IC_HORDE_REINFORCEMENT_SET, 1);
        expectState(WORLD_STATE_BATTLEGROUND_IC_ALLIANCE_REINFORCEMENT, MAX_REINFORCEMENTS);
        expectState(WORLD_STATE_BATTLEGROUND_IC_HORDE_REINFORCEMENT, MAX_REINFORCEMENTS);

        for (uint8 i = 0; i < MAX_NODE_TYPES; ++i)
            for (uint8 state = NODE_STATE_UNCONTROLLED; state <= NODE_STATE_CONTROLLED_H; ++state)
                expectState(nodePointInitial[i].worldStates[state], state == nodes[i]);

        for (uint8 i = 0; i < MAX_FORTRESS_GATES_SPAWNS; ++i)
        {
            uint32 entry = BG_IC_ObjSpawnlocs[i].entry;
            expectState(bg.GetWorldStateFromGateEntry(entry, false), !gates[i]);
            expectState(bg.GetWorldStateFromGateEntry(entry, true), gates[i]);
        }
    }

    std::unique_ptr<IWorld> _previousWorld;
};

TEST_F(BattlegroundICWorldStatesTest, FreshMatchExplicitlyClearsInactiveIcons)
{
    BattlegroundIC bg;
    ExpectSnapshot(bg, ReadSnapshot(bg), InitialNodes, GateStates{});
}

TEST_F(BattlegroundICWorldStatesTest, LateJoinPreservesContestedAndCapturedNodesAndDestroyedGates)
{
    BattlegroundIC bg;
    NodeStates nodes = { NODE_STATE_CONTROLLED_H, NODE_STATE_CONFLICT_A, NODE_STATE_CONTROLLED_A,
        NODE_STATE_CONFLICT_H, NODE_STATE_UNCONTROLLED, NODE_STATE_CONTROLLED_H, NODE_STATE_CONTROLLED_A };
    GateStates gates = { true, false, true, false, true, false };
    SetMatchState(bg, nodes, gates);

    ExpectSnapshot(bg, ReadSnapshot(bg), nodes, gates);
}

TEST_F(BattlegroundICWorldStatesTest, FreshMatchOverridesPreviousMatchSnapshot)
{
    BattlegroundIC previous;
    NodeStates nodes;
    nodes.fill(NODE_STATE_CONTROLLED_H);
    GateStates gates;
    gates.fill(true);
    SetMatchState(previous, nodes, gates);
    WorldStates clientStates = ReadSnapshot(previous);

    // Retain the old snapshot as a client can when entering another match.
    BattlegroundIC fresh;
    for (auto const& [id, value] : ReadSnapshot(fresh))
        clientStates[id] = value;

    ExpectSnapshot(fresh, clientStates, InitialNodes, GateStates{});
}

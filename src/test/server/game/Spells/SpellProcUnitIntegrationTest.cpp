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

#include "IntegrationTestFixture.h"
#include "ProcEventInfoHelper.h"
#include "SpellInfoTestHelper.h"
#include "SpellMgr.h"
#include "gtest/gtest.h"

#ifndef TEST_F
#define TEST_F(fixture, name) void fixture##_##name()
#endif

namespace
{

class ProcUnitIntegrationTest : public IntegrationTestFixture
{
};

TEST_F(ProcUnitIntegrationTest, CreatureAndPlayerAreHostile)
{
    auto* player = CreateTestPlayer(1, "Hostile", SEC_PLAYER);
    // Player faction defaults to 0, set it to our test faction
    player->SetUInt32Value(UNIT_FIELD_FACTIONTEMPLATE, TEST_FACTION_HOSTILE_TO_MONSTERS);

    auto* creature = CreateTestCreature(100, 99001, TEST_FACTION_HOSTILE_TO_ALL);

    ReputationRank reaction = player->GetReactionTo(creature);
    EXPECT_EQ(reaction, REP_HOSTILE);

    ReputationRank reverseReaction = creature->GetReactionTo(player);
    EXPECT_EQ(reverseReaction, REP_HOSTILE);
}

TEST_F(ProcUnitIntegrationTest, ProcEventInfoWithRealUnits)
{
    auto* attacker = CreateTestPlayer(1, "Attacker", SEC_PLAYER);
    auto* victim = CreateTestCreature(100, 99001, TEST_FACTION_HOSTILE_TO_ALL);

    auto procInfo = ProcEventInfoBuilder()
        .WithActor(attacker)
        .WithActionTarget(victim)
        .WithProcTarget(victim)
        .WithTypeMask(PROC_FLAG_DONE_MELEE_AUTO_ATTACK)
        .WithSpellTypeMask(PROC_SPELL_TYPE_DAMAGE)
        .WithSpellPhaseMask(PROC_SPELL_PHASE_HIT)
        .WithHitMask(PROC_HIT_NORMAL)
        .Build();

    EXPECT_EQ(procInfo.GetActor(), attacker);
    EXPECT_EQ(procInfo.GetActionTarget(), victim);
    EXPECT_EQ(procInfo.GetProcTarget(), victim);
    EXPECT_EQ(procInfo.GetTypeMask(), uint32(PROC_FLAG_DONE_MELEE_AUTO_ATTACK));
}

TEST_F(ProcUnitIntegrationTest, ProcEntryMatchesSpellInfo)
{
    auto spellInfo = SpellInfoBuilder()
        .WithId(99999)
        .WithSpellFamilyName(SPELLFAMILY_GENERIC)
        .WithProcFlags(PROC_FLAG_DONE_MELEE_AUTO_ATTACK)
        .WithProcChance(100)
        .WithEffect(0, SPELL_EFFECT_APPLY_AURA, SPELL_AURA_PROC_TRIGGER_SPELL)
        .BuildUnique();

    auto procEntry = SpellProcEntryBuilder()
        .WithProcFlags(PROC_FLAG_DONE_MELEE_AUTO_ATTACK)
        .WithSpellTypeMask(PROC_SPELL_TYPE_DAMAGE)
        .WithSpellPhaseMask(PROC_SPELL_PHASE_HIT)
        .WithHitMask(PROC_HIT_NORMAL)
        .WithChance(100.0f)
        .Build();

    EXPECT_EQ(spellInfo->Id, 99999u);
    EXPECT_EQ(spellInfo->ProcFlags, uint32(PROC_FLAG_DONE_MELEE_AUTO_ATTACK));
    EXPECT_EQ(procEntry.ProcFlags, uint32(PROC_FLAG_DONE_MELEE_AUTO_ATTACK));
    EXPECT_FLOAT_EQ(procEntry.Chance, 100.0f);
}

TEST_F(ProcUnitIntegrationTest, MultipleCreaturesCanBeCreated)
{
    auto* player = CreateTestPlayer(1, "Attacker", SEC_PLAYER);
    auto* creature1 = CreateTestCreature(100, 99001, TEST_FACTION_HOSTILE_TO_ALL);
    auto* creature2 = CreateTestCreature(101, 99002, TEST_FACTION_HOSTILE_TO_ALL);

    EXPECT_NE(creature1, creature2);
    EXPECT_NE(creature1->GetGUID(), creature2->GetGUID());
    EXPECT_EQ(creature1->GetHealth(), 10000u);
    EXPECT_EQ(creature2->GetHealth(), 10000u);
    EXPECT_NE(player->GetGUID(), creature1->GetGUID());
}

TEST_F(ProcUnitIntegrationTest, ProcOnKillWithRealUnits)
{
    auto* attacker = CreateTestPlayer(1, "Killer", SEC_PLAYER);
    auto* victim = CreateTestCreature(100, 99001, TEST_FACTION_HOSTILE_TO_ALL);

    // Build a kill-proc event
    auto procInfo = ProcEventInfoBuilder()
        .WithActor(attacker)
        .WithActionTarget(victim)
        .WithProcTarget(victim)
        .WithTypeMask(PROC_FLAG_KILL)
        .WithSpellTypeMask(PROC_SPELL_TYPE_NONE)
        .WithSpellPhaseMask(PROC_SPELL_PHASE_NONE)
        .WithHitMask(PROC_HIT_NORMAL)
        .Build();

    EXPECT_EQ(procInfo.GetTypeMask(), uint32(PROC_FLAG_KILL));
    EXPECT_EQ(procInfo.GetActor(), attacker);
    EXPECT_EQ(procInfo.GetActionTarget(), victim);
}

TEST_F(ProcUnitIntegrationTest, CreatureHealthCanBeManipulated)
{
    auto* creature = CreateTestCreature(100, 99001, TEST_FACTION_HOSTILE_TO_ALL);

    EXPECT_EQ(creature->GetHealth(), 10000u);
    EXPECT_EQ(creature->GetMaxHealth(), 10000u);

    creature->SetHealth(1);
    EXPECT_EQ(creature->GetHealth(), 1u);

    creature->SetHealth(0);
    EXPECT_EQ(creature->GetHealth(), 0u);
}

TEST_F(ProcUnitIntegrationTest, FactionHostilityIsSymmetric)
{
    auto* c1 = CreateTestCreature(100, 99001, TEST_FACTION_HOSTILE_TO_MONSTERS);
    auto* c2 = CreateTestCreature(101, 99002, TEST_FACTION_HOSTILE_TO_ALL);

    // c2 (monster mask=8) hostile to c1's mask (player mask=1): yes
    // c1 (player mask=1) hostile to c2's mask (monster mask=8): yes
    ReputationRank r1 = c1->GetReactionTo(c2);
    ReputationRank r2 = c2->GetReactionTo(c1);

    EXPECT_EQ(r1, REP_HOSTILE);
    EXPECT_EQ(r2, REP_HOSTILE);
}

} // namespace

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

#include "CreatureAI.h"
#include "IntegrationTestFixture.h"
#include "SpellAuraEffects.h"
#include "SpellAuras.h"
#include "SpellInfoTestHelper.h"
#include "gtest/gtest.h"

#ifndef TEST_F
#define TEST_F(fixture, name) void fixture##_##name()
#endif

/*
 * Unit::IsCausingPeriodicTick lets a CreatureAI::CalculateThreat override
 * tell the threat of a DoT or HoT tick from the threat of an action of the
 * unit (Bloodlord Mandokir's Threatening Gaze ignores the ticks).
 */

namespace
{

constexpr uint32 DOT_SPELL_ID = 900101;
constexpr uint32 HOT_SPELL_ID = 900102;
constexpr int32 TICK_AMOUNT = 100;
constexpr int32 AURA_DURATION = 15 * IN_MILLISECONDS;

class TickRecordingAI : public CreatureAI
{
public:
    explicit TickRecordingAI(Creature* creature) : CreatureAI(creature) { }

    void UpdateAI(uint32 /*diff*/) override { }

    void CalculateThreat(Unit* hatedUnit, float& /*threat*/, SpellInfo const* /*threatSpell*/) override
    {
        ++Calls;
        LastUnit = hatedUnit;
        LastWasTick = hatedUnit->IsCausingPeriodicTick();
    }

    int Calls = 0;
    Unit* LastUnit = nullptr;
    bool LastWasTick = false;
};

class PeriodicTickThreatTest : public IntegrationTestFixture
{
protected:
    void SetUp() override
    {
        IntegrationTestFixture::SetUp();

        _durationEntry = {};
        _durationEntry.ID = 1;
        _durationEntry.Duration[0] = AURA_DURATION;
        _durationEntry.Duration[1] = AURA_DURATION;
        _durationEntry.Duration[2] = AURA_DURATION;

        _dotInfo = SpellInfoBuilder()
            .WithId(DOT_SPELL_ID)
            .WithSchoolMask(SPELL_SCHOOL_MASK_SHADOW)
            .WithDmgClass(SPELL_DAMAGE_CLASS_MAGIC)
            .WithEffect(0, SPELL_EFFECT_APPLY_AURA, SPELL_AURA_PERIODIC_DAMAGE)
            .WithEffectBasePoints(0, TICK_AMOUNT)
            .BuildUnique();
        const_cast<SpellInfo*>(_dotInfo.get())->DurationEntry = &_durationEntry;

        _hotInfo = SpellInfoBuilder()
            .WithId(HOT_SPELL_ID)
            .WithSchoolMask(SPELL_SCHOOL_MASK_HOLY)
            .WithDmgClass(SPELL_DAMAGE_CLASS_MAGIC)
            .WithEffect(0, SPELL_EFFECT_APPLY_AURA, SPELL_AURA_PERIODIC_HEAL)
            .WithEffectBasePoints(0, TICK_AMOUNT)
            .BuildUnique();
        const_cast<SpellInfo*>(_hotInfo.get())->DurationEntry = &_durationEntry;

        _player = CreateTestPlayer(1, "Gazed");
        _player->SetFaction(TEST_FACTION_HOSTILE_TO_MONSTERS);
        _player->SetMaxHealth(10000);
        _player->SetHealth(5000);

        _creature = CreateTestCreature(2, 12345, TEST_FACTION_HOSTILE_TO_ALL);
        _ai = new TickRecordingAI(_creature);
        _creature->SetAI(_ai);
        _creature->IsAIEnabled = true;

        // An action of the player: the creature now has them on its threat list
        _creature->GetThreatMgr().AddThreat(_player, 1.0f);
    }

    void TearDown() override
    {
        _creature->RemoveAllAuras();
        _player->RemoveAllAuras();
        IntegrationTestFixture::TearDown();
    }

    static void Tick(Aura* aura, Unit* target, Unit* caster)
    {
        aura->GetEffect(EFFECT_0)->PeriodicTick(aura->GetApplicationOfTarget(target->GetGUID()), caster);
    }

    SpellDurationEntry _durationEntry;
    std::unique_ptr<SpellInfo> _dotInfo;
    std::unique_ptr<SpellInfo> _hotInfo;
    TestPlayer* _player = nullptr;
    TestCreature* _creature = nullptr;
    TickRecordingAI* _ai = nullptr;
};

TEST_F(PeriodicTickThreatTest, DirectThreatIsNotATick)
{
    EXPECT_EQ(_ai->Calls, 1);
    EXPECT_EQ(_ai->LastUnit, _player);
    EXPECT_FALSE(_ai->LastWasTick);
}

TEST_F(PeriodicTickThreatTest, DotTickIsATick)
{
    Aura* dot = _player->AddAura(_dotInfo.get(), 1, _creature);
    ASSERT_NE(dot, nullptr);
    int const callsBefore = _ai->Calls;

    Tick(dot, _creature, _player);

    EXPECT_EQ(_ai->Calls, callsBefore + 1);
    EXPECT_EQ(_ai->LastUnit, _player);
    EXPECT_TRUE(_ai->LastWasTick);
    EXPECT_FALSE(_player->IsCausingPeriodicTick());
}

TEST_F(PeriodicTickThreatTest, HotTickIsATick)
{
    Aura* hot = _player->AddAura(_hotInfo.get(), 1, _player);
    ASSERT_NE(hot, nullptr);
    int const callsBefore = _ai->Calls;

    Tick(hot, _player, _player);

    EXPECT_EQ(_ai->Calls, callsBefore + 1);
    EXPECT_EQ(_ai->LastUnit, _player);
    EXPECT_TRUE(_ai->LastWasTick);
    EXPECT_FALSE(_player->IsCausingPeriodicTick());
}

TEST_F(PeriodicTickThreatTest, ThreatAfterATickIsNotATick)
{
    Aura* dot = _player->AddAura(_dotInfo.get(), 1, _creature);
    ASSERT_NE(dot, nullptr);
    Tick(dot, _creature, _player);

    _creature->GetThreatMgr().AddThreat(_player, 1.0f);

    EXPECT_FALSE(_ai->LastWasTick);
}

} // namespace

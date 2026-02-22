/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify it under
 * the terms of the GNU General Public License as published by the Free Software
 * Foundation; either version 2 of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License along with
 * this program. If not, see <http://www.gnu.org/licenses/>.
 */

#ifndef TEST_CREATURE_H
#define TEST_CREATURE_H

#include "Creature.h"
#include "CreatureData.h"
#include "ObjectGuid.h"

class TestMap;

/**
 * TestCreature - A test harness for Creature that bypasses database dependencies.
 *
 * Usage:
 *   TestCreature* creature = new TestCreature();
 *   creature->ForceInitValues(1, 12345);  // guidLow, entry
 *   creature->SetTestMap(testMap);
 *   creature->SetAlive(true);
 *   creature->SetupForCombatTest();  // Sets up all necessary state for combat/threat tests
 */
class TestCreature : public Creature
{
public:
    TestCreature();
    ~TestCreature() override;

    // Override methods that require database/world access
    void UpdateObjectVisibility(bool /*forced*/ = true, bool /*fromUpdate*/ = false) override { }
    void AddToWorld() override { }
    void RemoveFromWorld() override { }

    // Force initialization without database
    void ForceInitValues(ObjectGuid::LowType guidLow, uint32 entry);

    // Test control methods
    void SetTestMap(Map* map);

    // Set alive state (affects m_deathState)
    void SetAlive(bool alive);

    // Set in-world state (affects m_inWorld)
    void SetInWorld(bool inWorld);

    // Set phase mask for phase checks
    void SetPhase(uint32 phase);

    // Set faction for friendliness checks
    // Use hostile factions (14 = hostile monster) for combat tests
    void SetHostileFaction() { SetFaction(14); }
    void SetFriendlyFaction() { SetFaction(35); }
    void SetFaction(uint32 faction);

    // Complete setup for combat/threat testing
    // Sets creature to be alive, in-world, hostile, and initializes managers
    void SetupForCombatTest(Map* map, ObjectGuid::LowType guidLow, uint32 entry);

    // Initialize ThreatManager for testing
    void InitializeThreatManager();

    // Access managers directly for testing
    ThreatManager& TestGetThreatMgr() { return m_threatManager; }
    CombatManager& TestGetCombatMgr() { return m_combatManager; }

    // Clear all combat state for cleanup
    void CleanupCombatState();

private:
    Map* _testMap = nullptr;
    static CreatureTemplate* _fakeCreatureTemplate;
    static bool _fakeTemplateInitialized;
};

#endif // TEST_CREATURE_H

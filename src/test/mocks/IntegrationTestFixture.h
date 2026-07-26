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

#ifndef AZEROTHCORE_INTEGRATION_TEST_FIXTURE_H
#define AZEROTHCORE_INTEGRATION_TEST_FIXTURE_H

#include "TestMap.h"
#include "TestPlayer.h"
#include "TestCreature.h"
#include "WorldMock.h"
#include "WorldSession.h"
#include "DBCStores.h"
#include "SharedDefines.h"
#include "gmock/gmock.h"
#include "gtest/gtest.h"
#include <vector>

using namespace testing;

// Faction template IDs for test creatures
static constexpr uint32 TEST_FACTION_HOSTILE_TO_MONSTERS = 90001;
static constexpr uint32 TEST_FACTION_HOSTILE_TO_ALL      = 90002;

class IntegrationTestFixture : public ::testing::Test
{
protected:
    void SetUp() override
    {
        TestMap::EnsureDBC();
        EnsureFactionTemplates();

        _originalWorld = sWorld.release();
        _worldMock = new NiceMock<WorldMock>();
        sWorld.reset(_worldMock);

        static std::string emptyString;
        ON_CALL(*_worldMock, GetDataPath()).WillByDefault(ReturnRef(emptyString));
        ON_CALL(*_worldMock, GetRealmName()).WillByDefault(ReturnRef(emptyString));
        ON_CALL(*_worldMock, GetDefaultDbcLocale()).WillByDefault(Return(LOCALE_enUS));
        ON_CALL(*_worldMock, getRate(_)).WillByDefault(Return(1.0f));
        ON_CALL(*_worldMock, getBoolConfig(_)).WillByDefault(Return(false));
        ON_CALL(*_worldMock, getIntConfig(_)).WillByDefault(Return(0));
        ON_CALL(*_worldMock, getFloatConfig(_)).WillByDefault(Return(0.0f));
        ON_CALL(*_worldMock, GetPlayerSecurityLimit()).WillByDefault(Return(SEC_PLAYER));

        _testMap = new TestMap();
    }

    void TearDown() override
    {
        for (auto* creature : _trackedCreatures)
        {
            if (creature->IsInWorld())
                creature->RemoveFromWorld();
            delete creature;
        }
        _trackedCreatures.clear();

        for (auto* player : _trackedPlayers)
        {
            if (player->IsInWorld())
                player->RemoveFromWorld();
        }
        _trackedPlayers.clear();

        for (auto* tmpl : _ownedCreatureTemplates)
            delete tmpl;
        _ownedCreatureTemplates.clear();

        delete _testMap;
        _testMap = nullptr;

        IWorld* currentWorld = sWorld.release();
        delete currentWorld;
        _worldMock = nullptr;

        sWorld.reset(_originalWorld);
        _originalWorld = nullptr;

        // Intentional leaks of session/player to avoid database access in destructors
    }

    TestPlayer* CreateTestPlayer(ObjectGuid::LowType guidLow = 1,
                                 std::string const& name = "TestPlayer",
                                 AccountTypes security = SEC_PLAYER)
    {
        auto* session = new WorldSession(guidLow, std::string(name), 0, nullptr, security,
            EXPANSION_WRATH_OF_THE_LICH_KING, 0, LOCALE_enUS, 0, false, false, 0);
        // Pre-allocate RBAC data so Player's ctor (which calls
        // GetSession()->HasPermission) doesn't try to load from DB.
        session->InitRBACDataForTest();

        auto* player = new TestPlayer(session);
        player->ForceInitValues(guidLow);
        session->SetPlayer(player);
        player->SetSession(session);
        player->SetMap(_testMap);
        player->AddToWorld();
        _trackedPlayers.push_back(player);

        return player;
    }

    TestCreature* CreateTestCreature(ObjectGuid::LowType guidLow, uint32 entry, uint32 factionId)
    {
        // CreatureTemplate must be heap-allocated AFTER WorldMock is installed
        // because CreatureMovementData() constructor calls sWorld->getIntConfig()
        auto* tmpl = new CreatureTemplate();
        tmpl->Entry = entry;
        tmpl->faction = factionId;
        tmpl->minlevel = 80;
        tmpl->maxlevel = 80;
        tmpl->unit_class = CLASS_WARRIOR;
        tmpl->DamageModifier = 1.0f;
        tmpl->BaseAttackTime = 2000;
        tmpl->RangeAttackTime = 2000;
        tmpl->BaseVariance = 1.0f;
        tmpl->RangeVariance = 1.0f;
        tmpl->ModHealth = 1.0f;
        _ownedCreatureTemplates.push_back(tmpl);

        auto* creature = new TestCreature();
        creature->ForceInitValues(guidLow, entry);
        creature->SetTestMap(_testMap);
        creature->SetInWorld(true);
        creature->SetAlive(true);
        creature->SetPhase(1);
        creature->SetFaction(factionId);
        creature->SetLevel(80);
        creature->SetMaxHealth(10000);
        creature->SetHealth(10000);
        creature->InitializeThreatManager();
        _trackedCreatures.push_back(creature);

        return creature;
    }

    NiceMock<WorldMock>* GetWorldMock() { return _worldMock; }
    TestMap* GetTestMap() { return _testMap; }

private:
    static void EnsureFactionTemplates()
    {
        static bool initialized = false;
        if (initialized)
            return;
        initialized = true;

        // Faction 90001: "player-like" — ourMask=1 (FACTION_MASK_PLAYER), hostile to monsters (hostileMask=8)
        auto* f1 = new FactionTemplateEntry();
        std::memset(f1, 0, sizeof(FactionTemplateEntry));
        f1->ID = TEST_FACTION_HOSTILE_TO_MONSTERS;
        f1->faction = TEST_FACTION_HOSTILE_TO_MONSTERS;
        f1->ourMask = 0x1;       // FACTION_MASK_PLAYER
        f1->friendlyMask = 0x1;  // friendly to players
        f1->hostileMask = 0x8;   // hostile to monsters
        sFactionTemplateStore.SetEntry(TEST_FACTION_HOSTILE_TO_MONSTERS, f1);

        // Faction 90002: "monster" — ourMask=8 (FACTION_MASK_MONSTER), hostile to players (hostileMask=1)
        auto* f2 = new FactionTemplateEntry();
        std::memset(f2, 0, sizeof(FactionTemplateEntry));
        f2->ID = TEST_FACTION_HOSTILE_TO_ALL;
        f2->faction = TEST_FACTION_HOSTILE_TO_ALL;
        f2->ourMask = 0x8;       // FACTION_MASK_MONSTER
        f2->friendlyMask = 0x0;  // friendly to none
        f2->hostileMask = 0x1;   // hostile to players
        sFactionTemplateStore.SetEntry(TEST_FACTION_HOSTILE_TO_ALL, f2);
    }

    IWorld* _originalWorld = nullptr;
    NiceMock<WorldMock>* _worldMock = nullptr;
    TestMap* _testMap = nullptr;
    std::vector<TestPlayer*> _trackedPlayers;
    std::vector<TestCreature*> _trackedCreatures;
    std::vector<CreatureTemplate*> _ownedCreatureTemplates;
};

#endif //AZEROTHCORE_INTEGRATION_TEST_FIXTURE_H

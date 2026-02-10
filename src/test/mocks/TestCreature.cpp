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

#include "TestCreature.h"
#include "ThreatManager.h"
#include "CombatManager.h"

// Heap-allocated to avoid static init calling CreatureMovementData()
// which requires sWorld to be set up (calls getIntConfig).
CreatureTemplate* TestCreature::_fakeCreatureTemplate = nullptr;
bool TestCreature::_fakeTemplateInitialized = false;

TestCreature::TestCreature() : Creature()
{
}

TestCreature::~TestCreature()
{
    CleanupCombatState();
}

void TestCreature::CleanupCombatState()
{
    m_threatManager.ClearAllThreat();
    m_combatManager.EndAllCombat();
    // Must remove from world before destruction or ~Object will ABORT
    SetInWorld(false);
}

void TestCreature::ForceInitValues(ObjectGuid::LowType guidLow, uint32 entry)
{
    Object::_Create(guidLow, entry, HighGuid::Unit);

    m_objectType |= TYPEMASK_UNIT;
    m_objectTypeId = TYPEID_UNIT;

    m_originalEntry = entry;

    // Initialize the fake creature template once with safe defaults.
    // Heap-allocated because CreatureMovementData() constructor needs sWorld.
    if (!_fakeTemplateInitialized)
    {
        _fakeCreatureTemplate = new CreatureTemplate();
        _fakeCreatureTemplate->Entry = 0;
        _fakeCreatureTemplate->faction = 14; // hostile monster default
        _fakeCreatureTemplate->unit_class = 1; // CLASS_WARRIOR
        _fakeCreatureTemplate->speed_walk = 1.0f;
        _fakeCreatureTemplate->speed_run = 1.14286f;
        _fakeCreatureTemplate->speed_swim = 1.0f;
        _fakeCreatureTemplate->speed_flight = 1.0f;
        _fakeCreatureTemplate->scale = 1.0f;
        _fakeCreatureTemplate->DamageModifier = 1.0f;
        _fakeCreatureTemplate->BaseAttackTime = 2000;
        _fakeCreatureTemplate->RangeAttackTime = 2000;
        _fakeCreatureTemplate->BaseVariance = 1.0f;
        _fakeCreatureTemplate->RangeVariance = 1.0f;
        _fakeCreatureTemplate->ModHealth = 1.0f;
        _fakeCreatureTemplate->ModMana = 1.0f;
        _fakeCreatureTemplate->ModArmor = 1.0f;
        _fakeCreatureTemplate->ModExperience = 1.0f;
        _fakeCreatureTemplate->HoverHeight = 1.0f;
        _fakeCreatureTemplate->detection_range = 20.0f;
        _fakeCreatureTemplate->flags_extra = 0;
        _fakeCreatureTemplate->unit_flags = 0;
        _fakeCreatureTemplate->unit_flags2 = 0;
        _fakeCreatureTemplate->dynamicflags = 0;
        _fakeCreatureTemplate->type = 0;
        _fakeCreatureTemplate->type_flags = 0;
        // Movement is default-constructed by new CreatureTemplate():
        // Ground=Run, Swim=true -> CanWalk() and CanSwim() return true
        _fakeTemplateInitialized = true;
    }

    m_creatureInfo = _fakeCreatureTemplate;
}

void TestCreature::SetTestMap(Map* map)
{
    _testMap = map;
    // Also set the base class map pointer so GetMap() works
    // through the Unit* base pointer (polymorphic calls)
    WorldObject::SetMap(map);
}

void TestCreature::SetAlive(bool alive)
{
    m_deathState = alive ? DeathState::Alive : DeathState::Dead;
}

void TestCreature::SetInWorld(bool inWorld)
{
    if (inWorld && !Object::IsInWorld())
        Object::AddToWorld();
    else if (!inWorld && Object::IsInWorld())
        Object::RemoveFromWorld();
}

void TestCreature::SetPhase(uint32 phase)
{
    SetPhaseMask(phase, false);
}

void TestCreature::SetFaction(uint32 faction)
{
    // Set faction directly, bypassing Unit::SetFaction which calls
    // UpdateMoveInLineOfSightState() -> sObjectMgr->GetCreatureTemplate()
    SetUInt32Value(UNIT_FIELD_FACTIONTEMPLATE, faction);
}

void TestCreature::SetupForCombatTest(Map* map, ObjectGuid::LowType guidLow, uint32 entry)
{
    ForceInitValues(guidLow, entry);
    // SetTestMap calls WorldObject::SetMap which asserts !IsInWorld(),
    // so we must set map BEFORE SetInWorld
    SetTestMap(map);
    SetInWorld(true);
    SetAlive(true);
    SetPhase(1);
    SetHostileFaction();
    SetIsCombatDisallowed(false);
    ClearUnitState(UNIT_STATE_EVADE);
    ClearUnitState(UNIT_STATE_IN_FLIGHT);
    InitializeThreatManager();
}

void TestCreature::InitializeThreatManager()
{
    m_threatManager.Initialize();
}

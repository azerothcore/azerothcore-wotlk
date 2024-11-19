/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU Affero General Public License as published by the
 * Free Software Foundation; either version 3 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "Vehicle.h"
#include "BattlefieldWG.h"
#include "Log.h"
#include "MoveSplineInit.h"
#include "ObjectMgr.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "TemporarySummon.h"
#include "Unit.h"
#include "Util.h"

Vehicle::Vehicle(Unit* unit, VehicleEntry const* vehInfo, uint32 creatureEntry) :
    _me(unit), _vehicleInfo(vehInfo), _usableSeatNum(0), _creatureEntry(creatureEntry), _status(STATUS_NONE)
{
    for (uint32 i = 0; i < MAX_VEHICLE_SEATS; ++i)
    {
        if (uint32 seatId = _vehicleInfo->m_seatID[i])
            if (VehicleSeatEntry const* veSeat = sVehicleSeatStore.LookupEntry(seatId))
            {
                VehicleSeatAddon const* addon = sObjectMgr->GetVehicleSeatAddon(seatId);
                Seats.insert(std::make_pair(i, VehicleSeat(veSeat, addon)));
                if (veSeat->CanEnterOrExit())
                    ++_usableSeatNum;
            }
    }

    // Set or remove correct flags based on available seats. Will overwrite db data (if wrong).
    if (_usableSeatNum)
        _me->SetNpcFlag((_me->IsPlayer() ? UNIT_NPC_FLAG_PLAYER_VEHICLE : UNIT_NPC_FLAG_SPELLCLICK));
    else
        _me->RemoveNpcFlag((_me->IsPlayer() ? UNIT_NPC_FLAG_PLAYER_VEHICLE : UNIT_NPC_FLAG_SPELLCLICK));

    InitMovementInfoForBase();
}

Vehicle::~Vehicle()
{
    /// @Uninstall must be called before this.
    ASSERT(_status == STATUS_UNINSTALLING);

    for (SeatMap::const_iterator itr = Seats.begin(); itr != Seats.end(); ++itr)
        if (itr->second.Passenger.Guid)
        {
            if (Unit* unit = ObjectAccessor::GetUnit(*_me, itr->second.Passenger.Guid))
            {
                LOG_FATAL("vehicles", "Vehicle(), unit: {}, entry: {}, typeid: {}, this_entry: {}, this_typeid: {}!", unit->GetName(), unit->GetEntry(), unit->GetTypeId(), _me ? _me->GetEntry() : 0, _me ? _me->GetTypeId() : 0);
                unit->_ExitVehicle();
            }
            else
                LOG_FATAL("vehicles", "Vehicle(), unknown guid!");
        }
}

void Vehicle::Install()
{
    if (_me->IsCreature())
    {
        if (PowerDisplayEntry const* powerDisplay = sPowerDisplayStore.LookupEntry(_vehicleInfo->m_powerDisplayId))
            _me->setPowerType(Powers(powerDisplay->PowerType));
        else if (_me->IsClass(CLASS_ROGUE, CLASS_CONTEXT_ABILITY))
            _me->setPowerType(POWER_ENERGY);
    }

    _status = STATUS_INSTALLED;
    if (GetBase()->IsCreature())
        sScriptMgr->OnInstall(this);
}

void Vehicle::InstallAllAccessories(bool evading)
{
    if (GetBase()->IsPlayer() || !evading)
        RemoveAllPassengers();   // We might have aura's saved in the DB with now invalid casters - remove

    VehicleAccessoryList const* accessories = sObjectMgr->GetVehicleAccessoryList(this);
    if (!accessories)
        return;

    for (VehicleAccessoryList::const_iterator itr = accessories->begin(); itr != accessories->end(); ++itr)
        if (!evading || itr->IsMinion)  // only install minions on evade mode
            InstallAccessory(itr->AccessoryEntry, itr->SeatId, itr->IsMinion, itr->SummonedType, itr->SummonTime);
}

void Vehicle::Uninstall()
{
    /// @Prevent recursive uninstall call. (Bad script in OnUninstall/OnRemovePassenger/PassengerBoarded hook.)
    if (_status == STATUS_UNINSTALLING && !GetBase()->HasUnitTypeMask(UNIT_MASK_MINION))
    {
        LOG_ERROR("vehicles", "Vehicle {} attempts to uninstall, but already has STATUS_UNINSTALLING! "
                       "Check Uninstall/PassengerBoarded script hooks for errors.", _me->GetGUID().ToString());
        return;
    }
    _status = STATUS_UNINSTALLING;
    LOG_DEBUG("vehicles", "Vehicle::Uninstall {}", _me->GetGUID().ToString());
    RemoveAllPassengers();

    if (_me && _me->IsCreature())
    {
        sScriptMgr->OnUninstall(this);
    }
}

void Vehicle::Reset(bool evading /*= false*/)
{
    LOG_DEBUG("vehicles", "Vehicle::Reset: {}", _me->GetGUID().ToString());
    if (_me->IsPlayer())
    {
        if (_usableSeatNum)
            _me->SetNpcFlag(UNIT_NPC_FLAG_PLAYER_VEHICLE);
    }
    else
    {
        ApplyAllImmunities();
        InstallAllAccessories(evading);
        if (_usableSeatNum)
            _me->SetNpcFlag(UNIT_NPC_FLAG_SPELLCLICK);
    }

    if (GetBase()->IsCreature())
        sScriptMgr->OnReset(this);
}

void Vehicle::ApplyAllImmunities()
{
    // This couldn't be done in DB, because some spells have MECHANIC_NONE

    // Vehicles should be immune on Knockback ...
    //_me->ApplySpellImmune(0, IMMUNITY_EFFECT, SPELL_EFFECT_KNOCK_BACK, true);
    //_me->ApplySpellImmune(0, IMMUNITY_EFFECT, SPELL_EFFECT_KNOCK_BACK_DEST, true);

    // Mechanical units & vehicles ( which are not Bosses, they have own immunities in DB ) should be also immune on healing ( exceptions in switch below )
    if (_me->ToCreature() && _me->ToCreature()->GetCreatureTemplate()->type == CREATURE_TYPE_MECHANICAL && !_me->ToCreature()->isWorldBoss())
    {
        // Heal & dispel ...
        _me->ApplySpellImmune(0, IMMUNITY_EFFECT, SPELL_EFFECT_HEAL, true);
        _me->ApplySpellImmune(0, IMMUNITY_EFFECT, SPELL_EFFECT_HEAL_PCT, true);
        _me->ApplySpellImmune(0, IMMUNITY_EFFECT, SPELL_EFFECT_HEAL_MAX_HEALTH, true); // Xinef
        _me->ApplySpellImmune(0, IMMUNITY_EFFECT, SPELL_EFFECT_DISPEL, true);
        _me->ApplySpellImmune(0, IMMUNITY_STATE, SPELL_AURA_PERIODIC_HEAL, true);

        // ... Shield & Immunity grant spells ...
        _me->ApplySpellImmune(0, IMMUNITY_STATE, SPELL_AURA_SCHOOL_IMMUNITY, true);
        //_me->ApplySpellImmune(0, IMMUNITY_STATE, SPELL_AURA_MOD_UNATTACKABLE, true);
        _me->ApplySpellImmune(0, IMMUNITY_MECHANIC, MECHANIC_SHIELD, true);
        _me->ApplySpellImmune(0, IMMUNITY_MECHANIC, MECHANIC_IMMUNE_SHIELD, true);
        if (_me->GetZoneId() == BATTLEFIELD_WG_ZONEID || _me->ToCreature()->GetSpawnId() || (_me->FindMap() && _me->FindMap()->Instanceable()))
            _me->ApplySpellImmune(0, IMMUNITY_STATE, SPELL_AURA_SCHOOL_ABSORB, true);

        // ... Resistance, Split damage, Change stats ...
        _me->ApplySpellImmune(0, IMMUNITY_STATE, SPELL_AURA_DAMAGE_SHIELD, true);
        _me->ApplySpellImmune(0, IMMUNITY_STATE, SPELL_AURA_SPLIT_DAMAGE_PCT, true);
        _me->ApplySpellImmune(0, IMMUNITY_STATE, SPELL_AURA_MOD_RESISTANCE, true);
        _me->ApplySpellImmune(0, IMMUNITY_STATE, SPELL_AURA_MOD_STAT, true);

        // Taunt
        _me->ApplySpellImmune(0, IMMUNITY_STATE, SPELL_AURA_MOD_TAUNT, true);
        _me->ApplySpellImmune(0, IMMUNITY_EFFECT, SPELL_EFFECT_ATTACK_ME, true);
    }

    // Different immunities for vehicles goes below
    switch (GetVehicleInfo()->m_ID)
    {
        case 160: //Isle of conquest turret
        case 244: //Wintergrasp turret
        case 510: // Isle of Conquest
        case 452: // Isle of Conquest
        case 543: // Isle of Conquest
            //_me->SetControlled(true, UNIT_STATE_ROOT);
            //me->AddUnitMovementFlag(MOVEMENTFLAG_ROOT);
            //me->SetSpeed(MOVE_TURN_RATE, 0.7f);
            //me->SetSpeed(MOVE_PITCH_RATE, 0.7f);
            //me->m_movementInfo.flags2=59;
            _me->ApplySpellImmune(0, IMMUNITY_STATE, SPELL_AURA_MOD_DECREASE_SPEED, true);
            break;
        // Ulduar vehicles, remove immunities used in flame leviathan spells
        case 335:
        case 336:
        case 338:
            _me->ApplySpellImmune(0, IMMUNITY_STATE, SPELL_AURA_MOD_DAMAGE_PERCENT_TAKEN, false);
            _me->ApplySpellImmune(0, IMMUNITY_STATE, SPELL_AURA_SCHOOL_ABSORB, false);
            break;
        default:
            break;
    }
}

void Vehicle::RemoveAllPassengers()
{
    LOG_DEBUG("vehicles", "Vehicle::RemoveAllPassengers. {}", _me->GetGUID().ToString());

    // Passengers always cast an aura with SPELL_AURA_CONTROL_VEHICLE on the vehicle
    // We just remove the aura and the unapply handler will make the target leave the vehicle.
    // We don't need to iterate over Seats
    _me->RemoveAurasByType(SPELL_AURA_CONTROL_VEHICLE);

    // Following the above logic, this assertion should NEVER fail.
    // Even in 'hacky' cases, there should at least be VEHICLE_SPELL_RIDE_HARDCODED on us.
    // SeatMap::const_iterator itr;
    // for (itr = Seats.begin(); itr != Seats.end(); ++itr)
    //    ASSERT(!itr->second.passenger.Guid);
}

bool Vehicle::HasEmptySeat(int8 seatId) const
{
    SeatMap::const_iterator seat = Seats.find(seatId);
    if (seat == Seats.end())
        return false;
    return seat->second.IsEmpty();
}

Unit* Vehicle::GetPassenger(int8 seatId) const
{
    SeatMap::const_iterator seat = Seats.find(seatId);
    if (seat == Seats.end())
        return nullptr;

    return ObjectAccessor::GetUnit(*GetBase(), seat->second.Passenger.Guid);
}

VehicleSeatAddon const* Vehicle::GetSeatAddonForSeatOfPassenger(Unit const* passenger) const
{
    for (SeatMap::const_iterator itr = Seats.begin(); itr != Seats.end(); itr++)
        if (!itr->second.IsEmpty() && itr->second.Passenger.Guid == passenger->GetGUID())
            return itr->second.SeatAddon;

    return nullptr;
}

int8 Vehicle::GetNextEmptySeat(int8 seatId, bool next) const
{
    SeatMap::const_iterator seat = Seats.find(seatId);
    if (seat == Seats.end())
        return -1;

    while (!seat->second.IsEmpty() || (!seat->second.SeatInfo->CanEnterOrExit() && !seat->second.SeatInfo->IsUsableByOverride()))
    {
        if (next)
        {
            ++seat;
            if (seat == Seats.end())
                seat = Seats.begin();
        }
        else
        {
            if (seat == Seats.begin())
                seat = Seats.end();
            --seat;
        }

        if (seat->first == seatId)
            return -1; // no available seat
    }

    return seat->first;
}

void Vehicle::InstallAccessory(uint32 entry, int8 seatId, bool minion, uint8 type, uint32 summonTime)
{
    /// @Prevent adding accessories when vehicle is uninstalling. (Bad script in OnUninstall/OnRemovePassenger/PassengerBoarded hook.)
    if (_status == STATUS_UNINSTALLING)
    {
        LOG_ERROR("vehicles", "Vehicle {} attempts to install accessory Entry: {} on seat {} with STATUS_UNINSTALLING! "
                       "Check Uninstall/PassengerBoarded script hooks for errors.", _me->GetGUID().ToString(), entry, (int32)seatId);
        return;
    }

    LOG_DEBUG("vehicles", "Vehicle: Installing accessory entry {} on vehicle entry {} (seat:{})", entry, GetCreatureEntry(), seatId);
    if (Unit* passenger = GetPassenger(seatId))
    {
        // already installed
        if (passenger->GetEntry() == entry)
        {
            ASSERT(passenger->IsCreature());
            if (_me->IsCreature())
            {
                if (_me->ToCreature()->IsInEvadeMode() && passenger->ToCreature()->IsAIEnabled)
                    passenger->ToCreature()->AI()->EnterEvadeMode();
                return;
            }
        }
        else
            passenger->ExitVehicle(); // this should not happen
    }

    if (TempSummon* accessory = _me->SummonCreature(entry, *_me, TempSummonType(type), summonTime))
    {
        if (minion)
            accessory->AddUnitTypeMask(UNIT_MASK_ACCESSORY);

        if (!_me->HandleSpellClick(accessory, seatId))
        {
            accessory->UnSummon();
            return;
        }

        if (GetBase()->IsCreature())
            sScriptMgr->OnInstallAccessory(this, accessory);
    }
}

bool Vehicle::AddPassenger(Unit* unit, int8 seatId)
{
    /// @Prevent adding passengers when vehicle is uninstalling. (Bad script in OnUninstall/OnRemovePassenger/PassengerBoarded hook.)
    if (_status == STATUS_UNINSTALLING)
    {
        LOG_DEBUG("vehicles", "Passenger {}, attempting to board vehicle {} during uninstall! SeatId: {}",
            unit->GetGUID().ToString(), _me->GetGUID().ToString(), (int32)seatId);
        return false;
    }

    if (unit->GetVehicle() != this)
        return false;

    SeatMap::iterator seat;
    if (seatId < 0) // no specific seat requirement
    {
        for (seat = Seats.begin(); seat != Seats.end(); ++seat)
            if (seat->second.IsEmpty() && (seat->second.SeatInfo->CanEnterOrExit() || seat->second.SeatInfo->IsUsableByOverride()))
                break;

        if (seat == Seats.end()) // no available seat
            return false;
    }
    else
    {
        seat = Seats.find(seatId);
        if (seat == Seats.end())
            return false;

        if (!seat->second.IsEmpty())
        {
            if (Unit* passenger = ObjectAccessor::GetUnit(*GetBase(), seat->second.Passenger.Guid))
                passenger->ExitVehicle();

            seat->second.Passenger.Guid.Clear();
        }

        ASSERT(seat->second.IsEmpty());
    }

    if (!seat->second.SeatInfo)
        return false;

    LOG_DEBUG("vehicles", "Unit {} enter vehicle entry {} id {} ({}) seat {}",
        unit->GetName(), _me->GetEntry(), _vehicleInfo->m_ID, _me->GetGUID().ToString(), (int32)seat->first);

    seat->second.Passenger.Guid = unit->GetGUID();
    seat->second.Passenger.IsUnselectable = unit->HasUnitFlag(UNIT_FLAG_NOT_SELECTABLE);

    if (seat->second.SeatInfo->CanEnterOrExit())
    {
        ASSERT(_usableSeatNum);
        --_usableSeatNum;
        if (!_usableSeatNum)
            _me->RemoveNpcFlag(_me->IsPlayer() ? UNIT_NPC_FLAG_PLAYER_VEHICLE : UNIT_NPC_FLAG_SPELLCLICK);
        else
            _me->SetNpcFlag(_me->IsPlayer() ?  UNIT_NPC_FLAG_PLAYER_VEHICLE : UNIT_NPC_FLAG_SPELLCLICK);
    }

    if (!_me || !_me->IsInWorld() || _me->IsDuringRemoveFromWorld())
        return false;

    // Xinef: moved from unit.cpp, if aura passes seatId == -1 (choose automaticly) we wont get appropriate flags
    if (unit->IsPlayer() && !(seat->second.SeatInfo->m_flagsB & VEHICLE_SEAT_FLAG_B_KEEP_PET))
        unit->ToPlayer()->UnsummonPetTemporaryIfAny();

    if (seat->second.SeatInfo->m_flags & VEHICLE_SEAT_FLAG_PASSENGER_NOT_SELECTABLE)
        unit->SetUnitFlag(UNIT_FLAG_NOT_SELECTABLE);

    unit->AddUnitMovementFlag(MOVEMENTFLAG_ONTRANSPORT);
    VehicleSeatEntry const* veSeat = seat->second.SeatInfo;
    VehicleSeatAddon const* veSeatAddon = seat->second.SeatAddon;

    float o = veSeatAddon ? veSeatAddon->SeatOrientationOffset : 0.f;
    float x = veSeat->m_attachmentOffsetX;
    float y = veSeat->m_attachmentOffsetY;
    float z = veSeat->m_attachmentOffsetZ;

    unit->m_movementInfo.transport.pos.Relocate(x, y, z, o);
    unit->m_movementInfo.transport.time = 0;
    unit->m_movementInfo.transport.seat = seat->first;
    unit->m_movementInfo.transport.guid = _me->GetGUID();

    // xinef: removed seat->first == 0 check...
    if (_me->IsCreature()
            && unit->IsPlayer()
            && seat->second.SeatInfo->m_flags & VEHICLE_SEAT_FLAG_CAN_CONTROL)
    {
        // Removed try catch + ABORT() here, and make it as simple condition check.
        if (!_me->SetCharmedBy(unit, CHARM_TYPE_VEHICLE))
        {
            // I assume SetCharmedBy should always be true.
            // If not, let's log some debug info.
            LOG_INFO("vehicles", "Crash recovered in Unit::SetCharmedBy(). not null: {}", _me ? 1 : 0);
            if (!_me)
                return false;
            LOG_INFO("vehicles", "Crash recovered in Unit::SetCharmedBy(). Is: {}!", _me->IsInWorld());
            LOG_INFO("vehicles", "Crash recovered in Unit::SetCharmedBy(). Is2: {}!", _me->IsDuringRemoveFromWorld());
            LOG_INFO("vehicles", "Crash recovered in Unit::SetCharmedBy(). Unit {}!", _me->GetName());
            LOG_INFO("vehicles", "Crash recovered in Unit::SetCharmedBy(). typeid: {}!", _me->GetTypeId());
            LOG_INFO("vehicles", "Crash recovered in Unit::SetCharmedBy(). Unit {}, typeid: {}, in world: {}, duringremove: {} has wrong CharmType! Charmer {}, typeid: {}, in world: {}, duringremove: {}.", _me->GetName(), _me->GetTypeId(), _me->IsInWorld(), _me->IsDuringRemoveFromWorld(), unit->GetName(), unit->GetTypeId(), unit->IsInWorld(), unit->IsDuringRemoveFromWorld());
            return false;
        }
    }

    if (_me->IsInWorld())
    {
        unit->SendClearTarget();                                // SMSG_BREAK_TARGET
        unit->SetControlled(true, UNIT_STATE_ROOT);              // SMSG_FORCE_ROOT - In some cases we send SMSG_SPLINE_MOVE_ROOT here (for creatures)
        // also adds MOVEMENTFLAG_ROOT
        Movement::MoveSplineInit init(unit);
        init.DisableTransportPathTransformations();
        init.MoveTo(x, y, z, false, true);
        // Xinef: did not found anything unique in dbc, maybe missed something
        if (veSeat->m_ID == 3566 || veSeat->m_ID == 3567 || veSeat->m_ID == 3568 || veSeat->m_ID == 3570)
        {
            CalculatePassengerPosition(x, y, z, &o);
            init.SetFacing(_me->GetAngle(x, y));
        }
        else
        {
            init.SetFacing(o);
        }

        init.SetTransportEnter();
        init.Launch();

        if (_me->IsCreature())
        {
            if (_me->ToCreature()->IsAIEnabled)
                _me->ToCreature()->AI()->PassengerBoarded(unit, seat->first, true);
        }
    }

    if (GetBase()->IsCreature())
        sScriptMgr->OnAddPassenger(this, unit, seatId);

    // Remove parachute on vehicle switch
    unit->RemoveAurasDueToSpell(VEHICLE_SPELL_PARACHUTE);
    return true;
}

void Vehicle::RemovePassenger(Unit* unit)
{
    if (unit->GetVehicle() != this)
        return;

    SeatMap::iterator seat = GetSeatIteratorForPassenger(unit);
    // it can happen that unit enters vehicle and removes owner passenger
    // then vehicles is dissmised and removes all existing passengers, even the unit (vehicle has aura of unit)
    // but the unit is not on the vehicles seat yet, thus crashing at ASSERT(seat != Seats.end());
    // ASSERT(seat != Seats.end());
    if (seat == Seats.end())
    {
        LOG_ERROR("vehicles", "Vehicle::RemovePassenger: Vehicle entry ({}) id ({}) is dissmised and removed all existing passangers, but the unit ({}) was not on the vehicle!",
            _me->GetEntry(), _vehicleInfo->m_ID, unit->GetName());
        return;
    }

    LOG_DEBUG("vehicles", "Unit {} exit vehicle entry {} id {} ({}) seat {}",
        unit->GetName(), _me->GetEntry(), _vehicleInfo->m_ID, _me->GetGUID().ToString(), (int32)seat->first);

    if (seat->second.SeatInfo->CanEnterOrExit() && ++_usableSeatNum)
        _me->SetNpcFlag((_me->IsPlayer() ? UNIT_NPC_FLAG_PLAYER_VEHICLE : UNIT_NPC_FLAG_SPELLCLICK));

    // Remove UNIT_FLAG_NOT_SELECTABLE if passenger did not have it before entering vehicle
    if (seat->second.SeatInfo->m_flags & VEHICLE_SEAT_FLAG_PASSENGER_NOT_SELECTABLE && !seat->second.Passenger.IsUnselectable)
        unit->RemoveUnitFlag(UNIT_FLAG_NOT_SELECTABLE);

    seat->second.Passenger.Reset();

    if (_me->IsCreature() && unit->IsPlayer() && seat->second.SeatInfo->m_flags & VEHICLE_SEAT_FLAG_CAN_CONTROL)
        _me->RemoveCharmedBy(unit);

    if (_me->IsInWorld())
    {
        if (!_me->GetTransport())
        {
            unit->RemoveUnitMovementFlag(MOVEMENTFLAG_ONTRANSPORT);
            unit->m_movementInfo.transport.Reset();
        }
        else
            unit->m_movementInfo.transport = _me->m_movementInfo.transport;
    }

    // only for flyable vehicles
    if (_me->IsFlying() && !_me->GetInstanceId() && unit->IsPlayer() && !(unit->ToPlayer()->GetDelayedOperations() & DELAYED_VEHICLE_TELEPORT) && _me->GetEntry() != 30275 /*NPC_WILD_WYRM*/)
        _me->CastSpell(unit, VEHICLE_SPELL_PARACHUTE, true);

    if (_me->IsCreature())
        sScriptMgr->OnRemovePassenger(this, unit);

    if (_me->IsCreature() && _me->ToCreature()->IsAIEnabled)
        _me->ToCreature()->AI()->PassengerBoarded(unit, seat->first, false);
}

void Vehicle::RelocatePassengers()
{
    ASSERT(_me->GetMap());

    std::vector<std::pair<Unit*, Position>> seatRelocation;
    seatRelocation.reserve(Seats.size());

    // not sure that absolute position calculation is correct, it must depend on vehicle pitch angle
    for (auto const& itr : Seats)
    {
        if (Unit* passenger = ObjectAccessor::GetUnit(*GetBase(), itr.second.Passenger.Guid))
        {
            ASSERT(passenger->IsInWorld());

            float px, py, pz, po;
            passenger->m_movementInfo.transport.pos.GetPosition(px, py, pz, po);
            CalculatePassengerPosition(px, py, pz, &po);
            seatRelocation.emplace_back(passenger, Position(px, py, pz, po));
        }
    }

    for (auto const& pair : seatRelocation)
        pair.first->UpdatePosition(pair.second);
}

void Vehicle::Dismiss()
{
    if (!GetBase()->IsCreature())
        return;

    LOG_DEBUG("vehicles", "Vehicle::Dismiss {}", _me->GetGUID().ToString());
    Uninstall();
    GetBase()->ToCreature()->DespawnOrUnsummon();
}

bool Vehicle::IsVehicleInUse()
{
    for (SeatMap::const_iterator itr = Seats.begin(); itr != Seats.end(); ++itr)
        if (Unit* passenger = ObjectAccessor::GetUnit(*GetBase(), itr->second.Passenger.Guid))
        {
            if (passenger->IsPlayer())
                return true;
            else if (passenger->IsCreature() && passenger->GetVehicleKit() && passenger->GetVehicleKit()->IsVehicleInUse())
                return true;
        }

    return false;
}

void Vehicle::TeleportVehicle(float x, float y, float z, float ang)
{
    _me->GetMap()->LoadGrid(x, y);
    _me->NearTeleportTo(x, y, z, ang, true);

    for (SeatMap::const_iterator itr = Seats.begin(); itr != Seats.end(); ++itr)
        if (Unit* passenger = ObjectAccessor::GetUnit(*GetBase(), itr->second.Passenger.Guid))
        {
            if (passenger->IsPlayer())
            {
                passenger->ToPlayer()->SetMover(passenger);
                passenger->NearTeleportTo(x, y, z, ang, false, true);
                passenger->ToPlayer()->ScheduleDelayedOperation(DELAYED_VEHICLE_TELEPORT);
            }
            else if (passenger->IsCreature() && passenger->GetVehicleKit())
                passenger->GetVehicleKit()->TeleportVehicle(x, y, z, ang);
        }
}

void Vehicle::InitMovementInfoForBase()
{
    uint32 vehicleFlags = GetVehicleInfo()->m_flags;

    if (vehicleFlags & VEHICLE_FLAG_NO_STRAFE)
        _me->AddExtraUnitMovementFlag(MOVEMENTFLAG2_NO_STRAFE);
    if (vehicleFlags & VEHICLE_FLAG_NO_JUMPING)
        _me->AddExtraUnitMovementFlag(MOVEMENTFLAG2_NO_JUMPING);
    if (vehicleFlags & VEHICLE_FLAG_FULLSPEEDTURNING)
        _me->AddExtraUnitMovementFlag(MOVEMENTFLAG2_FULL_SPEED_TURNING);
    if (vehicleFlags & VEHICLE_FLAG_ALLOW_PITCHING)
        _me->AddExtraUnitMovementFlag(MOVEMENTFLAG2_ALWAYS_ALLOW_PITCHING);
    if (vehicleFlags & VEHICLE_FLAG_FULLSPEEDPITCHING)
        _me->AddExtraUnitMovementFlag(MOVEMENTFLAG2_FULL_SPEED_PITCHING);
}

VehicleSeatEntry const* Vehicle::GetSeatForPassenger(Unit const* passenger)
{
    SeatMap::iterator itr;
    for (itr = Seats.begin(); itr != Seats.end(); ++itr)
        if (itr->second.Passenger.Guid == passenger->GetGUID())
            return itr->second.SeatInfo;

    return nullptr;
}

SeatMap::iterator Vehicle::GetSeatIteratorForPassenger(Unit* passenger)
{
    SeatMap::iterator itr;
    for (itr = Seats.begin(); itr != Seats.end(); ++itr)
        if (itr->second.Passenger.Guid == passenger->GetGUID())
            return itr;

    return Seats.end();
}

uint8 Vehicle::GetAvailableSeatCount() const
{
    uint8 ret = 0;
    SeatMap::const_iterator itr;
    for (itr = Seats.begin(); itr != Seats.end(); ++itr)
        if (itr->second.IsEmpty() && (itr->second.SeatInfo->CanEnterOrExit() || itr->second.SeatInfo->IsUsableByOverride()))
            ++ret;

    return ret;
}

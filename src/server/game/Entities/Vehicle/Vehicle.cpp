/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include "Common.h"
#include "Log.h"
#include "ObjectMgr.h"
#include "Vehicle.h"
#include "Unit.h"
#include "Util.h"
#include "WorldPacket.h"
#include "ScriptMgr.h"
#include "CreatureAI.h"
#include "ZoneScript.h"
#include "SpellMgr.h"
#include "SpellInfo.h"
#include "MoveSplineInit.h"
#include "TemporarySummon.h"
#include "Player.h"
#include "BattlefieldWG.h"

Vehicle::Vehicle(Unit* unit, VehicleEntry const* vehInfo, uint32 creatureEntry) :
_me(unit), _vehicleInfo(vehInfo), _usableSeatNum(0), _creatureEntry(creatureEntry), _status(STATUS_NONE)
{
    for (uint32 i = 0; i < MAX_VEHICLE_SEATS; ++i)
    {
        if (uint32 seatId = _vehicleInfo->m_seatID[i])
            if (VehicleSeatEntry const* veSeat = sVehicleSeatStore.LookupEntry(seatId))
            {
                Seats.insert(std::make_pair(i, VehicleSeat(veSeat)));
                if (veSeat->CanEnterOrExit())
                    ++_usableSeatNum;
            }
    }

    // Ulduar demolisher
    if (vehInfo->m_ID == 338)
        ++_usableSeatNum;

    InitMovementInfoForBase();
}

Vehicle::~Vehicle()
{
    /// @Uninstall must be called before this.
    ASSERT(_status == STATUS_UNINSTALLING);

    for (SeatMap::const_iterator itr = Seats.begin(); itr != Seats.end(); ++itr)
        if (itr->second.Passenger.Guid)
        {
            if (Unit* unit = ObjectAccessor::FindUnit(itr->second.Passenger.Guid))
            {
                sLog->outString("ZOMG! ~Vehicle(), unit: %s, entry: %u, typeid: %u, this_entry: %u, this_typeid: %u!", unit->GetName().c_str(), unit->GetEntry(), unit->GetTypeId(), _me ? _me->GetEntry() : 0, _me ? _me->GetTypeId() : 0);
                unit->_ExitVehicle();
            }
            else
                sLog->outString("ZOMG! ~Vehicle(), unknown guid!");
        }
        //ASSERT(!itr->second.IsEmpty());
}

void Vehicle::Install()
{
    if (_me->GetTypeId() == TYPEID_UNIT)
    {
        if (PowerDisplayEntry const* powerDisplay = sPowerDisplayStore.LookupEntry(_vehicleInfo->m_powerDisplayId))
            _me->setPowerType(Powers(powerDisplay->PowerType));
        else if (_me->getClass() == CLASS_ROGUE)
            _me->setPowerType(POWER_ENERGY);
    }

    _status = STATUS_INSTALLED;
    if (GetBase()->GetTypeId() == TYPEID_UNIT)
        sScriptMgr->OnInstall(this);
}

void Vehicle::InstallAllAccessories(bool evading)
{
    if (GetBase()->GetTypeId() == TYPEID_PLAYER || !evading)
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
        sLog->outError("Vehicle GuidLow: %u, Entry: %u attempts to uninstall, but already has STATUS_UNINSTALLING! "
            "Check Uninstall/PassengerBoarded script hooks for errors.", _me->GetGUIDLow(), _me->GetEntry());
        return;
    }
    _status = STATUS_UNINSTALLING;
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outDebug(LOG_FILTER_VEHICLES, "Vehicle::Uninstall Entry: %u, GuidLow: %u", _creatureEntry, _me->GetGUIDLow());
#endif
    RemoveAllPassengers();

    if (GetBase()->GetTypeId() == TYPEID_UNIT)
        sScriptMgr->OnUninstall(this);
}

void Vehicle::Reset(bool evading /*= false*/)
{
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outDebug(LOG_FILTER_VEHICLES, "Vehicle::Reset Entry: %u, GuidLow: %u", _creatureEntry, _me->GetGUIDLow());
#endif
    if (_me->GetTypeId() == TYPEID_PLAYER)
    {
        if (_usableSeatNum)
            _me->SetFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_PLAYER_VEHICLE);
    }
    else
    {
        ApplyAllImmunities();
        InstallAllAccessories(evading);
        if (_usableSeatNum)
            _me->SetFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_SPELLCLICK);
    }

    if (GetBase()->GetTypeId() == TYPEID_UNIT)
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
        if (_me->GetZoneId() == BATTLEFIELD_WG_ZONEID || _me->ToCreature()->GetDBTableGUIDLow() || (_me->FindMap() && _me->FindMap()->Instanceable()))
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
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outDebug(LOG_FILTER_VEHICLES, "Vehicle::RemoveAllPassengers. Entry: %u, GuidLow: %u", _creatureEntry, _me->GetGUIDLow());
#endif

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
        sLog->outError("Vehicle GuidLow: %u, Entry: %u attempts to install accessory Entry: %u on seat %d with STATUS_UNINSTALLING! "
            "Check Uninstall/PassengerBoarded script hooks for errors.", _me->GetGUIDLow(), _me->GetEntry(), entry, (int32)seatId);
        return;
    }

#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outDebug(LOG_FILTER_VEHICLES, "Vehicle: Installing accessory entry %u on vehicle entry %u (seat:%i)", entry, GetCreatureEntry(), seatId);
#endif
    if (Unit* passenger = GetPassenger(seatId))
    {
        // already installed
        if (passenger->GetEntry() == entry)
        {
            ASSERT(passenger->GetTypeId() == TYPEID_UNIT);
            if (_me->GetTypeId() == TYPEID_UNIT)
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

        if (GetBase()->GetTypeId() == TYPEID_UNIT)
            sScriptMgr->OnInstallAccessory(this, accessory);
    }
}

bool Vehicle::AddPassenger(Unit* unit, int8 seatId)
{
    /// @Prevent adding passengers when vehicle is uninstalling. (Bad script in OnUninstall/OnRemovePassenger/PassengerBoarded hook.)
    if (_status == STATUS_UNINSTALLING)
    {
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
        sLog->outDebug(LOG_FILTER_VEHICLES, "Passenger GuidLow: %u, Entry: %u, attempting to board vehicle GuidLow: %u, Entry: %u during uninstall! SeatId: %i", unit->GetGUIDLow(), unit->GetEntry(), _me->GetGUIDLow(), _me->GetEntry(), (int32)seatId);
#endif
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

            seat->second.Passenger.Guid = 0;
        }

        ASSERT(seat->second.IsEmpty());
    }

#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outDebug(LOG_FILTER_VEHICLES, "Unit %s enter vehicle entry %u id %u dbguid %u seat %d", unit->GetName().c_str(), _me->GetEntry(), _vehicleInfo->m_ID, _me->GetGUIDLow(), (int32)seat->first);
#endif

    seat->second.Passenger.Guid = unit->GetGUID();
    seat->second.Passenger.IsUnselectable = unit->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
    
    if (seat->second.SeatInfo->CanEnterOrExit())
    {
        ASSERT(_usableSeatNum);
        --_usableSeatNum;
        if (!_usableSeatNum)
        {
            if (_me->GetTypeId() == TYPEID_PLAYER)
                _me->RemoveFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_PLAYER_VEHICLE);
            else
                _me->RemoveFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_SPELLCLICK);
        }
    }

    if (!_me || !_me->IsInWorld() || _me->IsDuringRemoveFromWorld())
        return false;

    // Xinef: moved from unit.cpp, if aura passes seatId == -1 (choose automaticly) we wont get appropriate flags
    if (unit->GetTypeId() == TYPEID_PLAYER && !(seat->second.SeatInfo->m_flagsB & VEHICLE_SEAT_FLAG_B_KEEP_PET))
        unit->ToPlayer()->UnsummonPetTemporaryIfAny();

    if (seat->second.SeatInfo->m_flags & VEHICLE_SEAT_FLAG_PASSENGER_NOT_SELECTABLE)
        unit->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);

    unit->AddUnitMovementFlag(MOVEMENTFLAG_ONTRANSPORT);
    VehicleSeatEntry const* veSeat = seat->second.SeatInfo;
    unit->m_movementInfo.transport.pos.Relocate(veSeat->m_attachmentOffsetX, veSeat->m_attachmentOffsetY, veSeat->m_attachmentOffsetZ);
    unit->m_movementInfo.transport.time = 0;
    unit->m_movementInfo.transport.seat = seat->first;
    unit->m_movementInfo.transport.guid = _me->GetGUID();

    // xinef: removed retarded seat->first == 0 check...
    if (_me->GetTypeId() == TYPEID_UNIT
        && unit->GetTypeId() == TYPEID_PLAYER
        && seat->second.SeatInfo->m_flags & VEHICLE_SEAT_FLAG_CAN_CONTROL)
    {
        try
        {
        if (!_me->SetCharmedBy(unit, CHARM_TYPE_VEHICLE))
            ABORT();
        }
        catch (...)
        {
            sLog->outString("ZOMG! CRASH! Try-catch in Unit::SetCharmedBy()!");
            sLog->outString("ZOMG! CRASH! Try-catch in Unit::SetCharmedBy(). not null: %u", _me ? 1 : 0);
            if (!_me)
                return false;
            sLog->outString("ZOMG! CRASH! Try-catch in Unit::SetCharmedBy(). Is: %u!", _me->IsInWorld());
            sLog->outString("ZOMG! CRASH! Try-catch in Unit::SetCharmedBy(). Is2: %u!", _me->IsDuringRemoveFromWorld());
            sLog->outString("ZOMG! CRASH! Try-catch in Unit::SetCharmedBy(). Unit %s!", _me->GetName().c_str());
            sLog->outString("ZOMG! CRASH! Try-catch in Unit::SetCharmedBy(). typeid: %u!", _me->GetTypeId());
            sLog->outString("ZOMG! CRASH! Try-catch in Unit::SetCharmedBy(). Unit %s, typeid: %u, in world: %u, duringremove: %u has wrong CharmType! Charmer %s, typeid: %u, in world: %u, duringremove: %u.", _me->GetName().c_str(), _me->GetTypeId(), _me->IsInWorld(), _me->IsDuringRemoveFromWorld(), unit->GetName().c_str(), unit->GetTypeId(), unit->IsInWorld(), unit->IsDuringRemoveFromWorld());
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
        init.MoveTo(veSeat->m_attachmentOffsetX, veSeat->m_attachmentOffsetY, veSeat->m_attachmentOffsetZ);
        // Xinef: did not found anything unique in dbc, maybe missed something
        if (veSeat->m_ID == 3566 || veSeat->m_ID == 3567 || veSeat->m_ID == 3568 || veSeat->m_ID == 3570)
        {
            float x = veSeat->m_attachmentOffsetX, y = veSeat->m_attachmentOffsetY, z = veSeat->m_attachmentOffsetZ, o;
            CalculatePassengerPosition(x, y, z, &o);
            init.SetFacing(_me->GetAngle(x, y));
        }
        else
            init.SetFacing(0.0f);

        init.SetTransportEnter();
        init.Launch();

        if (_me->GetTypeId() == TYPEID_UNIT)
        {
            if (_me->ToCreature()->IsAIEnabled)
                _me->ToCreature()->AI()->PassengerBoarded(unit, seat->first, true);
        }
    }

    if (GetBase()->GetTypeId() == TYPEID_UNIT)
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
        return;

#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outDebug(LOG_FILTER_VEHICLES, "Unit %s exit vehicle entry %u id %u dbguid %u seat %d", unit->GetName().c_str(), _me->GetEntry(), _vehicleInfo->m_ID, _me->GetGUIDLow(), (int32)seat->first);
#endif

    if (seat->second.SeatInfo->CanEnterOrExit() && ++_usableSeatNum)
        _me->SetFlag(UNIT_NPC_FLAGS, (_me->GetTypeId() == TYPEID_PLAYER ? UNIT_NPC_FLAG_PLAYER_VEHICLE : UNIT_NPC_FLAG_SPELLCLICK));

    // Remove UNIT_FLAG_NOT_SELECTABLE if passenger did not have it before entering vehicle
    if (seat->second.SeatInfo->m_flags & VEHICLE_SEAT_FLAG_PASSENGER_NOT_SELECTABLE && !seat->second.Passenger.IsUnselectable)
        unit->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);

    seat->second.Passenger.Reset();

    if (_me->GetTypeId() == TYPEID_UNIT && unit->GetTypeId() == TYPEID_PLAYER && seat->second.SeatInfo->m_flags & VEHICLE_SEAT_FLAG_CAN_CONTROL)
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
    if (_me->IsFlying() && !_me->GetInstanceId() && unit->GetTypeId() == TYPEID_PLAYER && !(unit->ToPlayer()->GetDelayedOperations() & DELAYED_VEHICLE_TELEPORT) && _me->GetEntry() != 30275 /*NPC_WILD_WYRM*/)
        _me->CastSpell(unit, VEHICLE_SPELL_PARACHUTE, true);

    if (_me->GetTypeId() == TYPEID_UNIT && _me->ToCreature()->IsAIEnabled)
        _me->ToCreature()->AI()->PassengerBoarded(unit, seat->first, false);

    if (GetBase()->GetTypeId() == TYPEID_UNIT)
        sScriptMgr->OnRemovePassenger(this, unit);
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
    if (GetBase()->GetTypeId() != TYPEID_UNIT)
        return;

#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outDebug(LOG_FILTER_VEHICLES, "Vehicle::Dismiss Entry: %u, GuidLow %u", _creatureEntry, _me->GetGUIDLow());
#endif
    Uninstall();
    GetBase()->ToCreature()->DespawnOrUnsummon();
}

bool Vehicle::IsVehicleInUse()
{
    for (SeatMap::const_iterator itr = Seats.begin(); itr != Seats.end(); ++itr)
        if (Unit* passenger = ObjectAccessor::GetUnit(*GetBase(), itr->second.Passenger.Guid))
        {
            if (passenger->GetTypeId() == TYPEID_PLAYER)
                return true;
            else if (passenger->GetTypeId() == TYPEID_UNIT && passenger->GetVehicleKit() && passenger->GetVehicleKit()->IsVehicleInUse())
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
            if (passenger->GetTypeId() == TYPEID_PLAYER)
            {
                passenger->ToPlayer()->SetMover(passenger);
                passenger->NearTeleportTo(x, y, z, ang, false, true);
                passenger->ToPlayer()->ScheduleDelayedOperation(DELAYED_VEHICLE_TELEPORT);
            }
            else if (passenger->GetTypeId() == TYPEID_UNIT && passenger->GetVehicleKit())
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

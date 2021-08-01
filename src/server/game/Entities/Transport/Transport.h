/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef TRANSPORTS_H
#define TRANSPORTS_H

#include "GameObject.h"
#include "TransportMgr.h"
#include "VehicleDefines.h"
#include "ZoneScript.h"

struct CreatureData;

class Transport : public GameObject, public TransportBase
{
public:
    Transport() : GameObject() {}
    void CalculatePassengerPosition(float& x, float& y, float& z, float* o = nullptr) const override { TransportBase::CalculatePassengerPosition(x, y, z, o, GetPositionX(), GetPositionY(), GetPositionZ(), GetOrientation()); }
    void CalculatePassengerOffset(float& x, float& y, float& z, float* o = nullptr) const override { TransportBase::CalculatePassengerOffset(x, y, z, o, GetPositionX(), GetPositionY(), GetPositionZ(), GetOrientation()); }

    typedef std::set<WorldObject*> PassengerSet;
    virtual void AddPassenger(WorldObject* passenger, bool withAll = false) = 0;
    virtual void RemovePassenger(WorldObject* passenger, bool withAll = false) = 0;
    PassengerSet const& GetPassengers() const { return _passengers; }

    uint32 GetPathProgress() const { return GetGOValue()->Transport.PathProgress; }
    void SetPathProgress(uint32 val) { m_goValue.Transport.PathProgress = val; }

protected:
    PassengerSet _passengers;
};

class MotionTransport : public Transport
{
    friend MotionTransport* TransportMgr::CreateTransport(uint32, ObjectGuid::LowType, Map*);
    MotionTransport();
public:
    ~MotionTransport() override;

    bool CreateMoTrans(ObjectGuid::LowType guidlow, uint32 entry, uint32 mapid, float x, float y, float z, float ang, uint32 animprogress);
    void CleanupsBeforeDelete(bool finalCleanup = true) override;
    void BuildUpdate(UpdateDataMapType& data_map, UpdatePlayerSet&) override;

    void Update(uint32 diff) override;
    void DelayedUpdate(uint32 diff);
    void UpdatePosition(float x, float y, float z, float o);

    void AddPassenger(WorldObject* passenger, bool withAll = false) override;
    void RemovePassenger(WorldObject* passenger, bool withAll = false) override;
    Creature* CreateNPCPassenger(ObjectGuid::LowType guid, CreatureData const* data);
    GameObject* CreateGOPassenger(ObjectGuid::LowType guid, GameObjectData const* data);

    void LoadStaticPassengers();
    PassengerSet const& GetStaticPassengers() const { return _staticPassengers; }
    void UnloadStaticPassengers();
    void UnloadNonStaticPassengers();
    void SetPassengersLoaded(bool loaded) { _passengersLoaded = loaded; }
    bool PassengersLoaded() const { return _passengersLoaded; }

    KeyFrameVec const& GetKeyFrames() const { return _transportInfo->keyFrames; }
    void EnableMovement(bool enabled);
    TransportTemplate const* GetTransportTemplate() const { return _transportInfo; }

    uint32 GetPeriod() const { return GetUInt32Value(GAMEOBJECT_LEVEL); }
    void SetPeriod(uint32 period) { SetUInt32Value(GAMEOBJECT_LEVEL, period); }

private:
    void MoveToNextWaypoint();
    float CalculateSegmentPos(float perc);
    bool TeleportTransport(uint32 newMapid, float x, float y, float z, float o);
    void DelayedTeleportTransport();
    void UpdatePassengerPositions(PassengerSet& passengers);
    void DoEventIfAny(KeyFrame const& node, bool departure);

    //! Helpers to know if stop frame was reached
    bool IsMoving() const { return _isMoving; }
    void SetMoving(bool val) { _isMoving = val; }

    TransportTemplate const* _transportInfo;
    KeyFrameVec::const_iterator _currentFrame;
    KeyFrameVec::const_iterator _nextFrame;
    TimeTrackerSmall _positionChangeTimer;
    bool _isMoving;
    bool _pendingStop;

    //! These are needed to properly control events triggering only once for each frame
    bool _triggeredArrivalEvent;
    bool _triggeredDepartureEvent;

    PassengerSet _staticPassengers;
    mutable std::mutex Lock;
    bool _passengersLoaded;
    bool _delayedTeleport;
};

class StaticTransport : public Transport
{
public:
    StaticTransport();
    ~StaticTransport() override;

    bool Create(ObjectGuid::LowType guidlow, uint32 name_id, Map* map, uint32 phaseMask, float x, float y, float z, float ang, G3D::Quat const& rotation, uint32 animprogress, GOState go_state, uint32 artKit = 0) override;
    void CleanupsBeforeDelete(bool finalCleanup = true) override;
    void BuildUpdate(UpdateDataMapType& data_map, UpdatePlayerSet&) override;

    void Update(uint32 diff) override;
    void RelocateToProgress(uint32 progress);
    void UpdatePosition(float x, float y, float z, float o);
    void UpdatePassengerPositions();

    void AddPassenger(WorldObject* passenger, bool withAll = false) override;
    void RemovePassenger(WorldObject* passenger, bool withAll = false) override;

    uint32 GetPauseTime() const { return GetUInt32Value(GAMEOBJECT_LEVEL); }
    void SetPauseTime(uint32 val) { SetUInt32Value(GAMEOBJECT_LEVEL, val); }
    uint32 GetPeriod() const { return m_goValue.Transport.AnimationInfo ? m_goValue.Transport.AnimationInfo->TotalTime : GetPauseTime() + 2; }
private:
    bool _needDoInitialRelocation;
};

#endif

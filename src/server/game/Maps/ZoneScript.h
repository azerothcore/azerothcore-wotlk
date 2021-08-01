/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef ZONE_SCRIPT_H_
#define ZONE_SCRIPT_H_

#include "Common.h"
#include "Creature.h"

class GameObject;

class ZoneScript
{
public:
    ZoneScript() {}
    virtual ~ZoneScript() {}

    virtual uint32 GetCreatureEntry(ObjectGuid::LowType /*guidlow*/, CreatureData const* data) { return data->id; }
    virtual uint32 GetGameObjectEntry(ObjectGuid::LowType /*guidlow*/, uint32 entry) { return entry; }

    virtual void OnCreatureCreate(Creature*) { }
    virtual void OnCreatureRemove(Creature*) { }

    virtual void OnGameObjectCreate(GameObject*) { }
    virtual void OnGameObjectRemove(GameObject*) { }

    virtual void OnUnitDeath(Unit*) { }

    //All-purpose data storage 64 bit
    virtual ObjectGuid GetGuidData(uint32 /*DataId*/) const { return ObjectGuid::Empty; }
    virtual void SetGuidData(uint32 /*DataId*/, ObjectGuid /*Value*/) {}

    virtual uint64 GetData64(uint32 /*DataId*/) const { return 0; }
    virtual void SetData64(uint32 /*DataId*/, uint64 /*Value*/) {}

    //All-purpose data storage 32 bit
    virtual uint32 GetData(uint32 /*DataId*/) const { return 0; }
    virtual void SetData(uint32 /*DataId*/, uint32 /*Value*/) {}

    virtual void ProcessEvent(WorldObject* /*obj*/, uint32 /*eventId*/) {}
};

#endif

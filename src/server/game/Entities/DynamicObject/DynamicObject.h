/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef AZEROTHCORE_DYNAMICOBJECT_H
#define AZEROTHCORE_DYNAMICOBJECT_H

#include "Object.h"

class Unit;
class Aura;
class SpellInfo;

enum DynamicObjectType
{
    DYNAMIC_OBJECT_PORTAL           = 0x0,      // unused
    DYNAMIC_OBJECT_AREA_SPELL       = 0x1,
    DYNAMIC_OBJECT_FARSIGHT_FOCUS   = 0x2,
};

class DynamicObject : public WorldObject, public GridObject<DynamicObject>, public MovableMapObject
{
public:
    DynamicObject(bool isWorldObject);
    ~DynamicObject() override;

    void AddToWorld() override;
    void RemoveFromWorld() override;

    void CleanupsBeforeDelete(bool finalCleanup = true) override;

    bool CreateDynamicObject(uint32 guidlow, Unit* caster, uint32 spellId, Position const& pos, float radius, DynamicObjectType type);
    void Update(uint32 p_time) override;
    void Remove();
    void SetDuration(int32 newDuration);
    [[nodiscard]] int32 GetDuration() const;
    void Delay(int32 delaytime);
    void SetAura(Aura* aura);
    void RemoveAura();
    void SetCasterViewpoint();
    void RemoveCasterViewpoint();
    [[nodiscard]] Unit* GetCaster() const { return _caster; }
    void BindToCaster();
    void UnbindFromCaster();
    [[nodiscard]] uint32 GetSpellId() const {  return GetUInt32Value(DYNAMICOBJECT_SPELLID); }
    [[nodiscard]] uint64 GetCasterGUID() const { return GetUInt64Value(DYNAMICOBJECT_CASTER); }
    [[nodiscard]] float GetRadius() const { return GetFloatValue(DYNAMICOBJECT_RADIUS); }
    [[nodiscard]] bool IsViewpoint() const { return _isViewpoint; }

protected:
    Aura* _aura;
    Aura* _removedAura;
    Unit* _caster;
    int32 _duration; // for non-aura dynobjects
    bool _isViewpoint;
};
#endif

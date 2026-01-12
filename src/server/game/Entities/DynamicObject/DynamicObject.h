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

class DynamicObject : public WorldObject, public GridObject<DynamicObject>, public MovableMapObject, public UpdatableMapObject
{
public:
    DynamicObject();
    ~DynamicObject() override;

    void AddToWorld() override;
    void RemoveFromWorld() override;

    void CleanupsBeforeDelete(bool finalCleanup = true) override;

    bool CreateDynamicObject(ObjectGuid::LowType guidlow, Unit* caster, uint32 spellId, Position const& pos, float radius, DynamicObjectType type);
    void Update(uint32 p_time) override;
    void Remove();
    void SetDuration(int32 newDuration);
    [[nodiscard]] int32 GetDuration() const;
    void Delay(int32 delaytime);
    void SetAura(Aura* aura);
    void RemoveAura();
    void SetCasterViewpoint(bool updateViewerVisibility);
    void RemoveCasterViewpoint();
    [[nodiscard]] Unit* GetCaster() const { return _caster; }
    void BindToCaster();
    void UnbindFromCaster();
    [[nodiscard]] uint32 GetSpellId() const {  return GetUInt32Value(DYNAMICOBJECT_SPELLID); }
    [[nodiscard]] ObjectGuid GetCasterGUID() const { return GetGuidValue(DYNAMICOBJECT_CASTER); }
    [[nodiscard]] float GetRadius() const { return GetFloatValue(DYNAMICOBJECT_RADIUS); }
    [[nodiscard]] bool IsViewpoint() const { return _isViewpoint; }

    ObjectGuid const& GetOldFarsightGUID() const { return _oldFarsightGUID; }

protected:
    Aura* _aura;
    Aura* _removedAura;
    Unit* _caster;
    int32 _duration; // for non-aura dynobjects
    bool _isViewpoint;
    uint32 _updateViewerVisibilityTimer;
    ObjectGuid _oldFarsightGUID;
};
#endif

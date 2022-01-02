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

    auto CreateDynamicObject(ObjectGuid::LowType guidlow, Unit* caster, uint32 spellId, Position const& pos, float radius, DynamicObjectType type) -> bool;
    void Update(uint32 p_time) override;
    void Remove();
    void SetDuration(int32 newDuration);
    [[nodiscard]] auto GetDuration() const -> int32;
    void Delay(int32 delaytime);
    void SetAura(Aura* aura);
    void RemoveAura();
    void SetCasterViewpoint();
    void RemoveCasterViewpoint();
    [[nodiscard]] auto GetCaster() const -> Unit* { return _caster; }
    void BindToCaster();
    void UnbindFromCaster();
    [[nodiscard]] auto GetSpellId() const -> uint32 {  return GetUInt32Value(DYNAMICOBJECT_SPELLID); }
    [[nodiscard]] auto GetCasterGUID() const -> ObjectGuid { return GetGuidValue(DYNAMICOBJECT_CASTER); }
    [[nodiscard]] auto GetRadius() const -> float { return GetFloatValue(DYNAMICOBJECT_RADIUS); }
    [[nodiscard]] auto IsViewpoint() const -> bool { return _isViewpoint; }

protected:
    Aura* _aura;
    Aura* _removedAura;
    Unit* _caster;
    int32 _duration; // for non-aura dynobjects
    bool _isViewpoint;
};
#endif

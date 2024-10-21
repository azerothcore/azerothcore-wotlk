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

#include "GameTime.h"
#include "GridNotifiers.h"
#include "ObjectAccessor.h"
#include "ScriptMgr.h"
#include "SpellAuraEffects.h"
#include "Transport.h"

DynamicObject::DynamicObject(bool isWorldObject) : WorldObject(isWorldObject), MovableMapObject(),
    _aura(nullptr), _removedAura(nullptr), _caster(nullptr), _duration(0), _isViewpoint(false), _updateViewerVisibilityTimer(0)
{
    m_objectType |= TYPEMASK_DYNAMICOBJECT;
    m_objectTypeId = TYPEID_DYNAMICOBJECT;

    m_updateFlag = (UPDATEFLAG_LOWGUID | UPDATEFLAG_STATIONARY_POSITION | UPDATEFLAG_POSITION);

    m_valuesCount = DYNAMICOBJECT_END;
}

DynamicObject::~DynamicObject()
{
    // make sure all references were properly removed
    ASSERT(!_aura);
    ASSERT(!_caster);
    ASSERT(!_isViewpoint);
    delete _removedAura;
}

void DynamicObject::CleanupsBeforeDelete(bool finalCleanup /* = true */)
{
    if (Transport* transport = GetTransport())
    {
        transport->RemovePassenger(this);
        SetTransport(nullptr);
        m_movementInfo.transport.Reset();
        m_movementInfo.RemoveMovementFlag(MOVEMENTFLAG_ONTRANSPORT);
    }

    WorldObject::CleanupsBeforeDelete(finalCleanup);
}

void DynamicObject::AddToWorld()
{
    ///- Register the dynamicObject for guid lookup and for caster
    if (!IsInWorld())
    {
        GetMap()->GetObjectsStore().Insert<DynamicObject>(GetGUID(), this);

        WorldObject::AddToWorld();

        BindToCaster();
    }
}

void DynamicObject::RemoveFromWorld()
{
    ///- Remove the dynamicObject from the accessor and from all lists of objects in world
    if (IsInWorld())
    {
        if (_isViewpoint)
            RemoveCasterViewpoint();

        if (_aura)
            RemoveAura();

        // dynobj could get removed in Aura::RemoveAura
        if (!IsInWorld())
            return;

        UnbindFromCaster();

        if (Transport* transport = GetTransport())
            transport->RemovePassenger(this, true);

        WorldObject::RemoveFromWorld();

        GetMap()->GetObjectsStore().Remove<DynamicObject>(GetGUID());
    }
}

bool DynamicObject::CreateDynamicObject(ObjectGuid::LowType guidlow, Unit* caster, uint32 spellId, Position const& pos, float radius, DynamicObjectType type)
{
    SetMap(caster->GetMap());
    Relocate(pos);
    if (!IsPositionValid())
    {
        LOG_ERROR("dyobject", "DynamicObject (spell {}) not created. Suggested coordinates isn't valid (X: {} Y: {})", spellId, GetPositionX(), GetPositionY());
        return false;
    }

    WorldObject::_Create(guidlow, HighGuid::DynamicObject, caster->GetPhaseMask());

    UpdatePositionData();

    SetEntry(spellId);
    SetObjectScale(1);
    SetGuidValue(DYNAMICOBJECT_CASTER, caster->GetGUID());

    // The lower word of DYNAMICOBJECT_BYTES must be 0x0001. This value means that the visual radius will be overriden
    // by client for most of the "ground patch" visual effect spells and a few "skyfall" ones like Hurricane.
    // If any other value is used, the client will _always_ use the radius provided in DYNAMICOBJECT_RADIUS, but
    // precompensation is necessary (eg radius *= 2) for many spells. Anyway, blizz sends 0x0001 for all the spells
    // I saw sniffed...
    SetByteValue(DYNAMICOBJECT_BYTES, 0, type);
    SetUInt32Value(DYNAMICOBJECT_SPELLID, spellId);
    SetFloatValue(DYNAMICOBJECT_RADIUS, radius);
    SetUInt32Value(DYNAMICOBJECT_CASTTIME, GameTime::GetGameTimeMS().count());

    if (!GetMap()->AddToMap(this, true))
    {
        // Returning false will cause the object to be deleted - remove from transport
        return false;
    }

    if (IsWorldObject())
    {
        setActive(true);
    }

    return true;
}

void DynamicObject::Update(uint32 p_time)
{
    // caster has to be always available and in the same map
    ASSERT(_caster);
    ASSERT(_caster->GetMap() == GetMap());

    bool expired = false;

    if (_aura)
    {
        if (!_aura->IsRemoved())
            _aura->UpdateOwner(p_time, this);

        // _aura may be set to null in Aura::UpdateOwner call
        if (_aura && (_aura->IsRemoved() || _aura->IsExpired()))
            expired = true;
    }
    else
    {
        if (GetDuration() > int32(p_time))
            _duration -= p_time;
        else
            expired = true;
    }

    if (expired)
        Remove();
    else
    {
        if (_updateViewerVisibilityTimer)
        {
            if (_updateViewerVisibilityTimer <= p_time)
            {
                _updateViewerVisibilityTimer = 0;

                if (Player* playerCaster = _caster->ToPlayer())
                    playerCaster->UpdateVisibilityForPlayer();
            }
            else
                _updateViewerVisibilityTimer -= p_time;
        }

        sScriptMgr->OnDynamicObjectUpdate(this, p_time);
    }
}

void DynamicObject::Remove()
{
    if (IsInWorld())
    {
        SendObjectDeSpawnAnim(GetGUID());
        RemoveFromWorld();
        AddObjectToRemoveList();
    }
}

int32 DynamicObject::GetDuration() const
{
    if (!_aura)
        return _duration;
    else
        return _aura->GetDuration();
}

void DynamicObject::SetDuration(int32 newDuration)
{
    if (!_aura)
        _duration = newDuration;
    else
        _aura->SetDuration(newDuration);
}

void DynamicObject::Delay(int32 delaytime)
{
    SetDuration(GetDuration() - delaytime);
}

void DynamicObject::SetAura(Aura* aura)
{
    ASSERT(!_aura && aura);
    _aura = aura;
}

void DynamicObject::RemoveAura()
{
    ASSERT(_aura && !_removedAura);
    _removedAura = _aura;
    _aura = nullptr;
    if (!_removedAura->IsRemoved())
        _removedAura->_Remove(AURA_REMOVE_BY_DEFAULT);
}

void DynamicObject::SetCasterViewpoint(bool updateViewerVisibility)
{
    if (Player* caster = _caster->ToPlayer())
    {
        // Remove old farsight viewpoint
        if (Unit* farsightObject = ObjectAccessor::GetUnit(*caster, caster->GetGuidValue(PLAYER_FARSIGHT)))
        {
            _oldFarsightGUID = caster->GetGuidValue(PLAYER_FARSIGHT);
            caster->SetViewpoint(farsightObject, false);
        }

        caster->SetViewpoint(this, true);
        _isViewpoint = true;
    }

    _updateViewerVisibilityTimer = updateViewerVisibility ? 100 : 0;
}

void DynamicObject::RemoveCasterViewpoint()
{
    if (Player* caster = _caster->ToPlayer())
    {
        caster->SetViewpoint(this, false);
        _isViewpoint = false;

        // Restore prev farsight viewpoint
        if (Unit* farsightObject = ObjectAccessor::GetUnit(*caster, _oldFarsightGUID))
        {
            caster->SetViewpoint(farsightObject, true);
        }
        _oldFarsightGUID.Clear();
    }
}

void DynamicObject::BindToCaster()
{
    ASSERT(!_caster);
    _caster = ObjectAccessor::GetUnit(*this, GetCasterGUID());
    ASSERT(_caster);
    ASSERT(_caster->GetMap() == GetMap());
    _caster->_RegisterDynObject(this);
}

void DynamicObject::UnbindFromCaster()
{
    ASSERT(_caster);
    _caster->_UnregisterDynObject(this);
    _caster = nullptr;
}

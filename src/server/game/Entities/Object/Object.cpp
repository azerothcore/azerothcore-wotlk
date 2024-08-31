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

#include "Object.h"
#include "Battlefield.h"
#include "BattlefieldMgr.h"
#include "CellImpl.h"
#include "Chat.h"
#include "Creature.h"
#include "DynamicVisibility.h"
#include "GameObjectAI.h"
#include "GameTime.h"
#include "GridNotifiers.h"
#include "Log.h"
#include "MapMgr.h"
#include "MiscPackets.h"
#include "MovementPacketBuilder.h"
#include "ObjectAccessor.h"
#include "ObjectMgr.h"
#include "Opcodes.h"
#include "OutdoorPvPMgr.h"
#include "Physics.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "SharedDefines.h"
#include "SpellAuraEffects.h"
#include "StringConvert.h"
#include "TargetedMovementGenerator.h"
#include "TemporarySummon.h"
#include "Tokenize.h"
#include "Totem.h"
#include "Transport.h"
#include "UpdateData.h"
#include "UpdateFieldFlags.h"
#include "UpdateMask.h"
#include "Util.h"
#include "Vehicle.h"
#include "World.h"
#include "WorldPacket.h"

/// @todo: this import is not necessary for compilation and marked as unused by the IDE
//  however, for some reasons removing it would cause a damn linking issue
//  there is probably some underlying problem with imports which should properly addressed
//  see: https://github.com/azerothcore/azerothcore-wotlk/issues/9766
#include "GridNotifiersImpl.h"

constexpr float VisibilityDistances[AsUnderlyingType(VisibilityDistanceType::Max)] =
{
    DEFAULT_VISIBILITY_DISTANCE,
    VISIBILITY_DISTANCE_TINY,
    VISIBILITY_DISTANCE_SMALL,
    VISIBILITY_DISTANCE_LARGE,
    VISIBILITY_DISTANCE_GIGANTIC,
    VISIBILITY_DISTANCE_INFINITE
};

Object::Object() : m_PackGUID(sizeof(uint64) + 1)
{
    m_objectTypeId      = TYPEID_OBJECT;
    m_objectType        = TYPEMASK_OBJECT;

    m_uint32Values      = nullptr;
    m_valuesCount       = 0;
    _fieldNotifyFlags   = UF_FLAG_DYNAMIC;

    m_inWorld           = false;
    m_objectUpdated     = false;

    sScriptMgr->OnConstructObject(this);
}

WorldObject::~WorldObject()
{
    sScriptMgr->OnWorldObjectDestroy(this);

    // this may happen because there are many !create/delete
    if (IsWorldObject() && m_currMap)
    {
        if (IsCorpse())
        {
            LOG_FATAL("entities.object", "Object::~Object Corpse {}, type={} deleted but still in map!!", GetGUID().ToString(), ((Corpse*)this)->GetType());
            ABORT();
        }
        ResetMap();
    }
}

Object::~Object()
{
    sScriptMgr->OnDestructObject(this);

    if (IsInWorld())
    {
        LOG_FATAL("entities.object", "Object::~Object - {} deleted but still in world!!", GetGUID().ToString());
        if (isType(TYPEMASK_ITEM))
            LOG_FATAL("entities.object", "Item slot {}", ((Item*)this)->GetSlot());
        ABORT();
    }

    if (m_objectUpdated)
    {
        LOG_FATAL("entities.object", "Object::~Object - {} deleted but still in update list!!", GetGUID().ToString());
        ABORT();
    }

    delete [] m_uint32Values;
    m_uint32Values = 0;
}

void Object::_InitValues()
{
    m_uint32Values = new uint32[m_valuesCount];
    memset(m_uint32Values, 0, m_valuesCount * sizeof(uint32));

    _changesMask.SetCount(m_valuesCount);

    m_objectUpdated = false;
}

void Object::_Create(ObjectGuid::LowType guidlow, uint32 entry, HighGuid guidhigh)
{
    if (!m_uint32Values) _InitValues();

    ObjectGuid guid(guidhigh, entry, guidlow);
    SetGuidValue(OBJECT_FIELD_GUID, guid);
    SetUInt32Value(OBJECT_FIELD_TYPE, m_objectType);
    m_PackGUID.Set(guid);
}

std::string Object::_ConcatFields(uint16 startIndex, uint16 size) const
{
    std::ostringstream ss;
    for (uint16 index = 0; index < size; ++index)
        ss << GetUInt32Value(index + startIndex) << ' ';
    return ss.str();
}

void Object::AddToWorld()
{
    if (m_inWorld)
        return;

    ASSERT(m_uint32Values);

    m_inWorld = true;

    // synchronize values mirror with values array (changes will send in updatecreate opcode any way
    ASSERT(!m_objectUpdated);
    ClearUpdateMask(false);
}

void Object::RemoveFromWorld()
{
    if (!m_inWorld)
        return;

    m_inWorld = false;

    // if we remove from world then sending changes not required
    ClearUpdateMask(true);
}

void Object::BuildMovementUpdateBlock(UpdateData* data, uint32 flags) const
{
    ByteBuffer buf(500);

    buf << uint8(UPDATETYPE_MOVEMENT);
    buf << GetPackGUID();

    BuildMovementUpdate(&buf, flags);

    data->AddUpdateBlock(buf);
}

void Object::BuildCreateUpdateBlockForPlayer(UpdateData* data, Player* target)
{
    if (!target)
        return;

    uint8  updatetype = UPDATETYPE_CREATE_OBJECT;
    uint16 flags      = m_updateFlag;

    /** lower flag1 **/
    if (target == this)                                      // building packet for yourself
        flags |= UPDATEFLAG_SELF;

    if (flags & UPDATEFLAG_STATIONARY_POSITION)
    {
        // UPDATETYPE_CREATE_OBJECT2 dynamic objects, corpses...
        if (isType(TYPEMASK_DYNAMICOBJECT) || isType(TYPEMASK_CORPSE) || isType(TYPEMASK_PLAYER))
            updatetype = UPDATETYPE_CREATE_OBJECT2;

        // UPDATETYPE_CREATE_OBJECT2 for pets...
        if (target->GetPetGUID() == GetGUID())
            updatetype = UPDATETYPE_CREATE_OBJECT2;

        // UPDATETYPE_CREATE_OBJECT2 for some gameobject types...
        if (isType(TYPEMASK_GAMEOBJECT))
        {
            switch (((GameObject*)this)->GetGoType())
            {
                case GAMEOBJECT_TYPE_TRAP:
                case GAMEOBJECT_TYPE_DUEL_ARBITER:
                case GAMEOBJECT_TYPE_FLAGSTAND:
                case GAMEOBJECT_TYPE_FLAGDROP:
                    updatetype = UPDATETYPE_CREATE_OBJECT2;
                    break;
                default:
                    if (((GameObject*)this)->GetOwner())
                        updatetype = UPDATETYPE_CREATE_OBJECT2;
                    break;
            }
        }

        if (isType(TYPEMASK_UNIT))
        {
            if (((Unit*)this)->GetVictim())
                flags |= UPDATEFLAG_HAS_TARGET;
        }
    }

    ByteBuffer buf(500);
    buf << (uint8)updatetype;
    buf << GetPackGUID();
    buf << (uint8)m_objectTypeId;

    BuildMovementUpdate(&buf, flags);
    BuildValuesUpdate(updatetype, &buf, target);
    data->AddUpdateBlock(buf);
}

void Object::SendUpdateToPlayer(Player* player)
{
    // send create update to player
    UpdateData upd;
    WorldPacket packet;

    BuildCreateUpdateBlockForPlayer(&upd, player);
    upd.BuildPacket(packet);
    player->GetSession()->SendPacket(&packet);
}

void Object::BuildValuesUpdateBlockForPlayer(UpdateData* data, Player* target)
{
    ByteBuffer buf(500);

    buf << (uint8) UPDATETYPE_VALUES;
    buf << GetPackGUID();

    BuildValuesUpdate(UPDATETYPE_VALUES, &buf, target);

    data->AddUpdateBlock(buf);
}

void Object::BuildOutOfRangeUpdateBlock(UpdateData* data) const
{
    data->AddOutOfRangeGUID(GetGUID());
}

void Object::DestroyForPlayer(Player* target, bool onDeath) const
{
    ASSERT(target);

    if (isType(TYPEMASK_UNIT) || isType(TYPEMASK_PLAYER))
    {
        if (Battleground* bg = target->GetBattleground())
        {
            if (bg->isArena())
            {
                WorldPacket data(SMSG_ARENA_UNIT_DESTROYED, 8);
                data << GetGUID();
                target->GetSession()->SendPacket(&data);
            }
        }
    }

    WorldPacket data(SMSG_DESTROY_OBJECT, 8 + 1);
    data << GetGUID();
    //! If the following bool is true, the client will call "void CGUnit_C::OnDeath()" for this object.
    //! OnDeath() does for eg trigger death animation and interrupts certain spells/missiles/auras/sounds...
    data << uint8(onDeath ? 1 : 0);
    target->GetSession()->SendPacket(&data);
}

[[nodiscard]] int32 Object::GetInt32Value(uint16 index) const
{
    ASSERT(index < m_valuesCount || PrintIndexError(index, false));
    return m_int32Values[index];
}

[[nodiscard]] uint32 Object::GetUInt32Value(uint16 index) const
{
    ASSERT(index < m_valuesCount || PrintIndexError(index, false));
    return m_uint32Values[index];
}

[[nodiscard]] uint64 Object::GetUInt64Value(uint16 index) const
{
    ASSERT(index + 1 < m_valuesCount || PrintIndexError(index, false));
    return *((uint64*) &(m_uint32Values[index]));
}

[[nodiscard]] float Object::GetFloatValue(uint16 index) const
{
    ASSERT(index < m_valuesCount || PrintIndexError(index, false));
    return m_floatValues[index];
}

[[nodiscard]] uint8 Object::GetByteValue(uint16 index, uint8 offset) const
{
    ASSERT(index < m_valuesCount || PrintIndexError(index, false));
    ASSERT(offset < 4);
    return *(((uint8*) &m_uint32Values[index]) + offset);
}

[[nodiscard]] uint16 Object::GetUInt16Value(uint16 index, uint8 offset) const
{
    ASSERT(index < m_valuesCount || PrintIndexError(index, false));
    ASSERT(offset < 2);
    return *(((uint16*) &m_uint32Values[index]) + offset);
}

[[nodiscard]] ObjectGuid Object::GetGuidValue(uint16 index) const
{
    ASSERT(index + 1 < m_valuesCount || PrintIndexError(index, false));
    return *((ObjectGuid*) &(m_uint32Values[index]));
}

void Object::BuildMovementUpdate(ByteBuffer* data, uint16 flags) const
{
    Unit const* unit = nullptr;
    WorldObject const* object = nullptr;

    if (isType(TYPEMASK_UNIT))
        unit = ToUnit();
    else
        object = ((WorldObject*)this);

    *data << uint16(flags);                                  // update flags

    // 0x20
    if (flags & UPDATEFLAG_LIVING)
    {
        unit->BuildMovementPacket(data);

        *data << unit->GetSpeed(MOVE_WALK)
              << unit->GetSpeed(MOVE_RUN)
              << unit->GetSpeed(MOVE_RUN_BACK)
              << unit->GetSpeed(MOVE_SWIM)
              << unit->GetSpeed(MOVE_SWIM_BACK)
              << unit->GetSpeed(MOVE_FLIGHT)
              << unit->GetSpeed(MOVE_FLIGHT_BACK)
              << unit->GetSpeed(MOVE_TURN_RATE)
              << unit->GetSpeed(MOVE_PITCH_RATE);

        // 0x08000000
        if (unit->m_movementInfo.GetMovementFlags() & MOVEMENTFLAG_SPLINE_ENABLED)
        {
            Movement::PacketBuilder::WriteCreate(*unit->movespline, *data);
        }
    }
    else
    {
        if (flags & UPDATEFLAG_POSITION)
        {
            Transport* transport = object->GetTransport();

            if (transport)
                *data << transport->GetPackGUID();
            else
                *data << uint8(0);

            *data << object->GetPositionX();
            *data << object->GetPositionY();
            *data << object->GetPositionZ();

            if (transport)
            {
                *data << object->GetTransOffsetX();
                *data << object->GetTransOffsetY();
                *data << object->GetTransOffsetZ();
            }
            else
            {
                *data << object->GetPositionX();
                *data << object->GetPositionY();
                *data << object->GetPositionZ();
            }

            *data << object->GetOrientation();

            if (IsCorpse())
                *data << float(object->GetOrientation());
            else
                *data << float(0);
        }
        else
        {
            // 0x40
            if (flags & UPDATEFLAG_STATIONARY_POSITION)
            {
                *data << object->GetStationaryX();
                *data << object->GetStationaryY();
                *data << object->GetStationaryZ();
                *data << object->GetStationaryO();
            }
        }
    }

    // 0x8
    if (flags & UPDATEFLAG_UNKNOWN)
    {
        *data << uint32(0);
    }

    // 0x10
    if (flags & UPDATEFLAG_LOWGUID)
    {
        switch (GetTypeId())
        {
            case TYPEID_OBJECT:
            case TYPEID_ITEM:
            case TYPEID_CONTAINER:
            case TYPEID_GAMEOBJECT:
            case TYPEID_DYNAMICOBJECT:
            case TYPEID_CORPSE:
                *data << uint32(GetGUID().GetCounter());
                break;
            //! Unit, Player and default here are sending wrong values.
            /// @todo Research the proper formula
            case TYPEID_UNIT:
                *data << uint32(0x0000000B);                // unk
                break;
            case TYPEID_PLAYER:
                if (flags & UPDATEFLAG_SELF)
                    *data << uint32(0x0000002F);            // unk
                else
                    *data << uint32(0x00000008);            // unk
                break;
            default:
                *data << uint32(0x00000000);                // unk
                break;
        }
    }

    // 0x4
    if (flags & UPDATEFLAG_HAS_TARGET)
    {
        if (Unit* victim = unit->GetVictim())
            *data << victim->GetPackGUID();
        else
            *data << uint8(0);
    }

    // 0x2
    if (flags & UPDATEFLAG_TRANSPORT)
    {
        GameObject const* go = ToGameObject();
        if (go && go->ToTransport())
            *data << uint32(go->ToTransport()->GetPathProgress());
        else
            *data << uint32(0);
    }

    // 0x80
    if (flags & UPDATEFLAG_VEHICLE)
    {
        /// @todo Allow players to aquire this updateflag.
        *data << uint32(unit->GetVehicleKit()->GetVehicleInfo()->m_ID);
        if (unit->HasUnitMovementFlag(MOVEMENTFLAG_ONTRANSPORT))
            *data << float(unit->GetTransOffsetO());
        else
            *data << float(unit->GetOrientation());
    }

    // 0x200
    if (flags & UPDATEFLAG_ROTATION)
    {
        *data << int64(ToGameObject()->GetPackedLocalRotation());
    }
}

void Object::BuildValuesUpdate(uint8 updateType, ByteBuffer* data, Player* target)
{
    if (!target)
        return;

    ByteBuffer fieldBuffer;
    UpdateMask updateMask;
    updateMask.SetCount(m_valuesCount);

    uint32* flags = nullptr;
    uint32 visibleFlag = GetUpdateFieldData(target, flags);

    for (uint16 index = 0; index < m_valuesCount; ++index)
    {
        if (_fieldNotifyFlags & flags[index] ||
                ((updateType == UPDATETYPE_VALUES ? _changesMask.GetBit(index) : m_uint32Values[index]) && (flags[index] & visibleFlag)))
        {
            updateMask.SetBit(index);
            fieldBuffer << m_uint32Values[index];
        }
    }

    *data << uint8(updateMask.GetBlockCount());
    updateMask.AppendToPacket(data);
    data->append(fieldBuffer);
}

void Object::AddToObjectUpdateIfNeeded()
{
    if (m_inWorld && !m_objectUpdated)
    {
        AddToObjectUpdate();
        m_objectUpdated = true;
    }
}

void Object::ClearUpdateMask(bool remove)
{
    _changesMask.Clear();

    if (m_objectUpdated)
    {
        if (remove)
            RemoveFromObjectUpdate();
        m_objectUpdated = false;
    }
}

void Object::BuildFieldsUpdate(Player* player, UpdateDataMapType& data_map)
{
    UpdateDataMapType::iterator iter = data_map.find(player);

    if (iter == data_map.end())
    {
        std::pair<UpdateDataMapType::iterator, bool> p = data_map.insert(UpdateDataMapType::value_type(player, UpdateData()));
        ASSERT(p.second);
        iter = p.first;
    }

    BuildValuesUpdateBlockForPlayer(&iter->second, iter->first);
}

uint32 Object::GetUpdateFieldData(Player const* target, uint32*& flags) const
{
    uint32 visibleFlag = UF_FLAG_PUBLIC;

    if (target == this)
        visibleFlag |= UF_FLAG_PRIVATE;

    switch (GetTypeId())
    {
        case TYPEID_ITEM:
        case TYPEID_CONTAINER:
            flags = ItemUpdateFieldFlags;
            if (((Item*)this)->GetOwnerGUID() == target->GetGUID())
                visibleFlag |= UF_FLAG_OWNER | UF_FLAG_ITEM_OWNER;
            break;
        case TYPEID_UNIT:
        case TYPEID_PLAYER:
            {
                Player* plr = ToUnit()->GetCharmerOrOwnerPlayerOrPlayerItself();
                flags = UnitUpdateFieldFlags;
                if (ToUnit()->GetOwnerGUID() == target->GetGUID())
                    visibleFlag |= UF_FLAG_OWNER;

                if (HasDynamicFlag(UNIT_DYNFLAG_SPECIALINFO))
                    if (ToUnit()->HasAuraTypeWithCaster(SPELL_AURA_EMPATHY, target->GetGUID()))
                        visibleFlag |= UF_FLAG_SPECIAL_INFO;

                if (plr && plr->IsInSameRaidWith(target))
                    visibleFlag |= UF_FLAG_PARTY_MEMBER;
                break;
            }
        case TYPEID_GAMEOBJECT:
            flags = GameObjectUpdateFieldFlags;
            if (ToGameObject()->GetOwnerGUID() == target->GetGUID())
                visibleFlag |= UF_FLAG_OWNER;
            break;
        case TYPEID_DYNAMICOBJECT:
            flags = DynamicObjectUpdateFieldFlags;
            if (((DynamicObject*)this)->GetCasterGUID() == target->GetGUID())
                visibleFlag |= UF_FLAG_OWNER;
            break;
        case TYPEID_CORPSE:
            flags = CorpseUpdateFieldFlags;
            if (ToCorpse()->GetOwnerGUID() == target->GetGUID())
                visibleFlag |= UF_FLAG_OWNER;
            break;
        case TYPEID_OBJECT:
            break;
    }

    return visibleFlag;
}

bool Object::_LoadIntoDataField(std::string const& data, uint32 startOffset, uint32 count)
{
    if (data.empty())
        return false;

    std::vector<std::string_view> tokens = Acore::Tokenize(data, ' ', false);

    if (tokens.size() != count)
        return false;

    for (uint32 index = 0; index < count; ++index)
    {
        Optional<uint32> val = Acore::StringTo<uint32>(tokens[index]);
        if (!val)
        {
            return false;
        }

        m_uint32Values[startOffset + index] = *val;
        _changesMask.SetBit(startOffset + index);
    }

    return true;
}

void Object::SetInt32Value(uint16 index, int32 value)
{
    ASSERT(index < m_valuesCount || PrintIndexError(index, true));

    if (m_int32Values[index] != value)
    {
        m_int32Values[index] = value;
        _changesMask.SetBit(index);

        AddToObjectUpdateIfNeeded();
    }
}

void Object::SetUInt32Value(uint16 index, uint32 value)
{
    ASSERT(index < m_valuesCount || PrintIndexError(index, true));

    if (m_uint32Values[index] != value)
    {
        m_uint32Values[index] = value;
        _changesMask.SetBit(index);

        AddToObjectUpdateIfNeeded();
    }
}

void Object::UpdateUInt32Value(uint16 index, uint32 value)
{
    ASSERT(index < m_valuesCount || PrintIndexError(index, true));

    m_uint32Values[index] = value;
    _changesMask.SetBit(index);
}

void Object::SetUInt64Value(uint16 index, uint64 value)
{
    ASSERT(index + 1 < m_valuesCount || PrintIndexError(index, true));

    if (*((uint64*) & (m_uint32Values[index])) != value)
    {
        m_uint32Values[index] = PAIR64_LOPART(value);
        m_uint32Values[index + 1] = PAIR64_HIPART(value);
        _changesMask.SetBit(index);
        _changesMask.SetBit(index + 1);

        AddToObjectUpdateIfNeeded();
    }
}

bool Object::AddGuidValue(uint16 index, ObjectGuid value)
{
    ASSERT(index + 1 < m_valuesCount || PrintIndexError(index, true));

    if (value && !*((ObjectGuid*)&(m_uint32Values[index])))
    {
        *((ObjectGuid*)&(m_uint32Values[index])) = value;
        _changesMask.SetBit(index);
        _changesMask.SetBit(index + 1);

        AddToObjectUpdateIfNeeded();

        return true;
    }

    return false;
}

bool Object::RemoveGuidValue(uint16 index, ObjectGuid value)
{
    ASSERT(index + 1 < m_valuesCount || PrintIndexError(index, true));

    if (value && *((ObjectGuid*)&(m_uint32Values[index])) == value)
    {
        m_uint32Values[index] = 0;
        m_uint32Values[index + 1] = 0;
        _changesMask.SetBit(index);
        _changesMask.SetBit(index + 1);

        AddToObjectUpdateIfNeeded();

        return true;
    }

    return false;
}

void Object::SetGuidValue(uint16 index, ObjectGuid value)
{
    ASSERT(index + 1 < m_valuesCount || PrintIndexError(index, true));

    if (*((ObjectGuid*)&(m_uint32Values[index])) != value)
    {
        *((ObjectGuid*)&(m_uint32Values[index])) = value;
        _changesMask.SetBit(index);
        _changesMask.SetBit(index + 1);

        AddToObjectUpdateIfNeeded();
    }
}

void Object::SetFloatValue(uint16 index, float value)
{
    ASSERT(index < m_valuesCount || PrintIndexError(index, true));

    if (m_floatValues[index] != value)
    {
        m_floatValues[index] = value;
        _changesMask.SetBit(index);

        AddToObjectUpdateIfNeeded();
    }
}

void Object::SetByteValue(uint16 index, uint8 offset, uint8 value)
{
    ASSERT(index < m_valuesCount || PrintIndexError(index, true));

    if (offset > 3)
    {
        LOG_ERROR("entities.object", "Object::SetByteValue: wrong offset {}", offset);
        return;
    }

    if (uint8(m_uint32Values[index] >> (offset * 8)) != value)
    {
        m_uint32Values[index] &= ~uint32(uint32(0xFF) << (offset * 8));
        m_uint32Values[index] |= uint32(uint32(value) << (offset * 8));
        _changesMask.SetBit(index);

        AddToObjectUpdateIfNeeded();
    }
}

void Object::SetUInt16Value(uint16 index, uint8 offset, uint16 value)
{
    ASSERT(index < m_valuesCount || PrintIndexError(index, true));

    if (offset > 1)
    {
        LOG_ERROR("entities.object", "Object::SetUInt16Value: wrong offset {}", offset);
        return;
    }

    if (uint16(m_uint32Values[index] >> (offset * 16)) != value)
    {
        m_uint32Values[index] &= ~uint32(uint32(0xFFFF) << (offset * 16));
        m_uint32Values[index] |= uint32(uint32(value) << (offset * 16));
        _changesMask.SetBit(index);

        AddToObjectUpdateIfNeeded();
    }
}

void Object::SetStatFloatValue(uint16 index, float value)
{
    if (value < 0)
        value = 0.0f;

    SetFloatValue(index, value);
}

void Object::SetStatInt32Value(uint16 index, int32 value)
{
    if (value < 0)
        value = 0;

    SetUInt32Value(index, uint32(value));
}

void Object::ApplyModUInt32Value(uint16 index, int32 val, bool apply)
{
    int32 cur = GetUInt32Value(index);
    cur += (apply ? val : -val);
    if (cur < 0)
        cur = 0;
    SetUInt32Value(index, cur);
}

void Object::ApplyModInt32Value(uint16 index, int32 val, bool apply)
{
    int32 cur = GetInt32Value(index);
    cur += (apply ? val : -val);
    SetInt32Value(index, cur);
}

void Object::ApplyModSignedFloatValue(uint16 index, float  val, bool apply)
{
    float cur = GetFloatValue(index);
    cur += (apply ? val : -val);
    SetFloatValue(index, cur);
}

void Object::ApplyPercentModFloatValue(uint16 index, float val, bool apply)
{
    float value = GetFloatValue(index);
    ApplyPercentModFloatVar(value, val, apply);
    SetFloatValue(index, value);
}

void Object::ApplyModPositiveFloatValue(uint16 index, float  val, bool apply)
{
    float cur = GetFloatValue(index);
    cur += (apply ? val : -val);
    if (cur < 0)
        cur = 0;
    SetFloatValue(index, cur);
}

void Object::SetFlag(uint16 index, uint32 newFlag)
{
    ASSERT(index < m_valuesCount || PrintIndexError(index, true));
    uint32 oldval = m_uint32Values[index];
    uint32 newval = oldval | newFlag;

    if (oldval != newval)
    {
        m_uint32Values[index] = newval;
        _changesMask.SetBit(index);

        AddToObjectUpdateIfNeeded();
    }
}

void Object::RemoveFlag(uint16 index, uint32 oldFlag)
{
    ASSERT(index < m_valuesCount || PrintIndexError(index, true));
    ASSERT(m_uint32Values);

    uint32 oldval = m_uint32Values[index];
    uint32 newval = oldval & ~oldFlag;

    if (oldval != newval)
    {
        m_uint32Values[index] = newval;
        _changesMask.SetBit(index);

        AddToObjectUpdateIfNeeded();
    }
}

void Object::ToggleFlag(uint16 index, uint32 flag)
{
    if (HasFlag(index, flag))
    {
        RemoveFlag(index, flag);
    }
    else
    {
        SetFlag(index, flag);
    }
}

[[nodiscard]] bool Object::HasFlag(uint16 index, uint32 flag) const
{
    if (index >= m_valuesCount && !PrintIndexError(index, false))
    {
        return false;
    }

    return (m_uint32Values[index] & flag) != 0;
}

void Object::ApplyModFlag(uint16 index, uint32 flag, bool apply)
{
    if (apply)
    {
        SetFlag(index, flag);
    }
    else
    {
        RemoveFlag(index, flag);
    }
}

void Object::SetByteFlag(uint16 index, uint8 offset, uint8 newFlag)
{
    ASSERT(index < m_valuesCount || PrintIndexError(index, true));

    if (offset > 3)
    {
        LOG_ERROR("entities.object", "Object::SetByteFlag: wrong offset {}", offset);
        return;
    }

    if (!(uint8(m_uint32Values[index] >> (offset * 8)) & newFlag))
    {
        m_uint32Values[index] |= uint32(uint32(newFlag) << (offset * 8));
        _changesMask.SetBit(index);

        AddToObjectUpdateIfNeeded();
    }
}

void Object::RemoveByteFlag(uint16 index, uint8 offset, uint8 oldFlag)
{
    ASSERT(index < m_valuesCount || PrintIndexError(index, true));

    if (offset > 3)
    {
        LOG_ERROR("entities.object", "Object::RemoveByteFlag: wrong offset {}", offset);
        return;
    }

    if (uint8(m_uint32Values[index] >> (offset * 8)) & oldFlag)
    {
        m_uint32Values[index] &= ~uint32(uint32(oldFlag) << (offset * 8));
        _changesMask.SetBit(index);

        AddToObjectUpdateIfNeeded();
    }
}

[[nodiscard]] bool Object::HasByteFlag(uint16 index, uint8 offset, uint8 flag) const
{
    ASSERT(index < m_valuesCount || PrintIndexError(index, false));
    ASSERT(offset < 4);
    return (((uint8*) &m_uint32Values[index])[offset] & flag) != 0;
}

void Object::SetFlag64(uint16 index, uint64 newFlag)
{
    uint64 oldval = GetUInt64Value(index);
    uint64 newval = oldval | newFlag;
    SetUInt64Value(index, newval);
}

void Object::RemoveFlag64(uint16 index, uint64 oldFlag)
{
    uint64 oldval = GetUInt64Value(index);
    uint64 newval = oldval & ~oldFlag;
    SetUInt64Value(index, newval);
}

void Object::ToggleFlag64(uint16 index, uint64 flag)
{
    if (HasFlag64(index, flag))
    {
        RemoveFlag64(index, flag);
    }
    else
    {
        SetFlag64(index, flag);
    }
}

[[nodiscard]] bool Object::HasFlag64(uint16 index, uint64 flag) const
{
    ASSERT(index < m_valuesCount || PrintIndexError(index, false));
    return (GetUInt64Value(index) & flag) != 0;
}

void Object::ApplyModFlag64(uint16 index, uint64 flag, bool apply)
{
    if (apply)
    {
        SetFlag64(index, flag);
    }
    else
    {
        RemoveFlag64(index, flag);
    }
}

bool Object::PrintIndexError(uint32 index, bool set) const
{
    LOG_INFO("misc", "Attempt {} non-existed value field: {} (count: {}) for object typeid: {} type mask: {}",
        (set ? "set value to" : "get value from"), index, m_valuesCount, GetTypeId(), m_objectType);

    // ASSERT must fail after function call
    return false;
}

std::string Object::GetDebugInfo() const
{
    std::stringstream sstr;
    sstr << GetGUID().ToString() + " Entry " << GetEntry();
    return sstr.str();
}

void MovementInfo::OutDebug()
{
    LOG_INFO("movement", "MOVEMENT INFO");
    LOG_INFO("movement", "guid {}", guid.ToString());
    LOG_INFO("movement", "flags {}", flags);
    LOG_INFO("movement", "flags2 {}", flags2);
    LOG_INFO("movement", "time {} current time {}", flags2, uint64(::GameTime::GetGameTime().count()));
    LOG_INFO("movement", "position: `{}`", pos.ToString());

    if (flags & MOVEMENTFLAG_ONTRANSPORT)
    {
        LOG_INFO("movement", "TRANSPORT:");
        LOG_INFO("movement", "guid: {}", transport.guid.ToString());
        LOG_INFO("movement", "position: `{}`", transport.pos.ToString());
        LOG_INFO("movement", "seat: {}", transport.seat);
        LOG_INFO("movement", "time: {}", transport.time);

        if (flags2 & MOVEMENTFLAG2_INTERPOLATED_MOVEMENT)
        {
            LOG_INFO("movement", "time2: {}", transport.time2);
        }
    }

    if ((flags & (MOVEMENTFLAG_SWIMMING | MOVEMENTFLAG_FLYING)) || (flags2 & MOVEMENTFLAG2_ALWAYS_ALLOW_PITCHING))
        LOG_INFO("movement", "pitch: {}", pitch);

    LOG_INFO("movement", "fallTime: {}", fallTime);
    if (flags & MOVEMENTFLAG_FALLING)
        LOG_INFO("movement", "j_zspeed: {} j_sinAngle: {} j_cosAngle: {} j_xyspeed: {}", jump.zspeed, jump.sinAngle, jump.cosAngle, jump.xyspeed);

    if (flags & MOVEMENTFLAG_SPLINE_ELEVATION)
        LOG_INFO("movement", "splineElevation: {}", splineElevation);
}

WorldObject::WorldObject(bool isWorldObject) : WorldLocation(),
    LastUsedScriptID(0), m_name(""), m_isActive(false), m_visibilityDistanceOverride(), m_isWorldObject(isWorldObject), m_zoneScript(nullptr),
    _zoneId(0), _areaId(0), _floorZ(INVALID_HEIGHT), _outdoors(false), _liquidData(), _updatePositionData(false), m_transport(nullptr),
    m_currMap(nullptr), m_InstanceId(0), m_phaseMask(PHASEMASK_NORMAL), m_useCombinedPhases(true), m_notifyflags(0), m_executed_notifies(0)
{
    m_serverSideVisibility.SetValue(SERVERSIDE_VISIBILITY_GHOST, GHOST_VISIBILITY_ALIVE | GHOST_VISIBILITY_GHOST);
    m_serverSideVisibilityDetect.SetValue(SERVERSIDE_VISIBILITY_GHOST, GHOST_VISIBILITY_ALIVE);

    sScriptMgr->OnWorldObjectCreate(this);
}

void WorldObject::Update(uint32 time_diff)
{
    sScriptMgr->OnWorldObjectUpdate(this, time_diff);
}

void WorldObject::SetWorldObject(bool on)
{
    if (!IsInWorld())
        return;

    GetMap()->AddObjectToSwitchList(this, on);
}

bool WorldObject::IsWorldObject() const
{
    if (m_isWorldObject)
        return true;

    if (ToCreature() && ToCreature()->m_isTempWorldObject)
        return true;

    return false;
}

void WorldObject::setActive(bool on)
{
    if (m_isActive == on)
        return;

    if (IsPlayer())
        return;

    //npcbot: bots should never be removed from active
    if (on == false && IsNPCBotOrPet())
        return;
    //end npcbot

    m_isActive = on;

    if (on && !IsInWorld())
        return;

    Map* map = FindMap();
    if (!map)
        return;

    if (on)
    {
        if (GetTypeId() == TYPEID_UNIT)
            map->AddToActive(this->ToCreature());
        else if (IsDynamicObject())
            map->AddToActive((DynamicObject*)this);
        else if (GetTypeId() == TYPEID_GAMEOBJECT)
            map->AddToActive((GameObject*)this);
    }
    else
    {
        if (GetTypeId() == TYPEID_UNIT)
            map->RemoveFromActive(this->ToCreature());
        else if (IsDynamicObject())
            map->RemoveFromActive((DynamicObject*)this);
        else if (GetTypeId() == TYPEID_GAMEOBJECT)
            map->RemoveFromActive((GameObject*)this);
    }
}

void WorldObject::SetVisibilityDistanceOverride(VisibilityDistanceType type)
{
    ASSERT(type < VisibilityDistanceType::Max);
    if (IsPlayer())
    {
        return;
    }

    m_visibilityDistanceOverride = VisibilityDistances[AsUnderlyingType(type)];
}

void WorldObject::CleanupsBeforeDelete(bool /*finalCleanup*/)
{
    if (IsInWorld())
        RemoveFromWorld();
}

void WorldObject::_Create(ObjectGuid::LowType guidlow, HighGuid guidhigh, uint32 phaseMask)
{
    Object::_Create(guidlow, 0, guidhigh);
    SetPhaseMask(phaseMask, false);
}

void WorldObject::SetPositionDataUpdate()
{
    _updatePositionData = true;

    // Calls immediately for charmed units
    if (GetTypeId() == TYPEID_UNIT && ToUnit()->IsCharmedOwnedByPlayerOrPlayer())
        UpdatePositionData();
    //npcbot
    else if (IsNPCBotOrPet() && ToUnit()->IsControlledByPlayer())
        UpdatePositionData();
    //end npcbot
}

void WorldObject::UpdatePositionData()
{
    _updatePositionData = false;

    PositionFullTerrainStatus data;
    GetMap()->GetFullTerrainStatusForPosition(GetPhaseMask(), GetPositionX(), GetPositionY(), GetPositionZ(), GetCollisionHeight(), data);
    ProcessPositionDataChanged(data);
}

void WorldObject::ProcessPositionDataChanged(PositionFullTerrainStatus const& data)
{
    _zoneId = _areaId = data.areaId;

    if (AreaTableEntry const* area = sAreaTableStore.LookupEntry(_areaId))
        if (area->zone)
            _zoneId = area->zone;

    _outdoors   = data.outdoors;
    _floorZ     = data.floorZ;
    _liquidData = data.liquidInfo;
}

void WorldObject::AddToWorld()
{
    Object::AddToWorld();
    GetMap()->GetZoneAndAreaId(GetPhaseMask(), _zoneId, _areaId, GetPositionX(), GetPositionY(), GetPositionZ());
}

void WorldObject::RemoveFromWorld()
{
    if (!IsInWorld())
        return;

    DestroyForNearbyPlayers();

    Object::RemoveFromWorld();
}

InstanceScript* WorldObject::GetInstanceScript() const
{
    Map* map = GetMap();
    return map->IsDungeon() ? map->ToInstanceMap()->GetInstanceScript() : nullptr;
}

float WorldObject::GetDistanceZ(WorldObject const* obj) const
{
    float dz = std::fabs(GetPositionZ() - obj->GetPositionZ());
    float sizefactor = GetObjectSize() + obj->GetObjectSize();
    float dist = dz - sizefactor;
    return (dist > 0 ? dist : 0);
}

bool WorldObject::_IsWithinDist(WorldObject const* obj, float dist2compare, bool is3D, bool useBoundingRadius) const
{
    float sizefactor = useBoundingRadius ? GetObjectSize() + obj->GetObjectSize() : 0.0f;
    float maxdist = dist2compare + sizefactor;

    if (m_transport && obj->GetTransport() &&  obj->GetTransport()->GetGUID() == m_transport->GetGUID())
    {
        float dtx = m_movementInfo.transport.pos.m_positionX - obj->m_movementInfo.transport.pos.m_positionX;
        float dty = m_movementInfo.transport.pos.m_positionY - obj->m_movementInfo.transport.pos.m_positionY;
        float disttsq = dtx * dtx + dty * dty;
        if (is3D)
        {
            float dtz = m_movementInfo.transport.pos.m_positionZ - obj->m_movementInfo.transport.pos.m_positionZ;
            disttsq += dtz * dtz;
        }
        return disttsq < (maxdist * maxdist);
    }

    float dx = GetPositionX() - obj->GetPositionX();
    float dy = GetPositionY() - obj->GetPositionY();
    float distsq = dx * dx + dy * dy;
    if (is3D)
    {
        float dz = GetPositionZ() - obj->GetPositionZ();
        distsq += dz * dz;
    }

    return distsq < maxdist * maxdist;
}

Position WorldObject::GetHitSpherePointFor(Position const& dest, Optional<float> collisionHeight, Optional<float> combatReach) const
{
    G3D::Vector3 vThis(GetPositionX(), GetPositionY(), GetPositionZ() + (collisionHeight ? *collisionHeight : GetCollisionHeight()));
    G3D::Vector3 vObj(dest.GetPositionX(), dest.GetPositionY(), dest.GetPositionZ());
    G3D::Vector3 contactPoint = vThis + (vObj - vThis).directionOrZero() * std::min(dest.GetExactDist(this), (combatReach ? *combatReach : GetCombatReach()));

    return Position(contactPoint.x, contactPoint.y, contactPoint.z, GetAngle(contactPoint.x, contactPoint.y));
}

float WorldObject::GetDistance(WorldObject const* obj) const
{
    float d = GetExactDist(obj) - GetObjectSize() - obj->GetObjectSize();
    return d > 0.0f ? d : 0.0f;
}

[[nodiscard]] float WorldObject::GetDistance(const Position& pos) const
{
    float d = GetExactDist(&pos) - GetObjectSize();
    return d > 0.0f ? d : 0.0f;
}

[[nodiscard]] float WorldObject::GetDistance(float x, float y, float z) const
{
    float d = GetExactDist(x, y, z) - GetObjectSize();
    return d > 0.0f ? d : 0.0f;
}

float WorldObject::GetDistance2d(WorldObject const* obj) const
{
    float d = GetExactDist2d(obj) - GetObjectSize() - obj->GetObjectSize();
    return d > 0.0f ? d : 0.0f;
}

[[nodiscard]] float WorldObject::GetDistance2d(float x, float y) const
{
    float d = GetExactDist2d(x, y) - GetObjectSize();
    return d > 0.0f ? d : 0.0f;
}

bool WorldObject::IsSelfOrInSameMap(WorldObject const* obj) const
{
    if (this == obj)
    {
        return true;
    }

    return IsInMap(obj);
}

bool WorldObject::IsInMap(WorldObject const* obj) const
{
    if (obj)
    {
        return IsInWorld() && obj->IsInWorld() && (FindMap() == obj->FindMap());
    }

    return false;
}

[[nodiscard]] bool WorldObject::IsWithinDist3d(float x, float y, float z, float dist) const
{
    return IsInDist(x, y, z, dist + GetObjectSize());
}

bool WorldObject::IsWithinDist3d(const Position* pos, float dist) const
{
    return IsInDist(pos, dist + GetObjectSize());
}

[[nodiscard]] bool WorldObject::IsWithinDist2d(float x, float y, float dist) const
{
    return IsInDist2d(x, y, dist + GetObjectSize());
}

bool WorldObject::IsWithinDist2d(const Position* pos, float dist) const
{
    return IsInDist2d(pos, dist + GetObjectSize());
}

// use only if you will sure about placing both object at same map
bool WorldObject::IsWithinDist(WorldObject const* obj, float dist2compare, bool is3D, bool useBoundingRadius) const
{
    return obj && _IsWithinDist(obj, dist2compare, is3D, useBoundingRadius);
}

bool WorldObject::IsWithinDistInMap(WorldObject const* obj, float dist2compare, bool is3D, bool useBoundingRadius) const
{
    return obj && IsInMap(obj) && InSamePhase(obj) && _IsWithinDist(obj, dist2compare, is3D, useBoundingRadius);
}

bool WorldObject::IsWithinLOS(float ox, float oy, float oz, VMAP::ModelIgnoreFlags ignoreFlags, LineOfSightChecks checks) const
{
    if (IsInWorld())
    {
        oz += GetCollisionHeight();
        float x, y, z;
        if (IsPlayer())
        {
            GetPosition(x, y, z);
            z += GetCollisionHeight();
        }
        else
        {
            GetHitSpherePointFor({ ox, oy, oz }, x, y, z);
        }

        return GetMap()->isInLineOfSight(x, y, z, ox, oy, oz, GetPhaseMask(), checks, ignoreFlags);
    }
    return true;
}

bool WorldObject::IsWithinLOSInMap(WorldObject const* obj, VMAP::ModelIgnoreFlags ignoreFlags, LineOfSightChecks checks, Optional<float> collisionHeight /*= { }*/, Optional<float> combatReach /*= { }*/) const
{
   if (!IsInMap(obj))
        return false;

    float ox, oy, oz;
    if (obj->IsPlayer())
    {
        obj->GetPosition(ox, oy, oz);
        oz += obj->GetCollisionHeight();
    }
    else
        obj->GetHitSpherePointFor({ GetPositionX(), GetPositionY(), GetPositionZ() + (collisionHeight ? *collisionHeight : GetCollisionHeight()) }, ox, oy, oz);

    float x, y, z;
    if (IsPlayer())
    {
        GetPosition(x, y, z);
        z += GetCollisionHeight();
    }
    else
        GetHitSpherePointFor({ obj->GetPositionX(), obj->GetPositionY(), obj->GetPositionZ() + obj->GetCollisionHeight() }, x, y, z, collisionHeight, combatReach);

    return GetMap()->isInLineOfSight(x, y, z, ox, oy, oz, GetPhaseMask(), checks, ignoreFlags);
}

void WorldObject::GetHitSpherePointFor(Position const& dest, float& x, float& y, float& z, Optional<float> collisionHeight, Optional<float> combatReach) const
{
    Position pos = GetHitSpherePointFor(dest, collisionHeight, combatReach);
    x = pos.GetPositionX();
    y = pos.GetPositionY();
    z = pos.GetPositionZ();
}

bool WorldObject::GetDistanceOrder(WorldObject const* obj1, WorldObject const* obj2, bool is3D /* = true */) const
{
    float dx1 = GetPositionX() - obj1->GetPositionX();
    float dy1 = GetPositionY() - obj1->GetPositionY();
    float distsq1 = dx1 * dx1 + dy1 * dy1;
    if (is3D)
    {
        float dz1 = GetPositionZ() - obj1->GetPositionZ();
        distsq1 += dz1 * dz1;
    }

    float dx2 = GetPositionX() - obj2->GetPositionX();
    float dy2 = GetPositionY() - obj2->GetPositionY();
    float distsq2 = dx2 * dx2 + dy2 * dy2;
    if (is3D)
    {
        float dz2 = GetPositionZ() - obj2->GetPositionZ();
        distsq2 += dz2 * dz2;
    }

    return distsq1 < distsq2;
}

bool WorldObject::IsInRange(WorldObject const* obj, float minRange, float maxRange, bool is3D /* = true */) const
{
    float dx = GetPositionX() - obj->GetPositionX();
    float dy = GetPositionY() - obj->GetPositionY();
    float distsq = dx * dx + dy * dy;
    if (is3D)
    {
        float dz = GetPositionZ() - obj->GetPositionZ();
        distsq += dz * dz;
    }

    float sizefactor = GetObjectSize() + obj->GetObjectSize();

    // check only for real range
    if (minRange > 0.0f)
    {
        float mindist = minRange + sizefactor;
        if (distsq < mindist * mindist)
            return false;
    }

    float maxdist = maxRange + sizefactor;
    return distsq < maxdist * maxdist;
}

bool WorldObject::IsInRange2d(float x, float y, float minRange, float maxRange) const
{
    float dx = GetPositionX() - x;
    float dy = GetPositionY() - y;
    float distsq = dx * dx + dy * dy;

    float sizefactor = GetObjectSize();

    // check only for real range
    if (minRange > 0.0f)
    {
        float mindist = minRange + sizefactor;
        if (distsq < mindist * mindist)
            return false;
    }

    float maxdist = maxRange + sizefactor;
    return distsq < maxdist * maxdist;
}

bool WorldObject::IsInRange3d(float x, float y, float z, float minRange, float maxRange) const
{
    float dx = GetPositionX() - x;
    float dy = GetPositionY() - y;
    float dz = GetPositionZ() - z;
    float distsq = dx * dx + dy * dy + dz * dz;

    float sizefactor = GetObjectSize();

    // check only for real range
    if (minRange > 0.0f)
    {
        float mindist = minRange + sizefactor;
        if (distsq < mindist * mindist)
            return false;
    }

    float maxdist = maxRange + sizefactor;
    return distsq < maxdist * maxdist;
}

bool WorldObject::IsInBetween(WorldObject const* obj1, WorldObject const* obj2, float size) const
{
    if (!obj1 || !obj2)
        return false;

    if (!size)
        size = GetObjectSize() / 2;

    float pdist = obj1->GetExactDist2dSq(obj2) + size / 2.0f;
    if (GetExactDist2dSq(obj1) >= pdist || GetExactDist2dSq(obj2) >= pdist)
        return false;

    if (G3D::fuzzyEq(obj1->GetPositionX(), obj2->GetPositionX()))
        return GetPositionX() >= obj1->GetPositionX() - size && GetPositionX() <= obj1->GetPositionX() + size;

    float A = (obj2->GetPositionY() - obj1->GetPositionY()) / (obj2->GetPositionX() - obj1->GetPositionX());
    float B = -1;
    float C = obj1->GetPositionY() - A * obj1->GetPositionX();
    float dist = std::fabs(A * GetPositionX() + B * GetPositionY() + C) / std::sqrt(A * A + B * B);
    return dist <= size;
}

bool WorldObject::isInFront(WorldObject const* target,  float arc) const
{
    return HasInArc(arc, target);
}

bool WorldObject::isInBack(WorldObject const* target, float arc) const
{
    return !HasInArc(2 * M_PI - arc, target);
}

void WorldObject::GetRandomPoint(const Position& pos, float distance, float& rand_x, float& rand_y, float& rand_z) const
{
    if (!distance)
    {
        pos.GetPosition(rand_x, rand_y, rand_z);
        return;
    }

    // angle to face `obj` to `this`
    float angle = (float)rand_norm() * static_cast<float>(2 * M_PI);
    float new_dist = (float)rand_norm() * static_cast<float>(distance);

    rand_x = pos.m_positionX + new_dist * cos(angle);
    rand_y = pos.m_positionY + new_dist * std::sin(angle);
    rand_z = pos.m_positionZ;

    Acore::NormalizeMapCoord(rand_x);
    Acore::NormalizeMapCoord(rand_y);
    UpdateGroundPositionZ(rand_x, rand_y, rand_z);            // update to LOS height if available
}

Position WorldObject::GetRandomPoint(const Position& srcPos, float distance) const
{
    float x, y, z;
    GetRandomPoint(srcPos, distance, x, y, z);
    return Position(x, y, z, GetOrientation());
}

void WorldObject::UpdateGroundPositionZ(float x, float y, float &z) const
{
    float new_z = GetMapHeight(x, y, z);
    if (new_z > INVALID_HEIGHT)
        z = new_z + (isType(TYPEMASK_UNIT) ? static_cast<Unit const*>(this)->GetHoverHeight() : 0.0f);
}

/**
 * @brief Get the minimum height of a object that should be in water
 * to start floating/swim
 *
 * @return float
 */
float WorldObject::GetMinHeightInWater() const
{
    // have a fun with Archimedes' formula
    auto height = GetCollisionHeight();
    auto width = GetCollisionWidth();
    auto weight = getWeight(height, width, 1040); // avg human specific weight
    auto heightOutOfWater = getOutOfWater(width, weight, 10202) * 4.0f; // avg human density
    auto heightInWater = height - heightOutOfWater;
    return (height > heightInWater ? heightInWater : (height - (height / 3)));
}

void WorldObject::UpdateAllowedPositionZ(float x, float y, float& z, float* groundZ) const
{
    if (GetTransport())
    {
        if (groundZ)
            *groundZ = z;

        return;
    }

    if (Unit const* unit = ToUnit())
    {
        if (!unit->CanFly())
        {
            Creature const* c = unit->ToCreature();
            bool canSwim = c ? c->CanSwim() : true;
            float ground_z = z;
            float max_z;
            if (canSwim)
                max_z = GetMapWaterOrGroundLevel(x, y, z, &ground_z);
            else
                max_z = ground_z = GetMapHeight(x, y, z);

            if (max_z > INVALID_HEIGHT)
            {
                if (canSwim && unit->GetMap()->IsInWater(unit->GetPhaseMask(), x, y, max_z - Z_OFFSET_FIND_HEIGHT, unit->GetCollisionHeight()))
                {
                    // do not allow creatures to walk on
                    // water level while swimming
                    max_z = std::max(max_z - GetMinHeightInWater(), ground_z);
                }
                else
                {
                    // hovering units cannot go below their hover height
                    float hoverOffset = unit->GetHoverHeight();
                    max_z += hoverOffset;
                    ground_z += hoverOffset;
                }

                if (z > max_z)
                    z = max_z;
                else if (z < ground_z)
                    z = ground_z;
            }

            if (groundZ)
                *groundZ = ground_z;
        }
        else
        {
            float ground_z = GetMapHeight(x, y, z) + unit->GetHoverHeight();
            if (z < ground_z)
                z = ground_z;

            if (groundZ)
               *groundZ = ground_z;
        }
    }
    else
    {
        float ground_z = GetMapHeight(x, y, z);
        if (ground_z > INVALID_HEIGHT)
            z = ground_z;

        if (groundZ)
            *groundZ = ground_z;
    }
}

float WorldObject::GetGridActivationRange() const
{
    if (ToPlayer())
    {
        if (ToPlayer()->GetCinematicMgr()->IsOnCinematic())
        {
            return DEFAULT_VISIBILITY_INSTANCE;
        }
        return IsInWintergrasp() ? VISIBILITY_DIST_WINTERGRASP : GetMap()->GetVisibilityRange();
    }
    else if (ToCreature())
    {
        return ToCreature()->m_SightDistance;
    }
    else if (((GetTypeId() == TYPEID_GAMEOBJECT && ToGameObject()->IsTransport()) || IsDynamicObject()) && isActiveObject())
    {
        return GetMap()->GetVisibilityRange();
    }

    return 0.0f;
}

float WorldObject::GetVisibilityRange() const
{
    if (IsVisibilityOverridden() && GetTypeId() == TYPEID_UNIT)
    {
        return *m_visibilityDistanceOverride;
    }
    else if (GetTypeId() == TYPEID_GAMEOBJECT)
    {
        {
            if (IsInWintergrasp())
            {
                return VISIBILITY_DIST_WINTERGRASP + VISIBILITY_INC_FOR_GOBJECTS;
            }
            else if (IsVisibilityOverridden())
            {
                return *m_visibilityDistanceOverride;
            }
            else
            {
                return GetMap()->GetVisibilityRange() + VISIBILITY_INC_FOR_GOBJECTS;
            }
        }
    }
    else
        return IsInWintergrasp() ? VISIBILITY_DIST_WINTERGRASP : GetMap()->GetVisibilityRange();
}

float WorldObject::GetSightRange(WorldObject const* target) const
{
    if (ToUnit())
    {
        if (ToPlayer())
        {
            if (target)
            {
                if (target->IsVisibilityOverridden() && target->GetTypeId() == TYPEID_UNIT)
                {
                    return *target->m_visibilityDistanceOverride;
                }
                else if (target->GetTypeId() == TYPEID_GAMEOBJECT)
                {
                    if (IsInWintergrasp() && target->IsInWintergrasp())
                    {
                        return VISIBILITY_DIST_WINTERGRASP + VISIBILITY_INC_FOR_GOBJECTS;
                    }
                    else if (target->IsVisibilityOverridden())
                    {
                        return *target->m_visibilityDistanceOverride;
                    }
                    else if (ToPlayer()->GetCinematicMgr()->IsOnCinematic())
                    {
                        return DEFAULT_VISIBILITY_INSTANCE;
                    }
                    else
                    {
                        return GetMap()->GetVisibilityRange() + VISIBILITY_INC_FOR_GOBJECTS;
                    }
                }

                return IsInWintergrasp() && target->IsInWintergrasp() ? VISIBILITY_DIST_WINTERGRASP : GetMap()->GetVisibilityRange();
            }
            return IsInWintergrasp() ? VISIBILITY_DIST_WINTERGRASP : GetMap()->GetVisibilityRange();
        }
        else if (ToCreature())
        {
            return ToCreature()->m_SightDistance;
        }
        else
        {
            return SIGHT_RANGE_UNIT;
        }
    }

    if (ToDynObject() && isActiveObject())
    {
        return GetMap()->GetVisibilityRange();
    }

    return 0.0f;
}

bool WorldObject::CanSeeOrDetect(WorldObject const* obj, bool ignoreStealth, bool distanceCheck, bool checkAlert) const
{
    if (this == obj)
        return true;

    if (obj->IsNeverVisible() || CanNeverSee(obj))
        return false;

    if (obj->IsAlwaysVisibleFor(this) || CanAlwaysSee(obj))
        return true;

    // Creature scripts
    if (Creature const* cObj = obj->ToCreature())
    {
        if (Player const* player = ToPlayer())
        {
            if (cObj->IsAIEnabled && !cObj->AI()->CanBeSeen(player))
            {
                return false;
            }

            ConditionList conditions = sConditionMgr->GetConditionsForNotGroupedEntry(CONDITION_SOURCE_TYPE_CREATURE_VISIBILITY, cObj->GetEntry());
            if (!sConditionMgr->IsObjectMeetToConditions((WorldObject*)this, (WorldObject*)obj, conditions))
            {
                return false;
            }
        }
    }

    // Gameobject scripts
    if (GameObject const* goObj = obj->ToGameObject())
    {
        if (ToPlayer() && !goObj->AI()->CanBeSeen(ToPlayer()))
        {
            return false;
        }
    }

    // pussywizard: arena spectator
    if (obj->IsPlayer())
        if (((Player const*)obj)->IsSpectator() && ((Player const*)obj)->FindMap()->IsBattleArena())
            return false;

    bool corpseVisibility = false;
    if (distanceCheck)
    {
        bool corpseCheck = false;
        WorldObject const* viewpoint = this;
        if (Player const* thisPlayer = ToPlayer())
        {
            if (Creature const* creature = obj->ToCreature())
            {
                if (TempSummon const* tempSummon = creature->ToTempSummon())
                {
                    if (tempSummon->IsVisibleBySummonerOnly() && GetGUID() != tempSummon->GetSummonerGUID())
                    {
                        return false;
                    }
                }
            }

            if (thisPlayer->isDead() && thisPlayer->GetHealth() > 0 && // Cheap way to check for ghost state
                    !(obj->m_serverSideVisibility.GetValue(SERVERSIDE_VISIBILITY_GHOST) & m_serverSideVisibility.GetValue(SERVERSIDE_VISIBILITY_GHOST) & GHOST_VISIBILITY_GHOST))
            {
                if (Corpse* corpse = thisPlayer->GetCorpse())
                {
                    corpseCheck = true;
                    if (corpse->IsWithinDist(thisPlayer, GetSightRange(obj), false))
                        if (corpse->IsWithinDist(obj, GetSightRange(obj), false))
                            corpseVisibility = true;
                }
            }

            // our additional checks
            if (Unit const* target = obj->ToUnit())
            {
                // xinef: don't allow to detect vehicle accessory if you can't see vehicle base!
                if (Unit const* vehicle = target->GetVehicleBase())
                    if (!thisPlayer->HaveAtClient(vehicle))
                        return false;

                // pussywizard: during arena preparation, don't allow to detect pets if can't see its owner (spoils enemy arena frames)
                if (target->IsPet() && target->GetOwnerGUID() && target->FindMap()->IsBattleArena() && GetGUID() != target->GetOwnerGUID())
                    if (BattlegroundMap* bgmap = target->FindMap()->ToBattlegroundMap())
                        if (Battleground* bg = bgmap->GetBG())
                            if (bg->GetStatus() < STATUS_IN_PROGRESS && !thisPlayer->HaveAtClient(target->GetOwnerGUID()))
                                return false;
            }

            if (thisPlayer->GetViewpoint())
                viewpoint = thisPlayer->GetViewpoint();

            if (thisPlayer->GetFarSightDistance() && !thisPlayer->isInFront(obj))
            {
                return false;
            }
        }

        // Xinef: check reversely obj vs viewpoint, object could be a gameObject which overrides _IsWithinDist function to include gameobject size
        if (!corpseCheck && !viewpoint->IsWithinDist(obj, GetSightRange(obj), true))
            return false;
    }

    // GM visibility off or hidden NPC
    if (!obj->m_serverSideVisibility.GetValue(SERVERSIDE_VISIBILITY_GM))
    {
        // Stop checking other things for GMs
        if (m_serverSideVisibilityDetect.GetValue(SERVERSIDE_VISIBILITY_GM))
            return true;
    }
    else
        return m_serverSideVisibilityDetect.GetValue(SERVERSIDE_VISIBILITY_GM) >= obj->m_serverSideVisibility.GetValue(SERVERSIDE_VISIBILITY_GM);

    // Ghost players, Spirit Healers, and some other NPCs
    if (!corpseVisibility && !(obj->m_serverSideVisibility.GetValue(SERVERSIDE_VISIBILITY_GHOST) & m_serverSideVisibilityDetect.GetValue(SERVERSIDE_VISIBILITY_GHOST)))
    {
        // Alive players can see dead players in some cases, but other objects can't do that
        if (Player const* thisPlayer = ToPlayer())
        {
            if (Player const* objPlayer = obj->ToPlayer())
            {
                if (thisPlayer->GetTeamId() != objPlayer->GetTeamId() || !thisPlayer->IsGroupVisibleFor(objPlayer))
                    return false;
            }
            else
                return false;
        }
        else
            return false;
    }

    if (obj->IsInvisibleDueToDespawn())
        return false;

    // pussywizard: arena spectator
    if (this->IsPlayer())
        if (((Player const*)this)->IsSpectator() && ((Player const*)this)->FindMap()->IsBattleArena() && (obj->m_invisibility.GetFlags() || obj->m_stealth.GetFlags()))
            return false;

    if (!CanDetect(obj, ignoreStealth, !distanceCheck, checkAlert))
    {
        return false;
    }

    return true;
}

bool WorldObject::CanNeverSee(WorldObject const* obj) const
{
    if (GetTypeId() == TYPEID_UNIT && obj->GetTypeId() == TYPEID_UNIT)
        return GetMap() != obj->GetMap() || (!InSamePhase(obj) && ToUnit()->GetVehicleBase() != obj && this != obj->ToUnit()->GetVehicleBase());
    return GetMap() != obj->GetMap() || !InSamePhase(obj);
}

bool WorldObject::CanDetect(WorldObject const* obj, bool ignoreStealth, bool checkClient, bool checkAlert) const
{
    WorldObject const* seer = this;

    //npcbot: master's sight only partially affects bots
    if (IsNPCBot())
    {
        Unit const* owner = ToCreature()->GetBotOwner();
        if (!owner)
            owner = ToUnit();

        if (!obj->IsAlwaysDetectableFor(seer) && !obj->IsAlwaysDetectableFor(owner) && !ignoreStealth)
        {
            if (!seer->CanDetectInvisibilityOf(obj) && !(owner->IsInWorld() && owner->GetMap()->IsDungeon() && owner->CanDetectInvisibilityOf(obj)))
                return false;

            if (!seer->CanDetectStealthOf(obj, checkAlert))
                return false;
        }

        return true;
    }
    //end npcbot

    // Pets don't have detection, they use the detection of their masters
    if (Unit const* thisUnit = ToUnit())
        if (Unit* controller = thisUnit->GetCharmerOrOwner())
            seer = controller;

    if (obj->IsAlwaysDetectableFor(seer) || GetEntry() == WORLD_TRIGGER) // xinef: World Trigger can detect all objects, used for wild gameobjects without owner!
        return true;

    if (!ignoreStealth)
    {
        if (!seer->CanDetectInvisibilityOf(obj)) // xinef: added ignoreStealth, allow AoE spells to hit invisible targets!
        {
            return false;
        }

        if (!seer->CanDetectStealthOf(obj, checkAlert))
        {
            // xinef: ignore units players have at client, this cant be cheated!
            if (checkClient)
            {
                if (GetTypeId() != TYPEID_PLAYER || !ToPlayer()->HaveAtClient(obj))
                    return false;
            }
            else
                return false;
        }
    }

    return true;
}

bool WorldObject::CanDetectInvisibilityOf(WorldObject const* obj) const
{
    uint32 mask = obj->m_invisibility.GetFlags() & m_invisibilityDetect.GetFlags();
    // xinef: include invisible flags of caster in the mask, 2 invisible objects should be able to detect eachother
    mask |= obj->m_invisibility.GetFlags() & m_invisibility.GetFlags();

    // Check for not detected types
    if (mask != obj->m_invisibility.GetFlags())
        return false;

    // It isn't possible in invisibility to detect something that can't detect the invisible object
    // (it's at least true for spell: 66)
    // It seems like that only Units are affected by this check (couldn't see arena doors with preparation invisibility)
    if (obj->ToUnit())
    {
        // Permanently invisible creatures should be able to engage non-invisible targets.
        // ex. Skulking Witch (20882) / Greater Invisibility (16380)
        bool isPermInvisibleCreature = false;
        if (Creature const* baseObj = ToCreature())
        {
            auto auraEffects = baseObj->GetAuraEffectsByType(SPELL_AURA_MOD_INVISIBILITY);
            for (auto const effect : auraEffects)
            {
                if (SpellInfo const* spell = effect->GetSpellInfo())
                {
                    if (spell->GetMaxDuration() == -1)
                    {
                        isPermInvisibleCreature = true;
                    }
                }
            }
        }

        if (!isPermInvisibleCreature)
        {
            uint32 objMask = m_invisibility.GetFlags() & obj->m_invisibilityDetect.GetFlags();
            // xinef: include invisible flags of caster in the mask, 2 invisible objects should be able to detect eachother
            objMask |= m_invisibility.GetFlags() & obj->m_invisibility.GetFlags();
            if (objMask != m_invisibility.GetFlags())
                return false;
        }
    }

    for (uint32 i = 0; i < TOTAL_INVISIBILITY_TYPES; ++i)
    {
        if (!(mask & (1 << i)))
            continue;

        // xinef: visible for the same invisibility type:
        if (m_invisibility.GetValue(InvisibilityType(i)) && obj->m_invisibility.GetValue(InvisibilityType(i)))
            continue;

        int32 objInvisibilityValue = obj->m_invisibility.GetValue(InvisibilityType(i));
        int32 ownInvisibilityDetectValue = m_invisibilityDetect.GetValue(InvisibilityType(i));

        // Too low value to detect
        if (ownInvisibilityDetectValue < objInvisibilityValue)
            return false;
    }

    return true;
}

bool WorldObject::CanDetectStealthOf(WorldObject const* obj, bool checkAlert) const
{
    // Combat reach is the minimal distance (both in front and behind),
    //   and it is also used in the range calculation.
    // One stealth point increases the visibility range by 0.3 yard.

    if (!obj->m_stealth.GetFlags())
        return true;

    // dead players shouldnt be able to detect stealth on arenas
    if (isType(TYPEMASK_PLAYER))
        if (!ToPlayer()->IsAlive())
            return false;

    float distance = GetExactDist(obj);
    float combatReach = 0.0f;

    if (isType(TYPEMASK_UNIT))
        combatReach = ((Unit*)this)->GetCombatReach();

    if (distance < combatReach)
        return true;

    if (!HasInArc(M_PI, obj))
        return false;

    for (uint32 i = 0; i < TOTAL_STEALTH_TYPES; ++i)
    {
        if (!(obj->m_stealth.GetFlags() & (1 << i)))
            continue;

        if (isType(TYPEMASK_UNIT))
            if (((Unit*)this)->HasAuraTypeWithMiscvalue(SPELL_AURA_DETECT_STEALTH, i))
                return true;

        // Starting points
        int32 detectionValue = 30;

        // Level difference: 5 point / level, starting from level 1.
        // There may be spells for this and the starting points too, but
        // not in the DBCs of the client.
        detectionValue += int32(getLevelForTarget(obj) - 1) * 5;

        // Apply modifiers
        detectionValue += m_stealthDetect.GetValue(StealthType(i));
        if (obj->isType(TYPEMASK_GAMEOBJECT))
        {
            detectionValue += 30; // pussywizard: increase detection range for gameobjects (ie. traps)
            if (Unit* owner = ((GameObject*)obj)->GetOwner())
                detectionValue -= int32(owner->getLevelForTarget(this) - 1) * 5;
        }

        detectionValue -= obj->m_stealth.GetValue(StealthType(i));

        // Calculate max distance
        float visibilityRange = float(detectionValue) * 0.3f + combatReach;

        Unit const* unit = ToUnit();

        // If this unit is an NPC then player detect range doesn't apply
        if (unit && unit->IsPlayer() && visibilityRange > MAX_PLAYER_STEALTH_DETECT_RANGE)
            visibilityRange = MAX_PLAYER_STEALTH_DETECT_RANGE;

        if (checkAlert)
            visibilityRange += (visibilityRange * 0.08f) + 1.5f;

        Unit const* targetUnit = obj->ToUnit();

        // If checking for alert, and creature's visibility range is greater than aggro distance, No alert
        if (checkAlert && unit && unit->ToCreature() && visibilityRange >= unit->ToCreature()->GetAttackDistance(targetUnit) + unit->ToCreature()->m_CombatDistance)
            return false;

        if (distance > visibilityRange)
            return false;
    }

    return true;
}

void WorldObject::SendPlayMusic(uint32 Music, bool OnlySelf)
{
    WorldPacket data(SMSG_PLAY_MUSIC, 4);
    data << Music;
    if (OnlySelf && IsPlayer())
        this->ToPlayer()->GetSession()->SendPacket(&data);
    else
        SendMessageToSet(&data, true); // ToSelf ignored in this case
}

void Object::ForceValuesUpdateAtIndex(uint32 i)
{
    _changesMask.SetBit(i);
    AddToObjectUpdateIfNeeded();
}

void Unit::BuildHeartBeatMsg(WorldPacket* data) const
{
    data->Initialize(MSG_MOVE_HEARTBEAT, 32);
    *data << GetPackGUID();
    BuildMovementPacket(data);
}

void WorldObject::SendMessageToSet(WorldPacket const* data, bool self) const
{
    if (IsInWorld())
        SendMessageToSetInRange(data, GetVisibilityRange(), self);
}

void WorldObject::SendMessageToSetInRange(WorldPacket const* data, float dist, bool /*self*/) const
{
    Acore::MessageDistDeliverer notifier(this, data, dist);
    Cell::VisitWorldObjects(this, notifier, dist);
}

void WorldObject::SendMessageToSet(WorldPacket const* data, Player const* skipped_rcvr) const
{
    Acore::MessageDistDeliverer notifier(this, data, GetVisibilityRange(), false, skipped_rcvr);
    Cell::VisitWorldObjects(this, notifier, GetVisibilityRange());
}

void WorldObject::SendObjectDeSpawnAnim(ObjectGuid guid)
{
    WorldPacket data(SMSG_GAMEOBJECT_DESPAWN_ANIM, 8);
    data << guid;
    SendMessageToSet(&data, true);
}

void WorldObject::SetMap(Map* map)
{
    ASSERT(map);
    ASSERT(!IsInWorld());

    if (m_currMap == map) // command add npc: first create, than loadfromdb
    {
        return;
    }

    if (m_currMap)
    {
        LOG_FATAL("entities.object", "WorldObject::SetMap: obj {} new map {} {}, old map {} {}", (uint32)GetTypeId(), map->GetId(), map->GetInstanceId(), m_currMap->GetId(), m_currMap->GetInstanceId());
        ABORT();
    }

    m_currMap = map;
    m_mapId = map->GetId();
    m_InstanceId = map->GetInstanceId();

    sScriptMgr->OnWorldObjectSetMap(this, map);

    if (IsWorldObject())
        m_currMap->AddWorldObject(this);
}

void WorldObject::ResetMap()
{
    ASSERT(m_currMap);
    ASSERT(!IsInWorld());

    if (IsWorldObject())
    {
        m_currMap->RemoveWorldObject(this);
    }

    sScriptMgr->OnWorldObjectResetMap(this);

    m_currMap = nullptr;
    //maybe not for corpse
    //m_mapId = 0;
    //m_InstanceId = 0;
}

void WorldObject::AddObjectToRemoveList()
{
    ASSERT(m_uint32Values);

    Map* map = FindMap();
    if (!map)
    {
        LOG_ERROR("entities.object", "Object {} at attempt add to move list not have valid map (Id: {}).", GetGUID().ToString(), GetMapId());
        return;
    }

    map->AddObjectToRemoveList(this);
}

TempSummon* Map::SummonCreature(uint32 entry, Position const& pos, SummonPropertiesEntry const* properties /*= nullptr*/, uint32 duration /*= 0*/, WorldObject* summoner /*= nullptr*/, uint32 spellId /*= 0*/, uint32 vehId /*= 0*/, bool visibleBySummonerOnly /*= false*/)
{
    uint32 mask = UNIT_MASK_SUMMON;
    if (properties)
    {
        switch (properties->Category)
        {
            case SUMMON_CATEGORY_PET:
                mask = UNIT_MASK_GUARDIAN;
                break;
            case SUMMON_CATEGORY_PUPPET:
                mask = UNIT_MASK_PUPPET;
                break;
            case SUMMON_CATEGORY_VEHICLE:
                mask = UNIT_MASK_MINION;
                break;
            case SUMMON_CATEGORY_WILD:
            case SUMMON_CATEGORY_ALLY:
            case SUMMON_CATEGORY_UNK:
                {
                    switch (properties->Type)
                    {
                        case SUMMON_TYPE_MINION:
                        case SUMMON_TYPE_GUARDIAN:
                        case SUMMON_TYPE_GUARDIAN2:
                            mask = UNIT_MASK_GUARDIAN;
                            break;
                        case SUMMON_TYPE_TOTEM:
                        case SUMMON_TYPE_LIGHTWELL:
                            mask = UNIT_MASK_TOTEM;
                            break;
                        case SUMMON_TYPE_VEHICLE:
                        case SUMMON_TYPE_VEHICLE2:
                            mask = UNIT_MASK_SUMMON;
                            break;
                        case SUMMON_TYPE_MINIPET:
                        case SUMMON_TYPE_JEEVES:
                            mask = UNIT_MASK_MINION;
                            break;
                        default:
                            if (properties->Flags & 512) // Mirror Image, Summon Gargoyle
                                mask = UNIT_MASK_GUARDIAN;
                            break;
                    }
                    break;
                }
            default:
                return nullptr;
        }
    }

    uint32 phase = PHASEMASK_NORMAL;
    if (summoner)
        phase = summoner->GetPhaseMask();

    TempSummon* summon = nullptr;
    switch (mask)
    {
        case UNIT_MASK_SUMMON:
            summon = new TempSummon(properties, summoner ? summoner->GetGUID() : ObjectGuid::Empty, false);
            break;
        case UNIT_MASK_GUARDIAN:
            summon = new Guardian(properties, summoner ? summoner->GetGUID() : ObjectGuid::Empty, false);
            break;
        case UNIT_MASK_PUPPET:
            summon = new Puppet(properties, summoner ? summoner->GetGUID() : ObjectGuid::Empty);
            break;
        case UNIT_MASK_TOTEM:
            //npcbot: totem emul step 1
            if (summoner && summoner->IsNPCBot())
                summon = new Totem(properties, summoner->ToCreature()->GetBotOwner()->GetGUID());
            else
            //end npcbot
            summon = new Totem(properties, summoner ? summoner->GetGUID() : ObjectGuid::Empty);
            break;
        case UNIT_MASK_MINION:
            summon = new Minion(properties, summoner ? summoner->GetGUID() : ObjectGuid::Empty, false);
            break;
        default:
            return nullptr;
    }

    EnsureGridLoaded(Cell(pos.GetPositionX(), pos.GetPositionY()));
    if (!summon->Create(GenerateLowGuid<HighGuid::Unit>(), this, phase, entry, vehId, pos.GetPositionX(), pos.GetPositionY(), pos.GetPositionZ(), pos.GetOrientation()))
    {
        delete summon;
        return nullptr;
    }

    //npcbot: totem emul step 2
    if (summoner && summoner->IsNPCBot())
    {
        summon->SetCreatorGUID(summoner->GetGUID()); // see TempSummon::InitStats()
        if (mask == UNIT_MASK_TOTEM)
        {
            summon->SetFaction(summoner->ToCreature()->GetFaction());
            summon->SetPvP(summoner->ToCreature()->IsPvP());
            //set key flags if needed
            if (!summoner->ToCreature()->IsFreeBot())
            {
                summon->SetUnitFlag(UNIT_FLAG_PLAYER_CONTROLLED);
                summon->SetOwnerGUID(summoner->ToCreature()->GetBotOwner()->GetGUID());
                summon->SetControlledByPlayer(true);
            }
        }
    }
    //end npcbot

    summon->SetUInt32Value(UNIT_CREATED_BY_SPELL, spellId);

    summon->SetHomePosition(pos);

    summon->InitStats(duration);

    summon->SetVisibleBySummonerOnly(visibleBySummonerOnly);

    if (!AddToMap(summon->ToCreature(), summon->GetOwnerGUID().IsPlayer() || (summoner && summoner->GetTransport())))
    {
        delete summon;
        return nullptr;
    }

    summon->InitSummon();

    //npcbot: totem emul step 3
    if (summoner && summoner->IsNPCBot())
        summoner->ToCreature()->OnBotSummon(summon);
    //end npcbot

    //ObjectAccessor::UpdateObjectVisibility(summon);

    return summon;
}

/**
* Summons group of creatures.
*
* @param group Id of group to summon.
* @param list  List to store pointers to summoned creatures.
*/

void Map::SummonCreatureGroup(uint8 group, std::list<TempSummon*>* list /*= nullptr*/)
{
    std::vector<TempSummonData> const* data = sObjectMgr->GetSummonGroup(GetId(), SUMMONER_TYPE_MAP, group);
    if (!data)
        return;

    for (std::vector<TempSummonData>::const_iterator itr = data->begin(); itr != data->end(); ++itr)
        if (TempSummon* summon = SummonCreature(itr->entry, itr->pos, nullptr, itr->time))
            if (list)
                list->push_back(summon);
}

TempSummon* WorldObject::SummonCreature(uint32 id, float x, float y, float z, float ang, TempSummonType spwtype, uint32 despwtime, SummonPropertiesEntry const* properties, bool visibleBySummonerOnly)
{
    if (!x && !y && !z)
    {
        GetClosePoint(x, y, z, GetObjectSize());
        ang = GetOrientation();
    }
    Position pos;
    pos.Relocate(x, y, z, ang);
    return SummonCreature(id, pos, spwtype, despwtime, 0, properties, visibleBySummonerOnly);
}

GameObject* Map::SummonGameObject(uint32 entry, float x, float y, float z, float ang, float rotation0, float rotation1, float rotation2, float rotation3, uint32 respawnTime, bool checkTransport)
{
    GameObjectTemplate const* goinfo = sObjectMgr->GetGameObjectTemplate(entry);
    if (!goinfo)
    {
        LOG_ERROR("sql.sql", "Gameobject template {} not found in database!", entry);
        return nullptr;
    }

    GameObject* go = sObjectMgr->IsGameObjectStaticTransport(entry) ? new StaticTransport() : new GameObject();
    if (!go->Create(GenerateLowGuid<HighGuid::GameObject>(), entry, this, PHASEMASK_NORMAL, x, y, z, ang, G3D::Quat(rotation0, rotation1, rotation2, rotation3), 100, GO_STATE_READY))
    {
        delete go;
        return nullptr;
    }

    // Xinef: if gameobject is temporary, set custom spellid
    if (respawnTime)
        go->SetSpellId(1);

    go->SetRespawnTime(respawnTime);
    go->SetSpawnedByDefault(false);
    AddToMap(go, checkTransport);
    return go;
}

GameObject* Map::SummonGameObject(uint32 entry, Position const& pos, float rotation0, float rotation1, float rotation2, float rotation3, uint32 respawnTime, bool checkTransport)
{
    return SummonGameObject(entry, pos.GetPositionX(), pos.GetPositionY(), pos.GetPositionZ(), pos.GetOrientation(), rotation0, rotation1, rotation2, rotation3, respawnTime, checkTransport);
}

void WorldObject::SetZoneScript()
{
    if (Map* map = FindMap())
    {
        if (InstanceMap* instanceMap = map->ToInstanceMap())
            m_zoneScript = reinterpret_cast<ZoneScript*>(instanceMap->GetInstanceScript());
        else if (!map->IsBattlegroundOrArena())
        {
            uint32 zoneId = GetZoneId();
            if (Battlefield* bf = sBattlefieldMgr->GetBattlefieldToZoneId(zoneId))
                m_zoneScript = bf;
            else
                m_zoneScript = sOutdoorPvPMgr->GetZoneScript(zoneId);
        }
    }
}

void WorldObject::ClearZoneScript()
{
    m_zoneScript = nullptr;
}

TempSummon* WorldObject::SummonCreature(uint32 entry, const Position& pos, TempSummonType spwtype, uint32 duration, uint32  /*vehId*/, SummonPropertiesEntry const* properties, bool visibleBySummonerOnly /*= false*/) const
{
    if (Map* map = FindMap())
    {
        if (TempSummon* summon = map->SummonCreature(entry, pos, properties, duration, (WorldObject*)this, 0, 0, visibleBySummonerOnly))
        {
            summon->SetTempSummonType(spwtype);
            return summon;
        }
    }

    return nullptr;
}

GameObject* WorldObject::SummonGameObject(uint32 entry, float x, float y, float z, float ang, float rotation0, float rotation1, float rotation2, float rotation3, uint32 respawnTime, bool checkTransport, GOSummonType summonType)
{
    if (!IsInWorld())
        return nullptr;

    GameObjectTemplate const* goinfo = sObjectMgr->GetGameObjectTemplate(entry);
    if (!goinfo)
    {
        LOG_ERROR("sql.sql", "Gameobject template {} not found in database!", entry);
        return nullptr;
    }

    Map* map = GetMap();
    GameObject* go = sObjectMgr->IsGameObjectStaticTransport(entry) ? new StaticTransport() : new GameObject();
    if (!go->Create(map->GenerateLowGuid<HighGuid::GameObject>(), entry, map, GetPhaseMask(), x, y, z, ang, G3D::Quat(rotation0, rotation1, rotation2, rotation3), 100, GO_STATE_READY))
    {
        delete go;
        return nullptr;
    }

    go->SetRespawnTime(respawnTime);

    // Xinef: if gameobject is temporary, set custom spellid
    if (respawnTime)
        go->SetSpellId(1);

    if (IsPlayer() || (GetTypeId() == TYPEID_UNIT && summonType == GO_SUMMON_TIMED_OR_CORPSE_DESPAWN)) //not sure how to handle this
        ToUnit()->AddGameObject(go);
    else
        go->SetSpawnedByDefault(false);

    map->AddToMap(go, checkTransport);
    return go;
}

Creature* WorldObject::SummonTrigger(float x, float y, float z, float ang, uint32 duration, bool setLevel, CreatureAI * (*GetAI)(Creature*))
{
    TempSummonType summonType = (duration == 0) ? TEMPSUMMON_DEAD_DESPAWN : TEMPSUMMON_TIMED_DESPAWN;
    Creature* summon = SummonCreature(WORLD_TRIGGER, x, y, z, ang, summonType, duration);
    if (!summon)
        return nullptr;

    //summon->SetName(GetName());
    if (setLevel && (IsPlayer() || GetTypeId() == TYPEID_UNIT))
    {
        summon->SetFaction(((Unit*)this)->GetFaction());
        summon->SetLevel(((Unit*)this)->GetLevel());
    }

    // Xinef: correctly set phase mask in case of gameobjects
    summon->SetPhaseMask(GetPhaseMask(), false);

    if (GetAI)
        summon->AIM_Initialize(GetAI(summon));
    return summon;
}

/**
* Summons group of creatures. Should be called only by instances of Creature and GameObject classes.
*
* @param group Id of group to summon.
* @param list  List to store pointers to summoned creatures.
*/
void WorldObject::SummonCreatureGroup(uint8 group, std::list<TempSummon*>* list /*= nullptr*/)
{
    ASSERT((GetTypeId() == TYPEID_GAMEOBJECT || GetTypeId() == TYPEID_UNIT) && "Only GOs and creatures can summon npc groups!");

    std::vector<TempSummonData> const* data = sObjectMgr->GetSummonGroup(GetEntry(), GetTypeId() == TYPEID_GAMEOBJECT ? SUMMONER_TYPE_GAMEOBJECT : SUMMONER_TYPE_CREATURE, group);
    if (!data)
        return;

    for (std::vector<TempSummonData>::const_iterator itr = data->begin(); itr != data->end(); ++itr)
        if (TempSummon* summon = SummonCreature(itr->entry, itr->pos, itr->type, itr->time))
            if (list)
                list->push_back(summon);
}

Creature* WorldObject::FindNearestCreature(uint32 entry, float range, bool alive) const
{
    Creature* creature = nullptr;
    Acore::NearestCreatureEntryWithLiveStateInObjectRangeCheck checker(*this, entry, alive, range);
    Acore::CreatureLastSearcher<Acore::NearestCreatureEntryWithLiveStateInObjectRangeCheck> searcher(this, creature, checker);
    Cell::VisitAllObjects(this, searcher, range);
    return creature;
}

GameObject* WorldObject::FindNearestGameObject(uint32 entry, float range, bool onlySpawned /*= false*/) const
{
    GameObject* go = nullptr;
    Acore::NearestGameObjectEntryInObjectRangeCheck checker(*this, entry, range, onlySpawned);
    Acore::GameObjectLastSearcher<Acore::NearestGameObjectEntryInObjectRangeCheck> searcher(this, go, checker);
    Cell::VisitGridObjects(this, searcher, range);
    return go;
}

GameObject* WorldObject::FindNearestGameObjectOfType(GameobjectTypes type, float range) const
{
    GameObject* go = nullptr;
    Acore::NearestGameObjectTypeInObjectRangeCheck checker(*this, type, range);
    Acore::GameObjectLastSearcher<Acore::NearestGameObjectTypeInObjectRangeCheck> searcher(this, go, checker);
    Cell::VisitGridObjects(this, searcher, range);
    return go;
}

Player* WorldObject::SelectNearestPlayer(float distance) const
{
    Player* target = nullptr;

    Acore::NearestPlayerInObjectRangeCheck checker(this, distance);
    Acore::PlayerLastSearcher<Acore::NearestPlayerInObjectRangeCheck> searcher(this, target, checker);
    Cell::VisitWorldObjects(this, searcher, distance);

    return target;
}

std::string WorldObject::GetDebugInfo() const
{
    std::stringstream sstr;
    sstr << WorldLocation::GetDebugInfo() << "\n"
        << Object::GetDebugInfo() << "\n"
        << "Name: " << GetName();
    return sstr.str();
}

void WorldObject::GetGameObjectListWithEntryInGrid(std::list<GameObject*>& gameobjectList, uint32 entry, float maxSearchRange) const
{
    Acore::AllGameObjectsWithEntryInRange check(this, entry, maxSearchRange);
    Acore::GameObjectListSearcher<Acore::AllGameObjectsWithEntryInRange> searcher(this, gameobjectList, check);
    Cell::VisitGridObjects(this, searcher, maxSearchRange);
}

void WorldObject::GetCreatureListWithEntryInGrid(std::list<Creature*>& creatureList, uint32 entry, float maxSearchRange) const
{
    Acore::AllCreaturesOfEntryInRange check(this, entry, maxSearchRange);
    Acore::CreatureListSearcher<Acore::AllCreaturesOfEntryInRange> searcher(this, creatureList, check);
    Cell::VisitGridObjects(this, searcher, maxSearchRange);
}

void WorldObject::GetDeadCreatureListInGrid(std::list<Creature*>& creaturedeadList, float maxSearchRange, bool alive /*= false*/) const
{
    Acore::AllDeadCreaturesInRange check(this, maxSearchRange, alive);
    Acore::CreatureListSearcher<Acore::AllDeadCreaturesInRange> searcher(this, creaturedeadList, check);
    Cell::VisitGridObjects(this, searcher, maxSearchRange);
}

/*
namespace Acore
{
    class NearUsedPosDo
    {
        public:
            NearUsedPosDo(WorldObject const& obj, WorldObject const* searcher, float angle, ObjectPosSelector& selector)
                : i_object(obj), i_searcher(searcher), i_angle(angle), i_selector(selector) {}

            void operator()(Corpse*) const {}
            void operator()(DynamicObject*) const {}

            void operator()(Creature* c) const
            {
                // skip self or target
                if (c == i_searcher || c == &i_object)
                    return;

                float x, y, z;

                if (!c->IsAlive() || c->HasUnitState(UNIT_STATE_ROOT | UNIT_STATE_STUNNED | UNIT_STATE_DISTRACTED) ||
                    !c->GetMotionMaster()->GetDestination(x, y, z))
                {
                    x = c->GetPositionX();
                    y = c->GetPositionY();
                }

                add(c, x, y);
            }

            template<class T>
                void operator()(T* u) const
            {
                // skip self or target
                if (u == i_searcher || u == &i_object)
                    return;

                float x, y;

                x = u->GetPositionX();
                y = u->GetPositionY();

                add(u, x, y);
            }

            // we must add used pos that can fill places around center
            void add(WorldObject* u, float x, float y) const
            {
                // u is too nearest/far away to i_object
                if (!i_object.IsInRange2d(x, y, i_selector.m_dist - i_selector.m_size, i_selector.m_dist + i_selector.m_size))
                    return;

                float angle = i_object.GetAngle(u)-i_angle;

                // move angle to range -pi ... +pi
                while (angle > M_PI)
                    angle -= 2.0f * M_PI;
                while (angle < -M_PI)
                    angle += 2.0f * M_PI;

                // dist include size of u
                float dist2d = i_object.GetDistance2d(x, y);
                i_selector.AddUsedPos(u->GetObjectSize(), angle, dist2d + i_object.GetObjectSize());
            }
        private:
            WorldObject const& i_object;
            WorldObject const* i_searcher;
            float              i_angle;
            ObjectPosSelector& i_selector;
    };
}                                                           // namespace Acore
*/

//===================================================================================================

void WorldObject::GetNearPoint2D(WorldObject const* searcher, float& x, float& y, float distance2d, float absAngle, Position const* startPos) const
{
    float effectiveReach = GetCombatReach();

    if (searcher)
    {
        effectiveReach += searcher->GetCombatReach();

        if (this != searcher)
        {
            float myHover = 0.0f, searcherHover = 0.0f;
            if (Unit const* unit = ToUnit())
                myHover = unit->GetHoverHeight();
            if (Unit const* searchUnit = searcher->ToUnit())
                searcherHover = searchUnit->GetHoverHeight();

            float hoverDelta = myHover - searcherHover;
            if (hoverDelta != 0.0f)
                effectiveReach = std::sqrt(std::max(effectiveReach * effectiveReach - hoverDelta * hoverDelta, 0.0f));
        }
    }

    float positionX = startPos ? startPos->GetPositionX() : GetPositionX();
    float positionY = startPos ? startPos->GetPositionY() : GetPositionY();

    x = positionX + (effectiveReach + distance2d) * std::cos(absAngle);
    y = positionY + (effectiveReach + distance2d) * std::sin(absAngle);

    Acore::NormalizeMapCoord(x);
    Acore::NormalizeMapCoord(y);
}

void WorldObject::GetNearPoint2D(float& x, float& y, float distance2d, float absAngle, Position const* startPos) const
{
    GetNearPoint2D(nullptr, x, y, distance2d, absAngle, startPos);
}

void WorldObject::GetNearPoint(WorldObject const* searcher, float& x, float& y, float& z, float searcher_size, float distance2d, float absAngle, float controlZ, Position const* startPos) const
{
    GetNearPoint2D(x, y, distance2d + searcher_size, absAngle, startPos);
    z = GetPositionZ();

    if (searcher)
    {
        if (Unit const* unit = searcher->ToUnit(); Unit const* target = ToUnit())
        {
            if (unit && target && unit->IsInWater() && target->IsInWater())
            {
                // if the searcher is in water
                // we have no ground so we can
                // set the target height to the
                // z-coord to keep the searcher
                // at the correct height (face to face)
                z += GetCollisionHeight() - unit->GetCollisionHeight();
            }
        }
        searcher->UpdateAllowedPositionZ(x, y, z);
    }
    else
    {
        UpdateAllowedPositionZ(x, y, z);
    }

    // if detection disabled, return first point
    if (!sWorld->getBoolConfig(CONFIG_DETECT_POS_COLLISION))
        return;

    // return if the point is already in LoS
    if (!controlZ && IsWithinLOS(x, y, z))
        return;

    // remember first point
    float first_x = x;
    float first_y = y;
    float first_z = z;

    // loop in a circle to look for a point in LoS using small steps
    for (float angle = float(M_PI) / 8; angle < float(M_PI) * 2; angle += float(M_PI) / 8)
    {
        GetNearPoint2D(x, y, distance2d + searcher_size, absAngle + angle, startPos);
        z = GetPositionZ();
        UpdateAllowedPositionZ(x, y, z);
        if (controlZ && fabsf(GetPositionZ() - z) > controlZ)
            continue;

        if (IsWithinLOS(x, y, z))
            return;
    }

    // still not in LoS, give up and return first position found
    if (startPos)
    {
        x = searcher->GetPositionX();
        y = searcher->GetPositionY();
        z = searcher->GetPositionZ();
    }
    else
    {
        x = first_x;
        y = first_y;
        z = first_z;
    }
}

void WorldObject::GetVoidClosePoint(float& x, float& y, float& z, float size, float distance2d /*= 0*/, float relAngle /*= 0*/, float controlZ /*= 0*/) const
{
    // angle calculated from current orientation
    GetNearPoint(nullptr, x, y, z, size, distance2d, GetOrientation() + relAngle, controlZ);
}

bool WorldObject::GetClosePoint(float& x, float& y, float& z, float size, float distance2d, float angle, WorldObject const* forWho, bool force) const
{
    // angle calculated from current orientation
    GetNearPoint(forWho, x, y, z, size, distance2d, GetOrientation() + angle);

    if (std::fabs(this->GetPositionZ() - z) > 3.0f || !IsWithinLOS(x, y, z))
    {
        x = this->GetPositionX();
        y = this->GetPositionY();
        z = this->GetPositionZ();
        if (forWho)
            if (Unit const* u = forWho->ToUnit())
                u->UpdateAllowedPositionZ(x, y, z);
    }
    float maxDist = GetObjectSize() + size + distance2d + 1.0f;
    if (GetExactDistSq(x, y, z) >= maxDist * maxDist)
    {
        if (force)
        {
            x = this->GetPositionX();
            y = this->GetPositionY();
            z = this->GetPositionZ();
            return true;
        }
        return false;
    }
    return true;
}

Position WorldObject::GetNearPosition(float dist, float angle)
{
    Position pos = GetPosition();
    MovePosition(pos, dist, angle);
    return pos;
}

Position WorldObject::GetRandomNearPosition(float radius)
{
    Position pos = GetPosition();
    MovePosition(pos, radius * (float) rand_norm(), (float) rand_norm() * static_cast<float>(2 * M_PI));
    return pos;
}

void WorldObject::GetContactPoint(WorldObject const* obj, float& x, float& y, float& z, float distance2d) const
{
    // angle to face `obj` to `this` using distance includes size of `obj`
    GetNearPoint(obj, x, y, z, obj->GetObjectSize(), distance2d, GetAngle(obj));

    // Exclude gameobjects from LoS calculations
    if (std::fabs(this->GetPositionZ() - z) > 3.0f || (GetTypeId() != TYPEID_GAMEOBJECT && !IsWithinLOS(x, y, z)))
    {
        x = this->GetPositionX();
        y = this->GetPositionY();
        z = this->GetPositionZ();
        obj->UpdateAllowedPositionZ(x, y, z);
    }
}

void WorldObject::GetChargeContactPoint(WorldObject const* obj, float& x, float& y, float& z, float distance2d) const
{
    // angle to face `obj` to `this` using distance includes size of `obj`
    GetNearPoint(obj, x, y, z, obj->GetObjectSize(), distance2d, GetAngle(obj));

    if (std::fabs(this->GetPositionZ() - z) > 3.0f || !IsWithinLOS(x, y, z))
    {
        x = this->GetPositionX();
        y = this->GetPositionY();
        z = this->GetPositionZ();
        obj->UpdateGroundPositionZ(x, y, z);
    }
}

[[nodiscard]] float WorldObject::GetObjectSize() const
{
    return (m_valuesCount > UNIT_FIELD_COMBATREACH) ? m_floatValues[UNIT_FIELD_COMBATREACH] : DEFAULT_WORLD_OBJECT_SIZE * GetObjectScale();
}

void WorldObject::MovePosition(Position& pos, float dist, float angle)
{
    angle += GetOrientation();
    float destx, desty, destz, ground, floor;
    destx = pos.m_positionX + dist * cos(angle);
    desty = pos.m_positionY + dist * std::sin(angle);

    // Prevent invalid coordinates here, position is unchanged
    if (!Acore::IsValidMapCoord(destx, desty))
    {
        LOG_FATAL("entities.object", "WorldObject::MovePosition invalid coordinates X: {} and Y: {} were passed!", destx, desty);
        return;
    }

    ground = GetMapHeight(destx, desty, MAX_HEIGHT);
    floor = GetMapHeight(destx, desty, pos.m_positionZ);
    destz = std::fabs(ground - pos.m_positionZ) <= std::fabs(floor - pos.m_positionZ) ? ground : floor;

    float step = dist / 10.0f;

    for (uint8 j = 0; j < 10; ++j)
    {
        // do not allow too big z changes
        if (std::fabs(pos.m_positionZ - destz) > 6.0f)
        {
            destx -= step * cos(angle);
            desty -= step * std::sin(angle);
            ground = GetMapHeight(destx, desty, MAX_HEIGHT);
            floor = GetMapHeight(destx, desty, pos.m_positionZ);
            destz = std::fabs(ground - pos.m_positionZ) <= std::fabs(floor - pos.m_positionZ) ? ground : floor;
        }
        // we have correct destz now
        else
        {
            pos.Relocate(destx, desty, destz);
            break;
        }
    }

    Acore::NormalizeMapCoord(pos.m_positionX);
    Acore::NormalizeMapCoord(pos.m_positionY);
    UpdateGroundPositionZ(pos.m_positionX, pos.m_positionY, pos.m_positionZ);
    pos.SetOrientation(GetOrientation());
}

Position WorldObject::GetFirstCollisionPosition(float startX, float startY, float startZ, float destX, float destY)
{
    auto dx = destX - startX;
    auto dy = destY - startY;

    auto ang = std::atan2(dy, dx);
    ang = (ang >= 0) ? ang : 2 * M_PI + ang;
    Position pos = Position(startX, startY, startZ, ang);

    auto distance = pos.GetExactDist2d(destX,destY);

    MovePositionToFirstCollision(pos, distance, ang);
    return pos;
}

Position WorldObject::GetFirstCollisionPosition(float destX, float destY, float destZ)
{
    Position pos = GetPosition();
    auto distance = GetExactDistSq(destX,destY,destZ);

    auto dx = destX - pos.GetPositionX();
    auto dy = destY - pos.GetPositionY();

    auto ang = std::atan2(dy, dx);
    ang = (ang >= 0) ? ang : 2 * M_PI + ang;

    MovePositionToFirstCollision(pos, distance, ang);
    return pos;
}

Position WorldObject::GetFirstCollisionPosition(float dist, float angle) const
{
    Position pos = GetPosition();
    MovePositionToFirstCollision(pos, dist, angle);
    return pos;
}

void WorldObject::MovePositionToFirstCollision(Position& pos, float dist, float angle) const
{
    angle += GetOrientation();
    float destx, desty, destz;
    destx = pos.m_positionX + dist * cos(angle);
    desty = pos.m_positionY + dist * std::sin(angle);
    destz = pos.m_positionZ;

    if (!GetMap()->CheckCollisionAndGetValidCoords(this, pos.m_positionX, pos.m_positionY, pos.m_positionZ, destx, desty, destz, false))
        return;

    pos.SetOrientation(GetOrientation());
    pos.Relocate(destx, desty, destz);
}

void WorldObject::SetPhaseMask(uint32 newPhaseMask, bool update)
{
    sScriptMgr->OnBeforeWorldObjectSetPhaseMask(this, m_phaseMask, newPhaseMask, m_useCombinedPhases, update);
    m_phaseMask = newPhaseMask;

    if (update && IsInWorld())
        UpdateObjectVisibility();
}

void WorldObject::PlayDistanceSound(uint32 sound_id, Player* target /*= nullptr*/)
{
    if (target)
        target->SendDirectMessage(WorldPackets::Misc::PlayObjectSound(GetGUID(), sound_id).Write());
    else
        SendMessageToSet(WorldPackets::Misc::PlayObjectSound(GetGUID(), sound_id).Write(), true);
}

void WorldObject::PlayDirectSound(uint32 sound_id, Player* target /*= nullptr*/)
{
    if (target)
        target->SendDirectMessage(WorldPackets::Misc::Playsound(sound_id).Write());
    else
        SendMessageToSet(WorldPackets::Misc::Playsound(sound_id).Write(), true);
}

void WorldObject::PlayRadiusSound(uint32 sound_id, float radius)
{
    std::list<Player*> targets;
    Acore::AnyPlayerInObjectRangeCheck check(this, radius, false);
    Acore::PlayerListSearcher<Acore::AnyPlayerInObjectRangeCheck> searcher(this, targets, check);
    Cell::VisitWorldObjects(this, searcher, radius);

    for (Player* player : targets)
    {
        if (player)
        {
            player->SendDirectMessage(WorldPackets::Misc::Playsound(sound_id).Write());
        }
    }
}

void WorldObject::PlayDirectMusic(uint32 music_id, Player* target /*= nullptr*/)
{
    if (target)
    {
        target->SendDirectMessage(WorldPackets::Misc::PlayMusic(music_id).Write());
    }
    else
    {
        SendMessageToSet(WorldPackets::Misc::PlayMusic(music_id).Write(), true);
    }
}

void WorldObject::PlayRadiusMusic(uint32 music_id, float radius)
{
    std::list<Player*> targets;
    Acore::AnyPlayerInObjectRangeCheck check(this, radius, false);
    Acore::PlayerListSearcher<Acore::AnyPlayerInObjectRangeCheck> searcher(this, targets, check);
    Cell::VisitWorldObjects(this, searcher, radius);

    for (Player* player : targets)
    {
        if (player)
        {
            player->SendDirectMessage(WorldPackets::Misc::PlayMusic(music_id).Write());
        }
    }
}

void WorldObject::DestroyForNearbyPlayers()
{
    if (!IsInWorld())
        return;

    std::list<Player*> targets;
    Acore::AnyPlayerInObjectRangeCheck check(this, GetVisibilityRange() + VISIBILITY_COMPENSATION, false);
    Acore::PlayerListSearcherWithSharedVision<Acore::AnyPlayerInObjectRangeCheck> searcher(this, targets, check);
    Cell::VisitWorldObjects(this, searcher, GetVisibilityRange());
    for (std::list<Player*>::const_iterator iter = targets.begin(); iter != targets.end(); ++iter)
    {
        Player* player = (*iter);

        if (player == this)
            continue;

        if (!player->HaveAtClient(this))
            continue;

        if (isType(TYPEMASK_UNIT) && ((Unit*)this)->GetCharmerGUID() == player->GetGUID()) /// @todo: this is for puppet
            continue;

        DestroyForPlayer(player);
        player->m_clientGUIDs.erase(GetGUID());
    }
}

void WorldObject::UpdateObjectVisibility(bool /*forced*/, bool /*fromUpdate*/)
{
    //updates object's visibility for nearby players
    Acore::VisibleChangesNotifier notifier(*this);
    Cell::VisitWorldObjects(this, notifier, GetVisibilityRange());
}

void WorldObject::AddToNotify(uint16 f)
{
    if (!(m_notifyflags & f))
        if (Unit* u = ToUnit())
        {
            if (f & NOTIFY_VISIBILITY_CHANGED)
            {
                uint32 EVENT_VISIBILITY_DELAY = u->FindMap() ? DynamicVisibilityMgr::GetVisibilityNotifyDelay(u->FindMap()->GetEntry()->map_type) : 1000;

                uint32 diff = getMSTimeDiff(u->m_last_notify_mstime, GameTime::GetGameTimeMS().count());
                if (diff >= EVENT_VISIBILITY_DELAY / 2)
                    EVENT_VISIBILITY_DELAY /= 2;
                else
                    EVENT_VISIBILITY_DELAY -= diff;
                u->m_delayed_unit_relocation_timer = EVENT_VISIBILITY_DELAY;
                u->m_last_notify_mstime = GameTime::GetGameTimeMS().count() + EVENT_VISIBILITY_DELAY - 1;
            }
            else if (f & NOTIFY_AI_RELOCATION)
            {
                u->m_delayed_unit_ai_notify_timer = u->FindMap() ? DynamicVisibilityMgr::GetAINotifyDelay(u->FindMap()->GetEntry()->map_type) : 500;
            }

            m_notifyflags |= f;
        }
}

struct WorldObjectChangeAccumulator
{
    UpdateDataMapType& i_updateDatas;
    UpdatePlayerSet& i_playerSet;
    WorldObject& i_object;
    WorldObjectChangeAccumulator(WorldObject& obj, UpdateDataMapType& d, UpdatePlayerSet& p) : i_updateDatas(d), i_playerSet(p), i_object(obj)
    {
        i_playerSet.clear();
    }
    void Visit(PlayerMapType& m)
    {
        Player* source = nullptr;
        for (PlayerMapType::iterator iter = m.begin(); iter != m.end(); ++iter)
        {
            source = iter->GetSource();

            BuildPacket(source);

            if (source->HasSharedVision())
            {
                SharedVisionList::const_iterator it = source->GetSharedVisionList().begin();
                for (; it != source->GetSharedVisionList().end(); ++it)
                    BuildPacket(*it);
            }
        }
    }

    void Visit(CreatureMapType& m)
    {
        Creature* source = nullptr;
        for (CreatureMapType::iterator iter = m.begin(); iter != m.end(); ++iter)
        {
            source = iter->GetSource();
            if (source->HasSharedVision())
            {
                SharedVisionList::const_iterator it = source->GetSharedVisionList().begin();
                for (; it != source->GetSharedVisionList().end(); ++it)
                    BuildPacket(*it);
            }
        }
    }

    void Visit(DynamicObjectMapType& m)
    {
        DynamicObject* source = nullptr;
        for (DynamicObjectMapType::iterator iter = m.begin(); iter != m.end(); ++iter)
        {
            source = iter->GetSource();
            ObjectGuid guid = source->GetCasterGUID();

            if (guid)
            {
                //Caster may be nullptr if DynObj is in removelist
                if (Player* caster = ObjectAccessor::FindPlayer(guid))
                    if (caster->GetGuidValue(PLAYER_FARSIGHT) == source->GetGUID())
                        BuildPacket(caster);
            }
        }
    }

    void BuildPacket(Player* player)
    {
        // Only send update once to a player
        if (i_playerSet.find(player->GetGUID()) == i_playerSet.end() && player->HaveAtClient(&i_object))
        {
            i_object.BuildFieldsUpdate(player, i_updateDatas);
            i_playerSet.insert(player->GetGUID());
        }
    }

    template<class SKIP> void Visit(GridRefMgr<SKIP>&) {}
};

void WorldObject::BuildUpdate(UpdateDataMapType& data_map, UpdatePlayerSet& player_set)
{
    WorldObjectChangeAccumulator notifier(*this, data_map, player_set);
    //we must build packets for all visible players
    Cell::VisitWorldObjects(this, notifier, GetVisibilityRange());

    ClearUpdateMask(false);
}

void WorldObject::GetCreaturesWithEntryInRange(std::list<Creature*>& creatureList, float radius, uint32 entry)
{
    CellCoord pair(Acore::ComputeCellCoord(this->GetPositionX(), this->GetPositionY()));
    Cell cell(pair);
    cell.SetNoCreate();

    Acore::AllCreaturesOfEntryInRange check(this, entry, radius);
    Acore::CreatureListSearcher<Acore::AllCreaturesOfEntryInRange> searcher(this, creatureList, check);

    TypeContainerVisitor<Acore::CreatureListSearcher<Acore::AllCreaturesOfEntryInRange>, WorldTypeMapContainer> world_visitor(searcher);
    cell.Visit(pair, world_visitor, *(this->GetMap()), *this, radius);

    TypeContainerVisitor<Acore::CreatureListSearcher<Acore::AllCreaturesOfEntryInRange>, GridTypeMapContainer> grid_visitor(searcher);
    cell.Visit(pair, grid_visitor, *(this->GetMap()), *this, radius);
}

void WorldObject::AddToObjectUpdate()
{
    GetMap()->AddUpdateObject(this);
}

void WorldObject::RemoveFromObjectUpdate()
{
    GetMap()->RemoveUpdateObject(this);
}

ObjectGuid WorldObject::GetTransGUID() const
{
    if (GetTransport())
        return GetTransport()->GetGUID();

    return ObjectGuid::Empty;
}

float WorldObject::GetMapHeight(float x, float y, float z, bool vmap/* = true*/, float distanceToSearch/* = DEFAULT_HEIGHT_SEARCH*/) const
{
    if (z != MAX_HEIGHT)
        z += std::max(GetCollisionHeight(), Z_OFFSET_FIND_HEIGHT);

    return GetMap()->GetHeight(GetPhaseMask(), x, y, z, vmap, distanceToSearch);
}

float WorldObject::GetMapWaterOrGroundLevel(float x, float y, float z, float* ground/* = nullptr*/) const
{
    return GetMap()->GetWaterOrGroundLevel(GetPhaseMask(), x, y, z, ground,
        isType(TYPEMASK_UNIT) ? !static_cast<Unit const*>(this)->HasAuraType(SPELL_AURA_WATER_WALK) : false,
        std::max(GetCollisionHeight(),  Z_OFFSET_FIND_HEIGHT));
}

float WorldObject::GetFloorZ() const
{
    if (_updatePositionData)
        const_cast<WorldObject*>(this)->UpdatePositionData();

    if (!IsInWorld())
        return _floorZ;

    return std::max<float>(_floorZ, GetMap()->GetGameObjectFloor(GetPhaseMask(), GetPositionX(), GetPositionY(), GetPositionZ() + std::max(GetCollisionHeight(), Z_OFFSET_FIND_HEIGHT)));
}

uint32 WorldObject::GetZoneId() const
{
    if (_updatePositionData)
        const_cast<WorldObject*>(this)->UpdatePositionData();

    return _zoneId;
}

uint32 WorldObject::GetAreaId() const
{
    if (_updatePositionData)
        const_cast<WorldObject*>(this)->UpdatePositionData();

    return _areaId;
}

void WorldObject::GetZoneAndAreaId(uint32& zoneid, uint32& areaid) const
{
    if (_updatePositionData)
        const_cast<WorldObject*>(this)->UpdatePositionData();

    zoneid = _zoneId;
    areaid = _areaId;
}

bool WorldObject::IsOutdoors() const
{
    if (_updatePositionData)
        const_cast<WorldObject*>(this)->UpdatePositionData();

    return _outdoors;
}

LiquidData const& WorldObject::GetLiquidData() const
{
    if (_updatePositionData)
        const_cast<WorldObject*>(this)->UpdatePositionData();

    return _liquidData;
}

void WorldObject::AddAllowedLooter(ObjectGuid guid)
{
    _allowedLooters.insert(guid);
}

void WorldObject::SetAllowedLooters(GuidUnorderedSet const looters)
{
    _allowedLooters = looters;
}

void WorldObject::ResetAllowedLooters()
{
    _allowedLooters.clear();
}

bool WorldObject::HasAllowedLooter(ObjectGuid guid) const
{
    if (_allowedLooters.empty())
    {
        return true;
    }

    return _allowedLooters.find(guid) != _allowedLooters.end();
}

GuidUnorderedSet const& WorldObject::GetAllowedLooters() const
{
    return _allowedLooters;
}

void WorldObject::RemoveAllowedLooter(ObjectGuid guid)
{
    _allowedLooters.erase(guid);
}

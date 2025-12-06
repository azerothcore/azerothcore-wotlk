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

#include "Corpse.h"
#include "CharacterCache.h"
#include "Common.h"
#include "DatabaseEnv.h"
#include "GameTime.h"
#include "Log.h"
#include "ObjectAccessor.h"
#include "Player.h"
#include "UpdateMask.h"
#include "World.h"

Corpse::Corpse(CorpseType type) : WorldObject(), m_type(type)
{
    m_objectType |= TYPEMASK_CORPSE;
    m_objectTypeId = TYPEID_CORPSE;
    m_updateFlag = (UPDATEFLAG_LOWGUID | UPDATEFLAG_STATIONARY_POSITION | UPDATEFLAG_POSITION);
    m_valuesCount = CORPSE_END;
    m_time = GameTime::GetGameTime().count();
    lootRecipient = nullptr;
}

Corpse::~Corpse()
{
}

void Corpse::AddToWorld()
{
    ///- Register the corpse for guid lookup
    if (!IsInWorld())
        GetMap()->GetObjectsStore().Insert<Corpse>(GetGUID(), this);

    Object::AddToWorld();
}

void Corpse::RemoveFromWorld()
{
    ///- Remove the corpse from the accessor
    if (IsInWorld())
        GetMap()->GetObjectsStore().Remove<Corpse>(GetGUID());

    WorldObject::RemoveFromWorld();
}

bool Corpse::Create(ObjectGuid::LowType guidlow)
{
    Object::_Create(guidlow, 0, HighGuid::Corpse);
    return true;
}

bool Corpse::Create(ObjectGuid::LowType guidlow, Player* owner)
{
    ASSERT(owner);

    Relocate(owner->GetPositionX(), owner->GetPositionY(), owner->GetPositionZ(), owner->GetOrientation());

    if (!IsPositionValid())
    {
        LOG_ERROR("entities.player", "Corpse (guidlow {}, owner {}) not created. Suggested coordinates isn't valid (X: {} Y: {})",
            guidlow, owner->GetName(), owner->GetPositionX(), owner->GetPositionY());
        return false;
    }

    WorldObject::_Create(guidlow, HighGuid::Corpse, owner->GetPhaseMask());

    SetObjectScale(1);
    SetGuidValue(CORPSE_FIELD_OWNER, owner->GetGUID());

    _cellCoord = Acore::ComputeCellCoord(GetPositionX(), GetPositionY());

    return true;
}

void Corpse::SaveToDB()
{
    // prevent DB data inconsistence problems and duplicates
    CharacterDatabaseTransaction trans = CharacterDatabase.BeginTransaction();
    DeleteFromDB(trans);

    CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_CORPSE);
    stmt->SetData(0, GetOwnerGUID().GetCounter());                            // guid
    stmt->SetData (1, GetPositionX());                                         // posX
    stmt->SetData (2, GetPositionY());                                         // posY
    stmt->SetData (3, GetPositionZ());                                         // posZ
    stmt->SetData (4, GetOrientation());                                       // orientation
    stmt->SetData(5, GetMapId());                                             // mapId
    stmt->SetData(6, GetUInt32Value(CORPSE_FIELD_DISPLAY_ID));                // displayId
    stmt->SetData(7, _ConcatFields(CORPSE_FIELD_ITEM, EQUIPMENT_SLOT_END));   // itemCache
    stmt->SetData(8, GetUInt32Value(CORPSE_FIELD_BYTES_1));                   // bytes1
    stmt->SetData(9, GetUInt32Value(CORPSE_FIELD_BYTES_2));                   // bytes2
    stmt->SetData(10, GetUInt32Value(CORPSE_FIELD_GUILD));                    // guildId
    stmt->SetData (11, GetUInt32Value(CORPSE_FIELD_FLAGS));                    // flags
    stmt->SetData (12, GetUInt32Value(CORPSE_FIELD_DYNAMIC_FLAGS));            // dynFlags
    stmt->SetData(13, uint32(m_time));                                        // time
    stmt->SetData (14, GetType());                                             // corpseType
    stmt->SetData(15, GetInstanceId());                                       // instanceId
    stmt->SetData(16, GetPhaseMask());                                        // phaseMask
    trans->Append(stmt);

    CharacterDatabase.CommitTransaction(trans);
}

void Corpse::DeleteFromDB(CharacterDatabaseTransaction trans)
{
    DeleteFromDB(GetOwnerGUID(), trans);
}

void Corpse::DeleteFromDB(ObjectGuid const& ownerGuid, CharacterDatabaseTransaction trans)
{
    CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_CORPSE);
    stmt->SetData(0, ownerGuid.GetCounter());
    CharacterDatabase.ExecuteOrAppend(trans, stmt);
}

bool Corpse::LoadCorpseFromDB(ObjectGuid::LowType guid, Field* fields)
{
    ObjectGuid::LowType ownerGuid = fields[16].Get<uint32>();

    //        0     1     2     3            4      5          6          7       8       9        10     11        12    13          14          15         16
    // SELECT posX, posY, posZ, orientation, mapId, displayId, itemCache, bytes1, bytes2, guildId, flags, dynFlags, time, corpseType, instanceId, phaseMask, guid FROM corpse WHERE mapId = ? AND instanceId = ?
    float posX   = fields[0].Get<float>();
    float posY   = fields[1].Get<float>();
    float posZ   = fields[2].Get<float>();
    float o      = fields[3].Get<float>();
    uint32 mapId = fields[4].Get<uint16>();

    Object::_Create(guid, 0, HighGuid::Corpse);

    SetObjectScale(1.0f);
    SetUInt32Value(CORPSE_FIELD_DISPLAY_ID, fields[5].Get<uint32>());

    if (!_LoadIntoDataField(fields[6].Get<std::string>(), CORPSE_FIELD_ITEM, EQUIPMENT_SLOT_END))
    {
        LOG_ERROR("entities.player", "Corpse ({}, owner: {}) is not created, given equipment info is not valid ('{}')",
            GetGUID().ToString(), GetOwnerGUID().ToString(), fields[6].Get<std::string>());
    }

    SetUInt32Value(CORPSE_FIELD_BYTES_1, fields[7].Get<uint32>());
    SetUInt32Value(CORPSE_FIELD_BYTES_2, fields[8].Get<uint32>());
    SetUInt32Value(CORPSE_FIELD_GUILD, fields[9].Get<uint32>());
    SetUInt32Value(CORPSE_FIELD_FLAGS, fields[10].Get<uint8>());
    SetUInt32Value(CORPSE_FIELD_DYNAMIC_FLAGS, fields[11].Get<uint8>());
    SetGuidValue(CORPSE_FIELD_OWNER, ObjectGuid::Create<HighGuid::Player>(ownerGuid));

    m_time = time_t(fields[12].Get<uint32>());

    uint32 instanceId  = fields[14].Get<uint32>();
    uint32 phaseMask   = fields[15].Get<uint32>();

    // place
    SetLocationInstanceId(instanceId);
    SetLocationMapId(mapId);
    SetPhaseMask(phaseMask, false);
    Relocate(posX, posY, posZ, o);

    if (!IsPositionValid())
    {
        LOG_ERROR("entities.player", "Corpse ( {}, owner: {}) is not created, given coordinates are not valid (X: {}, Y: {}, Z: {})",
            GetGUID().ToString(), GetOwnerGUID().ToString(), posX, posY, posZ);
        return false;
    }

    _cellCoord = Acore::ComputeCellCoord(GetPositionX(), GetPositionY());
    return true;
}

bool Corpse::IsExpired(time_t t) const
{
    // Deleted character
    if (!sCharacterCache->GetCharacterCacheByGuid(GetOwnerGUID()))
        return true;

    if (m_type == CORPSE_BONES)
        return m_time < t - 60 * MINUTE;
    else
        return m_time < t - 3 * DAY;
}

void Corpse::ResetGhostTime()
{
    m_time = GameTime::GetGameTime().count();
}

void Corpse::BuildValuesUpdate(uint8 updateType, ByteBuffer* data, Player* target)
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
        if (_fieldNotifyFlags & flags[index] || ((updateType == UPDATETYPE_VALUES ? _changesMask.GetBit(index) : m_uint32Values[index]) && (flags[index] & visibleFlag)))
        {
            updateMask.SetBit(index);

            if (index == CORPSE_FIELD_BYTES_1 || index == CORPSE_FIELD_BYTES_2)
            {
                Player* owner = ObjectAccessor::GetPlayer(*this, GetOwnerGUID());
                if (owner && owner != target && sWorld->getBoolConfig(CONFIG_ALLOW_TWO_SIDE_INTERACTION_GROUP) && owner->IsInRaidWith(target) && owner->GetTeamId() != target->GetTeamId())
                {
                    uint32 playerBytes = target->GetUInt32Value(PLAYER_BYTES);
                    uint32 playerBytes2 = target->GetUInt32Value(PLAYER_BYTES_2);

                    uint8 race = target->getRace();
                    uint8 skin = (uint8)(playerBytes);
                    uint8 face = (uint8)(playerBytes >> 8);
                    uint8 hairstyle = (uint8)(playerBytes >> 16);
                    uint8 haircolor = (uint8)(playerBytes >> 24);
                    uint8 facialhair = (uint8)(playerBytes2);

                    uint32 corpseBytes1 = ((0x00) | (race << 8) | (target->GetByteValue(PLAYER_BYTES_3, 0) << 16) | (skin << 24));
                    uint32 corpseBytes2 = ((face) | (hairstyle << 8) | (haircolor << 16) | (facialhair << 24));

                    if (index == CORPSE_FIELD_BYTES_1)
                    {
                        fieldBuffer << corpseBytes1;
                    }
                    else
                    {
                        fieldBuffer << corpseBytes2;
                    }
                }
                else
                {
                    fieldBuffer << m_uint32Values[index];
                }
            }
            else
            {
                fieldBuffer << m_uint32Values[index];
            }
        }
    }

    *data << uint8(updateMask.GetBlockCount());
    updateMask.AppendToPacket(data);
    data->append(fieldBuffer);
}

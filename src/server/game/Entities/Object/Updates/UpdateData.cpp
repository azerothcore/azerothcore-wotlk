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

#include "UpdateData.h"
#include "ByteBuffer.h"
#include "Errors.h"
#include "Log.h"
#include "Opcodes.h"
#include "World.h"
#include "WorldPacket.h"

UpdateData::UpdateData() : m_blockCount(0)
{
    m_outOfRangeGUIDs.reserve(15);
}

void UpdateData::AddOutOfRangeGUID(ObjectGuid guid)
{
    m_outOfRangeGUIDs.push_back(guid);
}

void UpdateData::AddUpdateBlock(const ByteBuffer& block)
{
    m_data.append(block);
    ++m_blockCount;
}

void UpdateData::AddUpdateBlock(const UpdateData& block)
{
    m_data.append(block.m_data);
    m_blockCount += block.m_blockCount;
}

bool UpdateData::BuildPacket(WorldPacket& packet)
{
    ASSERT(packet.empty());

    packet.reserve(4 + (m_outOfRangeGUIDs.empty() ? 0 : 1 + 4 + 9 * m_outOfRangeGUIDs.size()) + m_data.wpos());

    packet << (uint32) (!m_outOfRangeGUIDs.empty() ? m_blockCount + 1 : m_blockCount);

    if (!m_outOfRangeGUIDs.empty())
    {
        packet << (uint8) UPDATETYPE_OUT_OF_RANGE_OBJECTS;
        packet << (uint32) m_outOfRangeGUIDs.size();

        for (ObjectGuid const& guid : m_outOfRangeGUIDs)
            packet << guid.WriteAsPacked();
    }

    packet.append(m_data);
    packet.SetOpcode(SMSG_UPDATE_OBJECT);

    return true;
}

void UpdateData::Clear()
{
    m_data.clear();
    m_outOfRangeGUIDs.clear();
    m_blockCount = 0;
}

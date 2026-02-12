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

#include "LFGGroupData.h"
#include "LFG.h"
#include "World.h"

namespace lfg
{
    LfgGroupData::LfgGroupData(): m_State(LFG_STATE_NONE), m_OldState(LFG_STATE_NONE),
        m_Dungeon(0), _isLFGGroup(false), m_KicksLeft(sWorld->getIntConfig(CONFIG_LFG_MAX_KICK_COUNT))
    { }

    LfgGroupData::~LfgGroupData()
    { }

    bool LfgGroupData::IsLfgGroup()
    {
        return _isLFGGroup;
    }

    void LfgGroupData::SetState(LfgState state)
    {
        switch (state)
        {
            case LFG_STATE_DUNGEON:
                _isLFGGroup = true;
                break;
            case LFG_STATE_FINISHED_DUNGEON:
                _isLFGGroup = false;
                break;
            default:
                break;
        }

        switch (state)
        {
            case LFG_STATE_NONE:
                m_Dungeon = 0;
                m_KicksLeft = sWorld->getIntConfig(CONFIG_LFG_MAX_KICK_COUNT);
                [[fallthrough]];
            case LFG_STATE_FINISHED_DUNGEON:
            case LFG_STATE_DUNGEON:
                m_OldState = state;
                [[fallthrough]];
            default:
                m_State = state;
        }
    }

    void LfgGroupData::RestoreState()
    {
        m_State = m_OldState;
    }

    void LfgGroupData::AddPlayer(ObjectGuid guid)
    {
        m_Players.insert(guid);
    }

    uint8 LfgGroupData::RemovePlayer(ObjectGuid guid)
    {
        LfgGuidSet::iterator it = m_Players.find(guid);
        if (it != m_Players.end())
            m_Players.erase(it);
        return uint8(m_Players.size());
    }

    void LfgGroupData::RemoveAllPlayers()
    {
        m_Players.clear();
    }

    void LfgGroupData::SetLeader(ObjectGuid guid)
    {
        m_Leader = guid;
    }

    void LfgGroupData::SetDungeon(uint32 dungeon)
    {
        m_Dungeon = dungeon;
    }

    void LfgGroupData::DecreaseKicksLeft()
    {
        if (m_KicksLeft)
            --m_KicksLeft;
    }

    LfgState LfgGroupData::GetState() const
    {
        return m_State;
    }

    LfgState LfgGroupData::GetOldState() const
    {
        return m_OldState;
    }

    LfgGuidSet const& LfgGroupData::GetPlayers() const
    {
        return m_Players;
    }

    uint8 LfgGroupData::GetPlayerCount() const
    {
        return m_Players.size();
    }

    ObjectGuid LfgGroupData::GetLeader() const
    {
        return m_Leader;
    }

    uint32 LfgGroupData::GetDungeon(bool asId /* = true */) const
    {
        if (asId)
            return (m_Dungeon & 0x00FFFFFF);
        else
            return m_Dungeon;
    }

    uint8 LfgGroupData::GetKicksLeft() const
    {
        return m_KicksLeft;
    }

    void LfgGroupData::AddRandomQueuedPlayer(ObjectGuid guid)
    {
        m_RandomQueuedPlayers.insert(guid);
    }

    [[nodiscard]] bool LfgGroupData::IsRandomQueuedPlayer(ObjectGuid guid) const
    {
        return m_RandomQueuedPlayers.contains(guid);
    }
} // namespace lfg

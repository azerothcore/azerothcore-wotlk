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

#ifndef _LFGGROUPDATA_H
#define _LFGGROUPDATA_H

#include "LFG.h"

namespace lfg
{
    /**
        Stores all lfg data needed about a group.
    */
    class LfgGroupData
    {
    public:
        LfgGroupData();
        ~LfgGroupData();

        bool IsLfgGroup();

        // General
        void SetState(LfgState state);
        void RestoreState();
        void AddPlayer(ObjectGuid guid);
        void AddRandomQueuedPlayer(ObjectGuid guid);
        [[nodiscard]] bool IsRandomQueuedPlayer(ObjectGuid guid) const;
        uint8 RemovePlayer(ObjectGuid guid);
        void RemoveAllPlayers();
        void SetLeader(ObjectGuid guid);

        // Dungeon
        void SetDungeon(uint32 dungeon);

        // VoteKick
        void DecreaseKicksLeft();

        // General
        [[nodiscard]] LfgState GetState() const;
        [[nodiscard]] LfgState GetOldState() const;
        [[nodiscard]] LfgGuidSet const& GetPlayers() const;
        [[nodiscard]] uint8 GetPlayerCount() const;
        [[nodiscard]] ObjectGuid GetLeader() const;

        // Dungeon
        [[nodiscard]] uint32 GetDungeon(bool asId = true) const;

        // VoteKick
        [[nodiscard]] uint8 GetKicksLeft() const;

    private:
        // General
        LfgState m_State;                   ///< State if group in LFG
        LfgState m_OldState;                ///< Old State
        ObjectGuid m_Leader;                ///< Leader GUID
        LfgGuidSet m_Players;               ///< Players in group
        LfgGuidSet m_RandomQueuedPlayers;   ///< Players that queued for random dungeon
        // Dungeon
        uint32 m_Dungeon;                   ///< Dungeon entry
        bool _isLFGGroup;
        // Vote Kick
        uint8 m_KicksLeft;                  ///< Number of kicks left
    };

} // namespace lfg

#endif

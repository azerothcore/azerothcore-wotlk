/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef _LFGGROUPDATA_H
#define _LFGGROUPDATA_H

#include "LFG.h"

namespace lfg
{

enum LfgGroupEnum
{
    LFG_GROUP_MAX_KICKS                           = 3,
};

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
        void AddPlayer(uint64 guid);
        uint8 RemovePlayer(uint64 guid);
        void RemoveAllPlayers();
        void SetLeader(uint64 guid);

        // Dungeon
        void SetDungeon(uint32 dungeon);

        // VoteKick
        void DecreaseKicksLeft();

        // General
        LfgState GetState() const;
        LfgState GetOldState() const;
        LfgGuidSet const& GetPlayers() const;
        uint8 GetPlayerCount() const;
        uint64 GetLeader() const;

        // Dungeon
        uint32 GetDungeon(bool asId = true) const;

        // VoteKick
        uint8 GetKicksLeft() const;

    private:
        // General
        LfgState m_State;                                  ///< State if group in LFG
        LfgState m_OldState;                               ///< Old State
        uint64 m_Leader;                                   ///< Leader GUID
        LfgGuidSet m_Players;                              ///< Players in group
        // Dungeon
        uint32 m_Dungeon;                                  ///< Dungeon entry
        // Vote Kick
        uint8 m_KicksLeft;                                 ///< Number of kicks left
};

} // namespace lfg

#endif

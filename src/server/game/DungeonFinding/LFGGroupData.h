/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
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
        void AddPlayer(ObjectGuid guid);
        uint8 RemovePlayer(ObjectGuid guid);
        void RemoveAllPlayers();
        void SetLeader(ObjectGuid guid);

        // Dungeon
        void SetDungeon(uint32 dungeon);

        // VoteKick
        void DecreaseKicksLeft();

        // General
        LfgState GetState() const;
        LfgState GetOldState() const;
        LfgGuidSet const& GetPlayers() const;
        uint8 GetPlayerCount() const;
        ObjectGuid GetLeader() const;

        // Dungeon
        uint32 GetDungeon(bool asId = true) const;

        // VoteKick
        uint8 GetKicksLeft() const;

    private:
        // General
        LfgState m_State;                                  ///< State if group in LFG
        LfgState m_OldState;                               ///< Old State
        ObjectGuid m_Leader;                               ///< Leader GUID
        LfgGuidSet m_Players;                              ///< Players in group
        // Dungeon
        uint32 m_Dungeon;                                  ///< Dungeon entry
        // Vote Kick
        uint8 m_KicksLeft;                                 ///< Number of kicks left
    };

} // namespace lfg

#endif

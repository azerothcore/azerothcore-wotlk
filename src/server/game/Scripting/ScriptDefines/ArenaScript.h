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

#ifndef SCRIPT_OBJECT_ARENA_SCRIPT_H_
#define SCRIPT_OBJECT_ARENA_SCRIPT_H_

#include "ObjectGuid.h"
#include "ScriptObject.h"
#include <vector>

enum ArenaHook
{
    ARENAHOOK_CAN_ADD_MEMBER,
    ARENAHOOK_ON_GET_POINTS,
    ARENAHOOK_CAN_SAVE_TO_DB,
    ARENAHOOK_ON_BEFORE_CHECK_WIN_CONDITION,
    ARENAHOOK_ON_ARENA_START,
    ARENAHOOK_ON_BEFORE_TEAM_MEMBER_UPDATE,
    ARENAHOOK_CAN_SAVE_ARENA_STATS_FOR_MEMBER,
    ARENAHOOK_END
};

class ArenaScript : public ScriptObject
{
protected:

    ArenaScript(const char* name, std::vector<uint16> enabledHooks = std::vector<uint16>());

public:

    [[nodiscard]] bool IsDatabaseBound() const override { return false; }

    [[nodiscard]] virtual bool CanAddMember(ArenaTeam* /*team*/, ObjectGuid /*PlayerGuid*/) { return true; }

    virtual void OnGetPoints(ArenaTeam* /*team*/, uint32 /*memberRating*/, float& /*points*/) { }

    [[nodiscard]] virtual bool OnBeforeArenaCheckWinConditions(Battleground* const /* bg */) { return true; }

    [[nodiscard]] virtual bool CanSaveToDB(ArenaTeam* /*team*/) { return true; }

    virtual void OnArenaStart(Battleground* /* bg */) { };

    [[nodiscard]] virtual bool OnBeforeArenaTeamMemberUpdate(ArenaTeam* /*team*/, Player* /*player*/, bool /*won*/, uint32 /*opponentMatchmakerRating*/, int32 /*matchmakerChange*/) { return false; }

    [[nodiscard]] virtual bool CanSaveArenaStatsForMember(ArenaTeam* /*team*/, ObjectGuid /*playerGuid*/) { return true; }
};

#endif

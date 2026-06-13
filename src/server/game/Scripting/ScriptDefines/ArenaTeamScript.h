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

#ifndef SCRIPT_OBJECT_ARENA_TEAM_SCRIPT_H_
#define SCRIPT_OBJECT_ARENA_TEAM_SCRIPT_H_

#include "Battleground.h"
#include "ScriptObject.h"
#include <vector>

enum ArenaTeamHook
{
    ARENATEAMHOOK_ON_GET_SLOT_BY_TYPE,
    ARENATEAMHOOK_ON_GET_ARENA_POINTS,
    ARENATEAMHOOK_ON_TYPEID_TO_QUEUEID,
    ARENATEAMHOOK_ON_QUEUEID_TO_ARENA_TYPE,
    ARENATEAMHOOK_ON_SET_ARENA_MAX_PLAYERS_PER_TEAM,
    ARENATEAMHOOK_END
};

class ArenaTeamScript : public ScriptObject
{
protected:
    ArenaTeamScript(const char* name, std::vector<uint16> enabledHooks = std::vector<uint16>());

public:
    [[nodiscard]] bool IsDatabaseBound() const override { return false; };

    virtual void OnGetSlotByType(const uint32 /*type*/, uint8& /*slot*/) {}
    virtual void OnGetArenaPoints(ArenaTeam* /*team*/, float& /*points*/) {}
    virtual void OnTypeIDToQueueID(const BattlegroundTypeId /*bgTypeId*/, const uint8 /*arenaType*/, uint32& /*queueTypeID*/) {}
    virtual void OnQueueIdToArenaType(const BattlegroundQueueTypeId /*bgQueueTypeId*/, uint8& /*ArenaType*/) {}
    virtual void OnSetArenaMaxPlayersPerTeam(const uint8 /*arenaType*/, uint32& /*maxPlayerPerTeam*/) {}
};

#endif

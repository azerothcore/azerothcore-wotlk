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
};

#endif

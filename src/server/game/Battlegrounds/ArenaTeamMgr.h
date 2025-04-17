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

#ifndef _ARENATEAMMGR_H
#define _ARENATEAMMGR_H

#include "ArenaTeam.h"

constexpr uint32 MAX_ARENA_TEAM_ID = 0xFFF00000;
constexpr uint32 MAX_TEMP_ARENA_TEAM_ID = 0xFFFFFFFE;

class ArenaTeamMgr
{
    ArenaTeamMgr();
    ~ArenaTeamMgr();

public:
    static ArenaTeamMgr* instance();

    typedef std::unordered_map<uint32, ArenaTeam*> ArenaTeamContainer;

    ArenaTeam* GetArenaTeamById(uint32 arenaTeamId) const;
    ArenaTeam* GetArenaTeamByName(std::string const& arenaTeamName) const;
    ArenaTeam* GetArenaTeamByCaptain(ObjectGuid guid) const;
    ArenaTeam* GetArenaTeamByName(std::string const& arenaTeamName, const uint32 type) const;
    ArenaTeam* GetArenaTeamByCaptain(ObjectGuid guid, const uint32 type) const;

    void LoadArenaTeams();
    void AddArenaTeam(ArenaTeam* arenaTeam);
    void RemoveArenaTeam(uint32 Id);

    void DeleteAllArenaTeams();

    ArenaTeamContainer::iterator GetArenaTeamMapBegin() { return ArenaTeamStore.begin(); }
    ArenaTeamContainer::iterator GetArenaTeamMapEnd()   { return ArenaTeamStore.end(); }
    ArenaTeamContainer& GetArenaTeams() { return ArenaTeamStore; }

    void DistributeArenaPoints();

    uint32 GenerateArenaTeamId();
    void SetNextArenaTeamId(uint32 Id) { NextArenaTeamId = Id; }

    uint32 GetNextArenaLogId() { return ++LastArenaLogId; }
    void SetLastArenaLogId(uint32 id) { LastArenaLogId = id; }

    uint32 GenerateTempArenaTeamId();

protected:
    uint32 NextArenaTeamId;
    uint32 NextTempArenaTeamId;
    ArenaTeamContainer ArenaTeamStore;
    uint32 LastArenaLogId;
};

#define sArenaTeamMgr ArenaTeamMgr::instance()

#endif

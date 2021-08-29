/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
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

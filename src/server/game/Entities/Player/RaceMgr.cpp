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

#include "RaceMgr.h"
#include "AccountMgr.h"
#include "DatabaseEnv.h"
#include "ObjectMgr.h"
#include "Player.h"
#include "Util.h"
#include "WorldPacket.h"
#include "WorldSession.h"

uint8  RaceMgr::_maxRaces = 0;

uint64 RaceMgr::_playableRaceMask = 0;
uint64 RaceMgr::_allianceRaceMask = 0;
uint64 RaceMgr::_hordeRaceMask = 0;

RaceMgr::RaceMgr()
{
}

RaceMgr::~RaceMgr()
{
}

RaceMgr* RaceMgr::instance()
{
    static RaceMgr instance;
    return &instance;
}

void RaceMgr::LoadRaces()
{
    //LOG_ERROR("sql.sql", "shareddefines!");
    //LOG_ERROR("sql.sql.", "max races: {}, playable: {}, horde: {}, alliance: {}", MAX_RACES, RACEMASK_ALL_PLAYABLE, RACEMASK_HORDE, RACEMASK_ALLIANCE);
    for (auto const& raceEntry : sChrRacesStore)
    {
        if (!raceEntry)
            continue;

        uint8 alliance = raceEntry->alliance;
        uint8 raceId = raceEntry->RaceID;

        if (alliance == ALLIANCE_NEUTRAL)
            continue; // Not playable race (no flags obviously distinguishing playable from not)

        if (GetMaxRaces() <= raceId)
            SetMaxRaces(raceId + 1);

        uint64 raceBit = (1ULL << (raceId - 1));  // Races are 1-indexed

        _playableRaceMask |= raceBit;

        if (alliance == ALLIANCE_HORDE)
            _hordeRaceMask |= raceBit; // do something
        else if (alliance == ALLIANCE_ALLIANCE)
            _allianceRaceMask |= raceBit; // do something else


        /*
        // Store race data
        RaceEntry& race = _races[raceId];
        race.raceId = raceId;
        race.faction = raceEntry->FactionID;  // Check actual field name
        race.isPlayable = (raceEntry->Flags & 0x01) != 0;  // Check actual playable flag

        // Track max race ID
        if (raceId >= _maxRaces)
            _maxRaces = raceId + 1;
            */
    }

    LOG_ERROR("sql.sql", "racemgr!");
    LOG_ERROR("sql.sql.", "max races: {}, playable: {}, horde: {}, alliance: {}", GetMaxRaces(), GetPlayableRaceMask(), GetHordeRaceMask(), GetAllianceRaceMask());
    return;
}

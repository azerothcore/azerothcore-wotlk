#ifndef CROSSFACTION_H
#define CROSSFACTION_H

#include "ScriptMgr.h"
#include "Language.h"
#include "Player.h"
#include "ObjectAccessor.h"
#include "Group.h"
#include "Map.h"
#include "Log.h"
#include <vector>
#include <algorithm>

class CrossFaction
{
    public:
        void LoadConfig(bool reload);
        void UpdatePlayerTeam(Group* group, uint64 guid, bool reset = false);
        void UpdateGroupLeaderMap(uint64 leaderGuid) { LeaderRaceMap[leaderGuid] = GetPlayerRace(leaderGuid); };

    private:
        // Group leader guid-race caching
        UNORDERED_MAP<uint64, uint8> LeaderRaceMap; 
        uint8 GetPlayerRace(uint64 playerGuid);

        // Disables system
        typedef std::vector<uint32> CrossFactionDisableList;

        CrossFactionDisableList mapDisable;
        CrossFactionDisableList zoneDisable;
        CrossFactionDisableList areaDisable;

        bool isMapEnabled(uint32 mapid) { return std::find(mapDisable.begin(), mapDisable.end(), mapid) == mapDisable.end(); };
        bool isZoneEnabled(uint32 mapid) { return std::find(zoneDisable.begin(), zoneDisable.end(), mapid) == zoneDisable.end(); };
        bool isAreaEnabled(uint32 mapid) { return std::find(areaDisable.begin(), areaDisable.end(), mapid) == areaDisable.end(); };
};

#define sCrossFaction ACE_Singleton<CrossFaction, ACE_Null_Mutex>::instance()


#endif

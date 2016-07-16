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

        // functions needed to control the 
        void LoadConfig(bool reload);
        void UpdatePlayerTeam(Group* group, uint64 guid, bool reset = false);

    private:
        typedef std::vector<uint32> CrossFactionDisableList;

        // the different disable lists
        CrossFactionDisableList mapDisable;
        CrossFactionDisableList zoneDisable;
        CrossFactionDisableList areaDisable;

        // Check functions
        bool isMapEnabled(uint32 mapid) { return std::find(mapDisable.begin(), mapDisable.end(), mapid) == mapDisable.end(); };
        bool isZoneEnabled(uint32 mapid) { return std::find(zoneDisable.begin(), zoneDisable.end(), mapid) == zoneDisable.end(); };
        bool isAreaEnabled(uint32 mapid) { return std::find(areaDisable.begin(), areaDisable.end(), mapid) == areaDisable.end(); };

};

#define sCrossFaction ACE_Singleton<CrossFaction, ACE_Null_Mutex>::instance()


#endif
#ifndef CROSSFACTION_H
#define CROSSFACTION_H

#include "ScriptMgr.h"
#include "Language.h"
#include "Player.h"
#include "Vehicle.h"
#include "ObjectAccessor.h"
#include "Group.h"
#include "Map.h"
#include "Log.h"
#include "Opcodes.h"
#include <vector>
#include <algorithm>

enum FakeMorphs
{
    FAKE_F_TAUREN   = 20584,
    FAKE_M_TAUREN   = 20585,
    FAKE_M_NELF     = 20318,
    FAKE_F_DRAENEI  = 20323,
    FAKE_M_HUMAN    = 19723,
    FAKE_F_HUMAN    = 19724,
    FAKE_M_BELF     = 20578,
    FAKE_F_BELF     = 20579
};

class CrossFaction
{
    public:
        // Race Update
        void SetFakeRaceAndMorph(Player* player);
        uint8 GetFakeRace(uint64 playerGuid);
        uint32 GetFakeMorph(uint64 playerGuid);
        void SetMorph(Player* player, bool value);
        void SetResetCache(uint64 guid, bool value) { m_resetCache[guid] = value; };
        void ResetCacheWorker();

        // Team Update
        void LoadConfig(bool reload);
        void UpdatePlayerTeam(Group* group, uint64 guid, bool reset = false);
        void UpdateGroupLeaderMap(uint64 leaderGuid, bool remove = false);
        void UpdateAllGroups();

        // Battleground race player invalidation - retrieval
        void DoForgetPlayersInBG(Battleground* pBattleGround, Player* player);

    private:
        // Group leader guid-race caching
        UNORDERED_MAP<uint64, uint8> LeaderRaceMap; 
        uint8 GetLeaderRace(uint64 playerGuid);

        // Fake race caching
        UNORDERED_MAP<uint64, uint8> m_FakeRace;
        UNORDERED_MAP<uint64, uint32> m_FakeMorph;
        UNORDERED_MAP<uint64, bool> m_resetCache;

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

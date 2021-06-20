/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef OUTDOOR_PVP_MGR_H_
#define OUTDOOR_PVP_MGR_H_

#define OUTDOORPVP_OBJECTIVE_UPDATE_INTERVAL 1000

#include "OutdoorPvP.h"

class Player;
class GameObject;
class Creature;
class ZoneScript;
struct GossipMenuItems;

struct OutdoorPvPData
{
    OutdoorPvPTypes TypeId;
    uint32 ScriptId;
};

// class to handle player enter / leave / areatrigger / GO use events
class OutdoorPvPMgr
{
    private:
        OutdoorPvPMgr();
        ~OutdoorPvPMgr() {};

    public:
        static OutdoorPvPMgr* instance();

        // create outdoor pvp events
        void InitOutdoorPvP();

        // cleanup
        void Die();

        // called when a player enters an outdoor pvp area
        void HandlePlayerEnterZone(Player* player, uint32 areaflag);

        // called when player leaves an outdoor pvp area
        void HandlePlayerLeaveZone(Player* player, uint32 areaflag);

        // called when player resurrects
        void HandlePlayerResurrects(Player* player, uint32 areaflag);

        // return assigned outdoor pvp
        OutdoorPvP* GetOutdoorPvPToZoneId(uint32 zoneid);

        // handle custom (non-exist in dbc) spell if registered
        bool HandleCustomSpell(Player* player, uint32 spellId, GameObject* go);

        // handle custom go if registered
        bool HandleOpenGo(Player* player, uint64 guid);

        ZoneScript* GetZoneScript(uint32 zoneId);

        void AddZone(uint32 zoneid, OutdoorPvP* handle);

        void Update(uint32 diff);

        void HandleGossipOption(Player* player, uint64 guid, uint32 gossipid);

        bool CanTalkTo(Player* player, Creature* creature, GossipMenuItems const& gso);

        void HandleDropFlag(Player* player, uint32 spellId);

        // pussywizard: lock required because different functions affect m_players
        ACE_Thread_Mutex _lock;

    private:
        typedef std::vector<OutdoorPvP*> OutdoorPvPSet;
        typedef std::map<uint32 /* zoneid */, OutdoorPvP*> OutdoorPvPMap;
        typedef std::map<OutdoorPvPTypes, OutdoorPvPData*> OutdoorPvPDataMap;

        // contains all initiated outdoor pvp events
        // used when initing / cleaning up
        OutdoorPvPSet  m_OutdoorPvPSet;

        // maps the zone ids to an outdoor pvp event
        // used in player event handling
        OutdoorPvPMap   m_OutdoorPvPMap;

        // Holds the outdoor PvP templates
        OutdoorPvPDataMap m_OutdoorPvPDatas;

        // update interval
        uint32 m_UpdateTimer;
};

#define sOutdoorPvPMgr OutdoorPvPMgr::instance()

#endif /*OUTDOOR_PVP_MGR_H_*/

/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef BATTLEFIELD_MGR_H_
#define BATTLEFIELD_MGR_H_

#include "Battlefield.h"

class Player;
class GameObject;
class Creature;
class ZoneScript;
struct GossipMenuItems;

// class to handle player enter / leave / areatrigger / GO use events
class BattlefieldMgr
{
  public:
    // ctor
    BattlefieldMgr();
    // dtor
    ~BattlefieldMgr();

    static BattlefieldMgr* instance();

    // create battlefield events
    void InitBattlefield();
    // called when a player enters an battlefield area
    void HandlePlayerEnterZone(Player * player, uint32 areaflag);
    // called when player leaves an battlefield area
    void HandlePlayerLeaveZone(Player * player, uint32 areaflag);
    // called when player resurrects
    void HandlePlayerResurrects(Player * player, uint32 areaflag);
    // return assigned battlefield
    Battlefield* GetBattlefieldToZoneId(uint32 zoneid);
    Battlefield* GetBattlefieldByBattleId(uint32 battleid);

    ZoneScript* GetZoneScript(uint32 zoneId);

    void AddZone(uint32 zoneid, Battlefield * handle);

    void Update(uint32 diff);

    void HandleGossipOption(Player * player, uint64 guid, uint32 gossipid);

    bool CanTalkTo(Player * player, Creature * creature, GossipMenuItems gso);

    void HandleDropFlag(Player * player, uint32 spellId);

    typedef std::vector < Battlefield * >BattlefieldSet;
    typedef std::map < uint32 /* zoneid */ , Battlefield * >BattlefieldMap;
  private:
    // contains all initiated battlefield events
    // used when initing / cleaning up
      BattlefieldSet m_BattlefieldSet;
    // maps the zone ids to an battlefield event
    // used in player event handling
    BattlefieldMap m_BattlefieldMap;
    // update interval
    uint32 m_UpdateTimer;
};

#define sBattlefieldMgr BattlefieldMgr::instance()

#endif

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

#ifndef OUTDOOR_PVP_H_
#define OUTDOOR_PVP_H_

#include "SharedDefines.h"
#include "ZoneScript.h"
#include "WorldStatePackets.h"
#include <array>

class GameObject;

enum OutdoorPvPTypes
{
    OUTDOOR_PVP_HP = 1,
    OUTDOOR_PVP_NA = 2,
    OUTDOOR_PVP_TF = 3,
    OUTDOOR_PVP_ZM = 4,
    OUTDOOR_PVP_SI = 5,
    OUTDOOR_PVP_EP = 6,
    OUTDOOR_PVP_GH = 7,
};

#define MAX_OUTDOORPVP_TYPES 8

enum ObjectiveStates
{
    OBJECTIVESTATE_NEUTRAL = 0,
    OBJECTIVESTATE_ALLIANCE,
    OBJECTIVESTATE_HORDE,
    OBJECTIVESTATE_NEUTRAL_ALLIANCE_CHALLENGE,
    OBJECTIVESTATE_NEUTRAL_HORDE_CHALLENGE,
    OBJECTIVESTATE_ALLIANCE_HORDE_CHALLENGE,
    OBJECTIVESTATE_HORDE_ALLIANCE_CHALLENGE,
};

// struct for go spawning
struct go_type
{
    uint32 entry;
    uint32 map;
    float x;
    float y;
    float z;
    float o;
    float rot0;
    float rot1;
    float rot2;
    float rot3;
};

// struct for creature spawning
struct creature_type
{
    uint32 entry;
    uint32 map;
    float x;
    float y;
    float z;
    float o;
};

// some class predefs
class Player;
class GameObject;
class WorldPacket;
class Creature;
class Unit;
class OutdoorPvP;

struct GossipMenuItems;

typedef GuidSet PlayerSet;

class OPvPCapturePoint
{
public:
    explicit OPvPCapturePoint(OutdoorPvP* pvp);
    virtual ~OPvPCapturePoint() = default;

    virtual void FillInitialWorldStates(WorldPackets::WorldState::InitWorldStates& /*packet*/) { }

    // send world state update to all players present
    void SendUpdateWorldState(uint32 field, uint32 value);

    // send kill notify to players in the controlling faction
    void SendObjectiveComplete(uint32 id, ObjectGuid guid = ObjectGuid::Empty);

    // used when player is activated/inactivated in the area
    virtual bool HandlePlayerEnter(Player* player);
    virtual void HandlePlayerLeave(Player* player);

    // checks if player is in range of a capture credit marker
    bool IsInsideObjective(Player* player) const;

    virtual bool HandleCustomSpell(Player* player, uint32 spellId, GameObject* go);

    virtual int32 HandleOpenGo(Player* player, GameObject* go);

    // returns true if the state of the objective has changed, in this case, the OutdoorPvP must send a world state ui update.
    virtual bool Update(uint32 diff);
    virtual void ChangeState() = 0;
    virtual void ChangeTeam(TeamId /*oldTeam*/) {}
    virtual void SendChangePhase();
    virtual bool HandleGossipOption(Player* player, Creature* creature, uint32 gossipId);
    virtual bool CanTalkTo(Player* player, Creature* c, GossipMenuItems const& gso);
    virtual bool HandleDropFlag(Player* player, uint32 spellId);
    virtual void DeleteSpawns();

    ObjectGuid::LowType m_capturePointSpawnId{};
    GameObject* _capturePoint{};

    void AddGO(uint32 type, ObjectGuid::LowType guid, uint32 entry = 0);
    void AddCre(uint32 type, ObjectGuid::LowType guid, uint32 entry = 0);

    bool SetCapturePointData(uint32 entry, uint32 map, float x, float y, float z, float o = 0,
                             float rotation0 = 0, float rotation1 = 0, float rotation2 = 0, float rotation3 = 0);

    void SetSlider(float slider);

    [[nodiscard]] float GetSlider() const
    {
        return _value;
    }

protected:
    bool AddObject(uint32 type, uint32 entry, uint32 map, float x, float y, float z, float o,
                   float rotation0, float rotation1, float rotation2, float rotation3);
    bool AddCreature(uint32 type, uint32 entry, uint32 map, float x, float y, float z, float o, uint32 spawntimeDelay = 0);
    bool DelCreature(uint32 type);
    bool DelObject(uint32 type);
    bool DelCapturePoint();

protected:
    // active players in the area of the objective, 0 - alliance, 1 - horde
    std::array<PlayerSet, 2> _activePlayers;

    // total shift needed to capture the objective
    float _maxValue{};
    float _minValue{};

    // maximum speed of capture
    float _maxSpeed{};

    // the status of the objective
    float _value{};

    TeamId _team{ TEAM_NEUTRAL };

    // objective states
    ObjectiveStates _oldState{ OBJECTIVESTATE_NEUTRAL };
    ObjectiveStates _state{ OBJECTIVESTATE_NEUTRAL };

    // neutral value on capture bar
    uint32 _neutralValuePct{};

    // pointer to the OutdoorPvP this objective belongs to
    OutdoorPvP* _pvp{};

    // map to store the various game objects and creatures
    // spawned by the objective
    //        type, guid
    std::unordered_map<uint32, ObjectGuid::LowType> _objects;
    std::unordered_map<uint32, ObjectGuid::LowType> _creatures;
    std::unordered_map<ObjectGuid::LowType, uint32> _objectTypes;
    std::unordered_map<ObjectGuid::LowType, uint32> _creatureTypes;
};

// base class for specific outdoor pvp handlers
class OutdoorPvP : public ZoneScript
{
    friend class OutdoorPvPMgr;

public:
    // ctor
    OutdoorPvP() = default;

    // dtor
    ~OutdoorPvP() override;

    // deletes all gos/creatures spawned by the pvp
    void DeleteSpawns();

    typedef std::map<ObjectGuid::LowType/*lowguid*/, OPvPCapturePoint*> OPvPCapturePointMap;
    typedef std::pair<ObjectGuid::LowType, GameObject*> GoScriptPair;
    typedef std::pair<ObjectGuid::LowType, Creature*> CreatureScriptPair;

    virtual void FillInitialWorldStates(WorldPackets::WorldState::InitWorldStates& /*packet*/) {}

    // called when a player triggers an area trigger
    virtual bool HandleAreaTrigger(Player* player, uint32 trigger);

    // called on custom spell
    virtual bool HandleCustomSpell(Player* player, uint32 spellId, GameObject* go);

    // called on go use
    virtual bool HandleOpenGo(Player* player, GameObject* go);

    // setup stuff
    virtual bool SetupOutdoorPvP() {return true;}

    void OnGameObjectCreate(GameObject* go) override;
    void OnGameObjectRemove(GameObject* go) override;
    void OnCreatureCreate(Creature* creature) override;
    void OnCreatureRemove(Creature* creature) override;

    // send world state update to all players present
    void SendUpdateWorldState(uint32 field, uint32 value);

    // called by OutdoorPvPMgr, updates the objectives and if needed, sends new worldstateui information
    virtual bool Update(uint32 diff);

    // handle npc/player kill
    virtual void HandleKill(Player* killer, Unit* killed);
    virtual void HandleKillImpl(Player* /*killer*/, Unit* /*killed*/) {}

    // checks if player is in range of a capture credit marker
    bool IsInsideObjective(Player* player) const;

    // awards rewards for player kill
    virtual void AwardKillBonus(Player* /*player*/) {}

    uint32 GetTypeId() const { return _typeId; }
    virtual bool HandleDropFlag(Player* player, uint32 spellId);
    virtual bool HandleGossipOption(Player* player, Creature* creature, uint32 gossipId);
    virtual bool CanTalkTo(Player* player, Creature* c, GossipMenuItems const& gso);
    void TeamApplyBuff(TeamId teamId, uint32 spellId, uint32 spellId2 = 0, Player* sameMapPlr = nullptr);

    Map* GetMap() const { return _map; }

protected:
    void BroadcastPacket(WorldPacket& data) const;

    virtual void SendRemoveWorldStates(Player* /*player*/) {} // world state stuff
    virtual void HandlePlayerEnterZone(Player* player, uint32 zone);
    virtual void HandlePlayerLeaveZone(Player* player, uint32 zone);
    virtual void HandlePlayerResurrects(Player* player, uint32 zone);

    void AddCapturePoint(OPvPCapturePoint* cp)
    {
        _capturePoints[cp->m_capturePointSpawnId] = cp;
    }

    OPvPCapturePoint* GetCapturePoint(ObjectGuid::LowType spawnId) const;
    void RegisterZone(uint32 zoneid);
    bool HasPlayer(Player const* player) const;
    void TeamCastSpell(TeamId team, int32 spellId, Player* sameMapPlr = nullptr);

    // Hack to store map
    void SetMapFromZone(uint32 zone);

    // the map of the objectives belonging to this outdoor pvp
    OPvPCapturePointMap _capturePoints;
    std::array<PlayerSet, 2> _players;
    uint32 _typeId{};
    bool _sendUpdate{ true };
    Map* _map{};
    std::unordered_map<ObjectGuid::LowType, GameObject*> _goScriptStore;
    std::unordered_map<ObjectGuid::LowType, Creature*> _creatureScriptStore;
};

#endif /*OUTDOOR_PVP_H_*/

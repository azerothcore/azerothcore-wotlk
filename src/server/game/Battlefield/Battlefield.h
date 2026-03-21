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

#ifndef BATTLEFIELD_H_
#define BATTLEFIELD_H_

#include "Battleground.h"
#include "GameObject.h"
#include "ObjectAccessor.h"
#include "SharedDefines.h"
#include "TaskScheduler.h"
#include "ZoneScript.h"

enum BattlefieldTypes
{
    BATTLEFIELD_WG,                                         // Wintergrasp
    BATTLEFIELD_TB,                                         // Tol Barad (cataclysm)
};

enum BattlefieldIDs
{
    BATTLEFIELD_BATTLEID_WG                      = 1,       // Wintergrasp battle
};

enum BattlefieldObjectiveStates
{
    BF_CAPTUREPOINT_OBJECTIVESTATE_NEUTRAL = 0,
    BF_CAPTUREPOINT_OBJECTIVESTATE_ALLIANCE,
    BF_CAPTUREPOINT_OBJECTIVESTATE_HORDE,
    BF_CAPTUREPOINT_OBJECTIVESTATE_NEUTRAL_ALLIANCE_CHALLENGE,
    BF_CAPTUREPOINT_OBJECTIVESTATE_NEUTRAL_HORDE_CHALLENGE,
    BF_CAPTUREPOINT_OBJECTIVESTATE_ALLIANCE_HORDE_CHALLENGE,
    BF_CAPTUREPOINT_OBJECTIVESTATE_HORDE_ALLIANCE_CHALLENGE,
};

enum BattlefieldSounds
{
    BF_HORDE_WINS                                = 8454,
    BF_ALLIANCE_WINS                             = 8455,
    BF_START                                     = 3439
};

constexpr auto BATTLEFIELD_OBJECTIVE_UPDATE_INTERVAL = 1000;

enum BattlefieldTimerGroups
{
    BATTLEFIELD_TIMER_GROUP_RESURRECT   = 1,
    BATTLEFIELD_TIMER_GROUP_WAR         = 2,
    BATTLEFIELD_TIMER_GROUP_SAVE        = 3,
};

const uint32 BattlefieldFactions[PVP_TEAMS_COUNT] =
{
    1732, // Alliance
    1735  // Horde
};

// some class predefs
class Player;
class GameObject;
class WorldPacket;
class Creature;
class Unit;

class Battlefield;
class BfGraveyard;

using GraveyardVect = std::vector<BfGraveyard*>;
using PlayerTimerMap = std::map<ObjectGuid, time_t>;

class BfCapturePoint
{
public:
    BfCapturePoint(Battlefield* bf);

    virtual ~BfCapturePoint() { }

    virtual void FillInitialWorldStates(WorldPackets::WorldState::InitWorldStates& /*packet*/) { }

    // Send world state update to all players present
    void SendUpdateWorldState(uint32 field, uint32 value);

    // Send kill notify to players in the controlling faction
    void SendObjectiveComplete(uint32 id, ObjectGuid guid);

    // Used when player is activated/inactivated in the area
    virtual bool HandlePlayerEnter(Player* player);
    virtual GuidUnorderedSet::iterator HandlePlayerLeave(Player* player);

    // Checks if player is in range of a capture credit marker
    bool IsInsideObjective(Player* player) const;

    // Returns true if the state of the objective has changed, in this case, the OutdoorPvP must send a world state ui update.
    virtual bool Update(uint32 diff);
    virtual void ChangeTeam(TeamId /*oldTeam*/) {}
    virtual void SendChangePhase();

    // Added team to reset capturepoints on sliders after warTime
    bool SetCapturePointData(GameObject* capturePoint, TeamId team);
    GameObject* GetCapturePointGo();
    GameObject* GetCapturePointGo(WorldObject* obj);

    TeamId GetTeamId() const { return Team; }

protected:
    bool DelCapturePoint();

    // Active players in the area of the objective, 0 - alliance, 1 - horde
    GuidUnorderedSet ActivePlayers[2];

    // Total shift needed to capture the objective
    float MaxValue;
    float MinValue;

    // Maximum speed of capture
    float MaxSpeed;

    // The status of the objective
    float Value;
    TeamId Team;

    // Objective states
    BattlefieldObjectiveStates OldState;
    BattlefieldObjectiveStates State;

    // Neutral value on capture bar
    uint32 NeutralValuePct;

    // Pointer to the Battlefield this objective belongs to
    Battlefield* Bf;

    // Capture point entry
    uint32 CapturePointEntry;

    // Gameobject related to that capture point
    ObjectGuid CapturePoint;
};

class BfGraveyard
{
public:
    BfGraveyard(Battlefield* bf);
    virtual ~BfGraveyard() = default;

    // Method to changing who controls the graveyard
    void GiveControlTo(TeamId team);
    TeamId GetControlTeamId() const { return ControlTeam; }

    // Find the nearest graveyard to a player
    float GetDistance(Player* player);

    // Initialize the graveyard
    void Initialize(TeamId startControl, uint32 graveyardId);

    // Set spirit service for the graveyard
    void SetSpirit(Creature* spirit, TeamId team);

    // Add a player to the graveyard
    void AddPlayer(ObjectGuid playerGuid);

    // Remove a player from the graveyard
    void RemovePlayer(ObjectGuid playerGuid);

    // Resurrect players
    void Resurrect();

    // Move players waiting to that graveyard on the nearest one
    void RelocateDeadPlayers();

    // Check if this graveyard has a spirit guide
    bool HasNpc(ObjectGuid guid)
    {
        if (!SpiritGuide[0] && !SpiritGuide[1])
            return false;

        return (SpiritGuide[0] == guid || SpiritGuide[1] == guid);
    }

    // Check if a player is in this graveyard's resurrect queue
    bool HasPlayer(ObjectGuid guid) const { return ResurrectQueue.find(guid) != ResurrectQueue.end(); }

    // Get the graveyard's ID.
    uint32 GetGraveyardId() const { return GraveyardId; }

protected:
    TeamId ControlTeam;
    uint32 GraveyardId;
    ObjectGuid SpiritGuide[2];
    GuidUnorderedSet ResurrectQueue;
    Battlefield* Bf;
};

class Battlefield : public ZoneScript
{
    friend class BattlefieldMgr;

public:
    /// Constructor
    Battlefield();
    /// Destructor
    ~Battlefield() override;

    /// Vector of capture points belonging to this battlefield
    using BfCapturePointVector = std::vector<BfCapturePoint*>;

    /// Call this to init the Battlefield
    virtual bool SetupBattlefield() { return true; }

    /// Update data of a worldstate to all players present in zone
    void SendUpdateWorldState(uint32 field, uint32 value);

    /**
     * \brief Called every time for update bf data and time
     * - Update timer for start/end battle
     * - Invite player in zone to queue StartGroupingTimer minutes before start
     * - Kick Afk players
     * \param diff : time elapsed since last call (in ms)
     */
    virtual bool Update(uint32 diff);

    /// Invite all players in zone to join the queue, called x minutes before battle start in Update()
    void InvitePlayersInZoneToQueue();
    /// Invite all players in queue to join battle on battle start
    void InvitePlayersInQueueToWar();
    /// Invite all players in zone to join battle on battle start
    void InvitePlayersInZoneToWar();

    /// Called when a Unit is killed in battlefield zone
    virtual void HandleKill(Player* /*killer*/, Unit* /*killed*/) {};

    uint32 GetTypeId() const { return TypeId; }
    uint32 GetZoneId() const { return ZoneId; }

    void TeamApplyBuff(TeamId team, uint32 spellId, uint32 spellId2 = 0);

    /// Return true if battle is started, false if battle is not started
    bool IsWarTime() const { return Active; }

    /// Enable or Disable battlefield
    void ToggleBattlefield(bool enable) { Enabled = enable; }
    /// Return if battlefield is enabled
    bool IsEnabled() const { return Enabled; }

    /**
     * \brief Kick player from battlefield and teleport him to kick-point location
     * \param guid : guid of player who must be kicked
     */
    void KickPlayerFromBattlefield(ObjectGuid guid);

    /// Called when player (player) enters the zone
    void HandlePlayerEnterZone(Player* player, uint32 zone);
    /// Called when player (player) leaves the zone
    void HandlePlayerLeaveZone(Player* player, uint32 zone);

    // All-purpose data storage 64 bit
    uint64 GetData64(uint32 dataId) const override { return Data64[dataId]; }
    void SetData64(uint32 dataId, uint64 value) override { Data64[dataId] = value; }

    // All-purpose data storage 32 bit
    uint32 GetData(uint32 dataId) const override { return Data32[dataId]; }
    void SetData(uint32 dataId, uint32 value) override { Data32[dataId] = value; }
    virtual void UpdateData(uint32 index, int32 pad) { Data32[index] += pad; }

    // Battlefield - generic methods
    TeamId GetDefenderTeam() const { return DefenderTeam; }
    TeamId GetAttackerTeam() const { return TeamId(1 - DefenderTeam); }
    TeamId GetOtherTeam(TeamId team) const { return (team == TEAM_HORDE ? TEAM_ALLIANCE : TEAM_HORDE); }
    void SetDefenderTeam(TeamId team) { DefenderTeam = team; }

    // Group methods
    /**
     * \brief Find a not full battlefield group, if there is no, create one
     * \param teamId : Id of player team for who we search a group (player->GetTeamId())
     */
    Group* GetFreeBfRaid(TeamId teamId);
    /// Return battlefield group where player is.
    Group* GetGroupPlayer(ObjectGuid guid, TeamId teamId);
    /// Force player to join a battlefield group
    bool AddOrSetPlayerToCorrectBfGroup(Player* player);

    // Graveyard methods
    // Find which graveyard the player must be teleported to to be resurrected by spiritguide
    GraveyardStruct const* GetClosestGraveyard(Player* player);

    virtual void AddPlayerToResurrectQueue(ObjectGuid npcGuid, ObjectGuid playerGuid);
    void RemovePlayerFromResurrectQueue(ObjectGuid playerGuid);
    void SetGraveyardNumber(uint32 number) { GraveyardList.resize(number); }
    BfGraveyard* GetGraveyardById(uint32 id) const;

    // Misc methods
    Creature* SpawnCreature(uint32 entry, float x, float y, float z, float o, TeamId teamId);
    Creature* SpawnCreature(uint32 entry, Position pos, TeamId teamId);
    GameObject* SpawnGameObject(uint32 entry, float x, float y, float z, float o);

    Creature* GetCreature(ObjectGuid const& guid);
    GameObject* GetGameObject(ObjectGuid const& guid);

    // Script-methods

    /// Called on start
    virtual void OnBattleStart() {};
    /// Called at the end of battle
    virtual void OnBattleEnd(bool /*endByTimer*/) {};
    /// Called x minutes before battle start when players in zone are invited to join queue
    virtual void OnStartGrouping() {};
    /// Called when a player accepts to join the battle
    virtual void OnPlayerJoinWar(Player* /*player*/) {};
    /// Called when a player leaves the battle
    virtual void OnPlayerLeaveWar(Player* /*player*/) {};
    /// Called when a player leaves the battlefield zone
    virtual void OnPlayerLeaveZone(Player* /*player*/) {};
    /// Called when a player enters the battlefield zone
    virtual void OnPlayerEnterZone(Player* /*player*/) {};

    void SendWarning(uint8 id, WorldObject const* target = nullptr);

    void PlayerAcceptInviteToQueue(Player* player);
    void PlayerAcceptInviteToWar(Player* player);
    uint32 GetBattleId() const { return BattleId; }
    void AskToLeaveQueue(Player* player);
    void PlayerAskToLeave(Player* player);

    /// Send all worldstate data to all players in zone.
    virtual void SendInitWorldStatesToAll() = 0;
    virtual void FillInitialWorldStates(WorldPackets::WorldState::InitWorldStates& /*packet*/) = 0;
    virtual void SendUpdateWorldStates(Player* player = nullptr) = 0;

    /// Return if we can use mount in battlefield
    bool CanFlyIn() const { return !Active; }

    void SendAreaSpiritHealerQueryOpcode(Player* player, ObjectGuid const& guid);

    void StartBattle();
    void EndBattle(bool endByTimer);

    void HideNpc(Creature* creature);
    void ShowNpc(Creature* creature, bool aggressive);

    GraveyardVect const& GetGraveyardVector() const { return GraveyardList; }

    uint32 GetTimer() const { return Timer; }
    void SetTimer(uint32 timer) { Timer = timer; }

    // Returns combined count of players in war + invited (per team) for balance checking
    uint32 GetPlayersInWarCount(TeamId teamId) const { return static_cast<uint32>(PlayersInWar[teamId].size() + InvitedPlayers[teamId].size()); }
    // Returns total count of players in the battlefield zone per team
    uint32 GetPlayersInZoneCount(TeamId teamId) const { return static_cast<uint32>(Players[teamId].size()); }
    // Returns the maximum players allowed per team
    uint32 GetMaxPlayersPerTeam() const { return MaxPlayer; }
    /// Returns true if there is still room for another player on the given team in the active war.
    bool HasWarVacancy(TeamId teamId) const { return GetPlayersInWarCount(teamId) < MaxPlayer; }

    /// Returns the set of players waiting in the pre-battle queue (per team, read-only).
    GuidUnorderedSet const& GetPlayersQueueSet(TeamId teamId) const { return PlayersInQueue[teamId]; }
    /// Returns the map of players invited to join the active war, value is invite expiry
    /// timestamp (per team, read-only).
    PlayerTimerMap const& GetInvitedPlayersMap(TeamId teamId) const { return InvitedPlayers[teamId]; }
    /// Returns the set of players actively fighting in the war (per team, read-only).
    GuidUnorderedSet const& GetPlayersInWarSet(TeamId teamId) const { return PlayersInWar[teamId]; }

    void DoPlaySoundToAll(uint32 soundId);

    void InvitePlayerToQueue(Player* player);
    void InvitePlayerToWar(Player* player);

    void InitStalker(uint32 entry, float x, float y, float z, float o);

protected:
    ObjectGuid StalkerGuid;
    uint32 Timer;                                           // Global timer for event
    bool Enabled;
    bool Active;
    TeamId DefenderTeam;

    // Map of the objectives belonging to this OutdoorPvP
    BfCapturePointVector CapturePoints;

    // Players info maps
    GuidUnorderedSet Players[PVP_TEAMS_COUNT];              // Players in zone
    GuidUnorderedSet PlayersInQueue[PVP_TEAMS_COUNT];       // Players in the queue
    GuidUnorderedSet PlayersInWar[PVP_TEAMS_COUNT];         // Players in WG combat
    PlayerTimerMap InvitedPlayers[PVP_TEAMS_COUNT];
    PlayerTimerMap PlayersWillBeKick[PVP_TEAMS_COUNT];

    // Variables that must exist for each battlefield
    uint32 TypeId;                                          // See enum BattlefieldTypes
    uint32 BattleId;                                        // BattleID (for packet)
    uint32 ZoneId;                                          // ZoneID of Wintergrasp = 4197
    uint32 MapId;                                           // MapId where is Battlefield
    Map* BfMap;
    uint32 MaxPlayer;                                       // Maximum number of players per team that participated to Battlefield
    uint32 MinPlayer;                                       // Minimum number of players per team for Battlefield start
    uint32 MinLevel;                                        // Required level to participate at Battlefield
    uint32 BattleTime;                                      // Length of a battle
    uint32 NoWarBattleTime;                                 // Time between two battles
    uint32 RestartAfterCrash;                               // Delay to restart Wintergrasp if the server crashed during a running battle
    uint32 TimeForAcceptInvite;
    WorldLocation KickPosition;                             // Position where players are teleported if they switch to afk during the battle or if they don't accept invitation

    // Graveyard variables
    GraveyardVect GraveyardList;                            // Vector which contains the different GY of the battle

    uint32 StartGroupingTimer;                              // Timer for invite players in area 15 minutes before start battle
    bool StartGrouping;                                     // bool for knowing if all players in area have been invited

    TaskScheduler _scheduler;

    GuidUnorderedSet Groups[PVP_TEAMS_COUNT];               // Contains different raid groups

    std::vector<uint64> Data64;
    std::vector<uint32> Data32;

    void KickAfkPlayers();

    // use for switch off all worldstate for client
    virtual void SendRemoveWorldStates(Player* /*player*/) {}

    // use for send a packet for all player list
    void BroadcastPacketToZone(WorldPacket const* data) const;
    void BroadcastPacketToQueue(WorldPacket const* data) const;
    void BroadcastPacketToWar(WorldPacket const* data) const;

    // CapturePoint system
    void AddCapturePoint(BfCapturePoint* cp) { CapturePoints.push_back(cp); }

    void RegisterZone(uint32 zoneId);
    bool HasPlayer(Player* player) const;
    void TeamCastSpell(TeamId team, int32 spellId);

    /// Returns true if the player is already tracked as actively in the war or invited to join it.
    bool IsPlayerInWarOrInvited(Player* player) const;

    // Player-iteration helpers: resolve each GUID to a live Player* and call fn(player).
    // Using templates avoids std::function overhead and works naturally with lambdas.
    template<typename Func>
    void ForEachPlayerInZone(Func&& fn) const
    {
        for (uint8 team = 0; team < PVP_TEAMS_COUNT; ++team)
            for (ObjectGuid const& guid : Players[team])
                if (Player* player = ObjectAccessor::FindPlayer(guid))
                    fn(player);
    }

    template<typename Func>
    void ForEachPlayerInQueue(Func&& fn) const
    {
        for (uint8 team = 0; team < PVP_TEAMS_COUNT; ++team)
            for (ObjectGuid const& guid : PlayersInQueue[team])
                if (Player* player = ObjectAccessor::FindPlayer(guid))
                    fn(player);
    }

    template<typename Func>
    void ForEachPlayerInWar(Func&& fn) const
    {
        for (uint8 team = 0; team < PVP_TEAMS_COUNT; ++team)
            for (ObjectGuid const& guid : PlayersInWar[team])
                if (Player* player = ObjectAccessor::FindPlayer(guid))
                    fn(player);
    }

    template<typename Func>
    void ForEachPlayerInWar(TeamId team, Func&& fn) const
    {
        for (ObjectGuid const& guid : PlayersInWar[team])
            if (Player* player = ObjectAccessor::FindPlayer(guid))
                fn(player);
    }
};

#endif

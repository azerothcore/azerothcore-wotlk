/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef SC_SCRIPTMGR_H
#define SC_SCRIPTMGR_H

#include "AchievementMgr.h"
#include "ArenaTeam.h"
#include "AuctionHouseMgr.h"
#include "Battleground.h"
#include "Common.h"
#include "DBCStores.h"
#include "DynamicObject.h"
#include "GameEventMgr.h"
#include "LFGMgr.h"
#include "ObjectMgr.h"
#include "PetDefines.h"
#include "QuestDef.h"
#include "SharedDefines.h"
#include "Weather.h"
#include "World.h"
#include <atomic>

class AuctionHouseObject;
class AuraScript;
class Battleground;
class BattlegroundMap;
class BattlegroundQueue;
class Channel;
class ChatCommand;
class Creature;
class CreatureAI;
class DynamicObject;
class GameObject;
class GameObjectAI;
class Guild;
class GridMap;
class Group;
class InstanceMap;
class InstanceScript;
class Item;
class Map;
class OutdoorPvP;
class Player;
class Quest;
class ScriptMgr;
class Spell;
class SpellScript;
class SpellInfo;
class SpellCastTargets;
class Transport;
class StaticTransport;
class MotionTransport;
class Unit;
class Vehicle;
class WorldPacket;
class WorldSocket;
class WorldObject;

struct AchievementCriteriaData;
struct AuctionEntry;
struct ConditionSourceInfo;
struct Condition;
struct DungeonProgressionRequirements;
struct ItemTemplate;
struct OutdoorPvPData;
struct GroupQueueInfo;
struct TargetInfo;

#define VISIBLE_RANGE       166.0f                          //MAX visible range (size of grid)

// Check out our guide on how to create new hooks in our wiki! https://www.azerothcore.org/wiki/hooks-script
/*
    TODO: Add more script type classes.

    SessionScript
    CollisionScript
    ArenaTeamScript

*/

class ScriptObject
{
    friend class ScriptMgr;

public:
    // Do not override this in scripts; it should be overridden by the various script type classes. It indicates
    // whether or not this script type must be assigned in the database.
    [[nodiscard]] virtual bool IsDatabaseBound() const { return false; }
    [[nodiscard]] virtual bool isAfterLoadScript() const { return IsDatabaseBound(); }
    virtual void checkValidity() { }

    [[nodiscard]] const std::string& GetName() const { return _name; }

protected:
    ScriptObject(const char* name)
        : _name(std::string(name))
    {
    }

    virtual ~ScriptObject() = default;

private:
    const std::string _name;
};

template<class TObject> class UpdatableScript
{
protected:
    UpdatableScript() = default;

public:
    virtual void OnUpdate(TObject* /*obj*/, uint32 /*diff*/) { }
};

class SpellScriptLoader : public ScriptObject
{
protected:
    SpellScriptLoader(const char* name);

public:
    [[nodiscard]] bool IsDatabaseBound() const override { return true; }

    // Should return a fully valid SpellScript pointer.
    [[nodiscard]] virtual SpellScript* GetSpellScript() const { return nullptr; }

    // Should return a fully valid AuraScript pointer.
    [[nodiscard]] virtual AuraScript* GetAuraScript() const { return nullptr; }
};

class ServerScript : public ScriptObject
{
protected:
    ServerScript(const char* name);

public:
    // Called when reactive socket I/O is started (WorldSocketMgr).
    virtual void OnNetworkStart() { }

    // Called when reactive I/O is stopped.
    virtual void OnNetworkStop() { }

    // Called when a remote socket establishes a connection to the server. Do not store the socket object.
    virtual void OnSocketOpen(WorldSocket* /*socket*/) { }

    // Called when a socket is closed. Do not store the socket object, and do not rely on the connection
    // being open; it is not.
    virtual void OnSocketClose(WorldSocket* /*socket*/, bool /*wasNew*/) { }

    // Called when a packet is sent to a client. The packet object is a copy of the original packet, so reading
    // and modifying it is safe.
    virtual void OnPacketSend(WorldSession* /*session*/, WorldPacket& /*packet*/) { }

    // Called when a (valid) packet is received by a client. The packet object is a copy of the original packet, so
    // reading and modifying it is safe. Make sure to check WorldSession pointer before usage, it might be null in case of auth packets
    virtual void OnPacketReceive(WorldSession* /*session*/, WorldPacket& /*packet*/) { }
};

class WorldScript : public ScriptObject
{
protected:
    WorldScript(const char* name);

public:
    // Called when the open/closed state of the world changes.
    virtual void OnOpenStateChange(bool /*open*/) { }

    // Called after the world configuration is (re)loaded.
    virtual void OnAfterConfigLoad(bool /*reload*/) { }

    // Called when loading custom database tables
    virtual void OnLoadCustomDatabaseTable() { }

    // Called before the world configuration is (re)loaded.
    virtual void OnBeforeConfigLoad(bool /*reload*/) { }

    // Called before the message of the day is changed.
    virtual void OnMotdChange(std::string& /*newMotd*/) { }

    // Called when a world shutdown is initiated.
    virtual void OnShutdownInitiate(ShutdownExitCode /*code*/, ShutdownMask /*mask*/) { }

    // Called when a world shutdown is cancelled.
    virtual void OnShutdownCancel() { }

    // Called on every world tick (don't execute too heavy code here).
    virtual void OnUpdate(uint32 /*diff*/) { }

    // Called when the world is started.
    virtual void OnStartup() { }

    // Called when the world is actually shut down.
    virtual void OnShutdown() { }
};

class FormulaScript : public ScriptObject
{
protected:
    FormulaScript(const char* name);

public:
    // Called after calculating honor.
    virtual void OnHonorCalculation(float& /*honor*/, uint8 /*level*/, float /*multiplier*/) { }

    // Called after gray level calculation.
    virtual void OnGrayLevelCalculation(uint8& /*grayLevel*/, uint8 /*playerLevel*/) { }

    // Called after calculating experience color.
    virtual void OnColorCodeCalculation(XPColorChar& /*color*/, uint8 /*playerLevel*/, uint8 /*mobLevel*/) { }

    // Called after calculating zero difference.
    virtual void OnZeroDifferenceCalculation(uint8& /*diff*/, uint8 /*playerLevel*/) { }

    // Called after calculating base experience gain.
    virtual void OnBaseGainCalculation(uint32& /*gain*/, uint8 /*playerLevel*/, uint8 /*mobLevel*/, ContentLevels /*content*/) { }

    // Called after calculating experience gain.
    virtual void OnGainCalculation(uint32& /*gain*/, Player* /*player*/, Unit* /*unit*/) { }

    // Called when calculating the experience rate for group experience.
    virtual void OnGroupRateCalculation(float& /*rate*/, uint32 /*count*/, bool /*isRaid*/) { }

    // Called after calculating arena rating changes
    virtual void OnAfterArenaRatingCalculation(Battleground* const /*bg*/, int32& /*winnerMatchmakerChange*/, int32& /*loserMatchmakerChange*/, int32& /*winnerChange*/, int32& /*loserChange*/) { };

    // Called before modifying a player's personal rating
    virtual void OnBeforeUpdatingPersonalRating(int32& /*mod*/, uint32 /*type*/) { }
};

template<class TMap> class MapScript : public UpdatableScript<TMap>
{
    MapEntry const* _mapEntry;
    uint32 _mapId;

protected:
    MapScript(uint32 mapId)
        : _mapId(mapId)
    {
    }

public:
    void checkMap()
    {
        _mapEntry = sMapStore.LookupEntry(_mapId);

        if (!_mapEntry)
            LOG_ERROR("server", "Invalid MapScript for %u; no such map ID.", _mapId);
    }

    // Gets the MapEntry structure associated with this script. Can return nullptr.
    MapEntry const* GetEntry() { return _mapEntry; }

    // Called when the map is created.
    virtual void OnCreate(TMap* /*map*/) { }

    // Called just before the map is destroyed.
    virtual void OnDestroy(TMap* /*map*/) { }

    // Called when a grid map is loaded.
    virtual void OnLoadGridMap(TMap* /*map*/, GridMap* /*gmap*/, uint32 /*gx*/, uint32 /*gy*/) { }

    // Called when a grid map is unloaded.
    virtual void OnUnloadGridMap(TMap* /*map*/, GridMap* /*gmap*/, uint32 /*gx*/, uint32 /*gy*/)  { }

    // Called when a player enters the map.
    virtual void OnPlayerEnter(TMap* /*map*/, Player* /*player*/) { }

    // Called when a player leaves the map.
    virtual void OnPlayerLeave(TMap* /*map*/, Player* /*player*/) { }

    // Called on every map update tick.
    void OnUpdate(TMap* /*map*/, uint32 /*diff*/) override { }
};

class WorldMapScript : public ScriptObject, public MapScript<Map>
{
protected:
    WorldMapScript(const char* name, uint32 mapId);

public:
    [[nodiscard]] bool isAfterLoadScript() const override { return true; }

    void checkValidity() override
    {
        checkMap();

        if (GetEntry() && !GetEntry()->IsWorldMap())
            LOG_ERROR("server", "WorldMapScript for map %u is invalid.", GetEntry()->MapID);
    }
};

class InstanceMapScript : public ScriptObject, public MapScript<InstanceMap>
{
protected:
    InstanceMapScript(const char* name, uint32 mapId);

public:
    [[nodiscard]] bool IsDatabaseBound() const override { return true; }

    void checkValidity() override
    {
        checkMap();

        if (GetEntry() && !GetEntry()->IsDungeon())
            LOG_ERROR("server", "InstanceMapScript for map %u is invalid.", GetEntry()->MapID);
    }

    // Gets an InstanceScript object for this instance.
    virtual InstanceScript* GetInstanceScript(InstanceMap* /*map*/) const { return nullptr; }
};

class BattlegroundMapScript : public ScriptObject, public MapScript<BattlegroundMap>
{
protected:
    BattlegroundMapScript(const char* name, uint32 mapId);

public:
    [[nodiscard]] bool isAfterLoadScript() const override { return true; }

    void checkValidity() override
    {
        checkMap();

        if (GetEntry() && !GetEntry()->IsBattleground())
            LOG_ERROR("server", "BattlegroundMapScript for map %u is invalid.", GetEntry()->MapID);
    }
};

class ItemScript : public ScriptObject
{
protected:
    ItemScript(const char* name);

public:
    [[nodiscard]] bool IsDatabaseBound() const override { return true; }

    // Called when a player accepts a quest from the item.
    [[nodiscard]] virtual bool OnQuestAccept(Player* /*player*/, Item* /*item*/, Quest const* /*quest*/) { return false; }

    // Called when a player uses the item.
    [[nodiscard]] virtual bool OnUse(Player* /*player*/, Item* /*item*/, SpellCastTargets const& /*targets*/) { return false; }

    // Called when the item is destroyed.
    [[nodiscard]] virtual bool OnRemove(Player* /*player*/, Item* /*item*/) { return false; }

    // Called before casting a combat spell from this item (chance on hit spells of item template, can be used to prevent cast if returning false)
    [[nodiscard]] virtual bool OnCastItemCombatSpell(Player* /*player*/, Unit* /*victim*/, SpellInfo const* /*spellInfo*/, Item* /*item*/) { return true; }

    // Called when the item expires (is destroyed).
    [[nodiscard]] virtual bool OnExpire(Player* /*player*/, ItemTemplate const* /*proto*/) { return false; }

    // Called when a player selects an option in an item gossip window
    virtual void OnGossipSelect(Player* /*player*/, Item* /*item*/, uint32 /*sender*/, uint32 /*action*/) { }

    // Called when a player selects an option in an item gossip window
    virtual void OnGossipSelectCode(Player* /*player*/, Item* /*item*/, uint32 /*sender*/, uint32 /*action*/, const char* /*code*/) { }
};

class UnitScript : public ScriptObject
{
protected:
    UnitScript(const char* name, bool addToScripts = true);

public:
    // Called when a unit deals healing to another unit
    virtual void OnHeal(Unit* /*healer*/, Unit* /*reciever*/, uint32& /*gain*/) { }

    // Called when a unit deals damage to another unit
    virtual void OnDamage(Unit* /*attacker*/, Unit* /*victim*/, uint32& /*damage*/) { }

    // Called when DoT's Tick Damage is being Dealt
    // Attacker can be nullptr if he is despawned while the aura still exists on target
    virtual void ModifyPeriodicDamageAurasTick(Unit* /*target*/, Unit* /*attacker*/, uint32& /*damage*/) { }

    // Called when Melee Damage is being Dealt
    virtual void ModifyMeleeDamage(Unit* /*target*/, Unit* /*attacker*/, uint32& /*damage*/) { }

    // Called when Spell Damage is being Dealt
    virtual void ModifySpellDamageTaken(Unit* /*target*/, Unit* /*attacker*/, int32& /*damage*/) { }

    // Called when Heal is Recieved
    virtual void ModifyHealRecieved(Unit* /*target*/, Unit* /*attacker*/, uint32& /*damage*/) { }

    //Called when Damage is Dealt
    virtual uint32 DealDamage(Unit* /*AttackerUnit*/, Unit* /*pVictim*/, uint32 damage, DamageEffectType /*damagetype*/) { return damage; }

    virtual void OnBeforeRollMeleeOutcomeAgainst(const Unit* /*attacker*/, const Unit* /*victim*/, WeaponAttackType /*attType*/, int32& /*attackerMaxSkillValueForLevel*/, int32& /*victimMaxSkillValueForLevel*/, int32& /*attackerWeaponSkill*/, int32& /*victimDefenseSkill*/, int32& /*crit_chance*/, int32& /*miss_chance*/, int32& /*dodge_chance*/, int32& /*parry_chance*/, int32& /*block_chance*/ ) {   };

    virtual void OnAuraRemove(Unit* /*unit*/, AuraApplication* /*aurApp*/, AuraRemoveMode /*mode*/) { }

    [[nodiscard]] virtual bool IfNormalReaction(Unit const* /*unit*/, Unit const* /*target*/, ReputationRank& /*repRank*/) { return true; }

    [[nodiscard]] virtual bool IsNeedModSpellDamagePercent(Unit const* /*unit*/, AuraEffect* /*auraEff*/, float& /*doneTotalMod*/, SpellInfo const* /*spellProto*/) { return true; }

    [[nodiscard]] virtual bool IsNeedModMeleeDamagePercent(Unit const* /*unit*/, AuraEffect* /*auraEff*/, float& /*doneTotalMod*/, SpellInfo const* /*spellProto*/) { return true; }

    [[nodiscard]] virtual bool IsNeedModHealPercent(Unit const* /*unit*/, AuraEffect* /*auraEff*/, float& /*doneTotalMod*/, SpellInfo const* /*spellProto*/) { return true; }

    [[nodiscard]] virtual bool CanSetPhaseMask(Unit const* /*unit*/, uint32 /*newPhaseMask*/, bool /*update*/) { return true; }

    [[nodiscard]] virtual bool IsCustomBuildValuesUpdate(Unit const* /*unit*/, uint8 /*updateType*/, ByteBuffer& /*fieldBuffer*/, Player const* /*target*/, uint16 /*index*/) { return false; }
};

class MovementHandlerScript : public ScriptObject
{
protected:
    MovementHandlerScript(const char* name);

public:
    //Called whenever a player moves
    virtual void OnPlayerMove(Player* /*player*/, MovementInfo /*movementInfo*/, uint32 /*opcode*/) { }
};

class AllMapScript : public ScriptObject
{
protected:
    AllMapScript(const char* name);

public:
    // Called when a player enters any Map
    virtual void OnPlayerEnterAll(Map* /*map*/, Player* /*player*/) { }

    // Called when a player leave any Map
    virtual void OnPlayerLeaveAll(Map* /*map*/, Player* /*player*/) { }
};

class AllCreatureScript : public ScriptObject
{
protected:
    AllCreatureScript(const char* name);

public:
    // Called from End of Creature Update.
    virtual void OnAllCreatureUpdate(Creature* /*creature*/, uint32 /*diff*/) { }

    // Called from End of Creature SelectLevel.
    virtual void Creature_SelectLevel(const CreatureTemplate* /*cinfo*/, Creature* /*creature*/) { }
};

class CreatureScript : public ScriptObject, public UpdatableScript<Creature>
{
protected:
    CreatureScript(const char* name);

public:
    [[nodiscard]] bool IsDatabaseBound() const override { return true; }

    // Called when a player opens a gossip dialog with the creature.
    [[nodiscard]] virtual bool OnGossipHello(Player* /*player*/, Creature* /*creature*/) { return false; }

    // Called when a player selects a gossip item in the creature's gossip menu.
    [[nodiscard]] virtual bool OnGossipSelect(Player* /*player*/, Creature* /*creature*/, uint32 /*sender*/, uint32 /*action*/) { return false; }

    // Called when a player selects a gossip with a code in the creature's gossip menu.
    [[nodiscard]] virtual bool OnGossipSelectCode(Player* /*player*/, Creature* /*creature*/, uint32 /*sender*/, uint32 /*action*/, const char* /*code*/) { return false; }

    // Called when a player accepts a quest from the creature.
    [[nodiscard]] virtual bool OnQuestAccept(Player* /*player*/, Creature* /*creature*/, Quest const* /*quest*/) { return false; }

    // Called when a player selects a quest in the creature's quest menu.
    [[nodiscard]] virtual bool OnQuestSelect(Player* /*player*/, Creature* /*creature*/, Quest const* /*quest*/) { return false; }

    // Called when a player completes a quest with the creature.
    [[nodiscard]] virtual bool OnQuestComplete(Player* /*player*/, Creature* /*creature*/, Quest const* /*quest*/) { return false; }

    // Called when a player selects a quest reward.
    [[nodiscard]] virtual bool OnQuestReward(Player* /*player*/, Creature* /*creature*/, Quest const* /*quest*/, uint32 /*opt*/) { return false; }

    // Called when the dialog status between a player and the creature is requested.
    virtual uint32 GetDialogStatus(Player* /*player*/, Creature* /*creature*/) { return DIALOG_STATUS_SCRIPTED_NO_STATUS; }

    // Called when a CreatureAI object is needed for the creature.
    virtual CreatureAI* GetAI(Creature* /*creature*/) const { return nullptr; }
};

class GameObjectScript : public ScriptObject, public UpdatableScript<GameObject>
{
protected:
    GameObjectScript(const char* name);

public:
    [[nodiscard]] bool IsDatabaseBound() const override { return true; }

    // Called when a player opens a gossip dialog with the gameobject.
    [[nodiscard]] virtual bool OnGossipHello(Player* /*player*/, GameObject* /*go*/) { return false; }

    // Called when a player selects a gossip item in the gameobject's gossip menu.
    [[nodiscard]] virtual bool OnGossipSelect(Player* /*player*/, GameObject* /*go*/, uint32 /*sender*/, uint32 /*action*/) { return false; }

    // Called when a player selects a gossip with a code in the gameobject's gossip menu.
    [[nodiscard]] virtual bool OnGossipSelectCode(Player* /*player*/, GameObject* /*go*/, uint32 /*sender*/, uint32 /*action*/, const char* /*code*/) { return false; }

    // Called when a player accepts a quest from the gameobject.
    [[nodiscard]] virtual bool OnQuestAccept(Player* /*player*/, GameObject* /*go*/, Quest const* /*quest*/) { return false; }

    // Called when a player selects a quest reward.
    [[nodiscard]] virtual bool OnQuestReward(Player* /*player*/, GameObject* /*go*/, Quest const* /*quest*/, uint32 /*opt*/) { return false; }

    // Called when the dialog status between a player and the gameobject is requested.
    virtual uint32 GetDialogStatus(Player* /*player*/, GameObject* /*go*/) { return DIALOG_STATUS_SCRIPTED_NO_STATUS; }

    // Called when the game object is destroyed (destructible buildings only).
    virtual void OnDestroyed(GameObject* /*go*/, Player* /*player*/) { }

    // Called when the game object is damaged (destructible buildings only).
    virtual void OnDamaged(GameObject* /*go*/, Player* /*player*/) { }

    // Called when the game object loot state is changed.
    virtual void OnLootStateChanged(GameObject* /*go*/, uint32 /*state*/, Unit* /*unit*/) { }

    // Called when the game object state is changed.
    virtual void OnGameObjectStateChanged(GameObject* /*go*/, uint32 /*state*/) { }

    // Called when a GameObjectAI object is needed for the gameobject.
    virtual GameObjectAI* GetAI(GameObject* /*go*/) const { return nullptr; }
};

class AreaTriggerScript : public ScriptObject
{
protected:
    AreaTriggerScript(const char* name);

public:
    [[nodiscard]] bool IsDatabaseBound() const override { return true; }

    // Called when the area trigger is activated by a player.
    [[nodiscard]] virtual bool OnTrigger(Player* /*player*/, AreaTrigger const* /*trigger*/) { return false; }
};

class BattlegroundScript : public ScriptObject
{
protected:
    BattlegroundScript(const char* name);

public:
    [[nodiscard]] bool IsDatabaseBound() const override { return true; }

    // Should return a fully valid Battleground object for the type ID.
    [[nodiscard]] virtual Battleground* GetBattleground() const = 0;
};

class OutdoorPvPScript : public ScriptObject
{
protected:
    OutdoorPvPScript(const char* name);

public:
    [[nodiscard]] bool IsDatabaseBound() const override { return true; }

    // Should return a fully valid OutdoorPvP object for the type ID.
    [[nodiscard]] virtual OutdoorPvP* GetOutdoorPvP() const = 0;
};

class CommandScript : public ScriptObject
{
protected:
    CommandScript(const char* name);

public:
    // Should return a pointer to a valid command table (ChatCommand array) to be used by ChatHandler.
    [[nodiscard]] virtual std::vector<ChatCommand> GetCommands() const = 0;
};

class WeatherScript : public ScriptObject, public UpdatableScript<Weather>
{
protected:
    WeatherScript(const char* name);

public:
    [[nodiscard]] bool IsDatabaseBound() const override { return true; }

    // Called when the weather changes in the zone this script is associated with.
    virtual void OnChange(Weather* /*weather*/, WeatherState /*state*/, float /*grade*/) { }
};

class AuctionHouseScript : public ScriptObject
{
protected:
    AuctionHouseScript(const char* name);

public:
    // Called when an auction is added to an auction house.
    virtual void OnAuctionAdd(AuctionHouseObject* /*ah*/, AuctionEntry* /*entry*/) { }

    // Called when an auction is removed from an auction house.
    virtual void OnAuctionRemove(AuctionHouseObject* /*ah*/, AuctionEntry* /*entry*/) { }

    // Called when an auction was succesfully completed.
    virtual void OnAuctionSuccessful(AuctionHouseObject* /*ah*/, AuctionEntry* /*entry*/) { }

    // Called when an auction expires.
    virtual void OnAuctionExpire(AuctionHouseObject* /*ah*/, AuctionEntry* /*entry*/) { }

    // Called before sending the mail concerning a won auction
    virtual void OnBeforeAuctionHouseMgrSendAuctionWonMail(AuctionHouseMgr* /*auctionHouseMgr*/, AuctionEntry* /*auction*/, Player* /*bidder*/, uint32& /*bidder_accId*/, bool& /*sendNotification*/, bool& /*updateAchievementCriteria*/, bool& /*sendMail*/) { }

    // Called before sending the mail concerning a pending sale
    virtual void OnBeforeAuctionHouseMgrSendAuctionSalePendingMail(AuctionHouseMgr* /*auctionHouseMgr*/, AuctionEntry* /*auction*/, Player* /*owner*/, uint32& /*owner_accId*/, bool& /*sendMail*/) { }

    // Called before sending the mail concerning a successful auction
    virtual void OnBeforeAuctionHouseMgrSendAuctionSuccessfulMail(AuctionHouseMgr* /*auctionHouseMgr*/, AuctionEntry* /*auction*/, Player* /*owner*/, uint32& /*owner_accId*/, uint32& /*profit*/, bool& /*sendNotification*/, bool& /*updateAchievementCriteria*/, bool& /*sendMail*/) { }

    // Called before sending the mail concerning an expired auction
    virtual void OnBeforeAuctionHouseMgrSendAuctionExpiredMail(AuctionHouseMgr* /*auctionHouseMgr*/, AuctionEntry* /*auction*/, Player* /*owner*/, uint32& /*owner_accId*/, bool& /*sendNotification*/, bool& /*sendMail*/) { }

    // Called before sending the mail concerning an outbidded auction
    virtual void OnBeforeAuctionHouseMgrSendAuctionOutbiddedMail(AuctionHouseMgr* /*auctionHouseMgr*/, AuctionEntry* /*auction*/, Player* /*oldBidder*/, uint32& /*oldBidder_accId*/, Player* /*newBidder*/, uint32& /*newPrice*/, bool& /*sendNotification*/, bool& /*sendMail*/) { }

    // Called before sending the mail concerning an cancelled auction
    virtual void OnBeforeAuctionHouseMgrSendAuctionCancelledToBidderMail(AuctionHouseMgr* /*auctionHouseMgr*/, AuctionEntry* /*auction*/, Player* /*bidder*/, uint32& /*bidder_accId*/, bool& /*sendMail*/) { }

    // Called before updating the auctions
    virtual void OnBeforeAuctionHouseMgrUpdate() { }
};

class ConditionScript : public ScriptObject
{
protected:
    ConditionScript(const char* name);

public:
    [[nodiscard]] bool IsDatabaseBound() const override { return true; }

    // Called when a single condition is checked for a player.
    [[nodiscard]] virtual bool OnConditionCheck(Condition* /*condition*/, ConditionSourceInfo& /*sourceInfo*/) { return true; }
};

class VehicleScript : public ScriptObject
{
protected:
    VehicleScript(const char* name);

public:
    // Called after a vehicle is installed.
    virtual void OnInstall(Vehicle* /*veh*/) { }

    // Called after a vehicle is uninstalled.
    virtual void OnUninstall(Vehicle* /*veh*/) { }

    // Called when a vehicle resets.
    virtual void OnReset(Vehicle* /*veh*/) { }

    // Called after an accessory is installed in a vehicle.
    virtual void OnInstallAccessory(Vehicle* /*veh*/, Creature* /*accessory*/) { }

    // Called after a passenger is added to a vehicle.
    virtual void OnAddPassenger(Vehicle* /*veh*/, Unit* /*passenger*/, int8 /*seatId*/) { }

    // Called after a passenger is removed from a vehicle.
    virtual void OnRemovePassenger(Vehicle* /*veh*/, Unit* /*passenger*/) { }
};

class DynamicObjectScript : public ScriptObject, public UpdatableScript<DynamicObject>
{
protected:
    DynamicObjectScript(const char* name);
};

class TransportScript : public ScriptObject, public UpdatableScript<Transport>
{
protected:
    TransportScript(const char* name);

public:
    [[nodiscard]] bool IsDatabaseBound() const override { return true; }

    // Called when a player boards the transport.
    virtual void OnAddPassenger(Transport* /*transport*/, Player* /*player*/) { }

    // Called when a creature boards the transport.
    virtual void OnAddCreaturePassenger(Transport* /*transport*/, Creature* /*creature*/) { }

    // Called when a player exits the transport.
    virtual void OnRemovePassenger(Transport* /*transport*/, Player* /*player*/) { }

    // Called when a transport moves.
    virtual void OnRelocate(Transport* /*transport*/, uint32 /*waypointId*/, uint32 /*mapId*/, float /*x*/, float /*y*/, float /*z*/) { }
};

class AchievementCriteriaScript : public ScriptObject
{
protected:
    AchievementCriteriaScript(const char* name);

public:
    [[nodiscard]] bool IsDatabaseBound() const override { return true; }

    [[nodiscard]] virtual bool OnCheck(Player* /*source*/, Unit* /*target*/, uint32 /*criteria_id*/) { return true; };
};

class PlayerScript : public ScriptObject
{
protected:
    PlayerScript(const char* name);

public:
    virtual void OnPlayerReleasedGhost(Player* /*player*/) { }

    // Called on Send Initial Packets Before Add To Map
    virtual void OnSendInitialPacketsBeforeAddToMap(Player* /*player*/, WorldPacket& /*data*/) {}

    // Called when a player does a desertion action (see BattlegroundDesertionType)
    virtual void OnBattlegroundDesertion(Player* /*player*/, BattlegroundDesertionType const /*desertionType*/) { }

    // Called when a player completes a quest
    virtual void OnPlayerCompleteQuest(Player* /*player*/, Quest const* /*quest_id*/) { }

    // Called when a player kills another player
    virtual void OnPVPKill(Player* /*killer*/, Player* /*killed*/) { }

    // Called when a player kills a creature
    virtual void OnCreatureKill(Player* /*killer*/, Creature* /*killed*/) { }

    // Called when a player's pet kills a creature
    virtual void OnCreatureKilledByPet(Player* /*PetOwner*/, Creature* /*killed*/) { }

    // Called when a player is killed by a creature
    virtual void OnPlayerKilledByCreature(Creature* /*killer*/, Player* /*killed*/) { }

    // Called when a player's level changes (right after the level is applied)
    virtual void OnLevelChanged(Player* /*player*/, uint8 /*oldlevel*/) { }

    // Called when a player's free talent points change (right before the change is applied)
    virtual void OnFreeTalentPointsChanged(Player* /*player*/, uint32 /*points*/) { }

    // Called when a player's talent points are reset (right before the reset is done)
    virtual void OnTalentsReset(Player* /*player*/, bool /*noCost*/) { }

    // Called for player::update
    virtual void OnBeforeUpdate(Player* /*player*/, uint32 /*p_time*/) { }
    virtual void OnUpdate(Player* /*player*/, uint32 /*p_time*/) { }

    // Called when a player's money is modified (before the modification is done)
    virtual void OnMoneyChanged(Player* /*player*/, int32& /*amount*/) { }

    // Called when a player gains XP (before anything is given)
    virtual void OnGiveXP(Player* /*player*/, uint32& /*amount*/, Unit* /*victim*/) { }

    // Called when a player's reputation changes (before it is actually changed)
    virtual void OnReputationChange(Player* /*player*/, uint32 /*factionId*/, int32& /*standing*/, bool /*incremental*/) { }

    // Called when a player's reputation rank changes (before it is actually changed)
    virtual void OnReputationRankChange(Player* /*player*/, uint32 /*factionID*/, ReputationRank /*newRank*/, ReputationRank /*olRank*/, bool /*increased*/) { }

    // Called when a player learned new spell
    virtual void OnLearnSpell(Player* /*player*/, uint32 /*spellID*/) {}

    // Called when a player forgot spell
    virtual void OnForgotSpell(Player* /*player*/, uint32 /*spellID*/) {}

    // Called when a duel is requested
    virtual void OnDuelRequest(Player* /*target*/, Player* /*challenger*/) { }

    // Called when a duel starts (after 3s countdown)
    virtual void OnDuelStart(Player* /*player1*/, Player* /*player2*/) { }

    // Called when a duel ends
    virtual void OnDuelEnd(Player* /*winner*/, Player* /*loser*/, DuelCompleteType /*type*/) { }

    // The following methods are called when a player sends a chat message.
    virtual void OnChat(Player* /*player*/, uint32 /*type*/, uint32 /*lang*/, std::string& /*msg*/) { }

    virtual void OnBeforeSendChatMessage(Player* /*player*/, uint32& /*type*/, uint32& /*lang*/, std::string& /*msg*/) { }

    virtual void OnChat(Player* /*player*/, uint32 /*type*/, uint32 /*lang*/, std::string& /*msg*/, Player* /*receiver*/) { }

    virtual void OnChat(Player* /*player*/, uint32 /*type*/, uint32 /*lang*/, std::string& /*msg*/, Group* /*group*/) { }

    virtual void OnChat(Player* /*player*/, uint32 /*type*/, uint32 /*lang*/, std::string& /*msg*/, Guild* /*guild*/) { }

    virtual void OnChat(Player* /*player*/, uint32 /*type*/, uint32 /*lang*/, std::string& /*msg*/, Channel* /*channel*/) { }

    // Both of the below are called on emote opcodes.
    virtual void OnEmote(Player* /*player*/, uint32 /*emote*/) { }

    virtual void OnTextEmote(Player* /*player*/, uint32 /*textEmote*/, uint32 /*emoteNum*/, ObjectGuid /*guid*/) { }

    // Called in Spell::Cast.
    virtual void OnSpellCast(Player* /*player*/, Spell* /*spell*/, bool /*skipCheck*/) { }

    // Called during data loading
    virtual void OnLoadFromDB(Player* /*player*/) { };

    // Called when a player logs in.
    virtual void OnLogin(Player* /*player*/) { }

    // Called when a player logs out.
    virtual void OnLogout(Player* /*player*/) { }

    // Called when a player is created.
    virtual void OnCreate(Player* /*player*/) { }

    // Called when a player is deleted.
    virtual void OnDelete(ObjectGuid /*guid*/, uint32 /*accountId*/) { }

    // Called when a player delete failed.
    virtual void OnFailedDelete(ObjectGuid /*guid*/, uint32 /*accountId*/) { }

    // Called when a player is about to be saved.
    virtual void OnSave(Player* /*player*/) { }

    // Called when a player is bound to an instance
    virtual void OnBindToInstance(Player* /*player*/, Difficulty /*difficulty*/, uint32 /*mapId*/, bool /*permanent*/) { }

    // Called when a player switches to a new zone
    virtual void OnUpdateZone(Player* /*player*/, uint32 /*newZone*/, uint32 /*newArea*/) { }

    // Called when a player switches to a new area (more accurate than UpdateZone)
    virtual void OnUpdateArea(Player* /*player*/, uint32 /*oldArea*/, uint32 /*newArea*/) { }

    // Called when a player changes to a new map (after moving to new map)
    virtual void OnMapChanged(Player* /*player*/) { }

    // Called before a player is being teleported to new coords
    [[nodiscard]] virtual bool OnBeforeTeleport(Player* /*player*/, uint32 /*mapid*/, float /*x*/, float /*y*/, float /*z*/, float /*orientation*/, uint32 /*options*/, Unit* /*target*/) { return true; }

    // Called when team/faction is set on player
    virtual void OnUpdateFaction(Player* /*player*/) { }

    // Called when a player is added to battleground
    virtual void OnAddToBattleground(Player* /*player*/, Battleground* /*bg*/) { }

    // Called when a player is removed from battleground
    virtual void OnRemoveFromBattleground(Player* /*player*/, Battleground* /*bg*/) { }

    // Called when a player complete an achievement
    virtual void OnAchiComplete(Player* /*player*/, AchievementEntry const* /*achievement*/) { }

    // Called before player complete an achievement, can be used to disable achievements in certain conditions
    virtual bool OnBeforeAchiComplete(Player* /*player*/, AchievementEntry const* /*achievement*/) { return true; }

    // Called when a player complete an achievement criteria
    virtual void OnCriteriaProgress(Player* /*player*/, AchievementCriteriaEntry const* /*criteria*/) { }

    //  Called before player complete an achievement criteria, can be used to disable achievement criteria in certain conditions
    virtual bool OnBeforeCriteriaProgress(Player* /*player*/, AchievementCriteriaEntry const* /*criteria*/) { return true; }

    // Called when an Achievement is saved to DB
    virtual void OnAchiSave(SQLTransaction& /*trans*/, Player* /*player*/, uint16 /*achId*/, CompletedAchievementData /*achiData*/) { }

    // Called when an Criteria is saved to DB
    virtual void OnCriteriaSave(SQLTransaction& /*trans*/, Player* /*player*/, uint16 /*achId*/, CriteriaProgress /*criteriaData*/) { }

    // Called when a player selects an option in a player gossip window
    virtual void OnGossipSelect(Player* /*player*/, uint32 /*menu_id*/, uint32 /*sender*/, uint32 /*action*/) { }

    // Called when a player selects an option in a player gossip window
    virtual void OnGossipSelectCode(Player* /*player*/, uint32 /*menu_id*/, uint32 /*sender*/, uint32 /*action*/, const char* /*code*/) { }

    // On player getting charmed
    virtual void OnBeingCharmed(Player* /*player*/, Unit* /*charmer*/, uint32 /*oldFactionId*/, uint32 /*newFactionId*/) { }

    // To change behaviour of set visible item slot
    virtual void OnAfterSetVisibleItemSlot(Player* /*player*/, uint8 /*slot*/, Item* /*item*/) { }

    // After an item has been moved from inventory
    virtual void OnAfterMoveItemFromInventory(Player* /*player*/, Item* /*it*/, uint8 /*bag*/, uint8 /*slot*/, bool /*update*/) { }

    // After an item has been equipped
    virtual void OnEquip(Player* /*player*/, Item* /*it*/, uint8 /*bag*/, uint8 /*slot*/, bool /*update*/) { }

    // After player enters queue for BG
    virtual void OnPlayerJoinBG(Player* /*player*/) { }

    // After player enters queue for Arena
    virtual void OnPlayerJoinArena(Player* /*player*/) { }

    //Called when trying to get a team ID of a slot > 2 (This is for custom teams created by modules)
    virtual void GetCustomGetArenaTeamId(const Player* /*player*/, uint8 /*slot*/, uint32& /*teamID*/) const { }

    //Called when trying to get players personal rating of an arena slot > 2 (This is for custom teams created by modules)
    virtual void GetCustomArenaPersonalRating(const Player* /*player*/, uint8 /*slot*/, uint32& /*rating*/) const { }

    //Called after the normal slots (0..2) for arena have been evaluated so that custom arena teams could modify it if nececasry
    virtual void OnGetMaxPersonalArenaRatingRequirement(const Player* /*player*/, uint32 /*minSlot*/, uint32& /*maxArenaRating*/) const {}

    //After looting item
    virtual void OnLootItem(Player* /*player*/, Item* /*item*/, uint32 /*count*/, ObjectGuid /*lootguid*/) { }

    //After creating item (eg profession item creation)
    virtual void OnCreateItem(Player* /*player*/, Item* /*item*/, uint32 /*count*/) { }

    // After receiving item as a quest reward
    virtual void OnQuestRewardItem(Player* /*player*/, Item* /*item*/, uint32 /*count*/) { }

    // After completed a quest
    [[nodiscard]] virtual bool OnBeforeQuestComplete(Player* /*player*/, uint32 /*quest_id*/) { return true; }

    // Before durability repair action, you can even modify the discount value
    virtual void OnBeforeDurabilityRepair(Player* /*player*/, ObjectGuid /*npcGUID*/, ObjectGuid /*itemGUID*/, float&/*discountMod*/, uint8 /*guildBank*/) { }

    //Before buying something from any vendor
    virtual void OnBeforeBuyItemFromVendor(Player* /*player*/, ObjectGuid /*vendorguid*/, uint32 /*vendorslot*/, uint32& /*item*/, uint8 /*count*/, uint8 /*bag*/, uint8 /*slot*/) { };

    //Before buying something from any vendor
    virtual void OnBeforeStoreOrEquipNewItem(Player* /*player*/, uint32 /*vendorslot*/, uint32& /*item*/, uint8 /*count*/, uint8 /*bag*/, uint8 /*slot*/, ItemTemplate const* /*pProto*/, Creature* /*pVendor*/, VendorItem const* /*crItem*/, bool /*bStore*/) { };

    //After buying something from any vendor
    virtual void OnAfterStoreOrEquipNewItem(Player* /*player*/, uint32 /*vendorslot*/, Item* /*item*/, uint8 /*count*/, uint8 /*bag*/, uint8 /*slot*/, ItemTemplate const* /*pProto*/, Creature* /*pVendor*/, VendorItem const* /*crItem*/, bool /*bStore*/) { };

    virtual void OnAfterUpdateMaxPower(Player* /*player*/, Powers& /*power*/, float& /*value*/) { }

    virtual void OnAfterUpdateMaxHealth(Player* /*player*/, float& /*value*/) { }

    virtual void OnBeforeUpdateAttackPowerAndDamage(Player* /*player*/, float& /*level*/, float& /*val2*/, bool /*ranged*/) { }
    virtual void OnAfterUpdateAttackPowerAndDamage(Player* /*player*/, float& /*level*/, float& /*base_attPower*/, float& /*attPowerMod*/, float& /*attPowerMultiplier*/, bool /*ranged*/) { }

    virtual void OnBeforeInitTalentForLevel(Player* /*player*/, uint8& /*level*/, uint32& /*talentPointsForLevel*/) { }

    virtual void OnFirstLogin(Player* /*player*/) { }

    [[nodiscard]] virtual bool CanJoinInBattlegroundQueue(Player* /*player*/, ObjectGuid /*BattlemasterGuid*/, BattlegroundTypeId /*BGTypeID*/, uint8 /*joinAsGroup*/, GroupJoinBattlegroundResult& /*err*/) { return true; }
    virtual bool ShouldBeRewardedWithMoneyInsteadOfExp(Player* /*player*/) { return false; }

    // Called before the player's temporary summoned creature has initialized it's stats
    virtual void OnBeforeTempSummonInitStats(Player* /*player*/, TempSummon* /*tempSummon*/, uint32& /*duration*/) { }

    // Called before the player's guardian / pet has initialized it's stats for the player's level
    virtual void OnBeforeGuardianInitStatsForLevel(Player* /*player*/, Guardian* /*guardian*/, CreatureTemplate const* /*cinfo*/, PetType& /*petType*/) { }

    // Called after the player's guardian / pet has initialized it's stats for the player's level
    virtual void OnAfterGuardianInitStatsForLevel(Player* /*player*/, Guardian* /*guardian*/) { }

    // Called before loading a player's pet from the DB
    virtual void OnBeforeLoadPetFromDB(Player* /*player*/, uint32& /*petentry*/, uint32& /*petnumber*/, bool& /*current*/, bool& /*forceLoadFromDB*/) { }

    [[nodiscard]] virtual bool CanJoinInArenaQueue(Player* /*player*/, ObjectGuid /*BattlemasterGuid*/, uint8 /*arenaslot*/, BattlegroundTypeId /*BGTypeID*/, uint8 /*joinAsGroup*/, uint8 /*IsRated*/, GroupJoinBattlegroundResult& /*err*/) { return true; }

    [[nodiscard]] virtual bool CanBattleFieldPort(Player* /*player*/, uint8 /*arenaType*/, BattlegroundTypeId /*BGTypeID*/, uint8 /*action*/) { return true; }

    [[nodiscard]] virtual bool CanGroupInvite(Player* /*player*/, std::string& /*membername*/) { return true; }

    [[nodiscard]] virtual bool CanGroupAccept(Player* /*player*/, Group* /*group*/) { return true; }

    [[nodiscard]] virtual bool CanSellItem(Player* /*player*/, Item* /*item*/, Creature* /*creature*/) { return true; }

    [[nodiscard]] virtual bool CanSendMail(Player* /*player*/, ObjectGuid /*receiverGuid*/, ObjectGuid /*mailbox*/, std::string& /*subject*/, std::string& /*body*/, uint32 /*money*/, uint32 /*COD*/, Item* /*item*/) { return true; }

    virtual void PetitionBuy(Player* /*player*/, Creature* /*creature*/, uint32& /*charterid*/, uint32& /*cost*/, uint32& /*type*/) { }

    virtual void PetitionShowList(Player* /*player*/, Creature* /*creature*/, uint32& /*CharterEntry*/, uint32& /*CharterDispayID*/, uint32& /*CharterCost*/) { }

    virtual void OnRewardKillRewarder(Player* /*player*/, bool /*isDungeon*/, float& /*rate*/) { }

    [[nodiscard]] virtual bool CanGiveMailRewardAtGiveLevel(Player* /*player*/, uint8 /*level*/) { return true; }

    virtual void OnDeleteFromDB(SQLTransaction& /*trans*/, uint32 /*guid*/) { }

    [[nodiscard]] virtual bool CanRepopAtGraveyard(Player* /*player*/) { return true; }

    virtual void OnGetMaxSkillValue(Player* /*player*/, uint32 /*skill*/, int32& /*result*/, bool /*IsPure*/) { }

    [[nodiscard]] virtual bool CanAreaExploreAndOutdoor(Player* /*player*/) { return true; }

    virtual void OnVictimRewardBefore(Player* /*player*/, Player* /*victim*/, uint32& /*killer_title*/, uint32& /*victim_title*/) { }

    virtual void OnVictimRewardAfter(Player* /*player*/, Player* /*victim*/, uint32& /*killer_title*/, uint32& /*victim_rank*/, float& /*honor_f*/) { }

    virtual void OnCustomScalingStatValueBefore(Player* /*player*/, ItemTemplate const* /*proto*/, uint8 /*slot*/, bool /*apply*/, uint32& /*CustomScalingStatValue*/) { }

    virtual void OnCustomScalingStatValue(Player* /*player*/, ItemTemplate const* /*proto*/, uint32& /*statType*/, int32& /*val*/, uint8 /*itemProtoStatNumber*/, uint32 /*ScalingStatValue*/, ScalingStatValuesEntry const* /*ssv*/) { }

    [[nodiscard]] virtual bool CanArmorDamageModifier(Player* /*player*/) { return true; }

    virtual void OnGetFeralApBonus(Player* /*player*/, int32& /*feral_bonus*/, int32 /*dpsMod*/, ItemTemplate const* /*proto*/, ScalingStatValuesEntry const* /*ssv*/) { }

    [[nodiscard]] virtual bool CanApplyWeaponDependentAuraDamageMod(Player* /*player*/, Item* /*item*/, WeaponAttackType /*attackType*/, AuraEffect const* /*aura*/, bool /*apply*/) { return true; }

    [[nodiscard]] virtual bool CanApplyEquipSpell(Player* /*player*/, SpellInfo const* /*spellInfo*/, Item* /*item*/, bool /*apply*/, bool /*form_change*/) { return true; }

    [[nodiscard]] virtual bool CanApplyEquipSpellsItemSet(Player* /*player*/, ItemSetEffect* /*eff*/) { return true; }

    [[nodiscard]] virtual bool CanCastItemCombatSpell(Player* /*player*/, Unit* /*target*/, WeaponAttackType /*attType*/, uint32 /*procVictim*/, uint32 /*procEx*/, Item* /*item*/, ItemTemplate const* /*proto*/) { return true; }

    [[nodiscard]] virtual bool CanCastItemUseSpell(Player* /*player*/, Item* /*item*/, SpellCastTargets const& /*targets*/, uint8 /*cast_count*/, uint32 /*glyphIndex*/) { return true; }

    virtual void OnApplyAmmoBonuses(Player* /*player*/, ItemTemplate const* /*proto*/, float& /*currentAmmoDPS*/) { }

    [[nodiscard]] virtual bool CanEquipItem(Player* /*player*/, uint8 /*slot*/, uint16& /*dest*/, Item* /*pItem*/, bool /*swap*/, bool /*not_loading*/) { return true; }

    [[nodiscard]] virtual bool CanUnequipItem(Player* /*player*/, uint16 /*pos*/, bool /*swap*/) { return true; }

    [[nodiscard]] virtual bool CanUseItem(Player* /*player*/, ItemTemplate const* /*proto*/, InventoryResult& /*result*/) { return true; }

    [[nodiscard]] virtual bool CanSaveEquipNewItem(Player* /*player*/, Item* /*item*/, uint16 /*pos*/, bool /*update*/) { return true; }

    [[nodiscard]] virtual bool CanApplyEnchantment(Player* /*player*/, Item* /*item*/, EnchantmentSlot /*slot*/, bool /*apply*/, bool /*apply_dur*/, bool /*ignore_condition*/) { return true; }

    virtual void OnGetQuestRate(Player* /*player*/, float& /*result*/) { }

    [[nodiscard]] virtual bool PassedQuestKilledMonsterCredit(Player* /*player*/, Quest const* /*qinfo*/, uint32 /*entry*/, uint32 /*real_entry*/, ObjectGuid /*guid*/) { return true; }

    [[nodiscard]] virtual bool CheckItemInSlotAtLoadInventory(Player* /*player*/, Item* /*item*/, uint8 /*slot*/, uint8& /*err*/, uint16& /*dest*/) { return true; }

    [[nodiscard]] virtual bool NotAvoidSatisfy(Player* /*player*/, DungeonProgressionRequirements const* /*ar*/, uint32 /*target_map*/, bool /*report*/) { return true; }

    [[nodiscard]] virtual bool NotVisibleGloballyFor(Player* /*player*/, Player const* /*u*/) { return true; }

    virtual void OnGetArenaPersonalRating(Player* /*player*/, uint8 /*slot*/, uint32& /*result*/) { }

    virtual void OnGetArenaTeamId(Player* /*player*/, uint8 /*slot*/, uint32& /*result*/) { }

    virtual void OnIsFFAPvP(Player* /*player*/, bool& /*result*/) { }

    virtual void OnIsPvP(Player* /*player*/, bool& /*result*/) { }

    virtual void OnGetMaxSkillValueForLevel(Player* /*player*/, uint16& /*result*/) { }

    [[nodiscard]] virtual bool NotSetArenaTeamInfoField(Player* /*player*/, uint8 /*slot*/, ArenaTeamInfoType /*type*/, uint32 /*value*/) { return true; }

    [[nodiscard]] virtual bool CanJoinLfg(Player* /*player*/, uint8 /*roles*/, lfg::LfgDungeonSet& /*dungeons*/, const std::string& /*comment*/) { return true; }

    [[nodiscard]] virtual bool CanEnterMap(Player* /*player*/, MapEntry const* /*entry*/, InstanceTemplate const* /*instance*/, MapDifficulty const* /*mapDiff*/, bool /*loginCheck*/) { return true; }

    [[nodiscard]] virtual bool CanInitTrade(Player* /*player*/, Player* /*target*/) { return true; }

    virtual void OnSetServerSideVisibility(Player* /*player*/, ServerSideVisibilityType& /*type*/, AccountTypes& /*sec*/) { }

    virtual void OnSetServerSideVisibilityDetect(Player* /*player*/, ServerSideVisibilityType& /*type*/, AccountTypes& /*sec*/) { }

    // Passive Anticheat System
    virtual void AnticheatSetSkipOnePacketForASH(Player* /*player*/, bool /*apply*/) { }
    virtual void AnticheatSetCanFlybyServer(Player* /*player*/, bool /*apply*/) { }
    virtual void AnticheatSetUnderACKmount(Player* /*player*/) { }
    virtual void AnticheatSetRootACKUpd(Player* /*player*/) { }
    virtual void AnticheatSetJumpingbyOpcode(Player* /*player*/, bool /*jump*/) { }
    virtual void AnticheatUpdateMovementInfo(Player* /*player*/, MovementInfo const& /*movementInfo*/) { }
    [[nodiscard]] virtual bool AnticheatHandleDoubleJump(Player* /*player*/, Unit* /*mover*/) { return true; }
    [[nodiscard]] virtual bool AnticheatCheckMovementInfo(Player* /*player*/, MovementInfo const& /*movementInfo*/, Unit* /*mover*/, bool /*jump*/) { return true; }
};

class AccountScript : public ScriptObject
{
protected:
    AccountScript(const char* name);

public:
    // Called when an account logged in successfully
    virtual void OnAccountLogin(uint32 /*accountId*/) { }

    // Called when an ip logged in successfully
    virtual void OnLastIpUpdate(uint32 /*accountId*/, std::string /*ip*/) { }

    // Called when an account login failed
    virtual void OnFailedAccountLogin(uint32 /*accountId*/) { }

    // Called when Email is successfully changed for Account
    virtual void OnEmailChange(uint32 /*accountId*/) { }

    // Called when Email failed to change for Account
    virtual void OnFailedEmailChange(uint32 /*accountId*/) { }

    // Called when Password is successfully changed for Account
    virtual void OnPasswordChange(uint32 /*accountId*/) { }

    // Called when Password failed to change for Account
    virtual void OnFailedPasswordChange(uint32 /*accountId*/) { }
};

class GuildScript : public ScriptObject
{
protected:
    GuildScript(const char* name);

public:
    [[nodiscard]] bool IsDatabaseBound() const override { return false; }

    // Called when a member is added to the guild.
    virtual void OnAddMember(Guild* /*guild*/, Player* /*player*/, uint8& /*plRank*/) { }

    // Called when a member is removed from the guild.
    virtual void OnRemoveMember(Guild* /*guild*/, Player* /*player*/, bool /*isDisbanding*/, bool /*isKicked*/) { }

    // Called when the guild MOTD (message of the day) changes.
    virtual void OnMOTDChanged(Guild* /*guild*/, const std::string& /*newMotd*/) { }

    // Called when the guild info is altered.
    virtual void OnInfoChanged(Guild* /*guild*/, const std::string& /*newInfo*/) { }

    // Called when a guild is created.
    virtual void OnCreate(Guild* /*guild*/, Player* /*leader*/, const std::string& /*name*/) { }

    // Called when a guild is disbanded.
    virtual void OnDisband(Guild* /*guild*/) { }

    // Called when a guild member withdraws money from a guild bank.
    virtual void OnMemberWitdrawMoney(Guild* /*guild*/, Player* /*player*/, uint32& /*amount*/, bool /*isRepair*/) { }

    // Called when a guild member deposits money in a guild bank.
    virtual void OnMemberDepositMoney(Guild* /*guild*/, Player* /*player*/, uint32& /*amount*/) { }

    // Called when a guild member moves an item in a guild bank.
    virtual void OnItemMove(Guild* /*guild*/, Player* /*player*/, Item* /*pItem*/, bool /*isSrcBank*/, uint8 /*srcContainer*/, uint8 /*srcSlotId*/,
                            bool /*isDestBank*/, uint8 /*destContainer*/, uint8 /*destSlotId*/) { }

    virtual void OnEvent(Guild* /*guild*/, uint8 /*eventType*/, ObjectGuid::LowType /*playerGuid1*/, ObjectGuid::LowType /*playerGuid2*/, uint8 /*newRank*/) { }

    virtual void OnBankEvent(Guild* /*guild*/, uint8 /*eventType*/, uint8 /*tabId*/, ObjectGuid::LowType /*playerGuid*/, uint32 /*itemOrMoney*/, uint16 /*itemStackCount*/, uint8 /*destTabId*/) { }

    [[nodiscard]] virtual bool CanGuildSendBankList(Guild const* /*guild*/, WorldSession* /*session*/, uint8 /*tabId*/, bool /*sendAllSlots*/) { return true; }
};

class GroupScript : public ScriptObject
{
protected:
    GroupScript(const char* name);

public:
    [[nodiscard]] bool IsDatabaseBound() const override { return false; }

    // Called when a member is added to a group.
    virtual void OnAddMember(Group* /*group*/, ObjectGuid /*guid*/) { }

    // Called when a member is invited to join a group.
    virtual void OnInviteMember(Group* /*group*/, ObjectGuid /*guid*/) { }

    // Called when a member is removed from a group.
    virtual void OnRemoveMember(Group* /*group*/, ObjectGuid /*guid*/, RemoveMethod /*method*/, ObjectGuid /*kicker*/, const char* /*reason*/) { }

    // Called when the leader of a group is changed.
    virtual void OnChangeLeader(Group* /*group*/, ObjectGuid /*newLeaderGuid*/, ObjectGuid /*oldLeaderGuid*/) { }

    // Called when a group is disbanded.
    virtual void OnDisband(Group* /*group*/) { }

    [[nodiscard]] virtual bool CanGroupJoinBattlegroundQueue(Group const* /*group*/, Player* /*member*/, Battleground const* /*bgTemplate*/, uint32 /*MinPlayerCount*/, bool /*isRated*/, uint32 /*arenaSlot*/) { return true; }

    virtual void OnCreate(Group* /*group*/, Player* /*leader*/) { }
};

// following hooks can be used anywhere and are not db bounded
class GlobalScript : public ScriptObject
{
protected:
    GlobalScript(const char* name);

public:
    // items
    virtual void OnItemDelFromDB(SQLTransaction& /*trans*/, ObjectGuid::LowType /*itemGuid*/) { }
    virtual void OnMirrorImageDisplayItem(const Item* /*item*/, uint32& /*display*/) { }

    // loot
    virtual void OnAfterRefCount(Player const* /*player*/, LootStoreItem* /*LootStoreItem*/, Loot& /*loot*/, bool /*canRate*/, uint16 /*lootMode*/, uint32& /*maxcount*/, LootStore const& /*store*/) { }
    virtual void OnBeforeDropAddItem(Player const* /*player*/, Loot& /*loot*/, bool /*canRate*/, uint16 /*lootMode*/, LootStoreItem* /*LootStoreItem*/, LootStore const& /*store*/) { }
    virtual bool OnItemRoll(Player const* /*player*/, LootStoreItem const* /*LootStoreItem*/, float& /*chance*/, Loot& /*loot*/, LootStore const& /*store*/) { return true; };
    virtual bool OnBeforeLootEqualChanced(Player const* /*player*/, LootStoreItemList /*EqualChanced*/, Loot& /*loot*/, LootStore const& /*store*/) { return true; }
    virtual void OnInitializeLockedDungeons(Player* /*player*/, uint8& /*level*/, uint32& /*lockData*/, lfg::LFGDungeonData const* /*dungeon*/) { }
    virtual void OnAfterInitializeLockedDungeons(Player* /*player*/) { }

    // On Before arena points distribution
    virtual void OnBeforeUpdateArenaPoints(ArenaTeam* /*at*/, std::map<ObjectGuid, uint32>& /*ap*/) { }

    // Called when a dungeon encounter is updated.
    virtual void OnAfterUpdateEncounterState(Map* /*map*/, EncounterCreditType /*type*/,  uint32 /*creditEntry*/, Unit* /*source*/, Difficulty /*difficulty_fixed*/, DungeonEncounterList const* /*encounters*/, uint32 /*dungeonCompleted*/, bool /*updated*/) { }

    // Called before the phase for a WorldObject is set
    virtual void OnBeforeWorldObjectSetPhaseMask(WorldObject const* /*worldObject*/, uint32& /*oldPhaseMask*/, uint32& /*newPhaseMask*/, bool& /*useCombinedPhases*/, bool& /*update*/) { }
};

class BGScript : public ScriptObject
{
protected:
    BGScript(const char* name);

public:
    [[nodiscard]] bool IsDatabaseBound() const override { return false; }

    // Start Battlegroud
    virtual void OnBattlegroundStart(Battleground* /*bg*/) { }

    // End Battleground
    virtual void OnBattlegroundEndReward(Battleground* /*bg*/, Player* /*player*/, TeamId /*winnerTeamId*/) { }

    // Update Battlegroud
    virtual void OnBattlegroundUpdate(Battleground* /*bg*/, uint32 /*diff*/) { }

    // Add Player in Battlegroud
    virtual void OnBattlegroundAddPlayer(Battleground* /*bg*/, Player* /*player*/) { }

    // Before added player in Battlegroud
    virtual void OnBattlegroundBeforeAddPlayer(Battleground* /*bg*/, Player* /*player*/) { }

    // Remove player at leave BG
    virtual void OnBattlegroundRemovePlayerAtLeave(Battleground* /*bg*/, Player* /*player*/) { }

    virtual void OnQueueUpdate(BattlegroundQueue* /*queue*/, BattlegroundBracketId /*bracket_id*/, bool /*isRated*/, uint32 /*arenaRatedTeamId*/) { }

    virtual void OnAddGroup(BattlegroundQueue* /*queue*/, GroupQueueInfo* /*ginfo*/, uint32& /*index*/, Player* /*leader*/, Group* /*grp*/, PvPDifficultyEntry const* /*bracketEntry*/, bool /*isPremade*/) { }

    [[nodiscard]] virtual bool CanFillPlayersToBG(BattlegroundQueue* /*queue*/, Battleground* /*bg*/, const int32 /*aliFree*/, const int32 /*hordeFree*/, BattlegroundBracketId /*bracket_id*/) { return true; }

    [[nodiscard]] virtual bool CanFillPlayersToBGWithSpecific(BattlegroundQueue* /*queue*/, Battleground* /*bg*/, const int32 /*aliFree*/, const int32 /*hordeFree*/,
            BattlegroundBracketId /*thisBracketId*/, BattlegroundQueue* /*specificQueue*/, BattlegroundBracketId /*specificBracketId*/) { return true; }

    virtual void OnCheckNormalMatch(BattlegroundQueue* /*queue*/, uint32& /*Coef*/, Battleground* /*bgTemplate*/, BattlegroundBracketId /*bracket_id*/, uint32& /*minPlayers*/, uint32& /*maxPlayers*/) { }

    [[nodiscard]] virtual bool CanSendMessageBGQueue(BattlegroundQueue* /*queue*/, Player* /*leader*/, Battleground* /*bg*/, PvPDifficultyEntry const* /*bracketEntry*/) { return true; }

    [[nodiscard]] bool CanSendJoinMessageArenaQueue(BattlegroundQueue* /*queue*/, Player* /*leader*/, GroupQueueInfo* /*ginfo*/, PvPDifficultyEntry const* /*bracketEntry*/, bool /*isRated*/) { return true; }

    [[nodiscard]] bool CanExitJoinMessageArenaQueue(BattlegroundQueue* /*queue*/, GroupQueueInfo* /*ginfo*/) { return true; }
};

class ArenaTeamScript : public ScriptObject
{
protected:
    ArenaTeamScript(const char* name);

public:
    [[nodiscard]] bool IsDatabaseBound() const override { return false; };

    virtual void OnGetSlotByType(const uint32 /*type*/, uint8& /*slot*/) {}
    virtual void OnGetArenaPoints(ArenaTeam* /*team*/, float& /*points*/) {}
    virtual void OnTypeIDToQueueID(const BattlegroundTypeId /*bgTypeId*/, const uint8 /*arenaType*/, uint32& /*queueTypeID*/) {}
    virtual void OnQueueIdToArenaType(const BattlegroundQueueTypeId /*bgQueueTypeId*/, uint8& /*ArenaType*/) {}
    virtual void OnSetArenaMaxPlayersPerTeam(const uint8 /*arenaType*/, uint32& /*maxPlayerPerTeam*/) {}
};

class SpellSC : public ScriptObject
{
protected:
    SpellSC(const char* name);

public:
    [[nodiscard]] bool IsDatabaseBound() const override { return false; }

    // Calculate max duration in applying aura
    virtual void OnCalcMaxDuration(Aura const* /*aura*/, int32& /*maxDuration*/) { }

    [[nodiscard]] virtual bool CanModAuraEffectDamageDone(AuraEffect const* /*auraEff*/, Unit* /*target*/, AuraApplication const* /*aurApp*/, uint8 /*mode*/, bool /*apply*/) { return true; }

    [[nodiscard]] virtual bool CanModAuraEffectModDamagePercentDone(AuraEffect const* /*auraEff*/, Unit* /*target*/, AuraApplication const* /*aurApp*/, uint8 /*mode*/, bool /*apply*/) { return true; }

    virtual void OnSpellCheckCast(Spell* /*spell*/, bool /*strict*/, SpellCastResult& /*res*/) { }

    [[nodiscard]] virtual bool CanPrepare(Spell* /*spell*/, SpellCastTargets const* /*targets*/, AuraEffect const* /*triggeredByAura*/) { return true; }

    [[nodiscard]] virtual bool CanScalingEverything(Spell* /*spell*/) { return false; }

    [[nodiscard]] virtual bool CanSelectSpecTalent(Spell* /*spell*/) { return true; }

    virtual void OnScaleAuraUnitAdd(Spell* /*spell*/, Unit* /*target*/, uint32 /*effectMask*/, bool /*checkIfValid*/, bool /*implicit*/, uint8 /*auraScaleMask*/, TargetInfo& /*targetInfo*/) { }

    virtual void OnRemoveAuraScaleTargets(Spell* /*spell*/, TargetInfo& /*targetInfo*/, uint8 /*auraScaleMask*/, bool& /*needErase*/) { }

    virtual void OnBeforeAuraRankForLevel(SpellInfo const* /*spellInfo*/, SpellInfo const* /*latestSpellInfo*/, uint8 /*level*/) { }
};

// this class can be used to be extended by Modules
// creating their own custom hooks inside module itself
class ModuleScript : public ScriptObject
{
protected:
    ModuleScript(const char* name);
};

class GameEventScript : public ScriptObject
{
protected:
    GameEventScript(const char* name);

public:
    // Runs on start event
    virtual void OnStart(uint16 /*EventID*/) { }

    // Runs on stop event
    virtual void OnStop(uint16 /*EventID*/) { }
};

class MailScript : public ScriptObject
{
protected:
    MailScript(const char* name);

public:
    // Called before mail is sent
    virtual void OnBeforeMailDraftSendMailTo(MailDraft* /*mailDraft*/, MailReceiver const& /*receiver*/, MailSender const& /*sender*/, MailCheckMask& /*checked*/, uint32& /*deliver_delay*/, uint32& /*custom_expiration*/, bool& /*deleteMailItemsFromDB*/, bool& /*sendMail*/) { }
};

class AchievementScript : public ScriptObject
{
protected:

    AchievementScript(const char* name);

public:

    bool IsDatabaseBound() const { return false; }

    // After complete global acvievement
    virtual void SetRealmCompleted(AchievementEntry const* /*achievement*/) { }

    [[nodiscard]] virtual bool IsCompletedCriteria(AchievementMgr* /*mgr*/, AchievementCriteriaEntry const* /*achievementCriteria*/, AchievementEntry const* /*achievement*/, CriteriaProgress const* /*progress*/) { return true; }

    [[nodiscard]] virtual bool IsRealmCompleted(AchievementGlobalMgr const* /*globalmgr*/, AchievementEntry const* /*achievement*/, std::chrono::system_clock::time_point /*completionTime*/) { return true; }

    virtual void OnBeforeCheckCriteria(AchievementMgr* /*mgr*/, AchievementCriteriaEntryList const* /*achievementCriteriaList*/) { }

    [[nodiscard]] virtual bool CanCheckCriteria(AchievementMgr* /*mgr*/, AchievementCriteriaEntry const* /*achievementCriteria*/) { return true; }
};

class PetScript : public ScriptObject
{
protected:

    PetScript(const char* name);

public:

    bool IsDatabaseBound() const { return false; }

    virtual void OnInitStatsForLevel(Guardian* /*guardian*/, uint8 /*petlevel*/) { }

    virtual void OnCalculateMaxTalentPointsForLevel(Pet* /*pet*/, uint8 /*level*/, uint8& /*points*/) { }

    [[nodiscard]] virtual bool CanUnlearnSpellSet(Pet* /*pet*/, uint32 /*level*/, uint32 /*spell*/) { return true; }

    [[nodiscard]] virtual bool CanUnlearnSpellDefault(Pet* /*pet*/, SpellInfo const* /*spellEntry*/) { return true; }

    [[nodiscard]] virtual bool CanResetTalents(Pet* /*pet*/) { return true; }
};

class ArenaScript : public ScriptObject
{
protected:

    ArenaScript(const char* name);

public:

    bool IsDatabaseBound() const { return false; }

    [[nodiscard]] virtual bool CanAddMember(ArenaTeam* /*team*/, ObjectGuid /*PlayerGuid*/) { return true; }

    virtual void OnGetPoints(ArenaTeam* /*team*/, uint32 /*memberRating*/, float& /*points*/) { }

    [[nodiscard]] virtual bool CanSaveToDB(ArenaTeam* /*team*/) { return true; }
};

class MiscScript : public ScriptObject
{
protected:

    MiscScript(const char* name);

public:

    bool IsDatabaseBound() const { return false; }

    virtual void OnConstructObject(Object* /*origin*/) { }

    virtual void OnDestructObject(Object* /*origin*/) { }

    virtual void OnConstructPlayer(Player* /*origin*/) { }

    virtual void OnDestructPlayer(Player* /*origin*/) { }

    virtual void OnConstructGroup(Group* /*origin*/) { }

    virtual void OnDestructGroup(Group* /*origin*/) { }

    virtual void OnConstructInstanceSave(InstanceSave* /*origin*/) { }

    virtual void OnDestructInstanceSave(InstanceSave* /*origin*/) { }

    virtual void OnItemCreate(Item* /*item*/, ItemTemplate const* /*itemProto*/, Player const* /*owner*/) { }

    [[nodiscard]] virtual bool CanApplySoulboundFlag(Item* /*item*/, ItemTemplate const* /*proto*/) { return true; }

    [[nodiscard]] virtual bool CanItemApplyEquipSpell(Player* /*player*/, Item* /*item*/) { return true; }

    [[nodiscard]] virtual bool CanSendAuctionHello(WorldSession const* /*session*/, ObjectGuid /*guid*/, Creature* /*creature*/) { return true; }

    virtual void ValidateSpellAtCastSpell(Player* /*player*/, uint32& /*oldSpellId*/, uint32& /*spellId*/, uint8& /*castCount*/, uint8& /*castFlags*/) { }

    virtual void ValidateSpellAtCastSpellResult(Player* /*player*/, Unit* /*mover*/, Spell* /*spell*/, uint32 /*oldSpellId*/, uint32 /*spellId*/) { }

    virtual void OnAfterLootTemplateProcess(Loot* /*loot*/, LootTemplate const* /*tab*/, LootStore const& /*store*/, Player* /*lootOwner*/, bool /*personal*/, bool /*noEmptyError*/, uint16 /*lootMode*/) { }

    virtual void OnPlayerSetPhase(const AuraEffect* /*auraEff*/, AuraApplication const* /*aurApp*/, uint8 /*mode*/, bool /*apply*/, uint32& /*newPhase*/) { }

    virtual void OnInstanceSave(InstanceSave* /*instanceSave*/) { }
};

class CommandSC : public ScriptObject
{
protected:

    CommandSC(const char* name);

public:

    bool IsDatabaseBound() const { return false; }

    virtual void OnHandleDevCommand(Player* /*player*/, std::string& /*argstr*/) { }
};

// Manages registration, loading, and execution of scripts.
class ScriptMgr
{
    friend class ScriptObject;

private:
    ScriptMgr();
    virtual ~ScriptMgr();

public: /* Initialization */
    static ScriptMgr* instance();
    void Initialize();
    void LoadDatabase();
    void FillSpellSummary();
    void CheckIfScriptsInDatabaseExist();

    const char* ScriptsVersion() const { return "Integrated Trinity Scripts"; }

    void IncrementScriptCount() { ++_scriptCount; }
    uint32 GetScriptCount() const { return _scriptCount; }

public: /* Unloading */
    void Unload();

public: /* SpellScriptLoader */
    void CreateSpellScripts(uint32 spellId, std::list<SpellScript*>& scriptVector);
    void CreateAuraScripts(uint32 spellId, std::list<AuraScript*>& scriptVector);
    void CreateSpellScriptLoaders(uint32 spellId, std::vector<std::pair<SpellScriptLoader*, std::multimap<uint32, uint32>::iterator> >& scriptVector);

public: /* ServerScript */
    void OnNetworkStart();
    void OnNetworkStop();
    void OnSocketOpen(WorldSocket* socket);
    void OnSocketClose(WorldSocket* socket, bool wasNew);
    void OnPacketReceive(WorldSession* session, WorldPacket const& packet);
    void OnPacketSend(WorldSession* session, WorldPacket const& packet);

public: /* WorldScript */
    void OnLoadCustomDatabaseTable();
    void OnOpenStateChange(bool open);
    void OnBeforeConfigLoad(bool reload);
    void OnAfterConfigLoad(bool reload);
    void OnMotdChange(std::string& newMotd);
    void OnShutdownInitiate(ShutdownExitCode code, ShutdownMask mask);
    void OnShutdownCancel();
    void OnWorldUpdate(uint32 diff);
    void OnStartup();
    void OnShutdown();

public: /* FormulaScript */
    void OnHonorCalculation(float& honor, uint8 level, float multiplier);
    void OnGrayLevelCalculation(uint8& grayLevel, uint8 playerLevel);
    void OnColorCodeCalculation(XPColorChar& color, uint8 playerLevel, uint8 mobLevel);
    void OnZeroDifferenceCalculation(uint8& diff, uint8 playerLevel);
    void OnBaseGainCalculation(uint32& gain, uint8 playerLevel, uint8 mobLevel, ContentLevels content);
    void OnGainCalculation(uint32& gain, Player* player, Unit* unit);
    void OnGroupRateCalculation(float& rate, uint32 count, bool isRaid);
    void OnAfterArenaRatingCalculation(Battleground* const bg, int32& winnerMatchmakerChange, int32& loserMatchmakerChange, int32& winnerChange, int32& loserChange);
    void OnBeforeUpdatingPersonalRating(int32& mod, uint32 type);

public: /* MapScript */
    void OnCreateMap(Map* map);
    void OnDestroyMap(Map* map);
    void OnLoadGridMap(Map* map, GridMap* gmap, uint32 gx, uint32 gy);
    void OnUnloadGridMap(Map* map, GridMap* gmap, uint32 gx, uint32 gy);
    void OnPlayerEnterMap(Map* map, Player* player);
    void OnPlayerLeaveMap(Map* map, Player* player);
    void OnMapUpdate(Map* map, uint32 diff);

public: /* InstanceMapScript */
    InstanceScript* CreateInstanceScript(InstanceMap* map);

public: /* ItemScript */
    bool OnQuestAccept(Player* player, Item* item, Quest const* quest);
    bool OnItemUse(Player* player, Item* item, SpellCastTargets const& targets);
    bool OnItemExpire(Player* player, ItemTemplate const* proto);
    bool OnItemRemove(Player* player, Item* item);
    bool OnCastItemCombatSpell(Player* player, Unit* victim, SpellInfo const* spellInfo, Item* item);
    void OnGossipSelect(Player* player, Item* item, uint32 sender, uint32 action);
    void OnGossipSelectCode(Player* player, Item* item, uint32 sender, uint32 action, const char* code);

public: /* CreatureScript */
    bool OnGossipHello(Player* player, Creature* creature);
    bool OnGossipSelect(Player* player, Creature* creature, uint32 sender, uint32 action);
    bool OnGossipSelectCode(Player* player, Creature* creature, uint32 sender, uint32 action, const char* code);
    bool OnQuestAccept(Player* player, Creature* creature, Quest const* quest);
    bool OnQuestSelect(Player* player, Creature* creature, Quest const* quest);
    bool OnQuestComplete(Player* player, Creature* creature, Quest const* quest);
    bool OnQuestReward(Player* player, Creature* creature, Quest const* quest, uint32 opt);
    uint32 GetDialogStatus(Player* player, Creature* creature);
    CreatureAI* GetCreatureAI(Creature* creature);
    void OnCreatureUpdate(Creature* creature, uint32 diff);

public: /* GameObjectScript */
    bool OnGossipHello(Player* player, GameObject* go);
    bool OnGossipSelect(Player* player, GameObject* go, uint32 sender, uint32 action);
    bool OnGossipSelectCode(Player* player, GameObject* go, uint32 sender, uint32 action, const char* code);
    bool OnQuestAccept(Player* player, GameObject* go, Quest const* quest);
    bool OnQuestReward(Player* player, GameObject* go, Quest const* quest, uint32 opt);
    uint32 GetDialogStatus(Player* player, GameObject* go);
    void OnGameObjectDestroyed(GameObject* go, Player* player);
    void OnGameObjectDamaged(GameObject* go, Player* player);
    void OnGameObjectLootStateChanged(GameObject* go, uint32 state, Unit* unit);
    void OnGameObjectStateChanged(GameObject* go, uint32 state);
    void OnGameObjectUpdate(GameObject* go, uint32 diff);
    GameObjectAI* GetGameObjectAI(GameObject* go);

public: /* AreaTriggerScript */
    bool OnAreaTrigger(Player* player, AreaTrigger const* trigger);

public: /* BattlegroundScript */
    Battleground* CreateBattleground(BattlegroundTypeId typeId);

public: /* OutdoorPvPScript */
    OutdoorPvP* CreateOutdoorPvP(OutdoorPvPData const* data);

public: /* CommandScript */
    std::vector<ChatCommand> GetChatCommands();

public: /* WeatherScript */
    void OnWeatherChange(Weather* weather, WeatherState state, float grade);
    void OnWeatherUpdate(Weather* weather, uint32 diff);

public: /* AuctionHouseScript */
    void OnAuctionAdd(AuctionHouseObject* ah, AuctionEntry* entry);
    void OnAuctionRemove(AuctionHouseObject* ah, AuctionEntry* entry);
    void OnAuctionSuccessful(AuctionHouseObject* ah, AuctionEntry* entry);
    void OnAuctionExpire(AuctionHouseObject* ah, AuctionEntry* entry);
    void OnBeforeAuctionHouseMgrSendAuctionWonMail(AuctionHouseMgr* auctionHouseMgr, AuctionEntry* auction, Player* bidder, uint32& bidder_accId, bool& sendNotification, bool& updateAchievementCriteria, bool& sendMail);
    void OnBeforeAuctionHouseMgrSendAuctionSalePendingMail(AuctionHouseMgr* auctionHouseMgr, AuctionEntry* auction, Player* owner, uint32& owner_accId, bool& sendMail);
    void OnBeforeAuctionHouseMgrSendAuctionSuccessfulMail(AuctionHouseMgr* auctionHouseMgr, AuctionEntry* auction, Player* owner, uint32& owner_accId, uint32& profit, bool& sendNotification, bool& updateAchievementCriteria, bool& sendMail);
    void OnBeforeAuctionHouseMgrSendAuctionExpiredMail(AuctionHouseMgr* auctionHouseMgr, AuctionEntry* auction, Player* owner, uint32& owner_accId, bool& sendNotification, bool& sendMail);
    void OnBeforeAuctionHouseMgrSendAuctionOutbiddedMail(AuctionHouseMgr* auctionHouseMgr, AuctionEntry* auction, Player* oldBidder, uint32& oldBidder_accId, Player* newBidder, uint32& newPrice, bool& sendNotification, bool& sendMail);
    void OnBeforeAuctionHouseMgrSendAuctionCancelledToBidderMail(AuctionHouseMgr* auctionHouseMgr, AuctionEntry* auction, Player* bidder, uint32& bidder_accId, bool& sendMail);
    void OnBeforeAuctionHouseMgrUpdate();

public: /* ConditionScript */
    bool OnConditionCheck(Condition* condition, ConditionSourceInfo& sourceInfo);

public: /* VehicleScript */
    void OnInstall(Vehicle* veh);
    void OnUninstall(Vehicle* veh);
    void OnReset(Vehicle* veh);
    void OnInstallAccessory(Vehicle* veh, Creature* accessory);
    void OnAddPassenger(Vehicle* veh, Unit* passenger, int8 seatId);
    void OnRemovePassenger(Vehicle* veh, Unit* passenger);

public: /* DynamicObjectScript */
    void OnDynamicObjectUpdate(DynamicObject* dynobj, uint32 diff);

public: /* TransportScript */
    void OnAddPassenger(Transport* transport, Player* player);
    void OnAddCreaturePassenger(Transport* transport, Creature* creature);
    void OnRemovePassenger(Transport* transport, Player* player);
    void OnTransportUpdate(Transport* transport, uint32 diff);
    void OnRelocate(Transport* transport, uint32 waypointId, uint32 mapId, float x, float y, float z);

public: /* AchievementCriteriaScript */
    bool OnCriteriaCheck(uint32 scriptId, Player* source, Unit* target, uint32 criteria_id);

public: /* PlayerScript */
    void OnBeforePlayerUpdate(Player* player, uint32 p_time);
    void OnPlayerUpdate(Player* player, uint32 p_time);
    void OnSendInitialPacketsBeforeAddToMap(Player* player, WorldPacket& data);
    void OnPlayerReleasedGhost(Player* player);
    void OnPVPKill(Player* killer, Player* killed);
    void OnCreatureKill(Player* killer, Creature* killed);
    void OnCreatureKilledByPet(Player* petOwner, Creature* killed);
    void OnPlayerKilledByCreature(Creature* killer, Player* killed);
    void OnPlayerLevelChanged(Player* player, uint8 oldLevel);
    void OnPlayerFreeTalentPointsChanged(Player* player, uint32 newPoints);
    void OnPlayerTalentsReset(Player* player, bool noCost);
    void OnPlayerMoneyChanged(Player* player, int32& amount);
    void OnGivePlayerXP(Player* player, uint32& amount, Unit* victim);
    void OnPlayerReputationChange(Player* player, uint32 factionID, int32& standing, bool incremental);
    void OnPlayerReputationRankChange(Player* player, uint32 factionID, ReputationRank newRank, ReputationRank oldRank, bool increased);
    void OnPlayerLearnSpell(Player* player, uint32 spellID);
    void OnPlayerForgotSpell(Player* player, uint32 spellID);
    void OnPlayerDuelRequest(Player* target, Player* challenger);
    void OnPlayerDuelStart(Player* player1, Player* player2);
    void OnPlayerDuelEnd(Player* winner, Player* loser, DuelCompleteType type);
    void OnPlayerChat(Player* player, uint32 type, uint32 lang, std::string& msg);
    void OnBeforeSendChatMessage(Player* player, uint32& type, uint32& lang, std::string& msg);
    void OnPlayerChat(Player* player, uint32 type, uint32 lang, std::string& msg, Player* receiver);
    void OnPlayerChat(Player* player, uint32 type, uint32 lang, std::string& msg, Group* group);
    void OnPlayerChat(Player* player, uint32 type, uint32 lang, std::string& msg, Guild* guild);
    void OnPlayerChat(Player* player, uint32 type, uint32 lang, std::string& msg, Channel* channel);
    void OnPlayerEmote(Player* player, uint32 emote);
    void OnPlayerTextEmote(Player* player, uint32 textEmote, uint32 emoteNum, ObjectGuid guid);
    void OnPlayerSpellCast(Player* player, Spell* spell, bool skipCheck);
    void OnPlayerLogin(Player* player);
    void OnPlayerLoadFromDB(Player* player);
    void OnPlayerLogout(Player* player);
    void OnPlayerCreate(Player* player);
    void OnPlayerSave(Player* player);
    void OnPlayerDelete(ObjectGuid guid, uint32 accountId);
    void OnPlayerFailedDelete(ObjectGuid guid, uint32 accountId);
    void OnPlayerBindToInstance(Player* player, Difficulty difficulty, uint32 mapid, bool permanent);
    void OnPlayerUpdateZone(Player* player, uint32 newZone, uint32 newArea);
    void OnPlayerUpdateArea(Player* player, uint32 oldArea, uint32 newArea);
    bool OnBeforePlayerTeleport(Player* player, uint32 mapid, float x, float y, float z, float orientation, uint32 options, Unit* target);
    void OnPlayerUpdateFaction(Player* player);
    void OnPlayerAddToBattleground(Player* player, Battleground* bg);
    void OnPlayerRemoveFromBattleground(Player* player, Battleground* bg);
    void OnAchievementComplete(Player* player, AchievementEntry const* achievement);
    bool OnBeforeAchievementComplete(Player* player, AchievementEntry const* achievement);
    void OnCriteriaProgress(Player* player, AchievementCriteriaEntry const* criteria);
    bool OnBeforeCriteriaProgress(Player* player, AchievementCriteriaEntry const* criteria);
    void OnAchievementSave(SQLTransaction& trans, Player* player, uint16 achiId, CompletedAchievementData achiData);
    void OnCriteriaSave(SQLTransaction& trans, Player* player, uint16 critId, CriteriaProgress criteriaData);
    void OnGossipSelect(Player* player, uint32 menu_id, uint32 sender, uint32 action);
    void OnGossipSelectCode(Player* player, uint32 menu_id, uint32 sender, uint32 action, const char* code);
    void OnPlayerBeingCharmed(Player* player, Unit* charmer, uint32 oldFactionId, uint32 newFactionId);
    void OnAfterPlayerSetVisibleItemSlot(Player* player, uint8 slot, Item* item);
    void OnAfterPlayerMoveItemFromInventory(Player* player, Item* it, uint8 bag, uint8 slot, bool update);
    void OnEquip(Player* player, Item* it, uint8 bag, uint8 slot, bool update);
    void OnPlayerJoinBG(Player* player);
    void OnPlayerJoinArena(Player* player);
    void GetCustomGetArenaTeamId(const Player* player, uint8 slot, uint32& teamID) const;
    void GetCustomArenaPersonalRating(const Player* player, uint8 slot, uint32& rating) const;
    void OnGetMaxPersonalArenaRatingRequirement(const Player* player, uint32 minSlot, uint32& maxArenaRating) const;
    void OnLootItem(Player* player, Item* item, uint32 count, ObjectGuid lootguid);
    void OnCreateItem(Player* player, Item* item, uint32 count);
    void OnQuestRewardItem(Player* player, Item* item, uint32 count);
    bool OnBeforePlayerQuestComplete(Player* player, uint32 quest_id);
    void OnBeforePlayerDurabilityRepair(Player* player, ObjectGuid npcGUID, ObjectGuid itemGUID, float& discountMod, uint8 guildBank);
    void OnBeforeBuyItemFromVendor(Player* player, ObjectGuid vendorguid, uint32 vendorslot, uint32& item, uint8 count, uint8 bag, uint8 slot);
    void OnBeforeStoreOrEquipNewItem(Player* player, uint32 vendorslot, uint32& item, uint8 count, uint8 bag, uint8 slot, ItemTemplate const* pProto, Creature* pVendor, VendorItem const* crItem, bool bStore);
    void OnAfterStoreOrEquipNewItem(Player* player, uint32 vendorslot, Item* item, uint8 count, uint8 bag, uint8 slot, ItemTemplate const* pProto, Creature* pVendor, VendorItem const* crItem, bool bStore);
    void OnAfterUpdateMaxPower(Player* player, Powers& power, float& value);
    void OnAfterUpdateMaxHealth(Player* player, float& value);
    void OnBeforeUpdateAttackPowerAndDamage(Player* player, float& level, float& val2, bool ranged);
    void OnAfterUpdateAttackPowerAndDamage(Player* player, float& level, float& base_attPower, float& attPowerMod, float& attPowerMultiplier, bool ranged);
    void OnBeforeInitTalentForLevel(Player* player, uint8& level, uint32& talentPointsForLevel);
    void OnFirstLogin(Player* player);
    void OnPlayerCompleteQuest(Player* player, Quest const* quest);
    void OnBattlegroundDesertion(Player* player, BattlegroundDesertionType const desertionType);
    bool CanJoinInBattlegroundQueue(Player* player, ObjectGuid BattlemasterGuid, BattlegroundTypeId BGTypeID, uint8 joinAsGroup, GroupJoinBattlegroundResult& err);
    bool ShouldBeRewardedWithMoneyInsteadOfExp(Player* player);
    void OnBeforeTempSummonInitStats(Player* player, TempSummon* tempSummon, uint32& duration);
    void OnBeforeGuardianInitStatsForLevel(Player* player, Guardian* guardian, CreatureTemplate const* cinfo, PetType& petType);
    void OnAfterGuardianInitStatsForLevel(Player* player, Guardian* guardian);
    void OnBeforeLoadPetFromDB(Player* player, uint32& petentry, uint32& petnumber, bool& current, bool& forceLoadFromDB);
    bool CanJoinInArenaQueue(Player* player, ObjectGuid BattlemasterGuid, uint8 arenaslot, BattlegroundTypeId BGTypeID, uint8 joinAsGroup, uint8 IsRated, GroupJoinBattlegroundResult& err);
    bool CanBattleFieldPort(Player* player, uint8 arenaType, BattlegroundTypeId BGTypeID, uint8 action);
    bool CanGroupInvite(Player* player, std::string& membername);
    bool CanGroupAccept(Player* player, Group* group);
    bool CanSellItem(Player* player, Item* item, Creature* creature);
    bool CanSendMail(Player* player, ObjectGuid receiverGuid, ObjectGuid mailbox, std::string& subject, std::string& body, uint32 money, uint32 COD, Item* item);
    void PetitionBuy(Player* player, Creature* creature, uint32& charterid, uint32& cost, uint32& type);
    void PetitionShowList(Player* player, Creature* creature, uint32& CharterEntry, uint32& CharterDispayID, uint32& CharterCost);
    void OnRewardKillRewarder(Player* player, bool isDungeon, float& rate);
    bool CanGiveMailRewardAtGiveLevel(Player* player, uint8 level);
    void OnDeleteFromDB(SQLTransaction& trans, uint32 guid);
    bool CanRepopAtGraveyard(Player* player);
    void OnGetMaxSkillValue(Player* player, uint32 skill, int32& result, bool IsPure);
    bool CanAreaExploreAndOutdoor(Player* player);
    void OnVictimRewardBefore(Player* player, Player* victim, uint32& killer_title, uint32& victim_title);
    void OnVictimRewardAfter(Player* player, Player* victim, uint32& killer_title, uint32& victim_rank, float& honor_f);
    void OnCustomScalingStatValueBefore(Player* player, ItemTemplate const* proto, uint8 slot, bool apply, uint32& CustomScalingStatValue);
    void OnCustomScalingStatValue(Player* player, ItemTemplate const* proto, uint32& statType, int32& val, uint8 itemProtoStatNumber, uint32 ScalingStatValue, ScalingStatValuesEntry const* ssv);
    bool CanArmorDamageModifier(Player* player);
    void OnGetFeralApBonus(Player* player, int32& feral_bonus, int32 dpsMod, ItemTemplate const* proto, ScalingStatValuesEntry const* ssv);
    bool CanApplyWeaponDependentAuraDamageMod(Player* player, Item* item, WeaponAttackType attackType, AuraEffect const* aura, bool apply);
    bool CanApplyEquipSpell(Player* player, SpellInfo const* spellInfo, Item* item, bool apply, bool form_change);
    bool CanApplyEquipSpellsItemSet(Player* player, ItemSetEffect* eff);
    bool CanCastItemCombatSpell(Player* player, Unit* target, WeaponAttackType attType, uint32 procVictim, uint32 procEx, Item* item, ItemTemplate const* proto);
    bool CanCastItemUseSpell(Player* player, Item* item, SpellCastTargets const& targets, uint8 cast_count, uint32 glyphIndex);
    void OnApplyAmmoBonuses(Player* player, ItemTemplate const* proto, float& currentAmmoDPS);
    bool CanEquipItem(Player* player, uint8 slot, uint16& dest, Item* pItem, bool swap, bool not_loading);
    bool CanUnequipItem(Player* player, uint16 pos, bool swap);
    bool CanUseItem(Player* player, ItemTemplate const* proto, InventoryResult& result);
    bool CanSaveEquipNewItem(Player* player, Item* item, uint16 pos, bool update);
    bool CanApplyEnchantment(Player* player, Item* item, EnchantmentSlot slot, bool apply, bool apply_dur, bool ignore_condition);
    void OnGetQuestRate(Player* player, float& result);
    bool PassedQuestKilledMonsterCredit(Player* player, Quest const* qinfo, uint32 entry, uint32 real_entry, ObjectGuid guid);
    bool CheckItemInSlotAtLoadInventory(Player* player, Item* item, uint8 slot, uint8& err, uint16& dest);
    bool NotAvoidSatisfy(Player* player, DungeonProgressionRequirements const* ar, uint32 target_map, bool report);
    bool NotVisibleGloballyFor(Player* player, Player const* u);
    void OnGetArenaPersonalRating(Player* player, uint8 slot, uint32& result);
    void OnGetArenaTeamId(Player* player, uint8 slot, uint32& result);
    void OnIsFFAPvP(Player* player, bool& result);
    void OnIsPvP(Player* player, bool& result);
    void OnGetMaxSkillValueForLevel(Player* player, uint16& result);
    bool NotSetArenaTeamInfoField(Player* player, uint8 slot, ArenaTeamInfoType type, uint32 value);
    bool CanJoinLfg(Player* player, uint8 roles, lfg::LfgDungeonSet& dungeons, const std::string& comment);
    bool CanEnterMap(Player* player, MapEntry const* entry, InstanceTemplate const* instance, MapDifficulty const* mapDiff, bool loginCheck);
    bool CanInitTrade(Player* player, Player* target);
    void OnSetServerSideVisibility(Player* player, ServerSideVisibilityType& type, AccountTypes& sec);
    void OnSetServerSideVisibilityDetect(Player* player, ServerSideVisibilityType& type, AccountTypes& sec);
    void AnticheatSetSkipOnePacketForASH(Player* player, bool apply);
    void AnticheatSetCanFlybyServer(Player* player, bool apply);
    void AnticheatSetUnderACKmount(Player* player);
    void AnticheatSetRootACKUpd(Player* player);
    void AnticheatUpdateMovementInfo(Player* player, MovementInfo const& movementInfo);
    void AnticheatSetJumpingbyOpcode(Player* player, bool jump);
    bool AnticheatHandleDoubleJump(Player* player, Unit* mover);
    bool AnticheatCheckMovementInfo(Player* player, MovementInfo const& movementInfo, Unit* mover, bool jump);

public: /* AccountScript */
    void OnAccountLogin(uint32 accountId);
    void OnLastIpUpdate(uint32 accountId, std::string ip);
    void OnFailedAccountLogin(uint32 accountId);
    void OnEmailChange(uint32 accountId);
    void OnFailedEmailChange(uint32 accountId);
    void OnPasswordChange(uint32 accountId);
    void OnFailedPasswordChange(uint32 accountId);

public: /* GuildScript */
    void OnGuildAddMember(Guild* guild, Player* player, uint8& plRank);
    void OnGuildRemoveMember(Guild* guild, Player* player, bool isDisbanding, bool isKicked);
    void OnGuildMOTDChanged(Guild* guild, const std::string& newMotd);
    void OnGuildInfoChanged(Guild* guild, const std::string& newInfo);
    void OnGuildCreate(Guild* guild, Player* leader, const std::string& name);
    void OnGuildDisband(Guild* guild);
    void OnGuildMemberWitdrawMoney(Guild* guild, Player* player, uint32& amount, bool isRepair);
    void OnGuildMemberDepositMoney(Guild* guild, Player* player, uint32& amount);
    void OnGuildItemMove(Guild* guild, Player* player, Item* pItem, bool isSrcBank, uint8 srcContainer, uint8 srcSlotId,
                         bool isDestBank, uint8 destContainer, uint8 destSlotId);
    void OnGuildEvent(Guild* guild, uint8 eventType, ObjectGuid::LowType playerGuid1, ObjectGuid::LowType playerGuid2, uint8 newRank);
    void OnGuildBankEvent(Guild* guild, uint8 eventType, uint8 tabId, ObjectGuid::LowType playerGuid, uint32 itemOrMoney, uint16 itemStackCount, uint8 destTabId);
    bool CanGuildSendBankList(Guild const* guild, WorldSession* session, uint8 tabId, bool sendAllSlots);

public: /* GroupScript */
    void OnGroupAddMember(Group* group, ObjectGuid guid);
    void OnGroupInviteMember(Group* group, ObjectGuid guid);
    void OnGroupRemoveMember(Group* group, ObjectGuid guid, RemoveMethod method, ObjectGuid kicker, const char* reason);
    void OnGroupChangeLeader(Group* group, ObjectGuid newLeaderGuid, ObjectGuid oldLeaderGuid);
    void OnGroupDisband(Group* group);
    bool CanGroupJoinBattlegroundQueue(Group const* group, Player* member, Battleground const* bgTemplate, uint32 MinPlayerCount, bool isRated, uint32 arenaSlot);
    void OnCreate(Group* group, Player* leader);

public: /* GlobalScript */
    void OnGlobalItemDelFromDB(SQLTransaction& trans, ObjectGuid::LowType itemGuid);
    void OnGlobalMirrorImageDisplayItem(const Item* item, uint32& display);
    void OnBeforeUpdateArenaPoints(ArenaTeam* at, std::map<ObjectGuid, uint32>& ap);
    void OnAfterRefCount(Player const* player, Loot& loot, bool canRate, uint16 lootMode, LootStoreItem* LootStoreItem, uint32& maxcount, LootStore const& store);
    void OnBeforeDropAddItem(Player const* player, Loot& loot, bool canRate, uint16 lootMode, LootStoreItem* LootStoreItem, LootStore const& store);
    bool OnItemRoll(Player const* player, LootStoreItem const* LootStoreItem, float& chance, Loot& loot, LootStore const& store);
    bool OnBeforeLootEqualChanced(Player const* player, LootStoreItemList EqualChanced, Loot& loot, LootStore const& store);
    void OnInitializeLockedDungeons(Player* player, uint8& level, uint32& lockData, lfg::LFGDungeonData const* dungeon);
    void OnAfterInitializeLockedDungeons(Player* player);
    void OnAfterUpdateEncounterState(Map* map, EncounterCreditType type, uint32 creditEntry, Unit* source, Difficulty difficulty_fixed, DungeonEncounterList const* encounters, uint32 dungeonCompleted, bool updated);
    void OnBeforeWorldObjectSetPhaseMask(WorldObject const* worldObject, uint32& oldPhaseMask, uint32& newPhaseMask, bool& useCombinedPhases, bool& update);

public: /* Scheduled scripts */
    uint32 IncreaseScheduledScriptsCount() { return ++_scheduledScripts; }
    uint32 DecreaseScheduledScriptCount() { return --_scheduledScripts; }
    uint32 DecreaseScheduledScriptCount(size_t count) { return _scheduledScripts -= count; }
    bool IsScriptScheduled() const { return _scheduledScripts > 0; }

public: /* UnitScript */
    void OnHeal(Unit* healer, Unit* reciever, uint32& gain);
    void OnDamage(Unit* attacker, Unit* victim, uint32& damage);
    void ModifyPeriodicDamageAurasTick(Unit* target, Unit* attacker, uint32& damage);
    void ModifyMeleeDamage(Unit* target, Unit* attacker, uint32& damage);
    void ModifySpellDamageTaken(Unit* target, Unit* attacker, int32& damage);
    void ModifyHealRecieved(Unit* target, Unit* attacker, uint32& addHealth);
    uint32 DealDamage(Unit* AttackerUnit, Unit* pVictim, uint32 damage, DamageEffectType damagetype);
    void OnBeforeRollMeleeOutcomeAgainst(const Unit* attacker, const Unit* victim, WeaponAttackType attType, int32& attackerMaxSkillValueForLevel, int32& victimMaxSkillValueForLevel, int32& attackerWeaponSkill, int32& victimDefenseSkill, int32& crit_chance, int32& miss_chance, int32& dodge_chance, int32& parry_chance, int32& block_chance);
    void OnAuraRemove(Unit* unit, AuraApplication* aurApp, AuraRemoveMode mode);
    bool IfNormalReaction(Unit const* unit, Unit const* target, ReputationRank& repRank);
    bool IsNeedModSpellDamagePercent(Unit const* unit, AuraEffect* auraEff, float& doneTotalMod, SpellInfo const* spellProto);
    bool IsNeedModMeleeDamagePercent(Unit const* unit, AuraEffect* auraEff, float& doneTotalMod, SpellInfo const* spellProto);
    bool IsNeedModHealPercent(Unit const* unit, AuraEffect* auraEff, float& doneTotalMod, SpellInfo const* spellProto);
    bool CanSetPhaseMask(Unit const* unit, uint32 newPhaseMask, bool update);
    bool IsCustomBuildValuesUpdate(Unit const* unit, uint8 updateType, ByteBuffer& fieldBuffer, Player const* target, uint16 index);

public: /* MovementHandlerScript */
    void OnPlayerMove(Player* player, MovementInfo movementInfo, uint32 opcode);

public: /* AllCreatureScript */
    //listener function (OnAllCreatureUpdate) is called by OnCreatureUpdate
    //void OnAllCreatureUpdate(Creature* creature, uint32 diff);
    void Creature_SelectLevel(const CreatureTemplate* cinfo, Creature* creature);

public: /* AllMapScript */
    //listener functions are called by OnPlayerEnterMap and OnPlayerLeaveMap
    //void OnPlayerEnterAll(Map* map, Player* player);
    //void OnPlayerLeaveAll(Map* map, Player* player);

public: /* BGScript */
    void OnBattlegroundStart(Battleground* bg);
    void OnBattlegroundEndReward(Battleground* bg, Player* player, TeamId winnerTeamId);
    void OnBattlegroundUpdate(Battleground* bg, uint32 diff);
    void OnBattlegroundAddPlayer(Battleground* bg, Player* player);
    void OnBattlegroundBeforeAddPlayer(Battleground* bg, Player* player);
    void OnBattlegroundRemovePlayerAtLeave(Battleground* bg, Player* player);
    void OnQueueUpdate(BattlegroundQueue* queue, BattlegroundBracketId bracket_id, bool isRated, uint32 arenaRatedTeamId);
    void OnAddGroup(BattlegroundQueue* queue, GroupQueueInfo* ginfo, uint32& index, Player* leader, Group* grp, PvPDifficultyEntry const* bracketEntry, bool isPremade);
    bool CanFillPlayersToBG(BattlegroundQueue* queue, Battleground* bg, const int32 aliFree, const int32 hordeFree, BattlegroundBracketId bracket_id);
    bool CanFillPlayersToBGWithSpecific(BattlegroundQueue* queue, Battleground* bg, const int32 aliFree, const int32 hordeFree,
                                        BattlegroundBracketId thisBracketId, BattlegroundQueue* specificQueue, BattlegroundBracketId specificBracketId);
    void OnCheckNormalMatch(BattlegroundQueue* queue, uint32& Coef, Battleground* bgTemplate, BattlegroundBracketId bracket_id, uint32& minPlayers, uint32& maxPlayers);
    bool CanSendMessageBGQueue(BattlegroundQueue* queue, Player* leader, Battleground* bg, PvPDifficultyEntry const* bracketEntry);
    bool CanSendJoinMessageArenaQueue(BattlegroundQueue* queue, Player* leader, GroupQueueInfo* ginfo, PvPDifficultyEntry const* bracketEntry, bool isRated);
    bool CanExitJoinMessageArenaQueue(BattlegroundQueue* queue, GroupQueueInfo* ginfo);

public: /* Arena Team Script */
    void OnGetSlotByType(const uint32 type, uint8& slot);
    void OnGetArenaPoints(ArenaTeam* at, float& points);
    void OnArenaTypeIDToQueueID(const BattlegroundTypeId bgTypeId, const uint8 arenaType, uint32& queueTypeID);
    void OnArenaQueueIdToArenaType(const BattlegroundQueueTypeId bgQueueTypeId, uint8& ArenaType);
    void OnSetArenaMaxPlayersPerTeam(const uint8 arenaType, uint32& maxPlayerPerTeam);

public: /* SpellSC */
    void OnCalcMaxDuration(Aura const* aura, int32& maxDuration);
    bool CanModAuraEffectDamageDone(AuraEffect const* auraEff, Unit* target, AuraApplication const* aurApp, uint8 mode, bool apply);
    bool CanModAuraEffectModDamagePercentDone(AuraEffect const* auraEff, Unit* target, AuraApplication const* aurApp, uint8 mode, bool apply);
    void OnSpellCheckCast(Spell* spell, bool strict, SpellCastResult& res);
    bool CanPrepare(Spell* spell, SpellCastTargets const* targets, AuraEffect const* triggeredByAura);
    bool CanScalingEverything(Spell* spell);
    bool CanSelectSpecTalent(Spell* spell);
    void OnScaleAuraUnitAdd(Spell* spell, Unit* target, uint32 effectMask, bool checkIfValid, bool implicit, uint8 auraScaleMask, TargetInfo& targetInfo);
    void OnRemoveAuraScaleTargets(Spell* spell, TargetInfo& targetInfo, uint8 auraScaleMask, bool& needErase);
    void OnBeforeAuraRankForLevel(SpellInfo const* spellInfo, SpellInfo const* latestSpellInfo, uint8 level);

public: /* GameEventScript */
    void OnGameEventStart(uint16 EventID);
    void OnGameEventStop(uint16 EventID);

public: /* MailScript */
    void OnBeforeMailDraftSendMailTo(MailDraft* mailDraft, MailReceiver const& receiver, MailSender const& sender, MailCheckMask& checked, uint32& deliver_delay, uint32& custom_expiration, bool& deleteMailItemsFromDB, bool& sendMail);

public: /* AchievementScript */

        void SetRealmCompleted(AchievementEntry const* achievement);
        bool IsCompletedCriteria(AchievementMgr* mgr, AchievementCriteriaEntry const* achievementCriteria, AchievementEntry const* achievement, CriteriaProgress const* progress);
        bool IsRealmCompleted(AchievementGlobalMgr const* globalmgr, AchievementEntry const* achievement, std::chrono::system_clock::time_point completionTime);
        void OnBeforeCheckCriteria(AchievementMgr* mgr, AchievementCriteriaEntryList const* achievementCriteriaList);
        bool CanCheckCriteria(AchievementMgr* mgr, AchievementCriteriaEntry const* achievementCriteria);

    public: /* PetScript */

        void OnInitStatsForLevel(Guardian* guardian, uint8 petlevel);
        void OnCalculateMaxTalentPointsForLevel(Pet* pet, uint8 level, uint8& points);
        bool CanUnlearnSpellSet(Pet* pet, uint32 level, uint32 spell);
        bool CanUnlearnSpellDefault(Pet* pet, SpellInfo const* spellEntry);
        bool CanResetTalents(Pet* pet);

    public: /* ArenaScript */

        bool CanAddMember(ArenaTeam* team, ObjectGuid PlayerGuid);
        void OnGetPoints(ArenaTeam* team, uint32 memberRating, float& points);
        bool CanSaveToDB(ArenaTeam* team);

    public: /* MiscScript */

        void OnConstructObject(Object* origin);
        void OnDestructObject(Object* origin);
        void OnConstructPlayer(Player* origin);
        void OnDestructPlayer(Player* origin);
        void OnConstructGroup(Group* origin);
        void OnDestructGroup(Group* origin);
        void OnConstructInstanceSave(InstanceSave* origin);
        void OnDestructInstanceSave(InstanceSave* origin);
        void OnItemCreate(Item* item, ItemTemplate const* itemProto, Player const* owner);
        bool CanApplySoulboundFlag(Item* item, ItemTemplate const* proto);
        bool CanItemApplyEquipSpell(Player* player, Item* item);
        bool CanSendAuctionHello(WorldSession const* session, ObjectGuid guid, Creature* creature);
        void ValidateSpellAtCastSpell(Player* player, uint32& oldSpellId, uint32& spellId, uint8& castCount, uint8& castFlags);
        void OnPlayerSetPhase(const AuraEffect* auraEff, AuraApplication const* aurApp, uint8 mode, bool apply, uint32& newPhase);
        void ValidateSpellAtCastSpellResult(Player* player, Unit* mover, Spell* spell, uint32 oldSpellId, uint32 spellId);
        void OnAfterLootTemplateProcess(Loot* loot, LootTemplate const* tab, LootStore const& store, Player* lootOwner, bool personal, bool noEmptyError, uint16 lootMode);
        void OnInstanceSave(InstanceSave* instanceSave);

    public: /* CommandSC */

        void OnHandleDevCommand(Player* player, std::string& argstr);

private:
    uint32 _scriptCount;

    //atomic op counter for active scripts amount
    std::atomic<long> _scheduledScripts;
};

#define sScriptMgr ScriptMgr::instance()

template<class TScript>
class ScriptRegistry
{
public:
    typedef std::map<uint32, TScript*> ScriptMap;
    typedef typename ScriptMap::iterator ScriptMapIterator;

    typedef std::vector<TScript*> ScriptVector;
    typedef typename ScriptVector::iterator ScriptVectorIterator;

    // The actual list of scripts. This will be accessed concurrently, so it must not be modified
    // after server startup.
    static ScriptMap ScriptPointerList;
    // After database load scripts
    static ScriptVector ALScripts;

    static void AddScript(TScript* const script)
    {
        ASSERT(script);

        if (!_checkMemory(script))
            return;

        if (script->isAfterLoadScript())
        {
            ALScripts.push_back(script);
        }
        else
        {
            script->checkValidity();

            // We're dealing with a code-only script; just add it.
            ScriptPointerList[_scriptIdCounter++] = script;
            sScriptMgr->IncrementScriptCount();
        }
    }

    static void AddALScripts()
    {
        for(ScriptVectorIterator it = ALScripts.begin(); it != ALScripts.end(); ++it)
        {
            TScript* const script = *it;

            script->checkValidity();

            if (script->IsDatabaseBound())
            {
                if (!_checkMemory(script))
                {
                    return;
                }

                // Get an ID for the script. An ID only exists if it's a script that is assigned in the database
                // through a script name (or similar).
                uint32 id = sObjectMgr->GetScriptId(script->GetName().c_str());
                if (id)
                {
                    // Try to find an existing script.
                    bool existing = false;
                    for (auto iterator = ScriptPointerList.begin(); iterator != ScriptPointerList.end(); ++iterator)
                    {
                        // If the script names match...
                        if (iterator->second->GetName() == script->GetName())
                        {
                            // ... It exists.
                            existing = true;
                            break;
                        }
                    }

                    // If the script isn't assigned -> assign it!
                    if (!existing)
                    {
                        ScriptPointerList[id] = script;
                        sScriptMgr->IncrementScriptCount();
                    }
                    else
                    {
                        // If the script is already assigned -> delete it!
                        LOG_ERROR("server", "Script named '%s' is already assigned (two or more scripts have the same name), so the script can't work, aborting...",
                                       script->GetName().c_str());

                        ABORT(); // Error that should be fixed ASAP.
                    }
                }
                else
                {
                    // The script uses a script name from database, but isn't assigned to anything.
                    if (script->GetName().find("Smart") == std::string::npos)
                        LOG_ERROR("sql.sql", "Script named '%s' is not assigned in the database.",
                                         script->GetName().c_str());
                }
            }
            else
            {
                // We're dealing with a code-only script; just add it.
                ScriptPointerList[_scriptIdCounter++] = script;
                sScriptMgr->IncrementScriptCount();
            }
        }
    }

    // Gets a script by its ID (assigned by ObjectMgr).
    static TScript* GetScriptById(uint32 id)
    {
        ScriptMapIterator it = ScriptPointerList.find(id);
        if (it != ScriptPointerList.end())
            return it->second;

        return nullptr;
    }

private:
    // See if the script is using the same memory as another script. If this happens, it means that
    // someone forgot to allocate new memory for a script.
    static bool _checkMemory(TScript* const script)
    {
        // See if the script is using the same memory as another script. If this happens, it means that
        // someone forgot to allocate new memory for a script.
        for (ScriptMapIterator it = ScriptPointerList.begin(); it != ScriptPointerList.end(); ++it)
        {
            if (it->second == script)
            {
                LOG_ERROR("server", "Script '%s' has same memory pointer as '%s'.",
                               script->GetName().c_str(), it->second->GetName().c_str());

                return false;
            }
        }

        return true;
    }

    // Counter used for code-only scripts.
    static uint32 _scriptIdCounter;
};

// Instantiate static members of ScriptRegistry.
template<class TScript> std::map<uint32, TScript*> ScriptRegistry<TScript>::ScriptPointerList;
template<class TScript> std::vector<TScript*> ScriptRegistry<TScript>::ALScripts;
template<class TScript> uint32 ScriptRegistry<TScript>::_scriptIdCounter = 0;

#endif

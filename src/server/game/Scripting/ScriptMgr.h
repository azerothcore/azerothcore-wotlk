/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef SC_SCRIPTMGR_H
#define SC_SCRIPTMGR_H

#include "Common.h"
#include "ObjectMgr.h"
#include "DBCStores.h"
#include "QuestDef.h"
#include "SharedDefines.h"
#include "World.h"
#include "Weather.h"
#include "AchievementMgr.h"
#include "DynamicObject.h"
#include "ArenaTeam.h"
#include "GameEventMgr.h"
#include "PetDefines.h"
#include "AuctionHouseMgr.h"
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
struct ItemTemplate;
struct OutdoorPvPData;
struct GroupQueueInfo;

#define VISIBLE_RANGE       166.0f                          //MAX visible range (size of grid)

/*
    TODO: Add more script type classes.

    SessionScript
    CollisionScript
    ArenaTeamScript

*/

/*
    Standard procedure when adding new script type classes:

    First of all, define the actual class, and have it inherit from ScriptObject, like so:

    class MyScriptType : public ScriptObject
    {
        uint32 _someId;

        private:

            void RegisterSelf();

        protected:

            MyScriptType(const char* name, uint32 someId)
                : ScriptObject(name), _someId(someId)
            {
                ScriptRegistry<MyScriptType>::AddScript(this);
            }

        public:

            // If a virtual function in your script type class is not necessarily
            // required to be overridden, just declare it virtual with an empty
            // body. If, on the other hand, it's logical only to override it (i.e.
            // if it's the only method in the class), make it pure virtual, by adding
            // = 0 to it.
            virtual void OnSomeEvent(uint32 someArg1, std::string& someArg2) { }

            // This is a pure virtual function:
            virtual void OnAnotherEvent(uint32 someArg) = 0;
    }

    Next, you need to add a specialization for ScriptRegistry. Put this in the bottom of
    ScriptMgr.cpp:

    template class ScriptRegistry<MyScriptType>;

    Now, add a cleanup routine in ScriptMgr::~ScriptMgr:

    SCR_CLEAR(MyScriptType);

    Now your script type is good to go with the script system. What you need to do now
    is add functions to ScriptMgr that can be called from the core to actually trigger
    certain events. For example, in ScriptMgr.h:

    void OnSomeEvent(uint32 someArg1, std::string& someArg2);
    void OnAnotherEvent(uint32 someArg);

    In ScriptMgr.cpp:

    void ScriptMgr::OnSomeEvent(uint32 someArg1, std::string& someArg2)
    {
        FOREACH_SCRIPT(MyScriptType)->OnSomeEvent(someArg1, someArg2);
    }

    void ScriptMgr::OnAnotherEvent(uint32 someArg)
    {
        FOREACH_SCRIPT(MyScriptType)->OnAnotherEvent(someArg1, someArg2);
    }

    Now you simply call these two functions from anywhere in the core to trigger the
    event on all registered scripts of that type.
*/

class ScriptObject
{
    friend class ScriptMgr;

    public:

        // Do not override this in scripts; it should be overridden by the various script type classes. It indicates
        // whether or not this script type must be assigned in the database.
        virtual bool IsDatabaseBound() const { return false; }
        virtual bool isAfterLoadScript() const { return IsDatabaseBound(); }
        virtual void checkValidity() { }

        const std::string& GetName() const { return _name; }

    protected:

        ScriptObject(const char* name)
            : _name(std::string(name))
        {
        }

        virtual ~ScriptObject()
        {
        }

    private:

        const std::string _name;
};

template<class TObject> class UpdatableScript
{
    protected:

        UpdatableScript()
        {
        }

    public:

        virtual void OnUpdate(TObject* /*obj*/, uint32 /*diff*/) { }
};

class SpellScriptLoader : public ScriptObject
{
    protected:

        SpellScriptLoader(const char* name);

    public:

        bool IsDatabaseBound() const { return true; }

        // Should return a fully valid SpellScript pointer.
        virtual SpellScript* GetSpellScript() const { return nullptr; }

        // Should return a fully valid AuraScript pointer.
        virtual AuraScript* GetAuraScript() const { return nullptr; }
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
        virtual void OnAfterArenaRatingCalculation(Battleground *const /*bg*/, int32& /*winnerMatchmakerChange*/, int32& /*loserMatchmakerChange*/, int32& /*winnerChange*/, int32& /*loserChange*/) { };
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
        void checkMap() {
            _mapEntry = sMapStore.LookupEntry(_mapId);

            if (!_mapEntry)
                sLog->outError("Invalid MapScript for %u; no such map ID.", _mapId);
        }

        // Gets the MapEntry structure associated with this script. Can return NULL.
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
        virtual void OnUpdate(TMap* /*map*/, uint32 /*diff*/) { }
};

class WorldMapScript : public ScriptObject, public MapScript<Map>
{
    protected:

        WorldMapScript(const char* name, uint32 mapId);

    public:

        bool isAfterLoadScript() const { return true; }

        void checkValidity() {
            checkMap();

            if (GetEntry() && !GetEntry()->IsWorldMap())
                sLog->outError("WorldMapScript for map %u is invalid.", GetEntry()->MapID);
        }
};

class InstanceMapScript : public ScriptObject, public MapScript<InstanceMap>
{
    protected:

        InstanceMapScript(const char* name, uint32 mapId);

    public:

        bool IsDatabaseBound() const { return true; }

        void checkValidity() {
            checkMap();

            if (GetEntry() && !GetEntry()->IsDungeon())
                sLog->outError("InstanceMapScript for map %u is invalid.", GetEntry()->MapID);
        }

        // Gets an InstanceScript object for this instance.
        virtual InstanceScript* GetInstanceScript(InstanceMap* /*map*/) const { return nullptr; }
};

class BattlegroundMapScript : public ScriptObject, public MapScript<BattlegroundMap>
{
    protected:

        BattlegroundMapScript(const char* name, uint32 mapId);

    public:

        bool isAfterLoadScript() const { return true; }

        void checkValidity() {
            checkMap();

            if (GetEntry() && !GetEntry()->IsBattleground())
                sLog->outError("BattlegroundMapScript for map %u is invalid.", GetEntry()->MapID);
        }
};

class ItemScript : public ScriptObject
{
    protected:

        ItemScript(const char* name);

    public:

        bool IsDatabaseBound() const { return true; }

        // Called when a player accepts a quest from the item.
        virtual bool OnQuestAccept(Player* /*player*/, Item* /*item*/, Quest const* /*quest*/) { return false; }

        // Called when a player uses the item.
        virtual bool OnUse(Player* /*player*/, Item* /*item*/, SpellCastTargets const& /*targets*/) { return false; }

        // Called when the item is destroyed.
        virtual bool OnRemove(Player* /*player*/, Item* /*item*/) { return false; }

        // Called before casting a combat spell from this item (chance on hit spells of item template, can be used to prevent cast if returning false)
        virtual bool OnCastItemCombatSpell(Player* /*player*/, Unit* /*victim*/, SpellInfo const* /*spellInfo*/, Item* /*item*/) { return true; }

        // Called when the item expires (is destroyed).
        virtual bool OnExpire(Player* /*player*/, ItemTemplate const* /*proto*/) { return false; }

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
    // Attacker can be NULL if he is despawned while the aura still exists on target
    virtual void ModifyPeriodicDamageAurasTick(Unit* /*target*/, Unit* /*attacker*/, uint32& /*damage*/) { }

    // Called when Melee Damage is being Dealt
    virtual void ModifyMeleeDamage(Unit* /*target*/, Unit* /*attacker*/, uint32& /*damage*/) { }

    // Called when Spell Damage is being Dealt
    virtual void ModifySpellDamageTaken(Unit* /*target*/, Unit* /*attacker*/, int32& /*damage*/) { }

    // Called when Heal is Recieved
    virtual void ModifyHealRecieved(Unit* /*target*/, Unit* /*attacker*/, uint32& /*damage*/) { }

    //Called when Damage is Dealt
    virtual uint32 DealDamage(Unit* /*AttackerUnit*/, Unit* /*pVictim*/, uint32 damage, DamageEffectType /*damagetype*/) { return damage; }

    virtual void OnBeforeRollMeleeOutcomeAgainst(const Unit* /*attacker*/, const Unit* /*victim*/, WeaponAttackType /*attType*/, int32 &/*attackerMaxSkillValueForLevel*/, int32 &/*victimMaxSkillValueForLevel*/, int32 &/*attackerWeaponSkill*/, int32 &/*victimDefenseSkill*/, int32& /*crit_chance*/, int32& /*miss_chance*/ , int32& /*dodge_chance*/ , int32& /*parry_chance*/ , int32& /*block_chance*/ ) {   };
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

        bool IsDatabaseBound() const { return true; }

        // Called when a player opens a gossip dialog with the creature.
        virtual bool OnGossipHello(Player* /*player*/, Creature* /*creature*/) { return false; }

        // Called when a player selects a gossip item in the creature's gossip menu.
        virtual bool OnGossipSelect(Player* /*player*/, Creature* /*creature*/, uint32 /*sender*/, uint32 /*action*/) { return false; }

        // Called when a player selects a gossip with a code in the creature's gossip menu.
        virtual bool OnGossipSelectCode(Player* /*player*/, Creature* /*creature*/, uint32 /*sender*/, uint32 /*action*/, const char* /*code*/) { return false; }

        // Called when a player accepts a quest from the creature.
        virtual bool OnQuestAccept(Player* /*player*/, Creature* /*creature*/, Quest const* /*quest*/) { return false; }

        // Called when a player selects a quest in the creature's quest menu.
        virtual bool OnQuestSelect(Player* /*player*/, Creature* /*creature*/, Quest const* /*quest*/) { return false; }

        // Called when a player completes a quest with the creature.
        virtual bool OnQuestComplete(Player* /*player*/, Creature* /*creature*/, Quest const* /*quest*/) { return false; }

        // Called when a player selects a quest reward.
        virtual bool OnQuestReward(Player* /*player*/, Creature* /*creature*/, Quest const* /*quest*/, uint32 /*opt*/) { return false; }

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

        bool IsDatabaseBound() const { return true; }

        // Called when a player opens a gossip dialog with the gameobject.
        virtual bool OnGossipHello(Player* /*player*/, GameObject* /*go*/) { return false; }

        // Called when a player selects a gossip item in the gameobject's gossip menu.
        virtual bool OnGossipSelect(Player* /*player*/, GameObject* /*go*/, uint32 /*sender*/, uint32 /*action*/) { return false; }

        // Called when a player selects a gossip with a code in the gameobject's gossip menu.
        virtual bool OnGossipSelectCode(Player* /*player*/, GameObject* /*go*/, uint32 /*sender*/, uint32 /*action*/, const char* /*code*/) { return false; }

        // Called when a player accepts a quest from the gameobject.
        virtual bool OnQuestAccept(Player* /*player*/, GameObject* /*go*/, Quest const* /*quest*/) { return false; }

        // Called when a player selects a quest reward.
        virtual bool OnQuestReward(Player* /*player*/, GameObject* /*go*/, Quest const* /*quest*/, uint32 /*opt*/) { return false; }

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

        bool IsDatabaseBound() const { return true; }

        // Called when the area trigger is activated by a player.
        virtual bool OnTrigger(Player* /*player*/, AreaTrigger const* /*trigger*/) { return false; }
};

class BattlegroundScript : public ScriptObject
{
    protected:

        BattlegroundScript(const char* name);

    public:

        bool IsDatabaseBound() const { return true; }

        // Should return a fully valid Battleground object for the type ID.
        virtual Battleground* GetBattleground() const = 0;

};

class OutdoorPvPScript : public ScriptObject
{
    protected:

        OutdoorPvPScript(const char* name);

    public:

        bool IsDatabaseBound() const { return true; }

        // Should return a fully valid OutdoorPvP object for the type ID.
        virtual OutdoorPvP* GetOutdoorPvP() const = 0;
};

class CommandScript : public ScriptObject
{
    protected:

        CommandScript(const char* name);

    public:

        // Should return a pointer to a valid command table (ChatCommand array) to be used by ChatHandler.
        virtual std::vector<ChatCommand> GetCommands() const = 0;
};

class WeatherScript : public ScriptObject, public UpdatableScript<Weather>
{
    protected:

        WeatherScript(const char* name);

    public:

        bool IsDatabaseBound() const { return true; }

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

        bool IsDatabaseBound() const { return true; }

        // Called when a single condition is checked for a player.
        virtual bool OnConditionCheck(Condition* /*condition*/, ConditionSourceInfo& /*sourceInfo*/) { return true; }
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

        bool IsDatabaseBound() const { return true; }

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

        bool IsDatabaseBound() const { return true; }

        // Called when an additional criteria is checked.
        virtual bool OnCheck(Player* source, Unit* target, uint32 /*criteria_id*/) {
            return OnCheck(source, target);
        }
        // deprecated/legacy
        virtual bool OnCheck(Player* /*source*/, Unit* /*target*/) { return true; };
};

class PlayerScript : public ScriptObject
{
    protected:

        PlayerScript(const char* name);

    public:
        virtual void OnPlayerReleasedGhost(Player* /*player*/) { }

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
        virtual void OnBeforeUpdate(Player* /*player*/, uint32 /*p_time*/){ }

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

        virtual void OnTextEmote(Player* /*player*/, uint32 /*textEmote*/, uint32 /*emoteNum*/, uint64 /*guid*/) { }

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
        virtual void OnDelete(uint64 /*guid*/, uint32 /*accountId*/) { }

        // Called when a player delete failed.
        virtual void OnFailedDelete(uint64 /*guid*/, uint32 /*accountId*/) { }

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
        virtual bool OnBeforeTeleport(Player* /*player*/, uint32 /*mapid*/, float /*x*/, float /*y*/, float /*z*/, float /*orientation*/, uint32 /*options*/, Unit* /*target*/) { return true; }

        // Called when team/faction is set on player
        virtual void OnUpdateFaction(Player* /*player*/) { }

        // Called when a player is added to battleground
        virtual void OnAddToBattleground(Player* /*player*/, Battleground* /*bg*/) { }

        // Called when a player is removed from battleground
        virtual void OnRemoveFromBattleground(Player* /*player*/, Battleground* /*bg*/) { }

        // Called when a player complete an achievement
        virtual void OnAchiComplete(Player* /*player*/, AchievementEntry const* /*achievement*/) { }

        // Called when a player complete an achievement criteria
        virtual void OnCriteriaProgress(Player* /*player*/, AchievementCriteriaEntry const* /*criteria*/) { }

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

        //After looting item
        virtual void OnLootItem(Player* /*player*/, Item* /*item*/, uint32 /*count*/, uint64 /*lootguid*/) { }

        //After creating item (eg profession item creation)
        virtual void OnCreateItem(Player* /*player*/, Item* /*item*/, uint32 /*count*/) { }

        //After receiving item as a quest reward
        virtual void OnQuestRewardItem(Player* /*player*/, Item* /*item*/, uint32 /*count*/) { }

        //Before buying something from any vendor
        virtual void OnBeforeBuyItemFromVendor(Player* /*player*/, uint64 /*vendorguid*/, uint32 /*vendorslot*/, uint32 &/*item*/, uint8 /*count*/, uint8 /*bag*/, uint8 /*slot*/) { };

        //Before buying something from any vendor
        virtual void OnAfterStoreOrEquipNewItem(Player* /*player*/, uint32 /*vendorslot*/, uint32& /*item*/, uint8 /*count*/, uint8 /*bag*/, uint8 /*slot*/, ItemTemplate const* /*pProto*/, Creature* /*pVendor*/, VendorItem const* /*crItem*/, bool /*bStore*/) { };

        virtual void OnAfterUpdateMaxPower(Player* /*player*/, Powers& /*power*/, float& /*value*/) { }

        virtual void OnAfterUpdateMaxHealth(Player* /*player*/, float& /*value*/) { }

        virtual void OnBeforeUpdateAttackPowerAndDamage(Player* /*player*/, float& /*level*/, float& /*val2*/, bool /*ranged*/) { }
        virtual void OnAfterUpdateAttackPowerAndDamage(Player* /*player*/, float& /*level*/, float& /*base_attPower*/, float& /*attPowerMod*/, float& /*attPowerMultiplier*/, bool /*ranged*/) { }

        virtual void OnBeforeInitTalentForLevel(Player* /*player*/, uint8& /*level*/, uint32& /*talentPointsForLevel*/) { }

        virtual void OnFirstLogin(Player* /*player*/) { }

        virtual bool CanJoinInBattlegroundQueue(Player* /*player*/, uint64 /*BattlemasterGuid*/, BattlegroundTypeId /*BGTypeID*/, uint8 /*joinAsGroup*/, GroupJoinBattlegroundResult& /*err*/) { return true; }

        // Called before the player's temporary summoned creature has initialized it's stats
        virtual void OnBeforeTempSummonInitStats(Player* /*player*/, TempSummon* /*tempSummon*/, uint32& /*duration*/) { }

        // Called before the player's guardian / pet has initialized it's stats for the player's level
        virtual void OnBeforeGuardianInitStatsForLevel(Player* /*player*/, Guardian* /*guardian*/, CreatureTemplate const* /*cinfo*/, PetType& /*petType*/) { }

        // Called after the player's guardian / pet has initialized it's stats for the player's level
        virtual void OnAfterGuardianInitStatsForLevel(Player* /*player*/, Guardian* /*guardian*/) { }

        // Called before loading a player's pet from the DB
        virtual void OnBeforeLoadPetFromDB(Player* /*player*/, uint32& /*petentry*/, uint32& /*petnumber*/, bool& /*current*/, bool& /*forceLoadFromDB*/) { }
};

class AccountScript : public ScriptObject
{
    protected:

        AccountScript(const char* name);

    public:

        // Called when an account logged in successfully
        virtual void OnAccountLogin(uint32 /*accountId*/) { }


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

        bool IsDatabaseBound() const { return false; }

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

        virtual void OnEvent(Guild* /*guild*/, uint8 /*eventType*/, uint32 /*playerGuid1*/, uint32 /*playerGuid2*/, uint8 /*newRank*/) { }

        virtual void OnBankEvent(Guild* /*guild*/, uint8 /*eventType*/, uint8 /*tabId*/, uint32 /*playerGuid*/, uint32 /*itemOrMoney*/, uint16 /*itemStackCount*/, uint8 /*destTabId*/) { }
};

class GroupScript : public ScriptObject
{
    protected:

        GroupScript(const char* name);

    public:

        bool IsDatabaseBound() const { return false; }

        // Called when a member is added to a group.
        virtual void OnAddMember(Group* /*group*/, uint64 /*guid*/) { }

        // Called when a member is invited to join a group.
        virtual void OnInviteMember(Group* /*group*/, uint64 /*guid*/) { }

        // Called when a member is removed from a group.
        virtual void OnRemoveMember(Group* /*group*/, uint64 /*guid*/, RemoveMethod /*method*/, uint64 /*kicker*/, const char* /*reason*/) { }

        // Called when the leader of a group is changed.
        virtual void OnChangeLeader(Group* /*group*/, uint64 /*newLeaderGuid*/, uint64 /*oldLeaderGuid*/) { }

        // Called when a group is disbanded.
        virtual void OnDisband(Group* /*group*/) { }
};

// following hooks can be used anywhere and are not db bounded
class GlobalScript : public ScriptObject
{
    protected:

        GlobalScript(const char* name);

    public:

        // items
        virtual void OnItemDelFromDB(SQLTransaction& /*trans*/, uint32 /*itemGuid*/) { }
        virtual void OnMirrorImageDisplayItem(const Item* /*item*/, uint32& /*display*/) { }

        // loot
        virtual void OnAfterRefCount(Player const* /*player*/, LootStoreItem* /*LootStoreItem*/, Loot& /*loot*/, bool /*canRate*/, uint16 /*lootMode*/, uint32& /*maxcount*/, LootStore const& /*store*/) { }
        virtual void OnBeforeDropAddItem(Player const* /*player*/, Loot& /*loot*/, bool /*canRate*/, uint16 /*lootMode*/, LootStoreItem* /*LootStoreItem*/, LootStore const& /*store*/) { }
        virtual void OnItemRoll(Player const* /*player*/, LootStoreItem const* /*LootStoreItem*/, float& /*chance*/, Loot& /*loot*/, LootStore const& /*store*/) { };

        virtual void OnInitializeLockedDungeons(Player* /*player*/, uint8& /*level*/, uint32& /*lockData*/) { }
        virtual void OnAfterInitializeLockedDungeons(Player* /*player*/) { }

        // On Before arena points distribution
        virtual void OnBeforeUpdateArenaPoints(ArenaTeam* /*at*/, std::map<uint32, uint32> & /*ap*/) { }

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

    bool IsDatabaseBound() const { return false; }

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

    virtual void OnAddGroup(BattlegroundQueue* /*queue*/, GroupQueueInfo* /*ginfo*/, uint32& /*index*/, Player* /*leader*/, Group* /*grp*/, PvPDifficultyEntry const* /*bracketEntry*/, bool /*isPremade*/) { }

    virtual bool CanFillPlayersToBG(BattlegroundQueue* /*queue*/, Battleground* /*bg*/, const int32 /*aliFree*/, const int32 /*hordeFree*/, BattlegroundBracketId /*bracket_id*/) { return true; }

    virtual bool CanFillPlayersToBGWithSpecific(BattlegroundQueue* /*queue*/, Battleground* /*bg*/, const int32 /*aliFree*/, const int32 /*hordeFree*/,
        BattlegroundBracketId /*thisBracketId*/, BattlegroundQueue* /*specificQueue*/, BattlegroundBracketId /*specificBracketId*/) { return true; }

    virtual void OnCheckNormalMatch(BattlegroundQueue* /*queue*/, uint32& /*Coef*/, Battleground* /*bgTemplate*/, BattlegroundBracketId /*bracket_id*/, uint32& /*minPlayers*/, uint32& /*maxPlayers*/) { }

    virtual bool CanSendMessageQueue(BattlegroundQueue* /*queue*/, Player* /*leader*/, Battleground* /*bg*/, PvPDifficultyEntry const* /*bracketEntry*/) { return true; }
};

class SpellSC : public ScriptObject
{
protected:

    SpellSC(const char* name);

public:

    bool IsDatabaseBound() const { return false; }

    // Calculate max duration in applying aura
    virtual void OnCalcMaxDuration(Aura const* /*aura*/, int32& /*maxDuration*/) { }

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
        void OnAfterArenaRatingCalculation(Battleground *const bg, int32 &winnerMatchmakerChange, int32 &loserMatchmakerChange, int32 &winnerChange, int32 &loserChange);

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
        void OnPlayerTextEmote(Player* player, uint32 textEmote, uint32 emoteNum, uint64 guid);
        void OnPlayerSpellCast(Player* player, Spell* spell, bool skipCheck);
        void OnPlayerLogin(Player* player);
        void OnPlayerLoadFromDB(Player* player);
        void OnPlayerLogout(Player* player);
        void OnPlayerCreate(Player* player);
        void OnPlayerSave(Player* player);
        void OnPlayerDelete(uint64 guid, uint32 accountId);
        void OnPlayerFailedDelete(uint64 guid, uint32 accountId);
        void OnPlayerBindToInstance(Player* player, Difficulty difficulty, uint32 mapid, bool permanent);
        void OnPlayerUpdateZone(Player* player, uint32 newZone, uint32 newArea);
        void OnPlayerUpdateArea(Player* player, uint32 oldArea, uint32 newArea);
        bool OnBeforePlayerTeleport(Player* player, uint32 mapid, float x, float y, float z, float orientation, uint32 options, Unit *target);
        void OnPlayerUpdateFaction(Player* player);
        void OnPlayerAddToBattleground(Player* player, Battleground* bg);
        void OnPlayerRemoveFromBattleground(Player* player, Battleground* bg);
        void OnAchievementComplete(Player *player, AchievementEntry const* achievement);
        void OnCriteriaProgress(Player *player, AchievementCriteriaEntry const* criteria);
        void OnAchievementSave(SQLTransaction& trans, Player* player, uint16 achiId, CompletedAchievementData achiData);
        void OnCriteriaSave(SQLTransaction& trans, Player* player, uint16 critId, CriteriaProgress criteriaData);
        void OnGossipSelect(Player* player, uint32 menu_id, uint32 sender, uint32 action);
        void OnGossipSelectCode(Player* player, uint32 menu_id, uint32 sender, uint32 action, const char* code);
        void OnPlayerBeingCharmed(Player* player, Unit* charmer, uint32 oldFactionId, uint32 newFactionId);
        void OnAfterPlayerSetVisibleItemSlot(Player* player, uint8 slot, Item *item);
        void OnAfterPlayerMoveItemFromInventory(Player* player, Item* it, uint8 bag, uint8 slot, bool update);
        void OnEquip(Player* player, Item* it, uint8 bag, uint8 slot, bool update);
        void OnPlayerJoinBG(Player* player);
        void OnPlayerJoinArena(Player* player);
        void OnLootItem(Player* player, Item* item, uint32 count, uint64 lootguid);
        void OnCreateItem(Player* player, Item* item, uint32 count);
        void OnQuestRewardItem(Player* player, Item* item, uint32 count);
        void OnBeforeBuyItemFromVendor(Player * player, uint64 vendorguid, uint32 vendorslot, uint32 &item, uint8 count, uint8 bag, uint8 slot);
        void OnAfterStoreOrEquipNewItem(Player* player, uint32 vendorslot, uint32 &item, uint8 count, uint8 bag, uint8 slot, ItemTemplate const* pProto, Creature* pVendor, VendorItem const* crItem, bool bStore);
        void OnAfterUpdateMaxPower(Player* player, Powers& power, float& value);
        void OnAfterUpdateMaxHealth(Player* player, float& value);
        void OnBeforeUpdateAttackPowerAndDamage(Player* player, float& level, float& val2, bool ranged);
        void OnAfterUpdateAttackPowerAndDamage(Player* player, float& level, float& base_attPower, float& attPowerMod, float& attPowerMultiplier, bool ranged);
        void OnBeforeInitTalentForLevel(Player* player, uint8& level, uint32& talentPointsForLevel);
        void OnFirstLogin(Player* player);
        void OnPlayerCompleteQuest(Player* player, Quest const* quest);
        bool CanJoinInBattlegroundQueue(Player* player, uint64 BattlemasterGuid, BattlegroundTypeId BGTypeID, uint8 joinAsGroup, GroupJoinBattlegroundResult& err);
        void OnBeforeTempSummonInitStats(Player* player, TempSummon* tempSummon, uint32& duration);
        void OnBeforeGuardianInitStatsForLevel(Player* player, Guardian* guardian, CreatureTemplate const* cinfo, PetType& petType);
        void OnAfterGuardianInitStatsForLevel(Player* player, Guardian* guardian);
        void OnBeforeLoadPetFromDB(Player* player, uint32& petentry, uint32& petnumber, bool& current, bool& forceLoadFromDB);

    public: /* AccountScript */

        void OnAccountLogin(uint32 accountId);
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
        void OnGuildMemberWitdrawMoney(Guild* guild, Player* player, uint32 &amount, bool isRepair);
        void OnGuildMemberDepositMoney(Guild* guild, Player* player, uint32 &amount);
        void OnGuildItemMove(Guild* guild, Player* player, Item* pItem, bool isSrcBank, uint8 srcContainer, uint8 srcSlotId,
            bool isDestBank, uint8 destContainer, uint8 destSlotId);
        void OnGuildEvent(Guild* guild, uint8 eventType, uint32 playerGuid1, uint32 playerGuid2, uint8 newRank);
        void OnGuildBankEvent(Guild* guild, uint8 eventType, uint8 tabId, uint32 playerGuid, uint32 itemOrMoney, uint16 itemStackCount, uint8 destTabId);

    public: /* GroupScript */

        void OnGroupAddMember(Group* group, uint64 guid);
        void OnGroupInviteMember(Group* group, uint64 guid);
        void OnGroupRemoveMember(Group* group, uint64 guid, RemoveMethod method, uint64 kicker, const char* reason);
        void OnGroupChangeLeader(Group* group, uint64 newLeaderGuid, uint64 oldLeaderGuid);
        void OnGroupDisband(Group* group);

    public: /* GlobalScript */
        void OnGlobalItemDelFromDB(SQLTransaction& trans, uint32 itemGuid);
        void OnGlobalMirrorImageDisplayItem(const Item *item, uint32 &display);
        void OnBeforeUpdateArenaPoints(ArenaTeam* at, std::map<uint32, uint32> &ap);
        void OnAfterRefCount(Player const* player, Loot& loot, bool canRate, uint16 lootMode, LootStoreItem* LootStoreItem, uint32 &maxcount, LootStore const& store);
        void OnBeforeDropAddItem(Player const* player, Loot& loot, bool canRate, uint16 lootMode, LootStoreItem* LootStoreItem, LootStore const& store);
        void OnItemRoll(Player const* player, LootStoreItem const* LootStoreItem, float &chance, Loot& loot, LootStore const& store);
        void OnInitializeLockedDungeons(Player* player, uint8& level, uint32& lockData);
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
        uint32 DealDamage(Unit* AttackerUnit, Unit *pVictim, uint32 damage, DamageEffectType damagetype);
        void OnBeforeRollMeleeOutcomeAgainst(const Unit* attacker, const Unit* victim, WeaponAttackType attType, int32 &attackerMaxSkillValueForLevel, int32 &victimMaxSkillValueForLevel, int32 &attackerWeaponSkill, int32 &victimDefenseSkill, int32 &crit_chance, int32 &miss_chance, int32 &dodge_chance, int32 &parry_chance, int32 &block_chance);


    public: /* MovementHandlerScript */

        void OnPlayerMove(Player* player, MovementInfo movementInfo, uint32 opcode);

    public: /* AllCreatureScript */

        //listener function (OnAllCreatureUpdate) is called by OnCreatureUpdate
        //void OnAllCreatureUpdate(Creature* creature, uint32 diff);
        void Creature_SelectLevel(const CreatureTemplate *cinfo, Creature* creature);

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
        void OnAddGroup(BattlegroundQueue* queue, GroupQueueInfo* ginfo, uint32& index, Player* leader, Group* grp, PvPDifficultyEntry const* bracketEntry, bool isPremade);
        bool CanFillPlayersToBG(BattlegroundQueue* queue, Battleground* bg, const int32 aliFree, const int32 hordeFree, BattlegroundBracketId bracket_id);
        bool CanFillPlayersToBGWithSpecific(BattlegroundQueue* queue, Battleground* bg, const int32 aliFree, const int32 hordeFree,
            BattlegroundBracketId thisBracketId, BattlegroundQueue* specificQueue, BattlegroundBracketId specificBracketId);
        void OnCheckNormalMatch(BattlegroundQueue* queue, uint32& Coef, Battleground* bgTemplate, BattlegroundBracketId bracket_id, uint32& minPlayers, uint32& maxPlayers);
        bool CanSendMessageQueue(BattlegroundQueue* queue, Player* leader, Battleground* bg, PvPDifficultyEntry const* bracketEntry);

    public: /* SpellSC */

        void OnCalcMaxDuration(Aura const* aura, int32& maxDuration);

    public: /* GameEventScript */

        void OnGameEventStart(uint16 EventID);
        void OnGameEventStop(uint16 EventID);

    public: /* MailScript */

        void OnBeforeMailDraftSendMailTo(MailDraft* mailDraft, MailReceiver const& receiver, MailSender const& sender, MailCheckMask& checked, uint32& deliver_delay, uint32& custom_expiration, bool& deleteMailItemsFromDB, bool& sendMail);

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

        static void AddALScripts() {
            for(ScriptVectorIterator it = ALScripts.begin(); it != ALScripts.end(); ++it) {
                TScript* const script = *it;

                script->checkValidity();

                if (script->IsDatabaseBound()) {

                    if (!_checkMemory(script))
                        return;

                    // Get an ID for the script. An ID only exists if it's a script that is assigned in the database
                    // through a script name (or similar).
                    uint32 id = sObjectMgr->GetScriptId(script->GetName().c_str());
                    if (id)
                    {
                        // Try to find an existing script.
                        bool existing = false;
                        for (ScriptMapIterator it = ScriptPointerList.begin(); it != ScriptPointerList.end(); ++it)
                        {
                            // If the script names match...
                            if (it->second->GetName() == script->GetName())
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
                            sLog->outError("Script named '%s' is already assigned (two or more scripts have the same name), so the script can't work, aborting...",
                                script->GetName().c_str());

                            ABORT(); // Error that should be fixed ASAP.
                        }
                    }
                    else
                    {
                        // The script uses a script name from database, but isn't assigned to anything.
                        if (script->GetName().find("Smart") == std::string::npos)
                            sLog->outErrorDb("Script named '%s' is not assigned in the database.",
                                script->GetName().c_str());
                    }
                } else {
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
        static bool _checkMemory(TScript* const script) {
            // See if the script is using the same memory as another script. If this happens, it means that
            // someone forgot to allocate new memory for a script.
            for (ScriptMapIterator it = ScriptPointerList.begin(); it != ScriptPointerList.end(); ++it)
            {
                if (it->second == script)
                {
                    sLog->outError("Script '%s' has same memory pointer as '%s'.",
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

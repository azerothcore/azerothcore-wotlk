/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU Affero General Public License as published by the
 * Free Software Foundation; either version 3 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
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
#include "Tuples.h"
#include "Types.h"
#include "Weather.h"
#include "World.h"
#include <atomic>

class AuctionHouseObject;
class AuraScript;
class Battleground;
class BattlegroundMap;
class BattlegroundQueue;
class Channel;
class ChatHandler;
class Creature;
class CreatureAI;
class DynamicObject;
class GameObject;
class GameObjectAI;
class GridMap;
class Group;
class Guild;
class InstanceMap;
class InstanceScript;
class Item;
class Map;
class MotionTransport;
class OutdoorPvP;
class Player;
class Quest;
class ScriptMgr;
class Spell;
class SpellCastTargets;
class SpellInfo;
class SpellScript;
class StaticTransport;
class Transport;
class Unit;
class Vehicle;
class WorldObject;
class WorldPacket;
class WorldSocket;

struct AchievementCriteriaData;
struct AuctionEntry;
struct Condition;
struct ConditionSourceInfo;
struct DungeonProgressionRequirements;
struct GroupQueueInfo;
struct ItemTemplate;
struct OutdoorPvPData;
struct TargetInfo;
struct SpellModifier;

namespace Acore::ChatCommands
{
    struct ChatCommandBuilder;
}

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
    [[nodiscard]] virtual auto IsDatabaseBound() const -> bool { return false; }
    [[nodiscard]] virtual auto isAfterLoadScript() const -> bool { return IsDatabaseBound(); }
    virtual void checkValidity() { }

    [[nodiscard]] auto GetName() const -> const std::string& { return _name; }

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
    [[nodiscard]] auto IsDatabaseBound() const -> bool override { return true; }

    // Should return a fully valid SpellScript pointer.
    [[nodiscard]] virtual auto GetSpellScript() const -> SpellScript* { return nullptr; }

    // Should return a fully valid AuraScript pointer.
    [[nodiscard]] virtual auto GetAuraScript() const -> AuraScript* { return nullptr; }
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
    virtual void OnSocketOpen(std::shared_ptr<WorldSocket> /*socket*/) { }

    // Called when a socket is closed. Do not store the socket object, and do not rely on the connection
    // being open; it is not.
    virtual void OnSocketClose(std::shared_ptr<WorldSocket> /*socket*/) { }

    /**
     * @brief This hook called when a packet is sent to a client. The packet object is a copy of the original packet, so reading and modifying it is safe.
     *
     * @param session Contains information about the WorldSession
     * @param packet Contains information about the WorldPacket
     * @return True if you want to continue sending the packet, false if you want to disallow sending the packet
     */
    [[nodiscard]] virtual auto CanPacketSend(WorldSession* /*session*/, WorldPacket& /*packet*/) -> bool { return true; }

    /**
     * @brief Called when a (valid) packet is received by a client. The packet object is a copy of the original packet, so
     * reading and modifying it is safe. Make sure to check WorldSession pointer before usage, it might be null in case of auth packets
     *
     * @param session Contains information about the WorldSession
     * @param packet Contains information about the WorldPacket
     * @return True if you want to continue receive the packet, false if you want to disallow receive the packet
     */
    [[nodiscard]] virtual auto CanPacketReceive(WorldSession* /*session*/, WorldPacket& /*packet*/) -> bool { return true; }
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

    /**
     * @brief This hook runs before finalizing the player world session. Can be also used to mutate the cache version of the Client.
     *
     * @param version The cache version that we will be sending to the Client.
     */
    virtual void OnBeforeFinalizePlayerWorldSession(uint32& /*cacheVersion*/) { }

    /**
     * @brief This hook runs after all scripts loading and before itialized
     */
    virtual void OnBeforeWorldInitialized() { }
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
            LOG_ERROR("maps.script", "Invalid MapScript for %u; no such map ID.", _mapId);
    }

    // Gets the MapEntry structure associated with this script. Can return nullptr.
    auto GetEntry() -> MapEntry const* { return _mapEntry; }

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
    [[nodiscard]] auto isAfterLoadScript() const -> bool override { return true; }

    void checkValidity() override
    {
        checkMap();

        if (GetEntry() && !GetEntry()->IsWorldMap())
            LOG_ERROR("maps.script", "WorldMapScript for map %u is invalid.", GetEntry()->MapID);
    }
};

class InstanceMapScript : public ScriptObject, public MapScript<InstanceMap>
{
protected:
    InstanceMapScript(const char* name, uint32 mapId);

public:
    [[nodiscard]] auto IsDatabaseBound() const -> bool override { return true; }

    void checkValidity() override
    {
        checkMap();

        if (GetEntry() && !GetEntry()->IsDungeon())
            LOG_ERROR("maps.script", "InstanceMapScript for map %u is invalid.", GetEntry()->MapID);
    }

    // Gets an InstanceScript object for this instance.
    virtual auto GetInstanceScript(InstanceMap* /*map*/) const -> InstanceScript* { return nullptr; }
};

class BattlegroundMapScript : public ScriptObject, public MapScript<BattlegroundMap>
{
protected:
    BattlegroundMapScript(const char* name, uint32 mapId);

public:
    [[nodiscard]] auto isAfterLoadScript() const -> bool override { return true; }

    void checkValidity() override
    {
        checkMap();

        if (GetEntry() && !GetEntry()->IsBattleground())
            LOG_ERROR("maps.script", "BattlegroundMapScript for map %u is invalid.", GetEntry()->MapID);
    }
};

class ItemScript : public ScriptObject
{
protected:
    ItemScript(const char* name);

public:
    [[nodiscard]] auto IsDatabaseBound() const -> bool override { return true; }

    // Called when a player accepts a quest from the item.
    [[nodiscard]] virtual auto OnQuestAccept(Player* /*player*/, Item* /*item*/, Quest const* /*quest*/) -> bool { return false; }

    // Called when a player uses the item.
    [[nodiscard]] virtual auto OnUse(Player* /*player*/, Item* /*item*/, SpellCastTargets const& /*targets*/) -> bool { return false; }

    // Called when the item is destroyed.
    [[nodiscard]] virtual auto OnRemove(Player* /*player*/, Item* /*item*/) -> bool { return false; }

    // Called before casting a combat spell from this item (chance on hit spells of item template, can be used to prevent cast if returning false)
    [[nodiscard]] virtual auto OnCastItemCombatSpell(Player* /*player*/, Unit* /*victim*/, SpellInfo const* /*spellInfo*/, Item* /*item*/) -> bool { return true; }

    // Called when the item expires (is destroyed).
    [[nodiscard]] virtual auto OnExpire(Player* /*player*/, ItemTemplate const* /*proto*/) -> bool { return false; }

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
    virtual auto DealDamage(Unit* /*AttackerUnit*/, Unit* /*pVictim*/, uint32 damage, DamageEffectType /*damagetype*/) -> uint32 { return damage; }

    virtual void OnBeforeRollMeleeOutcomeAgainst(const Unit* /*attacker*/, const Unit* /*victim*/, WeaponAttackType /*attType*/, int32& /*attackerMaxSkillValueForLevel*/, int32& /*victimMaxSkillValueForLevel*/, int32& /*attackerWeaponSkill*/, int32& /*victimDefenseSkill*/, int32& /*crit_chance*/, int32& /*miss_chance*/, int32& /*dodge_chance*/, int32& /*parry_chance*/, int32& /*block_chance*/ ) {   };

    virtual void OnAuraRemove(Unit* /*unit*/, AuraApplication* /*aurApp*/, AuraRemoveMode /*mode*/) { }

    [[nodiscard]] virtual auto IfNormalReaction(Unit const* /*unit*/, Unit const* /*target*/, ReputationRank& /*repRank*/) -> bool { return true; }

    [[nodiscard]] virtual auto IsNeedModSpellDamagePercent(Unit const* /*unit*/, AuraEffect* /*auraEff*/, float& /*doneTotalMod*/, SpellInfo const* /*spellProto*/) -> bool { return true; }

    [[nodiscard]] virtual auto IsNeedModMeleeDamagePercent(Unit const* /*unit*/, AuraEffect* /*auraEff*/, float& /*doneTotalMod*/, SpellInfo const* /*spellProto*/) -> bool { return true; }

    [[nodiscard]] virtual auto IsNeedModHealPercent(Unit const* /*unit*/, AuraEffect* /*auraEff*/, float& /*doneTotalMod*/, SpellInfo const* /*spellProto*/) -> bool { return true; }

    [[nodiscard]] virtual auto CanSetPhaseMask(Unit const* /*unit*/, uint32 /*newPhaseMask*/, bool /*update*/) -> bool { return true; }

    [[nodiscard]] virtual auto IsCustomBuildValuesUpdate(Unit const* /*unit*/, uint8 /*updateType*/, ByteBuffer& /*fieldBuffer*/, Player const* /*target*/, uint16 /*index*/) -> bool { return false; }

    [[nodiscard]] virtual auto OnBuildValuesUpdate(Unit const* /*unit*/, uint8 /*updateType*/, ByteBuffer& /*fieldBuffer*/, Player* /*target*/, uint16 /*index*/) -> bool { return false; }

    /**
     * @brief This hook runs in Unit::Update
     *
     * @param unit Contains information about the Unit
     * @param diff Contains information about the diff time
     */
    virtual void OnUnitUpdate(Unit* /*unit*/, uint32 /*diff*/) { }
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
    /**
     * @brief This hook called when a player enters any Map
     *
     * @param map Contains information about the Map
     * @param player Contains information about the Player
     */
    virtual void OnPlayerEnterAll(Map* /*map*/, Player* /*player*/) { }

    /**
     * @brief This hook called when a player leave any Map
     *
     * @param map Contains information about the Map
     * @param player Contains information about the Player
     */
    virtual void OnPlayerLeaveAll(Map* /*map*/, Player* /*player*/) { }

    /**
     * @brief This hook called before create instance script
     *
     * @param instanceMap Contains information about the WorldSession
     * @param instanceData Contains information about the WorldPacket
     * @param load if true loading instance save data
     * @param data Contains information about the instance save data
     * @param completedEncounterMask Contains information about the completed encouter mask
     */
    virtual void OnBeforeCreateInstanceScript(InstanceMap* /*instanceMap*/, InstanceScript* /*instanceData*/, bool /*load*/, std::string /*data*/, uint32 /*completedEncounterMask*/) { }

    /**
     * @brief This hook called before destroy instance
     *
     * @param mapInstanced Contains information about the MapInstanced
     * @param map Contains information about the Map
     */
    virtual void OnDestroyInstance(MapInstanced* /*mapInstanced*/, Map* /*map*/) { }

    /**
     * @brief This hook called before creating map
     *
     * @param map Contains information about the Map
     */
    virtual void OnCreateMap(Map* /*map*/) { }

    /**
     * @brief This hook called before destroing map
     *
     * @param map Contains information about the Map
     */
    virtual void OnDestroyMap(Map* /*map*/) { }

    /**
     * @brief This hook called before updating map
     *
     * @param map Contains information about the Map
     * @param diff Contains information about the diff time
     */
    virtual void OnMapUpdate(Map* /*map*/, uint32 /*diff*/) { }
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

    /**
     * @brief This hook runs after add creature in world
     *
     * @param creature Contains information about the Creature
     */
    virtual void OnCreatureAddWorld(Creature* /*creature*/) { }

    /**
     * @brief This hook runs after remove creature in world
     *
     * @param creature Contains information about the Creature
     */
    virtual void OnCreatureRemoveWorld(Creature* /*creature*/) { }

    /**
     * @brief This hook called when a player opens a gossip dialog with the creature.
     *
     * @param player Contains information about the Player
     * @param creature Contains information about the Creature
     *
     * @return False if you want to continue, true if you want to disable
     */
    [[nodiscard]] virtual auto CanCreatureGossipHello(Player* /*player*/, Creature* /*creature*/) -> bool { return false; }

    /**
     * @brief This hook called when a player selects a gossip item in the creature's gossip menu.
     *
     * @param player Contains information about the Player
     * @param creature Contains information about the Creature
     * @param sender Contains information about the sender type
     * @param action Contains information about the action id
     *
     * @return False if you want to continue, true if you want to disable
     */
    [[nodiscard]] virtual auto CanCreatureGossipSelect(Player* /*player*/, Creature* /*creature*/, uint32 /*sender*/, uint32 /*action*/) -> bool { return false; }

    /**
     * @brief This hook called when a player selects a gossip with a code in the creature's gossip menu.
     *
     * @param player Contains information about the Player
     * @param creature Contains information about the Creature
     * @param sender Contains information about the sender type
     * @param action Contains information about the action id
     * @param code Contains information about the code entered
     *
     * @return True if you want to continue, false if you want to disable
     */
    [[nodiscard]] virtual auto CanCreatureGossipSelectCode(Player* /*player*/, Creature* /*creature*/, uint32 /*sender*/, uint32 /*action*/, const char* /*code*/) -> bool { return false; }

    // Called when a player accepts a quest from the creature.
    [[nodiscard]] virtual auto CanCreatureQuestAccept(Player* /*player*/, Creature* /*creature*/, Quest const* /*quest*/) -> bool { return false; }

    // Called when a player selects a quest reward.
    [[nodiscard]] virtual auto CanCreatureQuestReward(Player* /*player*/, Creature* /*creature*/, Quest const* /*quest*/, uint32 /*opt*/) -> bool { return false; }

    // Called when a CreatureAI object is needed for the creature.
    [[nodiscard]] virtual auto GetCreatureAI(Creature* /*creature*/) const -> CreatureAI* { return nullptr; }
};

class AllItemScript : public ScriptObject
{
protected:
    AllItemScript(const char* name);

public:
    // Called when a player accepts a quest from the item.
    [[nodiscard]] virtual auto CanItemQuestAccept(Player* /*player*/, Item* /*item*/, Quest const* /*quest*/) -> bool { return true; }

    // Called when a player uses the item.
    [[nodiscard]] virtual auto CanItemUse(Player* /*player*/, Item* /*item*/, SpellCastTargets const& /*targets*/) -> bool { return false; }

    // Called when the item is destroyed.
    [[nodiscard]] virtual auto CanItemRemove(Player* /*player*/, Item* /*item*/) -> bool { return true; }

    // Called when the item expires (is destroyed).
    [[nodiscard]] virtual auto CanItemExpire(Player* /*player*/, ItemTemplate const* /*proto*/) -> bool { return true; }

    // Called when a player selects an option in an item gossip window
    virtual void OnItemGossipSelect(Player* /*player*/, Item* /*item*/, uint32 /*sender*/, uint32 /*action*/) { }

    // Called when a player selects an option in an item gossip window
    virtual void OnItemGossipSelectCode(Player* /*player*/, Item* /*item*/, uint32 /*sender*/, uint32 /*action*/, const char* /*code*/) { }
};

class AllGameObjectScript : public ScriptObject
{
protected:
    AllGameObjectScript(const char* name);

public:
    /**
     * @brief This hook runs after add game object in world
     *
     * @param go Contains information about the GameObject
     */
    virtual void OnGameObjectAddWorld(GameObject* /*go*/) { }

    /**
     * @brief This hook runs after remove game object in world
     *
     * @param go Contains information about the GameObject
     */
    virtual void OnGameObjectRemoveWorld(GameObject* /*go*/) { }

    /**
     * @brief This hook runs after remove game object in world
     *
     * @param go Contains information about the GameObject
     */
    virtual void OnGameObjectUpdate(GameObject* /*go*/, uint32 /*diff*/) { }

    // Called when a player opens a gossip dialog with the gameobject.
    [[nodiscard]] virtual auto CanGameObjectGossipHello(Player* /*player*/, GameObject* /*go*/) -> bool { return false; }

    // Called when a player selects a gossip item in the gameobject's gossip menu.
    [[nodiscard]] virtual auto CanGameObjectGossipSelect(Player* /*player*/, GameObject* /*go*/, uint32 /*sender*/, uint32 /*action*/) -> bool { return false; }

    // Called when a player selects a gossip with a code in the gameobject's gossip menu.
    [[nodiscard]] virtual auto CanGameObjectGossipSelectCode(Player* /*player*/, GameObject* /*go*/, uint32 /*sender*/, uint32 /*action*/, const char* /*code*/) -> bool { return false; }

    // Called when a player accepts a quest from the gameobject.
    [[nodiscard]] virtual auto CanGameObjectQuestAccept(Player* /*player*/, GameObject* /*go*/, Quest const* /*quest*/) -> bool { return false; }

    // Called when a player selects a quest reward.
    [[nodiscard]] virtual auto CanGameObjectQuestReward(Player* /*player*/, GameObject* /*go*/, Quest const* /*quest*/, uint32 /*opt*/) -> bool { return false; }

    // Called when the game object is destroyed (destructible buildings only).
    virtual void OnGameObjectDestroyed(GameObject* /*go*/, Player* /*player*/) { }

    // Called when the game object is damaged (destructible buildings only).
    virtual void OnGameObjectDamaged(GameObject* /*go*/, Player* /*player*/) { }

    // Called when the game object loot state is changed.
    virtual void OnGameObjectLootStateChanged(GameObject* /*go*/, uint32 /*state*/, Unit* /*unit*/) { }

    // Called when the game object state is changed.
    virtual void OnGameObjectStateChanged(GameObject* /*go*/, uint32 /*state*/) { }

    // Called when a GameObjectAI object is needed for the gameobject.
    virtual auto GetGameObjectAI(GameObject* /*go*/) const -> GameObjectAI* { return nullptr; }
};

class CreatureScript : public ScriptObject, public UpdatableScript<Creature>
{
protected:
    CreatureScript(const char* name);

public:
    [[nodiscard]] auto IsDatabaseBound() const -> bool override { return true; }

    // Called when a player opens a gossip dialog with the creature.
    [[nodiscard]] virtual auto OnGossipHello(Player* /*player*/, Creature* /*creature*/) -> bool { return false; }

    // Called when a player selects a gossip item in the creature's gossip menu.
    [[nodiscard]] virtual auto OnGossipSelect(Player* /*player*/, Creature* /*creature*/, uint32 /*sender*/, uint32 /*action*/) -> bool { return false; }

    // Called when a player selects a gossip with a code in the creature's gossip menu.
    [[nodiscard]] virtual auto OnGossipSelectCode(Player* /*player*/, Creature* /*creature*/, uint32 /*sender*/, uint32 /*action*/, const char* /*code*/) -> bool { return false; }

    // Called when a player accepts a quest from the creature.
    [[nodiscard]] virtual auto OnQuestAccept(Player* /*player*/, Creature* /*creature*/, Quest const* /*quest*/) -> bool { return false; }

    // Called when a player selects a quest in the creature's quest menu.
    [[nodiscard]] virtual auto OnQuestSelect(Player* /*player*/, Creature* /*creature*/, Quest const* /*quest*/) -> bool { return false; }

    // Called when a player completes a quest with the creature.
    [[nodiscard]] virtual auto OnQuestComplete(Player* /*player*/, Creature* /*creature*/, Quest const* /*quest*/) -> bool { return false; }

    // Called when a player selects a quest reward.
    [[nodiscard]] virtual auto OnQuestReward(Player* /*player*/, Creature* /*creature*/, Quest const* /*quest*/, uint32 /*opt*/) -> bool { return false; }

    // Called when the dialog status between a player and the creature is requested.
    virtual auto GetDialogStatus(Player* /*player*/, Creature* /*creature*/) -> uint32 { return DIALOG_STATUS_SCRIPTED_NO_STATUS; }

    // Called when a CreatureAI object is needed for the creature.
    virtual auto GetAI(Creature* /*creature*/) const -> CreatureAI* { return nullptr; }
};

class GameObjectScript : public ScriptObject, public UpdatableScript<GameObject>
{
protected:
    GameObjectScript(const char* name);

public:
    [[nodiscard]] auto IsDatabaseBound() const -> bool override { return true; }

    // Called when a player opens a gossip dialog with the gameobject.
    [[nodiscard]] virtual auto OnGossipHello(Player* /*player*/, GameObject* /*go*/) -> bool { return false; }

    // Called when a player selects a gossip item in the gameobject's gossip menu.
    [[nodiscard]] virtual auto OnGossipSelect(Player* /*player*/, GameObject* /*go*/, uint32 /*sender*/, uint32 /*action*/) -> bool { return false; }

    // Called when a player selects a gossip with a code in the gameobject's gossip menu.
    [[nodiscard]] virtual auto OnGossipSelectCode(Player* /*player*/, GameObject* /*go*/, uint32 /*sender*/, uint32 /*action*/, const char* /*code*/) -> bool { return false; }

    // Called when a player accepts a quest from the gameobject.
    [[nodiscard]] virtual auto OnQuestAccept(Player* /*player*/, GameObject* /*go*/, Quest const* /*quest*/) -> bool { return false; }

    // Called when a player selects a quest reward.
    [[nodiscard]] virtual auto OnQuestReward(Player* /*player*/, GameObject* /*go*/, Quest const* /*quest*/, uint32 /*opt*/) -> bool { return false; }

    // Called when the dialog status between a player and the gameobject is requested.
    virtual auto GetDialogStatus(Player* /*player*/, GameObject* /*go*/) -> uint32 { return DIALOG_STATUS_SCRIPTED_NO_STATUS; }

    // Called when the game object is destroyed (destructible buildings only).
    virtual void OnDestroyed(GameObject* /*go*/, Player* /*player*/) { }

    // Called when the game object is damaged (destructible buildings only).
    virtual void OnDamaged(GameObject* /*go*/, Player* /*player*/) { }

    // Called when the game object loot state is changed.
    virtual void OnLootStateChanged(GameObject* /*go*/, uint32 /*state*/, Unit* /*unit*/) { }

    // Called when the game object state is changed.
    virtual void OnGameObjectStateChanged(GameObject* /*go*/, uint32 /*state*/) { }

    // Called when a GameObjectAI object is needed for the gameobject.
    virtual auto GetAI(GameObject* /*go*/) const -> GameObjectAI* { return nullptr; }
};

class AreaTriggerScript : public ScriptObject
{
protected:
    AreaTriggerScript(const char* name);

public:
    [[nodiscard]] auto IsDatabaseBound() const -> bool override { return true; }

    // Called when the area trigger is activated by a player.
    [[nodiscard]] virtual auto OnTrigger(Player* /*player*/, AreaTrigger const* /*trigger*/) -> bool { return false; }
};

class OnlyOnceAreaTriggerScript : public AreaTriggerScript
{
    using AreaTriggerScript::AreaTriggerScript;

public:
    [[nodiscard]] auto OnTrigger(Player* /*player*/, AreaTrigger const* /*trigger*/) -> bool override;

protected:
    virtual auto _OnTrigger(Player* /*player*/, AreaTrigger const* /*trigger*/) -> bool = 0;
    void ResetAreaTriggerDone(InstanceScript* /*instance*/, uint32 /*triggerId*/);
    void ResetAreaTriggerDone(Player const* /*player*/, AreaTrigger const* /*trigger*/);
};

class BattlegroundScript : public ScriptObject
{
protected:
    BattlegroundScript(const char* name);

public:
    [[nodiscard]] auto IsDatabaseBound() const -> bool override { return true; }

    // Should return a fully valid Battleground object for the type ID.
    [[nodiscard]] virtual auto GetBattleground() const -> Battleground* = 0;
};

class OutdoorPvPScript : public ScriptObject
{
protected:
    OutdoorPvPScript(const char* name);

public:
    [[nodiscard]] auto IsDatabaseBound() const -> bool override { return true; }

    // Should return a fully valid OutdoorPvP object for the type ID.
    [[nodiscard]] virtual auto GetOutdoorPvP() const -> OutdoorPvP* = 0;
};

class CommandScript : public ScriptObject
{
protected:
    CommandScript(const char* name);

public:
    // Should return a pointer to a valid command table (ChatCommand array) to be used by ChatHandler.
    [[nodiscard]] virtual auto GetCommands() const -> std::vector<Acore::ChatCommands::ChatCommandBuilder> = 0;
};

class WeatherScript : public ScriptObject, public UpdatableScript<Weather>
{
protected:
    WeatherScript(const char* name);

public:
    [[nodiscard]] auto IsDatabaseBound() const -> bool override { return true; }

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
    [[nodiscard]] auto IsDatabaseBound() const -> bool override { return true; }

    // Called when a single condition is checked for a player.
    [[nodiscard]] virtual auto OnConditionCheck(Condition* /*condition*/, ConditionSourceInfo& /*sourceInfo*/) -> bool { return true; }
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
    [[nodiscard]] auto IsDatabaseBound() const -> bool override { return true; }

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
    [[nodiscard]] auto IsDatabaseBound() const -> bool override { return true; }

    [[nodiscard]] virtual auto OnCheck(Player* /*source*/, Unit* /*target*/, uint32 /*criteria_id*/) -> bool { return true; };
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

    // Called when a player toggles pvp
    virtual void OnPlayerPVPFlagChange(Player* /*player*/, bool /*state*/) { }

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
    [[nodiscard]] virtual auto OnBeforeTeleport(Player* /*player*/, uint32 /*mapid*/, float /*x*/, float /*y*/, float /*z*/, float /*orientation*/, uint32 /*options*/, Unit* /*target*/) -> bool { return true; }

    // Called when team/faction is set on player
    virtual void OnUpdateFaction(Player* /*player*/) { }

    // Called when a player is added to battleground
    virtual void OnAddToBattleground(Player* /*player*/, Battleground* /*bg*/) { }

    // Called when a player queues a Random Dungeon using the RDF (Random Dungeon Finder)
    virtual void OnQueueRandomDungeon(Player* /*player*/, uint32 & /*rDungeonId*/) { }

    // Called when a player is removed from battleground
    virtual void OnRemoveFromBattleground(Player* /*player*/, Battleground* /*bg*/) { }

    // Called when a player complete an achievement
    virtual void OnAchiComplete(Player* /*player*/, AchievementEntry const* /*achievement*/) { }

    // Called before player complete an achievement, can be used to disable achievements in certain conditions
    virtual auto OnBeforeAchiComplete(Player* /*player*/, AchievementEntry const* /*achievement*/) -> bool { return true; }

    // Called when a player complete an achievement criteria
    virtual void OnCriteriaProgress(Player* /*player*/, AchievementCriteriaEntry const* /*criteria*/) { }

    //  Called before player complete an achievement criteria, can be used to disable achievement criteria in certain conditions
    virtual auto OnBeforeCriteriaProgress(Player* /*player*/, AchievementCriteriaEntry const* /*criteria*/) -> bool { return true; }

    // Called when an Achievement is saved to DB
    virtual void OnAchiSave(CharacterDatabaseTransaction /*trans*/, Player* /*player*/, uint16 /*achId*/, CompletedAchievementData /*achiData*/) { }

    // Called when an Criteria is saved to DB
    virtual void OnCriteriaSave(CharacterDatabaseTransaction /*trans*/, Player* /*player*/, uint16 /*achId*/, CriteriaProgress /*criteriaData*/) { }

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
    [[nodiscard]] virtual auto OnBeforeQuestComplete(Player* /*player*/, uint32 /*quest_id*/) -> bool { return true; }

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

    [[nodiscard]] virtual auto CanJoinInBattlegroundQueue(Player* /*player*/, ObjectGuid /*BattlemasterGuid*/, BattlegroundTypeId /*BGTypeID*/, uint8 /*joinAsGroup*/, GroupJoinBattlegroundResult& /*err*/) -> bool { return true; }
    virtual auto ShouldBeRewardedWithMoneyInsteadOfExp(Player* /*player*/) -> bool { return false; }

    // Called before the player's temporary summoned creature has initialized it's stats
    virtual void OnBeforeTempSummonInitStats(Player* /*player*/, TempSummon* /*tempSummon*/, uint32& /*duration*/) { }

    // Called before the player's guardian / pet has initialized it's stats for the player's level
    virtual void OnBeforeGuardianInitStatsForLevel(Player* /*player*/, Guardian* /*guardian*/, CreatureTemplate const* /*cinfo*/, PetType& /*petType*/) { }

    // Called after the player's guardian / pet has initialized it's stats for the player's level
    virtual void OnAfterGuardianInitStatsForLevel(Player* /*player*/, Guardian* /*guardian*/) { }

    // Called before loading a player's pet from the DB
    virtual void OnBeforeLoadPetFromDB(Player* /*player*/, uint32& /*petentry*/, uint32& /*petnumber*/, bool& /*current*/, bool& /*forceLoadFromDB*/) { }

    [[nodiscard]] virtual auto CanJoinInArenaQueue(Player* /*player*/, ObjectGuid /*BattlemasterGuid*/, uint8 /*arenaslot*/, BattlegroundTypeId /*BGTypeID*/, uint8 /*joinAsGroup*/, uint8 /*IsRated*/, GroupJoinBattlegroundResult& /*err*/) -> bool { return true; }

    [[nodiscard]] virtual auto CanBattleFieldPort(Player* /*player*/, uint8 /*arenaType*/, BattlegroundTypeId /*BGTypeID*/, uint8 /*action*/) -> bool { return true; }

    [[nodiscard]] virtual auto CanGroupInvite(Player* /*player*/, std::string& /*membername*/) -> bool { return true; }

    [[nodiscard]] virtual auto CanGroupAccept(Player* /*player*/, Group* /*group*/) -> bool { return true; }

    [[nodiscard]] virtual auto CanSellItem(Player* /*player*/, Item* /*item*/, Creature* /*creature*/) -> bool { return true; }

    [[nodiscard]] virtual auto CanSendMail(Player* /*player*/, ObjectGuid /*receiverGuid*/, ObjectGuid /*mailbox*/, std::string& /*subject*/, std::string& /*body*/, uint32 /*money*/, uint32 /*COD*/, Item* /*item*/) -> bool { return true; }

    virtual void PetitionBuy(Player* /*player*/, Creature* /*creature*/, uint32& /*charterid*/, uint32& /*cost*/, uint32& /*type*/) { }

    virtual void PetitionShowList(Player* /*player*/, Creature* /*creature*/, uint32& /*CharterEntry*/, uint32& /*CharterDispayID*/, uint32& /*CharterCost*/) { }

    virtual void OnRewardKillRewarder(Player* /*player*/, bool /*isDungeon*/, float& /*rate*/) { }

    [[nodiscard]] virtual auto CanGiveMailRewardAtGiveLevel(Player* /*player*/, uint8 /*level*/) -> bool { return true; }

    virtual void OnDeleteFromDB(CharacterDatabaseTransaction /*trans*/, uint32 /*guid*/) { }

    [[nodiscard]] virtual auto CanRepopAtGraveyard(Player* /*player*/) -> bool { return true; }

    virtual void OnGetMaxSkillValue(Player* /*player*/, uint32 /*skill*/, int32& /*result*/, bool /*IsPure*/) { }

    [[nodiscard]] virtual auto CanAreaExploreAndOutdoor(Player* /*player*/) -> bool { return true; }

    virtual void OnVictimRewardBefore(Player* /*player*/, Player* /*victim*/, uint32& /*killer_title*/, uint32& /*victim_title*/) { }

    virtual void OnVictimRewardAfter(Player* /*player*/, Player* /*victim*/, uint32& /*killer_title*/, uint32& /*victim_rank*/, float& /*honor_f*/) { }

    virtual void OnCustomScalingStatValueBefore(Player* /*player*/, ItemTemplate const* /*proto*/, uint8 /*slot*/, bool /*apply*/, uint32& /*CustomScalingStatValue*/) { }

    virtual void OnCustomScalingStatValue(Player* /*player*/, ItemTemplate const* /*proto*/, uint32& /*statType*/, int32& /*val*/, uint8 /*itemProtoStatNumber*/, uint32 /*ScalingStatValue*/, ScalingStatValuesEntry const* /*ssv*/) { }

    [[nodiscard]] virtual auto CanArmorDamageModifier(Player* /*player*/) -> bool { return true; }

    virtual void OnGetFeralApBonus(Player* /*player*/, int32& /*feral_bonus*/, int32 /*dpsMod*/, ItemTemplate const* /*proto*/, ScalingStatValuesEntry const* /*ssv*/) { }

    [[nodiscard]] virtual auto CanApplyWeaponDependentAuraDamageMod(Player* /*player*/, Item* /*item*/, WeaponAttackType /*attackType*/, AuraEffect const* /*aura*/, bool /*apply*/) -> bool { return true; }

    [[nodiscard]] virtual auto CanApplyEquipSpell(Player* /*player*/, SpellInfo const* /*spellInfo*/, Item* /*item*/, bool /*apply*/, bool /*form_change*/) -> bool { return true; }

    [[nodiscard]] virtual auto CanApplyEquipSpellsItemSet(Player* /*player*/, ItemSetEffect* /*eff*/) -> bool { return true; }

    [[nodiscard]] virtual auto CanCastItemCombatSpell(Player* /*player*/, Unit* /*target*/, WeaponAttackType /*attType*/, uint32 /*procVictim*/, uint32 /*procEx*/, Item* /*item*/, ItemTemplate const* /*proto*/) -> bool { return true; }

    [[nodiscard]] virtual auto CanCastItemUseSpell(Player* /*player*/, Item* /*item*/, SpellCastTargets const& /*targets*/, uint8 /*cast_count*/, uint32 /*glyphIndex*/) -> bool { return true; }

    virtual void OnApplyAmmoBonuses(Player* /*player*/, ItemTemplate const* /*proto*/, float& /*currentAmmoDPS*/) { }

    [[nodiscard]] virtual auto CanEquipItem(Player* /*player*/, uint8 /*slot*/, uint16& /*dest*/, Item* /*pItem*/, bool /*swap*/, bool /*not_loading*/) -> bool { return true; }

    [[nodiscard]] virtual auto CanUnequipItem(Player* /*player*/, uint16 /*pos*/, bool /*swap*/) -> bool { return true; }

    [[nodiscard]] virtual auto CanUseItem(Player* /*player*/, ItemTemplate const* /*proto*/, InventoryResult& /*result*/) -> bool { return true; }

    [[nodiscard]] virtual auto CanSaveEquipNewItem(Player* /*player*/, Item* /*item*/, uint16 /*pos*/, bool /*update*/) -> bool { return true; }

    [[nodiscard]] virtual auto CanApplyEnchantment(Player* /*player*/, Item* /*item*/, EnchantmentSlot /*slot*/, bool /*apply*/, bool /*apply_dur*/, bool /*ignore_condition*/) -> bool { return true; }

    virtual void OnGetQuestRate(Player* /*player*/, float& /*result*/) { }

    [[nodiscard]] virtual auto PassedQuestKilledMonsterCredit(Player* /*player*/, Quest const* /*qinfo*/, uint32 /*entry*/, uint32 /*real_entry*/, ObjectGuid /*guid*/) -> bool { return true; }

    [[nodiscard]] virtual auto CheckItemInSlotAtLoadInventory(Player* /*player*/, Item* /*item*/, uint8 /*slot*/, uint8& /*err*/, uint16& /*dest*/) -> bool { return true; }

    [[nodiscard]] virtual auto NotAvoidSatisfy(Player* /*player*/, DungeonProgressionRequirements const* /*ar*/, uint32 /*target_map*/, bool /*report*/) -> bool { return true; }

    [[nodiscard]] virtual auto NotVisibleGloballyFor(Player* /*player*/, Player const* /*u*/) -> bool { return true; }

    virtual void OnGetArenaPersonalRating(Player* /*player*/, uint8 /*slot*/, uint32& /*result*/) { }

    virtual void OnGetArenaTeamId(Player* /*player*/, uint8 /*slot*/, uint32& /*result*/) { }

    virtual void OnIsFFAPvP(Player* /*player*/, bool& /*result*/) { }

    virtual void OnIsPvP(Player* /*player*/, bool& /*result*/) { }

    virtual void OnGetMaxSkillValueForLevel(Player* /*player*/, uint16& /*result*/) { }

    [[nodiscard]] virtual auto NotSetArenaTeamInfoField(Player* /*player*/, uint8 /*slot*/, ArenaTeamInfoType /*type*/, uint32 /*value*/) -> bool { return true; }

    [[nodiscard]] virtual auto CanJoinLfg(Player* /*player*/, uint8 /*roles*/, lfg::LfgDungeonSet& /*dungeons*/, const std::string& /*comment*/) -> bool { return true; }

    [[nodiscard]] virtual auto CanEnterMap(Player* /*player*/, MapEntry const* /*entry*/, InstanceTemplate const* /*instance*/, MapDifficulty const* /*mapDiff*/, bool /*loginCheck*/) -> bool { return true; }

    [[nodiscard]] virtual auto CanInitTrade(Player* /*player*/, Player* /*target*/) -> bool { return true; }

    virtual void OnSetServerSideVisibility(Player* /*player*/, ServerSideVisibilityType& /*type*/, AccountTypes& /*sec*/) { }

    virtual void OnSetServerSideVisibilityDetect(Player* /*player*/, ServerSideVisibilityType& /*type*/, AccountTypes& /*sec*/) { }

    virtual void OnPlayerResurrect(Player* /*player*/, float /*restore_percent*/, bool /*applySickness*/) { }

    /**
     * @brief This hook called before player sending message in default chat
     *
     * @param player Contains information about the Player sender
     * @param type Contains information about the chat message type
     * @param language Contains information about the language type
     * @param msg Contains information about the message
     *
     * @return True if you want to continue sending the message, false if you want to disable sending the message
     */
    [[nodiscard]] virtual auto CanPlayerUseChat(Player* /*player*/, uint32 /*type*/, uint32 /*language*/, std::string& /*msg*/) -> bool { return true; }

    /**
     * @brief This hook called before player sending message to other player via private
     *
     * @param player Contains information about the Player sender
     * @param type Contains information about the chat message type
     * @param language Contains information about the language type
     * @param msg Contains information about the message
     * @param receiver Contains information about the Player receiver
     *
     * @return True if you want to continue sending the message, false if you want to disable sending the message
     */
    [[nodiscard]] virtual auto CanPlayerUseChat(Player* /*player*/, uint32 /*type*/, uint32 /*language*/, std::string& /*msg*/, Player* /*receiver*/) -> bool { return true; }

    /**
     * @brief This hook called before player sending message to group
     *
     * @param player Contains information about the Player sender
     * @param type Contains information about the chat message type
     * @param language Contains information about the language type
     * @param msg Contains information about the message
     * @param group Contains information about the Group
     *
     * @return True if you want to continue sending the message, false if you want to disable sending the message
     */
    [[nodiscard]] virtual auto CanPlayerUseChat(Player* /*player*/, uint32 /*type*/, uint32 /*language*/, std::string& /*msg*/, Group* /*group*/) -> bool { return true; }

    /**
     * @brief This hook called before player sending message to guild
     *
     * @param player Contains information about the Player sender
     * @param type Contains information about the chat message type
     * @param language Contains information about the language type
     * @param msg Contains information about the message
     * @param guild Contains information about the Guild
     *
     * @return True if you want to continue sending the message, false if you want to disable sending the message
     */
    [[nodiscard]] virtual auto CanPlayerUseChat(Player* /*player*/, uint32 /*type*/, uint32 /*language*/, std::string& /*msg*/, Guild* /*guild*/) -> bool { return true; }

    /**
     * @brief This hook called before player sending message to channel
     *
     * @param player Contains information about the Player sender
     * @param type Contains information about the chat message type
     * @param language Contains information about the language type
     * @param msg Contains information about the message
     * @param channel Contains information about the Channel
     *
     * @return True if you want to continue sending the message, false if you want to disable sending the message
     */
    [[nodiscard]] virtual auto CanPlayerUseChat(Player* /*player*/, uint32 /*type*/, uint32 /*language*/, std::string& /*msg*/, Channel* /*channel*/) -> bool { return true; }

    /**
     * @brief This hook called after player learning talents
     *
     * @param player Contains information about the Player
     * @param talentId Contains information about the talent id
     * @param talentRank Contains information about the talent rank
     * @param spellid Contains information about the spell id
     */
    virtual void OnPlayerLearnTalents(Player* /*player*/, uint32 /*talentId*/, uint32 /*talentRank*/, uint32 /*spellid*/) { }

    /**
     * @brief This hook called after player entering combat
     *
     * @param player Contains information about the Player
     * @param Unit Contains information about the Unit
     */
    virtual void OnPlayerEnterCombat(Player* /*player*/, Unit* /*enemy*/) { }

    /**
     * @brief This hook called after player leave combat
     *
     * @param player Contains information about the Player
     */
    virtual void OnPlayerLeaveCombat(Player* /*player*/) { }

    /**
     * @brief This hook called after player abandoning quest
     *
     * @param player Contains information about the Player
     * @param questId Contains information about the quest id
     */
    virtual void OnQuestAbandon(Player* /*player*/, uint32 /*questId*/) { }

    // Passive Anticheat System
    virtual void AnticheatSetSkipOnePacketForASH(Player* /*player*/, bool /*apply*/) { }
    virtual void AnticheatSetCanFlybyServer(Player* /*player*/, bool /*apply*/) { }
    virtual void AnticheatSetUnderACKmount(Player* /*player*/) { }
    virtual void AnticheatSetRootACKUpd(Player* /*player*/) { }
    virtual void AnticheatSetJumpingbyOpcode(Player* /*player*/, bool /*jump*/) { }
    virtual void AnticheatUpdateMovementInfo(Player* /*player*/, MovementInfo const& /*movementInfo*/) { }
    [[nodiscard]] virtual auto AnticheatHandleDoubleJump(Player* /*player*/, Unit* /*mover*/) -> bool { return true; }
    [[nodiscard]] virtual auto AnticheatCheckMovementInfo(Player* /*player*/, MovementInfo const& /*movementInfo*/, Unit* /*mover*/, bool /*jump*/) -> bool { return true; }
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
    [[nodiscard]] auto IsDatabaseBound() const -> bool override { return false; }

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

    [[nodiscard]] virtual auto CanGuildSendBankList(Guild const* /*guild*/, WorldSession* /*session*/, uint8 /*tabId*/, bool /*sendAllSlots*/) -> bool { return true; }
};

class GroupScript : public ScriptObject
{
protected:
    GroupScript(const char* name);

public:
    [[nodiscard]] auto IsDatabaseBound() const -> bool override { return false; }

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

    [[nodiscard]] virtual auto CanGroupJoinBattlegroundQueue(Group const* /*group*/, Player* /*member*/, Battleground const* /*bgTemplate*/, uint32 /*MinPlayerCount*/, bool /*isRated*/, uint32 /*arenaSlot*/) -> bool { return true; }

    virtual void OnCreate(Group* /*group*/, Player* /*leader*/) { }
};

// following hooks can be used anywhere and are not db bounded
class GlobalScript : public ScriptObject
{
protected:
    GlobalScript(const char* name);

public:
    // items
    virtual void OnItemDelFromDB(CharacterDatabaseTransaction /*trans*/, ObjectGuid::LowType /*itemGuid*/) { }
    virtual void OnMirrorImageDisplayItem(const Item* /*item*/, uint32& /*display*/) { }

    // loot
    virtual void OnAfterRefCount(Player const* /*player*/, LootStoreItem* /*LootStoreItem*/, Loot& /*loot*/, bool /*canRate*/, uint16 /*lootMode*/, uint32& /*maxcount*/, LootStore const& /*store*/) { }
    virtual void OnBeforeDropAddItem(Player const* /*player*/, Loot& /*loot*/, bool /*canRate*/, uint16 /*lootMode*/, LootStoreItem* /*LootStoreItem*/, LootStore const& /*store*/) { }
    virtual auto OnItemRoll(Player const* /*player*/, LootStoreItem const* /*LootStoreItem*/, float& /*chance*/, Loot& /*loot*/, LootStore const& /*store*/) -> bool { return true; };
    virtual auto OnBeforeLootEqualChanced(Player const* /*player*/, LootStoreItemList /*EqualChanced*/, Loot& /*loot*/, LootStore const& /*store*/) -> bool { return true; }
    virtual void OnInitializeLockedDungeons(Player* /*player*/, uint8& /*level*/, uint32& /*lockData*/, lfg::LFGDungeonData const* /*dungeon*/) { }
    virtual void OnAfterInitializeLockedDungeons(Player* /*player*/) { }

    // On Before arena points distribution
    virtual void OnBeforeUpdateArenaPoints(ArenaTeam* /*at*/, std::map<ObjectGuid, uint32>& /*ap*/) { }

    // Called when a dungeon encounter is updated.
    virtual void OnAfterUpdateEncounterState(Map* /*map*/, EncounterCreditType /*type*/,  uint32 /*creditEntry*/, Unit* /*source*/, Difficulty /*difficulty_fixed*/, DungeonEncounterList const* /*encounters*/, uint32 /*dungeonCompleted*/, bool /*updated*/) { }

    // Called before the phase for a WorldObject is set
    virtual void OnBeforeWorldObjectSetPhaseMask(WorldObject const* /*worldObject*/, uint32& /*oldPhaseMask*/, uint32& /*newPhaseMask*/, bool& /*useCombinedPhases*/, bool& /*update*/) { }

    // Called when checking if a spell is affected by a mod
    virtual auto OnIsAffectedBySpellModCheck(SpellInfo const* /*affectSpell*/, SpellInfo const* /*checkSpell*/, SpellModifier const* /*mod*/) -> bool { return true; };
};

class BGScript : public ScriptObject
{
protected:
    BGScript(const char* name);

public:
    [[nodiscard]] auto IsDatabaseBound() const -> bool override { return false; }

    /**
     * @brief This hook runs before start Battleground
     *
     * @param bg Contains information about the Battleground
     */
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

    [[nodiscard]] virtual auto CanFillPlayersToBG(BattlegroundQueue* /*queue*/, Battleground* /*bg*/, const int32 /*aliFree*/, const int32 /*hordeFree*/, BattlegroundBracketId /*bracket_id*/) -> bool { return true; }

    [[nodiscard]] virtual auto CanFillPlayersToBGWithSpecific(BattlegroundQueue* /*queue*/, Battleground* /*bg*/, const int32 /*aliFree*/, const int32 /*hordeFree*/,
            BattlegroundBracketId /*thisBracketId*/, BattlegroundQueue* /*specificQueue*/, BattlegroundBracketId /*specificBracketId*/) -> bool { return true; }

    virtual void OnCheckNormalMatch(BattlegroundQueue* /*queue*/, uint32& /*Coef*/, Battleground* /*bgTemplate*/, BattlegroundBracketId /*bracket_id*/, uint32& /*minPlayers*/, uint32& /*maxPlayers*/) { }

    [[nodiscard]] virtual auto CanSendMessageBGQueue(BattlegroundQueue* /*queue*/, Player* /*leader*/, Battleground* /*bg*/, PvPDifficultyEntry const* /*bracketEntry*/) -> bool { return true; }

    /**
     * @brief This hook runs before sending the join message during the arena queue, allowing you to run extra operations or disabling the join message
     *
     * @param queue Contains information about the Arena queue
     * @param leader Contains information about the player leader
     * @param ginfo Contains information about the group of the queue
     * @param bracketEntry Contains information about the bracket
     * @param isRated Contains information about rated arena or skirmish
     * @return True if you want to continue sending the message, false if you want to disable the message
     */
    [[nodiscard]] virtual auto OnBeforeSendJoinMessageArenaQueue(BattlegroundQueue* /*queue*/, Player* /*leader*/, GroupQueueInfo* /*ginfo*/, PvPDifficultyEntry const* /*bracketEntry*/, bool /*isRated*/) -> bool { return true; }

    /**
     * @brief This hook runs before sending the exit message during the arena queue, allowing you to run extra operations or disabling the exit message
     *
     * @param queue Contains information about the Arena queue
     * @param ginfo Contains information about the group of the queue
     * @return True if you want to continue sending the message, false if you want to disable the message
     */
    [[nodiscard]] virtual auto OnBeforeSendExitMessageArenaQueue(BattlegroundQueue* /*queue*/, GroupQueueInfo* /*ginfo*/) -> bool { return true; }

    /**
     * @brief This hook runs after end Battleground
     *
     * @param bg Contains information about the Battleground
     * @param TeamId Contains information about the winneer team
     */
    virtual void OnBattlegroundEnd(Battleground* /*bg*/, TeamId /*winner team*/) { }

    /**
     * @brief This hook runs before Battleground destroy
     *
     * @param bg Contains information about the Battleground
     */
    virtual void OnBattlegroundDestroy(Battleground* /*bg*/) { }

    /**
     * @brief This hook runs after Battleground create
     *
     * @param bg Contains information about the Battleground
     */
    virtual void OnBattlegroundCreate(Battleground* /*bg*/) { }
};

class ArenaTeamScript : public ScriptObject
{
protected:
    ArenaTeamScript(const char* name);

public:
    [[nodiscard]] auto IsDatabaseBound() const -> bool override { return false; };

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
    [[nodiscard]] auto IsDatabaseBound() const -> bool override { return false; }

    // Calculate max duration in applying aura
    virtual void OnCalcMaxDuration(Aura const* /*aura*/, int32& /*maxDuration*/) { }

    [[nodiscard]] virtual auto CanModAuraEffectDamageDone(AuraEffect const* /*auraEff*/, Unit* /*target*/, AuraApplication const* /*aurApp*/, uint8 /*mode*/, bool /*apply*/) -> bool { return true; }

    [[nodiscard]] virtual auto CanModAuraEffectModDamagePercentDone(AuraEffect const* /*auraEff*/, Unit* /*target*/, AuraApplication const* /*aurApp*/, uint8 /*mode*/, bool /*apply*/) -> bool { return true; }

    virtual void OnSpellCheckCast(Spell* /*spell*/, bool /*strict*/, SpellCastResult& /*res*/) { }

    [[nodiscard]] virtual auto CanPrepare(Spell* /*spell*/, SpellCastTargets const* /*targets*/, AuraEffect const* /*triggeredByAura*/) -> bool { return true; }

    [[nodiscard]] virtual auto CanScalingEverything(Spell* /*spell*/) -> bool { return false; }

    [[nodiscard]] virtual auto CanSelectSpecTalent(Spell* /*spell*/) -> bool { return true; }

    virtual void OnScaleAuraUnitAdd(Spell* /*spell*/, Unit* /*target*/, uint32 /*effectMask*/, bool /*checkIfValid*/, bool /*implicit*/, uint8 /*auraScaleMask*/, TargetInfo& /*targetInfo*/) { }

    virtual void OnRemoveAuraScaleTargets(Spell* /*spell*/, TargetInfo& /*targetInfo*/, uint8 /*auraScaleMask*/, bool& /*needErase*/) { }

    virtual void OnBeforeAuraRankForLevel(SpellInfo const* /*spellInfo*/, SpellInfo const* /*latestSpellInfo*/, uint8 /*level*/) { }

    /**
     * @brief This hook called after spell dummy effect
     *
     * @param caster Contains information about the WorldObject
     * @param spellID Contains information about the spell id
     * @param effIndex Contains information about the SpellEffIndex
     * @param gameObjTarget Contains information about the GameObject
     */
    virtual void OnDummyEffect(WorldObject* /*caster*/, uint32 /*spellID*/, SpellEffIndex /*effIndex*/, GameObject* /*gameObjTarget*/) { }

    /**
     * @brief This hook called after spell dummy effect
     *
     * @param caster Contains information about the WorldObject
     * @param spellID Contains information about the spell id
     * @param effIndex Contains information about the SpellEffIndex
     * @param creatureTarget Contains information about the Creature
     */
    virtual void OnDummyEffect(WorldObject* /*caster*/, uint32 /*spellID*/, SpellEffIndex /*effIndex*/, Creature* /*creatureTarget*/) { }

    /**
     * @brief This hook called after spell dummy effect
     *
     * @param caster Contains information about the WorldObject
     * @param spellID Contains information about the spell id
     * @param effIndex Contains information about the SpellEffIndex
     * @param itemTarget Contains information about the Item
     */
    virtual void OnDummyEffect(WorldObject* /*caster*/, uint32 /*spellID*/, SpellEffIndex /*effIndex*/, Item* /*itemTarget*/) { }
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

    [[nodiscard]] auto IsDatabaseBound() const -> bool override { return false; }

    // After complete global acvievement
    virtual void SetRealmCompleted(AchievementEntry const* /*achievement*/) { }

    [[nodiscard]] virtual auto IsCompletedCriteria(AchievementMgr* /*mgr*/, AchievementCriteriaEntry const* /*achievementCriteria*/, AchievementEntry const* /*achievement*/, CriteriaProgress const* /*progress*/) -> bool { return true; }

    [[nodiscard]] virtual auto IsRealmCompleted(AchievementGlobalMgr const* /*globalmgr*/, AchievementEntry const* /*achievement*/, std::chrono::system_clock::time_point /*completionTime*/) -> bool { return true; }

    virtual void OnBeforeCheckCriteria(AchievementMgr* /*mgr*/, AchievementCriteriaEntryList const* /*achievementCriteriaList*/) { }

    [[nodiscard]] virtual auto CanCheckCriteria(AchievementMgr* /*mgr*/, AchievementCriteriaEntry const* /*achievementCriteria*/) -> bool { return true; }
};

class PetScript : public ScriptObject
{
protected:

    PetScript(const char* name);

public:

    [[nodiscard]] auto IsDatabaseBound() const -> bool override { return false; }

    virtual void OnInitStatsForLevel(Guardian* /*guardian*/, uint8 /*petlevel*/) { }

    virtual void OnCalculateMaxTalentPointsForLevel(Pet* /*pet*/, uint8 /*level*/, uint8& /*points*/) { }

    [[nodiscard]] virtual auto CanUnlearnSpellSet(Pet* /*pet*/, uint32 /*level*/, uint32 /*spell*/) -> bool { return true; }

    [[nodiscard]] virtual auto CanUnlearnSpellDefault(Pet* /*pet*/, SpellInfo const* /*spellEntry*/) -> bool { return true; }

    [[nodiscard]] virtual auto CanResetTalents(Pet* /*pet*/) -> bool { return true; }

    /**
     * @brief This hook called after add pet in world
     *
     * @param pet Contains information about the Pet
     */
    virtual void OnPetAddToWorld(Pet* /*pet*/) { }
};

class ArenaScript : public ScriptObject
{
protected:

    ArenaScript(const char* name);

public:

    [[nodiscard]] auto IsDatabaseBound() const -> bool override { return false; }

    [[nodiscard]] virtual auto CanAddMember(ArenaTeam* /*team*/, ObjectGuid /*PlayerGuid*/) -> bool { return true; }

    virtual void OnGetPoints(ArenaTeam* /*team*/, uint32 /*memberRating*/, float& /*points*/) { }

    [[nodiscard]] virtual auto CanSaveToDB(ArenaTeam* /*team*/) -> bool { return true; }
};

class MiscScript : public ScriptObject
{
protected:

    MiscScript(const char* name);

public:

    [[nodiscard]] auto IsDatabaseBound() const -> bool override { return false; }

    virtual void OnConstructObject(Object* /*origin*/) { }

    virtual void OnDestructObject(Object* /*origin*/) { }

    virtual void OnConstructPlayer(Player* /*origin*/) { }

    virtual void OnDestructPlayer(Player* /*origin*/) { }

    virtual void OnConstructGroup(Group* /*origin*/) { }

    virtual void OnDestructGroup(Group* /*origin*/) { }

    virtual void OnConstructInstanceSave(InstanceSave* /*origin*/) { }

    virtual void OnDestructInstanceSave(InstanceSave* /*origin*/) { }

    virtual void OnItemCreate(Item* /*item*/, ItemTemplate const* /*itemProto*/, Player const* /*owner*/) { }

    [[nodiscard]] virtual auto CanApplySoulboundFlag(Item* /*item*/, ItemTemplate const* /*proto*/) -> bool { return true; }

    [[nodiscard]] virtual auto CanItemApplyEquipSpell(Player* /*player*/, Item* /*item*/) -> bool { return true; }

    [[nodiscard]] virtual auto CanSendAuctionHello(WorldSession const* /*session*/, ObjectGuid /*guid*/, Creature* /*creature*/) -> bool { return true; }

    virtual void ValidateSpellAtCastSpell(Player* /*player*/, uint32& /*oldSpellId*/, uint32& /*spellId*/, uint8& /*castCount*/, uint8& /*castFlags*/) { }

    virtual void ValidateSpellAtCastSpellResult(Player* /*player*/, Unit* /*mover*/, Spell* /*spell*/, uint32 /*oldSpellId*/, uint32 /*spellId*/) { }

    virtual void OnAfterLootTemplateProcess(Loot* /*loot*/, LootTemplate const* /*tab*/, LootStore const& /*store*/, Player* /*lootOwner*/, bool /*personal*/, bool /*noEmptyError*/, uint16 /*lootMode*/) { }

    virtual void OnPlayerSetPhase(const AuraEffect* /*auraEff*/, AuraApplication const* /*aurApp*/, uint8 /*mode*/, bool /*apply*/, uint32& /*newPhase*/) { }

    virtual void OnInstanceSave(InstanceSave* /*instanceSave*/) { }

    /**
     * @brief This hook called before get Quest Dialog Status
     *
     * @param player Contains information about the Player
     * @param questgiver Contains information about the Object
     */
    virtual void GetDialogStatus(Player* /*player*/, Object* /*questgiver*/) { }
};

class CommandSC : public ScriptObject
{
protected:

    CommandSC(const char* name);

public:

    [[nodiscard]] auto IsDatabaseBound() const -> bool override { return false; }

    virtual void OnHandleDevCommand(Player* /*player*/, bool& /*enable*/) { }

    /**
     * @brief This hook runs execute chat command
     *
     * @param handler Contains information about the ChatHandler
     * @param cmdStr Contains information about the command name
     */
    [[nodiscard]] virtual auto CanExecuteCommand(ChatHandler& /*handler*/, std::string_view /*cmdStr*/) -> bool { return true; }
};

class DatabaseScript : public ScriptObject
{
protected:

    DatabaseScript(const char* name);

public:

    [[nodiscard]] auto IsDatabaseBound() const -> bool override { return false; }

    virtual void OnAfterDatabasesLoaded(uint32 /*updateFlags*/) { }
};

class WorldObjectScript : public ScriptObject
{
protected:

    WorldObjectScript(const char* name);

public:

    [[nodiscard]] auto IsDatabaseBound() const -> bool override { return false; }

    /**
     * @brief This hook called before destroy world object
     *
     * @param object Contains information about the WorldObject
     */
    virtual void OnWorldObjectDestroy(WorldObject* /*object*/) { }

    /**
     * @brief This hook called after create world object
     *
     * @param object Contains information about the WorldObject
     */
    virtual void OnWorldObjectCreate(WorldObject* /*object*/) { }

    /**
     * @brief This hook called after world object set to map
     *
     * @param object Contains information about the WorldObject
     */
    virtual void OnWorldObjectSetMap(WorldObject* /*object*/, Map* /*map*/ ) { }

    /**
     * @brief This hook called after world object reset
     *
     * @param object Contains information about the WorldObject
     */
    virtual void OnWorldObjectResetMap(WorldObject* /*object*/) { }

    /**
     * @brief This hook called after world object update
     *
     * @param object Contains information about the WorldObject
     * @param diff Contains information about the diff time
     */
    virtual void OnWorldObjectUpdate(WorldObject* /*object*/, uint32 /*diff*/) { }
};

class LootScript : public ScriptObject
{
protected:

    LootScript(const char* name);

public:

    [[nodiscard]] auto IsDatabaseBound() const -> bool override { return false; }

    /**
     * @brief This hook called before money loot
     *
     * @param player Contains information about the Player
     * @param gold Contains information about money
     */
    virtual void OnLootMoney(Player* /*player*/, uint32 /*gold*/) { }
};

class ElunaScript : public ScriptObject
{
protected:

    ElunaScript(const char* name);

public:
    /**
     * @brief This hook called when the weather changes in the zone this script is associated with.
     *
     * @param weather Contains information about the Weather
     * @param state Contains information about the WeatherState
     * @param grade Contains information about the grade
     */
    virtual void OnWeatherChange(Weather* /*weather*/, WeatherState /*state*/, float /*grade*/) { }

    // Called when the area trigger is activated by a player.
    [[nodiscard]] virtual auto CanAreaTrigger(Player* /*player*/, AreaTrigger const* /*trigger*/) -> bool { return false; }
};

// Manages registration, loading, and execution of scripts.
class ScriptMgr
{
    friend class ScriptObject;

private:
    ScriptMgr();
    virtual ~ScriptMgr();

public: /* Initialization */
    static auto instance() -> ScriptMgr*;
    void Initialize();
    void LoadDatabase();
    void FillSpellSummary();
    void CheckIfScriptsInDatabaseExist();

    auto ScriptsVersion() const -> const char* { return "Integrated Azeroth Scripts"; }

    void IncrementScriptCount() { ++_scriptCount; }
    auto GetScriptCount() const -> uint32 { return _scriptCount; }

    typedef void(*ScriptLoaderCallbackType)();
    typedef void(*ModulesLoaderCallbackType)();

    /// Sets the script loader callback which is invoked to load scripts
    /// (Workaround for circular dependency game <-> scripts)
    void SetScriptLoader(ScriptLoaderCallbackType script_loader_callback)
    {
        _script_loader_callback = script_loader_callback;
    }

    /// Sets the modules loader callback which is invoked to load modules
    /// (Workaround for circular dependency game <-> modules)
    void SetModulesLoader(ModulesLoaderCallbackType script_loader_callback)
    {
        _modules_loader_callback = script_loader_callback;
    }

public: /* Unloading */
    void Unload();

public: /* SpellScriptLoader */
    void CreateSpellScripts(uint32 spellId, std::list<SpellScript*>& scriptVector);
    void CreateAuraScripts(uint32 spellId, std::list<AuraScript*>& scriptVector);
    void CreateSpellScriptLoaders(uint32 spellId, std::vector<std::pair<SpellScriptLoader*, std::multimap<uint32, uint32>::iterator> >& scriptVector);

public: /* ServerScript */
    void OnNetworkStart();
    void OnNetworkStop();
    void OnSocketOpen(std::shared_ptr<WorldSocket> socket);
    void OnSocketClose(std::shared_ptr<WorldSocket> socket);
    auto CanPacketReceive(WorldSession* session, WorldPacket const& packet) -> bool;
    auto CanPacketSend(WorldSession* session, WorldPacket const& packet) -> bool;

public: /* WorldScript */
    void OnLoadCustomDatabaseTable();
    void OnOpenStateChange(bool open);
    void OnBeforeConfigLoad(bool reload);
    void OnAfterConfigLoad(bool reload);
    void OnBeforeFinalizePlayerWorldSession(uint32& cacheVersion);
    void OnMotdChange(std::string& newMotd);
    void OnShutdownInitiate(ShutdownExitCode code, ShutdownMask mask);
    void OnShutdownCancel();
    void OnWorldUpdate(uint32 diff);
    void OnStartup();
    void OnShutdown();
    void OnBeforeWorldInitialized();

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
    auto CreateInstanceScript(InstanceMap* map) -> InstanceScript*;

public: /* ItemScript */
    auto OnQuestAccept(Player* player, Item* item, Quest const* quest) -> bool;
    auto OnItemUse(Player* player, Item* item, SpellCastTargets const& targets) -> bool;
    auto OnItemExpire(Player* player, ItemTemplate const* proto) -> bool;
    auto OnItemRemove(Player* player, Item* item) -> bool;
    auto OnCastItemCombatSpell(Player* player, Unit* victim, SpellInfo const* spellInfo, Item* item) -> bool;
    void OnGossipSelect(Player* player, Item* item, uint32 sender, uint32 action);
    void OnGossipSelectCode(Player* player, Item* item, uint32 sender, uint32 action, const char* code);

public: /* CreatureScript */
    auto OnGossipHello(Player* player, Creature* creature) -> bool;
    auto OnGossipSelect(Player* player, Creature* creature, uint32 sender, uint32 action) -> bool;
    auto OnGossipSelectCode(Player* player, Creature* creature, uint32 sender, uint32 action, const char* code) -> bool;
    auto OnQuestAccept(Player* player, Creature* creature, Quest const* quest) -> bool;
    auto OnQuestSelect(Player* player, Creature* creature, Quest const* quest) -> bool;
    auto OnQuestComplete(Player* player, Creature* creature, Quest const* quest) -> bool;
    auto OnQuestReward(Player* player, Creature* creature, Quest const* quest, uint32 opt) -> bool;
    auto GetDialogStatus(Player* player, Creature* creature) -> uint32;
    auto GetCreatureAI(Creature* creature) -> CreatureAI*;
    void OnCreatureUpdate(Creature* creature, uint32 diff);
    void OnCreatureAddWorld(Creature* creature);
    void OnCreatureRemoveWorld(Creature* creature);

public: /* GameObjectScript */
    auto OnGossipHello(Player* player, GameObject* go) -> bool;
    auto OnGossipSelect(Player* player, GameObject* go, uint32 sender, uint32 action) -> bool;
    auto OnGossipSelectCode(Player* player, GameObject* go, uint32 sender, uint32 action, const char* code) -> bool;
    auto OnQuestAccept(Player* player, GameObject* go, Quest const* quest) -> bool;
    auto OnQuestReward(Player* player, GameObject* go, Quest const* quest, uint32 opt) -> bool;
    auto GetDialogStatus(Player* player, GameObject* go) -> uint32;
    void OnGameObjectDestroyed(GameObject* go, Player* player);
    void OnGameObjectDamaged(GameObject* go, Player* player);
    void OnGameObjectLootStateChanged(GameObject* go, uint32 state, Unit* unit);
    void OnGameObjectStateChanged(GameObject* go, uint32 state);
    void OnGameObjectUpdate(GameObject* go, uint32 diff);
    auto GetGameObjectAI(GameObject* go) -> GameObjectAI*;
    void OnGameObjectAddWorld(GameObject* go);
    void OnGameObjectRemoveWorld(GameObject* go);

public: /* AreaTriggerScript */
    auto OnAreaTrigger(Player* player, AreaTrigger const* trigger) -> bool;

public: /* BattlegroundScript */
    auto CreateBattleground(BattlegroundTypeId typeId) -> Battleground*;

public: /* OutdoorPvPScript */
    auto CreateOutdoorPvP(OutdoorPvPData const* data) -> OutdoorPvP*;

public: /* CommandScript */
    auto GetChatCommands() -> std::vector<Acore::ChatCommands::ChatCommandBuilder>;

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
    auto OnConditionCheck(Condition* condition, ConditionSourceInfo& sourceInfo) -> bool;

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
    auto OnCriteriaCheck(uint32 scriptId, Player* source, Unit* target, uint32 criteria_id) -> bool;

public: /* PlayerScript */
    void OnBeforePlayerUpdate(Player* player, uint32 p_time);
    void OnPlayerUpdate(Player* player, uint32 p_time);
    void OnSendInitialPacketsBeforeAddToMap(Player* player, WorldPacket& data);
    void OnPlayerReleasedGhost(Player* player);
    void OnPVPKill(Player* killer, Player* killed);
    void OnPlayerPVPFlagChange(Player* player, bool state);
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
    auto OnBeforePlayerTeleport(Player* player, uint32 mapid, float x, float y, float z, float orientation, uint32 options, Unit* target) -> bool;
    void OnPlayerUpdateFaction(Player* player);
    void OnPlayerAddToBattleground(Player* player, Battleground* bg);
    void OnPlayerQueueRandomDungeon(Player* player, uint32 & rDungeonId);
    void OnPlayerRemoveFromBattleground(Player* player, Battleground* bg);
    void OnAchievementComplete(Player* player, AchievementEntry const* achievement);
    auto OnBeforeAchievementComplete(Player* player, AchievementEntry const* achievement) -> bool;
    void OnCriteriaProgress(Player* player, AchievementCriteriaEntry const* criteria);
    auto OnBeforeCriteriaProgress(Player* player, AchievementCriteriaEntry const* criteria) -> bool;
    void OnAchievementSave(CharacterDatabaseTransaction trans, Player* player, uint16 achiId, CompletedAchievementData achiData);
    void OnCriteriaSave(CharacterDatabaseTransaction trans, Player* player, uint16 critId, CriteriaProgress criteriaData);
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
    auto OnBeforePlayerQuestComplete(Player* player, uint32 quest_id) -> bool;
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
    auto CanJoinInBattlegroundQueue(Player* player, ObjectGuid BattlemasterGuid, BattlegroundTypeId BGTypeID, uint8 joinAsGroup, GroupJoinBattlegroundResult& err) -> bool;
    auto ShouldBeRewardedWithMoneyInsteadOfExp(Player* player) -> bool;
    void OnBeforeTempSummonInitStats(Player* player, TempSummon* tempSummon, uint32& duration);
    void OnBeforeGuardianInitStatsForLevel(Player* player, Guardian* guardian, CreatureTemplate const* cinfo, PetType& petType);
    void OnAfterGuardianInitStatsForLevel(Player* player, Guardian* guardian);
    void OnBeforeLoadPetFromDB(Player* player, uint32& petentry, uint32& petnumber, bool& current, bool& forceLoadFromDB);
    auto CanJoinInArenaQueue(Player* player, ObjectGuid BattlemasterGuid, uint8 arenaslot, BattlegroundTypeId BGTypeID, uint8 joinAsGroup, uint8 IsRated, GroupJoinBattlegroundResult& err) -> bool;
    auto CanBattleFieldPort(Player* player, uint8 arenaType, BattlegroundTypeId BGTypeID, uint8 action) -> bool;
    auto CanGroupInvite(Player* player, std::string& membername) -> bool;
    auto CanGroupAccept(Player* player, Group* group) -> bool;
    auto CanSellItem(Player* player, Item* item, Creature* creature) -> bool;
    auto CanSendMail(Player* player, ObjectGuid receiverGuid, ObjectGuid mailbox, std::string& subject, std::string& body, uint32 money, uint32 COD, Item* item) -> bool;
    void PetitionBuy(Player* player, Creature* creature, uint32& charterid, uint32& cost, uint32& type);
    void PetitionShowList(Player* player, Creature* creature, uint32& CharterEntry, uint32& CharterDispayID, uint32& CharterCost);
    void OnRewardKillRewarder(Player* player, bool isDungeon, float& rate);
    auto CanGiveMailRewardAtGiveLevel(Player* player, uint8 level) -> bool;
    void OnDeleteFromDB(CharacterDatabaseTransaction trans, uint32 guid);
    auto CanRepopAtGraveyard(Player* player) -> bool;
    void OnGetMaxSkillValue(Player* player, uint32 skill, int32& result, bool IsPure);
    auto CanAreaExploreAndOutdoor(Player* player) -> bool;
    void OnVictimRewardBefore(Player* player, Player* victim, uint32& killer_title, uint32& victim_title);
    void OnVictimRewardAfter(Player* player, Player* victim, uint32& killer_title, uint32& victim_rank, float& honor_f);
    void OnCustomScalingStatValueBefore(Player* player, ItemTemplate const* proto, uint8 slot, bool apply, uint32& CustomScalingStatValue);
    void OnCustomScalingStatValue(Player* player, ItemTemplate const* proto, uint32& statType, int32& val, uint8 itemProtoStatNumber, uint32 ScalingStatValue, ScalingStatValuesEntry const* ssv);
    auto CanArmorDamageModifier(Player* player) -> bool;
    void OnGetFeralApBonus(Player* player, int32& feral_bonus, int32 dpsMod, ItemTemplate const* proto, ScalingStatValuesEntry const* ssv);
    auto CanApplyWeaponDependentAuraDamageMod(Player* player, Item* item, WeaponAttackType attackType, AuraEffect const* aura, bool apply) -> bool;
    auto CanApplyEquipSpell(Player* player, SpellInfo const* spellInfo, Item* item, bool apply, bool form_change) -> bool;
    auto CanApplyEquipSpellsItemSet(Player* player, ItemSetEffect* eff) -> bool;
    auto CanCastItemCombatSpell(Player* player, Unit* target, WeaponAttackType attType, uint32 procVictim, uint32 procEx, Item* item, ItemTemplate const* proto) -> bool;
    auto CanCastItemUseSpell(Player* player, Item* item, SpellCastTargets const& targets, uint8 cast_count, uint32 glyphIndex) -> bool;
    void OnApplyAmmoBonuses(Player* player, ItemTemplate const* proto, float& currentAmmoDPS);
    auto CanEquipItem(Player* player, uint8 slot, uint16& dest, Item* pItem, bool swap, bool not_loading) -> bool;
    auto CanUnequipItem(Player* player, uint16 pos, bool swap) -> bool;
    auto CanUseItem(Player* player, ItemTemplate const* proto, InventoryResult& result) -> bool;
    auto CanSaveEquipNewItem(Player* player, Item* item, uint16 pos, bool update) -> bool;
    auto CanApplyEnchantment(Player* player, Item* item, EnchantmentSlot slot, bool apply, bool apply_dur, bool ignore_condition) -> bool;
    void OnGetQuestRate(Player* player, float& result);
    auto PassedQuestKilledMonsterCredit(Player* player, Quest const* qinfo, uint32 entry, uint32 real_entry, ObjectGuid guid) -> bool;
    auto CheckItemInSlotAtLoadInventory(Player* player, Item* item, uint8 slot, uint8& err, uint16& dest) -> bool;
    auto NotAvoidSatisfy(Player* player, DungeonProgressionRequirements const* ar, uint32 target_map, bool report) -> bool;
    auto NotVisibleGloballyFor(Player* player, Player const* u) -> bool;
    void OnGetArenaPersonalRating(Player* player, uint8 slot, uint32& result);
    void OnGetArenaTeamId(Player* player, uint8 slot, uint32& result);
    void OnIsFFAPvP(Player* player, bool& result);
    void OnIsPvP(Player* player, bool& result);
    void OnGetMaxSkillValueForLevel(Player* player, uint16& result);
    auto NotSetArenaTeamInfoField(Player* player, uint8 slot, ArenaTeamInfoType type, uint32 value) -> bool;
    auto CanJoinLfg(Player* player, uint8 roles, lfg::LfgDungeonSet& dungeons, const std::string& comment) -> bool;
    auto CanEnterMap(Player* player, MapEntry const* entry, InstanceTemplate const* instance, MapDifficulty const* mapDiff, bool loginCheck) -> bool;
    auto CanInitTrade(Player* player, Player* target) -> bool;
    void OnSetServerSideVisibility(Player* player, ServerSideVisibilityType& type, AccountTypes& sec);
    void OnSetServerSideVisibilityDetect(Player* player, ServerSideVisibilityType& type, AccountTypes& sec);
    void OnPlayerResurrect(Player* player, float restore_percent, bool applySickness);
    auto CanPlayerUseChat(Player* player, uint32 type, uint32 language, std::string& msg) -> bool;
    auto CanPlayerUseChat(Player* player, uint32 type, uint32 language, std::string& msg, Player* receiver) -> bool;
    auto CanPlayerUseChat(Player* player, uint32 type, uint32 language, std::string& msg, Group* group) -> bool;
    auto CanPlayerUseChat(Player* player, uint32 type, uint32 language, std::string& msg, Guild* guild) -> bool;
    auto CanPlayerUseChat(Player* player, uint32 type, uint32 language, std::string& msg, Channel* channel) -> bool;
    void OnPlayerLearnTalents(Player* player, uint32 talentId, uint32 talentRank, uint32 spellid);
    void OnPlayerEnterCombat(Player* player, Unit* enemy);
    void OnPlayerLeaveCombat(Player* player);
    void OnQuestAbandon(Player* player, uint32 questId);

    // Anti cheat
    void AnticheatSetSkipOnePacketForASH(Player* player, bool apply);
    void AnticheatSetCanFlybyServer(Player* player, bool apply);
    void AnticheatSetUnderACKmount(Player* player);
    void AnticheatSetRootACKUpd(Player* player);
    void AnticheatUpdateMovementInfo(Player* player, MovementInfo const& movementInfo);
    void AnticheatSetJumpingbyOpcode(Player* player, bool jump);
    auto AnticheatHandleDoubleJump(Player* player, Unit* mover) -> bool;
    auto AnticheatCheckMovementInfo(Player* player, MovementInfo const& movementInfo, Unit* mover, bool jump) -> bool;

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
    auto CanGuildSendBankList(Guild const* guild, WorldSession* session, uint8 tabId, bool sendAllSlots) -> bool;

public: /* GroupScript */
    void OnGroupAddMember(Group* group, ObjectGuid guid);
    void OnGroupInviteMember(Group* group, ObjectGuid guid);
    void OnGroupRemoveMember(Group* group, ObjectGuid guid, RemoveMethod method, ObjectGuid kicker, const char* reason);
    void OnGroupChangeLeader(Group* group, ObjectGuid newLeaderGuid, ObjectGuid oldLeaderGuid);
    void OnGroupDisband(Group* group);
    auto CanGroupJoinBattlegroundQueue(Group const* group, Player* member, Battleground const* bgTemplate, uint32 MinPlayerCount, bool isRated, uint32 arenaSlot) -> bool;
    void OnCreate(Group* group, Player* leader);

public: /* GlobalScript */
    void OnGlobalItemDelFromDB(CharacterDatabaseTransaction trans, ObjectGuid::LowType itemGuid);
    void OnGlobalMirrorImageDisplayItem(const Item* item, uint32& display);
    void OnBeforeUpdateArenaPoints(ArenaTeam* at, std::map<ObjectGuid, uint32>& ap);
    void OnAfterRefCount(Player const* player, Loot& loot, bool canRate, uint16 lootMode, LootStoreItem* LootStoreItem, uint32& maxcount, LootStore const& store);
    void OnBeforeDropAddItem(Player const* player, Loot& loot, bool canRate, uint16 lootMode, LootStoreItem* LootStoreItem, LootStore const& store);
    auto OnItemRoll(Player const* player, LootStoreItem const* LootStoreItem, float& chance, Loot& loot, LootStore const& store) -> bool;
    auto OnBeforeLootEqualChanced(Player const* player, LootStoreItemList EqualChanced, Loot& loot, LootStore const& store) -> bool;
    void OnInitializeLockedDungeons(Player* player, uint8& level, uint32& lockData, lfg::LFGDungeonData const* dungeon);
    void OnAfterInitializeLockedDungeons(Player* player);
    void OnAfterUpdateEncounterState(Map* map, EncounterCreditType type, uint32 creditEntry, Unit* source, Difficulty difficulty_fixed, DungeonEncounterList const* encounters, uint32 dungeonCompleted, bool updated);
    void OnBeforeWorldObjectSetPhaseMask(WorldObject const* worldObject, uint32& oldPhaseMask, uint32& newPhaseMask, bool& useCombinedPhases, bool& update);
    auto OnIsAffectedBySpellModCheck(SpellInfo const* affectSpell, SpellInfo const* checkSpell, SpellModifier const* mod) -> bool;

public: /* Scheduled scripts */
    auto IncreaseScheduledScriptsCount() -> uint32 { return ++_scheduledScripts; }
    auto DecreaseScheduledScriptCount() -> uint32 { return --_scheduledScripts; }
    auto DecreaseScheduledScriptCount(size_t count) -> uint32 { return _scheduledScripts -= count; }
    auto IsScriptScheduled() const -> bool { return _scheduledScripts > 0; }

public: /* UnitScript */
    void OnHeal(Unit* healer, Unit* reciever, uint32& gain);
    void OnDamage(Unit* attacker, Unit* victim, uint32& damage);
    void ModifyPeriodicDamageAurasTick(Unit* target, Unit* attacker, uint32& damage);
    void ModifyMeleeDamage(Unit* target, Unit* attacker, uint32& damage);
    void ModifySpellDamageTaken(Unit* target, Unit* attacker, int32& damage);
    void ModifyHealRecieved(Unit* target, Unit* attacker, uint32& addHealth);
    auto DealDamage(Unit* AttackerUnit, Unit* pVictim, uint32 damage, DamageEffectType damagetype) -> uint32;
    void OnBeforeRollMeleeOutcomeAgainst(const Unit* attacker, const Unit* victim, WeaponAttackType attType, int32& attackerMaxSkillValueForLevel, int32& victimMaxSkillValueForLevel, int32& attackerWeaponSkill, int32& victimDefenseSkill, int32& crit_chance, int32& miss_chance, int32& dodge_chance, int32& parry_chance, int32& block_chance);
    void OnAuraRemove(Unit* unit, AuraApplication* aurApp, AuraRemoveMode mode);
    auto IfNormalReaction(Unit const* unit, Unit const* target, ReputationRank& repRank) -> bool;
    auto IsNeedModSpellDamagePercent(Unit const* unit, AuraEffect* auraEff, float& doneTotalMod, SpellInfo const* spellProto) -> bool;
    auto IsNeedModMeleeDamagePercent(Unit const* unit, AuraEffect* auraEff, float& doneTotalMod, SpellInfo const* spellProto) -> bool;
    auto IsNeedModHealPercent(Unit const* unit, AuraEffect* auraEff, float& doneTotalMod, SpellInfo const* spellProto) -> bool;
    auto CanSetPhaseMask(Unit const* unit, uint32 newPhaseMask, bool update) -> bool;
    auto IsCustomBuildValuesUpdate(Unit const* unit, uint8 updateType, ByteBuffer& fieldBuffer, Player const* target, uint16 index) -> bool;
    auto OnBuildValuesUpdate(Unit const* unit, uint8 updateType, ByteBuffer& fieldBuffer, Player* target, uint16 index) -> bool;
    void OnUnitUpdate(Unit* unit, uint32 diff);

public: /* MovementHandlerScript */
    void OnPlayerMove(Player* player, MovementInfo movementInfo, uint32 opcode);

public: /* AllCreatureScript */
    //listener function (OnAllCreatureUpdate) is called by OnCreatureUpdate
    //void OnAllCreatureUpdate(Creature* creature, uint32 diff);
    void Creature_SelectLevel(const CreatureTemplate* cinfo, Creature* creature);

public: /* AllMapScript */
    void OnBeforeCreateInstanceScript(InstanceMap* instanceMap, InstanceScript* instanceData, bool load, std::string data, uint32 completedEncounterMask);
    void OnDestroyInstance(MapInstanced* mapInstanced, Map* map);

public: /* BGScript */
    void OnBattlegroundStart(Battleground* bg);
    void OnBattlegroundEndReward(Battleground* bg, Player* player, TeamId winnerTeamId);
    void OnBattlegroundUpdate(Battleground* bg, uint32 diff);
    void OnBattlegroundAddPlayer(Battleground* bg, Player* player);
    void OnBattlegroundBeforeAddPlayer(Battleground* bg, Player* player);
    void OnBattlegroundRemovePlayerAtLeave(Battleground* bg, Player* player);
    void OnQueueUpdate(BattlegroundQueue* queue, BattlegroundBracketId bracket_id, bool isRated, uint32 arenaRatedTeamId);
    void OnAddGroup(BattlegroundQueue* queue, GroupQueueInfo* ginfo, uint32& index, Player* leader, Group* grp, PvPDifficultyEntry const* bracketEntry, bool isPremade);
    auto CanFillPlayersToBG(BattlegroundQueue* queue, Battleground* bg, const int32 aliFree, const int32 hordeFree, BattlegroundBracketId bracket_id) -> bool;
    auto CanFillPlayersToBGWithSpecific(BattlegroundQueue* queue, Battleground* bg, const int32 aliFree, const int32 hordeFree,
                                        BattlegroundBracketId thisBracketId, BattlegroundQueue* specificQueue, BattlegroundBracketId specificBracketId) -> bool;
    void OnCheckNormalMatch(BattlegroundQueue* queue, uint32& Coef, Battleground* bgTemplate, BattlegroundBracketId bracket_id, uint32& minPlayers, uint32& maxPlayers);
    auto CanSendMessageBGQueue(BattlegroundQueue* queue, Player* leader, Battleground* bg, PvPDifficultyEntry const* bracketEntry) -> bool;
    auto OnBeforeSendJoinMessageArenaQueue(BattlegroundQueue* queue, Player* leader, GroupQueueInfo* ginfo, PvPDifficultyEntry const* bracketEntry, bool isRated) -> bool;
    auto OnBeforeSendExitMessageArenaQueue(BattlegroundQueue* queue, GroupQueueInfo* ginfo) -> bool;
    void OnBattlegroundEnd(Battleground* bg, TeamId winnerTeamId);
    void OnBattlegroundDestroy(Battleground* bg);
    void OnBattlegroundCreate(Battleground* bg);

public: /* Arena Team Script */
    void OnGetSlotByType(const uint32 type, uint8& slot);
    void OnGetArenaPoints(ArenaTeam* at, float& points);
    void OnArenaTypeIDToQueueID(const BattlegroundTypeId bgTypeId, const uint8 arenaType, uint32& queueTypeID);
    void OnArenaQueueIdToArenaType(const BattlegroundQueueTypeId bgQueueTypeId, uint8& ArenaType);
    void OnSetArenaMaxPlayersPerTeam(const uint8 arenaType, uint32& maxPlayerPerTeam);

public: /* SpellSC */
    void OnCalcMaxDuration(Aura const* aura, int32& maxDuration);
    auto CanModAuraEffectDamageDone(AuraEffect const* auraEff, Unit* target, AuraApplication const* aurApp, uint8 mode, bool apply) -> bool;
    auto CanModAuraEffectModDamagePercentDone(AuraEffect const* auraEff, Unit* target, AuraApplication const* aurApp, uint8 mode, bool apply) -> bool;
    void OnSpellCheckCast(Spell* spell, bool strict, SpellCastResult& res);
    auto CanPrepare(Spell* spell, SpellCastTargets const* targets, AuraEffect const* triggeredByAura) -> bool;
    auto CanScalingEverything(Spell* spell) -> bool;
    auto CanSelectSpecTalent(Spell* spell) -> bool;
    void OnScaleAuraUnitAdd(Spell* spell, Unit* target, uint32 effectMask, bool checkIfValid, bool implicit, uint8 auraScaleMask, TargetInfo& targetInfo);
    void OnRemoveAuraScaleTargets(Spell* spell, TargetInfo& targetInfo, uint8 auraScaleMask, bool& needErase);
    void OnBeforeAuraRankForLevel(SpellInfo const* spellInfo, SpellInfo const* latestSpellInfo, uint8 level);
    void OnDummyEffect(WorldObject* caster, uint32 spellID, SpellEffIndex effIndex, GameObject* gameObjTarget);
    void OnDummyEffect(WorldObject* caster, uint32 spellID, SpellEffIndex effIndex, Creature* creatureTarget);
    void OnDummyEffect(WorldObject* caster, uint32 spellID, SpellEffIndex effIndex, Item* itemTarget);

public: /* GameEventScript */
    void OnGameEventStart(uint16 EventID);
    void OnGameEventStop(uint16 EventID);

public: /* MailScript */
    void OnBeforeMailDraftSendMailTo(MailDraft* mailDraft, MailReceiver const& receiver, MailSender const& sender, MailCheckMask& checked, uint32& deliver_delay, uint32& custom_expiration, bool& deleteMailItemsFromDB, bool& sendMail);

public: /* AchievementScript */

    void SetRealmCompleted(AchievementEntry const* achievement);
    auto IsCompletedCriteria(AchievementMgr* mgr, AchievementCriteriaEntry const* achievementCriteria, AchievementEntry const* achievement, CriteriaProgress const* progress) -> bool;
    auto IsRealmCompleted(AchievementGlobalMgr const* globalmgr, AchievementEntry const* achievement, std::chrono::system_clock::time_point completionTime) -> bool;
    void OnBeforeCheckCriteria(AchievementMgr* mgr, AchievementCriteriaEntryList const* achievementCriteriaList);
    auto CanCheckCriteria(AchievementMgr* mgr, AchievementCriteriaEntry const* achievementCriteria) -> bool;

public: /* PetScript */

    void OnInitStatsForLevel(Guardian* guardian, uint8 petlevel);
    void OnCalculateMaxTalentPointsForLevel(Pet* pet, uint8 level, uint8& points);
    auto CanUnlearnSpellSet(Pet* pet, uint32 level, uint32 spell) -> bool;
    auto CanUnlearnSpellDefault(Pet* pet, SpellInfo const* spellEntry) -> bool;
    auto CanResetTalents(Pet* pet) -> bool;

public: /* ArenaScript */

    auto CanAddMember(ArenaTeam* team, ObjectGuid PlayerGuid) -> bool;
    void OnGetPoints(ArenaTeam* team, uint32 memberRating, float& points);
    auto CanSaveToDB(ArenaTeam* team) -> bool;

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
    auto CanApplySoulboundFlag(Item* item, ItemTemplate const* proto) -> bool;
    auto CanItemApplyEquipSpell(Player* player, Item* item) -> bool;
    auto CanSendAuctionHello(WorldSession const* session, ObjectGuid guid, Creature* creature) -> bool;
    void ValidateSpellAtCastSpell(Player* player, uint32& oldSpellId, uint32& spellId, uint8& castCount, uint8& castFlags);
    void OnPlayerSetPhase(const AuraEffect* auraEff, AuraApplication const* aurApp, uint8 mode, bool apply, uint32& newPhase);
    void ValidateSpellAtCastSpellResult(Player* player, Unit* mover, Spell* spell, uint32 oldSpellId, uint32 spellId);
    void OnAfterLootTemplateProcess(Loot* loot, LootTemplate const* tab, LootStore const& store, Player* lootOwner, bool personal, bool noEmptyError, uint16 lootMode);
    void OnInstanceSave(InstanceSave* instanceSave);
    void GetDialogStatus(Player* player, Object* questgiver);

public: /* CommandSC */

    void OnHandleDevCommand(Player* player, bool& enable);
    auto CanExecuteCommand(ChatHandler& handler, std::string_view cmdStr) -> bool;

public: /* DatabaseScript */

    void OnAfterDatabasesLoaded(uint32 updateFlags);

public: /* WorldObjectScript */

    void OnWorldObjectDestroy(WorldObject* object);
    void OnWorldObjectCreate(WorldObject* object);
    void OnWorldObjectSetMap(WorldObject* object, Map* map);
    void OnWorldObjectResetMap(WorldObject* object);
    void OnWorldObjectUpdate(WorldObject* object, uint32 diff);

public: /* PetScript */

    void OnPetAddToWorld(Pet* pet);

public: /* LootScript */

    void OnLootMoney(Player* player, uint32 gold);

private:
    uint32 _scriptCount;

    //atomic op counter for active scripts amount
    std::atomic<long> _scheduledScripts;

    ScriptLoaderCallbackType _script_loader_callback;
    ModulesLoaderCallbackType _modules_loader_callback;
};

namespace Acore::SpellScripts
{
    template<typename T>
    using is_SpellScript = std::is_base_of<SpellScript, T>;

    template<typename T>
    using is_AuraScript = std::is_base_of<AuraScript, T>;
}

template <typename... Ts>
class GenericSpellAndAuraScriptLoader : public SpellScriptLoader
{
    using SpellScriptType = typename Acore::find_type_if_t<Acore::SpellScripts::is_SpellScript, Ts...>;
    using AuraScriptType = typename Acore::find_type_if_t<Acore::SpellScripts::is_AuraScript, Ts...>;
    using ArgsType = typename Acore::find_type_if_t<Acore::is_tuple, Ts...>;

public:
    GenericSpellAndAuraScriptLoader(char const* name, ArgsType&& args) : SpellScriptLoader(name), _args(std::move(args)) { }

private:
    [[nodiscard]] auto GetSpellScript() const -> SpellScript* override
    {
        if constexpr (!std::is_same_v<SpellScriptType, Acore::find_type_end>)
        {
            return Acore::new_from_tuple<SpellScriptType>(_args);
        }
        else
        {
            return nullptr;
        }
    }

    [[nodiscard]] auto GetAuraScript() const -> AuraScript* override
    {
        if constexpr (!std::is_same_v<AuraScriptType, Acore::find_type_end>)
        {
            return Acore::new_from_tuple<AuraScriptType>(_args);
        }
        else
        {
            return nullptr;
        }
    }

    ArgsType _args;
};

#define RegisterSpellScriptWithArgs(spell_script, script_name, ...) new GenericSpellAndAuraScriptLoader<spell_script, decltype(std::make_tuple(__VA_ARGS__))>(script_name, std::make_tuple(__VA_ARGS__))
#define RegisterSpellScript(spell_script) RegisterSpellScriptWithArgs(spell_script, #spell_script)
#define RegisterSpellAndAuraScriptPairWithArgs(script_1, script_2, script_name, ...) new GenericSpellAndAuraScriptLoader<script_1, script_2, decltype(std::make_tuple(__VA_ARGS__))>(script_name, std::make_tuple(__VA_ARGS__))
#define RegisterSpellAndAuraScriptPair(script_1, script_2) RegisterSpellAndAuraScriptPairWithArgs(script_1, script_2, #script_1)

template <class AI>
class GenericCreatureScript : public CreatureScript
{
    public:
        GenericCreatureScript(char const* name) : CreatureScript(name) { }
        auto GetAI(Creature* me) const -> CreatureAI* override { return new AI(me); }
};
#define RegisterCreatureAI(ai_name) new GenericCreatureScript<ai_name>(#ai_name)

template <class AI, AI*(*AIFactory)(Creature*)>
class FactoryCreatureScript : public CreatureScript
{
    public:
        FactoryCreatureScript(char const* name) : CreatureScript(name) { }
        auto GetAI(Creature* me) const -> CreatureAI* override { return AIFactory(me); }
};
#define RegisterCreatureAIWithFactory(ai_name, factory_fn) new FactoryCreatureScript<ai_name, &factory_fn>(#ai_name)

// Cannot be used due gob scripts not working like this
template <class AI>
class GenericGameObjectScript : public GameObjectScript
{
    public:
        GenericGameObjectScript(char const* name) : GameObjectScript(name) { }
        auto GetAI(GameObject* me) const -> GameObjectAI* override { return new AI(me); }
};
#define RegisterGameObjectAI(ai_name) new GenericGameObjectScript<ai_name>(#ai_name)

// Cannot be used due gob scripts not working like this
template <class AI, AI* (*AIFactory)(GameObject*)> class FactoryGameObjectScript : public GameObjectScript
{
    public:
        FactoryGameObjectScript(char const* name) : GameObjectScript(name) {}
        auto GetAI(GameObject* me) const -> GameObjectAI* override { return AIFactory(me); }
};
#define RegisterGameObjectAIWithFactory(ai_name, factory_fn) new FactoryGameObjectScript<ai_name, &factory_fn>(#ai_name)

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
                    TScript const* oldScript = nullptr;
                    for (auto iterator = ScriptPointerList.begin(); iterator != ScriptPointerList.end(); ++iterator)
                    {
                        // If the script names match...
                        if (iterator->second->GetName() == script->GetName())
                        {
                            // ... It exists.
                            oldScript = iterator->second;
                            break;
                        }
                    }

                    // If the script is already assigned -> delete it!
                    if (oldScript)
                    {
                        delete oldScript;
                    }

                    // Assign new script!
                    ScriptPointerList[id] = script;

                    // Increment script count only with new scripts
                    if (!oldScript)
                    {
                        sScriptMgr->IncrementScriptCount();
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
    static auto GetScriptById(uint32 id) -> TScript*
    {
        ScriptMapIterator it = ScriptPointerList.find(id);
        if (it != ScriptPointerList.end())
            return it->second;

        return nullptr;
    }

private:
    // See if the script is using the same memory as another script. If this happens, it means that
    // someone forgot to allocate new memory for a script.
    static auto _checkMemory(TScript* const script) -> bool
    {
        // See if the script is using the same memory as another script. If this happens, it means that
        // someone forgot to allocate new memory for a script.
        for (ScriptMapIterator it = ScriptPointerList.begin(); it != ScriptPointerList.end(); ++it)
        {
            if (it->second == script)
            {
                LOG_ERROR("scripts", "Script '%s' has same memory pointer as '%s'.",
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

/*
 * This file is part of the WarheadCore Project. See AUTHORS file for Copyright information
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

#ifndef _SCRIPT_REGISTRY_H_
#define _SCRIPT_REGISTRY_H_

#include "EventProcessor.h"
#include "ObjectGuid.h"
#include <unordered_map>

class Creature;
class GameObject;
class Map;
class Unit;

// Script list
class AccountScript;
class AchievementCriteriaScript;
class AchievementScript;
class AllCreatureScript;
class AllGameObjectScript;
class AllItemScript;
class AllMapScript;
class AreaTriggerScript;
class ArenaScript;
class ArenaTeamScript;
class AuctionHouseScript;
class BGScript;
class BattlegroundMapScript;
class BattlegroundScript;
class CommandSC;
class CommandScript;
class ConditionScript;
class CreatureScript;
class DatabaseScript;
class DynamicObjectScript;
class ElunaScript;
class FormulaScript;
class GameEventScript;
class GameObjectScript;
class GlobalScript;
class GroupScript;
class GuildScript;
class InstanceMapScript;
class ItemScript;
class LootScript;
class MailScript;
class MiscScript;
class ModuleScript;
class MovementHandlerScript;
class OutdoorPvPScript;
class PetScript;
class PlayerScript;
class ServerScript;
class SpellSC;
class SpellScriptLoader;
class TransportScript;
class UnitScript;
class VehicleScript;
class WeatherScript;
class WorldMapScript;
class WorldObjectScript;
class WorldScript;

constexpr auto SPELL_HOTSWAP_VISUAL_SPELL_EFFECT = 40162;

// Trait which indicates whether this script type
 // must be assigned in the database.
template<typename>
struct is_script_database_bound
    : std::false_type { };

template<>
struct is_script_database_bound<AchievementCriteriaScript>
    : std::true_type { };

template<>
struct is_script_database_bound<AreaTriggerScript>
    : std::true_type { };

template<>
struct is_script_database_bound<BattlegroundScript>
    : std::true_type { };

template<>
struct is_script_database_bound<ConditionScript>
    : std::true_type { };

template<>
struct is_script_database_bound<CreatureScript>
    : std::true_type { };

template<>
struct is_script_database_bound<GameObjectScript>
    : std::true_type { };

template<>
struct is_script_database_bound<InstanceMapScript>
    : std::true_type { };

template<>
struct is_script_database_bound<ItemScript>
    : std::true_type { };

template<>
struct is_script_database_bound<OutdoorPvPScript>
    : std::true_type { };

template<>
struct is_script_database_bound<SpellScriptLoader>
    : std::true_type { };

template<>
struct is_script_database_bound<TransportScript>
    : std::true_type { };

template<>
struct is_script_database_bound<VehicleScript>
    : std::true_type { };

template<>
struct is_script_database_bound<WeatherScript>
    : std::true_type { };

class ScriptRegistryInterface
{
public:
    ScriptRegistryInterface() { }
    virtual ~ScriptRegistryInterface() { }

    ScriptRegistryInterface(ScriptRegistryInterface const&) = delete;
    ScriptRegistryInterface(ScriptRegistryInterface&&) = delete;

    ScriptRegistryInterface& operator= (ScriptRegistryInterface const&) = delete;
    ScriptRegistryInterface& operator= (ScriptRegistryInterface&&) = delete;

    /// Removes all scripts associated with the given script context.
    /// Requires ScriptRegistryBase::SwapContext to be called after all transfers have finished.
    virtual void ReleaseContext(std::string_view context) = 0;

    /// Injects and updates the changed script objects.
    virtual void SwapContext(bool initialize) = 0;

    /// Removes the scripts used by this registry from the given container.
    /// Used to find unused script names.
    virtual void RemoveUsedScriptsFromContainer(std::unordered_set<std::string>& scripts) = 0;

    /// Unloads the script registry.
    virtual void Unload() = 0;

    /// Loading scripts after loadd DB.
    virtual void LoadDBBoundScripts() = 0;
};

template<class>
class ScriptRegistry;

class ScriptRegistryCompositum
    : public ScriptRegistryInterface
{
    ScriptRegistryCompositum() = default;

    template<class>
    friend class ScriptRegistry;

    /// Type erasure wrapper for objects
    class DeleteableObjectBase
    {
    public:
        DeleteableObjectBase() = default;
        virtual ~DeleteableObjectBase() = default;

        DeleteableObjectBase(DeleteableObjectBase const&) = delete;
        DeleteableObjectBase& operator= (DeleteableObjectBase const&) = delete;
    };

    template<typename T>
    class DeleteableObject
        : public DeleteableObjectBase
    {
    public:
        DeleteableObject(T&& object)
            : _object(std::forward<T>(object)) { }

    private:
        T _object;
    };

public:
    void SetScriptNameInContext(std::string_view scriptName, std::string_view context);
    std::string_view GetScriptContextOfScriptName(std::string_view scriptname) const;
    void ReleaseContext(std::string_view context) final override;

    void SwapContext(bool initialize) final override
    {
        for (auto const registry : _registries)
            registry->SwapContext(initialize);

        DoDelayedDelete();
    }

    void RemoveUsedScriptsFromContainer(std::unordered_set<std::string>& scripts) final override
    {
        for (auto const registry : _registries)
            registry->RemoveUsedScriptsFromContainer(scripts);
    }

    void Unload() final override
    {
        for (auto const registry : _registries)
            registry->Unload();
    }

    template<typename T>
    void QueueForDelayedDelete(T&& any)
    {
        _delayed_delete_queue.emplace_back(std::make_unique<DeleteableObject<typename std::decay<T>::type>>(std::forward<T>(any)));
    }

    void LoadDBBoundScripts() final
    {
        for (auto const registry : _registries)
            registry->LoadDBBoundScripts();
    }

    static ScriptRegistryCompositum* Instance()
    {
        static ScriptRegistryCompositum instance;
        return &instance;
    }

private:
    void Register(ScriptRegistryInterface* registry)
    {
        _registries.insert(registry);
    }

    void DoDelayedDelete()
    {
        _delayed_delete_queue.clear();
    }

    std::unordered_set<ScriptRegistryInterface*> _registries;
    std::vector<std::unique_ptr<DeleteableObjectBase>> _delayed_delete_queue;
    std::unordered_map<std::string /*script name*/, std::string /*context*/> _scriptnames_to_context;
};

#define sScriptRegistryCompositum ScriptRegistryCompositum::Instance()

template<typename /*ScriptType*/, bool /*IsDatabaseBound*/>
class SpecializedScriptRegistry;

// This is the global static registry of scripts.
template<class ScriptType>
class ScriptRegistry final
    : public SpecializedScriptRegistry<
    ScriptType, is_script_database_bound<ScriptType>::value>
{
    ScriptRegistry()
    {
        sScriptRegistryCompositum->Register(this);
    }

public:
    static ScriptRegistry* Instance();

    void LogDuplicatedScriptPointerError(ScriptType const* first, ScriptType const* second);
};

class ScriptRegistrySwapHookBase
{
public:
    ScriptRegistrySwapHookBase() { }
    virtual ~ScriptRegistrySwapHookBase() { }

    ScriptRegistrySwapHookBase(ScriptRegistrySwapHookBase const&) = delete;
    ScriptRegistrySwapHookBase(ScriptRegistrySwapHookBase&&) = delete;

    ScriptRegistrySwapHookBase& operator= (ScriptRegistrySwapHookBase const&) = delete;
    ScriptRegistrySwapHookBase& operator= (ScriptRegistrySwapHookBase&&) = delete;

    /// Called before the actual context release happens
    virtual void BeforeReleaseContext(std::string_view /*context*/) { }

    /// Called before SwapContext
    virtual void BeforeSwapContext(bool /*initialize*/) { }

    /// Called before Unload
    virtual void BeforeUnload() { }
};

template<typename ScriptType, typename Base>
class ScriptRegistrySwapHooks
    : public ScriptRegistrySwapHookBase
{
};

/// This hook is responsible for swapping OutdoorPvP's
template<typename Base>
class UnsupportedScriptRegistrySwapHooks
    : public ScriptRegistrySwapHookBase
{
public:
    void BeforeReleaseContext(std::string_view context) final override;
};

/// This hook is responsible for swapping Creature and GameObject AI's
template<typename ObjectType, typename ScriptType, typename Base>
class CreatureGameObjectScriptRegistrySwapHooks
    : public ScriptRegistrySwapHookBase
{
    template<typename W>
    class AIFunctionMapWorker
    {
    public:
        template<typename T>
        AIFunctionMapWorker(T&& worker)
            : _worker(std::forward<T>(worker)) { }

        void Visit(std::unordered_map<ObjectGuid, ObjectType*>& objects)
        {
            _worker(objects);
        }

        template<typename O>
        void Visit(std::unordered_map<ObjectGuid, O*>&) { }

    private:
        W _worker;
    };

    class AsyncCastHotswapEffectEvent : public BasicEvent
    {
    public:
        explicit AsyncCastHotswapEffectEvent(Unit* owner) : owner_(owner) { }

        bool Execute(uint64 /*e_time*/, uint32 /*p_time*/) override;

    private:
        Unit* owner_;
    };

    // Hook which is called before a creature is swapped
    static void UnloadResetScript(Creature* creature);
    static void UnloadDestroyScript(Creature* creature);

    // Hook which is called before a gameobject is swapped
    static void UnloadResetScript(GameObject* gameobject);
    static void UnloadDestroyScript(GameObject* gameobject);

    // Hook which is called after a creature was swapped
    static void LoadInitializeScript(Creature* creature);
    static void LoadResetScript(Creature* creature);

    // Hook which is called after a gameobject was swapped
    static void LoadInitializeScript(GameObject* gameobject);
    static void LoadResetScript(GameObject* gameobject);

    static Creature* GetEntityFromMap(std::common_type<Creature>, Map* map, ObjectGuid const& guid);
    static GameObject* GetEntityFromMap(std::common_type<GameObject>, Map* map, ObjectGuid const& guid);

    template<typename T>
    static void VisitObjectsToSwapOnMap(Map* map, std::unordered_set<uint32> const& idsToRemove, T visitor);

    static void DestroyScriptIdsFromSet(std::unordered_set<uint32> const& idsToRemove);
    static void InitializeScriptIdsFromSet(std::unordered_set<uint32> const& idsToRemove);

public:
    void BeforeReleaseContext(std::string_view context) final override;
    void BeforeSwapContext(bool initialize) override;
    void BeforeUnload() final override;

private:
    std::unordered_set<uint32> ids_removed_;
};

// This hook is responsible for swapping CreatureAI's
template<typename Base>
class ScriptRegistrySwapHooks<CreatureScript, Base>
    : public CreatureGameObjectScriptRegistrySwapHooks<
    Creature, CreatureScript, Base
    > { };

// This hook is responsible for swapping GameObjectAI's
template<typename Base>
class ScriptRegistrySwapHooks<GameObjectScript, Base>
    : public CreatureGameObjectScriptRegistrySwapHooks<
    GameObject, GameObjectScript, Base
    > { };

/// This hook is responsible for swapping BattlegroundScript's
template<typename Base>
class ScriptRegistrySwapHooks<BattlegroundScript, Base>
    : public UnsupportedScriptRegistrySwapHooks<Base> { };

/// This hook is responsible for swapping OutdoorPvP's
template<typename Base>
class ScriptRegistrySwapHooks<OutdoorPvPScript, Base>
    : public ScriptRegistrySwapHookBase
{
public:
    ScriptRegistrySwapHooks() = default;

    void BeforeReleaseContext(std::string_view context) final override;
    void BeforeSwapContext(bool initialize) override;
    void BeforeUnload() final override;

private:
    bool swapped{ false };
};

/// This hook is responsible for swapping InstanceMapScript's
template<typename Base>
class ScriptRegistrySwapHooks<InstanceMapScript, Base>
    : public ScriptRegistrySwapHookBase
{
public:
    ScriptRegistrySwapHooks() = default;

    void BeforeReleaseContext(std::string_view context) final override;
    void BeforeSwapContext(bool /*initialize*/) override;
    void BeforeUnload() final override;

private:
    bool swapped{ false };
};

/// This hook is responsible for swapping SpellScriptLoader's
template<typename Base>
class ScriptRegistrySwapHooks<SpellScriptLoader, Base>
    : public ScriptRegistrySwapHookBase
{
public:
    ScriptRegistrySwapHooks() = default;

    void BeforeReleaseContext(std::string_view context) final override;
    void BeforeSwapContext(bool /*initialize*/) override;
    void BeforeUnload() final override;

private:
    bool swapped{ false };
};

// Database bound script registry
template<typename ScriptType>
class SpecializedScriptRegistry<ScriptType, true>
    : public ScriptRegistryInterface,
    public ScriptRegistrySwapHooks<ScriptType, ScriptRegistry<ScriptType>>
{
    template<typename>
    friend class UnsupportedScriptRegistrySwapHooks;

    template<typename, typename>
    friend class ScriptRegistrySwapHooks;

    template<typename, typename, typename>
    friend class CreatureGameObjectScriptRegistrySwapHooks;

public:
    SpecializedScriptRegistry() = default;

    typedef std::unordered_map<uint32 /*script id*/, std::unique_ptr<ScriptType>> ScriptStoreType;
    typedef typename ScriptStoreType::iterator ScriptStoreIteratorType;

    void ReleaseContext(std::string_view context) final override;
    void SwapContext(bool initialize) final override;

    void RemoveUsedScriptsFromContainer(std::unordered_set<std::string>& scripts) final override;
    void Unload() final override;

    void LoadDBBoundScripts() final;

    // Adds a database bound script
    void AddScript(ScriptType* script);

    // Gets a script by its ID (assigned by ObjectMgr).
    ScriptType* GetScriptById(uint32 id);

    ScriptStoreType& GetScripts()
    {
        return _scripts;
    }

protected:
    // Returns the script id's which are registered to a certain context
    std::unordered_set<uint32> GetScriptIDsToRemove(std::string_view context) const;
    std::unordered_set<uint32> const& GetRecentlyAddedScriptIDs() const;

private:
    ScriptStoreType _scripts;

    // Scripts of a specific context
    std::unordered_multimap<std::string /*context*/, uint32 /*id*/> _ids_of_contexts;

    // Script id's which were registered recently
    std::unordered_set<uint32> _recently_added_ids;

    std::vector<std::pair<ScriptType*, std::string>> _dbDboundScripts;
};

/// This hook is responsible for swapping CommandScript's
template<typename Base>
class ScriptRegistrySwapHooks<CommandScript, Base>
    : public ScriptRegistrySwapHookBase
{
public:
    void BeforeReleaseContext(std::string_view /*context*/) final override;
    void BeforeSwapContext(bool /*initialize*/) override;
    void BeforeUnload() final override;
};

// Database unbound script registry
template<typename ScriptType>
class SpecializedScriptRegistry<ScriptType, false>
    : public ScriptRegistryInterface,
    public ScriptRegistrySwapHooks<ScriptType, ScriptRegistry<ScriptType>>
{
    template<typename, typename>
    friend class ScriptRegistrySwapHooks;

public:
    typedef std::unordered_multimap<std::string /*context*/, std::unique_ptr<ScriptType>> ScriptStoreType;
    typedef typename ScriptStoreType::iterator ScriptStoreIteratorType;

    SpecializedScriptRegistry() = default;

    void ReleaseContext(std::string_view context) final override
    {
        this->BeforeReleaseContext(context);
        _scripts.erase(std::string{ context });
    }

    void SwapContext(bool initialize) final override
    {
        this->BeforeSwapContext(initialize);
    }

    void RemoveUsedScriptsFromContainer(std::unordered_set<std::string>& scripts) final override
    {
        for (auto const& script : _scripts)
            scripts.erase(std::string{ script.second->GetName() });
    }

    void Unload() final override
    {
        this->BeforeUnload();
        _scripts.clear();
    }

    void LoadDBBoundScripts() final { }

    // Adds a non database bound script
    void AddScript(ScriptType* script);

    ScriptStoreType& GetScripts()
    {
        return _scripts;
    }

private:
    ScriptStoreType _scripts;
};

#endif // _SCRIPT_REGISTRY_H_

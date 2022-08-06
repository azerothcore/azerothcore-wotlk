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

// This is an open source non-commercial project. Dear PVS-Studio, please check it.
// PVS-Studio Static Code Analyzer for C, C++ and C#: http://www.viva64.com

#include "ScriptRegistry.h"
#include "Chat.h"
#include "GameObject.h"
#include "GameObjectAI.h"
#include "MapMgr.h"
#include "ObjectMgr.h"
#include "OutdoorPvPMgr.h"
#include "ScriptMgr.h"
#include "ScriptObject.h"
#include "Vehicle.h"

void ScriptRegistryCompositum::SetScriptNameInContext(std::string_view scriptName, std::string_view context)
{
    std::string name{ scriptName };

    ASSERT(_scriptnames_to_context.find(name) == _scriptnames_to_context.end(),
        "Scriptname was assigned to this context already!");
    _scriptnames_to_context.emplace(name, std::string{ context });
}

std::string_view ScriptRegistryCompositum::GetScriptContextOfScriptName(std::string_view scriptname) const
{
    auto itr = _scriptnames_to_context.find(std::string{ scriptname });
    ASSERT(itr != _scriptnames_to_context.end() && "Given scriptname doesn't exist!");
    return itr->second;
}

void ScriptRegistryCompositum::ReleaseContext(std::string_view context)
{
    for (auto const registry : _registries)
        registry->ReleaseContext(context);

    // Clear the script names in context after calling the release hooks
    // since it's possible that new references to a shared library
    // are acquired when releasing.
    for (auto itr = _scriptnames_to_context.begin(); itr != _scriptnames_to_context.end();)
        if (itr->second == context)
            itr = _scriptnames_to_context.erase(itr);
        else
            ++itr;
}

template<class ScriptType>
inline ScriptRegistry<ScriptType>* ScriptRegistry<ScriptType>::Instance()
{
    static ScriptRegistry<ScriptType> instance;
    return &instance;
}

template<class ScriptType>
void ScriptRegistry<ScriptType>::LogDuplicatedScriptPointerError(ScriptType const* first, ScriptType const* second)
{
    // See if the script is using the same memory as another script. If this happens, it means that
    // someone forgot to allocate new memory for a script.
    LOG_ERROR("scripts", "Script '{}' has same memory pointer as '{}'.", first->GetName(), second->GetName());
}

template<typename Base>
void UnsupportedScriptRegistrySwapHooks<Base>::BeforeReleaseContext(std::string_view context)
{
    auto const bounds = static_cast<Base*>(this)->_ids_of_contexts.equal_range(std::string{ context });
    ASSERT(bounds.first == bounds.second);
}

template<typename ObjectType, typename ScriptType, typename Base>
bool CreatureGameObjectScriptRegistrySwapHooks<ObjectType, ScriptType, Base>::AsyncCastHotswapEffectEvent::Execute(uint64, uint32)
{
    owner_->CastSpell(owner_, SPELL_HOTSWAP_VISUAL_SPELL_EFFECT, true);
    return true;
}

template<typename ObjectType, typename ScriptType, typename Base>
void CreatureGameObjectScriptRegistrySwapHooks<ObjectType, ScriptType, Base>::UnloadResetScript(Creature* creature)
{
    // Remove deletable events only,
    // otherwise it causes crashes with non-deletable spell events.
    creature->m_Events.KillAllEvents(false);

    if (creature->IsCharmed())
        creature->RemoveCharmedBy(nullptr);

    ASSERT(!creature->IsCharmed(), "There is a disabled AI which is still loaded.");

    if (creature->IsAlive())
        creature->AI()->EnterEvadeMode();
}

template<typename ObjectType, typename ScriptType, typename Base>
void CreatureGameObjectScriptRegistrySwapHooks<ObjectType, ScriptType, Base>::UnloadDestroyScript(Creature* creature)
{
    [[maybe_unused]] bool const destroyed = creature->AIM_Destroy();
    ASSERT(destroyed, "Destroying the AI should never fail here!");
    ASSERT(!creature->AI(), "The AI should be null here!");
}

template<typename ObjectType, typename ScriptType, typename Base>
void CreatureGameObjectScriptRegistrySwapHooks<ObjectType, ScriptType, Base>::UnloadResetScript(GameObject* gameobject)
{
    gameobject->AI()->Reset();
}

template<typename ObjectType, typename ScriptType, typename Base>
void CreatureGameObjectScriptRegistrySwapHooks<ObjectType, ScriptType, Base>::UnloadDestroyScript(GameObject* gameobject)
{
    gameobject->AIM_Destroy();
    ASSERT(!gameobject->AI(), "The AI should be null here!");
}

template<typename ObjectType, typename ScriptType, typename Base>
void CreatureGameObjectScriptRegistrySwapHooks<ObjectType, ScriptType, Base>::LoadInitializeScript(Creature* creature)
{
    ASSERT(!creature->AI(), "The AI should be null here!");

    if (creature->IsAlive())
        creature->ClearUnitState(UNIT_STATE_EVADE);

    [[maybe_unused]] bool const created = creature->AIM_Create();
    ASSERT(created, "Creating the AI should never fail here!");
}

template<typename ObjectType, typename ScriptType, typename Base>
void CreatureGameObjectScriptRegistrySwapHooks<ObjectType, ScriptType, Base>::LoadResetScript(Creature* creature)
{
    if (!creature->IsAlive())
        return;

    creature->AI()->InitializeAI();

    if (creature->GetVehicleKit())
        creature->GetVehicleKit()->Reset();

    creature->AI()->EnterEvadeMode();

    // Cast a dummy visual spell asynchronously here to signal
    // that the AI was hot swapped
    creature->m_Events.AddEvent(new AsyncCastHotswapEffectEvent(creature),
        creature->m_Events.CalculateTime(0));
}

template<typename ObjectType, typename ScriptType, typename Base>
void CreatureGameObjectScriptRegistrySwapHooks<ObjectType, ScriptType, Base>::LoadInitializeScript(GameObject* gameobject)
{
    ASSERT(!gameobject->AI(), "The AI should be null here!");
    gameobject->AIM_Initialize();
}

template<typename ObjectType, typename ScriptType, typename Base>
void CreatureGameObjectScriptRegistrySwapHooks<ObjectType, ScriptType, Base>::LoadResetScript(GameObject* gameobject)
{
    gameobject->AI()->Reset();
}

template<typename ObjectType, typename ScriptType, typename Base>
Creature* CreatureGameObjectScriptRegistrySwapHooks<ObjectType, ScriptType, Base>::GetEntityFromMap(std::common_type<Creature>, Map* map, ObjectGuid const& guid)
{
    return map->GetCreature(guid);
}

template<typename ObjectType, typename ScriptType, typename Base>
GameObject* CreatureGameObjectScriptRegistrySwapHooks<ObjectType, ScriptType, Base>::GetEntityFromMap(std::common_type<GameObject>, Map* map, ObjectGuid const& guid)
{
    return map->GetGameObject(guid);
}

template<typename ObjectType, typename ScriptType, typename Base>
template<typename T>
void CreatureGameObjectScriptRegistrySwapHooks<ObjectType, ScriptType, Base>::VisitObjectsToSwapOnMap(Map* map, std::unordered_set<uint32> const& idsToRemove, T visitor)
{
    auto evaluator = [&](std::unordered_map<ObjectGuid, ObjectType*>& objects)
    {
        for (auto object : objects)
        {
            // When the script Id of the script isn't removed in this
            // context change, do nothing.
            if (idsToRemove.find(object.second->GetScriptId()) != idsToRemove.end())
                visitor(object.second);
        }
    };

    AIFunctionMapWorker<typename std::decay<decltype(evaluator)>::type> worker(std::move(evaluator));
    TypeContainerVisitor<decltype(worker), MapStoredObjectTypesContainer> containerVisitor(worker);

    containerVisitor.Visit(map->GetObjectsStore());
}

template<typename ObjectType, typename ScriptType, typename Base>
void CreatureGameObjectScriptRegistrySwapHooks<ObjectType, ScriptType, Base>::DestroyScriptIdsFromSet(std::unordered_set<uint32> const& idsToRemove)
{
    // First reset all swapped scripts safe by guid
    // Skip creatures and gameobjects with an empty guid
    // (that were not added to the world as of now)
    sMapMgr->DoForAllMaps([&](Map* map)
    {
        std::vector<ObjectGuid> guidsToReset;

        VisitObjectsToSwapOnMap(map, idsToRemove, [&](ObjectType* object)
        {
            if (object->AI() && !object->GetGUID().IsEmpty())
                guidsToReset.push_back(object->GetGUID());
        });

        for (ObjectGuid const& guid : guidsToReset)
        {
            if (auto entity = GetEntityFromMap(std::common_type<ObjectType>{}, map, guid))
                UnloadResetScript(entity);
        }

        VisitObjectsToSwapOnMap(map, idsToRemove, [&](ObjectType* object)
        {
            // Destroy the scripts instantly
            UnloadDestroyScript(object);
        });
    });
}

template<typename ObjectType, typename ScriptType, typename Base>
void CreatureGameObjectScriptRegistrySwapHooks<ObjectType, ScriptType, Base>::InitializeScriptIdsFromSet(std::unordered_set<uint32> const& idsToRemove)
{
    sMapMgr->DoForAllMaps([&](Map* map)
    {
        std::vector<ObjectGuid> guidsToReset;

        VisitObjectsToSwapOnMap(map, idsToRemove, [&](ObjectType* object)
        {
            if (!object->AI() && !object->GetGUID().IsEmpty())
            {
                // Initialize the script
                LoadInitializeScript(object);
                guidsToReset.push_back(object->GetGUID());
            }
        });

        for (ObjectGuid const& guid : guidsToReset)
        {
            // Reset the script
            if (auto entity = GetEntityFromMap(std::common_type<ObjectType>{}, map, guid))
            {
                if (!entity->AI())
                    LoadInitializeScript(entity);

                LoadResetScript(entity);
            }
        }
    });
}

template<typename ObjectType, typename ScriptType, typename Base>
void CreatureGameObjectScriptRegistrySwapHooks<ObjectType, ScriptType, Base>::BeforeReleaseContext(std::string_view context)
{
    auto idsToRemove = static_cast<Base*>(this)->GetScriptIDsToRemove(std::string{ context });
    DestroyScriptIdsFromSet(idsToRemove);

    // Add the new ids which are removed to the global ids to remove set
    ids_removed_.insert(idsToRemove.begin(), idsToRemove.end());
}

template<typename ObjectType, typename ScriptType, typename Base>
void CreatureGameObjectScriptRegistrySwapHooks<ObjectType, ScriptType, Base>::BeforeSwapContext(bool initialize)
{
    // Never swap creature or gameobject scripts when initializing
    if (initialize)
        return;

    // Add the recently added scripts to the deleted scripts to replace
    // default AI's with recently added core scripts.
    ids_removed_.insert(static_cast<Base*>(this)->GetRecentlyAddedScriptIDs().begin(),
        static_cast<Base*>(this)->GetRecentlyAddedScriptIDs().end());

    DestroyScriptIdsFromSet(ids_removed_);
    InitializeScriptIdsFromSet(ids_removed_);

    ids_removed_.clear();
}

template<typename ObjectType, typename ScriptType, typename Base>
void CreatureGameObjectScriptRegistrySwapHooks<ObjectType, ScriptType, Base>::BeforeUnload()
{
    ASSERT(ids_removed_.empty());
}

template<typename Base>
void ScriptRegistrySwapHooks<OutdoorPvPScript, Base>::BeforeReleaseContext(std::string_view context)
{
    auto const bounds = static_cast<Base*>(this)->_ids_of_contexts.equal_range(std::string{ context });

    if ((!swapped) && (bounds.first != bounds.second))
    {
        swapped = true;
        sOutdoorPvPMgr->Die();
    }
}

template<typename Base>
void ScriptRegistrySwapHooks<OutdoorPvPScript, Base>::BeforeSwapContext(bool initialize)
{
    // Never swap outdoor pvp scripts when initializing
    if ((!initialize) && swapped)
    {
        sOutdoorPvPMgr->InitOutdoorPvP();
        swapped = false;
    }
}

template<typename Base>
void ScriptRegistrySwapHooks<OutdoorPvPScript, Base>::BeforeUnload()
{
    ASSERT(!swapped);
}

template<typename Base>
void ScriptRegistrySwapHooks<InstanceMapScript, Base>::BeforeReleaseContext(std::string_view context)
{
    auto const bounds = static_cast<Base*>(this)->_ids_of_contexts.equal_range(std::string{ context });
    if (bounds.first != bounds.second)
        swapped = true;
}

template<typename Base>
void ScriptRegistrySwapHooks<InstanceMapScript, Base>::BeforeSwapContext(bool)
{
    swapped = false;
}

template<typename Base>
void ScriptRegistrySwapHooks<InstanceMapScript, Base>::BeforeUnload()
{
    ASSERT(!swapped);
}

template<typename Base>
void ScriptRegistrySwapHooks<SpellScriptLoader, Base>::BeforeReleaseContext(std::string_view context)
{
    auto const bounds = static_cast<Base*>(this)->_ids_of_contexts.equal_range(std::string{ context });

    if (bounds.first != bounds.second)
        swapped = true;
}

template<typename Base>
void ScriptRegistrySwapHooks<SpellScriptLoader, Base>::BeforeSwapContext(bool)
{
    if (swapped)
    {
        sObjectMgr->ValidateSpellScripts();
        swapped = false;
    }
}

template<typename Base>
void ScriptRegistrySwapHooks<SpellScriptLoader, Base>::BeforeUnload()
{
    ASSERT(!swapped);
}

template<typename ScriptType>
void SpecializedScriptRegistry<ScriptType, true>::ReleaseContext(std::string_view context)
{
    this->BeforeReleaseContext(context);

    auto const bounds = _ids_of_contexts.equal_range(std::string{ context });
    for (auto itr = bounds.first; itr != bounds.second; ++itr)
        _scripts.erase(itr->second);
}

template<typename ScriptType>
void SpecializedScriptRegistry<ScriptType, true>::SwapContext(bool initialize)
{
    this->BeforeSwapContext(initialize);
    _recently_added_ids.clear();

    if (initialize)
        return;

    LoadDBBoundScripts();
}

template<typename ScriptType>
void SpecializedScriptRegistry<ScriptType, true>::RemoveUsedScriptsFromContainer(std::unordered_set<std::string>& scripts)
{
    for (auto const& script : _scripts)
        scripts.erase(std::string{ script.second->GetName() });
}

template<typename ScriptType>
void SpecializedScriptRegistry<ScriptType, true>::Unload()
{
    this->BeforeUnload();
    ASSERT(_recently_added_ids.empty(), "Recently added script ids should be empty here!");

    _scripts.clear();
    _ids_of_contexts.clear();
}

template<typename ScriptType>
void SpecializedScriptRegistry<ScriptType, true>::LoadDBBoundScripts()
{
    for (auto [script, context] : _dbDboundScripts)
    {
        ASSERT(script, "Tried to call AddScript with a nullpointer!");
        ASSERT(!context.empty(), "Tried to register a script without being in a valid script context!");

        std::unique_ptr<ScriptType> script_ptr{ std::move(script) };

        // Get an ID for the script. An ID only exists if it's a script that is assigned in the database
        // through a script name (or similar).
        if (uint32 const id = sObjectMgr->GetScriptId(script_ptr->GetName()))
        {
            // Try to find an existing script.
            for (auto const& stored_script : _scripts)
            {
                // If the script names match...
                if (stored_script.second->GetName() == script_ptr->GetName())
                {
                    // If the script is already assigned -> delete it!
                    ABORT("Script '{}' already assigned with the same script name, so the script can't work.", script->GetName());

                    // Error that should be fixed ASAP.
                    sScriptRegistryCompositum->QueueForDelayedDelete(std::move(script_ptr));
                    ABORT();
                    return;
                }
            }

            std::string scriptName{ script_ptr->GetName() };

            // If the script isn't assigned -> assign it!
            _scripts.emplace(id, std::move(script_ptr));
            _ids_of_contexts.emplace(context, id);
            _recently_added_ids.emplace(id);

            sScriptRegistryCompositum->SetScriptNameInContext(scriptName, context);
        }
        else
        {
            // The script uses a script name from database, but isn't assigned to anything.
            LOG_ERROR("sql.sql", "Script '{}' exists in the core, but the database does not assign it to any creature.", script->GetName());

            // Avoid calling "delete script;" because we are currently in the script constructor
            // In a valid scenario this will not happen because every script has a name assigned in the database
            sScriptRegistryCompositum->QueueForDelayedDelete(std::move(script_ptr));
        }
    }

    _dbDboundScripts.clear();
}

// Adds a database bound script
template<typename ScriptType>
void SpecializedScriptRegistry<ScriptType, true>::AddScript(ScriptType* script)
{
    ASSERT(script, "Tried to call AddScript with a nullpointer!");
    ASSERT(!sScriptMgr->GetCurrentScriptContext().empty(), "Tried to register a script without being in a valid script context!");

    _dbDboundScripts.emplace_back(script, sScriptMgr->GetCurrentScriptContext());
}

// Gets a script by its ID (assigned by ObjectMgr).
template<typename ScriptType>
ScriptType* SpecializedScriptRegistry<ScriptType, true>::GetScriptById(uint32 id)
{
    auto const itr = _scripts.find(id);
    if (itr != _scripts.end())
        return itr->second.get();

    return nullptr;
}

// Returns the script id's which are registered to a certain context
template<typename ScriptType>
inline std::unordered_set<uint32> SpecializedScriptRegistry<ScriptType, true>::GetScriptIDsToRemove(std::string_view context) const
{
    // Create a set of all ids which are removed
    std::unordered_set<uint32> scripts_to_remove;

    auto const bounds = _ids_of_contexts.equal_range(std::string{ context });
    for (auto itr = bounds.first; itr != bounds.second; ++itr)
        scripts_to_remove.insert(itr->second);

    return scripts_to_remove;
}

template<typename ScriptType>
inline std::unordered_set<uint32> const& SpecializedScriptRegistry<ScriptType, true>::GetRecentlyAddedScriptIDs() const
{
    return _recently_added_ids;
}

template<typename Base>
inline void ScriptRegistrySwapHooks<CommandScript, Base>::BeforeReleaseContext(std::string_view)
{
    Acore::ChatCommands::InvalidateCommandMap();
}

template<typename Base>
inline void ScriptRegistrySwapHooks<CommandScript, Base>::BeforeSwapContext(bool)
{
    Acore::ChatCommands::InvalidateCommandMap();
}

template<typename Base>
inline void ScriptRegistrySwapHooks<CommandScript, Base>::BeforeUnload()
{
    Acore::ChatCommands::InvalidateCommandMap();
}

// Adds a non database bound script
template<typename ScriptType>
inline void SpecializedScriptRegistry<ScriptType, false>::AddScript(ScriptType* script)
{
    ASSERT(script, "Tried to call AddScript with a nullpointer!");
    ASSERT(!sScriptMgr->GetCurrentScriptContext().empty(), "Tried to register a script without being in a valid script context!");

    std::unique_ptr<ScriptType> script_ptr(script);

    for (auto const& entry : _scripts)
    {
        if (entry.second.get() == script)
        {
            static_cast<ScriptRegistry<ScriptType>*>(this)->LogDuplicatedScriptPointerError(script, entry.second.get());

            sScriptRegistryCompositum->QueueForDelayedDelete(std::move(script_ptr));
            return;
        }
    }

    // We're dealing with a code-only script, just add it.
    _scripts.insert(std::make_pair(sScriptMgr->GetCurrentScriptContext(), std::move(script_ptr)));
}

// Specialize for each script type class like so:

#define REGISTER_SCRIPT_OBJECT(__script_object) \
template class AC_GAME_API ScriptRegistry<__script_object>; \
template class AC_GAME_API SpecializedScriptRegistry<__script_object, is_script_database_bound<__script_object>::value>;

REGISTER_SCRIPT_OBJECT(AccountScript)
REGISTER_SCRIPT_OBJECT(AchievementCriteriaScript)
REGISTER_SCRIPT_OBJECT(AchievementScript)
REGISTER_SCRIPT_OBJECT(AllCreatureScript)
REGISTER_SCRIPT_OBJECT(AllGameObjectScript)
REGISTER_SCRIPT_OBJECT(AllItemScript)
REGISTER_SCRIPT_OBJECT(AllMapScript)
REGISTER_SCRIPT_OBJECT(AreaTriggerScript)
REGISTER_SCRIPT_OBJECT(ArenaScript)
REGISTER_SCRIPT_OBJECT(ArenaTeamScript)
REGISTER_SCRIPT_OBJECT(AuctionHouseScript)
REGISTER_SCRIPT_OBJECT(BGScript)
REGISTER_SCRIPT_OBJECT(BattlegroundMapScript)
REGISTER_SCRIPT_OBJECT(BattlegroundScript)
REGISTER_SCRIPT_OBJECT(CommandSC)
REGISTER_SCRIPT_OBJECT(CommandScript)
REGISTER_SCRIPT_OBJECT(ConditionScript)
REGISTER_SCRIPT_OBJECT(CreatureScript)
REGISTER_SCRIPT_OBJECT(DatabaseScript)
REGISTER_SCRIPT_OBJECT(DynamicObjectScript)
REGISTER_SCRIPT_OBJECT(ElunaScript)
REGISTER_SCRIPT_OBJECT(FormulaScript)
REGISTER_SCRIPT_OBJECT(GameEventScript)
REGISTER_SCRIPT_OBJECT(GameObjectScript)
REGISTER_SCRIPT_OBJECT(GlobalScript)
REGISTER_SCRIPT_OBJECT(GroupScript)
REGISTER_SCRIPT_OBJECT(GuildScript)
REGISTER_SCRIPT_OBJECT(InstanceMapScript)
REGISTER_SCRIPT_OBJECT(ItemScript)
REGISTER_SCRIPT_OBJECT(LootScript)
REGISTER_SCRIPT_OBJECT(MailScript)
REGISTER_SCRIPT_OBJECT(MiscScript)
REGISTER_SCRIPT_OBJECT(ModuleScript)
REGISTER_SCRIPT_OBJECT(MovementHandlerScript)
REGISTER_SCRIPT_OBJECT(OutdoorPvPScript)
REGISTER_SCRIPT_OBJECT(PetScript)
REGISTER_SCRIPT_OBJECT(PlayerScript)
REGISTER_SCRIPT_OBJECT(ServerScript)
REGISTER_SCRIPT_OBJECT(SpellSC)
REGISTER_SCRIPT_OBJECT(SpellScriptLoader)
REGISTER_SCRIPT_OBJECT(TransportScript)
REGISTER_SCRIPT_OBJECT(UnitScript)
REGISTER_SCRIPT_OBJECT(VehicleScript)
REGISTER_SCRIPT_OBJECT(WeatherScript)
REGISTER_SCRIPT_OBJECT(WorldMapScript)
REGISTER_SCRIPT_OBJECT(WorldObjectScript)
REGISTER_SCRIPT_OBJECT(WorldScript)

#undef REGISTER_SCRIPT_OBJECT

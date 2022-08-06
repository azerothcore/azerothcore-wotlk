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

#include "ScriptObject.h"
#include "InstanceScript.h"
#include "Log.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "ScriptRegistry.h"

ScriptObject::ScriptObject(std::string_view name) : _name(name)
{
    sScriptMgr->IncreaseScriptCount();
}

ScriptObject::~ScriptObject()
{
    sScriptMgr->DecreaseScriptCount();
}

///-
AllMapScript::AllMapScript(std::string_view name)
    : ScriptObject(name)
{
    ScriptRegistry<AllMapScript>::Instance()->AddScript(this);
}

AllCreatureScript::AllCreatureScript(std::string_view name)
    : ScriptObject(name)
{
    ScriptRegistry<AllCreatureScript>::Instance()->AddScript(this);
}

UnitScript::UnitScript(std::string_view name, bool addToScripts)
    : ScriptObject(name)
{
    if (addToScripts)
        ScriptRegistry<UnitScript>::Instance()->AddScript(this);
}

MovementHandlerScript::MovementHandlerScript(std::string_view name)
    : ScriptObject(name)
{
    ScriptRegistry<MovementHandlerScript>::Instance()->AddScript(this);
}

SpellScriptLoader::SpellScriptLoader(std::string_view name)
    : ScriptObject(name)
{
    ScriptRegistry<SpellScriptLoader>::Instance()->AddScript(this);
}

ServerScript::ServerScript(std::string_view name)
    : ScriptObject(name)
{
    ScriptRegistry<ServerScript>::Instance()->AddScript(this);
}

WorldScript::WorldScript(std::string_view name)
    : ScriptObject(name)
{
    ScriptRegistry<WorldScript>::Instance()->AddScript(this);
}

FormulaScript::FormulaScript(std::string_view name)
    : ScriptObject(name)
{
    ScriptRegistry<FormulaScript>::Instance()->AddScript(this);
}

WorldMapScript::WorldMapScript(std::string_view name, uint32 mapId)
    : ScriptObject(name), MapScript<Map>(mapId)
{
    ScriptRegistry<WorldMapScript>::Instance()->AddScript(this);
}

InstanceMapScript::InstanceMapScript(std::string_view name, uint32 mapId)
    : ScriptObject(name), MapScript<InstanceMap>(mapId)
{
    ScriptRegistry<InstanceMapScript>::Instance()->AddScript(this);
}

BattlegroundMapScript::BattlegroundMapScript(std::string_view name, uint32 mapId)
    : ScriptObject(name), MapScript<BattlegroundMap>(mapId)
{
    ScriptRegistry<BattlegroundMapScript>::Instance()->AddScript(this);
}

ItemScript::ItemScript(std::string_view name)
    : ScriptObject(name)
{
    ScriptRegistry<ItemScript>::Instance()->AddScript(this);
}

CreatureScript::CreatureScript(std::string_view name)
    : ScriptObject(name)
{
    ScriptRegistry<CreatureScript>::Instance()->AddScript(this);
}

GameObjectScript::GameObjectScript(std::string_view name)
    : ScriptObject(name)
{
    ScriptRegistry<GameObjectScript>::Instance()->AddScript(this);
}

AreaTriggerScript::AreaTriggerScript(std::string_view name)
    : ScriptObject(name)
{
    ScriptRegistry<AreaTriggerScript>::Instance()->AddScript(this);
}

bool OnlyOnceAreaTriggerScript::OnTrigger(Player* player, AreaTrigger const* trigger)
{
    uint32 const triggerId = trigger->entry;

    if (InstanceScript* instance = player->GetInstanceScript())
    {
        if (instance->IsAreaTriggerDone(triggerId))
        {
            return true;
        }
        else
        {
            instance->MarkAreaTriggerDone(triggerId);
        }
    }

    return _OnTrigger(player, trigger);
}

void OnlyOnceAreaTriggerScript::ResetAreaTriggerDone(InstanceScript* script, uint32 triggerId)
{
    script->ResetAreaTriggerDone(triggerId);
}

void OnlyOnceAreaTriggerScript::ResetAreaTriggerDone(Player const* player, AreaTrigger const* trigger)
{
    if (InstanceScript* instance = player->GetInstanceScript())
        ResetAreaTriggerDone(instance, trigger->entry);
}

BattlegroundScript::BattlegroundScript(std::string_view name)
    : ScriptObject(name)
{
    ScriptRegistry<BattlegroundScript>::Instance()->AddScript(this);
}

OutdoorPvPScript::OutdoorPvPScript(std::string_view name)
    : ScriptObject(name)
{
    ScriptRegistry<OutdoorPvPScript>::Instance()->AddScript(this);
}

CommandScript::CommandScript(std::string_view name)
    : ScriptObject(name)
{
    ScriptRegistry<CommandScript>::Instance()->AddScript(this);
}

WeatherScript::WeatherScript(std::string_view name)
    : ScriptObject(name)
{
    ScriptRegistry<WeatherScript>::Instance()->AddScript(this);
}

AuctionHouseScript::AuctionHouseScript(std::string_view name)
    : ScriptObject(name)
{
    ScriptRegistry<AuctionHouseScript>::Instance()->AddScript(this);
}

ConditionScript::ConditionScript(std::string_view name)
    : ScriptObject(name)
{
    ScriptRegistry<ConditionScript>::Instance()->AddScript(this);
}

VehicleScript::VehicleScript(std::string_view name)
    : ScriptObject(name)
{
    ScriptRegistry<VehicleScript>::Instance()->AddScript(this);
}

DynamicObjectScript::DynamicObjectScript(std::string_view name)
    : ScriptObject(name)
{
    ScriptRegistry<DynamicObjectScript>::Instance()->AddScript(this);
}

TransportScript::TransportScript(std::string_view name)
    : ScriptObject(name)
{
    ScriptRegistry<TransportScript>::Instance()->AddScript(this);
}

AchievementCriteriaScript::AchievementCriteriaScript(std::string_view name)
    : ScriptObject(name)
{
    ScriptRegistry<AchievementCriteriaScript>::Instance()->AddScript(this);
}

PlayerScript::PlayerScript(std::string_view name)
    : ScriptObject(name)
{
    ScriptRegistry<PlayerScript>::Instance()->AddScript(this);
}

AccountScript::AccountScript(std::string_view name)
    : ScriptObject(name)
{
    ScriptRegistry<AccountScript>::Instance()->AddScript(this);
}

GuildScript::GuildScript(std::string_view name)
    : ScriptObject(name)
{
    ScriptRegistry<GuildScript>::Instance()->AddScript(this);
}

GroupScript::GroupScript(std::string_view name)
    : ScriptObject(name)
{
    ScriptRegistry<GroupScript>::Instance()->AddScript(this);
}

GlobalScript::GlobalScript(std::string_view name)
    : ScriptObject(name)
{
    ScriptRegistry<GlobalScript>::Instance()->AddScript(this);
}

BGScript::BGScript(std::string_view name)
    : ScriptObject(name)
{
    ScriptRegistry<BGScript>::Instance()->AddScript(this);
}

ArenaTeamScript::ArenaTeamScript(std::string_view name)
    : ScriptObject(name)
{
    ScriptRegistry<ArenaTeamScript>::Instance()->AddScript(this);
}

SpellSC::SpellSC(std::string_view name)
    : ScriptObject(name)
{
    ScriptRegistry<SpellSC>::Instance()->AddScript(this);
}

ModuleScript::ModuleScript(std::string_view name)
    : ScriptObject(name)
{
    ScriptRegistry<ModuleScript>::Instance()->AddScript(this);
}

GameEventScript::GameEventScript(std::string_view name)
    : ScriptObject(name)
{
    ScriptRegistry<GameEventScript>::Instance()->AddScript(this);
}

MailScript::MailScript(std::string_view name)
    : ScriptObject(name)
{
    ScriptRegistry<MailScript>::Instance()->AddScript(this);
}

AchievementScript::AchievementScript(std::string_view name)
    : ScriptObject(name)
{
    ScriptRegistry<AchievementScript>::Instance()->AddScript(this);
}

PetScript::PetScript(std::string_view name)
    : ScriptObject(name)
{
    ScriptRegistry<PetScript>::Instance()->AddScript(this);
}

ArenaScript::ArenaScript(std::string_view name)
    : ScriptObject(name)
{
    ScriptRegistry<ArenaScript>::Instance()->AddScript(this);
}

MiscScript::MiscScript(std::string_view name)
    : ScriptObject(name)
{
    ScriptRegistry<MiscScript>::Instance()->AddScript(this);
}

CommandSC::CommandSC(std::string_view name)
    : ScriptObject(name)
{
    ScriptRegistry<CommandSC>::Instance()->AddScript(this);
}

DatabaseScript::DatabaseScript(std::string_view name) : ScriptObject(name)
{
    ScriptRegistry<DatabaseScript>::Instance()->AddScript(this);
}

WorldObjectScript::WorldObjectScript(std::string_view name) : ScriptObject(name)
{
    ScriptRegistry<WorldObjectScript>::Instance()->AddScript(this);
}

LootScript::LootScript(std::string_view name) : ScriptObject(name)
{
    ScriptRegistry<LootScript>::Instance()->AddScript(this);
}

ElunaScript::ElunaScript(std::string_view name) : ScriptObject(name)
{
    ScriptRegistry<ElunaScript>::Instance()->AddScript(this);
}

AllItemScript::AllItemScript(std::string_view name) : ScriptObject(name)
{
    ScriptRegistry<AllItemScript>::Instance()->AddScript(this);
}

AllGameObjectScript::AllGameObjectScript(std::string_view name) : ScriptObject(name)
{
    ScriptRegistry<AllGameObjectScript>::Instance()->AddScript(this);
}

void WorldMapScript::checkValidity()
{
    checkMap();

    if (GetEntry() && !GetEntry()->IsWorldMap())
        LOG_ERROR("maps.script", "WorldMapScript for map {} is invalid.", GetEntry()->MapID);
}

void InstanceMapScript::checkValidity()
{
    checkMap();

    if (GetEntry() && !GetEntry()->IsDungeon())
        LOG_ERROR("maps.script", "InstanceMapScript for map {} is invalid.", GetEntry()->MapID);
}

void BattlegroundMapScript::checkValidity()
{
    checkMap();

    if (GetEntry() && !GetEntry()->IsBattleground())
        LOG_ERROR("maps.script", "BattlegroundMapScript for map {} is invalid.", GetEntry()->MapID);
}

template<class TMap>
void MapScript<TMap>::checkMap()
{
    _mapEntry = sMapStore.LookupEntry(_mapId);

    if (!_mapEntry)
        LOG_ERROR("maps.script", "Invalid MapScript for {}; no such map ID.", _mapId);
}

template class AC_GAME_API MapScript<Map>;
template class AC_GAME_API MapScript<InstanceMap>;
template class AC_GAME_API MapScript<BattlegroundMap>;

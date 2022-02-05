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

#include "ScriptMgr.h"
#include "InstanceScript.h"
#include "ScriptSystem.h"
#include "SmartAI.h"
#include "SpellMgr.h"
#include "UnitAI.h"

namespace
{
    template<typename T>
    inline void SCR_CLEAR()
    {
        for (auto const& [scriptID, script] : ScriptRegistry<T>::ScriptPointerList)
        {
            delete script;
        }

        ScriptRegistry<T>::ScriptPointerList.clear();
    }
}

struct TSpellSummary
{
    uint8 Targets; // set of enum SelectTarget
    uint8 Effects; // set of enum SelectEffect
}*SpellSummary;

ScriptMgr::ScriptMgr()
    : _scriptCount(0),
    _scheduledScripts(0),
    _script_loader_callback(nullptr),
    _modules_loader_callback(nullptr) { }

ScriptMgr::~ScriptMgr() { }

ScriptMgr* ScriptMgr::instance()
{
    static ScriptMgr instance;
    return &instance;
}

void ScriptMgr::Initialize()
{
    LOG_INFO("server.loading", "> Loading C++ scripts");
    LOG_INFO("server.loading", " ");

    AddSC_SmartScripts();

    ASSERT(_script_loader_callback,
        "Script loader callback wasn't registered!");

    ASSERT(_modules_loader_callback,
        "Modules loader callback wasn't registered!");

    _script_loader_callback();
    _modules_loader_callback();
}

void ScriptMgr::Unload()
{
    SCR_CLEAR<AccountScript>();
    SCR_CLEAR<AchievementCriteriaScript>();
    SCR_CLEAR<AchievementScript>();
    SCR_CLEAR<AllCreatureScript>();
    SCR_CLEAR<AllGameObjectScript>();
    SCR_CLEAR<AllItemScript>();
    SCR_CLEAR<AllMapScript>();
    SCR_CLEAR<AreaTriggerScript>();
    SCR_CLEAR<ArenaScript>();
    SCR_CLEAR<ArenaTeamScript>();
    SCR_CLEAR<AuctionHouseScript>();
    SCR_CLEAR<BGScript>();
    SCR_CLEAR<BattlegroundMapScript>();
    SCR_CLEAR<BattlegroundScript>();
    SCR_CLEAR<CommandSC>();
    SCR_CLEAR<CommandScript>();
    SCR_CLEAR<ConditionScript>();
    SCR_CLEAR<CreatureScript>();
    SCR_CLEAR<DatabaseScript>();
    SCR_CLEAR<DynamicObjectScript>();
    SCR_CLEAR<ElunaScript>();
    SCR_CLEAR<FormulaScript>();
    SCR_CLEAR<GameEventScript>();
    SCR_CLEAR<GameObjectScript>();
    SCR_CLEAR<GlobalScript>();
    SCR_CLEAR<GroupScript>();
    SCR_CLEAR<GuildScript>();
    SCR_CLEAR<InstanceMapScript>();
    SCR_CLEAR<ItemScript>();
    SCR_CLEAR<LootScript>();
    SCR_CLEAR<MailScript>();
    SCR_CLEAR<MiscScript>();
    SCR_CLEAR<MovementHandlerScript>();
    SCR_CLEAR<OutdoorPvPScript>();
    SCR_CLEAR<PetScript>();
    SCR_CLEAR<PlayerScript>();
    SCR_CLEAR<ServerScript>();
    SCR_CLEAR<SpellSC>();
    SCR_CLEAR<SpellScriptLoader>();
    SCR_CLEAR<TransportScript>();
    SCR_CLEAR<UnitScript>();
    SCR_CLEAR<VehicleScript>();
    SCR_CLEAR<WeatherScript>();
    SCR_CLEAR<WorldMapScript>();
    SCR_CLEAR<WorldObjectScript>();
    SCR_CLEAR<WorldScript>();

    delete[] SpellSummary;
}

void ScriptMgr::LoadDatabase()
{
    uint32 oldMSTime = getMSTime();

    sScriptSystemMgr->LoadScriptWaypoints();

    // Add all scripts that must be loaded after db/maps
    ScriptRegistry<WorldMapScript>::AddALScripts();
    ScriptRegistry<BattlegroundMapScript>::AddALScripts();
    ScriptRegistry<InstanceMapScript>::AddALScripts();
    ScriptRegistry<SpellScriptLoader>::AddALScripts();
    ScriptRegistry<ItemScript>::AddALScripts();
    ScriptRegistry<CreatureScript>::AddALScripts();
    ScriptRegistry<GameObjectScript>::AddALScripts();
    ScriptRegistry<AreaTriggerScript>::AddALScripts();
    ScriptRegistry<BattlegroundScript>::AddALScripts();
    ScriptRegistry<OutdoorPvPScript>::AddALScripts();
    ScriptRegistry<WeatherScript>::AddALScripts();
    ScriptRegistry<ConditionScript>::AddALScripts();
    ScriptRegistry<TransportScript>::AddALScripts();
    ScriptRegistry<AchievementCriteriaScript>::AddALScripts();

    FillSpellSummary();

    CheckIfScriptsInDatabaseExist();

    LOG_INFO("server.loading", ">> Loaded {} C++ scripts in {} ms", GetScriptCount(), GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
}

void ScriptMgr::CheckIfScriptsInDatabaseExist()
{
    for (auto const& scriptName : sObjectMgr->GetScriptNames())
    {
        if (uint32 sid = sObjectMgr->GetScriptId(scriptName.c_str()))
        {
            if (!ScriptRegistry<SpellScriptLoader>::GetScriptById(sid) &&
                !ScriptRegistry<ServerScript>::GetScriptById(sid) &&
                !ScriptRegistry<WorldScript>::GetScriptById(sid) &&
                !ScriptRegistry<FormulaScript>::GetScriptById(sid) &&
                !ScriptRegistry<WorldMapScript>::GetScriptById(sid) &&
                !ScriptRegistry<InstanceMapScript>::GetScriptById(sid) &&
                !ScriptRegistry<BattlegroundMapScript>::GetScriptById(sid) &&
                !ScriptRegistry<ItemScript>::GetScriptById(sid) &&
                !ScriptRegistry<CreatureScript>::GetScriptById(sid) &&
                !ScriptRegistry<GameObjectScript>::GetScriptById(sid) &&
                !ScriptRegistry<AreaTriggerScript>::GetScriptById(sid) &&
                !ScriptRegistry<BattlegroundScript>::GetScriptById(sid) &&
                !ScriptRegistry<OutdoorPvPScript>::GetScriptById(sid) &&
                !ScriptRegistry<CommandScript>::GetScriptById(sid) &&
                !ScriptRegistry<WeatherScript>::GetScriptById(sid) &&
                !ScriptRegistry<AuctionHouseScript>::GetScriptById(sid) &&
                !ScriptRegistry<ConditionScript>::GetScriptById(sid) &&
                !ScriptRegistry<VehicleScript>::GetScriptById(sid) &&
                !ScriptRegistry<DynamicObjectScript>::GetScriptById(sid) &&
                !ScriptRegistry<TransportScript>::GetScriptById(sid) &&
                !ScriptRegistry<AchievementCriteriaScript>::GetScriptById(sid) &&
                !ScriptRegistry<PlayerScript>::GetScriptById(sid) &&
                !ScriptRegistry<GuildScript>::GetScriptById(sid) &&
                !ScriptRegistry<BGScript>::GetScriptById(sid) &&
                !ScriptRegistry<AchievementScript>::GetScriptById(sid) &&
                !ScriptRegistry<ArenaTeamScript>::GetScriptById(sid) &&
                !ScriptRegistry<SpellSC>::GetScriptById(sid) &&
                !ScriptRegistry<MiscScript>::GetScriptById(sid) &&
                !ScriptRegistry<PetScript>::GetScriptById(sid) &&
                !ScriptRegistry<CommandSC>::GetScriptById(sid) &&
                !ScriptRegistry<ArenaScript>::GetScriptById(sid) &&
                !ScriptRegistry<GroupScript>::GetScriptById(sid) &&
                !ScriptRegistry<DatabaseScript>::GetScriptById(sid))
                {
                    LOG_ERROR("sql.sql", "Script named '{}' is assigned in the database, but has no code!", scriptName);
                }
        }
    }
}

void ScriptMgr::FillSpellSummary()
{
    UnitAI::FillAISpellInfo();

    SpellSummary = new TSpellSummary[sSpellMgr->GetSpellInfoStoreSize()];

    SpellInfo const* pTempSpell;

    for (uint32 i = 0; i < sSpellMgr->GetSpellInfoStoreSize(); ++i)
    {
        SpellSummary[i].Effects = 0;
        SpellSummary[i].Targets = 0;

        pTempSpell = sSpellMgr->GetSpellInfo(i);
        // This spell doesn't exist.
        if (!pTempSpell)
            continue;

        for (uint32 j = 0; j < MAX_SPELL_EFFECTS; ++j)
        {
            // Spell targets self.
            if (pTempSpell->Effects[j].TargetA.GetTarget() == TARGET_UNIT_CASTER)
                SpellSummary[i].Targets |= 1 << (SELECT_TARGET_SELF - 1);

            // Spell targets a single enemy.
            if (pTempSpell->Effects[j].TargetA.GetTarget() == TARGET_UNIT_TARGET_ENEMY ||
                    pTempSpell->Effects[j].TargetA.GetTarget() == TARGET_DEST_TARGET_ENEMY)
                SpellSummary[i].Targets |= 1 << (SELECT_TARGET_SINGLE_ENEMY - 1);

            // Spell targets AoE at enemy.
            if (pTempSpell->Effects[j].TargetA.GetTarget() == TARGET_UNIT_SRC_AREA_ENEMY ||
                    pTempSpell->Effects[j].TargetA.GetTarget() == TARGET_UNIT_DEST_AREA_ENEMY ||
                    pTempSpell->Effects[j].TargetA.GetTarget() == TARGET_SRC_CASTER ||
                    pTempSpell->Effects[j].TargetA.GetTarget() == TARGET_DEST_DYNOBJ_ENEMY)
                SpellSummary[i].Targets |= 1 << (SELECT_TARGET_AOE_ENEMY - 1);

            // Spell targets an enemy.
            if (pTempSpell->Effects[j].TargetA.GetTarget() == TARGET_UNIT_TARGET_ENEMY ||
                    pTempSpell->Effects[j].TargetA.GetTarget() == TARGET_DEST_TARGET_ENEMY ||
                    pTempSpell->Effects[j].TargetA.GetTarget() == TARGET_UNIT_SRC_AREA_ENEMY ||
                    pTempSpell->Effects[j].TargetA.GetTarget() == TARGET_UNIT_DEST_AREA_ENEMY ||
                    pTempSpell->Effects[j].TargetA.GetTarget() == TARGET_SRC_CASTER ||
                    pTempSpell->Effects[j].TargetA.GetTarget() == TARGET_DEST_DYNOBJ_ENEMY)
                SpellSummary[i].Targets |= 1 << (SELECT_TARGET_ANY_ENEMY - 1);

            // Spell targets a single friend (or self).
            if (pTempSpell->Effects[j].TargetA.GetTarget() == TARGET_UNIT_CASTER ||
                    pTempSpell->Effects[j].TargetA.GetTarget() == TARGET_UNIT_TARGET_ALLY ||
                    pTempSpell->Effects[j].TargetA.GetTarget() == TARGET_UNIT_TARGET_PARTY)
                SpellSummary[i].Targets |= 1 << (SELECT_TARGET_SINGLE_FRIEND - 1);

            // Spell targets AoE friends.
            if (pTempSpell->Effects[j].TargetA.GetTarget() == TARGET_UNIT_CASTER_AREA_PARTY ||
                    pTempSpell->Effects[j].TargetA.GetTarget() == TARGET_UNIT_LASTTARGET_AREA_PARTY ||
                    pTempSpell->Effects[j].TargetA.GetTarget() == TARGET_SRC_CASTER)
                SpellSummary[i].Targets |= 1 << (SELECT_TARGET_AOE_FRIEND - 1);

            // Spell targets any friend (or self).
            if (pTempSpell->Effects[j].TargetA.GetTarget() == TARGET_UNIT_CASTER ||
                    pTempSpell->Effects[j].TargetA.GetTarget() == TARGET_UNIT_TARGET_ALLY ||
                    pTempSpell->Effects[j].TargetA.GetTarget() == TARGET_UNIT_TARGET_PARTY ||
                    pTempSpell->Effects[j].TargetA.GetTarget() == TARGET_UNIT_CASTER_AREA_PARTY ||
                    pTempSpell->Effects[j].TargetA.GetTarget() == TARGET_UNIT_LASTTARGET_AREA_PARTY ||
                    pTempSpell->Effects[j].TargetA.GetTarget() == TARGET_SRC_CASTER)
                SpellSummary[i].Targets |= 1 << (SELECT_TARGET_ANY_FRIEND - 1);

            // Make sure that this spell includes a damage effect.
            if (pTempSpell->Effects[j].Effect == SPELL_EFFECT_SCHOOL_DAMAGE ||
                    pTempSpell->Effects[j].Effect == SPELL_EFFECT_INSTAKILL ||
                    pTempSpell->Effects[j].Effect == SPELL_EFFECT_ENVIRONMENTAL_DAMAGE ||
                    pTempSpell->Effects[j].Effect == SPELL_EFFECT_HEALTH_LEECH)
                SpellSummary[i].Effects |= 1 << (SELECT_EFFECT_DAMAGE - 1);

            // Make sure that this spell includes a healing effect (or an apply aura with a periodic heal).
            if (pTempSpell->Effects[j].Effect == SPELL_EFFECT_HEAL ||
                    pTempSpell->Effects[j].Effect == SPELL_EFFECT_HEAL_MAX_HEALTH ||
                    pTempSpell->Effects[j].Effect == SPELL_EFFECT_HEAL_MECHANICAL ||
                    (pTempSpell->Effects[j].Effect == SPELL_EFFECT_APPLY_AURA  && pTempSpell->Effects[j].ApplyAuraName == 8))
                SpellSummary[i].Effects |= 1 << (SELECT_EFFECT_HEALING - 1);

            // Make sure that this spell applies an aura.
            if (pTempSpell->Effects[j].Effect == SPELL_EFFECT_APPLY_AURA)
                SpellSummary[i].Effects |= 1 << (SELECT_EFFECT_AURA - 1);
        }
    }
}

///-
AllMapScript::AllMapScript(const char* name)
    : ScriptObject(name)
{
    ScriptRegistry<AllMapScript>::AddScript(this);
}

AllCreatureScript::AllCreatureScript(const char* name)
    : ScriptObject(name)
{
    ScriptRegistry<AllCreatureScript>::AddScript(this);
}

UnitScript::UnitScript(const char* name, bool addToScripts)
    : ScriptObject(name)
{
    if (addToScripts)
        ScriptRegistry<UnitScript>::AddScript(this);
}

MovementHandlerScript::MovementHandlerScript(const char* name)
    : ScriptObject(name)
{
    ScriptRegistry<MovementHandlerScript>::AddScript(this);
}

SpellScriptLoader::SpellScriptLoader(const char* name)
    : ScriptObject(name)
{
    ScriptRegistry<SpellScriptLoader>::AddScript(this);
}

ServerScript::ServerScript(const char* name)
    : ScriptObject(name)
{
    ScriptRegistry<ServerScript>::AddScript(this);
}

WorldScript::WorldScript(const char* name)
    : ScriptObject(name)
{
    ScriptRegistry<WorldScript>::AddScript(this);
}

FormulaScript::FormulaScript(const char* name)
    : ScriptObject(name)
{
    ScriptRegistry<FormulaScript>::AddScript(this);
}

WorldMapScript::WorldMapScript(const char* name, uint32 mapId)
    : ScriptObject(name), MapScript<Map>(mapId)
{
    ScriptRegistry<WorldMapScript>::AddScript(this);
}

InstanceMapScript::InstanceMapScript(const char* name, uint32 mapId)
    : ScriptObject(name), MapScript<InstanceMap>(mapId)
{
    ScriptRegistry<InstanceMapScript>::AddScript(this);
}

BattlegroundMapScript::BattlegroundMapScript(const char* name, uint32 mapId)
    : ScriptObject(name), MapScript<BattlegroundMap>(mapId)
{
    ScriptRegistry<BattlegroundMapScript>::AddScript(this);
}

ItemScript::ItemScript(const char* name)
    : ScriptObject(name)
{
    ScriptRegistry<ItemScript>::AddScript(this);
}

CreatureScript::CreatureScript(const char* name)
    : ScriptObject(name)
{
    ScriptRegistry<CreatureScript>::AddScript(this);
}

GameObjectScript::GameObjectScript(const char* name)
    : ScriptObject(name)
{
    ScriptRegistry<GameObjectScript>::AddScript(this);
}

AreaTriggerScript::AreaTriggerScript(const char* name)
    : ScriptObject(name)
{
    ScriptRegistry<AreaTriggerScript>::AddScript(this);
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
    {
        ResetAreaTriggerDone(instance, trigger->entry);
    }
}

BattlegroundScript::BattlegroundScript(const char* name)
    : ScriptObject(name)
{
    ScriptRegistry<BattlegroundScript>::AddScript(this);
}

OutdoorPvPScript::OutdoorPvPScript(const char* name)
    : ScriptObject(name)
{
    ScriptRegistry<OutdoorPvPScript>::AddScript(this);
}

CommandScript::CommandScript(const char* name)
    : ScriptObject(name)
{
    ScriptRegistry<CommandScript>::AddScript(this);
}

WeatherScript::WeatherScript(const char* name)
    : ScriptObject(name)
{
    ScriptRegistry<WeatherScript>::AddScript(this);
}

AuctionHouseScript::AuctionHouseScript(const char* name)
    : ScriptObject(name)
{
    ScriptRegistry<AuctionHouseScript>::AddScript(this);
}

ConditionScript::ConditionScript(const char* name)
    : ScriptObject(name)
{
    ScriptRegistry<ConditionScript>::AddScript(this);
}

VehicleScript::VehicleScript(const char* name)
    : ScriptObject(name)
{
    ScriptRegistry<VehicleScript>::AddScript(this);
}

DynamicObjectScript::DynamicObjectScript(const char* name)
    : ScriptObject(name)
{
    ScriptRegistry<DynamicObjectScript>::AddScript(this);
}

TransportScript::TransportScript(const char* name)
    : ScriptObject(name)
{
    ScriptRegistry<TransportScript>::AddScript(this);
}

AchievementCriteriaScript::AchievementCriteriaScript(const char* name)
    : ScriptObject(name)
{
    ScriptRegistry<AchievementCriteriaScript>::AddScript(this);
}

PlayerScript::PlayerScript(const char* name)
    : ScriptObject(name)
{
    ScriptRegistry<PlayerScript>::AddScript(this);
}

AccountScript::AccountScript(const char* name)
    : ScriptObject(name)
{
    ScriptRegistry<AccountScript>::AddScript(this);
}

GuildScript::GuildScript(const char* name)
    : ScriptObject(name)
{
    ScriptRegistry<GuildScript>::AddScript(this);
}

GroupScript::GroupScript(const char* name)
    : ScriptObject(name)
{
    ScriptRegistry<GroupScript>::AddScript(this);
}

GlobalScript::GlobalScript(const char* name)
    : ScriptObject(name)
{
    ScriptRegistry<GlobalScript>::AddScript(this);
}

BGScript::BGScript(char const* name)
    : ScriptObject(name)
{
    ScriptRegistry<BGScript>::AddScript(this);
}

ArenaTeamScript::ArenaTeamScript(const char* name)
    : ScriptObject(name)
{
    ScriptRegistry<ArenaTeamScript>::AddScript(this);
}

SpellSC::SpellSC(char const* name)
    : ScriptObject(name)
{
    ScriptRegistry<SpellSC>::AddScript(this);
}

ModuleScript::ModuleScript(const char* name)
    : ScriptObject(name)
{
    ScriptRegistry<ModuleScript>::AddScript(this);
}

GameEventScript::GameEventScript(const char* name)
    : ScriptObject(name)
{
    ScriptRegistry<GameEventScript>::AddScript(this);
}

MailScript::MailScript(const char* name)
    : ScriptObject(name)
{
    ScriptRegistry<MailScript>::AddScript(this);
}

AchievementScript::AchievementScript(const char* name)
    : ScriptObject(name)
{
    ScriptRegistry<AchievementScript>::AddScript(this);
}

PetScript::PetScript(const char* name)
    : ScriptObject(name)
{
    ScriptRegistry<PetScript>::AddScript(this);
}

ArenaScript::ArenaScript(const char* name)
    : ScriptObject(name)
{
    ScriptRegistry<ArenaScript>::AddScript(this);
}

MiscScript::MiscScript(const char* name)
    : ScriptObject(name)
{
    ScriptRegistry<MiscScript>::AddScript(this);
}

CommandSC::CommandSC(const char* name)
    : ScriptObject(name)
{
    ScriptRegistry<CommandSC>::AddScript(this);
}

DatabaseScript::DatabaseScript(const char* name) : ScriptObject(name)
{
    ScriptRegistry<DatabaseScript>::AddScript(this);
}

WorldObjectScript::WorldObjectScript(const char* name) : ScriptObject(name)
{
    ScriptRegistry<WorldObjectScript>::AddScript(this);
}

LootScript::LootScript(const char* name) : ScriptObject(name)
{
    ScriptRegistry<LootScript>::AddScript(this);
}

ElunaScript::ElunaScript(const char* name) : ScriptObject(name)
{
    ScriptRegistry<ElunaScript>::AddScript(this);
}

AllItemScript::AllItemScript(const char* name) : ScriptObject(name)
{
    ScriptRegistry<AllItemScript>::AddScript(this);
}

AllGameObjectScript::AllGameObjectScript(const char* name) : ScriptObject(name)
{
    ScriptRegistry<AllGameObjectScript>::AddScript(this);
}

// Specialize for each script type class like so:
template class AC_GAME_API ScriptRegistry<AccountScript>;
template class AC_GAME_API ScriptRegistry<AchievementCriteriaScript>;
template class AC_GAME_API ScriptRegistry<AchievementScript>;
template class AC_GAME_API ScriptRegistry<AllCreatureScript>;
template class AC_GAME_API ScriptRegistry<AllGameObjectScript>;
template class AC_GAME_API ScriptRegistry<AllItemScript>;
template class AC_GAME_API ScriptRegistry<AllMapScript>;
template class AC_GAME_API ScriptRegistry<AreaTriggerScript>;
template class AC_GAME_API ScriptRegistry<ArenaScript>;
template class AC_GAME_API ScriptRegistry<ArenaTeamScript>;
template class AC_GAME_API ScriptRegistry<AuctionHouseScript>;
template class AC_GAME_API ScriptRegistry<BGScript>;
template class AC_GAME_API ScriptRegistry<BattlegroundMapScript>;
template class AC_GAME_API ScriptRegistry<BattlegroundScript>;
template class AC_GAME_API ScriptRegistry<CommandSC>;
template class AC_GAME_API ScriptRegistry<CommandScript>;
template class AC_GAME_API ScriptRegistry<ConditionScript>;
template class AC_GAME_API ScriptRegistry<CreatureScript>;
template class AC_GAME_API ScriptRegistry<DatabaseScript>;
template class AC_GAME_API ScriptRegistry<DynamicObjectScript>;
template class AC_GAME_API ScriptRegistry<ElunaScript>;
template class AC_GAME_API ScriptRegistry<FormulaScript>;
template class AC_GAME_API ScriptRegistry<GameEventScript>;
template class AC_GAME_API ScriptRegistry<GameObjectScript>;
template class AC_GAME_API ScriptRegistry<GlobalScript>;
template class AC_GAME_API ScriptRegistry<GroupScript>;
template class AC_GAME_API ScriptRegistry<GuildScript>;
template class AC_GAME_API ScriptRegistry<InstanceMapScript>;
template class AC_GAME_API ScriptRegistry<ItemScript>;
template class AC_GAME_API ScriptRegistry<LootScript>;
template class AC_GAME_API ScriptRegistry<MailScript>;
template class AC_GAME_API ScriptRegistry<MiscScript>;
template class AC_GAME_API ScriptRegistry<MovementHandlerScript>;
template class AC_GAME_API ScriptRegistry<OutdoorPvPScript>;
template class AC_GAME_API ScriptRegistry<PetScript>;
template class AC_GAME_API ScriptRegistry<PlayerScript>;
template class AC_GAME_API ScriptRegistry<ServerScript>;
template class AC_GAME_API ScriptRegistry<SpellSC>;
template class AC_GAME_API ScriptRegistry<SpellScriptLoader>;
template class AC_GAME_API ScriptRegistry<TransportScript>;
template class AC_GAME_API ScriptRegistry<UnitScript>;
template class AC_GAME_API ScriptRegistry<VehicleScript>;
template class AC_GAME_API ScriptRegistry<WeatherScript>;
template class AC_GAME_API ScriptRegistry<WorldMapScript>;
template class AC_GAME_API ScriptRegistry<WorldObjectScript>;
template class AC_GAME_API ScriptRegistry<WorldScript>;

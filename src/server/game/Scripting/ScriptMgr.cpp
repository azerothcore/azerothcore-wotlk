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
#include "Chat.h"
#include "Config.h"
#include "CreatureAI.h"
#include "DBCStores.h"
#include "DatabaseEnv.h"
#include "GossipDef.h"
#include "InstanceScript.h"
#include "ObjectMgr.h"
#include "OutdoorPvPMgr.h"
#include "Player.h"
#include "ScriptMgrMacros.h"
#include "ScriptSystem.h"
#include "ScriptedGossip.h"
#include "SmartAI.h"
#include "SpellInfo.h"
#include "SpellScript.h"
#include "Transport.h"
#include "Vehicle.h"
#include "WorldPacket.h"

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

    template<class ScriptName>
    inline void ForeachMaps([[maybe_unused]] Map* map, [[maybe_unused]] std::function<void(ScriptName*)> executeHook)
    {
        static_assert(Acore::dependant_false_v<ScriptName>, "Unsupported type used for ForeachMaps");
    }

    template<>
    inline void ForeachMaps(Map* map, std::function<void(WorldMapScript*)> executeHook)
    {
        auto mapEntry = map->GetEntry();

        if (!mapEntry)
        {
            return;
        }

        if (!mapEntry->IsWorldMap())
        {
            return;
        }

        if (ScriptRegistry<WorldMapScript>::ScriptPointerList.empty())
        {
            return;
        }

        for (auto const& [scriptID, script] : ScriptRegistry<WorldMapScript>::ScriptPointerList)
        {
            MapEntry const* mapEntry = script->GetEntry();
            if (!mapEntry)
            {
                continue;
            }

            if (mapEntry->MapID != map->GetId())
            {
                continue;
            }

            executeHook(script);
            return;
        }
    }

    template<>
    inline void ForeachMaps(Map* map, std::function<void(InstanceMapScript*)> executeHook)
    {
        auto mapEntry = map->GetEntry();

        if (!mapEntry)
        {
            return;
        }

        if (!mapEntry->IsDungeon())
        {
            return;
        }

        if (ScriptRegistry<InstanceMapScript>::ScriptPointerList.empty())
        {
            return;
        }

        for (auto const& [scriptID, script] : ScriptRegistry<InstanceMapScript>::ScriptPointerList)
        {
            MapEntry const* mapEntry = script->GetEntry();
            if (!mapEntry)
            {
                continue;
            }

            if (mapEntry->MapID != map->GetId())
            {
                continue;
            }

            executeHook(script);
            return;
        }
    }

    template<>
    inline void ForeachMaps(Map* map, std::function<void(BattlegroundMapScript*)> executeHook)
    {
        auto mapEntry = map->GetEntry();

        if (!mapEntry)
        {
            return;
        }

        if (!mapEntry->IsBattleground())
        {
            return;
        }

        if (ScriptRegistry<BattlegroundMapScript>::ScriptPointerList.empty())
        {
            return;
        }

        for (auto const& [scriptID, script] : ScriptRegistry<BattlegroundMapScript>::ScriptPointerList)
        {
            MapEntry const* mapEntry = script->GetEntry();
            if (!mapEntry)
            {
                continue;
            }

            if (mapEntry->MapID != map->GetId())
            {
                continue;
            }

            executeHook(script);
            return;
        }
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

    LOG_INFO("server.loading", ">> Loaded %u C++ scripts in %u ms", GetScriptCount(), GetMSTimeDiffToNow(oldMSTime));
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
                    LOG_ERROR("sql.sql", "Script named '%s' is assigned in the database, but has no code!", scriptName.c_str());
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

void ScriptMgr::CreateSpellScripts(uint32 spellId, std::list<SpellScript*>& scriptVector)
{
    SpellScriptsBounds bounds = sObjectMgr->GetSpellScriptsBounds(spellId);

    for (SpellScriptsContainer::iterator itr = bounds.first; itr != bounds.second; ++itr)
    {
        SpellScriptLoader* tempScript = ScriptRegistry<SpellScriptLoader>::GetScriptById(itr->second);
        if (!tempScript)
            continue;

        SpellScript* script = tempScript->GetSpellScript();

        if (!script)
            continue;

        script->_Init(&tempScript->GetName(), spellId);

        scriptVector.push_back(script);
    }
}

void ScriptMgr::CreateAuraScripts(uint32 spellId, std::list<AuraScript*>& scriptVector)
{
    SpellScriptsBounds bounds = sObjectMgr->GetSpellScriptsBounds(spellId);

    for (SpellScriptsContainer::iterator itr = bounds.first; itr != bounds.second; ++itr)
    {
        SpellScriptLoader* tempScript = ScriptRegistry<SpellScriptLoader>::GetScriptById(itr->second);
        if (!tempScript)
            continue;

        AuraScript* script = tempScript->GetAuraScript();

        if (!script)
            continue;

        script->_Init(&tempScript->GetName(), spellId);

        scriptVector.push_back(script);
    }
}

void ScriptMgr::CreateSpellScriptLoaders(uint32 spellId, std::vector<std::pair<SpellScriptLoader*, SpellScriptsContainer::iterator> >& scriptVector)
{
    SpellScriptsBounds bounds = sObjectMgr->GetSpellScriptsBounds(spellId);
    scriptVector.reserve(std::distance(bounds.first, bounds.second));

    for (SpellScriptsContainer::iterator itr = bounds.first; itr != bounds.second; ++itr)
    {
        SpellScriptLoader* tempScript = ScriptRegistry<SpellScriptLoader>::GetScriptById(itr->second);
        if (!tempScript)
            continue;

        scriptVector.emplace_back(tempScript, itr);
    }
}

void ScriptMgr::OnBeforePlayerDurabilityRepair(Player* player, ObjectGuid npcGUID, ObjectGuid itemGUID, float& discountMod, uint8 guildBank)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnBeforeDurabilityRepair(player, npcGUID, itemGUID, discountMod, guildBank);
    });
}

void ScriptMgr::OnNetworkStart()
{
    ExecuteScript<ServerScript>([&](ServerScript* script)
    {
        script->OnNetworkStart();
    });
}

void ScriptMgr::OnNetworkStop()
{
    ExecuteScript<ServerScript>([&](ServerScript* script)
    {
        script->OnNetworkStop();
    });
}

void ScriptMgr::OnSocketOpen(std::shared_ptr<WorldSocket> socket)
{
    ASSERT(socket);

    ExecuteScript<ServerScript>([&](ServerScript* script)
    {
        script->OnSocketOpen(socket);
    });
}

void ScriptMgr::OnSocketClose(std::shared_ptr<WorldSocket> socket)
{
    ASSERT(socket);

    ExecuteScript<ServerScript>([&](ServerScript* script)
    {
        script->OnSocketClose(socket);
    });
}

bool ScriptMgr::CanPacketReceive(WorldSession* session, WorldPacket const& packet)
{
    if (ScriptRegistry<ServerScript>::ScriptPointerList.empty())
        return true;

    WorldPacket copy(packet);

    auto ret = IsValidBoolScript<ServerScript>([&](ServerScript* script)
    {
        return !script->CanPacketReceive(session, copy);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

bool ScriptMgr::CanPacketSend(WorldSession* session, WorldPacket const& packet)
{
    ASSERT(session);

    if (ScriptRegistry<ServerScript>::ScriptPointerList.empty())
        return true;

    WorldPacket copy(packet);

    auto ret = IsValidBoolScript<ServerScript>([&](ServerScript* script)
    {
        return !script->CanPacketSend(session, copy);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

void ScriptMgr::OnOpenStateChange(bool open)
{
    ExecuteScript<WorldScript>([&](WorldScript* script)
    {
        script->OnOpenStateChange(open);
    });
}

void ScriptMgr::OnLoadCustomDatabaseTable()
{
    ExecuteScript<WorldScript>([&](WorldScript* script)
    {
        script->OnLoadCustomDatabaseTable();
    });
}

void ScriptMgr::OnBeforeConfigLoad(bool reload)
{
    ExecuteScript<WorldScript>([&](WorldScript* script)
    {
        script->OnBeforeConfigLoad(reload);
    });
}

void ScriptMgr::OnAfterConfigLoad(bool reload)
{
    ExecuteScript<WorldScript>([&](WorldScript* script)
    {
        script->OnAfterConfigLoad(reload);
    });
}

void ScriptMgr::OnBeforeFinalizePlayerWorldSession(uint32& cacheVersion)
{
    ExecuteScript<WorldScript>([&](WorldScript* script)
    {
        script->OnBeforeFinalizePlayerWorldSession(cacheVersion);
    });
}

void ScriptMgr::OnMotdChange(std::string& newMotd)
{
    ExecuteScript<WorldScript>([&](WorldScript* script)
    {
        script->OnMotdChange(newMotd);
    });
}

void ScriptMgr::OnShutdownInitiate(ShutdownExitCode code, ShutdownMask mask)
{
    ExecuteScript<WorldScript>([&](WorldScript* script)
    {
        script->OnShutdownInitiate(code, mask);
    });
}

void ScriptMgr::OnShutdownCancel()
{
    ExecuteScript<WorldScript>([&](WorldScript* script)
    {
        script->OnShutdownCancel();
    });
}

void ScriptMgr::OnWorldUpdate(uint32 diff)
{
    ExecuteScript<WorldScript>([&](WorldScript* script)
    {
        script->OnUpdate(diff);
    });
}

void ScriptMgr::OnHonorCalculation(float& honor, uint8 level, float multiplier)
{
    ExecuteScript<FormulaScript>([&](FormulaScript* script)
    {
        script->OnHonorCalculation(honor, level, multiplier);
    });
}

void ScriptMgr::OnGrayLevelCalculation(uint8& grayLevel, uint8 playerLevel)
{
    ExecuteScript<FormulaScript>([&](FormulaScript* script)
    {
        script->OnGrayLevelCalculation(grayLevel, playerLevel);
    });
}

void ScriptMgr::OnColorCodeCalculation(XPColorChar& color, uint8 playerLevel, uint8 mobLevel)
{
    ExecuteScript<FormulaScript>([&](FormulaScript* script)
    {
        script->OnColorCodeCalculation(color, playerLevel, mobLevel);
    });
}

void ScriptMgr::OnZeroDifferenceCalculation(uint8& diff, uint8 playerLevel)
{
    ExecuteScript<FormulaScript>([&](FormulaScript* script)
    {
        script->OnZeroDifferenceCalculation(diff, playerLevel);
    });
}

void ScriptMgr::OnBaseGainCalculation(uint32& gain, uint8 playerLevel, uint8 mobLevel, ContentLevels content)
{
    ExecuteScript<FormulaScript>([&](FormulaScript* script)
    {
        script->OnBaseGainCalculation(gain, playerLevel, mobLevel, content);
    });
}

void ScriptMgr::OnGainCalculation(uint32& gain, Player* player, Unit* unit)
{
    ASSERT(player);
    ASSERT(unit);

    ExecuteScript<FormulaScript>([&](FormulaScript* script)
    {
        script->OnGainCalculation(gain, player, unit);
    });
}

void ScriptMgr::OnGroupRateCalculation(float& rate, uint32 count, bool isRaid)
{
    ExecuteScript<FormulaScript>([&](FormulaScript* script)
    {
        script->OnGroupRateCalculation(rate, count, isRaid);
    });
}

void ScriptMgr::OnCreateMap(Map* map)
{
    ASSERT(map);

    ExecuteScript<AllMapScript>([&](AllMapScript* script)
    {
        script->OnCreateMap(map);
    });

    ForeachMaps<WorldMapScript>(map,
        [&](WorldMapScript* script)
        {
            script->OnCreate(map);
        });

    ForeachMaps<InstanceMapScript>(map,
        [&](InstanceMapScript* script)
        {
            script->OnCreate((InstanceMap*)map);
        });

    ForeachMaps<BattlegroundMapScript>(map,
        [&](BattlegroundMapScript* script)
        {
            script->OnCreate((BattlegroundMap*)map);
        });
}

void ScriptMgr::OnDestroyMap(Map* map)
{
    ASSERT(map);

    ExecuteScript<AllMapScript>([&](AllMapScript* script)
    {
        script->OnDestroyMap(map);
    });

    ForeachMaps<WorldMapScript>(map,
        [&](WorldMapScript* script)
        {
            script->OnDestroy(map);
        });

    ForeachMaps<InstanceMapScript>(map,
        [&](InstanceMapScript* script)
        {
            script->OnDestroy((InstanceMap*)map);
        });

    ForeachMaps<BattlegroundMapScript>(map,
        [&](BattlegroundMapScript* script)
        {
            script->OnDestroy((BattlegroundMap*)map);
        });
}

void ScriptMgr::OnLoadGridMap(Map* map, GridMap* gmap, uint32 gx, uint32 gy)
{
    ASSERT(map);
    ASSERT(gmap);

    ForeachMaps<WorldMapScript>(map,
        [&](WorldMapScript* script)
        {
            script->OnLoadGridMap(map, gmap, gx, gy);
        });

    ForeachMaps<InstanceMapScript>(map,
        [&](InstanceMapScript* script)
        {
            script->OnLoadGridMap((InstanceMap*)map, gmap, gx, gy);
        });

    ForeachMaps<BattlegroundMapScript>(map,
        [&](BattlegroundMapScript* script)
        {
            script->OnLoadGridMap((BattlegroundMap*)map, gmap, gx, gy);
        });
}

void ScriptMgr::OnUnloadGridMap(Map* map, GridMap* gmap, uint32 gx, uint32 gy)
{
    ASSERT(map);
    ASSERT(gmap);

    ForeachMaps<WorldMapScript>(map,
        [&](WorldMapScript* script)
        {
            script->OnUnloadGridMap(map, gmap, gx, gy);
        });

    ForeachMaps<InstanceMapScript>(map,
        [&](InstanceMapScript* script)
        {
            script->OnUnloadGridMap((InstanceMap*)map, gmap, gx, gy);
        });

    ForeachMaps<BattlegroundMapScript>(map,
        [&](BattlegroundMapScript* script)
        {
            script->OnUnloadGridMap((BattlegroundMap*)map, gmap, gx, gy);
        });
}

void ScriptMgr::OnPlayerEnterMap(Map* map, Player* player)
{
    ASSERT(map);
    ASSERT(player);

    ExecuteScript<AllMapScript>([&](AllMapScript* script)
    {
        script->OnPlayerEnterAll(map, player);
    });

    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnMapChanged(player);
    });

    ForeachMaps<WorldMapScript>(map,
        [&](WorldMapScript* script)
        {
            script->OnPlayerEnter(map, player);
        });

    ForeachMaps<InstanceMapScript>(map,
        [&](InstanceMapScript* script)
        {
            script->OnPlayerEnter((InstanceMap*)map, player);
        });

    ForeachMaps<BattlegroundMapScript>(map,
        [&](BattlegroundMapScript* script)
        {
            script->OnPlayerEnter((BattlegroundMap*)map, player);
        });
}

void ScriptMgr::OnPlayerLeaveMap(Map* map, Player* player)
{
    ASSERT(map);
    ASSERT(player);

    ExecuteScript<AllMapScript>([&](AllMapScript* script)
    {
        script->OnPlayerLeaveAll(map, player);
    });

    ForeachMaps<WorldMapScript>(map,
        [&](WorldMapScript* script)
        {
            script->OnPlayerLeave(map, player);
        });

    ForeachMaps<InstanceMapScript>(map,
        [&](InstanceMapScript* script)
        {
            script->OnPlayerLeave((InstanceMap*)map, player);
        });

    ForeachMaps<BattlegroundMapScript>(map,
        [&](BattlegroundMapScript* script)
        {
            script->OnPlayerLeave((BattlegroundMap*)map, player);
        });
}

void ScriptMgr::OnMapUpdate(Map* map, uint32 diff)
{
    ASSERT(map);

    ExecuteScript<AllMapScript>([&](AllMapScript* script)
    {
        script->OnMapUpdate(map, diff);
    });

    ForeachMaps<WorldMapScript>(map,
        [&](WorldMapScript* script)
        {
            script->OnUpdate(map, diff);
        });

    ForeachMaps<InstanceMapScript>(map,
        [&](InstanceMapScript* script)
        {
            script->OnUpdate((InstanceMap*)map, diff);
        });

    ForeachMaps<BattlegroundMapScript>(map,
        [&](BattlegroundMapScript* script)
        {
            script->OnUpdate((BattlegroundMap*)map, diff);
        });
}

InstanceScript* ScriptMgr::CreateInstanceScript(InstanceMap* map)
{
    ASSERT(map);

    auto tempScript = ScriptRegistry<InstanceMapScript>::GetScriptById(map->GetScriptId());
    return tempScript ? tempScript->GetInstanceScript(map) : nullptr;
}

bool ScriptMgr::OnQuestAccept(Player* player, Item* item, Quest const* quest)
{
    ASSERT(player);
    ASSERT(item);
    ASSERT(quest);

    auto ret = IsValidBoolScript<AllItemScript>([&](AllItemScript* script)
    {
        return !script->CanItemQuestAccept(player, item, quest);
    });

    if (ret && *ret)
    {
        return false;
    }

    auto tempScript = ScriptRegistry<ItemScript>::GetScriptById(item->GetScriptId());
    ClearGossipMenuFor(player);
    return tempScript ? tempScript->OnQuestAccept(player, item, quest) : false;
}

bool ScriptMgr::OnItemUse(Player* player, Item* item, SpellCastTargets const& targets)
{
    ASSERT(player);
    ASSERT(item);

    auto ret = IsValidBoolScript<AllItemScript>([&](AllItemScript* script)
    {
        return script->CanItemUse(player, item, targets);
    });

    if (ret && *ret)
    {
        return true;
    }

    auto tempScript = ScriptRegistry<ItemScript>::GetScriptById(item->GetScriptId());
    return tempScript ? tempScript->OnUse(player, item, targets) : false;
}

bool ScriptMgr::OnItemExpire(Player* player, ItemTemplate const* proto)
{
    ASSERT(player);
    ASSERT(proto);

    auto ret = IsValidBoolScript<AllItemScript>([&](AllItemScript* script)
    {
        return !script->CanItemExpire(player, proto);
    });

    if (ret && *ret)
    {
        return false;
    }

    auto tempScript = ScriptRegistry<ItemScript>::GetScriptById(proto->ScriptId);
    return tempScript ? tempScript->OnExpire(player, proto) : false;
}

bool ScriptMgr::OnItemRemove(Player* player, Item* item)
{
    ASSERT(player);
    ASSERT(item);

    auto ret = IsValidBoolScript<AllItemScript>([&](AllItemScript* script)
    {
        return !script->CanItemRemove(player, item);
    });

    if (ret && *ret)
    {
        return false;
    }

    auto tempScript = ScriptRegistry<ItemScript>::GetScriptById(item->GetScriptId());
    return tempScript ? tempScript->OnRemove(player, item) : false;
}

bool ScriptMgr::OnCastItemCombatSpell(Player* player, Unit* victim, SpellInfo const* spellInfo, Item* item)
{
    ASSERT(player);
    ASSERT(victim);
    ASSERT(spellInfo);
    ASSERT(item);

    auto tempScript = ScriptRegistry<ItemScript>::GetScriptById(item->GetScriptId());
    return tempScript ? tempScript->OnCastItemCombatSpell(player, victim, spellInfo, item) : true;
}

void ScriptMgr::OnGossipSelect(Player* player, Item* item, uint32 sender, uint32 action)
{
    ASSERT(player);
    ASSERT(item);

    ExecuteScript<AllItemScript>([&](AllItemScript* script)
    {
        script->OnItemGossipSelect(player, item, sender, action);
    });

    if (auto tempScript = ScriptRegistry<ItemScript>::GetScriptById(item->GetScriptId()))
    {
        tempScript->OnGossipSelect(player, item, sender, action);
    }
}

void ScriptMgr::OnGossipSelectCode(Player* player, Item* item, uint32 sender, uint32 action, const char* code)
{
    ASSERT(player);
    ASSERT(item);

    ExecuteScript<AllItemScript>([&](AllItemScript* script)
    {
        script->OnItemGossipSelectCode(player, item, sender, action, code);
    });

    if (auto tempScript = ScriptRegistry<ItemScript>::GetScriptById(item->GetScriptId()))
    {
        tempScript->OnGossipSelectCode(player, item, sender, action, code);
    }
}

void ScriptMgr::OnGossipSelect(Player* player, uint32 menu_id, uint32 sender, uint32 action)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnGossipSelect(player, menu_id, sender, action);
    });
}

void ScriptMgr::OnGossipSelectCode(Player* player, uint32 menu_id, uint32 sender, uint32 action, const char* code)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnGossipSelectCode(player, menu_id, sender, action, code);
    });
}

bool ScriptMgr::OnGossipHello(Player* player, Creature* creature)
{
    ASSERT(player);
    ASSERT(creature);

    auto ret = IsValidBoolScript<AllCreatureScript>([&](AllCreatureScript* script)
    {
        return script->CanCreatureGossipHello(player, creature);
    });

    if (ret && *ret)
    {
        return true;
    }

    auto tempScript = ScriptRegistry<CreatureScript>::GetScriptById(creature->GetScriptId());
    ClearGossipMenuFor(player);
    return tempScript ? tempScript->OnGossipHello(player, creature) : false;
}

bool ScriptMgr::OnGossipSelect(Player* player, Creature* creature, uint32 sender, uint32 action)
{
    ASSERT(player);
    ASSERT(creature);

    auto ret = IsValidBoolScript<AllCreatureScript>([&](AllCreatureScript* script)
    {
        return script->CanCreatureGossipSelect(player, creature, sender, action);
    });

    if (ret && *ret)
    {
        return true;
    }

    auto tempScript = ScriptRegistry<CreatureScript>::GetScriptById(creature->GetScriptId());
    return tempScript ? tempScript->OnGossipSelect(player, creature, sender, action) : false;
}

bool ScriptMgr::OnGossipSelectCode(Player* player, Creature* creature, uint32 sender, uint32 action, const char* code)
{
    ASSERT(player);
    ASSERT(creature);
    ASSERT(code);

    auto ret = IsValidBoolScript<AllCreatureScript>([&](AllCreatureScript* script)
    {
        return script->CanCreatureGossipSelectCode(player, creature, sender, action, code);
    });

    if (ret && *ret)
    {
        return true;
    }

    auto tempScript = ScriptRegistry<CreatureScript>::GetScriptById(creature->GetScriptId());
    return tempScript ? tempScript->OnGossipSelectCode(player, creature, sender, action, code) : false;
}

bool ScriptMgr::OnQuestAccept(Player* player, Creature* creature, Quest const* quest)
{
    ASSERT(player);
    ASSERT(creature);
    ASSERT(quest);

    auto ret = IsValidBoolScript<AllCreatureScript>([&](AllCreatureScript* script)
    {
        return script->CanCreatureQuestAccept(player, creature, quest);
    });

    if (ret && *ret)
    {
        return true;
    }

    auto tempScript = ScriptRegistry<CreatureScript>::GetScriptById(creature->GetScriptId());
    ClearGossipMenuFor(player);
    return tempScript ? tempScript->OnQuestAccept(player, creature, quest) : false;
}

bool ScriptMgr::OnQuestSelect(Player* player, Creature* creature, Quest const* quest)
{
    ASSERT(player);
    ASSERT(creature);
    ASSERT(quest);

    auto tempScript = ScriptRegistry<CreatureScript>::GetScriptById(creature->GetScriptId());
    ClearGossipMenuFor(player);
    return tempScript ? tempScript->OnQuestSelect(player, creature, quest) : false;
}

bool ScriptMgr::OnQuestComplete(Player* player, Creature* creature, Quest const* quest)
{
    ASSERT(player);
    ASSERT(creature);
    ASSERT(quest);

    auto tempScript = ScriptRegistry<CreatureScript>::GetScriptById(creature->GetScriptId());
    ClearGossipMenuFor(player);
    return tempScript ? tempScript->OnQuestComplete(player, creature, quest) : false;
}

bool ScriptMgr::OnQuestReward(Player* player, Creature* creature, Quest const* quest, uint32 opt)
{
    ASSERT(player);
    ASSERT(creature);
    ASSERT(quest);

    auto ret = IsValidBoolScript<AllCreatureScript>([&](AllCreatureScript* script)
    {
        return script->CanCreatureQuestReward(player, creature, quest, opt);
    });

    if (ret && *ret)
    {
        return true;
    }

    auto tempScript = ScriptRegistry<CreatureScript>::GetScriptById(creature->GetScriptId());
    ClearGossipMenuFor(player);
    return tempScript ? tempScript->OnQuestReward(player, creature, quest, opt) : false;
}

uint32 ScriptMgr::GetDialogStatus(Player* player, Creature* creature)
{
    ASSERT(player);
    ASSERT(creature);

    auto tempScript = ScriptRegistry<CreatureScript>::GetScriptById(creature->GetScriptId());
    ClearGossipMenuFor(player);
    return tempScript ? tempScript->GetDialogStatus(player, creature) : DIALOG_STATUS_SCRIPTED_NO_STATUS;
}

CreatureAI* ScriptMgr::GetCreatureAI(Creature* creature)
{
    ASSERT(creature);

    auto retAI = GetReturnAIScript<AllCreatureScript, CreatureAI>([creature](AllCreatureScript* script)
    {
        return script->GetCreatureAI(creature);
    });

    if (retAI)
    {
        return retAI;
    }

    auto tempScript = ScriptRegistry<CreatureScript>::GetScriptById(creature->GetScriptId());
    return tempScript ? tempScript->GetAI(creature) : nullptr;
}

void ScriptMgr::OnCreatureUpdate(Creature* creature, uint32 diff)
{
    ASSERT(creature);

    ExecuteScript<AllCreatureScript>([&](AllCreatureScript* script)
    {
        script->OnAllCreatureUpdate(creature, diff);
    });

    if (auto tempScript = ScriptRegistry<CreatureScript>::GetScriptById(creature->GetScriptId()))
    {
        tempScript->OnUpdate(creature, diff);
    }
}

void ScriptMgr::OnCreatureAddWorld(Creature* creature)
{
    ASSERT(creature);
    ExecuteScript<AllCreatureScript>([&](AllCreatureScript* script)
    {
        script->OnCreatureAddWorld(creature);
    });
}

void ScriptMgr::OnCreatureRemoveWorld(Creature* creature)
{
    ASSERT(creature);
    ExecuteScript<AllCreatureScript>([&](AllCreatureScript* script)
    {
        script->OnCreatureRemoveWorld(creature);
    });
}

bool ScriptMgr::OnGossipHello(Player* player, GameObject* go)
{
    ASSERT(player);
    ASSERT(go);

    auto ret = IsValidBoolScript<AllGameObjectScript>([&](AllGameObjectScript* script)
    {
        return script->CanGameObjectGossipHello(player, go);
    });

    if (ret && *ret)
    {
        return true;
    }

    auto tempScript = ScriptRegistry<GameObjectScript>::GetScriptById(go->GetScriptId());
    ClearGossipMenuFor(player);
    return tempScript ? tempScript->OnGossipHello(player, go) : false;
}

bool ScriptMgr::OnGossipSelect(Player* player, GameObject* go, uint32 sender, uint32 action)
{
    ASSERT(player);
    ASSERT(go);

    auto ret = IsValidBoolScript<AllGameObjectScript>([&](AllGameObjectScript* script)
    {
        return script->CanGameObjectGossipSelect(player, go, sender, action);
    });

    if (ret && *ret)
    {
        return true;
    }

    auto tempScript = ScriptRegistry<GameObjectScript>::GetScriptById(go->GetScriptId());
    return tempScript ? tempScript->OnGossipSelect(player, go, sender, action) : false;
}

bool ScriptMgr::OnGossipSelectCode(Player* player, GameObject* go, uint32 sender, uint32 action, const char* code)
{
    ASSERT(player);
    ASSERT(go);
    ASSERT(code);

    auto ret = IsValidBoolScript<AllGameObjectScript>([&](AllGameObjectScript* script)
    {
        return script->CanGameObjectGossipSelectCode(player, go, sender, action, code);
    });

    if (ret && *ret)
    {
        return true;
    }

    auto tempScript = ScriptRegistry<GameObjectScript>::GetScriptById(go->GetScriptId());
    return tempScript ? tempScript->OnGossipSelectCode(player, go, sender, action, code) : false;
}

bool ScriptMgr::OnQuestAccept(Player* player, GameObject* go, Quest const* quest)
{
    ASSERT(player);
    ASSERT(go);
    ASSERT(quest);

    auto ret = IsValidBoolScript<AllGameObjectScript>([&](AllGameObjectScript* script)
    {
        return script->CanGameObjectQuestAccept(player, go, quest);
    });

    if (ret && *ret)
    {
        return true;
    }

    auto tempScript = ScriptRegistry<GameObjectScript>::GetScriptById(go->GetScriptId());
    ClearGossipMenuFor(player);
    return tempScript ? tempScript->OnQuestAccept(player, go, quest) : false;
}

bool ScriptMgr::OnQuestReward(Player* player, GameObject* go, Quest const* quest, uint32 opt)
{
    ASSERT(player);
    ASSERT(go);
    ASSERT(quest);

    auto ret = IsValidBoolScript<AllGameObjectScript>([&](AllGameObjectScript* script)
    {
        return script->CanGameObjectQuestReward(player, go, quest, opt);
    });

    if (ret && *ret)
    {
        return true;
    }

    auto tempScript = ScriptRegistry<GameObjectScript>::GetScriptById(go->GetScriptId());
    ClearGossipMenuFor(player);
    return tempScript ? tempScript->OnQuestReward(player, go, quest, opt) : false;
}

uint32 ScriptMgr::GetDialogStatus(Player* player, GameObject* go)
{
    ASSERT(player);
    ASSERT(go);

    auto tempScript = ScriptRegistry<GameObjectScript>::GetScriptById(go->GetScriptId());
    ClearGossipMenuFor(player);
    return tempScript ? tempScript->GetDialogStatus(player, go) : DIALOG_STATUS_SCRIPTED_NO_STATUS;
}

void ScriptMgr::OnGameObjectDestroyed(GameObject* go, Player* player)
{
    ASSERT(go);

    ExecuteScript<AllGameObjectScript>([&](AllGameObjectScript* script)
    {
        script->OnGameObjectDestroyed(go, player);
    });

    if (auto tempScript = ScriptRegistry<GameObjectScript>::GetScriptById(go->GetScriptId()))
    {
        tempScript->OnDestroyed(go, player);
    }
}

void ScriptMgr::OnGameObjectDamaged(GameObject* go, Player* player)
{
    ASSERT(go);

    ExecuteScript<AllGameObjectScript>([&](AllGameObjectScript* script)
    {
        script->OnGameObjectDamaged(go, player);
    });

    if (auto tempScript = ScriptRegistry<GameObjectScript>::GetScriptById(go->GetScriptId()))
    {
        tempScript->OnDamaged(go, player);
    }
}

void ScriptMgr::OnGameObjectLootStateChanged(GameObject* go, uint32 state, Unit* unit)
{
    ASSERT(go);

    ExecuteScript<AllGameObjectScript>([&](AllGameObjectScript* script)
    {
        script->OnGameObjectLootStateChanged(go, state, unit);
    });

    if (auto tempScript = ScriptRegistry<GameObjectScript>::GetScriptById(go->GetScriptId()))
    {
        tempScript->OnLootStateChanged(go, state, unit);
    }
}

void ScriptMgr::OnGameObjectStateChanged(GameObject* go, uint32 state)
{
    ASSERT(go);

    ExecuteScript<AllGameObjectScript>([&](AllGameObjectScript* script)
    {
        script->OnGameObjectStateChanged(go, state);
    });

    if (auto tempScript = ScriptRegistry<GameObjectScript>::GetScriptById(go->GetScriptId()))
    {
        tempScript->OnGameObjectStateChanged(go, state);
    }
}

void ScriptMgr::OnGameObjectUpdate(GameObject* go, uint32 diff)
{
    ASSERT(go);

    ExecuteScript<AllGameObjectScript>([&](AllGameObjectScript* script)
    {
        script->OnGameObjectUpdate(go, diff);
    });

    if (auto tempScript = ScriptRegistry<GameObjectScript>::GetScriptById(go->GetScriptId()))
    {
        tempScript->OnUpdate(go, diff);
    }
}

GameObjectAI* ScriptMgr::GetGameObjectAI(GameObject* go)
{
    ASSERT(go);

    auto retAI = GetReturnAIScript<AllGameObjectScript, GameObjectAI>([go](AllGameObjectScript* script)
    {
        return script->GetGameObjectAI(go);
    });

    if (retAI)
    {
        return retAI;
    }

    auto tempScript = ScriptRegistry<GameObjectScript>::GetScriptById(go->GetScriptId());
    return tempScript ? tempScript->GetAI(go) : nullptr;
}

void ScriptMgr::OnGameObjectAddWorld(GameObject* go)
{
    ASSERT(go);
    ExecuteScript<AllGameObjectScript>([&](AllGameObjectScript* script)
    {
        script->OnGameObjectAddWorld(go);
    });
}

void ScriptMgr::OnGameObjectRemoveWorld(GameObject* go)
{
    ASSERT(go);
    ExecuteScript<AllGameObjectScript>([&](AllGameObjectScript* script)
    {
        script->OnGameObjectRemoveWorld(go);
    });
}

bool ScriptMgr::OnAreaTrigger(Player* player, AreaTrigger const* trigger)
{
    ASSERT(player);
    ASSERT(trigger);

    auto ret = IsValidBoolScript<ElunaScript>([&](ElunaScript* script)
    {
        return script->CanAreaTrigger(player, trigger);
    });

    if (ret && *ret)
    {
        return false;
    }

    auto tempScript = ScriptRegistry<AreaTriggerScript>::GetScriptById(sObjectMgr->GetAreaTriggerScriptId(trigger->entry));
    return tempScript ? tempScript->OnTrigger(player, trigger) : false;
}

Battleground* ScriptMgr::CreateBattleground(BattlegroundTypeId /*typeId*/)
{
    // TODO: Implement script-side battlegrounds.
    ABORT();
    return nullptr;
}

OutdoorPvP* ScriptMgr::CreateOutdoorPvP(OutdoorPvPData const* data)
{
    ASSERT(data);

    auto tempScript = ScriptRegistry<OutdoorPvPScript>::GetScriptById(data->ScriptId);
    return tempScript ? tempScript->GetOutdoorPvP() : nullptr;
}

Acore::ChatCommands::ChatCommandTable ScriptMgr::GetChatCommands()
{
    Acore::ChatCommands::ChatCommandTable table;

    for (auto const& [scriptID, script] : ScriptRegistry<CommandScript>::ScriptPointerList)
    {
        Acore::ChatCommands::ChatCommandTable cmds = script->GetCommands();
        std::move(cmds.begin(), cmds.end(), std::back_inserter(table));
    }

    return table;
}

void ScriptMgr::OnWeatherChange(Weather* weather, WeatherState state, float grade)
{
    ASSERT(weather);

    ExecuteScript<ElunaScript>([&](ElunaScript* script)
    {
        script->OnWeatherChange(weather, state, grade);
    });

    if (auto tempScript = ScriptRegistry<WeatherScript>::GetScriptById(weather->GetScriptId()))
    {
        tempScript->OnChange(weather, state, grade);
    }
}

void ScriptMgr::OnWeatherUpdate(Weather* weather, uint32 diff)
{
    ASSERT(weather);

    if (auto tempScript = ScriptRegistry<WeatherScript>::GetScriptById(weather->GetScriptId()))
    {
        tempScript->OnUpdate(weather, diff);
    }
}

void ScriptMgr::OnAuctionAdd(AuctionHouseObject* ah, AuctionEntry* entry)
{
    ASSERT(ah);
    ASSERT(entry);

    ExecuteScript<AuctionHouseScript>([&](AuctionHouseScript* script)
    {
        script->OnAuctionAdd(ah, entry);
    });
}

void ScriptMgr::OnAuctionRemove(AuctionHouseObject* ah, AuctionEntry* entry)
{
    ASSERT(ah);
    ASSERT(entry);

    ExecuteScript<AuctionHouseScript>([&](AuctionHouseScript* script)
    {
        script->OnAuctionRemove(ah, entry);
    });
}

void ScriptMgr::OnAuctionSuccessful(AuctionHouseObject* ah, AuctionEntry* entry)
{
    ASSERT(ah);
    ASSERT(entry);

    ExecuteScript<AuctionHouseScript>([&](AuctionHouseScript* script)
    {
        script->OnAuctionSuccessful(ah, entry);
    });
}

void ScriptMgr::OnAuctionExpire(AuctionHouseObject* ah, AuctionEntry* entry)
{
    ASSERT(ah);
    ASSERT(entry);

    ExecuteScript<AuctionHouseScript>([&](AuctionHouseScript* script)
    {
        script->OnAuctionExpire(ah, entry);
    });
}

void ScriptMgr::OnBeforeAuctionHouseMgrSendAuctionWonMail(AuctionHouseMgr* auctionHouseMgr, AuctionEntry* auction, Player* bidder, uint32& bidder_accId, bool& sendNotification, bool& updateAchievementCriteria, bool& sendMail)
{
    ExecuteScript<AuctionHouseScript>([&](AuctionHouseScript* script)
    {
        script->OnBeforeAuctionHouseMgrSendAuctionWonMail(auctionHouseMgr, auction, bidder, bidder_accId, sendNotification, updateAchievementCriteria, sendMail);
    });
}

void ScriptMgr::OnBeforeAuctionHouseMgrSendAuctionSalePendingMail(AuctionHouseMgr* auctionHouseMgr, AuctionEntry* auction, Player* owner, uint32& owner_accId, bool& sendMail)
{
    ExecuteScript<AuctionHouseScript>([&](AuctionHouseScript* script)
    {
        script->OnBeforeAuctionHouseMgrSendAuctionSalePendingMail(auctionHouseMgr, auction, owner, owner_accId, sendMail);
    });
}

void ScriptMgr::OnBeforeAuctionHouseMgrSendAuctionSuccessfulMail(AuctionHouseMgr* auctionHouseMgr, AuctionEntry* auction, Player* owner, uint32& owner_accId, uint32& profit, bool& sendNotification, bool& updateAchievementCriteria, bool& sendMail)
{
    ExecuteScript<AuctionHouseScript>([&](AuctionHouseScript* script)
    {
        script->OnBeforeAuctionHouseMgrSendAuctionSuccessfulMail(auctionHouseMgr, auction, owner, owner_accId, profit, sendNotification, updateAchievementCriteria, sendMail);
    });
}

void ScriptMgr::OnBeforeAuctionHouseMgrSendAuctionExpiredMail(AuctionHouseMgr* auctionHouseMgr, AuctionEntry* auction, Player* owner, uint32& owner_accId, bool& sendNotification, bool& sendMail)
{
    ExecuteScript<AuctionHouseScript>([&](AuctionHouseScript* script)
    {
        script->OnBeforeAuctionHouseMgrSendAuctionExpiredMail(auctionHouseMgr, auction, owner, owner_accId, sendNotification, sendMail);
    });
}

void ScriptMgr::OnBeforeAuctionHouseMgrSendAuctionOutbiddedMail(AuctionHouseMgr* auctionHouseMgr, AuctionEntry* auction, Player* oldBidder, uint32& oldBidder_accId, Player* newBidder, uint32& newPrice, bool& sendNotification, bool& sendMail)
{
    ExecuteScript<AuctionHouseScript>([&](AuctionHouseScript* script)
    {
        script->OnBeforeAuctionHouseMgrSendAuctionOutbiddedMail(auctionHouseMgr, auction, oldBidder, oldBidder_accId, newBidder, newPrice, sendNotification, sendMail);
    });
}

void ScriptMgr::OnBeforeAuctionHouseMgrSendAuctionCancelledToBidderMail(AuctionHouseMgr* auctionHouseMgr, AuctionEntry* auction, Player* bidder, uint32& bidder_accId, bool& sendMail)
{
    ExecuteScript<AuctionHouseScript>([&](AuctionHouseScript* script)
    {
        script->OnBeforeAuctionHouseMgrSendAuctionCancelledToBidderMail(auctionHouseMgr, auction, bidder, bidder_accId, sendMail);
    });
}

void ScriptMgr::OnBeforeAuctionHouseMgrUpdate()
{
    ExecuteScript<AuctionHouseScript>([&](AuctionHouseScript* script)
    {
        script->OnBeforeAuctionHouseMgrUpdate();
    });
}

bool ScriptMgr::OnConditionCheck(Condition* condition, ConditionSourceInfo& sourceInfo)
{
    ASSERT(condition);

    auto tempScript = ScriptRegistry<ConditionScript>::GetScriptById(condition->ScriptId);
    return tempScript ? tempScript->OnConditionCheck(condition, sourceInfo) : true;
}

void ScriptMgr::OnInstall(Vehicle* veh)
{
    ASSERT(veh);
    ASSERT(veh->GetBase()->GetTypeId() == TYPEID_UNIT);

    if (auto tempScript = ScriptRegistry<VehicleScript>::GetScriptById(veh->GetBase()->ToCreature()->GetScriptId()))
    {
        tempScript->OnInstall(veh);
    }
}

void ScriptMgr::OnUninstall(Vehicle* veh)
{
    ASSERT(veh);
    ASSERT(veh->GetBase()->GetTypeId() == TYPEID_UNIT);

    if (auto tempScript = ScriptRegistry<VehicleScript>::GetScriptById(veh->GetBase()->ToCreature()->GetScriptId()))
    {
        tempScript->OnUninstall(veh);
    }
}

void ScriptMgr::OnReset(Vehicle* veh)
{
    ASSERT(veh);
    ASSERT(veh->GetBase()->GetTypeId() == TYPEID_UNIT);

    if (auto tempScript = ScriptRegistry<VehicleScript>::GetScriptById(veh->GetBase()->ToCreature()->GetScriptId()))
    {
        tempScript->OnReset(veh);
    }
}

void ScriptMgr::OnInstallAccessory(Vehicle* veh, Creature* accessory)
{
    ASSERT(veh);
    ASSERT(veh->GetBase()->GetTypeId() == TYPEID_UNIT);
    ASSERT(accessory);

    if (auto tempScript = ScriptRegistry<VehicleScript>::GetScriptById(veh->GetBase()->ToCreature()->GetScriptId()))
    {
        tempScript->OnInstallAccessory(veh, accessory);
    }
}

void ScriptMgr::OnAddPassenger(Vehicle* veh, Unit* passenger, int8 seatId)
{
    ASSERT(veh);
    ASSERT(veh->GetBase()->GetTypeId() == TYPEID_UNIT);
    ASSERT(passenger);

    if (auto tempScript = ScriptRegistry<VehicleScript>::GetScriptById(veh->GetBase()->ToCreature()->GetScriptId()))
    {
        tempScript->OnAddPassenger(veh, passenger, seatId);
    }
}

void ScriptMgr::OnRemovePassenger(Vehicle* veh, Unit* passenger)
{
    ASSERT(veh);
    ASSERT(veh->GetBase()->GetTypeId() == TYPEID_UNIT);
    ASSERT(passenger);

    if (auto tempScript = ScriptRegistry<VehicleScript>::GetScriptById(veh->GetBase()->ToCreature()->GetScriptId()))
    {
        tempScript->OnRemovePassenger(veh, passenger);
    }
}

void ScriptMgr::OnDynamicObjectUpdate(DynamicObject* dynobj, uint32 diff)
{
    ASSERT(dynobj);

    for (auto const& [scriptID, script] : ScriptRegistry<DynamicObjectScript>::ScriptPointerList)
    {
        script->OnUpdate(dynobj, diff);
    }
}

void ScriptMgr::OnAddPassenger(Transport* transport, Player* player)
{
    ASSERT(transport);
    ASSERT(player);

    if (auto tempScript = ScriptRegistry<TransportScript>::GetScriptById(transport->GetScriptId()))
    {
        tempScript->OnAddPassenger(transport, player);
    }
}

void ScriptMgr::OnAddCreaturePassenger(Transport* transport, Creature* creature)
{
    ASSERT(transport);
    ASSERT(creature);

    if (auto tempScript = ScriptRegistry<TransportScript>::GetScriptById(transport->GetScriptId()))
    {
        tempScript->OnAddCreaturePassenger(transport, creature);
    }
}

void ScriptMgr::OnRemovePassenger(Transport* transport, Player* player)
{
    ASSERT(transport);
    ASSERT(player);

    if (auto tempScript = ScriptRegistry<TransportScript>::GetScriptById(transport->GetScriptId()))
    {
        tempScript->OnRemovePassenger(transport, player);
    }
}

void ScriptMgr::OnTransportUpdate(Transport* transport, uint32 diff)
{
    ASSERT(transport);

    if (auto tempScript = ScriptRegistry<TransportScript>::GetScriptById(transport->GetScriptId()))
    {
        tempScript->OnUpdate(transport, diff);
    }
}

void ScriptMgr::OnRelocate(Transport* transport, uint32 waypointId, uint32 mapId, float x, float y, float z)
{
    if (auto tempScript = ScriptRegistry<TransportScript>::GetScriptById(transport->GetScriptId()))
    {
        tempScript->OnRelocate(transport, waypointId, mapId, x, y, z);
    }
}

void ScriptMgr::OnStartup()
{
    ExecuteScript<WorldScript>([&](WorldScript* script)
    {
        script->OnStartup();
    });
}

void ScriptMgr::OnShutdown()
{
    ExecuteScript<WorldScript>([&](WorldScript* script)
    {
        script->OnShutdown();
    });
}

void ScriptMgr::OnBeforeWorldInitialized()
{
    ExecuteScript<WorldScript>([&](WorldScript* script)
    {
        script->OnBeforeWorldInitialized();
    });
}

bool ScriptMgr::OnCriteriaCheck(uint32 scriptId, Player* source, Unit* target, uint32 criteria_id)
{
    ASSERT(source);
    // target can be nullptr.

    auto tempScript = ScriptRegistry<AchievementCriteriaScript>::GetScriptById(scriptId);
    return tempScript ? tempScript->OnCheck(source, target, criteria_id) : false;
}

// Player
void ScriptMgr::OnPlayerCompleteQuest(Player* player, Quest const* quest)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnPlayerCompleteQuest(player, quest);
    });
}

void ScriptMgr::OnSendInitialPacketsBeforeAddToMap(Player* player, WorldPacket& data)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnSendInitialPacketsBeforeAddToMap(player, data);
    });
}

void ScriptMgr::OnBattlegroundDesertion(Player* player, BattlegroundDesertionType const desertionType)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnBattlegroundDesertion(player, desertionType);
    });
}

void ScriptMgr::OnPlayerReleasedGhost(Player* player)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnPlayerReleasedGhost(player);
    });
}

void ScriptMgr::OnPVPKill(Player* killer, Player* killed)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnPVPKill(killer, killed);
    });
}

void ScriptMgr::OnPlayerPVPFlagChange(Player* player, bool state)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnPlayerPVPFlagChange(player, state);
    });
}

void ScriptMgr::OnCreatureKill(Player* killer, Creature* killed)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnCreatureKill(killer, killed);
    });
}

void ScriptMgr::OnCreatureKilledByPet(Player* petOwner, Creature* killed)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnCreatureKilledByPet(petOwner, killed);
    });
}

void ScriptMgr::OnPlayerKilledByCreature(Creature* killer, Player* killed)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnPlayerKilledByCreature(killer, killed);
    });
}

void ScriptMgr::OnPlayerLevelChanged(Player* player, uint8 oldLevel)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnLevelChanged(player, oldLevel);
    });
}

void ScriptMgr::OnPlayerFreeTalentPointsChanged(Player* player, uint32 points)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnFreeTalentPointsChanged(player, points);
    });
}

void ScriptMgr::OnPlayerTalentsReset(Player* player, bool noCost)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnTalentsReset(player, noCost);
    });
}

void ScriptMgr::OnPlayerMoneyChanged(Player* player, int32& amount)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnMoneyChanged(player, amount);
    });
}

void ScriptMgr::OnGivePlayerXP(Player* player, uint32& amount, Unit* victim)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnGiveXP(player, amount, victim);
    });
}

void ScriptMgr::OnPlayerReputationChange(Player* player, uint32 factionID, int32& standing, bool incremental)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnReputationChange(player, factionID, standing, incremental);
    });
}

void ScriptMgr::OnPlayerReputationRankChange(Player* player, uint32 factionID, ReputationRank newRank, ReputationRank oldRank, bool increased)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnReputationRankChange(player, factionID, newRank, oldRank, increased);
    });
}

void ScriptMgr::OnPlayerLearnSpell(Player* player, uint32 spellID)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnLearnSpell(player, spellID);
    });
}

void ScriptMgr::OnPlayerForgotSpell(Player* player, uint32 spellID)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnForgotSpell(player, spellID);
    });
}

void ScriptMgr::OnPlayerDuelRequest(Player* target, Player* challenger)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnDuelRequest(target, challenger);
    });
}

void ScriptMgr::OnPlayerDuelStart(Player* player1, Player* player2)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnDuelStart(player1, player2);
    });
}

void ScriptMgr::OnPlayerDuelEnd(Player* winner, Player* loser, DuelCompleteType type)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnDuelEnd(winner, loser, type);
    });
}

void ScriptMgr::OnPlayerChat(Player* player, uint32 type, uint32 lang, std::string& msg)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnChat(player, type, lang, msg);
    });
}

void ScriptMgr::OnBeforeSendChatMessage(Player* player, uint32& type, uint32& lang, std::string& msg)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnBeforeSendChatMessage(player, type, lang, msg);
    });
}

void ScriptMgr::OnPlayerChat(Player* player, uint32 type, uint32 lang, std::string& msg, Player* receiver)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnChat(player, type, lang, msg, receiver);
    });
}

void ScriptMgr::OnPlayerChat(Player* player, uint32 type, uint32 lang, std::string& msg, Group* group)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnChat(player, type, lang, msg, group);
    });
}

void ScriptMgr::OnPlayerChat(Player* player, uint32 type, uint32 lang, std::string& msg, Guild* guild)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnChat(player, type, lang, msg, guild);
    });
}

void ScriptMgr::OnPlayerChat(Player* player, uint32 type, uint32 lang, std::string& msg, Channel* channel)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnChat(player, type, lang, msg, channel);
    });
}

void ScriptMgr::OnPlayerEmote(Player* player, uint32 emote)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnEmote(player, emote);
    });
}

void ScriptMgr::OnPlayerTextEmote(Player* player, uint32 textEmote, uint32 emoteNum, ObjectGuid guid)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnTextEmote(player, textEmote, emoteNum, guid);
    });
}

void ScriptMgr::OnPlayerSpellCast(Player* player, Spell* spell, bool skipCheck)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnSpellCast(player, spell, skipCheck);
    });
}

void ScriptMgr::OnBeforePlayerUpdate(Player* player, uint32 p_time)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnBeforeUpdate(player, p_time);
    });
}

void ScriptMgr::OnPlayerUpdate(Player* player, uint32 p_time)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnUpdate(player, p_time);
    });
}

void ScriptMgr::OnPlayerLogin(Player* player)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnLogin(player);
    });
}

void ScriptMgr::OnPlayerLoadFromDB(Player* player)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnLoadFromDB(player);
    });
}

void ScriptMgr::OnPlayerLogout(Player* player)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnLogout(player);
    });
}

void ScriptMgr::OnPlayerCreate(Player* player)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnCreate(player);
    });
}

void ScriptMgr::OnPlayerSave(Player* player)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnSave(player);
    });
}

void ScriptMgr::OnPlayerDelete(ObjectGuid guid, uint32 accountId)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnDelete(guid, accountId);
    });
}

void ScriptMgr::OnPlayerFailedDelete(ObjectGuid guid, uint32 accountId)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnFailedDelete(guid, accountId);
    });
}

void ScriptMgr::OnPlayerBindToInstance(Player* player, Difficulty difficulty, uint32 mapid, bool permanent)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnBindToInstance(player, difficulty, mapid, permanent);
    });
}

void ScriptMgr::OnPlayerUpdateZone(Player* player, uint32 newZone, uint32 newArea)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnUpdateZone(player, newZone, newArea);
    });
}

void ScriptMgr::OnPlayerUpdateArea(Player* player, uint32 oldArea, uint32 newArea)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnUpdateArea(player, oldArea, newArea);
    });
}

bool ScriptMgr::OnBeforePlayerTeleport(Player* player, uint32 mapid, float x, float y, float z, float orientation, uint32 options, Unit* target)
{
    auto ret = IsValidBoolScript<PlayerScript>([&](PlayerScript* script)
    {
        return !script->OnBeforeTeleport(player, mapid, x, y, z, orientation, options, target);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

void ScriptMgr::OnPlayerUpdateFaction(Player* player)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnUpdateFaction(player);
    });
}

void ScriptMgr::OnPlayerAddToBattleground(Player* player, Battleground* bg)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnAddToBattleground(player, bg);
    });
}

void ScriptMgr::OnPlayerQueueRandomDungeon(Player* player, uint32 & rDungeonId)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnQueueRandomDungeon(player, rDungeonId);
    });
}

void ScriptMgr::OnPlayerRemoveFromBattleground(Player* player, Battleground* bg)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnRemoveFromBattleground(player, bg);
    });
}

bool ScriptMgr::OnBeforeAchievementComplete(Player* player, AchievementEntry const* achievement)
{
    auto ret = IsValidBoolScript<PlayerScript>([&](PlayerScript* script)
    {
        return !script->OnBeforeAchiComplete(player, achievement);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

void ScriptMgr::OnAchievementComplete(Player* player, AchievementEntry const* achievement)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnAchiComplete(player, achievement);
    });
}

bool ScriptMgr::OnBeforeCriteriaProgress(Player* player, AchievementCriteriaEntry const* criteria)
{
    auto ret = IsValidBoolScript<PlayerScript>([&](PlayerScript* script)
    {
        return !script->OnBeforeCriteriaProgress(player, criteria);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

void ScriptMgr::OnCriteriaProgress(Player* player, AchievementCriteriaEntry const* criteria)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnCriteriaProgress(player, criteria);
    });
}

void ScriptMgr::OnAchievementSave(CharacterDatabaseTransaction trans, Player* player, uint16 achiId, CompletedAchievementData achiData)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnAchiSave(trans, player, achiId, achiData);
    });
}

void ScriptMgr::OnCriteriaSave(CharacterDatabaseTransaction trans, Player* player, uint16 critId, CriteriaProgress criteriaData)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnCriteriaSave(trans, player, critId, criteriaData);
    });
}

void ScriptMgr::OnPlayerBeingCharmed(Player* player, Unit* charmer, uint32 oldFactionId, uint32 newFactionId)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnBeingCharmed(player, charmer, oldFactionId, newFactionId);
    });
}

void ScriptMgr::OnAfterPlayerSetVisibleItemSlot(Player* player, uint8 slot, Item* item)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnAfterSetVisibleItemSlot(player, slot, item);
    });
}

void ScriptMgr::OnAfterPlayerMoveItemFromInventory(Player* player, Item* it, uint8 bag, uint8 slot, bool update)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnAfterMoveItemFromInventory(player, it, bag, slot, update);
    });
}

void ScriptMgr::OnEquip(Player* player, Item* it, uint8 bag, uint8 slot, bool update)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnEquip(player, it, bag, slot, update);
    });
}

void ScriptMgr::OnPlayerJoinBG(Player* player)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnPlayerJoinBG(player);
    });
}

void ScriptMgr::OnPlayerJoinArena(Player* player)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnPlayerJoinArena(player);
    });
}

void ScriptMgr::GetCustomGetArenaTeamId(const Player* player, uint8 slot, uint32& teamID) const
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->GetCustomGetArenaTeamId(player, slot, teamID);
    });
}

void ScriptMgr::GetCustomArenaPersonalRating(const Player* player, uint8 slot, uint32& rating) const
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->GetCustomArenaPersonalRating(player, slot, rating);
    });
}

void ScriptMgr::OnGetMaxPersonalArenaRatingRequirement(const Player* player, uint32 minSlot, uint32& maxArenaRating) const
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnGetMaxPersonalArenaRatingRequirement(player, minSlot, maxArenaRating);
    });
}

void ScriptMgr::OnLootItem(Player* player, Item* item, uint32 count, ObjectGuid lootguid)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnLootItem(player, item, count, lootguid);
    });
}

void ScriptMgr::OnCreateItem(Player* player, Item* item, uint32 count)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnCreateItem(player, item, count);
    });
}

void ScriptMgr::OnQuestRewardItem(Player* player, Item* item, uint32 count)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnQuestRewardItem(player, item, count);
    });
}

void ScriptMgr::OnFirstLogin(Player* player)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnFirstLogin(player);
    });
}

bool ScriptMgr::CanJoinInBattlegroundQueue(Player* player, ObjectGuid BattlemasterGuid, BattlegroundTypeId BGTypeID, uint8 joinAsGroup, GroupJoinBattlegroundResult& err)
{
    auto ret = IsValidBoolScript<PlayerScript>([&](PlayerScript* script)
    {
        return !script->CanJoinInBattlegroundQueue(player, BattlemasterGuid, BGTypeID, joinAsGroup, err);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

bool ScriptMgr::ShouldBeRewardedWithMoneyInsteadOfExp(Player* player)
{
    auto ret = IsValidBoolScript<PlayerScript>([&](PlayerScript* script)
    {
        return script->ShouldBeRewardedWithMoneyInsteadOfExp(player);
    });

    if (ret && *ret)
    {
        return true;
    }

    return false;
}

void ScriptMgr::OnBeforeTempSummonInitStats(Player* player, TempSummon* tempSummon, uint32& duration)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnBeforeTempSummonInitStats(player, tempSummon, duration);
    });
}

void ScriptMgr::OnBeforeGuardianInitStatsForLevel(Player* player, Guardian* guardian, CreatureTemplate const* cinfo, PetType& petType)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnBeforeGuardianInitStatsForLevel(player, guardian, cinfo, petType);
    });
}

void ScriptMgr::OnAfterGuardianInitStatsForLevel(Player* player, Guardian* guardian)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnAfterGuardianInitStatsForLevel(player, guardian);
    });
}

void ScriptMgr::OnBeforeLoadPetFromDB(Player* player, uint32& petentry, uint32& petnumber, bool& current, bool& forceLoadFromDB)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnBeforeLoadPetFromDB(player, petentry, petnumber, current, forceLoadFromDB);
    });
}

// Account
void ScriptMgr::OnAccountLogin(uint32 accountId)
{
    ExecuteScript<AccountScript>([&](AccountScript* script)
    {
        script->OnAccountLogin(accountId);
    });
}

void ScriptMgr::OnLastIpUpdate(uint32 accountId, std::string ip)
{
    ExecuteScript<AccountScript>([&](AccountScript* script)
    {
        script->OnLastIpUpdate(accountId, ip);
    });
}

void ScriptMgr::OnFailedAccountLogin(uint32 accountId)
{
    ExecuteScript<AccountScript>([&](AccountScript* script)
    {
        script->OnFailedAccountLogin(accountId);
    });
}

void ScriptMgr::OnEmailChange(uint32 accountId)
{
    ExecuteScript<AccountScript>([&](AccountScript* script)
    {
        script->OnEmailChange(accountId);
    });
}

void ScriptMgr::OnFailedEmailChange(uint32 accountId)
{
    ExecuteScript<AccountScript>([&](AccountScript* script)
    {
        script->OnFailedEmailChange(accountId);
    });
}

void ScriptMgr::OnPasswordChange(uint32 accountId)
{
    ExecuteScript<AccountScript>([&](AccountScript* script)
    {
        script->OnPasswordChange(accountId);
    });
}

void ScriptMgr::OnFailedPasswordChange(uint32 accountId)
{
    ExecuteScript<AccountScript>([&](AccountScript* script)
    {
        script->OnFailedPasswordChange(accountId);
    });
}

// Guild
void ScriptMgr::OnGuildAddMember(Guild* guild, Player* player, uint8& plRank)
{
    ExecuteScript<GuildScript>([&](GuildScript* script)
    {
        script->OnAddMember(guild, player, plRank);
    });
}

void ScriptMgr::OnGuildRemoveMember(Guild* guild, Player* player, bool isDisbanding, bool isKicked)
{
    ExecuteScript<GuildScript>([&](GuildScript* script)
    {
        script->OnRemoveMember(guild, player, isDisbanding, isKicked);
    });
}

void ScriptMgr::OnGuildMOTDChanged(Guild* guild, const std::string& newMotd)
{
    ExecuteScript<GuildScript>([&](GuildScript* script)
    {
        script->OnMOTDChanged(guild, newMotd);
    });
}

void ScriptMgr::OnGuildInfoChanged(Guild* guild, const std::string& newInfo)
{
    ExecuteScript<GuildScript>([&](GuildScript* script)
    {
        script->OnInfoChanged(guild, newInfo);
    });
}

void ScriptMgr::OnGuildCreate(Guild* guild, Player* leader, const std::string& name)
{
    ExecuteScript<GuildScript>([&](GuildScript* script)
    {
        script->OnCreate(guild, leader, name);
    });
}

void ScriptMgr::OnGuildDisband(Guild* guild)
{
    ExecuteScript<GuildScript>([&](GuildScript* script)
    {
        script->OnDisband(guild);
    });
}

void ScriptMgr::OnGuildMemberWitdrawMoney(Guild* guild, Player* player, uint32& amount, bool isRepair)
{
    ExecuteScript<GuildScript>([&](GuildScript* script)
    {
        script->OnMemberWitdrawMoney(guild, player, amount, isRepair);
    });
}

void ScriptMgr::OnGuildMemberDepositMoney(Guild* guild, Player* player, uint32& amount)
{
    ExecuteScript<GuildScript>([&](GuildScript* script)
    {
        script->OnMemberDepositMoney(guild, player, amount);
    });
}

void ScriptMgr::OnGuildItemMove(Guild* guild, Player* player, Item* pItem, bool isSrcBank, uint8 srcContainer, uint8 srcSlotId,
                                bool isDestBank, uint8 destContainer, uint8 destSlotId)
{
    ExecuteScript<GuildScript>([&](GuildScript* script)
    {
        script->OnItemMove(guild, player, pItem, isSrcBank, srcContainer, srcSlotId, isDestBank, destContainer, destSlotId);
    });
}

void ScriptMgr::OnGuildEvent(Guild* guild, uint8 eventType, ObjectGuid::LowType playerGuid1, ObjectGuid::LowType playerGuid2, uint8 newRank)
{
    ExecuteScript<GuildScript>([&](GuildScript* script)
    {
        script->OnEvent(guild, eventType, playerGuid1, playerGuid2, newRank);
    });
}

void ScriptMgr::OnGuildBankEvent(Guild* guild, uint8 eventType, uint8 tabId, ObjectGuid::LowType playerGuid, uint32 itemOrMoney, uint16 itemStackCount, uint8 destTabId)
{
    ExecuteScript<GuildScript>([&](GuildScript* script)
    {
        script->OnBankEvent(guild, eventType, tabId, playerGuid, itemOrMoney, itemStackCount, destTabId);
    });
}

// Group
void ScriptMgr::OnGroupAddMember(Group* group, ObjectGuid guid)
{
    ASSERT(group);
    ExecuteScript<GroupScript>([&](GroupScript* script)
    {
        script->OnAddMember(group, guid);
    });
}

void ScriptMgr::OnGroupInviteMember(Group* group, ObjectGuid guid)
{
    ASSERT(group);
    ExecuteScript<GroupScript>([&](GroupScript* script)
    {
        script->OnInviteMember(group, guid);
    });
}

void ScriptMgr::OnGroupRemoveMember(Group* group, ObjectGuid guid, RemoveMethod method, ObjectGuid kicker, const char* reason)
{
    ASSERT(group);
    ExecuteScript<GroupScript>([&](GroupScript* script)
    {
        script->OnRemoveMember(group, guid, method, kicker, reason);
    });
}

void ScriptMgr::OnGroupChangeLeader(Group* group, ObjectGuid newLeaderGuid, ObjectGuid oldLeaderGuid)
{
    ASSERT(group);
    ExecuteScript<GroupScript>([&](GroupScript* script)
    {
        script->OnChangeLeader(group, newLeaderGuid, oldLeaderGuid);
    });
}

void ScriptMgr::OnGroupDisband(Group* group)
{
    ASSERT(group);
    ExecuteScript<GroupScript>([&](GroupScript* script)
    {
        script->OnDisband(group);
    });
}

// Global
void ScriptMgr::OnGlobalItemDelFromDB(CharacterDatabaseTransaction trans, ObjectGuid::LowType itemGuid)
{
    ASSERT(trans);
    ASSERT(itemGuid);

    ExecuteScript<GlobalScript>([&](GlobalScript* script)
    {
        script->OnItemDelFromDB(trans, itemGuid);
    });
}

void ScriptMgr::OnGlobalMirrorImageDisplayItem(const Item* item, uint32& display)
{
    ExecuteScript<GlobalScript>([&](GlobalScript* script)
    {
        script->OnMirrorImageDisplayItem(item, display);
    });
}

void ScriptMgr::OnBeforeUpdateArenaPoints(ArenaTeam* at, std::map<ObjectGuid, uint32>& ap)
{
    ExecuteScript<GlobalScript>([&](GlobalScript* script)
    {
        script->OnBeforeUpdateArenaPoints(at, ap);
    });
}

void ScriptMgr::OnAfterRefCount(Player const* player, Loot& loot, bool canRate, uint16 lootMode, LootStoreItem* LootStoreItem, uint32& maxcount, LootStore const& store)
{
    ExecuteScript<GlobalScript>([&](GlobalScript* script)
    {
        script->OnAfterRefCount(player, LootStoreItem, loot, canRate, lootMode, maxcount, store);
    });
}

void ScriptMgr::OnBeforeDropAddItem(Player const* player, Loot& loot, bool canRate, uint16 lootMode, LootStoreItem* LootStoreItem, LootStore const& store)
{
    ExecuteScript<GlobalScript>([&](GlobalScript* script)
    {
        script->OnBeforeDropAddItem(player, loot, canRate, lootMode, LootStoreItem, store);
    });
}

bool ScriptMgr::OnItemRoll(Player const* player, LootStoreItem const* lootStoreItem, float& chance, Loot& loot, LootStore const& store)
{
    auto ret = IsValidBoolScript<GlobalScript>([&](GlobalScript* script)
    {
        return !script->OnItemRoll(player, lootStoreItem, chance, loot, store);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

bool ScriptMgr::OnBeforeLootEqualChanced(Player const* player, LootStoreItemList EqualChanced, Loot& loot, LootStore const& store)
{
    auto ret = IsValidBoolScript<GlobalScript>([&](GlobalScript* script)
    {
        return !script->OnBeforeLootEqualChanced(player, EqualChanced, loot, store);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

void ScriptMgr::OnInitializeLockedDungeons(Player* player, uint8& level, uint32& lockData, lfg::LFGDungeonData const* dungeon)
{
    ExecuteScript<GlobalScript>([&](GlobalScript* script)
    {
        script->OnInitializeLockedDungeons(player, level, lockData, dungeon);
    });
}

void ScriptMgr::OnAfterInitializeLockedDungeons(Player* player)
{
    ExecuteScript<GlobalScript>([&](GlobalScript* script)
    {
        script->OnAfterInitializeLockedDungeons(player);
    });
}

void ScriptMgr::OnAfterUpdateEncounterState(Map* map, EncounterCreditType type, uint32 creditEntry, Unit* source, Difficulty difficulty_fixed, DungeonEncounterList const* encounters, uint32 dungeonCompleted, bool updated)
{
    ExecuteScript<GlobalScript>([&](GlobalScript* script)
    {
        script->OnAfterUpdateEncounterState(map, type, creditEntry, source, difficulty_fixed, encounters, dungeonCompleted, updated);
    });
}

void ScriptMgr::OnBeforeWorldObjectSetPhaseMask(WorldObject const* worldObject, uint32& oldPhaseMask, uint32& newPhaseMask, bool& useCombinedPhases, bool& update)
{
    ExecuteScript<GlobalScript>([&](GlobalScript* script)
    {
        script->OnBeforeWorldObjectSetPhaseMask(worldObject, oldPhaseMask, newPhaseMask, useCombinedPhases, update);
    });
}

// Unit
uint32 ScriptMgr::DealDamage(Unit* AttackerUnit, Unit* pVictim, uint32 damage, DamageEffectType damagetype)
{
    if (ScriptRegistry<UnitScript>::ScriptPointerList.empty())
    {
        return damage;
    }

    for (auto const& [scriptID, script] : ScriptRegistry<UnitScript>::ScriptPointerList)
    {
        auto const& dmg = script->DealDamage(AttackerUnit, pVictim, damage, damagetype);
        if (dmg != damage)
        {
            return damage;
        }
    }

    return damage;
}

void ScriptMgr::Creature_SelectLevel(const CreatureTemplate* cinfo, Creature* creature)
{
    ExecuteScript<AllCreatureScript>([&](AllCreatureScript* script)
    {
        script->Creature_SelectLevel(cinfo, creature);
    });
}

void ScriptMgr::OnHeal(Unit* healer, Unit* reciever, uint32& gain)
{
    ExecuteScript<UnitScript>([&](UnitScript* script)
    {
        script->OnHeal(healer, reciever, gain);
    });
}

void ScriptMgr::OnDamage(Unit* attacker, Unit* victim, uint32& damage)
{
    ExecuteScript<UnitScript>([&](UnitScript* script)
    {
        script->OnDamage(attacker, victim, damage);
    });
}

void ScriptMgr::ModifyPeriodicDamageAurasTick(Unit* target, Unit* attacker, uint32& damage)
{
    ExecuteScript<UnitScript>([&](UnitScript* script)
    {
        script->ModifyPeriodicDamageAurasTick(target, attacker, damage);
    });
}

void ScriptMgr::ModifyMeleeDamage(Unit* target, Unit* attacker, uint32& damage)
{
    ExecuteScript<UnitScript>([&](UnitScript* script)
    {
        script->ModifyMeleeDamage(target, attacker, damage);
    });
}

void ScriptMgr::ModifySpellDamageTaken(Unit* target, Unit* attacker, int32& damage)
{
    ExecuteScript<UnitScript>([&](UnitScript* script)
    {
        script->ModifySpellDamageTaken(target, attacker, damage);
    });
}

void ScriptMgr::ModifyHealRecieved(Unit* target, Unit* attacker, uint32& damage)
{
    ExecuteScript<UnitScript>([&](UnitScript* script)
    {
        script->ModifyHealRecieved(target, attacker, damage);
    });
}

void ScriptMgr::OnBeforeRollMeleeOutcomeAgainst(const Unit* attacker, const Unit* victim, WeaponAttackType attType, int32& attackerMaxSkillValueForLevel, int32& victimMaxSkillValueForLevel, int32& attackerWeaponSkill, int32& victimDefenseSkill, int32& crit_chance, int32& miss_chance, int32& dodge_chance, int32& parry_chance, int32& block_chance)
{
    ExecuteScript<UnitScript>([&](UnitScript* script)
    {
        script->OnBeforeRollMeleeOutcomeAgainst(attacker, victim, attType, attackerMaxSkillValueForLevel, victimMaxSkillValueForLevel, attackerWeaponSkill, victimDefenseSkill, crit_chance, miss_chance, dodge_chance, parry_chance, block_chance);
    });
}

void ScriptMgr::OnPlayerMove(Player* player, MovementInfo movementInfo, uint32 opcode)
{
    ExecuteScript<MovementHandlerScript>([&](MovementHandlerScript* script)
    {
        script->OnPlayerMove(player, movementInfo, opcode);
    });
}

void ScriptMgr::OnBeforeBuyItemFromVendor(Player* player, ObjectGuid vendorguid, uint32 vendorslot, uint32& item, uint8 count, uint8 bag, uint8 slot)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnBeforeBuyItemFromVendor(player, vendorguid, vendorslot, item, count, bag, slot);
    });
}

void ScriptMgr::OnAfterStoreOrEquipNewItem(Player* player, uint32 vendorslot, Item* item, uint8 count, uint8 bag, uint8 slot, ItemTemplate const* pProto, Creature* pVendor, VendorItem const* crItem, bool bStore)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnAfterStoreOrEquipNewItem(player, vendorslot, item, count, bag, slot, pProto, pVendor, crItem, bStore);
    });
}

void ScriptMgr::OnAfterUpdateMaxPower(Player* player, Powers& power, float& value)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnAfterUpdateMaxPower(player, power, value);
    });
}

void ScriptMgr::OnAfterUpdateMaxHealth(Player* player, float& value)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnAfterUpdateMaxHealth(player, value);
    });
}

void ScriptMgr::OnBeforeUpdateAttackPowerAndDamage(Player* player, float& level, float& val2, bool ranged)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnBeforeUpdateAttackPowerAndDamage(player, level, val2, ranged);
    });
}

void ScriptMgr::OnAfterUpdateAttackPowerAndDamage(Player* player, float& level, float& base_attPower, float& attPowerMod, float& attPowerMultiplier, bool ranged)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnAfterUpdateAttackPowerAndDamage(player, level, base_attPower, attPowerMod, attPowerMultiplier, ranged);
    });
}

void ScriptMgr::OnBeforeInitTalentForLevel(Player* player, uint8& level, uint32& talentPointsForLevel)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnBeforeInitTalentForLevel(player, level, talentPointsForLevel);
    });
}

void ScriptMgr::OnAfterArenaRatingCalculation(Battleground* const bg, int32& winnerMatchmakerChange, int32& loserMatchmakerChange, int32& winnerChange, int32& loserChange)
{
    ExecuteScript<FormulaScript>([&](FormulaScript* script)
    {
        script->OnAfterArenaRatingCalculation(bg, winnerMatchmakerChange, loserMatchmakerChange, winnerChange, loserChange);
    });
}

// BGScript
void ScriptMgr::OnBattlegroundStart(Battleground* bg)
{
    ExecuteScript<BGScript>([&](BGScript* script)
    {
        script->OnBattlegroundStart(bg);
    });
}

void ScriptMgr::OnBattlegroundEndReward(Battleground* bg, Player* player, TeamId winnerTeamId)
{
    ExecuteScript<BGScript>([&](BGScript* script)
    {
        script->OnBattlegroundEndReward(bg, player, winnerTeamId);
    });
}

void ScriptMgr::OnBattlegroundUpdate(Battleground* bg, uint32 diff)
{
    ExecuteScript<BGScript>([&](BGScript* script)
    {
        script->OnBattlegroundUpdate(bg, diff);
    });
}

void ScriptMgr::OnBattlegroundAddPlayer(Battleground* bg, Player* player)
{
    ExecuteScript<BGScript>([&](BGScript* script)
    {
        script->OnBattlegroundAddPlayer(bg, player);
    });
}

void ScriptMgr::OnBattlegroundBeforeAddPlayer(Battleground* bg, Player* player)
{
    ExecuteScript<BGScript>([&](BGScript* script)
    {
        script->OnBattlegroundBeforeAddPlayer(bg, player);
    });
}

void ScriptMgr::OnBattlegroundRemovePlayerAtLeave(Battleground* bg, Player* player)
{
    ExecuteScript<BGScript>([&](BGScript* script)
    {
        script->OnBattlegroundRemovePlayerAtLeave(bg, player);
    });
}

void ScriptMgr::OnAddGroup(BattlegroundQueue* queue, GroupQueueInfo* ginfo, uint32& index, Player* leader, Group* grp, PvPDifficultyEntry const* bracketEntry, bool isPremade)
{
    ExecuteScript<BGScript>([&](BGScript* script)
    {
        script->OnAddGroup(queue, ginfo, index, leader, grp, bracketEntry, isPremade);
    });
}

bool ScriptMgr::CanFillPlayersToBG(BattlegroundQueue* queue, Battleground* bg, const int32 aliFree, const int32 hordeFree, BattlegroundBracketId bracket_id)
{
    auto ret = IsValidBoolScript<BGScript>([&](BGScript* script)
    {
        return !script->CanFillPlayersToBG(queue, bg, aliFree, hordeFree, bracket_id);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

bool ScriptMgr::CanFillPlayersToBGWithSpecific(BattlegroundQueue* queue, Battleground* bg, const int32 aliFree, const int32 hordeFree,
        BattlegroundBracketId thisBracketId, BattlegroundQueue* specificQueue, BattlegroundBracketId specificBracketId)
{
    auto ret = IsValidBoolScript<BGScript>([&](BGScript* script)
    {
        return !script->CanFillPlayersToBGWithSpecific(queue, bg, aliFree, hordeFree, thisBracketId, specificQueue, specificBracketId);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

void ScriptMgr::OnCheckNormalMatch(BattlegroundQueue* queue, uint32& Coef, Battleground* bgTemplate, BattlegroundBracketId bracket_id, uint32& minPlayers, uint32& maxPlayers)
{
    ExecuteScript<BGScript>([&](BGScript* script)
    {
        script->OnCheckNormalMatch(queue, Coef, bgTemplate, bracket_id, minPlayers, maxPlayers);
    });
}

void ScriptMgr::OnGetSlotByType(const uint32 type, uint8& slot)
{
    ExecuteScript<ArenaTeamScript>([&](ArenaTeamScript* script)
    {
        script->OnGetSlotByType(type, slot);
    });
}

void ScriptMgr::OnGetArenaPoints(ArenaTeam* at, float& points)
{
    ExecuteScript<ArenaTeamScript>([&](ArenaTeamScript* script)
    {
        script->OnGetArenaPoints(at, points);
    });
}

void ScriptMgr::OnArenaTypeIDToQueueID(const BattlegroundTypeId bgTypeId, const uint8 arenaType, uint32& queueTypeID)
{
    ExecuteScript<ArenaTeamScript>([&](ArenaTeamScript* script)
    {
        script->OnTypeIDToQueueID(bgTypeId, arenaType, queueTypeID);
    });
}

void ScriptMgr::OnArenaQueueIdToArenaType(const BattlegroundQueueTypeId bgQueueTypeId, uint8& ArenaType)
{
    ExecuteScript<ArenaTeamScript>([&](ArenaTeamScript* script)
    {
        script->OnQueueIdToArenaType(bgQueueTypeId, ArenaType);
    });
}

void ScriptMgr::OnSetArenaMaxPlayersPerTeam(const uint8 arenaType, uint32& maxPlayerPerTeam)
{
    ExecuteScript<ArenaTeamScript>([&](ArenaTeamScript* script)
    {
        script->OnSetArenaMaxPlayersPerTeam(arenaType, maxPlayerPerTeam);
    });
}

// SpellSC
void ScriptMgr::OnCalcMaxDuration(Aura const* aura, int32& maxDuration)
{
    ExecuteScript<SpellSC>([&](SpellSC* script)
    {
        script->OnCalcMaxDuration(aura, maxDuration);
    });
}

void ScriptMgr::OnGameEventStart(uint16 EventID)
{
    ExecuteScript<GameEventScript>([&](GameEventScript* script)
    {
        script->OnStart(EventID);
    });
}

void ScriptMgr::OnGameEventStop(uint16 EventID)
{
    ExecuteScript<GameEventScript>([&](GameEventScript* script)
    {
        script->OnStop(EventID);
    });
}

// Mail
void ScriptMgr::OnBeforeMailDraftSendMailTo(MailDraft* mailDraft, MailReceiver const& receiver, MailSender const& sender, MailCheckMask& checked, uint32& deliver_delay, uint32& custom_expiration, bool& deleteMailItemsFromDB, bool& sendMail)
{
    ExecuteScript<MailScript>([&](MailScript* script)
    {
        script->OnBeforeMailDraftSendMailTo(mailDraft, receiver, sender, checked, deliver_delay, custom_expiration, deleteMailItemsFromDB, sendMail);\
    });
}

void ScriptMgr::OnBeforeUpdatingPersonalRating(int32& mod, uint32 type)
{
    ExecuteScript<FormulaScript>([&](FormulaScript* script)
    {
        script->OnBeforeUpdatingPersonalRating(mod, type);
    });
}

bool ScriptMgr::OnBeforePlayerQuestComplete(Player* player, uint32 quest_id)
{
    auto ret = IsValidBoolScript<PlayerScript>([&](PlayerScript* script)
    {
        return !script->OnBeforeQuestComplete(player, quest_id);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

void ScriptMgr::OnBeforeStoreOrEquipNewItem(Player* player, uint32 vendorslot, uint32& item, uint8 count, uint8 bag, uint8 slot, ItemTemplate const* pProto, Creature* pVendor, VendorItem const* crItem, bool bStore)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnBeforeStoreOrEquipNewItem(player, vendorslot, item, count, bag, slot, pProto, pVendor, crItem, bStore);
    });
}

bool ScriptMgr::CanJoinInArenaQueue(Player* player, ObjectGuid BattlemasterGuid, uint8 arenaslot, BattlegroundTypeId BGTypeID, uint8 joinAsGroup, uint8 IsRated, GroupJoinBattlegroundResult& err)
{
    auto ret = IsValidBoolScript<PlayerScript>([&](PlayerScript* script)
    {
        return !script->CanJoinInArenaQueue(player, BattlemasterGuid, arenaslot, BGTypeID, joinAsGroup, IsRated, err);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

bool ScriptMgr::CanBattleFieldPort(Player* player, uint8 arenaType, BattlegroundTypeId BGTypeID, uint8 action)
{
    auto ret = IsValidBoolScript<PlayerScript>([&](PlayerScript* script)
    {
        return !script->CanBattleFieldPort(player, arenaType, BGTypeID, action);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

bool ScriptMgr::CanGroupInvite(Player* player, std::string& membername)
{
    auto ret = IsValidBoolScript<PlayerScript>([&](PlayerScript* script)
    {
        return !script->CanGroupInvite(player, membername);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

bool ScriptMgr::CanGroupAccept(Player* player, Group* group)
{
    auto ret = IsValidBoolScript<PlayerScript>([&](PlayerScript* script)
    {
        return !script->CanGroupAccept(player, group);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

bool ScriptMgr::CanSellItem(Player* player, Item* item, Creature* creature)
{
    auto ret = IsValidBoolScript<PlayerScript>([&](PlayerScript* script)
    {
        return !script->CanSellItem(player, item, creature);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

bool ScriptMgr::CanSendMail(Player* player, ObjectGuid receiverGuid, ObjectGuid mailbox, std::string& subject, std::string& body, uint32 money, uint32 COD, Item* item)
{
    auto ret = IsValidBoolScript<PlayerScript>([&](PlayerScript* script)
    {
        return !script->CanSendMail(player, receiverGuid, mailbox, subject, body, money, COD, item);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

void ScriptMgr::PetitionBuy(Player* player, Creature* creature, uint32& charterid, uint32& cost, uint32& type)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->PetitionBuy(player, creature, charterid, cost, type);
    });
}

void ScriptMgr::PetitionShowList(Player* player, Creature* creature, uint32& CharterEntry, uint32& CharterDispayID, uint32& CharterCost)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->PetitionShowList(player, creature, CharterEntry, CharterDispayID, CharterCost);
    });
}

void ScriptMgr::OnRewardKillRewarder(Player* player, bool isDungeon, float& rate)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnRewardKillRewarder(player, isDungeon, rate);
    });
}

bool ScriptMgr::CanGiveMailRewardAtGiveLevel(Player* player, uint8 level)
{
    auto ret = IsValidBoolScript<PlayerScript>([&](PlayerScript* script)
    {
        return !script->CanGiveMailRewardAtGiveLevel(player, level);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

void ScriptMgr::OnDeleteFromDB(CharacterDatabaseTransaction trans, uint32 guid)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnDeleteFromDB(trans, guid);
    });
}

bool ScriptMgr::CanRepopAtGraveyard(Player* player)
{
    auto ret = IsValidBoolScript<PlayerScript>([&](PlayerScript* script)
    {
        return !script->CanRepopAtGraveyard(player);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

void ScriptMgr::OnGetMaxSkillValue(Player* player, uint32 skill, int32& result, bool IsPure)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnGetMaxSkillValue(player, skill, result, IsPure);
    });
}

bool ScriptMgr::CanAreaExploreAndOutdoor(Player* player)
{
    auto ret = IsValidBoolScript<PlayerScript>([&](PlayerScript* script)
    {
        return !script->CanAreaExploreAndOutdoor(player);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

void ScriptMgr::OnVictimRewardBefore(Player* player, Player* victim, uint32& killer_title, uint32& victim_title)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnVictimRewardBefore(player, victim, killer_title, victim_title);
    });
}

void ScriptMgr::OnVictimRewardAfter(Player* player, Player* victim, uint32& killer_title, uint32& victim_rank, float& honor_f)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnVictimRewardAfter(player, victim, killer_title, victim_rank, honor_f);
    });
}

void ScriptMgr::OnCustomScalingStatValueBefore(Player* player, ItemTemplate const* proto, uint8 slot, bool apply, uint32& CustomScalingStatValue)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnCustomScalingStatValueBefore(player, proto, slot, apply, CustomScalingStatValue);
    });
}

void ScriptMgr::OnCustomScalingStatValue(Player* player, ItemTemplate const* proto, uint32& statType, int32& val, uint8 itemProtoStatNumber, uint32 ScalingStatValue, ScalingStatValuesEntry const* ssv)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnCustomScalingStatValue(player, proto, statType, val, itemProtoStatNumber, ScalingStatValue, ssv);
    });
}

bool ScriptMgr::CanArmorDamageModifier(Player* player)
{
    auto ret = IsValidBoolScript<PlayerScript>([&](PlayerScript* script)
    {
        return !script->CanArmorDamageModifier(player);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

void ScriptMgr::OnGetFeralApBonus(Player* player, int32& feral_bonus, int32 dpsMod, ItemTemplate const* proto, ScalingStatValuesEntry const* ssv)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnGetFeralApBonus(player, feral_bonus, dpsMod, proto, ssv);
    });
}

bool ScriptMgr::CanApplyWeaponDependentAuraDamageMod(Player* player, Item* item, WeaponAttackType attackType, AuraEffect const* aura, bool apply)
{
    auto ret = IsValidBoolScript<PlayerScript>([&](PlayerScript* script)
    {
        return !script->CanApplyWeaponDependentAuraDamageMod(player, item, attackType, aura, apply);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

bool ScriptMgr::CanApplyEquipSpell(Player* player, SpellInfo const* spellInfo, Item* item, bool apply, bool form_change)
{
    auto ret = IsValidBoolScript<PlayerScript>([&](PlayerScript* script)
    {
        return !script->CanApplyEquipSpell(player, spellInfo, item, apply, form_change);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

bool ScriptMgr::CanApplyEquipSpellsItemSet(Player* player, ItemSetEffect* eff)
{
    auto ret = IsValidBoolScript<PlayerScript>([&](PlayerScript* script)
    {
        return !script->CanApplyEquipSpellsItemSet(player, eff);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

bool ScriptMgr::CanCastItemCombatSpell(Player* player, Unit* target, WeaponAttackType attType, uint32 procVictim, uint32 procEx, Item* item, ItemTemplate const* proto)
{
    auto ret = IsValidBoolScript<PlayerScript>([&](PlayerScript* script)
    {
        return !script->CanCastItemCombatSpell(player, target, attType, procVictim, procEx, item, proto);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

bool ScriptMgr::CanCastItemUseSpell(Player* player, Item* item, SpellCastTargets const& targets, uint8 cast_count, uint32 glyphIndex)
{
    auto ret = IsValidBoolScript<PlayerScript>([&](PlayerScript* script)
    {
        return !script->CanCastItemUseSpell(player, item, targets, cast_count, glyphIndex);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

void ScriptMgr::OnApplyAmmoBonuses(Player* player, ItemTemplate const* proto, float& currentAmmoDPS)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnApplyAmmoBonuses(player, proto, currentAmmoDPS);
    });
}

bool ScriptMgr::CanEquipItem(Player* player, uint8 slot, uint16& dest, Item* pItem, bool swap, bool not_loading)
{
    auto ret = IsValidBoolScript<PlayerScript>([&](PlayerScript* script)
    {
        return !script->CanEquipItem(player, slot, dest, pItem, swap, not_loading);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

bool ScriptMgr::CanUnequipItem(Player* player, uint16 pos, bool swap)
{
    auto ret = IsValidBoolScript<PlayerScript>([&](PlayerScript* script)
    {
        return !script->CanUnequipItem(player, pos, swap);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

bool ScriptMgr::CanUseItem(Player* player, ItemTemplate const* proto, InventoryResult& result)
{
    auto ret = IsValidBoolScript<PlayerScript>([&](PlayerScript* script)
    {
        return !script->CanUseItem(player, proto, result);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

bool ScriptMgr::CanSaveEquipNewItem(Player* player, Item* item, uint16 pos, bool update)
{
    auto ret = IsValidBoolScript<PlayerScript>([&](PlayerScript* script)
    {
        return !script->CanSaveEquipNewItem(player, item, pos, update);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

bool ScriptMgr::CanApplyEnchantment(Player* player, Item* item, EnchantmentSlot slot, bool apply, bool apply_dur, bool ignore_condition)
{
    auto ret = IsValidBoolScript<PlayerScript>([&](PlayerScript* script)
    {
        return !script->CanApplyEnchantment(player, item, slot, apply, apply_dur, ignore_condition);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

void ScriptMgr::OnGetQuestRate(Player* player, float& result)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnGetQuestRate(player, result);
    });
}

bool ScriptMgr::PassedQuestKilledMonsterCredit(Player* player, Quest const* qinfo, uint32 entry, uint32 real_entry, ObjectGuid guid)
{
    auto ret = IsValidBoolScript<PlayerScript>([&](PlayerScript* script)
    {
        return !script->PassedQuestKilledMonsterCredit(player, qinfo, entry, real_entry, guid);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

bool ScriptMgr::CheckItemInSlotAtLoadInventory(Player* player, Item* item, uint8 slot, uint8& err, uint16& dest)
{
    auto ret = IsValidBoolScript<PlayerScript>([&](PlayerScript* script)
    {
        return !script->CheckItemInSlotAtLoadInventory(player, item, slot, err, dest);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

bool ScriptMgr::NotAvoidSatisfy(Player* player, DungeonProgressionRequirements const* ar, uint32 target_map, bool report)
{
    auto ret = IsValidBoolScript<PlayerScript>([&](PlayerScript* script)
    {
        return !script->NotAvoidSatisfy(player, ar, target_map, report);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

bool ScriptMgr::NotVisibleGloballyFor(Player* player, Player const* u)
{
    auto ret = IsValidBoolScript<PlayerScript>([&](PlayerScript* script)
    {
        return !script->NotVisibleGloballyFor(player, u);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

void ScriptMgr::OnGetArenaPersonalRating(Player* player, uint8 slot, uint32& result)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnGetArenaPersonalRating(player, slot, result);
    });
}

void ScriptMgr::OnGetArenaTeamId(Player* player, uint8 slot, uint32& result)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnGetArenaTeamId(player, slot, result);
    });
}

void ScriptMgr::OnIsFFAPvP(Player* player, bool& result)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnIsFFAPvP(player, result);
    });
}

void ScriptMgr::OnIsPvP(Player* player, bool& result)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnIsPvP(player, result);
    });
}

void ScriptMgr::OnGetMaxSkillValueForLevel(Player* player, uint16& result)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnGetMaxSkillValueForLevel(player, result);
    });
}

bool ScriptMgr::NotSetArenaTeamInfoField(Player* player, uint8 slot, ArenaTeamInfoType type, uint32 value)
{
    auto ret = IsValidBoolScript<PlayerScript>([&](PlayerScript* script)
    {
        return !script->NotSetArenaTeamInfoField(player, slot, type, value);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

bool ScriptMgr::CanJoinLfg(Player* player, uint8 roles, lfg::LfgDungeonSet& dungeons, const std::string& comment)
{
    auto ret = IsValidBoolScript<PlayerScript>([&](PlayerScript* script)
    {
        return !script->CanJoinLfg(player, roles, dungeons, comment);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

bool ScriptMgr::CanEnterMap(Player* player, MapEntry const* entry, InstanceTemplate const* instance, MapDifficulty const* mapDiff, bool loginCheck)
{
    auto ret = IsValidBoolScript<PlayerScript>([&](PlayerScript* script)
    {
        return !script->CanEnterMap(player, entry, instance, mapDiff, loginCheck);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

bool ScriptMgr::CanInitTrade(Player* player, Player* target)
{
    auto ret = IsValidBoolScript<PlayerScript>([&](PlayerScript* script)
    {
        return !script->CanInitTrade(player, target);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

void ScriptMgr::OnSetServerSideVisibility(Player* player, ServerSideVisibilityType& type, AccountTypes& sec)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnSetServerSideVisibility(player, type, sec);
    });
}

void ScriptMgr::OnSetServerSideVisibilityDetect(Player* player, ServerSideVisibilityType& type, AccountTypes& sec)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnSetServerSideVisibilityDetect(player, type, sec);
    });
}

void ScriptMgr::OnPlayerResurrect(Player* player, float restore_percent, bool applySickness)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnPlayerResurrect(player, restore_percent, applySickness);
    });
}

bool ScriptMgr::CanPlayerUseChat(Player* player, uint32 type, uint32 language, std::string& msg)
{
    auto ret = IsValidBoolScript<PlayerScript>([&](PlayerScript* script)
    {
        return !script->CanPlayerUseChat(player, type, language, msg);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

bool ScriptMgr::CanPlayerUseChat(Player* player, uint32 type, uint32 language, std::string& msg, Player* receiver)
{
    auto ret = IsValidBoolScript<PlayerScript>([&](PlayerScript* script)
    {
        return !script->CanPlayerUseChat(player, type, language, msg, receiver);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

bool ScriptMgr::CanPlayerUseChat(Player* player, uint32 type, uint32 language, std::string& msg, Group* group)
{
    auto ret = IsValidBoolScript<PlayerScript>([&](PlayerScript* script)
    {
        return !script->CanPlayerUseChat(player, type, language, msg, group);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

bool ScriptMgr::CanPlayerUseChat(Player* player, uint32 type, uint32 language, std::string& msg, Guild* guild)
{
    auto ret = IsValidBoolScript<PlayerScript>([&](PlayerScript* script)
    {
        return !script->CanPlayerUseChat(player, type, language, msg, guild);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

bool ScriptMgr::CanPlayerUseChat(Player* player, uint32 type, uint32 language, std::string& msg, Channel* channel)
{
    auto ret = IsValidBoolScript<PlayerScript>([&](PlayerScript* script)
    {
        return !script->CanPlayerUseChat(player, type, language, msg, channel);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

void ScriptMgr::OnPlayerLearnTalents(Player* player, uint32 talentId, uint32 talentRank, uint32 spellid)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnPlayerLearnTalents(player, talentId, talentRank, spellid);
    });
}

void ScriptMgr::OnPlayerEnterCombat(Player* player, Unit* enemy)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnPlayerEnterCombat(player, enemy);
    });
}

void ScriptMgr::OnPlayerLeaveCombat(Player* player)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnPlayerLeaveCombat(player);
    });
}

void ScriptMgr::OnQuestAbandon(Player* player, uint32 questId)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnQuestAbandon(player, questId);
    });
}

// Player anti cheat
void ScriptMgr::AnticheatSetSkipOnePacketForASH(Player* player, bool apply)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->AnticheatSetSkipOnePacketForASH(player, apply);
    });
}

void ScriptMgr::AnticheatSetCanFlybyServer(Player* player, bool apply)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->AnticheatSetCanFlybyServer(player, apply);
    });
}

void ScriptMgr::AnticheatSetUnderACKmount(Player* player)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->AnticheatSetUnderACKmount(player);
    });
}

void ScriptMgr::AnticheatSetRootACKUpd(Player* player)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->AnticheatSetRootACKUpd(player);
    });
}

void ScriptMgr::AnticheatSetJumpingbyOpcode(Player* player, bool jump)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->AnticheatSetJumpingbyOpcode(player, jump);
    });
}

void ScriptMgr::AnticheatUpdateMovementInfo(Player* player, MovementInfo const& movementInfo)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->AnticheatUpdateMovementInfo(player, movementInfo);
    });
}

bool ScriptMgr::AnticheatHandleDoubleJump(Player* player, Unit* mover)
{
    auto ret = IsValidBoolScript<PlayerScript>([&](PlayerScript* script)
    {
        return !script->AnticheatHandleDoubleJump(player, mover);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

bool ScriptMgr::AnticheatCheckMovementInfo(Player* player, MovementInfo const& movementInfo, Unit* mover, bool jump)
{
    auto ret = IsValidBoolScript<PlayerScript>([&](PlayerScript* script)
    {
        return !script->AnticheatCheckMovementInfo(player, movementInfo, mover, jump);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

bool ScriptMgr::CanGuildSendBankList(Guild const* guild, WorldSession* session, uint8 tabId, bool sendAllSlots)
{
    auto ret = IsValidBoolScript<GuildScript>([&](GuildScript* script)
    {
        return !script->CanGuildSendBankList(guild, session, tabId, sendAllSlots);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

bool ScriptMgr::CanGroupJoinBattlegroundQueue(Group const* group, Player* member, Battleground const* bgTemplate, uint32 MinPlayerCount, bool isRated, uint32 arenaSlot)
{
    auto ret = IsValidBoolScript<GroupScript>([&](GroupScript* script)
    {
        return !script->CanGroupJoinBattlegroundQueue(group, member, bgTemplate, MinPlayerCount, isRated, arenaSlot);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

void ScriptMgr::OnCreate(Group* group, Player* leader)
{
    ExecuteScript<GroupScript>([&](GroupScript* script)
    {
        script->OnCreate(group, leader);
    });
}

void ScriptMgr::OnAuraRemove(Unit* unit, AuraApplication* aurApp, AuraRemoveMode mode)
{
    ExecuteScript<UnitScript>([&](UnitScript* script)
    {
        script->OnAuraRemove(unit, aurApp, mode);
    });
}

bool ScriptMgr::IfNormalReaction(Unit const* unit, Unit const* target, ReputationRank& repRank)
{
    auto ret = IsValidBoolScript<UnitScript>([&](UnitScript* script)
    {
        return !script->IfNormalReaction(unit, target, repRank);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

bool ScriptMgr::IsNeedModSpellDamagePercent(Unit const* unit, AuraEffect* auraEff, float& doneTotalMod, SpellInfo const* spellProto)
{
    auto ret = IsValidBoolScript<UnitScript>([&](UnitScript* script)
    {
        return !script->IsNeedModSpellDamagePercent(unit, auraEff, doneTotalMod, spellProto);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

bool ScriptMgr::IsNeedModMeleeDamagePercent(Unit const* unit, AuraEffect* auraEff, float& doneTotalMod, SpellInfo const* spellProto)
{
    auto ret = IsValidBoolScript<UnitScript>([&](UnitScript* script)
    {
        return !script->IsNeedModMeleeDamagePercent(unit, auraEff, doneTotalMod, spellProto);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

bool ScriptMgr::IsNeedModHealPercent(Unit const* unit, AuraEffect* auraEff, float& doneTotalMod, SpellInfo const* spellProto)
{
    auto ret = IsValidBoolScript<UnitScript>([&](UnitScript* script)
    {
        return !script->IsNeedModHealPercent(unit, auraEff, doneTotalMod, spellProto);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

bool ScriptMgr::CanSetPhaseMask(Unit const* unit, uint32 newPhaseMask, bool update)
{
    auto ret = IsValidBoolScript<UnitScript>([&](UnitScript* script)
    {
        return !script->CanSetPhaseMask(unit, newPhaseMask, update);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

bool ScriptMgr::IsCustomBuildValuesUpdate(Unit const* unit, uint8 updateType, ByteBuffer& fieldBuffer, Player const* target, uint16 index)
{
    auto ret = IsValidBoolScript<UnitScript>([&](UnitScript* script)
    {
        return script->IsCustomBuildValuesUpdate(unit, updateType, fieldBuffer, target, index);
    });

    if (ret && *ret)
    {
        return true;
    }

    return false;
}

void ScriptMgr::OnUnitUpdate(Unit* unit, uint32 diff)
{
    ExecuteScript<UnitScript>([&](UnitScript* script)
    {
        script->OnUnitUpdate(unit, diff);
    });
}

// BG scripts
void ScriptMgr::OnQueueUpdate(BattlegroundQueue* queue, BattlegroundBracketId bracket_id, bool isRated, uint32 arenaRatedTeamId)
{
    ExecuteScript<BGScript>([&](BGScript* script)
    {
        script->OnQueueUpdate(queue, bracket_id, isRated, arenaRatedTeamId);
    });
}

bool ScriptMgr::CanSendMessageBGQueue(BattlegroundQueue* queue, Player* leader, Battleground* bg, PvPDifficultyEntry const* bracketEntry)
{
    auto ret = IsValidBoolScript<BGScript>([&](BGScript* script)
    {
        return !script->CanSendMessageBGQueue(queue, leader, bg, bracketEntry);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

bool ScriptMgr::OnBeforeSendJoinMessageArenaQueue(BattlegroundQueue* queue, Player* leader, GroupQueueInfo* ginfo, PvPDifficultyEntry const* bracketEntry, bool isRated)
{
    auto ret = IsValidBoolScript<BGScript>([&](BGScript* script)
    {
        return !script->OnBeforeSendJoinMessageArenaQueue(queue, leader, ginfo, bracketEntry, isRated);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

bool ScriptMgr::OnBeforeSendExitMessageArenaQueue(BattlegroundQueue* queue, GroupQueueInfo* ginfo)
{
    auto ret = IsValidBoolScript<BGScript>([&](BGScript* script)
    {
        return !script->OnBeforeSendExitMessageArenaQueue(queue, ginfo);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

void ScriptMgr::OnBattlegroundEnd(Battleground* bg, TeamId winnerTeam)
{
    ExecuteScript<BGScript>([&](BGScript* script)
    {
        script->OnBattlegroundEnd(bg, winnerTeam);
    });
}

void ScriptMgr::OnBattlegroundDestroy(Battleground* bg)
{
    ExecuteScript<BGScript>([&](BGScript* script)
    {
        script->OnBattlegroundDestroy(bg);
    });
}

void ScriptMgr::OnBattlegroundCreate(Battleground* bg)
{
    ExecuteScript<BGScript>([&](BGScript* script)
    {
        script->OnBattlegroundCreate(bg);
    });
}

bool ScriptMgr::CanModAuraEffectDamageDone(AuraEffect const* auraEff, Unit* target, AuraApplication const* aurApp, uint8 mode, bool apply)
{
    auto ret = IsValidBoolScript<SpellSC>([&](SpellSC* script)
    {
        return !script->CanModAuraEffectDamageDone(auraEff, target, aurApp, mode, apply);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

bool ScriptMgr::CanModAuraEffectModDamagePercentDone(AuraEffect const* auraEff, Unit* target, AuraApplication const* aurApp, uint8 mode, bool apply)
{
    auto ret = IsValidBoolScript<SpellSC>([&](SpellSC* script)
    {
        return !script->CanModAuraEffectModDamagePercentDone(auraEff, target, aurApp, mode, apply);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

void ScriptMgr::OnSpellCheckCast(Spell* spell, bool strict, SpellCastResult& res)
{
    ExecuteScript<SpellSC>([&](SpellSC* script)
    {
        script->OnSpellCheckCast(spell, strict, res);
    });
}

bool ScriptMgr::CanPrepare(Spell* spell, SpellCastTargets const* targets, AuraEffect const* triggeredByAura)
{
    auto ret = IsValidBoolScript<SpellSC>([&](SpellSC* script)
    {
        return !script->CanPrepare(spell, targets, triggeredByAura);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

bool ScriptMgr::CanScalingEverything(Spell* spell)
{
    auto ret = IsValidBoolScript<SpellSC>([&](SpellSC* script)
    {
        return script->CanScalingEverything(spell);
    });

    if (ret && *ret)
    {
        return true;
    }

    return false;
}

bool ScriptMgr::CanSelectSpecTalent(Spell* spell)
{
    auto ret = IsValidBoolScript<SpellSC>([&](SpellSC* script)
    {
        return !script->CanSelectSpecTalent(spell);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

void ScriptMgr::OnScaleAuraUnitAdd(Spell* spell, Unit* target, uint32 effectMask, bool checkIfValid, bool implicit, uint8 auraScaleMask, TargetInfo& targetInfo)
{
    ExecuteScript<SpellSC>([&](SpellSC* script)
    {
        script->OnScaleAuraUnitAdd(spell, target, effectMask, checkIfValid, implicit, auraScaleMask, targetInfo);
    });
}

void ScriptMgr::OnRemoveAuraScaleTargets(Spell* spell, TargetInfo& targetInfo, uint8 auraScaleMask, bool& needErase)
{
    ExecuteScript<SpellSC>([&](SpellSC* script)
    {
        script->OnRemoveAuraScaleTargets(spell, targetInfo, auraScaleMask, needErase);
    });
}

void ScriptMgr::OnBeforeAuraRankForLevel(SpellInfo const* spellInfo, SpellInfo const* latestSpellInfo, uint8 level)
{
    ExecuteScript<SpellSC>([&](SpellSC* script)
    {
        script->OnBeforeAuraRankForLevel(spellInfo, latestSpellInfo, level);
    });
}

void ScriptMgr::OnDummyEffect(WorldObject* caster, uint32 spellID, SpellEffIndex effIndex, GameObject* gameObjTarget)
{
    ExecuteScript<SpellSC>([&](SpellSC* script)
    {
        script->OnDummyEffect(caster, spellID, effIndex, gameObjTarget);
    });
}

void ScriptMgr::OnDummyEffect(WorldObject* caster, uint32 spellID, SpellEffIndex effIndex, Creature* creatureTarget)
{
    ExecuteScript<SpellSC>([&](SpellSC* script)
    {
        script->OnDummyEffect(caster, spellID, effIndex, creatureTarget);
    });
}

void ScriptMgr::OnDummyEffect(WorldObject* caster, uint32 spellID, SpellEffIndex effIndex, Item* itemTarget)
{
    ExecuteScript<SpellSC>([&](SpellSC* script)
    {
        script->OnDummyEffect(caster, spellID, effIndex, itemTarget);
    });
}

// AchievementScript
void ScriptMgr::SetRealmCompleted(AchievementEntry const* achievement)
{
    ExecuteScript<AchievementScript>([&](AchievementScript* script)
    {
        script->SetRealmCompleted(achievement);
    });
}

bool ScriptMgr::IsCompletedCriteria(AchievementMgr* mgr, AchievementCriteriaEntry const* achievementCriteria, AchievementEntry const* achievement, CriteriaProgress const* progress)
{
    auto ret = IsValidBoolScript<AchievementScript>([&](AchievementScript* script)
    {
        return !script->IsCompletedCriteria(mgr, achievementCriteria, achievement, progress);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

bool ScriptMgr::IsRealmCompleted(AchievementGlobalMgr const* globalmgr, AchievementEntry const* achievement, std::chrono::system_clock::time_point completionTime)
{
    auto ret = IsValidBoolScript<AchievementScript>([&](AchievementScript* script)
    {
        return !script->IsRealmCompleted(globalmgr, achievement, completionTime);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

void ScriptMgr::OnBeforeCheckCriteria(AchievementMgr* mgr, AchievementCriteriaEntryList const* achievementCriteriaList)
{
    ExecuteScript<AchievementScript>([&](AchievementScript* script)
    {
        script->OnBeforeCheckCriteria(mgr, achievementCriteriaList);
    });
}

bool ScriptMgr::CanCheckCriteria(AchievementMgr* mgr, AchievementCriteriaEntry const* achievementCriteria)
{
    auto ret = IsValidBoolScript<AchievementScript>([&](AchievementScript* script)
    {
        return !script->CanCheckCriteria(mgr, achievementCriteria);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

void ScriptMgr::OnInitStatsForLevel(Guardian* guardian, uint8 petlevel)
{
    ExecuteScript<PetScript>([&](PetScript* script)
    {
        script->OnInitStatsForLevel(guardian, petlevel);
    });
}

void ScriptMgr::OnCalculateMaxTalentPointsForLevel(Pet* pet, uint8 level, uint8& points)
{
    ExecuteScript<PetScript>([&](PetScript* script)
    {
        script->OnCalculateMaxTalentPointsForLevel(pet, level, points);
    });
}

bool ScriptMgr::CanUnlearnSpellSet(Pet* pet, uint32 level, uint32 spell)
{
    auto ret = IsValidBoolScript<PetScript>([&](PetScript* script)
    {
        return !script->CanUnlearnSpellSet(pet, level, spell);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

bool ScriptMgr::CanUnlearnSpellDefault(Pet* pet, SpellInfo const* spellEntry)
{
    auto ret = IsValidBoolScript<PetScript>([&](PetScript* script)
    {
        return !script->CanUnlearnSpellDefault(pet, spellEntry);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

bool ScriptMgr::CanResetTalents(Pet* pet)
{
    auto ret = IsValidBoolScript<PetScript>([&](PetScript* script)
    {
        return !script->CanResetTalents(pet);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

bool ScriptMgr::CanAddMember(ArenaTeam* team, ObjectGuid PlayerGuid)
{
    auto ret = IsValidBoolScript<ArenaScript>([&](ArenaScript* script)
    {
        return !script->CanAddMember(team, PlayerGuid);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

void ScriptMgr::OnGetPoints(ArenaTeam* team, uint32 memberRating, float& points)
{
    ExecuteScript<ArenaScript>([&](ArenaScript* script)
    {
        script->OnGetPoints(team, memberRating, points);
    });
}

bool ScriptMgr::CanSaveToDB(ArenaTeam* team)
{
    auto ret = IsValidBoolScript<ArenaScript>([&](ArenaScript* script)
    {
        return !script->CanSaveToDB(team);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

void ScriptMgr::OnItemCreate(Item* item, ItemTemplate const* itemProto, Player const* owner)
{
    ExecuteScript<MiscScript>([&](MiscScript* script)
    {
        script->OnItemCreate(item, itemProto, owner);
    });
}

bool ScriptMgr::CanApplySoulboundFlag(Item* item, ItemTemplate const* proto)
{
    auto ret = IsValidBoolScript<MiscScript>([&](MiscScript* script)
    {
        return !script->CanApplySoulboundFlag(item, proto);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

void ScriptMgr::OnConstructObject(Object* origin)
{
    ExecuteScript<MiscScript>([&](MiscScript* script)
    {
        script->OnConstructObject(origin);
    });
}

void ScriptMgr::OnDestructObject(Object* origin)
{
    ExecuteScript<MiscScript>([&](MiscScript* script)
    {
        script->OnDestructObject(origin);
    });
}

void ScriptMgr::OnConstructPlayer(Player* origin)
{
    ExecuteScript<MiscScript>([&](MiscScript* script)
    {
        script->OnConstructPlayer(origin);
    });
}

void ScriptMgr::OnDestructPlayer(Player* origin)
{
    ExecuteScript<MiscScript>([&](MiscScript* script)
    {
        script->OnDestructPlayer(origin);
    });
}

void ScriptMgr::OnConstructGroup(Group* origin)
{
    ExecuteScript<MiscScript>([&](MiscScript* script)
    {
        script->OnConstructGroup(origin);
    });
}

void ScriptMgr::OnDestructGroup(Group* origin)
{
    ExecuteScript<MiscScript>([&](MiscScript* script)
    {
        script->OnDestructGroup(origin);
    });
}

void ScriptMgr::OnConstructInstanceSave(InstanceSave* origin)
{
    ExecuteScript<MiscScript>([&](MiscScript* script)
    {
        script->OnConstructInstanceSave(origin);
    });
}

void ScriptMgr::OnDestructInstanceSave(InstanceSave* origin)
{
    ExecuteScript<MiscScript>([&](MiscScript* script)
    {
        script->OnDestructInstanceSave(origin);
    });
}

bool ScriptMgr::CanItemApplyEquipSpell(Player* player, Item* item)
{
    auto ret = IsValidBoolScript<MiscScript>([&](MiscScript* script)
    {
        return !script->CanItemApplyEquipSpell(player, item);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

bool ScriptMgr::CanSendAuctionHello(WorldSession const* session, ObjectGuid guid, Creature* creature)
{
    auto ret = IsValidBoolScript<MiscScript>([&](MiscScript* script)
    {
        return !script->CanSendAuctionHello(session, guid, creature);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

void ScriptMgr::ValidateSpellAtCastSpell(Player* player, uint32& oldSpellId, uint32& spellId, uint8& castCount, uint8& castFlags)
{
    ExecuteScript<MiscScript>([&](MiscScript* script)
    {
        script->ValidateSpellAtCastSpell(player, oldSpellId, spellId, castCount, castFlags);
    });
}

void ScriptMgr::ValidateSpellAtCastSpellResult(Player* player, Unit* mover, Spell* spell, uint32 oldSpellId, uint32 spellId)
{
    ExecuteScript<MiscScript>([&](MiscScript* script)
    {
        script->ValidateSpellAtCastSpellResult(player, mover, spell, oldSpellId, spellId);
    });
}

void ScriptMgr::OnAfterLootTemplateProcess(Loot* loot, LootTemplate const* tab, LootStore const& store, Player* lootOwner, bool personal, bool noEmptyError, uint16 lootMode)
{
    ExecuteScript<MiscScript>([&](MiscScript* script)
    {
        script->OnAfterLootTemplateProcess(loot, tab, store, lootOwner, personal, noEmptyError, lootMode);
    });
}

void ScriptMgr::OnInstanceSave(InstanceSave* instanceSave)
{
    ExecuteScript<MiscScript>([&](MiscScript* script)
    {
        script->OnInstanceSave(instanceSave);
    });
}

void ScriptMgr::OnPlayerSetPhase(const AuraEffect* auraEff, AuraApplication const* aurApp, uint8 mode, bool apply, uint32& newPhase)
{
    ExecuteScript<MiscScript>([&](MiscScript* script)
    {
        script->OnPlayerSetPhase(auraEff, aurApp, mode, apply, newPhase);
    });
}

void ScriptMgr::GetDialogStatus(Player* player, Object* questgiver)
{
    ExecuteScript<MiscScript>([&](MiscScript* script)
    {
        script->GetDialogStatus(player, questgiver);
    });
}

void ScriptMgr::OnAfterDatabasesLoaded(uint32 updateFlags)
{
    ExecuteScript<DatabaseScript>([&](DatabaseScript* script)
    {
        script->OnAfterDatabasesLoaded(updateFlags);
    });
}

// Command script custom
void ScriptMgr::OnHandleDevCommand(Player* player, std::string& argstr)
{
    ExecuteScript<CommandSC>([&](CommandSC* script)
    {
        script->OnHandleDevCommand(player, argstr);
    });
}

bool ScriptMgr::CanExecuteCommand(ChatHandler& handler, std::string_view cmdStr)
{
    auto ret = IsValidBoolScript<CommandSC>([&](CommandSC* script)
    {
        return !script->CanExecuteCommand(handler, cmdStr);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

// World object
void ScriptMgr::OnWorldObjectDestroy(WorldObject* object)
{
    ASSERT(object);
    ExecuteScript<WorldObjectScript>([&](WorldObjectScript* script)
    {
        script->OnWorldObjectDestroy(object);
    });
}

void ScriptMgr::OnWorldObjectCreate(WorldObject* object)
{
    ASSERT(object);
    ExecuteScript<WorldObjectScript>([&](WorldObjectScript* script)
    {
        script->OnWorldObjectCreate(object);
    });
}

void ScriptMgr::OnWorldObjectSetMap(WorldObject* object, Map* map)
{
    ASSERT(object);
    ExecuteScript<WorldObjectScript>([&](WorldObjectScript* script)
    {
        script->OnWorldObjectSetMap(object, map);
    });
}

void ScriptMgr::OnWorldObjectResetMap(WorldObject* object)
{
    ASSERT(object);
    ExecuteScript<WorldObjectScript>([&](WorldObjectScript* script)
    {
        script->OnWorldObjectResetMap(object);
    });
}

void ScriptMgr::OnWorldObjectUpdate(WorldObject* object, uint32 diff)
{
    ASSERT(object);
    ExecuteScript<WorldObjectScript>([&](WorldObjectScript* script)
    {
        script->OnWorldObjectUpdate(object, diff);
    });
}

// Pet
void ScriptMgr::OnPetAddToWorld(Pet* pet)
{
    ASSERT(pet);
    ExecuteScript<PetScript>([&](PetScript* script)
    {
        script->OnPetAddToWorld(pet);
    });
}

// Loot
void ScriptMgr::OnLootMoney(Player* player, uint32 gold)
{
    ASSERT(player);
    ExecuteScript<LootScript>([&](LootScript* script)
    {
        script->OnLootMoney(player, gold);
    });
}

// Map script
void ScriptMgr::OnBeforeCreateInstanceScript(InstanceMap* instanceMap, InstanceScript* instanceData, bool load, std::string data, uint32 completedEncounterMask)
{
    ExecuteScript<AllMapScript>([&](AllMapScript* script)
    {
        script->OnBeforeCreateInstanceScript(instanceMap, instanceData, load, data, completedEncounterMask);
    });
}

void ScriptMgr::OnDestroyInstance(MapInstanced* mapInstanced, Map* map)
{
    ExecuteScript<AllMapScript>([&](AllMapScript* script)
    {
        script->OnDestroyInstance(mapInstanced, map);
    });
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

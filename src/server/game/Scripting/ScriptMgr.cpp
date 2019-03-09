/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include "ScriptMgr.h"
#include "Config.h"
#include "DatabaseEnv.h"
#include "DBCStores.h"
#include "ObjectMgr.h"
#include "OutdoorPvPMgr.h"
#include "ScriptLoader.h"
#include "ScriptSystem.h"
#include "Transport.h"
#include "Vehicle.h"
#include "SpellInfo.h"
#include "SpellScript.h"
#include "GossipDef.h"
#include "CreatureAI.h"
#include "Player.h"
#include "WorldPacket.h"
#include "Chat.h"

#ifdef ELUNA
#include "LuaEngine.h"
#include "ElunaUtility.h"
#endif

// Specialize for each script type class like so:
template class ScriptRegistry<SpellScriptLoader>;
template class ScriptRegistry<ServerScript>;
template class ScriptRegistry<WorldScript>;
template class ScriptRegistry<FormulaScript>;
template class ScriptRegistry<WorldMapScript>;
template class ScriptRegistry<InstanceMapScript>;
template class ScriptRegistry<BattlegroundMapScript>;
template class ScriptRegistry<ItemScript>;
template class ScriptRegistry<CreatureScript>;
template class ScriptRegistry<GameObjectScript>;
template class ScriptRegistry<AreaTriggerScript>;
template class ScriptRegistry<BattlegroundScript>;
template class ScriptRegistry<OutdoorPvPScript>;
template class ScriptRegistry<CommandScript>;
template class ScriptRegistry<WeatherScript>;
template class ScriptRegistry<AuctionHouseScript>;
template class ScriptRegistry<ConditionScript>;
template class ScriptRegistry<VehicleScript>;
template class ScriptRegistry<DynamicObjectScript>;
template class ScriptRegistry<TransportScript>;
template class ScriptRegistry<AchievementCriteriaScript>;
template class ScriptRegistry<PlayerScript>;
template class ScriptRegistry<GuildScript>;
template class ScriptRegistry<GroupScript>;
template class ScriptRegistry<GlobalScript>;
template class ScriptRegistry<UnitScript>;
template class ScriptRegistry<AllCreatureScript>;
template class ScriptRegistry<AllMapScript>;
template class ScriptRegistry<MovementHandlerScript>;
template class ScriptRegistry<BGScript>;
template class ScriptRegistry<SpellSC>;
template class ScriptRegistry<AccountScript>;
template class ScriptRegistry<GameEventScript>;

#include "ScriptMgrMacros.h"

// This is the global static registry of scripts.
/*template<class TScript>
class ScriptRegistry
{
    public:

        typedef std::map<uint32, TScript*> ScriptMap;
        typedef typename ScriptMap::iterator ScriptMapIterator;

        // The actual list of scripts. This will be accessed concurrently, so it must not be modified
        // after server startup.
        static ScriptMap ScriptPointerList;

        static void AddScript(TScript* const script)
        {
            ASSERT(script);

            // See if the script is using the same memory as another script. If this happens, it means that
            // someone forgot to allocate new memory for a script.
            for (ScriptMapIterator it = ScriptPointerList.begin(); it != ScriptPointerList.end(); ++it)
            {
                if (it->second == script)
                {
                    sLog->outError("Script '%s' has same memory pointer as '%s'.",
                        script->GetName().c_str(), it->second->GetName().c_str());

                    return;
                }
            }

            if (script->IsDatabaseBound())
            {
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
                        sLog->outError("Script '%s' already assigned with the same script name, so the script can't work.",
                            script->GetName().c_str());

                        ASSERT(false); // Error that should be fixed ASAP.
                    }
                }
                else
                {
                    // The script uses a script name from database, but isn't assigned to anything.
                    if (script->GetName().find("example") == std::string::npos && script->GetName().find("Smart") == std::string::npos)
                        sLog->outErrorDb("Script named '%s' does not have a script name assigned in database.",
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

        // Gets a script by its ID (assigned by ObjectMgr).
        static TScript* GetScriptById(uint32 id)
        {
            ScriptMapIterator it = ScriptPointerList.find(id);
            if (it != ScriptPointerList.end())
                return it->second;

            return NULL;
        }

    private:

        // Counter used for code-only scripts.
        static uint32 _scriptIdCounter;
};*/

ScriptMgr::ScriptMgr()
    : _scriptCount(0), _scheduledScripts(0)
{

}

ScriptMgr::~ScriptMgr()
{
}

void ScriptMgr::Initialize()
{
    AddScripts();
    sLog->outString("Loading C++ scripts");
}

void ScriptMgr::Unload()
{
    #define SCR_CLEAR(T) \
        for (SCR_REG_ITR(T) itr = SCR_REG_LST(T).begin(); itr != SCR_REG_LST(T).end(); ++itr) \
            delete itr->second; \
        SCR_REG_LST(T).clear();

    // Clear scripts for every script type.
    SCR_CLEAR(SpellScriptLoader);
    SCR_CLEAR(ServerScript);
    SCR_CLEAR(WorldScript);
    SCR_CLEAR(FormulaScript);
    SCR_CLEAR(WorldMapScript);
    SCR_CLEAR(InstanceMapScript);
    SCR_CLEAR(BattlegroundMapScript);
    SCR_CLEAR(ItemScript);
    SCR_CLEAR(CreatureScript);
    SCR_CLEAR(GameObjectScript);
    SCR_CLEAR(AreaTriggerScript);
    SCR_CLEAR(BattlegroundScript);
    SCR_CLEAR(OutdoorPvPScript);
    SCR_CLEAR(CommandScript);
    SCR_CLEAR(WeatherScript);
    SCR_CLEAR(AuctionHouseScript);
    SCR_CLEAR(ConditionScript);
    SCR_CLEAR(VehicleScript);
    SCR_CLEAR(DynamicObjectScript);
    SCR_CLEAR(TransportScript);
    SCR_CLEAR(AchievementCriteriaScript);
    SCR_CLEAR(PlayerScript);
    SCR_CLEAR(AccountScript);
    SCR_CLEAR(GuildScript);
    SCR_CLEAR(GroupScript);
    SCR_CLEAR(GlobalScript);
    SCR_CLEAR(ModuleScript);
    SCR_CLEAR(BGScript);
    SCR_CLEAR(SpellSC);
    SCR_CLEAR(GameEventScript);

    #undef SCR_CLEAR
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

    sLog->outString(">> Loaded %u C++ scripts in %u ms", GetScriptCount(), GetMSTimeDiffToNow(oldMSTime));
    sLog->outString();
}

struct TSpellSummary
{
    uint8 Targets;                                          // set of enum SelectTarget
    uint8 Effects;                                          // set of enum SelectEffect
} *SpellSummary;

void ScriptMgr::CheckIfScriptsInDatabaseExist()
{
    ObjectMgr::ScriptNameContainer& sn = sObjectMgr->GetScriptNames();
    for (ObjectMgr::ScriptNameContainer::iterator itr = sn.begin(); itr != sn.end(); ++itr)
        if (uint32 sid = sObjectMgr->GetScriptId((*itr).c_str()))
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
                !ScriptRegistry<SpellSC>::GetScriptById(sid) &&
                !ScriptRegistry<GroupScript>::GetScriptById(sid))
                sLog->outErrorDb("Script named '%s' is assigned in database, but has no code!", (*itr).c_str());
        }
}

void ScriptMgr::FillSpellSummary()
{
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
                SpellSummary[i].Targets |= 1 << (SELECT_TARGET_SELF-1);

            // Spell targets a single enemy.
            if (pTempSpell->Effects[j].TargetA.GetTarget() == TARGET_UNIT_TARGET_ENEMY ||
                pTempSpell->Effects[j].TargetA.GetTarget() == TARGET_DEST_TARGET_ENEMY)
                SpellSummary[i].Targets |= 1 << (SELECT_TARGET_SINGLE_ENEMY-1);

            // Spell targets AoE at enemy.
            if (pTempSpell->Effects[j].TargetA.GetTarget() == TARGET_UNIT_SRC_AREA_ENEMY ||
                pTempSpell->Effects[j].TargetA.GetTarget() == TARGET_UNIT_DEST_AREA_ENEMY ||
                pTempSpell->Effects[j].TargetA.GetTarget() == TARGET_SRC_CASTER ||
                pTempSpell->Effects[j].TargetA.GetTarget() == TARGET_DEST_DYNOBJ_ENEMY)
                SpellSummary[i].Targets |= 1 << (SELECT_TARGET_AOE_ENEMY-1);

            // Spell targets an enemy.
            if (pTempSpell->Effects[j].TargetA.GetTarget() == TARGET_UNIT_TARGET_ENEMY ||
                pTempSpell->Effects[j].TargetA.GetTarget() == TARGET_DEST_TARGET_ENEMY ||
                pTempSpell->Effects[j].TargetA.GetTarget() == TARGET_UNIT_SRC_AREA_ENEMY ||
                pTempSpell->Effects[j].TargetA.GetTarget() == TARGET_UNIT_DEST_AREA_ENEMY ||
                pTempSpell->Effects[j].TargetA.GetTarget() == TARGET_SRC_CASTER ||
                pTempSpell->Effects[j].TargetA.GetTarget() == TARGET_DEST_DYNOBJ_ENEMY)
                SpellSummary[i].Targets |= 1 << (SELECT_TARGET_ANY_ENEMY-1);

            // Spell targets a single friend (or self).
            if (pTempSpell->Effects[j].TargetA.GetTarget() == TARGET_UNIT_CASTER ||
                pTempSpell->Effects[j].TargetA.GetTarget() == TARGET_UNIT_TARGET_ALLY ||
                pTempSpell->Effects[j].TargetA.GetTarget() == TARGET_UNIT_TARGET_PARTY)
                SpellSummary[i].Targets |= 1 << (SELECT_TARGET_SINGLE_FRIEND-1);

            // Spell targets AoE friends.
            if (pTempSpell->Effects[j].TargetA.GetTarget() == TARGET_UNIT_CASTER_AREA_PARTY ||
                pTempSpell->Effects[j].TargetA.GetTarget() == TARGET_UNIT_LASTTARGET_AREA_PARTY ||
                pTempSpell->Effects[j].TargetA.GetTarget() == TARGET_SRC_CASTER)
                SpellSummary[i].Targets |= 1 << (SELECT_TARGET_AOE_FRIEND-1);

            // Spell targets any friend (or self).
            if (pTempSpell->Effects[j].TargetA.GetTarget() == TARGET_UNIT_CASTER ||
                pTempSpell->Effects[j].TargetA.GetTarget() == TARGET_UNIT_TARGET_ALLY ||
                pTempSpell->Effects[j].TargetA.GetTarget() == TARGET_UNIT_TARGET_PARTY ||
                pTempSpell->Effects[j].TargetA.GetTarget() == TARGET_UNIT_CASTER_AREA_PARTY ||
                pTempSpell->Effects[j].TargetA.GetTarget() == TARGET_UNIT_LASTTARGET_AREA_PARTY ||
                pTempSpell->Effects[j].TargetA.GetTarget() == TARGET_SRC_CASTER)
                SpellSummary[i].Targets |= 1 << (SELECT_TARGET_ANY_FRIEND-1);

            // Make sure that this spell includes a damage effect.
            if (pTempSpell->Effects[j].Effect == SPELL_EFFECT_SCHOOL_DAMAGE ||
                pTempSpell->Effects[j].Effect == SPELL_EFFECT_INSTAKILL ||
                pTempSpell->Effects[j].Effect == SPELL_EFFECT_ENVIRONMENTAL_DAMAGE ||
                pTempSpell->Effects[j].Effect == SPELL_EFFECT_HEALTH_LEECH)
                SpellSummary[i].Effects |= 1 << (SELECT_EFFECT_DAMAGE-1);

            // Make sure that this spell includes a healing effect (or an apply aura with a periodic heal).
            if (pTempSpell->Effects[j].Effect == SPELL_EFFECT_HEAL ||
                pTempSpell->Effects[j].Effect == SPELL_EFFECT_HEAL_MAX_HEALTH ||
                pTempSpell->Effects[j].Effect == SPELL_EFFECT_HEAL_MECHANICAL ||
                (pTempSpell->Effects[j].Effect == SPELL_EFFECT_APPLY_AURA  && pTempSpell->Effects[j].ApplyAuraName == 8))
                SpellSummary[i].Effects |= 1 << (SELECT_EFFECT_HEALING-1);

            // Make sure that this spell applies an aura.
            if (pTempSpell->Effects[j].Effect == SPELL_EFFECT_APPLY_AURA)
                SpellSummary[i].Effects |= 1 << (SELECT_EFFECT_AURA-1);
        }
    }
}

void ScriptMgr::CreateSpellScripts(uint32 spellId, std::list<SpellScript*>& scriptVector)
{
    SpellScriptsBounds bounds = sObjectMgr->GetSpellScriptsBounds(spellId);

    for (SpellScriptsContainer::iterator itr = bounds.first; itr != bounds.second; ++itr)
    {
        SpellScriptLoader* tmpscript = ScriptRegistry<SpellScriptLoader>::GetScriptById(itr->second);
        if (!tmpscript)
            continue;

        SpellScript* script = tmpscript->GetSpellScript();

        if (!script)
            continue;

        script->_Init(&tmpscript->GetName(), spellId);

        scriptVector.push_back(script);
    }
}

void ScriptMgr::CreateAuraScripts(uint32 spellId, std::list<AuraScript*>& scriptVector)
{
    SpellScriptsBounds bounds = sObjectMgr->GetSpellScriptsBounds(spellId);

    for (SpellScriptsContainer::iterator itr = bounds.first; itr != bounds.second; ++itr)
    {
        SpellScriptLoader* tmpscript = ScriptRegistry<SpellScriptLoader>::GetScriptById(itr->second);
        if (!tmpscript)
            continue;

        AuraScript* script = tmpscript->GetAuraScript();

        if (!script)
            continue;

        script->_Init(&tmpscript->GetName(), spellId);

        scriptVector.push_back(script);
    }
}

void ScriptMgr::CreateSpellScriptLoaders(uint32 spellId, std::vector<std::pair<SpellScriptLoader*, SpellScriptsContainer::iterator> >& scriptVector)
{
    SpellScriptsBounds bounds = sObjectMgr->GetSpellScriptsBounds(spellId);
    scriptVector.reserve(std::distance(bounds.first, bounds.second));

    for (SpellScriptsContainer::iterator itr = bounds.first; itr != bounds.second; ++itr)
    {
        SpellScriptLoader* tmpscript = ScriptRegistry<SpellScriptLoader>::GetScriptById(itr->second);
        if (!tmpscript)
            continue;

        scriptVector.push_back(std::make_pair(tmpscript, itr));
    }
}

void ScriptMgr::OnNetworkStart()
{
    FOREACH_SCRIPT(ServerScript)->OnNetworkStart();
}

void ScriptMgr::OnNetworkStop()
{
    FOREACH_SCRIPT(ServerScript)->OnNetworkStop();
}

void ScriptMgr::OnSocketOpen(WorldSocket* socket)
{
    ASSERT(socket);

    FOREACH_SCRIPT(ServerScript)->OnSocketOpen(socket);
}

void ScriptMgr::OnSocketClose(WorldSocket* socket, bool wasNew)
{
    ASSERT(socket);

    FOREACH_SCRIPT(ServerScript)->OnSocketClose(socket, wasNew);
}

void ScriptMgr::OnPacketReceive(WorldSession* session, WorldPacket const& packet)
{
    if (SCR_REG_LST(ServerScript).empty())
        return;

    WorldPacket copy(packet);
    FOREACH_SCRIPT(ServerScript)->OnPacketReceive(session, copy);
}

void ScriptMgr::OnPacketSend(WorldSession* session, WorldPacket const& packet)
{
    ASSERT(session);

    if (SCR_REG_LST(ServerScript).empty())
        return;

    WorldPacket copy(packet);
    FOREACH_SCRIPT(ServerScript)->OnPacketSend(session, copy);
}


void ScriptMgr::OnOpenStateChange(bool open)
{
#ifdef ELUNA
    sEluna->OnOpenStateChange(open);
#endif
    FOREACH_SCRIPT(WorldScript)->OnOpenStateChange(open);
}


void ScriptMgr::OnLoadCustomDatabaseTable()
{
    FOREACH_SCRIPT(WorldScript)->OnLoadCustomDatabaseTable();
}

void ScriptMgr::OnBeforeConfigLoad(bool reload)
{
#ifdef ELUNA
    sEluna->OnConfigLoad(reload, true);
#endif
    FOREACH_SCRIPT(WorldScript)->OnBeforeConfigLoad(reload);
}

void ScriptMgr::OnAfterConfigLoad(bool reload)
{
#ifdef ELUNA
    sEluna->OnConfigLoad(reload, false);
#endif
    FOREACH_SCRIPT(WorldScript)->OnAfterConfigLoad(reload);
}

void ScriptMgr::OnMotdChange(std::string& newMotd)
{
    FOREACH_SCRIPT(WorldScript)->OnMotdChange(newMotd);
}

void ScriptMgr::OnShutdownInitiate(ShutdownExitCode code, ShutdownMask mask)
{
#ifdef ELUNA
    sEluna->OnShutdownInitiate(code, mask);
#endif
    FOREACH_SCRIPT(WorldScript)->OnShutdownInitiate(code, mask);
}

void ScriptMgr::OnShutdownCancel()
{
#ifdef ELUNA
    sEluna->OnShutdownCancel();
#endif
    FOREACH_SCRIPT(WorldScript)->OnShutdownCancel();
}

void ScriptMgr::OnWorldUpdate(uint32 diff)
{
#ifdef ELUNA
    sEluna->OnWorldUpdate(diff);
#endif
    FOREACH_SCRIPT(WorldScript)->OnUpdate(diff);
}

void ScriptMgr::OnHonorCalculation(float& honor, uint8 level, float multiplier)
{
    FOREACH_SCRIPT(FormulaScript)->OnHonorCalculation(honor, level, multiplier);
}

void ScriptMgr::OnGrayLevelCalculation(uint8& grayLevel, uint8 playerLevel)
{
    FOREACH_SCRIPT(FormulaScript)->OnGrayLevelCalculation(grayLevel, playerLevel);
}

void ScriptMgr::OnColorCodeCalculation(XPColorChar& color, uint8 playerLevel, uint8 mobLevel)
{
    FOREACH_SCRIPT(FormulaScript)->OnColorCodeCalculation(color, playerLevel, mobLevel);
}

void ScriptMgr::OnZeroDifferenceCalculation(uint8& diff, uint8 playerLevel)
{
    FOREACH_SCRIPT(FormulaScript)->OnZeroDifferenceCalculation(diff, playerLevel);
}

void ScriptMgr::OnBaseGainCalculation(uint32& gain, uint8 playerLevel, uint8 mobLevel, ContentLevels content)
{
    FOREACH_SCRIPT(FormulaScript)->OnBaseGainCalculation(gain, playerLevel, mobLevel, content);
}

void ScriptMgr::OnGainCalculation(uint32& gain, Player* player, Unit* unit)
{
    ASSERT(player);
    ASSERT(unit);

    FOREACH_SCRIPT(FormulaScript)->OnGainCalculation(gain, player, unit);
}

void ScriptMgr::OnGroupRateCalculation(float& rate, uint32 count, bool isRaid)
{
    FOREACH_SCRIPT(FormulaScript)->OnGroupRateCalculation(rate, count, isRaid);
}

#define SCR_MAP_BGN(M, V, I, E, C, T) \
    if (V->GetEntry() && V->GetEntry()->T()) \
    { \
        FOR_SCRIPTS(M, I, E) \
        { \
            MapEntry const* C = I->second->GetEntry(); \
            if (!C) \
                continue; \
            if (C->MapID == V->GetId()) \
            {

#define SCR_MAP_END \
                return; \
            } \
        } \
    }

void ScriptMgr::OnCreateMap(Map* map)
{
    ASSERT(map);

#ifdef ELUNA
    sEluna->OnCreate(map);
#endif

    SCR_MAP_BGN(WorldMapScript, map, itr, end, entry, IsWorldMap);
        itr->second->OnCreate(map);
    SCR_MAP_END;

    SCR_MAP_BGN(InstanceMapScript, map, itr, end, entry, IsDungeon);
        itr->second->OnCreate((InstanceMap*)map);
    SCR_MAP_END;

    SCR_MAP_BGN(BattlegroundMapScript, map, itr, end, entry, IsBattleground);
        itr->second->OnCreate((BattlegroundMap*)map);
    SCR_MAP_END;
}

void ScriptMgr::OnDestroyMap(Map* map)
{
    ASSERT(map);

#ifdef ELUNA
    sEluna->OnDestroy(map);
#endif

    SCR_MAP_BGN(WorldMapScript, map, itr, end, entry, IsWorldMap);
        itr->second->OnDestroy(map);
    SCR_MAP_END;

    SCR_MAP_BGN(InstanceMapScript, map, itr, end, entry, IsDungeon);
        itr->second->OnDestroy((InstanceMap*)map);
    SCR_MAP_END;

    SCR_MAP_BGN(BattlegroundMapScript, map, itr, end, entry, IsBattleground);
        itr->second->OnDestroy((BattlegroundMap*)map);
    SCR_MAP_END;
}

void ScriptMgr::OnLoadGridMap(Map* map, GridMap* gmap, uint32 gx, uint32 gy)
{
    ASSERT(map);
    ASSERT(gmap);

    SCR_MAP_BGN(WorldMapScript, map, itr, end, entry, IsWorldMap);
        itr->second->OnLoadGridMap(map, gmap, gx, gy);
    SCR_MAP_END;

    SCR_MAP_BGN(InstanceMapScript, map, itr, end, entry, IsDungeon);
        itr->second->OnLoadGridMap((InstanceMap*)map, gmap, gx, gy);
    SCR_MAP_END;

    SCR_MAP_BGN(BattlegroundMapScript, map, itr, end, entry, IsBattleground);
        itr->second->OnLoadGridMap((BattlegroundMap*)map, gmap, gx, gy);
    SCR_MAP_END;
}

void ScriptMgr::OnUnloadGridMap(Map* map, GridMap* gmap, uint32 gx, uint32 gy)
{
    ASSERT(map);
    ASSERT(gmap);

    SCR_MAP_BGN(WorldMapScript, map, itr, end, entry, IsWorldMap);
        itr->second->OnUnloadGridMap(map, gmap, gx, gy);
    SCR_MAP_END;

    SCR_MAP_BGN(InstanceMapScript, map, itr, end, entry, IsDungeon);
        itr->second->OnUnloadGridMap((InstanceMap*)map, gmap, gx, gy);
    SCR_MAP_END;

    SCR_MAP_BGN(BattlegroundMapScript, map, itr, end, entry, IsBattleground);
        itr->second->OnUnloadGridMap((BattlegroundMap*)map, gmap, gx, gy);
    SCR_MAP_END;
}

void ScriptMgr::OnPlayerEnterMap(Map* map, Player* player)
{
    ASSERT(map);
    ASSERT(player);

#ifdef ELUNA
    sEluna->OnMapChanged(player);
    sEluna->OnPlayerEnter(map, player);
#endif

    FOREACH_SCRIPT(AllMapScript)->OnPlayerEnterAll(map, player);

    FOREACH_SCRIPT(PlayerScript)->OnMapChanged(player);

    SCR_MAP_BGN(WorldMapScript, map, itr, end, entry, IsWorldMap);
        itr->second->OnPlayerEnter(map, player);
    SCR_MAP_END;

    SCR_MAP_BGN(InstanceMapScript, map, itr, end, entry, IsDungeon);
        itr->second->OnPlayerEnter((InstanceMap*)map, player);
    SCR_MAP_END;

    SCR_MAP_BGN(BattlegroundMapScript, map, itr, end, entry, IsBattleground);
        itr->second->OnPlayerEnter((BattlegroundMap*)map, player);
    SCR_MAP_END;
}

void ScriptMgr::OnPlayerLeaveMap(Map* map, Player* player)
{
    ASSERT(map);
    ASSERT(player);

#ifdef ELUNA
    sEluna->OnPlayerLeave(map, player);
#endif

    FOREACH_SCRIPT(AllMapScript)->OnPlayerLeaveAll(map, player);
    
    SCR_MAP_BGN(WorldMapScript, map, itr, end, entry, IsWorldMap);
        itr->second->OnPlayerLeave(map, player);
    SCR_MAP_END;

    SCR_MAP_BGN(InstanceMapScript, map, itr, end, entry, IsDungeon);
        itr->second->OnPlayerLeave((InstanceMap*)map, player);
    SCR_MAP_END;

    SCR_MAP_BGN(BattlegroundMapScript, map, itr, end, entry, IsBattleground);
        itr->second->OnPlayerLeave((BattlegroundMap*)map, player);
    SCR_MAP_END;
}

void ScriptMgr::OnMapUpdate(Map* map, uint32 diff)
{
    ASSERT(map);

#ifdef ELUNA
    sEluna->OnUpdate(map, diff);
#endif

    SCR_MAP_BGN(WorldMapScript, map, itr, end, entry, IsWorldMap);
        itr->second->OnUpdate(map, diff);
    SCR_MAP_END;

    SCR_MAP_BGN(InstanceMapScript, map, itr, end, entry, IsDungeon);
        itr->second->OnUpdate((InstanceMap*)map, diff);
    SCR_MAP_END;

    SCR_MAP_BGN(BattlegroundMapScript, map, itr, end, entry, IsBattleground);
        itr->second->OnUpdate((BattlegroundMap*)map, diff);
    SCR_MAP_END;
}

#undef SCR_MAP_BGN
#undef SCR_MAP_END

InstanceScript* ScriptMgr::CreateInstanceScript(InstanceMap* map)
{
    ASSERT(map);

    GET_SCRIPT_RET(InstanceMapScript, map->GetScriptId(), tmpscript, NULL);
    return tmpscript->GetInstanceScript(map);
}

bool ScriptMgr::OnQuestAccept(Player* player, Item* item, Quest const* quest)
{
    ASSERT(player);
    ASSERT(item);
    ASSERT(quest);

#ifdef ELUNA
    if (sEluna->OnQuestAccept(player, item, quest))
        return false;
#endif

    GET_SCRIPT_RET(ItemScript, item->GetScriptId(), tmpscript, false);
    player->PlayerTalkClass->ClearMenus();
    return tmpscript->OnQuestAccept(player, item, quest);
}

bool ScriptMgr::OnItemUse(Player* player, Item* item, SpellCastTargets const& targets)
{
    ASSERT(player);
    ASSERT(item);

#ifdef ELUNA
    if (!sEluna->OnUse(player, item, targets))
        return true;
#endif

    GET_SCRIPT_RET(ItemScript, item->GetScriptId(), tmpscript, false);
    return tmpscript->OnUse(player, item, targets);
}

bool ScriptMgr::OnItemExpire(Player* player, ItemTemplate const* proto)
{
    ASSERT(player);
    ASSERT(proto);

#ifdef ELUNA
    if (sEluna->OnExpire(player, proto))
        return false;
#endif

    GET_SCRIPT_RET(ItemScript, proto->ScriptId, tmpscript, false);
    return tmpscript->OnExpire(player, proto);
}

bool ScriptMgr::OnItemRemove(Player * player, Item * item)
{
    ASSERT(player);
    ASSERT(item);
#ifdef ELUNA
    if (sEluna->OnRemove(player, item))
        return false;
#endif
    GET_SCRIPT_RET(ItemScript, item->GetScriptId(), tmpscript, false);
    return tmpscript->OnRemove(player, item);

}

void ScriptMgr::OnGossipSelect(Player* player, Item* item, uint32 sender, uint32 action)
{
    ASSERT(player);
    ASSERT(item);
#ifdef ELUNA
    sEluna->HandleGossipSelectOption(player, item, sender, action, "");
#endif
    GET_SCRIPT(ItemScript, item->GetScriptId(), tmpscript);
    tmpscript->OnGossipSelect(player, item, sender, action);
}

void ScriptMgr::OnGossipSelectCode(Player* player, Item* item, uint32 sender, uint32 action, const char* code)
{
    ASSERT(player);
    ASSERT(item);
#ifdef ELUNA
    sEluna->HandleGossipSelectOption(player, item, sender, action, code);
#endif
    GET_SCRIPT(ItemScript, item->GetScriptId(), tmpscript);
    tmpscript->OnGossipSelectCode(player, item, sender, action, code);
}

void ScriptMgr::OnGossipSelect(Player* player, uint32 menu_id, uint32 sender, uint32 action)
{
#ifdef ELUNA
    sEluna->HandleGossipSelectOption(player, menu_id, sender, action, "");
#endif
    FOREACH_SCRIPT(PlayerScript)->OnGossipSelect(player, menu_id, sender, action);
}

void ScriptMgr::OnGossipSelectCode(Player* player, uint32 menu_id, uint32 sender, uint32 action, const char* code)
{
#ifdef ELUNA
    sEluna->HandleGossipSelectOption(player, menu_id, sender, action, code);
#endif
    FOREACH_SCRIPT(PlayerScript)->OnGossipSelectCode(player, menu_id, sender, action, code);
}

bool ScriptMgr::OnGossipHello(Player* player, Creature* creature)
{
    ASSERT(player);
    ASSERT(creature);
#ifdef ELUNA
    if (sEluna->OnGossipHello(player, creature))
        return true;
#endif
    GET_SCRIPT_RET(CreatureScript, creature->GetScriptId(), tmpscript, false);
    player->PlayerTalkClass->ClearMenus();
    return tmpscript->OnGossipHello(player, creature);
}

bool ScriptMgr::OnGossipSelect(Player* player, Creature* creature, uint32 sender, uint32 action)
{
    ASSERT(player);
    ASSERT(creature);
#ifdef ELUNA
    if (sEluna->OnGossipSelect(player, creature, sender, action))
        return true;
#endif
    GET_SCRIPT_RET(CreatureScript, creature->GetScriptId(), tmpscript, false);
    return tmpscript->OnGossipSelect(player, creature, sender, action);
}

bool ScriptMgr::OnGossipSelectCode(Player* player, Creature* creature, uint32 sender, uint32 action, const char* code)
{
    ASSERT(player);
    ASSERT(creature);
    ASSERT(code);
#ifdef ELUNA
    if (sEluna->OnGossipSelectCode(player, creature, sender, action, code))
        return true;
#endif
    GET_SCRIPT_RET(CreatureScript, creature->GetScriptId(), tmpscript, false);
    return tmpscript->OnGossipSelectCode(player, creature, sender, action, code);
}

bool ScriptMgr::OnQuestAccept(Player* player, Creature* creature, Quest const* quest)
{
    ASSERT(player);
    ASSERT(creature);
    ASSERT(quest);

    GET_SCRIPT_RET(CreatureScript, creature->GetScriptId(), tmpscript, false);
    player->PlayerTalkClass->ClearMenus();
    return tmpscript->OnQuestAccept(player, creature, quest);
}

bool ScriptMgr::OnQuestSelect(Player* player, Creature* creature, Quest const* quest)
{
    ASSERT(player);
    ASSERT(creature);
    ASSERT(quest);

    GET_SCRIPT_RET(CreatureScript, creature->GetScriptId(), tmpscript, false);
    player->PlayerTalkClass->ClearMenus();
    return tmpscript->OnQuestSelect(player, creature, quest);
}

bool ScriptMgr::OnQuestComplete(Player* player, Creature* creature, Quest const* quest)
{
    ASSERT(player);
    ASSERT(creature);
    ASSERT(quest);

    GET_SCRIPT_RET(CreatureScript, creature->GetScriptId(), tmpscript, false);
    player->PlayerTalkClass->ClearMenus();
    return tmpscript->OnQuestComplete(player, creature, quest);
}

bool ScriptMgr::OnQuestReward(Player* player, Creature* creature, Quest const* quest, uint32 opt)
{
    ASSERT(player);
    ASSERT(creature);
    ASSERT(quest);
#ifdef ELUNA
    if (sEluna->OnQuestReward(player, creature, quest, opt))
    {
        player->PlayerTalkClass->ClearMenus();
        return false;
    }
#endif
    GET_SCRIPT_RET(CreatureScript, creature->GetScriptId(), tmpscript, false);
    player->PlayerTalkClass->ClearMenus();
    return tmpscript->OnQuestReward(player, creature, quest, opt);
}

uint32 ScriptMgr::GetDialogStatus(Player* player, Creature* creature)
{
    ASSERT(player);
    ASSERT(creature);

    GET_SCRIPT_RET(CreatureScript, creature->GetScriptId(), tmpscript, DIALOG_STATUS_SCRIPTED_NO_STATUS);
    player->PlayerTalkClass->ClearMenus();
    return tmpscript->GetDialogStatus(player, creature);
}

CreatureAI* ScriptMgr::GetCreatureAI(Creature* creature)
{
    ASSERT(creature);

#ifdef ELUNA
    if (CreatureAI* luaAI = sEluna->GetAI(creature))
        return luaAI;
#endif

    GET_SCRIPT_RET(CreatureScript, creature->GetScriptId(), tmpscript, NULL);
    return tmpscript->GetAI(creature);
}

void ScriptMgr::OnCreatureUpdate(Creature* creature, uint32 diff)
{
    ASSERT(creature);

    FOREACH_SCRIPT(AllCreatureScript)->OnAllCreatureUpdate(creature, diff);

    GET_SCRIPT(CreatureScript, creature->GetScriptId(), tmpscript);
    tmpscript->OnUpdate(creature, diff);
}

bool ScriptMgr::OnGossipHello(Player* player, GameObject* go)
{
    ASSERT(player);
    ASSERT(go);
#ifdef ELUNA
    if (sEluna->OnGossipHello(player, go))
        return true;
    if (sEluna->OnGameObjectUse(player, go))
        return true;
#endif
    GET_SCRIPT_RET(GameObjectScript, go->GetScriptId(), tmpscript, false);
    player->PlayerTalkClass->ClearMenus();
    return tmpscript->OnGossipHello(player, go);
}

bool ScriptMgr::OnGossipSelect(Player* player, GameObject* go, uint32 sender, uint32 action)
{
    ASSERT(player);
    ASSERT(go);
#ifdef ELUNA
    if (sEluna->OnGossipSelect(player, go, sender, action))
        return true;
#endif
    GET_SCRIPT_RET(GameObjectScript, go->GetScriptId(), tmpscript, false);
    return tmpscript->OnGossipSelect(player, go, sender, action);
}

bool ScriptMgr::OnGossipSelectCode(Player* player, GameObject* go, uint32 sender, uint32 action, const char* code)
{
    ASSERT(player);
    ASSERT(go);
    ASSERT(code);
#ifdef ELUNA
    if (sEluna->OnGossipSelectCode(player, go, sender, action, code))
        return true;
#endif
    GET_SCRIPT_RET(GameObjectScript, go->GetScriptId(), tmpscript, false);
    return tmpscript->OnGossipSelectCode(player, go, sender, action, code);
}

bool ScriptMgr::OnQuestAccept(Player* player, GameObject* go, Quest const* quest)
{
    ASSERT(player);
    ASSERT(go);
    ASSERT(quest);

    GET_SCRIPT_RET(GameObjectScript, go->GetScriptId(), tmpscript, false);
    player->PlayerTalkClass->ClearMenus();
    return tmpscript->OnQuestAccept(player, go, quest);
}

bool ScriptMgr::OnQuestReward(Player* player, GameObject* go, Quest const* quest, uint32 opt)
{
    ASSERT(player);
    ASSERT(go);
    ASSERT(quest);
#ifdef ELUNA
    if (sEluna->OnQuestAccept(player, go, quest))
        return false;
#endif
#ifdef ELUNA
    if (sEluna->OnQuestReward(player, go, quest, opt))
        return false;
#endif
    GET_SCRIPT_RET(GameObjectScript, go->GetScriptId(), tmpscript, false);
    player->PlayerTalkClass->ClearMenus();
    return tmpscript->OnQuestReward(player, go, quest, opt);
}

uint32 ScriptMgr::GetDialogStatus(Player* player, GameObject* go)
{
    ASSERT(player);
    ASSERT(go);

    GET_SCRIPT_RET(GameObjectScript, go->GetScriptId(), tmpscript, DIALOG_STATUS_SCRIPTED_NO_STATUS);
    player->PlayerTalkClass->ClearMenus();
    return tmpscript->GetDialogStatus(player, go);
}

void ScriptMgr::OnGameObjectDestroyed(GameObject* go, Player* player)
{
    ASSERT(go);

    GET_SCRIPT(GameObjectScript, go->GetScriptId(), tmpscript);
    tmpscript->OnDestroyed(go, player);
}

void ScriptMgr::OnGameObjectDamaged(GameObject* go, Player* player)
{
    ASSERT(go);

    GET_SCRIPT(GameObjectScript, go->GetScriptId(), tmpscript);
    tmpscript->OnDamaged(go, player);
}

void ScriptMgr::OnGameObjectLootStateChanged(GameObject* go, uint32 state, Unit* unit)
{
    ASSERT(go);

    GET_SCRIPT(GameObjectScript, go->GetScriptId(), tmpscript);
    tmpscript->OnLootStateChanged(go, state, unit);
}

void ScriptMgr::OnGameObjectStateChanged(GameObject* go, uint32 state)
{
    ASSERT(go);

    GET_SCRIPT(GameObjectScript, go->GetScriptId(), tmpscript);
    tmpscript->OnGameObjectStateChanged(go, state);
}

void ScriptMgr::OnGameObjectUpdate(GameObject* go, uint32 diff)
{
    ASSERT(go);

#ifdef ELUNA
    sEluna->UpdateAI(go, diff);
#endif

    GET_SCRIPT(GameObjectScript, go->GetScriptId(), tmpscript);
    tmpscript->OnUpdate(go, diff);
}

GameObjectAI* ScriptMgr::GetGameObjectAI(GameObject* go)
{
    ASSERT(go);

#ifdef ELUNA
    sEluna->OnSpawn(go);
#endif

    GET_SCRIPT_RET(GameObjectScript, go->GetScriptId(), tmpscript, NULL);
    return tmpscript->GetAI(go);
}

bool ScriptMgr::OnAreaTrigger(Player* player, AreaTrigger const* trigger)
{
    ASSERT(player);
    ASSERT(trigger);
#ifdef ELUNA
    if (sEluna->OnAreaTrigger(player, trigger))
        return false;
#endif
    GET_SCRIPT_RET(AreaTriggerScript, sObjectMgr->GetAreaTriggerScriptId(trigger->entry), tmpscript, false);
    return tmpscript->OnTrigger(player, trigger);
}

Battleground* ScriptMgr::CreateBattleground(BattlegroundTypeId /*typeId*/)
{
    // TODO: Implement script-side battlegrounds.
    ASSERT(false);
    return NULL;
}

OutdoorPvP* ScriptMgr::CreateOutdoorPvP(OutdoorPvPData const* data)
{
    ASSERT(data);

    GET_SCRIPT_RET(OutdoorPvPScript, data->ScriptId, tmpscript, NULL);
    return tmpscript->GetOutdoorPvP();
}

std::vector<ChatCommand> ScriptMgr::GetChatCommands()
{
    std::vector<ChatCommand> table;

    FOR_SCRIPTS_RET(CommandScript, itr, end, table)
    {
        std::vector<ChatCommand> cmds = itr->second->GetCommands();
        table.insert(table.end(), cmds.begin(), cmds.end());
    }

    // Sort commands in alphabetical order
    std::sort(table.begin(), table.end(), [](const ChatCommand& a, const ChatCommand&b)
    {
        return strcmp(a.Name, b.Name) < 0;
    });

    return table;
}

void ScriptMgr::OnWeatherChange(Weather* weather, WeatherState state, float grade)
{
    ASSERT(weather);

#ifdef ELUNA
    sEluna->OnChange(weather, weather->GetZone(), state, grade);
#endif

    GET_SCRIPT(WeatherScript, weather->GetScriptId(), tmpscript);
    tmpscript->OnChange(weather, state, grade);
}

void ScriptMgr::OnWeatherUpdate(Weather* weather, uint32 diff)
{
    ASSERT(weather);

    GET_SCRIPT(WeatherScript, weather->GetScriptId(), tmpscript);
    tmpscript->OnUpdate(weather, diff);
}

void ScriptMgr::OnAuctionAdd(AuctionHouseObject* ah, AuctionEntry* entry)
{
    ASSERT(ah);
    ASSERT(entry);

#ifdef ELUNA
    sEluna->OnAdd(ah, entry);
#endif

    FOREACH_SCRIPT(AuctionHouseScript)->OnAuctionAdd(ah, entry);
}

void ScriptMgr::OnAuctionRemove(AuctionHouseObject* ah, AuctionEntry* entry)
{
    ASSERT(ah);
    ASSERT(entry);

#ifdef ELUNA
    sEluna->OnRemove(ah, entry);
#endif

    FOREACH_SCRIPT(AuctionHouseScript)->OnAuctionRemove(ah, entry);
}

void ScriptMgr::OnAuctionSuccessful(AuctionHouseObject* ah, AuctionEntry* entry)
{
    ASSERT(ah);
    ASSERT(entry);

#ifdef ELUNA
    sEluna->OnSuccessful(ah, entry);
#endif

    FOREACH_SCRIPT(AuctionHouseScript)->OnAuctionSuccessful(ah, entry);
}

void ScriptMgr::OnAuctionExpire(AuctionHouseObject* ah, AuctionEntry* entry)
{
    ASSERT(ah);
    ASSERT(entry);

#ifdef ELUNA
    sEluna->OnExpire(ah, entry);
#endif

    FOREACH_SCRIPT(AuctionHouseScript)->OnAuctionExpire(ah, entry);
}

bool ScriptMgr::OnConditionCheck(Condition* condition, ConditionSourceInfo& sourceInfo)
{
    ASSERT(condition);

    GET_SCRIPT_RET(ConditionScript, condition->ScriptId, tmpscript, true);
    return tmpscript->OnConditionCheck(condition, sourceInfo);
}

void ScriptMgr::OnInstall(Vehicle* veh)
{
    ASSERT(veh);
    ASSERT(veh->GetBase()->GetTypeId() == TYPEID_UNIT);

#ifdef ELUNA
    sEluna->OnInstall(veh);
#endif

    GET_SCRIPT(VehicleScript, veh->GetBase()->ToCreature()->GetScriptId(), tmpscript);
    tmpscript->OnInstall(veh);
}

void ScriptMgr::OnUninstall(Vehicle* veh)
{
    ASSERT(veh);
    ASSERT(veh->GetBase()->GetTypeId() == TYPEID_UNIT);

#ifdef ELUNA
    sEluna->OnUninstall(veh);
#endif

    GET_SCRIPT(VehicleScript, veh->GetBase()->ToCreature()->GetScriptId(), tmpscript);
    tmpscript->OnUninstall(veh);
}

void ScriptMgr::OnReset(Vehicle* veh)
{
    ASSERT(veh);
    ASSERT(veh->GetBase()->GetTypeId() == TYPEID_UNIT);

    GET_SCRIPT(VehicleScript, veh->GetBase()->ToCreature()->GetScriptId(), tmpscript);
    tmpscript->OnReset(veh);
}

void ScriptMgr::OnInstallAccessory(Vehicle* veh, Creature* accessory)
{
    ASSERT(veh);
    ASSERT(veh->GetBase()->GetTypeId() == TYPEID_UNIT);
    ASSERT(accessory);

#ifdef ELUNA
    sEluna->OnInstallAccessory(veh, accessory);
#endif

    GET_SCRIPT(VehicleScript, veh->GetBase()->ToCreature()->GetScriptId(), tmpscript);
    tmpscript->OnInstallAccessory(veh, accessory);
}

void ScriptMgr::OnAddPassenger(Vehicle* veh, Unit* passenger, int8 seatId)
{
    ASSERT(veh);
    ASSERT(veh->GetBase()->GetTypeId() == TYPEID_UNIT);
    ASSERT(passenger);

#ifdef ELUNA
    sEluna->OnAddPassenger(veh, passenger, seatId);
#endif

    GET_SCRIPT(VehicleScript, veh->GetBase()->ToCreature()->GetScriptId(), tmpscript);
    tmpscript->OnAddPassenger(veh, passenger, seatId);
}

void ScriptMgr::OnRemovePassenger(Vehicle* veh, Unit* passenger)
{
    ASSERT(veh);
    ASSERT(veh->GetBase()->GetTypeId() == TYPEID_UNIT);
    ASSERT(passenger);

#ifdef ELUNA
    sEluna->OnRemovePassenger(veh, passenger);
#endif

    GET_SCRIPT(VehicleScript, veh->GetBase()->ToCreature()->GetScriptId(), tmpscript);
    tmpscript->OnRemovePassenger(veh, passenger);
}

void ScriptMgr::OnDynamicObjectUpdate(DynamicObject* dynobj, uint32 diff)
{
    ASSERT(dynobj);

    FOR_SCRIPTS(DynamicObjectScript, itr, end)
        itr->second->OnUpdate(dynobj, diff);
}

void ScriptMgr::OnAddPassenger(Transport* transport, Player* player)
{
    ASSERT(transport);
    ASSERT(player);

    GET_SCRIPT(TransportScript, transport->GetScriptId(), tmpscript);
    tmpscript->OnAddPassenger(transport, player);
}

void ScriptMgr::OnAddCreaturePassenger(Transport* transport, Creature* creature)
{
    ASSERT(transport);
    ASSERT(creature);

    GET_SCRIPT(TransportScript, transport->GetScriptId(), tmpscript);
    tmpscript->OnAddCreaturePassenger(transport, creature);
}

void ScriptMgr::OnRemovePassenger(Transport* transport, Player* player)
{
    ASSERT(transport);
    ASSERT(player);

    GET_SCRIPT(TransportScript, transport->GetScriptId(), tmpscript);
    tmpscript->OnRemovePassenger(transport, player);
}

void ScriptMgr::OnTransportUpdate(Transport* transport, uint32 diff)
{
    ASSERT(transport);

    GET_SCRIPT(TransportScript, transport->GetScriptId(), tmpscript);
    tmpscript->OnUpdate(transport, diff);
}

void ScriptMgr::OnRelocate(Transport* transport, uint32 waypointId, uint32 mapId, float x, float y, float z)
{
    GET_SCRIPT(TransportScript, transport->GetScriptId(), tmpscript);
    tmpscript->OnRelocate(transport, waypointId, mapId, x, y, z);
}

void ScriptMgr::OnStartup()
{
#ifdef ELUNA
    sEluna->OnStartup();
#endif
    FOREACH_SCRIPT(WorldScript)->OnStartup();
}

void ScriptMgr::OnShutdown()
{
#ifdef ELUNA
    sEluna->OnShutdown();
#endif
    FOREACH_SCRIPT(WorldScript)->OnShutdown();
}

bool ScriptMgr::OnCriteriaCheck(uint32 scriptId, Player* source, Unit* target, uint32 criteria_id)
{
    ASSERT(source);
    // target can be NULL.

    GET_SCRIPT_RET(AchievementCriteriaScript, scriptId, tmpscript, false);
    return tmpscript->OnCheck(source, target, criteria_id);
}

// Player

void ScriptMgr::OnPlayerCompleteQuest(Player* player, Quest const* quest)
{
    FOREACH_SCRIPT(PlayerScript)->OnPlayerCompleteQuest(player, quest);
}

void ScriptMgr::OnPlayerReleasedGhost(Player* player)
{
    FOREACH_SCRIPT(PlayerScript)->OnPlayerReleasedGhost(player);
}

void ScriptMgr::OnPVPKill(Player* killer, Player* killed)
{
#ifdef ELUNA
    sEluna->OnPVPKill(killer, killed);
#endif
    FOREACH_SCRIPT(PlayerScript)->OnPVPKill(killer, killed);
}

void ScriptMgr::OnCreatureKill(Player* killer, Creature* killed)
{
#ifdef ELUNA
    sEluna->OnCreatureKill(killer, killed);
#endif
    FOREACH_SCRIPT(PlayerScript)->OnCreatureKill(killer, killed);
}

void ScriptMgr::OnCreatureKilledByPet(Player* petOwner, Creature* killed)
{
    FOREACH_SCRIPT(PlayerScript)->OnCreatureKilledByPet(petOwner, killed);
}

void ScriptMgr::OnPlayerKilledByCreature(Creature* killer, Player* killed)
{
#ifdef ELUNA
    sEluna->OnPlayerKilledByCreature(killer, killed);
#endif
    FOREACH_SCRIPT(PlayerScript)->OnPlayerKilledByCreature(killer, killed);
}

void ScriptMgr::OnPlayerLevelChanged(Player* player, uint8 oldLevel)
{
#ifdef ELUNA
    sEluna->OnLevelChanged(player, oldLevel);
#endif
    FOREACH_SCRIPT(PlayerScript)->OnLevelChanged(player, oldLevel);
}

void ScriptMgr::OnPlayerFreeTalentPointsChanged(Player* player, uint32 points)
{
#ifdef ELUNA
    sEluna->OnFreeTalentPointsChanged(player, points);
#endif
    FOREACH_SCRIPT(PlayerScript)->OnFreeTalentPointsChanged(player, points);
}

void ScriptMgr::OnPlayerTalentsReset(Player* player, bool noCost)
{
#ifdef ELUNA
    sEluna->OnTalentsReset(player, noCost);
#endif
    FOREACH_SCRIPT(PlayerScript)->OnTalentsReset(player, noCost);
}

void ScriptMgr::OnPlayerMoneyChanged(Player* player, int32& amount)
{
#ifdef ELUNA
    sEluna->OnMoneyChanged(player, amount);
#endif
    FOREACH_SCRIPT(PlayerScript)->OnMoneyChanged(player, amount);
}

void ScriptMgr::OnGivePlayerXP(Player* player, uint32& amount, Unit* victim)
{
#ifdef ELUNA
    sEluna->OnGiveXP(player, amount, victim);
#endif
    FOREACH_SCRIPT(PlayerScript)->OnGiveXP(player, amount, victim);
}

void ScriptMgr::OnPlayerReputationChange(Player* player, uint32 factionID, int32& standing, bool incremental)
{
#ifdef ELUNA
    sEluna->OnReputationChange(player, factionID, standing, incremental);
#endif
    FOREACH_SCRIPT(PlayerScript)->OnReputationChange(player, factionID, standing, incremental);
}

void ScriptMgr::OnPlayerReputationRankChange(Player* player, uint32 factionID, ReputationRank newRank, ReputationRank oldRank, bool increased)
{
    FOREACH_SCRIPT(PlayerScript)->OnReputationRankChange(player, factionID, newRank, oldRank, increased);
}

void ScriptMgr::OnPlayerLearnSpell(Player* player, uint32 spellID)
{
    FOREACH_SCRIPT(PlayerScript)->OnLearnSpell(player, spellID);
}

void ScriptMgr::OnPlayerForgotSpell(Player* player, uint32 spellID)
{
    FOREACH_SCRIPT(PlayerScript)->OnForgotSpell(player, spellID);
}

void ScriptMgr::OnPlayerDuelRequest(Player* target, Player* challenger)
{
#ifdef ELUNA
    sEluna->OnDuelRequest(target, challenger);
#endif
    FOREACH_SCRIPT(PlayerScript)->OnDuelRequest(target, challenger);
}

void ScriptMgr::OnPlayerDuelStart(Player* player1, Player* player2)
{
#ifdef ELUNA
    sEluna->OnDuelStart(player1, player2);
#endif
    FOREACH_SCRIPT(PlayerScript)->OnDuelStart(player1, player2);
}

void ScriptMgr::OnPlayerDuelEnd(Player* winner, Player* loser, DuelCompleteType type)
{
#ifdef ELUNA
    sEluna->OnDuelEnd(winner, loser, type);
#endif
    FOREACH_SCRIPT(PlayerScript)->OnDuelEnd(winner, loser, type);
}

void ScriptMgr::OnPlayerChat(Player* player, uint32 type, uint32 lang, std::string& msg)
{
    FOREACH_SCRIPT(PlayerScript)->OnChat(player, type, lang, msg);
}

void ScriptMgr::OnPlayerChat(Player* player, uint32 type, uint32 lang, std::string& msg, Player* receiver)
{
    FOREACH_SCRIPT(PlayerScript)->OnChat(player, type, lang, msg, receiver);
}

void ScriptMgr::OnPlayerChat(Player* player, uint32 type, uint32 lang, std::string& msg, Group* group)
{
    FOREACH_SCRIPT(PlayerScript)->OnChat(player, type, lang, msg, group);
}

void ScriptMgr::OnPlayerChat(Player* player, uint32 type, uint32 lang, std::string& msg, Guild* guild)
{
    FOREACH_SCRIPT(PlayerScript)->OnChat(player, type, lang, msg, guild);
}

void ScriptMgr::OnPlayerChat(Player* player, uint32 type, uint32 lang, std::string& msg, Channel* channel)
{
    FOREACH_SCRIPT(PlayerScript)->OnChat(player, type, lang, msg, channel);
}

void ScriptMgr::OnPlayerEmote(Player* player, uint32 emote)
{
#ifdef ELUNA
    sEluna->OnEmote(player, emote);
#endif
    FOREACH_SCRIPT(PlayerScript)->OnEmote(player, emote);
}

void ScriptMgr::OnPlayerTextEmote(Player* player, uint32 textEmote, uint32 emoteNum, uint64 guid)
{
#ifdef ELUNA
    sEluna->OnTextEmote(player, textEmote, emoteNum, guid);
#endif
    FOREACH_SCRIPT(PlayerScript)->OnTextEmote(player, textEmote, emoteNum, guid);
}

void ScriptMgr::OnPlayerSpellCast(Player* player, Spell* spell, bool skipCheck)
{
#ifdef ELUNA
    sEluna->OnSpellCast(player, spell, skipCheck);
#endif
    FOREACH_SCRIPT(PlayerScript)->OnSpellCast(player, spell, skipCheck);
}

void ScriptMgr::OnBeforePlayerUpdate(Player* player, uint32 p_time)
{
    FOREACH_SCRIPT(PlayerScript)->OnBeforeUpdate(player, p_time);
}

void ScriptMgr::OnPlayerLogin(Player* player)
{
#ifdef ELUNA
    sEluna->OnLogin(player);
#endif
    FOREACH_SCRIPT(PlayerScript)->OnLogin(player);
}

void ScriptMgr::OnPlayerLoadFromDB(Player* player)
{
    FOREACH_SCRIPT(PlayerScript)->OnLoadFromDB(player);
}

void ScriptMgr::OnPlayerLogout(Player* player)
{
#ifdef ELUNA
    sEluna->OnLogout(player);
#endif
    FOREACH_SCRIPT(PlayerScript)->OnLogout(player);
}

void ScriptMgr::OnPlayerCreate(Player* player)
{
#ifdef ELUNA
    sEluna->OnCreate(player);
#endif
    FOREACH_SCRIPT(PlayerScript)->OnCreate(player);
}

void ScriptMgr::OnPlayerSave(Player * player)
{
#ifdef ELUNA
    sEluna->OnSave(player);
#endif
    FOREACH_SCRIPT(PlayerScript)->OnSave(player);
}

void ScriptMgr::OnPlayerDelete(uint64 guid, uint32 accountId)
{
#ifdef ELUNA
    sEluna->OnDelete(GUID_LOPART(guid));
#endif
    FOREACH_SCRIPT(PlayerScript)->OnDelete(guid, accountId);
}

void ScriptMgr::OnPlayerFailedDelete(uint64 guid, uint32 accountId)
{
    FOREACH_SCRIPT(PlayerScript)->OnFailedDelete(guid, accountId);
}

void ScriptMgr::OnPlayerBindToInstance(Player* player, Difficulty difficulty, uint32 mapid, bool permanent)
{
#ifdef ELUNA
    sEluna->OnBindToInstance(player, difficulty, mapid, permanent);
#endif
    FOREACH_SCRIPT(PlayerScript)->OnBindToInstance(player, difficulty, mapid, permanent);
}

void ScriptMgr::OnPlayerUpdateZone(Player* player, uint32 newZone, uint32 newArea)
{
#ifdef ELUNA
    sEluna->OnUpdateZone(player, newZone, newArea);
#endif
    FOREACH_SCRIPT(PlayerScript)->OnUpdateZone(player, newZone, newArea);
}

void ScriptMgr::OnPlayerUpdateArea(Player* player, uint32 oldArea, uint32 newArea)
{
    FOREACH_SCRIPT(PlayerScript)->OnUpdateArea(player, oldArea, newArea);
}

bool ScriptMgr::OnBeforePlayerTeleport(Player* player, uint32 mapid, float x, float y, float z, float orientation, uint32 options, Unit *target)
{
    bool ret=true;
    FOR_SCRIPTS_RET(PlayerScript, itr, end, ret) // return true by default if not scripts
        if (!itr->second->OnBeforeTeleport(player, mapid, x, y, z, orientation, options, target))
            ret=false; // we change ret value only when scripts return false

    return ret;
}

void ScriptMgr::OnPlayerUpdateFaction(Player* player)
{
    FOREACH_SCRIPT(PlayerScript)->OnUpdateFaction(player);
}

void ScriptMgr::OnPlayerAddToBattleground(Player* player, Battleground *bg)
{
    FOREACH_SCRIPT(PlayerScript)->OnAddToBattleground(player, bg);
}

void ScriptMgr::OnPlayerRemoveFromBattleground(Player* player, Battleground* bg)
{
    FOREACH_SCRIPT(PlayerScript)->OnRemoveFromBattleground(player, bg);
}

void ScriptMgr::OnAchievementComplete(Player* player, AchievementEntry const* achievement)
{
    FOREACH_SCRIPT(PlayerScript)->OnAchiComplete(player, achievement);
}

void ScriptMgr::OnCriteriaProgress(Player* player, AchievementCriteriaEntry const* criteria)
{
    FOREACH_SCRIPT(PlayerScript)->OnCriteriaProgress(player, criteria);
}

void ScriptMgr::OnAchievementSave(SQLTransaction& trans, Player* player, uint16 achiId, CompletedAchievementData achiData)
{
    FOREACH_SCRIPT(PlayerScript)->OnAchiSave(trans, player, achiId, achiData);
}

void ScriptMgr::OnCriteriaSave(SQLTransaction& trans, Player* player, uint16 critId, CriteriaProgress criteriaData)
{
    FOREACH_SCRIPT(PlayerScript)->OnCriteriaSave(trans, player, critId, criteriaData);
}

void ScriptMgr::OnPlayerBeingCharmed(Player* player, Unit* charmer, uint32 oldFactionId, uint32 newFactionId)
{
    FOREACH_SCRIPT(PlayerScript)->OnBeingCharmed(player, charmer, oldFactionId, newFactionId);
}

void ScriptMgr::OnAfterPlayerSetVisibleItemSlot(Player* player, uint8 slot, Item *item)
{
    FOREACH_SCRIPT(PlayerScript)->OnAfterSetVisibleItemSlot(player, slot,item);
}

void ScriptMgr::OnAfterPlayerMoveItemFromInventory(Player* player, Item* it, uint8 bag, uint8 slot, bool update)
{
    FOREACH_SCRIPT(PlayerScript)->OnAfterMoveItemFromInventory(player, it, bag, slot, update);
}

void ScriptMgr::OnEquip(Player* player, Item* it, uint8 bag, uint8 slot, bool update)
{
    FOREACH_SCRIPT(PlayerScript)->OnEquip(player, it, bag, slot, update);
}

void ScriptMgr::OnPlayerJoinBG(Player* player)
{
    FOREACH_SCRIPT(PlayerScript)->OnPlayerJoinBG(player);
}

void ScriptMgr::OnPlayerJoinArena(Player* player)
{
    FOREACH_SCRIPT(PlayerScript)->OnPlayerJoinArena(player);
}

void ScriptMgr::OnLootItem(Player* player, Item* item, uint32 count, uint64 lootguid)
{
    FOREACH_SCRIPT(PlayerScript)->OnLootItem(player, item, count, lootguid);
}

void ScriptMgr::OnCreateItem(Player* player, Item* item, uint32 count)
{
    FOREACH_SCRIPT(PlayerScript)->OnCreateItem(player, item, count);
}

void ScriptMgr::OnQuestRewardItem(Player* player, Item* item, uint32 count)
{
    FOREACH_SCRIPT(PlayerScript)->OnQuestRewardItem(player, item, count);
}

void ScriptMgr::OnFirstLogin(Player* player)
{
#ifdef ELUNA
    sEluna->OnFirstLogin(player);
#endif
    FOREACH_SCRIPT(PlayerScript)->OnFirstLogin(player);
}

// Account
void ScriptMgr::OnAccountLogin(uint32 accountId)
{
    FOREACH_SCRIPT(AccountScript)->OnAccountLogin(accountId);
}

void ScriptMgr::OnFailedAccountLogin(uint32 accountId)
{
    FOREACH_SCRIPT(AccountScript)->OnFailedAccountLogin(accountId);
}

void ScriptMgr::OnEmailChange(uint32 accountId)
{
    FOREACH_SCRIPT(AccountScript)->OnEmailChange(accountId);
}

void ScriptMgr::OnFailedEmailChange(uint32 accountId)
{
    FOREACH_SCRIPT(AccountScript)->OnFailedEmailChange(accountId);
}

void ScriptMgr::OnPasswordChange(uint32 accountId)
{
    FOREACH_SCRIPT(AccountScript)->OnPasswordChange(accountId);
}

void ScriptMgr::OnFailedPasswordChange(uint32 accountId)
{
    FOREACH_SCRIPT(AccountScript)->OnFailedPasswordChange(accountId);
}

// Guild
void ScriptMgr::OnGuildAddMember(Guild* guild, Player* player, uint8& plRank)
{
#ifdef ELUNA
    sEluna->OnAddMember(guild, player, plRank);
#endif
    FOREACH_SCRIPT(GuildScript)->OnAddMember(guild, player, plRank);
}

void ScriptMgr::OnGuildRemoveMember(Guild* guild, Player* player, bool isDisbanding, bool isKicked)
{
#ifdef ELUNA
    sEluna->OnRemoveMember(guild, player, isDisbanding);
#endif
    FOREACH_SCRIPT(GuildScript)->OnRemoveMember(guild, player, isDisbanding, isKicked);
}

void ScriptMgr::OnGuildMOTDChanged(Guild* guild, const std::string& newMotd)
{
#ifdef ELUNA
    sEluna->OnMOTDChanged(guild, newMotd);
#endif
    FOREACH_SCRIPT(GuildScript)->OnMOTDChanged(guild, newMotd);
}

void ScriptMgr::OnGuildInfoChanged(Guild* guild, const std::string& newInfo)
{
#ifdef ELUNA
    sEluna->OnInfoChanged(guild, newInfo);
#endif
    FOREACH_SCRIPT(GuildScript)->OnInfoChanged(guild, newInfo);
}

void ScriptMgr::OnGuildCreate(Guild* guild, Player* leader, const std::string& name)
{
#ifdef ELUNA
    sEluna->OnCreate(guild, leader, name);
#endif
    FOREACH_SCRIPT(GuildScript)->OnCreate(guild, leader, name);
}

void ScriptMgr::OnGuildDisband(Guild* guild)
{
#ifdef ELUNA
    sEluna->OnDisband(guild);
#endif
    FOREACH_SCRIPT(GuildScript)->OnDisband(guild);
}

void ScriptMgr::OnGuildMemberWitdrawMoney(Guild* guild, Player* player, uint32 &amount, bool isRepair)
{
#ifdef ELUNA
    sEluna->OnMemberWitdrawMoney(guild, player, amount, isRepair);
#endif
    FOREACH_SCRIPT(GuildScript)->OnMemberWitdrawMoney(guild, player, amount, isRepair);
}

void ScriptMgr::OnGuildMemberDepositMoney(Guild* guild, Player* player, uint32 &amount)
{
#ifdef ELUNA
    sEluna->OnMemberDepositMoney(guild, player, amount);
#endif
    FOREACH_SCRIPT(GuildScript)->OnMemberDepositMoney(guild, player, amount);
}

void ScriptMgr::OnGuildItemMove(Guild* guild, Player* player, Item* pItem, bool isSrcBank, uint8 srcContainer, uint8 srcSlotId,
            bool isDestBank, uint8 destContainer, uint8 destSlotId)
{
#ifdef ELUNA
    sEluna->OnItemMove(guild, player, pItem, isSrcBank, srcContainer, srcSlotId, isDestBank, destContainer, destSlotId);
#endif
    FOREACH_SCRIPT(GuildScript)->OnItemMove(guild, player, pItem, isSrcBank, srcContainer, srcSlotId, isDestBank, destContainer, destSlotId);
}

void ScriptMgr::OnGuildEvent(Guild* guild, uint8 eventType, uint32 playerGuid1, uint32 playerGuid2, uint8 newRank)
{
#ifdef ELUNA
    sEluna->OnEvent(guild, eventType, playerGuid1, playerGuid2, newRank);
#endif
    FOREACH_SCRIPT(GuildScript)->OnEvent(guild, eventType, playerGuid1, playerGuid2, newRank);
}

void ScriptMgr::OnGuildBankEvent(Guild* guild, uint8 eventType, uint8 tabId, uint32 playerGuid, uint32 itemOrMoney, uint16 itemStackCount, uint8 destTabId)
{
#ifdef ELUNA
    sEluna->OnBankEvent(guild, eventType, tabId, playerGuid, itemOrMoney, itemStackCount, destTabId);
#endif
    FOREACH_SCRIPT(GuildScript)->OnBankEvent(guild, eventType, tabId, playerGuid, itemOrMoney, itemStackCount, destTabId);
}

// Group
void ScriptMgr::OnGroupAddMember(Group* group, uint64 guid)
{
    ASSERT(group);
#ifdef ELUNA
        sEluna->OnAddMember(group, guid);
#endif
    FOREACH_SCRIPT(GroupScript)->OnAddMember(group, guid);
}

void ScriptMgr::OnGroupInviteMember(Group* group, uint64 guid)
{
    ASSERT(group);
#ifdef ELUNA
    sEluna->OnInviteMember(group, guid);
#endif
    FOREACH_SCRIPT(GroupScript)->OnInviteMember(group, guid);
}

void ScriptMgr::OnGroupRemoveMember(Group* group, uint64 guid, RemoveMethod method, uint64 kicker, const char* reason)
{
    ASSERT(group);
#ifdef ELUNA
    sEluna->OnRemoveMember(group, guid, method);
#endif
    FOREACH_SCRIPT(GroupScript)->OnRemoveMember(group, guid, method, kicker, reason);
}

void ScriptMgr::OnGroupChangeLeader(Group* group, uint64 newLeaderGuid, uint64 oldLeaderGuid)
{
    ASSERT(group);
#ifdef ELUNA
    sEluna->OnChangeLeader(group, newLeaderGuid, oldLeaderGuid);
#endif
    FOREACH_SCRIPT(GroupScript)->OnChangeLeader(group, newLeaderGuid, oldLeaderGuid);
}

void ScriptMgr::OnGroupDisband(Group* group)
{
    ASSERT(group);
#ifdef ELUNA
    sEluna->OnDisband(group);
#endif
    FOREACH_SCRIPT(GroupScript)->OnDisband(group);
}

void ScriptMgr::OnGlobalItemDelFromDB(SQLTransaction& trans, uint32 itemGuid)
{
    ASSERT(trans);
    ASSERT(itemGuid);

    FOREACH_SCRIPT(GlobalScript)->OnItemDelFromDB(trans,itemGuid);
}

void ScriptMgr::OnGlobalMirrorImageDisplayItem(const Item *item, uint32 &display)
{
    FOREACH_SCRIPT(GlobalScript)->OnMirrorImageDisplayItem(item,display);
}

void ScriptMgr::OnBeforeUpdateArenaPoints(ArenaTeam* at, std::map<uint32, uint32> &ap)
{
    FOREACH_SCRIPT(GlobalScript)->OnBeforeUpdateArenaPoints(at,ap);
}

void ScriptMgr::OnAfterRefCount(Player const* player, Loot& loot, bool canRate, uint16 lootMode, LootStoreItem* LootStoreItem, uint32 &maxcount, LootStore const& store)
{
    FOREACH_SCRIPT(GlobalScript)->OnAfterRefCount(player, LootStoreItem, loot, canRate, lootMode, maxcount, store);
}

void ScriptMgr::OnBeforeDropAddItem(Player const* player, Loot& loot, bool canRate, uint16 lootMode, LootStoreItem* LootStoreItem, LootStore const& store)
{
    FOREACH_SCRIPT(GlobalScript)->OnBeforeDropAddItem(player, loot, canRate, lootMode, LootStoreItem, store);
}

void ScriptMgr::OnItemRoll(Player const* player, LootStoreItem const* LootStoreItem, float &chance, Loot& loot, LootStore const& store) {
    FOREACH_SCRIPT(GlobalScript)->OnItemRoll(player, LootStoreItem,  chance, loot, store);
}

void ScriptMgr::OnInitializeLockedDungeons(Player* player, uint8& level, uint32& lockData)
{
    FOREACH_SCRIPT(GlobalScript)->OnInitializeLockedDungeons(player, level, lockData);
}

void ScriptMgr::OnAfterInitializeLockedDungeons(Player* player)
{
    FOREACH_SCRIPT(GlobalScript)->OnAfterInitializeLockedDungeons(player);
}

void ScriptMgr::OnAfterUpdateEncounterState(Map* map, EncounterCreditType type, uint32 creditEntry, Unit* source, Difficulty difficulty_fixed, DungeonEncounterList const* encounters, uint32 dungeonCompleted, bool updated) 
{
    FOREACH_SCRIPT(GlobalScript)->OnAfterUpdateEncounterState(map, type, creditEntry, source, difficulty_fixed, encounters, dungeonCompleted, updated);
}

uint32 ScriptMgr::DealDamage(Unit* AttackerUnit, Unit *pVictim, uint32 damage, DamageEffectType damagetype)
{
    FOR_SCRIPTS_RET(UnitScript, itr, end, damage)
        damage = itr->second->DealDamage(AttackerUnit, pVictim, damage, damagetype);
    return damage;
}
void ScriptMgr::Creature_SelectLevel(const CreatureTemplate *cinfo, Creature* creature)
{
    FOREACH_SCRIPT(AllCreatureScript)->Creature_SelectLevel(cinfo, creature);
}
void ScriptMgr::OnHeal(Unit* healer, Unit* reciever, uint32& gain)
{
    FOREACH_SCRIPT(UnitScript)->OnHeal(healer, reciever, gain);
}

void ScriptMgr::OnDamage(Unit* attacker, Unit* victim, uint32& damage)
{
    FOREACH_SCRIPT(UnitScript)->OnDamage(attacker, victim, damage);
}

void ScriptMgr::ModifyPeriodicDamageAurasTick(Unit* target, Unit* attacker, uint32& damage)
{
    FOREACH_SCRIPT(UnitScript)->ModifyPeriodicDamageAurasTick(target, attacker, damage);
}

void ScriptMgr::ModifyMeleeDamage(Unit* target, Unit* attacker, uint32& damage)
{
    FOREACH_SCRIPT(UnitScript)->ModifyMeleeDamage(target, attacker, damage);
}

void ScriptMgr::ModifySpellDamageTaken(Unit* target, Unit* attacker, int32& damage)
{
    FOREACH_SCRIPT(UnitScript)->ModifySpellDamageTaken(target, attacker, damage);
}

void ScriptMgr::ModifyHealRecieved(Unit* target, Unit* attacker, uint32& damage)
{
    FOREACH_SCRIPT(UnitScript)->ModifyHealRecieved(target, attacker, damage);
}

void ScriptMgr::OnBeforeRollMeleeOutcomeAgainst(const Unit* attacker, const Unit* victim, WeaponAttackType attType, int32 &attackerMaxSkillValueForLevel, int32 &victimMaxSkillValueForLevel, int32 &attackerWeaponSkill, int32 &victimDefenseSkill, int32 &crit_chance, int32 &miss_chance, int32 &dodge_chance, int32 &parry_chance, int32 &block_chance)
{
    FOREACH_SCRIPT(UnitScript)->OnBeforeRollMeleeOutcomeAgainst(attacker, victim, attType, attackerMaxSkillValueForLevel, victimMaxSkillValueForLevel, attackerWeaponSkill, victimDefenseSkill, crit_chance, miss_chance, dodge_chance, parry_chance, block_chance);
}

void ScriptMgr::OnPlayerMove(Player* player, MovementInfo movementInfo, uint32 opcode)
{
    FOREACH_SCRIPT(MovementHandlerScript)->OnPlayerMove(player, movementInfo, opcode);
}

void ScriptMgr::OnBeforeBuyItemFromVendor(Player* player, uint64 vendorguid, uint32 vendorslot, uint32 &item, uint8 count, uint8 bag, uint8 slot)
{
    FOREACH_SCRIPT(PlayerScript)->OnBeforeBuyItemFromVendor(player, vendorguid, vendorslot, item, count, bag, slot);
}

void ScriptMgr::OnAfterStoreOrEquipNewItem(Player* player, uint32 vendorslot, uint32 &item, uint8 count, uint8 bag, uint8 slot, ItemTemplate const* pProto, Creature* pVendor, VendorItem const* crItem, bool bStore) 
{
    FOREACH_SCRIPT(PlayerScript)->OnAfterStoreOrEquipNewItem(player, vendorslot, item, count, bag, slot, pProto, pVendor, crItem, bStore);
}


void ScriptMgr::OnAfterUpdateMaxPower(Player* player, Powers& power, float& value)
{
    FOREACH_SCRIPT(PlayerScript)->OnAfterUpdateMaxPower(player, power, value);
}

void ScriptMgr::OnAfterUpdateMaxHealth(Player* player, float& value)
{
    FOREACH_SCRIPT(PlayerScript)->OnAfterUpdateMaxHealth(player, value);
}

void ScriptMgr::OnBeforeUpdateAttackPowerAndDamage(Player* player, float& level, float& val2, bool ranged)
{
    FOREACH_SCRIPT(PlayerScript)->OnBeforeUpdateAttackPowerAndDamage(player, level, val2, ranged);
}

void ScriptMgr::OnAfterUpdateAttackPowerAndDamage(Player* player, float& level, float& base_attPower, float& attPowerMod, float& attPowerMultiplier, bool ranged)
{
    FOREACH_SCRIPT(PlayerScript)->OnAfterUpdateAttackPowerAndDamage(player, level, base_attPower, attPowerMod, attPowerMultiplier, ranged);
}

void ScriptMgr::OnBeforeInitTalentForLevel(Player* player, uint8& level, uint32& talentPointsForLevel)
{
    FOREACH_SCRIPT(PlayerScript)->OnBeforeInitTalentForLevel(player, level, talentPointsForLevel);
}

void ScriptMgr::OnAfterArenaRatingCalculation(Battleground *const bg, int32 &winnerMatchmakerChange, int32 &loserMatchmakerChange, int32 &winnerChange, int32 &loserChange)
{
    FOREACH_SCRIPT(FormulaScript)->OnAfterArenaRatingCalculation(bg, winnerMatchmakerChange, loserMatchmakerChange, winnerChange, loserChange);
}

// BGScript
void ScriptMgr::OnBattlegroundStart(Battleground* bg)
{
    FOREACH_SCRIPT(BGScript)->OnBattlegroundStart(bg);
}

void ScriptMgr::OnBattlegroundEndReward(Battleground* bg, Player* player, TeamId winnerTeamId)
{
    FOREACH_SCRIPT(BGScript)->OnBattlegroundEndReward(bg, player, winnerTeamId);
}

void ScriptMgr::OnBattlegroundUpdate(Battleground* bg, uint32 diff)
{
    FOREACH_SCRIPT(BGScript)->OnBattlegroundUpdate(bg, diff);
}

void ScriptMgr::OnBattlegroundAddPlayer(Battleground* bg, Player* player)
{
    FOREACH_SCRIPT(BGScript)->OnBattlegroundAddPlayer(bg, player);
}

// SpellSC
void ScriptMgr::OnCalcMaxDuration(Aura const* aura, int32& maxDuration)
{
    FOREACH_SCRIPT(SpellSC)->OnCalcMaxDuration(aura, maxDuration);
}

void ScriptMgr::OnGameEventStart(uint16 EventID)
{
#ifdef ELUNA
    sEluna->OnGameEventStart(EventID);
#endif
    FOREACH_SCRIPT(GameEventScript)->OnStart(EventID);
}

void ScriptMgr::OnGameEventStop(uint16 EventID)
{
#ifdef ELUNA
    sEluna->OnGameEventStop(EventID);
#endif
    FOREACH_SCRIPT(GameEventScript)->OnStop(EventID);
}

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


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

#include "SmartScriptMgr.h"
#include "CellImpl.h"
#include "CreatureTextMgr.h"
#include "DatabaseEnv.h"
#include "GameEventMgr.h"
#include "GridDefines.h"
#include "InstanceScript.h"
#include "ObjectDefines.h"
#include "ObjectMgr.h"
#include "ScriptedCreature.h"
#include "SpellMgr.h"

bool SmartAIMgr::IsSAIBoolValid(SmartScriptHolder const& e, SAIBool value)
{
    if (value != 0 && value != 1)
    {
        LOG_ERROR("sql.sql", "SmartAIMgr: Entry {} SourceType {} Event {} Action {} uses param {} of type Boolean with value {}, valid values are 0 or 1, skipped.",
            e.entryOrGuid, e.GetScriptType(), e.event_id, e.GetActionType(), STRINGIZE(value), value);
        return false;
    }
    return true;
}

SmartWaypointMgr* SmartWaypointMgr::instance()
{
    static SmartWaypointMgr instance;
    return &instance;
}

void SmartWaypointMgr::LoadFromDB()
{
    uint32 oldMSTime = getMSTime();

    for (auto itr : waypoint_map)
    {
        delete itr.second;
    }

    waypoint_map.clear();

    WorldDatabasePreparedStatement* stmt = WorldDatabase.GetPreparedStatement(WORLD_SEL_SMARTAI_WP);
    PreparedQueryResult result = WorldDatabase.Query(stmt);

    if (!result)
    {
        LOG_WARN("server.loading", ">> Loaded 0 SmartAI Waypoint Paths. DB table `waypoints` is empty.");
        LOG_INFO("server.loading", " ");
        return;
    }

    uint32 count = 0;
    uint32 total = 0;
    uint32 last_entry = 0;
    uint32 last_id = 1;

    do
    {
        Field* fields = result->Fetch();
        uint32 entry = fields[0].Get<uint32>();
        uint32 id = fields[1].Get<uint32>();
        float x = fields[2].Get<float>();
        float y = fields[3].Get<float>();
        float z = fields[4].Get<float>();
        Optional<float> o;
        if (!fields[5].IsNull())
            o = fields[5].Get<float>();
        uint32 delay = fields[6].Get<uint32>();

        if (last_entry != entry)
        {
            waypoint_map[entry] = new WaypointPath();
            last_id = 1;
            count++;
        }

        if (last_id != id)
            LOG_ERROR("sql.sql", "SmartWaypointMgr::LoadFromDB: Path entry {}, unexpected point id {}, expected {}.", entry, id, last_id);

        last_id++;
        WaypointData data;
        data.id = id;
        data.x = x;
        data.y = y;
        data.z = z;
        data.orientation = o;
        data.delay = delay;
        data.move_type = WAYPOINT_MOVE_TYPE_MAX;
        (*waypoint_map[entry]).emplace(id, data);

        last_entry = entry;
        total++;
    } while (result->NextRow());

    LOG_INFO("server.loading", ">> Loaded {} SmartAI waypoint paths (total {} waypoints) in {} ms", count, total, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
}

SmartWaypointMgr::~SmartWaypointMgr()
{
    for (auto itr : waypoint_map)
    {
        delete itr.second;
    }
}

SmartAIMgr* SmartAIMgr::instance()
{
    static SmartAIMgr instance;
    return &instance;
}

void SmartAIMgr::LoadSmartAIFromDB()
{
    uint32 oldMSTime = getMSTime();

    for (uint8 i = 0; i < SMART_SCRIPT_TYPE_MAX; i++)
        mEventMap[i].clear();  //Drop Existing SmartAI List

    WorldDatabasePreparedStatement* stmt = WorldDatabase.GetPreparedStatement(WORLD_SEL_SMART_SCRIPTS);
    PreparedQueryResult result = WorldDatabase.Query(stmt);

    if (!result)
    {
        LOG_WARN("server.loading", ">> Loaded 0 SmartAI scripts. DB table `smart_scripts` is empty.");
        LOG_INFO("server.loading", " ");
        return;
    }

    uint32 count = 0;

    do
    {
        Field* fields = result->Fetch();

        SmartScriptHolder temp;

        temp.entryOrGuid = fields[0].Get<int32>();
        if (!temp.entryOrGuid)
        {
            LOG_ERROR("sql.sql", "SmartAIMgr::LoadSmartAIFromDB: invalid entryorguid (0), skipped loading.");
            continue;
        }

        SmartScriptType source_type = (SmartScriptType)fields[1].Get<uint8>();
        if (source_type >= SMART_SCRIPT_TYPE_MAX)
        {
            LOG_ERROR("sql.sql", "SmartAIMgr::LoadSmartAIFromDB: invalid source_type ({}), skipped loading.", uint32(source_type));
            continue;
        }
        if (temp.entryOrGuid >= 0)
        {
            switch (source_type)
            {
                case SMART_SCRIPT_TYPE_CREATURE:
                    {
                        if (!sObjectMgr->GetCreatureTemplate((uint32)temp.entryOrGuid))
                        {
                            LOG_ERROR("sql.sql", "SmartAIMgr::LoadSmartAIFromDB: Creature entry ({}) does not exist, skipped loading.", uint32(temp.entryOrGuid));
                            continue;
                        }
                        break;
                    }
                case SMART_SCRIPT_TYPE_GAMEOBJECT:
                    {
                        if (!sObjectMgr->GetGameObjectTemplate((uint32)temp.entryOrGuid))
                        {
                            LOG_ERROR("sql.sql", "SmartAIMgr::LoadSmartAIFromDB: GameObject entry ({}) does not exist, skipped loading.", uint32(temp.entryOrGuid));
                            continue;
                        }
                        break;
                    }
                case SMART_SCRIPT_TYPE_AREATRIGGER:
                    {
                        if (!sObjectMgr->GetAreaTrigger((uint32)temp.entryOrGuid))
                        {
                            LOG_ERROR("sql.sql", "SmartAIMgr::LoadSmartAIFromDB: AreaTrigger entry ({}) does not exist, skipped loading.", uint32(temp.entryOrGuid));
                            continue;
                        }
                        break;
                    }
                case SMART_SCRIPT_TYPE_TIMED_ACTIONLIST:
                    break;//nothing to check, really
                default:
                    LOG_ERROR("sql.sql", "SmartAIMgr::LoadSmartAIFromDB: not yet implemented source_type {}", (uint32)source_type);
                    continue;
            }
        }
        else
        {
            switch (source_type)
            {
                case SMART_SCRIPT_TYPE_CREATURE:
                    {
                        if (!sObjectMgr->GetCreatureData(uint32(std::abs(temp.entryOrGuid))))
                        {
                            LOG_ERROR("sql.sql", "SmartAIMgr::LoadSmartAIFromDB: Creature guid ({}) does not exist, skipped loading.", uint32(std::abs(temp.entryOrGuid)));
                            continue;
                        }
                        break;
                    }
                case SMART_SCRIPT_TYPE_GAMEOBJECT:
                    {
                        if (!sObjectMgr->GetGameObjectData(uint32(std::abs(temp.entryOrGuid))))
                        {
                            LOG_ERROR("sql.sql", "SmartAIMgr::LoadSmartAIFromDB: GameObject guid ({}) does not exist, skipped loading.", uint32(temp.entryOrGuid));
                            continue;
                        }
                        break;
                    }
                default:
                    LOG_ERROR("sql.sql", "SmartAIMgr::LoadSmartAIFromDB: not yet implemented source_type {}", (uint32)source_type);
                    continue;
            }
        }

        temp.source_type = source_type;
        temp.event_id = fields[2].Get<uint16>();
        temp.link = fields[3].Get<uint16>();
        temp.event.type = (SMART_EVENT)fields[4].Get<uint8>();
        temp.event.event_phase_mask = fields[5].Get<uint16>();
        temp.event.event_chance = fields[6].Get<uint8>();
        temp.event.event_flags = fields[7].Get<uint16>();

        temp.event.raw.param1 = fields[8].Get<uint32>();
        temp.event.raw.param2 = fields[9].Get<uint32>();
        temp.event.raw.param3 = fields[10].Get<uint32>();
        temp.event.raw.param4 = fields[11].Get<uint32>();
        temp.event.raw.param5 = fields[12].Get<uint32>();
        temp.event.raw.param6 = fields[13].Get<uint32>();

        temp.action.type = (SMART_ACTION)fields[14].Get<uint8>();
        temp.action.raw.param1 = fields[15].Get<uint32>();
        temp.action.raw.param2 = fields[16].Get<uint32>();
        temp.action.raw.param3 = fields[17].Get<uint32>();
        temp.action.raw.param4 = fields[18].Get<uint32>();
        temp.action.raw.param5 = fields[19].Get<uint32>();
        temp.action.raw.param6 = fields[20].Get<uint32>();

        temp.target.type = (SMARTAI_TARGETS)fields[21].Get<uint8>();
        temp.target.raw.param1 = fields[22].Get<uint32>();
        temp.target.raw.param2 = fields[23].Get<uint32>();
        temp.target.raw.param3 = fields[24].Get<uint32>();
        temp.target.raw.param4 = fields[25].Get<uint32>();
        temp.target.x = fields[26].Get<float>();
        temp.target.y = fields[27].Get<float>();
        temp.target.z = fields[28].Get<float>();
        temp.target.o = fields[29].Get<float>();

        //check target
        if (!IsTargetValid(temp))
            continue;

        // check all event and action params
        if (!IsEventValid(temp))
            continue;

        // xinef: specific check for timed events, fix db makers
        switch (temp.event.type)
        {
            case SMART_EVENT_UPDATE:
            case SMART_EVENT_UPDATE_OOC:
            case SMART_EVENT_UPDATE_IC:
            case SMART_EVENT_HEALTH_PCT:
            case SMART_EVENT_TARGET_HEALTH_PCT:
            case SMART_EVENT_MANA_PCT:
            case SMART_EVENT_TARGET_MANA_PCT:
            case SMART_EVENT_FRIENDLY_HEALTH:
            case SMART_EVENT_FRIENDLY_HEALTH_PCT:
            case SMART_EVENT_FRIENDLY_MISSING_BUFF:
            case SMART_EVENT_HAS_AURA:
            case SMART_EVENT_TARGET_BUFFED:
            case SMART_EVENT_RANGE:
            case SMART_EVENT_AREA_RANGE:
            case SMART_EVENT_AREA_CASTING:
            case SMART_EVENT_IS_BEHIND_TARGET:
            case SMART_EVENT_IS_IN_MELEE_RANGE:
                if (temp.event.minMaxRepeat.repeatMin == 0 && temp.event.minMaxRepeat.repeatMax == 0)
                    temp.event.event_flags |= SMART_EVENT_FLAG_NOT_REPEATABLE;
                break;
            case SMART_EVENT_VICTIM_CASTING:
            case SMART_EVENT_FRIENDLY_IS_CC:
                if (temp.event.friendlyCC.repeatMin == 0 && temp.event.friendlyCC.repeatMax == 0)
                    temp.event.event_flags |= SMART_EVENT_FLAG_NOT_REPEATABLE;
                break;
            default:
                break;
        }

        if (temp.action.type == SMART_ACTION_MOVE_TO_POS)
            if (temp.target.type == SMART_TARGET_SELF && (std::fabs(temp.target.x) > 200.0f || std::fabs(temp.target.y) > 200.0f || std::fabs(temp.target.z) > 200.0f))
                temp.target.type = SMART_TARGET_POSITION;

        // creature entry / guid not found in storage, create empty event list for it and increase counters
        if (mEventMap[source_type].find(temp.entryOrGuid) == mEventMap[source_type].end())
        {
            ++count;
            SmartAIEventList eventList;
            mEventMap[source_type][temp.entryOrGuid] = eventList;
        }
        // store the new event
        mEventMap[source_type][temp.entryOrGuid].push_back(temp);
    } while (result->NextRow());

    CheckIfSmartAIInDatabaseExists();

    LOG_INFO("server.loading", ">> Loaded {} SmartAI scripts in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
}

void SmartAIMgr::CheckIfSmartAIInDatabaseExists()
{
    // SMART_SCRIPT_TYPE_CREATURE
    for (auto const& [entry, creatureTemplate] : *sObjectMgr->GetCreatureTemplates())
    {
        if (creatureTemplate.AIName != "SmartAI")
            continue;

        bool found = false;

        // check template SAI
        if (mEventMap[uint32(SmartScriptType::SMART_SCRIPT_TYPE_CREATURE)].find(creatureTemplate.Entry) != mEventMap[uint32(SmartScriptType::SMART_SCRIPT_TYPE_CREATURE)].end())
            found = true;
        else
        {
            // check GUID SAI
            for (auto const& pair : sObjectMgr->GetAllCreatureData())
            {
                if (pair.second.id1 != creatureTemplate.Entry)
                    continue;

                if (mEventMap[uint32(SmartScriptType::SMART_SCRIPT_TYPE_CREATURE)].find((-1) * pair.first) != mEventMap[uint32(SmartScriptType::SMART_SCRIPT_TYPE_CREATURE)].end())
                {
                    found = true;
                    break;
                }
            }
        }

        if (!found)
            LOG_ERROR("sql.sql", "Creature entry ({}) has SmartAI enabled but no SmartAI entries in the database.", creatureTemplate.Entry);
    }

    // SMART_SCRIPT_TYPE_GAMEOBJECT
    for (auto const& [entry, gameobjectTemplate] : *sObjectMgr->GetGameObjectTemplates())
    {
        if (gameobjectTemplate.AIName != "SmartGameObjectAI")
            continue;

        bool found = false;

        // check template SAI
        if (mEventMap[uint32(SmartScriptType::SMART_SCRIPT_TYPE_GAMEOBJECT)].find(gameobjectTemplate.entry) != mEventMap[uint32(SmartScriptType::SMART_SCRIPT_TYPE_GAMEOBJECT)].end())
            found = true;
        else
        {
            // check GUID SAI
            for (auto const& pair : sObjectMgr->GetAllGOData())
            {
                if (pair.second.id != gameobjectTemplate.entry)
                    continue;

                if (mEventMap[uint32(SmartScriptType::SMART_SCRIPT_TYPE_GAMEOBJECT)].find((-1) * pair.first) != mEventMap[uint32(SmartScriptType::SMART_SCRIPT_TYPE_GAMEOBJECT)].end())
                {
                    found = true;
                    break;
                }
            }
        }

        if (!found)
            LOG_ERROR("sql.sql", "Gameobject entry ({}) has SmartGameobjectAI enabled but no SmartAI entries in the database.", gameobjectTemplate.entry);
    }

    // SMART_SCRIPT_TYPE_AREATRIGGER
    uint32 scriptID = sObjectMgr->GetScriptId("SmartTrigger");

    for (auto const& pair : sObjectMgr->GetAllAreaTriggerScriptData())
    {
        if (pair.second != scriptID)
            continue;

        if (mEventMap[uint32(SmartScriptType::SMART_SCRIPT_TYPE_AREATRIGGER)].find(pair.first) == mEventMap[uint32(SmartScriptType::SMART_SCRIPT_TYPE_AREATRIGGER)].end())
            LOG_ERROR("sql.sql", "AreaTrigger entry ({}) has SmartTrigger enabled but no SmartAI entries in the database.", pair.first);
    }
}

/*static*/ bool SmartAIMgr::EventHasInvoker(SMART_EVENT event)
{
    switch (event)
    { // white list of events that actually have an invoker passed to them
        case SMART_EVENT_AGGRO:
        case SMART_EVENT_DEATH:
        case SMART_EVENT_KILL:
        case SMART_EVENT_SUMMONED_UNIT:
        case SMART_EVENT_SUMMONED_UNIT_DIES:
        case SMART_EVENT_SPELLHIT:
        case SMART_EVENT_SPELLHIT_TARGET:
        case SMART_EVENT_DAMAGED:
        case SMART_EVENT_RECEIVE_HEAL:
        case SMART_EVENT_RECEIVE_EMOTE:
        case SMART_EVENT_JUST_SUMMONED:
        case SMART_EVENT_DAMAGED_TARGET:
        case SMART_EVENT_SUMMON_DESPAWNED:
        case SMART_EVENT_PASSENGER_BOARDED:
        case SMART_EVENT_PASSENGER_REMOVED:
        case SMART_EVENT_GOSSIP_HELLO:
        case SMART_EVENT_GOSSIP_SELECT:
        case SMART_EVENT_ACCEPTED_QUEST:
        case SMART_EVENT_REWARD_QUEST:
        case SMART_EVENT_FOLLOW_COMPLETED:
        case SMART_EVENT_ON_SPELLCLICK:
        case SMART_EVENT_GO_STATE_CHANGED:
        case SMART_EVENT_AREATRIGGER_ONTRIGGER:
        case SMART_EVENT_IC_LOS:
        case SMART_EVENT_OOC_LOS:
        case SMART_EVENT_DISTANCE_CREATURE:
        case SMART_EVENT_FRIENDLY_HEALTH:
        case SMART_EVENT_FRIENDLY_HEALTH_PCT:
        case SMART_EVENT_FRIENDLY_IS_CC:
        case SMART_EVENT_FRIENDLY_MISSING_BUFF:
        case SMART_EVENT_ACTION_DONE:
        case SMART_EVENT_TARGET_HEALTH_PCT:
        case SMART_EVENT_TARGET_MANA_PCT:
        case SMART_EVENT_RANGE:
        case SMART_EVENT_AREA_RANGE:
        case SMART_EVENT_VICTIM_CASTING:
        case SMART_EVENT_AREA_CASTING:
        case SMART_EVENT_TARGET_BUFFED:
        case SMART_EVENT_IS_BEHIND_TARGET:
        case SMART_EVENT_INSTANCE_PLAYER_ENTER:
        case SMART_EVENT_TRANSPORT_ADDCREATURE:
        case SMART_EVENT_NEAR_PLAYERS:
        case SMART_EVENT_SUMMONED_UNIT_EVADE:
        case SMART_EVENT_DATA_SET:
        case SMART_EVENT_IS_IN_MELEE_RANGE:
            return true;
        default:
            return false;
    }
}

bool SmartAIMgr::IsTargetValid(SmartScriptHolder const& e)
{
    if (e.GetActionType() == SMART_ACTION_INSTALL_AI_TEMPLATE)
        return true; // AI template has special handling
    switch (e.GetTargetType())
    {
        case SMART_TARGET_CREATURE_DISTANCE:
        case SMART_TARGET_CREATURE_RANGE:
            {
                if (e.target.unitDistance.creature && !sObjectMgr->GetCreatureTemplate(e.target.unitDistance.creature))
                {
                    LOG_ERROR("sql.sql", "SmartAIMgr: Entry {} SourceType {} Event {} Action {} uses non-existent Creature entry {} as target_param1, skipped.", e.entryOrGuid, e.GetScriptType(), e.event_id, e.GetActionType(), e.target.unitDistance.creature);
                    return false;
                }
                break;
            }
        case SMART_TARGET_GAMEOBJECT_DISTANCE:
        case SMART_TARGET_GAMEOBJECT_RANGE:
            {
                if (e.target.goDistance.entry && !sObjectMgr->GetGameObjectTemplate(e.target.goDistance.entry))
                {
                    LOG_ERROR("sql.sql", "SmartAIMgr: Entry {} SourceType {} Event {} Action {} uses non-existent GameObject entry {} as target_param1, skipped.", e.entryOrGuid, e.GetScriptType(), e.event_id, e.GetActionType(), e.target.goDistance.entry);
                    return false;
                }
                break;
            }
        case SMART_TARGET_CREATURE_GUID:
            {
                if (e.target.unitGUID.entry && !IsCreatureValid(e, e.target.unitGUID.entry))
                    return false;
                break;
            }
        case SMART_TARGET_GAMEOBJECT_GUID:
            {
                if (e.target.goGUID.entry && !IsGameObjectValid(e, e.target.goGUID.entry))
                    return false;
                break;
            }
        case SMART_TARGET_PLAYER_DISTANCE:
        case SMART_TARGET_CLOSEST_PLAYER:
            {
                if (e.target.playerDistance.dist == 0)
                {
                    LOG_ERROR("sql.sql", "SmartAIMgr: Entry {} SourceType {} Event {} Action {} has maxDist 0 as target_param1, skipped.", e.entryOrGuid, e.GetScriptType(), e.event_id, e.GetActionType());
                    return false;
                }
                break;
            }
        case SMART_TARGET_ACTION_INVOKER:
        case SMART_TARGET_ACTION_INVOKER_VEHICLE:
        case SMART_TARGET_INVOKER_PARTY:
            if (e.GetScriptType() != SMART_SCRIPT_TYPE_TIMED_ACTIONLIST && e.GetEventType() != SMART_EVENT_LINK && !EventHasInvoker(e.event.type))
            {
                LOG_ERROR("sql.sql", "SmartAIMgr: Entry {} SourceType {} Event {} Action {} has invoker target, but event does not provide any invoker!", e.entryOrGuid, e.GetScriptType(), e.GetEventType(), e.GetActionType());
                 return false;
            }
            break;
        case SMART_TARGET_SUMMONED_CREATURES:
        {
            if (e.target.summonedCreatures.entry && !IsCreatureValid(e, e.target.summonedCreatures.entry))
            {
                return false;
            }
            break;
        }
        case SMART_TARGET_INSTANCE_STORAGE:
        {
            if (e.target.instanceStorage.type != 1 && e.target.instanceStorage.type != 2)
            {
                LOG_ERROR("sql.sql", "SmartAIMgr: Entry {} SourceType {} Event {} Action {} has invalid instance storage type as target ({}).",
                    e.entryOrGuid, e.GetScriptType(), e.GetEventType(), e.GetActionType(), e.target.instanceStorage.type);
                return false;
            }
            break;
        }
        case SMART_TARGET_HOSTILE_SECOND_AGGRO:
        case SMART_TARGET_HOSTILE_LAST_AGGRO:
        case SMART_TARGET_HOSTILE_RANDOM:
        case SMART_TARGET_HOSTILE_RANDOM_NOT_TOP:
            return IsSAIBoolValid(e, e.target.hostileRandom.playerOnly);
        case SMART_TARGET_FARTHEST:
            return IsSAIBoolValid(e, e.target.farthest.playerOnly) &&
                   IsSAIBoolValid(e, e.target.farthest.isInLos);
            break;
        case SMART_TARGET_CLOSEST_CREATURE:
            return IsSAIBoolValid(e, e.target.unitClosest.dead);
            break;
        case SMART_TARGET_CLOSEST_ENEMY:
            return IsSAIBoolValid(e, e.target.closestAttackable.playerOnly);
            break;
        case SMART_TARGET_CLOSEST_FRIENDLY:
            return IsSAIBoolValid(e, e.target.closestFriendly.playerOnly);
            break;
        case SMART_TARGET_OWNER_OR_SUMMONER:
            return IsSAIBoolValid(e, e.target.owner.useCharmerOrOwner);
            break;
        case SMART_TARGET_STORED:
        case SMART_TARGET_PLAYER_WITH_AURA:
        case SMART_TARGET_RANDOM_POINT:
        case SMART_TARGET_ROLE_SELECTION:
        case SMART_TARGET_LOOT_RECIPIENTS:
        case SMART_TARGET_VEHICLE_PASSENGER:
        case SMART_EVENT_SUMMONED_UNIT_DIES:
        case SMART_EVENT_SUMMONED_UNIT_EVADE:
        case SMART_TARGET_PLAYER_RANGE:
        case SMART_TARGET_CLOSEST_GAMEOBJECT:
        case SMART_TARGET_SELF:
        case SMART_TARGET_VICTIM:
        case SMART_TARGET_POSITION:
        case SMART_TARGET_NONE:
        case SMART_TARGET_THREAT_LIST:
            break;
        default:
            LOG_ERROR("sql.sql", "SmartAIMgr: Not handled target_type({}), Entry {} SourceType {} Event {} Action {}, skipped.", e.GetTargetType(), e.entryOrGuid, e.GetScriptType(), e.event_id, e.GetActionType());
            return false;
    }

    if (!CheckUnusedTargetParams(e))
    {
        return false;
    }

    return true;
}

bool SmartAIMgr::CheckUnusedEventParams(SmartScriptHolder const& e)
{
    std::size_t paramsStructSize = [&]() -> std::size_t
    {
        constexpr std::size_t NO_PARAMS = std::size_t(0);
        switch (e.event.type)
        {
            case SMART_EVENT_UPDATE_IC: return sizeof(SmartEvent::minMaxRepeat);
            case SMART_EVENT_UPDATE_OOC: return sizeof(SmartEvent::minMaxRepeat);
            case SMART_EVENT_HEALTH_PCT: return sizeof(SmartEvent::minMaxRepeat);
            case SMART_EVENT_MANA_PCT: return sizeof(SmartEvent::minMaxRepeat);
            case SMART_EVENT_AGGRO: return NO_PARAMS;
            case SMART_EVENT_KILL: return sizeof(SmartEvent::kill);
            case SMART_EVENT_DEATH: return NO_PARAMS;
            case SMART_EVENT_EVADE: return NO_PARAMS;
            case SMART_EVENT_SPELLHIT: return sizeof(SmartEvent::spellHit);
            case SMART_EVENT_RANGE: return sizeof(SmartEvent::minMaxRepeat);
            case SMART_EVENT_OOC_LOS: return sizeof(SmartEvent::los);
            case SMART_EVENT_RESPAWN: return sizeof(SmartEvent::respawn);
            case SMART_EVENT_TARGET_HEALTH_PCT: return sizeof(SmartEvent::minMaxRepeat);
            case SMART_EVENT_VICTIM_CASTING: return sizeof(SmartEvent::targetCasting);
            case SMART_EVENT_FRIENDLY_HEALTH: return sizeof(SmartEvent::friendlyHealth);
            case SMART_EVENT_FRIENDLY_IS_CC: return sizeof(SmartEvent::friendlyCC);
            case SMART_EVENT_FRIENDLY_MISSING_BUFF: return sizeof(SmartEvent::missingBuff);
            case SMART_EVENT_SUMMONED_UNIT: return sizeof(SmartEvent::summoned);
            case SMART_EVENT_TARGET_MANA_PCT: return sizeof(SmartEvent::minMaxRepeat);
            case SMART_EVENT_ACCEPTED_QUEST: return sizeof(SmartEvent::quest);
            case SMART_EVENT_REWARD_QUEST: return sizeof(SmartEvent::quest);
            case SMART_EVENT_REACHED_HOME: return NO_PARAMS;
            case SMART_EVENT_RECEIVE_EMOTE: return sizeof(SmartEvent::emote);
            case SMART_EVENT_HAS_AURA: return sizeof(SmartEvent::aura);
            case SMART_EVENT_TARGET_BUFFED: return sizeof(SmartEvent::aura);
            case SMART_EVENT_RESET: return NO_PARAMS;
            case SMART_EVENT_IC_LOS: return sizeof(SmartEvent::los);
            case SMART_EVENT_PASSENGER_BOARDED: return sizeof(SmartEvent::minMax);
            case SMART_EVENT_PASSENGER_REMOVED: return sizeof(SmartEvent::minMax);
            case SMART_EVENT_CHARMED: return sizeof(SmartEvent::charm);
            case SMART_EVENT_CHARMED_TARGET: return NO_PARAMS;
            case SMART_EVENT_SPELLHIT_TARGET: return sizeof(SmartEvent::spellHit);
            case SMART_EVENT_DAMAGED: return sizeof(SmartEvent::minMaxRepeat);
            case SMART_EVENT_DAMAGED_TARGET: return sizeof(SmartEvent::minMaxRepeat);
            case SMART_EVENT_MOVEMENTINFORM: return sizeof(SmartEvent::movementInform);
            case SMART_EVENT_SUMMON_DESPAWNED: return sizeof(SmartEvent::summoned);
            case SMART_EVENT_CORPSE_REMOVED: return NO_PARAMS;
            case SMART_EVENT_AI_INIT: return NO_PARAMS;
            case SMART_EVENT_DATA_SET: return sizeof(SmartEvent::dataSet);
            case SMART_EVENT_ESCORT_START: return sizeof(SmartEvent::waypoint);
            case SMART_EVENT_ESCORT_REACHED: return sizeof(SmartEvent::waypoint);
            case SMART_EVENT_TRANSPORT_ADDPLAYER: return NO_PARAMS;
            case SMART_EVENT_TRANSPORT_ADDCREATURE: return sizeof(SmartEvent::transportAddCreature);
            case SMART_EVENT_TRANSPORT_REMOVE_PLAYER: return NO_PARAMS;
            case SMART_EVENT_TRANSPORT_RELOCATE: return sizeof(SmartEvent::transportRelocate);
            case SMART_EVENT_INSTANCE_PLAYER_ENTER: return sizeof(SmartEvent::instancePlayerEnter);
            case SMART_EVENT_AREATRIGGER_ONTRIGGER: return sizeof(SmartEvent::areatrigger);
            case SMART_EVENT_QUEST_ACCEPTED: return NO_PARAMS;
            case SMART_EVENT_QUEST_OBJ_COMPLETION: return NO_PARAMS;
            case SMART_EVENT_QUEST_COMPLETION: return NO_PARAMS;
            case SMART_EVENT_QUEST_REWARDED: return NO_PARAMS;
            case SMART_EVENT_QUEST_FAIL: return NO_PARAMS;
            case SMART_EVENT_TEXT_OVER: return sizeof(SmartEvent::textOver);
            case SMART_EVENT_RECEIVE_HEAL: return sizeof(SmartEvent::minMaxRepeat);
            case SMART_EVENT_JUST_SUMMONED: return NO_PARAMS;
            case SMART_EVENT_ESCORT_PAUSED: return sizeof(SmartEvent::waypoint);
            case SMART_EVENT_ESCORT_RESUMED: return sizeof(SmartEvent::waypoint);
            case SMART_EVENT_ESCORT_STOPPED: return sizeof(SmartEvent::waypoint);
            case SMART_EVENT_ESCORT_ENDED: return sizeof(SmartEvent::waypoint);
            case SMART_EVENT_TIMED_EVENT_TRIGGERED: return sizeof(SmartEvent::timedEvent);
            case SMART_EVENT_UPDATE: return sizeof(SmartEvent::minMaxRepeat);
            case SMART_EVENT_LINK: return NO_PARAMS;
            case SMART_EVENT_GOSSIP_SELECT: return sizeof(SmartEvent::gossip);
            case SMART_EVENT_JUST_CREATED: return NO_PARAMS;
            case SMART_EVENT_GOSSIP_HELLO: return sizeof(SmartEvent::gossipHello);
            case SMART_EVENT_FOLLOW_COMPLETED: return NO_PARAMS;
            case SMART_EVENT_EVENT_PHASE_CHANGE: return sizeof(SmartEvent::eventPhaseChange);
            case SMART_EVENT_IS_BEHIND_TARGET: return sizeof(SmartEvent::minMaxRepeat);
            case SMART_EVENT_IS_IN_MELEE_RANGE: return sizeof(SmartEvent::meleeRange);
            case SMART_EVENT_GAME_EVENT_START: return sizeof(SmartEvent::gameEvent);
            case SMART_EVENT_GAME_EVENT_END: return sizeof(SmartEvent::gameEvent);
            case SMART_EVENT_GO_STATE_CHANGED: return sizeof(SmartEvent::goStateChanged);
            case SMART_EVENT_GO_EVENT_INFORM: return sizeof(SmartEvent::eventInform);
            case SMART_EVENT_ACTION_DONE: return sizeof(SmartEvent::doAction);
            case SMART_EVENT_ON_SPELLCLICK: return NO_PARAMS;
            case SMART_EVENT_FRIENDLY_HEALTH_PCT: return sizeof(SmartEvent::friendlyHealthPct);
            case SMART_EVENT_DISTANCE_CREATURE: return sizeof(SmartEvent::distance);
            case SMART_EVENT_DISTANCE_GAMEOBJECT: return sizeof(SmartEvent::distance);
            case SMART_EVENT_COUNTER_SET: return sizeof(SmartEvent::counter);
                //case SMART_EVENT_SCENE_START: return sizeof(SmartEvent::raw);
                //case SMART_EVENT_SCENE_TRIGGER: return sizeof(SmartEvent::raw);
                //case SMART_EVENT_SCENE_CANCEL: return sizeof(SmartEvent::raw);
                //case SMART_EVENT_SCENE_COMPLETE: return sizeof(SmartEvent::raw);
            case SMART_EVENT_SUMMONED_UNIT_DIES: return sizeof(SmartEvent::summoned);
            case SMART_EVENT_NEAR_PLAYERS: return sizeof(SmartEvent::nearPlayer);
            case SMART_EVENT_NEAR_PLAYERS_NEGATION: return sizeof(SmartEvent::nearPlayerNegation);
            case SMART_EVENT_NEAR_UNIT: return sizeof(SmartEvent::nearUnit);
            case SMART_EVENT_NEAR_UNIT_NEGATION: return sizeof(SmartEvent::nearUnitNegation);
            case SMART_EVENT_AREA_CASTING: return sizeof(SmartEvent::minMaxRepeat);
            case SMART_EVENT_AREA_RANGE: return sizeof(SmartEvent::minMaxRepeat);
            case SMART_EVENT_SUMMONED_UNIT_EVADE: return sizeof(SmartEvent::summoned);
            case SMART_EVENT_WAYPOINT_REACHED: return sizeof(SmartEvent::wpData);
            case SMART_EVENT_WAYPOINT_ENDED: return sizeof(SmartEvent::wpData);
            default:
                LOG_WARN("sql.sql", "SmartAIMgr: entryorguid {} source_type {} id {} action_type {} is using an event {} with no unused params specified in SmartAIMgr::CheckUnusedEventParams(), please report this.",
                            e.entryOrGuid, e.GetScriptType(), e.event_id, e.GetActionType(), e.GetEventType());
                return sizeof(SmartEvent::raw);
        }
    }();

    static std::size_t rawCount = sizeof(SmartEvent::raw) / sizeof(uint32);
    std::size_t paramsCount = paramsStructSize / sizeof(uint32);

    bool valid = true;
    for (std::size_t index = paramsCount; index < rawCount; index++)
    {
        uint32 value = ((uint32*)&e.event.raw)[index];
        if (value != 0)
        {
            LOG_ERROR("sql.sql", "SmartAIMgr: entryorguid {} source_type {} id {} action_type {} has unused event_param{} with value {}, it must be 0, skipped.",
                         e.entryOrGuid, e.GetScriptType(), e.event_id, e.GetActionType(), index + 1, value);
            valid = false;
        }
    }

    return valid;
}

bool SmartAIMgr::CheckUnusedActionParams(SmartScriptHolder const& e)
{
    std::size_t paramsStructSize = [&]() -> std::size_t
    {
        constexpr std::size_t NO_PARAMS = std::size_t(0);
        switch (e.action.type)
        {
            case SMART_ACTION_NONE: return NO_PARAMS;
            case SMART_ACTION_TALK: return sizeof(SmartAction::talk);
            case SMART_ACTION_SET_FACTION: return sizeof(SmartAction::faction);
            case SMART_ACTION_MORPH_TO_ENTRY_OR_MODEL: return sizeof(SmartAction::morphOrMount);
            case SMART_ACTION_SOUND: return sizeof(SmartAction::sound);
            case SMART_ACTION_PLAY_EMOTE: return sizeof(SmartAction::emote);
            case SMART_ACTION_FAIL_QUEST: return sizeof(SmartAction::quest);
            case SMART_ACTION_OFFER_QUEST: return sizeof(SmartAction::questOffer);
            case SMART_ACTION_SET_REACT_STATE: return sizeof(SmartAction::react);
            case SMART_ACTION_ACTIVATE_GOBJECT: return NO_PARAMS;
            case SMART_ACTION_RANDOM_EMOTE: return sizeof(SmartAction::randomEmote);
            case SMART_ACTION_CAST: return sizeof(SmartAction::cast);
            case SMART_ACTION_SUMMON_CREATURE: return sizeof(SmartAction::summonCreature);
            case SMART_ACTION_THREAT_SINGLE_PCT: return sizeof(SmartAction::threatPCT);
            case SMART_ACTION_THREAT_ALL_PCT: return sizeof(SmartAction::threatPCT);
            case SMART_ACTION_CALL_AREAEXPLOREDOREVENTHAPPENS: return sizeof(SmartAction::quest);
            case SMART_ACTION_RESERVED_16: return sizeof(SmartAction::raw);
            case SMART_ACTION_SET_EMOTE_STATE: return sizeof(SmartAction::emote);
            case SMART_ACTION_SET_UNIT_FLAG: return sizeof(SmartAction::unitFlag);
            case SMART_ACTION_REMOVE_UNIT_FLAG: return sizeof(SmartAction::unitFlag);
            case SMART_ACTION_AUTO_ATTACK: return sizeof(SmartAction::autoAttack);
            case SMART_ACTION_ALLOW_COMBAT_MOVEMENT: return sizeof(SmartAction::combatMove);
            case SMART_ACTION_SET_EVENT_PHASE: return sizeof(SmartAction::setEventPhase);
            case SMART_ACTION_INC_EVENT_PHASE: return sizeof(SmartAction::incEventPhase);
            case SMART_ACTION_EVADE: return NO_PARAMS;
            case SMART_ACTION_FLEE_FOR_ASSIST: return sizeof(SmartAction::flee);
            case SMART_ACTION_CALL_GROUPEVENTHAPPENS: return sizeof(SmartAction::quest);
            case SMART_ACTION_COMBAT_STOP: return NO_PARAMS;
            case SMART_ACTION_REMOVEAURASFROMSPELL: return sizeof(SmartAction::removeAura);
            case SMART_ACTION_FOLLOW: return sizeof(SmartAction::follow);
            case SMART_ACTION_RANDOM_PHASE: return sizeof(SmartAction::randomPhase);
            case SMART_ACTION_RANDOM_PHASE_RANGE: return sizeof(SmartAction::randomPhaseRange);
            case SMART_ACTION_RESET_GOBJECT: return NO_PARAMS;
            case SMART_ACTION_CALL_KILLEDMONSTER: return sizeof(SmartAction::killedMonster);
            case SMART_ACTION_SET_INST_DATA: return sizeof(SmartAction::setInstanceData);
            case SMART_ACTION_SET_INST_DATA64: return sizeof(SmartAction::setInstanceData64);
            case SMART_ACTION_UPDATE_TEMPLATE: return sizeof(SmartAction::updateTemplate);
            case SMART_ACTION_DIE: return sizeof(SmartAction::die);
            case SMART_ACTION_SET_IN_COMBAT_WITH_ZONE: return NO_PARAMS;
            case SMART_ACTION_CALL_FOR_HELP: return sizeof(SmartAction::callHelp);
            case SMART_ACTION_SET_SHEATH: return sizeof(SmartAction::setSheath);
            case SMART_ACTION_FORCE_DESPAWN: return sizeof(SmartAction::forceDespawn);
            case SMART_ACTION_SET_INVINCIBILITY_HP_LEVEL: return sizeof(SmartAction::invincHP);
            case SMART_ACTION_MOUNT_TO_ENTRY_OR_MODEL: return sizeof(SmartAction::morphOrMount);
            case SMART_ACTION_SET_INGAME_PHASE_MASK: return sizeof(SmartAction::ingamePhaseMask);
            case SMART_ACTION_SET_DATA: return sizeof(SmartAction::setData);
            case SMART_ACTION_MOVE_FORWARD: return sizeof(SmartAction::moveRandom);
            case SMART_ACTION_ATTACK_STOP: return NO_PARAMS;
            case SMART_ACTION_SET_VISIBILITY: return sizeof(SmartAction::visibility);
            case SMART_ACTION_SET_ACTIVE: return sizeof(SmartAction::setActive);
            case SMART_ACTION_ATTACK_START: return NO_PARAMS;
            case SMART_ACTION_SUMMON_GO: return sizeof(SmartAction::summonGO);
            case SMART_ACTION_KILL_UNIT: return NO_PARAMS;
            case SMART_ACTION_ACTIVATE_TAXI: return sizeof(SmartAction::taxi);
            case SMART_ACTION_ESCORT_START: return sizeof(SmartAction::wpStart);
            case SMART_ACTION_ESCORT_PAUSE: return sizeof(SmartAction::wpPause);
            case SMART_ACTION_ESCORT_STOP: return sizeof(SmartAction::wpStop);
            case SMART_ACTION_ADD_ITEM: return sizeof(SmartAction::item);
            case SMART_ACTION_REMOVE_ITEM: return sizeof(SmartAction::item);
            case SMART_ACTION_INSTALL_AI_TEMPLATE: return sizeof(SmartAction::installTtemplate);
            case SMART_ACTION_SET_RUN: return sizeof(SmartAction::setRun);
            case SMART_ACTION_SET_FLY: return sizeof(SmartAction::setFly);
            case SMART_ACTION_SET_SWIM: return sizeof(SmartAction::setSwim);
            case SMART_ACTION_TELEPORT: return sizeof(SmartAction::teleport);
            case SMART_ACTION_SET_COUNTER: return sizeof(SmartAction::setCounter);
            case SMART_ACTION_STORE_TARGET_LIST: return sizeof(SmartAction::storeTargets);
            case SMART_ACTION_ESCORT_RESUME: return NO_PARAMS;
            case SMART_ACTION_SET_ORIENTATION: return sizeof(SmartAction::orientation);
            case SMART_ACTION_CREATE_TIMED_EVENT: return sizeof(SmartAction::timeEvent);
            case SMART_ACTION_PLAYMOVIE: return sizeof(SmartAction::movie);
            case SMART_ACTION_MOVE_TO_POS: return sizeof(SmartAction::moveToPos);
            case SMART_ACTION_RESPAWN_TARGET: return sizeof(SmartAction::RespawnTarget);
            case SMART_ACTION_EQUIP: return sizeof(SmartAction::equip);
            case SMART_ACTION_CLOSE_GOSSIP: return NO_PARAMS;
            case SMART_ACTION_TRIGGER_TIMED_EVENT: return sizeof(SmartAction::timeEvent);
            case SMART_ACTION_REMOVE_TIMED_EVENT: return sizeof(SmartAction::timeEvent);
            case SMART_ACTION_ADD_AURA: return sizeof(SmartAction::addAura);
            case SMART_ACTION_OVERRIDE_SCRIPT_BASE_OBJECT: return NO_PARAMS;
            case SMART_ACTION_RESET_SCRIPT_BASE_OBJECT: return NO_PARAMS;
            case SMART_ACTION_CALL_SCRIPT_RESET: return NO_PARAMS;
            case SMART_ACTION_SET_RANGED_MOVEMENT: return sizeof(SmartAction::setRangedMovement);
            case SMART_ACTION_CALL_TIMED_ACTIONLIST: return sizeof(SmartAction::timedActionList);
            case SMART_ACTION_SET_NPC_FLAG: return sizeof(SmartAction::flag);
            case SMART_ACTION_ADD_NPC_FLAG: return sizeof(SmartAction::flag);
            case SMART_ACTION_REMOVE_NPC_FLAG: return sizeof(SmartAction::flag);
            case SMART_ACTION_SIMPLE_TALK: return sizeof(SmartAction::simpleTalk);
            case SMART_ACTION_SELF_CAST: return sizeof(SmartAction::cast);
            case SMART_ACTION_INVOKER_CAST: return sizeof(SmartAction::cast);
            case SMART_ACTION_CROSS_CAST: return sizeof(SmartAction::crossCast);
            case SMART_ACTION_CALL_RANDOM_TIMED_ACTIONLIST: return sizeof(SmartAction::randTimedActionList);
            case SMART_ACTION_CALL_RANDOM_RANGE_TIMED_ACTIONLIST: return sizeof(SmartAction::randRangeTimedActionList);
            case SMART_ACTION_RANDOM_MOVE: return sizeof(SmartAction::moveRandom);
            case SMART_ACTION_SET_UNIT_FIELD_BYTES_1: return sizeof(SmartAction::setunitByte);
            case SMART_ACTION_REMOVE_UNIT_FIELD_BYTES_1: return sizeof(SmartAction::delunitByte);
            case SMART_ACTION_INTERRUPT_SPELL: return sizeof(SmartAction::interruptSpellCasting);
            case SMART_ACTION_SEND_GO_CUSTOM_ANIM: return sizeof(SmartAction::sendGoCustomAnim);
            case SMART_ACTION_SET_DYNAMIC_FLAG: return sizeof(SmartAction::flag);
            case SMART_ACTION_ADD_DYNAMIC_FLAG: return sizeof(SmartAction::flag);
            case SMART_ACTION_REMOVE_DYNAMIC_FLAG: return sizeof(SmartAction::flag);
            case SMART_ACTION_JUMP_TO_POS: return sizeof(SmartAction::jump);
            case SMART_ACTION_SEND_GOSSIP_MENU: return sizeof(SmartAction::sendGossipMenu);
            case SMART_ACTION_GO_SET_LOOT_STATE: return sizeof(SmartAction::setGoLootState);
            case SMART_ACTION_SEND_TARGET_TO_TARGET: return sizeof(SmartAction::sendTargetToTarget);
            case SMART_ACTION_SET_HOME_POS: return sizeof(SmartAction::setHomePos);
            case SMART_ACTION_SET_HEALTH_REGEN: return sizeof(SmartAction::setHealthRegen);
            case SMART_ACTION_SET_ROOT: return sizeof(SmartAction::setRoot);
            case SMART_ACTION_SET_GO_FLAG: return sizeof(SmartAction::goFlag);
            case SMART_ACTION_ADD_GO_FLAG: return sizeof(SmartAction::goFlag);
            case SMART_ACTION_REMOVE_GO_FLAG: return sizeof(SmartAction::goFlag);
            case SMART_ACTION_SUMMON_CREATURE_GROUP: return sizeof(SmartAction::creatureGroup);
            case SMART_ACTION_SET_POWER: return sizeof(SmartAction::power);
            case SMART_ACTION_ADD_POWER: return sizeof(SmartAction::power);
            case SMART_ACTION_REMOVE_POWER: return sizeof(SmartAction::power);
            case SMART_ACTION_GAME_EVENT_STOP: return sizeof(SmartAction::gameEventStop);
            case SMART_ACTION_GAME_EVENT_START: return sizeof(SmartAction::gameEventStart);
            case SMART_ACTION_START_CLOSEST_WAYPOINT: return sizeof(SmartAction::startClosestWaypoint);
            case SMART_ACTION_RISE_UP: return sizeof(SmartAction::moveRandom);
            case SMART_ACTION_RANDOM_SOUND: return sizeof(SmartAction::randomSound);
            case SMART_ACTION_SET_CORPSE_DELAY: return sizeof(SmartAction::corpseDelay);
            case SMART_ACTION_DISABLE_EVADE: return sizeof(SmartAction::disableEvade);
            case SMART_ACTION_GO_SET_GO_STATE: return sizeof(SmartAction::goState);
            // case SMART_ACTION_SET_CAN_FLY: return sizeof(SmartAction::setFly);
            // case SMART_ACTION_REMOVE_AURAS_BY_TYPE: return sizeof(SmartAction::auraType);
            case SMART_ACTION_SET_SIGHT_DIST: return sizeof(SmartAction::sightDistance);
            case SMART_ACTION_FLEE: return sizeof(SmartAction::flee);
            case SMART_ACTION_ADD_THREAT: return sizeof(SmartAction::threat);
            case SMART_ACTION_LOAD_EQUIPMENT: return sizeof(SmartAction::loadEquipment);
            case SMART_ACTION_TRIGGER_RANDOM_TIMED_EVENT: return sizeof(SmartAction::randomTimedEvent);
            case SMART_ACTION_REMOVE_ALL_GAMEOBJECTS: return NO_PARAMS;
            // case SMART_ACTION_PAUSE_MOVEMENT: return sizeof(SmartAction::pauseMovement);
            case SMART_ACTION_PLAY_ANIMKIT: return sizeof(SmartAction::raw);
            case SMART_ACTION_SCENE_PLAY: return sizeof(SmartAction::raw);
            case SMART_ACTION_SCENE_CANCEL: return sizeof(SmartAction::raw);
            // case SMART_ACTION_SPAWN_SPAWNGROUP: return sizeof(SmartAction::groupSpawn);
            // case SMART_ACTION_DESPAWN_SPAWNGROUP: return sizeof(SmartAction::groupSpawn);
            // case SMART_ACTION_RESPAWN_BY_SPAWNID: return sizeof(SmartAction::respawnData);
            case SMART_ACTION_PLAY_CINEMATIC: return sizeof(SmartAction::cinematic);
            case SMART_ACTION_SET_MOVEMENT_SPEED: return sizeof(SmartAction::movementSpeed);
            // case SMART_ACTION_PLAY_SPELL_VISUAL_KIT: return sizeof(SmartAction::raw);
            // case SMART_ACTION_OVERRIDE_LIGHT: return sizeof(SmartAction::overrideLight);
            // case SMART_ACTION_OVERRIDE_WEATHER: return sizeof(SmartAction::overrideWeather);
            // case SMART_ACTION_SET_AI_ANIM_KIT: return sizeof(SmartAction::raw);
            case SMART_ACTION_SET_HOVER: return sizeof(SmartAction::setHover);
            case SMART_ACTION_SET_HEALTH_PCT: return sizeof(SmartAction::setHealthPct);
            // case SMART_ACTION_CREATE_CONVERSATION: return sizeof(SmartAction::raw);
            case SMART_ACTION_MOVE_TO_POS_TARGET: return sizeof(SmartAction::moveToPosTarget);
            case SMART_ACTION_EXIT_VEHICLE: return NO_PARAMS;
            case SMART_ACTION_SET_UNIT_MOVEMENT_FLAGS: return sizeof(SmartAction::movementFlag);
            case SMART_ACTION_SET_COMBAT_DISTANCE: return sizeof(SmartAction::combatDistance);
            case SMART_ACTION_FALL: return NO_PARAMS;
            case SMART_ACTION_SET_EVENT_FLAG_RESET: return sizeof(SmartAction::setActive);
            case SMART_ACTION_STOP_MOTION: return sizeof(SmartAction::stopMotion);
            case SMART_ACTION_NO_ENVIRONMENT_UPDATE: return NO_PARAMS;
            case SMART_ACTION_ZONE_UNDER_ATTACK: return NO_PARAMS;
            case SMART_ACTION_LOAD_GRID: return NO_PARAMS;
            case SMART_ACTION_MUSIC: return sizeof(SmartAction::music);
            case SMART_ACTION_DO_ACTION: return sizeof(SmartAction::doAction);
            case SMART_ACTION_SET_GUID: return sizeof(SmartAction::setGuid);
            case SMART_ACTION_SCRIPTED_SPAWN: return sizeof(SmartAction::scriptSpawn);
            case SMART_ACTION_SET_SCALE: return sizeof(SmartAction::setScale);
            case SMART_ACTION_SUMMON_RADIAL: return sizeof(SmartAction::radialSummon);
            case SMART_ACTION_PLAY_SPELL_VISUAL: return sizeof(SmartAction::spellVisual);
            case SMART_ACTION_FOLLOW_GROUP: return sizeof(SmartAction::followGroup);
            case SMART_ACTION_SET_ORIENTATION_TARGET: return sizeof(SmartAction::orientationTarget);
            case SMART_ACTION_WAYPOINT_START: return sizeof(SmartAction::wpData);
            case SMART_ACTION_WAYPOINT_DATA_RANDOM: return sizeof(SmartAction::wpDataRandom);
            case SMART_ACTION_MOVEMENT_STOP: return NO_PARAMS;
            case SMART_ACTION_MOVEMENT_PAUSE: return sizeof(SmartAction::move);
            case SMART_ACTION_MOVEMENT_RESUME: return sizeof(SmartAction::move);
            case SMART_ACTION_WORLD_SCRIPT: return sizeof(SmartAction::worldStateScript);
            case SMART_ACTION_DISABLE_REWARD: return sizeof(SmartAction::reward);
            case SMART_ACTION_SET_ANIM_TIER: return sizeof(SmartAction::animTier);
            case SMART_ACTION_SET_GOSSIP_MENU: return sizeof(SmartAction::setGossipMenu);
            case SMART_ACTION_DISMOUNT: return NO_PARAMS;
            default:
                LOG_WARN("sql.sql", "SmartAIMgr: entryorguid {} source_type {} id {} action_type {} is using an action with no unused params specified in SmartAIMgr::CheckUnusedActionParams(), please report this.",
                            e.entryOrGuid, e.GetScriptType(), e.event_id, e.GetActionType());
                return sizeof(SmartAction::raw);
        }
    }();

    static std::size_t rawCount = sizeof(SmartAction::raw) / sizeof(uint32);
    std::size_t paramsCount = paramsStructSize / sizeof(uint32);

    bool valid = true;
    for (std::size_t index = paramsCount; index < rawCount; index++)
    {
        uint32 value = ((uint32*)&e.action.raw)[index];
        if (value != 0)
        {
            LOG_ERROR("sql.sql", "SmartAIMgr: entryorguid {} source_type {} id {} action_type {} has unused action_param{} with value {}, it must be 0, skipped.",
                         e.entryOrGuid, e.GetScriptType(), e.event_id, e.GetActionType(), index + 1, value);
            valid = false;
        }
    }

    return valid;
}

bool SmartAIMgr::CheckUnusedTargetParams(SmartScriptHolder const& e)
{
    std::size_t paramsStructSize = [&]() -> std::size_t
    {
        constexpr std::size_t NO_PARAMS = std::size_t(0);
        switch (e.target.type)
        {
            case SMART_TARGET_NONE: return NO_PARAMS;
            case SMART_TARGET_SELF: return NO_PARAMS;
            case SMART_TARGET_VICTIM: return NO_PARAMS;
            case SMART_TARGET_HOSTILE_SECOND_AGGRO: return sizeof(SmartTarget::hostileRandom);
            case SMART_TARGET_HOSTILE_LAST_AGGRO: return sizeof(SmartTarget::hostileRandom);
            case SMART_TARGET_HOSTILE_RANDOM: return sizeof(SmartTarget::hostileRandom);
            case SMART_TARGET_HOSTILE_RANDOM_NOT_TOP: return sizeof(SmartTarget::hostileRandom);
            case SMART_TARGET_ACTION_INVOKER: return NO_PARAMS;
            case SMART_TARGET_POSITION: return NO_PARAMS; //uses x,y,z,o
            case SMART_TARGET_CREATURE_RANGE: return sizeof(SmartTarget::unitRange);
            case SMART_TARGET_CREATURE_GUID: return sizeof(SmartTarget::unitGUID);
            case SMART_TARGET_CREATURE_DISTANCE: return sizeof(SmartTarget::unitDistance);
            case SMART_TARGET_STORED: return sizeof(SmartTarget::stored);
            case SMART_TARGET_GAMEOBJECT_RANGE: return sizeof(SmartTarget::goRange);
            case SMART_TARGET_GAMEOBJECT_GUID: return sizeof(SmartTarget::goGUID);
            case SMART_TARGET_GAMEOBJECT_DISTANCE: return sizeof(SmartTarget::goDistance);
            case SMART_TARGET_INVOKER_PARTY: return sizeof(SmartTarget::invokerParty);
            case SMART_TARGET_PLAYER_RANGE: return sizeof(SmartTarget::playerRange);
            case SMART_TARGET_PLAYER_DISTANCE: return sizeof(SmartTarget::playerDistance);
            case SMART_TARGET_CLOSEST_CREATURE: return sizeof(SmartTarget::unitClosest);
            case SMART_TARGET_CLOSEST_GAMEOBJECT: return sizeof(SmartTarget::goClosest);
            case SMART_TARGET_CLOSEST_PLAYER: return sizeof(SmartTarget::playerDistance);
            case SMART_TARGET_ACTION_INVOKER_VEHICLE: return NO_PARAMS;
            case SMART_TARGET_OWNER_OR_SUMMONER: return sizeof(SmartTarget::owner);
            case SMART_TARGET_THREAT_LIST: return sizeof(SmartTarget::threatList);
            case SMART_TARGET_CLOSEST_ENEMY: return sizeof(SmartTarget::closestAttackable);
            case SMART_TARGET_CLOSEST_FRIENDLY: return sizeof(SmartTarget::closestFriendly);
            case SMART_TARGET_LOOT_RECIPIENTS: return NO_PARAMS;
            case SMART_TARGET_FARTHEST: return sizeof(SmartTarget::farthest);
            case SMART_TARGET_VEHICLE_PASSENGER: return sizeof(SmartTarget::vehicle);
            // case SMART_TARGET_CLOSEST_UNSPAWNED_GAMEOBJECT: return sizeof(SmartTarget::goClosest);
            case SMART_TARGET_PLAYER_WITH_AURA: return sizeof(SmartTarget::playerWithAura);
            case SMART_TARGET_RANDOM_POINT: return sizeof(SmartTarget::randomPoint);
            case SMART_TARGET_SUMMONED_CREATURES: return sizeof(SmartTarget::summonedCreatures);
            case SMART_TARGET_INSTANCE_STORAGE: return sizeof(SmartTarget::instanceStorage);
            default:
                LOG_WARN("sql.sql", "SmartAIMgr: entryorguid {} source_type {} id {} action_type {} is using a target {} with no unused params specified in SmartAIMgr::CheckUnusedTargetParams(), please report this.",
                            e.entryOrGuid, e.GetScriptType(), e.event_id, e.GetActionType(), e.GetTargetType());
                return sizeof(SmartTarget::raw);
        }
    }();

    static std::size_t rawCount = sizeof(SmartTarget::raw) / sizeof(uint32);
    std::size_t paramsCount = paramsStructSize / sizeof(uint32);

    bool valid = true;
    for (std::size_t index = paramsCount; index < rawCount; index++)
    {
        uint32 value = ((uint32*)&e.target.raw)[index];
        if (value != 0)
        {
            LOG_ERROR("sql.sql", "SmartAIMgr: entryorguid {} source_type {} id {} action_type {} has unused target_param{} with value {}, it must be 0, skipped.",
                         e.entryOrGuid, e.GetScriptType(), e.event_id, e.GetActionType(), index + 1, value);
            valid = false;
        }
    }

    return valid;
}

bool SmartAIMgr::IsEventValid(SmartScriptHolder& e)
{
    if ((e.event.type >= SMART_EVENT_TC_END && e.event.type <= SMART_EVENT_AC_START) || e.event.type >= SMART_EVENT_AC_END)
    {
        LOG_ERROR("sql.sql", "SmartAIMgr: EntryOrGuid {} using event({}) has invalid event type ({}), skipped.", e.entryOrGuid, e.event_id, e.GetEventType());
        return false;
    }
    // in SMART_SCRIPT_TYPE_TIMED_ACTIONLIST all event types are overriden by core
    if (e.GetScriptType() != SMART_SCRIPT_TYPE_TIMED_ACTIONLIST && !(SmartAIEventMask[e.event.type][1] & SmartAITypeMask[e.GetScriptType()][1]))
    {
        LOG_ERROR("sql.sql", "SmartAIMgr: EntryOrGuid {}, event type {} can not be used for Script type {}", e.entryOrGuid, e.GetEventType(), e.GetScriptType());
        return false;
    }
    if (e.action.type <= 0
            || (e.action.type >= SMART_ACTION_TC_END && e.action.type <= SMART_ACTION_AC_START)
            || e.action.type >= SMART_ACTION_AC_END)
    {
        LOG_ERROR("sql.sql", "SmartAIMgr: EntryOrGuid {} using event({}) has an invalid action type ({}), skipped.", e.entryOrGuid, e.event_id, e.GetActionType());
        return false;
    }
    switch (e.action.type)
    {
        case SMART_ACTION_RESERVED_16:
        case SMART_ACTION_PLAY_ANIMKIT:
        case SMART_ACTION_SCENE_PLAY:
        case SMART_ACTION_SCENE_CANCEL:
            LOG_ERROR("sql.sql", "SmartAIMgr: EntryOrGuid {} using event({}) has an action type that is not supported on 3.3.5a ({}), skipped.",
                             e.entryOrGuid, e.event_id, e.GetActionType());
            return false;
        case SMART_ACTION_SET_CAN_FLY:
        case SMART_ACTION_REMOVE_AURAS_BY_TYPE:
        case SMART_ACTION_REMOVE_MOVEMENT:
        case SMART_ACTION_SPAWN_SPAWNGROUP:
        case SMART_ACTION_DESPAWN_SPAWNGROUP:
        case SMART_ACTION_RESPAWN_BY_SPAWNID:
            LOG_ERROR("sql.sql", "SmartAIMgr: EntryOrGuid {} using event({}) has an action type that is not yet supported on AzerothCore ({}), skipped.",
                             e.entryOrGuid, e.event_id, e.GetActionType());
            return false;
        default:
            break;
    }
    if (e.target.type < 0 || (e.target.type >= SMART_TARGET_TC_END && e.target.type < SMART_TARGET_AC_START) || e.target.type >= SMART_TARGET_AC_END)
    {
        LOG_ERROR("sql.sql", "SmartAIMgr: EntryOrGuid {} using event({}) has an invalid target type ({}), skipped.",
                         e.entryOrGuid, e.event_id, e.GetTargetType());
        return false;
    }
    if (e.target.type == SMART_TARGET_LOOT_RECIPIENTS)
    {
        LOG_ERROR("sql.sql", "SmartAIMgr: EntryOrGuid {} using event({}) has a target type that is not yet supported on AzerothCore ({}), skipped.",
                         e.entryOrGuid, e.event_id, e.GetTargetType());
        return false;
    }
    if (e.event.event_phase_mask > SMART_EVENT_PHASE_ALL)
    {
        LOG_ERROR("sql.sql", "SmartAIMgr: EntryOrGuid {} using event({}) has invalid phase mask ({}), skipped.", e.entryOrGuid, e.event_id, e.event.event_phase_mask);
        return false;
    }
    if (e.event.event_flags > SMART_EVENT_FLAGS_ALL)
    {
        LOG_ERROR("sql.sql", "SmartAIMgr: EntryOrGuid {} using event({}) has invalid event flags ({}), skipped.", e.entryOrGuid, e.event_id, e.event.event_flags);
        return false;
    }
    if (e.GetScriptType() == SMART_SCRIPT_TYPE_TIMED_ACTIONLIST)
    {
        e.event.type = SMART_EVENT_UPDATE_OOC;//force default OOC, can change when calling the script!
        if (!IsMinMaxValid(e, e.event.minMaxRepeat.min, e.event.minMaxRepeat.max))
            return false;

        if (!IsMinMaxValid(e, e.event.minMaxRepeat.repeatMin, e.event.minMaxRepeat.repeatMax))
            return false;
    }
    else
    {
        uint32 type = e.event.type;
        switch (type)
        {
            case SMART_EVENT_UPDATE:
            case SMART_EVENT_UPDATE_IC:
            case SMART_EVENT_UPDATE_OOC:
            case SMART_EVENT_HEALTH_PCT:
            case SMART_EVENT_MANA_PCT:
            case SMART_EVENT_TARGET_HEALTH_PCT:
            case SMART_EVENT_TARGET_MANA_PCT:
            case SMART_EVENT_DAMAGED:
            case SMART_EVENT_DAMAGED_TARGET:
            case SMART_EVENT_RECEIVE_HEAL:
                if (!IsMinMaxValid(e, e.event.minMaxRepeat.min, e.event.minMaxRepeat.max))
                    return false;

                if (!IsMinMaxValid(e, e.event.minMaxRepeat.repeatMin, e.event.minMaxRepeat.repeatMax))
                    return false;
                break;
            case SMART_EVENT_AREA_RANGE:
            case SMART_EVENT_AREA_CASTING:
            case SMART_EVENT_IS_BEHIND_TARGET:
            case SMART_EVENT_RANGE:
            case SMART_EVENT_IS_IN_MELEE_RANGE:
                if (!IsMinMaxValid(e, e.event.minMaxRepeat.min, e.event.minMaxRepeat.max))
                    return false;

                if (!IsMinMaxValid(e, e.event.minMaxRepeat.repeatMin, e.event.minMaxRepeat.repeatMax))
                    return false;

                if (!IsMinMaxValid(e, e.event.minMaxRepeat.rangeMin, e.event.minMaxRepeat.rangeMax))
                    return false;

                break;
            case SMART_EVENT_SPELLHIT:
            case SMART_EVENT_SPELLHIT_TARGET:
                if (e.event.spellHit.spell)
                {
                    SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(e.event.spellHit.spell);
                    if (!spellInfo)
                    {
                        LOG_ERROR("sql.sql", "SmartAIMgr: Entry {} SourceType {} Event {} Action {} uses non-existent Spell entry {}, skipped.", e.entryOrGuid, e.GetScriptType(), e.event_id, e.GetActionType(), e.event.spellHit.spell);
                        return false;
                    }
                    if (e.event.spellHit.school && (e.event.spellHit.school & spellInfo->SchoolMask) != spellInfo->SchoolMask)
                    {
                        LOG_ERROR("sql.sql", "SmartAIMgr: Entry {} SourceType {} Event {} Action {} uses Spell entry {} with invalid school mask, skipped.", e.entryOrGuid, e.GetScriptType(), e.event_id, e.GetActionType(), e.event.spellHit.spell);
                        return false;
                    }
                }
                if (!IsMinMaxValid(e, e.event.spellHit.cooldownMin, e.event.spellHit.cooldownMax))
                    return false;
                break;
            case SMART_EVENT_OOC_LOS:
            case SMART_EVENT_IC_LOS:
                if (!IsMinMaxValid(e, e.event.los.cooldownMin, e.event.los.cooldownMax))
                    return false;

                if (e.event.los.hostilityMode >= AsUnderlyingType(SmartEvent::LOSHostilityMode::End))
                {
                    LOG_ERROR("sql.sql", "SmartAIMgr: Entry {} SourceType {} Event {} Action {} uses hostilityMode with invalid value {} (max allowed value {}), skipped.",
                                 e.entryOrGuid, e.GetScriptType(), e.event_id, e.GetActionType(), e.event.los.hostilityMode, AsUnderlyingType(SmartEvent::LOSHostilityMode::End) - 1);
                    return false;
                }

                return IsSAIBoolValid(e, e.event.los.playerOnly);
            case SMART_EVENT_RESPAWN:
                if (e.event.respawn.type == SMART_SCRIPT_RESPAWN_CONDITION_MAP && !sMapStore.LookupEntry(e.event.respawn.map))
                {
                    LOG_ERROR("sql.sql", "SmartAIMgr: Entry {} SourceType {} Event {} Action {} uses non-existent Map entry {}, skipped.", e.entryOrGuid, e.GetScriptType(), e.event_id, e.GetActionType(), e.event.respawn.map);
                    return false;
                }
                if (e.event.respawn.type == SMART_SCRIPT_RESPAWN_CONDITION_AREA && !sAreaTableStore.LookupEntry(e.event.respawn.area))
                {
                    LOG_ERROR("sql.sql", "SmartAIMgr: Entry {} SourceType {} Event {} Action {} uses non-existent Area entry {}, skipped.", e.entryOrGuid, e.GetScriptType(), e.event_id, e.GetActionType(), e.event.respawn.area);
                    return false;
                }
                break;
            case SMART_EVENT_FRIENDLY_HEALTH:
                if (!NotNULL(e, e.event.friendlyHealth.radius))
                    return false;

                if (!IsMinMaxValid(e, e.event.friendlyHealth.repeatMin, e.event.friendlyHealth.repeatMax))
                    return false;
                break;
            case SMART_EVENT_FRIENDLY_IS_CC:
                if (!IsMinMaxValid(e, e.event.friendlyCC.repeatMin, e.event.friendlyCC.repeatMax))
                    return false;
                break;
            case SMART_EVENT_FRIENDLY_MISSING_BUFF:
                {
                    if (!IsSpellValid(e, e.event.missingBuff.spell))
                        return false;

                    if (!NotNULL(e, e.event.missingBuff.radius))
                        return false;

                    if (!IsMinMaxValid(e, e.event.missingBuff.repeatMin, e.event.missingBuff.repeatMax))
                        return false;
                    break;
                }
            case SMART_EVENT_KILL:
                if (!IsMinMaxValid(e, e.event.kill.cooldownMin, e.event.kill.cooldownMax))
                    return false;

                if (e.event.kill.creature && !IsCreatureValid(e, e.event.kill.creature))
                    return false;

                return IsSAIBoolValid(e, e.event.kill.playerOnly);
            case SMART_EVENT_VICTIM_CASTING:
                if (e.event.targetCasting.spellId > 0 && !sSpellMgr->GetSpellInfo(e.event.targetCasting.spellId))
                {
                    LOG_ERROR("scripts.ai.sai", "SmartAIMgr: Entry {} SourceType {} Event {} Action {} uses non-existent Spell entry {}, skipped.", e.entryOrGuid, e.GetScriptType(), e.event_id, e.GetActionType(), e.event.spellHit.spell);
                    return false;
                }

                if (!IsMinMaxValid(e, e.event.targetCasting.repeatMin, e.event.targetCasting.repeatMax))
                    return false;
                break;
            case SMART_EVENT_PASSENGER_BOARDED:
            case SMART_EVENT_PASSENGER_REMOVED:
                if (!IsMinMaxValid(e, e.event.minMax.repeatMin, e.event.minMax.repeatMax))
                    return false;
                break;
            case SMART_EVENT_SUMMON_DESPAWNED:
            case SMART_EVENT_SUMMONED_UNIT:
            case SMART_EVENT_SUMMONED_UNIT_DIES:
            case SMART_EVENT_SUMMONED_UNIT_EVADE:
                if (e.event.summoned.creature && !IsCreatureValid(e, e.event.summoned.creature))
                    return false;

                if (!IsMinMaxValid(e, e.event.summoned.cooldownMin, e.event.summoned.cooldownMax))
                    return false;
                break;
            case SMART_EVENT_ACCEPTED_QUEST:
            case SMART_EVENT_REWARD_QUEST:
                if (e.event.quest.quest && !IsQuestValid(e, e.event.quest.quest))
                    return false;

                if (!IsMinMaxValid(e, e.event.quest.cooldownMin, e.event.quest.cooldownMax))
                    return false;
                break;
            case SMART_EVENT_RECEIVE_EMOTE:
                {
                    if (e.event.emote.emote && !IsTextEmoteValid(e, e.event.emote.emote))
                        return false;

                    if (!IsMinMaxValid(e, e.event.emote.cooldownMin, e.event.emote.cooldownMax))
                        return false;
                    break;
                }
            case SMART_EVENT_HAS_AURA:
            case SMART_EVENT_TARGET_BUFFED:
                {
                    if (!IsSpellValid(e, e.event.aura.spell))
                        return false;

                    if (!IsMinMaxValid(e, e.event.aura.repeatMin, e.event.aura.repeatMax))
                        return false;
                    break;
                }
            case SMART_EVENT_TRANSPORT_ADDCREATURE:
                {
                    if (e.event.transportAddCreature.creature && !IsCreatureValid(e, e.event.transportAddCreature.creature))
                        return false;
                    break;
                }
            case SMART_EVENT_MOVEMENTINFORM:
                {
                    if (e.event.movementInform.type > NULL_MOTION_TYPE)
                    {
                        LOG_ERROR("sql.sql", "SmartAIMgr: Entry {} SourceType {} Event {} Action {} uses invalid Motion type {}, skipped.", e.entryOrGuid, e.GetScriptType(), e.event_id, e.GetActionType(), e.event.movementInform.type);
                        return false;
                    }
                    break;
                }
            case SMART_EVENT_DATA_SET:
                {
                    if (!IsMinMaxValid(e, e.event.dataSet.cooldownMin, e.event.dataSet.cooldownMax))
                        return false;
                    break;
                }
            case SMART_EVENT_AREATRIGGER_ONTRIGGER:
                {
                    if (e.event.areatrigger.id && !IsAreaTriggerValid(e, e.event.areatrigger.id))
                        return false;
                    break;
                }
            case SMART_EVENT_TEXT_OVER:
                //if (e.event.textOver.textGroupID && !IsTextValid(e, e.event.textOver.textGroupID)) return false;// 0 is a valid text group!
                break;
            case SMART_EVENT_LINK:
                {
                    if (e.link && e.link == e.event_id)
                    {
                        LOG_ERROR("sql.sql", "SmartAIMgr: Entry {} SourceType {}, Event {}, Link Event is linking self (infinite loop), skipped.", e.entryOrGuid, e.GetScriptType(), e.event_id);
                        return false;
                    }
                    break;
                }
            case SMART_EVENT_EVENT_PHASE_CHANGE:
                {
                    if (!e.event.eventPhaseChange.phasemask)
                    {
                        LOG_ERROR("sql.sql", "SmartAIMgr: Entry {} SourceType {} Event {} Action {} has no param set, event won't be executed!.", e.entryOrGuid, e.GetScriptType(), e.event_id, e.GetActionType());
                        return false;
                    }

                    if (e.event.eventPhaseChange.phasemask > SMART_EVENT_PHASE_ALL)
                    {
                        LOG_ERROR("sql.sql", "SmartAIMgr: Entry {} SourceType {} Event {} Action {} uses invalid phasemask {}, skipped.", e.entryOrGuid, e.GetScriptType(), e.event_id, e.GetActionType(), e.event.eventPhaseChange.phasemask);
                        return false;
                    }

                    if (e.event.event_phase_mask && !(e.event.event_phase_mask & e.event.eventPhaseChange.phasemask))
                    {
                        LOG_ERROR("sql.sql", "SmartAIMgr: Entry {} SourceType {} Event {} Action {} uses event phasemask {} and incompatible event_param1 {}, skipped.", e.entryOrGuid, e.GetScriptType(), e.event_id, e.GetActionType(), e.event.event_phase_mask, e.event.eventPhaseChange.phasemask);
                        return false;
                    }
                    break;
                }
            case SMART_EVENT_GAME_EVENT_START:
            case SMART_EVENT_GAME_EVENT_END:
                {
                    GameEventMgr::GameEventDataMap const& events = sGameEventMgr->GetEventMap();
                    if (e.event.gameEvent.gameEventId >= events.size() || !events[e.event.gameEvent.gameEventId].isValid())
                        return false;
                    break;
                }
            case SMART_EVENT_ACTION_DONE:
                {
                    if (e.event.doAction.eventId > EVENT_CHARGE)
                    {
                        LOG_ERROR("sql.sql", "SmartAIMgr: Entry {} SourceType {} Event {} Action {} uses invalid event id {}, skipped.", e.entryOrGuid, e.GetScriptType(), e.event_id, e.GetActionType(), e.event.doAction.eventId);
                        return false;
                    }
                    break;
                }
            case SMART_EVENT_FRIENDLY_HEALTH_PCT:
                if (!IsMinMaxValid(e, e.event.friendlyHealthPct.min, e.event.friendlyHealthPct.max))
                    return false;

                if (!IsMinMaxValid(e, e.event.friendlyHealthPct.repeatMin, e.event.friendlyHealthPct.repeatMax))
                    return false;

                if (e.event.friendlyHealthPct.hpPct > 100)
                {
                    LOG_ERROR("sql.sql", "SmartAIMgr: Entry {} SourceType {} Event {} Action {} has pct value above 100, skipped.", e.entryOrGuid, e.GetScriptType(), e.event_id, e.GetActionType());
                    return false;
                }

                switch (e.GetTargetType())
                {
                    case SMART_TARGET_CREATURE_RANGE:
                    case SMART_TARGET_CREATURE_GUID:
                    case SMART_TARGET_CREATURE_DISTANCE:
                    case SMART_TARGET_CLOSEST_CREATURE:
                    case SMART_TARGET_CLOSEST_PLAYER:
                    case SMART_TARGET_PLAYER_RANGE:
                    case SMART_TARGET_PLAYER_DISTANCE:
                        break;
                    case SMART_TARGET_SELF:
                    case SMART_TARGET_ACTION_INVOKER:
                        if (!NotNULL(e, e.event.friendlyHealthPct.radius))
                        {
                            return false;
                        }
                        break;
                    default:
                        LOG_ERROR("sql.sql", "SmartAIMgr: Entry {} SourceType {} Event {} Action {} uses invalid target_type {}, skipped.", e.entryOrGuid, e.GetScriptType(), e.event_id, e.GetActionType(), e.GetTargetType());
                        return false;
                }
                break;
            case SMART_EVENT_DISTANCE_CREATURE:
                if (e.event.distance.guid == 0 && e.event.distance.entry == 0)
                {
                    LOG_ERROR("sql.sql", "SmartAIMgr: Event SMART_EVENT_DISTANCE_CREATURE did not provide creature guid or entry, skipped.");
                    return false;
                }

                if (e.event.distance.guid != 0 && e.event.distance.entry != 0)
                {
                    LOG_ERROR("sql.sql", "SmartAIMgr: Event SMART_EVENT_DISTANCE_CREATURE provided both an entry and guid, skipped.");
                    return false;
                }

                if (e.event.distance.guid != 0 && !sObjectMgr->GetCreatureData(e.event.distance.guid))
                {
                    LOG_ERROR("sql.sql", "SmartAIMgr: Event SMART_EVENT_DISTANCE_CREATURE using invalid creature guid {}, skipped.", e.event.distance.guid);
                    return false;
                }

                if (e.event.distance.entry != 0 && !sObjectMgr->GetCreatureTemplate(e.event.distance.entry))
                {
                    LOG_ERROR("sql.sql", "SmartAIMgr: Event SMART_EVENT_DISTANCE_CREATURE using invalid creature entry {}, skipped.", e.event.distance.entry);
                    return false;
                }
                break;
            case SMART_EVENT_DISTANCE_GAMEOBJECT:
                if (e.event.distance.guid == 0 && e.event.distance.entry == 0)
                {
                    LOG_ERROR("sql.sql", "SmartAIMgr: Event SMART_EVENT_DISTANCE_GAMEOBJECT did not provide gameobject guid or entry, skipped.");
                    return false;
                }

                if (e.event.distance.guid != 0 && e.event.distance.entry != 0)
                {
                    LOG_ERROR("sql.sql", "SmartAIMgr: Event SMART_EVENT_DISTANCE_GAMEOBJECT provided both an entry and guid, skipped.");
                    return false;
                }

                if (e.event.distance.guid != 0 && !sObjectMgr->GetGameObjectData(e.event.distance.guid))
                {
                    LOG_ERROR("sql.sql", "SmartAIMgr: Event SMART_EVENT_DISTANCE_GAMEOBJECT using invalid gameobject guid {}, skipped.", e.event.distance.guid);
                    return false;
                }

                if (e.event.distance.entry != 0 && !sObjectMgr->GetGameObjectTemplate(e.event.distance.entry))
                {
                    LOG_ERROR("sql.sql", "SmartAIMgr: Event SMART_EVENT_DISTANCE_GAMEOBJECT using invalid gameobject entry {}, skipped.", e.event.distance.entry);
                    return false;
                }
                break;
            case SMART_EVENT_COUNTER_SET:
                if (!IsMinMaxValid(e, e.event.counter.cooldownMin, e.event.counter.cooldownMax))
                    return false;

                if (e.event.counter.id == 0)
                {
                    LOG_ERROR("sql.sql", "SmartAIMgr: Event SMART_EVENT_COUNTER_SET using invalid counter id {}, skipped.", e.event.counter.id);
                    return false;
                }

                if (e.event.counter.value == 0)
                {
                    LOG_ERROR("sql.sql", "SmartAIMgr: Event SMART_EVENT_COUNTER_SET using invalid value {}, skipped.", e.event.counter.value);
                    return false;
                }
                break;
            case SMART_EVENT_NEAR_PLAYERS:
                if (!IsMinMaxValid(e, e.event.nearPlayer.repeatMin, e.event.nearPlayer.repeatMax))
                    return false;
                break;
            case SMART_EVENT_NEAR_PLAYERS_NEGATION:
                if (!IsMinMaxValid(e, e.event.nearPlayerNegation.repeatMin, e.event.nearPlayerNegation.repeatMax))
                    return false;
                break;
            case SMART_EVENT_CHARMED:
            case SMART_EVENT_GO_STATE_CHANGED:
            case SMART_EVENT_GO_EVENT_INFORM:
            case SMART_EVENT_NEAR_UNIT:
            case SMART_EVENT_NEAR_UNIT_NEGATION:
            case SMART_EVENT_TIMED_EVENT_TRIGGERED:
            case SMART_EVENT_INSTANCE_PLAYER_ENTER:
            case SMART_EVENT_TRANSPORT_RELOCATE:
            case SMART_EVENT_CHARMED_TARGET:
            case SMART_EVENT_CORPSE_REMOVED:
            case SMART_EVENT_AI_INIT:
            case SMART_EVENT_TRANSPORT_ADDPLAYER:
            case SMART_EVENT_TRANSPORT_REMOVE_PLAYER:
            case SMART_EVENT_AGGRO:
            case SMART_EVENT_DEATH:
            case SMART_EVENT_EVADE:
            case SMART_EVENT_REACHED_HOME:
            case SMART_EVENT_RESET:
            case SMART_EVENT_QUEST_ACCEPTED:
            case SMART_EVENT_QUEST_OBJ_COMPLETION:
            case SMART_EVENT_QUEST_COMPLETION:
            case SMART_EVENT_QUEST_REWARDED:
            case SMART_EVENT_QUEST_FAIL:
            case SMART_EVENT_JUST_SUMMONED:
            case SMART_EVENT_ESCORT_START:
            case SMART_EVENT_ESCORT_REACHED:
            case SMART_EVENT_ESCORT_PAUSED:
            case SMART_EVENT_ESCORT_RESUMED:
            case SMART_EVENT_ESCORT_STOPPED:
            case SMART_EVENT_ESCORT_ENDED:
            case SMART_EVENT_GOSSIP_SELECT:
            case SMART_EVENT_GOSSIP_HELLO:
            case SMART_EVENT_JUST_CREATED:
            case SMART_EVENT_FOLLOW_COMPLETED:
            case SMART_EVENT_ON_SPELLCLICK:
            case SMART_EVENT_WAYPOINT_REACHED:
            case SMART_EVENT_WAYPOINT_ENDED:
                break;
            default:
                LOG_ERROR("sql.sql", "SmartAIMgr: Not handled event_type({}), Entry {} SourceType {} Event {} Action {}, skipped.", e.GetEventType(), e.entryOrGuid, e.GetScriptType(), e.event_id, e.GetActionType());
                return false;
        }
    }

    if (!CheckUnusedEventParams(e))
    {
        return false;
    }

    switch (e.GetActionType())
    {
        case SMART_ACTION_SET_FACTION:
            if (e.action.faction.factionID && !sFactionTemplateStore.LookupEntry(e.action.faction.factionID))
            {
                LOG_ERROR("sql.sql", "SmartAIMgr: Entry {} SourceType {} Event {} Action {} uses non-existent Faction {}, skipped.", e.entryOrGuid, e.GetScriptType(), e.event_id, e.GetActionType(), e.action.faction.factionID);
                return false;
            }
            break;
        case SMART_ACTION_MORPH_TO_ENTRY_OR_MODEL:
        case SMART_ACTION_MOUNT_TO_ENTRY_OR_MODEL:
            if (e.action.morphOrMount.creature || e.action.morphOrMount.model)
            {
                if (e.action.morphOrMount.creature > 0 && !sObjectMgr->GetCreatureTemplate(e.action.morphOrMount.creature))
                {
                    LOG_ERROR("sql.sql", "SmartAIMgr: Entry {} SourceType {} Event {} Action {} uses non-existent Creature entry {}, skipped.", e.entryOrGuid, e.GetScriptType(), e.event_id, e.GetActionType(), e.action.morphOrMount.creature);
                    return false;
                }

                if (e.action.morphOrMount.model)
                {
                    if (e.action.morphOrMount.creature)
                    {
                        LOG_ERROR("sql.sql", "SmartAIMgr: Entry {} SourceType {} Event {} Action {} has ModelID set with also set CreatureId, skipped.", e.entryOrGuid, e.GetScriptType(), e.event_id, e.GetActionType());
                        return false;
                    }
                    else if (!sCreatureDisplayInfoStore.LookupEntry(e.action.morphOrMount.model))
                    {
                        LOG_ERROR("sql.sql", "SmartAIMgr: Entry {} SourceType {} Event {} Action {} uses non-existent Model id {}, skipped.", e.entryOrGuid, e.GetScriptType(), e.event_id, e.GetActionType(), e.action.morphOrMount.model);
                        return false;
                    }
                }
            }
            break;
        case SMART_ACTION_SOUND:
            if (!IsSoundValid(e, e.action.sound.sound))
                return false;
            return IsSAIBoolValid(e, e.action.sound.onlySelf);
        case SMART_ACTION_RANDOM_SOUND:
            if (e.action.randomSound.sound1 && !IsSoundValid(e, e.action.randomSound.sound1))
                return false;

            if (e.action.randomSound.sound2 && !IsSoundValid(e, e.action.randomSound.sound2))
                return false;

            if (e.action.randomSound.sound3 && !IsSoundValid(e, e.action.randomSound.sound3))
                return false;

            if (e.action.randomSound.sound4 && !IsSoundValid(e, e.action.randomSound.sound4))
                return false;
            break;
        case SMART_ACTION_MUSIC:
            if (!IsSoundValid(e, e.action.music.sound))
                return false;
            break;
        case SMART_ACTION_RANDOM_MUSIC:
            if (e.action.randomMusic.sound1 && !IsSoundValid(e, e.action.randomMusic.sound1))
                return false;

            if (e.action.randomMusic.sound2 && !IsSoundValid(e, e.action.randomMusic.sound2))
                return false;

            if (e.action.randomMusic.sound3 && !IsSoundValid(e, e.action.randomMusic.sound3))
                return false;

            if (e.action.randomMusic.sound4 && !IsSoundValid(e, e.action.randomMusic.sound4))
                return false;
            break;
        case SMART_ACTION_SET_EMOTE_STATE:
        case SMART_ACTION_PLAY_EMOTE:
            if (!IsEmoteValid(e, e.action.emote.emote))
                return false;
            break;
        case SMART_ACTION_OFFER_QUEST:
            if (!IsQuestValid(e, e.action.questOffer.questID))
                return false;

            return IsSAIBoolValid(e, e.action.questOffer.directAdd);
        case SMART_ACTION_FAIL_QUEST:
            if (!IsQuestValid(e, e.action.quest.quest))
                return false;
            break;
        case SMART_ACTION_ACTIVATE_TAXI:
            {
                if (!sTaxiPathStore.LookupEntry(e.action.taxi.id))
                {
                    LOG_ERROR("sql.sql", "SmartAIMgr: Entry {} SourceType {} Event {} Action {} uses invalid Taxi path ID {}, skipped.", e.entryOrGuid, e.GetScriptType(), e.event_id, e.GetActionType(), e.action.taxi.id);
                    return false;
                }
                break;
            }
        case SMART_ACTION_RANDOM_EMOTE:
            {
                if (std::all_of(e.action.randomEmote.emotes.begin(), e.action.randomEmote.emotes.end(), [](uint32 emote) { return emote == 0; }))
                {
                    LOG_ERROR("sql.sql", "SmartAIMgr: Entry {} SourceType {} Event {} Action {} does not have any non-zero emote",
                              e.entryOrGuid, e.GetScriptType(), e.event_id, e.GetActionType());
                    return false;
                }

                for (uint32 emote : e.action.randomEmote.emotes)
                    if (emote && !IsEmoteValid(e, emote))
                        return false;
                break;
        }
        case SMART_ACTION_CALL_RANDOM_TIMED_ACTIONLIST:
            {
                if (std::all_of(e.action.randTimedActionList.actionLists.begin(), e.action.randTimedActionList.actionLists.end(), [](uint32 actionList) { return actionList == 0; }))
                {
                    LOG_ERROR("sql.sql", "SmartAIMgr: Entry {} SourceType {} Event {} Action {} does not have any non-zero action list",
                                 e.entryOrGuid, e.GetScriptType(), e.event_id, e.GetActionType());
                    return false;
                }
                break;
            }
        case SMART_ACTION_START_CLOSEST_WAYPOINT:
        {
            if (e.action.startClosestWaypoint.pathId1 == 0 || e.action.startClosestWaypoint.pathId2 == 0 || e.action.startClosestWaypoint.pathId2 < e.action.startClosestWaypoint.pathId1)
            {
                LOG_ERROR("sql.sql", "SmartAIMgr: Entry {} SourceType {} Event {} Action {} has invalid pathId1 or pathId2, it must be greater than 0 and pathId1 > pathId2",
                    e.entryOrGuid, e.GetScriptType(), e.event_id, e.GetActionType());
                return false;
            }
            if (e.action.startClosestWaypoint.repeat > 1 || e.action.startClosestWaypoint.forcedMovement >= FORCED_MOVEMENT_MAX)
            {
                LOG_ERROR("sql.sql", "SmartAIMgr: Entry {} SourceType {} Event {} Action {} has invalid forcedMovement ({}) or repeat ({}) parameter, must be 0 or 1.",
                    e.entryOrGuid, e.GetScriptType(), e.event_id, e.GetActionType(),
                    e.action.startClosestWaypoint.repeat, e.action.startClosestWaypoint.forcedMovement);
                return false;
            }
            break;
        }
        case SMART_ACTION_INVOKER_CAST:
            if (e.GetScriptType() != SMART_SCRIPT_TYPE_TIMED_ACTIONLIST && e.GetEventType() != SMART_EVENT_LINK && !EventHasInvoker(e.event.type))
            {
                LOG_ERROR("sql.sql", "SmartAIMgr: Entry {} SourceType {} Event {} Action {} has invoker cast action, but event does not provide any invoker!", e.entryOrGuid, e.GetScriptType(), e.GetEventType(), e.GetActionType());
                return false;
            }
            break;
        case SMART_ACTION_CAST:
        case SMART_ACTION_CROSS_CAST:
            if (!IsSpellValid(e, e.action.crossCast.spell))
                return false;
            break;
        case SMART_ACTION_CUSTOM_CAST:
            if (!IsSpellValid(e, e.action.castCustom.spell))
                return false;
            break;
        case SMART_ACTION_ADD_AURA:
            if (!IsSpellValid(e, e.action.addAura.spell))
                return false;
            break;
        case SMART_ACTION_CALL_AREAEXPLOREDOREVENTHAPPENS:
        case SMART_ACTION_CALL_GROUPEVENTHAPPENS:
            if (Quest const* qid = sObjectMgr->GetQuestTemplate(e.action.quest.quest))
            {
                if (!qid->HasSpecialFlag(QUEST_SPECIAL_FLAGS_EXPLORATION_OR_EVENT))
                {
                    LOG_ERROR("sql.sql", "SmartAIMgr: Entry {} SourceType {} Event {} Action {} SpecialFlags for Quest entry {} does not include FLAGS_EXPLORATION_OR_EVENT(2), skipped.", e.entryOrGuid, e.GetScriptType(), e.event_id, e.GetActionType(), e.action.quest.quest);
                    return false;
                }
            }
            else
            {
                LOG_ERROR("sql.sql", "SmartAIMgr: Entry {} SourceType {} Event {} Action {} uses non-existent Quest entry {}, skipped.", e.entryOrGuid, e.GetScriptType(), e.event_id, e.GetActionType(), e.action.quest.quest);
                return false;
            }
            break;
        case SMART_ACTION_SET_EVENT_PHASE:
            if (e.action.setEventPhase.phase >= SMART_EVENT_PHASE_MAX)
            {
                LOG_ERROR("sql.sql", "SmartAIMgr: Entry {} SourceType {} Event {} Action {} attempts to set phase {}. Phase mask cannot be used past phase {}, skipped.", e.entryOrGuid, e.GetScriptType(), e.event_id, e.GetActionType(), e.action.setEventPhase.phase, SMART_EVENT_PHASE_MAX - 1);
                return false;
            }
            break;
        case SMART_ACTION_INC_EVENT_PHASE:
            if (!e.action.incEventPhase.inc && !e.action.incEventPhase.dec)
            {
                LOG_ERROR("sql.sql", "SmartAIMgr: Entry {} SourceType {} Event {} Action {} is incrementing phase by 0, skipped.", e.entryOrGuid, e.GetScriptType(), e.event_id, e.GetActionType());
                return false;
            }
            else if (e.action.incEventPhase.inc > SMART_EVENT_PHASE_MAX || e.action.incEventPhase.dec > SMART_EVENT_PHASE_MAX)
            {
                LOG_ERROR("sql.sql", "SmartAIMgr: Entry {} SourceType {} Event {} Action {} attempts to increment phase by too large value, skipped.", e.entryOrGuid, e.GetScriptType(), e.event_id, e.GetActionType());
                return false;
            }
            break;
        case SMART_ACTION_REMOVEAURASFROMSPELL:
            if (e.action.removeAura.spell != 0 && !IsSpellValid(e, e.action.removeAura.spell))
                return false;
            break;
        case SMART_ACTION_RANDOM_PHASE:
            {
                if (std::all_of(e.action.randomPhase.phases.begin(), e.action.randomPhase.phases.end(), [](uint32 phase) { return phase == 0; }))
                {
                    LOG_ERROR("sql.sql", "SmartAIMgr: Entry {} SourceType {} Event {} Action {} does not have any non-zero phase",
                                 e.entryOrGuid, e.GetScriptType(), e.event_id, e.GetActionType());
                    return false;
                }

                if (std::any_of(e.action.randomPhase.phases.begin(), e.action.randomPhase.phases.end(), [](uint32 phase) { return phase >= SMART_EVENT_PHASE_MAX; }))
                {
                    LOG_ERROR("sql.sql", "SmartAIMgr: Entry {} SourceType {} Event {} Action {} attempts to set invalid phase, skipped.", e.entryOrGuid, e.GetScriptType(), e.event_id, e.GetActionType());
                    return false;
                }
                break;
            }
        case SMART_ACTION_RANDOM_PHASE_RANGE:       //PhaseMin, PhaseMax
            {
                if (e.action.randomPhaseRange.phaseMin >= SMART_EVENT_PHASE_MAX ||
                    e.action.randomPhaseRange.phaseMax >= SMART_EVENT_PHASE_MAX)
                {
                    LOG_ERROR("sql.sql", "SmartAIMgr: Entry {} SourceType {} Event {} Action {} attempts to set invalid phase, skipped.", e.entryOrGuid, e.GetScriptType(), e.event_id, e.GetActionType());
                    return false;
                }

                if (!IsMinMaxValid(e, e.action.randomPhaseRange.phaseMin, e.action.randomPhaseRange.phaseMax))
                    return false;
                break;
            }
        case SMART_ACTION_SUMMON_CREATURE:
            if (!IsCreatureValid(e, e.action.summonCreature.creature))
                return false;
            if (e.action.summonCreature.type < TEMPSUMMON_TIMED_OR_DEAD_DESPAWN || e.action.summonCreature.type > TEMPSUMMON_MANUAL_DESPAWN)
            {
                LOG_ERROR("sql.sql", "SmartAIMgr: Entry {} SourceType {} Event {} Action {} uses incorrect TempSummonType {}, skipped.", e.entryOrGuid, e.GetScriptType(), e.event_id, e.GetActionType(), e.action.summonCreature.type);
                return false;
            }

            return IsSAIBoolValid(e, e.action.summonCreature.attackInvoker);
        case SMART_ACTION_CALL_KILLEDMONSTER:
            if (!IsCreatureValid(e, e.action.killedMonster.creature))
                return false;
            break;
        case SMART_ACTION_UPDATE_TEMPLATE:
            if (!IsCreatureValid(e, e.action.updateTemplate.creature))
                return false;
            return IsSAIBoolValid(e, e.action.updateTemplate.updateLevel);
        case SMART_ACTION_SET_SHEATH:
            if (e.action.setSheath.sheath && e.action.setSheath.sheath >= MAX_SHEATH_STATE)
            {
                LOG_ERROR("sql.sql", "SmartAIMgr: Entry {} SourceType {} Event {} Action {} uses incorrect Sheath state {}, skipped.", e.entryOrGuid, e.GetScriptType(), e.event_id, e.GetActionType(), e.action.setSheath.sheath);
                return false;
            }
            break;
        case SMART_ACTION_SET_REACT_STATE:
            {
                if (e.action.react.state > REACT_AGGRESSIVE)
                {
                    LOG_ERROR("sql.sql", "SmartAIMgr: Creature {} Event {} Action {} uses invalid React State {}, skipped.", e.entryOrGuid, e.event_id, e.GetActionType(), e.action.react.state);
                    return false;
                }
                break;
            }
        case SMART_ACTION_SUMMON_GO:
            if (!IsGameObjectValid(e, e.action.summonGO.entry))
                return false;
            break;
        case SMART_ACTION_ADD_ITEM:
        case SMART_ACTION_REMOVE_ITEM:
            if (!IsItemValid(e, e.action.item.entry))
                return false;

            if (!NotNULL(e, e.action.item.count))
                return false;
            break;
        case SMART_ACTION_TELEPORT:
            if (!sMapStore.LookupEntry(e.action.teleport.mapID))
            {
                LOG_ERROR("sql.sql", "SmartAIMgr: Entry {} SourceType {} Event {} Action {} uses non-existent Map entry {}, skipped.", e.entryOrGuid, e.GetScriptType(), e.event_id, e.GetActionType(), e.action.teleport.mapID);
                return false;
            }
            break;
        case SMART_ACTION_INSTALL_AI_TEMPLATE:
            if (e.action.installTtemplate.id >= SMARTAI_TEMPLATE_END)
            {
                LOG_ERROR("sql.sql", "SmartAIMgr: Creature {} Event {} Action {} uses non-existent AI template id {}, skipped.", e.entryOrGuid, e.event_id, e.GetActionType(), e.action.installTtemplate.id);
                return false;
            }
            break;
        case SMART_ACTION_ESCORT_STOP:
            if (e.action.wpStop.quest && !IsQuestValid(e, e.action.wpStop.quest))
                return false;
            return IsSAIBoolValid(e, e.action.wpStop.fail);
        case SMART_ACTION_ESCORT_START:
            {
                if (!sSmartWaypointMgr->GetPath(e.action.wpStart.pathID))
                {
                    LOG_ERROR("sql.sql", "SmartAIMgr: Creature {} Event {} Action {} uses non-existent WaypointPath id {}, skipped.", e.entryOrGuid, e.event_id, e.GetActionType(), e.action.wpStart.pathID);
                    return false;
                }
                if (e.action.wpStart.quest && !IsQuestValid(e, e.action.wpStart.quest))
                    return false;

                // Allow "invalid" value 3 for a while to allow cleanup the values stored in the db for SMART_ACTION_WP_START.
                // Remember to remove this once the clean is complete.
                constexpr uint32 TEMPORARY_EXTRA_VALUE_FOR_DB_CLEANUP = 1;

                if (e.action.wpStart.reactState > (REACT_AGGRESSIVE + TEMPORARY_EXTRA_VALUE_FOR_DB_CLEANUP))
                {
                    LOG_ERROR("sql.sql", "SmartAIMgr: Creature {} Event {} Action {} uses invalid React State {}, skipped.", e.entryOrGuid, e.event_id, e.GetActionType(), e.action.wpStart.reactState);
                    return false;
                }

                if (e.action.wpStart.forcedMovement >= FORCED_MOVEMENT_MAX)
                {
                    LOG_ERROR("sql.sql", "SmartAIMgr: Creature {} Event {} Action {} uses invalid forcedMovement {}, skipped.", e.entryOrGuid, e.event_id, e.GetActionType(), e.action.wpStart.forcedMovement);
                    return false;
                }

                return IsSAIBoolValid(e, e.action.wpStart.repeat);
            }
        case SMART_ACTION_CREATE_TIMED_EVENT:
            {
                if (!IsMinMaxValid(e, e.action.timeEvent.min, e.action.timeEvent.max))
                    return false;

                if (!IsMinMaxValid(e, e.action.timeEvent.repeatMin, e.action.timeEvent.repeatMax))
                    return false;
                break;
            }
        case SMART_ACTION_CALL_RANDOM_RANGE_TIMED_ACTIONLIST:
            {
                if (!IsMinMaxValid(e, e.action.randTimedActionList.actionLists[0], e.action.randTimedActionList.actionLists[1]))
                    return false;
                break;
            }
        case SMART_ACTION_SET_POWER:
        case SMART_ACTION_ADD_POWER:
        case SMART_ACTION_REMOVE_POWER:
            if (e.action.power.powerType > MAX_POWERS)
            {
                LOG_ERROR("scripts.ai.sai", "SmartAIMgr: Entry {} SourceType {} Event {} Action {} uses non-existent Power {}, skipped.", e.entryOrGuid, e.GetScriptType(), e.event_id, e.GetActionType(), e.action.power.powerType);
                return false;
            }
            break;
        case SMART_ACTION_GAME_EVENT_STOP:
            {
                uint32 eventId = e.action.gameEventStop.id;

                GameEventMgr::GameEventDataMap const& events = sGameEventMgr->GetEventMap();
                if (eventId < 1 || eventId >= events.size())
                {
                    LOG_ERROR("scripts.ai.sai", "SmartAIMgr: Entry {} SourceType {} Event {} Action {} uses non-existent event, eventId {}, skipped.", e.entryOrGuid, e.GetScriptType(), e.event_id, e.GetActionType(), e.action.gameEventStop.id);
                    return false;
                }

                GameEventData const& eventData = events[eventId];
                if (!eventData.isValid())
                {
                    LOG_ERROR("scripts.ai.sai", "SmartAIMgr: Entry {} SourceType {} Event {} Action {} uses non-existent event, eventId {}, skipped.", e.entryOrGuid, e.GetScriptType(), e.event_id, e.GetActionType(), e.action.gameEventStop.id);
                    return false;
                }
                break;
            }
        case SMART_ACTION_GAME_EVENT_START:
            {
                uint32 eventId = e.action.gameEventStart.id;

                GameEventMgr::GameEventDataMap const& events = sGameEventMgr->GetEventMap();
                if (eventId < 1 || eventId >= events.size())
                {
                    LOG_ERROR("scripts.ai.sai", "SmartAIMgr: Entry {} SourceType {} Event {} Action {} uses non-existent event, eventId {}, skipped.", e.entryOrGuid, e.GetScriptType(), e.event_id, e.GetActionType(), e.action.gameEventStart.id);
                    return false;
                }

                GameEventData const& eventData = events[eventId];
                if (!eventData.isValid())
                {
                    LOG_ERROR("scripts.ai.sai", "SmartAIMgr: Entry {} SourceType {} Event {} Action {} uses non-existent event, eventId {}, skipped.", e.entryOrGuid, e.GetScriptType(), e.event_id, e.GetActionType(), e.action.gameEventStart.id);
                    return false;
                }
                break;
            }
        case SMART_ACTION_EQUIP:
            {
                if (e.GetScriptType() == SMART_SCRIPT_TYPE_CREATURE)
                {
                    if (int8 equipId = static_cast<int8>(e.action.equip.entry))
                    {
                        EquipmentInfo const* eInfo = sObjectMgr->GetEquipmentInfo(e.entryOrGuid, equipId);
                        if (!eInfo)
                        {
                            LOG_ERROR("scripts.ai.sai", "SmartScript: SMART_ACTION_EQUIP uses non-existent equipment info id {} for creature {}, skipped.", equipId, e.entryOrGuid);
                            return false;
                        }
                    }
                }
                break;
            }
        case SMART_ACTION_LOAD_GRID:
            {
                if (!Acore::IsValidMapCoord(e.target.x, e.target.y))
                {
                    LOG_ERROR("scripts.ai.sai", "SmartScript: SMART_ACTION_LOAD_GRID uses invalid map coords: {}, skipped.", e.entryOrGuid);
                    return false;
                }
                break;
            }
        case SMART_ACTION_SET_IN_COMBAT_WITH_ZONE:
            {
                if (e.GetScriptType() == SMART_SCRIPT_TYPE_GAMEOBJECT)
                {
                    LOG_ERROR("sql.sql", "SmartScript: action_type {} is not allowed with source_type {}. Entry {}, skipped.", e.GetActionType(), e.GetScriptType(), e.entryOrGuid);
                    return false;
                }
                break;
            }
        case SMART_ACTION_SET_INST_DATA:
            {
                if (e.action.setInstanceData.type == 1)
                {
                    if (e.action.setInstanceData.data >= EncounterState::TO_BE_DECIDED)
                    {
                        LOG_ERROR("sql.sql", "SmartScript: SMART_ACTION_SET_INST_DATA with type 1 (bossState) uses invalid encounter state {}. Source entry {}, type {}", e.action.setInstanceData.data, e.entryOrGuid, e.GetScriptType());
                        return false;
                    }
                }
                else if (e.action.setInstanceData.type > 1)
                {
                    LOG_ERROR("sql.sql", "SmartScript: SMART_ACTION_SET_INST_DATA uses unsupported data type {}. Source entry {}, type {}", e.action.setInstanceData.type, e.entryOrGuid, e.GetScriptType());
                    return false;
                }
                break;
            }
        case SMART_ACTION_SET_HEALTH_PCT:
            {
                if (e.action.setHealthPct.percent > 100 || !e.action.setHealthPct.percent)
                {
                    LOG_ERROR("sql.sql", "SmartAIMgr: Entry {} SourceType {} Event {} Action {} is trying to set invalid HP percent {}, skipped.",
                                 e.entryOrGuid, e.GetScriptType(), e.event_id, e.GetActionType(), e.action.setHealthPct.percent);
                    return false;
                }
                break;
            }
        case SMART_ACTION_SET_MOVEMENT_SPEED:
            {
                if (e.action.movementSpeed.movementType >= MAX_MOVE_TYPE)
                {
                    LOG_ERROR("sql.sql", "SmartAIMgr: Entry {} SourceType {} Event {} Action {} uses invalid movementType {}, skipped.", e.entryOrGuid, e.GetScriptType(), e.event_id, e.GetActionType(), e.action.movementSpeed.movementType);
                    return false;
                }

                if (!e.action.movementSpeed.speedInteger && !e.action.movementSpeed.speedFraction)
                {
                    LOG_ERROR("sql.sql", "SmartAIMgr: Entry {} SourceType {} Event {} Action {} uses speed 0, skipped.", e.entryOrGuid, e.GetScriptType(), e.event_id, e.GetActionType());
                    return false;
                }
                break;
            }
        case SMART_ACTION_SET_ANIM_TIER:
            if (e.action.animTier.animTier >= uint32(AnimTier::Max))
            {
                LOG_ERROR("sql.sql", "SmartAIMgr: Entry {} SourceType {} Event {} Action {} uses invalid animtier %u, skipped.", e.entryOrGuid, e.GetScriptType(), e.event_id, e.GetActionType(), e.action.animTier.animTier);
                return false;
            }
            break;
        case SMART_ACTION_AUTO_ATTACK:
            return IsSAIBoolValid(e, e.action.autoAttack.attack);
        case SMART_ACTION_ALLOW_COMBAT_MOVEMENT:
            return IsSAIBoolValid(e, e.action.combatMove.move);
        case SMART_ACTION_CALL_FOR_HELP:
            return IsSAIBoolValid(e, e.action.callHelp.withEmote);
        case SMART_ACTION_SET_VISIBILITY:
            return IsSAIBoolValid(e, e.action.visibility.state);
        case SMART_ACTION_SET_RUN:
            return IsSAIBoolValid(e, e.action.setRun.run);
        case SMART_ACTION_SET_CAN_FLY:
            return IsSAIBoolValid(e, e.action.setFly.fly);
        case SMART_ACTION_SET_SWIM:
            return IsSAIBoolValid(e, e.action.setSwim.swim);
        case SMART_ACTION_SET_COUNTER:
            return IsSAIBoolValid(e, e.action.setCounter.reset);
        case SMART_ACTION_INTERRUPT_SPELL:
            return IsSAIBoolValid(e, e.action.interruptSpellCasting.withDelayed) &&
                   IsSAIBoolValid(e, e.action.interruptSpellCasting.withInstant);
        case SMART_ACTION_SET_ROOT:
            return IsSAIBoolValid(e, e.action.setRoot.root);
        case SMART_ACTION_DISABLE_EVADE:
            return IsSAIBoolValid(e, e.action.disableEvade.disable);
        case SMART_ACTION_LOAD_EQUIPMENT:
            return IsSAIBoolValid(e, e.action.loadEquipment.force);
        case SMART_ACTION_TALK:
            if (!IsTextValid(e, e.action.talk.textGroupID))
                return false;
            return IsSAIBoolValid(e, e.action.talk.useTalkTarget);
        case SMART_ACTION_SIMPLE_TALK:
            if (!IsTextValid(e, e.action.simpleTalk.textGroupID))
                return false;
            break;
        case SMART_ACTION_SET_HEALTH_REGEN:
            return IsSAIBoolValid(e, e.action.setHealthRegen.regenHealth);
        case SMART_ACTION_CALL_TIMED_ACTIONLIST:
            return IsSAIBoolValid(e, e.action.timedActionList.allowOverride);
        case SMART_ACTION_DISABLE_REWARD:
            return IsSAIBoolValid(e, e.action.reward.reputation) &&
                   IsSAIBoolValid(e, e.action.reward.loot);
        case SMART_ACTION_FLEE_FOR_ASSIST:
        case SMART_ACTION_MOVE_TO_POS:
        case SMART_ACTION_EVADE:
        case SMART_ACTION_SET_ACTIVE:
        case SMART_ACTION_FOLLOW:
        case SMART_ACTION_SET_ORIENTATION:
        case SMART_ACTION_STORE_TARGET_LIST:
        case SMART_ACTION_COMBAT_STOP:
        case SMART_ACTION_DIE:
        case SMART_ACTION_ESCORT_RESUME:
        case SMART_ACTION_KILL_UNIT:
        case SMART_ACTION_SET_INVINCIBILITY_HP_LEVEL:
        case SMART_ACTION_RESET_GOBJECT:
        case SMART_ACTION_ATTACK_START:
        case SMART_ACTION_THREAT_ALL_PCT:
        case SMART_ACTION_THREAT_SINGLE_PCT:
        case SMART_ACTION_SET_INST_DATA64:
        case SMART_ACTION_SET_DATA:
        case SMART_ACTION_MOVE_FORWARD:
        case SMART_ACTION_ESCORT_PAUSE:
        case SMART_ACTION_SET_FLY:
        case SMART_ACTION_FORCE_DESPAWN:
        case SMART_ACTION_SET_INGAME_PHASE_MASK:
        case SMART_ACTION_SET_UNIT_FLAG:
        case SMART_ACTION_REMOVE_UNIT_FLAG:
        case SMART_ACTION_PLAYMOVIE:
        case SMART_ACTION_RESPAWN_TARGET:
        case SMART_ACTION_CLOSE_GOSSIP:
        case SMART_ACTION_TRIGGER_TIMED_EVENT:
        case SMART_ACTION_REMOVE_TIMED_EVENT:
        case SMART_ACTION_OVERRIDE_SCRIPT_BASE_OBJECT:
        case SMART_ACTION_RESET_SCRIPT_BASE_OBJECT:
        case SMART_ACTION_ACTIVATE_GOBJECT:
        case SMART_ACTION_CALL_SCRIPT_RESET:
        case SMART_ACTION_SET_RANGED_MOVEMENT:
        case SMART_ACTION_SET_NPC_FLAG:
        case SMART_ACTION_ADD_NPC_FLAG:
        case SMART_ACTION_REMOVE_NPC_FLAG:
        case SMART_ACTION_RANDOM_MOVE:
        case SMART_ACTION_SET_UNIT_FIELD_BYTES_1:
        case SMART_ACTION_REMOVE_UNIT_FIELD_BYTES_1:
        case SMART_ACTION_SEND_GO_CUSTOM_ANIM:
        case SMART_ACTION_SET_DYNAMIC_FLAG:
        case SMART_ACTION_ADD_DYNAMIC_FLAG:
        case SMART_ACTION_REMOVE_DYNAMIC_FLAG:
        case SMART_ACTION_JUMP_TO_POS:
        case SMART_ACTION_SEND_GOSSIP_MENU:
        case SMART_ACTION_GO_SET_LOOT_STATE:
        case SMART_ACTION_GO_SET_GO_STATE:
        case SMART_ACTION_SEND_TARGET_TO_TARGET:
        case SMART_ACTION_SET_HOME_POS:
        case SMART_ACTION_SET_GO_FLAG:
        case SMART_ACTION_ADD_GO_FLAG:
        case SMART_ACTION_REMOVE_GO_FLAG:
        case SMART_ACTION_SUMMON_CREATURE_GROUP:
        case SMART_ACTION_RISE_UP:
        case SMART_ACTION_MOVE_TO_POS_TARGET:
        case SMART_ACTION_EXIT_VEHICLE:
        case SMART_ACTION_SET_UNIT_MOVEMENT_FLAGS:
        case SMART_ACTION_SET_COMBAT_DISTANCE:
        case SMART_ACTION_SET_SIGHT_DIST:
        case SMART_ACTION_FLEE:
        case SMART_ACTION_ADD_THREAT:
        case SMART_ACTION_TRIGGER_RANDOM_TIMED_EVENT:
        case SMART_ACTION_DISMOUNT:
        case SMART_ACTION_SET_HOVER:
        case SMART_ACTION_ADD_IMMUNITY:
        case SMART_ACTION_REMOVE_IMMUNITY:
        case SMART_ACTION_FALL:
        case SMART_ACTION_SET_EVENT_FLAG_RESET:
        case SMART_ACTION_REMOVE_ALL_GAMEOBJECTS:
        case SMART_ACTION_STOP_MOTION:
        case SMART_ACTION_NO_ENVIRONMENT_UPDATE:
        case SMART_ACTION_ZONE_UNDER_ATTACK:
        case SMART_ACTION_CONE_SUMMON:
        case SMART_ACTION_VORTEX_SUMMON:
        case SMART_ACTION_PLAYER_TALK:
        case SMART_ACTION_CU_ENCOUNTER_START:
        case SMART_ACTION_DO_ACTION:
        case SMART_ACTION_SET_CORPSE_DELAY:
        case SMART_ACTION_ATTACK_STOP:
        case SMART_ACTION_PLAY_CINEMATIC:
        case SMART_ACTION_SET_GUID:
        case SMART_ACTION_SCRIPTED_SPAWN:
        case SMART_ACTION_SET_SCALE:
        case SMART_ACTION_SUMMON_RADIAL:
        case SMART_ACTION_PLAY_SPELL_VISUAL:
        case SMART_ACTION_FOLLOW_GROUP:
        case SMART_ACTION_SET_ORIENTATION_TARGET:
        case SMART_ACTION_WAYPOINT_START:
        case SMART_ACTION_WAYPOINT_DATA_RANDOM:
        case SMART_ACTION_MOVEMENT_STOP:
        case SMART_ACTION_MOVEMENT_PAUSE:
        case SMART_ACTION_MOVEMENT_RESUME:
        case SMART_ACTION_WORLD_SCRIPT:
        case SMART_ACTION_SET_GOSSIP_MENU:
            break;
        default:
            LOG_ERROR("sql.sql", "SmartAIMgr: Not handled action_type({}), event_type({}), Entry {} SourceType {} Event {}, skipped.", e.GetActionType(), e.GetEventType(), e.entryOrGuid, e.GetScriptType(), e.event_id);
            return false;
    }

    if (!CheckUnusedActionParams(e))
        return false;

    return true;
}

bool SmartAIMgr::IsTextValid(SmartScriptHolder const& e, uint32 id)
{
    if (e.GetScriptType() != SMART_SCRIPT_TYPE_CREATURE)
        return true;

    uint32 entry = 0;

    if (e.GetEventType() == SMART_EVENT_TEXT_OVER)
    {
        entry = e.event.textOver.creatureEntry;
    }
    else
    {
        switch (e.GetTargetType())
        {
            case SMART_TARGET_CREATURE_DISTANCE:
            case SMART_TARGET_CREATURE_RANGE:
            case SMART_TARGET_CLOSEST_CREATURE:
                return true; // ignore
            default:
                if (e.entryOrGuid < 0)
                {
                    ObjectGuid::LowType guid = ObjectGuid::LowType(-e.entryOrGuid);
                    CreatureData const* data = sObjectMgr->GetCreatureData(guid);
                    if (!data)
                    {
                        LOG_ERROR("sql.sql", "SmartAIMgr: Entry {} SourceType {} Event {} Action {} using non-existent Creature guid {}, skipped.", e.entryOrGuid, e.GetScriptType(), e.event_id, e.GetActionType(), guid);
                        return false;
                    }
                    else
                        entry = data->id1;
                }
                else
                    entry = uint32(e.entryOrGuid);
                break;
        }
    }

    if (!entry || !sCreatureTextMgr->TextExist(entry, uint8(id)))
    {
        LOG_ERROR("sql.sql", "SmartAIMgr: Entry {} SourceType {} Event {} Action {} using non-existent Text id {}, skipped.", e.entryOrGuid, e.GetScriptType(), e.event_id, e.GetActionType(), id);
        return false;
    }

    return true;
}

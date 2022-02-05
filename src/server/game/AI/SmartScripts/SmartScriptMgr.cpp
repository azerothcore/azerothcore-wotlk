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

#include "SmartScriptMgr.h"
#include "CellImpl.h"
#include "DatabaseEnv.h"
#include "GameEventMgr.h"
#include "GridDefines.h"
#include "GridNotifiers.h"
#include "GridNotifiersImpl.h"
#include "InstanceScript.h"
#include "ObjectDefines.h"
#include "ObjectMgr.h"
#include "ScriptedCreature.h"
#include "SpellMgr.h"

#define AC_SAI_IS_BOOLEAN_VALID(e, value) \
{ \
    if (value > 1) \
    { \
        LOG_ERROR("sql.sql", "SmartAIMgr: Entry {} SourceType {} Event {} Action {} uses param {} of type Boolean with value {}, valid values are 0 or 1, skipped.", \
            e.entryOrGuid, e.GetScriptType(), e.event_id, e.GetActionType(), STRINGIZE(value), value); \
        return false; \
    } \
}

SmartWaypointMgr* SmartWaypointMgr::instance()
{
    static SmartWaypointMgr instance;
    return &instance;
}

void SmartWaypointMgr::LoadFromDB()
{
    uint32 oldMSTime = getMSTime();

    for (std::unordered_map<uint32, WPPath*>::iterator itr = waypoint_map.begin(); itr != waypoint_map.end(); ++itr)
    {
        for (WPPath::iterator pathItr = itr->second->begin(); pathItr != itr->second->end(); ++pathItr)
            delete pathItr->second;

        delete itr->second;
    }

    waypoint_map.clear();

    WorldDatabasePreparedStatement* stmt = WorldDatabase.GetPreparedStatement(WORLD_SEL_SMARTAI_WP);
    PreparedQueryResult result = WorldDatabase.Query(stmt);

    if (!result)
    {
        LOG_INFO("server.loading", ">> Loaded 0 SmartAI Waypoint Paths. DB table `waypoints` is empty.");
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
        float x, y, z, o;
        x = fields[2].Get<float>();
        y = fields[3].Get<float>();
        z = fields[4].Get<float>();
        o = fields[5].Get<float>();
        uint32 delay = fields[6].Get<uint32>();

        if (last_entry != entry)
        {
            waypoint_map[entry] = new WPPath();
            last_id = 1;
            count++;
        }

        if (last_id != id)
            LOG_ERROR("sql.sql", "SmartWaypointMgr::LoadFromDB: Path entry {}, unexpected point id {}, expected {}.", entry, id, last_id);

        last_id++;
        (*waypoint_map[entry])[id] = new WayPoint(id, x, y, z, o, delay);

        last_entry = entry;
        total++;
    } while (result->NextRow());

    LOG_INFO("server.loading", ">> Loaded {} SmartAI waypoint paths (total {} waypoints) in {} ms", count, total, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
}

SmartWaypointMgr::~SmartWaypointMgr()
{
    for (std::unordered_map<uint32, WPPath*>::iterator itr = waypoint_map.begin(); itr != waypoint_map.end(); ++itr)
    {
        for (WPPath::iterator pathItr = itr->second->begin(); pathItr != itr->second->end(); ++pathItr)
            delete pathItr->second;

        delete itr->second;
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
        LOG_INFO("server.loading", ">> Loaded 0 SmartAI scripts. DB table `smart_scripts` is empty.");
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
            if (!sObjectMgr->GetCreatureData(uint32(std::abs(temp.entryOrGuid))))
            {
                LOG_ERROR("sql.sql", "SmartAIMgr::LoadSmartAIFromDB: Creature guid ({}) does not exist, skipped loading.", uint32(std::abs(temp.entryOrGuid)));
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

        temp.action.type = (SMART_ACTION)fields[13].Get<uint8>();
        temp.action.raw.param1 = fields[14].Get<uint32>();
        temp.action.raw.param2 = fields[15].Get<uint32>();
        temp.action.raw.param3 = fields[16].Get<uint32>();
        temp.action.raw.param4 = fields[17].Get<uint32>();
        temp.action.raw.param5 = fields[18].Get<uint32>();
        temp.action.raw.param6 = fields[19].Get<uint32>();

        temp.target.type = (SMARTAI_TARGETS)fields[20].Get<uint8>();
        temp.target.raw.param1 = fields[21].Get<uint32>();
        temp.target.raw.param2 = fields[22].Get<uint32>();
        temp.target.raw.param3 = fields[23].Get<uint32>();
        temp.target.raw.param4 = fields[24].Get<uint32>();
        temp.target.x = fields[25].Get<float>();
        temp.target.y = fields[26].Get<float>();
        temp.target.z = fields[27].Get<float>();
        temp.target.o = fields[28].Get<float>();

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
            case SMART_EVENT_RANGE:
            case SMART_EVENT_FRIENDLY_HEALTH:
            case SMART_EVENT_FRIENDLY_HEALTH_PCT:
            case SMART_EVENT_FRIENDLY_MISSING_BUFF:
            case SMART_EVENT_HAS_AURA:
            case SMART_EVENT_TARGET_BUFFED:
                if (temp.event.minMaxRepeat.repeatMin == 0 && temp.event.minMaxRepeat.repeatMax == 0)
                    temp.event.event_flags |= SMART_EVENT_FLAG_NOT_REPEATABLE;
                break;
            case SMART_EVENT_VICTIM_CASTING:
            case SMART_EVENT_IS_BEHIND_TARGET:
                if (temp.event.minMaxRepeat.min == 0 && temp.event.minMaxRepeat.max == 0)
                    temp.event.event_flags |= SMART_EVENT_FLAG_NOT_REPEATABLE;
                break;
            case SMART_EVENT_FRIENDLY_IS_CC:
                if (temp.event.friendlyCC.repeatMin == 0 && temp.event.friendlyCC.repeatMax == 0)
                    temp.event.event_flags |= SMART_EVENT_FLAG_NOT_REPEATABLE;
                break;
            default:
                break;
        }

        // xinef: rozpierdol tc, niedojeby ze szok
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

    LOG_INFO("server.loading", ">> Loaded {} SmartAI scripts in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
}

/*static*/ bool SmartAIMgr::EventHasInvoker(SMART_EVENT event)
{
    switch (event)
    { // white list of events that actually have an invoker passed to them
        case SMART_EVENT_AGGRO:
        case SMART_EVENT_DEATH:
        case SMART_EVENT_KILL:
        case SMART_EVENT_SUMMONED_UNIT:
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
        case SMART_EVENT_VICTIM_CASTING:
        case SMART_EVENT_TARGET_BUFFED:
        case SMART_EVENT_IS_BEHIND_TARGET:
        case SMART_EVENT_INSTANCE_PLAYER_ENTER:
        case SMART_EVENT_TRANSPORT_ADDCREATURE:
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
                LOG_ERROR("sql.sql", "SmartAIMgr: Entry {} SourceType {} Event {} Action {} has invoker target, but action does not provide any invoker!", e.entryOrGuid, e.GetScriptType(), e.GetEventType(), e.GetActionType());
                 return false;
            }
            break;
        case SMART_TARGET_HOSTILE_SECOND_AGGRO:
        case SMART_TARGET_HOSTILE_LAST_AGGRO:
        case SMART_TARGET_HOSTILE_RANDOM:
        case SMART_TARGET_HOSTILE_RANDOM_NOT_TOP:
            AC_SAI_IS_BOOLEAN_VALID(e, e.target.hostilRandom.playerOnly);
            break;
        case SMART_TARGET_FARTHEST:
            AC_SAI_IS_BOOLEAN_VALID(e, e.target.farthest.playerOnly);
            AC_SAI_IS_BOOLEAN_VALID(e, e.target.farthest.isInLos);
            break;
        case SMART_TARGET_CLOSEST_GAMEOBJECT:
        case SMART_TARGET_CLOSEST_CREATURE:
            AC_SAI_IS_BOOLEAN_VALID(e, e.target.closest.dead);
            break;
        case SMART_TARGET_CLOSEST_ENEMY:
            AC_SAI_IS_BOOLEAN_VALID(e, e.target.closestAttackable.playerOnly);
            break;
        case SMART_TARGET_CLOSEST_FRIENDLY:
            AC_SAI_IS_BOOLEAN_VALID(e, e.target.closestFriendly.playerOnly);
            break;
        case SMART_TARGET_OWNER_OR_SUMMONER:
            AC_SAI_IS_BOOLEAN_VALID(e, e.target.owner.useCharmerOrOwner);
            break;
        case SMART_TARGET_STORED:
        case SMART_TARGET_PLAYER_WITH_AURA:
        case SMART_TARGET_RANDOM_POINT:
        case SMART_TARGET_ROLE_SELECTION:
        case SMART_TARGET_LOOT_RECIPIENTS:
        case SMART_EVENT_SUMMONED_UNIT_DIES:
        case SMART_TARGET_PLAYER_RANGE:
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
    return true;
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
        case SMART_ACTION_SET_CORPSE_DELAY:
        case SMART_ACTION_DISABLE_EVADE:
        case SMART_ACTION_GO_SET_GO_STATE:
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
            case SMART_EVENT_RANGE:
            case SMART_EVENT_DAMAGED:
            case SMART_EVENT_DAMAGED_TARGET:
            case SMART_EVENT_RECEIVE_HEAL:
                if (!IsMinMaxValid(e, e.event.minMaxRepeat.min, e.event.minMaxRepeat.max))
                    return false;

                if (!IsMinMaxValid(e, e.event.minMaxRepeat.repeatMin, e.event.minMaxRepeat.repeatMax))
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
                {
                    return false;
                }

                if (e.event.los.hostilityMode >= AsUnderlyingType(SmartEvent::LOSHostilityMode::End))
                {
                    LOG_ERROR("sql.sql", "SmartAIMgr: Entry {} SourceType {} Event {} Action {} uses hostilityMode with invalid value {} (max allowed value {}), skipped.",
                                 e.entryOrGuid, e.GetScriptType(), e.event_id, e.GetActionType(), e.event.los.hostilityMode, AsUnderlyingType(SmartEvent::LOSHostilityMode::End) - 1);
                    return false;
                }

                AC_SAI_IS_BOOLEAN_VALID(e, e.event.los.playerOnly);
                break;
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

                AC_SAI_IS_BOOLEAN_VALID(e, e.event.kill.playerOnly);
                break;
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
                if (e.event.summoned.creature && !IsCreatureValid(e, e.event.summoned.creature))
                    return false;

                if (!IsMinMaxValid(e, e.event.summoned.cooldownMin, e.event.summoned.cooldownMax))
                    return false;
                break;
            case SMART_EVENT_ACCEPTED_QUEST:
            case SMART_EVENT_REWARD_QUEST:
                if (e.event.quest.quest && !IsQuestValid(e, e.event.quest.quest))
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
            case SMART_EVENT_IS_BEHIND_TARGET:
                if (!IsMinMaxValid(e, e.event.behindTarget.cooldownMin, e.event.behindTarget.cooldownMax))
                    return false;
                break;
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
                if (!IsMinMaxValid(e, e.event.friendlyHealthPct.repeatMin, e.event.friendlyHealthPct.repeatMax))
                    return false;

                if (e.event.friendlyHealthPct.maxHpPct > 100 || e.event.friendlyHealthPct.minHpPct > 100)
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

                if (e.event.distance.guid != 0 && !sObjectMgr->GetGOData(e.event.distance.guid))
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
            case SMART_EVENT_CHARMED:
            case SMART_EVENT_GO_STATE_CHANGED:
            case SMART_EVENT_GO_EVENT_INFORM:
            case SMART_EVENT_NEAR_PLAYERS:
            case SMART_EVENT_NEAR_PLAYERS_NEGATION:
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
            case SMART_EVENT_WAYPOINT_START:
            case SMART_EVENT_WAYPOINT_REACHED:
            case SMART_EVENT_WAYPOINT_PAUSED:
            case SMART_EVENT_WAYPOINT_RESUMED:
            case SMART_EVENT_WAYPOINT_STOPPED:
            case SMART_EVENT_WAYPOINT_ENDED:
            case SMART_EVENT_GOSSIP_SELECT:
            case SMART_EVENT_GOSSIP_HELLO:
            case SMART_EVENT_JUST_CREATED:
            case SMART_EVENT_FOLLOW_COMPLETED:
            case SMART_EVENT_ON_SPELLCLICK:
                break;
            default:
                LOG_ERROR("sql.sql", "SmartAIMgr: Not handled event_type({}), Entry {} SourceType {} Event {} Action {}, skipped.", e.GetEventType(), e.entryOrGuid, e.GetScriptType(), e.event_id, e.GetActionType());
                return false;
        }
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
            AC_SAI_IS_BOOLEAN_VALID(e, e.action.sound.onlySelf);
            break;
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

            AC_SAI_IS_BOOLEAN_VALID(e, e.action.questOffer.directAdd);
            break;
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
            if (e.action.randomEmote.emote1 && !IsEmoteValid(e, e.action.randomEmote.emote1))
                return false;

            if (e.action.randomEmote.emote2 && !IsEmoteValid(e, e.action.randomEmote.emote2))
                return false;

            if (e.action.randomEmote.emote3 && !IsEmoteValid(e, e.action.randomEmote.emote3))
                return false;

            if (e.action.randomEmote.emote4 && !IsEmoteValid(e, e.action.randomEmote.emote4))
                return false;

            if (e.action.randomEmote.emote5 && !IsEmoteValid(e, e.action.randomEmote.emote5))
                return false;

            if (e.action.randomEmote.emote6 && !IsEmoteValid(e, e.action.randomEmote.emote6))
                return false;
            break;
        case SMART_ACTION_ADD_AURA:
        case SMART_ACTION_CAST:
        case SMART_ACTION_INVOKER_CAST:
            if (!IsSpellValid(e, e.action.cast.spell))
                return false;
            break;
        case SMART_ACTION_CROSS_CAST:
            if (!IsSpellValid(e, e.action.crossCast.spell))
                return false;
            break;
        case SMART_ACTION_CUSTOM_CAST:
            if (!IsSpellValid(e, e.action.castCustom.spell))
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
                if (e.action.randomPhase.phase1 >= SMART_EVENT_PHASE_MAX ||
                        e.action.randomPhase.phase2 >= SMART_EVENT_PHASE_MAX ||
                        e.action.randomPhase.phase3 >= SMART_EVENT_PHASE_MAX ||
                        e.action.randomPhase.phase4 >= SMART_EVENT_PHASE_MAX ||
                        e.action.randomPhase.phase5 >= SMART_EVENT_PHASE_MAX ||
                        e.action.randomPhase.phase6 >= SMART_EVENT_PHASE_MAX)
                {
                    LOG_ERROR("sql.sql", "SmartAIMgr: Entry {} SourceType {} Event {} Action {} attempts to set invalid phase, skipped.", e.entryOrGuid, e.GetScriptType(), e.event_id, e.GetActionType());
                    return false;
                }
                if (e.action.randomPhase.phase1 == 0 &&
                        e.action.randomPhase.phase2 == 0 &&
                        e.action.randomPhase.phase3 == 0 &&
                        e.action.randomPhase.phase4 == 0 &&
                        e.action.randomPhase.phase5 == 0 &&
                        e.action.randomPhase.phase6 == 0)
                {
                    LOG_ERROR("sql.sql", "SmartAIMgr: Entry {} SourceType {} Event {} Action {} attempts to set invalid phase, skipped.", e.entryOrGuid, e.GetScriptType(), e.event_id, e.GetActionType());
                    return false;
                }
            }
            break;
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

            AC_SAI_IS_BOOLEAN_VALID(e, e.action.summonCreature.attackInvoker);
            break;
        case SMART_ACTION_CALL_KILLEDMONSTER:
            if (!IsCreatureValid(e, e.action.killedMonster.creature))
                return false;
            break;
        case SMART_ACTION_UPDATE_TEMPLATE:
            if (!IsCreatureValid(e, e.action.updateTemplate.creature))
                return false;
            AC_SAI_IS_BOOLEAN_VALID(e, e.action.updateTemplate.updateLevel);
            break;
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
        case SMART_ACTION_WP_STOP:
            if (e.action.wpStop.quest && !IsQuestValid(e, e.action.wpStop.quest))
                return false;
            AC_SAI_IS_BOOLEAN_VALID(e, e.action.wpStop.fail);
            break;
        case SMART_ACTION_WP_START:
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

                AC_SAI_IS_BOOLEAN_VALID(e, e.action.wpStart.run);
                AC_SAI_IS_BOOLEAN_VALID(e, e.action.wpStart.repeat);
                break;
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
                if (!IsMinMaxValid(e, e.action.randTimedActionList.entry1, e.action.randTimedActionList.entry2))
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
                    int8 equipId = (int8)e.action.equip.entry;

                    if (equipId)
                    {
                        EquipmentInfo const* einfo = sObjectMgr->GetEquipmentInfo(e.entryOrGuid, equipId);
                        if (!einfo)
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
        case SMART_ACTION_AUTO_ATTACK:
            {
                AC_SAI_IS_BOOLEAN_VALID(e, e.action.autoAttack.attack);
                break;
            }
        case SMART_ACTION_ALLOW_COMBAT_MOVEMENT:
            {
                AC_SAI_IS_BOOLEAN_VALID(e, e.action.combatMove.move);
                break;
            }
        case SMART_ACTION_CALL_FOR_HELP:
            {
                AC_SAI_IS_BOOLEAN_VALID(e, e.action.callHelp.withEmote);
                break;
            }
        case SMART_ACTION_SET_VISIBILITY:
            {
                AC_SAI_IS_BOOLEAN_VALID(e, e.action.visibility.state);
                break;
            }
        case SMART_ACTION_SET_RUN:
            {
                AC_SAI_IS_BOOLEAN_VALID(e, e.action.setRun.run);
                break;
            }
        case SMART_ACTION_SET_CAN_FLY:
            {
                AC_SAI_IS_BOOLEAN_VALID(e, e.action.setFly.fly);
                break;
            }
        case SMART_ACTION_SET_SWIM:
            {
                AC_SAI_IS_BOOLEAN_VALID(e, e.action.setSwim.swim);
                break;
            }
        case SMART_ACTION_SET_COUNTER:
            {
                AC_SAI_IS_BOOLEAN_VALID(e, e.action.setCounter.reset);
                break;
            }
        case SMART_ACTION_INTERRUPT_SPELL:
            {
                AC_SAI_IS_BOOLEAN_VALID(e, e.action.interruptSpellCasting.withDelayed);
                AC_SAI_IS_BOOLEAN_VALID(e, e.action.interruptSpellCasting.withInstant);
                break;
            }
        case SMART_ACTION_SET_ROOT:
            {
                AC_SAI_IS_BOOLEAN_VALID(e, e.action.setRoot.root);
                break;
            }
        case SMART_ACTION_DISABLE_EVADE:
            {
                AC_SAI_IS_BOOLEAN_VALID(e, e.action.disableEvade.disable);
                break;
            }
        case SMART_ACTION_LOAD_EQUIPMENT:
            {
                AC_SAI_IS_BOOLEAN_VALID(e, e.action.loadEquipment.force);
                break;
            }
        case SMART_ACTION_FLEE_FOR_ASSIST:
        case SMART_ACTION_MOVE_TO_POS:
        case SMART_ACTION_CALL_TIMED_ACTIONLIST:
        case SMART_ACTION_EVADE:
        case SMART_ACTION_SET_ACTIVE:
        case SMART_ACTION_START_CLOSEST_WAYPOINT:
        case SMART_ACTION_FOLLOW:
        case SMART_ACTION_SET_ORIENTATION:
        case SMART_ACTION_STORE_TARGET_LIST:
        case SMART_ACTION_COMBAT_STOP:
        case SMART_ACTION_DIE:
        case SMART_ACTION_WP_RESUME:
        case SMART_ACTION_KILL_UNIT:
        case SMART_ACTION_SET_INVINCIBILITY_HP_LEVEL:
        case SMART_ACTION_RESET_GOBJECT:
        case SMART_ACTION_ATTACK_START:
        case SMART_ACTION_THREAT_ALL_PCT:
        case SMART_ACTION_THREAT_SINGLE_PCT:
        case SMART_ACTION_SET_INST_DATA64:
        case SMART_ACTION_SET_DATA:
        case SMART_ACTION_MOVE_FORWARD:
        case SMART_ACTION_WP_PAUSE:
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
        case SMART_ACTION_TALK:
            AC_SAI_IS_BOOLEAN_VALID(e, e.action.talk.useTalkTarget);
            [[fallthrough]];
        case SMART_ACTION_SIMPLE_TALK:
        case SMART_ACTION_CALL_RANDOM_TIMED_ACTIONLIST:
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
        case SMART_ACTION_SET_HEALTH_REGEN:
        case SMART_ACTION_SET_GO_FLAG:
        case SMART_ACTION_ADD_GO_FLAG:
        case SMART_ACTION_REMOVE_GO_FLAG:
        case SMART_ACTION_SUMMON_CREATURE_GROUP:
        case SMART_ACTION_RISE_UP:
        case SMART_ACTION_MOVE_TO_POS_TARGET:
        case SMART_ACTION_SET_GO_STATE:
        case SMART_ACTION_EXIT_VEHICLE:
        case SMART_ACTION_SET_UNIT_MOVEMENT_FLAGS:
        case SMART_ACTION_SET_COMBAT_DISTANCE:
        case SMART_ACTION_SET_CASTER_COMBAT_DIST:
        case SMART_ACTION_SET_SIGHT_DIST:
        case SMART_ACTION_FLEE:
        case SMART_ACTION_ADD_THREAT:
        case SMART_ACTION_TRIGGER_RANDOM_TIMED_EVENT:
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
            break;
        default:
            LOG_ERROR("sql.sql", "SmartAIMgr: Not handled action_type({}), event_type({}), Entry {} SourceType {} Event {}, skipped.", e.GetActionType(), e.GetEventType(), e.entryOrGuid, e.GetScriptType(), e.event_id);
            return false;
    }

    return true;
}

/*bool SmartAIMgr::IsTextValid(SmartScriptHolder const& e, uint32 id) // unused
{
    bool error = false;
    uint32 entry = 0;
    if (e.entryOrGuid >= 0)
        entry = uint32(e.entryOrGuid);
    else {
        entry = uint32(std::abs(e.entryOrGuid));
        CreatureData const* data = sObjectMgr->GetCreatureData(entry);
        if (!data)
        {
            LOG_ERROR("scripts.ai.sai", "SmartAIMgr: Entry {} SourceType {} Event {} Action {} using non-existent Creature guid {}, skipped.", e.entryOrGuid, e.GetScriptType(), e.event_id, e.GetActionType(), entry);
            return false;
        }
        else
            entry = data->id;
    }
    if (!entry || !sCreatureTextMgr->TextExist(entry, uint8(id)))
        error = true;
    if (error)
    {
        LOG_ERROR("scripts.ai.sai", "SmartAIMgr: Entry {} SourceType {} Event {} Action {} using non-existent Text id {}, skipped.", e.entryOrGuid, e.GetScriptType(), e.source_type, e.GetActionType(), id);
        return false;
    }
    return true;
}*/

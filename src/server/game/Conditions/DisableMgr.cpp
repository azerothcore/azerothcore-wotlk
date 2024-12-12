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

#include "DisableMgr.h"
#include "GameEventMgr.h"
#include "MMapFactory.h"
#include "ObjectMgr.h"
#include "OutdoorPvP.h"
#include "Player.h"
#include "SpellInfo.h"
#include "SpellMgr.h"
#include "StringConvert.h"
#include "Tokenize.h"
#include "VMapMgr2.h"
#include "World.h"

namespace DisableMgr
{
    namespace
    {
        struct DisableData
        {
            uint8 flags;
            std::set<uint32> params[2];                             // params0, params1
        };

        // single disables here with optional data
        typedef std::map<uint32, DisableData> DisableTypeMap;
        // global disable map by source
        typedef std::map<DisableType, DisableTypeMap> DisableMap;

        DisableMap m_DisableMap;

        uint8 MAX_DISABLE_TYPES = 11;
    }

    void LoadDisables()
    {
        uint32 oldMSTime = getMSTime();

        // reload case
        for (DisableMap::iterator itr = m_DisableMap.begin(); itr != m_DisableMap.end(); ++itr)
            itr->second.clear();

        m_DisableMap.clear();

        QueryResult result = WorldDatabase.Query("SELECT sourceType, entry, flags, params_0, params_1 FROM disables");

        uint32 total_count = 0;

        if (!result)
        {
            LOG_WARN("server.loading", ">> Loaded 0 disables. DB table `disables` is empty!");
            LOG_INFO("server.loading", " ");
            return;
        }

        Field* fields;
        do
        {
            fields = result->Fetch();
            DisableType type = DisableType(fields[0].Get<uint32>());
            if (type >= MAX_DISABLE_TYPES)
            {
                LOG_ERROR("sql.sql", "Invalid type {} specified in `disables` table, skipped.", type);
                continue;
            }

            uint32 entry = fields[1].Get<uint32>();
            uint8 flags = fields[2].Get<uint8>();
            std::string params_0 = fields[3].Get<std::string>();
            std::string params_1 = fields[4].Get<std::string>();

            DisableData data;
            data.flags = flags;

            switch (type)
            {
                case DISABLE_TYPE_GO_LOS:
                    if (!sObjectMgr->GetGameObjectTemplate(entry))
                    {
                        LOG_ERROR("sql.sql", "Gameobject entry {} from `disables` doesn't exist in dbc, skipped.", entry);
                        continue;
                    }
                    if (flags)
                        LOG_ERROR("sql.sql", "Disable flags specified for gameobject {}, useless data.", entry);
                    break;
                case DISABLE_TYPE_SPELL:
                    if (!(sSpellMgr->GetSpellInfo(entry) || flags & SPELL_DISABLE_DEPRECATED_SPELL))
                    {
                        LOG_ERROR("sql.sql", "Spell entry {} from `disables` doesn't exist in dbc, skipped.", entry);
                        continue;
                    }

                    if (!flags || flags > MAX_SPELL_DISABLE_TYPE)
                    {
                        LOG_ERROR("sql.sql", "Disable flags for spell {} are invalid, skipped.", entry);
                        continue;
                    }

                    if (flags & SPELL_DISABLE_MAP)
                    {
                        for (std::string_view mapStr : Acore::Tokenize(params_0, ',', true))
                        {
                            if (Optional<uint32> mapId = Acore::StringTo<uint32>(mapStr))
                                data.params[0].insert(*mapId);
                            else
                                LOG_ERROR("sql.sql", "Disable map '{}' for spell {} is invalid, skipped.", mapStr, entry);
                        }
                    }

                    if (flags & SPELL_DISABLE_AREA)
                    {
                        for (std::string_view areaStr : Acore::Tokenize(params_1, ',', true))
                        {
                            if (Optional<uint32> areaId = Acore::StringTo<uint32>(areaStr))
                                data.params[1].insert(*areaId);
                            else
                                LOG_ERROR("sql.sql", "Disable area '{}' for spell {} is invalid, skipped.", areaStr, entry);
                        }
                    }

                    // xinef: if spell has disabled los, add flag
                    if (flags & SPELL_DISABLE_LOS)
                    {
                        SpellInfo* spellInfo = const_cast<SpellInfo*>(sSpellMgr->GetSpellInfo(entry));
                        spellInfo->AttributesEx2 |= SPELL_ATTR2_IGNORE_LINE_OF_SIGHT;
                    }

                    break;
                // checked later
                case DISABLE_TYPE_QUEST:
                    break;
                case DISABLE_TYPE_MAP:
                case DISABLE_TYPE_LFG_MAP:
                    {
                        MapEntry const* mapEntry = sMapStore.LookupEntry(entry);
                        if (!mapEntry)
                        {
                            LOG_ERROR("sql.sql", "Map entry {} from `disables` doesn't exist in dbc, skipped.", entry);
                            continue;
                        }
                        bool isFlagInvalid = false;
                        switch (mapEntry->map_type)
                        {
                            case MAP_COMMON:
                                if (flags)
                                    isFlagInvalid = true;
                                break;
                            case MAP_INSTANCE:
                            case MAP_RAID:
                                if (flags & DUNGEON_STATUSFLAG_HEROIC && !GetMapDifficultyData(entry, DUNGEON_DIFFICULTY_HEROIC))
                                    isFlagInvalid = true;
                                else if (flags & RAID_STATUSFLAG_10MAN_HEROIC && !GetMapDifficultyData(entry, RAID_DIFFICULTY_10MAN_HEROIC))
                                    isFlagInvalid = true;
                                else if (flags & RAID_STATUSFLAG_25MAN_HEROIC && !GetMapDifficultyData(entry, RAID_DIFFICULTY_25MAN_HEROIC))
                                    isFlagInvalid = true;
                                break;
                            case MAP_BATTLEGROUND:
                            case MAP_ARENA:
                                LOG_ERROR("sql.sql", "Battleground map {} specified to be disabled in map case, skipped.", entry);
                                continue;
                        }
                        if (isFlagInvalid)
                        {
                            LOG_ERROR("sql.sql", "Disable flags for map {} are invalid, skipped.", entry);
                            continue;
                        }
                        break;
                    }
                case DISABLE_TYPE_BATTLEGROUND:
                    if (!sBattlemasterListStore.LookupEntry(entry))
                    {
                        LOG_ERROR("sql.sql", "Battleground entry {} from `disables` doesn't exist in dbc, skipped.", entry);
                        continue;
                    }
                    if (flags)
                        LOG_ERROR("sql.sql", "Disable flags specified for battleground {}, useless data.", entry);
                    break;
                case DISABLE_TYPE_OUTDOORPVP:
                    if (entry > MAX_OUTDOORPVP_TYPES)
                    {
                        LOG_ERROR("sql.sql", "OutdoorPvPTypes value {} from `disables` is invalid, skipped.", entry);
                        continue;
                    }
                    if (flags)
                        LOG_ERROR("sql.sql", "Disable flags specified for outdoor PvP {}, useless data.", entry);
                    break;
                case DISABLE_TYPE_ACHIEVEMENT_CRITERIA:
                    if (!sAchievementCriteriaStore.LookupEntry(entry))
                    {
                        LOG_ERROR("sql.sql", "Achievement Criteria entry {} from `disables` doesn't exist in dbc, skipped.", entry);
                        continue;
                    }
                    if (flags)
                        LOG_ERROR("sql.sql", "Disable flags specified for Achievement Criteria {}, useless data.", entry);
                    break;
                case DISABLE_TYPE_VMAP:
                    {
                        MapEntry const* mapEntry = sMapStore.LookupEntry(entry);
                        if (!mapEntry)
                        {
                            LOG_ERROR("sql.sql", "Map entry {} from `disables` doesn't exist in dbc, skipped.", entry);
                            continue;
                        }
                        switch (mapEntry->map_type)
                        {
                            case MAP_COMMON:
                                if (flags & VMAP::VMAP_DISABLE_AREAFLAG)
                                    LOG_INFO("disable", "Areaflag disabled for world map {}.", entry);
                                if (flags & VMAP::VMAP_DISABLE_LIQUIDSTATUS)
                                    LOG_INFO("disable", "Liquid status disabled for world map {}.", entry);
                                break;
                            case MAP_INSTANCE:
                            case MAP_RAID:
                                if (flags & VMAP::VMAP_DISABLE_HEIGHT)
                                    LOG_INFO("disable", "Height disabled for instance map {}.", entry);
                                if (flags & VMAP::VMAP_DISABLE_LOS)
                                    LOG_INFO("disable", "LoS disabled for instance map {}.", entry);
                                break;
                            case MAP_BATTLEGROUND:
                                if (flags & VMAP::VMAP_DISABLE_HEIGHT)
                                    LOG_INFO("disable", "Height disabled for battleground map {}.", entry);
                                if (flags & VMAP::VMAP_DISABLE_LOS)
                                    LOG_INFO("disable", "LoS disabled for battleground map {}.", entry);
                                break;
                            case MAP_ARENA:
                                if (flags & VMAP::VMAP_DISABLE_HEIGHT)
                                    LOG_INFO("disable", "Height disabled for arena map {}.", entry);
                                if (flags & VMAP::VMAP_DISABLE_LOS)
                                    LOG_INFO("disable", "LoS disabled for arena map {}.", entry);
                                break;
                            default:
                                break;
                        }
                        break;
                    }
                    case DISABLE_TYPE_GAME_EVENT:
                    {
                        GameEventMgr::ActiveEvents const& activeEvents = sGameEventMgr->GetActiveEventList();
                        if (activeEvents.find(entry) != activeEvents.end())
                        {
                            sGameEventMgr->StopEvent(entry);
                            LOG_INFO("disable", "Event entry {} was stopped because it has been disabled.", entry);
                        }
                        break;
                    }
                    case DISABLE_TYPE_LOOT:
                        break;
                default:
                    break;
            }

            m_DisableMap[type].insert(DisableTypeMap::value_type(entry, data));
            ++total_count;
        } while (result->NextRow());

        LOG_INFO("server.loading", ">> Loaded {} Disables in {} ms", total_count, GetMSTimeDiffToNow(oldMSTime));
        LOG_INFO("server.loading", " ");
    }

    void CheckQuestDisables()
    {
        uint32 oldMSTime = getMSTime();

        uint32 count = m_DisableMap[DISABLE_TYPE_QUEST].size();
        if (!count)
        {
            LOG_INFO("server.loading", ">> Checked 0 quest disables.");
            LOG_INFO("server.loading", " ");
            return;
        }

        // check only quests, rest already done at startup
        for (DisableTypeMap::iterator itr = m_DisableMap[DISABLE_TYPE_QUEST].begin(); itr != m_DisableMap[DISABLE_TYPE_QUEST].end();)
        {
            const uint32 entry = itr->first;
            if (!sObjectMgr->GetQuestTemplate(entry))
            {
                LOG_ERROR("sql.sql", "Quest entry {} from `disables` doesn't exist, skipped.", entry);
                m_DisableMap[DISABLE_TYPE_QUEST].erase(itr++);
                continue;
            }
            if (itr->second.flags)
                LOG_ERROR("sql.sql", "Disable flags specified for quest {}, useless data.", entry);
            ++itr;
        }

        LOG_INFO("server.loading", ">> Checked {} Quest Disables in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
        LOG_INFO("server.loading", " ");
    }

    bool IsDisabledFor(DisableType type, uint32 entry, Unit const* unit, uint8 flags)
    {
        if (type > MAX_DISABLE_TYPES)
        {
            LOG_ERROR("server", "Disables::IsDisabledFor() called with unknown disable type {}!  (entry {}, flags {}).", type, entry, flags);
            return false;
        }

        if (m_DisableMap[type].empty())
            return false;

        DisableTypeMap::iterator itr = m_DisableMap[type].find(entry);
        if (itr == m_DisableMap[type].end())    // not disabled
            return false;

        switch (type)
        {
            case DISABLE_TYPE_SPELL:
                {
                    uint8 spellFlags = itr->second.flags;
                    if (unit)
                    {
                        if ((spellFlags & SPELL_DISABLE_PLAYER && unit->IsPlayer()) ||
                                (unit->IsCreature() && ((unit->IsPet() && spellFlags & SPELL_DISABLE_PET) || spellFlags & SPELL_DISABLE_CREATURE)))
                        {
                            if (spellFlags & SPELL_DISABLE_MAP)
                            {
                                std::set<uint32> const& mapIds = itr->second.params[0];
                                if (mapIds.find(unit->GetMapId()) != mapIds.end())
                                    return true;                                        // Spell is disabled on current map

                                if (!(spellFlags & SPELL_DISABLE_AREA))
                                    return false;                                       // Spell is disabled on another map, but not this one, return false

                                // Spell is disabled in an area, but not explicitly our current mapId. Continue processing.
                            }

                            if (spellFlags & SPELL_DISABLE_AREA)
                            {
                                std::set<uint32> const& areaIds = itr->second.params[1];
                                if (areaIds.find(unit->GetAreaId()) != areaIds.end())
                                    return true;                                        // Spell is disabled in this area
                                return false;                                           // Spell is disabled in another area, but not this one, return false
                            }
                            else
                                return true;                                            // Spell disabled for all maps
                        }

                        return false;
                    }
                    else if (spellFlags & SPELL_DISABLE_DEPRECATED_SPELL)    // call not from spellcast
                        return true;

                    break;
                }
            case DISABLE_TYPE_MAP:
            case DISABLE_TYPE_LFG_MAP:
                if (Player const* player = unit->ToPlayer())
                {
                    MapEntry const* mapEntry = sMapStore.LookupEntry(entry);
                    if (mapEntry->IsDungeon())
                    {
                        uint8 disabledModes = itr->second.flags;
                        Difficulty targetDifficulty = player->GetDifficulty(mapEntry->IsRaid());
                        GetDownscaledMapDifficultyData(entry, targetDifficulty);
                        switch (targetDifficulty)
                        {
                            case DUNGEON_DIFFICULTY_NORMAL:
                                return disabledModes & DUNGEON_STATUSFLAG_NORMAL;
                            case DUNGEON_DIFFICULTY_HEROIC:
                                return disabledModes & DUNGEON_STATUSFLAG_HEROIC;
                            case RAID_DIFFICULTY_10MAN_HEROIC:
                                return disabledModes & RAID_STATUSFLAG_10MAN_HEROIC;
                            case RAID_DIFFICULTY_25MAN_HEROIC:
                                return disabledModes & RAID_STATUSFLAG_25MAN_HEROIC;
                        }
                    }
                    else if (mapEntry->map_type == MAP_COMMON)
                        return true;
                }
                return false;
            case DISABLE_TYPE_QUEST:
                return true;
            case DISABLE_TYPE_BATTLEGROUND:
            case DISABLE_TYPE_OUTDOORPVP:
            case DISABLE_TYPE_ACHIEVEMENT_CRITERIA:
                return true;
            case DISABLE_TYPE_VMAP:
                return flags & itr->second.flags;
            case DISABLE_TYPE_GO_LOS:
                return true;
            case DISABLE_TYPE_GAME_EVENT:
                return true;
            case DISABLE_TYPE_LOOT:
                return true;
        }

        return false;
    }

    bool IsVMAPDisabledFor(uint32 entry, uint8 flags)
    {
        return IsDisabledFor(DISABLE_TYPE_VMAP, entry, nullptr, flags);
    }

    bool IsPathfindingEnabled(const Map* map)
    {
        if (!map)
            return false;

        return !MMAP::MMapFactory::forbiddenMaps[map->GetId()] && (sWorld->getBoolConfig(CONFIG_ENABLE_MMAPS) ? true : map->IsBattlegroundOrArena());
    }

} // Namespace

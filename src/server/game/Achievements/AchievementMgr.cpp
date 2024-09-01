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

#include "AchievementMgr.h"
#include "AccountMgr.h"
#include "ArenaTeam.h"
#include "ArenaTeamMgr.h"
#include "Battleground.h"
#include "BattlegroundAB.h"
#include "CellImpl.h"
#include "Chat.h"
#include "ChatTextBuilder.h"
#include "Common.h"
#include "DBCEnums.h"
#include "DatabaseEnv.h"
#include "DisableMgr.h"
#include "GameEventMgr.h"
#include "GameTime.h"
#include "GridNotifiersImpl.h"
#include "Guild.h"
#include "GuildMgr.h"
#include "InstanceScript.h"
#include "Language.h"
#include "Map.h"
#include "MapMgr.h"
#include "ObjectMgr.h"
#include "Player.h"
#include "ReputationMgr.h"
#include "ScriptMgr.h"
#include "SpellMgr.h"
#include "World.h"
#include "WorldPacket.h"

bool AchievementCriteriaData::IsValid(AchievementCriteriaEntry const* criteria)
{
    if (dataType >= MAX_ACHIEVEMENT_CRITERIA_DATA_TYPE)
    {
        LOG_ERROR("sql.sql", "Table `achievement_criteria_data` for criteria (Entry: {}) has wrong data type ({}), ignored.", criteria->ID, dataType);
        return false;
    }

    switch (criteria->requiredType)
    {
        case ACHIEVEMENT_CRITERIA_TYPE_KILL_CREATURE:
        case ACHIEVEMENT_CRITERIA_TYPE_KILL_CREATURE_TYPE:
        case ACHIEVEMENT_CRITERIA_TYPE_WIN_BG:
        case ACHIEVEMENT_CRITERIA_TYPE_FALL_WITHOUT_DYING:
        case ACHIEVEMENT_CRITERIA_TYPE_COMPLETE_QUEST:          // only hardcoded list
        case ACHIEVEMENT_CRITERIA_TYPE_CAST_SPELL:
        case ACHIEVEMENT_CRITERIA_TYPE_WIN_RATED_ARENA:
        case ACHIEVEMENT_CRITERIA_TYPE_WIN_ARENA:
        case ACHIEVEMENT_CRITERIA_TYPE_DO_EMOTE:
        case ACHIEVEMENT_CRITERIA_TYPE_SPECIAL_PVP_KILL:
        case ACHIEVEMENT_CRITERIA_TYPE_WIN_DUEL:
        case ACHIEVEMENT_CRITERIA_TYPE_LOOT_TYPE:
        case ACHIEVEMENT_CRITERIA_TYPE_CAST_SPELL2:
        case ACHIEVEMENT_CRITERIA_TYPE_BE_SPELL_TARGET:
        case ACHIEVEMENT_CRITERIA_TYPE_BE_SPELL_TARGET2:
        case ACHIEVEMENT_CRITERIA_TYPE_EQUIP_EPIC_ITEM:
        case ACHIEVEMENT_CRITERIA_TYPE_ROLL_NEED_ON_LOOT:
        case ACHIEVEMENT_CRITERIA_TYPE_ROLL_GREED_ON_LOOT:
        case ACHIEVEMENT_CRITERIA_TYPE_BG_OBJECTIVE_CAPTURE:
        case ACHIEVEMENT_CRITERIA_TYPE_HONORABLE_KILL:
        case ACHIEVEMENT_CRITERIA_TYPE_COMPLETE_DAILY_QUEST:    // only Children's Week achievements
        case ACHIEVEMENT_CRITERIA_TYPE_USE_ITEM:                // only Children's Week achievements
        case ACHIEVEMENT_CRITERIA_TYPE_GET_KILLING_BLOWS:
        case ACHIEVEMENT_CRITERIA_TYPE_REACH_LEVEL:
        case ACHIEVEMENT_CRITERIA_TYPE_ON_LOGIN:
        case ACHIEVEMENT_CRITERIA_TYPE_LOOT_EPIC_ITEM:
        case ACHIEVEMENT_CRITERIA_TYPE_RECEIVE_EPIC_ITEM:
        case ACHIEVEMENT_CRITERIA_TYPE_OWN_RANK:
            break;
        default:
            if (dataType != ACHIEVEMENT_CRITERIA_DATA_TYPE_SCRIPT)
            {
                LOG_ERROR("sql.sql", "Table `achievement_criteria_data` has data for non-supported criteria type (Entry: {} Type: {}), ignored.", criteria->ID, criteria->requiredType);
                return false;
            }
            break;
    }

    switch (dataType)
    {
        case ACHIEVEMENT_CRITERIA_DATA_TYPE_NONE:
        case ACHIEVEMENT_CRITERIA_DATA_TYPE_INSTANCE_SCRIPT:
        case ACHIEVEMENT_CRITERIA_DATA_TYPE_NTH_BIRTHDAY:
            return true;
        case ACHIEVEMENT_CRITERIA_DATA_TYPE_T_CREATURE:
            if (!creature.id || !sObjectMgr->GetCreatureTemplate(creature.id))
            {
                LOG_ERROR("sql.sql", "Table `achievement_criteria_data` (Entry: {} Type: {}) for data type ACHIEVEMENT_CRITERIA_DATA_TYPE_CREATURE ({}) has non-existing creature id in value1 ({}), ignored.",
                                 criteria->ID, criteria->requiredType, dataType, creature.id);
                return false;
            }
            return true;
        case ACHIEVEMENT_CRITERIA_DATA_TYPE_T_PLAYER_CLASS_RACE:
            if (classRace.class_id && ((1 << (classRace.class_id - 1)) & CLASSMASK_ALL_PLAYABLE) == 0)
            {
                LOG_ERROR("sql.sql", "Table `achievement_criteria_data` (Entry: {} Type: {}) for data type ACHIEVEMENT_CRITERIA_DATA_TYPE_T_PLAYER_CLASS_RACE ({}) has non-existing class in value1 ({}), ignored.",
                                 criteria->ID, criteria->requiredType, dataType, classRace.class_id);
                return false;
            }
            if (classRace.race_id && ((1 << (classRace.race_id - 1)) & RACEMASK_ALL_PLAYABLE) == 0)
            {
                LOG_ERROR("sql.sql", "Table `achievement_criteria_data` (Entry: {} Type: {}) for data type ACHIEVEMENT_CRITERIA_DATA_TYPE_T_PLAYER_CLASS_RACE ({}) has non-existing race in value2 ({}), ignored.",
                                 criteria->ID, criteria->requiredType, dataType, classRace.race_id);
                return false;
            }
            return true;
        case ACHIEVEMENT_CRITERIA_DATA_TYPE_T_PLAYER_LESS_HEALTH:
            if (health.percent < 1 || health.percent > 100)
            {
                LOG_ERROR("sql.sql", "Table `achievement_criteria_data` (Entry: {} Type: {}) for data type ACHIEVEMENT_CRITERIA_DATA_TYPE_PLAYER_LESS_HEALTH ({}) has wrong percent value in value1 ({}), ignored.",
                                 criteria->ID, criteria->requiredType, dataType, health.percent);
                return false;
            }
            return true;
        case ACHIEVEMENT_CRITERIA_DATA_TYPE_T_PLAYER_DEAD:
            if (player_dead.own_team_flag > 1)
            {
                LOG_ERROR("sql.sql", "Table `achievement_criteria_data` (Entry: {} Type: {}) for data type ACHIEVEMENT_CRITERIA_DATA_TYPE_T_PLAYER_DEAD ({}) has wrong boolean value1 ({}).",
                                 criteria->ID, criteria->requiredType, dataType, player_dead.own_team_flag);
                return false;
            }
            return true;
        case ACHIEVEMENT_CRITERIA_DATA_TYPE_S_AURA:
        case ACHIEVEMENT_CRITERIA_DATA_TYPE_T_AURA:
            {
                SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(aura.spell_id);
                if (!spellInfo)
                {
                    LOG_ERROR("sql.sql", "Table `achievement_criteria_data` (Entry: {} Type: {}) for data type {} ({}) has wrong spell id in value1 ({}), ignored.",
                                     criteria->ID, criteria->requiredType, (dataType == ACHIEVEMENT_CRITERIA_DATA_TYPE_S_AURA ? "ACHIEVEMENT_CRITERIA_DATA_TYPE_S_AURA" : "ACHIEVEMENT_CRITERIA_DATA_TYPE_T_AURA"), dataType, aura.spell_id);
                    return false;
                }
                if (aura.effect_idx >= 3)
                {
                    LOG_ERROR("sql.sql", "Table `achievement_criteria_data` (Entry: {} Type: {}) for data type {} ({}) has wrong spell effect index in value2 ({}), ignored.",
                                     criteria->ID, criteria->requiredType, (dataType == ACHIEVEMENT_CRITERIA_DATA_TYPE_S_AURA ? "ACHIEVEMENT_CRITERIA_DATA_TYPE_S_AURA" : "ACHIEVEMENT_CRITERIA_DATA_TYPE_T_AURA"), dataType, aura.effect_idx);
                    return false;
                }
                if (!spellInfo->Effects[aura.effect_idx].ApplyAuraName)
                {
                    LOG_ERROR("sql.sql", "Table `achievement_criteria_data` (Entry: {} Type: {}) for data type {} ({}) has non-aura spell effect (ID: {} Effect: {}), ignores.",
                                     criteria->ID, criteria->requiredType, (dataType == ACHIEVEMENT_CRITERIA_DATA_TYPE_S_AURA ? "ACHIEVEMENT_CRITERIA_DATA_TYPE_S_AURA" : "ACHIEVEMENT_CRITERIA_DATA_TYPE_T_AURA"), dataType, aura.spell_id, aura.effect_idx);
                    return false;
                }
                return true;
            }
        case ACHIEVEMENT_CRITERIA_DATA_TYPE_S_AREA:
            if (!sAreaTableStore.LookupEntry(area.id))
            {
                LOG_ERROR("sql.sql", "Table `achievement_criteria_data` (Entry: {} Type: {}) for data type ACHIEVEMENT_CRITERIA_DATA_TYPE_S_AREA ({}) has wrong area id in value1 ({}), ignored.",
                                 criteria->ID, criteria->requiredType, dataType, area.id);
                return false;
            }
            return true;
        case ACHIEVEMENT_CRITERIA_DATA_TYPE_VALUE:
            if (value.compType >= COMP_TYPE_MAX)
            {
                LOG_ERROR("sql.sql", "Table `achievement_criteria_data` (Entry: {} Type: {}) for data type ACHIEVEMENT_CRITERIA_DATA_TYPE_VALUE ({}) has wrong ComparisionType in value2 ({}), ignored.",
                                 value.compType, criteria->requiredType, dataType, value.value);
                return false;
            }
            return true;
        case ACHIEVEMENT_CRITERIA_DATA_TYPE_T_LEVEL:
            if (level.minlevel > STRONG_MAX_LEVEL)
            {
                LOG_ERROR("sql.sql", "Table `achievement_criteria_data` (Entry: {} Type: {}) for data type ACHIEVEMENT_CRITERIA_DATA_TYPE_T_LEVEL ({}) has wrong minlevel in value1 ({}), ignored.",
                                 criteria->ID, criteria->requiredType, dataType, level.minlevel);
                return false;
            }
            return true;
        case ACHIEVEMENT_CRITERIA_DATA_TYPE_T_GENDER:
            if (gender.gender > GENDER_NONE)
            {
                LOG_ERROR("sql.sql", "Table `achievement_criteria_data` (Entry: {} Type: {}) for data type ACHIEVEMENT_CRITERIA_DATA_TYPE_T_GENDER ({}) has wrong gender in value1 ({}), ignored.",
                                 criteria->ID, criteria->requiredType, dataType, gender.gender);
                return false;
            }
            return true;
        case ACHIEVEMENT_CRITERIA_DATA_TYPE_SCRIPT:
            if (!ScriptId)
            {
                LOG_ERROR("sql.sql", "Table `achievement_criteria_data` (Entry: {} Type: {}) for data type ACHIEVEMENT_CRITERIA_DATA_TYPE_SCRIPT ({}) does not have ScriptName set, ignored.",
                                 criteria->ID, criteria->requiredType, dataType);
                return false;
            }
            return true;
        case ACHIEVEMENT_CRITERIA_DATA_TYPE_MAP_DIFFICULTY:
            if (difficulty.difficulty >= MAX_DIFFICULTY)
            {
                LOG_ERROR("sql.sql", "Table `achievement_criteria_data` (Entry: {} Type: {}) for data type ACHIEVEMENT_CRITERIA_DATA_TYPE_MAP_DIFFICULTY ({}) has wrong difficulty in value1 ({}), ignored.",
                                 criteria->ID, criteria->requiredType, dataType, difficulty.difficulty);
                return false;
            }
            return true;
        case ACHIEVEMENT_CRITERIA_DATA_TYPE_MAP_PLAYER_COUNT:
            if (map_players.maxcount <= 0)
            {
                LOG_ERROR("sql.sql", "Table `achievement_criteria_data` (Entry: {} Type: {}) for data type ACHIEVEMENT_CRITERIA_DATA_TYPE_MAP_PLAYER_COUNT ({}) has wrong max players count in value1 ({}), ignored.",
                                 criteria->ID, criteria->requiredType, dataType, map_players.maxcount);
                return false;
            }
            return true;
        case ACHIEVEMENT_CRITERIA_DATA_TYPE_T_TEAM:
            if (team.team != ALLIANCE && team.team != HORDE)
            {
                LOG_ERROR("sql.sql", "Table `achievement_criteria_data` (Entry: {} Type: {}) for data type ACHIEVEMENT_CRITERIA_DATA_TYPE_T_TEAM ({}) has unknown team in value1 ({}), ignored.",
                                 criteria->ID, criteria->requiredType, dataType, team.team);
                return false;
            }
            return true;
        case ACHIEVEMENT_CRITERIA_DATA_TYPE_S_DRUNK:
            if (drunk.state >= MAX_DRUNKEN)
            {
                LOG_ERROR("sql.sql", "Table `achievement_criteria_data` (Entry: {} Type: {}) for data type ACHIEVEMENT_CRITERIA_DATA_TYPE_S_DRUNK ({}) has unknown drunken state in value1 ({}), ignored.",
                                 criteria->ID, criteria->requiredType, dataType, drunk.state);
                return false;
            }
            return true;
        case ACHIEVEMENT_CRITERIA_DATA_TYPE_HOLIDAY:
            if (!sHolidaysStore.LookupEntry(holiday.id))
            {
                LOG_ERROR("sql.sql", "Table `achievement_criteria_data` (Entry: {} Type: {}) for data type ACHIEVEMENT_CRITERIA_DATA_TYPE_HOLIDAY ({}) has unknown holiday in value1 ({}), ignored.",
                                 criteria->ID, criteria->requiredType, dataType, holiday.id);
                return false;
            }
            return true;
        case ACHIEVEMENT_CRITERIA_DATA_TYPE_BG_LOSS_TEAM_SCORE:
        case ACHIEVEMENT_CRITERIA_DATA_TYPE_BG_TEAMS_SCORES:
            return true;                                    // not check correctness node indexes
        case ACHIEVEMENT_CRITERIA_DATA_TYPE_S_EQUIPPED_ITEM:
        case ACHIEVEMENT_CRITERIA_DATA_TYPE_S_ITEM_QUALITY:
            if (equipped_item.item_quality >= MAX_ITEM_QUALITY)
            {
                LOG_ERROR("sql.sql", "Table `achievement_criteria_requirement` (Entry: {} Type: {}) for requirement ACHIEVEMENT_CRITERIA_REQUIRE_S_EQUIPPED_ITEM ({}) has unknown quality state in value1 ({}), ignored.",
                                 criteria->ID, criteria->requiredType, dataType, equipped_item.item_quality);
                return false;
            }
            return true;
        case ACHIEVEMENT_CRITERIA_DATA_TYPE_MAP_ID:
            if (!sMapStore.LookupEntry(map_id.mapId))
            {
                LOG_ERROR("sql.sql", "Table `achievement_criteria_requirement` (Entry: {} Type: {}) for requirement ACHIEVEMENT_CRITERIA_DATA_TYPE_MAP_ID ({}) has unknown map id in value1 ({}), ignored.",
                                 criteria->ID, criteria->requiredType, dataType, map_id.mapId);
                return false;
            }
            return true;
        case ACHIEVEMENT_CRITERIA_DATA_TYPE_S_PLAYER_CLASS_RACE:
            if (!classRace.class_id && !classRace.race_id)
            {
                LOG_ERROR("sql.sql", "Table `achievement_criteria_data` (Entry: {} Type: {}) for data type ACHIEVEMENT_CRITERIA_DATA_TYPE_S_PLAYER_CLASS_RACE ({}) must not have 0 in either value field, ignored.",
                                 criteria->ID, criteria->requiredType, dataType);
                return false;
            }
            if (classRace.class_id && ((1 << (classRace.class_id - 1)) & CLASSMASK_ALL_PLAYABLE) == 0)
            {
                LOG_ERROR("sql.sql", "Table `achievement_criteria_data` (Entry: {} Type: {}) for data type ACHIEVEMENT_CRITERIA_DATA_TYPE_S_PLAYER_CLASS_RACE ({}) has non-existing class in value1 ({}), ignored.",
                                 criteria->ID, criteria->requiredType, dataType, classRace.class_id);
                return false;
            }
            if (classRace.race_id && ((1 << (classRace.race_id - 1)) & RACEMASK_ALL_PLAYABLE) == 0)
            {
                LOG_ERROR("sql.sql", "Table `achievement_criteria_data` (Entry: {} Type: {}) for data type ACHIEVEMENT_CRITERIA_DATA_TYPE_S_PLAYER_CLASS_RACE ({}) has non-existing race in value2 ({}), ignored.",
                                 criteria->ID, criteria->requiredType, dataType, classRace.race_id);
                return false;
            }
            return true;
        case ACHIEVEMENT_CRITERIA_DATA_TYPE_S_KNOWN_TITLE:
            {
                if (!sCharTitlesStore.LookupEntry(known_title.title_id))
                {
                    LOG_ERROR("sql.sql", "Table `achievement_criteria_requirement` (Entry: {} Type: {}) for requirement ACHIEVEMENT_CRITERIA_DATA_TYPE_S_KNOWN_TITLE ({}) have unknown title_id in value1 ({}), ignore.",
                                     criteria->ID, criteria->requiredType, dataType, known_title.title_id);
                    return false;
                }
                return true;
            }
        default:
            LOG_ERROR("sql.sql", "Table `achievement_criteria_data` (Entry: {} Type: {}) has data for non-supported data type ({}), ignored.", criteria->ID, criteria->requiredType, dataType);
            return false;
    }
}

bool AchievementCriteriaData::Meets(uint32 criteria_id, Player const* source, Unit const* target, uint32 miscvalue1 /*= 0*/) const
{
    switch (dataType)
    {
        case ACHIEVEMENT_CRITERIA_DATA_TYPE_NONE:
            return true;
        case ACHIEVEMENT_CRITERIA_DATA_TYPE_T_CREATURE:
            if (!target || target->GetTypeId() != TYPEID_UNIT)
                return false;
            return target->GetEntry() == creature.id;
        case ACHIEVEMENT_CRITERIA_DATA_TYPE_T_PLAYER_CLASS_RACE:
            if (!target || target->GetTypeId() != TYPEID_PLAYER)
                return false;
            if (classRace.class_id && classRace.class_id != target->ToPlayer()->getClass())
                return false;
            if (classRace.race_id && classRace.race_id != target->ToPlayer()->getRace())
                return false;
            return true;
        case ACHIEVEMENT_CRITERIA_DATA_TYPE_S_PLAYER_CLASS_RACE:
            if (!source || source->GetTypeId() != TYPEID_PLAYER)
                return false;
            if (classRace.class_id && classRace.class_id != source->ToPlayer()->getClass())
                return false;
            if (classRace.race_id && classRace.race_id != source->ToPlayer()->getRace())
                return false;
            return true;
        case ACHIEVEMENT_CRITERIA_DATA_TYPE_T_PLAYER_LESS_HEALTH:
            if (!target || target->GetTypeId() != TYPEID_PLAYER)
                return false;
            return !target->HealthAbovePct(health.percent);
        case ACHIEVEMENT_CRITERIA_DATA_TYPE_T_PLAYER_DEAD:
            if (target && !target->IsAlive())
                if (Player const* player = target->ToPlayer())
                    if (player->GetDeathTimer() != 0)
                        // flag set == must be same team, not set == different team
                        return (player->GetTeamId() == source->GetTeamId()) == (player_dead.own_team_flag != 0);
            return false;
        case ACHIEVEMENT_CRITERIA_DATA_TYPE_S_AURA:
            return source->HasAuraEffect(aura.spell_id, aura.effect_idx);
        case ACHIEVEMENT_CRITERIA_DATA_TYPE_S_AREA:
        {
            uint32 zone_id, area_id;
            source->GetZoneAndAreaId(zone_id, area_id);
            return area.id == zone_id || area.id == area_id;
        }
        case ACHIEVEMENT_CRITERIA_DATA_TYPE_T_AURA:
            return target && target->HasAuraEffect(aura.spell_id, aura.effect_idx);
        case ACHIEVEMENT_CRITERIA_DATA_TYPE_VALUE:
            return CompareValues(ComparisionType(value.compType), miscvalue1, value.value);
        case ACHIEVEMENT_CRITERIA_DATA_TYPE_T_LEVEL:
            if (!target)
                return false;
            return target->GetLevel() >= level.minlevel;
        case ACHIEVEMENT_CRITERIA_DATA_TYPE_T_GENDER:
            if (!target)
                return false;
            return target->getGender() == gender.gender;
        case ACHIEVEMENT_CRITERIA_DATA_TYPE_SCRIPT:
            return sScriptMgr->OnCriteriaCheck(ScriptId, const_cast<Player*>(source), const_cast<Unit*>(target), criteria_id);
        case ACHIEVEMENT_CRITERIA_DATA_TYPE_MAP_DIFFICULTY:
        {
            if (source->GetMap()->IsRaid())
                if (source->GetMap()->Is25ManRaid() != ((difficulty.difficulty & RAID_DIFFICULTY_MASK_25MAN) != 0))
                    return false;

            AchievementCriteriaEntry const* criteria = sAchievementCriteriaStore.LookupEntry(criteria_id);
            uint8 spawnMode = source->GetMap()->GetSpawnMode();
            // Dungeons completed on heroic mode count towards both in general achievement, but not in statistics.
            return sAchievementMgr->IsStatisticCriteria(criteria) ? spawnMode == difficulty.difficulty : spawnMode >= difficulty.difficulty;
        }
        case ACHIEVEMENT_CRITERIA_DATA_TYPE_MAP_PLAYER_COUNT:
            return source->GetMap()->GetPlayersCountExceptGMs() <= map_players.maxcount;
        case ACHIEVEMENT_CRITERIA_DATA_TYPE_T_TEAM:
        {
            if (!target || target->GetTypeId() != TYPEID_PLAYER)
                return false;

            // DB data compatibility...
            uint32 teamOld = target->ToPlayer()->GetTeamId() == TEAM_ALLIANCE ? ALLIANCE : HORDE;
            return teamOld == team.team;
        }
        case ACHIEVEMENT_CRITERIA_DATA_TYPE_S_DRUNK:
            return Player::GetDrunkenstateByValue(source->GetDrunkValue()) >= DrunkenState(drunk.state);
        case ACHIEVEMENT_CRITERIA_DATA_TYPE_HOLIDAY:
            return IsHolidayActive(HolidayIds(holiday.id));
        case ACHIEVEMENT_CRITERIA_DATA_TYPE_BG_LOSS_TEAM_SCORE:
        {
            Battleground* bg = source->GetBattleground();
            if (!bg)
                return false;

            uint32 score = bg->GetTeamScore(source->GetTeamId() == TEAM_ALLIANCE ? TEAM_HORDE : TEAM_ALLIANCE);
            return score >= bg_loss_team_score.min_score && score <= bg_loss_team_score.max_score;
        }
        case ACHIEVEMENT_CRITERIA_DATA_TYPE_INSTANCE_SCRIPT:
        {
            if (!source->IsInWorld())
                return false;
            Map* map = source->GetMap();
            if (!map->IsDungeon())
            {
                LOG_ERROR("sql.sql", "Achievement system call ACHIEVEMENT_CRITERIA_DATA_TYPE_INSTANCE_SCRIPT ({}) for achievement criteria {} for non-dungeon/non-raid map {}",
                                    ACHIEVEMENT_CRITERIA_DATA_TYPE_INSTANCE_SCRIPT, criteria_id, map->GetId());
                return false;
            }
            InstanceScript* instance = map->ToInstanceMap()->GetInstanceScript();
            if (!instance)
            {
                LOG_ERROR("sql.sql", "Achievement system call ACHIEVEMENT_CRITERIA_DATA_TYPE_INSTANCE_SCRIPT ({}) for achievement criteria {} for map {} but map does not have a instance script",
                                    ACHIEVEMENT_CRITERIA_DATA_TYPE_INSTANCE_SCRIPT, criteria_id, map->GetId());
                return false;
            }
            return instance->CheckAchievementCriteriaMeet(criteria_id, source, target, miscvalue1);
        }
        case ACHIEVEMENT_CRITERIA_DATA_TYPE_S_EQUIPPED_ITEM:
        {
            ItemTemplate const* pProto = sObjectMgr->GetItemTemplate(miscvalue1);
            if (!pProto)
                return false;
            return pProto->ItemLevel >= equipped_item.item_level && pProto->Quality >= equipped_item.item_quality;
        }
        case ACHIEVEMENT_CRITERIA_DATA_TYPE_MAP_ID:
            return source->GetMapId() == map_id.mapId;
        case ACHIEVEMENT_CRITERIA_DATA_TYPE_NTH_BIRTHDAY:
        {
            tm birthday_tm = Acore::Time::TimeBreakdown(sWorld->getIntConfig(CONFIG_BIRTHDAY_TIME));

            // exactly N birthday
            birthday_tm.tm_year += birthday_login.nth_birthday;

            time_t birthday = mktime(&birthday_tm);
            time_t now = GameTime::GetGameTime().count();
            return now <= birthday + DAY && now >= birthday;
        }
        case ACHIEVEMENT_CRITERIA_DATA_TYPE_S_KNOWN_TITLE:
        {
            if (CharTitlesEntry const* titleInfo = sCharTitlesStore.LookupEntry(known_title.title_id))
                return source && source->HasTitle(titleInfo->bit_index);

            return false;
        }
        case ACHIEVEMENT_CRITERIA_DATA_TYPE_S_ITEM_QUALITY:
        {
            ItemTemplate const* pProto = sObjectMgr->GetItemTemplate(miscvalue1);
            if (!pProto)
                return false;
            return pProto->Quality == item.item_quality;
        }
        case ACHIEVEMENT_CRITERIA_DATA_TYPE_BG_TEAMS_SCORES:
        {
            Battleground* bg = source->GetBattleground();
            if (!bg)
            {
                return false;
            }

            TeamId winnerTeam = GetTeamId(bg->GetWinner());
            if (winnerTeam == TEAM_NEUTRAL)
            {
                return false;
            }

            uint32 winnnerScore = bg->GetTeamScore(winnerTeam);
            uint32 loserScore = bg->GetTeamScore(TeamId(!uint32(winnerTeam)));
            return source->GetTeamId() == winnerTeam && winnnerScore == teams_scores.winner_score && loserScore == teams_scores.loser_score;
        }
        default:
            break;
    }
    return false;
}

bool AchievementCriteriaDataSet::Meets(Player const* source, Unit const* target, uint32 miscvalue /*= 0*/) const
{
    for (Storage::const_iterator itr = _storage.begin(); itr != _storage.end(); ++itr)
        if (!itr->Meets(_criteria_id, source, target, miscvalue))
            return false;

    return true;
}

AchievementMgr::AchievementMgr(Player* player)
{
    _player = player;
}

AchievementMgr::~AchievementMgr()
{
}

void AchievementMgr::Reset()
{
    for (CompletedAchievementMap::const_iterator iter = _completedAchievements.begin(); iter != _completedAchievements.end(); ++iter)
    {
        WorldPacket data(SMSG_ACHIEVEMENT_DELETED, 4);
        data << uint32(iter->first);
        _player->SendDirectMessage(&data);
    }

    for (CriteriaProgressMap::const_iterator iter = _criteriaProgress.begin(); iter != _criteriaProgress.end(); ++iter)
    {
        WorldPacket data(SMSG_CRITERIA_DELETED, 4);
        data << uint32(iter->first);
        _player->SendDirectMessage(&data);
    }

    _completedAchievements.clear();
    _criteriaProgress.clear();
    DeleteFromDB(_player->GetGUID().GetCounter());

    // re-fill data
    CheckAllAchievementCriteria();
}

void AchievementMgr::ResetAchievementCriteria(AchievementCriteriaCondition condition, uint32 value, bool evenIfCriteriaComplete)
{
    // disable for gamemasters with GM-mode enabled
    if (_player->IsGameMaster())
        return;

    LOG_DEBUG("achievement", "AchievementMgr::ResetAchievementCriteria({}, {}, {})", condition, value, evenIfCriteriaComplete);

    AchievementCriteriaEntryList const* achievementCriteriaList = sAchievementMgr->GetAchievementCriteriaByCondition(condition, value);
    if (!achievementCriteriaList)
        return;

    for (AchievementCriteriaEntryList::const_iterator i = achievementCriteriaList->begin(); i != achievementCriteriaList->end(); ++i)
    {
        AchievementCriteriaEntry const* achievementCriteria = (*i);
        AchievementEntry const* achievement = sAchievementStore.LookupEntry(achievementCriteria->referredAchievement);
        if (!achievement)
            continue;

        // don't update already completed criteria if not forced or achievement already complete
        if ((IsCompletedCriteria(achievementCriteria, achievement) && !evenIfCriteriaComplete) || HasAchieved(achievement->ID))
            continue;

        RemoveCriteriaProgress(achievementCriteria);
    }
}

void AchievementMgr::DeleteFromDB(ObjectGuid::LowType lowguid)
{
    CharacterDatabaseTransaction trans = CharacterDatabase.BeginTransaction();

    CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_CHAR_ACHIEVEMENT);
    stmt->SetData(0, lowguid);
    trans->Append(stmt);

    stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_CHAR_ACHIEVEMENT_PROGRESS);
    stmt->SetData(0, lowguid);
    trans->Append(stmt);

    CharacterDatabase.CommitTransaction(trans);
}

void AchievementMgr::SaveToDB(CharacterDatabaseTransaction trans)
{
    if (!_completedAchievements.empty())
    {
        for (CompletedAchievementMap::iterator iter = _completedAchievements.begin(); iter != _completedAchievements.end(); ++iter)
        {
            if (!iter->second.changed)
                continue;

            CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_CHAR_ACHIEVEMENT_BY_ACHIEVEMENT);
            stmt->SetData(0, iter->first);
            stmt->SetData(1, GetPlayer()->GetGUID().GetCounter());
            trans->Append(stmt);

            stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_CHAR_ACHIEVEMENT);
            stmt->SetData(0, GetPlayer()->GetGUID().GetCounter());
            stmt->SetData(1, iter->first);
            stmt->SetData(2, uint32(iter->second.date));
            trans->Append(stmt);

            iter->second.changed = false;

            sScriptMgr->OnAchievementSave(trans, GetPlayer(), iter->first, iter->second);
        }
    }

    if (!_criteriaProgress.empty())
    {
        for (CriteriaProgressMap::iterator iter = _criteriaProgress.begin(); iter != _criteriaProgress.end(); ++iter)
        {
            if (!iter->second.changed)
                continue;

            CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_CHAR_ACHIEVEMENT_PROGRESS_BY_CRITERIA);
            stmt->SetData(0, GetPlayer()->GetGUID().GetCounter());
            stmt->SetData(1, iter->first);
            trans->Append(stmt);

            // pussywizard: insert only for (counter != 0) is very important! this is how criteria of completed achievements gets deleted from db (by setting counter to 0); if conflicted during merge - contact me
            if (iter->second.counter)
            {
                stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_CHAR_ACHIEVEMENT_PROGRESS);
                stmt->SetData(0, GetPlayer()->GetGUID().GetCounter());
                stmt->SetData(1, iter->first);
                stmt->SetData(2, iter->second.counter);
                stmt->SetData(3, uint32(iter->second.date));
                trans->Append(stmt);
            }

            iter->second.changed = false;

            sScriptMgr->OnCriteriaSave(trans, GetPlayer(), iter->first, iter->second);
        }
    }
}

void AchievementMgr::LoadFromDB(PreparedQueryResult achievementResult, PreparedQueryResult criteriaResult)
{
    if (achievementResult)
    {
        do
        {
            Field* fields = achievementResult->Fetch();
            uint32 achievementid = fields[0].Get<uint16>();

            // must not happen: cleanup at server startup in sAchievementMgr->LoadCompletedAchievements()
            AchievementEntry const* achievement = sAchievementStore.LookupEntry(achievementid);
            if (!achievement)
                continue;

            CompletedAchievementData& ca = _completedAchievements[achievementid];
            ca.date = time_t(fields[1].Get<uint32>());
            ca.changed = false;

            // title achievement rewards are retroactive
            if (AchievementReward const* reward = sAchievementMgr->GetAchievementReward(achievement))
                if (uint32 titleId = reward->titleId[Player::TeamIdForRace(GetPlayer()->getRace())])
                    if (CharTitlesEntry const* titleEntry = sCharTitlesStore.LookupEntry(titleId))
                        if (!GetPlayer()->HasTitle(titleEntry))
                            GetPlayer()->SetTitle(titleEntry);
        } while (achievementResult->NextRow());
    }

    if (criteriaResult)
    {
        do
        {
            Field* fields = criteriaResult->Fetch();
            uint32 id      = fields[0].Get<uint16>();
            uint32 counter = fields[1].Get<uint32>();
            time_t date    = time_t(fields[2].Get<uint32>());

            AchievementCriteriaEntry const* criteria = sAchievementCriteriaStore.LookupEntry(id);
            if (!criteria)
            {
                // we will remove not existed criteria for all characters
                LOG_ERROR("achievement", "Non-existing achievement criteria {} data removed from table `character_achievement_progress`.", id);

                CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_INVALID_ACHIEV_PROGRESS_CRITERIA);

                stmt->SetData(0, uint16(id));

                CharacterDatabase.Execute(stmt);

                continue;
            }

            if (criteria->timeLimit && time_t(date + criteria->timeLimit) < GameTime::GetGameTime().count())
                continue;

            CriteriaProgress& progress = _criteriaProgress[id];
            progress.counter = counter;
            progress.date    = date;
            progress.changed = false;
        } while (criteriaResult->NextRow());
    }
}

void AchievementMgr::SendAchievementEarned(AchievementEntry const* achievement) const
{
    if (GetPlayer()->GetSession()->PlayerLoading())
        return;

    // Don't send for achievements with ACHIEVEMENT_FLAG_TRACKING
    if (achievement->flags & ACHIEVEMENT_FLAG_HIDDEN)
        return;

    LOG_DEBUG("achievement", "AchievementMgr::SendAchievementEarned({})", achievement->ID);

    Guild* guild = sGuildMgr->GetGuildById(GetPlayer()->GetGuildId());
    if (guild)
    {
        Acore::BroadcastTextBuilder _builder(GetPlayer(), CHAT_MSG_GUILD_ACHIEVEMENT, BROADCAST_TEXT_ACHIEVEMENT_EARNED, GetPlayer()->getGender(), GetPlayer(), achievement->ID);
        Acore::LocalizedPacketDo<Acore::BroadcastTextBuilder> _localizer(_builder);
        guild->BroadcastWorker(_localizer, GetPlayer());
    }

    if (achievement->flags & (ACHIEVEMENT_FLAG_REALM_FIRST_KILL | ACHIEVEMENT_FLAG_REALM_FIRST_REACH))
    {
        // If guild exists - send its name to the server
        // If guild does not exist - send player's name to the server
        if (achievement->flags & ACHIEVEMENT_FLAG_REALM_FIRST_KILL && guild)
        {
            WorldPacket data(SMSG_SERVER_FIRST_ACHIEVEMENT, guild->GetName().size() + 1 + 8 + 4 + 4);
            data << guild->GetName();
            data << GetPlayer()->GetGUID();
            data << uint32(achievement->ID);
            data << uint32(0);                                  // display name as plain string in chat (always 0 for guild)
            sWorld->SendGlobalMessage(&data);
        }
        else
        {
            TeamId teamId = GetPlayer()->GetTeamId();

            // broadcast realm first reached
            WorldPacket data(SMSG_SERVER_FIRST_ACHIEVEMENT, GetPlayer()->GetName().size() + 1 + 8 + 4 + 4);
            data << GetPlayer()->GetName();
            data << GetPlayer()->GetGUID();
            data << uint32(achievement->ID);
            std::size_t linkTypePos = data.wpos();
            data << uint32(1);                                  // display name as clickable link in chat
            sWorld->SendGlobalMessage(&data, nullptr, teamId);

            data.put<uint32>(linkTypePos, 0);                   // display name as plain string in chat
            sWorld->SendGlobalMessage(&data, nullptr, teamId == TEAM_ALLIANCE ? TEAM_HORDE : TEAM_ALLIANCE);
        }
    }
    // if player is in world he can tell his friends about new achievement
    else if (GetPlayer()->IsInWorld())
    {
        CellCoord p = Acore::ComputeCellCoord(GetPlayer()->GetPositionX(), GetPlayer()->GetPositionY());

        Cell cell(p);
        cell.SetNoCreate();

        Acore::BroadcastTextBuilder _builder(GetPlayer(), CHAT_MSG_ACHIEVEMENT, BROADCAST_TEXT_ACHIEVEMENT_EARNED, GetPlayer()->getGender(), GetPlayer(), achievement->ID);
        Acore::LocalizedPacketDo<Acore::BroadcastTextBuilder> _localizer(_builder);
        Acore::PlayerDistWorker<Acore::LocalizedPacketDo<Acore::BroadcastTextBuilder>> _worker(GetPlayer(), sWorld->getFloatConfig(CONFIG_LISTEN_RANGE_SAY), _localizer);
        TypeContainerVisitor<Acore::PlayerDistWorker<Acore::LocalizedPacketDo<Acore::BroadcastTextBuilder> >, WorldTypeMapContainer > message(_worker);
        Cell::VisitWorldObjects(GetPlayer(), _worker, sWorld->getFloatConfig(CONFIG_LISTEN_RANGE_SAY));
    }

    WorldPacket data(SMSG_ACHIEVEMENT_EARNED, 8 + 4 + 8);
    data << GetPlayer()->GetPackGUID();
    data << uint32(achievement->ID);
    data.AppendPackedTime(GameTime::GetGameTime().count());
    data << uint32(0);
    GetPlayer()->SendMessageToSetInRange(&data, sWorld->getFloatConfig(CONFIG_LISTEN_RANGE_SAY), true);
}

void AchievementMgr::SendCriteriaUpdate(AchievementCriteriaEntry const* entry, CriteriaProgress const* progress, uint32 timeElapsed, bool timedCompleted) const
{
    WorldPacket data(SMSG_CRITERIA_UPDATE, 8 + 4 + 8);
    data << uint32(entry->ID);

    // the counter is packed like a packed Guid
    data.appendPackGUID(progress->counter);

    data << GetPlayer()->GetPackGUID();
    if (!entry->timeLimit)
        data << uint32(0);
    else
        data << uint32(timedCompleted ? 0 : 1); // 1 is for keeping the counter at 0 in client
    data.AppendPackedTime(progress->date);
    data << uint32(timeElapsed);    // time elapsed in seconds

    if (sAchievementMgr->IsAverageCriteria(entry))
        data << uint32(GameTime::GetGameTime().count() - GetPlayer()->GetCreationTime().count());    // for average achievements
    else
        data << uint32(timeElapsed);    // time elapsed in seconds

    GetPlayer()->SendDirectMessage(&data);
}

/**
 * called at player login. The player might have fulfilled some achievements when the achievement system wasn't working yet.
 */
void AchievementMgr::CheckAllAchievementCriteria()
{
    // suppress sending packets
    for (uint32 i = 0; i < ACHIEVEMENT_CRITERIA_TYPE_TOTAL; ++i)
        UpdateAchievementCriteria(AchievementCriteriaTypes(i));
}

static const uint32 achievIdByArenaSlot[MAX_ARENA_SLOT] = { 1057, 1107, 1108 };
static const uint32 achievIdForDungeon[][4] =
{
    // ach_cr_id, is_dungeon, is_raid, is_heroic_dungeon
    { 321,       true,      true,   true  },
    { 916,       false,     true,   false },
    { 917,       false,     true,   false },
    { 918,       true,      false,  false },
    { 2219,      false,     false,  true  },
    { 0,         false,     false,  false }
};

/**
 * this function will be called whenever the user might have done a criteria relevant action
 */
void AchievementMgr::UpdateAchievementCriteria(AchievementCriteriaTypes type, uint32 miscValue1 /*= 0*/, uint32 miscValue2 /*= 0*/, Unit* unit /*= nullptr*/)
{
    // disable for gamemasters with GM-mode enabled
    if (_player->IsGameMaster())
        return;

    if (type >= ACHIEVEMENT_CRITERIA_TYPE_TOTAL)
    {
        LOG_DEBUG("achievement", "UpdateAchievementCriteria: Wrong criteria type {}", type);
        return;
    }

    LOG_DEBUG("achievement", "AchievementMgr::UpdateAchievementCriteria({}, {}, {})", type, miscValue1, miscValue2);

    AchievementCriteriaEntryList const* achievementCriteriaList = nullptr;

    switch (type)
    {
        case ACHIEVEMENT_CRITERIA_TYPE_KILL_CREATURE:
        case ACHIEVEMENT_CRITERIA_TYPE_WIN_BG:
        case ACHIEVEMENT_CRITERIA_TYPE_REACH_SKILL_LEVEL:
        case ACHIEVEMENT_CRITERIA_TYPE_COMPLETE_ACHIEVEMENT:
        case ACHIEVEMENT_CRITERIA_TYPE_COMPLETE_QUESTS_IN_ZONE:
        case ACHIEVEMENT_CRITERIA_TYPE_COMPLETE_BATTLEGROUND:
        case ACHIEVEMENT_CRITERIA_TYPE_KILLED_BY_CREATURE:
        case ACHIEVEMENT_CRITERIA_TYPE_COMPLETE_QUEST:
        case ACHIEVEMENT_CRITERIA_TYPE_BE_SPELL_TARGET:
        case ACHIEVEMENT_CRITERIA_TYPE_CAST_SPELL:
        case ACHIEVEMENT_CRITERIA_TYPE_BG_OBJECTIVE_CAPTURE:
        case ACHIEVEMENT_CRITERIA_TYPE_HONORABLE_KILL_AT_AREA:
        case ACHIEVEMENT_CRITERIA_TYPE_LEARN_SPELL:
        case ACHIEVEMENT_CRITERIA_TYPE_OWN_ITEM:
        case ACHIEVEMENT_CRITERIA_TYPE_LEARN_SKILL_LEVEL:
        case ACHIEVEMENT_CRITERIA_TYPE_USE_ITEM:
        case ACHIEVEMENT_CRITERIA_TYPE_LOOT_ITEM:
        case ACHIEVEMENT_CRITERIA_TYPE_EXPLORE_AREA:
        case ACHIEVEMENT_CRITERIA_TYPE_GAIN_REPUTATION:
        case ACHIEVEMENT_CRITERIA_TYPE_HK_CLASS:
        case ACHIEVEMENT_CRITERIA_TYPE_HK_RACE:
        case ACHIEVEMENT_CRITERIA_TYPE_DO_EMOTE:
        case ACHIEVEMENT_CRITERIA_TYPE_EQUIP_ITEM:
        case ACHIEVEMENT_CRITERIA_TYPE_USE_GAMEOBJECT:
        case ACHIEVEMENT_CRITERIA_TYPE_BE_SPELL_TARGET2:
        case ACHIEVEMENT_CRITERIA_TYPE_FISH_IN_GAMEOBJECT:
        case ACHIEVEMENT_CRITERIA_TYPE_LEARN_SKILLLINE_SPELLS:
        case ACHIEVEMENT_CRITERIA_TYPE_LOOT_TYPE:
        case ACHIEVEMENT_CRITERIA_TYPE_CAST_SPELL2:
        case ACHIEVEMENT_CRITERIA_TYPE_LEARN_SKILL_LINE:
            if (miscValue1)
            {
                achievementCriteriaList = sAchievementMgr->GetSpecialAchievementCriteriaByType(type, miscValue1);
                break;
            }
            achievementCriteriaList = sAchievementMgr->GetAchievementCriteriaByType(type);
            break;
        case ACHIEVEMENT_CRITERIA_TYPE_EQUIP_EPIC_ITEM:
            if (miscValue2)
            {
                achievementCriteriaList = sAchievementMgr->GetSpecialAchievementCriteriaByType(type, miscValue2);
                break;
            }
            achievementCriteriaList = sAchievementMgr->GetAchievementCriteriaByType(type);
            break;
        default:
            achievementCriteriaList = sAchievementMgr->GetAchievementCriteriaByType(type);
            break;
    }

    if (!achievementCriteriaList)
        return;

    sScriptMgr->OnBeforeCheckCriteria(this, achievementCriteriaList);

    for (AchievementCriteriaEntryList::const_iterator i = achievementCriteriaList->begin(); i != achievementCriteriaList->end(); ++i)
    {
        AchievementCriteriaEntry const* achievementCriteria = (*i);
        AchievementEntry const* achievement = sAchievementStore.LookupEntry(achievementCriteria->referredAchievement);
        if (!achievement)
            continue;

        if (!CanUpdateCriteria(achievementCriteria, achievement))
            continue;

        if (!sScriptMgr->CanCheckCriteria(this, achievementCriteria))
            continue;

        switch (type)
        {
            // std. case: increment at 1
            case ACHIEVEMENT_CRITERIA_TYPE_NUMBER_OF_TALENT_RESETS:
            case ACHIEVEMENT_CRITERIA_TYPE_LOSE_DUEL:
            case ACHIEVEMENT_CRITERIA_TYPE_CREATE_AUCTION:
            case ACHIEVEMENT_CRITERIA_TYPE_WON_AUCTIONS:    /* FIXME: for online player only currently */
            case ACHIEVEMENT_CRITERIA_TYPE_ROLL_NEED:
            case ACHIEVEMENT_CRITERIA_TYPE_ROLL_GREED:
            case ACHIEVEMENT_CRITERIA_TYPE_ROLL_DISENCHANT:
            case ACHIEVEMENT_CRITERIA_TYPE_QUEST_ABANDONED:
            case ACHIEVEMENT_CRITERIA_TYPE_FLIGHT_PATHS_TAKEN:
            case ACHIEVEMENT_CRITERIA_TYPE_ACCEPTED_SUMMONINGS:
                // AchievementMgr::UpdateAchievementCriteria might also be called on login - skip in this case
                if (!miscValue1)
                    continue;
                SetCriteriaProgress(achievementCriteria, 1, PROGRESS_ACCUMULATE);
                break;
            // std case: increment at miscvalue1
            case ACHIEVEMENT_CRITERIA_TYPE_MONEY_FROM_VENDORS:
            case ACHIEVEMENT_CRITERIA_TYPE_GOLD_SPENT_FOR_TALENTS:
            case ACHIEVEMENT_CRITERIA_TYPE_MONEY_FROM_QUEST_REWARD:
            case ACHIEVEMENT_CRITERIA_TYPE_GOLD_SPENT_FOR_TRAVELLING:
            case ACHIEVEMENT_CRITERIA_TYPE_GOLD_SPENT_AT_BARBER:
            case ACHIEVEMENT_CRITERIA_TYPE_GOLD_SPENT_FOR_MAIL:
            case ACHIEVEMENT_CRITERIA_TYPE_LOOT_MONEY:
            case ACHIEVEMENT_CRITERIA_TYPE_GOLD_EARNED_BY_AUCTIONS:/* FIXME: for online player only currently */
            case ACHIEVEMENT_CRITERIA_TYPE_TOTAL_DAMAGE_RECEIVED:
            case ACHIEVEMENT_CRITERIA_TYPE_TOTAL_HEALING_RECEIVED:
            case ACHIEVEMENT_CRITERIA_TYPE_USE_LFD_TO_GROUP_WITH_PLAYERS:
                // AchievementMgr::UpdateAchievementCriteria might also be called on login - skip in this case
                if (!miscValue1)
                    continue;
                SetCriteriaProgress(achievementCriteria, miscValue1, PROGRESS_ACCUMULATE);
                break;
            // std case: high value at miscvalue1
            case ACHIEVEMENT_CRITERIA_TYPE_HIGHEST_AUCTION_BID:
            case ACHIEVEMENT_CRITERIA_TYPE_HIGHEST_AUCTION_SOLD: /* FIXME: for online player only currently */
            case ACHIEVEMENT_CRITERIA_TYPE_HIGHEST_HIT_DEALT:
            case ACHIEVEMENT_CRITERIA_TYPE_HIGHEST_HIT_RECEIVED:
            case ACHIEVEMENT_CRITERIA_TYPE_HIGHEST_HEAL_CASTED:
            case ACHIEVEMENT_CRITERIA_TYPE_HIGHEST_HEALING_RECEIVED:
                // AchievementMgr::UpdateAchievementCriteria might also be called on login - skip in this case
                if (!miscValue1)
                    continue;
                SetCriteriaProgress(achievementCriteria, miscValue1, PROGRESS_HIGHEST);
                break;

            // specialized cases
            case ACHIEVEMENT_CRITERIA_TYPE_COMPLETE_DAILY_QUEST:
                {
                    // AchievementMgr::UpdateAchievementCriteria might also be called on login - skip in this case
                    if (!miscValue1)
                        continue;

                    if (achievement->categoryId == CATEGORY_CHILDRENS_WEEK)
                    {
                        AchievementCriteriaDataSet const* data = sAchievementMgr->GetCriteriaDataSet(achievementCriteria);
                        if (!data || !data->Meets(GetPlayer(), nullptr))
                            continue;
                    }

                    SetCriteriaProgress(achievementCriteria, 1, PROGRESS_ACCUMULATE);
                    break;
                }
            case ACHIEVEMENT_CRITERIA_TYPE_WIN_BG:
                {
                    // AchievementMgr::UpdateAchievementCriteria might also be called on login - skip in this case
                    if (!miscValue1)
                        continue;
                    if (achievementCriteria->win_bg.bgMapID != GetPlayer()->GetMapId())
                        continue;

                    // those requirements couldn't be found in the dbc
                    AchievementCriteriaDataSet const* data = sAchievementMgr->GetCriteriaDataSet(achievementCriteria);
                    if (!data || !data->Meets(GetPlayer(), unit))
                        continue;

                    SetCriteriaProgress(achievementCriteria, 1, PROGRESS_ACCUMULATE);
                    break;
                }
            case ACHIEVEMENT_CRITERIA_TYPE_KILL_CREATURE:
                {
                    // AchievementMgr::UpdateAchievementCriteria might also be called on login - skip in this case
                    if (!miscValue1)
                        continue;
                    if (achievementCriteria->kill_creature.creatureID != miscValue1)
                        continue;

                    // those requirements couldn't be found in the dbc
                    AchievementCriteriaDataSet const* data = sAchievementMgr->GetCriteriaDataSet(achievementCriteria);
                    if (!data || !data->Meets(GetPlayer(), unit))
                        continue;

                    SetCriteriaProgress(achievementCriteria, miscValue2, PROGRESS_ACCUMULATE);
                    break;
                }
            case ACHIEVEMENT_CRITERIA_TYPE_KILL_CREATURE_TYPE:
                {
                    // AchievementMgr::UpdateAchievementCriteria might also be called on login - skip in this case
                    if (!miscValue2)
                        continue;

                    // those requirements couldn't be found in the dbc
                    AchievementCriteriaDataSet const* data = sAchievementMgr->GetCriteriaDataSet(achievementCriteria);
                    if (!data || !data->Meets(GetPlayer(), unit, miscValue1))
                        continue;

                    SetCriteriaProgress(achievementCriteria, miscValue2, PROGRESS_ACCUMULATE);
                    break;
                }
            case ACHIEVEMENT_CRITERIA_TYPE_REACH_LEVEL:
                if (AchievementCriteriaDataSet const* data = sAchievementMgr->GetCriteriaDataSet(achievementCriteria))
                    if (!data->Meets(GetPlayer(), unit))
                        continue;
                SetCriteriaProgress(achievementCriteria, GetPlayer()->GetLevel());
                break;
            case ACHIEVEMENT_CRITERIA_TYPE_REACH_SKILL_LEVEL:
                // update at loading or specific skill update
                if (miscValue1 && miscValue1 != achievementCriteria->reach_skill_level.skillID)
                    continue;
                if (uint32 skillvalue = GetPlayer()->GetBaseSkillValue(achievementCriteria->reach_skill_level.skillID))
                    SetCriteriaProgress(achievementCriteria, skillvalue);
                break;
            case ACHIEVEMENT_CRITERIA_TYPE_LEARN_SKILL_LEVEL:
                // update at loading or specific skill update
                if (miscValue1 && miscValue1 != achievementCriteria->learn_skill_level.skillID)
                    continue;
                if (uint32 maxSkillvalue = GetPlayer()->GetPureMaxSkillValue(achievementCriteria->learn_skill_level.skillID))
                    SetCriteriaProgress(achievementCriteria, maxSkillvalue);
                break;
            case ACHIEVEMENT_CRITERIA_TYPE_COMPLETE_ACHIEVEMENT:
                if ((miscValue1 && achievementCriteria->complete_achievement.linkedAchievement == miscValue1) || (!miscValue1 && GetPlayer()->HasAchieved(achievementCriteria->complete_achievement.linkedAchievement)))
                    SetCriteriaProgress(achievementCriteria, 1);
                break;
            case ACHIEVEMENT_CRITERIA_TYPE_COMPLETE_QUEST_COUNT:
                {
                    SetCriteriaProgress(achievementCriteria, GetPlayer()->GetRewardedQuestCount());
                    break;
                }
            case ACHIEVEMENT_CRITERIA_TYPE_COMPLETE_DAILY_QUEST_DAILY:
                {
                    Seconds nextDailyResetTime = sWorld->GetNextDailyQuestsResetTime();
                    CriteriaProgress* progress = GetCriteriaProgress(achievementCriteria);

                    if (!miscValue1) // Login case.
                    {
                        // reset if player missed one day.
                        if (progress && Seconds(progress->date) < (nextDailyResetTime - 2_days))
                            SetCriteriaProgress(achievementCriteria, 0, PROGRESS_SET);
                        continue;
                    }

                    ProgressType progressType;
                    if (!progress)
                        // 1st time. Start count.
                        progressType = PROGRESS_SET;
                    else if (Seconds(progress->date) < (nextDailyResetTime - 2_days))
                        // last progress is older than 2 days. Player missed 1 day => Retart count.
                        progressType = PROGRESS_RESET;
                    else if (Seconds(progress->date) < (nextDailyResetTime - 1_days))
                        // last progress is between 1 and 2 days. => 1st time of the day.
                        progressType = PROGRESS_ACCUMULATE;
                    else
                        // last progress is within the day before the reset => Already counted today.
                        continue;

                    SetCriteriaProgress(achievementCriteria, 1, progressType);
                    break;
                }
            case ACHIEVEMENT_CRITERIA_TYPE_COMPLETE_QUESTS_IN_ZONE:
                {
                    // speedup for non-login case
                    if (miscValue1 && miscValue1 != achievementCriteria->complete_quests_in_zone.zoneID)
                        continue;

                    uint32 counter = 0;

                    const RewardedQuestSet& rewQuests = GetPlayer()->getRewardedQuests();
                    for (RewardedQuestSet::const_iterator itr = rewQuests.begin(); itr != rewQuests.end(); ++itr)
                    {
                        Quest const* quest = sObjectMgr->GetQuestTemplate(*itr);
                        if (quest && quest->GetZoneOrSort() >= 0 && uint32(quest->GetZoneOrSort()) == achievementCriteria->complete_quests_in_zone.zoneID)
                            ++counter;
                    }
                    SetCriteriaProgress(achievementCriteria, counter);
                    break;
                }
            case ACHIEVEMENT_CRITERIA_TYPE_COMPLETE_BATTLEGROUND:
                // AchievementMgr::UpdateAchievementCriteria might also be called on login - skip in this case
                if (!miscValue1)
                    continue;
                if (GetPlayer()->GetMapId() != achievementCriteria->complete_battleground.mapID)
                    continue;
                SetCriteriaProgress(achievementCriteria, 1, PROGRESS_ACCUMULATE);
                break;
            case ACHIEVEMENT_CRITERIA_TYPE_DEATH_AT_MAP:
                // AchievementMgr::UpdateAchievementCriteria might also be called on login - skip in this case
                if (!miscValue1)
                    continue;
                if (GetPlayer()->GetMapId() != achievementCriteria->death_at_map.mapID)
                    continue;
                SetCriteriaProgress(achievementCriteria, 1, PROGRESS_ACCUMULATE);
                break;
            case ACHIEVEMENT_CRITERIA_TYPE_DEATH:
                {
                    // AchievementMgr::UpdateAchievementCriteria might also be called on login - skip in this case
                    if (!miscValue1)
                        continue;
                    // skip wrong arena achievements, if not achievIdByArenaSlot then normal total death counter
                    bool notfit = false;
                    for (int j = 0; j < MAX_ARENA_SLOT; ++j)
                    {
                        if (achievIdByArenaSlot[j] == achievement->ID)
                        {
                            Battleground* bg = GetPlayer()->GetBattleground();
                            if (!bg || !bg->isArena() || ArenaTeam::GetSlotByType(bg->GetArenaType()) != j)
                                notfit = true;

                            break;
                        }
                    }
                    if (notfit)
                        continue;

                    SetCriteriaProgress(achievementCriteria, 1, PROGRESS_ACCUMULATE);
                    break;
                }
            case ACHIEVEMENT_CRITERIA_TYPE_DEATH_IN_DUNGEON:
                {
                    // AchievementMgr::UpdateAchievementCriteria might also be called on login - skip in this case
                    if (!miscValue1)
                        continue;

                    Map const* map = GetPlayer()->IsInWorld() ? GetPlayer()->GetMap() : sMapMgr->FindMap(GetPlayer()->GetMapId(), GetPlayer()->GetInstanceId());
                    if (!map || !map->IsDungeon())
                        continue;

                    // search case
                    bool found = false;
                    for (int j = 0; achievIdForDungeon[j][0]; ++j)
                    {
                        if (achievIdForDungeon[j][0] == achievement->ID)
                        {
                            if (map->IsRaid())
                            {
                                // if raid accepted (ignore difficulty)
                                if (!achievIdForDungeon[j][2])
                                    break;                      // for
                            }
                            else if (GetPlayer()->GetDungeonDifficulty() == DUNGEON_DIFFICULTY_NORMAL)
                            {
                                // dungeon in normal mode accepted
                                if (!achievIdForDungeon[j][1])
                                    break;                      // for
                            }
                            else
                            {
                                // dungeon in heroic mode accepted
                                if (!achievIdForDungeon[j][3])
                                    break;                      // for
                            }

                            found = true;
                            break;                              // for
                        }
                    }
                    if (!found)
                        continue;

                    //FIXME: work only for instances where max == min for players
                    if (map->ToInstanceMap()->GetMaxPlayers() != achievementCriteria->death_in_dungeon.manLimit)
                        continue;
                    SetCriteriaProgress(achievementCriteria, 1, PROGRESS_ACCUMULATE);
                    break;
                }
            case ACHIEVEMENT_CRITERIA_TYPE_COMPLETE_RAID:
                {
                    // AchievementMgr::UpdateAchievementCriteria might also be called on login - skip in this case
                    if (!miscValue1)
                        continue;

                    Map const* map = GetPlayer()->IsInWorld() ? GetPlayer()->GetMap() : sMapMgr->FindMap(GetPlayer()->GetMapId(), GetPlayer()->GetInstanceId());
                    if (!map || !map->IsDungeon())
                        continue;

                    if (map->ToInstanceMap()->GetMaxPlayers() != achievementCriteria->complete_raid.groupSize)
                        continue;
                    SetCriteriaProgress(achievementCriteria, 1, PROGRESS_ACCUMULATE);
                    break;
                }
            case ACHIEVEMENT_CRITERIA_TYPE_KILLED_BY_CREATURE:
                // AchievementMgr::UpdateAchievementCriteria might also be called on login - skip in this case
                if (!miscValue1)
                    continue;
                if (miscValue1 != achievementCriteria->killed_by_creature.creatureEntry)
                    continue;
                SetCriteriaProgress(achievementCriteria, 1, PROGRESS_ACCUMULATE);
                break;
            case ACHIEVEMENT_CRITERIA_TYPE_KILLED_BY_PLAYER:
                // AchievementMgr::UpdateAchievementCriteria might also be called on login - skip in this case
                if (!miscValue1)
                    continue;

                // if team check required: must kill by opposition faction
                if (achievement->ID == 318 && miscValue2 == GetPlayer()->GetTeamId())
                    continue;

                SetCriteriaProgress(achievementCriteria, 1, PROGRESS_ACCUMULATE);
                break;
            case ACHIEVEMENT_CRITERIA_TYPE_FALL_WITHOUT_DYING:
                {
                    // AchievementMgr::UpdateAchievementCriteria might also be called on login - skip in this case
                    if (!miscValue1)
                        continue;

                    // those requirements couldn't be found in the dbc
                    AchievementCriteriaDataSet const* data = sAchievementMgr->GetCriteriaDataSet(achievementCriteria);
                    if (!data || !data->Meets(GetPlayer(), unit))
                        continue;

                    // miscvalue1 is the ingame fallheight*100 as stored in dbc
                    SetCriteriaProgress(achievementCriteria, miscValue1);
                    break;
                }
            case ACHIEVEMENT_CRITERIA_TYPE_DEATHS_FROM:
                // AchievementMgr::UpdateAchievementCriteria might also be called on login - skip in this case
                if (!miscValue1)
                    continue;
                if (miscValue2 != achievementCriteria->death_from.type)
                    continue;
                SetCriteriaProgress(achievementCriteria, 1, PROGRESS_ACCUMULATE);
                break;
            case ACHIEVEMENT_CRITERIA_TYPE_COMPLETE_QUEST:
                {
                    // if miscvalues != 0, it contains the questID.
                    if (miscValue1)
                    {
                        if (miscValue1 != achievementCriteria->complete_quest.questID)
                            continue;
                    }
                    else
                    {
                        // login case.
                        if (!GetPlayer()->GetQuestRewardStatus(achievementCriteria->complete_quest.questID))
                            continue;
                    }

                    if (AchievementCriteriaDataSet const* data = sAchievementMgr->GetCriteriaDataSet(achievementCriteria))
                        if (!data->Meets(GetPlayer(), unit))
                            continue;

                    SetCriteriaProgress(achievementCriteria, 1);
                    break;
                }
            case ACHIEVEMENT_CRITERIA_TYPE_BE_SPELL_TARGET:
            case ACHIEVEMENT_CRITERIA_TYPE_BE_SPELL_TARGET2:
                {
                    if (!miscValue1 || miscValue1 != achievementCriteria->be_spell_target.spellID)
                        continue;

                    // those requirements couldn't be found in the dbc
                    AchievementCriteriaDataSet const* data = sAchievementMgr->GetCriteriaDataSet(achievementCriteria);
                    if (!data)
                        continue;

                    if (!data->Meets(GetPlayer(), unit))
                        continue;

                    SetCriteriaProgress(achievementCriteria, 1, PROGRESS_ACCUMULATE);
                    break;
                }
            case ACHIEVEMENT_CRITERIA_TYPE_CAST_SPELL:
            case ACHIEVEMENT_CRITERIA_TYPE_CAST_SPELL2:
                {
                    if (!miscValue1 || miscValue1 != achievementCriteria->cast_spell.spellID)
                        continue;

                    // those requirements couldn't be found in the dbc
                    AchievementCriteriaDataSet const* data = sAchievementMgr->GetCriteriaDataSet(achievementCriteria);
                    if (!data)
                        continue;

                    if (!data->Meets(GetPlayer(), unit))
                        continue;

                    SetCriteriaProgress(achievementCriteria, 1, PROGRESS_ACCUMULATE);
                    break;
                }
            case ACHIEVEMENT_CRITERIA_TYPE_LEARN_SPELL:
                if (miscValue1 && miscValue1 != achievementCriteria->learn_spell.spellID)
                    continue;

                if (GetPlayer()->HasSpell(achievementCriteria->learn_spell.spellID))
                    SetCriteriaProgress(achievementCriteria, 1);
                break;
            case ACHIEVEMENT_CRITERIA_TYPE_LOOT_TYPE:
                {
                    // miscvalue1=loot_type (note: 0 = LOOT_CORPSE and then it ignored)
                    // miscvalue2=count of item loot
                    if (!miscValue1 || !miscValue2)
                        continue;
                    if (miscValue1 != achievementCriteria->loot_type.lootType)
                        continue;

                    // zone specific
                    if (achievementCriteria->loot_type.lootTypeCount == 1)
                    {
                        // those requirements couldn't be found in the dbc
                        AchievementCriteriaDataSet const* data = sAchievementMgr->GetCriteriaDataSet(achievementCriteria);
                        if (!data || !data->Meets(GetPlayer(), unit))
                            continue;
                    }

                    SetCriteriaProgress(achievementCriteria, miscValue2, PROGRESS_ACCUMULATE);
                    break;
                }
            case ACHIEVEMENT_CRITERIA_TYPE_OWN_ITEM:
                // speedup for non-login case
                if (miscValue1 && achievementCriteria->own_item.itemID != miscValue1)
                    continue;
                SetCriteriaProgress(achievementCriteria, miscValue2, PROGRESS_ACCUMULATE);
                break;
            case ACHIEVEMENT_CRITERIA_TYPE_WIN_RATED_ARENA:
                if (!miscValue1)                            // no update at login
                    continue;

                // additional requirements
                if (achievementCriteria->additionalRequirements[0].additionalRequirement_type == ACHIEVEMENT_CRITERIA_CONDITION_NO_LOSE)
                {
                    // those requirements couldn't be found in the dbc
                    AchievementCriteriaDataSet const* data = sAchievementMgr->GetCriteriaDataSet(achievementCriteria);
                    if (!data || !data->Meets(GetPlayer(), unit, miscValue1))
                    {
                        // reset the progress as we have a win without the requirement.
                        SetCriteriaProgress(achievementCriteria, 0);
                        continue;
                    }
                }

                SetCriteriaProgress(achievementCriteria, 1, PROGRESS_ACCUMULATE);
                break;
            case ACHIEVEMENT_CRITERIA_TYPE_USE_ITEM:
                // AchievementMgr::UpdateAchievementCriteria might also be called on login - skip in this case
                if (!miscValue1)
                    continue;

                if (achievementCriteria->use_item.itemID != miscValue1)
                    continue;

                // Children's Week achievements have extra requirements
                //if (achievement->categoryId == CATEGORY_CHILDRENS_WEEK || achievement->ID == 1291) // Lonely?
                {
                    // Xinef: skip progress only if data exists and is not meet
                    AchievementCriteriaDataSet const* data = sAchievementMgr->GetCriteriaDataSet(achievementCriteria);
                    if (data && !data->Meets(GetPlayer(), nullptr))
                        continue;
                }

                SetCriteriaProgress(achievementCriteria, 1, PROGRESS_ACCUMULATE);
                break;
            case ACHIEVEMENT_CRITERIA_TYPE_LOOT_ITEM:
                // You _have_ to loot that item, just owning it when logging in does _not_ count!
                if (!miscValue1)
                    continue;
                if (miscValue1 != achievementCriteria->own_item.itemID)
                    continue;
                SetCriteriaProgress(achievementCriteria, miscValue2, PROGRESS_ACCUMULATE);
                break;
            case ACHIEVEMENT_CRITERIA_TYPE_EXPLORE_AREA:
                {
                    WorldMapOverlayEntry const* worldOverlayEntry = sWorldMapOverlayStore.LookupEntry(achievementCriteria->explore_area.areaReference);
                    if (!worldOverlayEntry)
                        break;

                    bool matchFound = false;
                    for (int j = 0; j < MAX_WORLD_MAP_OVERLAY_AREA_IDX; ++j)
                    {
                        AreaTableEntry const* area = sAreaTableStore.LookupEntry(worldOverlayEntry->areatableID[j]);
                        if (!area)
                            break;

                        uint32 playerIndexOffset = uint32(area->exploreFlag) / 32;
                        if (playerIndexOffset >= PLAYER_EXPLORED_ZONES_SIZE)
                            continue;

                        uint32 mask = 1 << (uint32(area->exploreFlag) % 32);
                        if (GetPlayer()->GetUInt32Value(PLAYER_EXPLORED_ZONES_1 + playerIndexOffset) & mask)
                        {
                            matchFound = true;
                            break;
                        }
                    }

                    if (matchFound)
                        SetCriteriaProgress(achievementCriteria, 1);
                    break;
                }
            case ACHIEVEMENT_CRITERIA_TYPE_BUY_BANK_SLOT:
                SetCriteriaProgress(achievementCriteria, GetPlayer()->GetBankBagSlotCount());
                break;
            case ACHIEVEMENT_CRITERIA_TYPE_GAIN_REPUTATION:
                {
                    // skip faction check only at loading
                    if (miscValue1 && miscValue1 != achievementCriteria->gain_reputation.factionID)
                        continue;

                    int32 reputation = GetPlayer()->GetReputationMgr().GetReputation(achievementCriteria->gain_reputation.factionID);
                    if (reputation > 0)
                        SetCriteriaProgress(achievementCriteria, reputation);
                    break;
                }
            case ACHIEVEMENT_CRITERIA_TYPE_GAIN_EXALTED_REPUTATION:
                {
                    SetCriteriaProgress(achievementCriteria, GetPlayer()->GetReputationMgr().GetExaltedFactionCount());
                    break;
                }
            case ACHIEVEMENT_CRITERIA_TYPE_VISIT_BARBER_SHOP:
                {
                    // skip for login case
                    if (!miscValue1)
                        continue;
                    SetCriteriaProgress(achievementCriteria, 1);
                    break;
                }
            case ACHIEVEMENT_CRITERIA_TYPE_EQUIP_EPIC_ITEM:
                {
                    // miscvalue1 = itemid
                    // miscvalue2 = itemSlot
                    if (!miscValue1)
                        continue;

                    if (miscValue2 != achievementCriteria->equip_epic_item.itemSlot)
                        continue;

                    // check item level and quality via achievement_criteria_data
                    AchievementCriteriaDataSet const* data = sAchievementMgr->GetCriteriaDataSet(achievementCriteria);
                    if (!data || !data->Meets(GetPlayer(), 0, miscValue1))
                        continue;

                    SetCriteriaProgress(achievementCriteria, 1);
                    break;
                }

            case ACHIEVEMENT_CRITERIA_TYPE_ROLL_NEED_ON_LOOT:
            case ACHIEVEMENT_CRITERIA_TYPE_ROLL_GREED_ON_LOOT:
                {
                    // miscvalue1 = itemid
                    // miscvalue2 = diced value
                    if (!miscValue1)
                        continue;
                    if (miscValue2 != achievementCriteria->roll_greed_on_loot.rollValue)
                        continue;

                    ItemTemplate const* pProto = sObjectMgr->GetItemTemplate(miscValue1);
                    if (!pProto)
                        continue;

                    // check item level via achievement_criteria_data
                    AchievementCriteriaDataSet const* data = sAchievementMgr->GetCriteriaDataSet(achievementCriteria);
                    if (!data || !data->Meets(GetPlayer(), 0, pProto->ItemLevel))
                        continue;

                    SetCriteriaProgress(achievementCriteria, 1, PROGRESS_ACCUMULATE);
                    break;
                }
            case ACHIEVEMENT_CRITERIA_TYPE_DO_EMOTE:
                {
                    // miscvalue1 = emote
                    if (!miscValue1)
                        continue;
                    if (miscValue1 != achievementCriteria->do_emote.emoteID)
                        continue;
                    if (achievementCriteria->do_emote.count)
                    {
                        // those requirements couldn't be found in the dbc
                        AchievementCriteriaDataSet const* data = sAchievementMgr->GetCriteriaDataSet(achievementCriteria);
                        if (!data || !data->Meets(GetPlayer(), unit))
                            continue;
                    }

                    SetCriteriaProgress(achievementCriteria, 1, PROGRESS_ACCUMULATE);
                    break;
                }
            case ACHIEVEMENT_CRITERIA_TYPE_DAMAGE_DONE:
            case ACHIEVEMENT_CRITERIA_TYPE_HEALING_DONE:
                {
                    if (!miscValue1)
                        continue;

                    if (achievementCriteria->additionalRequirements[0].additionalRequirement_type == ACHIEVEMENT_CRITERIA_CONDITION_BG_MAP)
                    {
                        if (GetPlayer()->GetMapId() != achievementCriteria->additionalRequirements[0].additionalRequirement_value)
                            continue;

                        // map specific case (BG in fact) expected player targeted damage/heal
                        if (!unit || unit->GetTypeId() != TYPEID_PLAYER)
                            continue;
                    }

                    SetCriteriaProgress(achievementCriteria, miscValue1, PROGRESS_ACCUMULATE);
                    break;
                }
            case ACHIEVEMENT_CRITERIA_TYPE_EQUIP_ITEM:
                // miscvalue1 = item_id
                if (!miscValue1)
                    continue;
                if (miscValue1 != achievementCriteria->equip_item.itemID)
                    continue;

                SetCriteriaProgress(achievementCriteria, 1);
                break;
            case ACHIEVEMENT_CRITERIA_TYPE_USE_GAMEOBJECT:
                // miscvalue1 = go entry
                if (!miscValue1)
                    continue;
                if (miscValue1 != achievementCriteria->use_gameobject.goEntry)
                    continue;

                SetCriteriaProgress(achievementCriteria, 1, PROGRESS_ACCUMULATE);
                break;
            case ACHIEVEMENT_CRITERIA_TYPE_FISH_IN_GAMEOBJECT:
                if (!miscValue1)
                    continue;
                if (miscValue1 != achievementCriteria->fish_in_gameobject.goEntry)
                    continue;

                SetCriteriaProgress(achievementCriteria, 1, PROGRESS_ACCUMULATE);
                break;
            case ACHIEVEMENT_CRITERIA_TYPE_LEARN_SKILLLINE_SPELLS:
                {
                    if (miscValue1 && miscValue1 != achievementCriteria->learn_skillline_spell.skillLine)
                        continue;

                    uint32 spellCount = 0;
                    for (PlayerSpellMap::const_iterator spellIter = GetPlayer()->GetSpellMap().begin(); spellIter != GetPlayer()->GetSpellMap().end(); ++spellIter)
                    {
                        SkillLineAbilityMapBounds bounds = sSpellMgr->GetSkillLineAbilityMapBounds(spellIter->first);
                        for (SkillLineAbilityMap::const_iterator skillIter = bounds.first; skillIter != bounds.second; ++skillIter)
                        {
                            if (skillIter->second->SkillLine == achievementCriteria->learn_skillline_spell.skillLine)
                            {
                                // xinef: do not add couter twice if by any chance skill is listed twice in dbc (eg. skill 777 and spell 22717)
                                ++spellCount;
                                break;
                            }
                        }
                    }

                    SetCriteriaProgress(achievementCriteria, spellCount);
                    break;
                }
            case ACHIEVEMENT_CRITERIA_TYPE_WIN_DUEL:
                // AchievementMgr::UpdateAchievementCriteria might also be called on login - skip in this case
                if (!miscValue1)
                    continue;

                if (achievementCriteria->win_duel.duelCount)
                {
                    // those requirements couldn't be found in the dbc
                    AchievementCriteriaDataSet const* data = sAchievementMgr->GetCriteriaDataSet(achievementCriteria);
                    if (!data)
                        continue;

                    if (!data->Meets(GetPlayer(), unit))
                        continue;
                }

                SetCriteriaProgress(achievementCriteria, 1, PROGRESS_ACCUMULATE);
                break;
            case ACHIEVEMENT_CRITERIA_TYPE_GAIN_REVERED_REPUTATION:
                SetCriteriaProgress(achievementCriteria, GetPlayer()->GetReputationMgr().GetReveredFactionCount());
                break;
            case ACHIEVEMENT_CRITERIA_TYPE_GAIN_HONORED_REPUTATION:
                SetCriteriaProgress(achievementCriteria, GetPlayer()->GetReputationMgr().GetHonoredFactionCount());
                break;
            case ACHIEVEMENT_CRITERIA_TYPE_KNOWN_FACTIONS:
                SetCriteriaProgress(achievementCriteria, GetPlayer()->GetReputationMgr().GetVisibleFactionCount());
                break;
            case ACHIEVEMENT_CRITERIA_TYPE_LOOT_EPIC_ITEM:
            case ACHIEVEMENT_CRITERIA_TYPE_RECEIVE_EPIC_ITEM:
                {
                    // AchievementMgr::UpdateAchievementCriteria might also be called on login - skip in this case
                    if (!miscValue1)
                        continue;
                    ItemTemplate const* proto = sObjectMgr->GetItemTemplate(miscValue1);
                    if (!proto || proto->Quality < ITEM_QUALITY_EPIC)
                        continue;
                    AchievementCriteriaDataSet const* data = sAchievementMgr->GetCriteriaDataSet(achievementCriteria);
                    if (!data || !data->Meets(GetPlayer(), unit, miscValue1))
                        continue;
                    SetCriteriaProgress(achievementCriteria, 1, PROGRESS_ACCUMULATE);
                    break;
                }
            case ACHIEVEMENT_CRITERIA_TYPE_LEARN_SKILL_LINE:
                {
                    if (miscValue1 && miscValue1 != achievementCriteria->learn_skill_line.skillLine)
                        continue;

                    uint32 spellCount = 0;
                    for (PlayerSpellMap::const_iterator spellIter = GetPlayer()->GetSpellMap().begin(); spellIter != GetPlayer()->GetSpellMap().end(); ++spellIter)
                    {
                        SkillLineAbilityMapBounds bounds = sSpellMgr->GetSkillLineAbilityMapBounds(spellIter->first);
                        for (SkillLineAbilityMap::const_iterator skillIter = bounds.first; skillIter != bounds.second; ++skillIter)
                        {
                            if (skillIter->second->SkillLine == achievementCriteria->learn_skill_line.skillLine)
                            {
                                // xinef: do not add couter twice if by any chance skill is listed twice in dbc (eg. skill 777 and spell 22717)
                                ++spellCount;
                                break;
                            }
                        }
                    }

                    SetCriteriaProgress(achievementCriteria, spellCount);
                    break;
                }
            case ACHIEVEMENT_CRITERIA_TYPE_EARN_HONORABLE_KILL:
                SetCriteriaProgress(achievementCriteria, GetPlayer()->GetUInt32Value(PLAYER_FIELD_LIFETIME_HONORABLE_KILLS));
                break;
            case ACHIEVEMENT_CRITERIA_TYPE_HK_CLASS:
                if (!miscValue1 || miscValue1 != achievementCriteria->hk_class.classID)
                    continue;

                SetCriteriaProgress(achievementCriteria, 1, PROGRESS_ACCUMULATE);
                break;
            case ACHIEVEMENT_CRITERIA_TYPE_HK_RACE:
                if (!miscValue1 || miscValue1 != achievementCriteria->hk_race.raceID)
                    continue;

                SetCriteriaProgress(achievementCriteria, 1, PROGRESS_ACCUMULATE);
                break;
            case ACHIEVEMENT_CRITERIA_TYPE_HIGHEST_GOLD_VALUE_OWNED:
                SetCriteriaProgress(achievementCriteria, GetPlayer()->GetMoney(), PROGRESS_HIGHEST);
                break;
            case ACHIEVEMENT_CRITERIA_TYPE_EARN_ACHIEVEMENT_POINTS:
                {
                    if (!miscValue1)
                    {
                        uint32 points = 0;
                        for (CompletedAchievementMap::iterator itr = _completedAchievements.begin(); itr != _completedAchievements.end(); ++itr)
                            if (AchievementEntry const* pAchievement = sAchievementStore.LookupEntry(itr->first))
                                points += pAchievement->points;
                        SetCriteriaProgress(achievementCriteria, points, PROGRESS_SET);
                    }
                    else
                        SetCriteriaProgress(achievementCriteria, miscValue1, PROGRESS_ACCUMULATE);
                    break;
                }
            case ACHIEVEMENT_CRITERIA_TYPE_BG_OBJECTIVE_CAPTURE:
                {
                    if (!miscValue1 || miscValue1 != achievementCriteria->bg_objective.objectiveId)
                        continue;

                    // those requirements couldn't be found in the dbc
                    AchievementCriteriaDataSet const* data = sAchievementMgr->GetCriteriaDataSet(achievementCriteria);
                    if (!data || !data->Meets(GetPlayer(), unit))
                        continue;

                    SetCriteriaProgress(achievementCriteria, 1, PROGRESS_ACCUMULATE);
                    break;
                }
            case ACHIEVEMENT_CRITERIA_TYPE_HONORABLE_KILL:
            case ACHIEVEMENT_CRITERIA_TYPE_SPECIAL_PVP_KILL:
            case ACHIEVEMENT_CRITERIA_TYPE_GET_KILLING_BLOWS:
                {
                    // skip login update
                    if (!miscValue1)
                        continue;

                    // those requirements couldn't be found in the dbc
                    AchievementCriteriaDataSet const* data = sAchievementMgr->GetCriteriaDataSet(achievementCriteria);
                    if (!data || !data->Meets(GetPlayer(), unit))
                        continue;

                    SetCriteriaProgress(achievementCriteria, 1, PROGRESS_ACCUMULATE);
                    break;
                }
            case ACHIEVEMENT_CRITERIA_TYPE_HONORABLE_KILL_AT_AREA:
                {
                    if (!miscValue1 || miscValue1 != achievementCriteria->honorable_kill_at_area.areaID)
                        continue;

                    SetCriteriaProgress(achievementCriteria, 1, PROGRESS_ACCUMULATE);
                    break;
                }
            case ACHIEVEMENT_CRITERIA_TYPE_HIGHEST_TEAM_RATING:
                {
                    uint32 reqTeamType = achievementCriteria->highest_team_rating.teamtype;

                    if (miscValue1)
                    {
                        if (miscValue2 != reqTeamType)
                            continue;

                        SetCriteriaProgress(achievementCriteria, miscValue1, PROGRESS_HIGHEST);
                    }
                    else    // login case
                    {
                        for (uint32 arena_slot = 0; arena_slot < MAX_ARENA_SLOT; ++arena_slot)
                        {
                            uint32 arenaTeamId = GetPlayer()->GetArenaTeamId(arena_slot);
                            if (!arenaTeamId)
                                continue;

                            ArenaTeam* team = sArenaTeamMgr->GetArenaTeamById(arenaTeamId);
                            if (!team || team->GetType() != reqTeamType)
                                continue;

                            SetCriteriaProgress(achievementCriteria, team->GetStats().Rating, PROGRESS_HIGHEST);
                            break;
                        }
                    }

                    break;
                }
            case ACHIEVEMENT_CRITERIA_TYPE_HIGHEST_PERSONAL_RATING:
                {
                    uint32 reqTeamType = achievementCriteria->highest_personal_rating.teamtype;

                    if (miscValue1)
                    {
                        if (miscValue2 != reqTeamType)
                            continue;

                        SetCriteriaProgress(achievementCriteria, miscValue1, PROGRESS_HIGHEST);
                    }
                    else    // login case
                    {
                        for (uint32 arena_slot = 0; arena_slot < MAX_ARENA_SLOT; ++arena_slot)
                        {
                            uint32 arenaTeamId = GetPlayer()->GetArenaTeamId(arena_slot);
                            if (!arenaTeamId)
                                continue;

                            ArenaTeam* team = sArenaTeamMgr->GetArenaTeamById(arenaTeamId);
                            if (!team || team->GetType() != reqTeamType)
                                continue;

                            if (ArenaTeamMember const* member = team->GetMember(GetPlayer()->GetGUID()))
                            {
                                SetCriteriaProgress(achievementCriteria, member->PersonalRating, PROGRESS_HIGHEST);
                                break;
                            }
                        }
                    }

                    break;
                }
            case ACHIEVEMENT_CRITERIA_TYPE_ON_LOGIN:
                {
                    // This criteria is only called directly after login - with expected miscvalue1 == 1
                    if (!miscValue1)
                        continue;

                    // They have no proper requirements in dbc
                    AchievementCriteriaDataSet const* data = sAchievementMgr->GetCriteriaDataSet(achievementCriteria);
                    if (!data || !data->Meets(GetPlayer(), unit))
                        continue;

                    SetCriteriaProgress(achievementCriteria, 1, PROGRESS_ACCUMULATE);
                    break;
                }
            case ACHIEVEMENT_CRITERIA_TYPE_PLAY_ARENA:
            case ACHIEVEMENT_CRITERIA_TYPE_WIN_ARENA: // This also behaves like ACHIEVEMENT_CRITERIA_TYPE_WIN_RATED_ARENA
                {
                    // those requirements couldn't be found in the dbc
                    AchievementCriteriaDataSet const* data = sAchievementMgr->GetCriteriaDataSet(achievementCriteria);
                    if (!data || !data->Meets(GetPlayer(), nullptr))
                        continue;

                    // Check map id requirement
                    if (miscValue1 == achievementCriteria->win_arena.mapID)
                        SetCriteriaProgress(achievementCriteria, 1, PROGRESS_ACCUMULATE);
                    break;
                }
            case ACHIEVEMENT_CRITERIA_TYPE_OWN_RANK:
                {
                    // those requirements couldn't be found in the dbc
                    AchievementCriteriaDataSet const* data = sAchievementMgr->GetCriteriaDataSet(achievementCriteria);
                    if (!data || !data->Meets(GetPlayer(), nullptr))
                        continue;

                    SetCriteriaProgress(achievementCriteria, 1);
                    break;
                }
            // std case: not exist in DBC, not triggered in code as result
            case ACHIEVEMENT_CRITERIA_TYPE_HIGHEST_HEALTH:
            case ACHIEVEMENT_CRITERIA_TYPE_HIGHEST_SPELLPOWER:
            case ACHIEVEMENT_CRITERIA_TYPE_HIGHEST_ARMOR:
            case ACHIEVEMENT_CRITERIA_TYPE_HIGHEST_POWER:
            case ACHIEVEMENT_CRITERIA_TYPE_HIGHEST_STAT:
            case ACHIEVEMENT_CRITERIA_TYPE_HIGHEST_RATING:
                break;
            // FIXME: not triggered in code as result, need to implement
            case ACHIEVEMENT_CRITERIA_TYPE_TOTAL:
                break;                                   // Not implemented yet :(
        }

        if (IsCompletedCriteria(achievementCriteria, achievement))
            CompletedCriteriaFor(achievement);

        // check again the completeness for SUMM and REQ COUNT achievements,
        // as they don't depend on the completed criteria but on the sum of the progress of each individual criteria
        if (achievement->flags & ACHIEVEMENT_FLAG_SUMM)
            if (IsCompletedAchievement(achievement))
                CompletedAchievement(achievement);

        if (AchievementEntryList const* achRefList = sAchievementMgr->GetAchievementByReferencedId(achievement->ID))
            for (AchievementEntryList::const_iterator itr = achRefList->begin(); itr != achRefList->end(); ++itr)
                if (IsCompletedAchievement(*itr))
                    CompletedAchievement(*itr);
    }
}

bool AchievementMgr::IsCompletedCriteria(AchievementCriteriaEntry const* achievementCriteria, AchievementEntry const* achievement)
{
    // counter can never complete
    if (achievement->flags & ACHIEVEMENT_FLAG_COUNTER)
        return false;

    if (achievement->flags & (ACHIEVEMENT_FLAG_REALM_FIRST_REACH | ACHIEVEMENT_FLAG_REALM_FIRST_KILL))
    {
        // someone on this realm has already completed that achievement
        if (sAchievementMgr->IsRealmCompleted(achievement))
            return false;
    }

    // pussywizard: progress will be deleted after getting the achievement (optimization)
    // finished achievement should indicate criteria completed, since not finding progress would start some timed achievements and probably other things
    if (HasAchieved(achievement->ID))
    {
        bool completed = true;

        // completed only after all referenced achievements are also completed
        if (AchievementEntryList const* achRefList = sAchievementMgr->GetAchievementByReferencedId(achievement->ID))
            for (AchievementEntryList::const_iterator itr = achRefList->begin(); itr != achRefList->end(); ++itr)
                if (!IsCompletedAchievement(*itr))
                {
                    completed = false;
                    break;
                }

        if (completed)
            return true;
    }

    CriteriaProgress const* progress = GetCriteriaProgress(achievementCriteria);
    if (!progress)
        return false;

    if (!sScriptMgr->IsCompletedCriteria(this, achievementCriteria, achievement, progress))
        return false;

    switch (achievementCriteria->requiredType)
    {
        case ACHIEVEMENT_CRITERIA_TYPE_WIN_BG:
            return progress->counter >= achievementCriteria->win_bg.winCount;
        case ACHIEVEMENT_CRITERIA_TYPE_KILL_CREATURE:
            return progress->counter >= achievementCriteria->kill_creature.creatureCount;
        case ACHIEVEMENT_CRITERIA_TYPE_REACH_LEVEL:
            return progress->counter >= achievementCriteria->reach_level.level;
        case ACHIEVEMENT_CRITERIA_TYPE_REACH_SKILL_LEVEL:
            return progress->counter >= achievementCriteria->reach_skill_level.skillLevel;
        case ACHIEVEMENT_CRITERIA_TYPE_COMPLETE_ACHIEVEMENT:
            return progress->counter >= 1;
        case ACHIEVEMENT_CRITERIA_TYPE_COMPLETE_QUEST_COUNT:
            return progress->counter >= achievementCriteria->complete_quest_count.totalQuestCount;
        case ACHIEVEMENT_CRITERIA_TYPE_COMPLETE_DAILY_QUEST_DAILY:
            return progress->counter >= achievementCriteria->complete_daily_quest_daily.numberOfDays;
        case ACHIEVEMENT_CRITERIA_TYPE_COMPLETE_QUESTS_IN_ZONE:
            return progress->counter >= achievementCriteria->complete_quests_in_zone.questCount;
        case ACHIEVEMENT_CRITERIA_TYPE_DAMAGE_DONE:
        case ACHIEVEMENT_CRITERIA_TYPE_HEALING_DONE:
            return progress->counter >= achievementCriteria->healing_done.count;
        case ACHIEVEMENT_CRITERIA_TYPE_COMPLETE_DAILY_QUEST:
            return progress->counter >= achievementCriteria->complete_daily_quest.questCount;
        case ACHIEVEMENT_CRITERIA_TYPE_FALL_WITHOUT_DYING:
            return progress->counter >= achievementCriteria->fall_without_dying.fallHeight;
        case ACHIEVEMENT_CRITERIA_TYPE_COMPLETE_QUEST:
            return progress->counter >= 1;
        case ACHIEVEMENT_CRITERIA_TYPE_BE_SPELL_TARGET:
        case ACHIEVEMENT_CRITERIA_TYPE_BE_SPELL_TARGET2:
            return progress->counter >= achievementCriteria->be_spell_target.spellCount;
        case ACHIEVEMENT_CRITERIA_TYPE_CAST_SPELL:
        case ACHIEVEMENT_CRITERIA_TYPE_CAST_SPELL2:
            return progress->counter >= achievementCriteria->cast_spell.castCount;
        case ACHIEVEMENT_CRITERIA_TYPE_BG_OBJECTIVE_CAPTURE:
            return progress->counter >= achievementCriteria->bg_objective.completeCount;
        case ACHIEVEMENT_CRITERIA_TYPE_HONORABLE_KILL_AT_AREA:
            return progress->counter >= achievementCriteria->honorable_kill_at_area.killCount;
        case ACHIEVEMENT_CRITERIA_TYPE_LEARN_SPELL:
            return progress->counter >= 1;
        case ACHIEVEMENT_CRITERIA_TYPE_HONORABLE_KILL:
        case ACHIEVEMENT_CRITERIA_TYPE_EARN_HONORABLE_KILL:
            return progress->counter >= achievementCriteria->honorable_kill.killCount;
        case ACHIEVEMENT_CRITERIA_TYPE_OWN_ITEM:
            return progress->counter >= achievementCriteria->own_item.itemCount;
        case ACHIEVEMENT_CRITERIA_TYPE_WIN_RATED_ARENA:
            return progress->counter >= achievementCriteria->win_rated_arena.count;
        case ACHIEVEMENT_CRITERIA_TYPE_HIGHEST_PERSONAL_RATING:
            return progress->counter >= achievementCriteria->highest_personal_rating.PersonalRating;
        case ACHIEVEMENT_CRITERIA_TYPE_LEARN_SKILL_LEVEL:
            return progress->counter >= (achievementCriteria->learn_skill_level.skillLevel * 75);
        case ACHIEVEMENT_CRITERIA_TYPE_USE_ITEM:
            return progress->counter >= achievementCriteria->use_item.itemCount;
        case ACHIEVEMENT_CRITERIA_TYPE_LOOT_ITEM:
            return progress->counter >= achievementCriteria->loot_item.itemCount;
        case ACHIEVEMENT_CRITERIA_TYPE_EXPLORE_AREA:
            return progress->counter >= 1;
        case ACHIEVEMENT_CRITERIA_TYPE_BUY_BANK_SLOT:
            return progress->counter >= achievementCriteria->buy_bank_slot.numberOfSlots;
        case ACHIEVEMENT_CRITERIA_TYPE_GAIN_REPUTATION:
            return progress->counter >= achievementCriteria->gain_reputation.reputationAmount;
        case ACHIEVEMENT_CRITERIA_TYPE_GAIN_EXALTED_REPUTATION:
            return progress->counter >= achievementCriteria->gain_exalted_reputation.numberOfExaltedFactions;
        case ACHIEVEMENT_CRITERIA_TYPE_VISIT_BARBER_SHOP:
            return progress->counter >= achievementCriteria->visit_barber.numberOfVisits;
        case ACHIEVEMENT_CRITERIA_TYPE_EQUIP_EPIC_ITEM:
            return progress->counter >= achievementCriteria->equip_epic_item.count;
        case ACHIEVEMENT_CRITERIA_TYPE_ROLL_NEED_ON_LOOT:
        case ACHIEVEMENT_CRITERIA_TYPE_ROLL_GREED_ON_LOOT:
            return progress->counter >= achievementCriteria->roll_greed_on_loot.count;
        case ACHIEVEMENT_CRITERIA_TYPE_HK_CLASS:
            return progress->counter >= achievementCriteria->hk_class.count;
        case ACHIEVEMENT_CRITERIA_TYPE_HK_RACE:
            return progress->counter >= achievementCriteria->hk_race.count;
        case ACHIEVEMENT_CRITERIA_TYPE_DO_EMOTE:
            return progress->counter >= achievementCriteria->do_emote.count;
        case ACHIEVEMENT_CRITERIA_TYPE_EQUIP_ITEM:
            return progress->counter >= achievementCriteria->equip_item.count;
        case ACHIEVEMENT_CRITERIA_TYPE_MONEY_FROM_QUEST_REWARD:
            return progress->counter >= achievementCriteria->quest_reward_money.goldInCopper;
        case ACHIEVEMENT_CRITERIA_TYPE_LOOT_MONEY:
            return progress->counter >= achievementCriteria->loot_money.goldInCopper;
        case ACHIEVEMENT_CRITERIA_TYPE_USE_GAMEOBJECT:
            return progress->counter >= achievementCriteria->use_gameobject.useCount;
        case ACHIEVEMENT_CRITERIA_TYPE_SPECIAL_PVP_KILL:
            return progress->counter >= achievementCriteria->special_pvp_kill.killCount;
        case ACHIEVEMENT_CRITERIA_TYPE_FISH_IN_GAMEOBJECT:
            return progress->counter >= achievementCriteria->fish_in_gameobject.lootCount;
        case ACHIEVEMENT_CRITERIA_TYPE_LEARN_SKILLLINE_SPELLS:
            return progress->counter >= achievementCriteria->learn_skillline_spell.spellCount;
        case ACHIEVEMENT_CRITERIA_TYPE_WIN_DUEL:
            return progress->counter >= achievementCriteria->win_duel.duelCount;
        case ACHIEVEMENT_CRITERIA_TYPE_LOOT_TYPE:
            return progress->counter >= achievementCriteria->loot_type.lootTypeCount;
        case ACHIEVEMENT_CRITERIA_TYPE_LEARN_SKILL_LINE:
            return progress->counter >= achievementCriteria->learn_skill_line.spellCount;
        case ACHIEVEMENT_CRITERIA_TYPE_EARN_ACHIEVEMENT_POINTS:
            return progress->counter >= 9000;
        case ACHIEVEMENT_CRITERIA_TYPE_USE_LFD_TO_GROUP_WITH_PLAYERS:
            return progress->counter >= achievementCriteria->use_lfg.dungeonsComplete;
        case ACHIEVEMENT_CRITERIA_TYPE_GET_KILLING_BLOWS:
            return progress->counter >= achievementCriteria->get_killing_blow.killCount;
        case ACHIEVEMENT_CRITERIA_TYPE_ON_LOGIN:
            return true;
        case ACHIEVEMENT_CRITERIA_TYPE_WIN_ARENA:
            return achievementCriteria->win_arena.count && progress->counter >= achievementCriteria->win_arena.count;
        case ACHIEVEMENT_CRITERIA_TYPE_OWN_RANK:
            return true;
        // handle all statistic-only criteria here
        case ACHIEVEMENT_CRITERIA_TYPE_COMPLETE_BATTLEGROUND:
        case ACHIEVEMENT_CRITERIA_TYPE_DEATH_AT_MAP:
        case ACHIEVEMENT_CRITERIA_TYPE_DEATH:
        case ACHIEVEMENT_CRITERIA_TYPE_DEATH_IN_DUNGEON:
        case ACHIEVEMENT_CRITERIA_TYPE_COMPLETE_RAID:
        case ACHIEVEMENT_CRITERIA_TYPE_KILLED_BY_CREATURE:
        case ACHIEVEMENT_CRITERIA_TYPE_KILLED_BY_PLAYER:
        case ACHIEVEMENT_CRITERIA_TYPE_DEATHS_FROM:
        case ACHIEVEMENT_CRITERIA_TYPE_HIGHEST_TEAM_RATING:
        case ACHIEVEMENT_CRITERIA_TYPE_MONEY_FROM_VENDORS:
        case ACHIEVEMENT_CRITERIA_TYPE_GOLD_SPENT_FOR_TALENTS:
        case ACHIEVEMENT_CRITERIA_TYPE_NUMBER_OF_TALENT_RESETS:
        case ACHIEVEMENT_CRITERIA_TYPE_GOLD_SPENT_AT_BARBER:
        case ACHIEVEMENT_CRITERIA_TYPE_GOLD_SPENT_FOR_MAIL:
        case ACHIEVEMENT_CRITERIA_TYPE_LOSE_DUEL:
        case ACHIEVEMENT_CRITERIA_TYPE_KILL_CREATURE_TYPE:
        case ACHIEVEMENT_CRITERIA_TYPE_GOLD_EARNED_BY_AUCTIONS:
        case ACHIEVEMENT_CRITERIA_TYPE_CREATE_AUCTION:
        case ACHIEVEMENT_CRITERIA_TYPE_HIGHEST_AUCTION_BID:
        case ACHIEVEMENT_CRITERIA_TYPE_HIGHEST_AUCTION_SOLD:
        case ACHIEVEMENT_CRITERIA_TYPE_HIGHEST_GOLD_VALUE_OWNED:
        case ACHIEVEMENT_CRITERIA_TYPE_WON_AUCTIONS:
        case ACHIEVEMENT_CRITERIA_TYPE_GAIN_REVERED_REPUTATION:
        case ACHIEVEMENT_CRITERIA_TYPE_GAIN_HONORED_REPUTATION:
        case ACHIEVEMENT_CRITERIA_TYPE_KNOWN_FACTIONS:
        case ACHIEVEMENT_CRITERIA_TYPE_LOOT_EPIC_ITEM:
        case ACHIEVEMENT_CRITERIA_TYPE_RECEIVE_EPIC_ITEM:
        case ACHIEVEMENT_CRITERIA_TYPE_ROLL_NEED:
        case ACHIEVEMENT_CRITERIA_TYPE_ROLL_GREED:
        case ACHIEVEMENT_CRITERIA_TYPE_ROLL_DISENCHANT:
        case ACHIEVEMENT_CRITERIA_TYPE_HIGHEST_HEALTH:
        case ACHIEVEMENT_CRITERIA_TYPE_HIGHEST_SPELLPOWER:
        case ACHIEVEMENT_CRITERIA_TYPE_HIGHEST_ARMOR:
        case ACHIEVEMENT_CRITERIA_TYPE_QUEST_ABANDONED:
        case ACHIEVEMENT_CRITERIA_TYPE_FLIGHT_PATHS_TAKEN:
        case ACHIEVEMENT_CRITERIA_TYPE_ACCEPTED_SUMMONINGS:
        case ACHIEVEMENT_CRITERIA_TYPE_PLAY_ARENA:
        default:
            break;
    }
    return false;
}

void AchievementMgr::CompletedCriteriaFor(AchievementEntry const* achievement)
{
    // counter can never complete
    if (achievement->flags & ACHIEVEMENT_FLAG_COUNTER)
        return;

    // already completed and stored
    if (HasAchieved(achievement->ID))
        return;

    if (IsCompletedAchievement(achievement))
        CompletedAchievement(achievement);
}

bool AchievementMgr::IsCompletedAchievement(AchievementEntry const* entry)
{
    // counter can never complete
    if (entry->flags & ACHIEVEMENT_FLAG_COUNTER)
        return false;

    // for achievement with referenced achievement criterias get from referenced and counter from self
    uint32 achievmentForTestId = entry->refAchievement ? entry->refAchievement : entry->ID;
    uint32 achievmentForTestCount = entry->count;

    AchievementCriteriaEntryList const* cList = sAchievementMgr->GetAchievementCriteriaByAchievement(achievmentForTestId);
    if (!cList)
        return false;
    uint32 count = 0;

    // For SUMM achievements, we have to count the progress of each criteria of the achievement.
    // Oddly, the target count is NOT countained in the achievement, but in each individual criteria
    if (entry->flags & ACHIEVEMENT_FLAG_SUMM)
    {
        for (AchievementCriteriaEntryList::const_iterator itr = cList->begin(); itr != cList->end(); ++itr)
        {
            AchievementCriteriaEntry const* criteria = *itr;

            CriteriaProgress const* progress = GetCriteriaProgress(criteria);
            if (!progress)
                continue;

            count += progress->counter;

            // for counters, field4 contains the main count requirement
            if (count >= criteria->raw.count)
                return true;
        }
        return false;
    }

    // Default case - need complete all or
    bool completed_all = true;
    for (AchievementCriteriaEntryList::const_iterator itr = cList->begin(); itr != cList->end(); ++itr)
    {
        AchievementCriteriaEntry const* criteria = *itr;

        bool completed = IsCompletedCriteria(criteria, entry);

        // found an uncompleted criteria, but DONT return false yet - there might be a completed criteria with ACHIEVEMENT_CRITERIA_COMPLETE_FLAG_ALL
        if (completed)
            ++count;
        else
            completed_all = false;

        // completed as have req. count of completed criterias
        if (achievmentForTestCount > 0 && achievmentForTestCount <= count)
            return true;
    }

    // all criterias completed requirement
    if (completed_all && achievmentForTestCount == 0)
        return true;

    return false;
}

CriteriaProgress* AchievementMgr::GetCriteriaProgress(AchievementCriteriaEntry const* entry)
{
    CriteriaProgressMap::iterator iter = _criteriaProgress.find(entry->ID);

    if (iter == _criteriaProgress.end())
        return nullptr;

    return &(iter->second);
}

void AchievementMgr::SetCriteriaProgress(AchievementCriteriaEntry const* entry, uint32 changeValue, ProgressType ptype)
{
    // Don't allow to cheat - doing timed achievements without timer active
    TimedAchievementMap::iterator timedIter = _timedAchievements.find(entry->ID);
    if (entry->timeLimit && timedIter == _timedAchievements.end())
        return;

    if (!sScriptMgr->OnBeforeCriteriaProgress(GetPlayer(), entry))
    {
        return;
    }

    LOG_DEBUG("achievement", "AchievementMgr::SetCriteriaProgress({}, {}) for {}", entry->ID, changeValue, _player->GetGUID().ToString());

    CriteriaProgress* progress = GetCriteriaProgress(entry);
    if (!progress)
    {
        // not create record for 0 counter but allow it for timed achievements
        // we will need to send 0 progress to client to start the timer
        if (changeValue == 0 && !entry->timeLimit)
            return;

        progress = &_criteriaProgress[entry->ID];
        progress->counter = changeValue;
    }
    else
    {
        uint32 newValue = 0;
        switch (ptype)
        {
            case PROGRESS_SET:
            case PROGRESS_RESET:
                newValue = changeValue;
                break;
            case PROGRESS_ACCUMULATE:
                {
                    // avoid overflow
                    uint32 max_value = std::numeric_limits<uint32>::max();
                    newValue = max_value - progress->counter > changeValue ? progress->counter + changeValue : max_value;
                    break;
                }
            case PROGRESS_HIGHEST:
                newValue = progress->counter < changeValue ? changeValue : progress->counter;
                break;
        }

        // not update (not mark as changed) if counter will have same value
        if (ptype != PROGRESS_RESET && progress->counter == newValue && !entry->timeLimit)
            return;

        progress->counter = newValue;
    }

    progress->changed = true;
    progress->date = GameTime::GetGameTime().count(); // set the date to the latest update.

    uint32 timeElapsed = 0;
    bool timedCompleted = false;

    if (entry->timeLimit)
    {
        // has to exist else we wouldn't be here
        timedCompleted = IsCompletedCriteria(entry, sAchievementStore.LookupEntry(entry->referredAchievement));
        // Client expects this in packet
        timeElapsed = entry->timeLimit - (timedIter->second / IN_MILLISECONDS);

        // Remove the timer, we wont need it anymore
        if (timedCompleted)
            _timedAchievements.erase(timedIter);
    }

    SendCriteriaUpdate(entry, progress, timeElapsed, true);

    sScriptMgr->OnCriteriaProgress(GetPlayer(), entry);
}

void AchievementMgr::RemoveCriteriaProgress(const AchievementCriteriaEntry* entry)
{
    CriteriaProgressMap::iterator criteriaProgress = _criteriaProgress.find(entry->ID);
    if (criteriaProgress == _criteriaProgress.end())
        return;

    WorldPacket data(SMSG_CRITERIA_DELETED, 4);
    data << uint32(entry->ID);
    _player->SendDirectMessage(&data);

    _criteriaProgress.erase(criteriaProgress);
}

void AchievementMgr::UpdateTimedAchievements(uint32 timeDiff)
{
    if (!_timedAchievements.empty())
    {
        for (TimedAchievementMap::iterator itr = _timedAchievements.begin(); itr != _timedAchievements.end();)
        {
            // Time is up, remove timer and reset progress
            if (itr->second <= timeDiff)
            {
                AchievementCriteriaEntry const* entry = sAchievementCriteriaStore.LookupEntry(itr->first);
                RemoveCriteriaProgress(entry);
                _timedAchievements.erase(itr++);
            }
            else
            {
                itr->second -= timeDiff;
                ++itr;
            }
        }
    }
}

void AchievementMgr::StartTimedAchievement(AchievementCriteriaTimedTypes type, uint32 entry, uint32 timeLost /*= 0*/)
{
    AchievementCriteriaEntryList const& achievementCriteriaList = sAchievementMgr->GetTimedAchievementCriteriaByType(type);
    for (AchievementCriteriaEntryList::const_iterator i = achievementCriteriaList.begin(); i != achievementCriteriaList.end(); ++i)
    {
        if ((*i)->timerStartEvent != entry)
            continue;

        AchievementEntry const* achievement = sAchievementStore.LookupEntry((*i)->referredAchievement);
        if (_timedAchievements.find((*i)->ID) == _timedAchievements.end() && !IsCompletedCriteria(*i, achievement))
        {
            // Start the timer
            if ((*i)->timeLimit * IN_MILLISECONDS > timeLost)
            {
                _timedAchievements[(*i)->ID] = (*i)->timeLimit * IN_MILLISECONDS - timeLost;

                // and at client too
                SetCriteriaProgress(*i, 0, PROGRESS_SET);
            }
        }
    }
}

void AchievementMgr::RemoveTimedAchievement(AchievementCriteriaTimedTypes type, uint32 entry)
{
    AchievementCriteriaEntryList const& achievementCriteriaList = sAchievementMgr->GetTimedAchievementCriteriaByType(type);
    for (AchievementCriteriaEntryList::const_iterator i = achievementCriteriaList.begin(); i != achievementCriteriaList.end(); ++i)
    {
        if ((*i)->timerStartEvent != entry)
            continue;

        TimedAchievementMap::iterator timedIter = _timedAchievements.find((*i)->ID);
        // We don't have timer for this achievement
        if (timedIter == _timedAchievements.end())
            continue;

        // remove progress
        RemoveCriteriaProgress(*i);

        // Remove the timer
        _timedAchievements.erase(timedIter);
    }
}

void AchievementMgr::CompletedAchievement(AchievementEntry const* achievement)
{
    // disable for gamemasters with GM-mode enabled
    if (_player->IsGameMaster())
    {
        LOG_INFO("achievement", "Not available in GM mode.");
        ChatHandler(_player->GetSession()).PSendSysMessage("Not available in GM mode");
        return;
    }

    if (!sScriptMgr->OnBeforeAchievementComplete(GetPlayer(), achievement))
    {
        return;
    }

    if (achievement->flags & ACHIEVEMENT_FLAG_COUNTER || HasAchieved(achievement->ID))
        return;

    LOG_DEBUG("achievement", "AchievementMgr::CompletedAchievement({})", achievement->ID);

    SendAchievementEarned(achievement);
    CompletedAchievementData& ca = _completedAchievements[achievement->ID];
    ca.date = GameTime::GetGameTime().count();
    ca.changed = true;

    sScriptMgr->OnAchievementComplete(GetPlayer(), achievement);

    // pussywizard: set all progress counters to 0, so progress will be deleted from db during save
    {
        bool allRefsCompleted = true;
        uint32 achiCheckId = achievement->refAchievement ? achievement->refAchievement : achievement->ID;

        if (AchievementEntryList const* achRefList = sAchievementMgr->GetAchievementByReferencedId(achiCheckId))
            for (AchievementEntryList::const_iterator itr = achRefList->begin(); itr != achRefList->end(); ++itr)
                if (!IsCompletedAchievement(*itr))
                {
                    allRefsCompleted = false;
                    break;
                }

        if (allRefsCompleted)
            if (AchievementCriteriaEntryList const* cList = sAchievementMgr->GetAchievementCriteriaByAchievement(achiCheckId))
                for (AchievementCriteriaEntryList::const_iterator itr = cList->begin(); itr != cList->end(); ++itr)
                    if (CriteriaProgress* progress = GetCriteriaProgress(*itr))
                    {
                        progress->changed = true;
                        progress->counter = 0;
                    }
    }

    if (achievement->flags & (ACHIEVEMENT_FLAG_REALM_FIRST_REACH | ACHIEVEMENT_FLAG_REALM_FIRST_KILL) && AccountMgr::IsPlayerAccount(_player->GetSession()->GetSecurity()))
        sAchievementMgr->SetRealmCompleted(achievement);

    UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_COMPLETE_ACHIEVEMENT, achievement->ID);
    UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_EARN_ACHIEVEMENT_POINTS, achievement->points);

    // reward items and titles if any
    AchievementReward const* reward = sAchievementMgr->GetAchievementReward(achievement);

    // no rewards
    if (!reward)
        return;

    // titles
    //! Currently there's only one achievement that deals with gender-specific titles.
    //! Since no common attributes were found, (not even in titleRewardFlags field)
    //! we explicitly check by ID. Maybe in the future we could move the achievement_reward
    //! condition fields to the condition system.
    if (uint32 titleId = reward->titleId[achievement->ID == 1793 ? GetPlayer()->getGender() : uint8(GetPlayer()->GetTeamId())])
        if (CharTitlesEntry const* titleEntry = sCharTitlesStore.LookupEntry(titleId))
            GetPlayer()->SetTitle(titleEntry);

    // mail
    if (reward->sender)
    {
        MailDraft draft(reward->mailTemplate);

        if (!reward->mailTemplate)
        {
            std::string subject = reward->subject;
            std::string text = reward->text;

            LocaleConstant localeConstant = GetPlayer()->GetSession()->GetSessionDbLocaleIndex();
            if (localeConstant != LOCALE_enUS)
            {
                if(AchievementRewardLocale const* loc = sAchievementMgr->GetAchievementRewardLocale(achievement))
                {
                    ObjectMgr::GetLocaleString(loc->Subject, localeConstant, subject);
                    ObjectMgr::GetLocaleString(loc->Text, localeConstant, text);
                }
            }

            draft = MailDraft(subject, text);
        }

        CharacterDatabaseTransaction trans = CharacterDatabase.BeginTransaction();

        Item* item = reward->itemId ? Item::CreateItem(reward->itemId, 1, GetPlayer()) : nullptr;
        if (item)
        {
            // save new item before send
            item->SaveToDB(trans);                               // save for prevent lost at next mail load, if send fail then item will deleted

            // item
            draft.AddItem(item);
        }

        draft.SendMailTo(trans, GetPlayer(), MailSender(MAIL_CREATURE, reward->sender));
        CharacterDatabase.CommitTransaction(trans);
    }
}

void AchievementMgr::SendAllAchievementData() const
{
    WorldPacket data(SMSG_ALL_ACHIEVEMENT_DATA, _completedAchievements.size() * 8 + 4 + _criteriaProgress.size() * 38 + 4);
    BuildAllDataPacket(&data);
    GetPlayer()->GetSession()->SendPacket(&data);
}

void AchievementMgr::SendRespondInspectAchievements(Player* player) const
{
    WorldPacket data(SMSG_RESPOND_INSPECT_ACHIEVEMENTS, 9 + _completedAchievements.size() * 8 + 4 + _criteriaProgress.size() * 38 + 4);
    data << GetPlayer()->GetPackGUID();
    BuildAllDataPacket(&data);
    player->GetSession()->SendPacket(&data);
}

/**
 * used by SMSG_RESPOND_INSPECT_ACHIEVEMENT and SMSG_ALL_ACHIEVEMENT_DATA
 */
void AchievementMgr::BuildAllDataPacket(WorldPacket* data) const
{
    for (CompletedAchievementMap::const_iterator iter = _completedAchievements.begin(); iter != _completedAchievements.end(); ++iter)
    {
        // Skip hidden achievements
        AchievementEntry const* achievement = sAchievementStore.LookupEntry(iter->first);
        if (!achievement || achievement->flags & ACHIEVEMENT_FLAG_HIDDEN)
            continue;

        *data << uint32(iter->first);
        data->AppendPackedTime(iter->second.date);
    }

    *data << int32(-1);
    time_t now = GameTime::GetGameTime().count();

    for (CriteriaProgressMap::const_iterator iter = _criteriaProgress.begin(); iter != _criteriaProgress.end(); ++iter)
    {
        *data << uint32(iter->first);
        data->appendPackGUID(iter->second.counter);
        *data << GetPlayer()->GetPackGUID();
        *data << uint32(0); /// @todo: This should be 1 if it is a failed timed criteria
        data->AppendPackedTime(iter->second.date);
        *data << uint32(now - iter->second.date);

        if (sAchievementMgr->IsAverageCriteria(sAchievementCriteriaStore.LookupEntry(iter->first)))
            *data << uint32(now - GetPlayer()->GetCreationTime().count());    // for average achievements
        else
            *data << uint32(now - iter->second.date);
    }

    *data << int32(-1);
}

bool AchievementMgr::HasAchieved(uint32 achievementId) const
{
    return _completedAchievements.find(achievementId) != _completedAchievements.end();
}

bool AchievementMgr::CanUpdateCriteria(AchievementCriteriaEntry const* criteria, AchievementEntry const* achievement)
{
    if (DisableMgr::IsDisabledFor(DISABLE_TYPE_ACHIEVEMENT_CRITERIA, criteria->ID, nullptr))
        return false;

    if (achievement->mapID != -1 && GetPlayer()->GetMapId() != uint32(achievement->mapID))
        return false;

    if ((achievement->requiredFaction == ACHIEVEMENT_FACTION_HORDE    && GetPlayer()->GetTeamId(true) != TEAM_HORDE) ||
            (achievement->requiredFaction == ACHIEVEMENT_FACTION_ALLIANCE && GetPlayer()->GetTeamId(true) != TEAM_ALLIANCE))
        return false;

    for (uint32 i = 0; i < MAX_CRITERIA_REQUIREMENTS; ++i)
    {
        if (!criteria->additionalRequirements[i].additionalRequirement_type)
            continue;

        switch (criteria->additionalRequirements[i].additionalRequirement_type)
        {
            case ACHIEVEMENT_CRITERIA_CONDITION_BG_MAP:
                if (GetPlayer()->GetMapId() != criteria->additionalRequirements[i].additionalRequirement_value)
                    return false;
                break;
            case ACHIEVEMENT_CRITERIA_CONDITION_NOT_IN_GROUP:
                if (GetPlayer()->GetGroup())
                    return false;
                break;
            default:
                break;
        }
    }

    // don't update already completed criteria
    if (IsCompletedCriteria(criteria, achievement))
        return false;

    return true;
}

CompletedAchievementMap const& AchievementMgr::GetCompletedAchievements()
{
    return _completedAchievements;
}

AchievementGlobalMgr* AchievementGlobalMgr::instance()
{
    static AchievementGlobalMgr instance;
    return &instance;
}

bool AchievementGlobalMgr::IsStatisticCriteria(AchievementCriteriaEntry const* achievementCriteria) const
{
    return IsStatisticAchievement(sAchievementStore.LookupEntry(achievementCriteria->referredAchievement));
}

bool AchievementGlobalMgr::IsStatisticAchievement(AchievementEntry const* achievement) const
{
    if (!achievement)
        return false;

    AchievementCategoryEntry const* cat = sAchievementCategoryStore.LookupEntry(achievement->categoryId);
    do
    {
        switch(cat->ID)
        {
            case ACHIEVEMENT_CATEGORY_STATISTICS:
                return true;
            case ACHIEVEMENT_CATEOGRY_GENERAL:
                return false;
            default:
                cat = sAchievementCategoryStore.LookupEntry(cat->parentCategory);
                break;
        }
    } while (cat);

    return false;
}

bool AchievementGlobalMgr::IsAverageCriteria(AchievementCriteriaEntry const* criteria) const
{
    auto referencedAchievement = sAchievementStore.LookupEntry(criteria->referredAchievement);

    if (!referencedAchievement)
        return false;

    if (referencedAchievement->flags & ACHIEVEMENT_FLAG_AVERAGE)
        return true;

    if (AchievementEntryList const* achRefList = GetAchievementByReferencedId(referencedAchievement->ID))
        for (AchievementEntryList::const_iterator itr = achRefList->begin(); itr != achRefList->end(); ++itr)
            if ((*itr)->flags & ACHIEVEMENT_FLAG_AVERAGE)
                return true;

    return false;
}

bool AchievementGlobalMgr::IsRealmCompleted(AchievementEntry const* achievement) const
{
    auto itr = _allCompletedAchievements.find(achievement->ID);
    if (itr == _allCompletedAchievements.end())
        return false;

    if (itr->second == SystemTimePoint::min())
        return false;

    if (!sScriptMgr->IsRealmCompleted(this, achievement, itr->second))
        return false;

    if (itr->second == SystemTimePoint::max())
        return true;

    // Allow completing the realm first kill for entire minute after first person did it
    // it may allow more than one group to achieve it (highly unlikely)
    // but apparently this is how blizz handles it as well
    if (achievement->flags & ACHIEVEMENT_FLAG_REALM_FIRST_KILL)
        return (GameTime::GetSystemTime() - itr->second) > 1min;

    sScriptMgr->SetRealmCompleted(achievement);

    return true;
}

void AchievementGlobalMgr::SetRealmCompleted(AchievementEntry const* achievement)
{
    if (IsRealmCompleted(achievement))
        return;

    _allCompletedAchievements[achievement->ID] = GameTime::GetSystemTime();
}

//==========================================================
void AchievementGlobalMgr::LoadAchievementCriteriaList()
{
    uint32 oldMSTime = getMSTime();

    if (sAchievementCriteriaStore.GetNumRows() == 0)
    {
        LOG_WARN("server.loading", ">> Loaded 0 achievement criteria.");
        LOG_INFO("server.loading", " ");
        return;
    }

    uint32 loaded = 0;
    for (uint32 entryId = 0; entryId < sAchievementCriteriaStore.GetNumRows(); ++entryId)
    {
        AchievementCriteriaEntry const* criteria = sAchievementCriteriaStore.LookupEntry(entryId);
        if (!criteria)
            continue;

        if (!GetAchievement(criteria->referredAchievement))
        {
            LOG_DEBUG("server.loading", "Achievement {} referenced by criteria {} doesn't exist, criteria not loaded.", criteria->referredAchievement, criteria->ID);
            continue;
        }

        _achievementCriteriasByType[criteria->requiredType].push_back(criteria);
        _achievementCriteriaListByAchievement[criteria->referredAchievement].push_back(criteria);

        if (criteria->additionalRequirements[0].additionalRequirement_type != ACHIEVEMENT_CRITERIA_CONDITION_NONE)
            _achievementCriteriasByCondition[criteria->additionalRequirements[0].additionalRequirement_type][criteria->additionalRequirements[0].additionalRequirement_value].push_back(criteria);
        if (criteria->additionalRequirements[1].additionalRequirement_type != ACHIEVEMENT_CRITERIA_CONDITION_NONE &&
                criteria->additionalRequirements[1].additionalRequirement_type != criteria->additionalRequirements[0].additionalRequirement_type)
            _achievementCriteriasByCondition[criteria->additionalRequirements[1].additionalRequirement_type][criteria->additionalRequirements[1].additionalRequirement_value].push_back(criteria);

        switch (criteria->requiredType)
        {
            case ACHIEVEMENT_CRITERIA_TYPE_KILL_CREATURE:
                _specialList[criteria->requiredType][criteria->kill_creature.creatureID].push_back(criteria);
                break;
            case ACHIEVEMENT_CRITERIA_TYPE_WIN_BG:
                _specialList[criteria->requiredType][criteria->win_bg.bgMapID].push_back(criteria);
                break;
            case ACHIEVEMENT_CRITERIA_TYPE_REACH_SKILL_LEVEL:
                _specialList[criteria->requiredType][criteria->reach_skill_level.skillID].push_back(criteria);
                break;
            case ACHIEVEMENT_CRITERIA_TYPE_COMPLETE_ACHIEVEMENT:
                _specialList[criteria->requiredType][criteria->complete_achievement.linkedAchievement].push_back(criteria);
                break;
            case ACHIEVEMENT_CRITERIA_TYPE_COMPLETE_QUESTS_IN_ZONE:
                _specialList[criteria->requiredType][criteria->complete_quests_in_zone.zoneID].push_back(criteria);
                break;
            case ACHIEVEMENT_CRITERIA_TYPE_COMPLETE_BATTLEGROUND:
                _specialList[criteria->requiredType][criteria->complete_battleground.mapID].push_back(criteria);
                break;
            case ACHIEVEMENT_CRITERIA_TYPE_KILLED_BY_CREATURE:
                _specialList[criteria->requiredType][criteria->killed_by_creature.creatureEntry].push_back(criteria);
                break;
            case ACHIEVEMENT_CRITERIA_TYPE_COMPLETE_QUEST:
                _specialList[criteria->requiredType][criteria->complete_quest.questID].push_back(criteria);
                break;
            case ACHIEVEMENT_CRITERIA_TYPE_BE_SPELL_TARGET:
                _specialList[criteria->requiredType][criteria->be_spell_target.spellID].push_back(criteria);
                break;
            case ACHIEVEMENT_CRITERIA_TYPE_CAST_SPELL:
                _specialList[criteria->requiredType][criteria->cast_spell.spellID].push_back(criteria);
                break;
            case ACHIEVEMENT_CRITERIA_TYPE_BG_OBJECTIVE_CAPTURE:
                _specialList[criteria->requiredType][criteria->bg_objective.objectiveId].push_back(criteria);
                break;
            case ACHIEVEMENT_CRITERIA_TYPE_HONORABLE_KILL_AT_AREA:
                _specialList[criteria->requiredType][criteria->honorable_kill_at_area.areaID].push_back(criteria);
                break;
            case ACHIEVEMENT_CRITERIA_TYPE_LEARN_SPELL:
                _specialList[criteria->requiredType][criteria->learn_spell.spellID].push_back(criteria);
                break;
            case ACHIEVEMENT_CRITERIA_TYPE_OWN_ITEM:
                _specialList[criteria->requiredType][criteria->own_item.itemID].push_back(criteria);
                break;
            case ACHIEVEMENT_CRITERIA_TYPE_LEARN_SKILL_LEVEL:
                _specialList[criteria->requiredType][criteria->learn_skill_level.skillID].push_back(criteria);
                break;
            case ACHIEVEMENT_CRITERIA_TYPE_USE_ITEM:
                _specialList[criteria->requiredType][criteria->use_item.itemID].push_back(criteria);
                break;
            case ACHIEVEMENT_CRITERIA_TYPE_LOOT_ITEM:
                _specialList[criteria->requiredType][criteria->own_item.itemID].push_back(criteria);
                break;
            case ACHIEVEMENT_CRITERIA_TYPE_EXPLORE_AREA:
                {
                    WorldMapOverlayEntry const* worldOverlayEntry = sWorldMapOverlayStore.LookupEntry(criteria->explore_area.areaReference);
                    if (!worldOverlayEntry)
                        break;

                    for (uint8 j = 0; j < MAX_WORLD_MAP_OVERLAY_AREA_IDX; ++j)
                        if (worldOverlayEntry->areatableID[j])
                        {
                            bool valid = true;
                            for (uint8 i = 0; i < j; ++i)
                                if (worldOverlayEntry->areatableID[j] == worldOverlayEntry->areatableID[i])
                                    valid = false;
                            if (valid)
                                _specialList[criteria->requiredType][worldOverlayEntry->areatableID[j]].push_back(criteria);
                        }
                }
                break;
            case ACHIEVEMENT_CRITERIA_TYPE_GAIN_REPUTATION:
                _specialList[criteria->requiredType][criteria->gain_reputation.factionID].push_back(criteria);
                break;
            case ACHIEVEMENT_CRITERIA_TYPE_EQUIP_EPIC_ITEM:
                _specialList[criteria->requiredType][criteria->equip_epic_item.itemSlot].push_back(criteria);
                break;
            case ACHIEVEMENT_CRITERIA_TYPE_HK_CLASS:
                _specialList[criteria->requiredType][criteria->hk_class.classID].push_back(criteria);
                break;
            case ACHIEVEMENT_CRITERIA_TYPE_HK_RACE:
                _specialList[criteria->requiredType][criteria->hk_race.raceID].push_back(criteria);
                break;
            case ACHIEVEMENT_CRITERIA_TYPE_DO_EMOTE:
                _specialList[criteria->requiredType][criteria->do_emote.emoteID].push_back(criteria);
                break;
            case ACHIEVEMENT_CRITERIA_TYPE_EQUIP_ITEM:
                _specialList[criteria->requiredType][criteria->equip_item.itemID].push_back(criteria);
                break;
            case ACHIEVEMENT_CRITERIA_TYPE_USE_GAMEOBJECT:
                _specialList[criteria->requiredType][criteria->use_gameobject.goEntry].push_back(criteria);
                break;
            case ACHIEVEMENT_CRITERIA_TYPE_BE_SPELL_TARGET2:
                _specialList[criteria->requiredType][criteria->be_spell_target.spellID].push_back(criteria);
                break;
            case ACHIEVEMENT_CRITERIA_TYPE_FISH_IN_GAMEOBJECT:
                _specialList[criteria->requiredType][criteria->fish_in_gameobject.goEntry].push_back(criteria);
                break;
            case ACHIEVEMENT_CRITERIA_TYPE_LEARN_SKILLLINE_SPELLS:
                _specialList[criteria->requiredType][criteria->learn_skillline_spell.skillLine].push_back(criteria);
                break;
            case ACHIEVEMENT_CRITERIA_TYPE_LOOT_TYPE:
                _specialList[criteria->requiredType][criteria->loot_type.lootType].push_back(criteria);
                break;
            case ACHIEVEMENT_CRITERIA_TYPE_CAST_SPELL2:
                _specialList[criteria->requiredType][criteria->cast_spell.spellID].push_back(criteria);
                break;
            case ACHIEVEMENT_CRITERIA_TYPE_LEARN_SKILL_LINE:
                _specialList[criteria->requiredType][criteria->learn_skill_line.skillLine].push_back(criteria);
                break;
        }

        if (criteria->timeLimit)
            _achievementCriteriasByTimedType[criteria->timedType].push_back(criteria);

        ++loaded;
    }

    LOG_INFO("server.loading", ">> Loaded {} achievement criteria in {} ms", loaded, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
}

void AchievementGlobalMgr::LoadAchievementReferenceList()
{
    uint32 oldMSTime = getMSTime();

    if (sAchievementStore.GetNumRows() == 0)
    {
        LOG_WARN("server.loading", ">> Loaded 0 achievement references.");
        LOG_INFO("server.loading", " ");
        return;
    }

    uint32 count = 0;

    for (uint32 entryId = 0; entryId < sAchievementStore.GetNumRows(); ++entryId)
    {
        AchievementEntry const* achievement = sAchievementStore.LookupEntry(entryId);
        if (!achievement || !achievement->refAchievement)
            continue;

        _achievementListByReferencedId[achievement->refAchievement].push_back(achievement);
        ++count;
    }

    LOG_INFO("server.loading", ">> Loaded {} achievement references in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
}

void AchievementGlobalMgr::LoadAchievementCriteriaData()
{
    uint32 oldMSTime = getMSTime();

    _criteriaDataMap.clear();                              // need for reload case

    QueryResult result = WorldDatabase.Query("SELECT criteria_id, type, value1, value2, ScriptName FROM achievement_criteria_data");

    if (!result)
    {
        LOG_WARN("server.loading", ">> Loaded 0 additional achievement criteria data. DB table `achievement_criteria_data` is empty.");
        LOG_INFO("server.loading", " ");
        return;
    }

    uint32 count = 0;

    do
    {
        Field* fields = result->Fetch();
        uint32 criteria_id = fields[0].Get<uint32>();

        AchievementCriteriaEntry const* criteria = sAchievementCriteriaStore.LookupEntry(criteria_id);

        if (!criteria)
        {
            LOG_ERROR("sql.sql", "Table `achievement_criteria_data` has data for non-existing criteria (Entry: {}), ignore.", criteria_id);
            continue;
        }

        uint32 dataType = fields[1].Get<uint8>();
        std::string scriptName = fields[4].Get<std::string>();
        uint32 scriptId = 0;
        if (scriptName.length()) // not empty
        {
            if (dataType != ACHIEVEMENT_CRITERIA_DATA_TYPE_SCRIPT)
                LOG_ERROR("sql.sql", "Table `achievement_criteria_data` has ScriptName set for non-scripted data type (Entry: {}, type {}), useless data.", criteria_id, dataType);
            else
                scriptId = sObjectMgr->GetScriptId(scriptName);
        }

        AchievementCriteriaData data(dataType, fields[2].Get<uint32>(), fields[3].Get<uint32>(), scriptId);

        if (!data.IsValid(criteria))
            continue;

        // this will allocate empty data set storage
        AchievementCriteriaDataSet& dataSet = _criteriaDataMap[criteria_id];
        dataSet.SetCriteriaId(criteria_id);

        // add real data only for not NONE data types
        if (data.dataType != ACHIEVEMENT_CRITERIA_DATA_TYPE_NONE)
            dataSet.Add(data);

        // counting data by and data types
        ++count;
    } while (result->NextRow());

    // post loading checks
    for (uint32 entryId = 0; entryId < sAchievementCriteriaStore.GetNumRows(); ++entryId)
    {
        AchievementCriteriaEntry const* criteria = sAchievementCriteriaStore.LookupEntry(entryId);
        if (!criteria)
            continue;

        switch (criteria->requiredType)
        {
            case ACHIEVEMENT_CRITERIA_TYPE_KILL_CREATURE:
            case ACHIEVEMENT_CRITERIA_TYPE_WIN_BG:
            case ACHIEVEMENT_CRITERIA_TYPE_FALL_WITHOUT_DYING:
            case ACHIEVEMENT_CRITERIA_TYPE_BE_SPELL_TARGET:
            case ACHIEVEMENT_CRITERIA_TYPE_CAST_SPELL:
            case ACHIEVEMENT_CRITERIA_TYPE_BG_OBJECTIVE_CAPTURE:
            case ACHIEVEMENT_CRITERIA_TYPE_HONORABLE_KILL:
            case ACHIEVEMENT_CRITERIA_TYPE_OWN_RANK:
            case ACHIEVEMENT_CRITERIA_TYPE_EQUIP_EPIC_ITEM:
            case ACHIEVEMENT_CRITERIA_TYPE_ROLL_NEED_ON_LOOT:
            case ACHIEVEMENT_CRITERIA_TYPE_ROLL_GREED_ON_LOOT:
            case ACHIEVEMENT_CRITERIA_TYPE_GET_KILLING_BLOWS:
            case ACHIEVEMENT_CRITERIA_TYPE_BE_SPELL_TARGET2:
            case ACHIEVEMENT_CRITERIA_TYPE_SPECIAL_PVP_KILL:
            case ACHIEVEMENT_CRITERIA_TYPE_ON_LOGIN:
            case ACHIEVEMENT_CRITERIA_TYPE_KILL_CREATURE_TYPE:
            case ACHIEVEMENT_CRITERIA_TYPE_CAST_SPELL2:
                // achievement requires db data
                break;
            case ACHIEVEMENT_CRITERIA_TYPE_COMPLETE_QUEST:
                {
                    AchievementEntry const* achievement = sAchievementStore.LookupEntry(criteria->referredAchievement);
                    if (!achievement)
                        continue;

                    // exist many achievements with this criteria, use at this moment hardcoded check to skil simple case
                    if (achievement->ID == 1282)
                        break;

                    continue;
                }
            case ACHIEVEMENT_CRITERIA_TYPE_WIN_RATED_ARENA: // need skip generic cases
                if (criteria->additionalRequirements[0].additionalRequirement_type != ACHIEVEMENT_CRITERIA_CONDITION_NO_LOSE)
                    continue;
                break;
            case ACHIEVEMENT_CRITERIA_TYPE_DO_EMOTE:        // need skip generic cases
                if (criteria->do_emote.count == 0)
                    continue;
                break;
            case ACHIEVEMENT_CRITERIA_TYPE_WIN_DUEL:        // skip statistics
                if (criteria->win_duel.duelCount == 0)
                    continue;
                break;
            case ACHIEVEMENT_CRITERIA_TYPE_LOOT_TYPE:       // need skip generic cases
                if (criteria->loot_type.lootTypeCount != 1)
                    continue;
                break;
            case ACHIEVEMENT_CRITERIA_TYPE_COMPLETE_DAILY_QUEST:
            case ACHIEVEMENT_CRITERIA_TYPE_USE_ITEM:        // only Children's Week achievements
                {
                    AchievementEntry const* achievement = sAchievementStore.LookupEntry(criteria->referredAchievement);
                    if (!achievement)
                        continue;
                    if (achievement->categoryId != CATEGORY_CHILDRENS_WEEK)
                        continue;
                    break;
                }
            default:                                        // type not use DB data, ignore
                continue;
        }

        if (!GetCriteriaDataSet(criteria) && !DisableMgr::IsDisabledFor(DISABLE_TYPE_ACHIEVEMENT_CRITERIA, entryId, nullptr))
            LOG_ERROR("sql.sql", "Table `achievement_criteria_data` does not have expected data for criteria (Entry: {} Type: {}) for achievement {}.", criteria->ID, criteria->requiredType, criteria->referredAchievement);
    }

    LOG_INFO("server.loading", ">> Loaded {} additional achievement criteria data in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
}

void AchievementGlobalMgr::LoadCompletedAchievements()
{
    uint32 oldMSTime = getMSTime();

    QueryResult result = CharacterDatabase.Query("SELECT achievement FROM character_achievement GROUP BY achievement");

    // Populate _allCompletedAchievements with all realm first achievement ids to make multithreaded access safer
    // while it will not prevent races, it will prevent crashes that happen because std::unordered_map key was added
    // instead the only potential race will happen on value associated with the key
    for (uint32 i = 0; i < sAchievementStore.GetNumRows(); ++i)
        if (AchievementEntry const* achievement = sAchievementStore.LookupEntry(i))
            if (achievement->flags & (ACHIEVEMENT_FLAG_REALM_FIRST_REACH | ACHIEVEMENT_FLAG_REALM_FIRST_KILL))
                _allCompletedAchievements[achievement->ID] = SystemTimePoint::min();

    if (!result)
    {
        LOG_WARN("server.loading", ">> Loaded 0 completed achievements. DB table `character_achievement` is empty.");
        LOG_INFO("server.loading", " ");
        return;
    }

    do
    {
        Field* fields = result->Fetch();

        uint16 achievementId = fields[0].Get<uint16>();
        const AchievementEntry* achievement = sAchievementStore.LookupEntry(achievementId);
        if (!achievement)
        {
            // Remove non existent achievements from all characters
            LOG_ERROR("achievement", "Non-existing achievement {} data removed from table `character_achievement`.", achievementId);

            CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_INVALID_ACHIEVMENT);

            stmt->SetData(0, uint16(achievementId));
            CharacterDatabase.Execute(stmt);

            continue;
        }
        else if (achievement->flags & (ACHIEVEMENT_FLAG_REALM_FIRST_REACH | ACHIEVEMENT_FLAG_REALM_FIRST_KILL))
            _allCompletedAchievements[achievementId] =  SystemTimePoint::max();
    } while (result->NextRow());

    LOG_INFO("server.loading", ">> Loaded {} completed achievements in {} ms", (unsigned long)_allCompletedAchievements.size(), GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
}

void AchievementGlobalMgr::LoadRewards()
{
    uint32 oldMSTime = getMSTime();

    _achievementRewards.clear();                           // need for reload case

    //                                               0      1        2        3     4       5        6     7
    QueryResult result = WorldDatabase.Query("SELECT ID, TitleA, TitleH, ItemID, Sender, Subject, Body, MailTemplateID FROM achievement_reward");

    if (!result)
    {
        LOG_WARN("server.loading", ">> Loaded 0 achievement rewards. DB table `achievement_reward` is empty.");
        LOG_INFO("server.loading", " ");
        return;
    }

    uint32 count = 0;

    do
    {
        Field* fields = result->Fetch();
        uint32 entry = fields[0].Get<uint32>();
        AchievementEntry const* achievement = sAchievementStore.LookupEntry(entry);
        if (!achievement)
        {
            LOG_ERROR("sql.sql", "Table `achievement_reward` has wrong achievement (Entry: {}). Ignoring.", entry);
            continue;
        }

        AchievementReward reward;
        reward.titleId[0]   = fields[1].Get<uint32>(); // Alliance title
        reward.titleId[1]   = fields[2].Get<uint32>(); // Horde title
        reward.itemId       = fields[3].Get<uint32>();
        reward.sender       = fields[4].Get<uint32>(); // The sender of the mail (a creature from creature_template)
        reward.subject      = fields[5].Get<std::string>();
        reward.text         = fields[6].Get<std::string>(); // Body in DB
        reward.mailTemplate = fields[7].Get<uint32>();

        // Must reward a title or send a mail else, skip it.
        if (!reward.titleId[0] && !reward.titleId[1] && !reward.sender)
        {
            LOG_ERROR("sql.sql", "Table `achievement_reward` (Entry: {}) does not have any title or item reward data. Ignoring.", entry);
            continue;
        }

        if (achievement->requiredFaction == ACHIEVEMENT_FACTION_ANY && (!reward.titleId[0] ^ !reward.titleId[1]))
            LOG_DEBUG("achievement", "Table `achievement_reward` (Entry: {}) has title (A: {} H: {}) set for only one team.", entry, reward.titleId[0], reward.titleId[1]);

        if (reward.titleId[0])
        {
            CharTitlesEntry const* titleEntry = sCharTitlesStore.LookupEntry(reward.titleId[0]);
            if (!titleEntry)
            {
                LOG_ERROR("sql.sql", "Table `achievement_reward` (Entry: {}) has invalid title id ({}) in `title_A`. Setting it to 0.", entry, reward.titleId[0]);
                reward.titleId[0] = 0;
            }
        }

        if (reward.titleId[1])
        {
            CharTitlesEntry const* titleEntry = sCharTitlesStore.LookupEntry(reward.titleId[1]);
            if (!titleEntry)
            {
                LOG_ERROR("sql.sql", "Table `achievement_reward` (Entry: {}) has invalid title id ({}) in `title_H`. Setting it to 0.", entry, reward.titleId[1]);
                reward.titleId[1] = 0;
            }
        }

        // Check mail data before item for report including wrong item case
        if (reward.sender)
        {
            if (!sObjectMgr->GetCreatureTemplate(reward.sender))
            {
                LOG_ERROR("sql.sql", "Table `achievement_reward` (Entry: {}) has invalid creature_template entry {} as Sender. Will not send the mail reward.", entry, reward.sender);
                reward.sender = 0;
            }
        }
        else
        {
            if (reward.itemId)
                LOG_ERROR("sql.sql", "Table `achievement_reward` (Entry: {}) has itemId reward set but does not have Sender data set. Item will not be sent.", entry);

            if (!reward.subject.empty())
                LOG_ERROR("sql.sql", "Table `achievement_reward` (Entry: {}) has mail Subject but does not have Sender data set.", entry); // Maybe add "Mail will not be sent." ?

            if (!reward.text.empty())
                LOG_ERROR("sql.sql", "Table `achievement_reward` (Entry: {}) has mail text (Body) set but does not have Sender data set.", entry); // Maybe add "Mail will not be sent." ?

            if (reward.mailTemplate)
                LOG_ERROR("sql.sql", "Table `achievement_reward` (Entry: {}) has mailTemplate set does not have Sender data set.", entry); // Maybe add "Mail will not be sent." ?
        }

        if (reward.mailTemplate)
        {
            if (!sMailTemplateStore.LookupEntry(reward.mailTemplate))
            {
                LOG_ERROR("sql.sql", "Table `achievement_reward` (Entry: {}) has invalid mailTemplate ({}) (check the DBC).", entry, reward.mailTemplate);
                reward.mailTemplate = 0;
            }
            else if (!reward.subject.empty() || !reward.text.empty())
                LOG_ERROR("sql.sql", "Table `achievement_reward` (Entry: {}) has mailTemplate ({}) and mail Subject/Body. To use the column mailTemplate, Subject and Body must be empty.", entry, reward.mailTemplate);
        }

        if (reward.itemId)
        {
            if (!sObjectMgr->GetItemTemplate(reward.itemId))
            {
                // Not sure it's an error, it's probably an outDebug instead, because we can simply send a mail with no reward, right?
                LOG_ERROR("sql.sql", "Table `achievement_reward` (Entry: {}) has invalid item_template id {}. Reward mail will not contain any item.", entry, reward.itemId);
                reward.itemId = 0;
            }
        }

        _achievementRewards[entry] = reward;
        ++count;
    } while (result->NextRow());

    LOG_INFO("server.loading", ">> Loaded {} achievement rewards in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
}

void AchievementGlobalMgr::LoadRewardLocales()
{
    uint32 oldMSTime = getMSTime();

    _achievementRewardLocales.clear();                       // need for reload case

    //                                               0   1       2        3
    QueryResult result = WorldDatabase.Query("SELECT ID, Locale, Subject, Text FROM achievement_reward_locale");

    if (!result)
    {
        LOG_WARN("server.loading", ">> Loaded 0 achievement reward locale strings.  DB table `achievement_reward_locale` is empty");
        LOG_INFO("server.loading", " ");
        return;
    }

    do
    {
        Field* fields = result->Fetch();

        uint32 ID = fields[0].Get<uint32>();
        if (_achievementRewards.find(ID) == _achievementRewards.end())
        {
            LOG_ERROR("sql.sql", "Table `achievement_reward_locale` (Entry: {}) has locale strings for non-existing achievement reward.", ID);
            continue;
        }

        LocaleConstant locale = GetLocaleByName(fields[1].Get<std::string>());
        if (locale == LOCALE_enUS)
            continue;

        AchievementRewardLocale& data = _achievementRewardLocales[ID];
        ObjectMgr::AddLocaleString(fields[2].Get<std::string>(), locale, data.Subject);
        ObjectMgr::AddLocaleString(fields[3].Get<std::string>(), locale, data.Text);
    } while (result->NextRow());

    LOG_INFO("server.loading", ">> Loaded {} Achievement Reward Locale Strings in {} ms", (unsigned long)_achievementRewardLocales.size(), GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
}

AchievementEntry const* AchievementGlobalMgr::GetAchievement(uint32 achievementId) const
{
    return sAchievementStore.LookupEntry(achievementId);
}

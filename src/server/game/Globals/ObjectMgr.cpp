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

#include "ObjectMgr.h"
#include "AchievementMgr.h"
#include "ArenaTeamMgr.h"
#include "CharacterCache.h"
#include "Chat.h"
#include "Common.h"
#include "Config.h"
#include "Containers.h"
#include "CreatureAIFactory.h"
#include "DBCStructure.h"
#include "DatabaseEnv.h"
#include "DisableMgr.h"
#include "GameEventMgr.h"
#include "GameObjectAIFactory.h"
#include "GameTime.h"
#include "GossipDef.h"
#include "GroupMgr.h"
#include "GuildMgr.h"
#include "LFGMgr.h"
#include "Log.h"
#include "MapMgr.h"
#include "Pet.h"
#include "PoolMgr.h"
#include "ReputationMgr.h"
#include "ScriptMgr.h"
#include "Spell.h"
#include "SpellMgr.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "StringConvert.h"
#include "Tokenize.h"
#include "Transport.h"
#include "Unit.h"
#include "Util.h"
#include "Vehicle.h"
#include "World.h"
#include <boost/algorithm/string.hpp>

ScriptMapMap sSpellScripts;
ScriptMapMap sEventScripts;
ScriptMapMap sWaypointScripts;

std::string GetScriptsTableNameByType(ScriptsType type)
{
    std::string res = "";
    switch (type)
    {
        case SCRIPTS_SPELL:
            res = "spell_scripts";
            break;
        case SCRIPTS_EVENT:
            res = "event_scripts";
            break;
        case SCRIPTS_WAYPOINT:
            res = "waypoint_scripts";
            break;
        default:
            break;
    }
    return res;
}

ScriptMapMap* GetScriptsMapByType(ScriptsType type)
{
    ScriptMapMap* res = nullptr;
    switch (type)
    {
        case SCRIPTS_SPELL:
            res = &sSpellScripts;
            break;
        case SCRIPTS_EVENT:
            res = &sEventScripts;
            break;
        case SCRIPTS_WAYPOINT:
            res = &sWaypointScripts;
            break;
        default:
            break;
    }
    return res;
}

std::string GetScriptCommandName(ScriptCommands command)
{
    std::string res = "";
    switch (command)
    {
        case SCRIPT_COMMAND_TALK:
            res = "SCRIPT_COMMAND_TALK";
            break;
        case SCRIPT_COMMAND_EMOTE:
            res = "SCRIPT_COMMAND_EMOTE";
            break;
        case SCRIPT_COMMAND_FIELD_SET:
            res = "SCRIPT_COMMAND_FIELD_SET";
            break;
        case SCRIPT_COMMAND_MOVE_TO:
            res = "SCRIPT_COMMAND_MOVE_TO";
            break;
        case SCRIPT_COMMAND_FLAG_SET:
            res = "SCRIPT_COMMAND_FLAG_SET";
            break;
        case SCRIPT_COMMAND_FLAG_REMOVE:
            res = "SCRIPT_COMMAND_FLAG_REMOVE";
            break;
        case SCRIPT_COMMAND_TELEPORT_TO:
            res = "SCRIPT_COMMAND_TELEPORT_TO";
            break;
        case SCRIPT_COMMAND_QUEST_EXPLORED:
            res = "SCRIPT_COMMAND_QUEST_EXPLORED";
            break;
        case SCRIPT_COMMAND_KILL_CREDIT:
            res = "SCRIPT_COMMAND_KILL_CREDIT";
            break;
        case SCRIPT_COMMAND_RESPAWN_GAMEOBJECT:
            res = "SCRIPT_COMMAND_RESPAWN_GAMEOBJECT";
            break;
        case SCRIPT_COMMAND_TEMP_SUMMON_CREATURE:
            res = "SCRIPT_COMMAND_TEMP_SUMMON_CREATURE";
            break;
        case SCRIPT_COMMAND_OPEN_DOOR:
            res = "SCRIPT_COMMAND_OPEN_DOOR";
            break;
        case SCRIPT_COMMAND_CLOSE_DOOR:
            res = "SCRIPT_COMMAND_CLOSE_DOOR";
            break;
        case SCRIPT_COMMAND_ACTIVATE_OBJECT:
            res = "SCRIPT_COMMAND_ACTIVATE_OBJECT";
            break;
        case SCRIPT_COMMAND_REMOVE_AURA:
            res = "SCRIPT_COMMAND_REMOVE_AURA";
            break;
        case SCRIPT_COMMAND_CAST_SPELL:
            res = "SCRIPT_COMMAND_CAST_SPELL";
            break;
        case SCRIPT_COMMAND_PLAY_SOUND:
            res = "SCRIPT_COMMAND_PLAY_SOUND";
            break;
        case SCRIPT_COMMAND_CREATE_ITEM:
            res = "SCRIPT_COMMAND_CREATE_ITEM";
            break;
        case SCRIPT_COMMAND_DESPAWN_SELF:
            res = "SCRIPT_COMMAND_DESPAWN_SELF";
            break;
        case SCRIPT_COMMAND_LOAD_PATH:
            res = "SCRIPT_COMMAND_LOAD_PATH";
            break;
        case SCRIPT_COMMAND_CALLSCRIPT_TO_UNIT:
            res = "SCRIPT_COMMAND_CALLSCRIPT_TO_UNIT";
            break;
        case SCRIPT_COMMAND_KILL:
            res = "SCRIPT_COMMAND_KILL";
            break;
        // AzerothCore only
        case SCRIPT_COMMAND_ORIENTATION:
            res = "SCRIPT_COMMAND_ORIENTATION";
            break;
        case SCRIPT_COMMAND_EQUIP:
            res = "SCRIPT_COMMAND_EQUIP";
            break;
        case SCRIPT_COMMAND_MODEL:
            res = "SCRIPT_COMMAND_MODEL";
            break;
        case SCRIPT_COMMAND_CLOSE_GOSSIP:
            res = "SCRIPT_COMMAND_CLOSE_GOSSIP";
            break;
        case SCRIPT_COMMAND_PLAYMOVIE:
            res = "SCRIPT_COMMAND_PLAYMOVIE";
            break;
        default:
            {
                char sz[32];
                snprintf(sz, sizeof(sz), "Unknown command: %d", command);
                res = sz;
                break;
            }
    }
    return res;
}

std::string ScriptInfo::GetDebugInfo() const
{
    char sz[256];
    snprintf(sz, sizeof(sz), "%s ('%s' script id: %u)", GetScriptCommandName(command).c_str(), GetScriptsTableNameByType(type).c_str(), id);
    return std::string(sz);
}

/**
 * @name ReservedNames
 * @brief Checks NamesReserved.dbc for reserved names
 *
 * @param name Name to check for match in NamesReserved.dbc
 * @return true/false
 */
bool ReservedNames(std::wstring& name)
{
    for (NamesReservedEntry const* reservedStore : sNamesReservedStore)
    {
        std::wstring PatternString;

        Utf8toWStr(reservedStore->Pattern, PatternString);

        boost::algorithm::replace_all(PatternString, "\\<", "");
        boost::algorithm::replace_all(PatternString, "\\>", "");

        int stringCompare = name.compare(PatternString);
        if (stringCompare == 0)
        {
            return true;
        }
    }

    return false;
};

/**
 * @name ProfanityNames
 * @brief Checks NamesProfanity.dbc for reserved names
 *
 * @param name Name to check for match in NamesProfanity.dbc
 * @return true/false
 */
bool ProfanityNames(std::wstring& name)
{
    for (NamesProfanityEntry const* profanityStore : sNamesProfanityStore)
    {
        std::wstring PatternString;

        Utf8toWStr(profanityStore->Pattern, PatternString);

        boost::algorithm::replace_all(PatternString, "\\<", "");
        boost::algorithm::replace_all(PatternString, "\\>", "");

        int stringCompare = name.compare(PatternString);
        if (stringCompare == 0)
        {
            return true;
        }
    }

    return false;
}

bool normalizePlayerName(std::string& name)
{
    if (name.empty())
        return false;

    if (name.find(" ") != std::string::npos)
        return false;

    std::wstring tmp;
    if (!Utf8toWStr(name, tmp))
        return false;

    wstrToLower(tmp);
    if (!tmp.empty())
        tmp[0] = wcharToUpper(tmp[0]);

    if (!WStrToUtf8(tmp, name))
        return false;

    return true;
}

LanguageDesc lang_description[LANGUAGES_COUNT] =
{
    { LANG_ADDON,           0, 0                       },
    { LANG_UNIVERSAL,       0, 0                       },
    { LANG_ORCISH,        669, SKILL_LANG_ORCISH       },
    { LANG_DARNASSIAN,    671, SKILL_LANG_DARNASSIAN   },
    { LANG_TAURAHE,       670, SKILL_LANG_TAURAHE      },
    { LANG_DWARVISH,      672, SKILL_LANG_DWARVEN      },
    { LANG_COMMON,        668, SKILL_LANG_COMMON       },
    { LANG_DEMONIC,       815, SKILL_LANG_DEMON_TONGUE },
    { LANG_TITAN,         816, SKILL_LANG_TITAN        },
    { LANG_THALASSIAN,    813, SKILL_LANG_THALASSIAN   },
    { LANG_DRACONIC,      814, SKILL_LANG_DRACONIC     },
    { LANG_KALIMAG,       817, SKILL_LANG_OLD_TONGUE   },
    { LANG_GNOMISH,      7340, SKILL_LANG_GNOMISH      },
    { LANG_TROLL,        7341, SKILL_LANG_TROLL        },
    { LANG_GUTTERSPEAK, 17737, SKILL_LANG_GUTTERSPEAK  },
    { LANG_DRAENEI,     29932, SKILL_LANG_DRAENEI      },
    { LANG_ZOMBIE,          0, 0                       },
    { LANG_GNOMISH_BINARY,  0, 0                       },
    { LANG_GOBLIN_BINARY,   0, 0                       }
};

LanguageDesc const* GetLanguageDescByID(uint32 lang)
{
    for (uint8 i = 0; i < LANGUAGES_COUNT; ++i)
    {
        if (uint32(lang_description[i].lang_id) == lang)
            return &lang_description[i];
    }

    return nullptr;
}

bool SpellClickInfo::IsFitToRequirements(Unit const* clicker, Unit const* clickee) const
{
    Player const* playerClicker = clicker->ToPlayer();
    if (!playerClicker)
        return true;

    Unit const* summoner = nullptr;
    // Check summoners for party
    if (clickee->IsSummon())
        summoner = clickee->ToTempSummon()->GetSummonerUnit();
    if (!summoner)
        summoner = clickee;

    // This only applies to players
    switch (userType)
    {
        case SPELL_CLICK_USER_FRIEND:
            if (!playerClicker->IsFriendlyTo(summoner))
                return false;
            break;
        case SPELL_CLICK_USER_RAID:
            if (!playerClicker->IsInRaidWith(summoner))
                return false;
            break;
        case SPELL_CLICK_USER_PARTY:
            if (!playerClicker->IsInPartyWith(summoner))
                return false;
            break;
        default:
            break;
    }

    return true;
}

ObjectMgr::ObjectMgr():
    _auctionId(1),
    _equipmentSetGuid(1),
    _mailId(1),
    _hiPetNumber(1),
    _creatureSpawnId(1),
    _gameObjectSpawnId(1),
    DBCLocaleIndex(LOCALE_enUS)
{
    for (uint8 i = 0; i < MAX_CLASSES; ++i)
    {
        _playerClassInfo[i] = nullptr;
        for (uint8 j = 0; j < MAX_RACES; ++j)
            _playerInfo[j][i] = nullptr;
    }
}

ObjectMgr::~ObjectMgr()
{
    for (QuestMap::iterator i = _questTemplates.begin(); i != _questTemplates.end(); ++i)
        delete i->second;

    for (PetLevelInfoContainer::iterator i = _petInfoStore.begin(); i != _petInfoStore.end(); ++i)
        delete[] i->second;

    // free only if loaded
    for (int class_ = 0; class_ < MAX_CLASSES; ++class_)
    {
        if (_playerClassInfo[class_])
            delete[] _playerClassInfo[class_]->levelInfo;
        delete _playerClassInfo[class_];
    }

    for (int race = 0; race < MAX_RACES; ++race)
    {
        for (int class_ = 0; class_ < MAX_CLASSES; ++class_)
        {
            if (_playerInfo[race][class_])
                delete[] _playerInfo[race][class_]->levelInfo;
            delete _playerInfo[race][class_];
        }
    }

    for (CacheVendorItemContainer::iterator itr = _cacheVendorItemStore.begin(); itr != _cacheVendorItemStore.end(); ++itr)
        itr->second.Clear();

    _cacheTrainerSpellStore.clear();

    for (DungeonEncounterContainer::iterator itr = _dungeonEncounterStore.begin(); itr != _dungeonEncounterStore.end(); ++itr)
        for (DungeonEncounterList::iterator encounterItr = itr->second.begin(); encounterItr != itr->second.end(); ++encounterItr)
            delete *encounterItr;

    for (DungeonProgressionRequirementsContainer::iterator itr = _accessRequirementStore.begin(); itr != _accessRequirementStore.end(); ++itr)
    {
        std::unordered_map<uint8, DungeonProgressionRequirements*> difficulties = itr->second;
        for (auto difficultiesItr = difficulties.begin(); difficultiesItr != difficulties.end(); ++difficultiesItr)
        {
            for (auto questItr = difficultiesItr->second->quests.begin(); questItr != difficultiesItr->second->quests.end(); ++questItr)
            {
                delete* questItr;
            }

            for (auto achievementItr = difficultiesItr->second->achievements.begin(); achievementItr != difficultiesItr->second->achievements.end(); ++achievementItr)
            {
                delete* achievementItr;
            }

            for (auto itemsItr = difficultiesItr->second->items.begin(); itemsItr != difficultiesItr->second->items.end(); ++itemsItr)
            {
                delete* itemsItr;
            }

            delete difficultiesItr->second;
        }
    }
}

ObjectMgr* ObjectMgr::instance()
{
    static ObjectMgr instance;
    return &instance;
}

void ObjectMgr::AddLocaleString(std::string&& s, LocaleConstant locale, std::vector<std::string>& data)
{
    if (!s.empty())
    {
        if (data.size() <= size_t(locale))
            data.resize(locale + 1);

        data[locale] = std::move(s);
    }
}

void ObjectMgr::LoadCreatureLocales()
{
    uint32 oldMSTime = getMSTime();

    _creatureLocaleStore.clear();                              // need for reload case

    //                                               0      1       2     3
    QueryResult result = WorldDatabase.Query("SELECT entry, locale, Name, Title FROM creature_template_locale");
    if (!result)
        return;

    do
    {
        Field* fields = result->Fetch();

        uint32 ID = fields[0].Get<uint32>();

        LocaleConstant locale = GetLocaleByName(fields[1].Get<std::string>());
        if (locale == LOCALE_enUS)
            continue;

        CreatureLocale& data = _creatureLocaleStore[ID];
        AddLocaleString(fields[2].Get<std::string>(), locale, data.Name);
        AddLocaleString(fields[3].Get<std::string>(), locale, data.Title);
    } while (result->NextRow());

    LOG_INFO("server.loading", ">> Loaded {} Creature Locale Strings in {} ms", (unsigned long)_creatureLocaleStore.size(), GetMSTimeDiffToNow(oldMSTime));
}

void ObjectMgr::LoadGossipMenuItemsLocales()
{
    uint32 oldMSTime = getMSTime();

    _gossipMenuItemsLocaleStore.clear();                              // need for reload case

    //                                               0       1            2       3           4
    QueryResult result = WorldDatabase.Query("SELECT MenuID, OptionID, Locale, OptionText, BoxText FROM gossip_menu_option_locale");

    if (!result)
        return;

    do
    {
        Field* fields = result->Fetch();

        uint32 MenuID = fields[0].Get<uint32>();
        uint16 OptionID = fields[1].Get<uint16>();

        LocaleConstant locale = GetLocaleByName(fields[2].Get<std::string>());
        if (locale == LOCALE_enUS)
            continue;

        GossipMenuItemsLocale& data = _gossipMenuItemsLocaleStore[MAKE_PAIR32(MenuID, OptionID)];
        AddLocaleString(fields[3].Get<std::string>(), locale, data.OptionText);
        AddLocaleString(fields[4].Get<std::string>(), locale, data.BoxText);
    } while (result->NextRow());

    LOG_INFO("server.loading", ">> Loaded {} Gossip Menu Option Locale Strings in {} ms", (uint32)_gossipMenuItemsLocaleStore.size(), GetMSTimeDiffToNow(oldMSTime));
}

void ObjectMgr::LoadPetNamesLocales()
{
    uint32 oldMSTime = getMSTime();

    //                                                  0     1      2    3
    QueryResult result = WorldDatabase.Query("SELECT Locale, Word, Entry, Half FROM pet_name_generation_locale");

    if (!result)
    {
        LOG_WARN("server.loading", ">> Loaded 0 pet name locales parts. DB table `pet_name_generation_locale` is empty!");
        LOG_INFO("server.loading", " ");
        return;
    }

    uint32 count = 0;

    do
    {
        Field* fields = result->Fetch();
        LocaleConstant locale = GetLocaleByName(fields[0].Get<std::string>());
        std::string word = fields[1].Get<std::string>();

        uint32 entry = fields[2].Get<uint32>();
        bool half = fields[3].Get<bool>();
        std::pair<uint32, LocaleConstant> pairkey = std::make_pair(entry, locale);
        if (half)
        {
            _petHalfLocaleName1[pairkey].push_back(word);
        }
        else
        {
            _petHalfLocaleName0[pairkey].push_back(word);
        }
        ++count;
    } while (result->NextRow());

    LOG_INFO("server.loading", ">> Loaded {} Pet Name Locales Parts in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
}

void ObjectMgr::LoadPointOfInterestLocales()
{
    uint32 oldMSTime = getMSTime();

    _pointOfInterestLocaleStore.clear();                              // need for reload case

    //                                               0   1       2
    QueryResult result = WorldDatabase.Query("SELECT ID, locale, Name FROM points_of_interest_locale");

    if (!result)
        return;

    do
    {
        Field* fields = result->Fetch();

        uint32 ID = fields[0].Get<uint32>();

        LocaleConstant locale = GetLocaleByName(fields[1].Get<std::string>());
        if (locale == LOCALE_enUS)
            continue;

        PointOfInterestLocale& data = _pointOfInterestLocaleStore[ID];
        AddLocaleString(fields[2].Get<std::string>(), locale, data.Name);
    } while (result->NextRow());

    LOG_INFO("server.loading", ">> Loaded {} Points Of Interest Locale Strings in {} ms", (uint32)_pointOfInterestLocaleStore.size(), GetMSTimeDiffToNow(oldMSTime));
}

void ObjectMgr::LoadCreatureTemplates()
{
    uint32 oldMSTime = getMSTime();

//                                                   0      1                   2                   3                   4            5            6         7         8
    QueryResult result = WorldDatabase.Query("SELECT entry, difficulty_entry_1, difficulty_entry_2, difficulty_entry_3, KillCredit1, KillCredit2, modelid1, modelid2, modelid3, "
//                        9         10    11       12        13              14        15        16   17       18       19          20         21          22
                         "modelid4, name, subname, IconName, gossip_menu_id, minlevel, maxlevel, exp, faction, npcflag, speed_walk, speed_run, speed_swim, speed_flight, "
//                        23               24     25      26         27              28              29               30            31             32          33          34
                         "detection_range, scale, `rank`, dmgschool, DamageModifier, BaseAttackTime, RangeAttackTime, BaseVariance, RangeVariance, unit_class, unit_flags, unit_flags2, "
//                        35            36      37            38             39             40            41
                         "dynamicflags, family, trainer_type, trainer_spell, trainer_class, trainer_race, type, "
//                        42          43      44              45        46              47         48       49       50      51
                         "type_flags, lootid, pickpocketloot, skinloot, PetSpellDataId, VehicleId, mingold, maxgold, AIName, MovementType, "
//                        52          53        54          55          56         57          58                         59           60              61            62             63
                         "ctm.Ground, ctm.Swim, ctm.Flight, ctm.Rooted, ctm.Chase, ctm.Random, ctm.InteractionPauseTimer, HoverHeight, HealthModifier, ManaModifier, ArmorModifier, ExperienceModifier, "
//                        64            65          66           67                    68                        69           70
                         "RacialLeader, movementId, RegenHealth, mechanic_immune_mask, spell_school_immune_mask, flags_extra, ScriptName "
                         "FROM creature_template ct LEFT JOIN creature_template_movement ctm ON ct.entry = ctm.CreatureId ORDER BY entry DESC;");

    if (!result)
    {
        LOG_WARN("server.loading", ">> Loaded 0 creature template definitions. DB table `creature_template` is empty.");
        return;
    }

    _creatureTemplateStore.rehash(result->GetRowCount());
    _creatureTemplateStoreFast.clear();

    uint32 count = 0;
    do
    {
        Field* fields = result->Fetch();
        LoadCreatureTemplate(fields);
        ++count;
    } while (result->NextRow());

    sScriptMgr->OnAfterDatabaseLoadCreatureTemplates(_creatureTemplateStoreFast);

    LoadCreatureTemplateResistances();
    LoadCreatureTemplateSpells();

    // Checking needs to be done after loading because of the difficulty self referencing
    for (CreatureTemplateContainer::iterator itr = _creatureTemplateStore.begin(); itr != _creatureTemplateStore.end(); ++itr)
    {
        CheckCreatureTemplate(&itr->second);
        itr->second.InitializeQueryData();
    }

    LOG_INFO("server.loading", ">> Loaded {} Creature Definitions in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
}

/**
* @brief Loads a creature template from a database result
*
* @param fields Database result
* @param triggerHook If true, will trigger the OnAfterDatabaseLoadCreatureTemplates hook. Useful if you are not calling the hook yourself.
*/
void ObjectMgr::LoadCreatureTemplate(Field* fields, bool triggerHook)
{
    uint32 entry = fields[0].Get<uint32>();

    CreatureTemplate& creatureTemplate = _creatureTemplateStore[entry];

    // enlarge the fast cache as necessary
    if (_creatureTemplateStoreFast.size() < entry + 1)
    {
        _creatureTemplateStoreFast.resize(entry + 1, nullptr);
    }

    // load a pointer to this creatureTemplate into the fast cache
    _creatureTemplateStoreFast[entry] = &creatureTemplate;

    // build the creatureTemplate
    creatureTemplate.Entry = entry;

    for (uint8 i = 0; i < MAX_DIFFICULTY - 1; ++i)
    {
        creatureTemplate.DifficultyEntry[i] = fields[1 + i].Get<uint32>();
    }

    for (uint8 i = 0; i < MAX_KILL_CREDIT; ++i)
    {
        creatureTemplate.KillCredit[i] = fields[4 + i].Get<uint32>();
    }

    creatureTemplate.Modelid1         = fields[6].Get<uint32>();
    creatureTemplate.Modelid2         = fields[7].Get<uint32>();
    creatureTemplate.Modelid3         = fields[8].Get<uint32>();
    creatureTemplate.Modelid4         = fields[9].Get<uint32>();
    creatureTemplate.Name             = fields[10].Get<std::string>();
    creatureTemplate.SubName          = fields[11].Get<std::string>();
    creatureTemplate.IconName         = fields[12].Get<std::string>();
    creatureTemplate.GossipMenuId     = fields[13].Get<uint32>();
    creatureTemplate.minlevel         = fields[14].Get<uint8>();
    creatureTemplate.maxlevel         = fields[15].Get<uint8>();
    creatureTemplate.expansion        = uint32(fields[16].Get<int16>());
    creatureTemplate.faction          = uint32(fields[17].Get<uint16>());
    creatureTemplate.npcflag          = fields[18].Get<uint32>();
    creatureTemplate.speed_walk       = fields[19].Get<float>();
    creatureTemplate.speed_run        = fields[20].Get<float>();
    creatureTemplate.speed_swim       = fields[21].Get<float>();
    creatureTemplate.speed_flight     = fields[22].Get<float>();
    creatureTemplate.detection_range  = fields[23].Get<float>();
    creatureTemplate.scale            = fields[24].Get<float>();
    creatureTemplate.rank             = uint32(fields[25].Get<uint8>());
    creatureTemplate.dmgschool        = uint32(fields[26].Get<int8>());
    creatureTemplate.DamageModifier   = fields[27].Get<float>();
    creatureTemplate.BaseAttackTime   = fields[28].Get<uint32>();
    creatureTemplate.RangeAttackTime  = fields[29].Get<uint32>();
    creatureTemplate.BaseVariance     = fields[30].Get<float>();
    creatureTemplate.RangeVariance    = fields[31].Get<float>();
    creatureTemplate.unit_class       = uint32(fields[32].Get<uint8>());
    creatureTemplate.unit_flags       = fields[33].Get<uint32>();
    creatureTemplate.unit_flags2      = fields[34].Get<uint32>();
    creatureTemplate.dynamicflags     = fields[35].Get<uint32>();
    creatureTemplate.family           = uint32(fields[36].Get<uint8>());
    creatureTemplate.trainer_type     = uint32(fields[37].Get<uint8>());
    creatureTemplate.trainer_spell    = fields[38].Get<uint32>();
    creatureTemplate.trainer_class    = uint32(fields[39].Get<uint8>());
    creatureTemplate.trainer_race     = uint32(fields[40].Get<uint8>());
    creatureTemplate.type             = uint32(fields[41].Get<uint8>());
    creatureTemplate.type_flags       = fields[42].Get<uint32>();
    creatureTemplate.lootid           = fields[43].Get<uint32>();
    creatureTemplate.pickpocketLootId = fields[44].Get<uint32>();
    creatureTemplate.SkinLootId       = fields[45].Get<uint32>();

    for (uint8 i = SPELL_SCHOOL_HOLY; i < MAX_SPELL_SCHOOL; ++i)
    {
        creatureTemplate.resistance[i] = 0;
    }

    for (uint8 i = 0; i < MAX_CREATURE_SPELLS; ++i)
    {
        creatureTemplate.spells[i] = 0;
    }

    creatureTemplate.PetSpellDataId = fields[46].Get<uint32>();
    creatureTemplate.VehicleId      = fields[47].Get<uint32>();
    creatureTemplate.mingold        = fields[48].Get<uint32>();
    creatureTemplate.maxgold        = fields[49].Get<uint32>();
    creatureTemplate.AIName         = fields[50].Get<std::string>();
    creatureTemplate.MovementType   = uint32(fields[51].Get<uint8>());
    if (!fields[52].IsNull())
    {
        creatureTemplate.Movement.Ground = static_cast<CreatureGroundMovementType>(fields[52].Get<uint8>());
    }

    creatureTemplate.Movement.Swim = fields[53].Get<bool>();
    if (!fields[54].IsNull())
    {
        creatureTemplate.Movement.Flight = static_cast<CreatureFlightMovementType>(fields[54].Get<uint8>());
    }

    creatureTemplate.Movement.Rooted = fields[55].Get<bool>();
    if (!fields[56].IsNull())
    {
        creatureTemplate.Movement.Chase = static_cast<CreatureChaseMovementType>(fields[56].Get<uint8>());
    }
    if (!fields[57].IsNull())
    {
        creatureTemplate.Movement.Random = static_cast<CreatureRandomMovementType>(fields[57].Get<uint8>());
    }
    if (!fields[58].IsNull())
    {
        creatureTemplate.Movement.InteractionPauseTimer = fields[58].Get<uint32>();
    }

    creatureTemplate.HoverHeight           = fields[59].Get<float>();
    creatureTemplate.ModHealth             = fields[60].Get<float>();
    creatureTemplate.ModMana               = fields[61].Get<float>();
    creatureTemplate.ModArmor              = fields[62].Get<float>();
    creatureTemplate.ModExperience         = fields[63].Get<float>();
    creatureTemplate.RacialLeader          = fields[64].Get<bool>();
    creatureTemplate.movementId            = fields[65].Get<uint32>();
    creatureTemplate.RegenHealth           = fields[66].Get<bool>();
    creatureTemplate.MechanicImmuneMask    = fields[67].Get<uint32>();
    creatureTemplate.SpellSchoolImmuneMask = fields[68].Get<uint8>();
    creatureTemplate.flags_extra           = fields[69].Get<uint32>();
    creatureTemplate.ScriptID              = GetScriptId(fields[70].Get<std::string>());

    // useful if the creature template load is being triggered from outside this class
    if (triggerHook)
    {
        sScriptMgr->OnAfterDatabaseLoadCreatureTemplates(_creatureTemplateStoreFast);
    }

}

void ObjectMgr::LoadCreatureTemplateResistances()
{
    uint32 oldMSTime = getMSTime();

    //                                               0           1       2
    QueryResult result = WorldDatabase.Query("SELECT CreatureID, School, Resistance FROM creature_template_resistance");

    if (!result)
    {
        LOG_WARN("server.loading", ">> Loaded 0 creature template resistance definitions. DB table `creature_template_resistance` is empty.");
        LOG_INFO("server.loading", " ");
        return;
    }

    uint32 count = 0;

    do
    {
        Field* fields = result->Fetch();

        uint32 creatureID = fields[0].Get<uint32>();
        uint8 school = fields[1].Get<uint8>();

        if (school == SPELL_SCHOOL_NORMAL || school >= MAX_SPELL_SCHOOL)
        {
            LOG_ERROR("sql.sql", "creature_template_resistance has resistance definitions for creature {} but this school {} doesn't exist", creatureID, school);
            continue;
        }

        CreatureTemplateContainer::iterator itr = _creatureTemplateStore.find(creatureID);
        if (itr == _creatureTemplateStore.end())
        {
            LOG_ERROR("sql.sql", "creature_template_resistance has resistance definitions for creature {} but this creature doesn't exist", creatureID);
            continue;
        }

        CreatureTemplate& creatureTemplate = itr->second;
        creatureTemplate.resistance[school] = fields[2].Get<int16>();

        ++count;
    } while (result->NextRow());

    LOG_INFO("server.loading", ">> Loaded {} Creature Template Resistances in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
}

void ObjectMgr::LoadCreatureTemplateSpells()
{
    uint32 oldMSTime = getMSTime();

    //                                               0           1       2
    QueryResult result = WorldDatabase.Query("SELECT CreatureID, `Index`, Spell FROM creature_template_spell");

    if (!result)
    {
        LOG_WARN("server.loading", ">> Loaded 0 creature template spell definitions. DB table `creature_template_spell` is empty.");
        LOG_INFO("server.loading", " ");
        return;
    }

    uint32 count = 0;

    do
    {
        Field* fields = result->Fetch();

        uint32 creatureID = fields[0].Get<uint32>();
        uint8 index = fields[1].Get<uint8>();

        if (index >= MAX_CREATURE_SPELLS)
        {
            LOG_ERROR("sql.sql", "creature_template_spell has spell definitions for creature {} with a incorrect index {}", creatureID, index);
            continue;
        }

        CreatureTemplateContainer::iterator itr = _creatureTemplateStore.find(creatureID);
        if (itr == _creatureTemplateStore.end())
        {
            LOG_ERROR("sql.sql", "creature_template_spell has spell definitions for creature {} but this creature doesn't exist", creatureID);
            continue;
        }

        CreatureTemplate& creatureTemplate = itr->second;
        creatureTemplate.spells[index] = fields[2].Get<uint32>();

        ++count;
    } while (result->NextRow());

    LOG_INFO("server.loading", ">> Loaded {} Creature Template Spells in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
}

void ObjectMgr::LoadCreatureTemplateAddons()
{
    uint32 oldMSTime = getMSTime();

    //                                                0       1       2      3       4       5              6               7
    QueryResult result = WorldDatabase.Query("SELECT entry, path_id, mount, bytes1, bytes2, emote, visibilityDistanceType, auras FROM creature_template_addon");

    if (!result)
    {
        LOG_WARN("server.loading", ">> Loaded 0 creature template addon definitions. DB table `creature_template_addon` is empty.");
        LOG_INFO("server.loading", " ");
        return;
    }

    uint32 count = 0;
    do
    {
        Field* fields = result->Fetch();

        uint32 entry = fields[0].Get<uint32>();

        if (!sObjectMgr->GetCreatureTemplate(entry))
        {
            LOG_ERROR("sql.sql", "Creature template (Entry: {}) does not exist but has a record in `creature_template_addon`", entry);
            continue;
        }

        CreatureAddon& creatureAddon = _creatureTemplateAddonStore[entry];

        creatureAddon.path_id = fields[1].Get<uint32>();
        creatureAddon.mount   = fields[2].Get<uint32>();
        creatureAddon.bytes1  = fields[3].Get<uint32>();
        creatureAddon.bytes2  = fields[4].Get<uint32>();
        creatureAddon.emote   = fields[5].Get<uint32>();
        creatureAddon.visibilityDistanceType = VisibilityDistanceType(fields[6].Get<uint8>());

        for (std::string_view aura : Acore::Tokenize(fields[7].Get<std::string_view>(), ' ', false))
        {
            SpellInfo const* spellInfo = nullptr;

            if (Optional<uint32> spellId = Acore::StringTo<uint32>(aura))
            {
                spellInfo = sSpellMgr->GetSpellInfo(*spellId);
            }

            if (!spellInfo)
            {
                LOG_ERROR("sql.sql", "Creature (Entry: {}) has wrong spell '{}' defined in `auras` field in `creature_template_addon`.", entry, aura);
                continue;
            }

            if (std::find(creatureAddon.auras.begin(), creatureAddon.auras.end(), spellInfo->Id) != creatureAddon.auras.end())
            {
                LOG_ERROR("sql.sql", "Creature (Entry: {}) has duplicate aura (spell {}) in `auras` field in `creature_template_addon`.", entry, spellInfo->Id);
                continue;
            }

            if (spellInfo->GetDuration() > 0)
            {
                LOG_DEBUG/*ERROR*/("sql.sql", "Creature (Entry: {}) has temporary aura (spell {}) in `auras` field in `creature_template_addon`.", entry, spellInfo->Id);
                // continue;
            }

            creatureAddon.auras.push_back(spellInfo->Id);
        }

        if (creatureAddon.mount)
        {
            if (!sCreatureDisplayInfoStore.LookupEntry(creatureAddon.mount))
            {
                LOG_ERROR("sql.sql", "Creature (Entry: {}) has invalid displayInfoId ({}) for mount defined in `creature_template_addon`", entry, creatureAddon.mount);
                creatureAddon.mount = 0;
            }
        }

        if (!sEmotesStore.LookupEntry(creatureAddon.emote))
        {
            LOG_ERROR("sql.sql", "Creature (Entry: {}) has invalid emote ({}) defined in `creature_addon`.", entry, creatureAddon.emote);
            creatureAddon.emote = 0;
        }

        if (creatureAddon.visibilityDistanceType >= VisibilityDistanceType::Max)
        {
            LOG_ERROR("sql.sql", "Creature (Entry: {}) has invalid visibilityDistanceType ({}) defined in `creature_template_addon`.", entry, AsUnderlyingType(creatureAddon.visibilityDistanceType));
            creatureAddon.visibilityDistanceType = VisibilityDistanceType::Normal;
        }
        ++count;
    } while (result->NextRow());

    LOG_INFO("server.loading", ">> Loaded {} Creature Template Addons in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
}

/**
 * @brief Load config option Creatures.CustomIDs into Store
 */
void ObjectMgr::LoadCreatureCustomIDs()
{
    // Hack for modules
    std::string stringCreatureIds = sConfigMgr->GetOption<std::string>("Creatures.CustomIDs", "");
    std::vector<std::string_view> CustomCreatures = Acore::Tokenize(stringCreatureIds, ',', false);

    for (auto& itr : CustomCreatures)
    {
        _creatureCustomIDsStore.push_back(Acore::StringTo<uint32>(itr).value());
    }
}

void ObjectMgr::CheckCreatureTemplate(CreatureTemplate const* cInfo)
{
    if (!cInfo)
        return;

    bool ok = true;                                     // bool to allow continue outside this loop
    for (uint32 diff = 0; diff < MAX_DIFFICULTY - 1 && ok; ++diff)
    {
        if (!cInfo->DifficultyEntry[diff])
            continue;
        ok = false;                                     // will be set to true at the end of this loop again

        CreatureTemplate const* difficultyInfo = GetCreatureTemplate(cInfo->DifficultyEntry[diff]);
        if (!difficultyInfo)
        {
            LOG_ERROR("sql.sql", "Creature (Entry: {}) has `difficulty_entry_{}`={} but creature entry {} does not exist.",
                             cInfo->Entry, diff + 1, cInfo->DifficultyEntry[diff], cInfo->DifficultyEntry[diff]);
            continue;
        }

        bool ok2 = true;
        for (uint32 diff2 = 0; diff2 < MAX_DIFFICULTY - 1 && ok2; ++diff2)
        {
            ok2 = false;
            if (_difficultyEntries[diff2].find(cInfo->Entry) != _difficultyEntries[diff2].end())
            {
                LOG_ERROR("sql.sql", "Creature (Entry: {}) is listed as `difficulty_entry_{}` of another creature, but itself lists {} in `difficulty_entry_{}`.",
                                 cInfo->Entry, diff2 + 1, cInfo->DifficultyEntry[diff], diff + 1);
                continue;
            }

            if (_difficultyEntries[diff2].find(cInfo->DifficultyEntry[diff]) != _difficultyEntries[diff2].end())
            {
                LOG_ERROR("sql.sql", "Creature (Entry: {}) already listed as `difficulty_entry_{}` for another entry.", cInfo->DifficultyEntry[diff], diff2 + 1);
                continue;
            }

            if (_hasDifficultyEntries[diff2].find(cInfo->DifficultyEntry[diff]) != _hasDifficultyEntries[diff2].end())
            {
                LOG_ERROR("sql.sql", "Creature (Entry: {}) has `difficulty_entry_{}`={} but creature entry {} has itself a value in `difficulty_entry_{}`.",
                                 cInfo->Entry, diff + 1, cInfo->DifficultyEntry[diff], cInfo->DifficultyEntry[diff], diff2 + 1);
                continue;
            }
            ok2 = true;
        }
        if (!ok2)
            continue;

        if (cInfo->expansion > difficultyInfo->expansion)
        {
            LOG_ERROR("sql.sql", "Creature (Entry: {}, expansion {}) has different `expansion` in difficulty {} mode (Entry: {}, expansion {}).",
                             cInfo->Entry, cInfo->expansion, diff + 1, cInfo->DifficultyEntry[diff], difficultyInfo->expansion);
        }

        if (cInfo->faction != difficultyInfo->faction)
        {
            LOG_ERROR("sql.sql", "Creature (Entry: {}, faction {}) has different `faction` in difficulty {} mode (Entry: {}, faction {}).",
                             cInfo->Entry, cInfo->faction, diff + 1, cInfo->DifficultyEntry[diff], difficultyInfo->faction);
        }

        if (cInfo->unit_class != difficultyInfo->unit_class)
        {
            LOG_ERROR("sql.sql", "Creature (Entry: {}, class {}) has different `unit_class` in difficulty {} mode (Entry: {}, class {}).",
                             cInfo->Entry, cInfo->unit_class, diff + 1, cInfo->DifficultyEntry[diff], difficultyInfo->unit_class);
            continue;
        }

        if (cInfo->npcflag != difficultyInfo->npcflag)
        {
            LOG_ERROR("sql.sql", "Creature (Entry: {}) has different `npcflag` in difficulty {} mode (Entry: {}).", cInfo->Entry, diff + 1, cInfo->DifficultyEntry[diff]);
            continue;
        }

        if (cInfo->family != difficultyInfo->family)
        {
            LOG_ERROR("sql.sql", "Creature (Entry: {}, family {}) has different `family` in difficulty {} mode (Entry: {}, family {}).",
                             cInfo->Entry, cInfo->family, diff + 1, cInfo->DifficultyEntry[diff], difficultyInfo->family);
        }

        if (cInfo->trainer_class != difficultyInfo->trainer_class)
        {
            LOG_ERROR("sql.sql", "Creature (Entry: {}) has different `trainer_class` in difficulty {} mode (Entry: {}).", cInfo->Entry, diff + 1, cInfo->DifficultyEntry[diff]);
            continue;
        }

        if (cInfo->trainer_race != difficultyInfo->trainer_race)
        {
            LOG_ERROR("sql.sql", "Creature (Entry: {}) has different `trainer_race` in difficulty {} mode (Entry: {}).", cInfo->Entry, diff + 1, cInfo->DifficultyEntry[diff]);
            continue;
        }

        if (cInfo->trainer_type != difficultyInfo->trainer_type)
        {
            LOG_ERROR("sql.sql", "Creature (Entry: {}) has different `trainer_type` in difficulty {} mode (Entry: {}).", cInfo->Entry, diff + 1, cInfo->DifficultyEntry[diff]);
            continue;
        }

        if (cInfo->trainer_spell != difficultyInfo->trainer_spell)
        {
            LOG_ERROR("sql.sql", "Creature (Entry: {}) has different `trainer_spell` in difficulty {} mode (Entry: {}).", cInfo->Entry, diff + 1, cInfo->DifficultyEntry[diff]);
            continue;
        }

        if (cInfo->type != difficultyInfo->type)
        {
            LOG_ERROR("sql.sql", "Creature (Entry: {}, type {}) has different `type` in difficulty {} mode (Entry: {}, type {}).",
                             cInfo->Entry, cInfo->type, diff + 1, cInfo->DifficultyEntry[diff], difficultyInfo->type);
        }

        if (!cInfo->VehicleId && difficultyInfo->VehicleId)
        {
            LOG_ERROR("sql.sql", "Creature (Entry: {}, VehicleId {}) has different `VehicleId` in difficulty {} mode (Entry: {}, VehicleId {}).",
                             cInfo->Entry, cInfo->VehicleId, diff + 1, cInfo->DifficultyEntry[diff], difficultyInfo->VehicleId);
        }

        // Xinef: check dmg school
        if (cInfo->dmgschool != difficultyInfo->dmgschool)
        {
            LOG_ERROR("sql.sql", "Creature (Entry: {}) has different `dmgschool` in difficulty {} mode (Entry: {})", cInfo->Entry, diff + 1, cInfo->DifficultyEntry[diff]);
        }

        if (!difficultyInfo->AIName.empty())
        {
            LOG_ERROR("sql.sql", "Creature (Entry: {}) lists difficulty {} mode entry {} with `AIName` filled in. `AIName` of difficulty 0 mode creature is always used instead.",
                             cInfo->Entry, diff + 1, cInfo->DifficultyEntry[diff]);
            continue;
        }

        if (difficultyInfo->ScriptID)
        {
            LOG_ERROR("sql.sql", "Creature (Entry: {}) lists difficulty {} mode entry {} with `ScriptName` filled in. `ScriptName` of difficulty 0 mode creature is always used instead.",
                             cInfo->Entry, diff + 1, cInfo->DifficultyEntry[diff]);
            continue;
        }

        _hasDifficultyEntries[diff].insert(cInfo->Entry);
        _difficultyEntries[diff].insert(cInfo->DifficultyEntry[diff]);
        ok = true;
    }

    if (!cInfo->AIName.empty() && !sCreatureAIRegistry->HasItem(cInfo->AIName))
    {
        LOG_ERROR("sql.sql", "Creature (Entry: {}) has non-registered `AIName` '{}' set, removing", cInfo->Entry, cInfo->AIName);
        const_cast<CreatureTemplate*>(cInfo)->AIName.clear();
    }

    FactionTemplateEntry const* factionTemplate = sFactionTemplateStore.LookupEntry(cInfo->faction);
    if (!factionTemplate)
        LOG_ERROR("sql.sql", "Creature (Entry: {}) has non-existing faction template ({}).", cInfo->Entry, cInfo->faction);

    // used later for scale
    CreatureDisplayInfoEntry const* displayScaleEntry = nullptr;

    if (cInfo->Modelid1)
    {
        CreatureDisplayInfoEntry const* displayEntry = sCreatureDisplayInfoStore.LookupEntry(cInfo->Modelid1);
        if (!displayEntry)
        {
            LOG_ERROR("sql.sql", "Creature (Entry: {}) lists non-existing Modelid1 id ({}), this can crash the client.", cInfo->Entry, cInfo->Modelid1);
            const_cast<CreatureTemplate*>(cInfo)->Modelid1 = 0;
        }
        else if (!displayScaleEntry)
            displayScaleEntry = displayEntry;

        CreatureModelInfo const* modelInfo = GetCreatureModelInfo(cInfo->Modelid1);
        if (!modelInfo)
            LOG_ERROR("sql.sql", "No model data exist for `Modelid1` = {} listed by creature (Entry: {}).", cInfo->Modelid1, cInfo->Entry);
    }

    if (cInfo->Modelid2)
    {
        CreatureDisplayInfoEntry const* displayEntry = sCreatureDisplayInfoStore.LookupEntry(cInfo->Modelid2);
        if (!displayEntry)
        {
            LOG_ERROR("sql.sql", "Creature (Entry: {}) lists non-existing Modelid2 id ({}), this can crash the client.", cInfo->Entry, cInfo->Modelid2);
            const_cast<CreatureTemplate*>(cInfo)->Modelid2 = 0;
        }
        else if (!displayScaleEntry)
            displayScaleEntry = displayEntry;

        CreatureModelInfo const* modelInfo = GetCreatureModelInfo(cInfo->Modelid2);
        if (!modelInfo)
            LOG_ERROR("sql.sql", "No model data exist for `Modelid2` = {} listed by creature (Entry: {}).", cInfo->Modelid2, cInfo->Entry);
    }

    if (cInfo->Modelid3)
    {
        CreatureDisplayInfoEntry const* displayEntry = sCreatureDisplayInfoStore.LookupEntry(cInfo->Modelid3);
        if (!displayEntry)
        {
            LOG_ERROR("sql.sql", "Creature (Entry: {}) lists non-existing Modelid3 id ({}), this can crash the client.", cInfo->Entry, cInfo->Modelid3);
            const_cast<CreatureTemplate*>(cInfo)->Modelid3 = 0;
        }
        else if (!displayScaleEntry)
            displayScaleEntry = displayEntry;

        CreatureModelInfo const* modelInfo = GetCreatureModelInfo(cInfo->Modelid3);
        if (!modelInfo)
            LOG_ERROR("sql.sql", "No model data exist for `Modelid3` = {} listed by creature (Entry: {}).", cInfo->Modelid3, cInfo->Entry);
    }

    if (cInfo->Modelid4)
    {
        CreatureDisplayInfoEntry const* displayEntry = sCreatureDisplayInfoStore.LookupEntry(cInfo->Modelid4);
        if (!displayEntry)
        {
            LOG_ERROR("sql.sql", "Creature (Entry: {}) lists non-existing Modelid4 id ({}), this can crash the client.", cInfo->Entry, cInfo->Modelid4);
            const_cast<CreatureTemplate*>(cInfo)->Modelid4 = 0;
        }
        else if (!displayScaleEntry)
            displayScaleEntry = displayEntry;

        CreatureModelInfo const* modelInfo = GetCreatureModelInfo(cInfo->Modelid4);
        if (!modelInfo)
            LOG_ERROR("sql.sql", "No model data exist for `Modelid4` = {} listed by creature (Entry: {}).", cInfo->Modelid4, cInfo->Entry);
    }

    if (!displayScaleEntry)
        LOG_ERROR("sql.sql", "Creature (Entry: {}) does not have any existing display id in Modelid1/Modelid2/Modelid3/Modelid4.", cInfo->Entry);

    for (int k = 0; k < MAX_KILL_CREDIT; ++k)
    {
        if (cInfo->KillCredit[k])
        {
            if (!GetCreatureTemplate(cInfo->KillCredit[k]))
            {
                LOG_ERROR("sql.sql", "Creature (Entry: {}) lists non-existing creature entry {} in `KillCredit{}`.", cInfo->Entry, cInfo->KillCredit[k], k + 1);
                const_cast<CreatureTemplate*>(cInfo)->KillCredit[k] = 0;
            }
        }
    }

    if (!cInfo->unit_class || ((1 << (cInfo->unit_class - 1)) & CLASSMASK_ALL_CREATURES) == 0)
    {
        LOG_ERROR("sql.sql", "Creature (Entry: {}) has invalid unit_class ({}) in creature_template. Set to 1 (UNIT_CLASS_WARRIOR).", cInfo->Entry, cInfo->unit_class);
        const_cast<CreatureTemplate*>(cInfo)->unit_class = UNIT_CLASS_WARRIOR;
    }

    if (cInfo->dmgschool >= MAX_SPELL_SCHOOL)
    {
        LOG_ERROR("sql.sql", "Creature (Entry: {}) has invalid spell school value ({}) in `dmgschool`.", cInfo->Entry, cInfo->dmgschool);
        const_cast<CreatureTemplate*>(cInfo)->dmgschool = SPELL_SCHOOL_NORMAL;
    }

    if (cInfo->BaseAttackTime == 0)
        const_cast<CreatureTemplate*>(cInfo)->BaseAttackTime  = BASE_ATTACK_TIME;

    if (cInfo->RangeAttackTime == 0)
        const_cast<CreatureTemplate*>(cInfo)->RangeAttackTime = BASE_ATTACK_TIME;

    if ((cInfo->npcflag & UNIT_NPC_FLAG_TRAINER) && cInfo->trainer_type >= MAX_TRAINER_TYPE)
        LOG_ERROR("sql.sql", "Creature (Entry: {}) has wrong trainer type {}.", cInfo->Entry, cInfo->trainer_type);

    if (cInfo->speed_walk == 0.0f)
    {
        LOG_ERROR("sql.sql", "Creature (Entry: {}) has wrong value ({}) in speed_walk, set to 1.", cInfo->Entry, cInfo->speed_walk);
        const_cast<CreatureTemplate*>(cInfo)->speed_walk = 1.0f;
    }

    if (cInfo->speed_run == 0.0f)
    {
        LOG_ERROR("sql.sql", "Creature (Entry: {}) has wrong value ({}) in speed_run, set to 1.14286.", cInfo->Entry, cInfo->speed_run);
        const_cast<CreatureTemplate*>(cInfo)->speed_run = 1.14286f;
    }

    if (cInfo->type && !sCreatureTypeStore.LookupEntry(cInfo->type))
    {
        LOG_ERROR("sql.sql", "Creature (Entry: {}) has invalid creature type ({}) in `type`.", cInfo->Entry, cInfo->type);
        const_cast<CreatureTemplate*>(cInfo)->type = CREATURE_TYPE_HUMANOID;
    }

    // must exist or used hidden but used in data horse case
    if (cInfo->family && !sCreatureFamilyStore.LookupEntry(cInfo->family) && cInfo->family != CREATURE_FAMILY_HORSE_CUSTOM)
    {
        LOG_ERROR("sql.sql", "Creature (Entry: {}) has invalid creature family ({}) in `family`.", cInfo->Entry, cInfo->family);
        const_cast<CreatureTemplate*>(cInfo)->family = 0;
    }

    CheckCreatureMovement("creature_template_movement", cInfo->Entry, const_cast<CreatureTemplate*>(cInfo)->Movement);

    if (cInfo->HoverHeight < 0.0f)
    {
        LOG_ERROR("sql.sql", "Creature (Entry: {}) has wrong value ({}) in `HoverHeight`", cInfo->Entry, cInfo->HoverHeight);
        const_cast<CreatureTemplate*>(cInfo)->HoverHeight = 1.0f;
    }

    if (cInfo->VehicleId)
    {
        VehicleEntry const* vehId = sVehicleStore.LookupEntry(cInfo->VehicleId);
        if (!vehId)
        {
            LOG_ERROR("sql.sql", "Creature (Entry: {}) has a non-existing VehicleId ({}). This *WILL* cause the client to freeze!", cInfo->Entry, cInfo->VehicleId);
            const_cast<CreatureTemplate*>(cInfo)->VehicleId = 0;
        }
    }

    if (cInfo->PetSpellDataId)
    {
        CreatureSpellDataEntry const* spellDataId = sCreatureSpellDataStore.LookupEntry(cInfo->PetSpellDataId);
        if (!spellDataId)
            LOG_ERROR("sql.sql", "Creature (Entry: {}) has non-existing PetSpellDataId ({}).", cInfo->Entry, cInfo->PetSpellDataId);
    }

    for (uint8 j = 0; j < MAX_CREATURE_SPELLS; ++j)
    {
        if (cInfo->spells[j] && !sSpellMgr->GetSpellInfo(cInfo->spells[j]))
        {
            LOG_ERROR("sql.sql", "Creature (Entry: {}) has non-existing Spell{} ({}), set to 0.", cInfo->Entry, j + 1, cInfo->spells[j]);
            const_cast<CreatureTemplate*>(cInfo)->spells[j] = 0;
        }
    }

    if (cInfo->MovementType >= MAX_DB_MOTION_TYPE)
    {
        LOG_ERROR("sql.sql", "Creature (Entry: {}) has wrong movement generator type ({}), ignored and set to IDLE.", cInfo->Entry, cInfo->MovementType);
        const_cast<CreatureTemplate*>(cInfo)->MovementType = IDLE_MOTION_TYPE;
    }

    /// if not set custom creature scale then load scale from CreatureDisplayInfo.dbc
    if (cInfo->scale <= 0.0f)
    {
        if (displayScaleEntry)
            const_cast<CreatureTemplate*>(cInfo)->scale = displayScaleEntry->scale;
        else
            const_cast<CreatureTemplate*>(cInfo)->scale = 1.0f;
    }

    if (cInfo->expansion > (MAX_EXPANSIONS - 1))
    {
        LOG_ERROR("sql.sql", "Table `creature_template` lists creature (Entry: {}) with expansion {}. Ignored and set to 0.", cInfo->Entry, cInfo->expansion);
        const_cast<CreatureTemplate*>(cInfo)->expansion = 0;
    }

    if (uint32 badFlags = (cInfo->flags_extra & ~CREATURE_FLAG_EXTRA_DB_ALLOWED))
    {
        LOG_ERROR("sql.sql", "Table `creature_template` lists creature (Entry: {}) with disallowed `flags_extra` {}, removing incorrect flag.", cInfo->Entry, badFlags);
        const_cast<CreatureTemplate*>(cInfo)->flags_extra &= CREATURE_FLAG_EXTRA_DB_ALLOWED;
    }

    const_cast<CreatureTemplate*>(cInfo)->DamageModifier *= Creature::_GetDamageMod(cInfo->rank);

    // Hack for modules
    for (auto& itr : _creatureCustomIDsStore)
    {
        if (cInfo->Entry == itr)
            return;
    }

    if ((cInfo->GossipMenuId && !(cInfo->npcflag & UNIT_NPC_FLAG_GOSSIP)) && !(cInfo->flags_extra & CREATURE_FLAG_EXTRA_MODULE))
    {
        LOG_ERROR("sql.sql", "Creature (Entry: {}) has assigned gossip menu {}, but npcflag does not include UNIT_NPC_FLAG_GOSSIP (1).", cInfo->Entry, cInfo->GossipMenuId);
    }
    else if ((!cInfo->GossipMenuId && (cInfo->npcflag & UNIT_NPC_FLAG_GOSSIP)) && !(cInfo->flags_extra & CREATURE_FLAG_EXTRA_MODULE))
    {
        LOG_INFO("sql.sql", "Creature (Entry: {}) has npcflag UNIT_NPC_FLAG_GOSSIP (1), but gossip menu is unassigned.", cInfo->Entry);
    }
}

void ObjectMgr::CheckCreatureMovement(char const* table, uint64 id, CreatureMovementData& creatureMovement)
{
    if (creatureMovement.Ground >= CreatureGroundMovementType::Max)
    {
        LOG_ERROR("sql.sql", "`{}`.`Ground` wrong value ({}) for Id {}, setting to Run.", table, uint32(creatureMovement.Ground), id);
        creatureMovement.Ground = CreatureGroundMovementType::Run;
    }

    if (creatureMovement.Flight >= CreatureFlightMovementType::Max)
    {
        LOG_ERROR("sql.sql", "`{}`.`Flight` wrong value ({}) for Id {}, setting to None.", table, uint32(creatureMovement.Flight), id);
        creatureMovement.Flight = CreatureFlightMovementType::None;
    }

    if (creatureMovement.Chase >= CreatureChaseMovementType::Max)
    {
        LOG_ERROR("sql.sql", "`{}`.`Chase` wrong value ({}) for Id {}, setting to Run.", table, uint32(creatureMovement.Chase), id);
        creatureMovement.Chase = CreatureChaseMovementType::Run;
    }

    if (creatureMovement.Random >= CreatureRandomMovementType::Max)
    {
        LOG_ERROR("sql.sql", "`{}`.`Random` wrong value ({}) for Id {}, setting to Walk.", table, uint32(creatureMovement.Random), id);
        creatureMovement.Random = CreatureRandomMovementType::Walk;
    }
}

void ObjectMgr::LoadCreatureAddons()
{
    uint32 oldMSTime = getMSTime();

    //                                                0       1       2      3       4       5             6                7
    QueryResult result = WorldDatabase.Query("SELECT guid, path_id, mount, bytes1, bytes2, emote, visibilityDistanceType, auras FROM creature_addon");

    if (!result)
    {
        LOG_WARN("server.loading", ">> Loaded 0 creature addon definitions. DB table `creature_addon` is empty.");
        LOG_INFO("server.loading", " ");
        return;
    }

    uint32 count = 0;
    do
    {
        Field* fields = result->Fetch();

        ObjectGuid::LowType guid = fields[0].Get<uint32>();

        CreatureData const* creData = GetCreatureData(guid);
        if (!creData)
        {
            LOG_ERROR("sql.sql", "Creature (GUID: {}) does not exist but has a record in `creature_addon`", guid);
            continue;
        }

        CreatureAddon& creatureAddon = _creatureAddonStore[guid];

        creatureAddon.path_id = fields[1].Get<uint32>();
        if (creData->movementType == WAYPOINT_MOTION_TYPE && !creatureAddon.path_id)
        {
            const_cast<CreatureData*>(creData)->movementType = IDLE_MOTION_TYPE;
            LOG_ERROR("sql.sql", "Creature (GUID {}) has movement type set to WAYPOINT_MOTION_TYPE but no path assigned", guid);
        }

        creatureAddon.mount   = fields[2].Get<uint32>();
        creatureAddon.bytes1  = fields[3].Get<uint32>();
        creatureAddon.bytes2  = fields[4].Get<uint32>();
        creatureAddon.emote   = fields[5].Get<uint32>();
        creatureAddon.visibilityDistanceType = VisibilityDistanceType(fields[6].Get<uint8>());

        for (std::string_view aura : Acore::Tokenize(fields[7].Get<std::string_view>(), ' ', false))
        {
            SpellInfo const* spellInfo = nullptr;

            if (Optional<uint32> spellId = Acore::StringTo<uint32>(aura))
            {
                spellInfo = sSpellMgr->GetSpellInfo(*spellId);
            }

            if (!spellInfo)
            {
                LOG_ERROR("sql.sql", "Creature (GUID: {}) has wrong spell '{}' defined in `auras` field in `creature_addon`.", guid, aura);
                continue;
            }

            if (std::find(creatureAddon.auras.begin(), creatureAddon.auras.end(), spellInfo->Id) != creatureAddon.auras.end())
            {
                LOG_ERROR("sql.sql", "Creature (GUID: {}) has duplicate aura (spell {}) in `auras` field in `creature_addon`.", guid, spellInfo->Id);
                continue;
            }

            if (spellInfo->GetDuration() > 0)
            {
                LOG_DEBUG/*ERROR*/("sql.sql", "Creature (Entry: {}) has temporary aura (spell {}) in `auras` field in `creature_template_addon`.", guid, spellInfo->Id);
                // continue;
            }

            creatureAddon.auras.push_back(spellInfo->Id);
        }

        if (creatureAddon.mount)
        {
            if (!sCreatureDisplayInfoStore.LookupEntry(creatureAddon.mount))
            {
                LOG_ERROR("sql.sql", "Creature (GUID: {}) has invalid displayInfoId ({}) for mount defined in `creature_addon`", guid, creatureAddon.mount);
                creatureAddon.mount = 0;
            }
        }

        if (!sEmotesStore.LookupEntry(creatureAddon.emote))
        {
            LOG_ERROR("sql.sql", "Creature (GUID: {}) has invalid emote ({}) defined in `creature_addon`.", guid, creatureAddon.emote);
            creatureAddon.emote = 0;
        }

        if (creatureAddon.visibilityDistanceType >= VisibilityDistanceType::Max)
        {
            LOG_ERROR("sql.sql", "Creature (GUID: {}) has invalid visibilityDistanceType ({}) defined in `creature_addon`.", guid, AsUnderlyingType(creatureAddon.visibilityDistanceType));
            creatureAddon.visibilityDistanceType = VisibilityDistanceType::Normal;
        }

        ++count;
    } while (result->NextRow());

    LOG_INFO("server.loading", ">> Loaded {} Creature Addons in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
}

void ObjectMgr::LoadGameObjectAddons()
{
    uint32 oldMSTime = getMSTime();

    //                                               0     1                 2
    QueryResult result = WorldDatabase.Query("SELECT guid, invisibilityType, invisibilityValue FROM gameobject_addon");

    if (!result)
    {
        LOG_WARN("server.loading", ">> Loaded 0 gameobject addon definitions. DB table `gameobject_addon` is empty.");
        LOG_INFO("server.loading", " ");
        return;
    }

    uint32 count = 0;
    do
    {
        Field* fields = result->Fetch();

        ObjectGuid::LowType guid = fields[0].Get<uint32>();

        const GameObjectData* goData = GetGameObjectData(guid);
        if (!goData)
        {
            LOG_ERROR("sql.sql", "GameObject (GUID: {}) does not exist but has a record in `gameobject_addon`", guid);
            continue;
        }

        GameObjectAddon& gameObjectAddon = _gameObjectAddonStore[guid];
        gameObjectAddon.invisibilityType = InvisibilityType(fields[1].Get<uint8>());
        gameObjectAddon.InvisibilityValue = fields[2].Get<uint32>();

        if (gameObjectAddon.invisibilityType >= TOTAL_INVISIBILITY_TYPES)
        {
            LOG_ERROR("sql.sql", "GameObject (GUID: {}) has invalid InvisibilityType in `gameobject_addon`", guid);
            gameObjectAddon.invisibilityType = INVISIBILITY_GENERAL;
            gameObjectAddon.InvisibilityValue = 0;
        }

        if (gameObjectAddon.invisibilityType && !gameObjectAddon.InvisibilityValue)
        {
            LOG_ERROR("sql.sql", "GameObject (GUID: {}) has InvisibilityType set but has no InvisibilityValue in `gameobject_addon`, set to 1", guid);
            gameObjectAddon.InvisibilityValue = 1;
        }

        ++count;
    } while (result->NextRow());

    LOG_INFO("server.loading", ">> Loaded {} Gameobject Addons in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
}

GameObjectAddon const* ObjectMgr::GetGameObjectAddon(ObjectGuid::LowType lowguid)
{
    GameObjectAddonContainer::const_iterator itr = _gameObjectAddonStore.find(lowguid);
    if (itr != _gameObjectAddonStore.end())
        return &(itr->second);

    return nullptr;
}

CreatureAddon const* ObjectMgr::GetCreatureAddon(ObjectGuid::LowType lowguid)
{
    CreatureAddonContainer::const_iterator itr = _creatureAddonStore.find(lowguid);
    if (itr != _creatureAddonStore.end())
        return &(itr->second);

    return nullptr;
}

CreatureAddon const* ObjectMgr::GetCreatureTemplateAddon(uint32 entry)
{
    CreatureAddonContainer::const_iterator itr = _creatureTemplateAddonStore.find(entry);
    if (itr != _creatureTemplateAddonStore.end())
        return &(itr->second);

    return nullptr;
}

CreatureMovementData const* ObjectMgr::GetCreatureMovementOverride(ObjectGuid::LowType spawnId) const
{
    return Acore::Containers::MapGetValuePtr(_creatureMovementOverrides, spawnId);
}

EquipmentInfo const* ObjectMgr::GetEquipmentInfo(uint32 entry, int8& id)
{
    EquipmentInfoContainer::const_iterator itr = _equipmentInfoStore.find(entry);
    if (itr == _equipmentInfoStore.end())
        return nullptr;

    if (itr->second.empty())
        return nullptr;

    if (id == -1) // select a random element
    {
        EquipmentInfoContainerInternal::const_iterator ritr = itr->second.begin();
        std::advance(ritr, urand(0u, itr->second.size() - 1));
        id = std::distance(itr->second.begin(), ritr) + 1;
        return &ritr->second;
    }
    else
    {
        EquipmentInfoContainerInternal::const_iterator itr2 = itr->second.find(id);
        if (itr2 != itr->second.end())
            return &itr2->second;
    }

    return nullptr;
}

void ObjectMgr::LoadEquipmentTemplates()
{
    uint32 oldMSTime = getMSTime();

    //                                                 0         1       2       3       4
    QueryResult result = WorldDatabase.Query("SELECT CreatureID, ID, ItemID1, ItemID2, ItemID3 FROM creature_equip_template");

    if (!result)
    {
        LOG_WARN("server.loading", ">> Loaded 0 creature equipment templates. DB table `creature_equip_template` is empty!");
        LOG_INFO("server.loading", " ");
        return;
    }

    uint32 count = 0;
    do
    {
        Field* fields = result->Fetch();

        uint32 entry = fields[0].Get<uint32>();

        if (!sObjectMgr->GetCreatureTemplate(entry))
        {
            LOG_ERROR("sql.sql", "Creature template (CreatureID: {}) does not exist but has a record in `creature_equip_template`", entry);
            continue;
        }

        uint8 id = fields[1].Get<uint8>();
        if (!id)
        {
            LOG_ERROR("sql.sql", "Creature equipment template with id 0 found for creature {}, skipped.", entry);
            continue;
        }

        EquipmentInfo& equipmentInfo = _equipmentInfoStore[entry][id];

        equipmentInfo.ItemEntry[0] = fields[2].Get<uint32>();
        equipmentInfo.ItemEntry[1] = fields[3].Get<uint32>();
        equipmentInfo.ItemEntry[2] = fields[4].Get<uint32>();

        for (uint8 i = 0; i < MAX_EQUIPMENT_ITEMS; ++i)
        {
            if (!equipmentInfo.ItemEntry[i])
                continue;

            ItemEntry const* dbcItem = sItemStore.LookupEntry(equipmentInfo.ItemEntry[i]);

            if (!dbcItem)
            {
                LOG_ERROR("sql.sql", "Unknown item (ID={}) in creature_equip_template.ItemID{} for CreatureID = {} and ID = {}, forced to 0.",
                                 equipmentInfo.ItemEntry[i], i + 1, entry, id);
                equipmentInfo.ItemEntry[i] = 0;
                continue;
            }

            if (dbcItem->InventoryType != INVTYPE_WEAPON &&
                dbcItem->InventoryType != INVTYPE_SHIELD &&
                dbcItem->InventoryType != INVTYPE_RANGED &&
                dbcItem->InventoryType != INVTYPE_2HWEAPON &&
                dbcItem->InventoryType != INVTYPE_WEAPONMAINHAND &&
                dbcItem->InventoryType != INVTYPE_WEAPONOFFHAND &&
                dbcItem->InventoryType != INVTYPE_HOLDABLE &&
                dbcItem->InventoryType != INVTYPE_THROWN &&
                dbcItem->InventoryType != INVTYPE_RANGEDRIGHT)
            {
                LOG_ERROR("sql.sql", "Item (ID={}) in creature_equip_template.ItemID{} for CreatureID = {} and ID = {} is not equipable in a hand, forced to 0.",
                                 equipmentInfo.ItemEntry[i], i + 1, entry, id);
                equipmentInfo.ItemEntry[i] = 0;
            }
        }

        ++count;
    } while (result->NextRow());

    LOG_INFO("server.loading", ">> Loaded {} Equipment Templates in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
}

void ObjectMgr::LoadCreatureMovementOverrides()
{
    uint32 oldMSTime = getMSTime();

    _creatureMovementOverrides.clear();

    // Load the data from creature_movement_override and if NULL fallback to creature_template_movement
    QueryResult result = WorldDatabase.Query("SELECT cmo.SpawnId,"
                                             "COALESCE(cmo.Ground, ctm.Ground),"
                                             "COALESCE(cmo.Swim, ctm.Swim),"
                                             "COALESCE(cmo.Flight, ctm.Flight),"
                                             "COALESCE(cmo.Rooted, ctm.Rooted),"
                                             "COALESCE(cmo.Chase, ctm.Chase),"
                                             "COALESCE(cmo.Random, ctm.Random),"
                                             "COALESCE(cmo.InteractionPauseTimer, ctm.InteractionPauseTimer) "
                                             "FROM creature_movement_override AS cmo "
                                             "LEFT JOIN creature AS c ON c.guid = cmo.SpawnId "
                                             "LEFT JOIN creature_template_movement AS ctm ON ctm.CreatureId = c.id1");
    if (!result)
    {
        LOG_WARN("server.loading", ">> Loaded 0 creature movement overrides. DB table `creature_movement_override` is empty!");
        return;
    }

    do
    {
        Field*              fields  = result->Fetch();
        ObjectGuid::LowType spawnId = fields[0].Get<uint32>();
        if (!GetCreatureData(spawnId))
        {
            LOG_ERROR("sql.sql", "Creature (GUID: {}) does not exist but has a record in `creature_movement_override`", spawnId);
            continue;
        }

        CreatureMovementData& movement = _creatureMovementOverrides[spawnId];
        if (!fields[1].IsNull())
        {
            movement.Ground = static_cast<CreatureGroundMovementType>(fields[1].Get<uint8>());
        }

        if (!fields[2].IsNull())
        {
            movement.Swim = fields[2].Get<bool>();
        }

        if (!fields[3].IsNull())
        {
            movement.Flight = static_cast<CreatureFlightMovementType>(fields[3].Get<uint8>());
        }

        if (!fields[4].IsNull())
        {
            movement.Rooted = fields[4].Get<bool>();
        }

        if (!fields[5].IsNull())
        {
            movement.Chase = static_cast<CreatureChaseMovementType>(fields[5].Get<uint8>());
        }

        if (!fields[6].IsNull())
        {
            movement.Random = static_cast<CreatureRandomMovementType>(fields[6].Get<uint8>());
        }

        if (!fields[7].IsNull())
        {
            movement.InteractionPauseTimer = fields[7].Get<uint32>();
        }

        CheckCreatureMovement("creature_movement_override", spawnId, movement);
    } while (result->NextRow());

    LOG_INFO("server.loading", ">> Loaded {} Movement Overrides in {} ms", _creatureMovementOverrides.size(), GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
}

CreatureModelInfo const* ObjectMgr::GetCreatureModelInfo(uint32 modelId) const
{
    CreatureModelContainer::const_iterator itr = _creatureModelStore.find(modelId);
    if (itr != _creatureModelStore.end())
        return &(itr->second);

    return nullptr;
}

uint32 ObjectMgr::ChooseDisplayId(CreatureTemplate const* cinfo, CreatureData const* data /*= nullptr*/)
{
    // Load creature model (display id)
    if (data && data->displayid)
        return data->displayid;

    return cinfo->GetRandomValidModelId();
}

void ObjectMgr::ChooseCreatureFlags(const CreatureTemplate* cinfo, uint32& npcflag, uint32& unit_flags, uint32& dynamicflags, const CreatureData* data /*= nullptr*/)
{
    npcflag = cinfo->npcflag;
    unit_flags = cinfo->unit_flags;
    dynamicflags = cinfo->dynamicflags;

    if (data)
    {
        if (data->npcflag)
            npcflag = data->npcflag;

        if (data->unit_flags)
            unit_flags = data->unit_flags;

        if (data->dynamicflags)
            dynamicflags = data->dynamicflags;
    }
}

CreatureModelInfo const* ObjectMgr::GetCreatureModelRandomGender(uint32* displayID)
{
    CreatureModelInfo const* modelInfo = GetCreatureModelInfo(*displayID);
    if (!modelInfo)
        return nullptr;

    // If a model for another gender exists, 50% chance to use it
    if (modelInfo->modelid_other_gender != 0 && urand(0, 1) == 0)
    {
        CreatureModelInfo const* minfo_tmp = GetCreatureModelInfo(modelInfo->modelid_other_gender);
        if (!minfo_tmp)
            LOG_ERROR("sql.sql", "Model (Entry: {}) has modelid_other_gender {} not found in table `creature_model_info`. ", *displayID, modelInfo->modelid_other_gender);
        else
        {
            // Model ID changed
            *displayID = modelInfo->modelid_other_gender;
            return minfo_tmp;
        }
    }

    return modelInfo;
}

void ObjectMgr::LoadCreatureModelInfo()
{
    uint32 oldMSTime = getMSTime();

    //                                                   0             1             2          3               4
    QueryResult result = WorldDatabase.Query("SELECT DisplayID, BoundingRadius, CombatReach, Gender, DisplayID_Other_Gender FROM creature_model_info");

    if (!result)
    {
        LOG_WARN("server.loading", ">> Loaded 0 creature model definitions. DB table `creature_model_info` is empty.");
        LOG_INFO("server.loading", " ");
        return;
    }

    _creatureModelStore.rehash(result->GetRowCount());
    uint32 count = 0;

    do
    {
        Field* fields = result->Fetch();

        uint32 modelId = fields[0].Get<uint32>();

        CreatureModelInfo& modelInfo = _creatureModelStore[modelId];

        modelInfo.bounding_radius      = fields[1].Get<float>();
        modelInfo.combat_reach         = fields[2].Get<float>();
        modelInfo.gender               = fields[3].Get<uint8>();
        modelInfo.modelid_other_gender = fields[4].Get<uint32>();

        // Checks

        if (!sCreatureDisplayInfoStore.LookupEntry(modelId))
            LOG_ERROR("sql.sql", "Table `creature_model_info` has model for not existed display id ({}).", modelId);

        if (modelInfo.gender > GENDER_NONE)
        {
            LOG_ERROR("sql.sql", "Table `creature_model_info` has wrong gender ({}) for display id ({}).", uint32(modelInfo.gender), modelId);
            modelInfo.gender = GENDER_MALE;
        }

        if (modelInfo.modelid_other_gender && !sCreatureDisplayInfoStore.LookupEntry(modelInfo.modelid_other_gender))
        {
            LOG_ERROR("sql.sql", "Table `creature_model_info` has not existed alt.gender model ({}) for existed display id ({}).", modelInfo.modelid_other_gender, modelId);
            modelInfo.modelid_other_gender = 0;
        }

        if (modelInfo.combat_reach < 0.1f)
            modelInfo.combat_reach = DEFAULT_COMBAT_REACH;

        ++count;
    } while (result->NextRow());

    LOG_INFO("server.loading", ">> Loaded {} Creature Model Based Info in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
}

void ObjectMgr::LoadLinkedRespawn()
{
    uint32 oldMSTime = getMSTime();

    _linkedRespawnStore.clear();
    //                                                 0        1          2
    QueryResult result = WorldDatabase.Query("SELECT guid, linkedGuid, linkType FROM linked_respawn ORDER BY guid ASC");

    if (!result)
    {
        LOG_WARN("server.loading", ">> Loaded 0 linked respawns. DB table `linked_respawn` is empty.");
        LOG_INFO("server.loading", " ");
        return;
    }

    do
    {
        Field* fields = result->Fetch();

        ObjectGuid::LowType guidLow = fields[0].Get<uint32>();
        ObjectGuid::LowType linkedGuidLow = fields[1].Get<uint32>();
        uint8  linkType = fields[2].Get<uint8>();

        ObjectGuid guid, linkedGuid;
        bool error = false;
        switch (linkType)
        {
            case CREATURE_TO_CREATURE:
                {
                    const CreatureData* slave = GetCreatureData(guidLow);
                    if (!slave)
                    {
                        LOG_ERROR("sql.sql", "LinkedRespawn: Creature (guid) {} not found in creature table", guidLow);
                        error = true;
                        break;
                    }

                    const CreatureData* master = GetCreatureData(linkedGuidLow);
                    if (!master)
                    {
                        LOG_ERROR("sql.sql", "LinkedRespawn: Creature (linkedGuid) {} not found in creature table", linkedGuidLow);
                        error = true;
                        break;
                    }

                    MapEntry const* const map = sMapStore.LookupEntry(master->mapid);
                    if (!map || !map->Instanceable() || (master->mapid != slave->mapid))
                    {
                        LOG_ERROR("sql.sql", "LinkedRespawn: Creature '{}' linking to Creature '{}' on an unpermitted map.", guidLow, linkedGuidLow);
                        error = true;
                        break;
                    }

                    if (!(master->spawnMask & slave->spawnMask))  // they must have a possibility to meet (normal/heroic difficulty)
                    {
                        LOG_ERROR("sql.sql", "LinkedRespawn: Creature '{}' linking to Creature '{}' with not corresponding spawnMask", guidLow, linkedGuidLow);
                        error = true;
                        break;
                    }

                    guid = ObjectGuid::Create<HighGuid::Unit>(slave->id1, guidLow);
                    linkedGuid = ObjectGuid::Create<HighGuid::Unit>(master->id1, linkedGuidLow);
                    break;
                }
            case CREATURE_TO_GO:
                {
                    const CreatureData* slave = GetCreatureData(guidLow);
                    if (!slave)
                    {
                        LOG_ERROR("sql.sql", "LinkedRespawn: Creature (guid) {} not found in creature table", guidLow);
                        error = true;
                        break;
                    }

                    const GameObjectData* master = GetGameObjectData(linkedGuidLow);
                    if (!master)
                    {
                        LOG_ERROR("sql.sql", "LinkedRespawn: Gameobject (linkedGuid) {} not found in gameobject table", linkedGuidLow);
                        error = true;
                        break;
                    }

                    MapEntry const* const map = sMapStore.LookupEntry(master->mapid);
                    if (!map || !map->Instanceable() || (master->mapid != slave->mapid))
                    {
                        LOG_ERROR("sql.sql", "LinkedRespawn: Creature '{}' linking to Gameobject '{}' on an unpermitted map.", guidLow, linkedGuidLow);
                        error = true;
                        break;
                    }

                    if (!(master->spawnMask & slave->spawnMask))  // they must have a possibility to meet (normal/heroic difficulty)
                    {
                        LOG_ERROR("sql.sql", "LinkedRespawn: Creature '{}' linking to Gameobject '{}' with not corresponding spawnMask", guidLow, linkedGuidLow);
                        error = true;
                        break;
                    }

                    guid = ObjectGuid::Create<HighGuid::Unit>(slave->id1, guidLow);
                    linkedGuid = ObjectGuid::Create<HighGuid::GameObject>(master->id, linkedGuidLow);
                    break;
                }
            case GO_TO_GO:
                {
                    const GameObjectData* slave = GetGameObjectData(guidLow);
                    if (!slave)
                    {
                        LOG_ERROR("sql.sql", "LinkedRespawn: Gameobject (guid) {} not found in gameobject table", guidLow);
                        error = true;
                        break;
                    }

                    const GameObjectData* master = GetGameObjectData(linkedGuidLow);
                    if (!master)
                    {
                        LOG_ERROR("sql.sql", "LinkedRespawn: Gameobject (linkedGuid) {} not found in gameobject table", linkedGuidLow);
                        error = true;
                        break;
                    }

                    MapEntry const* const map = sMapStore.LookupEntry(master->mapid);
                    if (!map || !map->Instanceable() || (master->mapid != slave->mapid))
                    {
                        LOG_ERROR("sql.sql", "LinkedRespawn: Gameobject '{}' linking to Gameobject '{}' on an unpermitted map.", guidLow, linkedGuidLow);
                        error = true;
                        break;
                    }

                    if (!(master->spawnMask & slave->spawnMask))  // they must have a possibility to meet (normal/heroic difficulty)
                    {
                        LOG_ERROR("sql.sql", "LinkedRespawn: Gameobject '{}' linking to Gameobject '{}' with not corresponding spawnMask", guidLow, linkedGuidLow);
                        error = true;
                        break;
                    }

                    guid = ObjectGuid::Create<HighGuid::GameObject>(slave->id, guidLow);
                    linkedGuid = ObjectGuid::Create<HighGuid::GameObject>(master->id, linkedGuidLow);
                    break;
                }
            case GO_TO_CREATURE:
                {
                    const GameObjectData* slave = GetGameObjectData(guidLow);
                    if (!slave)
                    {
                        LOG_ERROR("sql.sql", "LinkedRespawn: Gameobject (guid) {} not found in gameobject table", guidLow);
                        error = true;
                        break;
                    }

                    const CreatureData* master = GetCreatureData(linkedGuidLow);
                    if (!master)
                    {
                        LOG_ERROR("sql.sql", "LinkedRespawn: Creature (linkedGuid) {} not found in creature table", linkedGuidLow);
                        error = true;
                        break;
                    }

                    MapEntry const* const map = sMapStore.LookupEntry(master->mapid);
                    if (!map || !map->Instanceable() || (master->mapid != slave->mapid))
                    {
                        LOG_ERROR("sql.sql", "LinkedRespawn: Gameobject '{}' linking to Creature '{}' on an unpermitted map.", guidLow, linkedGuidLow);
                        error = true;
                        break;
                    }

                    if (!(master->spawnMask & slave->spawnMask))  // they must have a possibility to meet (normal/heroic difficulty)
                    {
                        LOG_ERROR("sql.sql", "LinkedRespawn: Gameobject '{}' linking to Creature '{}' with not corresponding spawnMask", guidLow, linkedGuidLow);
                        error = true;
                        break;
                    }

                    guid = ObjectGuid::Create<HighGuid::GameObject>(slave->id, guidLow);
                    linkedGuid = ObjectGuid::Create<HighGuid::Unit>(master->id1, linkedGuidLow);
                    break;
                }
        }

        if (!error)
            _linkedRespawnStore[guid] = linkedGuid;
    } while (result->NextRow());

    LOG_INFO("server.loading", ">> Loaded {} Linked Respawns In {} ms", uint64(_linkedRespawnStore.size()), GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
}

bool ObjectMgr::SetCreatureLinkedRespawn(ObjectGuid::LowType guidLow, ObjectGuid::LowType linkedGuidLow)
{
    if (!guidLow)
        return false;

    CreatureData const* master = GetCreatureData(guidLow);
    ObjectGuid guid = ObjectGuid::Create<HighGuid::Unit>(master->id1, guidLow);

    if (!linkedGuidLow) // we're removing the linking
    {
        _linkedRespawnStore.erase(guid);
        WorldDatabasePreparedStatement* stmt = WorldDatabase.GetPreparedStatement(WORLD_DEL_CRELINKED_RESPAWN);
        stmt->SetData(0, guidLow);
        WorldDatabase.Execute(stmt);
        return true;
    }

    CreatureData const* slave = GetCreatureData(linkedGuidLow);
    if (!slave)
    {
        LOG_ERROR("sql.sql", "Creature '{}' linking to non-existent creature '{}'.", guidLow, linkedGuidLow);
        return false;
    }

    MapEntry const* map = sMapStore.LookupEntry(master->mapid);
    if (!map || !map->Instanceable() || (master->mapid != slave->mapid))
    {
        LOG_ERROR("sql.sql", "Creature '{}' linking to '{}' on an unpermitted map.", guidLow, linkedGuidLow);
        return false;
    }

    if (!(master->spawnMask & slave->spawnMask))  // they must have a possibility to meet (normal/heroic difficulty)
    {
        LOG_ERROR("sql.sql", "LinkedRespawn: Creature '{}' linking to '{}' with not corresponding spawnMask", guidLow, linkedGuidLow);
        return false;
    }

    ObjectGuid linkedGuid = ObjectGuid::Create<HighGuid::Unit>(slave->id1, linkedGuidLow);

    _linkedRespawnStore[guid] = linkedGuid;
    WorldDatabasePreparedStatement* stmt = WorldDatabase.GetPreparedStatement(WORLD_REP_CREATURE_LINKED_RESPAWN);
    stmt->SetData(0, guidLow);
    stmt->SetData(1, linkedGuidLow);
    WorldDatabase.Execute(stmt);
    return true;
}

void ObjectMgr::LoadTempSummons()
{
    uint32 oldMSTime = getMSTime();

    //                                                    0           1             2        3      4           5           6           7            8           9
    QueryResult result = WorldDatabase.Query("SELECT summonerId, summonerType, groupId, entry, position_x, position_y, position_z, orientation, summonType, summonTime FROM creature_summon_groups");

    if (!result)
    {
        LOG_WARN("server.loading", ">> Loaded 0 temp summons. DB table `creature_summon_groups` is empty.");
        return;
    }

    uint32 count = 0;
    do
    {
        Field* fields = result->Fetch();

        uint32 summonerId               = fields[0].Get<uint32>();
        SummonerType summonerType       = SummonerType(fields[1].Get<uint8>());
        uint8 group                     = fields[2].Get<uint8>();

        switch (summonerType)
        {
            case SUMMONER_TYPE_CREATURE:
                if (!GetCreatureTemplate(summonerId))
                {
                    LOG_ERROR("sql.sql", "Table `creature_summon_groups` has summoner with non existing entry {} for creature summoner type, skipped.", summonerId);
                    continue;
                }
                break;
            case SUMMONER_TYPE_GAMEOBJECT:
                if (!GetGameObjectTemplate(summonerId))
                {
                    LOG_ERROR("sql.sql", "Table `creature_summon_groups` has summoner with non existing entry {} for gameobject summoner type, skipped.", summonerId);
                    continue;
                }
                break;
            case SUMMONER_TYPE_MAP:
                if (!sMapStore.LookupEntry(summonerId))
                {
                    LOG_ERROR("sql.sql", "Table `creature_summon_groups` has summoner with non existing entry {} for map summoner type, skipped.", summonerId);
                    continue;
                }
                break;
            default:
                LOG_ERROR("sql.sql", "Table `creature_summon_groups` has unhandled summoner type {} for summoner {}, skipped.", summonerType, summonerId);
                continue;
        }

        TempSummonData data;
        data.entry                      = fields[3].Get<uint32>();

        if (!GetCreatureTemplate(data.entry))
        {
            LOG_ERROR("sql.sql", "Table `creature_summon_groups` has creature in group [Summoner ID: {}, Summoner Type: {}, Group ID: {}] with non existing creature entry {}, skipped.", summonerId, summonerType, group, data.entry);
            continue;
        }

        float posX                      = fields[4].Get<float>();
        float posY                      = fields[5].Get<float>();
        float posZ                      = fields[6].Get<float>();
        float orientation               = fields[7].Get<float>();

        data.pos.Relocate(posX, posY, posZ, orientation);

        data.type                       = TempSummonType(fields[8].Get<uint8>());

        if (data.type > TEMPSUMMON_MANUAL_DESPAWN)
        {
            LOG_ERROR("sql.sql", "Table `creature_summon_groups` has unhandled temp summon type {} in group [Summoner ID: {}, Summoner Type: {}, Group ID: {}] for creature entry {}, skipped.", data.type, summonerId, summonerType, group, data.entry);
            continue;
        }

        data.time                       = fields[9].Get<uint32>();

        TempSummonGroupKey key(summonerId, summonerType, group);
        _tempSummonDataStore[key].push_back(data);

        ++count;
    } while (result->NextRow());

    LOG_INFO("server.loading", ">> Loaded {} Temporary Summons in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
}

void ObjectMgr::LoadCreatures()
{
    uint32 oldMSTime = getMSTime();

    //                                                     0         1    2    3    4        5            6           7           8            9              10            11
    QueryResult result = WorldDatabase.Query("SELECT creature.guid, id1, id2, id3, map, equipment_id, position_x, position_y, position_z, orientation, spawntimesecs, wander_distance, "
                         //      12            13       14          15           16         17         18          19             20                 21                    22
                         "currentwaypoint, curhealth, curmana, MovementType, spawnMask, phaseMask, eventEntry, pool_entry, creature.npcflag, creature.unit_flags, creature.dynamicflags, "
                         //       23
                         "creature.ScriptName "
                         "FROM creature "
                         "LEFT OUTER JOIN game_event_creature ON creature.guid = game_event_creature.guid "
                         "LEFT OUTER JOIN pool_creature ON creature.guid = pool_creature.guid");

    if (!result)
    {
        LOG_WARN("server.loading", ">> Loaded 0 creatures. DB table `creature` is empty.");
        LOG_INFO("server.loading", " ");
        return;
    }

    // Build single time for check spawnmask
    std::map<uint32, uint32> spawnMasks;
    for (uint32 i = 0; i < sMapStore.GetNumRows(); ++i)
        if (sMapStore.LookupEntry(i))
            for (int k = 0; k < MAX_DIFFICULTY; ++k)
                if (GetMapDifficultyData(i, Difficulty(k)))
                    spawnMasks[i] |= (1 << k);

    _creatureDataStore.rehash(result->GetRowCount());
    uint32 count = 0;
    do
    {
        Field* fields = result->Fetch();

        ObjectGuid::LowType spawnId     = fields[0].Get<uint32>();
        uint32 id1                      = fields[1].Get<uint32>();
        uint32 id2                      = fields[2].Get<uint32>();
        uint32 id3                      = fields[3].Get<uint32>();

        CreatureTemplate const* cInfo = GetCreatureTemplate(id1);
        if (!cInfo)
        {
            LOG_ERROR("sql.sql", "Table `creature` has creature (SpawnId: {}) with non existing creature entry {} in id1 field, skipped.", spawnId, id1);
            continue;
        }
        CreatureTemplate const* cInfo2 = GetCreatureTemplate(id2);
        if (!cInfo2 && id2)
        {
            LOG_ERROR("sql.sql", "Table `creature` has creature (SpawnId: {}) with non existing creature entry {} in id2 field, skipped.", spawnId, id2);
            continue;
        }
        CreatureTemplate const* cInfo3 = GetCreatureTemplate(id3);
        if (!cInfo3 && id3)
        {
            LOG_ERROR("sql.sql", "Table `creature` has creature (SpawnId: {}) with non existing creature entry {} in id3 field, skipped.", spawnId, id3);
            continue;
        }
        if (!id2 && id3)
        {
            LOG_ERROR("sql.sql", "Table `creature` has creature (SpawnId: {}) with creature entry {} in id3 field but no entry in id2 field, skipped.", spawnId, id3);
            continue;
        }
        CreatureData& data      = _creatureDataStore[spawnId];
        data.id1                = id1;
        data.id2                = id2;
        data.id3                = id3;
        data.mapid              = fields[4].Get<uint16>();
        data.equipmentId        = fields[5].Get<int8>();
        data.posX               = fields[6].Get<float>();
        data.posY               = fields[7].Get<float>();
        data.posZ               = fields[8].Get<float>();
        data.orientation        = fields[9].Get<float>();
        data.spawntimesecs      = fields[10].Get<uint32>();
        data.wander_distance    = fields[11].Get<float>();
        data.currentwaypoint    = fields[12].Get<uint32>();
        data.curhealth          = fields[13].Get<uint32>();
        data.curmana            = fields[14].Get<uint32>();
        data.movementType       = fields[15].Get<uint8>();
        data.spawnMask          = fields[16].Get<uint8>();
        data.phaseMask          = fields[17].Get<uint32>();
        int16 gameEvent         = fields[18].Get<int8>();
        uint32 PoolId           = fields[19].Get<uint32>();
        data.npcflag            = fields[20].Get<uint32>();
        data.unit_flags         = fields[21].Get<uint32>();
        data.dynamicflags       = fields[22].Get<uint32>();
        data.ScriptId           = GetScriptId(fields[23].Get<std::string>());

        if (!data.ScriptId)
            data.ScriptId = cInfo->ScriptID;

        MapEntry const* mapEntry = sMapStore.LookupEntry(data.mapid);
        if (!mapEntry)
        {
            LOG_ERROR("sql.sql", "Table `creature` have creature (SpawnId: {}) that spawned at not existed map (Id: {}), skipped.", spawnId, data.mapid);
            continue;
        }

        // pussywizard: 7 days means no reaspawn, so set it to 14 days, because manual id reset may be late
        if (mapEntry->IsRaid() && data.spawntimesecs >= 7 * DAY && data.spawntimesecs < 14 * DAY)
            data.spawntimesecs = 14 * DAY;

        // Skip spawnMask check for transport maps
        if (!_transportMaps.count(data.mapid) && data.spawnMask & ~spawnMasks[data.mapid])
            LOG_ERROR("sql.sql", "Table `creature` have creature (SpawnId: {}) that have wrong spawn mask {} including not supported difficulty modes for map (Id: {}).",
                spawnId, data.spawnMask, data.mapid);

        bool ok = true;
        for (uint32 diff = 0; diff < MAX_DIFFICULTY - 1 && ok; ++diff)
        {
            if ((_difficultyEntries[diff].find(data.id1) != _difficultyEntries[diff].end()) || (_difficultyEntries[diff].find(data.id2) != _difficultyEntries[diff].end()) || (_difficultyEntries[diff].find(data.id3) != _difficultyEntries[diff].end()))
            {
                LOG_ERROR("sql.sql", "Table `creature` have creature (SpawnId: {}) that listed as difficulty {} template (Entries: {}, {}, {}) in `creature_template`, skipped.",
                                 spawnId, diff + 1, data.id1, data.id2, data.id3);
                ok = false;
            }
        }
        if (!ok)
            continue;

        // -1 random, 0 no equipment,
        if (data.equipmentId != 0)
        {
            if ((!GetEquipmentInfo(data.id1, data.equipmentId)) || (data.id2 && !GetEquipmentInfo(data.id2, data.equipmentId))  || (data.id3 && !GetEquipmentInfo(data.id3, data.equipmentId)))
            {
                LOG_ERROR("sql.sql", "Table `creature` have creature (Entries: {}, {}, {}) one or more with equipment_id {} not found in table `creature_equip_template`, set to no equipment.",
                    data.id1, data.id2, data.id3, data.equipmentId);
                data.equipmentId = 0;
            }
        }
        if ((cInfo->flags_extra & CREATURE_FLAG_EXTRA_INSTANCE_BIND) || (data.id2 && cInfo2->flags_extra & CREATURE_FLAG_EXTRA_INSTANCE_BIND) || (data.id3 && cInfo3->flags_extra & CREATURE_FLAG_EXTRA_INSTANCE_BIND))
        {
            if (!mapEntry->IsDungeon())
                LOG_ERROR("sql.sql", "Table `creature` have creature (SpawnId: {} Entries: {}, {}, {}) with a `creature_template`.`flags_extra` in one or more entries including CREATURE_FLAG_EXTRA_INSTANCE_BIND but creature are not in instance.",
                    spawnId, data.id1, data.id2, data.id3);
        }
        if (data.movementType >= MAX_DB_MOTION_TYPE)
        {
            LOG_ERROR("sql.sql", "Table `creature` has creature (SpawnId: {} Entries: {}, {}, {}) with wrong movement generator type ({}), ignored and set to IDLE.", spawnId, data.id1, data.id2, data.id3, data.movementType);
            data.movementType = IDLE_MOTION_TYPE;
        }
        if (data.wander_distance < 0.0f)
        {
            LOG_ERROR("sql.sql", "Table `creature` have creature (SpawnId: {} Entries: {}, {}, {}) with `wander_distance`< 0, set to 0.", spawnId, data.id1, data.id2, data.id3);
            data.wander_distance = 0.0f;
        }
        else if (data.movementType == RANDOM_MOTION_TYPE)
        {
            if (data.wander_distance == 0.0f)
            {
                LOG_ERROR("sql.sql", "Table `creature` have creature (SpawnId: {} Entries: {}, {}, {}) with `MovementType`=1 (random movement) but with `wander_distance`=0, replace by idle movement type (0).",
                    spawnId, data.id1, data.id2, data.id3);
                data.movementType = IDLE_MOTION_TYPE;
            }
        }
        else if (data.movementType == IDLE_MOTION_TYPE)
        {
            if (data.wander_distance != 0.0f)
            {
                LOG_ERROR("sql.sql", "Table `creature` have creature (SpawnId: {} Entries: {}, {}, {}) with `MovementType`=0 (idle) have `wander_distance`<>0, set to 0.", spawnId, data.id1, data.id2, data.id3);
                data.wander_distance = 0.0f;
            }
        }

        if (data.phaseMask == 0)
        {
            LOG_ERROR("sql.sql", "Table `creature` have creature (SpawnId: {} Entries: {}, {}, {}) with `phaseMask`=0 (not visible for anyone), set to 1.", spawnId, data.id1, data.id2, data.id3);
            data.phaseMask = 1;
        }

        if (sWorld->getBoolConfig(CONFIG_CALCULATE_CREATURE_ZONE_AREA_DATA))
        {
            uint32 zoneId = sMapMgr->GetZoneId(data.phaseMask, data.mapid, data.posX, data.posY, data.posZ);
            uint32 areaId = sMapMgr->GetAreaId(data.phaseMask, data.mapid, data.posX, data.posY, data.posZ);

            WorldDatabasePreparedStatement* stmt = WorldDatabase.GetPreparedStatement(WORLD_UPD_CREATURE_ZONE_AREA_DATA);

            stmt->SetData(0, zoneId);
            stmt->SetData(1, areaId);
            stmt->SetData(2, spawnId);

            WorldDatabase.Execute(stmt);
        }

        // Add to grid if not managed by the game event or pool system
        if (gameEvent == 0 && PoolId == 0)
            AddCreatureToGrid(spawnId, &data);

        ++count;
    } while (result->NextRow());

    LOG_INFO("server.loading", ">> Loaded {} Creatures in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
}

void ObjectMgr::AddCreatureToGrid(ObjectGuid::LowType guid, CreatureData const* data)
{
    uint8 mask = data->spawnMask;
    for (uint8 i = 0; mask != 0; i++, mask >>= 1)
    {
        if (mask & 1)
        {
            CellCoord cellCoord = Acore::ComputeCellCoord(data->posX, data->posY);
            CellObjectGuids& cell_guids = _mapObjectGuidsStore[MAKE_PAIR32(data->mapid, i)][cellCoord.GetId()];
            cell_guids.creatures.insert(guid);
        }
    }
}

void ObjectMgr::RemoveCreatureFromGrid(ObjectGuid::LowType guid, CreatureData const* data)
{
    uint8 mask = data->spawnMask;
    for (uint8 i = 0; mask != 0; i++, mask >>= 1)
    {
        if (mask & 1)
        {
            CellCoord cellCoord = Acore::ComputeCellCoord(data->posX, data->posY);
            CellObjectGuids& cell_guids = _mapObjectGuidsStore[MAKE_PAIR32(data->mapid, i)][cellCoord.GetId()];
            cell_guids.creatures.erase(guid);
        }
    }
}

uint32 ObjectMgr::AddGOData(uint32 entry, uint32 mapId, float x, float y, float z, float o, uint32 spawntimedelay, float rotation0, float rotation1, float rotation2, float rotation3)
{
    GameObjectTemplate const* goinfo = GetGameObjectTemplate(entry);
    if (!goinfo)
        return 0;

    Map* map = sMapMgr->CreateBaseMap(mapId);
    if (!map)
        return 0;

    ObjectGuid::LowType spawnId = GenerateGameObjectSpawnId();

    GameObjectData& data = NewGOData(spawnId);
    data.id             = entry;
    data.mapid          = mapId;
    data.posX           = x;
    data.posY           = y;
    data.posZ           = z;
    data.orientation    = o;
    data.rotation.x     = rotation0;
    data.rotation.y     = rotation1;
    data.rotation.z     = rotation2;
    data.rotation.w     = rotation3;
    data.spawntimesecs  = spawntimedelay;
    data.animprogress   = 100;
    data.spawnMask      = 1;
    data.go_state       = GO_STATE_READY;
    data.phaseMask      = PHASEMASK_NORMAL;
    data.artKit         = goinfo->type == GAMEOBJECT_TYPE_CAPTURE_POINT ? 21 : 0;
    data.dbData = false;

    AddGameobjectToGrid(spawnId, &data);

    // Spawn if necessary (loaded grids only)
    // We use spawn coords to spawn
    if (!map->Instanceable() && map->IsGridLoaded(x, y))
    {
        GameObject* go = sObjectMgr->IsGameObjectStaticTransport(data.id) ? new StaticTransport() : new GameObject();
        if (!go->LoadGameObjectFromDB(spawnId, map))
        {
            LOG_ERROR("sql.sql", "AddGOData: cannot add gameobject entry {} to map", entry);
            delete go;
            return 0;
        }
    }

    LOG_DEBUG("maps", "AddGOData: spawnId {} entry {} map {} x {} y {} z {} o {}", spawnId, entry, mapId, x, y, z, o);

    return spawnId;
}

uint32 ObjectMgr::AddCreData(uint32 entry, uint32 mapId, float x, float y, float z, float o, uint32 spawntimedelay)
{
    CreatureTemplate const* cInfo = GetCreatureTemplate(entry);
    if (!cInfo)
        return 0;

    uint32 level = cInfo->minlevel == cInfo->maxlevel ? cInfo->minlevel : urand(cInfo->minlevel, cInfo->maxlevel); // Only used for extracting creature base stats
    CreatureBaseStats const* stats = GetCreatureBaseStats(level, cInfo->unit_class);
    Map* map = sMapMgr->CreateBaseMap(mapId);
    if (!map)
        return 0;

    ObjectGuid::LowType spawnId = GenerateCreatureSpawnId();
    CreatureData& data = NewOrExistCreatureData(spawnId);
    data.spawnMask = spawnId;
    data.id1 = entry;
    data.id2 = 0;
    data.id3 = 0;
    data.mapid = mapId;
    data.displayid = 0;
    data.equipmentId = 0;
    data.posX = x;
    data.posY = y;
    data.posZ = z;
    data.orientation = o;
    data.spawntimesecs = spawntimedelay;
    data.wander_distance = 0;
    data.currentwaypoint = 0;
    data.curhealth = stats->GenerateHealth(cInfo);
    data.curmana = stats->GenerateMana(cInfo);
    data.movementType = cInfo->MovementType;
    data.spawnMask = 1;
    data.phaseMask = PHASEMASK_NORMAL;
    data.dbData = false;
    data.npcflag = cInfo->npcflag;
    data.unit_flags = cInfo->unit_flags;
    data.dynamicflags = cInfo->dynamicflags;

    AddCreatureToGrid(spawnId, &data);

    // Spawn if necessary (loaded grids only)
    if (!map->Instanceable() && !map->IsRemovalGrid(x, y))
    {
        Creature* creature = new Creature();
        if (!creature->LoadCreatureFromDB(spawnId, map, true, false, true))
        {
            LOG_ERROR("sql.sql", "AddCreature: Cannot add creature entry {} to map", entry);
            delete creature;
            return 0;
        }
    }

    return spawnId;
}

void ObjectMgr::LoadGameobjects()
{
    uint32 oldMSTime = getMSTime();

    uint32 count = 0;

    //                                                0                1   2    3           4           5           6
    QueryResult result = WorldDatabase.Query("SELECT gameobject.guid, id, map, position_x, position_y, position_z, orientation, "
                         //   7          8          9          10         11             12            13     14         15         16          17
                         "rotation0, rotation1, rotation2, rotation3, spawntimesecs, animprogress, state, spawnMask, phaseMask, eventEntry, pool_entry, "
                         //   18
                         "ScriptName "
                         "FROM gameobject LEFT OUTER JOIN game_event_gameobject ON gameobject.guid = game_event_gameobject.guid "
                         "LEFT OUTER JOIN pool_gameobject ON gameobject.guid = pool_gameobject.guid");

    if (!result)
    {
        LOG_WARN("server.loading", ">> Loaded 0 gameobjects. DB table `gameobject` is empty.");
        LOG_INFO("server.loading", " ");
        return;
    }

    // build single time for check spawnmask
    std::map<uint32, uint32> spawnMasks;
    for (uint32 i = 0; i < sMapStore.GetNumRows(); ++i)
        if (sMapStore.LookupEntry(i))
            for (int k = 0; k < MAX_DIFFICULTY; ++k)
                if (GetMapDifficultyData(i, Difficulty(k)))
                    spawnMasks[i] |= (1 << k);

    _gameObjectDataStore.rehash(result->GetRowCount());
    do
    {
        Field* fields = result->Fetch();

        ObjectGuid::LowType guid    = fields[0].Get<uint32>();
        uint32 entry                = fields[1].Get<uint32>();

        GameObjectTemplate const* gInfo = GetGameObjectTemplate(entry);
        if (!gInfo)
        {
            LOG_ERROR("sql.sql", "Table `gameobject` has gameobject (GUID: {}) with non existing gameobject entry {}, skipped.", guid, entry);
            continue;
        }

        if (!gInfo->displayId)
        {
            switch (gInfo->type)
            {
                case GAMEOBJECT_TYPE_TRAP:
                case GAMEOBJECT_TYPE_SPELL_FOCUS:
                    break;
                default:
                    LOG_ERROR("sql.sql", "Gameobject (GUID: {} Entry {} GoType: {}) doesn't have a displayId ({}), not loaded.", guid, entry, gInfo->type, gInfo->displayId);
                    break;
            }
        }

        if (gInfo->displayId && !sGameObjectDisplayInfoStore.LookupEntry(gInfo->displayId))
        {
            LOG_ERROR("sql.sql", "Gameobject (GUID: {} Entry {} GoType: {}) has an invalid displayId ({}), not loaded.", guid, entry, gInfo->type, gInfo->displayId);
            continue;
        }

        GameObjectData& data = _gameObjectDataStore[guid];

        data.id             = entry;
        data.mapid          = fields[2].Get<uint16>();
        data.posX           = fields[3].Get<float>();
        data.posY           = fields[4].Get<float>();
        data.posZ           = fields[5].Get<float>();
        data.orientation    = fields[6].Get<float>();
        data.rotation.x     = fields[7].Get<float>();
        data.rotation.y     = fields[8].Get<float>();
        data.rotation.z     = fields[9].Get<float>();
        data.rotation.w     = fields[10].Get<float>();
        data.spawntimesecs  = fields[11].Get<int32>();
        data.ScriptId       = GetScriptId(fields[18].Get<std::string>());
        if (!data.ScriptId)
            data.ScriptId = gInfo->ScriptId;

        MapEntry const* mapEntry = sMapStore.LookupEntry(data.mapid);
        if (!mapEntry)
        {
            LOG_ERROR("sql.sql", "Table `gameobject` has gameobject (GUID: {} Entry: {}) spawned on a non-existed map (Id: {}), skip", guid, data.id, data.mapid);
            continue;
        }

        if (data.spawntimesecs == 0 && gInfo->IsDespawnAtAction())
        {
            LOG_ERROR("sql.sql", "Table `gameobject` has gameobject (GUID: {} Entry: {}) with `spawntimesecs` (0) value, but the gameobejct is marked as despawnable at action.", guid, data.id);
        }

        data.animprogress   = fields[12].Get<uint8>();
        data.artKit         = 0;

        uint32 go_state     = fields[13].Get<uint8>();
        if (go_state >= MAX_GO_STATE)
        {
            LOG_ERROR("sql.sql", "Table `gameobject` has gameobject (GUID: {} Entry: {}) with invalid `state` ({}) value, skip", guid, data.id, go_state);
            continue;
        }
        data.go_state       = GOState(go_state);

        data.spawnMask      = fields[14].Get<uint8>();

        if (!_transportMaps.count(data.mapid) && data.spawnMask & ~spawnMasks[data.mapid])
            LOG_ERROR("sql.sql", "Table `gameobject` has gameobject (GUID: {} Entry: {}) that has wrong spawn mask {} including not supported difficulty modes for map (Id: {}), skip", guid, data.id, data.spawnMask, data.mapid);

        data.phaseMask      = fields[15].Get<uint32>();
        int16 gameEvent     = fields[16].Get<int8>();
        uint32 PoolId        = fields[17].Get<uint32>();

        if (data.rotation.x < -1.0f || data.rotation.x > 1.0f)
        {
            LOG_ERROR("sql.sql", "Table `gameobject` has gameobject (GUID: {} Entry: {}) with invalid rotationX ({}) value, skip", guid, data.id, data.rotation.x);
            continue;
        }

        if (data.rotation.y < -1.0f || data.rotation.y > 1.0f)
        {
            LOG_ERROR("sql.sql", "Table `gameobject` has gameobject (GUID: {} Entry: {}) with invalid rotationY ({}) value, skip", guid, data.id, data.rotation.y);
            continue;
        }

        if (data.rotation.z < -1.0f || data.rotation.z > 1.0f)
        {
            LOG_ERROR("sql.sql", "Table `gameobject` has gameobject (GUID: {} Entry: {}) with invalid rotationZ ({}) value, skip", guid, data.id, data.rotation.z);
            continue;
        }

        if (data.rotation.w < -1.0f || data.rotation.w > 1.0f)
        {
            LOG_ERROR("sql.sql", "Table `gameobject` has gameobject (GUID: {} Entry: {}) with invalid rotationW ({}) value, skip", guid, data.id, data.rotation.w);
            continue;
        }

        if (!MapMgr::IsValidMapCoord(data.mapid, data.posX, data.posY, data.posZ, data.orientation))
        {
            LOG_ERROR("sql.sql", "Table `gameobject` has gameobject (GUID: {} Entry: {}) with invalid coordinates, skip", guid, data.id);
            continue;
        }

        if (data.phaseMask == 0)
        {
            LOG_ERROR("sql.sql", "Table `gameobject` has gameobject (GUID: {} Entry: {}) with `phaseMask`=0 (not visible for anyone), set to 1.", guid, data.id);
            data.phaseMask = 1;
        }

        if (sWorld->getBoolConfig(CONFIG_CALCULATE_GAMEOBJECT_ZONE_AREA_DATA))
        {
            uint32 zoneId = sMapMgr->GetZoneId(data.phaseMask, data.mapid, data.posX, data.posY, data.posZ);
            uint32 areaId = sMapMgr->GetAreaId(data.phaseMask, data.mapid, data.posX, data.posY, data.posZ);

            WorldDatabasePreparedStatement* stmt = WorldDatabase.GetPreparedStatement(WORLD_UPD_GAMEOBJECT_ZONE_AREA_DATA);

            stmt->SetData(0, zoneId);
            stmt->SetData(1, areaId);
            stmt->SetData(2, guid);

            WorldDatabase.Execute(stmt);
        }

        if (gameEvent == 0 && PoolId == 0)                      // if not this is to be managed by GameEvent System or Pool system
            AddGameobjectToGrid(guid, &data);
        ++count;
    } while (result->NextRow());

    LOG_INFO("server.loading", ">> Loaded {} Gameobjects in {} ms", (unsigned long)_gameObjectDataStore.size(), GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
}

void ObjectMgr::AddGameobjectToGrid(ObjectGuid::LowType guid, GameObjectData const* data)
{
    uint8 mask = data->spawnMask;
    for (uint8 i = 0; mask != 0; i++, mask >>= 1)
    {
        if (mask & 1)
        {
            CellCoord cellCoord = Acore::ComputeCellCoord(data->posX, data->posY);
            CellObjectGuids& cell_guids = _mapObjectGuidsStore[MAKE_PAIR32(data->mapid, i)][cellCoord.GetId()];
            cell_guids.gameobjects.insert(guid);
        }
    }
}

void ObjectMgr::RemoveGameobjectFromGrid(ObjectGuid::LowType guid, GameObjectData const* data)
{
    uint8 mask = data->spawnMask;
    for (uint8 i = 0; mask != 0; i++, mask >>= 1)
    {
        if (mask & 1)
        {
            CellCoord cellCoord = Acore::ComputeCellCoord(data->posX, data->posY);
            CellObjectGuids& cell_guids = _mapObjectGuidsStore[MAKE_PAIR32(data->mapid, i)][cellCoord.GetId()];
            cell_guids.gameobjects.erase(guid);
        }
    }
}

void ObjectMgr::LoadItemLocales()
{
    uint32 oldMSTime = getMSTime();

    _itemLocaleStore.clear();                                 // need for reload case

    QueryResult result = WorldDatabase.Query("SELECT ID, locale, Name, Description FROM item_template_locale");
    if (!result)
        return;

    do
    {
        Field* fields = result->Fetch();

        uint32 ID = fields[0].Get<uint32>();

        LocaleConstant locale = GetLocaleByName(fields[1].Get<std::string>());
        if (locale == LOCALE_enUS)
            continue;

        ItemLocale& data = _itemLocaleStore[ID];
        AddLocaleString(fields[2].Get<std::string>(), locale, data.Name);
        AddLocaleString(fields[3].Get<std::string>(), locale, data.Description);
    } while (result->NextRow());

    LOG_INFO("server.loading", ">> Loaded {} Item Locale Strings in {} ms", (uint32)_itemLocaleStore.size(), GetMSTimeDiffToNow(oldMSTime));
}

void ObjectMgr::LoadItemTemplates()
{
    uint32 oldMSTime = getMSTime();

    //                                                 0      1       2               3              4        5        6       7          8         9        10        11           12
    QueryResult result = WorldDatabase.Query("SELECT entry, class, subclass, SoundOverrideSubclass, name, displayid, Quality, Flags, FlagsExtra, BuyCount, BuyPrice, SellPrice, InventoryType, "
                         //                                              13              14           15          16             17               18                19              20
                         "AllowableClass, AllowableRace, ItemLevel, RequiredLevel, RequiredSkill, RequiredSkillRank, requiredspell, requiredhonorrank, "
                         //                                              21                      22                       23               24        25          26             27           28
                         "RequiredCityRank, RequiredReputationFaction, RequiredReputationRank, maxcount, stackable, ContainerSlots, StatsCount, stat_type1, "
                         //                                            29           30          31           32          33           34          35           36          37           38
                         "stat_value1, stat_type2, stat_value2, stat_type3, stat_value3, stat_type4, stat_value4, stat_type5, stat_value5, stat_type6, "
                         //                                            39           40          41           42           43          44           45           46           47
                         "stat_value6, stat_type7, stat_value7, stat_type8, stat_value8, stat_type9, stat_value9, stat_type10, stat_value10, "
                         //                                                   48                    49           50        51        52         53        54         55      56      57        58
                         "ScalingStatDistribution, ScalingStatValue, dmg_min1, dmg_max1, dmg_type1, dmg_min2, dmg_max2, dmg_type2, armor, holy_res, fire_res, "
                         //                                            59          60         61          62       63       64            65            66          67               68
                         "nature_res, frost_res, shadow_res, arcane_res, delay, ammo_type, RangedModRange, spellid_1, spelltrigger_1, spellcharges_1, "
                         //                                              69              70                71                 72                 73           74               75
                         "spellppmRate_1, spellcooldown_1, spellcategory_1, spellcategorycooldown_1, spellid_2, spelltrigger_2, spellcharges_2, "
                         //                                              76               77              78                  79                 80           81               82
                         "spellppmRate_2, spellcooldown_2, spellcategory_2, spellcategorycooldown_2, spellid_3, spelltrigger_3, spellcharges_3, "
                         //                                              83               84              85                  86                 87           88               89
                         "spellppmRate_3, spellcooldown_3, spellcategory_3, spellcategorycooldown_3, spellid_4, spelltrigger_4, spellcharges_4, "
                         //                                              90               91              92                  93                  94          95               96
                         "spellppmRate_4, spellcooldown_4, spellcategory_4, spellcategorycooldown_4, spellid_5, spelltrigger_5, spellcharges_5, "
                         //                                              97               98              99                  100                 101        102         103       104          105
                         "spellppmRate_5, spellcooldown_5, spellcategory_5, spellcategorycooldown_5, bonding, description, PageText, LanguageID, PageMaterial, "
                         //                                            106       107     108      109          110            111       112     113         114       115   116     117
                         "startquest, lockid, Material, sheath, RandomProperty, RandomSuffix, block, itemset, MaxDurability, area, Map, BagFamily, "
                         //                                            118             119             120             121             122            123              124            125
                         "TotemCategory, socketColor_1, socketContent_1, socketColor_2, socketContent_2, socketColor_3, socketContent_3, socketBonus, "
                         //                                            126                 127                     128            129            130            131         132         133
                         "GemProperties, RequiredDisenchantSkill, ArmorDamageModifier, duration, ItemLimitCategory, HolidayId, ScriptName, DisenchantID, "
                         //                                           134        135            136
                         "FoodType, minMoneyLoot, maxMoneyLoot, flagsCustom FROM item_template");

    if (!result)
    {
        LOG_WARN("server.loading", ">> Loaded 0 item templates. DB table `item_template` is empty.");
        LOG_INFO("server.loading", " ");
        return;
    }

    _itemTemplateStore.reserve(result->GetRowCount());
    uint32 count = 0;
    // original inspiration https://github.com/TrinityCore/TrinityCore/commit/0c44bd33ee7b42c924859139a9f4b04cf2b91261
    bool enforceDBCAttributes = sWorld->getBoolConfig(CONFIG_DBC_ENFORCE_ITEM_ATTRIBUTES);

    do
    {
        Field* fields = result->Fetch();

        uint32 entry = fields[0].Get<uint32>();

        ItemTemplate& itemTemplate = _itemTemplateStore[entry];

        itemTemplate.ItemId                    = entry;
        itemTemplate.Class                     = uint32(fields[1].Get<uint8>());
        itemTemplate.SubClass                  = uint32(fields[2].Get<uint8>());
        itemTemplate.SoundOverrideSubclass     = int32(fields[3].Get<int8>());
        itemTemplate.Name1                     = fields[4].Get<std::string>();
        itemTemplate.DisplayInfoID             = fields[5].Get<uint32>();
        itemTemplate.Quality                   = uint32(fields[6].Get<uint8>());
        itemTemplate.Flags                     = fields[7].Get<uint32>();
        itemTemplate.Flags2                    = fields[8].Get<uint32>();
        itemTemplate.BuyCount                  = uint32(fields[9].Get<uint8>());
        itemTemplate.BuyPrice                  = int32(fields[10].Get<int64>() * sWorld->getRate((Rates)(RATE_BUYVALUE_ITEM_POOR + itemTemplate.Quality)));
        itemTemplate.SellPrice                 = uint32(fields[11].Get<uint32>() * sWorld->getRate((Rates)(RATE_SELLVALUE_ITEM_POOR + itemTemplate.Quality)));
        itemTemplate.InventoryType             = uint32(fields[12].Get<uint8>());
        itemTemplate.AllowableClass            = fields[13].Get<int32>();
        itemTemplate.AllowableRace             = fields[14].Get<int32>();
        itemTemplate.ItemLevel                 = uint32(fields[15].Get<uint16>());
        itemTemplate.RequiredLevel             = uint32(fields[16].Get<uint8>());
        itemTemplate.RequiredSkill             = uint32(fields[17].Get<uint16>());
        itemTemplate.RequiredSkillRank         = uint32(fields[18].Get<uint16>());
        itemTemplate.RequiredSpell             = fields[19].Get<uint32>();
        itemTemplate.RequiredHonorRank         = fields[20].Get<uint32>();
        itemTemplate.RequiredCityRank          = fields[21].Get<uint32>();
        itemTemplate.RequiredReputationFaction = uint32(fields[22].Get<uint16>());
        itemTemplate.RequiredReputationRank    = uint32(fields[23].Get<uint16>());
        itemTemplate.MaxCount                  = fields[24].Get<int32>();
        itemTemplate.Stackable                 = fields[25].Get<int32>();
        itemTemplate.ContainerSlots            = uint32(fields[26].Get<uint8>());
        itemTemplate.StatsCount                = uint32(fields[27].Get<uint8>());

        for (uint8 i = 0; i < itemTemplate.StatsCount; ++i)
        {
            itemTemplate.ItemStat[i].ItemStatType  = uint32(fields[28 + i * 2].Get<uint8>());
            itemTemplate.ItemStat[i].ItemStatValue = fields[29 + i * 2].Get<int32>();
        }

        itemTemplate.ScalingStatDistribution = uint32(fields[48].Get<uint16>());
        itemTemplate.ScalingStatValue        = fields[49].Get<int32>();

        for (uint8 i = 0; i < MAX_ITEM_PROTO_DAMAGES; ++i)
        {
            itemTemplate.Damage[i].DamageMin  = fields[50 + i * 3].Get<float>();
            itemTemplate.Damage[i].DamageMax  = fields[51 + i * 3].Get<float>();
            itemTemplate.Damage[i].DamageType = uint32(fields[52 + i * 3].Get<uint8>());
        }

        itemTemplate.Armor          = fields[56].Get<uint32>();
        itemTemplate.HolyRes        = fields[57].Get<int32>();
        itemTemplate.FireRes        = fields[58].Get<int32>();
        itemTemplate.NatureRes      = fields[59].Get<int32>();
        itemTemplate.FrostRes       = fields[60].Get<int32>();
        itemTemplate.ShadowRes      = fields[61].Get<int32>();
        itemTemplate.ArcaneRes      = fields[62].Get<int32>();
        itemTemplate.Delay          = uint32(fields[63].Get<uint16>());
        itemTemplate.AmmoType       = uint32(fields[64].Get<uint8>());
        itemTemplate.RangedModRange = fields[65].Get<float>();

        for (uint8 i = 0; i < MAX_ITEM_PROTO_SPELLS; ++i)
        {
            itemTemplate.Spells[i].SpellId               = fields[66 + i * 7  ].Get<int32>();
            itemTemplate.Spells[i].SpellTrigger          = uint32(fields[67 + i * 7].Get<uint8>());
            itemTemplate.Spells[i].SpellCharges          = int32(fields[68 + i * 7].Get<int16>());
            itemTemplate.Spells[i].SpellPPMRate          = fields[69 + i * 7].Get<float>();
            itemTemplate.Spells[i].SpellCooldown         = fields[70 + i * 7].Get<int32>();
            itemTemplate.Spells[i].SpellCategory         = uint32(fields[71 + i * 7].Get<uint16>());
            itemTemplate.Spells[i].SpellCategoryCooldown = fields[72 + i * 7].Get<int32>();
        }

        itemTemplate.Bonding        = uint32(fields[101].Get<uint8>());
        itemTemplate.Description    = fields[102].Get<std::string>();
        itemTemplate.PageText       = fields[103].Get<uint32>();
        itemTemplate.LanguageID     = uint32(fields[104].Get<uint8>());
        itemTemplate.PageMaterial   = uint32(fields[105].Get<uint8>());
        itemTemplate.StartQuest     = fields[106].Get<uint32>();
        itemTemplate.LockID         = fields[107].Get<uint32>();
        itemTemplate.Material       = int32(fields[108].Get<int8>());
        itemTemplate.Sheath         = uint32(fields[109].Get<uint8>());
        itemTemplate.RandomProperty = fields[110].Get<int32>();
        itemTemplate.RandomSuffix   = fields[111].Get<int32>();
        itemTemplate.Block          = fields[112].Get<uint32>();
        itemTemplate.ItemSet        = fields[113].Get<uint32>();
        itemTemplate.MaxDurability  = uint32(fields[114].Get<uint16>());
        itemTemplate.Area           = fields[115].Get<uint32>();
        itemTemplate.Map            = uint32(fields[116].Get<uint16>());
        itemTemplate.BagFamily      = fields[117].Get<uint32>();
        itemTemplate.TotemCategory  = fields[118].Get<uint32>();

        for (uint8 i = 0; i < MAX_ITEM_PROTO_SOCKETS; ++i)
        {
            itemTemplate.Socket[i].Color   = uint32(fields[119 + i * 2].Get<uint8>());
            itemTemplate.Socket[i].Content = fields[120 + i * 2].Get<uint32>();
        }

        itemTemplate.socketBonus             = fields[125].Get<uint32>();
        itemTemplate.GemProperties           = fields[126].Get<uint32>();
        itemTemplate.RequiredDisenchantSkill = uint32(fields[127].Get<int16>());
        itemTemplate.ArmorDamageModifier     = fields[128].Get<float>();
        itemTemplate.Duration                = fields[129].Get<uint32>();
        itemTemplate.ItemLimitCategory       = uint32(fields[130].Get<int16>());
        itemTemplate.HolidayId               = fields[131].Get<uint32>();
        itemTemplate.ScriptId                = sObjectMgr->GetScriptId(fields[132].Get<std::string>());
        itemTemplate.DisenchantID            = fields[133].Get<uint32>();
        itemTemplate.FoodType                = uint32(fields[134].Get<uint8>());
        itemTemplate.MinMoneyLoot            = fields[135].Get<uint32>();
        itemTemplate.MaxMoneyLoot            = fields[136].Get<uint32>();
        itemTemplate.FlagsCu                 = fields[137].Get<uint32>();

        // Checks
        ItemEntry const* dbcitem = sItemStore.LookupEntry(entry);

        if (dbcitem)
        {
            if (enforceDBCAttributes)
            {
                if (itemTemplate.Class != dbcitem->ClassID)
                {
                    LOG_ERROR("sql.sql", "Item (Entry: {}) has wrong Class value ({}), must be ({}).", entry, itemTemplate.Class, dbcitem->ClassID);
                    itemTemplate.Class = dbcitem->ClassID;
                }
                if (itemTemplate.SubClass != dbcitem->SubclassID)
                {
                    LOG_ERROR("sql.sql", "Item (Entry: {}) has wrong Subclass value ({}) for class {}, must be ({}).", entry, itemTemplate.SubClass, itemTemplate.Class, dbcitem->SubclassID);
                    itemTemplate.SubClass = dbcitem->SubclassID;
                }
                if (itemTemplate.SoundOverrideSubclass != dbcitem->SoundOverrideSubclassID)
                {
                    LOG_ERROR("sql.sql", "Item (Entry: {}) does not have a correct SoundOverrideSubclass ({}), must be {}.", entry, itemTemplate.SoundOverrideSubclass, dbcitem->SoundOverrideSubclassID);
                    itemTemplate.SoundOverrideSubclass = dbcitem->SoundOverrideSubclassID;
                }
                if (itemTemplate.Material != dbcitem->Material)
                {
                    LOG_ERROR("sql.sql", "Item (Entry: {}) does not have a correct material ({}), must be {}.", entry, itemTemplate.Material, dbcitem->Material);
                    itemTemplate.Material = dbcitem->Material;
                }
                if (itemTemplate.InventoryType != dbcitem->InventoryType)
                {
                    LOG_ERROR("sql.sql", "Item (Entry: {}) has wrong InventoryType value ({}), must be {}.", entry, itemTemplate.InventoryType, dbcitem->InventoryType);
                    itemTemplate.InventoryType = dbcitem->InventoryType;
                }
                if (itemTemplate.DisplayInfoID != dbcitem->DisplayInfoID)
                {
                    LOG_ERROR("sql.sql", "Item (Entry: {}) does not have a correct display id ({}), must be {}.", entry, itemTemplate.DisplayInfoID, dbcitem->DisplayInfoID);
                    itemTemplate.DisplayInfoID = dbcitem->DisplayInfoID;
                }
                if (itemTemplate.Sheath != dbcitem->SheatheType)
                {
                    LOG_ERROR("sql.sql", "Item (Entry: {}) has wrong Sheath ({}), must be {}.", entry, itemTemplate.Sheath, dbcitem->SheatheType);
                    itemTemplate.Sheath = dbcitem->SheatheType;
                }
            }
        }
        else
            LOG_ERROR("sql.sql", "Item (Entry: {}) does not exist in item.dbc! (not correct id?).", entry);

        if (itemTemplate.Quality >= MAX_ITEM_QUALITY)
        {
            LOG_ERROR("sql.sql", "Item (Entry: {}) has wrong Quality value ({})", entry, itemTemplate.Quality);
            itemTemplate.Quality = ITEM_QUALITY_NORMAL;
        }

        if (itemTemplate.Flags2 & ITEM_FLAGS_EXTRA_HORDE_ONLY)
        {
            if (FactionEntry const* faction = sFactionStore.LookupEntry(HORDE))
                if ((itemTemplate.AllowableRace & faction->BaseRepRaceMask[0]) == 0)
                    LOG_ERROR("sql.sql", "Item (Entry: {}) has value ({}) in `AllowableRace` races, not compatible with ITEM_FLAGS_EXTRA_HORDE_ONLY ({}) in Flags field, item cannot be equipped or used by these races.",
                                     entry, itemTemplate.AllowableRace, ITEM_FLAGS_EXTRA_HORDE_ONLY);

            if (itemTemplate.Flags2 & ITEM_FLAGS_EXTRA_ALLIANCE_ONLY)
                LOG_ERROR("sql.sql", "Item (Entry: {}) has value ({}) in `Flags2` flags (ITEM_FLAGS_EXTRA_ALLIANCE_ONLY) and ITEM_FLAGS_EXTRA_HORDE_ONLY ({}) in Flags field, this is a wrong combination.",
                                 entry, ITEM_FLAGS_EXTRA_ALLIANCE_ONLY, ITEM_FLAGS_EXTRA_HORDE_ONLY);
        }
        else if (itemTemplate.Flags2 & ITEM_FLAGS_EXTRA_ALLIANCE_ONLY)
        {
            if (FactionEntry const* faction = sFactionStore.LookupEntry(ALLIANCE))
                if ((itemTemplate.AllowableRace & faction->BaseRepRaceMask[0]) == 0)
                    LOG_ERROR("sql.sql", "Item (Entry: {}) has value ({}) in `AllowableRace` races, not compatible with ITEM_FLAGS_EXTRA_ALLIANCE_ONLY ({}) in Flags field, item cannot be equipped or used by these races.",
                                     entry, itemTemplate.AllowableRace, ITEM_FLAGS_EXTRA_ALLIANCE_ONLY);
        }

        if (itemTemplate.BuyCount <= 0)
        {
            LOG_ERROR("sql.sql", "Item (Entry: {}) has wrong BuyCount value ({}), set to default(1).", entry, itemTemplate.BuyCount);
            itemTemplate.BuyCount = 1;
        }

        if (itemTemplate.RequiredSkill >= MAX_SKILL_TYPE)
        {
            LOG_ERROR("sql.sql", "Item (Entry: {}) has wrong RequiredSkill value ({})", entry, itemTemplate.RequiredSkill);
            itemTemplate.RequiredSkill = 0;
        }

        {
            // can be used in equip slot, as page read use in inventory, or spell casting at use
            bool req = itemTemplate.InventoryType != INVTYPE_NON_EQUIP || itemTemplate.PageText;
            if (!req)
                for (uint8 j = 0; j < MAX_ITEM_PROTO_SPELLS; ++j)
                {
                    if (itemTemplate.Spells[j].SpellId)
                    {
                        req = true;
                        break;
                    }
                }

            if (req)
            {
                if (!(itemTemplate.AllowableClass & CLASSMASK_ALL_PLAYABLE))
                    LOG_ERROR("sql.sql", "Item (Entry: {}) does not have any playable classes ({}) in `AllowableClass` and can't be equipped or used.", entry, itemTemplate.AllowableClass);

                if (!(itemTemplate.AllowableRace & RACEMASK_ALL_PLAYABLE))
                    LOG_ERROR("sql.sql", "Item (Entry: {}) does not have any playable races ({}) in `AllowableRace` and can't be equipped or used.", entry, itemTemplate.AllowableRace);
            }
        }

        if (itemTemplate.RequiredSpell && !sSpellMgr->GetSpellInfo(itemTemplate.RequiredSpell))
        {
            LOG_ERROR("sql.sql", "Item (Entry: {}) has a wrong (non-existing) spell in RequiredSpell ({})", entry, itemTemplate.RequiredSpell);
            itemTemplate.RequiredSpell = 0;
        }

        if (itemTemplate.RequiredReputationRank >= MAX_REPUTATION_RANK)
            LOG_ERROR("sql.sql", "Item (Entry: {}) has wrong reputation rank in RequiredReputationRank ({}), item can't be used.", entry, itemTemplate.RequiredReputationRank);

        if (itemTemplate.RequiredReputationFaction)
        {
            if (!sFactionStore.LookupEntry(itemTemplate.RequiredReputationFaction))
            {
                LOG_ERROR("sql.sql", "Item (Entry: {}) has wrong (not existing) faction in RequiredReputationFaction ({})", entry, itemTemplate.RequiredReputationFaction);
                itemTemplate.RequiredReputationFaction = 0;
            }

            if (itemTemplate.RequiredReputationRank == MIN_REPUTATION_RANK)
                LOG_ERROR("sql.sql", "Item (Entry: {}) has min. reputation rank in RequiredReputationRank (0) but RequiredReputationFaction > 0, faction setting is useless.", entry);
        }

        if (itemTemplate.MaxCount < -1)
        {
            LOG_ERROR("sql.sql", "Item (Entry: {}) has too large negative in maxcount ({}), replace by value (-1) no storing limits.", entry, itemTemplate.MaxCount);
            itemTemplate.MaxCount = -1;
        }

        if (itemTemplate.Stackable == 0)
        {
            LOG_ERROR("sql.sql", "Item (Entry: {}) has wrong value in stackable ({}), replace by default 1.", entry, itemTemplate.Stackable);
            itemTemplate.Stackable = 1;
        }
        else if (itemTemplate.Stackable < -1)
        {
            LOG_ERROR("sql.sql", "Item (Entry: {}) has too large negative in stackable ({}), replace by value (-1) no stacking limits.", entry, itemTemplate.Stackable);
            itemTemplate.Stackable = -1;
        }

        if (itemTemplate.ContainerSlots > MAX_BAG_SIZE)
        {
            LOG_ERROR("sql.sql", "Item (Entry: {}) has too large value in ContainerSlots ({}), replace by hardcoded limit ({}).", entry, itemTemplate.ContainerSlots, MAX_BAG_SIZE);
            itemTemplate.ContainerSlots = MAX_BAG_SIZE;
        }

        if (itemTemplate.StatsCount > MAX_ITEM_PROTO_STATS)
        {
            LOG_ERROR("sql.sql", "Item (Entry: {}) has too large value in statscount ({}), replace by hardcoded limit ({}).", entry, itemTemplate.StatsCount, MAX_ITEM_PROTO_STATS);
            itemTemplate.StatsCount = MAX_ITEM_PROTO_STATS;
        }

        for (uint8 j = 0; j < itemTemplate.StatsCount; ++j)
        {
            // for ItemStatValue != 0
            if (itemTemplate.ItemStat[j].ItemStatValue && itemTemplate.ItemStat[j].ItemStatType >= MAX_ITEM_MOD)
            {
                LOG_ERROR("sql.sql", "Item (Entry: {}) has wrong (non-existing?) stat_type{} ({})", entry, j + 1, itemTemplate.ItemStat[j].ItemStatType);
                itemTemplate.ItemStat[j].ItemStatType = 0;
            }

            switch (itemTemplate.ItemStat[j].ItemStatType)
            {
                case ITEM_MOD_SPELL_HEALING_DONE:
                case ITEM_MOD_SPELL_DAMAGE_DONE:
                    LOG_ERROR("sql.sql", "Item (Entry: {}) has deprecated stat_type{} ({})", entry, j + 1, itemTemplate.ItemStat[j].ItemStatType);
                    break;
                default:
                    break;
            }
        }

        for (uint8 j = 0; j < MAX_ITEM_PROTO_DAMAGES; ++j)
        {
            if (itemTemplate.Damage[j].DamageType >= MAX_SPELL_SCHOOL)
            {
                LOG_ERROR("sql.sql", "Item (Entry: {}) has wrong dmg_type{} ({})", entry, j + 1, itemTemplate.Damage[j].DamageType);
                itemTemplate.Damage[j].DamageType = 0;
            }
        }

        // special format
        if ((itemTemplate.Spells[0].SpellId == 483) || (itemTemplate.Spells[0].SpellId == 55884))
        {
            // spell_1
            if (itemTemplate.Spells[0].SpellTrigger != ITEM_SPELLTRIGGER_ON_USE)
            {
                LOG_ERROR("sql.sql", "Item (Entry: {}) has wrong item spell trigger value in spelltrigger_{} ({}) for special learning format", entry, 0 + 1, itemTemplate.Spells[0].SpellTrigger);
                itemTemplate.Spells[0].SpellId = 0;
                itemTemplate.Spells[0].SpellTrigger = ITEM_SPELLTRIGGER_ON_USE;
                itemTemplate.Spells[1].SpellId = 0;
                itemTemplate.Spells[1].SpellTrigger = ITEM_SPELLTRIGGER_ON_USE;
            }

            // spell_2 have learning spell
            if (itemTemplate.Spells[1].SpellTrigger != ITEM_SPELLTRIGGER_LEARN_SPELL_ID)
            {
                LOG_ERROR("sql.sql", "Item (Entry: {}) has wrong item spell trigger value in spelltrigger_{} ({}) for special learning format.", entry, 1 + 1, itemTemplate.Spells[1].SpellTrigger);
                itemTemplate.Spells[0].SpellId = 0;
                itemTemplate.Spells[1].SpellId = 0;
                itemTemplate.Spells[1].SpellTrigger = ITEM_SPELLTRIGGER_ON_USE;
            }
            else if (!itemTemplate.Spells[1].SpellId)
            {
                LOG_ERROR("sql.sql", "Item (Entry: {}) does not have an expected spell in spellid_{} in special learning format.", entry, 1 + 1);
                itemTemplate.Spells[0].SpellId = 0;
                itemTemplate.Spells[1].SpellTrigger = ITEM_SPELLTRIGGER_ON_USE;
            }
            else if (itemTemplate.Spells[1].SpellId != -1)
            {
                SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(itemTemplate.Spells[1].SpellId);
                if (!spellInfo && !DisableMgr::IsDisabledFor(DISABLE_TYPE_SPELL, itemTemplate.Spells[1].SpellId, nullptr))
                {
                    LOG_ERROR("sql.sql", "Item (Entry: {}) has wrong (not existing) spell in spellid_{} ({})", entry, 1 + 1, itemTemplate.Spells[1].SpellId);
                    itemTemplate.Spells[0].SpellId = 0;
                    itemTemplate.Spells[1].SpellId = 0;
                    itemTemplate.Spells[1].SpellTrigger = ITEM_SPELLTRIGGER_ON_USE;
                }
                // allowed only in special format
                else if ((itemTemplate.Spells[1].SpellId == 483) || (itemTemplate.Spells[1].SpellId == 55884))
                {
                    LOG_ERROR("sql.sql", "Item (Entry: {}) has broken spell in spellid_{} ({})", entry, 1 + 1, itemTemplate.Spells[1].SpellId);
                    itemTemplate.Spells[0].SpellId = 0;
                    itemTemplate.Spells[1].SpellId = 0;
                    itemTemplate.Spells[1].SpellTrigger = ITEM_SPELLTRIGGER_ON_USE;
                }
            }

            // spell_3*, spell_4*, spell_5* is empty
            for (uint8 j = 2; j < MAX_ITEM_PROTO_SPELLS; ++j)
            {
                if (itemTemplate.Spells[j].SpellTrigger != ITEM_SPELLTRIGGER_ON_USE)
                {
                    LOG_ERROR("sql.sql", "Item (Entry: {}) has wrong item spell trigger value in spelltrigger_{} ({})", entry, j + 1, itemTemplate.Spells[j].SpellTrigger);
                    itemTemplate.Spells[j].SpellId = 0;
                    itemTemplate.Spells[j].SpellTrigger = ITEM_SPELLTRIGGER_ON_USE;
                }
                else if (itemTemplate.Spells[j].SpellId != 0)
                {
                    LOG_ERROR("sql.sql", "Item (Entry: {}) has wrong spell in spellid_{} ({}) for learning special format", entry, j + 1, itemTemplate.Spells[j].SpellId);
                    itemTemplate.Spells[j].SpellId = 0;
                }
            }
        }
        // normal spell list
        else
        {
            for (uint8 j = 0; j < MAX_ITEM_PROTO_SPELLS; ++j)
            {
                if (itemTemplate.Spells[j].SpellTrigger >= MAX_ITEM_SPELLTRIGGER || itemTemplate.Spells[j].SpellTrigger == ITEM_SPELLTRIGGER_LEARN_SPELL_ID)
                {
                    LOG_ERROR("sql.sql", "Item (Entry: {}) has wrong item spell trigger value in spelltrigger_{} ({})", entry, j + 1, itemTemplate.Spells[j].SpellTrigger);
                    itemTemplate.Spells[j].SpellId = 0;
                    itemTemplate.Spells[j].SpellTrigger = ITEM_SPELLTRIGGER_ON_USE;
                }

                if (itemTemplate.Spells[j].SpellId && itemTemplate.Spells[j].SpellId != -1)
                {
                    SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(itemTemplate.Spells[j].SpellId);
                    if (!spellInfo && !DisableMgr::IsDisabledFor(DISABLE_TYPE_SPELL, itemTemplate.Spells[j].SpellId, nullptr))
                    {
                        LOG_ERROR("sql.sql", "Item (Entry: {}) has wrong (not existing) spell in spellid_{} ({})", entry, j + 1, itemTemplate.Spells[j].SpellId);
                        itemTemplate.Spells[j].SpellId = 0;
                    }
                    // allowed only in special format
                    else if ((itemTemplate.Spells[j].SpellId == 483) || (itemTemplate.Spells[j].SpellId == 55884))
                    {
                        LOG_ERROR("sql.sql", "Item (Entry: {}) has broken spell in spellid_{} ({})", entry, j + 1, itemTemplate.Spells[j].SpellId);
                        itemTemplate.Spells[j].SpellId = 0;
                    }
                }
            }
        }

        if (itemTemplate.Bonding >= MAX_BIND_TYPE)
            LOG_ERROR("sql.sql", "Item (Entry: {}) has wrong Bonding value ({})", entry, itemTemplate.Bonding);

        if (itemTemplate.PageText && !GetPageText(itemTemplate.PageText))
            LOG_ERROR("sql.sql", "Item (Entry: {}) has non existing first page (Id:{})", entry, itemTemplate.PageText);

        if (itemTemplate.LockID && !sLockStore.LookupEntry(itemTemplate.LockID))
            LOG_ERROR("sql.sql", "Item (Entry: {}) has wrong LockID ({})", entry, itemTemplate.LockID);

        if (itemTemplate.RandomProperty)
        {
            // To be implemented later
            if (itemTemplate.RandomProperty == -1)
                itemTemplate.RandomProperty = 0;

            else if (!sItemRandomPropertiesStore.LookupEntry(GetItemEnchantMod(itemTemplate.RandomProperty)))
            {
                LOG_ERROR("sql.sql", "Item (Entry: {}) has unknown (wrong or not listed in `item_enchantment_template`) RandomProperty ({})", entry, itemTemplate.RandomProperty);
                itemTemplate.RandomProperty = 0;
            }
        }

        if (itemTemplate.RandomSuffix && !sItemRandomSuffixStore.LookupEntry(GetItemEnchantMod(itemTemplate.RandomSuffix)))
        {
            LOG_ERROR("sql.sql", "Item (Entry: {}) has wrong RandomSuffix ({})", entry, itemTemplate.RandomSuffix);
            itemTemplate.RandomSuffix = 0;
        }

        if (itemTemplate.ItemSet && !sItemSetStore.LookupEntry(itemTemplate.ItemSet))
        {
            LOG_ERROR("sql.sql", "Item (Entry: {}) have wrong ItemSet ({})", entry, itemTemplate.ItemSet);
            itemTemplate.ItemSet = 0;
        }

        if (itemTemplate.Area && !sAreaTableStore.LookupEntry(itemTemplate.Area))
            LOG_ERROR("sql.sql", "Item (Entry: {}) has wrong Area ({})", entry, itemTemplate.Area);

        if (itemTemplate.Map && !sMapStore.LookupEntry(itemTemplate.Map))
            LOG_ERROR("sql.sql", "Item (Entry: {}) has wrong Map ({})", entry, itemTemplate.Map);

        if (itemTemplate.BagFamily)
        {
            // check bits
            for (uint32 j = 0; j < sizeof(itemTemplate.BagFamily) * 8; ++j)
            {
                uint32 mask = 1 << j;
                if ((itemTemplate.BagFamily & mask) == 0)
                    continue;

                ItemBagFamilyEntry const* bf = sItemBagFamilyStore.LookupEntry(j + 1);
                if (!bf)
                {
                    LOG_ERROR("sql.sql", "Item (Entry: {}) has bag family bit set not listed in ItemBagFamily.dbc, remove bit", entry);
                    itemTemplate.BagFamily &= ~mask;
                    continue;
                }

                if (BAG_FAMILY_MASK_CURRENCY_TOKENS & mask)
                {
                    CurrencyTypesEntry const* ctEntry = sCurrencyTypesStore.LookupEntry(itemTemplate.ItemId);
                    if (!ctEntry)
                    {
                        LOG_ERROR("sql.sql", "Item (Entry: {}) has currency bag family bit set in BagFamily but not listed in CurrencyTypes.dbc, remove bit", entry);
                        itemTemplate.BagFamily &= ~mask;
                    }
                }
            }
        }

        if (itemTemplate.TotemCategory && !sTotemCategoryStore.LookupEntry(itemTemplate.TotemCategory))
            LOG_ERROR("sql.sql", "Item (Entry: {}) has wrong TotemCategory ({})", entry, itemTemplate.TotemCategory);

        for (uint8 j = 0; j < MAX_ITEM_PROTO_SOCKETS; ++j)
        {
            if (itemTemplate.Socket[j].Color && (itemTemplate.Socket[j].Color & SOCKET_COLOR_ALL) != itemTemplate.Socket[j].Color)
            {
                LOG_ERROR("sql.sql", "Item (Entry: {}) has wrong socketColor_{} ({})", entry, j + 1, itemTemplate.Socket[j].Color);
                itemTemplate.Socket[j].Color = 0;
            }
        }

        if (itemTemplate.GemProperties && !sGemPropertiesStore.LookupEntry(itemTemplate.GemProperties))
            LOG_ERROR("sql.sql", "Item (Entry: {}) has wrong GemProperties ({})", entry, itemTemplate.GemProperties);

        if (itemTemplate.FoodType >= MAX_PET_DIET)
        {
            LOG_ERROR("sql.sql", "Item (Entry: {}) has wrong FoodType value ({})", entry, itemTemplate.FoodType);
            itemTemplate.FoodType = 0;
        }

        if (itemTemplate.ItemLimitCategory && !sItemLimitCategoryStore.LookupEntry(itemTemplate.ItemLimitCategory))
        {
            LOG_ERROR("sql.sql", "Item (Entry: {}) has wrong LimitCategory value ({})", entry, itemTemplate.ItemLimitCategory);
            itemTemplate.ItemLimitCategory = 0;
        }

        if (itemTemplate.HolidayId && !sHolidaysStore.LookupEntry(itemTemplate.HolidayId))
        {
            LOG_ERROR("sql.sql", "Item (Entry: {}) has wrong HolidayId value ({})", entry, itemTemplate.HolidayId);
            itemTemplate.HolidayId = 0;
        }

        if (itemTemplate.FlagsCu & ITEM_FLAGS_CU_DURATION_REAL_TIME && !itemTemplate.Duration)
        {
            LOG_ERROR("sql.sql", "Item (Entry {}) has flag ITEM_FLAGS_CU_DURATION_REAL_TIME but it does not have duration limit", entry);
            itemTemplate.FlagsCu &= ~ITEM_FLAGS_CU_DURATION_REAL_TIME;
        }

        // Fill categories map
        for (uint8 i = 0; i < MAX_ITEM_PROTO_SPELLS; ++i)
            if (itemTemplate.Spells[i].SpellId && itemTemplate.Spells[i].SpellCategory && itemTemplate.Spells[i].SpellCategoryCooldown)
            {
                SpellCategoryStore::iterator ct = sSpellsByCategoryStore.find(itemTemplate.Spells[i].SpellCategory);
                if (ct != sSpellsByCategoryStore.end())
                {
                    ct->second.emplace(true, itemTemplate.Spells[i].SpellId);
                }
                else
                    sSpellsByCategoryStore[itemTemplate.Spells[i].SpellCategory].emplace(true, itemTemplate.Spells[i].SpellId);
            }

        ++count;
    } while (result->NextRow());

    // pussywizard:
    {
        uint32 max = 0;
        for (ItemTemplateContainer::const_iterator itr = _itemTemplateStore.begin(); itr != _itemTemplateStore.end(); ++itr)
            if (itr->first > max)
                max = itr->first;
        if (max)
        {
            _itemTemplateStoreFast.clear();
            _itemTemplateStoreFast.resize(max + 1, nullptr);
            for (ItemTemplateContainer::iterator itr = _itemTemplateStore.begin(); itr != _itemTemplateStore.end(); ++itr)
                _itemTemplateStoreFast[itr->first] = &(itr->second);
        }
    }

    for (ItemTemplateContainer::iterator itr = _itemTemplateStore.begin(); itr != _itemTemplateStore.end(); ++itr)
        itr->second.InitializeQueryData();

    // Check if item templates for DBC referenced character start outfit are present
    std::set<uint32> notFoundOutfit;
    for (uint32 i = 1; i < sCharStartOutfitStore.GetNumRows(); ++i)
    {
        CharStartOutfitEntry const* entry = sCharStartOutfitStore.LookupEntry(i);
        if (!entry)
            continue;

        for (int j = 0; j < MAX_OUTFIT_ITEMS; ++j)
        {
            if (entry->ItemId[j] <= 0)
                continue;

            uint32 item_id = entry->ItemId[j];

            if (!GetItemTemplate(item_id))
                notFoundOutfit.insert(item_id);
        }
    }

    for (std::set<uint32>::const_iterator itr = notFoundOutfit.begin(); itr != notFoundOutfit.end(); ++itr)
        LOG_ERROR("sql.sql", "Item (Entry: {}) does not exist in `item_template` but is referenced in `CharStartOutfit.dbc`", *itr);

    LOG_INFO("server.loading", ">> Loaded {} Item Templates in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
}

ItemTemplate const* ObjectMgr::GetItemTemplate(uint32 entry)
{
    return entry < _itemTemplateStoreFast.size() ? _itemTemplateStoreFast[entry] : nullptr;
}

void ObjectMgr::LoadItemSetNameLocales()
{
    uint32 oldMSTime = getMSTime();

    _itemSetNameLocaleStore.clear();                                 // need for reload case

    QueryResult result = WorldDatabase.Query("SELECT ID, locale, Name FROM item_set_names_locale");

    if (!result)
        return;

    do
    {
        Field* fields = result->Fetch();

        uint32 ID = fields[0].Get<uint32>();

        LocaleConstant locale = GetLocaleByName(fields[1].Get<std::string>());
        if (locale == LOCALE_enUS)
            continue;

        ItemSetNameLocale& data = _itemSetNameLocaleStore[ID];
        AddLocaleString(fields[2].Get<std::string>(), locale, data.Name);
    } while (result->NextRow());

    LOG_INFO("server.loading", ">> Loaded {} Item Set Name Locale Strings in {} ms", uint32(_itemSetNameLocaleStore.size()), GetMSTimeDiffToNow(oldMSTime));
}

void ObjectMgr::LoadItemSetNames()
{
    uint32 oldMSTime = getMSTime();

    _itemSetNameStore.clear();                               // needed for reload case

    std::set<uint32> itemSetItems;

    // fill item set member ids
    for (uint32 entryId = 0; entryId < sItemSetStore.GetNumRows(); ++entryId)
    {
        ItemSetEntry const* setEntry = sItemSetStore.LookupEntry(entryId);
        if (!setEntry)
            continue;

        for (uint32 i = 0; i < MAX_ITEM_SET_ITEMS; ++i)
            if (setEntry->itemId[i])
                itemSetItems.insert(setEntry->itemId[i]);
    }

    //                                                  0        1            2
    QueryResult result = WorldDatabase.Query("SELECT `entry`, `name`, `InventoryType` FROM `item_set_names`");

    if (!result)
    {
        LOG_WARN("server.loading", ">> Loaded 0 item set names. DB table `item_set_names` is empty.");
        LOG_INFO("server.loading", " ");
        return;
    }

    _itemSetNameStore.rehash(result->GetRowCount());
    uint32 count = 0;

    do
    {
        Field* fields = result->Fetch();

        uint32 entry = fields[0].Get<uint32>();
        if (itemSetItems.find(entry) == itemSetItems.end())
        {
            LOG_ERROR("sql.sql", "Item set name (Entry: {}) not found in ItemSet.dbc, data useless.", entry);
            continue;
        }

        ItemSetNameEntry& data = _itemSetNameStore[entry];
        data.name = fields[1].Get<std::string>();

        uint32 invType = fields[2].Get<uint8>();
        if (invType >= MAX_INVTYPE)
        {
            LOG_ERROR("sql.sql", "Item set name (Entry: {}) has wrong InventoryType value ({})", entry, invType);
            invType = INVTYPE_NON_EQUIP;
        }

        data.InventoryType = invType;
        itemSetItems.erase(entry);
        ++count;
    } while (result->NextRow());

    if (!itemSetItems.empty())
    {
        ItemTemplate const* pProto;
        for (std::set<uint32>::iterator itr = itemSetItems.begin(); itr != itemSetItems.end(); ++itr)
        {
            uint32 entry = *itr;
            // add data from item_template if available
            pProto = sObjectMgr->GetItemTemplate(entry);
            if (pProto)
            {
                LOG_ERROR("sql.sql", "Item set part (Entry: {}) does not have entry in `item_set_names`, adding data from `item_template`.", entry);
                ItemSetNameEntry& data = _itemSetNameStore[entry];
                data.name = pProto->Name1;
                data.InventoryType = pProto->InventoryType;
                ++count;
            }
            else
                LOG_ERROR("sql.sql", "Item set part (Entry: {}) does not have entry in `item_set_names`, set will not display properly.", entry);
        }
    }

    LOG_INFO("server.loading", ">> Loaded {} Item Set Names in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
}

void ObjectMgr::LoadVehicleTemplateAccessories()
{
    uint32 oldMSTime = getMSTime();

    _vehicleTemplateAccessoryStore.clear();                           // needed for reload case

    uint32 count = 0;

    //                                                  0             1              2          3           4             5
    QueryResult result = WorldDatabase.Query("SELECT `entry`, `accessory_entry`, `seat_id`, `minion`, `summontype`, `summontimer` FROM `vehicle_template_accessory`");

    if (!result)
    {
        LOG_WARN("server.loading", ">> Loaded 0 vehicle template accessories. DB table `vehicle_template_accessory` is empty.");
        LOG_INFO("server.loading", " ");
        return;
    }

    do
    {
        Field* fields = result->Fetch();

        uint32 uiEntry      = fields[0].Get<uint32>();
        uint32 uiAccessory  = fields[1].Get<uint32>();
        int8   uiSeat       = int8(fields[2].Get<int8>());
        bool   bMinion      = fields[3].Get<bool>();
        uint8  uiSummonType = fields[4].Get<uint8>();
        uint32 uiSummonTimer = fields[5].Get<uint32>();

        if (!sObjectMgr->GetCreatureTemplate(uiEntry))
        {
            LOG_ERROR("sql.sql", "Table `vehicle_template_accessory`: creature template entry {} does not exist.", uiEntry);
            continue;
        }

        if (!sObjectMgr->GetCreatureTemplate(uiAccessory))
        {
            LOG_ERROR("sql.sql", "Table `vehicle_template_accessory`: Accessory {} does not exist.", uiAccessory);
            continue;
        }

        if (_spellClickInfoStore.find(uiEntry) == _spellClickInfoStore.end())
        {
            LOG_ERROR("sql.sql", "Table `vehicle_template_accessory`: creature template entry {} has no data in npc_spellclick_spells", uiEntry);
            continue;
        }

        _vehicleTemplateAccessoryStore[uiEntry].push_back(VehicleAccessory(uiAccessory, uiSeat, bMinion, uiSummonType, uiSummonTimer));

        ++count;
    } while (result->NextRow());

    LOG_INFO("server.loading", ">> Loaded {} Vehicle Template Accessories in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
}

void ObjectMgr::LoadVehicleAccessories()
{
    uint32 oldMSTime = getMSTime();

    _vehicleAccessoryStore.clear();                           // needed for reload case

    uint32 count = 0;

    //                                                  0             1             2          3           4             5
    QueryResult result = WorldDatabase.Query("SELECT `guid`, `accessory_entry`, `seat_id`, `minion`, `summontype`, `summontimer` FROM `vehicle_accessory`");

    if (!result)
    {
        LOG_WARN("server.loading", ">> Loaded 0 Vehicle Accessories in {} ms", GetMSTimeDiffToNow(oldMSTime));
        LOG_INFO("server.loading", " ");
        return;
    }

    do
    {
        Field* fields = result->Fetch();

        uint32 uiGUID       = fields[0].Get<uint32>();
        uint32 uiAccessory  = fields[1].Get<uint32>();
        int8   uiSeat       = int8(fields[2].Get<int16>());
        bool   bMinion      = fields[3].Get<bool>();
        uint8  uiSummonType = fields[4].Get<uint8>();
        uint32 uiSummonTimer = fields[5].Get<uint32>();

        if (!sObjectMgr->GetCreatureTemplate(uiAccessory))
        {
            LOG_ERROR("sql.sql", "Table `vehicle_accessory`: Accessory {} does not exist.", uiAccessory);
            continue;
        }

        _vehicleAccessoryStore[uiGUID].push_back(VehicleAccessory(uiAccessory, uiSeat, bMinion, uiSummonType, uiSummonTimer));

        ++count;
    } while (result->NextRow());

    LOG_INFO("server.loading", ">> Loaded {} Vehicle Accessories in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
}

void ObjectMgr::LoadPetLevelInfo()
{
    uint32 oldMSTime = getMSTime();

    //                                                 0               1      2   3     4    5    6    7     8    9      10       11
    QueryResult result = WorldDatabase.Query("SELECT creature_entry, level, hp, mana, str, agi, sta, inte, spi, armor, min_dmg, max_dmg FROM pet_levelstats");

    if (!result)
    {
        LOG_WARN("server.loading", ">> Loaded 0 level pet stats definitions. DB table `pet_levelstats` is empty.");
        LOG_INFO("server.loading", " ");
        return;
    }

    uint32 count = 0;

    do
    {
        Field* fields = result->Fetch();

        uint32 creature_id = fields[0].Get<uint32>();
        if (!sObjectMgr->GetCreatureTemplate(creature_id))
        {
            LOG_ERROR("sql.sql", "Wrong creature id {} in `pet_levelstats` table, ignoring.", creature_id);
            continue;
        }

        uint32 current_level = fields[1].Get<uint8>();
        if (current_level > sWorld->getIntConfig(CONFIG_MAX_PLAYER_LEVEL))
        {
            if (current_level > STRONG_MAX_LEVEL)        // hardcoded level maximum
                LOG_ERROR("sql.sql", "Wrong (> {}) level {} in `pet_levelstats` table, ignoring.", STRONG_MAX_LEVEL, current_level);
            else
            {
                LOG_DEBUG("sql.sql", "Unused (> MaxPlayerLevel in worldserver.conf) level {} in `pet_levelstats` table, ignoring.", current_level);
                ++count;                                // make result loading percent "expected" correct in case disabled detail mode for example.
            }
            continue;
        }
        else if (current_level < 1)
        {
            LOG_ERROR("sql.sql", "Wrong (<1) level {} in `pet_levelstats` table, ignoring.", current_level);
            continue;
        }

        PetLevelInfo*& pInfoMapEntry = _petInfoStore[creature_id];

        if (!pInfoMapEntry)
            pInfoMapEntry = new PetLevelInfo[sWorld->getIntConfig(CONFIG_MAX_PLAYER_LEVEL)];

        // data for level 1 stored in [0] array element, ...
        PetLevelInfo* pLevelInfo = &pInfoMapEntry[current_level - 1];

        pLevelInfo->health = fields[2].Get<uint32>();
        pLevelInfo->mana   = fields[3].Get<uint32>();
        pLevelInfo->armor  = fields[9].Get<uint32>();
        pLevelInfo->min_dmg = fields[10].Get<uint32>();
        pLevelInfo->max_dmg = fields[11].Get<uint32>();
        for (uint8 i = 0; i < MAX_STATS; i++)
        {
            pLevelInfo->stats[i] = fields[i + 4].Get<uint32>();
        }

        ++count;
    } while (result->NextRow());

    // Fill gaps and check integrity
    for (PetLevelInfoContainer::iterator itr = _petInfoStore.begin(); itr != _petInfoStore.end(); ++itr)
    {
        PetLevelInfo* pInfo = itr->second;

        // fatal error if no level 1 data
        if (!pInfo || pInfo[0].health == 0)
        {
            LOG_ERROR("sql.sql", "Creature {} does not have pet stats data for Level 1!", itr->first);
            exit(1);
        }

        // fill level gaps
        for (uint8 level = 1; level < sWorld->getIntConfig(CONFIG_MAX_PLAYER_LEVEL); ++level)
        {
            if (pInfo[level].health == 0)
            {
                LOG_ERROR("sql.sql", "Creature {} has no data for Level {} pet stats data, using data of Level {}.", itr->first, level + 1, level);
                pInfo[level] = pInfo[level - 1];
            }
        }
    }

    LOG_INFO("server.loading", ">> Loaded {} Level Pet Stats Definitions in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
}

PetLevelInfo const* ObjectMgr::GetPetLevelInfo(uint32 creature_id, uint8 level) const
{
    if (level > sWorld->getIntConfig(CONFIG_MAX_PLAYER_LEVEL))
        level = sWorld->getIntConfig(CONFIG_MAX_PLAYER_LEVEL);

    PetLevelInfoContainer::const_iterator itr = _petInfoStore.find(creature_id);
    if (itr == _petInfoStore.end())
        return nullptr;

    return &itr->second[level - 1];                         // data for level 1 stored in [0] array element, ...
}

void ObjectMgr::PlayerCreateInfoAddItemHelper(uint32 race_, uint32 class_, uint32 itemId, int32 count)
{
    if (!_playerInfo[race_][class_])
        return;

    if (count > 0)
        _playerInfo[race_][class_]->item.push_back(PlayerCreateInfoItem(itemId, count));
    else
    {
        if (count < -1)
            LOG_ERROR("sql.sql", "Invalid count {} specified on item {} be removed from original player create info (use -1)!", count, itemId);

        for (uint32 gender = 0; gender < GENDER_NONE; ++gender)
        {
            if (CharStartOutfitEntry const* entry = GetCharStartOutfitEntry(race_, class_, gender))
            {
                bool found = false;
                for (uint8 x = 0; x < MAX_OUTFIT_ITEMS; ++x)
                {
                    if (entry->ItemId[x] > 0 && uint32(entry->ItemId[x]) == itemId)
                    {
                        found = true;
                        const_cast<CharStartOutfitEntry*>(entry)->ItemId[x] = 0;
                        break;
                    }
                }

                if (!found)
                    LOG_ERROR("sql.sql", "Item {} specified to be removed from original create info not found in dbc!", itemId);
            }
        }
    }
}

void ObjectMgr::LoadPlayerInfo()
{
    // Load playercreate
    {
        uint32 oldMSTime = getMSTime();
        //                                                0     1      2    3        4          5           6
        QueryResult result = WorldDatabase.Query("SELECT race, class, map, zone, position_x, position_y, position_z, orientation FROM playercreateinfo");

        if (!result)
        {
            LOG_INFO("server.loading", " ");
            LOG_WARN("server.loading", ">> Loaded 0 player create definitions. DB table `playercreateinfo` is empty.");
            exit(1);
        }
        else
        {
            uint32 count = 0;

            do
            {
                Field* fields = result->Fetch();

                uint32 current_race  = fields[0].Get<uint8>();
                uint32 current_class = fields[1].Get<uint8>();
                uint32 mapId         = fields[2].Get<uint16>();
                uint32 areaId        = fields[3].Get<uint32>(); // zone
                float  positionX     = fields[4].Get<float>();
                float  positionY     = fields[5].Get<float>();
                float  positionZ     = fields[6].Get<float>();
                float  orientation   = fields[7].Get<float>();

                if (current_race >= MAX_RACES)
                {
                    LOG_ERROR("sql.sql", "Wrong race {} in `playercreateinfo` table, ignoring.", current_race);
                    continue;
                }

                ChrRacesEntry const* rEntry = sChrRacesStore.LookupEntry(current_race);
                if (!rEntry)
                {
                    LOG_ERROR("sql.sql", "Wrong race {} in `playercreateinfo` table, ignoring.", current_race);
                    continue;
                }

                if (current_class >= MAX_CLASSES)
                {
                    LOG_ERROR("sql.sql", "Wrong class {} in `playercreateinfo` table, ignoring.", current_class);
                    continue;
                }

                if (!sChrClassesStore.LookupEntry(current_class))
                {
                    LOG_ERROR("sql.sql", "Wrong class {} in `playercreateinfo` table, ignoring.", current_class);
                    continue;
                }

                // accept DB data only for valid position (and non instanceable)
                if (!MapMgr::IsValidMapCoord(mapId, positionX, positionY, positionZ, orientation))
                {
                    LOG_ERROR("sql.sql", "Wrong home position for class {} race {} pair in `playercreateinfo` table, ignoring.", current_class, current_race);
                    continue;
                }

                if (sMapStore.LookupEntry(mapId)->Instanceable())
                {
                    LOG_ERROR("sql.sql", "Home position in instanceable map for class {} race {} pair in `playercreateinfo` table, ignoring.", current_class, current_race);
                    continue;
                }

                PlayerInfo* info = new PlayerInfo();
                info->mapId = mapId;
                info->areaId = areaId;
                info->positionX = positionX;
                info->positionY = positionY;
                info->positionZ = positionZ;
                info->orientation = orientation;
                info->displayId_m = rEntry->model_m;
                info->displayId_f = rEntry->model_f;
                _playerInfo[current_race][current_class] = info;

                ++count;
            } while (result->NextRow());

            LOG_INFO("server.loading", ">> Loaded {} Player Create Definitions in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
            LOG_INFO("server.loading", " ");
        }
    }

    // Load playercreate items
    LOG_INFO("server.loading", "Loading Player Create Items Data...");
    {
        uint32 oldMSTime = getMSTime();
        //                                                0     1      2       3
        QueryResult result = WorldDatabase.Query("SELECT race, class, itemid, amount FROM playercreateinfo_item");

        if (!result)
        {
            LOG_WARN("server.loading", ">> Loaded 0 Custom Player Create Items. DB Table `playercreateinfo_item` Is Empty.");
            LOG_INFO("server.loading", " ");
        }
        else
        {
            uint32 count = 0;

            do
            {
                Field* fields = result->Fetch();

                uint32 current_race = fields[0].Get<uint8>();
                if (current_race >= MAX_RACES)
                {
                    LOG_ERROR("sql.sql", "Wrong race {} in `playercreateinfo_item` table, ignoring.", current_race);
                    continue;
                }

                uint32 current_class = fields[1].Get<uint8>();
                if (current_class >= MAX_CLASSES)
                {
                    LOG_ERROR("sql.sql", "Wrong class {} in `playercreateinfo_item` table, ignoring.", current_class);
                    continue;
                }

                uint32 item_id = fields[2].Get<uint32>();

                if (!GetItemTemplate(item_id))
                {
                    LOG_ERROR("sql.sql", "Item id {} (race {} class {}) in `playercreateinfo_item` table but not listed in `item_template`, ignoring.", item_id, current_race, current_class);
                    continue;
                }

                int32 amount = fields[3].Get<int32>();

                if (!amount)
                {
                    LOG_ERROR("sql.sql", "Item id {} (class {} race {}) have amount == 0 in `playercreateinfo_item` table, ignoring.", item_id, current_race, current_class);
                    continue;
                }

                if (!current_race || !current_class)
                {
                    uint32 min_race = current_race ? current_race : 1;
                    uint32 max_race = current_race ? current_race + 1 : MAX_RACES;
                    uint32 min_class = current_class ? current_class : 1;
                    uint32 max_class = current_class ? current_class + 1 : MAX_CLASSES;
                    for (uint32 r = min_race; r < max_race; ++r)
                        for (uint32 c = min_class; c < max_class; ++c)
                            PlayerCreateInfoAddItemHelper(r, c, item_id, amount);
                }
                else
                    PlayerCreateInfoAddItemHelper(current_race, current_class, item_id, amount);

                ++count;
            } while (result->NextRow());

            LOG_INFO("server.loading", ">> Loaded {} Custom Player Create Items in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
            LOG_INFO("server.loading", " ");
        }
    }

    // Load playercreate skills
    LOG_INFO("server.loading", "Loading Player Create Skill Data...");
    {
        uint32 oldMSTime = getMSTime();

        QueryResult result = WorldDatabase.Query("SELECT raceMask, classMask, skill, `rank` FROM playercreateinfo_skills");

        if (!result)
        {
            LOG_WARN("server.loading", ">> Loaded 0 Player Create Skills. DB Table `playercreateinfo_skills` Is Empty.");
        }
        else
        {
            uint32 count = 0;

            do
            {
                Field* fields = result->Fetch();
                uint32 raceMask = fields[0].Get<uint32>();
                uint32 classMask = fields[1].Get<uint32>();
                PlayerCreateInfoSkill skill;
                skill.SkillId = fields[2].Get<uint16>();
                skill.Rank = fields[3].Get<uint16>();

                if (skill.Rank >= MAX_SKILL_STEP)
                {
                    LOG_ERROR("sql.sql", "Skill rank value {} set for skill {} raceMask {} classMask {} is too high, max allowed value is {}", skill.Rank, skill.SkillId, raceMask, classMask, MAX_SKILL_STEP);
                    continue;
                }

                if (raceMask != 0 && !(raceMask & RACEMASK_ALL_PLAYABLE))
                {
                    LOG_ERROR("sql.sql", "Wrong race mask {} in `playercreateinfo_skills` table, ignoring.", raceMask);
                    continue;
                }

                if (classMask != 0 && !(classMask & CLASSMASK_ALL_PLAYABLE))
                {
                    LOG_ERROR("sql.sql", "Wrong class mask {} in `playercreateinfo_skills` table, ignoring.", classMask);
                    continue;
                }

                if (!sSkillLineStore.LookupEntry(skill.SkillId))
                {
                    LOG_ERROR("sql.sql", "Wrong skill id {} in `playercreateinfo_skills` table, ignoring.", skill.SkillId);
                    continue;
                }

                for (uint32 raceIndex = RACE_HUMAN; raceIndex < MAX_RACES; ++raceIndex)
                {
                    if (raceMask == 0 || ((1 << (raceIndex - 1)) & raceMask))
                    {
                        for (uint32 classIndex = CLASS_WARRIOR; classIndex < MAX_CLASSES; ++classIndex)
                        {
                            if (classMask == 0 || ((1 << (classIndex - 1)) & classMask))
                            {
                                if (!GetSkillRaceClassInfo(skill.SkillId, raceIndex, classIndex))
                                    continue;

                                if (PlayerInfo* info = _playerInfo[raceIndex][classIndex])
                                {
                                    info->skills.push_back(skill);
                                    ++count;
                                }
                            }
                        }
                    }
                }
            } while (result->NextRow());

            LOG_INFO("server.loading", ">> Loaded {} Player Create Skills in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
            LOG_INFO("server.loading", " ");
        }
    }

    // Load playercreate spells
    LOG_INFO("server.loading", "Loading Player Create Spell Data...");
    {
        uint32 oldMSTime = getMSTime();

        QueryResult result = WorldDatabase.Query("SELECT racemask, classmask, Spell FROM playercreateinfo_spell_custom");

        if (!result)
        {
            LOG_WARN("server.loading", ">> Loaded 0 player create spells. DB table `playercreateinfo_spell_custom` is empty.");
        }
        else
        {
            uint32 count = 0;

            do
            {
                Field* fields = result->Fetch();
                uint32 raceMask = fields[0].Get<uint32>();
                uint32 classMask = fields[1].Get<uint32>();
                uint32 spellId = fields[2].Get<uint32>();

                if (raceMask != 0 && !(raceMask & RACEMASK_ALL_PLAYABLE))
                {
                    LOG_ERROR("sql.sql", "Wrong race mask {} in `playercreateinfo_spell_custom` table, ignoring.", raceMask);
                    continue;
                }

                if (classMask != 0 && !(classMask & CLASSMASK_ALL_PLAYABLE))
                {
                    LOG_ERROR("sql.sql", "Wrong class mask {} in `playercreateinfo_spell_custom` table, ignoring.", classMask);
                    continue;
                }

                for (uint32 raceIndex = RACE_HUMAN; raceIndex < MAX_RACES; ++raceIndex)
                {
                    if (raceMask == 0 || ((1 << (raceIndex - 1)) & raceMask))
                    {
                        for (uint32 classIndex = CLASS_WARRIOR; classIndex < MAX_CLASSES; ++classIndex)
                        {
                            if (classMask == 0 || ((1 << (classIndex - 1)) & classMask))
                            {
                                if (PlayerInfo* info = _playerInfo[raceIndex][classIndex])
                                {
                                    info->customSpells.push_back(spellId);
                                    ++count;
                                }
                            }
                        }
                    }
                }
            } while (result->NextRow());

            LOG_INFO("server.loading", ">> Loaded {} Custom Player Create Spells in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
            LOG_INFO("server.loading", " ");
        }
    }

    // Load playercreate cast spell
    LOG_INFO("server.loading", "Loading Player Create Cast Spell Data...");
    {
        uint32 oldMSTime = getMSTime();

        QueryResult result = WorldDatabase.Query("SELECT raceMask, classMask, spell FROM playercreateinfo_cast_spell");

        if (!result)
        {
            LOG_WARN("server.loading", ">> Loaded 0 Player Create Cast Spells. DB Table `playercreateinfo_cast_spell` Is Empty.");
        }
        else
        {
            uint32 count = 0;

            do
            {
                Field* fields    = result->Fetch();
                uint32 raceMask  = fields[0].Get<uint32>();
                uint32 classMask = fields[1].Get<uint32>();
                uint32 spellId   = fields[2].Get<uint32>();

                if (raceMask != 0 && !(raceMask & RACEMASK_ALL_PLAYABLE))
                {
                    LOG_ERROR("sql.sql", "Wrong race mask {} in `playercreateinfo_cast_spell` table, ignoring.", raceMask);
                    continue;
                }

                if (classMask != 0 && !(classMask & CLASSMASK_ALL_PLAYABLE))
                {
                    LOG_ERROR("sql.sql", "Wrong class mask {} in `playercreateinfo_cast_spell` table, ignoring.", classMask);
                    continue;
                }

                for (uint32 raceIndex = RACE_HUMAN; raceIndex < MAX_RACES; ++raceIndex)
                {
                    if (raceMask == 0 || ((1 << (raceIndex - 1)) & raceMask))
                    {
                        for (uint32 classIndex = CLASS_WARRIOR; classIndex < MAX_CLASSES; ++classIndex)
                        {
                            if (classMask == 0 || ((1 << (classIndex - 1)) & classMask))
                            {
                                if (PlayerInfo* info = _playerInfo[raceIndex][classIndex])
                                {
                                    info->castSpells.push_back(spellId);
                                    ++count;
                                }
                            }
                        }
                    }
                }
            } while (result->NextRow());

            LOG_INFO("server.loading", ">> Loaded {} Player Create Cast Spells in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
            LOG_INFO("server.loading", " ");
        }
    }

    // Load playercreate actions
    LOG_INFO("server.loading", "Loading Player Create Action Data...");
    {
        uint32 oldMSTime = getMSTime();

        //                                                0     1      2       3       4
        QueryResult result = WorldDatabase.Query("SELECT race, class, button, action, type FROM playercreateinfo_action");

        if (!result)
        {
            LOG_WARN("server.loading", ">> Loaded 0 Player Create Actions. DB Table `playercreateinfo_action` Is Empty.");
            LOG_INFO("server.loading", " ");
        }
        else
        {
            uint32 count = 0;

            do
            {
                Field* fields = result->Fetch();

                uint32 current_race = fields[0].Get<uint8>();
                if (current_race >= MAX_RACES)
                {
                    LOG_ERROR("sql.sql", "Wrong race {} in `playercreateinfo_action` table, ignoring.", current_race);
                    continue;
                }

                uint32 current_class = fields[1].Get<uint8>();
                if (current_class >= MAX_CLASSES)
                {
                    LOG_ERROR("sql.sql", "Wrong class {} in `playercreateinfo_action` table, ignoring.", current_class);
                    continue;
                }

                if (PlayerInfo* info = _playerInfo[current_race][current_class])
                    info->action.push_back(PlayerCreateInfoAction(fields[2].Get<uint16>(), fields[3].Get<uint32>(), fields[4].Get<uint16>()));

                ++count;
            } while (result->NextRow());

            LOG_INFO("server.loading", ">> Loaded {} Player Create Actions in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
            LOG_INFO("server.loading", " ");
        }
    }

    // Loading levels data (class/race dependent)
    LOG_INFO("server.loading", "Loading Player Create Level Stats Data...");
    {
        struct RaceStats
        {
            int16 StatModifier[MAX_STATS];
        };

        std::array<RaceStats, MAX_RACES> raceStatModifiers;

        uint32 oldMSTime = getMSTime();

        //                                                          0       1         2        3         4        5
        QueryResult raceStatsResult  = WorldDatabase.Query("SELECT Race, Strength, Agility, Stamina, Intellect, Spirit FROM player_race_stats");

        if (!raceStatsResult)
        {
            LOG_WARN("server.loading", ">> Loaded 0 race stats definitions. DB table `player_race_stats` is empty.");
            LOG_INFO("server.loading", " ");
            exit(1);
        }

        do
        {
            Field* fields = raceStatsResult->Fetch();

            uint32 current_race = fields[0].Get<uint8>();
            if (current_race >= MAX_RACES)
            {
                LOG_ERROR("sql.sql", "Wrong race {} in `player_race_stats` table, ignoring.", current_race);
                continue;
            }

            for (uint32 i = 0; i < MAX_STATS; ++i)
                raceStatModifiers[current_race].StatModifier[i] = fields[i + 1].Get<int16>();

        } while (raceStatsResult->NextRow());

        //                                                 0      1       2         3        4         5        6       7        8
        QueryResult result = WorldDatabase.Query("SELECT Class, Level, Strength, Agility, Stamina, Intellect, Spirit, BaseHP, BaseMana FROM player_class_stats");

        if (!result)
        {
            LOG_ERROR("server.loading", ">> Loaded 0 level stats definitions. DB table `player_class_stats` is empty.");
            exit(1);
        }

        uint32 count = 0;

        do
        {
            Field* fields = result->Fetch();

            uint32 current_class = fields[0].Get<uint8>();
            if (current_class >= MAX_CLASSES)
            {
                LOG_ERROR("sql.sql", "Wrong class {} in `player_class_stats` table, ignoring.", current_class);
                continue;
            }

            uint32 current_level = fields[1].Get<uint8>();
            if (current_level > sWorld->getIntConfig(CONFIG_MAX_PLAYER_LEVEL))
            {
                if (current_level > STRONG_MAX_LEVEL) // hardcoded level maximum
                    LOG_ERROR("sql.sql", "Wrong (> {}) level {} in `player_class_stats` table, ignoring.", STRONG_MAX_LEVEL, current_level);
                else
                    LOG_DEBUG("sql.sql", "Unused (> MaxPlayerLevel in worldserver.conf) level {} in `player_class_stats` table, ignoring.", current_level);

                continue;
            }

            for (std::size_t race = 0; race < raceStatModifiers.size(); ++race)
            {
                if (PlayerInfo* info = _playerInfo[race][current_class])
                {
                    if (!info->levelInfo)
                        info->levelInfo = new PlayerLevelInfo[sWorld->getIntConfig(CONFIG_MAX_PLAYER_LEVEL)];

                    PlayerLevelInfo& levelInfo = info->levelInfo[current_level - 1];
                    for (int i = 0; i < MAX_STATS; ++i)
                        levelInfo.stats[i] = fields[i + 2].Get<uint16>() + raceStatModifiers[race].StatModifier[i];
                }
            }

            PlayerClassInfo* info = _playerClassInfo[current_class];
            if (!info)
            {
                info = new PlayerClassInfo();
                info->levelInfo = new PlayerClassLevelInfo[sWorld->getIntConfig(CONFIG_MAX_PLAYER_LEVEL)];
                _playerClassInfo[current_class] = info;
            }

            PlayerClassLevelInfo& levelInfo = info->levelInfo[current_level - 1];

            levelInfo.basehealth = fields[7].Get<uint32>();
            levelInfo.basemana = fields[8].Get<uint32>();

            ++count;
        } while (result->NextRow());

        // Fill gaps and check integrity
        for (int race = 0; race < MAX_RACES; ++race)
        {
            // skip non existed races
            if (!sChrRacesStore.LookupEntry(race))
                continue;

            for (int class_ = 0; class_ < MAX_CLASSES; ++class_)
            {
                // skip non existed classes
                if (!sChrClassesStore.LookupEntry(class_))
                    continue;

                PlayerClassInfo* pClassInfo = _playerClassInfo[class_];
                PlayerInfo* info = _playerInfo[race][class_];
                if (!info)
                    continue;

                // skip expansion races if not playing with expansion
                if (sWorld->getIntConfig(CONFIG_EXPANSION) < EXPANSION_THE_BURNING_CRUSADE && (race == RACE_BLOODELF || race == RACE_DRAENEI))
                    continue;

                // skip expansion classes if not playing with expansion
                if (sWorld->getIntConfig(CONFIG_EXPANSION) < EXPANSION_WRATH_OF_THE_LICH_KING && class_ == CLASS_DEATH_KNIGHT)
                    continue;

                // fatal error if no initial stats data
                if (!info->levelInfo || (info->levelInfo[sWorld->getIntConfig(CONFIG_START_PLAYER_LEVEL) - 1].stats[0] == 0 && class_ != CLASS_DEATH_KNIGHT) || (info->levelInfo[sWorld->getIntConfig(CONFIG_START_HEROIC_PLAYER_LEVEL) - 1].stats[0] == 0 && class_ == CLASS_DEATH_KNIGHT))
                {
                    LOG_ERROR("sql.sql", "Race {} class {} initial level does not have stats data!", race, class_);
                    exit(1);
                }

                // fatal error if no initial health/mana data
                if (!pClassInfo->levelInfo || (pClassInfo->levelInfo[sWorld->getIntConfig(CONFIG_START_PLAYER_LEVEL) - 1].basehealth == 0 && class_ != CLASS_DEATH_KNIGHT) || (pClassInfo->levelInfo[sWorld->getIntConfig(CONFIG_START_HEROIC_PLAYER_LEVEL) - 1].basehealth == 0 && class_ == CLASS_DEATH_KNIGHT))
                {
                    LOG_ERROR("sql.sql", "Class {} initial level does not have health/mana data!", class_);
                    exit(1);
                }

                // fill level gaps for stats
                for (uint8 level = 1; level < sWorld->getIntConfig(CONFIG_MAX_PLAYER_LEVEL); ++level)
                {
                    if ((info->levelInfo[level].stats[0] == 0 && class_ != CLASS_DEATH_KNIGHT) || (level >= sWorld->getIntConfig(CONFIG_START_HEROIC_PLAYER_LEVEL) && info->levelInfo[level].stats[0] == 0 && class_ == CLASS_DEATH_KNIGHT))
                    {
                        LOG_ERROR("sql.sql", "Race {} class {} level {} does not have stats data. Using stats data of level {}.", race, class_, level + 1, level);
                        info->levelInfo[level] = info->levelInfo[level - 1];
                    }
                }

                // fill level gaps for health/mana
                for (uint8 level = 1; level < sWorld->getIntConfig(CONFIG_MAX_PLAYER_LEVEL); ++level)
                {
                    if ((pClassInfo->levelInfo[level].basehealth == 0 && class_ != CLASS_DEATH_KNIGHT) || (level >= sWorld->getIntConfig(CONFIG_START_HEROIC_PLAYER_LEVEL) && pClassInfo->levelInfo[level].basehealth == 0 && class_ == CLASS_DEATH_KNIGHT))
                    {
                        LOG_ERROR("sql.sql", "Class {} level {} does not have health/mana data. Using stats data of level {}.", class_, level + 1, level);
                        pClassInfo->levelInfo[level] = pClassInfo->levelInfo[level - 1];
                    }
                }
            }
        }

        LOG_INFO("server.loading", ">> Loaded {} Level Stats Definitions in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
        LOG_INFO("server.loading", " ");
    }

    // Loading xp per level data
    LOG_INFO("server.loading", "Loading Player Create XP Data...");
    {
        uint32 oldMSTime = getMSTime();

        _playerXPperLevel.resize(sWorld->getIntConfig(CONFIG_MAX_PLAYER_LEVEL));
        for (uint8 level = 0; level < sWorld->getIntConfig(CONFIG_MAX_PLAYER_LEVEL); ++level)
            _playerXPperLevel[level] = 0;

        //                                                 0    1
        QueryResult result  = WorldDatabase.Query("SELECT Level, Experience FROM player_xp_for_level");

        if (!result)
        {
            LOG_WARN("server.loading", ">> Loaded 0 xp for level definitions. DB table `player_xp_for_level` is empty.");
            LOG_INFO("server.loading", " ");
            exit(1);
        }

        uint32 count = 0;

        do
        {
            Field* fields = result->Fetch();

            uint32 current_level = fields[0].Get<uint8>();
            uint32 current_xp    = fields[1].Get<uint32>();

            if (current_level >= sWorld->getIntConfig(CONFIG_MAX_PLAYER_LEVEL))
            {
                if (current_level > STRONG_MAX_LEVEL)        // hardcoded level maximum
                    LOG_ERROR("sql.sql", "Wrong (> {}) level {} in `player_xp_for_level` table, ignoring.", STRONG_MAX_LEVEL, current_level);
                else
                {
                    LOG_DEBUG("sql.sql", "Unused (> MaxPlayerLevel in worldserver.conf) level {} in `player_xp_for_levels` table, ignoring.", current_level);
                    ++count;                                // make result loading percent "expected" correct in case disabled detail mode for example.
                }
                continue;
            }
            //PlayerXPperLevel
            _playerXPperLevel[current_level] = current_xp;
            ++count;
        } while (result->NextRow());

        // fill level gaps
        for (uint8 level = 1; level < sWorld->getIntConfig(CONFIG_MAX_PLAYER_LEVEL); ++level)
        {
            if (_playerXPperLevel[level] == 0)
            {
                LOG_ERROR("sql.sql", "Level {} does not have XP for level data. Using data of level [{}] + 100.", level + 1, level);
                _playerXPperLevel[level] = _playerXPperLevel[level - 1] + 100;
            }
        }

        LOG_INFO("server.loading", ">> Loaded {} XP For Level Definitions in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
        LOG_INFO("server.loading", " ");
    }
}

void ObjectMgr::GetPlayerClassLevelInfo(uint32 class_, uint8 level, PlayerClassLevelInfo* info) const
{
    if (level < 1 || class_ >= MAX_CLASSES)
        return;

    PlayerClassInfo const* pInfo = _playerClassInfo[class_];

    if (level > sWorld->getIntConfig(CONFIG_MAX_PLAYER_LEVEL))
        level = sWorld->getIntConfig(CONFIG_MAX_PLAYER_LEVEL);

    *info = pInfo->levelInfo[level - 1];
}

void ObjectMgr::GetPlayerLevelInfo(uint32 race, uint32 class_, uint8 level, PlayerLevelInfo* info) const
{
    if (level < 1 || race >= MAX_RACES || class_ >= MAX_CLASSES)
        return;

    PlayerInfo const* pInfo = _playerInfo[race][class_];
    if (!pInfo)
        return;

    if (level <= sWorld->getIntConfig(CONFIG_MAX_PLAYER_LEVEL))
        *info = pInfo->levelInfo[level - 1];
    else
        BuildPlayerLevelInfo(race, class_, level, info);
}

void ObjectMgr::BuildPlayerLevelInfo(uint8 race, uint8 _class, uint8 level, PlayerLevelInfo* info) const
{
    // base data (last known level)
    *info = _playerInfo[race][_class]->levelInfo[sWorld->getIntConfig(CONFIG_MAX_PLAYER_LEVEL) - 1];

    // if conversion from uint32 to uint8 causes unexpected behaviour, change lvl to uint32
    for (uint8 lvl = sWorld->getIntConfig(CONFIG_MAX_PLAYER_LEVEL) - 1; lvl < level; ++lvl)
    {
        switch (_class)
        {
            case CLASS_WARRIOR:
                info->stats[STAT_STRENGTH]  += (lvl > 23 ? 2 : (lvl > 1  ? 1 : 0));
                info->stats[STAT_STAMINA]   += (lvl > 23 ? 2 : (lvl > 1  ? 1 : 0));
                info->stats[STAT_AGILITY]   += (lvl > 36 ? 1 : (lvl > 6 && (lvl % 2) ? 1 : 0));
                info->stats[STAT_INTELLECT] += (lvl > 9 && !(lvl % 2) ? 1 : 0);
                info->stats[STAT_SPIRIT]    += (lvl > 9 && !(lvl % 2) ? 1 : 0);
                break;
            case CLASS_PALADIN:
                info->stats[STAT_STRENGTH]  += (lvl > 3  ? 1 : 0);
                info->stats[STAT_STAMINA]   += (lvl > 33 ? 2 : (lvl > 1 ? 1 : 0));
                info->stats[STAT_AGILITY]   += (lvl > 38 ? 1 : (lvl > 7 && !(lvl % 2) ? 1 : 0));
                info->stats[STAT_INTELLECT] += (lvl > 6 && (lvl % 2) ? 1 : 0);
                info->stats[STAT_SPIRIT]    += (lvl > 7 ? 1 : 0);
                break;
            case CLASS_HUNTER:
                info->stats[STAT_STRENGTH]  += (lvl > 4  ? 1 : 0);
                info->stats[STAT_STAMINA]   += (lvl > 4  ? 1 : 0);
                info->stats[STAT_AGILITY]   += (lvl > 33 ? 2 : (lvl > 1 ? 1 : 0));
                info->stats[STAT_INTELLECT] += (lvl > 8 && (lvl % 2) ? 1 : 0);
                info->stats[STAT_SPIRIT]    += (lvl > 38 ? 1 : (lvl > 9 && !(lvl % 2) ? 1 : 0));
                break;
            case CLASS_ROGUE:
                info->stats[STAT_STRENGTH]  += (lvl > 5  ? 1 : 0);
                info->stats[STAT_STAMINA]   += (lvl > 4  ? 1 : 0);
                info->stats[STAT_AGILITY]   += (lvl > 16 ? 2 : (lvl > 1 ? 1 : 0));
                info->stats[STAT_INTELLECT] += (lvl > 8 && !(lvl % 2) ? 1 : 0);
                info->stats[STAT_SPIRIT]    += (lvl > 38 ? 1 : (lvl > 9 && !(lvl % 2) ? 1 : 0));
                break;
            case CLASS_PRIEST:
                info->stats[STAT_STRENGTH]  += (lvl > 9 && !(lvl % 2) ? 1 : 0);
                info->stats[STAT_STAMINA]   += (lvl > 5  ? 1 : 0);
                info->stats[STAT_AGILITY]   += (lvl > 38 ? 1 : (lvl > 8 && (lvl % 2) ? 1 : 0));
                info->stats[STAT_INTELLECT] += (lvl > 22 ? 2 : (lvl > 1 ? 1 : 0));
                info->stats[STAT_SPIRIT]    += (lvl > 3  ? 1 : 0);
                break;
            case CLASS_SHAMAN:
                info->stats[STAT_STRENGTH]  += (lvl > 34 ? 1 : (lvl > 6 && (lvl % 2) ? 1 : 0));
                info->stats[STAT_STAMINA]   += (lvl > 4 ? 1 : 0);
                info->stats[STAT_AGILITY]   += (lvl > 7 && !(lvl % 2) ? 1 : 0);
                info->stats[STAT_INTELLECT] += (lvl > 5 ? 1 : 0);
                info->stats[STAT_SPIRIT]    += (lvl > 4 ? 1 : 0);
                break;
            case CLASS_MAGE:
                info->stats[STAT_STRENGTH]  += (lvl > 9 && !(lvl % 2) ? 1 : 0);
                info->stats[STAT_STAMINA]   += (lvl > 5  ? 1 : 0);
                info->stats[STAT_AGILITY]   += (lvl > 9 && !(lvl % 2) ? 1 : 0);
                info->stats[STAT_INTELLECT] += (lvl > 24 ? 2 : (lvl > 1 ? 1 : 0));
                info->stats[STAT_SPIRIT]    += (lvl > 33 ? 2 : (lvl > 2 ? 1 : 0));
                break;
            case CLASS_WARLOCK:
                info->stats[STAT_STRENGTH]  += (lvl > 9 && !(lvl % 2) ? 1 : 0);
                info->stats[STAT_STAMINA]   += (lvl > 38 ? 2 : (lvl > 3 ? 1 : 0));
                info->stats[STAT_AGILITY]   += (lvl > 9 && !(lvl % 2) ? 1 : 0);
                info->stats[STAT_INTELLECT] += (lvl > 33 ? 2 : (lvl > 2 ? 1 : 0));
                info->stats[STAT_SPIRIT]    += (lvl > 38 ? 2 : (lvl > 3 ? 1 : 0));
                break;
            case CLASS_DRUID:
                info->stats[STAT_STRENGTH]  += (lvl > 38 ? 2 : (lvl > 6 && (lvl % 2) ? 1 : 0));
                info->stats[STAT_STAMINA]   += (lvl > 32 ? 2 : (lvl > 4 ? 1 : 0));
                info->stats[STAT_AGILITY]   += (lvl > 38 ? 2 : (lvl > 8 && (lvl % 2) ? 1 : 0));
                info->stats[STAT_INTELLECT] += (lvl > 38 ? 3 : (lvl > 4 ? 1 : 0));
                info->stats[STAT_SPIRIT]    += (lvl > 38 ? 3 : (lvl > 5 ? 1 : 0));
        }
    }
}

void ObjectMgr::LoadQuests()
{
    uint32 oldMSTime = getMSTime();

    // For reload case
    for (QuestMap::const_iterator itr = _questTemplates.begin(); itr != _questTemplates.end(); ++itr)
        delete itr->second;
    _questTemplates.clear();

    mExclusiveQuestGroups.clear();

    QueryResult result = WorldDatabase.Query("SELECT "
                         //0      1         2           3           4           5             6                 7            8
                         "ID, QuestType, QuestLevel, MinLevel, QuestSortID, QuestInfoID, SuggestedGroupNum, TimeAllowed, AllowableRaces,"
                         //      9                     10                   11                    12
                         "RequiredFactionId1, RequiredFactionId2, RequiredFactionValue1, RequiredFactionValue2, "
                         //      13                14              15             16                 17                18                 19           20           21
                         "RewardNextQuest, RewardXPDifficulty, RewardMoney, RewardMoneyDifficulty, RewardBonusMoney,  RewardDisplaySpell, RewardSpell, RewardHonor, RewardKillHonor, "
                         //   22       23       24              25                26               27
                         "StartItem, Flags, RewardTitle, RequiredPlayerKills, RewardTalents, RewardArenaPoints, "
                         //    28           29           30          31            32              33            34             35
                         "RewardItem1, RewardAmount1, RewardItem2, RewardAmount2, RewardItem3, RewardAmount3, RewardItem4, RewardAmount4, "
                         //        36                      37                      38                      39                      40                      41                      42                      43                      44                      45                     46                      47
                         "RewardChoiceItemID1, RewardChoiceItemQuantity1, RewardChoiceItemID2, RewardChoiceItemQuantity2, RewardChoiceItemID3, RewardChoiceItemQuantity3, RewardChoiceItemID4, RewardChoiceItemQuantity4, RewardChoiceItemID5, RewardChoiceItemQuantity5, RewardChoiceItemID6, RewardChoiceItemQuantity6, "
                         //       48                 49                     50                  51                  52                     53                 54                  55                     56                  57                  58                    59                   60                 61                      62
                         "RewardFactionID1, RewardFactionValue1, RewardFactionOverride1, RewardFactionID2, RewardFactionValue2, RewardFactionOverride2, RewardFactionID3, RewardFactionValue3, RewardFactionOverride3, RewardFactionID4, RewardFactionValue4, RewardFactionOverride4, RewardFactionID5, RewardFactionValue5,  RewardFactionOverride5,"
                         //   62        64      65        66
                         "POIContinent, POIx, POIy, POIPriority, "
                         //   67          68               69           70                    71
                         "LogTitle, LogDescription, QuestDescription, AreaDescription, QuestCompletionLog, "
                         //      72                73                74                75                   76                     77                    78                      79
                         "RequiredNpcOrGo1, RequiredNpcOrGo2, RequiredNpcOrGo3, RequiredNpcOrGo4, RequiredNpcOrGoCount1, RequiredNpcOrGoCount2, RequiredNpcOrGoCount3, RequiredNpcOrGoCount4, "
                         //  80          81         82         83           84                  85                 86                  87
                         "ItemDrop1, ItemDrop2, ItemDrop3, ItemDrop4, ItemDropQuantity1, ItemDropQuantity2, ItemDropQuantity3, ItemDropQuantity4, "
                         //      88               89               90               91               92               93                94                  95                  96                  97                  98                  99
                         "RequiredItemId1, RequiredItemId2, RequiredItemId3, RequiredItemId4, RequiredItemId5, RequiredItemId6, RequiredItemCount1, RequiredItemCount2, RequiredItemCount3, RequiredItemCount4, RequiredItemCount5, RequiredItemCount6, "
                         //  100          101             102             103             104
                         "Unknown0, ObjectiveText1, ObjectiveText2, ObjectiveText3, ObjectiveText4"
                         " FROM quest_template");
    if (!result)
    {
        LOG_WARN("server.loading", ">> Loaded 0 quests definitions. DB table `quest_template` is empty.");
        LOG_INFO("server.loading", " ");
        return;
    }

    // create multimap previous quest for each existed quest
    // some quests can have many previous maps set by NextQuestId in previous quest
    // for example set of race quests can lead to single not race specific quest
    do
    {
        Field* fields = result->Fetch();

        Quest* newQuest = new Quest(fields);
        _questTemplates[newQuest->GetQuestId()] = newQuest;
    } while (result->NextRow());

    // pussywizard:
    {
        uint32 max = 0;
        for (QuestMap::const_iterator itr = _questTemplates.begin(); itr != _questTemplates.end(); ++itr)
            if (itr->first > max)
                max = itr->first;
        if (max)
        {
            _questTemplatesFast.clear();
            _questTemplatesFast.resize(max + 1, nullptr);
            for (QuestMap::iterator itr = _questTemplates.begin(); itr != _questTemplates.end(); ++itr)
                _questTemplatesFast[itr->first] = itr->second;
        }
    }

    for (QuestMap::iterator itr = _questTemplates.begin(); itr != _questTemplates.end(); ++itr)
        itr->second->InitializeQueryData();

    std::map<uint32, uint32> usedMailTemplates;

    // Load `quest_details`
    //                                   0   1       2       3       4       5            6            7            8
    result = WorldDatabase.Query("SELECT ID, Emote1, Emote2, Emote3, Emote4, EmoteDelay1, EmoteDelay2, EmoteDelay3, EmoteDelay4 FROM quest_details");

    if (!result)
    {
        LOG_WARN("server.loading", ">> Loaded 0 quest details. DB table `quest_details` is empty.");
    }
    else
    {
        do
        {
            Field* fields = result->Fetch();
            uint32 questId = fields[0].Get<uint32>();

            auto itr = _questTemplates.find(questId);
            if (itr != _questTemplates.end())
                itr->second->LoadQuestDetails(fields);
            else
                LOG_ERROR("sql.sql", "Table `quest_details` has data for quest {} but such quest does not exist", questId);
        } while (result->NextRow());
    }

    // Load `quest_request_items`
    //                                   0   1                2                  3
    result = WorldDatabase.Query("SELECT ID, EmoteOnComplete, EmoteOnIncomplete, CompletionText FROM quest_request_items");

    if (!result)
    {
        LOG_WARN("server.loading", ">> Loaded 0 quest request items. DB table `quest_request_items` is empty.");
    }
    else
    {
        do
        {
            Field* fields = result->Fetch();
            uint32 questId = fields[0].Get<uint32>();

            auto itr = _questTemplates.find(questId);
            if (itr != _questTemplates.end())
                itr->second->LoadQuestRequestItems(fields);
            else
                LOG_ERROR("sql.sql", "Table `quest_request_items` has data for quest {} but such quest does not exist", questId);
        } while (result->NextRow());
    }

    // Load `quest_offer_reward`
    //                                   0   1       2       3       4       5            6            7            8            9
    result = WorldDatabase.Query("SELECT ID, Emote1, Emote2, Emote3, Emote4, EmoteDelay1, EmoteDelay2, EmoteDelay3, EmoteDelay4, RewardText FROM quest_offer_reward");

    if (!result)
    {
        LOG_WARN("server.loading", ">> Loaded 0 quest reward emotes. DB table `quest_offer_reward` is empty.");
    }
    else
    {
        do
        {
            Field* fields = result->Fetch();
            uint32 questId = fields[0].Get<uint32>();

            auto itr = _questTemplates.find(questId);
            if (itr != _questTemplates.end())
                itr->second->LoadQuestOfferReward(fields);
            else
                LOG_ERROR("sql.sql", "Table `quest_offer_reward` has data for quest {} but such quest does not exist", questId);
        } while (result->NextRow());
    }

    // Load `quest_template_addon`
    //                                   0   1         2                 3              4            5            6               7                     8
    result = WorldDatabase.Query("SELECT ID, MaxLevel, AllowableClasses, SourceSpellID, PrevQuestID, NextQuestID, ExclusiveGroup, RewardMailTemplateID, RewardMailDelay, "
                                 //9               10                   11                     12                     13                   14                   15                 16                     17
                                 "RequiredSkillID, RequiredSkillPoints, RequiredMinRepFaction, RequiredMaxRepFaction, RequiredMinRepValue, RequiredMaxRepValue, ProvidedItemCount, RewardMailSenderEntry, SpecialFlags FROM quest_template_addon LEFT JOIN quest_mail_sender ON Id=QuestId");

    if (!result)
    {
        LOG_WARN("server.loading", ">> Loaded 0 quest template addons. DB table `quest_template_addon` is empty.");
    }
    else
    {
        do
        {
            Field* fields = result->Fetch();
            uint32 questId = fields[0].Get<uint32>();

            auto itr = _questTemplates.find(questId);
            if (itr != _questTemplates.end())
                itr->second->LoadQuestTemplateAddon(fields);
            else
                LOG_ERROR("sql.sql", "Table `quest_template_addon` has data for quest {} but such quest does not exist", questId);
        } while (result->NextRow());
    }

    // Post processing
    for (QuestMap::iterator iter = _questTemplates.begin(); iter != _questTemplates.end(); ++iter)
    {
        // skip post-loading checks for disabled quests
        if (DisableMgr::IsDisabledFor(DISABLE_TYPE_QUEST, iter->first, nullptr))
            continue;

        Quest* qinfo = iter->second;

        // additional quest integrity checks (GO, creature_template and item_template must be loaded already)

        if (qinfo->GetQuestMethod() >= 3)
            LOG_ERROR("sql.sql", "Quest {} has `Method` = {}, expected values are 0, 1 or 2.", qinfo->GetQuestId(), qinfo->GetQuestMethod());

        if (qinfo->SpecialFlags & ~QUEST_SPECIAL_FLAGS_DB_ALLOWED)
        {
            LOG_ERROR("sql.sql", "Quest {} has `SpecialFlags` = {} > max allowed value. Correct `SpecialFlags` to value <= {}",
                             qinfo->GetQuestId(), qinfo->SpecialFlags, QUEST_SPECIAL_FLAGS_DB_ALLOWED);
            qinfo->SpecialFlags &= QUEST_SPECIAL_FLAGS_DB_ALLOWED;
        }

        if (qinfo->Flags & QUEST_FLAGS_DAILY && qinfo->Flags & QUEST_FLAGS_WEEKLY)
        {
            LOG_ERROR("sql.sql", "Weekly Quest {} is marked as daily quest in `Flags`, removed daily flag.", qinfo->GetQuestId());
            qinfo->Flags &= ~QUEST_FLAGS_DAILY;
        }

        if (qinfo->Flags & QUEST_FLAGS_DAILY)
        {
            if (!(qinfo->SpecialFlags & QUEST_SPECIAL_FLAGS_REPEATABLE))
            {
                LOG_ERROR("sql.sql", "Daily Quest {} not marked as repeatable in `SpecialFlags`, added.", qinfo->GetQuestId());
                qinfo->SpecialFlags |= QUEST_SPECIAL_FLAGS_REPEATABLE;
            }
        }

        if (qinfo->Flags & QUEST_FLAGS_WEEKLY)
        {
            if (!(qinfo->SpecialFlags & QUEST_SPECIAL_FLAGS_REPEATABLE))
            {
                LOG_ERROR("sql.sql", "Weekly Quest {} not marked as repeatable in `SpecialFlags`, added.", qinfo->GetQuestId());
                qinfo->SpecialFlags |= QUEST_SPECIAL_FLAGS_REPEATABLE;
            }
        }

        if (qinfo->SpecialFlags & QUEST_SPECIAL_FLAGS_MONTHLY)
        {
            if (!(qinfo->SpecialFlags & QUEST_SPECIAL_FLAGS_REPEATABLE))
            {
                LOG_ERROR("sql.sql", "Monthly quest {} not marked as repeatable in `SpecialFlags`, added.", qinfo->GetQuestId());
                qinfo->SpecialFlags |= QUEST_SPECIAL_FLAGS_REPEATABLE;
            }
        }

        if (qinfo->Flags & QUEST_FLAGS_TRACKING)
        {
            // at auto-reward can be rewarded only RewardChoiceItemId[0]
            for (int j = 1; j < QUEST_REWARD_CHOICES_COUNT; ++j )
            {
                if (uint32 id = qinfo->RewardChoiceItemId[j])
                {
                    LOG_ERROR("sql.sql", "Quest {} has `RewardChoiceItemId{}` = {} but item from `RewardChoiceItemId{}` can't be rewarded with quest flag QUEST_FLAGS_TRACKING.",
                                     qinfo->GetQuestId(), j + 1, id, j + 1);
                    // no changes, quest ignore this data
                }
            }
        }

        // client quest log visual (area case)
        if (qinfo->ZoneOrSort > 0)
        {
            if (!sAreaTableStore.LookupEntry(qinfo->ZoneOrSort))
            {
                LOG_ERROR("sql.sql", "Quest {} has `ZoneOrSort` = {} (zone case) but zone with this id does not exist.",
                                 qinfo->GetQuestId(), qinfo->ZoneOrSort);
                // no changes, quest not dependent from this value but can have problems at client
            }
        }
        // client quest log visual (sort case)
        if (qinfo->ZoneOrSort < 0)
        {
            QuestSortEntry const* qSort = sQuestSortStore.LookupEntry(-int32(qinfo->ZoneOrSort));
            if (!qSort)
            {
                LOG_ERROR("sql.sql", "Quest {} has `ZoneOrSort` = {} (sort case) but quest sort with this id does not exist.",
                                 qinfo->GetQuestId(), qinfo->ZoneOrSort);
                // no changes, quest not dependent from this value but can have problems at client (note some may be 0, we must allow this so no check)
            }
            //check for proper RequiredSkillId value (skill case)
            if (uint32 skill_id = SkillByQuestSort(-int32(qinfo->ZoneOrSort)))
            {
                if (qinfo->RequiredSkillId != skill_id)
                {
                    LOG_ERROR("sql.sql", "Quest {} has `ZoneOrSort` = {} but `RequiredSkillId` does not have a corresponding value ({}).",
                                     qinfo->GetQuestId(), qinfo->ZoneOrSort, skill_id);
                    //override, and force proper value here?
                }
            }
        }

        // RequiredClasses, can be 0/CLASSMASK_ALL_PLAYABLE to allow any class
        if (qinfo->RequiredClasses)
        {
            if (!(qinfo->RequiredClasses & CLASSMASK_ALL_PLAYABLE))
            {
                LOG_ERROR("sql.sql", "Quest {} does not contain any playable classes in `RequiredClasses` ({}), value set to 0 (all classes).", qinfo->GetQuestId(), qinfo->RequiredClasses);
                qinfo->RequiredClasses = 0;
            }
        }
        // AllowableRaces, can be 0/RACEMASK_ALL_PLAYABLE to allow any race
        if (qinfo->AllowableRaces)
        {
            if (!(qinfo->AllowableRaces & RACEMASK_ALL_PLAYABLE))
            {
                LOG_ERROR("sql.sql", "Quest {} does not contain any playable races in `AllowableRaces` ({}), value set to 0 (all races).", qinfo->GetQuestId(), qinfo->AllowableRaces);
                qinfo->AllowableRaces = 0;
            }
        }
        // RequiredSkillId, can be 0
        if (qinfo->RequiredSkillId)
        {
            if (!sSkillLineStore.LookupEntry(qinfo->RequiredSkillId))
            {
                LOG_ERROR("sql.sql", "Quest {} has `RequiredSkillId` = {} but this skill does not exist",
                                 qinfo->GetQuestId(), qinfo->RequiredSkillId);
            }
        }

        if (qinfo->RequiredSkillPoints)
        {
            if (qinfo->RequiredSkillPoints > sWorld->GetConfigMaxSkillValue())
            {
                LOG_ERROR("sql.sql", "Quest {} has `RequiredSkillPoints` = {} but max possible skill is {}, quest can't be done.",
                                 qinfo->GetQuestId(), qinfo->RequiredSkillPoints, sWorld->GetConfigMaxSkillValue());
                // no changes, quest can't be done for this requirement
            }
        }
        // else Skill quests can have 0 skill level, this is ok

        if (qinfo->RequiredFactionId2 && !sFactionStore.LookupEntry(qinfo->RequiredFactionId2))
        {
            LOG_ERROR("sql.sql", "Quest {} has `RequiredFactionId2` = {} but faction template {} does not exist, quest can't be done.",
                             qinfo->GetQuestId(), qinfo->RequiredFactionId2, qinfo->RequiredFactionId2);
            // no changes, quest can't be done for this requirement
        }

        if (qinfo->RequiredFactionId1 && !sFactionStore.LookupEntry(qinfo->RequiredFactionId1))
        {
            LOG_ERROR("sql.sql", "Quest {} has `RequiredFactionId1` = {} but faction template {} does not exist, quest can't be done.",
                             qinfo->GetQuestId(), qinfo->RequiredFactionId1, qinfo->RequiredFactionId1);
            // no changes, quest can't be done for this requirement
        }

        if (qinfo->RequiredMinRepFaction && !sFactionStore.LookupEntry(qinfo->RequiredMinRepFaction))
        {
            LOG_ERROR("sql.sql", "Quest {} has `RequiredMinRepFaction` = {} but faction template {} does not exist, quest can't be done.",
                             qinfo->GetQuestId(), qinfo->RequiredMinRepFaction, qinfo->RequiredMinRepFaction);
            // no changes, quest can't be done for this requirement
        }

        if (qinfo->RequiredMaxRepFaction && !sFactionStore.LookupEntry(qinfo->RequiredMaxRepFaction))
        {
            LOG_ERROR("sql.sql", "Quest {} has `RequiredMaxRepFaction` = {} but faction template {} does not exist, quest can't be done.",
                             qinfo->GetQuestId(), qinfo->RequiredMaxRepFaction, qinfo->RequiredMaxRepFaction);
            // no changes, quest can't be done for this requirement
        }

        if (qinfo->RequiredMinRepValue && qinfo->RequiredMinRepValue > ReputationMgr::Reputation_Cap)
        {
            LOG_ERROR("sql.sql", "Quest {} has `RequiredMinRepValue` = {} but max reputation is {}, quest can't be done.",
                             qinfo->GetQuestId(), qinfo->RequiredMinRepValue, ReputationMgr::Reputation_Cap);
            // no changes, quest can't be done for this requirement
        }

        if (qinfo->RequiredMinRepValue && qinfo->RequiredMaxRepValue && qinfo->RequiredMaxRepValue <= qinfo->RequiredMinRepValue)
        {
            LOG_ERROR("sql.sql", "Quest {} has `RequiredMaxRepValue` = {} and `RequiredMinRepValue` = {}, quest can't be done.",
                             qinfo->GetQuestId(), qinfo->RequiredMaxRepValue, qinfo->RequiredMinRepValue);
            // no changes, quest can't be done for this requirement
        }

        if (!qinfo->RequiredFactionId1 && qinfo->RequiredFactionValue1 != 0)
        {
            LOG_ERROR("sql.sql", "Quest {} has `RequiredFactionValue1` = {} but `RequiredFactionId1` is 0, value has no effect",
                             qinfo->GetQuestId(), qinfo->RequiredFactionValue1);
            // warning
        }

        if (!qinfo->RequiredFactionId2 && qinfo->RequiredFactionValue2 != 0)
        {
            LOG_ERROR("sql.sql", "Quest {} has `RequiredFactionValue2` = {} but `RequiredFactionId2` is 0, value has no effect",
                             qinfo->GetQuestId(), qinfo->RequiredFactionValue2);
            // warning
        }

        if (!qinfo->RequiredMinRepFaction && qinfo->RequiredMinRepValue != 0)
        {
            LOG_ERROR("sql.sql", "Quest {} has `RequiredMinRepValue` = {} but `RequiredMinRepFaction` is 0, value has no effect",
                             qinfo->GetQuestId(), qinfo->RequiredMinRepValue);
            // warning
        }

        if (!qinfo->RequiredMaxRepFaction && qinfo->RequiredMaxRepValue != 0)
        {
            LOG_ERROR("sql.sql", "Quest {} has `RequiredMaxRepValue` = {} but `RequiredMaxRepFaction` is 0, value has no effect",
                             qinfo->GetQuestId(), qinfo->RequiredMaxRepValue);
            // warning
        }

        if (qinfo->RewardTitleId && !sCharTitlesStore.LookupEntry(qinfo->RewardTitleId))
        {
            LOG_ERROR("sql.sql", "Quest {} has `RewardTitleId` = {} but CharTitle Id {} does not exist, quest can't be rewarded with title.",
                             qinfo->GetQuestId(), qinfo->GetCharTitleId(), qinfo->GetCharTitleId());
            qinfo->RewardTitleId = 0;
            // quest can't reward this title
        }

        if (qinfo->StartItem)
        {
            if (!sObjectMgr->GetItemTemplate(qinfo->StartItem))
            {
                LOG_ERROR("sql.sql", "Quest {} has `StartItem` = {} but item with entry {} does not exist, quest can't be done.",
                                 qinfo->GetQuestId(), qinfo->StartItem, qinfo->StartItem);
                qinfo->StartItem = 0;                       // quest can't be done for this requirement
            }
            else if (qinfo->StartItemCount == 0)
            {
                LOG_ERROR("sql.sql", "Quest {} has `StartItem` = {} but `StartItemCount` = 0, set to 1 but need fix in DB.",
                                 qinfo->GetQuestId(), qinfo->StartItem);
                qinfo->StartItemCount = 1;                    // update to 1 for allow quest work for backward compatibility with DB
            }
        }
        else if (qinfo->StartItemCount > 0)
        {
            LOG_ERROR("sql.sql", "Quest {} has `StartItem` = 0 but `StartItemCount` = {}, useless value.",
                             qinfo->GetQuestId(), qinfo->StartItemCount);
            qinfo->StartItemCount = 0;                          // no quest work changes in fact
        }

        if (qinfo->SourceSpellid)
        {
            SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(qinfo->SourceSpellid);
            if (!spellInfo)
            {
                LOG_ERROR("sql.sql", "Quest {} has `SourceSpellid` = {} but spell {} doesn't exist, quest can't be done.",
                                 qinfo->GetQuestId(), qinfo->SourceSpellid, qinfo->SourceSpellid);
                qinfo->SourceSpellid = 0;                        // quest can't be done for this requirement
            }
            else if (!SpellMgr::ComputeIsSpellValid(spellInfo))
            {
                LOG_ERROR("sql.sql", "Quest {} has `SourceSpellid` = {} but spell {} is broken, quest can't be done.",
                                 qinfo->GetQuestId(), qinfo->SourceSpellid, qinfo->SourceSpellid);
                qinfo->SourceSpellid = 0;                        // quest can't be done for this requirement
            }
        }

        for (uint8 j = 0; j < QUEST_ITEM_OBJECTIVES_COUNT; ++j)
        {
            uint32 id = qinfo->RequiredItemId[j];
            if (id)
            {
                if (qinfo->RequiredItemCount[j] == 0)
                {
                    LOG_ERROR("sql.sql", "Quest {} has `RequiredItemId{}` = {} but `RequiredItemCount{}` = 0, quest can't be done.",
                                     qinfo->GetQuestId(), j + 1, id, j + 1);
                    // no changes, quest can't be done for this requirement
                }

                qinfo->SetSpecialFlag(QUEST_SPECIAL_FLAGS_DELIVER);

                if (!sObjectMgr->GetItemTemplate(id))
                {
                    LOG_ERROR("sql.sql", "Quest {} has `RequiredItemId{}` = {} but item with entry {} does not exist, quest can't be done.",
                                     qinfo->GetQuestId(), j + 1, id, id);
                    qinfo->RequiredItemCount[j] = 0;             // prevent incorrect work of quest
                }
            }
            else if (qinfo->RequiredItemCount[j] > 0)
            {
                LOG_ERROR("sql.sql", "Quest {} has `RequiredItemId{}` = 0 but `RequiredItemCount{}` = {}, quest can't be done.",
                                 qinfo->GetQuestId(), j + 1, j + 1, qinfo->RequiredItemCount[j]);
                qinfo->RequiredItemCount[j] = 0;                 // prevent incorrect work of quest
            }
        }

        for (uint8 j = 0; j < QUEST_SOURCE_ITEM_IDS_COUNT; ++j)
        {
            uint32 id = qinfo->ItemDrop[j];
            if (id)
            {
                if (!sObjectMgr->GetItemTemplate(id))
                {
                    LOG_ERROR("sql.sql", "Quest {} has `ItemDrop{}` = {} but item with entry {} does not exist, quest can't be done.",
                                     qinfo->GetQuestId(), j + 1, id, id);
                    // no changes, quest can't be done for this requirement
                }
            }
            else
            {
                if (qinfo->ItemDropQuantity[j] > 0)
                {
                    LOG_ERROR("sql.sql", "Quest {} has `ItemDrop{}` = 0 but `ItemDropQuantity{}` = {}.",
                                     qinfo->GetQuestId(), j + 1, j + 1, qinfo->ItemDropQuantity[j]);
                    // no changes, quest ignore this data
                }
            }
        }

        for (uint8 j = 0; j < QUEST_OBJECTIVES_COUNT; ++j)
        {
            int32 id = qinfo->RequiredNpcOrGo[j];
            if (id < 0 && !sObjectMgr->GetGameObjectTemplate(-id))
            {
                LOG_ERROR("sql.sql", "Quest {} has `RequiredNpcOrGo{}` = {} but gameobject {} does not exist, quest can't be done.",
                                 qinfo->GetQuestId(), j + 1, id, uint32(-id));
                qinfo->RequiredNpcOrGo[j] = 0;            // quest can't be done for this requirement
            }

            if (id > 0 && !sObjectMgr->GetCreatureTemplate(id))
            {
                LOG_ERROR("sql.sql", "Quest {} has `RequiredNpcOrGo{}` = {} but creature with entry {} does not exist, quest can't be done.",
                                 qinfo->GetQuestId(), j + 1, id, uint32(id));
                qinfo->RequiredNpcOrGo[j] = 0;            // quest can't be done for this requirement
            }

            if (id)
            {
                // In fact SpeakTo and Kill are quite same: either you can speak to mob:SpeakTo or you can't:Kill/Cast

                qinfo->SetSpecialFlag(QUEST_SPECIAL_FLAGS_KILL | QUEST_SPECIAL_FLAGS_CAST | QUEST_SPECIAL_FLAGS_SPEAKTO);

                if (!qinfo->RequiredNpcOrGoCount[j])
                {
                    LOG_ERROR("sql.sql", "Quest {} has `RequiredNpcOrGo{}` = {} but `RequiredNpcOrGoCount{}` = 0, quest can't be done.",
                                     qinfo->GetQuestId(), j + 1, id, j + 1);
                    // no changes, quest can be incorrectly done, but we already report this
                }
            }
            else if (qinfo->RequiredNpcOrGoCount[j] > 0)
            {
                LOG_ERROR("sql.sql", "Quest {} has `RequiredNpcOrGo{}` = 0 but `RequiredNpcOrGoCount{}` = {}.",
                                 qinfo->GetQuestId(), j + 1, j + 1, qinfo->RequiredNpcOrGoCount[j]);
                // no changes, quest ignore this data
            }
        }

        for (uint8 j = 0; j < QUEST_REWARD_CHOICES_COUNT; ++j)
        {
            uint32 id = qinfo->RewardChoiceItemId[j];
            if (id)
            {
                if (!sObjectMgr->GetItemTemplate(id))
                {
                    LOG_ERROR("sql.sql", "Quest {} has `RewardChoiceItemId{}` = {} but item with entry {} does not exist, quest will not reward this item.",
                                     qinfo->GetQuestId(), j + 1, id, id);
                    qinfo->RewardChoiceItemId[j] = 0;          // no changes, quest will not reward this
                }

                if (!qinfo->RewardChoiceItemCount[j])
                {
                    LOG_ERROR("sql.sql", "Quest {} has `RewardChoiceItemId{}` = {} but `RewardChoiceItemCount{}` = 0, quest can't be done.",
                                     qinfo->GetQuestId(), j + 1, id, j + 1);
                    // no changes, quest can't be done
                }
            }
            else if (qinfo->RewardChoiceItemCount[j] > 0)
            {
                LOG_ERROR("sql.sql", "Quest {} has `RewardChoiceItemId{}` = 0 but `RewardChoiceItemCount{}` = {}.",
                                 qinfo->GetQuestId(), j + 1, j + 1, qinfo->RewardChoiceItemCount[j]);
                // no changes, quest ignore this data
            }
        }

        for (uint8 j = 0; j < QUEST_REWARDS_COUNT; ++j)
        {
            if (!qinfo->RewardItemId[0] && qinfo->RewardItemId[j])
            {
                LOG_ERROR("sql.sql", "Quest {} has no `RewardItemId1` but has `RewardItem{}`. Reward item will not be loaded.",
                                    qinfo->GetQuestId(), j + 1);
            }
            if (!qinfo->RewardItemId[1] && j > 1 && qinfo->RewardItemId[j])
            {
                LOG_ERROR("sql.sql", "Quest {} has no `RewardItemId2` but has `RewardItem{}`. Reward item will not be loaded.",
                                    qinfo->GetQuestId(), j + 1);
            }
            if (!qinfo->RewardItemId[2] && j > 2 && qinfo->RewardItemId[j])
            {
                LOG_ERROR("sql.sql", "Quest {} has no `RewardItemId3` but has `RewardItem{}`. Reward item will not be loaded.",
                                    qinfo->GetQuestId(), j + 1);
            }
        }

        for (uint8 j = 0; j < QUEST_REWARDS_COUNT; ++j)
        {
            uint32 id = qinfo->RewardItemId[j];
            if (id)
            {
                if (!sObjectMgr->GetItemTemplate(id))
                {
                    LOG_ERROR("sql.sql", "Quest {} has `RewardItemId{}` = {} but item with entry {} does not exist, quest will not reward this item.",
                                     qinfo->GetQuestId(), j + 1, id, id);
                    qinfo->RewardItemId[j] = 0;                // no changes, quest will not reward this item
                }

                if (!qinfo->RewardItemIdCount[j])
                {
                    LOG_ERROR("sql.sql", "Quest {} has `RewardItemId{}` = {} but `RewardItemIdCount{}` = 0, quest will not reward this item.",
                                     qinfo->GetQuestId(), j + 1, id, j + 1);
                    // no changes
                }
            }
            else if (qinfo->RewardItemIdCount[j] > 0)
            {
                LOG_ERROR("sql.sql", "Quest {} has `RewardItemId{}` = 0 but `RewardItemIdCount{}` = {}.",
                                 qinfo->GetQuestId(), j + 1, j + 1, qinfo->RewardItemIdCount[j]);
                // no changes, quest ignore this data
            }
        }

        for (uint8 j = 0; j < QUEST_REPUTATIONS_COUNT; ++j)
        {
            if (qinfo->RewardFactionId[j])
            {
                if (std::abs(qinfo->RewardFactionValueId[j]) > 9)
                {
                    LOG_ERROR("sql.sql", "Quest {} has RewardFactionValueId{} = {}. That is outside the range of valid values (-9 to 9).", qinfo->GetQuestId(), j + 1, qinfo->RewardFactionValueId[j]);
                }
                if (!sFactionStore.LookupEntry(qinfo->RewardFactionId[j]))
                {
                    LOG_ERROR("sql.sql", "Quest {} has `RewardFactionId{}` = {} but raw faction (faction.dbc) {} does not exist, quest will not reward reputation for this faction.", qinfo->GetQuestId(), j + 1, qinfo->RewardFactionId[j], qinfo->RewardFactionId[j]);
                    qinfo->RewardFactionId[j] = 0;            // quest will not reward this
                }
            }

            else if (qinfo->RewardFactionValueIdOverride[j] != 0)
            {
                LOG_ERROR("sql.sql", "Quest {} has `RewardFactionId{}` = 0 but `RewardFactionValueIdOverride{}` = {}.",
                                 qinfo->GetQuestId(), j + 1, j + 1, qinfo->RewardFactionValueIdOverride[j]);
                // no changes, quest ignore this data
            }
        }

        if (qinfo->RewardDisplaySpell)
        {
            SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(qinfo->RewardDisplaySpell);

            if (!spellInfo)
            {
                LOG_ERROR("sql.sql", "Quest {} has `RewardDisplaySpell` = {} but spell {} does not exist, spell removed as display reward.",
                                 qinfo->GetQuestId(), qinfo->RewardDisplaySpell, qinfo->RewardDisplaySpell);
                qinfo->RewardDisplaySpell = 0;                        // no spell reward will display for this quest
            }

            else if (!SpellMgr::ComputeIsSpellValid(spellInfo))
            {
                LOG_ERROR("sql.sql", "Quest {} has `RewardDisplaySpell` = {} but spell {} is broken, quest will not have a spell reward.",
                                 qinfo->GetQuestId(), qinfo->RewardDisplaySpell, qinfo->RewardDisplaySpell);
                qinfo->RewardDisplaySpell = 0;                        // no spell reward will display for this quest
            }

            else if (GetTalentSpellCost(qinfo->RewardDisplaySpell))
            {
                LOG_ERROR("sql.sql", "Quest {} has `RewardDisplaySpell` = {} but spell {} is talent, quest will not have a spell reward.",
                                 qinfo->GetQuestId(), qinfo->RewardDisplaySpell, qinfo->RewardDisplaySpell);
                qinfo->RewardDisplaySpell = 0;                        // no spell reward will display for this quest
            }
        }

        if (qinfo->RewardSpell > 0)
        {
            SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(qinfo->RewardSpell);

            if (!spellInfo)
            {
                LOG_ERROR("sql.sql", "Quest {} has `RewardSpell` = {} but spell {} does not exist, quest will not have a spell reward.",
                                 qinfo->GetQuestId(), qinfo->RewardSpell, qinfo->RewardSpell);
                qinfo->RewardSpell = 0;                    // no spell will be casted on player
            }

            else if (!SpellMgr::ComputeIsSpellValid(spellInfo))
            {
                LOG_ERROR("sql.sql", "Quest {} has `RewardSpell` = {} but spell {} is broken, quest will not have a spell reward.",
                                 qinfo->GetQuestId(), qinfo->RewardSpell, qinfo->RewardSpell);
                qinfo->RewardSpell = 0;                    // no spell will be casted on player
            }

            else if (GetTalentSpellCost(qinfo->RewardSpell))
            {
                LOG_ERROR("sql.sql", "Quest {} has `RewardDisplaySpell` = {} but spell {} is talent, quest will not have a spell reward.",
                                 qinfo->GetQuestId(), qinfo->RewardSpell, qinfo->RewardSpell);
                qinfo->RewardSpell = 0;                    // no spell will be casted on player
            }
        }

        if (qinfo->RewardMailTemplateId)
        {
            if (!sMailTemplateStore.LookupEntry(qinfo->RewardMailTemplateId))
            {
                LOG_ERROR("sql.sql", "Quest {} has `RewardMailTemplateId` = {} but mail template  {} does not exist, quest will not have a mail reward.",
                                 qinfo->GetQuestId(), qinfo->RewardMailTemplateId, qinfo->RewardMailTemplateId);
                qinfo->RewardMailTemplateId = 0;               // no mail will send to player
                qinfo->RewardMailDelay = 0;                // no mail will send to player
                qinfo->RewardMailSenderEntry = 0;
            }
            else if (usedMailTemplates.find(qinfo->RewardMailTemplateId) != usedMailTemplates.end())
            {
                std::map<uint32, uint32>::const_iterator used_mt_itr = usedMailTemplates.find(qinfo->RewardMailTemplateId);
                LOG_ERROR("sql.sql", "Quest {} has `RewardMailTemplateId` = {} but mail template  {} already used for quest {}, quest will not have a mail reward.",
                                 qinfo->GetQuestId(), qinfo->RewardMailTemplateId, qinfo->RewardMailTemplateId, used_mt_itr->second);
                qinfo->RewardMailTemplateId = 0;               // no mail will send to player
                qinfo->RewardMailDelay = 0;                // no mail will send to player
                qinfo->RewardMailSenderEntry = 0;
            }
            else
                usedMailTemplates[qinfo->RewardMailTemplateId] = qinfo->GetQuestId();
        }

        if (qinfo->RewardNextQuest)
        {
            QuestMap::iterator qNextItr = _questTemplates.find(qinfo->RewardNextQuest);
            if (qNextItr == _questTemplates.end())
            {
                LOG_ERROR("sql.sql", "Quest {} has `RewardNextQuest` = {} but quest {} does not exist, quest chain will not work.",
                                 qinfo->GetQuestId(), qinfo->RewardNextQuest, qinfo->RewardNextQuest);
                qinfo->RewardNextQuest = 0;
            }
            else
                qNextItr->second->prevChainQuests.push_back(qinfo->GetQuestId());
        }

        // fill additional data stores
        if (qinfo->PrevQuestId)
        {
            if (_questTemplates.find(std::abs(qinfo->GetPrevQuestId())) == _questTemplates.end())
            {
                LOG_ERROR("sql.sql", "Quest {} has PrevQuestId {}, but no such quest", qinfo->GetQuestId(), qinfo->GetPrevQuestId());
            }
            else
            {
                qinfo->prevQuests.push_back(qinfo->PrevQuestId);
            }
        }

        if (qinfo->NextQuestId)
        {
            QuestMap::iterator qNextItr = _questTemplates.find(qinfo->GetNextQuestId());
            if (qNextItr == _questTemplates.end())
            {
                LOG_ERROR("sql.sql", "Quest {} has NextQuestId {}, but no such quest", qinfo->GetQuestId(), qinfo->GetNextQuestId());
            }
            else
                qNextItr->second->prevQuests.push_back(static_cast<int32>(qinfo->GetQuestId()));
        }

        if (qinfo->ExclusiveGroup)
            mExclusiveQuestGroups.insert(std::pair<int32, uint32>(qinfo->ExclusiveGroup, qinfo->GetQuestId()));
        if (qinfo->TimeAllowed)
            qinfo->SetSpecialFlag(QUEST_SPECIAL_FLAGS_TIMED);
        if (qinfo->RequiredPlayerKills)
            qinfo->SetSpecialFlag(QUEST_SPECIAL_FLAGS_PLAYER_KILL);
    }

    // check QUEST_SPECIAL_FLAGS_EXPLORATION_OR_EVENT for spell with SPELL_EFFECT_QUEST_COMPLETE
    for (uint32 i = 0; i < sSpellMgr->GetSpellInfoStoreSize(); ++i)
    {
        SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(i);
        if (!spellInfo)
            continue;

        for (uint8 j = 0; j < MAX_SPELL_EFFECTS; ++j)
        {
            if (spellInfo->Effects[j].Effect != SPELL_EFFECT_QUEST_COMPLETE)
                continue;

            uint32 quest_id = spellInfo->Effects[j].MiscValue;

            Quest const* quest = GetQuestTemplate(quest_id);

            // some quest referenced in spells not exist (outdated spells)
            if (!quest)
                continue;

            if (!quest->HasSpecialFlag(QUEST_SPECIAL_FLAGS_EXPLORATION_OR_EVENT))
            {
                LOG_ERROR("sql.sql", "Spell (id: {}) have SPELL_EFFECT_QUEST_COMPLETE for quest {}, but quest not have specialflag QUEST_SPECIAL_FLAGS_EXPLORATION_OR_EVENT. Quest flags must be fixed, quest modified to enable objective.", spellInfo->Id, quest_id);

                // this will prevent quest completing without objective
                // xinef: remove this, leave error but do not break the quest
                // const_cast<Quest*>(quest)->SetSpecialFlag(QUEST_SPECIAL_FLAGS_EXPLORATION_OR_EVENT);
            }
        }
    }

    LOG_INFO("server.loading", ">> Loaded {} Quests Definitions in {} ms", (unsigned long)_questTemplates.size(), GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
}

void ObjectMgr::LoadQuestLocales()
{
    uint32 oldMSTime = getMSTime();

    _questLocaleStore.clear();                                // need for reload case

    //                                               0   1       2      3        4           5        6              7               8               9               10
    QueryResult result = WorldDatabase.Query("SELECT ID, locale, Title, Details, Objectives, EndText, CompletedText, ObjectiveText1, ObjectiveText2, ObjectiveText3, ObjectiveText4 FROM quest_template_locale");

    if (!result)
        return;

    do
    {
        Field* fields = result->Fetch();

        uint32 ID = fields[0].Get<uint32>();

        LocaleConstant locale = GetLocaleByName(fields[1].Get<std::string>());
        if (locale == LOCALE_enUS)
            continue;

        QuestLocale& data = _questLocaleStore[ID];
        AddLocaleString(fields[2].Get<std::string>(), locale, data.Title);
        AddLocaleString(fields[3].Get<std::string>(), locale, data.Details);
        AddLocaleString(fields[4].Get<std::string>(), locale, data.Objectives);
        AddLocaleString(fields[5].Get<std::string>(), locale, data.AreaDescription);
        AddLocaleString(fields[6].Get<std::string>(), locale, data.CompletedText);

        for (uint8 i = 0; i < 4; ++i)
            AddLocaleString(fields[i + 7].Get<std::string>(), locale, data.ObjectiveText[i]);
    } while (result->NextRow());

    LOG_INFO("server.loading", ">> Loaded {} Quest Locale Strings in {} ms", (uint32)_questLocaleStore.size(), GetMSTimeDiffToNow(oldMSTime));
}

void ObjectMgr::LoadScripts(ScriptsType type)
{
    uint32 oldMSTime = getMSTime();

    ScriptMapMap* scripts = GetScriptsMapByType(type);
    if (!scripts)
        return;

    std::string tableName = GetScriptsTableNameByType(type);
    if (tableName.empty())
        return;

    if (sScriptMgr->IsScriptScheduled())                    // function cannot be called when scripts are in use.
        return;

    LOG_INFO("server.loading", "Loading {}...", tableName);

    scripts->clear();                                       // need for reload support

    bool isSpellScriptTable = (type == SCRIPTS_SPELL);
    //                                                 0    1       2         3         4          5    6  7  8  9
    QueryResult result = WorldDatabase.Query("SELECT id, delay, command, datalong, datalong2, dataint, x, y, z, o{} FROM {}", isSpellScriptTable ? ", effIndex" : "", tableName);

    if (!result)
    {
        LOG_WARN("server.loading", ">> Loaded 0 script definitions. DB table `{}` is empty!", tableName);
        LOG_INFO("server.loading", " ");
        return;
    }

    uint32 count = 0;

    do
    {
        Field* fields = result->Fetch();
        ScriptInfo tmp;
        tmp.type      = type;
        tmp.id           = fields[0].Get<uint32>();
        if (isSpellScriptTable)
            tmp.id      |= fields[10].Get<uint8>() << 24;
        tmp.delay        = fields[1].Get<uint32>();
        tmp.command      = ScriptCommands(fields[2].Get<uint32>());
        tmp.Raw.nData[0] = fields[3].Get<uint32>();
        tmp.Raw.nData[1] = fields[4].Get<uint32>();
        tmp.Raw.nData[2] = fields[5].Get<int32>();
        tmp.Raw.fData[0] = fields[6].Get<float>();
        tmp.Raw.fData[1] = fields[7].Get<float>();
        tmp.Raw.fData[2] = fields[8].Get<float>();
        tmp.Raw.fData[3] = fields[9].Get<float>();

        // generic command args check
        switch (tmp.command)
        {
            case SCRIPT_COMMAND_TALK:
                {
                    if (tmp.Talk.ChatType > CHAT_TYPE_WHISPER && tmp.Talk.ChatType != CHAT_MSG_RAID_BOSS_WHISPER)
                    {
                        LOG_ERROR("sql.sql", "Table `{}` has invalid talk type (datalong = {}) in SCRIPT_COMMAND_TALK for script id {}",
                                         tableName, tmp.Talk.ChatType, tmp.id);
                        continue;
                    }
                    if (!GetBroadcastText(uint32(tmp.Talk.TextID)))
                    {
                        LOG_ERROR("sql.sql", "Table `{}` has invalid talk text id (dataint = {}) in SCRIPT_COMMAND_TALK for script id {}",
                                         tableName, tmp.Talk.TextID, tmp.id);
                        continue;
                    }
                    break;
                }

            case SCRIPT_COMMAND_EMOTE:
                {
                    if (!sEmotesStore.LookupEntry(tmp.Emote.EmoteID))
                    {
                        LOG_ERROR("sql.sql", "Table `{}` has invalid emote id (datalong = {}) in SCRIPT_COMMAND_EMOTE for script id {}",
                                         tableName, tmp.Emote.EmoteID, tmp.id);
                        continue;
                    }
                    break;
                }

            case SCRIPT_COMMAND_TELEPORT_TO:
                {
                    if (!sMapStore.LookupEntry(tmp.TeleportTo.MapID))
                    {
                        LOG_ERROR("sql.sql", "Table `{}` has invalid map (Id: {}) in SCRIPT_COMMAND_TELEPORT_TO for script id {}",
                                         tableName, tmp.TeleportTo.MapID, tmp.id);
                        continue;
                    }

                    if (!Acore::IsValidMapCoord(tmp.TeleportTo.DestX, tmp.TeleportTo.DestY, tmp.TeleportTo.DestZ, tmp.TeleportTo.Orientation))
                    {
                        LOG_ERROR("sql.sql", "Table `{}` has invalid coordinates (X: {} Y: {} Z: {} O: {}) in SCRIPT_COMMAND_TELEPORT_TO for script id {}",
                                         tableName, tmp.TeleportTo.DestX, tmp.TeleportTo.DestY, tmp.TeleportTo.DestZ, tmp.TeleportTo.Orientation, tmp.id);
                        continue;
                    }
                    break;
                }

            case SCRIPT_COMMAND_QUEST_EXPLORED:
                {
                    Quest const* quest = GetQuestTemplate(tmp.QuestExplored.QuestID);
                    if (!quest)
                    {
                        LOG_ERROR("sql.sql", "Table `{}` has invalid quest (ID: {}) in SCRIPT_COMMAND_QUEST_EXPLORED in `datalong` for script id {}",
                                         tableName, tmp.QuestExplored.QuestID, tmp.id);
                        continue;
                    }

                    if (!quest->HasSpecialFlag(QUEST_SPECIAL_FLAGS_EXPLORATION_OR_EVENT))
                    {
                        LOG_ERROR("sql.sql", "Table `{}` has quest (ID: {}) in SCRIPT_COMMAND_QUEST_EXPLORED in `datalong` for script id {}, but quest not have specialflag QUEST_SPECIAL_FLAGS_EXPLORATION_OR_EVENT in quest flags. Script command or quest flags wrong. Quest modified to require objective.",
                                         tableName, tmp.QuestExplored.QuestID, tmp.id);

                        // this will prevent quest completing without objective
                        const_cast<Quest*>(quest)->SetSpecialFlag(QUEST_SPECIAL_FLAGS_EXPLORATION_OR_EVENT);

                        // continue; - quest objective requirement set and command can be allowed
                    }

                    if (float(tmp.QuestExplored.Distance) > DEFAULT_VISIBILITY_DISTANCE)
                    {
                        LOG_ERROR("sql.sql", "Table `{}` has too large distance ({}) for exploring objective complete in `datalong2` in SCRIPT_COMMAND_QUEST_EXPLORED in `datalong` for script id {}",
                                         tableName, tmp.QuestExplored.Distance, tmp.id);
                        continue;
                    }

                    if (tmp.QuestExplored.Distance && float(tmp.QuestExplored.Distance) > DEFAULT_VISIBILITY_DISTANCE)
                    {
                        LOG_ERROR("sql.sql", "Table `{}` has too large distance ({}) for exploring objective complete in `datalong2` in SCRIPT_COMMAND_QUEST_EXPLORED in `datalong` for script id {}, max distance is {} or 0 for disable distance check",
                                         tableName, tmp.QuestExplored.Distance, tmp.id, DEFAULT_VISIBILITY_DISTANCE);
                        continue;
                    }

                    if (tmp.QuestExplored.Distance && float(tmp.QuestExplored.Distance) < INTERACTION_DISTANCE)
                    {
                        LOG_ERROR("sql.sql", "Table `{}` has too small distance ({}) for exploring objective complete in `datalong2` in SCRIPT_COMMAND_QUEST_EXPLORED in `datalong` for script id {}, min distance is {} or 0 for disable distance check",
                                         tableName, tmp.QuestExplored.Distance, tmp.id, INTERACTION_DISTANCE);
                        continue;
                    }

                    break;
                }

            case SCRIPT_COMMAND_KILL_CREDIT:
                {
                    if (!GetCreatureTemplate(tmp.KillCredit.CreatureEntry))
                    {
                        LOG_ERROR("sql.sql", "Table `{}` has invalid creature (Entry: {}) in SCRIPT_COMMAND_KILL_CREDIT for script id {}",
                                         tableName, tmp.KillCredit.CreatureEntry, tmp.id);
                        continue;
                    }
                    break;
                }

            case SCRIPT_COMMAND_RESPAWN_GAMEOBJECT:
                {
                    GameObjectData const* data = GetGameObjectData(tmp.RespawnGameobject.GOGuid);
                    if (!data)
                    {
                        LOG_ERROR("sql.sql", "Table `{}` has invalid gameobject (GUID: {}) in SCRIPT_COMMAND_RESPAWN_GAMEOBJECT for script id {}",
                                         tableName, tmp.RespawnGameobject.GOGuid, tmp.id);
                        continue;
                    }

                    GameObjectTemplate const* info = GetGameObjectTemplate(data->id);
                    if (!info)
                    {
                        LOG_ERROR("sql.sql", "Table `{}` has gameobject with invalid entry (GUID: {} Entry: {}) in SCRIPT_COMMAND_RESPAWN_GAMEOBJECT for script id {}",
                                         tableName, tmp.RespawnGameobject.GOGuid, data->id, tmp.id);
                        continue;
                    }

                    if (info->type == GAMEOBJECT_TYPE_FISHINGNODE ||
                            info->type == GAMEOBJECT_TYPE_FISHINGHOLE ||
                            info->type == GAMEOBJECT_TYPE_DOOR        ||
                            info->type == GAMEOBJECT_TYPE_BUTTON      ||
                            info->type == GAMEOBJECT_TYPE_TRAP)
                    {
                        LOG_ERROR("sql.sql", "Table `{}` have gameobject type ({}) unsupported by command SCRIPT_COMMAND_RESPAWN_GAMEOBJECT for script id {}",
                                         tableName, info->entry, tmp.id);
                        continue;
                    }
                    break;
                }

            case SCRIPT_COMMAND_TEMP_SUMMON_CREATURE:
                {
                    if (!Acore::IsValidMapCoord(tmp.TempSummonCreature.PosX, tmp.TempSummonCreature.PosY, tmp.TempSummonCreature.PosZ, tmp.TempSummonCreature.Orientation))
                    {
                        LOG_ERROR("sql.sql", "Table `{}` has invalid coordinates (X: {} Y: {} Z: {} O: {}) in SCRIPT_COMMAND_TEMP_SUMMON_CREATURE for script id {}",
                                         tableName, tmp.TempSummonCreature.PosX, tmp.TempSummonCreature.PosY, tmp.TempSummonCreature.PosZ, tmp.TempSummonCreature.Orientation, tmp.id);
                        continue;
                    }

                    uint32 entry = tmp.TempSummonCreature.CreatureEntry;
                    if (!GetCreatureTemplate(entry))
                    {
                        LOG_ERROR("sql.sql", "Table `{}` has invalid creature (Entry: {}) in SCRIPT_COMMAND_TEMP_SUMMON_CREATURE for script id {}",
                                         tableName, tmp.TempSummonCreature.CreatureEntry, tmp.id);
                        continue;
                    }
                    break;
                }

            case SCRIPT_COMMAND_OPEN_DOOR:
            case SCRIPT_COMMAND_CLOSE_DOOR:
                {
                    GameObjectData const* data = GetGameObjectData(tmp.ToggleDoor.GOGuid);
                    if (!data)
                    {
                        LOG_ERROR("sql.sql", "Table `{}` has invalid gameobject (GUID: {}) in {} for script id {}",
                                         tableName, tmp.ToggleDoor.GOGuid, GetScriptCommandName(tmp.command), tmp.id);
                        continue;
                    }

                    GameObjectTemplate const* info = GetGameObjectTemplate(data->id);
                    if (!info)
                    {
                        LOG_ERROR("sql.sql", "Table `{}` has gameobject with invalid entry (GUID: {} Entry: {}) in {} for script id {}",
                                         tableName, tmp.ToggleDoor.GOGuid, data->id, GetScriptCommandName(tmp.command), tmp.id);
                        continue;
                    }

                    if (info->type != GAMEOBJECT_TYPE_DOOR)
                    {
                        LOG_ERROR("sql.sql", "Table `{}` has gameobject type ({}) non supported by command {} for script id {}",
                                         tableName, info->entry, GetScriptCommandName(tmp.command), tmp.id);
                        continue;
                    }

                    break;
                }

            case SCRIPT_COMMAND_REMOVE_AURA:
                {
                    if (!sSpellMgr->GetSpellInfo(tmp.RemoveAura.SpellID))
                    {
                        LOG_ERROR("sql.sql", "Table `{}` using non-existent spell (id: {}) in SCRIPT_COMMAND_REMOVE_AURA for script id {}",
                                         tableName, tmp.RemoveAura.SpellID, tmp.id);
                        continue;
                    }
                    if (tmp.RemoveAura.Flags & ~0x1)                    // 1 bits (0, 1)
                    {
                        LOG_ERROR("sql.sql", "Table `{}` using unknown flags in datalong2 ({}) in SCRIPT_COMMAND_REMOVE_AURA for script id {}",
                                         tableName, tmp.RemoveAura.Flags, tmp.id);
                        continue;
                    }
                    break;
                }

            case SCRIPT_COMMAND_CAST_SPELL:
                {
                    if (!sSpellMgr->GetSpellInfo(tmp.CastSpell.SpellID))
                    {
                        LOG_ERROR("sql.sql", "Table `{}` using non-existent spell (id: {}) in SCRIPT_COMMAND_CAST_SPELL for script id {}",
                                         tableName, tmp.CastSpell.SpellID, tmp.id);
                        continue;
                    }
                    if (tmp.CastSpell.Flags > 4)                      // targeting type
                    {
                        LOG_ERROR("sql.sql", "Table `{}` using unknown target in datalong2 ({}) in SCRIPT_COMMAND_CAST_SPELL for script id {}",
                                         tableName, tmp.CastSpell.Flags, tmp.id);
                        continue;
                    }
                    if (tmp.CastSpell.Flags != 4 && tmp.CastSpell.CreatureEntry & ~0x1)                      // 1 bit (0, 1)
                    {
                        LOG_ERROR("sql.sql", "Table `{}` using unknown flags in dataint ({}) in SCRIPT_COMMAND_CAST_SPELL for script id {}",
                                         tableName, tmp.CastSpell.CreatureEntry, tmp.id);
                        continue;
                    }
                    else if (tmp.CastSpell.Flags == 4 && !GetCreatureTemplate(tmp.CastSpell.CreatureEntry))
                    {
                        LOG_ERROR("sql.sql", "Table `{}` using invalid creature entry in dataint ({}) in SCRIPT_COMMAND_CAST_SPELL for script id {}",
                                         tableName, tmp.CastSpell.CreatureEntry, tmp.id);
                        continue;
                    }
                    break;
                }

            case SCRIPT_COMMAND_CREATE_ITEM:
                {
                    if (!GetItemTemplate(tmp.CreateItem.ItemEntry))
                    {
                        LOG_ERROR("sql.sql", "Table `{}` has nonexistent item (entry: {}) in SCRIPT_COMMAND_CREATE_ITEM for script id {}",
                                         tableName, tmp.CreateItem.ItemEntry, tmp.id);
                        continue;
                    }
                    if (!tmp.CreateItem.Amount)
                    {
                        LOG_ERROR("sql.sql", "Table `{}` SCRIPT_COMMAND_CREATE_ITEM but amount is {} for script id {}",
                                         tableName, tmp.CreateItem.Amount, tmp.id);
                        continue;
                    }
                    break;
                }
            default:
                break;
        }

        if (scripts->find(tmp.id) == scripts->end())
        {
            ScriptMap emptyMap;
            (*scripts)[tmp.id] = emptyMap;
        }
        (*scripts)[tmp.id].insert(std::pair<uint32, ScriptInfo>(tmp.delay, tmp));

        ++count;
    } while (result->NextRow());

    LOG_INFO("server.loading", ">> Loaded {} script definitions in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
}

void ObjectMgr::LoadSpellScripts()
{
    LoadScripts(SCRIPTS_SPELL);

    // check ids
    for (ScriptMapMap::const_iterator itr = sSpellScripts.begin(); itr != sSpellScripts.end(); ++itr)
    {
        uint32 spellId = uint32(itr->first) & 0x00FFFFFF;
        SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(spellId);

        if (!spellInfo)
        {
            LOG_ERROR("sql.sql", "Table `spell_scripts` has not existing spell (Id: {}) as script id", spellId);
            continue;
        }

        SpellEffIndex i = SpellEffIndex((uint32(itr->first) >> 24) & 0x000000FF);
        if (uint32(i) >= MAX_SPELL_EFFECTS)
        {
            LOG_ERROR("sql.sql", "Table `spell_scripts` has too high effect index {} for spell (Id: {}) as script id", uint32(i), spellId);
        }

        //check for correct spellEffect
        if (!spellInfo->Effects[i].Effect || (spellInfo->Effects[i].Effect != SPELL_EFFECT_SCRIPT_EFFECT && spellInfo->Effects[i].Effect != SPELL_EFFECT_DUMMY))
            LOG_ERROR("sql.sql", "Table `spell_scripts` - spell {} effect {} is not SPELL_EFFECT_SCRIPT_EFFECT or SPELL_EFFECT_DUMMY", spellId, uint32(i));
    }
}

void ObjectMgr::LoadEventScripts()
{
    LoadScripts(SCRIPTS_EVENT);

    std::set<uint32> evt_scripts;
    // Load all possible script entries from gameobjects
    GameObjectTemplateContainer const* gotc = sObjectMgr->GetGameObjectTemplates();
    for (GameObjectTemplateContainer::const_iterator itr = gotc->begin(); itr != gotc->end(); ++itr)
        if (uint32 eventId = itr->second.GetEventScriptId())
            evt_scripts.insert(eventId);

    // Load all possible script entries from spells
    for (uint32 i = 1; i < sSpellMgr->GetSpellInfoStoreSize(); ++i)
        if (SpellInfo const* spell = sSpellMgr->GetSpellInfo(i))
            for (uint8 j = 0; j < MAX_SPELL_EFFECTS; ++j)
                if (spell->Effects[j].Effect == SPELL_EFFECT_SEND_EVENT)
                    if (spell->Effects[j].MiscValue)
                        evt_scripts.insert(spell->Effects[j].MiscValue);

    for (size_t path_idx = 0; path_idx < sTaxiPathNodesByPath.size(); ++path_idx)
    {
        for (size_t node_idx = 0; node_idx < sTaxiPathNodesByPath[path_idx].size(); ++node_idx)
        {
            TaxiPathNodeEntry const* node = sTaxiPathNodesByPath[path_idx][node_idx];

            if (node->arrivalEventID)
                evt_scripts.insert(node->arrivalEventID);

            if (node->departureEventID)
                evt_scripts.insert(node->departureEventID);
        }
    }

    // Then check if all scripts are in above list of possible script entries
    for (ScriptMapMap::const_iterator itr = sEventScripts.begin(); itr != sEventScripts.end(); ++itr)
    {
        std::set<uint32>::const_iterator itr2 = evt_scripts.find(itr->first);
        if (itr2 == evt_scripts.end())
            LOG_ERROR("sql.sql", "Table `event_scripts` has script (Id: {}) not referring to any gameobject_template type 10 data2 field, type 3 data6 field, type 13 data 2 field or any spell effect {}",
                             itr->first, SPELL_EFFECT_SEND_EVENT);
    }
}

//Load WP Scripts
void ObjectMgr::LoadWaypointScripts()
{
    LoadScripts(SCRIPTS_WAYPOINT);

    std::set<uint32> actionSet;

    for (ScriptMapMap::const_iterator itr = sWaypointScripts.begin(); itr != sWaypointScripts.end(); ++itr)
        actionSet.insert(itr->first);

    WorldDatabasePreparedStatement* stmt = WorldDatabase.GetPreparedStatement(WORLD_SEL_WAYPOINT_DATA_ACTION);
    PreparedQueryResult result = WorldDatabase.Query(stmt);

    if (result)
    {
        do
        {
            Field* fields = result->Fetch();
            uint32 action = fields[0].Get<uint32>();

            actionSet.erase(action);
        } while (result->NextRow());
    }

    for (std::set<uint32>::iterator itr = actionSet.begin(); itr != actionSet.end(); ++itr)
        LOG_ERROR("sql.sql", "There is no waypoint which links to the waypoint script {}", *itr);
}

void ObjectMgr::LoadSpellScriptNames()
{
    uint32 oldMSTime = getMSTime();

    _spellScriptsStore.clear();                            // need for reload case

    QueryResult result = WorldDatabase.Query("SELECT spell_id, ScriptName FROM spell_script_names");

    if (!result)
    {
        LOG_WARN("server.loading", ">> Loaded 0 spell script names. DB table `spell_script_names` is empty!");
        LOG_INFO("server.loading", " ");
        return;
    }

    uint32 count = 0;

    do
    {
        Field* fields = result->Fetch();

        int32 spellId          = fields[0].Get<int32>();
        std::string scriptName = fields[1].Get<std::string>();

        bool allRanks = false;
        if (spellId <= 0)
        {
            allRanks = true;
            spellId = -spellId;
        }

        SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(spellId);
        if (!spellInfo)
        {
            LOG_ERROR("sql.sql", "Scriptname: `{}` spell (spell_id:{}) does not exist in `Spell.dbc`.", scriptName, fields[0].Get<int32>());
            continue;
        }

        if (allRanks)
        {
            if (sSpellMgr->GetFirstSpellInChain(spellId) != uint32(spellId))
            {
                LOG_ERROR("sql.sql", "Scriptname: `{}` spell (spell_id:{}) is not first rank of spell.", scriptName, fields[0].Get<int32>());
                continue;
            }
            while (spellInfo)
            {
                _spellScriptsStore.insert(SpellScriptsContainer::value_type(spellInfo->Id, GetScriptId(scriptName)));
                spellInfo = spellInfo->GetNextRankSpell();
            }
        }
        else
            _spellScriptsStore.insert(SpellScriptsContainer::value_type(spellInfo->Id, GetScriptId(scriptName)));
        ++count;
    } while (result->NextRow());

    LOG_INFO("server.loading", ">> Loaded {} spell script names in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
}

void ObjectMgr::ValidateSpellScripts()
{
    uint32 oldMSTime = getMSTime();

    if (_spellScriptsStore.empty())
    {
        LOG_INFO("server.loading", ">> Validated 0 scripts.");
        LOG_INFO("server.loading", " ");
        return;
    }

    uint32 count = 0;

    for (SpellScriptsContainer::iterator itr = _spellScriptsStore.begin(); itr != _spellScriptsStore.end();)
    {
        SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(itr->first);
        std::vector<std::pair<SpellScriptLoader*, SpellScriptsContainer::iterator> > SpellScriptLoaders;
        sScriptMgr->CreateSpellScriptLoaders(itr->first, SpellScriptLoaders);
        itr = _spellScriptsStore.upper_bound(itr->first);

        for (std::vector<std::pair<SpellScriptLoader*, SpellScriptsContainer::iterator> >::iterator sitr = SpellScriptLoaders.begin(); sitr != SpellScriptLoaders.end(); ++sitr)
        {
            SpellScript* spellScript = sitr->first->GetSpellScript();
            AuraScript* auraScript = sitr->first->GetAuraScript();
            bool valid = true;
            if (!spellScript && !auraScript)
            {
                LOG_ERROR("sql.sql", "Functions GetSpellScript() and GetAuraScript() of script `{}` do not return objects - script skipped", GetScriptName(sitr->second->second));
                valid = false;
            }
            if (spellScript)
            {
                spellScript->_Init(&sitr->first->GetName(), spellInfo->Id);
                spellScript->_Register();
                if (!spellScript->_Validate(spellInfo))
                    valid = false;
                delete spellScript;
            }
            if (auraScript)
            {
                auraScript->_Init(&sitr->first->GetName(), spellInfo->Id);
                auraScript->_Register();
                if (!auraScript->_Validate(spellInfo))
                    valid = false;
                delete auraScript;
            }
            if (!valid)
            {
                _spellScriptsStore.erase(sitr->second);
            }
        }
        ++count;
    }

    LOG_INFO("server.loading", ">> Validated {} scripts in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
}

void ObjectMgr::InitializeSpellInfoPrecomputedData()
{
    uint32 limit = sSpellStore.GetNumRows();
    for(uint32 i = 0; i <= limit; ++i)
        if (SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(i))
        {
            const_cast<SpellInfo*>(spellInfo)->SetStackableWithRanks(spellInfo->ComputeIsStackableWithRanks());
            const_cast<SpellInfo*>(spellInfo)->SetCritCapable(spellInfo->ComputeIsCritCapable());
            const_cast<SpellInfo*>(spellInfo)->SetSpellValid(SpellMgr::ComputeIsSpellValid(spellInfo, false));
        }
}

void ObjectMgr::LoadPageTexts()
{
    uint32 oldMSTime = getMSTime();

    //                                               0     1       2
    QueryResult result = WorldDatabase.Query("SELECT ID, Text, NextPageID FROM page_text");

    if (!result)
    {
        LOG_WARN("server.loading", ">> Loaded 0 page texts. DB table `page_text` is empty!");
        LOG_INFO("server.loading", " ");
        return;
    }

    uint32 count = 0;
    do
    {
        Field* fields = result->Fetch();

        PageText& pageText = _pageTextStore[fields[0].Get<uint32>()];

        pageText.Text     = fields[1].Get<std::string>();
        pageText.NextPage = fields[2].Get<uint32>();

        ++count;
    } while (result->NextRow());

    for (PageTextContainer::const_iterator itr = _pageTextStore.begin(); itr != _pageTextStore.end(); ++itr)
    {
        if (itr->second.NextPage)
        {
            PageTextContainer::const_iterator itr2 = _pageTextStore.find(itr->second.NextPage);
            if (itr2 == _pageTextStore.end())
                LOG_ERROR("sql.sql", "Page text (Id: {}) has not existing next page (Id: {})", itr->first, itr->second.NextPage);
        }
    }

    LOG_INFO("server.loading", ">> Loaded {} Page Texts in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
}

PageText const* ObjectMgr::GetPageText(uint32 pageEntry)
{
    PageTextContainer::const_iterator itr = _pageTextStore.find(pageEntry);
    if (itr != _pageTextStore.end())
        return &(itr->second);

    return nullptr;
}

void ObjectMgr::LoadPageTextLocales()
{
    uint32 oldMSTime = getMSTime();

    _pageTextLocaleStore.clear();                             // need for reload case

    //                                               0   1       2
    QueryResult result = WorldDatabase.Query("SELECT ID, locale, Text FROM page_text_locale");

    if (!result)
        return;

    do
    {
        Field* fields = result->Fetch();

        uint32 ID = fields[0].Get<uint32>();

        LocaleConstant locale = GetLocaleByName(fields[1].Get<std::string>());
        if (locale == LOCALE_enUS)
            continue;

        PageTextLocale& data = _pageTextLocaleStore[ID];
        AddLocaleString(fields[2].Get<std::string>(), locale, data.Text);
    } while (result->NextRow());

    LOG_INFO("server.loading", ">> Loaded {} Page Text Locale Strings in {} ms", (uint32)_pageTextLocaleStore.size(), GetMSTimeDiffToNow(oldMSTime));
}

void ObjectMgr::LoadInstanceTemplate()
{
    uint32 oldMSTime = getMSTime();

    //                                                0     1       2        4
    QueryResult result = WorldDatabase.Query("SELECT map, parent, script, allowMount FROM instance_template");

    if (!result)
    {
        LOG_WARN("server.loading", ">> Loaded 0 instance templates. DB table `page_text` is empty!");
        LOG_INFO("server.loading", " ");
        return;
    }

    uint32 count = 0;
    do
    {
        Field* fields = result->Fetch();

        uint16 mapID = fields[0].Get<uint16>();

        if (!MapMgr::IsValidMAP(mapID, true))
        {
            LOG_ERROR("sql.sql", "ObjectMgr::LoadInstanceTemplate: bad mapid {} for template!", mapID);
            continue;
        }

        InstanceTemplate instanceTemplate;

        instanceTemplate.AllowMount = fields[3].Get<bool>();
        instanceTemplate.Parent     = uint32(fields[1].Get<uint16>());
        instanceTemplate.ScriptId   = sObjectMgr->GetScriptId(fields[2].Get<std::string>());

        _instanceTemplateStore[mapID] = instanceTemplate;

        ++count;
    } while (result->NextRow());

    LOG_INFO("server.loading", ">> Loaded {} Instance Templates in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
}

InstanceTemplate const* ObjectMgr::GetInstanceTemplate(uint32 mapID)
{
    InstanceTemplateContainer::const_iterator itr = _instanceTemplateStore.find(uint16(mapID));
    if (itr != _instanceTemplateStore.end())
        return &(itr->second);

    return nullptr;
}

void ObjectMgr::LoadInstanceEncounters()
{
    uint32 oldMSTime = getMSTime();

    //                                                 0         1            2                3
    QueryResult result = WorldDatabase.Query("SELECT entry, creditType, creditEntry, lastEncounterDungeon FROM instance_encounters");
    if (!result)
    {
        LOG_WARN("server.loading", ">> Loaded 0 instance encounters, table is empty!");
        LOG_INFO("server.loading", " ");
        return;
    }

    uint32 count = 0;
    std::map<uint32, DungeonEncounterEntry const*> dungeonLastBosses;
    do
    {
        Field* fields = result->Fetch();
        uint32 entry = fields[0].Get<uint32>();
        uint8 creditType = fields[1].Get<uint8>();
        uint32 creditEntry = fields[2].Get<uint32>();
        uint32 lastEncounterDungeon = fields[3].Get<uint16>();
        DungeonEncounterEntry const* dungeonEncounter = sDungeonEncounterStore.LookupEntry(entry);
        if (!dungeonEncounter)
        {
            LOG_ERROR("sql.sql", "Table `instance_encounters` has an invalid encounter id {}, skipped!", entry);
            continue;
        }

        if (lastEncounterDungeon && !sLFGMgr->GetLFGDungeonEntry(lastEncounterDungeon))
        {
            LOG_ERROR("sql.sql", "Table `instance_encounters` has an encounter {} ({}) marked as final for invalid dungeon id {}, skipped!", entry, dungeonEncounter->encounterName[0], lastEncounterDungeon);
            continue;
        }

        std::map<uint32, DungeonEncounterEntry const*>::const_iterator itr = dungeonLastBosses.find(lastEncounterDungeon);
        if (lastEncounterDungeon)
        {
            if (itr != dungeonLastBosses.end())
            {
                LOG_ERROR("sql.sql", "Table `instance_encounters` specified encounter {} ({}) as last encounter but {} ({}) is already marked as one, skipped!", entry, dungeonEncounter->encounterName[0], itr->second->id, itr->second->encounterName[0]);
                continue;
            }

            dungeonLastBosses[lastEncounterDungeon] = dungeonEncounter;
        }

        switch (creditType)
        {
            case ENCOUNTER_CREDIT_KILL_CREATURE:
                {
                    CreatureTemplate const* creatureInfo = GetCreatureTemplate(creditEntry);
                    if (!creatureInfo)
                    {
                        LOG_ERROR("sql.sql", "Table `instance_encounters` has an invalid creature (entry {}) linked to the encounter {} ({}), skipped!", creditEntry, entry, dungeonEncounter->encounterName[0]);
                        continue;
                    }
                    const_cast<CreatureTemplate*>(creatureInfo)->flags_extra |= CREATURE_FLAG_EXTRA_DUNGEON_BOSS;
                    break;
                }
            case ENCOUNTER_CREDIT_CAST_SPELL:
                {
                    SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(creditEntry);
                    if (!spellInfo)
                    {
                        LOG_ERROR("sql.sql", "Table `instance_encounters` has an invalid spell (entry {}) linked to the encounter {} ({}), skipped!", creditEntry, entry, dungeonEncounter->encounterName[0]);
                        continue;
                    }
                    const_cast<SpellInfo*>(spellInfo)->AttributesCu |= SPELL_ATTR0_CU_ENCOUNTER_REWARD;
                    break;
                }
            default:
                LOG_ERROR("sql.sql", "Table `instance_encounters` has an invalid credit type ({}) for encounter {} ({}), skipped!", creditType, entry, dungeonEncounter->encounterName[0]);
                continue;
        }

        DungeonEncounterList& encounters = _dungeonEncounterStore[MAKE_PAIR32(dungeonEncounter->mapId, dungeonEncounter->difficulty)];
        encounters.push_back(new DungeonEncounter(dungeonEncounter, EncounterCreditType(creditType), creditEntry, lastEncounterDungeon));
        ++count;
    } while (result->NextRow());

    LOG_INFO("server.loading", ">> Loaded {} Instance Encounters in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
}

GossipText const* ObjectMgr::GetGossipText(uint32 Text_ID) const
{
    GossipTextContainer::const_iterator itr = _gossipTextStore.find(Text_ID);
    if (itr != _gossipTextStore.end())
        return &itr->second;
    return nullptr;
}

void ObjectMgr::LoadGossipText()
{
    uint32 oldMSTime = getMSTime();

    QueryResult result = WorldDatabase.Query("SELECT ID, "
                         "text0_0, text0_1, BroadcastTextID0, lang0, Probability0, em0_0, em0_1, em0_2, em0_3, em0_4, em0_5, "
                         "text1_0, text1_1, BroadcastTextID1, lang1, Probability1, em1_0, em1_1, em1_2, em1_3, em1_4, em1_5, "
                         "text2_0, text2_1, BroadcastTextID2, lang2, Probability2, em2_0, em2_1, em2_2, em2_3, em2_4, em2_5, "
                         "text3_0, text3_1, BroadcastTextID3, lang3, Probability3, em3_0, em3_1, em3_2, em3_3, em3_4, em3_5, "
                         "text4_0, text4_1, BroadcastTextID4, lang4, Probability4, em4_0, em4_1, em4_2, em4_3, em4_4, em4_5, "
                         "text5_0, text5_1, BroadcastTextID5, lang5, Probability5, em5_0, em5_1, em5_2, em5_3, em5_4, em5_5, "
                         "text6_0, text6_1, BroadcastTextID6, lang6, Probability6, em6_0, em6_1, em6_2, em6_3, em6_4, em6_5, "
                         "text7_0, text7_1, BroadcastTextID7, lang7, Probability7, em7_0, em7_1, em7_2, em7_3, em7_4, em7_5 "
                         "FROM npc_text");

    if (!result)
    {
        LOG_WARN("server.loading", ">> Loaded 0 npc texts, table is empty!");
        LOG_INFO("server.loading", " ");
        return;
    }

    _gossipTextStore.rehash(result->GetRowCount());

    uint32 count = 0;
    uint8 cic;

    do
    {
        cic = 0;

        Field* fields = result->Fetch();

        uint32 id = fields[cic++].Get<uint32>();
        if (!id)
        {
            LOG_ERROR("sql.sql", "Table `npc_text` has record wit reserved id 0, ignore.");
            continue;
        }

        GossipText& gText = _gossipTextStore[id];

        for (uint8 i = 0; i < MAX_GOSSIP_TEXT_OPTIONS; ++i)
        {
            gText.Options[i].Text_0           = fields[cic++].Get<std::string>();
            gText.Options[i].Text_1           = fields[cic++].Get<std::string>();
            gText.Options[i].BroadcastTextID  = fields[cic++].Get<uint32>();
            gText.Options[i].Language         = fields[cic++].Get<uint8>();
            gText.Options[i].Probability      = fields[cic++].Get<float>();

            for (uint8 j = 0; j < MAX_GOSSIP_TEXT_EMOTES; ++j)
            {
                gText.Options[i].Emotes[j]._Delay = fields[cic++].Get<uint16>();
                gText.Options[i].Emotes[j]._Emote = fields[cic++].Get<uint16>();
            }
        }

        for (uint8 i = 0; i < MAX_GOSSIP_TEXT_OPTIONS; i++)
        {
            if (gText.Options[i].BroadcastTextID)
            {
                if (!GetBroadcastText(gText.Options[i].BroadcastTextID))
                {
                    LOG_ERROR("sql.sql", "GossipText (Id: {}) in table `npc_text` has non-existing or incompatible BroadcastTextID{} {}.", id, i, gText.Options[i].BroadcastTextID);
                    gText.Options[i].BroadcastTextID = 0;
                }
            }
        }

        count++;
    } while (result->NextRow());

    LOG_INFO("server.loading", ">> Loaded {} Npc Texts in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
}

void ObjectMgr::LoadNpcTextLocales()
{
    uint32 oldMSTime = getMSTime();

    _npcTextLocaleStore.clear();                              // need for reload case

    QueryResult result = WorldDatabase.Query("SELECT ID, Locale, "
                         //   2        3        4        5        6        7        8        9        10       11       12       13       14       15       16       17
                         "Text0_0, Text0_1, Text1_0, Text1_1, Text2_0, Text2_1, Text3_0, Text3_1, Text4_0, Text4_1, Text5_0, Text5_1, Text6_0, Text6_1, Text7_0, Text7_1 "
                         "FROM npc_text_locale");

    if (!result)
        return;

    do
    {
        Field* fields = result->Fetch();

        uint32 ID = fields[0].Get<uint32>();

        LocaleConstant locale = GetLocaleByName(fields[1].Get<std::string>());
        if (locale == LOCALE_enUS)
            continue;

        NpcTextLocale& data = _npcTextLocaleStore[ID];
        for (uint8 i = 0; i < MAX_GOSSIP_TEXT_OPTIONS; ++i)
        {
            AddLocaleString(fields[2 + i * 2].Get<std::string>(), locale, data.Text_0[i]);
            AddLocaleString(fields[3 + i * 2].Get<std::string>(), locale, data.Text_1[i]);
        }
    } while (result->NextRow());

    LOG_INFO("server.loading", ">> Loaded {} Npc Text Locale Strings in {} ms", (uint32)_npcTextLocaleStore.size(), GetMSTimeDiffToNow(oldMSTime));
}

void ObjectMgr::ReturnOrDeleteOldMails(bool serverUp)
{
    uint32 oldMSTime = getMSTime();

    time_t curTime = GameTime::GetGameTime().count();

    CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_EXPIRED_MAIL);
    stmt->SetData(0, uint32(curTime));
    PreparedQueryResult result = CharacterDatabase.Query(stmt);
    if (!result)
        return;

    std::map<uint32 /*messageId*/, MailItemInfoVec> itemsCache;
    stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_EXPIRED_MAIL_ITEMS);
    stmt->SetData(0, uint32(curTime));
    if (PreparedQueryResult items = CharacterDatabase.Query(stmt))
    {
        MailItemInfo item;
        do
        {
            Field* fields = items->Fetch();
            item.item_guid = fields[0].Get<uint32>();
            item.item_template = fields[1].Get<uint32>();
            uint32 mailId = fields[2].Get<uint32>();
            itemsCache[mailId].push_back(item);
        } while (items->NextRow());
    }

    uint32 deletedCount = 0;
    uint32 returnedCount = 0;
    do
    {
        Field* fields = result->Fetch();
        Mail* m = new Mail;
        m->messageID      = fields[0].Get<uint32>();
        m->messageType    = fields[1].Get<uint8>();
        m->sender         = fields[2].Get<uint32>();
        m->receiver       = fields[3].Get<uint32>();
        bool has_items    = fields[4].Get<bool>();
        m->expire_time    = time_t(fields[5].Get<uint32>());
        m->deliver_time   = time_t(0);
        m->stationery     = fields[6].Get<uint8>();
        m->checked        = fields[7].Get<uint8>();
        m->mailTemplateId = fields[8].Get<int16>();

        Player* player = nullptr;
        if (serverUp)
            player = ObjectAccessor::FindPlayerByLowGUID(m->receiver);

        if (player) // don't modify mails of a logged in player
        {
            delete m;
            continue;
        }

        // Delete or return mail
        if (has_items)
        {
            // read items from cache
            m->items.swap(itemsCache[m->messageID]);

            // If it is mail from non-player, or if it's already return mail, it shouldn't be returned, but deleted
            if (!m->IsSentByPlayer() || m->IsSentByGM() || (m->IsCODPayment() || m->IsReturnedMail()))
            {
                for (auto const& mailedItem : m->items)
                {
                    stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_ITEM_INSTANCE);
                    stmt->SetData(0, mailedItem.item_guid);
                    CharacterDatabase.Execute(stmt);
                }

                stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_MAIL_ITEM_BY_ID);
                stmt->SetData(0, m->messageID);
                CharacterDatabase.Execute(stmt);
            }
            else
            {
                // Mail will be returned
                stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_MAIL_RETURNED);
                stmt->SetData(0, m->receiver);
                stmt->SetData(1, m->sender);
                stmt->SetData(2, uint32(curTime + 30 * DAY));
                stmt->SetData(3, uint32(curTime));
                stmt->SetData (4, uint8(MAIL_CHECK_MASK_RETURNED));
                stmt->SetData(5, m->messageID);
                CharacterDatabase.Execute(stmt);
                for (auto const& mailedItem : m->items)
                {
                    // Update receiver in mail items for its proper delivery, and in instance_item for avoid lost item at sender delete
                    stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_MAIL_ITEM_RECEIVER);
                    stmt->SetData(0, m->sender);
                    stmt->SetData(1, mailedItem.item_guid);
                    CharacterDatabase.Execute(stmt);

                    stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_ITEM_OWNER);
                    stmt->SetData(0, m->sender);
                    stmt->SetData(1, mailedItem.item_guid);
                    CharacterDatabase.Execute(stmt);
                }

                // xinef: update global data
                sCharacterCache->IncreaseCharacterMailCount(ObjectGuid(HighGuid::Player, m->sender));
                sCharacterCache->DecreaseCharacterMailCount(ObjectGuid(HighGuid::Player, m->receiver));

                delete m;
                ++returnedCount;
                continue;
            }
        }

        sCharacterCache->DecreaseCharacterMailCount(ObjectGuid(HighGuid::Player, m->receiver));

        stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_MAIL_BY_ID);
        stmt->SetData(0, m->messageID);
        CharacterDatabase.Execute(stmt);
        delete m;
        ++deletedCount;
    } while (result->NextRow());

    LOG_INFO("server.loading", ">> Processed {} expired mails: {} deleted and {} returned in {} ms", deletedCount + returnedCount, deletedCount, returnedCount, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
}

void ObjectMgr::LoadQuestAreaTriggers()
{
    uint32 oldMSTime = getMSTime();

    _questAreaTriggerStore.clear();                           // need for reload case

    QueryResult result = WorldDatabase.Query("SELECT id, quest FROM areatrigger_involvedrelation");

    if (!result)
    {
        LOG_WARN("server.loading", ">> Loaded 0 quest trigger points. DB table `areatrigger_involvedrelation` is empty.");
        LOG_INFO("server.loading", " ");
        return;
    }

    uint32 count = 0;

    do
    {
        ++count;

        Field* fields = result->Fetch();

        uint32 trigger_ID = fields[0].Get<uint32>();
        uint32 quest_ID   = fields[1].Get<uint32>();

        AreaTrigger const* atEntry = GetAreaTrigger(trigger_ID);
        if (!atEntry)
        {
            LOG_ERROR("sql.sql", "Area trigger (ID:{}) does not exist in `AreaTrigger.dbc`.", trigger_ID);
            continue;
        }

        Quest const* quest = GetQuestTemplate(quest_ID);

        if (!quest)
        {
            LOG_ERROR("sql.sql", "Table `areatrigger_involvedrelation` has record (id: {}) for not existing quest {}", trigger_ID, quest_ID);
            continue;
        }

        if (!quest->HasSpecialFlag(QUEST_SPECIAL_FLAGS_EXPLORATION_OR_EVENT))
        {
            LOG_ERROR("sql.sql", "Table `areatrigger_involvedrelation` has record (id: {}) for not quest {}, but quest not have specialflag QUEST_SPECIAL_FLAGS_EXPLORATION_OR_EVENT. Trigger or quest flags must be fixed, quest modified to require objective.", trigger_ID, quest_ID);

            // this will prevent quest completing without objective
            const_cast<Quest*>(quest)->SetSpecialFlag(QUEST_SPECIAL_FLAGS_EXPLORATION_OR_EVENT);

            // continue; - quest modified to required objective and trigger can be allowed.
        }

        _questAreaTriggerStore[trigger_ID] = quest_ID;
    } while (result->NextRow());

    LOG_INFO("server.loading", ">> Loaded {} Quest Trigger Points in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
}

QuestGreeting const* ObjectMgr::GetQuestGreeting(TypeID type, uint32 id) const
{
    uint32 typeIndex;
    if (type == TYPEID_UNIT)
        typeIndex = 0;
    else if (type == TYPEID_GAMEOBJECT)
        typeIndex = 1;
    else
        return nullptr;

    return Acore::Containers::MapGetValuePtr(_questGreetingStore[typeIndex], id);
}

void ObjectMgr::LoadQuestGreetings()
{
    uint32 oldMSTime = getMSTime();

    for (std::size_t i = 0; i < _questGreetingStore.size(); ++i)
        _questGreetingStore[i].clear();

    //                                                0   1          2                3             4
    QueryResult result = WorldDatabase.Query("SELECT ID, Type, GreetEmoteType, GreetEmoteDelay, Greeting FROM quest_greeting");
    if (!result)
    {
        LOG_WARN("server.loading", ">> Loaded 0 quest greetings. DB table `quest_greeting` is empty.");
        return;
    }

    uint32 count = 0;

    do
    {
        Field* fields = result->Fetch();

        uint32 id = fields[0].Get<uint32>();
        uint8 type = fields[1].Get<uint8>();
        switch (type)
        {
        case 0: // Creature
            if (!sObjectMgr->GetCreatureTemplate(id))
            {
                LOG_ERROR("sql.sql", "Table `quest_greeting`: creature template entry {} does not exist.", id);
                continue;
            }
            break;
        case 1: // GameObject
            if (!sObjectMgr->GetGameObjectTemplate(id))
            {
                LOG_ERROR("sql.sql", "Table `quest_greeting`: gameobject template entry {} does not exist.", id);
                continue;
            }
            break;
        default:
            continue;
        }

        uint16 greetEmoteType = fields[2].Get<uint16>();
        uint32 greetEmoteDelay = fields[3].Get<uint32>();
        std::string greeting = fields[4].Get<std::string>();

        _questGreetingStore[type].emplace(std::piecewise_construct, std::forward_as_tuple(id), std::forward_as_tuple(greetEmoteType, greetEmoteDelay, std::move(greeting)));

        ++count;
    }
    while (result->NextRow());

    LOG_INFO("server.loading", ">> Loaded {} quest_greeting in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
}

void ObjectMgr::LoadQuestGreetingsLocales()
{
    uint32 oldMSTime = getMSTime();

    _questGreetingLocaleStore.clear();

    //                                               0     1      2       3
    QueryResult result = WorldDatabase.Query("SELECT ID, Type, Locale, Greeting FROM quest_greeting_locale");
    if (!result)
    {
        LOG_WARN("server.loading", ">> Loaded 0 quest_greeting locales. DB table `quest_greeting_locale` is empty.");
        return;
    }

    uint32 count = 0;

    do
    {
        Field* fields = result->Fetch();

        uint32 id = fields[0].Get<uint32>();
        uint8 type = fields[1].Get<uint8>();
        switch (type)
        {
        case 0: // Creature
            if (!sObjectMgr->GetCreatureTemplate(id))
            {
                LOG_ERROR("sql.sql", "Table `quest_greeting_locale`: creature template entry {} does not exist.", id);
                continue;
            }
            break;
        case 1: // GameObject
            if (!sObjectMgr->GetGameObjectTemplate(id))
            {
                LOG_ERROR("sql.sql", "Table `quest_greeting_locale`: gameobject template entry {} does not exist.", id);
                continue;
            }
            break;
        default:
            continue;
        }

        std::string localeName = fields[2].Get<std::string>();

        LocaleConstant locale = GetLocaleByName(localeName);
        if (locale == LOCALE_enUS)
            continue;

        QuestGreetingLocale& data = _questGreetingLocaleStore[MAKE_PAIR32(type, id)];
        AddLocaleString(fields[3].Get<std::string>(), locale, data.Greeting);

        ++count;
    } while (result->NextRow());

    LOG_INFO("server.loading", ">> Loaded {} quest greeting Locale Strings in {} ms", (uint32)_questGreetingLocaleStore.size(), GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
}

void ObjectMgr::LoadQuestOfferRewardLocale()
{
    uint32 oldMSTime = getMSTime();

    _questOfferRewardLocaleStore.clear(); // need for reload case

    //                                               0     1          2
    QueryResult result = WorldDatabase.Query("SELECT Id, locale, RewardText FROM quest_offer_reward_locale");
    if (!result)
        return;

    do
    {
        Field* fields = result->Fetch();

        uint32 id = fields[0].Get<uint32>();
        std::string localeName = fields[1].Get<std::string>();

        LocaleConstant locale = GetLocaleByName(localeName);
        if (locale == LOCALE_enUS)
            continue;

        QuestOfferRewardLocale& data = _questOfferRewardLocaleStore[id];
        AddLocaleString(fields[2].Get<std::string>(), locale, data.RewardText);
    } while (result->NextRow());

    LOG_INFO("server.loading", ">> Loaded {} Quest Offer Reward Locale Strings in {} ms", _questOfferRewardLocaleStore.size(), GetMSTimeDiffToNow(oldMSTime));
}

void ObjectMgr::LoadQuestRequestItemsLocale()
{
    uint32 oldMSTime = getMSTime();

    _questRequestItemsLocaleStore.clear(); // need for reload case

    //                                               0     1          2
    QueryResult result = WorldDatabase.Query("SELECT Id, locale, CompletionText FROM quest_request_items_locale");
    if (!result)
        return;

    do
    {
        Field* fields = result->Fetch();

        uint32 id = fields[0].Get<uint32>();
        std::string localeName = fields[1].Get<std::string>();

        LocaleConstant locale = GetLocaleByName(localeName);
        if (locale == LOCALE_enUS)
            continue;

        QuestRequestItemsLocale& data = _questRequestItemsLocaleStore[id];
        AddLocaleString(fields[2].Get<std::string>(), locale, data.CompletionText);
    } while (result->NextRow());

    LOG_INFO("server.loading", ">> Loaded {} Quest Request Items Locale Strings in {} ms", _questRequestItemsLocaleStore.size(), GetMSTimeDiffToNow(oldMSTime));
}

void ObjectMgr::LoadTavernAreaTriggers()
{
    uint32 oldMSTime = getMSTime();

    _tavernAreaTriggerStore.clear();                          // need for reload case

    QueryResult result = WorldDatabase.Query("SELECT id, faction FROM areatrigger_tavern");

    if (!result)
    {
        LOG_WARN("server.loading", ">> Loaded 0 tavern triggers. DB table `areatrigger_tavern` is empty.");
        LOG_INFO("server.loading", " ");
        return;
    }

    uint32 count = 0;

    do
    {
        ++count;

        Field* fields = result->Fetch();

        uint32 Trigger_ID      = fields[0].Get<uint32>();

        AreaTrigger const* atEntry = GetAreaTrigger(Trigger_ID);
        if (!atEntry)
        {
            LOG_ERROR("sql.sql", "Area trigger (ID:{}) does not exist in `AreaTrigger.dbc`.", Trigger_ID);
            continue;
        }

        uint32 faction         = fields[1].Get<uint32>();

        _tavernAreaTriggerStore.emplace(Trigger_ID, faction);
    } while (result->NextRow());

    LOG_INFO("server.loading", ">> Loaded {} Tavern Triggers in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
}

void ObjectMgr::LoadAreaTriggerScripts()
{
    uint32 oldMSTime = getMSTime();

    _areaTriggerScriptStore.clear();                            // need for reload case
    QueryResult result = WorldDatabase.Query("SELECT entry, ScriptName FROM areatrigger_scripts");

    if (!result)
    {
        LOG_WARN("server.loading", ">> Loaded 0 Areatrigger Scripts. DB Table `areatrigger_scripts` Is Empty.");
        LOG_INFO("server.loading", " ");
        return;
    }

    uint32 count = 0;

    do
    {
        ++count;

        Field* fields = result->Fetch();

        uint32 Trigger_ID      = fields[0].Get<uint32>();
        std::string scriptName = fields[1].Get<std::string>();

        AreaTrigger const* atEntry = GetAreaTrigger(Trigger_ID);
        if (!atEntry)
        {
            LOG_ERROR("sql.sql", "Area trigger (ID:{}) does not exist in `AreaTrigger.dbc`.", Trigger_ID);
            continue;
        }
        _areaTriggerScriptStore[Trigger_ID] = GetScriptId(scriptName);
    } while (result->NextRow());

    LOG_INFO("server.loading", ">> Loaded {} Areatrigger Scripts in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
}

uint32 ObjectMgr::GetNearestTaxiNode(float x, float y, float z, uint32 mapid, uint32 teamId)
{
    bool found = false;
    float dist = 10000;
    uint32 id = 0;

    for (uint32 i = 1; i < sTaxiNodesStore.GetNumRows(); ++i)
    {
        TaxiNodesEntry const* node = sTaxiNodesStore.LookupEntry(i);

        if (!node || node->map_id != mapid || (!node->MountCreatureID[teamId == TEAM_ALLIANCE ? 1 : 0] && node->MountCreatureID[0] != 32981)) // dk flight
            continue;

        uint8  field   = (uint8)((i - 1) / 32);
        uint32 submask = 1 << ((i - 1) % 32);

        // skip not taxi network nodes
        if (field >= TaxiMaskSize || (sTaxiNodesMask[field] & submask) == 0)
        {
            continue;
        }

        float dist2 = (node->x - x) * (node->x - x) + (node->y - y) * (node->y - y) + (node->z - z) * (node->z - z);
        if (found)
        {
            if (dist2 < dist)
            {
                dist = dist2;
                id = i;
            }
        }
        else
        {
            found = true;
            dist = dist2;
            id = i;
        }
    }

    return id;
}

void ObjectMgr::GetTaxiPath(uint32 source, uint32 destination, uint32& path, uint32& cost)
{
    TaxiPathSetBySource::iterator src_i = sTaxiPathSetBySource.find(source);
    if (src_i == sTaxiPathSetBySource.end())
    {
        path = 0;
        cost = 0;
        return;
    }

    TaxiPathSetForSource& pathSet = src_i->second;

    TaxiPathSetForSource::iterator dest_i = pathSet.find(destination);
    if (dest_i == pathSet.end())
    {
        path = 0;
        cost = 0;
        return;
    }

    cost = dest_i->second->price;
    path = dest_i->second->ID;
}

uint32 ObjectMgr::GetTaxiMountDisplayId(uint32 id, TeamId teamId, bool allowed_alt_team /* = false */)
{
    uint32 mount_id = 0;

    // select mount creature id
    TaxiNodesEntry const* node = sTaxiNodesStore.LookupEntry(id);
    if (node)
    {
        uint32 mount_entry = node->MountCreatureID[teamId == TEAM_ALLIANCE ? 1 : 0];

        // Fix for Alliance not being able to use Acherus taxi
        // only one mount type for both sides
        if (mount_entry == 0 && allowed_alt_team)
        {
            // Simply reverse the selection. At least one team in theory should have a valid mount ID to choose.
            mount_entry = node->MountCreatureID[teamId];
        }

        CreatureTemplate const* mount_info = GetCreatureTemplate(mount_entry);
        if (mount_info)
        {
            mount_id = mount_info->GetRandomValidModelId();
            if (!mount_id)
            {
                LOG_ERROR("sql.sql", "No displayid found for the taxi mount with the entry {}! Can't load it!", mount_entry);
                return 0;
            }
        }
    }

    // minfo is not actually used but the mount_id was updated
    GetCreatureModelRandomGender(&mount_id);

    return mount_id;
}

void ObjectMgr::LoadAreaTriggers()
{
    uint32 oldMSTime = getMSTime();

    _areaTriggerStore.clear();

    QueryResult result = WorldDatabase.Query("SELECT entry, map, x, y, z, radius, length, width, height, orientation FROM areatrigger");

    if (!result)
    {
        LOG_WARN("server.loading", ">> Loaded 0 area trigger definitions. DB table `areatrigger` is empty.");
        LOG_INFO("server.loading", " ");
        return;
    }

    uint32 count = 0;

    do
    {
        Field* fields = result->Fetch();

        ++count;

        AreaTrigger at;

        at.entry = fields[0].Get<uint32>();
        at.map = fields[1].Get<uint32>();
        at.x = fields[2].Get<float>();
        at.y = fields[3].Get<float>();
        at.z = fields[4].Get<float>();
        at.radius = fields[5].Get<float>();
        at.length = fields[6].Get<float>();
        at.width = fields[7].Get<float>();
        at.height = fields[8].Get<float>();
        at.orientation = fields[9].Get<float>();

        MapEntry const* mapEntry = sMapStore.LookupEntry(at.map);
        if (!mapEntry)
        {
            LOG_ERROR("sql.sql", "Area trigger (ID:{}) map (ID: {}) does not exist in `Map.dbc`.", at.entry, at.map);
            continue;
        }

        _areaTriggerStore[at.entry] = at;
    } while (result->NextRow());

    LOG_INFO("server.loading", ">> Loaded {} Area Trigger Definitions in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
}

void ObjectMgr::LoadAreaTriggerTeleports()
{
    uint32 oldMSTime = getMSTime();

    _areaTriggerTeleportStore.clear();                                  // need for reload case

    //                                               0        1              2                  3                  4                   5
    QueryResult result = WorldDatabase.Query("SELECT ID,  target_map, target_position_x, target_position_y, target_position_z, target_orientation FROM areatrigger_teleport");

    if (!result)
    {
        LOG_WARN("server.loading", ">> Loaded 0 area trigger teleport definitions. DB table `areatrigger_teleport` is empty.");
        LOG_INFO("server.loading", " ");
        return;
    }

    uint32 count = 0;

    do
    {
        Field* fields = result->Fetch();

        ++count;

        uint32 Trigger_ID = fields[0].Get<uint32>();

        AreaTriggerTeleport at;

        at.target_mapId             = fields[1].Get<uint16>();
        at.target_X                 = fields[2].Get<float>();
        at.target_Y                 = fields[3].Get<float>();
        at.target_Z                 = fields[4].Get<float>();
        at.target_Orientation       = fields[5].Get<float>();

        AreaTrigger const* atEntry = GetAreaTrigger(Trigger_ID);
        if (!atEntry)
        {
            LOG_ERROR("sql.sql", "Area trigger (ID:{}) does not exist in `AreaTrigger.dbc`.", Trigger_ID);
            continue;
        }

        MapEntry const* mapEntry = sMapStore.LookupEntry(at.target_mapId);
        if (!mapEntry)
        {
            LOG_ERROR("sql.sql", "Area trigger (ID:{}) target map (ID: {}) does not exist in `Map.dbc`.", Trigger_ID, at.target_mapId);
            continue;
        }

        if (at.target_X == 0 && at.target_Y == 0 && at.target_Z == 0)
        {
            LOG_ERROR("sql.sql", "Area trigger (ID:{}) target coordinates not provided.", Trigger_ID);
            continue;
        }

        _areaTriggerTeleportStore[Trigger_ID] = at;
    } while (result->NextRow());

    LOG_INFO("server.loading", ">> Loaded {} Area Trigger Teleport Definitions in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
}

void ObjectMgr::LoadAccessRequirements()
{
    uint32 oldMSTime = getMSTime();

    if (!_accessRequirementStore.empty())
    {
        for (DungeonProgressionRequirementsContainer::iterator itr = _accessRequirementStore.begin(); itr != _accessRequirementStore.end(); ++itr)
        {
            std::unordered_map<uint8, DungeonProgressionRequirements*> difficulties = itr->second;
            for (auto difficultiesItr = difficulties.begin(); difficultiesItr != difficulties.end(); ++difficultiesItr)
            {
                for (auto questItr = difficultiesItr->second->quests.begin(); questItr != difficultiesItr->second->quests.end(); ++questItr)
                {
                    delete* questItr;
                }

                for (auto achievementItr = difficultiesItr->second->achievements.begin(); achievementItr != difficultiesItr->second->achievements.end(); ++achievementItr)
                {
                    delete* achievementItr;
                }

                for (auto itemsItr = difficultiesItr->second->items.begin(); itemsItr != difficultiesItr->second->items.end(); ++itemsItr)
                {
                    delete* itemsItr;
                }

                delete difficultiesItr->second;
            }
        }

        _accessRequirementStore.clear();                                  // need for reload case
    }
    //                                                               0       1            2           3          4            5
    QueryResult access_template_result = WorldDatabase.Query("SELECT id, map_id, difficulty, min_level, max_level, min_avg_item_level FROM dungeon_access_template");
    if (!access_template_result)
    {
        LOG_WARN("server.loading", ">> Loaded 0 access requirement definitions. DB table `dungeon_access_template` is empty.");
        LOG_INFO("server.loading", " ");
        return;
    }

    uint32 count = 0;
    uint32 countProgressionRequirements = 0;

    do
    {
        Field* fields = access_template_result->Fetch();

        //Get the common variables for the access requirements
        uint8 dungeon_access_id = fields[0].Get<uint8>();
        uint32 mapid            = fields[1].Get<uint32>();
        uint8 difficulty        = fields[2].Get<uint8>();

        //Set up the access requirements
        DungeonProgressionRequirements* ar = new DungeonProgressionRequirements();
        ar->levelMin     = fields[3].Get<uint8>();
        ar->levelMax     = fields[4].Get<uint8>();
        ar->reqItemLevel = fields[5].Get<uint16>();

        //                                                                              0                 1               2                 3        4         6
        QueryResult progression_requirements_results = WorldDatabase.Query("SELECT requirement_type, requirement_id, requirement_note, faction, priority, leader_only FROM dungeon_access_requirements where dungeon_access_id = {}", dungeon_access_id);
        if (progression_requirements_results)
        {
            do
            {
                Field* progression_requirement_row = progression_requirements_results->Fetch();

                const uint8 requirement_type             = progression_requirement_row[0].Get<uint8>();
                const uint32 requirement_id              = progression_requirement_row[1].Get<uint32>();
                const std::string requirement_note       = progression_requirement_row[2].Get<std::string>();
                const uint8 requirement_faction          = progression_requirement_row[3].Get<uint8>();
                const uint8 requirement_priority         = progression_requirement_row[4].IsNull() ? UINT8_MAX : progression_requirement_row[4].Get<uint8>();
                const bool requirement_checkLeaderOnly   = progression_requirement_row[5].Get<bool>();

                ProgressionRequirement* progression_requirement = new ProgressionRequirement();
                progression_requirement->id              = requirement_id;
                progression_requirement->note            = requirement_note;
                progression_requirement->faction         = (TeamId)requirement_faction;
                progression_requirement->priority        = requirement_priority;
                progression_requirement->checkLeaderOnly = requirement_checkLeaderOnly;

                std::vector<ProgressionRequirement*>* currentRequirementsList = nullptr;

                switch (requirement_type)
                {
                case 0:
                {
                    //Achievement
                    if (!sAchievementStore.LookupEntry(progression_requirement->id))
                    {
                        LOG_ERROR("sql.sql", "Required achievement {} for faction {} does not exist for map {} difficulty {}, remove or fix this achievement requirement.", progression_requirement->id, requirement_faction, mapid, difficulty);
                        break;
                    }

                    currentRequirementsList = &ar->achievements;
                    break;
                }
                case 1:
                {
                    //Quest
                    if (!GetQuestTemplate(progression_requirement->id))
                    {
                        LOG_ERROR("sql.sql", "Required quest {} for faction {} does not exist for map {} difficulty {}, remove or fix this quest requirement.", progression_requirement->id, requirement_faction, mapid, difficulty);
                        break;
                    }

                    currentRequirementsList = &ar->quests;
                    break;
                }
                case 2:
                {
                    //Item
                    ItemTemplate const* pProto = GetItemTemplate(progression_requirement->id);
                    if (!pProto)
                    {
                        LOG_ERROR("sql.sql", "Required item {} for faction {} does not exist for map {} difficulty {}, remove or fix this item requirement.", progression_requirement->id, requirement_faction, mapid, difficulty);
                        break;
                    }

                    currentRequirementsList = &ar->items;
                    break;
                }
                default:
                    LOG_ERROR("sql.sql", "requirement_type of {} is not valid for map {} difficulty {}. Please use 0 for achievements, 1 for quest, 2 for items or remove this entry from the db.", requirement_type, mapid, difficulty);
                    break;
                }

                //Check if array is valid and delete the progression requirement
                if (!currentRequirementsList)
                {
                    delete progression_requirement;
                    continue;
                }

                //Insert into the array
                if (currentRequirementsList->size() > requirement_priority)
                {
                    currentRequirementsList->insert(currentRequirementsList->begin() + requirement_priority, progression_requirement);
                }
                else
                {
                    currentRequirementsList->push_back(progression_requirement);
                }

            } while (progression_requirements_results->NextRow());
        }

        //Sort all arrays for priority
        auto sortFunction = [](const ProgressionRequirement* const a, const ProgressionRequirement* const b) {return a->priority > b->priority; };
        std::sort(ar->achievements.begin(), ar->achievements.end(), sortFunction);
        std::sort(ar->quests.begin(), ar->quests.end(), sortFunction);
        std::sort(ar->items.begin(), ar->items.end(), sortFunction);

        countProgressionRequirements += ar->achievements.size();
        countProgressionRequirements += ar->quests.size();
        countProgressionRequirements += ar->items.size();
        count++;

        _accessRequirementStore[mapid][difficulty] = ar;
    } while (access_template_result->NextRow());

    LOG_INFO("server.loading", ">> Loaded {} Rows From dungeon_access_template And {} Rows From dungeon_access_requirements in {} ms", count, countProgressionRequirements, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
}

/*
 * Searches for the areatrigger which teleports players out of the given map with instance_template.parent field support
 */
AreaTriggerTeleport const* ObjectMgr::GetGoBackTrigger(uint32 Map) const
{
    bool useParentDbValue = false;
    uint32 parentId = 0;
    MapEntry const* mapEntry = sMapStore.LookupEntry(Map);
    if (!mapEntry || mapEntry->entrance_map < 0)
        return nullptr;

    if (mapEntry->IsDungeon())
    {
        InstanceTemplate const* iTemplate = sObjectMgr->GetInstanceTemplate(Map);

        if (!iTemplate)
            return nullptr;

        parentId = iTemplate->Parent;
        useParentDbValue = true;
    }

    uint32 entrance_map = uint32(mapEntry->entrance_map);
    for (AreaTriggerTeleportContainer::const_iterator itr = _areaTriggerTeleportStore.begin(); itr != _areaTriggerTeleportStore.end(); ++itr)
        if ((!useParentDbValue && itr->second.target_mapId == entrance_map) || (useParentDbValue && itr->second.target_mapId == parentId))
        {
            AreaTrigger const* atEntry = GetAreaTrigger(itr->first);
            if (atEntry && atEntry->map == Map)
                return &itr->second;
        }
    return nullptr;
}

/**
 * Searches for the areatrigger which teleports players to the given map
 */
AreaTriggerTeleport const* ObjectMgr::GetMapEntranceTrigger(uint32 Map) const
{
    for (AreaTriggerTeleportContainer::const_iterator itr = _areaTriggerTeleportStore.begin(); itr != _areaTriggerTeleportStore.end(); ++itr)
    {
        if (itr->second.target_mapId == Map) // Id is used to determine correct Scarlet Monastery instance
        {
            // xinef: no need to check, already done at loading
            //AreaTriggerEntry const* atEntry = sAreaTriggerStore.LookupEntry(itr->first);
            //if (atEntry)
            return &itr->second;
        }
    }
    return nullptr;
}

void ObjectMgr::SetHighestGuids()
{
    QueryResult result = CharacterDatabase.Query("SELECT MAX(guid) FROM characters");
    if (result)
        GetGuidSequenceGenerator<HighGuid::Player>().Set((*result)[0].Get<uint32>() + 1);

    result = CharacterDatabase.Query("SELECT MAX(guid) FROM item_instance");
    if (result)
        GetGuidSequenceGenerator<HighGuid::Item>().Set((*result)[0].Get<uint32>() + 1);

    // Cleanup other tables from not existed guids ( >= _hiItemGuid)
    CharacterDatabase.Execute("DELETE FROM character_inventory WHERE item >= '{}'", GetGuidSequenceGenerator<HighGuid::Item>().GetNextAfterMaxUsed());     // One-time query
    CharacterDatabase.Execute("DELETE FROM mail_items WHERE item_guid >= '{}'", GetGuidSequenceGenerator<HighGuid::Item>().GetNextAfterMaxUsed());         // One-time query
    CharacterDatabase.Execute("DELETE FROM auctionhouse WHERE itemguid >= '{}'", GetGuidSequenceGenerator<HighGuid::Item>().GetNextAfterMaxUsed());        // One-time query
    CharacterDatabase.Execute("DELETE FROM guild_bank_item WHERE item_guid >= '{}'", GetGuidSequenceGenerator<HighGuid::Item>().GetNextAfterMaxUsed());    // One-time query

    result = WorldDatabase.Query("SELECT MAX(guid) FROM transports");
    if (result)
        GetGuidSequenceGenerator<HighGuid::Mo_Transport>().Set((*result)[0].Get<uint32>() + 1);

    result = CharacterDatabase.Query("SELECT MAX(id) FROM auctionhouse");
    if (result)
        _auctionId = (*result)[0].Get<uint32>() + 1;

    result = CharacterDatabase.Query("SELECT MAX(id) FROM mail");
    if (result)
        _mailId = (*result)[0].Get<uint32>() + 1;

    result = CharacterDatabase.Query("SELECT MAX(arenateamid) FROM arena_team");
    if (result)
        sArenaTeamMgr->SetNextArenaTeamId((*result)[0].Get<uint32>() + 1);

    result = CharacterDatabase.Query("SELECT MAX(fight_id) FROM log_arena_fights");
    if (result)
        sArenaTeamMgr->SetLastArenaLogId((*result)[0].Get<uint32>());

    result = CharacterDatabase.Query("SELECT MAX(setguid) FROM character_equipmentsets");
    if (result)
        _equipmentSetGuid = (*result)[0].Get<uint64>() + 1;

    result = CharacterDatabase.Query("SELECT MAX(guildId) FROM guild");
    if (result)
        sGuildMgr->SetNextGuildId((*result)[0].Get<uint32>() + 1);

    result = WorldDatabase.Query("SELECT MAX(guid) FROM creature");
    if (result)
        _creatureSpawnId = (*result)[0].Get<uint32>() + 1;

    result = WorldDatabase.Query("SELECT MAX(guid) FROM gameobject");
    if (result)
        _gameObjectSpawnId = (*result)[0].Get<uint32>() + 1;
}

uint32 ObjectMgr::GenerateAuctionID()
{
    if (_auctionId >= 0xFFFFFFFE)
    {
        LOG_ERROR("server.worldserver", "Auctions ids overflow!! Can't continue, shutting down server. ");
        World::StopNow(ERROR_EXIT_CODE);
    }
    return _auctionId++;
}

uint64 ObjectMgr::GenerateEquipmentSetGuid()
{
    if (_equipmentSetGuid >= uint64(0xFFFFFFFFFFFFFFFELL))
    {
        LOG_ERROR("server.worldserver", "EquipmentSet guid overflow!! Can't continue, shutting down server. ");
        World::StopNow(ERROR_EXIT_CODE);
    }
    return _equipmentSetGuid++;
}

uint32 ObjectMgr::GenerateMailID()
{
    if (_mailId >= 0xFFFFFFFE)
    {
        LOG_ERROR("server.worldserver", "Mail ids overflow!! Can't continue, shutting down server. ");
        World::StopNow(ERROR_EXIT_CODE);
    }
    std::lock_guard<std::mutex> guard(_mailIdMutex);
    return _mailId++;
}

uint32 ObjectMgr::GenerateCreatureSpawnId()
{
    if (_creatureSpawnId >= uint32(0xFFFFFF))
    {
        LOG_ERROR("server.worldserver", "Creature spawn id overflow!! Can't continue, shutting down server. Search on forum for TCE00007 for more info.");
        World::StopNow(ERROR_EXIT_CODE);
    }
    return _creatureSpawnId++;
}

uint32 ObjectMgr::GenerateGameObjectSpawnId()
{
    if (_gameObjectSpawnId >= uint32(0xFFFFFF))
    {
        LOG_ERROR("server.worldserver", "GameObject spawn id overflow!! Can't continue, shutting down server. Search on forum for TCE00007 for more info. ");
        World::StopNow(ERROR_EXIT_CODE);
    }
    return _gameObjectSpawnId++;
}

void ObjectMgr::LoadGameObjectLocales()
{
    uint32 oldMSTime = getMSTime();

    _gameObjectLocaleStore.clear(); // need for reload case

    //                                               0      1       2     3
    QueryResult result = WorldDatabase.Query("SELECT entry, locale, name, castBarCaption FROM gameobject_template_locale");
    if (!result)
        return;

    do
    {
        Field* fields = result->Fetch();

        uint32 ID = fields[0].Get<uint32>();

        LocaleConstant locale = GetLocaleByName(fields[1].Get<std::string>());
        if (locale == LOCALE_enUS)
            continue;

        GameObjectLocale& data = _gameObjectLocaleStore[ID];
        AddLocaleString(fields[2].Get<std::string>(), locale, data.Name);
        AddLocaleString(fields[3].Get<std::string>(), locale, data.CastBarCaption);
    } while (result->NextRow());

    LOG_INFO("server.loading", ">> Loaded {} Gameobject Locale Strings in {} ms", (uint32)_gameObjectLocaleStore.size(), GetMSTimeDiffToNow(oldMSTime));
}

inline void CheckGOLockId(GameObjectTemplate const* goInfo, uint32 dataN, uint32 N)
{
    if (sLockStore.LookupEntry(dataN))
        return;

    LOG_ERROR("sql.sql", "Gameobject (Entry: {} GoType: {}) have data{}={} but lock (Id: {}) not found.",
                     goInfo->entry, goInfo->type, N, goInfo->door.lockId, goInfo->door.lockId);
}

inline void CheckGOLinkedTrapId(GameObjectTemplate const* goInfo, uint32 dataN, uint32 N)
{
    if (GameObjectTemplate const* trapInfo = sObjectMgr->GetGameObjectTemplate(dataN))
    {
        if (trapInfo->type != GAMEOBJECT_TYPE_TRAP)
            LOG_ERROR("sql.sql", "Gameobject (Entry: {} GoType: {}) have data{}={} but GO (Entry {}) have not GAMEOBJECT_TYPE_TRAP ({}) type.",
                             goInfo->entry, goInfo->type, N, dataN, dataN, GAMEOBJECT_TYPE_TRAP);
    }
}

inline void CheckGOSpellId(GameObjectTemplate const* goInfo, uint32 dataN, uint32 N)
{
    if (sSpellMgr->GetSpellInfo(dataN))
        return;

    LOG_ERROR("sql.sql", "Gameobject (Entry: {} GoType: {}) have data{}={} but Spell (Entry {}) not exist.",
                     goInfo->entry, goInfo->type, N, dataN, dataN);
}

inline void CheckAndFixGOChairHeightId(GameObjectTemplate const* goInfo, uint32 const& dataN, uint32 N)
{
    if (dataN <= (UNIT_STAND_STATE_SIT_HIGH_CHAIR - UNIT_STAND_STATE_SIT_LOW_CHAIR))
        return;

    LOG_ERROR("sql.sql", "Gameobject (Entry: {} GoType: {}) have data{}={} but correct chair height in range 0..{}.",
                     goInfo->entry, goInfo->type, N, dataN, UNIT_STAND_STATE_SIT_HIGH_CHAIR - UNIT_STAND_STATE_SIT_LOW_CHAIR);

    // prevent client and server unexpected work
    const_cast<uint32&>(dataN) = 0;
}

inline void CheckGONoDamageImmuneId(GameObjectTemplate* goTemplate, uint32 dataN, uint32 N)
{
    // 0/1 correct values
    if (dataN <= 1)
        return;

    LOG_ERROR("sql.sql", "Gameobject (Entry: {} GoType: {}) have data{}={} but expected boolean (0/1) noDamageImmune field value.", goTemplate->entry, goTemplate->type, N, dataN);
}

inline void CheckGOConsumable(GameObjectTemplate const* goInfo, uint32 dataN, uint32 N)
{
    // 0/1 correct values
    if (dataN <= 1)
        return;

    LOG_ERROR("sql.sql", "Gameobject (Entry: {} GoType: {}) have data{}={} but expected boolean (0/1) consumable field value.",
                     goInfo->entry, goInfo->type, N, dataN);
}

void ObjectMgr::LoadGameObjectTemplate()
{
    uint32 oldMSTime = getMSTime();

    //                                                 0      1      2        3       4             5          6      7
    QueryResult result = WorldDatabase.Query("SELECT entry, type, displayId, name, IconName, castBarCaption, unk1, size, "
                         //                                          8      9      10     11     12     13     14     15     16     17     18      19      20
                         "Data0, Data1, Data2, Data3, Data4, Data5, Data6, Data7, Data8, Data9, Data10, Data11, Data12, "
                         //                                          21      22      23      24      25      26      27      28      29      30      31      32        33
                         "Data13, Data14, Data15, Data16, Data17, Data18, Data19, Data20, Data21, Data22, Data23, AIName, ScriptName "
                         "FROM gameobject_template");

    if (!result)
    {
        LOG_WARN("server.loading", ">> Loaded 0 gameobject definitions. DB table `gameobject_template` is empty.");
        LOG_INFO("server.loading", " ");
        return;
    }

    _gameObjectTemplateStore.rehash(result->GetRowCount());
    uint32 count = 0;
    do
    {
        Field* fields = result->Fetch();

        uint32 entry = fields[0].Get<uint32>();

        GameObjectTemplate& got = _gameObjectTemplateStore[entry];

        got.entry          = entry;
        got.type           = uint32(fields[1].Get<uint8>());
        got.displayId      = fields[2].Get<uint32>();
        got.name           = fields[3].Get<std::string>();
        got.IconName       = fields[4].Get<std::string>();
        got.castBarCaption = fields[5].Get<std::string>();
        got.unk1           = fields[6].Get<std::string>();
        got.size           = fields[7].Get<float>();

        for (uint8 i = 0; i < MAX_GAMEOBJECT_DATA; ++i)
            got.raw.data[i] = fields[8 + i].Get<int32>(); // data1 and data6 can be -1

        got.AIName = fields[32].Get<std::string>();
        got.ScriptId = GetScriptId(fields[33].Get<std::string>());
        got.IsForQuests = false;

        // Checks
        if (!got.AIName.empty() && !sGameObjectAIRegistry->HasItem(got.AIName))
        {
            LOG_ERROR("sql.sql", "GameObject (Entry: {}) has non-registered `AIName` '{}' set, removing", got.entry, got.AIName);
        }

        switch (got.type)
        {
            case GAMEOBJECT_TYPE_DOOR:                      //0
                {
                    if (got.door.lockId)
                        CheckGOLockId(&got, got.door.lockId, 1);
                    CheckGONoDamageImmuneId(&got, got.door.noDamageImmune, 3);
                    break;
                }
            case GAMEOBJECT_TYPE_BUTTON:                    //1
                {
                    if (got.button.lockId)
                        CheckGOLockId(&got, got.button.lockId, 1);
                    CheckGONoDamageImmuneId(&got, got.button.noDamageImmune, 4);
                    break;
                }
            case GAMEOBJECT_TYPE_QUESTGIVER:                //2
                {
                    if (got.questgiver.lockId)
                        CheckGOLockId(&got, got.questgiver.lockId, 0);
                    CheckGONoDamageImmuneId(&got, got.questgiver.noDamageImmune, 5);
                    break;
                }
            case GAMEOBJECT_TYPE_CHEST:                     //3
                {
                    if (got.chest.lockId)
                        CheckGOLockId(&got, got.chest.lockId, 0);

                    CheckGOConsumable(&got, got.chest.consumable, 3);

                    if (got.chest.linkedTrapId)              // linked trap
                        CheckGOLinkedTrapId(&got, got.chest.linkedTrapId, 7);
                    break;
                }
            case GAMEOBJECT_TYPE_TRAP:                      //6
                {
                    if (got.trap.lockId)
                        CheckGOLockId(&got, got.trap.lockId, 0);
                    break;
                }
            case GAMEOBJECT_TYPE_CHAIR:                     //7
                CheckAndFixGOChairHeightId(&got, got.chair.height, 1);
                break;
            case GAMEOBJECT_TYPE_SPELL_FOCUS:               //8
                {
                    if (got.spellFocus.focusId)
                    {
                        if (!sSpellFocusObjectStore.LookupEntry(got.spellFocus.focusId))
                            LOG_ERROR("sql.sql", "GameObject (Entry: {} GoType: {}) have data0={} but SpellFocus (Id: {}) not exist.",
                                             entry, got.type, got.spellFocus.focusId, got.spellFocus.focusId);
                    }

                    if (got.spellFocus.linkedTrapId)        // linked trap
                        CheckGOLinkedTrapId(&got, got.spellFocus.linkedTrapId, 2);
                    break;
                }
            case GAMEOBJECT_TYPE_GOOBER:                    //10
                {
                    if (got.goober.lockId)
                        CheckGOLockId(&got, got.goober.lockId, 0);

                    CheckGOConsumable(&got, got.goober.consumable, 3);

                    if (got.goober.pageId)                  // pageId
                    {
                        if (!GetPageText(got.goober.pageId))
                            LOG_ERROR("sql.sql", "GameObject (Entry: {} GoType: {}) have data7={} but PageText (Entry {}) not exist.",
                                             entry, got.type, got.goober.pageId, got.goober.pageId);
                    }
                    CheckGONoDamageImmuneId(&got, got.goober.noDamageImmune, 11);
                    if (got.goober.linkedTrapId)            // linked trap
                        CheckGOLinkedTrapId(&got, got.goober.linkedTrapId, 12);
                    break;
                }
            case GAMEOBJECT_TYPE_AREADAMAGE:                //12
                {
                    if (got.areadamage.lockId)
                        CheckGOLockId(&got, got.areadamage.lockId, 0);
                    break;
                }
            case GAMEOBJECT_TYPE_CAMERA:                    //13
                {
                    if (got.camera.lockId)
                        CheckGOLockId(&got, got.camera.lockId, 0);
                    break;
                }
            case GAMEOBJECT_TYPE_MO_TRANSPORT:              //15
                {
                    if (got.moTransport.taxiPathId)
                    {
                        if (got.moTransport.taxiPathId >= sTaxiPathNodesByPath.size() || sTaxiPathNodesByPath[got.moTransport.taxiPathId].empty())
                            LOG_ERROR("sql.sql", "GameObject (Entry: {} GoType: {}) have data0={} but TaxiPath (Id: {}) not exist.",
                                             entry, got.type, got.moTransport.taxiPathId, got.moTransport.taxiPathId);
                    }
                    if (uint32 transportMap = got.moTransport.mapID)
                        _transportMaps.insert(transportMap);
                    break;
                }
            case GAMEOBJECT_TYPE_SUMMONING_RITUAL:          //18
                break;
            case GAMEOBJECT_TYPE_SPELLCASTER:               //22
                {
                    // always must have spell
                    CheckGOSpellId(&got, got.spellcaster.spellId, 0);
                    break;
                }
            case GAMEOBJECT_TYPE_FLAGSTAND:                 //24
                {
                    if (got.flagstand.lockId)
                        CheckGOLockId(&got, got.flagstand.lockId, 0);
                    CheckGONoDamageImmuneId(&got, got.flagstand.noDamageImmune, 5);
                    break;
                }
            case GAMEOBJECT_TYPE_FISHINGHOLE:               //25
                {
                    if (got.fishinghole.lockId)
                        CheckGOLockId(&got, got.fishinghole.lockId, 4);
                    break;
                }
            case GAMEOBJECT_TYPE_FLAGDROP:                  //26
                {
                    if (got.flagdrop.lockId)
                        CheckGOLockId(&got, got.flagdrop.lockId, 0);
                    CheckGONoDamageImmuneId(&got, got.flagdrop.noDamageImmune, 3);
                    break;
                }
            case GAMEOBJECT_TYPE_BARBER_CHAIR:              //32
                CheckAndFixGOChairHeightId(&got, got.barberChair.chairheight, 0);
                break;
        }

        ++count;
    } while (result->NextRow());

    LOG_INFO("server.loading", ">> Loaded {} Game Object Templates in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
}

void ObjectMgr::LoadGameObjectTemplateAddons()
{
    uint32 oldMSTime = getMSTime();

    //                                                0       1       2      3        4       5        6        7        8
    QueryResult result = WorldDatabase.Query("SELECT entry, faction, flags, mingold, maxgold, artkit0, artkit1, artkit2, artkit3 FROM gameobject_template_addon");

    if (!result)
    {
        LOG_WARN("server.loading", ">> Loaded 0 gameobject template addon definitions. DB table `gameobject_template_addon` is empty.");
        LOG_INFO("server.loading", " ");
        return;
    }

    uint32 count = 0;
    do
    {
        Field* fields = result->Fetch();

        uint32 entry = fields[0].Get<uint32>();

        GameObjectTemplate const* got = sObjectMgr->GetGameObjectTemplate(entry);
        if (!got)
        {
            LOG_ERROR("sql.sql",
                "GameObject template (Entry: {}) does not exist but has a record in `gameobject_template_addon`",
                entry);
            continue;
        }

        GameObjectTemplateAddon& gameObjectAddon = _gameObjectTemplateAddonStore[entry];
        gameObjectAddon.faction = uint32(fields[1].Get<uint16>());
        gameObjectAddon.flags   = fields[2].Get<uint32>();
        gameObjectAddon.mingold = fields[3].Get<uint32>();
        gameObjectAddon.maxgold = fields[4].Get<uint32>();

        for (uint32 i = 0; i < gameObjectAddon.artKits.size(); i++)
        {
            uint32 artKitID = fields[5 + i].Get<uint32>();
            if (!artKitID)
                continue;

            if (!sGameObjectArtKitStore.LookupEntry(artKitID))
            {
                LOG_ERROR("sql.sql", "GameObject (Entry: {}) has invalid `artkit{}` {} defined, set to zero instead.", entry, i, artKitID);
                continue;
            }

            gameObjectAddon.artKits[i] = artKitID;
        }

        // checks
        if (gameObjectAddon.faction && !sFactionTemplateStore.LookupEntry(gameObjectAddon.faction))
            LOG_ERROR("sql.sql",
                "GameObject (Entry: {}) has invalid faction ({}) defined in `gameobject_template_addon`.",
                entry, gameObjectAddon.faction);

        if (gameObjectAddon.maxgold > 0)
        {
            switch (got->type)
            {
                case GAMEOBJECT_TYPE_CHEST:
                case GAMEOBJECT_TYPE_FISHINGHOLE:
                    break;
                default:
                    LOG_ERROR("sql.sql",
                        "GameObject (Entry {} GoType: {}) cannot be looted but has maxgold set in `gameobject_template_addon`.",
                        entry, got->type);
                    break;
            }
        }

        ++count;
    } while (result->NextRow());

    LOG_INFO("server.loading", ">> Loaded {} Game Object Template Addons in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
}

void ObjectMgr::LoadExplorationBaseXP()
{
    uint32 oldMSTime = getMSTime();

    QueryResult result = WorldDatabase.Query("SELECT level, basexp FROM exploration_basexp");

    if (!result)
    {
        LOG_WARN("server.loading", ">> Loaded 0 BaseXP definitions. DB table `exploration_basexp` is empty.");
        LOG_INFO("server.loading", " ");
        return;
    }

    uint32 count = 0;

    do
    {
        Field* fields = result->Fetch();
        uint8 level  = fields[0].Get<uint8>();
        uint32 basexp = fields[1].Get<int32>();
        _baseXPTable[level] = basexp;
        ++count;
    } while (result->NextRow());

    LOG_INFO("server.loading", ">> Loaded {} BaseXP Definitions in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
}

uint32 ObjectMgr::GetBaseXP(uint8 level)
{
    return _baseXPTable[level] ? _baseXPTable[level] : 0;
}

uint32 ObjectMgr::GetXPForLevel(uint8 level) const
{
    if (level < _playerXPperLevel.size())
        return _playerXPperLevel[level];
    return 0;
}

void ObjectMgr::LoadPetNames()
{
    uint32 oldMSTime = getMSTime();
    //                                                0     1      2
    QueryResult result = WorldDatabase.Query("SELECT word, entry, half FROM pet_name_generation");

    if (!result)
    {
        LOG_WARN("server.loading", ">> Loaded 0 pet name parts. DB table `pet_name_generation` is empty!");
        LOG_INFO("server.loading", " ");
        return;
    }

    uint32 count = 0;

    do
    {
        Field* fields = result->Fetch();
        std::string word = fields[0].Get<std::string>();
        uint32 entry     = fields[1].Get<uint32>();
        bool   half      = fields[2].Get<bool>();
        if (half)
            _petHalfName1[entry].push_back(word);
        else
            _petHalfName0[entry].push_back(word);
        ++count;
    } while (result->NextRow());

    LOG_INFO("server.loading", ">> Loaded {} Pet Name Parts in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
}

void ObjectMgr::LoadPetNumber()
{
    uint32 oldMSTime = getMSTime();

    QueryResult result = CharacterDatabase.Query("SELECT MAX(id) FROM character_pet");
    if (result)
    {
        Field* fields = result->Fetch();
        _hiPetNumber = fields[0].Get<uint32>() + 1;
    }

    LOG_INFO("server.loading", ">> Loaded The Max Pet Number: {} in {} ms", _hiPetNumber - 1, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
}

std::string ObjectMgr::GeneratePetNameLocale(uint32 entry, LocaleConstant locale)
{
    std::vector<std::string>& list0 = _petHalfLocaleName0[std::make_pair(entry, locale)];
    std::vector<std::string>& list1 = _petHalfLocaleName1[std::make_pair(entry, locale)];

    if (list0.empty() || list1.empty())
    {
       return GeneratePetName(entry);
    }

    return *(list0.begin() + urand(0, list0.size() - 1)) + *(list1.begin() + urand(0, list1.size() - 1));
}

std::string ObjectMgr::GeneratePetName(uint32 entry)
{
    std::vector<std::string>& list0 = _petHalfName0[entry];
    std::vector<std::string>& list1 = _petHalfName1[entry];

    if (list0.empty() || list1.empty())
    {
        CreatureTemplate const* cinfo = GetCreatureTemplate(entry);
        char const* petname = GetPetName(cinfo->family, sWorld->GetDefaultDbcLocale());
        if (!petname)
            return cinfo->Name;

        return std::string(petname);
    }

    return *(list0.begin() + urand(0, list0.size() - 1)) + *(list1.begin() + urand(0, list1.size() - 1));
}

uint32 ObjectMgr::GeneratePetNumber()
{
    std::lock_guard<std::mutex> guard(_hiPetNumberMutex);
    return ++_hiPetNumber;
}

void ObjectMgr::LoadReputationRewardRate()
{
    uint32 oldMSTime = getMSTime();

    _repRewardRateStore.clear();                             // for reload case

    uint32 count = 0; //                                0          1             2                  3                  4                 5                      6             7
    QueryResult result = WorldDatabase.Query("SELECT faction, quest_rate, quest_daily_rate, quest_weekly_rate, quest_monthly_rate, quest_repeatable_rate, creature_rate, spell_rate FROM reputation_reward_rate");
    if (!result)
    {
        LOG_INFO("server.loading", ">> Loaded `reputation_reward_rate`, table is empty!");
        return;
    }

    do
    {
        Field* fields = result->Fetch();

        uint32 factionId            = fields[0].Get<uint32>();

        RepRewardRate repRate;

        repRate.questRate           = fields[1].Get<float>();
        repRate.questDailyRate      = fields[2].Get<float>();
        repRate.questWeeklyRate     = fields[3].Get<float>();
        repRate.questMonthlyRate    = fields[4].Get<float>();
        repRate.questRepeatableRate = fields[5].Get<float>();
        repRate.creatureRate        = fields[6].Get<float>();
        repRate.spellRate           = fields[7].Get<float>();

        FactionEntry const* factionEntry = sFactionStore.LookupEntry(factionId);
        if (!factionEntry)
        {
            LOG_ERROR("sql.sql", "Faction (faction.dbc) {} does not exist but is used in `reputation_reward_rate`", factionId);
            continue;
        }

        if (repRate.questRate < 0.0f)
        {
            LOG_ERROR("sql.sql", "Table reputation_reward_rate has quest_rate with invalid rate {}, skipping data for faction {}", repRate.questRate, factionId);
            continue;
        }

        if (repRate.questDailyRate < 0.0f)
        {
            LOG_ERROR("sql.sql", "Table reputation_reward_rate has quest_daily_rate with invalid rate {}, skipping data for faction {}", repRate.questDailyRate, factionId);
            continue;
        }

        if (repRate.questWeeklyRate < 0.0f)
        {
            LOG_ERROR("sql.sql", "Table reputation_reward_rate has quest_weekly_rate with invalid rate {}, skipping data for faction {}", repRate.questWeeklyRate, factionId);
            continue;
        }

        if (repRate.questMonthlyRate < 0.0f)
        {
            LOG_ERROR("sql.sql", "Table reputation_reward_rate has quest_monthly_rate with invalid rate {}, skipping data for faction {}", repRate.questMonthlyRate, factionId);
            continue;
        }

        if (repRate.questRepeatableRate < 0.0f)
        {
            LOG_ERROR("sql.sql", "Table reputation_reward_rate has quest_repeatable_rate with invalid rate {}, skipping data for faction {}", repRate.questRepeatableRate, factionId);
            continue;
        }

        if (repRate.creatureRate < 0.0f)
        {
            LOG_ERROR("sql.sql", "Table reputation_reward_rate has creature_rate with invalid rate {}, skipping data for faction {}", repRate.creatureRate, factionId);
            continue;
        }

        if (repRate.spellRate < 0.0f)
        {
            LOG_ERROR("sql.sql", "Table reputation_reward_rate has spell_rate with invalid rate {}, skipping data for faction {}", repRate.spellRate, factionId);
            continue;
        }

        _repRewardRateStore[factionId] = repRate;

        ++count;
    } while (result->NextRow());

    LOG_INFO("server.loading", ">> Loaded {} Reputation Reward Rate in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
}

void ObjectMgr::LoadReputationOnKill()
{
    uint32 oldMSTime = getMSTime();

    // For reload case
    _repOnKillStore.clear();

    uint32 count = 0;

    //                                                0            1                     2
    QueryResult result = WorldDatabase.Query("SELECT creature_id, RewOnKillRepFaction1, RewOnKillRepFaction2, "
                         //   3             4             5                   6             7             8                   9
                         "IsTeamAward1, MaxStanding1, RewOnKillRepValue1, IsTeamAward2, MaxStanding2, RewOnKillRepValue2, TeamDependent "
                         "FROM creature_onkill_reputation");

    if (!result)
    {
        LOG_WARN("server.loading", ">> Loaded 0 creature award reputation definitions. DB table `creature_onkill_reputation` is empty.");
        LOG_INFO("server.loading", " ");
        return;
    }

    do
    {
        Field* fields = result->Fetch();

        uint32 creature_id = fields[0].Get<uint32>();

        ReputationOnKillEntry repOnKill;
        repOnKill.RepFaction1          = fields[1].Get<int16>();
        repOnKill.RepFaction2          = fields[2].Get<int16>();
        repOnKill.IsTeamAward1        = fields[3].Get<bool>();
        repOnKill.ReputationMaxCap1  = fields[4].Get<uint8>();
        repOnKill.RepValue1            = fields[5].Get<float>();
        repOnKill.IsTeamAward2        = fields[6].Get<bool>();
        repOnKill.ReputationMaxCap2  = fields[7].Get<uint8>();
        repOnKill.RepValue2            = fields[8].Get<float>();
        repOnKill.TeamDependent       = fields[9].Get<uint8>();

        if (!GetCreatureTemplate(creature_id))
        {
            LOG_ERROR("sql.sql", "Table `creature_onkill_reputation` have data for not existed creature entry ({}), skipped", creature_id);
            continue;
        }

        if (repOnKill.RepFaction1)
        {
            FactionEntry const* factionEntry1 = sFactionStore.LookupEntry(repOnKill.RepFaction1);
            if (!factionEntry1)
            {
                LOG_ERROR("sql.sql", "Faction (faction.dbc) {} does not exist but is used in `creature_onkill_reputation`", repOnKill.RepFaction1);
                continue;
            }
        }

        if (repOnKill.RepFaction2)
        {
            FactionEntry const* factionEntry2 = sFactionStore.LookupEntry(repOnKill.RepFaction2);
            if (!factionEntry2)
            {
                LOG_ERROR("sql.sql", "Faction (faction.dbc) {} does not exist but is used in `creature_onkill_reputation`", repOnKill.RepFaction2);
                continue;
            }
        }

        _repOnKillStore[creature_id] = repOnKill;

        ++count;
    } while (result->NextRow());

    LOG_INFO("server.loading", ">> Loaded {} Creature Award Reputation Definitions in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
}

void ObjectMgr::LoadReputationSpilloverTemplate()
{
    uint32 oldMSTime = getMSTime();

    _repSpilloverTemplateStore.clear();                      // for reload case

    uint32 count = 0; //                                0         1        2       3        4       5       6         7        8      9        10       11     12        13       14      15       16       17     18
    QueryResult result = WorldDatabase.Query("SELECT faction, faction1, rate_1, rank_1, faction2, rate_2, rank_2, faction3, rate_3, rank_3, faction4, rate_4, rank_4, faction5, rate_5, rank_5, faction6, rate_6, rank_6 FROM reputation_spillover_template");

    if (!result)
    {
        LOG_INFO("server.loading", ">> Loaded `reputation_spillover_template`, table is empty.");
        LOG_INFO("server.loading", " ");
        return;
    }

    do
    {
        Field* fields = result->Fetch();

        uint32 factionId                = fields[0].Get<uint16>();

        RepSpilloverTemplate repTemplate;

        repTemplate.faction[0]          = fields[1].Get<uint16>();
        repTemplate.faction_rate[0]     = fields[2].Get<float>();
        repTemplate.faction_rank[0]     = fields[3].Get<uint8>();
        repTemplate.faction[1]          = fields[4].Get<uint16>();
        repTemplate.faction_rate[1]     = fields[5].Get<float>();
        repTemplate.faction_rank[1]     = fields[6].Get<uint8>();
        repTemplate.faction[2]          = fields[7].Get<uint16>();
        repTemplate.faction_rate[2]     = fields[8].Get<float>();
        repTemplate.faction_rank[2]     = fields[9].Get<uint8>();
        repTemplate.faction[3]          = fields[10].Get<uint16>();
        repTemplate.faction_rate[3]     = fields[11].Get<float>();
        repTemplate.faction_rank[3]     = fields[12].Get<uint8>();
        repTemplate.faction[4]          = fields[13].Get<uint16>();
        repTemplate.faction_rate[4]     = fields[14].Get<float>();
        repTemplate.faction_rank[4]     = fields[15].Get<uint8>();
        repTemplate.faction[5]          = fields[16].Get<uint16>();
        repTemplate.faction_rate[5]     = fields[17].Get<float>();
        repTemplate.faction_rank[5]     = fields[18].Get<uint8>();

        FactionEntry const* factionEntry = sFactionStore.LookupEntry(factionId);

        if (!factionEntry)
        {
            LOG_ERROR("sql.sql", "Faction (faction.dbc) {} does not exist but is used in `reputation_spillover_template`", factionId);
            continue;
        }

        if (factionEntry->team == 0)
        {
            LOG_ERROR("sql.sql", "Faction (faction.dbc) {} in `reputation_spillover_template` does not belong to any team, skipping", factionId);
            continue;
        }

        for (uint32 i = 0; i < MAX_SPILLOVER_FACTIONS; ++i)
        {
            if (repTemplate.faction[i])
            {
                FactionEntry const* factionSpillover = sFactionStore.LookupEntry(repTemplate.faction[i]);

                if (!factionSpillover)
                {
                    LOG_ERROR("sql.sql", "Spillover faction (faction.dbc) {} does not exist but is used in `reputation_spillover_template` for faction {}, skipping", repTemplate.faction[i], factionId);
                    continue;
                }

                if (factionSpillover->reputationListID < 0)
                {
                    LOG_ERROR("sql.sql", "Spillover faction (faction.dbc) {} for faction {} in `reputation_spillover_template` can not be listed for client, and then useless, skipping", repTemplate.faction[i], factionId);
                    continue;
                }

                if (repTemplate.faction_rank[i] >= MAX_REPUTATION_RANK)
                {
                    LOG_ERROR("sql.sql", "Rank {} used in `reputation_spillover_template` for spillover faction {} is not valid, skipping", repTemplate.faction_rank[i], repTemplate.faction[i]);
                    continue;
                }
            }
        }

        FactionEntry const* factionEntry0 = sFactionStore.LookupEntry(repTemplate.faction[0]);
        if (repTemplate.faction[0] && !factionEntry0)
        {
            LOG_ERROR("sql.sql", "Faction (faction.dbc) {} does not exist but is used in `reputation_spillover_template`", repTemplate.faction[0]);
            continue;
        }
        FactionEntry const* factionEntry1 = sFactionStore.LookupEntry(repTemplate.faction[1]);
        if (repTemplate.faction[1] && !factionEntry1)
        {
            LOG_ERROR("sql.sql", "Faction (faction.dbc) {} does not exist but is used in `reputation_spillover_template`", repTemplate.faction[1]);
            continue;
        }
        FactionEntry const* factionEntry2 = sFactionStore.LookupEntry(repTemplate.faction[2]);
        if (repTemplate.faction[2] && !factionEntry2)
        {
            LOG_ERROR("sql.sql", "Faction (faction.dbc) {} does not exist but is used in `reputation_spillover_template`", repTemplate.faction[2]);
            continue;
        }
        FactionEntry const* factionEntry3 = sFactionStore.LookupEntry(repTemplate.faction[3]);
        if (repTemplate.faction[3] && !factionEntry3)
        {
            LOG_ERROR("sql.sql", "Faction (faction.dbc) {} does not exist but is used in `reputation_spillover_template`", repTemplate.faction[3]);
            continue;
        }

        _repSpilloverTemplateStore[factionId] = repTemplate;

        ++count;
    } while (result->NextRow());

    LOG_INFO("server.loading", ">> Loaded {} Reputation Spillover Template in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
}

void ObjectMgr::LoadPointsOfInterest()
{
    uint32 oldMSTime = getMSTime();

    _pointsOfInterestStore.clear();                              // need for reload case

    uint32 count = 0;

    //                                               0       1          2        3     4      5    6
    QueryResult result = WorldDatabase.Query("SELECT ID, PositionX, PositionY, Icon, Flags, Importance, Name FROM points_of_interest");

    if (!result)
    {
        LOG_WARN("server.loading", ">> Loaded 0 Points of Interest definitions. DB table `points_of_interest` is empty.");
        LOG_INFO("server.loading", " ");
        return;
    }

    do
    {
        Field* fields = result->Fetch();

        uint32 point_id = fields[0].Get<uint32>();

        PointOfInterest POI;
        POI.ID          = point_id;
        POI.PositionX   = fields[1].Get<float>();
        POI.PositionY   = fields[2].Get<float>();
        POI.Icon        = fields[3].Get<uint32>();
        POI.Flags       = fields[4].Get<uint32>();
        POI.Importance  = fields[5].Get<uint32>();
        POI.Name        = fields[6].Get<std::string>();

        if (!Acore::IsValidMapCoord(POI.PositionX, POI.PositionY))
        {
            LOG_ERROR("sql.sql", "Table `points_of_interest` (ID: {}) have invalid coordinates (X: {} Y: {}), ignored.", point_id, POI.PositionX, POI.PositionY);
            continue;
        }

        _pointsOfInterestStore[point_id] = POI;

        ++count;
    } while (result->NextRow());

    LOG_INFO("server.loading", ">> Loaded {} Points of Interest Definitions in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
}

void ObjectMgr::LoadQuestPOI()
{
    if (!sWorld->getBoolConfig(CONFIG_QUEST_POI_ENABLED))
    {
        LOG_INFO("server.loading", ">> Loaded 0 quest POI definitions. Disabled by config.");
        LOG_INFO("server.loading", " ");
        return;
    }

    uint32 oldMSTime = getMSTime();

    _questPOIStore.clear();                              // need for reload case

    uint32 count = 0;

    //                                               0        1          2          3           4          5       6        7
    QueryResult result = WorldDatabase.Query("SELECT QuestID, id, ObjectiveIndex, MapID, WorldMapAreaId, Floor, Priority, Flags FROM quest_poi order by QuestID");

    if (!result)
    {
        LOG_WARN("server.loading", ">> Loaded 0 quest POI definitions. DB table `quest_poi` is empty.");
        LOG_INFO("server.loading", " ");
        return;
    }

    //                                                  0       1   2  3
    QueryResult points = WorldDatabase.Query("SELECT QuestID, Idx1, X, Y FROM quest_poi_points ORDER BY QuestID DESC, Idx2");

    std::vector<std::vector<std::vector<QuestPOIPoint> > > POIs;

    if (points)
    {
        // The first result should have the highest questId
        Field* fields = points->Fetch();
        uint32 questIdMax = fields[0].Get<uint32>();
        POIs.resize(questIdMax + 1);

        do
        {
            fields = points->Fetch();

            uint32 questId            = fields[0].Get<uint32>();
            uint32 id                 = fields[1].Get<uint32>();
            int32  x                  = fields[2].Get<int32>();
            int32  y                  = fields[3].Get<int32>();

            if (POIs[questId].size() <= id + 1)
                POIs[questId].resize(id + 10);

            QuestPOIPoint point(x, y);
            POIs[questId][id].push_back(point);
        } while (points->NextRow());
    }

    do
    {
        Field* fields = result->Fetch();

        uint32 questId            = fields[0].Get<uint32>();
        uint32 id                 = fields[1].Get<uint32>();
        int32 objIndex            = fields[2].Get<int32>();
        uint32 mapId              = fields[3].Get<uint32>();
        uint32 WorldMapAreaId     = fields[4].Get<uint32>();
        uint32 FloorId            = fields[5].Get<uint32>();
        uint32 unk3               = fields[6].Get<uint32>();
        uint32 unk4               = fields[7].Get<uint32>();

        QuestPOI POI(id, objIndex, mapId, WorldMapAreaId, FloorId, unk3, unk4);
        if (questId < POIs.size() && id < POIs[questId].size())
        {
            POI.points = POIs[questId][id];
            _questPOIStore[questId].push_back(POI);
        }
        else
            LOG_ERROR("sql.sql", "Table quest_poi references unknown quest points for quest {} POI id {}", questId, id);

        ++count;
    } while (result->NextRow());

    LOG_INFO("server.loading", ">> Loaded {} Quest POI definitions in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
}

void ObjectMgr::LoadNPCSpellClickSpells()
{
    uint32 oldMSTime = getMSTime();

    _spellClickInfoStore.clear();
    //                                                0          1         2            3
    QueryResult result = WorldDatabase.Query("SELECT npc_entry, spell_id, cast_flags, user_type FROM npc_spellclick_spells");

    if (!result)
    {
        LOG_WARN("server.loading", ">> Loaded 0 spellclick spells. DB table `npc_spellclick_spells` is empty.");
        LOG_INFO("server.loading", " ");
        return;
    }

    uint32 count = 0;

    do
    {
        Field* fields = result->Fetch();

        uint32 npc_entry = fields[0].Get<uint32>();
        CreatureTemplate const* cInfo = GetCreatureTemplate(npc_entry);
        if (!cInfo)
        {
            LOG_ERROR("sql.sql", "Table npc_spellclick_spells references unknown creature_template {}. Skipping entry.", npc_entry);
            continue;
        }

        uint32 spellid = fields[1].Get<uint32>();
        SpellInfo const* spellinfo = sSpellMgr->GetSpellInfo(spellid);
        if (!spellinfo)
        {
            LOG_ERROR("sql.sql", "Table npc_spellclick_spells references unknown spellid {}. Skipping entry.", spellid);
            continue;
        }

        uint8 userType = fields[3].Get<uint16>();
        if (userType >= SPELL_CLICK_USER_MAX)
            LOG_ERROR("sql.sql", "Table npc_spellclick_spells references unknown user type {}. Skipping entry.", uint32(userType));

        uint8 castFlags = fields[2].Get<uint8>();
        SpellClickInfo info;
        info.spellId = spellid;
        info.castFlags = castFlags;
        info.userType = SpellClickUserTypes(userType);
        _spellClickInfoStore.insert(SpellClickInfoContainer::value_type(npc_entry, info));

        ++count;
    } while (result->NextRow());

    // all spellclick data loaded, now we check if there are creatures with NPC_FLAG_SPELLCLICK but with no data
    // NOTE: It *CAN* be the other way around: no spellclick flag but with spellclick data, in case of creature-only vehicle accessories
    CreatureTemplateContainer const* ctc = sObjectMgr->GetCreatureTemplates();
    for (CreatureTemplateContainer::const_iterator itr = ctc->begin(); itr != ctc->end(); ++itr)
    {
        if ((itr->second.npcflag & UNIT_NPC_FLAG_SPELLCLICK) && _spellClickInfoStore.find(itr->second.Entry) == _spellClickInfoStore.end())
        {
            LOG_ERROR("sql.sql", "npc_spellclick_spells: Creature template {} has UNIT_NPC_FLAG_SPELLCLICK but no data in spellclick table! Removing flag", itr->second.Entry);
            const_cast<CreatureTemplate*>(&itr->second)->npcflag &= ~UNIT_NPC_FLAG_SPELLCLICK;
        }
    }

    LOG_INFO("server.loading", ">> Loaded {} Spellclick Definitions in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
}

void ObjectMgr::DeleteCreatureData(ObjectGuid::LowType guid)
{
    // remove mapid*cellid -> guid_set map
    CreatureData const* data = GetCreatureData(guid);
    if (data)
        RemoveCreatureFromGrid(guid, data);

    _creatureDataStore.erase(guid);
}

void ObjectMgr::DeleteGOData(ObjectGuid::LowType guid)
{
    // remove mapid*cellid -> guid_set map
    GameObjectData const* data = GetGameObjectData(guid);
    if (data)
        RemoveGameobjectFromGrid(guid, data);

    _gameObjectDataStore.erase(guid);
}

void ObjectMgr::LoadQuestRelationsHelper(QuestRelations& map, std::string const& table, bool starter, bool go)
{
    uint32 oldMSTime = getMSTime();

    map.clear();                                            // need for reload case

    uint32 count = 0;

    QueryResult result = WorldDatabase.Query("SELECT id, quest, pool_entry FROM {} qr LEFT JOIN pool_quest pq ON qr.quest = pq.entry", table);

    if (!result)
    {
        LOG_WARN("server.loading", ">> Loaded 0 quest relations from `{}`, table is empty.", table);
        LOG_INFO("server.loading", " ");
        return;
    }

    PooledQuestRelation* poolRelationMap = go ? &sPoolMgr->mQuestGORelation : &sPoolMgr->mQuestCreatureRelation;
    if (starter)
        poolRelationMap->clear();

    do
    {
        uint32 id     = result->Fetch()[0].Get<uint32>();
        uint32 quest  = result->Fetch()[1].Get<uint32>();
        uint32 poolId = result->Fetch()[2].Get<uint32>();

        if (_questTemplates.find(quest) == _questTemplates.end())
        {
            LOG_ERROR("sql.sql", "Table `{}`: Quest {} listed for entry {} does not exist.", table, quest, id);
            continue;
        }

        if (!poolId || !starter)
            map.insert(QuestRelations::value_type(id, quest));
        else if (starter)
            poolRelationMap->insert(PooledQuestRelation::value_type(quest, id));

        ++count;
    } while (result->NextRow());

    LOG_INFO("server.loading", ">> Loaded {} Quest Relations From {} in {} ms", count, table, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
}

void ObjectMgr::LoadGameobjectQuestStarters()
{
    LoadQuestRelationsHelper(_goQuestRelations, "gameobject_queststarter", true, true);

    for (QuestRelations::iterator itr = _goQuestRelations.begin(); itr != _goQuestRelations.end(); ++itr)
    {
        GameObjectTemplate const* goInfo = GetGameObjectTemplate(itr->first);
        if (!goInfo)
            LOG_ERROR("sql.sql", "Table `gameobject_queststarter` have data for not existed gameobject entry ({}) and existed quest {}", itr->first, itr->second);
        else if (goInfo->type != GAMEOBJECT_TYPE_QUESTGIVER)
            LOG_ERROR("sql.sql", "Table `gameobject_queststarter` have data gameobject entry ({}) for quest {}, but GO is not GAMEOBJECT_TYPE_QUESTGIVER", itr->first, itr->second);
    }
}

void ObjectMgr::LoadGameobjectQuestEnders()
{
    LoadQuestRelationsHelper(_goQuestInvolvedRelations, "gameobject_questender", false, true);

    for (QuestRelations::iterator itr = _goQuestInvolvedRelations.begin(); itr != _goQuestInvolvedRelations.end(); ++itr)
    {
        GameObjectTemplate const* goInfo = GetGameObjectTemplate(itr->first);
        if (!goInfo)
            LOG_ERROR("sql.sql", "Table `gameobject_questender` have data for not existed gameobject entry ({}) and existed quest {}", itr->first, itr->second);
        else if (goInfo->type != GAMEOBJECT_TYPE_QUESTGIVER)
            LOG_ERROR("sql.sql", "Table `gameobject_questender` have data gameobject entry ({}) for quest {}, but GO is not GAMEOBJECT_TYPE_QUESTGIVER", itr->first, itr->second);
    }
}

void ObjectMgr::LoadCreatureQuestStarters()
{
    LoadQuestRelationsHelper(_creatureQuestRelations, "creature_queststarter", true, false);

    for (QuestRelations::iterator itr = _creatureQuestRelations.begin(); itr != _creatureQuestRelations.end(); ++itr)
    {
        CreatureTemplate const* cInfo = GetCreatureTemplate(itr->first);
        if (!cInfo)
            LOG_ERROR("sql.sql", "Table `creature_queststarter` have data for not existed creature entry ({}) and existed quest {}", itr->first, itr->second);
        else if (!(cInfo->npcflag & UNIT_NPC_FLAG_QUESTGIVER))
            LOG_ERROR("sql.sql", "Table `creature_queststarter` has creature entry ({}) for quest {}, but npcflag does not include UNIT_NPC_FLAG_QUESTGIVER", itr->first, itr->second);
    }
}

void ObjectMgr::LoadCreatureQuestEnders()
{
    LoadQuestRelationsHelper(_creatureQuestInvolvedRelations, "creature_questender", false, false);

    for (QuestRelations::iterator itr = _creatureQuestInvolvedRelations.begin(); itr != _creatureQuestInvolvedRelations.end(); ++itr)
    {
        CreatureTemplate const* cInfo = GetCreatureTemplate(itr->first);
        if (!cInfo)
            LOG_ERROR("sql.sql", "Table `creature_questender` have data for not existed creature entry ({}) and existed quest {}", itr->first, itr->second);
        else if (!(cInfo->npcflag & UNIT_NPC_FLAG_QUESTGIVER))
            LOG_ERROR("sql.sql", "Table `creature_questender` has creature entry ({}) for quest {}, but npcflag does not include UNIT_NPC_FLAG_QUESTGIVER", itr->first, itr->second);
    }
}

void ObjectMgr::LoadReservedPlayersNames()
{
    uint32 oldMSTime = getMSTime();

    _reservedNamesStore.clear();                                // need for reload case

    QueryResult result = CharacterDatabase.Query("SELECT name FROM reserved_name");

    if (!result)
    {
        LOG_WARN("server.loading", ">> Loaded 0 reserved player names. DB table `reserved_name` is empty!");
        LOG_INFO("server.loading", " ");
        return;
    }

    uint32 count = 0;

    Field* fields;
    do
    {
        fields = result->Fetch();
        std::string name = fields[0].Get<std::string>();

        std::wstring wstr;
        if (!Utf8toWStr (name, wstr))
        {
            LOG_ERROR("sql.sql", "Table `reserved_name` have invalid name: {}", name);
            continue;
        }

        wstrToLower(wstr);

        _reservedNamesStore.insert(wstr);
        ++count;
    } while (result->NextRow());

    LOG_INFO("server.loading", ">> Loaded {} reserved player names in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
}

bool ObjectMgr::IsReservedName(std::string_view name) const
{
    // pussywizard
    if (name.size() >= 2 && (name[name.size() - 2] == 'G' || name[name.size() - 2] == 'g') && (name[name.size() - 1] == 'M' || name[name.size() - 1] == 'm'))
        return true;

    std::wstring wstr;
    if (!Utf8toWStr (name, wstr))
        return false;

    wstrToLower(wstr);

    return _reservedNamesStore.find(wstr) != _reservedNamesStore.end();
}

void ObjectMgr::AddReservedPlayerName(std::string const& name)
{
    if (!IsReservedName(name))
    {
        std::wstring wstr;
        if (!Utf8toWStr(name, wstr))
        {
            LOG_ERROR("server", "Could not add invalid name to reserved player names: {}", name);
            return;
        }
        wstrToLower(wstr);

        _reservedNamesStore.insert(wstr);

        CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_RESERVED_PLAYER_NAME);
        stmt->SetData(0, name);
        CharacterDatabase.Execute(stmt);
    }
}

void ObjectMgr::LoadProfanityPlayersNames()
{
    uint32 oldMSTime = getMSTime();

    _profanityNamesStore.clear();                                // need for reload case

    QueryResult result = CharacterDatabase.Query("SELECT name FROM profanity_name");

    if (!result)
    {
        LOG_WARN("server.loading", ">> Loaded 0 profanity player names. DB table `profanity_name` is empty!");
        LOG_INFO("server.loading", " ");
        return;
    }

    uint32 count = 0;

    Field* fields;
    do
    {
        fields = result->Fetch();
        std::string name = fields[0].Get<std::string>();

        std::wstring wstr;
        if (!Utf8toWStr (name, wstr))
        {
            LOG_ERROR("sql.sql", "Table `profanity_name` have invalid name: {}", name);
            continue;
        }

        wstrToLower(wstr);

        _profanityNamesStore.insert(wstr);
        ++count;
    } while (result->NextRow());

    LOG_INFO("server.loading", ">> Loaded {} profanity player names in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
}

bool ObjectMgr::IsProfanityName(std::string_view name) const
{
    // pussywizard
    if (name.size() >= 2 && (name[name.size() - 2] == 'G' || name[name.size() - 2] == 'g') && (name[name.size() - 1] == 'M' || name[name.size() - 1] == 'm'))
        return true;

    std::wstring wstr;
    if (!Utf8toWStr (name, wstr))
        return false;

    wstrToLower(wstr);

    return _profanityNamesStore.find(wstr) != _profanityNamesStore.end();
}

void ObjectMgr::AddProfanityPlayerName(std::string const& name)
{
    if (!IsProfanityName(name))
    {
        std::wstring wstr;
        if (!Utf8toWStr(name, wstr))
        {
            LOG_ERROR("server", "Could not add invalid name to profanity player names: {}", name);
            return;
        }
        wstrToLower(wstr);

        _profanityNamesStore.insert(wstr);

        CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_PROFANITY_PLAYER_NAME);
        stmt->SetData(0, name);
        CharacterDatabase.Execute(stmt);
    }
}

enum LanguageType
{
    LT_BASIC_LATIN    = 0x0000,
    LT_EXTENDEN_LATIN = 0x0001,
    LT_CYRILLIC       = 0x0002,
    LT_EAST_ASIA      = 0x0004,
    LT_ANY            = 0xFFFF
};

static LanguageType GetRealmLanguageType(bool create)
{
    switch (sWorld->getIntConfig(CONFIG_REALM_ZONE))
    {
        case REALM_ZONE_UNKNOWN:                            // any language
        case REALM_ZONE_DEVELOPMENT:
        case REALM_ZONE_TEST_SERVER:
        case REALM_ZONE_QA_SERVER:
            return LT_ANY;
        case REALM_ZONE_UNITED_STATES:                      // extended-Latin
        case REALM_ZONE_OCEANIC:
        case REALM_ZONE_LATIN_AMERICA:
        case REALM_ZONE_ENGLISH:
        case REALM_ZONE_GERMAN:
        case REALM_ZONE_FRENCH:
        case REALM_ZONE_SPANISH:
            return LT_EXTENDEN_LATIN;
        case REALM_ZONE_KOREA:                              // East-Asian
        case REALM_ZONE_TAIWAN:
        case REALM_ZONE_CHINA:
            return LT_EAST_ASIA;
        case REALM_ZONE_RUSSIAN:                            // Cyrillic
            return LT_CYRILLIC;
        default:
            return create ? LT_BASIC_LATIN : LT_ANY;        // basic-Latin at create, any at login
    }
}

bool isValidString(std::wstring wstr, uint32 strictMask, bool numericOrSpace, bool create = false)
{
    if (strictMask == 0)                                       // any language, ignore realm
    {
        if (isExtendedLatinString(wstr, numericOrSpace))
            return true;
        if (isCyrillicString(wstr, numericOrSpace))
            return true;
        if (isEastAsianString(wstr, numericOrSpace))
            return true;
        return false;
    }

    if (strictMask & 0x2)                                    // realm zone specific
    {
        LanguageType lt = GetRealmLanguageType(create);
        if (lt & LT_EXTENDEN_LATIN)
            if (isExtendedLatinString(wstr, numericOrSpace))
                return true;
        if (lt & LT_CYRILLIC)
            if (isCyrillicString(wstr, numericOrSpace))
                return true;
        if (lt & LT_EAST_ASIA)
            if (isEastAsianString(wstr, numericOrSpace))
                return true;
    }

    if (strictMask & 0x1)                                    // basic Latin
    {
        if (isBasicLatinString(wstr, numericOrSpace))
            return true;
    }

    return false;
}

uint8 ObjectMgr::CheckPlayerName(std::string_view name, bool create)
{
    std::wstring wname;

    // Check for invalid characters
    if (!Utf8toWStr(name, wname))
        return CHAR_NAME_INVALID_CHARACTER;

    // Check for too long name
    if (wname.size() > MAX_PLAYER_NAME)
        return CHAR_NAME_TOO_LONG;

    // Check for too short name
    uint32 minName = sWorld->getIntConfig(CONFIG_MIN_PLAYER_NAME);
    if (wname.size() < minName)
        return CHAR_NAME_TOO_SHORT;

    // Check for mixed languages
    uint32 strictMask = sWorld->getIntConfig(CONFIG_STRICT_PLAYER_NAMES);
    if (!isValidString(wname, strictMask, false, create))
        return CHAR_NAME_MIXED_LANGUAGES;

    // Check for three consecutive letters
    wstrToLower(wname);
    for (size_t i = 2; i < wname.size(); ++i)
        if (wname[i] == wname[i - 1] && wname[i] == wname[i - 2])
            return CHAR_NAME_THREE_CONSECUTIVE;

    // Check Reserved Name from Database
    if (sObjectMgr->IsReservedName(name))
    {
        return CHAR_NAME_RESERVED;
    }

    if (sObjectMgr->IsProfanityName(name))
    {
        return CHAR_NAME_PROFANE;
    }

    // Check for Reserved Name from DBC
    if (sWorld->getBoolConfig(CONFIG_STRICT_NAMES_RESERVED))
    {
        if (ReservedNames(wname))
        {
            return CHAR_NAME_RESERVED;
        }
    }

    // Check for Profanity
    if (sWorld->getBoolConfig(CONFIG_STRICT_NAMES_PROFANITY))
    {
        if (ProfanityNames(wname))
        {
            return CHAR_NAME_PROFANE;
        }
    }

    return CHAR_NAME_SUCCESS;
}

bool ObjectMgr::IsValidCharterName(std::string_view name)
{
    std::wstring wname;
    if (!Utf8toWStr(name, wname))
        return false;

    if (wname.size() > MAX_CHARTER_NAME)
        return false;

    uint32 minName = sWorld->getIntConfig(CONFIG_MIN_CHARTER_NAME);
    if (wname.size() < minName)
        return false;

    // Check for Reserved Name from DBC
    if (sWorld->getBoolConfig(CONFIG_STRICT_NAMES_RESERVED))
    {
        if (ReservedNames(wname))
        {
            return false;
        }
    }

    // Check for Profanity
    if (sWorld->getBoolConfig(CONFIG_STRICT_NAMES_PROFANITY))
    {
        if (ProfanityNames(wname))
        {
            return false;
        }
    }

    uint32 strictMask = sWorld->getIntConfig(CONFIG_STRICT_CHARTER_NAMES);

    return isValidString(wname, strictMask, true);
}

bool ObjectMgr::IsValidChannelName(const std::string& name)
{
    std::wstring wname;
    if (!Utf8toWStr(name, wname))
        return false;

    if (wname.size() > MAX_CHANNEL_NAME)
        return false;

    uint32 strictMask = sWorld->getIntConfig(CONFIG_STRICT_CHANNEL_NAMES);

    return isValidString(wname, strictMask, true);
}

PetNameInvalidReason ObjectMgr::CheckPetName(std::string_view name)
{
    std::wstring wname;
    if (!Utf8toWStr(name, wname))
        return PET_NAME_INVALID;

    if (wname.size() > MAX_PET_NAME)
        return PET_NAME_TOO_LONG;

    uint32 minName = sWorld->getIntConfig(CONFIG_MIN_PET_NAME);
    if (wname.size() < minName)
        return PET_NAME_TOO_SHORT;

    uint32 strictMask = sWorld->getIntConfig(CONFIG_STRICT_PET_NAMES);
    if (!isValidString(wname, strictMask, false))
        return PET_NAME_MIXED_LANGUAGES;

    // Check for Reserved Name from DBC
    if (sWorld->getBoolConfig(CONFIG_STRICT_NAMES_RESERVED))
    {
        if (ReservedNames(wname))
        {
            return PET_NAME_RESERVED;
        }
    }

    // Check for Profanity
    if (sWorld->getBoolConfig(CONFIG_STRICT_NAMES_PROFANITY))
    {
        if (ProfanityNames(wname))
        {
            return PET_NAME_PROFANE;
        }
    }

    return PET_NAME_SUCCESS;
}

void ObjectMgr::LoadGameObjectForQuests()
{
    uint32 oldMSTime = getMSTime();

    if (sObjectMgr->GetGameObjectTemplates()->empty())
    {
        LOG_WARN("server.loading", ">> Loaded 0 GameObjects for quests");
        LOG_INFO("server.loading", " ");
        return;
    }

    uint32 count = 0;

    // collect GO entries for GO that must activated
    GameObjectTemplateContainer* gotc = const_cast<GameObjectTemplateContainer*>(sObjectMgr->GetGameObjectTemplates());
    for (GameObjectTemplateContainer::iterator itr = gotc->begin(); itr != gotc->end(); ++itr)
    {
        itr->second.IsForQuests = false;
        switch (itr->second.type)
        {
            case GAMEOBJECT_TYPE_QUESTGIVER:
                itr->second.IsForQuests = true;
                ++count;
                break;
            case GAMEOBJECT_TYPE_CHEST:
                {
                    // scan GO chest with loot including quest items
                    uint32 loot_id = (itr->second.GetLootId());

                    // find quest loot for GO
                    if (itr->second.chest.questId || LootTemplates_Gameobject.HaveQuestLootFor(loot_id))
                    {
                        itr->second.IsForQuests = true;
                        ++count;
                    }
                    break;
                }
            case GAMEOBJECT_TYPE_GENERIC:
                {
                    if (itr->second._generic.questID > 0)            //quests objects
                    {
                        itr->second.IsForQuests = true;
                        ++count;
                    }
                    break;
                }
            case GAMEOBJECT_TYPE_SPELL_FOCUS:
                {
                    if (itr->second.spellFocus.questID > 0)          //quests objects
                    {
                        itr->second.IsForQuests = true;
                        ++count;
                    }
                    break;
                }
            case GAMEOBJECT_TYPE_GOOBER:
                {
                    if (itr->second.goober.questId > 0)              //quests objects
                    {
                        itr->second.IsForQuests = true;
                        ++count;
                    }
                    break;
                }
            default:
                break;
        }
    }

    LOG_INFO("server.loading", ">> Loaded {} GameObjects for quests in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
}

bool ObjectMgr::LoadAcoreStrings()
{
    uint32 oldMSTime = getMSTime();

    _acoreStringStore.clear(); // for reload case
    QueryResult result = WorldDatabase.Query("SELECT entry, content_default, locale_koKR, locale_frFR, locale_deDE, locale_zhCN, locale_zhTW, locale_esES, locale_esMX, locale_ruRU FROM acore_string");
    if (!result)
    {
        LOG_WARN("server.loading", ">> Loaded 0 acore strings. DB table `acore_strings` is empty.");
        LOG_INFO("server.loading", " ");
        return false;
    }

    do
    {
        Field* fields = result->Fetch();

        uint32 entry = fields[0].Get<uint32>();

        AcoreString& data = _acoreStringStore[entry];

        data.Content.resize(DEFAULT_LOCALE + 1);

        for (uint8 i = 0; i < TOTAL_LOCALES; ++i)
            AddLocaleString(fields[i + 1].Get<std::string>(), LocaleConstant(i), data.Content);
    } while (result->NextRow());

    LOG_INFO("server.loading", ">> Loaded {} Acore Strings in {} ms", (uint32)_acoreStringStore.size(), GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");

    return true;
}

char const* ObjectMgr::GetAcoreString(uint32 entry, LocaleConstant locale) const
{
    if (AcoreString const* ts = GetAcoreString(entry))
    {
        if (ts->Content.size() > size_t(locale) && !ts->Content[locale].empty())
            return ts->Content[locale].c_str();

        return ts->Content[DEFAULT_LOCALE].c_str();
    }

    LOG_ERROR("sql.sql", "Acore string entry {} not found in DB.", entry);

    return "<error>";
}

void ObjectMgr::LoadFishingBaseSkillLevel()
{
    uint32 oldMSTime = getMSTime();

    _fishingBaseForAreaStore.clear();                            // for reload case

    QueryResult result = WorldDatabase.Query("SELECT entry, skill FROM skill_fishing_base_level");

    if (!result)
    {
        LOG_WARN("server.loading", ">> Loaded 0 areas for fishing base skill level. DB table `skill_fishing_base_level` is empty.");
        LOG_INFO("server.loading", " ");
        return;
    }

    uint32 count = 0;

    do
    {
        Field* fields = result->Fetch();
        uint32 entry  = fields[0].Get<uint32>();
        int32 skill   = fields[1].Get<int16>();

        AreaTableEntry const* fArea = sAreaTableStore.LookupEntry(entry);
        if (!fArea)
        {
            LOG_ERROR("sql.sql", "AreaId {} defined in `skill_fishing_base_level` does not exist", entry);
            continue;
        }

        _fishingBaseForAreaStore[entry] = skill;
        ++count;
    } while (result->NextRow());

    LOG_INFO("server.loading", ">> Loaded {} areas for fishing base skill level in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
}

void ObjectMgr::ChangeFishingBaseSkillLevel(uint32 entry, int32 skill)
{
    AreaTableEntry const* fArea = sAreaTableStore.LookupEntry(entry);
    if (!fArea)
    {
        LOG_ERROR("sql.sql", "AreaId {} defined in `skill_fishing_base_level` does not exist", entry);
        return;
    }

    _fishingBaseForAreaStore[entry] = skill;

    LOG_INFO("server.loading", ">> Fishing base skill level of area {} changed to {}", entry, skill);
    LOG_INFO("server.loading", " ");
}

bool ObjectMgr::CheckDeclinedNames(std::wstring w_ownname, DeclinedName const& names)
{
    // get main part of the name
    std::wstring mainpart = GetMainPartOfName(w_ownname, 0);
    // prepare flags
    bool x = true;
    bool y = true;

    // check declined names
    for (uint8 i = 0; i < MAX_DECLINED_NAME_CASES; ++i)
    {
        std::wstring wname;
        if (!Utf8toWStr(names.name[i], wname))
            return false;

        if (mainpart != GetMainPartOfName(wname, i + 1))
            x = false;

        if (w_ownname != wname)
            y = false;
    }
    return (x || y);
}

uint32 ObjectMgr::GetAreaTriggerScriptId(uint32 trigger_id)
{
    AreaTriggerScriptContainer::const_iterator i = _areaTriggerScriptStore.find(trigger_id);
    if (i != _areaTriggerScriptStore.end())
        return i->second;
    return 0;
}

SpellScriptsBounds ObjectMgr::GetSpellScriptsBounds(uint32 spell_id)
{
    return SpellScriptsBounds(_spellScriptsStore.lower_bound(spell_id), _spellScriptsStore.upper_bound(spell_id));
}

// this allows calculating base reputations to offline players, just by race and class
int32 ObjectMgr::GetBaseReputationOf(FactionEntry const* factionEntry, uint8 race, uint8 playerClass)
{
    if (!factionEntry)
        return 0;

    uint32 raceMask = (1 << (race - 1));
    uint32 classMask = (1 << (playerClass - 1));

    for (int i = 0; i < 4; i++)
    {
        if ((!factionEntry->BaseRepClassMask[i] ||
                factionEntry->BaseRepClassMask[i] & classMask) &&
                (!factionEntry->BaseRepRaceMask[i] ||
                 factionEntry->BaseRepRaceMask[i] & raceMask))
            return factionEntry->BaseRepValue[i];
    }

    return 0;
}

SkillRangeType GetSkillRangeType(SkillRaceClassInfoEntry const* rcEntry)
{
    SkillLineEntry const* skill = sSkillLineStore.LookupEntry(rcEntry->SkillID);
    if (!skill)
    {
        return SKILL_RANGE_NONE;
    }

    if (sSkillTiersStore.LookupEntry(rcEntry->SkillTierID))
    {
        return SKILL_RANGE_RANK;
    }

    if (rcEntry->SkillID == SKILL_RUNEFORGING)
    {
        return SKILL_RANGE_MONO;
    }

    switch (skill->categoryId)
    {
        case SKILL_CATEGORY_ARMOR:
            return SKILL_RANGE_MONO;
        case SKILL_CATEGORY_LANGUAGES:
            return SKILL_RANGE_LANGUAGE;
    }

    return SKILL_RANGE_LEVEL;
}

void ObjectMgr::LoadGameTele()
{
    uint32 oldMSTime = getMSTime();

    _gameTeleStore.clear();                                  // for reload case

    //                                                0       1           2           3           4        5     6
    QueryResult result = WorldDatabase.Query("SELECT id, position_x, position_y, position_z, orientation, map, name FROM game_tele");

    if (!result)
    {
        LOG_WARN("server.loading", ">> Loaded 0 GameTeleports. DB table `game_tele` is empty!");
        LOG_INFO("server.loading", " ");
        return;
    }

    uint32 count = 0;

    do
    {
        Field* fields = result->Fetch();

        uint32 id         = fields[0].Get<uint32>();

        GameTele gt;

        gt.position_x     = fields[1].Get<float>();
        gt.position_y     = fields[2].Get<float>();
        gt.position_z     = fields[3].Get<float>();
        gt.orientation    = fields[4].Get<float>();
        gt.mapId          = fields[5].Get<uint16>();
        gt.name           = fields[6].Get<std::string>();

        if (!MapMgr::IsValidMapCoord(gt.mapId, gt.position_x, gt.position_y, gt.position_z, gt.orientation))
        {
            LOG_ERROR("sql.sql", "Wrong position for id {} (name: {}) in `game_tele` table, ignoring.", id, gt.name);
            continue;
        }

        if (!Utf8toWStr(gt.name, gt.wnameLow))
        {
            LOG_ERROR("sql.sql", "Wrong UTF8 name for id {} in `game_tele` table, ignoring.", id);
            continue;
        }

        wstrToLower(gt.wnameLow);

        _gameTeleStore[id] = gt;

        ++count;
    } while (result->NextRow());

    LOG_INFO("server.loading", ">> Loaded {} GameTeleports in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
}

GameTele const* ObjectMgr::GetGameTele(std::string_view name) const
{
    // explicit name case
    std::wstring wname;
    if (!Utf8toWStr(name, wname))
        return nullptr;

    // converting string that we try to find to lower case
    wstrToLower(wname);

    // Alternative first GameTele what contains wnameLow as substring in case no GameTele location found
    const GameTele* alt = nullptr;
    for (GameTeleContainer::const_iterator itr = _gameTeleStore.begin(); itr != _gameTeleStore.end(); ++itr)
    {
        if (itr->second.wnameLow == wname)
            return &itr->second;
        else if (!alt && itr->second.wnameLow.find(wname) != std::wstring::npos)
            alt = &itr->second;
    }

    return alt;
}

bool ObjectMgr::AddGameTele(GameTele& tele)
{
    // find max id
    uint32 new_id = 0;
    for (GameTeleContainer::const_iterator itr = _gameTeleStore.begin(); itr != _gameTeleStore.end(); ++itr)
        if (itr->first > new_id)
            new_id = itr->first;

    // use next
    ++new_id;

    if (!Utf8toWStr(tele.name, tele.wnameLow))
        return false;

    wstrToLower(tele.wnameLow);

    _gameTeleStore[new_id] = tele;

    WorldDatabasePreparedStatement* stmt = WorldDatabase.GetPreparedStatement(WORLD_INS_GAME_TELE);

    stmt->SetData(0, new_id);
    stmt->SetData(1, tele.position_x);
    stmt->SetData(2, tele.position_y);
    stmt->SetData(3, tele.position_z);
    stmt->SetData(4, tele.orientation);
    stmt->SetData(5, uint16(tele.mapId));
    stmt->SetData(6, tele.name);

    WorldDatabase.Execute(stmt);

    return true;
}

bool ObjectMgr::DeleteGameTele(std::string_view name)
{
    // explicit name case
    std::wstring wname;
    if (!Utf8toWStr(name, wname))
        return false;

    // converting string that we try to find to lower case
    wstrToLower(wname);

    for (GameTeleContainer::iterator itr = _gameTeleStore.begin(); itr != _gameTeleStore.end(); ++itr)
    {
        if (itr->second.wnameLow == wname)
        {
            WorldDatabasePreparedStatement* stmt = WorldDatabase.GetPreparedStatement(WORLD_DEL_GAME_TELE);

            stmt->SetData(0, itr->second.name);

            WorldDatabase.Execute(stmt);

            _gameTeleStore.erase(itr);
            return true;
        }
    }

    return false;
}

void ObjectMgr::LoadMailLevelRewards()
{
    uint32 oldMSTime = getMSTime();

    _mailLevelRewardStore.clear();                           // for reload case

    //                                                 0        1             2            3
    QueryResult result = WorldDatabase.Query("SELECT level, raceMask, mailTemplateId, senderEntry FROM mail_level_reward");

    if (!result)
    {
        LOG_WARN("server.loading", ">> Loaded 0 level dependent mail rewards. DB table `mail_level_reward` is empty.");
        LOG_INFO("server.loading", " ");
        return;
    }

    uint32 count = 0;

    do
    {
        Field* fields = result->Fetch();

        uint8 level           = fields[0].Get<uint8>();
        uint32 raceMask       = fields[1].Get<uint32>();
        uint32 mailTemplateId = fields[2].Get<uint32>();
        uint32 senderEntry    = fields[3].Get<uint32>();

        if (level > MAX_LEVEL)
        {
            LOG_ERROR("sql.sql", "Table `mail_level_reward` have data for level {} that more supported by client ({}), ignoring.", level, MAX_LEVEL);
            continue;
        }

        if (!(raceMask & RACEMASK_ALL_PLAYABLE))
        {
            LOG_ERROR("sql.sql", "Table `mail_level_reward` have raceMask ({}) for level {} that not include any player races, ignoring.", raceMask, level);
            continue;
        }

        if (!sMailTemplateStore.LookupEntry(mailTemplateId))
        {
            LOG_ERROR("sql.sql", "Table `mail_level_reward` have invalid mailTemplateId ({}) for level {} that invalid not include any player races, ignoring.", mailTemplateId, level);
            continue;
        }

        if (!GetCreatureTemplate(senderEntry))
        {
            LOG_ERROR("sql.sql", "Table `mail_level_reward` have not existed sender creature entry ({}) for level {} that invalid not include any player races, ignoring.", senderEntry, level);
            continue;
        }

        _mailLevelRewardStore[level].push_back(MailLevelReward(raceMask, mailTemplateId, senderEntry));

        ++count;
    } while (result->NextRow());

    LOG_INFO("server.loading", ">> Loaded {} Level Dependent Mail Rewards in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
}

void ObjectMgr::AddSpellToTrainer(uint32 entry, uint32 spell, uint32 spellCost, uint32 reqSkill, uint32 reqSkillValue, uint32 reqLevel, uint32 reqSpell)
{
    if (entry >= ACORE_TRAINER_START_REF)
        return;

    CreatureTemplate const* cInfo = GetCreatureTemplate(entry);
    if (!cInfo)
    {
        LOG_ERROR("sql.sql", "Table `npc_trainer` contains an entry for a non-existing creature template (Entry: {}), ignoring", entry);
        return;
    }

    if (!(cInfo->npcflag & UNIT_NPC_FLAG_TRAINER))
    {
        LOG_ERROR("sql.sql", "Table `npc_trainer` contains an entry for a creature template (Entry: {}) without trainer flag, ignoring", entry);
        return;
    }

    SpellInfo const* spellinfo = sSpellMgr->GetSpellInfo(spell);
    if (!spellinfo)
    {
        LOG_ERROR("sql.sql", "Table `npc_trainer` contains an entry (Entry: {}) for a non-existing spell (Spell: {}), ignoring", entry, spell);
        return;
    }

    if (!SpellMgr::ComputeIsSpellValid(spellinfo))
    {
        LOG_ERROR("sql.sql", "Table `npc_trainer` contains an entry (Entry: {}) for a broken spell (Spell: {}), ignoring", entry, spell);
        return;
    }

    if (GetTalentSpellCost(spell))
    {
        LOG_ERROR("sql.sql", "Table `npc_trainer` contains an entry (Entry: {}) for a non-existing spell (Spell: {}) which is a talent, ignoring", entry, spell);
        return;
    }

    if (reqSpell && !sSpellMgr->GetSpellInfo(reqSpell))
    {
        LOG_ERROR("sql.sql", "Table `npc_trainer` contains an entry (Entry: {}) for a non-existing reqSpell (Spell: {}), ignoring", entry, reqSpell);
        return;
    }

    TrainerSpellData& data = _cacheTrainerSpellStore[entry];

    TrainerSpell& trainerSpell = data.spellList[spell];
    trainerSpell.spell         = spell;
    trainerSpell.spellCost     = spellCost;
    trainerSpell.reqSkill      = reqSkill;
    trainerSpell.reqSkillValue = reqSkillValue;
    trainerSpell.reqLevel      = reqLevel;
    trainerSpell.reqSpell      = reqSpell;

    if (!trainerSpell.reqLevel)
        trainerSpell.reqLevel = spellinfo->SpellLevel;

    // calculate learned spell for profession case when stored cast-spell
    trainerSpell.learnedSpell[0] = spell;
    for (uint8 i = 0; i < MAX_SPELL_EFFECTS; ++i)
    {
        if (spellinfo->Effects[i].Effect != SPELL_EFFECT_LEARN_SPELL)
            continue;
        if (trainerSpell.learnedSpell[0] == spell)
            trainerSpell.learnedSpell[0] = 0;
        // player must be able to cast spell on himself
        if (spellinfo->Effects[i].TargetA.GetTarget() != 0 && spellinfo->Effects[i].TargetA.GetTarget() != TARGET_UNIT_TARGET_ALLY
                && spellinfo->Effects[i].TargetA.GetTarget() != TARGET_UNIT_TARGET_ANY && spellinfo->Effects[i].TargetA.GetTarget() != TARGET_UNIT_CASTER)
        {
            LOG_ERROR("sql.sql", "Table `npc_trainer` has spell {} for trainer entry {} with learn effect which has incorrect target type, ignoring learn effect!", spell, entry);
            continue;
        }

        trainerSpell.learnedSpell[i] = spellinfo->Effects[i].TriggerSpell;

        if (trainerSpell.learnedSpell[i])
        {
            SpellInfo const* learnedSpellInfo = sSpellMgr->GetSpellInfo(trainerSpell.learnedSpell[i]);
            if (learnedSpellInfo && learnedSpellInfo->IsProfession())
                data.trainerType = 2;
        }
    }

    return;
}

void ObjectMgr::LoadTrainerSpell()
{
    uint32 oldMSTime = getMSTime();

    // For reload case
    _cacheTrainerSpellStore.clear();

    QueryResult result = WorldDatabase.Query("SELECT b.ID, a.SpellID, a.MoneyCost, a.ReqSkillLine, a.ReqSkillRank, a.ReqLevel, a.ReqSpell FROM npc_trainer AS a "
                         "INNER JOIN npc_trainer AS b ON a.ID = -(b.SpellID) "
                         "UNION SELECT * FROM npc_trainer WHERE SpellID > 0");

    if (!result)
    {
        LOG_WARN("server.loading", ">> Loaded 0 Trainers. DB table `npc_trainer` is empty!");
        LOG_INFO("server.loading", " ");
        return;
    }

    uint32 count = 0;

    do
    {
        Field* fields = result->Fetch();

        uint32 entry         = fields[0].Get<uint32>();
        uint32 spell         = fields[1].Get<uint32>();
        uint32 spellCost     = fields[2].Get<uint32>();
        uint32 reqSkill      = fields[3].Get<uint16>();
        uint32 reqSkillValue = fields[4].Get<uint16>();
        uint32 reqLevel      = fields[5].Get<uint8>();
        uint32 reqSpell      = fields[6].Get<uint32>();

        AddSpellToTrainer(entry, spell, spellCost, reqSkill, reqSkillValue, reqLevel, reqSpell);

        ++count;
    } while (result->NextRow());

    LOG_INFO("server.loading", ">> Loaded {} Trainers in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
}

int ObjectMgr::LoadReferenceVendor(int32 vendor, int32 item, std::set<uint32>* skip_vendors)
{
    // find all items from the reference vendor
    WorldDatabasePreparedStatement* stmt = WorldDatabase.GetPreparedStatement(WORLD_SEL_NPC_VENDOR_REF);
    stmt->SetData(0, uint32(item));
    PreparedQueryResult result = WorldDatabase.Query(stmt);

    if (!result)
        return 0;

    uint32 count = 0;
    do
    {
        Field* fields = result->Fetch();

        int32 item_id = fields[0].Get<int32>();

        // if item is a negative, its a reference
        if (item_id < 0)
            count += LoadReferenceVendor(vendor, -item_id, skip_vendors);
        else
        {
            int32  maxcount     = fields[1].Get<uint8>();
            uint32 incrtime     = fields[2].Get<uint32>();
            uint32 ExtendedCost = fields[3].Get<uint32>();

            if (!IsVendorItemValid(vendor, item_id, maxcount, incrtime, ExtendedCost, nullptr, skip_vendors))
                continue;

            VendorItemData& vList = _cacheVendorItemStore[vendor];

            vList.AddItem(item_id, maxcount, incrtime, ExtendedCost);
            ++count;
        }
    } while (result->NextRow());

    return count;
}

void ObjectMgr::LoadVendors()
{
    uint32 oldMSTime = getMSTime();

    // For reload case
    for (CacheVendorItemContainer::iterator itr = _cacheVendorItemStore.begin(); itr != _cacheVendorItemStore.end(); ++itr)
        itr->second.Clear();
    _cacheVendorItemStore.clear();

    std::set<uint32> skip_vendors;

    QueryResult result = WorldDatabase.Query("SELECT entry, item, maxcount, incrtime, ExtendedCost FROM npc_vendor ORDER BY entry, slot ASC, item, ExtendedCost");
    if (!result)
    {
        LOG_INFO("server.loading", " ");
        LOG_WARN("server.loading", ">> Loaded 0 Vendors. DB table `npc_vendor` is empty!");
        return;
    }

    uint32 count = 0;

    do
    {
        Field* fields = result->Fetch();

        uint32 entry        = fields[0].Get<uint32>();
        int32 item_id      = fields[1].Get<int32>();

        // if item is a negative, its a reference
        if (item_id < 0)
            count += LoadReferenceVendor(entry, -item_id, &skip_vendors);
        else
        {
            uint32 maxcount     = fields[2].Get<uint8>();
            uint32 incrtime     = fields[3].Get<uint32>();
            uint32 ExtendedCost = fields[4].Get<uint32>();

            if (!IsVendorItemValid(entry, item_id, maxcount, incrtime, ExtendedCost, nullptr, &skip_vendors))
                continue;

            VendorItemData& vList = _cacheVendorItemStore[entry];

            vList.AddItem(item_id, maxcount, incrtime, ExtendedCost);
            ++count;
        }
    } while (result->NextRow());

    LOG_INFO("server.loading", ">> Loaded {} Vendors in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
}

void ObjectMgr::LoadGossipMenu()
{
    uint32 oldMSTime = getMSTime();

    _gossipMenusStore.clear();

    QueryResult result = WorldDatabase.Query("SELECT MenuID, TextID FROM gossip_menu");

    if (!result)
    {
        LOG_WARN("server.loading", ">> Loaded 0 gossip_menu entries. DB table `gossip_menu` is empty!");
        LOG_INFO("server.loading", " ");
        return;
    }

    do
    {
        Field* fields = result->Fetch();

        GossipMenus gMenu;

        gMenu.MenuID        = fields[0].Get<uint32>();
        gMenu.TextID        = fields[1].Get<uint32>();

        if (!GetGossipText(gMenu.TextID))
        {
            LOG_ERROR("sql.sql", "Table gossip_menu entry {} are using non-existing TextID {}", gMenu.MenuID, gMenu.TextID);
            continue;
        }

        _gossipMenusStore.insert(GossipMenusContainer::value_type(gMenu.MenuID, gMenu));
    } while (result->NextRow());

    LOG_INFO("server.loading", ">> Loaded {} gossip_menu entries in {} ms", (uint32)_gossipMenusStore.size(), GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
}

void ObjectMgr::LoadGossipMenuItems()
{
    uint32 oldMSTime = getMSTime();

    _gossipMenuItemsStore.clear();

    QueryResult result = WorldDatabase.Query(
                             //      0       1         2           3           4                      5           6              7             8            9         10        11       12
                             "SELECT MenuID, OptionID, OptionIcon, OptionText, OptionBroadcastTextID, OptionType, OptionNpcFlag, ActionMenuID, ActionPoiID, BoxCoded, BoxMoney, BoxText, BoxBroadcastTextID "
                             "FROM gossip_menu_option ORDER BY MenuID, OptionID");

    if (!result)
    {
        LOG_WARN("server.loading", ">> Loaded 0 gossip_menu_option IDs. DB table `gossip_menu_option` is empty!");
        LOG_INFO("server.loading", " ");
        return;
    }

    do
    {
        Field* fields = result->Fetch();

        GossipMenuItems gMenuItem;

        gMenuItem.MenuID                    = fields[0].Get<uint32>();
        gMenuItem.OptionID                  = fields[1].Get<uint16>();
        gMenuItem.OptionIcon                = fields[2].Get<uint32>();
        gMenuItem.OptionText                = fields[3].Get<std::string>();
        gMenuItem.OptionBroadcastTextID     = fields[4].Get<uint32>();
        gMenuItem.OptionType                = fields[5].Get<uint8>();
        gMenuItem.OptionNpcFlag             = fields[6].Get<uint32>();
        gMenuItem.ActionMenuID              = fields[7].Get<uint32>();
        gMenuItem.ActionPoiID               = fields[8].Get<uint32>();
        gMenuItem.BoxCoded                  = fields[9].Get<bool>();
        gMenuItem.BoxMoney                  = fields[10].Get<uint32>();
        gMenuItem.BoxText                   = fields[11].Get<std::string>();
        gMenuItem.BoxBroadcastTextID        = fields[12].Get<uint32>();

        if (gMenuItem.OptionIcon >= GOSSIP_ICON_MAX)
        {
            LOG_ERROR("sql.sql", "Table `gossip_menu_option` for menu {}, id {} has unknown icon id {}. Replacing with GOSSIP_ICON_CHAT", gMenuItem.MenuID, gMenuItem.OptionID, gMenuItem.OptionIcon);
            gMenuItem.OptionIcon = GOSSIP_ICON_CHAT;
        }

        if (gMenuItem.OptionBroadcastTextID && !GetBroadcastText(gMenuItem.OptionBroadcastTextID))
        {
            LOG_ERROR("sql.sql", "Table `gossip_menu_option` for menu {}, id {} has non-existing or incompatible OptionBroadcastTextID {}, ignoring.", gMenuItem.MenuID, gMenuItem.OptionID, gMenuItem.OptionBroadcastTextID);
            gMenuItem.OptionBroadcastTextID = 0;
        }

        if (gMenuItem.OptionType >= GOSSIP_OPTION_MAX)
            LOG_ERROR("sql.sql", "Table `gossip_menu_option` for menu {}, id {} has unknown option id {}. Option will not be used", gMenuItem.MenuID, gMenuItem.OptionID, gMenuItem.OptionType);

        if (gMenuItem.ActionPoiID && !GetPointOfInterest(gMenuItem.ActionPoiID))
        {
            LOG_ERROR("sql.sql", "Table `gossip_menu_option` for menu {}, id {} use non-existing ActionPoiID {}, ignoring", gMenuItem.MenuID, gMenuItem.OptionID, gMenuItem.ActionPoiID);
            gMenuItem.ActionPoiID = 0;
        }

        if (gMenuItem.BoxBroadcastTextID && !GetBroadcastText(gMenuItem.BoxBroadcastTextID))
        {
            LOG_ERROR("sql.sql", "Table `gossip_menu_option` for menu {}, id {} has non-existing or incompatible BoxBroadcastTextID {}, ignoring.", gMenuItem.MenuID, gMenuItem.OptionID, gMenuItem.BoxBroadcastTextID);
            gMenuItem.BoxBroadcastTextID = 0;
        }

        _gossipMenuItemsStore.insert(GossipMenuItemsContainer::value_type(gMenuItem.MenuID, gMenuItem));
    } while (result->NextRow());

    LOG_INFO("server.loading", ">> Loaded {} gossip_menu_option entries in {} ms", uint32(_gossipMenuItemsStore.size()), GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
}

void ObjectMgr::AddVendorItem(uint32 entry, uint32 item, int32 maxcount, uint32 incrtime, uint32 extendedCost, bool persist /*= true*/)
{
    VendorItemData& vList = _cacheVendorItemStore[entry];
    vList.AddItem(item, maxcount, incrtime, extendedCost);

    if (persist)
    {
        WorldDatabasePreparedStatement* stmt = WorldDatabase.GetPreparedStatement(WORLD_INS_NPC_VENDOR);

        stmt->SetData(0, entry);
        stmt->SetData(1, item);
        stmt->SetData(2, maxcount);
        stmt->SetData(3, incrtime);
        stmt->SetData(4, extendedCost);

        WorldDatabase.Execute(stmt);
    }
}

bool ObjectMgr::RemoveVendorItem(uint32 entry, uint32 item, bool persist /*= true*/)
{
    CacheVendorItemContainer::iterator  iter = _cacheVendorItemStore.find(entry);
    if (iter == _cacheVendorItemStore.end())
        return false;

    if (!iter->second.RemoveItem(item))
        return false;

    if (persist)
    {
        WorldDatabasePreparedStatement* stmt = WorldDatabase.GetPreparedStatement(WORLD_DEL_NPC_VENDOR);

        stmt->SetData(0, entry);
        stmt->SetData(1, item);

        WorldDatabase.Execute(stmt);
    }

    return true;
}

bool ObjectMgr::IsVendorItemValid(uint32 vendor_entry, uint32 item_id, int32 maxcount, uint32 incrtime, uint32 ExtendedCost, Player* player, std::set<uint32>* /*skip_vendors*/, uint32 /*ORnpcflag*/) const
{
    /*
    CreatureTemplate const* cInfo = sObjectMgr->GetCreatureTemplate(vendor_entry);
    if (!cInfo)
    {
        if (player)
            ChatHandler(player->GetSession()).SendSysMessage(LANG_COMMAND_VENDORSELECTION);
        else
            LOG_ERROR("sql.sql", "Table `(game_event_)npc_vendor` have data for not existed creature template (Entry: {}), ignore", vendor_entry);
        return false;
    }

    if (!((cInfo->npcflag | ORnpcflag) & UNIT_NPC_FLAG_VENDOR))
    {
        if (!skip_vendors || skip_vendors->count(vendor_entry) == 0)
        {
            if (player)
                ChatHandler(player->GetSession()).SendSysMessage(LANG_COMMAND_VENDORSELECTION);
            else
                LOG_ERROR("sql.sql", "Table `(game_event_)npc_vendor` have data for not creature template (Entry: {}) without vendor flag, ignore", vendor_entry);

            if (skip_vendors)
                skip_vendors->insert(vendor_entry);
        }
        return false;
    }
    */

    if (!sObjectMgr->GetItemTemplate(item_id))
    {
        if (player)
            ChatHandler(player->GetSession()).PSendSysMessage(LANG_ITEM_NOT_FOUND, item_id);
        else
            LOG_ERROR("sql.sql", "Table `(game_event_)npc_vendor` for Vendor (Entry: {}) have in item list non-existed item ({}), ignore", vendor_entry, item_id);
        return false;
    }

    if (ExtendedCost && !sItemExtendedCostStore.LookupEntry(ExtendedCost))
    {
        if (player)
            ChatHandler(player->GetSession()).PSendSysMessage(LANG_EXTENDED_COST_NOT_EXIST, ExtendedCost);
        else
            LOG_ERROR("sql.sql", "Table `(game_event_)npc_vendor` have Item (Entry: {}) with wrong ExtendedCost ({}) for vendor ({}), ignore", item_id, ExtendedCost, vendor_entry);
        return false;
    }

    if (maxcount > 0 && incrtime == 0)
    {
        if (player)
            ChatHandler(player->GetSession()).PSendSysMessage("MaxCount != 0 (%u) but IncrTime == 0", maxcount);
        else
            LOG_ERROR("sql.sql", "Table `(game_event_)npc_vendor` has `maxcount` ({}) for item {} of vendor (Entry: {}) but `incrtime`=0, ignore", maxcount, item_id, vendor_entry);
        return false;
    }
    else if (maxcount == 0 && incrtime > 0)
    {
        if (player)
            ChatHandler(player->GetSession()).PSendSysMessage("MaxCount == 0 but IncrTime<>= 0");
        else
            LOG_ERROR("sql.sql", "Table `(game_event_)npc_vendor` has `maxcount`=0 for item {} of vendor (Entry: {}) but `incrtime`<>0, ignore", item_id, vendor_entry);
        return false;
    }

    VendorItemData const* vItems = GetNpcVendorItemList(vendor_entry);
    if (!vItems)
        return true;                                        // later checks for non-empty lists

    if (vItems->FindItemCostPair(item_id, ExtendedCost))
    {
        if (player)
            ChatHandler(player->GetSession()).PSendSysMessage(LANG_ITEM_ALREADY_IN_LIST, item_id, ExtendedCost);
        else
            LOG_ERROR("sql.sql", "Table `npc_vendor` has duplicate items {} (with extended cost {}) for vendor (Entry: {}), ignoring", item_id, ExtendedCost, vendor_entry);
        return false;
    }

    return true;
}

void ObjectMgr::LoadScriptNames()
{
    uint32 oldMSTime = getMSTime();

    // We insert an empty placeholder here so we can use the
    // script id 0 as dummy for "no script found".
    _scriptNamesStore.emplace_back("");

    QueryResult result = WorldDatabase.Query(
                             "SELECT DISTINCT(ScriptName) FROM achievement_criteria_data WHERE ScriptName <> '' AND type = 11 "
                             "UNION "
                             "SELECT DISTINCT(ScriptName) FROM battleground_template WHERE ScriptName <> '' "
                             "UNION "
                             "SELECT DISTINCT(ScriptName) FROM creature WHERE ScriptName <> '' "
                             "UNION "
                             "SELECT DISTINCT(ScriptName) FROM creature_template WHERE ScriptName <> '' "
                             "UNION "
                             "SELECT DISTINCT(ScriptName) FROM gameobject WHERE ScriptName <> '' "
                             "UNION "
                             "SELECT DISTINCT(ScriptName) FROM gameobject_template WHERE ScriptName <> '' "
                             "UNION "
                             "SELECT DISTINCT(ScriptName) FROM item_template WHERE ScriptName <> '' "
                             "UNION "
                             "SELECT DISTINCT(ScriptName) FROM areatrigger_scripts WHERE ScriptName <> '' "
                             "UNION "
                             "SELECT DISTINCT(ScriptName) FROM spell_script_names WHERE ScriptName <> '' "
                             "UNION "
                             "SELECT DISTINCT(ScriptName) FROM transports WHERE ScriptName <> '' "
                             "UNION "
                             "SELECT DISTINCT(ScriptName) FROM game_weather WHERE ScriptName <> '' "
                             "UNION "
                             "SELECT DISTINCT(ScriptName) FROM conditions WHERE ScriptName <> '' "
                             "UNION "
                             "SELECT DISTINCT(ScriptName) FROM outdoorpvp_template WHERE ScriptName <> '' "
                             "UNION "
                             "SELECT DISTINCT(script) FROM instance_template WHERE script <> ''");

    if (!result)
    {
        LOG_INFO("server.loading", " ");
        LOG_ERROR("sql.sql", ">> Loaded empty set of Script Names!");
        return;
    }

    _scriptNamesStore.reserve(result->GetRowCount() + 1);

    do
    {
        _scriptNamesStore.push_back((*result)[0].Get<std::string>());
    } while (result->NextRow());

    std::sort(_scriptNamesStore.begin(), _scriptNamesStore.end());
    LOG_INFO("server.loading", ">> Loaded {} ScriptNames in {} ms", _scriptNamesStore.size(), GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
}

std::string const& ObjectMgr::GetScriptName(uint32 id) const
{
    static std::string const empty = "";
    return (id < _scriptNamesStore.size()) ? _scriptNamesStore[id] : empty;
}

uint32 ObjectMgr::GetScriptId(std::string const& name)
{
    // use binary search to find the script name in the sorted vector
    // assume "" is the first element
    if (name.empty())
        return 0;

    ScriptNameContainer::const_iterator itr = std::lower_bound(_scriptNamesStore.begin(), _scriptNamesStore.end(), name);
    if (itr == _scriptNamesStore.end() || (*itr != name))
        return 0;

    return uint32(itr - _scriptNamesStore.begin());
}

void ObjectMgr::LoadBroadcastTexts()
{
    uint32 oldMSTime = getMSTime();

    _broadcastTextStore.clear(); // for reload case

    //                                               0   1           2         3           4         5         6         7            8            9            10              11        12
    QueryResult result = WorldDatabase.Query("SELECT ID, LanguageID, MaleText, FemaleText, EmoteID1, EmoteID2, EmoteID3, EmoteDelay1, EmoteDelay2, EmoteDelay3, SoundEntriesID, EmotesID, Flags FROM broadcast_text");
    if (!result)
    {
        LOG_WARN("server.loading", ">> Loaded 0 broadcast texts. DB table `broadcast_text` is empty.");
        LOG_INFO("server.loading", " ");
        return;
    }

    _broadcastTextStore.rehash(result->GetRowCount());

    do
    {
        Field* fields = result->Fetch();

        BroadcastText bct;

        bct.Id = fields[0].Get<uint32>();
        bct.LanguageID = fields[1].Get<uint32>();
        bct.MaleText[DEFAULT_LOCALE] = fields[2].Get<std::string>();
        bct.FemaleText[DEFAULT_LOCALE] = fields[3].Get<std::string>();
        bct.EmoteId1 = fields[4].Get<uint32>();
        bct.EmoteId2 = fields[5].Get<uint32>();
        bct.EmoteId3 = fields[6].Get<uint32>();
        bct.EmoteDelay1 = fields[7].Get<uint32>();
        bct.EmoteDelay2 = fields[8].Get<uint32>();
        bct.EmoteDelay3 = fields[9].Get<uint32>();
        bct.SoundEntriesId = fields[10].Get<uint32>();
        bct.EmotesID = fields[11].Get<uint32>();
        bct.Flags = fields[12].Get<uint32>();

        if (bct.SoundEntriesId)
        {
            if (!sSoundEntriesStore.LookupEntry(bct.SoundEntriesId))
            {
                LOG_DEBUG("misc", "BroadcastText (Id: {}) in table `broadcast_text` has SoundEntriesId {} but sound does not exist.", bct.Id, bct.SoundEntriesId);
                bct.SoundEntriesId = 0;
            }
        }

        if (!GetLanguageDescByID(bct.LanguageID))
        {
            LOG_DEBUG("misc", "BroadcastText (Id: {}) in table `broadcast_text` using Language {} but Language does not exist.", bct.Id, bct.LanguageID);
            bct.LanguageID = LANG_UNIVERSAL;
        }

        if (bct.EmoteId1)
        {
            if (!sEmotesStore.LookupEntry(bct.EmoteId1))
            {
                LOG_DEBUG("misc", "BroadcastText (Id: {}) in table `broadcast_text` has EmoteId1 {} but emote does not exist.", bct.Id, bct.EmoteId1);
                bct.EmoteId1 = 0;
            }
        }

        if (bct.EmoteId2)
        {
            if (!sEmotesStore.LookupEntry(bct.EmoteId2))
            {
                LOG_DEBUG("misc", "BroadcastText (Id: {}) in table `broadcast_text` has EmoteId2 {} but emote does not exist.", bct.Id, bct.EmoteId2);
                bct.EmoteId2 = 0;
            }
        }

        if (bct.EmoteId3)
        {
            if (!sEmotesStore.LookupEntry(bct.EmoteId3))
            {
                LOG_DEBUG("misc", "BroadcastText (Id: {}) in table `broadcast_text` has EmoteId3 {} but emote does not exist.", bct.Id, bct.EmoteId3);
                bct.EmoteId3 = 0;
            }
        }

        _broadcastTextStore[bct.Id] = bct;
    } while (result->NextRow());

    LOG_INFO("server.loading", ">> Loaded {} Broadcast Texts in {} ms", _broadcastTextStore.size(), GetMSTimeDiffToNow(oldMSTime));
}

void ObjectMgr::LoadBroadcastTextLocales()
{
    uint32 oldMSTime = getMSTime();

    //                                               0   1       2         3
    QueryResult result = WorldDatabase.Query("SELECT ID, locale, MaleText, FemaleText FROM broadcast_text_locale");

    if (!result)
    {
        LOG_WARN("server.loading", ">> Loaded 0 broadcast text locales. DB table `broadcast_text_locale` is empty.");
        LOG_INFO("server.loading", " ");
        return;
    }

    uint32 locales_count = 0;
    do
    {
        Field* fields = result->Fetch();

        uint32 id = fields[0].Get<uint32>();

        BroadcastTextContainer::iterator bct = _broadcastTextStore.find(id);
        if (bct == _broadcastTextStore.end())
        {
            LOG_ERROR("sql.sql", "BroadcastText (Id: {}) found in table `broadcast_text_locale` but does not exist in `broadcast_text`. Skipped!", id);
            continue;
        }

        LocaleConstant locale = GetLocaleByName(fields[1].Get<std::string>());
        if (locale == LOCALE_enUS)
            continue;

        AddLocaleString(fields[2].Get<std::string>(), locale, bct->second.MaleText);
        AddLocaleString(fields[3].Get<std::string>(), locale, bct->second.FemaleText);
        locales_count++;
    } while (result->NextRow());

    LOG_INFO("server.loading", ">> Loaded {} Broadcast Text Locales in {} ms", locales_count, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
}

CreatureBaseStats const* ObjectMgr::GetCreatureBaseStats(uint8 level, uint8 unitClass)
{
    CreatureBaseStatsContainer::const_iterator it = _creatureBaseStatsStore.find(MAKE_PAIR16(level, unitClass));

    if (it != _creatureBaseStatsStore.end())
        return &(it->second);

    struct DefaultCreatureBaseStats : public CreatureBaseStats
    {
        DefaultCreatureBaseStats()
        {
            BaseArmor = 1;
            for (uint8 j = 0; j < MAX_EXPANSIONS; ++j)
            {
                BaseHealth[j] = 1;
                BaseDamage[j] = 0.0f;
            }
            BaseMana = 0;
            AttackPower = 0;
            RangedAttackPower = 0;
        }
    };
    static const DefaultCreatureBaseStats defStats;
    return &defStats;
}

void ObjectMgr::LoadCreatureClassLevelStats()
{
    uint32 oldMSTime = getMSTime();

    QueryResult result = WorldDatabase.Query("SELECT level, class, basehp0, basehp1, basehp2, basemana, basearmor, attackpower, rangedattackpower, damage_base, damage_exp1, damage_exp2 FROM creature_classlevelstats");

    if (!result)
    {
        LOG_WARN("server.loading", ">> Loaded 0 creature base stats. DB table `creature_classlevelstats` is empty.");
        LOG_INFO("server.loading", " ");
        return;
    }

    uint32 count = 0;
    do
    {
        Field* fields = result->Fetch();

        uint8 Level = fields[0].Get<uint8>();
        uint8 Class = fields[1].Get<uint8>();

        if (!Class || ((1 << (Class - 1)) & CLASSMASK_ALL_CREATURES) == 0)
            LOG_ERROR("sql.sql", "Creature base stats for level {} has invalid class {}", Level, Class);

        CreatureBaseStats stats;

        for (uint8 i = 0; i < MAX_EXPANSIONS; ++i)
        {
            stats.BaseHealth[i] = fields[2 + i].Get<uint32>();

            if (stats.BaseHealth[i] == 0)
            {
                LOG_ERROR("sql.sql", "Creature base stats for class {}, level {} has invalid zero base HP[{}] - set to 1", Class, Level, i);
                stats.BaseHealth[i] = 1;
            }

            // xinef: if no data is available, get them from lower expansions
            if (stats.BaseHealth[i] <= 1)
            {
                for (uint8 j = i; j > 0;)
                {
                    --j;
                    if (stats.BaseHealth[j] > 1)
                    {
                        stats.BaseHealth[i] = stats.BaseHealth[j];
                        break;
                    }
                }
            }

            stats.BaseDamage[i] = fields[9 + i].Get<float>();
            if (stats.BaseDamage[i] < 0.0f)
            {
                LOG_ERROR("sql.sql", "Creature base stats for class {}, level {} has invalid negative base damage[{}] - set to 0.0", Class, Level, i);
                stats.BaseDamage[i] = 0.0f;
            }
        }

        stats.BaseMana = fields[5].Get<uint32>();
        stats.BaseArmor = fields[6].Get<uint32>();

        stats.AttackPower = fields[7].Get<uint32>();
        stats.RangedAttackPower = fields[8].Get<uint32>();

        _creatureBaseStatsStore[MAKE_PAIR16(Level, Class)] = stats;

        ++count;
    } while (result->NextRow());

    CreatureTemplateContainer const* ctc = sObjectMgr->GetCreatureTemplates();
    for (CreatureTemplateContainer::const_iterator itr = ctc->begin(); itr != ctc->end(); ++itr)
    {
        for (uint16 lvl = itr->second.minlevel; lvl <= itr->second.maxlevel; ++lvl)
        {
            if (_creatureBaseStatsStore.find(MAKE_PAIR16(lvl, itr->second.unit_class)) == _creatureBaseStatsStore.end())
                LOG_ERROR("sql.sql", "Missing base stats for creature class {} level {}", itr->second.unit_class, lvl);
        }
    }

    LOG_INFO("server.loading", ">> Loaded {} Creature Base Stats in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
}

void ObjectMgr::LoadFactionChangeAchievements()
{
    uint32 oldMSTime = getMSTime();

    QueryResult result = WorldDatabase.Query("SELECT alliance_id, horde_id FROM player_factionchange_achievement");

    if (!result)
    {
        LOG_WARN("server.loading", ">> Loaded 0 faction change achievement pairs. DB table `player_factionchange_achievement` is empty.");
        LOG_INFO("server.loading", " ");
        return;
    }

    uint32 count = 0;

    do
    {
        Field* fields = result->Fetch();

        uint32 alliance = fields[0].Get<uint32>();
        uint32 horde = fields[1].Get<uint32>();

        if (!sAchievementStore.LookupEntry(alliance))
            LOG_ERROR("sql.sql", "Achievement {} (alliance_id) referenced in `player_factionchange_achievement` does not exist, pair skipped!", alliance);
        else if (!sAchievementStore.LookupEntry(horde))
            LOG_ERROR("sql.sql", "Achievement {} (horde_id) referenced in `player_factionchange_achievement` does not exist, pair skipped!", horde);
        else
            FactionChangeAchievements[alliance] = horde;

        ++count;
    } while (result->NextRow());

    LOG_INFO("server.loading", ">> Loaded {} faction change achievement pairs in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
}

void ObjectMgr::LoadFactionChangeItems()
{
    uint32 oldMSTime = getMSTime();

    QueryResult result = WorldDatabase.Query("SELECT alliance_id, horde_id FROM player_factionchange_items");

    if (!result)
    {
        LOG_WARN("server.loading", ">> Loaded 0 faction change item pairs. DB table `player_factionchange_items` is empty.");
        LOG_INFO("server.loading", " ");
        return;
    }

    uint32 count = 0;

    do
    {
        Field* fields = result->Fetch();

        uint32 alliance = fields[0].Get<uint32>();
        uint32 horde = fields[1].Get<uint32>();

        if (!GetItemTemplate(alliance))
            LOG_ERROR("sql.sql", "Item {} (alliance_id) referenced in `player_factionchange_items` does not exist, pair skipped!", alliance);
        else if (!GetItemTemplate(horde))
            LOG_ERROR("sql.sql", "Item {} (horde_id) referenced in `player_factionchange_items` does not exist, pair skipped!", horde);
        else
            FactionChangeItems[alliance] = horde;

        ++count;
    } while (result->NextRow());

    LOG_INFO("server.loading", ">> Loaded {} faction change item pairs in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
}

void ObjectMgr::LoadFactionChangeQuests()
{
    uint32 oldMSTime = getMSTime();

    QueryResult result = WorldDatabase.Query("SELECT alliance_id, horde_id FROM player_factionchange_quests");

    if (!result)
    {
        LOG_WARN("server.loading", ">> Loaded 0 faction change quest pairs. DB table `player_factionchange_quests` is empty.");
        LOG_INFO("server.loading", " ");
        return;
    }

    uint32 count = 0;

    do
    {
        Field* fields = result->Fetch();

        uint32 alliance = fields[0].Get<uint32>();
        uint32 horde = fields[1].Get<uint32>();

        if (!sObjectMgr->GetQuestTemplate(alliance))
            LOG_ERROR("sql.sql", "Quest {} (alliance_id) referenced in `player_factionchange_quests` does not exist, pair skipped!", alliance);
        else if (!sObjectMgr->GetQuestTemplate(horde))
            LOG_ERROR("sql.sql", "Quest {} (horde_id) referenced in `player_factionchange_quests` does not exist, pair skipped!", horde);
        else
            FactionChangeQuests[alliance] = horde;

        ++count;
    } while (result->NextRow());

    LOG_INFO("server.loading", ">> Loaded {} faction change quest pairs in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
}

void ObjectMgr::LoadFactionChangeReputations()
{
    uint32 oldMSTime = getMSTime();

    QueryResult result = WorldDatabase.Query("SELECT alliance_id, horde_id FROM player_factionchange_reputations");

    if (!result)
    {
        LOG_WARN("server.loading", ">> Loaded 0 faction change reputation pairs. DB table `player_factionchange_reputations` is empty.");
        LOG_INFO("server.loading", " ");
        return;
    }

    uint32 count = 0;

    do
    {
        Field* fields = result->Fetch();

        uint32 alliance = fields[0].Get<uint32>();
        uint32 horde = fields[1].Get<uint32>();

        if (!sFactionStore.LookupEntry(alliance))
            LOG_ERROR("sql.sql", "Reputation {} (alliance_id) referenced in `player_factionchange_reputations` does not exist, pair skipped!", alliance);
        else if (!sFactionStore.LookupEntry(horde))
            LOG_ERROR("sql.sql", "Reputation {} (horde_id) referenced in `player_factionchange_reputations` does not exist, pair skipped!", horde);
        else
            FactionChangeReputation[alliance] = horde;

        ++count;
    } while (result->NextRow());

    LOG_INFO("server.loading", ">> Loaded {} faction change reputation pairs in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
}

void ObjectMgr::LoadFactionChangeSpells()
{
    uint32 oldMSTime = getMSTime();

    QueryResult result = WorldDatabase.Query("SELECT alliance_id, horde_id FROM player_factionchange_spells");

    if (!result)
    {
        LOG_WARN("server.loading", ">> Loaded 0 faction change spell pairs. DB table `player_factionchange_spells` is empty.");
        LOG_INFO("server.loading", " ");
        return;
    }

    uint32 count = 0;

    do
    {
        Field* fields = result->Fetch();

        uint32 alliance = fields[0].Get<uint32>();
        uint32 horde = fields[1].Get<uint32>();

        if (!sSpellMgr->GetSpellInfo(alliance))
            LOG_ERROR("sql.sql", "Spell {} (alliance_id) referenced in `player_factionchange_spells` does not exist, pair skipped!", alliance);
        else if (!sSpellMgr->GetSpellInfo(horde))
            LOG_ERROR("sql.sql", "Spell {} (horde_id) referenced in `player_factionchange_spells` does not exist, pair skipped!", horde);
        else
            FactionChangeSpells[alliance] = horde;

        ++count;
    } while (result->NextRow());

    LOG_INFO("server.loading", ">> Loaded {} faction change spell pairs in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
}

void ObjectMgr::LoadFactionChangeTitles()
{
    uint32 oldMSTime = getMSTime();

    QueryResult result = WorldDatabase.Query("SELECT alliance_id, horde_id FROM player_factionchange_titles");

    if (!result)
    {
        LOG_WARN("server.loading", ">> Loaded 0 faction change title pairs. DB table `player_factionchange_title` is empty.");
        return;
    }

    uint32 count = 0;

    do
    {
        Field* fields = result->Fetch();

        uint32 alliance = fields[0].Get<uint32>();
        uint32 horde = fields[1].Get<uint32>();

        if (!sCharTitlesStore.LookupEntry(alliance))
            LOG_ERROR("sql.sql", "Title {} (alliance_id) referenced in `player_factionchange_title` does not exist, pair skipped!", alliance);
        else if (!sCharTitlesStore.LookupEntry(horde))
            LOG_ERROR("sql.sql", "Title {} (horde_id) referenced in `player_factionchange_title` does not exist, pair skipped!", horde);
        else
            FactionChangeTitles[alliance] = horde;

        ++count;
    } while (result->NextRow());

    LOG_INFO("server.loading", ">> Loaded {} faction change title pairs in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
}

GameObjectTemplate const* ObjectMgr::GetGameObjectTemplate(uint32 entry)
{
    GameObjectTemplateContainer::const_iterator itr = _gameObjectTemplateStore.find(entry);
    if (itr != _gameObjectTemplateStore.end())
        return &(itr->second);

    return nullptr;
}

bool ObjectMgr::IsGameObjectStaticTransport(uint32 entry)
{
    GameObjectTemplate const* goinfo = GetGameObjectTemplate(entry);
    return goinfo && goinfo->type == GAMEOBJECT_TYPE_TRANSPORT;
}

GameObjectTemplateAddon const* ObjectMgr::GetGameObjectTemplateAddon(uint32 entry) const
{
    auto itr = _gameObjectTemplateAddonStore.find(entry);
    if (itr != _gameObjectTemplateAddonStore.end())
        return &itr->second;

    return nullptr;
}

CreatureTemplate const* ObjectMgr::GetCreatureTemplate(uint32 entry)
{
    return entry < _creatureTemplateStoreFast.size() ? _creatureTemplateStoreFast[entry] : nullptr;
}

VehicleAccessoryList const* ObjectMgr::GetVehicleAccessoryList(Vehicle* veh) const
{
    if (Creature* cre = veh->GetBase()->ToCreature())
    {
        // Give preference to GUID-based accessories
        VehicleAccessoryContainer::const_iterator itr = _vehicleAccessoryStore.find(cre->GetSpawnId());
        if (itr != _vehicleAccessoryStore.end())
            return &itr->second;
    }

    // Otherwise return entry-based
    VehicleAccessoryContainer::const_iterator itr = _vehicleTemplateAccessoryStore.find(veh->GetCreatureEntry());
    if (itr != _vehicleTemplateAccessoryStore.end())
        return &itr->second;
    return nullptr;
}

PlayerInfo const* ObjectMgr::GetPlayerInfo(uint32 race, uint32 class_) const
{
    if (race >= MAX_RACES)
        return nullptr;
    if (class_ >= MAX_CLASSES)
        return nullptr;
    PlayerInfo const* info = _playerInfo[race][class_];
    if (!info)
        return nullptr;
    return info;
}

void ObjectMgr::LoadGameObjectQuestItems()
{
    uint32 oldMSTime = getMSTime();

    //                                               0                1        2
    QueryResult result = WorldDatabase.Query("SELECT GameObjectEntry, ItemId, Idx FROM gameobject_questitem ORDER BY Idx ASC");

    if (!result)
    {
        LOG_WARN("server.loading", ">> Loaded 0 gameobject quest items. DB table `gameobject_questitem` is empty.");
        return;
    }

    uint32 count = 0;
    do
    {
        Field* fields = result->Fetch();

        uint32 entry = fields[0].Get<uint32>();
        uint32 item = fields[1].Get<uint32>();
        uint32 idx = fields[2].Get<uint32>();

        GameObjectTemplate const* goInfo = GetGameObjectTemplate(entry);
        if (!goInfo)
        {
            LOG_ERROR("sql.sql", "Table `gameobject_questitem` has data for nonexistent gameobject (entry: {}, idx: {}), skipped", entry, idx);
            continue;
        };

        ItemEntry const* dbcData = sItemStore.LookupEntry(item);
        if (!dbcData)
        {
            LOG_ERROR("sql.sql", "Table `gameobject_questitem` has nonexistent item (ID: {}) in gameobject (entry: {}, idx: {}), skipped", item, entry, idx);
            continue;
        };

        _gameObjectQuestItemStore[entry].push_back(item);

        ++count;
    } while (result->NextRow());

    LOG_INFO("server.loading", ">> Loaded {} Gameobject Quest Items in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
}

void ObjectMgr::LoadCreatureQuestItems()
{
    uint32 oldMSTime = getMSTime();

    //                                               0              1        2
    QueryResult result = WorldDatabase.Query("SELECT CreatureEntry, ItemId, Idx FROM creature_questitem ORDER BY Idx ASC");

    if (!result)
    {
        LOG_WARN("server.loading", ">> Loaded 0 creature quest items. DB table `creature_questitem` is empty.");
        return;
    }

    uint32 count = 0;
    do
    {
        Field* fields = result->Fetch();

        uint32 entry = fields[0].Get<uint32>();
        uint32 item = fields[1].Get<uint32>();
        uint32 idx = fields[2].Get<uint32>();

        CreatureTemplate const* creatureInfo = GetCreatureTemplate(entry);
        if (!creatureInfo)
        {
            LOG_ERROR("sql.sql", "Table `creature_questitem` has data for nonexistent creature (entry: {}, idx: {}), skipped", entry, idx);
            continue;
        };

        ItemEntry const* dbcData = sItemStore.LookupEntry(item);
        if (!dbcData)
        {
            LOG_ERROR("sql.sql", "Table `creature_questitem` has nonexistent item (ID: {}) in creature (entry: {}, idx: {}), skipped", item, entry, idx);
            continue;
        };

        _creatureQuestItemStore[entry].push_back(item);

        ++count;
    } while (result->NextRow());

    LOG_INFO("server.loading", ">> Loaded {} Creature Quest Items in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
}

void ObjectMgr::LoadQuestMoneyRewards()
{
    uint32 oldMSTime = getMSTime();

    _questMoneyRewards.clear();

    //                                                0       1       2       3       4       5       6       7       8       9       10
    QueryResult result = WorldDatabase.Query("SELECT `Level`, Money0, Money1, Money2, Money3, Money4, Money5, Money6, Money7, Money8, Money9 FROM `quest_money_reward` ORDER BY `Level`");
    if (!result)
    {
        LOG_WARN("server.loading", ">> Loaded 0 quest money rewards. DB table `quest_money_reward` is empty.");
        return;
    }

    uint32 count = 0;
    do
    {
        Field* fields = result->Fetch();
        uint32 Level = fields[0].Get<uint32>();

        QuestMoneyRewardArray& questMoneyReward = _questMoneyRewards[Level];
        questMoneyReward.fill(0);

        for (uint8 i = 0; i < MAX_QUEST_MONEY_REWARDS; ++i)
        {
            questMoneyReward[i] = fields[1 + i].Get<uint32>();
            ++count;
        }
    } while (result->NextRow());

    LOG_INFO("server.loading", ">> Loaded {} Quest Money Rewards in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
}

uint32 ObjectMgr::GetQuestMoneyReward(uint8 level, uint32 questMoneyDifficulty) const
{
    if (questMoneyDifficulty < MAX_QUEST_MONEY_REWARDS)
    {
        auto const& itr = _questMoneyRewards.find(level);
        if (itr != _questMoneyRewards.end())
        {
            return itr->second.at(questMoneyDifficulty);
        }
    }

    return 0;
}

void ObjectMgr::LoadInstanceSavedGameobjectStateData()
{
    uint32 oldMSTime = getMSTime();

    CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_SELECT_INSTANCE_SAVED_DATA);
    PreparedQueryResult result = CharacterDatabase.Query(stmt);

    if (!result)
    {
        // There's no gameobject with this GUID saved on the DB
        LOG_INFO("sql.sql", ">> Loaded 0 Instance saved gameobject state data. DB table `instance_saved_go_state_data` is empty.");
        return;
    }

    Field* fields;
    uint32 count = 0;
    do
    {
        fields = result->Fetch();
        GameobjectInstanceSavedStateList.push_back({ fields[0].Get<uint32>(), fields[1].Get<uint32>(), fields[2].Get<unsigned short>() });
        count++;
    } while (result->NextRow());

    LOG_INFO("server.loading", ">> Loaded {} instance saved gameobject state data in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
}

uint8 ObjectMgr::GetInstanceSavedGameobjectState(uint32 id, uint32 guid)
{
    for (auto it = GameobjectInstanceSavedStateList.begin(); it != GameobjectInstanceSavedStateList.end(); it++)
    {
        if (it->m_guid == guid && it->m_instance == id)
        {
            return it->m_state;
        }
    }
    return 3; // Any state higher than 2 to get the default state
}

bool ObjectMgr::FindInstanceSavedGameobjectState(uint32 id, uint32 guid)
{
    for (auto it = GameobjectInstanceSavedStateList.begin(); it != GameobjectInstanceSavedStateList.end(); it++)
    {
        if (it->m_guid == guid && it->m_instance == id)
        {
            return true;
        }
    }
    return false;
}

void ObjectMgr::SetInstanceSavedGameobjectState(uint32 id, uint32 guid, uint8 state)
{
    for (auto it = GameobjectInstanceSavedStateList.begin(); it != GameobjectInstanceSavedStateList.end(); it++)
    {
        if (it->m_guid == guid && it->m_instance == id)
        {
            it->m_state = state;
        }
    }
}
void ObjectMgr::NewInstanceSavedGameobjectState(uint32 id, uint32 guid, uint8 state)
{
    GameobjectInstanceSavedStateList.push_back({ id, guid, state });
}

void ObjectMgr::SendServerMail(Player* player, uint32 id, uint32 reqLevel, uint32 reqPlayTime, uint32 rewardMoneyA, uint32 rewardMoneyH, uint32 rewardItemA, uint32 rewardItemCountA, uint32 rewardItemH, uint32 rewardItemCountH, std::string subject, std::string body, uint8 active) const
{
    if (active)
    {
        if (player->GetLevel() < reqLevel)
            return;

        if (player->GetTotalPlayedTime() < reqPlayTime)
            return;

        CharacterDatabaseTransaction trans = CharacterDatabase.BeginTransaction();

        MailSender sender(MAIL_NORMAL, player->GetGUID().GetCounter(), MAIL_STATIONERY_GM);
        MailDraft draft(subject, body);

        draft.AddMoney(player->GetTeamId() == TEAM_ALLIANCE ? rewardMoneyA : rewardMoneyH);
        if (Item* mailItem = Item::CreateItem(player->GetTeamId() == TEAM_ALLIANCE ? rewardItemA : rewardItemH, player->GetTeamId() == TEAM_ALLIANCE ? rewardItemCountA : rewardItemCountH))
        {
            mailItem->SaveToDB(trans);
            draft.AddItem(mailItem);
        }

        draft.SendMailTo(trans, MailReceiver(player), sender);
        CharacterDatabase.CommitTransaction(trans);

        CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_REP_MAIL_SERVER_CHARACTER);
        stmt->SetData(0, player->GetGUID().GetCounter());
        stmt->SetData(1, id);
        CharacterDatabase.Execute(stmt);

        LOG_DEBUG("entities.player", "ObjectMgr::SendServerMail() Sent mail id {} to {}", id, player->GetGUID().ToString());
    }
}

void ObjectMgr::LoadMailServerTemplates()
{
    uint32 oldMSTime = getMSTime();

    _serverMailStore.clear(); // for reload case

    //                                                    0     1           2              3         4         5        6             7       8             9          10      11
    QueryResult result = CharacterDatabase.Query("SELECT `id`, `reqLevel`, `reqPlayTime`, `moneyA`, `moneyH`, `itemA`, `itemCountA`, `itemH`,`itemCountH`, `subject`, `body`, `active` FROM `mail_server_template`");
    if (!result)
    {
        LOG_INFO("sql.sql", ">> Loaded 0 server mail rewards. DB table `mail_server_template` is empty.");
        LOG_INFO("server.loading", " ");
        return;
    }

    _serverMailStore.rehash(result->GetRowCount());

    do
    {
        Field* fields = result->Fetch();

        uint32 id = fields[0].Get<uint32>();

        ServerMail& servMail = _serverMailStore[id];

        servMail.id          = id;
        servMail.reqLevel    = fields[1].Get<uint8>();
        servMail.reqPlayTime = fields[2].Get<uint32>();
        servMail.moneyA      = fields[3].Get<uint32>();
        servMail.moneyH      = fields[4].Get<uint32>();
        servMail.itemA       = fields[5].Get<uint32>();
        servMail.itemCountA  = fields[6].Get<uint32>();
        servMail.itemH       = fields[7].Get<uint32>();
        servMail.itemCountH  = fields[8].Get<uint32>();
        servMail.subject     = fields[9].Get<std::string>();
        servMail.body        = fields[10].Get<std::string>();
        servMail.active      = fields[11].Get<uint8>();

        if (servMail.reqLevel > sWorld->getIntConfig(CONFIG_MAX_PLAYER_LEVEL))
        {
            LOG_ERROR("sql.sql", "Table `mail_server_template` has reqLevel {} but max level is {} for id {}, skipped.", servMail.reqLevel, sWorld->getIntConfig(CONFIG_MAX_PLAYER_LEVEL), servMail.id);
            return;
        }

        if (servMail.moneyA > MAX_MONEY_AMOUNT || servMail.moneyH > MAX_MONEY_AMOUNT)
        {
            LOG_ERROR("sql.sql", "Table `mail_server_template` has moneyA {} or moneyH {} larger than MAX_MONEY_AMOUNT {} for id {}, skipped.", servMail.moneyA, servMail.moneyH, MAX_MONEY_AMOUNT, servMail.id);
            return;
        }

        ItemTemplate const* itemTemplateA = sObjectMgr->GetItemTemplate(servMail.itemA);
        if (!itemTemplateA && servMail.itemA)
        {
            LOG_ERROR("sql.sql", "Table `mail_server_template` has invalid item in itemA {} for id {}, skipped.", servMail.itemA, servMail.id);
            return;
        }
        ItemTemplate const* itemTemplateH = sObjectMgr->GetItemTemplate(servMail.itemH);
        if (!itemTemplateH && servMail.itemH)
        {
            LOG_ERROR("sql.sql", "Table `mail_server_template` has invalid item in itemH {} for id {}, skipped.", servMail.itemH, servMail.id);
            return;
        }

        if (!servMail.itemA && servMail.itemCountA)
        {
            LOG_ERROR("sql.sql", "Table `mail_server_template` has itemCountA {} with no ItemA, set to 0", servMail.itemCountA);
            servMail.itemCountA = 0;
        }
        if (!servMail.itemH && servMail.itemCountH)
        {
            LOG_ERROR("sql.sql", "Table `mail_server_template` has itemCountH {} with no ItemH, set to 0", servMail.itemCountH);
            servMail.itemCountH = 0;
        }
    } while (result->NextRow());

    LOG_INFO("server.loading", ">> Loaded {} Mail Server Template in {} ms", _serverMailStore.size(), GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
}

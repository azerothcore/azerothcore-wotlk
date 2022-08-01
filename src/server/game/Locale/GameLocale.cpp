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

#include "GameLocale.h"
#include "AccountMgr.h"
#include "Chat.h"
#include "DBCStores.h"
#include "DatabaseEnv.h"
#include "Config.h"
#include "LocaleCommon.h"
#include "Log.h"
#include "ModuleLocale.h"
#include "ObjectMgr.h"
#include "Realm.h"
#include "SpellInfo.h"
#include "SpellMgr.h"
#include "World.h"

GameLocale* GameLocale::instance()
{
    static GameLocale instance;
    return &instance;
}

void GameLocale::LoadAllLocales()
{
    // Get once for all the locale index of DBC language (console/broadcasts)
    SetDBCLocaleIndex(sWorld->GetDefaultDbcLocale());

    uint32 oldMSTime = getMSTime();

    LoadGameObjectLocales();
    LoadItemLocales();
    LoadItemSetNameLocales();
    LoadNpcTextLocales();
    LoadPageTextLocales();
    LoadGossipMenuItemsLocales();
    LoadPointOfInterestLocales();
    LoadQuestLocales();
    LoadQuestOfferRewardLocale();
    LoadQuestRequestItemsLocale();
    //LoadQuestGreetingLocales(); // not implement

    // Load new strings
    LoadRaceStrings();
    LoadClassStrings();

    // Load modules strings
    sModuleLocale->Init();

    LOG_INFO("server.loading", ">> Localization strings loaded in {} ms", GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", "");
}

bool GameLocale::LoadAcoreStrings()
{
    uint32 oldMSTime = getMSTime();

    _acoreStringStore.clear(); // for reload case

    QueryResult result = WorldDatabase.Query("SELECT entry, content_default, locale_koKR, locale_frFR, locale_deDE, locale_zhCN, locale_zhTW, locale_esES, locale_esMX, locale_ruRU FROM acore_string");
    if (!result)
    {
        LOG_WARN("sql.sql", ">> Loaded 0 warhead strings. DB table `warhead_strings` is empty.");
        LOG_WARN("sql.sql", "");
        return false;
    }

    do
    {
        Field* fields = result->Fetch();

        uint32 entry = fields[0].Get<uint32>();

        auto& data = _acoreStringStore[entry];

        data.Content.resize(DEFAULT_LOCALE + 1);

        for (uint8 i = 0; i < TOTAL_LOCALES; ++i)
            Acore::Locale::AddLocaleString(fields[i + 1].Get<std::string>(), LocaleConstant(i), data.Content);
    } while (result->NextRow());

    LOG_INFO("server.loading", ">> Loaded {} warhead strings in {} ms", static_cast<uint32>(_acoreStringStore.size()), GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", "");

    return true;
}



AcoreString const* GameLocale::GetAcoreString(uint32 entry) const
{
    auto const& itr = _acoreStringStore.find(entry);
    if (itr == _acoreStringStore.end())
        return nullptr;

    return &itr->second;
}


void GameLocale::LoadCreatureLocales()
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
        uint32 id = fields[0].Get<uint32>();

        LocaleConstant locale = GetLocaleByName(fields[1].Get<std::string>());
        if (locale == LOCALE_enUS)
            continue;

        /*if (CONF_GET_BOOL("Language.SupportOnlyDefault") && locale != GetDBCLocaleIndex())
            continue;*/

        CreatureLocale& data = _creatureLocaleStore[id];

        Acore::Locale::AddLocaleString(fields[2].Get<std::string>(), locale, data.Name);
        Acore::Locale::AddLocaleString(fields[3].Get<std::string>(), locale, data.Title);
    } while (result->NextRow());

    LOG_INFO("server.loading", ">> Loaded {} creature Locale strings in {} ms", static_cast<uint32>(_creatureLocaleStore.size()), GetMSTimeDiffToNow(oldMSTime));
}

void GameLocale::LoadGossipMenuItemsLocales()
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
        uint16 menuId = fields[0].Get<uint16>();
        uint16 optionId = fields[1].Get<uint16>();

        LocaleConstant locale = GetLocaleByName(fields[2].Get<std::string>());
        if (locale == LOCALE_enUS)
            continue;

        /*if (CONF_GET_BOOL("Language.SupportOnlyDefault") && locale != GetDBCLocaleIndex())
            continue;*/

        GossipMenuItemsLocale& data = _gossipMenuItemsLocaleStore[MAKE_PAIR32(menuId, optionId)];

        Acore::Locale::AddLocaleString(fields[3].Get<std::string>(), locale, data.OptionText);
        Acore::Locale::AddLocaleString(fields[4].Get<std::string>(), locale, data.BoxText);
    } while (result->NextRow());

    LOG_INFO("server.loading", ">> Loaded {} Gossip Menu Option Locale strings in {} ms", static_cast<uint32>(_gossipMenuItemsLocaleStore.size()), GetMSTimeDiffToNow(oldMSTime));
}

void GameLocale::LoadGameObjectLocales()
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
        uint32 id = fields[0].Get<uint32>();

        LocaleConstant locale = GetLocaleByName(fields[1].Get<std::string>());
        if (locale == LOCALE_enUS)
            continue;

        /*if (CONF_GET_BOOL("Language.SupportOnlyDefault") && locale != GetDBCLocaleIndex())
            continue;*/

        GameObjectLocale& data = _gameObjectLocaleStore[id];

        Acore::Locale::AddLocaleString(fields[2].Get<std::string>(), locale, data.Name);
        Acore::Locale::AddLocaleString(fields[3].Get<std::string>(), locale, data.CastBarCaption);
    } while (result->NextRow());

    LOG_INFO("server.loading", ">> Loaded {} Gameobject Locale strings in {} ms", static_cast<uint32>(_gameObjectLocaleStore.size()), GetMSTimeDiffToNow(oldMSTime));
}

void GameLocale::LoadItemLocales()
{
    uint32 oldMSTime = getMSTime();

    _itemLocaleStore.clear();                                 // need for reload case

    QueryResult result = WorldDatabase.Query("SELECT ID, locale, Name, Description FROM item_template_locale");
    if (!result)
        return;

    do
    {
        Field* fields = result->Fetch();
        uint32 id = fields[0].Get<uint32>();

        LocaleConstant locale = GetLocaleByName(fields[1].Get<std::string>());
        if (locale == LOCALE_enUS)
            continue;

        /*if (CONF_GET_BOOL("Language.SupportOnlyDefault") && locale != GetDBCLocaleIndex())
            continue;*/

        ItemLocale& data = _itemLocaleStore[id];

        Acore::Locale::AddLocaleString(fields[2].Get<std::string>(), locale, data.Name);
        Acore::Locale::AddLocaleString(fields[3].Get<std::string>(), locale, data.Description);
    } while (result->NextRow());

    LOG_INFO("server.loading", ">> Loaded {} Item Locale strings in {} ms", static_cast<uint32>(_itemLocaleStore.size()), GetMSTimeDiffToNow(oldMSTime));
}

void GameLocale::LoadItemSetNameLocales()
{
    uint32 oldMSTime = getMSTime();

    _itemSetNameLocaleStore.clear();                                 // need for reload case

    QueryResult result = WorldDatabase.Query("SELECT ID, locale, Name FROM item_set_names_locale");

    if (!result)
        return;

    do
    {
        Field* fields = result->Fetch();
        uint32 id = fields[0].Get<uint32>();

        LocaleConstant locale = GetLocaleByName(fields[1].Get<std::string>());
        if (locale == LOCALE_enUS)
            continue;

        /*if (CONF_GET_BOOL("Language.SupportOnlyDefault") && locale != GetDBCLocaleIndex())
            continue;*/

        ItemSetNameLocale& data = _itemSetNameLocaleStore[id];

        Acore::Locale::AddLocaleString(fields[2].Get<std::string>(), locale, data.Name);
    } while (result->NextRow());

    LOG_INFO("server.loading", ">> Loaded {} Item Set Name Locale strings in {} ms", static_cast<uint32>(_itemSetNameLocaleStore.size()), GetMSTimeDiffToNow(oldMSTime));
}

void GameLocale::LoadNpcTextLocales()
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
        uint32 id = fields[0].Get<uint32>();

        LocaleConstant locale = GetLocaleByName(fields[1].Get<std::string>());
        if (locale == LOCALE_enUS)
            continue;

        /*if (CONF_GET_BOOL("Language.SupportOnlyDefault") && locale != GetDBCLocaleIndex())
            continue;*/

        NpcTextLocale& data = _npcTextLocaleStore[id];

        for (uint8 i = 0; i < MAX_GOSSIP_TEXT_OPTIONS; ++i)
        {
            Acore::Locale::AddLocaleString(fields[2 + i * 2].Get<std::string>(), locale, data.Text_0[i]);
            Acore::Locale::AddLocaleString(fields[3 + i * 2].Get<std::string>(), locale, data.Text_1[i]);
        }
    } while (result->NextRow());

    LOG_INFO("server.loading", ">> Loaded {} Npc Text Locale strings in {} ms", static_cast<uint32>(_npcTextLocaleStore.size()), GetMSTimeDiffToNow(oldMSTime));
}

void GameLocale::LoadPageTextLocales()
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
        uint32 id = fields[0].Get<uint32>();

        LocaleConstant locale = GetLocaleByName(fields[1].Get<std::string>());
        if (locale == LOCALE_enUS)
            continue;

        /*if (CONF_GET_BOOL("Language.SupportOnlyDefault") && locale != GetDBCLocaleIndex())
            continue;*/

        PageTextLocale& data = _pageTextLocaleStore[id];

        Acore::Locale::AddLocaleString(fields[2].Get<std::string>(), locale, data.Text);
    } while (result->NextRow());

    LOG_INFO("server.loading", ">> Loaded {} Page Text Locale strings in {} ms", static_cast<uint32>(_pageTextLocaleStore.size()), GetMSTimeDiffToNow(oldMSTime));
}

void GameLocale::LoadPointOfInterestLocales()
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
        uint32 id = fields[0].Get<uint32>();

        LocaleConstant locale = GetLocaleByName(fields[1].Get<std::string>());
        if (locale == LOCALE_enUS)
            continue;

        /*if (CONF_GET_BOOL("Language.SupportOnlyDefault") && locale != GetDBCLocaleIndex())
            continue;*/

        PointOfInterestLocale& data = _pointOfInterestLocaleStore[id];

        Acore::Locale::AddLocaleString(fields[2].Get<std::string>(), locale, data.Name);
    } while (result->NextRow());

    LOG_INFO("server.loading", ">> Loaded {} Points Of Interest Locale strings in {} ms", static_cast<uint32>(_pointOfInterestLocaleStore.size()), GetMSTimeDiffToNow(oldMSTime));
}

void GameLocale::LoadQuestLocales()
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
        uint32 id = fields[0].Get<uint32>();

        LocaleConstant locale = GetLocaleByName(fields[1].Get<std::string>());
        if (locale == LOCALE_enUS)
            continue;

        /*if (CONF_GET_BOOL("Language.SupportOnlyDefault") && locale != GetDBCLocaleIndex())
            continue;*/

        QuestLocale& data = _questLocaleStore[id];

        Acore::Locale::AddLocaleString(fields[2].Get<std::string>(), locale, data.Title);
        Acore::Locale::AddLocaleString(fields[3].Get<std::string>(), locale, data.Details);
        Acore::Locale::AddLocaleString(fields[4].Get<std::string>(), locale, data.Objectives);
        Acore::Locale::AddLocaleString(fields[5].Get<std::string>(), locale, data.AreaDescription);
        Acore::Locale::AddLocaleString(fields[6].Get<std::string>(), locale, data.CompletedText);

        for (uint8 i = 0; i < 4; ++i)
            Acore::Locale::AddLocaleString(fields[i + 7].Get<std::string>(), locale, data.ObjectiveText[i]);
    } while (result->NextRow());

    LOG_INFO("server.loading", ">> Loaded {} Quest Locale strings in {} ms", static_cast<uint32>(_questLocaleStore.size()), GetMSTimeDiffToNow(oldMSTime));
}

void GameLocale::LoadQuestOfferRewardLocale()
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

        LocaleConstant locale = GetLocaleByName(fields[1].Get<std::string>());
        if (locale == LOCALE_enUS)
            continue;

        /*if (CONF_GET_BOOL("Language.SupportOnlyDefault") && locale != GetDBCLocaleIndex())
            continue;*/

        QuestOfferRewardLocale& data = _questOfferRewardLocaleStore[id];

        Acore::Locale::AddLocaleString(fields[2].Get<std::string>(), locale, data.RewardText);
    } while (result->NextRow());

    LOG_INFO("server.loading", ">> Loaded {} Quest Offer Reward locale strings in {} ms", static_cast<uint32>(_questOfferRewardLocaleStore.size()), GetMSTimeDiffToNow(oldMSTime));
}

void GameLocale::LoadQuestRequestItemsLocale()
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

        LocaleConstant locale = GetLocaleByName(fields[1].Get<std::string>());
        if (locale == LOCALE_enUS)
            continue;

        /*if (CONF_GET_BOOL("Language.SupportOnlyDefault") && locale != GetDBCLocaleIndex())
            continue;*/

        QuestRequestItemsLocale& data = _questRequestItemsLocaleStore[id];

        Acore::Locale::AddLocaleString(fields[2].Get<std::string>(), locale, data.CompletionText);
    } while (result->NextRow());

    LOG_INFO("server.loading", ">> Loaded {} Quest Request Items locale strings in {} ms", static_cast<uint32>(_questRequestItemsLocaleStore.size()), GetMSTimeDiffToNow(oldMSTime));
}



void GameLocale::LoadQuestGreetingLocales()
{
    uint32 oldMSTime = getMSTime();

    _questGreetingLocaleStore.clear();                              // need for reload case

    //                                               0     1      2       3
    QueryResult result = WorldDatabase.Query("SELECT ID, Type, Locale, Greeting FROM quest_greeting_locale");
    if (!result)
    {
        LOG_INFO("server.loading", ">> Loaded 0 quest_greeting locales. DB table `quest_greeting_locale` is empty.");
        return;
    }

    do
    {
        Field* fields = result->Fetch();
        uint32 id = fields[0].Get<uint32>();
        uint8 type = fields[1].Get<uint8>();

        // overwrite
        switch (type)
        {
        case 0: // Creature
            type = TYPEID_UNIT;
            break;
        case 1: // GameObject
            type = TYPEID_GAMEOBJECT;
            break;
        default:
            break;
        }

        LocaleConstant locale = GetLocaleByName(fields[2].Get<std::string>());
        if (locale == LOCALE_enUS)
            continue;

        /*if (CONF_GET_BOOL("Language.SupportOnlyDefault") && locale != GetDBCLocaleIndex())
            continue;*/

        QuestGreetingLocale& data = _questGreetingLocaleStore[MAKE_PAIR32(id, type)];

        Acore::Locale::AddLocaleString(fields[3].Get<std::string>(), locale, data.Greeting);
    } while (result->NextRow());

    LOG_INFO("server.loading", ">> Loaded {} quest greeting locale strings in {} ms", static_cast<uint32>(_questGreetingLocaleStore.size()), GetMSTimeDiffToNow(oldMSTime));
}


GameObjectLocale const* GameLocale::GetGameObjectLocale(uint32 entry) const
{
    auto const& itr = _gameObjectLocaleStore.find(entry);
    return itr != _gameObjectLocaleStore.end() ? &itr->second : nullptr;
}

GossipMenuItemsLocale const* GameLocale::GetGossipMenuItemsLocale(uint32 entry) const
{
    auto const& itr = _gossipMenuItemsLocaleStore.find(entry);
    return itr != _gossipMenuItemsLocaleStore.end() ? &itr->second : nullptr;
}

ItemLocale const* GameLocale::GetItemLocale(uint32 entry) const
{
    auto const& itr = _itemLocaleStore.find(entry);
    return itr != _itemLocaleStore.end() ? &itr->second : nullptr;
}

ItemSetNameLocale const* GameLocale::GetItemSetNameLocale(uint32 entry) const
{
    auto const& itr = _itemSetNameLocaleStore.find(entry);
    return itr != _itemSetNameLocaleStore.end() ? &itr->second : nullptr;
}

NpcTextLocale const* GameLocale::GetNpcTextLocale(uint32 entry) const
{
    auto const& itr = _npcTextLocaleStore.find(entry);
    return itr != _npcTextLocaleStore.end() ? &itr->second : nullptr;
}

PageTextLocale const* GameLocale::GetPageTextLocale(uint32 entry) const
{
    auto const& itr = _pageTextLocaleStore.find(entry);
    return itr != _pageTextLocaleStore.end() ? &itr->second : nullptr;
}

PointOfInterestLocale const* GameLocale::GetPointOfInterestLocale(uint32 entry) const
{
    auto const& itr = _pointOfInterestLocaleStore.find(entry);
    return itr != _pointOfInterestLocaleStore.end() ? &itr->second : nullptr;
}

QuestLocale const* GameLocale::GetQuestLocale(uint32 entry) const
{
    auto const& itr = _questLocaleStore.find(entry);
    return itr != _questLocaleStore.end() ? &itr->second : nullptr;
}

QuestOfferRewardLocale const* GameLocale::GetQuestOfferRewardLocale(uint32 entry) const
{
    auto const& itr = _questOfferRewardLocaleStore.find(entry);
    return itr != _questOfferRewardLocaleStore.end() ? &itr->second : nullptr;
}

QuestRequestItemsLocale const* GameLocale::GetQuestRequestItemsLocale(uint32 entry) const
{
    auto const& itr = _questRequestItemsLocaleStore.find(entry);
    return itr != _questRequestItemsLocaleStore.end() ? &itr->second : nullptr;
}

QuestGreetingLocale const* GameLocale::GetQuestGreetingLocale(uint32 id) const
{
    auto const& itr = _questGreetingLocaleStore.find(id);
    return itr != _questGreetingLocaleStore.end() ? &itr->second : nullptr;
}


// New locale
void GameLocale::LoadRaceStrings()
{
    uint32 oldMSTime = getMSTime();

    _raceStringStore.clear();                              // need for reload case

    QueryResult result = WorldDatabase.Query("SELECT ID, Locale, NameMale, NameFemale FROM `string_race`");
    if (!result)
    {
        LOG_WARN("sql.sql", "> DB table `string_race` is empty");
        return;
    }

    do
    {
        Field* fields = result->Fetch();
        uint32 ID = fields[0].Get<uint32>();

        LocaleConstant locale = GetLocaleByName(fields[1].Get<std::string>());

        /*if (CONF_GET_BOOL("Language.SupportOnlyDefault") && locale != GetDBCLocaleIndex())
            continue;*/

        auto& data = _raceStringStore[ID];

        Acore::Locale::AddLocaleString(fields[2].Get<std::string>(), locale, data.NameMale);
        Acore::Locale::AddLocaleString(fields[3].Get<std::string>(), locale, data.NameFemale);

    } while (result->NextRow());

    LOG_INFO("server.loading", ">> Loaded {} Race strings in {} ms", static_cast<uint32>(_raceStringStore.size()), GetMSTimeDiffToNow(oldMSTime));
}

void GameLocale::LoadClassStrings()
{
    uint32 oldMSTime = getMSTime();

    _classStringStore.clear();                              // need for reload case

    QueryResult result = WorldDatabase.Query("SELECT ID, Locale, NameMale, NameFemale FROM `string_class`");
    if (!result)
    {
        LOG_WARN("sql.sql", "> DB table `string_class` is empty");
        return;
    }

    do
    {
        Field* fields = result->Fetch();

        uint32 ID = fields[0].Get<uint32>();

        LocaleConstant locale = GetLocaleByName(fields[1].Get<std::string>());

        /*if (CONF_GET_BOOL("Language.SupportOnlyDefault") && locale != GetDBCLocaleIndex())
            continue;*/

        auto& data = _classStringStore[ID];

        Acore::Locale::AddLocaleString(fields[2].Get<std::string>(), locale, data.NameMale);
        Acore::Locale::AddLocaleString(fields[3].Get<std::string>(), locale, data.NameFemale);

    } while (result->NextRow());

    LOG_INFO("server.loading", ">> Loaded {} Class strings in {} ms", static_cast<uint32>(_classStringStore.size()), GetMSTimeDiffToNow(oldMSTime));
}

RaceString const* GameLocale::GetRaseString(uint32 id) const
{
    auto const& itr = _raceStringStore.find(id);
    return itr != _raceStringStore.end() ? &itr->second : nullptr;
}

ClassString const* GameLocale::GetClassString(uint32 id) const
{
    auto const& itr = _classStringStore.find(id);
    return itr != _classStringStore.end() ? &itr->second : nullptr;
}

std::string const GameLocale::GetItemNameLocale(uint32 itemID, int8 index_loc /*= DEFAULT_LOCALE*/)
{
    ItemTemplate const* itemTemplate = sObjectMgr->GetItemTemplate(itemID);
    ItemLocale const* itemLocale = GetItemLocale(itemID);
    std::string name;

    if (itemLocale)
        name = itemLocale->Name[index_loc];

    if (name.empty() && itemTemplate)
        name = itemTemplate->Name1;

    return name;
}

std::string const GameLocale::GetItemLink(uint32 itemID, int8 index_loc /*= DEFAULT_LOCALE*/)
{
    ItemTemplate const* itemTemplate = sObjectMgr->GetItemTemplate(itemID);
    if (!itemTemplate)
        return "";

    std::string name = GetItemNameLocale(itemID, index_loc);
    uint32 color = ItemQualityColors[itemTemplate ? itemTemplate->Quality : uint32(ITEM_QUALITY_POOR)];

    return Acore::StringFormat("|c{:08x}|Hitem:{}:0:0:0:0:0:0:0:0|h[{}]|h|r", color, itemID, name);
}

std::string const GameLocale::GetSpellLink(uint32 spellID, int8 index_loc /*= DEFAULT_LOCALE*/)
{
    auto const& spell = sSpellMgr->GetSpellInfo(spellID);
    if (!spell)
        return "";

    return Acore::StringFormat("|cffffffff|Hspell:{}|h[{}]|h|r", spell->Id, spell->SpellName[index_loc]);
}

std::string const GameLocale::GetSpellNamelocale(uint32 spellID, int8 index_loc /*= DEFAULT_LOCALE*/)
{
    auto const& spell = sSpellMgr->GetSpellInfo(spellID);
    if (!spell)
        return "";

    return spell->SpellName[index_loc];
}


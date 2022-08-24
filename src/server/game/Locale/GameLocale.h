/*
 * This file is part of the whCore Project. See AUTHORS file for Copyright information
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

#ifndef _GAME_LOCALE_H_
#define _GAME_LOCALE_H_

#include "Common.h"
#include "Optional.h"
#include "SharedDefines.h"
#include <unordered_map>
#include <vector>


// New strings and locales
struct RaceString
{
    RaceString()
    {
        NameMale.resize(DEFAULT_LOCALE + 1);
        NameFemale.resize(DEFAULT_LOCALE + 1);
    }

    std::vector<std::string> NameMale;
    std::vector<std::string> NameFemale;

    std::string const& GetText(LocaleConstant locale = DEFAULT_LOCALE, uint8 gender = GENDER_MALE) const
    {
        if (gender == GENDER_FEMALE)
        {
            if (NameFemale.size() > size_t(locale) && !NameFemale[locale].empty())
                return NameFemale[locale];

            if (NameMale.size() > size_t(locale) && !NameMale[locale].empty())
                return NameMale[locale];

            return NameFemale[DEFAULT_LOCALE];
        }

        if (NameMale.size() > size_t(locale) && !NameMale[locale].empty())
            return NameMale[locale];

        return NameMale[DEFAULT_LOCALE];
    }
};

struct ClassString
{
    ClassString()
    {
        NameMale.resize(DEFAULT_LOCALE + 1);
        NameFemale.resize(DEFAULT_LOCALE + 1);
    }

    std::vector<std::string> NameMale;
    std::vector<std::string> NameFemale;

    [[nodiscard]] std::string const& GetText(LocaleConstant locale = DEFAULT_LOCALE, uint8 gender = GENDER_MALE) const
    {
        if (gender == GENDER_FEMALE)
        {
            if (NameFemale.size() > size_t(locale) && !NameFemale[locale].empty())
                return NameFemale[locale];

            if (NameMale.size() > size_t(locale) && !NameMale[locale].empty())
                return NameMale[locale];

            return NameFemale[DEFAULT_LOCALE];
        }

        if (NameMale.size() > size_t(locale) && !NameMale[locale].empty())
            return NameMale[locale];

        return NameMale[DEFAULT_LOCALE];
    }
};

class AC_GAME_API GameLocale
{
private:
    GameLocale() = default;
    ~GameLocale() = default;

    GameLocale(GameLocale const&) = delete;
    GameLocale(GameLocale&&) = delete;
    GameLocale& operator= (GameLocale const&) = delete;
    GameLocale& operator= (GameLocale&&) = delete;

public:
    static GameLocale* instance();

    void LoadAllLocales();
    bool LoadAcoreStrings();

    static inline std::string_view GetLocaleString(std::vector<std::string> const& data, size_t locale)
    {
        if (locale < data.size())
            return data[locale];
        else
            return {};
    }

    static inline void GetLocaleString(const std::vector<std::string>& data, int loc_idx, std::string& value)
    {
        if (data.size() > size_t(loc_idx) && !data[loc_idx].empty())
            value = data[loc_idx];
    }

    AcoreString const* GetAcoreString(uint32 entry) const;
    std::string GetAcoreString(uint32 entry, LocaleConstant locale) const;
    std::string GetAcoreStringForDBCLocale(uint32 entry) const { return GetAcoreString(entry, DBCLocaleIndex); }

    LocaleConstant GetDBCLocaleIndex() const { return DBCLocaleIndex; }
    void SetDBCLocaleIndex(LocaleConstant locale) { DBCLocaleIndex = locale; }

    void LoadAchievementRewardLocales();
    void LoadBroadcastTexts();
    void LoadBroadcastTextLocales();
    void LoadCreatureLocales();
    void LoadGameObjectLocales();
    void LoadItemLocales();
    void LoadItemSetNameLocales();
    void LoadQuestLocales();
    void LoadNpcTextLocales();
    void LoadQuestOfferRewardLocale();
    void LoadQuestRequestItemsLocale();
    void LoadPageTextLocales();
    void LoadGossipMenuItemsLocales();
    void LoadPointOfInterestLocales();
    void LoadQuestGreetingLocales();
    void LoadChatCommandsLocales();
    void LoadAutoBroadCastLocales();

    
    [[nodiscard]] BroadcastText const* GetBroadcastText(uint32 id) const;
    [[nodiscard]] CreatureLocale const* GetCreatureLocale(uint32 entry) const;
    [[nodiscard]] GameObjectLocale const* GetGameObjectLocale(uint32 entry) const;
    [[nodiscard]] GossipMenuItemsLocale const* GetGossipMenuItemsLocale(uint32 entry) const;
    [[nodiscard]] ItemLocale const* GetItemLocale(uint32 entry) const;
    [[nodiscard]] ItemSetNameLocale const* GetItemSetNameLocale(uint32 entry) const;
    [[nodiscard]] NpcTextLocale const* GetNpcTextLocale(uint32 entry) const;
    [[nodiscard]] PageTextLocale const* GetPageTextLocale(uint32 entry) const;
    [[nodiscard]] PointOfInterestLocale const* GetPointOfInterestLocale(uint32 entry) const;
    [[nodiscard]] QuestLocale const* GetQuestLocale(uint32 entry) const;
    [[nodiscard]] QuestOfferRewardLocale const* GetQuestOfferRewardLocale(uint32 entry) const;
    [[nodiscard]] QuestRequestItemsLocale const* GetQuestRequestItemsLocale(uint32 entry) const;
    [[nodiscard]] QuestGreetingLocale const* GetQuestGreetingLocale(uint32 id) const;
  

    //
    std::string const GetItemNameLocale(uint32 itemID, int8 index_loc = DEFAULT_LOCALE);
    std::string const GetItemLink(uint32 itemID, int8 index_loc = DEFAULT_LOCALE);
    std::string const GetSpellLink(uint32 spellID, int8 index_loc = DEFAULT_LOCALE);
    std::string const GetSpellNamelocale(uint32 spellID, int8 index_loc = DEFAULT_LOCALE);
    std::string const GetCreatureNamelocale(uint32 creatureEntry, int8 index_loc = DEFAULT_LOCALE);

    // New strings and locales
    void LoadRaceStrings();
    void LoadClassStrings();

    RaceString const* GetRaseString(uint32 id) const;
    ClassString const* GetClassString(uint32 id) const;

    Optional<std::string> GetChatCommandStringHelpLocale(std::string const& commandName, LocaleConstant locale) const;

private:
    std::unordered_map<uint32, AcoreString> _acoreStringStore;
    LocaleConstant DBCLocaleIndex = LOCALE_enUS;

   
    std::unordered_map<uint32, BroadcastText> _broadcastTextStore;
    std::unordered_map<uint32, CreatureLocale> _creatureLocaleStore;
    std::unordered_map<uint32, GameObjectLocale> _gameObjectLocaleStore;
    std::unordered_map<uint32, GossipMenuItemsLocale> _gossipMenuItemsLocaleStore;
    std::unordered_map<uint32, ItemLocale> _itemLocaleStore;
    std::unordered_map<uint32, ItemSetNameLocale> _itemSetNameLocaleStore;
    std::unordered_map<uint32, NpcTextLocale> _npcTextLocaleStore;
    std::unordered_map<uint32, PageTextLocale> _pageTextLocaleStore;
    std::unordered_map<uint32, PointOfInterestLocale> _pointOfInterestLocaleStore;
    std::unordered_map<uint32, QuestLocale> _questLocaleStore;
    std::unordered_map<uint32, QuestGreetingLocale> _questGreetingLocaleStore;
    std::unordered_map<uint32, QuestOfferRewardLocale> _questOfferRewardLocaleStore;
    std::unordered_map<uint32, QuestRequestItemsLocale> _questRequestItemsLocaleStore;

    // New strings and locales
    std::unordered_map<uint32, RaceString> _raceStringStore;
    std::unordered_map<uint32, ClassString> _classStringStore;


};

#define sGameLocale GameLocale::instance()

#endif // _GAME_LOCALE_H_

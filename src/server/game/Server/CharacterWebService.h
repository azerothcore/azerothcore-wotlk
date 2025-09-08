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

#ifndef CHARACTER_WEB_SERVICE_H
#define CHARACTER_WEB_SERVICE_H

#include "Common.h"
#include "IoContext.h"
#include "DatabaseEnvFwd.h"
#include <boost/asio.hpp>
#include <boost/beast.hpp>
#include <memory>
#include <string>
#include <unordered_map>

using tcp = boost::asio::ip::tcp;
namespace http = boost::beast::http;

class Player;
class Item;

struct ItemData
{
    std::string name;
    uint32 id;
    std::string slot;
    struct EnchantData {
        std::string name;
        uint32 id;
        uint32 itemId = 0;
        uint32 spellId = 0;
    } enchant;
};

struct TalentData
{
    std::string name;
    uint32 id;
    uint32 rank;
    uint32 spellId;
};

struct GlyphData
{
    std::string name;
    uint32 id;
    std::string type; // MAJOR or MINOR
};

struct CharacterData
{
    std::string name;
    uint32 level;
    std::string gameClass;
    std::string race;
    std::string faction;
};

struct CharacterRequest
{
    std::string name;
    uint32 phase;
    CharacterData character;
    std::vector<ItemData> items;
    std::vector<TalentData> talents;
    std::vector<GlyphData> glyphs;
};

class CharacterWebService
{
public:
    CharacterWebService(Acore::Asio::IoContext& ioContext, uint16 port);
    ~CharacterWebService();

    bool Start();
    void Stop();

private:
    void DoAccept();
    void HandleRequest(tcp::socket socket);
    void ProcessCharacterRequest(const std::string& body, std::string& response);
    
    // JSON parsing helpers
    std::string ExtractJsonString(const std::string& json, const std::string& key);
    uint32 ExtractJsonNumber(const std::string& json, const std::string& key);
    std::vector<std::string> ExtractJsonArray(const std::string& json, const std::string& arrayName);
    
    bool ApplyCharacterGear(const CharacterRequest& request);
    bool UpdateCharacterConfiguration(uint32 characterGuid, const CharacterData& charData, CharacterDatabaseTransaction& trans);
    void GrantRequiredProficiencies(uint32 characterGuid, const std::vector<ItemData>& items, CharacterDatabaseTransaction& trans);
    void UpdateEquipmentCache(uint32 characterGuid, const std::vector<ItemData>& items, CharacterDatabaseTransaction& trans);
    bool ApplyItemToDatabase(uint32 characterGuid, const ItemData& itemData, CharacterDatabaseTransaction& trans);
    bool ApplyEnchantmentToDatabase(uint32 itemGuid, const ItemData::EnchantData& enchantData, CharacterDatabaseTransaction& trans);
    uint8 GetEquipmentSlot(const std::string& slotName);
    uint8 GetClassId(const std::string& className);
    uint8 GetRaceId(const std::string& raceName);
    uint32 GenerateItemGuid();
    void GrantAllClassSpells(uint32 characterGuid, uint8 level, uint8 classId, uint8 raceId, CharacterDatabaseTransaction& trans);
    void ApplyCharacterTalents(uint32 characterGuid, const std::vector<TalentData>& talents, CharacterDatabaseTransaction& trans);
    void ApplyCharacterGlyphs(uint32 characterGuid, const std::vector<GlyphData>& glyphs, CharacterDatabaseTransaction& trans);
    uint32 GetGlyphSpellId(uint32 itemId);
    bool DeleteCharacterFromDatabase(const std::string& characterName, uint32 accountId, CharacterDatabaseTransaction& trans);
    bool CreateCharacterInDatabase(const CharacterRequest& request, uint32 accountId, CharacterDatabaseTransaction& trans, uint32& outGuid, bool grantGenderChangeSpell = false);
    
    Acore::Asio::IoContext& _ioContext;
    tcp::acceptor _acceptor;
    uint16 _port;
    bool _running;
};

#endif // CHARACTER_WEB_SERVICE_H
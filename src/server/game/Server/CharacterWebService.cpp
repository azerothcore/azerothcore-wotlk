/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU Affero General Public License as published by the
 * Free Software Foundation; either version 3 of the License, or (at your
 option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "CharacterWebService.h"
#include "Player.h"
#include "Item.h"
#include "ObjectMgr.h"
#include "ObjectAccessor.h"
#include "World.h"
#include "Log.h"
#include "SharedDefines.h"
#include "SpellMgr.h"
#include "DBCStores.h"
#include "DatabaseEnv.h"
#include "ObjectGuid.h"
#include <boost/beast/version.hpp>
#include <sstream>
#include <thread>
#include <regex>

CharacterWebService::CharacterWebService(Acore::Asio::IoContext& ioContext, uint16 port)
    : _ioContext(ioContext), _acceptor(ioContext, tcp::endpoint(tcp::v4(), port)), _port(port), _running(false)
{
}

CharacterWebService::~CharacterWebService()
{
    Stop();
}

bool CharacterWebService::Start()
{
    try 
    {
        _running = true;
        DoAccept();
        LOG_INFO("server.worldserver", "Character Web Service started on port {}", _port);
        return true;
    }
    catch (std::exception const& e)
    {
        LOG_ERROR("server.worldserver", "Failed to start Character Web Service: {}", e.what());
        return false;
    }
}

void CharacterWebService::Stop()
{
    if (!_running)
        return;

    _running = false;
    boost::system::error_code ec;
    _acceptor.close(ec);
    LOG_INFO("server.worldserver", "Character Web Service stopped");
}

void CharacterWebService::DoAccept()
{
    _acceptor.async_accept(
        [this](boost::system::error_code ec, tcp::socket socket)
        {
            if (!ec && _running)
            {
                std::thread(&CharacterWebService::HandleRequest, this, std::move(socket)).detach();
            }

            if (_running)
                DoAccept();
        });
}

void CharacterWebService::HandleRequest(tcp::socket socket)
{
    try
    {
        boost::beast::flat_buffer buffer;
        http::request<http::string_body> request;
        
        http::read(socket, buffer, request);

        std::string response_body;
        http::status status = http::status::ok;

        if (request.method() == http::verb::post && request.target() == "/character/gear")
        {
            ProcessCharacterRequest(request.body(), response_body);
        }
        else
        {
            status = http::status::not_found;
            response_body = "{\"error\":\"Endpoint not found\"}";
        }

        http::response<http::string_body> response{status, request.version()};
        response.set(http::field::server, BOOST_BEAST_VERSION_STRING);
        response.set(http::field::content_type, "application/json");
        response.set(http::field::access_control_allow_origin, "*");
        response.body() = response_body;
        response.prepare_payload();

        http::write(socket, response);
        socket.shutdown(tcp::socket::shutdown_send);
    }
    catch (std::exception const& e)
    {
        LOG_ERROR("server.worldserver", "Error handling web request: {}", e.what());
    }
}

std::string CharacterWebService::ExtractJsonString(const std::string& json, const std::string& key)
{
    std::regex pattern("\"" + key + "\"\\s*:\\s*\"([^\"]+)\"");
    std::smatch matches;
    if (std::regex_search(json, matches, pattern))
        return matches[1].str();
    return "";
}

uint32 CharacterWebService::ExtractJsonNumber(const std::string& json, const std::string& key)
{
    std::regex pattern("\"" + key + "\"\\s*:\\s*(\\d+)");
    std::smatch matches;
    if (std::regex_search(json, matches, pattern))
        return std::stoul(matches[1].str());
    return 0;
}

std::vector<std::string> CharacterWebService::ExtractJsonArray(const std::string& json, const std::string& arrayName)
{
    std::vector<std::string> items;
    std::regex arrayPattern("\"" + arrayName + "\"\\s*:\\s*\\[([^\\]]+)\\]");
    std::smatch arrayMatch;
    
    if (std::regex_search(json, arrayMatch, arrayPattern))
    {
        std::string arrayContent = arrayMatch[1].str();
        
        // Parse JSON objects with proper brace matching to handle nested objects
        size_t pos = 0;
        while (pos < arrayContent.length())
        {
            size_t start = arrayContent.find('{', pos);
            if (start == std::string::npos) break;
            
            // Count braces to find the matching closing brace
            int braceCount = 1;
            size_t end = start + 1;
            while (end < arrayContent.length() && braceCount > 0)
            {
                if (arrayContent[end] == '{') braceCount++;
                else if (arrayContent[end] == '}') braceCount--;
                end++;
            }
            
            if (braceCount == 0)
            {
                std::string item = arrayContent.substr(start, end - start);
                items.push_back(item);
                pos = end;
            }
            else
            {
                break; // Malformed JSON
            }
        }
    }
    
    return items;
}

void CharacterWebService::ProcessCharacterRequest(const std::string& body, std::string& response)
{
    try
    {
        CharacterRequest request;
        
        // Extract basic character info
        request.character.name = ExtractJsonString(body, "name");
        request.phase = ExtractJsonNumber(body, "phase");
        
        // Extract character details from nested object
        std::regex charPattern("\"character\"\\s*:\\s*\\{([^}]+)\\}");
        std::smatch charMatch;
        if (std::regex_search(body, charMatch, charPattern))
        {
            std::string charData = charMatch[1].str();
            request.character.name = ExtractJsonString(charData, "name");
            request.character.level = ExtractJsonNumber(charData, "level");
            request.character.gameClass = ExtractJsonString(charData, "gameClass");
            request.character.race = ExtractJsonString(charData, "race");
            request.character.faction = ExtractJsonString(charData, "faction");
        }

        // Extract items array
        std::vector<std::string> itemStrings = ExtractJsonArray(body, "items");
        for (const auto& itemStr : itemStrings)
        {            
            ItemData item;
            item.name = ExtractJsonString(itemStr, "name");
            item.id = ExtractJsonNumber(itemStr, "id");
            item.slot = ExtractJsonString(itemStr, "slot");
            
            // Extract enchant if present
            std::regex enchantPattern("\"enchant\"\\s*:\\s*\\{([^}]+)\\}");
            std::smatch enchantMatch;
            if (std::regex_search(itemStr, enchantMatch, enchantPattern))
            {
                std::string enchantData = enchantMatch[1].str();
                item.enchant.name = ExtractJsonString(enchantData, "name");
                item.enchant.id = ExtractJsonNumber(enchantData, "id");
                item.enchant.itemId = ExtractJsonNumber(enchantData, "itemId");
                item.enchant.spellId = ExtractJsonNumber(enchantData, "spellId");
            }
            
            request.items.push_back(item);
        }

        bool success = ApplyCharacterGear(request);
        
        // Build response JSON manually
        std::ostringstream oss;
        oss << "{\"success\":" << (success ? "true" : "false") 
            << ",\"character\":\"" << request.character.name << "\""
            << ",\"itemsApplied\":" << (success ? request.items.size() : 0);
        
        if (success)
            oss << ",\"message\":\"Character configuration and gear updated successfully\"";
        else
            oss << ",\"error\":\"Failed to update character configuration and gear\"";
            
        oss << "}";
        response = oss.str();
    }
    catch (std::exception const& e)
    {
        response = "{\"success\":false,\"error\":\"Processing error: " + std::string(e.what()) + "\"}";
    }
}

bool CharacterWebService::ApplyCharacterGear(const CharacterRequest& request)
{
    // First check if player is online - they must be OFFLINE
    Player* player = ObjectAccessor::FindPlayerByName(request.character.name);
    if (player)
    {
        LOG_ERROR("server.worldserver", "Character '{}' must be offline for gear changes", request.character.name);
        return false;
    }

    // Get character data from database
    uint32 characterGuid = 0;
    QueryResult result = CharacterDatabase.Query("SELECT guid, account FROM characters WHERE name = '{}'", request.character.name);
    
    if (!result)
    {
        LOG_ERROR("server.worldserver", "Character '{}' not found in database", request.character.name);
        return false;
    }
    
    Field* fields = result->Fetch();
    characterGuid = fields[0].Get<uint32>();
    uint32 accountId = fields[1].Get<uint32>();

    // Check if character is in a battleground by checking their map ID
    // Battleground map IDs: 30 (AV), 489 (WS), 529 (AB), 566 (EY), 607 (SA), 628 (IC)
    // Arena map IDs: 572 (Nagrand), 562 (Blade's Edge), 617 (Ruins), 618 (Ring of Valor)
    QueryResult mapResult = CharacterDatabase.Query("SELECT map FROM characters WHERE guid = {}", characterGuid);
    
    if (mapResult)
    {
        Field* mapFields = mapResult->Fetch();
        uint32 mapId = mapFields[0].Get<uint32>();
        
        // Check if the map is a battleground or arena
        if (mapId == 30 || mapId == 489 || mapId == 529 || mapId == 566 || 
            mapId == 607 || mapId == 628 || mapId == 572 || mapId == 562 || 
            mapId == 617 || mapId == 618)
        {
            LOG_ERROR("server.worldserver", "Character '{}' is currently in a battleground/arena (map {}) and cannot have gear changed", 
                     request.character.name, mapId);
            return false;
        }
    }

    bool success = true;
    CharacterDatabaseTransaction trans = CharacterDatabase.BeginTransaction();
    
    // Update character level, class, race, and faction if provided
    if (!UpdateCharacterConfiguration(characterGuid, request.character, trans))
    {
        LOG_ERROR("server.worldserver", "Failed to update character configuration for '{}'", request.character.name);
        success = false;
    }
    
    // Grant necessary proficiencies before applying gear
    GrantRequiredProficiencies(characterGuid, request.items, trans);
    
    // Apply gear changes directly to database
    for (const auto& itemData : request.items)
    {
        if (!ApplyItemToDatabase(characterGuid, itemData, trans))
        {
            LOG_ERROR("server.worldserver", "Failed to equip item '{}' on character '{}'", 
                     itemData.name, request.character.name);
            success = false;
        }
    }

    if (success)
    {
        // Update equipment cache so character appears equipped on character select
        UpdateEquipmentCache(characterGuid, trans);
        
        CharacterDatabase.CommitTransaction(trans);
        LOG_INFO("server.worldserver", "Successfully updated configuration and gear for offline character '{}'", request.character.name);
    }
    else
    {
        // Transaction will automatically rollback if not committed
        LOG_ERROR("server.worldserver", "Failed to update configuration and gear for character '{}', changes rolled back", request.character.name);
    }

    return success;
}

void CharacterWebService::GrantRequiredProficiencies(uint32 characterGuid, const std::vector<ItemData>& items, CharacterDatabaseTransaction& trans)
{
    // Check which items require special proficiencies and grant them
    bool needsFishing = false;
    bool needsWeaponSkills = false;
    
    for (const auto& itemData : items)
    {
        ItemTemplate const* itemTemplate = sObjectMgr->GetItemTemplate(itemData.id);
        if (!itemTemplate)
            continue;
            
        // Check for fishing items (Lucky Fishing Hat, Nat Pagle's boots, etc.)
        if (itemData.id == 19972 || itemData.id == 19969 || itemData.id == 19979) // Fishing tournament rewards
        {
            needsFishing = true;
        }
        
        // Check for weapon proficiency requirements based on item class/subclass
        if (itemTemplate->Class == ITEM_CLASS_WEAPON)
        {
            needsWeaponSkills = true;
        }
    }
    
    if (needsFishing)
    {
        // Grant fishing skill (356) with max value for level 80
        trans->Append("INSERT INTO character_skills (guid, skill, value, max) VALUES ({}, 356, 450, 450) "
                     "ON DUPLICATE KEY UPDATE value = 450, max = 450", characterGuid);
    }
    
    if (needsWeaponSkills)
    {
        // Grant common weapon skills that might be needed
        // These are just examples - you might need more based on specific items
        uint32 weaponSkills[] = {43, 44, 45, 46, 54, 55, 95, 118, 136, 160, 172, 173, 176, 226, 227, 229, 236, 267}; // Various weapon skills
        for (uint32 skill : weaponSkills)
        {
            trans->Append("INSERT INTO character_skills (guid, skill, value, max) VALUES ({}, {}, 400, 400) "
                         "ON DUPLICATE KEY UPDATE value = GREATEST(value, 400), max = GREATEST(max, 400)", 
                         characterGuid, skill);
        }
    }
}

uint32 CharacterWebService::GenerateItemGuid()
{
    // Generate a unique item GUID by querying the highest existing GUID and incrementing
    static uint32 guidCounter = 0;
    if (guidCounter == 0)
    {
        QueryResult result = CharacterDatabase.Query("SELECT MAX(guid) FROM item_instance");
        if (result)
        {
            Field* field = result->Fetch();
            guidCounter = field[0].Get<uint32>();
        }
        if (guidCounter < 1000000)
            guidCounter = 1000000; // Start from a safe high number
    }
    return ++guidCounter;
}

bool CharacterWebService::ApplyItemToDatabase(uint32 characterGuid, const ItemData& itemData, CharacterDatabaseTransaction& trans)
{
    uint8 slot = GetEquipmentSlot(itemData.slot);
    if (slot >= EQUIPMENT_SLOT_END)
    {
        LOG_ERROR("server.worldserver", "Invalid equipment slot: {}", itemData.slot);
        return false;
    }

    ItemTemplate const* itemTemplate = sObjectMgr->GetItemTemplate(itemData.id);
    if (!itemTemplate)
    {
        LOG_ERROR("server.worldserver", "Item template not found for ID: {}", itemData.id);
        return false;
    }

    // Remove existing item in this slot completely (both item_instance and character_inventory)
    trans->Append("DELETE ii FROM item_instance ii INNER JOIN character_inventory ci ON ii.guid = ci.item WHERE ci.guid = {} AND ci.bag = 0 AND ci.slot = {}", 
                 characterGuid, slot);
    trans->Append("DELETE FROM character_inventory WHERE guid = {} AND bag = 0 AND slot = {}", 
                 characterGuid, slot);

    // Generate new item GUID
    uint32 itemGuid = GenerateItemGuid();

    // Insert item_instance record  
    // AzerothCore enchantment format: "enchant_id duration charges" for PERM_ENCHANTMENT_SLOT (slot 0)
    // Then remaining slots with "0 0 0" - total should be 3 values per slot for 12 slots = 36 values
    std::string enchantString = "";
    if (!itemData.enchant.name.empty() && itemData.enchant.id > 0)
    {
        // Permanent enchant in slot 0: "enchant_id 0 0", then 11 more slots of "0 0 0"
        enchantString = std::to_string(itemData.enchant.id) + " 0 0";
        for (int i = 1; i < 12; i++) {
            enchantString += " 0 0 0";
        }
    }
    else
    {
        // No enchantments: 12 slots * 3 values = 36 zeros
        enchantString = "";
        for (int i = 0; i < 12; i++) {
            if (i > 0) enchantString += " ";
            enchantString += "0 0 0";
        }
    }

    // Set durability to max value from item template
    uint32 durability = itemTemplate->MaxDurability;
    
    trans->Append("INSERT INTO item_instance (guid, itemEntry, owner_guid, creatorGuid, giftCreatorGuid, count, duration, charges, flags, enchantments, randomPropertyId, durability, playedTime, text) "
                 "VALUES ({}, {}, {}, 0, 0, 1, 0, '0 0 0 0 0', 0, '{}', 0, {}, 0, '')",
                 itemGuid, itemData.id, characterGuid, enchantString, durability);

    // Insert character_inventory record directly into equipment slot
    trans->Append("INSERT INTO character_inventory (guid, bag, slot, item) VALUES ({}, 0, {}, {})",
                 characterGuid, slot, itemGuid);

    return true;
}

bool CharacterWebService::ApplyEnchantmentToDatabase(uint32 itemGuid, const ItemData::EnchantData& enchantData, CharacterDatabaseTransaction& trans)
{
    SpellItemEnchantmentEntry const* enchant = sSpellItemEnchantmentStore.LookupEntry(enchantData.id);
    if (!enchant)
    {
        LOG_ERROR("server.worldserver", "Enchantment not found for ID: {}", enchantData.id);
        return false;
    }

    // This is handled in ApplyItemToDatabase now
    return true;
}

bool CharacterWebService::UpdateCharacterConfiguration(uint32 characterGuid, const CharacterData& charData, CharacterDatabaseTransaction& trans)
{
    // Convert string values to database IDs
    uint8 classId = GetClassId(charData.gameClass);
    uint8 raceId = GetRaceId(charData.race);
    
    if (classId == 0)
    {
        LOG_ERROR("server.worldserver", "Invalid class: {}", charData.gameClass);
        return false;
    }
    
    if (raceId == 0)
    {
        LOG_ERROR("server.worldserver", "Invalid race: {}", charData.race);
        return false;
    }

    // Update character configuration in database (keep original level)
    // Don't clear equipmentCache so character appears equipped on character select
    trans->Append("UPDATE characters SET level = {}, class = {}, race = {} WHERE guid = {}",
                 charData.level, classId, raceId, characterGuid);

    LOG_INFO("server.worldserver", "Updated character {} - Level: {}, Class: {} ({}), Race: {} ({})", 
             charData.name, charData.level, charData.gameClass, classId, charData.race, raceId);

    return true;
}

uint8 CharacterWebService::GetClassId(const std::string& className)
{
    static const std::unordered_map<std::string, uint8> classMap = {
        {"WARRIOR", 1},
        {"PALADIN", 2},
        {"HUNTER", 3},
        {"ROGUE", 4},
        {"PRIEST", 5},
        {"DEATH_KNIGHT", 6},
        {"SHAMAN", 7},
        {"MAGE", 8},
        {"WARLOCK", 9},
        {"DRUID", 11}
    };

    auto it = classMap.find(className);
    return it != classMap.end() ? it->second : 0;
}

uint8 CharacterWebService::GetRaceId(const std::string& raceName)
{
    static const std::unordered_map<std::string, uint8> raceMap = {
        {"HUMAN", 1},
        {"ORC", 2},
        {"DWARF", 3},
        {"NIGHTELF", 4},
        {"UNDEAD", 5},
        {"TAUREN", 6},
        {"GNOME", 7},
        {"TROLL", 8},
        {"BLOODELF", 10},
        {"DRAENEI", 11}
    };

    auto it = raceMap.find(raceName);
    return it != raceMap.end() ? it->second : 0;
}

uint8 CharacterWebService::GetEquipmentSlot(const std::string& slotName)
{
    static const std::unordered_map<std::string, uint8> slotMap = {
        {"HEAD", EQUIPMENT_SLOT_HEAD},
        {"NECK", EQUIPMENT_SLOT_NECK},
        {"SHOULDERS", EQUIPMENT_SLOT_SHOULDERS},
        {"CHEST", EQUIPMENT_SLOT_CHEST},
        {"WAIST", EQUIPMENT_SLOT_WAIST},
        {"LEGS", EQUIPMENT_SLOT_LEGS},
        {"FEET", EQUIPMENT_SLOT_FEET},
        {"WRISTS", EQUIPMENT_SLOT_WRISTS},
        {"HANDS", EQUIPMENT_SLOT_HANDS},
        {"FINGER_1", EQUIPMENT_SLOT_FINGER1},
        {"FINGER_2", EQUIPMENT_SLOT_FINGER2},
        {"TRINKET_1", EQUIPMENT_SLOT_TRINKET1},
        {"TRINKET_2", EQUIPMENT_SLOT_TRINKET2},
        {"BACK", EQUIPMENT_SLOT_BACK},
        {"MAIN_HAND", EQUIPMENT_SLOT_MAINHAND},
        {"OFF_HAND", EQUIPMENT_SLOT_OFFHAND},
        {"RANGED", EQUIPMENT_SLOT_RANGED}
    };

    auto it = slotMap.find(slotName);
    return it != slotMap.end() ? it->second : EQUIPMENT_SLOT_END;
}

void CharacterWebService::UpdateEquipmentCache(uint32 characterGuid, CharacterDatabaseTransaction& trans)
{
    // Build equipment cache string for character select screen display
    // Format: ALL 19 equipment slots (item1 enchant1 item2 enchant2 ... for slots 0-18)
    // Based on Player.cpp _SaveCharacter function: for (uint32 i = 0; i < EQUIPMENT_SLOT_END * 2; ++i)
    std::string equipmentCache;
    
    // Process ALL equipment slots (0-18) in sequential order, not just visible ones
    for (uint8 slot = 0; slot < 19; ++slot)  // EQUIPMENT_SLOT_END = 19
    {
        // Query the item in this slot
        QueryResult result = CharacterDatabase.Query(
            "SELECT ii.itemEntry, ii.enchantments "
            "FROM character_inventory ci "
            "JOIN item_instance ii ON ci.item = ii.guid "
            "WHERE ci.guid = {} AND ci.slot = {} AND ci.bag = 0",
            characterGuid, slot);
            
        if (result)
        {
            Field* fields = result->Fetch();
            uint32 itemEntry = fields[0].Get<uint32>();
            std::string enchantments = fields[1].Get<std::string>();
            
            // Extract main enchant from enchantments string (first enchant slot)
            uint32 enchantId = 0;
            if (!enchantments.empty())
            {
                std::istringstream iss(enchantments);
                std::string enchantStr;
                if (std::getline(iss, enchantStr, ' '))
                {
                    try {
                        enchantId = std::stoul(enchantStr);
                    } catch (...) {
                        enchantId = 0;
                    }
                }
            }
            
            equipmentCache += std::to_string(itemEntry) + " " + std::to_string(enchantId) + " ";
        }
        else
        {
            equipmentCache += "0 0 ";
        }
    }
    
    // Remove trailing space
    if (!equipmentCache.empty() && equipmentCache.back() == ' ')
    {
        equipmentCache.pop_back();
    }
    
    // Update the character's equipment cache
    trans->Append("UPDATE characters SET equipmentCache = '{}' WHERE guid = {}", equipmentCache, characterGuid);
    
    LOG_INFO("server.worldserver", "Updated equipment cache for character {}: {}", characterGuid, equipmentCache);
}
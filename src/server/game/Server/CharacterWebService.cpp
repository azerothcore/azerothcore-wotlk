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
#include "WorldConfig.h"
#include "Log.h"
#include "SharedDefines.h"
#include "SpellMgr.h"
#include "DBCStores.h"
#include "DatabaseEnv.h"
#include "ObjectGuid.h"
#include "CharacterCache.h"
#include <boost/beast/version.hpp>
#include <sstream>
#include <thread>
#include <regex>
#include <unordered_map>
#include <random>

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

        // Extract talents array if present
        std::vector<std::string> talentStrings = ExtractJsonArray(body, "talents");
        for (const auto& talentStr : talentStrings)
        {
            TalentData talent;
            talent.name = ExtractJsonString(talentStr, "name");
            talent.id = ExtractJsonNumber(talentStr, "id");
            talent.rank = ExtractJsonNumber(talentStr, "rank");
            talent.spellId = ExtractJsonNumber(talentStr, "spellId");
            request.talents.push_back(talent);
        }

        // Extract glyphs array if present
        std::vector<std::string> glyphStrings = ExtractJsonArray(body, "glyphs");
        for (const auto& glyphStr : glyphStrings)
        {
            GlyphData glyph;
            glyph.name = ExtractJsonString(glyphStr, "name");
            glyph.id = ExtractJsonNumber(glyphStr, "id");
            glyph.type = ExtractJsonString(glyphStr, "type");
            request.glyphs.push_back(glyph);
        }

        bool success = ApplyCharacterGear(request);
        
        // Build response JSON manually
        std::ostringstream oss;
        oss << "{\"success\":" << (success ? "true" : "false") 
            << ",\"character\":\"" << request.character.name << "\""
            << ",\"itemsApplied\":" << (success ? request.items.size() : 0)
            << ",\"talentsApplied\":" << (success ? request.talents.size() : 0)
            << ",\"glyphsApplied\":" << (success ? request.glyphs.size() : 0);
        
        if (success)
            oss << ",\"message\":\"Character configuration, gear, talents and glyphs updated successfully\"";
        else
            oss << ",\"error\":\"Failed to update character configuration, gear, talents and glyphs\"";
            
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

    // Check if character exists and get account info
    uint32 characterGuid = 0;
    QueryResult result = CharacterDatabase.Query("SELECT guid, account FROM characters WHERE name = '{}'", request.character.name);
    
    uint32 accountId = 0;
    bool characterExists = false;
    
    if (result)
    {
        Field* fields = result->Fetch();
        characterGuid = fields[0].Get<uint32>();
        accountId = fields[1].Get<uint32>();
        characterExists = true;
        
        LOG_INFO("server.worldserver", "Found existing character '{}' with GUID {}, will delete and recreate", request.character.name, characterGuid);
    }
    else
    {
        // If character doesn't exist, we need an account ID - for now, use account 1
        // In a real implementation, you'd get this from the request or authentication
        accountId = 1;
        LOG_INFO("server.worldserver", "Character '{}' not found, will create new character", request.character.name);
    }

    bool success = true;
    
    // Delete existing character if it exists (in separate transaction to ensure it completes)
    if (characterExists)
    {
        CharacterDatabaseTransaction deleteTrans = CharacterDatabase.BeginTransaction();
        if (!DeleteCharacterFromDatabase(request.character.name, accountId, deleteTrans))
        {
            LOG_ERROR("server.worldserver", "Failed to delete existing character '{}'", request.character.name);
            return false;
        }
        CharacterDatabase.CommitTransaction(deleteTrans);
        LOG_INFO("server.worldserver", "Successfully deleted existing character '{}'", request.character.name);
    }
    
    // Determine if we should enable customization based on config
    bool enableCustomization = sWorld->getIntConfig(CONFIG_RACE_CUSTOMIZATION) == 1;
    LOG_INFO("server.worldserver", "CONFIG_RACE_CUSTOMIZATION = {}, enableCustomization = {}", 
             sWorld->getIntConfig(CONFIG_RACE_CUSTOMIZATION), enableCustomization ? "true" : "false");
    
    // Create new character in first transaction
    CharacterDatabaseTransaction createTrans = CharacterDatabase.BeginTransaction();
    uint32 newCharacterGuid = 0;
    if (!CreateCharacterInDatabase(request, accountId, createTrans, newCharacterGuid, enableCustomization))
    {
        LOG_ERROR("server.worldserver", "Failed to create character '{}'", request.character.name);
        return false;
    }
    CharacterDatabase.CommitTransaction(createTrans);
    
    characterGuid = newCharacterGuid;
    LOG_INFO("server.worldserver", "Created new character '{}' with GUID {}", request.character.name, characterGuid);
    
    // Update the character cache so deletion/customization works properly
    uint8 classId = GetClassId(request.character.gameClass);
    uint8 raceId = GetRaceId(request.character.race);
    uint8 gender = 0; // Default to male for now (will be set properly if customization is enabled)
    sCharacterCache->AddCharacterCacheEntry(ObjectGuid(HighGuid::Player, characterGuid), accountId, request.character.name, gender, raceId, classId, request.character.level);
    LOG_INFO("server.worldserver", "Added character '{}' to character cache", request.character.name);
    
    // Now apply gear, spells, etc. in a second transaction
    CharacterDatabaseTransaction trans = CharacterDatabase.BeginTransaction();
    
    // Grant all class spells available for the character's level and class
    if (classId > 0 && raceId > 0)
    {
        GrantAllClassSpells(characterGuid, request.character.level, classId, raceId, trans);
    }
    
    // Apply talents if provided
    if (!request.talents.empty())
    {
        ApplyCharacterTalents(characterGuid, request.talents, trans);
    }
    
    // Apply glyphs if provided
    if (!request.glyphs.empty())
    {
        ApplyCharacterGlyphs(characterGuid, request.glyphs, trans);
    }
    
    // Grant necessary proficiencies before applying gear
    GrantRequiredProficiencies(characterGuid, request.items, trans);
    
    // Apply gear changes directly to database
    for (const auto& itemData : request.items)
    {
        if (!ApplyItemToDatabase(characterGuid, itemData, trans))
        {
            LOG_ERROR("server.worldserver", "Failed to apply item '{}' to character '{}'", itemData.name, request.character.name);
            success = false;
        }
    }

    if (success)
    {
        // Update equipment cache so character appears equipped on character select
        UpdateEquipmentCache(characterGuid, request.items, trans);
        
        // Remove all non-equipped items (bags and inventory contents)
        // Keep only equipped items by deleting inventory entries for bag slots (slots 19-22 and their contents)
        for (uint8 slot = 19; slot <= 22; ++slot) // Bag slots
        {
            trans->Append("DELETE FROM character_inventory WHERE guid = {} AND slot = {}", characterGuid, slot);
        }
        
        // Delete any items in bag slots (slots 23-38 for bag 1, 39-54 for bag 2, etc.)
        for (uint8 slot = 23; slot <= 150; ++slot) // All possible bag inventory slots
        {
            trans->Append("DELETE FROM character_inventory WHERE guid = {} AND slot = {}", characterGuid, slot);
        }
        
        // Also delete bank items (slots 39-66 for bank, 67-74 for bank bags)
        trans->Append("DELETE FROM character_inventory WHERE guid = {} AND slot >= 39", characterGuid);
        
        CharacterDatabase.CommitTransaction(trans);
        LOG_INFO("server.worldserver", "Successfully applied configuration and gear to character '{}'", request.character.name);
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
    bool needsEngineering = false;
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
        
        // Check for Engineering items
        // Spellpower Goggles Xtreme and other engineering goggles
        if (itemData.id == 10502 || itemData.id == 10503 || itemData.id == 10504 || // Spellpower Goggles variants
            itemData.id == 10518 || // Parachute Cloak  
            itemData.id == 10501 || itemData.id == 10500 || // Other engineering goggles
            itemData.id == 9491 || // Hotshot Pilot's Gloves
            itemData.id == 10506 || itemData.id == 10507 || itemData.id == 10508) // More goggles
        {
            needsEngineering = true;
        }
        
        // Also check if item has Engineering requirement from template
        if (itemTemplate->RequiredSkill == 202) // Engineering skill ID
        {
            needsEngineering = true;
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
        LOG_INFO("server.worldserver", "Granted Fishing skill to character {}", characterGuid);
    }
    
    if (needsEngineering)
    {
        // Grant engineering skill (202) with max value
        trans->Append("INSERT INTO character_skills (guid, skill, value, max) VALUES ({}, 202, 450, 450) "
                     "ON DUPLICATE KEY UPDATE value = 450, max = 450", characterGuid);
        LOG_INFO("server.worldserver", "Granted Engineering skill to character {}", characterGuid);
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

void CharacterWebService::UpdateEquipmentCache(uint32 characterGuid, const std::vector<ItemData>& items, CharacterDatabaseTransaction& trans)
{
    // Build equipment cache string for character select screen display
    // Format: ALL 19 equipment slots (item1 enchant1 item2 enchant2 ... for slots 0-18)
    // Based on Player.cpp _SaveCharacter function: for (uint32 i = 0; i < EQUIPMENT_SLOT_END * 2; ++i)
    
    // Create a map of slot -> item data for quick lookup
    std::unordered_map<uint8, const ItemData*> slotItemMap;
    for (const auto& item : items)
    {
        uint8 slot = GetEquipmentSlot(item.slot);
        if (slot < 19) // Valid equipment slot
        {
            slotItemMap[slot] = &item;
        }
    }
    
    std::string equipmentCache;
    
    // Process ALL equipment slots (0-18) in sequential order
    for (uint8 slot = 0; slot < 19; ++slot)  // EQUIPMENT_SLOT_END = 19
    {
        auto it = slotItemMap.find(slot);
        if (it != slotItemMap.end())
        {
            // We have an item in this slot
            uint32 itemId = it->second->id;
            uint32 enchantId = it->second->enchant.id;
            
            equipmentCache += std::to_string(itemId) + " " + std::to_string(enchantId) + " ";
        }
        else
        {
            // Empty slot
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

void CharacterWebService::GrantAllClassSpells(uint32 characterGuid, uint8 level, uint8 classId, uint8 raceId, CharacterDatabaseTransaction& trans)
{
    // TODO: This spell granting logic needs further manual review
    // Currently grants some skills/spells that shouldn't be automatically given
    // May need to filter out more passive abilities, profession spells, or other special cases
    
    // First, clear existing spells to avoid duplicates
    trans->Append("DELETE FROM character_spell WHERE guid = {}", characterGuid);
    
    uint32 spellsGranted = 0;
    uint32 raceMask = 1 << (raceId - 1);
    uint32 classMask = 1 << (classId - 1);
    
    // Define the main talent tree skill lines for each class
    // For Druid: Balance (574), Feral Combat (134), Restoration (573)
    std::vector<uint32> mainSkillLines;
    
    switch (classId)
    {
        case 11: // DRUID
            mainSkillLines = {574, 134, 573}; // Balance, Feral Combat, Restoration
            break;
        case 1: // WARRIOR  
            mainSkillLines = {26, 256, 257}; // Arms, Fury, Protection
            break;
        case 2: // PALADIN
            mainSkillLines = {594, 267, 184}; // Holy, Protection, Retribution
            break;
        case 3: // HUNTER
            mainSkillLines = {50, 51, 163}; // Beast Mastery, Marksmanship, Survival
            break;
        case 4: // ROGUE
            mainSkillLines = {253, 38, 39}; // Assassination, Combat, Subtlety
            break;
        case 5: // PRIEST
            mainSkillLines = {56, 78, 613}; // Discipline, Holy, Shadow
            break;
        case 6: // DEATH_KNIGHT
            mainSkillLines = {770, 771, 772}; // Blood, Frost, Unholy
            break;
        case 7: // SHAMAN
            mainSkillLines = {261, 263, 262}; // Elemental, Enhancement, Restoration
            break;
        case 8: // MAGE
            mainSkillLines = {237, 6, 8}; // Arcane, Fire, Frost
            break;
        case 9: // WARLOCK
            mainSkillLines = {355, 354, 593}; // Affliction, Demonology, Destruction
            break;
        default:
            LOG_ERROR("server.worldserver", "Unsupported class {} for spell granting", classId);
            return;
    }
    
    // Iterate through all SkillLineAbility entries to find spells from main talent trees only
    for (uint32 i = 0; i < sSkillLineAbilityStore.GetNumRows(); ++i)
    {
        SkillLineAbilityEntry const* skillEntry = sSkillLineAbilityStore.LookupEntry(i);
        if (!skillEntry)
            continue;
            
        // Only process spells from the main talent tree skill lines
        bool isMainSkillLine = false;
        for (uint32 skillLine : mainSkillLines)
        {
            if (skillEntry->SkillLine == skillLine)
            {
                isMainSkillLine = true;
                break;
            }
        }
        
        if (!isMainSkillLine)
            continue;
            
        SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(skillEntry->Spell);
        if (!spellInfo)
            continue;
            
        // Skip server-side/triggered spells (they have no spell level)
        if (spellInfo->SpellLevel == 0 && spellInfo->BaseLevel == 0)
            continue;
            
        // Only learn spells up to character level
        uint32 spellLevel = std::max(spellInfo->BaseLevel, spellInfo->SpellLevel);
        if (spellLevel > level)
            continue;
            
        // Check if spell fits this race/class combination
        if (skillEntry->RaceMask != 0 && !(skillEntry->RaceMask & raceMask))
            continue;
            
        if (skillEntry->ClassMask != 0 && !(skillEntry->ClassMask & classMask))
            continue;
            
        // Skip broken or invalid spells
        if (!SpellMgr::IsSpellValid(spellInfo))
            continue;
            
        // Skip talents (these should be learned separately)
        if (GetTalentSpellCost(skillEntry->Spell) > 0)
            continue;
            
        // Skip passive spells that are learned automatically
        if (spellInfo->IsPassive() && spellInfo->HasAura(SPELL_AURA_MOD_SKILL))
            continue;
            
        // Add spell to character_spell table
        trans->Append("INSERT INTO character_spell (guid, spell, specMask) VALUES ({}, {}, 255) ON DUPLICATE KEY UPDATE specMask = 255",
                     characterGuid, skillEntry->Spell);
        
        spellsGranted++;
    }
    
    // Get class and race names for logging
    const char* className = "Unknown";
    switch (classId) {
        case 1: className = "Warrior"; break;
        case 2: className = "Paladin"; break;
        case 3: className = "Hunter"; break;
        case 4: className = "Rogue"; break;
        case 5: className = "Priest"; break;
        case 6: className = "Death Knight"; break;
        case 7: className = "Shaman"; break;
        case 8: className = "Mage"; break;
        case 9: className = "Warlock"; break;
        case 11: className = "Druid"; break;
    }
    
    const char* raceName = "Unknown";
    switch (raceId) {
        case 1: raceName = "Human"; break;
        case 2: raceName = "Orc"; break;
        case 3: raceName = "Dwarf"; break;
        case 4: raceName = "Night Elf"; break;
        case 5: raceName = "Undead"; break;
        case 6: raceName = "Tauren"; break;
        case 7: raceName = "Gnome"; break;
        case 8: raceName = "Troll"; break;
        case 10: raceName = "Blood Elf"; break;
        case 11: raceName = "Draenei"; break;
    }
    
    LOG_INFO("server.worldserver", "Granted {} main talent tree spells to character {} (level {} {} {})", 
             spellsGranted, characterGuid, level, className, raceName);
}

void CharacterWebService::ApplyCharacterTalents(uint32 characterGuid, const std::vector<TalentData>& talents, CharacterDatabaseTransaction& trans)
{
    // First, clear existing talents
    trans->Append("DELETE FROM character_talent WHERE guid = {}", characterGuid);
    
    // Apply each talent
    for (const auto& talent : talents)
    {
        // Add the talent entry
        // specMask 255 means active for all specs
        trans->Append("INSERT INTO character_talent (guid, spell, specMask) VALUES ({}, {}, 255)", 
                     characterGuid, talent.spellId);
        
        // Also add the spell to character_spell if it's not already there
        trans->Append("INSERT INTO character_spell (guid, spell, specMask) VALUES ({}, {}, 255) "
                     "ON DUPLICATE KEY UPDATE specMask = 255", 
                     characterGuid, talent.spellId);
        
        LOG_DEBUG("server.worldserver", "Applied talent '{}' (spell {}) rank {} to character {}", 
                  talent.name, talent.spellId, talent.rank, characterGuid);
    }
    
    LOG_INFO("server.worldserver", "Applied {} talents to character {}", 
             talents.size(), characterGuid);
}

uint32 CharacterWebService::GetGlyphSpellId(uint32 itemId)
{
    // Query the item_template table to get the spell that the item casts
    // For glyphs, this spell will have SPELL_EFFECT_APPLY_GLYPH effect
    QueryResult result = WorldDatabase.Query(
        "SELECT class, spellid_1, spellid_2, spellid_3, spellid_4, spellid_5, spelltrigger_1, spelltrigger_2 FROM item_template WHERE entry = {}",
        itemId
    );
    
    if (!result)
    {
        LOG_WARN("server.worldserver", "Item {} not found in item_template", itemId);
        return 0;
    }
    
    Field* fields = result->Fetch();
    uint32 itemClass = fields[0].Get<uint32>();
    
    // Check if it's a glyph (class 16)
    if (itemClass != 16)
    {
        LOG_WARN("server.worldserver", "Item {} is not a glyph (class {}), expected class 16", itemId, itemClass);
        return 0;
    }
    
    // Find the spell with ITEM_SPELLTRIGGER_ON_USE (trigger = 0)
    uint32 useSpellId = 0;
    for (int i = 0; i < 5; ++i)
    {
        uint32 spellId = fields[1 + i].Get<uint32>();
        if (spellId > 0)
        {
            // Check spell trigger if it's one of the first two spells
            if (i < 2)
            {
                uint32 trigger = fields[6 + i].Get<uint32>();
                if (trigger == 0) // ITEM_SPELLTRIGGER_ON_USE
                {
                    useSpellId = spellId;
                    LOG_DEBUG("server.worldserver", "Found use spell {} in spellid_{} for glyph item {}", spellId, i + 1, itemId);
                    break;
                }
            }
            else if (useSpellId == 0)
            {
                // Fallback to any spell if no ON_USE trigger found
                useSpellId = spellId;
                LOG_DEBUG("server.worldserver", "Using spell {} from spellid_{} for glyph item {}", spellId, i + 1, itemId);
            }
        }
    }
    
    if (useSpellId == 0)
    {
        LOG_WARN("server.worldserver", "Glyph item {} has no spells", itemId);
        return 0;
    }
    
    // Now get the spell info to find the MiscValue which contains the glyph ID
    SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(useSpellId);
    if (!spellInfo)
    {
        LOG_WARN("server.worldserver", "Spell {} not found for glyph item {}", useSpellId, itemId);
        return 0;
    }
    
    // Find the SPELL_EFFECT_APPLY_GLYPH effect
    for (uint8 i = 0; i < MAX_SPELL_EFFECTS; ++i)
    {
        if (spellInfo->Effects[i].Effect == SPELL_EFFECT_APPLY_GLYPH)
        {
            uint32 glyphId = spellInfo->Effects[i].MiscValue;
            
            // Look up the glyph properties to get the actual glyph spell
            if (GlyphPropertiesEntry const* gp = sGlyphPropertiesStore.LookupEntry(glyphId))
            {
                LOG_DEBUG("server.worldserver", "Found glyph spell {} for item {} (glyph id {})", 
                          gp->SpellId, itemId, glyphId);
                return gp->SpellId;
            }
            else
            {
                LOG_WARN("server.worldserver", "Glyph properties not found for glyph id {} (item {})", 
                         glyphId, itemId);
                return 0;
            }
        }
    }
    
    LOG_WARN("server.worldserver", "No SPELL_EFFECT_APPLY_GLYPH found in spell {} for item {}", useSpellId, itemId);
    return 0;
}

void CharacterWebService::ApplyCharacterGlyphs(uint32 characterGuid, const std::vector<GlyphData>& glyphs, CharacterDatabaseTransaction& trans)
{
    // First, clear existing glyphs
    trans->Append("DELETE FROM character_glyphs WHERE guid = {}", characterGuid);
    
    // In WotLK, glyph slots are indexed 0-5 with specific types:
    // Slots 0, 2, 4: Major glyphs (even indexes)
    // Slots 1, 3, 5: Minor glyphs (odd indexes)
    // They unlock in order: 0 (lvl 15), 1 (lvl 15), 2 (lvl 30), 3 (lvl 50), 4 (lvl 70), 5 (lvl 80)
    
    uint32 glyphEntryIds[6] = {0, 0, 0, 0, 0, 0}; // The glyph IDs for character_glyphs table
    uint8 majorCount = 0;
    uint8 minorCount = 0;
    
    for (const auto& glyph : glyphs)
    {
        // Get both glyph entry ID and spell ID
        uint32 glyphEntryId = 0;
        uint32 glyphSpellId = 0;
        
        // Query the item to get the use spell
        QueryResult itemResult = WorldDatabase.Query(
            "SELECT class, spellid_1, spellid_2, spellid_3, spellid_4, spellid_5, spelltrigger_1, spelltrigger_2 FROM item_template WHERE entry = {}",
            glyph.id
        );
        
        if (!itemResult)
        {
            LOG_ERROR("server.worldserver", "Glyph item {} not found, skipping", glyph.id);
            continue;
        }
        
        Field* fields = itemResult->Fetch();
        uint32 itemClass = fields[0].Get<uint32>();
        
        if (itemClass != 16) // Not a glyph
        {
            LOG_ERROR("server.worldserver", "Item {} is not a glyph (class {}), skipping", glyph.id, itemClass);
            continue;
        }
        
        // Find the use spell
        uint32 useSpellId = 0;
        for (int i = 0; i < 5; ++i)
        {
            uint32 spellId = fields[1 + i].Get<uint32>();
            if (spellId > 0)
            {
                if (i < 2)
                {
                    uint32 trigger = fields[6 + i].Get<uint32>();
                    if (trigger == 0) // ITEM_SPELLTRIGGER_ON_USE
                    {
                        useSpellId = spellId;
                        break;
                    }
                }
                else if (useSpellId == 0)
                {
                    useSpellId = spellId;
                }
            }
        }
        
        if (useSpellId == 0)
        {
            LOG_ERROR("server.worldserver", "No use spell found for glyph item {}, skipping", glyph.id);
            continue;
        }
        
        // Get the spell info to find the glyph entry ID
        SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(useSpellId);
        if (!spellInfo)
        {
            LOG_ERROR("server.worldserver", "Spell {} not found for glyph item {}, skipping", useSpellId, glyph.id);
            continue;
        }
        
        // Find SPELL_EFFECT_APPLY_GLYPH effect to get the glyph entry ID
        for (uint8 i = 0; i < MAX_SPELL_EFFECTS; ++i)
        {
            if (spellInfo->Effects[i].Effect == SPELL_EFFECT_APPLY_GLYPH)
            {
                glyphEntryId = spellInfo->Effects[i].MiscValue;
                
                // Look up the glyph properties to get the glyph spell
                if (GlyphPropertiesEntry const* gp = sGlyphPropertiesStore.LookupEntry(glyphEntryId))
                {
                    glyphSpellId = gp->SpellId;
                    break;
                }
            }
        }
        
        if (glyphEntryId == 0 || glyphSpellId == 0)
        {
            LOG_ERROR("server.worldserver", "Could not find glyph data for item {}, skipping", glyph.id);
            continue;
        }
        
        // Add the glyph spell to the character's spell list
        trans->Append("INSERT INTO character_spell (guid, spell, specMask) VALUES ({}, {}, 255) "
                     "ON DUPLICATE KEY UPDATE specMask = 255", 
                     characterGuid, glyphSpellId);
        
        // Get the actual glyph type from GlyphProperties
        GlyphPropertiesEntry const* glyphProps = sGlyphPropertiesStore.LookupEntry(glyphEntryId);
        if (!glyphProps)
        {
            LOG_ERROR("server.worldserver", "Could not find GlyphProperties for glyph {}, skipping", glyphEntryId);
            continue;
        }
        
        // TypeFlags: 0 = Major, 1 = Minor
        bool isMajor = (glyphProps->TypeFlags == 0);
        
        if (isMajor)
        {
            // Major glyphs go in even slots: 0, 2, 4
            if (majorCount < 3)
            {
                uint8 slotIndex = majorCount * 2; // 0, 2, 4
                glyphEntryIds[slotIndex] = glyphEntryId;
                LOG_DEBUG("server.worldserver", "Applied MAJOR glyph '{}' (item {} -> glyph {} -> spell {}) to slot {}", 
                          glyph.name, glyph.id, glyphEntryId, glyphSpellId, slotIndex);
                majorCount++;
            }
            else
            {
                LOG_ERROR("server.worldserver", "Too many major glyphs for character {}, skipping glyph '{}'", 
                         characterGuid, glyph.name);
            }
        }
        else  // Minor glyph
        {
            // Minor glyphs go in odd slots: 1, 3, 5
            if (minorCount < 3)
            {
                uint8 slotIndex = (minorCount * 2) + 1; // 1, 3, 5
                glyphEntryIds[slotIndex] = glyphEntryId;
                LOG_DEBUG("server.worldserver", "Applied MINOR glyph '{}' (item {} -> glyph {} -> spell {}) to slot {}", 
                          glyph.name, glyph.id, glyphEntryId, glyphSpellId, slotIndex);
                minorCount++;
            }
            else
            {
                LOG_ERROR("server.worldserver", "Too many minor glyphs for character {}, skipping glyph '{}'", 
                         characterGuid, glyph.name);
            }
        }
    }
    
    // Insert all glyphs in a single row
    // talentGroup 0 is the primary spec
    trans->Append("INSERT INTO character_glyphs (guid, talentGroup, glyph1, glyph2, glyph3, glyph4, glyph5, glyph6) "
                 "VALUES ({}, 0, {}, {}, {}, {}, {}, {})", 
                 characterGuid, glyphEntryIds[0], glyphEntryIds[1], glyphEntryIds[2], glyphEntryIds[3], glyphEntryIds[4], glyphEntryIds[5]);
    
    LOG_INFO("server.worldserver", "Applied {} glyphs ({} major, {} minor) to character {}", 
             glyphs.size(), majorCount, minorCount, characterGuid);
}

bool CharacterWebService::DeleteCharacterFromDatabase(const std::string& characterName, uint32 accountId, CharacterDatabaseTransaction& trans)
{
    // Get character GUID first
    QueryResult result = CharacterDatabase.Query("SELECT guid FROM characters WHERE name = '{}'", characterName);
    if (!result)
    {
        LOG_ERROR("server.worldserver", "Character '{}' not found for deletion", characterName);
        return false;
    }
    
    uint32 characterGuid = result->Fetch()[0].Get<uint32>();
    
    // Delete ALL character-related data comprehensively
    // Order matters - delete child records before parent records
    
    // Delete ALL items owned by the character (both equipped and in bags)
    trans->Append("DELETE FROM item_instance WHERE owner_guid = {}", characterGuid);
    
    // Delete all character inventory entries (this includes equipped items and bag contents)
    trans->Append("DELETE FROM character_inventory WHERE guid = {}", characterGuid);
    
    // Delete character spells
    trans->Append("DELETE FROM character_spell WHERE guid = {}", characterGuid);
    
    // Delete character skills  
    trans->Append("DELETE FROM character_skills WHERE guid = {}", characterGuid);
    
    // Delete character homebind
    trans->Append("DELETE FROM character_homebind WHERE guid = {}", characterGuid);
    
    // Delete character stats
    trans->Append("DELETE FROM character_stats WHERE guid = {}", characterGuid);
    
    // Delete character_account_data if it exists (might not exist for never-logged-in characters)
    trans->Append("DELETE FROM character_account_data WHERE guid = {}", characterGuid);
    
    // Delete other character tables that might exist
    trans->Append("DELETE FROM character_action WHERE guid = {}", characterGuid);
    trans->Append("DELETE FROM character_aura WHERE guid = {}", characterGuid);
    trans->Append("DELETE FROM character_glyphs WHERE guid = {}", characterGuid);
    trans->Append("DELETE FROM character_queststatus WHERE guid = {}", characterGuid);
    trans->Append("DELETE FROM character_queststatus_rewarded WHERE guid = {}", characterGuid);
    trans->Append("DELETE FROM character_reputation WHERE guid = {}", characterGuid);
    trans->Append("DELETE FROM character_talent WHERE guid = {}", characterGuid);
    trans->Append("DELETE FROM character_achievement WHERE guid = {}", characterGuid);
    trans->Append("DELETE FROM character_achievement_progress WHERE guid = {}", characterGuid);
    trans->Append("DELETE FROM character_equipmentsets WHERE guid = {}", characterGuid);
    trans->Append("DELETE FROM character_pet WHERE owner = {}", characterGuid);
    trans->Append("DELETE FROM mail WHERE receiver = {}", characterGuid);
    trans->Append("DELETE FROM character_social WHERE guid = {} OR friend = {}", characterGuid, characterGuid);
    trans->Append("DELETE FROM guild_member WHERE guid = {}", characterGuid);
    
    // Delete the main character record last
    trans->Append("DELETE FROM characters WHERE guid = {}", characterGuid);
    
    LOG_INFO("server.worldserver", "Queued deletion of character '{}' (GUID {}) from all tables", characterName, characterGuid);
    return true;
}

bool CharacterWebService::CreateCharacterInDatabase(const CharacterRequest& request, uint32 accountId, CharacterDatabaseTransaction& trans, uint32& outGuid, bool enableCustomization)
{
    uint8 classId = GetClassId(request.character.gameClass);
    uint8 raceId = GetRaceId(request.character.race);
    
    if (classId == 0 || raceId == 0)
    {
        LOG_ERROR("server.worldserver", "Invalid class '{}' or race '{}' for character creation", 
                 request.character.gameClass, request.character.race);
        return false;
    }
    
    // Generate new character GUID using a simple approach
    // Find the highest existing character GUID across all relevant tables and add 1
    QueryResult maxGuidResult = CharacterDatabase.Query(
        "SELECT MAX(max_guid) FROM ("
        "  SELECT COALESCE(MAX(guid), 0) as max_guid FROM characters "
        "  UNION ALL "
        "  SELECT COALESCE(MAX(guid), 0) as max_guid FROM character_stats "
        "  UNION ALL "
        "  SELECT COALESCE(MAX(guid), 0) as max_guid FROM character_homebind"
        ") as all_guids"
    );
    
    uint32 newGuid = 1;
    if (maxGuidResult)
    {
        Field* fields = maxGuidResult->Fetch();
        if (!fields[0].IsNull())
        {
            newGuid = fields[0].Get<uint32>() + 1;
        }
    }
    
    // Return the generated GUID so caller can use it
    outGuid = newGuid;
    
    // Determine faction based on race
    uint8 teamId = 0; // Alliance
    if (raceId == 2 || raceId == 5 || raceId == 6 || raceId == 8 || raceId == 10) // Orc, Undead, Tauren, Troll, Blood Elf
    {
        teamId = 1; // Horde
    }
    
    // Determine gender and login flags based on config
    uint8 gender = 0;  // Default to male
    uint32 atLoginFlags = 0;
    
    if (enableCustomization)
    {
        // Flag character for customization on first login
        atLoginFlags |= AT_LOGIN_CUSTOMIZE;
        LOG_INFO("server.worldserver", "Flagging character '{}' for customization on first login", request.character.name);
    }
    else
    {
        // Randomize gender when customization is disabled
        std::random_device rd;
        std::mt19937 gen(rd());
        std::uniform_int_distribution<> dis(0, 1);
        gender = dis(gen);
        LOG_INFO("server.worldserver", "Setting random gender {} for character '{}'", 
                 gender == 0 ? "male" : "female", request.character.name);
    }
    
    // Create the main character record with all required fields (including those without defaults)
    trans->Append(
        "INSERT INTO characters "
        "(guid, account, name, race, class, gender, level, xp, money, "
        "position_x, position_y, position_z, map, orientation, taximask, cinematic, "
        "zone, online, health, power1, equipmentCache, exploredZones, knownTitles, actionBars, innTriggerId, at_login) "
        "VALUES "
        "({}, {}, '{}', {}, {}, {}, {}, 0, 0, "
        "-8949.95, -132.493, 83.5312, 0, 0, '', 1, "
        "12, 0, 100, 100, '', '', '', 0, 0, {})",
        newGuid, accountId, request.character.name, raceId, classId, gender, request.character.level, atLoginFlags
    );
    
    // Create character_homebind entry
    trans->Append(
        "INSERT INTO character_homebind (guid, mapId, zoneId, posX, posY, posZ) "
        "VALUES ({}, 0, 12, -8949.95, -132.493, 83.5312)",
        newGuid
    );
    
    // Create character_stats entry (use INSERT IGNORE in case it exists from a failed previous attempt)
    trans->Append(
        "INSERT IGNORE INTO character_stats (guid, maxhealth, maxpower1, maxpower2, maxpower3, maxpower4, maxpower5, maxpower6, maxpower7, "
        "strength, agility, stamina, intellect, spirit, armor, resHoly, resFire, resNature, resFrost, resShadow, resArcane, "
        "blockPct, dodgePct, parryPct, critPct, rangedCritPct, spellCritPct, attackPower, rangedAttackPower, spellPower, "
        "resilience) VALUES "
        "({}, 100, 100, 0, 0, 0, 0, 0, 0, 10, 10, 10, 10, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)",
        newGuid
    );
    
    // Note: character_account_data is account-wide, not character-specific
    // So we don't need to create entries for it here
    
    LOG_INFO("server.worldserver", "Created character '{}' with GUID {}, class {}, race {}, level {}", 
             request.character.name, newGuid, classId, raceId, request.character.level);
    
    return true;
}
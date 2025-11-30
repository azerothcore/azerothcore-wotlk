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

/**
 * @file ServerMailMgr.h
 * @brief Manages the ServerMail operations, including template loading, condition checking, and mail delivery.
 *
 * This class handles the loading of server mail templates, associated items, and conditions from the database.
 * It also provides functionality to check player eligibility for receiving server mails based on configured conditions.
 *
 * Key features:
 * - Supports multi-item mails via `mail_server_template_items`
 * - Supports flexible mail conditions (level, playtime, quest, achievement) via `mail_server_template_conditions`
 * - Ensures all related data is loaded and validated on startup
 */

#ifndef _SERVERMAILMGR_H
#define _SERVERMAILMGR_H

#include "Define.h"
#include <string>
#include <unordered_map>
#include <vector>

class Player;

/**
 * @enum ServerMailConditionType
 * @brief Represents the type of conditions that can be applied to server mail.
 */
enum class ServerMailConditionType : uint8
{
    Invalid     = 0, ///< Internal use, not used in DB.
    Level       = 1, ///< Requires the player to be at least a specific level.
    PlayTime    = 2, ///< Requires the player to have played for a minimum amount of time (in milliseconds).
    Quest       = 3, ///< Requires the player to have completed a specific quest.
    Achievement = 4, ///< Requires the player to have earned a specific achievement.
    Reputation  = 5, ///< Requires the player to have earned reputation with a specific faction.
    Faction     = 6, ///< Requires the player to be a part of a specific faction. Horde/Alliance.
    Race        = 7, ///< Requires the player to be a specific race.
    Class       = 8, ///< Requires the player to be a specific class.
    AccountFlags = 9, ///< Requires the player to have a specific AccountFlag (bit)
};

/**
* @brief Assign string condition to corresponding @ref ServerMailConditionType enum value
*/
constexpr std::pair<std::string_view, ServerMailConditionType> ServerMailConditionTypePairs[] =
{
    { "Level",       ServerMailConditionType::Level       },
    { "PlayTime",    ServerMailConditionType::PlayTime    },
    { "Quest",       ServerMailConditionType::Quest       },
    { "Achievement", ServerMailConditionType::Achievement },
    { "Reputation",  ServerMailConditionType::Reputation  },
    { "Faction",     ServerMailConditionType::Faction     },
    { "Race",        ServerMailConditionType::Race        },
    { "Class",       ServerMailConditionType::Class       },
    { "AccountFlags", ServerMailConditionType::AccountFlags }
};

/**
 * @struct ServerMailCondition
 * @brief Represents a condition that must be met for a player to receive a server mail.
 *
 * Each condition has a type (see @ref ServerMailConditionType) and a value associated with the type.
 * For example, for a level condition, the value represents the required player level.
 *
 * Some condition also have a state associated with the value.
 * For example, for a reputation condition, the state represents the current reputation state, like Exalted.
 *
 * Conditions are attached to server mail templates and are evaluated when players log in.
 */
struct ServerMailCondition
{
    ServerMailCondition() = default;

    ServerMailConditionType type = ServerMailConditionType::Invalid;
    uint32 value{ 0 };
    uint32 state{ 0 };

    /**
     * @brief Checks if a player meets this condition.
     *
     * Evaluates the condition type and compares the player's attributes to the required value.
     *
     * @param player The player to check.
     * @return True if the player meets the condition, otherwise false.
     */
    bool CheckCondition(Player* player) const;
};

/**
 * @struct ServerMailItems
 * @brief Represents an item reward associated with a server mail template.
 *
 * Server mail templates can have multiple item rewards, stored separately for each faction.
 * This struct tracks the item ID and item count.
 */
struct ServerMailItems
{
    ServerMailItems() = default;
    uint32 item{ 0 };
    uint32 itemCount{ 0 };
};

/**
 * @struct ServerMail
 * @brief Represents a server mail template, including rewards, conditions, and metadata.
 *
 * This structure defines a mail template that can be sent to players upon login,
 * provided they meet the associated conditions.
 */
struct ServerMail
{
    ServerMail() = default;
    uint32 id{ 0 };
    uint32 moneyA{ 0 };
    uint32 moneyH{ 0 };
    std::string subject;
    std::string body;
    uint8 active{ 0 };

    // Conditions from mail_server_template_conditions
    std::vector<ServerMailCondition> conditions;

    // Items from mail_server_template_items
    std::vector<ServerMailItems> itemsA;
    std::vector<ServerMailItems> itemsH;
};

typedef std::unordered_map<uint32, ServerMail> ServerMailContainer;

class ServerMailMgr
{
private:
    ServerMailMgr() = default;
    ~ServerMailMgr() = default;
public:
    static ServerMailMgr* instance();

    /**
     * @brief Loads all server mail templates from the database into memory.
     *
     * Queries the `mail_server_template` table and loads all rows into memory.
     * This method is intended to be called during server startup.
     */
    void LoadMailServerTemplates();

    /**
     * @brief Loads all items associated with server mail templates.
     *
     * Queries the `mail_server_template_items` table and loads all items into memory,
     * linking them to their corresponding templates by template ID.
     * This method is intended to be called during server startup.
     */
    void LoadMailServerTemplatesItems();

    /**
     * @brief Loads all conditions associated with server mail templates.
     *
     * Queries the `mail_server_template_conditions` table and loads all conditions into memory,
     * linking them to their corresponding templates by template ID.
     * This method is intended to be called during server startup.
     */
    void LoadMailServerTemplatesConditions();

    /**
    * @brief Convert DB value of conditionType to ServerMailConditionType.
    *
    * Lookup the corresponding SeverMailConditionType enum for the provided
    * string by DB. If the string is not found we return internal default value
    * ServerMailConditionType::Invalid
    *
    * @param conditionTypeStr string value from DB of conditionType
    * @return ServerMailConditionType The corresponding value (see @ref ServerMailConditionType) or default to ServerMailConditionType::Invalid
    */
    ServerMailConditionType GetServerMailConditionType(std::string_view conditionTypeStr) const;

    /**
    * @brief Check if ConditionType should use ConditionState
    *
    * @return True if the ConditionType is allowed to use ConditionState, otherwise False.
    */
    bool ConditionTypeUsesConditionState(ServerMailConditionType type) const;

    /**
     * @brief Sends a server mail to a player if the template is active and the player is eligible.
     *
     * This method handles the creation of the mail, adding money and items, and saving the mail to the database.
     * It also records that the player received the mail to prevent duplicate delivery.
     *
     * @param player The recipient player.
     * @param id The template ID.
     * @param money Money reward.
     * @param items List of items to include in the mail.
     * @param conditions List of the conditions for the mail.
     * @param subject Mail subject.
     * @param body Mail body.
     * @param active Whether the mail template is active.
     */
    void SendServerMail(Player* player, uint32 id, uint32 money, std::vector<ServerMailItems> const& items, std::vector<ServerMailCondition> const& conditions, std::string const& subject, std::string const& body) const;

    /**
     * @brief Retrieves the entire server mail store.
     *
     * This function returns a constant reference to the internal
     * `_serverMailStore` container, which holds all server mail data.
     *
     * @return A constant reference to the `ServerMailContainer` containing all stored server mail.
     */
    [[nodiscard]] ServerMailContainer const& GetAllServerMailStore() const { return _serverMailStore; }

private:
    ServerMailContainer _serverMailStore;
};

#define sServerMailMgr ServerMailMgr::instance()

#endif // _SERVERMAILMGR_H

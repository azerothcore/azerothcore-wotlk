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

#ifndef AZEROTHCORE_CHAT_H
#define AZEROTHCORE_CHAT_H

#include "SharedDefines.h"
#include "Errors.h"
#include "WorldSession.h"
#include <vector>

class ChatHandler;
class Creature;
class Group;
class Player;
class Unit;
class WorldSession;
class WorldObject;

struct GameTele;

class ChatCommand
{
    typedef bool(*pHandler)(ChatHandler*, char const*);

public:
    ChatCommand(char const* name, uint32 securityLevel, bool allowConsole, pHandler handler, std::string help, std::vector<ChatCommand> childCommands = std::vector<ChatCommand>())
        : Name(ASSERT_NOTNULL(name)), SecurityLevel(securityLevel), AllowConsole(allowConsole), Handler(handler), Help(std::move(help)), ChildCommands(std::move(childCommands)) { }

    char const* Name;
    uint32 SecurityLevel;
    bool AllowConsole;
    pHandler Handler;
    std::string Help;
    std::vector<ChatCommand> ChildCommands;
};

class ChatHandler
{
public:
    WorldSession* GetSession() { return m_session; }
    explicit ChatHandler(WorldSession* session) : m_session(session), sentErrorMessage(false) {}
    virtual ~ChatHandler() { }

    // Builds chat packet and returns receiver guid position in the packet to substitute in whisper builders
    static size_t BuildChatPacket(WorldPacket& data, ChatMsg chatType, Language language, ObjectGuid senderGUID, ObjectGuid receiverGUID, std::string_view message, uint8 chatTag,
                                  std::string const& senderName = "", std::string const& receiverName = "",
                                  uint32 achievementId = 0, bool gmMessage = false, std::string const& channelName = "");

    // Builds chat packet and returns receiver guid position in the packet to substitute in whisper builders
    static size_t BuildChatPacket(WorldPacket& data, ChatMsg chatType, Language language, WorldObject const* sender, WorldObject const* receiver, std::string_view message, uint32 achievementId = 0, std::string const& channelName = "", LocaleConstant locale = DEFAULT_LOCALE);

    static char* LineFromMessage(char*& pos) { char* start = strtok(pos, "\n"); pos = nullptr; return start; }

    // function with different implementation for chat/console
    virtual char const* GetAcoreString(uint32 entry) const;
    virtual void SendSysMessage(char const* str);

    void SendSysMessage(uint32 entry);
    void PSendSysMessage(char const* format, ...) ATTR_PRINTF(2, 3);
    void PSendSysMessage(uint32 entry, ...);
    std::string PGetParseString(uint32 entry, ...) const;

    bool ParseCommands(const char* text);

    static std::vector<ChatCommand> const& getCommandTable();

    bool isValidChatMessage(const char* msg);
    void SendGlobalSysMessage(const char* str);

    bool hasStringAbbr(const char* name, const char* part);

    // function with different implementation for chat/console
    virtual bool isAvailable(ChatCommand const& cmd) const;
    virtual std::string GetNameLink() const { return GetNameLink(m_session->GetPlayer()); }
    virtual bool needReportToTarget(Player* chr) const;
    virtual LocaleConstant GetSessionDbcLocale() const;
    virtual int GetSessionDbLocaleIndex() const;

    bool HasLowerSecurity(Player* target, ObjectGuid guid = ObjectGuid::Empty, bool strong = false);
    bool HasLowerSecurityAccount(WorldSession* target, uint32 account, bool strong = false);

    void SendGlobalGMSysMessage(const char* str);
    Player*   getSelectedPlayer();
    Creature* getSelectedCreature();
    Unit*     getSelectedUnit();
    WorldObject* getSelectedObject();
    // Returns either the selected player or self if there is no selected player
    Player*   getSelectedPlayerOrSelf();

    char*     extractKeyFromLink(char* text, char const* linkType, char** something1 = nullptr);
    char*     extractKeyFromLink(char* text, char const* const* linkTypes, int* found_idx, char** something1 = nullptr);

    // if args have single value then it return in arg2 and arg1 == nullptr
    void      extractOptFirstArg(char* args, char** arg1, char** arg2);
    char*     extractQuotedArg(char* args);

    uint32    extractSpellIdFromLink(char* text);
    ObjectGuid::LowType extractLowGuidFromLink(char* text, HighGuid& guidHigh);
    GameTele const* extractGameTeleFromLink(char* text);
    bool GetPlayerGroupAndGUIDByName(const char* cname, Player*& player, Group*& group, ObjectGuid& guid, bool offline = false);
    std::string extractPlayerNameFromLink(char* text);
    // select by arg (name/link) or in-game selection online/offline player
    bool extractPlayerTarget(char* args, Player** player, ObjectGuid* player_guid = nullptr, std::string* player_name = nullptr);

    std::string playerLink(std::string const& name) const { return m_session ? "|cffffffff|Hplayer:" + name + "|h[" + name + "]|h|r" : name; }
    std::string GetNameLink(Player* chr) const;

    GameObject* GetNearbyGameObject();
    GameObject* GetObjectFromPlayerMapByDbGuid(ObjectGuid::LowType lowguid);
    Creature* GetCreatureFromPlayerMapByDbGuid(ObjectGuid::LowType lowguid);
    bool HasSentErrorMessage() const { return sentErrorMessage; }
    void SetSentErrorMessage(bool val) { sentErrorMessage = val; }
    static bool LoadCommandTable() { return load_command_table; }
    static void SetLoadCommandTable(bool val) { load_command_table = val; }

    bool ShowHelpForCommand(std::vector<ChatCommand> const& table, const char* cmd);
protected:
    explicit ChatHandler() : m_session(nullptr), sentErrorMessage(false) {}      // for CLI subclass
    static bool SetDataForCommandInTable(std::vector<ChatCommand>& table, const char* text, uint32 securityLevel, std::string const& help, std::string const& fullcommand);
    bool ExecuteCommandInTable(std::vector<ChatCommand> const& table, const char* text, std::string const& fullcmd);
    bool ShowHelpForSubCommands(std::vector<ChatCommand> const& table, char const* cmd, char const* subcmd);

private:
    WorldSession* m_session;                           // != nullptr for chat command call and nullptr for CLI command

    // common global flag
    static bool load_command_table;
    bool sentErrorMessage;
};

class CliHandler : public ChatHandler
{
public:
    typedef void Print(void*, char const*);
    explicit CliHandler(void* callbackArg, Print* zprint) : m_callbackArg(callbackArg), m_print(zprint) {}

    // overwrite functions
    char const* GetAcoreString(uint32 entry) const override;
    bool isAvailable(ChatCommand const& cmd) const override;
    void SendSysMessage(const char* str) override;
    std::string GetNameLink() const override;
    bool needReportToTarget(Player* chr) const override;
    LocaleConstant GetSessionDbcLocale() const override;
    int GetSessionDbLocaleIndex() const override;

private:
    void* m_callbackArg;
    Print* m_print;
};

#endif

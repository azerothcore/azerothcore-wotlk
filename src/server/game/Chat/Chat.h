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

#include "ChatCommand.h"
#include "Player.h"
#include "SharedDefines.h"
#include "WorldSession.h"

class ChatHandler;
class Creature;
class Group;
class Player;
class Unit;
class WorldSession;
class WorldObject;

struct GameTele;

class AC_GAME_API ChatHandler
{
public:
    explicit ChatHandler(WorldSession* session) : m_session(session), sentErrorMessage(false) {}
    virtual ~ChatHandler() { }

    // Builds chat packet and returns receiver guid position in the packet to substitute in whisper builders
    static std::size_t BuildChatPacket(WorldPacket& data, ChatMsg chatType, Language language, ObjectGuid senderGUID, ObjectGuid receiverGUID, std::string_view message, uint8 chatTag,
                                  std::string const& senderName = "", std::string const& receiverName = "",
                                  uint32 achievementId = 0, bool gmMessage = false, std::string const& channelName = "");

    // Builds chat packet and returns receiver guid position in the packet to substitute in whisper builders
    static std::size_t BuildChatPacket(WorldPacket& data, ChatMsg chatType, Language language, WorldObject const* sender, WorldObject const* receiver, std::string_view message, uint32 achievementId = 0, std::string const& channelName = "", LocaleConstant locale = DEFAULT_LOCALE);

    static char* LineFromMessage(char*& pos) { char* start = strtok(pos, "\n"); pos = nullptr; return start; }

    void SendNotification(std::string_view str);
    template<typename... Args>
    void SendNotification(uint32 strId, Args&&... args)
    {
        if (HasSession())
            SendNotification(Acore::StringFormat(GetAcoreString(strId), std::forward<Args>(args)...));
    }
    template<typename... Args>
    void SendNotification(char const* fmt, Args&&... args)
    {
        if (HasSession())
            SendNotification(Acore::StringFormat(fmt, std::forward<Args>(args)...));
    }

    void SendGMText(std::string_view str);
    template<typename... Args>
    void SendGMText(uint32 strId, Args&&... args)
    {
        // GMText should be sent to all sessions
        DoForAllValidSessions([&](Player* player)
            {
                m_session = player->GetSession();
                SendGMText(Acore::StringFormat(GetAcoreString(strId), std::forward<Args>(args)...));
            });
    }
    template<typename... Args>
    void SendGMText(char const* fmt, Args&&... args)
    {
        // GMText should be sent to all sessions
        DoForAllValidSessions([&](Player* player)
            {
                m_session = player->GetSession();
                SendGMText(Acore::StringFormat(fmt, std::forward<Args>(args)...));
            });
    }

    void SendWorldText(std::string_view str);
    template<typename... Args>
    void SendWorldText(uint32 strId, Args&&... args)
    {
        // WorldText should be sent to all sessions
        DoForAllValidSessions([&](Player* player)
            {
                m_session = player->GetSession();
                SendWorldText(Acore::StringFormat(GetAcoreString(strId), std::forward<Args>(args)...));
            });
    }
    template<typename... Args>
    void SendWorldText(char const* fmt, Args&&... args)
    {
        // WorldText should be sent to all sessions
        DoForAllValidSessions([&](Player* player)
            {
                m_session = player->GetSession();
                SendWorldText(Acore::StringFormat(fmt, std::forward<Args>(args)...));
            });
    }

    void SendWorldTextOptional(std::string_view str, uint32 flag);
    template<typename... Args>
    void SendWorldTextOptional(uint32 strId, uint32 flag, Args&&... args)
    {
        // WorldTextOptional should be sent to all sessions
        DoForAllValidSessions([&](Player* player)
            {
                m_session = player->GetSession();
                SendWorldTextOptional(Acore::StringFormat(GetAcoreString(strId), std::forward<Args>(args)...), flag);
            });
    }
    template<typename... Args>
    void SendWorldTextOptional(char const* fmt, uint32 flag, Args&&... args)
    {
        // WorldTextOptional should be sent to all sessions
        DoForAllValidSessions([&](Player* player)
            {
                m_session = player->GetSession();
                SendWorldTextOptional(Acore::StringFormat(fmt, std::forward<Args>(args)...), flag);
            });
    }

    // function with different implementation for chat/console
    virtual char const* GetAcoreString(uint32 entry) const;
    virtual void SendSysMessage(std::string_view str, bool escapeCharacters = false);

    void SendSysMessage(uint32 entry);
    void PSendSysMessage(std::string_view str, bool escapeCharacters = false);

    template<typename... Args>
    void PSendSysMessage(char const* fmt, Args&&... args)
    {
        if (HasSession())
            SendSysMessage(Acore::StringFormat(fmt, std::forward<Args>(args)...));
    }

    template<typename... Args>
    void PSendSysMessage(uint32 entry, Args&&... args)
    {
        if (HasSession())
            SendSysMessage(PGetParseString(entry, std::forward<Args>(args)...));
    }

    template<typename... Args>
    std::string PGetParseString(uint32 entry, Args&&... args) const
    {
        return Acore::StringFormat(GetAcoreString(entry), std::forward<Args>(args)...);
    }

    std::string const* GetModuleString(std::string module, uint32 id) const;

    template<typename... Args>
    void PSendModuleSysMessage(std::string module, uint32 id, Args&&... args)
    {
        if (HasSession())
            SendSysMessage(PGetParseModuleString(module, id, std::forward<Args>(args)...));
    }

    template<typename... Args>
    std::string PGetParseModuleString(std::string module, uint32 id, Args&&... args) const
    {
        return Acore::StringFormat(GetModuleString(module, id)->c_str(), std::forward<Args>(args)...);
    }

    void SendErrorMessage(uint32 entry);
    void SendErrorMessage(std::string_view str, bool escapeCharacters);

    template<typename... Args>
    void SendErrorMessage(char const* fmt, Args&&... args)
    {
        PSendSysMessage(fmt, std::forward<Args>(args)...);
        SetSentErrorMessage(true);
    }

    template<typename... Args>
    void SendErrorMessage(uint32 entry, Args&&... args)
    {
        PSendSysMessage(entry, std::forward<Args>(args)...);
        SetSentErrorMessage(true);
    }

    bool _ParseCommands(std::string_view text);
    virtual bool ParseCommands(std::string_view text);

    void SendGlobalSysMessage(const char* str);

    // function with different implementation for chat/console
    virtual bool IsHumanReadable() const { return true; }
    virtual std::string GetNameLink() const { return GetNameLink(m_session->GetPlayer()); }
    virtual bool needReportToTarget(Player* chr) const;
    virtual LocaleConstant GetSessionDbcLocale() const;
    virtual int GetSessionDbLocaleIndex() const;

    bool HasLowerSecurity(Player* target, ObjectGuid guid = ObjectGuid::Empty, bool strong = false);
    bool HasLowerSecurityAccount(WorldSession* target, uint32 account, bool strong = false);

    void SendGlobalGMSysMessage(const char* str);
    Player* getSelectedPlayer() const;
    Creature* getSelectedCreature() const;
    Unit* getSelectedUnit() const;
    WorldObject* getSelectedObject() const;
    // Returns either the selected player or self if there is no selected player
    Player* getSelectedPlayerOrSelf() const;

    // Has different implementation for console
    virtual bool HasSession() const;
    // Do whatever you want to all the players with a valid session [including GameMasters], i.e.: param exec = [&](Player* p) { p->Whatever(); }
    // A "valid" session requires player->IsInWorld() to be true
    void DoForAllValidSessions(std::function<void(Player*)> exec);

    char* extractKeyFromLink(char* text, char const* linkType, char** something1 = nullptr);
    char* extractKeyFromLink(char* text, char const* const* linkTypes, int* found_idx, char** something1 = nullptr);
    char* extractQuotedArg(char* args);

    uint32    extractSpellIdFromLink(char* text);
    ObjectGuid::LowType extractLowGuidFromLink(char* text, HighGuid& guidHigh);
    bool GetPlayerGroupAndGUIDByName(const char* cname, Player*& player, Group*& group, ObjectGuid& guid, bool offline = false);
    std::string extractPlayerNameFromLink(char* text);
    // select by arg (name/link) or in-game selection online/offline player
    bool extractPlayerTarget(char* args, Player** player, ObjectGuid* player_guid = nullptr, std::string* player_name = nullptr);

    std::string playerLink(std::string const& name) const { return m_session ? "|cffffffff|Hplayer:" + name + "|h[" + name + "]|h|r" : name; }
    std::string GetNameLink(Player* chr) const;

    GameObject* GetNearbyGameObject() const;
    GameObject* GetObjectFromPlayerMapByDbGuid(ObjectGuid::LowType lowguid);
    Creature* GetCreatureFromPlayerMapByDbGuid(ObjectGuid::LowType lowguid);
    bool HasSentErrorMessage() const { return sentErrorMessage; }
    void SetSentErrorMessage(bool val) { sentErrorMessage = val; }

    bool IsConsole() const { return (m_session == nullptr); }
    Player* GetPlayer() const;
    WorldSession* GetSession() { return m_session; }
    bool IsAvailable(uint32 securityLevel) const;
protected:
    explicit ChatHandler() : m_session(nullptr), sentErrorMessage(false) {}      // for CLI subclass

private:
    WorldSession* m_session;                           // != nullptr for chat command call and nullptr for CLI command

    // common global flag
    bool sentErrorMessage;
};

class AC_GAME_API CliHandler : public ChatHandler
{
public:
    using Print = void(void*, std::string_view);
    explicit CliHandler(void* callbackArg, Print* zprint) : m_callbackArg(callbackArg), m_print(zprint) { }

    // overwrite functions
    char const* GetAcoreString(uint32 entry) const override;
    void SendSysMessage(std::string_view, bool escapeCharacters) override;
    bool ParseCommands(std::string_view str) override;
    std::string GetNameLink() const override;
    bool needReportToTarget(Player* chr) const override;
    LocaleConstant GetSessionDbcLocale() const override;
    int GetSessionDbLocaleIndex() const override;

    // CLI does not have a session, so we override it to always be true to output SendNotification and PSendSysMessage to console
    bool HasSession() const override;

private:
    void* m_callbackArg;
    Print* m_print;
};

class AC_GAME_API AddonChannelCommandHandler : public ChatHandler
{
    public:
        using ChatHandler::ChatHandler;
        bool ParseCommands(std::string_view str) override;
        void SendSysMessage(std::string_view str, bool escapeCharacters) override;
        using ChatHandler::SendSysMessage;
        bool IsHumanReadable() const override { return humanReadable; }

    private:
        void Send(std::string const& msg);
        void SendAck();
        void SendOK();
        void SendFailed();

        std::string echo;
        bool hadAck = false;
        bool humanReadable = false;
};

#endif

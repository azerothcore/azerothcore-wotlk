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

#ifndef __CHATTEXT_BUILDER_H
#define __CHATTEXT_BUILDER_H

#include "GameLocale.h"
#include "StringFormat.h"
#include <functional>

class Battleground;
class WorldObject;
class WorldPacket;
class WorldSession;

namespace Acore::Text
{
    using AcoreFmtText = std::function<std::string_view(uint8)>;

    // Get localized message
    template<typename... Args>
    inline std::string GetLocaleMessage(uint8 localeIndex, uint32 id, Args&&... args)
    {
        return StringFormatFmt(sGameLocale->GetAcoreString(id, LocaleConstant(localeIndex)), std::forward<Args>(args)...);
    }

    // Helper fmt functions
    void SendWorldTextFmt(AcoreFmtText const& msg);
    void SendWorldTextOptionalFmt(AcoreFmtText const& msg, uint32 flag);
    void SendGMTextFmt(AcoreFmtText const& msg);
    void SendNotificationFmt(AcoreFmtText const& msg, WorldSession* session);
    void SendAreaTriggerMessageFmt(AcoreFmtText const& msg, WorldSession* session);
    void SendBattlegroundWarningToAllFmt(Battleground* bg, AcoreFmtText const& msg);
    void SendBattlegroundMessageToAllFmt(Battleground* bg, ChatMsg type, AcoreFmtText const& msg);

    // Helper default functions
    void SendNotification(WorldSession* session, std::string_view text);
    void SendNotification(WorldSession* session, uint32 stringID);
    void SendAreaTriggerMessage(WorldSession* session, std::string_view text);
    void SendAreaTriggerMessage(WorldSession* session, uint32 stringID);

    // Send a System Message to all players (except self if mentioned)
    template<typename... Args>
    inline void SendWorldText(uint32 id, Args&&... args)
    {
        SendWorldTextFmt([&](uint8 localeIndex)
        {
            return GetLocaleMessage(localeIndex, id, std::forward<Args>(args)...);
        });
    }

    // Send a optional System Message to all players (except self if mentioned)
    template<typename... Args>
    inline void SendWorldTextOptional(uint32 id, uint32 flag, Args&&... args)
    {
        SendWorldTextOptionalFmt([&](uint8 localeIndex)
        {
            return GetLocaleMessage(localeIndex, id, std::forward<Args>(args)...);
        }, flag);
    }

    // Send a System Message to all GMs (except self if mentioned)
    template<typename... Args>
    inline void SendGMText(uint32 id, Args&&... args)
    {
        SendGMTextFmt([&](uint8 localeIndex)
        {
            return GetLocaleMessage(localeIndex, id, std::forward<Args>(args)...);
        });
    }

    // Send a Battleground warning message to all players
    template<typename... Args>
    inline void SendBattlegroundWarningToAll(Battleground* bg, uint32 id, Args&&... args)
    {
        SendBattlegroundWarningToAllFmt(bg, [&](uint8 localeIndex)
        {
            return GetLocaleMessage(localeIndex, id, std::forward<Args>(args)...);
        });
    }

    // Send a Battleground with type message to all players
    template<typename... Args>
    inline void SendBattlegroundMessageToAll(Battleground* bg, ChatMsg type, uint32 id, Args&&... args)
    {
        SendBattlegroundMessageToAllFmt(bg, type, [&](uint8 localeIndex)
        {
            return GetLocaleMessage(localeIndex, id, std::forward<Args>(args)...);
        });
    }

    template<typename... Args>
    inline void SendNotification(WorldSession* session, std::string_view fmt, Args&&... args)
    {
        SendNotification(session, StringFormatFmt(fmt, std::forward<Args>(args)...));
    }

    template<typename... Args>
    inline void SendNotification(WorldSession* session, uint32 stringID, Args&&... args)
    {
        SendNotificationFmt([&](uint8 localeIndex)
        {
            return GetLocaleMessage(localeIndex, stringID, std::forward<Args>(args)...);
        }, session);
    }

    template<typename... Args>
    inline void SendAreaTriggerMessage(WorldSession* session, std::string_view fmt, Args&&... args)
    {
        SendAreaTriggerMessage(session, StringFormatFmt(fmt, std::forward<Args>(args)...));
    }

    template<typename... Args>
    inline void SendAreaTriggerMessage(WorldSession* session, uint32 stringID, Args&&... args)
    {
        SendAreaTriggerMessageFmt([&](uint8 localeIndex)
        {
            return GetLocaleMessage(localeIndex, stringID, std::forward<Args>(args)...);
        }, session);
    }
}

namespace Acore
{
    class BroadcastTextBuilder
    {
    public:
        BroadcastTextBuilder(WorldObject const* obj, ChatMsg msgType, uint32 textId, uint8 gender, WorldObject const* target = nullptr, uint32 achievementId = 0)
            : _source(obj), _msgType(msgType), _textId(textId), _gender(gender), _target(target), _achievementId(achievementId) { }

        void operator()(WorldPacket& data, LocaleConstant locale) const;
        size_t operator()(WorldPacket* data, LocaleConstant locale) const;

    private:
        WorldObject const* _source;
        ChatMsg _msgType;
        uint32 _textId;
        uint8 _gender;
        WorldObject const* _target;
        uint32 _achievementId;
    };

    class CustomChatTextBuilder
    {
    public:
        CustomChatTextBuilder(WorldObject const* obj, ChatMsg msgType, std::string_view text, Language language = LANG_UNIVERSAL, WorldObject const* target = nullptr)
            : _source(obj), _msgType(msgType), _text(text), _language(language), _target(target) { }

        void operator()(WorldPacket& data, LocaleConstant locale) const;

    private:
        WorldObject const* _source;
        ChatMsg _msgType;
        std::string _text;
        Language _language;
        WorldObject const* _target;
    };
}

#endif // __CHATTEXT_BUILDER_H

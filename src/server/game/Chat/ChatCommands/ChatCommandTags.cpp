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

#include "ChatCommandTags.h"
#include "AccountMgr.h"
#include "Chat.h"
#include "ChatCommandArgs.h"
#include "ObjectAccessor.h"
#include "ObjectMgr.h"
#include "Player.h"

using namespace Acore::Impl::ChatCommands;

ChatCommandResult Acore::ChatCommands::QuotedString::TryConsume(ChatHandler const* handler, std::string_view args)
{
    if (args.empty())
        return std::nullopt;

    if ((args[0] != '"') && (args[0] != '\''))
        return ArgInfo<std::string>::TryConsume(*this, handler, args);

    char const QUOTE = args[0];
    for (size_t i = 1; i < args.length(); ++i)
    {
        if (args[i] == QUOTE)
        {
            auto [remainingToken, tail] = tokenize(args.substr(i + 1));
            if (remainingToken.empty()) // if this is not empty, then we did not consume the full token
                return tail;
            else
                return std::nullopt;
        }

        if (args[i] == '\\')
        {
            ++i;
            if (!(i < args.length()))
                break;
        }
        std::string::push_back(args[i]);
    }

    // if we reach this, we did not find a closing quote
    return std::nullopt;
}

ChatCommandResult Acore::ChatCommands::AccountIdentifier::TryConsume(ChatHandler const* handler, std::string_view args)
{
    std::string_view text;
    ChatCommandResult next = ArgInfo<std::string_view>::TryConsume(text, handler, args);
    if (!next)
        return next;

    // first try parsing as account name
    _name.assign(text);
    if (!Utf8ToUpperOnlyLatin(_name))
        return GetAcoreString(handler, LANG_CMDPARSER_INVALID_UTF8);

    _id = AccountMgr::GetId(_name);
    if (_id) // account with name exists, we are done
        return next;

    // try parsing as account id instead
    Optional<uint32> id = Acore::StringTo<uint32>(text, 10);
    if (!id)
        return FormatAcoreString(handler, LANG_CMDPARSER_ACCOUNT_NAME_NO_EXIST, _name);

    _id = *id;

    if (AccountMgr::GetName(_id, _name))
        return next;
    else
        return FormatAcoreString(handler, LANG_CMDPARSER_ACCOUNT_ID_NO_EXIST, _id);
}

ChatCommandResult Acore::ChatCommands::PlayerIdentifier::TryConsume(ChatHandler const* handler, std::string_view args)
{
    Variant<Hyperlink<player>, ObjectGuid::LowType, std::string_view> val;
    ChatCommandResult next = ArgInfo<decltype(val)>::TryConsume(val, handler, args);
    if (!next)
        return next;

    if (val.holds_alternative<ObjectGuid::LowType>())
    {
        _guid = ObjectGuid::Create<HighGuid::Player>(val.get<ObjectGuid::LowType>());

        if ((_player = ObjectAccessor::FindPlayerByLowGUID(_guid.GetCounter())))
        {
            _name = _player->GetName();
        }
        else if (!sCharacterCache->GetCharacterNameByGuid(_guid, _name))
        {
            return FormatAcoreString(handler, LANG_CMDPARSER_CHAR_GUID_NO_EXIST, _guid.ToString());
        }

        return next;
    }
    else
    {
        if (val.holds_alternative<Hyperlink<player>>())
            _name.assign(static_cast<std::string_view>(val.get<Hyperlink<player>>()));
        else
            _name.assign(val.get<std::string_view>());

        if (!normalizePlayerName(_name))
            return FormatAcoreString(handler, LANG_CMDPARSER_CHAR_NAME_INVALID, _name);

        if ((_player = ObjectAccessor::FindPlayerByName(_name)))
        {
            _guid = _player->GetGUID();
        }
        else if (!(_guid = sCharacterCache->GetCharacterGuidByName(_name)))
        {
            return FormatAcoreString(handler, LANG_CMDPARSER_CHAR_NAME_NO_EXIST, _name);
        }

        return next;
    }
}

Acore::ChatCommands::PlayerIdentifier::PlayerIdentifier(Player& player)
    : _name(player.GetName()), _guid(player.GetGUID()), _player(&player) {}

/*static*/ Optional<Acore::ChatCommands::PlayerIdentifier> Acore::ChatCommands::PlayerIdentifier::FromTarget(ChatHandler* handler)
{
    if (Player* player = handler->GetPlayer())
        if (Player* target = player->GetSelectedPlayer())
            return { *target };

    return std::nullopt;
}

/*static*/ Optional<Acore::ChatCommands::PlayerIdentifier> Acore::ChatCommands::PlayerIdentifier::FromSelf(ChatHandler* handler)
{
    if (Player* player = handler->GetPlayer())
        return { *player };

    return std::nullopt;
}

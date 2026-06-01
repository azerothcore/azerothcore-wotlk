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

#include "Chat.h"
#include "CommandScript.h"
#include "DatabaseEnv.h"
#include "ObjectMgr.h"

using namespace Acore::ChatCommands;

class chatfilter_commandscript : public CommandScript
{
public:
    chatfilter_commandscript() : CommandScript("chatfilter_commandscript") { }

    ChatCommandTable GetCommands() const override
    {
        static ChatCommandTable chatfilterCommandTable =
        {
            { "list",   HandleChatFilterListCommand,   rbac::RBAC_PERM_COMMAND_CHATFILTER_LIST,   Console::Yes },
            { "add",    HandleChatFilterAddCommand,    rbac::RBAC_PERM_COMMAND_CHATFILTER_ADD,    Console::Yes },
            { "remove", HandleChatFilterRemoveCommand, rbac::RBAC_PERM_COMMAND_CHATFILTER_REMOVE, Console::Yes }
        };

        static ChatCommandTable commandTable =
        {
            { "chatfilter", chatfilterCommandTable }
        };

        return commandTable;
    }

    static bool HandleChatFilterListCommand(ChatHandler* handler)
    {
        CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_CHAT_FILTER);
        PreparedQueryResult result = CharacterDatabase.Query(stmt);

        if (!result)
        {
            handler->SendSysMessage("No chat filter words found.");
            return true;
        }

        handler->SendSysMessage("Chat filter words:");
        uint32 count = 0;
        do
        {
            Field* fields = result->Fetch();
            uint32 id = fields[0].Get<uint32>();
            std::string word = fields[1].Get<std::string>();
            handler->PSendSysMessage("  ID: {} | Word: {}", id, word);
            ++count;
        } while (result->NextRow());

        handler->PSendSysMessage("{} chat filter word(s) total.", count);
        return true;
    }

    static bool HandleChatFilterAddCommand(ChatHandler* handler, Tail word)
    {
        if (word.empty())
            return false;

        std::string text(word);

        CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_CHAT_FILTER_WORD);
        stmt->SetData(0, text);
        if (CharacterDatabase.Query(stmt))
        {
            handler->SendErrorMessage("Chat filter word \"{}\" already exists.", text);
            return true;
        }

        stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_CHAT_FILTER_WORD);
        stmt->SetData(0, text);
        CharacterDatabase.DirectExecute(stmt);

        sObjectMgr->LoadChatFilter();

        handler->PSendSysMessage("Chat filter word \"{}\" added.", text);
        return true;
    }

    static bool HandleChatFilterRemoveCommand(ChatHandler* handler, Tail word)
    {
        if (word.empty())
            return false;

        std::string text(word);

        CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_CHAT_FILTER_WORD);
        stmt->SetData(0, text);
        if (!CharacterDatabase.Query(stmt))
        {
            handler->SendErrorMessage("Chat filter word \"{}\" not found.", text);
            return true;
        }

        stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_CHAT_FILTER_WORD);
        stmt->SetData(0, text);
        CharacterDatabase.DirectExecute(stmt);

        sObjectMgr->LoadChatFilter();

        handler->PSendSysMessage("Chat filter word \"{}\" removed.", text);
        return true;
    }
};

void AddSC_chatfilter_commandscript()
{
    new chatfilter_commandscript();
}

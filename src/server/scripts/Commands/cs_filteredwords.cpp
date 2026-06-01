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

class filteredwords_commandscript : public CommandScript
{
public:
    filteredwords_commandscript() : CommandScript("filteredwords_commandscript") { }

    ChatCommandTable GetCommands() const override
    {
        static ChatCommandTable filteredwordsCommandTable =
        {
            { "list",   HandleFilteredWordsListCommand,   rbac::RBAC_PERM_COMMAND_FILTEREDWORDS_LIST,    Console::Yes },
            { "add",    HandleFilteredWordsAddCommand,    rbac::RBAC_PERM_COMMAND_FILTEREDWORDS_ADD, Console::Yes },
            { "remove", HandleFilteredWordsRemoveCommand, rbac::RBAC_PERM_COMMAND_FILTEREDWORDS_REMOVE, Console::Yes }
        };

        static ChatCommandTable commandTable =
        {
            { "filteredwords", filteredwordsCommandTable }
        };

        return commandTable;
    }

    static bool HandleFilteredWordsListCommand(ChatHandler* handler)
    {
        CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_FILTERED_WORDS);
        PreparedQueryResult result = CharacterDatabase.Query(stmt);

        if (!result)
        {
            handler->SendSysMessage("No filtered words found.");
            return true;
        }

        handler->SendSysMessage("Filtered words:");
        uint32 count = 0;
        do
        {
            Field* fields = result->Fetch();
            uint32 id = fields[0].Get<uint32>();
            std::string word = fields[1].Get<std::string>();
            handler->PSendSysMessage("  ID: {} | Word: {}", id, word);
            ++count;
        } while (result->NextRow());

        handler->PSendSysMessage("{} filtered word(s) total.", count);
        return true;
    }

    static bool HandleFilteredWordsAddCommand(ChatHandler* handler, Tail word)
    {
        if (word.empty())
            return false;

        std::string text(word);

        CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_FILTERED_WORD);
        stmt->SetData(0, text);
        if (CharacterDatabase.Query(stmt))
        {
            handler->SendErrorMessage("Filtered word \"{}\" already exists.", text);
            return true;
        }

        stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_FILTERED_WORD);
        stmt->SetData(0, text);
        CharacterDatabase.DirectExecute(stmt);

        sObjectMgr->LoadFilteredWords();

        handler->PSendSysMessage("Filtered word \"{}\" added.", text);
        return true;
    }

    static bool HandleFilteredWordsRemoveCommand(ChatHandler* handler, Tail word)
    {
        if (word.empty())
            return false;

        std::string text(word);

        CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_FILTERED_WORD);
        stmt->SetData(0, text);
        if (!CharacterDatabase.Query(stmt))
        {
            handler->SendErrorMessage("Filtered word \"{}\" not found.", text);
            return true;
        }

        stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_FILTERED_WORD);
        stmt->SetData(0, text);
        CharacterDatabase.DirectExecute(stmt);

        sObjectMgr->LoadFilteredWords();

        handler->PSendSysMessage("Filtered word \"{}\" removed.", text);
        return true;
    }
};

void AddSC_filteredwords_commandscript()
{
    new filteredwords_commandscript();
}
